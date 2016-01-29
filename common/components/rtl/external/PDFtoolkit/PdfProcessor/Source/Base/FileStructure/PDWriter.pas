{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I gtCompilerDefines.inc}

unit PDWriter;

interface

uses
  Classes, gtObject, PDXRef, PDBaseObject, BaseStream, gtTypes, Windows;

type
  (**
   * Implements the logic needed for writing Portable Documents. Every PDBaseDoc
   * will contain a Writer object. The Writer writes the file according to the
   * options specified by the SaveOptions member of the ParentDoc(BaseDoc).
   *
   * The Writer also has the logic to save the document using ObjectStreams,
   * Encrypting the document etc.
   *)
  TgtPDWriter = class(TgtObject)
  private
    //Stream to which the file is wrriten to (Internal Implementation)
    FStream: TgtBaseStream;
    //Stream to which the file is wrriten to
    FFile: TStream;
    //The cross reference table of the newly created PDF File.
    FXRef: TgtPDXRef;
    //The Parent document
    FParentDoc: TgtObject;

//    FTrialMarkOffset: Cardinal;
//    FTrialMarkObjNumber: Cardinal;

    procedure InitIncremental;
    procedure InitFull;
    function GetEncryptionDict: TgtPDBaseObject;
    function GetSigDictOffset: Cardinal;
    procedure WriteSignature;
    procedure WriteSignatureContents(AOffset1, AOffset2, AOffset3, AOffset4:
      Cardinal);
  public
    constructor Create(ParentDoc: TgtObject);
    destructor Destroy; override;

    function GetFileStream: TStream;
    function GetXRef: TgtPDXRef;

    procedure SaveDocument(const Filename: AnsiString); overload;
    procedure SaveDocument(Stream: TStream); overload;

    //The cross reference table of the newly created PDF File.
    property XRef: TgtPDXRef read GetXRef;
    //Stream to which the file is wrriten to
    property FileStream: TStream read GetFileStream;
  end;

implementation

uses
  SysUtils, PDBaseDoc, gtConstants, gtMethods, PDDictionary, PDInteger, PDIndirectRef,
  FileStream, MemoryStream, PDBaseExceptions, PDStream, PDName, Encrypt,
  PDString, EncryptionSettings, CryptStream, PDArray, PDEnvelope,
  gtJwaWinCrypt{$IFDEF VCL6ORABOVE},DateUtils{$ENDIF};

{ TgtPDWriter }

 (**
  * Constructor
  *
  * @param ParentDoc The parent document object
  *)

constructor TgtPDWriter.Create(ParentDoc: TgtObject);
begin
  FParentDoc := ParentDoc;
end;

 (**
  * Destructor
  *
  *)

destructor TgtPDWriter.Destroy;
begin
  if Assigned(FXRef) then FreeAndNil(FXRef);
  if Assigned(FStream) then FreeAndNil(FStream);
  FFile := nil;
  inherited;
end;

function TgtPDWriter.GetEncryptionDict: TgtPDBaseObject;
var
  LEncryptDict: TgtPDDictionary;
  LObj, LObj2: TgtPDBaseObject;
  LEncryptObj: TgtEncrypt;
  LCreationDate, LFileID, LStr: AnsiString;
