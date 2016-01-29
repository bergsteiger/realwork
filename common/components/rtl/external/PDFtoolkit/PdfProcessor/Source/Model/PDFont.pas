{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDFont;

interface

uses
  Classes, PDElement, gtObject, PDBaseObject, PDTypes, PDRect, PDMatrix,
  gtTypes, PDCMapParser, Graphics, Windows;

const

  Type1FontExts: array[0..3] of AnsiString = ('.pfa', '.pfb', '.ps', '');
  TrueTypeFontExts: array[0..1] of AnsiString = ('.ttf', '');

type

  TgtPDFontEncoding = (
    feBuiltInEncoding, //The encoding specified internally in the font. In the
                        //case of a Type 1 or MMType 1 font, this is specified
                        //by the Encoding value in the font's fontdict. In the
                        //case of TrueType fonts, this is the encoding specified
                        //by the default one-byte CMap for the platform.
    feMacRomanEncoding, //MacRomanEncoding, as defined in Appendix D in the PDF
                        //Reference.
    feMacExpertEncoding,
    feWinAnsiEncoding,
    feStandardEncoding,
    fePDFDocEncoding, //PDFDocEncoding, as defined in Appendix D in the PDF
                        //Reference. This will never be returned for a font; it
                        //is used internally.
    feNone
    );

 (**
  * A PDFont is a font that is used to draw text on a page. It corresponds to a
  * font resource in a PDF file
  * Library users can get a list of PDFont objects used on a Page or a range of
  * PDPage objects. More than one PDPage may reference the same PDFont object.
  * A PDFont has a number of attributes whose values can be read or set,
  * including an array of widths, the character encoding, and the font's resource
  * name.
  * In general, a PDFont refers to a base font and an encoding. The base font is
  * specified by the font name and the subtype (typically Type 0, Type 1,
  * MMType1, Type3, or TrueType). This combination of base font and encoding is
  * commonly referred to as a font instance.
  * In single-byte character systems, an encoding specifies a mapping from an
  * 8-bit index, often called a codepoint, to a glyph.
  * Type 0 fonts support single-byte or multibyte encodings and can refer to one
  * or more descendent fonts. These fonts are analogous to the Type 0 or
  * composite fonts supported by Level 2 PostScript interpreters. However, PDF
  * Type 0 fonts only support character encodings defined by a character map
  * (CMap). The CMap defines the encoding for a Type 0 font. It specifies the
  * mappings between character codes and the glyphs in the descendant fonts.
  * Type 0 fonts may have a CIDFont as a descendent. A CIDFont is designed to
  * contain a large number of glyph procedures and is used for languages such as
  * Chinese, Japanese, or Korean. Instead of being accessed by a name, each
  * glyph procedure is accessed by an integer known as a character identifier or
  * CID. Instead of a font encoding, CIDFonts use a CMap to define the mapping
  * from character codes to a font number and a character selector.
  *)

  TgtPDFontType =
    (
    UnknowType, Type1, Type1C, Type1COT, Type3, TrueType,
    TrueTypeOT, CIDType0, CIDType0C, CIDType0COT, CIDType2,
    CIDType2OT
    );

  TgtWritingMode = (wmHorizontal, wmVertical);

  TToUnicodeTable = TgtPDCMapParser;

  TgtPDFont = class(TgtPDElement)
  protected
    FTag: AnsiString;
    FFontType: TgtPDFontType;
    FFontMatrix: TgtPDMatrix;
    FDescent: Double;
    FFontBox: TgtPDRect;
    FExtFontName: AnsiString;
    FEmbeddedFontName: AnsiString;
    FExtFontStream: TStream;
    FEmbeddedFontStream: TStream;
    FAscent: Double;
    FOrginalName: AnsiString;
    FFlags: Integer;
    FName: AnsiString;
    FMissingWidth: Integer;
    FEmbededFontIndRef: TgtPDBaseObject;
    FIsBold: Boolean;
    FIsItalic: Boolean;
    FItalicAngle: Integer;
    FEncodingName: AnsiString;
    FBaseFont: AnsiString;
    FEmbeddingType: TgtPDFFontEmbeddingType;
    FToUnicode: TToUnicodeTable;

    procedure SetTag(AValue: AnsiString);
    function GetEmbeddedFontStream: TStream;
    procedure SetEmbeddedFontStream(AValue: TStream);
    function GetExtFontStream: TStream;
    procedure ReadFontDescriptor(FontDict: TgtPDBaseObject);
//    function ReadToUnicodeCMap(FontDict: TgtPDBaseObject; nBits: Integer;
//      var CTU: TgtPDCCToUnicode): TgtPDCCToUnicode;
    function FindFontFile(const Dirs: TStrings; const Name: AnsiString;
      ExtsType: TgtPDFontType): AnsiString;
    procedure FindExtFontFile;
    function TextSize(const Text: AnsiString; AFont: TFont): TSize; overload;
  public
    class function MakeFont(AParentDoc: TgtObject; AResource: TgtPDElement;
      const ATag: AnsiString; AFontDict: TgtPDBaseObject): TgtPDFont;
    constructor Create(const aTag: AnsiString; const aName: AnsiString);
    destructor Destroy; override;
    procedure CreateFontDict;virtual; abstract;
    
    function Matches(const aTag: AnsiString): Boolean;
    function IsCIDFont: Boolean; virtual;
    function IsFixedWidth: Boolean;
    function IsSerif: Boolean;
    function IsSymbolic: Boolean;
    function IsItalic: Boolean;
    function IsBold: Boolean;

    function WritingMode: TgtWritingMode; virtual;

    function GetNextChar(const aStr: WideString; Index: Integer; out Processed: Integer;
      out Code: TgtCharCode; out CharName: AnsiString; out Dx: Double;
      out Dy: Double; out Ox: Double; out Oy: Double): Integer; virtual; abstract;

    function GetCharWidth(ACharCode: TgtCharCode): Double; virtual;
    function GetToUnicode: TToUnicodeTable; 

    property Tag: AnsiString read FTag write SetTag;
    property Name: AnsiString read FName; //set
    property OrginalName: AnsiString read FOrginalName;
    property FontType: TgtPDFontType read FFontType; //set
    property EmbeddedFontStream: TStream read GetEmbeddedFontStream
      write SetEmbeddedFontStream;
    property EmbeddedFontName: AnsiString read FEmbeddedFontName;
    property ExtFontStream: TStream read GetExtFontStream;
    property ExtFontName: AnsiString read FExtFontName;
    property Flags: Integer read FFlags; //set
    property FontMatrix: TgtPDMatrix read FFontMatrix; //set
    property FontBox: TgtPDRect read FFontBox; //set
    property Ascent: Double read FAscent; //set
    property Descent: Double read FDescent; //set
    property EncodingName: AnsiString read FEncodingName;
    property BaseFont: AnsiString read FBaseFont;
    property EmbeddingType: TgtPDFFontEmbeddingType read FEmbeddingType; 
    //italic angle
    //stemv
    //widtharray
    //encoding
  end;

  TgtPDEnumFontEvent = procedure(Font: TgtPDFont; var Name: AnsiString;
    var Cancel: Boolean) of object;

implementation

uses
  SysUtils, gtConstants, PDDictionary, PDName, PDCIDFont, PD8bitFont,
  PDIndirectRef, PDArray, PDInteger, PDStream, PDReal, PDDocument, gtMethods
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF}
  , Stream;

