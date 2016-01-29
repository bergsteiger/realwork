unit K517772970_TcsExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TcsExport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TcsExport
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
 TK517772970_TcsExport = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TcsExport
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csExport
  {$IfEnd} //not Nemesis
  ,
  dt_Types
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TcsExport

{$If defined(nsTest)}
function TK517772970_TcsExport.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsExport.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TcsExport.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53214BA801AC';
end;//TK517772970_TcsExport.GetModelElementGUID
{$IfEnd} //nsTest

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

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TcsExport.Suite);

end.