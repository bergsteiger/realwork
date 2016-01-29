unit RILogger;

interface

uses pi, pi_int, orbtypes, code_int;

const
  REQUEST_CONTEXT_ID: ServiceId = 100;
  REPLY_CONTEXT_ID: ServiceId = 101;

type
  {TRILogger = class()
  end;}

  TRIORBInitializerImpl = class(TORBInitializer)
  protected
    procedure pre_init(const info: IORBInitInfo); override;
    procedure post_init(const info: IORBInitInfo); override;
  public
    class procedure Init;
  end;

  TCORBAOut = class
  public
    class procedure ShowAny(const a: IAny);
    class procedure DisplayAny(const a: IAny);
    class procedure DisplayIDLTypeCode(const tc: ITypeCode);
    class procedure ShowAnyWithoutType(const a: IAny);
    class procedure ShowNameTypeCode(const tc: ITypeCode);
  end;

procedure DisplayRequestInfo(const info: IRequestInfo; logLevel: short; ASlotId: TSlotId);
procedure Down();
procedure Up();
procedure Skip();
function GetOctet(o: octet): string;

implementation

uses SysUtils, PIImpl, SRILoggerImpl, CRILoggerImpl, LoggerPolicy_int, pi_impl,
  exceptions, orb_int;

const
  NameTypeIDL: array [TCKind] of string = (
    'null', 'void',
    'short', 'long',
    'unsigned short', 'unsigned long',
    'float', 'double',
    'boolean',
    'char',
    'octet',
    'any',
    'TypeCode',
    'Principal',
    'objref',
    'struct', 'union',
    'enum',
    'string',
    'sequence', 'array',
    'alias',
    'exception',
    'long long', 'unsigned long long',
    'long double',
    'wchar', 'wstring',
    'fixed',
    'value', 'valuebox',
    'native',
    'abstract_interface'
  );

var
  level: Integer = 0;

procedure Down();
begin
  Inc(level);
end;

procedure Up();
begin
  Dec(level);
end;

procedure Skip();
var
  i: Integer;
begin
  for i := 0 to level do
    Write('   ');
end;

function GetOctet(o: octet): string;
begin
end;

procedure DisplayRequestInfo(const info: IRequestInfo; logLevel: short; ASlotId: TSlotId);
var
  i: Integer;
  args: TParameterList;
  excepts: TExceptionList;
  response_expected: Boolean;
  status: TReplyStatus;
  context: ServiceContext;
  res: IAny;
