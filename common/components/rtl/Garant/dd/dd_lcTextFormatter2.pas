unit dd_lcTextFormatter2;
{ Форматирование текста постановлений судов }

{ $Id: dd_lcTextFormatter2.pas,v 1.41 2014/04/29 14:06:17 lulin Exp $ }

// $Log: dd_lcTextFormatter2.pas,v $
// Revision 1.41  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.40  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.39  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.38  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.37  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.36  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.35  2013/07/29 06:24:46  dinishev
// Убрал ссылку на rxStrUtils
//
// Revision 1.34  2013/05/08 10:45:25  fireton
// - из-за табуляции не определялись реквизиты
//
// Revision 1.33  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.32  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.31  2013/04/03 09:34:33  narry
// Не проходили тесты
//
// Revision 1.30  2013/03/29 12:58:02  narry
// Помоломались тесты
//
// Revision 1.29  2012/09/04 10:11:34  narry
// Заголовок и нейм в определениях ВАС (390570489)
//
// Revision 1.28  2012/05/11 13:04:33  narry
// Не форматируются документы Югры (363566409)
//
// Revision 1.27  2012/04/24 13:10:09  narry
// Терялся номер дела
//
// Revision 1.26  2012/04/24 10:24:55  narry
// Подписи судей - попадает мусор (358982412)
//
// Revision 1.25  2012/03/14 08:52:08  narry
// Удаляется первая строка из текста (344142732)
//
// Revision 1.24  2012/03/12 07:49:08  narry
// АС г Москвы номер дела (344132791)
//
// Revision 1.23  2012/03/11 11:31:32  narry
// Липецкий арбитражный суд - изготовлено в полном объеме (344133631)
//
// Revision 1.22  2012/03/11 07:22:11  narry
// Липецкий суд номер дела плохо распознается (344132618)
//
// Revision 1.21  2012/03/05 10:48:39  narry
// Убрать из лога информирование об удалении абзаца только с пробелами (342865902)
//
// Revision 1.20  2012/03/02 10:42:11  narry
// Пропала дата оглашения резолютивной части (342860872)
//
// Revision 1.19  2012/03/02 10:15:42  narry
// Решения заливаются без текста (342860997)
//
// Revision 1.18  2011/12/07 07:35:28  narry
// Нестандартный вид номера в таблице дата-номер (309168209)
//
// Revision 1.17  2011/12/07 07:12:41  narry
// Нестандартный вид номера в таблице дата-номер (309168209)
//
// Revision 1.16  2011/11/24 08:02:50  narry
// Ошибка в таблице дата-номер (303858401)
//
// Revision 1.15  2011/11/23 13:55:58  narry
// В таблицу с датой-номером попадает левая информация (300028178)
//
// Revision 1.14  2011/11/23 09:35:36  narry
// Неправильно формируется таблица дата-номер для ФАС МО (302744524)
//
// Revision 1.13  2011/11/21 12:50:59  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.12  2011/11/18 12:47:54  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.11  2011/11/17 12:54:59  narry
// В таблице дата-номер город попал не в ту ячейку (299140417)
//
// Revision 1.10  2011/11/17 09:57:23  narry
// Таблица дата-номер для документов 5-го ААС (298682261)
//
// Revision 1.9  2011/11/11 13:24:04  narry
// Пропадает текст из определений ВАС (297710781)
//
// Revision 1.8  2011/11/09 10:38:02  narry
// Вывод в лог текста удаленных абзацев
//
// Revision 1.7  2011/11/07 11:36:15  narry
// Не проверять город в тексте (296630444)
//
// Revision 1.6  2011/10/31 13:22:19  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.5  2011/10/28 13:13:35  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.4  2011/10/26 09:57:37  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.3  2011/10/25 13:16:26  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.2  2011/10/25 05:31:16  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.1  2011/10/24 10:38:35  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//

interface

uses
 l3Variant,
 evdBufferedFilter,
 k2Interfaces, Classes, l3Types, k2Types, ddTypes, DT_Types, dd_lcBaseFilter,
 k2TagGen, l3base, dd_lcUtils, l3StringList, l3RegEx,

 k2Base
 ;

