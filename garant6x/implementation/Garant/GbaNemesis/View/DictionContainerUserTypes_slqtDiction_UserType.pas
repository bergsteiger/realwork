unit DictionContainerUserTypes_slqtDiction_UserType;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes_slqtDiction_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtDiction" MUID: (4D77A52C0374)

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
 {* Локализуемые строки slqtDictionLocalConstants }
 str_slqtDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtDictionCaption'; rValue : 'Толковый словарь');
  {* Заголовок пользовательского типа "Толковый словарь" }
 {* Константы для типа формы slqtDiction }
 slqtDictionName = 'slqtDiction';
  {* Строковый идентификатор пользовательского типа "Толковый словарь" }
 slqtDiction = TvcmUserType(0);
  {* Толковый словарь }
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
 Tkw_FormUserType_slqtDiction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtDiction.GetInteger: Integer;
begin
 Result := slqtDiction;
end;//Tkw_FormUserType_slqtDiction.GetInteger

class function Tkw_FormUserType_slqtDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtDiction';
end;//Tkw_FormUserType_slqtDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtDictionCaption.Init;
 {* Инициализация str_slqtDictionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtDiction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
