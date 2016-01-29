{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\..\Utils\gtCompilerDefines.inc}

unit PDParser;

interface

uses
  Classes, gtObject, PDXRef, Stream, BaseStream, Decrypt, PDLexer, PDBaseObject,
  EncryptionSettings, PDStream;

type
  (**
   * TgtPDParser
   *  This class is responsible for interpreting the higher level Types like
   *  array, dictionary etc. This class where the objects are given the
   *  exact meaning.
   *)
  TgtPDParser = class(TgtObject)
  private
    FXRef: TgtPDXRef; //the xref table for this PDF file
    FLexer: TgtPDLexer; //input stream
    FBufObject1: TgtPDBaseObject; //next token
    FBufObject2: TgtPDBaseObject; //next token
    FInlineImage: Integer; //set when inline image data is encountered
    FAllowStreams: Boolean; // To Check Stream Object inside content streams or object streams
    FEncryptionSettings: TgtEncryptionSettings;

    function MakeSubStream(ADict: TgtPDBaseObject; AFileKey: AnsiString;           
      AEncryptAlg: TgtCryptAlgorithm; AKeyLength: Integer;
      AObjNum: Integer; AGenNum: Integer): TgtPDStream;
    procedure Shift;
    function GetArrayObject(AFileKey: AnsiString; AEncryptAlg: TgtCryptAlgorithm;
      AKeyLength, AObjNum, AGenNum: Integer): TgtPDBaseObject;
    function GetDictObject(AFileKey: AnsiString; AEncryptAlg: TgtCryptAlgorithm;
      AKeyLength, AObjNum, AGenNum: Integer): TgtPDBaseObject;
    function GetNumberORIndirectRefObject: TgtPDBaseObject;
    function GetDecryptedString(AFileKey: AnsiString; AEncryptAlg: TgtCryptAlgorithm;
      AKeyLength, AObjNum, AGenNum: Integer): TgtPDBaseObject;
  public
    constructor Create(AXRef: TgtPDXRef; ALexer: TgtPDLexer;
      AAllowStreams: Boolean = False);
    destructor Destroy; override;

    function GetObject(AFileKey: AnsiString = '';
      AEncryptAlg: TgtCryptAlgorithm = cryptRC4;
      AKeyLength: Integer = 0; AObjNum: Integer = 0;
      AGenNum: Integer = 0): TgtPDBaseObject;
    function GetStream: TgtStream;
    function GetPosition: Integer;
  end;

implementation

uses
  gtMethods, CryptStream, PDArray, PDDictionary, PDName, PDError, PDInteger, PDIndirectRef,
  PDString, PDNull, PDFilterManager, PDBaseDoc, SysUtils
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF};

constructor TgtPDParser.Create(AXRef: TgtPDXRef; ALexer: TgtPDLexer;
  AAllowStreams: Boolean);
begin
  FXRef := AXRef;
  FLexer := ALexer;
  FInlineImage := 0;
  FAllowStreams := AAllowStreams;
  FLexer.GetStream.Reset;
  FBufObject1 := FLexer.GetObject;
  FBufObject2 := FLexer.GetObject;
{$IFDEF DEBUG}
  Logger.LogInfo('Created Parser');
{$ENDIF}
end;

destructor TgtPDParser.Destroy;
begin
  if Assigned(FBufObject1) then
    FreeAndNil(FBufObject1);
  if Assigned(FBufObject2) then
    FreeAndNil(FBufObject2);
  if Assigned(FLexer) then
    FreeAndNil(FLexer);
  inherited;
end;

  (**
   * Gets the Array objects
   * @param AFileKey is a File key to get the Array object
   * @param AEncryptAlg is the encryption algorithem to get the dict object
   * @param AKeyLength is the length of the Key
   * @param AObjNum is the Object number for the object that need to be
   *        retrieved
   * @param AGenNum is the Generation number for the object that need to be
   *        retrieved
   * @return TgtPDBaseObject is the dictioanry object
   *)

function TgtPDParser.GetArrayObject(AFileKey: AnsiString;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum,
  AGenNum: Integer): TgtPDBaseObject;
var
  LObj1, LObj2: TgtPDBaseObject;
begin
  Shift;

  LObj1 := TgtPDArray.Create(FXRef.ParentDoc);
  while not FBufObject1.IsCommand(']') and not FBufObject1.IsEOF do
  begin
    LObj2 := GetObject(AFileKey, AEncryptAlg, AKeyLength, AObjNum, AGenNum);
    TgtPDArray(LObj1).Add(LObj2);
  end;
  if (FBufObject1.IsEOF) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('End of file inside array');
{$ENDIF}
  end;
  Shift;
  Result := LObj1;
end;

function TgtPDParser.GetDecryptedString(AFileKey: AnsiString;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum,
  AGenNum: Integer): TgtPDBaseObject;
