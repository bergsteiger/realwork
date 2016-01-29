unit vcmMenuManagerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmMenuManagerRes.pas"
// �����: 03.03.2010 20:04
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmMenuManagerRes
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
  l3StringIDEx
  ;

var
  { ������������ ������ TvcmUserTypeHints }
 str_vcmCloseHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmCloseHint'; rValue : '�������');
  { '�������' }
 str_vcmMaximizedHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmMaximizedHint'; rValue : '������� � ����� ����');
  { '������� � ����� ����' }
 str_vcmOpenHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmOpenHint'; rValue : '������� � ������� ����');
  { '������� � ������� ����' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// ������������� str_vcmCloseHint
 str_vcmCloseHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmMaximizedHint
 str_vcmMaximizedHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmOpenHint
 str_vcmOpenHint.Init;
{$IfEnd} //not NoVCM

end.