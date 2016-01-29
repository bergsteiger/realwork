unit ctAbstractEdit;

interface

uses
 l3IntfUses
 , ctButtonEdit
;

type
 TctAbstractEdit = class(TctButtonEdit)
  procedure DeleteToClipboard;
  function CopyAllowed: Boolean;
  function CutAllowed: Boolean;
  function PasteAllowed: Boolean;
  function DeleteAllowed: Boolean;
 end;//TctAbstractEdit
 
implementation

uses
 l3ImplUses
 , Clipbrd
 , l3Interfaces
 , TtfwClassRef_Proxy
;

end.
