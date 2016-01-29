unit PDBaseDocIntf;

interface

uses
  gtObjectIntf, PDDocumentIntf, PDBaseObjectIntf, Classes;

type

  TPDSaveOptions = packed record
    Header: widestring;
    Incremental: Boolean;
    Full: Boolean;
    Copy: Boolean;
    Linearize: Boolean;
    UniDirectional: Boolean;
    KeepModDate: Boolean;
    UnCompressed: Boolean;
    Compressed: Boolean;
  end;

  IgtPDBaseDoc = Interface(IgtObject)
    procedure LoadDocument(FileName: string; APassword: string); overload;
    procedure LoadDocument(Stream: TStream; APassword: string); overload;

    procedure SaveDocument; overload;
    procedure SaveDocument(Stream: TStream); overload;
    procedure SaveDocument(Filename: string); overload;

    procedure SaveDocument(ASaveOptions: TPDSaveOptions); overload;
//    procedure SaveDocument(Stream: TStream; ASaveOptions:
//      TgtPDSaveOptions); overload;
//    procedure SaveDocument(Filename: string; ASaveOptions:
//      TgtPDSaveOptions); overload;

    procedure CloseDocument;

    procedure ForceIntermediateSave;

//    procedure EnumerateObjects(EnumObjects: TgtEnumObjectsEvent);

    procedure GetDocID(var InstanceID: string; var PermanentID: string);
    function GetDocInfo: IgtPDBaseObject;
    function GetDocRoot: IgtPDBaseObject;
    function GetEncrypt: IgtPDBaseObject;
    function GetTrailer: IgtPDBaseObject;
    function GetLinearized: IgtPDBaseObject;
    function GetHintTable: IgtPDBaseObject;
    function GetPassword: string;

    function GetObject(const ObjectPath: string): IgtPDBaseObject; overload;
    function GetObject(ObjectNumber: Cardinal): IgtPDBaseObject; overload;
    function IsObjectWritten(ObjectNumber: Cardinal): Boolean;

    procedure AddToCollection(Value: IgtPDBaseObject);

    function IsFullCompressed: Boolean;
    function IsPartialCompressed: Boolean;
    function IsLinearized: Boolean;

//    function GetPermissions: TgtUserPermissions;

    procedure SetSaveOptions(const Header: string; Incremental, Full, Copy,
      Linearize, UniDirectional, UnCompressed, Compressed, KeepModDate: Boolean);

    procedure SetMaxDocStorage(Value: Cardinal);

    function GetMajorVersion: Integer;
    function GetMinorVersion: Integer;

//    function GetCollection: TgtPDCollection;
//    function GetEncryptSettings: TgtEncryptionSettings;
//    function GetIsEncrypted: Boolean;
//    function GetReader: TgtPDReader;
//    function GetSaveOptions: TgtPDSaveOptions;
//    function GetWriter: TgtPDWriter;

  end;

implementation

end.
