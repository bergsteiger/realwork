unit ddTextParagraph;

interface

uses
  Classes,

  ddBase,
  ddTypes,
  ddSubsList,
  ddHyperlink,
  ddTextSegment,
  ddDocumentAtom,
  ddTextSegmentsList,
  ddCharacterProperty,
  ddCustomDestination,
  ddParagraphProperty,

  k2Prim,
  k2Interfaces,

  rtfListTable,

  l3Base,
  l3Types,
  l3ProtoObject,
  l3ProtoPersistentRefList;

type
  TddTextParagraph = class(TddDocumentAtom)
  private
    f_SkipAlign : Boolean;
    f_CharacterStyle: LongInt;
    f_CHP: TddCharacterProperty;
    f_ID: Integer;
    f_PAP: TddParagraphProperty;
    f_Segments: TddTextSegmentsList;
    f_SubList: TddSubsList;
    f_OEM: Boolean;
    f_Width: LongInt;
    f_Text: Tl3String;
    f_Inc: Integer;
    f_Offset: Integer;
    f_ItemText: Tl3String;
    f_BlockIndent: Integer;
    f_IgnoreLeftIndent: Boolean;
   private
    function CheckSpaceInText: Boolean;
    procedure CheckPAP;
    procedure CheckSymbolFont;
    procedure Process(aNewStyle: Integer); // Всякие предварительные обработки параграфа.
    procedure CheckTablList;
    procedure CheckListItem;
    function GetLastPara: TddDocumentAtom; override;
    function CheckInTable(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion): Boolean;
    function GetSegmentCount: Integer;
    procedure SetCHP(Value: TddCharacterProperty);
    procedure SetPAP(Value: TddParagraphProperty);
    function WritePAP(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion; aStyled: Boolean): Boolean;
    procedure WriteSegments(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
    procedure WriteTabStops(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
    procedure AddStyleSegment(aCHP: TddCharacterProperty);
    procedure CheckPrevSegment(aHyperlink: TddHyperlink);
    procedure CheckUpperOrLower;
    procedure AddSegmenFromListIndex(aCHP: TddCharacterProperty; aTextLen: Integer);
    function AddListItemText(aText: AnsiString): Integer;    
  protected
    function CheckSegments: Boolean;
    function GetEmpty: Boolean; override;
    function GetSegments(Index: Integer): TddTextSegment;
    function GetText: Tl3String;
    procedure Cleanup; override;
    procedure SetText(aTExt: Tl3String);
    procedure WriteSubs(const aGenerator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
    procedure AddOldListItem;
    procedure ClearOldListItem;
  public
    constructor Create(aDetination: TddCustomDestination); override;
    procedure AddItemText(const aItemText: AnsiString);
     {* - Добавить текст пункта, как в Word 6/95. }
    procedure AddHyperlink(aText: AnsiString; aDocID, aSubID: Integer);
    procedure AddHyperlinkWithURL(aStart: Integer; const aURL: AnsiString);
    procedure AddListIndex(const aList: TrtfList; aLite: Boolean; aWasRestarted: Boolean);
    procedure AddPicture(aPicture: TddDocumentAtom; aMove: Boolean);
    procedure AddFormula(aFormula: TddDocumentAtom);
    procedure AddSegment(aCHP: TddCharacterProperty; aStateCHP: TddCharacterProperty; const RelativeToText:
            Boolean = False); overload;
    procedure AddSegment(aSegment: TddTextSegment); overload;
    procedure AddSub(aSubID: Integer; aName: AnsiString; aIsRealName: Boolean = True); overload;
    procedure AddSub(aSubID: Integer; const aName: Tl3PCharLen); overload;
    procedure AddText(aText: AnsiChar; const aCodePage: Long = CP_ANSI); overload;
    procedure AddText(aText: AnsiString; const aCodePage: Long = CP_ANSI); overload;
    procedure AddText(aText: Tl3String); overload;
    function IsTextPara: Boolean; override;        
    procedure ApplyCHP(aCHP: TddCharacterProperty);
    procedure ApplyPAP(aPAP: TddParagraphProperty);
    procedure Assign(const aDocAtomObj: Tl3ProtoObject); override;
    procedure Clear; override;
    procedure ClearSegments;
    procedure CorrectSegments(aPrevPara: TddTextParagraph);
    function HasSoftEnter: Boolean; override;
    function HaveSegments: Boolean;
    function HaveHyperlinks: Boolean;
    function HyperlinkByCharIndex(Index: Longint; const EndSegment: Boolean =
            False): TddTextSegment;
    function ObjectByCharIndex(Index: Longint; const EndSegment: Boolean = False): TddTextSegment;
    function JoinWith(P: TObject; aCorrectSegment: Boolean = False): Long;
            override;
    function LastStyledSegment: TddTextSegment;
    procedure RemoveSegment(aSegment: TddTextSegment);
    procedure PackSegments;
    function PrevCHP(aCurSegment: TddTextSegment): TddCharacterProperty;
    function SegmentByCharIndex(Index: Longint; const EndSegment: Boolean = False; const StartIndex:
        Integer = -1): TddTextSegment;
    procedure Write2Generator(const Generator: Ik2TagGenerator; aNeedProcessRow: Boolean; aLiteVersion: TddLiteVersion); override;
    property CharacterStyle: LongInt read f_CharacterStyle write
            f_CharacterStyle;
    property CHP: TddCharacterProperty read f_CHP write SetCHP;
    property ID: Integer read f_ID write f_ID;
    property PAP: TddParagraphProperty read f_PAP write SetPAP;
    property SegmentCount: Integer read GetSegmentCount;
    property Segments[Index: Integer]: TddTextSegment read GetSegments;
    property SubList: TddSubsList read f_SubList write f_SubList;
    property Text: Tl3String read GetText write SetText;
    property OEMText: Boolean read f_OEM write f_OEM;
    property Width: LongInt read f_Width write f_Width;
    property BlockIndent: Integer read f_BlockIndent write f_BlockIndent;
    property IgnoreLeftIndent: Boolean read f_IgnoreLeftIndent write f_IgnoreLeftIndent;
    property SkipAlign: Boolean read f_SkipAlign write f_SkipAlign;
  end;

implementation

uses
  evdTypes,

  Windows,

  Math,
  SysUtils,

  l3Math,
  l3RegEx,
  l3Const,
  l3Chars,
  l3String,
  l3Memory,
  l3Interfaces,
  l3FontManager,


  k2Tags,
  evdStyles,

  RTfTypes,
  destNorm,

  ddSub,
  ddTab,
  ddRTFConst,
  ddRTFUnits,
  ddStyleSegment,
  ddObjectSegment,
  ddRTFProperties,
  ddTextParaString,
  ddPictureSegment,
  ddFormulaSegment,
  ddHyperlinkTarget,

  imageenio,
  imageenview,

  TextPara_Const,
  SegmentsLayer_Const,
  TextSegment_Const,
  Hyperlink_Const,
  Address_Const,
  SubLayer_Const,
  Sub_Const,
  Tabstop_Const,
  BitmapPara_Const,
  ObjectSegment_Const;

{ TddTextParagraph }

{
******************************* TddTextParagraph *******************************
}
constructor TddTextParagraph.Create(aDetination: TddCustomDestination);
begin
 inherited Create(aDetination);
 f_CHP := TddCharacterProperty.Create;
 f_PAP := TddParagraphProperty.Create;
 f_Segments := TddTextSegmentsList.Make;
 f_SubList := TddSubsList.Make;
 f_Text := TddTextParaString.Create(Self);
 f_Inc := 0;
 f_Offset := 0;
 f_BlockIndent := propUndefined;
 f_IgnoreLeftIndent := False;
 f_SkipAlign := False;
end;

procedure TddTextParagraph.AddHyperlink(aText: AnsiString; aDocID, aSubID: Integer);
var
 l_Seg: TddTextSegment;
begin
 l_Seg := TddHyperlink.Create;
 try
  l_Seg.AddTarget(aDocID, aSubID, CI_TOPIC);
  l_Seg.Start := Succ(Text.Len);
  AddText(aText);
  l_Seg.Stop := Succ(Text.Len);
  AddSegment(l_Seg);
 finally
  FreeAndNil(l_Seg);
 end;
end;

procedure TddTextParagraph.AddListIndex(const aList: TrtfList; aLite: Boolean; aWasRestarted: Boolean);

 function lp_Index2Letter(anIndex: Integer; anUpper: Boolean; aRussian: Boolean): AnsiString;
 const
  cnStartCharIndexEng: array [Boolean] of array [Boolean] of Integer = ((Ord('a') - 1, Ord('A') - 1), (Ord('а') - 1, Ord('А') - 1));
  cnCharsInAlphabet: array [Boolean] of Integer = (26, 30);
  cnSoftSignIndex = 27;
  cnHardSignIndex = 28;
 var
  l_Index     : Integer;
  l_CharsCount: Integer;
 begin
  Result := '';
  l_CharsCount := cnCharsInAlphabet[aRussian];
  while anIndex > 0 do
  begin
   l_Index := anIndex mod l_CharsCount;
   if l_Index = 0 then
    l_Index := l_CharsCount;
   if aRussian then
    if (l_Index = cnSoftSignIndex) then
     Inc(l_Index)
    else
     if (l_Index >= cnHardSignIndex) then
      Inc(l_Index, 2);
   Result := Result + Chr(cnStartCharIndexEng[aRussian, anUpper] + l_Index);
   Dec(anIndex, l_CharsCount);
  end; // while anIndex > 0 do
 end;

const
 cnArabicID = 0;
 cnBulletID = 23;

var
 l_iLvl     : Integer;
 l_ListLevel: TrtfListLevel;

 function lp_GetLevelText: AnsiString;

  procedure lp_AddSeparator;
  const
   cnTabSymb = 0;
  begin
   if Result <> '' then
   begin
    Result := Result + cc_SoftSpace; // http://mdp.garant.ru/pages/viewpage.action?pageId=623066444
    if (aList.Levels[l_iLvl].Follow = cnTabSymb) and (PAP.TabList.Count > 0) then
     PAP.TabList.Clear;
   end; // if Result <> '' then
  end;

 var
  i              : Integer;
  l_Index        : Integer;
  l_Count        : Integer;
  l_LevelNFC     : Integer;
  l_CountItems   : Integer;
  l_LevelIndexStr: array[0..8] of String;
 begin
  Result := '';
  l_Count := 0;
  for i := 0 to 8 do
   l_LevelIndexStr[i] := '';
  l_CountItems := Length(l_ListLevel.Numbers);
  if (l_CountItems = 0) and (l_ListLevel.levelnfc = cnBulletID) then
   l_LevelIndexStr[l_Count] := '-'
  else
  for i := 1 to l_CountItems do
  begin
   if aList.Levels[l_iLvl].Numbers[i] < cc_Tab then
   begin
    aList.GetNumberAndNFC(i, l_iLvl, l_Index, l_LevelNFC);
    case l_LevelNFC of
     cnArabicID:	l_LevelIndexStr[l_Count] := IntToStr(l_Index); //Arabic (1, 2, 3)
     1:	l_LevelIndexStr[l_Count] := l3IntToRoman(l_Index);//Uppercase Roman numeral (I, II, III)
     2:	l_LevelIndexStr[l_Count] := LowerCase(l3IntToRoman(l_Index));//Lowercase Roman numeral (i, ii, iii)
     3:	l_LevelIndexStr[l_Count] := lp_Index2Letter(l_Index, True, False); //Uppercase letter (A, B, C)
     4:	l_LevelIndexStr[l_Count] := lp_Index2Letter(l_Index, False, False); //Lowercase letter (a, b, c)
     5:	l_LevelIndexStr[l_Count] := Format('%d-й', [l_Index]);//Ordinal number (1st, 2nd, 3rd)
     6:	l_LevelIndexStr[l_Count] := IntToStr(l_Index);//Cardinal text number (One, Two Three)
     7:	l_LevelIndexStr[l_Count] := IntToStr(l_Index);//Ordinal text number (First, Second, Third)
    (*
     10	Kanji numbering without the digit character (DBNUM1)
     11	Kanji numbering with the digit character (DBNUM2)
     12	46 phonetic katakana characters in "aiueo" order (AIUEO) (newer form - "????????" based on phonem matrix)
     13	46 phonetic katakana characters in "iroha" order (IROHA) (old form - "???????????????" based on haiku from long ago)
     14	Double-byte character
     15	Single-byte character
     16	Kanji numbering 3 (DBNUM3)
     17	Kanji numbering 4 (DBNUM4)
     18	Circle numbering (CIRCLENUM)
     19	Double-byte Arabic numbering
     20	46 phonetic double-byte katakana characters (AIUEO DBCHAR)
     21	46 phonetic double-byte katakana characters (IROHA DBCHAR)
     *)
     22:	l_LevelIndexStr[l_Count] := Format('%.2d', [l_Index]); //Arabic with leading zero (01, 02, 03, ..., 10, 11)
     cnBulletID: l_LevelIndexStr[l_Count] := '-'; //	Bullet (no number at all)
     (*
     24	Korean numbering 2 (GANADA)
     25	Korean numbering 1 (CHOSUNG)
     26	Chinese numbering 1 (GB1)
     27	Chinese numbering 2 (GB2)
     28	Chinese numbering 3 (GB3)
     29	Chinese numbering 4 (GB4)
     30	Chinese Zodiac numbering 1 (ZODIAC1)
     31	Chinese Zodiac numbering 2 (ZODIAC2)
     32	Chinese Zodiac numbering 3 (ZODIAC3)
     33	Taiwanese double-byte numbering 1
     34	Taiwanese double-byte numbering 2
     35	Taiwanese double-byte numbering 3
     36	Taiwanese double-byte numbering 4
     37	Chinese double-byte numbering 1
     38	Chinese double-byte numbering 2
     39	Chinese double-byte numbering 3
     40	Chinese double-byte numbering 4
     41	Korean double-byte numbering 1
     42	Korean double-byte numbering 2
     43	Korean double-byte numbering 3
     44	Korean double-byte numbering 4
     45	Hebrew non-standard decimal
     46	Arabic Alif Ba Tah
     47	Hebrew Biblical standard
     48	Arabic Abjad style
     49	Hindi vowels
     50	Hindi consonants
     51	Hindi numbers
     52	Hindi descriptive (cardinals)
     53	Thai letters
     54	Thai numbers
     55	Thai descriptive (cardinals)
     56	Vietnamese descriptive (cardinals)
     57	Page number format - # -
     *)
     58: l_LevelIndexStr[l_Count] := lp_Index2Letter(l_Index, False, True);//Lower case Russian alphabet
     59: l_LevelIndexStr[l_Count] := lp_Index2Letter(l_Index, True, True);//Upper case Russian alphabet
     (*
     60	Lower case Greek numerals (alphabet based)
     61	Upper case Greek numerals (alphabet based)
     *)
     62:	l_LevelIndexStr[l_Count] := Format('%.3d', [l_Index]);// 2 leading zeros: 001, 002, ..., 100, ...
     63:	l_LevelIndexStr[l_Count] := Format('%.4d', [l_Index]);//3 leading zeros: 0001, 0002, ..., 1000, ...
     64:	l_LevelIndexStr[l_Count] := Format('%.5d', [l_Index]);//4 leading zeros: 00001, 00002, ..., 10000, ...
     (*
     65	Lower case Turkish alphabet
     66	Upper case Turkish alphabet
     67	Lower case Bulgarian alphabet
     68	Upper case Bulgarian alphabet
     *)
     255:	l_LevelIndexStr[l_Count] := '';
    end; // case
    Inc(l_Count);
   end; // AnsiChar < #9
  end; // for i

  case l_Count of
   0:
   if aList.Levels[0].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0]])
   else
    Result := l_LevelIndexStr[0];
   1:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1]])
   else
    Result := l_LevelIndexStr[1];
   2:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1], l_LevelIndexStr[2]])
   else
    Result := l_LevelIndexStr[2];
   3:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1], l_LevelIndexStr[2]])
   else
    Result := l_LevelIndexStr[3];
   4:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1], l_LevelIndexStr[2], l_LevelIndexStr[3]])
   else
    Result := l_LevelIndexStr[4];
   5:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1], l_LevelIndexStr[2], l_LevelIndexStr[3], l_LevelIndexStr[4]])
   else
    Result := l_LevelIndexStr[5];
   6:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1], l_LevelIndexStr[2], l_LevelIndexStr[3], l_LevelIndexStr[4], l_LevelIndexStr[5]])
   else
    Result := l_LevelIndexStr[6];
   7:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1], l_LevelIndexStr[2], l_LevelIndexStr[3], l_LevelIndexStr[4], l_LevelIndexStr[5], l_LevelIndexStr[6]])
   else
    Result := l_LevelIndexStr[7];
   8:
   if aList.Levels[l_iLvl].Text <> '' then
    Result := Format(aList.Levels[l_iLvl].Text, [l_LevelIndexStr[0], l_LevelIndexStr[1], l_LevelIndexStr[2], l_LevelIndexStr[3], l_LevelIndexStr[4], l_LevelIndexStr[5], l_LevelIndexStr[6], l_LevelIndexStr[7]])
   else
    Result := l_LevelIndexStr[8];
  end;

  lp_AddSeparator;
 end;

