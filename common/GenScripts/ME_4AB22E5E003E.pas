unit vcmApplicationRef;

interface

uses
 l3IntfUses
 , vcmApplication
;

type
 TvcmApplicationRef = class(TvcmApplication)
  {* Хак для подключения сгенерированных модулей }
 end;//TvcmApplicationRef
 
implementation

uses
 l3ImplUses
;

end.
