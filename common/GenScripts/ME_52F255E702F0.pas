unit GUIAppTester;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , KTestRunner
;

type
 TResultsPlaces = array of RTestResultsPlace;
 
 TGUIAppTester = class(Tl3ProtoObject)
  function GetResultsPlaces: TResultsPlaces;
  function MakeResults(const aPlaces: array of RTestResultsPlace): TResultsPlaces;
  function CalcBatchMode: Boolean;
 end;//TGUIAppTester
 
implementation

uses
 l3ImplUses
 , tfwScriptEngineEX
 , l3Base
 , Forms
 , afwAnswer
 , TestFrameWork
 , l3BatchService
;

end.
