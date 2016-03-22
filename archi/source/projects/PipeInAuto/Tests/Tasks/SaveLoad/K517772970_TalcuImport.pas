unit K517772970_TalcuImport;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuImport.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TalcuImport" MUID: (53218A6C0235)
// ��� ����: "TK517772970_TalcuImport"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TcsImportTaskItem
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TalcuImport = class(TK517772970_TcsImportTaskItem)
  {* [RequestLink:517772970] }
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
   function TaskClass: TddTaskClass; override;
 end;//TK517772970_TalcuImport
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuImport
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TalcuImport.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuImport.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuImport.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53218A6C0235';
end;//TK517772970_TalcuImport.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TalcuImport.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53218A6C0235_var*
//#UC END# *5320088202FB_53218A6C0235_var*
begin
//#UC START# *5320088202FB_53218A6C0235_impl*
 result := TalcuImport;
//#UC END# *5320088202FB_53218A6C0235_impl*
end;//TK517772970_TalcuImport.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TalcuImport.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
