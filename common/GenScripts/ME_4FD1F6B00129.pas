unit vtPngImgListUtils;

// Модуль: "w:\common\components\gui\Garant\VT\vtPngImgListUtils.pas"
// Стереотип: "UtilityPack"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , l3ObjectList
 {$If NOT Defined(NoImageEn)}
 , hyieutils
 {$IfEnd} // NOT Defined(NoImageEn)
 , Graphics
 , Windows
 , l3Types
 , vtInterfaces
 , l3ProcedureList
 , l3ProtoObject
;

type
 TvtImageListCreatorProc = function: TObject;

 PvtImageListCreatorProc = ^TvtImageListCreatorProc;

 TAlphaBlendFunc = function(DestDC: hDC;
  X: Integer;
  Y: Integer;
  Width: Integer;
  Height: Integer;
  SrcDC: hDC;
  XSrc: Integer;
  YSrc: Integer;
  SrcWidth: Integer;
  SrcHeight: Integer;
  const BlendFunc: TBlendFunction): Boolean;

 TvtilCreators = class(Tl3ProcedureList)
  public
   class function IsAssigned: Boolean;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TvtilCreators;
    {* Метод получения экземпляра синглетона TvtilCreators }
 end;//TvtilCreators

 ImgLibraryManager = class(Tl3ProtoObject)
  private
   f_ImgDLL: THandle;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: ImgLibraryManager;
    {* Метод получения экземпляра синглетона ImgLibraryManager }
 end;//ImgLibraryManager

 TaBPPGlyphs = array [TvtPILBpp] of TIEBitmap;

 TaPILSizes = array [TvtPILSize] of Integer;

 TBitmap = Graphics.TBitmap;

const
 PILSize: TaPILSizes = (16, 32, 24);
 cDefaultAvailableSizes = [ps16x16, ps32x32, ps24x24];
 cFullAlpha = 255;
 cDisabledAlpha = 192;
 OldPILSize: TaPILSizes = (18, 34, 26);

procedure PrepareAlphaBitmap(aSource: TIEBitmap;
 aDest: TBitmap);
function AlphaBlend(DestDC: hDC;
 X: Integer;
 Y: Integer;
 Width: Integer;
 Height: Integer;
 SrcDC: hDC;
 XSrc: Integer;
 YSrc: Integer;
 SrcWidth: Integer;
 SrcHeight: Integer;
 const BlendFunc: TBlendFunction): Boolean;
function CalcTransparenctColor(aTransparensy: Byte;
 HalfTransparent: Boolean): Byte;
procedure IterateExistingImageListsF(anAction: Tl3IteratorAction);
procedure AddImageListCreator(aCreator: PvtImageListCreatorProc);
procedure AddImageListCreatorPrim(aCreator: TvtImageListCreatorProc);
function GetAnother(aSize: TvtPILSize): TvtPILSize; overload;
function GetAnother(aBpp: TvtPILBpp): TvtPILBpp; overload;
function GetScreenColorDepth: Integer;
function AutoDetectColorDepth: TvtPILBpp;
procedure SetColorDepthGlobal(aBpp: TvtPILBpp);

var g_PILList: Tl3ObjectList;
var g_AlphaBlendFunc: TAlphaBlendFunc;

implementation

uses
 l3ImplUses
 , l3Bitmap
 , SysUtils
 , l3MinMax
 , l3Base
 {$If NOT Defined(NoImageEn)}
 , hyiedefs
 {$IfEnd} // NOT Defined(NoImageEn)
 , vtPngImgList
;

var g_TvtilCreators: TvtilCreators = nil;
 {* Экземпляр синглетона TvtilCreators }
var g_ImgLibraryManager: ImgLibraryManager = nil;
 {* Экземпляр синглетона ImgLibraryManager }
var g_ScreenColorDepth: Integer;

procedure TvtilCreatorsFree;
 {* Метод освобождения экземпляра синглетона TvtilCreators }
begin
 l3Free(g_TvtilCreators);
end;//TvtilCreatorsFree