{ TgtPDFont }

constructor TgtPDFont.Create(const aTag, aName: AnsiString);
begin
  FTag := aTag;
  FName := aName;
  FOrginalName := aName;
  FEmbeddedFontStream := nil;
  FExtFontStream := nil;
  FEmbeddingType := etNone;
end;

destructor TgtPDFont.Destroy;
begin
  if Assigned(FFontMatrix) then FFontMatrix.Free;
  if Assigned(FFontBox) then FFontBox.Free;
  if Assigned(FExtFontStream) then FExtFontStream.Free;
  if Assigned(FEmbeddedFontStream) then FEmbeddedFontStream.Free;
  if Assigned(FToUnicode) then FToUnicode.Free;  
  inherited;
end;

procedure TgtPDFont.FindExtFontFile;
begin
//  if FName <> '' then
//  begin
//    FExtFontName := FindFontFile(TgtPDDocument(ParentDoc).FontDirectory, FName, FFontType);
//  end;
end;

function TgtPDFont.FindFontFile(const Dirs: TStrings; const Name: AnsiString;
  ExtsType: TgtPDFontType): AnsiString;
var
  I: Integer;
  Dir: AnsiString;
  FileName: AnsiString;
  J: Integer;
  Found: Boolean;
begin
  Found := False;
  Result := '';
  for I := 0 to Dirs.Count - 1 do
  begin
    Dir := Dirs.Strings[I];
    if ExtsType = Type1 then
    begin
      for J := 0 to 3 do
      begin
        Filename := Dir + Name + Type1FontExts[J];
        if FileExists(FileName) then
        begin
          Break;
          Found := True;
        end;
      end;
      if Found then
        Break;
    end
    else if ExtsType = TrueType then
    begin
      for J := 0 to 1 do
      begin
        Filename := Dir + Name + TrueTypeFontExts[J];
        if FileExists(FileName) then
        begin
          Break;
          Found := True;
        end;
      end;
      if Found then
        Break;
    end;
  end;
  if Found then
    Result := FileName;
