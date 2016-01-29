{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
{$I gtDefines.inc}
{$I gtPTKDefines.inc}

unit gtExProPDFDoc;

interface

uses
  Classes, Windows, gtExPDFDoc, gtCstPDFDoc, Graphics, gtPDFUtils, gtPDFConsts,
  Contnrs, gtPDFClasses, gtWideStrings;

type

  TgtPDFSearchType = (stCaseSensitive, stWholeWord, stNone);

  TgtSearchTypes = set of TgtPDFSearchType;
  TgtSearchEvent = procedure (Sender: TObject; List: TStrings; PageNum: Integer;
    var Continue: Boolean) of object;


  TgtSearchElement = class(TObject)
  private
    FIndex: Integer;
    FRect: TRect;
    FText: string;
    FPageNum: Integer;
    FSearchIndex: Integer;
  public
    function Copy: TgtSearchElement;
    property PageNum: Integer read FPageNum write FPageNum;
    property BoundingRect: TRect read FRect write FRect;
    property IndexToSearchStr: Integer read FIndex write FIndex;
    property Line: string read FText write FText;
  end;

  TgtStringList = class(TStringList)
  public
    destructor Destroy; override;
  end;

  TgtExProPDFDocument = class(TgtExPDFDocument)
  private
    FSearchList: TgtStringList;
    FSearchStr: string;
    FSearchOptions: TgtSearchTypes;
    FCurrentSearchPage: Integer;
    FPageElementList: TgtPDFPageElementList;

    function CreateFileSpecStr(AStr: string): string;

//    procedure AddLinkAnnot(AStrSizeToCalculate: string; AHyperLinkStr: string;
//      AStartPos: Integer; ATextElement: TgtPDFTextElement; APageHeight: Double;
//      AFound: Boolean; APageNo: Integer);

//    procedure ActivateLinks(APageNo: Integer); overload;

    procedure EnumCallBack(Sender: TObject; PageElement: TgtPDFPageElement;
      ElementType: TgtPDFElementType; PageNumber: Integer);
  protected
    procedure SearchText(AResultList: TgtWideStringList; APageNo: Integer);
    function SearchInStr(const Searchtext: string; const Text: string;
      StartPos: Integer; Options: TgtSearchTypes): Integer;
    procedure RenderImageToCanvas(aDC: HDC; aStream: TStream; aWidth: Cardinal;
      aHeight: Cardinal; aRotate: Integer = 0);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
//
////    procedure SaveToImage(Filename: String; ImageFormat: TImageFormat);
//
    function ExtractTextFormatted(APageNo: Integer): TgtWideStringList;
    function GetPageElements(APageNo: Integer; ElementTypes: TgtElementTypes;
      MMUnit: TgtMeasurementUnit): TgtPDFPageElementList;
    procedure EnumPageElements(aPageNumber: Integer; aElementTypes: TgtElementTypes;
      aMUnit: TgtMeasurementUnit; TextType: TgtPDFTextType;
      CallBackEvent: TgtEnumPageElementCallBack);
    procedure RenderToCanvas(PageNo: Integer; ACanvas: TCanvas;
      aTextPrecision: TgtTextOutputPrecision; RotationAngle: Integer = 0); overload; //deprecated;
    procedure RenderToDC(aDC: Cardinal; aWidth: Cardinal; aHeight: Cardinal;
      aPageNum: Integer; axDPI: Double = 72; ayDPI: Double = 72;
      aRotationAngle: Integer = 0; aAntiAliasing: Boolean = True;
      aForPrinting: Boolean = False);
    procedure RenderToStream(aEMFPlusStream: TStream; aPageNum: Integer;
      aWidth, aHeight: double; axDPI: Double = 72; ayDPI: Double = 72;
      aRotationAngle: Integer = 0; aAntiAliasing: Boolean = True;
      aForPrinting: Boolean = False); overload;
    {Search functions }
    procedure SearchInPage(PageNum: Integer; const Asearchtext: string;
      AOptions: TgtSearchTypes; var SearchList: TgtStringList);
    function SearchFirst(const Asearchtext: string; AOptions: TgtSearchTypes;
      PageNum: Integer = 1): TgtSearchElement; overload;
    function SearchNext(aCurrentSearchElement: TgtSearchElement): TgtSearchElement; overload;
    procedure SearchAll(const ASearchText: string; AOptions: TgtSearchTypes;
      SearchEvent: TgtSearchEvent; StartPage: Integer = 1); overload;
    procedure SearchAll(const ASearchText: string; AOptions: TgtSearchTypes;
      var SearchList: TgtStringList; StartPage: Integer = 1); overload;
    procedure ActivateLinks(APageRange: string); overload;
    procedure ActivateLinks; overload;
{$IFDEF EXPOSEGDIINIT}
    procedure StartGDIPlus;
    procedure StopGDIPlus;
{$ENDIF}
  end;

implementation

uses
  SysUtils, Math, PDSearchDev, PDExportDevice, gtObject, PDState, gtTypes,
  PDImage, PDForm, Forms, PDMatrix, PDIGDIPlus, gtStreamAdpt, ActiveX,
  PDFont, FontProcessor, PDCIDFont;

type
  
  TgtEnumElementsDev = class(TgtPDExportDevice)
  private
    // Common
    FDC: HDC;
    FGraphics: IGPGraphics;
    FCTM: TgtPDMatrix;
    FStateStack: TList;
    FCurrentPath: IGPGraphicsPath;
    FFont: IGPFont;
    FFontFamily: IGPFontFamily;
    FFontProcessor: TgtFontProcessor;

    FElementTypes: TgtElementTypes;
    FTextType: TgtPDFTextType;
    FMMUnit: TgtMeasurementUnit;
    FCallBackEvent: TgtEnumPageElementCallBack;
    FPageNo: Integer;
    //Text
    FTextDev: TgtPDSearchDev;
    FTextList: TgtWideStringList;
    FFontList: TStrings;
    //Text

    function MakeTextElement(const ATextList: TgtWideStringList; AIndex: Integer)
      : TgtPDFTextElement;
    function MakeImageElement: TgtPDFImageElement;
    function IsRectValid(ARect: TRect): Boolean;
    procedure DrawCharacter(AGlyphPoints: TgtPointsList; AdvanceWidth, AdvanceHeight: Double;
      EvenOddFill: Boolean; ReverseFill: Boolean);
  public
    constructor Create(ElementTypes: TgtElementTypes; TextType: TgtPDFTextType;
      aMUnit: TgtMeasurementUnit; CallBackEvent: TgtEnumPageElementCallBack);
    destructor Destroy; override;

    function CheckPageSlice(Page: TgtObject; hDPI: Double; vDPI: Double;
      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; SliceX: Double;
      SliceY: Double; SliceW: Double; SliceH: Double): Boolean; override;

    procedure StartPage(nPage: Integer; State: TgtPDState); override;

    procedure EndPage; override;

    procedure SaveState(State: TgtPDState); override;
    procedure RestoreState(State: TgtPDState); override;

    procedure Stroke(State: TgtPDState); override;
    procedure Fill(State: TgtPDState); override;
    procedure EvenOddFill(State: TgtPDState); override;

    procedure Clip(State: TgtPDState); override;
    procedure EvenOddClip(State: TgtPDState); override;
    procedure ClipToStrokePath(State: TgtPDState); override;

    procedure DrawChar(State: TgtPDState; X: Double; Y: Double;
      Dx, Dy: Double; Code: TgtCharCode; const CharName: AnsiString); override;
    procedure DrawImage(State: TgtPDState; Image: TgtPDImage); override;
    procedure DrawFormXObject(State: TgtPDState; Form: TgtPDForm); override;

    procedure DrawString(const Str: AnsiString; State: TgtPDState); override;
    procedure BeginString(State: TgtPDState; Str: AnsiString); override;
    procedure EndString(State: TgtPDState); override;

    procedure UpdateFont(State: TgtPDState); override;
    procedure UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix); override;

    procedure RawTextOut(State: TgtPDState; X, Y: Double;
      const AText: Ansistring); override;

    property FontList: TStrings read FFontList write FFontList;
  end;

