unit PrimProgressIndicator_utProgressIndicator_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimProgressIndicator_utProgressIndicator_UserType.pas"
// Начат: 25.08.2009 18:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimProgressIndicator::utProgressIndicator
//
// Ход выполнения
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
   { Константы для типа формы utProgressIndicator }
  utProgressIndicatorName = 'utProgressIndicator';
   { Строковый идентификатор пользовательского типа "Ход выполнения" }
  utProgressIndicator = TvcmUserType(0);
   { Ход выполнения }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utProgressIndicator = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utProgressIndicator }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utProgressIndicator
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utProgressIndicator

class function Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utProgressIndicator';
end;//Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister

function Tkw_FormUserType_utProgressIndicator.GetInteger: Integer;
 {-}
begin
 Result := utProgressIndicator;
end;//Tkw_FormUserType_utProgressIndicator.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utProgressIndicator
 Tkw_FormUserType_utProgressIndicator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.