unit PrimShutDown_sftNone_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/PrimShutDown_sftNone_UserType.pas"
// Начат: 21.08.2009 21:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimShutDown::sftNone
//
// Предупреждение о закрытии приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
   { Константы для типа формы sftNone }
  sftNoneName = 'sftNone';
   { Строковый идентификатор пользовательского типа "Предупреждение о закрытии приложения" }
  sftNone = TvcmUserType(0);
   { Предупреждение о закрытии приложения }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_sftNone = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы sftNone }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_sftNone
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_sftNone

class function Tkw_FormUserType_sftNone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::sftNone';
end;//Tkw_FormUserType_sftNone.GetWordNameForRegister

function Tkw_FormUserType_sftNone.GetInteger: Integer;
 {-}
begin
 Result := sftNone;
end;//Tkw_FormUserType_sftNone.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_sftNone
 Tkw_FormUserType_sftNone.RegisterInEngine;
{$IfEnd} //not NoScripts

end.