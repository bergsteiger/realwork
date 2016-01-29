unit PDStream;

interface

uses
  Classes, gtObject, PDBaseObject, Stream, PDDictionary, gtTypes;

type
  TgtPDStream = class(TgtPDBaseObject)
  private
    FStream: TgtStream;
    FDict: TgtPDDictionary;
    FParentDoc: TgtObject;

    function GetEncodedStream(AOutMem: TMemoryStream): TgtStream;
    function GetEncryptedStream(AStream: TgtStream; AOutMem: TMemoryStream): TgtStream;
  public
    constructor Create(AStream: TgtStream; ADict: TgtPDBaseObject; AObjNumber,
      AGenNumber: Cardinal); overload;
    constructor Create(AStream: TgtStream; ADict: TgtPDBaseObject); overload;
    constructor Create(AParentDoc: TgtObject); overload;
    destructor Destroy; override;

    function Clone: TgtPDBaseObject; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;
    function IsStream: Boolean; override;
    function GetDict: TgtPDBaseObject;
    procedure SetDict(Value: TgtPDDictionary);
    function Isof(const ADictType: AnsiString): Boolean;
    procedure Reset;
    procedure Close;
    function GetChar: Integer;
    function LookChar: Integer;
    function ReadLine(Count: Longint): AnsiString;
    function GetPosition: Cardinal;
    procedure SetPosition(const Offset: Int64; Origin: TSeekOrigin);
    function MakeSubStream(AStart: Longint; ALength: Longint;
      ALimited: Boolean; ADict: TgtPDBaseObject): TgtPDStream;
    function GetStart: Longint;
    procedure MoveStart(Delta: Int64);

    procedure Assign(ASourceObj: TgtPDBaseObject); override;

    function Read(var Buffer: Bytes; Count: Longint): Longint; overload;
    function Read(var Buffer: AnsiString; Count: Longint): Longint; overload;
    function Write(const Buffer: Bytes; Count: Longint): Longint; overload;
    function Write(const Buffer: AnsiString): Longint; overload;

    function GetStream: TgtStream;
  end;

implementation

uses
  BaseStream, gtMethods, gtConstants, PDFilterManager, Contnrs, PDXRef,
  PDXRefEntry, PDBaseDoc, PDIndirectRef, PDInteger, gtLogger, PDBaseExceptions,
  SysUtils, MemoryStream, PDConsts, PDName, FlateStream, CryptStream, PDString,
  EncryptionSettings, PDArray;

{ TgtPDStream }

procedure TgtPDStream.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;
  FStream := TgtPDStream(ASourceObj).FStream.GetBaseStream;

  FDict := TgtPDDictionary.Create(FParentDoc);
  FDict.Assign(TgtPDStream(ASourceObj).GetDict);
end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the Stream object with the same properties of
   *         current object
   *)

function TgtPDStream.Clone: TgtPDBaseObject;
begin
  Result := TgtPDStream.Create(FStream, FDict, FObjNumber, FGenNumber);
  Self.FStream.IncRef;
end;

procedure TgtPDStream.Close;
begin
  FStream.Close;
end;

constructor TgtPDStream.Create(AParentDoc: TgtObject);
begin
  FParentDoc := AParentDoc;
  FStream := nil;
  FDict := nil;
  FIsChanged := False;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
end;

(**
   * Constructor
   *
   * @param AValue is the Stream value with which this object will created
   * @param ADict is the dictionary object with which this object will created
   *)

constructor TgtPDStream.Create(AStream: TgtStream; ADict: TgtPDBaseObject);
begin
  FStream := AStream;
  FDict := TgtPDDictionary(ADict);
  FIsChanged := False;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
end;

  (**
   * Constructor
   *
   * @param AValue is the Stream value with which this object will created
   * @param AObjNumber is the object number with which this object will created
   * @param AGenNumber is the object generation with which this object will created
   * @param ADict is the dictionary object with which this object will created
   *)

constructor TgtPDStream.Create(AStream: TgtStream; ADict: TgtPDBaseObject;
  AObjNumber, AGenNumber: Cardinal);
begin
  FStream := AStream;
  FDict := TgtPDDictionary(ADict);
  FIsChanged := False;
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;
end;

destructor TgtPDStream.Destroy;
begin
  if FStream.DecRef = 0 then
    FStream.Free;
  FDict.Free;
  inherited;
