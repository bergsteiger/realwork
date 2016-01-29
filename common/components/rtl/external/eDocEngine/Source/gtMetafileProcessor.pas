{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

// Switch OFF RangeChecking and OverFlow checking
{$R-Q-}
unit gtMetafileProcessor;

interface

uses
  Windows, Classes, Graphics, gtCstDocEng, gtUtils3, gtDocUtils, gtConsts3,
  gtDocConsts, Dialogs;

type

  { ------------------------------------------------------------------------------ }

  (* Set of alignments used in EMR_SETTEXTALIGN *)
  TgtEMFAlignments = (TA_NOUPDATECP, TA_UPDATECP, TA_LEFT, TA_RIGHT, TA_CENTER,
    TA_TOP, TA_BOTTOM, TA_BASELINE, TA_RTLREADING, TA_MASK);

  TgtEMFAlignment = set of TgtEMFAlignments;

  TgtAlignments = (taLeftJustify, taRightJustify, taCenter, taJustify,
    taBaseLine, taBottom, taTop);

  TgtGDIOBJType = (goPen, goBrush, goFont, goPalette, goNone);

  TgtAlignment = set of TgtAlignments;

  PTList = ^TList;

  { ------------------------------------------------------------------------------ }

  // Holds font metrics.
  TgtFontInfo = class(TObject)
  private
    FfiFlags: Integer;
    FfiAscent: Double;
    FfiDescent: Double;
    FfiCapHeight: Double;
    FfiStrikeoutSize: Double;
    FfiStrikeoutPosition: Double;
    FfiUnderscoreSize: Double;
    FfiUnderscorePosition: Double;
  end;

  { ------------------------------------------------------------------------------ }

  TgtFont = class(TFont)
  public
    FRotateFont: Integer;

    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  end;

  { ------------------------------------------------------------------------------ }

  TgtPalette = class(TObject)
  private
    FLogPalette: TLogPalette;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { ------------------------------------------------------------------------------ }

  TgtGDIOBJ = class(TObject)
  public
    FGDIOBJType: TgtGDIOBJType;
    FPen: TPen;
    FBrush: TBrush;
    FFont: TgtFont;
    FPalette: TgtPalette;
    FPenJoinStyle: TgtPenJoinStyle;
    FPenCapStyle: TgtPenCapStyle;
    constructor Create(AGDIOBJType: TgtGDIOBJType);
    destructor Destroy; override;
  end;

  { ------------------------------------------------------------------------------ }

  (* Dummy class to access protected methods of TgtCustomDocumentEngine. *)
  TgtHackDocumentEngine = class(TgtCustomDocumentEngine)
  end;

  { ------------------------------------------------------------------------------ }
  (* Class to store/restore the Metafile State (DC). *)
  TgtMetaState = class(TObject)
  private
    FFont: TgtFont;
    FBrush: TBrush;
    FPen: TPen;
    FCurrentTextColor: TColor;
    FBKMode: Integer;
    FMapMode: Cardinal;
    FXForm: TXForm;
    FWinExtent: TSize;
    FViewExtent: TSize;
    FWinOrg: TPoint;
    FViewOrg: TPoint;
    FTextAlign: TgtEMFAlignment;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { ------------------------------------------------------------------------------ }

  TgtMetafileProcessor = class(TObject)
  private
    FEngine: TgtHackDocumentEngine;
    FStartX: Double;
    FStartY: Double;

    (*
      Set in EMR_SETROP2.
      The SetROP2 function sets the current foreground mix mode.
    *)
    FROP2: Cardinal;
    (*
      Set in EMR_SETSTRETCHBLTMODE.
      The SetStretchBltMode function sets the bitmap stretching mode in the
      specified device context.
    *)
    FStretchMode: Cardinal;
    (*
      Set in EMR_SETICMMODE.
      The SetICMMode function causes Image Color Management to be enabled,
      disabled, or queried on a given device context (DC).
    *)
    FICMMode: Cardinal;
    (*
      Set in EMR_SETPOLYFILLMODE.
      The SetPolyFillMode function sets the polygon fill mode for functions
      that fill polygons.
    *)
    FPolyFillMode: Cardinal;
    (*
      Shapes:
      FBKMODE = TRANSPARENT
      => Consider only the current selected brush.
      FBKMODE = OPAQUE
      Brush.Style = bsClear/bsSolid
      => Consider only the current selected brush.
      Brush.Style = bsHorizontal.....
      => Shade the shape using FBKColor.
      => Shade the shape using Brush.
    *)
    FBKColor: TColor;
    (* Current MapMode (if is set in metafile) *)
    FMapMode: Cardinal;
    (* Current set MiterLimit; Default = 10.0 *)
    FMiterLimit: Single;
    (* Holds any comment set in metafile through EMRGDICOMMENT *)
    // FGdiComment: String;

    (* Holds The Current GDI Objects Selected *)
    FCurrentFont: TgtFont;
    FCurrentBrush: TBrush;
    FCurrentPen: TPen;
    FCurrentPalette: TgtPalette;

    (* Holds current text alignment set by EMR_SETTEXTALIGN *)
    FTextAlignment: TgtEMFAlignment;
    (* Holds current text color set by EMR_SETTEXTCOLOR *)
    FTextColor: TColor;
    (* Holds current point set by EMR_MOVETOEX *)
    FCurrentPathPoint: TPoint;
    FUpdatePathX: Double;
    (*
      Holds current Background Mode set by EMR_SETBKMODE
      Shapes:
      FBKMODE = TRANSPARENT
      => Consider only the current selected brush.
      FBKMODE = OPAQUE
      Brush.Style = bsClear/bsSolid
      => Consider only the current selected brush.
      Brush.Style = bsHorizontal.....
      => Shade the shape using FBKColor.
      => Shade the shape using Brush.
    *)
    FBKMode: Byte;
    (*
      Used for determining underline/strikeout. Set in
      EMR_STRETCHBLT/EMR_BITBLT.. if a text was processed recently AND if the
      bitmap does not have any bits.
    *)
    FStretchBltRect: TgtRect;
    (*
      Set in EMR_EXTTEXTOUTA. Required for determining whether text is
      underlined/strikedout
    *)
    FJustProcessedTextItem: Integer;
    (*
      Used with JustProcessedTextItem. This flag indicates that text rendered
      recently is underlined/strikedout through EMR_STRETCHBLT/EMR_BITBLT
    *)
    FFontStyleChanged: Boolean;
    (*
      Set in EMR_INTERSECTCLIPRECT. Used with EMR_STRETCHBLT/EMR_BITBLT.. for
      determining whether image is cliped/centered.
    *)
    FClipRect: TgtRect;
    (*
      Set in EMR_ENDPATH. Used in
      EMR_FILLPATH/EMR_STROKEPATH/EMR_STROKEANDFILLPATH to determine whether
      current path should be filled.
    *)
    FJustCompletedPath: Byte;
    (* Set in EMR_BEGINPATH. *)
    FInPath: Boolean;

    FJustProcessedStretchBltShape: Boolean;

    (* Special case for Symbol Fonts with EMR_EXTTEXTOUTW *)
    FSymbolCharsetFontIdx: Integer;

    FCurrentRecord: Integer; // Required for debuging.

    FGDIOBJList: TList;
    FGDIOBJ: TgtGDIOBJ;

    FProcessText: Boolean;
    FProcessImage: Boolean;
    FProcessShape: Boolean;
    FIsClipRect: Boolean;
    FIsIntersectClipRect: Boolean;
    FPTextList: PTList;
    FIsWindowsExt: Boolean;
    FIsTransApplied: Boolean;
    FEOFItem: TgtEOFItem;
    FTextItem: TgtTextItem;
    FImageItem: TgtImageItem;
    FPolyShapeItem: TgtPolyShapeItem;
    FShapeItem: TgtShapeItem;
    FClipItem: TgtClipItem;
    FPolyPolygonItem: TgtPolyPolygonItem;
    FPathItem: TgtPathItem;
    FPolyDrawItem: TgtPolyDrawItem;
    // FTransformationItem: TgtTransformationItem;
    (* Metafile dimensions. *)
    FWidth: Integer;
    FHeight: Integer;
    (*
      Transformation Matrix.
      Used for Scaling, Translating, Rotating & Reflecting.
    *)
    FXForm: TXForm;
    FMetaState: TStringList; (* Holds the Metafile State (DC) *)
    (*
      Used by records -
      EMRSETVIEWPORTORGEX
      EMRSETVIEWPORTEXTEX
      EMRSETWINDOWORGEX &
      EMRSETWINDOWEXTEX
      respectively in MM_ANISOTROPIC & MM_ISOTROPIC map mode.
    *)
    FViewPortOrigin: TPoint;
    FViewPortExtent: TSize;
    FWindowOrigin: TPoint;
    FWindowExtent: TSize;

    FMapMXmul: Double;
    FMapMYmul: Double;

    // Color with High-Order bit <> 0 is always Black!
    function GetColorValue(AColor: Cardinal): Cardinal;

    (*
      Method to calculate correct X & Y values based on Map Mode that is
      currently set.
    *)
    function ApplyMMToPenWidth(AX: Double): Double;

    function ApplyMMWithOrigin(AX, AY: Double): TgtPoint;

    function ApplyMM(AX, AY: Double): TgtPoint;

    function ApplyMMToRect(ARect: TgtRect): TgtRect;
    (*
      Method to initialize X & Y multiplier when Map Mode is set to
      MM_ANISOTROPIC.
    *)
    procedure SetMapModeMultiplier;
    (*
      Method to calculate the Top-Left position of a text based on the text
      alignment that is set.
    *)
    function GetTopLeftPosition(ReferenceX, ReferenceY: Double; Text: String;
      ATextWidth: Double; Font: TFont; Rotation: Integer): TgtPoint;
    (*
      Method to calculate word transformed co-ordinates.
    *)
    function WorldTransform(AX, AY: Double): TgtPoint;

    (* Methods to save and restore metastate (DC). *)
    procedure SaveMetaState;
    procedure RestoreMetaState(N: Integer);

    (*
      Method to select a stock object.
    *)
    procedure SelectStockObject(AihObject: Cardinal);
    (*
      Checks whether the current image item position is same as an already
      existing recent image item in the list.
      Returns:
      True - If current image item position is not same as already existing
      recent image item.
      False - If current image item position is same as already existing
      recent image item.
      If Result = False then ImageIndex contains the index to image in
      FImageResourceList.
    *)
    procedure IsFirstRasterOpImage(ARect: TgtRect; out ImageIndex: Integer);
    (*
      Appends a scanline to bitmap.
      This method is used with EMR_SETDIBITSTODEVICE which outputs a bitmap one
      scanline at a time.
    *)
    procedure AddScanLineToBitmap(ABitmapFileHeader: BITMAPFILEHEADER;
      ABitmapInfoHeader: BITMAPINFOHEADER; APBmiSrc, APBitSrc: Pointer;
      ABmiBufCount, ABitBufCount: Cardinal);
    (*
      If Text alignment is set to TA_UPDATECP, the EMR_EXTTEXTOUTA does not
      include reference point. Hence append the next text item to the previous
      text item.
    *)
    {
      procedure AppendString(var ATextItem: TgtTextItem; AAppendText: AnsiString;
      AAppendInterCharSpacing: array of Integer);
    }
    (*
      Performs the specified operation on given bitmap information
    *)
    procedure BitmapRasterOp(ARop: DWORD; AImageIndex: Integer;
      ABitmapFileHeader: BITMAPFILEHEADER; ABitmapInfoHeader: BITMAPINFOHEADER;
      APBmiSrc, APBitSrc: Pointer; ABmiBufCount, ABitBufCount: Cardinal);
    function CheckAndSetUnderlineStrikeOut: Boolean;
    (*
      Creates a Bitmap image using the information passed
      BITMAPFILEHEADER
      BITMAPINFOHEADER
      BmiSrc &
      BitSrc
      This method is used with EMR_STRETCHBLT, EMR_BITBLT....
    *)
    procedure CreateBitmap(var ABitmapStream: TMemoryStream;
      ABitmapFileHeader: BITMAPFILEHEADER; ABitmapInfoHeader: BITMAPINFOHEADER;
      APBmiSrc, APBitSrc: Pointer; ABmiBufCount, ABitBufCount: Cardinal);
    procedure CreateShapeItem(var AShapeItem: TgtShapeItem;
      AShapeType: TgtShapeType = stLine);
    procedure CreatePolyShapeItem(var APolyShapeItem: TgtPolyShapeItem);
    procedure CreatePolyPolygonItem(var APolyPolygonItem: TgtPolyPolygonItem);
    procedure CreateImageItem(var AImageItem: TgtImageItem);
    procedure CreateTextItem(var ATextItem: TgtTextItem);
    procedure CreateClipItem(var AClipItem: TgtClipItem);
    procedure CreatePathItem(var APathItem: TgtPathItem);
    // procedure CreateTransformationItem(var ATransformationItem
    // : TgtTransformationItem);
    procedure CreateEOFItem(var AEOFItem: TgtEOFItem);
    procedure CreatePolyDrawItem(var APolyDrawItem: TgtPolyDrawItem);
    procedure CreateGDIRec(var AGDIOBJ: TgtGDIOBJ; AGDIOBJType: TgtGDIOBJType);

    procedure FillFontMetrics(AFont: TFont; AFontInfo: TgtFontInfo);

    function GetSizeFromHeight(AHeight: Extended): Extended;
    {
      procedure GetInterCharSpacing(const AEnhMetaRecord: Pointer;
      var AInterCharSpacing: array of Integer);
    }
    function IsTextUnderlinedStrikedout(AFont: TFont; AMapMode: Cardinal;
      AStretchBlt: TgtRect; ATextReferenceY: Extended): TFontStyles;
    procedure SetAlignment(AgtEMFAlignment: TgtEMFAlignment;
      var AHorizontalAlignment: TgtHAlignment;
      var AVerticalAlignment: TgtVAlignment); overload;
    procedure SetAlignment(AMode: Integer;
      var AgtAlignment: TgtEMFAlignment); overload;
    function DoCharMapping(AChar: Word): Word;
  public
    FCombineCharsToSentence: Boolean;
    // FApplyTransformation:Boolean;
    constructor Create(ADocumentEngine: TgtCustomDocumentEngine);
    destructor Destroy; override;
    (*
      After Create call Execute to process the metafile AMetafile.
      AStartX, AStartY indicate the actual original.
    *)
    procedure Execute(AMetafile: TMetafile; AStartX, AStartY: Double); overload;
    procedure Execute(AMetafileHandle: HENHMETAFILE;
      AStartX, AStartY: Double); overload;

  end;

  PTgtMetafileProcessor = ^TgtMetafileProcessor;
  (* Enumerate Metafile CallBack Function *)
function EnhMetaFileProc(AHDC: HDC; AHandleTable: PHandleTable;
  const AEnhMetaRecord: Pointer; AObjectCount: Integer;
  AOptionalData: Pointer): Integer;
stdcall

{ ------------------------------------------------------------------------------ }

  implementation uses SysUtils, Math;

{ ------------------------------------------------------------------------------ }
{ TgtFont }
{ ------------------------------------------------------------------------------ }

procedure TgtFont.Assign(Source: TPersistent);
begin
  inherited;
  if (Source <> nil) and (Source is TgtFont) then
  begin
    FRotateFont := TgtFont(Source).FRotateFont;
  end;

end;

{ ------------------------------------------------------------------------------ }

constructor TgtFont.Create;
begin
  inherited;
  FRotateFont := 0;
end;

{ ------------------------------------------------------------------------------ }

destructor TgtFont.Destroy;
begin

  inherited;
end;

{ ------------------------------------------------------------------------------ }
{ TgtMetafileProcessor }
{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.AddScanLineToBitmap(ABitmapFileHeader
  : BITMAPFILEHEADER; ABitmapInfoHeader: BITMAPINFOHEADER;
  APBmiSrc, APBitSrc: Pointer; ABmiBufCount, ABitBufCount: Cardinal);

var
  LBitmap, LSetDIBitsToDeviceBitmap: TBitmap;
  LNewWidth, LNewHeight, LRow, LCol, LNewRow: Integer;
  LSetDIBitsToDeviceStream: TMemoryStream;
  LImageResourceIndex: Integer;
begin
  LRow := -1;
  LNewWidth := ABitmapInfoHeader.biWidth;
  if TObject(FEngine.CurrentDocumentItemList.Items
    [FEngine.CurrentDocumentItemList.Count - 1]) is TgtImageItem then
    LImageResourceIndex := TgtImageItem(FEngine.CurrentDocumentItemList.Items
      [FEngine.CurrentDocumentItemList.Count - 1]).IndexNo
  else
    Exit;
  (*
    If ScanLine = 0 then
    Since this is the first scanline, image will have to be created and height
    set to ABitmapInfoHeader.biHeight
    Else
    Set image would have been created with earlier scanlines. Hence set
    height to (Previous image height + ABitmapInfoHeader.biHeight)
  *)
  if TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex]) = nil then
    LNewHeight := ABitmapInfoHeader.biHeight
  else
    LNewHeight := TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex])
      .Height + ABitmapInfoHeader.biHeight;

  LSetDIBitsToDeviceStream := TMemoryStream.Create;
  LSetDIBitsToDeviceBitmap := TBitmap.Create;
  LBitmap := TBitmap.Create;
  try
    CreateBitmap(LSetDIBitsToDeviceStream, ABitmapFileHeader, ABitmapInfoHeader,
      APBmiSrc, APBitSrc, ABmiBufCount, ABitBufCount);

    LSetDIBitsToDeviceStream.Position := 0;
    LSetDIBitsToDeviceBitmap.LoadFromStream(LSetDIBitsToDeviceStream);

    if (TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex]) <> nil)
      and (TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex]).Width
      <> 0) and (TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex])
      .Height <> 0) then
    begin
      (* Collect back the old scan lines. *)
      LBitmap.Assign(TBitmap(FEngine.FImageResourceList.Items
        [LImageResourceIndex]));
      LRow := TBitmap(FEngine.FImageResourceList.Items
        [LImageResourceIndex]).Height;
    end;

    LBitmap.Width := LNewWidth;
    LBitmap.Height := LNewHeight;

    if LRow = -1 then
      Inc(LRow);

    for LNewRow := 0 to LSetDIBitsToDeviceBitmap.Height - 1 do
    begin
      for LCol := 0 to LSetDIBitsToDeviceBitmap.Width - 1 do
        LBitmap.Canvas.Pixels[LCol, LRow] :=
          LSetDIBitsToDeviceBitmap.Canvas.Pixels[LCol, LNewRow];
      Inc(LRow);
    end;

    if (TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex])
      = nil) then
      { begin }
      FEngine.FImageResourceList.Items[LImageResourceIndex] := TBitmap.Create;

    TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex]).Width :=
      LNewWidth;
    TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex]).Height :=
      LNewHeight;
    TBitmap(FEngine.FImageResourceList.Items[LImageResourceIndex])
      .Assign(LBitmap);
    { end; }
  finally
    LSetDIBitsToDeviceStream.Free;
    LSetDIBitsToDeviceBitmap.Free;
    LBitmap.Free;
  end;
end;

