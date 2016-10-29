unit SynchroViewUserTypes_svSynchroView_UserType;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes_svSynchroView_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "svSynchroView" MUID: (4BD6C0D30243)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки svSynchroViewLocalConstants }
 str_svSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svSynchroViewCaption'; rValue : 'Синхронный просмотр');
  {* Заголовок пользовательского типа "Синхронный просмотр" }
 {* Константы для типа формы svSynchroView }
 svSynchroViewName = 'svSynchroView';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр" }
 svSynchroView = TvcmUserType(0);
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
 Tkw_FormUserType_svSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы svSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_svSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_svSynchroView.GetInteger: Integer;
begin
 Result := svSynchroView;
end;//Tkw_FormUserType_svSynchroView.GetInteger

class function Tkw_FormUserType_svSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::svSynchroView';
end;//Tkw_FormUserType_svSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_svSynchroViewCaption.Init;
 {* Инициализация str_svSynchroViewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_svSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_svSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
