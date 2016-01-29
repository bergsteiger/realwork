unit IWDsnPaintHandlers;

interface

uses
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  {$IFDEF Linux}QButtons, {$ELSE}Buttons,{$ENDIF}
  {$IFDEF Linux}Types, {$ELSE}Windows,{$ENDIF}
  IWControl, IWFont, Classes, IWDsnPaint;

type
  TIWPaintHandlerRadioGroup = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerRectangle = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerMenu = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerLabel = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerButton = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerEdit = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerCheckBox = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerComboBox = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerListBox = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerMemo = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerLink = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerText = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerImage = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerHRule = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerList = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerDBNavigator = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerCSNavigator = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

implementation

{$R IWDB.res}

uses
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  {$IFDEF Linux}QDBCtrls,{$ELSE}DBCtrls,{$ENDIF}
  IWFormDsn, IWExtCtrls, IWCompRectangle, Math, IWCompMenu,
  IWAppForm, IWCompLabel, IWCompButton, IWCompEdit,
  IWCompCheckbox, IWCompListbox, IWCompMemo, IWHTMLControls,
  IWCompText, IWDBStdCtrls,  IWCSStdCtrls, IWGrids,
  SysUtils, SWSystem;

{ TIWPaintHandlerRadioGroup }

procedure TIWPaintHandlerRadioGroup.Paint;
var
  i: Integer;
  LHeight: Integer;
  LWidth: Integer;
  LLeft: Integer;
  LRadioGroup: TIWRadioGroup;
  LText: string;
  LTop: Integer;
begin
  LRadioGroup := FControl as TIWRadioGroup;
  if LRadioGroup.Items.Count = 0 then begin
    DrawOutline;
  end else begin
    SetTransparent;
    with FControl.Canvas do begin
      SetCanvasFont(LRadioGroup.Font);
      LLeft := 0;
      LTop := 0;
      if LRadioGroup.Items.Count > 0 then begin
        LText := LRadioGroup.Items[0];
        LHeight := Max(TextHeight(LText), 12) + 2;
        LWidth := TextWidth(LText) + 18;
        for i := 0 to LRadioGroup.Items.Count - 1 do begin
          DrawResource(iif(LRadioGroup.ItemIndex = i, 'RadioButtonChecked', 'RadioButtonUnchecked')
           , LLeft, LTop);
          TextOut(LLeft + 14, LTop, LRadioGroup.Items[i]);
          if LRadioGroup.Layout = glVertical then begin
            LTop := LTop + LHeight;
          end else begin
            LLeft := LLeft + LWidth;
          end;
        end;
      end;
    end;
  end;
end;

{ TIWPaintHandlerRectangle }

procedure TIWPaintHandlerRectangle.Paint;
var
  LRect: TIWCustomRectangle;
  LTextRect: TRect;
begin
  LRect := FControl as TIWCustomRectangle;
  with FControl.Canvas do begin
    if LRect.Color = clNone then begin
      DrawOutline;
    end else begin
      Brush.Color := LRect.Color;
      Brush.Style := bsSolid;
      Pen.Color := LRect.Color;
      Rectangle(0, 0, LRect.Width, LRect.Height);
    end;
    if Font.Color = clNone then begin
      Font.Color := clBlack;
    end;
    SetCanvasFont(LRect.Font);
    LTextRect := Rect(0, 0, TextWidth(LRect.Text), TextHeight(LRect.Text));
    case LRect.Alignment of
      taRightJustify: begin
        LTextRect.Left := LRect.Width - LTextRect.Right;
      end;
      taCenter: begin
        LTextRect.Left := (LRect.Width - LTextRect.Right) div 2;
      end;
    end;

    case LRect.VAlign of
      vaMiddle: LTextRect.Top := (LRect.Height - LTextRect.Bottom) div 2;
      vaBottom: LTextRect.Top := LRect.Height - LTextRect.Bottom;
      // vaBaseline: LTextRect.Top := LRect.Height - LTextRect.Bottom;
    end;
    TextOut(LTextRect.Left, LTextRect.Top, LRect.Text);
  end;