end;

function TgtPDFont.GetCharWidth(ACharCode: TgtCharCode): Double;
begin
  Result := 0;
end;

function TgtPDFont.GetEmbeddedFontStream: TStream;
var
  LObj: TgtPDBaseObject;
  I: Integer;
  LStream: TgtStream;
  LChar: AnsiChar;
begin
  if not Assigned(FEmbeddedFontStream) then
  begin
    if Assigned(FEmbededFontIndRef) then
    begin
      LObj := TgtPDDocument(FParentDoc).BaseDoc.GetObject(FEmbededFontIndRef.ObjNumber);
      if Assigned(LObj) and LObj.IsStream then
      begin
        FEmbeddedFontStream := TMemoryStream.Create;
        LStream := TgtPDStream(LObj).GetStream;
        LStream.Reset;
        I := LStream.GetChar;
        while I <> ENDOFFILE do
        begin
          LChar := AnsiChar(I);
          FEmbeddedFontStream.Write(LChar, 1);
          I := LStream.GetChar;
        end;
        LStream.Close;
        FEmbeddedFontStream.Position := 0;
      end
      else
      begin
{$IFDEF DEBUG}
        Logger.LogError('Embedded font file is not a stream');
{$ENDIF}
      end;
    end;
  end;
  Result := FEmbeddedFontStream;
end;

function TgtPDFont.GetExtFontStream: TStream;
begin
  if not Assigned(FExtFontStream) then
  begin
    if FileExists(FExtFontName) then
    begin
      FExtFontStream := TFileStream.Create(FExtFontName, fmOpenRead);
      FExtFontStream.Position := 0;
    end
    else
    begin
{$IFDEF DEBUG}
      Logger.LogError('External font file %s vanished', [FExtFontName]);
{$ENDIF}
    end;
  end;
  Result := FExtFontStream;
end;

function TgtPDFont.GetToUnicode: TToUnicodeTable;
begin
  Result := FToUnicode;
end;

function TgtPDFont.IsBold: Boolean;
begin
  if FIsBold then
    Result := FIsBold
  else
    Result := ((FFlags and 262144) = 262144);
end;

function TgtPDFont.IsCIDFont: Boolean;
begin
  Result := False;
end;

function TgtPDFont.IsFixedWidth: Boolean;
begin
  Result := ((FFlags and 1) = 1);
end;

function TgtPDFont.IsItalic: Boolean;
begin
  if FIsItalic then
    Result := FIsItalic
  else
    Result := ((FFlags and 64) = 64);
end;

function TgtPDFont.IsSerif: Boolean;
begin
  Result := ((FFlags and 2) = 2);
end;

function TgtPDFont.IsSymbolic: Boolean;
begin
  Result := ((FFlags and 4) = 4);
end;

class function TgtPDFont.MakeFont(AParentDoc: TgtObject;
  AResource: TgtPDElement; const ATag: AnsiString; AFontDict: TgtPDBaseObject): TgtPDFont;
var
  LObj: TgtPDBaseObject;
  LName: AnsiString;
