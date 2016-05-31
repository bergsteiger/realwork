unit PrimFoldersTree_utSaveOpen_UserType;
 {* Мои документы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utSaveOpen_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utSaveOpen" MUID: (4BD6EB3F017A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersTree_utFoldersTree_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки utSaveOpenLocalConstants }
 str_utSaveOpenCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSaveOpenCaption'; rValue : 'Мои документы');
  {* Заголовок пользовательского типа "Мои документы" }
 {* Константы для типа формы utSaveOpen }
 utSaveOpenName = 'utSaveOpen';
  {* Строковый идентификатор пользовательского типа "Мои документы" }
 utSaveOpen = TvcmUserType(utFoldersTree + 1);
  {* Мои документы }
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
 Tkw_FormUserType_utSaveOpen = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utSaveOpen }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utSaveOpen
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utSaveOpen.GetInteger: Integer;
begin
 Result := utSaveOpen;
end;//Tkw_FormUserType_utSaveOpen.GetInteger

class function Tkw_FormUserType_utSaveOpen.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utSaveOpen';
end;//Tkw_FormUserType_utSaveOpen.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utSaveOpenCaption.Init;
 {* Инициализация str_utSaveOpenCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSaveOpen.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utSaveOpen }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