var
  LObj1: TgtPDBaseObject;
  LDecryptedStr, LInputStr: AnsiString;
  LCryptStrm: TgtStream;
  LChar: Integer;
  LEncryptSett: TgtEncryptionSettings;
begin
  // Decrypting AnsiString object if it is ecrypted
  if TgtPDBaseDoc(FXRef.ParentDoc).IsEncrypted then
  begin
    if not Assigned(FEncryptionSettings) then
      FEncryptionSettings := TgtPDBaseDoc(FXRef.ParentDoc).EncryptionSettings;

    LInputStr := TgtPDString(FBufObject1).GetString;
    if TgtPDString(FBufObject1).IsHexString then
      LInputStr := HexToByteString(LInputStr);

    //Create a crypt stream for encryption
    LCryptStrm := TgtCryptStream.Create(LInputStr, '', FEncryptionSettings,
      cryptRC4, 0, AObjNum, AGenNum);
    LEncryptSett := TgtEncryptionSettings.Create;
    TgtCryptStream(LCryptStrm).CheckPassword(LEncryptSett,
      TgtPDBaseDoc(FXRef.ParentDoc).GetPassword);

    //Gets the decrypted AnsiString
    TgtCryptStream(LCryptStrm).Reset;
    LChar := TgtCryptStream(LCryptStrm).GetChar;
    while LChar <> -1 do
    begin
      LDecryptedStr := LDecryptedStr + AnsiChar(LChar);
      LChar := TgtCryptStream(LCryptStrm).GetChar;
    end;
    //Free the objects(Crypt Stream and settings object)
    FreeAndNil(LCryptStrm);
    FreeAndNil(LEncryptSett);

    LObj1 := TgtPDString.Create(LDecryptedStr, FBufObject1.ObjNumber,
      FBufObject1.GenNumber, False);
  end
  else
    LObj1 := FBufObject1.Clone;

  Shift;
  Result := LObj1;
end;

  (**
   * Gets the dictionary objects
   * @param AFileKey is a name object to get the dictionary object
   * @param AEncryptAlg is the encryption algorithem to get the dict object
   * @param AKeyLength is the length of the Key
   * @param AObjNum is the Object number for the object that need to be
   *        retrieved
   * @param AGenNum is the Generation number for the object that need to be
   *        retrieved
   * @return TgtPDBaseObject is the dictioanry object
   *)

function TgtPDParser.GetDictObject(AFileKey: AnsiString;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum,
  AGenNum: Integer): TgtPDBaseObject;
var
  LObj1, LObj2: TgtPDBaseObject;
  LKey: AnsiString;
begin
  Shift;
  LObj1 := TgtPDDictionary.Create(FXRef.ParentDoc);

  while not FBufObject1.IsCommand('>>') and not FBufObject1.IsEOF do
  begin
    if not FBufObject1.IsName then
    begin
{$IFDEF DEBUG}
      Logger.LogError('Dictionary key must be a name object');
{$ENDIF}
      Shift;
    end
    else
    begin
      LKey := TgtPDName(FBufObject1).Value;
      Shift;
      if (FBufObject1.IsEOF or FBufObject1.IsError) then
        Break;
      LObj2 := GetObject(AFileKey, AEncryptAlg, AKeyLength, AObjNum, AGenNum);
      TgtPDDictionary(LObj1).Add(LKey, LObj2);
    end;
  end;

  if (FBufObject1.IsEOF) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('End of file inside dictionary %d', [GetPosition]);
{$ENDIF}
  end;

  if FAllowStreams and FBufObject2.IsCommand('stream') then
  begin
    LObj2 := MakeSubStream(LObj1, AFileKey, AEncryptAlg, AKeyLength,
      AObjNum, AGenNum);
    if Assigned(LObj2) then
      LObj1 := LObj2
    else
    begin
      FreeAndNil(LObj1);
      LObj1 := TgtPDError.Create;
    end;
  end
  else
    Shift;
  Result := LObj1;
end;

function TgtPDParser.GetNumberORIndirectRefObject: TgtPDBaseObject;
var
  LNumber: Integer;
  LObj1: TgtPDBaseObject;
begin
  LNumber := TgtPDInteger(FBufObject1).Value;
  Shift;
  if FBufObject1.IsInteger and FBufObject2.IsCommand('R') then
  begin
    LObj1 := TgtPDIndirectRef.Create(LNumber, TgtPDInteger(FBufObject1).Value);
    Shift;
    Shift;
  end
  else
    LObj1 := TgtPDInteger.Create(LNumber);
  Result := LObj1;
end;

  (**
   * Gets the object
   * @param AFileKey is a name object to get the object
   * @param AEncryptAlg is the encryption algorithem to get the object
   * @param AKeyLength is the length of the Key
   * @param AObjNum is the Object number for the object that need to be
   *        retrieved
   * @param AGenNum is the Generation number for the object that need to be
   *        retrieved
   * @return TgtPDBaseObject is the dictioanry object
   *)

