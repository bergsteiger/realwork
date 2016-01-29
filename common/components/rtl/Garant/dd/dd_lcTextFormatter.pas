unit dd_lcTextFormatter;
{ Форматирование текста постановлений судов }

{ $Id: dd_lcTextFormatter.pas,v 1.45 2014/04/29 14:06:17 lulin Exp $ }

// $Log: dd_lcTextFormatter.pas,v $
// Revision 1.45  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.44  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.43  2014/04/03 17:10:43  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.42  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.41  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.40  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.39  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.38  2011/10/28 13:13:35  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.37  2011/10/28 07:46:25  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.36  2011/10/26 12:25:14  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.35  2011/10/26 09:56:45  narry
// Неверно обрабалывались сложные типы после преобразование в простые
//
// Revision 1.34  2011/10/25 05:31:16  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.33  2011/10/21 13:11:59  narry
// Накопившиеся изменения
//
// Revision 1.32  2011/10/17 10:08:47  narry
// Формирование списка документов для расстановки (293276752)
//
// Revision 1.31  2011/10/14 09:54:13  narry
// При расстановке меток в процессе заливки ФАСов портится текст (293277407)
//
// Revision 1.30  2011/09/19 13:00:17  narry
// При заливке испортилась таблица (285509624)
//
// Revision 1.29  2011/09/16 11:07:41  narry
// Форматирование текста - подписи судей (284886047)
//
// Revision 1.28  2011/09/14 12:31:11  narry
// Форматирование текста - дополнение (283613953)
//

interface

uses
 l3Variant,
 evdBufferedFilter,
 k2Interfaces, Classes,
 l3Types, k2Types, ddTypes, DT_Types, dd_lcBaseFilter,
 k2TagGen, l3base, dd_lcUtils,

 k2Base
 ;

type
 Tdd_lcTextFormatter = class(Tdd_lcParaFilter)
 private
  f_Date: Integer;
  f_DefinitionTitle: AnsiString;
  f_DNType: Integer;
  f_Do: Tdd_lcLookForSet;
  f_DocID: TDocID;
  f_DocName: Tl3String;
  f_Field: TDocID;
  f_FormatStyle: Tdd_lcFormatStyle;
  f_InTable: Boolean;
  f_LawCaseNumber: AnsiString;
  f_LostParaCount: Integer;
  f_Number: AnsiString;
  f_Numbers: TStrings;
  f_OnBodyEnded: TNotifyEvent;
  f_OnHeaderFound: TNotifyEvent;
  f_Parameters: Array[Tdd_lcLookFor] of AnsiString;
  f_PrevPara: Il3TagRef;
  f_Source: AnsiString;
  f_StartCounting: Boolean;
  f_Type: AnsiString;
  procedure AddDateNumber;
  procedure AddDefinition;
  procedure AddSBSTable(const aLeft, aRight: AnsiString; aIsSign: Boolean);
  procedure AddEmptyPara;
  procedure AddJudges;
  procedure AddPostanovlenie;
  procedure AddResolution;
  procedure AddTitle;
  function CheckAddJudge(aPara: Tl3Variant): Boolean;
  function CheckDocStart(aPara: Tl3Variant): Boolean;
  function CheckAddMainJudge(aPara: Tl3Variant): Boolean;
  function CheckNumber(aPara: Tl3Variant): Boolean;
  function CheckConditions(aLeaf: Tl3Variant): Boolean;
  function CheckDate(aPara: Tl3Variant): Boolean;
  function CheckMainJudge(aPara: Tl3Variant): Boolean;
  function CheckJudge(aPara: Tl3Variant): Boolean;
  function CheckResolution(aPara: Tl3Variant): Boolean;
  procedure ClearParameters;
  function CheckEmptyPara(aPara: Tl3Variant): Boolean;
  function CheckCourtName(aPara: Tl3Variant): Boolean;
  procedure CheckLostParameters;
  function CheckAddNumber(aPara: Tl3Variant): Boolean;
  function CheckPostanovlenie(aPara: Tl3Variant): Boolean;
  function CheckOrder(aPara: Tl3Variant): Boolean;
  function CheckDefinition(aPara: Tl3Variant): Boolean;
  function CheckDefinitionTitle(aPara: Tl3Variant): Boolean;
  procedure CheckPrezidium(aPara: Tl3Variant);
  function CheckStartText(aPara: Tl3Variant): Boolean;
  function CheckUstanovil(aPara: Tl3Variant): Boolean;
  function CheckTitle(aPara: Tl3Variant): Boolean;
  procedure CheckTitleCondition;
  procedure CorrectNumber(aPara: Tl3Variant);
  procedure CorrectTextAndStyle(aLeaf: Tl3Variant);
  function DeJudgeStr(const aStr: AnsiString): AnsiString;
  function deSignedStr(aStr: AnsiString): AnsiString;
  function FindPostanovlenie(aText: AnsiString; aWithResolution: Boolean): Boolean;
  function isCourtName(aPara: Tl3Variant): Boolean;
  function IsPrezidium: Boolean;
  function LastNamePresent(aText: AnsiString): Boolean;
    function NormalizeText(aLeaf: Tl3Variant): AnsiString;
 protected
  procedure Cleanup; override;
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure DoWritePara(aLeaf: Tl3Variant); override;
  procedure DoStartChild(TypeID: Tk2Type); override;
  procedure OpenStream; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure CloseStructure(NeedUndo: Boolean); override;
  property OnBodyEnded: TNotifyEvent read f_OnBodyEnded write f_OnBodyEnded;
  property OnHeaderFound: TNotifyEvent read f_OnHeaderFound write f_OnHeaderFound;
 end;

implementation

