unit NOT_FINISHED_OvcCmd;

// Модуль: "w:\common\components\rtl\external\Orpheus\NOT_FINISHED_OvcCmd.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\external\Orpheus\OVC.INC}

interface

uses
 l3IntfUses
;

const

type
 TUserCommandEvent = function(Sender: TObject;
  Command: Word): Boolean of object;

implementation

uses
 l3ImplUses
;

end.
