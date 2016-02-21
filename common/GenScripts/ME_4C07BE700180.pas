unit EVDtoEVDEmptyRowTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoEVDEmptyRowTest.pas"
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
 TEVDtoEVDEmptyRowTest = {abstract} class(TEVDtoEVDWriterTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoEVDEmptyRowTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evdEmptyRowFilter
 , TestFrameWork
;

procedure TEVDtoEVDEmptyRowTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C07BE700180_var*
//#UC END# *4C07BCBE01F2_4C07BE700180_var*
begin
//#UC START# *4C07BCBE01F2_4C07BE700180_impl*
 TevdEmptyRowFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C07BE700180_impl*
end;//TEVDtoEVDEmptyRowTest.SetFilters

function TEVDtoEVDEmptyRowTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TEVDtoEVDEmptyRowTest.GetFolder

function TEVDtoEVDEmptyRowTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C07BE700180';
end;//TEVDtoEVDEmptyRowTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
