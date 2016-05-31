{$IfNDef DocumentUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "DocumentUserTypes" MUID: (4BD1E3DE02FB)
// Имя типа: "_DocumentUserTypes_"

{$Define DocumentUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _DocumentUserTypes_ = {abstract} class(_DocumentUserTypes_Parent_)
  {* Пользовательские типы документа }
  protected
   procedure DftRelatedDocQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события dftRelatedDoc.OnQueryClose }
   procedure DftDocSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события dftDocSynchroView.OnQueryMaximized }
   procedure DftDocSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события dftDocSynchroView.OnQueryOpen }
   procedure DftDictSubEntryQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события dftDictSubEntry.OnQueryClose }
   procedure DftAnnotationQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события dftAnnotation.OnQueryClose }
   procedure DftTranslationQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события dftTranslation.OnQueryMaximized }
   procedure DftTranslationQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события dftTranslation.OnQueryOpen }
   procedure DftTranslationQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события dftTranslation.OnQueryClose }
   procedure DftMedicFirmSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события dftMedicFirmSynchroView.OnQueryMaximized }
   procedure DftMedicFirmSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события dftMedicFirmSynchroView.OnQueryOpen }
   procedure DftDrugSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события dftDrugSynchroView.OnQueryMaximized }
   procedure DftDrugSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события dftDrugSynchroView.OnQueryOpen }
   procedure DftChronologyQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события dftChronology.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_DocumentUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_DocumentUserTypes_ = _DocumentUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else DocumentUserTypes_imp}

{$IfNDef DocumentUserTypes_imp_impl}

{$Define DocumentUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _DocumentUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(dftNoneName,
  str_dftNoneCaption,
  str_dftNoneCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftNoneName
 with AddUsertype(dftDocumentName,
  str_dftDocumentCaption,
  str_dftDocumentSettingsCaption,
  True,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDocumentName
 with AddUsertype(dftRelatedDocName,
  str_dftRelatedDocCaption,
  str_dftRelatedDocSettingsCaption,
  False,
  20,
  30,
  dftAnnotationName,
  nil,
  nil,
  DftRelatedDocQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftRelatedDocName
 with AddUsertype(dftDocSynchroViewName,
  str_dftDocSynchroViewCaption,
  str_dftDocSynchroViewSettingsCaption,
  True,
  30,
  -1,
  '',
  DftDocSynchroViewQueryMaximized,
  DftDocSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDocSynchroViewName
 with AddUsertype(dftRelatedSynchroViewName,
  str_dftRelatedSynchroViewCaption,
  str_dftRelatedSynchroViewSettingsCaption,
  False,
  30,
  -1,
  dftAnnotationSynchroViewName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftRelatedSynchroViewName
 with AddUsertype(dftDictEntryName,
  str_dftDictEntryCaption,
  str_dftDictEntrySettingsCaption,
  True,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDictEntryName
 with AddUsertype(dftDictSubEntryName,
  str_dftDictSubEntryCaption,
  str_dftDictSubEntrySettingsCaption,
  True,
  21,
  -1,
  '',
  nil,
  nil,
  DftDictSubEntryQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDictSubEntryName
 with AddUsertype(dftAnnotationName,
  str_dftAnnotationCaption,
  str_dftAnnotationSettingsCaption,
  True,
  143,
  35,
  '',
  nil,
  nil,
  DftAnnotationQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAnnotationName
 with AddUsertype(dftAutoreferatAfterSearchName,
  str_dftAutoreferatAfterSearchCaption,
  str_dftAutoreferatAfterSearchSettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAutoreferatAfterSearchName
 with AddUsertype(dftConsultationName,
  str_dftConsultationCaption,
  str_dftConsultationSettingsCaption,
  True,
  155,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftConsultationName
 with AddUsertype(dftTranslationName,
  str_dftTranslationCaption,
  str_dftTranslationSettingsCaption,
  True,
  167,
  110,
  '',
  DftTranslationQueryMaximized,
  DftTranslationQueryOpen,
  DftTranslationQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftTranslationName
 with AddUsertype(dftAnnotationSynchroViewName,
  str_dftAnnotationSynchroViewCaption,
  str_dftAnnotationSynchroViewSettingsCaption,
  True,
  143,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAnnotationSynchroViewName
 with AddUsertype(dftTipsName,
  str_dftTipsCaption,
  str_dftTipsSettingsCaption,
  True,
  175,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftTipsName
 with AddUsertype(dftMedDictEntryName,
  str_dftMedDictEntryCaption,
  str_dftMedDictEntrySettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftMedDictEntryName
 with AddUsertype(dftAutoreferatName,
  str_dftAutoreferatCaption,
  str_dftAutoreferatSettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAutoreferatName
 with AddUsertype(dftDrugName,
  str_dftDrugCaption,
  str_dftDrugCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDrugName
 with AddUsertype(dftMedicFirmName,
  str_dftMedicFirmCaption,
  str_dftMedicFirmCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftMedicFirmName
 with AddUsertype(dftMedicFirmSynchroViewName,
  str_dftMedicFirmSynchroViewCaption,
  str_dftMedicFirmSynchroViewSettingsCaption,
  True,
  -1,
  -1,
  '',
  DftMedicFirmSynchroViewQueryMaximized,
  DftMedicFirmSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftMedicFirmSynchroViewName
 with AddUsertype(dftDrugSynchroViewName,
  str_dftDrugSynchroViewCaption,
  str_dftDrugSynchroViewSettingsCaption,
  True,
  -1,
  -1,
  '',
  DftDrugSynchroViewQueryMaximized,
  DftDrugSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDrugSynchroViewName
 with AddUsertype(dftAACLeftName,
  str_dftAACLeftCaption,
  str_dftAACLeftSettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAACLeftName
 with AddUsertype(dftAACRightName,
  str_dftAACRightCaption,
  str_dftAACRightSettingsCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
  CanHaveToolbars := false;
 end;//with AddUsertype(dftAACRightName
 with AddUsertype(dftAACContentsLeftName,
  str_dftAACContentsLeftCaption,
  str_dftAACContentsLeftCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
  CanHaveToolbars := false;
 end;//with AddUsertype(dftAACContentsLeftName
 with AddUsertype(dftAACContentsRightName,
  str_dftAACContentsRightCaption,
  str_dftAACContentsRightCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
  CanHaveToolbars := false;
 end;//with AddUsertype(dftAACContentsRightName
 with AddUsertype(dftChronologyName,
  str_dftChronologyCaption,
  str_dftChronologySettingsCaption,
  True,
  211,
  130,
  dftRelatedDocName,
  nil,
  nil,
  DftChronologyQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftChronologyName
end;//_DocumentUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf DocumentUserTypes_imp_impl}

{$EndIf DocumentUserTypes_imp}

