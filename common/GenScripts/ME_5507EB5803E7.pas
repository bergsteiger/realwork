unit l3AFWExceptions;

interface

uses
 l3IntfUses
 , SysUtils
;

type
 El3TryEnterModalState = class(Exception)
 end;//El3TryEnterModalState
 
implementation

uses
 l3ImplUses
;

end.
