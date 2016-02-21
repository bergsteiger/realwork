unit evGeneratorUtils;

// Модуль: "w:\common\components\gui\Garant\Everest\evGeneratorUtils.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagGen
 , evdStyles
;

procedure evSetFilters4PDF(var aGenerator: Tk2TagGenerator;
 aHiddenStyles: TevStandardStyles);

implementation

uses
 l3ImplUses
 , evHiddenFilter
 , evdPageParamsFilter
 , evUserCommentFilter
 , evStyleHeaderAdder
;

procedure evSetFilters4PDF(var aGenerator: Tk2TagGenerator;
 aHiddenStyles: TevStandardStyles);
//#UC START# *5549F1C50037_5549F1AA032E_var*
//#UC END# *5549F1C50037_5549F1AA032E_var*
begin
//#UC START# *5549F1C50037_5549F1AA032E_impl*
 TevdPageParamsFilter.SetToA4(aGenerator); // {Requestlink:564248678}: Размер страницы А4.
 {$IFNDEF Nemesis}
 TevStyleHeaderAdder.SetTo(aGenerator);
 {$ENDIF Nemesis}
 TevUserCommentFilter.SetTo(aGenerator);
 TevHiddenFilter.SetTo(aHiddenStyles, true, aGenerator);
//#UC END# *5549F1C50037_5549F1AA032E_impl*
end;//evSetFilters4PDF

end.
