unit K517772970_TddCaseCodeTaskDefault;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddCaseCodeTaskDefault.pas"
// ���������: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TCheckSaveToStreamDefault
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddCaseCodeTaskDefault = class(TK517772970_TCheckSaveToStreamDefault)
  {* [RequestLink:517772970] }
  protected
   function GetTaskClass: TddTaskClass; override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TddCaseCodeTaskDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , ddCaseCodeMaker
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
;

function TK517772970_TddCaseCodeTaskDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_5319775301A8_var*
//#UC END# *53170E4100CF_5319775301A8_var*
begin
//#UC START# *53170E4100CF_5319775301A8_impl*
 result := TddCaseCodeTask;
//#UC END# *53170E4100CF_5319775301A8_impl*
end;//TK517772970_TddCaseCodeTaskDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TddCaseCodeTaskDefault.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TddCaseCodeTaskDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddCaseCodeTaskDefault.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5319775301A8';
end;//TK517772970_TddCaseCodeTaskDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddCaseCodeTaskDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