type
 Tdd_lcTextReaction = (lcWrite, lcSkip, lcDelete); // записано, использовано, удалено
 Tdd_lcBaseFormatter = class(Tdd_lcParaFilter)
 private
  f_CheckEmptyPara: Boolean;
  f_CityNamePattern: AnsiString;
  f_EnableRestoreText: Boolean;
  f_InTable: Integer;
  f_LostParas: Tl3StringList;
  f_RegSearcher: Tl3RegularSearch;
  procedure MakeCityNamePattern;
  function pm_GetInTable: Boolean;
  function pm_GetLostParaCount: Integer;
  function _ExtractNumber(aPara: Tl3Tag; var NeedCheckDate: Boolean): AnsiString;
 protected
  f_BodyFinished: Boolean;
  f_BodyStarted: Boolean;
  f_Date: Integer;
  f_DefinitionTitle: AnsiString;
  f_DNType: Integer;
  f_DocID: TDocID;
  f_DocName: Tl3String;
  f_FormatStyle: Tdd_lcFormatStyle;
  f_LawCaseNumber: AnsiString;
  f_Number: AnsiString;
  f_Numbers: TStrings;
  f_Parameters: Array[Tdd_lcLookFor] of AnsiString;
  f_PrevPara: Il3TagRef;
  f_Source: AnsiString;
  f_Type: AnsiString;
  procedure AddEmptyPara;
  procedure AddSBSTable(const aLeft, aRight: AnsiString; aIsSign: Boolean);
  function CheckExtractNumber(aPara: Tl3Variant; out theNumber: AnsiString; out
      theStartPos, theLength: Integer; out theIsCaseCode: Boolean): Boolean;
  procedure CheckLostParameters; virtual;
  function CheckStartText(aPara: Tl3Variant): Boolean;
  procedure Cleanup; override;
  procedure ClearParameters; virtual;
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure DoStartChild(TypeID: Tk2Type); override;
  procedure DoWritePara(aLeaf: Tl3Variant); override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; virtual;
  function IsBodyStart(aPara: Tl3Variant; out IsResolution: Boolean): Boolean;
  function IsCityName(aPara: Tl3Variant; var aCityName: ShortString): Boolean;
  function isCourtName(aPara: Tl3Variant): Boolean;
  function CheckExtractDate(aPara: Tl3Variant; out theDate: AnsiString; out theStartPos,
      theLength: Integer): Boolean;
  function CheckStartsDate(aPara: Tl3Variant): Boolean;
  function CheckDateStart(aPara: Tl3Variant; aPos: Integer = 0): Integer;
  function CheckDateEnd(aPara: Tl3Variant; aPos: Integer = 0): Integer;
  function FindDatePos(aPara: Tl3Variant; out theDatePos: Tl3MatchPosition; aPos:
      Integer = 0): Boolean;
  function IsDate(aPara: Tl3Variant): Boolean;
  function IsNumber(aPara: Tl3Variant): Boolean;
  function IsPrezidium: Boolean;
  function NormalizeText(aLeaf: Tl3Variant): AnsiString; overload;
  function NormalizeText(const aText: AnsiString): AnsiString; overload;
  procedure OpenStream; override;
  procedure ReportMissing(const aMessage: AnsiString);
  property CheckEmptyPara: Boolean read f_CheckEmptyPara write f_CheckEmptyPara;
  property InTable: Boolean read pm_GetInTable;
  property LostParaCount: Integer read pm_GetLostParaCount;
  property RegSearcher: Tl3RegularSearch read f_RegSearcher;
 public
  f_ParaCount: Integer;
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure BodyFinish; virtual;
  procedure BodyStart; virtual;
  procedure CloseStructure(NeedUndo: Boolean); override;
  property EnableRestoreText: Boolean read f_EnableRestoreText write f_EnableRestoreText;
  property ParaCount: Integer read f_ParaCount;
 end;

 Tdd_lcDefaultChildFormatter = class(Tdd_lcBaseFormatter)
 protected
  procedure CheckLostParameters; override;
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;


implementation

uses
 k2Tags,
 StrUtils, SysUtils, Windows,
 ddUtils,
 evdStyles, evdTypes,
 l3LingLib, l3DateSt, l3Chars,
 TextPara_Const, Document_Const, DictItem_Const, NumAndDate_Const, Block_Const, TableCell_Const, Table_Const,
 SBS_Const, SBSRow_Const, SBSCell_Const, l3String, Math,
 dd_lcCodeCorrector, dd_lcSourceUtils, l3StringListPrim;

