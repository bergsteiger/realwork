unit K517772970_TddGetTaskRequestDefault;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddGetTaskRequestDefault.pas"
// ���������: "TestCase"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

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
 TK517772970_TddGetTaskRequestDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TddGetTaskRequestDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csTaskRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
;

function TK517772970_TddGetTaskRequestDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_5319795B02BD_var*
//#UC END# *53170E4100CF_5319795B02BD_var*
begin
//#UC START# *53170E4100CF_5319795B02BD_impl*
 result := TddGetTaskRequest;
//#UC END# *53170E4100CF_5319795B02BD_impl*
end;//TK517772970_TddGetTaskRequestDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TddGetTaskRequestDefault.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TddGetTaskRequestDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddGetTaskRequestDefault.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5319795B02BD';
end;//TK517772970_TddGetTaskRequestDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddGetTaskRequestDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