end;

  (**
   * Gets a character from Fstream
   * @return A Character(Integer Value)
   *)

function TgtPDStream.GetChar: Integer;
begin
  Result := FStream.GetChar;
end;

  (*
   * Gets the current Dictionary object
   * @return  the Dictionary object
   *)

function TgtPDStream.GetDict: TgtPDBaseObject;
begin
  Result := FDict;
end;

function TgtPDStream.GetEncodedStream(AOutMem: TMemoryStream): TgtStream;
var
  LMemStream: TMemoryStream;
  LgtMemStream: TgtMemoryStream;
  LFilterStream: TgtFlateStream;
  LLength: Integer;
  LObj, LObj2: TgtPDBaseObject;
  LIsWiredStream: Boolean;
  LBuffer: Bytes;
begin
  LFilterStream := nil;
  LLength := 0;
  LIsWiredStream := false;
  LMemStream := TMemoryStream.Create;
  LgtMemStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
  Result := TgtMemoryStream.Create(AOutMem, 0, 0, False);
  try
    begin
      LObj := FDict.LookUp(PDF_LENGTH);
      if Assigned(LObj) then
        LLength := TgtPDInteger(LObj).Value;
      if (LLength <> 0) then
      begin
        LObj := FDict.LookUp(PD_FILTER);
        if Assigned(LObj) and (not LObj.IsName(PD_JBIG2DECODE)) then
          FDict.Remove(PDF_DECODEPARMS);
        if Assigned(LObj) and (LObj.IsName(PD_JBIG2DECODE)) then
          LIsWiredStream := true;
        FStream.Reset;
        LgtMemStream.CopyFrom(FStream, LLength);
        LgtMemStream.Reset;
        LFilterStream := TgtFlateStream.Create(LgtMemStream, 1, 1, 1, 8);
        if Assigned(LObj) then
        begin
          if not LIsWiredStream then
          begin
            FDict.Remove(PD_FILTER);
            FDict.SetKeyValue(PD_FILTER, TgtPDName.Create(PD_FLATEDECODE));
          end;
        end
        else
          FDict.SetKeyValue(PD_FILTER, TgtPDName.Create(PD_FLATEDECODE));

        if not LIsWiredStream then
          LFilterStream.Write(Result, 0)
        else
        begin
          LgtMemStream.Reset;
          SetLength(LBuffer, LgtMemStream.GetSize);
          LMemStream.Read(LBuffer[0], LgtMemStream.GetSize);
          Result.Write(LBuffer, LgtMemStream.GetSize);
          SetLength(LBuffer, 0);
        end;
        FDict.SetKeyValue(PDF_LENGTH, TgtPDInteger.Create(AOutMem.Size));
      end;
    end;
  finally
    if Assigned(LgtMemStream) then
      FreeObject(LgtMemStream);
    if Assigned(LFilterStream) then
      FreeObject(LFilterStream);
  end;
end;

function TgtPDStream.GetEncryptedStream(AStream: TgtStream;
  AOutMem: TMemoryStream): TgtStream;
var
  LInfoObj, LObj: TgtPDBaseObject;
  LFilterStream: TgtCryptStream;
  LCreateDate: AnsiString;
begin
  Result := TgtMemoryStream.Create(AOutMem, 0, 0, False);
  try
    LInfoObj := TgtPDBaseDoc(FDict.GetParentDoc).GetDocInfo();
    LObj := TgtPDDictionary(LInfoObj).LookUp(PDF_CREATIONDATE);
    if Assigned(LObj) then
      LCreateDate := TgtPDName(LObj).Value;

    LFilterStream := TgtCryptStream.Create(AStream, LCreateDate,
      TgtPDBaseDoc(FDict.GetParentDoc).UserEncryptionSettings, cryptRC4, 0,
      ObjNumber, GenNumber);
    AStream.Reset;
    LFilterStream.Write(Result, TgtMemoryStream(AStream).GetSize);
  finally
    if Assigned(LFilterStream) then
      FreeObject(LFilterStream);
  end;
end;

function TgtPDStream.GetPosition: Cardinal;
begin
  Result := FStream.GetPosition;
end;

function TgtPDStream.GetStart: Longint;
begin
  if not (FStream is TgtBaseStream) then
  begin
    Result := 0;
{$IFDEF DEBUG}
    Logger.LogError('Internal: Cannot call GetStart on Filter streams');
{$ENDIF}
    Exit;
  end;
  Result := TgtBaseStream(FStream).GetStart;
