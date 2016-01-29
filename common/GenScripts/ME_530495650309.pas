unit nscFormWithArrangeGrid.imp;

interface

uses
 l3IntfUses
 , nscInterfaces
 , Controls
;

type
 _nscFormWithArrangeGrid_ = class(MvcmEntityForm)
  procedure BuildGrid;
  procedure ArrangeGrid;
  procedure RecalcGrid;
  function GridParentControl: TWinControl;
  function DoBuildGrid: InscArrangeGrid;
  procedure DoRecalcGrid(const aGrid: InscArrangeGrid);
  procedure GridSizeChanged(aSender: TObject);
  procedure GridParentControlResize(aSender: TObject);
 end;//_nscFormWithArrangeGrid_
 
implementation

uses
 l3ImplUses
 , nscArrangeGrid
;

type
 THackControl = class(TControl)
 end;//THackControl
 
end.
