{$IfNDef ListUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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
 end;//_ListUserTypes_
{$Else}

 _ListUserTypes_ = _ListUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else ListUserTypes_imp}

{$IfNDef ListUserTypes_imp_impl}
{$Define ListUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки lftNoneLocalConstants }
  str_lftNoneCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftNoneCaption'; rValue : 'Список');
   { Заголовок пользовательского типа "Список" }

var
   { Локализуемые строки lftRespondentLocalConstants }
  str_lftRespondentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentCaption'; rValue : 'Ссылки из документа');
   { Заголовок пользовательского типа "Ссылки из документа" }
  str_lftRespondentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentSettingsCaption'; rValue : 'Список: Ссылки из документа (все)/Ссылки на документ (все)');
   { Заголовок пользовательского типа "Ссылки из документа" для настройки панелей инструментов }

var
   { Локализуемые строки lftCorrespondentLocalConstants }
  str_lftCorrespondentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentCaption'; rValue : 'Ссылки на документ');
   { Заголовок пользовательского типа "Ссылки на документ" }
  str_lftCorrespondentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentSettingsCaption'; rValue : 'Список: Ссылки на документ');
   { Заголовок пользовательского типа "Ссылки на документ" для настройки панелей инструментов }

var
   { Локализуемые строки lftSynchroViewLocalConstants }
  str_lftSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewCaption'; rValue : 'Синхронный просмотр (ссылки из документа, ссылки на документ)');
   { Заголовок пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" }
  str_lftSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок из документа/на документ');
   { Заголовок пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" для настройки панелей инструментов }

var
   { Локализуемые строки lftCToPartLocalConstants }
  str_lftCToPartCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartCaption'; rValue : 'Ссылки на фрагмент');
   { Заголовок пользовательского типа "Ссылки на фрагмент" }
  str_lftCToPartSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartSettingsCaption'; rValue : 'Список: Ссылки на фрагмент');
   { Заголовок пользовательского типа "Ссылки на фрагмент" для настройки панелей инструментов }

var
   { Локализуемые строки lftUserCR1LocalConstants }
  str_lftUserCR1Caption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1Caption'; rValue : 'Настраиваемая вкладка связанных документов 1');
   { Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 1" }
  str_lftUserCR1SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1SettingsCaption'; rValue : 'Список: Ссылки из документа (вид информации)/Ссылки на документ (вид информации)');
   { Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 1" для настройки панелей инструментов }

var
   { Локализуемые строки lftUserCR2LocalConstants }
  str_lftUserCR2Caption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2Caption'; rValue : 'Настраиваемая вкладка связанных документов 2');
   { Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 2" }
  str_lftUserCR2SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR2SettingsCaption'; rValue : 'Список: Пользовательская вкладка ссылки на документ (ссылки из документа) 2');
   { Заголовок пользовательского типа "Настраиваемая вкладка связанных документов 2" для настройки панелей инструментов }

var
   { Локализуемые строки lftConsultationLocalConstants }
  str_lftConsultationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationCaption'; rValue : 'Консультация');
   { Заголовок пользовательского типа "Консультация" }
  str_lftConsultationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftConsultationSettingsCaption'; rValue : 'Список: Консультация');
   { Заголовок пользовательского типа "Консультация" для настройки панелей инструментов }

var
   { Локализуемые строки lftSimilarDocumentsLocalConstants }
  str_lftSimilarDocumentsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsCaption'; rValue : 'Похожие документы');
   { Заголовок пользовательского типа "Похожие документы" }
  str_lftSimilarDocumentsSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSettingsCaption'; rValue : 'Список: Похожие документы');
   { Заголовок пользовательского типа "Похожие документы" для настройки панелей инструментов }

var
   { Локализуемые строки lftSimilarDocumentsSynchroViewLocalConstants }
  str_lftSimilarDocumentsSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewCaption'; rValue : 'Синхронный просмотр (похожие документы)');
   { Заголовок пользовательского типа "Синхронный просмотр (похожие документы)" }
  str_lftSimilarDocumentsSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Похожие документы');
   { Заголовок пользовательского типа "Синхронный просмотр (похожие документы)" для настройки панелей инструментов }

var
   { Локализуемые строки lftCorrespondentsSynchroFormLocalConstants }
  str_lftCorrespondentsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormCaption'; rValue : 'Синхронный просмотр (ссылки на документ)');
   { Заголовок пользовательского типа "Синхронный просмотр (ссылки на документ)" }
  str_lftCorrespondentsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок на документ');
   { Заголовок пользовательского типа "Синхронный просмотр (ссылки на документ)" для настройки панелей инструментов }

var
   { Локализуемые строки lftRespondentsSynchroFormLocalConstants }
  str_lftRespondentsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormCaption'; rValue : 'Синхронный просмотр (ссылка из документа)');
   { Заголовок пользовательского типа "Синхронный просмотр (ссылка из документа)" }
  str_lftRespondentsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Списки ссылок из документа');
   { Заголовок пользовательского типа "Синхронный просмотр (ссылка из документа)" для настройки панелей инструментов }

var
   { Локализуемые строки lftUserCRList1_SynchorFormLocalConstants }
  str_lftUserCRList1_SynchorFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormCaption'; rValue : 'Синхронный просмотр (настраиваемая вкладка связанных документов 1)');
   { Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" }
  str_lftUserCRList1_SynchorFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList1_SynchorFormSettingsCaption'; rValue : 'Синхронный просмотр: Первая пользовательская вкладка списка ссылкок на документ\из документа');
   { Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" для настройки панелей инструментов }

var
   { Локализуемые строки lftUserCRList2_SynchorFormLocalConstants }
  str_lftUserCRList2_SynchorFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormCaption'; rValue : 'Синхронный просмотр (настраиваемая вкладка связанных документов 2)');
   { Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 2)" }
  str_lftUserCRList2_SynchorFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormSettingsCaption'; rValue : 'Синхронный просмотр: Вторая пользовательская вкладка списка ссылкок на документ\из документа');
   { Заголовок пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 2)" для настройки панелей инструментов }

var
   { Локализуемые строки lftDrugListLocalConstants }
  str_lftDrugListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugListCaption'; rValue : 'Список препаратов');
   { Заголовок пользовательского типа "Список препаратов" }

var
   { Локализуемые строки lftDrugInternationalNameSynonymsLocalConstants }
  str_lftDrugInternationalNameSynonymsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsCaption'; rValue : 'Синонимы по международному названию');
   { Заголовок пользовательского типа "Синонимы по международному названию" }

var
   { Локализуемые строки lftProducedDrugsLocalConstants }
  str_lftProducedDrugsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsCaption'; rValue : 'Выпускаемые препараты');
   { Заголовок пользовательского типа "Выпускаемые препараты" }

var
   { Локализуемые строки lftProducedDrugsSynchroFormLocalConstants }
  str_lftProducedDrugsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormCaption'; rValue : 'Синхронный просмотр (выпускаемые препараты)');
   { Заголовок пользовательского типа "Синхронный просмотр (выпускаемые препараты)" }
  str_lftProducedDrugsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftProducedDrugsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Выпускаемые препараты');
   { Заголовок пользовательского типа "Синхронный просмотр (выпускаемые препараты)" для настройки панелей инструментов }

var
   { Локализуемые строки lftDrugInternationalNameSynonymsSynchroFormLocalConstants }
  str_lftDrugInternationalNameSynonymsSynchroFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormCaption'; rValue : 'Синхронный просмотр (синонимы по международному названию)');
   { Заголовок пользовательского типа "Синхронный просмотр (синонимы по международному названию)" }
  str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormSettingsCaption'; rValue : 'Синхронный просмотр: Синонимы по международному названию');
   { Заголовок пользовательского типа "Синхронный просмотр (синонимы по международному названию)" для настройки панелей инструментов }

var
   { Локализуемые строки lftRToPartLocalConstants }
  str_lftRToPartCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartCaption'; rValue : 'Ссылки из фрагмента');
   { Заголовок пользовательского типа "Ссылки из фрагмента" }
  str_lftRToPartSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRToPartSettingsCaption'; rValue : 'Список: Ссылки из фрагмента');
   { Заголовок пользовательского типа "Ссылки из фрагмента" для настройки панелей инструментов }

var
   { Локализуемые строки lftSimilarDocumentsToFragmentLocalConstants }
  str_lftSimilarDocumentsToFragmentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentCaption'; rValue : 'Похожие к фрагменту');
   { Заголовок пользовательского типа "Похожие к фрагменту" }
  str_lftSimilarDocumentsToFragmentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsToFragmentSettingsCaption'; rValue : 'Список: Похожие к фрагменту');
   { Заголовок пользовательского типа "Похожие к фрагменту" для настройки панелей инструментов }

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
// Инициализация str_lftNoneCaption
 str_lftNoneCaption.Init;
// Инициализация str_lftRespondentCaption
 str_lftRespondentCaption.Init;
// Инициализация str_lftRespondentSettingsCaption
 str_lftRespondentSettingsCaption.Init;
// Инициализация str_lftCorrespondentCaption
 str_lftCorrespondentCaption.Init;
// Инициализация str_lftCorrespondentSettingsCaption
 str_lftCorrespondentSettingsCaption.Init;
// Инициализация str_lftSynchroViewCaption
 str_lftSynchroViewCaption.Init;
// Инициализация str_lftSynchroViewSettingsCaption
 str_lftSynchroViewSettingsCaption.Init;
// Инициализация str_lftCToPartCaption
 str_lftCToPartCaption.Init;
// Инициализация str_lftCToPartSettingsCaption
 str_lftCToPartSettingsCaption.Init;
// Инициализация str_lftUserCR1Caption
 str_lftUserCR1Caption.Init;
// Инициализация str_lftUserCR1SettingsCaption
 str_lftUserCR1SettingsCaption.Init;
// Инициализация str_lftUserCR2Caption
 str_lftUserCR2Caption.Init;
// Инициализация str_lftUserCR2SettingsCaption
 str_lftUserCR2SettingsCaption.Init;
// Инициализация str_lftConsultationCaption
 str_lftConsultationCaption.Init;
// Инициализация str_lftConsultationSettingsCaption
 str_lftConsultationSettingsCaption.Init;
// Инициализация str_lftSimilarDocumentsCaption
 str_lftSimilarDocumentsCaption.Init;
// Инициализация str_lftSimilarDocumentsSettingsCaption
 str_lftSimilarDocumentsSettingsCaption.Init;
// Инициализация str_lftSimilarDocumentsSynchroViewCaption
 str_lftSimilarDocumentsSynchroViewCaption.Init;
// Инициализация str_lftSimilarDocumentsSynchroViewSettingsCaption
 str_lftSimilarDocumentsSynchroViewSettingsCaption.Init;
// Инициализация str_lftCorrespondentsSynchroFormCaption
 str_lftCorrespondentsSynchroFormCaption.Init;
// Инициализация str_lftCorrespondentsSynchroFormSettingsCaption
 str_lftCorrespondentsSynchroFormSettingsCaption.Init;
// Инициализация str_lftRespondentsSynchroFormCaption
 str_lftRespondentsSynchroFormCaption.Init;
// Инициализация str_lftRespondentsSynchroFormSettingsCaption
 str_lftRespondentsSynchroFormSettingsCaption.Init;
// Инициализация str_lftUserCRList1_SynchorFormCaption
 str_lftUserCRList1_SynchorFormCaption.Init;
// Инициализация str_lftUserCRList1_SynchorFormSettingsCaption
 str_lftUserCRList1_SynchorFormSettingsCaption.Init;
// Инициализация str_lftUserCRList2_SynchorFormCaption
 str_lftUserCRList2_SynchorFormCaption.Init;
// Инициализация str_lftUserCRList2_SynchorFormSettingsCaption
 str_lftUserCRList2_SynchorFormSettingsCaption.Init;
// Инициализация str_lftDrugListCaption
 str_lftDrugListCaption.Init;
// Инициализация str_lftDrugInternationalNameSynonymsCaption
 str_lftDrugInternationalNameSynonymsCaption.Init;
// Инициализация str_lftProducedDrugsCaption
 str_lftProducedDrugsCaption.Init;
// Инициализация str_lftProducedDrugsSynchroFormCaption
 str_lftProducedDrugsSynchroFormCaption.Init;
// Инициализация str_lftProducedDrugsSynchroFormSettingsCaption
 str_lftProducedDrugsSynchroFormSettingsCaption.Init;
// Инициализация str_lftDrugInternationalNameSynonymsSynchroFormCaption
 str_lftDrugInternationalNameSynonymsSynchroFormCaption.Init;
// Инициализация str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption.Init;
// Инициализация str_lftRToPartCaption
 str_lftRToPartCaption.Init;
// Инициализация str_lftRToPartSettingsCaption
 str_lftRToPartSettingsCaption.Init;
// Инициализация str_lftSimilarDocumentsToFragmentCaption
 str_lftSimilarDocumentsToFragmentCaption.Init;
// Инициализация str_lftSimilarDocumentsToFragmentSettingsCaption
 str_lftSimilarDocumentsToFragmentSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf ListUserTypes_imp_impl}
{$EndIf ListUserTypes_imp}
