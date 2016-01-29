unit EULA_ut_EULA_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/EULA_ut_EULA_UserType.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::EULA::ut_EULA
//
// Условия использования
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
    { Константы для типа формы ut_EULA }
   ut_EULAName = 'ut_EULA';
    { Строковый идентификатор пользовательского типа "Условия использования" }
   ut_EULA = TvcmUserType(0);
    { Условия использования }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_EULA = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_EULA }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_EULA
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_EULA

class function Tkw_FormUserType_ut_EULA.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_EULA';
end;//Tkw_FormUserType_ut_EULA.GetWordNameForRegister

function Tkw_FormUserType_ut_EULA.GetInteger: Integer;
 {-}
begin
 Result := ut_EULA;
end;//Tkw_FormUserType_ut_EULA.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_EULA
 Tkw_FormUserType_ut_EULA.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.