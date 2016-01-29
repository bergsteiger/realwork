{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\..\Utils\gtCompilerDefines.inc}

unit PDLexer;

interface

uses
  Classes, gtObject, Stream, PDBaseObject;

const
  TokenSize = 128; // size of token buffer

type

  (**
   *  TgtPDLexer
   *    This class is responsible for interpreting the lower level Types like
   *  Integer, AnsiString, Command etc. This class only provides some information
   *  that is meaningful to PDPareser Class where the objects are given the
   *  exact meaning.
   *)

  TgtPDLexer = class(TgtObject)
  private
    FStream: TgtStream; //Stream variable
    FTokenBuf: array[1..TokenSize] of AnsiChar; //Temperory token buffer
    FOwned: Boolean;

    function GetChar: Integer; //Returns the next character from stream
    function LookChar: Integer; //Peeks at the next character of stream
    function AppendString(const ACharArray: array of AnsiChar;
      ALength: Integer): AnsiString;
    function CheckSpecialChar(AChar: Integer): Boolean;
    function TokenizeNumbers(AChar: Integer): TgtPDBaseObject;
    function TokenizeStrings: TgtPDBaseObject;
    function TokenizeNames: TgtPDBaseObject;
    function TokenizeCommands(AChar: Integer): TgtPDBaseObject;
    function TokenizeHexStringDicts: TgtPDBaseObject;
    function ProcessRealNumber(ANumber: Integer; ANegtive: Boolean): Double;
  public
    constructor Create(AStream: TgtStream; Owned: Boolean = True);
    destructor Destroy; override;

    function GetObject: TgtPDBaseObject;
    procedure SkiptoNextLine;
    procedure SkipChar;
    function GetStream: TgtStream;
    function GetPosition: Cardinal;
    procedure SetPosition(APosition: Cardinal);
  end;

implementation

uses
  PDReal, PDString, PDInteger, PDEOF, PDName, PDCommand, PDError, PDBoolean,
  PDNull, gtMethods, gtConstants, StreamConsts, SysUtils, gtTypes
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF};

{ TgtLexer }

  (**
   *  Copies the content of a buffer to AnsiString
   *
   *  @retur AnsiString which is copies from the buffer
   *)

function TgtPDLexer.AppendString(const ACharArray: array of AnsiChar;
  ALength: Integer): AnsiString;
var
  LI: Integer;
begin
  Result := '';
  for LI := 0 to ALength - 1 do
    Result := Result + ACharArray[LI];
  for LI := 1 to ALength do
    FTokenBuf[LI] := #0;
end;

  (**
   *    This function checks if a charecter has special meaning in PDF. Returns
   *  True if it has, false otherwise
   *
   *  @param AChar is the charecter that need to be checked if special AnsiChar
   *
   *  @return True if it makes special meaning to PDF
   *)

function TgtPDLexer.CheckSpecialChar(AChar: Integer): Boolean;
begin
  Result := True;
  if ((SpecialChars[AChar] = 1) or (SpecialChars[AChar] = 2)) then
    Result := False;
end;

  (**
   *  Constructor
   *
   *  @param AStream is a Stream with which Lexer need to be created.
   *)

constructor TgtPDLexer.Create(AStream: TgtStream; Owned: Boolean = True);
begin
  FStream := AStream;
  FOwned := Owned;
end;

  (**
   *  Destructor
   *)

destructor TgtPDLexer.Destroy;
begin
  if FOwned then
  begin
    if Assigned(FStream) then
      FreeAndNil(FStream);
  end;
  inherited;
end;

  (**
   *  Gets the next character from stream
   *
   *  @return the next charecter(integer value)
   *)

function TgtPDLexer.GetChar: Integer;
begin
  Result := FStream.GetChar;
end;

  (**
   *    Gets an Object from the stream in the form of lower level Types like
   *  Number, Command, EOF, Error etc.
   *
   *  @return TgtPDBaseObject is an object of any of the lower Type objects
   *)

function TgtPDLexer.GetObject: TgtPDBaseObject;
var
  LChar: Integer;
  LComment: Boolean;
