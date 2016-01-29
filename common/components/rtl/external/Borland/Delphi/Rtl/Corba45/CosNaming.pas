{************************************************************}
{                                                            }
{       Borland VisiBroker for Delphi Naming Service         }
{                                                            }
{   Copyright (C) 2000 - 2001 Borland Software Corporation   }
{                                                            }
{************************************************************}

unit
  CosNaming;

interface

uses
  Corba;

type
  NameComponent = interface;
  Binding = interface;
  BindingIterator = interface;
  NamingContext = interface;
  NamingContextExt = interface;

  BindingType = (NObject, NContext);
  NamingContext_NotFoundReason = (Missing_Node, Not_Context, Not_Object);
  Istring = AnsiString;

  Name = array of NameComponent;

  BindingList = array of Binding;

  NamingContextExt_StringName = AnsiString;
  NamingContextExt_Address = AnsiString;
  NamingContextExt_URLString = AnsiString;

  NameComponent = interface
    ['{1F97A052-327B-946B-DDC7-8546E892923D}']
    function  _get_id : Istring;
    procedure _set_id (const id : Istring);
    function  _get_kind : Istring;
    procedure _set_kind (const kind : Istring);
    property  id : Istring read _get_id write _set_id;
    property  kind : Istring read _get_kind write _set_kind;
  end;

  Binding = interface
    ['{D5179672-5716-C953-DE66-A7EB2E831A5C}']
    function  _get_binding_name : Name;
    procedure _set_binding_name (const binding_name : Name);
    function  _get_binding_type : BindingType;
    procedure _set_binding_type (const binding_type : BindingType);
    property  binding_name : Name read _get_binding_name write _set_binding_name;
    property  binding_type : BindingType read _get_binding_type write _set_binding_type;
  end;

  BindingIterator = interface
    ['{D33A454D-62FB-2BF8-7C70-AB76C61BD0AE}']
    function  next_one (out b : Binding): Boolean;
    function  next_n (const how_many : Cardinal; out b : BindingList): Boolean;
    procedure _destroy;
  end;

  NamingContext = interface
    ['{7DFA1D2B-16FD-AFBF-C509-0FFF155A2060}']
    procedure bind (const n : Name; const obj : CORBAObject);
    procedure rebind (const n : Name; const obj : CORBAObject);
    procedure bind_context (const n : Name; const nc : NamingContext);
    procedure rebind_context (const n : Name; const nc : NamingContext);
    function  resolve (const n : Name): CORBAObject;
    procedure unbind (const n : Name);
    function  new_context : NamingContext;
    function  bind_new_context (const n : Name): NamingContext;
    procedure _destroy;
    procedure list (const how_many : Cardinal; out bl : BindingList;
      out bi : BindingIterator);
  end;

  NamingContextExt = interface (NamingContext)
    ['{FA41078E-DA19-0D9F-D34A-F5E550D735A2}']
    function to_string (const n : Name): NamingContextExt_StringName;
    function to_name (const sn : NamingContextExt_StringName): Name;
    function to_url (const addr : NamingContextExt_Address;
      const sn : NamingContextExt_StringName): NamingContextExt_URLString;
    function resolve_str (const n : NamingContextExt_StringName): CORBAObject;
  end;

  TIstringHelper = class;
  TNameComponentHelper = class;
  TNameComponent = class;
  TNameHelper = class;
  TBindingTypeHelper = class;
  TBindingHelper = class;
  TBinding = class;
  TBindingListHelper = class;
  TBindingIteratorHelper = class;
  TBindingIteratorStub = class;
  TNamingContextHelper = class;
  TNamingContextStub = class;
  TNamingContext_NotFoundReasonHelper = class;
  ENamingContext_NotFound = class;
  ENamingContext_CannotProceed = class;
  ENamingContext_InvalidName = class;
  ENamingContext_AlreadyBound = class;
  ENamingContext_NotEmpty = class;
  TNamingContextExtHelper = class;
  TNamingContextExtStub = class;
  TNamingContextExt_StringNameHelper = class;
  TNamingContextExt_AddressHelper = class;
  TNamingContextExt_URLStringHelper = class;
  ENamingContextExt_InvalidAddress = class;

  TIstringHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : Istring);
    class function  Extract(const _A: CORBA.Any): Istring;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : Istring;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : Istring);
  end;

  TNameComponentHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : NameComponent);
    class function  Extract(const _A: CORBA.Any): NameComponent;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : NameComponent;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : NameComponent);
  end;

  TNameComponent = class (TInterfacedObject, NameComponent)
  private
    id : Istring;
    kind : Istring;
    constructor Create; overload;
  public
    function  _get_id : Istring; virtual;
    procedure _set_id (const _value : Istring ); virtual;
    function  _get_kind : Istring; virtual;
    procedure _set_kind (const _value : Istring ); virtual;
    constructor Create (const id : Istring; const kind : Istring); overload;
  end;

  TNameHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : Name);
    class function  Extract(const _A: CORBA.Any): Name;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : Name;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : Name);
  end;

  TBindingTypeHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : BindingType);
    class function  Extract(const _A: CORBA.Any): BindingType;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : BindingType;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : BindingType);
  end;

  TBindingHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : Binding);
    class function  Extract(const _A: CORBA.Any): Binding;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : Binding;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : Binding);
  end;

  TBinding = class (TInterfacedObject, Binding)
  private
    binding_name : Name;
    binding_type : BindingType;
    constructor Create; overload;
  public
    function  _get_binding_name : Name; virtual;
    procedure _set_binding_name (const _value : Name ); virtual;
    function  _get_binding_type : BindingType; virtual;
    procedure _set_binding_type (const _value : BindingType ); virtual;
    constructor Create (const binding_name : Name; const binding_type : BindingType); overload;
  end;

  TBindingListHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : BindingList);
    class function  Extract(const _A: CORBA.Any): BindingList;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : BindingList;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : BindingList);
  end;

  TBindingIteratorHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : BindingIterator);
    class function  Extract(var _A: CORBA.Any) : BindingIterator;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId : string;
    class function  Read (const _Input  : CORBA.InputStream) : BindingIterator;
    class procedure Write(const _Output : CORBA.OutputStream;
      const _Value : BindingIterator);
    class function  Narrow(const _Obj   : CORBA.CORBAObject;
      _IsA : Boolean = False) : BindingIterator;
    class function  Bind(const _InstanceName : string = '';
      _HostName : string = '') : BindingIterator; overload;
    class function  Bind(_Options : BindOptions;
      const _InstanceName : string = '';
      _HostName: string = '') : BindingIterator; overload;
  end;

  TBindingIteratorStub = class(CORBA.TCORBAObject, BindingIterator)
  public
    function  next_one (out b : Binding): Boolean; virtual;
    function  next_n (const how_many : Cardinal; out b : BindingList): Boolean; virtual;
    procedure _destroy; virtual;
  end;


  TNamingContextHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : NamingContext);
    class function  Extract(var _A: CORBA.Any) : NamingContext;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId : string;
    class function  Read (const _Input  : CORBA.InputStream) : NamingContext;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : NamingContext);
    class function  Narrow(const _Obj   : CORBA.CORBAObject; _IsA : Boolean = False) : NamingContext;
    class function  Bind(const _InstanceName : string = ''; _HostName : string = '') : NamingContext; overload;
    class function  Bind(_Options : BindOptions; const _InstanceName : string = ''; _HostName: string = '') : NamingContext; overload;
  end;

  TNamingContextStub = class(CORBA.TCORBAObject, NamingContext)
  public
    procedure bind (const n : Name; const obj : CORBAObject); virtual;
    procedure rebind (const n : Name; const obj : CORBAObject); virtual;
    procedure bind_context (const n : Name; const nc : NamingContext); virtual;
    procedure rebind_context (const n : Name; const nc : NamingContext); virtual;
    function  resolve (const n : Name): CORBAObject; virtual;
    procedure unbind (const n : Name); virtual;
    function  new_context : NamingContext; virtual;
    function  bind_new_context (const n : Name): NamingContext; virtual;
    procedure _destroy; virtual;
    procedure list (const how_many : Cardinal; out bl : BindingList;
                    out bi : BindingIterator); virtual;
  end;

  TNamingContext_NotFoundReasonHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : NamingContext_NotFoundReason);
    class function  Extract(const _A: CORBA.Any): NamingContext_NotFoundReason;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : NamingContext_NotFoundReason;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : NamingContext_NotFoundReason);
  end;

  ENamingContext_NotFound = class(UserException)
  private
    Fwhy : NamingContext_NotFoundReason;
    Frest_of_name : Name;
  protected
    function  _get_why : NamingContext_NotFoundReason; virtual;
    function  _get_rest_of_name : Name; virtual;
  public
    property  why : NamingContext_NotFoundReason read _get_why;
    property  rest_of_name : Name read _get_rest_of_name;
    constructor Create; overload;
    constructor Create(const why : NamingContext_NotFoundReason;
                       const rest_of_name : Name); overload;
    procedure Copy(const _Input : InputStream); override;
    procedure WriteExceptionInfo(var _Output : OutputStream); override;
  end;

  ENamingContext_CannotProceed = class(UserException)
  private
    Fcxt : NamingContext;
    Frest_of_name : Name;
  protected
    function  _get_cxt : NamingContext; virtual;
    function  _get_rest_of_name : Name; virtual;
  public
    property  cxt : NamingContext read _get_cxt;
    property  rest_of_name : Name read _get_rest_of_name;
    constructor Create; overload;
    constructor Create(const cxt : NamingContext;
                       const rest_of_name : Name); overload;
    procedure Copy(const _Input : InputStream); override;
    procedure WriteExceptionInfo(var _Output : OutputStream); override;
  end;

  ENamingContext_InvalidName = class(UserException)
  public
    constructor Create; overload;
    procedure Copy(const _Input : InputStream); override;
    procedure WriteExceptionInfo(var _Output : OutputStream); override;
  end;

  ENamingContext_AlreadyBound = class(UserException)
  public
    constructor Create; overload;
    procedure Copy(const _Input : InputStream); override;
    procedure WriteExceptionInfo(var _Output : OutputStream); override;
  end;

  ENamingContext_NotEmpty = class(UserException)
  public
    constructor Create; overload;
    procedure Copy(const _Input : InputStream); override;
    procedure WriteExceptionInfo(var _Output : OutputStream); override;
  end;

  TNamingContextExtHelper = class
    class procedure Insert (var _A: CORBA.Any; const _Value : NamingContextExt);
    class function  Extract(var _A: CORBA.Any) : NamingContextExt;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId : string;
    class function  Read (const _Input  : CORBA.InputStream) : NamingContextExt;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt);
    class function  Narrow(const _Obj   : CORBA.CORBAObject; _IsA : Boolean = False) : NamingContextExt;
    class function  Bind(const _InstanceName : string = ''; _HostName : string = '') : NamingContextExt; overload;
    class function  Bind(_Options : BindOptions; const _InstanceName : string = ''; _HostName: string = '') : NamingContextExt; overload;
  end;

  TNamingContextExtStub = class(CORBA.TCORBAObject, NamingContextExt)
  public
    function  to_string (const n : Name): NamingContextExt_StringName; virtual;
    function  to_name (const sn : NamingContextExt_StringName): Name; virtual;
    function  to_url (const addr : NamingContextExt_Address;
                       const sn : NamingContextExt_StringName): NamingContextExt_URLString; virtual;
    function  resolve_str ( const n : NamingContextExt_StringName): CORBAObject; virtual;
    procedure bind (const n : Name; const obj : CORBAObject); virtual;
    procedure rebind (const n : Name; const obj : CORBAObject); virtual;
    procedure bind_context (const n : Name; const nc : NamingContext); virtual;
    procedure rebind_context (const n : Name; const nc : NamingContext); virtual;
    function  resolve (const n : Name): CORBAObject; virtual;
    procedure unbind (const n : Name); virtual;
    function  new_context : NamingContext; virtual;
    function  bind_new_context (const n : Name): NamingContext; virtual;
    procedure _destroy; virtual;
    procedure list (const how_many : Cardinal; out bl : BindingList;
                    out bi : BindingIterator); virtual;
  end;

  TNamingContextExt_StringNameHelper = class
    class procedure Insert (var   _A: CORBA.Any; const _Value : NamingContextExt_StringName);
    class function  Extract(const _A: CORBA.Any): NamingContextExt_StringName;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : NamingContextExt_StringName;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt_StringName);
  end;

  TNamingContextExt_AddressHelper = class
    class procedure Insert (var   _A: CORBA.Any; const _Value : NamingContextExt_Address);
    class function  Extract(const _A: CORBA.Any): NamingContextExt_Address;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : NamingContextExt_Address;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt_Address);
  end;

  TNamingContextExt_URLStringHelper = class
    class procedure Insert (var   _A: CORBA.Any; const _Value : NamingContextExt_URLString);
    class function  Extract(const _A: CORBA.Any): NamingContextExt_URLString;
    class function  TypeCode : CORBA.TypeCode;
    class function  RepositoryId: string;
    class function  Read (const _Input  : CORBA.InputStream) : NamingContextExt_URLString;
    class procedure Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt_URLString);
  end;

  ENamingContextExt_InvalidAddress = class(UserException)
  public
    constructor Create; overload;
    procedure Copy(const _Input : InputStream); override;
    procedure WriteExceptionInfo(var _Output : OutputStream); override;
  end;



