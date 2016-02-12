unit DocumentUserTypes_dftAACLeft_UserType;
 {* Левая часть Энциклопедии решений }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACLeft_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrugSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftAACLeft }
 dftAACLeftName = 'dftAACLeft';
  {* Строковый идентификатор пользовательского типа "Левая часть Энциклопедии решений" }
 dftAACLeft = TvcmUserType(dftDrugSynchroView + 1);
  {* Левая часть Энциклопедии решений }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACLeft = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAACLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAACLeft
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAACLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAACLeft';
end;//Tkw_FormUserType_dftAACLeft.GetWordNameForRegister

function Tkw_FormUserType_dftAACLeft.GetInteger: Integer;
begin
 Result := dftAACLeft;
end;//Tkw_FormUserType_dftAACLeft.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACLeft.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAACLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
