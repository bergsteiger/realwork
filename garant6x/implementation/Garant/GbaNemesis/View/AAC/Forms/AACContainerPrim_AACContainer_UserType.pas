unit AACContainerPrim_AACContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/Forms/AACContainerPrim_AACContainer_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACContainerPrim::AACContainer
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
   { Константы для типа формы AACContainer }
  AACContainerName = 'AACContainer';
   { Строковый идентификатор пользовательского типа "" }
  AACContainer = TvcmUserType(0);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_AACContainer = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы AACContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_AACContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_AACContainer

class function Tkw_FormUserType_AACContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::AACContainer';
end;//Tkw_FormUserType_AACContainer.GetWordNameForRegister

function Tkw_FormUserType_AACContainer.GetInteger: Integer;
 {-}
begin
 Result := AACContainer;
end;//Tkw_FormUserType_AACContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_AACContainer
 Tkw_FormUserType_AACContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.