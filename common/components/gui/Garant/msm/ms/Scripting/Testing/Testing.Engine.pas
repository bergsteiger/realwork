unit Testing.Engine;

interface

{$IfNDef NoTesting}
uses
 System.Classes,
 Core.Obj
 ;

type
 TtestSocket = record
  {* - ����������� ����� }
  private
   rClass: TClass;
   rMethod: String;
  public
   constructor Create(anObject: TObject; const aMethod: String);
    {* - ������ ��������� ����������� �����. }
   function EQ(const anOther: TtestSocket): Boolean;
    {* - ���������� ��� ����, ��� ����������� ����� - ����������� }
 end;//TtestSocket

 TtestValueType = (test_vtChar, test_vtString);
  {* - ��������� ���� ���������� �������� }

 TtestValue = record
  {* - ���������� �������� }
  private
   rType : TtestValueType;
    {* - ��� ����������� ����������� ��������. }
   rAsString : AnsiString;
   rAsChar : AnsiChar;
  public
   constructor CreateAsChar(aChar: AnsiChar);
   constructor CreateAsString(const aString: AnsiString);
 end;//TtestValue

 TtestMetricValues = record
  {* - ����� �������� ��� �������. }
  private
   f_Stream : TStream;
    {* ���������� ����� ���� ������������ �������� �������. }
  public
   procedure Init(const aTestName: String; const aSocket: TtestSocket);
    {* - �������������� ����� �������� ��� ������� }
   procedure FlushAndClear;
    {* - ���������� ����� �� ���������� �������� � ����������� ���. }
   procedure PutValue(const aValue: TtestValue);
    {* - ���������� ������� �������� � ����� �������� ��� ������� }
 end;//TtestMetricValues

 TtestSocketMetric = record
  {* - ���������� �������. }
  private
   rSocket : TtestSocket;
    {* - ����������� ����� � ������� ��������� ������� }
   rValues : TtestMetricValues;
    {* - ������� ����� ��������, ������� ���� � ����������� ����� }
  public
   constructor Create(const aTestName: String; const aSocket: TtestSocket);
   function EQ(const anOther: TtestSocket): Boolean;
    {* - ��������� ��� ����, ��� ������� ��������� � ������ ����������� ����� }
   procedure FlushAndClear;
    {* - ���������� ������� �� ���������� �������� � ����������� �. }
   procedure PutValue(const aValue: TtestValue); overload;
    {* - ���������� ������� �������� � ����� �������� ��� ������� }
   procedure PutValue(const aValue: String); overload;
    {* - ���������� ������� �������� � ����� �������� ��� ������� }
   procedure PutValue(const aValue: AnsiChar); overload;
    {* - ���������� ������� �������� � ����� �������� ��� ������� }
 end;//TtestSocketMetric
 PtestMetric = ^TtestSocketMetric;

 TtestMetrics = array of TtestSocketMetric;
  {* - ��� ������� ��������� � ���������� ������������ }

 TtestInstance = class(TCoreObject)
  {* - ����������� }
  private
   f_TestName : String;
   f_Metrics : TtestMetrics;
  protected
   procedure Cleanup; override;
  public
   constructor Create(const aTestName: String);
   function SocketMetric(const aSocket: TtestSocket): PtestMetric;
    {* - ���������� ��������� ������� ������� ��� ������ "����������� �����", ��� ��������� ������ � ��� }
 end;//TtestInstance

 TtestEngine = class
  {* - ������ ��� ������������ }
  public
   class function StartTest(const aTestName: String): TtestInstance;
    {* - �������� ���� (�����������) }
   class procedure StopTest;
    {* - ��������� ������� ����������� }
   class function CurrentTest: TtestInstance;
    {* - ������� ���������� ����������� }
 end;
{$EndIf NoTesting}

implementation

{$IfNDef NoTesting}

uses
 System.SysUtils
 ;

var
 g_CurrentTest : TtestInstance = nil;

constructor TtestValue.CreateAsChar(aChar: AnsiChar);
begin
 inherited;
 rType := test_vtChar;
 rAsChar := aChar;
end;

constructor TtestValue.CreateAsString(const aString: AnsiString);
begin
 inherited;
 rType := test_vtString;
 rAsString := aString;
end;

constructor TtestSocket.Create(anObject: TObject; const aMethod: String);
begin
 inherited;
 rClass := anObject.ClassType;
 rMethod := aMethod;
end;

function TtestSocket.EQ(const anOther: TtestSocket): Boolean;
 {* - ���������� ��� ����, ��� ����������� ����� - ����������� }
begin
 Result := (Self.rClass = anOther.rClass) AND (Self.rMethod = anOther.rMethod);
end;

constructor TtestSocketMetric.Create(const aTestName: String; const aSocket: TtestSocket);
begin
 inherited;
 rSocket := aSocket;
 rValues.Init(aTestName, aSocket);