uses
 k2Tags,
 StrUtils, SysUtils, Windows,
 rxStrUtils,
 ddUtils,
 evdStyles, evdTypes,
 l3LingLib, l3DateSt, l3Chars,
 TextPara_Const, Document_Const, DictItem_Const, NumAndDate_Const, Block_Const, TableCell_Const, Table_Const,
 SBS_Const, SBSRow_Const, SBSCell_Const, l3String, Math,
 dd_lcCodeCorrector, dd_lcSourceUtils;

constructor Tdd_lcTextFormatter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_Numbers := TStringList.Create;
 f_DocName := Tl3String.Create();
end;

procedure Tdd_lcTextFormatter.Cleanup;
begin
 FreeAndNil(f_DocName);
 FreeAndNil(f_Numbers);
 inherited;
end;

procedure Tdd_lcTextFormatter.AddDateNumber;
begin
 Exclude(f_Do, lc_lfNumber);
 Exclude(f_Do, lc_lfDate);
 if (f_FormatStyle in [lc_fsResolution, lc_fsDecision]) and not IsPrezidium then
 begin
  if (f_Parameters[lc_lfDate] <> '') or (f_Parameters[lc_LfNumber] <> '') then
   AddSBSTable(f_Parameters[lc_lfDate], f_Parameters[lc_LfNumber], False);
  AddEmptyPara;
  if (lc_lfResolution in f_Do) and (f_Parameters[lc_lfResolution] <> '') and (f_Parameters[lc_lfPostanovlenie] <> '') then
   AddResolution;
 end; // (f_FormatStyle = lc_fsResolution) 
end;

procedure Tdd_lcTextFormatter.AddDefinition;
var
 l_text: AnsiString;
 l_Text2: AnsiString;
 l_Number: AnsiString;
 l_Date: Integer;
 i: Integer;
begin
 l_Text2:= Trim(f_definitionTitle);
 UpperCaseFirstLetter(l_text2);
 l_Date:= 0; l_Number:= ''; i:= 0;
 while (l_Number = '') and (i < f_Numbers.Count) do
 begin
  if AnsiStartsText('ВАС-', f_Numbers.ValueFromIndex[i]) and IsTwoDigitsNumber(f_Numbers.ValueFromIndex[i]) then
  begin
   l_Date:= StrToIntDef(f_Numbers.Names[i], 0);
   l_Number:= f_Numbers.ValueFromIndex[i];
  end
  else
   Inc(i);
 end; // (l_Number = '') and (i < f_Numbers.Count)
 l_text:= Format('%s Высшего Арбитражного Суда РФ от %s г. № %s'#10'"%s"',
                 [f_Type, l3DateToStr(l_Date, 'd mmmm yyyy'), l_Number, l_Text2]);
 Generator.AddStringAtom(k2_tiName, l_Text);
 Generator.StartChild(k2_typTextPara);
 try
  Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
  Generator.AddStringAtom(k2_tiText, l_Text);
 finally
  Generator.Finish;
 end;
 AddEmptyPara;
end;

procedure Tdd_lcTextFormatter.AddSBSTable(const aLeft, aRight: AnsiString; aIsSign: Boolean);
begin
 if (aLeft <> '') or (aRight <> '') then
 begin
  Generator.StartChild(k2_typSBS);
  try
   Generator.StartChild(k2_typSBSRow);
   try
    Generator.StartChild(k2_typSBSCell);
    try
     if not aIsSign then
     begin
      Generator.AddIntegerAtom(k2_tiWidth, 1);
      Generator.AddIntegerAtom(k2_tiVerticalAligment, ord(ev_valTop));
     end
     else
      Generator.AddIntegerAtom(k2_tiWidth, 2);
     Generator.StartChild(k2_typTextPara);
     try
      Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSLeft);
      Generator.AddStringAtom(k2_tiText, aLeft);
     finally
      Generator.Finish;
     end;
    finally
     Generator.Finish;
    end;
    Generator.StartChild(k2_typSBSCell);
    try
     if not aIsSign then
     begin
      Generator.AddIntegerAtom(k2_tiWidth, 2);
      Generator.AddIntegerAtom(k2_tiVerticalAligment, ord(ev_valTop));
     end
     else
      Generator.AddIntegerAtom(k2_tiWidth, 1);
     Generator.StartChild(k2_typTextPara);
     try
      Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSRight);
      Generator.AddStringAtom(k2_tiText, aRight);
     finally
      Generator.Finish;
     end;
    finally
     Generator.Finish;
    end;
   finally
    Generator.Finish;
   end;
  finally
   Generator.Finish;
  end;
  //AddEmptyPara;
 end;
end;

procedure Tdd_lcTextFormatter.AddEmptyPara;
begin
 Generator.StartChild(k2_typTextPara);
 Generator.Finish;
end;

procedure Tdd_lcTextFormatter.AddJudges;
begin
 if (f_FormatStyle in [lc_fsDefinition, lc_fsDecision]) and (f_Parameters[lc_lfMainJudge] = '') then
  AddEmptyPara;
 AddSBSTable(AnsiReplaceStr(f_Parameters[lc_lfJudge], '_', ''),
             AnsiReplaceStr(f_Parameters[lc_lfAddJudge], '_', ''), True);
 AddEmptyPara;
 Exclude(f_Do, lc_lfJudge);
 Exclude(f_Do, lc_lfAddJudge);
end;

procedure Tdd_lcTextFormatter.AddPostanovlenie;
var
 l_S: AnsiString;
begin
 UpperCaseFirstLetter(f_Parameters[lc_lfPostanovlenie]);
 Generator.StartChild(k2_typTextPara);
 try
  Generator.AddStringAtom(k2_tiText, f_Parameters[lc_lfPostanovlenie]);
 finally
  Generator.Finish;
 end;
 AddEmptyPara;
end;

procedure Tdd_lcTextFormatter.AddResolution;
var
 l_S: AnsiString;
