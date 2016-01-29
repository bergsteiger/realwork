{$IfNDef ListUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ListUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _ListUserTypes_ = {abstract form} class(_ListUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure LftRespondentQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftRespondent.OnQueryMaximized }
   procedure LftRespondentQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftRespondent.OnQueryOpen }
   procedure LftRespondentQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftRespondent.OnQueryClose }
   procedure LftCorrespondentQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftCorrespondent.OnQueryMaximized }
   procedure LftCorrespondentQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftCorrespondent.OnQueryOpen }
   procedure LftCorrespondentQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftCorrespondent.OnQueryClose }
   procedure LftSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSynchroView.OnQueryMaximized }
   procedure LftSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSynchroView.OnQueryOpen }
   procedure LftCToPartQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftCToPart.OnQueryMaximized }
   procedure LftCToPartQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftCToPart.OnQueryOpen }
   procedure LftUserCR1QueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCR1.OnQueryMaximized }
   procedure LftUserCR1QueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCR1.OnQueryOpen }
   procedure LftUserCR1QueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCR1.OnQueryClose }
   procedure LftUserCR2QueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCR2.OnQueryMaximized }
   procedure LftUserCR2QueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCR2.OnQueryOpen }
   procedure LftUserCR2QueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCR2.OnQueryClose }
   procedure LftConsultationQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftConsultation.OnQueryMaximized }
   procedure LftConsultationQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftConsultation.OnQueryOpen }
   procedure LftConsultationQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftConsultation.OnQueryClose }
   procedure LftSimilarDocumentsQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocuments.OnQueryMaximized }
   procedure LftSimilarDocumentsQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocuments.OnQueryOpen }
   procedure LftSimilarDocumentsQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocuments.OnQueryClose }
   procedure LftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocumentsSynchroView.OnQueryMaximized }
   procedure LftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocumentsSynchroView.OnQueryOpen }
   procedure LftCorrespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftCorrespondentsSynchroForm.OnQueryMaximized }
   procedure LftCorrespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftCorrespondentsSynchroForm.OnQueryOpen }
   procedure LftRespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftRespondentsSynchroForm.OnQueryMaximized }
   procedure LftRespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftRespondentsSynchroForm.OnQueryOpen }
   procedure LftUserCRList1SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCRList1_SynchorForm.OnQueryMaximized }
   procedure LftUserCRList1SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCRList1_SynchorForm.OnQueryOpen }
   procedure LftUserCRList2SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCRList2_SynchorForm.OnQueryMaximized }
   procedure LftUserCRList2SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftUserCRList2_SynchorForm.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryMaximized }
   procedure LftDrugInternationalNameSynonymsQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryClose }
   procedure LftProducedDrugsQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftProducedDrugs.OnQueryMaximized }
   procedure LftProducedDrugsQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftProducedDrugs.OnQueryOpen }
   procedure LftProducedDrugsQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftProducedDrugs.OnQueryClose }
   procedure LftProducedDrugsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftProducedDrugsSynchroForm.OnQueryMaximized }
   procedure LftProducedDrugsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftProducedDrugsSynchroForm.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftDrugInternationalNameSynonymsSynchroForm.OnQueryMaximized }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftDrugInternationalNameSynonymsSynchroForm.OnQueryOpen }
   procedure LftRToPartQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftRToPart.OnQueryMaximized }
   procedure LftRToPartQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftRToPart.OnQueryOpen }
   procedure LftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryMaximized }
   procedure LftSimilarDocumentsToFragmentQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryOpen }
   procedure LftSimilarDocumentsToFragmentQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryClose }
 end;//_ListUserTypes_
{$Else}

 _ListUserTypes_ = _ListUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else ListUserTypes_imp}

{$IfNDef ListUserTypes_imp_impl}
{$Define ListUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ lftNoneLocalConstants }
  str_lftNoneCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftNoneCaption'; rValue : '������');
   { ��������� ����������������� ���� "������" }

