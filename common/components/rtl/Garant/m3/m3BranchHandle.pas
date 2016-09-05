unit m3BranchHandle;

// Модуль: "w:\common\components\rtl\Garant\m3\m3BranchHandle.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3BranchHandle" MUID: (5453ACDE0177)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3BranchHandlePrim
;

type
 Tm3BranchHandle = class(Tm3BranchHandlePrim)
  public
   NormalForms: Pm3BranchHandlePrim;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//Tm3BranchHandle

implementation

uses
 l3ImplUses
 , m3NormalFormsManager
 //#UC START# *5453ACDE0177impl_uses*
 //#UC END# *5453ACDE0177impl_uses*
;

procedure Tm3BranchHandle.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5453ACDE0177_var*
//#UC END# *479731C50290_5453ACDE0177_var*
begin
//#UC START# *479731C50290_5453ACDE0177_impl*
 inherited;
 if Tm3NormalFormsManager.Exists then
  Tm3NormalFormsManager.Instance.FreeItem(NormalForms);
//#UC END# *479731C50290_5453ACDE0177_impl*
end;//Tm3BranchHandle.Cleanup

end.
