unit PrimFoldersTree_utFoldersTree_UserType;
 {* Мои документы (вкладка) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utFoldersTree_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersTree_utSaveOpen_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersTree = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utFoldersTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFoldersTree
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utFoldersTree';
end;//Tkw_FormUserType_utFoldersTree.GetWordNameForRegister

function Tkw_FormUserType_utFoldersTree.GetInteger: Integer;
begin
 Result := utFoldersTree;
end;//Tkw_FormUserType_utFoldersTree.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersTree.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utFoldersTree }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
