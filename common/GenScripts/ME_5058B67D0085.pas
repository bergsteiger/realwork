unit nscSizeGripPanel;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSizeGripPanel.pas"
// Стереотип: "GuiControl"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , StatusBarUtils
 , nscNewInterfaces
 , Messages
;

type
 _nscStatusBarItemNotification_Parent_ = TSizeGripPanel;
 {$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}
 TnscSizeGripPanel = class(_nscStatusBarItemNotification_)
  protected
   {$If NOT Defined(NoTB97)}
   function GetFormToResize: TCustomForm; override;
   {$IfEnd} // NOT Defined(NoTB97)
 end;//TnscSizeGripPanel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}

{$If NOT Defined(NoTB97)}
function TnscSizeGripPanel.GetFormToResize: TCustomForm;
//#UC START# *53CE39CD0045_5058B67D0085_var*

 function lp_GetTopmostParentForm(aForm: TCustomForm): TCustomForm;
 var
  l_Control: TWinControl;
  l_Parent: TWinControl;
 begin
  Assert(aForm <> nil);
  lp_GetTopmostParentForm := nil;  
  l_Control := aForm;
  while true do
  begin
   l_Parent := l_Control.Parent;
   if (l_Parent = nil) then
   begin
    if (l_Control is TCustomForm) then
    begin
     lp_GetTopmostParentForm := TCustomForm(l_Control);
     Break;
    end
    else
    begin
     lp_GetTopmostParentForm := aForm;
     Break;
    end;
   end;
   l_Control := l_Parent;
  end;
 end;//lp_GetTopmostParentForm

var
 l_ParentForm: TCustomForm;
//#UC END# *53CE39CD0045_5058B67D0085_var*
begin
//#UC START# *53CE39CD0045_5058B67D0085_impl*
 l_ParentForm := inherited GetFormToResize;
 if (l_ParentForm <> nil) then
  l_ParentForm := lp_GetTopmostParentForm(l_ParentForm);
 Result := l_ParentForm;
//#UC END# *53CE39CD0045_5058B67D0085_impl*
end;//TnscSizeGripPanel.GetFormToResize
{$IfEnd} // NOT Defined(NoTB97)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscSizeGripPanel);
 {* Регистрация TnscSizeGripPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