var
 l_HasText      : Boolean;
 l_LevelText    : AnsiString;
 l_TextLength   : Integer;
 l_UnicodeSymbol: WideChar;
begin
 if (aList <> nil) then
 begin
  ClearOldListItem;
  l_iLvl := PAP.iLvl;
  if l_iLvl >= aList.Count then // Пока запиливаем: http://mdp.garant.ru/pages/viewpage.action?pageId=537954808
   l_iLvl := aList.Count - 1;
  l_ListLevel := aList.Levels[l_iLvl];
  l_LevelText := '';
  if aWasRestarted and (l_iLvl > 0) and (l_ListLevel.levelnfc > 0) then // http://mdp.garant.ru/pages/viewpage.action?pageId=602001112
 	 l_ListLevel.Restart;
  if (l_ListLevel.UnicodeText.Len > 0) then // Здесь идет обработка Unicode-строк. Пока отдельно, т.к. объединение с Ansi-версией без переделок нереально.
  begin
   case l_ListLevel.LevelNFC of  
    cnBulletID: ; // http://mdp.garant.ru/pages/viewpage.action?pageId=590757091
    cnArabicID: l_LevelText := lp_GetLevelText;
   end; // case l_ListLevel.LevelNFC of
  end // if (l_ListLevel.UnicodeBuffer.Size > 0) then
  else
   l_LevelText := lp_GetLevelText;
  l_TextLength := AddListItemText(l_LevelText);
  if l_ListLevel.UnicodeText.Len > 0 then
  begin
   Text.Insert(l_ListLevel.UnicodeText, 0);
   Inc(l_TextLength, l_ListLevel.UnicodeText.Len);
  end; // if l_Str.SLen > 0 then
  CheckUpperOrLower;
  AddSegmenFromListIndex(aList.Levels[l_iLvl].CHP, l_TextLength);
 end // List <> nil;
 else
  AddOldListItem;
