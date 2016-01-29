unit vgRemindersLineManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vgRemindersLine
;

type
 TvgRemindersLineManager = class(Tl3ProtoObject)
  procedure AddLine(aLine: TvgRemindersLine);
  procedure RemoveLine(aLine: TvgRemindersLine);
  procedure ClosePopupForms;
  procedure CheckZOrder;
  procedure LockActivateProcessing;
  procedure UnlockActivateProcessing;
  procedure UpdateRemindersActions;
 end;//TvgRemindersLineManager
 
implementation

uses
 l3ImplUses
 , vgRemindersLineList
 , NewRemindersInterfaces
;

end.
