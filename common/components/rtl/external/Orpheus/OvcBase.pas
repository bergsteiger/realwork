{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCBASE.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$IFDEF Win32}
  {$R OVCBASE.R32}
{$ELSE}
  {$R OVCBASE.R16}
{$ENDIF}

unit OvcBase;
  {-Base unit for Orpheus visual components}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Dialogs, Forms, Messages, StdCtrls, SysUtils,
  {$IFDEF NVBUG} LibIntf, {$ENDIF}
  l3Base,
  OvcCmd, OvcData, OvcConst, OvcExcpt, {OvcTimer, }STDate,
  l3InterfacedComponent
  ;

{$IFDEF NVBUG}
  {$IFDEF Win32}
  var
  {$ELSE}
  const
  {$ENDIF}
    ICompLib : TILibrary = nil;
{$ENDIF}

const
  DefEpoch        = 1900;
  DefErrorPending = False;
  DefInsertMode   = True;

type
  {event method types}
  TDataErrorEvent =
    procedure(Sender : TObject; ErrorCode : Word; const ErrorMsg : string)
    of object;
  TPostEditEvent =
    procedure(Sender : TObject; GainingControl : TWinControl)
    of object;
  TPreEditEvent =
    procedure(Sender : TObject; LosingControl : TWinControl)
    of object;
  TDelayNotifyEvent =                                                  {!!.12}
    procedure(Sender : TObject; NotifyCode : Word)                     {!!.12}
    of object;                                                         {!!.12}
  TIsSpecialControlEvent =                                             {!!.13}
    procedure(Sender : TObject; Control : TWinControl;                 {!!.13}
    var Special : Boolean)                                             {!!.13}
    of object;                                                         {!!.13}

type
  TOvcController = class(Tl3InterfacedComponent)
  {.Z+}
  protected {private}
    FBtnCancel     : TWinControl;           {ignore errors if the}     {!!.12}
    FBtnHelp       : TWinControl;           {focus is moving to}       {!!.12}
    FBtnRestore    : TWinControl;           {one of these}             {!!.12}
    FEntryCommands : TOvcCommandProcessor;  {command processor}
    FEpoch         : Integer;               {combined epoch year and cenury}
    FErrorPending  : Boolean;               {an error is pending for an ef}
    FErrorText     : string;                {text of last error}
    FHandle        : hWnd;                  {our window handle}
    FInsertMode    : Boolean;               {global insert mode flag}
//    FTimerPool     : TOvcTimerPool;         {general timer pool}       {!!.01}

    {events}
    FOnDelayNotify      : TDelayNotifyEvent;                           {!!.12}
    FOnError            : TDataErrorEvent;
    FOnIsSpecialControl : TIsSpecialControlEvent;                      {!!.13}
    FOnPostEdit         : TPostEditEvent;
    FOnPreEdit          : TPreEditEvent;
//    FOnTimerTrigger     : TTriggerEvent;                               {!!.01}

    {property methods}
    procedure SetEpoch(Value : Integer);
      {-set the epoch value--used by entry fields}
    function GetHandle : hWnd;
      {-return our window handle. create if necessary}
    function GetVersion : string;                                      {!!.13}
    procedure SetVersion(Value : string);                              {!!.13}

    {internal methods}
    procedure cWndProc(var Msg : TMessage);
      {-window procedure}

  protected
    procedure Notification(AComponent : TComponent; Operation: TOperation);
      override;
  {.Z-}

  public
    constructor Create(AOwner: TComponent);
      override;
    procedure Release;
      override;

  {.Z+}
    procedure DestroyHandle;
      {-destroy the window handle}

    {wrappers for event handlers}
    procedure DoOnPostEdit(Sender : TObject; GainingControl : TWinControl);
      {-call the method assigned to the OnPostEdit event}
    procedure DoOnPreEdit(Sender : TObject; LosingControl : TWinControl);
      {-call the method assigned to the OnPreEdit event}
