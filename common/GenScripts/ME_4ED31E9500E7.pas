unit evTableColumnHotSpot;

interface

uses
 l3IntfUses
 , evColumnBorderMarker
 , nevGUIInterfaces
 , l3Variant
 , nevBase
 , nevTools
 , l3Interfaces
 , afwInterfaces
;

type
 RevTableColumnHotSpot = class of TevTableColumnHotSpot;
 
 TevTableColumnHotSpot = class(TevColumnBorderMarker, IevAdvancedHotSpot, IevHotSpotDelta)
  {* реализует интерфейс IevHotSpot дл€ колонки таблицы. }
  function ProportionalChangeWidth(aTable: Tl3Variant;
   aDelta: Integer;
   const anOpPack: InevOp): Boolean;
  procedure ChangeCellWidth(const aView: InevControlView;
   const aProcessor: InevProcessor;
   const anOpPack: InevOp;
   const Keys: TevMouseState;
   const aRow: InevParaList;
   aDelta: Integer);
  function CanChangeTable(const aView: InevControlView;
   aPara: Tl3Variant): Boolean;
  procedure Create(const aView: InevControlView;
   aPara: Tl3Variant;
   aColumnID: Integer;
   const aHint: Il3CString;
   aDelta: Integer);
  function Make(const aView: InevControlView;
   aPara: Tl3Variant;
   aColumnID: Integer;
   const aHint: Il3CString;
   aDelta: Integer): IevAdvancedHotSpot;
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* обрабатывает событие от мыши. ¬озвращает true - если обработано, иначе - false }
  function Delta: Integer;
   {* точность }
  function CanDrag: Boolean;
 end;//TevTableColumnHotSpot
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Math
 , evdTypes
 , Classes
 , SysUtils
 , evInternalInterfaces
 , evParaTools
 , CommentPara_Const
 , l3Base
 , evEditorInterfaces
 , l3InterfacesMisc
 , nevInterfaces
 , evTableCellUtils
 , k2OpMisc
 , evMsgCode
 , l3IID
;

end.
