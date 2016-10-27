unit PrimSaveLoadUserTypes_slqtAttribute_UserType;
 {* Поиск: По реквизитам }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtAttribute_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtAttribute" MUID: (4BD5BB7D038A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtAttributeLocalConstants }
 str_slqtAttributeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtAttributeCaption'; rValue : 'Поиск: По реквизитам');
  {* Заголовок пользовательского типа "Поиск: По реквизитам" }
 {* Константы для типа формы slqtAttribute }
 slqtAttributeName = 'slqtAttribute';
  {* Строковый идентификатор пользовательского типа "Поиск: По реквизитам" }
 slqtAttribute = TvcmUserType(0);
  {* Поиск: По реквизитам }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtAttribute = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtAttribute }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtAttribute
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtAttribute.GetInteger: Integer;
begin
 Result := slqtAttribute;
end;//Tkw_FormUserType_slqtAttribute.GetInteger

class function Tkw_FormUserType_slqtAttribute.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtAttribute';
end;//Tkw_FormUserType_slqtAttribute.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtAttributeCaption.Init;
 {* Инициализация str_slqtAttributeCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtAttribute.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtAttribute }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
