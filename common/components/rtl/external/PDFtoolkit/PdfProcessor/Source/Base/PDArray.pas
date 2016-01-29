{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDArray;

interface

uses
  Classes, gtObject, PDBaseObject, Stream, Contnrs;

type
  (**
   * TgtArray
   *    This class represents the PDF array object of a PDF document
   *)
  TgtArray = class(TgtObject)
  private
   { private declarations }
    FParentDoc: TgtObject;
    FElements: TList; //array of elements
    FRef: Integer;
  public
   { public declarations }
    constructor Create(ParentDoc: TgtObject);
    destructor Destroy; override;

    procedure Add(AElement: TgtPDBaseObject);
    procedure Remove(AIndex: Integer); overload;
    function IncRef: Integer;
    function DecRef: Integer;
    function Get(Index: Integer): TgtPDBaseObject;
    function GetRefObj(Index: Integer): TgtPDBaseObject;
    procedure Insert(AObject: TgtPDBaseObject; Index: Integer);
    function Length: Integer;
    procedure SetParentDoc(Value: TgtObject);
    function GetParentDoc: TgtObject;
    property ParentDoc: TgtObject read GetParentDoc;
    property Elements: TList read FElements;
  end;

  (**
   *  TgtPDArray
   *    This is the class that is responsible for manipulation of Array objects.
   *  Using this class we can, add, delete elements from a PDF array object
   *)
  TgtPDArray = class(TgtPDBaseObject)
  private
    FArray: TgtArray;
    procedure WriteEncryptedString(AStringObj: TgtPDBaseObject;
      Stream: TgtStream; OnlyChanged: Boolean; XRef: TgtObject);
  public
    constructor Create(AParentDoc: TgtObject; AObjNumber, AGenNumber:
      Cardinal); overload;
    constructor Create(AParentDoc: TgtObject); overload;
    constructor Create(AArray: TgtArray; AObjNumber, AGenNumber:
      Cardinal); overload;
    constructor Create(AArray: TgtArray); overload;
    destructor Destroy; override;

    function Clone: TgtPDBaseObject; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;
    function WriteIDWithoutEncrypting(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal;
    function IsArray: Boolean; override;
    function GetLength: Integer;
    procedure Add(AElement: TgtPDBaseObject);
    procedure Insert(AObject: TgtPDBaseObject; Index: Integer);
    procedure Remove(Index: Integer); overload;
    procedure GetIndirectRefs(List: TObjectList);
    procedure SetValue(AObject: TgtPDBaseObject; AIndex: Integer);

    procedure Assign(ASourceObj: TgtPDBaseObject); override;

    function Get(Index: Integer): TgtPDBaseObject;
    function GetRefObj(Index: Integer): TgtPDBaseObject;
    function GetClone(Index: Integer): TgtPDBaseObject;
    function GetRefObjClone(Index: Integer): TgtPDBaseObject;
    procedure SetParentDoc(Value: TgtObject);
    function GetParentDoc: TgtObject;
  end;

implementation

uses
  PDNull, PDIndirectRef, PDString, PDName, PDStream, PDInteger, PDBoolean,
  PDReal, gtConstants, PDConsts, PDBaseDoc, PDXRef, PDXRefEntry, gtMethods,
  PDDictionary, PDBaseExceptions, Memorystream, CryptStream, EncryptionSettings;

{ TgtArray }

  (**
   * Adds an element into the current Array object
   *
   * @param AElement is the Element to be added to the Array object
   *
   * @exception ExOutofMemory is raised if allocation out of memory
   *)

procedure TgtArray.Add(AElement: TgtPDBaseObject);
begin
  if not Assigned(FElements) then
    FElements := TList.Create;
  FElements.Add(AElement);
end;

  (**
   * Constructor
   *
   * @param ParentDoc is the Parent Document of this object
   *)

constructor TgtArray.Create(ParentDoc: TgtObject);
begin
  FParentDoc := ParentDoc;
  FElements := nil;
  FRef := 1;
end;

  (**
   * Decreases the reference  count for the object by one for each call
   *
   * @return total number of references for this object after decreasing it by one
   *)

function TgtArray.DecRef: Integer;
begin
  Dec(FRef);
  Result := FRef;
end;

  (**
   * Destructor
   *)

destructor TgtArray.Destroy;
var
  I: Integer;
begin
  if Assigned(FElements) then
  begin
    for I := 0 to FElements.Count - 1 do
      TObject(FElements.Items[I]).Free;
    FElements.Free;
  end;
  inherited;
end;

  (**
   * Gets the element from index position of the array
   * @param Index is the position of the element to be retrieved
   *
   * @return TgtPDBaseObject is the object in the Index position
   *)

function TgtArray.Get(Index: Integer): TgtPDBaseObject;
begin
  Result := nil;
  if Assigned(FElements) and (Index > -1) and (Index < FElements.Count) then
  begin
    if TgtPDBaseObject(FElements.Items[Index]).IsIndirectRef
      and Assigned(FParentDoc) then
    begin
      Result := TgtPDBaseDoc(FParentDoc).GetObject(
        TgtPDIndirectRef(FElements.Items[Index]).ObjNumber);
    end
    else
      Result := TgtPDBaseObject(FElements.Items[Index]);

//    if Result.IsDict then TgtPDDictionary(Result).SetParentDoc(FParentDoc)
//    else if Result.IsArray then TgtPDArray(Result).SetParentDoc(FParentDoc);
  end;
end;

function TgtArray.GetParentDoc: TgtObject;
begin
  Result := FParentDoc;
end;

(**
   * Gets a clone object from the position Index of Array
   *
   * @param Index is the position of Element to be retrieved from Array object
   *
   * @return TgtPDBaseObject is the Element present at the requested index of
   *          the Array
   *)

function TgtPDArray.GetClone(Index: Integer): TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  LObj := Get(Index);
  if Assigned(LObj) then
    Result := LObj.Clone
  else
    Result := TgtPDNull.Create;
end;

  (**
   * Gets a reference object present in the array from the given position
   * @param Index is the index of the reference element to be retrieved
   *
   * @return TgtPDBaseObject is the reference object(indirect object) in the
   *         Index position
   *)

function TgtArray.GetRefObj(Index: Integer): TgtPDBaseObject;
begin
  Result := nil;
  if Assigned(FElements) and (Index > -1) and (Index < FElements.Count) then
  begin
    Result := FElements.Items[Index];
//    if Result.IsDict then TgtPDDictionary(Result).SetParentDoc(FParentDoc)
//    else if Result.IsArray then TgtPDArray(Result).SetParentDoc(FParentDoc);
  end;
end;

  (**
   * Gets a clone object of Indirect reference from the position Index of Array
   *
   * @param Index is the position of Indirect reference Element to be retrieved
   *         from Array object
   *
   * @return TgtPDBaseObject is the Indirect reference Element present at the
   *         requested index of the Array
   *)

function TgtPDArray.GetRefObjClone(Index: Integer): TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  LObj := GetRefObj(Index);
  if Assigned(LObj) then
    Result := LObj.Clone
  else
    Result := TgtPDNull.Create;
end;

  (**
   * Increases the reference count for the object by one for each call
   *
   * @return total number of references for this object after increasing it by one
   *)

function TgtArray.IncRef: Integer;
begin
  Inc(FRef);
  Result := FRef;
end;

procedure TgtArray.Insert(AObject: TgtPDBaseObject; Index: Integer);
begin
  if not Assigned(FElements) then
    FElements := TList.Create;
  FElements.Insert(Index, AObject);
end;

(**
   * Gets the total number of elements present in the array
   *
   * @return the number of elements in the array
   *)

function TgtArray.Length: Integer;
begin
  Result := 0;
  if Assigned(FElements) then
    Result := FElements.Count;
end;

procedure TgtArray.Remove(AIndex: Integer);
var
  LObj: TObject;
begin
  if Assigned(FElements) and (AIndex > -1) and (AIndex < FElements.Count) then
  begin
    LObj := FElements.Items[AIndex];
    FElements.Delete(AIndex);
    LObj.Free;
  end;
end;


(**
   * Sets the Parent document of this object with the value passed
   * @param Value is the Parent document for the object
   *)

procedure TgtArray.SetParentDoc(Value: TgtObject);
begin
  FParentDoc := Value;
end;

{ TgtPDArray }

  (**
   * Adds an element into the current Array object
   *
   * @param AElement is the Element to be added to the Array object
   *
   * @exception ExOutofMemory is raised if allocation out of memory
   *)

procedure TgtPDArray.Add(AElement: TgtPDBaseObject);
begin
  FArray.Add(AElement);
  IsChanged := True;
end;

  (**
   * Creates an Array object with a different copy of all objects in the array
   *     from the Source document
   * @param ASourceObj is the source document from where the current
   *         object need to be created
   *)

procedure TgtPDArray.Assign(ASourceObj: TgtPDBaseObject);
var
  LObj, LCopyObj: TgtPDBaseObject;
  LI: Integer;
  LObjType: TgtPDObjTypes;
begin
  inherited;
  LCopyObj := nil;
  for LI := 0 to TgtPDArray(ASourceObj).GetLength - 1 do
  begin
    LObj := TgtPDArray(ASourceObj).GetRefObj(LI);

    LObjType := LObj.GetType;
    case LObjType of
      otBoolean:
        begin
          LCopyObj := TgtPDBoolean.Create(False);
          TgtPDBoolean(LCopyObj).Assign(LObj);
        end;

      otInteger:
        begin
          LCopyObj := TgtPDInteger.Create(0);
          TgtPDInteger(LCopyObj).Assign(LObj);
        end;

      otReal:
        begin
          LCopyObj := TgtPDReal.Create(0);
          TgtPDReal(LCopyObj).Assign(LObj);
        end;

      otString:
        begin
          LCopyObj := TgtPDString.Create('', False);
          TgtPDString(LCopyObj).Assign(LObj);
        end;

      otName:
        begin
          LCopyObj := TgtPDName.Create('');
          TgtPDName(LCopyObj).Assign(LObj);
        end;

      otArray:
        begin
          LCopyObj := TgtPDArray.Create(GetParentDoc);
          TgtPDArray(LCopyObj).Assign(LObj);
        end;

      otDict:
        begin
          LCopyObj := TgtPDDictionary.Create(GetParentDoc);
          TgtPDDictionary(LCopyObj).Assign(LObj);
        end;

      otIndirectRef:
        begin
          LCopyObj := TgtPDIndirectRef.Create($FFFFFFFF, $FFFFFFFF);
          TgtPDIndirectRef(LCopyObj).Assign(LObj);
        end;

      otStream:
        begin
          LCopyObj := TgtPDStream.Create(GetParentDoc);
          TgtPDStream(LCopyObj).Assign(LObj);
        end;
    end;
    FArray.Add(LCopyObj);
  end;
end;

  (**
   * Gets a copy of the current object
   * @return Copy of current object(Array)
   *)

function TgtPDArray.Clone: TgtPDBaseObject;
begin
  Result := TgtPDArray.Create(FArray, FObjNumber, FGenNumber);
  Result.IsChanged := IsChanged;
  FArray.IncRef;
end;

  (**
   * Constructor
   * @param AArray is the array object with which we create a array
   * @param AObjNumber is the object number that need to be set for this object
   * @param AGenNumber is the generation number that need to be set for this object
   *)

constructor TgtPDArray.Create(AArray: TgtArray; AObjNumber,
  AGenNumber: Cardinal);
begin
  FArray := AArray;

  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;

  FIsChanged := False;
end;

  (**
   * Constructor
   * @param AArray is the array object with which we create a array
   *)

constructor TgtPDArray.Create(AArray: TgtArray);
begin
  FArray := AArray;

  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;

  FIsChanged := False;
end;


  (**
   * Constructor
   * @param AParentDoc is parent document of this array object
   * @param AObjNumber is the object number that need to be set for this object
   * @param AGenNumber is the generation number that need to be set for this object
   *)

constructor TgtPDArray.Create(AParentDoc: TgtObject; AObjNumber,
  AGenNumber: Cardinal);
begin
  FArray := TgtArray.Create(AParentDoc);

  FIsChanged := False;

  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;
end;

  (**
   * Constructor
   * @param AParentDoc is parent document of this array object
   *)

constructor TgtPDArray.Create(AParentDoc: TgtObject);
begin
  FIsChanged := False;

  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;

  FArray := TgtArray.Create(AParentDoc);
end;

  (**
   * Destructor
   *)

destructor TgtPDArray.Destroy;
begin
  if FArray.DecRef = 0 then
    FArray.Destroy;
  inherited;
end;

  (**
   * Gets the element from index position of the array
   * @param Index is the position of the element to be retrieved
   *
   * @return TgtPDBaseObject is the object in the Index position
   *)

function TgtPDArray.Get(Index: Integer): TgtPDBaseObject;
begin
  Result := FArray.Get(Index);
end;

  (**
   * Gets all indirect references(indirect objects) from the Array
   * @param List is the list where all the indirect references will be stored
   *)

procedure TgtPDArray.GetIndirectRefs(List: TObjectList);
var
  LI: Integer;
  LObj: TgtPDBaseObject;
begin
  for LI := 0 to FArray.Length - 1 do
  begin
    LObj := FArray.Elements[LI];
    if Assigned(LObj) then
    begin
      if LObj.IsIndirectRef then
        List.Add(LObj)
      else if LObj.isArray then
        TgtPDArray(LObj).GetIndirectRefs(List)
      else if LObj.isDict then
        TgtPDDictionary(LObj).GetIndirectRefs(List);
    end;
  end;
end;

  (**
   * Gets the number of elements present in the array
   *
   * @return the number of elements in the array
   *)

function TgtPDArray.GetLength: Integer;
begin
  Result := FArray.Length;
end;

function TgtPDArray.GetParentDoc: TgtObject;
begin
  Result := FArray.FParentDoc;
end;

(**
   * Gets a reference object present in the array from the given position
   * @param Index is the index of the reference element to be retrieved
   *
   * @return TgtPDBaseObject is the reference object(indirect object) in the
   *         Index position
   *)

function TgtPDArray.GetRefObj(Index: Integer): TgtPDBaseObject;
begin
  Result := FArray.GetRefObj(Index);
end;

procedure TgtPDArray.Insert(AObject: TgtPDBaseObject; Index: Integer);
begin
  FArray.Insert(AObject, Index);
  IsChanged := True;
end;

  (**
   * True if the object is an Array object
   * @return True if the object is Array object, False otherwise
   *)

function TgtPDArray.IsArray: Boolean;
begin
  Result := True;
end;


procedure TgtPDArray.Remove(Index: Integer);
begin
  FArray.Remove(Index);
  IsChanged := True;
end;

  (**
   * This function writes the array object into the stream provided based on
      the writting parameters
   * @param Stream is the where this Array object need to be written into.
   * @param OnlyChanged flag indicates that, write those object of Array with
   *         the value set True for this parameter
   * @param XRef is the Xreferance table for this document
   *
   * @return count bytes written into the stream
   *)

function TgtPDArray.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
var
  List: TObjectList;
  I: Integer;
  LObj: TgtPDBaseObject;
  LXRefEntry: TgtPDXRefEntry;
  PrevObjNumber: Cardinal;
begin
  PrevObjNumber := 0;
  Result := 0;
  if ObjNumber <> $FFFFFFFF then
  begin
    PrevObjNumber := ObjNumber;
    TgtPDXRef(XRef).LastObjectNumber := TgtPDXRef(XRef).LastObjectNumber + 1;
    ObjNumber := TgtPDXRef(XRef).LastObjectNumber;
    GenNumber := 0;
    IsWritten := True;
  end;

  List := TObjectList.Create(False);
  try
    GetIndirectRefs(List);
    for I := 0 to List.Count - 1 do
    begin
      if Assigned(FArray.FParentDoc) then
      begin
        if not TgtPDBaseDoc(FArray.FParentDoc).IsObjectWritten(
          TgtPDIndirectRef(List.Items[I]).ObjNumber) then
        begin
          LObj := TgtPDBaseDoc(FArray.FParentDoc).GetObject(
            TgtPDIndirectRef(List.Items[I]).ObjNumber);
          if Assigned(LObj) and not LObj.IsNull then
          begin
            LObj.SaveToStream(Stream, OnlyChanged, XRef);
            if LObj.IsChanged then
              IsChanged := True;
          end;
        end;
      end;
    end;
  finally
    List.Free;
  end;

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
    Result := Result + Stream.Write(PD_ARRAYSTART + ' ');

    for I := 0 to FArray.Length - 1 do
    begin
      LObj := GetRefObj(I);
      if LObj.IsIndirectRef then
      begin
        if Assigned(FArray.ParentDoc) then
        begin
          if TgtPDBaseDoc(FArray.ParentDoc).IsObjectWritten(
            TgtPDIndirectRef(LObj).ObjNumber) then
            LObj.ObjNumber := Get(I).ObjNumber;
        end;
      end;

      if IsChanged then
        LObj.IsChanged := True;

      if LObj.IsString and (TgtPDBaseDoc(FArray.ParentDoc).IsEncrypted or
        (Assigned(TgtPDBaseDoc(FArray.ParentDoc).UserEncryptionSettings) and
              (TgtPDBaseDoc(FArray.ParentDoc).UserEncryptionSettings.Enabled)))then
      begin
        WriteEncryptedString(LObj, Stream, OnlyChanged, XRef)
      end
      else
        Result := Result + LObj.SaveToStream(Stream, OnlyChanged, XRef);
      Result := Result + Stream.Write(' ');
    end;

    if Result > 0 then
    begin
      if (ObjNumber <> $FFFFFFFF) then
        Result := Result + Stream.Write(PD_ARRAYEND + CRLF + PDF_ENDOBJ + CRLF)
      else
        Result := Result + Stream.Write(PD_ARRAYEND);
    end;
  end
  else
  begin
    if ObjNumber <> $FFFFFFFF then
      ObjNumber := PrevObjNumber;
  end;
end;

procedure TgtPDArray.WriteEncryptedString(AStringObj: TgtPDBaseObject;
  Stream: TgtStream; OnlyChanged: Boolean; XRef: TgtObject);
var
  LXRefEntry: TgtPDXRefEntry;
  LI: Integer;
  LValue: AnsiString;
  LStrObj: TgtPDString;
  LgtMemStream, LgtDataStrm: TgtMemoryStream;
  LMemStream, LDataStrm: TMemoryStream;
  LCryptStream: TgtCryptStream;
  LInfoObj, LObj: TgtPDBaseObject;
  LCreateDate: AnsiString;
begin
  LStrObj := TgtPDString(AStringObj);
  if (OnlyChanged and IsChanged) or not OnlyChanged then
  begin
    if LStrObj.ObjNumber <> $FFFFFFFF then
    begin
      TgtPDXRef(XRef).LastObjectNumber := TgtPDXRef(XRef).LastObjectNumber + 1;
      LStrObj.ObjNumber := TgtPDXRef(XRef).LastObjectNumber;
      LStrObj.GenNumber := 0;
      LXRefEntry := TgtPDXRefEntry.Create;
      try
        LXRefEntry.Offset := Stream.GetPosition;
        LXRefEntry.GenNum := LStrObj.GenNumber;
        LXRefEntry.EntryType := xeUnCompressed;
        TgtPDXRef(XRef).Entries[LStrObj.ObjNumber] := LXRefEntry;
      finally
        LXRefEntry.Free;
      end;
      Stream.Write(IntegerToString(LStrObj.ObjNumber) + ' ' +
      IntegerToString(LStrObj.GenNumber) + ' ' + PDF_OBJ + CRLF);
    end;

    if LStrObj.IsHexString then
      Stream.Write(AnsiChar(LESSTHANSIGN))
    else
      Stream.Write(AnsiChar(LEFTPARENTHESIS));

    if LStrObj.Value <> '' then
    begin
      LI := 1;
      LValue := '';
      while (LI <= Length(LStrObj.Value)) do
      begin
        case LStrObj.Value[LI] of
          AnsiChar(#8): LValue := LValue + '\b';
          AnsiChar(#9): LValue := LValue + '\t';
          AnsiChar(#10): LValue := LValue + '\n';
          AnsiChar(#12): LValue := LValue + '\f';
          AnsiChar(#13): LValue := LValue + '\r';
          AnsiChar(#40): LValue := LValue + '\(';
          AnsiChar(#41): LValue := LValue + '\)';
          AnsiChar(#92): LValue := LValue + '\\';
        else
          LValue := LValue + AnsiChar(LStrObj.Value[LI]);
        end;
        Inc(LI);
      end;
    LMemStream := TMemoryStream.Create;
    LgtMemStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
    try
      LgtMemStream.Write(LValue);
      LgtMemStream.Reset;

      LInfoObj := TgtPDBaseDoc(FArray.GetParentDoc).GetDocInfo();
      LObj := TgtPDDictionary(LInfoObj).LookUp(PDF_CREATIONDATE);

      if Assigned(LObj) then
        LCreateDate := TgtPDName(LObj).Value;

      if (LStrObj.ObjNumber <> $FFFFFFFF) then
      begin
        LCryptStream := TgtCryptStream.Create(LgtMemStream, LCreateDate,
        TgtPDBaseDoc(FArray.GetParentDoc).UserEncryptionSettings, cryptRC4, 0,
        LStrObj.ObjNumber, LStrObj.GenNumber);
      end
      else
      begin
        LCryptStream := TgtCryptStream.Create(LgtMemStream, LCreateDate,
        TgtPDBaseDoc(FArray.GetParentDoc).UserEncryptionSettings, cryptRC4, 0,
        ObjNumber, GenNumber);
      end;
      
      if LStrObj.IsHexString then
        LValue := HexToStr(LValue);

      LDataStrm := TMemoryStream.Create;
      LgtDataStrm := TgtMemoryStream.Create(LDataStrm, 0, 0, False);
      try
        LCryptStream.Reset;
        LgtMemStream.Reset;
        LCryptStream.Write(LgtDataStrm, Length(LValue));
        LDataStrm.Position := 0;
        LDataStrm.Read(LValue[1], LDataStrm.Size);
        if LStrObj.IsHexString then
          LStrObj.Value := StringToHex2(LValue)
        else
          LStrObj.Value := LValue;

        Stream.Write(LStrObj.Value);
      finally
        if Assigned(LgtDataStrm) then
          FreeObject(LgtDataStrm);
        if Assigned(LCryptStream) then
          FreeObject(LCryptStream);
      end;
    finally
      if Assigned(LgtMemStream) then
      FreeObject(LgtMemStream);
    end;

    if LStrObj.IsHexString then
      Stream.Write(AnsiChar(GREATERTHANSIGN))
    else
      Stream.Write(AnsiChar(RIGHTPARENTHESIS));
    end;

    IsWritten := True;
    if LStrObj.ObjNumber <> $FFFFFFFF then
      Stream.Write(CRLF + PDF_ENDOBJ + CRLF);
  end;//end of IF
end;


function TgtPDArray.WriteIDWithoutEncrypting(Stream: TgtStream;
  OnlyChanged: Boolean; XRef: TgtObject): Cardinal;
var
  List: TObjectList;
  I: Integer;
  LObj: TgtPDBaseObject;
  LXRefEntry: TgtPDXRefEntry;
  PrevObjNumber: Cardinal;
begin
  PrevObjNumber := 0;
  Result := 0;
  if ObjNumber <> $FFFFFFFF then
  begin
    PrevObjNumber := ObjNumber;
    TgtPDXRef(XRef).LastObjectNumber := TgtPDXRef(XRef).LastObjectNumber + 1;
    ObjNumber := TgtPDXRef(XRef).LastObjectNumber;
    GenNumber := 0;
    IsWritten := True;
  end;

  List := TObjectList.Create(False);
  try
    GetIndirectRefs(List);
    for I := 0 to List.Count - 1 do
    begin
      if Assigned(FArray.FParentDoc) then
      begin
        if not TgtPDBaseDoc(FArray.FParentDoc).IsObjectWritten(
          TgtPDIndirectRef(List.Items[I]).ObjNumber) then
        begin
          LObj := TgtPDBaseDoc(FArray.FParentDoc).GetObject(
            TgtPDIndirectRef(List.Items[I]).ObjNumber);
          if Assigned(LObj) and not LObj.IsNull then
          begin
            LObj.SaveToStream(Stream, OnlyChanged, XRef);
            if LObj.IsChanged then
              IsChanged := True;
          end;
        end;
      end;
    end;
  finally
    List.Free;
  end;

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
    Result := Result + Stream.Write(PD_ARRAYSTART + ' ');

    for I := 0 to FArray.Length - 1 do
    begin
      LObj := GetRefObj(I);
      if LObj.IsIndirectRef then
      begin
        if Assigned(FArray.ParentDoc) then
        begin
          if TgtPDBaseDoc(FArray.ParentDoc).IsObjectWritten(
            TgtPDIndirectRef(LObj).ObjNumber) then
            LObj.ObjNumber := Get(I).ObjNumber;
        end;
      end;

      if IsChanged then
        LObj.IsChanged := True;

      Result := Result + LObj.SaveToStream(Stream, OnlyChanged, XRef);
      Result := Result + Stream.Write(' ');
    end;

    if Result > 0 then
    begin
      if (ObjNumber <> $FFFFFFFF) then
        Result := Result + Stream.Write(PD_ARRAYEND + CRLF + PDF_ENDOBJ + CRLF)
      else
        Result := Result + Stream.Write(PD_ARRAYEND);
    end;
  end
  else
  begin
    if ObjNumber <> $FFFFFFFF then
      ObjNumber := PrevObjNumber;
  end;
end;

(**
   * Sets the Parent document of this object with the value passed
   * @param Value is the Parent document for the object
   *)

procedure TgtPDArray.SetParentDoc(Value: TgtObject);
begin
  FArray.SetParentDoc(Value);
end;

procedure TgtPDArray.SetValue(AObject: TgtPDBaseObject; AIndex: Integer);
begin
  FArray.Remove(AIndex);
  FArray.Insert(AObject, AIndex);
end;

end.
