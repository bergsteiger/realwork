unit Printers;

interface

uses
 l3IntfUses
 , SysUtils
;

type
 EPrinter = class(Exception)
 end;//EPrinter
 
 TPrinter = class(TObject)
  {* TPrinter encapsulates the Windows printer interface. }
 end;//TPrinter
 
 TPrinterState = (
  psNoHandle
  , psHandleIC
  , psHandleDC
 );//TPrinterState
 
 TPrinterOrientation = (
  poPortrait
  , poLandscape
 );//TPrinterOrientation
 
 TPrinterCapability = (
  pcCopies
  , pcOrientation
  , pcCollation
 );//TPrinterCapability
 
 TPrinterCapabilities = set of TPrinterCapability;
 
implementation

uses
 l3ImplUses
;

end.
