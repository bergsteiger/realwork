unit afwPreviewCanvas;
 {* Реализация канвы для печати. }

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewCanvas.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3Canvas
 , afwInterfaces
 , afwPreviewPageList
 , afwTypes
 , l3Core
 , l3Interfaces
 , l3Units
 , l3BaseWithLargeIDList
;

type
 TnevPages = class(Tl3BaseWithLargeIDList)
  public
   function GetPageByObject(anObjectID: Integer): Integer;
    {* страница по смещению с начала. }
   procedure AddParaOnPage(aParaID: Integer;
    aPageNumber: Integer);
 end;//TnevPages

 TafwLastPage = record
  rPage: IafwPreviewPage;
  rX: Integer;
  rY: Integer;
 end;//TafwLastPage

 TafwPreviewCanvas = class(Tl3Canvas, IafwPreviewCanvas)
  {* Реализация канвы для печати. }
  private
   f_IsPageCounter: Boolean;
   f_PagesList: TafwPreviewPageList;
   f_PagesInfo: TafwPagesInfo;
   f_Pages: TnevPages;
   f_LastPage: TafwLastPage;
   f_PreviewPage: IafwPreviewPage;
  protected
   function IsMonochrome: Boolean;
    {* true, если устройство назначения не поддерживает цвет; определяет, будет по-умолчанию подавлен цвет. }
   function GetPagesCount: Integer;
    {* длина документа в страницах (количество страниц "в высоту"). }
   function GetPagesWidthCount(aIndex: Integer): Integer;
    {* сколько страниц в ширину, для заданной страницы. }
   function GetPageByObject(anObjectID: Integer): Integer;
    {* страница по смещению с начала. }
   function GetMMPageWidth(aIndex: Integer;
    aWIndex: Integer): Integer;
    {* ширина страницы в мм. }
   function GetMMPageHeight(aIndex: Integer;
    aWIndex: Integer): Integer;
    {* высота (длина) страницы в мм. }
   procedure DrawTo(aIndex: Integer;
    aWIndex: Integer;
    const aRect: TRect;
    aBitmap: VCLBitmap);
    {* рисует страницу в прямоугольнике на битмапе }
   function GetIntervalPages(anInterval: TafwPagesInterval;
    const aRange: Il3RangeManager = nil): TafwPrintPagesArray;
    {* получает массив страниц, по диапазону. }
   procedure Drop;
    {* сбрасывает страницы на диск. }
   function IsPagesCounter: Boolean;
    {* канва для подсчета числа страниц? }
   function PreviewPage(aIndex: Integer;
    aWIndex: Integer): IafwPreviewPage;
    {* страница preview. }
   function Get_PagesInfo: TafwPagesInfo;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FillRectPrim(const R: TRect); override;
   procedure DoFillForeRect(const R: Tl3SRect); override;
   function DoGetDrawEnabled: Boolean; override;
   function GetIsPagesCounter: Boolean; override;
   procedure ClearFields; override;
   function IsPreview: Boolean; override;
   procedure StartPage; override;
   procedure DoStartObject(anObjectID: Integer); override;
   procedure DoSetPageTop; override;
   procedure DoEndPaint; override;
  public
   constructor Create(const aPrinter: IafwPrinter;
    aIsPageCounter: Boolean;
    const aPagesInfo: TafwPagesInfo); reintroduce;
 end;//TafwPreviewCanvas

implementation

uses
 l3ImplUses
 , l3BaseWithID
 , SysUtils
 , afwFacade
 , afwPreviewPage
;

type
 TnevPage = class(Tl3BaseWithID)
  private
   f_PageNumber: Integer;
  public
   constructor Create(aParaID: Integer;
    aPageNumber: Integer); reintroduce;
 end;//TnevPage

function TnevPages.GetPageByObject(anObjectID: Integer): Integer;
 {* страница по смещению с начала. }
//#UC START# *47DFBC640050_47DFBC4F02AD_var*
var
 l_Index : Integer;  
//#UC END# *47DFBC640050_47DFBC4F02AD_var*
begin
//#UC START# *47DFBC640050_47DFBC4F02AD_impl*
 if FindData(anObjectID, l_Index) then
  Result := Pred(TnevPage(Items[l_Index]).f_PageNumber)
 else
  Result := 0;
//#UC END# *47DFBC640050_47DFBC4F02AD_impl*
end;//TnevPages.GetPageByObject

procedure TnevPages.AddParaOnPage(aParaID: Integer;
 aPageNumber: Integer);
