unit vcmCustomizeToolsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmCustomizeToolsRes.pas"
// �����: 03.03.2010 20:31
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmCustomizeToolsRes
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
  vcmUserControls,
  l3StringIDEx
  ;

var
  { ������������ ������ ToolbarPos }
 str_vcmetbpTop : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpTop'; rValue : '�������');
  { '�������' }
 str_vcmetbpBottom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpBottom'; rValue : '������');
  { '������' }
 str_vcmetbpLeft : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpLeft'; rValue : '�����');
  { '�����' }
 str_vcmetbpRight : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpRight'; rValue : '������');
  { '������' }

const
  { ����� �������������� �������������� ����� ToolbarPos }
 ToolbarPosMap : array [TvcmEffectiveToolBarPos] of Pl3StringIDEx = (
  @str_vcmetbpTop
  , @str_vcmetbpBottom
  , @str_vcmetbpLeft
  , @str_vcmetbpRight
 );//ToolbarPosMap

var
  { ������������ ������ Local }
 str_vcmSeparator : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmSeparator'; rValue : '- ����������� -');
  { '- ����������� -' }
 str_vcmAskResoreToolbar : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmAskResoreToolbar'; rValue : '�� ������������� ������ ������������ ������� � ����� �������� ���� ������� ������������ ������� �� ���������?');
  { '�� ������������� ������ ������������ ������� � ����� �������� ���� ������� ������������ ������� �� ���������?' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// ������������� str_vcmetbpTop
 str_vcmetbpTop.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmetbpBottom
 str_vcmetbpBottom.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmetbpLeft
 str_vcmetbpLeft.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmetbpRight
 str_vcmetbpRight.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmSeparator
 str_vcmSeparator.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmAskResoreToolbar
 str_vcmAskResoreToolbar.Init;
{$IfEnd} //not NoVCM

end.