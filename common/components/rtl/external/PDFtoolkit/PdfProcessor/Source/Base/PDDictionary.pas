{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDDictionary;

{$I ..\Utils\gtCompilerDefines.inc}

interface

uses
  Classes, gtObject, PDBaseObject, Stream, Contnrs;

type

  TgtDictEntry = record
    Key: AnsiString;
    Value: TgtPDBaseObject;
  end;

    //Array of Dictionary entries
  TgtDictEntries = array of TgtDictEntry;

  (**
   * This class represents a PDF document's Dictionary object. A Dictionary
   * object is an associative table containing pairs of objects, known as the
   * dictionary's entries. The first element of each entry is the key and the
   * second element is the value.
   *)

  TgtDict = class(TgtObject)
  private
    FParentDoc: TgtObject;
    FEntries: TStringList;
    FRef: Integer;

    function Find(Key: AnsiString): TgtPDBaseObject;
  public
    constructor Create(AParentDoc: TgtObject);
    destructor Destroy; override;

    procedure Add(const Key: AnsiString; const Value: TgtPDBaseObject); overload;
    procedure Add(Key: TgtPDBaseObject; Value: TgtPDBaseObject); overload;
    function Isof(const AType: AnsiString): Boolean;
    function LookUp(const Key: AnsiString): TgtPDBaseObject;
    function LookupRefObj(const Key: AnsiString): TgtPDBaseObject;
    function GetValue(AIndex: Integer): TgtPDBaseObject;
    function GetValueRefObj(AIndex: Integer): TgtPDBaseObject;
    procedure Remove(Key: AnsiString); overload;
    procedure Remove(Key: TgtPDBaseObject); overload;

    procedure SetValue(AIndex: Integer; Value: TgtPDBaseObject);
    procedure SetKey(AIndex: Integer; AKey: AnsiString);

    function GetKey(AIndex: Integer): AnsiString;
    procedure SetParentDoc(AParentDoc: TgtObject);

    function IncRef: Integer;
    function DecRef: Integer;

    function GetEntries: TStringList;
    function GetLength: Integer;
    function GetParentDoc: TgtObject;
    function Clone: TgtDict;

    property Length: Integer read GetLength;
    property ParentDoc: TgtObject read GetParentDoc;
    property Entries: TStringList read GetEntries;
  end;


  TgtPDDictionary = class(TgtPDBaseObject)
  private
    FDict: TgtDict;

    procedure WriteEncryptedString(AStringObj: TgtPDBaseObject;
      Stream: TgtStream; OnlyChanged: Boolean; XRef: TgtObject);
    function ToUnicodeHex(AStr: WideString): String;
  public
    constructor Create(AObjNumber, AGenNumber: Cardinal;
      AParentDoc: TgtObject); overload;
    constructor Create(AObjNumber, AGenNumber: Cardinal; ADict: TgtDict); overload;
    constructor Create(AParentDoc: TgtObject); overload;
    constructor Create(ADict: TgtDict); overload;
    destructor Destroy; override;

    function Clone: TgtPDBaseObject; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;
    function IsDict: Boolean; overload; override;
    function IsDict(const ADictType: AnsiString): Boolean; overload; override;
    procedure Add(const Key: AnsiString; const AValue: TgtPDBaseObject); overload;
    procedure Add(Key: TgtPDBaseObject; AValue: TgtPDBaseObject); overload;
    procedure Remove(Key: AnsiString); overload;
    procedure Remove(Key: TgtPDBaseObject); overload;
    procedure SetKeyValue(Key: AnsiString; AValue: TgtPDBaseObject);
    function LookUp(const Key: AnsiString): TgtPDBaseObject;
    function LookupRefObj(const Key: AnsiString): TgtPDBaseObject;
    function LookUpClone(const Key: AnsiString): TgtPDBaseObject;
    function LookupRefObjClone(const Key: AnsiString): TgtPDBaseObject;

    procedure SetKey(AIndex: Integer; AKey: AnsiString);
    procedure SetValue(AIndex: Integer; Value: TgtPDBaseObject);
    function GetValue(AIndex: Integer): TgtPDBaseObject;
    function GetValueRefObj(AIndex: Integer): TgtPDBaseObject;
    function GetKey(Index: Integer): AnsiString;
    function GetLength: Integer;
    procedure GetIndirectRefs(List: TObjectList);

    //Returns a Copy of source object
    procedure Assign(ASourceObj: TgtPDBaseObject); override;

   //function GetObject(const ObjectPath: AnsiString): TgtPDBaseObject;

    procedure SetParentDoc(AParentDoc: TgtObject);
    function GetParentDoc: TgtObject;
  end;

implementation

uses
  PDNull, PDIndirectRef, PDInteger, PDReal, PDBoolean, PDName, PDString,
  PDStream, PDConsts, PDArray, gtMethods, SysUtils, PDBaseDoc, gtConstants,
  PDXRef, PDXRefEntry, PDBaseExceptions, MemoryStream, CryptStream,
  EncryptionSettings;

{ TgtDict }

procedure TgtDict.Add(Key, Value: TgtPDBaseObject);
begin
  if Key.IsName then
    Add(TgtPDName(Key).Value, Value);
end;

  (**
   * Adds an object into the current Dictionary object
   *
   * @param Key is the name
   * @param AValue is the Base Object
   *)

procedure TgtDict.Add(const Key: AnsiString; const Value: TgtPDBaseObject);
begin
  if not Assigned(FEntries) then
    FEntries := TStringList.Create;
  FEntries.AddObject(Key, Value);
end;

function TgtDict.Clone: TgtDict;
var
  I: Integer;
begin
  Result := TgtDict.Create(Self.FParentDoc);

  if Assigned(Self.FEntries) then
  begin
    Result.FEntries := TStringList.Create;
    for I := 0 to Self.FEntries.Count - 1 do
    begin
      Result.FEntries.AddObject(Self.FEntries[I],
        TgtPDBaseObject(Self.FEntries.Objects[I]).Clone);
    end;
    if not Result.FEntries.Sorted then
    begin
      {$IFDEF VCL6ORABOVE}
      Result.FEntries.CaseSensitive := True;
      {$ENDIF}
      Result.FEntries.Sort;
    end;
  end;
end;

constructor TgtDict.Create(AParentDoc: TgtObject);
begin
  FParentDoc := AParentDoc;
  FEntries := nil;
  FRef := 1;
end;

function TgtDict.DecRef: Integer;
begin
  Dec(FRef);
  Result := FRef;
end;

destructor TgtDict.Destroy;
var
  I: Integer;
begin
  if Assigned(FEntries) then
  begin
    for I := 0 to FEntries.Count - 1 do
      FEntries.Objects[I].Free;
    FEntries.Free;
  end;
  inherited;
end;

function TgtDict.Find(Key: AnsiString): TgtPDBaseObject;
var
  LI: Integer;
begin
  LI := 0;
  Result := nil;
  if Assigned(FEntries) then
  begin
    if not FEntries.Sorted then
    begin
      {$IFDEF VCL6ORABOVE}
      FEntries.CaseSensitive := True;
      {$ENDIF}
      FEntries.Sort;
    end;
    if FEntries.Find(Key, LI) then
      Result := FEntries.Objects[LI] as TgtPDBaseObject;
  end;
end;

function TgtDict.GetEntries: TStringList;
begin
  Result := FEntries;
end;

function TgtDict.GetKey(AIndex: Integer): AnsiString;
begin
  Result := '';
  if Assigned(FEntries) and (AIndex > -1) and (AIndex < FEntries.Count) then
    Result := FEntries.Strings[AIndex];
end;

function TgtDict.GetLength: Integer;
begin
  Result := 0;
  if Assigned(FEntries) then
    Result := FEntries.Count;
end;

function TgtDict.GetParentDoc: TgtObject;
begin
  Result := FParentDoc;
end;

function TgtDict.GetValue(AIndex: Integer): TgtPDBaseObject;
begin
  Result := nil;
  if Assigned(FEntries) and (AIndex > -1) and (AIndex < FEntries.Count) then
  begin
    if TgtPDBaseObject(FEntries.Objects[AIndex]).IsIndirectRef then
      Result := TgtPDBaseDoc(FParentDoc).GetObject(
        TgtPDIndirectRef(FEntries.Objects[AIndex]).ObjNumber)
    else
      Result := TgtPDBaseObject(FEntries.Objects[AIndex]);
  end;
end;

function TgtDict.GetValueRefObj(AIndex: Integer): TgtPDBaseObject;
begin
  Result := nil;
  if Assigned(FEntries) and (AIndex > -1) and (AIndex < FEntries.Count) then
  begin
    Result := TgtPDBaseObject(FEntries.Objects[AIndex]);
  end;
end;

function TgtDict.IncRef: Integer;
begin
  Inc(FRef);
  Result := FRef;
end;

  (**
   * Checks whether the dictionary has given type entry
   * @param ADictType is the given type to check
   * @return True if dictionary has given type entry, else false
   *)

function TgtDict.Isof(const AType: AnsiString): Boolean;
var
  LDictValue: TgtPDBaseObject;
begin
  Result := False;
  LDictValue := Find(PD_TYPE);
  if Assigned(LDictValue) and LDictValue.IsName(AType) then
    Result := True;
end;

function TgtDict.LookUp(const Key: AnsiString): TgtPDBaseObject;
var
  LDictValue: TgtPDBaseObject;
begin
  LDictValue := Find(Key);
  if Assigned(LDictValue) then
  begin
    if LDictValue.IsIndirectRef then
    begin
      Result := TgtPDBaseDoc(FParentDoc).
        GetObject(TgtPDIndirectRef(LDictValue).ObjNumber);
    end
    else
      Result := LDictValue;
  end
  else
    Result := nil;
end;

function TgtDict.LookupRefObj(const Key: AnsiString): TgtPDBaseObject;
var
  LDictValue: TgtPDBaseObject;
begin
  LDictValue := Find(Key);
  if Assigned(LDictValue) then
  begin
    Result := LDictValue;
  end
  else
    Result := nil;
end;

procedure TgtDict.Remove(Key: TgtPDBaseObject);
begin

end;

procedure TgtDict.Remove(Key: AnsiString);
var
  LI: Integer;
  LObj: TObject;
begin
  if Assigned(FEntries) then
  begin
    if not FEntries.Sorted then
      FEntries.Sort;
    if FEntries.Find(Key, LI) then
    begin
      LObj := FEntries.Objects[LI];
      FEntries.Delete(LI);
      LObj.Free;
    end;
  end;
end;

procedure TgtDict.SetKey(AIndex: Integer; AKey: AnsiString);
begin
  if Assigned(FEntries) and (AIndex > -1) and (AIndex < FEntries.Count) then
    FEntries.Strings[AIndex] := AKey;
end;

procedure TgtDict.SetParentDoc(AParentDoc: TgtObject);
begin
  FParentDoc := AParentDoc;
end;

procedure TgtDict.SetValue(AIndex: Integer; Value: TgtPDBaseObject);
begin
  if Assigned(FEntries) and (AIndex > -1) and (AIndex < FEntries.Count) then
    FEntries.Objects[AIndex] := Value;
end;

{ TgtPDDictionary }

  (**
   * Adds an object into the current Dictionary object
   *)

procedure TgtPDDictionary.Add(Key, AValue: TgtPDBaseObject);
begin
  if Assigned(FDict) then
    FDict.Add(Key, TgtPDBaseObject(AValue));
  IsChanged := True;
end;

procedure TgtPDDictionary.Assign(ASourceObj: TgtPDBaseObject);
var
  LI: Integer;
  LObjType: TgtPDObjTypes;
  LKeyName: AnsiString;
  LObj, LCopyObj: TgtPDBaseObject;
begin
  inherited;
  LCopyObj := nil;
  for LI := 0 to TgtPDDictionary(ASourceObj).GetLength - 1 do
  begin
    LObj := TgtPDDictionary(ASourceObj).GetValueRefObj(LI);

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

    LKeyName := TgtPDDictionary(ASourceObj).GetKey(LI);
    FDict.Add(LKeyName, LCopyObj);
  end;
end;

  (**
   * Adds an object into the current Dictionary object
   *
   * @param Key is the name
   * @param AValue is the Base Object
   *)

procedure TgtPDDictionary.Add(const Key: AnsiString;
  const AValue: TgtPDBaseObject);
begin
  if Assigned(FDict) then
    FDict.Add(Key, TgtPDBaseObject(AValue));
  IsChanged := True;
end;

  (**
   * Gets a copy of the current object
   * @return Copy of current object(Dictionary)
   *)

function TgtPDDictionary.Clone: TgtPDBaseObject;
begin
  Result := TgtPDDictionary.Create(FObjNumber, FGenNumber, FDict.Clone);
end;

  (**
   * Constructor
   * @param AObjNumber is the object number that need to be set for this object
   * @param AGenNumber is the generation number that need to be set for this object
   * @param AParentDoc is parent document of this Dictionary object
   *)

constructor TgtPDDictionary.Create(AObjNumber, AGenNumber: Cardinal;
  AParentDoc: TgtObject);
begin
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;
  FDict := TgtDict.Create(AParentDoc);
  FIsChanged := True;
end;

  (**
   * Constructor
   * @param AObjNumber is the object number that need to be set for this object
   * @param AGenNumber is the generation number that need to be set for this object
   * @param ADict is the Dictionary object
   *)

constructor TgtPDDictionary.Create(AObjNumber, AGenNumber: Cardinal;
  ADict: TgtDict);
begin
  FDict := ADict;
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;
  FIsChanged := True;
end;

  (**
   * Constructor
   * @param AParentDoc is parent document of this Dictionary object
   *)

constructor TgtPDDictionary.Create(AParentDoc: TgtObject);
begin
  FDict := TgtDict.Create(AParentDoc);
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
  FIsChanged := True;
end;

  (**
   * Constructor
   * @param ADict is the Dictionary object
   *)

constructor TgtPDDictionary.Create(ADict: TgtDict);
begin
  FDict := ADict;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
  FIsChanged := True;
end;

destructor TgtPDDictionary.Destroy;
begin
  if FDict.DecRef = 0 then
    FDict.Free;
  inherited;
end;

function TgtPDDictionary.GetKey(Index: Integer): AnsiString;
begin
  Result := FDict.GetKey(Index)
end;

  (**
   * Gets the Length of the Dictionary entries
   * @return Length of the Dictionary entries
   *)

function TgtPDDictionary.GetLength: Integer;
begin
  Result := FDict.Length;
end;

  (**
   * Gets the parent document of the Dictionary object
   * @return The parent document of the Dictionary object
   *)

function TgtPDDictionary.GetParentDoc: TgtObject;
begin
  Result := FDict.FParentDoc;
end;

(*function TgtPDDictionary.GetObject(const ObjectPath: AnsiString): TgtPDBaseObject;
var
  LStrings: TStringList;
  I: Integer;
  LObj, LObj2: TgtPDBaseObject;
  LStr: AnsiString;
  NewPath: AnsiString;
  J: Integer;
begin
  if ObjectPath = '' then
    Result := Self
  else
  begin
    LStrings := TStringList.Create;
    try
      LStrings.Delimiter := PD_PATHSEPARATOR;
      LStrings.DelimitedText := Trim(ObjectPath);

      I := 0;
      while I <= LStrings.Count - 1 do
      begin
        LObj := LookUp(Trim(LStrings.Strings[I]));
        Result := LObj;
        if LObj.IsArray then
        begin
          LStr := Trim(LStrings.Strings[I + 1]);
          LStr := ReplaceStr(LStr, PD_PATHSEPARATOR + PD_ARRAYSTART, '');
          LStr := ReplaceStr(LStr, PD_ARRAYEND + PD_PATHSEPARATOR, '');
          LObj2 := TgtPDArray(LObj).Get(StringToInteger(LStr));
          LObj.Free;
          Result := LObj2;
          I := I + 1;
        end;
        if LObj.IsDict then
        begin
          NewPath := '';
          for J := I + 1 to LStrings.Count - 1 do
          begin
            NewPath := NewPath + Trim(LStrings.Strings[J]);
            if J < LStrings.Count - 1 then
              NewPath := NewPath + PD_PATHSEPARATOR;
          end;
          if NewPath <> '' then
          begin
            LObj2 := TgtPDDictionary(LObj).GetObject(NewPath);
            LObj.Free;
            I := J;
            if LObj2.IsNull then
            begin
              //Logg Error
            end;
            Result := LObj2;
          end;
          Inc(I);
        end;
      end;
    finally
      LStrings.Free;
    end;
  end;
end; *)

  (**
   * Checks if the object is an Dictionary object
   * @return True if the object is Dictionary object, False otherwise
   *)

function TgtPDDictionary.IsDict: Boolean;
begin
  Result := True;
end;

function TgtPDDictionary.GetValue(AIndex: Integer): TgtPDBaseObject;
begin
  Result := FDict.GetValue(AIndex);
end;

function TgtPDDictionary.GetValueRefObj(AIndex: Integer): TgtPDBaseObject;
begin
  Result := FDict.GetValueRefObj(AIndex);
end;

  (**
   * Check whether object is an Dictionary object and ADictType is the its Dict type
   * @param ADictType Is the Dictionary type
   * @return True if the object is Dictionary object and dictionary type is
   * ADictType, False otherwise
   *)

function TgtPDDictionary.IsDict(const ADictType: AnsiString): Boolean;
begin
  if (FDict.Isof(ADictType)) then
    Result := True
  else
    Result := False;
end;

function TgtPDDictionary.LookUp(const Key: AnsiString): TgtPDBaseObject;
begin
  Result := FDict.LookUp(Key);
end;

function TgtPDDictionary.LookUpClone(const Key: AnsiString): TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  LObj := LookUp(Key);
  if Assigned(LObj) then
    Result := LObj.Clone
  else
    Result := TgtPDNull.Create;
end;

function TgtPDDictionary.LookupRefObj(const Key: AnsiString): TgtPDBaseObject;
begin
  Result := FDict.LookupRefObj(Key)
end;

function TgtPDDictionary.LookupRefObjClone(const Key: AnsiString): TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  LObj := LookupRefObj(Key);
  if Assigned(LObj) then
    Result := LObj.Clone
  else
    Result := TgtPDNull.Create;
end;

  (**
   * Removes an object from the current Dictionary object
   *
   * @param Key is the name
   * @param AValue is the Base Object
   *)

procedure TgtPDDictionary.Remove(Key: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := LookupRefObj(Key);
  if Assigned(LObj) then
  begin
    FDict.Remove(Key);
    Self.IsChanged := True;
  end;
end;

procedure TgtPDDictionary.Remove(Key: TgtPDBaseObject);
begin
  IsChanged := True;
end;

  (**
   * This function writes the array object into the stream provided based on
      the writting parameters
   * @param Stream is the where this Dictionary object need to be written into.
   * @param OnlyChanged flag indicates that, write those object of Dictionay with
   *         the value set True for this parameter
   * @param XRef is the Xreferance table for this document
   *
   * @return count bytes written into the stream
   *)

function TgtPDDictionary.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
var
  List: TObjectList;
  I: Integer;
  LObj: TgtPDBaseObject;
  LXRefEntry: TgtPDXRefEntry;
  PrevObjNumber: Cardinal;
  LValue: string;
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
      if Assigned(FDict.ParentDoc) then
      begin
        if not TgtPDBaseDoc(FDict.ParentDoc).IsObjectWritten(
          TgtPDIndirectRef(List.Items[I]).ObjNumber) then
        begin
          LObj := TgtPDBaseDoc(FDict.ParentDoc).GetObject(
            TgtPDIndirectRef(List.Items[I]).ObjNumber);
          if Assigned(LObj) {and not LObj.IsNull} then
          begin
            if LObj.IsString and (TgtPDBaseDoc(FDict.ParentDoc).IsEncrypted or
              (Assigned(TgtPDBaseDoc(FDict.ParentDoc).UserEncryptionSettings) and
              (TgtPDBaseDoc(FDict.ParentDoc).UserEncryptionSettings.Enabled))) then
            begin
              WriteEncryptedString(LObj, Stream, OnlyChanged, XRef);
            end
            else
            begin
              LObj.SaveToStream(Stream, OnlyChanged, XRef);
              if LObj.IsChanged then
                IsChanged := True;
            end;
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

    Result := Result + Stream.Write(PDF_DICTSTART);

    for I := 0 to FDict.Length - 1 do
    begin
      Result := Result + Stream.Write('/' + FDict.GetKey(I) + ' ');
      LObj := GetValueRefObj(I);
      if LObj.IsIndirectRef then
      begin
        if Assigned(FDict.ParentDoc) then
        begin
          if TgtPDBaseDoc(FDict.ParentDoc).IsObjectWritten(
            TgtPDIndirectRef(LObj).ObjNumber) then
            LObj.ObjNumber := GetValue(I).ObjNumber;
        end;
      end;
      if IsChanged then
        LObj.IsChanged := True;

      if LObj.IsString and (TgtPDBaseDoc(FDict.ParentDoc).IsEncrypted or
              (Assigned(TgtPDBaseDoc(FDict.ParentDoc).UserEncryptionSettings) and
              (TgtPDBaseDoc(FDict.ParentDoc).UserEncryptionSettings.Enabled))) then
      begin
        if (FDict.GetKey(I) <> PDF_U) and (FDict.GetKey(I) <> PDF_O) then
        begin
          if ((FDict.GetKey(I) = PDF_AUTHOR) or (FDict.GetKey(I) = PDF_TITLE)) or
            (FDict.GetKey(I) = PDF_KEYWORDS) or (FDict.GetKey(I) = PDF_PRODUCER) or
            (FDict.GetKey(I) = PDF_CREATOR) or (FDict.GetKey(I) = PDF_SUBJECT)then
          begin
            LValue := '';
            //Pass the original string
            //Convert it to HEX
            //Get the HEX to byte value
            LValue := ToUnicodeHex(TgtPDString(LObj).Value);
            //Prepend LValue with 'FEFF'
            LValue := #254#255 + LValue;
            TgtPDString(LObj).Value := LValue;
            WriteEncryptedString(LObj, Stream, OnlyChanged, XRef);
          end
          else
          begin
            WriteEncryptedString(LObj, Stream, OnlyChanged, XRef);
          end;
        end
        else
          Result := Result + LObj.SaveToStream(Stream, OnlyChanged, XRef);
      end
      else
      begin
        if (FDict.GetKey(I) = PDF_ID) then
          Result := Result + TgtPDArray(LObj).WriteIDWithoutEncrypting(Stream, OnlyChanged, XRef)
        else
          Result := Result + LObj.SaveToStream(Stream, OnlyChanged, XRef);
      end;

      Result := Result + Stream.Write(' ');
    end;

    if Result > 0 then
    begin
      if (ObjNumber <> $FFFFFFFF) then
        Result := Result + Stream.Write(PDF_DICTEND + CRLF + PDF_ENDOBJ + CRLF)
      else
        Result := Result + Stream.Write(PDF_DICTEND);
    end;
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

procedure TgtPDDictionary.SetKey(AIndex: Integer; AKey: AnsiString);
begin
  FDict.SetKey(AIndex, AKey);
end;

procedure TgtPDDictionary.SetKeyValue(Key: AnsiString; AValue: TgtPDBaseObject);
begin
  Remove(Key);
  Add(Key, AValue);
end;

procedure TgtPDDictionary.SetParentDoc(AParentDoc: TgtObject);
begin
  FDict.SetParentDoc(AParentDoc);
end;

procedure TgtPDDictionary.SetValue(AIndex: Integer; Value: TgtPDBaseObject);
begin
  FDict.SetValue(AIndex, Value);
end;

function TgtPDDictionary.ToUnicodeHex(AStr: WideString): String;
var
  LStr: String;
  LI: Integer;
  LByte: Byte;
begin
  Result := '';
  for LI :=1 to Length(AStr) do
  begin
    LStr := LStr + IntToHex((Ord(AStr[LI])),4);
  end;
  LI := 1;
  while (LI <= Length(LStr)) do
  begin
    HexToByteValue(LStr[LI] + LStr[LI+1], LByte);
    Result := Result + Char(LByte);
    Inc(LI, 2);
  end;
end;

procedure TgtPDDictionary.WriteEncryptedString(AStringObj: TgtPDBaseObject;
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

    if LStrObj.Value <> '' then
    begin
      LValue := LStrObj.Value;
      //Encrypt the string
      LMemStream := TMemoryStream.Create;
      LgtMemStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
      try
        LgtMemStream.Write(LValue);
        LgtMemStream.Reset;

        LInfoObj := TgtPDBaseDoc(FDict.GetParentDoc).GetDocInfo();
        LObj := TgtPDDictionary(LInfoObj).LookUp(PDF_CREATIONDATE);

        if Assigned(LObj) then
          LCreateDate := TgtPDName(LObj).Value;

        if (LStrObj.ObjNumber <> $FFFFFFFF) then
        begin
          LCryptStream := TgtCryptStream.Create(LgtMemStream, LCreateDate,
          TgtPDBaseDoc(FDict.GetParentDoc).UserEncryptionSettings, cryptRC4, 0,
          LStrObj.ObjNumber, LStrObj.GenNumber);
        end
        else
        begin
          LCryptStream := TgtCryptStream.Create(LgtMemStream, LCreateDate,
          TgtPDBaseDoc(FDict.GetParentDoc).UserEncryptionSettings, cryptRC4, 0,
          ObjNumber, GenNumber);
        end;
        LDataStrm := TMemoryStream.Create;
        LgtDataStrm := TgtMemoryStream.Create(LDataStrm, 0, 0, False);
        try
          LCryptStream.Reset;
          LgtMemStream.Reset;
          LDataStrm.Position := 0;
          LCryptStream.Write(LgtDataStrm, Length(LValue));
          LDataStrm.Position := 0;
          LDataStrm.Read(LValue[1], LDataStrm.Size);
          //The encrypted string is again converted to HEX
          LValue := GetHexOfString(LValue);
          Stream.Write(AnsiChar(LESSTHANSIGN));
          //Write the string to PDF
          Stream.Write(LValue);
          Stream.Write(AnsiChar(GREATERTHANSIGN));
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
    end;

    IsWritten := True;
    if LStrObj.ObjNumber <> $FFFFFFFF then
      Stream.Write(CRLF + PDF_ENDOBJ + CRLF);
  end;//end of IF
end;

procedure TgtPDDictionary.GetIndirectRefs(List: TObjectList);
var
  LI: Integer;
  LObj: TgtPDBaseObject;
begin
  for LI := 0 to FDict.Length - 1 do
  begin
    LObj := TgtPDBaseObject(FDict.Entries.Objects[LI]);
    if LObj.IsIndirectRef then
      List.Add(LObj)
    else if LObj.isArray then
      TgtPDArray(LObj).GetIndirectRefs(List)
    else if LObj.isDict then
      TgtPDDictionary(LObj).GetIndirectRefs(List);
  end;
end;



end.