constructor Tdd_lcBaseFormatter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_Numbers := TStringList.Create;
 f_DocName := Tl3String.Create();
 f_LostParas := Tl3StringList.Create();
 f_RegSearcher := Tl3RegularSearch.Create;
 f_RegSearcher.IgnoreCase:= False;
 MakeCityNamePattern;
 f_EnableRestoreText := False;
end;

procedure Tdd_lcBaseFormatter.AddEmptyPara;
begin
 Generator.StartChild(k2_typTextPara);
 Generator.Finish;
end;

procedure Tdd_lcBaseFormatter.AddSBSTable(const aLeft, aRight: AnsiString; aIsSign:
    Boolean);
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

procedure Tdd_lcBaseFormatter.BodyFinish;
begin
 f_BodyFinished:= True;
end;

function Tdd_lcBaseFormatter.EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction;
begin
 Result:= lcWrite;
end;

procedure Tdd_lcBaseFormatter.CheckLostParameters;
var
 i: Integer;
begin
 if (LostParaCount > 0) and (LostParaCount <> f_ParaCount) then
 begin
  ErrorReaction('%s: Удалено %d абзацев с текстом:', [ClassName, LostParaCount]);
  for i:= 0 to f_LostParas.Hi do
   ErrorReaction('%d. "%s"', [Succ(i), f_LostParas.Items[i].AsString]);
 end
 else
 if (LostParaCount = f_ParaCount) and (EnableRestoreText) then
 begin
  //ErrorReaction('%s: Восстановление документа', [ClassName]);
  for i:= 0 to f_LostParas.Hi do
  begin
   Generator.StartChild(k2_typTextPara);
   try
    Generator.AddStringAtom(k2_tiText, f_LostParas.Items[i].AsString);
   finally
    Generator.Finish;
   end;
  end;
 end;
 f_LostParas.Clear;
end;

procedure Tdd_lcBaseFormatter.Cleanup;
begin
 inherited;
 FreeAndNil(f_DocName);
 FreeAndNil(f_LostParas);
 FreeAndNil(f_RegSearcher);
end;

procedure Tdd_lcBaseFormatter.ClearParameters;
begin
 f_DNType:= -1;
 f_Date:= 0;
 f_Number:= '';
 f_LawCaseNumber:= '';
 f_Source:= '';
 f_Type:= '';
 f_InTable:= 0;
 f_PrevPara:= nil;
 f_DefinitionTitle:= '';
 f_FormatStyle:= lc_fsResolution;
 f_Numbers.Clear;
 f_DocName.Clear;
 l3FillChar(f_Parameters, SizeOf(f_Parameters), 0);
 f_CheckEmptyPara:= False;
 f_BodyStarted:= False;
 f_BodyFinished:= False;
 f_ParaCount:= 0;
 f_LostParas.Clear;
end;

procedure Tdd_lcBaseFormatter.CloseStructure(NeedUndo: Boolean);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  CheckLostParameters
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
  Dec(f_InTable);
 inherited;
end;

procedure Tdd_lcBaseFormatter.DoAddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
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
     if AnsiSameText('Президиум ВАС РФ', f_Source) then
      f_Source:= 'Президиум Высшего Арбитражного Суда';
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
        if Source2DossierType(f_Source) = lc_dtVAC then
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

procedure Tdd_lcBaseFormatter.DoStartChild(TypeID: Tk2Type);
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
  Inc(f_InTable);
end;

procedure Tdd_lcBaseFormatter.DoWritePara(aLeaf: Tl3Variant);
var
 l_EnableWrite: Tdd_lcTextReaction;
begin
 Inc(f_ParaCount);
 if ((aLeaf.StrA[k2_tiText] = '') and CheckEmptyPara) then
  l_EnableWrite:= EnableWrite(aLeaf)
 else
  l_EnableWrite:= lcWrite;
 if (aLeaf.StrA[k2_tiText] <> '') then
  l_EnableWrite:= EnableWrite(aLeaf);
 if l_EnableWrite = lcWrite then
  inherited
 else
 if (l_EnableWrite = lcDelete) and
    ((aLeaf.StrA[k2_tiText] <> '') and not l3AllCharsInCharSet(aLeaf.PCharLenA[k2_tiText], cc_WhiteSpace)) then
  f_LostParas.Add(aLeaf.StrA[k2_tiText]);