begin
 if (lc_lfDate in f_Do) or (lc_lfNumber in f_Do) then
  AddDateNumber;
  //exit;
 Exclude(f_Do, lc_lfResolution);
 if f_Parameters[lc_lfResolution] <> '' then
 begin
  while f_Parameters[lc_lfResolution][length(f_Parameters[lc_lfResolution])] in [',', '.', ' '] do
   Delete(f_Parameters[lc_lfResolution], length(f_Parameters[lc_lfResolution]), 1);
  Exclude(f_Do, lc_lfPostanovlenie);
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddStringAtom(k2_tiText, f_Parameters[lc_lfResolution]+'.');
  finally
   Generator.Finish;
  end;
 end; // if f_Parameters[lc_lfResolution] <> ''
 if f_Parameters[lc_lfPostanovlenie] <> '' then
  AddPostanovlenie
end;

procedure Tdd_lcTextFormatter.AddTitle;
var
 l_Text: AnsiString;
 l_Court, l_CourtR: AnsiString;
 l_Date: Integer;
 l_Number: AnsiString;
begin
 if f_DocName.Empty then
 begin
  l_Court:= deBracketStr(f_Source);
  l_CourtR:= mlmaRusDeclensionStr(l_Court, rdRodit);
  l_Date:= 0;
  l_Number:= '';
  if f_Numbers.Count > 0 then
  begin
   l_Date:= StrToIntDef(f_Numbers.Names[0], 0);               
   l_Number:= f_Numbers.ValueFromIndex[0];
  end;

  // Есть вероятность, что тут могут оказаться неправильные номера...
  if Source2DossierType(f_Source) = lc_dtFirst then
   l_Text:= Format('%s %s от %s г.',
                  [f_Type, l_CourtR, l3DateToStr(l_Date, 'd mmmm yyyy')])
  else
   l_Text:= Format('%s %s от %s г. № %s',
                  [f_Type, l_CourtR, l3DateToStr(l_Date, 'd mmmm yyyy'), l_Number]);
  if Source2DossierType(f_Source) in [lc_dtFAC, lc_dtFirst] then
   l_Text:= l_Text + ' по делу № ' + f_LawCaseNumber;
  if f_FormatStyle = lc_fsDefinition then
  begin
   UpperCaseFirstLetter(f_Parameters[lc_lfTitle]);
   l_Text:= l_Text + #10'"' + f_Parameters[lc_lfTitle] + '"';
  end;

  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
   Generator.AddStringAtom(k2_tiText, l_Text);
  finally
   Generator.Finish;
  end;
 end
 else
 begin
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
   Generator.AddStringAtom(k2_tiText, f_DocName.AsWStr);
  finally
   Generator.Finish;
  end;
 end;
 AddEmptyPara;
 Exclude(f_Do, lc_lfTitle);
 (*
 if Assigned(f_OnHeaderFound) then
  f_OnHeaderFound(Self);
 *)
 f_StartCounting:= True;
end;

function Tdd_lcTextFormatter.CheckAddJudge(aPara: Tl3Variant): Boolean;
var
 l_S: AnsiString;
 l_Pos, i: Integer;
begin
 Result:= True;
 if not (lc_lfMainJudge in f_Do) then
 begin
  l_S:= aPara.StrA[k2_tiText];
  if LastNamePresent(l_S) then
  begin
   l_S:= DeJudgeStr(l_S);
   if not AnsiContainsText(f_Parameters[lc_lfAddJudge], DeSignedStr(l_S)) then
   begin
    if f_Parameters[lc_lfAddJudge] <> '' then
    begin
     f_Parameters[lc_lfJudge]:= 'Судьи';
     f_Parameters[lc_lfAddJudge]:= f_Parameters[lc_lfAddJudge] + #10;
    end;
    f_Parameters[lc_lfAddJudge]:= f_Parameters[lc_lfAddJudge] + DeSignedStr(l_S);
   end; 
   Result:= False;
  end
  else
  if AnsiStartsText('судь', l_S) then
   Result:= False
  else 
  begin
   AddJudges;
   Result:= False;
  end;
 end;
end;

function Tdd_lcTextFormatter.CheckDocStart(aPara: Tl3Variant): Boolean;
begin
 Result:= False;
 if AnsiEndsText(c_TypeNames[f_FormatStyle], NormalizeText(aPara)) then
  f_Do:= c_FirstSteps[f_FormatStyle];
end;

function Tdd_lcTextFormatter.CheckAddMainJudge(aPara: Tl3Variant): Boolean;
var
 l_S: AnsiString;
begin
 Result:= True;
 if not (lc_lfMainJudge in f_Do) and (lc_lfAddMainJudge in f_Do) then
 begin
  l_S:= aPara.StrA[k2_tiText];
  if {not AnsiStartsText('судь', l_S)}(f_Parameters[lc_lfAddMainJudge] = '') and LastNamePresent(l_S) then
  begin
   f_Parameters[lc_lfAddMainJudge]:= f_Parameters[lc_lfAddMainJudge] + DeJudgeStr(designedStr(l_S));
   Exclude(f_Do, lc_lfAddMainJudge);
   AddEmptyPara;
   AddSBSTable(AnsiReplaceStr(f_Parameters[lc_lfMainJudge], '_', ''),
               AnsiReplaceStr(f_Parameters[lc_lfAddMainJudge], '_', ''), True);
   AddEmptyPara;
   Result:= False;
  end;
 end;
end;

function Tdd_lcTextFormatter.CheckNumber(aPara: Tl3Variant): Boolean;
var
 l_S: AnsiString;
