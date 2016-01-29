{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                              }
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

unit gtExXLS95Eng;

interface
uses
  Classes, Windows, Graphics, SysUtils, gtCstDocEng, gtCstXLS95Eng, gtDocConsts,
  gtUtils3, gtDocResStrs, gtDocUtils;
type

  TgtExcelFormulaType = (ftExpression, ftFunction);

  TgtFormulaItem = class(TPersistent)
  private
    FColNo: Integer;
    FRowNo: Integer;
    FLines: String;
    FFont: TFont;
    FAlignment: TgtHAlignment;
    FBrush: TBrush;
    FFormulaType: TgtExcelFormulaType;

    procedure SetAlignment(const Value: TgtHAlignment);
    procedure SetFont(const Value: TFont);
    procedure SetBrush(const Value: TBrush);
    procedure SetFormulaType(const Value: TgtExcelFormulaType);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RowNo: Integer read FRowNo write FRowNo;
    property ColNo: Integer read FColNo write FColNo;
    property Lines: String read FLines write FLines;
    property Font: TFont read FFont write SetFont;
    property Alignment: TgtHAlignment read FAlignment write SetAlignment
      default haLeft;
    property Brush: TBrush read FBrush write SetBrush;
    property FormulaType: TgtExcelFormulaType read FFormulaType write SetFormulaType;
  end;


  TgtExExcel95Engine = class(TgtCustomExcel95Engine)
  private
    FObjectCount: Integer;
    FRowHeights: TList;
    FLastRowNo: Integer;
    FMaxFont: TFont;
    FMaxCellSize: Integer;

    procedure EncodeGraphic(ARect: TgtRect; ABitmap: TBitmap;
     AMetafile: TMetafile; IsBackground: Boolean);
    procedure AbsHorPosn(AX, AWidth: Double; var ALeft, ALeftOffset,
      ARight, ARightOffset: Integer);
    procedure AbsVertPosn(AY, AHeight: Double; var ATop, ATopOffset,
      ABottom, ABottomOffset: Integer);
    procedure GetCommonAttribute(var AObjectAttrib: array of byte;
      ARect: TgtRect; AObjectType: Byte);

  protected
    procedure Start; override;
    procedure BeginPage; override;
    procedure Finish; override;

    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeFormula(AObject: TgtFormulaItem);
    procedure EncodeTextBox(AObject: TgtTextBoxItem); override;
    procedure EncodeImage(AObject: TgtImageItem); override;
    procedure EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen); override;
    procedure EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
      IsClosed: Boolean; Pen: TPen; Brush: TBrush); override;
    procedure EncodeShapeBitmap(X, Y: Double; Bitmap: TBitmap); override;
    function CheckOutputImageFormat(Value: TgtOutputImageFormat;
      var S: String): Boolean; override;
    procedure WriteBackgroundImage; override;
    procedure ProcessMetafile(AX, AY: Double; AMetafile: TMetafile); override;

  public
    Procedure FormulaOut(Row, Column: Integer; Text: String;Alignment:
      TgtHAlignment; FormulaType: TgtExcelFormulaType);
    procedure DrawImage(X, Y: Double; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; Index: Integer); override;
    procedure DrawImage(ColumnNo: Integer; Width, Height: Double;
      AGraphic: TGraphic); override;
    function AddImageAsResource(AGraphic: TGraphic): Integer; override;

    procedure Line(X1, Y1, X2, Y2: Double); override;
    procedure Rectangle(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Double; IsFill: Boolean);
       override;
    procedure Ellipse(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure Polygon(Points: array of TgtPoint; IsFill: Boolean); override;
    procedure PolyLine(Points: array of TgtPoint); override;
    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure PolyBezier(Points: array of TgtPoint); override;
  published
    property ImageSettings;
  end;

implementation

uses gtCstSpdEng;

procedure TgtExExcel95Engine.AbsHorPosn(AX, AWidth: Double; var ALeft,
  ALeftOffset, ARight, ARightOffset: Integer);

  function GetColumnWidth(AColNo: Integer): Integer;
  var
    I: Integer;
  begin
    for I := 0 to FColWidths.Count - 1 do
    if PgtColumnWidth(FColWidths[I]).FCoumnNumber = AColNo then
    begin
      Result := Round(PgtColumnWidth(FColWidths[I]).FWidth *
        FXFactor / Formatting.ScaleX / cSheet_StdCharsPerCell);
      Exit;
    end;
    Result := Round(FXFactor / Formatting.ScaleX);
  end;
var
  LE: Double;
  LCurWidth: Integer;

begin
  ALeft :=  0; ALeftOffset := 0;
  ARight := 0; ARightOffset := 0;

  LE := AX / FXFactor;
  ALeft := Trunc(LE);
  LCurWidth := GetColumnWidth(ALeft);

    //offset should be expressed as 1/1024 of cell Width
  ALeftOffset := Trunc(((LE - ALeft) * FXFactor / LCurWidth) * 1024);
  AWidth := (LE - ALeft) * FXFactor + AWidth;
  ARight := ALeft;

  while AWidth > 0 do
  begin
    if AWidth > LCurWidth then
      Inc(ARight)
    else
    begin
      ARightOffset := Round(AWidth / LCurWidth * 1024);
      break;
    end;
    AWidth := AWidth - LCurWidth;
    LCurWidth := GetColumnWidth(ARight + 1);
  end;
end;

procedure TgtExExcel95Engine.AbsVertPosn(AY, AHeight: Double; var ATop,
  ATopOffset, ABottom, ABottomOffset: Integer);
var
  I, LCurHeight: Integer;
  LE, LSum: Double;
begin

  ATop :=  0; ATopOffset := 0;
  ABottom := 0; ABottomOffset := 0;
  LSum := 0.0;

  LE := AY / FYFactor;

  ATop := Trunc(Abs(LE));

  if (ATop >= 0) and (ATop < FRowHeights.Count) then
    LCurHeight := Int64(FRowHeights.Items[ATop])
  else
    LCurHeight := FDefaultCellHeight;
  // Row offset should be in 1 / 256 of the RowHeight
  ATopOffset := Trunc(((LE - ATop) * FYFactor / LCurHeight) * 256);
  if ATopOffset > 256 then
  begin
    ATopOffset := 256;
  end;

  AHeight := AHeight - LCurHeight + (ATopOffset / 256) * LCurHeight;

  if AHeight < 0 then
  begin
    ABottom := ATop;
    ABottomOffset := Round((LCurHeight + AHeight) / LCurHeight * 256);
  end
  else
  begin
    I := ATop + 1;
    while I <=  FRowHeights.Count - 1  do
    begin
      LCurHeight := Int64(FRowHeights.Items[I]);
      if LSum + LCurHeight <= AHeight then
        LSum := LSum + LCurHeight
      else
      begin
        ABottom := I;
        ABottomOffset := Trunc(((AHeight - LSum) / LCurHeight) * 256);
        Exit;
      end;
      Inc(I)
    end;

    LE := (AHeight - LSum) / FDefaultCellHeight;
    ABottom :=  I  + Trunc(LE) ;
    ABottomOffset := Trunc((LE - Int(LE))*256) ;

    if ABottom > FPrevRowNo then
      FPrevRowNo := Round(ABottom);
  end;
end;

function TgtExExcel95Engine.AddImageAsResource(AGraphic: TGraphic): Integer;
begin
  Result := inherited AddImageAsResource(AGraphic);
end;

procedure TgtExExcel95Engine.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
begin
  inherited;

end;

procedure TgtExExcel95Engine.BeginPage;
begin
  inherited;
  FLastRowNo := -1;
end;

function TgtExExcel95Engine.CheckOutputImageFormat(
  Value: TgtOutputImageFormat; var S: String): Boolean;
begin
  Result := False;
	if Value in [ifBMP, ifMetafile] then
    Result := True
  else
    S := SUnsupportedExcelImageFormat;
end;

procedure TgtExExcel95Engine.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtExExcel95Engine.DrawImage(ImageRect: TgtRect; Index: Integer);
begin
  inherited;

end;

procedure TgtExExcel95Engine.DrawImage(ImageRect: TgtRect;
  AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtExExcel95Engine.DrawImage(X, Y: Double; AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtExExcel95Engine.DrawImage(ColumnNo: Integer; Width,
  Height: Double; AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtExExcel95Engine.Ellipse(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtExExcel95Engine.EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
	LAttrib: array [4..47] of Byte;
  I: Integer;
begin
  for I := Low(LAttrib) to High(LAttrib) do
    LAttrib[I] := 0;
  GetCommonAttribute(LAttrib, gtRect(X1, Y1, X2, Y2), 3);
  LAttrib[38] := AddColorToColorTable(clWhite) + 8;
  if Brush <> nil then
  begin
    LAttrib[39] := AddColorToColorTable(Brush.Color) + 8;
    LAttrib[40] := GetFillStyle(byte(Brush.Style));
  end;
  LAttrib[42] := AddColorToColorTable(Pen.Color) + 8;
  LAttrib[43] := Byte(Pen.Style);
  LAttrib[44] := Byte(Pen.Width);
  WriteRecord($5d, 44, [0], 0, ExcelStream);
  ExcelStream.Write(LAttrib, SizeOf(LAttrib));
end;

procedure TgtExExcel95Engine.EncodeFormula(AObject: TgtFormulaItem);
var
  LFormatIndex, LFontIndex, LCellXFIndex: Integer;
  LTextAlign: TgtHAlignment;
  LBuf: array[0..1] of Word;
  LS, Formula: String;
  FormulaAttribute: array[10..100] of Byte;
  Top, LI, LK : Integer;
  Stack: array[1..100] of String;
  PostFix, Infix, opString, TempStr1, TempStr2, TempStr3: String;
  OpCount, operatorCount, FnCount, SetLen: Integer;
  intCount, operatorCount1: Integer;
  Encode1, Operand, ArgumentCount, Ref, SizeCount: Integer;
  StackSymb : String;
  Symbol : Char;
  LWCellXFIndex : Word;

  function isDigit( ch: Char) : Boolean;
  begin
    if(((ch >= '0') and (ch <= '9')) or (Char(ch) = {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator) ) then
      Result := True
    else
      Result := False;
  end;


  procedure push(ch : String; var Stack1: array of String;var Top: Integer);
  begin
    Top := Top + 1;
    Stack1[top] := ch;
  end;

  function IsAlpha(ch: Char) : boolean;
  begin
   if(((ch >= 'a') and (ch <= 'z')) or((ch >= 'A')and  (ch <= 'Z'))) then
     Result := True
   else
     Result := False;
  end;

  function Pop(var Stack1: array of String;var Top: Integer ): String;
  begin
    if (Top > 0) then
    begin
      Result :=Stack1[top];
      Top := Top - 1;
    end;
  end;

  function InputPrec(Str : String) : Integer;
  var
  ch : Char;
  begin
    ch := Str[1];
    case Ch of
      '=', '<', '>': Result:= 1;
      '&' : Result := 3;
      '+' , '-': Result := 6;
      '*', '/' : Result := 9;
      '^', '$': Result := 12;
      '(' : Result := 15;
      ')' : Result := 0;
    else
       Result := 13;
    end;
  end;

  function StackPrec(Str : String) : Integer;
  var
  ch : Char;
  begin
    ch := Str[1];
    case Ch of
    '=', '<', '>' : Result:= 2;
    '&' : Result := 4 ;

    '+' , '-': Result := 5;
    '*', '/' : Result := 7;
    '^', '$': Result := 8;
    '(' : Result := 0;
    '#' : Result := -1;
    else
       Result := 10;
    end;
  end;

  function InfixToPostfix(Infix: String; var Stack: array of String; var top : Integer): String;
  var
  I : Integer;
  Symb: String;
  PF : String;
  begin
    Top := 0;
    push('#', stack, Top);
    PF := '';
    I := 1;

    while(I <= Length(Infix)) do
    begin
      Symbol := Char(0);
      Symb := '';

      if((Length(Stack[Top]) = 1) and (I > 1)) then
        StackSymb := (Stack[Top])[1]
      else if((Length(Stack[Top]) <> 1) and (I > 1)) then
        StackSymb := '1'
      else if((I = 1)) then
         StackSymb := '#';

      if((isDigit(Infix[I])) or  (isAlpha(Infix[I]))
        or((Infix[I] = '-') and (not(isDigit(Infix[I -1])) )))  then
      begin
        Symb := Symb + Infix[I];
        Symbol := Infix[I];
        I := I + 1;
        while((isDigit(Infix[I])) or  (isAlpha(Infix[I]))) do
        begin
          Symb := Symb + Infix[I];
          Symbol := Infix[I];
          I := I + 1;
        end;
      end
      else
      begin
          Symb := Symb + Infix[I];
          Symbol := Infix[I];
          I := I + 1;

          if((Infix[I -1] = '<') or(Infix[I-1] = '>')) then
          begin
            if((Infix[I] = '=') or (Infix[I] = '>')) then
            begin
              Symb := Symb + Infix[I];
              Symbol := Infix[I -1];
              I := I + 1;
            end;
          end;
      end;

      while(StackPrec(StackSymb) > InputPrec(Symbol)) do
      begin
        PF := PF + pop(Stack, Top)+ '|';
        if((Length(Stack[Top]) = 1) and (I > 1)) then
          StackSymb := (Stack[Top])[1]
        else if((Length(Stack[Top]) <> 1) and (I > 1)) then
          StackSymb := '1';
      end;

      if(StackPrec(StackSymb) <> InputPrec(Symbol))then
        push(Symb, Stack, Top)
      else
      begin
        Pop(Stack, Top);
      end;
    end;

    while(Stack[Top] <> '#') do
    begin
        PF := PF + pop(Stack, Top) + '|';
    end;
    Result := PF;
  end;

   function RemoveSpace(str: String): String;
   var
     I: Integer;
     str1: String;
   begin
     I := 1;
     str1 := '';
     While (I <=  Length(str)) do
     begin

       if(str[I] = '"') then
       begin
         str1 := str1+ str[I];
         Inc(I);
         while ((I <=  Length(str)) and (str[I] <> '"')) do
         begin
            str1 := str1+ str[I];
            Inc(I);
         end;
         str1 := str1+ str[I];
         Inc(I);
       end;

       if(str[I] <> ' ') then
         str1 := str1+ str[I];
       Inc(I);
     end;
     Result := str1;
   end;


   procedure EncodeFormula(Str: String; Count: Integer);
   var
      LI : Integer;

   const
      Formulas: array[0..224] of String = ('COUNT', 'IF', 'ISNA', 'ISERROR', 'SUM', 'AVERAGE',
        'MIN', 'MAX', 'ROW', 'COLUMN', 'NA', 'NPV', 'STDEV', 'DOLLAR', 'FIXED', 'SIN',
        'COS', 'TAN', 'ATAN', 'PI', 'SQRT', 'EXP', 'LN', 'LOG10', 'ABS', 'INT', 'SIGN', 'ROUND',
        'LOOKUP' , 'INDEX', 'REPT', 'MID', 'LEN', 'VALUE', 'TRUE', 'FALSE', 'AND', 'OR', 'NOT',
        'MOD', 'DCOUNT', 'DSUM', 'DAVERAGE', 'DMIN', 'DMAX', 'DSTDEV', 'VAR', 'DVAR', 'TEXT',
        'LINEST', 'TREND', 'LOGEST', 'GROWTH', 'PV', 'FV', 'NPER', 'PMT', 'RATE', 'MIRR', 'IRR',
        'RAND', 'MATCH', 'DATE', 'TIME', 'DAY', 'MONTH', 'YEAR', 'WEEKDAY', 'HOUR', 'MINUTE',
        'SECOND', 'NOW', 'AREAS', 'ROWS', 'COLUMNS', 'OFFSET', 'SEARCH', 'TRANSPOSE', 'TYPE',
        'ATAN2', 'ASIN', 'ACOS', 'CHOOSE', 'HLOOKUP', 'VLOOKUP', 'ISREF', 'LOG', 'Char', 'LOWER',
        'UPPER', 'PROPER', 'LEFT', 'RIGHT', 'EXACT', 'TRIM', 'REPLACE', 'SUBSTITUTE', 'CODE',
        'FIND', 'CELL', 'ISERR', 'ISTEXT', 'ISNUMBER', 'ISBLANK', 'T', 'N', 'DATEVALUE', 'TIMEVALUE',
        'SLN', 'SYD', 'DDB', 'INDIRECT', 'CALL', 'CLEAN', 'MDETERM', 'MINVERSE', 'MMULT', 'IPMT',
        'PPMT', 'COUNTA', 'PRODUCT', 'FACT', 'DPRODUCT', 'ISNONTEXT', 'STDEVP', 'VARP', 'DSTDEVP',
        'DVARP', 'TRUNC', 'ISLOGICAL', 'DCOUNTA', 'ROUNDUP', 'ROUNDDOWN', 'RANK', 'ADDRESS',
        'DAYS360', 'TODAY', 'VDB', 'MEDIAN', 'SUMPRODUCT', 'SINH', 'COSH','TANH', 'ASINH', 'ACOSH',
        'ATANH', 'DGET', 'INFO', 'DB', 'FREQUENCY', 'ERROR.TYPE', 'REGISTER.ID', 'AVEDEV', 'BETADIST',
        'GAMMALN', 'BETAINV', 'BINOMDIST', 'CHIDIST', 'CHIINV', 'COMBIN', 'CONFIDENCE', 'CRITBINOM',
        'EVEN', 'EXPONDIST', 'FDIST', 'FINV', 'FISHER', 'FISHERINV', 'FLOOR', 'GAMMADIST', 'GAMMAINV',
        'CEILING', 'HYPGEOMDIST', 'LOGNORMDIST', 'LOGINV', 'NEGBINOMDIST', 'NORMDIST', 'NORMSDIST',
        'NORMINV', 'NORMSINV', 'STANDARDIZE', 'ODD', 'PERMUT', 'POISSON', 'TDIST', 'WEIBULL', 'SUMXMY2',
        'SUMX2MY2', 'SUMX2PY2', 'CHITEST', 'CORREL', 'COVAR', 'FORECAST', 'FTEST', 'INTERCEPT',
        'PEARSON', 'RSQ', 'STEYX', 'SLOPE', 'TTEST', 'PROB', 'DEVSQ', 'GEOMEAN', 'HARMEAN',
        'SUMSQ', 'KURT', 'SKEW', 'ZTEST', 'LARGE', 'SMALL', 'QUARTILE', 'PERCENTILE', 'PERCENTRANK',
        'MODE', 'TRIMMEAN', 'TINV', 'CONCATENATE', 'POWER', 'RADIANS', 'DEGREES', 'SUBTOTAL', 'SUMIF',
        'COUNTIF', 'COUNTBLANK', 'ROMAN');

      Values: array[0..224] of Integer = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
        16, 17, 18, 19, 20 ,21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
        37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 56, 57, 58, 59, 60, 61,
        62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 82, 83, 86, 97, 98,
        99, 100, 101, 102, 105, 109, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 124,
        125, 126, 127, 128, 129, 130, 131, 140, 141, 142, 143, 144, 148, 150, 162, 163, 164, 165,
        167, 168, 169, 183, 184, 189, 190, 193, 194, 195, 196, 197, 198, 199, 212, 213, 216, 219,
        220, 221, 222, 227, 228, 229, 230, 231, 232, 233, 234, 235, 244, 247, 252, 261, 267, 269,
        270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287,
        288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303,304, 305,
        306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323,
        324, 325, 326, 327, 328, 329, 330, 331, 332, 336, 337, 342, 343, 344, 345, 346, 347, 354);
   begin
     Count := Count; //+ Count3;
     FnCount := FnCount + 4;
     Encode1 := -1;

     for LI := 0 to High(Formulas) do
       if (Formulas[LI] = UpperCase(Str)) then
       begin
         Inc(SetLen);
         FormulaAttribute[SetLen ]:= $42;
         Inc(SetLen);
         FormulaAttribute[SetLen ]:= Count and $ff;
         Break;
       end;

     if LI <= High(Formulas) then
       Encode1 := Values[LI];
     Inc(SetLen);
     FormulaAttribute[SetLen ]:= Encode1 and $FF;
     Inc(SetLen);
     FormulaAttribute[SetLen ]:= (Encode1 shr 8) and $FF;
   end;

   procedure EncodeExp(Str: String);
   var
   LK, LJ,  Pos1, Res, Len, I: Integer;
   LeftStr1, RightStr1, IEEE, TS1, TS2, TS3: String;
   SignBit, ExponentBits, MantissaBits: String;
   varDouble: Double;

     function EncodeAlpha(RefStr: String): Integer;
     var
     K : Integer;
     begin
        for K := 1 to Length(RefStr) do
        begin
          // If the column no. is greater than 'z' then
          if (Length(RefStr) > 1) then
          begin
            if( K = 1) then
            begin
              if(((RefStr[K] >= 'a') and (RefStr[K] <= 'z'))) then
                Operand :=  (Ord(RefStr[K]) - 96) * 26
              else
                Operand := (Ord(RefStr[K]) - 64) * 26;
            end
            else
            begin
              if(((RefStr[K] >= 'a') and (RefStr[K] <= 'z'))) then
                Operand := Operand + Ord(RefStr[K]) - 97
              else
                Operand := Operand + Ord(RefStr[K]) - 65;
            end;
          end
          else
          begin
            if(((RefStr[K] >= 'a') and (RefStr[K] <= 'z'))) then
              Operand := Ord(RefStr[K]) - 97
            else
              Operand := Ord(RefStr[K]) - 65;
          end;
        end;
        Result := Operand;
     end;

     function DecToBinConverter(Dec: Integer): String;
     var
     x: Double;
     begin
        x := Dec;
        TempStr3 := '';
        while (x >= 1) do
        begin
          TempStr3 := IntToStr(Trunc(x) mod 2 ) + TempStr3;
          x := x/2;
        end;
        Result := TempStr3;
        if Dec < 1 then
          Result := IntToStr(Trunc(Dec));
     end;

     function DecFractionToBinConverter(DecStr: Double): String;
     var
     x, y:Double;

     begin
        TempStr3 := '';
        x := DecStr - Trunc(DecStr);
        while((x < 1) and (x > 0)) do
        begin
          y := x*2;
          TempStr3 := TempStr3 + IntToStr(Trunc(y));
          x := y - Trunc(y);
        end;
        if TempStr3 = ''  then
          TempStr3 := '0';
        Result := TempStr3;
     end;

     function BinToIntConverter(BinStr: String): Integer ;
     var
     var1, var2: Integer;
     begin
       LJ := 8;
       var1 := 1;
       var2 := 0;
       while(LJ > 0 ) do
       begin
         var2 := var2 + var1* StrToInt(BinStr[LJ]);
         var1 := var1 *2;
         LJ := LJ -1;
       end;
      Result := var2;
     end;

   begin

   OpCount := 0;
   operatorCount := 0;
   // For Strings
   if(AnsiContainsText(Str, '"'))   then
   begin
     OpCount := 2;
     Inc(SetLen);
     FormulaAttribute[SetLen ]:= $17;
     Inc(SetLen);
     FormulaAttribute[SetLen ]:= (Length(Str) -2) and $FF;
     for LK := 1 to Length(Str) do
     begin
       if(Str[LK] = '"') then
       begin
         //DO nothing
       end
       else
       begin
         Inc(SetLen);
         FormulaAttribute[SetLen ]:= ORD(Str[LK]) and $FF;
       end;
     end;
     OpCount := OpCount + Length(Str) -2 ;
   end


    // For Mem references like .. A1:d4
    else if (AnsiContainsText(Str, ':'))then
    begin
      Inc(SetLen);
      FormulaAttribute[SetLen ]:= $25;
      OpCount := OpCount + 7;
      Operand := 0;
      LK := 1;
      SetLen := SetLen + 6;
      Pos1 := PosEx(':', Str );
      LeftStr1 := LeftStr(Str, Pos1 - 1);
      RightStr1 := RightStr(Str, Length(Str) - Pos1) ;
      TempStr3 := '';
      while(LK <= Length(LeftStr1)) do
      begin
        if(IsAlpha(LeftStr1[LK])) then
        begin
          while (IsAlpha(LeftStr1[LK])) do
          begin
            TempStr3 :=  TempStr3 +  LeftStr1[LK];
            Inc(LK);
          end;
          Dec(LK);
          Operand := EncodeAlpha(TempStr3);
          FormulaAttribute[SetLen - 1] := Operand and $FF;
        end
        else
        begin
          TempStr2 := '';
          LJ := Length(LeftStr1);
          while( isDigit(LeftStr1[LJ]) ) do
          begin
            TempStr2 := TempStr2 + LeftStr1[LJ];
            Dec(LJ);
          end;
          TempStr2 := ReverseString(TempStr2);
          LK := Length(LeftStr1);
          Operand := StrToInt(TempStr2);
          Operand := Operand -1;
          FormulaAttribute[SetLen -5] := (Operand)and $FF;
          FormulaAttribute[SetLen -4] := ((Operand shr 8) and $FF)or $C0;
        end;
        Inc(LK);
      end;

     // For right String
      TempStr3 := '';
      LK := 1;
      while(LK <= Length(RightStr1)) do
      begin
        if(IsAlpha(RightStr1[LK])) then
        begin
          while (IsAlpha(RightStr1[LK])) do
          begin
            TempStr3 :=  TempStr3 +  RightStr1[LK];
            Inc(LK);
          end;
          Dec(LK);
          Operand := EncodeAlpha(TempStr3);
          FormulaAttribute[SetLen ] := Operand and $FF;
        end
        else
        begin
          TempStr2 := '';
          LJ := Length(RightStr1);
          while( isDigit(RightStr1[LJ]) ) do
          begin
            TempStr2 := TempStr2 + RightStr1[LJ];
            Dec(LJ);
          end;
          TempStr2 := ReverseString(TempStr2) ;
          LK := Length(RightStr1);
          Operand := StrToInt(TempStr2);
          Operand := Operand -1;
          FormulaAttribute[SetLen -3] := (Operand)and $FF;
          FormulaAttribute[SetLen -2] := ((Operand shr 8) and $FF)or $C0;
        end;
        Inc(LK);
      end;
    end


   // for Expressions
    else
    begin
      PostFix := InfixToPostfix(Str, Stack, Top);
      LI := 1;

      while (LI <= Length(PostFix)) do
      begin
       opString := '';
       if(PostFix[LI] = '|') then
         Inc(LI)
       else
       begin
          intCount := 0;
          operatorCount1 := 0;
          while(PostFIx[LI] <> '|') do
          begin
            opString := opString + PostFix[LI];
            Inc(LI);
          end;

          for LK := 1 to Length(opString) do
          begin
            if((LK = 1) and (Length(opString) > 1))then
              if((opString[LK] = '-')) then
                Inc(intCount);
            if(isDigit(opString[LK])) then
              Inc(intCount)
            else if (IsAlpha(opString[LK])) then
            begin
            //do nothing
            end
            else
              Inc(operatorCount1);
          end;

          // For simple integral expressions...
          if(intCount = Length(opString)) then
          begin
            if ((AnsiContainsText(opString, {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator))
              or((AnsiContainsText(opString, '-'))) ) then
            begin
                SignBit := '';
                TS1 := '';
                TS2 := '';
                TS3 := '';
                MantissaBits := '';
                ExponentBits := '';
                OpCount := OpCount + 9;
                Inc(SetLen);
                FormulaAttribute[SetLen ] := $1f;
                if(Pos('-',opString) = 1) then
                begin
                  SignBit := IntToStr(1);
                  opString := RightStr(opString, Length(opString) -1);
                end
                else
                  SignBit := IntToStr(0);

               varDouble := StrToFloat(opString);
               TS1 := DecToBinConverter(Trunc(varDouble));
               TS2 := DecFractionToBinConverter(varDouble);

               if((Length(TS1) >= 1)) then
               begin
               if(Length(TS1) <> 1) then
                ExponentBits := DecToBinConverter((length(TS1) - 1) + 1023)
               else
                 if(StrToInt(TS1[1])<> 0) then
                       ExponentBits := DecToBinConverter((length(TS1) - 1) + 1023)
                 else
                 begin
                   I := Pos('1', TS2);
                   ExponentBits := DecToBinConverter(1023 - I );
                   TS2 := RightStr(TS2, (Length(TS2) - I)) ;
                 end;
               end;
               if(Length(ExponentBits) < 11) then
                 for LK := Length(ExponentBits) + 1 to 11 do
                   ExponentBits :=  IntToStr(0) + ExponentBits
               else
                ExponentBits := LeftStr(ExponentBits, 11);

               TS3 := TS1 + TS2;

               for LK := 2 to length(TS3) do
                 MantissaBits := MantissaBits + TS3[LK];
               Len := Length(MantissaBits);
               if(Len < 52) then
                 for LK := Len to 51 do
                   MantissaBits := MantissaBits + '0'
               else
                 MantissaBits := LeftStr(MantissaBits, 52);

               IEEE := SignBit + ExponentBits + MantissaBits;

               LK := 64;

               while(LK > 0) do
               begin
                 TS1 := '';

                 for LJ := 0 to 7 do
                 begin
                   TS1 := TS1 + IEEE[LK];
                   LK := LK -1;
                 end;
                TS1 := ReverseString(TS1);
                Res := BinToIntConverter(TS1);
                Inc(SetLen);
                FormulaAttribute[SetLen ] := Res;
               end;
            end
            else
            begin
              Operand :=  StrToInt(opString);
              OpCount := OpCount + 3;
              Inc(SetLen);
              FormulaAttribute[SetLen ] := $1e;
              Inc(SetLen);
              FormulaAttribute[SetLen] := Operand and $FF;
              Inc(SetLen);
              FormulaAttribute[SetLen] := (Operand shr 8) and $FF;
            end;
          end

          //For References like A1+B2
          else if(operatorCount1 = 0 ) then
          begin
            TempStr1 := '';
            TempStr3:= '';

              Inc(SetLen);
              OpCount := OpCount + 4;
              Operand := 0;
              FormulaAttribute[SetLen ]:= $44;
              LK := 1;

              while(LK <= Length(opString)) do
              begin
                if(IsAlpha(opString[LK])) then
                begin
                  while (IsAlpha(opString[LK])) do
                  begin
                    TempStr3 :=  TempStr3 +  opString[LK];
                    Inc(LK);
                  end;
                  Dec(LK);
                  Operand := EncodeAlpha(TempStr3);
                  SetLen := SetLen + 3;
                  FormulaAttribute[SetLen ] := Operand and $FF;
                end
                else
                begin
                  TempStr2 := '';
                  LJ := Length(opString);
                  while( isDigit(opString[LJ]) ) do
                  begin
                    TempStr2 := TempStr2 + opString[LJ];
                    Dec(LJ);
                  end;
                  TempStr2 := ReverseString(TempStr2) ;
                  LK := Length(opString);
                  Operand := StrToInt(TempStr2);
                  Operand := Operand -1;
                  FormulaAttribute[SetLen -2] := (Operand)and $FF;
                  FormulaAttribute[SetLen -1] := ((Operand shr 8) and $FF)or $C0;
                end;
                Inc(LK);
            end;
          end
          else
          begin
            operatorCount := operatorCount + 1;
            Inc(SetLen);
            Symbol := opString[1];
            case Symbol of
              '+' :  FormulaAttribute[SetLen ]:= $03;
              '-' :  FormulaAttribute[SetLen ]:= $04;
              '*' :  FormulaAttribute[SetLen ]:= $05;
              '/' :  FormulaAttribute[SetLen ]:= $06;
              '^', '$' : FormulaAttribute[SetLen ]:= $07;
              '&' :  FormulaAttribute[SetLen ]:= $08;
              '<' :  begin
                     if(opString[2] = '=') then
                       FormulaAttribute[SetLen ]:= $0A
                     else if(opString[2] = '>') then
                       FormulaAttribute[SetLen ]:= $0E
                     else
                       FormulaAttribute[SetLen ]:= $09
                     end;
              '=' :  FormulaAttribute[SetLen ]:= $0B;
              '>' :  begin
                     if(opString[2] <> '=')  then
                       FormulaAttribute[SetLen ]:= $0D
                     else
                       FormulaAttribute[SetLen ]:= $0C
                     end;
            end;
          end;
       end;
      end;
    end;
   SizeCount := SizeCount + OpCount + operatorCount;
   end;


begin
  if(Trim(AObject.Lines) <>'') then
  begin
    Infix := RemoveSpace(AObject.Lines);
    PostFix := '';
    SetLen := 25;
    FnCount := 0;
    SizeCount := 0;
    OpCount := 0;
    operatorCount := 0;
    FnCount := 0;

    with AObject do
    begin

      if(FormulaType = ftExpression ) then
      begin
        EncodeExp(Infix);
      end

      else
      begin
        Formula := '';
        LK := 1;
        ArgumentCount := 0;
        while( Infix[LK] <> '(') do
        begin
          Formula := Formula + Infix[LK];
          Inc(LK);
        end;
        Ref := LK;
        Inc(Ref);
        while( Ref <= Length(Infix) -1) do
        begin
          TempStr1 := '';
          if(Infix[Ref] = ',') then
            Inc(Ref)

          else
          begin
            if(Infix[Ref] = '"') then
            begin
              TempStr1 := TempStr1 +  Infix[Ref];
              inc(Ref);
              while((Infix[Ref] <> '"') and (Ref <= Length(Infix) -1))  do
              begin
                TempStr1 := TempStr1 +  Infix[Ref];
                inc(Ref);
              end;
              TempStr1 := TempStr1 +  Infix[Ref];
              inc(Ref);
              Inc(ArgumentCount);
              EncodeExp(TempStr1);
            end
            else
            begin
              while((Infix[Ref] <> ',') and (Ref <= Length(Infix) -1))  do
              begin
                TempStr1 := TempStr1 +  Infix[Ref];
                inc(Ref);
              end;
              Inc(ArgumentCount);
              EncodeExp(TempStr1);
            end;
          end;
        end;

        EncodeFormula(Formula, ArgumentCount);
      end;
        if((FormulaType = ftExpression) or ((FormulaType = ftFunction) and (Encode1 <> -1))) then
        begin

          LFormatIndex := $0;   // String
          LTextAlign := Alignment;
          LS := Lines;

          if LS = '' then Exit;

          LFontIndex := AddFontInfoToFontTable(AObject.Font) + 5;

          LCellXFIndex := AddCellInfoToCellXFTable(LFontIndex, LTextAlign,
            LFormatIndex, Brush) + $10;
           LWCellXFIndex := word(LCellXFIndex);

          with TgtFormulaItem(AObject) do
          begin
            LBuf[0] := RowNo + FLastPageHeight;
            LBuf[1] := ColNo;
            UpdateDimensionVars(RowNo, ColNo);
          end;

          WriteRecord(6, (Sizeof(FormulaAttribute)+6), [0], 0, ExcelStream);
          ExcelStream.Write(LBuf, SizeOf(LBuf));
          ExcelStream.Write(LWCellXFIndex, 2); // size of word

        //Common to both Expressions and Functions....
          SizeCount := SizeCount  + FnCount ;
          FormulaAttribute[10] := $00;
          FormulaAttribute[11] := $00;
          FormulaAttribute[12] := $00;
          FormulaAttribute[13] := $00;
          FormulaAttribute[14] := $00;
          FormulaAttribute[15] := $00;
          FormulaAttribute[16] := $00;
          FormulaAttribute[17] := $00;
          FormulaAttribute[18] := $01;
          FormulaAttribute[19] := $00;
          FormulaAttribute[20] := $0C;
          FormulaAttribute[21] := $00;
          FormulaAttribute[22] := $00;
          FormulaAttribute[23] := $00;
          FormulaAttribute[24] := SizeCount and $ff;
          FormulaAttribute[25] := (SizeCount shr 8) and $FF;

          ExcelStream.Write(FormulaAttribute, sizeof(FormulaAttribute));
        end;
    end;
  end;
end;



procedure TgtExExcel95Engine.EncodeGraphic(ARect: TgtRect; ABitmap: TBitmap;
  AMetafile: TMetafile; IsBackground: Boolean);
var
	ImageAttrib: array [4..64] of Byte; // for Background Image
	ImageData: array [4..11] of Byte;
	BitmapHeaderInfo: array[1..12] of Byte;
	MetafileHeaderInfo: array[1..8] of Byte;
	S: TMemoryStream;
	StreamSize, ContinueSize: Integer;
	ImageSize, InfoSize: Cardinal;
	LDC: HDC;
	Image: Pointer;
	BitmapInfo: PBitmapInfo;
	MetafileInfo: PEnhMetaHeader;
	BackgroundImageName: String;
  LATemp : AnsiString;
	LByte: Byte;
begin
    GetCommonAttribute(ImageAttrib, ARect, 8);
    ImageAttrib[38] := 8;
    ImageAttrib[39] := 9;
    ImageAttrib[40] := 0;
    ImageAttrib[41] := 0;
    ImageAttrib[42] := 9;
    ImageAttrib[43] := 0;
    ImageAttrib[44] := 0;
    ImageAttrib[45] := 0;
    ImageAttrib[46] := 0;
    ImageAttrib[47] := 0;
    if AMetafile <> nil then
      ImageAttrib[48] := 2 	// Metafile
    else
      ImageAttrib[48] := 9;	// Bitmap

    ImageAttrib[49] := 0;
    ImageAttrib[50] := 0;
    ImageAttrib[51] := 0;
    ImageAttrib[52] := 0;
    ImageAttrib[53] := $3d;
    ImageAttrib[54] := 0;
    ImageAttrib[55] := 0;
    ImageAttrib[56] := 0;
    ImageAttrib[57] := 0;
    ImageAttrib[58] := 1;
    ImageAttrib[59] := 0;
    ImageAttrib[60] := 0;
    ImageAttrib[61] := 0;
    ImageAttrib[62] := 0;
    ImageAttrib[63] := 0;
    if IsBackground then
    begin
      ImageAttrib[34] := $0A;
      BackgroundImageName := '__BkgndObj';  // For Background Image
      ImageAttrib[64] := Length(BackgroundImageName) and $FF;
      WriteRecord($5d, $3C + ImageAttrib[64] + 2 , [0], 0, ExcelStream);
      ExcelStream.Write(ImageAttrib, SizeOf(ImageAttrib));
      LATemp := AnsiString(BackgroundImageName);
      ExcelStream.Write(LATemp[1], Length(BackgroundImageName));
      LByte := 0;
      ExcelStream.Write(LByte,sizeof(LByte));
    end
    else
    begin
      ImageAttrib[34] := 0;
      WriteRecord($5d, $3c, [0], 0, ExcelStream);
      ExcelStream.Write(ImageAttrib, SizeOf(ImageAttrib) - 1);
    end;
    S := TMemoryStream.Create;
    LDC := GetDC(0);
    try
    if AMetafile <> nil then
    begin
      InfoSize := GetEnhMetaFileHeader(AMetafile.Handle, 0, nil);
      MetafileInfo := GetMemory(InfoSize);
      GetEnhMetaFileHeader(AMetafile.Handle, InfoSize, MetafileInfo);
      ImageSize := GetWinMetaFileBits(AMetafile.Handle, 0, nil, MM_ANISOTROPIC,
        LDC);
      Image := GetMemory(ImageSize);
      GetWinMetaFileBits(AMetafile.Handle, ImageSize, Image, MM_ANISOTROPIC, LDC);
      MetafileHeaderInfo[1] := 8;
      MetafileHeaderInfo[2] := 0;
      MetafileHeaderInfo[3] := MetafileInfo^.rclFrame.Right and $FF;
      MetafileHeaderInfo[4] := (MetafileInfo^.rclFrame.Right shr 8) and $FF;
      MetafileHeaderInfo[5] := MetafileInfo^.rclFrame.Bottom and $FF;
      MetafileHeaderInfo[6] := (MetafileInfo^.rclFrame.Bottom shr 8) and $FF;
      MetafileHeaderInfo[7] := 0;
      MetafileHeaderInfo[8] := 0;

      S.Write(MetafileHeaderInfo, SizeOf(MetafileHeaderInfo));
      S.Write(Image^, ImageSize);

      FreeMemory(MetafileInfo);
      FreeMemory(Image);
    end
    else
    begin

      GetDIBSizes(ABitmap.Handle, InfoSize, ImageSize);
      BitmapInfo := GetMemory(InfoSize);
      Image := GetMemory(ImageSize);
      GetDIB(ABitmap.Handle, ABitmap.Palette, BitmapInfo^, Image^);

      BitmapHeaderInfo[1] := $0c;
      BitmapHeaderInfo[2] := 0;
      BitmapHeaderInfo[3] := 0;
      BitmapHeaderInfo[4] := 0;
      BitmapHeaderInfo[5] := ABitmap.Width and $FF;
      BitmapHeaderInfo[6] := (ABitmap.Width shr 8) and $FF;
      BitmapHeaderInfo[7] := ABitmap.Height and $FF;
      BitmapHeaderInfo[8] := (ABitmap.Height shr 8) and $FF;
      BitmapHeaderInfo[9] := BitmapInfo^.bmiHeader.biPlanes and $FF;
      BitmapHeaderInfo[10] := (BitmapInfo^.bmiHeader.biPlanes shr 8) and $FF;
      BitmapHeaderInfo[11] := BitmapInfo^.bmiHeader.biBitCount and $FF;
      BitmapHeaderInfo[12] := (BitmapInfo^.bmiHeader.biBitCount shr 8) and $FF;

      S.Write(BitmapHeaderInfo, SizeOf(BitmapHeaderInfo));
      S.Write(Image^, ImageSize);
      FreeMemory(BitmapInfo);
      FreeMemory(Image);
//      ABitmap.Free;
    end;

    S.Position := 0;

    if AMetafile <> nil then
      ImageData[4] := 02	// Metafile
    else
      ImageData[4] := 9; // Bitmap

    ImageData[5] := 0;
    ImageData[6] := 1;
    ImageData[7] := 0;
    ImageData[8] := S.Size and $FF;
    ImageData[9] := (S.Size shr 8) and $FF;
    ImageData[10] := (S.Size shr 16) and $FF;
    ImageData[11] := (S.Size shr 24) and $FF;
    StreamSize := S.Size;
    if StreamSize > 2068 then
      StreamSize := 2068;
    WriteRecord($7F, StreamSize + 8, [0], 0, ExcelStream);
    ExcelStream.Write(ImageData, SizeOf(ImageData));
    StreamSize := S.Size;
    if StreamSize <= 2068 then
      ExcelStream.CopyFrom(S, 0)
    else
    begin
      S.Position := 0;
      ExcelStream.CopyFrom(S, 2068);
      StreamSize := StreamSize - 2068;
      while StreamSize > 0 do
      begin
        ContinueSize := 2068;
        if StreamSize < ContinueSize then
          ContinueSize := StreamSize;
        WriteRecord($3C, ContinueSize, [0], 0, ExcelStream);
        ExcelStream.CopyFrom(S, ContinueSize);
        StreamSize := StreamSize - ContinueSize;
      end;
    end;
    finally
      S.Free;
			ReleaseDC(0, LDC);
    end;
end;

procedure TgtExExcel95Engine.EncodeImage(AObject: TgtImageItem);
var
  LBitmap: TBitmap;
  LMetafile: TMetafile;
begin
  inherited;
  Inc(FObjectCount);
  with AObject do
  begin
    LBitmap := nil; LMetafile := nil;
    if GetGraphicResource(IndexNo) is TBitmap and
        (Settings.OutputImageFormat in [ifBMP]) then
      LBitmap := GetImageAsBitmap(AObject)
    else
      LMetafile := GetImageAsMetafile(AObject);
    EncodeGraphic(gtRect(X, Y, X + Width, Y + Height), LBitmap, LMetafile, FALSE);
    if LBitmap <> nil then
      LBitmap.Free;
    if LMetafile <> nil then
      LMetafile.Free;
  end;
end;

procedure TgtExExcel95Engine.EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen);
var
	LAttrib: array [4..47] of Byte;
  I: Integer;
begin
  for I := Low(LAttrib) to High(LAttrib) do
    LAttrib[I] := 0;
  GetCommonAttribute(LAttrib, gtRect(X1, Y1, X2, Y2), 1);

  LAttrib[38] := AddColorToColorTable(Pen.Color) + 8;
  LAttrib[39] := Byte(Pen.Style);
  LAttrib[40] := byte(Pen.Width);
  WriteRecord($5d, 44, [0], 0, ExcelStream);
  ExcelStream.Write(LAttrib, SizeOf(LAttrib));
end;

procedure TgtExExcel95Engine.EncodePolyLine(Points: TgtPoints;
  NoPoints: Integer; IsClosed: Boolean; Pen: TPen; Brush: TBrush);
var
	LAttrib: array [4..69] of Byte;
  I: Integer;
  X1, Y1, X2, Y2: Double;
  LX, LY: Word;
begin

  for I := Low(LAttrib) to High(LAttrib) do
    LAttrib[I] := 0;
  X1 := 0; Y1 := 0; X2 := 0; Y2 := 0;
  for I := 0 to NoPoints - 1 do
  begin
    if I = 0 then
    begin
      X1 := Points[I].X;
      Y1 := Points[I].Y;
    end;
    if X1 > Points[I].X then X1 := Points[I].X;
    if X2 < Points[I].X then X2 := Points[I].X;
    if Y1 > Points[I].Y then Y1 := Points[I].Y;
    if Y2 < Points[I].Y then Y2 := Points[I].Y;
  end;

  GetCommonAttribute(LAttrib, gtRect(X1, Y1, X2, Y2), 9);
  LAttrib[38] := AddColorToColorTable(clWhite) + 8;
  if IsClosed and (Brush <> nil) then
  begin
    LAttrib[39] := AddColorToColorTable(Brush.Color) + 8;
    LAttrib[40] := GetFillStyle(byte(Brush.Style));
  end;
  LAttrib[42] := AddColorToColorTable(Pen.Color) + 8;
  LAttrib[43] := Byte(Pen.Style);
  LAttrib[44] := Byte(Pen.Width);
  if IsClosed then
  begin
    LAttrib[48] := 1;
    Inc(NoPoints);
  end;
  LAttrib[60] := NoPoints and $FF;
  LAttrib[61] := (NoPoints shr 8) and $FF;

  WriteRecord($5d, 66, [0], 0, ExcelStream);
  ExcelStream.Write(LAttrib, SizeOf(LAttrib));
  WriteRecord($A9, 4 * NoPoints, [0], 0, ExcelStream);
  for I := 0 to NoPoints - 1 do
  begin
    if IsClosed and (I = NoPoints - 1) then
    begin
      LX := Round(Points[0].X - X1);
      LY := Round(Points[0].Y - Y1);
    end
    else
    begin
      LX := Round(Points[I].X - X1);
      LY := Round(Points[I].Y - Y1);
    end;
    ExcelStream.Write(LX, 2);
    ExcelStream.Write(LY, 2);
  end;
end;

procedure TgtExExcel95Engine.EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
	LAttrib: array [4..47] of Byte;
  I: Integer;
begin
  for I := Low(LAttrib) to High(LAttrib) do
    LAttrib[I] := 0;
  GetCommonAttribute(LAttrib, gtRect(X1, Y1, X2, Y2), 2);
  LAttrib[38] := AddColorToColorTable(clWhite) + 8;
  if Brush <> nil then
  begin
    LAttrib[39] := AddColorToColorTable(Brush.Color) + 8;
    LAttrib[40] := GetFillStyle(byte(Brush.Style));
  end;
  LAttrib[42] := AddColorToColorTable(Pen.Color) + 8;
  LAttrib[43] := Byte(Pen.Style);
  LAttrib[44] := Byte(Pen.Width);
  WriteRecord($5d, 44, [0], 0, ExcelStream);
  ExcelStream.Write(LAttrib, SizeOf(LAttrib));
end;

procedure TgtExExcel95Engine.EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
  Pen: TPen; Brush: TBrush);
var
	LAttrib: array [4..47] of Byte;
  I: Integer;
  LFrameStyle: Word;
begin
  for I := Low(LAttrib) to High(LAttrib) do
    LAttrib[I] := 0;
  GetCommonAttribute(LAttrib, gtRect(X1, Y1, X2, Y2), 2);
  LAttrib[38] := AddColorToColorTable(clWhite) + 8;
  if Brush <> nil then
  begin
    LAttrib[39] := AddColorToColorTable(Brush.Color) + 8;
    LAttrib[40] := GetFillStyle(byte(Brush.Style));
  end;
  LAttrib[42] := AddColorToColorTable(Pen.Color) + 8;
  LAttrib[43] := Byte(Pen.Style);
  LAttrib[44] := Byte(Pen.Width);
  LFrameStyle := 1 + Round((X3 + Y3) / 2) shl 2;
  LAttrib[46] := LFrameStyle and $FF;
  LAttrib[47] := (LFrameStyle shr 8) and $FF;
  WriteRecord($5d, 44, [0], 0, ExcelStream);
  ExcelStream.Write(LAttrib, SizeOf(LAttrib));
end;

procedure TgtExExcel95Engine.EncodeShapeBitmap(X, Y: Double; Bitmap: TBitmap);
begin
  inherited;
  EncodeGraphic(gtRect(X, Y, X + Bitmap.Width, Y + Bitmap.Height), Bitmap,
    nil, FALSE);
end;

procedure TgtExExcel95Engine.EncodeText(AObject: TgtTextItem);
var
  I : Integer;
begin
  inherited;
    { To calculate Maximum  Font within a Row}
  with TgtFmTextItem(AObject) do
  begin
    if (RowNo <> FLastRowNo) {and (FLastRowNo <> - 1)} then
    begin
      if FLastRowNo <> - 1 then
        FRowHeights.Add(TObject(FMaxCellSize));
      for I := (FLastRowNo + 1) to (RowNo - 1) do
        FRowHeights.Add(TObject(FDefaultCellHeight));
      FMaxCellSize := FDefaultCellHeight;
      FLastRowNo := RowNo;
    end
    else
    if TextSize('W', Font).cy > FMaxCellSize then
      FMaxCellSize := TextSize('W', Font).cy;
  end;
end;

procedure TgtExExcel95Engine.EncodeTextBox(AObject: TgtTextBoxItem);
var
	LAttrib: array [4..73] of Byte;
  LWord, LTextLength: Word;
  I, LInt: Integer;
  LText: String;
  LATemp : AnsiString;
begin
  with AObject do
  begin
    for I := 4 to 73 do
      LAttrib[I] := 0;

    for I := 0 to Lines.Count - 1 do
      LText := LText + Trim(Lines[I]);
    LText := ReplacePlaceHolders(LText, True);
    LTextLength := Length(LText);
    GetCommonAttribute(LAttrib, gtRect(X, Y, X + BoxWidth, Y + BoxHeight), 6);
    LAttrib[38] := Byte(AddColorToColorTable(clWhite) + 8);
    LAttrib[39] := Byte(AddColorToColorTable(Brush.Color) + 8);
    LAttrib[40] := GetFillStyle(byte(Brush.Style));
    LAttrib[42] := Byte(AddColorToColorTable(Pen.Color) + 8);
    LAttrib[43] := Byte(Pen.Style);
    LAttrib[44] := Byte(Pen.Width);
    LAttrib[48] := ( LTextLength and $FF);
    LAttrib[49] := ((LTextLength shr 8) and $FF);
    LAttrib[52] := 16; // Minimum Two TextRun's Length
    case HAlign of
      haLeft: LAttrib[58] := LAttrib[58] + 2;
      haRight: LAttrib[58] := LAttrib[58] + 6;
      haCenter: LAttrib[58] := LAttrib[58] + 4;
      haJustify: LAttrib[58] := LAttrib[58] + 14;
    end;
    case VAlign of
      vaTop: LAttrib[58] := LAttrib[58] + 16;
      vaCenter: LAttrib[58] := LAttrib[58] + 32;
      vaBottom: LAttrib[58] := LAttrib[58] + 48;
    end;
    LAttrib[59] := 0;
    WriteRecord($5d, 86 + LTextLength, [0], 0, ExcelStream);
    ExcelStream.Write(LAttrib, SizeOf(LAttrib));
    LATemp := AnsiString(LText);
    ExcelStream.Write(LATemp[1], LTextLength);

    LInt := 0;
    LWord := 0;
    ExcelStream.Write(LWord, 2);
    LWord := AddFontInfoToFontTable(Font) + 5;
    ExcelStream.Write(LWord, 2);
    ExcelStream.Write(LInt, 4);
    LWord := 0;
    ExcelStream.Write(LTextLength, 2);
    ExcelStream.Write(LWord, 2);
    ExcelStream.Write(LInt, 4);
  end;
end;

procedure TgtExExcel95Engine.Finish;
begin
  inherited;
  FreeAndNil(FRowHeights);
  FreeAndNil(FMaxFont);
end;

procedure TgtExExcel95Engine.FormulaOut(Row, Column: Integer; Text: String;
  Alignment: TgtHAlignment; FormulaType: TgtExcelFormulaType);
var
  FFormulaItem: TgtFormulaItem;
begin
  if not FIsDocumentStarted then
    Exit;

  FFormulaItem := TgtFormulaItem.Create;
  FFormulaItem.FRowNo := Row;
  FFormulaItem.FColNo := Column;
  FFormulaItem.Lines := Text;
  FFormulaItem.Alignment := Alignment;
  FFormulaItem.Font := Font;
  FFormulaItem.Brush := Brush;
  FFormulaItem.FFormulaType := FormulaType ;
  EncodeFormula(FFormulaItem);
end;

procedure TgtExExcel95Engine.GetCommonAttribute(var AObjectAttrib: array of byte;
  ARect: TgtRect; AObjectType: Byte);
var
  LTop, LTopOffset, LBottom, LBottomOffset: Integer;
  LLeft, LRight, LLeftOffset,  LRightOffset: Integer;
begin

  AbsVertPosn(ARect.Top, ARect.Bottom - ARect.Top, LTop,
    LTopOffset, LBottom, LBottomOffset);
  LTop := LTop + FLastPageHeight;
  LBottom := LBottom + FLastPageHeight;

  AbsHorPosn(ARect.Left, ARect.Right - ARect.Left, LLeft,
    LLeftOffset, LRight, LRightOffset);

  AObjectAttrib[0] := FObjectCount and $FF;
  AObjectAttrib[1] := (FObjectCount shr 8) and $FF;
  AObjectAttrib[2] := (FObjectCount shr 16) and $FF;
  AObjectAttrib[3] := (FObjectCount shr 24) and $FF;
  AObjectAttrib[4] := AObjectType;
  AObjectAttrib[5] := 0;
  AObjectAttrib[6] := (FObjectCount ) and $FF;
  AObjectAttrib[7] := ((FObjectCount ) shr 8) and $FF;
  AObjectAttrib[8] := 4;
  AObjectAttrib[9] := 6;
  AObjectAttrib[10] := LLeft and $FF;
  AObjectAttrib[11] := (LLeft shr 8) and $FF;
  AObjectAttrib[12] := LLeftOffset and $FF;
  AObjectAttrib[13] := (LLeftOffset shr 8) and $FF;
  AObjectAttrib[14] := LTop and $FF;
  AObjectAttrib[15] := (LTop shr 8) and $FF;
  AObjectAttrib[16] := LTopOffset and $FF;
  AObjectAttrib[17] := (LTopOffset shr 8) and $FF;
  AObjectAttrib[18] := LRight and $FF;
  AObjectAttrib[19] := (LRight shr 8) and $FF;
  AObjectAttrib[20] := LRightOffset and $FF;
  AObjectAttrib[21] := (LRightOffset shr 8) and $FF;
  AObjectAttrib[22] := LBottom and $FF;
  AObjectAttrib[23] := (LBottom shr 8) and $FF;
  AObjectAttrib[24] := LBottomOffset and $FF;
  AObjectAttrib[25] := (LBottomOffset shr 8) and $FF;
  AObjectAttrib[26] := 0;
  AObjectAttrib[27] := 0;
  AObjectAttrib[28] := 0;
  AObjectAttrib[29] := 0;
  AObjectAttrib[30] := 0;
  AObjectAttrib[31] := 0;
  AObjectAttrib[32] := 0;
end;


procedure TgtExExcel95Engine.Line(X1, Y1, X2, Y2: Double);
begin
  inherited;

end;

procedure TgtExExcel95Engine.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtExExcel95Engine.PolyBezier(Points: array of TgtPoint);
begin
  inherited;

end;

procedure TgtExExcel95Engine.Polygon(Points: array of TgtPoint;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtExExcel95Engine.PolyLine(Points: array of TgtPoint);
begin
  inherited;

end;

procedure TgtExExcel95Engine.ProcessMetafile(AX, AY: Double;
  AMetafile: TMetafile);
var
  LImageItem: TgtImageItem;
begin
  if Preferences.MetafileAsImage then
  begin
    LImageItem := TgtImageItem.Create;
    LImageItem.X := BandRect.Left + NativeXPos(AX);
    LImageItem.Y := BandRect.Top + NativeYPos(AY);
    LImageItem.Width := AMetafile.Width;
    LImageItem.Height := AMetafile.Height;
    with LImageItem do
      DisplayRect := gtRect(X, Y, X + Width, Y + Height);
    LImageItem.Settings.OutputImageFormat := ifMetafile;
    LImageItem.IndexNo := AddImageAsResource(AMetafile,
      Preferences.UseImagesAsResources);
    AddDocumentItem(LImageItem);
  end
  else
    inherited;
end;

procedure TgtExExcel95Engine.Rectangle(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtExExcel95Engine.RoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtExExcel95Engine.Start;
begin
  inherited;
  FRowHeights := TList.Create;

  FMaxFont := TFont.Create;
  FMaxFont.Name := 'Arial';
  FMaxFont.Size := 10;
end;

procedure TgtExExcel95Engine.WriteBackgroundImage;
var
  LBitmap: TBitmap;
begin
  inherited;
  with BackgroundImage do
  if Graphic <> nil then
  begin
    LBitmap := TBitmap.Create;
    LBitmap.Width := Graphic.Width;
    LBitmap.Height := Graphic.Height;
    LBitmap.PixelFormat := pf24bit;
    LBitmap.Canvas.Draw(0, 0, Graphic);
    EncodeGraphic(gtRect(0,0, Graphic.Width, Graphic.Height), LBitmap, nil, True);
    LBitmap.Free;
  end;
end;

{ TgtFormulaItem }

constructor TgtFormulaItem.Create;
begin
  FLines := '';
  FFont := TFont.Create;
  FBrush := TBrush.Create;
  FAlignment := haLeft;
end;

destructor TgtFormulaItem.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FBrush);
  inherited;
end;

procedure TgtFormulaItem.SetAlignment(const Value: TgtHAlignment);
begin
  FAlignment := Value;
end;

procedure TgtFormulaItem.SetBrush(const Value: TBrush);
begin
  FBrush := Value;
end;

procedure TgtFormulaItem.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

procedure TgtFormulaItem.SetFormulaType(const Value: TgtExcelFormulaType);
begin
  FFormulaType := Value;
end;

end.

