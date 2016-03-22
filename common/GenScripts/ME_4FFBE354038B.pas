{$IfNDef DocumentWithFlashUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "DocumentWithFlashUserTypes" MUID: (4FFBE354038B)
// Имя типа: "_DocumentWithFlashUserTypes_"

{$Define DocumentWithFlashUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _DocumentWithFlashUserTypes_ = {abstract} class(_DocumentWithFlashUserTypes_Parent_)
 end;//_DocumentWithFlashUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_DocumentWithFlashUserTypes_ = _DocumentWithFlashUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else DocumentWithFlashUserTypes_imp}

{$IfNDef DocumentWithFlashUserTypes_imp_impl}

{$Define DocumentWithFlashUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки dwftMainLocalConstants }
 str_dwftMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftMainCaption'; rValue : 'Схема');
  {* Заголовок пользовательского типа "Схема" }
 {* Локализуемые строки dwftSynchroLocalConstants }
 str_dwftSynchroCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroCaption'; rValue : 'Схема (синхронный просмотр)');
  {* Заголовок пользовательского типа "Схема (синхронный просмотр)" }
 str_dwftSynchroSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroSettingsCaption'; rValue : 'Синхронный просмотр: Схема');
  {* Заголовок пользовательского типа "Схема (синхронный просмотр)" для настройки панелей инструментов }

{$Else DocumentWithFlashUserTypes_imp_impl}

 str_dwftMainCaption.Init;
 {* Инициализация str_dwftMainCaption }
 str_dwftSynchroCaption.Init;
 {* Инициализация str_dwftSynchroCaption }
 str_dwftSynchroSettingsCaption.Init;
 {* Инициализация str_dwftSynchroSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf DocumentWithFlashUserTypes_imp_impl}

{$EndIf DocumentWithFlashUserTypes_imp}

