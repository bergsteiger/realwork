unit TestImpl;

interface

uses Test, Test_int, orbtypes, orb_int, poa, mtdebug, SysUtils;

type
  TTestIntfFactory_impl = class(TTestIntfFactory_serv)
  protected
    function create_test_intf: ITestIntf; override;
  end;

  TTestIntf_impl = class(TTestIntf_serv)
  protected
    function check_short(const value_in: short; var value_inout: short; out value_out: short): short; override;
    function check_long(const value_in: long; var value_inout: long; out value_out: long): long; override;
    function check_unsigned_short(const value_in: _ushort; var value_inout: _ushort; out value_out: _ushort): _ushort; override;
    function check_unsigned_long(const value_in: _ulong; var value_inout: _ulong; out value_out: _ulong): _ulong; override;
    function check_float(const value_in: float; var value_inout: float; out value_out: float): float; override;
    function check_double(const value_in: double; var value_inout: double; out value_out: double): double; override;
    function check_boolean(const value_in: boolean; var value_inout: boolean; out value_out: boolean): boolean; override;
    function check_char(const value_in: AnsiChar; var value_inout: AnsiChar; out value_out: AnsiChar): AnsiChar; override;
    function check_octet(const value_in: octet; var value_inout: octet; out value_out: octet): octet; override;
    function check_string(const value_in: AnsiString; var value_inout: AnsiString; out value_out: AnsiString): AnsiString; override;
    function check_longlong(const value_in: longlong; var value_inout: longlong; out value_out: longlong): longlong; override;
    function check_unsigned_longlong(const value_in: _ulonglong; var value_inout: _ulonglong; out value_out: _ulonglong): _ulonglong; override;
    function check_wchar(const value_in: widechar; var value_inout: widechar; out value_out: widechar): widechar; override;
    function check_wstring(const value_in: widestring; var value_inout: widestring; out value_out: widestring): widestring; override;
    function check_octet_seq(const value_in: TTestOctetSeq; var value_inout: TTestOctetSeq; out value_out: TTestOctetSeq): TTestOctetSeq; override;
    function check_struct(const value_in: TTestStruct; var value_inout: TTestStruct; out value_out: TTestStruct): TTestStruct; override;
    function check_enum(const value_in: TTestEnum; var value_inout: TTestEnum; out value_out: TTestEnum): TTestEnum; override;
    function check_obj(const value_in: ITestIntf; var value_inout: ITestIntf; out value_out: ITestIntf): ITestIntf; override;
    procedure check_exception(const mes: AnsiString); override;
    procedure deactivate; override;
  //public
    //constructor Create(const );
  end;

implementation

procedure CheckTestIntf(const ATest: ITestIntf);
var
  i: Integer;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  longValIn, longValInOut, longValOut, longValResult: long;
  ushortValIn, ushortValInOut, ushortValOut, ushortValResult: _ushort;
  octetSeqValIn, octetSeqValInOut, octetSeqValOut, octetSeqValResult: TTestOctetSeq;
  {ulongValIn, ulongValInOut, ulongValOut, ulongValResult: _ulong;
  {booleanValIn, booleanValInOut, booleanValOut, booleanValResult: boolean;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;}
begin
  shortValIn := Trunc(Random(High(short)));
  shortValInOut := shortValIn;
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');
  longValIn := Trunc(Random(High(long)));
  longValInOut := longValIn;
  longValResult := ATest.check_long(longValIn, longValInOut, longValOut);
  if longValIn <> longValResult then
    MTDORBLogger.Error('Client callback. Mismatch long value.');
  ushortValIn := Trunc(Random(High(_ushort)));
  ushortValInOut := ushortValIn;
  ushortValResult := ATest.check_unsigned_short(ushortValIn, ushortValInOut, ushortValOut);
  if ushortValIn <> ushortValResult then
    MTDORBLogger.Error('Client callback. Mismatch unsigned short value.');
  SetLength(octetSeqValIn, 1024{*1024*5});
  for i := 0 to Length(octetSeqValIn) - 1 do
    octetSeqValIn[i] := octet(Trunc(Random(Ord(High(octet)))));
  octetSeqValInOut := Copy(octetSeqValIn, 0, Length(octetSeqValIn));
  octetSeqValResult := ATest.check_octet_seq(octetSeqValIn, octetSeqValInOut, octetSeqValOut);
  if not CompareMem(octetSeqValIn, octetSeqValResult, Length(octetSeqValInOut)) then
    MTDORBLogger.Error('Client callback. Mismatch octet sequence value.');
  {ulongValIn := Trunc(Random(High(_ulong)));
  ulongValResult := ATest.check_unsigned_long(ulongValIn, ulongValInOut, ulongValOut);
  if ulongValIn <> ulongValResult then
    MTDORBLogger.Error('Client callback. Mismatch unsigned long value.');
  booleanValIn := Trunc(Random(High(boolean)));
  booleanValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');
  shortValIn := Trunc(Random(High(short)));
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');
  shortValIn := Trunc(Random(High(short)));
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');
  shortValIn := Trunc(Random(High(short)));
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');
  shortValIn := Trunc(Random(High(short)));
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');
  shortValIn := Trunc(Random(High(short)));
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');
  shortValIn := Trunc(Random(High(short)));
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Client callback. Mismatch short value.');}
end;

{ TTestIntfFactory_impl }

function TTestIntfFactory_impl.create_test_intf: ITestIntf;
var
  ref: IORBObject;
begin
  ref := FPoa.servant_to_reference(TTestIntf_impl.Create);
  Result := TTestIntf._narrow(ref);
end;

{ TTestIntf_impl }

function TTestIntf_impl.check_boolean(const value_in: boolean;
  var value_inout: boolean; out value_out: boolean): boolean;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch boolean value. %d <> %d', [Ord(value_in), Ord(value_inout)])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_char(const value_in: AnsiChar;
  var value_inout: AnsiChar; out value_out: AnsiChar): AnsiChar;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch char value. %s <> %s', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_double(const value_in: double;
  var value_inout: double; out value_out: double): double;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch double value. %n <> %n', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_enum(const value_in: TTestEnum;
  var value_inout: TTestEnum; out value_out: TTestEnum): TTestEnum;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch enum value. %d <> %d', [Ord(value_in), Ord(value_inout)])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