begin
  args := nil;
  excepts := nil;
  //
  // Display request id
  //
  Skip();
  WriteLn('request id = ', info.request_id);

  //
  // Display operation
  //
  Skip();
  WriteLn('operation = ', info.operation);

  //
  // Display arguments
  //
  try
      args := info.arguments;

      Skip();
      Write('arguments = ');
      if Length(args) = 0 then
        Write('(no arguments)')
      else begin
          Down();
          for i := 0 to Length(args) - 1 do begin
              WriteLn;
              case args[i].mode of
                PARAM_IN: begin
                  Skip();
                  Write('in ');
                end;
                PARAM_OUT: begin
                  Skip();
                  Write('out ');
                end;
              else begin
                  Skip();
                  Write('inout ');
              end;
              end;
              TCORBAOut.ShowAny(args[i].argument);
          end;
          Up();
      end;
      WriteLn;
  except
    on E: BAD_INV_ORDER do ;
      // Operation not supported in this context
    on E: NO_RESOURCES do ;
      // Operation not supported in this environment
  end;

  //
  // Display exceptions
  //
  try
      excepts := info.exceptions;

      Skip();
      Write('exceptions = ');
      if Length(excepts) = 0 then
          WriteLn('(no exceptions)')
      else begin
          WriteLn;
          Down();
          for i := 0 to  Length(excepts) - 1 do
              TCORBAOut.DisplayIDLTypeCode(excepts[i]);
          Up();
      end;
  except
    on E: BAD_INV_ORDER do ;
      // Operation not supported in this context
    on E: NO_RESOURCES do ;
      // Operation not supported in this environment
  end;
    
  //
  // Display result
  //
  try
    res := info._result;
    Skip();
    Write('result = ');
    TCORBAOut.ShowAny(res);
    WriteLn;
  except
    on E: BAD_INV_ORDER do ;
      // Operation not supported in this context
    on E: NO_RESOURCES do ;
      // Operation not supported in this environment
  end;

  //
  // Display response expected
  //
  response_expected := info.response_expected;

  Skip();
  Write('response expected = ');
  if response_expected then
    Write('true')
  else
    Write('false');
  WriteLn;

  //
  // Display reply status
  //
  try
      status := info.reply_status;

      Skip();
      Write('reply status = ');
      case status of
        pi_int.SUCCESSFUL: Write('SUCCESSFUL');
        pi_int.SYSTEM_EXCEPTION: Write('SYSTEM_EXCEPTION');
        pi_int.USER_EXCEPTION: Write('USER_EXCEPTION');
        pi_int.LOCATION_FORWARD: Write('LOCATION_FORWARD');
        pi_int.LOCATION_FORWARD_PERMANENT: Write('LOCATION_FORWARD_PERMANENT');
        pi_int.TRANSPORT_RETRY: Write('TRANSPORT_RETRY');
      else
        Write('UNKNOWN_REPLY_STATUS');
      end;
      WriteLn;
  except
    on E: BAD_INV_ORDER do ;
      // Operation not supported in this context
  end;

  if logLevel > 1 then begin
      //
      // Display slot data
      //
      try
          Skip();
          WriteLn('slot data ', ASlotId, ' = ');
          Down();
          TCORBAOut.DisplayAny(info.get_slot(ASlotId));
          Up();
      except
        on E: TInvalidSlot do ;
      end;

      //
      // Display request service context
      //
      try
          context := info.get_request_service_context(REQUEST_CONTEXT_ID);

          Skip();
          Write('request service context ', REQUEST_CONTEXT_ID, ' = ');

          for i := 0 to Length(context.context_data) - 1 do
              Write(GetOctet(context.context_data[i]));
          WriteLn;
      except
        on E: BAD_INV_ORDER do ;
          // Operation not supported in this context
        on E: BAD_PARAM do ;
          // No entry found
      end;

      //
      // Display reply service context
      //
      try
          context := info.get_reply_service_context(REPLY_CONTEXT_ID);

          Skip();
          Write('reply service context ', REPLY_CONTEXT_ID, ' = ');

          for i := 0 to Length(context.context_data) - 1 do
              Write(GetOctet(context.context_data[i]));
          WriteLn;
      except
        on E: BAD_INV_ORDER do ;
          // Operation not supported in this context
        on E: BAD_PARAM do ;
          // No entry found
      end;
  end;
end;

{ TRIORBInitializerImpl }

// Note: the interceptors are registered in post_init()
//       because the TCRILoggerImpl and TSRILoggerImpl
//       constructors require
//       ORBInitInfo::resolve_initial_reference(), which
//       cannot be called in pre_init().
class procedure TRIORBInitializerImpl.Init;
begin
  //
  // Register the ORB initializer
  //
  TPIManager.RegisterOrbInitializer(TRIORBInitializerImpl.Create());
end;

procedure TRIORBInitializerImpl.post_init(const info: IORBInitInfo);
var
  slotId: TSlotId;
begin
  //
  // Register the policy factory
  //
  info.register_policy_factory(LOGGER_POLICY_ID, TLoggerPolicyFactory.Create());

  //
  // Allocate state slot for call stack tracing
  //
  slotId := info.allocate_slot_id();

  //
  // Create the interceptors
  //
  //
  // Register the interceptors
  //
  try
    info.add_client_request_interceptor(TCRILoggerImpl.Create(info, slotId));
    info.add_server_request_interceptor(TSRILoggerImpl.Create(info, slotId));
  except
    on E: TDuplicateName do
      Assert(false);
  end;
end;

procedure TRIORBInitializerImpl.pre_init(const info: IORBInitInfo);
begin

end;

{ TCORBAOut }

class procedure TCORBAOut.DisplayAny(const a: IAny);
begin
  Skip();
  ShowAny(a);
  WriteLn;
