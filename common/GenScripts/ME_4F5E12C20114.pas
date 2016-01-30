{$IfNDef BaloonWarningUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define BaloonWarningUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaloonWarningUserTypes_ = {abstract} class(_BaloonWarningUserTypes_Parent_)
 end;//_BaloonWarningUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaloonWarningUserTypes_ = _BaloonWarningUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaloonWarningUserTypes_imp}

{$IfNDef BaloonWarningUserTypes_imp_impl}

{$Define BaloonWarningUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки FakeLocalConstants }
 str_FakeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FakeCaption'; rValue : 'Предупреждение');
  {* Заголовок пользовательского типа "Предупреждение" }
 {* Локализуемые строки WarnJurorLocalConstants }
 str_WarnJurorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnJurorCaption'; rValue : 'Юридическое предупреждение');
  {* Заголовок пользовательского типа "Юридическое предупреждение" }
 {* Локализуемые строки WarnPreActiveLocalConstants }
 str_WarnPreActiveCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnPreActiveCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки WarnIsAbolishedLocalConstants }
 str_WarnIsAbolishedCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnIsAbolishedCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки WarnOnControlLocalConstants }
 str_WarnOnControlCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnOnControlCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки WarnInactualDocumentLocalConstants }
 str_WarnInactualDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnInactualDocumentCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки WarnTimeMachineOnLocalConstants }
 str_WarnTimeMachineOnCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineOnCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки WarnRedactionLocalConstants }
 str_WarnRedactionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnRedactionCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки WarnTimeMachineWarningLocalConstants }
 str_WarnTimeMachineWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки WarnTimeMachineExceptionLocalConstants }
 str_WarnTimeMachineExceptionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineExceptionCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки remListModifiedLocalConstants }
 str_remListModifiedCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListModifiedCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки remListFilteredLocalConstants }
 str_remListFilteredCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListFilteredCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки remTimeMachineWarningLocalConstants }
 str_remTimeMachineWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remTimeMachineWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки remUnreadConsultationsLocalConstants }
 str_remUnreadConsultationsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remUnreadConsultationsCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки remOnlineDeadLocalConstants }
 str_remOnlineDeadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remOnlineDeadCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки TrialModeWarningLocalConstants }
 str_TrialModeWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки OldBaseWarningLocalConstants }
 str_OldBaseWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldBaseWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки ControlledChangingWarningLocalConstants }
 str_ControlledChangingWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }

{$Else BaloonWarningUserTypes_imp_impl}

 str_FakeCaption.Init;
 {* Инициализация str_FakeCaption }
 str_WarnJurorCaption.Init;
 {* Инициализация str_WarnJurorCaption }
 str_WarnPreActiveCaption.Init;
 {* Инициализация str_WarnPreActiveCaption }
 str_WarnIsAbolishedCaption.Init;
 {* Инициализация str_WarnIsAbolishedCaption }
 str_WarnOnControlCaption.Init;
 {* Инициализация str_WarnOnControlCaption }
 str_WarnInactualDocumentCaption.Init;
 {* Инициализация str_WarnInactualDocumentCaption }
 str_WarnTimeMachineOnCaption.Init;
 {* Инициализация str_WarnTimeMachineOnCaption }
 str_WarnRedactionCaption.Init;
 {* Инициализация str_WarnRedactionCaption }
 str_WarnTimeMachineWarningCaption.Init;
 {* Инициализация str_WarnTimeMachineWarningCaption }
 str_WarnTimeMachineExceptionCaption.Init;
 {* Инициализация str_WarnTimeMachineExceptionCaption }
 str_remListModifiedCaption.Init;
 {* Инициализация str_remListModifiedCaption }
 str_remListFilteredCaption.Init;
 {* Инициализация str_remListFilteredCaption }
 str_remTimeMachineWarningCaption.Init;
 {* Инициализация str_remTimeMachineWarningCaption }
 str_remUnreadConsultationsCaption.Init;
 {* Инициализация str_remUnreadConsultationsCaption }
 str_remOnlineDeadCaption.Init;
 {* Инициализация str_remOnlineDeadCaption }
 str_TrialModeWarningCaption.Init;
 {* Инициализация str_TrialModeWarningCaption }
 str_OldBaseWarningCaption.Init;
 {* Инициализация str_OldBaseWarningCaption }
 str_ControlledChangingWarningCaption.Init;
 {* Инициализация str_ControlledChangingWarningCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf BaloonWarningUserTypes_imp_impl}

{$EndIf BaloonWarningUserTypes_imp}

