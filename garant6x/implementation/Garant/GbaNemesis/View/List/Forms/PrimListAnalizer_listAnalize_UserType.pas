unit PrimListAnalizer_listAnalize_UserType;
 {* Анализ списка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalizer_listAnalize_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "listAnalize" MUID: (4BD71C5800C2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки listAnalizeLocalConstants }
 str_listAnalizeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'listAnalizeCaption'; rValue : 'Анализ списка');
  {* Заголовок пользовательского типа "Анализ списка" }
 {* Константы для типа формы listAnalize }
 listAnalizeName = 'listAnalize';
  {* Строковый идентификатор пользовательского типа "Анализ списка" }
 listAnalize = TvcmUserType(0);
  {* Анализ списка }
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
 Tkw_FormUserType_listAnalize = {final} class(TtfwInteger)
  {* Слово словаря для типа формы listAnalize }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_listAnalize
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_listAnalize.GetInteger: Integer;
begin
 Result := listAnalize;
end;//Tkw_FormUserType_listAnalize.GetInteger

class function Tkw_FormUserType_listAnalize.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::listAnalize';
end;//Tkw_FormUserType_listAnalize.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_listAnalizeCaption.Init;
 {* Инициализация str_listAnalizeCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_listAnalize.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_listAnalize }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