begin
  LChar := 0;
  // skip whitespace and comments
  LComment := False;
  while True do
  begin
    LChar := GetChar;
    if (LChar = EndofFile) then
    begin
      Result := TgtPDEOF.Create;
      Exit;
    end;
    //Skipping Comments and Looking for a valid Token
    if (LComment) then
    begin
      if ((LChar = 13) or (LChar = 10)) then
        LComment := False;
    end
    else if (LChar = 37) then
    begin
      LComment := True;
    end
    else if (SpecialChars[LChar] <> 1) then
    begin
      Break;
    end;
  end;

  //Start Tokenizing
  case LChar of
    //If LChar is between 0..9 Checking with ASCII value.
    // Number Tokenizing
    45, 46, 48..57:
      begin
        Result := TokenizeNumbers(LChar);
      end;

    //AnsiString
    40: // '(' Braces
      begin
        Result := TokenizeStrings;
      end; //( Braces End 40:

  //Name parsing
    47: // '/'
      begin
        Result := TokenizeNames;
      end; // End of Case 40 [Name Parsing]

    // array punctuation
    91, 93: // '[' and ']'
      begin
        FTokenBuf[1] := AnsiChar(LChar);
        Result := TgtPDCommand.Create(AppendString(FTokenBuf, 1));
      end; //End Array Punctuation

  // hex AnsiString or dict punctuation
    60: // '<'
      begin
        Result := TokenizeHexStringDicts;
      end; //End of Case <

  // dict punctuation
    62: // '>':
      begin
        LChar := LookChar();
        if (LChar = 62) then
        begin
          GetChar;
          FTokenBuf[1] := AnsiChar(62);
          FTokenBuf[2] := AnsiChar(62);
          Result := TgtPDCommand.Create(AppendString(FTokenBuf, 2));
        end
        else
        begin
{$IFDEF DEBUG}
          Logger.LogError('Illegal character ">"');
{$ENDIF}
          Result := TgtPDError.Create;
        end;
      end; // End Case 62
  // error
    41, 123, 125: // ')' '{' '}':
      begin
{$IFDEF DEBUG}
        Logger.LogError('Illegal character %d', [LChar]);
{$ENDIF}
        Result := TgtPDError.Create;
      end;
  // Command
  else
    begin
      Result := TokenizeCommands(LChar);
    //break;
    end
  end; // End Of Case Begin Tokenizing
end;

  (**
   *  Gets the current position in the Stream
   *
   *  @return A number specifying the position in the stream.
   *)

function TgtPDLexer.GetPosition: Cardinal;
begin
  Result := FStream.GetPosition;
end;

  (**
   *  Gets the current Stream
   *
   *  @return TgtStream is the current stream.
   *)

function TgtPDLexer.GetStream: TgtStream;
begin
  Result := FStream;
end;

  (**
   *  Peeks a charecter from the stream
   *
   *  @return Integer is the charecter read from next position in its integer value
   *)

function TgtPDLexer.LookChar: Integer;
begin
  Result := FStream.LookChar;
end;

  (**
   *  This function process a real number from stream and conveys a meaning to it
   *
   *  @param ANumber is the number that need to be processed
   *  @param ANegtive is the flag that indicates that this number is a negative
   *         number
   *
   *  @result The number after processing
   *)

function TgtPDLexer.ProcessRealNumber(ANumber: Integer; ANegtive: Boolean): Double;
var
  LScale, LFNumber: Double;
  LChar: Integer;
begin
  LFNumber := ANumber;
  LScale := 0.1;
  while (True) do
  begin
    LChar := LookChar;
    if (LChar = 45) then //if LChar is mInus
    begin
{$IFDEF DEBUG}
      // ignore minus signs in the middle of numbers to match
      // Adobe's behavior
      Logger.LogInfo('Badly formatted number');
{$ENDIF}
      GetChar; //Flush the AnsiChar
      Continue;
    end;
    if (Lchar in [48..57]) then //If LChar Between 0..9 [Checking with Ascii Values]
    begin
      GetChar; //Flushing the Character
      //Appendnig the float Number
      LFNumber := LFNumber + LScale * (Lchar - 48);
      LScale := LScale * 0.1;
    end
    else
      Break;
  end;
  if (ANegtive) then //if the number is Negative [For Double]
    LFNumber := -LFNumber;
  Result := LFNumber;
end;

  (**
   *  Sets the position given by the user
   *
   *  @param APosition to be set for the stream
   *)

procedure TgtPDLexer.SetPosition(APosition: Cardinal);
begin
  FStream.SetPosition(Aposition, soBeginning);
end;

  (**
   *  Skips one charecter
   *)

procedure TgtPDLexer.SkipChar;
begin
  GetChar;
