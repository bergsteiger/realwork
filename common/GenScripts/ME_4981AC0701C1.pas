unit ComObj;

interface

uses
 l3IntfUses
 , SysUtils
;

type
 EOleError = class(Exception)
  {* EOleError is the exception class for low-level OLE errors }
 end;//EOleError
 
 EOleSysError = class(EOleError)
  {* EOleSysError is the exception class for errors specific to the OLE IDispatch interface }
 end;//EOleSysError
 
implementation

uses
 l3ImplUses
;

end.
