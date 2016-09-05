unit MultyOperationTest;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\MultyOperationTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TMultyOperationTest" MUID: (54193E6A0023)

{$Include w:\common\components\rtl\Garant\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TMultyOperationTest = {abstract} class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  private
   procedure ClearBase(const aBasePath: AnsiString);
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt();
 end;//TMultyOperationTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataBaseTester
 , SysUtils
 , m3SplittedFileStream
 , m3DBInterfaces
 , m3DB
 , TestFrameWork
 //#UC START# *54193E6A0023impl_uses*
 //#UC END# *54193E6A0023impl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
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

function TMultyOperationTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DataBase';
end;//TMultyOperationTest.GetFolder

function TMultyOperationTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54193E6A0023';
end;//TMultyOperationTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
