unit PrimUnderControl_utUnderControl_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/UnderControl/Forms/PrimUnderControl_utUnderControl_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Работа с документом и списком документов::UnderControl::View::UnderControl::PrimUnderControl::utUnderControl
//
// Документы на контроле
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
   { Константы для типа формы utUnderControl }
  utUnderControlName = 'utUnderControl';
   { Строковый идентификатор пользовательского типа "Документы на контроле" }
  utUnderControl = TvcmUserType(0);
   { Документы на контроле }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utUnderControl = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utUnderControl }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utUnderControl
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utUnderControl

class function Tkw_FormUserType_utUnderControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utUnderControl';
end;//Tkw_FormUserType_utUnderControl.GetWordNameForRegister

function Tkw_FormUserType_utUnderControl.GetInteger: Integer;
 {-}
begin
 Result := utUnderControl;
end;//Tkw_FormUserType_utUnderControl.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utUnderControl
 Tkw_FormUserType_utUnderControl.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.