begin
//  Result := nil;
  if Assigned(AFontDict) then
  begin
    LObj := TgtPDDictionary(AFontDict).LookUp(PDF_BASEFONT);
    if Assigned(LObj) and LObj.IsName then
      LName := TgtPDName(LObj).Value
    else
      LName := '';

    LObj := TgtPDDictionary(AFontDict).LookUp(PDF_SUBTYPE);
    if Assigned(LObj) then
    begin
      if LObj.IsName(PDF_TYPE1) or LObj.IsName(PDF_MMTYPE1) then
        Result := TgtPD8bitFont.Create(AParentDoc, AResource, AFontDict, ATag,
          LName, Type1)
      else if LObj.IsName(PDF_TYPE1C) then
        Result := TgtPD8bitFont.Create(AParentDoc, AResource, AFontDict, ATag,
          LName, Type1C)
      else if LObj.IsName(PDF_TYPE3) then
        Result := TgtPD8bitFont.Create(AParentDoc, AResource, AFontDict, ATag,
          LName, Type3)
      else if LObj.IsName(PDF_TRUETYPE) then
        Result := TgtPD8bitFont.Create(AParentDoc, AResource, AFontDict, ATag,
          LName, TrueType)
      else if LObj.IsName(PDF_TYPE0) then
        Result := TgtPDCIDFont.Create(AParentDoc, AResource, AFontDict, ATag,
          LName)
//        Result := TgtPDCIDFont.Create(AParentDoc, AResource, nil)
      else
      begin
    {$IFDEF DEBUG}
        Logger.LogError('Unknown font type: %s', [LName]);
    {$ENDIF}
        Result := TgtPD8bitFont.Create(AParentDoc, AResource, AFontDict, ATag,
          LName, UnknowType);
      end;
    end
    else
    begin
    {$IFDEF DEBUG}
        Logger.LogError('Font type not found');
    {$ENDIF}
      Result := nil;
    end;
  end
  else
  begin
  {$IFDEF DEBUG}
      Logger.LogError('Invalid font Dict with tag %s', [ATag]);
  {$ENDIF}
    Result := nil;
  end;
end;

function TgtPDFont.Matches(const aTag: AnsiString): Boolean;
begin
  Result := (aTag = FTag);
end;

procedure TgtPDFont.ReadFontDescriptor(FontDict: TgtPDBaseObject);
var
  LFontDes: TgtPDBaseObject;
  LObj, LObj2, LObj3, LObj4: TgtPDBaseObject;
  LObjRef: TgtPDIndirectRef;
  Temp: Double;
  LBaseFont: AnsiString;
  LIsSubset, LIsFontFileExist: Boolean;
//  LTempName: AnsiString;
//  LIn: Boolean;
{$IFDEF DEBUG}
  LName: AnsiString;
{$ENDIF}
begin
  LIsSubset := False;
  LIsFontFileExist := False;
  
  FFlags := 1 shl 1; //Font Serif;
  FMissingWidth := 0;

  LObj4 := TgtPDDictionary(FontDict).LookUp(PDF_BASEFONT);
  if Assigned(LObj4) then
  begin
    LBaseFont := TgtPDName(LObj4).Value;
    if AnsiPos('+', LBaseFont) = 7 then//if subset embedded
    begin
      LIsSubset := True;
    end;
  end;
  
  //get Font Descriptor Dict
  LFontDes := TgtPDDictionary(FontDict).LookUp(PDF_FONTDESCRIPTOR);
  if Assigned(LFontDes) and LFontDes.IsDict then
  begin
    // Get Flags
    LObj := TgtPDDictionary(LFontDes).LookUp(PDF_FLAGS);
    if Assigned(LObj) and LObj.IsInteger then
      FFlags := TgtPDInteger(LObj).Value;

    //get name
    LObj := TgtPDDictionary(LFontDes).LookUp(PDF_FONTNAME);

    if Assigned(LObj) and LObj.IsName then
      FEmbeddedFontName := TgtPDName(LObj).Value;

