unit vcmTabbedContainerRes;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerRes.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3MessageID
 , l3StringIDEx
;

const
 {* ������������ ������ vcmTabbedContainerConsts }
 str_TooManyTabsOpened: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened'; rValue : '������� ������������ ���������� �������, �������� �������� ��� ����������� �������� � ������� �������.');
  {* '������� ������������ ���������� �������, �������� �������� ��� ����������� �������� � ������� �������.' }
 str_pui_MainWindowTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pui_MainWindowTabs'; rValue : '������� ��������� ����');
  {* '������� ��������� ����' }
 str_pi_UseTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_UseTabs'; rValue : '������������ �������');
  {* '������������ �������' }
 str_pi_OpenDocumentsFromList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenDocumentsFromList'; rValue : '��������� ��������� �� �������');
  {* '��������� ��������� �� �������' }
 str_pi_OpenLinksFromDocument: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenLinksFromDocument'; rValue : '��������� ������ �� ����������');
  {* '��������� ������ �� ����������' }
 str_pi_InCurrentTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InCurrentTab'; rValue : '� ������� �������');
  {* '� ������� �������' }
 str_pi_InNewTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewTab'; rValue : '� ����� �������');
  {* '� ����� �������' }
 str_pi_InNewWindow: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewWindow'; rValue : '� ����� ����');
  {* '� ����� ����' }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 {* �������� ������ ��� ������� TooManyTabsOpened }
 str_TooManyTabsOpened_Choice_First: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened_Choice_First'; rValue : '���������� ������ � ������� �������');
  {* '���������� ������ � ������� �������' }

initialization
 str_TooManyTabsOpened_Choice_First.Init;
 {* ������������� str_TooManyTabsOpened_Choice_First }
 str_TooManyTabsOpened.Init;
!!! Lost Message ini !!!
 {* ������������� str_TooManyTabsOpened }
 str_pui_MainWindowTabs.Init;
 {* ������������� str_pui_MainWindowTabs }
 str_pi_UseTabs.Init;
 {* ������������� str_pi_UseTabs }
 str_pi_OpenDocumentsFromList.Init;
 {* ������������� str_pi_OpenDocumentsFromList }
 str_pi_OpenLinksFromDocument.Init;
 {* ������������� str_pi_OpenLinksFromDocument }
 str_pi_InCurrentTab.Init;
 {* ������������� str_pi_InCurrentTab }
 str_pi_InNewTab.Init;
 {* ������������� str_pi_InNewTab }
 str_pi_InNewWindow.Init;
 {* ������������� str_pi_InNewWindow }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
