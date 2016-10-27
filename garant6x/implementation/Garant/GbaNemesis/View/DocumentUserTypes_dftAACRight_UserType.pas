unit DocumentUserTypes_dftAACRight_UserType;
 {* Правая часть Энциклопедии решений }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACRight_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftAACRight" MUID: (4FF2ECC2023E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACLeft_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки dftAACRightLocalConstants }
 str_dftAACRightCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightCaption'; rValue : 'Правая часть Энциклопедии решений');
  {* Заголовок пользовательского типа "Правая часть Энциклопедии решений" }
 str_dftAACRightSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightSettingsCaption'; rValue : 'Правая часть Энциклопедии решений');
  {* Заголовок пользовательского типа "Правая часть Энциклопедии решений" для настройки панелей инструментов }
 {* Константы для типа формы dftAACRight }
 dftAACRightName = 'dftAACRight';
  {* Строковый идентификатор пользовательского типа "Правая часть Энциклопедии решений" }
 dftAACRight = TvcmUserType(dftAACLeft + 1);
  {* Правая часть Энциклопедии решений }
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
 Tkw_FormUserType_dftAACRight = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAACRight }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAACRight
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAACRight.GetInteger: Integer;
begin
 Result := dftAACRight;
end;//Tkw_FormUserType_dftAACRight.GetInteger

class function Tkw_FormUserType_dftAACRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAACRight';
end;//Tkw_FormUserType_dftAACRight.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAACRightCaption.Init;
 {* Инициализация str_dftAACRightCaption }
 str_dftAACRightSettingsCaption.Init;
 {* Инициализация str_dftAACRightSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACRight.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAACRight }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
