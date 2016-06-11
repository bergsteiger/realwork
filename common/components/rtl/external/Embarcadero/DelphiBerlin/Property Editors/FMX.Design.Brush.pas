{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Design.Brush;

interface
                             
uses
  System.SysUtils, System.Classes, System.UITypes, System.UIConsts, FMX.Forms,  FMX.Dialogs, FMX.Menus,
  FMX.Types, FMX.Layouts, FMX.Objects, FMX.Controls, FMX.Colors, FMX.Ani, FMX.StdCtrls, FMX.ExtCtrls, FMX.Graphics,
  FMX.TabControl, FMX.Edit, FMX.ListBox, FMX.TreeView, FMX.NumberBox, FmxDesignWindows,
  FMX.Controls.Presentation, FMX.EditBox;

type
  TBrushDesigner = class(TFmxDesignWindow)
    solidQuad: TColorQuad;
    solidPicker: TColorPicker;
    gradQuad: TColorQuad;
    solidCont: TRectangle;
    gradEditor: TGradientEdit;
    Layout1: TLayout;
    ext1: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    gradPicker: TColorPicker;
    BrushTabControl: TTabControl;
    tabNone: TTabItem;
    tabSolid: TTabItem;
    tabGradient: TTabItem;
    Text1: TLabel;
    Text2: TLabel;
    Text3: TLabel;
    brushList: TListBox;
    textSolidR: TNumberBox;
    textSolidG: TNumberBox;
    textSolidB: TNumberBox;
    textSolidA: TNumberBox;
    textGradR: TNumberBox;
    textGradG: TNumberBox;
    textGradB: TNumberBox;
    textGradA: TNumberBox;
    textSolidHex: TEdit;
    textGradHex: TEdit;
    gradColorRect: TColorBox;
    solidColorRect: TColorBox;
    tabBitmap: TTabItem;
    tabRes: TTabItem;
    bitmapImage: TImage;
    Layout5: TLayout;
    btnSelectBitmap: TButton;
    resList: TListBox;
    Layout6: TLayout;
    btnMakeRes: TButton;
    Label1: TLabel;
    Rectangle1: TRectangle;
    tileModeList: TPopupBox;
    btnCancel: TButton;
    btnOK: TButton;
    makeResLayout: TLayout;
    gradAngle: TArcDial;
    gradAlabel: TLabel;
    gradKind: TPopupBox;
    gradAngleLabel: TLabel;
    LabelBitmapKind: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure solidQuadChange(Sender: TObject);
    procedure gradEditorChange(Sender: TObject);
    procedure gradQuadChange(Sender: TObject);
    procedure brushListChange(Sender: TObject);
    procedure BrushTabControlChange(Sender: TObject);
    procedure textGradRChange(Sender: TObject);
    procedure textGradHexChange(Sender: TObject);
    procedure textSolidHexChange(Sender: TObject);
    procedure btnSelectBitmapClick(Sender: TObject);
    procedure btnMakeResClick(Sender: TObject);
    procedure resListChange(Sender: TObject);
    procedure tileModeListChange(Sender: TObject);
    procedure textSolidRChange(Sender: TObject);
    procedure gradAngleChange(Sender: TObject);
    procedure gradKindChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure textGradAChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  private
    FCurrentBrush: TBrush;
    FComponent: TPersistent;
    FOwner: TFmxObject;
    FChanged: Boolean;
    procedure LoadBrushes;
    function CanMakeResources: Boolean;
    procedure FillControls(const Value: TBrush);
    procedure FillGradientColorEdits(const AColor: TAlphaColor);
    function GetGradientColorFromEdits: TAlphaColor;
    procedure RebuilResourceList;
    procedure SetComponent(const Value: TPersistent);
    procedure SetCurrentBrush(const Value: TBrush);
  public
    property Component: TPersistent read FComponent write SetComponent;
    property CurrentBrush: TBrush read FCurrentBrush write SetCurrentBrush;
  end;

  TBrushKinds = set of TBrushKind;

  TBrushDialog = class(TComponent)
  private
    FShowStyles: TBrushKinds;
    FShowBrushList: boolean;
    FShowMakeResource: boolean;
    FBrush: TBrush;
    FComponent: TComponent;
    FTitle: WideString;
    procedure SetBrush(const Value: TBrush);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: boolean;
    property Brush: TBrush read FBrush write SetBrush;
    property Component: TComponent read FComponent write FComponent;
  published
    property ShowStyles: TBrushKinds read FShowStyles write FShowStyles;
    property ShowBrushList: boolean read FShowBrushList write FShowBrushList default true;
    property ShowMakeResource: boolean read FShowMakeResource write FShowMakeResource;
    property Title: WideString read FTitle write FTitle;
  end;

procedure ShowBrushDialog(const Brush: TBrush; const ShowStyles: TBrushKinds; const ShowBrushList: boolean = true);
procedure ShowGradientDialog(const Gradient: TGradient);
function ShowColorDialog(const Color: TAlphaColor): TAlphaColor;

resourcestring
  sMakeResCaption = 'New TBrushObject';
  sMakeResText = 'Enter resource name:';

implementation

uses System.TypInfo, System.Types, FmxDsnConst, FMX.Design.Bitmap, System.Math, FMX.Consts, FMX.DialogService.Sync;

{$R *.fmx}

{ TBrushDesigner ==============================================================}

procedure TBrushDesigner.FillControls(const Value: TBrush);

  procedure FillSolidTab;
  begin
    solidPicker.Color := Value.Color;
  end;

  procedure FillGradientTab;
  var
    Angle: Single;
    H: Single;
    S: Single;
    L: Single;
  begin
    gradEditor.Gradient.Assign(Value.Gradient);
    gradKind.ItemIndex := Integer(gradEditor.Gradient.Style);

    // calculate the angle depending on the start and stop positions of the gradient editor
    with gradEditor.Gradient do
    begin
      Angle := -RadToDeg(ArcTan((StopPosition.Y - StartPosition.Y) / (StopPosition.X - StartPosition.X)));
      if StopPosition.X - StartPosition.X <= 0 then
        Angle := Angle - 180;
      gradAngle.Value := Angle;
      gradAngle.Visible := Style = TGradientStyle.Linear;
    end;

    // first set the color from the first point of the gradient editor to the
    // quad and then update the text fields; it is necessary because
    // the gradient quad event handler changes the color of the first
    // gradient point of the gradient editor
    with gradEditor do
    begin
      RGBtoHSL(Gradient.Points[CurrentPoint].Color, H, S, L);
      gradQuad.Hue := H;
      gradQuad.Sat := S;
      gradQuad.Lum := L;
    end;
    FillGradientColorEdits(gradColorRect.Color);
  end;

  procedure FillBitmapTab;
  begin
    bitmapImage.Bitmap.Assign(Value.Bitmap.Bitmap);
    LabelBitmapKind.Visible := Value is TStrokeBrush;
    tileModeList.ItemIndex := Integer(Value.Bitmap.WrapMode);
  end;

begin
  FillGradientTab;
  FillSolidTab;
  FillBitmapTab;
  RebuilResourceList;
  case Value.Kind of
    TBrushKind.None:
      BrushTabControl.TabIndex := tabNone.Index;
    TBrushKind.Solid:
      BrushTabControl.TabIndex := tabSolid.Index;
    TBrushKind.Gradient:
      BrushTabControl.TabIndex := tabGradient.Index;
    TBrushKind.Bitmap:
      BrushTabControl.TabIndex := tabBitmap.Index;
    TBrushKind.Resource:
      BrushTabControl.TabIndex := tabRes.Index;
  end;
end;

procedure TBrushDesigner.FillGradientColorEdits(const AColor: TAlphaColor);
begin
  textGradR.Value := TAlphaColorRec(AColor).R;
  textGradG.Value := TAlphaColorRec(AColor).G;
  textGradB.Value := TAlphaColorRec(AColor).B;
  textGradA.Value := TAlphaColorRec(AColor).A;
  textGradHex.Text := AlphaColorToString(AColor);
end;

procedure TBrushDesigner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TBrushDesigner.FormCreate(Sender: TObject);
begin
  FChanged := False;
  LabelBitmapKind.Text := SBitmapBrushWindowsOnly;
end;

function TBrushDesigner.GetGradientColorFromEdits: TAlphaColor;
begin
  TAlphaColorRec(Result).R := Trunc(textGradR.Value);
  TAlphaColorRec(Result).G := Trunc(textGradG.Value);
  TAlphaColorRec(Result).B := Trunc(textGradB.Value);
  TAlphaColorRec(Result).A := Trunc(textGradA.Value);
end;

procedure TBrushDesigner.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove) and AComponent.Equals(FComponent) then
  begin
    CurrentBrush := nil;
    Component := nil;
  end;

  if (Operation = opRemove) and AComponent.Equals(FOwner) then
    FOwner := nil;
