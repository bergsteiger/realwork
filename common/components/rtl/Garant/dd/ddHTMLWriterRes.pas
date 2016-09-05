unit ddHTMLWriterRes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddHTMLWriterRes" MUID: (4B9E548D0157)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_ddmmMultiLinkTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmMultiLinkTitle'; rValue : '%s - Список множественных ссылок');
  {* '%s - Список множественных ссылок' }

implementation

uses
 l3ImplUses
 //#UC START# *4B9E548D0157impl_uses*
 //#UC END# *4B9E548D0157impl_uses*
;

initialization
 str_ddmmMultiLinkTitle.Init;
 {* Инициализация str_ddmmMultiLinkTitle }

end.
