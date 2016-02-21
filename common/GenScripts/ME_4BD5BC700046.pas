unit PrimSaveLoadUserTypes_slqtConsult_UserType;
 {* Правовая поддержка онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtConsult_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtPostingOrder_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы slqtConsult }
 slqtConsultName = 'slqtConsult';
  {* Строковый идентификатор пользовательского типа "Правовая поддержка онлайн" }
 slqtConsult = TvcmUserType(slqtPostingOrder + 1);
  {* Правовая поддержка онлайн }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtConsult = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtConsult }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtConsult
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtConsult.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtConsult';
end;//Tkw_FormUserType_slqtConsult.GetWordNameForRegister

function Tkw_FormUserType_slqtConsult.GetInteger: Integer;
begin
 Result := slqtConsult;
end;//Tkw_FormUserType_slqtConsult.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtConsult.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtConsult }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
