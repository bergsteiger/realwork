unit K517772970_TcsUserDefinedExport;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsUserDefinedExport.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TcsUserDefinedExport" MUID: (53B26EC60189)
// Имя типа: "TK517772970_TcsUserDefinedExport"

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
 TK517772970_TcsUserDefinedExport = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TcsUserDefinedExport
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csUserDefinedExport
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 //#UC START# *53B26EC60189impl_uses*
 //#UC END# *53B26EC60189impl_uses*
;

function TK517772970_TcsUserDefinedExport.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53B26EC60189_var*
//#UC END# *5320088202FB_53B26EC60189_var*
begin
//#UC START# *5320088202FB_53B26EC60189_impl*
 Result := TcsUserDefinedExport;
//#UC END# *5320088202FB_53B26EC60189_impl*
end;//TK517772970_TcsUserDefinedExport.TaskClass

procedure TK517772970_TcsUserDefinedExport.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53B26EC60189_var*
//#UC END# *532008D203BA_53B26EC60189_var*
begin
//#UC START# *532008D203BA_53B26EC60189_impl*
 inherited;
 with (Task As TcsUserDefinedExport) do
 begin
  QueryFile := Self.FileFromCurrent('A.evd');
  TimeToRun := Date + 100;
 end;//with (Task As TcsUserDefinedExport)
//#UC END# *532008D203BA_53B26EC60189_impl*
end;//TK517772970_TcsUserDefinedExport.InitTask

{$If Defined(nsTest)}
function TK517772970_TcsUserDefinedExport.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsUserDefinedExport.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsUserDefinedExport.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53B26EC60189';
end;//TK517772970_TcsUserDefinedExport.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TcsUserDefinedExport.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