end;

procedure TBrushDesigner.SetCurrentBrush(const Value: TBrush);
var
  I: Integer;
  Found: Boolean;
begin
  if not Assigned(Value) then Exit;
  FCurrentBrush := Value;

  I := 0;
  Found := False;
  while (I < brushList.Count) and not Found do
  begin
    Found := brushList.ListItems[I].Data as TBrush = FCurrentBrush;
    if not Found then
      Inc(I);
  end;

  if Found then
    brushList.ItemIndex := I
  else
    FillControls(FCurrentBrush);
end;

procedure TBrushDesigner.SetComponent(const Value: TPersistent);
var
  R: IRoot;
begin
  FComponent := Value;
  if Assigned(FComponent) then
  begin
    if Supports(FComponent, IRoot, R) then
      FOwner := R.GetObject
    else
      if (FComponent is TFmxObject) and Assigned(TFmxObject(FComponent).Root) then
        FOwner := TFmxObject(FComponent).Root.GetObject;
  end;

  LoadBrushes;

  btnMakeRes.Visible := CanMakeResources;
end;

procedure TBrushDesigner.solidQuadChange(Sender: TObject);
begin
  if FChanged or not Assigned(FCurrentBrush) then Exit;

  FChanged := True;
  try
    textSolidR.Value := TAlphaColorRec(solidColorRect.Color).R;
    textSolidG.Value := TAlphaColorRec(solidColorRect.Color).G;
    textSolidB.Value := TAlphaColorRec(solidColorRect.Color).B;
    textSolidA.Value := TAlphaColorRec(solidColorRect.Color).A;
    textSolidHex.Text := AlphaColorToString(solidColorRect.Color);

    if BrushTabControl.TabIndex = tabSolid.Index then
      FCurrentBrush.Color := solidQuad.ColorBox.Color;
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.textSolidHexChange(Sender: TObject);
begin
  { change solid hex }
  if FChanged or not Assigned(FCurrentBrush) then Exit;

  FChanged := True;
  try
    FCurrentBrush.Color := StringToAlphaColor(textSolidHex.Text);
    solidPicker.Color := FCurrentBrush.Color;
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.textSolidRChange(Sender: TObject);
var
  Color: TAlphaColor;
