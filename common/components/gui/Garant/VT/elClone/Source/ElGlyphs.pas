unit ElGlyphs;

{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$I ElPack.inc}

// $Id: ElGlyphs.pas,v 1.9 2013/04/04 11:20:40 lulin Exp $

// $Log: ElGlyphs.pas,v $
// Revision 1.9  2013/04/04 11:20:40  lulin
// - портируем.
//
// Revision 1.8  2011/05/19 12:23:19  lulin
// {RequestLink:266409354}.
//
// Revision 1.7  2008/05/13 12:16:45  lulin
// - чистка в рамках <K>: 90441490.
//
// Revision 1.6  2008/02/07 11:59:51  lulin
// - распилили наследие ElPack'а по двум библиотекам.
//
// Revision 1.5  2008/02/06 09:30:44  lulin
// - базовые списки объектов выделяем в отдельные файлы.
//
// Revision 1.4  2008/01/31 18:53:38  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.3  2007/04/09 06:05:21  lulin
// - используем родные битмапы.
//
// Revision 1.2  2007/03/27 13:26:30  lulin
// - используем родной список.
//
(*

Version History

05/15/2003

  Fixed the problem with getting disabled image from multi-glyph bitmap 

03/19/2003

  Disabled image is now always created in the same way as for ImageList items

12/15/2002

  Glyph classes moved to separate unit

*)

interface

uses
  SysUtils,
  Classes,
  ElTmSchema,
  ElUxTheme,

  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Buttons,
  CommCtrl,
  Menus,
{$ifdef VCL_6_USED}
  Types,
{$endif}
{$ifdef VCL_4_USED}
  ImgList,
{$endif}
{$IFDEF VCL_4_USED}
  ActnList,
{$ENDIF}
  ElVCLUtils,
  ElStrUtils,
  ElTools,

  l3Base,
  l3ProtoObject,
  l3ObjectList
  ;

type

  TElButtonState = (ebsUp, ebsDisabled, ebsDown, ebsExclusive, ebsArrDown);

  TElGlyphList = class(TImageList)
  private
    Used : TBits;
    FCount : Integer;
    function AllocateIndex : Integer;
  public
    constructor CreateSize(AWidth, AHeight : Integer);
    destructor Destroy; override;
    function AddMasked(Image : TBitmap; MaskColor : TColor) : Integer;     procedure Delete(Index : Integer);
    property Count : Integer read FCount;
  end;

  TElGlyphCache = class(Tl3ProtoObject)
  private
    GlyphLists : Tl3ObjectList;
  protected
    procedure Cleanup; override;
  public
    constructor Create;
      reintroduce;
    function GetList(AWidth, AHeight : Integer) : TElGlyphList;
    procedure ReturnList(List : TElGlyphList);
    function Empty : Boolean;
  end;//TElGlyphCache

  TElButtonGlyph = class(Tl3ProtoObject)
  protected
    FImageList : TImageList;
    FAlphaImageList: TImageList;
    FImageIndex : Integer;
    FUseImageList : Boolean;
    FIcon : TIcon;
    FUseIcon : Boolean;
    FOriginal : TBitmap;
    FGlyphList : TElGlyphList;
    FIndexs : array[TElButtonState] of Integer;
    FTransparentColor : TColor;
    FNumGlyphs : TNumGlyphs;
    FOnChange : TNotifyEvent;
    FStretched : boolean;
    FStrW,
      FStrH : integer;
    //procedure ImageListChanged(Sender : TObject);
    procedure SetImageList(NewValue  : TImageList);
    procedure SetAlphaImageList(NewValue: TImageList);
    procedure SetImageIndex(NewValue : Integer);
    procedure GlyphChanged(Sender : TObject);
    procedure IconChanged(Sender : TObject);
    procedure SetGlyph(Value : TBitmap);
    procedure SetNumGlyphs(Value : TNumGlyphs);
    procedure Repaint;
    function CreateButtonGlyph(State : TElButtonState) : Integer;
    procedure DrawButtonGlyph(Canvas : TCanvas; const GlyphPos : TPoint; State :
        TElButtonState; Transparent : Boolean; Color : TColor; AlphaBlended :
        boolean);
    procedure DrawButtonText(Canvas : TCanvas; const Caption : TElFString;
        TextBounds : TRect; State : TElButtonState; Multiline : boolean; Alignment
        : TAlignment; Active, Transparent : boolean; TextDrawType : TElTextDrawType;
        UseThemesForText : boolean; Theme : HTheme; ThemePart, ThemeState : integer;
        ShowAccelChar : boolean  ; ChangeDisabledText : boolean);
    procedure CalcButtonLayout(Canvas : TCanvas; const Client : TRect; const aOffset
        : TPoint; const Caption : TElFString; Layout : TButtonLayout; Margin,
        Spacing : Integer; var GlyphPos : TPoint; var TextBounds : TRect; ShowGlyph,
        ShowText, MultiLine : boolean; ArrowWidth : integer; UseThemesForText :
        boolean; Theme : HTheme; ThemePart, ThemeState : integer; ShowAccelChar : boolean
        
        );
    function GetGlyphSize : TRect;
    procedure SetUseIcon(NewValue : boolean);
  protected
    property ImageList : TImageList read FImageList write SetImageList;
    property AlphaImageList: TImageList read FAlphaImageList write SetAlphaImageList;
    property ImageIndex : Integer read FImageIndex write SetImageIndex default -1;
    property UseImageList : Boolean read FUseImageList write FUseImageList;
    procedure Cleanup; override;
  public
    constructor Create;
      reintroduce;
    { return the text rectangle }
    procedure ResetNumGlyphs;

    function Draw(Canvas : TCanvas; const Client : TRect; const Offset : TPoint;
        const Caption : TElFString; Layout : TButtonLayout; Margin, Spacing :
        Integer; State, GlyphState : TElButtonState; Alignment : TAlignment;
        Transparent : Boolean; Multiline : boolean; Active, ShowGlyph,
        ShowText : boolean; ArrowWidth : integer; TextDrawType : TElTextDrawType;
        Color : TColor; UseThemesForText : boolean; Theme : HTheme;
        ThemePart, ThemeState : integer; ShowAccelChar : boolean;
        ImageIsAlphaBlended : boolean
        ; ChangeDisabledText : boolean
        ) : TRect;
    procedure GetPaintGlyphSize(R : TRect; var Size : TPoint);
    function CalcButtonWidth(Canvas : TCanvas; var MaxHeight : integer; const
        Offset : TPoint; const Caption : TElFString; Layout : TButtonLayout; Margin,
        Spacing : Integer; ShowGlyph, ShowText, MultiLine : boolean; ArrowWidth :
        integer; UseThemesForText : boolean; Theme : HTheme; ThemePart, ThemeState
        : integer; ShowAccelChar : boolean): Integer;
    property UseIcon : boolean read FUseIcon write SetUseIcon;
    property Icon : TIcon read FIcon;
    property Glyph : TBitmap read FOriginal write SetGlyph;
    property NumGlyphs : TNumGlyphs read FNumGlyphs write SetNumGlyphs default 1;
    property GlyphSize : TRect read GetGlyphSize;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
  end;//TElButtonGlyph

