unit k2ProcessorTagTool;

interface

uses
 l3IntfUses
 , k2TagTool
 , k2PureMixIns
 , k2Interfaces
 , l3Variant
 , l3IID
;

type
 Tk2ProcessorTagTool = class(Tk2TagTool)
  procedure Create(aTag: Tl3Variant;
   const aProcessor: Ik2Processor);
  function GetProcessor: Ik2Processor;
  function StartOp(OpCode: Integer;
   DoLock: Boolean): Ik2Op;
  function Make(aTag: Tl3Variant;
   const aProcessor: Ik2Processor): Ik2TagTool;
  function Processor: Ik2Processor;
 end;//Tk2ProcessorTagTool
 
implementation

uses
 l3ImplUses
;

end.
