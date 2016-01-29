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
{*                   OVCISEB.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcISEB;
  {-abstract incremental search edit control base class}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, ExtCtrls, Forms, Graphics, Menus, StdCtrls, SysUtils,
  OvcBase, OvcExcpt;

const
  DefAutoSearch    = True;
  DefCaseSensitive = False;
  DefKeyDelay      = 500;
  DefShowResults   = True;

type
  TOvcBaseISE = class(TCustomEdit)
  {.Z+}
  protected {private}
    {property variables}
    FAutoSearch    : Boolean;
    FCaseSensitive : Boolean;
    FController    : TOvcController;
    FKeyDelay      : Integer;
    FPreviousText  : string;
    FShowResults   : Boolean;

    {internal variables}
    isTimer       : Integer;         {timer-pool handle}

    {property methods}
    procedure SetAutoSearch(Value : Boolean);
    procedure SetController(Value : TOvcController);
    procedure SetKeyDelay(Value : Integer);

    {internal methods}
    procedure isTimerEvent(Sender : TObject; Handle : Integer;
                           Interval : Word; ElapsedTime : LongInt);

  protected
    procedure CreateWnd;
      override;
    procedure KeyUp(var Key : Word; Shift : TShiftState);
      override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;

  {protected properties}
    property AutoSearch : Boolean
      read FAutoSearch
      write SetAutoSearch
      default DefAutoSearch;

    property CaseSensitive : Boolean
      read FCaseSensitive
      write FCaseSensitive
      default DefCaseSensitive;

    property Controller : TOvcController
      read FController
      write SetController;

    property KeyDelay : Integer
      read FKeyDelay
      write SetKeyDelay
      default DefKeyDelay;

    property ShowResults : Boolean
      read FShowResults
      write FShowResults
      default DefShowResults;

  public
    constructor Create(AOwner: TComponent);
      override;
    destructor Destroy;
      override;

    property PreviousText : string
      read FPreviousText
      write FPreviousText;

    function ISUpperCase(const S : string) : string;
      {return the UpperCase(S) if not CaseSensitive}
  {.Z-}

    {public methods}
    procedure PerformSearch;
      virtual; abstract;
      {search for Text}
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcBaseISE ***}

constructor TOvcBaseISE.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  if (csDesigning in ComponentState) then
    Text := Name
  else
    Text := '';

  {initialize property variables}
  FAutoSearch    := DefAutoSearch;
  FCaseSensitive := DefCaseSensitive;
  FKeyDelay      := DefKeyDelay;
  FShowResults   := DefShowResults;

  isTimer := -1;
end;

procedure TOvcBaseISE.CreateWnd;
var
  OurForm : TForm;
  {$IFDEF TRIALRUN}
    X : Integer;
  {$ENDIF}
begin
  OurForm := GetImmediateParentForm(Self);

  {do this only when the component is first dropped on the form, not during loading}
  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    ResolveController(OurForm, FController);

  if not Assigned(FController) and not (csLoading in ComponentState) then begin
    {try to find a controller on this form that we can use}
    FController := FindController(OurForm);

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

destructor TOvcBaseISE.Destroy;
begin
  if Assigned(FController) and (isTimer > -1) then begin
    FController.TimerPool.Remove(isTimer);
    isTimer := -1;
  end;

  inherited Destroy;
end;

procedure TOvcBaseISE.isTimerEvent(Sender : TObject;
          Handle : Integer; Interval : Word; ElapsedTime : LongInt);
begin
  {perform a search if modified}
  if Modified then begin
    Modified := False;
    isTimer := -1;
    PerformSearch;
  end;
end;

function TOvcBaseISE.ISUpperCase(const S : string) : string;
  {return the UpperCase(S) if not CaseSensitive}
begin
  if not CaseSensitive then
    Result := UpperCase(S)
  else
    Result := S;
end;

procedure TOvcBaseISE.KeyUp(var Key : Word; Shift : TShiftState);
var
  DoIt : Boolean;
begin
  DoIt := True;
  if (ISUpperCase(Text) = PreviousText) then
    DoIt := False;

  inherited KeyUp(Key, Shift);

  {start/reset timer}
  if AutoSearch and DoIt then begin
    {see if we need to reset our timer}
    if (isTimer > -1) then
      Controller.TimerPool.Remove(isTimer);
    isTimer := Controller.TimerPool.AddOneTime(isTimerEvent, FKeyDelay);
  end;

end;

procedure TOvcBaseISE.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (AComponent = FController) and (Operation = opRemove) then
    FController := nil
  else if (Operation = opInsert) and (FController = nil) and
          (AComponent is TOvcController) then
    FController := TOvcController(AComponent);
end;

procedure TOvcBaseISE.SetAutoSearch(Value : Boolean);
begin
  if (Value <> FAutoSearch) then begin
    FAutoSearch := Value;
    RecreateWnd;
  end;
end;

procedure TOvcBaseISE.SetController(Value : TOvcController);
begin
  FController := Value;
  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}
end;

procedure TOvcBaseISE.SetKeyDelay(Value : Integer);
begin
  if (Value <> FKeyDelay) and (Value >= 0) then begin
    FKeyDelay := Value;
  end;
end;


end.