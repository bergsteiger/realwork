unit ListUserTypes_lftUserCR2_UserType;
 {* Настраиваемая вкладка связанных документов 2 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCR2_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftUserCR2" MUID: (4BD589720381)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCR1_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы lftUserCR2 }
 lftUserCR2Name = 'lftUserCR2';
  {* Строковый идентификатор пользовательского типа "Настраиваемая вкладка связанных документов 2" }
 lftUserCR2 = TvcmUserType(lftUserCR1 + 1);
  {* Настраиваемая вкладка связанных документов 2 }
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
 Tkw_FormUserType_lftUserCR2 = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftUserCR2 }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftUserCR2
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftUserCR2.GetInteger: Integer;
begin
 Result := lftUserCR2;
end;//Tkw_FormUserType_lftUserCR2.GetInteger

class function Tkw_FormUserType_lftUserCR2.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftUserCR2';
end;//Tkw_FormUserType_lftUserCR2.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCR2.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftUserCR2 }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
