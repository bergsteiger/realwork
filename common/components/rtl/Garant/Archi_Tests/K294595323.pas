unit K294595323;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Tests"
// Модуль: "w:/common/components/rtl/Garant/Archi_Tests/K294595323.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Archi Tests::Filters::K294595323
//
// {RequestLink:294595323}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Archi_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  AACFiltersTest,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK294595323 = class(TAACFiltersTest)
  {* [RequestLink:294595323] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 public
 // overridden public methods
   class function Suite: ITestSuite; override;
 end;//TK294595323
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  K294595323Suite
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK294595323

function TK294595323.GetFolder: AnsiString;
 {-}
begin
 Result := 'Filters';
end;//TK294595323.GetFolder

function TK294595323.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4EA5382F006A';
end;//TK294595323.GetModelElementGUID

class function TK294595323.Suite: ITestSuite;
//#UC START# *4EA553E901DB_4EA5382F006A_var*
//#UC END# *4EA553E901DB_4EA5382F006A_var*
begin
//#UC START# *4EA553E901DB_4EA5382F006A_impl*
 Result := TK294595323Suite.Create(Self);
//#UC END# *4EA553E901DB_4EA5382F006A_impl*
end;//TK294595323.Suite

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK294595323.Suite);

end.