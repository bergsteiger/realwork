{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Vcl.Bind.Navigator"'}    {Do not Localize}
unit Vcl.Bind.Navigator;

interface

uses Data.Bind.Components, System.Classes, Data.Bind.Controls,
  Generics.Collections, Vcl.Buttons, Vcl.ActnList, System.SysUtils;

type

  TNavigateButtonEvent = procedure (Sender: TObject; Button: TNavigateButton) of object;

  TNavigatorOrientation = (orHorizontal, orVertical);

  TCustomBindNavigator = class(TBaseNavigator, IBindNavigator)
  private
    FController: TBindNavigatorController;
    FBeforeAction: TNavigateButtonEvent;
    FOnNavClick: TNavigateButtonEvent;
    FHints: TStrings;
    FDefHints: TStrings;
    FVisibleButtons: TNavigateButtons;
    procedure OnActiveChanged(Sender: TObject);
    procedure OnDataChanged(Sender: TObject);
    procedure OnEditingChanged(Sender: TObject);
    function GetDataSource: TBaseLinkingBindSource;
    procedure SetDataSource(Value: TBaseLinkingBindSource);
    procedure SetVisible(const Value: TNavigateButtons);
    function GetHints: TStrings;
    procedure SetHints(Value: TStrings);
    function GetButton(Index: TNavigateButton): TNavButton;
    procedure HintsChanged(Sender: TObject);
    function GetOrientation: TNavigatorOrientation;
    procedure SetOrientation(const Value: TNavigatorOrientation);
  protected
    procedure InitHints;
    property Buttons[Index: TNavigateButton]: TNavButton read GetButton;
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure EnabledChanged; override;
    procedure ActiveChanged;
    procedure DataChanged;
    procedure EditingChanged;
    procedure BtnClick(Index: TNavigateButton); virtual;
    procedure Loaded; override;
    procedure BtnIDClick(Index: TNavBtnID); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property VisibleButtons: TNavigateButtons read FVisibleButtons write SetVisible
      default NavigatorDefaultButtons;
    property DataSource: TBaseLinkingBindSource read GetDataSource write SetDataSource;
    property Hints: TStrings read GetHints write SetHints;
    property BeforeAction: TNavigateButtonEvent read FBeforeAction write FBeforeAction;
    property OnClick: TNavigateButtonEvent read FOnNavClick write FOnNavClick;
    property Orientation: TNavigatorOrientation read GetOrientation write SetOrientation;
  end;

  TBindNavigator = class (TCustomBindNavigator)
  published
    property DataSource;
    property VisibleButtons;
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Flat;
    property Ctl3D;
    property Hints;
    property Orientation;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ConfirmDelete;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property BeforeAction;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  { BindSource actions }

  TBindNavigateAction = class(TAction)
  private
    FController: TBindNavigatorController;
    FButton: TNavigateButton;
    function GetDataSource: TBaseLinkingBindSource;
    procedure SetDataSource(Value: TBaseLinkingBindSource);
    function InvokeController(Target: TObject;
      AProc: TProc<TBindNavigatorController>): Boolean;
  protected
    property Controller: TBindNavigatorController read FController;
  public
    constructor Create(AComponent: TComponent); overload; override;
    constructor Create(AComponent: TComponent; AButton: TNavigateButton); reintroduce; overload;
    destructor Destroy; override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property DataSource: TBaseLinkingBindSource read GetDataSource write SetDataSource;
  end;

  TBindNavigateFirst = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigatePrior = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateNext = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateLast = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateInsert = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateDelete = class(TBindNavigateAction)
  private
    FConfirmDelete: Boolean;
  public
    constructor Create(AComponent: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    [Default(True)]
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
  end;

  TBindNavigateEdit = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigatePost = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateCancel = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateRefresh = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateApplyUpdates = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TBindNavigateCancelUpdates = class(TBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

implementation

uses Vcl.Dialogs, WinApi.Windows, Vcl.Themes,
  Data.Bind.Consts, System.UITypes;

{$R BindCtrls.res}

{ TCustomBindNavigator }


var
  BtnTypeName: array[TNavigateButton] of pchar = ('FIRST', 'PRIOR', 'NEXT',
    'LAST', 'INSERT', 'DELETE', 'EDIT', 'POST', 'CANCEL', 'REFRESH',
     'APPLYUPDATES',
     'CANCELUPDATES');
  BtnHintId: array[TNavigateButton] of string = (SFirstRecord, SPriorRecord,
    SNextRecord, SLastRecord, SInsertRecord, SDeleteRecord, SEditRecord,
    SPostEdit, SCancelEdit, SRefreshRecord,
    SApplyUpdates, SCancelUpdates);

constructor TCustomBindNavigator.Create(AOwner: TComponent);
const
  NormalButtons: array[TNavigateButton] of TThemedDataNavButtons = (tdnbFirstNormal,
    tdnbPriorNormal, tdnbNextNormal, tdnbLastNormal, tdnbInsertNormal,
    tdnbDeleteNormal, tdnbEditNormal, tdnbPostNormal, tdnbCancelNormal,
    tdnbRefreshNormal, tdnbApplyUpdatesNormal, tdnbCancelUpdatesNormal);
  HotButtons: array[TNavigateButton] of TThemedDataNavButtons = (tdnbFirstHot,
    tdnbPriorHot, tdnbNextHot, tdnbLastHot, tdnbInsertHot,
    tdnbDeleteHot, tdnbEditHot, tdnbPostHot, tdnbCancelHot,
    tdnbRefreshHot,  tdnbApplyUpdatesHot, tdnbCancelUpdatesHot);
  DisabledButtons: array[TNavigateButton] of TThemedDataNavButtons = (tdnbFirstDisabled,
    tdnbPriorDisabled, tdnbNextDisabled, tdnbLastDisabled, tdnbInsertDisabled,
    tdnbDeleteDisabled, tdnbEditDisabled, tdnbPostDisabled, tdnbCancelDisabled,
    tdnbRefreshDisabled, tdnbApplyUpdatesDisabled, tdnbCancelUpdatesDisabled);
  PressedButtons: array[TNavigateButton] of TThemedDataNavButtons = (tdnbFirstPressed,
    tdnbPriorPressed, tdnbNextPressed, tdnbLastPressed, tdnbInsertPressed,
    tdnbDeletePressed, tdnbEditPressed, tdnbPostPressed, tdnbCancelPressed,
    tdnbRefreshPressed, tdnbApplyUpdatesPressed, tdnbCancelUpdatesPressed);
var
  LList: TList<TBaseNavigator.TButtonDescription>;
  LDescription: TButtonDescription;
  I: TNavigateButton;
begin
  inherited;
  FHints := TStringList.Create;
  TStringList(FHints).OnChange := HintsChanged;
  VisibleButtons := NavigatorDefaultButtons;
  FController := TBindNavigatorController.Create(Self);
  FController.OnEditingChanged := OnEditingChanged;
  FController.OnDataChanged := OnDataChanged;
  FController.OnActiveChanged := OnActiveChanged;

  LList := TList<TBaseNavigator.TButtonDescription>.Create;
  try
    for I := Low(TNavigateButton) to High(TNavigateButton) do
    begin
      LDescription.ID := TNavBtnID(I);
      LDescription.AllowTimer := (I = nbPrior) or (I = nbNext);
      LDescription.DefaultHint := BtnHintId[I];
      LDescription.DefaultVisible := I in VisibleButtons;
      LDescription.GlyphResInstance := HInstance;
      LDescription.GlyphResName := Format('BINDN_%s', [BtnTypeName[I]]);
      LDescription.ThemeNormal := NormalButtons[I];
      LDescription.ThemeHot := HotButtons[I];
      LDescription.ThemeDisabled := DisabledButtons[I];
      LDescription.ThemePressed := PressedButtons[I];
      LList.Add(LDescription);
    end;
    DefineButtons(LList.ToArray);
  finally
    LList.Free;
  end;
end;

procedure TCustomBindNavigator.HintsChanged(Sender: TObject);
begin
  InitHints;
end;

procedure TCustomBindNavigator.InitHints;
var
  I: Integer;
  J: TNavigateButton;
begin
  if not Assigned(FDefHints) then
  begin
    FDefHints := TStringList.Create;
    for J := Low(TNavigateButton) to High(TNavigateButton) do
      FDefHints.Add(BtnHintId[J]);
  end;
  for J := Low(TNavigateButton) to High(TNavigateButton) do
    Buttons[J].Hint := FDefHints[Ord(J)];
  J := Low(TNavigateButton);
  for I := 0 to (FHints.Count - 1) do
  begin
    if FHints.Strings[I] <> '' then Buttons[J].Hint := FHints.Strings[I];
    if J = High(TNavigateButton) then Exit;
    Inc(J);
  end;
end;

procedure TCustomBindNavigator.Loaded;
begin
  inherited;
  HintsChanged(Self);
end;

procedure TCustomBindNavigator.ActiveChanged;
var
  LActive: Boolean;
begin
  LActive := FController.Active;
  if not (Enabled and LActive) then
    FController.DisableButtons(
      procedure(AButton: TNavigateButton; AEnabled: Boolean)
      begin
        Buttons[AButton].Enabled := AEnabled;
      end)
  else
  begin
    FController.EnableButtons(NavigatorButtons, Self.Enabled,
      procedure(AButton: TNavigateButton; AEnabled: Boolean)
      begin
        Buttons[AButton].Enabled := AEnabled;
      end)
  end;
end;

procedure TCustomBindNavigator.DataChanged;
begin
  FController.EnableButtons(NavigatorScrollButtons + [nbDelete, nbApplyUpdates, nbCancelUpdates], Self.Enabled,
    procedure(AButton: TNavigateButton; AEnabled: Boolean)
    begin
      Buttons[AButton].Enabled := AEnabled;
    end);
end;

destructor TCustomBindNavigator.Destroy;
begin
  FController.Free;
  FHints.Free;
  FDefHints.Free;
  inherited;
end;

procedure TCustomBindNavigator.EditingChanged;
begin
  FController.EnableButtons(NavigatorEditButtons - [nbDelete], Enabled,
    procedure(AButton: TNavigateButton; AEnabled: Boolean)
    begin
      Buttons[AButton].Enabled := AEnabled;
    end);
end;

procedure TCustomBindNavigator.EnabledChanged;
begin
  ActiveChanged;
end;

procedure TCustomBindNavigator.OnEditingChanged(Sender: TObject);
begin
  Self.EditingChanged;
end;

procedure TCustomBindNavigator.OnActiveChanged(Sender: TObject);
begin
  Self.ActiveChanged;
end;

procedure TCustomBindNavigator.OnDataChanged(Sender: TObject);
begin
  Self.DataChanged;
end;

procedure TCustomBindNavigator.SetDataSource(Value: TBaseLinkingBindSource);
begin
  FController.DataSource := Value;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

procedure TCustomBindNavigator.SetHints(Value: TStrings);
begin
  if Value.Text = FDefHints.Text then
    FHints.Clear else
    FHints.Assign(Value);
end;

procedure TCustomBindNavigator.SetOrientation(
  const Value: TNavigatorOrientation);
begin
  case Value of
    orHorizontal:
      inherited Orientation := TOrientation.orHorizontal;
    orVertical:
      inherited Orientation := TOrientation.orVertical;
  else
    Assert(False);
  end;
end;

procedure TCustomBindNavigator.SetVisible(const Value: TNavigateButtons);
var
  LList: TList<TNavBtnID>;
  I: TNavigateButton;
begin
  FVisibleButtons := Value;
  LList := TList<TNavBtnID>.Create;
  try
    for I in Value do
      LList.Add(TNavBtnID(I));
    inherited SetVisible(LList.ToArray);
  finally
    LList.Free;
  end;
end;

function TCustomBindNavigator.GetHints: TStrings;
begin
  if (csDesigning in ComponentState) and not (csWriting in ComponentState) and
     not (csReading in ComponentState) and (FHints.Count = 0) then
    Result := FDefHints else
    Result := FHints;
end;

function TCustomBindNavigator.GetOrientation: TNavigatorOrientation;
begin
  case inherited Orientation of
    TOrientation.orHorizontal:
      Result := orHorizontal;
    TOrientation.orVertical:
      Result := orVertical;
  else
    Result := orHorizontal;
    Assert(False);
  end;
end;

function TCustomBindNavigator.GetDataSource: TBaseLinkingBindSource;
begin
  Result := FController.DataSource as TBaseLinkingBindSource
end;

function TCustomBindNavigator.GetButton(Index: TNavigateButton): TNavButton;
begin
  Result := inherited GetButton(TNavBtnID(Index));
end;

procedure TCustomBindNavigator.BtnClick(Index: TNavigateButton);
begin
  if (DataSource <> nil) then
  begin
    if not (csDesigning in ComponentState) and Assigned(BeforeAction) then
      BeforeAction(Self, Index);
    FController.ExecuteButton(Index,
       function: Boolean
       begin
          Result := not ConfirmDelete or
          (MessageDlg(SDeleteRecordQuestion, mtConfirmation,
          mbOKCancel, 0) <> idCancel);
       end
      );
  end;
  if not (csDesigning in ComponentState) and Assigned(OnClick) then
    OnClick(Self, Index);
end;

procedure TCustomBindNavigator.BtnIDClick(Index: TNavBtnID);
begin
  Self.BtnClick(TNavigateButton(Index));
end;


{ TBindNavigateAction }

function TBindNavigateAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := DataSource <> nil;
end;

constructor TBindNavigateAction.Create(AComponent: TComponent);
begin
  inherited;
  FController := TBindNavigatorController.Create(Self);
end;

constructor TBindNavigateAction.Create(AComponent: TComponent;
  AButton: TNavigateButton);
begin
  inherited Create(AComponent);
  FButton := AButton;
  FController := TBindNavigatorController.Create(Self);
end;

destructor TBindNavigateAction.Destroy;
begin
  FController.Free;
  inherited;
end;

procedure TBindNavigateAction.ExecuteTarget(Target: TObject);
begin
  InvokeController(Target,
    procedure(AController: TBindNavigatorController)
    begin
      AController.ExecuteButton(FButton, nil);
    end);

end;

function TBindNavigateAction.GetDataSource: TBaseLinkingBindSource;
begin
  Result := FController.DataSource as TBaseLinkingBindSource
end;

procedure TBindNavigateAction.SetDataSource(Value: TBaseLinkingBindSource);
begin
  FController.DataSource := Value;
end;

procedure TBindNavigateAction.UpdateTarget(Target: TObject);
begin
  if not InvokeController(Target,
    procedure(AController: TBindNavigatorController)
    begin
      AController.EnableButtons([FButton], True,
        procedure(AButton: TNavigateButton; AEnabled: Boolean)
        begin
          Enabled := AEnabled;
        end);
    end) then
    Enabled := False;
end;

function TBindNavigateAction.InvokeController(Target: TObject; AProc: TProc<TBindNavigatorController>): Boolean;
begin
  Result := DataSource <> nil;
  if Result then
    AProc(FController)
end;

{ TBindNavigateFirst }

constructor TBindNavigateFirst.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbFirst);
end;

{ TBindNavigatePrior }

constructor TBindNavigatePrior.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbPrior);
end;


{ TBindNavigateNext }

constructor TBindNavigateNext.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbNext)

