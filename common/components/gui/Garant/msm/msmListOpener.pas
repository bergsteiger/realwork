unit msmListOpener;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOpener.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOpener" MUID: (57CD5F5603E5)

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
 _ModelToListen_ = ImsmListLikeModel;
 _ModelToFire_ = ImsmListModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmListOpener = class(_msmModelToModelBinding_)
  protected
   procedure DoActionElementEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmListOpener

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 , msmOpenService
 //#UC START# *57CD5F5603E5impl_uses*
 , Windows
 //#UC END# *57CD5F5603E5impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmListOpener.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_var*
//#UC END# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_var*
begin
//#UC START# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_impl*
 inherited;
 if (GetAsyncKeyState(VK_SHIFT) < 0) then
  TmsmOpenService.Instance.OpenListInNewWindow(Self.ModelToListen.ElementToAction)
 else
 if (GetAsyncKeyState(VK_CONTROL) < 0) then
  TmsmOpenService.Instance.OpenListInNewWindow(Self.ModelToListen.ElementToAction)
 else
  Self.ModelToFire.ShowElementAsDir(Self.ModelToListen.ElementToAction);
//#UC END# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_impl*
end;//TmsmListOpener.DoActionElementEvent

procedure TmsmListOpener.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
end;//TmsmListOpener.LinkEventHandlers

end.
