unit K517772970_TddClientMessage;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddClientMessage.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TddClientMessage" MUID: (53200C460255)
// Имя типа: "TK517772970_TddClientMessage"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddRequestTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddClientMessage = class(TK517772970_TddRequestTask)
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
   function CreateTask(aUserID: LongWord): TddTaskItem; override;
 end;//TK517772970_TddClientMessage
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csClientMessageRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsNotification
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TddClientMessage.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddClientMessage.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddClientMessage.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53200C460255';
end;//TK517772970_TddClientMessage.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TddClientMessage.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53200C460255_var*
//#UC END# *5320088202FB_53200C460255_var*
begin
//#UC START# *5320088202FB_53200C460255_impl*
 Result := TddClientMessage;
//#UC END# *5320088202FB_53200C460255_impl*
end;//TK517772970_TddClientMessage.TaskClass

procedure TK517772970_TddClientMessage.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53200C460255_var*
(*const
 IntConst = 12345;
 NotificationType = ntUserLogin;*)
//#UC END# *532008D203BA_53200C460255_var*
begin
//#UC START# *532008D203BA_53200C460255_impl*
 inherited InitTask(Task);
(* with (Task as TddClientMessage) do
 begin
  NotifyType := NotificationType;
  Data := IntConst;
  Text := ClassName;
 end;*)
//#UC END# *532008D203BA_53200C460255_impl*
end;//TK517772970_TddClientMessage.InitTask

function TK517772970_TddClientMessage.CreateTask(aUserID: LongWord): TddTaskItem;
//#UC START# *5388508D03DE_53200C460255_var*
const
 IntConst = 12345;
 NotificationType = ntUserLogin;
//#UC END# *5388508D03DE_53200C460255_var*
begin
//#UC START# *5388508D03DE_53200C460255_impl*
 Result := TddClientMessage.Create(aUserID, IntConst, NotificationType, ClassName);
//#UC END# *5388508D03DE_53200C460255_impl*
end;//TK517772970_TddClientMessage.CreateTask

initialization
 TestFramework.RegisterTest(TK517772970_TddClientMessage.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