{ ------------------------------------------------------------------------------

  procedure TgtMetafileProcessor.AppendString(var ATextItem: TgtTextItem;
  AAppendText: AnsiString; AAppendInterCharSpacing: array of Integer);
  begin
  with ATextItem do
  begin
  Lines.Text := RemoveTerminalCRLF(Lines.Text) + AAppendText;
  end;
  end;

  ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.BitmapRasterOp(ARop: DWORD; AImageIndex: Integer;
  ABitmapFileHeader: BITMAPFILEHEADER; ABitmapInfoHeader: BITMAPINFOHEADER;
  APBmiSrc, APBitSrc: Pointer; ABmiBufCount, ABitBufCount: Cardinal);

var
  LBitmapStream: TMemoryStream;
  LBitmap, LOpBitmap: TBitmap;
  ResultIndex: Integer;
  LImageHashValue: TgtHashValue;
  LStream: TMemoryStream;
begin
  LBitmapStream := nil;
  LBitmap := TBitmap.Create;
  LStream := TMemoryStream.Create;
  try
    CreateBitmap(LBitmapStream, ABitmapFileHeader, ABitmapInfoHeader, APBmiSrc,
      APBitSrc, ABmiBufCount, ABitBufCount);
    LBitmapStream.Position := 0;
    LBitmap.LoadFromStream(LBitmapStream);
  finally
    FreeAndNil(LBitmapStream);
  end;
  try
    LOpBitmap := TBitmap.Create;
    try
      if FEngine.FImageResourceList.Items[AImageIndex] = nil then
      begin
        // LStream := TMemoryStream.Create;
        LImageHashValue := TgtHashValue.Create;
        LOpBitmap.PixelFormat := pf24bit;
        LOpBitmap.Width := LBitmap.Width;
        LOpBitmap.Height := LBitmap.Height;
        LOpBitmap.Canvas.CopyMode := ARop;
        LOpBitmap.Canvas.Draw(0, 0, LBitmap);
        { Getting the already existed image index }
        LOpBitmap.SaveToStream(LStream);
        ResultIndex := FEngine.FindImageResourceIndex(LStream, LImageHashValue);
        if (ResultIndex <> -1) then
        begin
          FImageItem.IndexNo := ResultIndex;
          FEngine.FImageResourceList.Delete
            (FEngine.FImageResourceList.Count - 1);
          FreeAndNil(LImageHashValue);
        end
        else
        begin
          FEngine.FImageResourceList.Items[AImageIndex] := TBitmap.Create;
          TPicture(FEngine.FImageResourceList.Items[AImageIndex])
            .Assign(LOpBitmap);
        end;
        FEngine.CurrentDocumentItemList.add(FImageItem);
      end
      else
      begin
        LOpBitmap.Assign(TBitmap(FEngine.FImageResourceList.Items
          [AImageIndex]));
        LOpBitmap.Canvas.CopyMode := ARop;
        LOpBitmap.Canvas.Draw(0, 0, LBitmap);
        TPicture(FEngine.FImageResourceList.Items[AImageIndex])
          .Assign(LOpBitmap);
        FreeAndNil(FImageItem);
        FEngine.FImageResourceList.Delete(FEngine.FImageResourceList.Count - 1);
      end;
    finally
      if Assigned(LStream) then
        LStream.Free;
      FreeAndNil(LOpBitmap);
    end;
  finally
    FreeAndNil(LBitmap);
  end;
end;

{ ------------------------------------------------------------------------------ }

function TgtMetafileProcessor.CheckAndSetUnderlineStrikeOut: Boolean;

var
  LI, LJ: Integer;
  LUseSeparateTextItemList: Boolean;
begin
  Result := False;
  (*
    If separate text list
    assign CurrentTextItemList
    Else
    Assign CurrentDocumentItemList
  *)
  if (FEngine.FSortTextItems) then
    LUseSeparateTextItemList := True
  else
    LUseSeparateTextItemList := False;

  for LI := FPTextList.Count - 1 downto 0 do
    if (((not LUseSeparateTextItemList) and
      (TgtDocumentItem(FPTextList.Items[LI]) is TgtTextItem)) or
      LUseSeparateTextItemList) then
      with TgtTextItem(FPTextList.Items[LI]) do
      begin
        if ((X = FStretchBltRect.Left) or ((X - 1) = FStretchBltRect.Left)) then
        begin
          if (fsUnderline in IsTextUnderlinedStrikedout(Font, FMapMode,
            FStretchBltRect, Y)) then
          begin
            Font.Style := Font.Style + [fsUnderline];
            FFontStyleChanged := True;
          end
          else if (fsStrikeOut in IsTextUnderlinedStrikedout(Font, FMapMode,
            FStretchBltRect, Y)) then
          begin
            Font.Style := Font.Style + [fsStrikeOut];
            FFontStyleChanged := True;
          end;
          if FFontStyleChanged then
          begin
            Result := True;
            if (LI < (FPTextList.Count - 1)) then
              for LJ := (LI + 1) to (FPTextList.Count - 1) do
                (* If item is a TgtTextItem and is in the sampe Y position. *)
                if ((TgtDocumentItem(FPTextList.Items[LJ]) is TgtTextItem) and
                  (TgtTextItem(FPTextList.Items[LJ])
                  .Y = TgtTextItem(FPTextList.Items[LI]).Y)) then
                  TgtTextItem(FPTextList.Items[LJ]).Font.Style :=
                    TgtTextItem(FPTextList.Items[LI]).Font.Style;
            Break;
          end;
        end; (* End if *)
      end; (* End with *)
end;

{ ------------------------------------------------------------------------------ }

constructor TgtMetafileProcessor.Create(ADocumentEngine
  : TgtCustomDocumentEngine);
begin
  FEngine := TgtHackDocumentEngine(ADocumentEngine);
  (*
    Set PMFPro to Self such that it could be accessed by the
    Call Back function.
  *)

  if FEngine.FSortTextItems then
    FPTextList := @FEngine.CurrentTextItemList
  else
    FPTextList := @FEngine.CurrentDocumentItemList;

  FStartX := 0;
  FStartY := 0;

  FBKMode := OPAQUE;
  FBKColor := clWhite;
  FMapMode := 0;

  FMiterLimit := 10.0;
  // FGdiComment := '';

  FEOFItem := nil;
  FTextItem := nil;
  FImageItem := nil;
  FPolyShapeItem := nil;
  FShapeItem := nil;
  FClipItem := nil;
  FPathItem := nil;
  FPolyDrawItem := nil;

  FCurrentFont := TgtFont.Create;
  FCurrentBrush := TBrush.Create;
  FCurrentPen := TPen.Create;
  FCurrentPalette := TgtPalette.Create;

  FGDIOBJ := nil;
  FGDIOBJList := TList.Create;

  FProcessText := (irText in FEngine.ItemsToRender) and
    (ckText in FEngine.Capabilities);
  FProcessImage := (irImage in FEngine.ItemsToRender) and
    (ckImage in FEngine.Capabilities);
  FProcessShape := (irShape in FEngine.ItemsToRender) and
    (ckShape in FEngine.Capabilities);

  FJustProcessedTextItem := 0;
  FFontStyleChanged := False;
  FTextAlignment := [TA_LEFT];
  FTextColor := clBlack;

  FClipRect.Left := 0;
  FClipRect.Top := 0;
  FClipRect.Right := 0;
  FClipRect.Bottom := 0;

  FInPath := False;
  FCurrentPathPoint.X := 0;
  FCurrentPathPoint.Y := 0;
  FUpdatePathX := 0;
  FJustCompletedPath := 0;
  FSymbolCharsetFontIdx := -1;

  with FXForm do
  begin
    eM11 := 1;
    eM12 := 0;
    eM21 := 0;
    eM22 := 1;
    eDx := 0;
    eDy := 0;
  end;
  FMetaState := TStringList.Create;

  FViewPortOrigin.X := 0;
  FViewPortOrigin.Y := 0;
  FViewPortExtent.cx := 1;
  FViewPortExtent.cy := 1;

  FWindowOrigin.X := 0;
  FWindowOrigin.Y := 0;
  FWindowExtent.cx := 1;
  FWindowExtent.cy := 1;
  FMapMXmul := 1;
  FMapMYmul := 1;

  SetMapModeMultiplier;

  FCombineCharsToSentence := False;
  FIsClipRect := False;
  FIsIntersectClipRect := False;
  FIsWindowsExt := False;
  FIsTransApplied := False;
  // FTransformationItem:=nil;
  // FApplyTransformation :=False;
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.CreateBitmap(var ABitmapStream: TMemoryStream;
  ABitmapFileHeader: BITMAPFILEHEADER; ABitmapInfoHeader: BITMAPINFOHEADER;
  APBmiSrc, APBitSrc: Pointer; ABmiBufCount, ABitBufCount: Cardinal);

var
  LStream: TMemoryStream;
  LSz: Cardinal;
begin
  LStream := TMemoryStream.Create;
  try
    LStream.Write(ABitmapFileHeader, SizeOf(BITMAPFILEHEADER));
    LStream.Write(ABitmapInfoHeader, SizeOf(BITMAPINFOHEADER));
    LSz := 0;
    if (ABitmapInfoHeader.biCompression = BI_BITFIELDS) then
      LSz := LSz + 12 // Add 3 RGB doubleword masks
    else
    begin
      if not((ABitmapInfoHeader.biCompression = BI_RGB) and
        (ABitmapInfoHeader.biBitCount > 8) and
        (ABitmapInfoHeader.biClrUsed = 0)) then
      begin
        if (ABitmapInfoHeader.biClrUsed = 0) then
          LSz := LSz + (1 shl ABitmapInfoHeader.biBitCount) * 4
        else
          LSz := LSz + ABitmapInfoHeader.biClrUsed * 4;
      end
    end;
    LStream.Write(APBmiSrc^, LSz);
    // Write bits
    LStream.Write(APBitSrc^, ABitBufCount);

    LStream.Position := 0;
    if ABitmapStream = nil then
      ABitmapStream := TMemoryStream.Create;
    ABitmapStream.CopyFrom(LStream, 0);
  finally
    LStream.Free;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.CreateImageItem(var AImageItem: TgtImageItem);
begin
  AImageItem := TgtImageItem.Create;
  AImageItem.Settings := FEngine.ImageSettings;
  if not(AImageItem.Settings.AutoSize) then
    AImageItem.Settings.Stretch := True;

  AImageItem.IndexNo := FEngine.FImageResourceList.add(nil);
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.CreateShapeItem(var AShapeItem: TgtShapeItem;
  AShapeType: TgtShapeType);
begin
  AShapeItem := TgtShapeItem.Create(True, AShapeType);
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.CreateTextItem(var ATextItem: TgtTextItem);
begin
  ATextItem := TgtTextItem.Create;
  ATextItem.IsFromMetafile := True;
end;

// procedure TgtMetafileProcessor.CreateTransformationItem(var ATransformationItem
// : TgtTransformationItem);
// begin
// ATransformationItem := TgtTransformationItem.Create;
// end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.CreateClipItem(var AClipItem: TgtClipItem);
begin
  AClipItem := TgtClipItem.Create;
end;

{ ------------------------------------------------------------------------------ }
procedure TgtMetafileProcessor.CreatePathItem(var APathItem: TgtPathItem);
begin
  APathItem := TgtPathItem.Create;
end;

procedure TgtMetafileProcessor.CreateGDIRec(var AGDIOBJ: TgtGDIOBJ;
  AGDIOBJType: TgtGDIOBJType);
begin
  AGDIOBJ := TgtGDIOBJ.Create(AGDIOBJType);
end;
{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.CreateEOFItem(var AEOFItem: TgtEOFItem);
begin
  AEOFItem := TgtEOFItem.Create;
end;

procedure TgtMetafileProcessor.CreatePolyDrawItem(var APolyDrawItem
  : TgtPolyDrawItem);
begin
  APolyDrawItem := TgtPolyDrawItem.Create;
end;
{ ------------------------------------------------------------------------------ }
destructor TgtMetafileProcessor.Destroy;

var
  I: Integer;
begin
  for I := 0 to FGDIOBJList.Count - 1 do
    TgtGDIOBJ(FGDIOBJList[I]).Free;

  FreeAndNil(FGDIOBJList);

  for I := 0 to FMetaState.Count - 1 do
    TgtMetaState(FMetaState.Objects[I]).Free;
  FreeAndNil(FMetaState);

  FCurrentFont.Destroy;
  FCurrentBrush.Destroy;
  FCurrentPen.Destroy;
  FCurrentPalette.Destroy;

  inherited;
end;

function TgtMetafileProcessor.DoCharMapping(AChar: Word): Word;
begin
  // Look up U0000.pdf from http://www.unicode.org/charts/
  // 'ASCII punctuation and symbols' topic
  case (AChar) of
    $2019 { , $02B9, $02BC, $02C8, $0301, $2032, $A78C } :
      Result := $27;
    // $066D, : Result := $2A;
  else
    Result := AChar;
  end;
end;

{ ------------------------------------------------------------------------------ }

function EnhMetaFileProc(AHDC: HDC; AHandleTable: PHandleTable;
  const AEnhMetaRecord: Pointer; AObjectCount: Integer; AOptionalData: Pointer)
  : Integer; stdcall;

var
  LI: Integer;
  LJ: Cardinal;
  LText: WideString;
  LAnsiText: AnsiString;
  LPointer, LPointer2: Pointer;
  LPAnsiChar: PAnsiChar;
  LPByte: PByte;
  LPrevByte: Byte;
  LCharW: WideChar;
  LIntPointer: PInteger;
  LPoints: array of TgtPoint;
  LIsWideString: Boolean;
  LLeft, LTop, LRight, LBottom: Double;
  LBitmapHeader: BITMAPFILEHEADER;
  LBitmapInfoHeader: BITMAPINFOHEADER;
  LBitmapStream: TMemoryStream;
  LBitmap, LOpBitmap, LOpBitmap1: TBitmap;
  LPBmiSrc, LPBitSrc: Pointer;
  ImageIndex: Integer;
  LXPoint: TgtPoint;
  LcxDest, LcyDest, LxDest, LyDest, LTextWidth, SrcWidth, SrcHeight, DestHeight,
    DestWidth: Double;
  LrclBounds: TgtRect;
  PMFPro: PTgtMetafileProcessor;

  l_Brush     : TBrush;
  l_PFrameRgn : PEMRFrameRgn;
  (*l_RGNData   : PRgnData;
  l_PointIndex: Integer;*)

  I: Integer;
  Rgn: RGNDATA;
  M: Integer;
  TempVar: Integer;
  TempArray: array [1 .. 4] of Integer;
  J: Integer;
  LeftTop, BottomRight: TgtPoint;

function IsSymbolCharset(const FaceName: String): Boolean;

var
  LList: TList;
begin
  LList := TList.Create;
  try
    GetSupportedCharSets(FaceName, LList);
    Result := ((LList.Count = 1) and (Byte(LList.Items[0]) = 2));
  finally
    LList.Free;
  end;
end;

procedure CheckUnderlinePattern;
begin
  (*
    This check is done to determine if the recently rendered text is
    underlined/strikedout.
    This check usually needs to be done in case of Word generated EMF file.
    By analysis, if underline/strikeout is not included in
    EMR_EXTCREATEFONTINDIRECTW, it could be rendered as an image using
    EMR_STRETCHBLT, EMR_BITBLT...
    If underline/strikeout is indicated through EMR_STRETCHBLT..., then
    underline/strikeout can be recognized by the order
    EMR_SELECTOBJECT - ihObject will be an invalid object
    EMR_STRETCHBLT/ EMR_BITBLT....
    EMR_SELECTOBJECT - ihObject will be an invalid object

    Based on the above pattern analysis,
    * FJustProcessedTextItem is set to 3 in
    EMR_EXTTEXTOUTA/ EMR_EXTTEXTOUTW record.
    * In EMR_SELECTOBJECT, if ihObject is invalid object and if
    FJustProcessedTextItem is greater than 0, FJustProcessedTextItem
    is decremented by 1. After decrement if FJustProcessedTextItem = 0
    then current FStretchBltRect value is used to determine
    underline/strikeout position.
  *)
  if PMFPro.FJustProcessedTextItem > 0 then
  begin
    Dec(PMFPro.FJustProcessedTextItem);
    if (PMFPro.FJustProcessedTextItem = 0) then
    begin
      (* If the StretchBlt rect is not a underline, create a shape item. *)
      if PMFPro.CheckAndSetUnderlineStrikeOut then
        PMFPro.FJustProcessedStretchBltShape := False;
    end;
  end; (* End if *)

  if PMFPro.FJustProcessedStretchBltShape and PMFPro.FProcessShape then
  begin
    SetLength(LPoints, 2);

    LPoints[0] := gtPoint(PMFPro.FStretchBltRect.Left,
      PMFPro.FStretchBltRect.Top);
    LPoints[1] := gtPoint(PMFPro.FStretchBltRect.Right,
      PMFPro.FStretchBltRect.Bottom);

    if (LPoints[0].X = LPoints[1].X) or (LPoints[0].Y = LPoints[1].Y) then
    begin
      PMFPro.CreateShapeItem(PMFPro.FShapeItem, stLine);
      PMFPro.FShapeItem.Pen.Color := PMFPro.FCurrentBrush.Color;
    end
    else
    begin
      PMFPro.CreateShapeItem(PMFPro.FShapeItem, stRectangle);
      PMFPro.FShapeItem.Brush := PMFPro.FCurrentBrush;
      PMFPro.FShapeItem.Pen := PMFPro.FCurrentPen;

      if PMFPro.FBKMode = OPAQUE then
      begin
        PMFPro.FShapeItem.Pen.Color := PMFPro.FBKColor;
      end
      else
      begin
        PMFPro.FShapeItem.Brush.Color := PMFPro.FCurrentBrush.Color;
        PMFPro.FShapeItem.Pen.Style := psClear;
      end;

      if PMFPro.FROP2 = R2_COPYPEN then
      begin
        PMFPro.FShapeItem.Pen.Color := PMFPro.FShapeItem.Brush.Color;
      end;
    end;

    with PMFPro.FShapeItem do
    begin
      NoPoints := 2;
      LPoints[0].X := LPoints[0].X *
        (CPixelsPerInch / PMFPro.FEngine.InputXRes);
      LPoints[0].Y := LPoints[0].Y *
        (CPixelsPerInch / PMFPro.FEngine.InputYRes);
      LPoints[1].X := LPoints[1].X *
        (CPixelsPerInch / PMFPro.FEngine.InputXRes);
      LPoints[1].Y := LPoints[1].Y *
        (CPixelsPerInch / PMFPro.FEngine.InputYRes);

      LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
      LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;

      LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
      LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;
      SetPoints(LPoints);
      PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
    end;
    PMFPro.FJustProcessedStretchBltShape := False;
  end;
end;

function GetACPCharset(AName: String): TFontCharset;

var
  LList: TList;
begin
  Result := 0;
  LList := TList.Create;
  GetSupportedCharSets(AName, LList);
  if (LList.Count = 1) then
    Result := Byte(LList.Items[0])
  else
  begin
    case GetACP of
      1252:
        Result := ANSI_CHARSET;
      932:
        Result := SHIFTJIS_CHARSET;
      949:
        Result := HANGEUL_CHARSET;
      1361:
        Result := JOHAB_CHARSET;
      936:
        Result := GB2312_CHARSET;
      950:
        Result := CHINESEBIG5_CHARSET;
      1253:
        Result := GREEK_CHARSET;
      1254:
        Result := TURKISH_CHARSET;
      1258:
        Result := VIETNAMESE_CHARSET;
      1255:
        Result := HEBREW_CHARSET;
      1256:
        Result := ARABIC_CHARSET;
      1257:
        Result := BALTIC_CHARSET;
      874:
        Result := THAI_CHARSET;
      1250:
        Result := EASTEUROPE_CHARSET;
      1251:
        Result := RUSSIAN_CHARSET;
    end;
  end;
  LList.Free;
end;

var
 l_PitchFlag: Byte;
begin
  PMFPro := PTgtMetafileProcessor(AOptionalData);
  if AEnhMetaRecord = nil then
  begin
    Result := 1;
    Exit;
  end;
  Inc(PMFPro.FCurrentRecord);

  case EMR(AEnhMetaRecord^).iType of
    EMR_SELECTOBJECT:
      begin
        with EMRSELECTOBJECT(AEnhMetaRecord^) do
        begin
          (*
            Check if the handle to object is a stock object.
            This can be done by checking the higher order bit of the ihObject.
            Then ihObject and $7fffffff gives the stock object constant no.
            like NULL_BRUSH, WHITE_BRUSH......
          *)
          if (ihObject = 0) then
          begin
            PMFPro.SelectStockObject(ihObject);
            Result := 1;
            Exit;
          end;

          if ((ihObject and $80000000) <> 0) then
          begin
            PMFPro.SelectStockObject(ihObject and $7FFFFFFF);
            Result := 1;
            Exit;
          end;
          if (Round(ihObject) > PMFPro.FGDIOBJList.Count) then
          begin
            Result := 1;
            Exit;
          end;
          case TgtGDIOBJ(PMFPro.FGDIOBJList.Items[ihObject - 1]).FGDIOBJType of
            goPen:
              PMFPro.FCurrentPen.Assign
                (TgtGDIOBJ(PMFPro.FGDIOBJList.Items[ihObject - 1]).FPen);
            goBrush:
              PMFPro.FCurrentBrush.Assign
                (TgtGDIOBJ(PMFPro.FGDIOBJList.Items[ihObject - 1]).FBrush);
            goFont:
              begin
                PMFPro.FCurrentFont.Assign
                  (TgtGDIOBJ(PMFPro.FGDIOBJList.Items[ihObject - 1]).FFont);
                if (IsSymbolCharset(PMFPro.FCurrentFont.Name)) then
                  PMFPro.FSymbolCharsetFontIdx := -1
                else
                  PMFPro.FSymbolCharsetFontIdx := 1;
              end;
          else
            Result := 1;
            Exit;
          end;
        end;
      end; { - End EMR_SELECTOBJECT - }

    EMR_SELECTPALETTE:
      begin
        with EMRSELECTPALETTE(AEnhMetaRecord^) do
        begin
          if ((ihPal and $80000000) <> 0) then
          begin
            PMFPro.SelectStockObject(ihPal and $7FFFFFFF);
            Result := 1;
            Exit;
          end;
          if (ihPal <= Cardinal(PMFPro.FGDIOBJList.Count)) then
            PMFPro.FCurrentPalette.FLogPalette :=
              TgtPalette(TgtGDIOBJ(PMFPro.FGDIOBJList.Items[ihPal - 1])
              .FPalette).FLogPalette;
        end;
      end; { - End EMR_SELECTPALETTE - }

    EMR_DELETEOBJECT:
      begin
        with EMRDELETEOBJECT(AEnhMetaRecord^) do
        begin
          if (Round(ihObject) > PMFPro.FGDIOBJList.Count) then
          begin
            Result := 1;
            Exit;
          end;
          TgtGDIOBJ(PMFPro.FGDIOBJList[ihObject - 1]).Free;
          PMFPro.FGDIOBJList.Delete(ihObject - 1);
          PMFPro.CreateGDIRec(PMFPro.FGDIOBJ, goNone);
          PMFPro.FGDIOBJList.Insert((ihObject - 1), PMFPro.FGDIOBJ);
        end;
      end; { - End EMR_DELETEOBJECT - }

    EMR_SETTEXTCOLOR:
      begin
        with EMRSETTEXTCOLOR(AEnhMetaRecord^) do
          PMFPro.FTextColor := PMFPro.GetColorValue(crColor);
      end; { - End EMR_SETTEXTCOLOR - }

    EMR_SETTEXTALIGN:
      begin
        {
          Text Alignment Options
          TA_NOUPDATECP = 0;
          TA_UPDATECP = 1;
          TA_LEFT = 0;
          TA_RIGHT = 2;
          TA_CENTER = 6;
          TA_TOP = 0;
          TA_BOTTOM = 8;
          TA_BASELINE = 24;
          TA_RTLREADING = $100;
          TA_MASK =  (TA_BASELINE+TA_CENTER+TA_UPDATECP+TA_RTLREADING);
        }
        with TEMRSETTEXTALIGN(AEnhMetaRecord^) do
          PMFPro.SetAlignment(iMode, PMFPro.FTextAlignment);
      end; { - End EMR_SETTEXTALIGN - }

    EMR_SETBKCOLOR:
      begin
        with TEMRSetBkColor(AEnhMetaRecord^) do
          PMFPro.FBKColor := PMFPro.GetColorValue(crColor);
      end; { - End EMR_SETBKCOLOR - }

    EMR_SETBKMODE:
      with TEMRSETBKMODE(AEnhMetaRecord^) do
      begin
        {
          Background Modes
          TRANSPARENT = 1;
          OPAQUE = 2;
          BKMODE_LAST = 2;
        }
        PMFPro.FBKMode := iMode;
      end; { - End EMR_SETBKMODE - }

    EMR_SETMAPMODE:
      begin
        {
          Mapping Modes

          MM_TEXT = 1;
          MM_LOMETRIC = 2;
          MM_HIMETRIC = 3;
          MM_LOENGLISH = 4;
          MM_HIENGLISH = 5;
          MM_TWIPS = 6;
          MM_ISOTROPIC = 7;
          MM_ANISOTROPIC = 8;
        }
        { All other modes may be considered. }
        with TEMRSETMAPMODE(AEnhMetaRecord^) do
        begin
          PMFPro.FMapMode := iMode;
          if iMode = MM_TEXT then
          begin
            PMFPro.FViewPortOrigin.X := 0;
            PMFPro.FViewPortOrigin.Y := 0;
            PMFPro.FViewPortExtent.cx := 1;
            PMFPro.FViewPortExtent.cy := 1;

            PMFPro.FWindowOrigin.X := 0;
            PMFPro.FWindowOrigin.Y := 0;
            PMFPro.FWindowExtent.cx := 1;
            PMFPro.FWindowExtent.cy := 1;
            PMFPro.FMapMXmul := 1;
            PMFPro.FMapMYmul := 1;
          end;
        end;
      end; { - End EMR_SETMAPMODE - }

    EMR_SETVIEWPORTORGEX:
      begin
        with EMRSETVIEWPORTORGEX(AEnhMetaRecord^) do
        begin
          PMFPro.FViewPortOrigin.X := ptlOrigin.X;
          PMFPro.FViewPortOrigin.Y := ptlOrigin.Y;
        end;
      end; { - End EMR_SETVIEWPORTORGEX - }

    EMR_SETVIEWPORTEXTEX:
      begin
        with EMRSETVIEWPORTEXTEX(AEnhMetaRecord^) do
        begin
          PMFPro.FViewPortExtent.cx := szlExtent.cx;
          PMFPro.FViewPortExtent.cy := szlExtent.cy;
          PMFPro.SetMapModeMultiplier;
        end;
      end; { - End EMR_SETVIEWPORTEXTEX - }

    EMR_SETWINDOWORGEX:
      begin
        with EMRSETWINDOWORGEX(AEnhMetaRecord^) do
        begin
          PMFPro.FWindowOrigin.X := ptlOrigin.X;
          PMFPro.FWindowOrigin.Y := ptlOrigin.Y;
        end;
      end; { - End EMR_SETWINDOWORGEX - }

    EMR_SETWINDOWEXTEX:
      begin
        with EMRSETWINDOWEXTEX(AEnhMetaRecord^) do
        begin
          PMFPro.FWindowExtent.cx := szlExtent.cx;
          PMFPro.FWindowExtent.cy := szlExtent.cy;
          PMFPro.SetMapModeMultiplier;
          PMFPro.FIsWindowsExt := True;
        end;
      end; { - End EMR_SETWINDOWEXTEX - }
    EMR_SCALEVIEWPORTEXTEX:
      begin
        with EMRSCALEVIEWPORTEXTEX(AEnhMetaRecord^) do
        begin
          PMFPro.FViewPortExtent.cx := PMFPro.FViewPortExtent.cx *
            xNum div xDenom;
          PMFPro.FViewPortExtent.cy := PMFPro.FViewPortExtent.cy *
            yNum div yDenom;
          PMFPro.SetMapModeMultiplier;
        end;
      end;
    EMR_SCALEWINDOWEXTEX:
      begin
        with EMRSCALEWINDOWEXTEX(AEnhMetaRecord^) do
        begin
          PMFPro.FWindowExtent.cx := PMFPro.FWindowExtent.cx * xNum div xDenom;
          PMFPro.FWindowExtent.cy := PMFPro.FWindowExtent.cy * yNum div yDenom;
          PMFPro.SetMapModeMultiplier;
        end;
      end;
    EMR_SETICMMODE:
      begin
        (*
          ICM_OFF = 1;
          ICM_ON = 2;
          ICM_QUERY = 3;
        *)

        with TEMRSETICMMODE(AEnhMetaRecord^) do
          PMFPro.FICMMode := iMode;
      end; { - End EMR_SETICMMODE - }

    EMR_SETPOLYFILLMODE:
      begin
        {
          ALTERNATE = 1;
          WINDING = 2;
          POLYFILL_LAST = 2;
        }

        with TEMRSETPOLYFILLMODE(AEnhMetaRecord^) do
          PMFPro.FPolyFillMode := iMode;
      end; { - End EMR_SETPOLYFILLMODE - }

    EMR_SETMITERLIMIT:
      begin
        with EMRSETMITERLIMIT(AEnhMetaRecord^) do
          PMFPro.FMiterLimit := eMiterLimit;
      end; { - End EMR_SETMITERLIMIT - }

    EMR_SETWORLDTRANSFORM:
      begin
        // PMFPro.CreateTransformationItem(PMFPro.FTransformationItem);

        with EMRSETWORLDTRANSFORM(AEnhMetaRecord^) do
          with PMFPro.FXForm do
          begin
            eM11 := xform.eM11;
            eM12 := xform.eM12;
            eM21 := xform.eM21;
            eM22 := xform.eM22;
            eDx := xform.eDx;
            eDy := xform.eDy;
          end;
        PMFPro.FIsTransApplied := True;
        // PMFPro.FTransformationItem.Transformation := PMFPro.FXForm;
        // PMFPro.FEngine.CurrentDocumentItemList.Add(PMFPro.FTransformationItem);
      end; { - End EMR_SETWORLDTRANSFORM - }

    EMR_MODIFYWORLDTRANSFORM:
      begin
        {
          MWT_IDENTITY = 1;
          MWT_LEFTMULTIPLY = 2;
          MWT_RIGHTMULTIPLY = 3;

          MWT_MIN = MWT_IDENTITY;
          MWT_MAX = MWT_RIGHTMULTIPLY;
        }

        with EMRMODIFYWORLDTRANSFORM(AEnhMetaRecord^) do
          with PMFPro.FXForm do
          begin
            case iMode of
              MWT_IDENTITY:
                begin
                  eM11 := 1;
                  eM12 := 0;
                  eM21 := 0;
                  eM22 := 1;
                  eDx := 0;
                  eDy := 0;
                end;
              MWT_LEFTMULTIPLY:
                CombineTransform(PMFPro.FXForm, xform, PMFPro.FXForm);
              MWT_RIGHTMULTIPLY:
                CombineTransform(PMFPro.FXForm, PMFPro.FXForm, xform);
            else
              begin
                eM11 := xform.eM11;
                eM12 := xform.eM12;
                eM21 := xform.eM21;
                eM22 := xform.eM22;
                eDx := xform.eDx;
                eDy := xform.eDy;
              end;
            end;
          end;
        PMFPro.FIsTransApplied := True;
      end; { - End EMR_MODIFYWORLDTRANSFORM - }

    EMR_EXTCREATEFONTINDIRECTW:
      if PMFPro.FProcessText then
      begin
        with EMREXTCREATEFONTINDIRECTW(AEnhMetaRecord^) do
        begin
          {
            OutPrecision
            OUT_DEFAULT_PRECIS = 0;
            OUT_STRING_PRECIS = 1;
            OUT_CHARACTER_PRECIS = 2;
            OUT_STROKE_PRECIS = 3;
            OUT_TT_PRECIS = 4;
            OUT_DEVICE_PRECIS = 5;
            OUT_RASTER_PRECIS = 6;
            OUT_TT_ONLY_PRECIS = 7;
            OUT_OUTLINE_PRECIS = 8;
            OUT_SCREEN_OUTLINE_PRECIS = 9;
          }

          {
            ClipPrecision
            CLIP_DEFAULT_PRECIS = 0;
            CLIP_CHARACTER_PRECIS = 1;
            CLIP_STROKE_PRECIS = 2;
            CLIP_MASK = 15;
            CLIP_LH_ANGLES = (1 shl 4);
            CLIP_TT_ALWAYS = (2 shl 4);
            CLIP_EMBEDDED  = (8 shl 4);
          }

          {
            Quality
            DEFAULT_QUALITY = 0;
            DRAFT_QUALITY = 1;
            PROOF_QUALITY = 2;
            NONANTIALIASED_QUALITY = 3;
            ANTIALIASED_QUALITY = 4;
          }

          (*
            Pitch
            DEFAULT_PITCH = 0;
            FIXED_PITCH = 1;
            VARIABLE_PITCH = 2;
            MONO_FONT = 8;

            Font Families
            FF_DONTCARE   = (0 shl 4);     { Don't care or don't know. }
            FF_ROMAN      = (1 shl 4);     { Variable stroke width, serifed. }
            { Times Roman, Century Schoolbook, etc. }
            FF_SWISS      = (2 shl 4);     { Variable stroke width, sans-serifed. }
            { Helvetica, Swiss, etc. }
            FF_MODERN     = (3 shl 4);     { Constant stroke width, serifed or sans-serifed. }
            { Pica, Elite, Courier, etc. }
            FF_SCRIPT     = (4 shl 4);     { Cursive, etc. }
            FF_DECORATIVE = (5 shl 4);     { Old English, etc. }
          *)

          PMFPro.CreateGDIRec(PMFPro.FGDIOBJ, goFont);

          PMFPro.FGDIOBJ.FFont.Handle := ihFont;
          PMFPro.FGDIOBJ.FFont.Name := elfw.elfLogFont.lfFaceName;
          PMFPro.FGDIOBJ.FFont.Charset := elfw.elfLogFont.lfCharSet;
          // if (PMFPro.FGDIOBJ.FFont.Charset = DEFAULT_CHARSET) then
          // PMFPro.FGDIOBJ.FFont.Charset := GetACPCharset(PMFPro.FGDIOBJ.FFont.Name);
          l_PitchFlag := elfw.elfLogFont.lfPitchAndFamily;
          l_PitchFlag := l_PitchFlag and 3;
          case l_PitchFlag of
            0:
              PMFPro.FGDIOBJ.FFont.Pitch := fpDefault;
            1:
              PMFPro.FGDIOBJ.FFont.Pitch := fpFixed;
            2:
              PMFPro.FGDIOBJ.FFont.Pitch := fpVariable;
          end;
          PMFPro.FGDIOBJ.FFont.Style := [];
          if elfw.elfLogFont.lfItalic <> 0 then
            PMFPro.FGDIOBJ.FFont.Style := PMFPro.FGDIOBJ.FFont.Style +
              [fsItalic];
          if elfw.elfLogFont.lfWeight = FW_BOLD then
            PMFPro.FGDIOBJ.FFont.Style := PMFPro.FGDIOBJ.FFont.Style + [fsBold];
          if elfw.elfLogFont.lfUnderline <> 0 then
            PMFPro.FGDIOBJ.FFont.Style := PMFPro.FGDIOBJ.FFont.Style +
              [fsUnderline];
          if elfw.elfLogFont.lfStrikeOut <> 0 then
            PMFPro.FGDIOBJ.FFont.Style := PMFPro.FGDIOBJ.FFont.Style +
              [fsStrikeOut];

          if (PMFPro.FMapMode = 0) or (PMFPro.FMapMode = MM_ANISOTROPIC) or
            (PMFPro.FMapMode = MM_ISOTROPIC) then
            PMFPro.FGDIOBJ.FFont.Size :=
              Round(PMFPro.GetSizeFromHeight(elfw.elfLogFont.lfHeight))
          else
            PMFPro.FGDIOBJ.FFont.Height := elfw.elfLogFont.lfHeight;

          if (PMFPro.FMapMode = MM_ANISOTROPIC) or
            (PMFPro.FMapMode = MM_ISOTROPIC) then
          begin
            LI := Round(PMFPro.FViewPortExtent.cx /
              (CPixelsPerInch / PMFPro.FEngine.InputXRes));
            PMFPro.FGDIOBJ.FFont.Height :=
              Round((PMFPro.FGDIOBJ.FFont.Height / (PMFPro.FWindowExtent.cx /
              LI)) * (CPixelsPerInch / PMFPro.FEngine.InputXRes));
          end
          else if (PMFPro.FMapMode = 0) then
            PMFPro.FGDIOBJ.FFont.Size :=
              Round(PMFPro.GetSizeFromHeight(elfw.elfLogFont.lfHeight *
              PMFPro.FXForm.eM22))
          else
            PMFPro.FGDIOBJ.FFont.Height :=
              Round(PMFPro.FGDIOBJ.FFont.Height * PMFPro.FXForm.eM22);

          if (PMFPro.FGDIOBJ.FFont.Size > 100) and
            (PMFPro.FIsTransApplied or PMFPro.FIsWindowsExt) then
            PMFPro.FGDIOBJ.FFont.Size := Round(PMFPro.FGDIOBJ.FFont.Size / 100);

          PMFPro.FGDIOBJ.FFont.FRotateFont := elfw.elfLogFont.lfEscapement;

          if (PMFPro.FGDIOBJList.Count < Round(ihFont)) then
            PMFPro.FGDIOBJList.add(PMFPro.FGDIOBJ)
          else
          begin
            TgtGDIOBJ(PMFPro.FGDIOBJList[ihFont - 1]).Free;
            PMFPro.FGDIOBJList.Delete(ihFont - 1);
            PMFPro.FGDIOBJList.Insert(ihFont - 1, PMFPro.FGDIOBJ);
          end;
        end;

      end; { - End EMR_EXTCREATEFONTINDIRECTW - }

    EMR_CREATEPEN:
      begin
        {
          PS_SOLID        = 0
          PS_DASH         = 1
          PS_DOT          = 2
          PS_DASHDOT      = 3
          PS_DASHDOTDOT   = 4
          PS_NULL         = 5
          PS_INSIDEFRAME  = 6
        }
        with EMRCREATEPEN(AEnhMetaRecord^) do
        begin
          PMFPro.CreateGDIRec(PMFPro.FGDIOBJ, goPen);
          with PMFPro.FGDIOBJ.FPen do
          begin
            if lopn.lopnWidth.X = 0 then
              Width := 1
            else
            begin
              Width := Round(PMFPro.ApplyMMToPenWidth(lopn.lopnWidth.X));
              if Width = 0 then
                Width := 1;
            end;
            case lopn.lopnStyle of
              PS_SOLID:
                Style := psSolid;
              PS_DASH:
                Style := psDash;
              PS_DOT:
                Style := psDot;
              PS_DASHDOT:
                Style := psDashDot;
              PS_DASHDOTDOT:
                Style := psDashDotDot;
              PS_NULL:
                Style := psClear;
              PS_INSIDEFRAME:
                Style := psInsideFrame;
            end; { - End Case lopn.lopnStyle - }
            Color := PMFPro.GetColorValue(lopn.lopnColor);
          end;
          if (PMFPro.FGDIOBJList.Count < Round(ihPen)) then
            PMFPro.FGDIOBJList.add(PMFPro.FGDIOBJ)
          else
          begin
            TgtGDIOBJ(PMFPro.FGDIOBJList[ihPen - 1]).Free;
            PMFPro.FGDIOBJList.Delete(ihPen - 1);
            PMFPro.FGDIOBJList.Insert(ihPen - 1, PMFPro.FGDIOBJ);
          end;
        end;
      end; { - End EMR_CREATEPEN - }

    EMR_CREATEBRUSHINDIRECT:
      begin
        with EMRCREATEBRUSHINDIRECT(AEnhMetaRecord^) do
        begin
          {
            Brush Styles
            BS_SOLID                = 0;
            BS_NULL                 = 1;
            BS_HOLLOW               = BS_NULL;
            BS_HATCHED              = 2;
            BS_PATTERN              = 3;
            BS_INDEXED              = 4;
            BS_DIBPATTERN           = 5;
            BS_DIBPATTERNPT         = 6;
            BS_PATTERN8X8           = 7;
            BS_DIBPATTERN8X8        = 8;
            BS_MONOPATTERN          = 9;
          }

          (*
            Hatch Styles
            HS_HORIZONTAL = 0;       { ----- }
            HS_VERTICAL   = 1;       { ||||| }
            HS_FDIAGONAL  = 2;       { ///// } { Wrong - \\\\\ }
            HS_BDIAGONAL  = 3;       { \\\\\ } { Wrong - ///// }
            HS_CROSS      = 4;       { +++++ }
            HS_DIAGCROSS  = 5;       { xxxxx }
          *)
          PMFPro.CreateGDIRec(PMFPro.FGDIOBJ, goBrush);
          PMFPro.FGDIOBJ.FBrush.Bitmap := nil;
          with PMFPro.FGDIOBJ.FBrush do
          begin
            // Color := PMFPro.GetColorValue(lb.lbColor);
            Color := lb.lbColor;
            case lb.lbStyle of
              BS_SOLID:
                Style := bsSolid;
              BS_NULL:
                Style := bsClear;
              BS_HATCHED:
                begin
                  case lb.lbHatch of
                    HS_HORIZONTAL:
                      Style := bsHorizontal;
                    HS_VERTICAL:
                      Style := bsVertical;
                    HS_FDIAGONAL:
                      Style := bsFDiagonal;
                    HS_BDIAGONAL:
                      Style := bsBDiagonal;
                    HS_CROSS:
                      Style := bsCross;
                    HS_DIAGCROSS:
                      Style := bsDiagCross;
                  end; { - End Case lb.lbHatch - }
                end;
            end; { - End Case lb.lbStyle - }
          end;
          if (PMFPro.FGDIOBJList.Count < Round(ihBrush)) then
            PMFPro.FGDIOBJList.add(PMFPro.FGDIOBJ)
          else
          begin
            TgtGDIOBJ(PMFPro.FGDIOBJList[ihBrush - 1]).Free;
            PMFPro.FGDIOBJList.Delete(ihBrush - 1);
            PMFPro.FGDIOBJList.Insert(ihBrush - 1, PMFPro.FGDIOBJ);
          end;
        end;
      end; { - End EMR_CREATEBRUSHINDIRECT - }

    EMR_CREATEDIBPATTERNBRUSHPT, EMR_CREATEMONOBRUSH:
      begin
        with EMRCREATEDIBPATTERNBRUSHPT(AEnhMetaRecord^) do
        begin
          if ((cbBmi = 0) or (cbBits = 0)) then
          begin
            Result := 1;
            Exit;
          end;
          LPointer := AEnhMetaRecord;
          Inc(PAnsiChar(LPointer), offBmi);
          LBitmapInfoHeader := BITMAPINFO(LPointer^).bmiHeader;
          LBitmapHeader.bfType := 19778;
          LBitmapHeader.bfSize := SizeOf(BITMAPFILEHEADER) + cbBmi + cbBits;
          LBitmapHeader.bfOffBits := SizeOf(BITMAPFILEHEADER) + cbBmi;
          LBitmapStream := TMemoryStream.Create;
          try
            LPBmiSrc := AEnhMetaRecord;
            Inc(PAnsiChar(LPBmiSrc), offBmi);
            Inc(PAnsiChar(LPBmiSrc), SizeOf(BITMAPINFOHEADER));
            LPBitSrc := AEnhMetaRecord;
            Inc(PAnsiChar(LPBitSrc), offBits);
            PMFPro.CreateBitmap(LBitmapStream, LBitmapHeader, LBitmapInfoHeader,
              LPBmiSrc, LPBitSrc, (cbBmi - SizeOf(BITMAPINFOHEADER)), cbBits);
          finally
            PMFPro.CreateGDIRec(PMFPro.FGDIOBJ, goBrush);
            PMFPro.FGDIOBJ.FBrush.Bitmap := TBitmap.Create;
            LBitmapStream.Position := 0;
            PMFPro.FGDIOBJ.FBrush.Bitmap.LoadFromStream(LBitmapStream);
            LBitmapStream.Free;
          end;
          if (PMFPro.FGDIOBJList.Count < Round(ihBrush)) then
            PMFPro.FGDIOBJList.add(PMFPro.FGDIOBJ)
          else
          begin
            TgtGDIOBJ(PMFPro.FGDIOBJList[ihBrush - 1]).Free;
            PMFPro.FGDIOBJList.Delete(ihBrush - 1);
            PMFPro.FGDIOBJList.Insert(ihBrush - 1, PMFPro.FGDIOBJ);
          end;
        end;
      end; { - End EMR_CREATEDIBPATTERNBRUSHPT - }

    EMR_CREATEPALETTE:
      begin
        with EMRCREATEPALETTE(AEnhMetaRecord^) do
        begin
          PMFPro.CreateGDIRec(PMFPro.FGDIOBJ, goPalette);
          PMFPro.FGDIOBJ.FPalette.FLogPalette := lgpl;
          if (PMFPro.FGDIOBJList.Count < Round(ihPal)) then
            PMFPro.FGDIOBJList.add(PMFPro.FGDIOBJ)
          else
          begin
            TgtGDIOBJ(PMFPro.FGDIOBJList[ihPal - 1]).Free;
            PMFPro.FGDIOBJList.Delete(ihPal - 1);
            PMFPro.FGDIOBJList.Insert(ihPal - 1, PMFPro.FGDIOBJ);
          end;
        end;
      end; { - End EMR_CREATEPALETTE - }

    EMR_EXTTEXTOUTA, EMR_EXTTEXTOUTW:
      if PMFPro.FProcessText then
      begin
        with EMREXTTEXTOUTA(AEnhMetaRecord^) do
        begin
          if ((emrtext.fOptions and ETO_OPAQUE) <> 0) and
            (not((emrtext.rcl.Left = 0) and (emrtext.rcl.Top = 0) and
            (emrtext.rcl.Right = -1) and (emrtext.rcl.Bottom = -1))) and
            (PMFPro.FProcessShape) then
          begin
            SetLength(LPoints, 2);

            // LPoints[0] := gtPoint(emrtext.rcl.Left, emrtext.rcl.Top);
            // LPoints[1] := gtPoint(emrtext.rcl.Right, emrtext.rcl.Bottom);

            LPoints[0] := PMFPro.ApplyMMWithOrigin(emrtext.rcl.Left,
              emrtext.rcl.Top);
            LPoints[1] := PMFPro.ApplyMMWithOrigin(emrtext.rcl.Right,
              emrtext.rcl.Bottom);

            if (LPoints[0].X = LPoints[1].X) or
              (LPoints[0].Y = LPoints[1].Y) then
            begin
              PMFPro.CreateShapeItem(PMFPro.FShapeItem, stLine);
              PMFPro.FShapeItem.Pen.Color := PMFPro.FCurrentBrush.Color;
            end
            else
            begin
              PMFPro.CreateShapeItem(PMFPro.FShapeItem, stRectangle);
              PMFPro.FShapeItem.Brush := PMFPro.FCurrentBrush;
              PMFPro.FShapeItem.Pen := PMFPro.FCurrentPen;
              if (((emrtext.fOptions) and (ETO_OPAQUE)) <> 0) and
                (PMFPro.FCurrentBrush.Style <> bsClear) then
                PMFPro.FShapeItem.Brush.Color := PMFPro.FBKColor
              else
                PMFPro.FShapeItem.Brush.Style := bsClear;
              PMFPro.FShapeItem.Pen.Style := psClear;
            end;

            with PMFPro.FShapeItem do
            begin
              NoPoints := 2;
              // Resolution already applied - don't apply again

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;

              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;
              SetPoints(LPoints);
              PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
            end;
          end;
          if (emrtext.nChars = 0) then
          begin
            Result := 1;
            Exit;
          end;
          LPByte := AEnhMetaRecord;
          Inc(LPByte, emrtext.offString);
          LText := '';
          LAnsiText := '';
          LIsWideString := False;
          LI := 1;
          while (Cardinal(LI) <= emrtext.nChars) do
          begin
            case (Windows.EMR(AEnhMetaRecord^).iType) of
              EMR_EXTTEXTOUTA:
                begin
                  if (AnsiChar(LPByte^) <> '') then
                    LAnsiText := LAnsiText + AnsiChar(LPByte^);
                  Inc(LPByte, 1);
                end;
              EMR_EXTTEXTOUTW:
                begin
                  LPrevByte := (LPByte^);
                  if (PMFPro.FSymbolCharsetFontIdx <> 1) then
                  begin
                    LCharW := WideChar(LPrevByte);
                    Inc(LPByte, 1);
                  end
                  else
                  begin
                    Inc(LPByte, 1);
                    // LCharW := WideChar(((LPByte^) shl 8) or LPrevByte);
                    LCharW := WideChar
                      (PMFPro.DoCharMapping((((LPByte^) shl 8) or LPrevByte)));
                  end;
                  if (PMFPro.FSymbolCharsetFontIdx <> 1) then
                  begin
                    if (LCharW <> '') then
                      LText := LText + LCharW;
                  end
                  else
                  begin
                    if (LCharW <> '') then
                      LText := LText + LCharW;
                    if (Ord(LCharW) > 255) then
                      LIsWideString := True;
                  end;
                  Inc(LPByte, 1);
                end;
            end;
            Inc(LI);
          end;
        end;
        with EMREXTTEXTOUTA(AEnhMetaRecord^) do
        begin
          PMFPro.CreateTextItem(PMFPro.FTextItem);
          PMFPro.FTextItem.IsWideString := LIsWideString;
          LIntPointer := AEnhMetaRecord;
          Inc(LIntPointer, (emrtext.offDx div 4));
          with PMFPro.FTextItem do
          begin
            SetLength(FCharSpaceArray, emrtext.nChars);
            LTextWidth := 0;
            for I := 0 to emrtext.nChars - 1 do
            begin
              FCharSpaceArray[I] := LIntPointer^ * PMFPro.FXForm.eM11;
              if (PMFPro.FMapMode = MM_ANISOTROPIC) or
                (PMFPro.FMapMode = MM_ISOTROPIC) then
                FCharSpaceArray[I] := FCharSpaceArray[I] * PMFPro.FMapMXmul;
              Inc(LIntPointer);
              LTextWidth := LTextWidth + FCharSpaceArray[I];
            end;
            if (TA_UPDATECP in PMFPro.FTextAlignment) and
              PMFPro.FCombineCharsToSentence then
            begin
              LXPoint := PMFPro.ApplyMMWithOrigin(PMFPro.FCurrentPathPoint.X,
                PMFPro.FCurrentPathPoint.Y);
              X := LXPoint.X + PMFPro.FUpdatePathX;
              Y := LXPoint.Y;
            end
            else
            begin
              LXPoint := PMFPro.ApplyMMWithOrigin(emrtext.ptlReference.X,
                emrtext.ptlReference.Y);
              X := LXPoint.X;
              Y := LXPoint.Y;
            end;
            X := X + PMFPro.FStartX;
            Y := Y + PMFPro.FStartY;

            if ((emrtext.fOptions and ETO_CLIPPED) <> 0) then
            begin
              IsClipRect := True;
              ClipRect := PMFPro.ApplyMMToRect(gtRect(emrtext.rcl.Left,
                emrtext.rcl.Top, emrtext.rcl.Right, emrtext.rcl.Bottom));
              ClipRect := gtRect(ClipRect.Left + PMFPro.FStartX,
                ClipRect.Top + PMFPro.FStartY, ClipRect.Right + PMFPro.FStartX,
                ClipRect.Bottom + PMFPro.FStartY);
            end;
            Font.Assign(PMFPro.FCurrentFont);
            // Temp Update Start

            { if ((LIsWideString)) and ((Font.Charset = ANSI_CHARSET)or (Font.Charset = DEFAULT_CHARSET))then
              begin
              Font.Charset := 161;
              Font.Name := 'Arial Unicode MS';
              end; }
            // Temp Update End

            RotationAngle := Round(PMFPro.FCurrentFont.FRotateFont / 10);

            { Update the current position. }
            if (LAnsiText <> '') then
              LText := String(LAnsiText);
            if (TA_UPDATECP in PMFPro.FTextAlignment) and
              PMFPro.FCombineCharsToSentence then
            begin
              if (TA_RIGHT in PMFPro.FTextAlignment) then
                PMFPro.FUpdatePathX := PMFPro.FUpdatePathX -
                  TextSize(LText, Font).cx
              else // to do: for other alignments, update y also, if needed.
                PMFPro.FUpdatePathX := PMFPro.FUpdatePathX +
                  TextSize(LText, Font).cx;
            end;

            if (TA_RTLREADING in PMFPro.FTextAlignment) then
              PMFPro.FTextItem.BidiMode := bdRightToLeft;

            (*
              Calculate Top-Left position for the text based on the
              Text Alignment that is set.
            *)
            LXPoint := PMFPro.GetTopLeftPosition(X, Y, LText, LTextWidth, Font,
              RotationAngle);
            X := LXPoint.X;
            Y := LXPoint.Y;

            Font.Color := PMFPro.FTextColor;
            Brush.Color := PMFPro.FBKColor;
            if PMFPro.FBKMode = TRANSPARENT then
              Brush.Style := bsClear;

            Lines.add(LText);
          end;

          PMFPro.FPTextList.add(PMFPro.FTextItem);
          PMFPro.FJustProcessedTextItem := 3;
        end;
      end; { - End EMR_EXTTEXTOUTA, EMR_EXTTEXTOUTW - }

    EMR_SETROP2:
      begin
        (*
          Binary raster ops
          R2_BLACK       = 1;     {  0   }
          R2_NOTMERGEPEN = 2;     { DPon }
          R2_MASKNOTPEN  = 3;     { DPna }
          R2_NOTCOPYPEN  = 4;     { PN   }
          R2_MASKPENNOT  = 5;     { PDna }
          R2_NOT         = 6;     { Dn   }
          R2_XORPEN      = 7;     { DPx  }
          R2_NOTMASKPEN  = 8;     { DPan }
          R2_MASKPEN     = 9;     { DPa  }
          R2_NOTXORPEN   = 10;    { DPxn }
          R2_NOP         = 11;    { D    }
          R2_MERGENOTPEN = 12;    { DPno }
          R2_COPYPEN     = 13;    { P    }
          R2_MERGEPENNOT = 14;    { PDno }
          R2_MERGEPEN    = 15;    { DPo  }
          R2_WHITE       = $10;   {  1   }
          R2_LAST        = $10;
        *)
        with TEMRSETROP2(AEnhMetaRecord^) do
          PMFPro.FROP2 := iMode;
      end; { - End EMR_SETROP2 - }

    EMR_SETSTRETCHBLTMODE:
      begin
        {
          BLACKONWHITE = 1;
          WHITEONBLACK = 2;
          COLORONCOLOR = 3;
          HALFTONE = 4;
          MAXSTRETCHBLTMODE = 4;

          // New StretchBlt() Modes
          STRETCH_ANDSCANS = BLACKONWHITE;
          STRETCH_ORSCANS = WHITEONBLACK;
          STRETCH_DELETESCANS = COLORONCOLOR;
          STRETCH_HALFTONE = HALFTONE;
        }
        with TEMRSETSTRETCHBLTMODE(AEnhMetaRecord^) do
          PMFPro.FStretchMode := iMode;
      end; { - End EMR_SETSTRETCHBLTMODE - }

    EMR_STRETCHBLT:
      if PMFPro.FProcessText or PMFPro.FProcessImage or
        PMFPro.FProcessShape then
      begin
        (*
          Ternary raster operations

          SRCCOPY     = $00CC0020;     { dest = source                    }
          SRCPAINT    = $00EE0086;     { dest = source OR dest            }
          SRCAND      = $008800C6;     { dest = source AND dest           }
          SRCINVERT   = $00660046;     { dest = source XOR dest           }
          SRCERASE    = $00440328;     { dest = source AND (NOT dest )    }
          NOTSRCCOPY  = $00330008;     { dest = (NOT source)              }
          NOTSRCERASE = $001100A6;     { dest = (NOT src) AND (NOT dest)  }
          MERGECOPY   = $00C000CA;     { dest = (source AND pattern)      }
          MERGEPAINT  = $00BB0226;     { dest = (NOT source) OR dest      }
          PATCOPY     = $00F00021;     { dest = pattern                   }
          PATPAINT    = $00FB0A09;     { dest = DPSnoo                    }
          PATINVERT   = $005A0049;     { dest = pattern XOR dest          }
          DSTINVERT   = $00550009;     { dest = (NOT dest)                }
          BLACKNESS   = $00000042;     { dest = BLACK                     }
          WHITENESS   = $00FF0062;     { dest = WHITE                     }
        *)

        with EMRSTRETCHBLT(AEnhMetaRecord^) do
        begin
          if ((cbBmiSrc = 0) or (cbBitsSrc = 0)) then
          begin
            if PMFPro.FProcessText and (PMFPro.FPTextList.Count > 0) then
            begin
              PMFPro.FStretchBltRect.Left := rclBounds.Left;
              PMFPro.FStretchBltRect.Top := rclBounds.Top;
              PMFPro.FStretchBltRect.Right := rclBounds.Right;
              PMFPro.FStretchBltRect.Bottom := rclBounds.Bottom;
              if PMFPro.FJustProcessedTextItem > 0 then
                Dec(PMFPro.FJustProcessedTextItem);
              PMFPro.FJustProcessedStretchBltShape := True;
            end
            else if PMFPro.FProcessShape then
            begin
              PMFPro.FStretchBltRect.Left := rclBounds.Left;
              PMFPro.FStretchBltRect.Top := rclBounds.Top;
              PMFPro.FStretchBltRect.Right := rclBounds.Right;
              PMFPro.FStretchBltRect.Bottom := rclBounds.Bottom;
              PMFPro.FJustProcessedStretchBltShape := True;
            end;
            CheckUnderlinePattern;
            Result := 1;
            Exit;
          end;
          if not PMFPro.FProcessImage then
          begin
            Result := 1;
            Exit;
          end;
          LPointer := AEnhMetaRecord;
          Inc(PAnsiChar(LPointer), offBmiSrc);
          LBitmapInfoHeader := BITMAPINFO(LPointer^).bmiHeader;

          PMFPro.CreateImageItem(PMFPro.FImageItem);
          with PMFPro.FImageItem do
          begin

            if (PMFPro.FClipRect.Left <> 0) or (PMFPro.FClipRect.Top <> 0) or
              ((PMFPro.FClipRect.Right - PMFPro.FClipRect.Left) <> 0) or
              ((PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top) <> 0) then
            begin
              PMFPro.FClipRect.Top := rclBounds.Top;
              PMFPro.FClipRect.Left := rclBounds.Left;
              PMFPro.FClipRect.Right := rclBounds.Right;
              PMFPro.FClipRect.Bottom := rclBounds.Bottom;
            end;

            LrclBounds := PMFPro.ApplyMMToRect
              (gtRect(rclBounds.Left, rclBounds.Top, rclBounds.Right,
              rclBounds.Bottom));

            LXPoint := PMFPro.ApplyMMWithOrigin(xDest, yDest);
            LxDest := LXPoint.X;
            LyDest := LXPoint.Y;

            LXPoint := PMFPro.ApplyMM(cxDest, cyDest);
            LcxDest := LXPoint.X;
            LcyDest := LXPoint.Y;

            X := LxDest;
            Y := LyDest;

            Width := LcxDest;
            Height := LcyDest;
            DisplayRect := gtRect(X, Y, (X + Abs(Width)), (Y + Abs(Height)));

            if PMFPro.FIsClipRect then
            begin
              PMFPro.FClipRect.Left := rclBounds.Left;
              PMFPro.FClipRect.Top := rclBounds.Top;
              PMFPro.FClipRect.Right := rclBounds.Right;
              PMFPro.FClipRect.Bottom := rclBounds.Bottom;
            end;

            if (PMFPro.FClipRect.Left <> 0) or (PMFPro.FClipRect.Top <> 0) or
              ((PMFPro.FClipRect.Right - PMFPro.FClipRect.Left) <> 0) or
              ((PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top) <> 0) then
            begin
              if (PMFPro.FClipRect.Left <> LxDest) or
                (PMFPro.FClipRect.Top <> LyDest) then
                Settings.Center := True;
              if (LrclBounds.Left = PMFPro.FClipRect.Left) and
                (LrclBounds.Top = PMFPro.FClipRect.Top) then
              begin
                X := PMFPro.FClipRect.Left;
                Y := PMFPro.FClipRect.Top;
              end;

              Width := PMFPro.FClipRect.Right - PMFPro.FClipRect.Left;
              Height := PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top;
              if (cxSrc * cxDest) < 0 then
                Width := Width * -1;
              if (cySrc * cyDest) < 0 then
                Height := Height * -1;
            end
            else
              Settings.Stretch := True;
            X := X + PMFPro.FStartX;
            Y := Y + PMFPro.FStartY;
          end;

          LBitmapHeader.bfType := 19778;
          LBitmapHeader.bfSize := SizeOf(BITMAPFILEHEADER) + cbBmiSrc +
            cbBitsSrc;
          LBitmapHeader.bfOffBits := SizeOf(BITMAPFILEHEADER) + cbBmiSrc;
          LPBmiSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBmiSrc), offBmiSrc);
          Inc(PAnsiChar(LPBmiSrc), SizeOf(BITMAPINFOHEADER));
          LPBitSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBitSrc), offBitsSrc);

          with PMFPro.FImageItem do
          begin
            PMFPro.IsFirstRasterOpImage(gtRect(X, Y, (X + Width), (Y + Height)),
              ImageIndex);
            if ImageIndex = -1 then
              PMFPro.BitmapRasterOp(dwRop, IndexNo, LBitmapHeader,
                LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
            else
              PMFPro.BitmapRasterOp(dwRop, ImageIndex, LBitmapHeader,
                LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
          end;
        end;
      end; { - End EMR_STRETCHBLT - }

    EMR_STRETCHDIBITS:
      if PMFPro.FProcessText or PMFPro.FProcessImage or
        PMFPro.FProcessShape then
      begin
        (*
          Ternary raster operations

          SRCCOPY     = $00CC0020;     { dest = source                    }
          SRCPAINT    = $00EE0086;     { dest = source OR dest            }
          SRCAND      = $008800C6;     { dest = source AND dest           }
          SRCINVERT   = $00660046;     { dest = source XOR dest           }
          SRCERASE    = $00440328;     { dest = source AND (NOT dest )    }
          NOTSRCCOPY  = $00330008;     { dest = (NOT source)              }
          NOTSRCERASE = $001100A6;     { dest = (NOT src) AND (NOT dest)  }
          MERGECOPY   = $00C000CA;     { dest = (source AND pattern)      }
          MERGEPAINT  = $00BB0226;     { dest = (NOT source) OR dest      }
          PATCOPY     = $00F00021;     { dest = pattern                   }
          PATPAINT    = $00FB0A09;     { dest = DPSnoo                    }
          PATINVERT   = $005A0049;     { dest = pattern XOR dest          }
          DSTINVERT   = $00550009;     { dest = (NOT dest)                }
          BLACKNESS   = $00000042;     { dest = BLACK                     }
          WHITENESS   = $00FF0062;     { dest = WHITE                     }
        *)

        with EMRSTRETCHDIBITS(AEnhMetaRecord^) do
        begin
          LrclBounds := PMFPro.ApplyMMToRect(gtRect(rclBounds.Left,
            rclBounds.Top, rclBounds.Right, rclBounds.Bottom));
          if ((cbBmiSrc = 0) or (cbBitsSrc = 0)) then
          begin
            if PMFPro.FProcessText and (PMFPro.FPTextList.Count > 0) then
            begin
              with PMFPro.FStretchBltRect do
              begin
                Left := LrclBounds.Left;
                Top := LrclBounds.Top;
                Right := LrclBounds.Right;
                Bottom := LrclBounds.Bottom;
              end;
              if PMFPro.FJustProcessedTextItem > 0 then
                Dec(PMFPro.FJustProcessedTextItem);
              PMFPro.FJustProcessedStretchBltShape := True;
            end
            else if PMFPro.FProcessShape then
            begin
              with PMFPro.FStretchBltRect do
              begin
                Left := LrclBounds.Left;
                Top := LrclBounds.Top;
                Right := LrclBounds.Right;
                Bottom := LrclBounds.Bottom;
              end;
              PMFPro.FJustProcessedStretchBltShape := True;
            end;
            CheckUnderlinePattern;
            Result := 1;
            Exit;
          end;
          if not PMFPro.FProcessImage then
          begin
            Result := 1;
            Exit;
          end;
          LPointer := AEnhMetaRecord;
          Inc(PAnsiChar(LPointer), offBmiSrc);
          LBitmapInfoHeader := BITMAPINFO(LPointer^).bmiHeader;

          PMFPro.CreateImageItem(PMFPro.FImageItem);

          // For handling clipping in special cases like
          // -ve co-ordinates for cxdest and cydest......

          // if (PMFPro.FIsIntersectClipRect) then
          // begin
          // LBitmapHeader.bfType := 19778;
          // LBitmapHeader.bfSize := SizeOf(BITMAPFILEHEADER) + cbBmiSrc + cbBitsSrc;
          // LBitmapHeader.bfOffBits := SizeOf(BITMAPFILEHEADER) + cbBmiSrc;
          // LPBmiSrc := AEnhMetaRecord;
          // Inc(PAnsiChar(LPBmiSrc), offBmiSrc);
          // Inc(PAnsiChar(LPBmiSrc), SizeOf(BITMAPINFOHEADER));
          // LPBitSrc := AEnhMetaRecord;
          // Inc(PAnsiChar(LPBitSrc), offBitsSrc);
          // LBitmapStream := nil;
          // LBitmapStream := TMemoryStream.Create;
          // LBitmap := TBitmap.Create;
          // try
          // PMFPro.CreateBitmap(LBitmapStream, LBitmapHeader, LBitmapInfoHeader,
          // LPBmiSrc, LPBitSrc, (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc);
          // LBitmapStream.Position := 0;
          // LBitmap.LoadFromStream(LBitmapStream);
          // finally
          // FreeAndNil(LBitmapStream);
          // end;
          // LOpBitmap := TBitmap.Create;
          // LOpBitmap.Width := LBitmap.Width;
          // LOpBitmap.Height := LBitmap.Height;
          // IntersectClipRect(LOpBitmap.Canvas.Handle, Round(LrclBounds.Left),
          // Round(LrclBounds.Top), Round(LrclBounds.Right), Round(LrclBounds.Bottom));
          //
          // LXPoint := PMFPro.ApplyMMWithOrigin(xDest, yDest);
          // LxDest := LXPoint.X;
          // LyDest := LXPoint.Y;
          //
          // if (PMFPro.FStretchMode = STRETCH_HALFTONE) then
          // begin
          // // ToDo: Find the reason
          // LcxDest := cxDest;
          // LcyDest := cyDest;
          // end
          // else
          // begin
          // LXPoint := PMFPro.ApplyMMWithOrigin(cxDest, cyDest);
          // LcxDest := LXPoint.X;
          // LcyDest := LXPoint.Y;
          // end;
          // LOpBitmap.Canvas.StretchDraw(Rect(Round(LxDest),Round(LyDest),
          // Round(LcxDest + LxDest), Round(LcyDest + LyDest)), LBitmap);
          // LOpBitmap1 := TBitmap.Create;
          // LOpBitmap1.Width := Round(LrclBounds.Right - LrclBounds.Left);
          // LOpBitmap1.Height := Round(LrclBounds.Bottom - LrclBounds.Top);
          // LOpBitmap1.Canvas.CopyRect(Rect(0, 0, Round(LrclBounds.Right - LrclBounds.Left),
          // Round(LrclBounds.Bottom - LrclBounds.Top)), LOpBitmap.Canvas,
          // Rect(Round(LrclBounds.Left), Round(LrclBounds.Top),
          // Round(LrclBounds.Right), Round(LrclBounds.Bottom)));
          // PMFPro.FEngine.FImageResourceList.Items[PMFPro.FImageItem.IndexNo] :=
          // TBitmap.Create;
          // TPicture(PMFPro.FEngine.FImageResourceList.Items[
          // PMFPro.FImageItem.IndexNo]).Assign(LOpBitmap1);
          // PMFPro.FImageItem.X := LrclBounds.Left;
          // PMFPro.FImageItem.Y := LrclBounds.Top;
          // PMFPro.FImageItem.Width := LOpBitmap1.Width;
          // PMFPro.FImageItem.Height := LOpBitmap1.Height;
          // PMFPro.FEngine.CurrentDocumentItemList.Add(PMFPro.FImageItem);
          //
          // FreeAndNil(LOpBitmap);
          // FreeAndNil(LOpBitmap1);
          // FreeAndNil(LBitmap);
          // PMFPro.FIsIntersectClipRect := False;
          // end
          /// /--------- End of IF-------
          // else
          begin
            with PMFPro.FImageItem do
            begin
              LXPoint := PMFPro.ApplyMMWithOrigin(xDest, yDest);
              LxDest := LXPoint.X;
              LyDest := LXPoint.Y;
              SrcWidth := cxSrc;
              SrcHeight := cySrc;
              DestWidth := cxDest;
              DestHeight := cyDest;
              if (PMFPro.FStretchMode = STRETCH_HALFTONE) then
              begin
                // ToDo: Find the reason
                LcxDest := cxDest;
                LcyDest := cyDest;
              end
              else
              begin
                LXPoint := PMFPro.ApplyMMWithOrigin(cxDest, cyDest);
                LcxDest := LXPoint.X;
                LcyDest := LXPoint.Y;
              end;
              X := LxDest;
              Y := LyDest;
              Width := LcxDest;
              Height := LcyDest;

              DisplayRect := gtRect(X, Y, (X + Width), (Y + Height));
              begin
                PMFPro.FClipRect.Left := rclBounds.Left;
                PMFPro.FClipRect.Top := rclBounds.Top;
                PMFPro.FClipRect.Right := rclBounds.Right;
                PMFPro.FClipRect.Bottom := rclBounds.Bottom;
              end;
              if (PMFPro.FClipRect.Left <> 0) or (PMFPro.FClipRect.Top <> 0) or
                ((PMFPro.FClipRect.Right - PMFPro.FClipRect.Left) <> 0) or
                ((PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top) <> 0) then
              begin
                if (PMFPro.FClipRect.Left <> LxDest) or
                  (PMFPro.FClipRect.Top <> LyDest) then
                  Settings.Center := True;
                if (LrclBounds.Left = PMFPro.FClipRect.Left) and
                  (LrclBounds.Top = PMFPro.FClipRect.Top) then
                begin
                  X := PMFPro.FClipRect.Left;
                  Y := PMFPro.FClipRect.Top;
                end;

                if SrcWidth <> DestWidth then
                  Width := (PMFPro.FClipRect.Right - PMFPro.FClipRect.Left) *
                    (CPixelsPerInch / PMFPro.FEngine.InputXRes);
                if SrcHeight <> DestHeight then
                  Height := (PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top) *
                    (CPixelsPerInch / PMFPro.FEngine.InputXRes);

              end
              else
                Settings.Stretch := True;
              X := X + PMFPro.FStartX;
              Y := Y + PMFPro.FStartY;
            end;

            LBitmapHeader.bfType := 19778;
            LBitmapHeader.bfSize := SizeOf(BITMAPFILEHEADER) + cbBmiSrc +
              cbBitsSrc;
            LBitmapHeader.bfOffBits := SizeOf(BITMAPFILEHEADER) + cbBmiSrc;
            LPBmiSrc := AEnhMetaRecord;
            Inc(PAnsiChar(LPBmiSrc), offBmiSrc);
            Inc(PAnsiChar(LPBmiSrc), SizeOf(BITMAPINFOHEADER));
            LPBitSrc := AEnhMetaRecord;
            Inc(PAnsiChar(LPBitSrc), offBitsSrc);

            with PMFPro.FImageItem do
            begin
              PMFPro.IsFirstRasterOpImage(gtRect(X, Y, (X + Width), (Y + Height)
                ), ImageIndex);
              if ImageIndex = -1 then
                PMFPro.BitmapRasterOp(dwRop, IndexNo, LBitmapHeader,
                  LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                  (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
              else
                PMFPro.BitmapRasterOp(dwRop, ImageIndex, LBitmapHeader,
                  LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                  (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
            end;
          end;
        end;
      end; { - End EMR_STRETCHDIBITS - }

    EMR_SETDIBITSTODEVICE:
      begin
        with EMRSETDIBITSTODEVICE(AEnhMetaRecord^) do
        begin
          LrclBounds := PMFPro.ApplyMMToRect(gtRect(rclBounds.Left,
            rclBounds.Top, rclBounds.Right, rclBounds.Bottom));

          if ((cbBmiSrc = 0) or (cbBitsSrc = 0)) then
          begin
            if PMFPro.FProcessText and (PMFPro.FPTextList.Count > 0) then
            begin
              with PMFPro.FStretchBltRect do
              begin
                Left := LrclBounds.Left;
                Top := LrclBounds.Top;
                Right := LrclBounds.Right;
                Bottom := LrclBounds.Bottom;
              end;
              if PMFPro.FJustProcessedTextItem > 0 then
                Dec(PMFPro.FJustProcessedTextItem);
              PMFPro.FJustProcessedStretchBltShape := True;
            end
            else if PMFPro.FProcessShape then
            begin
              with PMFPro.FStretchBltRect do
              begin
                Left := LrclBounds.Left;
                Top := LrclBounds.Top;
                Right := LrclBounds.Right;
                Bottom := LrclBounds.Bottom;
              end;
              PMFPro.FJustProcessedStretchBltShape := True;
            end;
            CheckUnderlinePattern;
            Result := 1;
            Exit;
          end;
          if not PMFPro.FProcessImage then
          begin
            Result := 1;
            Exit;
          end;

          (*
            Create Bitmap on the first call of EMR_SETDIBITSTODEVICE.
          *)

          LPointer := AEnhMetaRecord;
          Inc(PAnsiChar(LPointer), offBmiSrc);
          LBitmapInfoHeader := BITMAPINFO(LPointer^).bmiHeader;
          if LBitmapInfoHeader.biHeight < 0 then
            LBitmapInfoHeader.biHeight := cySrc;

          LBitmapHeader.bfType := 19778;
          LBitmapHeader.bfSize := SizeOf(BITMAPFILEHEADER) + cbBmiSrc +
            cbBitsSrc;
          LBitmapHeader.bfOffBits := SizeOf(BITMAPFILEHEADER) + cbBmiSrc;

          LPBmiSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBmiSrc), offBmiSrc);
          Inc(PAnsiChar(LPBmiSrc), SizeOf(BITMAPINFOHEADER));
          LPBitSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBitSrc), offBitsSrc);

          if (iStartScan = 0) then
          begin
            PMFPro.CreateImageItem(PMFPro.FImageItem);
            PMFPro.FImageItem.X := LrclBounds.Left + PMFPro.FStartX;
            PMFPro.FImageItem.Y := LrclBounds.Top + PMFPro.FStartY;
            PMFPro.FImageItem.Width := (LrclBounds.Right - LrclBounds.Left);
            PMFPro.FImageItem.Height := (LrclBounds.Bottom - LrclBounds.Top);
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FImageItem);
          end;

          (*
            Call AddScanLineToBitmap so that the new scanlines can be added to
            the bitmap created previously. i.e., the last item in the image list.
          *)
          PMFPro.AddScanLineToBitmap(LBitmapHeader, LBitmapInfoHeader, LPBmiSrc,
            LPBitSrc, (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc);

          if (iStartScan <> 0) then
            with TgtImageItem(PMFPro.FEngine.CurrentDocumentItemList.Items
              [PMFPro.FEngine.CurrentDocumentItemList.Count - 1]) do
            begin
              Height := TBitmap(PMFPro.FEngine.FImageResourceList.Items
                [TgtImageItem(PMFPro.FEngine.CurrentDocumentItemList.Items
                [PMFPro.FEngine.CurrentDocumentItemList.Count - 1])
                .IndexNo]).Height;
            end;
        end;
      end; { - End EMR_SETDIBITSTODEVICE - }

    EMR_MASKBLT:
      if PMFPro.FProcessText or PMFPro.FProcessImage or
        PMFPro.FProcessShape then
      begin
        (*
          Ternary raster operations

          SRCCOPY     = $00CC0020;     { dest = source                    }
          SRCPAINT    = $00EE0086;     { dest = source OR dest            }
          SRCAND      = $008800C6;     { dest = source AND dest           }
          SRCINVERT   = $00660046;     { dest = source XOR dest           }
          SRCERASE    = $00440328;     { dest = source AND (NOT dest )    }
          NOTSRCCOPY  = $00330008;     { dest = (NOT source)              }
          NOTSRCERASE = $001100A6;     { dest = (NOT src) AND (NOT dest)  }
          MERGECOPY   = $00C000CA;     { dest = (source AND pattern)      }
          MERGEPAINT  = $00BB0226;     { dest = (NOT source) OR dest      }
          PATCOPY     = $00F00021;     { dest = pattern                   }
          PATPAINT    = $00FB0A09;     { dest = DPSnoo                    }
          PATINVERT   = $005A0049;     { dest = pattern XOR dest          }
          DSTINVERT   = $00550009;     { dest = (NOT dest)                }
          BLACKNESS   = $00000042;     { dest = BLACK                     }
          WHITENESS   = $00FF0062;     { dest = WHITE                     }
        *)

        with EMRMASKBLT(AEnhMetaRecord^) do
        begin
          LrclBounds := PMFPro.ApplyMMToRect(gtRect(rclBounds.Left,
            rclBounds.Top, rclBounds.Right, rclBounds.Bottom));

          if ((cbBmiSrc = 0) or (cbBitsSrc = 0)) then
          begin
            if PMFPro.FProcessText and (PMFPro.FPTextList.Count > 0) then
            begin

              with PMFPro.FStretchBltRect do
              begin
                Left := LrclBounds.Left;
                Top := LrclBounds.Top;
                Right := LrclBounds.Right;
                Bottom := LrclBounds.Bottom;
              end;
              if PMFPro.FJustProcessedTextItem > 0 then
                Dec(PMFPro.FJustProcessedTextItem);
              PMFPro.FJustProcessedStretchBltShape := True;
            end
            else if PMFPro.FProcessShape then
            begin
              with PMFPro.FStretchBltRect do
              begin
                Left := LrclBounds.Left;
                Top := LrclBounds.Top;
                Right := LrclBounds.Right;
                Bottom := LrclBounds.Bottom;
              end;
              PMFPro.FJustProcessedStretchBltShape := True;
            end;
            CheckUnderlinePattern;
            Result := 1;
            Exit;
          end;
          if not PMFPro.FProcessImage then
          begin
            Result := 1;
            Exit;
          end;
          LPointer := AEnhMetaRecord;
          Inc(PAnsiChar(LPointer), offBmiSrc);
          LBitmapInfoHeader := BITMAPINFO(LPointer^).bmiHeader;

          PMFPro.CreateImageItem(PMFPro.FImageItem);
          with PMFPro.FImageItem do
          begin

            LXPoint := PMFPro.ApplyMMWithOrigin(xDest, yDest);
            LxDest := LXPoint.X;
            LyDest := LXPoint.Y;

            LXPoint := PMFPro.ApplyMMWithOrigin(cxDest, cyDest);
            LcxDest := LXPoint.X;
            LcyDest := LXPoint.Y;

            X := LxDest;
            Y := LyDest;
            Width := LrclBounds.Right - LrclBounds.Left;
            Height := LrclBounds.Bottom - LrclBounds.Top;
            DisplayRect := gtRect(X, Y, (X + Width), (Y + Height));

            if PMFPro.FIsClipRect then
            begin
              PMFPro.FClipRect.Left := rclBounds.Left;
              PMFPro.FClipRect.Top := rclBounds.Top;
              PMFPro.FClipRect.Right := rclBounds.Right;
              PMFPro.FClipRect.Bottom := rclBounds.Bottom;
            end;

            if (PMFPro.FClipRect.Left <> 0) or (PMFPro.FClipRect.Top <> 0) or
              ((PMFPro.FClipRect.Right - PMFPro.FClipRect.Left) <> 0) or
              ((PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top) <> 0) then
            begin
              if (PMFPro.FClipRect.Left <> LxDest) or
                (PMFPro.FClipRect.Top <> LyDest) then
                Settings.Center := True;
              if (LrclBounds.Left = PMFPro.FClipRect.Left) and
                (LrclBounds.Top = PMFPro.FClipRect.Top) then
              begin
                X := PMFPro.FClipRect.Left;
                Y := PMFPro.FClipRect.Top;
              end;
              Width := (PMFPro.FClipRect.Right - PMFPro.FClipRect.Left);
              Height := (PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top);
              PMFPro.FClipRect.Left := 0;
              PMFPro.FClipRect.Top := 0;
              PMFPro.FClipRect.Right := 0;
              PMFPro.FClipRect.Bottom := 0;
            end
            else
            begin
              if (LcxDest <> Width) or (LcyDest <> Height) then
                Settings.Stretch := True;
              X := LrclBounds.Left;
              Y := LrclBounds.Top;
              Width := LrclBounds.Right - LrclBounds.Left;
              Height := LrclBounds.Bottom - LrclBounds.Top;
            end;
            X := X + PMFPro.FStartX;
            Y := Y + PMFPro.FStartY;
          end;

          LBitmapHeader.bfType := 19778;
          LBitmapHeader.bfSize := SizeOf(BITMAPFILEHEADER) + cbBmiSrc +
            cbBitsSrc;
          LBitmapHeader.bfOffBits := SizeOf(BITMAPFILEHEADER) + cbBmiSrc;
          LPBmiSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBmiSrc), offBmiSrc);
          Inc(PAnsiChar(LPBmiSrc), SizeOf(BITMAPINFOHEADER));
          LPBitSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBitSrc), offBitsSrc);

          with PMFPro.FImageItem do
          begin
            PMFPro.IsFirstRasterOpImage(gtRect(X, Y, (X + Width), (Y + Height)),
              ImageIndex);
            if ImageIndex = -1 then
              PMFPro.BitmapRasterOp(dwRop, IndexNo, LBitmapHeader,
                LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
            else
              PMFPro.BitmapRasterOp(dwRop, ImageIndex, LBitmapHeader,
                LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
          end;
        end;
      end; { - End EMR_MASKBLT - }

    EMR_BITBLT:
      begin
       with EMRBITBLT(AEnhMetaRecord^) do
        if PMFPro.FCurrentBrush.Color <> clWhite then
        begin
          if ((cbBmiSrc = 0) or (cbBitsSrc = 0)) then
          begin
            if PMFPro.FProcessShape then
            begin
              case dwRop of
                BLACKNESS, DSTINVERT, MERGECOPY, MERGEPAINT, NOTSRCCOPY,
                  NOTSRCERASE, PATCOPY, PATINVERT, PATPAINT, SRCAND, SRCCOPY,
                  SRCERASE, SRCINVERT, SRCPAINT, WHITENESS:
                  // , CAPTUREBLT, NOMIRRORBITMAP
                  begin
                    // Process only known records
                  end;
              else
                begin
                  // Unknown records ignored
                  Result := 1;
                  Exit;
                end;
              end;
              SetLength(LPoints, 2);

              LPoints[0] := PMFPro.ApplyMMWithOrigin(xDest, yDest);
              LPoints[1] := PMFPro.ApplyMMWithOrigin(xDest + cxDest,
                yDest + cyDest);

              PMFPro.CreateShapeItem(PMFPro.FShapeItem, stRectangle);
              // Brush-Color Depends On dwRop & some other color.
              (*
                MSDN: dwRop - Raster-operation code. These codes define how the color
                data of the source rectangle is to be combined with the color data of
                the destination rectangle to achieve the final color.
              *)
              PMFPro.FShapeItem.Brush := PMFPro.FCurrentBrush;
              PMFPro.FShapeItem.Pen := PMFPro.FCurrentPen;
              PMFPro.FShapeItem.Pen.Style := psClear;
              // ~~~~~~~~~~~~~~If FBKMode = TRANSPARENT then set the Brush color~~~~~~
              if ((PMFPro.FBKMode = TRANSPARENT) and
                (Assigned(PMFPro.FShapeItem.Brush.Bitmap))) then
              begin
                PMFPro.FShapeItem.Brush.Color := PMFPro.FTextColor;
              end;
              // ~~~~~~~~~~~~~end if~~~~~~~~~~~~~~~~~~~~

              with PMFPro.FShapeItem do
              begin
                NoPoints := 2;
                // Resolution already applied - don't apply again

                LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
                LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;

                LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
                LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;
                SetPoints(LPoints);
                PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
                // ~~~~~~~~~~~~~~~~~~~~If Brush has a Bitmap~~~~~~~~~~~~~~
                if Assigned(PMFPro.FShapeItem.Brush.Bitmap) then
                begin

                  PMFPro.CreateClipItem(PMFPro.FClipItem);
                  PMFPro.FClipItem.NoRects := 1;
                  PMFPro.FClipItem.Mode := RGN_AND;
                  PMFPro.FClipItem.SetRects(1);
                  PMFPro.FClipItem.FClipRects[0].Left := Round(LPoints[0].X);
                  PMFPro.FClipItem.FClipRects[0].Top := Round(LPoints[0].Y);
                  PMFPro.FClipItem.FClipRects[0].Right := Round(LPoints[1].X);
                  PMFPro.FClipItem.FClipRects[0].Bottom := Round(LPoints[1].Y);
                  PMFPro.FClipItem.Restore := False;
                  PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FClipItem);
                  LI := PMFPro.FEngine.FImageResourceList.add(nil);
                  PMFPro.FEngine.FImageResourceList.Items[LI] := TBitmap.Create;
                  TPicture(PMFPro.FEngine.FImageResourceList.Items[LI])
                    .Assign(PMFPro.FShapeItem.Brush.Bitmap);
                  LLeft := LPoints[0].X;
                  LTop := LPoints[0].Y;
                  LRight := LPoints[1].X;
                  LBottom := LPoints[1].Y;
                  while ((LRight > LLeft) and (LBottom > LTop)) do
                  begin
                    PMFPro.CreateImageItem(PMFPro.FImageItem);
                    PMFPro.FImageItem.Width :=
                      PMFPro.FShapeItem.Brush.Bitmap.Width;
                    PMFPro.FImageItem.Height :=
                      PMFPro.FShapeItem.Brush.Bitmap.Height;
                    if PMFPro.FBKMode = TRANSPARENT then
                    begin
                      PMFPro.FImageItem.Settings.TRANSPARENT := True;
                    end;
                    if (LRight - LLeft) >= PMFPro.FImageItem.Width then
                    begin
                      with PMFPro.FImageItem do
                      begin
                        IndexNo := LI;
                        Settings.Stretch := True;
                        X := LLeft;
                        Y := LTop;
                        DisplayRect := gtRect(X, Y, (X + Width), (Y + Height));
                        PMFPro.FEngine.CurrentDocumentItemList.add
                          (PMFPro.FImageItem);
                        LLeft := LLeft + Width;
                      end;
                    end
                    else if (LBottom - LTop) >= PMFPro.FImageItem.Height then
                    begin
                      with PMFPro.FImageItem do
                      begin
                        IndexNo := LI;
                        Settings.Stretch := True;
                        X := LLeft;
                        Y := LTop;
                        DisplayRect := gtRect(X, Y, (X + Width), (Y + Height));
                        PMFPro.FEngine.CurrentDocumentItemList.add
                          (PMFPro.FImageItem);
                        LTop := LTop + Height;
                      end;
                    end
                    else
                    begin
                      with PMFPro.FImageItem do
                      begin
                        IndexNo := LI;
                        Settings.Stretch := True;
                        X := LLeft;
                        Y := LTop;
                        DisplayRect := gtRect(X, Y, (X + Width), (Y + Height));
                        PMFPro.FEngine.CurrentDocumentItemList.add
                          (PMFPro.FImageItem);
                        LLeft := LLeft + Width;
                        LTop := LTop + Height;
                      end;
                    end;
                  end;
                  PMFPro.CreateClipItem(PMFPro.FClipItem);
                  PMFPro.FClipItem.Restore := True;
                  PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FClipItem);
                end;
                // ~~~~~~~~~~~~~~~~~~~~end If ~~~~~~~~~~~~~~~~~~~~~~~~~
              end;
            end;
            Result := 1;
            Exit;
          end;
          LPointer := AEnhMetaRecord;
          Inc(PAnsiChar(LPointer), offBmiSrc);
          LBitmapInfoHeader := BITMAPINFO(LPointer^).bmiHeader;

          PMFPro.CreateImageItem(PMFPro.FImageItem);
          with PMFPro.FImageItem do
          begin
            LrclBounds := PMFPro.ApplyMMToRect
              (gtRect(rclBounds.Left, rclBounds.Top, rclBounds.Right,
              rclBounds.Bottom));

            LXPoint := PMFPro.ApplyMMWithOrigin(xDest, yDest);
            LxDest := LXPoint.X;
            LyDest := LXPoint.Y;

            LXPoint := PMFPro.ApplyMMWithOrigin(cxDest, cyDest);
            LcxDest := LXPoint.X;
            LcyDest := LXPoint.Y;

            X := LxDest;
            Y := LyDest;
            Width := LrclBounds.Right - LrclBounds.Left;
            Height := LrclBounds.Bottom - LrclBounds.Top;
            DisplayRect := gtRect(X, Y, (X + Width), (Y + Height));

            if PMFPro.FIsClipRect then
            begin
              PMFPro.FClipRect.Left := rclBounds.Left;
              PMFPro.FClipRect.Top := rclBounds.Top;
              PMFPro.FClipRect.Right := rclBounds.Right;
              PMFPro.FClipRect.Bottom := rclBounds.Bottom;
            end;

            if (PMFPro.FClipRect.Left <> 0) or (PMFPro.FClipRect.Top <> 0) or
              ((PMFPro.FClipRect.Right - PMFPro.FClipRect.Left) <> 0) or
              ((PMFPro.FClipRect.Bottom - PMFPro.FClipRect.Top) <> 0) then
            begin
              if (PMFPro.FClipRect.Left <> LxDest) or
                (PMFPro.FClipRect.Top <> LyDest) then
                Settings.Center := True;
              if (LrclBounds.Left = PMFPro.FClipRect.Left) and
                (LrclBounds.Top = PMFPro.FClipRect.Top) then
              begin
                X := PMFPro.FClipRect.Left;
                Y := PMFPro.FClipRect.Top;
              end;

              PMFPro.FClipRect.Left := 0;
              PMFPro.FClipRect.Top := 0;
              PMFPro.FClipRect.Right := 0;
              PMFPro.FClipRect.Bottom := 0;
            end
            else
            begin
              if (LcxDest <> Width) or (LcyDest <> Height) then
                Settings.Stretch := True;

            end;
            X := X + PMFPro.FStartX;
            Y := Y + PMFPro.FStartY;
          end;

          LBitmapHeader.bfType := 19778;
          LBitmapHeader.bfSize := SizeOf(BITMAPFILEHEADER) + cbBmiSrc +
            cbBitsSrc;
          LBitmapHeader.bfOffBits := SizeOf(BITMAPFILEHEADER) + cbBmiSrc;

          LBitmapStream := TMemoryStream.Create;
          LPBmiSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBmiSrc), offBmiSrc);
          Inc(PAnsiChar(LPBmiSrc), SizeOf(BITMAPINFOHEADER));
          LPBitSrc := AEnhMetaRecord;
          Inc(PAnsiChar(LPBitSrc), offBitsSrc);
          try
            PMFPro.CreateBitmap(LBitmapStream, LBitmapHeader, LBitmapInfoHeader,
              LPBmiSrc, LPBitSrc, (cbBmiSrc - SizeOf(BITMAPINFOHEADER)),
              cbBitsSrc);
          finally
            with PMFPro.FImageItem do
            begin
              PMFPro.IsFirstRasterOpImage(gtRect(X, Y, (X + Width), (Y + Height)
                ), ImageIndex);
              if ImageIndex = -1 then
                PMFPro.BitmapRasterOp(dwRop, IndexNo, LBitmapHeader,
                  LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                  (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
              else
                PMFPro.BitmapRasterOp(dwRop, ImageIndex, LBitmapHeader,
                  LBitmapInfoHeader, LPBmiSrc, LPBitSrc,
                  (cbBmiSrc - SizeOf(BITMAPINFOHEADER)), cbBitsSrc)
            end;
          end;
        end;
      end; { - End EMR_BITBLT - }

    EMR_INTERSECTCLIPRECT:
      begin
        PMFPro.FIsClipRect := True;
        PMFPro.FIsIntersectClipRect := True;
        with EMRINTERSECTCLIPRECT(AEnhMetaRecord^) do
          PMFPro.FClipRect := PMFPro.ApplyMMToRect
            (gtRect(rclClip.Left, rclClip.Top, rclClip.Right, rclClip.Bottom));
      end; { - End EMR_INTERSECTCLIPRECT - }

    EMR_FILLRGN:
      begin
        {
          - This structure is not implemented completely
          You need to consider
          cbRgnData - size of the region data.
          RgnData - Region data structure (which contains No of rectangle and
          array of rectangles..
        }
        (*l_PFrameRgn := PEMRFrameRgn(AEnhMetaRecord);
        with l_PFrameRgn^ do
        begin
         if PMFPro.FProcessShape then
         begin
          if ihBrush > PMFPro.FGDIOBJList.Count then
           l_Brush := PMFPro.FGDIOBJ.FBrush
          else
           l_Brush := TgtGDIOBJ(PMFPro.FGDIOBJList.Items[ihBrush - 1]).FBrush;
          if l_Brush.Color <> clWhite then
          begin
            if PMFPro.FProcessShape then
              with EMRRECTANGLE(AEnhMetaRecord^) do
              begin
                PMFPro.CreateShapeItem(PMFPro.FShapeItem, stRectangleRgn);
                with PMFPro.FShapeItem do
                begin
                  NoPoints := 2;
                  SetLength(LPoints, 2);

                  LPoints[0] := gtPoint(rclBounds.Left, rclBounds.Top);
                  LPoints[1] := gtPoint(rclBounds.Right, rclBounds.Bottom);

                  LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
                  LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
                  LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
                  LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;
                  SetPoints(LPoints);
                  Pen.Style := psClear;
                  Pen.Width := 0;
                  Brush := l_Brush;
                end;
                PMFPro.FEngine.CurrentDocumentItemList.Insert(0, PMFPro.FShapeItem);
              end;*)               
           (*l_RGNData := PRgnData(@l_PFrameRgn^.RgnData[0]);
           if l_RGNData^.rdh.nCount > 0 then
           begin
            for i := 0 to l_RGNData^.rdh.nCount - 1 do
            begin
             PMFPro.CreateShapeItem(PMFPro.FShapeItem, stRectangle);
             with PMFPro.FShapeItem do
             begin
              Pen.Style := psClear;
              Pen.Width := 0;
              Brush := l_Brush;
              NoPoints := 2;
              SetLength(LPoints, 2);
              l_PointIndex := 0;
              with PRect(Integer(@l_RGNData^.Buffer) + i * SizeOf(TRect))^ do
              begin
               LPoints[l_PointIndex] := gtPoint(Left, Top);
               LPoints[l_PointIndex].X := LPoints[l_PointIndex].X + PMFPro.FStartX;
               LPoints[l_PointIndex].Y := LPoints[l_PointIndex].Y + PMFPro.FStartY;
               Inc(l_PointIndex);
               LPoints[l_PointIndex] := gtPoint(Right, Bottom);
               LPoints[l_PointIndex].X := LPoints[l_PointIndex].X + PMFPro.FStartX;
               LPoints[l_PointIndex].Y := LPoints[l_PointIndex].Y + PMFPro.FStartY;
               Inc(l_PointIndex);
              end; // with PRect(Integer(@l_RGNData^.Buffer) + i * SizeOf(TRect))^ do
              SetPoints(LPoints);
             end; // with PMFPro.FShapeItem do
             PMFPro.FEngine.CurrentDocumentItemList.Insert(0, PMFPro.FShapeItem);
            end; // for i := 0 to l_RGNData^.rdh.nCount - 1 do
           end; // if l_RGNData^.rdh.nCount > 0 then *)
           
        (*  end; // if l_Brush.Color <> clWhite then
         end; // if PMFPro.FProcessShape then
        end; *)     
      end;

    EMR_MOVETOEX:
      begin
        with EMRMOVETOEX(AEnhMetaRecord^) do
          PMFPro.FCurrentPathPoint := ptl;
        PMFPro.FUpdatePathX := 0;
      end; { - End EMR_MOVETOEX - }

    EMR_LINETO:
      begin
        if PMFPro.FProcessShape then
          with EMRLINETO(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stLine);
            with PMFPro.FShapeItem do
            begin
              NoPoints := 2;
              SetLength(LPoints, 2);

              LPoints[0] := PMFPro.ApplyMMWithOrigin(PMFPro.FCurrentPathPoint.X,
                PMFPro.FCurrentPathPoint.Y);

              LPoints[1] := PMFPro.ApplyMMWithOrigin(ptl.X, ptl.Y);

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;

              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;

              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
              PMFPro.FShapeItem.PenJoinStyle := PMFPro.FGDIOBJ.FPenJoinStyle;
              PMFPro.FShapeItem.PenCapStyle := PMFPro.FGDIOBJ.FPenCapStyle;
              PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);

              PMFPro.FCurrentPathPoint := ptl;
              PMFPro.FUpdatePathX := 0;

            end;
          end;
      end; { - End EMR_LINETO - }

    EMR_RECTANGLE:
      begin
        if PMFPro.FProcessShape then
          with EMRRECTANGLE(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stRectangle);
            with PMFPro.FShapeItem do
            begin
              NoPoints := 2;
              SetLength(LPoints, 2);

              LPoints[0] := PMFPro.ApplyMMWithOrigin(rclBox.Left, rclBox.Top);
              LPoints[1] := PMFPro.ApplyMMWithOrigin(rclBox.Right,
                rclBox.Bottom);

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;

              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              if (PMFPro.FROP2 = R2_NOP) then
                Pen.Color := PMFPro.FBKColor;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_RECTANGLE - }

    EMR_ROUNDRECT:
      begin
        if PMFPro.FProcessShape then
          with EMRROUNDRECT(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stRoundRect);
            with PMFPro.FShapeItem do
            begin
              NoPoints := 3;
              SetLength(LPoints, 3);

              LPoints[0] := PMFPro.ApplyMMWithOrigin(rclBox.Left, rclBox.Top);
              LPoints[1] := PMFPro.ApplyMMWithOrigin(rclBox.Right,
                rclBox.Bottom);

              LPoints[2].X := szlCorner.cx * PMFPro.FMapMXmul;
              LPoints[2].Y := szlCorner.cy * PMFPro.FMapMYmul;

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;

              SetPoints(LPoints);
              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_ROUNDRECT - }

    EMR_ARC:
      begin
        if PMFPro.FProcessShape then
          with EMRARC(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stArc);
            with PMFPro.FShapeItem do
            begin
              NoPoints := 4;
              SetLength(LPoints, 4);

              LPoints[0] := PMFPro.ApplyMMWithOrigin(rclBox.Left, rclBox.Top);
              LPoints[1] := PMFPro.ApplyMMWithOrigin(rclBox.Right,
                rclBox.Bottom);
              LPoints[2] := PMFPro.ApplyMMWithOrigin(ptlStart.X, ptlStart.Y);
              LPoints[3] := PMFPro.ApplyMMWithOrigin(ptlEnd.X, ptlEnd.Y);

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;
              LPoints[2].X := LPoints[2].X + PMFPro.FStartX;
              LPoints[2].Y := LPoints[2].Y + PMFPro.FStartY;
              LPoints[3].X := LPoints[3].X + PMFPro.FStartX;
              LPoints[3].Y := LPoints[3].Y + PMFPro.FStartY;

              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_ARC - }

    EMR_CHORD:
      begin
        if PMFPro.FProcessShape then
          with EMRCHORD(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stChord);
            with PMFPro.FShapeItem do
            begin
              NoPoints := 4;
              SetLength(LPoints, 4);
              LPoints[0] := PMFPro.ApplyMMWithOrigin(rclBox.Left, rclBox.Top);
              LPoints[1] := PMFPro.ApplyMMWithOrigin(rclBox.Right,
                rclBox.Bottom);
              LPoints[2] := PMFPro.ApplyMMWithOrigin(ptlStart.X, ptlStart.Y);
              LPoints[3] := PMFPro.ApplyMMWithOrigin(ptlEnd.X, ptlEnd.Y);

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;
              LPoints[2].X := LPoints[2].X + PMFPro.FStartX;
              LPoints[2].Y := LPoints[2].Y + PMFPro.FStartY;
              LPoints[3].X := LPoints[3].X + PMFPro.FStartX;
              LPoints[3].Y := LPoints[3].Y + PMFPro.FStartY;
              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_CHORD - }

    EMR_PIE:
      begin
        if PMFPro.FProcessShape then
          with EMRPIE(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPie);
            with PMFPro.FShapeItem do
            begin
              NoPoints := 4;
              SetLength(LPoints, 4);
              LPoints[0] := PMFPro.ApplyMMWithOrigin(rclBox.Left, rclBox.Top);
              LPoints[1] := PMFPro.ApplyMMWithOrigin(rclBox.Right,
                rclBox.Bottom);
              LPoints[2] := PMFPro.ApplyMMWithOrigin(ptlStart.X, ptlStart.Y);
              LPoints[3] := PMFPro.ApplyMMWithOrigin(ptlEnd.X, ptlEnd.Y);

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;
              LPoints[2].X := LPoints[2].X + PMFPro.FStartX;
              LPoints[2].Y := LPoints[2].Y + PMFPro.FStartY;
              LPoints[3].X := LPoints[3].X + PMFPro.FStartX;
              LPoints[3].Y := LPoints[3].Y + PMFPro.FStartY;
              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_PIE - }

    EMR_ELLIPSE:
      begin
        if PMFPro.FProcessShape then
          with EMRELLIPSE(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stEllipse);
            with PMFPro.FShapeItem do
            begin
              NoPoints := 2;
              SetLength(LPoints, 2);
              LPoints[0] := PMFPro.ApplyMMWithOrigin(rclBox.Left, rclBox.Top);
              LPoints[1] := PMFPro.ApplyMMWithOrigin(rclBox.Right,
                rclBox.Bottom);

              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
              LPoints[1].X := LPoints[1].X + PMFPro.FStartX;
              LPoints[1].Y := LPoints[1].Y + PMFPro.FStartY;

              SetPoints(LPoints);
              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_ELLIPSE - }

    EMR_POLYLINETO16:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYLINE16(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyLine);
            with PMFPro.FShapeItem do
            begin
              NoPoints := cpts + 1;
              SetLength(LPoints, cpts + 1);
              LPoints[0] := PMFPro.ApplyMMWithOrigin(PMFPro.FCurrentPathPoint.X,
                PMFPro.FCurrentPathPoint.Y);
              LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
              LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
              LPointer := @(apts[0]);
              for LI := 1 to cpts do
              begin
                LPoints[LI] := PMFPro.ApplyMMWithOrigin
                  (TSmallPoint(LPointer^).X, TSmallPoint(LPointer^).Y);
                LPoints[LI].X := LPoints[LI].X + PMFPro.FStartX;
                LPoints[LI].Y := LPoints[LI].Y + PMFPro.FStartY;
                Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
              end;
              SetPoints(LPoints);
              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
            PMFPro.FCurrentPathPoint := Point(apts[cpts - 1].X,
              apts[cpts - 1].Y);
            PMFPro.FUpdatePathX := 0;
          end;
      end; { - End EMR_POLYLINETO16- }

    EMR_POLYLINE16:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYLINE16(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyLine);
            with PMFPro.FShapeItem do
            begin
              NoPoints := cpts;
              SetLength(LPoints, cpts);
              LPointer := @(apts[0]);
              for LI := 1 to cpts do
              begin
                LPoints[LI - 1] := PMFPro.ApplyMMWithOrigin
                  (TSmallPoint(LPointer^).X, TSmallPoint(LPointer^).Y);
                LPoints[LI - 1].X := LPoints[LI - 1].X + PMFPro.FStartX;
                LPoints[LI - 1].Y := LPoints[LI - 1].Y + PMFPro.FStartY;
                Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
              end;
              SetPoints(LPoints);
              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_POLYLINE16 - }

    EMR_POLYLINETO:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYLINETO(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyLine);
            with PMFPro.FShapeItem do
            begin
              NoPoints := cptl;
              SetLength(LPoints, cptl);
              LPointer := @(aptl[0]);
              for LI := 1 to cptl do
              begin
                LPoints[LI - 1] := PMFPro.ApplyMMWithOrigin(TPoint(LPointer^).X,
                  TPoint(LPointer^).Y);

                LPoints[LI - 1].X := LPoints[LI - 1].X + PMFPro.FStartX;
                LPoints[LI - 1].Y := LPoints[LI - 1].Y + PMFPro.FStartY;

                Inc(PAnsiChar(LPointer), SizeOf(TPoint));
              end;
              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_POLYLINETO - }

    EMR_POLYGON16:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYGON16(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolygon);
            with PMFPro.FShapeItem do
            begin
              NoPoints := cpts;
              SetLength(LPoints, cpts);
              LPointer := @(apts[0]);
              for LI := 1 to cpts do
              begin
                LPoints[LI - 1] := PMFPro.ApplyMMWithOrigin
                  (TSmallPoint(LPointer^).X, TSmallPoint(LPointer^).Y);

                LPoints[LI - 1].X := LPoints[LI - 1].X + PMFPro.FStartX;
                LPoints[LI - 1].Y := LPoints[LI - 1].Y + PMFPro.FStartY;
                Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
              end;
              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_POLYGON16 - }

    EMR_POLYGON:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYGON(AEnhMetaRecord^) do
          begin
            PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolygon);
            with PMFPro.FShapeItem do
            begin
              {
                FShapeRect.Left := rclBounds.Left;
                FShapeRect.Top := rclBounds.Top;
                FShapeRect.Width := rclBounds.Right - rclBounds.Left;
                FShapeRect.Height := rclBounds.Bottom - rclBounds.Top;

                FX := FShapeRect.Left;
                FY := FShapeRect.Top;
              }
              NoPoints := cptl;
              SetLength(LPoints, cptl);
              LPointer := @(aptl[0]);
              for LI := 1 to cptl do
              begin
                LPoints[LI - 1] := PMFPro.ApplyMMWithOrigin(TPoint(LPointer^).X,
                  TPoint(LPointer^).Y);

                LPoints[LI - 1].X := LPoints[LI - 1].X + PMFPro.FStartX;
                LPoints[LI - 1].Y := LPoints[LI - 1].Y + PMFPro.FStartY;

                Inc(PAnsiChar(LPointer), SizeOf(TPoint));
              end;
              SetPoints(LPoints);

              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          end;
      end; { - End EMR_POLYGON - }

    EMR_POLYPOLYGON16:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYPOLYGON16(AEnhMetaRecord^) do
          begin
            PMFPro.CreatePolyPolygonItem(PMFPro.FPolyPolygonItem);
            with PMFPro.FPolyPolygonItem do
            begin
              NoPoly := nPolys;
              SetNoPoints();

              for LI := 0 to nPolys - 1 do
              begin
                FNoPoints[LI + 1] := aPolyCounts[LI];
              end;
              FNoPoints[0] := cpts;
              SetPoints();
              I := NoPoly - 1;
              for LI := 0 to FNoPoints[0] - 1 do
              begin
                FPoints[LI] := PMFPro.ApplyMMWithOrigin(TSmallPoint(apts[I]).X,
                  TSmallPoint(apts[I]).Y);
                FPoints[LI].X := FPoints[LI].X + PMFPro.FStartX;
                FPoints[LI].Y := FPoints[LI].Y + PMFPro.FStartY;
                I := I + 1;
              end;
              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
              FillAlternate := (PMFPro.FPolyFillMode = 1);
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPolyPolygonItem);
          end;
      end; { - End EMR_POLYPOLYGON16 - }

    EMR_POLYPOLYGON:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYPOLYGON(AEnhMetaRecord^) do
          begin
            PMFPro.CreatePolyPolygonItem(PMFPro.FPolyPolygonItem);
            with PMFPro.FPolyPolygonItem do
            begin
              NoPoly := nPolys;
              SetNoPoints();

              for LI := 0 to nPolys - 1 do
              begin
                FNoPoints[LI + 1] := aPolyCounts[LI];
              end;
              FNoPoints[0] := cptl;
              SetPoints();
              I := NoPoly - 1;
              for LI := 0 to FNoPoints[0] - 1 do
              begin
                FPoints[LI] := PMFPro.ApplyMMWithOrigin(TPoint(aptl[I]).X,
                  TPoint(aptl[I]).Y);
                FPoints[LI].X := FPoints[LI].X + PMFPro.FStartX;
                FPoints[LI].Y := FPoints[LI].Y + PMFPro.FStartY;
                I := I + 1;
              end;
              Pen := PMFPro.FCurrentPen;
              Brush := PMFPro.FCurrentBrush;
              FillAlternate := (PMFPro.FPolyFillMode = 1);
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPolyPolygonItem);
          end;
      end; { - End EMR_POLYPOLYGON - }

    EMR_POLYPOLYLINE16:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYPOLYLINE16(AEnhMetaRecord^) do
          begin
            LPointer := @(apts[0]);
            LPointer2 := @(aPolyCounts[0]);
            PMFPro.CreatePolyShapeItem(PMFPro.FPolyShapeItem);
            // Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
            for LJ := 1 to nPolys do
            begin
              PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyLine);
              with PMFPro.FShapeItem do
              begin
                SetLength(LPoints, (DWORD(LPointer2^)));
                for LI := 1 to (DWORD(LPointer2^)) do
                begin
                  // if (LI = 1) then Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
                  LPoints[LI - 1] := PMFPro.ApplyMMWithOrigin
                    (TSmallPoint(LPointer^).X, TSmallPoint(LPointer^).Y);
                  LPoints[LI - 1].X := LPoints[LI - 1].X + PMFPro.FStartX;
                  LPoints[LI - 1].Y := LPoints[LI - 1].Y + PMFPro.FStartY;
                  Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
                end;
                SetPoints(LPoints);
                Pen := PMFPro.FCurrentPen;
                Brush := PMFPro.FCurrentBrush;
                PMFPro.FPolyShapeItem.Shapes.add(PMFPro.FShapeItem);
              end;
              Inc(PAnsiChar(LPointer2), SizeOf(DWORD));
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPolyShapeItem);
          end;
      end; { - End EMR_POLYPOLYLINE16 - }

    EMR_POLYPOLYLINE:
      begin
        if PMFPro.FProcessShape then
          with EMRPOLYPOLYLINE(AEnhMetaRecord^) do
          begin
            LPointer := @(aptl[0]);
            LPointer2 := @(aPolyCounts[0]);
            PMFPro.CreatePolyShapeItem(PMFPro.FPolyShapeItem);
            for LJ := 1 to nPolys do
            begin
              PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyLine);
              with PMFPro.FShapeItem do
              begin
                SetLength(LPoints, (DWORD(LPointer2^) - 1));
                for LI := 1 to (DWORD(LPointer2^) - 1) do
                begin
                  if (LI = 1) then
                    Inc(PAnsiChar(LPointer), SizeOf(TPoint));
                  LPoints[LI - 1] := PMFPro.ApplyMMWithOrigin
                    (TPoint(LPointer^).X, TSmallPoint(LPointer^).Y);

                  LPoints[LI - 1].X := LPoints[LI - 1].X + PMFPro.FStartX;
                  LPoints[LI - 1].Y := LPoints[LI - 1].Y + PMFPro.FStartY;
                  Inc(PAnsiChar(LPointer), SizeOf(TPoint));
                end;
                SetPoints(LPoints);
                Pen := PMFPro.FCurrentPen;
                Brush := PMFPro.FCurrentBrush;
                PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
              end;
              Inc(PAnsiChar(LPointer2), SizeOf(DWORD));
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPolyShapeItem);
          end;
      end; { - End EMR_POLYPOLYLINE - }

    EMR_POLYBEZIER:
      begin
        with EMRPOLYBEZIER(AEnhMetaRecord^) do
        begin
          PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyBezier);
          with PMFPro.FShapeItem do
          begin
            NoPoints := cptl;
            SetLength(LPoints, cptl);
            LPointer := @(aptl[0]);
            for LI := 1 to cptl do
            begin
              LPoints[LI - 1].X := TPoint(LPointer^).X + PMFPro.FStartX;
              LPoints[LI - 1].Y := TPoint(LPointer^).Y + PMFPro.FStartY;
              Inc(PAnsiChar(LPointer), SizeOf(TPoint));
            end;
            SetPoints(LPoints);

            Pen := PMFPro.FCurrentPen;
            Brush := PMFPro.FCurrentBrush;
          end;
          PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
        end;
      end; { - End EMR_POLYBEZIER - }

    EMR_POLYBEZIERTO:
      begin
        with EMRPOLYBEZIERTO(AEnhMetaRecord^) do
        begin
          PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyBezier);
          with PMFPro.FShapeItem do
          begin
            NoPoints := cptl + 1;
            SetLength(LPoints, cptl + 1);
            LPoints[0] := PMFPro.ApplyMMWithOrigin(PMFPro.FCurrentPathPoint.X,
              PMFPro.FCurrentPathPoint.Y);
            LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
            LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;

            LPointer := @(aptl[0]);
            for LI := 1 to cptl do
            begin
              LPoints[LI] := PMFPro.ApplyMMWithOrigin(TPoint(LPointer^).X,
                TPoint(LPointer^).Y);
              LPoints[LI].X := LPoints[LI].X + PMFPro.FStartX;
              LPoints[LI].Y := LPoints[LI].Y + PMFPro.FStartY;
              Inc(PAnsiChar(LPointer), SizeOf(TPoint));
            end;
            SetPoints(LPoints);

            Pen := PMFPro.FCurrentPen;
            Brush := PMFPro.FCurrentBrush;
          end;
          PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          PMFPro.FCurrentPathPoint := Point(aptl[cptl - 1].X, aptl[cptl - 1].Y);
          PMFPro.FUpdatePathX := 0;
        end;
      end; { - End EMR_POLYBEZIERTO - }

    EMR_POLYBEZIER16:
      begin
        with EMRPOLYBEZIER16(AEnhMetaRecord^) do
        begin
          PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyBezier);
          with PMFPro.FShapeItem do
          begin
            NoPoints := cpts;
            SetLength(LPoints, cpts);
            LPointer := @(apts[0]);
            for LI := 1 to cpts do
            begin
              LPoints[LI - 1] := PMFPro.ApplyMMWithOrigin
                (TSmallPoint(LPointer^).X, TSmallPoint(LPointer^).Y);
              LPoints[LI - 1].X := LPoints[LI - 1].X + PMFPro.FStartX;
              LPoints[LI - 1].Y := LPoints[LI - 1].Y + PMFPro.FStartY;
              Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
            end;
            SetPoints(LPoints);

            Pen := PMFPro.FCurrentPen;
            Brush := PMFPro.FCurrentBrush;
          end;
          PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
        end;
      end; { - End EMR_POLYBEZIER16 - }

    EMR_POLYBEZIERTO16:
      begin
        with EMRPOLYBEZIERTO16(AEnhMetaRecord^) do
        begin
          PMFPro.CreateShapeItem(PMFPro.FShapeItem, stPolyBezier);
          with PMFPro.FShapeItem do
          begin
            NoPoints := cpts + 1;
            SetLength(LPoints, cpts + 1);
            LPoints[0] := PMFPro.ApplyMMWithOrigin(PMFPro.FCurrentPathPoint.X,
              PMFPro.FCurrentPathPoint.Y);
            LPoints[0].X := LPoints[0].X + PMFPro.FStartX;
            LPoints[0].Y := LPoints[0].Y + PMFPro.FStartY;
            LPointer := @(apts[0]);
            for LI := 1 to cpts do
            begin
              LPoints[LI] := PMFPro.ApplyMMWithOrigin(TSmallPoint(LPointer^).X,
                TSmallPoint(LPointer^).Y);
              LPoints[LI].X := LPoints[LI].X + PMFPro.FStartX;
              LPoints[LI].Y := LPoints[LI].Y + PMFPro.FStartY;
              Inc(PAnsiChar(LPointer), SizeOf(TSmallPoint));
            end;
            SetPoints(LPoints);

            Pen := PMFPro.FCurrentPen;
            Brush := PMFPro.FCurrentBrush;
          end;
          PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FShapeItem);
          PMFPro.FCurrentPathPoint := Point(apts[cpts - 1].X, apts[cpts - 1].Y);
          PMFPro.FUpdatePathX := 0;
        end;
      end; { - End EMR_POLYBEZIERTO16 - }

    EMR_POLYDRAW16:
      begin
        with EMRPOLYDRAW16(AEnhMetaRecord^) do
        begin
          if cpts > 0 then
          begin
            PMFPro.CreatePolyDrawItem(PMFPro.FPolyDrawItem);
            with PMFPro.FPolyDrawItem do
            begin
              FNoPoints := cpts;
              SetPoints;
              for LI := 0 to FNoPoints - 1 do
              begin
                FPoints[LI] := PMFPro.ApplyMMWithOrigin(TSmallPoint(apts[LI]).X,
                  TSmallPoint(apts[LI]).Y);
              end;

              LPointer := AEnhMetaRecord;
              LI := SizeOf(TEMR) + SizeOf(TRect) +
                (cpts * SizeOf(TSmallPoint)) + 4;
              Inc(PAnsiChar(LPointer), LI);

              for LI := 0 to FNoPoints - 1 do
              begin
                FOperations[LI] := Byte(LPointer^);
                Inc(PByte(LPointer));
              end;
            end;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPolyDrawItem);
          end;
        end;
      end; { - End EMR_POLYDRAW16 - }
    (*
      EMR_GDICOMMENT:
      begin
      with EMRGDICOMMENT(AEnhMetaRecord^) do
      begin
      LPAnsiChar := AEnhMetaRecord;
      Inc(LPAnsiChar, (SizeOf(emr) + SizeOf(DWORD)));
      LI := 1;
      PMFPro.FGdiComment := '';
      while (Cardinal(LI) <= cbData) do
      begin
      if not IsCharAlphaNumericA(LPAnsiChar^) then
      Break;
      PMFPro.FGdiComment := PMFPro.FGdiComment +
      LPAnsiChar^;
      Inc(LI);
      Inc(LPAnsiChar, SizeOf(Byte));
      end;
      end;
      end; {- End EMR_GDICOMMENT -}
    *)
    EMR_SAVEDC:
      begin
        PMFPro.SaveMetaState;
      end; { - End EMR_SAVEDC - }

    EMR_RESTOREDC:
      begin
        with EMRRESTOREDC(AEnhMetaRecord^) do
        begin
          PMFPro.RestoreMetaState(iRelative);
          PMFPro.FClipRect := gtRect(0, 0, 0, 0);
          PMFPro.CreateClipItem(PMFPro.FClipItem);
          PMFPro.FClipItem.Restore := True;
          PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FClipItem);
        end;
      end; { - End EMR_RESTOREDC - }

    EMR_EXTCREATEPEN:
      begin

        with EMREXTCREATEPEN(AEnhMetaRecord^) do
        begin
          PMFPro.CreateGDIRec(PMFPro.FGDIOBJ, goPen);
          with PMFPro.FGDIOBJ.FPen do
          begin
            if elp.elpWidth < 1 then
              elp.elpWidth := 1;
            Width := Round(PMFPro.ApplyMMToPenWidth(elp.elpWidth));
            if Width < 1 then
              Width := 1;
            case (elp.elpPenStyle and PS_STYLE_MASK) of
              PS_SOLID:
                Style := psSolid;
              PS_DASH:
                Style := psDash;
              PS_DOT:
                Style := psDot;
              PS_DASHDOT:
                Style := psDashDot;
              PS_DASHDOTDOT:
                Style := psDashDotDot;
              PS_NULL:
                Style := psClear;
              PS_INSIDEFRAME:
                Style := psInsideFrame;
            end; { - End Case lopn.lopnStyle - }
            Color := PMFPro.GetColorValue(elp.elpColor);
          end;
          with PMFPro.FGDIOBJ do
          begin
            if (elp.elpPenStyle and PS_TYPE_MASK) = PS_GEOMETRIC then
            begin
              case (elp.elpPenStyle and PS_JOIN_MASK) of
                PS_JOIN_ROUND:
                  FPenJoinStyle := pjsRound;
                PS_JOIN_BEVEL:
                  FPenJoinStyle := pjsBevel;
                PS_JOIN_MITER:
                  FPenJoinStyle := pjsMiter;
              end;
              case (elp.elpPenStyle and PS_ENDCAP_MASK) of
                PS_ENDCAP_ROUND:
                  FPenCapStyle := pcsRound;
                PS_ENDCAP_SQUARE:
                  FPenCapStyle := pcsSquare;
                PS_ENDCAP_FLAT:
                  FPenCapStyle := pcsFlat;
              end;
            end
            else
            begin
              FPenJoinStyle := pjsNone;
              FPenCapStyle := pcsNone;
            end;
          end;
          if (PMFPro.FGDIOBJList.Count < Round(ihPen)) then
            PMFPro.FGDIOBJList.add(PMFPro.FGDIOBJ)
          else
          begin
            TgtGDIOBJ(PMFPro.FGDIOBJList[ihPen - 1]).Free;
            PMFPro.FGDIOBJList.Delete(ihPen - 1);
            PMFPro.FGDIOBJList.Insert(ihPen - 1, PMFPro.FGDIOBJ);
          end;
        end;
      end; { - End EMR_EXTCREATEPEN - }

    EMR_EXTSELECTCLIPRGN:
      begin
        (*with EMREXTSELECTCLIPRGN(AEnhMetaRecord^) do
        begin
          if (cbRgnData = 0) then
          begin
            PMFPro.FClipRect := gtRect(0, 0, 0, 0);
            PMFPro.CreateClipItem(PMFPro.FClipItem);
            PMFPro.FClipItem.Restore := True;
            PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FClipItem);
          end
          else
          begin
            for I := 0 to 3 do
              Rgn.rdh.nCount := Rgn.rdh.nCount or (RGNDATA[I + 8] shl (8 * I));
            if Rgn.rdh.nCount = 1 then
            begin
              PMFPro.FIsClipRect := True;
              PMFPro.CreateClipItem(PMFPro.FClipItem);
              PMFPro.FClipItem.SetRects(Rgn.rdh.nCount);
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Left := Rgn.rdh.rcBound.Left or
                  (RGNDATA[I + 16] shl (8 * I));
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Top := Rgn.rdh.rcBound.Top or
                  (RGNDATA[I + 20] shl (8 * I));
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Right := Rgn.rdh.rcBound.Right or
                  (RGNDATA[I + 24] shl (8 * I));
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Bottom := Rgn.rdh.rcBound.Bottom or
                  (RGNDATA[I + 28] shl (8 * I));
              LeftTop := gtPoint(Rgn.rdh.rcBound.Left + PMFPro.FStartX,
                Rgn.rdh.rcBound.Top + PMFPro.FStartY);
              BottomRight := gtPoint(Rgn.rdh.rcBound.Right + PMFPro.FStartX,
                Rgn.rdh.rcBound.Bottom + PMFPro.FStartY);

              PMFPro.FClipItem.FClipRects[0] :=
                Rect(Round(LeftTop.X), Round(LeftTop.Y), Round(BottomRight.X),
                Round(BottomRight.Y));
              PMFPro.FClipItem.Restore := False;
              PMFPro.FClipItem.Mode := iMode;
              PMFPro.FClipItem.Pen := PMFPro.FCurrentPen;
              PMFPro.FClipItem.Brush := PMFPro.FCurrentBrush;
              PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FClipItem);
            end;
            if Rgn.rdh.nCount > 1 then
            begin
              PMFPro.CreateClipItem(PMFPro.FClipItem);
              PMFPro.FClipItem.SetRects(Rgn.rdh.nCount);
              for M := 1 to Rgn.rdh.nCount - 1 do
              begin
                for J := 0 to 3 do
                begin
                  TempVar := 0;
                  for I := 0 to 3 do
                    TempVar := TempVar or
                      (RGNDATA[I + 32 + (4 * J) + (M * 16)] shl (8 * I));
                  TempArray[J + 1] := TempVar;
                end;
                LeftTop := gtPoint(TempArray[1] + PMFPro.FStartX,
                  TempArray[2] + PMFPro.FStartY);
                BottomRight := gtPoint(TempArray[3] + PMFPro.FStartX,
                  TempArray[4] + PMFPro.FStartY);
                PMFPro.FClipItem.FClipRects[M] :=
                  Rect(Round(LeftTop.X), Round(LeftTop.Y), Round(BottomRight.X),
                  Round(BottomRight.Y));
              end;
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Left := Rgn.rdh.rcBound.Left or
                  (RGNDATA[I + 16] shl (8 * I));
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Top := Rgn.rdh.rcBound.Top or
                  (RGNDATA[I + 20] shl (8 * I));
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Right := Rgn.rdh.rcBound.Right or
                  (RGNDATA[I + 24] shl (8 * I));
              for I := 0 to 3 do
                Rgn.rdh.rcBound.Bottom := Rgn.rdh.rcBound.Bottom or
                  (RGNDATA[I + 28] shl (8 * I));
              LeftTop := gtPoint(Rgn.rdh.rcBound.Left + PMFPro.FStartX,
                Rgn.rdh.rcBound.Top + PMFPro.FStartY);
              BottomRight := gtPoint(Rgn.rdh.rcBound.Right + PMFPro.FStartX,
                Rgn.rdh.rcBound.Bottom + PMFPro.FStartY);

              PMFPro.FClipItem.FClipRects[0] :=
                Rect(Round(LeftTop.X), Round(LeftTop.Y), Round(BottomRight.X),
                Round(BottomRight.Y));
              PMFPro.FClipItem.Restore := False;
              PMFPro.FClipItem.Mode := iMode;
              PMFPro.FClipItem.Pen := PMFPro.FCurrentPen;
              PMFPro.FClipItem.Brush := PMFPro.FCurrentBrush;
              PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FClipItem);
            end;
          end;
        end;*)
      end; { - End EMR_EXTSELECTCLIPRGN - }

    EMR_EOF:
      begin
        PMFPro.CreateEOFItem(PMFPro.FEOFItem);
        PMFPro.FEOFItem.Status := True;
        PMFPro.FIsClipRect := False;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FEOFItem);
      end;
    EMR_CLOSEFIGURE:
      begin
        PMFPro.CreatePathItem(PMFPro.FPathItem);
        PMFPro.FPathItem.PathOperation := poCloseFigure;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
      end; { - End EMR_CLOSEFIGURE - }

    EMR_BEGINPATH:
      begin
        PMFPro.CreatePathItem(PMFPro.FPathItem);
        PMFPro.FPathItem.PathOperation := poBeginPath;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
      end; { - End EMR_BEGINPATH - }

    EMR_ENDPATH:
      begin
        PMFPro.CreatePathItem(PMFPro.FPathItem);
        PMFPro.FPathItem.PathOperation := poEndPath;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
      end; { - End EMR_ENDPATH - }

    EMR_ABORTPATH:
      begin
        PMFPro.CreatePathItem(PMFPro.FPathItem);
        PMFPro.FPathItem.PathOperation := poAbortPath;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
      end; { - End EMR_ABORTPATH - }

    EMR_FILLPATH:
      begin
        PMFPro.CreatePathItem(PMFPro.FPathItem);
        PMFPro.FPathItem.PathOperation := poFillPath;
        PMFPro.FPathItem.FillAlternate := (PMFPro.FPolyFillMode = 1);
        PMFPro.FPathItem.Pen := PMFPro.FCurrentPen;
        PMFPro.FPathItem.Brush := PMFPro.FCurrentBrush;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
      end; { - End EMR_FILLPATH - }

    EMR_FLATTENPATH:
      begin
      end; { - End EMR_FLATTENPATH - }

    EMR_SELECTCLIPPATH:
      begin
        with EMRSELECTCLIPPATH(AEnhMetaRecord^) do
        begin
          PMFPro.CreatePathItem(PMFPro.FPathItem);
          PMFPro.FPathItem.PathOperation := poSelectClipPath;
          PMFPro.FPathItem.Mode := iMode;
          PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
        end;
      end; { - End EMR_SELECTCLIPPATH - }

    EMR_STROKEANDFILLPATH:
      begin
        PMFPro.CreatePathItem(PMFPro.FPathItem);
        PMFPro.FPathItem.PathOperation := poStrokeAndFillPath;
        PMFPro.FPathItem.FillAlternate := (PMFPro.FPolyFillMode = 1);
        PMFPro.FPathItem.Pen := PMFPro.FCurrentPen;
        PMFPro.FPathItem.Brush := PMFPro.FCurrentBrush;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
      end; { - End EMR_STROKEANDFILLPATH - }

    EMR_STROKEPATH:
      begin
        PMFPro.CreatePathItem(PMFPro.FPathItem);
        PMFPro.FPathItem.PathOperation := poStrokePath;
        PMFPro.FPathItem.Pen := PMFPro.FCurrentPen;
        PMFPro.FPathItem.Brush := PMFPro.FCurrentBrush;
        PMFPro.FEngine.CurrentDocumentItemList.add(PMFPro.FPathItem);
      end; { - End EMR_STROKEPATH - }

    EMR_WIDENPATH:
      begin
      end; { - End EMR_WIDENPATH - }

    (*
      // Unhandled Records
      EMR_SETTEXTJUSTIFICATION:
      begin
      // Invalid Record
      end; {- End EMR_SETTEXTJUSTIFICATION -}

      EMR_EOF:
      begin
      end;

      EMR_SETMETARGN:
      begin
      end; {- End EMR_SETMETARGN -}

      EMR_SETBRUSHORGEX:
      begin
      end; {- End EMR_SETBRUSHORGEX -}

      EMR_REALIZEPALETTE:
      begin
      end; {- End EMR_REALIZEPALETTE -}

      EMR_CLOSEFIGURE:
      begin
      end; {- End EMR_CLOSEFIGURE -}

      EMR_FILLPATH, EMR_STROKEPATH, EMR_STROKEANDFILLPATH:
      begin
      with EMRFILLPATH(AEnhMetaRecord^) do
      begin
      if (PMFPro.FJustCompletedPath > 0) and
      (TgtDocumentItem(PMFPro.FEngine.CurrentDocumentItemList.Items[
      PMFPro.FEngine.CurrentDocumentItemList.Count - 1]) is
      TgtShapeItem) then
      with TgtShapeItem(PMFPro.FEngine.CurrentDocumentItemList.Items[
      PMFPro.FEngine.CurrentDocumentItemList.Count - 1]) do
      begin
      {
      if (FShapeRect.Left <= rclBounds.Left) and
      (FShapeRect.Top <= rclBounds.Top) and
      (FShapeRect.Width >= (rclBounds.Right - rclBounds.Left)) and
      (FShapeRect.Height >= (rclBounds.Bottom - rclBounds.Top)) then
      FStrokeAndFillPath := True;
      }
      end;
      end;
      end; {- End EMR_FILLPATH, EMR_STROKEPATH, EMR_STROKEANDFILLPATH -}

      EMR_ALPHADIBBLEND:
      begin
      end; {- End EMR_ALPHADIBBLEND -}
    *)
  else
  end; (* End Case EMR(AEnhMetaRecord^).iType *)

  Result := 1;
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.Execute(AMetafile: TMetafile;
  AStartX, AStartY: Double);

