unit nsQuestions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/nsQuestions.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::���� ����� ��� ��������� �� StdRes � Choices::nsQuestions
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3StringIDEx,
  l3MessageID
  ;

var
  { ������������ ������ Asks }
 str_DocumentEMailSelection : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection'; rValue : '��������� �� E-mail:');
  { '��������� �� E-mail:' }
 str_ListEMailSelection : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection'; rValue : '��������� �� EMail');
  { '��������� �� EMail' }
 str_ListPrintSelectedConfirmation : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation'; rValue : '��������:');
  { '��������:' }
 str_PrintSelectedConfirmation : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation'; rValue : '��������:');
  { '��������:' }
 str_ExportSelectionToWord : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord'; rValue : '�������������� � MS-Word');
  { '�������������� � MS-Word' }
 str_ListExportSelectionToWord : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord'; rValue : '�������������� � MS-Word:');
  { '�������������� � MS-Word:' }
 str_ConsultDocumentsNotFound : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFound'; rValue : '���������� �� ������� ������� ����������� � ������������� � ��� ���������.');
  { '���������� �� ������� ������� ����������� � ������������� � ��� ���������.' }
 str_ConsultDocumentsNotFoundNoSpec : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFoundNoSpec'; rValue : '���������� �� ������� ������� ����������� � ������������� � ��� ���������.');
  { '���������� �� ������� ������� ����������� � ������������� � ��� ���������.' }
 str_DocumentEMailSelection_CheckCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_CheckCaption'; rValue : '������ ���������� ���������� ��������');
  { undefined }
 str_DocumentEMailSelection_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_SettingsCaption'; rValue : '��������� �� EMail');
  { undefined }
 str_DocumentEMailSelection_LongHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_LongHint'; rValue : '������������� ��� ��������� ����������� ���������');
  { undefined }
 str_ListEMailSelection_CheckCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_CheckCaption'; rValue : '������ ���������� ���������� �������� ');
  { undefined }
 str_ListEMailSelection_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_SettingsCaption'; rValue : '��������� �� EMail');
  { undefined }
 str_ListEMailSelection_LongHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_LongHint'; rValue : '������������� ��� ��������� ���������� ���������');
  { undefined }
 str_ListPrintSelectedConfirmation_CheckCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_CheckCaption'; rValue : '������ �������� ���������� ��������');
  { undefined }
 str_ListPrintSelectedConfirmation_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_SettingsCaption'; rValue : '������');
  { undefined }
 str_ListPrintSelectedConfirmation_LongHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_LongHint'; rValue : '������������� ��� ������ ���������� ���������');
  { undefined }
 str_PrintSelectedConfirmation_CheckCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_CheckCaption'; rValue : '������ �������� ���������� ��������');
  { undefined }
 str_PrintSelectedConfirmation_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_SettingsCaption'; rValue : '������');
  { undefined }
 str_PrintSelectedConfirmation_LongHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_LongHint'; rValue : '������������� ��� ������ ����������� ���������');
  { undefined }
 str_ExportSelectionToWord_CheckCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_CheckCaption'; rValue : '������ �������������� ���������� ��������');
  { undefined }
 str_ExportSelectionToWord_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_SettingsCaption'; rValue : '������� � MS-Word');
  { undefined }
 str_ExportSelectionToWord_LongHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_LongHint'; rValue : '������������� ��� �������� � MS-Word ����������� ���������');
  { undefined }
 str_ListExportSelectionToWord_CheckCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_CheckCaption'; rValue : '������ �������������� ���������� ��������');
  { undefined }
 str_ListExportSelectionToWord_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_SettingsCaption'; rValue : '������� � MS-Word');
  { undefined }
 str_ListExportSelectionToWord_LongHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_LongHint'; rValue : '������������� ��� �������� � MS-Word ���������� ���������');
  { undefined }

implementation

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

var
  { �������� ������ ��� ������� DocumentEMailSelection }
 str_DocumentEMailSelection_Choice_Selection : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_Choice_Selection'; rValue : '���������� ��������');
  { '���������� ��������' }
 str_DocumentEMailSelection_Choice_WholeDocument : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_Choice_WholeDocument'; rValue : '�������� �������');
  { '�������� �������' }

var
  { �������� ������ ��� ������� ListEMailSelection }
 str_ListEMailSelection_Choice_Selected : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_Choice_Selected'; rValue : '���������� ��������');
  { '���������� ��������' }
 str_ListEMailSelection_Choice_WholeList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_Choice_WholeList'; rValue : '������ �������');
  { '������ �������' }

