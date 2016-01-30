unit vtPngImgList;

// Модуль: "w:\common\components\gui\Garant\VT\vtPngImgList.pas"
// Стереотип: "UtilityPack"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , vtInterfaces
 , vtPngImgListUtils
 {$If NOT Defined(NoImageEn)}
 , hyieutils
 {$IfEnd} // NOT Defined(NoImageEn)
 , l3InternalInterfaces
 , l3PrinterInterfaces
 , l3Core
 , Graphics
 , Classes
 , Types
;

type
 //#UC START# *4ACB4A5201FCci*
 //#UC END# *4ACB4A5201FCci*
 //#UC START# *4ACB4A5201FCcit*
 //#UC END# *4ACB4A5201FCcit*
 TvtNonFixedPngImageListPrim = class(TCustomImageList, IvtFlashImageList)
  private
   f_Glyph: TaBPPGlyphs;
   f_OldHeight: Integer;
   f_OldWidth: Integer;
   f_NeedPrepareAlphaDrawCache: Boolean;
   f_Rebuilding: Boolean;
   f_DrawCache: TBitmap;
   f_AlphaDrawCache: TBitmap;
   f_Count: Integer;
    {* Поле для свойства Count }
   f_CurBPP: TvtPILBpp;
    {* Поле для свойства CurBPP }
  private
   procedure CalcCount;
   procedure ResizeAll(aCount: Integer);
   function CanAlphaDraw(aBpp: TvtPILBpp): Boolean;
   procedure ClearAlphaDrawCache;
  protected
   procedure pm_SetCurBPP(aValue: TvtPILBpp);
   procedure Draw(Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Index: TImageIndex;
    Enabled: Boolean = True;
    HalfTransparent: Boolean = True);
   procedure SaveImageToStream(aStream: TStream;
    aIndex: TImageIndex;
    aBpp: TvtPILBpp);
   {$If NOT Defined(NoVCL)}
   procedure Change; override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DefineProperties(Filer: TFiler); override;
   {$If NOT Defined(NoVCL)}
   procedure ReadData(Stream: TStream); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure WriteData(Stream: TStream); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure WriteState(Writer: TWriter); override;
  public
   procedure ClearCache;
   function AddItem: Integer;
   procedure Delete(aIndex: Integer);
   procedure AddImage(Index: Integer;
    Bpp: TvtPILBpp;
    Image: TIEBitmap);
   procedure GetImage(Index: Integer;
    Bpp: TvtPILBpp;
    Image: TIEBitmap);
   procedure Clear;
   procedure DrawGlyphSpecified(Index: Integer;
    const Canvas: Il3Canvas;
    Bpp: TvtPILBpp;
    X: Integer;
    Y: Integer;
    Enabled: Boolean); overload;
   procedure DrawGlyphSpecified(Index: Integer;
    Canvas: TCanvas;
    Bpp: TvtPILBpp;
    X: Integer;
    Y: Integer;
    Enabled: Boolean;
    HalfTransparent: Boolean = False); overload;
   procedure SaveImage(const aFilename: AnsiString;
    aIndex: Integer;
    aBpp: TvtPILBpp);
   procedure Exchange(Index1: Integer;
    Index2: Integer);
   {$If Defined(DesignTimeLibrary)}
   function ImageExtent(anIndex: Integer): TPoint;
   {$IfEnd} // Defined(DesignTimeLibrary)
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   {$If NOT Defined(NoVCL)}
   procedure DoDraw(Index: Integer;
    Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Style: Cardinal;
    Enabled: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
   function ImageExtent(anIndex: Integer): TPoint; override;
   {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)
   {$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
   function IsSmart: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)
  public
   property Count: Integer
    read f_Count;
   property CurBPP: TvtPILBpp
    read f_CurBPP
    write pm_SetCurBPP;
    {* default bpp24 }
 //#UC START# *4ACB4A5201FCpubl*
  {$IFDEF DesignTimeLibrary}
  procedure RebuildForDesignTime;
  {$ENDIF}
   {$ifndef DesignTimeLibrary}
   {$IfNDef XE}
  protected
   function GetCount: Integer; override;
   {$EndIf}
   {$endif}
 //#UC END# *4ACB4A5201FCpubl*
 end;//TvtNonFixedPngImageListPrim

 TvtBPPGlyphs = array [TvtPILBpp] of TIEBitmap;

 TvtSizeBPPGlyphs = array [TvtPILSize] of TvtBPPGlyphs;

 TvtPILSizeBitmapArray = array [TvtPILSize] of TBitmap;

 TvtPILSizeBoolArray = array [TvtPILSize] of Boolean;

 //#UC START# *4FD0A98C01BDci*
 //#UC END# *4FD0A98C01BDci*
 //#UC START# *4FD0A98C01BDcit*
 //#UC END# *4FD0A98C01BDcit*
 TvtPngImageListPrim = class(TCustomImageList, IvtFlashImageList)
  private
   f_ChangeOn: Boolean;
   f_Glyph: TvtSizeBPPGlyphs;
   f_DrawCache: TvtPILSizeBitmapArray;
   f_AlphaDrawCache: TvtPILSizeBitmapArray;
   f_NeedPrepareAlphaDrawCache: TvtPILSizeBoolArray;
   f_Rebuilding: Boolean;
   f_AvailableSizes: TvtPILSizes;
    {* Поле для свойства AvailableSizes }
   f_Count: Integer;
    {* Поле для свойства Count }
   f_CurBPP: TvtPILBpp;
    {* Поле для свойства CurBPP }
   f_CurSize: TvtPILSize;
    {* Поле для свойства CurSize }
  private
   procedure CalcCount(UseNewSizes: Boolean = True);
   procedure ResizeAll(aCount: Integer);
   function CanAlphaDraw(aBpp: TvtPILBpp;
    aSize: TvtPILSize): Boolean;
   procedure ClearAlphaDrawCache;
  protected
   procedure pm_SetAvailableSizes(aValue: TvtPILSizes); virtual;
   function pm_GetCount: Integer; virtual;
   procedure pm_SetCurBPP(aValue: TvtPILBpp);
   procedure pm_SetCurSize(aValue: TvtPILSize);
   procedure Draw(Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Index: TImageIndex;
    Enabled: Boolean = True;
    HalfTransparent: Boolean = True);
   procedure SaveImageToStream(aStream: TStream;
    aIndex: TImageIndex;
    aBpp: TvtPILBpp);
   {$If NOT Defined(NoVCL)}
   procedure Change; override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DefineProperties(Filer: TFiler); override;
   {$If NOT Defined(NoVCL)}
   procedure ReadData(Stream: TStream); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure WriteData(Stream: TStream); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure WriteState(Writer: TWriter); override;
  public
   procedure ClearCache;
   function AddItem: Integer;
   procedure Delete(aIndex: Integer);
   procedure AddImage(Index: Integer;
    Size: TvtPILSize;
    Bpp: TvtPILBpp;
    Image: TIEBitmap);
   procedure DrawGlyphSpecified(Index: Integer;
    const Canvas: Il3Canvas;
    Size: TvtPILSize;
    Bpp: TvtPILBpp;
    X: Integer;
    Y: Integer;
    Enabled: Boolean); overload;
   procedure Exchange(Index1: Integer;
    Index2: Integer);
   procedure _RepairSizes;
   procedure Clear;
   procedure CopySizeToSize(aSizeFrom: TvtPILSize;
    aSizeTo: TvtPILSize);
   procedure SaveImage(const aFilename: AnsiString;
    aIndex: Integer;
    aSize: TvtPILSize;
    aBpp: TvtPILBpp);
   procedure DrawGlyphSpecified(Index: Integer;
    Canvas: TCanvas;
    Size: TvtPILSize;
    Bpp: TvtPILBpp;
    X: Integer;
    Y: Integer;
    Enabled: Boolean;
    HalfTransparent: Boolean = False); overload;
   {$If Defined(DesignTimeLibrary)}
   function ImageExtent(anIndex: Integer): TPoint;
   {$IfEnd} // Defined(DesignTimeLibrary)
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   {$If NOT Defined(NoVCL)}
   procedure DoDraw(Index: Integer;
    Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Style: Cardinal;
    Enabled: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
   function ImageExtent(anIndex: Integer): TPoint; override;
   {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)
   {$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
   function IsSmart: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)
  public
   property AvailableSizes: TvtPILSizes
    read f_AvailableSizes
    write pm_SetAvailableSizes;
   property Count: Integer
    read pm_GetCount;
   property CurBPP: TvtPILBpp
    read f_CurBPP
    write pm_SetCurBPP;
   property CurSize: TvtPILSize
    read f_CurSize
    write pm_SetCurSize;
 //#UC START# *4FD0A98C01BDpubl*
  {$IFDEF DesignTimeLibrary}
  procedure RebuildForDesignTime;
  {$ENDIF}
   {$ifndef DesignTimeLibrary}
   {$IfNDef XE}
  protected
   function GetCount: Integer; override;
   {$EndIf}
   {$endif}
 //#UC END# *4FD0A98C01BDpubl*
 end;//TvtPngImageListPrim

 //#UC START# *4FD0BFBC00F9ci*
 //#UC END# *4FD0BFBC00F9ci*
 //#UC START# *4FD0BFBC00F9cit*
 //#UC END# *4FD0BFBC00F9cit*
 TvtFixedSizeProxyPngImageListPrim = class(TCustomImageList, IvtFlashImageList)
  private
   f_ImageChangeLink: TChangeLink;
   f_FixedSize: TvtPILSize;
    {* Поле для свойства FixedSize }
   f_OriginalImgList: TvtPngImageListPrim;
    {* Поле для свойства OriginalImgList }
  private
   procedure ImageListChange(Sender: TObject);
  protected
   procedure pm_SetFixedSize(aValue: TvtPILSize);
   procedure pm_SetOriginalImgList(aValue: TvtPngImageListPrim);
   function pm_GetCount: Integer; virtual;
   procedure Draw(Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Index: TImageIndex;
    Enabled: Boolean = True;
    HalfTransparent: Boolean = True);
   procedure SaveImageToStream(aStream: TStream;
    aIndex: TImageIndex;
    aBpp: TvtPILBpp);
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   {$If NOT Defined(NoVCL)}
   procedure DoDraw(Index: Integer;
    Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Style: Cardinal;
    Enabled: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
   function IsSmart: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)
  public
   property FixedSize: TvtPILSize
    read f_FixedSize
    write pm_SetFixedSize;
   property OriginalImgList: TvtPngImageListPrim
    read f_OriginalImgList
    write pm_SetOriginalImgList;
   property Count: Integer
    read pm_GetCount;
 //#UC START# *4FD0BFBC00F9publ*
   {$ifndef DesignTimeLibrary}
   {$IfNDef XE}
  protected
   function GetCount: Integer; override;
   {$EndIf}
   {$endif}
 //#UC END# *4FD0BFBC00F9publ*
 end;//TvtFixedSizeProxyPngImageListPrim

 //#UC START# *4FD224430014ci*
 //#UC END# *4FD224430014ci*
 //#UC START# *4FD224430014cit*
 //#UC END# *4FD224430014cit*
 TvtNonFixedPngImageList = class(TvtNonFixedPngImageListPrim)
 //#UC START# *4FD224430014publ*
 published
  property CurBpp;
  property Width;
  property Height;
 //#UC END# *4FD224430014publ*
 end;//TvtNonFixedPngImageList

 //#UC START# *4FD2246B017Bci*
 //#UC END# *4FD2246B017Bci*
 //#UC START# *4FD2246B017Bcit*
 //#UC END# *4FD2246B017Bcit*
 TvtPngImageList = class(TvtPngImageListPrim)
 //#UC START# *4FD2246B017Bpubl*
 published
  property AvailableSizes;
  property CurBpp;
  property CurSize;
 //#UC END# *4FD2246B017Bpubl*
 end;//TvtPngImageList

 //#UC START# *4FD2248F001Bci*
 //#UC END# *4FD2248F001Bci*
 //#UC START# *4FD2248F001Bcit*
 //#UC END# *4FD2248F001Bcit*
 TvtFixedSizeProxyPngImageList = class(TvtFixedSizeProxyPngImageListPrim)
 //#UC START# *4FD2248F001Bpubl*
 published
  property FixedSize;
  property OriginalImgList;
 //#UC END# *4FD2248F001Bpubl*
 end;//TvtFixedSizeProxyPngImageList

 TBitmap = vtPngImgListUtils.TBitmap;

implementation

uses
 l3ImplUses
 , l3Bitmap
 , l3Base
 {$If NOT Defined(NoImageEn)}
 , hyiedefs
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 , l3ObjectList
 , SysUtils
;

var g_BlendOp: TBlendFunction = (BlendOp: AC_SRC_OVER; BlendFlags: 0; SourceConstantAlpha: cFullAlpha; AlphaFormat: AC_SRC_ALPHA);

procedure TvtNonFixedPngImageListPrim.pm_SetCurBPP(aValue: TvtPILBpp);
//#UC START# *4FD089B50350_4ACB4A5201FCset_var*
//#UC END# *4FD089B50350_4ACB4A5201FCset_var*
begin
//#UC START# *4FD089B50350_4ACB4A5201FCset_impl*
 if f_CurBpp <> aValue then
 begin
  f_CurBpp := aValue;
  Change;
 end;
//#UC END# *4FD089B50350_4ACB4A5201FCset_impl*
end;//TvtNonFixedPngImageListPrim.pm_SetCurBPP

procedure TvtNonFixedPngImageListPrim.CalcCount;
//#UC START# *4FD08DA20340_4ACB4A5201FC_var*
//#UC END# *4FD08DA20340_4ACB4A5201FC_var*
begin
//#UC START# *4FD08DA20340_4ACB4A5201FC_impl*
 f_Count := f_Glyph[bpp24].Width div Width;
//#UC END# *4FD08DA20340_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.CalcCount

procedure TvtNonFixedPngImageListPrim.ResizeAll(aCount: Integer);
//#UC START# *4FD08DBD02AD_4ACB4A5201FC_var*
var
 lBpp: TvtPILBpp;
//#UC END# *4FD08DBD02AD_4ACB4A5201FC_var*
begin
//#UC START# *4FD08DBD02AD_4ACB4A5201FC_impl*
 for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  if aCount = 0
   then f_Glyph[lBpp].Resize(1, 1, 0, 0, iehLeft, ievTop)
   else f_Glyph[lBpp].Resize(aCount * Width, Height, 0, 0, iehLeft, ievTop);
//#UC END# *4FD08DBD02AD_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.ResizeAll

function TvtNonFixedPngImageListPrim.CanAlphaDraw(aBpp: TvtPILBpp): Boolean;
//#UC START# *4FD08E070341_4ACB4A5201FC_var*
//#UC END# *4FD08E070341_4ACB4A5201FC_var*
begin
//#UC START# *4FD08E070341_4ACB4A5201FC_impl*
 Result := (aBpp = bpp24) and (@g_AlphaBlendFunc <> nil) and Assigned(f_Glyph[bpp24]);
 if Result then
 begin
  if not Assigned(f_AlphaDrawCache) then
  begin
   f_AlphaDrawCache := Tl3Bitmap.Create;
   with f_AlphaDrawCache do
   begin
    Width  := f_Glyph[bpp24].Width;
    Height := f_Glyph[bpp24].Height*2;
    PixelFormat := pf32bit;
   end;
   f_NeedPrepareAlphaDrawCache := True;
  end;
  if f_NeedPrepareAlphaDrawCache then
  begin
   PrepareAlphaBitmap(f_Glyph[bpp24], f_AlphaDrawCache);
   f_NeedPrepareAlphaDrawCache := False;
  end;
 end;
//#UC END# *4FD08E070341_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.CanAlphaDraw

procedure TvtNonFixedPngImageListPrim.ClearAlphaDrawCache;
//#UC START# *4FD08E3902B2_4ACB4A5201FC_var*
//#UC END# *4FD08E3902B2_4ACB4A5201FC_var*
begin
//#UC START# *4FD08E3902B2_4ACB4A5201FC_impl*
 f_NeedPrepareAlphaDrawCache := True;
//#UC END# *4FD08E3902B2_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.ClearAlphaDrawCache

procedure TvtNonFixedPngImageListPrim.ClearCache;
//#UC START# *4FD08E4F0057_4ACB4A5201FC_var*
//#UC END# *4FD08E4F0057_4ACB4A5201FC_var*
begin
//#UC START# *4FD08E4F0057_4ACB4A5201FC_impl*
 l3Free(f_AlphaDrawCache);
 l3Free(f_DrawCache);
//#UC END# *4FD08E4F0057_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.ClearCache

function TvtNonFixedPngImageListPrim.AddItem: Integer;
//#UC START# *4FD092660354_4ACB4A5201FC_var*
//#UC END# *4FD092660354_4ACB4A5201FC_var*
begin
//#UC START# *4FD092660354_4ACB4A5201FC_impl*
 Inc(f_Count);
 ResizeAll(f_Count);
 Result := f_Count;
 Change;
//#UC END# *4FD092660354_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.AddItem

procedure TvtNonFixedPngImageListPrim.Delete(aIndex: Integer);
//#UC START# *4FD09329032F_4ACB4A5201FC_var*
var
 lHowMuch: Integer;
 lTo: Integer;
 lFrom: Integer;
 lBpp: TvtPILBpp;
//#UC END# *4FD09329032F_4ACB4A5201FC_var*
begin
//#UC START# *4FD09329032F_4ACB4A5201FC_impl*
 if (aIndex < 0) or (aIndex > Count-1) then
  Exit;
 if aIndex < (Count-1) then
 begin
  // переносим картинки влево
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  begin
   lFrom := (aIndex+1)*Width;
   lTo := aIndex*Width;
   lHowMuch := (Count-aIndex-1)*Width;
   f_Glyph[lBpp].CopyRectTo(f_Glyph[lBpp], lFrom, 0, lTo, 0,
      lHowMuch, Height);
   f_Glyph[lBpp].AlphaChannel.CopyRectTo(f_Glyph[lBpp].AlphaChannel,
      lFrom, 0, lTo, 0, lHowMuch, Height);
  end;
 end;
 Dec(f_Count);
 ResizeAll(f_Count);
 Change;
//#UC END# *4FD09329032F_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.Delete

procedure TvtNonFixedPngImageListPrim.AddImage(Index: Integer;
 Bpp: TvtPILBpp;
 Image: TIEBitmap);
//#UC START# *4FD0947D03BE_4ACB4A5201FC_var*
var
 lShiftY: Integer;
 lShiftX: Integer;
//#UC END# *4FD0947D03BE_4ACB4A5201FC_var*
begin
//#UC START# *4FD0947D03BE_4ACB4A5201FC_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 lShiftX := (Image.Width - Width) div 2;
 lShiftY := (Image.Height - Height) div 2;

 Image.CopyRectTo(f_Glyph[Bpp], lShiftX, lShiftY, Index*Width, 0, Width, Height);
 Image.AlphaChannel.CopyRectTo(f_Glyph[Bpp].AlphaChannel, lShiftX, lShiftY, Index*Width, 0, Width, Height);
 f_Glyph[Bpp].AlphaChannel.SyncFull;
 ClearAlphaDrawCache;
//#UC END# *4FD0947D03BE_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.AddImage

procedure TvtNonFixedPngImageListPrim.GetImage(Index: Integer;
 Bpp: TvtPILBpp;
 Image: TIEBitmap);
//#UC START# *4FD094A5039B_4ACB4A5201FC_var*
//#UC END# *4FD094A5039B_4ACB4A5201FC_var*
begin
//#UC START# *4FD094A5039B_4ACB4A5201FC_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;

 Image.Width := Width;
 Image.Height := Height;

 f_Glyph[Bpp].CopyRectTo(Image, Index*Width, 0, 0, 0, Width, Height);
 f_Glyph[Bpp].AlphaChannel.CopyRectTo(Image.AlphaChannel, Index*Width, 0, 0, 0, Width, Height);
 Image.AlphaChannel.SyncFull;
//#UC END# *4FD094A5039B_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.GetImage

procedure TvtNonFixedPngImageListPrim.Clear;
//#UC START# *4FD094BC00C9_4ACB4A5201FC_var*
//#UC END# *4FD094BC00C9_4ACB4A5201FC_var*
begin
//#UC START# *4FD094BC00C9_4ACB4A5201FC_impl*
 f_Count := 0;
 ResizeAll(0);
 Change; 
//#UC END# *4FD094BC00C9_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.Clear

procedure TvtNonFixedPngImageListPrim.DrawGlyphSpecified(Index: Integer;
 const Canvas: Il3Canvas;
 Bpp: TvtPILBpp;
 X: Integer;
 Y: Integer;
 Enabled: Boolean);
//#UC START# *4FD094DB01A3_4ACB4A5201FC_var*
//#UC END# *4FD094DB01A3_4ACB4A5201FC_var*
begin
//#UC START# *4FD094DB01A3_4ACB4A5201FC_impl*
 DrawGlyphSpecified(Index, Canvas.Canvas, Bpp, Y, Y, Enabled);
//#UC END# *4FD094DB01A3_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.DrawGlyphSpecified

procedure TvtNonFixedPngImageListPrim.DrawGlyphSpecified(Index: Integer;
 Canvas: TCanvas;
 Bpp: TvtPILBpp;
 X: Integer;
 Y: Integer;
 Enabled: Boolean;
 HalfTransparent: Boolean = False);
//#UC START# *4FD095010268_4ACB4A5201FC_var*
var
 lAlpha: Byte;
 lROP: TIERenderOperation;
 l_CacheTop: Integer;
 l_Painted: Boolean;
//#UC END# *4FD095010268_4ACB4A5201FC_var*
begin
//#UC START# *4FD095010268_4ACB4A5201FC_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 l_Painted := CanAlphaDraw(Bpp);
 if l_Painted then
 begin
  if Enabled then
   l_CacheTop := 0
  else
   l_CacheTop := Height;
  g_BlendOp.SourceConstantAlpha := CalcTransparenctColor(cFullAlpha, HalfTransparent);
  l_Painted := AlphaBlend(Canvas.Handle, X, Y, Width, Height, f_AlphaDrawCache.Canvas.Handle,
                          Index * Width, l_CacheTop, Width, Height, g_BlendOp);
  g_BlendOp.SourceConstantAlpha := cFullAlpha;
 end;
 if not l_Painted then
 begin
  if f_DrawCache = nil then
  begin
   f_DrawCache := Tl3Bitmap.Create;
   with f_DrawCache do
   begin
    Width := Self.Width;
    Height := Self.Height;
    PixelFormat := pf24bit;
    Dormant;
   end;
  end;
  if f_DrawCache.Width <> Width then
   f_DrawCache.Width := Width;
  if f_DrawCache.Height <> Height then
   f_DrawCache.Height := Height;

  with f_DrawCache.Canvas do
  begin
   Brush.Style := bsSolid;
   Brush.Color := clWindow;
   Pen.Style := psClear;
   Rectangle(ClipRect);
  end;
  StretchBlt(f_DrawCache.Canvas.Handle, 0, 0, Width, Height, Canvas.Handle, X, Y,
     Width, Height, SRCCOPY);
  if Enabled then
  begin
   lAlpha := CalcTransparenctColor(cFullAlpha, HalfTransparent);
   lROP := ielNormal;
  end
  else
  begin
   lAlpha := CalcTransparenctColor(cDisabledAlpha, HalfTransparent);
   lROP := ielGreyDown;
  end; {if..}
  f_Glyph[Bpp].RenderToTBitmap(f_DrawCache, 0, 0, Width, Height,
    Index*Width, 0, Width, Height, True, rfNone, True, lAlpha, lROP);
  Canvas.Draw(X, Y, f_DrawCache);
 end;
//#UC END# *4FD095010268_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.DrawGlyphSpecified

procedure TvtNonFixedPngImageListPrim.SaveImage(const aFilename: AnsiString;
 aIndex: Integer;
 aBpp: TvtPILBpp);
//#UC START# *4FD0969703D3_4ACB4A5201FC_var*
var
 l_Img: TIEBitmap;
 l_Src: TIEBitmap;
 l_IO : TImageEnIO;
//#UC END# *4FD0969703D3_4ACB4A5201FC_var*
begin
//#UC START# *4FD0969703D3_4ACB4A5201FC_impl*
 if (aIndex < 0) or (aIndex > Count-1) then
  Exit;
 l_Src := f_Glyph[aBpp];
 l_Img := TIEBitmap.Create;
 try
  l_Img.PixelFormat := l_Src.PixelFormat;
  l_Img.Width := Width + 2; // добавляем "рамочку"
  l_Img.Height := Height + 2;
  l_Img.FillRect(0, 0, Width + 2, Height + 2, $FF00FF);
  l_Img.CreateAlphaChannel;
  l_Img.AlphaChannel.FillRect(0, 0, Width + 2, Height + 2, 0);
  l_Src.CopyRectTo(l_Img, aIndex*Width, 0, 1, 1, Width, Height);
  l_Src.AlphaChannel.CopyRectTo(l_Img.AlphaChannel, aIndex*Width, 0, 1, 1, Width, Height);
  l_Img.AlphaChannel.SyncFull;
  l_IO := TImageEnIO.Create(nil);
  try
   l_IO.AttachedIEBitmap := l_Img;
   l_IO.SaveToFilePNG(aFileName);
  finally
   l3Free(l_IO);
  end;
 finally
  l_Img.Free;
 end;
//#UC END# *4FD0969703D3_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.SaveImage

procedure TvtNonFixedPngImageListPrim.Exchange(Index1: Integer;
 Index2: Integer);
//#UC START# *4FD0A70C03C5_4ACB4A5201FC_var*
var
 lBpp: TvtPILBpp;
 lBMP: TIEBitmap;
//#UC END# *4FD0A70C03C5_4ACB4A5201FC_var*
begin
//#UC START# *4FD0A70C03C5_4ACB4A5201FC_impl*
 lBMP := TIEBitmap.Create;
 try
  lBMP.Height := Width;
  lBMP.Width := Height;
  lBMP.PixelFormat := ie24RGB;
  lBMP.CreateAlphaChannel;
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  begin
   f_Glyph[lBpp].CopyRectTo(lBMP, Index1*Width, 0, 0, 0, Width, Height);
   f_Glyph[lBpp].AlphaChannel.CopyRectTo(lBMP.AlphaChannel, Index1*Width, 0, 0, 0, Width, Height);
   f_Glyph[lBpp].CopyRectTo(f_Glyph[lBpp], Index2*Width, 0, Index1*Width, 0, Width, Height);
   f_Glyph[lBpp].AlphaChannel.CopyRectTo(f_Glyph[lBpp].AlphaChannel, Index2*Width, 0, Index1*Width, 0, Width, Height);
   lBMP.CopyRectTo(f_Glyph[lBpp], 0, 0, Index2*Width, 0, Width, Height);
   lBMP.AlphaChannel.CopyRectTo(f_Glyph[lBpp].AlphaChannel, 0, 0, Index2*Width, 0, Width, Height);
  end;
 finally
  lBMP.Free;
 end;
 Change;
//#UC END# *4FD0A70C03C5_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.Exchange

{$If Defined(DesignTimeLibrary)}
function TvtNonFixedPngImageListPrim.ImageExtent(anIndex: Integer): TPoint;
//#UC START# *5025442B0365_4ACB4A5201FC_var*
//#UC END# *5025442B0365_4ACB4A5201FC_var*
begin
//#UC START# *5025442B0365_4ACB4A5201FC_impl*
 Result.X := Width;
 Result.Y := Height;
//#UC END# *5025442B0365_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.ImageExtent
{$IfEnd} // Defined(DesignTimeLibrary)

procedure TvtNonFixedPngImageListPrim.Draw(Canvas: TCanvas;
 X: Integer;
 Y: Integer;
 Index: TImageIndex;
 Enabled: Boolean = True;
 HalfTransparent: Boolean = True);
//#UC START# *4F950C6D03BE_4ACB4A5201FC_var*
//#UC END# *4F950C6D03BE_4ACB4A5201FC_var*
begin
//#UC START# *4F950C6D03BE_4ACB4A5201FC_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 DrawGlyphSpecified(Index, Canvas, f_CurBpp, X, Y, Enabled, HalfTransparent);
//#UC END# *4F950C6D03BE_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.Draw

procedure TvtNonFixedPngImageListPrim.SaveImageToStream(aStream: TStream;
 aIndex: TImageIndex;
 aBpp: TvtPILBpp);
//#UC START# *53282D3E0350_4ACB4A5201FC_var*
var
 l_Img: TIEBitmap;
 l_Src: TIEBitmap;
 l_IO: TImageEnIO;
//#UC END# *53282D3E0350_4ACB4A5201FC_var*
begin
//#UC START# *53282D3E0350_4ACB4A5201FC_impl*
 Assert(Assigned(aStream));
 if (aIndex < 0) or (aIndex > Count - 1) then
  Exit;
 l_Src := f_Glyph[aBpp];
 l_Img := TIEBitmap.Create;
 try
  l_Img.PixelFormat := l_Src.PixelFormat;
  l_Img.Width := Width;
  l_Img.Height := Height;
  l_Img.FillRect(0, 0, Width, Height, $FF00FF);
  l_Img.CreateAlphaChannel;
  l_Img.AlphaChannel.FillRect(0, 0, Width, Height, 0);
  l_Src.CopyRectTo(l_Img, aIndex * Width, 0, 0, 0, Width, Height);
  l_Src.AlphaChannel.CopyRectTo(l_Img.AlphaChannel, aIndex * Width, 0, 0, 0, Width, Height);
  l_Img.AlphaChannel.SyncFull;
  l_IO := TImageEnIO.Create(nil);
  try
   l_IO.AttachedIEBitmap := l_Img;
   l_IO.SaveToStreamPNG(aStream);
  finally
   l3Free(l_IO);
  end;
 finally
  l_Img.Free;
 end;
//#UC END# *53282D3E0350_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.SaveImageToStream

constructor TvtNonFixedPngImageListPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4ACB4A5201FC_var*
var
 lBpp: TvtPILBpp;
//#UC END# *47D1602000C6_4ACB4A5201FC_var*
begin
//#UC START# *47D1602000C6_4ACB4A5201FC_impl*
 inherited;
 for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
 begin
  f_Glyph[lBpp] := TIEBitmap.Create;
  with f_Glyph[lBpp] do
  begin
   PixelFormat := ie24RGB;
   CreateAlphaChannel;
   Location := ieFile;
   MinFileSize := 51200;
   Width := 1;
   Height := 1;
  end;
 end;
 f_OldWidth := 16;
 f_OldHeight := 16;
 Width := 16;
 Height := 16;
 f_CurBpp := bpp24;
 f_Count := 0;
 f_Rebuilding := false;
 HandleNeeded;
 if g_PILList = nil then
  g_PILList := Tl3ObjectList.Make;
 g_PILList.Add(Self);
//#UC END# *47D1602000C6_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.Create

destructor TvtNonFixedPngImageListPrim.Destroy;
//#UC START# *48077504027E_4ACB4A5201FC_var*
var
 lBpp: TvtPILBpp;
//#UC END# *48077504027E_4ACB4A5201FC_var*
begin
//#UC START# *48077504027E_4ACB4A5201FC_impl*
 for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  l3Free(f_Glyph[lBpp]);
 l3Free(f_DrawCache);
 g_PILList.Remove(Self);
 if g_PILList.Count = 0 then
  l3Free(g_PILList);
 l3Free(f_AlphaDrawCache);
 inherited Destroy;
//#UC END# *48077504027E_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.Destroy

{$If NOT Defined(NoVCL)}
procedure TvtNonFixedPngImageListPrim.Change;
//#UC START# *4FD08E8503DC_4ACB4A5201FC_var*
//#UC END# *4FD08E8503DC_4ACB4A5201FC_var*
begin
//#UC START# *4FD08E8503DC_4ACB4A5201FC_impl*
 inherited;
 if ((Width <> f_OldWidth) or (Height <> f_OldHeight)) and (f_Glyph[bpp24] <> nil) then
 begin
  f_Count := 0;
  ResizeAll(0);
  f_OldWidth := Width;
  f_OldHeight := Height;
 end;
 ClearAlphaDrawCache;
//#UC END# *4FD08E8503DC_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.Change
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtNonFixedPngImageListPrim.DefineProperties(Filer: TFiler);
//#UC START# *4FD08EF002D0_4ACB4A5201FC_var*
  function DoWrite: Boolean;
  begin
    {if Filer.Ancestor <> nil then
      Result := not (Filer.Ancestor is TCustomImageList) or
        not Equal(TCustomImageList(Filer.Ancestor))
    else}
      Result := Count > 0;
  end;
//#UC END# *4FD08EF002D0_4ACB4A5201FC_var*
begin
//#UC START# *4FD08EF002D0_4ACB4A5201FC_impl*
 inherited DefineProperties(Filer);
 Filer.DefineBinaryProperty('PNGData', ReadData, WriteData, DoWrite);
//#UC END# *4FD08EF002D0_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.DefineProperties

{$If NOT Defined(NoVCL)}
procedure TvtNonFixedPngImageListPrim.ReadData(Stream: TStream);
//#UC START# *4FD08F7F01AD_4ACB4A5201FC_var*
var
 lBpp: TvtPILBpp;
 IO: TImageEnIO;
//#UC END# *4FD08F7F01AD_4ACB4A5201FC_var*
begin
//#UC START# *4FD08F7F01AD_4ACB4A5201FC_impl*
 IO := TImageEnIO.Create(nil);
 try
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  begin
   IO.AttachedIEBitmap := f_Glyph[lBpp];
   IO.LoadFromStreamPNG(Stream);
  end;
 finally
  IO.Free;
 end;
 CalcCount;
 {$IFDEF DesignTimeLibrary}
 RebuildForDesignTime;
 {$ENDIF}
//#UC END# *4FD08F7F01AD_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.ReadData
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtNonFixedPngImageListPrim.WriteData(Stream: TStream);
//#UC START# *4FD08FA7008C_4ACB4A5201FC_var*
var
 lBpp: TvtPILBpp;
 IO: TImageEnIO;
//#UC END# *4FD08FA7008C_4ACB4A5201FC_var*
begin
//#UC START# *4FD08FA7008C_4ACB4A5201FC_impl*
 IO := TImageEnIO.Create(nil);
 try
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  begin
   IO.AttachedIEBitmap := f_Glyph[lBpp];
   IO.SaveToStreamPNG(Stream);
  end;
 finally
  IO.Free;
 end;
//#UC END# *4FD08FA7008C_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.WriteData
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtNonFixedPngImageListPrim.WriteState(Writer: TWriter);
//#UC START# *4FD092040227_4ACB4A5201FC_var*
//#UC END# *4FD092040227_4ACB4A5201FC_var*
begin
//#UC START# *4FD092040227_4ACB4A5201FC_impl*
 {$IFDEF DesignTimeLibrary}
 inherited Clear;
 {$ENDIF}
 inherited;
//#UC END# *4FD092040227_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.WriteState

{$If NOT Defined(NoVCL)}
procedure TvtNonFixedPngImageListPrim.DoDraw(Index: Integer;
 Canvas: TCanvas;
 X: Integer;
 Y: Integer;
 Style: Cardinal;
 Enabled: Boolean);
//#UC START# *4FD093CB025F_4ACB4A5201FC_var*
//#UC END# *4FD093CB025F_4ACB4A5201FC_var*
begin
//#UC START# *4FD093CB025F_4ACB4A5201FC_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 DrawGlyphSpecified(Index, Canvas, f_CurBpp, X, Y, Enabled);
//#UC END# *4FD093CB025F_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.DoDraw
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
function TvtNonFixedPngImageListPrim.ImageExtent(anIndex: Integer): TPoint;
//#UC START# *4FD0944D0202_4ACB4A5201FC_var*
//#UC END# *4FD0944D0202_4ACB4A5201FC_var*
begin
//#UC START# *4FD0944D0202_4ACB4A5201FC_impl*
 Result.X := Width;
 Result.Y := Height;
//#UC END# *4FD0944D0202_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.ImageExtent
{$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)

{$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
function TvtNonFixedPngImageListPrim.IsSmart: Boolean;
//#UC START# *4FD095D20217_4ACB4A5201FC_var*
//#UC END# *4FD095D20217_4ACB4A5201FC_var*
begin
//#UC START# *4FD095D20217_4ACB4A5201FC_impl*
 Result := True;
//#UC END# *4FD095D20217_4ACB4A5201FC_impl*
end;//TvtNonFixedPngImageListPrim.IsSmart
{$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)

//#UC START# *4ACB4A5201FCimpl*
{$ifndef DesignTimeLibrary}
{$IfNDef XE}
function TvtNonFixedPngImageListPrim.GetCount: Integer;
begin
 Result := f_Count;
end;
{$endif}
{$endif}
//#UC END# *4ACB4A5201FCimpl*

procedure TvtPngImageListPrim.pm_SetAvailableSizes(aValue: TvtPILSizes);
//#UC START# *4FD0A9FC01F1_4FD0A98C01BDset_var*
var
 lSize: TvtPILSize;

 procedure TrimSize(aSize: TvtPILSize);
 var
  lBpp: TvtPILBpp;
 begin
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   f_Glyph[aSize, lBpp].Resize(1, 1, 0, 0, iehLeft, ievTop);
 end;

 procedure RebuildSize(aSize: TvtPILSize);
 var
  lBpp: TvtPILBpp;
 begin
  if f_Count = 0 then
   Exit;
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   f_Glyph[aSize, lBpp].Resize(f_Count*PILSize[aSize], PILSize[aSize], 0, 0, iehLeft, ievTop);
 end;
//#UC END# *4FD0A9FC01F1_4FD0A98C01BDset_var*
begin
//#UC START# *4FD0A9FC01F1_4FD0A98C01BDset_impl*
 if f_AvailableSizes <> aValue then
 begin
  for lSize := Low(TvtPILSize) to High(TvtPILSize) do
  begin
   if (lSize in f_AvailableSizes) and not (lSize in aValue) then
    TrimSize(lSize)
   else
    if not (lSize in f_AvailableSizes) and (lSize in aValue) then
     RebuildSize(lSize);
  end;
  f_AvailableSizes := aValue;
  Change;
 end;
//#UC END# *4FD0A9FC01F1_4FD0A98C01BDset_impl*
end;//TvtPngImageListPrim.pm_SetAvailableSizes

function TvtPngImageListPrim.pm_GetCount: Integer;
//#UC START# *4FD0AA8C002B_4FD0A98C01BDget_var*
//#UC END# *4FD0AA8C002B_4FD0A98C01BDget_var*
begin
//#UC START# *4FD0AA8C002B_4FD0A98C01BDget_impl*
 Result := f_Count;
//#UC END# *4FD0AA8C002B_4FD0A98C01BDget_impl*
end;//TvtPngImageListPrim.pm_GetCount

procedure TvtPngImageListPrim.pm_SetCurBPP(aValue: TvtPILBpp);
//#UC START# *4FD0ACBB038A_4FD0A98C01BDset_var*
//#UC END# *4FD0ACBB038A_4FD0A98C01BDset_var*
begin
//#UC START# *4FD0ACBB038A_4FD0A98C01BDset_impl*
 if f_CurBpp <> aValue then
 begin
  f_CurBpp := aValue;
  Change;
 end;
//#UC END# *4FD0ACBB038A_4FD0A98C01BDset_impl*
end;//TvtPngImageListPrim.pm_SetCurBPP

procedure TvtPngImageListPrim.pm_SetCurSize(aValue: TvtPILSize);
//#UC START# *4FD0ACFD0363_4FD0A98C01BDset_var*
//#UC END# *4FD0ACFD0363_4FD0A98C01BDset_var*
begin
//#UC START# *4FD0ACFD0363_4FD0A98C01BDset_impl*
 if (f_CurSize <> aValue) and (aValue in f_AvailableSizes) then
 begin
  f_CurSize := aValue;
  f_ChangeOn := False;
  try
   Width := PILSize[f_CurSize];
   Height := PILSize[f_CurSize];
  finally
   f_ChangeOn := True;
  end; {try..finally}
  Change;
 end;
//#UC END# *4FD0ACFD0363_4FD0A98C01BDset_impl*
end;//TvtPngImageListPrim.pm_SetCurSize

procedure TvtPngImageListPrim.CalcCount(UseNewSizes: Boolean = True);
//#UC START# *4FD0B13F0065_4FD0A98C01BD_var*
var
 lSize: TvtPILSize;
//#UC END# *4FD0B13F0065_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B13F0065_4FD0A98C01BD_impl*
 f_Count := 0;
 for lSize := Low(TvtPILSize) to High(TvtPILSize) do
 begin
  if lSize in AvailableSizes then
  begin
   if UseNewSizes then
    f_Count := f_Glyph[lSize, bpp24].Width div PILSize[lSize]
   else
    f_Count := f_Glyph[lSize, bpp24].Width div OldPILSize[lSize];
   Break;
  end;
 end;
//#UC END# *4FD0B13F0065_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.CalcCount

procedure TvtPngImageListPrim.ResizeAll(aCount: Integer);
//#UC START# *4FD0B1C601D7_4FD0A98C01BD_var*
var
 lBpp: TvtPILBpp;
 lSize: TvtPILSize;
//#UC END# *4FD0B1C601D7_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B1C601D7_4FD0A98C01BD_impl*
 for lSize := Low(TvtPILSize) to High(TvtPILSize) do
  if lSize in f_AvailableSizes then
  begin
   for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   begin
    if aCount = 0 then
     f_Glyph[lSize, lBpp].Resize(1, 1, 0, 0, iehLeft, ievTop)
    else
     f_Glyph[lSize, lBpp].Resize(aCount*PILSize[lSize], PILSize[lSize], 0, 0, iehLeft, ievTop);
   end;
  end; {if..}
//#UC END# *4FD0B1C601D7_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.ResizeAll

function TvtPngImageListPrim.CanAlphaDraw(aBpp: TvtPILBpp;
 aSize: TvtPILSize): Boolean;
//#UC START# *4FD0B1FB01EA_4FD0A98C01BD_var*
//#UC END# *4FD0B1FB01EA_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B1FB01EA_4FD0A98C01BD_impl*
 Result := not f_Rebuilding and (aBpp = bpp24) and (@g_AlphaBlendFunc <> nil) and Assigned(f_Glyph[aSize, bpp24]);
 if Result then
 begin
  if f_AlphaDrawCache[aSize] = nil then
  begin
   f_AlphaDrawCache[aSize] := Tl3Bitmap.Create;
   with f_AlphaDrawCache[aSize] do
   begin
    Width  := f_Glyph[aSize, bpp24].Width;
    Height := f_Glyph[aSize, bpp24].Height*2;
    PixelFormat := pf32bit;
   end;
   f_NeedPrepareAlphaDrawCache[aSize] := True;
  end;
  if f_NeedPrepareAlphaDrawCache[aSize] then
  begin
   PrepareAlphaBitmap(f_Glyph[aSize, bpp24], f_AlphaDrawCache[aSize]);
   f_NeedPrepareAlphaDrawCache[aSize] := False;
  end;
 end;
//#UC END# *4FD0B1FB01EA_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.CanAlphaDraw

procedure TvtPngImageListPrim.ClearAlphaDrawCache;
//#UC START# *4FD0B21900E8_4FD0A98C01BD_var*
var
 l_Size: TvtPILSize;
//#UC END# *4FD0B21900E8_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B21900E8_4FD0A98C01BD_impl*
 if not f_Rebuilding then
  for l_Size := Low(TvtPILSize) to High(TvtPILSize) do
   f_NeedPrepareAlphaDrawCache[l_Size] := True;
//#UC END# *4FD0B21900E8_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.ClearAlphaDrawCache

procedure TvtPngImageListPrim.ClearCache;
//#UC START# *4FD0B23002E8_4FD0A98C01BD_var*
var
 l_Size: TvtPILSize;
//#UC END# *4FD0B23002E8_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B23002E8_4FD0A98C01BD_impl*
 for l_Size := Low(TvtPILSize) to High(TvtPILSize) do
 begin
  l3Free(f_AlphaDrawCache[l_Size]);
  l3Free(f_DrawCache[l_Size]);
 end;
//#UC END# *4FD0B23002E8_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.ClearCache

function TvtPngImageListPrim.AddItem: Integer;
//#UC START# *4FD0B2980233_4FD0A98C01BD_var*
//#UC END# *4FD0B2980233_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B2980233_4FD0A98C01BD_impl*
 Inc(f_Count);
 ResizeAll(f_Count);
 Result := f_Count;
 Change;
//#UC END# *4FD0B2980233_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.AddItem

procedure TvtPngImageListPrim.Delete(aIndex: Integer);
//#UC START# *4FD0B2F50112_4FD0A98C01BD_var*
var
 lHowMuch: Integer;
 lTo: Integer;
 lFrom: Integer;
 lBpp: TvtPILBpp;
 lSize: TvtPILSize;
//#UC END# *4FD0B2F50112_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B2F50112_4FD0A98C01BD_impl*
 if (aIndex < 0) or (aIndex > Count-1) then
  Exit;
 if aIndex < (Count-1) then
 begin
  // переносим картинки влево
  for lSize := Low(TvtPILSize) to High(TvtPILSize) do
   for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   begin
    lFrom := (aIndex+1)*PILSize[lSize];
    lTo := aIndex*PILSize[lSize];
    lHowMuch := (Count-aIndex-1)*PILSize[lSize];
    f_Glyph[lSize, lBpp].CopyRectTo(f_Glyph[lSize, lBpp], lFrom, 0, lTo, 0,
       lHowMuch, PILSize[lSize]);
    f_Glyph[lSize, lBpp].AlphaChannel.CopyRectTo(f_Glyph[lSize, lBpp].AlphaChannel,
       lFrom, 0, lTo, 0, lHowMuch, PILSize[lSize]);
   end;
 end;
 Dec(f_Count);
 ResizeAll(f_Count);
 Change;
//#UC END# *4FD0B2F50112_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.Delete

procedure TvtPngImageListPrim.AddImage(Index: Integer;
 Size: TvtPILSize;
 Bpp: TvtPILBpp;
 Image: TIEBitmap);
//#UC START# *4FD0B3500288_4FD0A98C01BD_var*
var
 lShiftY: Integer;
 lShiftX: Integer;
//#UC END# *4FD0B3500288_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B3500288_4FD0A98C01BD_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 if not (Size in f_AvailableSizes) then
  Exit;
 lShiftX := (Image.Width - PILSize[Size]) div 2;
 lShiftY := (Image.Height - PILSize[Size]) div 2;

 Image.CopyRectTo(f_Glyph[Size, Bpp], lShiftX, lShiftY, Index*PILSize[Size], 0, PILSize[Size], PILSize[Size]);
 Image.AlphaChannel.CopyRectTo(f_Glyph[Size, Bpp].AlphaChannel, lShiftX, lShiftY, Index*PILSize[Size], 0, PILSize[Size], PILSize[Size]);
 f_Glyph[Size, Bpp].AlphaChannel.SyncFull;
 ClearAlphaDrawCache;
//#UC END# *4FD0B3500288_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.AddImage

procedure TvtPngImageListPrim.DrawGlyphSpecified(Index: Integer;
 const Canvas: Il3Canvas;
 Size: TvtPILSize;
 Bpp: TvtPILBpp;
 X: Integer;
 Y: Integer;
 Enabled: Boolean);
//#UC START# *4FD0B37801F0_4FD0A98C01BD_var*
//#UC END# *4FD0B37801F0_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B37801F0_4FD0A98C01BD_impl*
 DrawGlyphSpecified(Index, Canvas.Canvas, Size, Bpp, X, Y, Enabled);
//#UC END# *4FD0B37801F0_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.DrawGlyphSpecified

procedure TvtPngImageListPrim.Exchange(Index1: Integer;
 Index2: Integer);
//#UC START# *4FD0B43A020D_4FD0A98C01BD_var*
var
 lBpp: TvtPILBpp;
 lSize: TvtPILSize;
 lBMP: TIEBitmap;
//#UC END# *4FD0B43A020D_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B43A020D_4FD0A98C01BD_impl*
 lBMP := TIEBitmap.Create;
 try
  lBMP.Height := PILSize[ps32x32];
  lBMP.Width := PILSize[ps32x32];
  lBMP.PixelFormat := ie24RGB;
  lBMP.CreateAlphaChannel;
  for lSize := Low(TvtPILSize) to High(TvtPILSize) do
   if lSize in f_AvailableSizes then
   begin
    for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
    begin
     f_Glyph[lSize, lBpp].CopyRectTo(lBMP, Index1*PILSize[lSize], 0, 0, 0, PILSize[lSize], PILSize[lSize]);
     f_Glyph[lSize, lBpp].AlphaChannel.CopyRectTo(lBMP.AlphaChannel, Index1*PILSize[lSize], 0, 0, 0, PILSize[lSize], PILSize[lSize]);
     f_Glyph[lSize, lBpp].CopyRectTo(f_Glyph[lSize, lBpp], Index2*PILSize[lSize], 0, Index1*PILSize[lSize], 0, PILSize[lSize], PILSize[lSize]);
     f_Glyph[lSize, lBpp].AlphaChannel.CopyRectTo(f_Glyph[lSize, lBpp].AlphaChannel, Index2*PILSize[lSize], 0, Index1*PILSize[lSize], 0, PILSize[lSize], PILSize[lSize]);
     lBMP.CopyRectTo(f_Glyph[lSize, lBpp], 0, 0, Index2*PILSize[lSize], 0, PILSize[lSize], PILSize[lSize]);
     lBMP.AlphaChannel.CopyRectTo(f_Glyph[lSize, lBpp].AlphaChannel, 0, 0, Index2*PILSize[lSize], 0, PILSize[lSize], PILSize[lSize]);
    end;
   end; {if..}
 finally
  lBMP.Free;
 end;
 Change;
//#UC END# *4FD0B43A020D_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.Exchange

procedure TvtPngImageListPrim._RepairSizes;
//#UC START# *4FD0B4640341_4FD0A98C01BD_var*
var
 I: Integer;
 lNewImage: TIEBitmap;
 lBpp: TvtPILBpp;
 lSize: TvtPILSize;
//#UC END# *4FD0B4640341_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B4640341_4FD0A98C01BD_impl*
 CalcCount(False);
 for lSize := Low(TvtPILSize) to High(TvtPILSize) do
 begin
  if not (lSize in f_AvailableSizes) then
   Continue;
  lNewImage := TIEBitmap.Create;
  try
   with lNewImage do
   begin
    PixelFormat := ie24RGB;
    CreateAlphaChannel;
    Location := ieFile;
    MinFileSize := 51200;
    Width := PILSize[lSize]*f_Count;
    Height := PILSize[lSize];
   end; {with..}
   for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   begin
    for I := 0 to f_Count-1 do
    begin
     f_Glyph[lSize, lBpp].CopyRectTo(lNewImage, I*OldPilSize[lSize]+1, 1, I*PILSize[lSize], 0,
         PILSize[lSize], PILSize[lSize]);
     f_Glyph[lSize, lBpp].AlphaChannel.CopyRectTo(lNewImage.AlphaChannel, I*OldPilSize[lSize]+1, 1, I*PILSize[lSize], 0,
         PILSize[lSize], PILSize[lSize]);
    end;
    f_Glyph[lSize, lBpp].Assign(lNewImage);
   end;
  finally
    lNewImage.Free;
  end; {try..finally}
 end;
 Change;
//#UC END# *4FD0B4640341_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim._RepairSizes

procedure TvtPngImageListPrim.Clear;
//#UC START# *4FD0B4D500C1_4FD0A98C01BD_var*
var
 l_Size: TvtPILSize;
//#UC END# *4FD0B4D500C1_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B4D500C1_4FD0A98C01BD_impl*
 if not f_Rebuilding then
  for l_Size := Low(TvtPILSize) to High(TvtPILSize) do
   f_NeedPrepareAlphaDrawCache[l_Size] := True;
//#UC END# *4FD0B4D500C1_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.Clear

procedure TvtPngImageListPrim.CopySizeToSize(aSizeFrom: TvtPILSize;
 aSizeTo: TvtPILSize);
//#UC START# *4FD0B4EF00CE_4FD0A98C01BD_var*
var
 lBpp: TvtPILBpp;
//#UC END# *4FD0B4EF00CE_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B4EF00CE_4FD0A98C01BD_impl*
 if Count > 0 then
 begin
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  begin
   f_Glyph[aSizeFrom, lBpp].StretchRectTo(f_Glyph[aSizeTo, lBpp],
       0, 0, PILSize[aSizeTo]*Count, PILSize[aSizeTo],
       0, 0, PILSize[aSizeFrom]*Count, PILSize[aSizeFrom], rfLanczos3, 255);
   f_Glyph[aSizeTo, lBpp].AlphaChannel.SyncFull;
  end;
  ClearAlphaDrawCache;
 end;
//#UC END# *4FD0B4EF00CE_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.CopySizeToSize

procedure TvtPngImageListPrim.SaveImage(const aFilename: AnsiString;
 aIndex: Integer;
 aSize: TvtPILSize;
 aBpp: TvtPILBpp);
//#UC START# *4FD0B54000ED_4FD0A98C01BD_var*
var
 l_Img: TIEBitmap;
 l_Src: TIEBitmap;
 l_IO : TImageEnIO;
//#UC END# *4FD0B54000ED_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B54000ED_4FD0A98C01BD_impl*
 if (aIndex < 0) or (aIndex > Count-1) then
  Exit;
 if not (aSize in f_AvailableSizes) then
  Exit;
 l_Src := f_Glyph[aSize, aBpp];
 l_Img := TIEBitmap.Create;
 try
  l_Img.PixelFormat := l_Src.PixelFormat;
  l_Img.Width := PILSize[aSize] + 2; // добавляем "рамочку"
  l_Img.Height := PILSize[aSize] + 2;
  l_Img.FillRect(0, 0, PILSize[aSize] + 2, PILSize[aSize] + 2, $FF00FF);
  l_Img.CreateAlphaChannel;
  l_Img.AlphaChannel.FillRect(0, 0, PILSize[aSize] + 2, PILSize[aSize] + 2, 0);
  l_Src.CopyRectTo(l_Img, aIndex*PILSize[aSize], 0, 1, 1, PILSize[aSize], PILSize[aSize]);
  l_Src.AlphaChannel.CopyRectTo(l_Img.AlphaChannel, aIndex*PILSize[aSize], 0, 1, 1, PILSize[aSize],
       PILSize[aSize]);
  l_Img.AlphaChannel.SyncFull;
  l_IO := TImageEnIO.Create(nil);
  try
   l_IO.AttachedIEBitmap := l_Img;
   l_IO.SaveToFilePNG(aFileName);
  finally
   l3Free(l_IO);
  end;
 finally
  l_Img.Free;
 end;
//#UC END# *4FD0B54000ED_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.SaveImage

procedure TvtPngImageListPrim.DrawGlyphSpecified(Index: Integer;
 Canvas: TCanvas;
 Size: TvtPILSize;
 Bpp: TvtPILBpp;
 X: Integer;
 Y: Integer;
 Enabled: Boolean;
 HalfTransparent: Boolean = False);
//#UC START# *4FD0B8CB02B7_4FD0A98C01BD_var*
var
 lAlpha: Byte;
 lROP: TIERenderOperation;
 l_CacheTop: Integer;
 l_Painted: Boolean;
//#UC END# *4FD0B8CB02B7_4FD0A98C01BD_var*
begin
//#UC START# *4FD0B8CB02B7_4FD0A98C01BD_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 if not (Size in f_AvailableSizes) then
  Exit;

 l_Painted := CanAlphaDraw(Bpp, Size);
 if l_Painted then
 begin
  if Enabled then
   l_CacheTop := 0
  else
   l_CacheTop := PILSize[Size];
  g_BlendOp.SourceConstantAlpha := CalcTransparenctColor(cFullAlpha, HalfTransparent);
  l_Painted := AlphaBlend(Canvas.Handle, X, Y, PILSize[Size], PILSize[Size], f_AlphaDrawCache[Size].Canvas.Handle,Index*PILSize[Size],l_CacheTop,PILSize[Size],PILSize[Size],g_BlendOp);
  g_BlendOp.SourceConstantAlpha := cFullAlpha;
 end;
 if not l_Painted then
 begin
  if f_DrawCache[Size] = nil then
   begin
    f_DrawCache[Size] := Tl3Bitmap.Create;
    with f_DrawCache[Size] do
    begin
     Width  := PILSize[Size];
     Height := PILSize[Size];
     PixelFormat := pf24bit;
     Dormant;
    end;
   end;
  StretchBlt(f_DrawCache[Size].Canvas.Handle, 0, 0, PILSize[Size], PILSize[Size], Canvas.Handle, X, Y,
     PILSize[Size], PILSize[Size], SRCCOPY);
  if Enabled then
  begin
   lAlpha := CalcTransparenctColor(cFullAlpha, HalfTransparent);
   lROP := ielNormal;
  end
  else
  begin
   lAlpha := CalcTransparenctColor(cDisabledAlpha, HalfTransparent);
   lROP := ielGreyDown;
  end; {if..}
  f_Glyph[Size, Bpp].RenderToTBitmap(f_DrawCache[Size], 0, 0, PILSize[Size], PILSize[Size],
    Index*PILSize[Size], 0, PILSize[Size], PILSize[Size], True, rfNone, True, lAlpha, lROP);
  Canvas.Draw(X, Y, f_DrawCache[Size]);
 end;
//#UC END# *4FD0B8CB02B7_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.DrawGlyphSpecified

{$If Defined(DesignTimeLibrary)}
function TvtPngImageListPrim.ImageExtent(anIndex: Integer): TPoint;
//#UC START# *502543E60239_4FD0A98C01BD_var*
//#UC END# *502543E60239_4FD0A98C01BD_var*
begin
//#UC START# *502543E60239_4FD0A98C01BD_impl*
 Result.X := Width;
 Result.Y := Height;
//#UC END# *502543E60239_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.ImageExtent
{$IfEnd} // Defined(DesignTimeLibrary)

procedure TvtPngImageListPrim.Draw(Canvas: TCanvas;
 X: Integer;
 Y: Integer;
 Index: TImageIndex;
 Enabled: Boolean = True;
 HalfTransparent: Boolean = True);
//#UC START# *4F950C6D03BE_4FD0A98C01BD_var*
//#UC END# *4F950C6D03BE_4FD0A98C01BD_var*
begin
//#UC START# *4F950C6D03BE_4FD0A98C01BD_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 DrawGlyphSpecified(Index, Canvas, f_CurSize, f_CurBpp, X, Y, Enabled, HalfTransparent);
//#UC END# *4F950C6D03BE_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.Draw

procedure TvtPngImageListPrim.SaveImageToStream(aStream: TStream;
 aIndex: TImageIndex;
 aBpp: TvtPILBpp);
//#UC START# *53282D3E0350_4FD0A98C01BD_var*
//#UC END# *53282D3E0350_4FD0A98C01BD_var*
begin
//#UC START# *53282D3E0350_4FD0A98C01BD_impl*
 Assert(False, 'todo');
//#UC END# *53282D3E0350_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.SaveImageToStream

constructor TvtPngImageListPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4FD0A98C01BD_var*
var
 lBpp: TvtPILBpp;
 lSize: TvtPILSize;
//#UC END# *47D1602000C6_4FD0A98C01BD_var*
begin
//#UC START# *47D1602000C6_4FD0A98C01BD_impl*
 inherited;
 f_AvailableSizes := cDefaultAvailableSizes;
 for lSize := Low(TvtPILSize) to High(TvtPILSize) do
 begin
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
  begin
   f_Glyph[lSize, lBpp] := TIEBitmap.Create;
   with f_Glyph[lSize, lBpp] do
   begin
    PixelFormat := ie24RGB;
    CreateAlphaChannel;
    Location := ieFile;
    MinFileSize := 51200;
   end;
  end;
 end;
 Width := PILSize[ps16x16];
 Height := PILSize[ps16x16];
 f_CurSize := ps16x16;
 f_CurBpp := bpp24;
 f_Count := 0;
 f_ChangeOn := True;
 HandleNeeded;
 if g_PILList = nil then
  g_PILList := Tl3ObjectList.Make;
 g_PILList.Add(Self);
 f_Rebuilding := False;
//#UC END# *47D1602000C6_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.Create

destructor TvtPngImageListPrim.Destroy;
//#UC START# *48077504027E_4FD0A98C01BD_var*
var
 lBpp: TvtPILBpp;
 lSize: TvtPILSize;
//#UC END# *48077504027E_4FD0A98C01BD_var*
begin
//#UC START# *48077504027E_4FD0A98C01BD_impl*
 for lSize := Low(TvtPILSize) to High(TvtPILSize) do
 begin
  for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   l3Free(f_Glyph[lSize, lBpp]);
  l3Free(f_DrawCache[lSize]);
  l3Free(f_AlphaDrawCache[lSize]);
 end;
 g_PILList.Remove(Self);
 if g_PILList.Count = 0 then
  l3Free(g_PILList);
 inherited;
//#UC END# *48077504027E_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.Destroy

{$If NOT Defined(NoVCL)}
procedure TvtPngImageListPrim.Change;
//#UC START# *4FD08E8503DC_4FD0A98C01BD_var*
//#UC END# *4FD08E8503DC_4FD0A98C01BD_var*
begin
//#UC START# *4FD08E8503DC_4FD0A98C01BD_impl*
 if f_ChangeOn then
  inherited;
 ClearAlphaDrawCache; 
//#UC END# *4FD08E8503DC_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.Change
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtPngImageListPrim.DefineProperties(Filer: TFiler);
//#UC START# *4FD08EF002D0_4FD0A98C01BD_var*
  function DoWrite: Boolean;
  begin
    {if Filer.Ancestor <> nil then
      Result := not (Filer.Ancestor is TCustomImageList) or
        not Equal(TCustomImageList(Filer.Ancestor))
    else}
      Result := Count > 0;
  end;
//#UC END# *4FD08EF002D0_4FD0A98C01BD_var*
begin
//#UC START# *4FD08EF002D0_4FD0A98C01BD_impl*
 inherited DefineProperties(Filer);
 Filer.DefineBinaryProperty('PNGData', ReadData, WriteData, DoWrite);
//#UC END# *4FD08EF002D0_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.DefineProperties

{$If NOT Defined(NoVCL)}
procedure TvtPngImageListPrim.ReadData(Stream: TStream);
//#UC START# *4FD08F7F01AD_4FD0A98C01BD_var*
var
 lBpp: TvtPILBpp;
 IO: TImageEnIO;
 lSize: TvtPILSize;
//#UC END# *4FD08F7F01AD_4FD0A98C01BD_var*
begin
//#UC START# *4FD08F7F01AD_4FD0A98C01BD_impl*
 IO := TImageEnIO.Create(nil);
 try
  for lSize := Low(TvtPILSize) to High(TvtPILSize) do
   for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   begin
    IO.AttachedIEBitmap := f_Glyph[lSize, lBpp];
    IO.LoadFromStreamPNG(Stream);
   end;
 finally
  IO.Free;
 end;
 CalcCount;
 if f_Count <> 0 then
 begin
  for lSize := Low(TvtPILSize) to High(TvtPILSize) do
   if (lSize in AvailableSizes) then
    for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
     if f_Glyph[lSize, lBpp].Width = 0 then // не загрузились - надо создать
     with f_Glyph[lSize, lBpp] do
     begin
      Width := PILSize[lSize] * f_Count;
      Height := PILSize[lSize];
      with AlphaChannel.Canvas do
      begin
       Brush.Style := bsSolid;
       Brush.Color := 0;
       FillRect(Rect(0,0,PILSize[lSize] * f_Count, PILSize[lSize]));
      end;
     end;
 end;
 {$IFDEF DesignTimeLibrary}
 RebuildForDesignTime;
 {$ENDIF}
//#UC END# *4FD08F7F01AD_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.ReadData
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtPngImageListPrim.WriteData(Stream: TStream);
//#UC START# *4FD08FA7008C_4FD0A98C01BD_var*
var
 lBpp: TvtPILBpp;
 IO: TImageEnIO;
 lSize : TvtPILSize;
//#UC END# *4FD08FA7008C_4FD0A98C01BD_var*
begin
//#UC START# *4FD08FA7008C_4FD0A98C01BD_impl*
 IO := TImageEnIO.Create(nil);
 try
  for lSize := Low(TvtPILSize) to High(TvtPILSize) do
   for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
   begin
    IO.AttachedIEBitmap := f_Glyph[lSize, lBpp];
    IO.SaveToStreamPNG(Stream);
   end;
 finally
  IO.Free;
 end;
//#UC END# *4FD08FA7008C_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.WriteData
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtPngImageListPrim.WriteState(Writer: TWriter);
//#UC START# *4FD092040227_4FD0A98C01BD_var*
//#UC END# *4FD092040227_4FD0A98C01BD_var*
begin
//#UC START# *4FD092040227_4FD0A98C01BD_impl*
 {$IFDEF DesignTimeLibrary}
 inherited Clear;
 {$ENDIF}
 inherited;
//#UC END# *4FD092040227_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.WriteState

{$If NOT Defined(NoVCL)}
procedure TvtPngImageListPrim.DoDraw(Index: Integer;
 Canvas: TCanvas;
 X: Integer;
 Y: Integer;
 Style: Cardinal;
 Enabled: Boolean);
//#UC START# *4FD093CB025F_4FD0A98C01BD_var*
//#UC END# *4FD093CB025F_4FD0A98C01BD_var*
begin
//#UC START# *4FD093CB025F_4FD0A98C01BD_impl*
 if (Index < 0) or (Index > Count-1) then
  Exit;
 DrawGlyphSpecified(Index, Canvas, f_CurSize, f_CurBpp, X, Y, Enabled);
//#UC END# *4FD093CB025F_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.DoDraw
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
function TvtPngImageListPrim.ImageExtent(anIndex: Integer): TPoint;
//#UC START# *4FD0944D0202_4FD0A98C01BD_var*
//#UC END# *4FD0944D0202_4FD0A98C01BD_var*
begin
//#UC START# *4FD0944D0202_4FD0A98C01BD_impl*
 Result.X := Width;
 Result.Y := Height;
//#UC END# *4FD0944D0202_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.ImageExtent
{$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)

{$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
function TvtPngImageListPrim.IsSmart: Boolean;
//#UC START# *4FD095D20217_4FD0A98C01BD_var*
//#UC END# *4FD095D20217_4FD0A98C01BD_var*
begin
//#UC START# *4FD095D20217_4FD0A98C01BD_impl*
 Result := True;
//#UC END# *4FD095D20217_4FD0A98C01BD_impl*
end;//TvtPngImageListPrim.IsSmart
{$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)

//#UC START# *4FD0A98C01BDimpl*
{$ifndef DesignTimeLibrary}
{$IfNDef XE}
function TvtPngImageListPrim.GetCount: Integer;
begin
 Result := f_Count;
end;
{$endif}
{$endif}
//#UC END# *4FD0A98C01BDimpl*

procedure TvtFixedSizeProxyPngImageListPrim.pm_SetFixedSize(aValue: TvtPILSize);
//#UC START# *4FD0C074032D_4FD0BFBC00F9set_var*
//#UC END# *4FD0C074032D_4FD0BFBC00F9set_var*
begin
//#UC START# *4FD0C074032D_4FD0BFBC00F9set_impl*
 if f_FixedSize <> aValue then
 begin
  f_FixedSize := aValue;
  Width := PILSize[f_FixedSize];
  Height := PILSize[f_FixedSize];
  Change;
 end;
//#UC END# *4FD0C074032D_4FD0BFBC00F9set_impl*
end;//TvtFixedSizeProxyPngImageListPrim.pm_SetFixedSize

procedure TvtFixedSizeProxyPngImageListPrim.pm_SetOriginalImgList(aValue: TvtPngImageListPrim);
//#UC START# *4FD0C0CB027B_4FD0BFBC00F9set_var*
//#UC END# *4FD0C0CB027B_4FD0BFBC00F9set_var*
begin
//#UC START# *4FD0C0CB027B_4FD0BFBC00F9set_impl*
 if (f_OriginalImgList <> aValue) then
 begin
  if (f_ImageChangeLink <> nil) AND (f_ImageChangeLink.Sender = nil) then
   // - список картинок уже убит - надо его зачистить
   f_OriginalImgList := nil;
  (* Отпишемся от нотификации изменений *)
  if (f_OriginalImgList <> nil) then
   f_OriginalImgList.UnRegisterChanges(f_ImageChangeLink);
  (* Подпишемся на нотификацию *)
  aValue.RegisterChanges(f_ImageChangeLink);
  f_OriginalImgList := aValue;
  Change;
 end;//f_OriginalImgList <> aValue
//#UC END# *4FD0C0CB027B_4FD0BFBC00F9set_impl*
end;//TvtFixedSizeProxyPngImageListPrim.pm_SetOriginalImgList

function TvtFixedSizeProxyPngImageListPrim.pm_GetCount: Integer;
//#UC START# *4FD0C1BF0313_4FD0BFBC00F9get_var*
//#UC END# *4FD0C1BF0313_4FD0BFBC00F9get_var*
begin
//#UC START# *4FD0C1BF0313_4FD0BFBC00F9get_impl*
 if f_OriginalImgList <> nil
  then Result := f_OriginalImgList.Count
  else Result := 0;
//#UC END# *4FD0C1BF0313_4FD0BFBC00F9get_impl*
end;//TvtFixedSizeProxyPngImageListPrim.pm_GetCount

procedure TvtFixedSizeProxyPngImageListPrim.ImageListChange(Sender: TObject);
//#UC START# *4FD0C2760204_4FD0BFBC00F9_var*
//#UC END# *4FD0C2760204_4FD0BFBC00F9_var*
begin
//#UC START# *4FD0C2760204_4FD0BFBC00F9_impl*
 Change;
//#UC END# *4FD0C2760204_4FD0BFBC00F9_impl*
end;//TvtFixedSizeProxyPngImageListPrim.ImageListChange

procedure TvtFixedSizeProxyPngImageListPrim.Draw(Canvas: TCanvas;
 X: Integer;
 Y: Integer;
 Index: TImageIndex;
 Enabled: Boolean = True;
 HalfTransparent: Boolean = True);
//#UC START# *4F950C6D03BE_4FD0BFBC00F9_var*
//#UC END# *4F950C6D03BE_4FD0BFBC00F9_var*
begin
//#UC START# *4F950C6D03BE_4FD0BFBC00F9_impl*
 if (Index < 0) or (Index > Count-1) then                 
  Exit;
 if f_OriginalImgList <> nil then
  f_OriginalImgList.DrawGlyphSpecified(Index, Canvas, f_FixedSize, f_OriginalImgList.CurBpp, X, Y, Enabled, HalfTransparent);
//#UC END# *4F950C6D03BE_4FD0BFBC00F9_impl*
end;//TvtFixedSizeProxyPngImageListPrim.Draw

procedure TvtFixedSizeProxyPngImageListPrim.SaveImageToStream(aStream: TStream;
 aIndex: TImageIndex;
 aBpp: TvtPILBpp);
//#UC START# *53282D3E0350_4FD0BFBC00F9_var*
//#UC END# *53282D3E0350_4FD0BFBC00F9_var*
begin
//#UC START# *53282D3E0350_4FD0BFBC00F9_impl*
 Assert(False, 'todo');
//#UC END# *53282D3E0350_4FD0BFBC00F9_impl*
end;//TvtFixedSizeProxyPngImageListPrim.SaveImageToStream

constructor TvtFixedSizeProxyPngImageListPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4FD0BFBC00F9_var*
//#UC END# *47D1602000C6_4FD0BFBC00F9_var*
begin
//#UC START# *47D1602000C6_4FD0BFBC00F9_impl*
 inherited;
 f_ImageChangeLink := TChangeLink.Create;
 f_ImageChangeLink.OnChange := ImageListChange;
 f_FixedSize := ps16x16;
 Width := PILSize[ps16x16];
 Height := PILSize[ps16x16];
 HandleNeeded;
//#UC END# *47D1602000C6_4FD0BFBC00F9_impl*
end;//TvtFixedSizeProxyPngImageListPrim.Create

destructor TvtFixedSizeProxyPngImageListPrim.Destroy;
//#UC START# *48077504027E_4FD0BFBC00F9_var*
//#UC END# *48077504027E_4FD0BFBC00F9_var*
begin
//#UC START# *48077504027E_4FD0BFBC00F9_impl*
 l3Free(f_ImageChangeLink);
 inherited;
//#UC END# *48077504027E_4FD0BFBC00F9_impl*
end;//TvtFixedSizeProxyPngImageListPrim.Destroy

{$If NOT Defined(NoVCL)}
procedure TvtFixedSizeProxyPngImageListPrim.DoDraw(Index: Integer;
 Canvas: TCanvas;
 X: Integer;
 Y: Integer;
 Style: Cardinal;
 Enabled: Boolean);
//#UC START# *4FD093CB025F_4FD0BFBC00F9_var*
//#UC END# *4FD093CB025F_4FD0BFBC00F9_var*
begin
//#UC START# *4FD093CB025F_4FD0BFBC00F9_impl*
 if f_OriginalImgList <> nil then
  f_OriginalImgList.DrawGlyphSpecified(Index, Canvas, f_FixedSize, f_OriginalImgList.CurBpp, X, Y, Enabled);
//#UC END# *4FD093CB025F_4FD0BFBC00F9_impl*
end;//TvtFixedSizeProxyPngImageListPrim.DoDraw
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)}
function TvtFixedSizeProxyPngImageListPrim.IsSmart: Boolean;
//#UC START# *4FD095D20217_4FD0BFBC00F9_var*
//#UC END# *4FD095D20217_4FD0BFBC00F9_var*
begin
//#UC START# *4FD095D20217_4FD0BFBC00F9_impl*
 Result := True;
//#UC END# *4FD095D20217_4FD0BFBC00F9_impl*
end;//TvtFixedSizeProxyPngImageListPrim.IsSmart
{$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary) AND NOT Defined(XE)

//#UC START# *4FD0BFBC00F9impl*
{$ifndef DesignTimeLibrary}
{$IfNDef XE}
function TvtFixedSizeProxyPngImageListPrim.GetCount: Integer;
begin
 if f_OriginalImgList <> nil
  then Result := f_OriginalImgList.Count
  else Result := 0;
end;
{$endif}
{$endif}
//#UC END# *4FD0BFBC00F9impl*

//#UC START# *4FD224430014impl*
{$IFDEF DesignTimeLibrary}
procedure TvtPngImageListPrim.RebuildForDesignTime;
var
 lBmp: TBitmap;
 I: Integer;
begin
 lBmp := Tl3Bitmap.Create;
 lBmp.Height := Height;
 lBmp.Width  := Width;
 f_Rebuilding := True;
 try
  inherited Clear;
  for I := 0 to Pred(Count) do
  begin
   with lBmp.Canvas do
   begin
    Brush.Color := clWindow;
    Brush.Style := bsSolid;
    FillRect(Rect(0, 0, Width, Height));
   end;
   DoDraw(I, lBmp.Canvas, 0, 0, 0, True);
   inherited Add(lBmp, nil);
  end;
 finally
  FreeAndNil(lBmp);
  f_Rebuilding := False;
 end; {try..finally}
end;
{$ENDIF}

{$IFDEF DesignTimeLibrary}
procedure TvtNonFixedPngImageListPrim.RebuildForDesignTime;
var
 lBmp: TBitmap;
 I: Integer;
begin
 lBmp := Tl3Bitmap.Create;
 lBmp.Height := Height;
 lBmp.Width  := Width;
 f_Rebuilding := True;
 try
  inherited Clear;
  for I := 0 to Pred(Count) do
  begin
   with lBmp.Canvas do
   begin
    Brush.Color := clWindow;
    Brush.Style := bsSolid;
    FillRect(Rect(0, 0, Width, Height));
   end;
   DoDraw(I, lBmp.Canvas, 0, 0, 0, True);
   inherited Add(lBmp, nil);
  end;
 finally
  FreeAndNil(lBmp);
  f_Rebuilding := False;
 end; {try..finally}
end;
{$ENDIF}
//#UC END# *4FD224430014impl*

//#UC START# *4FD2246B017Bimpl*
//#UC END# *4FD2246B017Bimpl*

//#UC START# *4FD2248F001Bimpl*
//#UC END# *4FD2248F001Bimpl*

end.