{ TgtExProPDFDocument }

procedure TgtExProPDFDocument.ActivateLinks(APageRange: string);
//var
//  LPages: TgtPageNumbers;
//  LI: Integer;
begin
//  LPages := GetPages(APageRange, PageCount);
//  for LI := 0 to Length(LPages) - 1 do
//  begin
//    ActivateLinks(LPages[LI]);
//  end;
end;


procedure TgtExProPDFDocument.ActivateLinks;
//var
//  LI: Integer;
begin
//  if not Assigned(FPDDoc) then
//  begin
//    Exit;
//  end;
//
//  for LI := 1 to FPDDoc.PageCount do
//  begin
//    ActivateLinks(LI);
//  end;
end;

//procedure TgtExProPDFDocument.AddLinkAnnot(AStrSizeToCalculate,
//  AHyperLinkStr: string; AStartPos: Integer; ATextElement: TgtPDFTextElement;
//  APageHeight: Double; AFound: Boolean; APageNo: Integer);
//var
//  LURIAction: TgtPDFURIAction;
//  LLaunchAction: TgtPDFLaunchAction;
//  LLinkAnnot: TgtPDFLinkAnnotation;
//  LTempStr: string;
//begin
//  LLinkAnnot := TgtPDFLinkAnnotation.Create;
//  LLinkAnnot.BackgroundColor := clWhite;
//  //Set the LinkAnnot Rect values
//  if AStartPos = 1 then
//  begin
//    LLinkAnnot.RectTop := ATextElement.YCordOrigin -
//      (TextSize(AStrSizeToCalculate, ATextElement.Font).cy * 0.75);
//    LLinkAnnot.RectLeft :=  ATextElement.XCordOrigin;
//    LLinkAnnot.RectBottom :=  ATextElement.YCordOrigin + 6;
//    LLinkAnnot.RectRight :=  ATextElement.XCordOrigin +
//      (TextSize(AStrSizeToCalculate, ATextElement.Font).cx * 0.75);
//  end
//  else
//  begin
//    LTempStr := LeftStr(ATextElement.Text, AStartPos);
//    LLinkAnnot.RectTop := APageHeight - ATextElement.YCordOrigin +
//      6 - ATextElement.Font.Size;
//    LLinkAnnot.RectLeft := ATextElement.XCordOrigin +
//      TextSize(LTempStr, ATextElement.Font).cx;
//    LLinkAnnot.RectBottom := APageHeight - ATextElement.YCordOrigin - 6 -
//      ATextElement.Font.Size;
//    LLinkAnnot.RectRight := LLinkAnnot.RectLeft +
//      TextSize(AStrSizeToCalculate, ATextElement.Font).cx;
//  end;
//  //if any hyperlink keywords found then
//  if AFound then
//  begin
//    LURIAction := TgtPDFURIAction.Create;
//    LURIAction.URI := AHyperLinkStr;
//    LLinkAnnot.Action := LURIAction;
//  end
//  else
//  begin //it might be a file open action
//    LLaunchAction := TgtPDFLaunchAction.Create;
//    LLaunchAction.ApplicationToLaunch := CreateFileSpecStr(AHyperLinkStr);
//    LLaunchAction.LaunchActionType := atOpen;
//    LLinkAnnot.Action := LLaunchAction;
//  end;
//  InsertAnnotation(LLinkAnnot, APageNo);
//end;

