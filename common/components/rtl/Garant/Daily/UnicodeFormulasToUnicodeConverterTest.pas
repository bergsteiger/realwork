unit UnicodeFormulasToUnicodeConverterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\UnicodeFormulasToUnicodeConverterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "UnicodeFormulasToUnicodeConverterTest" MUID: (561E7EAF0288)
// Имя типа: "TUnicodeFormulasToUnicodeConverterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TUnicodeFormulasToUnicodeConverterTest = {abstract} class(TEVDtoEVDWriterTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TUnicodeFormulasToUnicodeConverterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evUnicodeFormulasToUnicodeConverter
 , TestFrameWork
 //#UC START# *561E7EAF0288impl_uses*
 //#UC END# *561E7EAF0288impl_uses*
;

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
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TUnicodeFormulasToUnicodeConverterTest.GetFolder

function TUnicodeFormulasToUnicodeConverterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561E7EAF0288';
end;//TUnicodeFormulasToUnicodeConverterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
