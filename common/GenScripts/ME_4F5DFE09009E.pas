{$IfNDef PrimSaveLoadUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define PrimSaveLoadUserTypes_imp}

{$If NOT Defined(Admin)}
 _PrimSaveLoadUserTypes_ = {abstract} class(_PrimSaveLoadUserTypes_Parent_)
 end;//_PrimSaveLoadUserTypes_

{$Else NOT Defined(Admin)}

_PrimSaveLoadUserTypes_ = _PrimSaveLoadUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin)
{$Else PrimSaveLoadUserTypes_imp}

{$IfNDef PrimSaveLoadUserTypes_imp_impl}

{$Define PrimSaveLoadUserTypes_imp_impl}

{$If NOT Defined(Admin)}
const
 {* Локализуемые строки slqtAttributeLocalConstants }
 str_slqtAttributeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtAttributeCaption'; rValue : 'Поиск: По реквизитам');
  {* Заголовок пользовательского типа "Поиск: По реквизитам" }
 {* Локализуемые строки slqtKWLocalConstants }
 str_slqtKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtKWCaption'; rValue : 'Поиск: По ситуации');
  {* Заголовок пользовательского типа "Поиск: По ситуации" }
 {* Локализуемые строки slqtOldKWLocalConstants }
 str_slqtOldKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWCaption'; rValue : 'Поиск: По ситуации');
  {* Заголовок пользовательского типа "Поиск: По ситуации" }
 str_slqtOldKWSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWSettingsCaption'; rValue : 'Поиск: По ситуации (Преемственный)');
  {* Заголовок пользовательского типа "Поиск: По ситуации" для настройки панелей инструментов }
 {* Локализуемые строки slqtPublishSourceLocalConstants }
 str_slqtPublishSourceCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPublishSourceCaption'; rValue : 'Поиск: По источнику опубликования');
  {* Заголовок пользовательского типа "Поиск: По источнику опубликования" }
 {* Локализуемые строки slqtFiltersLocalConstants }
 str_slqtFiltersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtFiltersCaption'; rValue : 'Карточка Фильтров');
  {* Заголовок пользовательского типа "Карточка Фильтров" }
 {* Локализуемые строки slqtLegislationReviewLocalConstants }
 str_slqtLegislationReviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtLegislationReviewCaption'; rValue : 'Поиск: ПРАЙМ. Обзор изменений законодательства');
  {* Заголовок пользовательского типа "Поиск: ПРАЙМ. Обзор изменений законодательства" }
 {* Локализуемые строки slqtPostingOrderLocalConstants }
 str_slqtPostingOrderCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPostingOrderCaption'; rValue : 'Настройка индивидуальной ленты новостей');
  {* Заголовок пользовательского типа "Настройка индивидуальной ленты новостей" }
 {* Локализуемые строки slqtConsultLocalConstants }
 str_slqtConsultCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtConsultCaption'; rValue : 'Правовая поддержка онлайн');
  {* Заголовок пользовательского типа "Правовая поддержка онлайн" }
 {* Локализуемые строки slqtInpharmSearchLocalConstants }
 str_slqtInpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtInpharmSearchCaption'; rValue : 'Поиск лекарственных средств');
  {* Заголовок пользовательского типа "Поиск лекарственных средств" }

{$Else PrimSaveLoadUserTypes_imp_impl}

 str_slqtAttributeCaption.Init;
 {* Инициализация str_slqtAttributeCaption }
 str_slqtKWCaption.Init;
 {* Инициализация str_slqtKWCaption }
 str_slqtOldKWCaption.Init;
 {* Инициализация str_slqtOldKWCaption }
 str_slqtOldKWSettingsCaption.Init;
 {* Инициализация str_slqtOldKWSettingsCaption }
 str_slqtPublishSourceCaption.Init;
 {* Инициализация str_slqtPublishSourceCaption }
 str_slqtFiltersCaption.Init;
 {* Инициализация str_slqtFiltersCaption }
 str_slqtLegislationReviewCaption.Init;
 {* Инициализация str_slqtLegislationReviewCaption }
 str_slqtPostingOrderCaption.Init;
 {* Инициализация str_slqtPostingOrderCaption }
 str_slqtConsultCaption.Init;
 {* Инициализация str_slqtConsultCaption }
 str_slqtInpharmSearchCaption.Init;
 {* Инициализация str_slqtInpharmSearchCaption }
{$IfEnd} // NOT Defined(Admin)

{$EndIf PrimSaveLoadUserTypes_imp_impl}

{$EndIf PrimSaveLoadUserTypes_imp}