var
  LRect: TRect;
  (* Pointer to CallBack function *)
  LEnhMetaFileProc: TFNEnhMFEnumProc;
  LMetafile: TMetafile;
  LMCanvas: TMetafileCanvas;
begin
  with LRect do
  begin
    Left := 0;
    Top := 0;
    Right := 0;
    Bottom := 0;
  end;
  FStartX := AStartX;
  FStartY := AStartY;
  FWidth := AMetafile.Width;
  FHeight := AMetafile.Height;
  LEnhMetaFileProc := @EnhMetaFileProc;

  if not AMetafile.Enhanced then
  begin
    LMetafile := TMetafile.Create;
    LMetafile.Enhanced := True;
    LMetafile.Width := AMetafile.Width;
    LMetafile.Height := AMetafile.Height;
    LMCanvas := TMetafileCanvas.Create(LMetafile, 0);
    LMCanvas.Draw(0, 0, AMetafile);
    LMCanvas.Free;
    EnumEnhMetaFile(0, LMetafile.Handle, LEnhMetaFileProc, @Self, LRect);
    LMetafile.Free;
  end
  else
    EnumEnhMetaFile(0, AMetafile.Handle, LEnhMetaFileProc, @Self, LRect);
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.Execute(AMetafileHandle: HENHMETAFILE;
  AStartX, AStartY: Double);