begin
  LEncryptDict := nil;
  if TgtPDBaseDoc(FParentDoc).IsEncrypted or
    (Assigned(TgtPDBaseDoc(FParentDoc).UserEncryptionSettings) and
    TgtPDBaseDoc(FParentDoc).UserEncryptionSettings.Enabled) then
  begin
    LEncryptDict := TgtPDDictionary(
      TgtPDBaseDoc(FParentDoc).GetTrailer).LookUp(PDF_ENCRYPT) as TgtPDDictionary;
    //Retrive Creation Date from Doc Info
    LObj := TgtPDBaseDoc(FParentDoc).GetDocInfo;
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_CREATIONDATE);
      if Assigned(LObj2) then
        LCreationDate := TgtPDString(LObj2).Value;
    end;

    //Create Encryption Object to create the Dict
    LEncryptObj := TgtEncrypt.Create(nil, LCreationDate,
      TgtPDBaseDoc(FParentDoc).UserEncryptionSettings, cryptRC4, 0, 0, 0);

    LFileID := LEncryptObj.FileID;
    LFileID := GetHexOfStr(LFileID, Length(LFileID));
    TgtPDBAseDoc(FParentDoc).SetDocID(LFileID, LFileID);

    if not Assigned(LEncryptDict) then
    begin
    //Update Object number to use for new object
      TgtPDBaseDoc(FParentDoc).Reader.XRef.LastObjectNumber :=
        TgtPDBaseDoc(FParentDoc).Reader.XRef.LastObjectNumber + 1;
      LEncryptDict := TgtPDDictionary.Create(TgtPDBaseDoc(FParentDoc).Reader.XRef.LastObjectNumber, 0,
        TgtPDBaseDoc(FParentDoc));
      //Add the created Encryption Dict to Collection
      TgtPDBaseDoc(FParentDoc).AddToCollection(LEncryptDict);

      //Update Encryption Dict with values from Encrypt Object
      LEncryptDict.Add(PDF_FILTER, TgtPDName.Create(PDF_STANDARD));
      LStr := GetHexOfStr(LEncryptObj.UserKey, Length(LEncryptObj.UserKey));
      LEncryptDict.Add(PDF_U, TgtPDString.Create(LStr, True));
      LStr := GetHexOfStr(LEncryptObj.OwnerKey, Length(LEncryptObj.OwnerKey));
      LEncryptDict.Add(PDF_O, TgtPDString.Create(LStr, True));
      LEncryptDict.Add(PDF_P, TgtPDInteger.Create(LEncryptObj.PermissionValue));

      case TgtPDBAseDoc(FParentDoc).UserEncryptionSettings.Level of
        el40Bit:
          begin
            LEncryptDict.Add(PDF_V, TgtPDInteger.Create(1));
            LEncryptDict.Add(PDF_R, TgtPDInteger.Create(2));
          end;
        el128Bit:
          begin
            LEncryptDict.Add(PDF_V, TgtPDInteger.Create(2));
            LEncryptDict.Add(PDF_R, TgtPDInteger.Create(3));
          end;
      end;
      LEncryptDict.Add(PDF_LENGTH, TgtPDInteger.Create(
        EncryptLength[TgtPDBAseDoc(FParentDoc).UserEncryptionSettings.Level] * 8));
    end
    else
    begin
      LObj := LEncryptDict.LookUp(PDF_U);
      if Assigned(LObj) then
      begin
        LStr := GetHexOfStr(LEncryptObj.UserKey, Length(LEncryptObj.UserKey));
        LEncryptDict.SetKeyValue(PDF_U, TgtPDString.Create(LStr, True));
      end;

      LObj := LEncryptDict.LookUp(PDF_O);
      if Assigned(LObj) then
      begin
        LStr := GetHexOfStr(LEncryptObj.OwnerKey, Length(LEncryptObj.OwnerKey));
        LEncryptDict.SetKeyValue(PDF_O, TgtPDString.Create(LStr, True));
      end;

      LObj := LEncryptDict.LookUp(PDF_P);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value := LEncryptObj.PermissionValue;

      case TgtPDBAseDoc(FParentDoc).UserEncryptionSettings.Level of
        el40Bit:
          begin
            LObj := LEncryptDict.LookUp(PDF_V);
            TgtPDInteger(LObj).Value := 1;
            LObj := LEncryptDict.LookUp(PDF_R);
            TgtPDInteger(LObj).Value := 2;
          end;
        el128Bit:
          begin
            LObj := LEncryptDict.LookUp(PDF_V);
            TgtPDInteger(LObj).Value := 2;
            LObj := LEncryptDict.LookUp(PDF_R);
            TgtPDInteger(LObj).Value := 3;
          end;
      end;
      LObj := LEncryptDict.LookUp(PDF_LENGTH);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value :=
          EncryptLength[TgtPDBAseDoc(FParentDoc).UserEncryptionSettings.Level] * 8;
    end;
    if Assigned(LEncryptObj) then
      FreeObject(LEncryptObj);
  end;

  Result := LEncryptDict;
end;

function TgtPDWriter.GetFileStream: TStream;
begin
  Result := FFile;
end;

function TgtPDWriter.GetSigDictOffset: Cardinal;
var
  LObj, LObj1, LFields: TgtPDBaseObject;
  I: Integer;
  LObjNo: Cardinal;
  LDoc: TgtPDBaseDoc;
  LStr: Ansistring;
