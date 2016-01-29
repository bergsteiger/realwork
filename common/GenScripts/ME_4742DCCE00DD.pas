unit m3DBDocument;

interface

uses
 l3IntfUses
 , m3BaseObject
 , m3DBInterfaces
 , m3PrimDB
 , ActiveX
 , m3StorageInterfaces
;

type
 Tm3DBDocument = class(Tm3BaseObject, Im3DBDocument)
  {* Реализация документа. }
  procedure Create(aDB: Tm3PrimDB;
   anID: Integer);
  function Make(aDB: Tm3PrimDB;
   anID: Integer): Im3DBDocument;
  function ID: Integer;
   {* Идентификатор документа. }
  procedure Delete;
   {* Удаляет документ из хранилища. }
  function Undelete: Boolean;
   {* Восстанавливает документ. }
  function GetConst: Im3DBDocumentPart;
   {* Постоянная часть документа. }
  function GetVersion(aLevel: Integer): Im3DBDocumentPart;
   {* Переменная часть документа. }
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* открыть документ. }
  function GetFreeObjectID: Integer;
  procedure DeleteObject(aObjID: Integer);
 end;//Tm3DBDocument
 
implementation

uses
 l3ImplUses
 , m3DBDocumentPart
 , m3DB
;

end.
