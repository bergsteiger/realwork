unit ExportPipeTestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SimpleTests"
// Модуль: "W:/archi/source/projects/ImportExportTest/ExportPipeTestPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportPipeTestPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include W:\archi\source\projects\ImportExportTest.inc}

interface

{$If defined(nsTest)}
uses
  ExportPipe,
  archiDBTest
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 _DTTypesUser_Parent_ = TarchiDBTest;
 {$Include ..\ImportExportTest\DTTypesUser.imp.pas}
 TExportPipeTestPrim = {abstract} class(_DTTypesUser_)
 private
 // private fields
   f_IsNSRC : Boolean;
   f_Pipe : TExportPipe;
    {* Поле для свойства Pipe}
 private
 // private methods
   procedure FillDocSub;
     {* Формирование выборки для экспорта (она одна для всех потомков) }
   procedure InternalExport;
   procedure CompareResults;
   procedure CheckNumberOfTopicsInResult;
 protected
 // property methods
   function pm_GetPipe: TExportPipe;
 protected
 // overridden protected methods
   procedure Cleanup; override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function OutputFolderName: AnsiString; override;
     {* Папка, в которую пишутся выходные файлы. }
    {$IfEnd} //nsTest AND not NotTunedDUnit
 protected
 // protected methods
   procedure TuneExportPipe; virtual; abstract;
     {* Процедура настройки трубы. Метод для перекрытия в потомках. }
   function GetResultHeaderStartingChar: AnsiChar; virtual;
 public
 // public properties
   property Pipe: TExportPipe
     read pm_GetPipe;
 published
 // published methods
   procedure DoExport;
     {* Собственно, экспорт }
 end;//TExportPipeTestPrim
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  dtIntf
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_Sab
  {$IfEnd} //not Nemesis
  ,
  dt_Const,
  dt_Types,
  l3FileUtils,
  ddFileIterator
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  l3Filer,
  l3Interfaces,
  l3String
  {$If not defined(Nemesis)}
  ,
  dt_Renum
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_Doc
  {$IfEnd} //not Nemesis
  
  {$If defined(Archi) AND not defined(Nemesis)}
  ,
  dt_LinkServ
  {$IfEnd} //Archi AND not Nemesis
  ,
  SysUtils,
  TestFrameWork,
  ddPipeOutInterfaces,
  l3Base
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

{$Include ..\ImportExportTest\DTTypesUser.imp.pas}

// start class TExportPipeTestPrim

procedure TExportPipeTestPrim.FillDocSub;
//#UC START# *55ED5FF503B2_55ED52510115_var*
var
 l_Sab: ISab;
 l_VF : IValueSetFiller;
 
 procedure AddNum(aNum: TDocID);
 begin
  l_VF.AddValue(aNum);
 end;
//#UC END# *55ED5FF503B2_55ED52510115_var*
begin
//#UC START# *55ED5FF503B2_55ED52510115_impl*
 l_Sab := MakeSab(LinkServer(CurrentFamily).Renum);
 l_VF := l_Sab.MakeValueSetFiller(rnImportID_fld);
 AddNum(10002801);
 AddNum(10005719);
 AddNum(2208298);
 AddNum(637196);
 AddNum(10001742);
 AddNum(637760);
 AddNum(10036025);
 AddNum(2205986);
 AddNum(2206451);
 AddNum(637228);
 AddNum(601769);
 AddNum(10005528);
 l_VF := nil;
 l_Sab.RecordsByKey;
 l_Sab.ValuesOfKey(rnRealID_fld);
 l_Sab.TransferToPhoto(fId_Fld, DocumentServer(CurrentFamily).FileTbl);
 Pipe.DocSab := l_Sab;
//#UC END# *55ED5FF503B2_55ED52510115_impl*
end;//TExportPipeTestPrim.FillDocSub

procedure TExportPipeTestPrim.InternalExport;
//#UC START# *55F2E1EE014B_55ED52510115_var*
var
 l_Dir: AnsiString;
//#UC END# *55F2E1EE014B_55ED52510115_var*
begin
//#UC START# *55F2E1EE014B_55ED52510115_impl*
 FillDocSub;
 l_Dir := GetFullPath2OutputFolderName;
 DelDir(l_Dir);
 ForceDirectories(l_Dir);
 Pipe.ExportDirectory := l_Dir;
 Pipe.Family := CurrentFamily;
 Pipe.OutFileType := outNSRC; // по умолчанию выливаем в NSRC
 TuneExportPipe;
 f_IsNSRC := Pipe.OutFileType = outNSRC; // всё-таки экспортировали NSRC
 Check(Pipe.Execute, 'Ошибка при экспорте документов');
