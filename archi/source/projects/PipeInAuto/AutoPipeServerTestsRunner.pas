unit AutoPipeServerTestsRunner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/PipeInAuto/AutoPipeServerTestsRunner.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::AutoPipeServer$Test::TAutoPipeServerTestsRunner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  Classes
  {$If defined(nsTest)}
  ,
  GUIAppTester
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TAutoPipeServerTestsRunner = class(TGUIAppTester)
 public
 // realized methods
    {$If defined(nsTest)}
   class function GetResultsPlaces: TResultsPlaces; override;
    {$IfEnd} //nsTest
 end;//TAutoPipeServerTestsRunner
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  toK
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiAutoTestSuite
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}

// start class TAutoPipeServerTestsRunner

{$If defined(nsTest)}
class function TAutoPipeServerTestsRunner.GetResultsPlaces: TResultsPlaces;
//#UC START# *52F264840382_52F24FD90066_var*
//#UC END# *52F264840382_52F24FD90066_var*
begin
//#UC START# *52F264840382_52F24FD90066_impl*
 Result := MakeResults([TtoK{, TtoKT}]);
//#UC END# *52F264840382_52F24FD90066_impl*
end;//TAutoPipeServerTestsRunner.GetResultsPlaces
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide

end.