var
  LRect: TRect;
  (* Pointer to CallBack function *)
  LEnhMetaFileProc: TFNEnhMFEnumProc;
begin
  with LRect do
  begin
    Left := 0;
    Top := 0;
    Right := 0;
    Bottom := 0;
  end;
  FStartX := AStartX;
  FStartY := AStartY;

  LEnhMetaFileProc := @EnhMetaFileProc;
  EnumEnhMetaFile(0, AMetafileHandle, LEnhMetaFileProc, @Self, LRect);
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.FillFontMetrics(AFont: TFont;
  AFontInfo: TgtFontInfo);

var
  Font: TFont;
  DC: HDC;
  SaveFont: HFont;
  TM: TTextMetric;
  OTM: TOutlineTextmetric;
  SaveMM: Integer;

function GetFontFlags: Integer;
begin
  with TM do
  begin
    Result :=
    // If bit TMPF_FIXED_PITCH is set the font is NOT fixed-pitch,
    // the values are reversed. Refer Win API help on
    // TextMetric for details.
      CFontFixedPitch[(tmPitchAndFamily and TMPF_FIXED_PITCH) = 0] +
      CFontSerif[(tmPitchAndFamily and FF_ROMAN) <> 0] + CFontSymbolic
      [tmCharSet = SYMBOL_CHARSET] + CFontScript
      [(tmPitchAndFamily and FF_SCRIPT) <> 0] + CFontNonSymbolic
      [tmCharSet <> SYMBOL_CHARSET] + CFontItalic[tmItalic <> 0];
  end;