end;

function TgtPDStream.GetStream: TgtStream;
begin
  Result := FStream;
end;

  (**
   * Checks whether the dictionary has given type entry
   * @param ADictType is the given type to check
   * @return True if dictionary has given type entry, else false
   *)

function TgtPDStream.Isof(const ADictType: AnsiString): Boolean;
begin
  Result := Assigned(FDict) and FDict.IsDict(ADictType);
end;

  (**
   * Checks whether the object is Stream object or not
   *
   * @return true if the object is Stream object
   *)

function TgtPDStream.IsStream: Boolean;
begin
  Result := True;
end;

  (**
   * Gets a character from Fstream
   * @return A Character(Integer Value)
   *)

function TgtPDStream.LookChar: Integer;
begin
  Result := FStream.LookChar;
end;

function TgtPDStream.MakeSubStream(AStart, ALength: Integer;
  ALimited: Boolean; ADict: TgtPDBaseObject): TgtPDStream;
var
  LStream: TgtBaseStream;
begin
  if not (FStream is TgtBaseStream) then
  begin
    Result := nil;
{$IFDEF DEBUG}
    Logger.LogError('Internal: Cannot call MakeSubstream on Filter streams');
{$ENDIF}
    Exit;
  end;
  LStream := TgtBaseStream(FStream).MakeSubStream(AStart, ALength,
    ALimited) as TgtBaseStream;
  Result := TgtPDStream.Create(LStream, ADict);
end;

procedure TgtPDStream.MoveStart(Delta: Int64);
begin
  if not (FStream is TgtBaseStream) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Internal: Cannot call Movestart on Filter streams');
{$ENDIF}
    Exit;
  end;
  TgtBaseStream(FStream).MoveStart(Delta);
end;

function TgtPDStream.Read(var Buffer: Bytes; Count: Longint): Longint;
begin
  Result := FStream.Read(Buffer, Count);
end;

function TgtPDStream.Read(var Buffer: AnsiString; Count: Longint): Longint;
begin
  Result := FStream.Read(Buffer, Count);
end;

function TgtPDStream.ReadLine(Count: Integer): AnsiString;
var
  LBuffer: Bytes;
  LI: Integer;
begin
  Result := '';
  SetLength(LBuffer, Count);
  FStream.ReadLine(LBuffer, Count);
  for LI := 0 to Length(LBuffer) - 1 do
    Result := Result + AnsiChar(LBuffer[LI]);
end;

(**
 * Resets the Stream to its defaults
 * @exception ExInvalidStream if FStream is FULL
 *)

procedure TgtPDStream.Reset;
begin
  try
    FStream.Reset;
  except
    on E: Exception do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