//    procedure DoOnTimerTrigger(Sender : TObject; Handle : Integer;     {!!.01}
//                               Interval : Word; ElapsedTime : LongInt);
  {.Z-}
    procedure DelayNotify(Sender : TObject; NotifyCode : Word);        {!!.12}
      {-start the chain of events that will fire the OnDelayNotify event}
    procedure DoOnError(Sender : TObject; ErrorCode : Word; ErrorMsg : string);
      {-call the method assigned to the OnError event}

    function IsSpecialButton(H : hWnd) : Boolean;
      dynamic;
      {-return true if H is btnCancel, btnHelp, or btnRestore}
    procedure MarkAsUninitialized(Uninitialized : Boolean);
      {-mark all entry fields on form as uninitialized}
    function ValidateEntryFields : TComponent;
      {-ask each entry field to validate its contents. Return nil
        if no error, else return pointer to field with error}
    function ValidateEntryFieldsEx(ReportError, ChangeFocus : Boolean) : TComponent;
      {-ask each entry field to validate its contents. Return nil
        if no error, else return pointer to field with error.
        Conditionally move focus and report error}
    function ValidateTheseEntryFields(Fields : array of TComponent) : TComponent;
      {-ask the specified entry fields to validate their contents. Return nil
        if no error, else return pointer to field with error}

    property ErrorPending : Boolean
      read FErrorPending
      write FErrorPending
      default DefErrorPending;

    property ErrorText : string
      read FErrorText
      write FErrorText;

    property Handle : hWnd
      read GetHandle;

    property InsertMode : Boolean
      read FInsertMode
      write FInsertMode
      default DefInsertMode;

//    property TimerPool : TovcTimerPool                                 {!!.01}
//      read FTimerPool;

  published
    {properties}
    property BtnCancel  : TWinControl                                  {!!.12}
      read FBtnCancel
      write FBtnCancel
      stored True;

    property BtnHelp    : TWinControl                                  {!!.12}
      read FBtnHelp
      write FBtnHelp
      stored True;

    property BtnRestore : TWinControl                                  {!!.12}
      read FBtnRestore
      write FBtnRestore
      stored True;

    property EntryCommands : TOvcCommandProcessor
      read FEntryCommands
      write FEntryCommands
      stored True;

    property Epoch : Integer
      read FEpoch
      write SetEpoch
      default DefEpoch;

    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}

    {events}
    property OnError : TDataErrorEvent
      read FOnError
      write FOnError;

    property OnDelayNotify : TDelayNotifyEvent                         {!!.12}
      read FOnDelayNotify
      write FOnDelayNotify;

    {!!.13}
    property OnIsSpecialControl : TIsSpecialControlEvent
      read FOnIsSpecialControl
      write FOnIsSpecialControl;

    property OnPostEdit : TPostEditEvent
      read FOnPostEdit
      write FOnPostEdit;

    property OnPreEdit : TPreEditEvent
      read FOnPreEdit
      write FOnPreEdit;

//    property OnTimerTrigger : TTriggerEvent                            {!!.01}
//      read FOnTimerTrigger
//      write FOnTimerTrigger;

    property Tag;
  end;


type
  {base class for Orpheus components. Provides controller access}
  TOvcBase = class(TCustomControl)
  {.Z+}
  protected {private}
    FAfterEnter : TNotifyEvent;                                        {!!.12}
    FAfterExit  : TNotifyEvent;                                        {!!.12}
    FController : TOvcController;

    function ControllerAssigned : Boolean;
    function GetVersion : string;                                      {!!.13}
    procedure SetController(Value : TOvcController);
    function  GetController : TOvcController;                          {V}
    procedure SetVersion(Value : string);                              {!!.13}

    {private message methods}
    procedure OMAfterEnter(var Msg : TMessage);                        {!!.12}
      message om_AfterEnter;
    procedure OMAfterExit(var Msg : TMessage);                         {!!.12}
      message om_AfterExit;

    {windows message methods}
    procedure WMKillFocus(var Msg : TWMKillFocus);                     {!!.12}
      message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg : TWMSetFocus);                       {!!.12}
      message WM_SETFOCUS;

  protected
    procedure CreateWnd;
      override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;
  {.Z-}

  property AfterEnter : TNotifyEvent                                   {!!.12}
    read FAfterEnter
    write FAfterEnter;

  property AfterExit : TNotifyEvent                                    {!!.12}
    read FAfterExit
    write FAfterExit;

  public
    property Controller : TOvcController
      read  GetController
      write SetController;

  published                                                            {!!.13}
    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}
  end;