//procedure TgtExProPDFDocument.ActivateLinks(APageNo: Integer);
//const
//  HyperLinkKeywords: array[0..4] of AnsiString = ('http', 'www', 'ftp', '@', ':\');
//  DomainNames: array[1..18] of string = ('.com', '.org', '.net', '.co.', '.biz',
//    '.edu', '.gov', '.info', '.name', '.int', '.uk', '.in', '.us', '.au', '.ch',
//    '.ie', '.de', '.co');
//  FileExtNames: array[1..14] of string = ('.htm', '.html', '.pdf', '.doc',
//    '.xls', '.jsp', '.xml', '.txt', '.ppt', '.aspx', '.asp', '.chtml', '.xhtml',
//    '.shtml');
//var
////  LPageElementList: TgtPDFPageElementList;
//  LStrList: TStringList;
//  LPageHeight: Double;
//  LFont: TFont;
//  LX, LY: Double;
//  LI, LJ, LK, LStartPos, LStart, LDots: Integer;
//  LFirstTextItem, LNextTextItem, LHyperLinkStr, LHyperLinkStrDiv: string;
//  LFound, LDomainFound, LDomainFoundAgain, LFileExtFound: Boolean;
//  LTextElement: TgtPDFTextElement;
//begin
//  LFont := TFont.Create;
//  LFont.Size := 18;
//  LFont.Name := 'Arial'; //Default
//
//  LStrList := ExtractTextFormatted(APageNo);
//  LPageHeight := GetPageSize(APageNo, muPoints).Height;
//
//  for LI := 0 to LStrList.Count - 1 do
//  begin
//    LTextElement := TgtPDFTextElement(LStrList.Objects[LI]);
//    if Assigned(LTextElement) then
//    begin
//      LX := LTextElement.XCordOrigin;
//      LY := LTextElement.YCordOrigin;
//      LFont.Assign(LTextElement.Font);
//      LFont.Size := Round(PixelsToPoints(LTextElement.Font.Size));
//      LFirstTextItem := LTextElement.ActualText;
//
//      LFound := False;
//      LDomainFound := False;
//      for LJ := Low(HyperLinkKeywords) to High(HyperLinkKeywords) do
//      begin
//        //Check if the text elt has any hyperlink words
//        if (AnsiContainsText(AnsiLowerCase(LFirstTextItem),
//          HyperLinkKeywords[LJ]) = true) then
//        begin
//          LFound := True;
//          //Get the starting pos of the keyword in the curr text elt
//          LStartPos := Pos(HyperLinkKeywords[LJ], AnsiLowerCase(LFirstTextItem));
//          LStart := LStartPos;
//          //Extract only the hyperlink text from the curr text elt
//          while (LStartPos <= Length(LFirstTextItem)) do
//          begin
//            LHyperLinkStr := LHyperLinkStr + LFirstTextItem[LStartPos];
//            INC(LStartPos);
//            if ((LFirstTextItem[LStartPos] = ' ') or
//              (LFirstTextItem[LStartPos] = '>') or
//              (LFirstTextItem[LStartPos] = '<') or
//              (LFirstTextItem[LStartPos] = ')') or
//              (LFirstTextItem[LStartPos] = '}')) then
//            begin
//              Break;
//            end;
//          end;
//          //In the hyperlink text, check if contains any domain names
//          for LK := 1 to 18 do
//          begin
//            if (AnsiContainsText(AnsiLowerCase(LHyperLinkStr),
//              DomainNames[LK])) then
//            begin
//              LDomainFound := True;
//              Break;
//            end;
//          end;
//          //If Domain found, check for FileExtNames if any
//          if (LDomainFound = True) then
//          begin
//            for LK := 1 to 14 do
//            begin
//              if (AnsiContainsText(AnsiLowerCase(LHyperLinkStr),
//                FileExtNames[LK]) = True) then
//              begin
//                LFileExtFound := True;
//                LHyperLinkStr := LeftStr(LHyperLinkStr, Pos(FileExtNames[LK],
//                  LHyperLinkStr) - 1) + FileExtNames[LK];
//                Break;
//              end;
//            end;
//            //If FileExt is also found then
//            if ((LFileExtFound = True)) then
//            begin
//              LK := 0;
//              LDots := 0;
//              while LK < Length(LHyperLinkStr) do
//              begin
//                if (LHyperLinkStr[LK] = '.') then INC(LDots);
//                INC(LK);
//              end;
//              //Create linkAnnot
//              AddLinkAnnot(LHyperLinkStr, LHyperLinkStr, LStart, LTextElement,
//                LPageHeight, LFound, APageNo);
//            end
//            else
//            begin
//              if ((LI + 1) <> (LStrList.Count)) then // if not a last node then
//              begin
//                if ((LFileExtFound = False) or (LFound = True)) then
//                begin
//                  LDots := 0;
//                  LNextTextItem := TgtPDFTextElement(LStrList.Objects[LI + 1]).Text;
//                  for LK := 1 to 18 do
//                  begin
//                    if (AnsiContainsText(
//                      AnsiLowerCase(LNextTextItem), DomainNames[LK])) then
//                    begin
//                      LDomainFoundAgain := True;
//                      Break;
//                    end;
//                  end;
//                  if AnsiContainsText(LNextTextItem, ' ') then
//                    LNextTextItem := LeftStr(LNextTextItem, pos(' ', LNextTextItem));
//                  for LK := 1 to 14 do
//                  begin
//                    if (AnsiContainsText(
//                      AnsiLowerCase(LNextTextItem), FileExtNames[LK]) = True) then
//                    begin
//                      //Divided On Two Lines
//                      LNextTextItem := LeftStr(LNextTextItem,
//                        pos(FileExtNames[LK], LNextTextItem) - 1) +
//                        FileExtNames[LK];
//                      LHyperLinkStrDiv := LHyperLinkStr + LNextTextItem;
//                      if (LDomainFoundAgain <> True) then LFileExtFound := True;
//                      Break;
//                    end;
//                  end;
//
//                  if ((LDomainFound) and (LFileExtFound) and
//                    ((LPageHeight -
//                    TgtPDFPageElement(LStrList.Objects[LI]).YCordOrigin) =
//                    (LPageHeight -
//                    TgtPDFPageElement(LStrList.Objects[LI + 1]).YCordOrigin))) then
//                  begin
//                    //Divided in two Nodes but are on th same line as Y cords ar same.
//                    AddLinkAnnot(LHyperLinkStrDiv, LHyperLinkStrDiv, LStart,
//                      LTextElement, LPageHeight, LFound, APageNo);
//                  end
//                  else
//                    if ((LDomainFound) and (LFileExtFound) and
//                      ((LPageHeight -
//                      TgtPDFPageElement(LStrList.Objects[LI]).YCordOrigin)
//                      > (LPageHeight -
//                      TgtPDFPageElement(LStrList.Objects[LI + 1]).YCordOrigin))) then
//                    begin
//                      AddLinkAnnot(LHyperLinkStr, LHyperLinkStrDiv, LStart, LTextElement,
//                        LPageHeight, LFound, APageNo);
//                      LStart := 1;
//                      LX := TgtPDFPageElement(LStrList.Objects[LI + 1]).XCordOrigin;
//                      LY := TgtPDFPageElement(LStrList.Objects[LI + 1]).YCordOrigin;
//                      AddLinkAnnot(LNextTextItem, LHyperLinkStrDiv, LStart, LTextElement,
//                        LPageHeight, LFound, APageNo);
//                    end
//                    else // found Domain but not extension
//                      AddLinkAnnot(LHyperLinkStr, LHyperLinkStr, LStart, LTextElement,
//                        LPageHeight, LFound, APageNo);
//                end;
//              end
//              else if LI + 1 = LStrList.Count then //if a last node then create hyperlink.
//                AddLinkAnnot(LHyperLinkStr, LHyperLinkStr, LStart, LTextElement,
//                  LPageHeight, LFound, APageNo);
//            end;
//          end
//          else //if finds extension with domain name other than that considered here
//          begin
//            for LK := 1 to 14 do
//            begin
//              if (AnsiContainsText(
//                AnsiLowerCase(LHyperLinkStr), FileExtNames[LK]) = True) then
//              begin
//                LFileExtFound := True;
//                LNextTextItem := LeftStr(LNextTextItem,
//                  pos(FileExtNames[LK], LNextTextItem) - 1) + FileExtNames[LK];
//                LHyperLinkStrDiv := LHyperLinkStr; // + LStr1;
//                Break;
//              end;
//            end;
//            if (LFileExtFound = True) then
//              AddLinkAnnot(LHyperLinkStrDiv, LHyperLinkStrDiv, LStart,
//                LTextElement, LPageHeight, LFound, APageNo)
//            else
//            begin
//              LDots := 0;
//              LNextTextItem :=
//                TgtPDFTextElement(LStrList.Objects[LI + 1]).Text;
//              if AnsiContainsText(LNextTextItem, ' ') then
//                LNextTextItem := LeftStr(LNextTextItem,
//                  pos(' ', LNextTextItem));
//              for LK := 1 to 20 do
//              begin
//                if (AnsiContainsText(AnsiLowerCase(LNextTextItem),
//                  DomainNames[LK]) = true) then
//                begin
//                  Break;
//                end;
//              end;
//              for LK := 1 to 20 do
//              begin
//                if (AnsiContainsText(
//                  AnsiLowerCase(LNextTextItem), FileExtNames[LK]) = true) then
//                begin
//                  LNextTextItem := LeftStr(LNextTextItem,
//                    pos(FileExtNames[LK], LNextTextItem) - 1) + FileExtNames[LK];
//                  LHyperLinkStrDiv := LHyperLinkStr + LNextTextItem;
//                  LFileExtFound := True;
//                  Break;
//                end;
//              end;
//              if (LFound and LFileExtFound and
//                ((LPageHeight -
//                TgtPDFPageElement(LStrList.Objects[LI]).YCordOrigin) =
//                (LPageHeight -
//                TgtPDFPageElement(LStrList.Objects[LI + 1]).YCordOrigin))) then
//              begin
//                AddLinkAnnot(LHyperLinkStrDiv, LHyperLinkStrDiv, LStart, LTextElement,
//                  LPageHeight, LFound, APageNo)
//              end
//              else
//                if (LFound and LFileExtFound and
//                  ((LPageHeight -
//                  TgtPDFPageElement(LStrList.Objects[LI]).YCordOrigin) >
//                  (LPageHeight -
//                  TgtPDFPageElement(LStrList.Objects[LI + 1]).YCordOrigin))) then
//                begin
//                  AddLinkAnnot(LHyperLinkStr, LHyperLinkStrDiv, LStart,
//                    LTextElement, LPageHeight, LFound, APageNo);
//                  LStart := 1;
//                  LX := TgtPDFPageElement(LStrList.Objects[LI + 1]).XCordOrigin;
//                  LY := TgtPDFPageElement(LStrList.Objects[LI + 1]).YCordOrigin;
//                  AddLinkAnnot(LNextTextItem, LHyperLinkStrDiv, LStart, LTextElement,
//                    LPageHeight, LFound, APageNo)
//                end;
//            end;
//            if ((LDomainFound = True) and (LFileExtFound = False)) then
//              AddLinkAnnot(LHyperLinkStrDiv, LHyperLinkStrDiv, LStart,
//                LTextElement, LPageHeight, LFound, APageNo)
//          end;
//        end; //end of if condition, if text has any hyperlink words.
//      end; //end of for loop, traversing through all hyperlink keyword
//    end;
//  end; //end of for loop, for looping through all text elts in a page
//  for LI := 0 to LStrList.Count - 1 do
//  begin
//    LStrList.Objects[LI].Free;
//  end;
//  LStrList.Free;
//  if Assigned(LFont) then
//    FreeAndNil(LFont);
//end;

