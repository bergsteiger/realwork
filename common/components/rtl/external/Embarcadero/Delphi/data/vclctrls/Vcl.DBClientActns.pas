{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.DBClientActns;

interface

uses System.Classes, Vcl.ActnList, Data.DB, Vcl.DBActns, Datasnap.DBClient;

type
  TClientDataSetApply = class;

{ TReconcileActionLink }

  TReconcileActionLink = class(TDataLink)
  private
    FApplyAction: TClientDataSetApply;
  protected
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
  public
    property ApplyAction: TClientDataSetApply read FApplyAction write FApplyAction;
  end;

{ TClientDataSetApply }

  TClientDataSetApply = class(TDataSetAction)
  private
    FReconcileActnLink: TReconcileActionLink;
    FMaxErrors: Integer;
    FDisplayErrorDlg: Boolean;
    procedure SetDisplayErrorDlg(const Value: Boolean);
  protected
    procedure DoReconcileError(ReconcileInfo: TReconcileInfo);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property DataSource;
    [Default(0)]
    property MaxErrors: Integer read FMaxErrors write FMaxErrors default 0;
    property DisplayErrorDlg: Boolean read FDisplayErrorDlg
      write SetDisplayErrorDlg;
  end;

{ TClientDataSetRevert }

  TClientDataSetRevert = class(TDataSetAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property DataSource;
  end;

{ TClientDataSetUndo }

  TClientDataSetUndo = class(TDataSetAction)
  private
    FFollowChange: Boolean;
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property DataSource;
    property FollowChange: Boolean read FFollowChange write FFollowChange;
  end;

implementation

uses System.SysUtils, Vcl.recerror;

{ TClientDataSetApply }

constructor TClientDataSetApply.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FMaxErrors := 0;
end;

destructor TClientDataSetApply.Destroy;
begin
  FreeAndNil(FReconcileActnLink);
  inherited;
end;

procedure TClientDataSetApply.DoReconcileError(ReconcileInfo: TReconcileInfo);
begin
  with ReconcileInfo do
    ReconcileInfo.ActionRef^ := HandleReconcileError(DataSet, UpdateKind, ReconcileError);
end;

procedure TClientDataSetApply.ExecuteTarget(Target: TObject);
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(Target);
  if DataSet is TClientDataSet then
    if FDisplayErrorDlg then
    try
      FReconcileActnLink.DataSource := Target as TDataSource;
      TClientDataSet(DataSet).ApplyUpdates(FMaxErrors);
    finally
      FReconcileActnLink.DataSource := nil;
    end
    else
      TClientDataSet(DataSet).ApplyUpdates(FMaxErrors);
end;

procedure TClientDataSetApply.SetDisplayErrorDlg(
  const Value: Boolean);
begin
  if FDisplayErrorDlg <> Value then
  begin
    FDisplayErrorDlg := Value;
    if FDisplayErrorDlg then
    begin
      FReconcileActnLink := TReconcileActionLink.Create;
      FReconcileActnLink.ApplyAction := Self;
    end
    else
      FreeAndNil(FReconcileActnLink);
  end;
end;

procedure TClientDataSetApply.UpdateTarget(Target: TObject);
var
  DataSet: TDataSet;
begin
  DataSet := GetDataSet(Target);
  if (DataSet is TClientDataSet) then
    with DataSet as TClientDataSet do
      Enabled := TClientDataSet(DataSet).Active and CanModify and (ChangeCount > 0)
  else
    Enabled := False;
end;

{ TClientDataSetRevert }

procedure TClientDataSetRevert.ExecuteTarget(Target: TObject);
begin
  if GetDataSet(Target) is TClientDataSet then
    TClientDataSet(GetDataSet(Target)).RevertRecord;
end;

procedure TClientDataSetRevert.UpdateTarget(Target: TObject);
begin
  if (GetDataSet(Target) is TClientDataSet) and
     (GetDataSet(Target) as TCustomClientDataSet).Active then
    Enabled := not (TClientDataSet(GetDataSet(Target)).UpdateStatus = usUnmodified)
  else
    Enabled := False;
end;

{ TClientDataSetUndo }

procedure TClientDataSetUndo.ExecuteTarget(Target: TObject);
begin
  if GetDataSet(Target) is TClientDataSet then
    TClientDataSet(GetDataSet(Target)).UndoLastChange(FFollowChange);
end;

procedure TClientDataSetUndo.UpdateTarget(Target: TObject);
begin
  if (GetDataSet(Target) is TClientDataSet) then
    Enabled := TClientDataSet(GetDataSet(Target)).ChangeCount > 0
  else
    Enabled := False;
end;

{ TReconcileActionLink }

procedure TReconcileActionLink.DataEvent(Event: TDataEvent; Info: NativeInt);
begin
  inherited;
  if (Event = deReconcileError) and Assigned(FApplyAction) then
    FApplyAction.DoReconcileError(TReconcileInfo(Pointer(Info)^));
end;

end.
