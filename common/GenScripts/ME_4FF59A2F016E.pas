{$IfNDef ListUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define ListUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListUserTypes_ = {abstract} class(_ListUserTypes_Parent_)
  protected
   procedure lftRespondentQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondent.OnQueryMaximized }
   procedure lftRespondentQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondent.OnQueryOpen }
   procedure lftRespondentQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondent.OnQueryClose }
   procedure lftCorrespondentQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondent.OnQueryMaximized }
   procedure lftCorrespondentQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondent.OnQueryOpen }
   procedure lftCorrespondentQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondent.OnQueryClose }
   procedure lftSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSynchroView.OnQueryMaximized }
   procedure lftSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSynchroView.OnQueryOpen }
   procedure lftCToPartQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCToPart.OnQueryMaximized }
   procedure lftCToPartQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCToPart.OnQueryOpen }
   procedure lftUserCR1QueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR1.OnQueryMaximized }
   procedure lftUserCR1QueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR1.OnQueryOpen }
   procedure lftUserCR1QueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR1.OnQueryClose }
   procedure lftUserCR2QueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR2.OnQueryMaximized }
   procedure lftUserCR2QueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR2.OnQueryOpen }
   procedure lftUserCR2QueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCR2.OnQueryClose }
   procedure lftConsultationQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftConsultation.OnQueryMaximized }
   procedure lftConsultationQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftConsultation.OnQueryOpen }
   procedure lftConsultationQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftConsultation.OnQueryClose }
   procedure lftSimilarDocumentsQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocuments.OnQueryMaximized }
   procedure lftSimilarDocumentsQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocuments.OnQueryOpen }
   procedure lftSimilarDocumentsQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocuments.OnQueryClose }
   procedure lftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryMaximized }
   procedure lftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryOpen }
   procedure lftCorrespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondentsSynchroForm.OnQueryMaximized }
   procedure lftCorrespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftCorrespondentsSynchroForm.OnQueryOpen }
   procedure lftRespondentsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondentsSynchroForm.OnQueryMaximized }
   procedure lftRespondentsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRespondentsSynchroForm.OnQueryOpen }
   procedure lftUserCRList1_SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList1_SynchorForm.OnQueryMaximized }
   procedure lftUserCRList1_SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList1_SynchorForm.OnQueryOpen }
   procedure lftUserCRList2_SynchorFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList2_SynchorForm.OnQueryMaximized }
   procedure lftUserCRList2_SynchorFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftUserCRList2_SynchorForm.OnQueryOpen }
   procedure lftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryMaximized }
   procedure lftDrugInternationalNameSynonymsQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryOpen }
   procedure lftDrugInternationalNameSynonymsQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryClose }
   procedure lftProducedDrugsQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugs.OnQueryMaximized }
   procedure lftProducedDrugsQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugs.OnQueryOpen }
   procedure lftProducedDrugsQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugs.OnQueryClose }
   procedure lftProducedDrugsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugsSynchroForm.OnQueryMaximized }
   procedure lftProducedDrugsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftProducedDrugsSynchroForm.OnQueryOpen }
   procedure lftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryMaximized }
   procedure lftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryOpen }
   procedure lftRToPartQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRToPart.OnQueryMaximized }
   procedure lftRToPartQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftRToPart.OnQueryOpen }
   procedure lftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryMaximized }
   procedure lftSimilarDocumentsToFragmentQueryOpen(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryOpen }
   procedure lftSimilarDocumentsToFragmentQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryClose }
 end;//_ListUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ListUserTypes_ = _ListUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ListUserTypes_imp}

{$IfNDef ListUserTypes_imp_impl}