begin
  { solid textbox change }
  if FChanged or not Assigned(FCurrentBrush) then Exit;

  FChanged := True;
  try
    TAlphaColorRec(Color).R := Trunc(textSolidR.Value);
    TAlphaColorRec(Color).G := Trunc(textSolidG.Value);
    TAlphaColorRec(Color).B := Trunc(textSolidB.Value);
    TAlphaColorRec(Color).A := Trunc(textSolidA.Value);
    FCurrentBrush.Color := Color;
    solidPicker.Color := FCurrentBrush.Color;
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.gradEditorChange(Sender: TObject);
begin
  { change gradient }
  if FChanged or not Assigned(FCurrentBrush) then Exit;

  FChanged := True;
  try
    FCurrentBrush.Gradient.Assign(gradEditor.Gradient);
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.gradQuadChange(Sender: TObject);
begin
  { chage color in current point }
  if FChanged or not Assigned(FCurrentBrush) then Exit;

  FChanged := True;
  try
    gradEditor.Gradient.Points[gradEditor.CurrentPoint].Color := gradColorRect.Color;
    gradEditor.Repaint;
    FCurrentBrush.Gradient.Assign(gradEditor.Gradient);

    FillGradientColorEdits(gradColorRect.Color);
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.LoadBrushes;

  procedure CreateListItem(const APropertyName: string);
  var
    NewListItem: TListBoxItem;
  begin
    NewListItem := TListBoxItem.Create(Self);
    NewListItem.Parent := brushList;
    NewListItem.Height := 23;
    NewListItem.Data := GetObjectProp(FComponent, APropertyName);
    NewListItem.Text := APropertyName;

    brushList.Height := brushList.Height + NewListItem.Height;
  end;

  function IsBrushProperty(const APropInfoPtr : PPropInfo) : Boolean;
  var
    PropType: PTypeData;
  begin
    Result := Assigned(APropInfoPtr)
         and (APropInfoPtr.PropType^.Kind = tkClass);
    PropType := GetTypeData(APropInfoPtr.PropType{$IFNDEF FPC}^{$ENDIF});
    Result := Result
         and Assigned(PropType)
         and ((PropType.ClassType.ClassName = 'TBrush') or (PropType.ClassType.ClassName = 'TStrokeBrush'));
  end;

