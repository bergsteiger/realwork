{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\..\Utils\gtCompilerDefines.inc}

unit PDXRef;

interface

uses
  Classes, gtObject, Contnrs, PDBaseObject, Stream, BaseStream, PDXRefEntry,
  EncryptionSettings;

type
  TgtWArray = array[0..2] of Integer;
  TgtObjectStream = class;

  (**
   *  TgtPDXRef
   *    This class is responsible for maintaining and manipulating XReference
   *  table or XReference stream in a PDF document. This class stores all the
   *  information inside the XRef table or stream which helps to get the object
   *  from the File or stream.
   *)
  TgtPDXRef = class(TgtObject)
  private
    FEntries: TObjectList;
    FStartXref: Cardinal;
    FStream: TgtBaseStream;
    FTrailerDict: TgtPDBaseObject;
    FOk: Boolean;

    FObjectStream: TgtObjectStream;
    FChanged: Boolean;

    FParentDoc: TgtObject;

    FStart: Cardinal;

    FEncrypted: Boolean;
//    FFileKey: array[0..15] of AnsiChar;
    FKeyLength: Integer;
    FEncryptAlgorithm: TgtCryptAlgorithm;

    FStartObjectNumber: Cardinal;
    FLastObjectNumber: Cardinal;

    function Read(var APosition: LongWord): Boolean;

    function ReadXRefStreamSection(AXRefStream: TgtPDBaseObject; W: TgtWArray;
      First: Integer; Count: Integer): Boolean;
    function ReadXRefTable(AParser: TgtObject; var APosition: LongWord): Boolean;
    function ReadXRefStream(AXRefStream: TgtPDBaseObject; var APosition:
      LongWord): Boolean;
  public
    constructor Create(AParentDoc: TgtObject; AStream: TgtBaseStream);
    destructor Destroy; override;

    function GetSize: Cardinal;
    function Fetch(ANum: Cardinal): TgtPDBaseObject;

    function GetTrailorDict: TgtPDBaseObject;
    function GetStartXref: Cardinal;

    procedure AddEntry(const AEntry: TgtPDXRefEntry);
    procedure AddDefaultEntries(TillCount: Integer);

    function GenerateTable: Boolean;
    function SaveToStream(Stream: TgtStream): Boolean;
    function IsEntryFree(Index: Integer): Boolean;

    procedure SetEntry(Index: Integer; Value: TgtPDXRefEntry);
    function GetEntry(Index: Integer): TgtPDXRefEntry;
    function GetLastObjectNumber: Cardinal;
    function GetParentDoc: TgtObject;
    function GetStartObjectNumber: Cardinal;
    procedure SetLastObjectNumber(const Value: Cardinal);
    procedure SetStartObjectNumber(const Value: Cardinal);

    property Entries[Index: Integer]: TgtPDXRefEntry read GetEntry
    write SetEntry;
    property LastObjectNumber: Cardinal read GetLastObjectNumber
      write SetLastObjectNumber;
    property StartObjectNumber: Cardinal read GetStartObjectNumber
      write SetStartObjectNumber;
    property ParentDoc: TgtObject read GetParentDoc;
  end;

  TgtObjectStream = class
  private
   { private declarations }
    FObjStrNum: Integer; // Object number of object stream
    FNoObjects: Integer; // Number of objects in the stream
    FPDFObjects: TgtPDBaseObjects; // the objects
    FObjNumbers: array of Integer;
  public
   { public declarations }
    constructor Create(AXRef: TgtPDXRef; AObjStreamNum: Integer);
    destructor Destroy; override;
    function GetObjStrNum: Integer; // the object numbers
    function GetObject(AObjectIndex: Integer; AObjNumber: Integer)
      : TgtPDBaseObject;

    property ObjStreamNumber: Integer read GetObjStrNum;
  end;

implementation

uses
  gtMethods, PDConsts, PDParser, PDInteger, PDDictionary, PDLexer, PDStream,
  PDArray, StreamConsts, EmbededStream, PDNull, gtTypes, gtConstants, SysUtils,
  PDBaseDoc, PDBaseExceptions, PDError, {$IFDEF VCL6ORABOVE}StrUtils{$ELSE} gtStrUtils{$ENDIF}
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF};

{ TgtPDXRef }

  (**
   *  This function creates TillCount Entries with its default values
   *
   *  @param TillCount is the maximum number of Entries that need to be created
   *)

procedure TgtPDXRef.AddDefaultEntries(TillCount: Integer);
var
  I: Integer;
  LXRefEntry: TgtPDXRefEntry;
begin
  for I := FEntries.Count to TillCount - 1 do
  begin
    LXRefEntry := TgtPDXRefEntry.Create;
    FEntries.Add(LXRefEntry);
  end;
end;

  (**
   *  Adds a Xref Entry into the List(FEntries where Xref entries are kept)
   *
   *  @param AEntry is the Entry that need to be added to the List
   *)

procedure TgtPDXRef.AddEntry(const AEntry: TgtPDXRefEntry);
begin
  FEntries.Add(AEntry);
