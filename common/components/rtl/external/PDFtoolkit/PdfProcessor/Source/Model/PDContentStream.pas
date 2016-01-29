{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDContentStream;

interface

uses              
  Classes, Windows, PDElement, PDBaseObject, gtObject, PDExportDevice, PDState,
  PDRect, PDMatrix, PDParser, PDResource, PDColorSpace, PDDeviceGrayColorSpace,
  PDDeviceRGBColorSpace, PDDeviceNColorSpace, PDXObject, PDImage, Graphics,
  {$IFDEF VCL6ORABOVE}Types, {$ENDIF} PDTypes, gtFont, PD8bitFont, PDFont;

const
  MAXARGS = 32;
  NUMOPS = 72;

type

  TgtArgCheck = (acBoolean, acInteger, acNumber,
    acString, acName, acArray,
    acProps, acSCN, acNone
    );
  TgtClip = (clipNone, clipNormal, clipEO);

  TgtArgumentList = array[0..MAXARGS] of TgtPDBaseObject;

  TgtOperationFunc = procedure(Args: TgtArgumentList; NumArgs: Integer) of object;

  TArray = array of WideString;

  TgtPenJoinStyle = (pjsNone, pjsBevel, pjsMiter, pjsRound);

  TgtPenCapStyle = (pcsNone, pcsRound, pcsSquare, pcsFlat);
  
  TgtOperator = record
    Op: AnsiString;
    NumArgs: Integer;
    ArgChk: array[0..MAXARGS] of TgtArgCheck;
    Operation: TgtOperationFunc;
  end;

  TgtPDContentStream = class(TgtPDElement)
  private
    FExportDev: TgtPDExportDevice;
    FState: TgtPDState;
    FhDPI: Double;
    FvDPI: Double;
    FRotate: Integer;
    FBox: TgtPDRect;
    FCropBox: TgtPDRect;
    FPageNum: Integer;
    FBaseMatrix: TgtPDMatrix;
    FParser: TgtPDParser;
    FUpdateLevel: Cardinal;
    FPageResource: TgtPDResource;
    FClip: TgtClip;
    FIgnoreUndef: Integer;
    FEvenOddFillMode: Boolean;
    FPenJoinStyle: TgtPenJoinStyle;
    FPenCapStyle: TgtPenCapStyle;
    FPenStyle: TPenStyle;
    FOpTable: array[0..NUMOPS] of TgtOperator;
    FStateStack: TList;
    Fx, Fy: Double;
    FWritingMode: TgtWritingMode;
    FAngle: Integer;
    FFont: TgtFont;
    FSameFontText: WideString;
    FTempGlyphInfoList: TList;
    FPrevGStateTag: AnsiString;

    function StringToEscapeWideString(AString: WideString;
      out ALineNos: Integer; out ALineStrings: TArray): WideString;

    procedure InitOpTable;
    procedure StartContentParsing;
    procedure ExecuteOp(Command: TgtPDBaseObject; Args: TgtArgumentList; NumArgs: Integer);
    function FindOperator(const Name: AnsiString; var Op: TgtOperator): Boolean;
    function CheckArg(Arg: TgtPDBaseObject; CheckType: TgtArgCheck): Boolean;
//    function GetPosition: Integer;
    procedure InitColorObject(var AColor: TgtColor);

  // graphics state operators
    procedure OpSave(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpRestore(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpConcat(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetDash(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetFlat(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetLineJoin(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetLineCap(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetMiterLimit(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetLineWidth(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetExtGState(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetRenderingIntent(Args: TgtArgumentList; NumArgs: Integer);

  // color operators
    procedure OpSetFillGray(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetStrokeGray(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetFillCMYKColor(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetStrokeCMYKColor(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetFillRGBColor(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetStrokeRGBColor(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetFillColorSpace(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetStrokeColorSpace(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetFillColor(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetStrokeColor(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetFillColorN(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetStrokeColorN(Args: TgtArgumentList; NumArgs: Integer);

  // path segment operators
    procedure OpMoveTo(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpLineTo(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpCurveTo(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpCurveTo1(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpCurveTo2(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpRectangle(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpClosePath(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpShFill(Args: TgtArgumentList; NumArgs: Integer);

  // path painting operators
    procedure OpEndPath(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpStroke(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpCloseStroke(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpFill(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpEOFill(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpFillStroke(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpCloseFillStroke(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpEOFillStroke(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpCloseEOFillStroke(Args: TgtArgumentList; NumArgs: Integer);
    procedure DoPatternFill(EoFill: Boolean);
    procedure DoPatternStroke;
    procedure DoEndPath;
//    function DoForm: TgtPDBaseObject;

  // path clipping operators
    procedure OpClip(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpEOClip(Args: TgtArgumentList; NumArgs: Integer);

  // text object operators
    procedure OpBeginText(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpEndText(Args: TgtArgumentList; NumArgs: Integer);

  // text state operators
    procedure OpSetCharSpacing(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetFont(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetTextLeading(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetTextRender(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetTextRise(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetWordSpacing(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetHorizScaling(Args: TgtArgumentList; NumArgs: Integer);

  // text positioning operators
    procedure OpTextMove(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpTextMoveSet(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetTextMatrix(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpTextNextLine(Args: TgtArgumentList; NumArgs: Integer);

  // text AnsiString operators
    procedure OpShowText(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpMoveShowText(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpMoveSetShowText(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpShowSpaceText(Args: TgtArgumentList; NumArgs: Integer);
    procedure DoShowText(const Str: WideString);
    procedure DoShowHexText(const Str: WideString);

  // XObject operators
    procedure OpXObject(Args: TgtArgumentList; NumArgs: Integer);
    procedure DoImage(AObject: TgtPDBaseObject; Stream: TgtPDBaseObject;
      IsInlineImg: Boolean);

  // in-line image operators
    procedure OpBeginImage(Args: TgtArgumentList; NumArgs: Integer);
    function BuildImageStream: TgtPDBaseObject;
    procedure OpImageData(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpEndImage(Args: TgtArgumentList; NumArgs: Integer);

  // type 3 font operators
    procedure OpSetCharWidth(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpSetCacheDevice(Args: TgtArgumentList; NumArgs: Integer);

  // compatibility operators
    procedure OpBeginIgnoreUndef(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpEndIgnoreUndef(Args: TgtArgumentList; NumArgs: Integer);

  // marked content operators
    procedure OpBeginMarkedContent(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpEndMarkedContent(Args: TgtArgumentList; NumArgs: Integer);
    procedure OpMarkPoint(Args: TgtArgumentList; NumArgs: Integer);
    //For Image insertion
    function GetPDFBitmapStream(ABitmap: TBitmap): TStream;
    //For translation of XandY according to CROPBOX or MEDIABOX
    procedure TranslateXY(var AX, AY: Double);
    procedure CallMeForScript(AText: WideString; ARunIndex, ARunCount: Integer;
      AIsComplex: Boolean; var AGlyphInfoList: TList);
  protected
    Args: TgtArgumentList;
    NumArgs: Integer;
    FFontChanged: Boolean;

    property State: TgtPDState read FState write FState;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    function Clone: TgtPDContentStream;
    destructor Destroy; override;
    procedure Update; override;
    procedure Display(ExportDev: TgtPDExportDevice; hDPI, vDPI: Double;
      PageNum: Integer; Rotate: Integer; Box, CropBox: TgtPDRect);
    procedure DispalyObject(aExportDev: TgtPDExportDevice; aState: TgtPDState;
      AResources: TgtPDResource);
    //-------General Functions

    // Save graphics state.
    procedure SaveState;
    //Restor graphic state
    procedure RestoreState;
    //Get current graphic state
    function GetCurrentState: TgtPDState;
    procedure Save;
    procedure Restore;
    procedure SetTextRenderMode(AValue: TTextRenderMode);
    procedure SetOpacity(AStrokeValue, AFillValue: Integer);
    procedure SetPenWidth(AValue: Double);
    procedure TextOut(const Text: WideString; AFont: TgtFont; aX, aY: Double;
      AWritingMode: TgtWritingMode = wmHorizontal; AAngle: Integer = 0); Overload;
    procedure TextOut(const Text: WideString; AFont: TgtFont; aX, aY: Double;
      aClipRect: TgtPDRect; AWritingMode: TgtWritingMode = wmHorizontal;
      AAngle: Integer = 0); Overload;

    //Unicode support
    procedure TextOutEx(const Text: WideString; AFont: TgtFont; aX, aY: Double;
      AIsComplex: Boolean; AGlyphInfoList: TList; AWritingMode: TgtWritingMode = wmHorizontal;
      AAngle: Integer = 0);
    procedure UniCodeTextOut(const Text: WideString; AFont: TgtFont; aX, aY: Double;
      AWritingMode: TgtWritingMode = wmHorizontal; AAngle: Integer = 0);

    procedure MoveTo(AX, AY: Double);
    procedure LineTo(AX, AY: Double);
    procedure Rectangle(X1, Y1, X2, Y2: Double);
    procedure CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
    procedure SetBrushColor(AR, AG, AB: Byte);
    procedure SetPenColor(AR, AG, AB: Byte);
    procedure ClosePath;
    procedure FillPath;
    procedure StrokePath;
    procedure FillAndStrokePath;
    procedure CloseAndStrokePath;
    procedure CloseFillAndStrokePath;
    procedure EndPath;
    procedure SetDashPattern;
    procedure SetBrushStyle(aBrush: TBrush);
    function GetPattern(aBrushStyle: TBrushStyle): string;
    procedure InsertImage(AX, AY: Double; AStream: TStream;
      AImageFormat: TgtOutFormat; AInLine: Boolean;
      AWidth, AHeight: Double; AAngle: Integer);
    property EvenOddFillMode: Boolean read FEvenOddFillMode write FEvenOddFillMode;
    property PenStyle: TPenStyle read FPenStyle write FPenStyle;
    property PenJoinStyle: TgtPenJoinStyle read FPenJoinStyle write FPenJoinStyle;
    property PenCapStyle: TgtPenCapStyle read FPenCapStyle write FPenCapStyle;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  PDDocument, PDLexer, PDStream, gtMethods, PDCommand, SysUtils,
  PDInteger, PDReal, PDArray, PDName, PDString, PDDictionary,
  gtConstants, PDBoolean, gtTypes, PDPatternColorSpace, PDPattern,
  PDDeviceCMYKColorSpace, PDIndirectRef, PDGState, MemoryStream, JPEG,
  PDPage, PDEncoding, Stream, EmbededStream, PDFilterManager, PDContents,
  PDForm, gtUniscribe, gtPDUsp10, PDCIDFont,
  {$IFDEF VCL6ORABOVE}StrUtils{$ELSE}gtStrUtils{$ENDIF}, FontProcessor, forms;

type
  THackState = class(TgtPDState)

  end;

{ TgtPDContentStream }

function TgtPDContentStream.BuildImageStream: TgtPDBaseObject;
var
  LDict, LObj: TgtPDBaseObject;
  LKey: AnsiString;
  LStream: TgtStream;
begin
  // build dictionary
  LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LObj := FParser.GetObject();
  while (not LObj.IsCommand(PDF_ID)) and (not LObj.IsEOF) do
  begin
    if (not LObj.IsName) then
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Inline image dictionary key must be a name object');
    {$ENDIF}
      FreeAndNil(LObj);
    end
    else
    begin
      LKey := TgtPDName(LObj).Value;
      FreeAndNil(LObj);
      LObj := FParser.GetObject();
      if (LObj.IsEOF or LObj.IsError) then
      begin
        LKey := '';
        Break;
      end;
      TgtPDDictionary(LDict).Add(LKey, LObj);
    end;
    LObj := FParser.GetObject();
  end;
  if LObj.IsEOF then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('End of file in inline image');
    {$ENDIF}
    FreeAndNil(LObj);
    FreeAndNil(LDict);
    Result := nil;
    Exit;
  end;

  //Free the Last object got from the parser
  FreeAndNil(LObj);

  //make stream
  LStream := TgtEmbededStream.Create(FParser.GetStream, 0, False);
  Result := TgtPDFilterManager.GetFilter(LDict, LStream);
end;

procedure TgtPDContentStream.CallMeForScript(AText: WideString;
  ARunIndex, ARunCount: Integer; AIsComplex: Boolean; var AGlyphInfoList: TList);
var
  LGlyphInfo: TgtGlyphInfo;
  LAdvTextWidth: Integer;
  LFontProcObj: TgtFontProcessor;
  LFont: TFont;
  ErrorCode: ErrorCodes;
  LTxtWidth: Double;
  LRunFontName: string;

  procedure CopyGlyphInfos;
  var
    LI : Integer;
  begin
    for LI := 0 to AGlyphInfoList.Count - 1 do
      FTempGlyphInfoList.Add(AGlyphInfoList.Items[LI]);
    FreeAndNil(AGlyphInfoList);
  end;

  procedure ClearGlyphInfos;
  var
    LI : Integer;
  begin
    for LI := 0 to FTempGlyphInfoList.Count - 1 do
      TgtGlyphInfo(FTempGlyphInfoList.Items[LI]).Free;
    FTempGlyphInfoList.Clear;
  end;

  procedure WriteText;
  begin
    TextOutEx(FSameFontText, FFont, Fx, Fy, AIsComplex, FTempGlyphInfoList, FWritingMode, FAngle);
    LFont := TFont.Create;
    LFont.Name := FFont.Name;
    LFont.Size := FFont.Size;
    LFont.Color := FFont.Color;
    LFontProcObj := TgtFontProcessor.Create(LFont, ErrorCode);
    try
      LTxtWidth := LFontProcObj.GetTextWidth(FSameFontText);
      Fx := Fx + LTxtWidth * Cos(FAngle * Pi / 180.0);
      Fy := Fy + LTxtWidth * Sin(FAngle * Pi / 180.0);
    finally
      LFontProcObj.Free;
      LFont.Free;
    end;
  end;

begin
  if (AGlyphInfoList = nil) then
    Exit;
  if (AGlyphInfoList.Count = 0) then
  begin
    AGlyphInfoList.Free;
    Exit;
  end;
  LRunFontName := TgtGlyphInfo(AGlyphInfoList.Items[0]).FontName;
  if (not Assigned(FTempGlyphInfoList)) then
    FTempGlyphInfoList := TList.Create;

  //First run, init text
  if (ARunIndex = 0) then
  begin
    FSameFontText := AText;
    FFont.Name := LRunFontName;
    CopyGlyphInfos;
  end
  else //Not first run
  begin
    if (FFont.Name = LRunFontName) then
    begin //same font, merge with prev text
      FSameFontText := FSameFontText + AText;
      CopyGlyphInfos;
    end
    else //diff font, write prev text, store curr text
    begin
      WriteText;
      ClearGlyphInfos;
      FFont.Name := LRunFontName;
      FSameFontText := AText;
      CopyGlyphInfos;
    end;
  end;
  //last run, write text, clear list
  if (ARunIndex = (ARunCount - 1)) then
  begin
    WriteText;
    ClearGlyphInfos;
  end;
end;

function TgtPDContentStream.CheckArg(Arg: TgtPDBaseObject;
  CheckType: TgtArgCheck): Boolean;
begin
  Result := False;
  case CheckType of
    acBoolean: Result := Arg.IsBoolean;
    acInteger: Result := Arg.IsInteger;
    acNumber: Result := Arg.IsNumber;
    acString: Result := Arg.IsString;
    acName: Result := Arg.IsName;
    acArray: Result := Arg.IsArray;
    acProps: Result := Arg.IsDict or Arg.IsName;
    acSCN: Result := Arg.IsNumber or Arg.IsName;
    acNone: Result := False;
  end;
end;

function TgtPDContentStream.Clone: TgtPDContentStream;
begin
  Result := TgtPDContentStream.Create(FParentDoc, FParentElement, FBaseObject);
end;

procedure TgtPDContentStream.CloseAndStrokePath;
var
  LStr: AnsiString;
begin
  LStr := 's' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.CloseFillAndStrokePath;
var
  LStr: AnsiString;
begin
  if EvenOddFillMode then
    LStr := 'b*' + CRLF
  else
    LStr := 'b' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.ClosePath;
var
  LStr: AnsiString;
begin
  LStr := 'h' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

constructor TgtPDContentStream.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
var
  I: Integer;
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FStateStack := nil;
  FState := nil;
  for I := 0 to MAXARGS do
    Args[I] := nil;
  NumArgs := 0;
  FSameFontText := '';
  FTempGlyphInfoList := TList.Create;
end;

procedure TgtPDContentStream.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
var
  LStr: AnsiString;
begin
  TranslateXY(X1, Y1);
  TranslateXY(X2, Y2);
  TranslateXY(X3, Y3);
  LStr := FloatToStringLocale(X1) + ' ' + FloatToStringLocale(Y1) + ' ' +
    FloatToStringLocale(X2) + ' ' + FloatToStringLocale(Y2) + ' ' +
    FloatToStringLocale(X3) + ' ' + FloatToStringLocale(Y3) + ' ' + 'c' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

destructor TgtPDContentStream.Destroy;
var
  I: Integer;
begin
  if Assigned(FState) then
    FreeAndNil(FState);

  if NumArgs > 0 then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Leftover a rgs in content stream');
    {$ENDIF}
    for I := 0 to NumArgs - 1 do
      if Assigned(Args[I]) then Args[I].Free;
  end;
  if Assigned(FTempGlyphInfoList) then
    FreeAndNil(FTempGlyphInfoList);
  inherited;
end;

procedure TgtPDContentStream.DispalyObject(aExportDev: TgtPDExportDevice;
  aState: TgtPDState; AResources: TgtPDResource);
var
  Lexer: TgtPDLexer;
begin
  FPageResource := AResources;
  FState := aState;
  FExportDev := aExportDev;

  InitOpTable;
  Lexer := TgtPDLexer.Create(TgtPDStream(BaseObject).GetStream, False);
  FParser := TgtPDParser.Create(TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef,
    Lexer);
  FUpdateLevel := 0;
  StartContentParsing;
  FreeAndNil(FParser);
end;

procedure TgtPDContentStream.Display(ExportDev: TgtPDExportDevice; hDPI,
  vDPI: Double; PageNum, Rotate: Integer; Box, CropBox: TgtPDRect);
var
  Lexer: TgtPDLexer;
begin
  FExportDev := ExportDev;
  FhDPI := hDPI;
  FvDPI := vDPI;
  FRotate := Rotate;
  FBox := Box;
  FCropBox := CropBox;
  FPageNum := PageNum;

  InitOpTable;

  FPageResource := TgtPDDocument(ParentDoc).Pages[PageNum].Resource;
  if not Assigned(State) then
    State := TgtPDState.Create(hDPI, vDPI, Rotate, CropBox);

  THackState(FState).FPageNumber := PageNum;
//  SaveState;

  FBaseMatrix := FState.CTM;

  ExportDev.SetDefaultCTM(FState.CTM);
  ExportDev.UpdateAll(FState);

  Lexer := TgtPDLexer.Create(TgtPDStream(BaseObject).GetStream, False);
  FParser := TgtPDParser.Create(TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef,
    Lexer);
  FUpdateLevel := 0;
  try
    try
      {$IFDEF DEBUG}
          Logger.LogInfo('Content parsing for page (%d) started', [PageNum]);
      {$ENDIF}
      StartContentParsing;
    except
  {$IFDEF DEBUG}
      Logger.LogError('Exception occured while parsing content stream');
  {$ENDIF}
    end;
  finally
    FreeAndNil(FParser);
  end;
//  RestoreState;
end;

procedure TgtPDContentStream.DoEndPath;
begin
  if FState.IsCurrentPoint and (FClip <> clipNone) then
  begin
    if FClip = clipNormal then
      FExportDev.Clip(FState)
    else
      FExportDev.EvenOddClip(FState);
  end;
  FClip := clipNone;
  FState.ClearPath;
end;

(*
function TgtPDContentStream.DoForm: TgtPDBaseObject;
begin

end;
*)

procedure TgtPDContentStream.DoImage(AObject, Stream: TgtPDBaseObject;
  IsInlineImg: Boolean);
var
  LImage: TgtPDImage;
  LElement: TgtPDElement;
begin
  LElement := nil;
  if FParentElement is TgtPDContents then
    LElement := TgtPDContents(FParentElement).ParentElement
  else
    LElement := FParentElement;

  LImage := TgtPDImage.Create(FParentDoc, LElement, Stream);
  try
    LImage.IsInlineImage := True;
    FExportDev.DrawImage(State, LImage);
  finally
    FreeAndNil(LImage);
  end;
end;

procedure TgtPDContentStream.DoPatternFill(EoFill: Boolean);
begin

end;

procedure TgtPDContentStream.DoPatternStroke;
begin

end;

procedure TgtPDContentStream.DoShowHexText(const Str: WideString);
var
  J: Integer;
  LInt: Integer;
  LStr: WideString;
  LLength: Integer;
begin
  //Remove AnsiChar() typecast if any problem occurs had changed it
  //for Delphi 7 support
  if FState.Font.IsCIDFont then
  begin
    J := 1;
    LStr := '';
    LLength := Length(Str);
    while J <= LLength do
    begin
      if (LLength - J < 3) then
      begin
        case LLength - J of
          0: LStr := '000' + AnsiChar(Str[J]);
          1: LStr := '00' + AnsiChar(Str[J]) + AnsiChar(Str[J + 1]);
          2: LStr := '0' + AnsiChar(Str[J]) + AnsiChar(Str[J + 1]) + AnsiChar(Str[J + 2]);
        end;
        LInt := StrToInt('$' + AnsiChar(LStr[1]) + AnsiChar(LStr[2]) + AnsiChar(LStr[3]) + AnsiChar(LStr[4]));
      end
      else
        LInt := StrToInt('$' + AnsiChar(Str[J]) + AnsiChar(Str[J + 1]) +
          AnsiChar(Str[J + 2]) + AnsiChar(Str[J + 3]));
      LStr := WideChar(LInt);
      DoShowText(LStr);
      J := J + 4;
    end;
  end
  else
  begin
    J := 1;
    LStr := '';
    LLength := Length(Str);
    while J <= LLength do
    begin
      if (LLength - J < 1) then
      begin
        case LLength - J of
          0: LStr := '0' + AnsiChar(Str[J]);
        end;
        LInt := StrToInt('$' + AnsiChar(LStr[1]) + AnsiChar(LStr[2]));
      end
      else
        LInt := StrToInt('$' + AnsiChar(Str[J]) + AnsiChar(Str[J + 1]));
      LStr := WideChar(LInt);
      DoShowText(LStr);
      J := J + 2;
    end;
  end;
end;

procedure TgtPDContentStream.DoShowText(const Str: WideString);
var
  LFont: TgtPDFont;
  LWMode: TgtWritingMode;
  LLength: Integer;
  Code: TgtCharCode;
  ACharName: AnsiString;
  Dx, Dy, OrginX, OrginY: Double;
  I: Integer;
  LProcessed: Integer;
  LUnicodes: TgtUnicodes;
  LContentStrm: TgtPDContentStream;
  LType3FontDict, LFontDict: TgtPDBaseObject;
  LEncodingDict, LDifferenceArray, LGlyphname: TgtPDBaseObject;
  LCharProcDict, LObj: TgtPDBaseObject;
  LPageResource: TgtPDResource;
  LArray: TgtPDArray;

  function GetGlyphIDFromCharCode(aCharCode: Word):TgtPDBaseObject;
  var
    I: Integer;
  begin
    if aCharCode = 0 then
    begin
      Result := nil;
      Exit;
    end;
    LPageResource := TgtPDDocument(ParentDoc).Pages[State.PageNumber].Resource;
    LFontDict := TgtPDDictionary(LPageResource.BaseObject).LookUp(PDF_FONT);
    if LFontDict.IsDict then
    begin
      LType3FontDict := TgtPDDictionary(LFontDict).LookUp(State.Font.Tag);
      if LType3FontDict.IsDict then
      begin
        LEncodingDict := TgtPDDictionary(LType3FontDict).LookUp(PDF_ENCODING);
        if LEncodingDict.IsDict then
        begin
          LDifferenceArray := TgtPDDictionary(LEncodingDict).LookUp(PDF_DIFFERENCES);
          if LDifferenceArray.IsArray then
          begin
            LArray := (LDifferenceArray as TgtPDArray);
            for I := 1 to LArray.GetLength do
            begin
              LGlyphname := LArray.Get(I);
              if LGlyphname.IsName then
              begin
                if AnsiContainsStr(TgtPDName(LGlyphname).Value, IntToStr(aCharCode)) then
                begin
                  Result := (LGlyphname as TgtPDName);
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  function GetContentStreamOfTheGlyphID(aGlyphID: TgtPDBaseObject):TgtPDContentStream;
  begin
    if not aGlyphID.IsName then
    begin
      Result := nil;
      Exit;
    end;

    LPageResource := TgtPDDocument(ParentDoc).Pages[State.PageNumber].Resource;
    LFontDict := TgtPDDictionary(LPageResource.BaseObject).LookUp(PDF_FONT);
    if LFontDict.IsDict then
    begin
      LType3FontDict := TgtPDDictionary(LFontDict).LookUp(State.Font.Tag);
      if LType3FontDict.IsDict then
      begin
        LCharProcDict := TgtPDDictionary(LType3FontDict).LookUp(PDF_CHARPROCS);
        if LCharProcDict.IsDict then
        begin
          LObj := TgtPDDictionary(LCharProcDict).LookUp(TgtPDName(aGlyphID).Value);
          if Assigned(LObj) then
          begin
            if LObj.IsStream then
            begin
              Result := TgtPDContentStream.Create(TgtPDDocument(ParentDoc),ParentElement,TgtPDStream(LObj));
            end;
          end;
        end;
      end;
    end;
  end;

  function GetContentStreamToRender(aCharCode: Word):TgtPDContentStream;
  begin
    Result := nil;
    LGlyphname := GetGlyphIDFromCharCode(aCharCode);
    if Assigned(LGlyphname) then
      Result := GetContentStreamOfTheGlyphID(LGlyphname);
  end;

begin
  LFont := FState.Font;
  LWMode := LFont.WritingMode;

  if FExportDev.UseDrawChar then
  begin
    FExportDev.BeginString(FState, Str);
  end;

  if (LFont.FontType = Type3) and (FExportDev.InterpretType3Chars) then
  begin
//    for I := 0 to Length(Str) do
//    begin
//      LContentStrm := GetContentStreamToRender(Word(Str[I]));
//      if Assigned(LContentStrm) then
//      begin
//        LContentStrm.Display(FExportDev, 96, 96, State.PageNumber, 0,
//          TgtPDDocument(ParentDoc).Pages[State.PageNumber].Cropbox,
//          TgtPDDocument(ParentDoc).Pages[State.PageNumber].Cropbox);
//        LContentStrm.Free;
//      end;
//    end;
//      FExportDev.BeginType3Char(FState, FState.CurX, FState.CurY, dX, dY, Word(Str[I]),
//       LUnicodes, Length(Str));
  end
  else if FExportDev.UseDrawChar then
  begin
    if Length(Str) > 1 then
      LLength := Length(TrimRight(Str))
    else
      LLength := Length(Str);
    I := 1;
    while I <= LLength do
    begin
      //In certain strings, there can be some escape chars like \n, \r, \f etc.
      //We need not process those chars as the positioning is taken cared explicitly
//      if ((Str[I] <> #13) or (Str[I] <> #10)) then
      begin
        LFont.GetNextChar(Str, I, LProcessed, Code, ACharName, Dx, Dy,
          OrginX, OrginY);
        FState.CurCharW := Dx * FState.FontSize;
        I := I + LProcessed;
        Dy := 0;
        if LWMode = wmVertical then
        begin
          Dx := Dx * FState.FontSize;
          Dy := Dy * FState.FontSize + FState.CharSpace;
          if Code = 32 then
            Dy := Dy + FState.WordSpace;
        end
        else
        begin
          Dx := Dx * FState.FontSize + FState.CharSpace;
          if Code = 32 then
            Dx := Dx + FState.WordSpace;
          Dx := Dx * FState.HorizScaling;
          Dy := Dy * FState.FontSize;
        end;
        FExportDev.DrawChar(FState, FState.CurX, FState.CurY, dX, dY, Code, ACharName);
        FState.Shift(dX, dY);
      end;
//      else
//        Inc(I);
    end;
  end
  else
  begin
    FExportDev.RawTextOut(FState, FState.CurX, FState.CurY, Str);
  end;

  if FExportDev.UseDrawChar then
  begin
    FExportDev.EndString(FState);
  end;
end;

procedure TgtPDContentStream.EndPath;
var
  LStr: AnsiString;
begin
  LStr := 'n' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.ExecuteOp(Command: TgtPDBaseObject;
  Args: TgtArgumentList; NumArgs: Integer);
var
  Cmd: AnsiString;
  LOperator: TgtOperator;
  I: Integer;
begin
  Cmd := TgtPDCommand(Command).Value;
  {$IFDEF DEBUG}
    Logger.LogInfo('%s operator is about to be processed', [Cmd]);
  {$ENDIF}
  if FindOperator(Cmd, LOperator) then
  begin
    if LOperator.NumArgs >= 0 then
    begin
      if NumArgs < LOperator.NumArgs then
      begin
      {$IFDEF DEBUG}
        Logger.LogError('Too few (%d) args to %s operator', [NumArgs, Cmd]);
      {$ENDIF}
        Exit;
      end;
      if NumArgs > LOperator.NumArgs then
      begin
      {$IFDEF DEBUG}
        Logger.LogError('Too many (%d) args to %s operator', [NumArgs, Cmd]);
      {$ENDIF}
        NumArgs := LOperator.NumArgs;
      end;
    end
    else
    begin
      if NumArgs > -LOperator.NumArgs then
      begin
      {$IFDEF DEBUG}
        Logger.LogError('Too many (%d) args to %s operator', [NumArgs, Cmd]);
      {$ENDIF}
        Exit;
      end;
    end;

    for I := 0 to NumArgs - 1 do
    begin
      if not CheckArg(Args[I], LOperator.ArgChk[I]) then
      begin
      {$IFDEF DEBUG}
        Logger.LogError('Arg #%d to %s operator is wrong type (%s)',
          [I, Cmd, Args[I].GetTypeName]);
      {$ENDIF}
        Exit;
      end;
    end;

    LOperator.Operation(Args, NumArgs);
  end
  else
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Unknown operator %s', [Cmd]);
    {$ENDIF}
  end;
end;

procedure TgtPDContentStream.FillAndStrokePath;
var
  LStr: AnsiString;
begin
  if EvenOddFillMode then
    LStr := 'B*' + CRLF
  else
    LStr := 'B' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.FillPath;
var
  LStr: AnsiString;
begin
  if EvenOddFillMode then
    LStr := 'f*' + CRLF
  else
    LStr := 'f' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

function TgtPDContentStream.FindOperator(const Name: AnsiString;
  var Op: TgtOperator): Boolean;
var
  First, Last, Mid, CmpResult: Integer;
begin
  Result := False;
  First := Low(FOpTable);
  Last := High(FOpTable);

  CmpResult := -1;
  while (First <= Last) do
  begin
    Mid := (First + Last) div 2;
    CmpResult := AnsiCompareStr(FOpTable[Mid].Op, Name);
    if CmpResult < 0 then
      First := Mid + 1
    else if CmpResult > 0 then
      Last := Mid - 1
    else
    begin
      First := Mid;
      Break;
    end;
  end;

  if CmpResult = 0 then
  begin
    Op := FOpTable[First];
    Result := True;
  end;
end;

function TgtPDContentStream.GetCurrentState: TgtPDState;
begin
  Result := FState;
end;

function TgtPDContentStream.GetPattern(aBrushStyle: TBrushStyle): string;
begin
  Result := '';
  case aBrushStyle of
    bsHorizontal:
    begin
      Result := 'PH';
    end;
    bsVertical:
    begin
      Result := 'PV';
    end;
    bsFDiagonal:
    begin
      Result := 'PFD';
    end;
    bsBDiagonal:
    begin
      Result := 'PBD';
    end;
    bsCross:
    begin
      Result := 'PC';
    end;
    bsDiagCross:
    begin
      Result := 'PDC';
    end;
  end;
end;

function TgtPDContentStream.GetPDFBitmapStream(ABitmap: TBitmap): TStream;
var
  LX, LY: Integer;
  ScanLine: PByteArray;
  LByte: Byte;
  LBitmap: TBitmap;
begin
  Result := TMemoryStream.Create;
  LBitmap := TBitmap.Create;
  try
    LBitmap.Assign(ABitmap);
    LBitmap.PixelFormat := pf24Bit;

    Result.Size := LBitmap.Width * LBitmap.Height * 3;
    for LY := 0 to (LBitmap.Height - 1) do
    begin
      ScanLine := LBitmap.ScanLine[LY];
      LX := 0;
      while LX < (LBitmap.Width * 3 - 1) do
      begin
        LByte := ScanLine[LX];
        ScanLine[LX] := ScanLine[LX + 2];
        ScanLine[LX + 2] := LByte;
        Inc(LX, 3);
      end;
      Result.Write(ScanLine[0], (LBitmap.Width * 3));
    end;
  finally
    FreeAndNil(LBitmap);
  end;
end;

(*
function TgtPDContentStream.GetPosition: Integer;
begin
  Result := 0;
  if Assigned(FParser) then
    Result := FParser.GetPosition;
end;
*)

procedure TgtPDContentStream.InitColorObject(var AColor: TgtColor);
var
  LI: Integer;
begin
  for LI := 0 to ColorMapMaxComps - 1 do
    AColor.Comps[LI] := 0;
end;

procedure TgtPDContentStream.InitOpTable;
begin
  FOpTable[0].Op := ''''; FOpTable[0].NumArgs := 1;
  FOpTable[0].ArgChk[0] := acString; FOpTable[0].Operation := OpMoveShowText;

  FOpTable[1].Op := '"'; FOpTable[1].NumArgs := 3;
  FOpTable[1].ArgChk[0] := acNumber; FOpTable[1].ArgChk[1] := acNumber;
  FOpTable[1].ArgChk[2] := acString; FOpTable[1].Operation := OpMoveSetShowText;

  FOpTable[2].Op := 'b'; FOpTable[2].NumArgs := 0;
  FOpTable[2].ArgChk[0] := acNone; FOpTable[2].Operation := opCloseFillStroke;

  FOpTable[3].Op := 'B'; FOpTable[3].NumArgs := 0;
  FOpTable[3].ArgChk[0] := acNone; FOpTable[3].Operation := OpFillStroke;

  FOpTable[4].Op := 'b*'; FOpTable[4].NumArgs := 0;
  FOpTable[4].ArgChk[0] := acNone; FOpTable[4].Operation := opEOFillStroke;

  FOpTable[5].Op := 'B*'; FOpTable[5].NumArgs := 0;
  FOpTable[5].ArgChk[0] := acNone; FOpTable[5].Operation := opCloseEOFillStroke;

  FOpTable[6].Op := 'BDC'; FOpTable[6].NumArgs := 2;
  FOpTable[6].ArgChk[0] := acName; FOpTable[6].ArgChk[1] := acProps;
  FOpTable[6].Operation := opBeginMarkedContent;

  FOpTable[7].Op := 'BI'; FOpTable[7].NumArgs := 0;
  FOpTable[7].ArgChk[0] := acNone; FOpTable[7].Operation := opBeginImage;

  FOpTable[8].Op := 'BMC'; FOpTable[8].NumArgs := 1;
  FOpTable[8].ArgChk[0] := acName; FOpTable[8].Operation := opBeginMarkedContent;

  FOpTable[9].Op := 'BT'; FOpTable[9].NumArgs := 0;
  FOpTable[9].ArgChk[0] := acNone; FOpTable[9].Operation := opBeginText;

  FOpTable[10].Op := 'BX'; FOpTable[10].NumArgs := 0;
  FOpTable[10].ArgChk[0] := acNone; FOpTable[10].Operation := opBeginIgnoreUndef;

  FOpTable[11].Op := 'c'; FOpTable[11].NumArgs := 6;
  FOpTable[11].ArgChk[0] := acNumber; FOpTable[11].ArgChk[1] := acNumber;
  FOpTable[11].ArgChk[2] := acNumber; FOpTable[11].ArgChk[3] := acNumber;
  FOpTable[11].ArgChk[4] := acNumber; FOpTable[11].ArgChk[5] := acNumber;
  FOpTable[11].Operation := opCurveTo;

  FOpTable[12].Op := 'cm'; FOpTable[12].NumArgs := 6;
  FOpTable[12].ArgChk[0] := acNumber; FOpTable[12].ArgChk[1] := acNumber;
  FOpTable[12].ArgChk[2] := acNumber; FOpTable[12].ArgChk[3] := acNumber;
  FOpTable[12].ArgChk[4] := acNumber; FOpTable[12].ArgChk[5] := acNumber;
  FOpTable[12].Operation := opConcat;

  FOpTable[13].Op := 'cs'; FOpTable[13].NumArgs := 1;
  FOpTable[13].ArgChk[0] := acName; FOpTable[13].Operation := opSetFillColorSpace;

  FOpTable[14].Op := 'CS'; FOpTable[14].NumArgs := 1;
  FOpTable[14].ArgChk[0] := acName; FOpTable[14].Operation := opSetStrokeColorSpace;

  FOpTable[15].Op := 'd'; FOpTable[15].NumArgs := 2;
  FOpTable[15].ArgChk[0] := acArray; FOpTable[15].ArgChk[1] := acNumber;
  FOpTable[15].Operation := opSetDash;

  FOpTable[16].Op := 'd0'; FOpTable[16].NumArgs := 2;
  FOpTable[16].ArgChk[0] := acNumber; FOpTable[16].ArgChk[1] := acNumber;
  FOpTable[16].Operation := opSetCharWidth;

  FOpTable[17].Op := 'd1'; FOpTable[17].NumArgs := 6;
  FOpTable[17].ArgChk[0] := acNumber; FOpTable[17].ArgChk[1] := acNumber;
  FOpTable[17].ArgChk[2] := acNumber; FOpTable[17].ArgChk[3] := acNumber;
  FOpTable[17].ArgChk[4] := acNumber; FOpTable[17].ArgChk[5] := acNumber;
  FOpTable[17].Operation := opSetCacheDevice;

  FOpTable[18].Op := 'Do'; FOpTable[18].NumArgs := 1;
  FOpTable[18].ArgChk[0] := acName; FOpTable[18].Operation := opXObject;

  FOpTable[19].Op := 'DP'; FOpTable[19].NumArgs := 2;
  FOpTable[19].ArgChk[0] := acName; FOpTable[19].ArgChk[1] := acProps;
  FOpTable[19].Operation := opMarkPoint;

  FOpTable[20].Op := 'EI'; FOpTable[20].NumArgs := 0;
  FOpTable[20].ArgChk[0] := acNone; FOpTable[20].Operation := opEndImage;

  FOpTable[21].Op := 'EMC'; FOpTable[21].NumArgs := 0;
  FOpTable[21].ArgChk[0] := acNone; FOpTable[21].Operation := opEndMarkedContent;

  FOpTable[22].Op := 'ET'; FOpTable[22].NumArgs := 0;
  FOpTable[22].ArgChk[0] := acNone; FOpTable[22].Operation := opEndText;

  FOpTable[23].Op := 'EX'; FOpTable[23].NumArgs := 0;
  FOpTable[23].ArgChk[0] := acNone; FOpTable[23].Operation := opEndIgnoreUndef;

  FOpTable[24].Op := 'f'; FOpTable[24].NumArgs := 0;
  FOpTable[24].ArgChk[0] := acNone; FOpTable[24].Operation := opFill;

  FOpTable[25].Op := 'F'; FOpTable[25].NumArgs := 0;
  FOpTable[25].ArgChk[0] := acNone; FOpTable[25].Operation := opFill;

  FOpTable[26].Op := 'f*'; FOpTable[26].NumArgs := 0;
  FOpTable[26].ArgChk[0] := acNone; FOpTable[26].Operation := opEOFill;

  FOpTable[27].Op := 'g'; FOpTable[27].NumArgs := 1;
  FOpTable[27].ArgChk[0] := acNumber; FOpTable[27].Operation := opSetFillGray;

  FOpTable[28].Op := 'G'; FOpTable[28].NumArgs := 1;
  FOpTable[28].ArgChk[0] := acNumber; FOpTable[28].Operation := opSetStrokeGray;

  FOpTable[29].Op := 'gs'; FOpTable[29].NumArgs := 1;
  FOpTable[29].ArgChk[0] := acName; FOpTable[29].Operation := opSetExtGState;

  FOpTable[30].Op := 'h'; FOpTable[30].NumArgs := 0;
  FOpTable[30].ArgChk[0] := acNone; FOpTable[30].Operation := opClosePath;

  FOpTable[31].Op := 'i'; FOpTable[31].NumArgs := 1;
  FOpTable[31].ArgChk[0] := acNumber; FOpTable[31].Operation := opSetFlat;

  FOpTable[32].Op := 'ID'; FOpTable[32].NumArgs := 0;
  FOpTable[32].ArgChk[0] := acNone; FOpTable[32].Operation := opImageData;

  FOpTable[33].Op := 'j'; FOpTable[33].NumArgs := 1;
  FOpTable[33].ArgChk[0] := acInteger; FOpTable[33].Operation := opSetLineJoin;

  FOpTable[34].Op := 'J'; FOpTable[34].NumArgs := 1;
  FOpTable[34].ArgChk[0] := acInteger; FOpTable[34].Operation := opSetLineCap;

  FOpTable[35].Op := 'k'; FOpTable[35].NumArgs := 4;
  FOpTable[35].ArgChk[0] := acNumber; FOpTable[35].ArgChk[1] := acNumber;
  FOpTable[35].ArgChk[2] := acNumber; FOpTable[35].ArgChk[3] := acNumber;
  FOpTable[35].Operation := opSetFillCMYKColor;

  FOpTable[36].Op := 'K'; FOpTable[36].NumArgs := 4;
  FOpTable[36].ArgChk[0] := acNumber; FOpTable[36].ArgChk[1] := acNumber;
  FOpTable[36].ArgChk[2] := acNumber; FOpTable[36].ArgChk[3] := acNumber;
  FOpTable[36].Operation := opSetStrokeCMYKColor;

  FOpTable[37].Op := 'l'; FOpTable[37].NumArgs := 2;
  FOpTable[37].ArgChk[0] := acNumber; FOpTable[37].ArgChk[1] := acNumber;
  FOpTable[37].Operation := opLineTo;

  FOpTable[38].Op := 'm'; FOpTable[38].NumArgs := 2;
  FOpTable[38].ArgChk[0] := acNumber; FOpTable[38].ArgChk[1] := acNumber;
  FOpTable[38].Operation := opMoveTo;

  FOpTable[39].Op := 'M'; FOpTable[39].NumArgs := 1;
  FOpTable[39].ArgChk[0] := acNumber; FOpTable[39].Operation := opSetMiterLimit;

  FOpTable[40].Op := 'MP'; FOpTable[40].NumArgs := 1;
  FOpTable[40].ArgChk[0] := acName; FOpTable[40].Operation := opMarkPoint;

  FOpTable[41].Op := 'n'; FOpTable[41].NumArgs := 0;
  FOpTable[41].ArgChk[0] := acNone; FOpTable[41].Operation := opEndPath;

  FOpTable[42].Op := 'q'; FOpTable[42].NumArgs := 0;
  FOpTable[42].ArgChk[0] := acNone; FOpTable[42].Operation := OpSave;

  FOpTable[43].Op := 'Q'; FOpTable[43].NumArgs := 0;
  FOpTable[43].ArgChk[0] := acNone; FOpTable[43].Operation := OpRestore;

  FOpTable[44].Op := 're'; FOpTable[44].NumArgs := 4;
  FOpTable[44].ArgChk[0] := acNumber; FOpTable[44].ArgChk[1] := acNumber;
  FOpTable[44].ArgChk[2] := acNumber; FOpTable[44].ArgChk[3] := acNumber;
  FOpTable[44].Operation := opRectangle;

  FOpTable[45].Op := 'rg'; FOpTable[45].NumArgs := 3;
  FOpTable[45].ArgChk[0] := acNumber; FOpTable[45].ArgChk[1] := acNumber;
  FOpTable[45].ArgChk[2] := acNumber; FOpTable[45].Operation := opSetFillRGBColor;

  FOpTable[46].Op := 'RG'; FOpTable[46].NumArgs := 3;
  FOpTable[46].ArgChk[0] := acNumber; FOpTable[46].ArgChk[1] := acNumber;
  FOpTable[46].ArgChk[2] := acNumber; FOpTable[46].Operation := opSetStrokeRGBColor;

  FOpTable[47].Op := 'ri'; FOpTable[47].NumArgs := 1;
  FOpTable[47].ArgChk[0] := acName; FOpTable[47].Operation := opSetRenderingIntent;

  FOpTable[48].Op := 's'; FOpTable[48].NumArgs := 0;
  FOpTable[48].ArgChk[0] := acNone; FOpTable[48].Operation := opCloseStroke;

  FOpTable[49].Op := 'S'; FOpTable[49].NumArgs := 0;
  FOpTable[49].ArgChk[0] := acNone; FOpTable[49].Operation := opStroke;

  FOpTable[50].Op := 'sc'; FOpTable[50].NumArgs := -4;
  FOpTable[50].ArgChk[0] := acNumber; FOpTable[50].ArgChk[1] := acNumber;
  FOpTable[50].ArgChk[2] := acNumber; FOpTable[50].ArgChk[3] := acNumber;
  FOpTable[50].Operation := opSetFillColor;

  FOpTable[51].Op := 'SC'; FOpTable[51].NumArgs := -4;
  FOpTable[51].ArgChk[0] := acNumber; FOpTable[51].ArgChk[1] := acNumber;
  FOpTable[51].ArgChk[2] := acNumber; FOpTable[51].ArgChk[3] := acNumber;
  FOpTable[51].Operation := opSetStrokeColor;

  FOpTable[52].Op := 'scn'; FOpTable[52].NumArgs := -33;
  FOpTable[52].ArgChk[0] := acSCN; FOpTable[52].ArgChk[1] := acSCN;
  FOpTable[52].ArgChk[2] := acSCN; FOpTable[52].ArgChk[3] := acSCN;
  FOpTable[52].ArgChk[4] := acSCN; FOpTable[52].ArgChk[5] := acSCN;
  FOpTable[52].ArgChk[6] := acSCN; FOpTable[52].ArgChk[7] := acSCN;
  FOpTable[52].ArgChk[8] := acSCN; FOpTable[52].ArgChk[9] := acSCN;
  FOpTable[52].ArgChk[10] := acSCN; FOpTable[52].ArgChk[11] := acSCN;
  FOpTable[52].ArgChk[12] := acSCN; FOpTable[52].ArgChk[13] := acSCN;
  FOpTable[52].ArgChk[14] := acSCN; FOpTable[52].ArgChk[15] := acSCN;
  FOpTable[52].ArgChk[16] := acSCN; FOpTable[52].ArgChk[17] := acSCN;
  FOpTable[52].ArgChk[18] := acSCN; FOpTable[52].ArgChk[19] := acSCN;
  FOpTable[52].ArgChk[20] := acSCN; FOpTable[52].ArgChk[21] := acSCN;
  FOpTable[52].ArgChk[22] := acSCN; FOpTable[52].ArgChk[23] := acSCN;
  FOpTable[52].ArgChk[24] := acSCN; FOpTable[52].ArgChk[25] := acSCN;
  FOpTable[52].ArgChk[26] := acSCN; FOpTable[52].ArgChk[27] := acSCN;
  FOpTable[52].ArgChk[28] := acSCN; FOpTable[52].ArgChk[29] := acSCN;
  FOpTable[52].ArgChk[30] := acSCN; FOpTable[52].ArgChk[31] := acSCN;
  FOpTable[52].ArgChk[32] := acSCN; FOpTable[52].Operation := opSetFillColorN;

  FOpTable[53].Op := 'SCN'; FOpTable[53].NumArgs := -33;
  FOpTable[53].ArgChk[0] := acSCN; FOpTable[53].ArgChk[1] := acSCN;
  FOpTable[53].ArgChk[2] := acSCN; FOpTable[53].ArgChk[3] := acSCN;
  FOpTable[53].ArgChk[4] := acSCN; FOpTable[53].ArgChk[5] := acSCN;
  FOpTable[53].ArgChk[6] := acSCN; FOpTable[53].ArgChk[7] := acSCN;
  FOpTable[53].ArgChk[8] := acSCN; FOpTable[53].ArgChk[9] := acSCN;
  FOpTable[53].ArgChk[10] := acSCN; FOpTable[53].ArgChk[11] := acSCN;
  FOpTable[53].ArgChk[12] := acSCN; FOpTable[53].ArgChk[13] := acSCN;
  FOpTable[53].ArgChk[14] := acSCN; FOpTable[53].ArgChk[15] := acSCN;
  FOpTable[53].ArgChk[16] := acSCN; FOpTable[53].ArgChk[17] := acSCN;
  FOpTable[53].ArgChk[18] := acSCN; FOpTable[53].ArgChk[19] := acSCN;
  FOpTable[53].ArgChk[20] := acSCN; FOpTable[53].ArgChk[21] := acSCN;
  FOpTable[53].ArgChk[22] := acSCN; FOpTable[53].ArgChk[23] := acSCN;
  FOpTable[53].ArgChk[24] := acSCN; FOpTable[53].ArgChk[25] := acSCN;
  FOpTable[53].ArgChk[26] := acSCN; FOpTable[53].ArgChk[27] := acSCN;
  FOpTable[53].ArgChk[28] := acSCN; FOpTable[53].ArgChk[29] := acSCN;
  FOpTable[53].ArgChk[30] := acSCN; FOpTable[53].ArgChk[31] := acSCN;
  FOpTable[53].ArgChk[32] := acSCN; FOpTable[53].Operation := opSetStrokeColorN;

  FOpTable[54].Op := 'sh'; FOpTable[54].NumArgs := 1;
  FOpTable[54].ArgChk[0] := acName; FOpTable[54].Operation := OpShFill;

  FOpTable[55].Op := 'T*'; FOpTable[55].NumArgs := 0;
  FOpTable[55].ArgChk[0] := acNone; FOpTable[55].Operation := opTextNextLine;

  FOpTable[56].Op := 'Tc'; FOpTable[56].NumArgs := 1;
  FOpTable[56].ArgChk[0] := acNumber; FOpTable[56].Operation := opSetCharSpacing;

  FOpTable[57].Op := 'Td'; FOpTable[57].NumArgs := 2;
  FOpTable[57].ArgChk[0] := acNumber; FOpTable[57].ArgChk[1] := acNumber;
  FOpTable[57].Operation := opTextMove;

  FOpTable[58].Op := 'TD'; FOpTable[58].NumArgs := 2;
  FOpTable[58].ArgChk[0] := acNumber; FOpTable[58].ArgChk[1] := acNumber;
  FOpTable[58].Operation := opTextMoveSet;

  FOpTable[59].Op := 'Tf'; FOpTable[59].NumArgs := 2;
  FOpTable[59].ArgChk[0] := acName; FOpTable[59].ArgChk[1] := acNumber;
  FOpTable[59].Operation := opSetFont;

  FOpTable[60].Op := 'Tj'; FOpTable[60].NumArgs := 1;
  FOpTable[60].ArgChk[0] := acString; FOpTable[60].Operation := opShowText;

  FOpTable[61].Op := 'TJ'; FOpTable[61].NumArgs := 1;
  FOpTable[61].ArgChk[0] := acArray; FOpTable[61].Operation := opShowSpaceText;

  FOpTable[62].Op := 'TL'; FOpTable[62].NumArgs := 1;
  FOpTable[62].ArgChk[0] := acNumber; FOpTable[62].Operation := opSetTextLeading;

  FOpTable[63].Op := 'Tm'; FOpTable[63].NumArgs := 6;
  FOpTable[63].ArgChk[0] := acNumber; FOpTable[63].ArgChk[1] := acNumber;
  FOpTable[63].ArgChk[2] := acNumber; FOpTable[63].ArgChk[3] := acNumber;
  FOpTable[63].ArgChk[4] := acNumber; FOpTable[63].ArgChk[5] := acNumber;
  FOpTable[63].Operation := opSetTextMatrix;

  FOpTable[64].Op := 'Tr'; FOpTable[64].NumArgs := 1;
  FOpTable[64].ArgChk[0] := acInteger; FOpTable[64].Operation := opSetTextRender;

  FOpTable[65].Op := 'Ts'; FOpTable[65].NumArgs := 1;
  FOpTable[65].ArgChk[0] := acNumber; FOpTable[65].Operation := opSetTextRise;

  FOpTable[66].Op := 'Tw'; FOpTable[66].NumArgs := 1;
  FOpTable[66].ArgChk[0] := acNumber; FOpTable[66].Operation := opSetWordSpacing;

  FOpTable[67].Op := 'Tz'; FOpTable[67].NumArgs := 1;
  FOpTable[67].ArgChk[0] := acNumber; FOpTable[67].Operation := opSetHorizScaling;

  FOpTable[68].Op := 'v'; FOpTable[68].NumArgs := 4;
  FOpTable[68].ArgChk[0] := acNumber; FOpTable[68].ArgChk[1] := acNumber;
  FOpTable[68].ArgChk[2] := acNumber; FOpTable[68].ArgChk[3] := acNumber;
  FOpTable[68].Operation := opCurveTo1;

  FOpTable[69].Op := 'w'; FOpTable[69].NumArgs := 1;
  FOpTable[69].ArgChk[0] := acNumber; FOpTable[69].Operation := opSetLineWidth;

  FOpTable[70].Op := 'W'; FOpTable[70].NumArgs := 0;
  FOpTable[70].ArgChk[0] := acNone; FOpTable[70].Operation := opClip;

  FOpTable[71].Op := 'W*'; FOpTable[71].NumArgs := 0;
  FOpTable[71].ArgChk[0] := acNone; FOpTable[71].Operation := opEOClip;

  FOpTable[72].Op := 'y'; FOpTable[72].NumArgs := 4;
  FOpTable[72].ArgChk[0] := acNumber; FOpTable[72].ArgChk[1] := acNumber;
  FOpTable[72].ArgChk[2] := acNumber; FOpTable[72].ArgChk[3] := acNumber;
  FOpTable[72].Operation := opCurveTo2;
end;

procedure TgtPDContentStream.InsertImage(AX, AY: Double; AStream: TStream;
  AImageFormat: TgtOutFormat; AInLine: Boolean;
  AWidth, AHeight: Double; AAngle: Integer);
var
  LImageObj, LObj1: TgtPDBaseObject;
  LDict: TgtPDDictionary;
  LgtMemStream: TgtMemoryStream;
  LMemStream: TMemoryStream;
  LBuffer: Bytes;
  LImageTag, LStr: AnsiString;
  LImage: TBitmap;
  LAngleInRadian, LPageAngle, LPageAngleInRadian: Extended;
  LDisplayRect: TgtPDRect;
  ImageLeft, ImageBottom, ImageAlpha, ImageLeftDx, ImageBottomDy,
    ImageDglDst: Double;
  LIsPageRotate: Boolean;  
begin
  LIsPageRotate := False;
  LStr := '';
  if not Assigned(TgtPDPage(FParentElement).Resource) then
  begin
    LObj1 := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDictionary(FParentElement.BaseObject).Add(PDF_RESOURCES, LObj1);
  end;
  LImage := TBitmap.Create;
  //check the image format...
  case AImageFormat of
    ofBMP:
      begin
        AStream.Position := 0;
        LImage.LoadFromStream(AStream);
        LMemStream := TMemoryStream(GetPDFBitmapStream(LImage));
      end;
    ofPPM:
      begin
        LMemStream := TMemoryStream.Create;
        TBitmap(LImage).LoadFromStream(AStream);
        LMemStream.LoadFromStream(AStream);
      end;
    ofPBM:
      begin
        LMemStream := TMemoryStream.Create;
        TBitmap(LImage).LoadFromStream(AStream);
        LMemStream.LoadFromStream(AStream);
      end;
    ofJPEG:
      begin
        LMemStream := TMemoryStream.Create;
        if Assigned(LImage) then FreeAndNil(LImage);
        TJPEGImage(LImage) := TJPEGImage.Create;
        AStream.Position := 0;
        LImage.LoadFromStream(AStream);
        LImage.SaveToStream(LMemStream);
      end;
  end;

  TranslateXY(AX, AY);

  LAngleInRadian := AAngle * (PI / 180);
  LDisplayRect := TgtPDRect.Create(AX, AY, AX + AWidth, AY + AHeight);

  LPageAngle := TgtPDPage(FParentElement).Rotate;
  LPageAngleInRadian := LPageAngle * (PI / 180);

  if ((LPageAngle <> 0) and (LPageAngle <> 360))  then
  begin
    LIsPageRotate := True;

    ImageLeft := AX;
    ImageBottom := ((TgtPDPage(FParentElement).GetPageHeight - AY) +
      (LDisplayRect.Bottom - LDisplayRect.Top));

    // Translate
    LStr := LStr + '1 0 0 1' + SP +
      FloatToStringF(ImageBottom) + SP + FloatToStringF(ImageLeft) + SP +
      'cm' + CRLF;
    // Rotate
    LStr := LStr + FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      '0 0' + SP + 'cm' + CRLF;
  end;

  if (AAngle = 0) or (AAngle = 360) then
  begin

    if LIsPageRotate then
    begin
      AX := 0;
      AY := 0;
    end
    else
      AY := Abs(AY - Abs(AHeight));

    LStr := LStr + 'q' + CRLF +
      '0 g 0 G' + CRLF +
      FloatToStrFLocale(Abs(AWidth), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(0, ffFixed, 10, 3) + SP +
      FloatToStrFLocale(0, ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Abs(AHeight), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(AX, ffFixed, 10, 3) + SP;
    LStr := LStr + FloatToStrFLocale(AY, ffFixed, 10, 3) + SP +
      'cm' + CRLF;
  end
  else
  begin
    ImageLeftDx := (AX - LDisplayRect.Left);
    ImageBottomDy := ((AY + AHeight) - LDisplayRect.Top);
    ImageDglDst := Sqrt((ImageLeftDx * ImageLeftDx) +
      (ImageBottomDy * ImageBottomDy));
    if ImageBottomDy = 0 then
      ImageAlpha := LAngleInRadian + PI
    else
      ImageAlpha := LAngleInRadian + ArcTan(ImageLeftDx / ImageBottomDy);
    ImageLeft := LDisplayRect.Left + (ImageDglDst * Sin(ImageAlpha));
    ImageBottom := LDisplayRect.Top - (ImageDglDst * Cos(ImageAlpha));

    LStr := LStr + 'q' + CRLF +
      '0 g 0 G' + CRLF;

    if LIsPageRotate then
    begin
      ImageLeft := 0;
      ImageBottom := 0;
    end;

    // Translate
    LStr := LStr + '1 0 0 1' + SP +
      FloatToStrFLocale(ImageLeft, ffFixed, 10, 3) + SP +
      FloatToStrFLocale(ImageBottom, ffFixed, 10, 3) + SP +
      'cm' + CRLF;

    // Rotate
    LStr := LStr + FloatToStrFLocale(Cos(LAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Sin(LAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(-Sin(LAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Cos(LAngleInRadian), ffFixed, 10, 3) + SP +
      '0 0' + SP + 'cm' + CRLF;
    // Scale
    LStr := LStr + FloatToStrFLocale(Abs(AWidth), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(0, ffFixed, 10, 3) + SP +
      FloatToStrFLocale(0, ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Abs(AHeight), ffFixed, 10, 3) + SP +
      '0 0' + SP + 'cm' + CRLF;
  end;

  LMemStream.Position := 0;
  if not (AInLine) then
  begin
    LgtMemStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
    LgtMemStream.Reset;

    LImageTag := TgtPDPage(FParentElement).Resource.GetResourceName(resXObject);

    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

    LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LDict.Add(PDF_TYPE, TgtPDName.Create(PDF_XOBJECT));
    LDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_IMAGE));
    LDict.Add(PDF_NAME, TgtPDName.Create(LImageTag));
    LDict.Add(PDF_WIDTH, TgtPDInteger.Create(LImage.Width));
    LDict.Add(PDF_HEIGHT, TgtPDInteger.Create(LImage.Height));
    LDict.Add(PDF_BITSPERCOMP, TgtPDInteger.Create(8));
    LDict.Add(PDF_COLORSPACE, TgtPDName.Create(PDF_DEVICERGB));
    LDict.Add(PDF_LENGTH, TgtPDInteger.Create(LgtMemStream.GetSize));

    if AImageFormat = ofJPEG then
      LDict.Add(PDF_Filter, TgtPDName.Create(PDF_DCTDecode));

    LImageObj := TgtPDStream.Create(LgtMemStream, LDict,
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);

    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LImageObj);
    TgtPDPage(FParentElement).AddResource(resXObject, LImageTag, LImageObj);

    LStr := LStr + '/' + LImageTag + ' ' + 'Do' + CRLF +
      'Q' + CRLF;
    TgtPDStream(FBaseObject).Write(LStr);
  end
  else
  begin
    LMemStream.Position := 0;

    LStr := LStr + 'BI' + CRLF +
      '/W' + ' ' + FloatToStringF(AWidth) + CRLF +
      '/H' + ' ' + FloatToStringF(AHeight) + CRLF +
      '/CS' + ' ' + '/RGB' + CRLF +
      '/BPC' + ' ' + '8' + CRLF;

    if AImageFormat = ofJPEG then
      LStr := LStr + '/F' + ' ' + 'DCT' + CRLF;

    LStr := LStr + 'ID' + CRLF;
    TgtPDStream(FBaseObject).Write(LStr);
    SetLength(LBuffer, LMemStream.Size);
    LMemStream.Read(LBuffer[0], LMemStream.Size);
    TgtPDStream(FBaseObject).Write(LBuffer, Length(LBuffer));
    LStr := CRLF + 'EI' + CRLF +
      'Q';
    TgtPDStream(FBaseObject).Write(LStr);
  end;
  if Assigned(LImage) then FreeAndNil(LImage);
  if AInLine then FreeAndNil(LMemStream);
  if Assigned(LDisplayRect) then FreeAndNil(LDisplayRect);
end;

procedure TgtPDContentStream.LineTo(AX, AY: Double);
var
  LStr: AnsiString;
begin
  TranslateXY(AX, AY);
  LStr := FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' ' + 'l' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.MoveTo(AX, AY: Double);
var
  LStr: AnsiString;
begin
  TranslateXY(AX, AY);
  LStr := FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' ' + 'm' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.OpBeginIgnoreUndef(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  Inc(FIgnoreUndef);
end;

procedure TgtPDContentStream.OpBeginImage(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LStrmObj: TgtPDBaseObject;
  LChar1, LChar2: Integer;
begin
  // build dict/stream
  LStrmObj := BuildImageStream;

  // display the image
  if Assigned(LStrmObj) then
  begin
    DoImage(nil, LStrmObj, True);

//    skip EI tag
    LChar1 := TgtPDStream(LStrmObj).GetStream.GetUndecodedStream.GetChar;
    LChar2 := TgtPDStream(LStrmObj).GetStream.GetUndecodedStream.GetChar;
    while (not ((AnsiChar(LChar1) = 'E') and (AnsiChar(LChar2) = 'I')) and (LChar2 <> ENDOFFILE)) do
    begin
      LChar1 := LChar2;
      LChar2 := TgtPDStream(LStrmObj).GetStream.GetUndecodedStream.GetChar;
    end;
    FreeAndNil(LStrmObj);
  end;
end;

procedure TgtPDContentStream.OpBeginMarkedContent(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpBeginText(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  FState.TextMatrix.SetValues(1, 0, 0, 1, 0, 0);
  FState.TextMoveTo(0, 0);

  FExportDev.UpdateTextMatrix(FState);
  FExportDev.UpdateTextPos(FState);

  FFontChanged := True;
end;

procedure TgtPDContentStream.OpClip(Args: TgtArgumentList; NumArgs: Integer);
begin
  FClip := clipNormal;
end;

procedure TgtPDContentStream.OpCloseEOFillStroke(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if (not FState.IsCurrentPoint) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No path in closepath/eofill/stroke');
{$ENDIF}
    Exit;
  end;

  if FState.IsCurrentPath then
  begin
    if Assigned(FState.FillColorSpace) and
      (FState.FillColorSpace.GetMode = csPattern) then
      DoPatternFill(True)
    else
      FExportDev.EvenOddFill(FState);

    if Assigned(FState.StrokeColorSpace) and
      (FState.StrokeColorSpace.GetMode = csPattern) then
      DoPatternStroke
    else
      FExportDev.Stroke(FState);
  end;
  DoEndPath;
end;

procedure TgtPDContentStream.OpCloseFillStroke(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No path in closepath/fill/stroke');
{$ENDIF}
    Exit;
  end;

  if FState.IsCurrentPath then
  begin
    FState.ClosePath;
    if Assigned(FState.FillColorSpace) and
      (FState.FillColorSpace.GetMode = csPattern) then
      DoPatternFill(False)
    else
      FExportDev.Fill(FState);
    if Assigned(FState.StrokeColorSpace) and
      (FState.StrokeColorSpace.GetMode = csPattern) then
      DoPatternStroke
    else
      FExportDev.Stroke(FState);
  end;
  DoEndPath;
end;

procedure TgtPDContentStream.OpClosePath(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No current point in closepath');
{$ENDIF}
    Exit;
  end;
  FState.ClosePath;
end;

procedure TgtPDContentStream.OpCloseStroke(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if not (FState.IsCurrentPoint) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No current point in closepath/stroke');
{$ENDIF}
    Exit;
  end;
  if FState.IsCurrentPath then
  begin
    FState.ClosePath;
    if Assigned(FState.StrokeColorSpace) and
      (FState.StrokeColorSpace.GetMode = csPattern) then
      DoPatternStroke
    else
      FExportDev.Stroke(FState);
  end;
  DoEndPath;
end;

procedure TgtPDContentStream.OpConcat(Args: TgtArgumentList; NumArgs: Integer);
var
  LMatrix: TgtPDMatrix;
  eM11, eM12, eM21, eM22, eDx, eDy: Double;
begin
  if Args[0].IsInteger then eM11 := TgtPDInteger(Args[0]).Value
  else eM11 := TgtPDReal(Args[0]).Value;

  if Args[1].IsInteger then eM12 := TgtPDInteger(Args[1]).Value
  else eM12 := TgtPDReal(Args[1]).Value;

  if Args[2].IsInteger then eM21 := TgtPDInteger(Args[2]).Value
  else eM21 := TgtPDReal(Args[2]).Value;

  if Args[3].IsInteger then eM22 := TgtPDInteger(Args[3]).Value
  else eM22 := TgtPDReal(Args[3]).Value;

  if Args[4].IsInteger then eDx := TgtPDInteger(Args[4]).Value
  else eDx := TgtPDReal(Args[4]).Value;

  if Args[5].IsInteger then eDy := TgtPDInteger(Args[5]).Value
  else eDy := TgtPDReal(Args[5]).Value;

  LMatrix := TgtPDMatrix.Create(eM11, eM12, eM21, eM22, eDx, eDy);
  FState.ConcatCTM(LMatrix);

  FExportDev.UpdateCTM(FState, LMatrix);
  FreeAndNil(LMatrix);

  FFontChanged := True;
end;

procedure TgtPDContentStream.OpCurveTo(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LObj1: TgtPDBaseObject;
  LX1, LY1, LX2, LY2, LX3, LY3: Double;
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No current point in curveto');
{$ENDIF}
    Exit;
  end;

  LObj1 := Args[0];
  if LObj1.IsReal then
    LX1 := TgtPDReal(LObj1).Value
  else
    LX1 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[1];
  if LObj1.IsReal then
    LY1 := TgtPDReal(LObj1).Value
  else
    LY1 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[2];
  if LObj1.IsReal then
    LX2 := TgtPDReal(LObj1).Value
  else
    LX2 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[3];
  if LObj1.IsReal then
    LY2 := TgtPDReal(LObj1).Value
  else
    LY2 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[4];
  if LObj1.IsReal then
    LX3 := TgtPDReal(LObj1).Value
  else
    LX3 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[5];
  if LObj1.IsReal then
    LY3 := TgtPDReal(LObj1).Value
  else
    LY3 := TgtPDInteger(LObj1).Value;

  FState.CurveTo(LX1, LY1, LX2, LY2, LX3, LY3);
end;

procedure TgtPDContentStream.OpCurveTo1(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LObj1: TgtPDBaseObject;
  LX1, LY1, LX2, LY2, LX3, LY3: Double;
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No current point in curveto1');
{$ENDIF}
    Exit;
  end;

  LX1 := FState.CurX;
  LY1 := FState.CurY;

  LObj1 := Args[0];
  if LObj1.IsReal then
    LX2 := TgtPDReal(LObj1).Value
  else
    LX2 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[1];
  if LObj1.IsReal then
    LY2 := TgtPDReal(LObj1).Value
  else
    LY2 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[2];
  if LObj1.IsReal then
    LX3 := TgtPDReal(LObj1).Value
  else
    LX3 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[3];
  if LObj1.IsReal then
    LY3 := TgtPDReal(LObj1).Value
  else
    LY3 := TgtPDInteger(LObj1).Value;

  FState.CurveTo(LX1, LY1, LX2, LY2, LX3, LY3);
end;

procedure TgtPDContentStream.OpCurveTo2(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LObj1: TgtPDBaseObject;
  LX1, LY1, LX2, LY2, LX3, LY3: Double;
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No current point in curveto2');
{$ENDIF}
    Exit;
  end;

  LObj1 := Args[0];
  if LObj1.IsReal then
    LX1 := TgtPDReal(LObj1).Value
  else
    LX1 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[1];
  if LObj1.IsReal then
    LY1 := TgtPDReal(LObj1).Value
  else
    LY1 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[2];
  if LObj1.IsReal then
    LX2 := TgtPDReal(LObj1).Value
  else
    LX2 := TgtPDInteger(LObj1).Value;

  LObj1 := Args[3];
  if LObj1.IsReal then
    LY2 := TgtPDReal(LObj1).Value
  else
    LY2 := TgtPDInteger(LObj1).Value;

  LX3 := LX2;
  LY3 := LY2;

  FState.CurveTo(LX1, LY1, LX2, LY2, LX3, LY3);
end;

procedure TgtPDContentStream.OpEndIgnoreUndef(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if (FIgnoreUndef > 0) then
    Dec(FIgnoreUndef);
end;

procedure TgtPDContentStream.OpEndImage(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpEndMarkedContent(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpEndPath(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  DoEndPath;
end;

procedure TgtPDContentStream.OpEndText(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  FExportDev.EndTextObject(FState);
end;

procedure TgtPDContentStream.OpEOClip(Args: TgtArgumentList; NumArgs: Integer);
begin
  FClip := clipEO;
end;

procedure TgtPDContentStream.OpEOFill(Args: TgtArgumentList; NumArgs: Integer);
begin
  if (not FState.IsCurrentPoint) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('No path in eofill');
    {$ENDIF}
    Exit;
  end;

  if (FState.IsCurrentPath) then
  begin
    if Assigned(FState.FillColorSpace) and
      (FState.FillColorSpace.GetMode = csPattern) then
      DoPatternFill(True)
    else
      FExportDev.EvenOddFill(FState);
  end;
  DoEndPath;
end;

procedure TgtPDContentStream.OpEOFillStroke(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if (not FState.IsCurrentPoint) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No path in eofill/stroke');
{$ENDIF}
    Exit;
  end;

  if (FState.IsCurrentPath) then
  begin
    if Assigned(FState.FillColorSpace) and
      (FState.FillColorSpace.GetMode = csPattern) then
      DoPatternFill(True)
    else
      FExportDev.EvenOddFill(FState);

    if Assigned(FState.StrokeColorSpace) and (
      FState.StrokeColorSpace.GetMode = csPattern) then
      DoPatternStroke
    else
      FExportDev.Stroke(FState);
  end;
  DoEndPath;
end;

procedure TgtPDContentStream.OpFill(Args: TgtArgumentList; NumArgs: Integer);
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No path in fill');
{$ENDIF}
    Exit;
  end;
  if FState.IsCurrentPath then
  begin
    if Assigned(FState.FillColorSpace) and
      (FState.FillColorSpace.GetMode = csPattern) then
      DoPatternFill(False)
    else
      FExportDev.Fill(FState);
  end;
  DoEndPath
end;

procedure TgtPDContentStream.OpFillStroke(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No current point in closepath');
{$ENDIF}
    Exit;
  end;
  if FState.IsCurrentPath then
  begin
    if Assigned(FState.FillColorSpace) and
      (FState.FillColorSpace.GetMode = csPattern) then
      DoPatternFill(False)
    else
      FExportDev.Fill(FState);
    if Assigned(FState.StrokeColorSpace) and
      (FState.StrokeColorSpace.GetMode = csPattern) then
      DoPatternStroke
    else
      FExportDev.Stroke(FState);
  end;
  DoEndPath;
end;

procedure TgtPDContentStream.OpImageData(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpLineTo(Args: TgtArgumentList; NumArgs: Integer);
var
  LObj1: TgtPDBaseObject;
  LX, LY: Double;
begin
  if not FState.IsCurrentPoint then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No current point in lineto');
{$ENDIF}
    Exit;
  end;

  LObj1 := Args[0];
  if LObj1.IsReal then
    LX := TgtPDReal(LObj1).Value
  else
    LX := TgtPDInteger(LObj1).Value;

  LObj1 := Args[1];
  if LObj1.IsReal then
    LY := TgtPDReal(LObj1).Value
  else
    LY := TgtPDInteger(LObj1).Value;

  FState.LineTo(LX, LY);
end;

procedure TgtPDContentStream.OpMarkPoint(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpMoveSetShowText(Args: TgtArgumentList;
  NumArgs: Integer);
var
  Tx, Ty: Double;
begin
  if not Assigned(FState.Font) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('No font in move/set/show');
    {$ENDIF}
    Exit;
  end;
  if FFontChanged then
  begin
    FExportDev.UpdateFont(FState);
    FFontChanged := False;
  end;

  if Args[0].IsInteger then FState.WordSpace := TgtPDInteger(Args[0]).Value
  else FState.WordSpace := TgtPDReal(Args[0]).Value;

  if Args[1].IsInteger then FState.CharSpace := TgtPDInteger(Args[1]).Value
  else FState.CharSpace := TgtPDReal(Args[1]).Value;

  Tx := FState.LineX;
  Ty := FState.LineY - FState.Leading;

  FState.TextMoveTo(Tx, Ty);

  FExportDev.UpdateWordSpace(FState);
  FExportDev.UpdateCharSpace(FState);
  FExportDev.UpdateTextPos(FState);

  FExportDev.BeginStringOp(FState);
  DoShowText(TgtPDString(Args[2]).Value);
  FExportDev.EndStringOp(FState);
end;

procedure TgtPDContentStream.OpMoveShowText(Args: TgtArgumentList;
  NumArgs: Integer);
var
  Tx, Ty: Double;
begin
  if not Assigned(FState.Font) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('No font in move/show');
    {$ENDIF}
    Exit;
  end;
  if FFontChanged then
  begin
    FExportDev.UpdateFont(FState);
    FFontChanged := False;
  end;

  Tx := FState.LineX;
  Ty := FState.LineY - FState.Leading;

  FState.TextMoveTo(Tx, Ty);
  FExportDev.UpdateTextPos(FState);

  FExportDev.BeginStringOp(FState);
  if TgtPDString(Args[0]).IsHexString then
    DoShowHexText(TgtPDString(Args[0]).Value)
  else
    DoShowText(TgtPDString(Args[0]).Value);
  FExportDev.EndStringOp(FState);
end;

procedure TgtPDContentStream.OpMoveTo(Args: TgtArgumentList; NumArgs: Integer);
var
  LObj1: TgtPDBaseObject;
  LX, LY: Double;
begin
  LObj1 := Args[0];
  if LObj1.IsReal then
    LX := TgtPDReal(LObj1).Value
  else
    LX := TgtPDInteger(LObj1).Value;

  LObj1 := Args[1];
  if LObj1.IsReal then
    LY := TgtPDReal(LObj1).Value
  else
    LY := TgtPDInteger(LObj1).Value;
  FState.MoveTo(LX, LY);
end;

procedure TgtPDContentStream.OpRectangle(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LX, LY, LW, LH: Double;
  LObj: TgtPDBaseObject;
begin
  LObj := Args[0];
  if LObj.IsReal then
    LX := TgtPDReal(LObj).Value
  else
    LX := TgtPDInteger(LObj).Value;

  LObj := Args[1];
  if LObj.IsReal then
    LY := TgtPDReal(LObj).Value
  else
    LY := TgtPDInteger(LObj).Value;

  LObj := Args[2];
  if LObj.IsReal then
    LW := TgtPDReal(LObj).Value
  else
    LW := TgtPDInteger(LObj).Value;

  LObj := Args[3];
  if LObj.IsReal then
    LH := TgtPDReal(LObj).Value
  else
    LH := TgtPDInteger(LObj).Value;

  FState.MoveTo(LX, LY);
  FState.LineTo(LX + LW, LY);
  FState.LineTo(LX + LW, LY + LH);
  FState.LineTo(LX, LY + LH);
  FState.ClosePath;
end;

procedure TgtPDContentStream.OpRestore(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  RestoreState;
end;

procedure TgtPDContentStream.OpSave(Args: TgtArgumentList; NumArgs: Integer);
begin
  SaveState;
end;

procedure TgtPDContentStream.OpSetCacheDevice(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpSetCharSpacing(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if Args[0].IsInteger then FState.CharSpace := TgtPDInteger(Args[0]).Value
  else FState.CharSpace := TgtPDReal(Args[0]).Value;

  FExportDev.UpdateCharSpace(FState);
end;

procedure TgtPDContentStream.OpSetCharWidth(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpSetDash(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LArray: TgtPDArray;
  LObj: TgtPDBaseObject;
  Length, LI: Integer;
  LDash: TgtDashArray;
  LStart: Double;
begin
  LArray := TgtPDArray(Args[0]);
  Length := LArray.GetLength;

  if Length = 0 then
  begin
    LDash := nil;
  end
  else
  begin
    SetLength(LDash, Length);
    for LI := 0 to Length - 1 do
    begin
      LObj := LArray.Get(LI);
      if LObj.IsReal then
        LDash[LI] := TgtPDReal(LObj).Value
      else
        LDash[LI] := TgtPDInteger(LObj).Value;
    end;
  end;

  LObj := Args[1];
  if LObj.IsReal then
    LStart := TgtPDReal(LObj).Value
  else
    LStart := TgtPDInteger(LObj).Value;

  FState.SetLineDash(LDash, Length, LStart);
  FExportDev.UpdateLineDash(FState);

  SetLength(LDash, 0);
end;

procedure TgtPDContentStream.OpSetExtGState(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LGState: TgtPDGState;
begin
  LGState := FPageResource.LookUpGState(TgtPDName(Args[0]).Value);

  if Assigned(LGState) then
  begin
    if LGState.StrokeAlpha <> -1 then
    begin
      FState.StrokeOpacity := LGState.StrokeAlpha;
      FExportDev.UpdateStrokeOpacity(FState);
    end
    else
      FExportDev.UpdateStrokeOpacity(FState);
    if LGState.NonStrokeAlpha <> -1 then
    begin
      FState.FillOpacity := LGState.NonStrokeAlpha;
      FExportDev.UpdateFillOpacity(FState);
    end
    else
      FExportDev.UpdateFillOpacity(FState);
  end;
end;

procedure TgtPDContentStream.OpSetFillCMYKColor(Args: TgtArgumentList;
  NumArgs: Integer);
var
  I: Integer;
  LColor: TgtColor;
begin
  InitColorObject(LColor);
  FState.FillColorSpace := TgtPDDeviceCMYKColorSpace.Create;
  FState.FillCSOwned := True;
  FExportDev.UpdateFillColorSpace(FState);
  for I := 0 to 3 do
  begin
    if Args[I].IsReal then
      LColor.Comps[i] := Round(TgtPDReal(Args[I]).Value * $10000)
    else
      LColor.Comps[i] := TgtPDInteger(Args[I]).Value * $10000;
  end;
  FState.SetFillColor(LColor);
  FExportDev.UpdateFillColor(FState);
end;

procedure TgtPDContentStream.OpSetFillColor(Args: TgtArgumentList;
  NumArgs: Integer);
var
  I: Integer;
  LColor: TgtColor;
begin
  InitColorObject(LColor);
//  if Assigned(FState.FillColorSpace) then
//  begin
//    if (NumArgs <> FState.FillColorSpace.GetNoOfComps) then
//    begin
//      {$IFDEF DEBUG}
//          Logger.LogError('Incorrect number of arguments in SC command');
//      {$ENDIF}
//      Exit;
//    end;
//    FState.FillPattern := nil;
  for I := 0 to NumArgs - 1 do
  begin
    if Args[I].IsReal then
      LColor.Comps[i] := Round(TgtPDReal(Args[I]).Value * $10000)
    else
      LColor.Comps[i] := TgtPDInteger(Args[I]).Value * $10000;
  end;
//  end;
  FState.SetFillColor(LColor);
  FExportDev.UpdateFillColor(FState);
end;

procedure TgtPDContentStream.OpSetFillColorN(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColor: TgtColor;
  LPattern: TgtPDPattern;
  LI: Integer;
  LColorSpace: TgtPDColorSpace;
begin
  InitColorObject(LColor);
  if Assigned(FState.FillColorSpace) and (FState.FillColorSpace.GetMode = csPattern) then
  begin
    if (NumArgs > 1) then
    begin
      LColorSpace := TgtPDPatternColorSpace(FState.FillColorSpace).GetUnder;
      if (not Assigned(LColorSpace)) or ((NumArgs - 1) <> LColorSpace.GetNoOfComps) then
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Incorrect number of arguments in "scn" command');
        {$ENDIF}
        Exit;
      end;
      LI := 0;
      while (LI < NumArgs) and (LI < ColorMapMaxComps) do
      begin
        if Args[LI].IsReal then
          LColor.Comps[LI] := Round(TgtPDReal(Args[LI]).Value * $10000)
        else
          LColor.Comps[LI] := TgtPDInteger(Args[LI]).Value * $10000;
        Inc(LI);
      end;
      FState.SetFillColor(LColor);
      FExportDev.UpdateFillColor(FState);
    end;

    if (Args[NumArgs - 1].IsName) then
    begin
      LPattern := FPageResource.LookUpPattern(TgtPDName(Args[NumArgs - 1]).Value);
      if Assigned(LPattern) then
        FState.FillPattern := LPattern;
    end;
  end
  else
  begin
    if Assigned(FState.FillColorSpace) and (NumArgs <> FState.FillColorSpace.GetNoOfComps) then
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Incorrect number of arguments in "scn" command');
    {$ENDIF}
      Exit;
    end;
    FState.FillPattern := nil;
    LI := 0;
    while (LI < NumArgs) and (LI < ColorMapMaxComps) do
    begin
      if Args[LI].IsReal then
        LColor.Comps[LI] := Round(TgtPDReal(Args[LI]).Value * $10000)
      else
        LColor.Comps[LI] := TgtPDInteger(Args[LI]).Value * $10000;
      Inc(LI);
    end;
    FState.SetFillColor(LColor);
    FExportDev.UpdateFillColor(FState);
  end;

end;

procedure TgtPDContentStream.OpSetFillColorSpace(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColor: TgtColor;
  LColorSpace: TgtPDColorSpace;
  LIsOwned: Boolean;
begin
  LIsOwned := False;
  InitColorObject(LColor);
  LColorSpace := nil;
  if Assigned(FPageResource) then
    LColorSpace := FPageResource.LookUpColorSpace(TgtPDName(Args[0]).Value);

  //The names DeviceGray, DeviceRGB, DeviceCMYK, and Pattern always identify
  //the corresponding color spaces directly; they never refer to resources in
  //the ColorSpace subdictionary
  if not Assigned(LColorSpace)  then
  begin
    if (TgtPDName(Args[0]).Value = PDF_DEVICERGB) then
    begin
      LColorSpace := TgtPDDeviceRGBColorSpace.Create;
      LIsOwned := True;
    end
    else if TgtPDName(Args[0]).Value = PDF_DEVICEGRAY then
    begin
      LColorSpace := TgtPDDeviceGrayColorSpace.Create;
      LIsOwned := True;
    end
    else if TgtPDName(Args[0]).Value = PDF_DEVICECMYK then
    begin
      LColorSpace := TgtPDDeviceCMYKColorSpace.Create;
      LIsOwned := True;
    end
    //This should be either tilling or shading pattern as a default
    else if TgtPDName(Args[0]).Value = PDF_PATTERN then
    begin
      LColorSpace := TgtPDPatternColorSpace.Create(nil);
      LIsOwned := True;
    end;    
  end;

  if Assigned(LColorSpace) then
  begin
    FState.FillColorSpace := LColorSpace;
    FState.FillCSOwned := LIsOwned;
    FExportDev.UpdateFillColorSpace(FState);
    LColorSpace.GetDefaultColor(LColor);
    FState.SetFillColor(LColor);
    FExportDev.UpdateFillColor(FState);
  end
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Bad color space (fill)');
{$ENDIF}
    Exit;
  end;
end;

procedure TgtPDContentStream.OpSetFillGray(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColor: TgtColor;
begin
  InitColorObject(LColor);
  FState.FillColorSpace := TgtPDDeviceGrayColorSpace.Create;
  FState.FillCSOwned := True;
  FExportDev.UpdateFillColorSpace(FState);
  if Args[0].IsInteger then
    LColor.Comps[0] := TgtPDInteger(Args[0]).Value * $10000
  else
    LColor.Comps[0] := Round(TgtPDReal(Args[0]).Value * $10000);
  FState.SetFillColor(LColor);
  FExportDev.UpdateFillColor(FState);
end;

procedure TgtPDContentStream.OpSetFillRGBColor(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColor: TgtColor;
  I: Integer;
begin
  InitColorObject(LColor);
  FState.FillColorSpace := TgtPDDeviceRGBColorSpace.Create;
  FState.FillCSOwned := True;
  FExportDev.UpdateFillColorSpace(FState);
  for I := 0 to 2 do
  begin
    if Args[I].IsReal then
      LColor.Comps[I] := Round(TgtPDReal(Args[I]).Value * $10000)
    else
      LColor.Comps[I] := TgtPDInteger(Args[I]).Value * $10000;
  end;
  FState.SetFillColor(LColor);
  FExportDev.UpdateFillColor(FState);
end;

procedure TgtPDContentStream.OpSetFlat(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LObj: TgtPDBaseObject;
begin
  LObj := Args[0];
  if LObj.IsReal then
    FState.Flatness := TgtPDReal(LObj).Value
  else
    FState.Flatness := TgtPDInteger(LObj).Value;

  FExportDev.UpdateFlatness(FState);
end;

procedure TgtPDContentStream.OpSetFont(Args: TgtArgumentList;
  NumArgs: Integer);
var
  Font: TgtPDFont;
begin
  Font := nil;
  if Assigned(FPageResource) then
    Font := FPageResource.LookUpFont(TgtPDName(Args[0]).Value);

  if not Assigned(Font) then
    Exit;

  FState.Font := Font;
  if Args[1].IsInteger then
    FState.FontSize := TgtPDInteger(Args[1]).Value
  else
    FState.FontSize := TgtPDReal(Args[1]).Value;
  FFontChanged := True;
end;

procedure TgtPDContentStream.OpSetHorizScaling(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if Args[0].IsInteger then FState.HorizScaling := TgtPDInteger(Args[0]).Value / 100
  else FState.HorizScaling := TgtPDReal(Args[0]).Value / 100;

  FExportDev.UpdateHorizScaling(FState);

  FFontChanged := True;
end;

procedure TgtPDContentStream.OpSetLineCap(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  FState.LineCap := TgtPDInteger(Args[0]).Value;
  FExportDev.UpdateLineCap(FState);
end;

procedure TgtPDContentStream.OpSetLineJoin(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  FState.LineJoin := TgtPDInteger(Args[0]).Value;
  FExportDev.UpdateLineJoin(FState);
end;

procedure TgtPDContentStream.OpSetLineWidth(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LObj: TgtPDBaseObject;
begin
  LObj := Args[0];
  if LObj.IsReal then
    FState.LineWidth := TgtPDReal(LObj).Value
  else
    FState.LineWidth := TgtPDInteger(LObj).Value;

  FExportDev.UpdateLineWidth(FState);
end;

procedure TgtPDContentStream.OpSetMiterLimit(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LObj: TgtPDBaseObject;
begin
  LObj := Args[0];
  if LObj.IsReal then
    FState.MiterLimit := TgtPDReal(LObj).Value
  else
    FState.MiterLimit := TgtPDInteger(LObj).Value;

  FExportDev.UpdateMiterLimit(FState);
end;

procedure TgtPDContentStream.OpSetRenderingIntent(Args: TgtArgumentList;
  NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpSetStrokeCMYKColor(Args: TgtArgumentList;
  NumArgs: Integer);
var
  I: Integer;
  LColor: TgtColor;
begin
  InitColorObject(LColor);
  FState.StrokeColorSpace := TgtPDDeviceCMYKColorSpace.Create;
  FState.StrokeCSOwned := True;

  FExportDev.UpdateStrokeColorSpace(FState);
  for I := 0 to 3 do
  begin
    if Args[I].IsReal then
      LColor.Comps[I] := Round(TgtPDReal(Args[I]).Value * $10000)
    else
      LColor.Comps[I] := TgtPDInteger(Args[I]).Value * $10000;
  end;
  FState.SetStrokeColor(LColor);
  FExportDev.UpdateStrokeColor(FState);
end;

procedure TgtPDContentStream.OpSetStrokeColor(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LI: Integer;
  LColor: TgtColor;
begin
  InitColorObject(LColor);
  if Assigned(FState.StrokeColorSpace) and
    (NumArgs <> FState.StrokeColorSpace.GetNoOfComps) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Incorrect number of arguments in "SC" command');
    {$ENDIF}
    Exit;
  end;
  FState.StrokePattern := nil;
  for LI := 0 to NumArgs - 1 do
  begin
    if TgtPDBaseObject(Args[LI]).IsReal then
      LColor.Comps[LI] := Round(TgtPDReal(Args[LI]).Value * $10000)
    else
      LColor.Comps[LI] := TgtPDInteger(Args[LI]).Value * $10000;
  end;
  FState.SetStrokeColor(LColor);
  FExportDev.UpdateStrokeColor(FState);
end;

procedure TgtPDContentStream.OpSetStrokeColorN(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColorSpace: TgtPDColorSpace;
  LColor: TgtColor;
  LPattern: TgtPDPattern;
  LI: Integer;
begin
  if Assigned(FState.StrokeColorSpace) and
    (FState.StrokeColorSpace.GetMode = csPattern) then
  begin
    InitColorObject(LColor);
    if (NumArgs > 1) then
    begin
      LColorSpace := TgtPDPatternColorSpace(FState.StrokeColorSpace).GetUnder;
      if (not Assigned(LColorSpace)) or ((NumArgs - 1) <> (LColorSpace.GetNoOfComps)) then
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Incorrect number of arguments in "SCN" command');
        {$ENDIF}
        Exit;
      end;
      LI := 0;
      while (LI < (NumArgs - 1)) and (LI < ColorMapMaxComps) do
      begin
        if Args[LI].IsNumber then
          LColor.Comps[LI] := TgtPDInteger(Args[LI]).Value * $10000;
        Inc(LI);
      end;
      FState.SetStrokeColor(LColor);
      FExportDev.UpdateStrokeColor(FState);
    end;
    if Args[NumArgs - 1].IsName then
    begin
      LPattern := FPageResource.LookUpPattern(TgtPDName(Args[NumArgs - 1]).Value);
      if Assigned(LPattern) then
      begin
        FState.StrokePattern := LPattern;
      end;
    end;
  end
  else
  begin
    if Assigned(FState.StrokeColorSpace) and
      (NumArgs <> FState.StrokeColorSpace.GetNoOfComps) then
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Incorrect number of arguments in "SCN" command');
    {$ENDIF}
      Exit;
    end;
    FState.StrokePattern := nil;
    LI := 0;
    while (LI < NumArgs) and (LI < ColorMapMaxComps) do
    begin
      if Args[LI].IsReal then
        LColor.Comps[LI] := Round(TgtPDReal(Args[LI]).Value * $10000)
      else
        LColor.Comps[LI] := TgtPDInteger(Args[LI]).Value * $10000;
      Inc(LI);
    end;
    FState.SetStrokeColor(LColor);
    FExportDev.UpdateStrokeColor(FState);
  end;
end;

procedure TgtPDContentStream.OpSetStrokeColorSpace(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColorSpace: TgtPDColorSpace;
  LColor: TgtColor;
  LIsOwned: Boolean;
begin
  InitColorObject(LColor);
  LColorSpace := nil;
  LIsOwned := False;
  if Assigned(FPageResource) then
    LColorSpace := FPageResource.LookUpColorSpace(TgtPDName(Args[0]).Value);

  //The names DeviceGray, DeviceRGB, DeviceCMYK, and Pattern always identify
  //the corresponding color spaces directly; they never refer to resources in
  //the ColorSpace subdictionary    
  if not Assigned(LColorSpace) then
  begin
    if (TgtPDName(Args[0]).Value = PDF_DEVICERGB) then
    begin
      LColorSpace := TgtPDDeviceRGBColorSpace.Create;
      LIsOwned := True;
    end
    else if TgtPDName(Args[0]).Value = PDF_DEVICEGRAY then
    begin
      LColorSpace := TgtPDDeviceGrayColorSpace.Create;
      LIsOwned := True;
    end
    else if TgtPDName(Args[0]).Value = PDF_DEVICECMYK then
    begin
      LColorSpace := TgtPDDeviceCMYKColorSpace.Create;
      LIsOwned := True;
    end
    //This should be either tilling or shading pattern as a default
    else if TgtPDName(Args[0]).Value = PDF_PATTERN then
    begin
      LColorSpace := TgtPDPatternColorSpace.Create(nil);
      LIsOwned := True;
    end;
  end;

  if Assigned(LColorSpace) then
  begin
    FState.StrokeColorSpace := LColorSpace;
    FState.StrokeCSOwned := LIsOwned;
    FExportDev.UpdateStrokeColorSpace(FState);
    LColorSpace.GetDefaultColor(LColor);
    FState.SetStrokeColor(LColor);
    FExportDev.UpdateStrokeColor(FState);
  end
  else
{$IFDEF DEBUG}
    Logger.LogError('Bad color space (stroke)');
{$ENDIF}
end;

procedure TgtPDContentStream.OpSetStrokeGray(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColor: TgtColor;
begin
  InitColorObject(LColor);
  FState.StrokeColorSpace := TgtPDDeviceGrayColorSpace.Create;
  FState.StrokeCSOwned := True;
  FExportDev.UpdateStrokeColorSpace(FState);
  if Args[0].IsInteger then
    LColor.Comps[0] := TgtPDInteger(Args[0]).Value * $10000
  else
    LColor.Comps[0] := Round(TgtPDReal(Args[0]).Value * $10000);
  FState.SetStrokeColor(LColor);
  FExportDev.UpdateStrokeColor(FState);
end;

procedure TgtPDContentStream.OpSetStrokeRGBColor(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LColor: TgtColor;
  I: Integer;
begin
  InitColorObject(LColor);
  FState.StrokeColorSpace := TgtPDDeviceRGBColorSpace.Create;
  FState.StrokeCSOwned := True;
  FExportDev.UpdateStrokeColorSpace(FState);
  for I := 0 to 2 do
  begin
    if Args[I].IsReal then
      LColor.Comps[I] := Round(TgtPDReal(Args[I]).Value * $10000)
    else
      LColor.Comps[I] := TgtPDInteger(Args[I]).Value * $10000;
  end;
  FState.SetStrokeColor(LColor);
  FExportDev.UpdateStrokeColor(FState);
end;

procedure TgtPDContentStream.OpSetTextLeading(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if Args[0].IsInteger then
    FState.Leading := TgtPDInteger(Args[0]).Value
  else
    FState.Leading := TgtPDReal(Args[0]).Value;
end;

procedure TgtPDContentStream.OpSetTextMatrix(Args: TgtArgumentList;
  NumArgs: Integer);
var
//  LMatrix: TgtPDMatrix;
  eM11, eM12, eM21, eM22, eDx, eDy: Double;
begin
  if Args[0].IsInteger then eM11 := TgtPDInteger(Args[0]).Value
  else eM11 := TgtPDReal(Args[0]).Value;

  if Args[1].IsInteger then eM12 := TgtPDInteger(Args[1]).Value
  else eM12 := TgtPDReal(Args[1]).Value;

  if Args[2].IsInteger then eM21 := TgtPDInteger(Args[2]).Value
  else eM21 := TgtPDReal(Args[2]).Value;

  if Args[3].IsInteger then eM22 := TgtPDInteger(Args[3]).Value
  else eM22 := TgtPDReal(Args[3]).Value;

  if Args[4].IsInteger then eDx := TgtPDInteger(Args[4]).Value
  else eDx := TgtPDReal(Args[4]).Value;

  if Args[5].IsInteger then eDy := TgtPDInteger(Args[5]).Value
  else eDy := TgtPDReal(Args[5]).Value;

  FState.TextMatrix.SetValues(eM11, eM12, eM21, eM22, eDx, eDy);
  FState.TextMoveTo(0, 0);

  FExportDev.UpdateTextMatrix(FState);
  FExportDev.UpdateTextPos(FState);
  FFontChanged := True;
end;

procedure TgtPDContentStream.OpSetTextRender(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if Args[0].IsInteger then FState.Render := TgtPDInteger(Args[0]).Value
  else FState.Render := TgtPDReal(Args[0]).Value;

  FExportDev.UpdateRender(FState);
end;

procedure TgtPDContentStream.OpSetTextRise(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if Args[0].IsInteger then FState.Rise := TgtPDInteger(Args[0]).Value
  else FState.Rise := TgtPDReal(Args[0]).Value;

  FExportDev.UpdateRise(FState);
end;

procedure TgtPDContentStream.OpSetWordSpacing(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if Args[0].IsInteger then FState.WordSpace := TgtPDInteger(Args[0]).Value
  else FState.WordSpace := TgtPDReal(Args[0]).Value;

  FExportDev.UpdateWordSpace(FState);
end;

procedure TgtPDContentStream.OpShFill(Args: TgtArgumentList; NumArgs: Integer);
begin

end;

procedure TgtPDContentStream.OpShowSpaceText(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LArray: TgtPDArray;
  LObj: TgtPDBaseObject;
  LwMode: TgtWritingMode;
  I: Integer;
  LShift: Double;
begin
  if not Assigned(FState.Font) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('No font in show/space');
    {$ENDIF}
    Exit;
  end;
  if FFontChanged then
  begin
    FExportDev.UpdateFont(FState);
    FFontChanged := False;
  end;

  FExportDev.BeginStringOp(FState);
  LwMode := FState.Font.WritingMode;
  LArray := TgtPDArray(Args[0]);

  for I := 0 to LArray.GetLength - 1 do
  begin
    LObj := LArray.Get(I);
    if LObj.IsNumber then
    begin
      if LObj.IsInteger then LShift := TgtPDInteger(LObj).Value
      else LShift := TgtPDReal(LObj).Value;

      if LwMode = wmVertical then
        FState.TextShift(0, -1 * LShift * 0.001 * Abs(FState.FontSize))
      else
        FState.TextShift(-1 * LShift * 0.001 * Abs(FState.FontSize), 0);

      FExportDev.UpdateTextShift(FState, LShift);
    end
    else if LObj.IsString then
    begin
      if TgtPDString(LObj).IsHexString then
        DoShowHexText(TgtPDString(LObj).Value)
      else
        DoShowText(TgtPDString(LObj).Value);
    end
    else
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Element of show/space array must be number or AnsiString');
    {$ENDIF}
    end;
  end;

  FExportDev.EndStringOp(FState);
end;

procedure TgtPDContentStream.OpShowText(Args: TgtArgumentList;
  NumArgs: Integer);
begin
  if not Assigned(FState.Font) then
  begin
  {$IFDEF DEBUG}
    Logger.LogError('No font in show');
  {$ENDIF}
    Exit;
  end;
  if FFontChanged then
  begin
    FExportDev.UpdateFont(FState);
    FFontChanged := False;
  end;
  FExportDev.BeginStringOp(FState);

  if TgtPDString(Args[0]).IsHexString then
    DoShowHexText(TgtPDString(Args[0]).Value)
  else
    DoShowText(TgtPDString(Args[0]).Value);
  FExportDev.EndStringOp(FState);
end;

procedure TgtPDContentStream.OpStroke(Args: TgtArgumentList; NumArgs: Integer);
begin
  if not (FState.IsCurrentPoint) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('No path in stroke');
{$ENDIF}
    Exit;
  end;
  if (FState.IsCurrentPath) then
  begin
    if Assigned(FState.StrokeColorSpace) and
      (FState.StrokeColorSpace.GetMode = csPattern) then
      DoPatternStroke
    else
      FExportDev.Stroke(FState);
  end;
  DoEndPath;
end;

procedure TgtPDContentStream.OpTextMove(Args: TgtArgumentList;
  NumArgs: Integer);
var
  Lx, Ly: Double;
begin
  if Args[0].IsInteger then Lx := TgtPDInteger(Args[0]).Value
  else Lx := TgtPDReal(Args[0]).Value;

  if Args[1].IsInteger then Ly := TgtPDInteger(Args[1]).Value
  else Ly := TgtPDReal(Args[1]).Value;

  LX := FState.LineX + LX;
  Ly := FState.LineY + Ly;

  FState.TextMoveTo(Lx, Ly);
  FExportDev.UpdateTextPos(FState);
end;

procedure TgtPDContentStream.OpTextMoveSet(Args: TgtArgumentList;
  NumArgs: Integer);
var
  Lx, Ly: Double;
begin
  if Args[0].IsInteger then Lx := TgtPDInteger(Args[0]).Value
  else Lx := TgtPDReal(Args[0]).Value;

  if Args[1].IsInteger then Ly := TgtPDInteger(Args[1]).Value
  else Ly := TgtPDReal(Args[1]).Value;

  LX := FState.LineX + LX;
//  Not sure why text lead is set to -LY, need to verify
//  FState.Leading := -Ly;
  Ly := FState.LineY + Ly;

  FState.TextMoveTo(Lx, Ly);
  FExportDev.UpdateTextPos(FState);
end;

procedure TgtPDContentStream.OpTextNextLine(Args: TgtArgumentList;
  NumArgs: Integer);
var
  Tx, Ty: Double;
begin
  Tx := FState.LineX;
  Ty := FState.CurY - State.Leading;

  FState.TextMoveTo(Tx, Ty);

  FExportDev.UpdateTextPos(FState);
end;

procedure TgtPDContentStream.OpXObject(Args: TgtArgumentList;
  NumArgs: Integer);
var
  LString: AnsiString;
  LXObj: TgtPDXObject;
begin
  LString := TgtPDString(Args[0]).Value;
  LXObj := FPageResource.LookUpXObject(LString);

  if Assigned(LXObj) then
  begin
    if LXObj.SubType = xtImage then
    begin
      FExportDev.DrawImage(FState, LXObj as TgtPDImage);
    end
    else if LXObj.SubType = xtForm then
    begin
      FExportDev.DrawFormXObject(State, LXObj as TgtPDForm);
    end
    else
    begin

    end;
  end;
end;



procedure TgtPDContentStream.Rectangle(X1, Y1, X2, Y2: Double);
var
  LStr: WideString;
begin
  TranslateXY(X1, Y1);
  TranslateXY(X2, Y2);
  LStr := '';
  LStr := FloatToStringLocale(X1) + ' ' + FloatToStringLocale(Y1 - (Y1 - Y2))
    + ' ' + FloatToStringLocale((X2 - X1)) + ' ' +
    FloatToStringLocale((Y1 - Y2))
    + ' ' + 're' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.Restore;
begin
  TgtPDStream(FBaseObject).Write('Q' + CRLF);
end;

procedure TgtPDContentStream.RestoreState;
begin
  FState := FState.Restore;
  FExportDev.RestoreState(FState);
end;

procedure TgtPDContentStream.Save;
begin
  TgtPDStream(FBaseObject).Write('q' + CRLF);
end;

procedure TgtPDContentStream.SaveState;
begin
  FExportDev.SaveState(FState);
  FState := FState.Save;
end;

procedure TgtPDContentStream.SetBrushColor(AR, AG, AB: Byte);
var
  LStr: AnsiString;
begin
  LStr := ColorToPDFColor(AR, AG, AB) + ' ' + 'rg' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.SetBrushStyle(aBrush: TBrush);
//var
//  LStr: string;
begin
//  LStr := '/CSP cs ' + ColorToPDFColor(GetRValue(aBrush.Color), GetGValue(aBrush.Color),
//    GetBValue(aBrush.Color)) + ' /' + GetPattern(aBrush.Style) + ' scn';
//  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.SetDashPattern;
const
	LineType: array[0..8] of String = ('[]0', '[16 8]0', '[3 4]0',
		'[8 4 2 4]0', '[8 4 2 4 2 8]0', '', '', '', '');
var
  Lstr: string;
begin
  Lstr := LineType[ord(FPenStyle)];
	if Lstr <> '' then
		Lstr := Lstr + ' d ';
  case FPenJoinStyle of
    pjsBevel:
      Lstr := Lstr +  '2 j ';
    pjsMiter :
      Lstr := Lstr + '0 j ';
    pjsRound:
      Lstr := Lstr + '1 j ';
  end;
  case FPenCapStyle of
    pcsRound:
      Lstr := Lstr + '1 J ';
    pcsSquare:
      Lstr := Lstr + '2 J ';
    pcsFlat:
      Lstr := Lstr + '0 J ';
  end;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.SetOpacity(AStrokeValue, AFillValue: Integer);
var
  LObj1, LObj2: TgtPDBaseObject;
  LDict: TgtPDDictionary;
  LTag, LStr: AnsiString;
  LGState: TgtPDGState;
begin
  //if page does not have a resource dict
  if not Assigned(TgtPDPage(FParentElement).Resource) then
  begin
    //create a resource dict
    LObj1 := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    //add it to the page dict
    TgtPDDictionary(ParentElement.BaseObject).Add(PDF_RESOURCES, LObj1);
  end;

  if FPrevGStateTag <> '' then
  begin
    LGState := TgtPDPage(FParentElement).Resource.LookUpGState(FPrevGStateTag);
    if Assigned(LGState) then
    begin
      if (LGState.StrokeAlpha = (AFillValue / 100)) and 
        (LGState.NonStrokeAlpha = (AStrokeValue /100)) then
      begin
        LStr := '/' + LGState.Tag + ' ' + 'gs' + CRLF;
        TgtPDStream(FBaseObject).Write(LStr);  
      end
      else
      begin
        //get the GState resource name
        LTag := TgtPDPage(FParentElement).Resource.GetResourceName(resExtGState);
        FPrevGStateTag := LTag;
        //create graphics state dict
        TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
        TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
        LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
          TgtPDDocument(FParentDoc).BaseDoc);
        //add the required entries in to the GState dict
        LDict.Add(PDF_TYPE, TgtPDName.Create(PDF_EXTGSTATE));
        LDict.Add(PDF_SMALLCA, TgtPDReal.Create((AFillValue) / 100));
        LDict.Add(PDF_CA, TgtPDReal.Create((AStrokeValue) / 100));

        TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LDict);
        
        //Add the GState dict to Page Resource
        TgtPDPage(FParentElement).AddResource(resExtGState, LTag, LDict);

        LStr := '/' + LTag + ' ' + 'gs' + CRLF;
        TgtPDStream(FBaseObject).Write(LStr);
      end;
    end;
  end
  else
  begin
    //get the GState resource name
    LTag := TgtPDPage(FParentElement).Resource.GetResourceName(resExtGState);
    FPrevGStateTag := LTag;
    //create graphics state dict
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
    LDict := TgtPDDictionary.Create(
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    //add the required entries in to the GState dict
    LDict.Add(PDF_TYPE, TgtPDName.Create(PDF_EXTGSTATE));
    LDict.Add(PDF_SMALLCA, TgtPDReal.Create((AFillValue) / 100));
    LDict.Add(PDF_CA, TgtPDReal.Create((AStrokeValue) / 100));

    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LDict);
    //Add the GState dict to Page Resource
    TgtPDPage(FParentElement).AddResource(resExtGState, LTag, LDict);

    LStr := '/' + LTag + ' ' + 'gs' + CRLF;
    TgtPDStream(FBaseObject).Write(LStr);
  end;
end;

procedure TgtPDContentStream.SetPenColor(AR, AG, AB: Byte);
var
  LStr: AnsiString;
begin
  LStr := ColorToPDFColor(AR, AG, AB) + ' ' + 'RG' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.SetPenWidth(AValue: Double);
var
  LStr: AnsiString;
begin
  LStr := FloatToStringLocale(AValue) + ' ' + 'w' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.SetTextRenderMode(AValue: TTextRenderMode);
var
  LStr: AnsiString;
begin
  LStr := IntToStr(Ord(AValue)) + ' ' + 'Tr' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.StartContentParsing;
var
  LObj: TgtPDBaseObject;
  I: Integer;
begin
  LObj := FParser.GetObject;
  while not LObj.IsEOF do
  begin
    if LObj.IsCommand then
    begin
      ExecuteOp(LObj, Args, NumArgs);
      FreeAndNil(LObj);
      for I := 0 to NumArgs - 1 do
      begin
        try
          FreeAndNil(Args[I]);
        except

        end;
      end;
      NumArgs := 0;
    end
    else if NumArgs < MAXARGS then
    begin
      Args[NumArgs] := LObj;
      Inc(NumArgs);
    end
    else
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Too many args in content stream');
      {$ENDIF}
      FreeAndNil(LObj);
    end;
    LObj := FParser.GetObject;
  end;
  FreeAndNil(LObj);
end;

function TgtPDContentStream.StringToEscapeWideString(AString: WideString;
  out ALineNos: Integer; out ALineStrings: TArray): WideString;
var
  LK, LJ: Integer;
  Ltempstr: WideString;
begin
  Result := '';
  Ltempstr := '';
  ALineNos := 0;
  LJ := 0;
  for LK := 1 to Length(AString) do
  begin
    case AString[LK] of
      '(': Result := Result + '\(';
      ')': Result := Result + '\)';
      '\': Result := Result + '\\';
      #13:
      begin
//       if (AString[LK + 1] <> #10) then
//         Result := Result + ')Tj T* ('
//       else
        Result := Result + '';
      end;
      #10: Result := Result + ''{Result := Result + ')Tj T* ('};
      #9: Result := Result + '        ';//8 spaces
      #8: Result := Result + '';
      #12: Result := Result + '';
    else Result := Result + AString[LK];
    end;

    if ((AString[LK] = #10) or ((AString[LK] = #13) and (AString[LK + 1] <> #10))) then
    begin
      Inc(ALineNos);
      SetLength(ALineStrings, Length(ALineStrings) + 1);
      ALineStrings[LJ] := Ltempstr;
      Ltempstr := '';
      Inc(LJ);
    end
    else if (AString[LK] <> #13) then
      Ltempstr := Ltempstr + AString[LK];

    if LK >= Length(AString) then
    begin
      Inc(ALineNos);
      SetLength(ALineStrings, Length(ALineStrings) + 1);
      ALineStrings[LJ] := Ltempstr;
      Ltempstr := '';
    end;
  end;
end;

procedure TgtPDContentStream.StrokePath;
var
  LStr: AnsiString;
begin
  LStr := 'S' + CRLF;
  TgtPDStream(FBaseObject).Write(LStr);
end;

procedure TgtPDContentStream.TextOut(const Text: WideString; AFont: TgtFont;
  aX, aY: Double; AWritingMode: TgtWritingMode = wmHorizontal; AAngle: Integer = 0);
var
  LStr, LFontTag: WideString;
  LgtPDFont: TgtPDFont;
  LFont: TFont;
  LFontObj: TgtPD8bitFont;
  LI, LMLineNos, LPageAngle: Integer;
  LIsExist: Boolean;
  LX1, LY1, LX2, LY2: Double;
  LUnderscorePos, LUnderscoreSize,
    LStrikeOutPos, LTextWidth, LTextHeight, LCharSpace: Double;
  LAngleInRadian, LPageAngleInRadian: Double;
  LTxtY1, LTxtX1, LTxtDy, LTxtDgl, LTxtAlpha, LCosA, LSinA,
    LTxtLeft, LTxtBottom: Double;
  LMLineStrings: TArray;

  function WriteTextAsPDFString(AX, AY: Double; AFontSize: Integer;
    AFontTag, AText: WideString): AnsiString;
  begin
    Result := 'BT' + CRLF +
      FloatToStrFLocale(LCharSpace, ffFixed, 18, 8) + SP + 'Tc' + CRLF +
      '0 Tw 100 Tz' + SP + IntToStr(AFontSize) + SP + 'TL' + CRLF +
      '/' + AFontTag + ' ' + IntToStr(AFontSize) + ' ' + 'Tf' +
      CRLF + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' ' + 'Td' +
      CRLF + '(' + AText + ')' + ' ' + 'Tj' +
      CRLF + 'ET' + CRLF;
  end;

  procedure ProcessFontStyles(AX, AY, APos, AUnderscoreSize, ATextWidth: Double;
    APenColor: TColor);
  begin
    LX1 := AX;

    if fsUnderline in AFont.Style then
      LY1 := AY + (APos + AUnderscoreSize)
    else if fsStrikeOut in AFont.Style then
      LY1 := AY + (APos + AUnderscoreSize);

    LX2 := AX + ATextWidth;

    LY2 := LY1;

    SetPenColor(GetRValue(ColorToRGB(APenColor)),
      GetGValue(ColorToRGB(APenColor)),
      GetBValue(ColorToRGB(APenColor)));

    SetPenWidth(AUnderscoreSize / 2);//Check

    MoveTo(LX1, LY1);
    LineTo(LX2, LY2);
    StrokePath;
  end;

begin
  LFontTag := '';
  LIsExist := False;
  LgtPDFont := nil;
  LCharSpace := 0;
  LFont := TFont.Create;
  LFont.Name := aFont.Name;
  LFont.Size := aFont.Size;
  LFont.Color := aFont.Color;
  LFont.Style := aFont.Style;

  LFontObj := TgtPD8bitFont.Create(FParentDoc,
    TgtPDPage(FParentElement).Resource, aFont);

  try

    if LFontObj.Name = '' then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Error in creating Font object');
      {$ENDIF}
      Exit;
    end;
    //  LCharSpace := LFontObj.GetPDFCharSpacing(RemoveTerminalCRLF(Text), AFont.Size);

    LUnderscoreSize := (72 / 96) * (LFontObj.UnderscoreSize);
    LUnderscorePos := (72 / 96) * (LFontObj.UnderscorePosition);
    LTextHeight := LFontObj.GetHeight(Text, LFont);
    LStrikeOutPos := (72 / 96) * (((LFontObj.Ascent + LFontObj.Descent) / 64) / 2);

    //Checks if the required font already exist
    //Traverse through all the pages
  //  for LI := 1 to TgtPDDocument(FParentDoc).PageCount do
  //  begin
  //    //In each page check if font resource exist
  //    if Assigned(TgtPDDocument(FParentDoc).Pages[LI].Resource) then
  //    begin
  //      LgtPDFont := TgtPDDocument(FParentDoc).Pages[LI].Resource.
  //        GetFontByName(LFontObj.Name);
  //      if Assigned(LgtPDFont) then
  //      begin
  //        LIsExist := True;
  //        Break;
  //      end;
  //    end;
  //  end;

  //  //Traverse through the current page resource
  //  if Assigned(TgtPDPage(FParentElement).Resource) then
  //  begin
  //    LgtPDFont := TgtPDPage(FParentElement).Resource.GetFontByName(LFontObj.Name);
  //    if Assigned(LgtPDFont) then
  //    begin
  //      LIsExist := True;
  //    end;
  //  end;

    //If the required font does not exist in the entire document
    if LIsExist = False then
    begin
      //get the tag name for the newly added font obj
      LFontObj.Tag := TgtPDPage(FParentElement).Resource.GetResourceName(resFont);
      LFontTag := LFontObj.Tag;
      //create a font dict and add indirect ref to
      LFontObj.CreateFontDict;
      //Add the new font obj
      TgtPDPage(FParentElement).AddResource(resFont, LFontTag, LFontObj.BaseObject);
    end
    else
    begin
      //If the required font does not exist in the current page
      if (TgtPDPage(FParentElement).Resource.LookUpFont(LgtPDFont.Tag) = nil) then
      TgtPDPage(FParentElement).AddResource(resFont, LgtPDFont.Tag, LgtPDFont.BaseObject);
      LFontTag := LgtPDFont.Tag;
    end;

    LTxtY1 := aY;
    LTxtX1 := aX;

    aY := Abs(aY - (AFont.Size * (72 / 96)));

    //if Page mediabox or cropbox's, left and top, does not start with (0,0) origin
    TranslateXY(aX, aY);

    LPageAngle := TgtPDPage(FParentElement).Rotate;

    LPageAngleInRadian := LPageAngle * (PI / 180);
    LAngleInRadian := AAngle * (PI / 180);

    LCosA := Cos(LAngleInRadian);
    LSinA := Sin(LAngleInRadian);

    {--------------Page Rotation-------------------}

    if ((LPageAngle <> 0) and (LPageAngle <> 360))  then
    begin
      case LPageAngle of
        90:
        begin
          LTxtLeft := LTxtX1;
          LTxtBottom := (TgtPDPage(FParentElement).GetPageWidth - LTxtY1) +
            (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
        180:
        begin
          LTxtLeft := (TgtPDPage(FParentElement).GetPageWidth - LTxtX1);
          LTxtBottom := (TgtPDPage(FParentElement).GetPageHeight - LTxtY1) +
            (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
        270:
        begin
          LTxtLeft := (TgtPDPage(FParentElement).GetPageHeight - LTxtX1);
          LTxtBottom := LTxtY1 - (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
      end;

      aX := 0;
      aY := 0;
      LTxtY1 := 0;
      //LTxtX1 := 0;
    end;

    {--------------Vertical rendering of text-------------------}
    if (AWritingMode = wmVertical) then
    begin

      for LI := 1 to Length(Text) do
      begin
        LStr := LStr + WriteTextAsPDFString(aX, aY, AFont.Size, LFontTag, Text[LI]);

        LTextWidth := LFontObj.GetWidth(Text[LI], LFont);
        //underline & Strikeout
        if (Text[LI] <> ' ') then
        begin
          if fsUnderline in AFont.Style then
            ProcessFontStyles(aX, aY, LUnderscorePos, LUnderscoreSize, LTextWidth,
              AFont.Color);

          if fsStrikeOut in AFont.Style then
            ProcessFontStyles(aX, aY, LStrikeOutPos, LUnderscoreSize, LTextWidth,
              AFont.Color);
        end;
        //if text rotation
        aX := aX + LTextHeight * LSinA;
        aY := aY - LTextHeight * LCosA;
      end;

      TgtPDStream(FBaseObject).Write(LStr);
      LStr := '';
    end
    else
    begin
  {--------------Horizontal rendering of text with rotation-------------------}
      if ((AAngle <> 0) and (AAngle <> 360))  then
      begin
        StringToEscapeWideString(Text, LMLineNos, LMLineStrings);

        for LI := 0 to LMLineNos - 1 do
        begin

          LTxtLeft := aX - (AFont.Size * (72 / 96));
          LTxtBottom := aY + AFont.Size;

          LCharSpace := (LFontObj.GetPDFCharSpacing(LMLineStrings[LI], LFont) / 2);

          LStr := LStr + 'BT' + CRLF + '/' + LFontTag + ' ' + IntToStr(AFont.Size) +
            ' ' + 'Tf' + CRLF;

          LStr := LStr + Format('%s %s %s %s %s %s Tm ' + CRLF,
                    [FloatToStrFLocale(LCosA, ffFixed, 10, 3),
                    FloatToStrFLocale(LSinA, ffFixed, 10, 3),
                    FloatToStrFLocale(-LSinA, ffFixed, 10, 3),
                    FloatToStrFLocale(LCosA, ffFixed, 10, 3),
                    FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3),
                    FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3)]);

          LStr := LStr + '(' + LMLineStrings[LI] + ')' + ' ' + 'Tj' + CRLF + 'ET' + CRLF;

          TgtPDStream(FBaseObject).Write(LStr);

          LStr := '';

          //if text rotation
          aY := aY - LTextHeight * LCosA;
          aX := aX + LTextHeight * LSinA;
        end;
      end
      else
      begin
      {--------------Horizontal rendering of text without rotation-------------------}

        StringToEscapeWideString(Text, LMLineNos, LMLineStrings);

        for LI := 0 to LMLineNos - 1 do
        begin

          if LI <> 0 then
          begin
            aY := (aY - AFont.Size);
            //if aY <= 0 then Break;
          end;

          LCharSpace := (LFontObj.GetPDFCharSpacing(LMLineStrings[LI], LFont) / 2);

          LStr := LStr + WriteTextAsPDFString(aX, aY, AFont.Size, LFontTag, LMLineStrings[LI]);

          TgtPDStream(FBaseObject).Write(LStr);

          LTextWidth := LFontObj.GetWidth(LMLineStrings[LI], LFont);

          if (LMLineStrings[LI] <> '') then
          begin
            if fsUnderline in AFont.Style then
              ProcessFontStyles(aX, aY, LUnderscorePos, LUnderscoreSize, LTextWidth,
                AFont.Color);

            if fsStrikeOut in AFont.Style then
              ProcessFontStyles(aX, aY, LStrikeOutPos, LUnderscoreSize, LTextWidth,
                AFont.Color);
          end;

          LStr := '';
        end;
      end;
    end;

  finally
    if Assigned(LFontObj)then
    begin
      FreeAndNil(LFontObj);
    end;
    FreeAndNil(LFont);
  end;
end;

procedure TgtPDContentStream.TextOut(const Text: WideString; AFont: TgtFont; aX,
  aY: Double; aClipRect: TgtPDRect; AWritingMode: TgtWritingMode;
  AAngle: Integer);
var
  LStr, LFontTag, LClipStr: WideString;
  LgtPDFont: TgtPDFont;
  LFont: TFont;
  LFontObj: TgtPD8bitFont;
  LI, LMLineNos, LPageAngle: Integer;
  LIsExist: Boolean;
  LX1, LY1, LX2, LY2: Double;
  LUnderscorePos, LUnderscoreSize,
    LStrikeOutPos, LTextWidth, LTextHeight, LCharSpace: Double;
  LAngleInRadian, LPageAngleInRadian: Double;
  LTxtY1, LTxtX1, LTxtDy, LTxtDgl, LTxtAlpha, LCosA, LSinA,
    LTxtLeft, LTxtBottom: Double;
  LMLineStrings: TArray;

  function WriteTextAsPDFString(AX, AY: Double; AFontSize: Integer;
    AFontTag, AText: WideString): AnsiString;
  begin
    Result := LClipStr + CRLF + 'BT' + CRLF +
      FloatToStrFLocale(LCharSpace, ffFixed, 18, 8) + SP + 'Tc' + CRLF +
      '0 Tw 100 Tz' + SP + IntToStr(AFontSize) + SP + 'TL' + CRLF +
      '/' + AFontTag + ' ' + IntToStr(AFontSize) + ' ' + 'Tf' +
      CRLF + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' ' + 'Td' +
      CRLF + '(' + AText + ')' + ' ' + 'Tj' +
      CRLF + 'ET Q' + CRLF;
  end;

  procedure ProcessFontStyles(AX, AY, APos, AUnderscoreSize, ATextWidth: Double;
    APenColor: TColor);
  begin
    LX1 := AX;

    if fsUnderline in AFont.Style then
      LY1 := AY + (APos + AUnderscoreSize)
    else if fsStrikeOut in AFont.Style then
      LY1 := AY + (APos + AUnderscoreSize);

    LX2 := AX + ATextWidth;

    LY2 := LY1;

    SetPenColor(GetRValue(ColorToRGB(APenColor)),
      GetGValue(ColorToRGB(APenColor)),
      GetBValue(ColorToRGB(APenColor)));

    SetPenWidth(AUnderscoreSize / 2);//Check

    MoveTo(LX1, LY1);
    LineTo(LX2, LY2);
    StrokePath;
  end;

begin
  LFontTag := '';
  LIsExist := False;
  LgtPDFont := nil;
  LCharSpace := 0;
  LFont := TFont.Create;
  LFont.Name := aFont.Name;
  LFont.Size := aFont.Size;
  LFont.Color := aFont.Color;
  LFont.Style := aFont.Style;
  
  //Ex:- q 50.0000 591.8888 200.0000 200.0000 re W n

  LClipStr := 'q ' + FloatToStringLocale(aClipRect.Left) + ' ' +
              FloatToStringLocale(aClipRect.Top) + ' ' +
              FloatToStringLocale(aClipRect.Right) + ' ' +
              FloatToStringLocale(aClipRect.Bottom) + ' re W n'; 

  LFontObj := TgtPD8bitFont.Create(FParentDoc,
    TgtPDPage(FParentElement).Resource, aFont);

  try

    if LFontObj.Name = '' then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Error in creating Font object');
      {$ENDIF}
      Exit;
    end;
    //  LCharSpace := LFontObj.GetPDFCharSpacing(RemoveTerminalCRLF(Text), AFont.Size);

    LUnderscoreSize := (72 / 96) * (LFontObj.UnderscoreSize);
    LUnderscorePos := (72 / 96) * (LFontObj.UnderscorePosition);
    LTextHeight := LFontObj.GetHeight(Text, LFont);
    LStrikeOutPos := (72 / 96) * (((LFontObj.Ascent + LFontObj.Descent) / 64) / 2);

    //Checks if the required font already exist
    //Traverse through all the pages
  //  for LI := 1 to TgtPDDocument(FParentDoc).PageCount do
  //  begin
  //    //In each page check if font resource exist
  //    if Assigned(TgtPDDocument(FParentDoc).Pages[LI].Resource) then
  //    begin
  //      LgtPDFont := TgtPDDocument(FParentDoc).Pages[LI].Resource.
  //        GetFontByName(LFontObj.Name);
  //      if Assigned(LgtPDFont) then
  //      begin
  //        LIsExist := True;
  //        Break;
  //      end;
  //    end;
  //  end;

  //  //Traverse through the current page resource
  //  if Assigned(TgtPDPage(FParentElement).Resource) then
  //  begin
  //    LgtPDFont := TgtPDPage(FParentElement).Resource.GetFontByName(LFontObj.Name);
  //    if Assigned(LgtPDFont) then
  //    begin
  //      LIsExist := True;
  //    end;
  //  end;

    //If the required font does not exist in the entire document
    if LIsExist = False then
    begin
      //get the tag name for the newly added font obj
      LFontObj.Tag := TgtPDPage(FParentElement).Resource.GetResourceName(resFont);
      LFontTag := LFontObj.Tag;
      //create a font dict and add indirect ref to
      LFontObj.CreateFontDict;
      //Add the new font obj
      TgtPDPage(FParentElement).AddResource(resFont, LFontTag, LFontObj.BaseObject);
    end
    else
    begin
      //If the required font does not exist in the current page
      if (TgtPDPage(FParentElement).Resource.LookUpFont(LgtPDFont.Tag) = nil) then
      TgtPDPage(FParentElement).AddResource(resFont, LgtPDFont.Tag, LgtPDFont.BaseObject);
      LFontTag := LgtPDFont.Tag;
    end;

    LTxtY1 := aY;
    LTxtX1 := aX;

    aY := Abs(aY - (AFont.Size * (72 / 96)));

    //if Page mediabox or cropbox's, left and top, does not start with (0,0) origin
    TranslateXY(aX, aY);

    LPageAngle := TgtPDPage(FParentElement).Rotate;

    LPageAngleInRadian := LPageAngle * (PI / 180);
    LAngleInRadian := AAngle * (PI / 180);

    LCosA := Cos(LAngleInRadian);
    LSinA := Sin(LAngleInRadian);

    {--------------Page Rotation-------------------}

    if ((LPageAngle <> 0) and (LPageAngle <> 360))  then
    begin
      case LPageAngle of
        90:
        begin
          LTxtLeft := LTxtX1;
          LTxtBottom := (TgtPDPage(FParentElement).GetPageWidth - LTxtY1) +
            (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
        180:
        begin
          LTxtLeft := (TgtPDPage(FParentElement).GetPageWidth - LTxtX1);
          LTxtBottom := (TgtPDPage(FParentElement).GetPageHeight - LTxtY1) +
            (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
        270:
        begin
          LTxtLeft := (TgtPDPage(FParentElement).GetPageHeight - LTxtX1);
          LTxtBottom := LTxtY1 - (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
      end;

      aX := 0;
      aY := 0;
      LTxtY1 := 0;
      //LTxtX1 := 0;
    end;

    {--------------Vertical rendering of text-------------------}
    if (AWritingMode = wmVertical) then
    begin

      for LI := 1 to Length(Text) do
      begin
        LStr := LStr + WriteTextAsPDFString(aX, aY, AFont.Size, LFontTag, Text[LI]);

        LTextWidth := LFontObj.GetWidth(Text[LI], LFont);
        //underline & Strikeout
        if (Text[LI] <> ' ') then
        begin
          if fsUnderline in AFont.Style then
            ProcessFontStyles(aX, aY, LUnderscorePos, LUnderscoreSize, LTextWidth,
              AFont.Color);

          if fsStrikeOut in AFont.Style then
            ProcessFontStyles(aX, aY, LStrikeOutPos, LUnderscoreSize, LTextWidth,
              AFont.Color);
        end;
        //if text rotation
        aX := aX + LTextHeight * LSinA;
        aY := aY - LTextHeight * LCosA;
      end;

      TgtPDStream(FBaseObject).Write(LStr);
      LStr := '';
    end
    else
    begin
  {--------------Horizontal rendering of text with rotation-------------------}
      if ((AAngle <> 0) and (AAngle <> 360))  then
      begin
        StringToEscapeWideString(Text, LMLineNos, LMLineStrings);

        for LI := 0 to LMLineNos - 1 do
        begin

          LTxtLeft := aX + (AFont.Size * (72 / 96));
          LTxtBottom := aY;

          LCharSpace := (LFontObj.GetPDFCharSpacing(LMLineStrings[LI], LFont) / 2);

          LStr :=   LStr + LClipStr + CRLF + 'BT' + CRLF + '/' + LFontTag + ' ' + IntToStr(AFont.Size) +
            ' ' + 'Tf' + CRLF;

          LStr := LStr + Format('%s %s %s %s %s %s Tm ' + CRLF,
                    [FloatToStrFLocale(LCosA, ffFixed, 10, 3),
                    FloatToStrFLocale(LSinA, ffFixed, 10, 3),
                    FloatToStrFLocale(-LSinA, ffFixed, 10, 3),
                    FloatToStrFLocale(LCosA, ffFixed, 10, 3),
                    FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3),
                    FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3)]);

          LStr := LStr + '(' + LMLineStrings[LI] + ')' + ' ' + 'Tj' + CRLF + 'ET Q' + CRLF;

          TgtPDStream(FBaseObject).Write(LStr);

          LStr := '';

          //if text rotation
          aY := aY - LTextHeight * LCosA;
          aX := aX + LTextHeight * LSinA;
        end;
      end
      else
      begin
      {--------------Horizontal rendering of text without rotation-------------------}

        StringToEscapeWideString(Text, LMLineNos, LMLineStrings);

        for LI := 0 to LMLineNos - 1 do
        begin

          if LI <> 0 then
          begin
            aY := (aY - AFont.Size);
            //if aY <= 0 then Break;
          end;

          LCharSpace := (LFontObj.GetPDFCharSpacing(LMLineStrings[LI], LFont) / 2);

          LStr := LStr + WriteTextAsPDFString(aX, aY, AFont.Size, LFontTag, LMLineStrings[LI]);

          TgtPDStream(FBaseObject).Write(LStr);

          LTextWidth := LFontObj.GetWidth(LMLineStrings[LI], LFont);

          if (LMLineStrings[LI] <> '') then
          begin
            if fsUnderline in AFont.Style then
              ProcessFontStyles(aX, aY, LUnderscorePos, LUnderscoreSize, LTextWidth,
                AFont.Color);

            if fsStrikeOut in AFont.Style then
              ProcessFontStyles(aX, aY, LStrikeOutPos, LUnderscoreSize, LTextWidth,
                AFont.Color);
          end;

          LStr := '';
        end;
      end;
    end;

  finally
    if Assigned(LFontObj)then
    begin
      FreeAndNil(LFontObj);
    end;
    FreeAndNil(LFont);
  end;
end;


procedure TgtPDContentStream.TextOutEx(const Text: WideString; AFont: TgtFont;
  aX, aY: Double; AIsComplex: Boolean; AGlyphInfoList: TList;
  AWritingMode: TgtWritingMode; AAngle: Integer);
var
  LStr, LFontTag: WideString;
  LgtPDFont, LgtPDFont1: TgtPDFont;
  LFont: TFont;
  LFontObj: TgtPDCIDFont;
  LI, LMLineNos, LPageAngle: Integer;
  LIsExist: Boolean;
  LX1, LY1, LX2, LY2: Double;
  LUnderscorePos, LUnderscoreSize,
  LStrikeOutPos, LTextWidth, LTextHeight, LCharSpace: Double;
  LAngleInRadian, LPageAngleInRadian: Double;
  LTxtY1, LTxtX1, LTxtDy, LTxtDgl, LTxtAlpha, LCosA, LSinA,
  LTxtLeft, LTxtBottom: Double;
  LMLineStrings: TArray;
  LDict, LResDict: TgtPDDictionary;
  LObj, LObj1, LObj2: TgtPDBaseObject;
  TxtX1, TxtY1, TxtLeft, TxtBottom, TxtAlpha, TxtDgl, TxtDx, TxtDy: Double;
  LFreeFontObj: Boolean;

  function GetGlyphIDAsPDFString(AText: WideString): AnsiString;
  var
    LGlyphID: string;
    LI: Integer;
    LCIDGlyphInfo: TgtGlyphInfo;
  begin
    //Gets the GlyphIDs as PDF string
    LGlyphID := '';
    for LI := 0 to AGlyphInfoList.Count - 1 do
    begin
      LCIDGlyphInfo := TgtGlyphInfo(AGlyphInfoList.Items[LI]);
      LGlyphID := LGlyphID + AnsiString(IntToHex(LCIDGlyphInfo.ID, 4));
    end;
    Result := LGlyphID;
  end;

  function WriteTextAsPDFString(AX, AY: Double; AFontSize: Integer;
    AFontTag, AText: WideString): AnsiString;
  var
    LGlyphID: string;
  begin
    //Write GlyphID to 'tj' and return the content stream as string
    LGlyphID := GetGlyphIDAsPDFString(AText);
    Result := 'BT' + CRLF +
      FloatToStrFLocale(LCharSpace, ffFixed, 18, 8) + SP + 'Tc' + CRLF +
      '0 Tw 100 Tz' + SP + IntToStr(AFontSize) + SP + 'TL' + CRLF +
      '/' + AFontTag + ' ' + IntToStr(AFontSize) + ' ' + 'Tf' +
      CRLF + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' ' + 'Td' +
      CRLF + '<' + LGlyphID + '>' + ' ' + 'Tj' +
      CRLF + 'ET' + CRLF;
  end;

  procedure ProcessFontStyles(AX, AY, APos, AUnderscoreSize, ATextWidth: Double;
    APenColor: TColor);
  begin
    LX1 := AX;
    if fsUnderline in AFont.Style then
      LY1 := AY + (APos + AUnderscoreSize)
    else if fsStrikeOut in AFont.Style then
      LY1 := AY + (APos + AUnderscoreSize);
    LX2 := AX + ATextWidth;
    LY2 := LY1;
    SetPenColor(GetRValue(ColorToRGB(APenColor)),
      GetGValue(ColorToRGB(APenColor)),
      GetBValue(ColorToRGB(APenColor)));
    SetPenWidth(AUnderscoreSize / 2);//Check
    MoveTo(LX1, LY1);
    LineTo(LX2, LY2);
    StrokePath;
  end;

begin
  LFontTag := '';
  LIsExist := False;
  LgtPDFont := nil;
  LCharSpace := 0;
  LFont := TFont.Create;
  LFont.Name := aFont.Name;
  LFont.Size := aFont.Size;
  LFont.Color := aFont.Color;
  LFont.Style := aFont.Style;
  //Create CID font
  LFontObj := TgtPDCIDFont.Create(FParentDoc, FPageResource, AFont);
  LFreeFontObj := True;
  try
    if LFontObj.Name = '' then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Error in creating Font object');
      {$ENDIF}
      Exit;
    end;
    LUnderscoreSize := (72 / 96) * (LFontObj.UnderscoreSize);
    LUnderscorePos := (72 / 96) * (LFontObj.UnderscorePosition);
    LTextHeight := LFontObj.GetHeight(Text, LFont);
    LStrikeOutPos := (72 / 96) * (((LFontObj.Ascent + LFontObj.Descent) / 64) / 2);

    //Check if the font resource already exist in the PDF Document i.e traverse
    //through all the pages
    for LI := 1 to TgtPDDocument(FParentDoc).PageCount do
    begin
      //In each page check if font resource exist
      if Assigned(TgtPDDocument(FParentDoc).Pages[LI].Resource) then
      begin
        LgtPDFont := TgtPDDocument(FParentDoc).Pages[LI].Resource.
          GetFontByName(LFontObj.Name);
        if Assigned(LgtPDFont) then
        begin
          LIsExist := True;
          Break;
        end;
      end;
    end;

    if not LIsExist then
    begin
      //Get tag name for the newly added font obj
      LFontObj.Tag := TgtPDPage(FParentElement).Resource.GetResourceName(resFont);
      LFontTag := LFontObj.Tag;
      //Create a font dict and add indirect ref to /Resource dictionary
      LFontObj.CreateFontDict;
      TgtPDPage(FParentElement).AddResource(resFont, LFontTag, LFontObj.BaseObject);
      FreeAndNil(LFontObj);
      LFreeFontObj := False;
      FPageResource := TgtPDPage(FParentElement).Resource;
      LFontObj := (FPageResource.LookUpFont(LFontTag) as TgtPDCIDFont);
      LFontObj.ProcessUniscribe(Text, LFont, AGlyphInfoList);
    end
    else
    begin
      //If the required font does not exist in the current page
      //Check if there is "/Resource" entry in the page else add it
      if not Assigned(TgtPDPage(FParentElement).Resource) then
      begin
        TgtPDPage(FParentElement).AddResource(resFont, TgtPDCIDFont(LgtPDFont).Tag,
          TgtPDCIDFont(LgtPDFont).BaseObject);
        FPageResource := TgtPDPage(FParentElement).Resource;
        if Assigned(LFontObj) then
          FreeAndNil(LFontObj);
        LFreeFontObj := False;
        LFontObj := (FPageResource.LookUpFont(TgtPDCIDFont(LgtPDFont).Tag) as TgtPDCIDFont);
        TgtPDCIDFont(LFontObj).ProcessUniscribe(Text, LFont, AGlyphInfoList);
        LFontTag := TgtPDCIDFont(LFontObj).Tag;
      end
      else
      begin
        LFreeFontObj := True;
        //If "/Resource" is present but not "/Font" entry then add it
//        LgtPDFont1 :=  TgtPDPage(FParentElement).Resource.GetFontByName(LFont,.Name);
        LObj := TgtPDDictionary(TgtPDPage(FParentElement).BaseObject).LookUp(PDF_RESOURCES);
	    	LObj1 := TgtPDDictionary(LObj).LookUp(PDF_FONT);
	    	if Assigned(LObj1) then
        begin
			    LObj2 := TgtPDDictionary(LObj1).LookUp(TgtPDCIDFont(LgtPDFont).Tag);
        end;
        if not Assigned(LObj2) then
        begin
          TgtPDPage(FParentElement).AddResource(resFont, TgtPDCIDFont(LgtPDFont).Tag,
            TgtPDCIDFont(LgtPDFont).BaseObject);
          FPageResource := TgtPDPage(FParentElement).Resource;
          LgtPDFont1 := (FPageResource.LookUpFont(TgtPDCIDFont(LgtPDFont).Tag) as TgtPDCIDFont);
          TgtPDCIDFont(LgtPDFont1).ProcessUniscribe(Text, LFont, AGlyphInfoList);
          LFontTag := TgtPDCIDFont(LgtPDFont1).Tag;
        end
        else
        begin
          FPageResource := TgtPDPage(FParentElement).Resource;
          LgtPDFont1 := (FPageResource.LookUpFont(TgtPDCIDFont(LgtPDFont).Tag) as TgtPDCIDFont);
          TgtPDCIDFont(LgtPDFont1).ProcessUniscribe(Text, LFont, AGlyphInfoList);
          LFontTag := TgtPDCIDFont(LgtPDFont1).Tag;
        end;
      end;
    end;
    //If Page mediabox or cropbox's, left and top, does not start with (0,0) origin
    LTxtY1 := aY;
    LTxtX1 := aX;
    if ((AAngle = 0) or (AAngle = 360))  then
    begin
      aY := Abs(aY - (AFont.Size));
    end;
    TranslateXY(aX, aY);
    LPageAngle := TgtPDPage(FParentElement).Rotate;
    LPageAngleInRadian := LPageAngle * (PI / 180);
    LAngleInRadian := AAngle * (PI / 180);
    LCosA := Cos(LAngleInRadian);
    LSinA := Sin(LAngleInRadian);

    {--------------Page Rotation-------------------}

    if ((LPageAngle <> 0) and (LPageAngle <> 360))  then
    begin
      case LPageAngle of
        90:
        begin
          LTxtLeft := LTxtX1;
          LTxtBottom := (TgtPDPage(FParentElement).GetPageWidth - LTxtY1) +
            (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
        180:
        begin
          LTxtLeft := (TgtPDPage(FParentElement).GetPageWidth - LTxtX1);
          LTxtBottom := (TgtPDPage(FParentElement).GetPageHeight - LTxtY1) +
            (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
        270:
        begin
          LTxtLeft := (TgtPDPage(FParentElement).GetPageHeight - LTxtX1);
          LTxtBottom := LTxtY1 - (AFont.Size * (72 / 96));
          LStr := FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3) + SP +
            FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3) + SP +
            'cm' + CRLF;
        end;
      end;
      aX := 0;
      aY := 0;
      LTxtY1 := 0;
    end;

    {--------------Vertical rendering of text-------------------}
    if (AWritingMode = wmVertical) then
    begin
      //Write each character in the text as a separate 'tj'
      for LI := 1 to Length(Text) do
      begin
        LStr := LStr + WriteTextAsPDFString(aX, aY, AFont.Size, LFontTag, Text[LI]);
        LTextWidth := LFontObj.GetWidth(Text[LI], LFont);
        //Underline & Strikeout
        if (Text[LI] <> ' ') then
        begin
          if fsUnderline in AFont.Style then
            ProcessFontStyles(aX, aY, LUnderscorePos, LUnderscoreSize, LTextWidth,
              AFont.Color);
          if fsStrikeOut in AFont.Style then
            ProcessFontStyles(aX, aY, LStrikeOutPos, LUnderscoreSize, LTextWidth,
              AFont.Color);
        end;
        //If text rotation
        aX := aX + LTextHeight * LSinA;
        aY := aY - LTextHeight * LCosA;
      end;
      TgtPDStream(FBaseObject).Write(LStr);
      LStr := '';
    end
    else
    begin
  {--------------Horizontal rendering of text with rotation-------------------}
      if ((AAngle <> 0) and (AAngle <> 360))  then
      begin
        StringToEscapeWideString(Text, LMLineNos, LMLineStrings);
        for LI := 0 to LMLineNos - 1 do
        begin
          TxtY1 := aY + AFont.Size;
          TxtDx := 0;
          TxtDy := AFont.Size;
          TxtDgl := TxtDy;
          TxtAlpha := AAngle * Pi / 180.0;
          TxtLeft := aX + (TxtDgl * Sin(TxtAlpha));
          TxtBottom := aY - (TxtDgl * Cos(TxtAlpha));
          LTxtLeft := TxtLeft;
          LTxtBottom := TxtBottom;
          
          LStr := LStr + 'BT' + CRLF + '/' + LFontTag + ' ' + IntToStr(AFont.Size) +
            ' ' + 'Tf' + CRLF;
          LStr := LStr + Format('%s %s %s %s %s %s Tm ' + CRLF,
                    [FloatToStrFLocale(LCosA, ffFixed, 10, 3),
                    FloatToStrFLocale(LSinA, ffFixed, 10, 3),
                    FloatToStrFLocale(-LSinA, ffFixed, 10, 3),
                    FloatToStrFLocale(LCosA, ffFixed, 10, 3),
                    FloatToStrFLocale(LTxtLeft, ffFixed, 10, 3),
                    FloatToStrFLocale(LTxtBottom, ffFixed, 10, 3)]);
          LStr := LStr + '<' + GetGlyphIDAsPDFString(LMLineStrings[LI]) + '>' + ' ' + 'Tj' + CRLF + 'ET' + CRLF;
          TgtPDStream(FBaseObject).Write(LStr);
          LStr := '';
          //if text rotation
          aY := aY - LTextHeight * LCosA;
          aX := aX + LTextHeight * LSinA;
        end;
      end
      else
      begin
      {--------------Horizontal rendering of text without rotation-------------------}

        StringToEscapeWideString(Text, LMLineNos, LMLineStrings);
        for LI := 0 to LMLineNos - 1 do
        begin
          if LI <> 0 then
          begin
            aY := (aY - AFont.Size);
          end;
          LStr := LStr + WriteTextAsPDFString(aX, aY, AFont.Size, LFontTag, LMLineStrings[LI]);
          TgtPDStream(FBaseObject).Write(LStr);
          LTextWidth := LFontObj.GetWidth(LMLineStrings[LI], LFont);
          if (LMLineStrings[LI] <> '') then
          begin
            if fsUnderline in AFont.Style then
              ProcessFontStyles(aX, aY, LUnderscorePos, LUnderscoreSize, LTextWidth,
                AFont.Color);
            if fsStrikeOut in AFont.Style then
              ProcessFontStyles(aX, aY, LStrikeOutPos, LUnderscoreSize, LTextWidth,
                AFont.Color);
          end;
          LStr := '';
        end;
      end;
    end;
  finally
    if Assigned(LFont) then
      FreeAndNil(LFont);
    if Assigned(LFontObj) and LFreeFontObj then
      FreeAndNil(LFontObj);
//    if Assigned(AGlyphInfoList) then
//    begin
//      for LI := 0 to AGlyphInfoList.Count - 1 do
//        if Assigned(AGlyphInfoList.Items[LI]) then
//          TgtGlyphInfo(AGlyphInfoList.Items[LI]).Free;
//      FreeAndNil(AGlyphInfoList);
//    end;
  end;
end;

procedure TgtPDContentStream.TranslateXY(var AX, AY: Double);
var
  LRect: TgtPDRect;
begin
  LRect := TgtPDPage(FParentElement).Cropbox;
  if not Assigned(LRect) then
    LRect := TgtPDPage(FParentElement).Mediabox;
  AX := AX + LRect.Left;
  AY := AY + LRect.Top;
end;

procedure TgtPDContentStream.UniCodeTextOut(const Text: WideString;
  AFont: TgtFont; aX, aY: Double; AWritingMode: TgtWritingMode;
  AAngle: Integer);
var
  LFont: TFont;
begin
  LFont := TFont.Create;
  try
    LFont.Name := AFont.Name;
    LFont.Size := 1000;
    LFont.Color := AFont.Color;
    Fx := aX;
    Fy := aY;
    FWritingMode := AWritingMode;
    FAngle := AAngle;
    FFont := AFont;
    TgtGlyphInfo.StringAnalyze(Text, LFont, CallMeForScript);
  finally
    if Assigned(LFont) then
      FreeAndNil(LFont);
  end;
end;

procedure TgtPDContentStream.Update;
begin
  inherited;

end;

end.