constructor TgtExProPDFDocument.Create(AOwner: TComponent);
begin
  inherited;
end;

function TgtExProPDFDocument.CreateFileSpecStr(AStr: string): string;
begin
  Result := '';
  if AnsiContainsText(AStr, ':\') then
  begin
    AStr := ReplaceString(Astr, ':\', '/');
    AStr := '/' + AStr;
  end;
  while AnsiContainsText(AStr, '\\') do
    AStr := ReplaceString(AStr, '\\', '/');
  AStr := ReplaceString(AStr, '\', '/');
  Result := AStr;
end;

destructor TgtExProPDFDocument.Destroy;
begin
  inherited;
end;

procedure TgtExProPDFDocument.EnumPageElements(aPageNumber: Integer;
  aElementTypes: TgtElementTypes; aMUnit: TgtMeasurementUnit;
  TextType: TgtPDFTextType; CallBackEvent: TgtEnumPageElementCallBack);
var
  LEnumPageElemDev: TgtEnumElementsDev;
begin
  LEnumPageElemDev := TgtEnumElementsDev.Create(aElementTypes, TextType, aMUnit,
    CallBackEvent);
  try
    // Get Fonts will be required
    if not Assigned(FPDDoc.FontList) then
      FPDDoc.FontList := GetFonts;
    LEnumPageElemDev.FontList := FPDDoc.FontList;
    FPDDoc.DisplayPage(LEnumPageElemDev, aPageNumber, 72,
      72, 0, True, False, False, False);
  finally
    LEnumPageElemDev.Free;
  end;
end;

function TgtExProPDFDocument.ExtractTextFormatted(
  APageNo: Integer): TgtWideStringList;
begin
  if Assigned(FPDDoc) then
  begin
    Result := ExtractTextFromPage(APageNo, True)
  end;
end;

function TgtExProPDFDocument.GetPageElements(APageNo: Integer;
  ElementTypes: TgtElementTypes;
  MMUnit: TgtMeasurementUnit): TgtPDFPageElementList;
begin
//  if not Assigned(FPageElementList) then
  FPageElementList := TgtPDFPageElementList.Create;
  EnumPageElements(APageNo, ElementTypes, MMUnit, ttLine, EnumCallBack);
  Result := FPageElementList;
end;

//function TgtExProPDFDocument.GetPageElements(APageNo: Integer;
//  ElementTypes: TgtElementTypes;
//  MMUnit: TgtMeasurementUnit): TgtPDFPageElementList;
//begin
//
//end;

procedure TgtExProPDFDocument.RenderImageToCanvas(aDC: HDC; aStream: TStream;
  aWidth, aHeight: Cardinal; aRotate: Integer);
begin
  FPDDoc.RenderImageToDC(aStream, aDC, aWidth, aHeight, 72, 72, aRotate, True, False);
end;

procedure TgtExProPDFDocument.RenderToCanvas(PageNo: Integer; ACanvas: TCanvas;
  aTextPrecision: TgtTextOutputPrecision; RotationAngle: Integer);
begin
  FPDDoc.RenderToCanvas(ACanvas.Handle, PageNo, Round(Self.GetPageSize(PageNo, muPixels).Width),
    Round(Self.GetPageSize(PageNo, muPixels).Height), 72, 72, RotationAngle,
    True, False);
end;

procedure TgtExProPDFDocument.RenderToDC(aDC: Cardinal; aWidth, aHeight: Cardinal;
  aPageNum: Integer; axDPI, ayDPI: Double; aRotationAngle: Integer;
  aAntiAliasing, aForPrinting: Boolean);
begin
  FPDDoc.RenderToCanvas(aDC, aPageNum, aWidth, aHeight, axDPI, ayDPI,
    aRotationAngle, aAntiAliasing, aForPrinting);
end;

procedure TgtExProPDFDocument.RenderToStream(aEMFPlusStream: TStream;
  aPageNum: Integer; aWidth, aHeight: double; axDPI, ayDPI: Double;
  aRotationAngle: Integer; aAntiAliasing, aForPrinting: Boolean);
begin
  FPDDoc.RenderToMetafile(aEMFPlusStream, aPageNum, Round(aWidth), Round(aHeight),
    axDPI, ayDPI, aRotationAngle, aAntiAliasing, aForPrinting);
end;

procedure TgtExProPDFDocument.SearchAll(const ASearchText: string;
  AOptions: TgtSearchTypes; SearchEvent: TgtSearchEvent; StartPage: Integer);
var
  I: Integer;
  LSearchList: TgtStringList;
  Continue: Boolean;
begin
  for I := StartPage to PageCount do
  begin
    LSearchList := TgtStringList.Create;
    SearchInPage(I, ASearchText, AOptions, LSearchList);
    if Assigned(SearchEvent) then
    begin
      Continue := True;
      SearchEvent(Self, LSearchList, I, Continue);
      if not Continue then
      begin
        LSearchList.Free;
        Exit;
      end;
    end;
    LSearchList.Free;
  end;
end;

////procedure TgtExProPDFDocument.SaveToImage(Filename: String;
////  ImageFormat: TImageFormat);
////begin
////
////end;

procedure TgtExProPDFDocument.SearchAll(const ASearchText: string;
  AOptions: TgtSearchTypes; var SearchList: TgtStringList; StartPage: Integer);
var
  I: Integer;
begin
  for I := StartPage to PageCount do
    SearchInPage(I, ASearchText, AOptions, SearchList);
end;

procedure TgtExProPDFDocument.SearchInPage(PageNum: Integer; const Asearchtext: string;
  AOptions: TgtSearchTypes; var SearchList: TgtStringList);
var
  LLinesHandle: Cardinal;
  LText: WideString;
  LLinesCount: Integer;
  LPos, NextSearchPos: Integer;
  LSearchElement: TgtSearchElement;
  I, J: Integer;
  LRect, LFinalRect: TRect;
  LLineList: TgtWideStringList;
const
  CFactor = 96/72;
begin
  LLineList := TgtWideStringList.Create;
  try
    SearchText(LLineList, PageNum);
    LLinesCount := LLineList.Count;
    for I := 0 to LLinesCount - 1 do
    begin
      NextSearchPos := 1;
      LText := String(linesGetText(LLineList, I));
      repeat
        LPos := SearchInStr(ASearchtext, LText, NextSearchPos, AOptions);
        if LPos > 0 then
          begin
            LSearchElement := TgtSearchElement.Create;

            LSearchElement.PageNum := PageNum;

            LSearchElement.IndexToSearchStr := LPos;
            LSearchElement.Line := String(LText);

            lineGetCharRect(LLineList, I, LPos, LRect);
            LFinalRect.Left := LRect.Left;
            LFinalRect.Top := LRect.Top;
            LFinalRect.Right := LRect.Right;
            LFinalRect.Bottom := LRect.Bottom;

            for J := LPos + 1 to LPos + Length(Asearchtext) - 1 do
            begin
              lineGetCharRect(LLineList, I, J, LRect);
              if LRect.Left <> 0 then
                LFinalRect.Left := Min(LFinalRect.Left, LRect.Left);
              if LRect.Top <> 0 then
                LFinalRect.Top := Min(LFinalRect.Top, LRect.Top);
              LFinalRect.Right := Max(LFinalRect.Right, LRect.Right);
              LFinalRect.Bottom := Max(LFinalRect.Bottom, LRect.Bottom);
            end;

            LFinalRect.Left := Round(LFinalRect.Left * CFactor);
            LFinalRect.Top := Round(LFinalRect.Top * CFactor);
            LFinalRect.Right := Round(LFinalRect.Right * CFactor);
            LFinalRect.Bottom := Round(LFinalRect.Bottom * CFactor);

            LSearchElement.BoundingRect := LFinalRect;
            SearchList.AddObject(LText, LSearchElement);
            NextSearchPos := LPos + Length(Asearchtext);
          end;
      until (LPos = 0);
    end;
  finally
    freeLines(LLineList);
  end;
end;

function TgtExProPDFDocument.SearchInStr(const Searchtext, Text: string;
  StartPos: Integer; Options: TgtSearchTypes): Integer;
var
  LSearchStr, LText: string;
begin
  if not (stWholeWord in Options) then
  begin
    LText := Text;
    LSearchStr := Searchtext;
  end
  else
  begin
    LText := Text;
    LSearchStr := Searchtext + ' ';
  end;

  if not (stCaseSensitive in Options) then
  begin
    LText := AnsiUpperCase(Text);
    LSearchStr := AnsiUpperCase(LSearchStr);
    Result := PosExx(LSearchStr, LText, StartPos);
  end;

  Result := PosExx(LSearchStr, LText, StartPos);
end;

procedure TgtExProPDFDocument.SearchText(AResultList: TgtWideStringList;
  APageNo: Integer);
var
  LSearchDev: TgtPDSearchDev;
begin
  LSearchDev := TgtPDSearchDev.Create(AResultList);
  try
    if not Assigned(FPDDoc.FontList) then
      FPDDoc.FontList := GetFonts;
    LSearchDev.FontList := FPDDoc.FontList;

    FPDDoc.DisplayPage(LSearchDev, APageNo, 72, 72, 0, True,
      False, False, False);
  finally
    LSearchDev.Free;
  end;
end;

{$IFDEF EXPOSEGDIINIT}
procedure TgtExProPDFDocument.StartGDIPlus;
begin
  if Assigned(FPDDoc) then
  begin
    FPDDoc.StartGDIPlus;
  end;
end;

procedure TgtExProPDFDocument.StopGDIPlus;
begin
  if Assigned(FPDDoc) then
  begin
    FPDDoc.StopGDIPlus;
  end;
end;
{$ENDIF}

function TgtExProPDFDocument.SearchNext(
  aCurrentSearchElement: TgtSearchElement): TgtSearchElement;
begin
  Result := nil;
  if not Assigned(FSearchList) then
    Exit;

  if aCurrentSearchElement.FSearchIndex = FSearchList.Count - 1 then
  begin
    FCurrentSearchPage := FCurrentSearchPage + 1;
    if FCurrentSearchPage <= Self.PageCount then
    begin
      FSearchList.Free;
      FSearchList := TgtStringList.Create;

      SearchInPage(FCurrentSearchPage, FSearchStr, FSearchOptions, FSearchList);
      if FSearchList.Count > 0 then
      begin
        TgtSearchElement(FSearchList.Objects[0]).FSearchIndex := 0;
        Result := TgtSearchElement(FSearchList.Objects[0]);
      end
      else
      begin
        Result := TgtSearchElement.Create;
        Result.PageNum := FCurrentSearchPage;
        Result.IndexToSearchStr := 0;
        FSearchList.Add('');
      end;
    end;
  end
  else
  begin
    TgtSearchElement(FSearchList.Objects[aCurrentSearchElement.FSearchIndex + 1]).
      FSearchIndex := aCurrentSearchElement.FSearchIndex + 1;
    Result := TgtSearchElement(FSearchList.Objects[aCurrentSearchElement.FSearchIndex + 1]);
  end;
end;

function TgtExProPDFDocument.SearchFirst(const Asearchtext: string;
  AOptions: TgtSearchTypes; PageNum: Integer): TgtSearchElement;
begin
  Result := nil;
  FCurrentSearchPage := PageNum;
  if (PageNum <= 0) or (PageNum > Self.PageCount) then
    FCurrentSearchPage := 1;
  FSearchStr := Asearchtext;
  FSearchOptions := AOptions;

  if Assigned(FSearchList) then FSearchList.Free;
  FSearchList := TgtStringList.Create;

  SearchInPage(FCurrentSearchPage, FSearchStr, AOptions, FSearchList);
  if FSearchList.Count > 0 then
  begin
    TgtSearchElement(FSearchList.Objects[0]).FSearchIndex := 0;
    Result := TgtSearchElement(FSearchList.Objects[0]);
  end;
end;

//////function TgtExProPDFDocument.AnsiPosI(const S, Substr: string; StartIndex: Integer): Integer;
//////var
//////  ATempStr: string;
//////begin
//////  ATempStr := Copy(S, StartIndex, MaxInt);
//////  Result := AnsiPos(Substr, ATempStr);
//////end;
////
//////function TgtExProPDFDocument.IsWholeMatch(const S, Patt: string; StartPos: Integer): Boolean;
//////var
//////  Newlength: Integer;
//////begin
//////  Newlength := StartPos + Length(Patt);
//////  Result := (not (S[StartPos - 1] in ['A'..'Z', 'a'..'z', '0'..'9']))
//////    and (not (S[Newlength] in ['A'..'Z', 'a'..'z', '0'..'9']));
//////end;
////
{ TgtSearchElement }

function TgtSearchElement.Copy: TgtSearchElement;
begin
  Result := TgtSearchElement.Create;
  Result.FIndex := Self.FIndex;
  Result.FRect := Self.FRect;
  Result.FText := Self.FText;
  Result.FPageNum := Self.FPageNum;
end;

{ TgtStringList }

destructor TgtStringList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    if Assigned(Objects[I]) then
      Objects[I].Free;
  end;
  inherited;
end;

{ TgtEnumElementsDev }

procedure TgtEnumElementsDev.BeginString(State: TgtPDState; Str: AnsiString);
begin
  inherited;
//  if etText in FElementTypes then
//  begin
//    FTextDev.BeginString(State, Str);
//  end;
end;

function TgtEnumElementsDev.CheckPageSlice(Page: TgtObject; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
  SliceH: Double): Boolean;
begin
  Result := True;
end;

procedure TgtEnumElementsDev.Clip(State: TgtPDState);
begin
  inherited;

end;

procedure TgtEnumElementsDev.ClipToStrokePath(State: TgtPDState);
begin
  inherited;

end;

constructor TgtEnumElementsDev.Create(ElementTypes: TgtElementTypes;
  TextType: TgtPDFTextType; aMUnit: TgtMeasurementUnit;
  CallBackEvent: TgtEnumPageElementCallBack);
begin
  FUseShadedFill := True;
  FNeedNonText := True;
  FInterpretType3Chars := True;
  FUseDrawChar := False;
  FUseDrawForm := True;
  FUseTillingPatternFill := True;
  FUpsideDown := True;

  FElementTypes := ElementTypes;
  FTextType := TextType;
  FMMUnit := aMUnit;
  FCallBackEvent := CallBackEvent;

  if (etText in ElementTypes) then
  begin
    FTextList := TgtWideStringList.Create;
//    FTextDev := TgtPDSearchDev.Create(FTextList);
  end;


end;

destructor TgtEnumElementsDev.Destroy;
var
  I: Integer;
begin
  //Text
  if Assigned(FTextList) then
  begin
    for I := 0 to FTextList.Count - 1 do
    begin
      if Assigned(FTextList.Objects[I]) then
        TgtPDFTextElement(FTextList.Objects[I]).Free;
    end;
    FreeAndNil(FTextList);
  end;
  FGraphics := nil;
  ReleaseDC(0, FDC);
  if Assigned(FStateStack) then FStateStack.Free;
  if Assigned(FCTM) then FCTM.Free;

  inherited;
end;

procedure TgtEnumElementsDev.DrawChar(State: TgtPDState; X, Y, Dx, Dy: Double;
  Code: TgtCharCode; const CharName: AnsiString);
begin
  inherited;

//  if etText in FElementTypes then
//  begin
//    FTextDev.DrawChar(State, X, Y, Dx, Dy, Code, CharName);
//  end;
end;

procedure TgtEnumElementsDev.DrawCharacter(AGlyphPoints: TgtPointsList;
  AdvanceWidth, AdvanceHeight: Double; EvenOddFill, ReverseFill: Boolean);
var
  LI: Integer;
  StartX, StartY: Double;
  LP1X, LP1Y, LP2X, LP2Y: Double;
  LMulValue: Double;
  LInFigure: Boolean;
begin
  LI := 0;
  StartX := 0;
  StartY := 0;
  LMulValue := 1;
  LInFigure := False;

  while LI < Length(AGlyphPoints) do
  begin
    case Round(AGlyphPoints[LI]) of
      1:
        begin
          if LInFigure then
          FCurrentPath.CloseFigure;
          FCurrentPath.StartFigure;
          LInFigure := True;
          StartX := AGlyphPoints[LI + 1] * LMulValue;
          StartY := AGlyphPoints[LI + 2] * LMulValue;
          Inc(LI, 3);
        end;
      2:
        begin
          FCurrentPath.AddLineF(StartX, StartY, AGlyphPoints[LI + 1] * LMulValue, AGlyphPoints[LI + 2] * LMulValue);
          StartX := AGlyphPoints[LI + 1] * LMulValue;
          StartY := AGlyphPoints[LI + 2] * LMulValue;
          Inc(LI, 3);
        end;
      3:
        begin
          LP1X := StartX + 2.0 / 3.0 * (AGlyphPoints[LI + 1] * LMulValue - StartX);
          LP1Y := StartY + 2.0 / 3.0 * (AGlyphPoints[LI + 2] * LMulValue - StartY);
          LP2X := LP1X + (AGlyphPoints[LI + 3] * LMulValue - StartX) / 3.0;
          LP2Y := LP1Y + (AGlyphPoints[LI + 4] * LMulValue - StartY) / 3.0;

          FCurrentPath.AddBezierF(StartX, StartY, LP1X, LP1Y,
            LP2X, LP2Y, AGlyphPoints[LI + 3] * LMulValue, AGlyphPoints[LI + 4] * LMulValue);
          StartX := AGlyphPoints[LI + 3] * LMulValue;
          StartY := AGlyphPoints[LI + 4] * LMulValue;
          Inc(LI, 5);
        end;
      4:
        begin
          FCurrentPath.AddBezierF(StartX, StartY, AGlyphPoints[LI + 1] * LMulValue,
            AGlyphPoints[LI + 2] * LMulValue, AGlyphPoints[LI + 3] * LMulValue,
            AGlyphPoints[LI + 4] * LMulValue, AGlyphPoints[LI + 5] * LMulValue,
            AGlyphPoints[LI + 6] * LMulValue);
          StartX := AGlyphPoints[LI + 5] * LMulValue;
          StartY := AGlyphPoints[LI + 6] * LMulValue;
          Inc(LI, 7);
        end;
    end;
  end;
  FCurrentPath.CloseFigure;
  if EvenOddFill then
    FCurrentPath.SetFillMode(FillModeAlternate);
end;

procedure TgtEnumElementsDev.DrawFormXObject(State: TgtPDState;
  Form: TgtPDForm);
begin
  inherited;
  if not (etFormField in FElementTypes) then Exit;
end;

procedure TgtEnumElementsDev.DrawImage(State: TgtPDState; Image: TgtPDImage);
var
  LImageEle: TgtPDFImageElement;
begin
  if (etImage in FElementTypes) then
  begin
    Image.SetState(State);
    LImageEle := MakeImageElement;
    Image.SaveToStream(LImageEle.Image, ofBMP);
    FCallBackEvent(Self, LImageEle, etImage, FPageNo);
  end;
end;

procedure TgtEnumElementsDev.DrawString(const Str: AnsiString;
  State: TgtPDState);
begin
  inherited;

end;

procedure TgtEnumElementsDev.EndPage;
var
  I: Integer;
  LPageElement: TgtPDFPageElement;
begin
  inherited;
  if etText in FElementTypes then
  begin
//    FTextDev.EndPage;
    for I := 0 to FTextList.Count - 1 do
    begin
      LPageElement := MakeTextElement(FTextList, I);
      FCallBackEvent(Self, LPageElement, etText, FPageNo);
    end;
  end;
end;

procedure TgtEnumElementsDev.EndString(State: TgtPDState);
begin
  inherited;
//  if etText in FElementTypes then
//  begin
//    FTextDev.EndString(State);
//  end;
end;

procedure TgtEnumElementsDev.EvenOddClip(State: TgtPDState);
begin
  inherited;

end;

procedure TgtEnumElementsDev.EvenOddFill(State: TgtPDState);
begin
  inherited;

end;

procedure TgtEnumElementsDev.Fill(State: TgtPDState);
begin
  inherited;

end;

function TgtEnumElementsDev.IsRectValid(ARect: TRect): Boolean;
begin
  Result := True;
  if (ARect.Left = 0) and (ARect.Top = 0) and
     (ARect.Right = 0) and (ARect.Bottom = 0) then
    Result := False;
end;

function TgtEnumElementsDev.MakeImageElement: TgtPDFImageElement;
var
  LCurrentPath: IGPGraphicsPath;
  LRect: TGPRectF;
begin
  Result := TgtPDFImageElement.Create;
  LCurrentPath := TGPGraphicsPath.Create;
  LCurrentPath.AddRectangle(MakeRect(0, -1, 1, 1));
  LCurrentPath.Transform(FGraphics.GetTransform);
  LRect := LCurrentPath.GetBoundsF;
  Result.X := ConvertToMu(FMMUnit, LRect.X);
  Result.Y := ConvertToMu(FMMUnit, LRect.Y);
  Result.Width := ConvertToMu(FMMUnit, LRect.Width + LRect.X);
  Result.Height := ConvertToMu(FMMUnit, LRect.Height + LRect.Y);
  LCurrentPath := nil;;
end;

function TgtEnumElementsDev.MakeTextElement(const ATextList: TgtWideStringList;
  AIndex: Integer): TgtPDFTextElement;
var
  LRect: TRect;
  LFont: TgtPDFFont;
  Lobj: TgtPDFTextElement;
begin
  Result := TgtPDFTextElement.Create;
  LObj := TgtPDFTextElement(ATextList.Objects[AIndex]);
  with Result do
  begin
    Text := Lobj.Text;
    LRect.Left := Round(ConvertToMU(FMMUnit, LObj.Rect.Left));
    LRect.Top := Round(ConvertToMU(FMMUnit, LObj.Rect.Top));
    LRect.Bottom := Round(ConvertToMU(FMMUnit, LObj.Rect.Bottom));
    LRect.Right := Round(ConvertToMU(FMMUnit, LObj.Rect.Right));
    Rect := LRect;
    X := Rect.Left;
    Y := Rect.Top;
    PageNum := LObj.PageNum;
  end;
end;

procedure TgtEnumElementsDev.RawTextOut(State: TgtPDState; X, Y: Double;
  const AText: Ansistring);
var
  LS: WideString;
  LBaseLineOffset: Double;
  LSave: Cardinal;
  LFormatString: IGPStringFormat;
  LX, LY, LDy: Double;
  LFontSize: Integer;
  LMatrix: IGPMatrix;
  LRect: TGPRect;
  I: Integer;
  LStartY: Double;
  LPoint: TGPPointF;
  LObj: TObject;
  LUnicodeTable: TToUnicodeTable;
  LFont: TgtPDFont;
  LLength: Integer;
  Code: TgtCharCode;
  LCharName: AnsiString;
  Dx, Dy, OrginX, OrginY: Double;
  LProcessed: Integer;
  LUnicodes: TgtUnicodes;
  LText, LFinalText: Widestring;
  LTextElement: TgtPDFTextElement;
  LFinalRect: TRect;
begin
  LText := '';
  LFinalText := '';
  LLength := Length(AText);
  I := 1;
  LFont := State.Font;
  LTextElement := nil;
  while I <= LLength do
  begin
    LFont.GetNextChar(AText, I, LProcessed, Code, LCharName, Dx, Dy,
      OrginX, OrginY);
    LText := LText + Widechar(Code);
//    I := I + LProcessed;

    LSave := FGraphics.Save;

    if Assigned(FCTM) then
    begin
      LMatrix := TGPMatrix.Create;
      try
        LMatrix.SetElements(State.TextMatrix.M11, -State.TextMatrix.M12,
          -State.TextMatrix.M21, State.TextMatrix.M22, State.TextMatrix.Dx,
          -State.TextMatrix.Dy);
        FGraphics.MultiplyTransform(LMatrix);
      finally
        LMatrix := nil;
      end;
    end
    else
    begin
      LMatrix := TGPMatrix.Create;
      try
        LMatrix.SetElements(State.TextMatrix.M11, -State.TextMatrix.M12,
          -State.TextMatrix.M21, State.TextMatrix.M22, State.TextMatrix.Dx,
          State.PageHeight - State.TextMatrix.Dy);
        FGraphics.SetTransform(LMatrix);
      finally
        LMatrix := nil;
      end;
    end;

    LMatrix := TGPMatrix.Create;
    LMatrix := FGraphics.GetTransform;

    LPoint.X := X;
    LPoint.Y := Y;

    //LMatrix.TransformPointsF([MakePointF( X, Y )]);
    LStartY := LPoint.Y;
    LMatrix := nil;

    if Assigned(FFont) then
    begin
      FGraphics.TranslateTransform(X, -Y);

      LS := WideChar(Code);
      if Assigned(FFontFamily) then
        LBaseLineOffset := FFont.GetSize / FFontFamily.GetEmHeight(FFont.GetStyle)
          * FFontFamily.GetCellAscent(FFont.GetStyle)
      else
        LBaseLineOffset := FFont.GetSize;

      LBaseLineOffset := LBaseLineOffset + State.Rise;
      LFormatString := TGPStringFormat.GenericTypographic;

      FCurrentPath := TGPGraphicsPath.Create;
      FCurrentPath.AddString(LS, FFontFamily, FFont.GetStyle, FFont.GetSize,
        MakePoint(0, -Round(LBaseLineOffset)), LFormatString);

      LMatrix := TGPMatrix.Create(State.HorizScaling, 0, 0, 1, 0, 0);
      FCurrentPath.Transform(LMatrix);
      LMatrix := nil;

      LMatrix := TGPMatrix.Create;
      LMatrix := FGraphics.GetTransform;
      FCurrentPath.Transform(LMatrix);
      LMatrix := nil;

      LRect := FCurrentPath.GetBounds;
      if I = 1 then
      begin
        // Giving maximun value of unsigned int to avoid X, y (0, 0) problem
        // when (0, 0) comes min will be always zero
        LFinalRect.Left := $7FFFFFFF;
        LFinalRect.Top := $7FFFFFFF;
        LFinalRect.Right := LRect.Width;
        LFinalRect.Bottom := LRect.Height;
      end;

      if LRect.X <> 0 then
        LFinalRect.Left := Min(LFinalRect.Left, LRect.X);
      if LRect.Y <> 0 then
        LFinalRect.Top := Min(LFinalRect.Top, LRect.Y);
      LFinalRect.Right := Max(LFinalRect.Right, LRect.Width);
      LFinalRect.Bottom := Max(LFinalRect.Bottom, LRect.Height);

      if not Assigned(LTextElement) then
        LTextElement := TgtPDFTextElement.Create;
      LTextElement.Rect := LFinalRect;
      LTextElement.PageNum := State.PageNumber;

      FCurrentPath := nil;
    end
    else if Assigned(FFontProcessor) then
    begin
      LS := WideChar(Code);

      LY := 0;
      LX := 0;

      if State.FontSize < 50 then
        LFontSize := 50
      else
        LFontSize := Round(State.FontSize);

      FCurrentPath := TGPGraphicsPath.Create;

      if (State.Font.FontType = Type1) or (State.Font.FontType = Type1C) or
        (State.Font.FontType = Type1COT) then
      begin
        if LCharName <> '' then
          FFontProcessor.DecomposeOutlineGlyph(LCharName, LFontSize, LX, LY, True,
            DrawCharacter, gtGlyphName)
        else
          FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
            DrawCharacter, gtCharacterCode)
      end
      else if State.Font.IsCIDFont then
      begin
        FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
          DrawCharacter, gtGlyphIndex);
        LUnicodeTable := TgtPDCIDFont(State.Font).GetToUnicode;
        if Assigned(LUnicodeTable) then
          Code := LUnicodeTable.Code[Code];
      end
      else
      begin
        if (FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
          DrawCharacter, gtCharacterCode) = NoWindowsCharacterMapFound) then
        begin
          LS := WideChar(Code + $F000);
          FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
            DrawCharacter, gtCharacterCode);
        end;
      end;

      if State.FontSize < 50 then
      begin
        LMatrix := TGPMatrix.Create(State.FontSize / 50, 0, 0,
          State.FontSize / 50, 0, 0);
        FCurrentPath.Transform(LMatrix);
        LMatrix := nil;
      end;

      FGraphics.TranslateTransform(X, -Y + State.Rise);

      LMatrix := TGPMatrix.Create(State.HorizScaling, 0, 0, 1, 0, 0);
      FCurrentPath.Transform(LMatrix);
      LMatrix := nil;

      LMatrix := TGPMatrix.Create;
      LMatrix := FGraphics.GetTransform;
      FCurrentPath.Transform(LMatrix);
      LMatrix := nil;

      LRect := FCurrentPath.GetBounds;

      if I = 1 then
      begin
        LFinalRect.Left := $7FFFFFFF;
        LFinalRect.Top := $7FFFFFFF;
        LFinalRect.Right := LRect.Width;
        LFinalRect.Bottom := LRect.Height;
      end;

      if LRect.X <> 0 then

        LFinalRect.Left := Min(LFinalRect.Left, LRect.X);
      if LRect.Y <> 0 then
        LFinalRect.Top := Min(LFinalRect.Top, LRect.Y);
      LFinalRect.Right := Max(LFinalRect.Right, LRect.Width);
      LFinalRect.Bottom := Max(LFinalRect.Bottom, LRect.Height);
      if not Assigned(LTextElement) then
        LTextElement := TgtPDFTextElement.Create;
      LTextElement.Rect := LFinalRect;
      LTextElement.PageNum := State.PageNumber;

      FCurrentPath := nil;
    end;
  //  LStr := '';
  //  LStr := Char(Code) + '    X: ' + FloatToStr(LRect.X) + ' Y: ' + FloatToStr(LRect.Y)
  //    + ' Right: ' + FloatToStr(LRect.Width + LRect.X) + ' FontSize: ' +
  //    FloatToStr(State.FontSize * State.HorizScaling) + ' CharSpace: ' +
  //    FloatToStr(state.CharSpace) ;
  //  FStrList.Add(LStr);
    LObj := State.Font.GetToUnicode;
  //  if (State.Font is TgtPD8bitFont) and Assigned(LObj) then
  //    Code := State.Font.GetToUnicode.Code[Code];
