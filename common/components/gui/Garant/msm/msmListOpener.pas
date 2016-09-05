unit msmListOpener;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOpener.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOpener" MUID: (57CD5F5603E5)

{$Include w:\common\components\msm.inc}

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
   procedure DoFire(anEvent: TmsmEvent); override;
 end;//TmsmListOpener

implementation

uses
 l3ImplUses
 , msmMainForm
 , msmListAndTreeInterfaces
 //#UC START# *57CD5F5603E5impl_uses*
 , Windows
 //#UC END# *57CD5F5603E5impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmListOpener.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57CD5F5603E5_var*
//#UC END# *57ADDC3A0071_57CD5F5603E5_var*
begin
//#UC START# *57ADDC3A0071_57CD5F5603E5_impl*
 inherited;
 if (anEvent = ActionElementEvent.Instance) then
 begin
  if (GetAsyncKeyState(VK_SHIFT) < 0) then
   TmsmMainForm.RunWithList(Self.ModelToListen.ElementToAction)
  else
  if (GetAsyncKeyState(VK_CONTROL) < 0) then
   TmsmMainForm.RunWithList(Self.ModelToListen.ElementToAction)
  else
   Self.ModelToFire.ShowElementAsDir(Self.ModelToListen.ElementToAction);
 end;//anEvent = ActionElementEvent.Instance
//#UC END# *57ADDC3A0071_57CD5F5603E5_impl*
end;//TmsmListOpener.DoFire

end.