procedure ImgLibraryManagerFree;
 {* Метод освобождения экземпляра синглетона ImgLibraryManager }
begin
 l3Free(g_ImgLibraryManager);
end;//ImgLibraryManagerFree

procedure PrepareAlphaBitmap(aSource: TIEBitmap;
 aDest: TBitmap);
//#UC START# *4FD1F66B03D5_4FD1F6B00129_var*
var
 l_LineIdx, l_PixelIdx: integer;
 l_DestColor: pRGBA;
 l_DestGray: pRGBA;
 l_Source: PRGB;
 l_Alpha: PByte;
 l_DisabledAlpha: Byte;
 l_Gray: Byte;
//#UC END# *4FD1F66B03D5_4FD1F6B00129_var*
begin
//#UC START# *4FD1F66B03D5_4FD1F6B00129_impl*
 aDest.Width := aSource.Width;
 aDest.Height := aSource.Height*2;
 aDest.PixelFormat := pf32Bit;
 for l_LineIdx := 0 to aSource.Height-1 do
 begin
  l_DestColor := aDest.Scanline[l_LineIdx];
  l_DestGray := aDest.Scanline[l_LineIdx+aSource.Height];
  l_Source := aSource.Scanline[l_LineIdx];
  l_Alpha := aSource.AlphaChannel.Scanline[l_LineIdx];
  for l_PixelIdx:=0 to aSource.Width-1 do
  begin
   with l_DestColor^ do
   begin
    r := l_Source^.r * l_Alpha^ div cFullAlpha;
    g := l_Source^.g * l_Alpha^ div cFullAlpha;
    b := l_Source^.b * l_Alpha^ div cFullAlpha;
    a := l_Alpha^;
   end;
   l_DisabledAlpha := l_Alpha^ * cDisabledAlpha div cFullAlpha;
   l_Gray := max(max(l_Source^.r, l_Source^.g),l_Source^.b) * l_DisabledAlpha div cFullAlpha;
   with l_DestGray^ do
   begin
    r := l_Gray;
    g := l_Gray;
    b := l_Gray;
    a := l_DisabledAlpha;
   end;
   inc(l_Source);
   inc(l_DestColor);
   inc(l_DestGray);
   inc(l_Alpha);
  end;
 end;
 aDest.Dormant;
//#UC END# *4FD1F66B03D5_4FD1F6B00129_impl*
end;//PrepareAlphaBitmap

function AlphaBlend(DestDC: hDC;
 X: Integer;
 Y: Integer;
 Width: Integer;
 Height: Integer;
 SrcDC: hDC;
 XSrc: Integer;
 YSrc: Integer;
 SrcWidth: Integer;
 SrcHeight: Integer;
 const BlendFunc: TBlendFunction): Boolean;
//#UC START# *4FD1F6FB00AF_4FD1F6B00129_var*
//#UC END# *4FD1F6FB00AF_4FD1F6B00129_var*
begin
//#UC START# *4FD1F6FB00AF_4FD1F6B00129_impl*
 if Assigned(g_AlphaBlendFunc) then
  Result := g_AlphaBlendFunc(DestDC, X, Y, Width, Height, SrcDC, XSrc,
  YSrc, SrcWidth, SrcHeight, BlendFunc)
 else
 begin
  SetLastError(ERROR_INVALID_FUNCTION);
  Result := false;
 end;
//#UC END# *4FD1F6FB00AF_4FD1F6B00129_impl*
end;//AlphaBlend

function CalcTransparenctColor(aTransparensy: Byte;
 HalfTransparent: Boolean): Byte;
//#UC START# *4FD1F75F023A_4FD1F6B00129_var*
//#UC END# *4FD1F75F023A_4FD1F6B00129_var*
begin
//#UC START# *4FD1F75F023A_4FD1F6B00129_impl*
 if HalfTransparent
  then Result := aTransparensy div 2
  else Result := aTransparensy;
//#UC END# *4FD1F75F023A_4FD1F6B00129_impl*
end;//CalcTransparenctColor

