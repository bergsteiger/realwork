unit PrimParent_utHistory_UserType;
 {* История навигации }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_utHistory_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utHistory" MUID: (4F72C32000CF)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы utHistory }
 utHistoryName = 'utHistory';
  {* Строковый идентификатор пользовательского типа "История навигации" }
 utHistory = TvcmUserType(0);
  {* История навигации }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utHistory = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utHistory }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utHistory
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utHistory.GetInteger: Integer;
begin
 Result := utHistory;
end;//Tkw_FormUserType_utHistory.GetInteger

class function Tkw_FormUserType_utHistory.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utHistory';
end;//Tkw_FormUserType_utHistory.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utHistory.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utHistory }
{$IfEnd} // NOT Defined(NoScripts)

end.
