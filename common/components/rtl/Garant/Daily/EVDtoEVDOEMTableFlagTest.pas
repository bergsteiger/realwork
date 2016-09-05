unit EVDtoEVDOEMTableFlagTest;
 {* Тест фильтра"'Выливать в псевдографику" }

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoEVDOEMTableFlagTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDtoEVDOEMTableFlagTest" MUID: (4C3FEDDA034A)
// Имя типа: "TEVDtoEVDOEMTableFlagTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TEVDtoEVDOEMTableFlagTest = {abstract} class(TEVDtoEVDWriterTest)
  {* Тест фильтра"'Выливать в псевдографику" }
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoEVDOEMTableFlagTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOEMTableFlagFilter
 , TestFrameWork
 //#UC START# *4C3FEDDA034Aimpl_uses*
 //#UC END# *4C3FEDDA034Aimpl_uses*
;

procedure TEVDtoEVDOEMTableFlagTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C3FEDDA034A_var*
//#UC END# *4C07BCBE01F2_4C3FEDDA034A_var*
begin
//#UC START# *4C07BCBE01F2_4C3FEDDA034A_impl*
 TevOEMTableFlagFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C3FEDDA034A_impl*
end;//TEVDtoEVDOEMTableFlagTest.SetFilters

function TEVDtoEVDOEMTableFlagTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TEVDtoEVDOEMTableFlagTest.GetFolder

function TEVDtoEVDOEMTableFlagTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3FEDDA034A';
end;//TEVDtoEVDOEMTableFlagTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
