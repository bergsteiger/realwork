unit AACContainerPrim_AACContentsContainer_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContentsContainer_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACContainerPrim_AACContainer_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы AACContentsContainer }
 AACContentsContainerName = 'AACContentsContainer';
  {* Строковый идентификатор пользовательского типа "" }
 AACContentsContainer = TvcmUserType(AACContainer + 1);
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
 Tkw_FormUserType_AACContentsContainer = {final} class(TtfwInteger)
  {* Слово словаря для типа формы AACContentsContainer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_AACContentsContainer
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::AACContentsContainer';
end;//Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister

function Tkw_FormUserType_AACContentsContainer.GetInteger: Integer;
begin
 Result := AACContentsContainer;
end;//Tkw_FormUserType_AACContentsContainer.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_AACContentsContainer.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_AACContentsContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
