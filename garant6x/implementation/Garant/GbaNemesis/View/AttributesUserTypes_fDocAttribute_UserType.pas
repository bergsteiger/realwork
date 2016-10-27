unit AttributesUserTypes_fDocAttribute_UserType;
 {* Информация о документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fDocAttribute_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "fDocAttribute" MUID: (4BD6BA11008E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки fDocAttributeLocalConstants }
 str_fDocAttributeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fDocAttributeCaption'; rValue : 'Информация о документе');
  {* Заголовок пользовательского типа "Информация о документе" }
 {* Константы для типа формы fDocAttribute }
 fDocAttributeName = 'fDocAttribute';
  {* Строковый идентификатор пользовательского типа "Информация о документе" }
 fDocAttribute = TvcmUserType(0);
  {* Информация о документе }
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
 Tkw_FormUserType_fDocAttribute = {final} class(TtfwInteger)
  {* Слово словаря для типа формы fDocAttribute }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_fDocAttribute
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_fDocAttribute.GetInteger: Integer;
begin
 Result := fDocAttribute;
end;//Tkw_FormUserType_fDocAttribute.GetInteger

class function Tkw_FormUserType_fDocAttribute.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::fDocAttribute';
end;//Tkw_FormUserType_fDocAttribute.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_fDocAttributeCaption.Init;
 {* Инициализация str_fDocAttributeCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fDocAttribute.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_fDocAttribute }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
