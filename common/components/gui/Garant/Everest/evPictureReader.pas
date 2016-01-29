unit evPictureReader;
{* Читатель битмапа из файла. }

{ Библиотека "Эверест"     }
{ Автор: Инишев Д.А. ©      }
{ Модуль: evPictureReader - }
{ Начат: 03.02.2011 15:15  }
{ $Id: evPictureReader.pas,v 1.4 2013/10/18 14:11:23 lulin Exp $ }

// $Log: evPictureReader.pas,v $
// Revision 1.4  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2011/02/08 09:08:09  dinishev
// [$252524029]
//
// Revision 1.2  2011/02/03 16:03:05  dinishev
// [$252524029]. Компилируемся в хеде.
//
// Revision 1.1.2.2  2011/02/03 15:38:51  dinishev
// Cleanup
//
// Revision 1.1.2.1  2011/02/03 15:15:22  dinishev
// [$252524029]. Читалка графических файлов.

{$Include evDefine.inc }

interface

uses
  Windows,

  Classes,
  Graphics,

  l3Types,
  l3Base,
  l3Stream,

  k2Base,
  k2TagGen,
  k2Reader
  ;

type
  TevPictureReader = class(Tk2CustomReader)
   {* Читатель битмапа из файла. }
    private
    {property fields}
      f_FileName : string;
      f_Stream   : Tl3FileStream;
    protected
    {internal methods}
      function pm_GetFileName: string;
      procedure pm_SetFileName(Value: string);
        {-}
    protected
    {internal methods}
      procedure Read;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
       function GetFileStream: Tl3FileStream;
    public
    // public methods
      function IsPicture: Boolean;
       {* - Проверить поддерживаемость формата и принадлежность к графике. }
      constructor Make(const aFileName: string;
                       anOwner : Tk2TagGeneratorOwner = nil);
        reintroduce;               
        {* - создает читателя. }
  end;//TevPictureReader

implementation

uses
  Document_Const,
  BitmapPara_Const,

  evGraphicFileSupport,

  //SysUtils,

  k2Tags
  ;

{ start class TevPictureReader }

constructor TevPictureReader.Make(const aFileName: string;
                                  anOwner : Tk2TagGeneratorOwner = nil);
  {* - создает читателя. }
begin
 Create(anOwner);
 f_FileName := aFileName;
end;

procedure TevPictureReader.Read;
  {override;}
  {-}
begin
 Generator.StartChild(k2_typDocument);
 try
  Generator.StartChild(k2_typBitmapPara);
  try
   Generator.AddStreamAtom(k2_tiData, GetFileStream);
  finally
   Generator.Finish;
  end;{try..finally}
 finally
  Generator.Finish;
 end;{try..finally}
end;

procedure TevPictureReader.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Stream);
 f_FileName := '';
 inherited;
end;

procedure TevPictureReader.pm_SetFileName(Value: string);
begin
 f_FileName := Value;
end;

function TevPictureReader.pm_GetFileName: string;
begin
 Result := f_FileName;
end;

function TevPictureReader.GetFileStream: Tl3FileStream;
begin
 if f_Stream = nil then
  f_Stream := Tl3FileStream.Create(f_FileName, l3_fmRead);
 Result := f_Stream;
 f_Stream.Seek(0, soBeginning);
end;

function TevPictureReader.IsPicture: Boolean;
var
 l_Stream : Tl3FileStream;
begin
 Result := evIsGraphicFile(f_FileName);
 if Result then
 begin
  l_Stream := GetFileStream;
  Result := l_Stream <> nil;
  if Result then
   Result := evIsGraphicFileStream(l_Stream)
 end; // if Result then
end;

end.

