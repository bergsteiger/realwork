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
  {* Реализация части документа. }
  procedure Create(aDB: Tm3PrimDB;
   const aDoc: Im3DBDocument;
   aLevel: Integer;
   aFiler: Tl3CustomFiler);
  function Make(aDB: Tm3PrimDB;
   const aDoc: Im3DBDocument;
   aLevel: Integer;
   aFiler: Tl3CustomFiler): Im3DBDocumentPart;
  function Document: Im3DBDocument;
   {* Документ, к которому часть относится. }
  function Info: Tm3DBDocumentInfo;
   {* Информация о документе. }
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* Открывает поток в документе. }
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
