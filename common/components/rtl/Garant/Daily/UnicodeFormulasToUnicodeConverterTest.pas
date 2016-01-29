unit UnicodeFormulasToUnicodeConverterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/UnicodeFormulasToUnicodeConverterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::UnicodeFormulasToUnicodeConverterTest
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
 TUnicodeFormulasToUnicodeConverterTest = {abstract} class(TEVDtoEVDWriterTest)
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TUnicodeFormulasToUnicodeConverterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evUnicodeFormulasToUnicodeConverter,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TUnicodeFormulasToUnicodeConverterTest

procedure TUnicodeFormulasToUnicodeConverterTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_561E7EAF0288_var*
//#UC END# *4C07BCBE01F2_561E7EAF0288_var*
begin
//#UC START# *4C07BCBE01F2_561E7EAF0288_impl*
 inherited;
 TevUnicodeFormulasToUnicodeConverter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_561E7EAF0288_impl*
end;//TUnicodeFormulasToUnicodeConverterTest.SetFilters

function TUnicodeFormulasToUnicodeConverterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TUnicodeFormulasToUnicodeConverterTest.GetFolder

function TUnicodeFormulasToUnicodeConverterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '561E7EAF0288';
end;//TUnicodeFormulasToUnicodeConverterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.