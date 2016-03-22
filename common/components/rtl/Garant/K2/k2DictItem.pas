unit k2DictItem;
 {* Словарная запись, со ссылкой на родительский тег }

// Модуль: "w:\common\components\rtl\Garant\K2\k2DictItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2DictItem" MUID: (484D42AC01C3)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2DictRecTag
 , l3BitArr
 , k2Base
 , l3Variant
 , k2BaseStruct
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

type
 _HashType_ = Tl3OneBytePtrHash;
 _k2HashTag_Parent_ = Tk2DictRecTag;
 {$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}
 _k2ParentedTagObject_Parent_ = _k2HashTag_;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 Tk2DictItem = class(_k2ParentedTagObject_)
  {* Словарная запись, со ссылкой на родительский тег }
 end;//Tk2DictItem

implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
 , l3String
 , k2Except
 , k2Strings
 , TypInfo
 , l3Stream
 , l3Base
 , k2Facade
 , Classes
 , k2OList_Const
 , k2Dictionary
 , k2NonOptimizeContext
 , k2VariantImpl
 , k2Bool_Const
 , k2String
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , k2InterfaceFactory
 , k2List
;

type _Instance_R_ = Tk2DictItem;

{$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

end.