end;

function TtestSocketMetric.EQ(const anOther: TtestSocket): Boolean;
 {* - ��������� ��� ����, ��� ������� ��������� � ������ ����������� ����� }
begin
 Result := Self.rSocket.EQ(anOther);
end;

procedure TtestSocketMetric.FlushAndClear;
 {* - ���������� ������� �� ���������� �������� � ����������� �. }
begin
 Self.rValues.FlushAndClear;
end;

procedure TtestSocketMetric.PutValue(const aValue: TtestValue);
 {* - ���������� ������� �������� � ����� �������� ��� ������� }
begin
 Self.rValues.PutValue(aValue);
end;

procedure TtestSocketMetric.PutValue(const aValue: String);
 {* - ���������� ������� �������� � ����� �������� ��� ������� }
begin
 if (@Self = nil) then
  Exit;
 Self.rValues.PutValue(TtestValue.CreateAsString(aValue));
end;

procedure  TtestSocketMetric.PutValue(const aValue: AnsiChar);
 {* - ���������� ������� �������� � ����� �������� ��� ������� }
begin
 if (@Self = nil) then
  Exit;
 Self.rValues.PutValue(TtestValue.CreateAsChar(aValue));
end;

procedure TtestMetricValues.Init(const aTestName: String; const aSocket: TtestSocket);
 {* - �������������� ����� �������� ��� ������� }
begin
 f_Stream := TFileStream.Create(ExtractFilePath(ParamStr(0)) + '\' +
                                ExtractFileName(ParamStr(0)) + '.' +
                                ExtractFileName(aTestName) +
                                '.' + aSocket.rClass.ClassName +
                                '.' + aSocket.rMethod +
                                '.out', fmCreate);
end;

procedure TtestMetricValues.FlushAndClear;
 {* - ���������� ����� �� ���������� �������� � ����������� ���. }
begin
 FreeAndNil(f_Stream);
end;

procedure TtestMetricValues.PutValue(const aValue: TtestValue);
 {* - ���������� ������� �������� � ����� �������� ��� ������� }
const
 cEOL : AnsiString = #13#10;
begin
 if (@Self = nil) then
  Exit;
 Assert(f_Stream <> nil, '���� ��� ������ �������� ������� �� ������');
 case aValue.rType of
  test_vtChar:
   f_Stream.Write(@aValue.rAsChar, SizeOf(aValue.rAsChar));
  test_vtString:
  begin
   f_Stream.Write(@aValue.rAsString[1], Length(aValue.rAsString));
   f_Stream.Write(@cEOL[1], Length(cEOL));
  end;//test_vtString
  else
   Assert(false, '����������� ��� �������� �������');
 end;
end;

constructor TtestInstance.Create(const aTestName: String);
begin
 Assert(g_CurrentTest = nil, '��������� ������������ �� ��������������');
 f_TestName := aTestName;
 inherited Create;
 g_CurrentTest := Self;
end;

procedure TtestInstance.Cleanup;
var
 l_Index : Integer;
begin
 for l_Index := Low(f_Metrics) to High(f_Metrics) do
  f_Metrics[l_Index].FlushAndClear;
 Finalize(f_Metrics);
 inherited;
end;

function TtestInstance.SocketMetric(const aSocket: TtestSocket): PtestMetric;
 {* - ���������� ��������� ������� ������� ��� ������ "����������� �����", ��� ��������� ������ � ��� }
var
 l_Index : Integer;
begin
 if (Self = nil) then
 begin
  Result := nil;
  Exit;
 end;//Self = nil
 for l_Index := Low(f_Metrics) to High(f_Metrics) do
  if f_Metrics[l_Index].EQ(aSocket) then
  begin
   Result := @f_Metrics[l_Index];
   Exit;
  end;//f_Metrics[l_Index].EQ(aSocket)
 SetLength(f_Metrics, Succ(Length(f_Metrics)));
 f_Metrics[High(f_Metrics)] := TtestSocketMetric.Create(f_TestName, aSocket);
 Result := @f_Metrics[High(f_Metrics)];
end;

class function TtestEngine.StartTest(const aTestName: String): TtestInstance;
 {* - �������� ���� (�����������)}
begin
 Result := TtestInstance.Create(aTestName);
end;

class procedure TtestEngine.StopTest;
 {* - ��������� ������� ����������� }
begin
 Assert(g_CurrentTest <> nil, '���-�� ����� �� ���. ��� �������� ������������');
 FreeAndNil(g_CurrentTest);
end;

class function TtestEngine.CurrentTest: TtestInstance;
 {* - ������� ���������� �����������}
begin
 Result := g_CurrentTest;
end;
{$EndIf  NoTesting}

end.
