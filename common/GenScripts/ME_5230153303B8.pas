unit kwVcmOpChecked;

interface

uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpChecked = class(TkwOperationParamWord)
  function Flag: TvcmOpFlag;
 end;//TkwVcmOpChecked
 
implementation

uses
 l3ImplUses
;

end.
