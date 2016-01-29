unit K517772970_TddBaseStatusRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddBaseStatusRequest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddBaseStatusRequest
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
 TK517772970_TddBaseStatusRequest = class(TK517772970_TddRequestTask)
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
 end;//TK517772970_TddBaseStatusRequest
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csBaseStatusRequest
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TddBaseStatusRequest

{$If defined(nsTest)}
function TK517772970_TddBaseStatusRequest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddBaseStatusRequest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddBaseStatusRequest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53202365007E';
end;//TK517772970_TddBaseStatusRequest.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TddBaseStatusRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53202365007E_var*
//#UC END# *5320088202FB_53202365007E_var*
begin
//#UC START# *5320088202FB_53202365007E_impl*
 result := TddBaseStatusRequest;
//#UC END# *5320088202FB_53202365007E_impl*
end;//TK517772970_TddBaseStatusRequest.TaskClass

procedure TK517772970_TddBaseStatusRequest.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53202365007E_var*
//#UC END# *532008D203BA_53202365007E_var*
begin
//#UC START# *532008D203BA_53202365007E_impl*
 inherited InitTask(Task);
 with (Task as TddBaseStatusRequest) do begin
  IsFree := true;
  Message := ClassName;
 end;
//#UC END# *532008D203BA_53202365007E_impl*
end;//TK517772970_TddBaseStatusRequest.InitTask

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddBaseStatusRequest.Suite);

end.