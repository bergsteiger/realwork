{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Design.Bitmap;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, System.Math, VCL.Forms, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.Types, FMX.Controls, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.Effects, FMX.StdCtrls,
  FMX.NumberBox, System.Actions, FMX.ActnList, FMX.EditBox, FMX.Controls.Presentation;

type
  TBitmapDesigner = class(TForm)
    Button1: TButton;
    Layout1: TLayout;
    Button2: TButton;
    btnOk: TButton;
    ScrollBox1: TScrollBox;
    Preview: TPaintBox;
    labelScale: TLabel;
    trackScale: TTrackBar;
    cropButton: TButton;
    Image1: TImage;
    btnFit: TButton;
    btnOriginal: TButton;
    Button3: TButton;
    newWidth: TNumberBox;
    Label1: TLabel;
    Label2: TLabel;
    newHeight: TNumberBox;
    resizeLayout: TPanel;
    ShadowEffect1: TShadowEffect;
    Button4: TButton;
    Button5: TButton;
    btnResize: TButton;
    btnSave: TButton;
    editControl: TLayout;
    Label3: TLabel;
    ResizeScale: TTrackBar;
    ScaleLabel: TLabel;
    SaveDialog1: TSaveDialog;
    ActionList1: TActionList;
    ActnHelp: TAction;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PreviewPaint(Sender: TObject; const Canvas: TCanvas);
    procedure trackScaleChange(Sender: TObject);
    procedure cropButtonClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure trackScaleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnFitClick(Sender: TObject);
    procedure btnOriginalClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnResizeClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure newWidthChange(Sender: TObject);
    procedure newHeightChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure ResizeScaleChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ActnHelpExecute(Sender: TObject);
  private
    { Private declarations }
    FBitmap: TBitmap;
    FSourceRect: TRectF;
    FCropRect: TSelection;
    FOldScale: single;
    FFileName: string;
    FCheckboardBitmap: TBitmap;
    procedure PrepareCheckboardBitmap;
    function GetScrollBoxRect: TRectF;
    procedure UpdateCropRectMinSize;
    function PrepareForCrop: TRectF;
    procedure UpdateResizeX;
  public
    { Public declarations }
    procedure AssignFromBitmap(B: TBitmap);
    procedure AssignToBitmap(B: TBitmap);
    property FileName: string read FFileName write FFileName;
  end;

resourcestring
  sScaleCaption = 'Scale:';
  sCropCaption = 'Crop';
  sCropCaptionFull = 'Full';

var
  BitmapDesigner: TBitmapDesigner;

implementation

uses
  FMX.Ani;

{$R *.fmx}

procedure TBitmapDesigner.FormCreate(Sender: TObject);
begin
  FBitmap := TBitmap.Create(0, 0);
  FOldScale := 1;
  resizeLayout.Visible := false;
  UpdateResizeX;
end;

procedure TBitmapDesigner.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCheckboardBitmap);
  FreeAndNil(FBitmap);
end;

procedure TBitmapDesigner.FormResize(Sender: TObject);
begin
  UpdateResizeX;
end;

procedure TBitmapDesigner.Button1Click(Sender: TObject);
var
  D: TOpenDialog;
begin
  if (Assigned(FCropRect)) then
  begin
    FreeAndNil(FCropRect);
    cropButton.Text := sCropCaption;
  end;

  D := TOpenDialog.Create(Application);
  try
    D.Filter := TBitmapCodecManager.GetFilterString;
    if D.Execute then
    begin
      FileName := D.FileName;
      FBitmap.LoadFromFile(D.FileName);
      FSourceRect := RectF(0, 0, FBitmap.Width, FBitmap.Height);
      if not SameValue(Preview.Width, FBitmap.Width * trackScale.Value) or
         not SameValue(Preview.Height, FBitmap.Height * trackScale.Value) then
      begin
        Preview.Width := FBitmap.Width * trackScale.Value;
        Preview.Height := FBitmap.Height * trackScale.Value;
      end else
        Preview.Repaint;

      editControl.Enabled := true;
      btnOk.Enabled := true;
    end;
  finally
    D.Free;
  end;
  BringToFront;
