unit dd_lcJudgeFormatter;
{ Форматирование подписей судей }

{ $Id: dd_lcJudgeFormatter.pas,v 1.34 2014/04/08 17:13:30 lulin Exp $ }

// $Log: dd_lcJudgeFormatter.pas,v $
// Revision 1.34  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.33  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.32  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.31  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.30  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.29  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.28  2012/06/26 06:08:54  narry
// Подписи - варианты написания (372639779)
//
// Revision 1.27  2012/05/12 12:35:58  narry
// Латинская буква вместо русской
//
// Revision 1.26  2012/04/25 07:19:25  narry
// Подписи судей через дефис (356066387)
//
// Revision 1.25  2012/04/25 05:34:00  narry
// Подписи судей со словом подпись (361038129)
//
// Revision 1.24  2012/04/24 10:24:55  narry
// Подписи судей - попадает мусор (358982412)
//
// Revision 1.23  2012/04/23 11:42:04  narry
// Заменились лишние III
//
// Revision 1.22  2012/04/23 08:53:44  narry
// Подписи в зависимости от написания слова решил (358978207)
//
// Revision 1.21  2012/04/20 12:58:00  narry
// Ошибочно нашелся судья для подписи (360024950)
//
// Revision 1.20  2012/03/28 14:42:23  narry
// Подписи судей еще варианты (353438287)
//
// Revision 1.19  2012/03/27 07:28:13  narry
// Не форматировался СУДЬЯ
//
// Revision 1.18  2012/03/15 12:56:02  narry
// Подписи арбитражных заседателей в решениях первой инстанции (346751940)
//
// Revision 1.17  2012/02/24 04:29:09  narry
// Не форматируется подпись, если Решил не выделено в абзац (341835953)
//
// Revision 1.16  2011/11/23 13:55:58  narry
// В таблицу с датой-номером попадает левая информация (300028178)
//
// Revision 1.15  2011/11/17 12:54:59  narry
// В таблице дата-номер город попал не в ту ячейку (299140417)
//
// Revision 1.14  2011/11/17 11:08:25  narry
// Шаблоны для форматирования подписей  (300024308)
//
// Revision 1.13  2011/11/17 10:54:06  narry
// Добавлять в лог информацию о несоответствии типа содержанию (298683500)
//
// Revision 1.12  2011/11/14 11:50:50  narry
// Пропадает текст из определений ВАС (297710781)
//
// Revision 1.11  2011/11/08 13:20:45  narry
// Подписи судей и их форматирование (297369814)
//
// Revision 1.10  2011/11/08 13:08:21  narry
// Судьи в одну строку (296630258)
//
// Revision 1.9  2011/11/07 11:37:30  narry
// Не проверять город в тексте (296630444)
//
// Revision 1.8  2011/11/02 12:05:30  narry
// Уточнение информации об удаленных абзацах (296625489)
//
// Revision 1.7  2011/11/01 07:49:45  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.6  2011/10/31 13:22:19  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.5  2011/10/31 09:13:59  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.4  2011/10/28 07:54:14  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.3  2011/10/26 12:25:14  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.2  2011/10/26 09:57:37  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.1  2011/10/25 07:02:05  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//

interface

uses
  dd_lcTextFormatter2, k2Interfaces, Classes, k2tagGen, l3RegEx;

type
 Tdd_lcJudgeFormatter = class(Tdd_lcBaseFormatter)
 private
  f_FoundAddJudge: Boolean;
  f_FoundAddMainJudge: Boolean;
  f_FoundJudge: Boolean;
  f_FoundMainJudge: Boolean;
  f_FoundOrder: Boolean;
  f_BodyNotifyList: TList;
  f_JudgesAdded: Boolean;
  procedure AddJudges;
  procedure AddMainJudge;
  function CheckAddJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
  function CheckAddMainJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
  function CheckJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
  function CheckMainJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
  function CheckOrder(aPara: Tl3Variant): Tdd_lcTextReaction;
 protected
  procedure CheckLostParameters; override;
  procedure Cleanup; override;
  procedure ClearParameters; override;
  procedure DoTextEnded;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
  function FindLastName(aPara: Tl3Variant; out theTitle, theLastName: ShortString; out theNotSure:
      Boolean): Boolean;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AddBodyFinishNotifier(aNotifier: Tdd_lcBaseFormatter);
  procedure CloseStructure(NeedUndo: Boolean); override;
 end;

implementation

uses
  dd_lcUtils, k2tags, StrUtils, l3Chars, SysUtils, Document_Const,
  l3StringListPrim, l3PrimString, l3String, ddUtils, dd_lcBaseFilter;

