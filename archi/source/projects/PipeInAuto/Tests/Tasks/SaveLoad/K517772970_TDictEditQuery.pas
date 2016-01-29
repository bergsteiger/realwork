unit K517772970_TDictEditQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TDictEditQuery.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TDictEditQuery
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
  K517772970_TddProcessTask
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TDictEditQuery = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TDictEditQuery
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csServerTaskTypes
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TDictEditQuery

{$If defined(nsTest)}
function TK517772970_TDictEditQuery.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TDictEditQuery.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TDictEditQuery.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '532150C50123';
end;//TK517772970_TDictEditQuery.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TDictEditQuery.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532150C50123_var*
//#UC END# *5320088202FB_532150C50123_var*
begin
//#UC START# *5320088202FB_532150C50123_impl*
 result := TDictEditQuery;
//#UC END# *5320088202FB_532150C50123_impl*
end;//TK517772970_TDictEditQuery.TaskClass

procedure TK517772970_TDictEditQuery.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_532150C50123_var*
const
 IntConst = 123;
//#UC END# *532008D203BA_532150C50123_var*
begin
//#UC START# *532008D203BA_532150C50123_impl*
 inherited InitTask(Task);
 with (Task as TDictEditQuery) do begin
  {DictInfo.}Family := IntConst;
  {DictInfo.}DictType := IntConst;
  {DictInfo.}Operation := IntConst;
  {DictInfo.}ID := IntConst;
  {DictInfo.}ParentID := IntConst;
  {DictInfo.}NextID := IntConst;
 end;
//#UC END# *532008D203BA_532150C50123_impl*
end;//TK517772970_TDictEditQuery.InitTask

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TDictEditQuery.Suite);

end.