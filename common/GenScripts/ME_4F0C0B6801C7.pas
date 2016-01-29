unit DragData;

interface

uses
 l3IntfUses
 , Messages
 , Windows
 , l3Except
 , l3Base
 , l3Interfaces
 , Controls
 , Classes
;

type
 TDragDataState = (
  dsPassive
  , dsActive
  , dsPaused
 );//TDragDataState
 
 TGetCursorByType = function(DDType: Integer): HCURSOR;
 
 EDragInProcess = class(El3NoLoggedException)
  procedure Create;
 end;//EDragInProcess
 
 TDragDataSupport = class(Tl3Base, Il3WndProcListener, Il3WndProcRetListener, Il3MouseListener)
  procedure InitListeners;
  procedure RemoveListeners;
  function DoDrop(aDestControl: TControl): Boolean;
  function Execute(SrcControl: TControl): Boolean;
  procedure RunDragData(SrcControl: TControl);
  procedure Stop(aSuccess: Boolean);
  procedure Pause;
  procedure Restore;
  procedure CheckInProgress;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure MouseListenerNotify(aMouseMessage: WPARAM;
   aHookStruct: PMouseHookStruct;
   var theResult: Tl3HookProcResult);
  procedure WndProcListenerNotify(Msg: PCWPStruct;
   var theResult: Tl3HookProcResult);
  procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
   var theResult: Tl3HookProcResult);
 end;//TDragDataSupport
 
implementation

uses
 l3ImplUses
 , afwFacade
 , l3ListenersManager
 , Forms
 , kwVTControlsPack
;

end.
