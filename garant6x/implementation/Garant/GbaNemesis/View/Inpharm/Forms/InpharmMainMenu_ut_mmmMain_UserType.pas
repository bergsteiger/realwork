unit InpharmMainMenu_ut_mmmMain_UserType;
 {* ГАРАНТ-ИнФарм }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\InpharmMainMenu_ut_mmmMain_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_mmmMain" MUID: (4BD6DC630189)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_mmmMainLocalConstants }
 str_ut_mmmMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_mmmMainCaption'; rValue : 'ГАРАНТ-ИнФарм');
  {* Заголовок пользовательского типа "ГАРАНТ-ИнФарм" }
 {* Константы для типа формы ut_mmmMain }
 ut_mmmMainName = 'ut_mmmMain';
  {* Строковый идентификатор пользовательского типа "ГАРАНТ-ИнФарм" }
 ut_mmmMain = TvcmUserType(0);
  {* ГАРАНТ-ИнФарм }
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
 Tkw_FormUserType_ut_mmmMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_mmmMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_mmmMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_mmmMain.GetInteger: Integer;
begin
 Result := ut_mmmMain;
end;//Tkw_FormUserType_ut_mmmMain.GetInteger

class function Tkw_FormUserType_ut_mmmMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_mmmMain';
end;//Tkw_FormUserType_ut_mmmMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_mmmMainCaption.Init;
 {* Инициализация str_ut_mmmMainCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_mmmMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_mmmMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