const
 cLastNamePattern = '(([А-Я]\w+\-?)+)';
 cNamePattern = '('+cLastNamePattern+'\s?([А-Я]\.\s?[А-Я]\.))|(([А-Я]\.\s?[А-Я]\.?)\s?'+cLastNamePattern+')';
 cTitSep      = '((\s\-\s)|\s|\-)';
 cTitlePattern = '((^[Пп]редседатель\w*('+cTitSep+'судья)?)|(^[CcСс]\s?[Уу]\s?[Дд]\s?[Ьь]\s?\w(\s*[Рр]еспублики\s[А-Я]\w+)?))|(^[Рр]еспублики\s[А-Я]\w+)|(^[Аа]рбитражны[ей] заседател[иь])';

 cSignaturePatternR = '(({'+cTitlePattern+'}(\s+\(?подпись\)?)?[\s\/\\\:_\-]+)?{'+cNamePattern+'})';
 cTitlePatternR = '{' + cTitlePattern + '}';

constructor Tdd_lcJudgeFormatter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_BodyNotifyList := TList.Create();
end;

procedure Tdd_lcJudgeFormatter.AddBodyFinishNotifier(aNotifier:
    Tdd_lcBaseFormatter);
begin
 if f_BodyNotifyList.IndexOf(aNotifier) = -1 then
  f_BodyNotifyList.Add(aNotifier);
end;

procedure Tdd_lcJudgeFormatter.AddJudges;
var
 l_Judge: AnsiString;
begin
 if not f_JudgesAdded then
 begin
  f_JudgesAdded:= True;
  if (f_FormatStyle in [lc_fsDefinition, lc_fsDecision]) and (f_Parameters[lc_lfMainJudge] = '') then
   AddEmptyPara;
  l_Judge:= AnsiLowerCase(AnsiReplaceStr(f_Parameters[lc_lfJudge], '_', ''));
  if (Length(l_Judge) > 1) and (l_Judge[2] = ' ') then
   l_Judge:= AnsiReplaceStr(l_Judge, ' ', '');
  UpperCaseFirstLetter(l_Judge);
  AddSBSTable(l_Judge, AnsiReplaceStr(f_Parameters[lc_lfAddJudge], '_', ''), True);
  AddEmptyPara;
 end; // not f_JudgesAdded
end;

procedure Tdd_lcJudgeFormatter.AddMainJudge;
begin
 AddEmptyPara;
 AddSBSTable(AnsiReplaceStr(f_Parameters[lc_lfMainJudge], '_', ''),
             AnsiReplaceStr(f_Parameters[lc_lfAddMainJudge], '_', ''), True);
 AddEmptyPara;
end;

function Tdd_lcJudgeFormatter.CheckAddJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 l_Title, l_LastName: ShortString;
 l_NotSure: Boolean;
begin
 Result:= lcWrite;
 if f_FoundMainJudge then
 begin
  if FindLastName(aPara, l_Title, l_LastName, l_NotSure) then
  begin
   if (l_LastName <> '') and not AnsiContainsText(f_Parameters[lc_lfAddJudge], l_LastName) then
   begin
    if l_NotSure then
     ErrorReaction('Возможно ошибочное определение подписи "%s" из "%s"', [l_LastName, aPara.StrA[k2_tiText]]);
    if f_Parameters[lc_lfAddJudge] <> '' then
    begin
     // нужно получить множественное число
     if AnsiStartsText('судь', f_Parameters[lc_lfJudge]) then
      f_Parameters[lc_lfJudge]:= 'Судьи';
     f_Parameters[lc_lfAddJudge]:= f_Parameters[lc_lfAddJudge] + #10;
    end;
    f_Parameters[lc_lfAddJudge]:= f_Parameters[lc_lfAddJudge] + l_LastName;
   end;
   Result:= lcSkip;
  end
  else
  //if AnsiStartsText('судь', aPara.StrA[k2_titext]) then
   Result:= lcSkip
  (*else
  begin
   AddJudges;
   Result:= lcSkip;
  end;*)
 end;
end;

function Tdd_lcJudgeFormatter.CheckAddMainJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 l_LastName, l_Title: ShortString;
 l_NotSure: Boolean;
