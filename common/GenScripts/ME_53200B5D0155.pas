unit K517772970_TddProcessTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddProcessTask.pas"
// Стереотип: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddTaskItem
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddProcessTask = class(TK517772970_TddTaskItem)
  {* [RequestLink:517772970] }
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
 end;//TK517772970_TddProcessTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TddProcessTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddProcessTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddProcessTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53200B5D0155';
end;//TK517772970_TddProcessTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TddProcessTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53200B5D0155_var*
//#UC END# *5320088202FB_53200B5D0155_var*
begin
//#UC START# *5320088202FB_53200B5D0155_impl*
 result := TddProcessTask;
//#UC END# *5320088202FB_53200B5D0155_impl*
end;//TK517772970_TddProcessTask.TaskClass

procedure TK517772970_TddProcessTask.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53200B5D0155_var*
const
 Const111 = 111;
 Const123 = 123;
 Const678 = 678;
//#UC END# *532008D203BA_53200B5D0155_var*
begin
//#UC START# *532008D203BA_53200B5D0155_impl*
 inherited InitTask(Task);
 with (Task as TddProcessTask) do
 begin
  RequestRun;
  //Status := cs_tsRun;
  Comment := ClassName;
  DocumentIDList.Add(Const111);
  DocumentIDList.Add(Const123);
  DocumentIDList.Add(Const678);
 end;
//#UC END# *532008D203BA_53200B5D0155_impl*
end;//TK517772970_TddProcessTask.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TddProcessTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
