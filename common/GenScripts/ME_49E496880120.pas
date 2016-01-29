unit evdBufferedFilter;

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdCustomBufferedFilter = class(Tk2TagFilter)
  function NeedFlushBuffer(aLeaf: Tl3Variant;
   aTagId: Integer): Boolean;
  procedure DoFlushBuffer(aLeaf: Tl3Variant;
   aTagId: Integer;
   aNeedCloseBracket: Boolean);
  function NeedStartBuffering(aID: Integer): Boolean;
 end;//TevdCustomBufferedFilter
 
 TevdBufferedFilter = class(TevdCustomBufferedFilter)
  procedure DoFlushBuffer(aLeaf: Tl3Variant;
   aTagId: Integer;
   aNeedCloseBracket: Boolean);
 end;//TevdBufferedFilter
 
 TevdChildBufferedFilter = class(TevdBufferedFilter)
 end;//TevdChildBufferedFilter
 
 TevdCustomChildBufferedFilter = class(TevdBufferedFilter)
 end;//TevdCustomChildBufferedFilter
 
 TevdTagBufferedFilter = class(TevdBufferedFilter)
 end;//TevdTagBufferedFilter
 
implementation

uses
 l3ImplUses
;

end.
