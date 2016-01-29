{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.Bind.ObserverLinks;

interface

uses
  System.Classes, System.SysUtils, Data.Bind.Components;

type
  TBindObserver = class(TInterfacedObject, IObserver)
  private
    FBindLink: IBindLink;
    FOnToggle: TObserverToggleEvent;
  protected
    constructor Create(ABindLink: IBindLink); overload;
  public
    function GetOnObserverToggle: TObserverToggleEvent;
    procedure SetOnObserverToggle(AEvent: TObserverToggleEvent);
    procedure Removed;
    function GetActive: Boolean;
    procedure SetActive(Value: Boolean);
  end;

  TBindSingleCastObserver = class(TBindObserver, ISingleCastObserver)
  end;

  TBindMultiCastObserver = class(TBindObserver, IMultiCastObserver)
  end;

  TBindEditLinkObserver = class(TBindSingleCastObserver, IEditLinkObserver, IObserverTrack)
  private
    FTrack: Boolean;
  protected
    function GetTrack: Boolean;
  public
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetUpdating: Boolean;
    procedure Update;
    function Edit: Boolean;
    procedure Reset;
    procedure Modified;
    function IsModified: Boolean;
    function IsValidChar(AKey: Char): Boolean;
    function IsRequired: Boolean;
    function GetIsReadOnly: Boolean;
    procedure SetIsReadOnly(Value: Boolean);
    function GetIsEditing: Boolean;
    constructor Create(ABindLink: TCustomBindLink); overload;
    procedure SetTrack(AValue: Boolean);
  end;

  TBindEditGridLinkObserver = class(TBindEditLinkObserver, IEditGridLinkObserver)
  private
    FOnGetCurrent: TObserverGetCurrentEvent;
  public
    function GetCurrent: TVarRec;
    function GetOnObserverCurrent: TObserverGetCurrentEvent;
    procedure SetOnObserverCurrent(AEvent: TObserverGetCurrentEvent);
    constructor Create(ABindLink: TCustomBindGridLink); overload;
    constructor Create(ABindLink: TCustomBindListLink); overload;
    constructor Create(ABindLink: TCustomBindGridListLink); overload;
  end;

  TBindPositionLinkObserver = class(TBindMultiCastObserver, IPositionLinkObserver)
  private
    FBindPosition: IBindPosition;
  public
    constructor Create(ABindLink: TCustomBindGridLink); overload;
    constructor Create(ABindLink: TCustomBindListLink); overload;
    constructor Create(ABindLink: TCustomBindGridListLink); overload;
    constructor Create(ABindPosition: TCustomBindPosition); overload;
    procedure PosChanged;
    procedure PosChanging;
  end;

  TBindControlValueLinkObserver = class(TBindMultiCastObserver, IControlValueObserver, IObserverTrack)
  private
    FBindControlValue: IBindControlValue;
    FTrack: Boolean;
    FModified: Boolean;
  protected
    function GetTrack: Boolean;
  public
    constructor Create(ABindControlValue: TCustomBindControlValue); overload;
    procedure SetTrack(AValue: Boolean);
    procedure ValueUpdate;
    procedure ValueModified;
  end;

implementation

uses
  Data.Bind.Consts;

{ TBindEditLinkObserver }

constructor TBindEditLinkObserver.Create(ABindLink: TCustomBindLink);
var
  LBindLink: IBindLink;
begin
  if not Supports(ABindLink, IBindLink, LBindLink) then
    raise EObserverException.CreateFmt(sBindLinkIncompatible, [ABindLink.DisplayName]);
  inherited Create(LBindLink);
end;

function TBindEditLinkObserver.Edit: Boolean;
begin
  if FBindLink.Updating then
    //Result := False
    // Allow control state to be changed while updating
    Result := True
  else
  begin
    if not FBindLink.GetCanModify then
      // Don't allow editing of readonly field
      Exit(False);
    FBindLink.BeginUpdate;
    try
      Result := FBindLink.Edit;
    finally
      FBindLink.EndUpdate;
    end;
  end;
end;

function TBindEditLinkObserver.GetIsEditing: Boolean;
begin
  Result := FBindLink.GetIsEditing;
end;

function TBindEditLinkObserver.GetIsReadOnly: Boolean;
begin
  Result := not FBindLink.GetCanModify;
end;

function TBindEditLinkObserver.GetTrack: Boolean;
begin
  Result := FTrack;
end;

function TBindEditLinkObserver.IsModified: Boolean;
begin
  Result := FBindLink.GetIsModified;
end;

function TBindEditLinkObserver.IsRequired: Boolean;
begin
  Result := FBindLink.IsRequired;
end;

function TBindEditLinkObserver.IsValidChar(AKey: Char): Boolean;
begin
  Result := FBindLink.IsValidChar(AKey);
end;

procedure TBindEditLinkObserver.Modified;
begin
  if not FBindLink.Updating then
    FBindLink.SetModified;
end;

procedure TBindEditLinkObserver.Reset;
begin
  FBindLink.Reset;
end;

procedure TBindEditLinkObserver.SetIsReadOnly(Value: Boolean);
begin
  FBindLink.SetIsReadOnly(Value);
end;

procedure TBindEditLinkObserver.SetTrack(AValue: Boolean);
begin
  FTrack := AValue;
end;

procedure TBindEditLinkObserver.Update;
begin
  if IsModified and (not FBindLink.Updating) then
  begin
    FBindLink.BeginUpdate;
    try
      FBindLink.EvaluateParse('');
    finally
      FBindLink.EndUpdate;
    end;
  end;
end;

procedure TBindEditLinkObserver.BeginUpdate;
begin
  FBindLink.BeginUpdate;
end;

procedure TBindEditLinkObserver.EndUpdate;
begin
  FBindLink.EndUpdate;
end;

function TBindEditLinkObserver.GetUpdating: Boolean;
begin
  Result := FBindLink.Updating;
end;

{ TBindObserver }

constructor TBindObserver.Create(ABindLink: IBindLink);
begin
  FBindLink := ABindLink;
  FOnToggle := nil;
end;

function TBindObserver.GetActive: Boolean;
begin
  if Assigned(FBindLink) then
    Result := FBindLink.Active
  else
    Result := True
end;

function TBindObserver.GetOnObserverToggle: TObserverToggleEvent;
begin
  Result := FOnToggle;
end;

procedure TBindObserver.Removed;
begin
  if Assigned(FBindLink) then
  begin
    FBindLink.Active := False;
    FBindLink.ClearEditingLink;
                                      
  end;
end;

procedure TBindObserver.SetActive(Value: Boolean);
begin
                                              
  //  (to initialize properties like ReadOnly, alignment, maxlength, etc)
  if Assigned(FOnToggle) then
    FOnToggle(Self, Value);
end;

procedure TBindObserver.SetOnObserverToggle(AEvent: TObserverToggleEvent);
begin
  FOnToggle := AEvent;
end;

{ TBindControlValueLinkObserver }

constructor TBindControlValueLinkObserver.Create(ABindControlValue: TCustomBindControlValue);
var
  LBindControlValue: IBindControlValue;
begin
  if not Supports(ABindControlValue, IBindControlValue, LBindControlValue) then
    raise EObserverException.CreateFmt(sBindPositionIncompatible,
      [ABindControlValue.DisplayName]);
  inherited Create(nil);
  FBindControlValue := LBindControlValue;
end;

function TBindControlValueLinkObserver.GetTrack: Boolean;
begin
  Result := FTrack;
end;

procedure TBindControlValueLinkObserver.SetTrack(AValue: Boolean);
begin
  FTrack := AValue;
end;

procedure TBindControlValueLinkObserver.ValueUpdate;
begin
  if FModified then
  begin
    FModified := False;
    FBindControlValue.ValueChanged;
  end;
end;

procedure TBindControlValueLinkObserver.ValueModified;
begin
  FModified := True;
end;

{ TBindPositionLinkObserver }

constructor TBindPositionLinkObserver.Create(ABindLink: TCustomBindGridLink);
var
  LBindLink: IBindLink;
  LBindPosition: IBindPosition;
begin
  if not Supports(ABindLink, IBindLink, LBindLink) then
    raise EObserverException.CreateFmt(sBindLinkIncompatible,
      [ABindLink.DisplayName]);
  if not Supports(ABindLink, IBindPosition, LBindPosition) then
    raise EObserverException.CreateFmt(sBindPositionIncompatible,
      [ABindLink.DisplayName]);
  inherited Create(LBindLink);
  FBindPosition := LBindPosition;
end;

constructor TBindPositionLinkObserver.Create(ABindLink: TCustomBindListLink);
var
  LBindLink: IBindLink;
  LBindPosition: IBindPosition;
begin
  if not Supports(ABindLink, IBindLink, LBindLink) then
    raise EObserverException.CreateFmt(sBindLinkIncompatible,
      [ABindLink.DisplayName]);
  if not Supports(ABindLink, IBindPosition, LBindPosition) then
    raise EObserverException.CreateFmt(sBindPositionIncompatible,
      [ABindLink.DisplayName]);
  inherited Create(LBindLink);
  FBindPosition := LBindPosition;
end;

constructor TBindPositionLinkObserver.Create(ABindLink: TCustomBindGridListLink);
var
  LBindLink: IBindLink;
  LBindPosition: IBindPosition;
begin
  if not Supports(ABindLink, IBindLink, LBindLink) then
    raise EObserverException.CreateFmt(sBindLinkIncompatible,
      [ABindLink.DisplayName]);
  if not Supports(ABindLink, IBindPosition, LBindPosition) then
    raise EObserverException.CreateFmt(sBindPositionIncompatible,
      [ABindLink.DisplayName]);
  inherited Create(LBindLink);
  FBindPosition := LBindPosition;
end;

constructor TBindPositionLinkObserver.Create(ABindPosition: TCustomBindPosition);
var
  LBindPosition: IBindPosition;
begin
  if not Supports(ABindPosition, IBindPosition, LBindPosition) then
    raise EObserverException.CreateFmt(sBindPositionIncompatible,
      [ABindPosition.DisplayName]);
  inherited Create(nil);
  FBindPosition := LBindPosition;
end;

procedure TBindPositionLinkObserver.PosChanged;
begin
  FBindPosition.PosChanged;
end;

procedure TBindPositionLinkObserver.PosChanging;
begin
  FBindPosition.PosChanging;
end;

{ TBindEditGridLinkObserver }

constructor TBindEditGridLinkObserver.Create(ABindLink: TCustomBindGridLink);
var
  LBindLink: IBindLink;
begin
  if not Supports(ABindLink, IBindLink, LBindLink) then
    raise EObserverException.CreateFmt(sBindLinkIncompatible,
      [ABindLink.DisplayName]);
  inherited Create(LBindLink);
end;

constructor TBindEditGridLinkObserver.Create(ABindLink: TCustomBindListLink);
var
  LBindLink: IBindLink;
begin
  if not Supports(ABindLink, IBindLink, LBindLink) then
    raise EObserverException.CreateFmt(sBindLinkIncompatible,
      [ABindLink.DisplayName]);
  inherited Create(LBindLink);
end;

constructor TBindEditGridLinkObserver.Create(ABindLink: TCustomBindGridListLink);
var
  LBindLink: IBindLink;
begin
  if not Supports(ABindLink, IBindLink, LBindLink) then
    raise EObserverException.CreateFmt(sBindLinkIncompatible,
      [ABindLink.DisplayName]);
  inherited Create(LBindLink);
end;

function TBindEditGridLinkObserver.GetCurrent: TVarRec;
begin
  if Assigned(FOnGetCurrent) then
    Result := FOnGetCurrent()
  else
  begin
    Result.VType := vtInteger;
    Result.VInteger := -1;
  end;
end;

function TBindEditGridLinkObserver.GetOnObserverCurrent: TObserverGetCurrentEvent;
begin
  Result := FOnGetCurrent;
end;

procedure TBindEditGridLinkObserver.SetOnObserverCurrent(
  AEvent: TObserverGetCurrentEvent);
begin
  FOnGetCurrent := AEvent;
end;

end.
