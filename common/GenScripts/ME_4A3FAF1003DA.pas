unit OvcCmd;

interface

uses
 l3IntfUses
;

type
 TUserCommandEvent = function(Sender: TObject;
  Command: Word): Boolean of object;
 
implementation

uses
 l3ImplUses
;

end.
