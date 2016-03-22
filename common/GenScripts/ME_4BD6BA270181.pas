unit AttributesUserTypes_fAttributeSynchroView_UserType;
 {* Информация о документе (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fAttributeSynchroView_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "fAttributeSynchroView" MUID: (4BD6BA270181)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AttributesUserTypes_fDocAttribute_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы fAttributeSynchroView }
 fAttributeSynchroViewName = 'fAttributeSynchroView';
  {* Строковый идентификатор пользовательского типа "Информация о документе (синхронный просмотр)" }
 fAttributeSynchroView = TvcmUserType(fDocAttribute + 1);
  {* Информация о документе (синхронный просмотр) }
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
 Tkw_FormUserType_fAttributeSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы fAttributeSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_fAttributeSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_fAttributeSynchroView.GetInteger: Integer;
begin
 Result := fAttributeSynchroView;
end;//Tkw_FormUserType_fAttributeSynchroView.GetInteger

class function Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::fAttributeSynchroView';
end;//Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fAttributeSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_fAttributeSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
