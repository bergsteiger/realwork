unit CoPDBaseDoc;

interface

uses
  PDBaseDocIntf, CogtObject, PDBaseDoc, Classes, PDBaseObjectIntf;

type

  TgtCoPDBaseDoc = class(TgtCoObject, IgtPDBaseDoc)
  public
    constructor Create; overload;
    constructor Create(ABaseDoc: TgtPDBaseDoc); overload;
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

{ TgtCoPDBaseDoc }

procedure TgtCoPDBaseDoc.AddToCollection(Value: IgtPDBaseObject);
begin

end;

procedure TgtCoPDBaseDoc.CloseDocument;
begin

end;

constructor TgtCoPDBaseDoc.Create(ABaseDoc: TgtPDBaseDoc);
begin
  gtObject := ABaseDoc;
end;

constructor TgtCoPDBaseDoc.Create;
begin
  gtObject := TgtPDBaseDoc.Create;
end;

procedure TgtCoPDBaseDoc.ForceIntermediateSave;
begin

end;

procedure TgtCoPDBaseDoc.GetDocID(var InstanceID, PermanentID: string);
begin

end;

function TgtCoPDBaseDoc.GetDocInfo: IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.GetDocRoot: IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.GetEncrypt: IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.GetHintTable: IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.GetLinearized: IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.GetMajorVersion: Integer;
begin

end;

function TgtCoPDBaseDoc.GetMinorVersion: Integer;
begin

end;

function TgtCoPDBaseDoc.GetObject(ObjectNumber: Cardinal): IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.GetObject(const ObjectPath: string): IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.GetPassword: string;
begin

end;

function TgtCoPDBaseDoc.GetTrailer: IgtPDBaseObject;
begin

end;

function TgtCoPDBaseDoc.IsFullCompressed: Boolean;
begin

end;

function TgtCoPDBaseDoc.IsLinearized: Boolean;
begin

end;

function TgtCoPDBaseDoc.IsObjectWritten(ObjectNumber: Cardinal): Boolean;
begin

end;

function TgtCoPDBaseDoc.IsPartialCompressed: Boolean;
begin

end;

procedure TgtCoPDBaseDoc.LoadDocument(FileName, APassword: string);
begin

end;

procedure TgtCoPDBaseDoc.LoadDocument(Stream: TStream; APassword: string);
begin

end;

procedure TgtCoPDBaseDoc.SaveDocument(Filename: string);
begin

end;

procedure TgtCoPDBaseDoc.SaveDocument(ASaveOptions: TPDSaveOptions);
begin

end;

procedure TgtCoPDBaseDoc.SaveDocument;
begin

end;

procedure TgtCoPDBaseDoc.SaveDocument(Stream: TStream);
begin

end;

procedure TgtCoPDBaseDoc.SetMaxDocStorage(Value: Cardinal);
begin

end;

procedure TgtCoPDBaseDoc.SetSaveOptions(const Header: string; Incremental, Full,
  Copy, Linearize, UniDirectional, UnCompressed, Compressed,
  KeepModDate: Boolean);
begin

end;

end.
