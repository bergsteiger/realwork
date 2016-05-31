unit OutlinerForm_ut_OutlinerForm_UserType;
 {* Форма для тестирования списка }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\OutlinerForm_ut_OutlinerForm_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_OutlinerForm" MUID: (2404FCE7338E)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_OutlinerFormLocalConstants }
 str_ut_OutlinerFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_OutlinerFormCaption'; rValue : 'Форма для тестирования списка');
  {* Заголовок пользовательского типа "Форма для тестирования списка" }
 {* Константы для типа формы ut_OutlinerForm }
 ut_OutlinerFormName = 'ut_OutlinerForm';
  {* Строковый идентификатор пользовательского типа "Форма для тестирования списка" }
 ut_OutlinerForm = TvcmUserType(0);
  {* Форма для тестирования списка }
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
 Tkw_FormUserType_ut_OutlinerForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_OutlinerForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_OutlinerForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_OutlinerForm.GetInteger: Integer;
begin
 Result := ut_OutlinerForm;
end;//Tkw_FormUserType_ut_OutlinerForm.GetInteger

class function Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_OutlinerForm';
end;//Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_OutlinerFormCaption.Init;
 {* Инициализация str_ut_OutlinerFormCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_OutlinerForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_OutlinerForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