var
  PropList: PPropList;
  PropCount: Integer;
  CurrentPropPtr: PPropInfo;
  I: Integer;
begin
  brushList.Clear;
  brushList.Height := 4;
  PropCount := GetPropList(FComponent.ClassInfo, PropList);
  try
    for I := 0 to PropCount - 1 do
    begin
      CurrentPropPtr := PropList[I];
      if not IsBrushProperty(CurrentPropPtr) then Continue;
      CreateListItem(string(CurrentPropPtr.Name));
    end;
    Self.ClientHeight := Trunc(BrushTabControl.Height + brushList.Height + Layout6.Height + 16);
  finally
    FreeMem(PropList, SizeOf(PPropInfo) * PropCount);
  end;
end;

procedure TBrushDesigner.brushListChange(Sender: TObject);
begin
  if not Assigned(FComponent) then Exit;
  if Assigned(Sender) then
  begin
    FCurrentBrush := TBrush(TListBoxItem(Sender).Data);
    FillControls(FCurrentBrush);
  end;
end;

procedure TBrushDesigner.BrushTabControlChange(Sender: TObject);
begin
  if not Assigned(FCurrentBrush) then Exit;

  if BrushTabControl.TabIndex = tabNone.Index then
    FCurrentBrush.Kind := TBrushKind.None;

  if BrushTabControl.TabIndex = tabSolid.Index then
    FCurrentBrush.Kind := TBrushKind.Solid;

  if BrushTabControl.TabIndex = tabGradient.Index then
  begin
    FCurrentBrush.Kind := TBrushKind.Gradient;
    gradQuadChange(Sender);
    gradAngleLabel.Text := InttoStr(Trunc(gradAngle.Value));
  end;

  if BrushTabControl.TabIndex = tabBitmap.Index then
    FCurrentBrush.Kind := TBrushKind.Bitmap;

  if BrushTabControl.TabIndex = tabRes.Index then
    FCurrentBrush.Kind := TBrushKind.Resource;

  btnMakeRes.Visible := CanMakeResources;
  if not btnMakeRes.Visible then
    RebuilResourceList;
end;

