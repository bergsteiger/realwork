unit BaloonWarningUserTypes_remUnreadConsultations_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remUnreadConsultations_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "remUnreadConsultations" MUID: (4DBFF59201D0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки remUnreadConsultationsLocalConstants }
 str_remUnreadConsultationsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remUnreadConsultationsCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы remUnreadConsultations }
 remUnreadConsultationsName = 'remUnreadConsultations';
  {* Строковый идентификатор пользовательского типа "" }
 remUnreadConsultations = TvcmUserType(remTimeMachineWarning + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_remUnreadConsultations = {final} class(TtfwInteger)
  {* Слово словаря для типа формы remUnreadConsultations }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_remUnreadConsultations
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_remUnreadConsultations.GetInteger: Integer;
begin
 Result := remUnreadConsultations;
end;//Tkw_FormUserType_remUnreadConsultations.GetInteger

class function Tkw_FormUserType_remUnreadConsultations.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::remUnreadConsultations';
end;//Tkw_FormUserType_remUnreadConsultations.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_remUnreadConsultationsCaption.Init;
 {* Инициализация str_remUnreadConsultationsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remUnreadConsultations.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_remUnreadConsultations }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
