unit kwVcmOpVisible;

interface

uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpVisible = class(TkwOperationParamWord)
  function Flag: TvcmOpFlag;
 end;//TkwVcmOpVisible
 
implementation

uses
 l3ImplUses
;

end.
