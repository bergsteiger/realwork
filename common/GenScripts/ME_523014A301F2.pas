unit kwVcmOpEnabled;

interface

uses
 l3IntfUses
 , kwOperationParamWord
 , vcmExternalInterfaces
;

type
 TkwVcmOpEnabled = class(TkwOperationParamWord)
  function Flag: TvcmOpFlag;
 end;//TkwVcmOpEnabled
 
implementation

uses
 l3ImplUses
;

end.
