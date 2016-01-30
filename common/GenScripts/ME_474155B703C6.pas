unit afwPreviewPage;
 {* ������, ����������� �������� preview. }

// ������: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas"
// ���������: "SimpleClass"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , l3Metafile
 , afwPreviewPageList
 , l3Canvas
 , l3InternalInterfaces
 , l3Core
 , l3Interfaces
;

type
 TafwPreviewPage = class(Tl3ProtoObject, IafwPreviewPage)
  {* ������, ����������� �������� preview. }
  private
   f_WidthPages: TafwPreviewPageList;
   f_PageNumber: Integer;
    {* ���� ��� �������� PageNumber }
   f_PageWidthNumber: Integer;
    {* ���� ��� �������� PageWidthNumber }
   f_Metafile: Tl3Metafile;
    {* ���� ��� �������� Metafile }
   f_HORZRES: Integer;
    {* ���� ��� �������� HORZRES }
   f_VERTRES: Integer;
    {* ���� ��� �������� VERTRES }
   f_LOGPIXELSX: Integer;
    {* ���� ��� �������� LOGPIXELSX }
   f_LOGPIXELSY: Integer;
    {* ���� ��� �������� LOGPIXELSY }
   f_PHYSICALWIDTH: Integer;
    {* ���� ��� �������� PHYSICALWIDTH }
   f_PHYSICALHEIGHT: Integer;
    {* ���� ��� �������� PHYSICALHEIGHT }
   f_PHYSICALOFFSETX: Integer;
    {* ���� ��� �������� PHYSICALOFFSETX }
   f_PHYSICALOFFSETY: Integer;
    {* ���� ��� �������� PHYSICALOFFSETY }
   f_DropStream: IafwTempStream;
    {* ���� ��� �������� DropStream }
   f_OverallPageNumber: Integer;
    {* ���� ��� �������� OverallPageNumber }
  protected
   procedure Start(aCanvas: Tl3Canvas);
    {* ������ ��������� ��������. }
   procedure InitCanvas(aCanvas: Tl3Canvas);
   procedure ReadDCMetrics(const aCanvas: Il3InfoCanvas);
   function pm_GetPageNumber: Integer;
   function pm_GetPageWidthNumber: Integer;
   procedure Add(const aPage: IafwPreviewPage);
    {* ��������� �������� � ������. }
   procedure Drop(aCounter: Boolean);
    {* ���������� �������� �� ����. }
   procedure Finish(aPageNumber: Integer;
    aPageWidthNumber: Integer;
    anOverallPageNumber: Integer);
    {* ��������� ���������� ��������. }
   function GetMMWidth: Integer;
    {* ������ �������� � ��. }
   function GetMMHeight: Integer;
    {* ������ (�����) �������� � ��. }
   procedure DrawTo(const aRect: TRect;
    aBitmap: VCLBitmap);
    {* ������ �������� � �������������� �� ������� }
   function WidthCount: Integer;
    {* ���������� ������� � ������. }
   function WidthPage(anIndex: Integer): IafwPreviewPage;
    {* �������� � ������. }
   function Get_OverallPageNumber: Integer;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(aCanvas: Tl3Canvas); reintroduce;
   class function Make(aCanvas: Tl3Canvas): IafwPreviewPage; reintroduce;
  protected
   property Metafile: Tl3Metafile
    read f_Metafile;
   property HORZRES: Integer
    read f_HORZRES;
   property VERTRES: Integer
    read f_VERTRES;
   property LOGPIXELSX: Integer
    read f_LOGPIXELSX;
   property LOGPIXELSY: Integer
    read f_LOGPIXELSY;
   property PHYSICALWIDTH: Integer
    read f_PHYSICALWIDTH;
   property PHYSICALHEIGHT: Integer
    read f_PHYSICALHEIGHT;
   property PHYSICALOFFSETX: Integer
    read f_PHYSICALOFFSETX;
   property PHYSICALOFFSETY: Integer
    read f_PHYSICALOFFSETY;
  public
   property PageNumber: Integer
    read f_PageNumber;
    {* ����� ��������. }
   property PageWidthNumber: Integer
    read f_PageWidthNumber;
    {* ����� �������� �� ������. }
   property DropStream: IafwTempStream
    read f_DropStream;
   property OverallPageNumber: Integer
    read f_OverallPageNumber;
 end;//TafwPreviewPage

implementation