var
  GlyphCache : TElGlyphCache = nil;
  Pattern    : TBitmap = nil;
  ButtonCount: Integer = 0;

implementation

uses
  l3Bitmap
  ;

const
  ROP_DSPDxax = $00E20746;

procedure SetDisabled(FOriginal : TBitmap);
var MonoBmp : TBitmap;
    SrcDC,
    DestDC  : HDC;

begin
  MonoBmp := Tl3Bitmap.Create;
  with MonoBmp do
  begin
    Width := FOriginal.Width;
    Height := FOriginal.Height;
    Monochrome := True;
  end;
  SrcDC := MonoBmp.Canvas.Handle;

  monoBmp.Canvas.CopyRect(Rect(0, 0, FOriginal.Width, FOriginal.Height), FOriginal.Canvas, Rect(0, 0, FOriginal.Width, FOriginal.Height));
  //BitBlt(SrcDC, 0, 0, FOriginal.Width, FOriginal.Height, FOriginal.Canvas.Handle, 0, 0, SRCCOPY);

  FOriginal.Canvas.Brush.Color := cl3DDkShadow;
  FOriginal.Canvas.FillRect(Rect(0, 0, FOriginal.Width, FOriginal.Height));

  { Convert Black to clBtnHighlight }
  FOriginal.Canvas.Brush.Color := clBtnHighlight;
  DestDC := FOriginal.Canvas.Handle;

  Windows.SetTextColor(DestDC, clWhite);
  Windows.SetBkColor(DestDC, clBlack);

  BitBlt(DestDC, 1, 1, FOriginal.Width - 1, FOriginal.Height - 1, SrcDC, 0, 0, ROP_DSPDxax);

  { Convert Black to clBtnShadow }

  FOriginal.Canvas.Brush.Color := clBtnShadow;
  DestDC := FOriginal.Canvas.Handle;

  Windows.SetTextColor(DestDC, clWhite);
  Windows.SetBkColor(DestDC, clBlack);

  BitBlt(DestDC, 0, 0, FOriginal.Width, FOriginal.Height, SrcDC, 0, 0, ROP_DSPDxax);

  l3Free(MonoBmp);
end;