begin
  LObjNo := 0;
  Result := 0;
  LDoc := TgtPDBaseDoc.Create;
  LDoc.LoadDocument(TgtFileStream(FStream).GetTStream,
    TgtPDBaseDoc(FParentDoc).GetPassword);
  LObj := TgtPDDictionary(LDoc.GetDocRoot).Lookup(PDF_ACROFORM);
  if Assigned(LObj) and LObj.IsDict then
  begin
    LFields := TgtPDDictionary(LObj).LookUp(PDF_FIELDS);
    if Assigned(LFields) and LFields.IsArray then
    begin
      for I := 0 to TgtPDArray(LFields).GetLength - 1 do
      begin
        LObj := TgtPDArray(LFields).Get(I); // FormField entry
        if Assigned(LObj) and LObj.IsDict then
        begin
          LObj1 := TgtPDDictionary(LObj).LookUp(PDF_FT);  // sig dictionary
          if Assigned(LObj1) and (LObj1.ISName) and
            (TgtPDName(LObj1).Value = PDF_SIG) then  // Its sig FrmField
          begin
            LObj1 := TgtPDDictionary(LObj).LookUp(PDF_V);
            if Assigned(LObj1) and LObj1.IsDict then
            begin
              LObj := TgtPDDictionary(LObj1).LookUp(PDF_GNOSTICETAG);
              if Assigned(LObj) then
                LObjNo := TgtPDDictionary(LObj1).ObjNumber; // ObjectNo of Sig Dict
            end;
          end;
        end;
      end;
    end;
  end;
  if LObjNo <> 0 then
  begin
    // Calculation of offset till deic start
    LStr := IntToStr(LObjNo) + ' ' + IntToStr(TgtPDDictionary(LObj1).GenNumber) + '<<';
    Result := XRef.Entries[LObjNo].GetOffset + Length(LStr) + 6 {length for" obj " entry};
  end;
  LDoc.Free;
end;

function TgtPDWriter.GetXRef: TgtPDXRef;
begin
  Result := FXRef;
end;

procedure TgtPDWriter.InitFull;
begin
  FFile.Write(TgtPDBaseDoc(FParentDoc).SaveOptions.Header[1],
    Length(TgtPDBaseDoc(FParentDoc).SaveOptions.Header));
  FXRef.StartObjectNumber := 0;
end;

procedure TgtPDWriter.InitIncremental;
var
  LS: AnsiString;
begin
  // The Existing bytes in the orginal file is blindly copied to the
  // destination file
  FFile.CopyFrom(TgtPDBaseDoc(FParentDoc).Reader.FileStream, 0);
  LS := CRLF;
  FFile.Write(LS[1], Length(LS));

  FXRef.StartObjectNumber := TgtPDBaseDoc(FParentDoc).Reader.
    XRef.LastObjectNumber + 1;
  FXRef.LastObjectNumber := TgtPDBaseDoc(FParentDoc).Reader.
    XRef.LastObjectNumber;
end;



(**
  * Saves the PDF document to the location specified by the Filename
  *
  * @param FileName Name and path of the file to which the document has to
  *        be saved
  * @exception EInvalidFileName If the Filename is invalid
  * @exception ExFileCreateError raised if any error while creating the file
  *)

procedure TgtPDWriter.SaveDocument(const Filename: AnsiString);
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

 (**
  * Saves the PDF document to the Stream
  *
  * @param Stream to which the file will be written
  *
  * @exception ExInvalidStream is raised if Stream is nil
  *)

procedure TgtPDWriter.SaveDocument(Stream: TStream);
var
  LObj: TgtPDBaseObject;
  LTrailer: TgtPDBaseObject;
