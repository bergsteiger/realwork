unit l3ObjectRefArray;
 {* "Открытый массив". Список, который автоматически расширяется при добавлении элемента за гранецей диапазона }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectRefArray.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObjectRefList
;

type
 _l3OpenArray_Parent_ = Tl3ProtoObjectRefList;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 Tl3ObjectRefArray = class(_l3OpenArray_)
  {* "Открытый массив". Список, который автоматически расширяется при добавлении элемента за гранецей диапазона }
 end;//Tl3ObjectRefArray

implementation

uses
 l3ImplUses
 , l3Base
 , l3ProtoObject
 , l3Memory
;

type _Instance_R_ = Tl3ObjectRefArray;

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

end.
