unit evdNative_AttrValues;
 {* ������������ �������� ��������� �������� ����� ������� ����� evdNative }

// ������: "w:\common\components\rtl\Garant\EVD\evdNative_AttrValues.pas"
// ���������: "UtilityPack"
// ������� ������: "evdNative_AttrValues" MUID: (A15623CB6EA6)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ AttrValues }
 str_Frame_Empty_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Frame_Empty_Name_Value'; rValue : 'Empty');
  {* ������������ �������� �������� Frame_Empty_Name_Value }
 str_Frame_Solid_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Frame_Solid_Name_Value'; rValue : 'Solid');
  {* ������������ �������� �������� Frame_Solid_Name_Value }
 str_Frame_Down_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Frame_Down_Name_Value'; rValue : 'Down');
  {* ������������ �������� �������� Frame_Down_Name_Value }
 str_TextStyle_TxtNormalANSI_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtNormalANSI_Name_Value'; rValue : '����������');
  {* ������������ �������� �������� TextStyle_TxtNormalANSI_Name_Value }
 str_TextStyle_Object_Font_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Object_Font_Name_Value'; rValue : 'Times New Roman');
  {* ������������ �������� �������� TextStyle_Object_Font_Name_Value }
 str_TextStyle_Object_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Object_Name_Value'; rValue : '������');
  {* ������������ �������� �������� TextStyle_Object_Name_Value }
 str_TextStyle_Mistake_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Mistake_Name_Value'; rValue : '��������');
  {* ������������ �������� �������� TextStyle_Mistake_Name_Value }
 str_TextStyle_ColorSelection_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ColorSelection_Name_Value'; rValue : '�������� ���������');
  {* ������������ �������� �������� TextStyle_ColorSelection_Name_Value }
 str_TextStyle_HyperLink_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HyperLink_Name_Value'; rValue : '�������������� ������');
  {* ������������ �������� �������� TextStyle_HyperLink_Name_Value }
 str_TextStyle_Interface_Font_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Interface_Font_Name_Value'; rValue : 'Arial');
  {* ������������ �������� �������� TextStyle_Interface_Font_Name_Value }
 str_TextStyle_Interface_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Interface_Name_Value'; rValue : '���������');
  {* ������������ �������� �������� TextStyle_Interface_Name_Value }
 str_TextStyle_ActiveHyperLink_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ActiveHyperLink_Name_Value'; rValue : '�������� �����������');
  {* ������������ �������� �������� TextStyle_ActiveHyperLink_Name_Value }
 str_TextStyle_NormalTable_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NormalTable_Name_Value'; rValue : '���������� (�������)');
  {* ������������ �������� �������� TextStyle_NormalTable_Name_Value }
 str_TextStyle_CenteredTable_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_CenteredTable_Name_Value'; rValue : '�������������� (�������)');
  {* ������������ �������� �������� TextStyle_CenteredTable_Name_Value }
 str_TextStyle_ColorSelectionForBaseSearch_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ColorSelectionForBaseSearch_Name_Value'; rValue : '��������� ��� �������� ������');
  {* ������������ �������� �������� TextStyle_ColorSelectionForBaseSearch_Name_Value }
 str_TextStyle_ItalicColorSelectionForBaseSearch_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ItalicColorSelectionForBaseSearch_Name_Value'; rValue : '��������� ��� �������� ������ (������)');
  {* ������������ �������� �������� TextStyle_ItalicColorSelectionForBaseSearch_Name_Value }
 str_TextStyle_Dialogs_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Dialogs_Name_Value'; rValue : '����� ��������');
  {* ������������ �������� �������� TextStyle_Dialogs_Name_Value }
 str_TextStyle_TOC_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TOC_Name_Value'; rValue : '��������� ���������');
  {* ������������ �������� �������� TextStyle_TOC_Name_Value }
 str_TextStyle_Attention_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Attention_Name_Value'; rValue : '��������');
  {* ������������ �������� �������� TextStyle_Attention_Name_Value }
 str_TextStyle_Attention_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Attention_ShortName_Value'; rValue : '��������');
  {* ������������ �������� �������� TextStyle_Attention_ShortName_Value }
 str_TextStyle_WriteToUs_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_WriteToUs_Name_Value'; rValue : '�������� ���');
  {* ������������ �������� �������� TextStyle_WriteToUs_Name_Value }
 str_TextStyle_AbolishedDocumentLink_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_AbolishedDocumentLink_Name_Value'; rValue : '������ �� ���������� ���� ��������');
  {* ������������ �������� �������� TextStyle_AbolishedDocumentLink_Name_Value }
 str_TextStyle_NewsConfigStyle_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NewsConfigStyle_Name_Value'; rValue : '����� ����������� "��������� ��������� �����"');
  {* ������������ �������� �������� TextStyle_NewsConfigStyle_Name_Value }
 str_TextStyle_AACHyperlink_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_AACHyperlink_Name_Value'; rValue : '����������� ��� ��-����������');
  {* ������������ �������� �������� TextStyle_AACHyperlink_Name_Value }