begin
 Result := True;
 l_S:= aPara.StrA[k2_tiText];
 if not isCourtName(aPara) and (InRange(Pos('№', l_S), 1, 15) or AnsiContainsText(l_S, f_Number)) then
 begin
  Result:= False;
  if (l_S[1] = '(') and (l_S[Length(l_S)] = ')') then
   l_S:= Copy(l_S, 2, Length(l_S)-2);
  if f_Parameters[lc_lfNumber] <> '' then
   f_Parameters[lc_lfNumber]:= f_Parameters[lc_lfNumber] + #10;
  f_Parameters[lc_lfNumber]:= f_Parameters[lc_lfNumber] + l_S;
  if Pos('№', l_S) > (Length(l_S) - 4) then
   Include(f_Do, lc_lfAddNumber);
 end;
end;

function Tdd_lcTextFormatter.CheckConditions(aLeaf: Tl3Variant): Boolean;
var
 l_AddEmptyPara: Boolean;
 l_LF: Tdd_lcLookFor;
begin
 CorrectNumber(aLeaf);
 CheckTitleCondition;
 CheckPrezidium(aLeaf);
 Result:= True;
 for l_LF:= low(Tdd_lcLookFor) to High(Tdd_lcLookFor) do
 begin
  l_AddEmptyPara:= False;
  if Result and (l_LF in f_Do) then
  begin
   case l_LF of
    lc_lfStart        : Result:= CheckDocStart(aLeaf);
    lc_lfTitle        : Result:= CheckTitle(aLeaf);
    lc_lfDate         : Result:= CheckDate(aLeaf);
    lc_lfNumber       : Result:= CheckNumber(aLeaf);
    lc_lfAddNumber    : Result:= CheckAddNumber(aLeaf);
    lc_lfResolution   : Result:= CheckResolution(aLeaf);
    lc_lfPostanovlenie: Result:= CheckPostanovlenie(aLeaf);
    lc_lfCourtName    : Result:= CheckCourtName(aLeaf);
    lc_lfMainJudge    : Result:= CheckMainJudge(aLeaf);
    lc_lfAddMainJudge : Result:= CheckAddMainJudge(aLeaf);
    lc_lfAddJudge     : Result:= CheckAddJudge(aLeaf);
    lc_lfJudge        : Result:= CheckJudge(aLeaf);
    lc_lfOrder        : Result:= CheckOrder(aLeaf);
    lc_lfUstanovil    : Result:= CheckUstanovil(aLeaf);
    lc_lfDefinition   : Result:= CheckDefinition(aLeaf);
    lc_lfDefinitionTitle: Result:= CheckDefinitionTitle(aLeaf);
    lc_lfStartText    : Result:= CheckStartText(aLeaf);
   else
    Result:= True;
   end; // case l_F
   if not (l_LF in f_Do) or ((l_LF in [lc_lfNumber, lc_lfAddJudge]) and not Result) then
    break;
  end;
 end;
end;

function Tdd_lcTextFormatter.CheckDate(aPara: Tl3Variant): Boolean;
var
 l_S, l_Year: AnsiString;
 l_Pos, i, l_NumberCount: Integer;
begin
 Result:= True;
 l_S:= aPara.StrA[k2_tiText];
 // Ищем вхождение г. или года. А еще бывают даты, которые не заканчиваются на г. :(
 if not AnsiContainsText(l_S, 'постанов') then
  if {not AnsiStartsStr('г.', l_S)} AnsiStartsDate(l_S, l_Year) then
  begin
   if lc_lfTitle in f_Do then
     AddTitle;
   l_Pos:= Pos(l_Year, l_S);
   f_Parameters[lc_lfDate]:= Copy(l_S, 1, Pred(l_Pos)) + ' г.';
   Exclude(f_Do, lc_lfDate);
   Result:= False;
   l_Pos:= PosEx(' ', l_S, l_Pos+ Length(l_Year));
   if (l_Pos > 0) then
   begin
    l_S:= Copy(l_S, Succ(l_Pos), Succ(Length(l_S)-l_Pos));
    if l_S <> '' then
    begin
     if (l_S[1] = '(') and (l_S[Length(l_S)] = ')') then
      l_S:= Copy(l_S, 2, Length(l_S)-2);
     f_Parameters[lc_lfNumber]:= l_S;
     AddDateNumber;
    end;
   end// l_Pos > 0
  end; // not AnsiStartsStr('г.', l_S)
end;

function Tdd_lcTextFormatter.CheckEmptyPara(aPara: Tl3Variant): Boolean;
begin
 // Можно удалить пустой только, если он не в таблице
 //Result:= True;
 if f_InTable then // для таблиц пропускам все
  Result:= True
 else
  Result:= aPara.Attr[k2_tiText].IsValid and (aPara.StrA[k2_tiText] <> '');
end;

function Tdd_lcTextFormatter.CheckMainJudge(aPara: Tl3Variant): Boolean;
var
 i, l_Pos: Integer;
 l_S: AnsiString;
begin
 Result := True;
  l_S:= aPara.StrA[k2_tiText];
  if AnsiStartsText(c_MainJudge, l_S) then
   // Дальше два варианта - фамилия в этом же абзаце или в следующем
   begin
    Result:= False;
    l_Pos:= Length(l_S);
    for i:= Succ(Length(c_MainJudge)) to Length(l_S) do
     if l_S[i] in cc_UpRussian then
     begin
      l_Pos:= Pred(i);
      break;
     end;
    f_Parameters[lc_lfMainJudge]:= DesignedStr(Copy(l_S, 1, l_Pos));
    Exclude(f_Do, lc_lfMainJudge);
    if l_Pos <> Length(l_S) then
    begin
     f_Parameters[lc_lfAddMainJudge]:= DesignedStr(Copy(l_S, Succ(l_Pos), Length(l_S)));
     Exclude(f_Do, lc_lfAddMainJudge);
     AddEmptyPara;
     AddSBSTable(f_Parameters[lc_lfMainJudge], f_Parameters[lc_lfAddMainJudge], True);
     AddEmptyPara;
    end
   end;
