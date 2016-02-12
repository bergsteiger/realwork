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
 {$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}
 Tl3Dictionary = class(_l3Dictionary_)
  {* Словарь. Используется для преобразования строки в идентификатор и наоборот. Имеет два индекса сортировки }
 end;//Tl3Dictionary

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
 , l3Variant
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3PrimString;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = Tl3Dictionary;

{$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}

end.