var
  { �������� ������ ��� ������� ListPrintSelectedConfirmation }
 str_ListPrintSelectedConfirmation_Choice_Selected : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_Choice_Selected'; rValue : '���������� ��������');
  { '���������� ��������' }
 str_ListPrintSelectedConfirmation_Choice_WholeList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_Choice_WholeList'; rValue : '������ �������');
  { '������ �������' }

var
  { �������� ������ ��� ������� PrintSelectedConfirmation }
 str_PrintSelectedConfirmation_Choice_Selected : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_Choice_Selected'; rValue : '���������� ��������');
  { '���������� ��������' }
 str_PrintSelectedConfirmation_Choice_WholeDocument : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_Choice_WholeDocument'; rValue : '�������� �������');
  { '�������� �������' }

var
  { �������� ������ ��� ������� ExportSelectionToWord }
 str_ExportSelectionToWord_Choice_Selected : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_Choice_Selected'; rValue : '���������� ��������');
  { '���������� ��������' }
 str_ExportSelectionToWord_Choice_WholeDocument : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_Choice_WholeDocument'; rValue : '�������� �������');
  { '�������� �������' }

var
  { �������� ������ ��� ������� ListExportSelectionToWord }
 str_ListExportSelectionToWord_Choice_Selected : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_Choice_Selected'; rValue : '���������� ��������');
  { '���������� ��������' }
 str_ListExportSelectionToWord_Choice_WholeList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_Choice_WholeList'; rValue : '������ �������');
  { '������ �������' }

var
  { �������� ������ ��� ������� ConsultDocumentsNotFound }
 str_ConsultDocumentsNotFound_Choice_Spec : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFound_Choice_Spec'; rValue : '���������� � ������������ �������� ��������� ������');
  { '���������� � ������������ �������� ��������� ������' }
 str_ConsultDocumentsNotFound_Choice_Back : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFound_Choice_Back'; rValue : '��������� � �������� � �������� ������� �������');
  { '��������� � �������� � �������� ������� �������' }

var
  { �������� ������ ��� ������� ConsultDocumentsNotFoundNoSpec }
 str_ConsultDocumentsNotFoundNoSpec_Choice_Back : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFoundNoSpec_Choice_Back'; rValue : '��������� � �������� � �������� ������� �������');
  { '��������� � �������� � �������� ������� �������' }


initialization
// ������������� str_DocumentEMailSelection_Choice_Selection
 str_DocumentEMailSelection_Choice_Selection.Init;
// ������������� str_DocumentEMailSelection_Choice_WholeDocument
 str_DocumentEMailSelection_Choice_WholeDocument.Init;
// ������������� str_ListEMailSelection_Choice_Selected
 str_ListEMailSelection_Choice_Selected.Init;
// ������������� str_ListEMailSelection_Choice_WholeList
 str_ListEMailSelection_Choice_WholeList.Init;
// ������������� str_ListPrintSelectedConfirmation_Choice_Selected
 str_ListPrintSelectedConfirmation_Choice_Selected.Init;
// ������������� str_ListPrintSelectedConfirmation_Choice_WholeList
 str_ListPrintSelectedConfirmation_Choice_WholeList.Init;
// ������������� str_PrintSelectedConfirmation_Choice_Selected
 str_PrintSelectedConfirmation_Choice_Selected.Init;
// ������������� str_PrintSelectedConfirmation_Choice_WholeDocument
 str_PrintSelectedConfirmation_Choice_WholeDocument.Init;
// ������������� str_ExportSelectionToWord_Choice_Selected
 str_ExportSelectionToWord_Choice_Selected.Init;
// ������������� str_ExportSelectionToWord_Choice_WholeDocument
 str_ExportSelectionToWord_Choice_WholeDocument.Init;
// ������������� str_ListExportSelectionToWord_Choice_Selected
 str_ListExportSelectionToWord_Choice_Selected.Init;
// ������������� str_ListExportSelectionToWord_Choice_WholeList
 str_ListExportSelectionToWord_Choice_WholeList.Init;
// ������������� str_ConsultDocumentsNotFound_Choice_Spec
 str_ConsultDocumentsNotFound_Choice_Spec.Init;
// ������������� str_ConsultDocumentsNotFound_Choice_Back
 str_ConsultDocumentsNotFound_Choice_Back.Init;
