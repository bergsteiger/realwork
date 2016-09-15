unit msmParentedViewControllerWithOwnership;

// Модуль: "w:\common\components\gui\Garant\msm\msmParentedViewControllerWithOwnership.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmParentedViewControllerWithOwnership" MUID: (57DA78D6035A)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmParentedViewController
;

type
 TmsmParentedViewControllerWithOwnership = class(TmsmParentedViewController)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//TmsmParentedViewControllerWithOwnership

implementation

uses
 l3ImplUses
 //#UC START# *57DA78D6035Aimpl_uses*
 , SysUtils
 , msmControllers
 //#UC END# *57DA78D6035Aimpl_uses*
;

procedure TmsmParentedViewControllerWithOwnership.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57DA78D6035A_var*
var
 l_View : TmsmView;
//#UC END# *479731C50290_57DA78D6035A_var*
begin
//#UC START# *479731C50290_57DA78D6035A_impl*
 l_View := Self.View;
 inherited;
 Assert(l_View.Parent = nil);
 FreeAndNil(l_View);
//#UC END# *479731C50290_57DA78D6035A_impl*
end;//TmsmParentedViewControllerWithOwnership.Cleanup

end.