function TgtPDParser.GetObject(AFileKey: AnsiString; AEncryptAlg: TgtCryptAlgorithm;
  AKeyLength, AObjNum, AGenNum: Integer): TgtPDBaseObject;
begin
   // For Handling Inline Images
  if (FInlineImage = 2) then
  begin
    FreeAndNil(FBufObject1);
    FreeAndNil(FBufObject2);
    FBufObject1 := FLexer.GetObject;
    FBufObject2 := FLexer.GetObject;
    FInlineImage := 0;
  end;
  if FBufObject1.IsCommand('[') then
    Result := GetArrayObject(AFileKey, AEncryptAlg, AKeyLength, AObjNum, AGenNum)
  else if FBufObject1.IsCommand('<<') then
    Result := GetDictObject(AFileKey, AEncryptAlg, AKeyLength, AObjNum, AGenNum)
  else if FBufObject1.IsInteger then
    Result := GetNumberORIndirectRefObject
  else if FBufObject1.IsString and (AFileKey <> '') then
    Result := GetDecryptedString(AFileKey, AEncryptAlg, AKeyLength, AObjNum, AGenNum)
  else
  begin
    Result := FBufObject1.Clone;
    Shift;
  end;
end;

function TgtPDParser.GetPosition: Integer;
begin
  Result := FLexer.GetPosition;
end;

function TgtPDParser.GetStream: TgtStream;
begin
  Result := FLexer.GetStream;
end;

  (**
   *
   *)

function TgtPDParser.MakeSubStream(ADict: TgtPDBaseObject; AFileKey: AnsiString;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum,
  AGenNum: Integer): TgtPDStream;
var
  LPos: Cardinal;
  LDict: TgtPDDictionary;
  LBaseStrm: TgtStream;
  LStream, LCrptStrm: TgtStream;
  LObject: TgtPDBaseObject;
  LLength: Cardinal;
  LEncryptSett: TgtEncryptionSettings;
begin
  FLexer.SkiptoNextLine;
  LPos := FLexer.GetPosition;
  LDict := TgtPDDictionary(ADict);
  LObject := LDict.LookUpClone('Length');
  if LObject.IsInteger then
  begin
    LLength := TgtPDInteger(LObject).Value;
    FreeAndNil(LObject);
  end
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Bad "Length" attribute in stream');
{$ENDIF}
    FreeAndNil(LObject);
    Result := nil;
    Exit;
  end;

  // in badly damaged PDF files, we can run off the end of the input
  // stream immediately after the "stream" token
  if Flexer.GetStream = nil then
  begin
    Result := nil;
    Exit;
  end;
  LBaseStrm := TgtStream(Flexer.GetStream.GetBaseStream);
  // skip over stream data
  FLexer.SetPosition(LPos + LLength);
  // refill token buffers and check for 'endstream'
  Shift; // kill '>>'
  Shift; // kill ' end stream'
  if FBufObject1.IsCommand('endstream') then
    Shift
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Missing endstream');
{$ENDIF}
    // kludge for broken PDF files: just add 5k to the length, and
    // hope its enough
    LLength := LLength + 5000;
  end;

  LStream := TgtBaseStream(LBaseStrm).MakeSubStream(LPos, LLength, True);

  // If the stream is encrypted, create a CryptStream object and get the filter
  if TgtPDBaseDoc(FXRef.ParentDoc).IsEncrypted then
  begin
    if not Assigned(FEncryptionSettings) then
      FEncryptionSettings := TgtPDBaseDoc(FXRef.ParentDoc).EncryptionSettings;

    // Create Crypt stream
    LCrptStrm := TgtCryptStream.Create(LStream, '', FEncryptionSettings, cryptRC4,
      0, AObjNum, AGenNum);
    LEncryptSett := TgtEncryptionSettings.Create;
    TgtCryptStream(LCrptStrm).CheckPassword(LEncryptSett,
      TgtPDBaseDoc(FXRef.ParentDoc).GetPassword);
    FreeAndNil(LEncryptSett);

    // get filters
    Result := TgtPDFilterManager.GetFilter(LDict, LCrptStrm);
  end
  else
    Result := TgtPDFilterManager.GetFilter(LDict, LStream); // get filters
end;


procedure TgtPDParser.Shift;
begin
  if FInlineImage > 0 then
    if FInlineImage < 2 then
      Inc(FInlineImage)
    else
      // in a damaged content stream, if 'ID' shows up in the middle
      // of a dictionary, we need to reset
      FInlineImage := 0
  else if FBufObject2.IsCommand('ID') then
  begin
    FLexer.SkipChar; // skip AnsiChar after 'ID' command
    FInlineImage := 1;
  end;
  FreeAndNil(FBufObject1);
  FBufObject1 := FBufObject2;
  if FInlineImage > 0 then
    FBufObject2 := TgtPDNull.Create
  else
    FBufObject2 := FLexer.GetObject;
end;

end.
