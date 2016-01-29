{*********************************************************}
{*                   STDROP.PAS 3.01                     *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}

unit StDrop;

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  Windows, Forms, Classes, Controls, Messages, ShellApi,
  StBase, StConst;

{$Z+}
type

  TStDropFilesEvent = procedure(Sender : TObject;
                                Point : TPoint) of object;

  TStCustomDropFiles = class(TStComponent)
  protected {private}
    {property variables}
    FActive           : Boolean;
    FCount            : Integer;
    FDropTarget       : TWinControl;
    FFiles            : TStrings;
    FTargetStringList : TStrings;

    {event variables}
    FOnDropFiles : TStDropFilesEvent;

    {internal variables}
    NewWndProc  : TFarProc;
    PrevWndProc : TFarProc;

    procedure TargetWndProc(var Msg : TMessage);
    procedure SetDropTarget(const Value: TWinControl);
    procedure SetActive(const Value: Boolean);

    procedure HookTarget;
    procedure UnhookTarget;
  protected
{$Z-}
    {properties}
    property Active : Boolean
      read FActive write SetActive default True;

    property Count : Integer
      read FCount;

    property DropTarget : TWinControl
      read FDropTarget write SetDropTarget;

    property Files : TStrings
      read FFiles;

    property TargetStringList : TStrings
      read FTargetStringList write FTargetStringList;

    {events}
    property OnDropFiles : TStDropFilesEvent
      read FOnDropFiles write FOnDropFiles;

    {methods}
    procedure DoDropFiles(Point : TPoint);

  public
{$Z+}
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
{$Z-}
  end;

  TStDropFiles = class(TStCustomDropFiles)
  public
    {properties}
    property Count;
    property Files;
    property TargetStringList;

  published
    {properties}
    property DropTarget;
    property Active;

    {events}
    property OnDropFiles;
  end;

implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  SysUtils,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

constructor TStCustomDropFiles.Create(AOwner: TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  FActive := True;
  FFiles  := TStringList.Create;
  if AOwner is TWinControl then
    if (csDesigning in ComponentState) then
      FDropTarget := AOwner as TWinControl;
end;

destructor TStCustomDropFiles.Destroy;
begin
  UnhookTarget;
  FFiles.Free;
  inherited Destroy;
end;

procedure TStCustomDropFiles.DoDropFiles(Point : TPoint);
begin
  if Assigned(OnDropFiles) then
    OnDropFiles(Self, Point);
end;

procedure TStCustomDropFiles.HookTarget;
begin
  if not Assigned(NewWndProc) and Assigned(FDropTarget) then begin
    NewWndProc := MakeObjectInstance(TargetWndProc);
    PrevWndProc:= Pointer(
      SetWindowLong(FDropTarget.Handle, GWL_WNDPROC, LongInt(NewWndProc)));
  end;
end;

procedure TStCustomDropFiles.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then begin
    if FDropTarget = nil then
      SetDropTarget(Owner as TWinControl);
    if FActive then
      SetActive(True);
  end;
end;

procedure TStCustomDropFiles.Notification(AComponent: TComponent;
                                          Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (DropTarget = AComponent) and (Operation = opRemove) and
      not (csDestroying in ComponentState) then
    DropTarget := nil;
end;

procedure TStCustomDropFiles.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if not (csDesigning in ComponentState) then                          
    DragAcceptFiles(FDropTarget.Handle, Value);
end;

procedure TStCustomDropFiles.SetDropTarget(const Value: TWinControl);
var
  OldTarget : TWinControl;
begin
  if (Value <> nil) and (not (Value is TWinControl)) then
    RaiseStError(EStDropFilesError, stscBadDropTarget);
  if not (csDesigning in ComponentState) then begin
    UnhookTarget;
    OldTarget := FDropTarget;
    FDropTarget := Value;
    HookTarget;
    if Assigned(OldTarget) then
      { Remove the previous drop target. }
      DragAcceptFiles(OldTarget.Handle, False);
    { Set new drop target. }
    DragAcceptFiles(FDropTarget.Handle, FActive);
  end else
    if Value <> nil then
      FDropTarget := Value
    else
      FDropTarget := Owner as TWinControl;
end;

procedure TStCustomDropFiles.TargetWndProc(var Msg : TMessage);
var
  DropHandle : Integer;
  I          : Integer;
  Buff       : array [0..MAX_PATH - 1] of Char;
  Point      : TPoint;
begin
  with Msg do begin
    if (Msg = WM_DROPFILES) then begin
      DropHandle := wParam;
      FCount := DragQueryFile(DropHandle, Cardinal(-1), nil, 0);
      if FCount > 0 then begin
        FFiles.Clear;
        for I := 0 to Pred(FCount) do begin
          DragQueryFile(DropHandle, I, Buff, SizeOf(Buff));
          FFiles.Add(Buff);
        end;
        DragQueryPoint(DropHandle, Point);
        if Assigned(FTargetStringList) then
          FTargetStringList.Assign(FFiles);
        DoDropFiles(Point);
        DragFinish(DropHandle);
        Exit;                                                          
      end;
    end;
    if Assigned(PrevWndProc) then
      Result := CallWindowProc(PrevWndProc,
        FDropTarget.Handle, Msg, wParam, lParam);
  end;
end;

procedure TStCustomDropFiles.UnhookTarget;
begin
  {restore old wnd proc}
  if Assigned(NewWndProc) then begin
    if Assigned(PrevWndProc) and
      not (csDestroying in ComponentState) then begin
        SetWindowLong(FDropTarget.Handle, GWL_WNDPROC, LongInt(PrevWndProc));
        PrevWndProc := nil;
    end;
    FreeObjectInstance(NewWndProc);
    NewWndProc := nil;
  end;
end;


end.