uses
 l3ImplUses
 , SysUtils
 , l3DataCache
 , l3Math
 , l3Const
 , Graphics
 , Windows
 {$If Defined(nsTest)}
 , afwPreviewPageSpy
 {$IfEnd} // Defined(nsTest)
;

const
 c_MMPerInch = l3mmInInch * 10;

constructor TafwPreviewPage.Create(aCanvas: Tl3Canvas);
//#UC START# *4CB6E48501B8_474155B703C6_var*
//#UC END# *4CB6E48501B8_474155B703C6_var*
begin
//#UC START# *4CB6E48501B8_474155B703C6_impl*
 inherited Create;

 f_Metafile := nil;

 f_HORZRES := 0;
 f_VERTRES := 0;
 f_LOGPIXELSX := 0;
 f_LOGPIXELSY := 0;
 f_PHYSICALWIDTH := 0;
 f_PHYSICALHEIGHT := 0;
 f_PHYSICALOFFSETX := 0;
 f_PHYSICALOFFSETY := 0;
 Start(aCanvas);
//#UC END# *4CB6E48501B8_474155B703C6_impl*
end;//TafwPreviewPage.Create

class function TafwPreviewPage.Make(aCanvas: Tl3Canvas): IafwPreviewPage;
var
 l_Inst : TafwPreviewPage;
begin
 l_Inst := Create(aCanvas);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TafwPreviewPage.Make

procedure TafwPreviewPage.Start(aCanvas: Tl3Canvas);
 {* ������ ��������� ��������. }
//#UC START# *47DFDAB403DA_474155B703C6_var*
//#UC END# *47DFDAB403DA_474155B703C6_var*
begin
//#UC START# *47DFDAB403DA_474155B703C6_impl*
 if (f_Metafile = nil) then
  f_Metafile := Tl3Metafile.Create;
 ReadDCMetrics(aCanvas);
 InitCanvas(aCanvas);
//#UC END# *47DFDAB403DA_474155B703C6_impl*
end;//TafwPreviewPage.Start

procedure TafwPreviewPage.InitCanvas(aCanvas: Tl3Canvas);
//#UC START# *47E0CA2E0263_474155B703C6_var*
//#UC END# *47E0CA2E0263_474155B703C6_var*
begin
//#UC START# *47E0CA2E0263_474155B703C6_impl*
 if (aCanvas <> nil) then
  aCanvas.SetCanvas(TMetafileCanvas.Create(Metafile, aCanvas.DC), false);
//#UC END# *47E0CA2E0263_474155B703C6_impl*
end;//TafwPreviewPage.InitCanvas

procedure TafwPreviewPage.ReadDCMetrics(const aCanvas: Il3InfoCanvas);
//#UC START# *47E0CA4A006B_474155B703C6_var*
//#UC END# *47E0CA4A006B_474155B703C6_var*
begin
//#UC START# *47E0CA4A006B_474155B703C6_impl*
 f_HORZRES := aCanvas.DeviceCaps(Windows.HORZRES);
 f_VERTRES := aCanvas.DeviceCaps(Windows.VERTRES);
 f_LOGPIXELSX := aCanvas.DeviceCaps(Windows.LOGPIXELSX);
 f_LOGPIXELSY := aCanvas.DeviceCaps(Windows.LOGPIXELSY);
 f_PHYSICALWIDTH := aCanvas.DeviceCaps(Windows.PHYSICALWIDTH);
 f_PHYSICALHEIGHT := aCanvas.DeviceCaps(Windows.PHYSICALHEIGHT);
 f_PHYSICALOFFSETX := aCanvas.DeviceCaps(Windows.PHYSICALOFFSETX);
 f_PHYSICALOFFSETY := aCanvas.DeviceCaps(Windows.PHYSICALOFFSETY);
//#UC END# *47E0CA4A006B_474155B703C6_impl*
end;//TafwPreviewPage.ReadDCMetrics

function TafwPreviewPage.pm_GetPageNumber: Integer;
//#UC START# *4728BE6A0392_474155B703C6get_var*
//#UC END# *4728BE6A0392_474155B703C6get_var*
begin
//#UC START# *4728BE6A0392_474155B703C6get_impl*
 Result := f_PageNumber;
//#UC END# *4728BE6A0392_474155B703C6get_impl*
end;//TafwPreviewPage.pm_GetPageNumber

function TafwPreviewPage.pm_GetPageWidthNumber: Integer;
//#UC START# *4728BE830080_474155B703C6get_var*
//#UC END# *4728BE830080_474155B703C6get_var*
begin
//#UC START# *4728BE830080_474155B703C6get_impl*
 Result := f_PageWidthNumber;
