{$IfNDef DocumentUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes
//
// Пользовательские типы документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define DocumentUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _DocumentUserTypes_ = {abstract form} class(_DocumentUserTypes_Parent_)
  {* Пользовательские типы документа }
 protected
  procedure MakeControls; override;
 protected
 // protected methods
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
 end;//_DocumentUserTypes_
{$Else}

 _DocumentUserTypes_ = _DocumentUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else DocumentUserTypes_imp}

{$IfNDef DocumentUserTypes_imp_impl}
{$Define DocumentUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки dftNoneLocalConstants }
  str_dftNoneCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftNoneCaption'; rValue : 'Документ');
   { Заголовок пользовательского типа "Документ" }

var
   { Локализуемые строки dftDocumentLocalConstants }
  str_dftDocumentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocumentCaption'; rValue : 'Текст');
   { Заголовок пользовательского типа "Текст" }
  str_dftDocumentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocumentSettingsCaption'; rValue : 'Документ: Текст документа');
   { Заголовок пользовательского типа "Текст" для настройки панелей инструментов }

var
   { Локализуемые строки dftRelatedDocLocalConstants }
  str_dftRelatedDocCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocCaption'; rValue : 'Справка');
   { Заголовок пользовательского типа "Справка" }
  str_dftRelatedDocSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocSettingsCaption'; rValue : 'Документ: Справка к документу');
   { Заголовок пользовательского типа "Справка" для настройки панелей инструментов }

var
   { Локализуемые строки dftDocSynchroViewLocalConstants }
  str_dftDocSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewCaption'; rValue : 'Текст документа (синхронный просмотр)');
   { Заголовок пользовательского типа "Текст документа (синхронный просмотр)" }
  str_dftDocSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Текст документа');
   { Заголовок пользовательского типа "Текст документа (синхронный просмотр)" для настройки панелей инструментов }

var
   { Локализуемые строки dftRelatedSynchroViewLocalConstants }
  str_dftRelatedSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewCaption'; rValue : 'Справка к документу (синхронный просмотр)');
   { Заголовок пользовательского типа "Справка к документу (синхронный просмотр)" }
  str_dftRelatedSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Справка к документу');
   { Заголовок пользовательского типа "Справка к документу (синхронный просмотр)" для настройки панелей инструментов }

var
   { Локализуемые строки dftDictEntryLocalConstants }
  str_dftDictEntryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictEntryCaption'; rValue : 'Текст словарной статьи');
   { Заголовок пользовательского типа "Текст словарной статьи" }
  str_dftDictEntrySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictEntrySettingsCaption'; rValue : 'Толковый словарь: Текст словарной статьи');
   { Заголовок пользовательского типа "Текст словарной статьи" для настройки панелей инструментов }

var
   { Локализуемые строки dftDictSubEntryLocalConstants }
  str_dftDictSubEntryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntryCaption'; rValue : 'Перевод словарной статьи');
   { Заголовок пользовательского типа "Перевод словарной статьи" }
  str_dftDictSubEntrySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntrySettingsCaption'; rValue : 'Толковый словарь: Перевод словарной статьи');
   { Заголовок пользовательского типа "Перевод словарной статьи" для настройки панелей инструментов }

var
   { Локализуемые строки dftAnnotationLocalConstants }
  str_dftAnnotationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationCaption'; rValue : 'Аннотация');
   { Заголовок пользовательского типа "Аннотация" }
  str_dftAnnotationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSettingsCaption'; rValue : 'Документ: Дополнительная информация');
   { Заголовок пользовательского типа "Аннотация" для настройки панелей инструментов }

var
   { Локализуемые строки dftAutoreferatAfterSearchLocalConstants }
  str_dftAutoreferatAfterSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchCaption'; rValue : 'ПРАЙМ. Обзор изменений законодательства');
   { Заголовок пользовательского типа "ПРАЙМ. Обзор изменений законодательства" }
  str_dftAutoreferatAfterSearchSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchSettingsCaption'; rValue : 'Документ: ПРАЙМ. Обзор изменений законодательства');
   { Заголовок пользовательского типа "ПРАЙМ. Обзор изменений законодательства" для настройки панелей инструментов }

var
   { Локализуемые строки dftConsultationLocalConstants }
  str_dftConsultationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationCaption'; rValue : 'Консультация');
   { Заголовок пользовательского типа "Консультация" }
  str_dftConsultationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationSettingsCaption'; rValue : 'Документ: Консультация');
   { Заголовок пользовательского типа "Консультация" для настройки панелей инструментов }

var
   { Локализуемые строки dftTranslationLocalConstants }
  str_dftTranslationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationCaption'; rValue : 'Перевод');
   { Заголовок пользовательского типа "Перевод" }
  str_dftTranslationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationSettingsCaption'; rValue : 'Документ: Перевод');
   { Заголовок пользовательского типа "Перевод" для настройки панелей инструментов }

