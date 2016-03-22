unit ListUserTypes_lftProducedDrugs_UserType;
 {* Выпускаемые препараты }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftProducedDrugs_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftProducedDrugs" MUID: (4BD58B810263)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftDrugInternationalNameSynonyms_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы lftProducedDrugs }
 lftProducedDrugsName = 'lftProducedDrugs';
  {* Строковый идентификатор пользовательского типа "Выпускаемые препараты" }
 lftProducedDrugs = TvcmUserType(lftDrugInternationalNameSynonyms + 1);
  {* Выпускаемые препараты }
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
 Tkw_FormUserType_lftProducedDrugs = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftProducedDrugs }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftProducedDrugs
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftProducedDrugs.GetInteger: Integer;
begin
 Result := lftProducedDrugs;
end;//Tkw_FormUserType_lftProducedDrugs.GetInteger

class function Tkw_FormUserType_lftProducedDrugs.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftProducedDrugs';
end;//Tkw_FormUserType_lftProducedDrugs.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftProducedDrugs.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftProducedDrugs }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
