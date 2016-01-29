{$IfNDef PrimSaveLoadUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define PrimSaveLoadUserTypes_imp}
{$If not defined(Admin)}
 _PrimSaveLoadUserTypes_ = {abstract form} class(_PrimSaveLoadUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_PrimSaveLoadUserTypes_
{$Else}

 _PrimSaveLoadUserTypes_ = _PrimSaveLoadUserTypes_Parent_;

{$IfEnd} //not Admin

{$Else PrimSaveLoadUserTypes_imp}

{$IfNDef PrimSaveLoadUserTypes_imp_impl}
{$Define PrimSaveLoadUserTypes_imp_impl}

{$If not defined(Admin)}

var
   { Локализуемые строки slqtAttributeLocalConstants }
  str_slqtAttributeCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtAttributeCaption'; rValue : 'Поиск: По реквизитам');
   { Заголовок пользовательского типа "Поиск: По реквизитам" }

var
   { Локализуемые строки slqtKWLocalConstants }
  str_slqtKWCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtKWCaption'; rValue : 'Поиск: По ситуации');
   { Заголовок пользовательского типа "Поиск: По ситуации" }

var
   { Локализуемые строки slqtOldKWLocalConstants }
  str_slqtOldKWCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWCaption'; rValue : 'Поиск: По ситуации');
   { Заголовок пользовательского типа "Поиск: По ситуации" }
  str_slqtOldKWSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWSettingsCaption'; rValue : 'Поиск: По ситуации (Преемственный)');
   { Заголовок пользовательского типа "Поиск: По ситуации" для настройки панелей инструментов }

var
   { Локализуемые строки slqtPublishSourceLocalConstants }
  str_slqtPublishSourceCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPublishSourceCaption'; rValue : 'Поиск: По источнику опубликования');
   { Заголовок пользовательского типа "Поиск: По источнику опубликования" }

var
   { Локализуемые строки slqtFiltersLocalConstants }
  str_slqtFiltersCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtFiltersCaption'; rValue : 'Карточка Фильтров');
   { Заголовок пользовательского типа "Карточка Фильтров" }

var
   { Локализуемые строки slqtLegislationReviewLocalConstants }
  str_slqtLegislationReviewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtLegislationReviewCaption'; rValue : 'Поиск: ПРАЙМ. Обзор изменений законодательства');
   { Заголовок пользовательского типа "Поиск: ПРАЙМ. Обзор изменений законодательства" }

var
   { Локализуемые строки slqtPostingOrderLocalConstants }
  str_slqtPostingOrderCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPostingOrderCaption'; rValue : 'Настройка индивидуальной ленты новостей');
   { Заголовок пользовательского типа "Настройка индивидуальной ленты новостей" }

var
   { Локализуемые строки slqtConsultLocalConstants }
  str_slqtConsultCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtConsultCaption'; rValue : 'Правовая поддержка онлайн');
   { Заголовок пользовательского типа "Правовая поддержка онлайн" }

var
   { Локализуемые строки slqtInpharmSearchLocalConstants }
  str_slqtInpharmSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtInpharmSearchCaption'; rValue : 'Поиск лекарственных средств');
   { Заголовок пользовательского типа "Поиск лекарственных средств" }

// start class _PrimSaveLoadUserTypes_

procedure _PrimSaveLoadUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(slqtAttributeName,
  str_slqtAttributeCaption,
  str_slqtAttributeCaption,
  true,
  28,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtAttributeName
 with AddUsertype(slqtKWName,
  str_slqtKWCaption,
  str_slqtKWCaption,
  true,
  29,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtKWName
 with AddUsertype(slqtOldKWName,
  str_slqtOldKWCaption,
  str_slqtOldKWSettingsCaption,
  true,
  29,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtOldKWName
 with AddUsertype(slqtPublishSourceName,
  str_slqtPublishSourceCaption,
  str_slqtPublishSourceCaption,
  true,
  30,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtPublishSourceName
 with AddUsertype(slqtFiltersName,
  str_slqtFiltersCaption,
  str_slqtFiltersCaption,
  false,
  40,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtFiltersName
 with AddUsertype(slqtLegislationReviewName,
  str_slqtLegislationReviewCaption,
  str_slqtLegislationReviewCaption,
  true,
  144,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtLegislationReviewName
 with AddUsertype(slqtPostingOrderName,
  str_slqtPostingOrderCaption,
  str_slqtPostingOrderCaption,
  false,
  156,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtPostingOrderName
 with AddUsertype(slqtConsultName,
  str_slqtConsultCaption,
  str_slqtConsultCaption,
  false,
  154,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtConsultName
 with AddUsertype(slqtInpharmSearchName,
  str_slqtInpharmSearchCaption,
  str_slqtInpharmSearchCaption,
  true,
  179,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtInpharmSearchName
end;

{$IfEnd} //not Admin

{$Else  PrimSaveLoadUserTypes_imp_impl}
{$If not defined(Admin)}
// Инициализация str_slqtAttributeCaption
 str_slqtAttributeCaption.Init;
// Инициализация str_slqtKWCaption
 str_slqtKWCaption.Init;
// Инициализация str_slqtOldKWCaption
 str_slqtOldKWCaption.Init;
// Инициализация str_slqtOldKWSettingsCaption
 str_slqtOldKWSettingsCaption.Init;
// Инициализация str_slqtPublishSourceCaption
 str_slqtPublishSourceCaption.Init;
// Инициализация str_slqtFiltersCaption
 str_slqtFiltersCaption.Init;
// Инициализация str_slqtLegislationReviewCaption
 str_slqtLegislationReviewCaption.Init;
// Инициализация str_slqtPostingOrderCaption
 str_slqtPostingOrderCaption.Init;
// Инициализация str_slqtConsultCaption
 str_slqtConsultCaption.Init;
// Инициализация str_slqtInpharmSearchCaption
 str_slqtInpharmSearchCaption.Init;
{$IfEnd} //not Admin

{$EndIf PrimSaveLoadUserTypes_imp_impl}
{$EndIf PrimSaveLoadUserTypes_imp}
