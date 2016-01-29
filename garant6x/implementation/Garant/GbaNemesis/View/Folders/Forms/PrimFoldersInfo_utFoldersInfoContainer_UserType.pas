unit PrimFoldersInfo_utFoldersInfoContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFoldersInfo_utFoldersInfoContainer_UserType.pas"
// Начат: 29.10.2009 19:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFoldersInfo::utFoldersInfoContainer
//
// Свойства папок (модальный диалог)
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
   { Константы для типа формы utFoldersInfoContainer }
  utFoldersInfoContainerName = 'utFoldersInfoContainer';
   { Строковый идентификатор пользовательского типа "Свойства папок (модальный диалог)" }
  utFoldersInfoContainer = TvcmUserType(0);
   { Свойства папок (модальный диалог) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFoldersInfoContainer = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utFoldersInfoContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFoldersInfoContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFoldersInfoContainer

class function Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utFoldersInfoContainer';
end;//Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister

function Tkw_FormUserType_utFoldersInfoContainer.GetInteger: Integer;
 {-}
begin
 Result := utFoldersInfoContainer;
end;//Tkw_FormUserType_utFoldersInfoContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utFoldersInfoContainer
 Tkw_FormUserType_utFoldersInfoContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.