end;

function Tdd_lcTextFormatter.CheckJudge(aPara: Tl3Variant): Boolean;
var
 i, l_Pos: Integer;
 l_S: AnsiString;
begin
 Result := True;
 if not (lc_lfMainJudge in f_Do) or (f_FormatStyle in [lc_fsDefinition, lc_fsDecision]) then
 begin
  l_S:= aPara.StrA[k2_tiText];
  if AnsiStartsText('судь', l_S) then
   // Дальше два варианта - фамилия в этом же абзаце или в следующем
   begin
    Result:= False;
    Exclude(f_Do, lc_lfJudge);
    if f_Parameters[lc_lfMainJudge] = '' {not (lc_lfMainJudge in f_Do)} then
    begin
     Exclude(f_Do, lc_lfMainJudge);
     Exclude(f_Do, lc_lfAddMainJudge);
    end; 
    l_Pos:= Length(l_S);
    for i:= Succ(Length('судь')) to Length(l_S) do
     if l_S[i] in cc_UpRussian then
     begin
      l_Pos:= Pred(i);
      break;
     end;
    f_Parameters[lc_lfJudge]:= 'Судья';
    if l_Pos <> Length(l_S) then
     f_Parameters[lc_lfAddJudge]:= DesignedStr(Copy(l_S, Succ(l_Pos), Length(l_S)));
   end;
 end;
end;

function Tdd_lcTextFormatter.CheckResolution(aPara: Tl3Variant): Boolean;
var
 l_S: AnsiString;
 l_Pos: Integer;
begin
 Result:= True;
 
 begin
  l_S:= aPara.StrA[k2_tiText];
  if AnsiContainsText(l_S, 'Резолютивн') then
  begin
   // Нужно проверить не состоит ли этот абзац из двух - про резолюцию и полный текст
   Result:= False;
   //Exclude(f_Do, lc_lfResolution);
   //if not FindPostanovlenie(l_S, True) then
    f_Parameters[lc_lfResolution]:= l_S;
   if not (lc_lfTitle in f_Do) then
    AddResolution; 
  end;
 end;
end;

function Tdd_lcTextFormatter.CheckCourtName(aPara: Tl3Variant): Boolean;
begin
 Result:= True;
 if not (lc_lfTitle in f_Do) then
 begin
  if isCourtName(aPara) or AnsiContainsText(aPara.StrA[k2_tiText], 'жный суд в составе') then
  begin
   Exclude(f_Do, lc_lfCourtName);
   if (lc_lfDate in f_Do) or (lc_lfNumber in f_Do) then
    AddDateNumber;
   //else
   // AddEmptyPara;
   if lc_lfResolution in f_do then
    AddResolution;
   if f_Parameters[lc_lfPostanovlenie] = '' then
    AddEmptyPara;
  end;
 end;
end;

procedure Tdd_lcTextFormatter.CheckLostParameters;
var
 l_LF: Tdd_lcLookFor;
 l_Msg: AnsiString;
begin
 if f_Do <> [] then
 begin
  l_Msg:= '';
  for l_LF:= Low(Tdd_lcLookFor) to High(Tdd_lcLookFor) do
   if l_LF in f_Do then
   begin
    case l_LF of
     lc_lfNone: l_Msg:= 'Ничто';
     lc_lfStart: l_Msg:= 'Начало постановления (ПОСТАНОВЛЕНИЕ)';
     lc_lfTitle : l_Msg:= 'Заголовок';
     lc_lfDate : l_Msg:= 'Дата';
     lc_lfNumber : l_Msg:= 'Номер дела';
     lc_lfResolution : l_Msg:= 'Дата резолютивной части';
     lc_lfPostanovlenie : l_Msg:= 'Дата полного объема';
     lc_lfCourtName : l_Msg:= 'Название суда';
     lc_lfUstanovil: l_msg:= 'Установил';
     lc_lfMainJudge : l_Msg:= 'Председательствующий судья';
     lc_lfAddMainJudge : l_Msg:= 'Фамилия председательствующего судьи';
     lc_lfJudge : l_Msg:= 'Судьи';
     lc_lfAddJudge : l_Msg:= 'Фамилии судей';
     lc_lfOrder: l_Msg:= 'Постановил';
     lc_lfDefinition: l_Msg:= 'Начало определения';
     lc_lfDefinitionTitle: l_Msg:= 'Заголовок определения';
     lc_lfStartText: l_Msg:= 'Начало текста. Текст документа утрачен.';
    end; //case
    ErrorReaction('%d: Не найдена информация для "%s"', [f_DocID, l_Msg]);
   end; // l_LF in f_Do;
  ErrorReaction('%d: Удалено %d абзацев с текстом', [f_DocID,f_LostParaCount]); 
 end; // f_Do <> []
end;

function Tdd_lcTextFormatter.CheckAddNumber(aPara: Tl3Variant): Boolean;
var
 l_S: AnsiString;
begin
 Result := False;
 l_S:= aPara.StrA[k2_tiText];
 if f_Parameters[lc_lfNumber] <> '' then
  f_Parameters[lc_lfNumber]:= f_Parameters[lc_lfNumber] + ' ' + l_S;
 Exclude(f_Do, lc_lfAddNumber);
end;

function Tdd_lcTextFormatter.CheckPostanovlenie(aPara: Tl3Variant): Boolean;
begin
 Result:= not FindPostanovlenie(aPara.StrA[k2_tiText], False);
 //if not Result and not (lc_lfTitle in f_Do) then
 // AddPostanovlenie;
end;

function Tdd_lcTextFormatter.CheckOrder(aPara: Tl3Variant): Boolean;
var
 l_Text: ShortString;
 l_Pos: Integer;
