unit NOT_FINISHED_vg_controls;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vg_controls.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vg_controls" MUID: (4CFCE531013A)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vg_scene
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvgPathButton = class
 end;//TvgPathButton

 TvgCloseButton = class
 end;//TvgCloseButton

 TvgRadioButton = class
 end;//TvgRadioButton

 TvgTextControl = class(TvgControl)
  protected
   procedure SetText(const Value: WideString); virtual;
 end;//TvgTextControl

 TvgCustomButton = class(TvgTextControl)
  private
   f_ModalResult: TModalResult;
  protected
   procedure pm_SetModalResult(aValue: TModalResult); virtual;
  public
   property ModalResult: TModalResult
    read f_ModalResult
    write pm_SetModalResult;
 end;//TvgCustomButton

 TvgButton = class(TvgCustomButton)
  private
   f_Default: Boolean;
   f_Cancel: Boolean;
  protected
   procedure pm_SetDefault(aValue: Boolean); virtual;
   procedure pm_SetCancel(aValue: Boolean); virtual;
  public
   property Default: Boolean
    read f_Default
    write pm_SetDefault;
   property Cancel: Boolean
    read f_Cancel
    write pm_SetCancel;
 end;//TvgButton

 TvgCheckBox = class
 end;//TvgCheckBox

 TvgPanel = class(TvgControl)
 end;//TvgPanel

 TvgCalloutPanel = class(TvgPanel)
 end;//TvgCalloutPanel
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , VGSceneWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvgTextControl.SetText(const Value: WideString);
//#UC START# *4D5E5ACA029B_4D4955ED018F_var*
//#UC END# *4D5E5ACA029B_4D4955ED018F_var*
begin
//#UC START# *4D5E5ACA029B_4D4955ED018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E5ACA029B_4D4955ED018F_impl*
end;//TvgTextControl.SetText

procedure TvgCustomButton.pm_SetModalResult(aValue: TModalResult);
//#UC START# *4D5E5B530342_4D4955DB0282set_var*
//#UC END# *4D5E5B530342_4D4955DB0282set_var*
begin
//#UC START# *4D5E5B530342_4D4955DB0282set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E5B530342_4D4955DB0282set_impl*
end;//TvgCustomButton.pm_SetModalResult

procedure TvgButton.pm_SetDefault(aValue: Boolean);
//#UC START# *4D5E5C0A01E6_4CFF5690033Dset_var*
//#UC END# *4D5E5C0A01E6_4CFF5690033Dset_var*
begin
//#UC START# *4D5E5C0A01E6_4CFF5690033Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E5C0A01E6_4CFF5690033Dset_impl*
end;//TvgButton.pm_SetDefault

procedure TvgButton.pm_SetCancel(aValue: Boolean);
//#UC START# *4D5E5C27000E_4CFF5690033Dset_var*
//#UC END# *4D5E5C27000E_4CFF5690033Dset_var*
begin
//#UC START# *4D5E5C27000E_4CFF5690033Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E5C27000E_4CFF5690033Dset_impl*
end;//TvgButton.pm_SetCancel

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgRadioButton);
 {* Регистрация TvgRadioButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgTextControl);
 {* Регистрация TvgTextControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgCustomButton);
 {* Регистрация TvgCustomButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgButton);
 {* Регистрация TvgButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgPanel);
 {* Регистрация TvgPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgCalloutPanel);
 {* Регистрация TvgCalloutPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