end;

  (**
   * This function will writes the Stream object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDStream.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
var
  LXRefEntry: TgtPDXRefEntry;
  PrevObjNumber: Cardinal;
  List: TObjectList;
  I: Integer;
  LObj: TgtPDBaseObject;
  LParentDoc: TgtObject;
  LBytes: Bytes;
  LLength: Integer;
  LOutStream, LCryptStream: TMemoryStream;
  LgtOutMemStream, LgtCryptStream: TgtMemoryStream;
  LIsEncrypted: Boolean;
begin
  PrevObjNumber := $FFFFFFFF;
  Result := 0;
  if ObjNumber <> $FFFFFFFF then
  begin
    PrevObjNumber := ObjNumber;
    TgtPDXRef(XRef).LastObjectNumber := TgtPDXRef(XRef).LastObjectNumber + 1;
    ObjNumber := TgtPDXRef(XRef).LastObjectNumber;
    GenNumber := 0;
    IsWritten := True;
  end;

  LLength := 0;

  LObj := FDict.LookUp(PDF_LENGTH);
  if LObj.IsInteger then
    LLength := TgtPDInteger(LObj).Value;
//  LObj.Free;


  LParentDoc := FDict.GetParentDoc;
  List := TObjectList.Create(False);
  try
    FDict.GetIndirectRefs(List);
    for I := 0 to List.Count - 1 do
    begin
      if Assigned(LParentDoc) then
      begin
        if not TgtPDBaseDoc(LParentDoc).IsObjectWritten(
          TgtPDIndirectRef(List.Items[I]).ObjNumber) then
        begin
          LObj := TgtPDBaseDoc(LParentDoc).GetObject(
            TgtPDIndirectRef(List.Items[I]).ObjNumber);
          if Assigned(LObj) then
          begin
            if Assigned(LObj) then
              LObj.SaveToStream(Stream, OnlyChanged, XRef);
            if LObj.IsChanged then
              FDict.IsChanged := True;
          end;
        end;
      end;
    end;
  finally
    List.Free;
  end;

  IsChanged := FDict.IsChanged;

  if (OnlyChanged and IsChanged) or not OnlyChanged then
  begin
    if ObjNumber <> $FFFFFFFF then
    begin
      LXRefEntry := TgtPDXRefEntry.Create;
      try
        LXRefEntry.Offset := Stream.GetPosition;
        LXRefEntry.GenNum := GenNumber;
        LXRefEntry.EntryType := xeUnCompressed;
        TgtPDXRef(XRef).Entries[ObjNumber] := LXRefEntry;
      finally
        LXRefEntry.Free;
      end;

      Result := Result + Stream.Write(IntegerToString(ObjNumber) + ' ' +
        IntegerToString(GenNumber) + ' ' + PDF_OBJ + CRLF);
    end;

    LIsEncrypted := TgtPDBaseDoc(FDict.GetParentDoc).IsEncrypted;
    if IsChanged or (not Assigned(FDict.LookUp(PD_FILTER))) or LIsEncrypted or
      (Assigned(TgtPDBaseDoc(FDict.GetParentDoc).UserEncryptionSettings)) then
    begin
      try
        LOutStream := TMemoryStream.Create;
        LgtOutMemStream := GetEncodedStream(LOutStream) as TgtMemoryStream;
        if LIsEncrypted or (Assigned(TgtPDBaseDoc(FDict.GetParentDoc).UserEncryptionSettings) and
          TgtPDBaseDoc(FDict.GetParentDoc).UserEncryptionSettings.Enabled) then
        begin
          LCryptStream := TMemoryStream.Create;
          LgtCryptStream := GetEncryptedStream(LgtOutMemStream, LCryptStream) as TgtMemoryStream;
          try
            LCryptStream.Position := 0;
            SetLength(LBytes, LCryptStream.Size);
            LCryptStream.Read(LBytes[0], LCryptStream.Size);
          finally
            if Assigned(LgtCryptStream) then
              FreeAndNil(LgtCryptStream);
          end;
        end
        else
        begin
          LOutStream.Position := 0;
          SetLength(LBytes, LOutStream.Size);
          LOutStream.Read(LBytes[0], LOutStream.Size);
        end;
        IsChanged := True;
      finally
        if Assigned(LgtOutMemStream) then
          FreeObject(LgtOutMemStream);
      end;
    end;

    FDict.SaveToStream(Stream, OnlyChanged, XRef);

    Result := Result + Stream.Write(CRLF + PDF_STREAM + CRLF);

    FStream.GetBaseStream.Reset;
    if IsChanged then
    begin
      Result := Result + Stream.Write(LBytes, Length(LBytes));
      SetLength(LBytes, 0);
    end
    else
      Result := Result + Stream.CopyFrom(FStream.GetBaseStream, LLength);


    if ObjNumber <> $FFFFFFFF then
      Result := Result + Stream.Write(CRLF + PDF_ENDSTREAM + CRLF +
        PDF_ENDOBJ + CRLF);
  end
  else
  begin
    if ObjNumber <> $FFFFFFFF then
    begin
      ObjNumber := PrevObjNumber;
      TgtPDXRef(XRef).LastObjectNumber := TgtPDXRef(XRef).LastObjectNumber - 1;
    end;
  end;
end;

  (*
   * Sets the Dictionary object
   * @param Value is a Dictionary object
   *)

procedure TgtPDStream.SetDict(Value: TgtPDDictionary);
begin
  FDict := Value;
end;

procedure TgtPDStream.SetPosition(const Offset: Int64;
  Origin: TSeekOrigin);
begin
  FStream.SetPosition(Offset, Origin);
end;

function TgtPDStream.Write(const Buffer: AnsiString): Longint;
begin
  Result := FStream.Write(Buffer);
end;

function TgtPDStream.Write(const Buffer: Bytes; Count: Longint): Longint;
begin
  Result := FStream.Write(Buffer, Count);
end;

end.
