unit PrimMedicListSynchroView_mlsfDrugList_UserType;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfDrugList_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "mlsfDrugList" MUID: (4BD6C82400DF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки mlsfDrugListLocalConstants }
 str_mlsfDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfDrugListCaption'; rValue : 'Синхронный просмотр');
  {* Заголовок пользовательского типа "Синхронный просмотр" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_mlsfDrugList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы mlsfDrugList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_mlsfDrugList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_mlsfDrugList.GetInteger: Integer;
begin
 Result := mlsfDrugList;
end;//Tkw_FormUserType_mlsfDrugList.GetInteger

class function Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::mlsfDrugList';
end;//Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_mlsfDrugListCaption.Init;
 {* Инициализация str_mlsfDrugListCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfDrugList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_mlsfDrugList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
