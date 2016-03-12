unit ArchiStorageTest;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\ArchiStorageTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , m3DBInterfaces
;

type
 TArchiStorageTest = {abstract} class(TBaseTest)
  protected
   procedure DoBase(const aDB: Im3DB); virtual;
   function NeedTestRenaming: Boolean; virtual;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If NOT Defined(NotTunedDUnit)}
   function NeedCreateEtalonsWhileCheckingOutputWithInput: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
  published
   procedure DoIt;
 end;//TArchiStorageTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , m3DB
 , m3StorageInterfaces
 , SysUtils
 , l3FileUtils
 , l3Base
 , l3Interfaces
 , l3Stream
 , l3Types
 , m3SplittedFileStream
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TArchiStorageTest.DoIt;
//#UC START# *4FA137EE02D3_4FA137DD03E4_var*
var
 l_DB : Im3DB;
 l_DBName : String;
//#UC END# *4FA137EE02D3_4FA137DD03E4_var*
begin
//#UC START# *4FA137EE02D3_4FA137DD03E4_impl*
 Tm3SplittedFileStream.SetDefaultSizeLimit(2 * 1024 * 1024);
 try
  l_DBName := FileForOutput;
  l_DBName := ChangeFileExt(l_DBName, '');
  l_DB := Tm3DB.MakeExclusive(l_DBName);
  try
   l_DB.DeleteVersion;
   l_DB.DeleteMain;
   StartTimer;
   try
    l_DB.Start(m3_saReadWrite);
    try
     DoBase(l_DB);
    finally
     l_DB.Finish;
    end;//try..finally
   finally
    StopTimer;
   end;//try..finally
  finally
   l_DB := nil;
  end;//try..finally
 finally
  Tm3SplittedFileStream.SetDefaultSizeLimit(0);
 end;//try..finally
//#UC END# *4FA137EE02D3_4FA137DD03E4_impl*
end;//TArchiStorageTest.DoIt

procedure TArchiStorageTest.DoBase(const aDB: Im3DB);
//#UC START# *4FA150420241_4FA137DD03E4_var*

  procedure MakeCopy(const anIn : IStream; const anOut : IStream);
  var
   l_Read : Int64;
   l_Written : Int64;
  begin//MakeCopy
   if not (anIn.CopyTo(anOut, High(Int64), l_Read, l_Written) = S_OK) then
    Check(false);
   Check(l_Read = l_Written);
  end;//MakeCopy

var
 l_Index : Integer;

 function DocStream(anAccess : Tm3StoreAccess) : IStream;
 var
  l_Doc : Im3DBDocument;
 begin//DocStream
  l_Doc := aDB.GetDocument(l_Index);
  try
   Result := l_Doc.Open(anAccess);
  finally
   l_Doc := nil;
  end;//try..finally
  Inc(l_Index);
 end;//DocStream

 function DoFile(const aFileName: string): Boolean;
 var
  l_SOut : IStream;
  l_SIn  : Tl3NamedFileStream;
 begin//DoFile
  Result := true;
  l_SOut := DocStream(m3_saReadWrite);
  try
   l_SIn := Tl3NamedFileStream.Create(aFileName, l3_fmRead);
   try
    MakeCopy(l_SIn, l_SOut);
   finally
    FreeAndNil(l_SIn);
   end;//try..finally
  finally
   l_SOut := nil;
  end;//try..finally
  Dec(l_Index);
  l_SOut := DocStream(m3_saRead);
  try
   Assert(l_SOut <> nil);
  finally
   l_SOut := nil;
  end;//try..finally
 end;//DoFile

 function DoFileCheck(const aFileName: string): Boolean;
 var
  l_SIn : IStream;
  l_SOut : Tl3NamedFileStream;
  l_OutFileName : String;
 begin//DoFileCheck
  Result := true;
  l_SIn := DocStream(m3_saRead);
  try
   Assert(l_SIn <> nil);
   l_OutFileName := OutputPath + ExtractFileName(aFileName);
   l_SOut := Tl3NamedFileStream.Create(l_OutFileName, l3_fmWrite);
   try
    MakeCopy(l_SIn, l_SOut);
   finally
    FreeAndNil(l_SOut);
   end;//try..finally
  finally
   l_SIn := nil;
  end;//try..finally
  CheckOutputWithInput(aFileName,
                       l_OutFileName,
                       #0,
                       false,
                       false,
                       '',
                       true
                      );
  DeleteFile(l_OutFileName);                    
 end;//DoFileCheck

var
 l_Folder : String;
 
 procedure ProcessFilesF(var aProc : Pointer);
 const
  cMask = '*';
 begin//ProcessFilesF
  l_Index := 1;
  try
   ProcessFilesWithMask(l_Folder, cMask, TFileProcessingFunc(aProc));
  finally
   l3FreeLocalStub(aProc);
  end;//try..finally
 end;//ProcessFilesF

var
 l_FPStub : Pointer;
 l_DBName : String;
 l_DBNameNew : String;
 l_DB : Im3DB;
//#UC END# *4FA150420241_4FA137DD03E4_var*
begin
//#UC START# *4FA150420241_4FA137DD03E4_impl*
 l_Folder := KPage;
 l_Folder := FolderFromCurrent(l_Folder);
 l_FPStub := l3LocalStub(@DoFile);
 ProcessFilesF(l_FPStub);
 l_FPStub := l3LocalStub(@DoFileCheck);
 ProcessFilesF(l_FPStub);
 aDB.Update;
 if NeedTestRenaming then
 begin
  l_DBName := FileForOutput;
  l_DBName := ChangeFileExt(l_DBName, '');
  l_DBNameNew := l_DBName + 'XXX';
  aDB.RenameVersion(l_DBNameNew);
  l_DB := Tm3DB.Make(l_DBNameNew);
  try
   l_DB.RenameVersion(l_DBName);
  finally
   l_DB := nil;
  end;//try..finally
  aDB.Rename(l_DBNameNew);
  aDB.Rename(l_DBName);
 end;//NeedTestRenaming
 aDB.DeleteVersion;
 l_FPStub := l3LocalStub(@DoFileCheck);
 ProcessFilesF(l_FPStub);
 aDB.DeleteMain;
//#UC END# *4FA150420241_4FA137DD03E4_impl*
end;//TArchiStorageTest.DoBase

function TArchiStorageTest.NeedTestRenaming: Boolean;
//#UC START# *4FBB73390387_4FA137DD03E4_var*
//#UC END# *4FBB73390387_4FA137DD03E4_var*
begin
//#UC START# *4FBB73390387_4FA137DD03E4_impl*
 Result := false;
//#UC END# *4FBB73390387_4FA137DD03E4_impl*
end;//TArchiStorageTest.NeedTestRenaming

function TArchiStorageTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Storage';
end;//TArchiStorageTest.GetFolder

function TArchiStorageTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FA137DD03E4';
end;//TArchiStorageTest.GetModelElementGUID

function TArchiStorageTest.NeedCreateEtalonsWhileCheckingOutputWithInput: Boolean;
//#UC START# *4FA164500031_4FA137DD03E4_var*
//#UC END# *4FA164500031_4FA137DD03E4_var*
begin
//#UC START# *4FA164500031_4FA137DD03E4_impl*
 Result := false;
//#UC END# *4FA164500031_4FA137DD03E4_impl*
end;//TArchiStorageTest.NeedCreateEtalonsWhileCheckingOutputWithInput
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
