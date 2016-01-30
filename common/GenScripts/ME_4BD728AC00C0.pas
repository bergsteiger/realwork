unit PrimRubricator_utRubricatorList_UserType;
 {* Правовой навигатор (линейное представление) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\PrimRubricator_utRubricatorList_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы utRubricatorList }
 utRubricatorListName = 'utRubricatorList';
  {* Строковый идентификатор пользовательского типа "Правовой навигатор (линейное представление)" }
 utRubricatorList = TvcmUserType(0);
  {* Правовой навигатор (линейное представление) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRubricatorList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utRubricatorList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utRubricatorList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utRubricatorList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utRubricatorList';
end;//Tkw_FormUserType_utRubricatorList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utRubricatorList.GetInteger: Integer;
begin
 Result := utRubricatorList;
end;//Tkw_FormUserType_utRubricatorList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRubricatorList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utRubricatorList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
