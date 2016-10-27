unit PrimAttributeSelect_utAttributeSelect_UserType;
 {* Выбор значения атрибута }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utAttributeSelect_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utAttributeSelect" MUID: (4BD6F81D015C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utAttributeSelectLocalConstants }
 str_utAttributeSelectCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utAttributeSelectCaption'; rValue : 'Выбор значения атрибута');
  {* Заголовок пользовательского типа "Выбор значения атрибута" }
 {* Константы для типа формы utAttributeSelect }
 utAttributeSelectName = 'utAttributeSelect';
  {* Строковый идентификатор пользовательского типа "Выбор значения атрибута" }
 utAttributeSelect = TvcmUserType(0);
  {* Выбор значения атрибута }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utAttributeSelect = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utAttributeSelect }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utAttributeSelect
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utAttributeSelect.GetInteger: Integer;
begin
 Result := utAttributeSelect;
end;//Tkw_FormUserType_utAttributeSelect.GetInteger

class function Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utAttributeSelect';
end;//Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utAttributeSelectCaption.Init;
 {* Инициализация str_utAttributeSelectCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAttributeSelect.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)

end.