begin
  if (Stream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  // Creating Internal Stream
  FFile := Stream;
  FStream := TgtFileStream.Create(TFileStream(FFile), 0, 0, False);
  // Creating Cross Reference table and initilizing it with default data.
  // The default size of the cross reference table is that of the Readers XRef Size
  FXRef := TgtPDXRef.Create(FParentDoc, FStream);
  FXRef.AddDefaultEntries(TgtPDBaseDoc(FParentDoc).Reader.XRef.GetSize);

  // Preparing for an incremental update.
  if TgtPDBaseDoc(FParentDoc).SaveOptions.Incremental then
    InitIncremental
  // Preparing for an Full rewrite.
  else if TgtPDBaseDoc(FParentDoc).SaveOptions.Full then
    InitFull;

  // Writing the Catalog and other objects linked to the Catalog. i.e All
  // objects in the catalog tree
  TgtPDBaseDoc(FParentDoc).GetDocRoot.SaveToStream(FStream,
    TgtPDBaseDoc(FParentDoc).SaveOptions.Incremental, FXRef);

  // Writing the Info dictionary
  LObj := TgtPDBaseDoc(FParentDoc).GetDocInfo;
  if Assigned(LObj) then
    LObj.SaveToStream(FStream, TgtPDBaseDoc(FParentDoc).SaveOptions.Incremental,
      FXRef);

  // Writing the Encrypt dictionary Tree
  LObj := GetEncryptionDict;
  if Assigned(LObj) then
  begin
    TgtPDDictionary(TgtPDBaseDoc(FParentDoc).GetTrailer).SetKeyValue(PDF_ENCRYPT,
      TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber));

    LObj.SaveToStream(FStream, TgtPDBaseDoc(FParentDoc).SaveOptions.Incremental,
      FXRef);
    TgtPDBaseDoc(FParentDoc).GetEncrypt.IsWritten := True;
  end
  else
  begin
    LObj := TgtPDBaseDoc(FParentDoc).GetEncrypt;
    if Assigned(LObj) then
      LObj.SaveToStream(FStream, TgtPDBaseDoc(FParentDoc).SaveOptions.Incremental,
        FXRef);
  end;

  // Writing the XRef Stream
  FXRef.SaveToStream(FStream);

  //Writing Trailer
  FStream.Write(PDF_TRAILER + CRLF);

  LTrailer := TgtPDDictionary.Create($FFFFFFFF, $FFFFFFFF, FParentDoc);
  try
    TgtPDDictionary(LTrailer).Add(PDF_SIZE, TgtPDInteger.Create(FXRef.LastObjectNumber + 1, $FFFFFFFF,
      $FFFFFFFF));

    if TgtPDBaseDoc(FParentDoc).SaveOptions.Incremental then
    begin
      TgtPDDictionary(LTrailer).Add(PDF_PREV, TgtPDInteger.Create(TgtPDBaseDoc(FParentDoc).Reader.
        XRef.GetStartXref, $FFFFFFFF, $FFFFFFFF));
    end;

    LObj := TgtPDDictionary(TgtPDBaseDoc(FParentDoc).GetTrailer).
      LookupRefObj(PDF_ROOT);
    if Assigned(LObj) and not LObj.IsNull then
      TgtPDDictionary(LTrailer).Add(PDF_ROOT, TgtPDIndirectRef.Create(
        LObj.ObjNumber, LObj.GenNumber));

    LObj := TgtPDDictionary(TgtPDBaseDoc(FParentDoc).GetTrailer).
      LookupRefObj(PDF_INFO);
    if Assigned(LObj) and not LObj.IsNull then
      TgtPDDictionary(LTrailer).Add(PDF_INFO, TgtPDIndirectRef.Create(
        LObj.ObjNumber, LObj.GenNumber));

    LObj := TgtPDDictionary(TgtPDBaseDoc(FParentDoc).GetTrailer).
      LookupRefObj(PDF_ENCRYPT);
    if Assigned(LObj) and not LObj.IsNull then
      TgtPDDictionary(LTrailer).Add(PDF_ENCRYPT, TgtPDIndirectRef.Create(
        LObj.ObjNumber, LObj.GenNumber));

    LObj := TgtPDDictionary(TgtPDBaseDoc(FParentDoc).GetTrailer).LookUp(PDF_ID);
    if Assigned(LObj) then
      TgtPDDictionary(LTrailer).Add(PDF_ID, LObj.Clone);

    LTrailer.SaveToStream(FStream, TgtPDBaseDoc(FParentDoc).SaveOptions.
      Incremental, FXRef);
  finally
    LTrailer.Free;
  end;

  //Finalizing Write
  FStream.Write(CRLF + PDF_STARTXREF + CRLF);
  FStream.Write(IntegerToString(FXRef.GetStartXref) + CRLF);
  FStream.Write(PDF_EOF);
  if TgtPDBaseDoc(FParentDoc).SignDoc then
    WriteSignature;
end;

procedure TgtPDWriter.WriteSignature;
var
  LSigOffset: Cardinal;
  LStr: AnsiString;
  LSigRec: TgtSignature;
  LOffset1, LOffset2, LOffset3, LOffset4: Cardinal;
  LDate: TgtDate;
  LDateStr: AnsiString;