//#UC START# *47DFBC7C0208_47DFBC4F02AD_var*
var
 l_Page : TnevPage;
//#UC END# *47DFBC7C0208_47DFBC4F02AD_var*
begin
//#UC START# *47DFBC7C0208_47DFBC4F02AD_impl*
 l_Page := TnevPage.Create(aParaID, aPageNumber);
 try
  Add(l_Page);
 finally
  FreeAndNil(l_Page);
 end;//try..finally
//#UC END# *47DFBC7C0208_47DFBC4F02AD_impl*
end;//TnevPages.AddParaOnPage

constructor TnevPage.Create(aParaID: Integer;
 aPageNumber: Integer);
//#UC START# *47DFC54203DC_47DFC50B03AF_var*
//#UC END# *47DFC54203DC_47DFC50B03AF_var*
begin
//#UC START# *47DFC54203DC_47DFC50B03AF_impl*
 inherited Create(aParaID);
 f_PageNumber := aPageNumber;
//#UC END# *47DFC54203DC_47DFC50B03AF_impl*
end;//TnevPage.Create

constructor TafwPreviewCanvas.Create(const aPrinter: IafwPrinter;
 aIsPageCounter: Boolean;
 const aPagesInfo: TafwPagesInfo);
//#UC START# *4CC69872038E_474145DE010F_var*
//#UC END# *4CC69872038E_474145DE010F_var*
begin
//#UC START# *4CC69872038E_474145DE010F_impl*
 CreateForPrinting(aPrinter);
 //etoFlags := etoFlags AND not eto_Opaque;
 f_PagesList := TafwPreviewPageList.Create;
 f_PreviewPage := nil;
 f_IsPageCounter := aIsPageCounter;
 f_PagesInfo := aPagesInfo;
//#UC END# *4CC69872038E_474145DE010F_impl*
end;//TafwPreviewCanvas.Create

function TafwPreviewCanvas.IsMonochrome: Boolean;
 {* true, если устройство назначения не поддерживает цвет; определяет, будет по-умолчанию подавлен цвет. }
//#UC START# *473C51D1005A_474145DE010F_var*
{var
 l_Device,
 l_Driver,
 l_Port : Array[0..255] of Char;
 l_hPrinter,
 l_hDeviceMode: THandle;}
//#UC END# *473C51D1005A_474145DE010F_var*
begin
//#UC START# *473C51D1005A_474145DE010F_impl*
 Result := true;
 //GetDeviceCaps(hDC(Handle), NUMCOLORS) > 0;//пока так
  {result := false;
  Printer.GetPrinter(l_Device, l_Driver, l_Port, l_hDeviceMode);
  if OpenPrinter(l_Device, l_hPrinter, nil) then
    try
      try
        result := PDeviceMode(GlobalLock(l_hDeviceMode)).dmColor <> DMCOLOR_COLOR;
      finally
        GlobalUnlock(l_hDeviceMode);
      end;
    finally
      ClosePrinter(l_hPrinter);
    end;}
//#UC END# *473C51D1005A_474145DE010F_impl*
end;//TafwPreviewCanvas.IsMonochrome

function TafwPreviewCanvas.GetPagesCount: Integer;
 {* длина документа в страницах (количество страниц "в высоту"). }
//#UC START# *473C51EB02CE_474145DE010F_var*
//#UC END# *473C51EB02CE_474145DE010F_var*
begin
//#UC START# *473C51EB02CE_474145DE010F_impl*
 if (f_PagesList = nil) then
  Result := 0
 else
  Result := f_PagesList.Count;
//#UC END# *473C51EB02CE_474145DE010F_impl*
end;//TafwPreviewCanvas.GetPagesCount

function TafwPreviewCanvas.GetPagesWidthCount(aIndex: Integer): Integer;
 {* сколько страниц в ширину, для заданной страницы. }
//#UC START# *473C52100001_474145DE010F_var*
var
 l_Page : IafwPreviewPage;
//#UC END# *473C52100001_474145DE010F_var*
begin
//#UC START# *473C52100001_474145DE010F_impl*
 l_Page := PreviewPage(aIndex, 0);
 if (l_Page = nil) then
  Result := 0
 else
  Result := l_Page.WidthCount;
//#UC END# *473C52100001_474145DE010F_impl*
end;//TafwPreviewCanvas.GetPagesWidthCount

function TafwPreviewCanvas.GetPageByObject(anObjectID: Integer): Integer;
 {* страница по смещению с начала. }
