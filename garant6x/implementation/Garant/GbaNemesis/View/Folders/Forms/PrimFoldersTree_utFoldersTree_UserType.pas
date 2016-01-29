unit PrimFoldersTree_utFoldersTree_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFoldersTree_utFoldersTree_UserType.pas"
// Начат: 26.01.2009 18:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFoldersTree::utFoldersTree
//
// Мои документы (вкладка)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utFoldersTree }
  utFoldersTreeName = 'utFoldersTree';
   { Строковый идентификатор пользовательского типа "Мои документы (вкладка)" }
  utFoldersTree = TvcmUserType(0);
   { Мои документы (вкладка) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFoldersTree = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utFoldersTree }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFoldersTree
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFoldersTree

class function Tkw_FormUserType_utFoldersTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utFoldersTree';
end;//Tkw_FormUserType_utFoldersTree.GetWordNameForRegister

function Tkw_FormUserType_utFoldersTree.GetInteger: Integer;
 {-}
begin
 Result := utFoldersTree;
end;//Tkw_FormUserType_utFoldersTree.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utFoldersTree
 Tkw_FormUserType_utFoldersTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.