procedure TTestIntf_impl.check_exception(const mes: AnsiString);
begin
  raise TTestException.Create(mes);
end;

function TTestIntf_impl.check_float(const value_in: float;
  var value_inout: float; out value_out: float): float;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch float value. %n <> %n', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_long(const value_in: long;
  var value_inout: long; out value_out: long): long;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch long value. %d <> %d', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_longlong(const value_in: longlong;
  var value_inout: longlong; out value_out: longlong): longlong;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch longlong value. %d <> %d', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_obj(const value_in: ITestIntf;
  var value_inout: ITestIntf; out value_out: ITestIntf): ITestIntf;
begin
  Result := value_in;
  value_out := value_in;
  CheckTestIntf(value_in);
end;

function TTestIntf_impl.check_octet(const value_in: octet;
  var value_inout: octet; out value_out: octet): octet;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch octet value. %d <> %d', [Ord(value_in), Ord(value_inout)])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_octet_seq(const value_in: TTestOctetSeq;
  var value_inout: TTestOctetSeq;
  out value_out: TTestOctetSeq): TTestOctetSeq;
begin
  if not CompareMem(value_in, value_inout, Length(value_in)) then
    MTDORBLogger.Error('Mismatch octet sequence value');
  Result := Copy(value_in, 0, Length(value_in));
  value_inout := Copy(value_in, 0, Length(value_in));
  value_out := Copy(value_in, 0, Length(value_in));
end;

function TTestIntf_impl.check_short(const value_in: short;
  var value_inout: short; out value_out: short): short;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch short value. %d <> %d', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_string(const value_in: AnsiString;
  var value_inout: AnsiString; out value_out: AnsiString): AnsiString;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch string value. %s <> %s', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_struct(const value_in: TTestStruct;
  var value_inout: TTestStruct; out value_out: TTestStruct): TTestStruct;
begin
  if (value_in.value_long <> value_inout.value_long) or (value_in.value_string <> value_inout.value_string) then
    MTDORBLogger.Error('Mismatch struct value');
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_unsigned_long(const value_in: _ulong;
  var value_inout: _ulong; out value_out: _ulong): _ulong;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch unsigned long value. %d <> %d', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_unsigned_longlong(const value_in: _ulonglong;
  var value_inout: _ulonglong; out value_out: _ulonglong): _ulonglong;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch unsigned longlong value. %d <> %d', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_unsigned_short(const value_in: _ushort;
  var value_inout: _ushort; out value_out: _ushort): _ushort;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch unsigned short value. %d <> %d', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_wchar(const value_in: widechar;
  var value_inout: widechar; out value_out: widechar): widechar;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch widechar value. %d <> %d', [Ord(value_in), Ord(value_inout)])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

function TTestIntf_impl.check_wstring(const value_in: widestring;
  var value_inout: widestring; out value_out: widestring): widestring;
begin
  if value_in <> value_inout then
    MTDORBLogger.Error(AnsiString(Format('Mismatch widestring value. %s <> %s', [value_in, value_inout])));
  Result := value_in;
  value_inout := value_in;
  value_out := value_in;
end;

procedure TTestIntf_impl.deactivate;
begin
  if POA_Current.iscurrent then
    FPOA.deactivate_object(POA_Current.get_object_id());
end;

end.
