unit K517772970_TRemoteDictEditQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TRemoteDictEditQuery.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TRemoteDictEditQuery
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

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
uses
  K517772970_TddProcessTask
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
type
 TK517772970_TRemoteDictEditQuery = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TRemoteDictEditQuery
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

implementation

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
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
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}

// start class TK517772970_TRemoteDictEditQuery

{$If defined(nsTest)}
function TK517772970_TRemoteDictEditQuery.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TRemoteDictEditQuery.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TRemoteDictEditQuery.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53214F530029';
end;//TK517772970_TRemoteDictEditQuery.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TRemoteDictEditQuery.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214F530029_var*
//#UC END# *5320088202FB_53214F530029_var*
begin
//#UC START# *5320088202FB_53214F530029_impl*
 result := TRemoteDictEditQuery;
//#UC END# *5320088202FB_53214F530029_impl*
end;//TK517772970_TRemoteDictEditQuery.TaskClass

procedure TK517772970_TRemoteDictEditQuery.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214F530029_var*
const
 IntConst = 123;
//#UC END# *532008D203BA_53214F530029_var*
begin
//#UC START# *532008D203BA_53214F530029_impl*
 inherited InitTask(Task);
 with (Task as TRemoteDictEditQuery) do begin
  Family := IntConst;
  DictType := IntConst;
  Operation := IntConst;
  ID := IntConst;
  ParentID := IntConst;
  NextID := IntConst;
  NameCyr := ClassName;
  NameShort := ClassName;
  NameLat := ClassName;
  IsPrivate := IntConst;
  IsNonPeriodic := IntConst;
  DateToDelete := IntConst;
 end;
//#UC END# *532008D203BA_53214F530029_impl*
end;//TK517772970_TRemoteDictEditQuery.InitTask

{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

initialization
 TestFramework.RegisterTest(TK517772970_TRemoteDictEditQuery.Suite);

end.