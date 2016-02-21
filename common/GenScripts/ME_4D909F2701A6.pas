unit EVDtoEVDBlockNameAdderTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoEVDBlockNameAdderTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TEVDtoEVDBlockNameAdderTest = {abstract} class(TEVDtoEVDWriterTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoEVDBlockNameAdderTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evdBlockNameAdder
 , TestFrameWork
;

procedure TEVDtoEVDBlockNameAdderTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4D909F2701A6_var*
//#UC END# *4C07BCBE01F2_4D909F2701A6_var*
begin
//#UC START# *4C07BCBE01F2_4D909F2701A6_impl*
 TevdBlockNameAdder.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4D909F2701A6_impl*
end;//TEVDtoEVDBlockNameAdderTest.SetFilters

function TEVDtoEVDBlockNameAdderTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TEVDtoEVDBlockNameAdderTest.GetFolder

function TEVDtoEVDBlockNameAdderTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D909F2701A6';
end;//TEVDtoEVDBlockNameAdderTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
