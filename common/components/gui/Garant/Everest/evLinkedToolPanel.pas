unit evLinkedToolPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evLinkedToolPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::ToolPanel::evLinkedToolPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  evVisualInterfaces,
  evToolPanel,
  Messages
  ;

type
 TevCustomLinkedToolPanel = class(TevCustomToolPanel, IevLinkedToolWindow)
  {* базовый класс для инструментальных панелей, привязанных к Control'ам }
 private
 // private fields
   f_Control : TWinControl;
    {* Поле для свойства Control}
 protected
 // realized methods
   function pm_GetControl: TWinControl;
   procedure pm_SetControl(aValue: TWinControl);
 public
 // overridden public methods
    {$If not defined(NoVCL)}
   procedure MouseWheelHandler(var Message: TMessage); override;
    {$IfEnd} //not NoVCL
 public
 // public properties
   property Control: TWinControl
     read pm_GetControl
     write pm_SetControl;
 end;//TevCustomLinkedToolPanel

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomLinkedToolPanel

function TevCustomLinkedToolPanel.pm_GetControl: TWinControl;
//#UC START# *547CA11F002F_547DA51401F2get_var*
//#UC END# *547CA11F002F_547DA51401F2get_var*
begin
//#UC START# *547CA11F002F_547DA51401F2get_impl*
 Result := f_Control;
//#UC END# *547CA11F002F_547DA51401F2get_impl*
end;//TevCustomLinkedToolPanel.pm_GetControl

procedure TevCustomLinkedToolPanel.pm_SetControl(aValue: TWinControl);
//#UC START# *547CA11F002F_547DA51401F2set_var*
//#UC END# *547CA11F002F_547DA51401F2set_var*
begin
//#UC START# *547CA11F002F_547DA51401F2set_impl*
 if (f_Control <> aValue) then 
  f_Control := aValue;
//#UC END# *547CA11F002F_547DA51401F2set_impl*
end;//TevCustomLinkedToolPanel.pm_SetControl

{$If not defined(NoVCL)}
procedure TevCustomLinkedToolPanel.MouseWheelHandler(var Message: TMessage);
//#UC START# *515317860183_547DA51401F2_var*
//#UC END# *515317860183_547DA51401F2_var*
begin
//#UC START# *515317860183_547DA51401F2_impl*
 if (f_Control = nil) then
  inherited
 else
  with Message do
   Result := f_Control.Perform(Msg, WParam, LParam);
//#UC END# *515317860183_547DA51401F2_impl*
end;//TevCustomLinkedToolPanel.MouseWheelHandler
{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts)}
// Регистрация TevCustomLinkedToolPanel
 TtfwClassRef.Register(TevCustomLinkedToolPanel);
{$IfEnd} //not NoScripts

end.