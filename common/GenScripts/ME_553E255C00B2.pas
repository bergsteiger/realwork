unit ChromeLikeTabSetControlRes;

// ������: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControlRes.pas"
// ���������: "UtilityPack"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ChromeLikeTabSetControllConst }
 str_NewTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewTab'; rValue : '����� �������');
  {* '����� �������' }
 str_MakeClone: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MakeClone'; rValue : '�����������');
  {* '�����������' }
 str_CloseTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseTab'; rValue : '������� �������');
  {* '������� �������' }
 str_CloseOtherTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseOtherTabs'; rValue : '������� ������ �������');
  {* '������� ������ �������' }
 str_CloseRightTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseRightTabs'; rValue : '������� ������� ������');
  {* '������� ������� ������' }
 str_ReopenClosedTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ReopenClosedTab'; rValue : '������� �������� �������');
  {* '������� �������� �������' }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_NewTab.Init;
 {* ������������� str_NewTab }
 str_MakeClone.Init;
 {* ������������� str_MakeClone }
 str_CloseTab.Init;
 {* ������������� str_CloseTab }
 str_CloseOtherTabs.Init;
 {* ������������� str_CloseOtherTabs }
 str_CloseRightTabs.Init;
 {* ������������� str_CloseRightTabs }
 str_ReopenClosedTab.Init;
 {* ������������� str_ReopenClosedTab }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
