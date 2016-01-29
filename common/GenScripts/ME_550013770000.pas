unit l3PopupMenuHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Menus
 , Classes
 , Types
 , Controls
;

type
 Tl3PopupMenuHelperCallback = procedure(aMenu: TMenuItem) of object;
 
 (*
 Ml3PopupMenuHelper = interface
  {* Контракт сервиса Tl3PopupMenuHelper }
  function GetPopupMenu(aControl: TComponent;
   const aPoint: TPoint): TMenuItem;
  procedure GetPopupMenuForComponentInfo(aControl: TComponent;
   const aPoint: TPoint;
   aCallback: Tl3PopupMenuHelperCallback);
 end;//Ml3PopupMenuHelper
 *)
 
 Il3PopupMenuHelper = interface
  {* Интерфейс сервиса Tl3PopupMenuHelper }
  function GetPopupMenu(aControl: TComponent;
   const aPoint: TPoint): TMenuItem;
  procedure GetPopupMenuForComponentInfo(aControl: TComponent;
   const aPoint: TPoint;
   aCallback: Tl3PopupMenuHelperCallback);
 end;//Il3PopupMenuHelper
 
 Tl3PopupMenuHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetPopupMenu(aControl: TComponent;
   const aPoint: TPoint): TMenuItem;
  procedure GetPopupMenuForComponentInfo(aControl: TComponent;
   const aPoint: TPoint;
   aCallback: Tl3PopupMenuHelperCallback);
 end;//Tl3PopupMenuHelper
 
implementation

uses
 l3ImplUses
;

type
 TControlFriend = class(TControl)
  {* Друг для TControl }
 end;//TControlFriend
 
end.
