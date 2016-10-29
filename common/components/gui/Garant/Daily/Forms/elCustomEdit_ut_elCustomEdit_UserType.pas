unit elCustomEdit_ut_elCustomEdit_UserType;
 {* Форма для тестирования TelCustomEdit }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_ut_elCustomEdit_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_elCustomEdit" MUID: (ADA641CE296E)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_elCustomEditLocalConstants }
 str_ut_elCustomEditCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_elCustomEditCaption'; rValue : 'Форма для тестирования TelCustomEdit');
  {* Заголовок пользовательского типа "Форма для тестирования TelCustomEdit" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_elCustomEdit = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_elCustomEdit }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_elCustomEdit
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_elCustomEdit.GetInteger: Integer;
begin
 Result := ut_elCustomEdit;
end;//Tkw_FormUserType_ut_elCustomEdit.GetInteger

class function Tkw_FormUserType_ut_elCustomEdit.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_elCustomEdit';
end;//Tkw_FormUserType_ut_elCustomEdit.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_elCustomEditCaption.Init;
 {* Инициализация str_ut_elCustomEditCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_elCustomEdit.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_elCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
