unit BaloonWarningUserTypes_TrialModeWarning_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_TrialModeWarning_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "TrialModeWarning" MUID: (4DBFF62502F4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remOnlineDead_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки TrialModeWarningLocalConstants }
 str_TrialModeWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы TrialModeWarning }
 TrialModeWarningName = 'TrialModeWarning';
  {* Строковый идентификатор пользовательского типа "" }
 TrialModeWarning = TvcmUserType(remOnlineDead + 1);
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
 Tkw_FormUserType_TrialModeWarning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы TrialModeWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_TrialModeWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_TrialModeWarning.GetInteger: Integer;
begin
 Result := TrialModeWarning;
end;//Tkw_FormUserType_TrialModeWarning.GetInteger

class function Tkw_FormUserType_TrialModeWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::TrialModeWarning';
end;//Tkw_FormUserType_TrialModeWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_TrialModeWarningCaption.Init;
 {* Инициализация str_TrialModeWarningCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_TrialModeWarning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_TrialModeWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