begin
 Result:= True;
 l_Text:= NormalizeText(aPara);
 if l_Text <> '' then
 begin

  l_Pos:= LastDelimiter(':', l_Text);
  if l_Pos = 0 then
   l_text:= l_Text + ':';

  if AnsiSameText(c_OrderNames[f_FormatStyle], l_Text) then
  begin
   Exclude(f_Do, lc_lfOrder);
   CheckLostParameters;
   f_Do:= c_SecondSteps[f_FormatStyle];
   if Assigned(f_OnBodyEnded) then
    f_OnBodyEnded(Self);
  end; // AnsiEndsText(c_OrderNames[f_FormatStyle], l_Text)
 end; // l_text <> ''
end;

function Tdd_lcTextFormatter.CheckDefinition(aPara: Tl3Variant): Boolean;
var
 l_NormText: AnsiString;
begin
 Result:= False;
 l_NormText:= NormalizeText(aPara);
 if AnsiStartsText(f_Type, l_NormText) then
 begin
  if Length(l_NormText) > Length(f_Type) then
  begin
   f_DefinitionTitle:= Copy(aPara.StrA[k2_tiText], Length(f_type)+1, MaxInt);
   AddDefinition;
   f_Do:= [lc_lfStartText];
  end
  else
   f_Do:= [lc_lfDefinitionTitle];
 end;
end;

function Tdd_lcTextFormatter.CheckDefinitionTitle(aPara: Tl3Variant): Boolean;
begin
 Result:= False;
 if AnsiStartsText('№', apara.StrA[k2_tiText]) then
 begin
  f_Do:= [lc_lfStartText];
  AddDefinition;
 end
 else
 begin
  if f_DefinitionTitle <> '' then
   f_DefinitionTitle:= f_DefinitionTitle + ' ';
  f_DefinitionTitle:= f_DefinitionTitle + aPara.StrA[k2_tiText];
 end;
end;

procedure Tdd_lcTextFormatter.CheckPrezidium(aPara: Tl3Variant);
var
 l_Cat: Integer;
begin
 if AnsiStartsText('Президиум Высшего Арбитражного Суда Российской Федерации', aPara.StrA[k2_tiText]) then
 begin
  l_Cat:= Category;
  Category:= 10;
  try
   ErrorReaction('Президиум');
  finally
   Category:= l_Cat;
  end;
 end;
end;

function Tdd_lcTextFormatter.CheckStartText(aPara: Tl3Variant): Boolean;
var
 i: Integer;
begin
 Result:= False;
 for i:= 0 to c_DefinitionMax do
  if AnsiStartsText(c_DefinitionStarts[i], aPara.StrA[k2_tiText]) then
  begin
   Result:= True;
   break;
  end;
 if Result then
  f_Do:= c_SecondSteps[f_FormatStyle];
end;

function Tdd_lcTextFormatter.CheckUstanovil(aPara: Tl3Variant): Boolean;
var
 l_Ok: Boolean;
 l_Text : AnsiString;
 l_pos: Integer;
begin
 Result:= True;
 l_Text:= NormalizeText(aPara);
 if l_Text <> '' then
 begin
  l_Pos:= LastDelimiter(':', l_Text);
  if l_Pos <> 0 then
   delete(l_text, l_Pos, 1);

  if f_FormatStyle = lc_fsDefinition then
   l_ok:= AnsiEndsText('определил', l_Text)
  else
   l_Ok:= AnsiEndsText('установил', l_Text);
  if l_ok then
  begin
   Exclude(f_Do, lc_lfUstanovil);
   if Assigned(f_OnheaderFound) then
    f_OnHeaderFound(Self);
  end; // AnsiCompareText(aPara.StrA[k2_tiText], 'постановил') = 0
 end;
end;

function Tdd_lcTextFormatter.CheckTitle(aPara: Tl3Variant): Boolean;
var
 i, l_Pos: Integer;
 l_S: AnsiString;

 procedure lp_AddTitle(const aCity: AnsiString; IsName: Boolean);
 begin
   AddTitle;
   // В строке с городом может быть номер дела... в Этом случае заменяем строку на таблицу
   l_Pos:= Succ(Length(aCity));
   if not IsName then
   begin
    while l_S[l_Pos] in [' ', '.'] do Inc(l_Pos);
    l_Pos:= PosEx(' ', l_S, l_Pos);
   end; // IsName
   if l_Pos > 0 then
   begin
    Result:= False;
    if not IsPrezidium then
     AddSBSTable(Copy(l_S, 1, l_Pos), Copy(l_S, Succ(l_Pos), Length(l_S)), False);
    // Напильник
    if not (lc_lfResolution in f_Do) then
    begin
     AddDateNumber;
     Exclude(f_Do, lc_lfCourtName); //!!!!!!!!!!!!!!
    end;
   end
   else
    Result:= True
 end;

begin
 Result:= True;
 l_S:= TrimLeft(aPara.StrA[k2_tiText]);
 for i:= 0 to 2 do
  if AnsiStartsText(c_Title[i], l_S) then
  begin
   Result:= False;
   if f_FormatStyle = lc_fsResolution then
    lp_AddTitle(c_Title[i], False)
   else
    AddTitle;
   break
  end;
 if Result and (lc_lfTitle in f_Do) then // не встретили "город"
 begin
  for i:= 0 to Length(c_CityNames)-1 do
   if AnsiStartsText(c_CityNames[i], l_S) then
   begin
    if f_FormatStyle = lc_fsResolution then
     lp_AddTitle(c_CityNames[i], True)
    else
    begin
     AddTitle;
     Result:= False;
    end;
    break;
   end;
 end;
 if (f_FormatStyle = lc_fsDefinition) and (lc_lfTitle in f_Do) then
 begin
  if CheckNumber(aPara) then
   f_Parameters[lc_lfTitle]:= f_Parameters[lc_lfTitle] + ' ' + l_S;
  Result:= False;
 end;
