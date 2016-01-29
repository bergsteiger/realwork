{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.Bind.Controls"'}    {Do not Localize}
unit Data.Bind.Controls;

interface

uses System.Classes, Data.Bind.Components, System.SysUtils;

type

  TNavigateButton = (nbFirst, nbPrior, nbNext, nbLast,
                  nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates,
                  nbCancelUpdates);

  TNavigateButtons = set of TNavigateButton;



  TBindNavigatorController = class(TComponent)
  private
    (*[weak]*) FDataSource: TBaseBindScopeComponent;
    FScopeNavigator: IScopeNavigator;
    FScopeNavigatorUpdates: IScopeNavigatorUpdates;
    FScopeState: IScopeState;
    FScopeEditor: IScopeEditor;
    FOnDataChanged: TNotifyEvent;
    FOnEditingChanged: TNotifyEvent;
    FOnActiveChanged: TNotifyEvent;
    function GetActive: Boolean;
    function GetBOF: Boolean;
    function GetEOF: Boolean;
    function GetSelected: Boolean;
    function GetEditing: Boolean;
    procedure SetDataSource(const Value: TBaseBindScopeComponent);
    function GetCanModify: Boolean;
    function GetCanInsert: Boolean;
    function GetCanDelete: Boolean;
    procedure DoOnEditingChanged(Sender: TObject);
    procedure DoOnDataChanged(Sender: TObject);
    procedure DoOnDataScrolled(Sender: TObject; Distance: Integer);
    procedure DoOnActiveChanged(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
    procedure EnableButtons(AButtons: TNavigateButtons; ADataSourceEnabled: Boolean;
      ASetEnabled: TProc<TNavigateButton, Boolean>);
    procedure DisableButtons(ASetEnabled: TProc<TNavigateButton, Boolean>);
    procedure ExecuteButton(AButton: TNavigateButton; AConfirmDelete: TFunc<Boolean>);
    procedure Next;
    procedure Prior;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Delete;
    procedure Cancel;
    procedure Post;
    procedure Refresh;
    procedure Edit;
    procedure ApplyUpdates;
    procedure CancelUpdates;
    function CanApplyUpdates: Boolean;
    function CanCancelUpdates: Boolean;
    property Active: Boolean read GetActive;
    property Editing: Boolean read GetEditing;
    property Eof: Boolean read GetEOF; {Upper case EOF conflicts with C++}
    property BOF: Boolean read GetBOF;
    property Selected: Boolean read GetSelected;
    property DataSource: TBaseBindScopeComponent read FDataSource write SetDataSource;
    property CanModify: Boolean read GetCanModify;
    property CanInsert: Boolean read GetCanInsert;
    property CanDelete: Boolean read GetCanDelete;
    property OnEditingChanged: TNotifyEvent read FOnEditingChanged write FOnEditingChanged;
    property OnDataChanged: TNotifyEvent read FOnDataChanged write FOnDataChanged;
    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
  end;

  const
    NavigatorScrollButtons = [nbFirst, nbPrior, nbNext, nbLast];
    NavigatorEditButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates,
                  nbCancelUpdates];
    NavigatorButtons = [nbFirst, nbPrior, nbNext, nbLast,
                  nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates,
                  nbCancelUpdates];
    NavigatorDefaultButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete,
        nbEdit, nbPost, nbCancel, nbRefresh];

implementation

{ TBindNavigatorController }

procedure TBindNavigatorController.ApplyUpdates;
begin
 if FScopeNavigatorUpdates <> nil then
   FScopeNavigatorUpdates.ApplyUpdates;
end;

function TBindNavigatorController.CanApplyUpdates: Boolean;
begin
  Result := (FScopeNavigatorUpdates <> nil) and FScopeNavigatorUpdates.CanApplyUpdates;
end;

function TBindNavigatorController.CanCancelUpdates: Boolean;
begin
  Result := (FScopeNavigatorUpdates <> nil) and FScopeNavigatorUpdates.CanCancelUpdates;
end;

procedure TBindNavigatorController.Cancel;
begin
  if Assigned(FScopeEditor) then
    FScopeEditor.Cancel
end;

procedure TBindNavigatorController.CancelUpdates;
begin
 if FScopeNavigatorUpdates <> nil then
   FScopeNavigatorUpdates.CancelUpdates;
end;

constructor TBindNavigatorController.Create(AComponent: TComponent);
begin
  inherited Create(AComponent);
end;

