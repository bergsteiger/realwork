unit AttributesUserTypes_fDocAttribute_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AttributesUserTypes_fDocAttribute_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::AttributesUserTypes::fDocAttribute
//
// Информация о документе
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
   { Константы для типа формы fDocAttribute }
  fDocAttributeName = 'fDocAttribute';
   { Строковый идентификатор пользовательского типа "Информация о документе" }
  fDocAttribute = TvcmUserType(0);
   { Информация о документе }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_fDocAttribute = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы fDocAttribute }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_fDocAttribute
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_fDocAttribute

class function Tkw_FormUserType_fDocAttribute.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::fDocAttribute';
end;//Tkw_FormUserType_fDocAttribute.GetWordNameForRegister

function Tkw_FormUserType_fDocAttribute.GetInteger: Integer;
 {-}
begin
 Result := fDocAttribute;
end;//Tkw_FormUserType_fDocAttribute.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_fDocAttribute
 Tkw_FormUserType_fDocAttribute.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.