implementation

uses
 l3ImplUses
 //#UC START# *A15623CB6EA6impl_uses*
 //#UC END# *A15623CB6EA6impl_uses*
;

initialization
 str_Frame_Empty_Name_Value.Init;
 {* ������������� str_Frame_Empty_Name_Value }
 str_Frame_Solid_Name_Value.Init;
 {* ������������� str_Frame_Solid_Name_Value }
 str_Frame_Down_Name_Value.Init;
 {* ������������� str_Frame_Down_Name_Value }
 str_TextStyle_TxtNormalANSI_Name_Value.Init;
 {* ������������� str_TextStyle_TxtNormalANSI_Name_Value }
 str_TextStyle_Object_Font_Name_Value.Init;
 {* ������������� str_TextStyle_Object_Font_Name_Value }
 str_TextStyle_Object_Name_Value.Init;
 {* ������������� str_TextStyle_Object_Name_Value }
 str_TextStyle_Mistake_Name_Value.Init;
 {* ������������� str_TextStyle_Mistake_Name_Value }
 str_TextStyle_ColorSelection_Name_Value.Init;
 {* ������������� str_TextStyle_ColorSelection_Name_Value }
 str_TextStyle_HyperLink_Name_Value.Init;
 {* ������������� str_TextStyle_HyperLink_Name_Value }
 str_TextStyle_Interface_Font_Name_Value.Init;
 {* ������������� str_TextStyle_Interface_Font_Name_Value }
 str_TextStyle_Interface_Name_Value.Init;
 {* ������������� str_TextStyle_Interface_Name_Value }
 str_TextStyle_ActiveHyperLink_Name_Value.Init;
 {* ������������� str_TextStyle_ActiveHyperLink_Name_Value }
 str_TextStyle_NormalTable_Name_Value.Init;
 {* ������������� str_TextStyle_NormalTable_Name_Value }
 str_TextStyle_CenteredTable_Name_Value.Init;
 {* ������������� str_TextStyle_CenteredTable_Name_Value }
 str_TextStyle_ColorSelectionForBaseSearch_Name_Value.Init;
 {* ������������� str_TextStyle_ColorSelectionForBaseSearch_Name_Value }
 str_TextStyle_ItalicColorSelectionForBaseSearch_Name_Value.Init;
 {* ������������� str_TextStyle_ItalicColorSelectionForBaseSearch_Name_Value }
 str_TextStyle_Dialogs_Name_Value.Init;
 {* ������������� str_TextStyle_Dialogs_Name_Value }
 str_TextStyle_TOC_Name_Value.Init;
 {* ������������� str_TextStyle_TOC_Name_Value }
 str_TextStyle_Attention_Name_Value.Init;
 {* ������������� str_TextStyle_Attention_Name_Value }
 str_TextStyle_Attention_ShortName_Value.Init;
 {* ������������� str_TextStyle_Attention_ShortName_Value }
 str_TextStyle_WriteToUs_Name_Value.Init;
 {* ������������� str_TextStyle_WriteToUs_Name_Value }
 str_TextStyle_AbolishedDocumentLink_Name_Value.Init;
 {* ������������� str_TextStyle_AbolishedDocumentLink_Name_Value }
 str_TextStyle_NewsConfigStyle_Name_Value.Init;
 {* ������������� str_TextStyle_NewsConfigStyle_Name_Value }
 str_TextStyle_AACHyperlink_Name_Value.Init;
 {* ������������� str_TextStyle_AACHyperlink_Name_Value }

end.
