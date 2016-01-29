unit l3ListenersManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3WndProcListenersList
 , l3CBTListenersList
 , l3GetMessageListenersList
 , Windows
 , l3WndProcRetListenersList
 , l3MouseListenersList
 , l3MouseWheelListenersList
 , l3Interfaces
;

type
 Tl3ListenersManager = class(Tl3ProtoObject)
  procedure AddCBTListener(const aListener: Il3CBTListener);
  procedure AddWndProcListener(const aListener: Il3WndProcListener);
  procedure AddGetMessageListener(const aListener: Il3GetMessageListener);
  procedure RemoveCBTListener(const aListener: Il3CBTListener);
  procedure RemoveWndProcListener(const aListener: Il3WndProcListener);
  procedure RemoveGetMessageListener(const aListener: Il3GetMessageListener);
  procedure UpdateHooks;
  procedure AddWndProcRetListener(const aListener: Il3WndProcRetListener);
  procedure RemoveWndProcRetListener(const aListener: Il3WndProcRetListener);
  procedure AddMouseListener(const aListener: Il3MouseListener);
  procedure RemoveMouseListener(const aListener: Il3MouseListener);
  procedure AddMouseWheelListener(const aListener: Il3MouseWheelListener);
  procedure RemoveMouseWheelListener(const aListener: Il3MouseWheelListener);
  procedure Add(const aListener: Il3Listener);
  procedure Remove(const aListener: Il3Listener);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3ListenersManager
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3ListenersHooks
;

end.