procedure IterateExistingImageListsF(anAction: Tl3IteratorAction);
//#UC START# *4FD1F77B0267_4FD1F6B00129_var*
 function DoItem(P: PPointer; Index: Long): Bool;
 begin//DoItem
  if (P^ <> nil) then
   TvtImageListCreatorProc(P^);
  P^ := nil;
  Result := true;
 end;//DoItem
//#UC END# *4FD1F77B0267_4FD1F6B00129_var*
begin
//#UC START# *4FD1F77B0267_4FD1F6B00129_impl*
 if TvtilCreators.IsAssigned then
  TvtilCreators.Instance.IterateAllF(l3L2IA(@DoItem));
 try
  if (g_PILList <> nil) then
   g_PILList.IterateAll(anAction);
 finally
  l3FreeIA(anAction);
 end;//try..finally  
//#UC END# *4FD1F77B0267_4FD1F6B00129_impl*
end;//IterateExistingImageListsF

procedure AddImageListCreator(aCreator: PvtImageListCreatorProc);
//#UC START# *4FD1F81F02CF_4FD1F6B00129_var*
//#UC END# *4FD1F81F02CF_4FD1F6B00129_var*
begin
//#UC START# *4FD1F81F02CF_4FD1F6B00129_impl*
 AddImageListCreatorPrim(TvtImageListCreatorProc(aCreator));
//#UC END# *4FD1F81F02CF_4FD1F6B00129_impl*
end;//AddImageListCreator

procedure AddImageListCreatorPrim(aCreator: TvtImageListCreatorProc);
//#UC START# *4FD1F900009A_4FD1F6B00129_var*
//#UC END# *4FD1F900009A_4FD1F6B00129_var*
begin
//#UC START# *4FD1F900009A_4FD1F6B00129_impl*
 TvtilCreators.Instance.Add(TProcedure(aCreator));
//#UC END# *4FD1F900009A_4FD1F6B00129_impl*
end;//AddImageListCreatorPrim

function GetAnother(aSize: TvtPILSize): TvtPILSize;
//#UC START# *4FD1F96300AF_4FD1F6B00129_var*
//#UC END# *4FD1F96300AF_4FD1F6B00129_var*
begin
//#UC START# *4FD1F96300AF_4FD1F6B00129_impl*
 if aSize = ps16x16
  then Result := ps24x24
  else Result := ps16x16;
//#UC END# *4FD1F96300AF_4FD1F6B00129_impl*
end;//GetAnother

function GetAnother(aBpp: TvtPILBpp): TvtPILBpp;
//#UC START# *4FD1F98902AB_4FD1F6B00129_var*
//#UC END# *4FD1F98902AB_4FD1F6B00129_var*
begin
//#UC START# *4FD1F98902AB_4FD1F6B00129_impl*
 case aBpp of
  bpp24: Result := bpp8;
  bpp8: Result := bpp4;
 else
  Result := bpp24;
 end;
//#UC END# *4FD1F98902AB_4FD1F6B00129_impl*
end;//GetAnother

function GetScreenColorDepth: Integer;
//#UC START# *4FD1F9AA00E5_4FD1F6B00129_var*
var
 DC: HDC;
//#UC END# *4FD1F9AA00E5_4FD1F6B00129_var*
begin
//#UC START# *4FD1F9AA00E5_4FD1F6B00129_impl*
 DC := GetDC(0);
 try
  Result := GetDeviceCaps(DC, BITSPIXEL);
 finally
  ReleaseDC(0, DC);
 end;
//#UC END# *4FD1F9AA00E5_4FD1F6B00129_impl*
end;//GetScreenColorDepth

function AutoDetectColorDepth: TvtPILBpp;
//#UC START# *4FD1F9CB0196_4FD1F6B00129_var*
//#UC END# *4FD1F9CB0196_4FD1F6B00129_var*
begin
//#UC START# *4FD1F9CB0196_4FD1F6B00129_impl*
 case GetScreenCOlorDepth of
  1..4: Result := bpp4;
  8: Result := bpp8;
  16,24,32: Result := bpp24;
 else
  raise Exception.Create('Не удалось определить глубину цвета экрана');
 end;
