unit nsConsultationHAFPainterImages_Form;

////////////////////////////////////////////////////////////////////////////////
// Библиотека : Проект Немезис.
// Назначение : Ресурсы для печати консультации.
// Версия     : $Id: nsConsultationHAFPainterImages_Form.pas,v 1.8 2014/04/11 15:29:40 lulin Exp $
////////////////////////////////////////////////////////////////////////////////

interface

uses
  ImgList,
  SysUtils,
  Classes,

  l3InternalInterfaces,

  vtPngImgList,
  
  k2Interfaces,

  nsHAFPainter
  ;

type
  TnsConsultationHAFPainterImages = class(TDataModule)
    FirstPage: TvtNonFixedPngImageList;
    OtherPage: TvtNonFixedPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;//TnsConsultationHAFPainterImages

  TnsConsultationHAFPainter = class(TnsHAFPainter)
    public
    // public methods
      procedure TuneHeader(const aCanvas : Il3Canvas;
                           aHeader : Tl3Variant;
                           aTop          : Boolean);
        override;
        {-}
      procedure ReadColontitulSettings;
        override;
        {-}
  end;//TnsConsultationHAFPainter

var
  nsConsultationHAFPainterImages: TnsConsultationHAFPainterImages = nil;

implementation

uses
  Graphics,

  l3Types,
  l3Base,
  l3BaseStream,
  l3Memory,
  l3Stream,
  l3String,

  afwInterfaces,

  k2Tags,
  k2Base,
  k2Facade,

  evdTypes,
  evdStyles,

  evTypes,

  evHAFPainterMacros,
  evSBSPar,

  vcmBase,

  StdRes,

  BitmapPara_Const,

  nevInterfaces,

  k2SizedMemoryPool,
  k2RawData_Const
  ;

{$R *.dfm}

type
  THackImg = class(TvtNonFixedPngImageList)
  end;//THackImg

// start class TnsConsultationHAFPainter

procedure TnsConsultationHAFPainter.TuneHeader(const aCanvas : Il3Canvas;
                                               aHeader : Tl3Variant;
                                               aTop          : Boolean);
  //override;
  {-}
  
 procedure TunePic(aPic: TvtNonFixedPngImageList);
 var
  l_Pic : Tl3Variant;
  l_Mem : Tk2SizedMemoryPool;
  l_IS  : IStream;
  l_S   : TStream;
  l_W   : Integer;
  l_W1  : Integer;
  l_TW  : Integer;
 begin
  l_Pic := k2_typBitmapPara.MakeTag.AsObject;
  try
   l_Mem := Tk2SizedMemoryPool.Create;
//   l_Mem := Tl3FileStream.Create('O:\haf\1.png', l3_fmRead);
   try
    l_IS := l_Mem As IStream;
    l3IStream2Stream(l_IS, l_S);
    try
     THackImg(aPic).WriteData(l_S);
    finally
     FreeAndNil(l_S);
    end;//try..finally
    l_Pic.IntA[k2_tiDPI] := 150;
    // - заплатка
    l_Pic.AttrW[k2_tiData, nil] := l_Mem;
   finally
    l3Free(l_Mem);
   end;//try..finally
   l_W := l_Pic.IntA[k2_tiWidth];
   with evSBS_RightColumn(aHeader) do
   begin
    Inc(l_W, IntA[k2_tiLeftIndent]);
    Inc(l_W, IntA[k2_tiRightIndent]);
    // - учитываем отступы ячейки
    l_W1 := IntA[k2_tiWidth];
    if (l_W > l_W1) then
    begin
     l_TW := aHeader.IntA[k2_tiWidth];
     if (l_W < l_TW) then
     begin
      with evSBS_LeftColumn(aHeader) do
       IntA[k2_tiWidth] := IntA[k2_tiWidth] - (l_W - l_W1);
      IntA[k2_tiWidth] := l_W;
     end//l_W < l_TW
     else
     begin
      with evSBS_LeftColumn(aHeader) do
       IntA[k2_tiWidth] := 0;
      IntA[k2_tiWidth] := l_TW;
     end;//l_W < l_TW
    end//l_W > IntA[k2_tiWidth]
    else
     l_Pic.IntA[k2_tiJustification] := Ord(ev_itRight);
    DeleteChild(0);
    // - удаляем текстовый параграф
    AddChild(l_Pic);
    // - добавляем картинку
   end;//with evSBS_RightColumn(aHeader)
  finally
   l_Pic := nil;
  end;//try..finally
 end;

var
 l_Canvas : IafwPreviewCanvas;

begin
 if not aTop then
 begin
  if (PagesCount = 0) AND Supports(aCanvas, IafwPreviewCanvas, l_Canvas) AND
     not l_Canvas.IsPagesCounter then
   try
    PagesCount := l_Canvas.PagesInfo.rPagesCount;
   finally
    l_Canvas := nil;
   end;//try..finally
  with evSBS_LeftPara(aHeader) do
  begin
   IntA[k2_tiStyle] := ev_saHFLeft;
   PCharLenA[k2_tiText] := l3PCharLen(vcmFmt(str_nevmmPageCounter, [MacroDocCurrentPage(aCanvas), MacroDocPagesCount]));
  end; 
 end;

 if (nsConsultationHAFPainterImages = nil) then
  nsConsultationHAFPainterImages := TnsConsultationHAFPainterImages.Create(nil);
 if aTop then
 // - верхний колонтитул
 begin
  if (aCanvas.PageNumber = 1) then
   TunePic(nsConsultationHAFPainterImages.FirstPage)
  else
   TunePic(nsConsultationHAFPainterImages.OtherPage);
 end//aTop
 else
 begin
  TunePic(dmStdRes.ilLogo);
  evSBS_LeftPara(aHeader).cAtom(k2_tiFont).IntA[k2_tiForeColor] := clNavy;
 end;//aTop
end;

procedure TnsConsultationHAFPainter.ReadColontitulSettings;
begin
 inherited;
 if (Settings <> nil) then
  with Settings do
  begin
   f_Colontituls[pcUpLeftFirst] := nil;
   f_Colontituls[pcUpRightFirst] := nil;
   f_Colontituls[pcDownLeftFirst] := vcmFmt(str_nevmmPageCounter, [SDocCurrentPage, SDocPagesCount]);
   f_Colontituls[pcDownRightFirst] := nil;
  //
   f_Colontituls[pcUpLeft] := nil;
   f_Colontituls[pcUpRight] := nil;
   f_Colontituls[pcDownLeft] := f_Colontituls[pcDownLeftFirst];
   f_Colontituls[pcDownRight] := nil;
  end;//with Settings
end;

initialization

finalization
  l3Free(nsConsultationHAFPainterImages);

end.