var
   { Локализуемые строки dftAnnotationSynchroViewLocalConstants }
  str_dftAnnotationSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSynchroViewCaption'; rValue : 'Аннотация (синхронный просмотр)');
   { Заголовок пользовательского типа "Аннотация (синхронный просмотр)" }
  str_dftAnnotationSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Дополнительная информация');
   { Заголовок пользовательского типа "Аннотация (синхронный просмотр)" для настройки панелей инструментов }

var
   { Локализуемые строки dftTipsLocalConstants }
  str_dftTipsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsCaption'; rValue : 'Совет дня');
   { Заголовок пользовательского типа "Совет дня" }
  str_dftTipsSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsSettingsCaption'; rValue : 'Совет дня: Текст совета');
   { Заголовок пользовательского типа "Совет дня" для настройки панелей инструментов }

var
   { Локализуемые строки dftMedDictEntryLocalConstants }
  str_dftMedDictEntryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntryCaption'; rValue : 'Описание медицинского термина');
   { Заголовок пользовательского типа "Описание медицинского термина" }
  str_dftMedDictEntrySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntrySettingsCaption'; rValue : 'Словарь медицинских терминов: Описание медицинского термина');
   { Заголовок пользовательского типа "Описание медицинского термина" для настройки панелей инструментов }