end;

procedure TddTextParagraph.AddPicture(aPicture: TddDocumentAtom; aMove: Boolean);
var
 l_Seg: TddTextSegment;
begin
 if aMove and not f_Segments.Empty and (f_Segments.Last is TddPictureSegment) then
 begin
  l_Seg := f_Segments.Last;
  l_Seg.Data.Assign(aPicture);
 end // if aMove and not f_Segments.Empty and (f_Segments.Last.ObjectType = dd_sotPicture) then
 else
 begin
  l_Seg := TddPictureSegment.Create;
  try
   l_Seg.Data := aPicture;
   Text.Append('*');
   l_Seg.Start := Text.Len;
   l_Seg.Stop := Text.Len;
   AddSegment(l_Seg);
  finally
   FreeAndNil(l_Seg);
  end;
 end;
end;

procedure TddTextParagraph.AddSegment(aCHP: TddCharacterProperty; aStateCHP: TddCharacterProperty; const
        RelativeToText: Boolean = False);
var
 l_S2: TddTextSegment;

 procedure lp_ClearSegment;
 begin
  l_S2.Start := 0;
  l_S2.CHP.AssignFrom(CHP);
  CHP.AssignFrom(aStateCHP);
 end;

 procedure lp_AddAndClear;
 begin
  AddStyleSegment(aCHP);
  CHP.AssignFrom(aStateCHP);
 end;

var
 l_S         : TddTextSegment;
 l_Diff      : TddCharacterProperty;
 l_HasSegment: Boolean;
begin
 if aCHP <> nil then
 begin
  l_Diff := TddCharacterProperty(CHP.Diff(aCHP, True));
  try
   l_S2 := LastStyledSegment;
   l_HasSegment := l_S2 <> nil;
   if (l_Diff = nil) then
   begin
    if (aStateCHP <> nil) and not l_HasSegment then
     lp_AddAndClear
    else
     if (aStateCHP <> nil) and l_HasSegment and not aStateCHP.Bold and CHP.Bold then
     begin
      if (l_S2.Stop = Text.Len) then
       if l_S2.CHP.Bold then
       begin
        if (l_S2.Start > 1) then
         lp_ClearSegment;
       end // if l_S2.CHP.Bold then
       else
        lp_ClearSegment;
     end; // if (aStateCHP <> nil) and l_HasSegment and not aStateCHP.Bold and CHP.Bold then
   end // if (l_Diff = nil) then
   else
    if (aStateCHP <> nil) and (aStateCHP.OCompare(aCHP) <> 0) and (aStateCHP.FontNumber <> CHP.FontNumber) and not l_HasSegment then
     lp_AddAndClear
    else
    begin
     l_S := TddStyleSegment.Create;
     try
      l_S.CHP := aCHP;
      l_S.Start := Text.Len + 1;
      if l_HasSegment then
      begin
       if (l_S2.CHP.OCompare(aCHP) <> 0) and (l_S2.Stop = 0) then
       begin
        l_S2.Stop := Text.Len;
        AddSegment(l_S);
       end // l_S2.CHP.OCompare(aCHP) <> 0
       else
        AddSegment(l_S);
      end // if HaveSegments then
      else
       AddSegment(l_S);
     finally
      FreeAndNil(l_S);
     end; // l_S
    end;
   finally
    FreeAndNil(l_Diff);
   end;
  end;  // aCHP <> nil
end;

procedure TddTextParagraph.AddSegment(aSegment: TddTextSegment);
begin
 aSegment.Index := f_Segments.Add(aSegment);
end;

procedure TddTextParagraph.AddSub(aSubID: Integer; aName: AnsiString; aIsRealName: Boolean = True);
var
 l_Sub: TddSub;
begin
 l_Sub := TddSub.Create;
 try
  l_Sub.ID := aSubID;
  l_Sub.Name.AsString := aName;
  l_Sub.IsRealName := aIsRealName;
  f_SubList.Add(l_Sub);
 finally
  FreeAndNil(l_SuB);
 end;
end;

procedure TddTextParagraph.AddText(aText: AnsiChar; const aCodePage: Long =
        CP_ANSI);
begin
 f_Text.Append(aText, 1, aCodePage);
end;

procedure TddTextParagraph.AddText(aText: AnsiString; const aCodePage: Long =
        CP_ANSI);
begin
 if aText <> '' then
  f_Text.Append(l3PCharLen(aText, aCodePage));
end;

