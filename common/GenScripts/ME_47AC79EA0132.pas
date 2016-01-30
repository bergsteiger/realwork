unit l3Dict;
 {* описание объекта-"словаря" }

// Модуль: "w:\common\components\rtl\Garant\L3\l3Dict.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3DictionaryPrim
 , l3IDIndex
 , l3Interfaces
 , l3Types
;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3Dictionary_Parent_ = Tl3DictionaryPrim;
 {$Include l3Dictionary.imp.pas}
 Tl3Dictionary = class(_l3Dictionary_)
  {* Словарь. Используется для преобразования строки в идентификатор и наоборот. Имеет два индекса сортировки }
 end;//Tl3Dictionary

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
;

type _Instance_R_ = Tl3Dictionary;

{$Include l3Dictionary.imp.pas}

end.
