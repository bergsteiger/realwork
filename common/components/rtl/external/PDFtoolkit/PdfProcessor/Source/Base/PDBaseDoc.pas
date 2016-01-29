{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

(**
  * Portable Document Base Layer
  *
  *   The PDBase layer provides access to the low-level object types and file
  * structure used in PDF files. PDF documents are trees of PDF objects.
  * Base objects represent document components such as bookmarks, pages, fonts,
  * and annotations, as described in "Document Structure", in the PDF Reference.
  *
  *   Using base layer methods improperly could result in an invalid PDF file.
  * Therefore, you should not use Base Layer methods unless necessary, for
  * example to add private data to portions of a PDF file that cannot be
  * accessed in other ways.
  *
  * File Structure
  *
  *   A PDF file consists of four sections:
  *     A one-line header specifying the PDF version.
  *     A body, which is a sequence of objects representing a PDF document.
  *     A cross-reference table containing information allowing access to
  *       indirect objects in the file.
  *     A trailer containing information on certain special objects in the file.
  *
  *   There is one entry in the cross-reference table for each indirect object
  * in a file; the entry specifies the byte offset of the object from the
  * beginning of the file. When a file is opened, if PDFProcessor determines
  * that the offsets are incorrect (indicating that the file has been damaged in
  * some manner), it attempts to rebuild the cross-reference table depending
  * upon the user requirement.
  *
  * Base Layer APIs (Core APIs)
  *
  *   In PDFProcessor core API, there are two defined objects:
  *     PDBaseDoc, which represents an entire PDF file.
  *     PDBaseObject, which represents all the individual object types. There are
          various methods to create the different types of PDBase objects, as well
          as getting and setting their values.
  *   Each PDBaseObject can be specified as being one of the other supported types:
  *     PDArray
  *     PDBoolean
  *     PDDict
  *     PDReal
  *     PDInteger
  *     PDName
  *     PDNull
  *     PDStream
  *     PDString
  *
  *   The Base layer provides methods to create and modify objects of each of
  *  the supported types, as well as methods to read and write objects to and
  *   from a file. PDBaseDoc includes those to get the root node of the tree of
  *   objects representing a PDF document, and the info dictionary for a PDF document.
  *
  *)

{$I ..\Utils\gtCompilerDefines.inc}

unit PDBaseDoc;

interface

uses
  Classes, gtObject, Decrypt, Stream, EncryptionSettings, PDBaseObject,
  PDWriter, PDCollection, PDReader, PDLexer, gtTypes, Contnrs;

type
  TgtPDSaveOptions = record
    Header: AnsiString;
    Incremental: Boolean;
    Full: Boolean;
    Copy: Boolean;
    Linearize: Boolean;
    UniDirectional: Boolean;
    KeepModDate: Boolean;
    UnCompressed: Boolean;
    Compressed: Boolean;
  end;

  TgtSignature = class
    Author,
    ContactInfo,
    Location,
    Reason: AnsiString;
    Filter,
    PFXFileName,
    PFXPassWord: AnsiString;
    Subfilter: AnsiString;
    CerificationLevel: TgtSigCertLevel;
    DateTime: TDateTime;
  end;


  TgtPDBaseDoc = class(TgtObject)
  private
    FReader: TgtPDReader;
    FWriter: TgtPDWriter;
    FCollection: TgtPDCollection;
    FSaveOptions: TgtPDSaveOptions;
    FCryptStream: TgtStream;
    FPassword: AnsiString;
    FEncryptSettings: TgtEncryptionSettings;
    FUserEncryptionSettings: TgtEncryptionSettings;
    FIsOwner: Boolean;

    FTrailer: TgtPDBaseObject;

    FLinearizedObject: TgtPDBaseObject;

    FCatalog: TgtPDBaseObject;
    FEncrypt: TgtPDBaseObject;
    FDocInfo: TgtPDBaseObject;
//    FHintTable: TgtPDBaseObject;

    FDocInfoNum: Cardinal;
    FCatalogNum: Cardinal;
    FEncryptNum: Cardinal;

    FIsEncrypted: Boolean;
    FSignature: TgtSignature;
    FSignDoc: Boolean;

    function Encrypted: Boolean;
    function GetUserEncryptionSettings: TgtEncryptionSettings;
    function GetIsOwner: Boolean;

    procedure SetUserEncryptionSettings(Value: TgtEncryptionSettings);
    function GetSignature: TgtSignature;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadDocument(FileName: AnsiString; APassword: AnsiString); overload;
    procedure LoadDocument(Stream: TStream; APassword: AnsiString); overload;

    procedure SaveDocument; overload;
    procedure SaveDocument(Stream: TStream); overload;
    procedure SaveDocument(Filename: AnsiString); overload;

    procedure SaveDocument(ASaveOptions: TgtPDSaveOptions); overload;
    procedure SaveDocument(Stream: TStream; ASaveOptions:
      TgtPDSaveOptions); overload;
    procedure SaveDocument(Filename: AnsiString; ASaveOptions:
      TgtPDSaveOptions); overload;

    procedure CloseDocument;

    procedure ForceIntermediateSave;

    procedure EnumerateObjects(EnumObjects: TgtEnumObjectsEvent);

    procedure GetDocID(var InstanceID: AnsiString; var PermanentID: AnsiString);
    procedure SetDocID(InstanceID: AnsiString; PermanentID: AnsiString);
    function GetDocInfo: TgtPDBaseObject;
    function GetDocRoot: TgtPDBaseObject;
    function GetEncrypt: TgtPDBaseObject;
    function GetTrailer: TgtPDBaseObject;
    function GetLinearized: TgtPDBaseObject;
    function GetHintTable: TgtPDBaseObject;
    function GetPassword: AnsiString;

    function GetObject(const ObjectPath: AnsiString): TgtPDBaseObject; overload;
    function GetObject(ObjectNumber: Cardinal): TgtPDBaseObject; overload;
    function IsObjectWritten(ObjectNumber: Cardinal): Boolean;

    procedure AddToCollection(Value: TgtPDBaseObject);

    function IsFullCompressed: Boolean;
    function IsPartialCompressed: Boolean;
    function IsLinearized: Boolean;

    function GetPermissions(AUserPermissions: TgtUserPermissions): TgtUserPermissions;

    procedure SetSaveOptions(const Header: AnsiString; Incremental, Full, Copy,
      Linearize, UniDirectional, UnCompressed, Compressed, KeepModDate: Boolean);

    procedure SetMaxDocStorage(Value: Cardinal);

    function GetMajorVersion: Integer;
    function GetMinorVersion: Integer;

    function GetCollection: TgtPDCollection;
    function GetEncryptSettings: TgtEncryptionSettings;
    function GetIsEncrypted: Boolean;
    function GetReader: TgtPDReader;
    function GetSaveOptions: TgtPDSaveOptions;
    function GetWriter: TgtPDWriter;

    property SaveOptions: TgtPDSaveOptions read GetSaveOptions;
    property Reader: TgtPDReader read GetReader;
    property Writer: TgtPDWriter read GetWriter;
    property Collection: TgtPDCollection read GetCollection;
    property Linearized: TgtPDBaseObject read GetLinearized;
    property IsEncrypted: Boolean read GetIsEncrypted;
    property EncryptionSettings: TgtEncryptionSettings read GetEncryptSettings;
    property UserEncryptionSettings: TgtEncryptionSettings
      read GetUserEncryptionSettings write SetUserEncryptionSettings;
    property IsOwner: Boolean read GetIsOwner;
    property Signature: TgtSignature read GetSignature;
    property SignDoc: Boolean read FSignDoc write FSignDoc;
  end;

implementation

uses
  SysUtils, FileStream, CryptStream, PDDictionary, gtConstants, PDArray,
  PDParser, PDString, PDInteger, PDBaseExceptions, PDIndirectRef, gtMethods;

{ TgtPDBaseDoc }

  (**
   * Adds a base object to collections
   * @param Value is a Base Object
   *)

procedure TgtPDBaseDoc.AddToCollection(Value: TgtPDBaseObject);
begin
  if not Assigned(FCollection) then
    FCollection := TgtPDCollection.Create(Self);
  FCollection.Add(TgtPDBaseObject(Value));
end;

procedure TgtPDBaseDoc.CloseDocument;
begin

end;

constructor TgtPDBaseDoc.Create;
begin
  FIsOwner := False;
  FUserEncryptionSettings := nil;
  FEncryptSettings := nil;
  FSignDoc := False;
end;

destructor TgtPDBaseDoc.Destroy;
begin
  if Assigned(FLinearizedObject) then FreeAndNil(FLinearizedObject);

  try
    if Assigned(FCollection) then FreeAndNil(FCollection);
  except

  end;

  if Assigned(FReader) then FreeAndNil(FReader);
  if Assigned(FWriter) then FreeAndNil(FWriter);


  if Assigned(FTrailer) then FreeAndNil(FTrailer);
  if Assigned(FCatalog) then FreeAndNil(FCatalog);
//  if Assigned(FEncrypt) then FreeAndNil(FEncrypt);

  if Assigned(FCryptStream) then FreeAndNil(FCryptStream);
  if Assigned(FEncryptSettings) then FreeAndNil(FEncryptSettings);
  if Assigned(FUserEncryptionSettings) then FreeAndNil(FUserEncryptionSettings);
  if Assigned(FSignature) then FreeAndNil(FSignature);
  


//  if Assigned(FDocInfo) then FDocInfo.Free;

  inherited;
end;

procedure TgtPDBaseDoc.EnumerateObjects(EnumObjects: TgtEnumObjectsEvent);
begin

end;

procedure TgtPDBaseDoc.ForceIntermediateSave;
begin

end;

function TgtPDBaseDoc.GetCollection: TgtPDCollection;
begin
  Result := FCollection;
end;

procedure TgtPDBaseDoc.GetDocID(var InstanceID: AnsiString; var PermanentID: AnsiString);
var
  LIDObj: TgtPDBaseObject;
begin
  LIDObj := TgtPDDictionary(FTrailer).LookUp(PDF_ID);
  if Assigned(LIDObj) then
  begin
    InstanceID := TgtPDString(TgtPDArray(LIDObj).Get(0)).GetString;
    PermanentID := TgtPDString(TgtPDArray(LIDObj).Get(1)).GetString;
  end;
end;

  (**
   * Gets the Info Dictionary
   * @returm The Base Object if Info dictionary found, else nil
   *)

function TgtPDBaseDoc.GetDocInfo: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FDocInfo) then
  begin
    FDocInfo := TgtPDDictionary(FTrailer).LookUp(PDF_INFO);
    if Assigned(FDocInfo) then
      FDocInfoNum := FDocInfo.ObjNumber
    else
    begin
      Reader.XRef.LastObjectNumber := Reader.XRef.LastObjectNumber + 1;
      FDocInfo := TgtPDDictionary.Create(Reader.XRef.LastObjectNumber, 0, Self);
      TgtPDDictionary(FDocInfo).Add(PDF_PRODUCER,
        TgtPDString.Create('Gnostice PDFProcessor v 4.0', False));
      LObj := TgtPDIndirectRef.Create(FDocInfo.ObjNumber, FDocInfo.GenNumber);
      TgtPDDictionary(FTrailer).Add(PDF_INFO, LObj);
      AddToCollection(FDocInfo);
    end;
  end;
  Result := FDocInfo;
