unit K517772970_TGetDictEditQuery;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TGetDictEditQuery.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TGetDictEditQuery" MUID: (532186F3030B)
// ��� ����: "TK517772970_TGetDictEditQuery"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TDictEditQuery
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TGetDictEditQuery = class(TK517772970_TDictEditQuery)
  {* [RequestLink:517772970] }
  protected
   function TaskClass: TddTaskClass; override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TGetDictEditQuery
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csServerTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

function TK517772970_TGetDictEditQuery.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532186F3030B_var*
//#UC END# *5320088202FB_532186F3030B_var*
begin
//#UC START# *5320088202FB_532186F3030B_impl*
 result := TGetDictEditQuery;
//#UC END# *5320088202FB_532186F3030B_impl*
end;//TK517772970_TGetDictEditQuery.TaskClass

{$If Defined(nsTest)}
function TK517772970_TGetDictEditQuery.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TGetDictEditQuery.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TGetDictEditQuery.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '532186F3030B';
end;//TK517772970_TGetDictEditQuery.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TGetDictEditQuery.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
