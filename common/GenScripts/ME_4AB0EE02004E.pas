unit Dialogs;

interface

uses
 l3IntfUses
 , Classes
;

type
 TMsgDlgBtn = (
 );//TMsgDlgBtn
 
 TMsgDlgButtons = set of TMsgDlgBtn;
 
 TMsgDlgType = (
 );//TMsgDlgType
 
 TOpenOption = (
 );//TOpenOption
 
 TOpenOptions = set of TOpenOption;
 
 TCommonDialog = class(TComponent)
  procedure DoClose;
  procedure DoShow;
  function Execute: Boolean;
 end;//TCommonDialog
 
 TOpenDialog = class(TCommonDialog)
  function DoCanClose: Boolean;
  function Execute: Boolean;
 end;//TOpenDialog
 
 TSaveDialog = class(TOpenDialog)
 end;//TSaveDialog
 
implementation

uses
 l3ImplUses
;

end.