end;

  (**
   *  Constructor
   *
   *  @param AParentDoc is the parent document object for which this xref need
   *         to be created
   *  @param AStream is the Filestream(actual document)
   *)

constructor TgtPDXRef.Create(AParentDoc: TgtObject; AStream: TgtBaseStream);
begin
  FParentDoc := AParentDoc;
  FStream := AStream;
  FEntries := TObjectList.Create(True);
  FStartXref := 0;
  FLastObjectNumber := 0;
  FStartObjectNumber := 0;
  FChanged := False;
  FOk := True;
end;

  (**
   *  Destructor
   *)

destructor TgtPDXRef.Destroy;
begin
  FreeAndNil(FEntries);
  if Assigned(FTrailerDict) then
    FreeAndNil(FTrailerDict);
  if Assigned(FObjectStream) then
    FreeAndNil(FObjectStream);
  inherited;
end;

  (**
   *  Gets an object from ANum index of the List if assigned, nil otherwise
   *
   *  @param ANum is the index from where the object need to be retrieved
   *
   *  @return TgtPDBaseObject is the object found at the Anum index of FEntries
   *
   *  @exception ExInvalidStream is raised if the stream is not assigned
   *)

function TgtPDXRef.Fetch(ANum: Cardinal): TgtPDBaseObject;
var
  LXrefEntry: TgtPDXRefEntry;
  LObject1, LObject2, LObject3: TgtPDBaseObject;
  LParser: TgtPDParser;
  LStream: TgtStream;
  LLexer: TgtPDLexer;
