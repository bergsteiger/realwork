unit ListUserTypes_lftRToPart_UserType;
 {* Ссылки из фрагмента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRToPart_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftRToPart" MUID: (5236CE6D00AC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы lftRToPart }
 lftRToPartName = 'lftRToPart';
  {* Строковый идентификатор пользовательского типа "Ссылки из фрагмента" }
 lftRToPart = TvcmUserType(lftDrugInternationalNameSynonymsSynchroForm + 1);
  {* Ссылки из фрагмента }
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
 Tkw_FormUserType_lftRToPart = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftRToPart }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftRToPart
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftRToPart.GetInteger: Integer;
begin
 Result := lftRToPart;
end;//Tkw_FormUserType_lftRToPart.GetInteger

class function Tkw_FormUserType_lftRToPart.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftRToPart';
end;//Tkw_FormUserType_lftRToPart.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRToPart.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftRToPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