procedure TBrushDesigner.textGradRChange(Sender: TObject);
var
  Color: TAlphaColor;
begin
  { change grad brush alpha }
  if FChanged or not Assigned(FCurrentBrush) then Exit;

  FChanged := True;
  try
    Color := GetGradientColorFromEdits;
    gradEditor.Gradient.Points[gradEditor.CurrentPoint].Color := Color;
    gradEditor.UpdateGradient;
    gradEditor.Repaint;

    FCurrentBrush.Gradient.Assign(gradEditor.Gradient);
    textGradHex.Text := AlphaColorToString(Color);
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.gradKindChange(Sender: TObject);
begin
  { change grad type }
  if FChanged or not Assigned(FCurrentBrush) then Exit;
  
  FChanged := True;
  try
    gradEditor.Gradient.Style := TGradientStyle(gradKind.ItemIndex);
    gradEditor.UpdateGradient;
    gradEditor.Repaint;
    gradAngle.Visible := gradEditor.Gradient.Style = TGradientStyle.Linear;
    FCurrentBrush.Gradient.Style := gradEditor.Gradient.Style;
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.gradAngleChange(Sender: TObject);
var
  X, Y, Koef: Single;
  Radian: Single;
  CosRadian: Single;
  SinRadian: Single;
begin
  { change grad brush alpha }
  if not Assigned(FCurrentBrush) then Exit;

  Radian := DegToRad(gradAngle.Value);
  CosRadian := Cos(Radian);
  SinRadian := Sin(Radian);
  if (CosRadian <> 0) and (Abs(1 / CosRadian) >= 1) and (Abs(1 / CosRadian) <= 1.42) then
    X := Abs(1 / CosRadian)
  else
    X := 1;

  if (SinRadian <> 0) and (Abs(1 / SinRadian) >= 1) and (Abs(1 / SinRadian) <= 1.42) then
    Y := Abs(1 / SinRadian)
  else
    Y := 1;

  Koef := Max(X, Y);
  Koef := Koef * 0.5;
  gradEditor.Gradient.StartPosition.Point := PointF(0.5 - (CosRadian * Koef), 0.5 + (SinRadian * Koef));
  gradEditor.Gradient.StopPosition.Point := PointF(0.5 + (CosRadian * Koef), 0.5 - (SinRadian * Koef));
  gradEditor.UpdateGradient;
  gradAngleLabel.Text := IntToStr(Trunc(gradAngle.Value));
end;

procedure TBrushDesigner.textGradAChange(Sender: TObject);
begin
  if FChanged then Exit;

  FChanged := True;
  try
    gradQuad.Alpha := textGradA.Value / $FF;
    gradEditor.Gradient.Points[gradEditor.CurrentPoint].Color := gradColorRect.Color;
    gradEditor.UpdateGradient;
    gradEditor.Repaint;
    FCurrentBrush.Gradient.Assign(gradEditor.Gradient);
    textGradHex.Text := AlphaColorToString(gradEditor.Gradient.Points[gradEditor.CurrentPoint].IntColor);
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.textGradHexChange(Sender: TObject);
var
  LColor: TAlphaColor;
begin
  { change gradient hex }
  if FChanged or not Assigned(FCurrentBrush) then Exit;

  FChanged := True;
  try
    try
      LColor := StringToAlphaColor(textGradHex.Text);
      gradEditor.Gradient.Points[gradEditor.CurrentPoint].IntColor := LColor;
      gradEditor.UpdateGradient;
      gradEditor.Repaint;
      FCurrentBrush.Gradient.Assign(gradEditor.Gradient);
    except
      textGradHex.Text := AlphaColorToString(gradEditor.Gradient.Points[gradEditor.CurrentPoint].IntColor);
      TDialogServiceSync.ShowMessage(SInvalidColorString);
    end;
  finally
    FChanged := False;
  end;
end;