end;

procedure Tdd_lcTextFormatter.CheckTitleCondition;
begin
 (*
 if lc_lfTitle in f_Do then
 begin
  if (f_Parameters[lc_lfResolution] <> '') and ((f_Parameters[lc_lfDate] <> '') or (f_Parameters[lc_lfNumber] <> '')) then
  begin
   AddTitle;
   AddResolution;
   AddDateNumber;
  end;
 end;
 *)
end;

procedure Tdd_lcTextFormatter.ClearParameters;
begin
 f_DNType:= -1;
 f_Date:= 0;
 f_Number:= '';     
 f_LawCaseNumber:= '';
 f_Source:= '';
 f_Type:= '';
 f_Do:= [lc_lfStart];
 l3FillChar(f_Parameters, SizeOf(f_Parameters), 0);
 f_PrevPara:= nil;
 f_DefinitionTitle:= '';
 f_FormatStyle:= lc_fsResolution;
 f_Numbers.Clear;
 f_DocName.Clear;
 f_InTable:= False;
 f_LostParaCount:= 0;
 f_StartCounting:= False;
end;

procedure Tdd_lcTextFormatter.CloseStructure(NeedUndo: Boolean);
var
 l_LF: Tdd_lcLookFor;
 l_Msg: AnsiString;
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  if (lc_lfAddJudge in f_Do) then
   AddJudges;
  CheckLostParameters;
 end
 else
 if CurrentType.IsKindOf(k2_typNumAndDate) then
 begin
  if f_DNType = ord(dnLawCaseNum) then
   f_LawCaseNumber:= f_Number
  else
   if f_DNType <> ord(dnPublish) then
   begin
    f_Date:= 0;
    f_Number:= '';
    f_DNType:= -1;
   end
   else
   if IsTwoDigitsNumber(f_Number) then
    f_Numbers.Add(IntToStr(f_Date)+'='+f_Number);
 end
 else
 if CurrentType.IsKindOf(k2_typTable) then
   f_InTable:= False;
 inherited;
end;

procedure Tdd_lcTextFormatter.CorrectNumber(aPara: Tl3Variant);
var
 l_Pos: Integer;
 l_Str: AnsiString;
 l_Update: Boolean;
begin
 l_Str:= aPara.StrA[k2_tiText];
 l_Pos:= Pos('№', l_Str);
 l_Update:= False;
 while l_Pos > 0 do
 begin
  if (Succ(l_Pos) <= Length(l_Str)) and not (l_Str[Succ(l_pos)] in [cc_HardSpace, cc_SoftSpace]) then
  begin
   Insert(cc_SoftSpace, l_Str, Succ(l_pos));
   l_Update:= True;
   l_Pos:= PosEx('№', l_Str, Succ(l_pos));
  end // (Succ(l_Pos) <= Length(l_Str)) and not (l_Str[Succ(l_pos)] in [cc_Space, cc_SoftSpace])
  else
   break
 end; // while l_Pos
 if l_Update then
  aPara.StrA[k2_tiText]:= l_Str;
end;

procedure Tdd_lcTextFormatter.CorrectTextAndStyle(aLeaf: Tl3Variant);
var
 l_Str: AnsiString;
begin
 if not aLeaf.Attr[k2_tiStyle].IsNull and aLeaf.Attr[k2_tiStyle].IsValid
    and (aLeaf.IntA[k2_tiStyle] <> ev_saNormalTable) then
  aLeaf.IntA[k2_tiStyle]:= ev_saTxtNormalANSI;
 // нужно найти и заменить неправильные сочетания пробел-запятая
 l_Str:= aLeaf.StrA[k2_tiText];
 l_Str:= AnsiReplaceStr(l_Str, ' ,', ',');
 l_Str:= AnsiReplaceStr(l_Str, ' .', '.');
end;

function Tdd_lcTextFormatter.DeJudgeStr(const aStr: AnsiString): AnsiString;
var
 l_Pos: Integer;
 i: Integer;
begin
 Result:= aStr;
 if AnsiStartsText('судь', aStr) then
  begin
   l_Pos:= Length(aStr);
   for i:= Succ(Length('судь')) to Length(aStr) do
    if aStr[i] in cc_UpRussian then
    begin
     l_Pos:= Pred(i);
     break;
    end;
   Result:= DesignedStr(Copy(aStr, Succ(l_Pos), Length(aStr)));
  end;
end;

function Tdd_lcTextFormatter.deSignedStr(aStr: AnsiString): AnsiString;
 procedure lp_Delete(const aText: AnsiString);
 begin
  if AnsiContainsText(Result, aText) then
   Delete(Result, AnsiPos(aText, Result), length(aText));
 end;
begin
 Result := aStr;
 lp_delete('подпись');
 lp_delete('()');
end;