function TddTextParagraph.GetEmpty: Boolean;
begin
 Result:= not l3CharSetPresent(Text.st, Text.Len, [#0..#255]-[#32]);
end;

procedure TddTextParagraph.AddText(aText: Tl3String);
var
 l_LastSegment: TddTextSegment;
begin
 if not aText.Empty then
 begin
  f_Text.JoinWith(aText);
  l_LastSegment := LastStyledSegment;
  if (l_LastSegment <> nil) and (l_LastSegment.Stop = 0) then
   l_LastSegment.Stop := Text.Len;
 end;
end;

procedure TddTextParagraph.ApplyCHP(aCHP: TddCharacterProperty);
var
 l_Seg: TddTextSegment;
begin
 if aCHP <> nil then
 begin
  if CHP.IsDefault and not aCHP.IsDefault then
  begin
   if HaveSegments then
   begin
    l_Seg := f_Segments.Last;
    l_Seg.CHP.JoinWith(aCHP);
   end // if HaveSegments then
   else
    if CHP.IsDefault then
     CHP.AssignFrom(aCHP);
  end; // CHP.IsDefault and not aCHP.IsDefault
 end; // aCHP <> nil
end;

procedure TddTextParagraph.ApplyPAP(aPAP: TddParagraphProperty);
begin
 if aPAP <> nil then
  if PAP.IsDefault and not aPAP.IsDefault then
   PAP := aPAP;
end;

procedure TddTextParagraph.Assign(const aDocAtomObj: Tl3ProtoObject);
var
 l_Par: TddTextParagraph;
begin
 if aDocAtomObj is TddTextParagraph then
 begin
  l_Par := aDocAtomObj as TddTextParagraph;
  f_CHP.AssignFrom(l_Par.CHP);
  f_PAP.AssignFrom(l_Par.PAP);
  f_ID := l_Par.ID;
  f_Segments.Assign(l_Par.f_Segments);
  f_SubList.Assign(l_Par.SubList);
  f_Text.Assign(l_Par.f_Text);
 end
 else
  inherited;
end;

function TddTextParagraph.CheckInTable(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion): Boolean;
begin
 Result := False;
 if PAP.InTable then
 begin
  if aLiteVersion > dd_lvNone then
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalTable)
  else
   if PAP.Style < 0 then
    Generator.AddIntegerAtom(k2_tiStyle, PAP.Style)
   else
    Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
  if aLiteVersion > dd_lvNone then
   case PAP.Just of
    justR: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itRight));
    justC: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itCenter));
    justF: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itWidth));
   else
    Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
  end; { case Just}
  Result := True;
 end // InTable
 else // Проверяем наличие псевдографики в тексте абзаца
 begin
  if ((Text.CodePage = cp_OEM) or (Text.CodePage = cp_OEMLite)) and
     l3CharSetPresent(Text.st, Text.Len, cc_Graph_Criteria) then
  begin
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtNormalOEM);
   Result := True;
  end; // if...
 end; // not InTable;
end;

function TddTextParagraph.CheckSegments: Boolean;
var
 j    : Integer;
 l_Seg: TddTextSegment;
 l_CHP: TddCharacterProperty;
begin
 Result := False;
 for j := 0 to f_Segments.Hi do
 begin
  l_Seg := Segments[j];
  begin
   if l_Seg.IsHyperlink or l_Seg.IsObjectSegment then
   begin
    Result:= True;
    Break;
   end // l_Seg.IsHyperLink
   else
   begin
    l_CHP := TddCharacterProperty(CHP.Diff(l_Seg.CHP, True));
    try
     if ((l_CHP <> nil) or (l_Seg.CHP.Style < 0)) then
     begin
      FreeAndNil(l_CHP);
      Result := True;
      Break;
     end; // ((l_CHP <> nil) or (l_Seg.CHP.Style < 0)) and not L_S.Empty
    finally
     FreeAndNil(l_CHP);
    end; // l_CHP
   end; // not l_Seg.IsHyperLink
  end; // l_Seg.SegmentType <> dd_segObject
 end; // for j
end;

procedure TddTextParagraph.CorrectSegments(aPrevPara: TddTextParagraph);
var
 i       : Integer;
 j       : Integer;
 l_HL    : TddTextSegment;
 l_Seg   : TddTextSegment;
 l_NewSeg: TddTextSegment;
begin
 if (Text.Len > 0) and (f_Segments.Count > 0) then
 begin
  i := 0;
  while i < SegmentCount do
  begin
   l_Seg := Segments[i];
   if (l_Seg.Start > l_Seg.Stop) then
    f_Segments.Delete(i)
   else
   begin
    if (l_Seg.CHP.Style = ev_saHyperLinkCont) and (aPrevPara <> nil) then
    begin
     for j := 0 to aPrevPara.f_Segments.Hi do
     begin
      l_HL := aPrevPara.f_Segments[j];
      if l_HL.IsHyperlink and InRange(l_Seg.Start, l_HL.Start, l_HL.Stop) then
      begin
       if (l_HL <> nil) and (l_HL.TargetList.Count > 0) then
       begin
        l_NewSeg := TddHyperlink.Create;
        try
         l_NewSeg.Assign(l_Seg);
         l_NewSeg.Style := ev_saTxtNormalANSI;
         l_NewSeg.TargetList.Assign(l_HL.TargetList);
         l_NewSeg.Stop := Min(Pred(Text.Len), l_NewSeg.stop);
         f_Segments.Insert(i, l_NewSeg);
         f_Segments.Delete(i + 1);
        finally
         l3Free(l_NewSeg);
        end;
       end // if (l_HL <> nil) and (l_HL.TargetList.Count > 0) then
       else
       begin
        f_Segments.Delete(i);
        if i < SegmentCount then
         Continue
        else
         Break;
       end;
      end; // l_HL.IsHyperlink and InRange(l_Seg.Start, l_HL.Start, l_HL.Stop)
     end; // for j
    end;
    Inc(i);
   end;
  end; // while i
 end; // (Text.Len > 0) and (f_Segments.Count > 0)
end;

function TddTextParagraph.GetSegmentCount: Integer;
begin
 Result := f_Segments.Count;
end;

function TddTextParagraph.GetSegments(Index: Integer): TddTextSegment;
begin
 if (Index >= 0) and (Index < f_Segments.Count) then
  Result := f_Segments[Index]
 else
  Result := nil;
end;

function TddTextParagraph.GetText: Tl3String;
begin
  Result:= f_Text;
end;

function TddTextParagraph.HaveSegments: Boolean;
begin
 Result := f_Segments.HasSegment;
end;

function TddTextParagraph.HyperlinkByCharIndex(Index: Longint; const
        EndSegment: Boolean = False): TddTextSegment;
var
 i     : Integer;
 l_Seg : TddTextSegment;
begin
 Result := nil;
 if IgnoreLeftIndent then Exit;
 for i := 0 to Pred(f_Segments.Count) do
 begin
  l_Seg := Segments[i];
  if l_Seg.IsHyperlink then
  begin
   if EndSegment then
   begin
    if l_Seg.Stop = Index then
    begin
     Result := l_Seg;
     Break;
    end // if l_Seg.Stop = Index then
   end // if l_Seg.IsHyperLink then
   else
    if (l_Seg.Start = Index) and (l_Seg.Stop >= l_Seg.Start) then
    begin
     Result := l_Seg;
     Break;
    end; // if (Seg.Start = Index) and (Seg.Stop >= Seg.Start) then
  end; // if Seg.IsHyperLink then
 end; // for i
end;

function TddTextParagraph.JoinWith(P: TObject; aCorrectSegment: Boolean = False): Long;
var
 i      : Integer;
 l_Prev : Integer;
 l_Seg  : TddTextSegment;
 l_Para : TddTextParagraph absolute P;
begin
 Result := 0;
 l_Prev := f_Inc;
 if P is TddTextParagraph then
 begin
  if not l_Para.Text.Empty then
   if (Text.Ch[Text.Len - 1] = '-') and (Text.Ch[Text.Len - 2] <> ' ') then
    Text.Delete(Text.Len - 1, 1)
   else
   if not Text.Empty and (Text.Last <> ' ') then
   begin
    Text.Append(' ');
    Inc(f_Inc);
   end;

  if l_Para.f_Segments.Count > 0 then
  begin
   for i := 0 to l_Para.f_Segments.Hi do
   begin
    l_Seg := l_Para.Segments[i];
    l_Seg.Start := l_Seg.Start + Text.Len;
    l_Seg.Stop := l_Seg.Stop + Text.Len;
    if aCorrectSegment then
    begin
     if f_Offset <= l_Seg.Start then
      l_Seg.Start := l_Seg.Start + l_Prev;
     if f_Offset <= l_Seg.Stop then
      l_Seg.Stop := l_Seg.Stop + l_Prev;
    end; // if aCorrectSegment then
    AddSegment(l_Seg);
   end; // for i
  end; // l_Para.f_Segments.Count > 0
  SubList.JoinWith(l_Para.SubList);
  Inc(f_Offset, l_Para.Text.Len);
  AddText(l_Para.Text);
 end; //P is TddTextParagraph
end;

function TddTextParagraph.LastStyledSegment: TddTextSegment;
var
  i: Integer;
begin
  Result:= nil;
  i:= f_Segments.Hi;
  while (i <= f_Segments.Hi) and (i >= 0) do
  begin
   if (Segments[i] is TddStyleSegment) then
   begin
    Result:= Segments[i];
    Exit;
   end // if (Segments[i] is TddStyleSegment) then
   else
    Dec(i);
  end;
