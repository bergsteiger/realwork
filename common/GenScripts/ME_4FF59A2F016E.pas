{$IfNDef ListUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "ListUserTypes" MUID: (4FF59A2F016E)
// ��� ����: "_ListUserTypes_"

{$Define ListUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListUserTypes_ = {abstract} class(_ListUserTypes_Parent_)
  protected
   procedure lftRespondentQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftRespondent.OnQueryMaximized }
   procedure lftRespondentQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftRespondent.OnQueryOpen }
   procedure lftRespondentQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftRespondent.OnQueryClose }
   procedure lftCorrespondentQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftCorrespondent.OnQueryMaximized }
   procedure lftCorrespondentQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftCorrespondent.OnQueryOpen }
   procedure lftCorrespondentQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftCorrespondent.OnQueryClose }
   procedure lftSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSynchroView.OnQueryMaximized }
   procedure lftSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSynchroView.OnQueryOpen }
   procedure lftCToPartQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftCToPart.OnQueryMaximized }
   procedure lftCToPartQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftCToPart.OnQueryOpen }
   procedure lftUserCR1QueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCR1.OnQueryMaximized }
   procedure lftUserCR1QueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCR1.OnQueryOpen }
   procedure lftUserCR1QueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCR1.OnQueryClose }
   procedure lftUserCR2QueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCR2.OnQueryMaximized }
   procedure lftUserCR2QueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCR2.OnQueryOpen }
   procedure lftUserCR2QueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCR2.OnQueryClose }
   procedure lftConsultationQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftConsultation.OnQueryMaximized }
   procedure lftConsultationQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftConsultation.OnQueryOpen }
   procedure lftConsultationQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftConsultation.OnQueryClose }
   procedure lftSimilarDocumentsQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocuments.OnQueryMaximized }
   procedure lftSimilarDocumentsQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocuments.OnQueryOpen }
   procedure lftSimilarDocumentsQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocuments.OnQueryClose }
   procedure lftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocumentsSynchroView.OnQueryMaximized }
   procedure lftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocumentsSynchroView.OnQueryOpen }
   procedure lftCorrespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftCorrespondentsSynchroForm.OnQueryMaximized }
   procedure lftCorrespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftCorrespondentsSynchroForm.OnQueryOpen }
   procedure lftRespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftRespondentsSynchroForm.OnQueryMaximized }
   procedure lftRespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftRespondentsSynchroForm.OnQueryOpen }
   procedure lftUserCRList1_SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCRList1_SynchorForm.OnQueryMaximized }
   procedure lftUserCRList1_SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCRList1_SynchorForm.OnQueryOpen }
   procedure lftUserCRList2_SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCRList2_SynchorForm.OnQueryMaximized }
   procedure lftUserCRList2_SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftUserCRList2_SynchorForm.OnQueryOpen }
   procedure lftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryMaximized }
   procedure lftDrugInternationalNameSynonymsQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryOpen }
   procedure lftDrugInternationalNameSynonymsQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryClose }
   procedure lftProducedDrugsQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftProducedDrugs.OnQueryMaximized }
   procedure lftProducedDrugsQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftProducedDrugs.OnQueryOpen }
   procedure lftProducedDrugsQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftProducedDrugs.OnQueryClose }
   procedure lftProducedDrugsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftProducedDrugsSynchroForm.OnQueryMaximized }
   procedure lftProducedDrugsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftProducedDrugsSynchroForm.OnQueryOpen }
   procedure lftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftDrugInternationalNameSynonymsSynchroForm.OnQueryMaximized }
   procedure lftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftDrugInternationalNameSynonymsSynchroForm.OnQueryOpen }
   procedure lftRToPartQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftRToPart.OnQueryMaximized }
   procedure lftRToPartQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftRToPart.OnQueryOpen }
   procedure lftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryMaximized }
   procedure lftSimilarDocumentsToFragmentQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryOpen }
   procedure lftSimilarDocumentsToFragmentQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_ListUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ListUserTypes_ = _ListUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ListUserTypes_imp}

{$IfNDef ListUserTypes_imp_impl}

