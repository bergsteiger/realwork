unit arFiltersUtils;

// Модуль: "w:\archi\source\projects\Common\Utils\arFiltersUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arFiltersUtils" MUID: (57D9125001E9)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , nevInternalInterfaces
;

procedure evLinkTableFilters(var aGen: Tk2TagGenerator;
 aNeedInit: Boolean);

{$If Defined(nsTest)}
var g_DisableMergeCellFilter: Boolean = False;
{$IfEnd} // Defined(nsTest)

implementation

uses
 l3ImplUses
 , evTabStopsFilter
 , evdEmptyRowFilter
 , evTableFilter
 , evMergedCellFilter
 , evTextInTableCorrector
 //#UC START# *57D9125001E9impl_uses*
 //#UC END# *57D9125001E9impl_uses*
;

procedure evLinkTableFilters(var aGen: Tk2TagGenerator;
 aNeedInit: Boolean);
//#UC START# *517F693A03DF_57D9125001E9_var*
//#UC END# *517F693A03DF_57D9125001E9_var*
begin
//#UC START# *517F693A03DF_57D9125001E9_impl*
 if aNeedInit then
  aGen := nil;
 TevdEmptyRowFilter.SetTo(aGen);
 TevTableFilter.SetTo(aGen);
 {$IFDEF nsTest}
 if not g_DisableMergeCellFilter then
 {$ENDIF nsTest}
  TevMergedCellFilter.SetTo(aGen);
 {$IFDEF nsTest}
 g_DisableMergeCellFilter := False;
 {$ENDIF nsTest}
 TevTabStopsFilter.SetTo(aGen);
 TevTextInTableCorrector.SetTo(aGen);
//#UC END# *517F693A03DF_57D9125001E9_impl*
end;//evLinkTableFilters

end.
