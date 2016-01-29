unit CustomFolderTestSuite;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/CustomFolderTestSuite.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Tests::Abstract Tests::FolderTestSupport::TCustomFolderTestSuite
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  CustomAutoTestsSuite,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TCustomFolderTestSuite = class(TCustomAutoTestSuite)
 private
 // private fields
   f_DataFolder : AnsiString;
 protected
 // overridden protected methods
   function GetDataFolder: AnsiString; override;
     {* Возвращает папку с данными для создания тестов. }
   function GetExt: AnsiString; override;
 public
 // overridden public methods
   procedure AddTests(aTestClass: TTestCaseClass); override;
 end;//TCustomFolderTestSuite
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TCustomFolderTestSuite

procedure TCustomFolderTestSuite.AddTests(aTestClass: TTestCaseClass);
//#UC START# *4DC38C96018E_4EA515800122_var*
//#UC END# *4DC38C96018E_4EA515800122_var*
begin
//#UC START# *4DC38C96018E_4EA515800122_impl*
 f_DataFolder := aTestClass.ClassName;
 inherited;
//#UC END# *4DC38C96018E_4EA515800122_impl*
end;//TCustomFolderTestSuite.AddTests

function TCustomFolderTestSuite.GetDataFolder: AnsiString;
//#UC START# *4EA50B95037D_4EA515800122_var*
//#UC END# *4EA50B95037D_4EA515800122_var*
begin
//#UC START# *4EA50B95037D_4EA515800122_impl*
 Result := f_DataFolder;
//#UC END# *4EA50B95037D_4EA515800122_impl*
end;//TCustomFolderTestSuite.GetDataFolder

function TCustomFolderTestSuite.GetExt: AnsiString;
//#UC START# *4EA50C04021B_4EA515800122_var*
//#UC END# *4EA50C04021B_4EA515800122_var*
begin
//#UC START# *4EA50C04021B_4EA515800122_impl*
 Result := '.evd';
//#UC END# *4EA50C04021B_4EA515800122_impl*
end;//TCustomFolderTestSuite.GetExt

{$IfEnd} //nsTest AND not NoScripts

end.