implementation

var
  NamingContext_NotFoundDesc : PExceptionDescription;
  NamingContext_CannotProceedDesc : PExceptionDescription;
  NamingContext_InvalidNameDesc : PExceptionDescription;
  NamingContext_AlreadyBoundDesc : PExceptionDescription;
  NamingContext_NotEmptyDesc : PExceptionDescription;
  NamingContextExt_InvalidAddressDesc : PExceptionDescription;


{TIString Helper}

class procedure TIstringHelper.Insert(var _A : CORBA.Any; const _Value : Istring);
begin
  _A := _Value;
end;

class function TIstringHelper.Extract(const _A : CORBA.Any) : Istring;
var
  _Input : InputStream;
  _Temp  : AnsiString;
begin
  Orb.GetAny(_A, _Input);
  _Input.ReadString(_Temp);
  Result := Istring(_Temp);
end;

class function  TIstringHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateAliasTC(RepositoryId, 'Istring', ORB.CreateTC(Integer(0)));
end;

class function  TIstringHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/Istring:1.0';
end;

class function  TIstringHelper.Read(const _Input: CORBA.InputStream) : Istring;
begin
  _Input.ReadString(Result);
end;

class procedure TIstringHelper.Write(const _Output : CORBA.OutputStream; const _Value : Istring);
begin
  _Output.WriteString(_Value);