constructor TElGlyphList.CreateSize(AWidth, AHeight : Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  Used := TBits.Create;
end;

destructor TElGlyphList.Destroy;
begin
  l3Free(Used);
  inherited Destroy;
end;

function TElGlyphList.AllocateIndex : Integer;
begin
  Result := Used.OpenBit;
  if Result >= Used.Size then
  begin
    Result := inherited Add(nil, nil);
    Used.Size := Result + 1;
  end;
  Used[Result] := True;
end;

function TElGlyphList.AddMasked(Image : TBitmap; MaskColor : TColor) : Integer;
const
  Mask: array[Boolean] of Longint = (0, ILC_MASK);
var
  DC : HDC;
begin
  if not HandleAllocated and (not ThemesAvailable) then
  begin
    DC := GetDC(0);
    if (GetDeviceCaps(DC, BITSPIXEL) = 32) then
      Handle := ImageList_Create(Width, Height, ILC_COLOR32 or Mask[Masked], AllocBy, AllocBy);
    ReleaseDC(0, DC);
  end;
  Result := AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;

procedure TElGlyphList.Delete(Index : Integer);
begin
  if Used[Index] then
  begin
    Dec(FCount);
    Used[Index] := False;
  end;
end;

{ TElGlyphCache }

constructor TElGlyphCache.Create;
begin
  inherited Create;
  GlyphLists := Tl3ObjectList.Make;
end;

procedure TElGlyphCache.Cleanup;
begin
  l3Free(GlyphLists);
  inherited;
end;

function TElGlyphCache.GetList(AWidth, AHeight : Integer) : TElGlyphList;
var
  I : Integer;
begin
  for I := GlyphLists.Count - 1 downto 0 do
  begin
    Result := TElGlyphList(GlyphLists[I]);
    with Result do
      if (AWidth = Width) and (AHeight = Height) then Exit;
  end;
  Result := TElGlyphList.CreateSize(AWidth, AHeight);
  GlyphLists.Add(Result);
end;

procedure TElGlyphCache.ReturnList(List : TElGlyphList);
begin
  if List = nil then Exit;
  if List.Count = 0 then
  begin
    GlyphLists.Remove(List);
    l3Free(List);
  end;
end;

function TElGlyphCache.Empty : Boolean;
begin
  Result := GlyphLists.Count = 0;
end;

(*
procedure CreateBrushPattern;
var
  X, Y : Integer;
begin
  Pattern := Tl3Bitmap.Create;
  Pattern.Width := 8;
  Pattern.Height := 8;
  with Pattern.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clBtnFace;
    FillRect(Rect(0, 0, Pattern.Width, Pattern.Height));
    {$ifdef CLX_USED}
    Pen.Color := clBtnHighlight;
    {$endif}
    for Y := 0 to 7 do
      for X := 0 to 7 do
        if (Y mod 2) = (X mod 2) then { toggles between even/odd pixles }
{$ifndef CLX_USED}
          Pixels[X, Y] := clBtnHighlight; { on even/odd rows }
{$else}
          Pattern.Canvas.DrawPoint(X, Y);
{$endif}
  end;
end;
*)

{ TElButtonGlyph }

constructor TElButtonGlyph.Create;
var
  I : TElButtonState;
begin
  inherited Create;
  FOriginal := Tl3Bitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clOlive;
  FNumGlyphs := 1;
  for I := Low(I) to High(I) do
    FIndexs[I] := -1;
  if GlyphCache = nil then GlyphCache := TElGlyphCache.Create;
  FIcon := TIcon.Create;
  FIcon.OnChange := IconChanged;
  FImageIndex := -1;
end;

procedure TElButtonGlyph.Cleanup;
begin
  l3Free(FOriginal);
  Repaint;
  if Assigned(GlyphCache) and GlyphCache.Empty then
    l3Free(GlyphCache);
  l3Free(FIcon);
  inherited;
end;

procedure TElButtonGlyph.Repaint;
var
  I : TElButtonState;
begin
  for I := Low(I) to High(I) do
  begin
    if FIndexs[I] <> -1 then FGlyphList.Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
  GlyphCache.ReturnList(FGlyphList);
  FGlyphList := nil;
end;

procedure TElButtonGlyph.SetImageIndex(NewValue : Integer);
begin
  if FImageIndex <> NewValue then
  begin
    FImageIndex := NewValue;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TElButtonGlyph.SetImageList(NewValue : TImageList);
begin
  if FImageList <> NewValue then
  begin
    FImageList := NewValue;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TElButtonGlyph.SetAlphaImageList(NewValue : TImageList);
begin
  if FAlphaImageList <> NewValue then
  begin
    FAlphaImageList := NewValue;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TElButtonGlyph.IconChanged(Sender : TObject);
begin
  if FIcon.Empty then UseIcon := false;
  Repaint;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TElButtonGlyph.GlyphChanged(Sender : TObject);
begin
  if Sender = FOriginal then
  begin
      FTransparentColor := FOriginal.TransparentColor;

    ResetNumGlyphs;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TElButtonGlyph.ResetNumGlyphs;
var Value : TBitmap;
    Glyphs: Integer;

begin
  Value := FOriginal;
  if (Value <> nil) and (Value.Height > 0) then
  begin
    FTransparentColor := Value.TransparentColor;
    if Value.Width mod Value.Height = 0 then
    begin
      Glyphs := Value.Width div Value.Height;
      if Glyphs > 4 then Glyphs := 1;
      SetNumGlyphs(Glyphs);
    end;
  end;
  if (Value = nil) or (Value.Empty) then SetNumGlyphs(1);
end;

procedure TElButtonGlyph.SetGlyph(Value : TBitmap);
begin
  Repaint;
  FOriginal.Assign(Value);
  if Value <> nil then
    FTransparentColor := Value.TransparentColor;
end;

procedure TElButtonGlyph.SetNumGlyphs(Value : TNumGlyphs);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then
  begin
    Repaint;
    FNumGlyphs := Value;
    GlyphChanged(Glyph);
    FNumGlyphs := Value;
  end;
end;

function TElButtonGlyph.CreateButtonGlyph(State : TElButtonState) : Integer;
var
  TmpImage : TBitmap;
  IWidth, IHeight : Integer;
  IRect, ORect : TRect;
  I : TElButtonState;
begin
  if (State = ebsDown) and (NumGlyphs < 3) then State := ebsUp;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width or FOriginal.Height) = 0 then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    if GlyphCache = nil then
      GlyphCache := TElGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := Tl3Bitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    if FOriginal.PixelFormat <> pfCustom then
      TmpImage.PixelFormat := FOriginal.PixelFormat; {pf24bit;}
    TmpImage.Palette := CopyPalette(FOriginal.Palette);

    I := State;
    if Ord(I) >= NumGlyphs then I := ebsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      ebsUp, ebsDown,
        ebsArrDown,
        ebsExclusive :
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
{$IFDEF VER90}
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor);
{$ELSE}
          if FOriginal.TransparentMode = tmFixed then
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor)
          else
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
{$ENDIF}
        end;
      ebsDisabled :
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          TmpImage.Canvas.Brush.Color := TmpImage.Canvas.Pixels[0, TmpImage.Height - 1];
          if NumGlyphs < 2 then
            SetDisabled(TmpImage);
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, TmpImage.Canvas.Pixels[0, TmpImage.Height - 1]);
        end;
    end;
  finally
    l3Free(TmpImage);
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;