//    LFinalText := LFinaltext + WideChar(Code);
    FGraphics.Restore(LSave);
    I := I + LProcessed;
  end;
  if Assigned(LTextElement) then
  begin
    LTextElement.Text := LText;
    LTextElement.PageNum := State.PageNumber;
    FTextList.AddObject(LText, LTextElement);
  end;
end;

procedure TgtEnumElementsDev.RestoreState(State: TgtPDState);
var
  LState: Cardinal;
  LI: Integer;

  LMatrix: IGPMatrix;
  LMarray: TGPMatrixParams;
begin
  inherited;
//  if etText in FElementTypes then
//  begin
//    FTextDev.RestoreState(State);
//  end;

  if FStateStack.Count >= 1 then
  begin
    LI := FStateStack.Count - 1;
    LState := Cardinal(FStateStack.Items[LI]);
    FGraphics.Restore(LState);
    FStateStack.Delete(LI);

    LMatrix := TGPMatrix.Create;
    try
      LMatrix := FGraphics.GetTransform;
      LMarray := LMatrix.GetElements;

      FCTM.SetValues(LMarray.m11, LMarray.m12, LMarray.m21, LMarray.m22,
      LMarray.dx, LMarray.dy);

    finally
      LMatrix := nil;
    end;
  end;
  UpdateAll(State);
