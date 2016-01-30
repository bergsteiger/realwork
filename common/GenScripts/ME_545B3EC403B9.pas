unit NOT_FINISHED_idComponent;

// Модуль: "w:\common\components\rtl\external\Indy\Source\System\NOT_FINISHED_idComponent.pas"
// Стереотип: "UtilityPack"

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