end;

  (**
   * Gets the Root Dictionary
   * @returm The Base Object if Root dictionary found, else nil
   *)

function TgtPDBaseDoc.GetDocRoot: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FCatalog) then
  begin
    FCatalog := TgtPDDictionary(FTrailer).LookUp(PDF_ROOT);

    if Assigned(FCatalog) and FCatalog.IsDict then
    begin
      FCatalogNum := FCatalog.ObjNumber;

      LObj := TgtPDDictionary(FCatalog).LookUp(PDF_PAGES);
      if not Assigned(LObj) then raise ExNoPageTreeObj.Create(ErrNoPageTree);
    end
    else
      raise ExBadRootObj.Create(ErrBadRootObj);
  end;
  Result := FCatalog;
end;

  (**
   * Gets the Encrypt Dictionary
   * @returm The Base Object if Encrypt dictionary found, else nil
   *)

function TgtPDBaseDoc.GetEncrypt: TgtPDBaseObject;
begin
  if not Assigned(FEncrypt) then
  begin
    FEncrypt := TgtPDDictionary(FTrailer).LookUp(PDF_ENCRYPT);
    if Assigned(FEncrypt) and (not FEncrypt.IsNull) then
      FEncryptNum := FEncrypt.ObjNumber
    else
      FEncrypt := nil;
  end;

  Result := FEncrypt;
