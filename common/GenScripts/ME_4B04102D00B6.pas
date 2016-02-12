unit DocumentUserTypes_dftAutoreferat_UserType;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferat_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedDictEntry_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftAutoreferat }
 dftAutoreferatName = 'dftAutoreferat';
  {* Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
 dftAutoreferat = TvcmUserType(dftMedDictEntry + 1);
  {* ПРАЙМ. Моя новостная лента }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferat = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAutoreferat }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAutoreferat
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAutoreferat';
end;//Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister

function Tkw_FormUserType_dftAutoreferat.GetInteger: Integer;
begin
 Result := dftAutoreferat;
end;//Tkw_FormUserType_dftAutoreferat.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferat.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAutoreferat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
