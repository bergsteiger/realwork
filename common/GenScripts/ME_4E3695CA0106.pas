unit ListAnalizeUserTypes_Analize_UserType;
 {* Анализ списка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes_Analize_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы Analize }
 AnalizeName = 'Analize';
  {* Строковый идентификатор пользовательского типа "Анализ списка" }
 Analize = TvcmUserType(0);
  {* Анализ списка }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Analize = {final} class(TtfwInteger)
  {* Слово словаря для типа формы Analize }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_Analize
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_Analize.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::Analize';
end;//Tkw_FormUserType_Analize.GetWordNameForRegister

function Tkw_FormUserType_Analize.GetInteger: Integer;
begin
 Result := Analize;
end;//Tkw_FormUserType_Analize.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Analize.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_Analize }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