begin
  LSigRec := TgtPDBaseDoc(FParentDoc).Signature;
  LStr := LStr + '/Type ' + '/Sig' + ' /Filter /' + LSigRec.Filter +
     ' /SubFilter /' + LSigRec.Subfilter;
  if LSigRec.Author <> '' then
    LStr := LStr + ' /Name (' + LSigRec.Author + ')';
  if LSigRec.Reason <> '' then
    LStr := LStr + ' /Reason (' + LSigRec.Reason + ')';
  if LSigRec.Location <> '' then
    LStr := LStr + ' /Location (' + LSigRec.Location + ')';
  if LSigRec.ContactInfo <> '' then
    LStr := LStr + ' /ContactInfo (' + LSigRec.ContactInfo + ')';
  //set Date
  if LSigRec.DateTime <> 0 then
  begin
    {$IFDEF VCL6ORABOVE}
    DecodeDateTime(LSigRec.DateTime, LDate.Year, LDate.Month, LDate.Day, LDate.Hour,
      LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
    {$ENDIF}
    {$IFDEF DELPHI5}
      DecodeDate(LSigRec.DateTime, LDate.Year, LDate.Month, LDate.Day);
      DecodeTime(LSigRec.DateTime, LDate.Hour, LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
    {$ENDIF}
    LDateStr := DateToPDFString(LDate);
    LStr := LStr + '/M (' + LDateStr + ')';
  end;
  LStr := LStr + ' /Contents<' ;

  LSigOffset := GetSigDictOffset;
  LOffset1 := 0;
  FStream.SetPosition(LSigOffset, soBeginning);
  FStream.Write(LStr);
  FStream.SetPosition(LSigOffset + Length(LStr), soBeginning);
  // Ignore '<'
  LOffset2 := LOffset1 + LSigOffset + Length(LStr) - Length('<');
  FStream.SetPosition(PDF_ENVELOPELENGTH, soCurrent);
  LOffset3 := LOffset2 + PDF_ENVELOPELENGTH + 1; {fixed as size of contents entry}
  LOffset4 := FStream.GetSize - LOffset3;
  LStr := '/ByteRange '  + '[' + IntToStr(LOffset1) + ' ' + IntToStr(LOffset2) + ' ' +
   IntToStr(LOffset3) + ' ' + IntToStr(LOffset4) + ']';
  FStream.Write(LStr);
  WriteSignatureContents(LOffset1, LOffset2, LOffset3, LOffset4);
end;

procedure TgtPDWriter.WriteSignatureContents(AOffset1, AOffset2, AOffset3,
  AOffset4: Cardinal);
var
  LBytes: Bytes;
  LTFileStream: TStream;
  LEnvelope: TgtPKCS7;
  LOffset1, LOffset2, LOffset3, LOffset4: Integer;
  LCertContext: PCertContext;
  LSignedData: AnsiString;
  LHashMessage: AnsiString;
  LHexdata: AnsiString;
  pHash: PByte;
  I: Integer;
  LDataLength: Integer;
begin
  LOffset1 := AOffset1;
  LOffset2 := AOffset2;
  LOffset3 := AOffset3;
  LOffset4 := AOffset4;
  LTFileStream := TgtFileStream(FStream).GetTStream;
  {$IFDEF VCL6ORABOVE}
  LTFileStream.Seek(AOffset1, soBeginning);
  {$ELSE}
  LTFileStream.Seek(AOffset1, soFromBeginning);
  {$ENDIF}
  try
    SetLength(LBytes, (LOffset2 - LOffset1 + LOffset4));
  except
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  LTFileStream.Read(LBytes[0], LOffset2 - LOffset1);
  {$IFDEF VCL6ORABOVE}
  LTFileStream.Seek(LOffset3, soBeginning);
  {$ELSE}
  LTFileStream.Seek(LOffset3, soFromBeginning);
  {$ENDIF}
  LTFileStream.Read(LBytes[Integer(LOffset2) - LOffset1], LOffset4);
  LEnvelope := TgtPKCS7.Create;
  try
    LCertContext := LEnvelope.GetPFXCertWithPvtKey(TgtPDBaseDoc(FParentDoc).
    Signature.PFXFileName, TgtPDBaseDoc(FParentDoc).Signature.PFXPassWord);
    LHashMessage := LEnvelope.ComputeHash(@LBytes[0], Length(LBytes));
    Finalize(LBytes);
    GetMem(pHash, Length(LHashMessage));
    system.Move(Pointer(LHashMessage)^, pHash^, Length(LHashMessage));
    LSignedData := LEnvelope.SignMessage(LCertContext, pHash,
      Length(LHashMessage), False);
    FreeMem(pHash);
    LHexdata := GetHexOfStr(LSignedData, Length(LSignedData));
  finally
    LEnvelope.Free;
  end;
  LDataLength := Length(LHexData);
  try
    SetLength(LHexData, PDF_ENVELOPELENGTH);
  except
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  for I := LDataLength + 1 to Length(LHexData) - 1 do
  begin
    LHexdata[I] := '0';
  end;
  LHexdata[Length(LHexData)] := '>';
  FStream.SetPosition(LOffset2 + Length('<'), soBeginning);
  FStream.Write(LHeXData);
  Finalize(LHeXData);
end;

end.
