unit evBitmapReader;
{* Читатель битмапа из памяти в формате буфера обмена. }

{ Библиотека "Эверест"     }
{ Автор: Люлин А.В. ©      }
{ Модуль: evBitmapReader - }
{ Начат: 25.02.2000 15:57  }
{ $Id: evBitmapReader.pas,v 1.15 2015/02/10 12:22:33 voba Exp $ }

// $Log: evBitmapReader.pas,v $
// Revision 1.15  2015/02/10 12:22:33  voba
// - Шурины правки
//
// Revision 1.14  2013/10/18 14:11:22  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.13  2010/11/10 18:43:05  lulin
// {RequestLink:228689255}.
//
// Revision 1.12  2009/03/04 13:32:45  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.11  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.10  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.2  2007/09/03 12:29:01  lulin
// - переименовываем тег.
//
// Revision 1.1  2006/12/15 11:46:21  lulin
// - модуль переехал в общий каталог.
//
// Revision 1.7.14.2  2006/12/15 11:30:41  lulin
// - добавлена картинка со счетчиком ссылок.
//
// Revision 1.7.14.1  2006/07/03 14:43:07  lulin
// - cleanup.
//
// Revision 1.7  2004/12/16 15:42:20  lulin
// - Print-_preview картинки полностью переведен на новый механизм.
//
// Revision 1.6  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.5  2002/12/24 13:02:01  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.4.6.1  2002/12/23 15:51:26  law
// - bug fix: не работали с хранилищем > 2Гб.
//
// Revision 1.4  2001/09/05 09:31:27  law
// - new method: TevBitmapHandleReader.Make.
//
// Revision 1.3  2001/04/25 14:56:16  law
// - comments.
//
// Revision 1.2  2000/12/15 15:10:33  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Windows,

  Classes,
  Graphics,

  l3Types,
  l3Base,

  k2Base,
  k2TagGen,
  k2Reader
  ;

type
  TevBitmapHandleReader = class(Tk2CustomReader)
   {* Читатель битмапа из памяти в формате буфера обмена. }
    private
    {property fields}
      f_Bitmap : TBitmap;
      f_Format : Word;
      f_DPI    : Integer;
      f_NeedOpenDocument : Boolean;
    protected
    {internal methods}
      function pm_GetBitmap: hBitmap;
      procedure pm_SetBitmap(Value: hBitmap);
        {-}
    protected
    {internal methods}
      procedure Read;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Make(aBitmap : hBitmap;
                       aFormat : Word = cf_Bitmap;
                       aDPI    : Integer = 0;
                       anOwner : Tk2TagGeneratorOwner = nil);
        reintroduce;
        {* - создает читателя. }
    public
    {public properties}
      property Bitmap: hBitmap
        read pm_GetBitmap
        write pm_SetBitmap;
        {* - данные картинки для чтения в формате буфера обмена. }
      property NeedOpenDocument : Boolean
        read f_NeedOpenDocument
        write f_NeedOpenDocument;  
  end;//TevBitmapHandleReader

implementation

uses
  l3Memory,
  l3Bitmap,

  k2Tags,

  Document_Const,
  BitmapPara_Const
  ;

{ start class TevBitmapHandleReader }

constructor TevBitmapHandleReader.Make(aBitmap : hBitmap;
                                       aFormat : Word = cf_Bitmap;
                                       aDPI    : Integer = 0;
                                       anOwner : Tk2TagGeneratorOwner = nil);
  {* - создает читателя. }
begin
 Create(anOwner);
 f_Format := aFormat;
 Bitmap := aBitmap;
 f_DPI := aDPI;
 f_NeedOpenDocument := true;
end;

procedure TevBitmapHandleReader.Read;
  {override;}
  {-}
var
 l_Stream : Tl3MemoryStream;
begin
 if (f_Bitmap <> nil) then
 begin
  if f_NeedOpenDocument then
   Generator.StartChild(k2_typDocument);
  try
   Generator.StartChild(k2_typBitmapPara);
   try
    l_Stream := Tl3MemoryStream.Create;
    try
     f_Bitmap.SaveToStream(l_Stream);
     l_Stream.Seek(0, soBeginning);
     if (f_DPI > 0) then
      Generator.AddIntegerAtom(k2_tiDPI, f_DPI);
     Generator.AddStreamAtom(k2_tiData, l_Stream);
    finally
     l3Free(l_Stream);
    end;{try..finally}
   finally
    Generator.Finish;
   end;{try..finally}
  finally
   if f_NeedOpenDocument then
    Generator.Finish;
  end;{try..finally}
 end;{f_Bitmap <> nil}
end;

procedure TevBitmapHandleReader.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Bitmap);
 inherited;
end;

function TevBitmapHandleReader.pm_GetBitmap: hBitmap;
  {-}
begin
 if (f_Bitmap = nil) then
  Result := 0
 else
  Result := f_Bitmap.Handle; 
end;

procedure TevBitmapHandleReader.pm_SetBitmap(Value: hBitmap);
  {-}
begin
 if (Value <> Bitmap) then begin
  if (Value = 0) then
   l3Free(f_Bitmap)
  else begin
   if (f_Bitmap = nil) then f_Bitmap := Tl3Bitmap.Create;
   f_Bitmap.LoadFromClipboardFormat(f_Format, Value, 0);
  end;{Value = 0}
 end;{Value <> Bitmap}
end;

end.

