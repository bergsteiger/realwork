unit PrimShutDown_sftNone_UserType;
 {* Предупреждение о закрытии приложения }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimShutDown_sftNone_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "sftNone" MUID: (4C9851E00246)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки sftNoneLocalConstants }
 str_sftNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sftNoneCaption'; rValue : 'Предупреждение о закрытии приложения');
  {* Заголовок пользовательского типа "Предупреждение о закрытии приложения" }
 {* Константы для типа формы sftNone }
 sftNoneName = 'sftNone';
  {* Строковый идентификатор пользовательского типа "Предупреждение о закрытии приложения" }
 sftNone = TvcmUserType(0);
  {* Предупреждение о закрытии приложения }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_sftNone = {final} class(TtfwInteger)
  {* Слово словаря для типа формы sftNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_sftNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_sftNone.GetInteger: Integer;
begin
 Result := sftNone;
end;//Tkw_FormUserType_sftNone.GetInteger

class function Tkw_FormUserType_sftNone.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::sftNone';
end;//Tkw_FormUserType_sftNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_sftNoneCaption.Init;
 {* Инициализация str_sftNoneCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_sftNone.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_sftNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
