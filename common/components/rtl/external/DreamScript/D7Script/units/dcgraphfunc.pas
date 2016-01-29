{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCGraphFunc;

{$I DC.inc}

interface

Uses
  Windows, Controls, Classes, CommCtrl, Graphics, StdCtrls,

  FontMan;

Procedure DCDrawEmptyRect( ACanvas : TCanvas; Const ARect : TRect );
Procedure DCFillExcludeRect( ACanvas : TCanvas; Const AOuterBounds, AInnerBounds : TRect );

Procedure DCFitBitmap( AGlyph : TBitmap; AWidth, AHeight : Integer );
Function  DCAddImageInList( AImageList : TImageList; AGlyph : TBitmap ) : Integer;
Procedure DCImageList_DrawCentered( AImageList : TImageList; AImageIndex : Integer;
                                    ACanvas : TCanvas; Const ARect : TRect; ABk, AFg : TColorRef;
                                    AStyle : Cardinal );

Function  DCDefaultCheckWidth : Integer;
Function  DCDefaultCheckHeight : Integer;

Procedure DCDrawEdge( hDC : HDC; Var ARect : TRect; ARaised : Boolean );
Procedure DCDrawArrow( ACanvas : TCanvas; ALeftArrow : Boolean; Const ARect : TRect;
  AEnabled : Boolean );
Procedure DCDrawCheckBox( ACanvas : TCanvas; Const ACheckRect : TRect; AState : TCheckBoxState;
  AFlat : Boolean; AHideBorder : Boolean; ATransparent : Boolean );
Procedure DCDrawCheckBoxEx( ABitmap : TBitmap; AWidth, AHeight : Integer; AState : TCheckBoxState;
  AFlat : Boolean; AHideBorder : Boolean );
Procedure DCGetMenuItemImageMask( ABitmap : TBitmap; AWidth, AHeight : Integer; AChecked : Boolean;
  AControl : Integer );
Procedure DCDrawMenuItemImage( ACanvas : TCanvas; Const AImageRect : TRect; AChecked : Boolean;
  AControl : Integer );

Procedure DCSmartTextOut( ACanvas: TCanvas; Const ARect : TRect; ALeft, ATop : Integer;
  Const AText : String );
Procedure DCDrawImageWithBackground( ACanvas : TCanvas; AImageList : TImageList;
  AImageIndex, ABkGroundIndex, X, Y : Integer );
Procedure DCBrushCopy( ACanvas : TCanvas; Const ADestRect : TRect; ABitmap : TBitmap;
  Const ASourceRect : TRect; ATransparentColor : TColor );
Procedure DCStretchDraw( ACanvas : TCanvas; Const AImageRect : TRect; ABitmap : TBitmap );

Procedure DCDrawHighlightedText( ACanvas : TCanvas; Const ARect : TRect; X, Y : Integer;
  Const AFormattedText : String );
Function DCGetHighlightedTextWidth( ACanvas : TCanvas; Const AFormattedText : String ) : Integer;
Procedure DCDrawDisabledText( ACanvas : TCanvas; Const ATextRect : TRect; Const AText : String;
  AFlags : Integer );

Procedure DCDecreaseFontSize( AFont : TFont );

Const
{$IFNDEF D4}
  DFCS_TRANSPARENT = $800;
{$ENDIF}

{ Consts for formatting text drawn by DCDrawHighlightedText }
  ht_BoldText = #1;
  ht_ItalicText = #2;
  ht_UnderlinedText = #3;
  ht_StrikeOut = #4;

  sDCThreeDots = '…';

implementation

{------------------------------------------------------------------}

Procedure DCDrawEmptyRect( ACanvas : TCanvas; Const ARect : TRect );
begin
  With ACanvas Do
  begin
    MoveTo( ARect.Left, ARect.Top );
    LineTo( ARect.Right - 1, ARect.Top );
    LineTo( ARect.Right - 1, ARect.Bottom - 1 );
    LineTo( ARect.Left, ARect.Bottom - 1 );
    LineTo( ARect.Left, ARect.Top );
  end;
end;

{------------------------------------------------------------------}

Procedure DCFillExcludeRect( ACanvas : TCanvas; Const AOuterBounds, AInnerBounds : TRect );
begin
  With ACanvas Do
  begin
    FillRect( Rect( AOuterBounds.Left, AOuterBounds.Top, AOuterBounds.Right, AInnerBounds.Top ) );
    FillRect( Rect( AOuterBounds.Left, AInnerBounds.Top, AInnerBounds.Left, AOuterBounds.Bottom ) );
    FillRect( Rect( AInnerBounds.Right, AInnerBounds.Top, AOuterBounds.Right, AOuterBounds.Bottom ) );
    FillRect( Rect( AInnerBounds.Left, AInnerBounds.Bottom, AInnerBounds.Right, AOuterBounds.Bottom ) );
  end;
end;

{------------------------------------------------------------------}

Procedure DCDrawEdge( hDC : HDC; Var ARect : TRect; ARaised : Boolean );
Const
  EdgeType : Array[ Boolean ] Of UINT = ( BDR_SUNKENOUTER, BDR_RAISEDINNER );
begin
  DrawEdge( hDC, ARect, EdgeType[ ARaised ], BF_TOPLEFT Or BF_BOTTOMRIGHT );
end;

{------------------------------------------------------------------}

Procedure DCDrawArrow( ACanvas : TCanvas; ALeftArrow : Boolean; Const ARect : TRect;
  AEnabled : Boolean );
Const
  Kind : Array[ Boolean ] Of Integer = ( DFCS_SCROLLRIGHT, DFCS_SCROLLLEFT );
  KindByEnabled : Array[ Boolean ] Of Integer = ( DFCS_INACTIVE, 0 );
Var
  Bitmap          : TBitmap;
  IWidth, IHeight : Integer;
begin
  IWidth  := ARect.Right - ARect.Left - 2;
  IHeight := ARect.Bottom - ARect.Top - 2;
  Bitmap := TBitmap.Create;
  With Bitmap Do
  try
    Width  := IWidth;
    Height := IHeight;
  { Draw Arrow to bitmap }
    DrawFrameControl( Canvas.Handle, Rect( -1, -1, IWidth + 1, IHeight + 1 ),
                      DFC_SCROLL, Kind[ ALeftArrow ] Or KindByEnabled[ AEnabled ] Or
                      DFCS_ADJUSTRECT Or DFCS_FLAT Or DFCS_TRANSPARENT );
//    Transparent := True;
//    TransparentColor := clBtnFace;
    ACanvas.Draw( ARect.Left + 1, ARect.Top + 1, Bitmap );
  finally
    Bitmap.Free
  end;
end;

{------------------------------------------------------------------}

Procedure DCDrawImageWithBackground( ACanvas : TCanvas; AImageList : TImageList;
  AImageIndex, ABkGroundIndex, X, Y : Integer );
Var
  Bitmap : TBitmap;
begin
  Bitmap := TBitmap.Create;
  With Bitmap Do
  try
    Width := AImageList.Width;
    Height := AImageList.Height;
    ImageList_Draw( AImageList.Handle, ABkGroundIndex, Canvas.Handle, 0, 0, ILD_NORMAL );
    ImageList_DrawEx( AImageList.Handle, AImageIndex, Canvas.Handle, 0, 0, AImageList.Width,
                      AImageList.Height, CLR_NONE, CLR_NONE, ILD_TRANSPARENT );
    ACanvas.Draw( X, Y, Bitmap );
  finally
    Bitmap.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCBrushCopy( ACanvas : TCanvas; Const ADestRect : TRect; ABitmap : TBitmap;
  Const ASourceRect : TRect; ATransparentColor : TColor );
const
  ROP_DSPDxax = $00E20746;
var
  SrcW, SrcH     : Integer;
  crBack, crText : TColorRef;
  MaskDC         : HDC;
  _Mask          : TBitmap;
  MaskHandle     : HBITMAP;
  AGlyph         : TBitmap;
begin
  If ABitmap = Nil Then
    Exit;

  AGlyph := TBitmap.Create;
  try

    With ADestRect Do
    begin
      AGlyph.Canvas.Brush.Color := ACanvas.Brush.Color;
      AGlyph.Width := Right - Left;
      AGlyph.Height:= Bottom - Top;
    end;
    With ASourceRect Do
    begin
      SrcW := Right - Left;
      SrcH := Bottom - Top;
    end;

    If ABitmap.TransparentColor = ATransparentColor Then
    begin
      _Mask := Nil;
      MaskHandle := ABitmap.MaskHandle;
      MaskDC := CreateCompatibleDC( 0 );
      MaskHandle := SelectObject( MaskDC, MaskHandle );
    end
      Else
    begin
      _Mask := TBitmap.Create;
      _Mask.Assign( ABitmap );
      _Mask.Mask( ATransparentColor );
      MaskDC := _Mask.Canvas.Handle;
      MaskHandle := 0;
    end;

    try
      With AGlyph, Canvas Do
      begin
        If Brush.Style = bsClear Then
          TransparentStretchBlt( Handle, 0, 0, Width, Height, ABitmap.Canvas.Handle,
                                 ASourceRect.Left, ASourceRect.Top, SrcW, SrcH, MaskDC,
                                 ASourceRect.Left, ASourceRect.Top )
        Else
        begin
          StretchBlt( Handle, 0, 0, Width, Height, ABitmap.Canvas.Handle, ASourceRect.Left,
                      ASourceRect.Top, SrcW, SrcH, SrcCopy );
          crText := SetTextColor( Handle, 0 );
          crBack := SetBkColor( Handle, $FFFFFF );
          StretchBlt( Handle, 0, 0, Width, Height, MaskDC, ASourceRect.Left, ASourceRect.Top,
                      SrcW, SrcH, ROP_DSPDxax );
          SetTextColor( Handle, crText );
          SetBkColor( Handle, crBack );
        end;
      end;
    finally
      If Assigned( _Mask ) Then
        _Mask.Free
      Else
      begin
        If MaskHandle <> 0 Then
          SelectObject( MaskDC, MaskHandle );
        DeleteDC( MaskDC );
      end;
    end;
    ACanvas.Draw( ADestRect.Left, ADestRect.Top, AGlyph );
  finally
    AGlyph.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCStretchDraw( ACanvas : TCanvas; Const AImageRect : TRect; ABitmap : TBitmap );
Var
  dWidth, dHeight : Integer;
  AGlyph          : TBitmap;
begin
  With AImageRect Do
  begin
    dWidth := Right - Left;
    dHeight := Bottom - Top;
  end;
  If dWidth < 0 Then
    dWidth := 0;
  If dHeight < 0 Then
    dHeight := 0;

  AGlyph := TBitmap.Create;
  try
    With AGlyph Do
    begin
      Canvas.Brush.Color := ACanvas.Brush.Color;
      Width := dWidth;
      Height := dHeight;
      Canvas.StretchDraw( Rect( 0, 0, Width, Height ), ABitmap );
    end;
    ACanvas.Draw( AImageRect.Left, AImageRect.Top, AGlyph );
  finally
    AGlyph.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCDrawHighlightedText( ACanvas : TCanvas; Const ARect : TRect; X, Y : Integer;
  Const AFormattedText : String );
Var
  Bitmap   : TBitmap;
  I, Start : Integer;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _OutTextBlock;
  Var
    PrintingText : String;
  begin
    If I = Start Then
      Exit;
    PrintingText := Copy( AFormattedText, Start, I - Start );
    With Bitmap.Canvas Do
    begin
      TextOut( X, Y, PrintingText );
      X := X + GetWidth( Font.Handle, PChar( PrintingText ), Length( PrintingText ) );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure InitializeCanvas;
  begin
    With Bitmap.Canvas Do
    begin
      Brush.Color := ACanvas.Brush.Color;
      Brush.Style := bsSolid;
      Font.Assign( ACanvas.Font );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ReverseState( AFontState : TFontStyle );
  Var
    FtStyle : TFontStyles;
  begin
    With Bitmap.Canvas.Font Do
    begin
      FtStyle := Style;
      If AFontState In FtStyle Then
        Exclude( FtStyle, AFontState )
      Else
        Include( FtStyle, AFontState );
      Style := FtStyle;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  Start := 1;
  Bitmap := TBitmap.Create;
  try
    X := X - ARect.Left;
    Y := Y - ARect.Top;
    With Bitmap Do
    begin
      Width := ARect.Right - ARect.Left;
      Height := ARect.Bottom - ARect.Top;
      InitializeCanvas;
      Canvas.FillRect( Rect( 0, 0, Width, Height ) );
      With Canvas.Font Do
        For I := 1 To Length( AFormattedText ) Do
          If AFormattedText[ I ] < #32 Then
          begin
            _OutTextBlock;
            Case AFormattedText[ I ] Of
              ht_BoldText       : _ReverseState( fsBold );
              ht_ItalicText     : _ReverseState( fsItalic );
              ht_UnderlinedText : _ReverseState( fsUnderline );
              ht_StrikeOut      : _ReverseState( fsStrikeOut );
            End;
            Start := I + 1;
          end;
    end;
    _OutTextBlock;
    ACanvas.Draw( ARect.Left, ARect.Top, Bitmap );
  finally
    Bitmap.Free;
  end;
end;

{------------------------------------------------------------------}

Function DCGetHighlightedTextWidth( ACanvas : TCanvas; Const AFormattedText : String ) : Integer;
Var
  I, Start : Integer;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function _GetTextPartWidth( AFinish : Boolean ) : Integer;
  Var
    PrintingText : String;
  begin
    Result := 0;
    If I = Start Then
      Exit;
    PrintingText := Copy( AFormattedText, Start, I - Start );
    If AFinish Then
      Result := ACanvas.TextWidth( PrintingText )
    Else
      Result := GetWidth( ACanvas.Font.Handle, PChar( PrintingText ), Length( PrintingText ) );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ReverseState( AFontState : TFontStyle );
  Var
    FtStyle : TFontStyles;
  begin
    With ACanvas.Font Do
    begin
      FtStyle := Style;
      If AFontState In Style Then
        Exclude( FtStyle, AFontState )
      Else
        Include( FtStyle, AFontState );
      Style := FtStyle;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  Start := 1;
  Result := 0;
  With ACanvas.Font Do
    For I := 1 To Length( AFormattedText ) Do
      If AFormattedText[ I ] < #32 Then
      begin
        Result := Result + _GetTextPartWidth( False );
        Case AFormattedText[ I ] Of
          ht_BoldText       : _ReverseState( fsBold );
          ht_ItalicText     : _ReverseState( fsItalic );
          ht_UnderlinedText : _ReverseState( fsUnderline );
          ht_StrikeOut      : _ReverseState( fsStrikeOut );
        End;
        Start := I + 1;
      end;
  I := Length( AFormattedText ) + 1;
  Result := Result + _GetTextPartWidth( True );
end;

{------------------------------------------------------------------}

Procedure DCFitBitmap( AGlyph : TBitmap; AWidth, AHeight : Integer );
Var
  OldWidth, OldHeight        : Integer;
  SaveBrushColor, TransColor : TColor;
begin
  If ( AGlyph.Width = AWidth ) And ( AGlyph.Height = AHeight ) Then
    Exit;
  TransColor := AGlyph.TransparentColor;
  OldWidth := AGlyph.Width;
  OldHeight := AGlyph.Height;
  AGlyph.Width := AWidth;
  AGlyph.Height := AHeight;
  AWidth := ( AGlyph.Width - OldWidth ) Div 2;
  AHeight := ( AGlyph.Height - OldHeight ) Div 2;
  If AWidth < 0 Then
    AWidth := 0;
  If AHeight < 0 Then
    AHeight := 0;
  If ( AWidth <> 0 ) Or ( AHeight <> 0 ) Then
    AGlyph.Canvas.Draw( AWidth, AHeight, AGlyph );
  SaveBrushColor := AGlyph.Canvas.Brush.Color;
  AGlyph.Canvas.Brush.Color := TransColor;
  DCFillExcludeRect( AGlyph.Canvas, Rect( 0, 0, AGlyph.Width, AGlyph.Height ),
                     Rect( AWidth, AHeight, AWidth + OldWidth, AHeight + OldHeight ) );
  AGlyph.Canvas.Brush.Color := SaveBrushColor;
end;

{------------------------------------------------------------------}

Function DCAddImageInList( AImageList : TImageList; AGlyph : TBitmap ) : Integer;
begin
  DCFitBitmap( AGlyph, AImageList.Width, AImageList.Height );
  Result := AImageList.AddMasked( AGlyph, AGlyph.TransparentColor );
end;

{------------------------------------------------------------------}

Procedure DCImageList_DrawCentered( AImageList : TImageList; AImageIndex : Integer;
                                    ACanvas : TCanvas; Const ARect : TRect; ABk, AFg : TColorRef;
                                    AStyle: Cardinal );
Var
  Glyph : TBitmap;
begin
  Glyph := TBitmap.Create;
  try
    Glyph.Width := AImageList.Width;
    Glyph.Height := AImageList.Height;
    ImageList_DrawEx( AImageList.Handle, AImageIndex, Glyph.Canvas.Handle, 0, 0, Glyph.Width,
                      Glyph.Height, ABk, AFg, AStyle );
    With ARect Do
      DCFitBitmap( Glyph, Right - Left, Bottom - Top );
    ACanvas.Draw( ARect.Left, ARect.Top, Glyph );
  finally
    Glyph.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCDrawCheckBoxEx( ABitmap : TBitmap; AWidth, AHeight : Integer; AState : TCheckBoxState;
  AFlat : Boolean; AHideBorder : Boolean );
Var
  DrawingRect : TRect;
  DrawState   : Integer;
begin
  If AWidth > AHeight Then
    AWidth := AHeight
  Else
    AHeight := AWidth;
  DrawingRect := Rect( 0, 0, AWidth, AHeight );

  Case AState Of
    cbChecked   : DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
    cbUnchecked : DrawState := DFCS_BUTTONCHECK;
    Else          DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
  end;

  ABitmap.Width := DrawingRect.Right;
  ABitmap.Height := DrawingRect.Bottom;
  With ABitmap.Canvas Do
  begin
    If AHideBorder Then
      InflateRect( DrawingRect, 2, 2 )
    Else
      If AFlat Then
        InflateRect( DrawingRect, 1, 1 );

    DrawFrameControl( Handle, DrawingRect, DFC_BUTTON, DrawState );
    If Not AHideBorder And AFlat Then
    begin
      Brush.Style := bsClear;
      Pen.Color := clBtnShadow;
      With DrawingRect Do
        Rectangle( Left + 1, Top + 1, Right - 1, Bottom - 1 );
    end;
  end;
end;

{------------------------------------------------------------------}

Var
  FCheckWidth  : Integer = 0;
  FCheckHeight : Integer = 0;

Procedure DCGetCheckSize;
begin
  If fCheckWidth = 0 Then
{$IFNDEF CLX}
    With TBitmap.Create Do
    try
      Handle := LoadBitmap( 0, PChar(OBM_CHECKBOXES) );
      FCheckWidth := Width Div 4;
      FCheckHeight := Height Div 3;
    finally
      Free;
    end;
{$ELSE}
  FCheckWidth :=  13;
  FCheckHeight := 13;
{$ENDIF}
end;

{------------------------------------------------------------------}

Function  DCDefaultCheckWidth : Integer;
begin
  DCGetCheckSize;
  result := fCheckWidth;
end;

{------------------------------------------------------------------}

Function  DCDefaultCheckHeight : Integer;
begin
  DCGetCheckSize;
  result := fCheckWidth;
end;

{------------------------------------------------------------------}

Procedure DCDrawCheckBox( ACanvas : TCanvas; Const ACheckRect : TRect; AState : TCheckBoxState;
  AFlat : Boolean; AHideBorder : Boolean; ATransparent : Boolean );
Var
  Bitmap : TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    With Bitmap.Canvas Do
      Brush.Color := ACanvas.Brush.Color;
    With ACheckRect Do
      DCDrawCheckBoxEx( Bitmap, Right - Left, Bottom - Top, AState, AFlat, AHideBorder );
    If ATransparent Then
      ACanvas.BrushCopy( ACheckRect, Bitmap, Rect( 0, 0, Bitmap.Width, Bitmap.Height ), clWindow )
    Else
      ACanvas.Draw( ACheckRect.Left, ACheckRect.Top, Bitmap );
  finally
    Bitmap.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCGetMenuItemImageMask( ABitmap : TBitmap; AWidth, AHeight : Integer;
  AChecked : Boolean; AControl : Integer );
begin
  If AWidth > AHeight Then
    AWidth := AHeight
  Else
    AHeight := AWidth;

  If AChecked Then
    AControl := AControl Or DFCS_CHECKED;

  ABitmap.Width := AWidth;
  ABitmap.Height := AHeight;

  DrawFrameControl( ABitmap.Canvas.Handle, Rect( 0, 0, ABitmap.Width, ABitmap.Height ),
                    DFC_MENU, AControl );
end;

{------------------------------------------------------------------}

Procedure DCDrawMenuItemImage( ACanvas : TCanvas; Const AImageRect : TRect; AChecked : Boolean;
  AControl : Integer );
Var
  mLeft, mTop, mWidth, mHeight : Integer;
  Bitmap, Mask, ForeGround     : TBitmap;
begin
  Bitmap := TBitmap.Create;
  ForeGround := TBitmap.Create;
  Mask := TBitmap.Create;
  try
    Bitmap.Canvas.Brush.Color := ACanvas.Brush.Color;
    ForeGround.Canvas.Brush.Color := ACanvas.Font.Color;

    With AImageRect Do
    begin
      Bitmap.Width := Right - Left;
      Bitmap.Height := Bottom - Top;
    end;
    DCGetMenuItemImageMask( Mask, Bitmap.Width, Bitmap.Height - 2, True, AControl );

    mLeft := ( Bitmap.Width - Mask.Width ) Div 2;
    mTop := ( Bitmap.Height - Mask.Height ) Div 2;
    mWidth := Mask.Width;
    mHeight := Mask.Height;

    ForeGround.Width := mWidth;
    ForeGround.Height := mHeight;

    BitBlt( Bitmap.Canvas.Handle, mLeft, mTop, mWidth, mHeight, Mask.Canvas.Handle, 0, 0, SRCAND );
    BitBlt( Mask.Canvas.Handle, 0, 0, mWidth, mHeight, 0, 0, 0, DSTINVERT );
    BitBlt( ForeGround.Canvas.Handle, 0, 0, mWidth, mHeight, Mask.Canvas.Handle, 0, 0, SRCAND );
    BitBlt( Bitmap.Canvas.Handle, mLeft, mTop, mWidth, mHeight, ForeGround.Canvas.Handle,
            0, 0, SRCPAINT );

    With AImageRect Do
      ACanvas.Draw( Left, Top, Bitmap );
  finally
    Mask.Free;
    ForeGround.Free;
    Bitmap.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCSmartTextOut( ACanvas: TCanvas; Const ARect : TRect; ALeft, ATop : Integer;
  Const AText : String );
Var
  I, AMaxWidth : Integer;
  ResultText   : String;
begin
  AMaxWidth := ARect.Right - ALeft;
  If ACanvas.TextWidth( AText ) <= AMaxWidth Then
  begin
    ACanvas.TextRect( ARect, ALeft, ATop, AText );
    Exit;
  end;
  AMaxWidth := AMaxWidth - ACanvas.TextWidth( sDCThreeDots );
  ResultText := Copy( AText, 1, 2 );
  For I := 3 To Length( AText ) - 1 Do
  begin
    If ACanvas.TextWidth( ResultText ) > AMaxWidth Then
      break;
    ResultText := ResultText + AText[ I ];
  end;
  SetLength( ResultText, Length( ResultText ) - 1 );
  ACanvas.TextRect( ARect, ALeft, ATop, ResultText + sDCThreeDots );
end;

{------------------------------------------------------------------}

Procedure DCDrawDisabledText( ACanvas : TCanvas; Const ATextRect : TRect; Const AText : String;
  AFlags : Integer );
Var
  DrawingRect : TRect; 
  Bitmap      : TBitmap;
begin
  DrawingRect := ATextRect;
  Bitmap := TBitmap.Create;
  try
    OffsetRect( DrawingRect, -DrawingRect.Left, -DrawingRect.Top );
    With Bitmap.Canvas Do
    begin
      Brush.Color := ACanvas.Brush.Color;
      Font := ACanvas.Font;
      Bitmap.Width := DrawingRect.Right;
      Bitmap.Height := DrawingRect.Bottom;
      Brush.Style := bsClear;
      OffsetRect( DrawingRect, 1, 1 );
      Font.Color := clBtnHighlight;
      DrawText( Handle, PChar( AText ), Length( AText ), DrawingRect, AFlags );
      Font.Color := clBtnShadow;
      OffsetRect( DrawingRect, -1, -1 );
      DrawText( Handle, pChar( AText ), Length( AText ), DrawingRect, AFlags );
    end;
    ACanvas.Draw( ATextRect.Left, ATextRect.Top, Bitmap );
  finally
    Bitmap.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCDecreaseFontSize( AFont : TFont );
{Var
  TextMetrica : tagTEXTMETRICA;}
begin
  If AFont.Size = 1 Then
    Exit;
  AFont.Size := AFont.Size - 1;

{  GetTextMetrics( AFont.Handle, TextMetrica );
  If ( TextMetrica.tmPitchAndFamily And TMPF_VECTOR <> 0 ) Or
     ( TextMetrica.tmPitchAndFamily And TMPF_TRUETYPE <> 0 ) Then
  begin
    AFont.Size := AFont.Size - 1;
    Exit;
  end;

// Font must be descrease by predefined steps. Get them from font info.
  AFont.Size := AFont.Size - 1;}
end;

{------------------------------------------------------------------}

end.
