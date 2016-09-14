unit msmTreeView;

// Модуль: "w:\common\components\gui\Garant\msm\msmTreeView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmTreeView" MUID: (57B4565F007C)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtOutliner
;

type
 TmsmTreeView = class(TvtOutliner)
  protected
   procedure Invalidate;
    {* Запрос на перерисовку. }
 end;//TmsmTreeView

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B4565F007Cimpl_uses*
 //#UC END# *57B4565F007Cimpl_uses*
;

procedure TmsmTreeView.Invalidate;
 {* Запрос на перерисовку. }
//#UC START# *46A5AA4B003C_57B4565F007C_var*
//#UC END# *46A5AA4B003C_57B4565F007C_var*
begin
//#UC START# *46A5AA4B003C_57B4565F007C_impl*
 inherited;
//#UC END# *46A5AA4B003C_57B4565F007C_impl*
end;//TmsmTreeView.Invalidate

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmTreeView);
 {* Регистрация TmsmTreeView }
{$IfEnd} // NOT Defined(NoScripts)

end.
