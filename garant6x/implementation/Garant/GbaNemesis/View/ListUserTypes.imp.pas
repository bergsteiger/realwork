{$IfNDef ListUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "ListUserTypes" MUID: (4FF59A2F016E)
// Имя типа: "_ListUserTypes_"

{$Define ListUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListUserTypes_ = {abstract} class(_ListUserTypes_Parent_)
  protected
   procedure LftRespondentQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondent.OnQueryMaximized }
   procedure LftRespondentQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondent.OnQueryOpen }
   procedure LftRespondentQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondent.OnQueryClose }
   procedure LftCorrespondentQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondent.OnQueryMaximized }
   procedure LftCorrespondentQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondent.OnQueryOpen }
   procedure LftCorrespondentQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondent.OnQueryClose }
   procedure LftSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSynchroView.OnQueryMaximized }
   procedure LftSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSynchroView.OnQueryOpen }
   procedure LftCToPartQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCToPart.OnQueryMaximized }
   procedure LftCToPartQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCToPart.OnQueryOpen }
   procedure LftUserCR1QueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR1.OnQueryMaximized }
   procedure LftUserCR1QueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR1.OnQueryOpen }
   procedure LftUserCR1QueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR1.OnQueryClose }
   procedure LftUserCR2QueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR2.OnQueryMaximized }
   procedure LftUserCR2QueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR2.OnQueryOpen }
   procedure LftUserCR2QueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR2.OnQueryClose }
   procedure LftConsultationQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftConsultation.OnQueryMaximized }
   procedure LftConsultationQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftConsultation.OnQueryOpen }
   procedure LftConsultationQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftConsultation.OnQueryClose }
   procedure LftSimilarDocumentsQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocuments.OnQueryMaximized }
   procedure LftSimilarDocumentsQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocuments.OnQueryOpen }
   procedure LftSimilarDocumentsQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocuments.OnQueryClose }
   procedure LftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryMaximized }
   procedure LftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryOpen }
   procedure LftCorrespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondentsSynchroForm.OnQueryMaximized }
   procedure LftCorrespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondentsSynchroForm.OnQueryOpen }
   procedure LftRespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondentsSynchroForm.OnQueryMaximized }
   procedure LftRespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondentsSynchroForm.OnQueryOpen }
   procedure LftUserCRList1SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList1_SynchorForm.OnQueryMaximized }
   procedure LftUserCRList1SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList1_SynchorForm.OnQueryOpen }
   procedure LftUserCRList2SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList2_SynchorForm.OnQueryMaximized }
   procedure LftUserCRList2SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList2_SynchorForm.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryMaximized }
   procedure LftDrugInternationalNameSynonymsQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryClose }
   procedure LftProducedDrugsQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugs.OnQueryMaximized }
   procedure LftProducedDrugsQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugs.OnQueryOpen }
   procedure LftProducedDrugsQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugs.OnQueryClose }
   procedure LftProducedDrugsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugsSynchroForm.OnQueryMaximized }
   procedure LftProducedDrugsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugsSynchroForm.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryMaximized }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryOpen }
   procedure LftRToPartQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRToPart.OnQueryMaximized }
   procedure LftRToPartQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRToPart.OnQueryOpen }
   procedure LftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryMaximized }
   procedure LftSimilarDocumentsToFragmentQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryOpen }
   procedure LftSimilarDocumentsToFragmentQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryClose }
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
{$If NOT Defined(NoVCM)}
procedure _ListUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(lftNoneName,
  str_lftNoneCaption,
  str_lftNoneCaption,
  True,
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
  True,
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
  True,
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
  True,
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
  False,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  True,
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
  False,
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
  True,
  166,
  25,
  lftSimilarDocumentsName,
  LftSimilarDocumentsToFragmentQueryMaximized,
  LftSimilarDocumentsToFragmentQueryOpen,
  LftSimilarDocumentsToFragmentQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(lftSimilarDocumentsToFragmentName
end;//_ListUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf ListUserTypes_imp_impl}

{$EndIf ListUserTypes_imp}