end;

procedure TddTextParagraph.PackSegments;
var
 l_Seg: TddTextsegment;

 function lp_CheckEmpty: Boolean;
 begin
  Result := l_Seg.CHP.IsDefault;
  if Result then
   Result := l_Seg.Style = propUndefined;
 end;

 function lp_CheckSingleSegment(aList: TddTextSegmentsList): Boolean;
 var
  l_First: TddTextsegment;
 begin
  Result := aList.Count > 0;
  if not Result then Exit;
  l_First := aList.First;
  Result := (aList.Count = 1) and (l_First.Start = 1) and (l_First.Stop = Text.Len);
  if Result then
   Result := ((CHP.Style = propUndefined) or (CHP.Style = 0) or (CHP.Style = l_First.Style));
 end;

var
 i      : LongInt;
 l_List : TddTextSegmentsList;
 l_Last : TddTextsegment;
begin
  { Упаковка пустых сегментов }
 if f_Segments.Count > 0 then
 begin
  l_List := TddTextSegmentsList.Make;
  try
   for i := 0 to f_Segments.Hi do
   begin
    l_Seg := Segments[i];
    if (l_Seg is TddStyleSegment) and ((l_Seg.CHP.OCompare(CHP) <> 0) or not l_Seg.Empty) then
    begin
     if not lp_CheckEmpty then
      if l_List.Empty then
       l_List.Add(l_Seg)
      else
      begin
       l_Last := TddTextSegment(l_List.Last);
       if (l_Last.CHP.OCompare(l_Seg.CHP) = 0) and (l_Last.Stop = l_Seg.Start) then
        l_Last.Stop := l_Seg.Stop
       else
        l_List.Add(l_Seg);
      end;
    end // if (l_Seg.SegmentType = dd_segText) and ((l_Seg.CHP.OCompare(CHP) <> 0) or not l_Seg.Empty) then
    else
     l_List.Add(l_Seg);
   end;// for i
   ClearSegments;
   if lp_CheckSingleSegment(l_List) then
    CHP.AssignFrom(l_List.First.CHP)
   else
    f_Segments.JoinWith(l_List);
  finally
   FreeAndNil(l_List);
  end; // l_List
 end;
end;

procedure TddTextParagraph.Cleanup;
begin
 FreeAndNil(f_Text);
 FreeAndNil(f_CHP);
 FreeAndNil(f_PAP);
 FreeAndNil(f_Segments);
 FreeAndNil(f_SubList);
 FreeAndNil(f_ItemText);
 f_Inc := 0;
 f_Offset := 0;
 f_BlockIndent := propUndefined;
 f_IgnoreLeftIndent := False;
 f_SkipAlign := False;
 inherited;
end;

procedure TddTextParagraph.Clear;
begin
 f_Text.Clear;
 f_CHP.Clear;
 f_PAP.Clear;
 f_Segments.Clear;
 f_SubList.Clear;
 f_Inc := 0;
 f_Offset := 0;
 f_BlockIndent := propUndefined;
 f_IgnoreLeftIndent := False;
 f_SkipAlign := False;
end;

function TddTextParagraph.ObjectByCharIndex(Index: Longint; const EndSegment: Boolean = False): TddTextSegment;
var
 i    : Integer;
 l_Seg: TddTextSegment;
begin
 Result := nil;
 for i := 0 to f_Segments.Count - 1 do
 begin
  l_Seg := Segments[i];
  if l_Seg.IsObjectSegment then
  begin
   if EndSegment then
   begin
    if l_Seg.Stop = Index then
    begin
     Result := l_Seg;
     Break;
    end // if l_Seg.Stop = Index then
   end // if EndSegment then
   else
   begin
    if (l_Seg.Start = Index) and (l_Seg.Stop >= l_Seg.Start) then
    begin
     Result := l_Seg;
     Break;
    end; // if (l_Seg.Start = Index) and (l_Seg.Stop >= l_Seg.Start) then
   end
  end; // if l_Seg.IsObjectSegment then
 end; // for i
end;

function TddTextParagraph.PrevCHP(aCurSegment: TddTextSegment): TddCharacterProperty;
var
 l_Index: Integer;
begin
 l_Index := f_Segments.IndexOf(aCurSegment);
 if l_Index > 0 then
  Result := Segments[Pred(l_Index)].CHP
 else
  Result := CHP;
end;

function TddTextParagraph.SegmentByCharIndex(Index: Longint; const EndSegment: Boolean = False;
    const StartIndex: Integer = -1): TddTextSegment;
var
 i      : Integer;
 l_Seg  : TddTextSegment;
 l_End  : Integer;
 l_Start: Integer;
begin
 Result := nil;
 l_End := f_Segments.Count - 1;
 l_Start := StartIndex + 1;  
 for i := l_Start to l_End do
 begin
  l_Seg := Segments[i];
  if not l_Seg.IsObjectSegment and not l_Seg.IsHyperlink then
  begin
   if EndSegment then
   begin
    if l_Seg.Stop = Index then
    begin
     Result := l_Seg;
     Break;
    end // if l_Seg.Stop = Index then
   end // if EndSegment then
   else
   begin
    if (IfThen(l_Seg.Start < 0, 0, l_Seg.Start) = Index) and (l_Seg.Stop >= l_Seg.Start) then
    begin
     Result := l_Seg;
     Break;
    end; // if (IfThen(l_Seg.Start < 0, 0, l_Seg.Start) = Index) and (l_Seg.Stop >= l_Seg.Start) then
   end
  end; // if not l_Seg.IsdObjectSegment and not l_Seg.IsHyperlink then
 end; // for i
end;

procedure TddTextParagraph.SetCHP(Value: TddCharacterProperty);
begin
 f_CHP.AssignFrom(Value);
end;

procedure TddTextParagraph.SetPAP(Value: TddParagraphProperty);
begin
  f_PAP.AssignFrom(Value);
end;

procedure TddTextParagraph.SetText(aTExt: Tl3String);
begin
  f_Text.Assign(aText);
end;

procedure TddTextParagraph.Write2Generator(const Generator: Ik2TagGenerator; aNeedProcessRow: Boolean; aLiteVersion: TddLiteVersion);
var
 l_Styled     : Boolean;
 l_NewStyle   : Integer;
 l_IgnoreStyle: Boolean;
begin                                               
 l_NewStyle := 0;
 if f_Destination <> nil then
  f_Destination.BeforeCloseParagraph(Self, l_NewStyle);
 l_Styled := False;
 Process(l_NewStyle);
 Generator.StartChild(k2_typTextPara);
 try
  WriteTabStops(Generator, aLiteVersion); // {Requestlink:571646843} - всякую "фигню" должен фильтр резаать.
  l_IgnoreStyle := (aLiteVersion = dd_lvNone) and (PAP.Style = ev_saTxtHeader1) and (PAP.JUST = justF); // http://mdp.garant.ru/pages/viewpage.action?pageId=608627112
  with PAP do
  begin
   if not l_IgnoreStyle then
   begin
    l_Styled := CheckInTable(Generator, aLiteVersion);
    if l_Styled and (aLiteVersion = dd_lvTextAlign) then
     aLiteVersion := dd_lvStyleOnly;
    l_Styled := WritePAP(Generator, aLiteVersion, l_Styled);
   end; // if not LiteVersion and (PAP.Style < 0) and (PAP.JUST <> justF) then
   if aLiteVersion = dd_lvNone then 
    Border.Write2Generator(Generator);
  end; //  with PAP

  { Выливка оформления }
  if not l_Styled and (aLiteVersion = dd_lvNone) and not CHP.IsDefault then
   CHP.Write2Generator(Generator);
                                                                          
  WriteSubs(Generator, aLiteVersion);

  if CheckSegments then
  begin
   WriteSegments(Generator, aLiteVersion);
  end; // CheckSegments
  Generator.AddStringAtom(k2_tiText, Text.AsWStr);
 finally
  Generator.Finish;
 end;
end;