end;

procedure InitFontInfo;
begin
  with AFontInfo do
  begin
    FfiFlags := 0;
    FfiAscent := 800;
    FfiDescent := -200;
    FfiCapHeight := 700;
    FfiStrikeoutSize := Font.Size / 20.0;
    FfiStrikeoutPosition := Abs(Font.Height) / 5.0;
    FfiUnderscoreSize := Font.Size / 10.0;
    FfiUnderscorePosition := -1;
  end;
end;

begin
  Font := TFont.Create;
  with AFontInfo do
    try
      with Font do
      begin
        Charset := AFont.Charset;
        Name := AFont.Name;
        Size := AFont.Size;
        Pitch := AFont.Pitch;
        Style := AFont.Style;
      end;
      InitFontInfo;
      DC := GetDC(0);
      SaveMM := GetMapMode(DC);
      SetMapMode(DC, FMapMode);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, TM);
      with TM do
      begin
        FfiFlags := GetFontFlags;
        FfiAscent := (tmAscent / CPixelsPerInch) * CInchesToPoints;
        FfiDescent := -(Abs(tmDescent) / CPixelsPerInch) * CInchesToPoints;
        FfiCapHeight := (tmAscent / CPixelsPerInch) * CInchesToPoints;
        if (tmPitchAndFamily and TMPF_TRUETYPE) <> 0 then
        begin
          GetOutlineTextMetrics(DC, SizeOf(OTM), @OTM);
          with OTM do
          begin
            // Required in degrees but function returns in tenths of a degree.
            FfiStrikeoutSize :=
              (((otmsStrikeoutSize / CPixelsPerInch) * CInchesToPoints) *
              AFont.Size / 1000);
            FfiStrikeoutPosition :=
              (((otmsStrikeoutPosition / CPixelsPerInch) * CInchesToPoints) *
              AFont.Size / 1000);
            FfiUnderscoreSize :=
              (((otmsUnderscoreSize / CPixelsPerInch) * CInchesToPoints) *
              AFont.Size / 1000);
            FfiUnderscorePosition :=
              (((otmsUnderscorePosition / CPixelsPerInch) * CInchesToPoints) *
              AFont.Size / 1000) - 1;
          end;
        end;
        SetMapMode(DC, SaveMM);
        SelectObject(DC, SaveFont);
        ReleaseDC(0, DC);
      end;
    finally
      Font.Free;
    end;
