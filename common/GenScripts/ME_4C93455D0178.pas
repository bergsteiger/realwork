unit PrimStyleEditorContainer_utStyleEditorContainer_UserType;
 {* Редактор стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorContainer_utStyleEditorContainer_UserType.pas"
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
 {* Константы для типа формы utStyleEditorContainer }
 utStyleEditorContainerName = 'utStyleEditorContainer';
  {* Строковый идентификатор пользовательского типа "Редактор стилей" }
 utStyleEditorContainer = TvcmUserType(0);
  {* Редактор стилей }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorContainer = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utStyleEditorContainer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utStyleEditorContainer
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utStyleEditorContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utStyleEditorContainer';
end;//Tkw_FormUserType_utStyleEditorContainer.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utStyleEditorContainer.GetInteger: Integer;
begin
 Result := utStyleEditorContainer;
end;//Tkw_FormUserType_utStyleEditorContainer.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorContainer.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utStyleEditorContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
