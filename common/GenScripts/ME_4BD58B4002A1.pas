unit ListUserTypes_lftDrugList_UserType;
 {* Список препаратов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugList_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCRList2_SynchorForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы lftDrugList }
 lftDrugListName = 'lftDrugList';
  {* Строковый идентификатор пользовательского типа "Список препаратов" }
 lftDrugList = TvcmUserType(lftUserCRList2_SynchorForm + 1);
  {* Список препаратов }
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
 Tkw_FormUserType_lftDrugList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftDrugList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftDrugList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftDrugList';
end;//Tkw_FormUserType_lftDrugList.GetWordNameForRegister

function Tkw_FormUserType_lftDrugList.GetInteger: Integer;
begin
 Result := lftDrugList;
end;//Tkw_FormUserType_lftDrugList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftDrugList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
