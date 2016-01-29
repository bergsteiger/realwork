unit dt_ImgContainer;

{ $Id: dt_ImgContainer.pas,v 1.2 2011/12/05 14:03:32 fireton Exp $ }

// $Log: dt_ImgContainer.pas,v $
// Revision 1.2  2011/12/05 14:03:32  fireton
// - не падаем, если файл битый
//
// Revision 1.1  2008/10/03 10:31:36  fireton
// - образом документа теперь может быть не только TIFF
//

interface
uses
 l3Base;

type
 TdtImgContainerFile = class(Tl3Base)
 private
  f_OriginalExt: string;
  f_Filename   : string;
 public
  constructor Create(aFileName: string);
  function UnwrapFile(aFileName: string): string;
  procedure WrapFile(aFileName: string);
  property Filename: string read f_Filename write f_Filename;
  property OriginalExt: string read f_OriginalExt write f_OriginalExt;
 end;

implementation
uses
 Classes,
 SysUtils,

 l3Types,
 l3Stream,

 imageenio
 ;

constructor TdtImgContainerFile.Create(aFileName: string);
var
 l_File: Tl3FileStream;
 l_ExtSize: Byte;
begin
 inherited Create;
 f_Filename := aFileName;
 if FileExists(f_Filename) then
 begin
  l_File := Tl3FileStream.Create(f_Filename, l3_fmRead);
  try
   try
    l_File.Read(l_ExtSize, 1);
    SetLength(f_OriginalExt, l_ExtSize);
    l_File.Read(f_OriginalExt[1], l_ExtSize);
   except
    f_OriginalExt := ''; // если были какие-то ошибки при чтении файла, то считаем, что ничего не было :)
   end;
  finally
   l3Free(l_File);
  end;
 end
 else
  f_OriginalExt := '';
end;

function TdtImgContainerFile.UnwrapFile(aFileName: string): string;
var
 l_Target: Tl3FileStream;
 l_File: Tl3FileStream;
 l_TargetFilename: string;
 l_HeaderSize: Integer;
begin
 Result := '';
 l_TargetFilename := ChangeFileExt(aFileName, '.'+OriginalExt);
 l_Target := Tl3FileStream.Create(l_TargetFilename, l3_fmWrite);
 try
  l_File := Tl3FileStream.Create(f_Filename, l3_fmRead);
  try
   l_HeaderSize := Length(f_OriginalExt)+1;
   l_File.Seek(l_HeaderSize, soBeginning);
   l_Target.CopyFrom(l_File, l_File.Size - l_HeaderSize);
   Result := l_TargetFilename;
  finally
   l3Free(l_File);
  end;
 finally
  l3Free(l_Target);
 end;
end;

procedure TdtImgContainerFile.WrapFile(aFileName: string);
var
 l_File: Tl3FileStream;
 l_Src : Tl3FileStream;
 l_Ext: string;
 l_Len: Byte;
begin
 if FileExists(aFileName) then
 begin
  l_File := Tl3FileStream.Create(f_Filename, l3_fmWrite);
  try
   l_Ext := ExtractFileExt(aFileName);
   if l_Ext[1] = '.' then
    l_Ext := Copy(l_Ext, 2, MaxInt);
   f_OriginalExt := l_Ext;
   l_Len := Length(f_OriginalExt);
   l_File.WriteBuffer(l_Len, 1);
   l_File.WriteBuffer(f_OriginalExt[1], l_Len);
   l_Src := Tl3FileStream.Create(aFileName, l3_fmRead);
   try
    l_File.CopyFrom(l_Src, l_Src.Size);
   finally
    l3Free(l_Src);
   end;
  finally
   l3Free(l_File);
  end;
 end
 else
  raise EFOpenError.CreateFmt('Файл %s не найден.', [aFilename]);
end;

end.