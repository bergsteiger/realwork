unit idComponent;

interface

uses
 l3IntfUses
;

type
 TIdStatus = (
  hsResolving
  , hsConnecting
  , hsConnected
  , hsDisconnecting
  , hsDisconnected
  , hsStatusText
  , ftpTransfer
  , ftpReady
  , ftpAborted
 );//TIdStatus
 
 TIdStatusEvent = procedure(ASender: TObject;
  const AStatus: TIdStatus;
  const AStatusText: AnsiString) of object;
 
implementation

uses
 l3ImplUses
;

end.
