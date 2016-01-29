unit StgIndexTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Archi Tests"
// ������: "w:/common/components/rtl/Garant/Abstract_Archi_Tests/StgIndexTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Archi Tests::DataBase::TStgIndexTest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
const
  { DBNames }
 cFileName = 'bserv001';
 cIndexFileName = 'bserv001.idx';

type
 TStgIndexTest = {abstract} class(TBaseTest)
 private
 // private fields
   f_IndexFile : AnsiString;
 protected
 // overridden protected methods
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
     {* ����������� ���� ��� ������, ��� ������� ����� }
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function FileNameForOutput: AnsiString; override;
    {$IfEnd} //nsTest AND not NotTunedDUnit
 published
 // published methods
   procedure DoIt;
 end;//TStgIndexTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  m3StorageIndexAdapter,
  SysUtils,
  l3FileUtils,
  m3DB,
  m3DBInterfaces,
  m4DBInterfaces,
  m4DB,
  l3Base,
  m3StgMgr,
  m3SplittedFileStream,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TStgIndexTest

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

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TStgIndexTest.FileForOutput: AnsiString;
//#UC START# *4B4F588B0241_4F193294011F_var*
//#UC END# *4B4F588B0241_4F193294011F_var*
begin
//#UC START# *4B4F588B0241_4F193294011F_impl*
 Result := inherited FileForOutput;
 // Result := Copy(Result, 1, Length(Result) - 4);
//#UC END# *4B4F588B0241_4F193294011F_impl*
end;//TStgIndexTest.FileForOutput
{$IfEnd} //nsTest AND not NotTunedDUnit

function TStgIndexTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'DataBase';
end;//TStgIndexTest.GetFolder

function TStgIndexTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4F193294011F';
end;//TStgIndexTest.GetModelElementGUID

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TStgIndexTest.FileNameForOutput: AnsiString;
//#UC START# *4DCA41A20364_4F193294011F_var*
//#UC END# *4DCA41A20364_4F193294011F_var*
begin
//#UC START# *4DCA41A20364_4F193294011F_impl*
 Result := cIndexFileName;
//#UC END# *4DCA41A20364_4F193294011F_impl*
end;//TStgIndexTest.FileNameForOutput
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.