unit K517772970_TddTaskItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddTaskItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddTaskItem
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
  K517772970_TCheckSaveToStream
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TddTaskItem = class(TK517772970_TCheckSaveToStream)
  {* [RequestLink:517772970] }
 protected
 // realized methods
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
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
 end;//TK517772970_TddTaskItem
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csTaskTypes
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  ,
  l3Filer,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TddTaskItem

function TK517772970_TddTaskItem.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53200B930243_var*
//#UC END# *5320088202FB_53200B930243_var*
begin
//#UC START# *5320088202FB_53200B930243_impl*
 Result := TddTaskItem;
//#UC END# *5320088202FB_53200B930243_impl*
end;//TK517772970_TddTaskItem.TaskClass

procedure TK517772970_TddTaskItem.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53200B930243_var*
//const
// VersionConst = 5;
// DateConst = 65000;
//#UC END# *532008D203BA_53200B930243_var*
begin
//#UC START# *532008D203BA_53200B930243_impl*
 with Task do
 begin
//  TaskType := cs_ttRequest;
//  Version := VersionConst;
//  Date := DateConst;
  Priority := 3;
  Description := ClassName;
 end;//with Task
//#UC END# *532008D203BA_53200B930243_impl*
end;//TK517772970_TddTaskItem.InitTask

{$If defined(nsTest)}
function TK517772970_TddTaskItem.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddTaskItem.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddTaskItem.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53200B930243';
end;//TK517772970_TddTaskItem.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddTaskItem.Suite);

end.