//    SetLength(LTempName, Length(FEmbeddedFontName));
//    LIn := False;
//    K := 1;
//    for I := 1 to Length(FEmbeddedFontName)  do
//    begin
//      if isAlpha(FEmbeddedFontName[I]) or (FEmbeddedFontName[I] = ' ') then
//      begin
//        LIn := False;
//        LTempName[K] := FEmbeddedFontName[I];
//        Inc(K);
//      end
//      else
//      begin
//        if not LIn then
//        begin
//          LTempName[K] := ',';
//          Inc(K);
//          LIn := True;
//        end;
//      end;
//    end;
//
//    LTempName := Trim(LTempName);
//    FEmbeddedFontName := LTempName;
//
//    Finalize(LTempName);

    //look for enbedded font file
    LObjRef := TgtPDDictionary(LFontDes).LookupRefObj(PDF_FONTFILE)
      as TgtPDIndirectRef;
    if Assigned(LObjRef) and LObjRef.IsIndirectRef then
    begin
      LIsFontFileExist := True;
      FEmbededFontIndRef := LObjRef;
      if FFontType <> Type1 then
      begin
{$IFDEF DEBUG}
        Logger.LogError('Mismatch between font type and embedded font file');
{$ENDIF}
        FFontType := Type1;
      end;
    end;

    if not Assigned(FEmbededFontIndRef) or
      (FEmbededFontIndRef.ObjNumber = $FFFFFFFF) then
    begin
      LObjRef := TgtPDDictionary(LFontDes).LookupRefObj(PDF_FONTFILE2)
        as TgtPDIndirectRef;
      if Assigned(LObjRef) and LObjRef.IsIndirectRef then
      begin
        LIsFontFileExist := True;
        FEmbededFontIndRef := LObjRef;
        if (FFontType <> TrueType) and (FFontType <> CIDType2) then
        begin
{$IFDEF DEBUG}
          Logger.LogError('Mismatch between font type and embedded font file');
{$ENDIF}
          if FFontType = CIDType0 then
            FFontType := CIDType2
          else FFontType := TrueType;
        end;
      end;
    end;

    if not Assigned(FEmbededFontIndRef) or
      (FEmbededFontIndRef.ObjNumber = $FFFFFFFF) then
    begin
      LObjRef := TgtPDDictionary(LFontDes).LookupRefObj(PDF_FONTFILE3)
        as TgtPDIndirectRef;
      if Assigned(LObjRef) and LObjRef.IsIndirectRef then
      begin
        LIsFontFileExist := True;
        LObj2 := TgtPDDocument(ParentDoc).BaseDoc.GetObject(LObjRef.ObjNumber);
        if Assigned(LObj2) and LObj2.IsStream then
        begin
          LObj3 := TgtPDDictionary(TgtPDStream(LObj2).GetDict).LookUp(PDF_SUBTYPE);
          if Assigned(LObj3) and LObj3.IsName(PDF_TYPE1) then
          begin
            FEmbededFontIndRef := LObjRef;
            if FFontType <> Type1 then
            begin
{$IFDEF DEBUG}
              Logger.LogError('Mismatch between font type and embedded font file');
{$ENDIF}
              FFontType := Type1;
            end;
          end
          else if Assigned(LObj3) and LObj3.IsName(PDF_TYPE1C) then
          begin
            FEmbededFontIndRef := LObjRef;
{$IFDEF DEBUG}
            if (FFontType <> Type1) or (FFontType <> Type1C) then
              Logger.LogError('Mismatch between font type and embedded font file');
{$ENDIF}
            FFontType := Type1C;
          end
          else if Assigned(LObj3) and LObj3.IsName(PDF_TRUETYPE) then
          begin
            FEmbededFontIndRef := LObjRef;
{$IFDEF DEBUG}
            if FFontType <> TrueType then
              Logger.LogError('Mismatch between font type and embedded font file');
{$ENDIF}
            FFontType := TrueType;
          end
          else if LObj3.IsName(PDF_CIDTYPE0C) then
          begin
            FEmbededFontIndRef := LObjRef;
{$IFDEF DEBUG}
            if FFontType <> CIDType0 then
              Logger.LogError('Mismatch between font type and embedded font file');
{$ENDIF}
            FFontType := CIDType0C;
          end
          else if LObj3.IsName(PDF_OPENTYPE) then
          begin
            FEmbededFontIndRef := LObjRef;
            if FFontType = TrueType then
              FFontType := TrueTypeOT
            else if FFontType = Type1 then
              FFontType := Type1COT
            else if FFontType = CIDType0 then
              FFontType := CIDType0COT
            else if FFontType = CIDType2 then
              FFontType := CIDType2OT
            else begin
{$IFDEF DEBUG}
              Logger.LogError('Mismatch between font type and embedded font file');
{$ENDIF}
            end;
          end
          else
          begin
{$IFDEF DEBUG}
            if Assigned(LObj3) and LObj3.IsName then
              LName := TgtPDName(LObj3).Value
            else LName := '????';
            Logger.LogError('Unknown embedded font type %s', [LName]);
{$ENDIF}
          end;
        end;
      end;
    end;

    if ((LIsFontFileExist) and (not LIsSubset)) then
      FEmbeddingType := etFull
    else if ((LIsFontFileExist) and (LIsSubset)) then
      FEmbeddingType := etSubset
    else FEmbeddingType := etNone;
    
    // get MissingWidth
    LObj := TgtPDDictionary(LFontDes).LookUp(PDF_MISSINGWIDTH);
    if Assigned(LObj) and LObj.IsInteger then
      FMissingWidth := TgtPDInteger(LObj).Value
    else if Assigned(LObj) and LObj.IsReal then
      FMissingWidth := Round(TgtPDReal(LObj).Value);

    //get font ascent
    LObj := TgtPDDictionary(LFontDes).LookUp(PDF_ASCENT);
    if Assigned(LObj) and LObj.IsNumber then
    begin
      if LObj.IsInteger then
        Temp := TgtPDInteger(LObj).Value
      else
        Temp := TgtPDReal(LObj).Value;
      Temp := 0.001 * Temp;
      //some broken font despcriptors set assent and descent to 0
      if Temp <> 0 then
        FAscent := Temp;
    end;

    // get font descent
    LObj := TgtPDDictionary(LFontDes).LookUp(PDF_DESCENT);
    if Assigned(LObj) and LObj.IsNumber then
    begin
      if LObj.IsInteger then
        Temp := TgtPDInteger(LObj).Value
      else
        Temp := TgtPDReal(LObj).Value;
      Temp := 0.001 * Temp;
      //some broken font despcriptors set assent and descent to 0
      if Temp <> 0 then
        FDescent := Temp;
      // some broken font descriptors specify a positive descent
      if FDescent > 0 then
        FDescent := -1 * FDescent;
    end;

    // get font BBox
    LObj := TgtPDDictionary(LFontDes).LookUp(PDF_FONTBBOX);
    if Assigned(LObj) and LObj.IsArray then
    begin
      if Assigned(FFontBox) then FFontBox.Free;
      FFontBox := TgtPDRect.Create(TgtPDArray(LObj))
    end;
  end;
