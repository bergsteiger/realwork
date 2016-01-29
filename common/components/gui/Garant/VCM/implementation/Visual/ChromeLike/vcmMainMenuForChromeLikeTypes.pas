unit vcmMainMenuForChromeLikeTypes;

interface
uses
 Types,
 Messages,
 Menus,
 Windows;
 
type
 TvcmMenuShowingResult = (vcm_msrNone,             // не задано
                          vcm_msrClosed,           // текущее меню закрылось
                          vcm_msrClosedRecursive,  // закрылось все меню полностью
                          vcm_msrExecuted,         // выполнен Click на TMenuItem
                          vcm_msrSiblingSelected); // выбран другой пункт меню

 PvcmMenuForChromeLikeItem = ^TvcmMenuForChromeLikeItem;
 TvcmMenuForChromeLikeItem = {$IfDef XE4}record{$Else}object{$EndIf}
 (* - Пункт главного меню *)
 public
  rItem: TMenuItem;
  (* - собственно пункт меню *)
  rRect: TRect;
  (* - размеченный прямоугольник для отображения в окне меню *)
 public
  function EQ(const anOther: TvcmMenuForChromeLikeItem): Boolean;
  function IsNull: Boolean;
  function Intersects(const aPoint: TPoint): Boolean;
 end;

 function TvcmMenuForChromeLikeItem_C(aMenuItem: TMenuItem): TvcmMenuForChromeLikeItem;


type
 IvcmMenuForChromeLikeCommand = Interface(IUnknown)
 ['{EF8B51CD-4F78-4F10-8955-827B02E284E6}']
  procedure Execute;
 end;

 function MakeClickMenuItemCommand(aMenuItem: TMenuItem): IvcmMenuForChromeLikeCommand;
 (* - создает команду для выполнения клика по TMenuItem *)
 function MakeDispatchMessageCommand(const aMessage: TMsg): IvcmMenuForChromeLikeCommand;
 (* - создает команду для направления сообщения в wndproc *)

const
 cNullMenuForChromeLikeItem: TvcmMenuForChromeLikeItem = (
  rItem: nil;
  rRect: (Left: 0; Top: 0; Right: 0; Bottom: 0)
 );
 (* - "пустой" NULL-пункт меню *)

 vcm_msgChromeLikeMenuFirst  = WM_USER + 10;
 vcm_msgShowMenu             = vcm_msgChromeLikeMenuFirst + 1;
 vcm_msgMenuOpened           = vcm_msgShowMenu + 1;
 vcm_msgMenuClosed           = vcm_msgMenuOpened + 1;
 vcm_msgClickMenuItem        = vcm_msgMenuClosed + 1;
 vcm_msgShowSubmenu          = vcm_msgClickMenuItem + 1;
 vcm_msgCloseAndDispatch     = vcm_msgShowSubmenu + 1;
 vcm_msgUpdateItemsRequested = vcm_msgCloseAndDispatch + 1;

implementation
uses
 SysUtils,
 l3Core,
 l3Base,
 l3ProtoObject,
 Controls;

function TvcmMenuForChromeLikeItem.EQ(const anOther: TvcmMenuForChromeLikeItem): Boolean;
begin
 Result := (rItem = anOther.rItem);
end;

function TvcmMenuForChromeLikeItem.IsNull: Boolean;
begin
 Result := EQ(cNullMenuForChromeLikeItem);
end;

function TvcmMenuForChromeLikeItem.Intersects(const aPoint: TPoint): Boolean;
begin
 Result := PtInRect(rRect, aPoint);
end;

function TvcmMenuForChromeLikeItem_C(aMenuItem: TMenuItem): TvcmMenuForChromeLikeItem;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 Result.rItem := aMenuItem;
end;

type
 TvcmBaseMenuForChromeLikeCommand = class(Tl3ProtoObject,
                                          IvcmMenuForChromeLikeCommand)
 protected
  procedure DoExecute;
   virtual; abstract;
  {-}
  procedure Execute;
  {-}
 end;

procedure TvcmBaseMenuForChromeLikeCommand.Execute;
begin
 DoExecute;
end;

type
 TvcmClickMenuItemCommand = class(TvcmBaseMenuForChromeLikeCommand)
 private
  f_MenuItem: TMenuItem;
  constructor Create(aMenuItem: TMenuItem);
 protected
  procedure DoExecute;
   override;
  {-}
 public
  class function Make(aMenuItem: TMenuItem): IvcmMenuForChromeLikeCommand;
  {-}
 end;

constructor TvcmClickMenuItemCommand.Create(aMenuItem: TMenuItem);
begin
 inherited Create;
 f_MenuItem := aMenuItem;
end;

procedure TvcmClickMenuItemCommand.DoExecute;
begin
 f_MenuItem.Click;
end;

class function TvcmClickMenuItemCommand.Make(aMenuItem: TMenuItem): IvcmMenuForChromeLikeCommand;
var
 l_Inst: TvcmClickMenuItemCommand;
begin
 Assert(aMenuItem <> nil);
 l_Inst := Create(aMenuItem);
 try
  Result := l_Inst;
 finally
  FreeAndNil(l_Inst);
 end;
end;

function MakeClickMenuItemCommand(aMenuItem: TMenuItem): IvcmMenuForChromeLikeCommand;
begin
 Result := TvcmClickMenuItemCommand.Make(aMenuItem);
end;

type
 TvcmDispatchMessageCommand = class(TvcmBaseMenuForChromeLikeCommand)
 private
  f_Message: TMsg;
  constructor Create(const aMessage: TMsg);
 protected
  procedure DoExecute;
   override;
  {-}
 public
  class function Make(const aMessage: TMsg): IvcmMenuForChromeLikeCommand;
  {-}
 end;

constructor TvcmDispatchMessageCommand.Create(const aMessage: TMsg);
begin
 inherited Create;
 f_Message := aMessage;
end;

procedure TvcmDispatchMessageCommand.DoExecute;
begin
 DispatchMessage(f_Message);
end;

class function TvcmDispatchMessageCommand.Make(const aMessage: TMsg): IvcmMenuForChromeLikeCommand;
var
 l_Inst: TvcmDispatchMessageCommand;
begin
 l_Inst := Create(aMessage);
 try
  Result := l_Inst;
 finally
  FreeAndNil(l_Inst);
 end;
end;

function MakeDispatchMessageCommand(const aMessage: TMsg): IvcmMenuForChromeLikeCommand;
begin
 Result := TvcmDispatchMessageCommand.Make(aMessage);
end;

end.
