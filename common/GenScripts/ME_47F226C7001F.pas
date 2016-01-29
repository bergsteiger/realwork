unit k2DocumentGenerator;

interface

uses
 l3IntfUses
 , k2BaseStackGenerator
 , l3Variant
;

type
 Tk2StackAtom = record
 end;//Tk2StackAtom
 
 Tk2DocumentGenerator = class(Tk2BaseStackGenerator)
  {* √енератор образа документа в оперативной пам€ти. }
  procedure DoStartAtom(var Atom: Tk2StackAtom);
  procedure DoFinishAtom(var anAtom: Tk2StackAtom);
  function DoBeforeFinishAtom(var Atom: Tk2StackAtom): Boolean;
  procedure DoAddAtom(const Atom: Tk2StackAtom;
   Prop: Integer;
   aSource: Tl3Variant);
  function AddChild(var aChild: Tk2StackAtom): Integer;
  function DeleteChild(const aChild: Tk2StackAtom): Boolean;
  function NeedPreAddChild(const aChild: Tk2StackAtom): Boolean;
 end;//Tk2DocumentGenerator
 
implementation

uses
 l3ImplUses
;

end.
