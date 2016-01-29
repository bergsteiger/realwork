unit csDecisionPhrasesHelper;

interface

uses
 l3IntfUses
 , evdTasksHelpers
 , CourtDecisionPhrase_Const
 , Classes
 , l3Variant
;

type
 DecisionPhrasesHelper = interface(StringListHelper)
 end;//DecisionPhrasesHelper
 
 TDecisionPhrasesHelper = class(TAbstractStringListHelper, DecisionPhrasesHelper)
  function Make(aValue: Tl3Tag): DecisionPhrasesHelper;
  procedure DoAdd(const anItem: AnsiString);
  function DoGetStrings(anIndex: Integer): AnsiString;
 end;//TDecisionPhrasesHelper
 
implementation

uses
 l3ImplUses
;

end.
