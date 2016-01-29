unit NOT_FINISHED_AbstractDropDown;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/ComboTree/NOT_FINISHED_AbstractDropDown.pas"
// Начат: 15.05.2008 22:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::ComboTree::TAbstractDropDown
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  ctAbstractEdit
  ;

type
 TAbstractDropDown = class(TctAbstractEdit {$If not defined(NoVCM)}, IvcmPopupIgnoresAction{$IfEnd} //not NoVCM
 )
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function pm_GetPopupIgnoresAction: Boolean;
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure DropDown; virtual;
     {* Сигнатура метода DropDown }
 end;//TAbstractDropDown

implementation

// start class TAbstractDropDown

procedure TAbstractDropDown.DropDown;
//#UC START# *52A9A9B802B4_482C80EA0131_var*
//#UC END# *52A9A9B802B4_482C80EA0131_var*
begin
//#UC START# *52A9A9B802B4_482C80EA0131_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A9A9B802B4_482C80EA0131_impl*
end;//TAbstractDropDown.DropDown

{$If not defined(NoVCM)}
function TAbstractDropDown.pm_GetPopupIgnoresAction: Boolean;
//#UC START# *476964B602C3_482C80EA0131get_var*
//#UC END# *476964B602C3_482C80EA0131get_var*
begin
//#UC START# *476964B602C3_482C80EA0131get_impl*
 Result := FComboStyle = cbEdit;
//#UC END# *476964B602C3_482C80EA0131get_impl*
end;//TAbstractDropDown.pm_GetPopupIgnoresAction
{$IfEnd} //not NoVCM

end.