unit EVDtoEVDSectionRepairTest;
 {* Тест для [IconForPage:175539595] [$175539595] }

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoEVDSectionRepairTest.pas"
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
 TEVDtoEVDSectionRepairTest = {abstract} class(TEVDtoEVDWriterTest)
  {* Тест для [IconForPage:175539595] [$175539595] }
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoEVDSectionRepairTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ddSectionRepair
 , ddSectionWithSub2Para
 , TestFrameWork
;

procedure TEVDtoEVDSectionRepairTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C10D6820047_var*
//#UC END# *4C07BCBE01F2_4C10D6820047_var*
begin
//#UC START# *4C07BCBE01F2_4C10D6820047_impl*
 TddSectionRepairFilter.SetTo(theGenerator);
 TddSectionWithSub2ParaFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C10D6820047_impl*
end;//TEVDtoEVDSectionRepairTest.SetFilters

function TEVDtoEVDSectionRepairTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TEVDtoEVDSectionRepairTest.GetFolder

function TEVDtoEVDSectionRepairTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C10D6820047';
end;//TEVDtoEVDSectionRepairTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
