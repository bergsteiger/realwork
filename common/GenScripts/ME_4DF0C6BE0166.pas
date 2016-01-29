unit k2TagByHandleView;

interface

uses
 l3IntfUses
 , k2CustomTagView
 , l3PureMixIns
;

type
 Tk2TagByHandleView = class(Tk2CustomTagView)
  function CompareData(const anItem1: _ItemType_;
   const anItem2: _ItemType_): Integer;
 end;//Tk2TagByHandleView
 
implementation

uses
 l3ImplUses
 , k2Tags
;

end.
