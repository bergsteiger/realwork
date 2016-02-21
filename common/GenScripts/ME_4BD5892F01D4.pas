unit ListUserTypes_lftUserCR1_UserType;
 {* Настраиваемая вкладка связанных документов 1 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCR1_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCToPart_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы lftUserCR1 }
 lftUserCR1Name = 'lftUserCR1';
  {* Строковый идентификатор пользовательского типа "Настраиваемая вкладка связанных документов 1" }
 lftUserCR1 = TvcmUserType(lftCToPart + 1);
  {* Настраиваемая вкладка связанных документов 1 }
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
 Tkw_FormUserType_lftUserCR1 = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftUserCR1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftUserCR1
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftUserCR1.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftUserCR1';
end;//Tkw_FormUserType_lftUserCR1.GetWordNameForRegister

function Tkw_FormUserType_lftUserCR1.GetInteger: Integer;
begin
 Result := lftUserCR1;
end;//Tkw_FormUserType_lftUserCR1.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCR1.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftUserCR1 }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
