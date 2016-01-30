{$IfNDef RedactionsUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\RedactionsUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define RedactionsUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _RedactionsUserTypes_ = {abstract} class(_RedactionsUserTypes_Parent_)
  protected
   procedure utRedactionQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события utRedaction.OnQueryClose }
 end;//_RedactionsUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_RedactionsUserTypes_ = _RedactionsUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else RedactionsUserTypes_imp}

{$IfNDef RedactionsUserTypes_imp_impl}

{$Define RedactionsUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки utRedactionLocalConstants }
 str_utRedactionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionCaption'; rValue : 'Редакции');
  {* Заголовок пользовательского типа "Редакции" }
 str_utRedactionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionSettingsCaption'; rValue : 'Документ: Редакции (вкладка)');
  {* Заголовок пользовательского типа "Редакции" для настройки панелей инструментов }

{$Else RedactionsUserTypes_imp_impl}

 str_utRedactionCaption.Init;
 {* Инициализация str_utRedactionCaption }
 str_utRedactionSettingsCaption.Init;
 {* Инициализация str_utRedactionSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf RedactionsUserTypes_imp_impl}

{$EndIf RedactionsUserTypes_imp}

