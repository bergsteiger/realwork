{$IfNDef WarningUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define WarningUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _WarningUserTypes_ = {abstract} class(_WarningUserTypes_Parent_)
  protected
   procedure WarningQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события Warning.OnQueryClose }
 end;//_WarningUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_WarningUserTypes_ = _WarningUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else WarningUserTypes_imp}

{$IfNDef WarningUserTypes_imp_impl}

{$Define WarningUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки WarningLocalConstants }
 str_WarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningCaption'; rValue : 'Предупреждение');
  {* Заголовок пользовательского типа "Предупреждение" }
 str_WarningSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningSettingsCaption'; rValue : 'Документ: Предупреждение');
  {* Заголовок пользовательского типа "Предупреждение" для настройки панелей инструментов }

{$Else WarningUserTypes_imp_impl}

 str_WarningCaption.Init;
 {* Инициализация str_WarningCaption }
 str_WarningSettingsCaption.Init;
 {* Инициализация str_WarningSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf WarningUserTypes_imp_impl}

{$EndIf WarningUserTypes_imp}

