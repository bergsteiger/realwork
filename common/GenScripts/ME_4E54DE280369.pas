unit ScrollAndLinesTest;

interface

uses
 l3IntfUses
 , LinesTest
 , PrimTextLoad_Form
;

type
 TScrollAndLinesTest = class(TLinesTest)
  procedure DoScroll(aForm: TPrimTextLoadForm);
  function GetScrollCount: Integer;
 end;//TScrollAndLinesTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
