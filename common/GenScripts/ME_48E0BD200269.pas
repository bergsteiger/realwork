unit nevNullPara;

interface

uses
 l3IntfUses
 , nevParaPrim
 , nevTools
;

type
 TnevNullPara = class(TnevParaPrim)
  function Make: InevPara;
  procedure Create;
 end;//TnevNullPara
 
implementation

uses
 l3ImplUses
;

end.