end;

procedure TBitmapDesigner.PrepareCheckboardBitmap;
var
  i, j: Integer;
  M: TBitmapData;
begin
  if not Assigned(FCheckboardBitmap) then
  begin
    FCheckboardBitmap := TBitmap.Create(32, 32);
    if FCheckboardBitmap.Map(TMapAccess.Write, M) then
    try
      for j := 0 to FCheckboardBitmap.Height - 1 do
      begin
        for i := 0 to FCheckboardBitmap.Width - 1 do
        begin
          if odd(i div 8) and not odd(j div 8) then
            M.SetPixel(i, j, $FFA0A0A0)
          else if not odd(i div 8) and odd(j div 8) then
            M.SetPixel(i, j, $FFA0A0A0)
          else
            M.SetPixel(i, j, $FFFFFFFF)
        end;
      end;
    finally
      FCheckboardBitmap.Unmap(M);
    end;
  end;
end;

procedure TBitmapDesigner.PreviewPaint(Sender: TObject; const Canvas: TCanvas);
begin
  PrepareCheckboardBitmap;
  Canvas.Fill.Kind := TBrushKind.Bitmap;
  Canvas.Fill.Bitmap.Bitmap := FCheckboardBitmap;
  Canvas.FillRect(RectF(0, 0, RectWidth(FSourceRect) * trackScale.Value, RectHeight(FSourceRect) * trackScale.Value), 0, 0, [], 1);
  if trackScale.Value > 1 then
    Canvas.DrawBitmap(FBitmap, FSourceRect, RectF(0, 0, RectWidth(FSourceRect) * trackScale.Value, RectHeight(FSourceRect) * trackScale.Value), Preview.AbsoluteOpacity, True)
  else
    Canvas.DrawBitmap(FBitmap, FSourceRect, RectF(0, 0, RectWidth(FSourceRect) * trackScale.Value, RectHeight(FSourceRect) * trackScale.Value), Preview.AbsoluteOpacity, False);
end;

procedure TBitmapDesigner.ResizeScaleChange(Sender: TObject);
begin
  newWidth.Value := round(FBitmap.Width * ResizeScale.Value);
  newHeight.Value := round(FBitmap.Height * ResizeScale.Value);
  ScaleLabel.Text := IntToStr(round(ResizeScale.Value * 100)) + '%';
end;

procedure TBitmapDesigner.UpdateCropRectMinSize;
const
  DefaultSelectionMinSize = 15;
  MaxCropMinProp = 4;
begin
  if (FBitmap.Width * trackScale.Value < FCropRect.MinSize * MaxCropMinProp) or
    (FBitmap.Height * trackScale.Value < FCropRect.MinSize * MaxCropMinProp) then
    FCropRect.MinSize := 1
  else
    FCropRect.MinSize := DefaultSelectionMinSize;
end;

procedure TBitmapDesigner.trackScaleChange(Sender: TObject);
begin
  Preview.Width := FBitmap.Width * trackScale.Value;
  Preview.Height := FBitmap.Height * trackScale.Value;

  if FCropRect <> nil then
  begin
    FCropRect.Position.X := (FCropRect.Position.X / FOldScale) * trackScale.Value;
    FCropRect.Position.Y := (FCropRect.Position.Y / FOldScale) * trackScale.Value;
    FCropRect.Width := (FCropRect.Width / FOldScale) * trackScale.Value;
    FCropRect.Height := (FCropRect.Height / FOldScale) * trackScale.Value;
    UpdateCropRectMinSize;
  end;

  FOldScale := trackScale.Value;
  labelScale.Text := sScaleCaption + ' ' + IntToStr(Round(trackScale.Value * 100)) + '%';
