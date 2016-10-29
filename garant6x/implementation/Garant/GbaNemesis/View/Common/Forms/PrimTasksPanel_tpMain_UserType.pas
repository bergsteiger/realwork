unit PrimTasksPanel_tpMain_UserType;
 {* Панель задач }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_tpMain_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "tpMain" MUID: (4BD6D9AE030B)

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
 {* Локализуемые строки tpMainLocalConstants }
 str_tpMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tpMainCaption'; rValue : 'Панель задач');
  {* Заголовок пользовательского типа "Панель задач" }
 {* Константы для типа формы tpMain }
 tpMainName = 'tpMain';
  {* Строковый идентификатор пользовательского типа "Панель задач" }
 tpMain = TvcmUserType(0);
  {* Панель задач }
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
 Tkw_FormUserType_tpMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы tpMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_tpMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_tpMain.GetInteger: Integer;
begin
 Result := tpMain;
end;//Tkw_FormUserType_tpMain.GetInteger

class function Tkw_FormUserType_tpMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::tpMain';
end;//Tkw_FormUserType_tpMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_tpMainCaption.Init;
 {* Инициализация str_tpMainCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_tpMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_tpMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
