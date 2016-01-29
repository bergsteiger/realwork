unit PrimFolders_utFolders_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFolders_utFolders_UserType.pas"
// Начат: 27.08.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders::utFolders
//
// Мои документы
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
   { Константы для типа формы utFolders }
  utFoldersName = 'utFolders';
   { Строковый идентификатор пользовательского типа "Мои документы" }
  utFolders = TvcmUserType(0);
   { Мои документы }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFolders = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utFolders }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFolders
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFolders

class function Tkw_FormUserType_utFolders.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utFolders';
end;//Tkw_FormUserType_utFolders.GetWordNameForRegister

function Tkw_FormUserType_utFolders.GetInteger: Integer;
 {-}
begin
 Result := utFolders;
end;//Tkw_FormUserType_utFolders.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utFolders
 Tkw_FormUserType_utFolders.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.