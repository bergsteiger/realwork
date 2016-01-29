unit GUIAppTester;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Shared Delphi Tests Common"
// Модуль: "w:/common/components/rtl/Garant/Shared_Delphi_Tests_Common/GUIAppTester.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::Shared Delphi Tests Common::Tests Res Common::TGUIAppTester
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(nsTest)}
uses
  l3ProtoObject
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  GUITestRunner
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  tfwScriptDebugger
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TResultsPlaces = array of RTestResultsPlace;

 _GUIAppTester_Parent_ = Tl3ProtoObject;
 {$Include ..\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}
 TGUIAppTester = {abstract} class(_GUIAppTester_)
 public
 // realized methods
   class function CalcBatchMode: Boolean; override;
 protected
 // protected methods
   class function GetResultsPlaces: TResultsPlaces; virtual; abstract;
   class function MakeResults(const aPlaces: array of RTestResultsPlace): TResultsPlaces;
 end;//TGUIAppTester
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX
  {$IfEnd} //not NoScripts
  ,
  l3Base
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  afwAnswer
  {$IfEnd} //not NoScripts
  ,
  TestFrameWork,
  l3BatchService
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

{$Include ..\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas}

// start class TGUIAppTester

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

{$IfEnd} //nsTest

end.