end;

function TgtPDBaseDoc.GetEncryptSettings: TgtEncryptionSettings;
begin
  Result := FEncryptSettings;
end;

function TgtPDBaseDoc.GetHintTable: TgtPDBaseObject;
begin
  Result := nil;
end;

function TgtPDBaseDoc.GetIsEncrypted: Boolean;
begin
  Result := FIsEncrypted;
end;

function TgtPDBaseDoc.GetIsOwner: Boolean;
begin
  Result := FIsOwner;
end;

function TgtPDBaseDoc.GetLinearized: TgtPDBaseObject;
var
  LParser: TgtPDParser;
  LObj: TgtPDBaseObject;
  LStream: TgtFileStream;
  LI: Integer;
begin

  if not Assigned(FLinearizedObject) then
  begin
    LStream := TgtFileStream.Create(TFileStream(FReader.FileStream), 0, 0, False);
    LParser := TgtPDParser.Create(FReader.XRef, TgtPDLexer.Create(LStream), True);

    while True do
    begin
      LObj := LParser.GetObject;
      if LObj.IsInteger then
      begin
        LObj := LParser.GetObject;
        if LObj.IsInteger then
        begin
          LObj := LParser.GetObject;
          if LObj.IsCommand('obj') then
          begin
            LObj := LParser.GetObject;
            if LObj.IsDict then
            begin
              for LI := 0 to TgtPDDictionary(LObj).GetLength - 1 do
              begin
                if TgtPDDictionary(Lobj).GetKey(LI) = PDF_LINEARIZED then
                begin
                  FLinearizedObject := LObj;
                  Break;
                end;
              end;
              Break;
            end
          end
        end
      end
    end;
  end;
  Result := FLinearizedObject;