function TddTextParagraph.WritePAP(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion; aStyled: Boolean): Boolean;
begin
 Result := False;
 with PAP do
 begin
  if not aStyled and (Style < 0) then
  begin
   if Style < -1 then
    Generator.AddIntegerAtom(k2_tiStyle, Style);
   Result:= True;
  end // if not aStyled and (Style < 0) then
  else
  if not PAP.IsDefault then
  begin
   if f_Text.Len > 0 then
   begin
    if (aLiteVersion = dd_lvNone) then
    begin
     if xaLeft <> propUndefined then
      Generator.AddIntegerAtom(k2_tiLeftIndent, xaLeft);
     if (xaFirst <> propUndefined) and (xaLeft <> propUndefined) then
      Generator.AddIntegerAtom(k2_tiFirstIndent, xaFirst + xaLeft);
     if xaFirst <> propUndefined then
      Generator.AddIntegerAtom(k2_tiFirstLineIndent, xaFirst);
     if xaRight <> propUndefined then
      Generator.AddIntegerAtom(k2_tiRightIndent, xaRight);
     if Before <> propUndefined then
      Generator.AddIntegerAtom(k2_tiSpaceBefore, Before);
     if After <> propUndefined then
      Generator.AddIntegerAtom(k2_tiSpaceAfter, After);
    end; // if (aLiteVersion = dd_lvNone) then
    if (aLiteVersion = dd_lvNone) or (aLiteVersion = dd_lvTextAlign) then
     case Just of
      justR: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itRight));
      justC: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itCenter));
      justF: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itWidth));
     else
      Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
    end; { case Just}
   end; // if f_Text.Len > 0 then
  end; // not LiteVersion and not IsDefault;
 end;
end;

