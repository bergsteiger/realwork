unit EULA_ut_EULA_UserType;
 {* Условия использования }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULA_ut_EULA_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_EULA" MUID: (88631209C038)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_EULALocalConstants }
 str_ut_EULACaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_EULACaption'; rValue : 'Условия использования');
  {* Заголовок пользовательского типа "Условия использования" }
 {* Константы для типа формы ut_EULA }
 ut_EULAName = 'ut_EULA';
  {* Строковый идентификатор пользовательского типа "Условия использования" }
 ut_EULA = TvcmUserType(0);
  {* Условия использования }
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
 Tkw_FormUserType_ut_EULA = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_EULA }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_EULA
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_EULA.GetInteger: Integer;
begin
 Result := ut_EULA;
end;//Tkw_FormUserType_ut_EULA.GetInteger

class function Tkw_FormUserType_ut_EULA.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_EULA';
end;//Tkw_FormUserType_ut_EULA.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_EULACaption.Init;
 {* Инициализация str_ut_EULACaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_EULA.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_EULA }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
