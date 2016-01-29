unit vcmTabbedContainerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmTabbedContainerRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmTabbedContainerRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3StringIDEx,
  l3MessageID
  ;

var
  { ������������ ������ vcmTabbedContainerConsts }
 str_TooManyTabsOpened : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened'; rValue : '������� ������������ ���������� �������, �������� �������� ��� ����������� �������� � ������� �������.');
  { '������� ������������ ���������� �������, �������� �������� ��� ����������� �������� � ������� �������.' }
 str_pui_MainWindowTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pui_MainWindowTabs'; rValue : '������� ��������� ����');
  { '������� ��������� ����' }
 str_pi_UseTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_UseTabs'; rValue : '������������ �������');
  { '������������ �������' }
 str_pi_OpenDocumentsFromList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenDocumentsFromList'; rValue : '��������� ��������� �� �������');
  { '��������� ��������� �� �������' }
 str_pi_OpenLinksFromDocument : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenLinksFromDocument'; rValue : '��������� ������ �� ����������');
  { '��������� ������ �� ����������' }
 str_pi_InCurrentTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InCurrentTab'; rValue : '� ������� �������');
  { '� ������� �������' }
 str_pi_InNewTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewTab'; rValue : '� ����� �������');
  { '� ����� �������' }
 str_pi_InNewWindow : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewWindow'; rValue : '� ����� ����');
  { '� ����� ����' }
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

var
  { �������� ������ ��� ������� TooManyTabsOpened }
 str_TooManyTabsOpened_Choice_First : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened_Choice_First'; rValue : '���������� ������ � ������� �������');
  { '���������� ������ � ������� �������' }

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_TooManyTabsOpened_Choice_First
 str_TooManyTabsOpened_Choice_First.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_TooManyTabsOpened
 str_TooManyTabsOpened.Init;
 str_TooManyTabsOpened.AddChoice(str_TooManyTabsOpened_Choice_First);
 str_TooManyTabsOpened.AddDefaultChoice(str_TooManyTabsOpened_Choice_First);
 str_TooManyTabsOpened.SetDlgType(mtConfirmation);
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_pui_MainWindowTabs
 str_pui_MainWindowTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_pi_UseTabs
 str_pi_UseTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_pi_OpenDocumentsFromList
 str_pi_OpenDocumentsFromList.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_pi_OpenLinksFromDocument
 str_pi_OpenLinksFromDocument.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_pi_InCurrentTab
 str_pi_InCurrentTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_pi_InNewTab
 str_pi_InNewTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_pi_InNewWindow
 str_pi_InNewWindow.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.