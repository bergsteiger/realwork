unit PrimEditionsContainer_utEditionsContainer_UserType;
 {* Сравнение редакций документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimEditionsContainer_utEditionsContainer_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utEditionsContainer" MUID: (4BD705C900FF)

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
 {* Константы для типа формы utEditionsContainer }
 utEditionsContainerName = 'utEditionsContainer';
  {* Строковый идентификатор пользовательского типа "Сравнение редакций документа" }
 utEditionsContainer = TvcmUserType(0);
  {* Сравнение редакций документа }
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
 Tkw_FormUserType_utEditionsContainer = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utEditionsContainer }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utEditionsContainer
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utEditionsContainer.GetInteger: Integer;
begin
 Result := utEditionsContainer;
end;//Tkw_FormUserType_utEditionsContainer.GetInteger

class function Tkw_FormUserType_utEditionsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utEditionsContainer';
end;//Tkw_FormUserType_utEditionsContainer.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utEditionsContainer.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utEditionsContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