end;

function TgtMetafileProcessor.GetSizeFromHeight(AHeight: Extended): Extended;

var
  LHDC: HDC;
begin
  LHDC := GetDC(0);
  Result := (Round(((-1 * AHeight) * 72) / GetDeviceCaps(LHDC, LOGPIXELSY)));

  ReleaseDC(0, LHDC);
end;

{ ------------------------------------------------------------------------------

  procedure TgtMetafileProcessor.GetInterCharSpacing(
  const AEnhMetaRecord: Pointer; var AInterCharSpacing: array of Integer);
  var
  LPAnsiChar: PAnsiChar;
  LI: Integer;
  begin
  with EMREXTTEXTOUTA(AEnhMetaRecord^) do
  begin
  LPAnsiChar := AEnhMetaRecord;
  Inc(LPAnsiChar, emrtext.offDx);
  LI := 1;
  while (Cardinal(LI) <= emrtext.nChars) do
  begin
  AInterCharSpacing[LI - 1] := Integer(LPAnsiChar^);
  (*
  If the text is full justified, then widths of Space character ' '
  will be greater than the actual text width of the same.

  Hence if in input text, if the intercharacter spacing for Space
  is greater, indicate that as Full Justified text.
  *)
  (*
  Commented out text Full Justification determination as it is not
  accurate.
  if (FInterCharSpace[LI - 1] > GetTextWidth(LText[LI],
  TFont(PEMFProcessor.FFontList.Objects[PEMFProcessor.FCurrentSelectedFont]))) then
  FTextAlign := taJustify;
  *)

  Inc(LI);
  Inc(LPAnsiChar, SizeOf(DWORD));
  end;
  end;
  end;

  ------------------------------------------------------------------------------- }

