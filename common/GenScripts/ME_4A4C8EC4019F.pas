unit evDocumentCursor;

interface

uses
 l3IntfUses
 , evParaListCursor
 , nevTools
 , l3IID
 , nevBase
;

type
 TevDocumentCursor = class(TevParaListCursor, InevLinkedPoint)
  function CanInsertParaOnMove: Boolean;
  procedure LinkListener(const aListener: InevPointListener);
  procedure UnlinkListener(const aListener: InevPointListener);
 end;//TevDocumentCursor
 
implementation

uses
 l3ImplUses
 , evMarker
 , evDocumentMarkers
 , nevInterfaces
 , k2Tags
 , TextPara_Const
 , evCursorTools
 , evOp
 , k2Base
 , evInternalInterfaces
 , Block_Const
;

end.