end;

procedure TgtEnumElementsDev.SaveState(State: TgtPDState);
var
  LState: Cardinal;
begin
  inherited;
  LState := FGraphics.Save;
  FStateStack.Add(Pointer(LState));
end;

procedure TgtEnumElementsDev.StartPage(nPage: Integer; State: TgtPDState);
begin
  inherited;
  FPageNo := nPage;
//  if etText in FElementTypes then
//  begin
//    FTextDev.FontList := FFontList;
//    FTextDev.StartPage(nPage, State);
//  end;
  FDC := GetDC(0);
  FGraphics := TGPGraphics.Create(FDC);
  FStateStack := TList.Create;

  UpdateCTM(State, State.CTM);
end;

procedure TgtEnumElementsDev.Stroke(State: TgtPDState);
begin
  inherited;

end;

procedure TgtEnumElementsDev.UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix);
var
  LMatrix: IGPMatrix;
begin
  inherited;
//  if etText in FElementTypes then
//    FTextDev.UpdateCTM(State, CTM);

  if not Assigned(FCTM) then
  begin
    FCTM := TgtPDMatrix.Create(CTM.M11, -CTM.M12, -CTM.M21, CTM.M22,
      CTM.Dx, CTM.Dy);
    LMatrix := TGPMatrix.Create;
    try
      LMatrix.SetElements(FCTM.M11, FCTM.M12, FCTM.M21, FCTM.M22, FCTM.Dx,
        State.PageHeight - FCTM.Dy);
      FGraphics.SetTransform(LMatrix);
    finally
      LMatrix := nil;
    end;
  end
  else
  begin
    LMatrix := TGPMatrix.Create;
    try
      FCTM.SetValues(CTM.M11, -CTM.M12, -CTM.M21, CTM.M22,
        CTM.Dx, CTM.Dy);
      LMatrix.SetElements(FCTM.M11, FCTM.M12,
        FCTM.M21, FCTM.M22, FCTM.Dx,
        -FCTM.Dy);
      FGraphics.MultiplyTransform(LMatrix);
    finally
      LMatrix := nil;
    end;
  end;
