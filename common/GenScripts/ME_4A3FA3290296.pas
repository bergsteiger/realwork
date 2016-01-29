unit evDocumentPartCursor;

interface

uses
 l3IntfUses
 , evParaListCursor
 , nevTools
 , l3Types
 , l3IID
 , nevBase
 , l3Core
;

type
 TevDocumentPartCursor = class(TevParaListCursor)
  {* Курсор для блоков документа }
  function ExpandOrCollapse(const aView: InevControlView;
   aExpandMode: Tl3Bool): Boolean;
  procedure AfterCollapsed(const aView: InevControlView);
  function IsShowingDocumentParts(const aView: InevControlView): Boolean;
 end;//TevDocumentPartCursor
 
implementation

uses
 l3ImplUses
 , k2Tags
 , k2OpMisc
 , evOp
 , evdTypes
 , OvcConst
 , OvcCmd
 , evParaTools
;

end.
