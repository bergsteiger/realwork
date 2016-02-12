unit About_ut_About_UserType;
 {* О программе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\About_ut_About_UserType.pas"
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
 {* Константы для типа формы ut_About }
 ut_AboutName = 'ut_About';
  {* Строковый идентификатор пользовательского типа "О программе" }
 ut_About = TvcmUserType(0);
  {* О программе }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_About = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_About }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_About
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_About.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_About';
end;//Tkw_FormUserType_ut_About.GetWordNameForRegister

function Tkw_FormUserType_ut_About.GetInteger: Integer;
begin
 Result := ut_About;
end;//Tkw_FormUserType_ut_About.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_About.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_About }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
