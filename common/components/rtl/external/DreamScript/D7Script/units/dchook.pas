{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dchook;

interface
{$I dc.inc}
{$D-,L-,Y-}

uses
  {$IFNDEF CLX}
  messages, windows,
  {$ENDIF}

  classes, sysutils, dcconsts,
  dcClasses;

type
  TFreeNotifyProc = procedure(Instance : TObject) of object;

procedure dcAddFreeNotification(Instance : TObject; Proc : TFreeNotifyProc);
procedure dcRemoveFreeNotification(Instance : TObject; Proc : TFreeNotifyProc);

type
  THookInfo = packed record
    ProcAddr : Pointer;
    OldSrc   : array[0..4] of byte;
  end;

procedure RestoreHook(const HookInfo : THookInfo);
function  SetupHook(Proc, NewProc : Pointer) : THookInfo;

{$IFNDEF CLX}
{$IFDEF WIN}
Type
  TCustomActiveNotifier = class(TComponent)
  private
    fOnActiveChanged : TNotifyEvent;
  protected
    procedure HookProc(const Msg : TCWPRetStruct);virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;

    property OnActiveChanged : TNotifyEvent read fOnActiveChanged write fOnActiveChanged;
  end;
{$ENDIF}
{$ENDIF}

{$IFDEF WIN}
{$IFNDEF CLX}
const
  CM_HOOKPROC  = WM_USER + 100;

procedure AddWndHook(o : TObject);
procedure RemoveWndHook(o : TObject);
{$ENDIF}
{$ENDIF}

implementation

{$IFDEF WIN}
{$IFNDEF CLX}
var
  WndHook : HHook=0;
  FWndHooks : TList;

function WndHooks : TList;
begin
  if fWndHooks = nil then
    fWndHooks := TList.Create;

  result := fWndHooks;
end;

{------------------------------------------------------------------}

function _CallWndProcHook(nCode : integer; wParam : Longint; var Msg : TCWPStruct) : longint; stdcall;
var
  i  : integer;
  _msg : TMessage;
begin
  Result := CallNextHookEx(WndHook, nCode, wParam, Longint(@Msg));
  if (nCode = HC_ACTION) then
    begin
      _msg.Msg := CM_HOOKPROC;
      _msg.wParam := integer(@Msg);
      _msg.Result := 0;

      if fWndHooks <> nil then
        for i := 0 to fWndHooks.Count - 1 do
          with TObject(fWndHooks[i]) do
            begin
              Dispatch(_msg);
              if _msg.Result <> 0 then
                exit;
            end;
    end;
end;

{------------------------------------------------------------------}

procedure AddWndHook(o : TObject);
begin
  if WndHooks.Count = 0 then
    WndHook := SetWindowsHookEx(WH_CALLWNDPROC, @_CallWndProcHook, 0, GetCurrentThreadId);
  WndHooks.Add(o);
end;

{------------------------------------------------------------------}

procedure RemoveWndHook(o : TObject);
begin
  WndHooks.Remove(o);
  if WndHooks.Count = 0 then
    UnHookWindowsHookEx(WndHook);
end;
{$ENDIF}
{$ENDIF}
{******************************************************************}

Procedure RestoreHook(const HookInfo:THookInfo);
Begin
  If HookInfo.ProcAddr<>Nil Then
    WriteMemory(HookInfo.ProcAddr, @HookInfo.OldSrc[0], SizeOf(HookInfo.OldSrc));
End;

{---------------------------------------------------------}

Function CalcJmpOffset(Src,Dest:Pointer):Longint;
Begin
  Result:=Longint(Dest)-(Longint(Src)+5);
End;

{---------------------------------------------------------}

Function SetupHook(Proc,NewProc:Pointer):THookInfo;
Var
  NewSrc:Array[0..4] Of Byte;
Begin
  Integer((@Result.OldSrc[0])^):=Integer(Proc^);
  Result.OldSrc[4]:=Ord(PChar(Proc)[4]);
  NewSrc[0]:=$E9;
  Integer((@NewSrc[1])^):=CalcJmpOffset(Proc,NewProc);
  if WriteMemory(Proc,@NewSrc[0],SizeOf(NewSrc)) then
    Result.ProcAddr:=Proc
  Else
    Result.ProcAddr:=Nil;
End;

{---------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}
var
  WHook : HHook=0;
  Fhooks : TList;

function Hooks:TList;
begin
  if fHooks = nil then
    fHooks := TList.Create;
  result := fHooks;
end;

{------------------------------------------------------------------}

function CallWndProcHook(nCode : integer; wParam : Longint; var Msg : TCWPRetStruct) : longint; stdcall;
var
  i  : integer;
begin
  result := 0;
//  Result := CallNextHookEx(WHook, nCode, wParam, Longint(@Msg));
  if (nCode = HC_ACTION) and (Msg.Message = WM_SETFOCUS) then
    for i := 0 to hooks.Count - 1 do
      with TCustomActiveNotifier(hooks[i]) do
        HookProc(Msg);
end;

{------------------------------------------------------------------}

procedure AddHook(o : TCustomActiveNotifier);
begin
  if hooks.Count = 0 then
    WHook := SetWindowsHookEx(WH_CALLWNDPROCRET, @CallWndProcHook, 0, GetCurrentThreadId);
  hooks.Add(o);
end;

{------------------------------------------------------------------}

procedure RemoveHook(o : TCustomActiveNotifier);
begin
  hooks.Remove(o);
  if hooks.Count = 0 then
    UnHookWindowsHookEx(WHook);
end;

{------------------------------------------------------------------}

procedure FreeHook;
begin
  if WHook <> 0 then
    UnHookWindowsHookEx(WHook);

  FHooks.Free;
  fHooks := nil;
end;

{------------------------------------------------------------------}

constructor TCustomActiveNotifier.Create(AOwner : TComponent);
begin
  inherited;
  AddHook(self);
end;

{-----------------------------------------------------------}

destructor  TCustomActiveNotifier.Destroy;
begin
  RemoveHook(self);
  inherited;
end;

{-----------------------------------------------------------}

procedure TCustomActiveNotifier.HookProc(const Msg : TCWPRetStruct);
begin
  if Assigned(OnActiveChanged) then
    OnActiveChanged(self);
end;

{$ENDIF}
{$ENDIF}
{******************************************************************}

type
  TFreeNotifier = class
  public
    Proc : TFreeNotifyProc;
  end;

  TFreeNotifierInfo = class
  public
    Instance  : TObject;
    Notifiers : TList;
    OldDestroy : pointer;
    fDestroying : boolean;

    constructor Create(AInstance : TObject);
    destructor Destroy; override;
  end;

  TFreeNotifiersList = class(TCustomSortedList)
  protected
    function  CompareWithKey(Item, Key : pointer) : Integer; override;
    function  Compare(Item1, Item2: Pointer) : integer; override;
  public
    function  AddInfo(Instance : TObject; Proc : TFreeNotifyProc) : boolean;
    function  DeleteInfo(Instance : TObject; Proc : TFreeNotifyProc) : boolean;
    procedure RemoveInfo(P : Pointer);
  end;


  TNotifierStorage = class(TComponent)
  private
    FList : TFreeNotifiersList;
    procedure CheckIfEmpty;
  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Add(Component : TComponent; Proc : TFreeNotifyProc);
    function  Delete(Component : TComponent; Proc : TFreeNotifyProc) : boolean;
    procedure Remove(Component : TComponent);
    function  Find(P : Pointer) : boolean;
  end;

var
  FreeNotifiers  : TFreeNotifiersList;
  FNotifierStorage : TNotifierStorage = nil;

{------------------------------------------------------------------}

function NotifierStorage : TNotifierStorage;
begin
  if FNotifierStorage = nil then
    FNotifierStorage := TNotifierStorage.Create(nil);
  result := FNotifierStorage;
end;

{------------------------------------------------------------------}

function GetFreeNotifierInfo(List : TFreeNotifiersList; Instance : TObject) : TFreeNotifierInfo;
var
  i : integer;
begin
  result := pointer(List);
  if result = nil then
    exit;
  result := pointer(TFreeNotifiersList(result).Count);
  if integer(result) = 0 then
    exit;
  i := List.IndexOfKey(Instance);
  result := nil;
  if i >= 0 then
    result := TFreeNotifierInfo(List[i]);
end;

{------------------------------------------------------------------}

Function isMethodsEqual(Var A,B):Boolean;
begin
  Result:=(TMethod(A).Data=TMethod(b).Data) and (TMethod(A).Code=TMethod(B).Code);
end;

{******************************************************************}

function  TFreeNotifiersList.Compare(Item1, Item2: Pointer) : integer;
begin
  result := integer(TFreeNotifierInfo(Item1).Instance) - integer(TFreeNotifierInfo(Item2).Instance);
end;

{------------------------------------------------------------------}

function TFreeNotifiersList.CompareWithKey(Item, Key : pointer) : Integer;
begin
  result := integer(TFreeNotifierInfo(Item).Instance) - integer(Key);
end;

{------------------------------------------------------------------}

function  TFreeNotifiersList.AddInfo(Instance : TObject; Proc : TFreeNotifyProc) : boolean;
var
  info : TFreeNotifierInfo;
  fnotifier : TFreeNotifier;
begin
  info := GetFreeNotifierInfo(Self, Instance);
  result := info = nil;
  if result then
    begin
      info := TFreeNotifierInfo.Create(Instance);
      Self.Add(info);
    end;

  fnotifier := TFreeNotifier.Create;
  fnotifier.Proc := Proc;
  info.Notifiers.Add(fnotifier);
end;

{------------------------------------------------------------------}

function TFreeNotifiersList.DeleteInfo(Instance : TObject; Proc : TFreeNotifyProc) : boolean;
var
  info : TFreeNotifierInfo;
  i    : integer;
begin
  result := false;
  info := GetFreeNotifierInfo(Self, Instance);
  if info <> nil then
    with info do
      if not fDestroying then
        begin
          with Notifiers do
            for i := Count - 1 downto 0 do
              if (List[i] <> nil) and
                IsMethodsEqual(TFreeNotifier(List[i]).Proc, Proc) then
                  begin
                    TFreeNotifier(List[i]).Free;
                    Delete(i);
                  end;

          if Notifiers.Count = 0 then
            begin
  //            UnHookDestroy(Instance, OldDestroy);

              Self.Remove(info);
              Free;
              result := true;
            end;
    end;
end;

{------------------------------------------------------------------}

procedure TFreeNotifiersList.RemoveInfo(P : Pointer);
var
  info : TFreeNotifierInfo;
  i    : integer;
  n    : TFreeNotifier;
begin
  info := GetFreeNotifierInfo(Self, P);
  if info <> nil then
    with info do
      begin
        i := 0;

        Self.Remove(info);

//        Notifiers.Add(nil);

        while i < Notifiers.Count do
          begin
            n := Notifiers[i];
            if n <> nil then
              TFreeNotifier(Notifiers[i]).Proc(Instance);
            if n = Notifiers[i] then
              inc(i);
          end;

(*
        for i := 0 to Notifiers.Count - 2 do
          if Notifiers[i] <> nil then
            TFreeNotifier(Notifiers[i]).Proc(Instance);
*)
        Free;
      end;
end;

{******************************************************************}

constructor TFreeNotifierInfo.Create(AInstance : TObject);
begin
  inherited Create;
  Notifiers := TList.Create;
  Instance := AInstance;
end;

{------------------------------------------------------------------}

destructor TFreeNotifierInfo.Destroy;
var
  i : integer;
begin
  fDestroying := true;

  if Notifiers <> nil then
    with Notifiers do
      begin
        for i := 0 to Count - 1 do
          TObject(List[i]).Free;

        Free;
      end;

  inherited;
end;

{******************************************************************}

procedure dcAddFreeNotification(Instance : TObject; Proc : TFreeNotifyProc);
begin
  if Instance = nil then
    exit;

  if Instance is TComponent then
    NotifierStorage.Add(TComponent(Instance), Proc)
  else
  if FreeNotifiers <> nil then
    FreeNotifiers.AddInfo(Instance, Proc);
end;

{------------------------------------------------------------------}

procedure dcRemoveFreeNotification(Instance : TObject; Proc : TFreeNotifyProc);
begin
  if (FNotifierStorage <> nil) and FNotifierStorage.Delete(TComponent(Instance), Proc) then
    exit;

  if FreeNotifiers <> nil then
    FreeNotifiers.DeleteInfo(Instance, Proc);
end;

{------------------------------------------------------------------}

procedure FreeNotifiersList(var List : TFreeNotifiersList);
var
  item : TObject;
begin
  with List do
    begin
      while Count > 0 do
        begin
          item := Items[0];
          Delete(0);
          item.Free;
        end;
      Free;
    end;
  List := nil;
end;

{******************************************************************}

constructor TNotifierStorage.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FList :=  TFreeNotifiersList.Create;
end;

{------------------------------------------------------------------}

destructor TNotifierStorage.Destroy;
begin
  FNotifierStorage := nil;
  FreeNotifiersList(FList);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TNotifierStorage.Add(Component : TComponent; Proc : TFreeNotifyProc);
begin
  if FList.AddInfo(Component, Proc) then
    Component.FreeNotification(Self);
end;

{------------------------------------------------------------------}

function TNotifierStorage.Delete(Component : TComponent; Proc : TFreeNotifyProc) : boolean;
begin
  result := FList.DeleteInfo(Component, Proc);
  if result then
    begin
      {$IFDEF D5}
        Component.RemoveFreeNotification(Self);
      {$ENDIF}
      CheckIfEmpty;
    end;
end;

{------------------------------------------------------------------}

procedure TNotifierStorage.Remove(Component : TComponent);
begin
  {$IFDEF D5}
  Component.RemoveFreeNotification(Self);
  {$ENDIF}
  FList.RemoveInfo(Component);
  if FNotifierStorage = nil then
    exit;
  CheckIfEmpty;
end;

{------------------------------------------------------------------}

procedure TNotifierStorage.CheckIfEmpty;
begin
  if FList.Count = 0 then
    Free;
end;

{------------------------------------------------------------------}

function  TNotifierStorage.Find(P : Pointer) : boolean;
begin
  result := GetFreeNotifierInfo(FList, P) <> nil;
end;

{------------------------------------------------------------------}

procedure TNotifierStorage.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and Find(AComponent) then
    Remove(AComponent);
end;

{------------------------------------------------------------------}

var
  MManager : TMemoryManager;

function MFreeMem(P: Pointer): Integer;
begin
  result := MManager.FreeMem(P);
  if FreeNotifiers <> nil then
    FreeNotifiers.RemoveInfo(P);
end;

{------------------------------------------------------------------}

function MGetMem(Size: Integer): Pointer;
begin
  result := MManager.GetMem(Size);
end;

{------------------------------------------------------------------}

function MReallocMem (P: Pointer; Size: Integer): Pointer;
begin
  result := MManager.ReallocMem(P, Size);
end;

{------------------------------------------------------------------}

function getnotnil(p1, p2 : pointer) : pointer;
begin
  if p1 <> nil then
    result := p1
  else
    result := p2;
end;

{------------------------------------------------------------------}

const
  NewManager : TMemoryManager =
    ( GetMem : MGetMem;
      FreeMem : MFreeMem;
      ReallocMem : MReallocMem);
var
  OldMManager : TMemoryManager;

initialization
  FreeNotifiers := TFreeNotifiersList.Create;


  GetMemoryManager(OldMManager);
  SetMemoryManager(NewManager);

  with MManager do
    begin
      GetMem := getnotnil(@OldMManager.GetMem, @SysGetMem);
      FreeMem := getnotnil(@OldMManager.FreeMem, @SysFreeMem);
      ReallocMem := getnotnil(@OldMManager.ReallocMem, @SysReallocMem);
    end;



finalization
  {$IFDEF WIN}
  {$IFNDEF CLX}
  FreeHook;
  {$ENDIF}
  {$ENDIF}
  SetMemoryManager(OldMManager);
  FreeNotifiersList(FreeNotifiers);
  {$IFDEF WIN}
  {$IFNDEF CLX}
  FWndHooks.Free;
  fWndHooks := nil;
  {$ENDIF}
  {$ENDIF}
end.
