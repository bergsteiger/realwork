unit EVDtoEVDEmptyRowAndEmptyTableTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoEVDEmptyRowAndEmptyTableTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDtoEVDEmptyRowAndEmptyTableTest" MUID: (51C8347903A2)
// Имя типа: "TEVDtoEVDEmptyRowAndEmptyTableTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDEmptyRowTest
 , l3Variant
;

type
 TEVDtoEVDEmptyRowAndEmptyTableTest = {abstract} class(TEVDtoEVDEmptyRowTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoEVDEmptyRowAndEmptyTableTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evEmptyTableEliminator
 , TestFrameWork
 //#UC START# *51C8347903A2impl_uses*
 //#UC END# *51C8347903A2impl_uses*
;

procedure TEVDtoEVDEmptyRowAndEmptyTableTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_51C8347903A2_var*
//#UC END# *4C07BCBE01F2_51C8347903A2_var*
begin
//#UC START# *4C07BCBE01F2_51C8347903A2_impl*
 inherited;
 TevEmptyTableEliminator.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_51C8347903A2_impl*
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.SetFilters

function TEVDtoEVDEmptyRowAndEmptyTableTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.GetFolder

function TEVDtoEVDEmptyRowAndEmptyTableTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51C8347903A2';
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