end;

class procedure TCORBAOut.DisplayIDLTypeCode(const tc: ITypeCode);
var
  kind: TCKind;
  i: Integer;
  member_type: ITypeCode;
begin
  kind := tc.kind;
  case kind of
    tk_objref: begin
      Skip();
      Write('interface ', tc.name(), ';');
    end;
    tk_struct, tk_except: begin
        Skip();
        WriteLn(NameTypeIDL[kind], ' ', tc.name(), ' {');

        Down();
        for i := 0 to tc.member_count() - 1 do begin
            Skip();
            member_type := tc.member_type(i);
            ShowNameTypeCode(member_type);
            WriteLn(' ', tc.member_name(i), ';');
        end;
        Up();
        Skip();
        Write('};');
    end;
  end;
  WriteLn;
end;

class procedure TCORBAOut.ShowAny(const a: IAny);
begin
  ShowNameTypeCode(a.__tc);
  Write('(');
  ShowAnyWithoutType(a);
  Write(')');
end;

class procedure TCORBAOut.ShowAnyWithoutType(const a: IAny);
var
  //i: _ulong;
  tc: ITypeCode;
  kind: TCKind;
  v_short: short;
  v_long: long;
  v_ushort: _ushort;
  v_ulong: _ulong;
  v_float: float;
  v_double: double;
  v_boolean: Boolean;
  v_char: AnsiChar;
  v_octet: octet;
  v_any: IAny;
  v_tc: ITypeCode;
  v_obj: IInterface;
  v_string: AnsiString;
  v_longlong: longlong;
  v_ulonglong: _ulonglong;
  v_wchar: WideChar;
  v_wstring: WideString;

  // Get original type, i.e. remove aliases
  function GetOrigType(const ATC: ITypeCode): ITypeCode;
  begin
    result := ATC;
    while result.kind = tk_alias do
      result := result.content_type;
  end;

begin
  a.rewind;

    tc := a.__tc();
    tc := GetOrigType(tc);

    kind := tc.kind();

    case kind of
      tk_null, tk_void: ;
      tk_short: begin
        a.to_short(v_short);
        Write(v_short);
      end;
      tk_long: begin
        a.to_long(v_long);
        Write(v_long);
      end;
      tk_ushort: begin
        a.to_ushort(v_ushort);
        Write(v_ushort);
      end;
      tk_ulong: begin
        a.to_ulong(v_ulong);
        Write(v_ulong);
      end;
      tk_float: begin
        a.to_float(v_float);
        Write(v_float);
      end;
      tk_double: begin
        a.to_double(v_double);
        Write(v_double);
      end;
      tk_boolean: begin
        a.to_boolean(v_boolean);
        if v_boolean then
	  Write('TRUE')
        else
	  Write('FALSE');
      end;
      tk_char: begin
        a.to_char(v_char);
        Write('''(char)'', v_char, ''');
      end;
      tk_octet: begin
        a.to_octet(v_octet);
        Write(v_octet);
      end;
      tk_any: begin
        a.to_any(v_any);
        ShowAny(v_any);
      end;
      tk_TypeCode: begin
        a.to_typecode(v_tc);
        ShowNameTypeCode(v_tc);
      end;
      tk_Principal: Write('<Principal>');
      tk_objref: begin
        Write(tc.id());
        a.to_object(v_obj);
        if v_obj = nil then
          Write('<NULL>');
      end;
      tk_struct: begin
        (*DynStruct_var dyn_struct =
	    DynStruct::_narrow(dyn_any);

        ostr_ << OB_ENDL;
        down();

        ULong member_count = tc -> member_count();
        for(i = 0 ; i < member_count ; i++)
	{
            String_var member_name = dyn_struct -> current_member_name();
            skip() << member_name << " = ";
            DynAny_var component = dyn_struct -> current_component();
            show_DynAny(component);
            ostr_ << OB_ENDL;
            dyn_struct -> next();
        }

        up();
        skip();*)
      end;
      tk_union: begin
        (*DynUnion_var dyn_union = DynUnion::_narrow(dyn_any);

        ostr_ << OB_ENDL;
        down();

        DynAny_var component = dyn_union -> current_component();

        skip() << "discriminator = ";
        show_DynAny(component);
        ostr_ << OB_ENDL;

        if(dyn_union -> component_count() == 2)
        {
            dyn_union -> next();

            component = dyn_union -> current_component();

            String_var member_name = dyn_union -> member_name();
            skip() << member_name << " = ";
            show_DynAny(component);

            ostr_ << OB_ENDL;
        }

        up();
        skip();*)
      end;
      tk_enum: begin
         (*DynEnum_var dyn_enum = DynEnum::_narrow(dyn_any);
         String_var v_string = dyn_enum -> get_as_string();
         ostr_ << v_string;*)
      end;
      tk_string: begin
        a.to_string(v_string);
        Write('"', v_string, '"');
      end;
      tk_sequence: begin
        (*DynSequence_var dyn_sequence = DynSequence::_narrow(dyn_any);
        for(i = 0 ; i < dyn_sequence -> get_length() ; i++)
	{
            if(i != 0) ostr_ << ", ";
            DynAny_var component = dyn_sequence -> current_component();
            show_DynAny(component);
            dyn_sequence -> next();
	}*)
      end;
      tk_array: begin
        (*DynArray_var dyn_array = DynArray::_narrow(dyn_any);
        for(i = 0 ; i < tc -> length() ; i++)
	{
            if(i != 0) ostr_ << ", ";
            DynAny_var component = dyn_array -> current_component();
	    show_DynAny(component);
	    dyn_array -> next();
	}*)
      end;
      tk_alias: Write('<alias>');
      tk_except: Write('<except>');
      tk_longlong: begin
        a.to_longlong(v_longlong);
        Write(v_longlong);
      end;
      tk_ulonglong: begin
        a.to_ulonglong(v_ulonglong);
        Write(v_ulonglong);
      end;
