unit vcmBaseMenuManagerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmBaseMenuManagerRes.pas"
// �����: 04.03.2010 13:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmBaseMenuManagerRes
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
  { ������������ ������ Local }
 str_vcmShowTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmShowTab'; rValue : '�������� ������� "%s"');
  { '�������� ������� "%s"' }
 str_vcmHideTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmHideTab'; rValue : '������ ������� "%s"');
  { '������ ������� "%s"' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// ������������� str_vcmShowTab
 str_vcmShowTab.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmHideTab
 str_vcmHideTab.Init;
{$IfEnd} //not NoVCM

end.