//#UC END# *4728BE830080_474155B703C6get_impl*
end;//TafwPreviewPage.pm_GetPageWidthNumber

procedure TafwPreviewPage.Add(const aPage: IafwPreviewPage);
 {* ��������� �������� � ������. }
//#UC START# *473D824A0357_474155B703C6_var*
//#UC END# *473D824A0357_474155B703C6_var*
begin
//#UC START# *473D824A0357_474155B703C6_impl*
 if (aPage <> nil) then
 begin
  if (f_WidthPages = nil) then
   f_WidthPages := TafwPreviewPageList.Make;
  f_WidthPages.Add(aPage);
 end;//aPage <> nil
//#UC END# *473D824A0357_474155B703C6_impl*
end;//TafwPreviewPage.Add

procedure TafwPreviewPage.Drop(aCounter: Boolean);
 {* ���������� �������� �� ����. }
//#UC START# *473D826601A8_474155B703C6_var*
var
 l_Stream : IStream;
 l_Index  : Integer;
//#UC END# *473D826601A8_474155B703C6_var*
begin
//#UC START# *473D826601A8_474155B703C6_impl*
 if (f_MetaFile <> nil) then
 begin
  {.$IfNDef nsTest}
  if aCounter then
  begin
   FreeAndNil(f_MetaFile);
   {$IfDef nsTest}
   if TafwPreviewPageSpy.Exists then
    TafwPreviewPageSpy.Instance.IncCounterNumber;
   {$EndIf nsTest}
  end
  else
  {.$EndIf  nsTest}
  if (f_DropStream = nil) then
  begin
   {$IfDef nsTest}
   if TafwPreviewPageSpy.Exists then
    TafwPreviewPageSpy.Instance.LogPage(Self, aCounter);
   {$EndIf nsTest}
   f_DropStream := TevDataCache.CreateTempStream;
   try
    l_Stream := f_DropStream.MakeForWrite;
    try
     MetaFile.SaveToIStream(l_Stream);
    finally
     l_Stream := nil;
    end;//try..finally
    FreeAndNil(f_MetaFile);
   except
    f_DropStream := nil;
    raise;
   end;//try..except
(*   {$IfDef nsTest}
   if (f_DropStream <> nil) then
   begin
    if TafwPreviewPageSpy.Exists then
     TafwPreviewPageSpy.Instance.LogPage(Self, aCounter);
    if aCounter then
     f_DropStream := nil;
   end;//f_DropStream <> nil
   {$EndIf nsTest}*)
  end//f_DropStream = nil
  else
   FreeAndNil(f_MetaFile);
 end;//f_MetaFile <> nil
 for l_Index := 1 to Pred(WidthCount) do
  WidthPage(l_Index).Drop(aCounter);
//#UC END# *473D826601A8_474155B703C6_impl*
end;//TafwPreviewPage.Drop

procedure TafwPreviewPage.Finish(aPageNumber: Integer;
 aPageWidthNumber: Integer;
 anOverallPageNumber: Integer);
 {* ��������� ���������� ��������. }
//#UC START# *473D8274005E_474155B703C6_var*
//#UC END# *473D8274005E_474155B703C6_var*
begin
//#UC START# *473D8274005E_474155B703C6_impl*
 f_PageNumber := aPageNumber;
 f_PageWidthNumber := aPageWidthNumber;
 f_OverallPageNumber := anOverallPageNumber;
//#UC END# *473D8274005E_474155B703C6_impl*
end;//TafwPreviewPage.Finish

function TafwPreviewPage.GetMMWidth: Integer;
 {* ������ �������� � ��. }
//#UC START# *473D828E03A5_474155B703C6_var*
//#UC END# *473D828E03A5_474155B703C6_var*
begin
//#UC START# *473D828E03A5_474155B703C6_impl*
 Result := l3MulDiv(PHYSICALWIDTH, c_MMPerInch, LOGPIXELSX);
//#UC END# *473D828E03A5_474155B703C6_impl*
end;//TafwPreviewPage.GetMMWidth

function TafwPreviewPage.GetMMHeight: Integer;
 {* ������ (�����) �������� � ��. }
//#UC START# *473D82A102B2_474155B703C6_var*
//#UC END# *473D82A102B2_474155B703C6_var*
begin
//#UC START# *473D82A102B2_474155B703C6_impl*
 Result := l3MulDiv(PHYSICALHEIGHT, c_MMPerInch, LOGPIXELSY);
