unit K517772970_TcsImportTaskItem;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsImportTaskItem.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TcsImportTaskItem" MUID: (53214C4500B5)
// Имя типа: "TK517772970_TcsImportTaskItem"

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
 TK517772970_TcsImportTaskItem = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TcsImportTaskItem
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csImport
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TcsImportTaskItem.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsImportTaskItem.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsImportTaskItem.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214C4500B5';
end;//TK517772970_TcsImportTaskItem.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

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

initialization
 TestFramework.RegisterTest(TK517772970_TcsImportTaskItem.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
