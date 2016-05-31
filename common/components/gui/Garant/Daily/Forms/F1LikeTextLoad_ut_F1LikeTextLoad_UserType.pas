unit F1LikeTextLoad_ut_F1LikeTextLoad_UserType;
 {* F1LikeTextLoad }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_ut_F1LikeTextLoad_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_F1LikeTextLoad" MUID: (EB591A36290E)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_F1LikeTextLoadLocalConstants }
 str_ut_F1LikeTextLoadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_F1LikeTextLoadCaption'; rValue : 'F1LikeTextLoad');
  {* Заголовок пользовательского типа "F1LikeTextLoad" }
 {* Константы для типа формы ut_F1LikeTextLoad }
 ut_F1LikeTextLoadName = 'ut_F1LikeTextLoad';
  {* Строковый идентификатор пользовательского типа "F1LikeTextLoad" }
 ut_F1LikeTextLoad = TvcmUserType(0);
  {* F1LikeTextLoad }
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
 Tkw_FormUserType_ut_F1LikeTextLoad = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_F1LikeTextLoad }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_F1LikeTextLoad
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger: Integer;
begin
 Result := ut_F1LikeTextLoad;
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger

class function Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_F1LikeTextLoad';
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_F1LikeTextLoadCaption.Init;
 {* Инициализация str_ut_F1LikeTextLoadCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_F1LikeTextLoad.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_F1LikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
