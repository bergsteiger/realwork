unit DocumentUserTypes_dftNone_UserType;
 {* Документ }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftNone_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 {* Константы для типа формы dftNone }
 dftNoneName = 'dftNone';
  {* Строковый идентификатор пользовательского типа "Документ" }
 dftNone = TvcmUserType(0);
  {* Документ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftNone = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftNone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftNone
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftNone.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftNone';
end;//Tkw_FormUserType_dftNone.GetWordNameForRegister

function Tkw_FormUserType_dftNone.GetInteger: Integer;
begin
 Result := dftNone;
end;//Tkw_FormUserType_dftNone.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftNone.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftNone }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
