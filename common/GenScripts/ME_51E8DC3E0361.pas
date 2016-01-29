unit ddPicture;

interface

uses
 l3IntfUses
 , ddTextParagraph
 , Classes
 , l3Base
 , l3MetafileHeader
 , l3Filer
 , ddParagraphProperty
 , ddCustomDestination
 , k2Interfaces
 , ddDocumentAtom
 , l3ProtoObject
;

type
 TddPicture = class(TddTextParagraph)
  procedure CropPicture;
  procedure ConvertToBin;
  procedure ConvertToHex;
  procedure AddHexData(aHexStream: Tl3String);
   {* Добавляем строку с 16-ричными символами. }
  function HexToBinEx(aText: Tl3String;
   Buffer: PAnsiChar;
   BufSize: Integer): Integer;
   {* Преобразование из 16-ричной текстовй строки в бинарные данные с пропуском символов переноса стоки и поддержки заглавных букв. }
  function Try2ReadKnownPicture(const aFiler: Tl3CustomFiler): Tl3String;
   {* Пытаемся передать обработку "знающим" объектам. }
  function Try2ReadEMF(const aFiler: Tl3CustomFiler): Tl3String;
   {* Чтение текстового 16-ричного потока EMF. }
  procedure SavePicture2File(aSize: Integer);
  function Try2ReadWMF(const aFiler: Tl3CustomFiler): Tl3String;
   {* Чтение текстового 16-ричного потока WMF. }
  function Clone(aPAP: TddParagraphProperty): TddPicture;
  function CreateFromFile(const aPath: AnsiString): TddPicture;
  procedure Try2ReadBinaryData(const aFiler: Tl3CustomFiler;
   aSize: Integer);
  procedure Try2RecalcPictureProps;
 end;//TddPicture
 
implementation

uses
 l3ImplUses
 , imageenview
 , l3Chars
 , l3Memory
 , SysUtils
 , ddRTFUnits
 , imageenio
 , k2Tags
 , l3Math
 , evdTypes
 , ddTypes
 , ddEVDTypesSupport
 , ddConst
 , l3ImageUtils
 , l3Metafile
 , Graphics
 , ddHexCharReader
 , Windows
 , ddPicturePathListner
;

end.