procedure TBindNavigatorController.Delete;
begin
  if Assigned(FScopeEditor) then
    FScopeEditor.Delete
end;

destructor TBindNavigatorController.Destroy;
begin
  SetDataSource(nil); // Clear notifications
  inherited;
end;

procedure TBindNavigatorController.DisableButtons(
  ASetEnabled: TProc<TNavigateButton, Boolean>);
var
  I: TNavigateButton;
begin
  for I := Low(TNavigateButton) to High(TNavigateButton) do
    ASetEnabled(I, False);
end;

type
  TState = (stUnknown, stEnable, stDisable);

procedure TBindNavigatorController.EnableButtons(AButtons: TNavigateButtons; ADataSourceEnabled: Boolean;
  ASetEnabled: TProc<TNavigateButton, Boolean>);
var
  FUpState: TState;
  FDnState: TState;
  FCanModifyState: TState;
  FStateSelected: TState;

  function Selected: Boolean;
  begin
    if FStateSelected = stUnknown then
      if Self.Active and Self.Selected then
        FStateSelected := stEnable
      else
        FStateSelected := stDisable;
    Result := FStateSelected = stEnable;
  end;

  function CanModify: Boolean;
  begin
    if FCanModifyState = stUnknown then
      if ADataSourceEnabled and Self.CanModify then
        FCanModifyState := stEnable
      else
        FCanModifyState := stDisable;
    Result := FCanModifyState = stEnable;
  end;

  function UpEnable: Boolean;
  begin
    if FUpState = stUnknown then
      if ADataSourceEnabled and Selected and not Self.BOF then
        FUpState := stEnable
      else
        FUpState := stDisable;
    Result := FUpState = stEnable;
  end;

  function DnEnable: Boolean;
  begin
    if FDnState = stUnknown then
      if ADataSourceEnabled and Selected and not Self.EOF then
        FDnState := stEnable
      else
        FDnState := stDisable;
    Result := FDnState = stEnable;
  end;

var
  LButton: TNavigateButton;
begin
  FUpState := stUnknown;
  FDnState := stUnknown;
  FCanModifyState := stUnknown;
  FStateSelected := stUnknown;
  for LButton in AButtons do
  begin
    case LButton of
      nbFirst:
        ASetEnabled(nbFirst,  UpEnable);
      nbPrior:
        ASetEnabled(nbPrior,  UpEnable);
      nbNext:
        ASetEnabled(nbNext,  DnEnable);
      nbLast:
        ASetEnabled(nbLast,  DnEnable);
      nbInsert:
        ASetEnabled(nbInsert, CanModify and Self.CanInsert);
      nbDelete:
        ASetEnabled(nbDelete, Selected and
          CanModify  and Self.CanDelete);
      nbEdit:
        ASetEnabled(nbEdit, CanModify and not Self.Editing);
      nbPost:
        ASetEnabled(nbPost, CanModify and Self.Editing);
      nbCancel:
        ASetEnabled(nbCancel, CanModify and Self.Editing);
      nbRefresh:
        ASetEnabled(nbRefresh, CanModify);
      nbApplyUpdates:
        ASetEnabled(nbApplyUpdates, CanModify and Self.CanApplyUpdates);
      nbCancelUpdates:
        ASetEnabled(nbCancelUpdates, CanModify and Self.CanCancelUpdates);
    else
      Assert(False);
    end
  end;
end;

procedure TBindNavigatorController.ExecuteButton(AButton: TNavigateButton;
  AConfirmDelete: TFunc<Boolean>);
begin
    case AButton of
      nbPrior: Self.Prior;
      nbNext: Self.Next;
      nbFirst: Self.First;
      nbLast: Self.Last;
      nbInsert: Self.Insert;
      nbEdit: Self.Edit;
      nbCancel: Self.Cancel;
      nbPost: Self.Post;
      nbRefresh: Self.Refresh;
      nbDelete:
        if (not Assigned(AConfirmDelete)) or AConfirmDelete()  then
          Self.Delete;
      nbApplyUpdates: Self.ApplyUpdates;
      nbCancelUpdates: Self.CancelUpdates;
    else
      Assert(False);
    end;
end;

procedure TBindNavigatorController.DoOnActiveChanged(Sender: TObject);
begin
  if Assigned(FOnActiveChanged) then
    FOnActiveChanged(Sender);
end;

procedure TBindNavigatorController.DoOnDataChanged(Sender: TObject);
begin
  if Assigned(FOnDataChanged) then
    FOnDataChanged(Sender);
end;