end;

function TBitmapDesigner.GetScrollBoxRect: TRectF;
begin
  Result := ScrollBox1.LocalRect;
  if (Result.Width > ScrollBox1.ClientWidth) then
    Result.Width := ScrollBox1.ClientWidth;
  if (Result.Height > ScrollBox1.ClientHeight) then
    Result.Height := ScrollBox1.ClientHeight;
end;

function TBitmapDesigner.PrepareForCrop: TRectF;
var
  ViewRect: TRectF;
  NewScale: Single;
  Pos: TPointF;
begin
  ViewRect := GetScrollBoxRect;

  if (FBitmap.Width < ViewRect.Width) and (FBitmap.Height < ViewRect.Height) then
  begin
    NewScale := 1 / RectF(0, 0, FBitmap.Width, FBitmap.Height).Fit(ViewRect);

    if (NewScale > trackScale.Value) then
      trackScale.Value := NewScale;
  end;
  Pos := ScrollBox1.ViewportPosition;
  Result.Left := Trunc(Min(Pos.X + ScrollBox1.ClientWidth * 0.1,
    FBitmap.Width * 0.1 * trackScale.Value));
  Result.Right := Trunc(Min(Pos.X + ScrollBox1.ClientWidth * 0.9,
    FBitmap.Width * 0.9 * trackScale.Value));
  Result.Top := Trunc(Min(Pos.Y + ScrollBox1.ClientHeight * 0.1,
    FBitmap.Height * 0.1 * trackScale.Value));
  Result.Bottom := Trunc(Min(Pos.Y + ScrollBox1.ClientHeight * 0.9,
    FBitmap.Height * 0.9 * trackScale.Value));
end;

procedure TBitmapDesigner.cropButtonClick(Sender: TObject);
var
  InitCropRect: TRectF;
begin
  if not Assigned(FCropRect) then
  begin
    InitCropRect:= PrepareForCrop;

    FCropRect := TSelection.Create(Self);
    FCropRect.Parent := ScrollBox1;
    cropButton.Text := sCropCaptionFull;
    FCropRect.SetBounds(InitCropRect.Left, InitCropRect.Top, InitCropRect.Width, InitCropRect.Height);
    FCropRect.GripSize:= 4;
    UpdateCropRectMinSize;
  end
  else
  begin
    FreeAndNil(FCropRect);
    Preview.Repaint;
    cropButton.Text := sCropCaption;
  end;
end;

procedure TBitmapDesigner.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TBitmapDesigner.ActnHelpExecute(Sender: TObject);
begin
  VCL.Forms.Application.HelpContext(16510);
end;

procedure TBitmapDesigner.AssignFromBitmap(B: TBitmap);
begin
  FileName := '';
  if B <> nil then
    FBitmap.Assign(B);
  FSourceRect := RectF(0, 0, FBitmap.Width, FBitmap.Height);
  Preview.Width := FBitmap.Width * trackScale.Value;
  Preview.Height := FBitmap.Height * trackScale.Value;
  if B.Width > 1 then
  begin
    editControl.Enabled := true;
    btnOk.Enabled := true;
  end;
end;

procedure TBitmapDesigner.AssignToBitmap(B: TBitmap);
var
  CR: TRectF;
begin
  if B <> nil then
  begin
    if (FCropRect <> nil) and (FCropRect.Width > 0) and (FCropRect.Height > 0) then
    begin
      CR := RectF(FCropRect.Position.X / trackScale.Value, FCropRect.Position.Y / trackScale.Value,
        (FCropRect.Position.X + FCropRect.Width) / trackScale.Value, (FCropRect.Position.Y + FCropRect.Height) / trackScale.Value);
      B.SetSize(Trunc(RectWidth(CR)), Trunc(RectHeight(CR)));
      B.CopyFromBitmap(FBitmap, CR.Round, 0, 0);
    end
    else
    begin
      B.Assign(FBitmap);
    end;
  end;