var
   { Локализуемые строки dftAutoreferatLocalConstants }
  str_dftAutoreferatCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatCaption'; rValue : 'ПРАЙМ. Моя новостная лента');
   { Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" }
  str_dftAutoreferatSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatSettingsCaption'; rValue : 'Документ: ПРАЙМ. Моя новостная лента');
   { Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" для настройки панелей инструментов }

var
   { Локализуемые строки dftDrugLocalConstants }
  str_dftDrugCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugCaption'; rValue : 'Описание препарата');
   { Заголовок пользовательского типа "Описание препарата" }

var
   { Локализуемые строки dftMedicFirmLocalConstants }
  str_dftMedicFirmCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmCaption'; rValue : 'Описание фирмы');
   { Заголовок пользовательского типа "Описание фирмы" }

var
   { Локализуемые строки dftMedicFirmSynchroViewLocalConstants }
  str_dftMedicFirmSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewCaption'; rValue : 'Описание фирмы (синхронный просмотр)');
   { Заголовок пользовательского типа "Описание фирмы (синхронный просмотр)" }
  str_dftMedicFirmSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Описание фирмы');
   { Заголовок пользовательского типа "Описание фирмы (синхронный просмотр)" для настройки панелей инструментов }

var
   { Локализуемые строки dftDrugSynchroViewLocalConstants }
  str_dftDrugSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewCaption'; rValue : 'Описание препарата (синхронный просмотр)');
   { Заголовок пользовательского типа "Описание препарата (синхронный просмотр)" }
  str_dftDrugSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Описание препарата');
   { Заголовок пользовательского типа "Описание препарата (синхронный просмотр)" для настройки панелей инструментов }

var
   { Локализуемые строки dftAACLeftLocalConstants }
  str_dftAACLeftCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftCaption'; rValue : 'Левая часть Энциклопедии решений');
   { Заголовок пользовательского типа "Левая часть Энциклопедии решений" }
  str_dftAACLeftSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftSettingsCaption'; rValue : 'Левая часть Энциклопедии решений');
   { Заголовок пользовательского типа "Левая часть Энциклопедии решений" для настройки панелей инструментов }

var
   { Локализуемые строки dftAACRightLocalConstants }
  str_dftAACRightCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightCaption'; rValue : 'Правая часть Энциклопедии решений');
   { Заголовок пользовательского типа "Правая часть Энциклопедии решений" }
  str_dftAACRightSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightSettingsCaption'; rValue : 'Правая часть Энциклопедии решений');
   { Заголовок пользовательского типа "Правая часть Энциклопедии решений" для настройки панелей инструментов }

var
   { Локализуемые строки dftAACContentsLeftLocalConstants }
  str_dftAACContentsLeftCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsLeftCaption'; rValue : 'Левая часть оглавления Энциклопедии решений');
   { Заголовок пользовательского типа "Левая часть оглавления Энциклопедии решений" }

var
   { Локализуемые строки dftAACContentsRightLocalConstants }
  str_dftAACContentsRightCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsRightCaption'; rValue : 'Правая часть оглавления Энциклопедии решений');
   { Заголовок пользовательского типа "Правая часть оглавления Энциклопедии решений" }

var
   { Локализуемые строки dftChronologyLocalConstants }
  str_dftChronologyCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologyCaption'; rValue : 'Хронология судебного дела');
   { Заголовок пользовательского типа "Хронология судебного дела" }
  str_dftChronologySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologySettingsCaption'; rValue : 'Документ: Хронология судебного дела');
   { Заголовок пользовательского типа "Хронология судебного дела" для настройки панелей инструментов }

// start class _DocumentUserTypes_

procedure _DocumentUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(dftNoneName,
  str_dftNoneCaption,
  str_dftNoneCaption,
  false,
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
  true,
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
  false,
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
  true,
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
  false,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  true,
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
  false,
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
  false,
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
  false,
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
  true,
  211,
  130,
  dftRelatedDocName,
  nil,
  nil,
  DftChronologyQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftChronologyName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  DocumentUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_dftNoneCaption
 str_dftNoneCaption.Init;
// Инициализация str_dftDocumentCaption
 str_dftDocumentCaption.Init;
// Инициализация str_dftDocumentSettingsCaption
 str_dftDocumentSettingsCaption.Init;
// Инициализация str_dftRelatedDocCaption
 str_dftRelatedDocCaption.Init;
// Инициализация str_dftRelatedDocSettingsCaption
 str_dftRelatedDocSettingsCaption.Init;
// Инициализация str_dftDocSynchroViewCaption
 str_dftDocSynchroViewCaption.Init;
// Инициализация str_dftDocSynchroViewSettingsCaption
 str_dftDocSynchroViewSettingsCaption.Init;
// Инициализация str_dftRelatedSynchroViewCaption
 str_dftRelatedSynchroViewCaption.Init;
// Инициализация str_dftRelatedSynchroViewSettingsCaption
 str_dftRelatedSynchroViewSettingsCaption.Init;
// Инициализация str_dftDictEntryCaption
 str_dftDictEntryCaption.Init;
// Инициализация str_dftDictEntrySettingsCaption
 str_dftDictEntrySettingsCaption.Init;
// Инициализация str_dftDictSubEntryCaption
 str_dftDictSubEntryCaption.Init;
// Инициализация str_dftDictSubEntrySettingsCaption
 str_dftDictSubEntrySettingsCaption.Init;
// Инициализация str_dftAnnotationCaption
 str_dftAnnotationCaption.Init;
// Инициализация str_dftAnnotationSettingsCaption
 str_dftAnnotationSettingsCaption.Init;
// Инициализация str_dftAutoreferatAfterSearchCaption
 str_dftAutoreferatAfterSearchCaption.Init;
// Инициализация str_dftAutoreferatAfterSearchSettingsCaption
 str_dftAutoreferatAfterSearchSettingsCaption.Init;
// Инициализация str_dftConsultationCaption
 str_dftConsultationCaption.Init;
// Инициализация str_dftConsultationSettingsCaption
 str_dftConsultationSettingsCaption.Init;
// Инициализация str_dftTranslationCaption
 str_dftTranslationCaption.Init;
// Инициализация str_dftTranslationSettingsCaption
 str_dftTranslationSettingsCaption.Init;
// Инициализация str_dftAnnotationSynchroViewCaption
 str_dftAnnotationSynchroViewCaption.Init;
// Инициализация str_dftAnnotationSynchroViewSettingsCaption
 str_dftAnnotationSynchroViewSettingsCaption.Init;
// Инициализация str_dftTipsCaption
 str_dftTipsCaption.Init;
// Инициализация str_dftTipsSettingsCaption
 str_dftTipsSettingsCaption.Init;
// Инициализация str_dftMedDictEntryCaption
 str_dftMedDictEntryCaption.Init;
// Инициализация str_dftMedDictEntrySettingsCaption
 str_dftMedDictEntrySettingsCaption.Init;
// Инициализация str_dftAutoreferatCaption
 str_dftAutoreferatCaption.Init;
// Инициализация str_dftAutoreferatSettingsCaption
 str_dftAutoreferatSettingsCaption.Init;
// Инициализация str_dftDrugCaption
 str_dftDrugCaption.Init;
// Инициализация str_dftMedicFirmCaption
 str_dftMedicFirmCaption.Init;
// Инициализация str_dftMedicFirmSynchroViewCaption
 str_dftMedicFirmSynchroViewCaption.Init;
// Инициализация str_dftMedicFirmSynchroViewSettingsCaption
 str_dftMedicFirmSynchroViewSettingsCaption.Init;
// Инициализация str_dftDrugSynchroViewCaption
 str_dftDrugSynchroViewCaption.Init;
// Инициализация str_dftDrugSynchroViewSettingsCaption
 str_dftDrugSynchroViewSettingsCaption.Init;
// Инициализация str_dftAACLeftCaption
 str_dftAACLeftCaption.Init;
// Инициализация str_dftAACLeftSettingsCaption
 str_dftAACLeftSettingsCaption.Init;
// Инициализация str_dftAACRightCaption
 str_dftAACRightCaption.Init;
// Инициализация str_dftAACRightSettingsCaption
 str_dftAACRightSettingsCaption.Init;
// Инициализация str_dftAACContentsLeftCaption
 str_dftAACContentsLeftCaption.Init;
// Инициализация str_dftAACContentsRightCaption
 str_dftAACContentsRightCaption.Init;
// Инициализация str_dftChronologyCaption
 str_dftChronologyCaption.Init;
// Инициализация str_dftChronologySettingsCaption
 str_dftChronologySettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf DocumentUserTypes_imp_impl}
{$EndIf DocumentUserTypes_imp}
