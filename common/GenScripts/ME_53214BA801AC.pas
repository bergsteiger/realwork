unit K517772970_TcsExport;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsExport.pas"
// Стереотип: "TestCase"

{$Include alcuDefine.inc}

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
 TK517772970_TcsExport = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TcsExport
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csExport
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TcsExport.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsExport.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsExport.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214BA801AC';
end;//TK517772970_TcsExport.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TcsExport.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214BA801AC_var*
//#UC END# *5320088202FB_53214BA801AC_var*
begin
//#UC START# *5320088202FB_53214BA801AC_impl*
 Result := TcsExport;
//#UC END# *5320088202FB_53214BA801AC_impl*
end;//TK517772970_TcsExport.TaskClass

procedure TK517772970_TcsExport.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214BA801AC_var*
const
 IntConst = 123;
var
 l_str: string;
//#UC END# *532008D203BA_53214BA801AC_var*
begin
//#UC START# *532008D203BA_53214BA801AC_impl*
 inherited InitTask(Task);
 with (Task as TcsExport) do
 begin
  AnnoTopicFileName := ClassName;
  DiapasonType := tdSearch;
  DocID := IntConst;
  DocumentFileNameMask := ClassName;
  ExportAnnoTopics := true;
  ExportDirectory := ClassName;
  ExportDocImage := true;
  ExportDocument := true;
  ExportEmptyKW := true;
  ExportKW := true;
  ExportRTFBody := true;
  Family := IntConst;
  InternalFormat := true;
  KWFileName := ClassName;
  MultiUser := true;
  ObjTopicFileName := ClassName;
  OnlyStructure := true;
  OutFileType := outEVDtext;
  OutputFileSize := IntConst;
  ReferenceFileNameMask := ClassName;
  SeparateFiles := divTopic;
  ToRegion := IntConst;
  ExportReferences := true;
  ExportEditions := true;
  FormulaAsPicture := true;
  SABStream.Add(1000300);
  SABStream.Add(10064072);
 end;//Task as TcsExport
//#UC END# *532008D203BA_53214BA801AC_impl*
end;//TK517772970_TcsExport.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TcsExport.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
