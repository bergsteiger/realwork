// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit value;

interface

uses
  value_int,code_int,classes,orbtypes,except_int,encoder,decoder, orb_int, stdstat;

type

  TAbstractBase = class(TInterfacedObject,IAbstractBase)
  protected
    function _to_object: IORBObject; virtual;
    function _to_value: IValueBase;  virtual;
    function narrow_helper(const repoid: RepositoryId): Pointer; virtual;
    procedure assign(const obj: IORBObject); virtual;
  public
    class procedure _marshal(const enc: IEncoder; const ab: IAbstractBase);
    class function _demarshal(const dec: IDecoder; var ab: IAbstractBase): Boolean;
  end;

  TUnknownAbstract = class(TAbstractBase)
  private
    FObject: IORBObject;
    FValue: IValueBase;
  protected
    function _to_object: IORBObject; override;
    function _to_value: IValueBase;  override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(val: IValueBase); overload;
    constructor Create(obj: IORBObject); overload;
  end;

  TValueBase = class(TInterfacedObject,IValueBase)
  protected
    function _copy_value : IValueBase; virtual;
    procedure _copy_members(const v: TObject); virtual;
    procedure _get_marshal_info(const str: TStrings; out chunked: Boolean); virtual;
    procedure _marshal_members(const enc: IEncoder);  virtual;
    function  _demarshal_members(const dec: Idecoder): Boolean; virtual;
    function narrow_helper(const repoid: RepositoryId): Pointer; virtual;
  public
    class function _create(repoids: TStrings; repoid: RepositoryId): IValueBase;
    class function _downcast(const vb: IValueBase): IValueBase;
    class procedure _marshal(const enc: IEncoder; const vb: IValueBase);
    class function _demarshal(const dec: IDecoder; var vb: IValueBase; const repoid: RepositoryId): Boolean;
  end;

  TValueFactoryBase = class(TInterfacedObject, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; virtual; abstract;
    function narrow_helper(const repoid: RepositoryId): Pointer; virtual;
  end;

  {** IDL:omg.org/CORBA/StringValue:1.0 } 
  TStringValue = class(TValueBase,IStringValue,IValueBase)
  protected
    FValue : AnsiString;
    function _copy_value : IValueBase; override;
    function _value : AnsiString; overload;
    procedure _value(val : AnsiString); overload;
    procedure _marshal_members(const enc: IEncoder); override;
    procedure _get_marshal_info(const str: TStrings;out chunked: Boolean); override;
    function  _demarshal_members(const dec: Idecoder): Boolean; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(val: AnsiString); overload;
    constructor Create(val:IStringValue); overload;
    class function _downcast(const vb : IValueBase): IStringValue;
  end;

  TStringValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TStringValueFactory = class(TValueFactoryBase)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  {** IDL:omg.org/CORBA/WStringValue:1.0 }
  TWStringValue = class(TValueBase,IWStringValue,IValueBase)
  protected
    FValue : widestring;
    function _copy_value : IValueBase; override;
    function _value : widestring; overload;
    procedure _value(val : widestring); overload;
    procedure _marshal_members(const enc: IEncoder); override;
    procedure _get_marshal_info(const str: TStrings;out chunked: Boolean); override;
    function  _demarshal_members(const dec: Idecoder): Boolean; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(val:widestring); overload;
    constructor Create(val:IWStringValue); overload;
    class function _downcast(const vb : IValueBase): IWStringValue;
  end;

  TWStringValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TWStringValueFactory = class(TValueFactoryBase)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  function WStringValue_to_any(const val: IWStringValue): IAny;
  function any_to_WStringValue(const a: IAny; var val: IWStringValue): Boolean;

var
  StringValue_marshaller : IStaticTypeInfo;
  WStringValue_marshaller : IStaticTypeInfo;
  _tc_StringValue : ITypeCodeConst;
  _tc_WStringValue : ITypeCodeConst;

implementation

uses
  SysUtils, orb, throw, exceptions, tcode, any, static;

function WStringValue_to_any(const val: IWStringValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(WStringValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_WStringValue(const a: IAny; var val: IWStringValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(WStringValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

//***********************************************************************
//  TValueBase
//***********************************************************************
class function TValueBase._create(repoids: TStrings; repoid: RepositoryId): IValueBase;
var
  dorb: IORB;
  vf : IValueFactory;
  i : integer;
begin
  result := nil;
  dorb := ORB_Instance;
  if repoids.Count = 0 then
    begin
      vf := dorb.lookup_value_factory(repoid);
      if vf <> nil then
        begin
          result := vf.create_for_umarshal();
          exit;
        end
      else
        raise MARSHAL.Create('Factory for value type not found. Repository ID: ' + String(repoid), 0, COMPLETED_MAYBE);
    end
  else
    for i := 0 to Pred(repoids.count) do
      begin
        vf := dorb.lookup_value_factory(RepositoryId(repoids[i]));
        if vf <> nil then
          begin
            result := vf.create_for_umarshal();
            exit;
          end
        else
          raise MARSHAL.Create('Factory for value type not found. Repository IDs: ' + repoids.Text, 0, COMPLETED_MAYBE);
      end;
end;

class procedure TValueBase._marshal(const enc: IEncoder; const vb: IValueBase);
var
  lst: TStrings;
  chunked: Boolean;
  vid: longint;
begin
  if vb = nil then
    begin
      enc.value_ref(0);
      exit;
    end;
  vid := enc.valuestate.visited.IndexOf(vb);
  if vid > 0 then
    begin
      enc.value_ref(enc.valuestate.visited[vb]);
      exit;
    end;
  lst := TStringList.Create;
  try
    vb._get_marshal_info(lst,chunked);
    enc.value_begin('',lst,chunked,vid);
    enc.valuestate.visited[vb] := vid;
    vb._marshal_members(enc);
  finally
    lst.Free;
  end;
end;

class function TValueBase._demarshal(const dec: IDecoder; var vb: IValueBase; const repoid: RepositoryId): Boolean;
var
  url: AnsiString;
  repoids: TStrings;
  vid : longint;
  is_ref: Boolean;
  temp: IUnknown;
  saveReadPosition: Cardinal;

  function HasWriteObject(): Boolean;
  var
    kFormatVersionOne: octet;
    defaultWriteObject: Boolean;
  begin
    Result := False;
    //see java SDK, IIOPInputStream.java 900 line
    // Read format version
    if not dec.get_octet(kFormatVersionOne) then Exit;
    // Read defaultWriteObject indicator
    if not dec.get_boolean(defaultWriteObject) then Exit;
    Result := True;
  end;

begin
  result := false;
  repoids := TStringList.Create;
  try
    if not dec.value_begin(url,repoids,vid,is_ref) then exit;
    if is_ref then
      begin
        if vid = 0 then
          begin
            vb := nil;
            result := true;
            exit;
          end;
        // indirection
        temp := dec.valuestates.visited[vid];
        if temp = nil then exit;
        vb := IValueBase(temp);
        result := true;
        exit;
      end;
    vb := _create(repoids,repoid);
    if vb = nil then exit;
    dec.valuestates.visited[vid] := vb;
    saveReadPosition := dec._buffer.RPosition;
    //see java SDK, IIOPInputStream.java 900 line
    if not vb._demarshal_members(dec) then begin
      //try demarshal again
      if not dec._buffer.RseekFromBegin(saveReadPosition) then Exit;
      if not HasWriteObject() then Exit;
      if not vb._demarshal_members(dec) then exit;
    end;
    result := true;
    dec.value_end(vid);
  finally
    repoids.Free;
  end;
end;

procedure TValueBase._get_marshal_info(const str: TStrings; out chunked: Boolean);
begin
  // must be implemented for each valuetype class
  assert(false,'not imlplemented');
end;

procedure TValueBase._marshal_members(const enc: IEncoder);
begin
  // must be implemented for each valuetype class
  assert(false,'not imlplemented');
end;

function  TValueBase._demarshal_members(const dec: Idecoder): Boolean;
begin
  // must be implemented for each valuetype class
  assert(false,'not imlplemented');
  result := false;
end;

function TValueBase.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
end;

procedure TValueBase._copy_members(const v: TObject);
begin

end;

function TValueBase._copy_value: IValueBase;
var
  enc: IEncoder;
  dec : IDecoder;
  str: TStrings;
  chunked : Boolean;
begin
  enc := CreateEncoder();
  dec := CreateDecoder(enc.buffer);
  str := TStringList.Create();
  try
    _get_marshal_info(str,chunked);
    _marshal(enc,self);
    assert(_demarshal(dec,result,RepositoryId(str[0])));
  finally
    str.free;
  end;
end;

class function TValueBase._downcast(const vb: IValueBase): IValueBase;
begin
  result := vb;
end;

//***********************************************************************
// TValueFactoryBase }
//***********************************************************************
function TValueFactoryBase.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  Result := nil;
end;

//***********************************************************************
//  TAbstractBase
//***********************************************************************
class function TAbstractBase._demarshal(const dec: IDecoder;
  var ab: IAbstractBase): Boolean;
var
  is_object: Boolean;
  obj : IORBObject;
  val: IValueBase;
begin
  result := false;
  if not stat_boolean.demarshal(dec,@is_object) then exit;
  if is_object then
    begin
      if not stat_Object.demarshal(dec,@obj) then exit;
      ab := TUnknownAbstract.Create(obj);
      result := true;
    end
  else
    begin
      if not stat_ValueBase.demarshal(dec,@val) then exit;
      ab := TUnknownAbstract.Create(val);
      result := true;
    end;
end;

class procedure TAbstractBase._marshal(const enc: IEncoder;
  const ab: IAbstractBase);
var
  obj : IORBObject;
  val : IValueBase;
begin
  obj := ab._to_object;
  val := ab._to_value;
  if assigned(obj) then
    begin
      enc.put_boolean(true);
      stat_Object.marshal(enc,@obj);
    end
  else
    begin
      enc.put_boolean(false);
      stat_ValueBase.marshal(enc,@val);
    end
end;

function TAbstractBase.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
end;

function TAbstractBase._to_object: IORBObject;
begin
  result := nil;
end;

function TAbstractBase._to_value: IValueBase;
begin
  result := nil;
end;

procedure TAbstractBase.assign(const obj: IORBObject);
var
  o : IORBObject;
begin
  o := _to_object;
  if assigned(o) then o.assign(obj);
end;


//***********************************************************************
//  TUnknownAbstract
//***********************************************************************
function TUnknownAbstract.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if FObject <> nil then
    result := FObject.narrow_helper(repoid)
  else if FValue <> nil then
    result := FValue.narrow_helper(repoid)
  else
    result := nil;
end;

function TUnknownAbstract._to_object: IORBObject;
begin
  result := FObject;
end;

function TUnknownAbstract._to_value: IValueBase;
begin
  result := FValue;
end;

constructor TUnknownAbstract.Create(obj: IORBObject);
begin
  inherited Create();
  FValue := nil;
  FObject := obj;
end;

constructor TUnknownAbstract.Create(val: IValueBase);
begin
  inherited Create();
  FObject := nil;
  FValue := val;
end;

///***********************************************************
// TStringValue
//***********************************************************
constructor TStringValue.Create(val: AnsiString);
begin
  inherited Create();
  FValue := val;
end;

constructor TStringValue.Create(val: IStringValue);
begin
  inherited Create();
  FValue := val._value;
end;

function TStringValue._value: AnsiString;
begin
  result := FValue;
end;

procedure TStringValue._value(val : AnsiString);
begin
  FValue := val;
end;

function TStringValue.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if strcomp(PAnsiChar(repoid),'IDL:omg.org/CORBA/StringValue:1.0') = 0 then
    result := Pointer(Self as IStringValue);
end;

class function TStringValue._downcast(const vb : IValueBase): IStringValue;
var
  ptr: pointer;
begin
  result := nil;
  if vb <> nil then
    begin
      ptr := vb.narrow_helper('IDL:omg.org/CORBA/StringValue:1.0');
      if ptr <> nil then
        result := IStringValue(ptr);
    end;
end;

procedure TStringValue._get_marshal_info(const str: TStrings; out chunked: Boolean);
begin
  str.Add('IDL:omg.org/CORBA/StringValue:1.0');
  chunked := false;
end;

procedure TStringValue._marshal_members(const enc: IEncoder);
begin
  stat_string.marshal(enc,@FValue);
end;

function  TStringValue._demarshal_members(const dec: IDecoder): Boolean;
begin
  result := false;
  if not stat_string.demarshal(dec,@FValue) then exit;
  result := true;
end;

function  TStringValue._copy_value: IValueBase;
begin
  result := TStringValue.Create(self) as IValueBase;
end;

//***********************************************************
// TStringValue_marshaller
//***********************************************************
procedure TStringValue_marshaller._create(var addr: Pointer);
begin
  IStringValue(addr^) := TStringValue.Create as IStringValue;
end;

procedure TStringValue_marshaller._assign(dst, src: Pointer);
begin
  IStringValue(dst^) := IStringValue(src^);
end;

procedure TStringValue_marshaller._free(var addr: Pointer);
begin
  IStringValue(addr^) := nil;
end;

function TStringValue_marshaller.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  vb : IValueBase;
begin
  result := TValueBase._demarshal(dec,vb,'IDL:omg.org/CORBA/StringValue:1.0');
  if not result then exit;
  IStringValue(addr^) := TStringValue._downcast(vb);
  result := (vb = nil) or (vb <> nil) and (Pointer(addr^) <> nil);
end;

procedure TStringValue_marshaller.marshal(enc: IEncoder; const addr: Pointer);
begin
  TValueBase._marshal(enc,IStringValue(addr^) as IValueBase);
end;

function TStringValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_StringValue.typecode;
end;

//***********************************************************
// TWStringValue
//***********************************************************
constructor TWStringValue.Create(val: widestring);
begin
  inherited Create();
  FValue := val;
end;

constructor TWStringValue.Create(val: IWStringValue);
begin
  inherited Create();
  FValue := val._value;
end;

function TWStringValue._value: widestring;
begin
  result := FValue;
end;

procedure TWStringValue._value(val : widestring);
begin
  FValue := val;
end;

function TWStringValue.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if strcomp(PAnsiChar(repoid),'IDL:omg.org/CORBA/WStringValue:1.0') = 0 then
    result := Pointer(Self as IWStringValue);
end;

class function TWStringValue._downcast(const vb : IValueBase): IWStringValue;
var
  ptr: pointer;
begin
  result := nil;
  if vb <> nil then
    begin
      ptr := vb.narrow_helper('IDL:omg.org/CORBA/WStringValue:1.0');
      if ptr <> nil then
        result := IWStringValue(ptr);
    end;
end;

procedure TWStringValue._get_marshal_info(const str: TStrings; out chunked: Boolean);
begin
  str.Add('IDL:omg.org/CORBA/WStringValue:1.0');
  chunked := false;
end;

procedure TWStringValue._marshal_members(const enc: IEncoder);
begin
  stat_widestring.marshal(enc,@FValue);
end;

function  TWStringValue._demarshal_members(const dec: IDecoder): Boolean;
begin
  result := false;
  if not stat_widestring.demarshal(dec,@FValue) then exit;
  result := true;
end;

function  TWStringValue._copy_value: IValueBase;
begin
  result := TWStringValue.Create(self) as IValueBase;
end;

//***********************************************************
// TWStringValue_marshaller
//***********************************************************
procedure TWStringValue_marshaller._create(var addr: Pointer);
begin
  IWStringValue(addr^) := TWStringValue.Create as IWStringValue;
end;

procedure TWStringValue_marshaller._assign(dst, src: Pointer);
begin
  IWStringValue(dst^) := IWStringValue(src^);
end;

procedure TWStringValue_marshaller._free(var addr: Pointer);
begin
  IWStringValue(addr^) := nil;
end;

function TWStringValue_marshaller.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  vb : IValueBase;
begin
  result := TValueBase._demarshal(dec,vb,'IDL:omg.org/CORBA/WStringValue:1.0');
  if not result then exit;
  IWStringValue(addr^) := TWStringValue._downcast(vb);
  result := (vb = nil) or (vb <> nil) and (Pointer(addr^) <> nil);
end;

procedure TWStringValue_marshaller.marshal(enc: IEncoder; const addr: Pointer);
begin
  TValueBase._marshal(enc,IWStringValue(addr^) as IValueBase);
end;

function TWStringValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_WStringValue.typecode;
end;

{ TStringValueFactory }

function TStringValueFactory.create_for_umarshal: IValueBase;
begin
  Result := TStringValue.Create();
end;

{ TWStringValueFactory }

function TWStringValueFactory.create_for_umarshal: IValueBase;
begin
  Result := TWStringValue.Create();
end;

initialization
  StringValue_marshaller := TStringValue_marshaller.Create();
  WStringValue_marshaller := TWStringValue_marshaller.Create();
  _tc_StringValue := CreateTypeCodeConst('010000001e00000044000000010000002200000049444c3a6f6d672e6f72672f434f5242412f537472696e6756616c75653a312e300000'+
    '000c000000537472696e6756616c7565001200000000000000');
  _tc_WStringValue := CreateTypeCodeConst('010000001e00000048000000010000002300000049444c3a6f6d672e6f72672f434f5242412f57537472696e6756616c75653a312e3000'+
    '000d00000057537472696e6756616c7565000000001b00000000000000');
end.