end;

procedure Tdd_lcBaseFormatter.BodyStart;
begin
 f_BodyStarted:= True;
end;

function Tdd_lcBaseFormatter.CheckExtractDate(aPara: Tl3Variant; out theDate:
    AnsiString; out theStartPos, theLength: Integer): Boolean;
const
 cDay   = '[\«\"]?{\d\d?}[\»\"]?';
 cMonth = '{(январ[ья])|(феврал[ья])|(марта?)|(апрел[ья])|(ма[йя])|(июн[ья])|(июл[ья])|(августа?)|(сентябр[ья])|(октябр[ья])|(ноябр[ья])|(декабр[ья])}';
 cYear  = '{\d\d\d\d}(\s?(года)|(г\.?))?<';
var
 l_pos: Tl3MatchPosition;
 l_S, l_type: AnsiString;
 i: Integer;
begin
 Result:= False;
 l_S:= aPara.StrA[k2_tiText];
 l_Type:= Copy(f_Type, 1, 6);
  RegSearcher.SearchPattern:= cDay + '\s+' + cMonth + '\s+' + cYear;
  if RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_pos) then
  begin
   if (not AnsiContainsText(l_S, l_Type{'постанов'}) and not AnsiContainsText(l_S, 'Резолют')) or
      (l_Pos.StartPos < 10) then
   begin
    theStartPos:= l_Pos.StartPos;
    theLength:= l_Pos.Length;
    Result:= True;
    theDate:= '';
    for i:= 0 to RegSearcher.TagParts.Count-1 do
    begin
     if i > 0 then
      theDate:= theDate + ' ';
     theDate:= theDate + RegSearcher.TagParts[i].AsString;
    end; // for i
    theDate:= theDate +' г.';
   end; // not AnsiContainsText(l_S, l_Type{'постанов'}) and not AnsiContainsText(l_S, 'Резолют') then
  end; // RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_pos)
end;

function Tdd_lcBaseFormatter.CheckStartsDate(aPara: Tl3Variant): Boolean;
begin
 Result:= CheckDateStart(aPara) = 0;
end;

function Tdd_lcBaseFormatter.CheckStartText(aPara: Tl3Variant): Boolean;
var
 i: Integer;
 l_Pos: Tl3MatchPosition;
const
 cArbCourt = '(Арбитражный суд (в составе)|(.+ в составе))|(Судья( (Федерального )?Арбитражного суда)?)|(Председатель)';
begin
 Result := False;
 for i:= 0 to c_DefinitionMax do
  if AnsiStartsText(c_DefinitionStarts[i], aPara.StrA[k2_tiText]) then
  begin
   Result:= True;
   break;
  end;
 if not Result then
 begin
  (*
  Result:= isCourtName(aPara) or
           AnsiContainsText(aPara.StrA[k2_tiText], 'Арбитражный суд в составе') or
           AnsiContainsText(aPara.StrA[k2_tiText], 'в составе') or
           AnsiStartsText('Судья', aPara.StrA[k2_tiText]) or
           AnsiStartsText('Председатель', aPara.StrA[k2_tiText]);
  *)
  RegSearcher.IgnoreCase:= True;
  RegSearcher.SearchPattern:= cArbCourt;
  Result:= isCourtName(aPara) or RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos);
 end;
end;

function Tdd_lcBaseFormatter._ExtractNumber(aPara: Tl3Tag; var NeedCheckDate:
    Boolean): AnsiString;

var
 l_EndPos: Integer;
begin
 NeedCheckDate:= False;
 Result:= '';
 (*
 if CheckExtractNumber(aPara, Result, l_EndPos) then
 begin
  if l_EndPos < aPara.PCharLenA[k2_tiText].SLen then
  begin
   aPara.StrW[k2_tiText, nil]:= Trim(Copy(aPara.StrA[k2_tiText], Succ(l_EndPos), MaxInt));
   NeedCheckDate:= True;
  end;
 end; // RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos)
 *)
end;

