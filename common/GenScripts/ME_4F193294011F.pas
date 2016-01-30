unit StgIndexTest;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\StgIndexTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

const
 cFileName = 'bserv001';
 cIndexFileName = 'bserv001.idx';

type
 TStgIndexTest = {abstract} class(TBaseTest)
  private
   f_IndexFile: AnsiString;
  protected
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* Стандартный файл для вывода, для текщего теста }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If NOT Defined(NotTunedDUnit)}
   function FileNameForOutput: AnsiString; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
  public
   procedure DoIt;
 end;//TStgIndexTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , m3SplittedFileStream
 , TestFrameWork
 , m3StorageIndexAdapter
 , SysUtils
 , l3FileUtils
 , m3DB
 , m3DBInterfaces
 , m4DBInterfaces
 , m4DB
 , l3Base
 , m3StgMgr
;

procedure TStgIndexTest.DoIt;
//#UC START# *4F19335D01E9_4F193294011F_var*
var
 l_DBName : String;

 procedure lp_CompareWithEtalon;

  function DoFile(const aFileName: string): Boolean;
  begin//DoFile
   Result := true;
   if FileExists(aFileName) then
   begin
    if (ExtractFileExt(aFileName) = '.idx') and (Pos('.cnt', aFileName) = 0) then
    begin
     f_IndexFile := aFileName;
     Result := False;
    end;
   end; // if FileExists(aFileName) then
  end;//DoFile

 var
  l_FPStub : Pointer;
 begin
  l_FPStub := l3LocalStub(@DoFile);
  try
   Tm3StorageManager.IterateStorageFiles(l_DBName, l_FPStub);
  finally
   l3FreeLocalStub(l_FPStub);
  end;//try..finally
  CheckWithEtalon(f_IndexFile, #0);
 end;
 
 procedure lp_DeleteVersion;
 var
  l_DB : Im3DB;
 begin
  l_DB := Tm3DB.Make(l_DBName);
  try
   l_DB.DeleteVersion;
  finally
   l_DB := nil;
  end;
 end;

 procedure lp_DeleteIndex;
 var
  l_DB4 : Im4DB;
 begin
  l_DB4 := Tm4DB.Make(l_DBName);
  try
   l_DB4.DeleteIndex;
  finally
   l_DB4 := nil;
  end;
 end;              

//#UC END# *4F19335D01E9_4F193294011F_var*
begin
//#UC START# *4F19335D01E9_4F193294011F_impl*
 Tm3SplittedFileStream.SetDefaultSizeLimit(2 * 1024 * 1024);
 try
  l_DBName := FileForOutput;
  l_DBName := ChangeFileExt(l_DBName, '');
  lp_DeleteVersion;
  with Tm3StorageIndexAdapter.Instance do
  begin
   BaseName := cFileName;
   DirName := ExtractFilePath(FileForOutput);
   DoBuildIndex(nil);
   lp_CompareWithEtalon;
  end; // with g_Tm3StorageIndexAdapter.Instance do
  lp_DeleteIndex;
  lp_DeleteVersion;
 finally
  Tm3SplittedFileStream.SetDefaultSizeLimit(0);
 end;//try..finally
//#UC END# *4F19335D01E9_4F193294011F_impl*
end;//TStgIndexTest.DoIt

{$If NOT Defined(NotTunedDUnit)}
function TStgIndexTest.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_4F193294011F_var*
//#UC END# *4B4F588B0241_4F193294011F_var*
begin
//#UC START# *4B4F588B0241_4F193294011F_impl*
 Result := inherited FileForOutput;
 // Result := Copy(Result, 1, Length(Result) - 4);
//#UC END# *4B4F588B0241_4F193294011F_impl*
end;//TStgIndexTest.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TStgIndexTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DataBase';
end;//TStgIndexTest.GetFolder

function TStgIndexTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F193294011F';
end;//TStgIndexTest.GetModelElementGUID

{$If NOT Defined(NotTunedDUnit)}
function TStgIndexTest.FileNameForOutput: AnsiString;
//#UC START# *4DCA41A20364_4F193294011F_var*
//#UC END# *4DCA41A20364_4F193294011F_var*
begin
//#UC START# *4DCA41A20364_4F193294011F_impl*
 Result := cIndexFileName;
//#UC END# *4DCA41A20364_4F193294011F_impl*
end;//TStgIndexTest.FileNameForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
