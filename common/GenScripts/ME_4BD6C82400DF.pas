unit PrimMedicListSynchroView_mlsfDrugList_UserType;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfDrugList_UserType.pas"
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
 {* Константы для типа формы mlsfDrugList }
 mlsfDrugListName = 'mlsfDrugList';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр" }
 mlsfDrugList = TvcmUserType(0);
  {* Синхронный просмотр }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfDrugList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы mlsfDrugList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_mlsfDrugList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::mlsfDrugList';
end;//Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_mlsfDrugList.GetInteger: Integer;
begin
 Result := mlsfDrugList;
end;//Tkw_FormUserType_mlsfDrugList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfDrugList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_mlsfDrugList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