//#UC END# *55F2E1EE014B_55ED52510115_impl*
end;//TExportPipeTestPrim.InternalExport

procedure TExportPipeTestPrim.CompareResults;
//#UC START# *55F2E21F02A5_55ED52510115_var*
var
 l_FI_Out, l_FI_Etalon: TddFileIterator;
 I: Integer;
 l_OutPathLen, l_EtalonPathLen: Integer;
 l_OutName, l_EtalonName : AnsiString;
 l_EtalonsFolder: AnsiString;
 l_EtalonExists: Boolean;
 l_Fail: Boolean;
 l_Msg: AnsiString;
//#UC END# *55F2E21F02A5_55ED52510115_var*
begin
//#UC START# *55F2E21F02A5_55ED52510115_impl*
 if f_IsNSRC then
  CheckNumberOfTopicsInResult;
 // скрытые и системные не считаем, чтобы убрать из сравнения служебную папку CVS
 l_FI_Out := TddFileIterator.Make(GetFullPath2OutputFolderName, '*.*', nil, False, faAnyFile and not (faHidden or faSysFile));
 try
  l_FI_Out.WithSubDir := True;
  l_FI_Out.LoadFiles;
  l_EtalonsFolder := ConcatDirName(GetAppTestSetPath, OutputFolderNameWitEtalons);
  l_FI_Etalon := TddFileIterator.Make(l_EtalonsFolder, '*.*', nil, False, faAnyFile and not (faHidden or faSysFile));
  try
   l_FI_Etalon.WithSubDir := True;
   l_FI_Etalon.LoadFiles;
   l_OutPathLen := Length(GetFullPath2OutputFolderName);
   l_EtalonExists := l_FI_Etalon.FileList.Count > 0;
   if l_EtalonExists then
   begin
    // эталоны есть, надо сравнить их число и имена файлов
    Check(l_FI_Etalon.Count = l_FI_Out.Count, 'Различное число файлов в результате и эталоне');
    l_EtalonPathLen := Length(l_EtalonsFolder);
    for I := 0 to Pred(l_FI_Etalon.Count) do
    begin
     l_OutName    := Copy(l_FI_Out.FileList[I], l_OutPathLen + 1, MaxInt);
     l_EtalonName := Copy(l_FI_Etalon.FileList[I], l_EtalonPathLen + 1, MaxInt);
     Check(AnsiSameText(l_OutName, l_EtalonName), 'Разные имена файлов в папке результата и папке эталона');
    end;
   end;
   // Эталонов нет или же они есть и их количество и имена файлов совпадают с результатом.
   // Сравниваем содержимое файлов (или создаём эталоны)
   l_Fail := False;
   for I := 0 to Pred(l_FI_Out.Count) do
   begin
    l_OutName := Copy(l_FI_Out.FileList[I], l_OutPathLen + 1, MaxInt);
    try
     CheckOutputWithInput(
      ConcatDirName(l_EtalonsFolder, l_OutName), // файл эталона
      l_FI_Out.FileList[I], // файл результата
      GetResultHeaderStartingChar,
      EtalonNeedsComputerName,
      EtalonCanHaveDiff,
      '',
      True // NeedCheck
     );
    except
     on E: ETestFailure do
      l_Fail := True;
     else
      raise;
    end;
   end;
   if l_Fail then
   begin
    if l_EtalonExists then
     l_Msg := 'Сравнение не прошло!'
    else
     l_Msg := 'Эталоны не найдены, были созданы новые в папке ' + l_EtalonsFolder;
    Check(False, l_Msg);
   end;
  finally
   FreeAndNil(l_FI_Etalon);
  end;
 finally
  FreeAndNil(l_FI_Out);
 end;
//#UC END# *55F2E21F02A5_55ED52510115_impl*
end;//TExportPipeTestPrim.CompareResults

