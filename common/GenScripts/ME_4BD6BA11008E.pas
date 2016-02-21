unit AttributesUserTypes_fDocAttribute_UserType;
 {* Информация о документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fDocAttribute_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fDocAttribute = {final} class(TtfwInteger)
  {* Слово словаря для типа формы fDocAttribute }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_fDocAttribute
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_fDocAttribute.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::fDocAttribute';
end;//Tkw_FormUserType_fDocAttribute.GetWordNameForRegister

function Tkw_FormUserType_fDocAttribute.GetInteger: Integer;
begin
 Result := fDocAttribute;
end;//Tkw_FormUserType_fDocAttribute.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fDocAttribute.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_fDocAttribute }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
