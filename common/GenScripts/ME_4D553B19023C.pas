unit evParaSplitter;

interface

uses
 l3IntfUses
 , evSearch
 , l3Variant
 , evTypes
 , nevTools
 , nevBase
;

type
 TevParaSplitter = class(TevBaseReplacer)
  {* [RequestLink:253668344] }
  procedure Create(const aGen: Ik2TagGenerator;
   anOptions: TevSearchOptionSet);
  function Make(const aGen: Ik2TagGenerator;
   anOptions: TevSearchOptionSet): IevReplacer;
  function ReplaceFunc(const aView: InevView;
   const Container: InevOp;
   const aBlock: InevRange): Boolean;
 end;//TevParaSplitter
 
implementation

uses
 l3ImplUses
;

end.