end;

  (**
   *  Skips to the next line(#13 or #10)
   *)

procedure TgtPDLexer.SkiptoNextLine;
var
  LChar: Integer;
begin
  LChar := GetChar;
  while (LChar <> EndOfFile) do
  begin
    if (LChar = 10) then
      Exit;
    if (LChar = 13) then
    begin
    // Checking for carriage retutrn and line feed
      LChar := LookChar;
      if (LChar = 10) then
      begin
        GetChar;
        Exit;
      end
      else
        Exit;
    end;
    LChar := GetChar;
  end;
end;

  (**
   *  This function identifies and creates the objects like boolean, null command
   *
   *  @param AChar is the charecter that need to be identified as boolean,
   *         null, command objects.
   *)

function TgtPDLexer.TokenizeCommands(AChar: Integer): TgtPDBaseObject;
var
  LChar: Integer;
  LString: AnsiString;
  LTbuffSize: Integer;
begin

  LTbuffSize := 1;
  FTokenBuf[LTbuffSize] := AnsiChar(AChar);
  LChar := LookChar;
  while ((LChar <> EndofFile) and (CheckSpecialChar(LChar))) do
  begin
    LChar := GetChar;
    Inc(LTbuffSize);
    if (LTbuffSize = TokenSize) then
    begin
{$IFDEF DEBUG}
      Logger.LogError('Command token too long');
{$ENDIF}
      break;
    end;
    FTokenBuf[LTbuffSize] := AnsiChar(LChar);
    LChar := LookChar;
  end;

  LString := AppendString(FTokenBuf, LTbuffSize);
  if (LString[1] = 't') and (LString = 'true') then
  begin
    Result := TgtPDBoolean.Create(True);
  end
  else if (LString[1] = 'f') and (LString = 'false') then
  begin
    Result := TgtPDBoolean.Create(False);
  end
  else if (LString[1] = 'n') and (LString = 'null') then
  begin
    Result := TgtPDNull.Create;
  end else
  begin
    Result := TgtPDCommand.Create(LString);
  end;
end;

  (**
   *  Gets a Hex AnsiString object or command object
   *
   *  @return TgtPDBaseObject is AnsiString object or a Command object
   *)

function TgtPDLexer.TokenizeHexStringDicts: TgtPDBaseObject;
var
  LChar: Integer;
  LString: AnsiString;
  LTbuffSize: Integer;
begin
  LChar := lookChar;
  LTbuffSize := 0;
  // dict punctuation
  if (LChar = 60) then
  begin
    GetChar;
    FTokenBuf[1] := '<';
    FTokenBuf[2] := '<';
    LString := AppendString(FTokenBuf, 2);
    Result := TgtPDCommand.Create(LString);
  end
  // hex AnsiString
  else
  begin
//    LM := 0;
//    LC2 := 0;
    LString := '';
    while (True) do
    begin
      LChar := GetChar;
      if (LChar = 62) then
      begin
        break;
      end
      else if (LChar = EndofFile) then
      begin
{$IFDEF DEBUG}
        Logger.LogError('Unterminated hex AnsiString');
{$ENDIF}
        break;
      end
      else if (SpecialChars[LChar] <> 1) then
      begin
        if (LTbuffSize = TokenSize) then
        begin
          LString := LString + AppendString(FTokenBuf, LTbuffSize);
          LTbuffSize := 0;
        end;
        Inc(LTbuffSize);
        FTokenBuf[LTbuffSize] := AnsiChar(LChar);


      end;
//        LC2 := LC2 shl 4;
//        if ((LChar >= Ord('0')) and (LChar <= Ord('9'))) then
//          LC2 := LC2 + LChar - Ord('0')
//        else if (LChar >= Ord('A')) and (LChar <= Ord('F')) then
//          LC2 := LC2 + LChar - Ord('A') + 10
//        else if (LChar >= Ord('a')) and (LChar <= Ord('f')) then
//          LC2 := LC2 + LChar - Ord('a') + 10
//        else
//        begin
//   //error(getPos(), "Illegal character <%02x> in hex AnsiString", c);
//        end;
//        Inc(LM);
//        if (LM = 2) then
//        begin
//          if (LTbuffSize = TokenSize) then
//          begin
//            LString := LString + AppendString(FTokenBuf, LTbuffSize);
//            LTbuffSize := 0;
//          end;
//          Inc(LTbuffSize);
//          FTokenBuf[LTbuffSize] := AnsiChar(LC2);
//          LC2 := 0;
//          LM := 0;
//        end;
//      end; //End if (specialChars[c] != 1) Loop
    end; //End While(1) loop

    LString := LString + AppendString(FTokenBuf, LTbuffSize);
//    if (LM = 1) then
//      LString := LString + Chr(LC2 shl 4);
    Result := TgtPDString.Create(LString, True);
  end; // End Hex AnsiString Loop
end;

  (**
   *  This function is responsible for identifying and creating Name objects
   *
   *  @return TgtPDBaseObject is the Name object if found else nil
   *)

function TgtPDLexer.TokenizeNames: TgtPDBaseObject;
var
  LChar, LTbuffSize, LC2: Integer;
  LString: AnsiString;
begin
  LTbuffSize := 0;
  LChar := LookChar;
  while ((LChar <> EndofFile) and (CheckSpecialChar(LChar))) do
  begin
    GetChar;
//    if (LChar = 35) then //'#20 .. series' Handling Hexadecial Strings
//    begin
//      LC2 := LookChar;
//      if ((LC2 >= 48) and (LC2 <= 57)) then
//      begin
//        LChar := LC2 - 48;
//      end
//      else if ((LC2 >= 65) and (LC2 <= 70)) then // Between 'A' and 'F'
//      begin
//        LChar := LC2 - 65 + 10;
//      end
//      else if ((LC2 >= 97) and (LC2 <= 102)) then //Between 'a' and 'f'
//      begin
//        LChar := LC2 - 97 + 10;
//      end
//      else
//      begin
//        Inc(LTbuffSize);
//        if (LTbuffSize = TokenSize) then
//        begin
//{$IFDEF DEBUG}
//          Logger.LogError('Name token too long');
//{$ENDIF}
//          break;
//        end;
//        FTokenBuf[LTbuffSize] := AnsiChar(LChar);
//      end;
//
//      GetChar;
//      LChar := LChar shl 4;
//      LC2 := GetChar;
//      if ((LC2 >= 48) and (LC2 <= 57)) then //Handling Hex Strings Second number
//      begin
//        LChar := LChar + LC2 - 48;
//      end
//      else if ((LC2 >= 65) and (LC2 <= 70)) then // Between 'A' and 'F'
//      begin
//        LChar := LChar + LC2 - 65 + 10;
//      end
//      else if ((LC2 >= 97) and (LC2 <= 102)) then //Between 'a' and 'f'
//      begin
//        LChar := LChar + LC2 - 95 + 10;
//      end
//      else
//{$IFDEF DEBUG}
//        Logger.LogError('Illegal digit in hex AnsiChar in name');
//{$ENDIF}
//    end; //End of Hex AnsiString Handling

    Inc(LTbuffSize);
    if (LTbuffSize = TokenSize) then
    begin
{$IFDEF DEBUG}
      Logger.LogError('Name token too long');
{$ENDIF}
      break;
    end;
//    if (LChar = 32) then
//      FTokenBuf[LTbuffSize] := Chr($20)
//    else if (LChar = 40) then
//      FTokenBuf[LTbuffSize] := Chr($28)
//    else if (LChar = 41) then
//      FTokenBuf[LTbuffSize] := Chr($29)
//    else if (LChar = 47) then
//      FTokenBuf[LTbuffSize] := Chr($2f)
//    else
      FTokenBuf[LTbuffSize] := AnsiChar(LChar);
    LChar := LookChar;
  end; //End of While
  LString := AppendString(FTokenBuf, LTbuffSize);
  Result := TgtPDName.Create(LString);
end;

  (**
   *    This class is responsible for identifying and creating all types of
   *  Number objects
   *
   *  @param AChar is the number that need to be processed.
   *
   *  @return TgtPDBaseObject is the Number object(Real or Integer)
   *)

function TgtPDLexer.TokenizeNumbers(AChar: Integer): TgtPDBaseObject;
var
  LChar: Integer;
  LINumber: Int64; //For Integer numbers
  LNeg: Boolean;
  LFNumber: Extended;
begin
  LChar := AChar;
  LNeg := False; //For Neative Number Handling
  LINumber := 0;
  if (LChar = 45) then //if LChar is '-' number is Negative
  begin
    LNeg := True;
  end
  else if (LChar = 46) then //if LChar is '.' then Number is Float
  begin
  // Call Real NUmber Processing Function
    LFNumber := ProcessRealNumber(LINumber, LNeg);
    Result := TgtPDReal.Create(LFNumber);
    Exit;
  end
  else
    LINumber := LChar - 48;
  while (True) do
  begin
    LChar := LookChar;
    if (LChar in [48..57]) then
    begin
      GetChar; //Flushing the AnsiChar
      //Appending the Lchar to get complete number
      LINumber := LINumber * 10 + (LChar - 48);
//      LChar := LookChar;
    end
    else if (LChar = 46) then //if LChar is '.' then Number is Float
    begin
      GetChar; //Flushing the AnsiChar
      // Call Real NUmber Processing Function
      LFNumber := ProcessRealNumber(LINumber, LNeg);
      Result := TgtPDReal.Create(LFNumber);
      Exit;
    end
    else
      Break;
  end;
  if (LNeg) then //if the number is Negative [For Integer]
    LINumber := -LINumber;
  if LINumber = $FFFFFFFF then
    LINumber := 0;
  Result := TgtPDInteger.Create(LINumber);
end;

  (**
   *  This function is responsible for creating AnsiString objects
   *
   *  @return TgtPDBaseObject is the AnsiString object that is created.
   *)

function TgtPDLexer.TokenizeStrings: TgtPDBaseObject;
var
  LNumParen, LChar: Integer;
  LString: AnsiString;
  LDone: Boolean;
  LC2: Integer;
  LTbuffSize: Integer;
begin

  LTbuffSize := 0; //Temporary Variable to Check The Buffer Storage
  LNumParen := 1; //To Tackle '(' in a Text
  LDone := False; //Boolean Value for Valid AnsiString Token
  LString := ''; // If TokenBuffer is Full Dump contents to This Variable

  repeat
    LC2 := EndofFile;
    LChar := GetChar;
    case LChar of //Parsing AnsiString
      EndofFile:
        begin
{$IFDEF DEBUG}
          Logger.LogError('Unterminated AnsiString');
{$ENDIF}
          LDone := True;
        end;
      40: //If Found '(' with in a AnsiString
        begin
          Inc(LNumParen);
          LC2 := LChar;
        end;
      41: // If found ')' decrement LNumParen
        begin
          Dec(LNumParen);
          if (LNumParen = 0) then
            LDone := True //if Number of Paranth =0 then Token Found
          else
            LC2 := LChar;
        end;
      92: //Case for Handling Escape Sequence in PDF's Strings
        begin
          LChar := GetChar;
          case LChar of
            110:
              LC2 := 10;
            114:
              LC2 := 13;
            116:
              LC2 := 9; //'\t'
            98:
              LC2 := 8;
            102:
              LC2 := 12;
            40, 41, 92: // '(' ')' '/'
              LC2 := LChar;
            48..55: //if the Character is between 0 - 7 [Octal Rep]
              begin //Special Case [Need to Confirm]
                LC2 := LChar - 48;
                LChar := LookChar;
                if ((LChar >= 48) and (LChar <= 55)) then
                begin
                  GetChar;
                  LC2 := (LC2 shl 3) + (LChar - 48);
                  LChar := LookChar;
                  if (LChar >= 48) and (LChar <= 55) then
                  begin
                    GetChar;
                    LC2 := (LC2 shl 3) + (LChar - 48);
                  end;
                end;
              end; // end Case for [Octal Rep]
            13: //CR: // '\r'in AnsiString
              begin
                LChar := LookChar;
                if (LChar = 10) then
                  GetChar;
              end;
            10: //LF: //case '\n':
              break;
            EndofFile: // case EOF:
              begin
                //error(getPos(), "Unterminated AnsiString");
                LDone := True;
              end;
          else // For Escape Seq handling Case
            LC2 := LChar;
          end; //End Handiling of Escape Seq
        end;
    else
      LC2 := LChar;
    end; // Parsing AnsiString
    if (LC2 <> EndofFile) then
    begin
      if (LTbuffSize = TokenSize) then
      begin
        LString := LString + AppendString(FTokenBuf, LTbuffSize);
        LTbuffSize := 0;
      end;
      //if not (LC2 in[254, 255]) then //to escape some chars
      begin
        Inc(LTbuffSize);
        FTokenBuf[LTbuffSize] := AnsiChar(LC2);
      end;
    end;
  until (LDone = True); //Repeat End
  LString := LString + AppendString(FTokenBuf, LTbuffSize);
  Result := TgtPDString.Create(LString, False);
end;

end.