//#UC END# *473D82A102B2_474155B703C6_impl*
end;//TafwPreviewPage.GetMMHeight

procedure TafwPreviewPage.DrawTo(const aRect: TRect;
 aBitmap: VCLBitmap);
 {* ������ �������� � �������������� �� ������� }
//#UC START# *473D82B5021A_474155B703C6_var*
var
 l_Rect   : TRect;
 l_Stream : IStream;
//#UC END# *473D82B5021A_474155B703C6_var*
begin
//#UC START# *473D82B5021A_474155B703C6_impl*
 if (Metafile = nil) AND (f_DropStream <> nil) then
 begin
  f_Metafile := Tl3Metafile.Create;
  l_Stream := f_DropStream.MakeForRead;
  try
   f_Metafile.LoadFromIStream(l_Stream);
  finally
   l_Stream := nil;
  end;//try..finally
 end;//Metafile = nil
 if (MetaFile <> nil) then
 begin
  l_Rect.Left := (aRect.Right - aRect.Left)*PHYSICALOFFSETX div PHYSICALWIDTH + aRect.Left;
  l_Rect.Top := (aRect.Bottom - aRect.Top)*PHYSICALOFFSETY div PHYSICALHEIGHT + aRect.Top;
  l_Rect.Right := (aRect.Right - aRect.Left)*(PHYSICALOFFSETX + HORZRES) div PHYSICALWIDTH + 1 + aRect.Left;
  l_Rect.Bottom := (aRect.Bottom - aRect.Top)*(PHYSICALOFFSETY + VERTRES) div PHYSICALHEIGHT + 1 + aRect.Top;
  aBitmap.Canvas.StretchDraw(l_Rect, Metafile);
 end;//MetaFile <> nil
//#UC END# *473D82B5021A_474155B703C6_impl*
end;//TafwPreviewPage.DrawTo

function TafwPreviewPage.WidthCount: Integer;
 {* ���������� ������� � ������. }
//#UC START# *473D82CD0066_474155B703C6_var*
//#UC END# *473D82CD0066_474155B703C6_var*
begin
//#UC START# *473D82CD0066_474155B703C6_impl*
 if (f_WidthPages = nil) then
  Result := 1
 else
  Result := f_WidthPages.Count + 1;
//#UC END# *473D82CD0066_474155B703C6_impl*
end;//TafwPreviewPage.WidthCount

function TafwPreviewPage.WidthPage(anIndex: Integer): IafwPreviewPage;
 {* �������� � ������. }
//#UC START# *473D82E20016_474155B703C6_var*
//#UC END# *473D82E20016_474155B703C6_var*
begin
//#UC START# *473D82E20016_474155B703C6_impl*
 if (anIndex = 0) then
  Result := Self
 else
 if (f_WidthPages = nil) then
  Result := nil
 else
  Result := f_WidthPages[anIndex-1];
//#UC END# *473D82E20016_474155B703C6_impl*
end;//TafwPreviewPage.WidthPage

function TafwPreviewPage.Get_OverallPageNumber: Integer;
//#UC START# *4CC68B5D00CA_474155B703C6get_var*
//#UC END# *4CC68B5D00CA_474155B703C6get_var*
begin
//#UC START# *4CC68B5D00CA_474155B703C6get_impl*
 Result := f_OverallPageNumber;
//#UC END# *4CC68B5D00CA_474155B703C6get_impl*
end;//TafwPreviewPage.Get_OverallPageNumber

procedure TafwPreviewPage.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_474155B703C6_var*
//#UC END# *479731C50290_474155B703C6_var*
begin
//#UC START# *479731C50290_474155B703C6_impl*
 FreeAndNil(f_WidthPages);
 f_DropStream := nil;
 FreeAndNil(f_Metafile);
 inherited;
//#UC END# *479731C50290_474155B703C6_impl*
end;//TafwPreviewPage.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TafwPreviewPage.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_474155B703C6_var*
//#UC END# *47A6FEE600FC_474155B703C6_var*
begin
//#UC START# *47A6FEE600FC_474155B703C6_impl*
 Result := true;
//#UC END# *47A6FEE600FC_474155B703C6_impl*
end;//TafwPreviewPage.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TafwPreviewPage.ClearFields;
begin
 f_DropStream := nil;
 inherited;
end;//TafwPreviewPage.ClearFields

end.