{$Define ListUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки lftNoneLocalConstants }
 str_lftNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftNoneCaption'; rValue : 'Список');
  {* Заголовок пользовательского типа "Список" }
 {* Локализуемые строки lftRespondentLocalConstants }
 str_lftRespondentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentCaption'; rValue : 'Ссылки из документа');
  {* Заголовок пользовательского типа "Ссылки из документа" }
 str_lftRespondentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentSettingsCaption'; rValue : 'Список: Ссылки из документа (все)/Ссылки на документ (все)');
  {* Заголовок пользовательского типа "Ссылки из документа" для настройки панелей инструментов }
 {* Локализуемые строки lftCorrespondentLocalConstants }
 str_lftCorrespondentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentCaption'; rValue : 'Ссылки на документ');
  {* Заголовок пользовательского типа "Ссылки на документ" }
 str_lftCorrespondentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentSettingsCaption'; rValue : 'Список: Ссылки на документ');
  {* Заголовок пользовательского типа "Ссылки на документ" для настройки панелей инструментов }
 {* Локализуемые строки lftSynchroViewLocalConstants }
 str_lftSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewCaption'; rValue : 'Синхронный просмотр (ссылки из документа, ссылки на документ)');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" }
 str_lftSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок из документа/на документ');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" для настройки панелей инструментов }
 {* Локализуемые строки lftCToPartLocalConstants }
 str_lftCToPartCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartCaption'; rValue : 'Ссылки на фрагмент');
  {* Заголовок пользовательского типа "Ссылки на фрагмент" }
 str_lftCToPartSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartSettingsCaption'; rValue : 'Список: Ссылки на фрагмент');
  {* Заголовок пользовательского типа "Ссылки на фрагмент" для настройки панелей инструментов }
 {* Локализуемые строки lftUserCR1LocalConstants }
 str_lftUserCR1Caption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1Caption'; rValue : 'Настраиваемая вкладка связанных документов 1');
  {* Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 1" }
 str_lftUserCR1SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1SettingsCaption'; rValue : 'Список: Ссылки из документа (вид информации)/Ссылки на документ (вид информации)');
  {* Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 1" для настройки панелей инструментов }
 {* Локализуемые строки lftUserCR2LocalConstants }
 str_lftUserCR2Caption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2Caption'; rValue : 'Настраиваемая вкладка связанных документов 2');
  {* Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 2" }
 str_lftUserCR2SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2SettingsCaption'; rValue : 'Список: Пользовательская вкладка ссылки на документ (ссылки из документа) 2');
  {* Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 2" для настройки панелей инструментов }
 {* Локализуемые строки lftConsultationLocalConstants }
 str_lftConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationCaption'; rValue : 'Консультация');
  {* Заголовок пользовательского типа "Консультация" }
 str_lftConsultationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationSettingsCaption'; rValue : 'Список: Консультация');
  {* Заголовок пользовательского типа "Консультация" для настройки панелей инструментов }
 {* Локализуемые строки lftSimilarDocumentsLocalConstants }
 str_lftSimilarDocumentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsCaption'; rValue : 'Похожие документы');
  {* Заголовок пользовательского типа "Похожие документы" }
 str_lftSimilarDocumentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSettingsCaption'; rValue : 'Список: Похожие документы');
  {* Заголовок пользовательского типа "Похожие документы" для настройки панелей инструментов }
 {* Локализуемые строки lftSimilarDocumentsSynchroViewLocalConstants }
 str_lftSimilarDocumentsSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewCaption'; rValue : 'Синхронный просмотр (похожие документы)');
  {* Заголовок пользовательского типа "Синхронный просмотр (похожие документы)" }
 str_lftSimilarDocumentsSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Похожие документы');
  {* Заголовок пользовательского типа "Синхронный просмотр (похожие документы)" для настройки панелей инструментов }
 {* Локализуемые строки lftCorrespondentsSynchroFormLocalConstants }
 str_lftCorrespondentsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormCaption'; rValue : 'Синхронный просмотр (ссылки на документ)');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылки на документ)" }
 str_lftCorrespondentsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок на документ');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылки на документ)" для настройки панелей инструментов }
 {* Локализуемые строки lftRespondentsSynchroFormLocalConstants }
 str_lftRespondentsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormCaption'; rValue : 'Синхронный просмотр (ссылка из документа)');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылка из документа)" }
 str_lftRespondentsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок из документа');
  {* Заголовок пользовательского типа "Синхронный просмотр (ссылка из документа)" для настройки панелей инструментов }
 {* Локализуемые строки lftUserCRList1_SynchorFormLocalConstants }
 str_lftUserCRList1_SynchorFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormCaption'; rValue : 'Синхронный просмотр (настраиваемая вкладка связанных документов 1)');
  {* Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" }
 str_lftUserCRList1_SynchorFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormSettingsCaption'; rValue : 'Синхронный просмотр: Первая пользовательская вкладка списка ссылкок на документ\из документа');
  {* Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" для настройки панелей инструментов }
 {* Локализуемые строки lftUserCRList2_SynchorFormLocalConstants }
 str_lftUserCRList2_SynchorFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormCaption'; rValue : 'Синхронный просмотр (настраиваемая вкладка связанных документов 2)');
  {* Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 2)" }
 str_lftUserCRList2_SynchorFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormSettingsCaption'; rValue : 'Синхронный просмотр: Вторая пользовательская вкладка списка ссылкок на документ\из документа');
  {* Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 2)" для настройки панелей инструментов }
 {* Локализуемые строки lftDrugListLocalConstants }
 str_lftDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugListCaption'; rValue : 'Список препаратов');
  {* Заголовок пользовательского типа "Список препаратов" }
 {* Локализуемые строки lftDrugInternationalNameSynonymsLocalConstants }
 str_lftDrugInternationalNameSynonymsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsCaption'; rValue : 'Синонимы по международному названию');
  {* Заголовок пользовательского типа "Синонимы по международному названию" }
 {* Локализуемые строки lftProducedDrugsLocalConstants }
 str_lftProducedDrugsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsCaption'; rValue : 'Выпускаемые препараты');
  {* Заголовок пользовательского типа "Выпускаемые препараты" }
 {* Локализуемые строки lftProducedDrugsSynchroFormLocalConstants }
 str_lftProducedDrugsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormCaption'; rValue : 'Синхронный просмотр (выпускаемые препараты)');
  {* Заголовок пользовательского типа "Синхронный просмотр (выпускаемые препараты)" }
 str_lftProducedDrugsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Выпускаемые препараты');
  {* Заголовок пользовательского типа "Синхронный просмотр (выпускаемые препараты)" для настройки панелей инструментов }
 {* Локализуемые строки lftDrugInternationalNameSynonymsSynchroFormLocalConstants }
 str_lftDrugInternationalNameSynonymsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormCaption'; rValue : 'Синхронный просмотр (синонимы по международному названию)');
  {* Заголовок пользовательского типа "Синхронный просмотр (синонимы по международному названию)" }
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Синонимы по международному названию');
  {* Заголовок пользовательского типа "Синхронный просмотр (синонимы по международному названию)" для настройки панелей инструментов }
 {* Локализуемые строки lftRToPartLocalConstants }
 str_lftRToPartCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartCaption'; rValue : 'Ссылки из фрагмента');
  {* Заголовок пользовательского типа "Ссылки из фрагмента" }
 str_lftRToPartSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartSettingsCaption'; rValue : 'Список: Ссылки из фрагмента');
  {* Заголовок пользовательского типа "Ссылки из фрагмента" для настройки панелей инструментов }
 {* Локализуемые строки lftSimilarDocumentsToFragmentLocalConstants }
 str_lftSimilarDocumentsToFragmentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentCaption'; rValue : 'Похожие к фрагменту');
  {* Заголовок пользовательского типа "Похожие к фрагменту" }
 str_lftSimilarDocumentsToFragmentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentSettingsCaption'; rValue : 'Список: Похожие к фрагменту');
  {* Заголовок пользовательского типа "Похожие к фрагменту" для настройки панелей инструментов }

{$Else ListUserTypes_imp_impl}

 str_lftNoneCaption.Init;
 {* Инициализация str_lftNoneCaption }
 str_lftRespondentCaption.Init;
 {* Инициализация str_lftRespondentCaption }
 str_lftRespondentSettingsCaption.Init;
 {* Инициализация str_lftRespondentSettingsCaption }
 str_lftCorrespondentCaption.Init;
 {* Инициализация str_lftCorrespondentCaption }
 str_lftCorrespondentSettingsCaption.Init;
 {* Инициализация str_lftCorrespondentSettingsCaption }
 str_lftSynchroViewCaption.Init;
 {* Инициализация str_lftSynchroViewCaption }
 str_lftSynchroViewSettingsCaption.Init;
 {* Инициализация str_lftSynchroViewSettingsCaption }
 str_lftCToPartCaption.Init;
 {* Инициализация str_lftCToPartCaption }
 str_lftCToPartSettingsCaption.Init;
 {* Инициализация str_lftCToPartSettingsCaption }
 str_lftUserCR1Caption.Init;
 {* Инициализация str_lftUserCR1Caption }
 str_lftUserCR1SettingsCaption.Init;
 {* Инициализация str_lftUserCR1SettingsCaption }
 str_lftUserCR2Caption.Init;
 {* Инициализация str_lftUserCR2Caption }
 str_lftUserCR2SettingsCaption.Init;
 {* Инициализация str_lftUserCR2SettingsCaption }
 str_lftConsultationCaption.Init;
 {* Инициализация str_lftConsultationCaption }
 str_lftConsultationSettingsCaption.Init;
 {* Инициализация str_lftConsultationSettingsCaption }
 str_lftSimilarDocumentsCaption.Init;
 {* Инициализация str_lftSimilarDocumentsCaption }
 str_lftSimilarDocumentsSettingsCaption.Init;
 {* Инициализация str_lftSimilarDocumentsSettingsCaption }
 str_lftSimilarDocumentsSynchroViewCaption.Init;
 {* Инициализация str_lftSimilarDocumentsSynchroViewCaption }
 str_lftSimilarDocumentsSynchroViewSettingsCaption.Init;
 {* Инициализация str_lftSimilarDocumentsSynchroViewSettingsCaption }
 str_lftCorrespondentsSynchroFormCaption.Init;
 {* Инициализация str_lftCorrespondentsSynchroFormCaption }
 str_lftCorrespondentsSynchroFormSettingsCaption.Init;
 {* Инициализация str_lftCorrespondentsSynchroFormSettingsCaption }
 str_lftRespondentsSynchroFormCaption.Init;
 {* Инициализация str_lftRespondentsSynchroFormCaption }
 str_lftRespondentsSynchroFormSettingsCaption.Init;
 {* Инициализация str_lftRespondentsSynchroFormSettingsCaption }
 str_lftUserCRList1_SynchorFormCaption.Init;
 {* Инициализация str_lftUserCRList1_SynchorFormCaption }
 str_lftUserCRList1_SynchorFormSettingsCaption.Init;
 {* Инициализация str_lftUserCRList1_SynchorFormSettingsCaption }
 str_lftUserCRList2_SynchorFormCaption.Init;
 {* Инициализация str_lftUserCRList2_SynchorFormCaption }
 str_lftUserCRList2_SynchorFormSettingsCaption.Init;
 {* Инициализация str_lftUserCRList2_SynchorFormSettingsCaption }
 str_lftDrugListCaption.Init;
 {* Инициализация str_lftDrugListCaption }
 str_lftDrugInternationalNameSynonymsCaption.Init;
 {* Инициализация str_lftDrugInternationalNameSynonymsCaption }
 str_lftProducedDrugsCaption.Init;
 {* Инициализация str_lftProducedDrugsCaption }
 str_lftProducedDrugsSynchroFormCaption.Init;
 {* Инициализация str_lftProducedDrugsSynchroFormCaption }
 str_lftProducedDrugsSynchroFormSettingsCaption.Init;
 {* Инициализация str_lftProducedDrugsSynchroFormSettingsCaption }
 str_lftDrugInternationalNameSynonymsSynchroFormCaption.Init;
 {* Инициализация str_lftDrugInternationalNameSynonymsSynchroFormCaption }
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption.Init;
 {* Инициализация str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption }
 str_lftRToPartCaption.Init;
 {* Инициализация str_lftRToPartCaption }
 str_lftRToPartSettingsCaption.Init;
 {* Инициализация str_lftRToPartSettingsCaption }
 str_lftSimilarDocumentsToFragmentCaption.Init;
 {* Инициализация str_lftSimilarDocumentsToFragmentCaption }
 str_lftSimilarDocumentsToFragmentSettingsCaption.Init;
 {* Инициализация str_lftSimilarDocumentsToFragmentSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ListUserTypes_imp_impl}

{$EndIf ListUserTypes_imp}