end;

{ TIWPaintHandlerMenu }

procedure TIWPaintHandlerMenu.Paint;
var
  IDx: integer;
  AutoXY: integer;
  // iWidth, iHeight: integer;
  LMenuControl: TIWMenu;
begin
  AutoXY := 0;
  LMenuControl := FControl as TIWMenu;
  Draw3DBox;
//  FCanvas.Font.Assign(Font);
  with LMenuControl do begin
    Canvas.Brush.Color := MenuStyle.Color;
    Canvas.Font.Color := MenuStyle.Font.Color;
    Canvas.Pen.Color := MenuStyle.HighlightColor;
    Canvas.Pen.Width := 2;
    Canvas.Font.Style := MenuStyle.Font.Style;
    Canvas.Font.Size := MenuStyle.Font.Size;
    Canvas.Font.Color := MenuStyle.Font.Color;
    Canvas.Font.Name := MenuStyle.Font.Name;
    Canvas.FillRect(Rect(0, 0, Width, Height));
  end;

  //	Draw the attached menu - top level only
  if Assigned(LMenuControl.AttachedMenu) and (LMenuControl.AttachedMenu.Items.Count > 0) then
  begin
    if LMenuControl.AutoSize <> mnaNone then
    begin
      if LMenuControl.Orientation = iwOHorizontal then
      begin
        if LMenuControl.ItemSpacing = itsEvenlySpaced then
          AutoXY := (LMenuControl.Width div LMenuControl.AttachedMenu.Items.Count)
        else
          AutoXY := (TIWAppForm(LMenuControl.Owner).Width div LMenuControl.AttachedMenu.Items.Count)
      end else
      begin
        if LMenuControl.ItemSpacing = itsEvenlySpaced then
          AutoXY := (LMenuControl.Height div LMenuControl.AttachedMenu.Items.Count)
        else
          AutoXY := (TIWAppForm(LMenuControl.Owner).Height div LMenuControl.AttachedMenu.Items.Count);
      end;
    end;

    for IDX := 0 to LMenuControl.AttachedMenu.Items.Count - 1 do
    begin
      if LMenuControl.Orientation = iwOHorizontal then
      begin
        if LMenuControl.AutoSize <> mnaNone then
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(LMenuControl.TextOffset + (AutoXY * IDx) + 1,
            (LMenuControl.MenuStyle.Height - LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption))) shr 1,
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          {$IFDEF Linux}
          LMenuControl.Canvas.Rectangle(Rect(LMenuControl.TextOffset + (AutoXY * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
          {$ELSE}
          LMenuControl.Canvas.FrameRect(Rect(LMenuControl.TextOffset + (AutoXY * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
          {$ENDIF}
        end else
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 1,
            (LMenuControl.MenuStyle.Height - LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption))) shr 1,
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          {$IFDEF Linux}
          LMenuControl.Canvas.Rectangle(Rect(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
          {$ELSE}
          LMenuControl.Canvas.FrameRect(Rect(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
          {$ENDIF}
        end;
      end else
      begin
        if LMenuControl.AutoSize <> mnaNone then
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(1, LMenuControl.TextOffset + (AutoXY * IDx) + (LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption)) shr 1),
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          {$IFDEF Linux}
          LMenuControl.Canvas.Rectangle(Rect(2, LMenuControl.TextOffset + (AutoXY * IDx) + 2,
            LMenuControl.MenuStyle.Width - 2, LMenuControl.TextOffset + (LMenuControl.MenuStyle.Height * (IDx + 1)) - 2));
          {$ELSE}
          LMenuControl.Canvas.FrameRect(Rect(2, LMenuControl.TextOffset + (AutoXY * IDx) + 2,
            LMenuControl.MenuStyle.Width - 2, LMenuControl.TextOffset + (LMenuControl.MenuStyle.Height * (IDx + 1)) - 2));
          {$ENDIF}
        end else
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(1, LMenuControl.TextOffset + (LMenuControl.MenuStyle.Height * IDx) +
            (LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption)) shr 1),
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          {$IFDEF Linux}
          LMenuControl.Canvas.Rectangle(Rect(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
          {$ELSE}
          LMenuControl.Canvas.FrameRect(Rect(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
          {$ENDIF}
        end;
      end;
    end;
    //FCanvas.TextOut(4, (Height - FCanvas.TextHeight('No Menu')) shr 1, FAttachedMenu.Name);
  end else
    LMenuControl.Canvas.TextOut(4, (LMenuControl.Height - LMenuControl.Canvas.TextHeight('No Menu')) shr 1, 'No menu attached');
end;

{ TIWPaintHandlerLabel }

procedure TIWPaintHandlerLabel.Paint;
var
  LWidth: Integer;
  LLabel: TIWCustomLabel;
begin
  LLabel := FControl as TIWCustomLabel;
  with FControl.Canvas do begin
    {$IFNDEF Linux}
    TextFlags := 0;
    {$ENDIF}
    // Transparent. Do NOT set Brush.Color after this, it will reset this to bsSolid.
    Brush.Style := bsClear;
    SetCanvasFont(LLabel.Font);
    if LLabel.Align = alNone then begin
      if LLabel.AutoSize then begin
        LWidth := Trunc(TextWidth(LLabel.Caption) * 1.10);
      end else begin
        LWidth := LLabel.Width;
      end;
    end
    else begin
      LWidth := LLabel.Width;
    end;
    TextRect(Rect(0, 0, LWidth, TextHeight(LLabel.Caption)), 0, 0, LLabel.Caption);
    if (LLabel.Align = alNone) and LLabel.AutoSize then begin
      LLabel.Width := LWidth;
      LLabel.Height := TextHeight(LLabel.Caption);
    end;
  end;
end;

procedure TIWPaintHandlerButton.Paint;
var
  LRect: TRect;
  LButton: TIWCustomButton;
begin
  LButton := FControl as TIWCustomButton;
  with FControl.Canvas do begin
    LRect := DrawButton(Rect(0, 0, LButton.Width - 1, LButton.Height - 1), 1);
    Brush.Style := bsSolid;
    if LButton.Color <> clNone then begin
      Brush.Color := LButton.Color;
    end else begin
      Brush.Color := clWhite;
    end;
    FillRect(LRect);
    SetCanvasFont(LButton.Font);
    TextRect(LRect, Max(0, (LRect.Right - LRect.Left - TextWidth(LButton.Caption)) div 2)
      , Max(0, (LRect.Bottom - LRect.Top - TextHeight(LButton.Caption)) div 2), LButton.Caption);
  end;
end;

{ TIWPaintHandlerEdit }

procedure TIWPaintHandlerEdit.Paint;
Var
  LEdit: TIWCustomEdit;
begin
  LEdit := FControl as TIWCustomEdit;
  with FControl.Canvas do begin
    Draw3DBox;
    SetCanvasFont(LEdit.Font);
    if LEdit.BGColor <> clNone then begin
      Brush.Color := LEdit.BGColor;
    end else begin
      Brush.Color := clWhite;
    end;
    TextRect(Rect(2, 2, LEdit.Width - 2, LEdit.Height - 2), 2, 2, LEdit.Text);
  end;
end;

{ TIWPaintHandlerCheckBox }

procedure TIWPaintHandlerCheckBox.Paint;
Var
  LCheckBox: TIWCustomCheckBox;
begin
  LCheckBox := FControl as TIWCustomCheckBox;
  with FControl.Canvas do begin
    Draw3DBox(2, 2, 15, 15);
    Brush.Style := bsSolid;
    Brush.Color := clWhite;
    Rectangle(4, 4, 13, 13);
    SetCanvasFont(LCheckBox.Font);
    Brush.Style := bsClear;
    TextRect(Rect(20, 2, LCheckBox.Width - 1, LCheckBox.Height - 2), 20, 2, LCheckBox.Caption);
    if LCheckBox.Checked then begin
      Pen.Color := clBlack;
      Brush.Color := clBlack;
      Brush.Style := bsSolid;
      Polygon([Point(5, 7), Point(5, 9), Point(7, 11), Point(11, 7)
       , Point(11, 5), Point(7, 9), Point(5, 7)]);
    end;
  end;
end;

{ TIWPaintHandlerComboBox }

procedure TIWPaintHandlerComboBox.Paint;
var
  LRect: TRect;
  LComboBox: TIWCustomComboBox;
begin
  LComboBox := FControl as TIWCustomComboBox;
  with FControl.Canvas, LComboBox do begin
    Draw3DBox;
    SetCanvasFont(LComboBox.Font);
    Brush.Color := clWhite;
    if (ItemIndex >= 0) and (ItemIndex < Items.Count) then begin
      if LComboBox.ItemsHaveValues then begin
        TextRect(Rect(2, 2, Width - 18, Height - 2), 2, 2, Items.Values[Items.Names[ItemIndex]]);
      end
      else begin
        TextRect(Rect(2, 2, Width - 18, Height - 2), 2, 2, Items[ItemIndex]);
      end;
    end else begin
      Rectangle(2, 2, Width - 18, Height - 2);
    end;
  //  FCanvas.MoveTo(Width - 16, Height -1);
  //  FCanvas.LineTo(Width - 16, Height -1);
    LRect := DrawButton(Rect(Width - 17, Height - 18, Width - 2, Height - 2));
    //TODO : Button not EXACTLY the same but will do for now. View under zoom 5:1 to see diff
    DrawArrow(LRect, adDown);
  end;
end;

{ TIWPaintHandlerListBox }

procedure TIWPaintHandlerListBox.Paint;
var
  Ln, YPos, Bt: Integer;
  LText: string;
  LListBox: TIWCustomListbox;
begin
  LListBox := FControl as TIWCustomListbox;
  with FControl.Canvas do begin
    Brush.Color := clWhite;
    Brush.Style := bsSolid;
    FillRect(Rect(0, 0, LListBox.Width, LListBox.Height));

    Draw3DBox;
    Ln := 0;
    YPos := 1;
    while (YPos < LListBox.Height - 2) and (Ln < LListBox.Items.Count) do begin
      SetCanvasFont(LListBox.Font);
      with LListBox do begin
        if ItemsHaveValues then begin
          LText := Items.Values[Items.Names[Ln]];
        end
        else begin
          LText := Items[Ln];
        end;
      end;

      if Length(LText) < 1 then begin
        LText := ' ';
      end;
      Bt := YPos + TextHeight(LText);
      if Bt >= LListBox.Height - 2 then begin
        Bt := LListBox.Height - 2;
      end;
      if (not LListBox.MultiSelect and (LListBox.ItemIndex = Ln)) or (LListBox.MultiSelect and LListBox.Selected[ln]) then begin
        Font.Color := clWhite;
        Brush.Color := clBlack;
      end else begin
        // Font.Color := LListBox.Font.Color;
        Brush.Color := clWhite;
      end;
      { TODO : Fix black marker on line }
      TextRect(Rect(4, YPos + 2, LListBox.Width - 5, Bt), 4, YPos + 2, LText);
      // Font.Color := LListBox.Font.Color;
      Brush.Color := clNone;

      Inc(Ln);
      YPos := Bt;
    end;
  end;
end;

{ TIWPaintHandlerMemo }

procedure TIWPaintHandlerMemo.Paint;
Var
  LMemo: TIWCustomMemo;
begin
  LMemo := FControl as TIWCustomMemo;
  with FControl.Canvas, LMemo do begin
    Draw3DBox;
    Brush.Color := clWhite;
    Rectangle(Rect(2, 2, Width - 16, Height - 2));
    SetCanvasFont(LMemo.Font);
    DrawTextLines(Rect(3, 2, Width - 15, Height - 1), LMemo.Lines);
    DrawScrollbar(Rect(Width - 16, 1, Width - 1, Height - 1));
  end;
end;

{ TIWPaintHandlerLink }

procedure TIWPaintHandlerLink.Paint;
Var
  LLink: TIWLinkBase;
begin
  LLink := FControl as TIWLinkBase;
  with FControl.Canvas do begin
    SetCanvasFont(LLink.Font);
    Brush.Style := bsClear;
    Font.Style := Font.Style + [fsUnderline];
    TextOut(0, 0, LLink.Caption);
  end;
end;

{ TIWPaintHandlerText }

procedure TIWPaintHandlerText.Paint;
Var
  LText: TIWCustomText;
begin
  LText := FControl as TIWCustomText;
  with FControl.Canvas do begin
    SetTransparent;
    if LText.Lines.Count = 0 then begin
      DrawOutline;
      DrawResource(FControl.ClassName, (FControl.Width - 24) div 2, (FControl.Height - 24) div 2);
    end else begin
      SetCanvasFont(LText.Font);
      DrawTextLines(Rect(1, 1, LText.Width - 2, LText.Height - 2), LText.Lines);
    end;
  end;
end;

{ TIWPaintHandlerImage }

procedure TIWPaintHandlerImage.Paint;
Var
  LImage: TIWCustomImage;
begin
  LImage := FControl as TIWCustomImage;
  with FControl.Canvas do begin
    // FPicture is nil during initial create at design time for TIWImageFile (inherited Create)
    if LImage.Picture <> nil then begin
      if LImage.Picture.Graphic <> nil then begin
        Draw(0, 0, LImage.Picture.Graphic);
      end
      else begin
        with TIWPaintHandlerComponent.Create(FControl) do begin
          Paint;
          Free;
        end;
      end;
    end;
  end;
end;

{ TIWPaintHandlerHRule }

procedure TIWPaintHandlerHRule.Paint;
begin
  with FControl.Canvas do begin
    Pen.Color := clBlack;
    Pen.Width := 3;
    MoveTo(0, 0);
    LineTo(FControl.Width, 0)
  end;
end;

{ TIWPaintHandlerList }

procedure TIWPaintHandlerList.Paint;
var
  i, LHeight: integer;
  s: string;
  LList: TIWList;
begin
  LList := FControl as TIWList;
  with FControl.Canvas do begin
    SetTransparent;
    SetCanvasFont(LList.Font);
    if LList.Items.Count > 0 then begin
      LHeight := TextHeight(LList.Items[0]);
      for i := 0 to LList.Items.Count - 1 do begin
        s := LList.Items[i];
        if LList.Numbered then begin
          s := IntToStr(i + 1) + ' ' + s;
        end else begin
          //TODO: Change to a real bullet
          s := '* ' + s;
        end;
        TextOut(0, i * LHeight, s);
      end;
    end;
  end;
end;

{ TIWPaintHandlerDBNavigator }

procedure TIWPaintHandlerDBNavigator.Paint;
var
  ARect: TRect;
  iLeft, iTop: Integer;
  dLeft, dTop: Integer;
  ABitMap: {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap;
  LNavigator: TIWDBNavigator;
begin
  // Depending on number of buttons do the painting.
  iLeft := 0;
  iTop := 0;
  dLeft := 0;
  dTop := 0;

  LNavigator := FControl as TIWDBNavigator;

  with LNavigator do begin
    case Orientation of
      orHorizontal: begin
       dLeft := ImageWidth + 2;
       dTop := 0;
      end;
      orVertical: begin
        dLeft := 0;
        dTop := ImageHeight + 2;
      end;
    end;

    if nbFirst in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adLeft);
      FControl.Canvas.MoveTo(ARect.Left + 5, ARect.Top + 5);
      FControl.Canvas.LineTo(ARect.Left + 5, ARect.Bottom - 5);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbPrior in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adLeft);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbNext in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adRight);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbLast in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adRight);
      FControl.Canvas.MoveTo(ARect.Right - 5, ARect.Top + 5);
      FControl.Canvas.LineTo(ARect.Right - 5, ARect.Bottom - 5);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbInsert in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      with FControl.Canvas do begin
        Brush.Color := clBlack;
        { TODO : Touch plus sign }
        Rectangle(iLeft + 9, iTop + 6, iLeft + 12, iTop + 16);
        Rectangle(iLeft + 6, iTop + 9, iLeft + 15, iTop + 13);
      end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbDelete in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      with FControl.Canvas do begin
        Brush.Color := clBlack;
        Rectangle(iLeft + 6, iTop + 9, iLeft + 16, iTop + 13);
      end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbEdit in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 2, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 2), adUp);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    { TODO : Do these three pending }
    if nbPost in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      ABitMap := {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap.Create; try
        ABitMap.LoadFromResourceName(HInstance, 'IW_POST');
        FControl.Canvas.Draw(iLeft + 2, iTop + 3, ABitMap);
      finally ABitMap.Free; end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbCancel in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      ABitMap := {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap.Create; try
        ABitMap.LoadFromResourceName(HInstance, 'IW_CANCEL');
        FControl.Canvas.Draw(iLeft + 2, iTop + 1, ABitMap);
      finally ABitMap.Free; end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbRefresh in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      ABitMap := {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap.Create; try
        ABitMap.LoadFromResourceName(HInstance, 'IW_REFRESH');
        FControl.Canvas.Draw(iLeft + 2, iTop + 1, ABitMap);
      finally
        ABitMap.Free;
      end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if Align = alNone then begin
      case Orientation of
        orHorizontal: Width := iLeft;
        orVertical: Height := iTop;
      end;
    end;
  end;
end;

{ TIWPaintHandlerCSNavigator }

procedure TIWPaintHandlerCSNavigator.Paint;
var
  ARect: TRect;
  iLeft, iTop: Integer;
  dLeft, dTop: Integer;
  ABitMap: {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap;
  LNavigator: TIWCSCustomNavigator;
begin
  // Depending on number of buttons do the painting.
  iLeft := 0;
  iTop := 0;
  dLeft := 0;
  dTop := 0;

  LNavigator := FControl as TIWCSCustomNavigator;

  with LNavigator do begin
    case Orientation of
      orHorizontal: begin
       dLeft := ImageWidth + 2;
       dTop := 0;
      end;
      orVertical: begin
        dLeft := 0;
        dTop := ImageHeight + 2;
      end;
    end;

    if nbFirst in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adLeft);
      FControl.Canvas.MoveTo(ARect.Left + 5, ARect.Top + 5);
      FControl.Canvas.LineTo(ARect.Left + 5, ARect.Bottom - 5);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbPrior in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adLeft);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbNext in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adRight);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbLast in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 3, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 4), adRight);
      FControl.Canvas.MoveTo(ARect.Right - 5, ARect.Top + 5);
      FControl.Canvas.LineTo(ARect.Right - 5, ARect.Bottom - 5);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbInsert in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      with FControl.Canvas do begin
        Brush.Color := clBlack;
        { TODO : Touch plus sign }
        Rectangle(iLeft + 9, iTop + 6, iLeft + 12, iTop + 16);
        Rectangle(iLeft + 6, iTop + 9, iLeft + 15, iTop + 13);
      end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbDelete in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      with FControl.Canvas do begin
        Brush.Color := clBlack;
        Rectangle(iLeft + 6, iTop + 9, iLeft + 16, iTop + 13);
      end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbEdit in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      DrawArrow(Rect(ARect.Left + 2, ARect.Top + 3, ARect.Right - 3, ARect.Bottom - 2), adUp);
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    { TODO : Do these three pending }
    if nbPost in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      ABitMap := {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap.Create; try
        ABitMap.LoadFromResourceName(HInstance, 'IW_POST');
        FControl.Canvas.Draw(iLeft + 2, iTop + 3, ABitMap);
      finally ABitMap.Free; end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbCancel in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      ABitMap := {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap.Create; try
        ABitMap.LoadFromResourceName(HInstance, 'IW_CANCEL');
        FControl.Canvas.Draw(iLeft + 2, iTop + 1, ABitMap);
      finally ABitMap.Free; end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if nbRefresh in VisibleButtons then begin
      ARect := DrawButton(Rect(iLeft, iTop, iLeft + ImageWidth, iTop + ImageHeight), iLeft);
      ABitMap := {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap.Create; try
        ABitMap.LoadFromResourceName(HInstance, 'IW_REFRESH');
        FControl.Canvas.Draw(iLeft + 2, iTop + 1, ABitMap);
      finally
        ABitMap.Free;
      end;
      Inc(iLeft, dLeft);
      Inc(iTop, dTop);
    end;
    if Align = alNone then begin
      case Orientation of
        orHorizontal: Width := iLeft;
        orVertical: Height := iTop;
      end;
    end;
  end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\IntraWeb\IWDsnPaintHandlers.pas initialization enter'); {$EndIf}
  IWRegisterPaintHandler('TIWApplet', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWDBGrid', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWDBImage', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWDynamicChart', TIWPaintHandlerComponent);
  // IWRegisterPaintHandler('TIWHTMLDynamicChart', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWDynamicChartLegend', TIWPaintHandlerComponent);
  // IWRegisterPaintHandler('TIWHTMLDynamicChartLegend', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWFlash', TIWPaintHandlerComponent);
  // IWRegisterPaintHandler('TIWHTMLFlash', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWGrid', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWTimer', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWTreeView', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWRadioGroup', TIWPaintHandlerRadioGroup);
  IWRegisterPaintHandler('TIWRectangle', TIWPaintHandlerRectangle);
  // IWRegisterPaintHandler('TIWHTMLRectangle', TIWPaintHandlerRectangle);
  IWRegisterPaintHandler('TIWMenu', TIWPaintHandlerMenu);
  IWRegisterPaintHandler('TIWLabel', TIWPaintHandlerLabel);
  IWRegisterPaintHandler('TIWDBLabel', TIWPaintHandlerLabel);
  IWRegisterPaintHandler('TIWCSLabel', TIWPaintHandlerLabel);
  IWRegisterPaintHandler('TIWButton', TIWPaintHandlerButton);
  IWRegisterPaintHandler('TIWEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWDBEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWFile', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWDBFile', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWCheckBox', TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TIWDBCheckBox', TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TIWComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TIWDBComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TIWDBLookupComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TIWListBox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWDBListBox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWDBLookupListBox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWMemo', TIWPaintHandlerMemo);
  IWRegisterPaintHandler('TIWDBMemo', TIWPaintHandlerMemo);
  IWRegisterPaintHandler('TIWLink', TIWPaintHandlerLink);
  IWRegisterPaintHandler('TIWURL', TIWPaintHandlerLink);
  IWRegisterPaintHandler('TIWText', TIWPaintHandlerText);
  IWRegisterPaintHandler('TIWDBText', TIWPaintHandlerText);
  IWRegisterPaintHandler('TIWList', TIWPaintHandlerList);
  IWRegisterPaintHandler('TIWHRule', TIWPaintHandlerHRule);
  IWRegisterPaintHandler('TIWImage', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TIWImageFile', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TIWDBImage', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TIWDBNavigator', TIWPaintHandlerDBNavigator);
  IWRegisterPaintHandler('TIWCSNavigator', TIWPaintHandlerCSNavigator);
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\IntraWeb\IWDsnPaintHandlers.pas initialization leave'); {$EndIf}
end.


