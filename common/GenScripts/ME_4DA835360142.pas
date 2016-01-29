unit afwDockingInterfaces;

interface

uses
 l3IntfUses
 , Controls
;

type
 IafwDockableControl = interface
  function CanBeDockedInto(aControl: TWinControl): Boolean;
 end;//IafwDockableControl
 
 IafwControlDock = interface
  function GetDockControl(const aDockable: IafwDockableControl): TWinControl;
 end;//IafwControlDock
 
implementation

uses
 l3ImplUses
;

end.
