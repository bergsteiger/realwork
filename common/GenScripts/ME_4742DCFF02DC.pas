unit m3DBDocumentPart;

interface

uses
 l3IntfUses
 , m3BaseObject
 , m3DBInterfaces
 , l3Filer
 , m3PrimDB
 , ActiveX
 , m3StorageInterfaces
;

type
 Tm3DBDocumentPart = class(Tm3BaseObject, Im3DBDocumentPart)
  {* ���������� ����� ���������. }
  procedure Create(aDB: Tm3PrimDB;
   const aDoc: Im3DBDocument;
   aLevel: Integer;
   aFiler: Tl3CustomFiler);
  function Make(aDB: Tm3PrimDB;
   const aDoc: Im3DBDocument;
   aLevel: Integer;
   aFiler: Tl3CustomFiler): Im3DBDocumentPart;
  function Document: Im3DBDocument;
   {* ��������, � �������� ����� ���������. }
  function Info: Tm3DBDocumentInfo;
   {* ���������� � ���������. }
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* ��������� ����� � ���������. }
  function DateTime: TDateTime;
 end;//Tm3DBDocumentPart
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m3DB
 , m2MemLib
 , m3StorageTools
 , l3String
 , m3BackupTools
 , m3NewVersionStream
 , l3Base
 , m3DBProxyWriteStream
 , l3Types
 , m3Const
 , l3ForkStream
 , m3Exceptions
 , ComObj
 , m2COMLib
 , Windows
 , l3Date
;

end.
