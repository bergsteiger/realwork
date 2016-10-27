unit DictionContainerUserTypes_slqtMedicDiction_UserType;
 {* Словарь медицинских терминов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes_slqtMedicDiction_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtMedicDiction" MUID: (4D81EE030156)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionContainerUserTypes_slqtDiction_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtMedicDictionLocalConstants }
 str_slqtMedicDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtMedicDictionCaption'; rValue : 'Словарь медицинских терминов');
  {* Заголовок пользовательского типа "Словарь медицинских терминов" }
 {* Константы для типа формы slqtMedicDiction }
 slqtMedicDictionName = 'slqtMedicDiction';
  {* Строковый идентификатор пользовательского типа "Словарь медицинских терминов" }
 slqtMedicDiction = TvcmUserType(slqtDiction + 1);
  {* Словарь медицинских терминов }
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
 Tkw_FormUserType_slqtMedicDiction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtMedicDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtMedicDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtMedicDiction.GetInteger: Integer;
begin
 Result := slqtMedicDiction;
end;//Tkw_FormUserType_slqtMedicDiction.GetInteger

class function Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtMedicDiction';
end;//Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtMedicDictionCaption.Init;
 {* Инициализация str_slqtMedicDictionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtMedicDiction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtMedicDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