procedure TBrushDesigner.btnSelectBitmapClick(Sender: TObject);
begin
  if not Assigned(FCurrentBrush) then Exit;

  BitmapDesigner := TBitmapDesigner.Create(nil);
  with BitmapDesigner do
    try
      AssignFromBitmap(bitmapImage.Bitmap);
      if ShowModal = mrOk then
      begin
        AssignToBitmap(bitmapImage.Bitmap);
        FCurrentBrush.Bitmap.Bitmap := bitmapImage.Bitmap;
        if Assigned(FComponent) and (FComponent is TControl) then
          TControl(FComponent).Repaint;
        bitmapImage.Repaint;
      end;
    finally
      Free;
    end;
end;

function TBrushDesigner.CanMakeResources: Boolean;
begin
  Result := (BrushTabControl.TabIndex <> tabRes.Index)
        and (BrushTabControl.TabIndex <> tabNone.Index)
        and Assigned(FOwner);
end;

procedure TBrushDesigner.RebuilResourceList;

  procedure CreateAndAppendResourceListItem(ABrushObject : TBrushObject);
  var
    ListBoxItem: TListBoxItem;
    ItemColorRect: TRectangle;
    ItemText: TText;
  begin
    if not Assigned(ABrushObject) then Exit;

    ListBoxItem := TListBoxItem.Create(Self);
    ListBoxItem.Data := ABrushObject;
    ListBoxItem.Parent := resList;

    {$REGION 'Color area'}
    ItemColorRect := TRectangle.Create(Self);
    with ItemColorRect do
    begin
      Parent := ListBoxItem;
      Align := TAlignLayout.Left;
      HitTest := False;
      Padding.Rect := RectF(2, 2, 2, 2);
      Fill.Kind := TBrushKind.Resource;
      Fill.Resource.StyleResource := ABrushObject;
      Stroke.Color := $80FFFFFF;
    end;
    {$ENDREGION}

    {$REGION 'Text area'}
    ItemText := TText.Create(Self);
    with ItemText do
    begin
      Parent := ListBoxItem;
      Align := TAlignLayout.Client;
      Text := ABrushObject.StyleName;
      HorzTextAlign := TTextAlign.Leading;
      Padding.Rect := RectF(2, 2, 2, 2);
    end;
    {$ENDREGION}
  end;

var
  I: Integer;
  ResourcesList: TFmxObjectList;
begin
  if not Assigned(FCurrentBrush) or not Assigned(FOwner) then Exit;

  resList.Clear;
  ResourcesList := TFmxObjectList.Create;
  try
    FOwner.AddObjectsToList(ResourcesList);
    for I := 0 to ResourcesList.Count - 1 do
      if ResourcesList[I] is TBrushObject then
      begin
        CreateAndAppendResourceListItem(TBrushObject(ResourcesList[I]));

        if FCurrentBrush.Resource.StyleResource = TBrushObject(ResourcesList[I]) then
          resList.ItemIndex := resList.Count - 1;
      end;
  finally
    ResourcesList.Free;
  end;
end;

procedure TBrushDesigner.resListChange(Sender: TObject);
begin
  if not Assigned(FCurrentBrush) or not Assigned(Sender) then Exit;

  FCurrentBrush.Assign(TBrushObject(TListBoxItem(Sender).Data).Brush);
  FCurrentBrush.Resource.StyleResource := TBrushObject(TListBoxItem(Sender).Data);
  FCurrentBrush.Kind := TBrushKind.Resource;
end;

procedure TBrushDesigner.btnMakeResClick(Sender: TObject);
var
  S: string;
  B: TBrushObject;
begin
  { make res }
  if not Assigned(Designer) then Exit;

  S := Designer.UniqueName('Brush');
  if TDialogServiceSync.InputQuery(sMakeResCaption, [sMakeResText], S) then
  begin
    B := TBrushObject.Create(FOwner);
    B.Parent := FOwner;
    B.StyleName := S;
    B.Name := S;
    B.Brush.Assign(FCurrentBrush);
    RebuilResourceList;
  end;