procedure TddTextParagraph.WriteSegments(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
type
 TddLayerStatus = (dd_lsNone, dd_lsStartedSegment, dd_lsStartLayer);
var
 l_LayserStatus: TddLayerStatus;

 procedure lp_StartSegments;
 begin
  Generator.StartTag(k2_tiSegments);
  l_LayserStatus := dd_lsStartedSegment;
 end;

 procedure lp_StartLayer(aLayer: TevSegmentHandle);
 begin
  if l_LayserStatus = dd_lsNone then
   lp_StartSegments;
  if l_LayserStatus = dd_lsStartedSegment then
  begin
   Generator.StartChild(k2_typSegmentsLayer);
   Generator.AddIntegerAtom(k2_tiHandle, Ord(aLayer));
   l_LayserStatus := dd_lsStartLayer;
  end; // if l_LayserStatus = dd_lsStartLayer then
 end;

 procedure lp_FinishLayer;
 begin
  if l_LayserStatus = dd_lsStartLayer then
  begin
   Generator.Finish;
   l_LayserStatus := dd_lsStartedSegment;
  end; // if l_LayserStatus = dd_lsStartLayer then
 end;

 procedure lp_FinishSegmentsList;
 begin
  if l_LayserStatus = dd_lsStartedSegment then
  begin
   Generator.Finish;
   l_LayserStatus := dd_lsStartedSegment;
  end; // if l_LayserStatus = dd_lsStartLayer then
 end;

 function lp_EqualLayer(aLayer : TevSegmentHandle; const aSeg: TddTextSegment): Boolean;
 begin
  if (aLayer = ev_slHyperlinks) and aSeg.IsHyperlink then
   Result := True
  else
   if (aLayer = ev_slObjects) and aSeg.IsObjectSegment then
    Result := True
   else
    if (aLayer = ev_slView) and not aSeg.IsObjectSegment and not aSeg.IsHyperlink then
     Result := True
    else
     Result := False;
 end;

 procedure lp_WriteStyleSegment(aLayer : TevSegmentHandle; const aSeg: TddTextSegment);
 var
  l_CHP: TddCharacterProperty;
 begin
  l_CHP := nil;
  if lp_EqualLayer(aLayer, aSeg) then
   if aSeg.Start <= Text.Len then // http://mdp.garant.ru/pages/viewpage.action?pageId=610745778
   begin
    aSeg.Stop := Min(aSeg.Stop, Text.Len);
    if aLayer = ev_slView then
     if aLiteVersion > dd_lvNone then
     begin
      l_CHP := nil;
      if CHP.Hidden then Exit;
     end // if aLiteVersion then
     else
      l_CHP := TddCharacterProperty(CHP.Diff(aSeg.CHP, True));
    if not aSeg.SkipSegment(l_CHP, aLiteVersion) then
    begin
     lp_StartLayer(aLayer);
     try
      aSeg.Write2Generator(Generator, l_CHP, CHP, aLiteVersion)
     finally
      FreeAndNil(l_CHP);
     end; // try
    end; // if ((aSeg.CHP.Style <> 0) and (aSeg.CHP.Style <> propUndefined)) or (l_CHP <> nil) then
   end; // if aSeg.Start < Text.Len then
 end;

 function lp_GetNextWritableLayer(var aLayer : TevSegmentHandle): Boolean;
 begin
  Result := True;
  case aLayer of
   Superposition: aLayer := Hyperlinks; // Чтобы эталоны не отъехали...
   Hyperlinks: aLayer := View;
   View: aLayer := Objects;
   else
   begin
    Result := False;
    aLayer := Mistakes;
   end;
  end; // case aLayer of
 end;

var
 j       : Integer;
 l_Seg   : TddTextSegment;
 l_Layer : TevSegmentHandle;
begin
 l_Layer := Superposition;
 l_LayserStatus := dd_lsNone;
 try
  while lp_GetNextWritableLayer(l_Layer) do
   try
    for j := 0 to f_Segments.Hi do
    begin
     l_Seg := Segments[j];
     lp_WriteStyleSegment(l_Layer, l_Seg);
    end; // for j := 0 to f_Segments.Hi do
   finally
    lp_FinishLayer;
   end;
 finally
  lp_FinishSegmentsList;
 end; // k2_tiSegments
end;

procedure TddTextParagraph.WriteSubs(const aGenerator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
var
 i    : Integer;
 l_Sub: TddSub;
begin
 if SubList.Count > 0 then
 begin
  aGenerator.StartTag(k2_tiSubs);
  try
   aGenerator.StartChild(k2_typSubLayer);
   try
    aGenerator.AddIntegerAtom(k2_tiHandle, Ord(ev_sbtSub));
    for i := 0 to SubList.Hi do
    begin
     l_Sub := SubList.Items[i];
     l_Sub.Write2Generator(aGenerator, aLiteVersion);
    end; { for i }
   finally
    aGenerator.Finish;
   end; { SubLayer }
  finally
   aGenerator.Finish;
  end; { Subs }
 end; // SubList.Count > 0
end;

procedure TddTextParagraph.WriteTabStops(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
var
 i    : Integer;
 l_Tab: TddTab;
begin
 with PAP do
 begin
  if not GetEmpty and (TabList.Count > 0) then
  begin
   Generator.StartTag(k2_tiTabStops);
   try
    for i := 0 to TabList.Count - 1 do
    begin
     l_Tab := Tablist.Items[i];
     l_Tab.Write2Generator(Generator, aLiteVersion);
    end; // for i := 0 to TabList.Count - 1 do
   finally
    Generator.Finish;
   end;
  end; // TabList.Count > 0;
 end; // with PAP do
end;

procedure TddTextParagraph.AddItemText(const aItemText: AnsiString);
begin
 if f_ItemText = nil then
  f_ItemText := Tl3String.Create;
 f_ItemText.AsString := aItemText;
end;

procedure TddTextParagraph.AddOldListItem;
begin
 if f_ItemText = nil then Exit;
 if not Text.Empty then
  Text.Insert(f_ItemText, 0);
 ClearOldListItem;
end;

procedure TddTextParagraph.ClearOldListItem;
begin
 FreeAndNil(f_ItemText);
end;

const
 cnCenterAlign = 2000;
 cnRightAlign = 4000;

procedure TddTextParagraph.CheckPAP;
var
 l_LeftIndent: Integer;
begin
 l_LeftIndent := PAP.xaLeft;
 if (PAP.xaFirst <> propUndefined) and (l_LeftIndent <> propUndefined) then
  Inc(l_LeftIndent, PAP.xaFirst);
 if (l_LeftIndent <> propUndefined) and (l_LeftIndent > cnCenterAlign) then
 begin
  if l_LeftIndent < cnRightAlign then
  begin
   if (PAP.Just <> JustC) then
   // Можно проверять: (PAP.ListItem = propUndefined), но отъедет в задаче (нижняя картинка): http://mdp.garant.ru/pages/viewpage.action?pageId=611189558
    PAP.Just := JustC;
  end // // if l_LeftIndent < cnRightAlign then
  else
   if PAP.Just <> JustR then
    PAP.Just := JustR;
  PAP.xaLeft := propUndefined;
  PAP.xaFirst := propUndefined;
 end; // if (l_LeftIndent <> propUndefined) and (l_LeftIndent > cnRightAlign) then
end;

procedure TddTextParagraph.Process(aNewStyle: Integer);

 procedure lp_CheckNewStyle;
 begin
  if aNewStyle <> 0 then
   if aNewStyle = ev_saToLeft then
   begin
    if PAP.Just = JustL then
     PAP.Style := ev_saToLeft;
   end // if aNewStyle = ev_saToLeft then
   else
    PAP.Style := aNewStyle;
 end;

var
 j: LongInt;
 l_P: TddDocumentAtom;
 l_Style: TddStyleEntry;
 l_Seg: TddTextSegment;
begin
 if (f_Destination <> nil) and (f_Destination is TdestNorm) then
 begin
  CheckListItem;
  // Проверяем сегменты
  PackSegments;
  { Поверяем легальность стилей }
  l_Style := f_Destination.GetStyle(PAP.Style);
  if (l_Style <> nil) and l_Style.IsEvdStyle then
  begin
   if l_Style.EvdStyle <> -1 then
    PAP.Style := l_Style.EvdStyle
  end // if (l_Style <> nil) and l_Style.IsEvdStyle then
  else
  if PAP.Style in [1..4] then
  begin
   // какая-то хрень...
   if (l_Style <> nil) and (Uppercase(l_Style.AsString) <> Format('HEADING %d', [l_Style.Number]))
      and (Uppercase(l_Style.AsString) <> Format('ЗАГОЛОВОК %d', [l_Style.Number])) then
    PAP.Style := PAP.Style + 16;
  end; // if PAP.Style in [1..4] then
  if CHP.Style <> 0 then
  begin
   l_Style := f_Destination.GetStyle(CHP.Style);
   if (l_Style <> nil) and l_Style.IsEvdStyle then
    CHP.Style := l_Style.EvdStyle
   else
    CHP.Style := 0;
  end; // if CHP.Style <> 0 then
  for j := 0 to f_Segments.Hi do
  begin
   l_Seg := Segments[j];
   if l_Seg.CHP.Style <> 0 then
   begin
    l_Style:= f_Destination.GetStyle(l_Seg.CHP.Style);
    if (l_Style <> nil) and l_Style.IsEvdStyle then
     l_Seg.CHP.Style := l_Style.EvdStyle
    else
     if (l_Seg.CHP.EvdStyle <> 0) and (l_Seg.CHP.EvdStyle <> propUndefined) then
      l_Seg.CHP.Style := l_Seg.CHP.EvdStyle
     else
      l_Seg.CHP.Style := 0;
   end; // if l_Seg.CHP.Style <> 0 then
   if f_Destination.LiteVersion then
    if l_Seg.CHP.Pos = cpSuperScript then
     Text.Append('.');
  end; // for j := 0 to f_Segments.Hi do
 end; // if (f_Destination <> nil) and (f_Destination is TdestNorm) then
 if CheckSpaceInText and not SkipAlign then
 begin
  CheckTablList;
  CheckPAP;
 end; // if CheckSpaceInText then
 CheckSymbolFont;
 lp_CheckNewStyle;
end;

procedure TddTextParagraph.CheckListItem;
var
 l_List        : TrtfList;
 l_WasRestarted: Boolean;
begin
 l_List := f_Destination.GetList(PAP.ListItem, l_WasRestarted);
 AddListIndex(l_List, f_Destination.LiteVersion, l_WasRestarted);
end;

function TddTextParagraph.HasSoftEnter: Boolean;
begin
 Result := f_Text.Last = cc_SoftEnter;
end;

function TddTextParagraph.IsTextPara: Boolean;
begin
 Result := True;
end;

function TddTextParagraph.GetLastPara: TddDocumentAtom;
begin
 Result := Self;
end;

procedure TddTextParagraph.AddFormula(aFormula: TddDocumentAtom);
var
 l_Seg: TddTextSegment;
begin
 l_Seg := TddFormulaSegment.Create;
 try
  l_Seg.Data := aFormula;
  Text.Append('*');
  l_Seg.Start := Text.Len;
  l_Seg.Stop := Text.Len;
  AddSegment(l_Seg);
 finally
  FreeAndNil(l_Seg);
 end;
end;

function TddTextParagraph.CheckSpaceInText: Boolean;

 function lp_IsNumberWithSpace: Boolean;
 var
  l_Dots   : Integer;
  l_Digits : Integer;

  function lp_HasDate: Boolean;
  const
   cnDotsInDate = 2;
   cnIgnoreDigit = '0';
   cnDigitsInYear = 4;
  begin
   Result := (l_Dots = cnDotsInDate) and (l_Digits = cnDigitsInYear);
  end;

 const
  csNumberDigit = ['1'..'9'];
 var
  i          : Integer;
  l_Char     : AnsiChar;
  l_SpaceEnd : Boolean;
  l_HasNumber: Boolean;
 begin
  Result := f_Text[0] = cc_HardSpace;
  if Result then
  begin
   l_SpaceEnd := False;
   l_HasNumber := False;
   Result := False;
   l_Digits := 0;
   l_Dots := 0;
   for i := 0 to f_Text.Len - 1 do
   begin
    l_Char := f_Text[i];
    if lp_HasDate then
    begin
     Result := False;
     Break;
    end; // if lp_HasDate then
    if (l_Char <> cc_HardSpace) and not l_SpaceEnd then
     l_SpaceEnd := True
    else
     if l_SpaceEnd and (l_Char = cc_HardSpace) then
      Break;
    if (l_Char in csNumberDigit) then
     l_HasNumber := True;
    if l_HasNumber and (l_Dots > 0) and (l_Char in cc_Digits) then
     Inc(l_Digits);
    if (l_Char = cc_Dot) then
     Inc(l_Dots);
    if (l_Dots > 0) and l_HasNumber and l_SpaceEnd then
     Result := True;
   end; // for i := 0 to f_Text.Len - 1 do
  end; // if Result then
 end;

var
 l_LeftSpace: Integer;
 l_NoSegment: Boolean;

const
 cnCenterAlign = 20;
 cnRightAlingn = 60;

 procedure lp_CheckAlign;

  function lp_CanAlign(aLen: Integer): Boolean;
  const
   cnMinAligndAlign = 1;
   cnMaxOneLineWith = 120;
  begin
   Result := (aLen > cnMinAligndAlign) and (aLen <= cnMaxOneLineWith) and not CHP.MonoTypeFont;
  end;

  procedure lp_CorrectPAP(aPara: TddTextParagraph);
  const
   cnLeftAlignIndent = 4000;
  begin
   aPara.PAP.JUST := JustL;
   aPara.PAP.xaFirst := cnLeftAlignIndent;
   aPara.SkipAlign := True;
  end;

 const
  cnAlignDelta = 3;
 var
  l_Text     : Tl3String;
  l_Align    : Boolean;
  l_NextPara : TObject;
  l_NextSpace: Integer;
 begin
  if f_Destination = nil then Exit; // HTML Reader & etc.
  l_Align := lp_CanAlign(f_Text.Len);
  if not l_Align then
  begin
   CheckSpaceInText := False;
   Exit;
  end; // if not l_Align then
  if l_NoSegment then
  begin
   l_NextPara := f_Destination.NextTextPara(Self);
   while l_NextPara <> nil do
   begin
    l_Text := TddTextParagraph(l_NextPara).Text;
    if (l_LeftSpace > cnRightAlingn) and lp_CanAlign(l_Text.Len) then
    begin
     l_NextSpace := ev_lpIndentPrim(l_Text.St, l_Text.Len);
     if Abs(l_NextSpace - l_LeftSpace) < cnAlignDelta then
     begin
      if l_Align then
      begin
       lp_CorrectPAP(Self);
       l_Align := False;
      end; // if l_Align then
      lp_CorrectPAP(TddTextParagraph(l_NextPara));
      CheckSpaceInText := False;
     end // if l_NextSpace = l_LeftSpace then
     else
      Break;
    end // if (l_LeftSpace > cnCenterAlign) and lp_CanAlign(f_Text.Len) and lp_CanAlign(l_Text.Len) then
    else
     Break;
    l_NextPara := f_Destination.NextTextPara(l_NextPara); 
   end; // while l_NextPara <> nil do
  end; // if l_NoSegment then
  if l_Align and not SkipAlign then
   if (l_LeftSpace >= cnRightAlingn) and (PAP.JUST <> JustR) then
    PAP.JUST := JustR
   else
    if (l_LeftSpace >= cnCenterAlign) and (PAP.JUST <> JustF) and (PAP.JUST <> JustC) then
     PAP.JUST := JustC;
 end;

var
 l_Seg      : TddTextSegment;
 l_NeedTrim : Boolean;
 l_NeedAlign: Boolean;
begin
 Result := True;
 // Здесь будут накапливатсья правила удаления пробелов, которые со временем преобразуются в фильтр.
 // А пока просто исправляться конкретные ошибки:
 // http://mdp.garant.ru/pages/viewpage.action?pageId=596385821
 // http://mdp.garant.ru/pages/viewpage.action?pageId=609131924
 // http://mdp.garant.ru/pages/viewpage.action?pageId=609132323
 // http://mdp.garant.ru/pages/viewpage.action?pageId=611189558
 l_LeftSpace := 0;
 l_NeedAlign := False;
 if (f_Text.CodePage = CP_ANSI) and (CHP.Pos <> cpSuperScript) then // Моноширинный и верхний индекс - не трогаем...
 begin
  l_NeedTrim := f_Segments.Count = 0;
  l_NoSegment := l_NeedTrim;
  if not l_NeedTrim then
  begin
   l_NeedTrim := (f_Segments.Count = 1);
   if l_NeedTrim then // http://mdp.garant.ru/pages/viewpage.action?pageId=596385821
   begin
    l_Seg := f_Segments[0];
    l_NeedTrim := not l_Seg.IsHyperlink and (f_Text[l_Seg.Start] = cc_HardSpace);
    l_NeedAlign := l_Seg.IsObjectSegment; // http://mdp.garant.ru/pages/viewpage.action?pageId=609132323
   end; // if l_NeedTrim then
  end // if not l_NeedTrim then
  else
   l_NeedAlign := l_NoSegment; // http://mdp.garant.ru/pages/viewpage.action?pageId=611189558
  if not l_NeedTrim or l_NeedAlign then
  begin
   l_LeftSpace := ev_lpIndentPrim(f_Text.St, f_Text.Len);
   if l_LeftSpace >= cnCenterAlign then
   begin
    l_NeedTrim := True;
    l_NeedAlign := True;
   end; // if l_LeftSpace >= cnCenterAlign then
  end; // if not l_NeedTrim or l_NeedAlign then
  if l_NeedTrim then
  begin
   if l_NeedAlign and not SkipAlign then
    lp_CheckAlign;
   f_Text.Trim;
   if f_Text.Empty then
    f_Segments.Clear;
  end; // if l_NeedTrim then
  if lp_IsNumberWithSpace then
   f_Text.LTrim;
 end; // if (f_Text.CodePage = CP_ANSI) and (CHP.Pos <> cpSuperScript) then 
end;

procedure TddTextParagraph.ClearSegments;
begin
 f_Segments.Clear;
end;

procedure TddTextParagraph.RemoveSegment(aSegment: TddTextSegment);
begin
 f_Segments.Remove(aSegment);
end;

function TddTextParagraph.HaveHyperlinks: Boolean;
begin
 Result := f_Segments.HasHyperlink;
end;

procedure TddTextParagraph.CheckTablList;
const
 cnLeftTabPos = 2;
var
 l_Indent: Integer;
 l_TabPos: Integer;
begin
 // Здесь будут накапливаться правила преобразования отступов по табуляции, которые тоже используются для выравания:
 // http://mdp.garant.ru/pages/viewpage.action?pageId=622418668
 with PAP do
 begin
  if not GetEmpty and (TabList.Count = 1) and (TabList[0].Kind = tkLeft) then
  begin
   l_TabPos := ev_lpCharIndex(cc_Tab, f_Text.AsWStr);
   l_Indent := TabList[0].TabPos;
   if (l_TabPos > l3NotFound) and (l_TabPos <= cnLeftTabPos) and (l_Indent > cnCenterAlign) then
   begin
    if JUST <> JustC then
     xaLeft := l_Indent;
    TabList.DeleteLast;
   end; // if l_Indent > cnRightAlign then
  end; // if (TabList.Count = 1) and (TabList[0].Kind = 0) then
 end; // with PAP do
end;

procedure TddTextParagraph.CheckSymbolFont;
begin
 if CHP.SymbolFont and (f_Segments.Count = 0) then
 begin
  AddStyleSegment(CHP);
  CHP.Clear;
 end; // if CHP.SymbolFont and (f_Segments.Count = 0) then
end;

procedure TddTextParagraph.AddStyleSegment(aCHP: TddCharacterProperty);
var
 l_Style: TddStyleSegment;
begin
 l_Style := TddStyleSegment.Create;
 try
  l_Style.Start := 1;
  l_Style.Stop := Text.Len;
  l_Style.CHP := aCHP;
  AddSegment(l_Style);
 finally
  FreeAndNil(l_Style);
 end;
end;

procedure TddTextParagraph.AddHyperlinkWithURL(aStart: Integer;
  const aURL: AnsiString);
var
 l_Seg: TddHyperlink;
begin
 l_Seg := TddHyperlink.Create;
 try
  l_Seg.Start := aStart;
  l_Seg.Stop := Text.Len;
  l_Seg.URL.AsString := aURL;
  CHP.ClearProp(ddUnderline);
  CHP.ClearProp(ddFColor);
  CheckPrevSegment(l_Seg);
  AddSegment(l_Seg);
 finally
  FreeAndNil(l_Seg);
 end;
end;

procedure TddTextParagraph.AddSub(aSubID: Integer;
  const aName: Tl3PCharLen);
var
 l_Sub: TddSub;
begin
 l_Sub := TddSub.Create;
 try
  l_Sub.ID := aSubID;
  l_Sub.Name.AsPCharLen := aName;
  l_Sub.IsRealName := True;
  f_SubList.Add(l_Sub);
 finally
  FreeAndNil(l_SuB);
 end;
end;

procedure TddTextParagraph.CheckPrevSegment(aHyperlink: TddHyperlink);
var
 i    : Integer;
 l_Seg: TddTextSegment;
begin
 for i := f_Segments.Hi downto 0 do
 begin
  l_Seg := f_Segments[i];
  if l_Seg.IsHyperlink or l_Seg.IsObjectSegment then Continue;
  if (l_Seg.Start = aHyperlink.Start) and (l_Seg.Stop = aHyperlink.Stop) then
   f_Segments.Delete(i);
 end; // for i := f_Segments.Hi downto 0 do
end;

procedure TddTextParagraph.CheckUpperOrLower;
begin
 if f_CHP.Caps = ccAllCaps then
  Text.MakeUpper
 else
  if f_CHP.Caps = ccSmallCaps then
   Text.MakeLower;
end;

procedure TddTextParagraph.AddSegmenFromListIndex(
  aCHP: TddCharacterProperty; aTextLen: Integer);
var
 i    : Integer;
 l_Seg: TddTextSegment;
begin
 l_Seg := TddStyleSegment.Create;
 try
  l_Seg.CHP.AssignFrom(aCHP);
  l_Seg.Start := 1;
  l_Seg.Stop := aTextLen;
  f_Segments.Insert(0, l_Seg);
  for i := 1 to f_Segments.Hi do
  begin
   Segments[i].Start := Segments[i].Start + l_Seg.Stop;
   Segments[i].Stop := Segments[i].Stop + l_Seg.Stop;
  end; // for i
 finally
  FreeAndNil(l_Seg);
 end;
end;

function TddTextParagraph.AddListItemText(aText: AnsiString): Integer;
begin  
 Result := Length(aText);
 if (aText <> '') then
 begin
  if (aText[Result] in cc_WhiteSpaceExt) and (Text.Len > 0)  then
   Text.LTrim;
  Text.Insert(l3PCharLen(aText), 0);
 end; // if aText <> '' then
end;

end.
