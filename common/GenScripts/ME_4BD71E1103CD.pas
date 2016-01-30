unit PrimNewsLine_nltMain_UserType;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimNewsLine_nltMain_UserType.pas"
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
 {* Константы для типа формы nltMain }
 nltMainName = 'nltMain';
  {* Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
 nltMain = TvcmUserType(0);
  {* ПРАЙМ. Моя новостная лента }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_nltMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы nltMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_nltMain
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_nltMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::nltMain';
end;//Tkw_FormUserType_nltMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_nltMain.GetInteger: Integer;
begin
 Result := nltMain;
end;//Tkw_FormUserType_nltMain.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_nltMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_nltMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
