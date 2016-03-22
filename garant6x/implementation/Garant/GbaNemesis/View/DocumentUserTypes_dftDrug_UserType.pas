unit DocumentUserTypes_dftDrug_UserType;
 {* Описание препарата }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrug_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftDrug" MUID: (4B04104F0026)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAutoreferat_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы dftDrug }
 dftDrugName = 'dftDrug';
  {* Строковый идентификатор пользовательского типа "Описание препарата" }
 dftDrug = TvcmUserType(dftAutoreferat + 1);
  {* Описание препарата }
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
 Tkw_FormUserType_dftDrug = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftDrug }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftDrug
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftDrug.GetInteger: Integer;
begin
 Result := dftDrug;
end;//Tkw_FormUserType_dftDrug.GetInteger

class function Tkw_FormUserType_dftDrug.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftDrug';
end;//Tkw_FormUserType_dftDrug.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrug.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftDrug }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