end;

function TgtPDBaseDoc.GetMajorVersion: Integer;
begin
  Result := 0;
end;

function TgtPDBaseDoc.GetMinorVersion: Integer;
begin
  Result := 0;
end;

function TgtPDBaseDoc.GetObject(const ObjectPath: AnsiString): TgtPDBaseObject;
begin
  Result := nil;
end;

  (**
   * Gets an Object where the Object Number ObjectNumber
   *
   * @param ObjectNumber is the Object number for the object that need to be
   *        retrieved
   *
   * @return TgtPDBaseObject is the object which has the object number
   *         ObjectNumber, nil if not found in the list
   *)

function TgtPDBaseDoc.GetObject(ObjectNumber: Cardinal): TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
  Found: Boolean;
  Saved: Boolean;
begin
  Found := False;
  Saved := False;
  LObj := nil;

  if not Found then
  begin
    if Assigned(FCatalog) and (FCatalogNum = ObjectNumber) then
    begin
      LObj := FCatalog;
      Found := True;
      Saved := True;
    end;
  end;

  if not Found then
  begin
    if Assigned(FEncrypt) and (FEncryptNum = ObjectNumber) then
    begin
      LObj := FEncrypt;
      Found := True;
      Saved := True;
    end;
  end;

  if not Found then
  begin
    if Assigned(FDocInfo) and (FDocInfoNum = ObjectNumber) then
    begin
      LObj := FDocInfo;
      Found := True;
      Saved := True;
    end;
  end;

  if not Found then
  begin
    if Assigned(FCollection) then
    begin
      LObj := FCollection.GetObject(ObjectNumber);
      if Assigned(LObj) and not LObj.IsError then
      begin
        Found := True;
        Saved := True;
      end;
      if Assigned(LObj) and LObj.IsError then
        FreeAndNil(LObj);
    end;
  end;

  if not Found then
  begin
    if Assigned(FReader) then
    begin
      LObj := FReader.Fetch(ObjectNumber);
      if Assigned(LObj) and not LObj.IsError then
        Found := True;
      if Assigned(LObj) and LObj.IsError then
        FreeAndNil(LObj);
    end;
  end;

  if Found and not Saved then
  begin
    if LObj.IsDict(PDF_CATALOG) then
    begin
      FCatalog := LObj;
    end
