unit evNative_AttrValues;
 {* ������������ �������� ��������� �������� ����� ������� ����� evNative }

// ������: "w:\common\components\gui\Garant\Everest\evNative_AttrValues.pas"
// ���������: "UtilityPack"
// ������� ������: "evNative_AttrValues" MUID: (060E2B49C828)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ AttrValues }
 str_TextStyle_ToLeft_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ToLeft_Name_Value'; rValue : '�������� �����');
  {* ������������ �������� �������� TextStyle_ToLeft_Name_Value }
 str_TextStyle_TxtHeader1_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader1_Name_Value'; rValue : '��������� 1');
  {* ������������ �������� �������� TextStyle_TxtHeader1_Name_Value }
 str_TextStyle_TxtHeader2_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader2_Name_Value'; rValue : '��������� 2');
  {* ������������ �������� �������� TextStyle_TxtHeader2_Name_Value }
 str_TextStyle_TxtHeader3_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader3_Name_Value'; rValue : '��������� 3');
  {* ������������ �������� �������� TextStyle_TxtHeader3_Name_Value }
 str_TextStyle_TxtHeader4_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader4_Name_Value'; rValue : '��������� 4');
  {* ������������ �������� �������� TextStyle_TxtHeader4_Name_Value }
 str_TextStyle_NormalNote_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NormalNote_Name_Value'; rValue : '���������� (�������)');
  {* ������������ �������� �������� TextStyle_NormalNote_Name_Value }
 str_TextStyle_TxtComment_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_Name_Value'; rValue : '�����������');
  {* ������������ �������� �������� TextStyle_TxtComment_Name_Value }
 {$If NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Garant_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_ShortName_D_Garant_Value'; rValue : '������:');
  {* ������������ �������� �������� TextStyle_TxtComment_ShortName_D_Garant_Value }
 {$IfEnd} // NOT Defined(Archi)
 {$If Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Archi_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_ShortName_D_Archi_Value'; rValue : ' ');
  {* ������������ �������� �������� TextStyle_TxtComment_ShortName_D_Archi_Value }
 {$IfEnd} // Defined(Archi)
 {$If Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_DailyTests_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_ShortName_D_DailyTests_Value'; rValue : '����������� �������:');
  {* ������������ �������� �������� TextStyle_TxtComment_ShortName_D_DailyTests_Value }
 {$IfEnd} // Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)
 str_TextStyle_VersionInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VersionInfo_Name_Value'; rValue : '���������� � ������');
  {* ������������ �������� �������� TextStyle_VersionInfo_Name_Value }
 {$If NOT Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VersionInfo_ShortName_Value'; rValue : '���������� �� ����������:');
  {* ������������ �������� �������� TextStyle_VersionInfo_ShortName_Value }
 {$IfEnd} // NOT Defined(Archi)
 {$If Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_D_Archi_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VersionInfo_ShortName_D_Archi_Value'; rValue : ' ');
  {* ������������ �������� �������� TextStyle_VersionInfo_ShortName_D_Archi_Value }
 {$IfEnd} // Defined(Archi)
 str_TextStyle_PromptTree_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_PromptTree_Name_Value'; rValue : '��������� ��� ���������');
  {* ������������ �������� �������� TextStyle_PromptTree_Name_Value }
 str_TextStyle_HLE1_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE1_Name_Value'; rValue : '����������� ���������');
  {* ������������ �������� �������� TextStyle_HLE1_Name_Value }
 str_TextStyle_HLE1_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE1_ShortName_Value'; rValue : '����������� ���������');
  {* ������������ �������� �������� TextStyle_HLE1_ShortName_Value }
 str_TextStyle_HLE2_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE2_Name_Value'; rValue : '���� ����������?');
  {* ������������ �������� �������� TextStyle_HLE2_Name_Value }
 str_TextStyle_HLE2_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE2_ShortName_Value'; rValue : '���� ����������?');
  {* ������������ �������� �������� TextStyle_HLE2_ShortName_Value }
 str_TextStyle_HLE3_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE3_Name_Value'; rValue : '��������: ������������������!');
  {* ������������ �������� �������� TextStyle_HLE3_Name_Value }
 str_TextStyle_HLE3_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE3_ShortName_Value'; rValue : '��������: ������������������!');
  {* ������������ �������� �������� TextStyle_HLE3_ShortName_Value }
 str_TextStyle_HLE4_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE4_Name_Value'; rValue : '��������: ��������!!');
  {* ������������ �������� �������� TextStyle_HLE4_Name_Value }
 str_TextStyle_HLE4_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE4_ShortName_Value'; rValue : '��������: ��������!!');
  {* ������������ �������� �������� TextStyle_HLE4_ShortName_Value }
 str_TextStyle_HLE5_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE5_Name_Value'; rValue : '����������.');
  {* ������������ �������� �������� TextStyle_HLE5_Name_Value }
 str_TextStyle_HLE5_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE5_ShortName_Value'; rValue : '����������.');
  {* ������������ �������� �������� TextStyle_HLE5_ShortName_Value }
 str_TextStyle_HLE6_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE6_Name_Value'; rValue : '������.');
  {* ������������ �������� �������� TextStyle_HLE6_Name_Value }
 str_TextStyle_HLE6_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE6_ShortName_Value'; rValue : '������');
  {* ������������ �������� �������� TextStyle_HLE6_ShortName_Value }
 str_TextStyle_HeaderForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HeaderForChangesInfo_Name_Value'; rValue : '��������� ��� ���������� �� ����������');
  {* ������������ �������� �������� TextStyle_HeaderForChangesInfo_Name_Value }
 str_TextStyle_FooterForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_FooterForChangesInfo_Name_Value'; rValue : '������ ��� ���������� �� ����������');
  {* ������������ �������� �������� TextStyle_FooterForChangesInfo_Name_Value }
 str_TextStyle_TextForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TextForChangesInfo_Name_Value'; rValue : '����� ���������� �� ����������');
  {* ������������ �������� �������� TextStyle_TextForChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_Header_HeaderC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Header_HeaderC_Text_Value'; rValue : '(���������� �� ���������� >>)');
  {* ������������ �������� �������� TextStyle_ChangesInfo_Header_HeaderC_Text_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value'; rValue : '������� ������� � ���������');
  {* ������������ �������� �������� TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value'; rValue : 'script:��::��������_�������_�_���������');
  {* ������������ �������� �������� TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Footer_FooterC_Text_Value'; rValue : '��������� ��. � ������� � ���������');
  {* ������������ �������� �������� TextStyle_ChangesInfo_Footer_FooterC_Text_Value }
 str_TextStyle_ChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Name_Value'; rValue : '���������� �� ����������');
  {* ������������ �������� �������� TextStyle_ChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_ShortName_Value'; rValue : '� ����������� � ������������ ��:');
  {* ������������ �������� �������� TextStyle_ChangesInfo_ShortName_Value }
 str_TextStyle_SubHeaderForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_SubHeaderForChangesInfo_Name_Value'; rValue : '������������ ��� ���������� �� ����������');
  {* ������������ �������� �������� TextStyle_SubHeaderForChangesInfo_Name_Value }
 str_TextStyle_ControlsBlockHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ControlsBlockHeader_Name_Value'; rValue : '��������� ������ ���������');
  {* ������������ �������� �������� TextStyle_ControlsBlockHeader_Name_Value }
 str_TextStyle_CloakHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_CloakHeader_Name_Value'; rValue : '��������� ��������������� ����� �������');
  {* ������������ �������� �������� TextStyle_CloakHeader_Name_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value'; rValue : '����������� ����� ����������� ���������� (��������-������)');
  {* ������������ �������� �������� TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value'; rValue : 'script:��::��������_�����������_�����_�����������_����������');
  {* ������������ �������� �������� TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Header_FooterC_Text_Value'; rValue : '��. ����������� ����� ����������� ����������');
  {* ������������ �������� �������� TextStyle_LinkToPublication_Header_FooterC_Text_Value }
 str_TextStyle_LinkToPublication_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Name_Value'; rValue : '������ �� ����������� ����������');
  {* ������������ �������� �������� TextStyle_LinkToPublication_Name_Value }
 str_TextStyle_UnderlinedText_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_UnderlinedText_Name_Value'; rValue : '������������ �����');
  {* ������������ �������� �������� TextStyle_UnderlinedText_Name_Value }
 str_TextStyle_NodeGroupHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NodeGroupHeader_Name_Value'; rValue : '��������� ������ ��������');
  {* ������������ �������� �������� TextStyle_NodeGroupHeader_Name_Value }
 str_TextStyle_TxtNormalAACSeeAlso_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtNormalAACSeeAlso_Name_Value'; rValue : '����� �� (��. �����)');
  {* ������������ �������� �������� TextStyle_TxtNormalAACSeeAlso_Name_Value }
 str_TextStyle_HeaderAACLeftWindow_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HeaderAACLeftWindow_Name_Value'; rValue : '��������� �� (����� ����)');
  {* ������������ �������� �������� TextStyle_HeaderAACLeftWindow_Name_Value }
 str_TextStyle_HeaderAACRightWindow_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HeaderAACRightWindow_Name_Value'; rValue : '��������� �� (������ ����)');
  {* ������������ �������� �������� TextStyle_HeaderAACRightWindow_Name_Value }
 str_TextStyle_ContextAACRightWindows_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ContextAACRightWindows_Name_Value'; rValue : '��-���������� (������ ����)');
  {* ������������ �������� �������� TextStyle_ContextAACRightWindows_Name_Value }
 str_TextStyle_FormulaInAAC_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_FormulaInAAC_Name_Value'; rValue : '�������');
  {* ������������ �������� �������� TextStyle_FormulaInAAC_Name_Value }
 str_TextStyle_TwoColorTable_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TwoColorTable_Name_Value'; rValue : '������� � ��������� ��������');
  {* ������������ �������� �������� TextStyle_TwoColorTable_Name_Value }
 str_TextStyle_BoldSelection_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_BoldSelection_Name_Value'; rValue : '��������� ������');
  {* ������������ �������� �������� TextStyle_BoldSelection_Name_Value }
 str_TextStyle_ExpandedText_Header_HeaderC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ExpandedText_Header_HeaderC_Text_Value'; rValue : '��������������� ����� >>');
  {* ������������ �������� �������� TextStyle_ExpandedText_Header_HeaderC_Text_Value }
 str_TextStyle_ExpandedText_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ExpandedText_Name_Value'; rValue : '��������������� �����');
  {* ������������ �������� �������� TextStyle_ExpandedText_Name_Value }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_TextStyle_ToLeft_Name_Value.Init;
 {* ������������� str_TextStyle_ToLeft_Name_Value }
 str_TextStyle_TxtHeader1_Name_Value.Init;
 {* ������������� str_TextStyle_TxtHeader1_Name_Value }
 str_TextStyle_TxtHeader2_Name_Value.Init;
 {* ������������� str_TextStyle_TxtHeader2_Name_Value }
 str_TextStyle_TxtHeader3_Name_Value.Init;
 {* ������������� str_TextStyle_TxtHeader3_Name_Value }
 str_TextStyle_TxtHeader4_Name_Value.Init;
 {* ������������� str_TextStyle_TxtHeader4_Name_Value }
 str_TextStyle_NormalNote_Name_Value.Init;
 {* ������������� str_TextStyle_NormalNote_Name_Value }
 str_TextStyle_TxtComment_Name_Value.Init;
 {* ������������� str_TextStyle_TxtComment_Name_Value }
{$If NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Garant_Value.Init;
 {* ������������� str_TextStyle_TxtComment_ShortName_D_Garant_Value }
{$IfEnd} // NOT Defined(Archi)
{$If Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Archi_Value.Init;
 {* ������������� str_TextStyle_TxtComment_ShortName_D_Archi_Value }
{$IfEnd} // Defined(Archi)
{$If Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_DailyTests_Value.Init;
 {* ������������� str_TextStyle_TxtComment_ShortName_D_DailyTests_Value }
{$IfEnd} // Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)
 str_TextStyle_VersionInfo_Name_Value.Init;
 {* ������������� str_TextStyle_VersionInfo_Name_Value }
{$If NOT Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_Value.Init;
 {* ������������� str_TextStyle_VersionInfo_ShortName_Value }
{$IfEnd} // NOT Defined(Archi)
{$If Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_D_Archi_Value.Init;
 {* ������������� str_TextStyle_VersionInfo_ShortName_D_Archi_Value }
{$IfEnd} // Defined(Archi)
 str_TextStyle_PromptTree_Name_Value.Init;
 {* ������������� str_TextStyle_PromptTree_Name_Value }
 str_TextStyle_HLE1_Name_Value.Init;
 {* ������������� str_TextStyle_HLE1_Name_Value }
 str_TextStyle_HLE1_ShortName_Value.Init;
 {* ������������� str_TextStyle_HLE1_ShortName_Value }
 str_TextStyle_HLE2_Name_Value.Init;
 {* ������������� str_TextStyle_HLE2_Name_Value }
 str_TextStyle_HLE2_ShortName_Value.Init;
 {* ������������� str_TextStyle_HLE2_ShortName_Value }
 str_TextStyle_HLE3_Name_Value.Init;
 {* ������������� str_TextStyle_HLE3_Name_Value }
 str_TextStyle_HLE3_ShortName_Value.Init;
 {* ������������� str_TextStyle_HLE3_ShortName_Value }
 str_TextStyle_HLE4_Name_Value.Init;
 {* ������������� str_TextStyle_HLE4_Name_Value }
 str_TextStyle_HLE4_ShortName_Value.Init;
 {* ������������� str_TextStyle_HLE4_ShortName_Value }
 str_TextStyle_HLE5_Name_Value.Init;
 {* ������������� str_TextStyle_HLE5_Name_Value }
 str_TextStyle_HLE5_ShortName_Value.Init;
 {* ������������� str_TextStyle_HLE5_ShortName_Value }
 str_TextStyle_HLE6_Name_Value.Init;
 {* ������������� str_TextStyle_HLE6_Name_Value }
 str_TextStyle_HLE6_ShortName_Value.Init;
 {* ������������� str_TextStyle_HLE6_ShortName_Value }
 str_TextStyle_HeaderForChangesInfo_Name_Value.Init;
 {* ������������� str_TextStyle_HeaderForChangesInfo_Name_Value }
 str_TextStyle_FooterForChangesInfo_Name_Value.Init;
 {* ������������� str_TextStyle_FooterForChangesInfo_Name_Value }
 str_TextStyle_TextForChangesInfo_Name_Value.Init;
 {* ������������� str_TextStyle_TextForChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_Header_HeaderC_Text_Value.Init;
 {* ������������� str_TextStyle_ChangesInfo_Header_HeaderC_Text_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value.Init;
 {* ������������� str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value.Init;
 {* ������������� str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Text_Value.Init;
 {* ������������� str_TextStyle_ChangesInfo_Footer_FooterC_Text_Value }
 str_TextStyle_ChangesInfo_Name_Value.Init;
 {* ������������� str_TextStyle_ChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_ShortName_Value.Init;
 {* ������������� str_TextStyle_ChangesInfo_ShortName_Value }
 str_TextStyle_SubHeaderForChangesInfo_Name_Value.Init;
 {* ������������� str_TextStyle_SubHeaderForChangesInfo_Name_Value }
 str_TextStyle_ControlsBlockHeader_Name_Value.Init;
 {* ������������� str_TextStyle_ControlsBlockHeader_Name_Value }
 str_TextStyle_CloakHeader_Name_Value.Init;
 {* ������������� str_TextStyle_CloakHeader_Name_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value.Init;
 {* ������������� str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value.Init;
 {* ������������� str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Text_Value.Init;
 {* ������������� str_TextStyle_LinkToPublication_Header_FooterC_Text_Value }
 str_TextStyle_LinkToPublication_Name_Value.Init;
 {* ������������� str_TextStyle_LinkToPublication_Name_Value }
 str_TextStyle_UnderlinedText_Name_Value.Init;
 {* ������������� str_TextStyle_UnderlinedText_Name_Value }
 str_TextStyle_NodeGroupHeader_Name_Value.Init;
 {* ������������� str_TextStyle_NodeGroupHeader_Name_Value }
 str_TextStyle_TxtNormalAACSeeAlso_Name_Value.Init;
 {* ������������� str_TextStyle_TxtNormalAACSeeAlso_Name_Value }
 str_TextStyle_HeaderAACLeftWindow_Name_Value.Init;
 {* ������������� str_TextStyle_HeaderAACLeftWindow_Name_Value }
 str_TextStyle_HeaderAACRightWindow_Name_Value.Init;
 {* ������������� str_TextStyle_HeaderAACRightWindow_Name_Value }
 str_TextStyle_ContextAACRightWindows_Name_Value.Init;
 {* ������������� str_TextStyle_ContextAACRightWindows_Name_Value }
 str_TextStyle_FormulaInAAC_Name_Value.Init;
 {* ������������� str_TextStyle_FormulaInAAC_Name_Value }
 str_TextStyle_TwoColorTable_Name_Value.Init;
 {* ������������� str_TextStyle_TwoColorTable_Name_Value }
 str_TextStyle_BoldSelection_Name_Value.Init;
 {* ������������� str_TextStyle_BoldSelection_Name_Value }
 str_TextStyle_ExpandedText_Header_HeaderC_Text_Value.Init;
 {* ������������� str_TextStyle_ExpandedText_Header_HeaderC_Text_Value }
 str_TextStyle_ExpandedText_Name_Value.Init;
 {* ������������� str_TextStyle_ExpandedText_Name_Value }

end.