procedure TElButtonGlyph.DrawButtonGlyph(Canvas : TCanvas; const GlyphPos :
    TPoint; State : TElButtonState; Transparent : Boolean; Color : TColor;
    AlphaBlended : boolean);
var
  Index   : Integer;
  TC, OTC : TColor;
  BMP     : TBitmap;
  FStyle  : TBrushStyle;
  IcW,
    IcH   : Integer;
  IconInfo: TIconInfo;
  ABMP    : Windows.TBitmap;

  AlphaIL: boolean;
  BmpAm : TBitmap;

const
  ROP_DSPDxax = $00E20746;

begin
  if FUseImageList and (FImageList <> nil) then
  begin
    if ImageIndex <> -1 then
    begin
      AlphaIL := (FAlphaImageList<> nil)and(ImageIndex < FAlphaImageList.Count);
      AlphaBlended := AlphaIL;
      if FStretched or (State = ebsDisabled) then
      begin
        BMP := Tl3Bitmap.Create;
        Bmp.PixelFormat := pf24bit;

        if FStretched then
        begin
{
          BMP.Width := FOriginal.Width div FNumGlyphs;
          BMP.Height := FOriginal.Height;
}
          BMP.Width := FImageList.Width;
          Bmp.Height := FImageList.Height;
        end
        else
        begin
          BMP.Width := FImageList.Width;
          Bmp.Height := FImageList.Height;
        end;
        with GlyphPos do
          if Transparent or (State = ebsExclusive) or (Color = clNone) then
            ImageList_DrawEx(FImageList.Handle, ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Transparent)
          else
            ImageList_DrawEx(FImageList.Handle, ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
              ColortoRGB(clBtnFace){CLR_DEFAULT}, clNone, ILD_Normal);
        // Bmp.SaveToFile('e:\nomanifset.bmp');
        FStyle := Canvas.Brush.Style;
        TC := BMP.Canvas.Pixels[0, BMP.Height - 1];
        OTC := Canvas.Brush.Color;
        Canvas.Brush.Color := TC;

        if FStretched then
        begin
          Canvas.Brush.Style := bsClear;

          if AlphaBlended then
          begin
            if AlphaIL then
            begin
              BmpAm := Tl3Bitmap.Create;
              BmpAm.Width := FAlphaImageList.Width;
              BmpAm.Height := FAlphaImageList.Height;
              BmpAm.PixelFormat := pf32bit;
              ImageList_DrawEx(FAlphaImageList.Handle, ImageIndex, BmpAm.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
              AlphaCopyRect2(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), BmpAm, 255);
              l3Free(BmpAm);
            end
            else
              AlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false);
          end
          else
            Canvas.BrushCopy(Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y),
              BMP, Rect(0, 0, BMP.Width, BMP.Height), TC);
        end
        else
        begin

          SetDisabled(Bmp);

          TC := Bmp.Canvas.Pixels[0, BMP.Height - 1];
          Canvas.Brush.Color := TC;
          Canvas.Brush.Style := bsClear;

          DrawTransparentBitmapEx(Canvas.Handle, Bmp, GlyphPos.X, GlyphPos.Y, Rect(0, 0, BMP.Width, BMP.Height), TC);

            //Canvas.BrushCopy(Rect(GlyphPos.X, GlyphPos.Y, BMP.Width + GlyphPos.X, BMP.Height + GlyphPos.Y),
            //  BMP, Rect(0, 0, BMP.Width, BMP.Height), TC);

        end;
        Canvas.Brush.Color := OTC;
        Canvas.Brush.Style := FStyle;
        l3Free(Bmp);
      end
      else
        if AlphaBlended then
        begin
          BMP := Tl3Bitmap.Create;
          BMP.Width := FImageList.Width;
          Bmp.Height := FImageList.Height;
          ImageList_DrawEx(FImageList.Handle, ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
          if AlphaIL then
          begin
            BmpAm := Tl3Bitmap.Create;
            BmpAm.Width := FAlphaImageList.Width;
            BmpAm.Height := FAlphaImageList.Height;
            BmpAm.PixelFormat := pf32bit;
            ImageList_DrawEx(FAlphaImageList.Handle, ImageIndex, BmpAm.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
            AlphaCopyRect2(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, BMP.Width + GlyphPos.X, BMP.Height + GlyphPos.Y), BMP.Canvas.Handle,  Rect(0, 0, BMP.Width, BMP.Height), BmpAm, 255);
            l3Free(BmpAm);
          end
          else
            AlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, BMP.Width + GlyphPos.X, BMP.Height + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false);
          l3Free(Bmp);
        end
        else
        with GlyphPos do
          if Transparent or (State = ebsExclusive) or (Color = clNone) then
            ImageList_DrawEx(FImageList.Handle, ImageIndex, Canvas.Handle, X, Y, 0, 0,
              clNone, clNone, ILD_Transparent)
          else
            ImageList_DrawEx(FImageList.Handle, ImageIndex, Canvas.Handle, X, Y, 0, 0,
              ColorToRGB(Color), clNone, ILD_Normal);
    end;
    exit;
  end;
  if FUseIcon then
  begin
    GetIconInfo(Icon.Handle, IconInfo);
    GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
    IcH := ABMP.bmHeight;
    IcW := ABMP.bmWidth;
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
    if FStretched then
      DrawIconEx(Canvas.Handle, GlyphPos.X, GlyphPos.Y, FIcon.Handle, FStrW, FStrH, 0, 0, DI_NORMAL)
    else
      DrawIconEx(Canvas.Handle, GlyphPos.X, GlyphPos.Y, FIcon.Handle, IcW, IcH, 0, 0, DI_NORMAL);
    exit;
  end;
  if (FOriginal = nil) or (FOriginal.Width = 0) or (FOriginal.Height = 0) then Exit;
  Index := CreateButtonGlyph(State);

  AlphaBlended := not IsAlphaEmpty(FOriginal);

  if FStretched then
  begin
    BMP := Tl3Bitmap.Create;
    BMP.Width := FOriginal.Width div FNumGlyphs;
    BMP.Height := FOriginal.Height;
    Bmp.PixelFormat := pf32bit;
    with GlyphPos do
      if Transparent or (State = ebsExclusive) then
        ImageList_DrawEx(FGlyphList.Handle, Index, BMP.Canvas.Handle, 0, 0, 0, 0,
          clNone, clNone, ILD_Transparent)
      else
        ImageList_DrawEx(FGlyphList.Handle, Index, BMP.Canvas.Handle, 0, 0, 0, 0,
          ColorToRGB(clBtnFace), clNone, ILD_Normal);
    FStyle := Canvas.Brush.Style;
    TC := BMP.Canvas.Pixels[0, BMP.Height - 1];
    OTC := Canvas.Brush.Color;
    Canvas.Brush.Color := TC;
    Canvas.Brush.Style := bsClear;
    if AlphaBlended then
      AlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false)
    else
      Canvas.BrushCopy(Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y),
        BMP, Rect(0, 0, BMP.Width, BMP.Height), TC);
    Canvas.Brush.Color := OTC;
    Canvas.Brush.Style := FStyle;
    l3Free(Bmp);
  end
  else
    if AlphaBlended then
    begin
      BMP := Tl3Bitmap.Create;
      BMP.Width := FGlyphList.Width;
      Bmp.Height := FGlyphList.Height;
      Bmp.PixelFormat := pf32bit;
      ImageList_DrawEx(FGlyphList.Handle, Index, BMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);
      AlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, BMP.Width + GlyphPos.X, BMP.Height + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false);
      l3Free(Bmp);
    end
    else
    with GlyphPos do
    begin
      if Transparent or (State = ebsExclusive) or (Color = clNone) then
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
          clNone, clNone, ILD_Transparent)
      else
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
          ColorToRGB(Color), clNone, ILD_Normal);
    end;