end;

{ TBindNavigateLast }

constructor TBindNavigateLast.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbLast)

end;

{ TBindNavigateInsert }

constructor TBindNavigateInsert.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbInsert)

end;

{ TBindNavigateDelete }

constructor TBindNavigateDelete.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbDelete);
  FConfirmDelete := True;

end;

procedure TBindNavigateDelete.ExecuteTarget(Target: TObject);
begin
  InvokeController(Target,
    procedure(AController: TBindNavigatorController)
    begin
      AController.ExecuteButton(FButton,
        function: Boolean
        begin
          Result := not ConfirmDelete or
          (MessageDlg(SDeleteRecordQuestion, mtConfirmation,
          mbOKCancel, 0) <> idCancel);
        end);
    end);
end;

{ TBindNavigateEdit }

constructor TBindNavigateEdit.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbEdit)

end;

{ TBindNavigatePost }

constructor TBindNavigatePost.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbPost)

end;

{ TBindNavigateCancel }

constructor TBindNavigateCancel.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbCancel)

end;

{ TBindNavigateRefresh }

constructor TBindNavigateRefresh.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbRefresh)

end;

{ TBindNavigateApplyUpdates }

constructor TBindNavigateApplyUpdates.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbApplyUpdates)

end;

{ TBindNavigateCancelUpdates }

constructor TBindNavigateCancelUpdates.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbCancelUpdates)

end;

end.
