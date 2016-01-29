unit ChromeLikeTabGlyph;

interface
uses
 Classes,
 Graphics,
 ImgList,
 l3ProtoObject,
 vgBitmap;

type
 TChromeLikeTabGlyph = class;

 TChromeLikeTabGlyphChangedEvent = procedure(aGlyph: TChromeLikeTabGlyph) of object;

 TChromeLikeTabGlyphGetImageEvent = procedure(aImageList: TCustomImageList;
  var aImageIndex: Integer) of object;

 TChromeLikeTabGlyph = class(Tl3ProtoObject)
 private
  f_OnGlyphChanged: TChromeLikeTabGlyphChangedEvent;
  f_Bitmap: TvgBitmap;
  f_Width: Integer;
  f_Height: Integer;
  f_IsEmpty: Boolean;
  f_Images: TCustomImageList;
  f_ImageIndex: Integer;
  f_OnGetImage: TChromeLikeTabGlyphGetImageEvent;
  procedure CallGlyphChanged;
  procedure ResizeBitmap;
  procedure CheckSize(aGraphic: TGraphic);
  procedure pm_SetHeight(aValue: Integer);
  procedure pm_SetWidth(aValue: Integer);
  procedure pm_SetImages(aValue: TCustomImageList);
  procedure pm_SetImageIndex(aValue: Integer);
  procedure AssignFromImageList;
  procedure LoadFromStream(aStream: TStream);
 protected
  procedure CleanUp; override;
 public
  procedure AssignFromGraphic(aGraphic: TGraphic);
  constructor Create(aWidth: Integer; aHeight: Integer;
   aOnGlyphChanged: TChromeLikeTabGlyphChangedEvent); reintroduce;
  property Height: Integer
   read f_Height
   write pm_SetHeight;
  property Width: Integer
   read f_Width
   write pm_SetWidth;
  property IsEmpty: Boolean
   read f_IsEmpty;
  property Bitmap: TvgBitmap
   read f_Bitmap;
  property Images: TCustomImageList
   read f_Images
   write pm_SetImages;
  property ImageIndex: Integer
   read f_ImageIndex
   write pm_SetImageIndex;
  property OnGetImage: TChromeLikeTabGlyphGetImageEvent
   read f_OnGetImage
   write f_OnGetImage;
 end;

implementation
uses
 SysUtils,
 l3Base,
 vg_scene,
 vtInterfaces;

{ TChromeLikeTabGlyph }


procedure TChromeLikeTabGlyph.AssignFromGraphic(aGraphic: TGraphic);
var
 l_Stream: TStream;
begin
 Assert(aGraphic <> nil);
 l_Stream := TMemoryStream.Create;
 try
  l_Stream.Seek(0, soFromBeginning);
  aGraphic.SaveToStream(l_Stream);
  LoadFromStream(l_Stream);
 finally
  FreeAndNil(l_Stream);
 end;
end;


procedure TChromeLikeTabGlyph.CallGlyphChanged;
begin
 if Assigned(f_OnGlyphChanged) then
  f_OnGlyphChanged(Self);
end;

procedure TChromeLikeTabGlyph.CleanUp;
begin
 inherited;
 FreeAndNil(f_Bitmap);
end;

constructor TChromeLikeTabGlyph.Create(aWidth: Integer; aHeight: Integer;
 aOnGlyphChanged: TChromeLikeTabGlyphChangedEvent);
begin
 inherited Create;
 f_Bitmap := TvgBitmap.Create(aWidth, aHeight);
 f_IsEmpty := True;
 f_OnGlyphChanged := aOnGlyphChanged;
 f_Width := aWidth;
 f_Height := aHeight;
 f_ImageIndex := -1;
 ResizeBitmap;
end;

procedure TChromeLikeTabGlyph.pm_SetHeight(aValue: Integer);
begin
 if (aValue <> f_Height) then
 begin
  f_Height := aValue;
  ResizeBitmap;
 end;
end;

procedure TChromeLikeTabGlyph.pm_SetWidth(aValue: Integer);
begin
 if (aValue <> f_Width) then
 begin
  f_Width := aValue;
  ResizeBitmap;
 end;
end;

procedure TChromeLikeTabGlyph.pm_SetImages(aValue: TCustomImageList);
begin
 if (aValue <> f_Images) then
 begin
  f_Images := aValue;
  f_Width := aValue.Width;
  f_Height :=  aValue.Height;
  ResizeBitmap;
  if (f_ImageIndex <> -1) then
   AssignFromImageList;
 end;
end;

procedure TChromeLikeTabGlyph.pm_SetImageIndex(aValue: Integer);
begin
 if (aValue <> f_ImageIndex) then
 begin
  f_ImageIndex := aValue;
  if (f_Images <> nil) then
   AssignFromImageList;
 end;
end;

procedure TChromeLikeTabGlyph.AssignFromImageList;
var
 l_Stream: TStream;
 l_Images: IvtFlashImageList;
begin
 if (f_Images <> nil) and (f_ImageIndex <> -1) then
  if Supports(f_Images, IvtFlashImageList, l_Images) then
  begin
   l_Stream := TMemoryStream.Create;
   try
    l_Images.SaveImageToStream(l_Stream, f_ImageIndex, bpp24);
    LoadFromStream(l_Stream);
   finally
    FreeAndNil(l_Stream);
   end;
  end
  else
   Assert(False, 'ѕо-другому - иконка будет непрозрачна€');
end;

procedure TChromeLikeTabGlyph.LoadFromStream(aStream: TStream);
begin
 Assert(aStream <> nil);
 aStream.Seek(0, soFromBeginning);
 f_Bitmap.Clear;
 f_Bitmap.LoadFromStream(aStream);
 f_IsEmpty := False;
 CallGlyphChanged;
end;

procedure TChromeLikeTabGlyph.ResizeBitmap;
begin
 f_Bitmap.Clear;
 f_Bitmap.Width := f_Width;
 f_Bitmap.Height := f_Height;
 CallGlyphChanged;
end;

procedure TChromeLikeTabGlyph.CheckSize(aGraphic: TGraphic);
begin
 Assert(aGraphic <> nil);
 if (aGraphic.Height <> Height) or (aGraphic.Width <> Width) then
 begin
  f_Width := aGraphic.Width;
  f_Height := aGraphic.Height;
  ResizeBitmap;
 end;
end;

end.
 