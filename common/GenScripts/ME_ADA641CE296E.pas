unit elCustomEdit_ut_elCustomEdit_UserType;
 {* Форма для тестирования TelCustomEdit }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_ut_elCustomEdit_UserType.pas"
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
 {* Константы для типа формы ut_elCustomEdit }
 ut_elCustomEditName = 'ut_elCustomEdit';
  {* Строковый идентификатор пользовательского типа "Форма для тестирования TelCustomEdit" }
 ut_elCustomEdit = TvcmUserType(0);
  {* Форма для тестирования TelCustomEdit }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_elCustomEdit = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_elCustomEdit }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_elCustomEdit
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_elCustomEdit.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_elCustomEdit';
end;//Tkw_FormUserType_ut_elCustomEdit.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_elCustomEdit.GetInteger: Integer;
begin
 Result := ut_elCustomEdit;
end;//Tkw_FormUserType_ut_elCustomEdit.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_elCustomEdit.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_elCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