//    else if LObj.IsDict(PDF_INFO) then
//    begin
//      FDocInfo := LObj;
//    end
    else if LObj.IsDict(PDF_ENCRYPT) then
    begin
      FEncrypt := LObj;
    end
    else
    begin
      if not Assigned(FCollection) then
        FCollection := TgtPDCollection.Create(Self);
      FCollection.Add(LObj);
    end;
  end;
  Result := LObj;
end;

(**
   * Gets the Userpermissions
   * @returm Userpermission of the document
   *)

function TgtPDBaseDoc.GetPassword: AnsiString;
begin
  Result := FPassword;
end;

function TgtPDBaseDoc.GetPermissions(
  AUserPermissions: TgtUserPermissions): TgtUserPermissions;
var
  LPermVal: Integer;
begin
  Result := [];
  LPermVal := EncryptionSettings.Permission;
  if ((LPermVal and 4) <> 0) or (AllowPrint in AUserPermissions) then
    EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowPrint];
  if ((LPermVal and 8) <> 0) or (AllowModify in AUserPermissions) then
    EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowModify];
  if ((LPermVal and 16) <> 0) or (AllowCopy in AUserPermissions) then
    EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowCopy];
  if ((LPermVal and 32) <> 0) or (AllowAnnotation in AUserPermissions) then
    EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowAnnotation];
  if (EncryptionSettings.Level = el128Bit) then
  begin
    if ((LPermVal and 256) <> 0) or (AllowFormFill in AUserPermissions) then
      EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowFormFill];
    if ((LPermVal and 512) <> 0) or (AllowAccessibility in AUserPermissions) then
      EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowAccessibility];
    if ((LPermVal and 1024) <> 0) or (AllowDocAssembly in AUserPermissions) then
      EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowDocAssembly];
    if ((LPermVal and 2048) <> 0) or (AllowHighResPrint in AUserPermissions) then
      EncryptionSettings.UserPermissions := EncryptionSettings.UserPermissions + [AllowHighResPrint];
  end;
  Result := EncryptionSettings.UserPermissions;
end;

function TgtPDBaseDoc.GetReader: TgtPDReader;
begin
  Result := FReader;
end;

function TgtPDBaseDoc.GetSaveOptions: TgtPDSaveOptions;
begin
  Result := FSaveOptions;
end;
function TgtPDBaseDoc.GetSignature: TgtSignature;
begin
  if not Assigned(FSignature) then
    FSignature := TgtSignature.Create;
  Result := FSignature;
end;

(**
   * Gets the Trailer Dictionary
   * @returm The Base Object if trailer dictionary found, else nil
   *)

function TgtPDBaseDoc.GetTrailer: TgtPDBaseObject;
begin
  if FSaveOptions.Full then
    TgtPDDictionary(FTrailer).Remove(PDF_PREV);

  Result := FTrailer;
end;

function TgtPDBaseDoc.GetUserEncryptionSettings: TgtEncryptionSettings;
begin
  Result := FUserEncryptionSettings;
end;

function TgtPDBaseDoc.GetWriter: TgtPDWriter;
begin
  Result := FWriter;
end;

function TgtPDBaseDoc.Encrypted: Boolean;
var
  LLength: Integer;
  LInstanceID, LPermanentID: AnsiString;
  LOwner, LUser: AnsiString;
  LLenObj: TgtPDBaseObject;