// ������������� str_ConsultDocumentsNotFoundNoSpec_Choice_Back
 str_ConsultDocumentsNotFoundNoSpec_Choice_Back.Init;
// ������������� str_DocumentEMailSelection
 str_DocumentEMailSelection.Init;
 str_DocumentEMailSelection.AddChoice(str_DocumentEMailSelection_Choice_Selection);
 str_DocumentEMailSelection.AddChoice(str_DocumentEMailSelection_Choice_WholeDocument);
 str_DocumentEMailSelection.AddDefaultChoice(str_DocumentEMailSelection_Choice_Selection);
 str_DocumentEMailSelection.SetDlgType(mtConfirmation);
 str_DocumentEMailSelection.SetNeedCheck(true);
 str_DocumentEMailSelection.SetCheckCaption(str_DocumentEMailSelection_CheckCaption);
 str_DocumentEMailSelection.SetSettingsCaption(str_DocumentEMailSelection_SettingsCaption);
 str_DocumentEMailSelection.SetLongHint(str_DocumentEMailSelection_LongHint);
// ������������� str_ListEMailSelection
 str_ListEMailSelection.Init;
 str_ListEMailSelection.AddChoice(str_ListEMailSelection_Choice_Selected);
 str_ListEMailSelection.AddChoice(str_ListEMailSelection_Choice_WholeList);
 str_ListEMailSelection.AddDefaultChoice(str_ListEMailSelection_Choice_Selected);
 str_ListEMailSelection.SetDlgType(mtConfirmation);
 str_ListEMailSelection.SetNeedCheck(true);
 str_ListEMailSelection.SetCheckCaption(str_ListEMailSelection_CheckCaption);
 str_ListEMailSelection.SetSettingsCaption(str_ListEMailSelection_SettingsCaption);
 str_ListEMailSelection.SetLongHint(str_ListEMailSelection_LongHint);
// ������������� str_ListPrintSelectedConfirmation
 str_ListPrintSelectedConfirmation.Init;
 str_ListPrintSelectedConfirmation.AddChoice(str_ListPrintSelectedConfirmation_Choice_Selected);
 str_ListPrintSelectedConfirmation.AddChoice(str_ListPrintSelectedConfirmation_Choice_WholeList);
 str_ListPrintSelectedConfirmation.AddDefaultChoice(str_ListPrintSelectedConfirmation_Choice_Selected);
 str_ListPrintSelectedConfirmation.SetDlgType(mtConfirmation);
 str_ListPrintSelectedConfirmation.SetNeedCheck(true);
 str_ListPrintSelectedConfirmation.SetCheckCaption(str_ListPrintSelectedConfirmation_CheckCaption);
 str_ListPrintSelectedConfirmation.SetSettingsCaption(str_ListPrintSelectedConfirmation_SettingsCaption);
 str_ListPrintSelectedConfirmation.SetLongHint(str_ListPrintSelectedConfirmation_LongHint);
// ������������� str_PrintSelectedConfirmation
 str_PrintSelectedConfirmation.Init;
 str_PrintSelectedConfirmation.AddChoice(str_PrintSelectedConfirmation_Choice_Selected);
 str_PrintSelectedConfirmation.AddChoice(str_PrintSelectedConfirmation_Choice_WholeDocument);
 str_PrintSelectedConfirmation.AddDefaultChoice(str_PrintSelectedConfirmation_Choice_Selected);
 str_PrintSelectedConfirmation.SetDlgType(mtConfirmation);
 str_PrintSelectedConfirmation.SetNeedCheck(true);
 str_PrintSelectedConfirmation.SetCheckCaption(str_PrintSelectedConfirmation_CheckCaption);
 str_PrintSelectedConfirmation.SetSettingsCaption(str_PrintSelectedConfirmation_SettingsCaption);
 str_PrintSelectedConfirmation.SetLongHint(str_PrintSelectedConfirmation_LongHint);
// ������������� str_ExportSelectionToWord
 str_ExportSelectionToWord.Init;
 str_ExportSelectionToWord.AddChoice(str_ExportSelectionToWord_Choice_Selected);
 str_ExportSelectionToWord.AddChoice(str_ExportSelectionToWord_Choice_WholeDocument);
 str_ExportSelectionToWord.AddDefaultChoice(str_ExportSelectionToWord_Choice_Selected);
 str_ExportSelectionToWord.SetDlgType(mtConfirmation);
 str_ExportSelectionToWord.SetNeedCheck(true);
 str_ExportSelectionToWord.SetCheckCaption(str_ExportSelectionToWord_CheckCaption);
 str_ExportSelectionToWord.SetSettingsCaption(str_ExportSelectionToWord_SettingsCaption);
 str_ExportSelectionToWord.SetLongHint(str_ExportSelectionToWord_LongHint);
