unit InsiderOwnScripter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Tests Core"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/InsiderOwnScripter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> F1 Поддержка тестов::F1 Shell Tests Core::Core::InsiderOwnScripter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  CustomInsiderScripter
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _F1Test_Parent_ = TCustomInsiderScripter;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}
 TInsiderOwnScripter = {abstract} class(_F1Test_)
 protected
 // realized methods
   procedure Run; override;
   procedure Prepare; override;
     {* Вызывается в начале DoIt }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TInsiderOwnScripter
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(Admin)}
  ,
  nsQueryInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  nsConst,
  bsTypesNew,
  tfwScriptEngine
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}

// start class TInsiderOwnScripter

procedure TInsiderOwnScripter.Run;
//#UC START# *4DC3D2E00153_4DB03B1B0055_var*
//#UC END# *4DC3D2E00153_4DB03B1B0055_var*
begin
//#UC START# *4DC3D2E00153_4DB03B1B0055_impl*
 OwnScriptFromFile;
//#UC END# *4DC3D2E00153_4DB03B1B0055_impl*
end;//TInsiderOwnScripter.Run

procedure TInsiderOwnScripter.Prepare;
//#UC START# *4DC3DE630030_4DB03B1B0055_var*
//#UC END# *4DC3DE630030_4DB03B1B0055_var*
begin
//#UC START# *4DC3DE630030_4DB03B1B0055_impl*
 g_WasBeep := false;
 //Script('"Закрыть все окна кроме текущего" StyleTable:Restore ОсновноеМеню "Сбрасываем вкладку БП в умолчательное состояние" "Выключаем машину времени" clipboard:clear');
 //ScriptFromFile('@\TestProlog.script');
//#UC END# *4DC3DE630030_4DB03B1B0055_impl*
end;//TInsiderOwnScripter.Prepare

function TInsiderOwnScripter.GetFolder: AnsiString;
 {-}
begin
 Result := 'Core';
end;//TInsiderOwnScripter.GetFolder

function TInsiderOwnScripter.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DB03B1B0055';
end;//TInsiderOwnScripter.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.