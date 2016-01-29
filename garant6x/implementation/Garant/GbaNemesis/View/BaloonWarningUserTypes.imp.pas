{$IfNDef BaloonWarningUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaloonWarningUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaloonWarningUserTypes_ = {abstract form} class(_BaloonWarningUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_BaloonWarningUserTypes_
{$Else}

 _BaloonWarningUserTypes_ = _BaloonWarningUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaloonWarningUserTypes_imp}

{$IfNDef BaloonWarningUserTypes_imp_impl}
{$Define BaloonWarningUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки FakeLocalConstants }
  str_FakeCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FakeCaption'; rValue : 'Предупреждение');
   { Заголовок пользовательского типа "Предупреждение" }

var
   { Локализуемые строки WarnJurorLocalConstants }
  str_WarnJurorCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnJurorCaption'; rValue : 'Юридическое предупреждение');
   { Заголовок пользовательского типа "Юридическое предупреждение" }

var
   { Локализуемые строки WarnPreActiveLocalConstants }
  str_WarnPreActiveCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnPreActiveCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки WarnIsAbolishedLocalConstants }
  str_WarnIsAbolishedCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnIsAbolishedCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки WarnOnControlLocalConstants }
  str_WarnOnControlCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnOnControlCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки WarnInactualDocumentLocalConstants }
  str_WarnInactualDocumentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnInactualDocumentCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки WarnTimeMachineOnLocalConstants }
  str_WarnTimeMachineOnCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineOnCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки WarnRedactionLocalConstants }
  str_WarnRedactionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnRedactionCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки WarnTimeMachineWarningLocalConstants }
  str_WarnTimeMachineWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineWarningCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки WarnTimeMachineExceptionLocalConstants }
  str_WarnTimeMachineExceptionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineExceptionCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки remListModifiedLocalConstants }
  str_remListModifiedCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListModifiedCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки remListFilteredLocalConstants }
  str_remListFilteredCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListFilteredCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки remTimeMachineWarningLocalConstants }
  str_remTimeMachineWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remTimeMachineWarningCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки remUnreadConsultationsLocalConstants }
  str_remUnreadConsultationsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remUnreadConsultationsCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки remOnlineDeadLocalConstants }
  str_remOnlineDeadCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remOnlineDeadCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки TrialModeWarningLocalConstants }
  str_TrialModeWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки OldBaseWarningLocalConstants }
  str_OldBaseWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldBaseWarningCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки ControlledChangingWarningLocalConstants }
  str_ControlledChangingWarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

// start class _BaloonWarningUserTypes_

procedure _BaloonWarningUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(FakeName,
  str_FakeCaption,
  str_FakeCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(FakeName
 with AddUsertype(WarnJurorName,
  str_WarnJurorCaption,
  str_WarnJurorCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnJurorName
 with AddUsertype(WarnPreActiveName,
  str_WarnPreActiveCaption,
  str_WarnPreActiveCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnPreActiveName
 with AddUsertype(WarnIsAbolishedName,
  str_WarnIsAbolishedCaption,
  str_WarnIsAbolishedCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnIsAbolishedName
 with AddUsertype(WarnOnControlName,
  str_WarnOnControlCaption,
  str_WarnOnControlCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnOnControlName
 with AddUsertype(WarnInactualDocumentName,
  str_WarnInactualDocumentCaption,
  str_WarnInactualDocumentCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnInactualDocumentName
 with AddUsertype(WarnTimeMachineOnName,
  str_WarnTimeMachineOnCaption,
  str_WarnTimeMachineOnCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnTimeMachineOnName
 with AddUsertype(WarnRedactionName,
  str_WarnRedactionCaption,
  str_WarnRedactionCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnRedactionName
 with AddUsertype(WarnTimeMachineWarningName,
  str_WarnTimeMachineWarningCaption,
  str_WarnTimeMachineWarningCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnTimeMachineWarningName
 with AddUsertype(WarnTimeMachineExceptionName,
  str_WarnTimeMachineExceptionCaption,
  str_WarnTimeMachineExceptionCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarnTimeMachineExceptionName
 with AddUsertype(remListModifiedName,
  str_remListModifiedCaption,
  str_remListModifiedCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remListModifiedName
 with AddUsertype(remListFilteredName,
  str_remListFilteredCaption,
  str_remListFilteredCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remListFilteredName
 with AddUsertype(remTimeMachineWarningName,
  str_remTimeMachineWarningCaption,
  str_remTimeMachineWarningCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remTimeMachineWarningName
 with AddUsertype(remUnreadConsultationsName,
  str_remUnreadConsultationsCaption,
  str_remUnreadConsultationsCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remUnreadConsultationsName
 with AddUsertype(remOnlineDeadName,
  str_remOnlineDeadCaption,
  str_remOnlineDeadCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(remOnlineDeadName
 with AddUsertype(TrialModeWarningName,
  str_TrialModeWarningCaption,
  str_TrialModeWarningCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(TrialModeWarningName
 with AddUsertype(OldBaseWarningName,
  str_OldBaseWarningCaption,
  str_OldBaseWarningCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(OldBaseWarningName
 with AddUsertype(ControlledChangingWarningName,
  str_ControlledChangingWarningCaption,
  str_ControlledChangingWarningCaption,
  false,
  -1,
  -1,
  FakeName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ControlledChangingWarningName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  BaloonWarningUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_FakeCaption
 str_FakeCaption.Init;
// Инициализация str_WarnJurorCaption
 str_WarnJurorCaption.Init;
// Инициализация str_WarnPreActiveCaption
 str_WarnPreActiveCaption.Init;
// Инициализация str_WarnIsAbolishedCaption
 str_WarnIsAbolishedCaption.Init;
// Инициализация str_WarnOnControlCaption
 str_WarnOnControlCaption.Init;
// Инициализация str_WarnInactualDocumentCaption
 str_WarnInactualDocumentCaption.Init;
// Инициализация str_WarnTimeMachineOnCaption
 str_WarnTimeMachineOnCaption.Init;
// Инициализация str_WarnRedactionCaption
 str_WarnRedactionCaption.Init;
// Инициализация str_WarnTimeMachineWarningCaption
 str_WarnTimeMachineWarningCaption.Init;
// Инициализация str_WarnTimeMachineExceptionCaption
 str_WarnTimeMachineExceptionCaption.Init;
// Инициализация str_remListModifiedCaption
 str_remListModifiedCaption.Init;
// Инициализация str_remListFilteredCaption
 str_remListFilteredCaption.Init;
// Инициализация str_remTimeMachineWarningCaption
 str_remTimeMachineWarningCaption.Init;
// Инициализация str_remUnreadConsultationsCaption
 str_remUnreadConsultationsCaption.Init;
// Инициализация str_remOnlineDeadCaption
 str_remOnlineDeadCaption.Init;
// Инициализация str_TrialModeWarningCaption
 str_TrialModeWarningCaption.Init;
// Инициализация str_OldBaseWarningCaption
 str_OldBaseWarningCaption.Init;
// Инициализация str_ControlledChangingWarningCaption
 str_ControlledChangingWarningCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaloonWarningUserTypes_imp_impl}
{$EndIf BaloonWarningUserTypes_imp}
