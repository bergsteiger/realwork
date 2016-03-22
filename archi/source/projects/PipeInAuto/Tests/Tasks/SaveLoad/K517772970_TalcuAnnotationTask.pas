unit K517772970_TalcuAnnotationTask;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAnnotationTask.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TalcuAnnotationTask" MUID: (53214E9A00C3)
// ��� ����: "TK517772970_TalcuAnnotationTask"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddProcessTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TalcuAnnotationTask = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TalcuAnnotationTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuAnnotationTask
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TalcuAnnotationTask.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuAnnotationTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuAnnotationTask.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53214E9A00C3';
end;//TK517772970_TalcuAnnotationTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TalcuAnnotationTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214E9A00C3_var*
//#UC END# *5320088202FB_53214E9A00C3_var*
begin
//#UC START# *5320088202FB_53214E9A00C3_impl*
 result := TalcuAnnotationTask;
//#UC END# *5320088202FB_53214E9A00C3_impl*
end;//TK517772970_TalcuAnnotationTask.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAnnotationTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
