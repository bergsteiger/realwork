unit PrimFolders_utFolders_UserType;
 {* Мои документы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFolders_utFolders_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utFolders" MUID: (4BD6C62402E7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utFoldersLocalConstants }
 str_utFoldersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersCaption'; rValue : 'Мои документы');
  {* Заголовок пользовательского типа "Мои документы" }
 {* Константы для типа формы utFolders }
 utFoldersName = 'utFolders';
  {* Строковый идентификатор пользовательского типа "Мои документы" }
 utFolders = TvcmUserType(0);
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
 Tkw_FormUserType_utFolders = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utFolders }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utFolders
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utFolders.GetInteger: Integer;
begin
 Result := utFolders;
end;//Tkw_FormUserType_utFolders.GetInteger

class function Tkw_FormUserType_utFolders.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utFolders';
end;//Tkw_FormUserType_utFolders.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utFoldersCaption.Init;
 {* Инициализация str_utFoldersCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFolders.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utFolders }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
