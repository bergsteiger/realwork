unit PrimFoldersInfo_utFoldersInfoContainer_UserType;
 {* Свойства папок (модальный диалог) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfo_utFoldersInfoContainer_UserType.pas"
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
 {* Константы для типа формы utFoldersInfoContainer }
 utFoldersInfoContainerName = 'utFoldersInfoContainer';
  {* Строковый идентификатор пользовательского типа "Свойства папок (модальный диалог)" }
 utFoldersInfoContainer = TvcmUserType(0);
  {* Свойства папок (модальный диалог) }
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
 Tkw_FormUserType_utFoldersInfoContainer = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utFoldersInfoContainer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFoldersInfoContainer
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utFoldersInfoContainer';
end;//Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister

function Tkw_FormUserType_utFoldersInfoContainer.GetInteger: Integer;
begin
 Result := utFoldersInfoContainer;
end;//Tkw_FormUserType_utFoldersInfoContainer.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersInfoContainer.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utFoldersInfoContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
