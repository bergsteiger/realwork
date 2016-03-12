unit ietBaseTest;

// Модуль: "w:\archi\source\projects\ImportExportTest\ietBaseTest.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , archiDBTest
 , ddImportPipe
 , ExportPipe
 , evdDTTypes
;

type
 TietBaseTest = {abstract} class(TarchiDBTest)
  private
   procedure DoImport;
   procedure DoExport;
   procedure CompareResults;
   procedure TopicEvent(aTopicNo: Integer;
    const aMessage: AnsiString);
  protected
   procedure DoBeforeImport(const aPipe: TddImportPipe); virtual;
   procedure DoAfterImport(const aPipe: TddImportPipe); virtual;
   procedure DoBeforeExport(const aPipe: TExportPipe); virtual;
   procedure DoAfterExport(const aPipe: TExportPipe); virtual;
   function GetOutputPath: AnsiString;
   function GetOutputFormat: TepSupportFileType; virtual;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If NOT Defined(NotTunedDUnit)}
   function OutputFolderName: AnsiString; override;
    {* Папка, в которую пишутся выходные файлы. }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
  published
   procedure DoIt;
 end;//TietBaseTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , l3IniFile
 , TestFrameWork
 , dt_AttrSchema
 {$If Defined(Archi) AND NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // Defined(Archi) AND NOT Defined(Nemesis)
 , SysUtils
 , dt_Const
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 , ddPipeOutInterfaces
 {$If NOT Defined(Nemesis)}
 , dt_Renum
 {$IfEnd} // NOT Defined(Nemesis)
;

procedure TietBaseTest.DoIt;
//#UC START# *5194BE87016F_51948F2601E9_var*
//#UC END# *5194BE87016F_51948F2601E9_var*
begin
//#UC START# *5194BE87016F_51948F2601E9_impl*
 UnpackDatabase;
 try
  ConnectToDatabase;
  try
   ClearTestFolder;
   DoImport;
   DoExport;
  finally
   DisconnectFromDatabase;
  end;
 finally
  DeleteDatabase;
 end;
 CompareResults;
//#UC END# *5194BE87016F_51948F2601E9_impl*
end;//TietBaseTest.DoIt

procedure TietBaseTest.DoImport;
//#UC START# *5195F5F7001A_51948F2601E9_var*
var
 l_InPipe: TddImportPipe;
 l_FromFolder: string;
//#UC END# *5195F5F7001A_51948F2601E9_var*
begin
//#UC START# *5195F5F7001A_51948F2601E9_impl*
 l_FromFolder := FolderFromCurrent(ClassName + '_in');
 Check(DirectoryExists(l_FromFolder), Format('Не найдена папка с исходными данными (%s)', [l_FromFolder]));
 l_InPipe := TddImportPipe.Create(CurrentFamily);
 try
  f_NumSab := MakeSab(LinkServer(CurrentFamily).Attribute[atRenum]);
  try
   l_InPipe.InputFileType := dd_itAutoDetect;
   l_InPipe.OnTopicStart := TopicEvent;
   l_InPipe.CheckDocuments:= False;
   l_InPipe.NeedLockBase := True;
   l_InPipe.WorkDir := l_FromFolder;
   l_InPipe.PictureDir := l_FromFolder;
   l_InPipe.NotUpdatableDicts:= [];
   l_InPipe.NeedFork:= True;
   l_InPipe.UserID := 0;
   l_InPipe.AddNewToLog := false;
   DoBeforeImport(l_InPipe);
   Check(l_InPipe.Execute, 'Импорт завершился с ошибкой');
   DoAfterImport(l_InPipe); 
  finally
   f_SabFiller := nil;
   f_NumSab.Refresh;
   f_NumSab.ValuesOfKey(rnRealID_fld);
  end;
 finally
  FreeAndNil(l_InPipe);
 end;
//#UC END# *5195F5F7001A_51948F2601E9_impl*
end;//TietBaseTest.DoImport

procedure TietBaseTest.DoExport;
//#UC START# *5195F62700C7_51948F2601E9_var*
var
 l_ExPipe   : TExportPipe;
 //l_Diapason : TDiapasonRec;
 l_Path     : string;
//#UC END# *5195F62700C7_51948F2601E9_var*
begin
//#UC START# *5195F62700C7_51948F2601E9_impl*
  l_ExPipe := TExportPipe.Create;
  try
   l_ExPipe.OutFileType := GetOutputFormat;
   l_ExPipe.Family := CurrentFamily;
   l_ExPipe.AllPartsDivideBy([edbTopic]);

   l_ExPipe.ExportDocument := True;
   l_ExPipe.ExportAnnotation := True;
   l_ExPipe.ExportDocImage := False;
   l_ExPipe.UpdateFiles := False;

   l_ExPipe.ExportEmpty := True;

   l_ExPipe.ExportKW := False;

   l_Path := GetOutputPath; 
   ForceDirectories(l_Path);
   l_ExPipe.ExportDirectory := l_Path;

   // выборка
   (*
   l_Diapason.Typ := tdNumList;
   l_Diapason.List := f_NumSab.htSab;
   l_Diapason.ExternalFormat := False;
   *)
   l_ExPipe.DocSab := f_NumSab;
   DoBeforeExport(l_ExPipe);
   Check(l_ExPipe.Execute, 'Экспорт завершился с ошибкой');
   DoAfterExport(l_ExPipe);
  finally
   f_NumSab:= nil;
   FreeAndNil(l_ExPipe);
  end;
//#UC END# *5195F62700C7_51948F2601E9_impl*
end;//TietBaseTest.DoExport

procedure TietBaseTest.CompareResults;
//#UC START# *5195F6E701B6_51948F2601E9_var*
const
 c_CommentChar: array[TepSupportFileType] of AnsiChar = ('%','%',';', #0, #0, #0, #0);
//#UC END# *5195F6E701B6_51948F2601E9_var*
begin
//#UC START# *5195F6E701B6_51948F2601E9_impl*
 CheckEtalonInFolder(c_CommentChar[GetOutputFormat]);
//#UC END# *5195F6E701B6_51948F2601E9_impl*
end;//TietBaseTest.CompareResults

procedure TietBaseTest.DoBeforeImport(const aPipe: TddImportPipe);
//#UC START# *5195F73400EE_51948F2601E9_var*
//#UC END# *5195F73400EE_51948F2601E9_var*
begin
//#UC START# *5195F73400EE_51948F2601E9_impl*

//#UC END# *5195F73400EE_51948F2601E9_impl*
end;//TietBaseTest.DoBeforeImport

procedure TietBaseTest.DoAfterImport(const aPipe: TddImportPipe);
//#UC START# *5195F75F02CB_51948F2601E9_var*
//#UC END# *5195F75F02CB_51948F2601E9_var*
begin
//#UC START# *5195F75F02CB_51948F2601E9_impl*

//#UC END# *5195F75F02CB_51948F2601E9_impl*
end;//TietBaseTest.DoAfterImport

procedure TietBaseTest.DoBeforeExport(const aPipe: TExportPipe);
//#UC START# *5195F795012D_51948F2601E9_var*
//#UC END# *5195F795012D_51948F2601E9_var*
begin
//#UC START# *5195F795012D_51948F2601E9_impl*

//#UC END# *5195F795012D_51948F2601E9_impl*
end;//TietBaseTest.DoBeforeExport

procedure TietBaseTest.DoAfterExport(const aPipe: TExportPipe);
//#UC START# *5195F7BA0056_51948F2601E9_var*
//#UC END# *5195F7BA0056_51948F2601E9_var*
begin
//#UC START# *5195F7BA0056_51948F2601E9_impl*

//#UC END# *5195F7BA0056_51948F2601E9_impl*
end;//TietBaseTest.DoAfterExport

procedure TietBaseTest.TopicEvent(aTopicNo: Integer;
 const aMessage: AnsiString);
//#UC START# *519A1C2700C4_51948F2601E9_var*
//#UC END# *519A1C2700C4_51948F2601E9_var*
begin
//#UC START# *519A1C2700C4_51948F2601E9_impl*
 if f_SabFiller = nil then
  f_SabFiller := f_NumSab.MakeValueSetFiller(rnImportID_fld);
 f_SabFiller.AddValue(aTopicNo); 
//#UC END# *519A1C2700C4_51948F2601E9_impl*
end;//TietBaseTest.TopicEvent

function TietBaseTest.GetOutputPath: AnsiString;
//#UC START# *519C80CD01E4_51948F2601E9_var*
//#UC END# *519C80CD01E4_51948F2601E9_var*
begin
//#UC START# *519C80CD01E4_51948F2601E9_impl*
 Result := FileFromCurrent(OutputFolderName);
//#UC END# *519C80CD01E4_51948F2601E9_impl*
end;//TietBaseTest.GetOutputPath

function TietBaseTest.GetOutputFormat: TepSupportFileType;
//#UC START# *51CBE62E006B_51948F2601E9_var*
//#UC END# *51CBE62E006B_51948F2601E9_var*
begin
//#UC START# *51CBE62E006B_51948F2601E9_impl*
 Result := outEVDtext;
//#UC END# *51CBE62E006B_51948F2601E9_impl*
end;//TietBaseTest.GetOutputFormat

function TietBaseTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ImportExport';
end;//TietBaseTest.GetFolder

function TietBaseTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51948F2601E9';
end;//TietBaseTest.GetModelElementGUID

{$If NOT Defined(NotTunedDUnit)}
function TietBaseTest.OutputFolderName: AnsiString;
 {* Папка, в которую пишутся выходные файлы. }
//#UC START# *51B1A75D0367_51948F2601E9_var*
//#UC END# *51B1A75D0367_51948F2601E9_var*
begin
//#UC START# *51B1A75D0367_51948F2601E9_impl*
 Result := ClassName + '_out';
//#UC END# *51B1A75D0367_51948F2601E9_impl*
end;//TietBaseTest.OutputFolderName
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