end;

procedure TBrushDesigner.tileModeListChange(Sender: TObject);
begin
  if not Assigned(FCurrentBrush) then Exit;
  FCurrentBrush.Bitmap.WrapMode := TWrapMode(tileModeList.ItemIndex);
  if Assigned(FComponent) and (FComponent is TControl) then
    TControl(FComponent).Repaint;
end;

{ TBrushDialog }

procedure ShowBrushDialog(const Brush: TBrush; const ShowStyles: TBrushKinds; const ShowBrushList: boolean);
var
  Dlg: TBrushDialog;
begin
  Dlg := TBrushDialog.Create(nil);
  try
    Dlg.Brush := Brush;
    Dlg.ShowStyles := ShowStyles;
    Dlg.ShowBrushList := ShowBrushList;
    if Dlg.Execute then
      Brush.Assign(Dlg.Brush);
  finally
    Dlg.Free;
  end;
end;

procedure ShowGradientDialog(const Gradient: TGradient);
var
  Dlg: TBrushDialog;
begin
  Dlg := TBrushDialog.Create(nil);
  try
    Dlg.Brush.Kind := TBrushKind.Gradient;
    Dlg.Brush.Gradient := Gradient;
    Dlg.ShowStyles := [TBrushKind.Gradient];
    Dlg.ShowBrushList := False;
    if Dlg.Execute then
      Gradient.Assign(Dlg.Brush.Gradient);
  finally
    Dlg.Free;
  end;
end;

function ShowColorDialog(const Color: TAlphaColor): TAlphaColor;
var
  Dlg: TBrushDialog;
begin
  Dlg := TBrushDialog.Create(nil);
  try
    Dlg.Brush.Kind := TBrushKind.Solid;
    Dlg.Brush.Color := Color;
    Dlg.ShowStyles := [TBrushKind.Solid];
    Dlg.ShowBrushList := False;
    if Dlg.Execute then
      Result := Dlg.Brush.Color
    else
      Result := Color;
  finally
    Dlg.Free;
  end;
end;

constructor TBrushDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBrush := TBrush.Create(TBrushKind.Solid, TAlphaColors.Gray);
  FShowStyles := [TBrushKind.None, TBrushKind.Solid, TBrushKind.Gradient,
                  TBrushKind.Bitmap, TBrushKind.Resource];
  FShowBrushList := True;
  FShowMakeResource := False;
  FTitle := 'Brush';
end;

destructor TBrushDialog.Destroy;
begin
  FBrush.Free;
  inherited;
end;

function TBrushDialog.Execute: boolean;
var
  Dialog: TBrushDesigner;
begin
  Dialog := TBrushDesigner.Create(Application);
  try
    Dialog.brushList.Visible := ShowBrushList;
    if Assigned(FComponent) then
      Dialog.Component := FComponent
    else
      Dialog.brushList.Visible := False;

    Dialog.tabNone.Visible := TBrushKind.None in ShowStyles;
    Dialog.tabSolid.Visible := TBrushKind.Solid in ShowStyles;
    Dialog.tabGradient.Visible := TBrushKind.Gradient in ShowStyles;
    Dialog.tabBitmap.Visible := TBrushKind.Bitmap in ShowStyles;
    Dialog.tabRes.Visible := TBrushKind.Resource in ShowStyles;
    Dialog.btnOK.Visible := True;
    Dialog.btnCancel.Visible := True;

    Dialog.CurrentBrush := FBrush;
    Dialog.makeResLayout.Visible := ShowMakeResource;
    Dialog.ClientHeight := Trunc(Dialog.Layout6.Position.Y + Dialog.Layout6.Height);
    Result := Dialog.ShowModal = mrOk;
  finally
    Dialog.Free;
  end;
end;

procedure TBrushDialog.SetBrush(const Value: TBrush);
begin
  FBrush.Assign(Value);
end;

end.

