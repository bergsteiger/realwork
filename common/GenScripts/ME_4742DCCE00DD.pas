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
  {* ���������� ���������. }
  procedure Create(aDB: Tm3PrimDB;
   anID: Integer);
  function Make(aDB: Tm3PrimDB;
   anID: Integer): Im3DBDocument;
  function ID: Integer;
   {* ������������� ���������. }
  procedure Delete;
   {* ������� �������� �� ���������. }
  function Undelete: Boolean;
   {* ��������������� ��������. }
  function GetConst: Im3DBDocumentPart;
   {* ���������� ����� ���������. }
  function GetVersion(aLevel: Integer): Im3DBDocumentPart;
   {* ���������� ����� ���������. }
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* ������� ��������. }
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
