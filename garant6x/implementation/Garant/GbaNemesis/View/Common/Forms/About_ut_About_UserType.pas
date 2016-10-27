unit About_ut_About_UserType;
 {* О программе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\About_ut_About_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_About" MUID: (FF4420B11953)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_AboutLocalConstants }
 str_ut_AboutCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_AboutCaption'; rValue : 'О программе');
  {* Заголовок пользовательского типа "О программе" }
 {* Константы для типа формы ut_About }
 ut_AboutName = 'ut_About';
  {* Строковый идентификатор пользовательского типа "О программе" }
 ut_About = TvcmUserType(0);
  {* О программе }
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
 Tkw_FormUserType_ut_About = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_About }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_About
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_About.GetInteger: Integer;
begin
 Result := ut_About;
end;//Tkw_FormUserType_ut_About.GetInteger

class function Tkw_FormUserType_ut_About.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_About';
end;//Tkw_FormUserType_ut_About.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_AboutCaption.Init;
 {* Инициализация str_ut_AboutCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_About.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_About }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