end;


{TNameComponentHelper}

class procedure TNameComponentHelper.Insert(var _A : CORBA.Any; const _Value : NameComponent);
var
  _Output : CORBA.OutputStream;
begin
  _Output := ORB.CreateOutputStream;
  TNameComponentHelper.Write(_Output, _Value);
  ORB.PutAny(_A, TNameComponentHelper.TypeCode, _Output);
end;

class function TNameComponentHelper.Extract(const _A : CORBA.Any) : NameComponent;
var
  _Input : CORBA.InputStream;
begin
  Orb.GetAny(_A, _Input);
  Result := TNameComponentHelper.Read(_Input);
end;

class function TNameComponentHelper.TypeCode : CORBA.TypeCode;
var
  _Seq: StructMemberSeq;
begin
  SetLength(_Seq, 2);
  _Seq[0].Name := 'id';
  _Seq[0].TC   := TIstringHelper.TypeCode;
  _Seq[1].Name := 'kind';
  _Seq[1].TC   := TIstringHelper.TypeCode;
  Result := ORB.MakeStructureTypecode(RepositoryID, 'NameComponent', _Seq);
end;

class function TNameComponentHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/NameComponent:1.0';
end;

class function TNameComponentHelper.Read(const _Input : CORBA.InputStream) : NameComponent;
var
  _Value : TNameComponent;
begin
  _Value := TNameComponent.Create;
  _Value.id := TIstringHelper.Read(_Input);
  _Value.kind := TIstringHelper.Read(_Input);
  Result := _Value;
end;

class procedure TNameComponentHelper.Write(const _Output : CORBA.OutputStream; const _Value : NameComponent);
begin
  TIstringHelper.Write(_Output, _Value.id);
  TIstringHelper.Write(_Output, _Value.kind);
end;


{TNameComponent}

constructor TNameComponent.Create;
begin
  inherited Create;
end;

constructor TNameComponent.Create(const id: Istring; const kind: Istring);
begin
  Self.id := id;
  Self.kind := kind;
end;

function  TNameComponent._get_id: Istring;
begin
  Result := id;
end;

procedure TNameComponent._set_id(const _Value : Istring);
begin
  id := _Value;
end;

function  TNameComponent._get_kind: Istring;
begin
  Result := kind;
end;

procedure TNameComponent._set_kind(const _Value : Istring);
begin
  kind := _Value;
end;


{TNameHelper}

class procedure TNameHelper.Insert(var _A : CORBA.Any; const _Value : Name);
var
  _Output : CORBA.OutputStream;
begin
  _Output := ORB.CreateOutputStream;
  TNameHelper.Write(_Output, _Value);
  ORB.PutAny(_A, TNameHelper.TypeCode, _Output);
end;

class function TNameHelper.Extract(const _A : CORBA.Any): Name;
var
  _Input : InputStream;
begin
  Orb.GetAny(_A, _Input);
  Result := TNameHelper.Read(_Input);
end;

class function  TNameHelper.TypeCode: CORBA.TypeCode;
begin
  Result := ORB.CreateSequenceTC(0, TNameComponentHelper.TypeCode());
end;

class function  TNameHelper.RepositoryId: string;
begin
  Result := 'IDL:omg.org/CosNaming/Name:1.0';
end;

class function  TNameHelper.Read(const _Input : CORBA.InputStream) : Name;
var
  L0 : Cardinal;
  I0 : Cardinal;
