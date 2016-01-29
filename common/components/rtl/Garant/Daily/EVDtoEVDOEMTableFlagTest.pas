unit EVDtoEVDOEMTableFlagTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoEVDOEMTableFlagTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDtoEVDOEMTableFlagTest
//
// Тест фильтра"'Выливать в псевдографику"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  EVDtoEVDWriterTest,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoEVDOEMTableFlagTest = {abstract} class(TEVDtoEVDWriterTest)
  {* Тест фильтра"'Выливать в псевдографику" }
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoEVDOEMTableFlagTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evOEMTableFlagFilter,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoEVDOEMTableFlagTest

procedure TEVDtoEVDOEMTableFlagTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C3FEDDA034A_var*
//#UC END# *4C07BCBE01F2_4C3FEDDA034A_var*
begin
//#UC START# *4C07BCBE01F2_4C3FEDDA034A_impl*
 TevOEMTableFlagFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C3FEDDA034A_impl*
end;//TEVDtoEVDOEMTableFlagTest.SetFilters

function TEVDtoEVDOEMTableFlagTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDtoEVDOEMTableFlagTest.GetFolder

function TEVDtoEVDOEMTableFlagTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3FEDDA034A';
end;//TEVDtoEVDOEMTableFlagTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.