unit msmListOpener;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOpener.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOpener" MUID: (57CD5F5603E5)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToListBinding
 , msmEvents
;

type
 TmsmListOpener = class(TmsmListToListBinding)
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
 , msmModelElements
 //#UC END# *57CD5F5603E5impl_uses*
;

procedure TmsmListOpener.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_var*
var
 l_E : ImsmModelElement;
//#UC END# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_var*
begin
//#UC START# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_impl*
 inherited;
 l_E := Self.ModelToListen.ElementToAction;
 if (l_E = nil) then
  Exit;
 if l_E.IsSameElement(Self.ModelToListen.List.Owner) then
  l_E := Self.ModelToListen.List.Owner.Parent;
 if (l_E = nil) then
  Exit;
 if (GetAsyncKeyState(VK_SHIFT) < 0) then
  TmsmOpenService.Instance.OpenListInNewWindow(l_E)
 else
 if (GetAsyncKeyState(VK_CONTROL) < 0) then
  TmsmOpenService.Instance.OpenListInNewWindow(l_E)
 else
  Self.ModelToFire.ShowElementAsList(l_E);
//#UC END# *57CD5F5603E5_57B2B0C602DF_57CD5F5603E5_impl*
end;//TmsmListOpener.DoActionElementEvent

procedure TmsmListOpener.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
end;//TmsmListOpener.LinkEventHandlers

end.