begin
  _Input.ReadULong(L0);
  SetLength(Result, L0);
  if (L0 > 0) then
  begin
    for I0 := 0 to High(Result) do
      Result[I0] := TNameComponentHelper.Read(_Input);
  end;
end;

class procedure TNameHelper.Write(const _Output: CORBA.OutputStream; const _Value: Name);
var
  L0 : Cardinal;
  I0 : Cardinal;
begin
  L0 := Length(_Value);
  _Output.WriteULong(L0);
  if (L0 > 0) then
  begin
    for I0 := 0 to High(_Value) do
      TNameComponentHelper.Write(_Output, _Value[I0]);
  end;
end;


{TBindHelper}

class procedure TBindingTypeHelper.Insert(var _A : CORBA.Any; const _Value : BindingType);
begin
  _A := _Value;
end;

class function TBindingTypeHelper.Extract(const _A : CORBA.Any) : BindingType;
begin
  Result := BindingType(_A);
end;

class function TBindingTypeHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateEnumTC(RepositoryId, 'BindingType', ['NObject', 'NContext']);
end;

class function TBindingTypeHelper.RepositoryId: string;
begin
  Result := 'IDL:omg.org/CosNaming/BindingType:1.0';
end;

class function TBindingTypeHelper.Read(const _Input : CORBA.InputStream) : BindingType;
var
  _Temp: Cardinal;
begin
  _Input.ReadULong(_Temp);
  Result := BindingType(_Temp);
end;

class procedure TBindingTypeHelper.Write(const _Output : CORBA.OutputStream; const _Value  : BindingType);
begin
  _Output.WriteULong(Cardinal(_Value));
end;

class procedure TBindingHelper.Insert(var _A : CORBA.Any; const _Value : Binding);
var
  _Output : CORBA.OutputStream;
begin
  _Output := ORB.CreateOutputStream;
  TBindingHelper.Write(_Output, _Value);
  ORB.PutAny(_A, TBindingHelper.TypeCode, _Output);
end;

class function TBindingHelper.Extract(const _A : CORBA.Any) : Binding;
var
  _Input : CORBA.InputStream;
begin
  Orb.GetAny(_A, _Input);
  Result := TBindingHelper.Read(_Input);
end;

class function TBindingHelper.TypeCode : CORBA.TypeCode;
var
  _Seq: StructMemberSeq;
begin
  SetLength(_Seq, 2);
  _Seq[0].Name := 'binding_name';
  _Seq[0].TC   := TNameHelper.TypeCode;
  _Seq[1].Name := 'binding_type';
  _Seq[1].TC   := TBindingTypeHelper.TypeCode;
  Result := ORB.MakeStructureTypecode(RepositoryID, 'Binding', _Seq);
end;

class function TBindingHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/Binding:1.0';
end;

class function TBindingHelper.Read(const _Input : CORBA.InputStream) : Binding;
var
  _Value : TBinding;
begin
  _Value := TBinding.Create;
  _Value.binding_name := TNameHelper.Read(_Input);
  _Value.binding_type := TBindingTypeHelper.Read(_Input);
  Result := _Value;
end;

class procedure TBindingHelper.Write(const _Output : CORBA.OutputStream; const _Value : Binding);
begin
  TNameHelper.Write(_Output, _Value.binding_name);
  TBindingTypeHelper.Write(_Output, _Value.binding_type);
end;


{TBinding}

constructor TBinding.Create;
begin
  inherited Create;
end;

constructor TBinding.Create(const binding_name: Name; const binding_type: BindingType);
begin
  Self.binding_name := binding_name;
  Self.binding_type := binding_type;
end;

function TBinding._get_binding_name: Name;
begin
  Result := binding_name;
end;

procedure TBinding._set_binding_name(const _Value : Name);
begin
  binding_name := _Value;
end;

function TBinding._get_binding_type: BindingType;
begin
  Result := binding_type;
end;

procedure TBinding._set_binding_type(const _Value : BindingType);
begin
  binding_type := _Value;
end;


{TBindingListHelper}

class procedure TBindingListHelper.Insert(var _A : CORBA.Any; const _Value : BindingList);
var
  _Output : CORBA.OutputStream;
begin
  _Output := ORB.CreateOutputStream;
  TBindingListHelper.Write(_Output, _Value);
  ORB.PutAny(_A, TBindingListHelper.TypeCode, _Output);
end;

class function TBindingListHelper.Extract(const _A : CORBA.Any): BindingList;
var
  _Input : InputStream;
begin
  Orb.GetAny(_A, _Input);
  Result := TBindingListHelper.Read(_Input);
end;

class function  TBindingListHelper.TypeCode: CORBA.TypeCode;
begin
  Result := ORB.CreateSequenceTC(0, TBindingHelper.TypeCode());
end;

class function  TBindingListHelper.RepositoryId: string;
begin
  Result := 'IDL:omg.org/CosNaming/BindingList:1.0';
end;

class function  TBindingListHelper.Read(const _Input : CORBA.InputStream) : BindingList;
var
  L0 : Cardinal;
  I0 : Cardinal;
begin
  _Input.ReadULong(L0);
  SetLength(Result, L0);
  if (L0 > 0) then
  begin
    for I0 := 0 to High(Result) do
      Result[I0] := TBindingHelper.Read(_Input);
  end;
end;

class procedure TBindingListHelper.Write(const _Output: CORBA.OutputStream; const _Value: BindingList);
var
  L0 : Cardinal;
  I0 : Cardinal;
begin
  L0 := Length(_Value);
  _Output.WriteULong(L0);
  if (L0 > 0) then
  begin
    for I0 := 0 to High(_Value) do
      TBindingHelper.Write(_Output, _Value[I0]);
  end;
end;


{TBindingIterator}

class procedure TBindingIteratorHelper.Insert(var _A : CORBA.Any; const _Value : BindingIterator);
begin
  _A := Orb.MakeObjectRef(TBindingIteratorHelper.TypeCode, _Value as CORBA.CORBAObject);
end;

class function TBindingIteratorHelper.Extract(var _A : CORBA.Any): BindingIterator;
var
  _obj : Corba.CorbaObject;
