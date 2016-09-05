unit NOT_FINISHED_l3FontManager;
 {* Классы для работы со шрифтами. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3FontManager.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3FontManager" MUID: (484CE8BC01CC)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3FontManagerPrim
 , l3LogFont
;

type
 Tl3FontManager = class(Tl3FontManagerPrim)
 end;//Tl3FontManager

 Tl3LogFont = l3LogFont.Tl3LogFont;

implementation

uses
 l3ImplUses
 //#UC START# *484CE8BC01CCimpl_uses*
 //#UC END# *484CE8BC01CCimpl_uses*
;

end.