begin
 Result:= lcWrite;
 if f_FoundMainJudge and not f_FoundAddMainJudge then
 begin
  if FindLastName(aPara, l_Title, l_LastName, l_NotSure) then
  begin
   if (l_Title = '') or AnsiStartsText('судь', l_Title) then
   begin
    if (l_LastName <> '') then
    begin
     if l_NotSure then
      ErrorReaction('Возможно ошибочное определение подписи "%s" из "%s"', [l_LastName, aPara.StrA[k2_tiText]]);
     f_Parameters[lc_lfAddMainJudge]:= f_Parameters[lc_lfAddMainJudge] + l_LastName;
     f_FoundAddMainJudge:= True;
     AddMainJudge;
    end
    else
    begin
     f_Parameters[lc_lfJudge]:= l_Title;
     f_FoundJudge:= True;
    end;
    Result:= lcSkip;
   end;
  end;
 end;
end;

function Tdd_lcJudgeFormatter.CheckJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 l_LastName, l_Title: ShortString;
 l_NotSure: Boolean;
begin
 Result := lcWrite;
 if f_FoundMainJudge or (f_FormatStyle in [lc_fsDefinition, lc_fsDecision]) then
 begin
  if FindLastName(aPara, l_Title, l_LastName, l_NotSure) then
  begin
   if l_Title <> '' then
   begin
    Result:= lcSkip;
    f_FoundJudge:= True;
    if not f_FoundMainJudge then
    begin
     f_FoundMainJudge:= True;
     f_FoundAddMainJudge:= True;
    end; // not f_FoundMainJudge
    f_Parameters[lc_lfJudge]:= l_Title;//'Судья';
    if l_LastName <> '' then
    begin
     if l_NotSure then
      ErrorReaction('Возможно ошибочное определение подписи "%s" из "%s"', [l_LastName, aPara.StrA[k2_tiText]]);
     f_Parameters[lc_lfAddJudge]:= l_LastName;
    end;
   end;
  end; // FindLastName(aPara, l_Title, l_LastName)
 end; // f_FoundMainJudge or (f_FormatStyle in [lc_fsDefinition, lc_fsDecision])
end;

procedure Tdd_lcJudgeFormatter.CheckLostParameters;
begin
 if not f_JudgesAdded then
 begin
  inherited;
  if not f_FoundMainJudge then
   ReportMissing('Председательствующий судья')
  else
  if f_Parameters[lc_lfMainJudge] <> '' then
   ErrorReaction('Председательствующий "%s" не добавлен', [f_Parameters[lc_lfMainJudge]]);
  if not f_FoundJudge then
   ReportMissing('Судьи')
  else
  if f_Parameters[lc_lfJudge] <> '' then
   ErrorReaction('Судья(и) %s не добавлен', [f_Parameters[lc_lfJudge]]);
  if not f_FoundOrder then
   ReportMissing(Format('Начало подписей (%s)', [c_OrderNames[f_FormatStyle]]));
 end;
end;

