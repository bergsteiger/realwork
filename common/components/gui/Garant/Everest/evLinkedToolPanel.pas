unit evLinkedToolPanel;

// Модуль: "w:\common\components\gui\Garant\Everest\evLinkedToolPanel.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evLinkedToolPanel" MUID: (547DA4F701F9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evToolPanel
 , evVisualInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
;

type
 TevCustomLinkedToolPanel = class(TevCustomToolPanel, IevLinkedToolWindow)
  {* базовый класс для инструментальных панелей, привязанных к Control'ам }
  private
   f_Control: TWinControl;
  protected
   function pm_GetControl: TWinControl;
   procedure pm_SetControl(aValue: TWinControl);
  public
   {$If NOT Defined(NoVCL)}
   procedure MouseWheelHandler(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property Control: TWinControl
    read pm_GetControl
    write pm_SetControl;
 end;//TevCustomLinkedToolPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *547DA4F701F9impl_uses*
 //#UC END# *547DA4F701F9impl_uses*
;

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

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomLinkedToolPanel);
 {* Регистрация TevCustomLinkedToolPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