end;

procedure TElButtonGlyph.DrawButtonText(Canvas : TCanvas; const Caption :
    TElFString; TextBounds : TRect; State : TElButtonState; Multiline : boolean;
    Alignment : TAlignment; Active, Transparent : boolean; TextDrawType :
    TElTextDrawType; UseThemesForText : boolean; Theme : HTheme; ThemePart,
    ThemeState : integer; ShowAccelChar : boolean ; ChangeDisabledText :
    boolean);
var
  Flags : integer;
begin
  {$ifdef MSWINDOWS}
  if (Theme <> 0) and UseThemesForText then
  begin
    if not Multiline then
      Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE
    else
    begin
      Flags := 0;
      case Alignment of
        taLeftJustify: Flags := DT_LEFT;
        taRightJustify: Flags := DT_RIGHT;
        taCenter: Flags := DT_CENTER;
      end;
      Flags := Flags or DT_VCENTER;
    end;
    if not ShowAccelChar then
      Flags := Flags or DT_NOPREFIX;
    Canvas.Brush.Style := bsClear;
    DrawThemeText(Theme, Canvas.Handle, ThemePart, ThemeState, PWideChar(WideString(Caption)), Length(WideString(Caption)), Flags, 0, TextBounds);
  end
  else
  {$endif}
  with Canvas do
  begin
    Brush.Style := bsClear;
    if (State = ebsDisabled) and ChangeDisabledText then
    begin
      OffsetRect(TextBounds, 1, 1);
      if not Multiline then
        Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS
      else
        Flags := DT_CENTER or DT_VCENTER or DT_END_ELLIPSIS;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;
      Font.Color := clBtnHighlight;
      if Transparent then Brush.Style := bsClear;
      {$ifdef ELPACK_UNICODE}
      ElVCLUtils.DrawTextW(Handle, PWideChar(Caption), Length(Caption), TextBounds, Flags);
      {$else}
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds, Flags);
      {$endif}
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      {$ifdef ELPACK_UNICODE}
      ElVCLUtils.DrawTextW(Handle, PWideChar(Caption), Length(Caption), TextBounds, Flags);
      {$else}
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds, Flags);
      {$endif}
    end
    else
    begin
      if not Multiline then
        Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS
      else
        Flags := DT_CENTER or DT_VCENTER or DT_END_ELLIPSIS;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;
      if Transparent then Brush.Style := bsClear;

      {$ifdef ELPACK_UNICODE}
      DrawTypedTextW(Canvas, TextBounds, Caption, Flags, TextDrawType);
      {$else}
      DrawTypedText(Canvas, TextBounds, Caption, Flags, TextDrawType);
      {$endif}

      Brush.Style := bsSolid;
      case TextDrawType of
        tdtNormal : InflateRect(TextBounds, 1, 1);
        tdtShadowed : InflateRect(TextBounds, 3, 3);
        tdtRaised : InflateRect(TextBounds, 2, 2);
      end;
      //if Active and (Length(Caption) > 0) then Windows.DrawFocusRect(Canvas.Handle, TextBounds);
    end;
  end;
