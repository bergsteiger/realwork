unit msmListOwnerNameToCaptionBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOwnerNameToCaptionBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOwnerNameToCaptionBinding" MUID: (57CD32BB0369)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToCaptionBinding
 , msmEvents
;

type
 TmsmListOwnerNameToCaptionBinding = class(TmsmListToCaptionBinding)
  protected
   procedure DoListChangedEvent(anEvent: TmsmEvent);
   procedure LinkDataToView; override;
   procedure LinkEventHandlers; override;
 end;//TmsmListOwnerNameToCaptionBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57CD32BB0369impl_uses*
 //#UC END# *57CD32BB0369impl_uses*
;

procedure TmsmListOwnerNameToCaptionBinding.DoListChangedEvent(anEvent: TmsmEvent);
//#UC START# *57CD32BB0369_57ADBA39026E_57CD32BB0369_var*
//#UC END# *57CD32BB0369_57ADBA39026E_57CD32BB0369_var*
begin
//#UC START# *57CD32BB0369_57ADBA39026E_57CD32BB0369_impl*
 inherited;
 ModelToFire.Caption := ModelToListen.List.Owner.Name;
//#UC END# *57CD32BB0369_57ADBA39026E_57CD32BB0369_impl*
end;//TmsmListOwnerNameToCaptionBinding.DoListChangedEvent

procedure TmsmListOwnerNameToCaptionBinding.LinkDataToView;
//#UC START# *57B6A49900F4_57CD32BB0369_var*
//#UC END# *57B6A49900F4_57CD32BB0369_var*
begin
//#UC START# *57B6A49900F4_57CD32BB0369_impl*
 inherited;
 ModelToFire.Caption := ModelToListen.List.Owner.Name;
//#UC END# *57B6A49900F4_57CD32BB0369_impl*
end;//TmsmListOwnerNameToCaptionBinding.LinkDataToView

procedure TmsmListOwnerNameToCaptionBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
end;//TmsmListOwnerNameToCaptionBinding.LinkEventHandlers

end.