begin
  if (FStream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  //Corrupted PDF files
  if (ANum >= Cardinal(FEntries.Count)) then
  begin
    Result := TgtPDError.Create;
{$IFDEF DEBUG}
    Logger.LogInfo('Exiting TgtXRef.Fetch with no sucess');
{$ENDIF}
    Exit;
  end;
  LXrefEntry := FEntries.Items[ANum] as TgtPDXRefEntry;

  case LXrefEntry.EntryType of
    xeUnCompressed:
      begin
        LStream := FStream.MakeSubStream(FStart + LXrefEntry.Offset, 0, False);
        LLexer := TgtPDLexer.Create(LStream);
        LParser := TgtPDParser.Create(Self, LLexer, True);

        LObject1 := LParser.GetObject();
        LObject2 := LParser.GetObject();
        LObject3 := LParser.GetObject();
        if (not (LObject1.IsInteger)) or
          (TgtPDInteger(LObject1).Value <> Integer(ANum))
          or (not (LObject2.IsInteger)) or
          (TgtPDInteger(LObject2).Value <> Integer(LXrefEntry.GenNum))
          or (not (LObject3.IsCommand('obj'))) then
        begin
          FreeAndNil(LObject1);
          FreeAndNil(LObject2);
          FreeAndNil(LObject3);
          FreeAndNil(LParser);
          LStream := nil;
          Result := TgtPDError.Create;
{$IFDEF DEBUG}
          Logger.LogInfo('Exiting TgtXRef.Fetch with no sucess');
{$ENDIF}
          Exit;
        end;

        FEncrypted := TgtPDBaseDoc(FParentDoc).IsEncrypted;
        if FEncrypted then
        begin
          Result := LParser.GetObject('Crpt', FEncryptAlgorithm, FKeyLength,
            ANum, LXrefEntry.GenNum);
        end
        else
        begin
          Result := LParser.GetObject('', FEncryptAlgorithm, FKeyLength, ANum,
            LXrefEntry.GenNum);
        end;
        FreeAndNil(LObject1);
        FreeAndNil(LObject2);
        FreeAndNil(LObject3);
        FreeAndNil(LParser);
      end;
    xeCompressed:
      begin
//        if LXrefEntry.GenNum <> 0 then
//        begin
//          Result := TgtPDNull.Create;
//{$IFDEF DEBUG}
//          Logger.LogInfo('Exiting TgtXRef.Fetch with no sucess');
//{$ENDIF}
//          Exit;
//        end;
        if ((not Assigned(FObjectStream)) or (FObjectStream.ObjStreamNumber <>
          Integer(LXrefEntry.Offset))) then
        begin
          if Assigned(FObjectStream) then
          begin
            FreeAndNil(FObjectStream);
          end;
          FObjectStream := TgtObjectStream.Create(Self, LXrefEntry.Offset);
        end;
        Result := FObjectStream.GetObject(LXrefEntry.GenNum, ANum);
      end;
  else
    begin
      Result := TgtPDError.Create;
{$IFDEF DEBUG}
      Logger.LogInfo('Exiting TgtXRef.Fetch with no sucess');
{$ENDIF}
      Exit;
    end;
  end;
  if Assigned(Result) and not Result.IsError then
  begin
//    if Result.IsDict then TgtPDDictionary(Result).SetParentDoc(FParentDoc)
//    else if Result.IsArray then TgtPDArray(Result).SetParentDoc(FParentDoc)
//    else if Result.IsStream then TgtPDDictionary(TgtPDStream(Result).GetDict).
//      SetParentDoc(FParentDoc);

    Result.ObjNumber := ANum;
    Result.GenNumber := TgtPDXRefEntry(FEntries.Items[ANum]).GenNum;

    Result.IsChanged := False;
    Result.IsWritten := False;

    if Result.IsStream then
    begin
      TgtPDDictionary(TgtPDStream(Result).GetDict).IsWritten := False;
      TgtPDDictionary(TgtPDStream(Result).GetDict).IsChanged := False;
    end;
  end;

{$IFDEF DEBUG}
  Logger.LogInfo('Exiting TgtXRef.Fetch');
{$ENDIF}
end;

  (**
   *  Creates the Xref table from Xref table or Stream present in PDF document
   *
   *  @return True if the generation of Table is successful
   *)

function TgtPDXRef.GenerateTable: Boolean;
var
  LPos: Cardinal;
begin
  LPos := GetStartXref;
  while Read(LPos) do
  begin

  end;
  Result := FOk;
end;

  (**
   *    Gets an entry in the Xref table which has the information such as Offset,
   *  Generation number and Entry type(compressed, uncompressed, free)
   *
   *  @param Index is the index from where these information need to be retrieved
   *
   *  @return TgtPDXRefEntry is the Object with info such as object Offset,
   *          Generation number and Entry type
   *)

function TgtPDXRef.GetEntry(Index: Integer): TgtPDXRefEntry;
begin
  Result := FEntries.Items[Index] as TgtPDXRefEntry;
end;

function TgtPDXRef.GetLastObjectNumber: Cardinal;
begin
  Result := FLastObjectNumber;
end;

function TgtPDXRef.GetParentDoc: TgtObject;
begin
  Result := FParentDoc;
end;

(**
   *  Gets the maximum number of entries present in the FEntries List
   *
   *  @return count of the FEntries
   *)

function TgtPDXRef.GetSize: Cardinal;
begin
  Result := FEntries.Count;
end;

  (**
   *    This function will gets the offset of the XRef entry preasent in the
   *  document by searching through the last 1024 bytes of the document.
   *
   *  @return Offset of the Xref in the Stream.
   *)

function TgtPDXRef.GetStartObjectNumber: Cardinal;
begin
  Result := FStartObjectNumber;
end;

function TgtPDXRef.GetStartXref: Cardinal;
var
  LBuffer, LBuffer2: Ansistring;
  LPos: Integer;
  LStrPos: PAnsiChar;
  LBytesRead: Cardinal;
begin
  LBytesRead := 0;
  if FStream.GetSize = 0 then
    raise ExInvalidPDFFile.Create(ErrInvalidPDFFile);

  if FStartXRef <> 0 then
    Result := FStartXRef
  else
  begin
    if FStream.GetSize <= 1024 then
      FStream.SetPosition(0, soBeginning)
    else
      FStream.SetPosition(-1 * XRefSearchSize, soEnd);
    SetLength(LBuffer, XRefSearchSize);
    LBytesRead := FStream.GetTStream.Read(LBuffer[1], XRefSearchSize);

    if LBytesRead <> 0 then
    begin
      LStrPos := SearchBuf(PAnsiChar(LBuffer), Length(LBuffer), 0, 0, AnsiString('startxref'),
        [soDown, soWholeword]);
      //If startxref is within 1024 bytes from EOF search the whole PDF Doc.
      if LStrPos = '' then
      begin
        LBytesRead := 0;
        LBuffer := '';
        FStream.SetPosition(0, soBeginning);
        SetLength(LBuffer, FStream.GetSize);
        LBytesRead := FStream.GetTStream.Read(LBuffer[1], FStream.GetSize);
        LStrPos := SearchBuf(PAnsiChar(LBuffer), Length(LBuffer), 0, 0, AnsiString('startxref'),
          [soDown, soWholeword]);
      end;
      LPos := Integer(LStrPos) - Integer(PAnsiChar(LBuffer)) + 1;
      LBuffer2 := Trim(StringTokenizer(LBuffer, LPos + 9));
      Setlength(LBuffer, 0);
      Result := StringToInteger(LBuffer2);
      FStartXref := Result;
      Setlength(LBuffer2, 0);
    end;
    if FStartXref = 0 then
      raise ExStartXrefNotFound.Create(ErrStartXrefNotFound);
  end;
end;

  (**
   *  Gets the Triler Dictionary of the first Xref Table.
   *
   *  @return TgtPDBaseObject is the Trailer Dictionary object of the document
   *)

function TgtPDXRef.GetTrailorDict: TgtPDBaseObject;
begin
  Result := FTrailerDict;
end;

  (**
   *  True if the entry in the Index position is a free entry(Entry with 'f' flag)
   *
   *  @param Index is the position of FEntries, from which the object need to
   *         be checked
   *
   *  @return True if the entry in the index position is a Free entry
   *)

function TgtPDXRef.IsEntryFree(Index: Integer): Boolean;
begin
  if Entries[Index].EntryType = xeFree then
    Result := True
  else
    Result := False;
end;

  (**
   *    This function read and build the XRef table from the Xref table position
   *  given. Calling this function in a loop til false will build the entire
   *  XRef table
   *
   *  @param APosition is the offset of the xref entry from where the it had
   *         to start reading
   *
   *  @return True if the reading is done successfully. flase otherwise
   *)

function TgtPDXRef.Read(var APosition: LongWord): Boolean;
var
  LParser: TgtPDParser;
  LObject: TgtPDBaseObject;
begin
{$IFDEF DEBUG}
  Logger.LogInfo('Starting ReadXRef with Position %d', [APosition]);
{$ENDIF}
//  Result := False;

  // Destructor of TgtLexer will distroy the stream
  // Destructor of TgtParser will distroy the Lexer
  LParser := TgtPDParser.Create(Self, TgtPDLexer.Create(FStream.MakeSubStream
    (FStart + APosition, 0, False)), True);

  LObject := LParser.GetObject();
  if LObject.IsCommand() then
  begin
    FreeAndNil(LObject);
    Result := ReadXRefTable(LParser, APosition);
  end

  else if LObject.IsInteger then
  begin
    FreeAndNil(LObject);

    LObject := LParser.GetObject();
    if not LObject.IsInteger then
    begin
      FreeAndNil(LParser);
      FreeAndNil(LObject);
      Result := False;
      FOk := False;
{$IFDEF DEBUG}
      Logger.LogInfo('ReadXRef End with Result %d', [Ord(Result)]);
{$ENDIF}
      Exit;
    end;
    FreeAndNil(LObject);

    LObject := LParser.GetObject();
    if not LObject.IsCommand('obj') then
    begin
      FreeAndNil(LParser);
      FreeAndNil(LObject);
      Result := False;
      FOk := False;
{$IFDEF DEBUG}
      Logger.LogInfo('ReadXRef End with Result %d', [Ord(Result)]);
{$ENDIF}
      Exit;
    end;
    FreeAndNil(LObject);

    LObject := LParser.GetObject();
    if not LObject.IsStream then
    begin
      FreeAndNil(LParser);
      FreeAndNil(LObject);
      Result := False;
      FOk := False;
{$IFDEF DEBUG}
      Logger.LogInfo('ReadXRef End with Result %d', [Ord(Result)]);
{$ENDIF}
      Exit;
    end;
    Result := ReadXRefStream(LObject, APosition);
    FreeAndNil(LObject);
  end
  else
  begin
    FreeAndNil(LObject);
    Result := False;
  end;
  FreeAndNil(LParser);

  if Assigned(FTrailerDict) then
    TgtPDDictionary(FTrailerDict).SetParentDoc(FParentDoc)
  else
    raise ExImproperCrossRefTableOrStream.Create(ErrImproperCrossRefTableOrStream);

{$IFDEF DEBUG}
  Logger.LogInfo('ReadXRef End with Result %d', [Ord(Result)]);
{$ENDIF}
end;

  (**
   *    Reads the XRef Stream and build the Table from it with the position and
   *  stream object given.
   *
   *  @param AXRefStream is the XrefStrm object which need to be read and processed
   *  @param APosition is the position of the stream object
   *
   *  @return True if reading is successful
   *)

function TgtPDXRef.ReadXRefStream(AXRefStream: TgtPDBaseObject;
  var APosition: LongWord): Boolean;
var
  LDict: TgtPDDictionary;
  LObject, LObj2, LIdx: TgtPDBaseObject;
  LNewSize: Cardinal;
  LI, LFirst, LCount: Integer;
  LW: TgtWArray;
  LFailed: Boolean;
begin
{$IFDEF DEBUG}
  Logger.LogInfo('Starting ReadXRefStream with Position %d', [APosition]);
{$ENDIF}
  Result := False;
  LDict := TgtPDStream(AXRefStream).GetDict as TgtPDDictionary;
  LObject := LDict.LookUpClone(PD_SIZE);

  if not (LObject.IsInteger) then
  begin
    FreeAndNil(LObject);
    FOk := False;
    Result := False;
{$IFDEF DEBUG}
    Logger.LogError('Error in ReadXRefStream');
{$ENDIF}
    Exit;
  end
  else
  begin
    LNewSize := TgtPDInteger(LObject).Value;
    FreeAndNil(LObject);
  end;

  if LNewSize < 0 then
  begin
    Result := False;
    FOk := False;
    Exit;
  end;

  if LNewSize > GetSize then
    AddDefaultEntries(LNewSize);

  LObject := LDict.LookUpClone(PD_W);
  if (not LObject.IsArray) or ((TgtPDArray(LObject).GetLength) < 3) then
  begin
    FreeAndNil(LObject);
    FOk := False;
    Result := False;
{$IFDEF DEBUG}
    Logger.LogError('Error in ReadXRefStream');
{$ENDIF}
    Exit;
  end;

  for LI := 0 to 2 do
  begin
    LObj2 := TgtPDArray(LObject).GetClone(LI);
    LW[LI] := TgtPDInteger(LObj2).Value;
    FreeAndNil(LObj2);
  end;
  FreeAndNil(LObject);

  TgtPDStream(AXRefStream).Reset;

  LIdx := LDict.LookUpClone(PD_INDEX);
  if LIdx.IsArray then
  begin
    LI := 0;
    LFailed := False;
    while (LI + 1) < TgtPDArray(LIdx).GetLength do
    begin
      LObject := TgtPDArray(LIdx).GetClone(LI);
      if not (LObject.IsInteger) then
      begin
        FreeAndNil(LIdx);
        LFailed := True;
        Break;
      end;
      LFirst := TgtPDInteger(LObject).Value;
      FreeAndNil(LObject);

      LObject := TgtPDArray(LIdx).GetClone(LI + 1);
      if not (LObject.IsInteger) then
      begin
        LIdx.Free;
        LFailed := True;
        Break;
      end;
      LCount := TgtPDInteger(LObject).Value;
      FreeAndNil(LObject);

      if ((LFirst < 0) or (LCount < 0) or
        (not (ReadXRefStreamSection(AXRefStream, LW, LFirst, LCount)))) then
      begin
        FreeAndNil(LIdx);
        LFailed := True;
        Break;
      end;
      LI := LI + 2;
    end; // End of While loop

    if LFailed then
    begin
      if Assigned(LObject) then
      begin
        FreeAndNil(LObject);
      end;
      Result := False;
      FOk := False;
{$IFDEF DEBUG}
      Logger.LogError('Error in ReadXRefStream');
{$ENDIF}
      Exit;
    end;
  end
  else if not (ReadXRefStreamSection(AXRefStream, LW, 0, LNewSize)) then
  begin
    FreeAndNil(LIdx);
    Result := False;
    FOk := False;
    Exit;
  end;

  if Assigned(LIdx) then LIdx.Free;

  LObject := LDict.LookUpClone('Prev');

  if LObject.IsInteger then
  begin
    APosition := TgtPDInteger(LObject).Value;
    Result := True;
  end;

  if Assigned(LObject) then FreeAndNil(LObject);

  if not Assigned(FTrailerDict) then
    FTrailerDict := LDict.Clone;
{$IFDEF DEBUG}
  if Result then
    Logger.LogInfo('ReadXRefStream Sucessful')
  else
    Logger.LogError('Error in ReadXRefStream');
{$ENDIF}
end;

  (**
   *  This function reads each cross reference stream section of many sections
   *
   *  @param AXRefStream is the Dictionary which contains all information to
   *         process a cross reference stream section
   *  @param W An array of integers representing the size of the fields in a
   *         single cross-reference entry.
   *  @param First The first object number in the subsection;.
   *  @param Count is the number of entries in the subsection
   *
   *  @return True on successful completion
   *)

function TgtPDXRef.ReadXRefStreamSection(AXRefStream: TgtPDBaseObject;
  W: TgtWArray; First, Count: Integer): Boolean;
var
  LOffSet: Cardinal;
  LI, LJ, LNewSize: Integer;
  LType, LGenNumber: Integer;
  LChar: Byte;
  //LXRefEntry: TgtXRefEntry;
begin
{$IFDEF DEBUG}
  Logger.LogInfo('Starting ReadXRefStreamSection');
{$ENDIF}
  if (First + Count) < 0 then
  begin
    Result := False;
    Exit;
  end;
  if (First + Count) > Integer(GetSize) then
  begin
    if GetSize = 0 then
      LNewSize := 1024
    else
      LNewSize := GetSize * 2;
    while ((First + Count > LNewSize) and (LNewSize > 0)) do
      LNewSize := LNewSize shl 1;

    if (LNewSize < 0) then
    begin
      Result := False;
      Exit;
    end;
    AddDefaultEntries(LNewSize);
  end;

  if FStartObjectNumber > Integer(First) then
    FStartObjectNumber := Integer(First);
  if FLastObjectNumber < Integer(First + Count) then
    FLastObjectNumber := Integer(First + Count - 1);


  for LI := First to (First + Count) - 1 do
  begin
    if W[0] = 0 then
      LType := 1
    else
    begin
      LType := 0;
      for LJ := 0 to (W[0] - 1) do
      begin
        LChar := Byte(TgtPDStream(AXRefStream).GetChar);
        if LChar = EndofFile then
        begin
          Result := False;
          Exit;
        end;
        LType := (LType shl 8) + LChar;
      end; // End [For LJ := 0 to LJ < W[0]]  loop
    end; //End Else

    LOffSet := 0;
    for LJ := 0 to (W[1] - 1) do
    begin
      LChar := Byte(TgtPDStream(AXRefStream).GetChar);
      if (LChar = EndofFile) then
      begin
        Result := False;
        Exit;
      end;
      LOffSet := (LOffSet shl 8) + Integer(LChar);
    end;
    LGenNumber := 0;
    for LJ := 0 to (w[2] - 1) do
    begin
      LChar := Byte(TgtPDStream(AXRefStream).GetChar);
      if (LChar = EndofFile) then
      begin
        Result := False;
        Exit;
      end;
      LGenNumber := (LGenNumber shl 8) + Integer(LChar);
    end;

    if Entries[LI].Offset = $FFFFFFFF then
    begin
      case LType of
        0:
          begin
            Entries[LI].Offset := LOffSet;
            Entries[LI].GenNum := LGenNumber;
            Entries[LI].EntryType := xeFree;
          end;
        1:
          begin

            Entries[LI].Offset := LOffSet;
            Entries[LI].GenNum := LGenNumber;
            Entries[LI].EntryType := xeUnCompressed;
          end;
        2:
          begin
            Entries[LI].Offset := LOffSet;
            Entries[LI].GenNum := LGenNumber;
            Entries[LI].EntryType := xeCompressed;
          end
      else
        begin
          Result := False;
          Exit;
        end;
      end; // End of Case
    end; // End of [if AXRef.FEntries[LI].Offset = $FFFFFFFF] loop
  end; // End of For [LI := First to (First + Count) - 1 ] loop
{$IFDEF DEBUG}
  Logger.LogInfo('Exiting ReadXRefStreamSection');
{$ENDIF}
  Result := True;
end;

  (**
   *  Generates an Xref table from given position of xref object.
   *
   *  @param AParser is the parser object for parsing the stream
   *  @param APosition is the position of where Xref is starting
   *
   *  @return True if the operation was successful
   *)

function TgtPDXRef.ReadXRefTable(AParser: TgtObject; var APosition:
  LongWord): Boolean;
var
  LXRFEntry: TgtPDXRefEntry;
  LFailed: Boolean;
  LFirst: Integer;
  LCount, LNewSize, LI: Integer;
  LObject, LObject2: TgtPDBaseObject;
  LPosition: Cardinal;
begin
{$IFDEF DEBUG}
  Logger.LogInfo('Starting ReadXRefTable with Position %d', [APosition]);
{$ENDIF}
  LObject := nil;
  LFailed := False;
  while True do
  begin
    LObject := TgtPDParser(AParser).GetObject;
    if (LObject.IsCommand(PD_TRAILER)) then
    begin
      FreeAndNil(LObject);
      LObject := nil;
      Break;
    end;

    if (not LObject.IsInteger) then
    begin
      LFailed := True;
      Break;
    end;
    LFirst := TgtPDInteger(LObject).Value;
    FreeAndNil(LObject);

    LObject := TgtPDParser(AParser).GetObject;
    if (not LObject.IsInteger) then
    begin
      LFailed := True;
      Break;
    end;
    LCount := TgtPDInteger(LObject).Value;
    FreeAndNil(LObject);

    if ((LFirst < 0) or (LCount < 0) or (LFirst + LCount < 0)) then
    begin
      LFailed := True;
      Break;
    end;

    if (LFirst + LCount > GetSize) then
    begin
      if GetSize = 0 then
        LNewSize := 1024
      else
        LNewSize := GetSize * 2;
      while ((LFirst + LCount > LNewSize) and (LNewSize > 0)) do
        LNewSize := LNewSize shl 1;

      if (LNewSize < 0) then
      begin
        LFailed := True;
        Break;
      end;
      AddDefaultEntries(LNewSize);
    end;

    if FStartObjectNumber > LFirst then
      FStartObjectNumber := LFirst;
    if FLastObjectNumber < LFirst + LCount then
      FLastObjectNumber := LFirst + LCount - 1;


    for LI := LFirst to LFirst + LCount - 1 do
    begin
      LObject := TgtPDParser(AParser).GetObject;
      LXRFEntry := TgtPDXRefEntry.Create;
      if not LObject.IsInteger then
      begin
        LFailed := True;
        Break;
      end;
      LXRFEntry.Offset := TgtPDInteger(LObject).Value;
      FreeAndNil(LObject);

      LObject := TgtPDParser(AParser).GetObject;
      if (not LObject.IsInteger) then
      begin
        LFailed := True;
        Break;
      end;
      LXRFEntry.GenNum := TgtPDInteger(LObject).Value;
      FreeAndNil(LObject);

      LObject := TgtPDParser(AParser).GetObject;
      if (LObject.IsCommand('n')) then
      begin
        LXRFEntry.EntryType := xeUnCompressed;
      end
      else if (LObject.IsCommand('f')) then
      begin
        LXRFEntry.EntryType := xeFree;
      end
      else
      begin
        LFailed := True;
        FreeAndNil(LXRFEntry);
        Break;
      end;
      FreeAndNil(LObject);

      if (Entries[LI].Offset = $FFFFFFFF) then
        SetEntry(LI, LXRFEntry);
      FreeAndNil(LXRFEntry);
    end;
    if LFailed then
      Break;
  end; // End of [while Loop]

  if LFailed then
  begin
    if Assigned(LObject) then FreeAndNil(LObject);
    FOK := False;
    Result := False;
{$IFDEF DEBUG}
    Logger.LogError('ReadXRefTable Failed');
{$ENDIF}
    Exit;
  end;

  // read the trailer dictionary
  if Assigned(LObject) then
    FreeAndNil(LObject);

  LObject := TgtPDParser(AParser).GetObject;
  if not LObject.IsDict then
  begin
    FreeAndNil(LObject);
    FOK := False;
    Result := False;
{$IFDEF DEBUG}
    Logger.LogError('ReadXRefTable Failed');
{$ENDIF}
    Exit;
  end;

  // get the 'Prev' pointer
  LObject2 := TgtPDDictionary(LObject).LookUpClone(PD_PREV);
  if (Assigned(LObject2) and (LObject2.IsInteger)) then
  begin
    APosition := TgtPDInteger(LObject2).Value;
    Result := True;
  end
  else
  begin
    Result := False;
  end;
  FreeAndNil(LObject2);

  // save the first trailer dictionary
  if (not Assigned(FTrailerDict)) then
  begin
    FTrailerDict := LObject.Clone;
  end;

  // check for an 'XRefStm' key
  LObject2 := TgtPDDictionary(LObject).LookUpClone(PD_XREFSTM);
  if (Assigned(LObject2) and (LObject2.IsInteger)) then
  begin
    LPosition := TgtPDInteger(LObject2).Value;
    Self.Read(LPosition);
    if not FOK then
    begin
      FreeAndNil(LObject2);
      FreeAndNil(LObject);
      Result := False;
{$IFDEF DEBUG}
      Logger.LogError('ReadXRefTable Failed');
{$ENDIF}
      Exit;
    end;
  end;
  FreeAndNil(LObject2);
  FreeAndNil(LObject);
{$IFDEF DEBUG}
  Logger.LogInfo('ReadXRefTable Sucess');
{$ENDIF}
end;

  (**
   * This function writes the Xref object into the stream provided based on
      the writting parameters
   * @param Stream is the where this Array object need to be written into.
   *
   * @return count bytes written into the stream
   *)

function TgtPDXRef.SaveToStream(Stream: TgtStream): Boolean;
var
  LI: Integer;
  LOffset: AnsiString;
  LGenNumber: AnsiString;
  LFlag: AnsiString;
  LXrefEntry: TgtPDXRefEntry;
  LTillCount: Cardinal;
begin
  Result := False;
  if not FChanged then
    Exit;

  FStartXRef := Stream.GetPosition;

  Stream.Write(PDF_XREF + CRLF);

  Entries[0].Offset := 0;
  Entries[0].GenNum := 65535;
  Entries[0].EntryType := xeFree;

  if TgtPDBaseDoc(FParentDoc).SaveOptions.Incremental then
    LTillCount := LastObjectNumber - 1
  else
    LTillCount := LastObjectNumber;

  Stream.Write(IntegerToString(StartObjectNumber) + AnsiChar(SPACE) +
    IntegerToString(LTillCount + 1 - StartObjectNumber) + CRLF);

  for LI := StartObjectNumber to LTillCount do
  begin
    LXrefEntry := GetEntry(LI);
    LOffset := FormatFloat('0000000000', LXrefEntry.Offset);
    LGenNumber := FormatFloat('00000', LXrefEntry.GenNum);
    case GetEntry(LI).EntryType of
      xeFree:
        LFlag := 'f';
      xeUnCompressed, xeCompressed:
        LFlag := 'n';
    end;
    Stream.Write(LOffset);
    Stream.Write(AnsiChar(SPACE));
    Stream.Write(LGenNumber);
    Stream.Write(AnsiChar(SPACE) + LFlag + CRLF);
  end;
end;

  (**
   *  Sets the Xref entry in the given index to the value provided.
   *
   *  @param Index is the index of the element that need to be reset by the function
   *  @param Value is the new set of values for the xref entry
   *
   *)

procedure TgtPDXRef.SetEntry(Index: Integer; Value: TgtPDXRefEntry);
begin
  if Index >= FEntries.Count then
    AddDefaultEntries(FEntries.Count + 1024);



  TgtPDXRefEntry(FEntries.Items[Index]).Offset := Value.Offset;
  TgtPDXRefEntry(FEntries.Items[Index]).GenNum := Value.GenNum;
  TgtPDXRefEntry(FEntries.Items[Index]).EntryType := Value.EntryType;

  FChanged := True;
end;

procedure TgtPDXRef.SetLastObjectNumber(const Value: Cardinal);
begin
  FLastObjectNumber := Value;
end;

procedure TgtPDXRef.SetStartObjectNumber(const Value: Cardinal);
begin
  FStartObjectNumber := Value;
end;

{ TgtObjectStream }

  (**
   *  Constructor
   *
   *  @param AXRef is the Xref object required for this object
   *  @param AObjStreamNum is the offset of that object
   *)

constructor TgtObjectStream.Create(AXRef: TgtPDXRef; AObjStreamNum: Integer);
var
  LStream: TgtStream;
  LObjStream, LObject, LObject1: TgtPDBaseObject;
  LFirst, LI: Integer;
  LOffsets: array of Integer;
  LParser: TgtPDParser;
begin
{$IFDEF DEBUG}
  Logger.LogInfo('Entering TgtObjectStream.Create');
{$ENDIF}
  FObjStrNum := AObjStreamNum;
  FNoObjects := 0;
  LObjStream := AXRef.Fetch(AObjStreamNum);
  if not LObjStream.IsStream then
  begin
    FreeAndNil(LObjStream);
{$IFDEF DEBUG}
    Logger.LogError('Error in TgtObjectStream.Create');
{$ENDIF}
    Exit;
  end;
  LObject := TgtPDDictionary(TgtPDStream(LObjStream).GetDict).LookUpClone(PD_N);
  if (not LObject.IsInteger) and (TgtPDInteger(LObject).Value <= 0) then
  begin
    FreeAndNil(LObject);
    FreeAndNil(LObjStream);
{$IFDEF DEBUG}
    Logger.LogError('Error in TgtObjectStream.Create');
{$ENDIF}
    Exit;
  end;
  FNoObjects := TgtPDInteger(LObject).Value;
  FreeAndNil(LObject);
  LObject := TgtPDDictionary(TgtPDStream(LObjStream).GetDict).LookUpClone(PD_FIRST);
  if (not LObject.IsInteger) and (TgtPDInteger(LObject).Value < 0) then
  begin
    FreeAndNil(LObject);
    FreeAndNil(LObjStream);
{$IFDEF DEBUG}
    Logger.LogError('Error in TgtObjectStream.Create');
{$ENDIF}
    Exit;
  end;
  LFirst := TgtPDInteger(LObject).Value;
  FreeAndNil(LObject);
  SetLength(FPDFObjects, FNoObjects);
  SetLength(FObjNumbers, FNoObjects);
  SetLength(LOffsets, FNoObjects);
  TgtPDStream(LObjStream).Reset;
  LStream := TgtEmbededStream.Create(TgtPDStream(LObjStream).GetStream, LFirst, True);
  LParser := TgtPDParser.Create(AXRef, TgtPDLexer.Create(LStream));
  for LI := 0 to FNoObjects - 1 do
  begin
    LObject := LParser.GetObject;
    LObject1 := LParser.GetObject;
    if (not LObject.IsInteger) or (not LObject1.IsInteger) then
    begin
      FreeAndNil(LObject);
      FreeAndNil(LObject1);
      FreeAndNil(LParser);
      Setlength(LOffsets, 0);
      FreeAndNil(LObjStream);
{$IFDEF DEBUG}
      Logger.LogError('Error in TgtObjectStream.Create');
{$ENDIF}
      Exit;
    end;
    FObjNumbers[LI] := TgtPDInteger(LObject).Value;
    LOffsets[LI] := TgtPDInteger(LObject1).Value;
    FreeAndNil(LObject);
    FreeAndNil(LObject1);
    if ((FObjNumbers[LI] < 0) or (LOffsets[LI] < 0) or
      ((LI > 0) and (LOffsets[LI] < LOffsets[LI - 1]))) then
    begin
      FreeAndNil(LParser);
      Setlength(LOffsets, 0);
      FreeAndNil(LObjStream);
{$IFDEF DEBUG}
      Logger.LogError('Error in TgtObjectStream.Create');
{$ENDIF}
      Exit;
    end;
  end;

  while (LStream.GetChar <> EndofFile) do
  begin
    //Do Nothing
  end;
  FreeAndNil(LParser);

  // skip to the first object - this shouldn't be necessary because
  // the First key is supposed to be equal to offsets[0], but just in
  // case...
  for LI := LFirst to LOffsets[0] - 1 do
  begin
    TgtPDStream(LObjStream).GetChar;
  end;
  // parse the objects
  for LI := 0 to FNoObjects - 1 do
  begin
    if LI = FNoObjects - 1 then
      LStream := TgtEmbededStream.Create(TgtPDStream(LObjStream).GetStream, 0, False)
    else
      LStream := TgtEmbededStream.Create(TgtPDStream(LObjStream).GetStream,
        LOffsets[LI + 1] - LOffsets[LI], True);
    LParser := TgtPDParser.Create(AXRef, TgtPDLexer.Create(LStream), False);
    FPDFObjects[LI] := LParser.GetObject;
    while (LStream.GetChar <> EndofFile) do
    begin
      //Do Nothing
    end;
    FreeAndNil(LParser);
  end;
  FreeAndNil(LObjStream);
  Setlength(LOffsets, 0);
end;

  (**
   *  Destructor
   *)

destructor TgtObjectStream.Destroy;
var
  LI: Integer;
begin
  if Length(FPDFObjects) > 0 then
  begin
    for LI := 0 to FNoObjects - 1 do
    begin
      FPDFObjects[LI].Free;
    end;
    Setlength(FPDFObjects, 0);
  end;
  Setlength(FObjNumbers, 0);
  inherited;
end;

  (**
   *  Gets an objects from the list of Objects(FPDFObjects)
   *
   *  @param TgtPDBaseObject is an object stream in the AObjectIndex of FPDFObjects
   *)

function TgtObjectStream.GetObject(AObjectIndex,
  AObjNumber: Integer): TgtPDBaseObject;
begin
  if ((AObjectIndex < 0) or (AObjectIndex >= FNoObjects) or
    (AObjNumber <> FObjNumbers[AObjectIndex])) then
  begin
    Result := TgtPDError.Create;
    Exit;
  end;
  Result := FPDFObjects[AObjectIndex].Clone;
end;

function TgtObjectStream.GetObjStrNum: Integer;
begin
  Result := FObjStrNum;
end;

end.
