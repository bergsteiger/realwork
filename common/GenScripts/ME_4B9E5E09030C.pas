unit ddAppConfigListsRes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigListsRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ConfigMessages }
 str_ddcmAddConfigValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmAddConfigValue'; rValue : 'Добавить');
  {* 'Добавить' }
 str_ddcmChangeConfigValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmChangeConfigValue'; rValue : 'Исправить');
  {* 'Исправить' }
 str_ddcmDeleteConfigValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmDeleteConfigValue'; rValue : 'Удалить');
  {* 'Удалить' }
 str_ddcmConfirmDeleteConfigValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmConfirmDeleteConfigValue'; rValue : 'Вы действительно хотите удалить элемент "%s"?');
  {* 'Вы действительно хотите удалить элемент "%s"?' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_ddcmAddConfigValue.Init;
 {* Инициализация str_ddcmAddConfigValue }
 str_ddcmChangeConfigValue.Init;
 {* Инициализация str_ddcmChangeConfigValue }
 str_ddcmDeleteConfigValue.Init;
 {* Инициализация str_ddcmDeleteConfigValue }
 str_ddcmConfirmDeleteConfigValue.Init;
 {* Инициализация str_ddcmConfirmDeleteConfigValue }

end.
