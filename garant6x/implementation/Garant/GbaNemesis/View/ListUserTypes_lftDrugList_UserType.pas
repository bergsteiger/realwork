unit ListUserTypes_lftDrugList_UserType;
 {* Список препаратов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugList_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftDrugList" MUID: (4BD58B4002A1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCRList2_SynchorForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки lftDrugListLocalConstants }
 str_lftDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugListCaption'; rValue : 'Список препаратов');
  {* Заголовок пользовательского типа "Список препаратов" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftDrugList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftDrugList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftDrugList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftDrugList.GetInteger: Integer;
begin
 Result := lftDrugList;
end;//Tkw_FormUserType_lftDrugList.GetInteger

class function Tkw_FormUserType_lftDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftDrugList';
end;//Tkw_FormUserType_lftDrugList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftDrugListCaption.Init;
 {* Инициализация str_lftDrugListCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftDrugList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
