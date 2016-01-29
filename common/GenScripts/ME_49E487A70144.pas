unit k2TagFilter;

interface

uses
 l3IntfUses
 , k2TagTerminator
 , k2Base
 , l3Variant
;

type
 Tk2TagFilterOpenMode = (
 );//Tk2TagFilterOpenMode
 
 Tk2TagFilter = class(Tk2TagTerminator)
  function NeedTranslateChildToNextPrim(anOpenMode: Tk2TagFilterOpenMode): Boolean;
  procedure DoCloseStructure(NeedUndo: Boolean);
  procedure DoStartChild(TypeID: Tk2Type);
  procedure DoAddAtomEx(AtomIndex: Integer;
   const Value: Ik2Variant);
  function NeedTranslateChildToNext: Boolean;
 end;//Tk2TagFilter
 
implementation

uses
 l3ImplUses
;

end.