begin
  _obj := Orb.GetObjectRef(_A);
  Result := TBindingIteratorHelper.Narrow(_obj, True);
end;

class function TBindingIteratorHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateInterfaceTC(RepositoryId, 'BindingIterator');
end;

class function TBindingIteratorHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/BindingIterator:1.0';
end;

class function TBindingIteratorHelper.Read(const _Input : CORBA.InputStream) : BindingIterator;
var
  _Obj : CORBA.CORBAObject;
begin
  _Input.ReadObject(_Obj);
  Result := Narrow(_Obj, True)
end;

class procedure TBindingIteratorHelper.Write(const _Output : CORBA.OutputStream;
  const _Value : BindingIterator);
begin
  _Output.WriteObject(_Value as CORBA.CORBAObject);
end;

class function TBindingIteratorHelper.Narrow(const _Obj : CORBA.CORBAObject;
  _IsA : Boolean) : BindingIterator;
begin
  Result := nil;
  if (_Obj = nil) or (_Obj.QueryInterface(BindingIterator, Result) = 0) then
    exit;
  if _IsA and _Obj._IsA(RepositoryId) then
    Result := TBindingIteratorStub.Create(_Obj);
end;

class function TBindingIteratorHelper.Bind(const _InstanceName : string = '';
  _HostName: string = '') : BindingIterator;
begin
  Result := Narrow(ORB.bind(RepositoryId, _InstanceName, _HostName), True);
end;

class function TBindingIteratorHelper.Bind(_Options : BindOptions;
  const _InstanceName : string = ''; _HostName : string = '') : BindingIterator;
begin
  Result := Narrow(ORB.bind(RepositoryId, _Options, _InstanceName, _HostName), True);
end;


{TBindingIteratorStub}

function  TBindingIteratorStub.next_one(out b : Binding): Boolean;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('next_one',True, _Output);
  inherited _Invoke(_Output, _Input);
  _Input.ReadBoolean(Result);
  b := TBindingHelper.Read(_Input);
end;

function  TBindingIteratorStub.next_n(const how_many : Cardinal; out b : BindingList): Boolean;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('next_n',True, _Output);
  _Output.WriteULong(how_many);
  inherited _Invoke(_Output, _Input);
  _Input.ReadBoolean(Result);
  b := TBindingListHelper.Read(_Input);
end;

procedure TBindingIteratorStub._destroy;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('_destroy',True, _Output);
  inherited _Invoke(_Output, _Input);
end;


{TNamingContextHelper}

class procedure TNamingContextHelper.Insert(var _A : CORBA.Any; const _Value : NamingContext);
begin
  _A := Orb.MakeObjectRef(TNamingContextHelper.TypeCode, _Value as CORBA.CORBAObject);
end;

class function TNamingContextHelper.Extract(var _A : CORBA.Any): NamingContext;
var
  _obj : Corba.CorbaObject;
begin
  _obj := Orb.GetObjectRef(_A);
  Result := TNamingContextHelper.Narrow(_obj, True);
end;

class function TNamingContextHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateInterfaceTC(RepositoryId, 'NamingContext');
end;

class function TNamingContextHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/NamingContext:1.0';
end;

class function TNamingContextHelper.Read(const _Input : CORBA.InputStream) : NamingContext;
var
  _Obj : CORBA.CORBAObject;
begin
  _Input.ReadObject(_Obj);
  Result := Narrow(_Obj, True)
end;

class procedure TNamingContextHelper.Write(const _Output : CORBA.OutputStream; const _Value : NamingContext);
begin
  _Output.WriteObject(_Value as CORBA.CORBAObject);
end;

class function TNamingContextHelper.Narrow(const _Obj : CORBA.CORBAObject; _IsA : Boolean) : NamingContext;
begin
  Result := nil;
  if (_Obj = nil) or (_Obj.QueryInterface(NamingContext, Result) = 0) then
    exit;
  if _IsA and _Obj._IsA(RepositoryId) then
    Result := TNamingContextStub.Create(_Obj);
end;

class function TNamingContextHelper.Bind(const _InstanceName : string = ''; _HostName: string = '') : NamingContext;
begin
  Result := Narrow(ORB.bind(RepositoryId, _InstanceName, _HostName), True);
end;

class function TNamingContextHelper.Bind(_Options : BindOptions;
  const _InstanceName : string = ''; _HostName : string = '') : NamingContext;
begin
  Result := Narrow(ORB.bind(RepositoryId, _Options, _InstanceName, _HostName), True);
end;

{TNamingContextStub}

procedure TNamingContextStub.bind(const n : Name; const obj : CORBAObject);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('bind',True, _Output);
  TNameHelper.Write(_Output, n);
  _Output.WriteObject(obj);
  inherited _Invoke(_Output, _Input);
end;

procedure TNamingContextStub.rebind(const n : Name; const obj : CORBAObject);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('rebind',True, _Output);
  TNameHelper.Write(_Output, n);
  _Output.WriteObject(obj);
  inherited _Invoke(_Output, _Input);
end;

procedure TNamingContextStub.bind_context(const n : Name; const nc : NamingContext);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('bind_context',True, _Output);
  TNameHelper.Write(_Output, n);
  TNamingContextHelper.Write(_Output, nc);
  inherited _Invoke(_Output, _Input);
end;

procedure TNamingContextStub.rebind_context(const n : Name; const nc : NamingContext);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('rebind_context',True, _Output);
  TNameHelper.Write(_Output, n);
  TNamingContextHelper.Write(_Output, nc);
  inherited _Invoke(_Output, _Input);
end;

function  TNamingContextStub.resolve ( const n : Name): CORBAObject;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('resolve',True, _Output);
  TNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
  _Input.ReadObject(Result);
end;

procedure TNamingContextStub.unbind(const n : Name);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('unbind',True, _Output);
  TNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
end;

function  TNamingContextStub.new_context : NamingContext;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('new_context',True, _Output);
  inherited _Invoke(_Output, _Input);
  Result := TNamingContextHelper.Read(_Input);
end;

function  TNamingContextStub.bind_new_context(const n : Name): NamingContext;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('bind_new_context',True, _Output);
  TNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
  Result := TNamingContextHelper.Read(_Input);
