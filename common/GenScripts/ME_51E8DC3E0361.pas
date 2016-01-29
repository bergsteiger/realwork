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
   {* ��������� ������ � 16-������� ���������. }
  function HexToBinEx(aText: Tl3String;
   Buffer: PAnsiChar;
   BufSize: Integer): Integer;
   {* �������������� �� 16-������ �������� ������ � �������� ������ � ��������� �������� �������� ����� � ��������� ��������� ����. }
  function Try2ReadKnownPicture(const aFiler: Tl3CustomFiler): Tl3String;
   {* �������� �������� ��������� "�������" ��������. }
  function Try2ReadEMF(const aFiler: Tl3CustomFiler): Tl3String;
   {* ������ ���������� 16-������� ������ EMF. }
  procedure SavePicture2File(aSize: Integer);
  function Try2ReadWMF(const aFiler: Tl3CustomFiler): Tl3String;
   {* ������ ���������� 16-������� ������ WMF. }
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
