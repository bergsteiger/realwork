unit ddAppConfigRes;
 {* Ресурсы для ddAppConfig }

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_ddmmSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmSettingsCaption'; rValue : 'Настройка конфигурации');
  {* 'Настройка конфигурации' }
 str_ddmmErrorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmErrorCaption'; rValue : 'Ошибка');
  {* 'Ошибка' }
 {* Локализуемые строки Errors }
 str_DifferentType: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DifferentType'; rValue : 'Тип свойства "%s" отличается от запрошенного');
  {* 'Тип свойства "%s" отличается от запрошенного' }
 str_PropertyAbsent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyAbsent'; rValue : 'Свойство "%s" отсутствует');
  {* 'Свойство "%s" отсутствует' }
 str_PropertyExists: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyExists'; rValue : 'Свойство с именем "%s" уже существует');
  {* 'Свойство с именем "%s" уже существует' }
 str_ListEmpty: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEmpty'; rValue : 'Конфигурация пуста');
  {* 'Конфигурация пуста' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_ddmmSettingsCaption.Init;
 {* Инициализация str_ddmmSettingsCaption }
 str_ddmmErrorCaption.Init;
 {* Инициализация str_ddmmErrorCaption }
 str_DifferentType.Init;
 {* Инициализация str_DifferentType }
 str_PropertyAbsent.Init;
 {* Инициализация str_PropertyAbsent }
 str_PropertyExists.Init;
 {* Инициализация str_PropertyExists }
 str_ListEmpty.Init;
 {* Инициализация str_ListEmpty }

end.
