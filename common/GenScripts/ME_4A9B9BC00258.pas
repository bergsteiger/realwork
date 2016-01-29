unit vtFocusLabel;

interface

uses
 l3IntfUses
;

type
 TvtFocusLabel = class
  function NeedUnderLine: Boolean;
  function AllowClickByKeyBoard: Boolean;
  function AllowTranslateReturn: Boolean;
 end;//TvtFocusLabel
 
implementation

uses
 l3ImplUses
;

end.
