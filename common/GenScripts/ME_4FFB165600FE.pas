{$IfNDef ListInfoUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define ListInfoUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListInfoUserTypes_ = {abstract} class(_ListInfoUserTypes_Parent_)
  protected
   procedure liListInfoQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события liListInfo.OnQueryClose }
 end;//_ListInfoUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ListInfoUserTypes_ = _ListInfoUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ListInfoUserTypes_imp}

{$IfNDef ListInfoUserTypes_imp_impl}

{$Define ListInfoUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки liListInfoLocalConstants }
 str_liListInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoCaption'; rValue : 'Справка к списку');
  {* Заголовок пользовательского типа "Справка к списку" }
 str_liListInfoSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoSettingsCaption'; rValue : 'Список: Справка к списку');
  {* Заголовок пользовательского типа "Справка к списку" для настройки панелей инструментов }

{$Else ListInfoUserTypes_imp_impl}

 str_liListInfoCaption.Init;
 {* Инициализация str_liListInfoCaption }
 str_liListInfoSettingsCaption.Init;
 {* Инициализация str_liListInfoSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ListInfoUserTypes_imp_impl}

{$EndIf ListInfoUserTypes_imp}