//#UC START# *473C52270357_474145DE010F_var*
//#UC END# *473C52270357_474145DE010F_var*
begin
//#UC START# *473C52270357_474145DE010F_impl*
 if (f_Pages = nil) then
  Result := 0
 else
  Result := f_Pages.GetPageByObject(anObjectID);
//#UC END# *473C52270357_474145DE010F_impl*
end;//TafwPreviewCanvas.GetPageByObject

function TafwPreviewCanvas.GetMMPageWidth(aIndex: Integer;
 aWIndex: Integer): Integer;
 {* ширина страницы в мм. }
//#UC START# *473C524A00D6_474145DE010F_var*
//#UC END# *473C524A00D6_474145DE010F_var*
begin
//#UC START# *473C524A00D6_474145DE010F_impl*
 Result := 0;
 if Assigned(PreviewPage(aIndex, aWIndex)) then
  Result := PreviewPage(aIndex, aWIndex).GetMMWidth;
//#UC END# *473C524A00D6_474145DE010F_impl*
end;//TafwPreviewCanvas.GetMMPageWidth

function TafwPreviewCanvas.GetMMPageHeight(aIndex: Integer;
 aWIndex: Integer): Integer;
 {* высота (длина) страницы в мм. }
//#UC START# *473C52670359_474145DE010F_var*
//#UC END# *473C52670359_474145DE010F_var*
begin
//#UC START# *473C52670359_474145DE010F_impl*
 Result := 0;
 if Assigned(PreviewPage(aIndex, aWIndex)) then
  Result := PreviewPage(aIndex, aWIndex).GetMMHeight;
//#UC END# *473C52670359_474145DE010F_impl*
end;//TafwPreviewCanvas.GetMMPageHeight

procedure TafwPreviewCanvas.DrawTo(aIndex: Integer;
 aWIndex: Integer;
 const aRect: TRect;
 aBitmap: VCLBitmap);
 {* рисует страницу в прямоугольнике на битмапе }
//#UC START# *473C5285001D_474145DE010F_var*
//#UC END# *473C5285001D_474145DE010F_var*
begin
//#UC START# *473C5285001D_474145DE010F_impl*
 if Assigned(PreviewPage(aIndex, aWIndex)) then
  PreviewPage(aIndex, aWIndex).DrawTo(aRect, aBitmap);
//#UC END# *473C5285001D_474145DE010F_impl*
end;//TafwPreviewCanvas.DrawTo

function TafwPreviewCanvas.GetIntervalPages(anInterval: TafwPagesInterval;
 const aRange: Il3RangeManager = nil): TafwPrintPagesArray;
 {* получает массив страниц, по диапазону. }
//#UC START# *473C583A0276_474145DE010F_var*

 type
  TMod = set of 0..1;
  
 procedure MakeResult(aMod: TMod);
 var
  l_Index : Integer;
  l_Len   : Integer;
 begin//MakeResult
  for l_Index := 0 to Pred(GetPagesCount) do
  begin
   if ((l_Index + 1) mod 2 in aMod) then
   begin
    if (aRange = nil) OR aRange.HasPage(l_Index + 1) then
    begin
     l_Len := Length(Result);
     SetLength(Result, l_Len + 1);
     with PreviewPage(l_Index, 0) do
     begin
      Result[l_Len].rNumber := PageNumber;
     end;//with PreviewPage(l_Index, 0)
    end;//aRange = nil
   end;//(l_Index + 1) mod 2 = aMod
  end;//for l_Index
 end;//MakeResult

//#UC END# *473C583A0276_474145DE010F_var*
begin
//#UC START# *473C583A0276_474145DE010F_impl*
 Result := nil;
 Case anInterval of
  afw_piOdd:
   MakeResult([1]);
  afw_piEven:
   MakeResult([0]);
  else
   if (aRange <> nil) then
    MakeResult([0, 1])
   else
    Result := nil;
 end;//Case anInterval
//#UC END# *473C583A0276_474145DE010F_impl*
end;//TafwPreviewCanvas.GetIntervalPages

procedure TafwPreviewCanvas.Drop;
 {* сбрасывает страницы на диск. }
//#UC START# *473C60A402D8_474145DE010F_var*
var
 l_Index : Integer;
//#UC END# *473C60A402D8_474145DE010F_var*
begin
//#UC START# *473C60A402D8_474145DE010F_impl*
 if (f_PagesList <> nil) then
  with f_PagesList do
   for l_Index := Lo to Hi do
    Items[l_Index].Drop(f_IsPageCounter);
//#UC END# *473C60A402D8_474145DE010F_impl*
end;//TafwPreviewCanvas.Drop

