unit evBitmapDataObject;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evBitmapDataObject - }
{ Начат: 16.12.2004 17:51 }
{ $Id: evBitmapDataObject.pas,v 1.7 2010/11/10 18:43:05 lulin Exp $ }

// $Log: evBitmapDataObject.pas,v $
// Revision 1.7  2010/11/10 18:43:05  lulin
// {RequestLink:228689255}.
//
// Revision 1.6  2008/04/14 07:03:22  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.5  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.4  2008/02/14 17:08:54  lulin
// - cleanup.
//
// Revision 1.3  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.2.8.3  2006/12/21 14:52:18  lulin
// - cleanup.
//
// Revision 1.2.8.2  2005/09/23 16:03:54  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.2.8.1  2005/07/11 06:07:05  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.2  2005/03/30 10:14:52  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.1  2004/12/16 15:42:20  lulin
// - Print-_preview картинки полностью переведен на новый механизм.
//

{$I evDefine.inc }

interface

uses
  Windows,
  
  Graphics,
  
  l3Base,
  l3CacheableBase,

  k2Interfaces,
  
  evInternalInterfaces,

  nevBase,
  nevTools
  ;

type
  TevBitmapDataObject = class(Tl3CacheableBase, InevStorable)
    protected
    // internal fields
      f_Data    : THandle;
      f_Palette : HPALETTE;
      f_Format  : Word;
      f_DPI     : Integer;
    protected
    // interface methods
      // InevStorable
      procedure Store(const aView : InevView;
                      const G : Ik2TagGenerator;
                      aFlags  : TevStoreFlags = evDefaultStoreFlags);
        overload;
        {* - сохраняет выделение в G. }
    protected
    // internla methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aData: TBitmap; aDPI : Integer);
        reintroduce;
        {-}
      class function Make(const aData: TBitmap; aDPI : Integer): InevStorable;
        reintroduce;
        {-}
  end;//TevBitmapDataObject

implementation

uses
  evBitmapReader
  ;

// start class TevBitmapDataObject

constructor TevBitmapDataObject.Create(const aData: TBitmap; aDPI : Integer);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_DPI := aDPI;
 f_Format := CF_Bitmap;
 if (aData <> nil) then
  aData.SaveToClipboardFormat(f_Format, f_Data, f_Palette);
end;

class function TevBitmapDataObject.Make(const aData: TBitmap; aDPI : Integer): InevStorable;
  //reintroduce;
  {-}
var
 l_Object: TevBitmapDataObject;
begin
 l_Object := Create(aData, aDPI);
 try
  Result := l_Object;
 finally
  l3Free(l_Object);
 end;//try..finally
end;

procedure TevBitmapDataObject.Cleanup;
  //override;
  {-}
begin
 DeleteObject(f_Data);
 DeleteObject(f_Palette);
 f_Data := 0;
 f_Palette := 0;
 inherited;
end;

procedure TevBitmapDataObject.Store(const aView : InevView;
                                    const G : Ik2TagGenerator;
                                    aFlags  : TevStoreFlags = evDefaultStoreFlags);
  //overload;
  {* - сохраняет выделение в G. }
var
 l_Reader : TevBitmapHandleReader;
begin
 l_Reader := TevBitmapHandleReader.Make(f_Data, f_Format, f_DPI);
 try
  l_Reader.Generator := G;
  l_Reader.Execute;
 finally
  l3Free(l_Reader);
 end;//try..finally
end;


end.

