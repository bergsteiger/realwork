unit atAdapterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Runner/atAdapterTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Runner::TatAdapterTest
//
// �����, ����� ������� ��������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  SysUtils,
  atScenario,
  atAdapterTestCommandLine
  ;

type
 ECantCreateScenario = class(Exception)
 end;//ECantCreateScenario

 TatAdapterTest = class(TObject)
  {* �����, ����� ������� ��������� ���������� }
 private
 // private fields
   f_UserName : AnsiString;
    {* ��� ������������}
   f_Password : AnsiString;
    {* ������ ������������}
   f_CommandLine : TatAdapterTestCommandLine;
   f_Scenario : TatScenario;
    {* ����������� �������� (������������������ ��������)}
 private
 // private methods
   function Init: Boolean; virtual;
   procedure CreateScenario; virtual;
   procedure PlayScenario; virtual;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   procedure Start; virtual;
   constructor Create; reintroduce;
 end;//TatAdapterTest

implementation

uses
  atLogger,
  atXMLScenarioGenerator,
  atScenarioPlayer
  ;

// start class TatAdapterTest

function TatAdapterTest.Init: Boolean;
//#UC START# *4AC3492402F9_4AC3488802F7_var*
//#UC END# *4AC3492402F9_4AC3488802F7_var*
begin
//#UC START# *4AC3492402F9_4AC3488802F7_impl*
  //  ���������, ��� �� ����������� ��������� ��������� ������ ��������
  if NOT f_CommandLine.IsAllRequiredSet then
  begin // ��������, ���� ���
    Logger.Error('������ �� ��� ����������� ��������� ��������� ������!');
    f_CommandLine.PrintUsageInfo;
    Result := false;
    Exit;
  end;
  //
  // ��������� ��������� ������
  f_UserName := f_CommandLine.Parameters[CLP_LOGIN].AsStr;
  f_Password := f_CommandLine.Parameters[CLP_PASSWORD].AsStr;
  //
  // �������������� ����� � ��� ����, ���� �� �����
  with f_CommandLine.Parameters[CLP_LOGFILENAME] do
    if IsSet then
      Logger := TatFileLogger.Create(AsStr);
  Result := true;
//#UC END# *4AC3492402F9_4AC3488802F7_impl*
end;//TatAdapterTest.Init

procedure TatAdapterTest.CreateScenario;
//#UC START# *4AC349310110_4AC3488802F7_var*
  var
    scenarioFileName : String;
    generator : TatXMLScenarioGenerator;
//#UC END# *4AC349310110_4AC3488802F7_var*
begin
//#UC START# *4AC349310110_4AC3488802F7_impl*
  scenarioFileName := f_CommandLine.Parameters[CLP_SCENARIOFILENAME].AsStr;
  if NOT FileExists(scenarioFileName) then
    Raise ECantCreateScenario.Create(Logger.Error('���� �������� �� ������!'));
  //
  generator := TatXMLScenarioGenerator.Create;
  f_Scenario := TatScenario.Create;
  try
    generator.FillScenario(f_Scenario, scenarioFileName);
  finally
    FreeAndNil(generator);
  end;
//#UC END# *4AC349310110_4AC3488802F7_impl*
end;//TatAdapterTest.CreateScenario

procedure TatAdapterTest.PlayScenario;
//#UC START# *4AC3494000AA_4AC3488802F7_var*
  var
    player : TatScenarioPlayer;
//#UC END# *4AC3494000AA_4AC3488802F7_var*
begin
//#UC START# *4AC3494000AA_4AC3488802F7_impl*
  player := TatScenarioPlayer.Create(f_Scenario);
  try
    // �������������� �������� ����������
    with player.F_ExecutionContext do
    begin
      F_LoginData.Login := f_UserName;
      F_LoginData.Password := f_Password;
      //GblAdapterWorker := TatGblAdapterWorker.Instance;
    end;
    // ���������
    player.Execute;
  finally
    FreeAndNil(player);
  end;
//#UC END# *4AC3494000AA_4AC3488802F7_impl*
end;//TatAdapterTest.PlayScenario

procedure TatAdapterTest.Start;
//#UC START# *4AC3494903C7_4AC3488802F7_var*
//#UC END# *4AC3494903C7_4AC3488802F7_var*
begin
//#UC START# *4AC3494903C7_4AC3488802F7_impl*
  if NOT Init then Exit;
  //
  CreateScenario;
  //
  PlayScenario;
//#UC END# *4AC3494903C7_4AC3488802F7_impl*
end;//TatAdapterTest.Start

constructor TatAdapterTest.Create;
//#UC START# *4AC3495102C1_4AC3488802F7_var*
//#UC END# *4AC3495102C1_4AC3488802F7_var*
begin
//#UC START# *4AC3495102C1_4AC3488802F7_impl*
  inherited;
  //
  f_CommandLine := TatAdapterTestCommandLine.Create;
//#UC END# *4AC3495102C1_4AC3488802F7_impl*
end;//TatAdapterTest.Create

destructor TatAdapterTest.Destroy;
//#UC START# *48077504027E_4AC3488802F7_var*
//#UC END# *48077504027E_4AC3488802F7_var*
begin
//#UC START# *48077504027E_4AC3488802F7_impl*
  FreeAndNil(f_CommandLine);
  FreeAndNil(f_Scenario);
  inherited;
//#UC END# *48077504027E_4AC3488802F7_impl*
end;//TatAdapterTest.Destroy

end.