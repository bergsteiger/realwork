unit AttributesUserTypes_fAttributeSynchroView_UserType;
 {* Информация о документе (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fAttributeSynchroView_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AttributesUserTypes_fDocAttribute_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fAttributeSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы fAttributeSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_fAttributeSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::fAttributeSynchroView';
end;//Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister

function Tkw_FormUserType_fAttributeSynchroView.GetInteger: Integer;
begin
 Result := fAttributeSynchroView;
end;//Tkw_FormUserType_fAttributeSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fAttributeSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_fAttributeSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
