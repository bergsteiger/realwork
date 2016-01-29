unit kwVcmOpDefault;

interface

uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpDefault = class(TkwOperationParamWord)
  function Flag: TvcmOpFlag;
 end;//TkwVcmOpDefault
 
implementation

uses
 l3ImplUses
;

end.
