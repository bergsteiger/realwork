unit kwStringArray;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStringArray.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwStringArray" MUID: (4F3E41930097)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwStringListPrim
;

type
 _l3OpenArray_Parent_ = TkwStringListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 TkwStringArray = class(_l3OpenArray_)
 end;//TkwStringArray
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , kwString
 , l3Memory
 //#UC START# *4F3E41930097impl_uses*
 //#UC END# *4F3E41930097impl_uses*
;

type _Instance_R_ = TkwStringArray;

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