// ������������� str_ListExportSelectionToWord
 str_ListExportSelectionToWord.Init;
 str_ListExportSelectionToWord.AddChoice(str_ListExportSelectionToWord_Choice_Selected);
 str_ListExportSelectionToWord.AddChoice(str_ListExportSelectionToWord_Choice_WholeList);
 str_ListExportSelectionToWord.AddDefaultChoice(str_ListExportSelectionToWord_Choice_Selected);
 str_ListExportSelectionToWord.SetDlgType(mtConfirmation);
 str_ListExportSelectionToWord.SetNeedCheck(true);
 str_ListExportSelectionToWord.SetCheckCaption(str_ListExportSelectionToWord_CheckCaption);
 str_ListExportSelectionToWord.SetSettingsCaption(str_ListExportSelectionToWord_SettingsCaption);
 str_ListExportSelectionToWord.SetLongHint(str_ListExportSelectionToWord_LongHint);
// ������������� str_ConsultDocumentsNotFound
 str_ConsultDocumentsNotFound.Init;
 str_ConsultDocumentsNotFound.AddChoice(str_ConsultDocumentsNotFound_Choice_Spec);
 str_ConsultDocumentsNotFound.AddChoice(str_ConsultDocumentsNotFound_Choice_Back);
 str_ConsultDocumentsNotFound.AddCustomChoice(str_ConsultDocumentsNotFound_Choice_Spec);
 str_ConsultDocumentsNotFound.SetDlgType(mtWarning);
// ������������� str_ConsultDocumentsNotFoundNoSpec
 str_ConsultDocumentsNotFoundNoSpec.Init;
 str_ConsultDocumentsNotFoundNoSpec.AddChoice(str_ConsultDocumentsNotFoundNoSpec_Choice_Back);
 str_ConsultDocumentsNotFoundNoSpec.SetDlgType(mtWarning);
// ������������� str_DocumentEMailSelection_CheckCaption
 str_DocumentEMailSelection_CheckCaption.Init;
// ������������� str_DocumentEMailSelection_SettingsCaption
 str_DocumentEMailSelection_SettingsCaption.Init;
// ������������� str_DocumentEMailSelection_LongHint
 str_DocumentEMailSelection_LongHint.Init;
// ������������� str_ListEMailSelection_CheckCaption
 str_ListEMailSelection_CheckCaption.Init;
// ������������� str_ListEMailSelection_SettingsCaption
 str_ListEMailSelection_SettingsCaption.Init;
// ������������� str_ListEMailSelection_LongHint
 str_ListEMailSelection_LongHint.Init;
// ������������� str_ListPrintSelectedConfirmation_CheckCaption
 str_ListPrintSelectedConfirmation_CheckCaption.Init;
// ������������� str_ListPrintSelectedConfirmation_SettingsCaption
 str_ListPrintSelectedConfirmation_SettingsCaption.Init;
// ������������� str_ListPrintSelectedConfirmation_LongHint
 str_ListPrintSelectedConfirmation_LongHint.Init;
// ������������� str_PrintSelectedConfirmation_CheckCaption
 str_PrintSelectedConfirmation_CheckCaption.Init;
// ������������� str_PrintSelectedConfirmation_SettingsCaption
 str_PrintSelectedConfirmation_SettingsCaption.Init;
// ������������� str_PrintSelectedConfirmation_LongHint
 str_PrintSelectedConfirmation_LongHint.Init;
// ������������� str_ExportSelectionToWord_CheckCaption
 str_ExportSelectionToWord_CheckCaption.Init;
// ������������� str_ExportSelectionToWord_SettingsCaption
 str_ExportSelectionToWord_SettingsCaption.Init;
// ������������� str_ExportSelectionToWord_LongHint
 str_ExportSelectionToWord_LongHint.Init;
// ������������� str_ListExportSelectionToWord_CheckCaption
 str_ListExportSelectionToWord_CheckCaption.Init;
// ������������� str_ListExportSelectionToWord_SettingsCaption
 str_ListExportSelectionToWord_SettingsCaption.Init;
// ������������� str_ListExportSelectionToWord_LongHint
 str_ListExportSelectionToWord_LongHint.Init;

end.