function TafwPreviewCanvas.IsPagesCounter: Boolean;
 {* канва для подсчета числа страниц? }
//#UC START# *473C60BA033E_474145DE010F_var*
//#UC END# *473C60BA033E_474145DE010F_var*
begin
//#UC START# *473C60BA033E_474145DE010F_impl*
 Result := f_IsPageCounter;
//#UC END# *473C60BA033E_474145DE010F_impl*
end;//TafwPreviewCanvas.IsPagesCounter

function TafwPreviewCanvas.PreviewPage(aIndex: Integer;
 aWIndex: Integer): IafwPreviewPage;
 {* страница preview. }
//#UC START# *473C60F60236_474145DE010F_var*
//#UC END# *473C60F60236_474145DE010F_var*
begin
//#UC START# *473C60F60236_474145DE010F_impl*
 if (f_LastPage.rPage <> nil) AND
    (f_LastPage.rY = aIndex) AND
    (f_LastPage.rX = aWIndex) then
 begin
  Result := f_LastPage.rPage;
  Exit;
 end;//f_LastPage.rPage <> nil..
 Result := nil;
 if (aIndex >= 0) and (aIndex < f_PagesList.Count) then
 begin
  Result := f_PagesList[aIndex];
  if (Result <> nil) then
   Result := Result.WidthPage(aWIndex);
 end;//aIndex >= 0
 f_LastPage.rPage := Result;
 f_LastPage.rY := aIndex;
 f_LastPage.rX := aWIndex;
//#UC END# *473C60F60236_474145DE010F_impl*
end;//TafwPreviewCanvas.PreviewPage

function TafwPreviewCanvas.Get_PagesInfo: TafwPagesInfo;
//#UC START# *4CC697810106_474145DE010Fget_var*
//#UC END# *4CC697810106_474145DE010Fget_var*
begin
//#UC START# *4CC697810106_474145DE010Fget_impl*
 Result := f_PagesInfo;
//#UC END# *4CC697810106_474145DE010Fget_impl*
end;//TafwPreviewCanvas.Get_PagesInfo

procedure TafwPreviewCanvas.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_474145DE010F_var*
//#UC END# *479731C50290_474145DE010F_var*
begin
//#UC START# *479731C50290_474145DE010F_impl*
 FreeAndNil(f_Pages);
 f_LastPage.rPage := nil;
 FreeAndNil(f_PagesList);
 inherited;
 //после inherited!
 //т.к. в inherited освобождаем канву f_PreviewPage.f_Metafile
 f_PreviewPage := nil;
//#UC END# *479731C50290_474145DE010F_impl*
end;//TafwPreviewCanvas.Cleanup

procedure TafwPreviewCanvas.FillRectPrim(const R: TRect);
//#UC START# *47DFCAAF0249_474145DE010F_var*
//#UC END# *47DFCAAF0249_474145DE010F_var*
begin
//#UC START# *47DFCAAF0249_474145DE010F_impl*
 Canvas.FillRect(R);
//#UC END# *47DFCAAF0249_474145DE010F_impl*
end;//TafwPreviewCanvas.FillRectPrim

procedure TafwPreviewCanvas.DoFillForeRect(const R: Tl3SRect);
//#UC START# *47DFCAEE0007_474145DE010F_var*
const
 D = 8;
 D1 = 3;
//#UC END# *47DFCAEE0007_474145DE010F_var*
begin
//#UC START# *47DFCAEE0007_474145DE010F_impl*
 if (R.Bottom - R.Top < D) then
 begin
  if (R.Right - R.Left < D) then
   inherited
  else
  begin
   AddRect(l3SRect(R.Left, R.Top - D1, R.Right, R.Bottom + D1));
   Line(l3SPoint(R.Left, R.Top), l3SPoint(R.Right, R.Top));
  end;//R.Right - R.Left < D
 end//R.Bottom - R.Top < D
 else
 if (R.Right - R.Left < D) then
 begin
  AddRect(l3SRect(R.Left - D1, R.Top, R.Right + D1, R.Bottom));
  Line(l3SPoint(R.Left, R.Top), l3SPoint(R.Left, R.Bottom));
 end//R.Right - R.Left < D
 else
  inherited;
//#UC END# *47DFCAEE0007_474145DE010F_impl*
end;//TafwPreviewCanvas.DoFillForeRect

function TafwPreviewCanvas.DoGetDrawEnabled: Boolean;
//#UC START# *4A4CC195011E_474145DE010F_var*
//#UC END# *4A4CC195011E_474145DE010F_var*
begin
//#UC START# *4A4CC195011E_474145DE010F_impl*
 Result := not f_IsPageCounter and inherited DoGetDrawEnabled;
