unit ChromeLikeWindowCaptionButtonsRes;

// ������: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeWindowCaptionButtonsRes.pas"
// ���������: "UtilityPack"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ WindowCaptionButtonsHints }
 str_Close: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Close'; rValue : '�������');
  {* '�������' }
 str_Minimize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Minimize'; rValue : '��������');
  {* '��������' }
 str_Restore: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Restore'; rValue : '�������� � ����');
  {* '�������� � ����' }
 str_Maximize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Maximize'; rValue : '����������');
  {* '����������' }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_Close.Init;
 {* ������������� str_Close }
 str_Minimize.Init;
 {* ������������� str_Minimize }
 str_Restore.Init;
 {* ������������� str_Restore }
 str_Maximize.Init;
 {* ������������� str_Maximize }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
