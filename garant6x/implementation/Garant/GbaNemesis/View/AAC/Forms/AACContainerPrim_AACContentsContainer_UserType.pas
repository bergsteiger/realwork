unit AACContainerPrim_AACContentsContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/Forms/AACContainerPrim_AACContentsContainer_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACContainerPrim::AACContentsContainer
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
  ,
  AACContainerPrim_AACContainer_UserType
  ;

const
   { Константы для типа формы AACContentsContainer }
  AACContentsContainerName = 'AACContentsContainer';
   { Строковый идентификатор пользовательского типа "" }
  AACContentsContainer = TvcmUserType(AACContainer + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_AACContentsContainer = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы AACContentsContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_AACContentsContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_AACContentsContainer

class function Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::AACContentsContainer';
end;//Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister

function Tkw_FormUserType_AACContentsContainer.GetInteger: Integer;
 {-}
begin
 Result := AACContentsContainer;
end;//Tkw_FormUserType_AACContentsContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_AACContentsContainer
 Tkw_FormUserType_AACContentsContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.