end;
{$WARNINGS off}

procedure TElButtonGlyph.CalcButtonLayout(Canvas : TCanvas; const Client :
    TRect; const aOffset : TPoint; const Caption : TElFString; Layout :
    TButtonLayout; Margin, Spacing : Integer; var GlyphPos : TPoint; var
    TextBounds : TRect; ShowGlyph, ShowText, MultiLine : boolean; ArrowWidth :
    integer; UseThemesForText : boolean; Theme : HTheme; ThemePart, ThemeState
    : integer; ShowAccelChar : boolean);
var
  TextPos : TPoint;
  ClientSize, GlyphSize, TextSize : TPoint;
  TotalSize : TPoint;
  GX, GY : integer;
  {$ifdef MSWINDOWS}
  Flags : integer;
  {$endif}
  AGraphic : TGraphic;
  IcW,
    IcH : Integer;
  IconInfo : TIconInfo;
  ABMP : Windows.TBitmap;
  ILBitmap : TBitmap;
begin
  ClientSize := Point(Client.Right - Client.Left - ArrowWidth, Client.Bottom - Client.Top);
  FStretched := false;

  if UseImageList and (FImageList <> nil) then
  begin
    ILBitmap := Tl3Bitmap.Create;
    if FImageIndex <> -1 then
    begin
      ILBitmap.Height := ImageList.Height;
      ILBitmap.Width := ImageList.Width;
    end;
    AGraphic := ILBitmap;
  end
  else
  if UseIcon then
  begin
    GetIconInfo(Icon.Handle, IconInfo);
    GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
    IcH := ABMP.bmHeight;
    IcW := ABMP.bmWidth;
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
    AGraphic := FIcon;
  end
  else
    AGraphic := FOriginal;
  if (AGraphic <> nil) and (ShowGlyph) then
  begin
    if UseIcon then
    begin
      GX := IcW;
      GY := IcH;
    end else
    if AGraphic = ILBitmap then
    begin
      GX := AGraphic.Width;
      GY := AGraphic.Height;
    end else
    begin
      GX := AGraphic.Width div FNumGlyphs;
      GY := AGraphic.Height;
    end;
    if GY > ClientSize.y then
    begin
      GY := ClientSize.Y - 2;
      GX := MulDiv(GX, GY, ClientSize.Y);
      FStretched := true;
    end;
    if GX > ClientSize.X then
    begin
      GY := MulDiv(GY , ClientSize.x - 4, GX);
      GX := ClientSize.x - 2;
      FStretched := true;
    end;
    if FStretched then
    begin
      FStrW := GX;
      FStrH := GY;
    end;
    GlyphSize := Point(GX, GY);
  end
  else
    GlyphSize := Point(0, 0);

  if (Length(Caption) > 0) and (ShowText) then
  begin
    {$ifdef MSWINDOWS}
    if (Theme <> 0) and UseThemesForText then
    begin
      TextBounds := Rect(0, 0, ClientSize.X, 0);
      if MultiLine then
        Flags := DT_CALCRECT
      else
        Flags := DT_CALCRECT + DT_SINGLELINE;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;

      GetThemeTextExtent(Theme, Canvas.Handle, ThemePart, ThemeState, PWideChar(WideString(Caption)), Length(WideString(Caption)), Flags, @Client, TextBounds);
      OffsetRect(TextBounds, -TextBounds.Left, -TextBounds.Top);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom - TextBounds.Top);
    end
    else
    {$endif}
    begin
      TextBounds := Rect(0, 0, ClientSize.X, 0);
      if MultiLine then
        Flags := DT_CALCRECT
      else
        Flags := DT_CALCRECT + DT_SINGLELINE;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;

      {$ifdef ELPACK_UNICODE}
      ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), TextBounds, Flags);
      {$else}
      DrawText(Canvas.Handle, PChar(Caption), Length(Caption), TextBounds, Flags);
      {$endif}
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
        TextBounds.Top);
    end;
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y {+ 1}) div 2;
    TextPos.Y := (ClientSize.Y - TextSize.Y {+ 1}) div 2;
  end
  else
  begin
    GlyphPos.X := (ClientSize.X - GlyphSize.X) div 2;
    TextPos.X := (ClientSize.X - TextSize.X) div 2;
  end;

  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  if Margin = -1 then
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;
      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 2
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 2;
    end;
  end
  else
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  case Layout of
    blGlyphLeft :
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
      end;
    blGlyphRight :
      begin
        GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    blGlyphTop :
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
      end;
    blGlyphBottom :
      begin
        GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
      end;
  end;

  { fixup the result variables }
  with GlyphPos do
  begin
    Inc(X, Client.Left + aOffset.X);
    Inc(Y, Client.Top + aOffset.Y);
  end;
  (*
  with TextPos do
  begin
    Inc(X, Client.Left + Offset.X);
    Inc(Y, Client.Top + Offset.Y);
  end;
  *)
  if Theme <> 0 then
    OffsetRect(TextBounds, TextPos.X + Client.Left + aOffset.X, Client.Top + TextPos.Y + aOffset.Y)
  else
  begin
    OffsetRect(TextBounds, TextPos.X + Client.Left + aOffset.X, TextPos.Y + Client.Top + aOffset.Y);
    // TextBounds.Right := TextBounds.Left + // Min(TextBounds.Right - TextBounds.Left, Client.Right - Client.Left - 1);
    // TextBounds.Bottom := TextBounds.Top + Min(TextBounds.Bottom - TextBounds.Top, Client.Bottom - Client.Top - 1);
  end;

  if UseImageList and (FImageList <> nil) then
   l3Free(ILBitmap);
