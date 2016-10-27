unit PrimSelectedAttributes_utSelectedAttributes_UserType;
 {* Поиск: Выбранные значения реквизита }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributes_utSelectedAttributes_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utSelectedAttributes" MUID: (4C6D0B950206)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utSelectedAttributesLocalConstants }
 str_utSelectedAttributesCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSelectedAttributesCaption'; rValue : 'Поиск: Выбранные значения реквизита');
  {* Заголовок пользовательского типа "Поиск: Выбранные значения реквизита" }
 {* Константы для типа формы utSelectedAttributes }
 utSelectedAttributesName = 'utSelectedAttributes';
  {* Строковый идентификатор пользовательского типа "Поиск: Выбранные значения реквизита" }
 utSelectedAttributes = TvcmUserType(0);
  {* Поиск: Выбранные значения реквизита }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utSelectedAttributes = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utSelectedAttributes }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utSelectedAttributes
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utSelectedAttributes.GetInteger: Integer;
begin
 Result := utSelectedAttributes;
end;//Tkw_FormUserType_utSelectedAttributes.GetInteger

class function Tkw_FormUserType_utSelectedAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utSelectedAttributes';
end;//Tkw_FormUserType_utSelectedAttributes.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utSelectedAttributesCaption.Init;
 {* Инициализация str_utSelectedAttributesCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSelectedAttributes.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utSelectedAttributes }
{$IfEnd} // NOT Defined(NoScripts)

end.