begin
  Result := False;
  if Assigned(FEncrypt) then
  begin
    FEncryptSettings := TgtEncryptionSettings.Create;

    //Gets the Doc ID from the Trailer Dictionary
    GetDocID(LInstanceID, LPermanentID);

    LOwner := TgtPDString(TgtPDDictionary(FEncrypt).LookUp(PDF_OWNER)).GetString;
    if TgtPDString(TgtPDDictionary(FEncrypt).LookUp(PDF_OWNER)).IsHexString then
      LOwner := '<' + LOwner + '>'
    else
      LOwner := '(' + LOwner + ')';

    LUser := TgtPDString(TgtPDDictionary(FEncrypt).LookUp(PDF_USER)).GetString;
    if TgtPDString(TgtPDDictionary(FEncrypt).LookUp(PDF_USER)).IsHexString then
      LUser := '<' + LUser + '>'
    else
      LUser := '(' + LUser + ')';

    //Setting the values needed for the Deryption of Document
    FEncryptSettings.FileID := LInstanceID;
    FEncryptSettings.OwnerPassword := LOwner;
    FEncryptSettings.UserPassword := LUser;
    FEncryptSettings.Permission := TgtPDInteger(TgtPDDictionary(FEncrypt).LookUp(PDF_PER)).Value;
    LLenObj := TgtPDDictionary(FEncrypt).LookUp(PDF_LENGTH);
    if Assigned(LLenObj) then
      LLength := TgtPDInteger(LLenObj).Value
    else
      LLength := 40;
    case LLength of
      40: FEncryptSettings.Level := el40Bit;
      128: FEncryptSettings.Level := el128Bit;
    end;

    Result := True;
  end;
end;

function TgtPDBaseDoc.IsFullCompressed: Boolean;
begin
  Result := False;
end;

function TgtPDBaseDoc.IsLinearized: Boolean;
begin
  Result := False;
end;

function TgtPDBaseDoc.IsObjectWritten(ObjectNumber: Cardinal): Boolean;
var
  LObj: TgtPDBaseObject;
begin
  Result := False;
  if Assigned(FCatalog) and (FCatalogNum = ObjectNumber) then
  begin
    if FCatalog.IsWritten then
      Result := True;
  end
  else if Assigned(FDocInfo) and (FDocInfoNum = ObjectNumber) then
  begin
    if FDocInfo.IsWritten then
      Result := True;
  end
  else if Assigned(FEncrypt) and (FEncryptNum = ObjectNumber) then
  begin
    if FEncrypt.IsWritten then
      Result := True;
  end
  else if Assigned(Collection) then
  begin
    LObj := Collection.GetObject(ObjectNumber);
    if Assigned(LObj) and LObj.IsWritten then
      Result := True;
  end;
end;

function TgtPDBaseDoc.IsPartialCompressed: Boolean;
begin
  Result := False;
end;

 (**
  * Loads the PDF file from stream
  *
  * @param Stream the Stream variable containg the file to be loaded
  * @param APassword is the password needed to Authorize the Loading
  *
  * @exception ExInvalidPassword is raised if password is incorrect
  *)

procedure TgtPDBaseDoc.LoadDocument(Stream: TStream; APassword: AnsiString);
begin
  if Assigned(FReader) then FReader.Free;
  FReader := TgtPDReader.Create(Self);
  FReader.LoadFromStream(Stream);

  FTrailer := Reader.GetTrailer;
  if not Assigned(FEncrypt) then GetEncrypt;
  FIsEncrypted := Encrypted;

  if IsEncrypted then
  begin
    FCryptStream := TgtCryptStream.Create(nil, '', FEncryptSettings, cryptRC4, 0, 0, 0);
    FUserEncryptionSettings := TgtEncryptionSettings.Create;
    if not TgtCryptStream(FCryptStream).CheckPassword(FUserEncryptionSettings, APassword) then
    begin
      FreeObject(FUserEncryptionSettings);
      raise ExInvalidPassword.Create(ErrInvalidPassword);
    end;
    FIsOwner := FUserEncryptionSettings.IsOwner;
//    FUserEncryptionSettings.FileID := FEncryptSettings.FileID;
//    FUserEncryptionSettings.Permission := FEncryptSettings.Permission;
//    FUserEncryptionSettings.Level := FEncryptSettings.Level;
//    FUserEncryptionSettings.OwnerPassword := FEncryptSettings.OwnerPassword;
//    FUserEncryptionSettings.UserPassword := FEncryptSettings.UserPassword;
//    FUserEncryptionSettings.UserPermissions := FEncryptSettings.UserPermissions;
    FPassword := APassword;
  end;
end;

 (**
  * Loads the PDF file from disk
  * @param FileName the file name and path of the file to be loaded
  *)

