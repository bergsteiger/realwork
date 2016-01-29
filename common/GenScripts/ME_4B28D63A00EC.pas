unit evCustomEditorWindowPrim;

interface

uses
 l3IntfUses
 , nevControl
 , Classes
 , evDef
 , Messages
 , nevTools
 , l3Core
 , Controls
 , k2Interfaces
;

type
 TevMakeExportFiltersEvent = procedure(aSelection: Boolean;
  aForExport: Boolean;
  var theGen: Ik2TagGenerator) of object;
 
 TevCustomEditorWindowPrim = class(TnevControl)
  function GetVScrollerHint(const anAnchor: InevBasePoint): AnsiString;
  function GetDocumentPartHint(const aPart: IevDocumentPart): AnsiString;
  function GetDocumentPartByPoint(const aPoint: InevBasePoint): IevDocumentPart;
  function NeedAlignMarksOnSingleClick: Boolean;
  procedure RecalcScreenCursor(const aPoint: TPoint;
   var theCursor: TCursor);
  procedure SetFocusViaMouse;
  function WantSoftEnter: Boolean;
  procedure DoAfterSetZoom;
  procedure WMMOUSEACTIVATE(var aMsg: TWMMouseActivate);
 end;//TevCustomEditorWindowPrim
 
implementation

uses
 l3ImplUses
 , Windows
 , TtfwClassRef_Proxy
 , evSchemaWordsPack
 , evParaWordsPack
 , EditorFromStackKeyWordsPack
 , EditorParaCoordsToScreenPack
 , l3String
 , evParaTools
 , Block_Const
 , Document_Const
 , k2Tags
;

end.
