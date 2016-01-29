unit vcmInternalConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmInternalConst.pas"
// �����: 12.02.2009 19:11
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmInternalConst
//
// ���������� ���������
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
  vcmExternalInterfaces,
  vcmInterfaces,
  vcmUserControls,
  vcmBaseTypes
  ;

const
 vcmToolbarOpTypes = [vcm_otButton, vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup, vcm_otTextButton, vcm_otCheck, vcm_otRadio, vcm_otEdit, vcm_otTyper, vcm_otCombo, vcm_otEditCombo, vcm_otDate];
 vcm_AllOperationOptions = [Low(TvcmOperationOption)..High(TvcmOperationOption)];
 vcm_ComboOperations = [vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup];
 vcm_ComboBoxOperations = [vcm_otCombo, vcm_otEditCombo];
 vcm_UseCaptionFromOperation = [vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup, vcm_otCombo];
  {* ���� ��������, � �������, ��� �������� ������ ����, Caption ����� �����
     �� ��������, � �� Action. ��� �������� � ����� ����, Action.Caption
     ����� ��������� ������� ��������� �������� (��������, ��� ��������
     "�����������" � Caption ����� ��������� �������� "�� ��. ����; ����
     ������� � �.�."), ������� �������� ����� ����� �� �������� }
 vcmOperationsWithIcon = [vcm_otButton, vcm_otCheck, vcm_otTextButton, vcm_otButtonPopup];
 vcm_InternalOperations = [vcm_otInternal];
 vcm_HiddenOperations = vcm_InternalOperations + [vcm_otHidden];
 vcm_SimpleOperations = [vcm_otEdit, vcm_otTyper, vcm_otFontName, vcm_otFontSize, vcm_otDate];
 vcmVisualOperations = [vcm_otButton, vcm_otCheck, vcm_otMenuButtonCombo, vcm_otButtonCombo, vcm_otTextButton, vcm_otCombo, vcm_otTyper, vcm_otEditCombo, vcm_otEdit, vcm_otDate, vcm_otButtonPopup];
 vcm_NotContainedForm = [vcm_ztFloating, vcm_ztModal, vcm_ztManualModal, vcm_ztSimpleFloat];
 vcm_omExecutes = [vcm_omExecute, vcm_omAggregateExecute];
  { �������������� ���� }
 fm_Any : TvcmFormID = (rName : ''; rID : 0);
{$IfEnd} //not NoVCM

implementation

end.