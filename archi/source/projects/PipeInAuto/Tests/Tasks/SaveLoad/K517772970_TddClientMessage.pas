unit K517772970_TddClientMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddClientMessage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddClientMessage
//
// {RequestLink:517772970}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  K517772970_TddRequestTask
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TddClientMessage = class(TK517772970_TddRequestTask)
  {* [RequestLink:517772970] }
 protected
 // overridden protected methods
   {$If defined(nsTest)}
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$IfEnd} //nsTest
   {$If defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} //nsTest
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
   function CreateTask(aUserID: LongWord): TddTaskItem; override;
 end;//TK517772970_TddClientMessage
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csClientMessageRequest
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  CsNotification
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TddClientMessage

{$If defined(nsTest)}
function TK517772970_TddClientMessage.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddClientMessage.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddClientMessage.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53200C460255';
end;//TK517772970_TddClientMessage.GetModelElementGUID
{$IfEnd} //nsTest

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

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddClientMessage.Suite);

end.