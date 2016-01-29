unit MultyOperationTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Archi Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Archi_Tests/MultyOperationTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Archi Tests::DataBase::TMultyOperationTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
type
 TMultyOperationTest = {abstract} class(TBaseTest)
 private
 // private methods
   procedure ClearBase(const aBasePath: AnsiString);
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt();
 end;//TMultyOperationTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  DataBaseTester,
  SysUtils,
  m3SplittedFileStream,
  m3DBInterfaces,
  m3DB,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TMultyOperationTest

procedure TMultyOperationTest.ClearBase(const aBasePath: AnsiString);
//#UC START# *54200FFA01D8_54193E6A0023_var*
var
 l_DB: Im3DB;
//#UC END# *54200FFA01D8_54193E6A0023_var*
begin
//#UC START# *54200FFA01D8_54193E6A0023_impl*
 l_DB := Tm3DB.Make(aBasePath);
 try
  l_DB.DeleteVersion;
  l_DB.DeleteMain;
 finally
  l_DB := nil;
 end;//try..finally
//#UC END# *54200FFA01D8_54193E6A0023_impl*
end;//TMultyOperationTest.ClearBase

procedure TMultyOperationTest.DoIt();
//#UC START# *54193F6B00F8_54193E6A0023_var*
var
 l_DBName      : AnsiString;
 l_Folder      : AnsiString;
 l_Folder1     : AnsiString;
 l_FirstTester : TDataBaseTester;
 l_SecondTester: TDataBaseTester;
//#UC END# *54193F6B00F8_54193E6A0023_var*
begin
//#UC START# *54193F6B00F8_54193E6A0023_impl*
 Tm3SplittedFileStream.SetDefaultSizeLimit(2 * 1024 * 1024);
 try
  l_DBName := FileForOutput;
  l_DBName := ChangeFileExt(l_DBName, '');
  l_Folder := KPage;
  l_Folder1 := KPage + '_1';
  l_Folder := FolderFromCurrent(l_Folder);
  l_Folder1 := FolderFromCurrent(l_Folder1);
  ClearBase(l_DBName);
  l_FirstTester := TDataBaseTester.Create(True, l_Folder, l_DBName);
  l_SecondTester := TDataBaseTester.Create(True, l_Folder1, l_DBName);
  try
   l_FirstTester.Resume;
   l_SecondTester.Resume;
   l_FirstTester.WaitFor;
   l_SecondTester.WaitFor;
  finally
   FreeAndNil(l_FirstTester);
   FreeAndNil(l_SecondTester);
  end;
 finally
  Tm3SplittedFileStream.SetDefaultSizeLimit(0);
 end;//try..finally
//#UC END# *54193F6B00F8_54193E6A0023_impl*
end;//TMultyOperationTest.DoIt()

function TMultyOperationTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'DataBase';
end;//TMultyOperationTest.GetFolder

function TMultyOperationTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '54193E6A0023';
end;//TMultyOperationTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.