end;

procedure TNamingContextStub._destroy;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('_destroy',True, _Output);
  inherited _Invoke(_Output, _Input);
end;


{TNamingContextStub}

procedure TNamingContextStub.list(const how_many : Cardinal; out bl : BindingList;
                                  out bi : BindingIterator);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('list',True, _Output);
  _Output.WriteULong(how_many);
  inherited _Invoke(_Output, _Input);
  bl := TBindingListHelper.Read(_Input);
  bi := TBindingIteratorHelper.Read(_Input);
end;


{TNamingContext_NotFoundReasonHelper}

class procedure TNamingContext_NotFoundReasonHelper.Insert(var _A : CORBA.Any; const _Value : NamingContext_NotFoundReason);
begin
  _A := _Value;
end;

class function TNamingContext_NotFoundReasonHelper.Extract(const _A : CORBA.Any) : NamingContext_NotFoundReason;
begin
  Result := NamingContext_NotFoundReason(_A);
end;

class function TNamingContext_NotFoundReasonHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateEnumTC(RepositoryId, 'NamingContext_NotFoundReason', ['missing_node', 'not_context', 'not_object']);
end;

class function TNamingContext_NotFoundReasonHelper.RepositoryId: string;
begin
  Result := 'IDL:omg.org/CosNaming/NamingContext/NotFoundReason:1.0';
end;

class function TNamingContext_NotFoundReasonHelper.Read(const _Input : CORBA.InputStream) : NamingContext_NotFoundReason;
var
  _Temp: Cardinal;
begin
  _Input.ReadULong(_Temp);
  Result := NamingContext_NotFoundReason(_Temp);
end;

class procedure TNamingContext_NotFoundReasonHelper.Write(const _Output : CORBA.OutputStream; const _Value  : NamingContext_NotFoundReason);
begin
  _Output.WriteULong(Cardinal(_Value));
end;


{ENamingContext_NotFound}

function ENamingContext_NotFound._get_why : NamingContext_NotFoundReason;
begin
  Result := Fwhy;
end;

function  ENamingContext_NotFound._get_rest_of_name : Name;
begin
  Result := Frest_of_name;
end;

constructor ENamingContext_NotFound.Create;
begin
  inherited Create;
end;

constructor ENamingContext_NotFound.Create(const why : NamingContext_NotFoundReason; const rest_of_name : Name);
begin
  inherited Create;
  Fwhy := why;
  Frest_of_name := rest_of_name;
end;

procedure ENamingContext_NotFound.Copy(const _Input: InputStream);
begin
  Fwhy := TNamingContext_NotFoundReasonHelper.Read(_Input);
  Frest_of_name := TNameHelper.Read(_Input);
end;

procedure ENamingContext_NotFound.WriteExceptionInfo(var _Output : OutputStream);
begin
  _Output.WriteString('IDL:omg.org/CosNaming/NamingContext/NotFound:1.0');
  TNamingContext_NotFoundReasonHelper.Write(_Output, Fwhy);
  TNameHelper.Write(_Output, Frest_of_name);
end;

function  NamingContext_NotFound_Factory: PExceptionProxy; cdecl;
begin
  with ENamingContext_NotFound.Create() do
    Result := Proxy;
end;


{ENamingContext_CannotProceed}

function  ENamingContext_CannotProceed._get_cxt : NamingContext;
begin
  Result := Fcxt;
end;

function  ENamingContext_CannotProceed._get_rest_of_name : Name;
begin
  Result := Frest_of_name;
end;

constructor ENamingContext_CannotProceed.Create;
begin
  inherited Create;
end;

constructor ENamingContext_CannotProceed.Create(const cxt : NamingContext; const rest_of_name : Name);
begin
  inherited Create;
  Fcxt := cxt;
  Frest_of_name := rest_of_name;
end;

procedure ENamingContext_CannotProceed.Copy(const _Input: InputStream);
begin
  Fcxt := TNamingContextHelper.Read(_Input);
  Frest_of_name := TNameHelper.Read(_Input);
end;

procedure ENamingContext_CannotProceed.WriteExceptionInfo(var _Output : OutputStream);
begin
  _Output.WriteString('IDL:omg.org/CosNaming/NamingContext/CannotProceed:1.0');
  TNamingContextHelper.Write(_Output, Fcxt);
  TNameHelper.Write(_Output, Frest_of_name);
end;

function  NamingContext_CannotProceed_Factory: PExceptionProxy; cdecl;
begin
  with ENamingContext_CannotProceed.Create() do
    Result := Proxy;
end;


{ENamingContext_InvalidName}

constructor ENamingContext_InvalidName.Create;
begin
  inherited Create;
end;

procedure ENamingContext_InvalidName.Copy(const _Input: InputStream);
begin
end;

procedure ENamingContext_InvalidName.WriteExceptionInfo(var _Output : OutputStream);
begin
  _Output.WriteString('IDL:omg.org/CosNaming/NamingContext/InvalidName:1.0');
end;

function  NamingContext_InvalidName_Factory: PExceptionProxy; cdecl;
begin
  with ENamingContext_InvalidName.Create() do
    Result := Proxy;
end;


{ENamingContext_AlreadyBound}

constructor ENamingContext_AlreadyBound.Create;
begin
  inherited Create;
end;

procedure ENamingContext_AlreadyBound.Copy(const _Input: InputStream);
begin
end;

procedure ENamingContext_AlreadyBound.WriteExceptionInfo(var _Output : OutputStream);
begin
  _Output.WriteString('IDL:omg.org/CosNaming/NamingContext/AlreadyBound:1.0');
end;

function  NamingContext_AlreadyBound_Factory: PExceptionProxy; cdecl;
begin
  with ENamingContext_AlreadyBound.Create() do
    Result := Proxy;
end;


{ENamingContext_NotEmpty}

constructor ENamingContext_NotEmpty.Create;
begin
  inherited Create;
end;

procedure ENamingContext_NotEmpty.Copy(const _Input: InputStream);
begin
end;