end;

//function TgtPDFont.ReadToUnicodeCMap(FontDict: TgtPDBaseObject;
//  nBits: Integer; var CTU: TgtPDCCToUnicode): TgtPDCCToUnicode;
//var
//  LObj: TgtPDBaseObject;
//  LStream: TMemoryStream;
//  I: Integer;
//begin
////  Result := CTU;
////
////  LObj := TgtPDDictionary(BaseObject).LookUp(PDF_TOUNICODE);
////  if Assigned(LObj) and LObj.IsStream then
////  begin
////    LStream := TMemoryStream.Create;
////    try
////      TgtPDStream(LObj).Reset;
////      I := TgtPDStream(LObj).GetChar;
////      while I <> ENDOFFILE do
////      begin
////        LStream.Write(AnsiChar(I), 1);
////        I := TgtPDStream(LObj).GetChar;
////      end;
////     TgtPDStream(LObj).Close;
////
////     if Assigned(CTU) then
////      CTU.MergeCMap(LStream)
////     else
////      CTU := TgtPDCCToUnicode.ParseCMap(LStream);
////    finally
////      LStream.Free;
////    end;
////  end;
//end;

procedure TgtPDFont.SetEmbeddedFontStream(AValue: TStream);
begin
//  if Assigned(FBaseObject) then
  begin
    if not Assigned(FEmbeddedFontStream) then
      FEmbeddedFontStream := TMemoryStream.Create;
    TMemoryStream(FEmbeddedFontStream).LoadFromStream(AValue);
    FEmbeddedFontStream.Position := 0;
  end;
end;

procedure TgtPDFont.SetTag(AValue: AnsiString);
begin
  FTag := AValue;
end;

function TgtPDFont.TextSize(const Text: AnsiString; AFont: TFont): TSize;
var
  DC: HDC;
  SaveFont: HFont;
  LSize: TSize;
  LFont: TFont;
begin
  LFont := TFont.Create;
  LFont.Name := AFont.Name;
  LFont.Size := AFont.Size;
  LFont.Style := AFont.Style;
  LFont.Color := AFont.Color;
  try
    DC := GetDC(0);
    SaveFont := SelectObject(DC, LFont.Handle);
    GetTextExtentPoint32A(DC, PAnsiChar(Text), Length(Text), LSize);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
    LFont.Free;
  end;
  Result := LSize;
end;

function TgtPDFont.WritingMode: TgtWritingMode;
begin
  Result := wmHorizontal;
end;

end.
