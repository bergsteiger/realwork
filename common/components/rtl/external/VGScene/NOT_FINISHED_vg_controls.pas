unit NOT_FINISHED_vg_controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vg_controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VGScene::Impl::vg_controls
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  vg_scene
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
 // protected methods
   procedure SetText(const Value: WideString); virtual;
 end;//TvgTextControl

 TvgCustomButton = class(TvgTextControl)
 private
 // private fields
   f_ModalResult : TModalResult;
    {* Поле для свойства ModalResult}
 protected
 // property methods
   procedure pm_SetModalResult(aValue: TModalResult); virtual;
 public
 // public properties
   property ModalResult: TModalResult
     read f_ModalResult
     write pm_SetModalResult;
 end;//TvgCustomButton

 TvgButton = class(TvgCustomButton)
 private
 // private fields
   f_Default : Boolean;
    {* Поле для свойства Default}
   f_Cancel : Boolean;
    {* Поле для свойства Cancel}
 protected
 // property methods
   procedure pm_SetDefault(aValue: Boolean); virtual;
   procedure pm_SetCancel(aValue: Boolean); virtual;
 public
 // public properties
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
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  VGSceneWordsPack
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  ;

// start class TvgTextControl

procedure TvgTextControl.SetText(const Value: WideString);
//#UC START# *4D5E5ACA029B_4D4955ED018F_var*
//#UC END# *4D5E5ACA029B_4D4955ED018F_var*
begin
//#UC START# *4D5E5ACA029B_4D4955ED018F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E5ACA029B_4D4955ED018F_impl*
end;//TvgTextControl.SetText
// start class TvgCustomButton

procedure TvgCustomButton.pm_SetModalResult(aValue: TModalResult);
//#UC START# *4D5E5B530342_4D4955DB0282set_var*
//#UC END# *4D5E5B530342_4D4955DB0282set_var*
begin
//#UC START# *4D5E5B530342_4D4955DB0282set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E5B530342_4D4955DB0282set_impl*
end;//TvgCustomButton.pm_SetModalResult
// start class TvgButton

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
{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgRadioButton
 TtfwClassRef.Register(TvgRadioButton);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgTextControl
 TtfwClassRef.Register(TvgTextControl);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgCustomButton
 TtfwClassRef.Register(TvgCustomButton);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgButton
 TtfwClassRef.Register(TvgButton);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgPanel
 TtfwClassRef.Register(TvgPanel);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgCalloutPanel
 TtfwClassRef.Register(TvgCalloutPanel);
{$IfEnd} //not NoScripts AND not NoVGScene

end.