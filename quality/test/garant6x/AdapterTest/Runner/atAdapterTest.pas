unit atAdapterTest;
 {* �����, ����� ������� ��������� ���������� }

// ������: "w:\quality\test\garant6x\AdapterTest\Runner\atAdapterTest.pas"
// ���������: "SimpleClass"
// ������� ������: "TatAdapterTest" MUID: (4AC3488802F7)

interface

uses
 l3IntfUses
 , atAdapterTestCommandLine
 , atScenario
 , SysUtils
;

type
 ECantCreateScenario = class(Exception)
 end;//ECantCreateScenario

 TatAdapterTest = class(TObject)
  {* �����, ����� ������� ��������� ���������� }
  private
   f_UserName: AnsiString;
    {* ��� ������������ }
   f_Password: AnsiString;
    {* ������ ������������ }
   f_CommandLine: TatAdapterTestCommandLine;
   f_Scenario: TatScenario;
    {* ����������� �������� (������������������ ��������) }
  private
   function Init: Boolean; virtual;
   procedure CreateScenario; virtual;
   procedure PlayScenario; virtual;
  public
   procedure Start; virtual;
   constructor Create; reintroduce;
   destructor Destroy; override;
 end;//TatAdapterTest

implementation

uses
 l3ImplUses
 , atLogger
 , atXMLScenarioGenerator
 , atScenarioPlayer
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4AC3488802F7impl_uses*
 //#UC END# *4AC3488802F7impl_uses*
;

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(ECantCreateScenario));
 {* ����������� ���� ECantCreateScenario }
{$IfEnd} // NOT Defined(NoScripts)

end.
