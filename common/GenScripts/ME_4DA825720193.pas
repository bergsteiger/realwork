unit BaloonWarningUserTypes_WarnJuror_UserType;
 {* Юридическое предупреждение }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnJuror_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnJuror" MUID: (4DA825720193)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки WarnJurorLocalConstants }
 str_WarnJurorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnJurorCaption'; rValue : 'Юридическое предупреждение');
  {* Заголовок пользовательского типа "Юридическое предупреждение" }
 {* Константы для типа формы WarnJuror }
 WarnJurorName = 'WarnJuror';
  {* Строковый идентификатор пользовательского типа "Юридическое предупреждение" }
 WarnJuror = TvcmUserType(Fake + 1);
  {* Юридическое предупреждение }
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
 Tkw_FormUserType_WarnJuror = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnJuror }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnJuror
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnJuror.GetInteger: Integer;
begin
 Result := WarnJuror;
end;//Tkw_FormUserType_WarnJuror.GetInteger

class function Tkw_FormUserType_WarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnJuror';
end;//Tkw_FormUserType_WarnJuror.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_WarnJurorCaption.Init;
 {* Инициализация str_WarnJurorCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnJuror.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnJuror }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
