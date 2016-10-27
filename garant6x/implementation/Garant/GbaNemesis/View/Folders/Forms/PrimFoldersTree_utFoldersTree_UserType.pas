unit PrimFoldersTree_utFoldersTree_UserType;
 {* Мои документы (вкладка) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utFoldersTree_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utFoldersTree" MUID: (4BD6EB140266)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utFoldersTreeLocalConstants }
 str_utFoldersTreeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersTreeCaption'; rValue : 'Мои документы (вкладка)');
  {* Заголовок пользовательского типа "Мои документы (вкладка)" }
 {* Константы для типа формы utFoldersTree }
 utFoldersTreeName = 'utFoldersTree';
  {* Строковый идентификатор пользовательского типа "Мои документы (вкладка)" }
 utFoldersTree = TvcmUserType(0);
  {* Мои документы (вкладка) }
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
 Tkw_FormUserType_utFoldersTree = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utFoldersTree }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utFoldersTree
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utFoldersTree.GetInteger: Integer;
begin
 Result := utFoldersTree;
end;//Tkw_FormUserType_utFoldersTree.GetInteger

class function Tkw_FormUserType_utFoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utFoldersTree';
end;//Tkw_FormUserType_utFoldersTree.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utFoldersTreeCaption.Init;
 {* Инициализация str_utFoldersTreeCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersTree.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utFoldersTree }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