//#UC END# *4A4CC195011E_474145DE010F_impl*
end;//TafwPreviewCanvas.DoGetDrawEnabled

function TafwPreviewCanvas.GetIsPagesCounter: Boolean;
//#UC START# *4CB32D4C030E_474145DE010F_var*
//#UC END# *4CB32D4C030E_474145DE010F_var*
begin
//#UC START# *4CB32D4C030E_474145DE010F_impl*
 Result := f_IsPageCounter;
//#UC END# *4CB32D4C030E_474145DE010F_impl*
end;//TafwPreviewCanvas.GetIsPagesCounter

procedure TafwPreviewCanvas.ClearFields;
begin
 f_PreviewPage := nil;
 inherited;
end;//TafwPreviewCanvas.ClearFields

function TafwPreviewCanvas.IsPreview: Boolean;
//#UC START# *56B0B9790320_474145DE010F_var*
//#UC END# *56B0B9790320_474145DE010F_var*
begin
//#UC START# *56B0B9790320_474145DE010F_impl*
 Result := True;
//#UC END# *56B0B9790320_474145DE010F_impl*
end;//TafwPreviewCanvas.IsPreview

procedure TafwPreviewCanvas.StartPage;
//#UC START# *56B4B5EF019F_474145DE010F_var*
//#UC END# *56B4B5EF019F_474145DE010F_var*
begin
//#UC START# *56B4B5EF019F_474145DE010F_impl*
 {$IfNDef l3UsePrinterForPreview}
 afw.ProcessMessages;
 {$EndIf  l3UsePrinterForPreview}
 if (f_PreviewPage = nil) then
  f_PreviewPage := TafwPreviewPage.Make(Self);
 inherited;
//#UC END# *56B4B5EF019F_474145DE010F_impl*
end;//TafwPreviewCanvas.StartPage

procedure TafwPreviewCanvas.DoStartObject(anObjectID: Integer);
//#UC START# *56B4BABD03A2_474145DE010F_var*
//#UC END# *56B4BABD03A2_474145DE010F_var*
begin
//#UC START# *56B4BABD03A2_474145DE010F_impl*
 if (anObjectID <> 0) then
 begin
  if (f_Pages = nil) then
   f_Pages := TnevPages.MakeSorted;
  f_Pages.AddParaOnPage(anObjectID, PageNumber);
 end;//anObjectID <> 0
//#UC END# *56B4BABD03A2_474145DE010F_impl*
end;//TafwPreviewCanvas.DoStartObject

procedure TafwPreviewCanvas.DoSetPageTop;
//#UC START# *56B4BBCF00D5_474145DE010F_var*
//#UC END# *56B4BBCF00D5_474145DE010F_var*
begin
//#UC START# *56B4BBCF00D5_474145DE010F_impl*
 inherited;
 if (f_PreviewPage <> nil) then
  f_PreviewPage.Finish(PageNumber, PageWidthNumber, OverallPageNumber);
//#UC END# *56B4BBCF00D5_474145DE010F_impl*
end;//TafwPreviewCanvas.DoSetPageTop

procedure TafwPreviewCanvas.DoEndPaint;
//#UC START# *56B4BDA30301_474145DE010F_var*
var
 l_PreviewPage: IafwPreviewPage;
//#UC END# *56B4BDA30301_474145DE010F_var*
begin
//#UC START# *56B4BDA30301_474145DE010F_impl*
 inherited;
 SetCanvas(nil, false);
 if (f_PreviewPage <> nil) then
 begin
  f_PagesInfo.rOverallPagesCount := f_PreviewPage.OverallPageNumber;
  if (f_PreviewPage.PageNumber = GetPagesCount) then
  begin
   l_PreviewPage := PreviewPage(f_PreviewPage.PageNumber - 1, 0);
   if Assigned(l_PreviewPage) then
   l_PreviewPage.Add(f_PreviewPage);
  end//f_PreviewPage.PageNumber = GetPagesCount
  else
   f_PagesList.Add(f_PreviewPage);
  f_PreviewPage.Drop(f_IsPageCounter);
  f_PreviewPage := nil;
 end;//f_PreviewPage <> nil
 if not Drawing AND (f_PagesInfo.rPagesCount = High(Integer)) then
  f_PagesInfo.rPagesCount := GetPagesCount;
//#UC END# *56B4BDA30301_474145DE010F_impl*
end;//TafwPreviewCanvas.DoEndPaint

end.
