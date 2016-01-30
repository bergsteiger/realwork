unit GUIAppTester;

// Модуль: "w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.pas"
// Стереотип: "SimpleClass"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , tfwScriptDebugger
 {$IfEnd} // Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 , GUITestRunner
;

type
 TResultsPlaces = array of RTestResultsPlace;

 _GUIAppTester_Parent_ = Tl3ProtoObject;
 {$Include GUIAppTester.imp.pas}
 TGUIAppTester = {abstract} class(_GUIAppTester_)
  protected
   class function GetResultsPlaces: TResultsPlaces; virtual; abstract;
   class function MakeResults(const aPlaces: array of RTestResultsPlace): TResultsPlaces;
  public
   class function CalcBatchMode: Boolean; override;
 end;//TGUIAppTester
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 , TestFrameWork
 , l3BatchService
;

{$Include GUIAppTester.imp.pas}

class function TGUIAppTester.MakeResults(const aPlaces: array of RTestResultsPlace): TResultsPlaces;
//#UC START# *52F2651C00F4_52F255E702F0_var*
var
 l_Index : Integer;
//#UC END# *52F2651C00F4_52F255E702F0_var*
begin
//#UC START# *52F2651C00F4_52F255E702F0_impl*
 SetLength(Result, Length(aPlaces));
 for l_Index := 0 to Pred(Length(aPlaces)) do
  Result[l_Index] := aPlaces[l_Index];
//#UC END# *52F2651C00F4_52F255E702F0_impl*
end;//TGUIAppTester.MakeResults

class function TGUIAppTester.CalcBatchMode: Boolean;
//#UC START# *4F79BCC902C5_52F255E702F0_var*
//#UC END# *4F79BCC902C5_52F255E702F0_var*
begin
//#UC START# *4F79BCC902C5_52F255E702F0_impl*
 Result := KTestRunner.NeedKTestRunner(GetResultsPlaces);
//#UC END# *4F79BCC902C5_52F255E702F0_impl*
end;//TGUIAppTester.CalcBatchMode
{$IfEnd} // Defined(nsTest)

end.
