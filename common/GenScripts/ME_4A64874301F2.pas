unit k2ParentedTypedSmallLeafTag;
 {* Листьевой тег с заранее определённым типом, имеющий ссылку на родителя и могущий иметь НЕ более 32 (включительно) атрибутов }

// Модуль: "w:\common\components\rtl\Garant\K2\k2ParentedTypedSmallLeafTag.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedSmallLeafTag
 , l3Variant
;

type
 //#UC START# *4A64874301F2ci*
 {$Define k2Tag_No_f_TagType}
 //#UC END# *4A64874301F2ci*
 _k2ParentedTagObject_Parent_ = Tk2TypedSmallLeafTag;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 //#UC START# *4A64874301F2cit*
 //#UC END# *4A64874301F2cit*
 Tk2ParentedTypedSmallLeafTag = class(_k2ParentedTagObject_)
  {* Листьевой тег с заранее определённым типом, имеющий ссылку на родителя и могущий иметь НЕ более 32 (включительно) атрибутов }
 //#UC START# *4A64874301F2publ*
 //#UC END# *4A64874301F2publ*
 end;//Tk2ParentedTypedSmallLeafTag

implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
 , l3BitArr
;

{$If not Declared(_HashType_)}type _HashType_ = Tl3OneBytePtrHash;{$IfEnd}

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

//#UC START# *4A64874301F2impl*
//#UC END# *4A64874301F2impl*

end.
