unit VCMWordsPack;

interface

uses
 l3IntfUses
;

implementation

uses
 l3ImplUses
 , kwVcmDispatcherLock
 , kwVcmDispatcherUnlock
 , kwVcmDispatcherBeginOp
 , kwVcmDispatcherEndOp
 , kwVcmHistoryGetBackCount
 , kwVcmHistoryGetBackItem
 , kwVcmHistoryGetForwardCount
 , kwVcmHistoryGetForwardItem
 , kwVcmOpEnabled
 , kwVcmOpVisible
 , kwVcmOpChecked
 , kwVcmOpDefault
 , kwVcmOpCaption
 , kwVcmOpHint
 , kwVcmOpImageIndex
 , kwVcmOpShortcut
 , kwVcmOpLongHint
 , RegisterVcmControls
 , kwVcmHistoryDeleteBackItem
 , kwVcmFindForm
 , kwVcmHistoryClear
 , kwVcmHistoryDeleteForwardItem
 , kwTryFocusOnForm
 , kwObjectCreate
 , kwVcmDispatcherLockInOp
 , kwVcmDispatcherUnlockInOp
 , tfwScriptingTypes
;

end.