end;

procedure TBitmapDesigner.UpdateResizeX;
begin
  resizeLayout.Position.Point := TPointF.Create(
    Round(Max(-newHeight.Position.X, (ClientWidth - resizeLayout.Width) / 2)), resizeLayout.Position.Y);
end;

procedure TBitmapDesigner.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TBitmapDesigner.trackScaleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if ssDouble in Shift then trackScale.Value := 1;
end;

procedure TBitmapDesigner.btnFitClick(Sender: TObject);
var
  R: TRectF;
begin
  R := RectF(0, 0, FBitmap.Width, FBitmap.Height);
  trackScale.Value := 1 / R.Fit(GetScrollBoxRect);
end;

procedure TBitmapDesigner.btnOriginalClick(Sender: TObject);
begin
  trackScale.Value := 1;
end;

procedure TBitmapDesigner.Button3Click(Sender: TObject);
begin
  editControl.Enabled := false;
  btnOk.Enabled := true;
  if FCropRect <> nil then cropButtonClick(Self);

  trackScale.Value := 1;
  FBitmap.SetSize(0, 0);
  FSourceRect := RectF(0, 0, FBitmap.Width, FBitmap.Height);
  Preview.Width := FBitmap.Width * trackScale.Value;
  Preview.Height := FBitmap.Height * trackScale.Value;
end;

procedure TBitmapDesigner.btnResizeClick(Sender: TObject);
begin
  if FBitmap.IsEmpty then Exit;
  
  Layout1.Enabled := False;
  
  newWidth.Value := FBitmap.Width;
  newHeight.Value := FBitmap.Height;

  resizeLayout.Visible := true;
  resizeLayout.Position.Y := -resizeLayout.Height;
  TAnimator.AnimateFloat(resizeLayout, 'Position.Y', 0, 0.3);
end;

procedure TBitmapDesigner.Button4Click(Sender: TObject);
var
  tmp: TBitmap;
  SaveFileName: string;
begin
  { resize }
  SaveFileName := FileName;
  tmp := TBitmap.Create(trunc(newWidth.Value), trunc(newHeight.Value));
  if tmp.Canvas.BeginScene then
  try
    tmp.Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height), RectF(0, 0, tmp.Width, tmp.Height), 1);
  finally
    tmp.Canvas.EndScene;
  end;
  AssignFromBitmap(tmp);
  tmp.Free;
  FileName := SaveFileName;
  { }
  TAnimator.AnimateFloatWait(resizeLayout, 'Position.Y', -resizeLayout.Height, 0.3);
  resizeLayout.Visible := false;
  Layout1.Enabled := True;
end;

procedure TBitmapDesigner.Button5Click(Sender: TObject);
begin
  TAnimator.AnimateFloatWait(resizeLayout, 'Position.Y', -resizeLayout.Height, 0.3);
  resizeLayout.Visible := false;
  Layout1.Enabled := True;
end;

procedure TBitmapDesigner.newWidthChange(Sender: TObject);
begin
  if Assigned(FBitmap) and not FBitmap.IsEmpty then
    newHeight.Value := Round(newWidth.Value * (FBitmap.Height / FBitmap.Width));
end;

procedure TBitmapDesigner.newHeightChange(Sender: TObject);
begin
  if Assigned(FBitmap) and not FBitmap.IsEmpty then
    newWidth.Value := Round(newHeight.Value * (FBitmap.Width / FBitmap.Height));
end;

procedure TBitmapDesigner.btnSaveClick(Sender: TObject);
begin
  SaveDialog1.Filter := TBitmapCodecManager.GetFilterString;
  SaveDialog1.FileName := FFileName;
  if SaveDialog1.Execute then
    FBitmap.SaveToFile(SaveDialog1.FileName);
end;

end.