function Tdd_lcBaseFormatter.IsBodyStart(aPara: Tl3Variant; out IsResolution:
    Boolean): Boolean;
begin
 if not f_BodyStarted then
 begin
  IsResolution:= AnsiContainsText(aPara.StrA[k2_tiText], 'Резолютивн');
  Result := isResolution or CheckStartText(aPara);
  if Result then
   BodyStart;
 end
 else
  Result:= False;
end;

function Tdd_lcBaseFormatter.IsCityName(aPara: Tl3Variant; var aCityName:
    ShortString): Boolean;
var
 l_Pos: Tl3MatchPosition;
begin
 aCityName:= '';
 RegSearcher.SearchPattern:= f_CityNamePattern;
 Result:= RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos);
 if Result then
  aCityName:= RegSearcher.TagParts.Items[0].AsString;
end;

function Tdd_lcBaseFormatter.isCourtName(aPara: Tl3Variant): Boolean;
var
 l_S,
 l_DecitySource: AnsiString;
 i: Integer;
begin
 if Source2DossierType(f_Source) = lc_dtVAC then
 begin
  Result:= False;
  for i:= 0 to length(c_DefinitionStarts)-1 do // : Array[0..c_DefinitionMax]
   if AnsiStartsText(c_DefinitionStarts[i], aPara.StrA[k2_tiText]) then
   begin
    Result:= True;
    break
   end;
 end
 else
 begin
  l_S:= AnsiReplaceText(aPara.StrA[k2_tiText], 'ё', 'е');
  l_DecitySource:= l3DeleteDoubleSpace(AnsiReplaceText(DeBracketStr(f_Source), 'г.', 'города '));
  Result := AnsiStartsText(DeBracketStr(f_Source), l_S) or AnsiStartsText(l_DecitySource, l_S);
 end;
end;

function Tdd_lcBaseFormatter.IsNumber(aPara: Tl3Variant): Boolean;
var
 l_Pos: Tl3MatchPosition;
 l_Number: AnsiString;
 l_StartPos, l_Length: Integer;
 l_IsCaseCode: Boolean;
begin
 Result:= CheckExtractNumber(aPara, l_Number, l_StartPos, l_Length, l_IsCaseCode)
end;

function Tdd_lcBaseFormatter.CheckExtractNumber(aPara: Tl3Variant; out theNumber:
    AnsiString; out theStartPos, theLength: Integer; out theIsCaseCode: Boolean):
    Boolean;
const
 cDelo = '(Д|дело\s*)';
 cNo   = '([\№N]\s*)';
 cNum  = '(([A-ZА-Я]\s?\d\d)|(ВАС)\s?(\-[А-Я]+\s?)?\-\s?\d+(\s?\/|\-|\\\s?)[А-Я\-0-9\\\/]+)';
 cRegExp = '({' + cDelo+cNo+'}.+\({'+cNum+'}\)$)|({'+cDelo+cNo+cNum+'?})|({'+cNo+cNum+'})|({'+cNum + '})|(^{'+cDelo+'}$)|('+cNo+')';
var
 l_Pos: Tl3MatchPosition;
 i: Integer;
begin
 Result:= False;
 theNumber:= '';
 RegSearcher.SearchPattern:= cRegExp;
 if RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos) then
 begin
  Result := InRange(l_Pos.StartPos, 0, 14);
  if Result then
  begin
   theStartPos:= l_Pos.StartPos;
   theLength:= l_Pos.Length;
   for i:= 0 to Pred(RegSearcher.TagParts.Count) do
   begin
    if i > 0 then
     theNumber:= theNumber + ' ';
    theNumber:= theNumber + RegSearcher.TagParts[i].AsString;
   end; // for i
   RegSearcher.SearchPattern:= '(А\d\d)|(Д|дело)';
   theIsCaseCode:= RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos);
  end; // Result
 end; // RegSearcher.SearchInString
end;

function Tdd_lcBaseFormatter.CheckDateStart(aPara: Tl3Variant; aPos: Integer = 0):
    Integer;
var
 l_pos: Tl3MatchPosition;
begin
 Result:= -1;
 if FindDatePos(aPara, l_Pos, aPos) then
  Result:= l_Pos.StartPos;
end;

function Tdd_lcBaseFormatter.CheckDateEnd(aPara: Tl3Variant; aPos: Integer = 0):
    Integer;
