unit PrimTreeAttributeSelect_astNone_UserType;
 {* Поиск: Выбор реквизита }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astNone_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "astNone" MUID: (4BD6F94500AC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки astNoneLocalConstants }
 str_astNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astNoneCaption'; rValue : 'Поиск: Выбор реквизита');
  {* Заголовок пользовательского типа "Поиск: Выбор реквизита" }
 {* Константы для типа формы astNone }
 astNoneName = 'astNone';
  {* Строковый идентификатор пользовательского типа "Поиск: Выбор реквизита" }
 astNone = TvcmUserType(0);
  {* Поиск: Выбор реквизита }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astNone = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astNone.GetInteger: Integer;
begin
 Result := astNone;
end;//Tkw_FormUserType_astNone.GetInteger

class function Tkw_FormUserType_astNone.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astNone';
end;//Tkw_FormUserType_astNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_astNoneCaption.Init;
 {* Инициализация str_astNoneCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astNone.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
