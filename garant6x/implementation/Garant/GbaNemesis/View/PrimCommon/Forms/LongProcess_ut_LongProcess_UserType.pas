unit LongProcess_ut_LongProcess_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/LongProcess_ut_LongProcess_UserType.pas"
// Начат: 21.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimCommon::LongProcess::ut_LongProcess
//
// Информация
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
    { Константы для типа формы ut_LongProcess }
   ut_LongProcessName = 'ut_LongProcess';
    { Строковый идентификатор пользовательского типа "Информация" }
   ut_LongProcess = TvcmUserType(0);
    { Информация }

implementation

{$If not defined(NoScripts)}
type
   Tkw_FormUserType_ut_LongProcess = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_LongProcess }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_LongProcess
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_ut_LongProcess

class function Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_LongProcess';
end;//Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister

function Tkw_FormUserType_ut_LongProcess.GetInteger: Integer;
 {-}
begin
 Result := ut_LongProcess;
end;//Tkw_FormUserType_ut_LongProcess.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_LongProcess
 Tkw_FormUserType_ut_LongProcess.RegisterInEngine;
{$IfEnd} //not NoScripts

end.