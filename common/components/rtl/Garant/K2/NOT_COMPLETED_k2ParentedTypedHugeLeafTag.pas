unit NOT_COMPLETED_k2ParentedTypedHugeLeafTag;
 {* Листьевой тег с заранее определённым типом, имеющий ссылку на родителя и могущий иметь БОЛЕЕ 32 (включительно) атрибутов }

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_COMPLETED_k2ParentedTypedHugeLeafTag.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2ParentedTypedHugeLeafTag" MUID: (4E8347810088)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2LeafTag
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

 {$Define k2Tag_No_f_TagType}

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = Tk2LeafTag;
 {$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}
 _k2ParentedTagObject_Parent_ = _k2HashTag_;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 Tk2ParentedTypedHugeLeafTag = class(_k2ParentedTagObject_)
  {* Листьевой тег с заранее определённым типом, имеющий ссылку на родителя и могущий иметь БОЛЕЕ 32 (включительно) атрибутов }
 end;//Tk2ParentedTypedHugeLeafTag

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

type _Instance_R_ = Tk2ParentedTypedHugeLeafTag;

{$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

end.