end;

procedure TgtEnumElementsDev.UpdateFont(State: TgtPDState);
var
  LFontStyle: TFontStyles;
  LFontStream: TStream;
  LName, LAltName: AnsiString;
  ErrorCode: ErrorCodes;
  IsBold, IsItalic: Boolean;
begin
  LFontStyle := [];
  IsItalic := False;
  IsBold := False;
  if Assigned(FFontFamily) then
  begin
    FFontFamily := nil;
  end;
  if Assigned(FFont) then
  begin
    FFont := nil;
  end;
  if Assigned(FFontProcessor) then
  begin
    FFontProcessor := nil;
  end;

  LFontStream := State.Font.EmbeddedFontStream;
  if Assigned(LFontStream) then
  begin
    FFontProcessor := TgtFontProcessor.Create(LFontStream, Round(State.FontSize),
      Round(State.hDPI), Round(State.vDPI), ErrorCode);
    if ErrorCode <> Success then
    begin
{$IFDEF LOGERROR}
      Logger.LogError('Error parsing Font stream, Replacing with Arial');
{$ENDIF}
      if Assigned(FFontProcessor) then FreeAndNil(FFontProcessor);

      FFontFamily := TGPFontFamily.Create('Arial Unicode MS');
      if not FFontFamily.IsAvailable then
      begin
        FFontFamily := nil;
        FFont := TGPFont.Create('Arial Unicode MS', State.FontSize,
          LFontStyle, UnitPoint);
      end
      else
        FFont := TGPFont.Create(FFontFamily, State.FontSize, LFontStyle,
          UnitPoint);
    end;
  end
  else
  begin
    if State.Font.EmbeddedFontName <> '' then
      LAltName := State.Font.EmbeddedFontName
    else
      LAltName := State.Font.Name;

    LName := FFontList.Values[LAltName];
    if LName = '' then
    begin
      LAltName := StringReplace(LAltName, ',', '', [rfReplaceAll]);
      LAltName := StringReplace(LAltName, '+', '', [rfReplaceAll]);
      LAltName := StringReplace(LAltName, '-', '', [rfReplaceAll]);
      LAltName := StringReplace(LAltName, 'PS', '', []);
      LAltName := StringReplace(LAltName, 'MT', '', []);
      if Pos('Bold', LAltName) > 0 then
      begin
        IsBold := True;
        LAltName := StringReplace(LAltName, 'Bold', '', [rfIgnoreCase]);
      end;

      if Pos('Italic', LAltName) > 0 then
      begin
        IsItalic := True;
        LAltName := StringReplace(LAltName, 'Italic', '', [rfIgnoreCase]);
      end;

      if IsBold or State.Font.IsBold then
      begin
        if IsItalic or State.Font.IsItalic then
          LFontStyle := LFontStyle + [fsBold, fsItalic]
        else
          LFontStyle := LFontStyle + [fsBold];
      end
      else if IsItalic or State.Font.IsItalic then
        LFontStyle := LFontStyle + [fsItalic];

      LName := FFontList.Values[LAltName];
    end;
    if LName = '' then
    begin
{$IFDEF LOGERROR}
      Logger.LogError('Font %s not found in system, Replacing with Arial Unicode MS',
        [LAltName]);
{$ENDIF}
      LName := 'Arial Unicode MS';
    end;

    FFontFamily := TGPFontFamily.Create(LName);
    if not FFontFamily.IsAvailable then
    begin
      FFontFamily := nil;
      FFont := TGPFont.Create(LName, State.FontSize,
        LFontStyle, UnitPoint);
    end
    else
      FFont := TGPFont.Create(FFontFamily, State.FontSize, LFontStyle,
        UnitPoint);
  end;
end;

procedure TgtExProPDFDocument.EnumCallBack(Sender: TObject; PageElement: TgtPDFPageElement;
  ElementType: TgtPDFElementType; PageNumber: Integer);
begin
  if not Assigned(FPageElementList) then Exit;
  FPageElementList.Add(PageElement);
end;

end.