function Tdd_lcJudgeFormatter.CheckMainJudge(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 l_Pos: Integer;
 l_LastName, l_Title: ShortString;
 l_NotSure: Boolean;
begin
 Result := lcWrite;
 //if not (f_FormatStyle in [lc_fsDefinition, lc_fsDecision]) then
  if FindLastName(aPara, l_Title, l_LastName, l_NotSure) then
  begin
   if AnsiStartsText(c_MainJudge, l_Title) then
   begin
    Result:= lcSkip;
    f_Parameters[lc_lfMainJudge]:= l_Title;
    f_FoundMainJudge:= True;
    if l_LastName <> '' then
     begin
      if l_NotSure then
       ErrorReaction('Возможно ошибочное определение подписи "%s" из "%s"', [l_LastName, aPara.StrA[k2_tiText]]);
      f_Parameters[lc_lfAddMainJudge]:= l_LastName;
      f_FoundAddMainJudge:= True;
      AddMainJudge;
      l_Pos:= Pos(l_LastName, aPara.StrA[k2_tiText]);
      aPara.StrW[k2_tiText, nil]:= Copy(aPara.StrA[k2_tiText], Succ(l_Pos+Length(l_LastName)), MaxInt);
      CheckJudge(aPara);
     end
   end;
  end
end;

function Tdd_lcJudgeFormatter.CheckOrder(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 l_Text, l_AltOrder: ShortString;
 l_Pos: Integer;
 i: Tdd_lcFormatStyle;
begin
 Result:= lcWrite;
 l_Text:= NormalizeText(aPara);
 // Нельзя заменять где попало
 if AnsiStartsText('реiiiил', l_Text)  then
 begin
  if AnsiContainsStr(aPara.StrA[k2_tiText], 'iii') then
   aPara.StrW[k2_tiText, nil]:= AnsiReplaceStr(aPara.StrA[k2_tiText], 'iii', 'ш')
  else
  if AnsiContainsStr(aPara.StrA[k2_tiText], 'III') then
   aPara.StrW[k2_tiText, nil]:= AnsiReplaceStr(aPara.StrA[k2_tiText], 'III', 'Ш');
  l_Text:= NormalizeText(aPara);
 end; // AnsiStartsText('реiiiил', l_Text)
 if l_Text <> '' then
 begin
  l_Pos:= LastDelimiter(':', l_Text);
  if l_Pos = 0 then
   l_text:= l_Text + ':';
  l_AltOrder:= c_OrderNames[f_FormatStyle];
  Insert('а', l_AltOrder, Pos(':', l_AltOrder));
  //if AnsiSameText(c_OrderNames[f_FormatStyle], l_Text) or AnsiSameText(l_AltOrder, l_Text) then
  if AnsiEndsText(c_OrderNames[f_FormatStyle], l_Text) or AnsiEndsText(l_AltOrder, l_Text) then
  begin
   f_FoundOrder:= true;
   DoTextEnded;
  end
  else
  for i:= Low(Tdd_lcFormatStyle) to High(Tdd_lcFormatStyle) do
  begin
   l_AltOrder:= c_OrderNames[i];
   Insert('а', l_AltOrder, Pos(':', l_AltOrder));
   if AnsiSameText(c_OrderNames[i], l_Text) or AnsiSameText(l_AltOrder, l_Text) then
   begin
    ErrorReaction('Вместо "%s" найдено "%s"', [c_OrderNames[f_FormatStyle], c_OrderNames[i]]);
    f_FoundOrder:= true;
    DoTextEnded;
    break;
   end
  end;
 end; // l_text <> ''
end;

procedure Tdd_lcJudgeFormatter.Cleanup;
begin
 inherited Cleanup;
 FreeAndnil(f_BodyNotifyList);
end;

procedure Tdd_lcJudgeFormatter.ClearParameters;
begin
 inherited;
 f_FoundMainJudge:= False;
 f_FoundAddMainJudge:= False;
 f_FoundJudge:= False;
 f_FoundAddJudge:= False;
 f_FoundOrder:= False;
 f_JudgesAdded:= False;
end;

procedure Tdd_lcJudgeFormatter.CloseStructure(NeedUndo: Boolean);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  if f_FoundJudge then
   AddJudges;
 end;// CurrentType.IsKindOf(k2_typDocument)
 inherited;
end;

procedure Tdd_lcJudgeFormatter.DoTextEnded;
var
 i: Integer;
begin
 for i:= 0 to pred(f_BodyNotifyList.Count) do
  if Assigned(f_BodyNotifyList[i]) then
   Tdd_lcBaseFormatter(f_BodyNotifyList[i]).BodyFinish;
end;

function Tdd_lcJudgeFormatter.EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction;
begin
 if f_JudgesAdded then
  Result:= lcDelete
 else
  Result:= lcWrite;
 if not f_JudgesAdded then
 begin
  if not f_FoundOrder then
   Result:= CheckOrder(aPara)
  else
  begin
   if not f_FoundMainJudge then
    Result:= CheckMainJudge(aPara);
   if (Result = lcWrite) and not f_FoundAddMainJudge then
    Result:= CheckAddMainJudge(aPara);
   if (Result = lcWrite) and not f_FoundJudge then
    Result:= CheckJudge(aPara);
   if (Result = lcwrite) and not f_FoundAddJudge then
    Result:= CheckAddJudge(aPara);
  end;
 end;
end;

function Tdd_lcJudgeFormatter.FindLastName(aPara: Tl3Variant; out theTitle, theLastName: ShortString;
    out theNotSure: Boolean): Boolean;
var
 l_Pos: Tl3MatchPosition;
begin
 theTitle:= '';
 theLastName:= '';
 theNotSure:= False;
 RegSearcher.IgnoreCase:= False;
 RegSearcher.SearchPattern:= cSignaturePatternR;
 Result:= RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos);
 if Result then
 begin
  if RegSearcher.TagParts.Count = 2 then
  begin
   theTitle:= RegSearcher.TagParts.Items[0].AsString;
   theLastName:= RegSearcher.TagParts.Items[1].AsString;
  end
  else
  begin
   theLastName:= RegSearcher.TagParts.Items[0].AsString;
   theNotSure:=  l_pos.StartPos > 5;
  end
 end
 else
 begin
  RegSearcher.SearchPattern:= cTitlePatternR;
  Result:= RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos);
  if Result then
   theTitle:= RegSearcher.TagParts.Items[0].AsString;
 end;
 if Result then
 begin
  theTitle:= AnsiReplaceStr(theTitle, '-', ' ');
  theTitle:= l3DeleteDoubleSpace(theTitle);
 end; // Result
end;

end.