function TgtMetafileProcessor.IsTextUnderlinedStrikedout(AFont: TFont;
  AMapMode: Cardinal; AStretchBlt: TgtRect; ATextReferenceY: Extended)
  : TFontStyles;

var
  LPixelToPoint: Extended;
  LFontInfo: TgtFontInfo;

function IsStrikeOut: Boolean;

var
  LFontRectangle: Extended;
begin
  Result := False;
  LFontRectangle := ATextReferenceY + AFont.Size;
  if ((LFontRectangle > AStretchBlt.Top) and ((LFontRectangle - AStretchBlt.Top)
    > 0) and ((LFontRectangle - AStretchBlt.Top) < 4)) then
    Result := True;
end;
begin
  Result := [];
  if AMapMode = MM_TEXT then
  begin
    LFontInfo := TgtFontInfo.Create;
    try
      FillFontMetrics(AFont, LFontInfo);
      if (AStretchBlt.Top >= (ATextReferenceY +
        Abs(LFontInfo.FfiUnderscorePosition))) and
        (AStretchBlt.Top <= (ATextReferenceY +
        Abs(LFontInfo.FfiUnderscorePosition) +
        LFontInfo.FfiUnderscoreSize)) then
        Result := [fsUnderline]
      else if ((AStretchBlt.Bottom <= (ATextReferenceY -
        LFontInfo.FfiStrikeoutPosition)) and
        (AStretchBlt.Bottom >= (ATextReferenceY - AFont.Size))) then
        Result := [fsStrikeOut]
    finally
      LFontInfo.Free;
    end;
  end
  else
  begin
    (*
      This is a very crude method of checking for Underline/Strikeout.
      Needs a change soon.
    *)
    LPixelToPoint := PixelsToPoints(AStretchBlt.Top - ATextReferenceY);
    if ((LPixelToPoint > (AFont.Size - 2)) and
      (LPixelToPoint < (AFont.Size + 2))) then
      Result := [fsUnderline]
    else if IsStrikeOut then
      Result := [fsStrikeOut];
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.SetAlignment(AgtEMFAlignment: TgtEMFAlignment;
  var AHorizontalAlignment: TgtHAlignment;
  var AVerticalAlignment: TgtVAlignment);
