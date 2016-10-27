unit PrimSaveLoadUserTypes_slqtKW_UserType;
 {* Поиск: По ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtKW_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtKW" MUID: (4BD5BB8D0207)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtAttribute_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtKWLocalConstants }
 str_slqtKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtKWCaption'; rValue : 'Поиск: По ситуации');
  {* Заголовок пользовательского типа "Поиск: По ситуации" }
 {* Константы для типа формы slqtKW }
 slqtKWName = 'slqtKW';
  {* Строковый идентификатор пользовательского типа "Поиск: По ситуации" }
 slqtKW = TvcmUserType(slqtAttribute + 1);
  {* Поиск: По ситуации }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtKW = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtKW }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtKW
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtKW.GetInteger: Integer;
begin
 Result := slqtKW;
end;//Tkw_FormUserType_slqtKW.GetInteger

class function Tkw_FormUserType_slqtKW.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtKW';
end;//Tkw_FormUserType_slqtKW.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtKWCaption.Init;
 {* Инициализация str_slqtKWCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtKW.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