procedure ENamingContext_NotEmpty.WriteExceptionInfo(var _Output : OutputStream);
begin
  _Output.WriteString('IDL:omg.org/CosNaming/NamingContext/NotEmpty:1.0');
end;

function  NamingContext_NotEmpty_Factory: PExceptionProxy; cdecl;
begin
  with ENamingContext_NotEmpty.Create() do
    Result := Proxy;
end;


{TNamingContextExtHelper}

class procedure TNamingContextExtHelper.Insert(var _A : CORBA.Any; const _Value : NamingContextExt);
begin
  _A := Orb.MakeObjectRef(TNamingContextExtHelper.TypeCode, _Value as CORBA.CORBAObject);
end;

class function TNamingContextExtHelper.Extract(var _A : CORBA.Any): NamingContextExt;
var
  _obj : Corba.CorbaObject;
begin
  _obj := Orb.GetObjectRef(_A);
  Result := TNamingContextExtHelper.Narrow(_obj, True);
end;

class function TNamingContextExtHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateInterfaceTC(RepositoryId, 'NamingContextExt');
end;

class function TNamingContextExtHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/NamingContextExt:1.0';
end;

class function TNamingContextExtHelper.Read(const _Input : CORBA.InputStream) : NamingContextExt;
var
  _Obj : CORBA.CORBAObject;
begin
  _Input.ReadObject(_Obj);
  Result := Narrow(_Obj, True)
end;

class procedure TNamingContextExtHelper.Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt);
begin
  _Output.WriteObject(_Value as CORBA.CORBAObject);
end;

class function TNamingContextExtHelper.Narrow(const _Obj : CORBA.CORBAObject; _IsA : Boolean) : NamingContextExt;
begin
  Result := nil;
  if (_Obj = nil) or (_Obj.QueryInterface(NamingContextExt, Result) = 0) then
    exit;
  if _IsA and _Obj._IsA(RepositoryId) then
    Result := TNamingContextExtStub.Create(_Obj);
end;

class function TNamingContextExtHelper.Bind(const _InstanceName : string = ''; _HostName: string = '') : NamingContextExt;
begin
  Result := Narrow(ORB.bind(RepositoryId, _InstanceName, _HostName), True);
end;

class function TNamingContextExtHelper.Bind(_Options : BindOptions;
  const _InstanceName : string = ''; _HostName : string = '') : NamingContextExt;
begin
  Result := Narrow(ORB.bind(RepositoryId, _Options, _InstanceName, _HostName), True);
end;


{TNamingContextExtStub}

function  TNamingContextExtStub.to_string(const n : Name): NamingContextExt_StringName;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('to_string',True, _Output);
  TNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
  Result := TNamingContextExt_StringNameHelper.Read(_Input);
end;

function  TNamingContextExtStub.to_name(const sn : NamingContextExt_StringName): Name;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('to_name',True, _Output);
  TNamingContextExt_StringNameHelper.Write(_Output, sn);
  inherited _Invoke(_Output, _Input);
  Result := TNameHelper.Read(_Input);
end;

function  TNamingContextExtStub.to_url(const addr : NamingContextExt_Address;
                                       const sn : NamingContextExt_StringName): NamingContextExt_URLString;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('to_url',True, _Output);
  TNamingContextExt_AddressHelper.Write(_Output, addr);
  TNamingContextExt_StringNameHelper.Write(_Output, sn);
  inherited _Invoke(_Output, _Input);
  Result := TNamingContextExt_URLStringHelper.Read(_Input);
end;

function  TNamingContextExtStub.resolve_str(const n : NamingContextExt_StringName): CORBAObject;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('resolve_str',True, _Output);
  TNamingContextExt_StringNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
  _Input.ReadObject(Result);
end;

procedure TNamingContextExtStub.bind(const n : Name; const obj : CORBAObject);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('bind',True, _Output);
  TNameHelper.Write(_Output, n);
  _Output.WriteObject(obj);
  inherited _Invoke(_Output, _Input);
end;

procedure TNamingContextExtStub.rebind(const n : Name; const obj : CORBAObject);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('rebind',True, _Output);
  TNameHelper.Write(_Output, n);
  _Output.WriteObject(obj);
  inherited _Invoke(_Output, _Input);
end;

procedure TNamingContextExtStub.bind_context(const n : Name; const nc : NamingContext);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('bind_context',True, _Output);
  TNameHelper.Write(_Output, n);
  TNamingContextHelper.Write(_Output, nc);
  inherited _Invoke(_Output, _Input);
end;

procedure TNamingContextExtStub.rebind_context(const n : Name; const nc : NamingContext);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('rebind_context',True, _Output);
  TNameHelper.Write(_Output, n);
  TNamingContextHelper.Write(_Output, nc);
  inherited _Invoke(_Output, _Input);
end;

function  TNamingContextExtStub.resolve(const n : Name): CORBAObject;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('resolve',True, _Output);
  TNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
  _Input.ReadObject(Result);
end;

procedure TNamingContextExtStub.unbind(const n : Name);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('unbind',True, _Output);
  TNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
end;

function  TNamingContextExtStub.new_context : NamingContext;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('new_context',True, _Output);
  inherited _Invoke(_Output, _Input);
  Result := TNamingContextHelper.Read(_Input);
end;

function  TNamingContextExtStub.bind_new_context(const n : Name): NamingContext;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('bind_new_context',True, _Output);
  TNameHelper.Write(_Output, n);
  inherited _Invoke(_Output, _Input);
  Result := TNamingContextHelper.Read(_Input);
end;

procedure TNamingContextExtStub._destroy ;
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('_destroy',True, _Output);
  inherited _Invoke(_Output, _Input);
end;


{TNamingContextExtStub}

procedure TNamingContextExtStub.list(const how_many : Cardinal; out bl : BindingList;
                                     out bi : BindingIterator);
var
  _Output: CORBA.OutputStream;
  _Input : CORBA.InputStream;
begin
  inherited _CreateRequest('list',True, _Output);
  _Output.WriteULong(how_many);
  inherited _Invoke(_Output, _Input);
  bl := TBindingListHelper.Read(_Input);
  bi := TBindingIteratorHelper.Read(_Input);
end;


