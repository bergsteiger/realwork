unit Logo_ut_Logo_UserType;
 {* Logo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Logo_ut_Logo_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_Logo" MUID: (8D46F2A2464B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_LogoLocalConstants }
 str_ut_LogoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LogoCaption'; rValue : 'Logo');
  {* Заголовок пользовательского типа "Logo" }
 {* Константы для типа формы ut_Logo }
 ut_LogoName = 'ut_Logo';
  {* Строковый идентификатор пользовательского типа "Logo" }
 ut_Logo = TvcmUserType(0);
  {* Logo }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_Logo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_Logo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_Logo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_Logo.GetInteger: Integer;
begin
 Result := ut_Logo;
end;//Tkw_FormUserType_ut_Logo.GetInteger

class function Tkw_FormUserType_ut_Logo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_Logo';
end;//Tkw_FormUserType_ut_Logo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_LogoCaption.Init;
 {* Инициализация str_ut_LogoCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Logo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_Logo }
{$IfEnd} // NOT Defined(NoScripts)

end.
