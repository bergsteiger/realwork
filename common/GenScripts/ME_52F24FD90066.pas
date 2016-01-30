unit AutoPipeServerTestsRunner;

// Модуль: "w:\archi\source\projects\PipeInAuto\AutoPipeServerTestsRunner.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 {$If Defined(nsTest)}
 , GUIAppTester
 {$IfEnd} // Defined(nsTest)
;

type
 TAutoPipeServerTestsRunner = class(TGUIAppTester)
  public
   {$If Defined(nsTest)}
   class function GetResultsPlaces: TResultsPlaces; override;
   {$IfEnd} // Defined(nsTest)
 end;//TAutoPipeServerTestsRunner
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , toK
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , ArchiAutoTestSuite
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
;

{$If Defined(nsTest)}
class function TAutoPipeServerTestsRunner.GetResultsPlaces: TResultsPlaces;
//#UC START# *52F264840382_52F24FD90066_var*
//#UC END# *52F264840382_52F24FD90066_var*
begin
//#UC START# *52F264840382_52F24FD90066_impl*
 Result := MakeResults([TtoK{, TtoKT}]);
//#UC END# *52F264840382_52F24FD90066_impl*
end;//TAutoPipeServerTestsRunner.GetResultsPlaces
{$IfEnd} // Defined(nsTest)

{$IfEnd} // Defined(AppServerSide)
end.