end;

procedure TElButtonGlyph.GetPaintGlyphSize(R : TRect; var Size : TPoint);
var
  GX, GY : integer;
  ClientSize : TPoint;
  AGraphic : TGraphic;
  IcW,
    IcH : Integer;
  IconInfo : TIconInfo;
  ABMP : Windows.TBitmap;
  ILBitmap : TBitmap;
begin
  AGraphic := nil;
  ClientSize.X := R.Right - R.Left;
  ClientSize.Y := R.Bottom - R.Top;
  if UseImageList and (FImageList <> nil) then
  begin
    ILBitmap := Tl3Bitmap.Create;
    if FImageIndex <> -1 then
    begin
      ILBitmap.Height := ImageList.Height;
      ILBitmap.Width := ImageList.Width;
      AGraphic := ILBitmap;
    end;
  end
  else
  if UseIcon then
  begin
    GetIconInfo(Icon.Handle, IconInfo);
    GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
    IcH := ABMP.bmHeight;
    IcW := ABMP.bmWidth;
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
    AGraphic := FIcon;
  end
  else
    AGraphic := FOriginal;
  if (AGraphic <> nil) then
  begin
    if UseIcon then
    begin
      GX := IcW;
      GY := IcH;
    end
    else
    begin
      GX := AGraphic.Width div FNumGlyphs;
      GY := AGraphic.Height;
    end;
    if GY > ClientSize.Y then
    begin
      GY := ClientSize.Y - 2;
      GX := MulDiv(GX, GY, ClientSize.Y);
      GX := Trunc(GX * (GY / ClientSize.Y));
      FStretched := true;
    end;
    if GX > ClientSize.X then
    begin
      GY := MulDiv(GY, ClientSize.x - 4, GX);
      GX := ClientSize.X - 2;
      FStretched := true;
    end;
    if FStretched then
    begin
      FStrW := GX;
      FStrH := GY;
    end;
    Size := Point(GX, GY);
  end
  else
    Size := Point(0, 0);
  if UseImageList and (FImageList <> nil) then
    l3Free(ILBitmap);
end;

function TElButtonGlyph.Draw(Canvas : TCanvas; const Client : TRect; const
    Offset : TPoint; const Caption : TElFString; Layout : TButtonLayout; Margin,
    Spacing : Integer; State, GlyphState : TElButtonState; Alignment : TAlignment;
    Transparent : Boolean; Multiline : boolean; Active, ShowGlyph, ShowText : boolean;
    ArrowWidth : integer; TextDrawType : TElTextDrawType; Color : TColor;
    UseThemesForText : boolean; Theme : HTheme; ThemePart, ThemeState : integer;
    ShowAccelChar : boolean; ImageIsAlphaBlended : boolean
    ; ChangeDisabledText : boolean
    ): TRect;
var
  GlyphPos : TPoint;
begin
  CalcButtonLayout(Canvas, Client, Offset, Caption, Layout, Margin, Spacing,
    GlyphPos, Result, ShowGlyph, ShowText, Multiline, ArrowWidth, UseThemesForText,
    Theme, ThemePart, ThemeState, ShowAccelChar );
  if ShowGlyph then
     DrawButtonGlyph(Canvas, GlyphPos, GlyphState, Transparent, Color, ImageIsAlphaBlended);
  if ShowText then
    DrawButtonText(Canvas, Caption, Result, State, MultiLine, Alignment, Active,
      Transparent, TextDrawType, UseThemesForText, Theme, ThemePart, ThemeState, ShowAccelChar, ChangeDisabledText);
