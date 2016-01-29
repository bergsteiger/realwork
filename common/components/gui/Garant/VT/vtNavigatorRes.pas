unit vtNavigatorRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$WithVCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VT/vtNavigatorRes.pas"
// �����: 02.03.2010 17:58
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT$WithVCM::vtNavigator::vtNavigatorRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3StringIDEx
  ;

var
  { ������������ ������ TvtNavigatorHints }
 str_vtAutoHideOffHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOffHint'; rValue : '������������� ������ ���������');
  { '������������� ������ ���������' }
 str_vtAutoHideOnHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOnHint'; rValue : '����������� ������ ���������');
  { '����������� ������ ���������' }
 str_vtMinimizedOnHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOnHint'; rValue : '��������');
  { '��������' }
 str_vtMinimizedOffHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOffHint'; rValue : '����������');
  { '����������' }
 str_vtBtnCloseHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtBtnCloseHint'; rValue : '���������� ���������');
  { '���������� ���������' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// ������������� str_vtAutoHideOffHint
 str_vtAutoHideOffHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vtAutoHideOnHint
 str_vtAutoHideOnHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vtMinimizedOnHint
 str_vtMinimizedOnHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vtMinimizedOffHint
 str_vtMinimizedOffHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vtBtnCloseHint
 str_vtBtnCloseHint.Init;
{$IfEnd} //not NoVCM

end.