{$IFDEF NVBUG}
procedure CreateNVComponent(const ClassName : string);
{$ENDIF}
(*function FindController(aForm : TForm) : TOvcController;
  {-search for an existing controller component}*)
function GetDefController : TOvcController;
  {-}
function GetImmediateParentForm(Control : TControl) : TForm;
  {-return first form found while searching Parent}
(*procedure ResolveController(AForm : TForm; var AController : TOvcController);
  {-find or create a controller on this form}*)

implementation

uses
  {$IFDEF TRIALRUN} OrTrial, {$ENDIF}
  OvcTCmmn,                                                            {!!.01}
  OvcVer,                                                              {!!.13}
  OvcEf;

{$IFDEF TRIALRUN}
{$I ORTRIALF.INC}
{$ENDIF}

type
  TLocalEF = class(TOvcBaseEntryField);

{$IFDEF NVBUG}
procedure CreateNVComponent(const ClassName : string);
  {-use undocumented LibMain routines to create a non-visual component}
var
  I : Integer;
begin
  {ICompLib is assigned the value of LibMain.CompLib in OvcReg's Register method}
  if (ICompLib <> nil) then begin
    for I := 0 To ICompLib.GetCompClassCount-1 do
      if CompareText(ClassName, ICompLib.GetCompClass(I).GetClassName) = 0 then begin
        ICompLib.GetActiveForm.CreateComponent(ICompLib.GetCompClass(I));
        Exit;
      end;
  end;


end;
{$ENDIF}

function FindController(aForm : TForm) : TOvcController; {V}
    {-search for an existing controller component}
  {$IfNDef Nemesis}
  var
    I : Integer;
  {$EndIf  Nemesis}
  begin
   Result := nil;
   {$IfNDef Nemesis}
   If (aForm <> nil) then
    begin
     for I := 0 to aForm.ComponentCount-1 do
      begin
       if aForm.Components[I] is TOvcController then
        begin
         Result := TOvcController(aForm.Components[I]);
         Break;
        end;
      end;
    end;

   If (Result = nil) and not ((aForm <> nil) and (csDesigning in aForm.ComponentState)) then
    If (Application.MainForm <> aForm) AND (Application.MainForm <> nil) then
     for I := 0 to Application.MainForm.ComponentCount-1 do
      begin
       if Application.MainForm.Components[I] is TOvcController then
        begin
         Result := TOvcController(Application.MainForm.Components[I]);
         Break;
        end;
      end;
   {$EndIf Nemesis}
  end;

function GetImmediateParentForm(Control : TControl) : TForm;
  {return first form found while searching Parent}
var
  ParentCtrl : TControl;
begin
  ParentCtrl := Control.Parent;
  {!!.14} {added Delphi 3 test since ParentCtrl can be an active form}
  {$IFDEF VERSION3}                                                    {!!.16}
  while Assigned(ParentCtrl) and (not (ParentCtrl is TCustomForm)) do
  {$ELSE}
  while Assigned(ParentCtrl) and (not (ParentCtrl is TForm)) do
  {$ENDIF}
    ParentCtrl := ParentCtrl.Parent;
  Result := TForm(ParentCtrl);
end;

(*procedure ResolveController(AForm : TForm; var AController : TOvcController);
  {-find or create a controller on this form}
begin
  if not Assigned(AController) then begin
    {search for an existing controller. If not found,}
    {create the controller as a child of the form}
    {and assign it as our controller}
    AController := FindController(AForm);
    if not Assigned(AController) then begin
      {$IFDEF NVBUG}
      CreateNVComponent(TOvcController.ClassName);
      {find and assign controller}
      AController := FindController(AForm);
      {$ELSE}
      AController := TOvcController.Create(AForm);
      try
        AController.Name := 'OvcController1';
      except
        AController.Free;
        AController := nil;
        raise;
      end;
      {$ENDIF}
    end;
  end;
end;*)

var
 gDefController : TOvcController = nil;

procedure FreeController;
begin
 l3Free(gDefController);
end;

function GetDefController : TOvcController;
//var
// l_Controller : TOvcController;
begin
 if (gDefController = nil) then
 begin
  gDefController := TOvcController.Create(nil);
  l3System.AddExitProc(FreeController);
 end;//gDefController = nil
 Result := gDefController;
end;

{*** TOvcController ***}

constructor TOvcController.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {create the command processor}
  FEntryCommands := TOvcCommandProcessor.Create;

  FEpoch         := DefEpoch;
  FErrorPending  := DefErrorPending;
  FInsertMode    := DefInsertMode;

  {create the general use timer pool}
//  FTimerPool     := TOvcTimerPool.Create(Self);                        {!!.01}
//  FTimerPool.OnAllTriggers := DoOnTimerTrigger;                        {!!.01}
end;

{!!.17} {revised}
procedure TOvcController.cWndProc(var Msg : TMessage);
  {-window procedure}
var
  C : TWinControl;
begin
  C := TWinControl(Msg.lParam);
  with Msg do begin
    try
      case Msg of
        om_SetFocus :
          begin
            C.Show;
            if C.CanFocus then
              C.SetFocus;
          end;
        om_PreEdit :
          if Assigned(FOnPreEdit) then
            FOnPreEdit(TWinControl(lParam), FindControl(wParam));
        om_PostEdit :
          if Assigned(FOnPostEdit) then
            FOnPostEdit(TWinControl(lParam), FindControl(wParam));
        om_DelayNotify :
          if Assigned(FOnDelayNotify) then
            FOnDelayNotify(TObject(lParam), wParam);
      else
        Result := DefWindowProc(Handle, Msg, wParam, lParam);
      end;
    except
      Application.HandleException(Self);
    end;
  end;
end;

{!!.12}
procedure TOvcController.DelayNotify(Sender : TObject; NotifyCode : Word);
  {-start the chain of event that will fire the OnDelayNotify event}
begin
  if Assigned(FOnDelayNotify) then
    PostMessage(Handle, om_DelayNotify, NotifyCode, LongInt(Sender));
end;

procedure TOvcController.Release;
begin
  {destroy the command processor}
  FEntryCommands.Free;
  FEntryCommands := nil;

//  FTimerPool.Free;                                                     {!!.01}
//  FTimerPool := nil;                                                   {!!.01}

  {destroy window handle, if created}
  DestroyHandle;

  inherited;
end;

procedure TOvcController.DestroyHandle;
  {-destroy the window handle}
begin
  if FHandle <> 0 then
    DeallocateHWnd(FHandle);

  FHandle := 0;
end;

procedure TOvcController.DoOnError(Sender : TObject; ErrorCode : Word;
                         ErrorMsg : string);
  {-call the method assigned to the OnError event}
begin
  if Assigned(FOnError) then
    FOnError(Sender, ErrorCode, ErrorMsg)
  else
    MessageDlg(ErrorMsg, mtError, [mbOK], 0);
end;

{!!.12}
procedure TOvcController.DoOnPostEdit(Sender : TObject; GainingControl : TWinControl);
  {-call the method assigned to the OnPostEdit event}
var
  H : hWnd;
begin
  if Assigned(GainingControl) then
    H := GainingControl.Handle
  else
    H := 0;

  PostMessage(Handle, om_PostEdit, H, LongInt(Sender));
end;

{!!.12}
procedure TOvcController.DoOnPreEdit(Sender : TObject; LosingControl : TWinControl);
  {-call the method assigned to the OnPreEdit event}
var
  H : hWnd;
begin
  if Assigned(LosingControl) then
    H := LosingControl.Handle
  else
    H := 0;

  PostMessage(Handle, om_PreEdit, H, LongInt(Sender));
end;

{!!.01} {Added}
(*procedure TOvcController.DoOnTimerTrigger(Sender : TObject; Handle : Integer;
                         Interval : Word; ElapsedTime : LongInt);
begin
//  if Assigned(FOnTimerTrigger) then
//    FOnTimerTrigger(Sender, Handle, Interval, ElapsedTime);
end;*)

function TOvcController.GetHandle : hWnd;
  {create our window handle}
begin
  if FHandle = 0 then
    FHandle := AllocateHWnd(cWndProc);
  Result := FHandle;
end;

{!!.13}
function TOvcController.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

function TOvcController.IsSpecialButton(H : hWnd) : Boolean;
  {-return true if H is btnCancel, btnHelp, or btnRestore}
begin
  Result := Assigned(FBtnCancel) and (FbtnCancel.Handle = H) or
            Assigned(FBtnHelp) and (FBtnHelp.Handle = H) or
            Assigned(FBtnRestore) and (FBtnRestore.Handle = H);

  if not Result and Assigned(FOnIsSpecialControl) then                 {!!.13}
    FOnIsSpecialControl(Self, FindControl(H), Result);                 {!!.13}
end;

procedure TOvcController.MarkAsUninitialized(Uninitialized : Boolean);
  {-mark all entry fields on form as uninitialized}
var
  I  : Integer;

  procedure MarkField(C : TComponent);
  var
    J : Integer;
  begin
    {first, see if this component is an entry field}

    {!!.01} {revised}
    if C is TOvcBaseEntryField then begin
      if (TOvcBaseEntryField(C).Parent <> nil) then begin
        {don't set Uninitialized for entry fields parented by a table}
        if not (TOvcBaseEntryField(C).Parent is TOvcTableAncestor) then
          TOvcBaseEntryField(C).Uninitialized := Uninitialized;
      end else
        TOvcBaseEntryField(C).Uninitialized := Uninitialized;
    end;

    {recurse through all child components}
    for J := 0 to C.ComponentCount-1 do
      MarkField(C.Components[J]);
  end;

begin
  if Owner is TForm then
    with TForm(Owner) do
      for I := 0 to ComponentCount-1 do
        MarkField(Components[I]);
end;

procedure TOvcController.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if Operation = opRemove then begin
    if AComponent = FBtnCancel then
      FBtnCancel := nil;
    if AComponent = FBtnHelp then
      FBtnHelp := nil;
    if AComponent = FBtnRestore then
      FBtnRestore := nil;
  end;
end;

procedure TOvcController.SetEpoch(Value : Integer);
begin
  if Value <> FEpoch then
    if (Value >= MinYear) and (Value <= MaxYear) then
      FEpoch := Value;
end;

{!!.13}
procedure TOvcController.SetVersion(Value : string);
begin
end;

{!!.01} {revised}
function TOvcController.ValidateEntryFields : TComponent;
  {-ask each entry field to validate its contents. Return nil
    if no error, else return pointer to field with error}
begin
  {if error, report it and send focus to field with error}
  Result := ValidateEntryFieldsEx(True, True);
end;

{!!.01} {added}
function TOvcController.ValidateEntryFieldsEx(ReportError, ChangeFocus : Boolean) : TComponent;
  {-ask each entry field to validate its contents. Return nil
    if no error, else return pointer to field with error
    Conditionally move focus and report error}
var
  I  : Integer;

  procedure ValidateEF(C : TComponent);
  var
    J  : Integer;
    EF : TLocalEF absolute C;
  begin
    {see if this component is an entry field}
    if (C is TOvcBaseEntryField) then begin

      {don't validate invisible or disabled fields}                    {!!.14}
      if not EF.Visible or not EF.Enabled then                         {!!.14}
        Exit;                                                          {!!.14}

      {skip entry fields parented by a table}
      if (EF.Parent <> nil) and not (EF.Parent is TOvcTableAncestor) then begin
        {ask entry field to validate itself}
        if (EF.ValidateContents(False) <> 0) then begin
          {remember only the first invalid field found}
          if not Assigned(Result) then
            Result := EF;

          {tell the entry field to report the error}
          if ReportError and not ErrorPending then
            PostMessage(EF.Handle, om_ReportError, EF.LastError, 0);

          {ask the controller to give the focus back to this field}
          if ChangeFocus and not ErrorPending then begin
            PostMessage(Handle, om_SetFocus, 0, LongInt(EF));
            ErrorPending := True;
          end;

          {exit if we are reporting the error or changing the focus}
          if (ReportError or ChangeFocus) then
            Exit;
        end;
      end;
    end;

    {recurse through all child components}
    for J := 0 to C.ComponentCount-1 do begin
      ValidateEf(C.Components[J]);

      {exit if we've already found an error and should stop}
      if Assigned(Result) and (ReportError or ChangeFocus) then
        Break;
    end;
  end;

begin
  Result := nil;

  if Owner is TForm then
    with TForm(Owner) do
      for I := 0 to ComponentCount-1 do begin
        ValidateEf(Components[I]);

        {stop checking if reporting the error or changing focus}
        if Assigned(Result) and (ReportError or ChangeFocus) then
          Break ;
      end;
end;

{!!.01} {revised}
function TOvcController.ValidateTheseEntryFields(Fields : array of TComponent) : TComponent;
  {-ask the specified entry fields to validate their contents. Return nil
    if no error, else return pointer to field with error}
var
  I  : Integer;
  EF : TLocalEF;
begin
  Result := nil;

  for I := Low(Fields) to High(Fields) do begin
    if Fields[I] is TOvcBaseEntryField then begin                      {!!.12}
      EF := TLocalEF(Fields[I]);

      {ask entry field to validate itself}
      if (EF.ValidateContents(False) <> 0) then begin
        Result := EF;

        {tell the entry field to report the error}
        if not ErrorPending then
          PostMessage(EF.Handle, om_ReportError, EF.LastError, 0);

        {ask the controller to give the focus back to this field}
        if not ErrorPending then begin
          PostMessage(Handle, om_SetFocus, 0, LongInt(EF));
          ErrorPending := True;
        end;

        Exit;
      end;

    end;
  end;
end;


{*** TOvcBase ***}

function TOvcBase.ControllerAssigned : Boolean;
begin
  Result := Assigned(FController);
end;

Function TOvcBase.GetController : TOvcController;
 Begin
  If Assigned(FController)
   then Result := FController
   else
    Begin
     FController := FindController(GetImmediateParentForm(Self));
     if not Assigned(FController) then
      FController := GetDefController;
     if not Assigned(FController) and not (csDesigning in ComponentState) then
      raise ENoControllerAssigned.Create;
     Result := FController;
    end;
 end;

procedure TOvcBase.CreateWnd;
begin

  {do this only when the component is first dropped on the form, not during loading}
  {if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    ResolveController(OurForm, FController);}                                    {V}

  if not Assigned(FController) and not (csLoading in ComponentState) then begin
    {try to find a controller on this form that we can use}
    FController := GetController;

    {if not found and we are not designing, raise exception}
    if not Assigned(FController) and not (csDesigning in ComponentState) then
      raise ENoControllerAssigned.Create;
  end;

  inherited CreateWnd;

{$IFDEF TRIALRUN}
  X := _CC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
  X := _VC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
{$ENDIF}
end;

procedure TOvcBase.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (AComponent = FController) and (Operation = opRemove) then
    FController := nil
  else if (Operation = opInsert) and (FController = nil) and
          (AComponent is TOvcController) then
    FController := TOvcController(AComponent);
end;

{!!.12}
procedure TOvcBase.OMAfterEnter(var Msg : TMessage);
begin
  if Assigned(FAfterEnter) then
    FAfterEnter(Self);
end;

{!!.12}
procedure TOvcBase.OMAfterExit(var Msg : TMessage);
begin
  if Assigned(FAfterExit) then
    FAfterExit(Self);
end;

{!!.13}
function TOvcBase.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

procedure TOvcBase.SetController(Value : TOvcController);
begin
  FController := Value;
  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}
end;

{!!.13}
procedure TOvcBase.SetVersion(Value : string);
begin
end;

{!!.12}
procedure TOvcBase.WMKillFocus(var Msg : TWMKillFocus);
begin
  inherited;

  PostMessage(Handle, om_AfterExit, 0, 0);
end;

{!!.12}
procedure TOvcBase.WMSetFocus(var Msg : TWMSetFocus);
begin
  inherited;

  PostMessage(Handle, om_AfterEnter, 0, 0);
end;

end.