{TNamingContextExt_StringNameHelper}

class procedure TNamingContextExt_StringNameHelper.Insert(var _A : CORBA.Any; const _Value : NamingContextExt_StringName);
begin
  _A := _Value;
end;

class function TNamingContextExt_StringNameHelper.Extract(const _A : CORBA.Any) : NamingContextExt_StringName;
var
  _Input : InputStream;
  _Temp  : AnsiString;
begin
  Orb.GetAny(_A, _Input);
  _Input.ReadString(_Temp);
  Result := NamingContextExt_StringName(_Temp);
end;

class function TNamingContextExt_StringNameHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateAliasTC(RepositoryId, 'NamingContextExt_StringName', ORB.CreateTC(Integer(0)));
end;

class function  TNamingContextExt_StringNameHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/NamingContextExt/StringName:1.0';
end;

class function TNamingContextExt_StringNameHelper.Read(const _Input: CORBA.InputStream) : NamingContextExt_StringName;
begin
  _Input.ReadString(Result);
end;

class procedure TNamingContextExt_StringNameHelper.Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt_StringName);
begin
  _Output.WriteString(_Value);
end;


{TNamingContextExt_AddressHelper}

class procedure TNamingContextExt_AddressHelper.Insert(var _A : CORBA.Any; const _Value : NamingContextExt_Address);
begin
  _A := _Value;
end;

class function TNamingContextExt_AddressHelper.Extract(const _A : CORBA.Any) : NamingContextExt_Address;
var
  _Input : InputStream;
  _Temp  : AnsiString;
begin
  Orb.GetAny(_A, _Input);
  _Input.ReadString(_Temp);
  Result := NamingContextExt_Address(_Temp);
end;

class function  TNamingContextExt_AddressHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateAliasTC(RepositoryId, 'NamingContextExt_Address', ORB.CreateTC(Integer(0)));
end;

class function  TNamingContextExt_AddressHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/NamingContextExt/Address:1.0';
end;

class function  TNamingContextExt_AddressHelper.Read(const _Input: CORBA.InputStream) : NamingContextExt_Address;
begin
  _Input.ReadString(Result);
end;

class procedure TNamingContextExt_AddressHelper.Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt_Address);
begin
  _Output.WriteString(_Value);
end;

{TNamingContextExt_URLStringHelper}

class procedure TNamingContextExt_URLStringHelper.Insert(var _A : CORBA.Any; const _Value : NamingContextExt_URLString);
begin
  _A := _Value;
end;

class function TNamingContextExt_URLStringHelper.Extract(const _A : CORBA.Any) : NamingContextExt_URLString;
var
  _Input : InputStream;
  _Temp  : AnsiString;
begin
  Orb.GetAny(_A, _Input);
  _Input.ReadString(_Temp);
  Result := NamingContextExt_URLString(_Temp);
end;

class function  TNamingContextExt_URLStringHelper.TypeCode : CORBA.TypeCode;
begin
  Result := ORB.CreateAliasTC(RepositoryId, 'NamingContextExt_URLString', ORB.CreateTC(Integer(0)));
end;

class function  TNamingContextExt_URLStringHelper.RepositoryId : string;
begin
  Result := 'IDL:omg.org/CosNaming/NamingContextExt/URLString:1.0';
end;

class function  TNamingContextExt_URLStringHelper.Read(const _Input: CORBA.InputStream) : NamingContextExt_URLString;
begin
  _Input.ReadString(Result);
end;

class procedure TNamingContextExt_URLStringHelper.Write(const _Output : CORBA.OutputStream; const _Value : NamingContextExt_URLString);
begin
  _Output.WriteString(_Value);
end;


{ENamingContextExt_InvalidAddress}

constructor ENamingContextExt_InvalidAddress.Create;
begin
  inherited Create;
end;

procedure ENamingContextExt_InvalidAddress.Copy(const _Input: InputStream);
begin
end;

procedure ENamingContextExt_InvalidAddress.WriteExceptionInfo(var _Output : OutputStream);
begin
  _Output.WriteString('IDL:omg.org/CosNaming/NamingContextExt/InvalidAddress:1.0');
end;

function  NamingContextExt_InvalidAddress_Factory: PExceptionProxy; cdecl;
begin
  with ENamingContextExt_InvalidAddress.Create() do
    Result := Proxy;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Corba45\CosNaming.pas initialization enter'); {$EndIf}
NamingContext_NotFoundDesc := RegisterUserException('NotFound', 'IDL:omg.org/CosNaming/NamingContext/NotFound:1.0', @NamingContext_NotFound_Factory);
NamingContext_CannotProceedDesc := RegisterUserException('CannotProceed', 'IDL:omg.org/CosNaming/NamingContext/CannotProceed:1.0', @NamingContext_CannotProceed_Factory);
NamingContext_InvalidNameDesc := RegisterUserException('InvalidName', 'IDL:omg.org/CosNaming/NamingContext/InvalidName:1.0', @NamingContext_InvalidName_Factory);
NamingContext_AlreadyBoundDesc := RegisterUserException('AlreadyBound', 'IDL:omg.org/CosNaming/NamingContext/AlreadyBound:1.0', @NamingContext_AlreadyBound_Factory);
NamingContext_NotEmptyDesc := RegisterUserException('NotEmpty', 'IDL:omg.org/CosNaming/NamingContext/NotEmpty:1.0', @NamingContext_NotEmpty_Factory);
NamingContextExt_InvalidAddressDesc := RegisterUserException('InvalidAddress', 'IDL:omg.org/CosNaming/NamingContextExt/InvalidAddress:1.0', @NamingContextExt_InvalidAddress_Factory);


{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Corba45\CosNaming.pas initialization leave'); {$EndIf}
finalization
UnRegisterUserException(NamingContext_NotFoundDesc);
UnRegisterUserException(NamingContext_CannotProceedDesc);
UnRegisterUserException(NamingContext_InvalidNameDesc);
UnRegisterUserException(NamingContext_AlreadyBoundDesc);
UnRegisterUserException(NamingContext_NotEmptyDesc);
UnRegisterUserException(NamingContextExt_InvalidAddressDesc);


end.
