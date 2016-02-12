unit F1LikeTextLoad_ut_F1LikeTextLoad_UserType;
 {* F1LikeTextLoad }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_ut_F1LikeTextLoad_UserType.pas"
// Стереотип: "UserType"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_F1LikeTextLoad = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_F1LikeTextLoad }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_F1LikeTextLoad
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_F1LikeTextLoad';
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister

function Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger: Integer;
begin
 Result := ut_F1LikeTextLoad;
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_F1LikeTextLoad.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_F1LikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
