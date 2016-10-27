unit BaloonWarningUserTypes_remTimeMachineWarning_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remTimeMachineWarning_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "remTimeMachineWarning" MUID: (4DB97E9400A2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remListFiltered_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки remTimeMachineWarningLocalConstants }
 str_remTimeMachineWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remTimeMachineWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы remTimeMachineWarning }
 remTimeMachineWarningName = 'remTimeMachineWarning';
  {* Строковый идентификатор пользовательского типа "" }
 remTimeMachineWarning = TvcmUserType(remListFiltered + 1);
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
 Tkw_FormUserType_remTimeMachineWarning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы remTimeMachineWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_remTimeMachineWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_remTimeMachineWarning.GetInteger: Integer;
begin
 Result := remTimeMachineWarning;
end;//Tkw_FormUserType_remTimeMachineWarning.GetInteger

class function Tkw_FormUserType_remTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::remTimeMachineWarning';
end;//Tkw_FormUserType_remTimeMachineWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_remTimeMachineWarningCaption.Init;
 {* Инициализация str_remTimeMachineWarningCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remTimeMachineWarning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_remTimeMachineWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
