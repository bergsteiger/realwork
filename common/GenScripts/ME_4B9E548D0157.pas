unit ddHTMLWriterRes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas"
// Стереотип: "UtilityPack"

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
 , l3MessageID
;

initialization
 str_ddmmMultiLinkTitle.Init;
 {* Инициализация str_ddmmMultiLinkTitle }

end.
