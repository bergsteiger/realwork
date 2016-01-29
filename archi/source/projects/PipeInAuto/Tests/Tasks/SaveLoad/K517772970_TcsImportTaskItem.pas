unit K517772970_TcsImportTaskItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TcsImportTaskItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TcsImportTaskItem
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
 TK517772970_TcsImportTaskItem = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TcsImportTaskItem
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csImport
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TcsImportTaskItem

{$If defined(nsTest)}
function TK517772970_TcsImportTaskItem.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsImportTaskItem.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TcsImportTaskItem.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53214C4500B5';
end;//TK517772970_TcsImportTaskItem.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TcsImportTaskItem.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214C4500B5_var*
//#UC END# *5320088202FB_53214C4500B5_var*
begin
//#UC START# *5320088202FB_53214C4500B5_impl*
 result := TcsImportTaskItem;
//#UC END# *5320088202FB_53214C4500B5_impl*
end;//TK517772970_TcsImportTaskItem.TaskClass

procedure TK517772970_TcsImportTaskItem.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214C4500B5_var*
//#UC END# *532008D203BA_53214C4500B5_var*
begin
//#UC START# *532008D203BA_53214C4500B5_impl*
 inherited InitTask(Task);
 with (Task as TcsImportTaskItem) do begin
  DeleteIncluded := true;
  IsAnnotation := true;
  IsRegion := true;
  SourceDir := ClassName;
  SourceFiles.Add(FileFromCurrent('A.evd'));
  SourceFiles.Add(FileFromCurrent('B.evd'));
  SourceFiles.Add(FileFromCurrent('C.evd'));
  SourceFiles.Add(FileFromCurrent('D.evd'));
  SourceFiles.Add(FileFromCurrent('E.evd'));
 end;
//#UC END# *532008D203BA_53214C4500B5_impl*
end;//TK517772970_TcsImportTaskItem.InitTask

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TcsImportTaskItem.Suite);

end.