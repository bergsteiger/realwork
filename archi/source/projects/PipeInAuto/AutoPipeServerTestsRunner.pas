unit AutoPipeServerTestsRunner;

// Модуль: "w:\archi\source\projects\PipeInAuto\AutoPipeServerTestsRunner.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TAutoPipeServerTestsRunner" MUID: (52F24FD90066)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 {$If Defined(nsTest)}
 , GUIAppTester
 {$IfEnd} // Defined(nsTest)
;

type
 TAutoPipeServerTestsRunner = class({$If Defined(nsTest)}
 TGUIAppTester
 {$IfEnd} // Defined(nsTest)
 )
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
 //#UC START# *52F24FD90066impl_uses*
 //#UC END# *52F24FD90066impl_uses*
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
