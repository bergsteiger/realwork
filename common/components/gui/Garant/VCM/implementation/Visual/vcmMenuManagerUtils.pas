unit vcmMenuManagerUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMenuManagerUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmMenuManagerUtils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  
  ;

procedure RequestClearPopup(aPopup: TPopupMenu);
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Windows,
  vcmMessages
  ;

// unit methods

procedure RequestClearPopup(aPopup: TPopupMenu);
//#UC START# *52AB0A580216_52AB0A3703E2_var*
//#UC END# *52AB0A580216_52AB0A3703E2_var*
begin
//#UC START# *52AB0A580216_52AB0A3703E2_impl*
 if (Application.MainForm <> nil) then
  PostMessage(Application.MainForm.Handle, vcm_msgClearPopup, 0, LParam(aPopup));
//#UC END# *52AB0A580216_52AB0A3703E2_impl*
end;//RequestClearPopup
{$IfEnd} //not NoVCM

end.