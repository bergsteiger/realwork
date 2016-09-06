unit msmListToCaptionBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListToCaptionBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListToCaptionBinding" MUID: (57CD32BB0369)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmEvents
 , msmControllers
 , msmController
;

type
 _ModelToListen_ = ImsmListModel;
 _ModelToFire_ = ImsmCaptionModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmListToCaptionBinding = class(_msmModelToModelBinding_)
  protected
   procedure DoListChangedEvent(anEvent: TmsmEvent);
   procedure LinkDataToView; override;
   procedure LinkEventHandlers; override;
 end;//TmsmListToCaptionBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57CD32BB0369impl_uses*
 //#UC END# *57CD32BB0369impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmListToCaptionBinding.DoListChangedEvent(anEvent: TmsmEvent);
//#UC START# *57CD32BB0369_57ADBA39026E_57CD32BB0369_var*
//#UC END# *57CD32BB0369_57ADBA39026E_57CD32BB0369_var*
begin
//#UC START# *57CD32BB0369_57ADBA39026E_57CD32BB0369_impl*
 inherited;
 ModelToFire.Caption := ModelToListen.List.Owner.Name;
//#UC END# *57CD32BB0369_57ADBA39026E_57CD32BB0369_impl*
end;//TmsmListToCaptionBinding.DoListChangedEvent

procedure TmsmListToCaptionBinding.LinkDataToView;
//#UC START# *57B6A49900F4_57CD32BB0369_var*
//#UC END# *57B6A49900F4_57CD32BB0369_var*
begin
//#UC START# *57B6A49900F4_57CD32BB0369_impl*
 inherited;
 ModelToFire.Caption := ModelToListen.List.Owner.Name;
//#UC END# *57B6A49900F4_57CD32BB0369_impl*
end;//TmsmListToCaptionBinding.LinkDataToView

procedure TmsmListToCaptionBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
end;//TmsmListToCaptionBinding.LinkEventHandlers

end.
