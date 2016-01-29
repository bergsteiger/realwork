unit java_utils;

interface

uses EJB, EJB_int, value, value_int, orb_int, seq1_octet_org_omg_boxedRMI,
  seq1_octet_org_omg_boxedRMI_int, orbtypes, seq1_long_org_omg_boxedRMI_int,
  seq1_long_org_omg_boxedRMI;

type
  TStackTraceElementFactory = class(TValueFactoryBase, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  TStackTraceElementImpl = class(Tjava_lang_StackTraceElement);

  TStackTraceElementSeqFactory = class(TValueFactoryBase, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  TSeqStackTraceElementImpl = class(Tjava_lang_seq1_StackTraceElement);

  TOctetSeqFactory = class(TValueFactoryBase, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  TSeqOctetElementImpl = class(Torg_omg_boxedRMI_seq1_octet);

  TJavaLangIntegerFactory = class(TValueFactoryBase, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  TJavaLangIntegerSeqFactory = class(TValueFactoryBase, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  TJavaLangIntegerImpl = class(Tjava_lang_Integer);

  TJavaLangLongFactory = class(TValueFactoryBase, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  TJavaLangLongImpl = class(Tjava_lang_Long);

procedure RegisterValueFactory(const AOrb: IORB);

function StringToWStringValue(const Str: WideString): IWStringValue;
function WStringValueToString(const WStrValue: IWStringValue): WideString;
function StringToStringValue(const Str: string): IStringValue;
function StringValueToString(const StrValue: IStringValue): string;

function VariantToJavaObject(const AVariant: Variant): Tjava_lang_Object;
function JavaObjectToVariant(const AJavaObject: Tjava_lang_Object): Variant;

function OctetSeqToBoxedRMI(const Seq: OctetSeq): Iorg_omg_boxedRMI_seq1_octet;
function LongSeqToBoxedRMI(const Seq: LongSeq): Iorg_omg_boxedRMI_seq1_long;

implementation

uses Variants, SysUtils, any, tcode;

procedure RegisterValueFactory(const AOrb: IORB);
begin
  AOrb.register_value_factory('RMI:java.lang.StackTraceElement:CD38F9930EA8AAEC:6109C59A2636DD85', TStackTraceElementFactory.Create());
  AOrb.register_value_factory('RMI:[Ljava.lang.StackTraceElement;:CD38F9930EA8AAEC:6109C59A2636DD85', TStackTraceElementSeqFactory.Create());
  AOrb.register_value_factory('RMI:[B:0000000000000000', TOctetSeqFactory.Create());
  AOrb.register_value_factory('RMI:java.lang.Integer:47693FFB4FE579F4:12E2A0A4F7818738', TJavaLangIntegerFactory.Create());
  AOrb.register_value_factory('RMI:java.lang.Long:205F6CCF002E6E90:3B8BE490CC8F23DF', TJavaLangLongFactory.Create());
  AOrb.register_value_factory('RMI:[I:0000000000000000', TJavaLangIntegerSeqFactory.Create);
end;

function StringToWStringValue(const Str: WideString): IWStringValue;
begin
  Result := TWStringValue.Create(Str);
end;

function WStringValueToString(const WStrValue: IWStringValue): WideString;
begin
  Result := WStrValue._value();
end;

function StringToStringValue(const Str: string): IStringValue;
begin
  Result := TStringValue.Create(Str);
end;

function StringValueToString(const StrValue: IStringValue): string;
begin
  Result := StrValue._value();
end;

function VariantToJavaObject(const AVariant: Variant): Tjava_lang_Object;
var
  valueInt: Ijava_lang_Integer;
  valueStr: IWStringValue;
begin
  if VarIsNull(AVariant) or VarIsEmpty(AVariant) then begin
    Result := TAny.Create();
    Result.replace(TTypeCode.Create(tk_null));
  end
  else
    case VarType(AVariant) of
      varInteger: begin
        valueInt := TJavaLangIntegerImpl.Create();
        valueInt.value(AVariant);
        Result := java_lang_Integer_to_any(valueInt);
      end;
      varString, varOleStr: begin
        valueStr := StringToWStringValue(AVariant);
        Result := WStringValue_to_any(valueStr);
      end;
    else
      raise Exception.CreateFmt('Not implemented: Variant type %d', [VarType(AVariant)]);
    end;
end;

function JavaObjectToVariant(const AJavaObject: Tjava_lang_Object): Variant;
var
  valueInt: Ijava_lang_Integer;
  valueLong: Ijava_lang_Long;
  valueWideStr: IWStringValue;
  intf: IInterface;
begin
  if AJavaObject.tc.kind = tk_null then
    Result := Null
  else if AJavaObject.tc.kind = tk_void then
    Result := Unassigned
  else if AJavaObject.tc.equal(java_lang_Integer_marshaller.typecode) then begin
    any_to_java_lang_Integer(AJavaObject, valueInt);
    Result := valueInt.value;
  end
  else if AJavaObject.tc.equal(java_lang_Long_marshaller.typecode) then begin
    any_to_java_lang_Long(AJavaObject, valueLong);
    Result := valueLong.value;
  end
  else if {AJavaObject.tc.equal(WStringValue_marshaller.typecode)}AJavaObject.tc.repoid = WStringValue_marshaller.typecode.repoid then begin
    //workaround features in java ORB
    {any_to_WStringValue(AJavaObject, valueWideStr);
    Result := WStringValueToString(valueWideStr);}
    AJavaObject.get_value(intf);
    Result := (intf as IWStringValue)._value;
  end
  else
    raise Exception.CreateFmt('Not implemented: Java type %s', [AJavaObject.tc.repoid]);
end;

function OctetSeqToBoxedRMI(const Seq: OctetSeq): Iorg_omg_boxedRMI_seq1_octet;
begin
  Result := Torg_omg_boxedRMI_seq1_octet.Create(Seq);
end;

function LongSeqToBoxedRMI(const Seq: LongSeq): Iorg_omg_boxedRMI_seq1_long;
begin
  Result := Torg_omg_boxedRMI_seq1_long.Create(Seq);
end;

{ TStackTraceElementFactory }

function TStackTraceElementFactory.create_for_umarshal: IValueBase;
begin
  Result := TStackTraceElementImpl.Create();
end;

{ TStackTraceElementSeqFactory }

function TStackTraceElementSeqFactory.create_for_umarshal: IValueBase;
begin
  Result := TSeqStackTraceElementImpl.Create();
end;

{ TOctetSeqFactory }

function TOctetSeqFactory.create_for_umarshal: IValueBase;
begin
  Result := TSeqOctetElementImpl.Create();
end;

{ TJavaLangIntegerFactory }

function TJavaLangIntegerFactory.create_for_umarshal: IValueBase;
begin
  Result := TJavaLangIntegerImpl.Create();
end;

{ TJavaLangLongFactory }

function TJavaLangLongFactory.create_for_umarshal: IValueBase;
begin
  Result := TJavaLangLongImpl.Create();
end;

{ TJavaLangIntegerSeqFactory }

function TJavaLangIntegerSeqFactory.create_for_umarshal: IValueBase;
begin
  Result := Torg_omg_boxedRMI_seq1_long.Create;
end;

end.
