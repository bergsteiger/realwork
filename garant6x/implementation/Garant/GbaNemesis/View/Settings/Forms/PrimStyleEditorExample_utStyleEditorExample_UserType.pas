unit PrimStyleEditorExample_utStyleEditorExample_UserType;
 {* Текстовое окно редактора стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorExample_utStyleEditorExample_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utStyleEditorExample" MUID: (4BD6DFC00310)

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
 {* Локализуемые строки utStyleEditorExampleLocalConstants }
 str_utStyleEditorExampleCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorExampleCaption'; rValue : 'Текстовое окно редактора стилей');
  {* Заголовок пользовательского типа "Текстовое окно редактора стилей" }
 {* Константы для типа формы utStyleEditorExample }
 utStyleEditorExampleName = 'utStyleEditorExample';
  {* Строковый идентификатор пользовательского типа "Текстовое окно редактора стилей" }
 utStyleEditorExample = TvcmUserType(0);
  {* Текстовое окно редактора стилей }
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
 Tkw_FormUserType_utStyleEditorExample = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utStyleEditorExample }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utStyleEditorExample
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utStyleEditorExample.GetInteger: Integer;
begin
 Result := utStyleEditorExample;
end;//Tkw_FormUserType_utStyleEditorExample.GetInteger

class function Tkw_FormUserType_utStyleEditorExample.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utStyleEditorExample';
end;//Tkw_FormUserType_utStyleEditorExample.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utStyleEditorExampleCaption.Init;
 {* Инициализация str_utStyleEditorExampleCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorExample.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utStyleEditorExample }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