//#UC END# *4FD1F9CB0196_4FD1F6B00129_impl*
end;//AutoDetectColorDepth

procedure SetColorDepthGlobal(aBpp: TvtPILBpp);
//#UC START# *4FD1F9E601E9_4FD1F6B00129_var*
var
 I: Integer;
 l_NeedReset: Boolean;
//#UC END# *4FD1F9E601E9_4FD1F6B00129_var*
begin
//#UC START# *4FD1F9E601E9_4FD1F6B00129_impl*
 I := GetScreenCOlorDepth;
 l_NeedReset := I <> g_ScreenColorDepth;
 g_ScreenColorDepth := I;
 if g_PILList <> nil then
 begin
  for I := 0 to Pred(g_PILList.Count) do
  begin
   if g_PILList[I] is TvtPngImageList then
   begin
    if l_NeedReset then
     TvtPngImageList(g_PILList[I]).ClearCache;
    TvtPngImageList(g_PILList[I]).CurBpp := aBpp;
   end;
   if g_PILList[I] is TvtNonFixedPngImageList then
   begin
    if l_NeedReset then
     TvtNonFixedPngImageList(g_PILList[I]).ClearCache;
    TvtNonFixedPngImageList(g_PILList[I]).CurBpp := aBpp;
   end;
  end;
 end;
//#UC END# *4FD1F9E601E9_4FD1F6B00129_impl*
end;//SetColorDepthGlobal

class function TvtilCreators.IsAssigned: Boolean;
//#UC START# *4FD318100335_4FD31272000C_var*
//#UC END# *4FD318100335_4FD31272000C_var*
begin
//#UC START# *4FD318100335_4FD31272000C_impl*
 Result := Assigned(g_TvtilCreators);
//#UC END# *4FD318100335_4FD31272000C_impl*
end;//TvtilCreators.IsAssigned

class function TvtilCreators.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvtilCreators <> nil;
end;//TvtilCreators.Exists

class function TvtilCreators.Instance: TvtilCreators;
 {* Метод получения экземпляра синглетона TvtilCreators }
begin
 if (g_TvtilCreators = nil) then
 begin
  l3System.AddExitProc(TvtilCreatorsFree);
  g_TvtilCreators := Create;
 end;
 Result := g_TvtilCreators;
end;//TvtilCreators.Instance

class function ImgLibraryManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_ImgLibraryManager <> nil;
end;//ImgLibraryManager.Exists

class function ImgLibraryManager.Instance: ImgLibraryManager;
 {* Метод получения экземпляра синглетона ImgLibraryManager }
begin
 if (g_ImgLibraryManager = nil) then
 begin
  l3System.AddExitProc(ImgLibraryManagerFree);
  g_ImgLibraryManager := Create;
 end;
 Result := g_ImgLibraryManager;
end;//ImgLibraryManager.Instance

procedure ImgLibraryManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_502518C60255_var*
//#UC END# *479731C50290_502518C60255_var*
begin
//#UC START# *479731C50290_502518C60255_impl*
 if f_ImgDLL <> 0 then
  FreeLibrary(f_ImgDLL);
 g_AlphaBlendFunc := nil;
//#UC END# *479731C50290_502518C60255_impl*
end;//ImgLibraryManager.Cleanup

procedure ImgLibraryManager.InitFields;
//#UC START# *47A042E100E2_502518C60255_var*
//#UC END# *47A042E100E2_502518C60255_var*
begin
//#UC START# *47A042E100E2_502518C60255_impl*
 if Win32Platform = VER_PLATFORM_WIN32_NT then
 begin
  f_ImgDLL := SafeLoadLibrary(msimg32);
  if f_ImgDLL <> 0 then
   g_AlphaBlendFunc := TAlphaBlendFunc(GetProcAddress(f_ImgDLL, 'AlphaBlend'));
  if @g_AlphaBlendFunc = nil then
   FreeLibrary(f_ImgDLL);
 end;
//#UC END# *47A042E100E2_502518C60255_impl*
end;//ImgLibraryManager.InitFields

end.