{$Define ListUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ lftNoneLocalConstants }
 str_lftNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftNoneCaption'; rValue : '������');
  {* ��������� ����������������� ���� "������" }
 {* ������������ ������ lftRespondentLocalConstants }
 str_lftRespondentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentCaption'; rValue : '������ �� ���������');
  {* ��������� ����������������� ���� "������ �� ���������" }
 str_lftRespondentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentSettingsCaption'; rValue : '������: ������ �� ��������� (���)/������ �� �������� (���)');
  {* ��������� ����������������� ���� "������ �� ���������" ��� ��������� ������� ������������ }
 {* ������������ ������ lftCorrespondentLocalConstants }
 str_lftCorrespondentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentCaption'; rValue : '������ �� ��������');
  {* ��������� ����������������� ���� "������ �� ��������" }
 str_lftCorrespondentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentSettingsCaption'; rValue : '������: ������ �� ��������');
  {* ��������� ����������������� ���� "������ �� ��������" ��� ��������� ������� ������������ }
 {* ������������ ������ lftSynchroViewLocalConstants }
 str_lftSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewCaption'; rValue : '���������� �������� (������ �� ���������, ������ �� ��������)');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" }
 str_lftSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ���������/�� ��������');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftCToPartLocalConstants }
 str_lftCToPartCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartCaption'; rValue : '������ �� ��������');
  {* ��������� ����������������� ���� "������ �� ��������" }
 str_lftCToPartSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartSettingsCaption'; rValue : '������: ������ �� ��������');
  {* ��������� ����������������� ���� "������ �� ��������" ��� ��������� ������� ������������ }
 {* ������������ ������ lftUserCR1LocalConstants }
 str_lftUserCR1Caption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1Caption'; rValue : '������������� ������� ��������� ���������� 1');
  {* ��������� ����������������� ���� "������������� ������� ��������� ���������� 1" }
 str_lftUserCR1SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1SettingsCaption'; rValue : '������: ������ �� ��������� (��� ����������)/������ �� �������� (��� ����������)');
  {* ��������� ����������������� ���� "������������� ������� ��������� ���������� 1" ��� ��������� ������� ������������ }
 {* ������������ ������ lftUserCR2LocalConstants }
 str_lftUserCR2Caption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2Caption'; rValue : '������������� ������� ��������� ���������� 2');
  {* ��������� ����������������� ���� "������������� ������� ��������� ���������� 2" }
 str_lftUserCR2SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2SettingsCaption'; rValue : '������: ���������������� ������� ������ �� �������� (������ �� ���������) 2');
  {* ��������� ����������������� ���� "������������� ������� ��������� ���������� 2" ��� ��������� ������� ������������ }
 {* ������������ ������ lftConsultationLocalConstants }
 str_lftConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationCaption'; rValue : '������������');
  {* ��������� ����������������� ���� "������������" }
 str_lftConsultationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationSettingsCaption'; rValue : '������: ������������');
  {* ��������� ����������������� ���� "������������" ��� ��������� ������� ������������ }
 {* ������������ ������ lftSimilarDocumentsLocalConstants }
 str_lftSimilarDocumentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsCaption'; rValue : '������� ���������');
  {* ��������� ����������������� ���� "������� ���������" }
 str_lftSimilarDocumentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSettingsCaption'; rValue : '������: ������� ���������');
  {* ��������� ����������������� ���� "������� ���������" ��� ��������� ������� ������������ }
 {* ������������ ������ lftSimilarDocumentsSynchroViewLocalConstants }
 str_lftSimilarDocumentsSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewCaption'; rValue : '���������� �������� (������� ���������)');
  {* ��������� ����������������� ���� "���������� �������� (������� ���������)" }
 str_lftSimilarDocumentsSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewSettingsCaption'; rValue : '���������� ��������: ������� ���������');
  {* ��������� ����������������� ���� "���������� �������� (������� ���������)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftCorrespondentsSynchroFormLocalConstants }
 str_lftCorrespondentsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormCaption'; rValue : '���������� �������� (������ �� ��������)');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ��������)" }
 str_lftCorrespondentsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ��������');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftRespondentsSynchroFormLocalConstants }
 str_lftRespondentsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormCaption'; rValue : '���������� �������� (������ �� ���������)');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������)" }
 str_lftRespondentsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ���������');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftUserCRList1_SynchorFormLocalConstants }
 str_lftUserCRList1_SynchorFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormCaption'; rValue : '���������� �������� (������������� ������� ��������� ���������� 1)');
  {* ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 1)" }
 str_lftUserCRList1_SynchorFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormSettingsCaption'; rValue : '���������� ��������: ������ ���������������� ������� ������ ������� �� ��������\�� ���������');
  {* ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 1)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftUserCRList2_SynchorFormLocalConstants }
 str_lftUserCRList2_SynchorFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormCaption'; rValue : '���������� �������� (������������� ������� ��������� ���������� 2)');
  {* ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" }
 str_lftUserCRList2_SynchorFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormSettingsCaption'; rValue : '���������� ��������: ������ ���������������� ������� ������ ������� �� ��������\�� ���������');
  {* ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftDrugListLocalConstants }
 str_lftDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugListCaption'; rValue : '������ ����������');
  {* ��������� ����������������� ���� "������ ����������" }
 {* ������������ ������ lftDrugInternationalNameSynonymsLocalConstants }
 str_lftDrugInternationalNameSynonymsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsCaption'; rValue : '�������� �� �������������� ��������');
  {* ��������� ����������������� ���� "�������� �� �������������� ��������" }
 {* ������������ ������ lftProducedDrugsLocalConstants }
 str_lftProducedDrugsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsCaption'; rValue : '����������� ���������');
  {* ��������� ����������������� ���� "����������� ���������" }
 {* ������������ ������ lftProducedDrugsSynchroFormLocalConstants }
 str_lftProducedDrugsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormCaption'; rValue : '���������� �������� (����������� ���������)');
  {* ��������� ����������������� ���� "���������� �������� (����������� ���������)" }
 str_lftProducedDrugsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormSettingsCaption'; rValue : '���������� ��������: ����������� ���������');
  {* ��������� ����������������� ���� "���������� �������� (����������� ���������)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftDrugInternationalNameSynonymsSynchroFormLocalConstants }
 str_lftDrugInternationalNameSynonymsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormCaption'; rValue : '���������� �������� (�������� �� �������������� ��������)');
  {* ��������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" }
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormSettingsCaption'; rValue : '���������� ��������: �������� �� �������������� ��������');
  {* ��������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ lftRToPartLocalConstants }
 str_lftRToPartCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartCaption'; rValue : '������ �� ���������');
  {* ��������� ����������������� ���� "������ �� ���������" }
 str_lftRToPartSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartSettingsCaption'; rValue : '������: ������ �� ���������');
  {* ��������� ����������������� ���� "������ �� ���������" ��� ��������� ������� ������������ }
 {* ������������ ������ lftSimilarDocumentsToFragmentLocalConstants }
 str_lftSimilarDocumentsToFragmentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentCaption'; rValue : '������� � ���������');
  {* ��������� ����������������� ���� "������� � ���������" }
 str_lftSimilarDocumentsToFragmentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentSettingsCaption'; rValue : '������: ������� � ���������');
  {* ��������� ����������������� ���� "������� � ���������" ��� ��������� ������� ������������ }

{$If NOT Defined(NoVCM)}
procedure _ListUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(lftNoneName,
  str_lftNoneCaption,
  str_lftNoneCaption,
  False,
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
  False,
  17,
  40,
  '',
  lftRespondentQueryMaximized,
  lftRespondentQueryOpen,
  lftRespondentQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftRespondentName
 with AddUsertype(lftCorrespondentName,
  str_lftCorrespondentCaption,
  str_lftCorrespondentSettingsCaption,
  False,
  18,
  50,
  lftRespondentName,
  lftCorrespondentQueryMaximized,
  lftCorrespondentQueryOpen,
  lftCorrespondentQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftCorrespondentName
 with AddUsertype(lftSynchroViewName,
  str_lftSynchroViewCaption,
  str_lftSynchroViewSettingsCaption,
  False,
  -1,
  -1,
  '',
  lftSynchroViewQueryMaximized,
  lftSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSynchroViewName
 with AddUsertype(lftCToPartName,
  str_lftCToPartCaption,
  str_lftCToPartSettingsCaption,
  False,
  -1,
  60,
  lftRespondentName,
  lftCToPartQueryMaximized,
  lftCToPartQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftCToPartName
 with AddUsertype(lftUserCR1Name,
  str_lftUserCR1Caption,
  str_lftUserCR1SettingsCaption,
  False,
  -1,
  80,
  '',
  lftUserCR1QueryMaximized,
  lftUserCR1QueryOpen,
  lftUserCR1QueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCR1Name
 with AddUsertype(lftUserCR2Name,
  str_lftUserCR2Caption,
  str_lftUserCR2SettingsCaption,
  False,
  -1,
  100,
  lftUserCR1Name,
  lftUserCR2QueryMaximized,
  lftUserCR2QueryOpen,
  lftUserCR2QueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCR2Name
 with AddUsertype(lftConsultationName,
  str_lftConsultationCaption,
  str_lftConsultationSettingsCaption,
  False,
  64,
  -1,
  '',
  lftConsultationQueryMaximized,
  lftConsultationQueryOpen,
  lftConsultationQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftConsultationName
 with AddUsertype(lftSimilarDocumentsName,
  str_lftSimilarDocumentsCaption,
  str_lftSimilarDocumentsSettingsCaption,
  False,
  166,
  120,
  '',
  lftSimilarDocumentsQueryMaximized,
  lftSimilarDocumentsQueryOpen,
  lftSimilarDocumentsQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSimilarDocumentsName
 with AddUsertype(lftSimilarDocumentsSynchroViewName,
  str_lftSimilarDocumentsSynchroViewCaption,
  str_lftSimilarDocumentsSynchroViewSettingsCaption,
  False,
  -1,
  -1,
  '',
  lftSimilarDocumentsSynchroViewQueryMaximized,
  lftSimilarDocumentsSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSimilarDocumentsSynchroViewName
 with AddUsertype(lftCorrespondentsSynchroFormName,
  str_lftCorrespondentsSynchroFormCaption,
  str_lftCorrespondentsSynchroFormSettingsCaption,
  False,
  18,
  -1,
  '',
  lftCorrespondentsSynchroFormQueryMaximized,
  lftCorrespondentsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftCorrespondentsSynchroFormName
 with AddUsertype(lftRespondentsSynchroFormName,
  str_lftRespondentsSynchroFormCaption,
  str_lftRespondentsSynchroFormSettingsCaption,
  False,
  17,
  -1,
  '',
  lftRespondentsSynchroFormQueryMaximized,
  lftRespondentsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftRespondentsSynchroFormName
 with AddUsertype(lftUserCRList1_SynchorFormName,
  str_lftUserCRList1_SynchorFormCaption,
  str_lftUserCRList1_SynchorFormSettingsCaption,
  False,
  -1,
  -1,
  '',
  lftUserCRList1_SynchorFormQueryMaximized,
  lftUserCRList1_SynchorFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCRList1_SynchorFormName
 with AddUsertype(lftUserCRList2_SynchorFormName,
  str_lftUserCRList2_SynchorFormCaption,
  str_lftUserCRList2_SynchorFormSettingsCaption,
  False,
  -1,
  -1,
  '',
  lftUserCRList2_SynchorFormQueryMaximized,
  lftUserCRList2_SynchorFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftUserCRList2_SynchorFormName
 with AddUsertype(lftDrugListName,
  str_lftDrugListCaption,
  str_lftDrugListCaption,
  False,
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
  False,
  181,
  -1,
  '',
  lftDrugInternationalNameSynonymsQueryMaximized,
  lftDrugInternationalNameSynonymsQueryOpen,
  lftDrugInternationalNameSynonymsQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftDrugInternationalNameSynonymsName
 with AddUsertype(lftProducedDrugsName,
  str_lftProducedDrugsCaption,
  str_lftProducedDrugsCaption,
  False,
  183,
  -1,
  '',
  lftProducedDrugsQueryMaximized,
  lftProducedDrugsQueryOpen,
  lftProducedDrugsQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftProducedDrugsName
 with AddUsertype(lftProducedDrugsSynchroFormName,
  str_lftProducedDrugsSynchroFormCaption,
  str_lftProducedDrugsSynchroFormSettingsCaption,
  False,
  -1,
  -1,
  '',
  lftProducedDrugsSynchroFormQueryMaximized,
  lftProducedDrugsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftProducedDrugsSynchroFormName
 with AddUsertype(lftDrugInternationalNameSynonymsSynchroFormName,
  str_lftDrugInternationalNameSynonymsSynchroFormCaption,
  str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption,
  False,
  -1,
  -1,
  '',
  lftDrugInternationalNameSynonymsSynchroFormQueryMaximized,
  lftDrugInternationalNameSynonymsSynchroFormQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftDrugInternationalNameSynonymsSynchroFormName
 with AddUsertype(lftRToPartName,
  str_lftRToPartCaption,
  str_lftRToPartSettingsCaption,
  False,
  -1,
  61,
  lftRespondentName,
  lftRToPartQueryMaximized,
  lftRToPartQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftRToPartName
 with AddUsertype(lftSimilarDocumentsToFragmentName,
  str_lftSimilarDocumentsToFragmentCaption,
  str_lftSimilarDocumentsToFragmentSettingsCaption,
  False,
  166,
  25,
  lftSimilarDocumentsName,
  lftSimilarDocumentsToFragmentQueryMaximized,
  lftSimilarDocumentsToFragmentQueryOpen,
  lftSimilarDocumentsToFragmentQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSimilarDocumentsToFragmentName
end;//_ListUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else ListUserTypes_imp_impl}

 str_lftNoneCaption.Init;
 {* ������������� str_lftNoneCaption }
 str_lftRespondentCaption.Init;
 {* ������������� str_lftRespondentCaption }
 str_lftRespondentSettingsCaption.Init;
 {* ������������� str_lftRespondentSettingsCaption }
 str_lftCorrespondentCaption.Init;
 {* ������������� str_lftCorrespondentCaption }
 str_lftCorrespondentSettingsCaption.Init;
 {* ������������� str_lftCorrespondentSettingsCaption }
 str_lftSynchroViewCaption.Init;
 {* ������������� str_lftSynchroViewCaption }
 str_lftSynchroViewSettingsCaption.Init;
 {* ������������� str_lftSynchroViewSettingsCaption }
 str_lftCToPartCaption.Init;
 {* ������������� str_lftCToPartCaption }
 str_lftCToPartSettingsCaption.Init;
 {* ������������� str_lftCToPartSettingsCaption }
 str_lftUserCR1Caption.Init;
 {* ������������� str_lftUserCR1Caption }
 str_lftUserCR1SettingsCaption.Init;
 {* ������������� str_lftUserCR1SettingsCaption }
 str_lftUserCR2Caption.Init;
 {* ������������� str_lftUserCR2Caption }
 str_lftUserCR2SettingsCaption.Init;
 {* ������������� str_lftUserCR2SettingsCaption }
 str_lftConsultationCaption.Init;
 {* ������������� str_lftConsultationCaption }
 str_lftConsultationSettingsCaption.Init;
 {* ������������� str_lftConsultationSettingsCaption }
 str_lftSimilarDocumentsCaption.Init;
 {* ������������� str_lftSimilarDocumentsCaption }
 str_lftSimilarDocumentsSettingsCaption.Init;
 {* ������������� str_lftSimilarDocumentsSettingsCaption }
 str_lftSimilarDocumentsSynchroViewCaption.Init;
 {* ������������� str_lftSimilarDocumentsSynchroViewCaption }
 str_lftSimilarDocumentsSynchroViewSettingsCaption.Init;
 {* ������������� str_lftSimilarDocumentsSynchroViewSettingsCaption }
 str_lftCorrespondentsSynchroFormCaption.Init;
 {* ������������� str_lftCorrespondentsSynchroFormCaption }
 str_lftCorrespondentsSynchroFormSettingsCaption.Init;
 {* ������������� str_lftCorrespondentsSynchroFormSettingsCaption }
 str_lftRespondentsSynchroFormCaption.Init;
 {* ������������� str_lftRespondentsSynchroFormCaption }
 str_lftRespondentsSynchroFormSettingsCaption.Init;
 {* ������������� str_lftRespondentsSynchroFormSettingsCaption }
 str_lftUserCRList1_SynchorFormCaption.Init;
 {* ������������� str_lftUserCRList1_SynchorFormCaption }
 str_lftUserCRList1_SynchorFormSettingsCaption.Init;
 {* ������������� str_lftUserCRList1_SynchorFormSettingsCaption }
 str_lftUserCRList2_SynchorFormCaption.Init;
 {* ������������� str_lftUserCRList2_SynchorFormCaption }
 str_lftUserCRList2_SynchorFormSettingsCaption.Init;
 {* ������������� str_lftUserCRList2_SynchorFormSettingsCaption }
 str_lftDrugListCaption.Init;
 {* ������������� str_lftDrugListCaption }
 str_lftDrugInternationalNameSynonymsCaption.Init;
 {* ������������� str_lftDrugInternationalNameSynonymsCaption }
 str_lftProducedDrugsCaption.Init;
 {* ������������� str_lftProducedDrugsCaption }
 str_lftProducedDrugsSynchroFormCaption.Init;
 {* ������������� str_lftProducedDrugsSynchroFormCaption }
 str_lftProducedDrugsSynchroFormSettingsCaption.Init;
 {* ������������� str_lftProducedDrugsSynchroFormSettingsCaption }
 str_lftDrugInternationalNameSynonymsSynchroFormCaption.Init;
 {* ������������� str_lftDrugInternationalNameSynonymsSynchroFormCaption }
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption.Init;
 {* ������������� str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption }
 str_lftRToPartCaption.Init;
 {* ������������� str_lftRToPartCaption }
 str_lftRToPartSettingsCaption.Init;
 {* ������������� str_lftRToPartSettingsCaption }
 str_lftSimilarDocumentsToFragmentCaption.Init;
 {* ������������� str_lftSimilarDocumentsToFragmentCaption }
 str_lftSimilarDocumentsToFragmentSettingsCaption.Init;
 {* ������������� str_lftSimilarDocumentsToFragmentSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ListUserTypes_imp_impl}

{$EndIf ListUserTypes_imp}

