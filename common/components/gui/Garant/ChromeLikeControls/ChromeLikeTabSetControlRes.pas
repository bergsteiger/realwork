unit ChromeLikeTabSetControlRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ChromeLikeControls"
// ������: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeTabSetControlRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::ChromeLikeTabSetControlRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3StringIDEx
  ;

var
  { ������������ ������ ChromeLikeTabSetControllConst }
 str_NewTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewTab'; rValue : '����� �������');
  { '����� �������' }
 str_MakeClone : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MakeClone'; rValue : '�����������');
  { '�����������' }
 str_CloseTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseTab'; rValue : '������� �������');
  { '������� �������' }
 str_CloseOtherTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseOtherTabs'; rValue : '������� ������ �������');
  { '������� ������ �������' }
 str_CloseRightTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseRightTabs'; rValue : '������� ������� ������');
  { '������� ������� ������' }
 str_ReopenClosedTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ReopenClosedTab'; rValue : '������� �������� �������');
  { '������� �������� �������' }
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_NewTab
 str_NewTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_MakeClone
 str_MakeClone.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_CloseTab
 str_CloseTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_CloseOtherTabs
 str_CloseOtherTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_CloseRightTabs
 str_CloseRightTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_ReopenClosedTab
 str_ReopenClosedTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.