procedure TgtPDBaseDoc.LoadDocument(FileName: AnsiString; APassword: AnsiString);
var
  LStream: TStream;
begin
  if not FileExists(Filename) then
  begin
    raise ExFileNotFound.Create(ErrFileNotFound);
  end;

  try
    LStream := TFileStream.Create(Filename, $0000 + $0010);
  except
    on E: EFOpenError do
      raise ExFileOpenError.Create(ErrFileOpenError);
  end;
  LoadDocument(LStream, APassword);
end;

procedure TgtPDBaseDoc.SaveDocument;
begin

end;

procedure TgtPDBaseDoc.SaveDocument(Stream: TStream);
begin
  if Assigned(FWriter) then
    FWriter.Free;
  FWriter := TgtPDWriter.Create(Self);

  FWriter.SaveDocument(Stream);
  FreeObject(FWriter);
  FDocInfo := nil;
  if Assigned(FCatalog) then FreeAndNil(FCatalog);
  FreeObject(FCollection);
end;

procedure TgtPDBaseDoc.SaveDocument(Stream: TStream;
  ASaveOptions: TgtPDSaveOptions);
begin

end;

procedure TgtPDBaseDoc.SaveDocument(Filename: AnsiString;
  ASaveOptions: TgtPDSaveOptions);
begin

end;

(**
  * Saves the PDF document to the location specified by the Filename
  *
  * @param FileName Name and path of the file to which the document has to
  *        be saved
  *)

procedure TgtPDBaseDoc.SaveDocument(Filename: AnsiString);
var
  LStream: TStream;
begin
  if Filename = '' then
  begin
    raise ExInvalidFileName.Create(ErrInvalidFileName);
  end;

  try
    LStream := TFileStream.Create(Filename, fmCreate);
  except
    on E: EFCreateError do
      raise ExFileCreateError.Create(ErrFileCreateError + E.Message);
  end;

  SaveDocument(LStream);
end;

procedure TgtPDBaseDoc.SaveDocument(ASaveOptions: TgtPDSaveOptions);
begin

end;

procedure TgtPDBaseDoc.SetDocID(InstanceID, PermanentID: AnsiString);
var
  LObj, LObj2: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FTrailer).LookUp(PDF_ID);
  if Assigned(LObj) then
  begin
    if LObj.IsArray then
    begin
      LObj2 := TgtPDArray(LObj).Get(0);
      TgtPDString(LObj2).Value := InstanceID;
      LObj2 := TgtPDArray(LObj).Get(1);
      TgtPDString(LObj2).Value := PermanentID;
    end;
  end
  else
  begin
    LObj := TgtPDArray.Create(Self);
    TgtPDArray(LObj).Add(TgtPDString.Create(InstanceID, True));
    TgtPDArray(LObj).Add(TgtPDString.Create(PermanentID, True));
    TgtPDDictionary(FTrailer).Add(PDF_ID, LObj);
  end;
end;

(*

procedure TgtPDBaseDoc.SetIsOwner(Value: Boolean);
begin
  FIsOwner := Value;
end;
*)

procedure TgtPDBaseDoc.SetMaxDocStorage(Value: Cardinal);
begin

end;

procedure TgtPDBaseDoc.SetSaveOptions(const Header: AnsiString; Incremental, Full,
  Copy, Linearize, UniDirectional, UnCompressed, Compressed, KeepModDate: Boolean);
begin
  FSaveOptions.Header := Header;
  FSaveOptions.Incremental := Incremental;
  FSaveOptions.Full := Full;
  FSaveOptions.Copy := Copy;
  FSaveOptions.Linearize := Linearize;
  FSaveOptions.UniDirectional := UniDirectional;
  FSaveOptions.KeepModDate := KeepModDate;
  FSaveOptions.UnCompressed := UnCompressed;
  FSaveOptions.Compressed := Compressed;
end;

procedure TgtPDBaseDoc.SetUserEncryptionSettings(Value: TgtEncryptionSettings);
begin
  if Assigned(Value) then
  begin
    if Assigned(FUserEncryptionSettings) then
      FreeObject(FUserEncryptionSettings);
    FUserEncryptionSettings := Value;
  end;
end;

end.
