unit k2OwnedTypedHugeListTag;

// Модуль: "w:\common\components\rtl\Garant\K2\k2OwnedTypedHugeListTag.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2OwnedTypedHugeListTag" MUID: (527B9A3F0164)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedHugeListTag
 , l3Variant
;

type
 _k2OwnedTagObject_Parent_ = Tk2TypedHugeListTag;
 {$Include w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas}
 Tk2OwnedTypedHugeListTag = class(_k2OwnedTagObject_)
 end;//Tk2OwnedTypedHugeListTag

implementation

uses
 l3ImplUses
 , k2Base
 , SysUtils
 , k2NullTagImpl
 , l3BitArr
 , l3Memory
;

{$Include w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas}

end.
