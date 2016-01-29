{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtCstSpdEng;

interface
uses
  Classes, Windows, Graphics, SysUtils, gtCstDocEng, gtUtils3, gtConsts3,
  gtDocConsts, gtDocResStrs;

type

  //  TS represents Thousand Separator
  TgtCellType = (ctString, ctInteger, ctDouble, ctCurrency, ctTime,
    ctDate, ctDateTime, ctInteger_TS, ctDouble_TS, ctPercentage_FP, ctPercentage);

  PgtColumnWidth = ^TgtColumnWidth;
  TgtColumnWidth = record
    FCoumnNumber: Integer;
    FWidth: Double;
  end;

  TgtFmTextItem = class(TgtTextItem)
  private
    FRowNo: Integer;
    FColumnNo: Integer;
  public
    property RowNo: Integer read FRowNo write FRowNo;
    property ColumnNo: Integer read FColumnNo write FColumnNo;
  end;

  TgtSheetTextItem = class(TgtFmTextItem)
  private
    FAlignment: TgtHAlignment;
    FCellType: TgtCellType;
    FWordWrap: Boolean;
  public
    property Alignment: TgtHAlignment read FAlignment write FAlignment;
    property CellType: TgtCellType read FCellType write FCellType;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
  end;


  TgtCellAttrib = class(TObject)
  private
    FFontIndex: Integer;
    FFormatIndex: Word;
    FAlignment: TgtHAlignment;
    FBrush: TBrush;
    FWordWrap: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property FontIndex: Integer read FFontIndex write FFontIndex;
    property FormatIndex: Word read FFormatIndex write FFormatIndex;
    property Alignment: TgtHAlignment read FAlignment write FAlignment;
    property Brush: TBrush read FBrush write FBrush;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
  end;

  TgtRowSpacingRange = -1..65536;
  TgtColumnSpacingRange = -1..256;

  TgtSheetFormatting = Class(TPersistent)
  private
    FRowSpacing: TgtRowSpacingRange;
    FColumnSpacing: TgtColumnSpacingRange;
    FScaleY: Single;
    FScaleX: Single;
    procedure SetRowSpacing(const Value: TgtRowSpacingRange);
    procedure SetColumnSpacing(const Value: TgtColumnSpacingRange);
    procedure SetScaleX(const Value: Single);
    procedure SetScaleY(const Value: Single);
  public
    constructor Create;
    destructor Destroy;override;
  published
    property ColumnSpacing: TgtColumnSpacingRange read FColumnSpacing
      write SetColumnSpacing;
    property RowSpacing: TgtRowSpacingRange read FRowSpacing write SetRowSpacing;
    property ScaleX: Single read FScaleX write SetScaleX;
    property ScaleY: Single read FScaleY write SetScaleY;
  end;

  TgtSpreadSheetPreferences = class(TgtPreferences)
  private
    FAutoFormatCells: Boolean;
    FMultiPass: Boolean;
    FApplyAlignment: Boolean;
    FWordWrap: Boolean;
    FUseDefaultPalette: Boolean;
    FContinuousMode: Boolean;
    FNumberFormatDecimalPlaces: Integer;
    procedure SetAutoFormatCells(const Value: Boolean);
    procedure SetApplyAlignment(const Value: Boolean);
    procedure SetMultiPass(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetUseDefaultPalette(const Value: Boolean);
    procedure SetContinuousMode(const Value: Boolean);
  published
    property AutoFormatCells: Boolean read FAutoFormatCells
      write SetAutoFormatCells;
    property ApplyAlignment: Boolean read FApplyAlignment
      write SetApplyAlignment default False;
    property MultiPass: Boolean read FMultiPass
      write SetMultiPass default False;
    property WordWrap: Boolean read FWordWrap
      write SetWordWrap default False;
    property UseDefaultPalette: Boolean read FUseDefaultPalette
      write SetUseDefaultPalette default False;
    property ContinuousMode: Boolean read FContinuousMode
      write SetContinuousMode default False;
    property NumberFormatDecimalPlaces: Integer read FNumberFormatDecimalPlaces
      write FNumberFormatDecimalPlaces default 2;
  end;

  TgtColumnInfo = class(TObject)
  private
    FMinX: Double;
    FColumnNum: Integer;
  public
    property MinX: Double read FMinX write FMinX;
    property ColumnNum: Integer read FColumnNum write FColumnNum;
  end;

  TgtColumnInfoList = class(TList)
  private
    function GetColumnNum(X, Offset: Double): Integer;
    procedure AddColumnInfo(MinX: Double; ColNum: Integer);
    function GetItem(Index: Integer): TgtColumnInfo;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    property Items[Index: Integer]: TgtColumnInfo read GetItem; default;
  end;

  TgtCustomSpreadSheetEngine = class(TgtCustomDocumentEngine)
  private
    FFormatting: TgtSheetFormatting;
    FColorFlag: Boolean;
    procedure SetFormatting(const Value: TgtSheetFormatting);
    function GetPreferences: TgtSpreadSheetPreferences;
    procedure SetPreferences(const Value: TgtSpreadSheetPreferences);
  protected

    FXFactor: Double;
    FDefaultCellHeight, FLastPageHeight, FPrevRowNo: Integer;

    FCellXFTable: TStringList;
    FFontTable: TStringList;
    FColorTable: TStringList;
    FColorArray: array [0..100] of integer;
    FColorArraySize: Integer;
    FColorValues: Integer;
    FColWidths: TList;
    FPrevColumnsInfo: TgtColumnInfoList;

    procedure SetColumnWidth(ColumnNumber: Integer; Width: Double); virtual;

    procedure Start; override;
    procedure BeginPage; override;
    procedure EndPage; override;
    procedure Finish; override;
{$IFNDEF gtRegistered}
    procedure PutTrialNote; override;
{$ENDIF}
    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeTextBox(AObject: TgtTextBoxItem); override;
    procedure EncodeParagraph(AObject: TgtParagraphItem); override;
    procedure EncodeTable(AObject: TgtTableItem); override;

      { SpreadSheet Engines helper methods}
    procedure WriteRecord(ARecType, ARecSize: Integer; ABuf: array of word;
      ADataSize: Integer; AStream: TStream);
    procedure WriteRecordByte(ARecType, ARecSize: Integer;
      ABuf: array of byte; ADataSize: Integer; AStream: TStream);
    function AddFontInfoToFontTable(AFont: TFont):  Integer;
    function AddColorToColorTable(AColor: TColor): Integer; virtual;
    function GetCellType(AText: String): TgtCellType;
    function AddCellInfoToCellXFTable(AFontIndex: Integer;
    ATextAlign: TgtHAlignment; AFormatIndex: Integer; ABrush: TBrush;
      AWordWrap: Boolean = False): Integer;
    function GetNumberString(AText: String): String;
    function GetNumberStringLocale(AText: String): String;
    procedure CreateResourceItems;
    procedure FreeResourceItems;
    procedure AdjustTextItemList(AList: TList); override;
    function IsInRange(LLeftX, LRightX, LCurLeftX, LCurRightX, LMaxTextSize,
    	LMinTextSize : Double): Boolean;
    function GetPreferencesClassName: TgtPreferencesClass; override;
    procedure NewSheet(AAddNewPage: Boolean = True); virtual;
    procedure ProcessTextList(AList: TList); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure NewPage; override;

    procedure TextOut(X, Y: Double; Text: WideString); override;
    procedure TextRect(Rect: TgtRect; X, Y: Double; Text: WideString); override;
    procedure TextOut(ColumnNo: Integer; Text: WideString); override;
    procedure TextOut(Row: Integer; Column: Integer; Text: WideString;
      Alignment: TgtHAlignment; CellType: TgtCellType); overload; virtual;
    procedure TextOut(Row: Integer; Column: Integer; Text: WideString;
      Alignment: TgtHAlignment; CellType: TgtCellType;
      WordWrap : Boolean); overload; virtual;
    function TextOut(Text: WideString): Double; override;
    procedure SetTextRotation(Angle: Integer); override;

    procedure BeginPara; override;
    procedure EndPara; override;
    
    function BeginTable(X, Y: Double; NoColumns: Integer): TList; override;
    function NewRow(Height: Double): Double; override;
    function NewRow: Double; override;
    procedure EndTable; override;

    procedure PlayMetafile(Metafile: TMetafile); override;
    procedure PlayMetafile(X, Y: Double; Metafile: TMetafile); override;

    procedure BeginHeader; override;
    procedure EndHeader; override;
    procedure ClearHeader; override;

    procedure BeginFooter; override;
    procedure EndFooter; override;
    procedure ClearFooter; override;

    procedure BeginWaterMark; override;
    procedure EndWaterMark; override;
    procedure ClearWaterMark; override;

    procedure BeginStamp; override;
    procedure EndStamp; override;
    procedure ClearStamp; override;

    function SaveEngineState: Integer; override;
    procedure RestoreEngineState(Index: Integer); override;
    procedure ClearEngineStates; override;

    procedure SetWorkingPage(PageNo: Integer); override;
    property TextFormatting;
  published
    property FileName;
    property Font;
    property Page;
    property Preferences: TgtSpreadSheetPreferences read GetPreferences
      write SetPreferences;
    property Formatting: TgtSheetFormatting read FFormatting write SetFormatting;

  end;

implementation
uses
  Math;

{ TgtCustomSpreadSheetEngine }

function TgtCustomSpreadSheetEngine.AddCellInfoToCellXFTable(
  AFontIndex: Integer; ATextAlign: TgtHAlignment; AFormatIndex: Integer;
  ABrush: TBrush; AWordWrap: Boolean): Integer;
var
	LAttrib: TgtCellAttrib;
	S: String;
begin
	S := IntToStr(AFontIndex) + IntToStr(Ord(ATextAlign)) + IntToStr(AFormatIndex)
    + ColorToString(ABrush.Color) + IntToStr(Ord(ABrush.Style));
  if AWordWrap then
        S := S + '-1'
  else
        S := S + '0';
  Result := FCellXFTable.IndexOf(S);
	if  Result = -1 then
  begin
    LAttrib := TgtCellAttrib.Create;
	  LAttrib.FFontIndex := AFontIndex;
	  LAttrib.FAlignment := ATextAlign;
    LAttrib.FFormatIndex := AFormatIndex;
    LAttrib.FBrush.Assign(ABrush);
    LAttrib.FWordWrap := AWordWrap;
    AddColorToColorTable(ABrush.Color);
    Result := FCellXFTable.AddObject(S, LAttrib);
  end
end;

function TgtCustomSpreadSheetEngine.AddColorToColorTable(
  AColor: TColor): Integer;
var
	S: String;
  I, ColVal: Integer;
begin
  if(Preferences.UseDefaultPalette)  then
  begin
    if(FColorFlag = False) then
    begin
      FColorArray[0] :=  0;
      FColorArray[1] :=  16777215;
      FColorArray[2] :=  255;
      FColorArray[3] :=  65280;
      FColorArray[4] :=  16711680;
      FColorArray[5] :=  65535;
      FColorArray[6] :=  16711935;
      FColorArray[7] :=  16776960;
      FColorArray[8] :=  128;
      FColorArray[9] :=  32768;
      FColorArray[10] :=  8388608;
      FColorArray[11] :=  32896;
      FColorArray[12] :=  8388736;
      FColorArray[13] :=  8421376;
      FColorArray[14] :=  12632256;
      FColorArray[15] :=  8421504;
      FColorArray[16] :=  16751001;
      FColorArray[17] :=  6697881;
      FColorArray[18] :=  13434879;
      FColorArray[19] :=  16777164;
      FColorArray[20] :=  6684774;
      FColorArray[21] :=  8421631;
      FColorArray[22] :=  13395456;
      FColorArray[23] :=  16764108;
      FColorArray[24] :=  8388608;
      FColorArray[25] :=  16711935;
      FColorArray[26] :=  65535;
      FColorArray[27] :=  16776960;
      FColorArray[28] :=  8388736;
      FColorArray[29] :=  128;
      FColorArray[30] :=  8421376;
      FColorArray[31] :=  16711680;
      FColorArray[32] :=  16763904;
      FColorArray[33] :=  16777164;
      FColorArray[34] :=  13434828;
      FColorArray[35] :=  10092543;
      FColorArray[36] :=  16764057;
      FColorArray[37] :=  13408767;
      FColorArray[38] :=  16751052;
      FColorArray[39] :=  14935011;
      FColorArray[40] :=  16737843;
      FColorArray[41] :=  13421619;
      FColorArray[42] :=  52377;
      FColorArray[43] :=  52479;
      FColorArray[44] :=  39423;
      FColorArray[45] :=  26367;
      FColorArray[46] :=  10053222;
      FColorArray[47] :=  9868950;
      FColorArray[48] :=  6697728;
      FColorArray[49] :=  6723891;
      FColorArray[50] :=  13056;
      FColorArray[51] :=  13107;
      FColorArray[52] :=  13209;
      FColorArray[53] :=  6697881;
      FColorArray[54] :=  10040115;
      FColorArray[55] :=  3355443;
      FColorArraySize := 56;
      FColorFlag := True;
    end;
    ColVal := ColorToRGB(AColor);
    Result := -1;
    for I := 0 to FColorArraySize -1 do
    begin
      if(FColorArray[I] = ColVal) then
      begin
        Result := I;
        Break;
      end;
    end;

    if(Result = -1) then
    begin
      Inc(FColorArraySize);
      FColorArray[FColorArraySize - 1] := ColVal;
      Result := FColorArraySize;
    end;
  end

  else
  begin
    S := ColorToString(AColor);
    Result := FColorTable.IndexOf(S);
    if  Result = -1 then
      Result := FColorTable.AddObject(S, TObject(AColor));
  end;

end;

function TgtCustomSpreadSheetEngine.AddFontInfoToFontTable(
  AFont: TFont): Integer;

  function BuildFontString(AFontName: String;	AFontSize: Integer;
    AFontStyle: TFontStyles; AFontColor: TColor): String;
  begin
  { Font String includes FontName, FontSize and FontStyle. }

    Result := AFontName + ' ' + IntToStr(AFontSize) + ColorToString(AFontColor);
    if fsBold in AFontStyle then
      Result := Result + ' Bold';
    if fsItalic in AFontStyle then
      Result := Result + ' Italic';
    if fsUnderLine in AFontStyle then
      Result := Result + ' UnderLine';
    if fsStrikeOut in AFontStyle then
      Result := Result + ' StrikeOut';
  end;
var
  LFont: TFont;
  LS: String;
begin
	LS := BuildFontString(AFont.Name, AFont.Size, AFont.Style, AFont.Color);
  Result := FFontTable.IndexOf(LS);
	if Result  = -1 then
	begin
    LFont := TFont.Create;
    LFont.Assign(AFont);
    if ColorToRGB(AFont.Color) = ColorToRGB(clWindow) then
      LFont.Color := clWindowText;
    AddColorToColorTable(LFont.Color);
		Result := FFontTable.AddObject(LS, LFont);
  end;
end;

procedure TgtCustomSpreadSheetEngine.BeginDoc;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.BeginFooter;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.BeginHeader;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.BeginPage;
begin
//  inherited;
{$IFNDEF gtRegistered}
  {$IFDEF gtFileMaker}
  if (not StatusMgr.IsException) then
  {$ENDIF}
  Inc(FLastPageHeight);
{$ENDIF}
  FPrevRowNo := -1;
end;

procedure TgtCustomSpreadSheetEngine.BeginPara;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.BeginWaterMark;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.BeginStamp;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.ClearEngineStates;
begin
  inherited;

end;

constructor TgtCustomSpreadSheetEngine.Create(AOwner: TComponent);
begin
  inherited;
  FFormatting := TgtSheetFormatting.Create;
  FSortTextItems := True;
  FColorFlag := False;
  ItemsToRender := [irText];
  FPrevColumnsInfo := TgtColumnInfoList.Create;
  Capabilities := [ckText, ckImage, ckShape, ckImageReusable];
end;

procedure TgtCustomSpreadSheetEngine.CreateResourceItems;
begin
  FFontTable := TStringList.Create;
  FColorTable := TStringList.Create;
  FCellXFTable := TStringList.Create;
end;

destructor TgtCustomSpreadSheetEngine.Destroy;
begin
  FreeAndNil(FFormatting);
  FreeAndNil(FPrevColumnsInfo);
  inherited;
end;

procedure TgtCustomSpreadSheetEngine.EncodeParagraph(
  AObject: TgtParagraphItem);
begin
  inherited;
end;

procedure TgtCustomSpreadSheetEngine.EncodeTable(AObject: TgtTableItem);
var
  I, J, K: Integer;
  LTextItem: TgtFmTextItem;
  LDocItem: TgtDocumentItem;
  LX, LY: Double;
begin
  with AObject do
  begin
    LTextItem := nil;
    
    LTextItem := TgtFmTextItem.Create;
    LTextItem.Font := Font;

{    if not Settings.EnableTitle then
      Dec(LY);}
    LY := 0;
    for I := - 1 to RowCount do
    begin
      LX := 0;
      for J := 0 to ColCount - 1 do
      begin
        LX := LX + Columns[J].Width;
        if (I = -1) then
        begin
          if Settings.EnableTitle then
          begin
            LTextItem.ColumnNo := Round((X + LX) / FXFactor);
            LTextItem.RowNo := Round((Y + LY) / FYFactor);
            LTextItem.Brush := Brush;
            LTextItem.Lines.Clear;
            LTextItem.Lines.Add(ReplacePlaceHolders(Columns[J].Title, True));
            EncodeText(LTextItem);
          end;
        end
        else
        begin
          for K := 0 to RowItemsList[I].Count - 1 do
          begin
            LDocItem := TgtDocumentItem(RowItemsList[I].Items[K]);
            if (LDocItem is TgtTextItem) and (TgtTextItem(LDocItem).X = J) then
            begin
              LTextItem.Lines.Clear;
              LTextItem.ColumnNo := Round((X + LX) / FXFactor);
              LTextItem.RowNo := Round((Y + LY) / FYFactor);
              LTextItem.Font := TgtTextItem(LDocItem).Font;
              LTextItem.Brush := TgtTextItem(LDocItem).Brush;
              LTextItem.Lines.Add(ReplacePlaceHolders(
                TgtTextItem(LDocItem).Lines[0], True));
              EncodeText(LTextItem);
              break;
            end
            else
            if (LDocItem is TgtImageItem) and (TgtImageItem(LDocItem).X = J) then
            begin
              TgtImageItem(LDocItem).X := X + LX;
              TgtImageItem(LDocItem).Y := LY + Y;
              EncodeImage(TgtImageItem(LDocItem));
              break;
            end;
          end;
        end;
      end;
      if (I = - 1) and Settings.EnableTitle then
        LY := LY + Settings.TitleHeight
      else if(I <> -1) then
        LY := LY + Integer(RowHeights[I]);
    end;
    FreeAndNil(LTextItem);
  end;
end;

function TgtCustomSpreadSheetEngine.GetCellType(AText: String): TgtCellType;
var
  LThousandSep: Integer;
  LText: String;

  function IsString(AText: String): Boolean;
  var
    LDecIndex, LThousandIndex: Integer;
  begin
    Result := False;
    LDecIndex := Pos({$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, AText);
    // Check if there is any thousand separator after decimal separator.
    // if so encode it as String.
    if (LDecIndex <> 0) then
    begin
      LThousandIndex := PosEx(SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator, AText, LDecIndex + 1 );
      if(LThousandIndex > LDecIndex) then
        Result := True;
    end;
  end;

  function IsDateTime(AText: String): Boolean;
  var
    LDateTime : TDateTime;
  begin
    Result := TryStrToDateTime(AText, LDateTime);
  end;

  function IsDate(AText: String): Boolean;
  var
    LDate : TDateTime;
  begin
    Result := TryStrToDate(Atext, LDate);
  end;

  function IsTime(AText: String): Boolean;
  var
    LTime : TDateTime;
  begin
    Result := TryStrToTime(Atext, LTime);
  end;

  function IsCorrectNo(AText: String): Boolean;
  var
    LK, LJ: Integer;
  begin
    Result := True;
    LK := LastDelimiter(SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator, AText);
    if(LK <> 0) then
    begin
      for LJ := (LK + 1) to (LK + 3) do
      begin
        if (LJ > Length(AText)) then
        begin
          Result := False;
          Exit;
        end;
        {$IFDEF gtDelphi2009Up}
            if SysUtils.CharInSet(AText[LJ],['0'..'9']) then
        {$ELSE}
            if AText[LJ] in ['0'..'9'] then
        {$ENDIF}
            Continue
        else
        begin
          Result := False;
          Exit;
        end;
      end;
      {$IFDEF gtDelphi2009Up}
        if ((LK + 4) <= Length(AText)) and SysUtils.CharInSet(AText[LK + 4],['0'..'9']) then
      {$ELSE}
        if ((LK + 4) <= Length(AText)) and (AText[LK + 4] in ['0'..'9']) then
      {$ENDIF}
        Result := False;
    end;
  end;

  function IsFloat(S: string): boolean;
  var
    f: extended;
  begin
    Result := TextToFloat(PChar(S), f, fvExtended);
  end;

  function IsPercent(AText: String): Boolean;
  var
    LTemp : String;
  begin
    Result := False;
    LTemp :=  trim(AText);
    if (LTemp[Length(LTemp)] = '%') and (Length(LTemp)>1) then
    begin
      if IsFloat(LeftStr(LTemp, Length(LTemp) - 1))  then
      Result := true;
    end;
  end;

begin
  LThousandSep := 0;
  Result := ctString;
  if Preferences.AutoFormatCells then
  begin
    if SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator <> SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator then
    begin
    {
      Check the thousandseparator and decimalseparator. If they are same
      then check for String or No.
      else check for thousandseparator and dateseparator, if they are same
      then check for String or No.
    }
      if SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator = SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DateSeparator then
      begin
      	// Check if thousandseparator appears after decimal separator.
        if not IsString(AText) then
        	// Check if thousand separator appears at correct position.
          if IsCorrectNo(AText) then
            AText := ReplaceString(AText, SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator, '');
      end
      else if SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DateSeparator = SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator then
      begin
      	//Count no of decimal separators. if more than 1 then it is a date.
        if not IsDate(AText) then
          if IsCorrectNo ( AText ) then
            AText := ReplaceString(AText, SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator, '');
      end
      else
        if not IsString(AText) then
      if IsCorrectNo(AText) then
      begin
        LThousandSep := Pos(SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator, AText);
        AText := ReplaceString(AText, SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}ThousandSeparator, '');
        // to convert an integer in parenthesis to negetive nos
        If ( (AText[1]='(') and (AText[Length(AText)]=')')) then
        begin
          AText := ReplaceString(AText, '(', '-');
          AText := ReplaceString(AText, ')', '');
        end;
      end;
    end;
    try
      if IsPercent(AText) then
      begin
        LText := LeftStr(AText, Length(AText) - 1);
        if (Pos(SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, LText) = 0) then
          Result := ctPercentage
        else
          Result := ctPercentage_FP;
        Exit;
        end;
    except
      on Exception do
//     on EConvertError do   // do nothing
    end;
    try

    if IsFloat(AText) then
    begin
      if Pos(SysUtils.{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, AText) = 0 then
      begin
          // if last Char is [+, -, e, E] then it is String
          if ((AText[Length(AText)] = '+') or (AText[Length(AText)] = '-') or
            (AText[Length(AText)] = 'e') or (AText[Length(AText)] = 'E')) then
          begin
            Result := ctString;
            Exit;
          end;
          // if [e, E] present in text, then it is double
          if (Pos('e', AText) <> 0) or (Pos('E', AText) <> 0) then
          begin
            Result := ctDouble;
            Exit;
          end
          else if (LThousandSep <> 0) then
          begin
            Result := ctInteger_TS;
            Exit;
          end;
          // default is integer
          Result := ctInteger;
          Exit;
        end
        else // same for double
        begin
          if ((AText[Length(AText)] = '+') or (AText[Length(AText)] = '-') or
            (AText[Length(AText)] = 'e') or (AText[Length(AText)] = 'E')) then
          begin
            Result := ctString;
            Exit;
          end;
          if (Pos('e', AText) <> 0) or (Pos('E', AText) <> 0) then
          begin
            Result := ctDouble;
            Exit;
          end;
          if (LThousandSep <> 0) then
          begin
            Result := ctDouble_TS;
            Exit;
          end;
          Result := ctDouble;
          Exit;
        end;
      end;
    except
      on Exception do
//      on EConvertError do     // do nothing
    end;


    try
      if (AText[1] = '-') and (AText[2] = {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}CurrencyString) then
      begin
        StrToCurr(Copy(AText, 3, Length(AText) - 1));
        Result := ctCurrency;
        Exit;
      end
      else
      if AText[1] = {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}CurrencyString then
      begin
        StrToCurr(Copy(AText, 2, Length(AText) - 1));
        Result := ctCurrency;
        Exit;
      end;
    except
      on Exception do
    //      on EConvertError do
    end;                     // do nothing

    if IsDate(AText) then
     Result := ctDate;

    if IsTime(AText) then
     Result := ctTime;

  end;
end;

procedure TgtCustomSpreadSheetEngine.EncodeText(AObject: TgtTextItem);
begin
	inherited;
end;

procedure TgtCustomSpreadSheetEngine.EndDoc;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.EndFooter;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.EndHeader;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.EndPage;
var
  LHeight: Integer;
begin
  if not Preferences.ContinuousMode then
  begin
    with Pages[CurrentPage - 1].Settings do
      LHeight := Round(Round(Height) / FDefaultCellHeight);

    if LHeight < FPrevRowNo then
      FLastPageHeight := FLastPageHeight + FPrevRowNo + 1
    else
      FLastPageHeight := FLastPageHeight + LHeight + 1;
  end
  else
  begin
    FLastPageHeight := FLastPageHeight + FPrevRowNo + 1;
  end;

  FPrevRowNo := -1;
  inherited;
end;

procedure TgtCustomSpreadSheetEngine.EndPara;
begin
  BreakParagraphIntoText;
end;

procedure TgtCustomSpreadSheetEngine.EndWaterMark;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.EndStamp;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.FreeResourceItems;
begin
  FreeAndNil(FFontTable);
  FreeAndNil(FColorTable);
  FreeAndNil(FCellXFTable);
end;

function TgtCustomSpreadSheetEngine.GetNumberString(AText: String): String;
var
  LI: Integer;
begin
	Result := '';
  AText := Trim(AText);
  for LI := 1 to Length(AText) do
     begin
     {$IFDEF gtDelphi2009Up}
        if ((LI = 1) and SysUtils.CharInSet(AText[LI],['+', '-'])) or
          SysUtils.CharInSet(AText[LI],['0'..'9', 'e', 'E', {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, '+', '-']) then
      {$ELSE}
        if ((LI = 1) and (AText[LI] in ['+', '-'])) or
      		(AText[LI] in ['0'..'9', 'e', 'E', DecimalSeparator, '+', '-']) then
      {$ENDIF}
      begin
      	// '73e03' must be considered as '73e+03'
        if ((LI > 1) and ((AText[LI-1] = 'E') or (AText[LI-1] = 'e'))) and
        		((AText[LI] <> '+') and (AText[LI] <> '-')) then
        	Result:=Result + '+';
        Result := Result + AText[LI];
       end;
    end;
end;
function TgtCustomSpreadSheetEngine.GetNumberStringLocale(AText: String): String;
var
  LI: Integer;
begin
	Result := '';
  AText := Trim(AText);
  for LI := 1 to Length(AText) do
     begin
     {$IFDEF gtDelphi2009Up}
        if ((LI = 1) and SysUtils.CharInSet(AText[LI],['+', '-'])) or
          SysUtils.CharInSet(AText[LI],['0'..'9', 'e', 'E', {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, '+', '-']) then
      {$ELSE}
        if ((LI = 1) and (AText[LI] in ['+', '-'])) or
      		(AText[LI] in ['0'..'9', 'e', 'E', DecimalSeparator, '+', '-']) then
      {$ENDIF}
      begin
      	// '73e03' must be considered as '73e+03'
        if (({$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator =
            AText[LI]) and (AText[LI] <> '.')) then
          AText[LI] := '.';
        Result := Result + AText[LI];
       end;
    end;
end;

function TgtCustomSpreadSheetEngine.GetPreferences: TgtSpreadSheetPreferences;
begin
  Result := TgtSpreadSheetPreferences(inherited Preferences);
end;

function TgtCustomSpreadSheetEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtSpreadSheetPreferences; 
end;


procedure TgtCustomSpreadSheetEngine.NewPage;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.PlayMetafile(X, Y: Double;
  Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.PlayMetafile(Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.RestoreEngineState(Index: Integer);
begin
  inherited;

end;

function TgtCustomSpreadSheetEngine.SaveEngineState: Integer;
begin
  Result := inherited SaveEngineState;
end;

procedure TgtCustomSpreadSheetEngine.SetColumnWidth(ColumnNumber: Integer;
  Width: Double);
var
  LItem: PgtColumnWidth;
begin
  if not FIsDocumentStarted then Exit;
  New(LItem);
  LItem.FCoumnNumber := ColumnNumber;
  LItem.FWidth := Width;
  FColWidths.Add(LItem);
end;

procedure TgtCustomSpreadSheetEngine.SetFormatting(
  const Value: TgtSheetFormatting);
begin
  FFormatting := Value;
end;

procedure TgtCustomSpreadSheetEngine.SetPreferences(
  const Value: TgtSpreadSheetPreferences);
begin
  inherited Preferences := Value;
end;

procedure TgtCustomSpreadSheetEngine.SetTextRotation(Angle: Integer);
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.SetWorkingPage(PageNo: Integer);
begin
  inherited;

end;

function TgtCustomSpreadSheetEngine.TextOut(Text: WideString): Double;
begin
  Result := inherited TextOut(Text);
end;

procedure TgtCustomSpreadSheetEngine.TextOut(Row, Column: Integer;
  Text: WideString; Alignment: TgtHAlignment; CellType: TgtCellType);
var
  LTextItem: TgtSheetTextItem;
begin
  if not FIsDocumentStarted or not (ckText in Capabilities)
    or not (irText in ItemsToRender) then exit;
  LTextItem := TgtSheetTextItem.Create;
  LTextItem.X := Column * FXFactor;
  LTextItem.Y := Row * FYFactor;
  LTextItem.ColumnNo := Column;
  LTextItem.RowNo := Row;
  LTextItem.Font := Font;
  LTextItem.Brush := Brush;
  LTextItem.Alignment := Alignment;
  LTextItem.CellType := CellType;
  LTextItem.WordWrap := Preferences.WordWrap;
  LTextItem.Lines.Add(Text);
  AddDocumentItem(LTextItem);
end;

procedure TgtCustomSpreadSheetEngine.TextOut(X, Y: Double; Text: WideString);
begin
  inherited;
end;

procedure TgtCustomSpreadSheetEngine.TextOut(ColumnNo: Integer;
  Text: WideString);
begin
  inherited;
end;

procedure TgtCustomSpreadSheetEngine.WriteRecord(ARecType,
  ARecSize: Integer; ABuf: array of word; ADataSize: Integer;
  AStream: TStream);
var
	Header: array[0..1] of word;
begin
	Header[0] := ARecType;
	Header[1] := ARecSize;
	AStream.Write(Header, SizeOf(Header));
	if ADataSize <> 0 then
		AStream.Write(ABuf, sizeof(ABuf));
end;

procedure TgtCustomSpreadSheetEngine.WriteRecordByte(ARecType,
  ARecSize: Integer; ABuf: array of byte; ADataSize: Integer;
  AStream: TStream);
var
	Header: array[0..1] of word;
begin
	Header[0] := ARecType;
	Header[1] := ARecSize;
	AStream.Write(Header, SizeOf(Header));
	if ADataSize <> 0 then
		AStream.Write(ABuf, sizeof(ABuf));
end;

function TgtCustomSpreadSheetEngine.BeginTable(X, Y: Double;
  NoColumns: Integer): TList;
begin
  Result := inherited BeginTable(X, Y, NoColumns);
end;

procedure TgtCustomSpreadSheetEngine.EndTable;
begin
  inherited;

end;

function TgtCustomSpreadSheetEngine.NewRow: Double;
begin
  Result := inherited NewRow;
end;

function TgtCustomSpreadSheetEngine.NewRow(Height: Double): Double;
begin
  Result := inherited NewRow(Height);
end;

procedure TgtCustomSpreadSheetEngine.AdjustTextItemList(AList: TList);

  procedure StoreMinXOfColumn(AList: TList);
var
    LI: Integer;
    MinX: Double;
    LFmTextItem: TgtFmTextItem;
  begin
    MinX := MaxInt;
    LFmTextItem := nil;
    for LI := 0 to AList.Count - 1 do
    begin
      LFmTextItem := TgtFmTextItem(AList[LI]);
      MinX := Min(LFmTextItem.X, MinX);
    end;
    if LFmTextItem <> nil then
      FPrevColumnsInfo.AddColumnInfo(MinX, LFmTextItem.ColumnNo);
  end;

var
  I, J, K, LColumnNo, LPrevColNo, LStoredColNum, LRowNo, LCount: Integer;
  LTextItem: TgtTextItem;
  LFmTextItem, LPrevTextItem, LStubTextItem, PrevTextItem, LKeepRef, LCopy: TgtFmTextItem;
  LPrevY, LOffset: Double;
  LColumns, LItems, LPrevItems, LPrevColItems, LColMove: TList;
  LFlag, LNew_Flag, LCheck, LRange, LChange: Boolean;
  LTxtSize1, LTxtSize2: Integer;
  LStr1, LStr2: Double;
  LoopI, LoopJ, LoopK, CurCol, CurRow, Width: Integer;
  LRightX, LprevRightX, LCenterX, LPrevCenterX: Double;
  LLeftX, LprevLeftX, LMinTextSize, LMaxTextSize: Double;
begin
  LPrevItems := TList.Create;
  LPrevColItems := nil;
  LMinTextSize := 0;
  LMaxTextSize := 0;
  LFmTextItem := nil;
  // Transform all sheet text items from the base class type to the spread sheet
  // text item class type so spread sheet specific row, col can be stored with it
  for I := 0 to AList.Count - 1 do
  begin
    if  not (TObject(Alist.Items[I]) is TgtSheetTextItem) then
    begin
      LFmTextItem := TgtFmTextItem.Create;
      LTextItem := TgtTextItem(Alist.Items[I]);
      with LFmTextItem do
      begin
        X := LTextItem.X;
        Y := LTextItem.Y;
        for J := 0 to LTextItem.Lines.Count - 1 do
          Lines.Add(LTextItem.Lines.Strings[J]);
        Font := LTextItem.Font;
        Brush := LTextItem.Brush;
        RotationAngle := LTextItem.RotationAngle;
        IsClipRect := LTextItem.IsClipRect;
        ClipRect := gtRect(LTextItem.ClipRect, 1);
        if((LTextItem.Alignment = haRight) and (Preferences.ApplyAlignment)) then
          X := LTextItem.X + TextSize(LTextItem.Lines[0], LTextItem.Font).cx;
        Alignment := LTextItem.Alignment;
      end;
      AList.Items[I] := LFmTextItem;
      LTextItem.Free;
    end;
  end;

  LColumns := TList.Create; // To store list of columns

  // Sort according to X direction
  if (not FNoSorting) then
  begin
    for I := 0 to AList.Count - 1 do
    begin
      J := I;
      LTextItem := TgtTextItem(Alist.Items[I]);
      while (J > 0) and (TgtTextItem(Alist.Items[J - 1]).X > LTextItem.X) do
      begin
        AList.Items[J] := AList.Items[J - 1];
        Dec(J);
      end;
      AList.Items[J] := LTextItem;
    end;
  end;


  // Calculate Column Number
  LColumnNo := - 1;
  LOffset := 0;
  I := 0;
  LPrevColNo := -1;
  LStoredColNum := -1;
  LPrevTextItem := nil;
  LCount := 0;
  Width := 0;
  LprevRightX := 0;
  LCenterX := 0;
  LPrevCenterX := 0;

  // Determine columns for all text items based on their x position.
  // Text with similar x pos (within a determined offset) need to stay together
  // in the same column.

  // At end of columns determination store the determined column numbers
  // for a given text x postion for use from page 2 onwards. Use only for
  // continuous mode generation.

  // For subsequent pages, set the column number for the text item based on stored
  // reference values. If the subsequent input pages have more columns and
  // continuous mode generation is true, assign new column numbers for the new x
  // position and update reference values at end for subsequent use.

  while I < AList.Count do
  begin
    if not (TObject(Alist.Items[I]) is TgtSheetTextItem) then
    begin
      LFmTextItem := TgtFmTextItem(Alist.Items[I]);
      if Preferences.ContinuousMode and (CurrentPage > 1) then
        LStoredColNum := FPrevColumnsInfo.GetColumnNum(
          Max(LFmTextItem.X, LFmTextItem.ClipRect.Left), LOffset);
      if ((LOffset = 0) or (LFmTextItem.X >= LOffset)) or
        (Preferences.ContinuousMode and (CurrentPage > 1) and
            (LStoredColNum <> -1)) then
      begin
        LOffset := LFmTextItem.X + FXFactor;
        // Assign stored column number from 2nd page onwards for continuous mode
        // generation, if a column for the given x pos has already been determined,
        // else do as usual
        if Preferences.ContinuousMode and (CurrentPage > 1) and
            (LStoredColNum <> -1) then
          LColumnNo := LStoredColNum
        else
        begin
          LColumnNo := Round(LFmTextItem.X / FXFactor);
          if LColumnNo <= LPrevColNo then
            Inc(LColumnNo);
        end;
        LPrevColNo := LColumnNo;

        LCount := 0;
        // Insert column at proper position
        for J := LColumns.Count to LColumnNo do
          LColumns.Add(TList.Create);
      end
      else
      begin
        if LCount <= 2 then
          Inc(LCount);
        if LCount = 1 then
          LPrevTextItem := LFmTextItem
        else
        if LCount = 2 then
        begin
          if Trim(LFmTextItem.Lines[0]) <> '' then
          begin
            LTxtSize1 := TextSize(Trim(LFmTextItem.Lines[0]), LFmTextItem.Font).cx;
            LTxtSize2 := TextSize(Trim(LPrevTextItem.Lines[0]), LPrevTextItem.Font).cx;
            if (LFmTextItem.X + LTxtSize1) = (LPrevTextItem.X + LTxtSize2) then
              LOffset := LFmTextItem.X + LTxtSize1
            else
            if (LFmTextItem.X + LTxtSize1 / 2) = (LPrevTextItem.X + LTxtSize2 / 2) then
              LOffset := LFmTextItem.X + LTxtSize1 / 2
            else
            begin
              Dec(LCount);
              LPrevTextItem := LFmTextItem;
            end;
          end
          else
            Dec(LCount);
        end;
      end;
      LFmTextItem.ColumnNo := LColumnNo;
      TList(LColumns.Items[LColumns.Count - 1]).Add(LFmTextItem);
    end;
    Inc(I);
  end;

  {Sort according to Y and Within Each Y according to X}
  inherited AdjustTextItemList(AList);

  LPrevY := -FYFactor;
  LRowNo := -1;
  LPrevTextItem := nil;

  for I := 0 to AList.Count - 1 do
  begin
    if  not (TObject(Alist.Items[I]) is TgtSheetTextItem) then
    begin
      //Trim Necessary?
      if(Trim((TgtFmTextItem(Alist.Items[I])).Lines[0]) <> '') then
      begin
        LFmTextItem := TgtFmTextItem(Alist.Items[I]);
        if LFmTextItem.Y < 0 then
          LFmTextItem.Y := 0;
        if LFmTextItem.Y >= (LPrevY + FYFactor) then
        begin
          LPrevY := LFmTextItem.Y;
          if Formatting.RowSpacing = - 1 then  // For RowSpacing
          begin
            if Round(LFmTextItem.Y / FYFactor) <= LRowNo then
              Inc(LRowNo)
            else
              LRowNo := Round(LFmTextItem.Y / FYFactor)
          end
          else
            LRowNo := LRowNo + Formatting.RowSpacing + 1;
          LFmTextItem.RowNo := LRowNo;
          LPrevTextItem := LFmTextItem;
          LPrevItems.Add(LPrevTextItem);
        end
        else
        begin
          LStr1 := LPrevTextItem.Y +
        	  TextSize(LPrevTextItem.Lines[0], LPrevTextitem.Font).cy / 2;
          LStr2 := LFmTextItem.Y;
          // Space between rows is very less, then divide the row
          if (LStr1 <= LStr2) then
          begin
            if((LFmTextItem.Lines[0] <> '') and (LPrevTextItem.Lines[0] <> '')) then
            begin
              if Formatting.RowSpacing = - 1 then  // For RowSpacing
                Inc(LRowNo)
              else
                LRowNo := LRowNo + Formatting.RowSpacing + 1;
              LFmTextItem.RowNo := LRowNo;
              LPrevY := LFmTextItem.Y
          end;
        end
        else
        begin // for overlapping text, use Prev item's list
          LFmTextItem.RowNo := LRowNo;
          for K := LPrevItems.Count - 1 downto 0 do
          begin
            LNew_Flag := False;
            PrevTextItem := TgtFmTextItem(LPrevItems.Items[K]);
            with LFmTextItem do
              if ((RowNo = PrevTextItem.RowNo) and
                (ColumnNo = PrevTextItem.ColumnNo)) then
              begin
              	// If start of current item is > half of height of the previous
                // item then increment row.
                if (LFmTextItem.Y >= (PrevTextItem.Y +
                	(TextSize(Trim(PrevTextItem.Lines[0]),
                  PrevTextITem.Font).cy / 2))) then
                begin
                  Inc(LRowNo);
                  RowNo := LRowNo;
                  LNew_Flag := True;
                end;
                if LNew_Flag = False then
                LPrevTextItem := PrevTextItem;
              end;
          end;
        end;
        // If Two cells in the same row have same ColumnNo
        if (LFmTextItem.ColumnNo = LPrevTextItem.ColumnNo) and
          (LFmTextItem.RowNo = LPrevTextItem.RowNo) and
          (Trim(LFmTextItem.Lines[0]) <> '') then
        begin
          // X's and Y's are identical?
          if (LFmTextItem.X = LPrevTextItem.X) and
            (LFmTextItem.Y = LPrevTextItem.Y) then
          begin
            // Keep the item added later.
            // Eliminate the one added before by setting columnNo = -1 which we
            // won't encode to file (else we get a "Data may have been lost" error)
            TgtFmTextItem(Alist.Items[I-1]).ColumnNo := -1;
          end
          else if LFmTextItem.X <> LPrevTextItem.X then
          begin
        	// If X's are not same then divide the column
            // This also takes care of keeping/showing all data and eliminating
            // "Data may have been lost" error

            // Use current items X as reference and move all items with X >= curr item X
            // in current col to new col
            LOffset := LFmTextItem.X;

            LColumnNo := LFmTextItem.ColumnNo;
            LFlag := False;
            // Move Next columns one step ahead.
            if(((LColumnNo + 1) < LColumns.Count) and
              (TList(LColumns[LColumnNo + 1]).Count > 0)) then
            begin
              while ((LColumnNo + 1) < LColumns.Count) and
                (TList(LColumns[LColumnNo + 1]).Count >= 0) do
              begin
                LItems := TList(LColumns[LColumnNo + 1]);
                for J := 0 to LItems.Count - 1 do
                  Inc(TgtFmTextItem(LItems[J]).FColumnNo);
                LFlag := True;
                Inc(LColumnNo);
              end;
            end;
            LColumnNo := LFmTextItem.ColumnNo;

            // Insert New column if next column is not free.
            if (LFlag or (LColumnNo = LColumns.Count - 1)) then
              LColumns.Insert(LFmTextItem.ColumnNo + 1, TList.Create);
            LItems := LColumns[LFmTextItem.ColumnNo + 1];

            // Divide existing column into two columns.
            J := 0;
           while J <= TList(LColumns[LColumnNo]).Count - 1 do
            begin
              LStubTextItem := TgtFmTextItem(TList(LColumns[LColumnNo]).Items[J]);
              if (LStubTextItem.X >= LOffset) then
              begin
                  TList(LColumns[LColumnNo]).Delete(J);
                  Inc(LStubTextItem.FColumnNo);
                  LItems.Add(LStubTextItem);
              end
              else
                Inc(J);
            end;
          end;
        end;
      end;
    end;

    LPrevTextItem := LFmTextItem;
    // Prev item's List for comparing in overlapping texts
    LPrevItems.Add(LPrevTextItem);
    end;
  end;

  if Preferences.ApplyAlignment then
  begin
    LprevLeftX := 0;
    CurRow := 0;
    for I := 0 to LColumns.Count - 1 do
    begin
      LItems := TList(LColumns[I]);
      LCheck := False;
      LColumnNo := -1;
      // Calculating the min x value
      for J := 0 to LItems.Count - 1 do
      begin
        if(TgtFmTextItem(LItems[J]).Alignment = haRight) then
        begin
          if(LCheck = False) then
          begin
            LprevLeftX := TgtFmTextItem(LItems[J]).X - TextSize(TgtFmTextItem(LItems[J]).Lines[0],
              TgtFmTextItem(LItems[J]).Font).cx;
            LprevRightX := LprevLeftX;
            LMinTextSize := TextSize(TgtFmTextItem(LItems[J]).Lines[0],TgtFmTextItem(LItems[J]).Font).cx;
            LMaxTextSize := LMinTextSize;
            CurRow := TgtFmTextItem(LItems[J]).RowNo;
          end;
          LLeftX := TgtFmTextItem(LItems[J]).X - TextSize(TgtFmTextItem(LItems[J]).Lines[0],
            TgtFmTextItem(LItems[J]).Font).cx;
          if(LprevLeftX > LLeftX ) then
          begin
            LprevLeftX := LLeftX;
            LMaxTextSize := TextSize(TgtFmTextItem(LItems[J]).Lines[0],
              TgtFmTextItem(LItems[J]).Font).cx;
          end;

          if(LprevRightX < LLeftX ) then
          begin
            LMinTextSize := TextSize(TgtFmTextItem(LItems[J]).Lines[0],
              TgtFmTextItem(LItems[J]).Font).cx;
            LprevRightX := LLeftX;
          end;
          if(CurRow > TgtFmTextItem(LItems[J]).RowNo) then
            CurRow := TgtFmTextItem(LItems[J]).RowNo;
            LCheck := True;
        end;
      end;

      LFlag := False;


      for LoopI := 0 to LItems.Count - 1 do
      begin
          LLeftX := TgtFmTextItem(LItems[LoopI]).X;
          LRightX := TgtFmTextItem(LItems[LoopI]).X +
                TextSize(TgtFmTextItem(LItems[LoopI]).Lines[0],
                TgtFmTextItem(LItems[LoopI]).Font).cx;
        if(TgtFmTextItem(LItems[LoopI]).RowNo < CurRow) then
        begin
          LRange := IsInRange(LprevLeftX, LprevRightX, LLeftX, LRightX,
          	LMaxTextSize, LMinTextSize);
          if(LRange = True) then
          begin
            LColumnNo := TgtFmTextItem(LItems[LoopI]).ColumnNo;
            LFlag := True;
          end;
        end;
      end;

     If((I > 0)and (CurRow > 0)) then
      begin
        if(TList(LColumns[I - 1]).Count > 0) then
          LPrevColItems := TList(LColumns[I - 1])
        else if((I > 1)and (TList(LColumns[I - 2]).Count > 0)) then
          LPrevColItems := TList(LColumns[I - 2])
        else if((I > 2)and (TList(LColumns[I - 3]).Count > 0)) then
          LPrevColItems := TList(LColumns[I - 3])
        else Break;

        if(LFlag = False) and (LPrevColItems <> nil) then
        for LoopI := 0 to LPrevColItems.Count - 1 do
        begin
            LLeftX := TgtFmTextItem(LPrevColItems[LoopI]).X;
            LRightX := TgtFmTextItem(LPrevColItems[LoopI]).X +
              TextSize(TgtFmTextItem(LPrevColItems[LoopI]).Lines[0],
              TgtFmTextItem(LPrevColItems[LoopI]).Font).cx;
          if(TgtFmTextItem(LPrevColItems[LoopI]).RowNo < CurRow) then
          begin
            LRange := IsInRange(LprevLeftX, LprevRightX, LLeftX, LRightX, LMaxTextSize, LMinTextSize);
            if(LRange = True) then
            begin
              LColumnNo := TgtFmTextItem(LPrevColItems[LoopI]).ColumnNo;
              LFlag := True;
            end;
          end;
        end;
      end;

      If((I < LColumns.Count - 1) and (CurRow > 0)) then
      begin
        LPrevColItems := TList(LColumns[I + 1]);
       if(LFlag = False) then
       for LoopI := 0 to LPrevColItems.Count - 1 do
       begin
            LLeftX := TgtFmTextItem(LPrevColItems[LoopI]).X;
            LRightX := TgtFmTextItem(LPrevColItems[LoopI]).X +
                  TextSize(TgtFmTextItem(LPrevColItems[LoopI]).Lines[0],
                  TgtFmTextItem(LPrevColItems[LoopI]).Font).cx;
         if(TgtFmTextItem(LPrevColItems[LoopI]).RowNo < CurRow) then
         begin
           LRange := IsInRange(LprevLeftX, LprevRightX, LLeftX, LRightX, LMaxTextSize, LMinTextSize);
           if(LRange = True) then
           begin
            LColumnNo := TgtFmTextItem(LPrevColItems[LoopI]).ColumnNo;
            LFlag := True;
           end;
         end;
       end;
      end;
      LChange := False;
      if(LFlag = True) then
      begin
        for LoopI := 0 to LItems.Count - 1 do
        begin
          if(TgtFmTextItem(LItems[LoopI]).Alignment = haRight) then
          begin
            if(TgtFmTextItem(LItems[LoopI]).ColumnNo <> LColumnNo) then
            begin
              TgtFmTextItem(LItems[LoopI]).ColumnNo := LColumnNo;
              if(LColumnNo > LColumns.Count -1) then
                LColumns.Insert(LColumnNo , TList.Create);
              TList(LColumns.Items[LColumnNo]).Add(TgtFmTextItem(LItems[LoopI]));
              LChange := True;
            end;
          end;
        end;
        for LoopI := LItems.Count - 1 downto 0 do
        begin
          if((TgtFmTextItem(LItems[LoopI]).Alignment = haRight) and
              (TgtFmTextItem(LItems[LoopI]).ColumnNo = LColumnNo) and
              (LChange = True)) then
          begin
              TList(LColumns[I]).Delete(LoopI);
          end;
        end;
      end;
    end;
  end;

  // For TextItems which is having same row and column numbers.
  if Preferences.MultiPass then
  begin
    for I := 0 to LColumns.Count - 1 do
    begin
      LItems := TList(LColumns[I]);
      for J := 0 to LItems.Count - 1 do
      begin
        if(Trim(TgtFmTextItem(LItems[J]).Lines[0])<> '') then
        begin
          CurCol := TgtFmTextItem(LItems[J]).ColumnNo;
          CurRow := TgtFmTextItem(LItems[J]).RowNo;
          //LColumnNo := TgtFmTextItem(LItems[J]).ColumnNo;
          for K := 0 to LItems.Count - 1 do
          begin
            if(Trim(TgtFmTextItem(LItems[K]).Lines[0])<> '') then
            begin
              if(K <> J) then
              begin
                //If both Items in same column has same row no.
                if((CurRow = TgtFmTextItem(LItems[K]).RowNo) ) then
                begin
                  // if x's are equal then increment the rows
                  if(TgtFmTextItem(LItems[J]).X = TgtFmTextItem(LItems[K]).X) then
                  begin
                    if (Trim(TgtFmTextItem(LItems[K]).Lines[0]) = '') then
                      TgtFmTextItem(LItems[K]).Lines[0] := TgtFmTextItem(LItems[J]).Lines[0]
                    else
                    if(TgtFmTextItem(LItems[J]).Y > TgtFmTextItem(LItems[K]).Y ) then
                    begin
                      LCheck := False;
                      // comparing If any item in the same colun has same row no.
                      for LoopI := 0 to LItems.Count   - 1 do
                      begin
                        if(CurRow + 1 = TgtFmTextItem(LItems[LoopI]).RowNo) then
                          LCheck := True;
                      end;
                      //if so, then shift those rows one step ahead
                      if(LCheck = True) then
                      begin
                        for LoopJ := 0 to LColumns.Count -1 do
                        begin
                          LPrevColItems := LColumns[LoopJ];
                          for LoopI := 0 to LPrevColItems.Count - 1  do
                          begin
                            if(TgtFmTextItem(LPrevColItems[LoopI]).RowNo > CurRow ) then
                              TgtFmTextItem(LPrevColItems[LoopI]).RowNo := TgtFmTextItem(LPrevColItems[LoopI]).RowNo + 1;
                          end;
                        end;
                      end;
                      //Increment the row no. of current text item
                      TgtFmTextItem(LItems[J]).RowNo := CurRow + 1;
                    end;
                  end


                  //If x's are not equal then increment the column
                  else
                  begin
                    if(TgtFmTextItem(LItems[J]).X > TgtFmTextItem(LItems[K]).X ) then
                    begin
                      LCheck := False;
                      //if it is not the Last column
                      if(CurCol < LColumns.Count - 1) then
                      begin
                        //If next column contains items
                        if(TList(LColumns[CurCol + 1]).Count > 0) then
                        begin
                          LPrevColItems := TList(LColumns[CurCol + 1]);
                          for LoopI:= 0 to LPrevColItems.Count - 1 do
                            if((TgtFmTextItem(LPrevColItems[LoopI]).RowNo = CurRow) and
                               (TgtFmTextItem(LPrevColItems[LoopI]).Lines[0] <> '') ) then
                            LCheck := True; // Next column is not free
                        end;
                      end;

                      // If next column is not free
                      if(LCheck = True) then
                      begin
                        LFlag := False;
                        // Move Next columns one step ahead.
                        while ((CurCol + 1) < LColumns.Count) and
                          (TList(LColumns[CurCol + 1]).Count > 0) do
                        begin
                          LPrevColItems := TList(LColumns[CurCol + 1]);
                          for LoopJ := 0 to LPrevColItems.Count - 1 do
                          begin
                            Inc(TgtFmTextItem(LPrevColItems[LoopJ]).FColumnNo);
                          end;
                          LFlag := True;
                          Inc(CurCol);
                        end;
                        CurCol := TgtFmTextItem(LItems[J]).ColumnNo;
                        // Insert New column if next column is not free.
                        if (LFlag or (CurCol = LColumns.Count - 1)) then
                          LColumns.Insert(CurCol + 1, TList.Create);
                        TgtFmTextItem(LItems[J]).ColumnNo := TgtFmTextItem(LItems[J]).ColumnNo + 1;
                        TList(LColumns.Items[CurCol + 1]).Add(TgtFmTextItem(LItems[J]));
                        //TList(LColumns[CurCol]).Delete(J);
                      end;
                      if(LCheck = False) then
                      begin
                        TgtFmTextItem(LItems[J]).ColumnNo := TgtFmTextItem(LItems[J]).ColumnNo + 1;
                        if(LColumns.Count -1 < CurCol +1) then
                          LColumns.Insert(CurCol + 1, TList.Create);
                        TList(LColumns.Items[CurCol + 1]).Add(TgtFmTextItem(LItems[J]));
                        //TList(LColumns[CurCol]).Delete(J);
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

   // reasigning the X value for right aligned text and applying column spacing

  // If ContinuousMode, then do these only for page 1 and use same column assignments
  // for subsequent pages
  if not Preferences.ContinuousMode or (CurrentPage = 1) then
  begin
    for I := 0 to AList.Count - 1 do
    begin
      LTextItem := TgtTextItem(Alist.Items[I]);
      if not (TObject(Alist.Items[I]) is TgtSheetTextItem) then
      begin
        if((LTextItem.Alignment = haRight) and (Preferences.ApplyAlignment)) then
          LTextItem.X := LTextItem.X - TextSize(LTextItem.Lines[0], LTextItem.Font).cx
      end;
      AList.Items[I] := LTextItem;
    end;

    LColumnNo := Formatting.ColumnSpacing;
    for I := 0 to LColumns.Count - 1 do
    begin
      LItems := TList(LColumns[I]);
      if (Formatting.ColumnSpacing <> - 1) and (LItems.Count <> 0) then
      begin
        for J := 0 to LItems.Count - 1 do
          TgtFmTextItem(LItems[J]).ColumnNo := LColumnNo;
        LColumnNo := LColumnNo + FFormatting.ColumnSpacing + 1;
      end;
    end;
  end;
  // Store the determined column numbers.
  // Update at end of existing columns info, don't overwrite.
  // FPrevColumnsInfo.Count will be zero for first page, so info for all columns
  // will be stored for first page, which will become our reference for assigning
  // column numbers to subsequent pages.

  // Store min x and max x pos considering all text items of all columns
  LCount := FPrevColumnsInfo.Count;
  if LCount > 0 then
    LCount := FPrevColumnsInfo.Items[LCount - 1].ColumnNum;
//  if CurrentPage = 1 then
    for I := LCount to LColumns.Count - 1 do
      if TList(LColumns[I]).Count <> 0 then // are there any items in the column?
        StoreMinXOfColumn(TList(LColumns[I]));

  for I := 0 to LColumns.Count - 1 do
  begin
    LItems := TList(LColumns[I]);
    LItems.Free;
  end;
  LColumns.Free;

  if FPrevRowNo < LRowNo then
    FPrevRowNo := LRowNo;
  LPrevItems.Free;
end;

procedure TgtCustomSpreadSheetEngine.Finish;
var
  I: Integer;
begin
  inherited;
  for I := 0 to  FColWidths.Count - 1 do
    Dispose(FColWidths[I]);
  FreeAndNil(FColWidths);
  FPrevColumnsInfo.Clear;
end;

procedure TgtCustomSpreadSheetEngine.Start;
var
  LFont: TFont;
  TS : TSize;
begin
  inherited;

  LFont := TFont.Create;
  LFont.Name := 'Arial';
  LFont.Size := 10;

  TS := TextSize('a', LFont);
  FXFactor := TS.cx * cSheet_StdCharsPerCell * Formatting.ScaleX;
  FYFactor := TS.cy * Formatting.ScaleY;
  FDefaultCellHeight := TS.cy;
  FreeAndNil(LFont);

  FColWidths := TList.Create;
  FLastPageHeight := 0;
  FPrevColumnsInfo.Clear;
end;

procedure TgtCustomSpreadSheetEngine.EncodeTextBox;
begin
end;

procedure TgtCustomSpreadSheetEngine.TextRect(Rect: TgtRect; X, Y: Double;
  Text: WideString);
begin
  inherited;

end;

function TgtCustomSpreadSheetEngine.IsInRange(LLeftX, LRightX, LCurLeftX,
  LCurRightX, LMaxTextSize, LMinTextSize: Double): Boolean;
var
LeftOffset, Rightoffset: Double;
begin
  LeftOffset := LLeftX + LMaxTextSize / 2;
  Rightoffset := LRightX + LMinTextSize / 2;

  if(((LLeftX >= LCurLeftX) and (LLeftX <= LCurRightX)) or
      ((LRightX >= LCurLeftX) and (LRightX <= LCurRightX))) then
    Result  := True
  else if(((LeftOffset >= LCurLeftX) and (LeftOffset <= LCurRightX)) or
      ((Rightoffset >= LCurLeftX) and (Rightoffset <= LCurRightX))) then
    Result := True
  else
    result := False;
end;

procedure TgtCustomSpreadSheetEngine.TextOut(Row, Column: Integer;
  Text: WideString; Alignment: TgtHAlignment; CellType: TgtCellType;
  WordWrap: Boolean);
var
  LTextItem: TgtSheetTextItem;
begin
  if not FIsDocumentStarted or not (ckText in Capabilities)
    or not (irText in ItemsToRender) then exit;
  LTextItem := TgtSheetTextItem.Create;
  LTextItem.X := Column * FXFactor;
  LTextItem.Y := Row * FYFactor;
  LTextItem.ColumnNo := Column;
  LTextItem.RowNo := Row;
  LTextItem.Font := Font;
  LTextItem.Brush := Brush;
  LTextItem.Alignment := Alignment;
  LTextItem.CellType := CellType;
  LTextItem.WordWrap := WordWrap;
  LTextItem.Lines.Add(Text);
  AddDocumentItem(LTextItem);
end;

{$IFNDEF gtRegistered}
procedure TgtCustomSpreadSheetEngine.PutTrialNote;
begin
  PutTrialNoteOnTop;
end;
{$ENDIF}

procedure TgtCustomSpreadSheetEngine.ClearFooter;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.ClearHeader;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.ClearStamp;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.ClearWaterMark;
begin
  inherited;

end;

procedure TgtCustomSpreadSheetEngine.NewSheet(AAddNewPage: Boolean);
begin
// Handled in gtExcelEngine
end;

procedure TgtCustomSpreadSheetEngine.ProcessTextList(AList: TList);

  function MakeCardinal(A, B: Integer): Cardinal;
  begin
    Result := A or B shl 16;
  end;

var
  I: Integer;
  LUsedCell: Cardinal;
  LUsedCellMap: TList;
begin
  // Mark items for exclusion if two or more items use the same cell.
  // Retain the item that was last written for a given cell.

  // Check all items from end and maintain a map. If cell is used by a more recently
  // written text item, mark current for exclusion.
  // (to avoid "Data may have been lost" error)

  LUsedCellMap := TList.Create;
  try
    for I := AList.Count - 1 downto 0 do
      if TgtDocumentItem(AList.Items[I]) is TgtFmTextItem then
        with TgtFmTextItem(AList.Items[I]) do
        begin
          // Col and Row will be stored in the first 16 bits, so make a single 32-bit
          // number and add to map to check if same row/col is used again
          if ColumnNo <> -1 then
          begin
            LUsedCell := MakeCardinal(RowNo, ColumnNo);
            if LUsedCellMap.IndexOf(TObject(LUsedCell)) = -1 then
              // Cell not used, so add to map
              LUsedCellMap.Add(TObject(LUsedCell))
            else
              // Cell overwritten, so exclude current item from sheet by setting
              // ColumnNo to -1
              ColumnNo := -1;
          end;
        end;
  finally
    LUsedCellMap.Free;
  end;

  inherited ProcessTextList(AList);
end;


{ TgtSheetFormatting }

constructor TgtSheetFormatting.Create;
begin
  FColumnSpacing := -1;
  FRowSpacing := -1;
  FScaleX := 1.0;
  FScaleY := 1.0;
end;

destructor TgtSheetFormatting.Destroy;
begin

  inherited;
end;

procedure TgtSheetFormatting.SetColumnSpacing(
  const Value: TgtColumnSpacingRange);
begin
  FColumnSpacing := Value;
end;

procedure TgtSheetFormatting.SetRowSpacing(const Value: TgtRowSpacingRange);
begin
  FRowSpacing := Value;
end;

procedure TgtSheetFormatting.SetScaleX(const Value: Single);
begin
  FScaleX := Value;
end;

procedure TgtSheetFormatting.SetScaleY(const Value: Single);
begin
  FScaleY := Value;
end;

{ TgtCellAttrib }

constructor TgtCellAttrib.Create;
begin
  FBrush := TBrush.Create;
end;

destructor TgtCellAttrib.Destroy;
begin
  FreeAndNil(FBrush);
  inherited;
end;

{ TgtSpreadSheetPreferences }

procedure TgtSpreadSheetPreferences.SetApplyAlignment(
  const Value: Boolean);
begin
  FApplyAlignment := Value;
end;

procedure TgtSpreadSheetPreferences.SetAutoFormatCells(
  const Value: Boolean);
begin
  FAutoFormatCells := Value;
end;

procedure TgtSpreadSheetPreferences.SetContinuousMode(
  const Value: Boolean);
begin
  FContinuousMode := Value;
end;

procedure TgtSpreadSheetPreferences.SetMultiPass(const Value: Boolean);
begin
  FMultiPass := Value;
end;

procedure TgtSpreadSheetPreferences.SetUseDefaultPalette(
  const Value: Boolean);
begin
  FUseDefaultPalette := Value;
end;

procedure TgtSpreadSheetPreferences.SetWordWrap(const Value: Boolean);
begin
  FWordWrap := Value;
end;

{ TgtColumnNumsList }

procedure TgtColumnInfoList.AddColumnInfo(MinX: Double; ColNum: Integer);
var
  LColInfo: TgtColumnInfo;
begin
  LColInfo := TgtColumnInfo.Create;
  LColInfo.MinX := MinX;
  LColInfo.ColumnNum := ColNum;
  Add(LColInfo);
end;

function TgtColumnInfoList.GetColumnNum(X, Offset: Double): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].MinX >= X then
    begin
      Result := Items[I].ColumnNum;
      if (Items[I].MinX > X) and (I < Count) and (I > 0) then
        Result := Items[I - 1].ColumnNum;
      Break;
    end;
  if (Result = -1) and (Count > 0) and (Items[Count - 1].MinX + Offset >= X) then
    Result := Items[Count - 1].ColumnNum;
end;

function TgtColumnInfoList.GetItem(Index: Integer): TgtColumnInfo;
begin
  Result := TgtColumnInfo(inherited Items[Index]);
end;

procedure TgtColumnInfoList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action = lnDeleted then
    TgtColumnInfo(Ptr).Free;
end;

end.
