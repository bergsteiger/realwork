unit PrimShutDown_sftNone_UserType;
 {* Предупреждение о закрытии приложения }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimShutDown_sftNone_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы sftNone }
 sftNoneName = 'sftNone';
  {* Строковый идентификатор пользовательского типа "Предупреждение о закрытии приложения" }
 sftNone = TvcmUserType(0);
  {* Предупреждение о закрытии приложения }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_sftNone = {final} class(TtfwInteger)
  {* Слово словаря для типа формы sftNone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_sftNone
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_sftNone.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::sftNone';
end;//Tkw_FormUserType_sftNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_sftNone.GetInteger: Integer;
begin
 Result := sftNone;
end;//Tkw_FormUserType_sftNone.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_sftNone.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_sftNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
