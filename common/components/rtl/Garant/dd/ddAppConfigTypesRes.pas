unit ddAppConfigTypesRes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfigTypesRes" MUID: (4B9E68040166)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_ddcmInvalidIntegerValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidIntegerValue'; rValue : 'Введенное вами значение ''%s'' не является числом.');
  {* 'Введенное вами значение ''%s'' не является числом.' }
 str_ddcmErrorIntegerRange: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmErrorIntegerRange'; rValue : 'Введенное вами число ''%d'' находится вне диапазона ''%d-%d''.');
  {* 'Введенное вами число ''%d'' находится вне диапазона ''%d-%d''.' }
 str_ddcmInvalidMaxValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMaxValue'; rValue : 'Максимальное значение %d не может превышать %d');
  {* 'Максимальное значение %d не может превышать %d' }
 str_ddcmInvalidMinValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMinValue'; rValue : 'Минимальное значение %d не может быть меньше %d');
  {* 'Минимальное значение %d не может быть меньше %d' }
 str_ddcmSelectButton: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmSelectButton'; rValue : 'Выбрать');
  {* 'Выбрать' }
 str_ddcmFontExample: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmFontExample'; rValue : 'Пример шрифта');
  {* 'Пример шрифта' }
 str_ddcmInvalidMapValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMapValue'; rValue : 'Введенное значение не найдено в списке допустимых');
  {* 'Введенное значение не найдено в списке допустимых' }

implementation

uses
 l3ImplUses
 //#UC START# *4B9E68040166impl_uses*
 //#UC END# *4B9E68040166impl_uses*
;

initialization
 str_ddcmInvalidIntegerValue.Init;
 {* Инициализация str_ddcmInvalidIntegerValue }
 str_ddcmErrorIntegerRange.Init;
 {* Инициализация str_ddcmErrorIntegerRange }
 str_ddcmInvalidMaxValue.Init;
 {* Инициализация str_ddcmInvalidMaxValue }
 str_ddcmInvalidMinValue.Init;
 {* Инициализация str_ddcmInvalidMinValue }
 str_ddcmSelectButton.Init;
 {* Инициализация str_ddcmSelectButton }
 str_ddcmFontExample.Init;
 {* Инициализация str_ddcmFontExample }
 str_ddcmInvalidMapValue.Init;
 {* Инициализация str_ddcmInvalidMapValue }

end.