procedure TBindNavigatorController.DoOnDataScrolled(Sender: TObject; Distance: Integer);
begin
  if Assigned(FOnDataChanged) then
    FOnDataChanged(Sender);
end;

procedure TBindNavigatorController.DoOnEditingChanged(Sender: TObject);
begin
  if Assigned(FOnEditingChanged) then
    FOnEditingChanged(Sender);
end;

procedure TBindNavigatorController.Edit;
begin
  if Assigned(FScopeEditor) then
    FScopeEditor.Edit
end;

procedure TBindNavigatorController.First;
begin
  if Assigned(FScopeNavigator) then
    FScopeNavigator.First
end;

function TBindNavigatorController.GetActive: Boolean;
begin
  if Assigned(FScopeState) then
    Result := FScopeState.Active
  else
    Result := False;
end;

function TBindNavigatorController.GetBOF: Boolean;
begin
  if Assigned(FScopeNavigator) then
    Result := FScopeNavigator.BOF
  else
    Result := True;

end;

function TBindNavigatorController.GetCanModify: Boolean;
begin
  if Assigned(FScopeState) then
    Result := FScopeState.CanModify
  else
    Result := False;
end;

function TBindNavigatorController.GetCanInsert: Boolean;
begin
  if Assigned(FScopeState) then
    Result := FScopeState.CanInsert
  else
    Result := False;
end;

function TBindNavigatorController.GetCanDelete: Boolean;
begin
  if Assigned(FScopeState) then
    Result := FScopeState.CanDelete
  else
    Result := False;
end;

function TBindNavigatorController.GetEditing: Boolean;
begin
  if Assigned(FScopeState) then
    Result := FScopeState.Editing
  else
    Result := False;

end;

function TBindNavigatorController.GetEOF: Boolean;
begin
  if Assigned(FScopeNavigator) then
    Result := FScopeNavigator.EOF
  else
    Result := True;
end;

function TBindNavigatorController.GetSelected: Boolean;
begin
  if Assigned(FScopeNavigator) then
    Result := FScopeNavigator.Selected
  else
    Result := True;
end;

procedure TBindNavigatorController.Insert;
begin
  if Assigned(FScopeEditor) then
    FScopeEditor.Insert
end;

procedure TBindNavigatorController.Last;
begin
  if Assigned(FScopeNavigator) then
    FScopeNavigator.Last;
end;

procedure TBindNavigatorController.Next;
begin
  if Assigned(FScopeNavigator) then
    FScopeNavigator.Next;
end;

procedure TBindNavigatorController.Post;
begin
  if Assigned(FScopeEditor) then
    FScopeEditor.Post
end;

procedure TBindNavigatorController.Prior;
begin
  if Assigned(FScopeNavigator) then
    FScopeNavigator.Prior;

end;

procedure TBindNavigatorController.Refresh;
begin
  if Assigned(FScopeEditor) then
    FScopeEditor.Refresh;
end;

procedure TBindNavigatorController.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent = FDataSource then
      DataSource := nil;
  end;
end;

procedure TBindNavigatorController.SetDataSource(const Value: TBaseBindScopeComponent);
begin
  if FDataSource <> nil then
  begin
    FScopeNavigator := nil;
    if FScopeState <> nil then
    begin
      FScopeState.RemoveActiveChanged(DoOnActiveChanged);
      FScopeState.RemoveDataSetChanged(DoOnDataChanged);
      FScopeState.RemoveDataSetScrolled(DoOnDataScrolled);
      FScopeState.RemoveEditingChanged(DoOnEditingChanged);
    end;
    FScopeState := nil;
    FScopeEditor := nil;
    FScopeNavigatorUpdates := nil;
    FDataSource.RemoveFreeNotification(Self);
  end;
  FDataSource := Value;
  if FDataSource <> nil then
  begin
    FDataSource.FreeNotification(Self);
    Supports(FDataSource, IScopeNavigator, FScopeNavigator);
    Supports(FDataSource, IScopeNavigatorUpdates, FScopeNavigatorUpdates);
    Supports(FDataSource, IScopeState, FScopeState);
    Supports(FDataSource, IScopeEditor, FScopeEditor);
    if Assigned(FScopeState) then
    begin
      FScopeState.AddActiveChanged(DoOnActiveChanged);
      FScopeState.AddDataSetChanged(DoOnDataChanged);
      FScopeState.AddDataSetScrolled(DoOnDataScrolled);
      FScopeState.AddEditingChanged(DoOnEditingChanged);
    end;
  end;

end;


end.
