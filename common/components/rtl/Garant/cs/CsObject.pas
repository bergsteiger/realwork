unit CsObject;

// Модуль: "w:\common\components\rtl\Garant\cs\CsObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TCsObject" MUID: (52FBB30A01C6)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TCsObjectClass = class of TCsObject;

 TCsObject = class(Tl3ProtoObject)
 end;//TCsObject
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *52FBB30A01C6impl_uses*
 //#UC END# *52FBB30A01C6impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