begin
  (*
    TgtEMFAlignments = (TA_NOUPDATECP, TA_UPDATECP, TA_LEFT, TA_RIGHT, TA_CENTER,
    TA_TOP, TA_BOTTOM, TA_BASELINE, TA_RTLREADING, TA_MASK);

    TgtAlignments = (taLeftJustify, taRightJustify, taCenter, taJustify,
    taBaseLine);
  *)
  if TA_LEFT in AgtEMFAlignment then
    AHorizontalAlignment := haLeft;
  if TA_RIGHT in AgtEMFAlignment then
    AHorizontalAlignment := haRight;
  if TA_CENTER in AgtEMFAlignment then
    AHorizontalAlignment := haCenter;
  if TA_BASELINE in AgtEMFAlignment then
    AVerticalAlignment := vaCenter;
  if TA_TOP in AgtEMFAlignment then
    AVerticalAlignment := vaTop;
  if TA_BOTTOM in AgtEMFAlignment then
    AVerticalAlignment := vaBottom;
end;

{ ------------------------------------------------------------------------------ }

procedure TgtMetafileProcessor.SetAlignment(AMode: Integer;
  var AgtAlignment: TgtEMFAlignment);

var
  LMode: Integer;
begin
  LMode := AMode;
  AgtAlignment := [TA_NOUPDATECP, TA_LEFT, TA_TOP];
  if ((Windows.TA_BASELINE and LMode) = Windows.TA_BASELINE) then
  begin
    AgtAlignment := (AgtAlignment - [TA_TOP]) + [TA_BASELINE];
    LMode := LMode - Windows.TA_BASELINE;
  end
  else if ((Windows.TA_BOTTOM and LMode) = Windows.TA_BOTTOM) then
  begin
    AgtAlignment := (AgtAlignment - [TA_TOP]) + [TA_BOTTOM];
    LMode := LMode - Windows.TA_BOTTOM;
  end;
  if ((Windows.TA_CENTER and LMode) = Windows.TA_CENTER) then
  begin
    AgtAlignment := (AgtAlignment - [TA_LEFT]) + [TA_CENTER];
    LMode := LMode - Windows.TA_CENTER;
  end
  else if ((Windows.TA_RIGHT and LMode) = Windows.TA_RIGHT) then
  begin
    AgtAlignment := (AgtAlignment - [TA_LEFT]) + [TA_RIGHT];
    LMode := LMode - Windows.TA_RIGHT;
  end;
  if ((Windows.TA_UPDATECP and LMode) = Windows.TA_UPDATECP) then
  begin
    AgtAlignment := (AgtAlignment - [TA_NOUPDATECP]) + [TA_UPDATECP];
  end;
  if ((Windows.TA_RTLREADING and LMode) = Windows.TA_RTLREADING) then
  begin
    AgtAlignment := (AgtAlignment - [TA_RTLREADING]) + [TA_RTLREADING];
  end;
end;

procedure TgtMetafileProcessor.IsFirstRasterOpImage(ARect: TgtRect;
  out ImageIndex: Integer);
begin
  ImageIndex := -1;
  if (FEngine.CurrentDocumentItemList.Count > 0) and
    (TgtDocumentItem(FEngine.CurrentDocumentItemList.Items
    [FEngine.CurrentDocumentItemList.Count - 1]) is TgtImageItem) then
  begin
    if (TgtImageItem(FEngine.CurrentDocumentItemList.Items
      [FEngine.CurrentDocumentItemList.Count - 1]).X = ARect.Left) and
      (TgtImageItem(FEngine.CurrentDocumentItemList.Items
      [FEngine.CurrentDocumentItemList.Count - 1]).Y = ARect.Top) and
      (TgtImageItem(FEngine.CurrentDocumentItemList.Items
      [FEngine.CurrentDocumentItemList.Count - 1]).Width = Round(ARect.Right -
      ARect.Left)) and
      (TgtImageItem(FEngine.CurrentDocumentItemList.Items
      [FEngine.CurrentDocumentItemList.Count - 1]).Height = Round(ARect.Bottom -
      ARect.Top)) then
      ImageIndex := TgtImageItem(FEngine.CurrentDocumentItemList.Items
        [FEngine.CurrentDocumentItemList.Count - 1]).IndexNo;
  end;
end;

procedure TgtMetafileProcessor.SelectStockObject(AihObject: Cardinal);

var
  LBrush: TBrush;
  LPen: TPen;
  LFont: TgtFont;
  LPalette: TgtPalette;
begin
  case AihObject of
    BLACK_BRUSH:
      begin
        LBrush := TBrush.Create;
        LBrush.Color := clBlack;
        FCurrentBrush.Assign(LBrush);
        LBrush.Destroy;
      end;
    DKGRAY_BRUSH:
      begin
        LBrush := TBrush.Create;
        LBrush.Color := clDkGray;
        FCurrentBrush.Assign(LBrush);
        LBrush.Destroy;
      end;
    DC_BRUSH:
      begin
        LBrush := TBrush.Create;
        FCurrentBrush.Assign(LBrush);
        LBrush.Destroy;
      end;
    GRAY_BRUSH:
      begin
        LBrush := TBrush.Create;
        LBrush.Color := clGray;
        FCurrentBrush.Assign(LBrush);
        LBrush.Destroy;
      end;
    HOLLOW_BRUSH:
      begin
        LBrush := TBrush.Create;
        LBrush.Style := bsClear;
        FCurrentBrush.Assign(LBrush);
        LBrush.Destroy;
      end;
    LTGRAY_BRUSH:
      begin
        LBrush := TBrush.Create;
        LBrush.Color := clLtGray;
        FCurrentBrush.Assign(LBrush);
        LBrush.Destroy;
      end;
    WHITE_BRUSH:
      begin
        LBrush := TBrush.Create;
        FCurrentBrush.Assign(LBrush);
        LBrush.Destroy;
      end;
    BLACK_PEN:
      begin
        LPen := TPen.Create;
        LPen.Color := clBlack;
        FCurrentPen.Assign(LPen);
        LPen.Destroy;
      end;
    DC_PEN:
      begin
        LPen := TPen.Create;
        FCurrentPen.Assign(LPen);
        LPen.Destroy;
      end;
    WHITE_PEN:
      begin
        LPen := TPen.Create;
        LPen.Color := clWhite;
        FCurrentPen.Assign(LPen);
        LPen.Destroy;
      end;
    NULL_PEN:
      begin
        LPen := TPen.Create;
        LPen.Style := psClear;
        FCurrentPen.Assign(LPen);
        LPen.Destroy;
      end;
    ANSI_FIXED_FONT:
      begin
        LFont := TgtFont.Create;
        FCurrentFont.Assign(LFont);
        LFont.Destroy;
      end;
    ANSI_VAR_FONT:
      begin
        LFont := TgtFont.Create;
        FCurrentFont.Assign(LFont);
        LFont.Destroy;
      end;
    DEVICE_DEFAULT_FONT:
      begin
        LFont := TgtFont.Create;
        FCurrentFont.Assign(LFont);
        LFont.Destroy;
      end;
    SYSTEM_FONT:
      begin
        LFont := TgtFont.Create;
        FCurrentFont.Assign(LFont);
        LFont.Destroy;
      end;
    SYSTEM_FIXED_FONT:
      begin
        LFont := TgtFont.Create;
        FCurrentFont.Assign(LFont);
        LFont.Destroy;
      end;
    OEM_FIXED_FONT:
      begin
        LFont := TgtFont.Create;
        FCurrentFont.Assign(LFont);
        LFont.Destroy;
      end;
    DEFAULT_PALETTE:
      begin
        LPalette := TgtPalette.Create;
        FCurrentPalette.FLogPalette := LPalette.FLogPalette;
        LPalette.Destroy;
      end;
  end;
end;

function TgtMetafileProcessor.WorldTransform(AX, AY: Double): TgtPoint;
begin
  Result.X := 0;
  Result.Y := 0;
  with FXForm do
  begin
    Result.X := AX * eM11 + AY * eM21 + eDx;
    Result.Y := AX * eM12 + AY * eM22 + eDy;
  end;
end;

procedure TgtMetafileProcessor.RestoreMetaState(N: Integer);

var
  LMetaState: TgtMetaState;
begin
  if ((FMetaState.Count = 0) or (N = 0)) then
    Exit;
  if N < 0 then
    N := FMetaState.Count + N;
  if (FMetaState.IndexOf(IntToStr(N))) = -1 then
    Exit;
  LMetaState := TgtMetaState(FMetaState.Objects
    [FMetaState.IndexOf(IntToStr(N))]);
  with LMetaState do
  begin
    FCurrentFont.Assign(FFont);
    FCurrentBrush.Assign(FBrush);
    FCurrentPen.Assign(FPen);
    Self.FBKMode := FBKMode;
    Self.FMapMode := FMapMode;
    Self.FXForm := FXForm;
    FWindowOrigin := FWinOrg;
    FWindowExtent := FWinExtent;
    FViewPortOrigin := FViewOrg;
    FTextColor := FCurrentTextColor;
    FViewPortExtent := FViewExtent;
    FTextAlignment := FTextAlign;
    SetMapModeMultiplier;

    TgtMetaState(FMetaState.Objects[FMetaState.IndexOf(IntToStr(N))]).Free;
    FMetaState.Delete(FMetaState.IndexOf(IntToStr(N)));
  end;
end;

procedure TgtMetafileProcessor.SaveMetaState;

var
  LMetaState: TgtMetaState;
begin
  LMetaState := TgtMetaState.Create;
  with LMetaState do
  begin
    FFont.Assign(FCurrentFont);
    FBrush.Assign(FCurrentBrush);
    FPen.Assign(FCurrentPen);
    FBKMode := Self.FBKMode;
    FMapMode := Self.FMapMode;
    FXForm := Self.FXForm;
    FCurrentTextColor := FTextColor;
    FWinOrg := FWindowOrigin;
    FWinExtent := FWindowExtent;
    FViewOrg := FViewPortOrigin;
    FTextAlign := FTextAlignment;
    FViewExtent := FViewPortExtent;

    FMetaState.AddObject(IntToStr(FMetaState.Count), LMetaState);
  end;
end;

{ TgtMetaState }

constructor TgtMetaState.Create;
begin
  inherited;
  FFont := TgtFont.Create;
  FBrush := TBrush.Create;
  FPen := TPen.Create;
  FBKMode := 0;
  FMapMode := 0;
  with FXForm do
  begin
    eM11 := 1;
    eM12 := 0;
    eM21 := 0;
    eM22 := 1;
    eDx := 0;
    eDy := 0;
  end;
  FViewOrg.X := 0;
  FViewOrg.Y := 0;
  FViewExtent.cx := 1;
  FViewExtent.cy := 1;

  FWinOrg.X := 0;
  FWinOrg.Y := 0;
  FWinExtent.cx := 1;
  FWinExtent.cy := 1;
end;

destructor TgtMetaState.Destroy;
begin
  FFont.Destroy;
  FBrush.Destroy;
  FPen.Destroy;
  inherited;
end;

function TgtMetafileProcessor.GetTopLeftPosition(ReferenceX, ReferenceY: Double;
  Text: String; ATextWidth: Double; Font: TFont; Rotation: Integer): TgtPoint;

var
  FontInfo: TgtFontInfo;
  Alpha, Len: Double;
  LTxtHeight, LTxtSize: Double;
  // LTxtWidth: Double;
begin
  Result.X := ReferenceX;
  Result.Y := ReferenceY;

  FontInfo := TgtFontInfo.Create;
  try
    FillFontMetrics(Font, FontInfo);
    LTxtSize := (Font.Size * Font.PixelsPerInch / 72.0) *
      (CPixelsPerInch / FEngine.InputYRes);
    LTxtHeight := TextSize(String(Text), Font).cy *
      (CPixelsPerInch / FEngine.InputYRes);
    // LTxtWidth := TextSize(String(Text), Font).cx *
    // (CPixelsPerInch / FEngine.InputXRes);
  finally
    FreeAndNil(FontInfo);
  end;

  // 1. Point of rotation is Top-Left corner.
  if ((TA_TOP in FTextAlignment) and (TA_LEFT in FTextAlignment)) then
  begin
    Result.Y := Result.Y;
    Result.X := Result.X;
  end
  // 2. Point of rotation is Basline-Left corner.
  else if ((TA_BASELINE in FTextAlignment) and (TA_LEFT in FTextAlignment)) then
  begin
    Result.Y := Result.Y - (Cos(Rotation * PI / 180.0) * LTxtSize);
    Result.X := Result.X - (Sin(Rotation * PI / 180.0) * LTxtSize);
  end
  // 3. Point of rotation is Bottom-Left corner.
  else if ((TA_BOTTOM in FTextAlignment) and (TA_LEFT in FTextAlignment)) then
  begin
    Result.Y := Result.Y - Cos(Rotation * PI / 180.0) * LTxtHeight;
    Result.X := Result.X - Sin(Rotation * PI / 180.0) * LTxtHeight;
  end
  // 4. Point of rotation is Top-Center corner.
  else if ((TA_TOP in FTextAlignment) and (TA_CENTER in FTextAlignment)) then
  begin
    Result.Y := Result.Y + Sin(Rotation * PI / 180.0) * (ATextWidth / 2);
    Result.X := Result.X - Cos(Rotation * PI / 180.0) * (ATextWidth / 2);
  end
  // 5. Point of rotation is Baseline-Center corner.
  else if ((TA_BASELINE in FTextAlignment) and
    (TA_CENTER in FTextAlignment)) then
  begin
    Alpha := (Rotation * PI / 180) - (ArcTan((LTxtSize) / (ATextWidth / 2)));
    Len := Hypot((ATextWidth / 2), (LTxtSize));
    Result.Y := Result.Y + Sin(Alpha) * Len;
    Result.X := Result.X - Cos(Alpha) * Len;
  end
  // 6. Point of rotation is Bottom-Center corner.
  else if ((TA_BOTTOM in FTextAlignment) and (TA_CENTER in FTextAlignment)) then
  begin
    Alpha := (Rotation * PI / 180) - (ArcTan(LTxtHeight / (ATextWidth / 2)));
    Len := Hypot((ATextWidth / 2), LTxtHeight);
    Result.Y := Result.Y + Sin(Alpha) * Len;
    Result.X := Result.X - Cos(Alpha) * Len;
  end
  // 7. Point of rotation is Top-Right corner.
  else if ((TA_TOP in FTextAlignment) and (TA_RIGHT in FTextAlignment)) then
  begin
    Result.Y := Result.Y + Sin(Rotation * PI / 180.0) * ATextWidth;
    Result.X := Result.X - Cos(Rotation * PI / 180.0) * ATextWidth;
  end
  // 8. Point of rotation is Baseline-Right corner.
  else if ((TA_BASELINE in FTextAlignment) and
    (TA_RIGHT in FTextAlignment)) then
  begin
    Alpha := (Rotation * PI / 180) - (ArcTan((LTxtSize) / ATextWidth));
    Len := Hypot(ATextWidth, (LTxtSize));
    Result.Y := Result.Y + Sin(Alpha) * Len;
    Result.X := Result.X - Cos(Alpha) * Len;
  end
  // 9. Point of rotation is Bottom-Right corner.
  else if ((TA_BOTTOM in FTextAlignment) and (TA_RIGHT in FTextAlignment)) then
  begin
    Alpha := (Rotation * PI / 180) - (ArcTan(LTxtHeight / ATextWidth));
    Len := Hypot(ATextWidth, LTxtHeight);
    Result.Y := Result.Y + Sin(Alpha) * Len;
    Result.X := Result.X - Cos(Alpha) * Len;
  end;
end;

procedure TgtMetafileProcessor.SetMapModeMultiplier;
begin
  if (FMapMode = MM_ANISOTROPIC) or (FMapMode = MM_ISOTROPIC) then
  begin
    FMapMXmul := FViewPortExtent.cx / FWindowExtent.cx;
    FMapMYmul := FViewPortExtent.cy / FWindowExtent.cy;
  end;
end;

function TgtMetafileProcessor.ApplyMM(AX, AY: Double): TgtPoint;
begin
  // convert from world Space to Page Space.
  // if not FApplyTransformation then
  Result := WorldTransform(AX, AY);
  if (FMapMode = MM_ANISOTROPIC) or (FMapMode = MM_ISOTROPIC) then
  begin
    Result.X := (Result.X - FWindowOrigin.X) * FMapMXmul *
      (CPixelsPerInch / FEngine.InputXRes);
    Result.Y := (Result.Y - FWindowOrigin.Y) * FMapMYmul *
      (CPixelsPerInch / FEngine.InputYRes);
  end
  else
  begin
    Result.X := (Result.X - FWindowOrigin.X) *
      (CPixelsPerInch / FEngine.InputXRes);
    Result.Y := (Result.Y - FWindowOrigin.Y) *
      (CPixelsPerInch / FEngine.InputYRes);
  end;
end;

function TgtMetafileProcessor.ApplyMMToPenWidth(AX: Double): Double;

var
  LI: Integer;
begin
  if (FMapMode = MM_ANISOTROPIC) or (FMapMode = MM_ISOTROPIC) then
  begin
    LI := Round(FViewPortExtent.cx / (CPixelsPerInch / FEngine.InputXRes));
    AX := Round((AX / (FWindowExtent.cx / LI)) *
      (CPixelsPerInch / FEngine.InputXRes));
  end;
  Result := AX * FXForm.eM11;
  // Multiplies Pen Width by the Horizontal Scaling Factor
end;

function TgtMetafileProcessor.ApplyMMWithOrigin(AX, AY: Double): TgtPoint;
begin
  // convert from world Space to Page Space.
  // if not FApplyTransformation then
  Result := WorldTransform(AX, AY);
  if (FMapMode = MM_ANISOTROPIC) or (FMapMode = MM_ISOTROPIC) then
  begin
    Result.X := (Result.X - FWindowOrigin.X) * FMapMXmul *
      (CPixelsPerInch / FEngine.InputXRes) + FViewPortOrigin.X;
    Result.Y := (Result.Y - FWindowOrigin.Y) * FMapMYmul *
      (CPixelsPerInch / FEngine.InputYRes) + FViewPortOrigin.Y;
  end
  else
  begin
    Result.X := (Result.X - FWindowOrigin.X) *
      (CPixelsPerInch / FEngine.InputXRes) + FViewPortOrigin.X;
    Result.Y := (Result.Y - FWindowOrigin.Y) *
      (CPixelsPerInch / FEngine.InputYRes) + FViewPortOrigin.Y;
  end;
end;

function TgtMetafileProcessor.ApplyMMToRect(ARect: TgtRect): TgtRect;

var
  LPoint: TgtPoint;
begin
  LPoint := ApplyMMWithOrigin(ARect.Left, ARect.Top);
  Result.Left := LPoint.X;
  Result.Top := LPoint.Y;
  LPoint := ApplyMMWithOrigin(ARect.Right, ARect.Bottom);
  Result.Right := LPoint.X;
  Result.Bottom := LPoint.Y;
end;

procedure TgtMetafileProcessor.CreatePolyShapeItem(var APolyShapeItem
  : TgtPolyShapeItem);
begin
  APolyShapeItem := TgtPolyShapeItem.Create;
end;

procedure TgtMetafileProcessor.CreatePolyPolygonItem(var APolyPolygonItem
  : TgtPolyPolygonItem);
begin
  APolyPolygonItem := TgtPolyPolygonItem.Create;
end;

function TgtMetafileProcessor.GetColorValue(AColor: Cardinal): Cardinal;
begin
  Result := AColor;
{$IFNDEF gtMany2PDFX}
  if (AColor and $FF000000 <> 0) then
    Result := $0;
{$ENDIF}
end;

{ ------------------------------------------------------------------------------ }
{ TgtPalette }
{ ------------------------------------------------------------------------------ }

constructor TgtPalette.Create;
begin
end;

destructor TgtPalette.Destroy;
begin

  inherited;
end;

{ ------------------------------------------------------------------------------ }
{ TgtGDIOBJ }
{ ------------------------------------------------------------------------------ }

constructor TgtGDIOBJ.Create(AGDIOBJType: TgtGDIOBJType);
begin
  FGDIOBJType := AGDIOBJType;
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FFont := TgtFont.Create;
  FPalette := TgtPalette.Create;
end;

destructor TgtGDIOBJ.Destroy;
begin
  FPen.Destroy;
  FBrush.Destroy;
  FFont.Destroy;
  FPalette.Destroy;
  inherited;
end;

end.
