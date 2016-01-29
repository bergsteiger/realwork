unit Main_ut_Main_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/NewGen/Main_ut_Main_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> MDProcess$NewGen$Interface::NewGen::NewGen::Main::ut_Main
//
// НЕ Роза
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\NewGen\ngDefine.inc}

interface

{$If defined(NewGen)}
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
   { Константы для типа формы ut_Main }
  ut_MainName = 'ut_Main';
   { Строковый идентификатор пользовательского типа "НЕ Роза" }
  ut_Main = TvcmUserType(0);
   { НЕ Роза }
{$IfEnd} //NewGen

implementation

{$If defined(NewGen)}
{$If defined(NewGen) AND not defined(NoScripts)}
type
  Tkw_FormUserType_ut_Main = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы ut_Main }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_Main
{$IfEnd} //NewGen AND not NoScripts

{$If defined(NewGen) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_Main

class function Tkw_FormUserType_ut_Main.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_Main';
end;//Tkw_FormUserType_ut_Main.GetWordNameForRegister

function Tkw_FormUserType_ut_Main.GetInteger: Integer;
 {-}
begin
 Result := ut_Main;
end;//Tkw_FormUserType_ut_Main.GetInteger

{$IfEnd} //NewGen AND not NoScripts
{$IfEnd} //NewGen

initialization
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_Main
 Tkw_FormUserType_ut_Main.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts

end.