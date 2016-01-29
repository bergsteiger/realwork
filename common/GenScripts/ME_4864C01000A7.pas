unit evMemoProcessor;

interface

uses
 l3IntfUses
 , evCustomEditorWindowProcessor
 , Classes
;

type
 TevMemoProcessor = class(TevCustomEditorWindowProcessor)
  procedure Create;
 end;//TevMemoProcessor
 
implementation

uses
 l3ImplUses
 , evCustomMemo
 , evDefaultContext
 , nevTools
;

end.