end;

procedure TElButtonGlyph.SetUseIcon(NewValue : boolean);
begin
  if newValue <> FUseIcon then
  begin
    FUseIcon := NewValue;
    Repaint;
  end;
end;

function TElButtonGlyph.GetGlyphSize : TRect;
var
  IconInfo : TIconInfo;
  ABMP : Windows.TBitmap;
begin
  if FUseImageList then
  begin
    result := Rect(0, 0, FImageList.Width, FImageList.Height);
  end
  else
  if UseIcon then
  begin
    GetIconInfo(Icon.Handle, IconInfo);
    GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
    result := Rect(0, 0, ABMP.bmWidth, ABMP.bmHeight);
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
  end
  else
    result := Rect(0, 0, FOriginal.Width div FNumGlyphs, FOriginal.Height);
end;

function TElButtonGlyph.CalcButtonWidth(Canvas : TCanvas; var MaxHeight :
    integer; const Offset : TPoint; const Caption : TElFString; Layout :
    TButtonLayout; Margin, Spacing : Integer; ShowGlyph, ShowText, MultiLine :
    boolean; ArrowWidth : integer; UseThemesForText : boolean; Theme : HTheme;
    ThemePart, ThemeState : integer; ShowAccelChar : boolean
    ): Integer;
var AGraphic : TGraphic;
    IcW,
      IcH : Integer;
    IconInfo : TIconInfo;
    ABMP     : Windows.TBitmap;
    ILBitmap : TBitmap;
    // Spacing  : integer;
    GX, GY   : integer;
    TextSize,
    GlyphSize: TPoint;
    {$ifdef MSWINDOWS}
    Client,
    {$endif}
    TextBounds: TRect;
    {$ifdef MSWINDOWS}
    Flags    : integer;
    {$endif}
begin
  // first get the graphic that will be used as a glyph
  if ShowGlyph then
  begin
    if UseImageList and (FImageList <> nil) then
    begin
      ILBitmap := Tl3Bitmap.Create;
      if FImageIndex <> -1 then
      begin
        ILBitmap.Height := ImageList.Height;
        ILBitmap.Width := ImageList.Width;
      end;
      AGraphic := ILBitmap;
    end
    else
    if UseIcon then
    begin
      GetIconInfo(Icon.Handle, IconInfo);
      GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
      IcH := ABMP.bmHeight;
      IcW := ABMP.bmWidth;
      DeleteObject(IconInfo.hbmColor);
      DeleteObject(IconInfo.hbmMask);
      AGraphic := FIcon;
    end
    else
      AGraphic := FOriginal;
  end
  else
    AGraphic := nil;

  // determine actual graphic size
  if (AGraphic <> nil) then
  begin
    if UseIcon then
    begin
      GX := IcW;
      GY := IcH;
    end
    else
    if AGraphic = ILBitmap then
    begin
      GX := AGraphic.Width;
      GY := AGraphic.Height;
    end
    else
    begin
      GX := AGraphic.Width div FNumGlyphs;
      GY := AGraphic.Height;
    end;

    if MaxHeight <> 0 then
      if GY > MaxHeight then
      begin
        GY := MaxHeight - 2;
        GX := MulDiv(GX, GY, MaxHeight);
        FStretched := true;
      end;
    if FStretched then
    begin
      FStrW := GX;
      FStrH := GY;
    end;
    GlyphSize := Point(GX, GY);
  end
  else
    GlyphSize := Point(0, 0);

  // calculate text size
  if (Length(Caption) > 0) and (ShowText) then
  begin
    {$ifdef MSWINDOWS}
    if (Theme <> 0) and (UseThemesForText) then
    begin
      TextBounds := Rect(0, 0, 10000, 10000);
      if MultiLine then
        Flags := 0
      else
        Flags := DT_SINGLELINE;

      GetThemeTextExtent(Theme, Canvas.Handle, ThemePart, ThemeState, PWideChar(WideString(Caption)), Length(WideString(Caption)), Flags, @Client, TextBounds);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom - TextBounds.Top);
    end
    else
    {$endif}
    begin
      TextBounds := Rect(0, 0, 10000, 10000);
      if MultiLine then
        Flags := DT_CALCRECT
      else
        Flags := DT_CALCRECT + DT_SINGLELINE;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;

      {$ifdef ELPACK_UNICODE}
      ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), TextBounds, Flags);
      {$else}
      DrawText(Canvas.Handle, PChar(Caption), Length(Caption), TextBounds, Flags);
      {$endif}
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
        TextBounds.Top);
    end;
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0
  else
  if Spacing = -1 then
    Spacing := 2;

  if Margin = -1 then
    Margin := 2;

  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
     result := TextSize.X + GlyphSize.X + Margin * 2 + Spacing;
     if MaxHeight = 0 then
       MaxHeight := Max(TextSize.Y, GlyphSize.Y) + Margin * 2;
  end
  else
  begin
     result := Max(TextSize.X, GlyphSize.X) + Margin * 2;
     if MaxHeight = 0 then
       MaxHeight := TextSize.Y + GlyphSize.Y + Margin * 2 + Spacing;
  end;
  inc(Result, ArrowWidth);
  if ShowGLyph and UseImageList and (FImageList <> nil) then
   l3Free(ILBitmap);
end;

end.
