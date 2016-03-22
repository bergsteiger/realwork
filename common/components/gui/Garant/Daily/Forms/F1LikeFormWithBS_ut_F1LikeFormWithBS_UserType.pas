unit F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType;
 {* Форма с текстовым редактором с базовым поиском. }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_F1LikeFormWithBS" MUID: (7865160AD7D7)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* Константы для типа формы ut_F1LikeFormWithBS }
 ut_F1LikeFormWithBSName = 'ut_F1LikeFormWithBS';
  {* Строковый идентификатор пользовательского типа "Форма с текстовым редактором с базовым поиском." }
 ut_F1LikeFormWithBS = TvcmUserType(0);
  {* Форма с текстовым редактором с базовым поиском. }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_F1LikeFormWithBS = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_F1LikeFormWithBS }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_F1LikeFormWithBS
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_F1LikeFormWithBS.GetInteger: Integer;
begin
 Result := ut_F1LikeFormWithBS;
end;//Tkw_FormUserType_ut_F1LikeFormWithBS.GetInteger

class function Tkw_FormUserType_ut_F1LikeFormWithBS.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_F1LikeFormWithBS';
end;//Tkw_FormUserType_ut_F1LikeFormWithBS.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_F1LikeFormWithBS.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_F1LikeFormWithBS }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