var
   { ������������ ������ lftRespondentLocalConstants }
  str_lftRespondentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentCaption'; rValue : '������ �� ���������');
   { ��������� ����������������� ���� "������ �� ���������" }
  str_lftRespondentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentSettingsCaption'; rValue : '������: ������ �� ��������� (���)/������ �� �������� (���)');
   { ��������� ����������������� ���� "������ �� ���������" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftCorrespondentLocalConstants }
  str_lftCorrespondentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentCaption'; rValue : '������ �� ��������');
   { ��������� ����������������� ���� "������ �� ��������" }
  str_lftCorrespondentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentSettingsCaption'; rValue : '������: ������ �� ��������');
   { ��������� ����������������� ���� "������ �� ��������" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftSynchroViewLocalConstants }
  str_lftSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewCaption'; rValue : '���������� �������� (������ �� ���������, ������ �� ��������)');
   { ��������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" }
  str_lftSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ���������/�� ��������');
   { ��������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftCToPartLocalConstants }
  str_lftCToPartCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartCaption'; rValue : '������ �� ��������');
   { ��������� ����������������� ���� "������ �� ��������" }
  str_lftCToPartSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartSettingsCaption'; rValue : '������: ������ �� ��������');
   { ��������� ����������������� ���� "������ �� ��������" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftUserCR1LocalConstants }
  str_lftUserCR1Caption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1Caption'; rValue : '������������� ������� ��������� ���������� 1');
   { ��������� ����������������� ���� "������������� ������� ��������� ���������� 1" }
  str_lftUserCR1SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1SettingsCaption'; rValue : '������: ������ �� ��������� (��� ����������)/������ �� �������� (��� ����������)');
   { ��������� ����������������� ���� "������������� ������� ��������� ���������� 1" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftUserCR2LocalConstants }
  str_lftUserCR2Caption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2Caption'; rValue : '������������� ������� ��������� ���������� 2');
   { ��������� ����������������� ���� "������������� ������� ��������� ���������� 2" }
  str_lftUserCR2SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2SettingsCaption'; rValue : '������: ���������������� ������� ������ �� �������� (������ �� ���������) 2');
   { ��������� ����������������� ���� "������������� ������� ��������� ���������� 2" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftConsultationLocalConstants }
  str_lftConsultationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationCaption'; rValue : '������������');
   { ��������� ����������������� ���� "������������" }
  str_lftConsultationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationSettingsCaption'; rValue : '������: ������������');
   { ��������� ����������������� ���� "������������" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftSimilarDocumentsLocalConstants }
  str_lftSimilarDocumentsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsCaption'; rValue : '������� ���������');
   { ��������� ����������������� ���� "������� ���������" }
  str_lftSimilarDocumentsSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSettingsCaption'; rValue : '������: ������� ���������');
   { ��������� ����������������� ���� "������� ���������" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftSimilarDocumentsSynchroViewLocalConstants }
  str_lftSimilarDocumentsSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewCaption'; rValue : '���������� �������� (������� ���������)');
   { ��������� ����������������� ���� "���������� �������� (������� ���������)" }
  str_lftSimilarDocumentsSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewSettingsCaption'; rValue : '���������� ��������: ������� ���������');
   { ��������� ����������������� ���� "���������� �������� (������� ���������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftCorrespondentsSynchroFormLocalConstants }
  str_lftCorrespondentsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormCaption'; rValue : '���������� �������� (������ �� ��������)');
   { ��������� ����������������� ���� "���������� �������� (������ �� ��������)" }
  str_lftCorrespondentsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ��������');
   { ��������� ����������������� ���� "���������� �������� (������ �� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftRespondentsSynchroFormLocalConstants }
  str_lftRespondentsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormCaption'; rValue : '���������� �������� (������ �� ���������)');
   { ��������� ����������������� ���� "���������� �������� (������ �� ���������)" }
  str_lftRespondentsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ���������');
   { ��������� ����������������� ���� "���������� �������� (������ �� ���������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftUserCRList1_SynchorFormLocalConstants }
  str_lftUserCRList1_SynchorFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormCaption'; rValue : '���������� �������� (������������� ������� ��������� ���������� 1)');
   { ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 1)" }
  str_lftUserCRList1_SynchorFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormSettingsCaption'; rValue : '���������� ��������: ������ ���������������� ������� ������ ������� �� ��������\�� ���������');
   { ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 1)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftUserCRList2_SynchorFormLocalConstants }
  str_lftUserCRList2_SynchorFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormCaption'; rValue : '���������� �������� (������������� ������� ��������� ���������� 2)');
   { ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" }
  str_lftUserCRList2_SynchorFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormSettingsCaption'; rValue : '���������� ��������: ������ ���������������� ������� ������ ������� �� ��������\�� ���������');
   { ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftDrugListLocalConstants }
  str_lftDrugListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugListCaption'; rValue : '������ ����������');
   { ��������� ����������������� ���� "������ ����������" }

var
   { ������������ ������ lftDrugInternationalNameSynonymsLocalConstants }
  str_lftDrugInternationalNameSynonymsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsCaption'; rValue : '�������� �� �������������� ��������');
   { ��������� ����������������� ���� "�������� �� �������������� ��������" }

var
   { ������������ ������ lftProducedDrugsLocalConstants }
  str_lftProducedDrugsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsCaption'; rValue : '����������� ���������');
   { ��������� ����������������� ���� "����������� ���������" }

var
   { ������������ ������ lftProducedDrugsSynchroFormLocalConstants }
  str_lftProducedDrugsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormCaption'; rValue : '���������� �������� (����������� ���������)');
   { ��������� ����������������� ���� "���������� �������� (����������� ���������)" }
  str_lftProducedDrugsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormSettingsCaption'; rValue : '���������� ��������: ����������� ���������');
   { ��������� ����������������� ���� "���������� �������� (����������� ���������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftDrugInternationalNameSynonymsSynchroFormLocalConstants }
  str_lftDrugInternationalNameSynonymsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormCaption'; rValue : '���������� �������� (�������� �� �������������� ��������)');
   { ��������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" }
  str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormSettingsCaption'; rValue : '���������� ��������: �������� �� �������������� ��������');
   { ��������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftRToPartLocalConstants }
  str_lftRToPartCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartCaption'; rValue : '������ �� ���������');
   { ��������� ����������������� ���� "������ �� ���������" }
  str_lftRToPartSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartSettingsCaption'; rValue : '������: ������ �� ���������');
   { ��������� ����������������� ���� "������ �� ���������" ��� ��������� ������� ������������ }

var
   { ������������ ������ lftSimilarDocumentsToFragmentLocalConstants }
  str_lftSimilarDocumentsToFragmentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentCaption'; rValue : '������� � ���������');
   { ��������� ����������������� ���� "������� � ���������" }
  str_lftSimilarDocumentsToFragmentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentSettingsCaption'; rValue : '������: ������� � ���������');
   { ��������� ����������������� ���� "������� � ���������" ��� ��������� ������� ������������ }

// start class _ListUserTypes_

procedure _ListUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(lftNoneName,
  str_lftNoneCaption,
  str_lftNoneCaption,
  true,
  64,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftNoneName
 with AddUsertype(lftRespondentName,
  str_lftRespondentCaption,
  str_lftRespondentSettingsCaption,
  true,
  17,
  40,
  '',
  LftRespondentQueryMaximized,
  LftRespondentQueryOpen,
  LftRespondentQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftRespondentName
 with AddUsertype(lftCorrespondentName,
  str_lftCorrespondentCaption,
  str_lftCorrespondentSettingsCaption,
  true,
  18,
  50,
  lftRespondentName,
  LftCorrespondentQueryMaximized,
  LftCorrespondentQueryOpen,
  LftCorrespondentQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftCorrespondentName
 with AddUsertype(lftSynchroViewName,
  str_lftSynchroViewCaption,
  str_lftSynchroViewSettingsCaption,
  true,
  -1,
  -1,
  '',
  LftSynchroViewQueryMaximized,
  LftSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSynchroViewName
 with AddUsertype(lftCToPartName,
  str_lftCToPartCaption,
  str_lftCToPartSettingsCaption,
  false,
  -1,
  60,
  lftRespondentName,
  LftCToPartQueryMaximized,
  LftCToPartQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftCToPartName
 with AddUsertype(lftUserCR1Name,
  str_lftUserCR1Caption,
  str_lftUserCR1SettingsCaption,
  true,
  -1,
  80,
  '',
  LftUserCR1QueryMaximized,
  LftUserCR1QueryOpen,
  LftUserCR1QueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCR1Name
 with AddUsertype(lftUserCR2Name,
  str_lftUserCR2Caption,
  str_lftUserCR2SettingsCaption,
  true,
  -1,
  100,
  lftUserCR1Name,
  LftUserCR2QueryMaximized,
  LftUserCR2QueryOpen,
  LftUserCR2QueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCR2Name
 with AddUsertype(lftConsultationName,
  str_lftConsultationCaption,
  str_lftConsultationSettingsCaption,
  true,
  64,
  -1,
  '',
  LftConsultationQueryMaximized,
  LftConsultationQueryOpen,
  LftConsultationQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftConsultationName
 with AddUsertype(lftSimilarDocumentsName,
  str_lftSimilarDocumentsCaption,
  str_lftSimilarDocumentsSettingsCaption,
  true,
  166,
  120,
  '',
  LftSimilarDocumentsQueryMaximized,
  LftSimilarDocumentsQueryOpen,
  LftSimilarDocumentsQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSimilarDocumentsName
 with AddUsertype(lftSimilarDocumentsSynchroViewName,
  str_lftSimilarDocumentsSynchroViewCaption,
  str_lftSimilarDocumentsSynchroViewSettingsCaption,
  true,
  -1,
  -1,
  '',
  LftSimilarDocumentsSynchroViewQueryMaximized,
  LftSimilarDocumentsSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSimilarDocumentsSynchroViewName
 with AddUsertype(lftCorrespondentsSynchroFormName,
  str_lftCorrespondentsSynchroFormCaption,
  str_lftCorrespondentsSynchroFormSettingsCaption,
  true,
  18,
  -1,
  '',
  LftCorrespondentsSynchroFormQueryMaximized,
  LftCorrespondentsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftCorrespondentsSynchroFormName
 with AddUsertype(lftRespondentsSynchroFormName,
  str_lftRespondentsSynchroFormCaption,
  str_lftRespondentsSynchroFormSettingsCaption,
  true,
  17,
  -1,
  '',
  LftRespondentsSynchroFormQueryMaximized,
  LftRespondentsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftRespondentsSynchroFormName
 with AddUsertype(lftUserCRList1_SynchorFormName,
  str_lftUserCRList1_SynchorFormCaption,
  str_lftUserCRList1_SynchorFormSettingsCaption,
  true,
  -1,
  -1,
  '',
  LftUserCRList1SynchorFormQueryMaximized,
  LftUserCRList1SynchorFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCRList1_SynchorFormName
 with AddUsertype(lftUserCRList2_SynchorFormName,
  str_lftUserCRList2_SynchorFormCaption,
  str_lftUserCRList2_SynchorFormSettingsCaption,
  true,
  -1,
  -1,
  '',
  LftUserCRList2SynchorFormQueryMaximized,
  LftUserCRList2SynchorFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCRList2_SynchorFormName
 with AddUsertype(lftDrugListName,
  str_lftDrugListCaption,
  str_lftDrugListCaption,
  true,
  180,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftDrugListName
 with AddUsertype(lftDrugInternationalNameSynonymsName,
  str_lftDrugInternationalNameSynonymsCaption,
  str_lftDrugInternationalNameSynonymsCaption,
  true,
  181,
  -1,
  '',
  LftDrugInternationalNameSynonymsQueryMaximized,
  LftDrugInternationalNameSynonymsQueryOpen,
  LftDrugInternationalNameSynonymsQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftDrugInternationalNameSynonymsName
 with AddUsertype(lftProducedDrugsName,
  str_lftProducedDrugsCaption,
  str_lftProducedDrugsCaption,
  true,
  183,
  -1,
  '',
  LftProducedDrugsQueryMaximized,
  LftProducedDrugsQueryOpen,
  LftProducedDrugsQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftProducedDrugsName
 with AddUsertype(lftProducedDrugsSynchroFormName,
  str_lftProducedDrugsSynchroFormCaption,
  str_lftProducedDrugsSynchroFormSettingsCaption,
  true,
  -1,
  -1,
  '',
  LftProducedDrugsSynchroFormQueryMaximized,
  LftProducedDrugsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftProducedDrugsSynchroFormName
 with AddUsertype(lftDrugInternationalNameSynonymsSynchroFormName,
  str_lftDrugInternationalNameSynonymsSynchroFormCaption,
  str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption,
  true,
  -1,
  -1,
  '',
  LftDrugInternationalNameSynonymsSynchroFormQueryMaximized,
  LftDrugInternationalNameSynonymsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftDrugInternationalNameSynonymsSynchroFormName
 with AddUsertype(lftRToPartName,
  str_lftRToPartCaption,
  str_lftRToPartSettingsCaption,
  false,
  -1,
  61,
  lftRespondentName,
  LftRToPartQueryMaximized,
  LftRToPartQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftRToPartName
 with AddUsertype(lftSimilarDocumentsToFragmentName,
  str_lftSimilarDocumentsToFragmentCaption,
  str_lftSimilarDocumentsToFragmentSettingsCaption,
  true,
  166,
  25,
  lftSimilarDocumentsName,
  LftSimilarDocumentsToFragmentQueryMaximized,
  LftSimilarDocumentsToFragmentQueryOpen,
  LftSimilarDocumentsToFragmentQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSimilarDocumentsToFragmentName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  ListUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lftNoneCaption
 str_lftNoneCaption.Init;
// ������������� str_lftRespondentCaption
 str_lftRespondentCaption.Init;
// ������������� str_lftRespondentSettingsCaption
 str_lftRespondentSettingsCaption.Init;
// ������������� str_lftCorrespondentCaption
 str_lftCorrespondentCaption.Init;
// ������������� str_lftCorrespondentSettingsCaption
 str_lftCorrespondentSettingsCaption.Init;
// ������������� str_lftSynchroViewCaption
 str_lftSynchroViewCaption.Init;
// ������������� str_lftSynchroViewSettingsCaption
 str_lftSynchroViewSettingsCaption.Init;
// ������������� str_lftCToPartCaption
 str_lftCToPartCaption.Init;
// ������������� str_lftCToPartSettingsCaption
 str_lftCToPartSettingsCaption.Init;
// ������������� str_lftUserCR1Caption
 str_lftUserCR1Caption.Init;
// ������������� str_lftUserCR1SettingsCaption
 str_lftUserCR1SettingsCaption.Init;
// ������������� str_lftUserCR2Caption
 str_lftUserCR2Caption.Init;
// ������������� str_lftUserCR2SettingsCaption
 str_lftUserCR2SettingsCaption.Init;
// ������������� str_lftConsultationCaption
 str_lftConsultationCaption.Init;
// ������������� str_lftConsultationSettingsCaption
 str_lftConsultationSettingsCaption.Init;
// ������������� str_lftSimilarDocumentsCaption
 str_lftSimilarDocumentsCaption.Init;
// ������������� str_lftSimilarDocumentsSettingsCaption
 str_lftSimilarDocumentsSettingsCaption.Init;
// ������������� str_lftSimilarDocumentsSynchroViewCaption
 str_lftSimilarDocumentsSynchroViewCaption.Init;
// ������������� str_lftSimilarDocumentsSynchroViewSettingsCaption
 str_lftSimilarDocumentsSynchroViewSettingsCaption.Init;
// ������������� str_lftCorrespondentsSynchroFormCaption
 str_lftCorrespondentsSynchroFormCaption.Init;
// ������������� str_lftCorrespondentsSynchroFormSettingsCaption
 str_lftCorrespondentsSynchroFormSettingsCaption.Init;
// ������������� str_lftRespondentsSynchroFormCaption
 str_lftRespondentsSynchroFormCaption.Init;
// ������������� str_lftRespondentsSynchroFormSettingsCaption
 str_lftRespondentsSynchroFormSettingsCaption.Init;
// ������������� str_lftUserCRList1_SynchorFormCaption
 str_lftUserCRList1_SynchorFormCaption.Init;
// ������������� str_lftUserCRList1_SynchorFormSettingsCaption
 str_lftUserCRList1_SynchorFormSettingsCaption.Init;
// ������������� str_lftUserCRList2_SynchorFormCaption
 str_lftUserCRList2_SynchorFormCaption.Init;
// ������������� str_lftUserCRList2_SynchorFormSettingsCaption
 str_lftUserCRList2_SynchorFormSettingsCaption.Init;
// ������������� str_lftDrugListCaption
 str_lftDrugListCaption.Init;
// ������������� str_lftDrugInternationalNameSynonymsCaption
 str_lftDrugInternationalNameSynonymsCaption.Init;
// ������������� str_lftProducedDrugsCaption
 str_lftProducedDrugsCaption.Init;
// ������������� str_lftProducedDrugsSynchroFormCaption
 str_lftProducedDrugsSynchroFormCaption.Init;
// ������������� str_lftProducedDrugsSynchroFormSettingsCaption
 str_lftProducedDrugsSynchroFormSettingsCaption.Init;
// ������������� str_lftDrugInternationalNameSynonymsSynchroFormCaption
 str_lftDrugInternationalNameSynonymsSynchroFormCaption.Init;
// ������������� str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption.Init;
// ������������� str_lftRToPartCaption
 str_lftRToPartCaption.Init;
// ������������� str_lftRToPartSettingsCaption
 str_lftRToPartSettingsCaption.Init;
// ������������� str_lftSimilarDocumentsToFragmentCaption
 str_lftSimilarDocumentsToFragmentCaption.Init;
// ������������� str_lftSimilarDocumentsToFragmentSettingsCaption
 str_lftSimilarDocumentsToFragmentSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf ListUserTypes_imp_impl}
{$EndIf ListUserTypes_imp}
