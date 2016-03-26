unit K517772970_TcsSpellCorrectTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsSpellCorrectTask.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TcsSpellCorrectTask" MUID: (53B25C540327)
// Имя типа: "TK517772970_TcsSpellCorrectTask"

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
 TK517772970_TcsSpellCorrectTask = class(TK517772970_TddProcessTask)
  {* [RequestLink:517772970] }
  protected
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TcsSpellCorrectTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csSpellCorrectTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

function TK517772970_TcsSpellCorrectTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53B25C540327_var*
//#UC END# *5320088202FB_53B25C540327_var*
begin
//#UC START# *5320088202FB_53B25C540327_impl*
 Result := TcsSpellCorrectTask;
//#UC END# *5320088202FB_53B25C540327_impl*
end;//TK517772970_TcsSpellCorrectTask.TaskClass

procedure TK517772970_TcsSpellCorrectTask.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53B25C540327_var*
//#UC END# *532008D203BA_53B25C540327_var*
begin
//#UC START# *532008D203BA_53B25C540327_impl*
 inherited;
 (Task As TcsSpellCorrectTask).ReplacementFile.Name := Self.FileFromCurrent('A.evd');
//#UC END# *532008D203BA_53B25C540327_impl*
end;//TK517772970_TcsSpellCorrectTask.InitTask

{$If Defined(nsTest)}
function TK517772970_TcsSpellCorrectTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsSpellCorrectTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsSpellCorrectTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53B25C540327';
end;//TK517772970_TcsSpellCorrectTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TcsSpellCorrectTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
