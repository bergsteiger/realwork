unit eeHotSpot;

interface

uses
 l3IntfUses
 , eeTagEditorTool
 , eeInterfaces
 , nevNavigation
 , l3Variant
 , eeInterfacesEx
 , l3IID
;

type
 TeeHotSpot = class(TeeTagEditorTool, IeeHotSpot)
  procedure Create(aTagWrap: Tl3Variant;
   const aDocument: IeeDocumentEx;
   const aHyperlink: IevHyperlink;
   aInSelection: Boolean;
   const aSub: IeeSub);
  procedure Make(aTagWrap: Tl3Variant;
   const aDocument: IeeDocumentEx;
   const aHyperlink: IevHyperlink;
   aInSelection: Boolean;
   const aSub: IeeSub);
  function Para: IeePara;
  function Hyperlink: IevHyperlink;
  function InSelection: Boolean;
  function Sub: IeeSub;
 end;//TeeHotSpot
 
implementation

uses
 l3ImplUses
 , l3String
 , eePara
 , SysUtils
;

end.
