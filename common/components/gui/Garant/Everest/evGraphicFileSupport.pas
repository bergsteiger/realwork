unit evGraphicFileSupport;

interface

uses
 Classes,

 imageenio;

const
 cioSupportedGraphicsFiles = [ioBMP, ioJPEG, ioGIF, ioPNG];

 function evIsGraphicFile(const aFileName: string): Boolean;
 function evIsGraphicFileStream(const aStream: TStream): Boolean;
 function evAddSupportedGraphicsFilters(const aSource: string): string;

implementation

uses
 SysUtils;

function evIsGraphicFileStream(const aStream: TStream): Boolean;
var
 l_FileType : TIOFileType;
begin
 l_FileType := FindStreamFormat(aStream);
 Result := l_FileType in cioSupportedGraphicsFiles;
end;

function evIsGraphicFile(const aFileName: string): Boolean;
var
 l_Ext: string;
begin
 l_Ext := LowerCase(ExtractFileExt(aFileName));
 Result := (l_Ext = '.bmp') or (l_Ext = '.jpg') or (l_Ext = '.gif') or (l_Ext = '.png');
end;

function evAddSupportedGraphicsFilters(const aSource: string): string;
begin
 Result := aSource + '|BMP-פאיכ (*.bmp)|*.bmp|PNG-פאיכ (*.png)|*.png|JPG-פאיכ (*.jpg)|*.jpg|GIF-פאיכ (*.gif)|*.gif'
end;

end.
