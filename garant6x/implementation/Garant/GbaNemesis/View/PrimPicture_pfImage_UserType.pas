unit PrimPicture_pfImage_UserType;
 {* Просмотр графического объекта }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPicture_pfImage_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "pfImage" MUID: (4BD72A4C0062)

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
 {* Локализуемые строки pfImageLocalConstants }
 str_pfImageCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pfImageCaption'; rValue : 'Просмотр графического объекта');
  {* Заголовок пользовательского типа "Просмотр графического объекта" }
 str_pfImageSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pfImageSettingsCaption'; rValue : 'Документ: Просмотр графического объекта');
  {* Заголовок пользовательского типа "Просмотр графического объекта" для настройки панелей инструментов }
 {* Константы для типа формы pfImage }
 pfImageName = 'pfImage';
  {* Строковый идентификатор пользовательского типа "Просмотр графического объекта" }
 pfImage = TvcmUserType(0);
  {* Просмотр графического объекта }
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
 Tkw_FormUserType_pfImage = {final} class(TtfwInteger)
  {* Слово словаря для типа формы pfImage }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_pfImage
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_pfImage.GetInteger: Integer;
begin
 Result := pfImage;
end;//Tkw_FormUserType_pfImage.GetInteger

class function Tkw_FormUserType_pfImage.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::pfImage';
end;//Tkw_FormUserType_pfImage.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_pfImageCaption.Init;
 {* Инициализация str_pfImageCaption }
 str_pfImageSettingsCaption.Init;
 {* Инициализация str_pfImageSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_pfImage.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_pfImage }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