(*#if SIZEOF_LONG_DOUBLE >= 12
    case tk_longdouble:
    {
        LongDouble v_longdouble = dyn_any -> get_longdouble();
        //
        // Not all platforms support this
        //
        //ostr_ << v_longdouble;
        char str[25];
        sprintf(str, "%31Lg", v_longdouble);
        ostr_ << str;

	break;
    }
#endif*)
      tk_wchar: begin
        a.to_wchar(v_wchar);
        Write('"', v_wchar, '"');
      end;
      tk_wstring: begin
        a.to_wstring(v_wstring);
        Write('"', v_wstring, '"');
      end;
      tk_fixed: begin
	(*DynFixed_var dyn_fixed = DynFixed::_narrow(dyn_any);

	ostr_ << OB_ENDL;
	down();

	// XXX
        String_var str = dyn_fixed -> get_value();
        skip() << str;

	ostr_ << OB_ENDL;

        up();
        skip();*)
      end;
      tk_value: Write('<value>');
      tk_value_box: Write('<value_box>');
      tk_native: Write('<native>');
      tk_abstract_interface: Write('<abstract_interface>');
      else
        Write('Unknown DynAny: ', Integer(kind));
    end;
    a.rewind;
end;

class procedure TCORBAOut.ShowNameTypeCode(const tc: ITypeCode);
var
  kind: TCKind;
  len: _ulong;
  content_type: ITypeCode;
begin
  kind := tc.kind();
  case kind of
    tk_objref,
    tk_enum,
    tk_union,
    tk_struct,
    tk_except,
    tk_alias: Write(tc.name());
    tk_string: begin
      Write('string');
      len := tc._length();
      if (len <> 0) then
        Write('<', len, '>');
    end;
    tk_sequence: begin
      Write('sequence<');
      content_type := tc.content_type();
      ShowNameTypeCode(content_type);
      len := tc._length();
      if (len <> 0) then
        Write(', ', len, '>');
    end;
    tk_array: begin
      content_type := tc.content_type();
      ShowNameTypeCode(content_type);
      Write('[', tc._length(), ']');
    end;
    else
      Write(NameTypeIDL[kind]);
  end;
end;

end.
