unit DocumentUserTypes_dftAACLeft_UserType;
 {* Левая часть Энциклопедии решений }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACLeft_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftAACLeft" MUID: (4FF2ECB40153)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrugSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftAACLeft = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAACLeft }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAACLeft
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAACLeft.GetInteger: Integer;
begin
 Result := dftAACLeft;
end;//Tkw_FormUserType_dftAACLeft.GetInteger

class function Tkw_FormUserType_dftAACLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAACLeft';
end;//Tkw_FormUserType_dftAACLeft.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACLeft.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAACLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