procedure TExportPipeTestPrim.CheckNumberOfTopicsInResult;
//#UC START# *55FFFF57037B_55ED52510115_var*
var
 l_FI_Out: TddFileIterator;
 l_IterFunc: TddIterateProc;
 l_NumTopics: Integer;

 function l_DoOne(const aFileName: AnsiString): Boolean;
 var
  l_F: Tl3DOSFiler;
  l_S: Tl3WString;
 begin
  Result := True;
  l_F := Tl3DOSFiler.Make(aFileName);
  try
   l_F.Open;
   while not l_F.EOF do
   begin
    l_S := l_F.ReadLn;
    if l3Starts('!TOPIC', l_S) then
     Inc(l_NumTopics);
   end;
  finally
   FreeAndNil(l_F);
  end;
 end;
//#UC END# *55FFFF57037B_55ED52510115_var*
begin
//#UC START# *55FFFF57037B_55ED52510115_impl*
 l_FI_Out := TddFileIterator.Make(GetFullPath2OutputFolderName, '*.nsr', nil, False, faAnyFile and not (faHidden or faSysFile));
 try
  l_FI_Out.LoadFiles;
  l_IterFunc := L2IterateFilesProc(@l_DoOne);
  try
   l_NumTopics := 0;
   l_FI_Out.IterateFiles(l_IterFunc);
  finally
   FreeIterateFilesProc(l_IterFunc);
  end;
  Check(l_NumTopics = 24, 'Не хватает документов в результатах экспорта!');
 finally
  FreeAndNil(l_FI_Out);
 end;
//#UC END# *55FFFF57037B_55ED52510115_impl*
end;//TExportPipeTestPrim.CheckNumberOfTopicsInResult

procedure TExportPipeTestPrim.DoExport;
//#UC START# *55EEA1AC0299_55ED52510115_var*
//#UC END# *55EEA1AC0299_55ED52510115_var*
begin
//#UC START# *55EEA1AC0299_55ED52510115_impl*
 UnpackDatabase;
 try
  ConnectToDatabase;
  try
   ClearTestFolder;
   InternalExport;
   FreeAndNil(f_Pipe);
  finally
   DisconnectFromDatabase;
  end;
 finally
  DeleteDatabase;
 end;
 CompareResults;
//#UC END# *55EEA1AC0299_55ED52510115_impl*
end;//TExportPipeTestPrim.DoExport

function TExportPipeTestPrim.GetResultHeaderStartingChar: AnsiChar;
//#UC START# *55F806E500B6_55ED52510115_var*
//#UC END# *55F806E500B6_55ED52510115_var*
begin
//#UC START# *55F806E500B6_55ED52510115_impl*
 Result := ';'; // по умолчанию выливаем в NSRC
//#UC END# *55F806E500B6_55ED52510115_impl*
end;//TExportPipeTestPrim.GetResultHeaderStartingChar

function TExportPipeTestPrim.pm_GetPipe: TExportPipe;
//#UC START# *55ED54F10251_55ED52510115get_var*
//#UC END# *55ED54F10251_55ED52510115get_var*
begin
//#UC START# *55ED54F10251_55ED52510115get_impl*
 if f_Pipe = nil then
  f_Pipe := TExportPipe.Create;
 Result := f_Pipe; 
//#UC END# *55ED54F10251_55ED52510115get_impl*
end;//TExportPipeTestPrim.pm_GetPipe

procedure TExportPipeTestPrim.Cleanup;
//#UC START# *4B2F40FD0088_55ED52510115_var*
//#UC END# *4B2F40FD0088_55ED52510115_var*
begin
//#UC START# *4B2F40FD0088_55ED52510115_impl*
 FreeAndNil(f_Pipe);
 inherited;
//#UC END# *4B2F40FD0088_55ED52510115_impl*
end;//TExportPipeTestPrim.Cleanup

function TExportPipeTestPrim.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportPipeTestPrim.GetFolder

function TExportPipeTestPrim.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55ED52510115';
end;//TExportPipeTestPrim.GetModelElementGUID

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TExportPipeTestPrim.OutputFolderName: AnsiString;
//#UC START# *51B1A75D0367_55ED52510115_var*
//#UC END# *51B1A75D0367_55ED52510115_var*
begin
//#UC START# *51B1A75D0367_55ED52510115_impl*
 Result := ClassName + '_out';
//#UC END# *51B1A75D0367_55ED52510115_impl*
end;//TExportPipeTestPrim.OutputFolderName
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest

end.