{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Design.Import;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, FMX.Forms, FMX.StdCtrls,
  FMX.Dialogs, FMX.Types, FMX.Controls, FMX.Import, FMX.Objects3D, FMX.Types3D, FMX.Viewport3D,
  FMX.Layouts, FMX.Objects, FMX.Edit, FMX.Effects, Generics.Collections, FMX.Controls3D,
  FMX.ASE.Importer, System.Math.Vectors,
  FMX.DAE.Importer,
  FMX.OBJ.Importer;

type

  TCommand = (cNone, cClose, cClear, cOpen);

  TMeshCollectionDesigner = class(TForm)
    btnLoad: TButton;
    Layout1: TLayout;
    btnCancel: TButton;
    btnOk: TButton;
    btnClear: TButton;
    Viewport1: TViewport3D;
    cameray: TDummy;
    camerax: TDummy;
    camera: TCamera;
    Light1: TLight;
    TrackBar1: TTrackBar;
    Model3D1: TModel3D;
    btnUp: TButton;
    Path1: TPath;
    btnDown: TButton;
    Path2: TPath;
    btnLeft: TButton;
    Path3: TPath;
    btnRight: TButton;
    Path4: TPath;
    MoveLayout: TLayout;
    procedure btnLoadClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure Viewport1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure Viewport1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Viewport1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
  private
    { Private declarations }
    FDown: TPointF;
    FFileName: string;
    FCommand: TCommand;
    FScale: Single;
    procedure ClearMeshes;
    procedure SetScale(const Value: Single);
  public
    { Public declarations }
    procedure CloneMeshCollection(AModel3D: TModel3d);
    property FileName: string read FFileName;
    property Command: TCommand read FCommand;
    property Scale: Single read FScale write SetScale;
  end;

implementation

{$R *.fmx}

uses
  Math;

procedure TMeshCollectionDesigner.btnClearClick(Sender: TObject);
begin
  FCommand := cClear;
  Model3D1.Clear;
  ClearMeshes;
  Scale := 1.0;
end;

procedure TMeshCollectionDesigner.btnLoadClick(Sender: TObject);
var
  D: TOpenDialog;
  LCount, I: Integer;
  LFileTypes: string;
  BtnEnable: Boolean;
begin
  D := TOpenDialog.Create(Application);
  try
    LCount := TModelImportServices.GetSupportedFileTypesCount;
    if LCount > 0 then
    begin
      for i := 0 to LCount - 2 do
        LFileTypes := Format('%s*.%s;',
          [LFileTypes, LowerCase(TModelImportServices.GetFileExt(i))]);

      LFileTypes := Format('%s*.%s',
        [LFileTypes, LowerCase(TModelImportServices.GetFileExt(LCount - 1))]);
    end;

    D.Filter := '3D File Formats (' + LFileTypes + ')|' + LFileTypes
      + '|All Files (*.*)|*.*';
    if D.Execute then
    begin
      Model3D1.Clear;
      ClearMeshes;
      FFileName := D.FileName;
      Model3D1.LoadFromFile(FileName);
      btnOk.Enabled := true;
      FCommand := cOpen;
      {making visible for user that loading process is done}
      TrackBar1.SetFocus;
      {enable editor buttons}
      BtnEnable:= Model3D1.ChildrenCount > 0;
      btnClear.Enabled:= BtnEnable;
      btnUp.Enabled:= BtnEnable;
      btnDown.Enabled:= BtnEnable;
      btnLeft.Enabled:= BtnEnable;
      btnRight.Enabled:= BtnEnable;
    end;
  finally
    D.Free;
  end;
end;

procedure TMeshCollectionDesigner.btnOkClick(Sender: TObject);
begin
  Model3D1.Clear;
  ClearMeshes;
  ModalResult := mrOk;
end;

procedure TMeshCollectionDesigner.btnUpClick(Sender: TObject);
begin
  {moving 3D model up}
  if (CameraX.RotationAngle.X <= -100) or (CameraX.RotationAngle.X >= 100)  then
    Model3D1.Position.Y:= Model3D1.Position.Y + 0.02
  else
    Model3D1.Position.Y:= Model3D1.Position.Y - 0.02;
//  btnUp.Enabled:= Model3D1.Position.Y - Model3D1.Height / 2 > Viewport1.LocalRect.Bottom;
end;

procedure TMeshCollectionDesigner.btnDownClick(Sender: TObject);
begin
  {moving 3D model down}
  if (CameraX.RotationAngle.X <= -100) or (CameraX.RotationAngle.X >= 100)  then
    Model3D1.Position.Y:= Model3D1.Position.Y - 0.02
  else
    Model3D1.Position.Y:= Model3D1.Position.Y + 0.02;
//  btnDown.Enabled:= Model3D1.Position.Y + Model3D1.Height / 2 < Viewport1.LocalRect.Top;
end;

procedure TMeshCollectionDesigner.btnLeftClick(Sender: TObject);
begin
  {moving 3D model to the left}
  if (CameraY.RotationAngle.Y <= -100) or (CameraY.RotationAngle.Y >= 100)  then
    Model3D1.Position.X:= Model3D1.Position.X + 0.02
  else
    Model3D1.Position.X:= Model3D1.Position.X - 0.02;
//  btnLeft.Enabled:= Model3D1.Position.X - Model3D1.Width / 2 > 0;
end;

procedure TMeshCollectionDesigner.btnRightClick(Sender: TObject);
begin
  {moving 3D model to the right}
  if (CameraY.RotationAngle.Y <= -100) or (CameraY.RotationAngle.Y >= 100)  then
    Model3D1.Position.X:= Model3D1.Position.X - 0.02
  else
    Model3D1.Position.X:= Model3D1.Position.X + 0.02;
//  btnRight.Enabled:= Model3D1.Position.X + Model3D1.Width / 2 < Viewport1;
end;

procedure TMeshCollectionDesigner.ClearMeshes;
var
  I: Integer;
  LMeshes: TList<TMesh>;
  LMesh: TMesh;
begin
  LMeshes := TList<TMesh>.Create;
  try
    for I := 0 to Model3D1.ChildrenCount - 1 do
    begin
      if Model3D1.Children[I] is TMesh then
      begin
        LMeshes.Add(TMesh(Model3D1.Children[I]));
      end;
    end;
    for LMesh in LMeshes do
    begin
      Model3D1.RemoveObject(LMesh);
      LMesh.Free;
    end;
  finally
    LMeshes.Free;
  end;
end;

procedure TMeshCollectionDesigner.CloneMeshCollection(AModel3D: TModel3D);
var
  I: Integer;
  LMesh: TMesh;
begin
  for i := 0 to High(AModel3D.MeshCollection) do
  begin
    LMesh := TMesh(AModel3D.MeshCollection[I].Clone(nil));
    LMesh.HitTest := False;
    LMesh.Lock;
    Model3D1.AddObject(LMesh);
  end;
end;

procedure TMeshCollectionDesigner.FormCreate(Sender: TObject);
const
  ButtonMargin: Integer = 4;
var
  LWidth: Single;
begin
  FCommand := cNone;
  LWidth := Math.Max(115, Canvas.TextWidth(btnLoad.Text) + ButtonMargin * 6);
  LWidth := Math.Max(LWidth, Canvas.TextWidth(btnClear.Text) + ButtonMargin * 6);
  LWidth := Math.Max(LWidth, Canvas.TextWidth(btnOk.Text) + ButtonMargin * 6);
  LWidth := Math.Max(LWidth, Canvas.TextWidth(btnCancel.Text) + ButtonMargin * 6);
  Layout1.Width := LWidth;
  MoveLayout.Width:= LWidth;
end;

procedure TMeshCollectionDesigner.SetScale(const Value: Single);
begin
  if (FScale <> Value) then
  begin
    FScale := Log10(Value);
    TrackBar1.Value := -FScale;
  end;
end;

procedure TMeshCollectionDesigner.TrackBar1Change(Sender: TObject);
begin
  FScale := Power(10, -TrackBar1.Value);
  if Assigned(Model3D1) then
  begin
    Model3D1.Scale.X := FScale;
    Model3D1.Scale.Y := FScale;
    Model3D1.Scale.Z := FScale;
  end;
end;

procedure TMeshCollectionDesigner.btnCancelClick(Sender: TObject);
begin
  Model3D1.Clear;
  ClearMeshes;
  FCommand := cNone;
  ModalResult := mrCancel;
end;


procedure TMeshCollectionDesigner.Viewport1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FDown := PointF(X, Y);
end;

procedure TMeshCollectionDesigner.Viewport1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if (ssLeft in Shift) then
  begin
    { rotate Z }
    CameraX.RotationAngle.X := CameraX.RotationAngle.X + ((Y - FDown.Y) * 0.3);
    { rotate X }
    CameraY.RotationAngle.Y := CameraY.RotationAngle.Y + ((X - FDown.X) * 0.3);
    FDown := PointF(X, Y);
  end;
end;

procedure TMeshCollectionDesigner.Viewport1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
begin
  Camera.Position.Vector := Camera.Position.Vector + Vector3D(0, 0, 1) * ((WheelDelta / 120) * 0.3);
end;


end.