var
 l_pos: Tl3MatchPosition;
begin
 Result:= -1;
 if FindDatePos(aPara, l_Pos, aPos) then
  Result:= l_Pos.EndPos;
end;

function Tdd_lcBaseFormatter.FindDatePos(aPara: Tl3Variant; out theDatePos:
    Tl3MatchPosition; aPos: Integer = 0): Boolean;
const
 cDay     = '[\«\"]?{\d\d?}[\»\"]?';
 cMonth   = '{(январ[ья])|(феврал[ья])|(марта?)|(апрел[ья])|(ма[йя])|(июн[ья])|(июл[ья])|(августа?)|(сентябр[ья])|(октябр[ья])|(ноябр[ья])|(декабр[ья])}';
 cYear    = '{\d\d\d\d}(\s?(года)|(г\.?))?<';
 cDigital = '\d\d?(\.|-|\\)\d\d(\.|-|\\)\d\d\d\d';
var
 l_pos: Tl3MatchPosition;
 l_S, l_type: AnsiString;
 i: Integer;
begin
 Result:= False;
 RegSearcher.SearchPattern:= cDay + '\s+' + cMonth + '\s+' + cYear;
 if RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText].S, aPos, aPara.PCharLenA[k2_tiText].SLen, l_pos) then
 begin
  Result:= true;
  theDatePos:= l_pos;
 end
 else
 begin
  RegSearcher.SearchPattern:= cDigital;
  if RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText].S, aPos, aPara.PCharLenA[k2_tiText].SLen, l_pos) then
  begin
   Result:= true;
   theDatePos:= l_pos;
  end
 end;
end;

function Tdd_lcBaseFormatter.IsDate(aPara: Tl3Variant): Boolean;
var
 l_Date: AnsiString;
 l_Start, l_Length: Integer;
begin
 Result := CheckExtractDate(aPara, l_Date, l_Start, l_Length);
end;

function Tdd_lcBaseFormatter.IsPrezidium: Boolean;
begin
 Result := AnsiSameText(f_Source, 'Президиум Высшего Арбитражного Суда');
end;

procedure Tdd_lcBaseFormatter.MakeCityNamePattern;
var
 i: Integer;
begin
 f_CityNamePattern:= '{((город)|((гор)|г\.?)\s?)?>';
 for i:= 0 to Pred(Length(c_CityNames)) do
 begin
  f_CityNamePattern:= f_CityNamePattern + '(' + c_CityNames[i] + ')';
  if i <> Pred(Length(c_CityNames)) then
   f_CityNamePattern:= f_CityNamePattern + '|';
 end;
 f_CityNamePattern:= f_CityNamePattern + '<}';
end;

function Tdd_lcBaseFormatter.NormalizeText(aLeaf: Tl3Variant): AnsiString;
begin
 Result:= NormalizeText(aLeaf.StrA[k2_titext]);
end;

function Tdd_lcBaseFormatter.NormalizeText(const aText: AnsiString): AnsiString;
begin
 Result:= AnsiReplaceStr(aText, ' ', '');
 Result:= AnsiReplaceStr(Result, #9, '');
end;

procedure Tdd_lcBaseFormatter.OpenStream;
begin
 inherited;
 ClearParameters;
end;

function Tdd_lcBaseFormatter.pm_GetInTable: Boolean;
begin
 Result := f_InTable > 0;
end;

function Tdd_lcBaseFormatter.pm_GetLostParaCount: Integer;
begin
 Result := f_LostParas.Count;
end;

procedure Tdd_lcBaseFormatter.ReportMissing(const aMessage: AnsiString);
begin
 if f_DocID > 0 then
  ErrorReaction('%d: Не найдена информация для "%s"', [f_DocID, aMessage])
 else
  ErrorReaction('Не найдена информация для "%s"', [aMessage]);
end;

procedure Tdd_lcDefaultChildFormatter.CheckLostParameters;
begin
end;

procedure Tdd_lcDefaultChildFormatter.ClearParameters;
begin
 inherited;
end;

function Tdd_lcDefaultChildFormatter.EnableWrite(aPara: Tl3Variant):
    Tdd_lcTextReaction;
begin
 Result:= lcWrite;
end;

end.
