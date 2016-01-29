unit nscSizeGripPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscSizeGripPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::StatusBar::TnscSizeGripPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoTB97)}
  ,
  tb97Ctls
  {$IfEnd} //not NoTB97
  ,
  Messages,
  nscNewInterfaces,
  StatusBarUtils,
  Controls {a}
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 _nscStatusBarItemNotification_Parent_ = TSizeGripPanel;
 {$Include ..\Nemesis\nscStatusBarItemNotification.imp.pas}
 TnscSizeGripPanel = class(_nscStatusBarItemNotification_)
 protected
 // overridden protected methods
    {$If not defined(NoTB97)}
   function GetFormToResize: TCustomForm; override;
    {$IfEnd} //not NoTB97
 end;//TnscSizeGripPanel
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

{$Include ..\Nemesis\nscStatusBarItemNotification.imp.pas}

// start class TnscSizeGripPanel

{$If not defined(NoTB97)}
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
{$IfEnd} //not NoTB97

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscSizeGripPanel
 TtfwClassRef.Register(TnscSizeGripPanel);
{$IfEnd} //Nemesis AND not NoScripts

end.