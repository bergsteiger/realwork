unit PrimGroupProperty_admCreateGroup_UserType;
 {* Новая группа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupProperty_admCreateGroup_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "admCreateGroup" MUID: (4BD6FFA702F6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки admCreateGroupLocalConstants }
 str_admCreateGroupCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admCreateGroupCaption'; rValue : 'Новая группа');
  {* Заголовок пользовательского типа "Новая группа" }
 {* Константы для типа формы admCreateGroup }
 admCreateGroupName = 'admCreateGroup';
  {* Строковый идентификатор пользовательского типа "Новая группа" }
 admCreateGroup = TvcmUserType(0);
  {* Новая группа }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_admCreateGroup = {final} class(TtfwInteger)
  {* Слово словаря для типа формы admCreateGroup }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_admCreateGroup
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_admCreateGroup.GetInteger: Integer;
begin
 Result := admCreateGroup;
end;//Tkw_FormUserType_admCreateGroup.GetInteger

class function Tkw_FormUserType_admCreateGroup.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::admCreateGroup';
end;//Tkw_FormUserType_admCreateGroup.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_admCreateGroupCaption.Init;
 {* Инициализация str_admCreateGroupCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admCreateGroup.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_admCreateGroup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
