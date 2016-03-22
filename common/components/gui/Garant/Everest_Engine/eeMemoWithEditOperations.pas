unit eeMemoWithEditOperations;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeMemoWithEditOperations.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TeeMemoWithEditOperations" MUID: (4AC5D3380185)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , eeMemo
 , evEditorWithOperations
;

type
 TeeMemoWithEditOperations = class(TeeMemo)
  protected
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* Какие операции публикуются компонентом. }
 end;//TeeMemoWithEditOperations

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TeeMemoWithEditOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
 {* Какие операции публикуются компонентом. }
//#UC START# *48735C4A03C3_4AC5D3380185_var*
//#UC END# *48735C4A03C3_4AC5D3380185_var*
begin
//#UC START# *48735C4A03C3_4AC5D3380185_impl*
 Result := [potEdit];
//#UC END# *48735C4A03C3_4AC5D3380185_impl*
end;//TeeMemoWithEditOperations.DefineProvideOperations

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeMemoWithEditOperations);
 {* Регистрация TeeMemoWithEditOperations }
{$IfEnd} // NOT Defined(NoScripts)

end.