procedure Tdd_lcTextFormatter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_Pos: Integer;
 i: Tdd_lcFormatStyle;
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  case AtomIndex of
   k2_tiExternalHandle: f_DocID:= Value.AsInteger;
   k2_tiName: f_DocName.Assign(Value.AsString);
  end
 else
 if CurrentType.IsKindOf(k2_typDictItem) and (TopObject[1].isProp) then
  case TopObject[1].AsProp.TagIndex of
   k2_tiSources:
    begin
     f_Source:= Value.AsString.AsString;
     l_Pos:= LastDelimiter('\', f_Source);
     f_Source:= IfThen(l_Pos > 0, Copy(f_Source, Succ(l_pos), Length(f_Source)-l_Pos), f_Source);
     //if ANSISameText(f_Source, 'ВАС РФ') then
     // f_Source:= 'Высший Арбитражный Суд РФ';
     if AnsiSameText('Президиум ВАС РФ', f_Source) then
      f_Source:= 'Президиум Высшего Арбитражного Суда';
     if AnsiContainsText(f_Source, 'Высший Арбитражный Суд') then
      f_Do:= [lc_lfDefinition];
    end;
   k2_tiTypes:
    begin
     f_Type:= Value.AsString.AsString;
     for i:= Low(Tdd_lcFormatStyle) to High(Tdd_lcFormatStyle) do
     if AnsiSameText(f_Type, c_TypeNames[i]) then
      f_FormatStyle:= i
    end;
  end
 else
 if CurrentType.IsKindOf(k2_typNumAnddate) then
     case AtomIndex of
      k2_tiType: f_DNType:= Value.AsInteger;
      k2_tiStart: f_Date:= Value.AsInteger;
      k2_tiNumber:
       begin
        if lc_lfDefinition in f_Do then
         // В случае ВАСов нужно искать номер с ВАС-
        begin
         if AnsiStartsText('ВАС-', Value.AsString.AsString) and
           (Length(Value.AsString.AsString)- Pos('/', Value.AsString.AsString) = 2) then
          f_Number:= Value.AsString.AsString;
        end
        else
         f_Number:= Value.AsString.AsString;
       end;
     end;
 inherited;
end;

procedure Tdd_lcTextFormatter.DoWritePara(aLeaf: Tl3Variant);
var
 l_SavePara: Boolean;
begin
 if CheckEmptyPara(aLeaf) then
 begin
  l_SavePara:= CheckConditions(aLeaf);
  If lc_lfTitle{lc_lfResolution} in f_Do then
   l_SavePara:= False;
  if l_SavePara then
  begin
   CorrectTextAndStyle(aLeaf);
   inherited;
  end
  else
  if f_StartCounting then
  begin
   Inc(f_LostParaCount);
   ErrorReaction('Удален текст "%s"', [aLeaf.StrA[k2_tiText]]);
  end;
 end; // CheckEmptyPara
end;

procedure Tdd_lcTextFormatter.DoStartChild(TypeID: Tk2Type);
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  ClearParameters
 else
 if CurrentType.IsKindOf(k2_typDictItem) and (TopObject[1].isProp) then
  case TopObject[1].AsProp.TagIndex of
   k2_tiSources: f_Source:= '';
   k2_tiTypes: f_Type:= '';
  end
 else
 if CurrentType.IsKindOf(k2_typTable) then
   f_InTable:= True;
 (*
 else
 if CurrentType.IsKindOf(k2_typNumAndDate) then
  begin
    if f_DNType <> ord(dnPublish) then
    begin
     f_Date:= 0;
     f_Number:= '';
     f_DNType:= -1;
    end
  end
  *)
end;

function Tdd_lcTextFormatter.FindPostanovlenie(aText: AnsiString; aWithResolution: Boolean): Boolean;
 function lp_CheckPhrase(const aPhrase: AnsiString): Boolean;
 var
  l_Pos: Integer;
 begin
  Result:= False;
  if AnsiContainsText(aText, aPhrase) then
  begin
   Result:= True;
   l_Pos:= AnsiPos(aPhrase, aText);
   if l_Pos > 0 then
   begin
    if aWithResolution then
    begin
     f_Parameters[lc_lfResolution]:= Copy(aText, 1, Pred(l_Pos));
     f_Parameters[lc_lfPostanovlenie]:= Copy(aText, l_Pos, Length(aText));
    end
    else
     f_Parameters[lc_lfPostanovlenie]:= aText;
   end // l_Pos > 0
  end; // AnsiContainsText(aText, aPhrase
 end; // lp_CheckPhrase

begin
 Result:= lp_CheckPhrase('Полный текст');
 if not Result then
 begin
  Result:= lp_CheckPhrase('Мотивированн');
  if not Result then
   Result:= lp_CheckPhrase('в полном объеме');
   if not Result then
    Result:= lp_CheckPhrase('в окончательной форме');
 end; // not Result
 if Result then
  Exclude(f_Do, lc_lfPostanovlenie);
end;

function Tdd_lcTextFormatter.isCourtName(aPara: Tl3Variant): Boolean;
var
 l_S: AnsiString;
begin
 l_S:= AnsiReplaceText(aPara.StrA[k2_tiText], 'ё', 'е');
 Result := AnsiStartsText(DeBracketStr(f_Source), l_S);
end;

function Tdd_lcTextFormatter.IsPrezidium: Boolean;
begin
 Result := AnsiSameText(f_Source, 'Президиум Высшего Арбитражного Суда');
end;

function Tdd_lcTextFormatter.LastNamePresent(aText: AnsiString): Boolean;
var
 i: Integer;
begin
 // признаком фамилии считается точка после заглавной буквы
 Result := False;
 for i:= 1 to Length(aText) do
  if (aText[i] in cc_UpRussian) and (i <> Length(aText)) and (aText[Succ(i)] = '.') then
  begin
   Result:= True;
   break;
  end;
end;

procedure Tdd_lcTextFormatter.OpenStream;
begin
 inherited;
 ClearParameters;
end;

function Tdd_lcTextFormatter.NormalizeText(aLeaf: Tl3Variant): AnsiString;
var
 i: Integer;
begin
 Result := l3DeleteDoubleSpace(Trim(aLeaf.Attr[k2_tiText].AsString));
 if Length(Result) > 2 then
  if Result[2] = ' ' then
  begin
   Result:= AnsiReplaceStr(Result, ' ', '');
   (*
   i:= 2;
   while i < Length(Result) do
   begin
    if Result[i] = ' ' then
     Delete(Result, i, 1);
    Inc(i);
   end;
   *)
  end;
end;

end.
