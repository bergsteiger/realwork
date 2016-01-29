unit arImageUtils;

{ $Id: arImageUtils.pas,v 1.1 2008/10/17 13:25:29 fireton Exp $ }

// $Log: arImageUtils.pas,v $
// Revision 1.1  2008/10/17 13:25:29  fireton
// - возможность присоединения образов-некартинок
//

interface
uses
 Graphics;

function BuildFileIcon(aFileName: string): TBitmap;

implementation
uses
 Types,

 l3Base,
 l3ShellUtils;

function BuildFileIcon(aFileName: string): TBitmap;
var
 l_Name : string;
 l_Width : Integer;
 l_Bmp: TBitmap;
begin
 Result := TBitmap.Create;
 with Result do
 begin
  Width := 64;
  Height := 64;
  PixelFormat := pf24bit;
  l_Name := l3RetrieveAssociatedDescription(aFileName);
  Canvas.Font.Color := clBlack;
  Canvas.Font.Name := 'Arial';
  Canvas.Font.Size := 11;
  l_Width := Canvas.TextWidth(l_Name);
  if l_Width > Width then
   Width := l_Width;
  Height := Height + Canvas.TextHeight(l_Name) + 5;
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(Rect(0, 0, MaxInt, MaxInt));
  l_Bmp := l3RetrieveAssociatedIconPicture(aFileName, clBtnFace);
  try
   Canvas.CopyMode := cmSrcCopy;
   Canvas.StretchDraw(Rect(Width div 2 - 32, 0, Width div 2 + 32, 64), l_Bmp);
  finally
   l3Free(l_Bmp);
  end;
  Canvas.TextOut(Width div 2 - l_Width div 2, 64 + 5, l_Name);
 end;
end;

end.