unit IntStackFromComponent;

// Модуль: "w:\common\components\SandBox\IntStackFromComponent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TIntStackFromComponent" MUID: (5155852403BB)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 _ItemType_ = Integer;
 _StackPrim_Parent_ = TComponent;
 {$Include w:\common\components\SandBox\StackPrim.imp.pas}
 TIntStackFromComponent = class(_StackPrim_)
 end;//TIntStackFromComponent

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\SandBox\StackPrim.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TIntStackFromComponent);
 {* Регистрация TIntStackFromComponent }
{$IfEnd} // NOT Defined(NoScripts)

end.
