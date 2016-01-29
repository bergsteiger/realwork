unit lukTextBeautyfier;
{ Различные фильтры для улучшения форматирования текста }

// $Id: lukTextBeautyfier.pas,v 1.27 2014/04/30 13:11:37 lulin Exp $

// $Log: lukTextBeautyfier.pas,v $
// Revision 1.27  2014/04/30 13:11:37  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.26  2011/10/04 12:20:02  narry
// Причесывание документов
//
// Revision 1.25  2011/09/09 12:16:29  narry
// 62. Оформление Доверенностей - 5 (281528411)
//
// Revision 1.24  2011/09/09 12:08:55  narry
// 61. Выделение имени в Доверенности (281528248)
//
// Revision 1.23  2011/09/09 12:03:02  narry
// 58. Не отбивать подпункты (281525222)
//
// Revision 1.22  2011/09/09 10:33:49  narry
// 57. Пункты отбивать пустой строкой сверху (281525215)
//
// Revision 1.21  2011/09/09 10:31:40  narry
// 56. Разрядка строк (281525189)
//
// Revision 1.20  2011/09/09 10:14:04  narry
// 46. Между инициалами и фамилией может быть пробел (281524883)
//
// Revision 1.19  2011/09/09 09:53:07  narry
// 46. Между инициалами и фамилией может быть пробел (281524883)
//
// Revision 1.18  2011/09/01 08:08:06  narry
// 35. Стирается пробел перед ссылкой (внимание на между "от" и датой) (278839514)
//
// Revision 1.17  2011/08/31 07:04:51  narry
// 37. Оформление документов (пробел между № и цифрой) (278839540)
//
// Revision 1.16  2011/08/30 10:30:28  narry
// 40. Ошибка. Слипается шапка Доверенностей (278839556)
//
// Revision 1.15  2011/08/30 06:55:41  narry
// 37. Оформление документов (пробел между № и цифрой) (278839540)
//
// Revision 1.14  2011/08/29 11:28:05  narry
// 42. Оформление текста Протоколов (278842646)
//
// Revision 1.13  2011/08/29 11:21:05  narry
// 39. Оформление текста (разделить пункты пустыми строками)  (278839550)
//
// Revision 1.12  2011/08/29 07:47:37  narry
// 34. Оформление ключевых слов перед распорядительной частью документов (278839498)
//
// Revision 1.11  2011/08/29 07:25:05  narry
// 33. Формирование подписи (278839311)
//
// Revision 1.10  2011/08/12 11:27:14  narry
// 32. Ограничение на преобразование (278839289)
//
// Revision 1.9  2011/08/10 13:14:46  narry
// 26. Необходимые правки в оформлении текста (278836218)
//
// Revision 1.8  2011/07/19 10:48:58  narry
// Оформление текста (274835314)
//
// Revision 1.7  2011/07/19 10:21:54  narry
// Оформление текста (274835314)
//
// Revision 1.6  2011/07/18 12:15:50  narry
// Снова заголовки (274829372)
//
// Revision 1.5  2011/07/12 13:00:14  narry
// Директивы CVS
//

interface

uses
 l3Types, k2Types, evdBufferedFilter, k2Interfaces, evdLeafParaFilter, k2Reader, k2TagGen,
 lukIDGenerator;

type
 TlukTextSplitter = class(TevdLeafParaFilter)
 private
  f_ParaStartText: String;
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 public
  class function SetTo(var theGenerator: Tk2TagGenerator; const aParaStartText: String):
      Tk2TagGenerator; overload;
 published
  property ParaStartText: String read f_ParaStartText write f_ParaStartText;
 end;

 TlukTextReplacer = class(TevdLeafParaFilter)
 private
  f_ReplaceText: string;
  f_SearchText: string;
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 public
  class function SetTo(var theGenerator: Tk2TagGenerator; const aSearchText, aReplaceText: String):
      Tk2TagGenerator; overload;
 published
  property ReplaceText: string read f_ReplaceText write f_ReplaceText;
  property SearchText: string read f_SearchText write f_SearchText;
 end;

 TlukEmptyParaEliminator = class(TevdLeafParaFilter)
 protected
  function NeedWritePara(const aLeaf: Tl3Tag): Boolean; override;
 end;

type
 TlukStyleReplacer = class(TevdLeafParaFilter)
 private
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 public
 published
 end;

type
 TlukSegmentJoiner = class(TevdLeafParaFilter)
 private
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 public
 published
 end;

 TlukPresidentFilter = class(TevdLeafParaFilter)
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 end;

 TlukSpaceInserter = class(TevdLeafParaFilter)
 private
  function NormalizeText(const aLeaf: Tl3Tag): string;
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 end;

 TlukPointDecorator = class(TevdLeafParaFilter)
 private
  function IsPoint(aText: String): Boolean;
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 end;

 TlukNumberDecorator = class(TevdLeafParaFilter)
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 end;

implementation

uses Textpara_Const, k2Tags, l3String, SysUtils, l3Chars, evSearch, NevTools, evParaTools, evTypes,
 l3Base, evParaSplitter, Math, evdStyles, evdTypes, k2base, SBS_Const, evTextParaTools,
  StrUtils, SBSRow_Const, SBSCell_Const;

procedure TlukTextSplitter.DoWritePara(const aLeaf: Tl3Tag);
const
 cOpt = [ev_soNoException, ev_soNoProgress, ev_soReplaceAll];
var
 l_nevPara: InevPara;
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  if aLeaf.QT(InevPara, l_nevPara) then
  try
   l_Searcher:= TevBMTextSearcher.Make(ParaStartText, cOpt);
   try
    l_Replacer:= TevParaSplitter.Make(Generator, cOpt);
    try
     EvReplaceInPara(l_nevPara, l_Searcher, l_Replacer);
    finally
     l_Replacer:= nil;
    end;//try..finally
   finally
    l_Searcher:= nil;
   end;//try..finally
  finally
   l_Nevpara:= nil;
  end;//try..finally
 end;//aLeaf.Attr[k2_tiText].IsValid
 inherited;
end;

class function TlukTextSplitter.SetTo(var theGenerator: Tk2TagGenerator; const aParaStartText:
    String): Tk2TagGenerator;
begin
 Result:= SetTo(theGenerator);
 TlukTextSplitter(theGenerator).ParaStartText:= aParaStartText;
end;

procedure TlukTextReplacer.DoWritePara(const aLeaf: Tl3Tag);
const
 cOpt = [ev_soNoException, ev_soNoProgress, ev_soReplaceAll];
var
 l_nevPara: InevPara;
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  if aLeaf.QT(InevPara, l_nevPara) then
  try
   l_Searcher:= TevBMTextSearcher.Make(SearchText, cOpt);
   try
    l_Replacer:= TevTextReplacer.Make(ReplaceText, cOpt);
    try
     EvReplaceInPara(l_nevPara, l_Searcher, l_Replacer);
    finally
     l_Replacer:= nil;
    end;//try..finally
   finally
    l_Searcher:= nil;
   end;//try..finally
  finally
   l_Nevpara:= nil;
  end;//try..finally
 end;//aLeaf.Attr[k2_tiText].IsValid
 inherited;
end;

class function TlukTextReplacer.SetTo(var theGenerator: Tk2TagGenerator; const aSearchText,
    aReplaceText: String): Tk2TagGenerator;
begin
 Result:= SetTo(theGenerator);
 TlukTextReplacer(theGenerator).SearchText:= aSearchText;
 TlukTextReplacer(theGenerator).ReplaceText:= aReplaceText;
end;

function TlukEmptyParaEliminator.NeedWritePara(const aLeaf: Tl3Tag): Boolean;
begin
 Result:= aLeaf.Attr[k2_tiText].IsValid and (aLeaf.Attr[k2_tiText].AsPCharLen.SLen > 0)
end;

procedure TlukStyleReplacer.DoWritePara(const aLeaf: Tl3Tag);
  function lp_CheckSegments(const aLayer: Tl3Tag; anIndex: Integer): Boolean;

   function lp_ConvertSegment(const aSeg: Tl3Tag): Boolean;
   var
    l_Font: Tl3Tag;
    l_Justify: TevIndentType;
    l_AllParaSeg: Boolean;
   begin
    l_Justify:= TevIndentType(aLeaf.IntA[k2_tiJustification]);
    l_AllParaSeg:= aSeg.Attr[k2_tiFinish].IsValid and (aSeg.IntA[k2_tiFinish] = aLeaf.Attr[k2_tiText].AsPCharLen.Slen);

    Result := False;
    if aSeg.Attr[k2_tiFont].IsValid then
    begin
     l_Font:= aSeg.Attr[k2_tiFont];
     if (l_Font.Attr[k2_tiItalic].IsValid) and (l_Font.BoolA[k2_tiItalic]) and l_AllParaSeg then
     begin
      case l_Justify of
       ev_itWidth: aLeaf.IntA[k2_tiStyle]:= ev_saColorSelection;
       ev_itCenter:
        begin
         aLeaf.IntA[k2_tiStyle]:= ev_saTxtHeader1;
         aLeaf.Attr[k2_tiJustification]:= k2NullTag;
        end;
       ev_itRight:
        if AnsiStartsText('Приложение', aLeaf.StrA[k2_tiText]) then
         aLeaf.IntA[k2_tiStyle]:= ev_saEnclosureHeader
        else
         aLeaf.IntA[k2_tiStyle]:= ev_saColorSelection;
      end;
      Result:= True;
     end
     else
     if (l_Font.Attr[k2_tiItalic].IsValid) and (l_Font.BoolA[k2_tiItalic]) then
     begin
      aSeg.IntW[k2_tiStyle, nil]:= ev_saColorSelection;
      l_Font.BoolW[k2_tiItalic, nil]:= False;
      Result:= False;
     end
     else
     if (l_Font.Attr[k2_tiBold].IsValid) and (l_Font.BoolA[k2_tiBold]) then
     begin
      aSeg.IntW[k2_tiStyle, nil]:= ev_saColorSelection;
      l_Font.BoolW[k2_tiBold, nil]:= False;
      Result:= False;
     end
     else
     if (l_Font.Attr[k2_tiBold].IsValid) and (l_Font.BoolA[k2_tiBold]) and l_AllParaSeg and (l_Justify = ev_itCenter) then
     begin
      aLeaf.IntA[k2_tiStyle]:= ev_saTxtHeader1;
      aLeaf.Attr[k2_tiJustification]:= k2NullTag;
      Result:= True;
     end
     else
     if l_Font.Attr[k2_tiUnderline].IsValid and l_Font.BoolA[k2_tiUnderline] and l_AllParaSeg and (l_Justify = ev_itCenter) then
     begin
      aLeaf.IntA[k2_tiStyle]:= ev_saTxtHeader1;
      aLeaf.Attr[k2_tiJustification]:= k2NullTag;
      Result:= True;
     end;
    end;
   end; // lp_ConvertObject
  var
   i: Integer;
  begin
   Result := True;
   if aLayer.Attr[k2_tiHandle].IsValid and (aLayer.IntA[k2_tiHandle] = ev_slView) then
   begin
    i:= 0;
    while i < aLayer.ChildrenCount do
     if lp_ConvertSegment(aLayer.Child[i]) then
      aLayer.DeleteChild(i)
     else
      Inc(i);
    Result:= False;
   end;
  end; // lp_CheckObjects
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  if not l3EmptyOrAllCharsInCharSet(aLeaf.PCharLenA[k2_tiText], [cc_HardSpace, cc_Tab, cc_SoftSpace, cc_SoftEnter]) then
  begin
   // Заменяем все ЗаголовокN на Заголовок1
   if aLeaf.Attr[k2_tiStyle].IsValid then
   begin
    if InRange(aLeaf.IntA[k2_tiStyle], ev_saTxtHeader4, ev_saTxtHeader2) then
    begin
     aLeaf.IntA[k2_tiStyle]:= ev_saTxtHeader1;
     if aLeaf.Attr[k2_tiSegments].IsValid then
      aLeaf.AttrW[k2_tiSegments, nil]:= k2NullTag;
    end; // InRange(aLeaf.IntA[k2_tiStyle], ev_saTxtHeader4, ev_saTxtHeader2)
   end;//aLeaf.Attr[k2_tiStyle].IsValid

   if (TevIndentType(aLeaf.IntA[k2_tiJustification]) = ev_itCenter) then
   begin
    aLeaf.IntW[k2_tiFirstIndent, nil]:= 0;

    if aLeaf.Attr[k2_tiFont].IsValid and
       aLeaf.Attr[k2_tiFont].Attr[k2_tiBold].IsValid and aLeaf.Attr[k2_tiFont].BoolA[k2_tiBold] then
    begin
     aLeaf.Attr[k2_tiFont].BoolW[k2_tiBold, nil]:= false;
     aLeaf.IntA[k2_tiStyle]:= ev_saTxtHeader1;
     aLeaf.Attr[k2_tiJustification]:= k2NullTag;
    end;
   end;
   // Заменяем курсив на что-то другое в зависимости от выравнивания абзаца
   if aLeaf.Attr[k2_tiSegments].IsValid then
   begin
     aLeaf.Attr[k2_tiSegments].IterateChildrenF(k2l2tia(@lp_CheckSegments));
   end;
  end // if not l3EmptyOrAllCharsInCharSet(aLeaf.PCharLenA[k2_tiText], [cc_HardSpace, cc_Tab, cc_SoftSpace])
  else
  begin
   aLeaf.AttrW[k2_tiStyle, nil]:= k2NullTag;
   aLeaf.AttrW[k2_tiText, nil]:= k2NullTag;
  end;
 end; // aLeaf.Attr[k2_tiText].IsValid
 inherited;
end;

procedure TlukSegmentJoiner.DoWritePara(const aLeaf: Tl3Tag);
  function lp_CheckSegments(const aLayer: Tl3Tag; anIndex: Integer): Boolean;

   function lp_JoinSegment(const aSeg, aPrevSeg: Tl3Tag): Boolean;
   var
    l_Font, l_PrevFont: Tl3Tag;
   begin
    Result := False;
    if aSeg.IntA[k2_tiStart] = IfThen(aSeg.IntA[k2_tiFinish]=0,
                                      aLeaf.Attr[k2_tiText].AsPCharLen.SLen,
                                      aSeg.IntA[k2_tiFinish]) then
     Result:= True
    else
    if (aSeg.Attr[k2_tiFont].IsValid) and (aPrevSeg.Attr[k2_tiFont].IsValid) then
    begin
     l_Font:= aSeg.Attr[k2_tiFont];
     l_PrevFont:= aPrevSeg.Attr[k2_tiFont];

     if ((l_Font.BoolA[k2_tiItalic] = l_PrevFont.BoolA[k2_tiItalic])) and
        (l_Font.BoolA[k2_tiUnderline] = l_PrevFont.BoolA[k2_tiUnderline]) or
        (l_Font.BoolA[k2_tiBold] = l_PrevFont.BoolA[k2_tiBold]) then
     begin
      if aSeg.IntA[k2_tiStart] >= {Succ}(aPrevSeg.IntA[k2_tiFinish]) then
       Result:= True
     end;
    end;
   end; // lp_ConvertObject
  var
   i: Integer;
   l_AllSegLen: Integer;
   l_BreakCount: Integer;

   function lp_CalcSegmentsLen(const aSeg: Tl3Tag; anIndex: Integer): Boolean;
   begin
    Result:= True;
    Inc(l_AllSegLen, IfThen(aSeg.IntA[k2_tiFinish]=0,
                                      aLeaf.Attr[k2_tiText].AsPCharLen.SLen,
                                      aSeg.IntA[k2_tiFinish]) - aSeg.IntA[k2_tiStart]);
   end;

  begin // lp_CheckSegments
   Result := True;
   if aLayer.Attr[k2_tiHandle].IsValid and (aLayer.IntA[k2_tiHandle] = ev_slView) then
   begin
    l_AllSegLen:= 0;
    aLayer.IterateChildrenF(k2l2tia(@lp_CalcSegmentsLen));
    l_BreakCount:= l3CountOfChar(cc_SoftEnter, aLeaf.StrA[k2_tiText]);
    if (aLayer.ChildrenCount > 1) and (l_AllSegLen + l_BreakCount = aLeaf.Attr[k2_tiText].AsPCharLen.SLen) then
    begin
     while aLayer.ChildrenCount > 1 do
      aLayer.DeleteChild(0);
     aLayer.Child[0].IntW[k2_tiStart, nil]:= 0;
     aLayer.Child[0].IntW[k2_tiFinish, nil]:= aLeaf.Attr[k2_tiText].AsPCharLen.SLen;
    end
    else
    begin
     i:= 1;
     while i < aLayer.ChildrenCount do
      if lp_JoinSegment(aLayer.Child[i], aLayer.Child[Pred(i)]) then
      begin
       aLayer.Child[Pred(i)].IntW[k2_tiFinish, nil]:= IfThen(aLayer.Child[i].IntA[k2_tiFinish]=0, aLeaf.Attr[k2_tiText].AsPCharLen.SLen, aLayer.Child[i].IntA[k2_tiFinish]);
       aLayer.DeleteChild(i)
      end
      else
       Inc(i);
    end;
   end; // aLayer.Attr[k2_tiHandle].IsValid and (aLayer.IntA[k2_tiHandle] = ev_slView)
  end; // lp_CheckSegments
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  if aLeaf.Attr[k2_tiSegments].IsValid then
   aLeaf.Attr[k2_tiSegments].IterateChildrenF(k2l2tia(@lp_CheckSegments));
 end;
 inherited;
end;

const
 cMaxSignatory = 17;
 cPosition = 0;
 cName = 1;
 cSignatory : array[0..cMaxSignatory, cPosition..cName] of string =
  (
  ('Президент', 'В.Ю.Алекперов'),
  ('И.о.Президента', 'Р.У.Маганов'),
  ('И.о.Президента', 'С.П.Кукура'),
  ('И.о.Президента', 'В.И.Некрасов'),
  ('И.о. Президента', 'Р.У.Маганов'),
  ('И.о. Президента', 'С.П.Кукура'),
  ('И.о. Президента', 'В.И.Некрасов'),
//Указания могут подписывать:
  ('Главный бухгалтер', 'Л.Н.Хоба'),
  ('Вице-президент-Главный бухгалтер', 'Л.Н.Хоба'),
  ('Первый вице-президент', 'С.П.Кукура'),
  ('Первый исполнительный вице-президент', 'Р.У.Маганов'),
  ('Вице-президент-начальник Главного управления стратегического развития и инвестиционного анализа', 'Л.А.Федун'),
  ('Вице-президент', 'В.С.Субботин'),
  ('Первый вице-президент', 'В.И.Некрасов'),
  ('Вице-президент-начальник Главного управления по общим вопросам, корпоративной безопасности и связи', 'А.А.Барков'),
//Протокол заседания Совета директоров подписывают:
  ('Председатель', 'В.И.Грайфер'),
//Протокол заседания Правления подписывают:
  ('Председатель Правления', 'В.Ю.Алекперов'),
  ('Секретарь Правления', 'Е.Л.Хавкин')
  );

procedure TlukPresidentFilter.DoWritePara(const aLeaf: Tl3Tag);
var
 l_Text: String;
 i: Integer;
 l_NeedWrite: Boolean;
begin
 l_NeedWrite:= True;
 l_Text:= l3DeleteDoubleSpace(Trim(aLeaf.Attr[k2_tiText].AsString));
 if l_Text <> '' then
 begin
  // Для корректной проверки фамилии, нужно удалить пробелы с конца до первой точки
  i:= Length(l_Text);
  while (i <> 0) and (not (l_Text[i] in [' ', '.'])) do
   Dec(i);
  if (i > 0) and (l_Text[i] = ' ') then
   Delete(l_Text, i, 1);
  for i:= 0 to cMaxSignatory do
   if AnsiStartsText(cSignatory[i, cPosition], l_text) and AnsiEndsText(cSignatory[i, cName], l_text) then
   begin
    l_NeedWrite:= False;
    Generator.StartChild(k2_idSBS);
    try
      Generator.StartChild(k2_idSBSRow);
      try
       Generator.StartChild(k2_idSBSCell);
       try
        Generator.AddIntegerAtom(k2_tiWidth, 2);
        Generator.StartChild(k2_idTextPara);
        try
         Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSLeft);
         Generator.AddStringAtom(k2_tiText, cSignatory[i, cPosition]);
        finally
         Generator.Finish;
        end;
       finally
        Generator.Finish;
       end;
       Generator.StartChild(k2_idSBSCell);
       try
        Generator.AddIntegerAtom(k2_tiWidth, 1);
        Generator.StartChild(k2_idTextPara);
        try
         Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSRight);
         Generator.AddStringAtom(k2_tiText, Copy(l_text, Succ(Length(cSignatory[i, cPosition])), Length(l_Text)));
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
    break
   end; // AnsiStartsText(cSignatory[i, cPosition], l_text) and AnsiEndsText(cSignatory[i, cName], l_text)
 end; // l_text <> ''  
 if l_NeedWrite then
  inherited;
end;

procedure TlukSpaceInserter.DoWritePara(const aLeaf: Tl3Tag);
var
 l_Text: String;
begin
 l_Text:= NormalizeText(aLeaf);
 if AnsiSameText('ОБЯЗЫВАЮ:', l_Text) or
    AnsiSameText('ПРЕДЛАГАЮ:', l_Text) or
    AnsiSameText('ДОВЕРЕННОСТЬ', l_Text) or
    AnsiSameText('ПРОТОКОЛ', l_Text) or
    AnsiSameText('СЧИТАЮ НЕОБХОДИМЫМ:', l_Text) or
    AnsiSameText('ПРАВЛЕНИЕ РЕШИЛО:', l_Text) or
    AnsiSameText('ПРИКАЗЫВАЮ:', l_Text) or
    AnsiContainsText(l_Text, 'образец подписи') or
    AnsiContainsText(l_Text, 'настоящая доверенность выдана') then
 begin
  Generator.StartChild(k2_idTextPara);
  Generator.Finish;
  inherited;
  Generator.StartChild(k2_idTextPara);
  Generator.Finish;
 end
 else
  inherited;
end;

function TlukSpaceInserter.NormalizeText(const aLeaf: Tl3Tag): string;
var
 i: Integer;
begin
 Result := l3DeleteDoubleSpace(Trim(aLeaf.Attr[k2_tiText].AsString));
 if Length(Result) > 2 then
  if Result[2] = ' ' then
  begin
   i:= 2;
   while i < Length(Result) do
   begin
    if Result[i] = ' ' then
     Delete(Result, i, 1);
    Inc(i);
   end;
  end;
end;

procedure TlukPointDecorator.DoWritePara(const aLeaf: Tl3Tag);
var
 l_Text: String;
begin
 l_Text:= Trim(aLeaf.Attr[k2_tiText].AsString);
 if IsPoint(l_Text) then
 begin
  Generator.StartChild(k2_idTextPara);
  Generator.Finish;
  inherited;
 end
 else
  inherited;
end;

function TlukPointDecorator.IsPoint(aText: String): Boolean;
var
 l_DotPos: word;
begin
 Result := False;
 if (aText <> '') then
 begin
  l_DotPos:= Pos('.', aText);
  Result:= (aText[1] in ['0'..'9']) and
           InRange(l_dotPos, 2, Pred(Length(aText))) and
           (ATEXT[PRED(L_DOTPOS)] IN ['0'..'9']) and not (ATEXT[Succ(L_DOTPOS)] IN ['0'..'9']);
 end;
end;

procedure TlukNumberDecorator.DoWritePara(const aLeaf: Tl3Tag);
var
 l_Text: String;
 l_Pos: Integer;
 l_Para: InevTextPara;
 l_Space: Tl3String;
begin
 l_Text:= aLeaf.Attr[k2_tiText].AsString;
 l_pos:= Pos('№', l_Text);
 if aLeaf.QT(InevTextPara, l_Para) then
 begin
  l_Space:= Tl3String.Create;
  try
   l_Space.AsString:= cc_SoftSpace;
   if l_Pos > 0 then
    repeat
     if Length(l_Text) > l_Pos then
     begin
      Inc(l_Pos);
      if not (l_Text[l_Pos] in [cc_SoftSpace, cc_HardSpace]) then
       evDir_InsertText(l_Para, l_Space, Pred(l_Pos), True);
      l_Pos:= PosEx('№', l_Text, l_Pos);
     end
     else
      l_Pos:= 0;
    until l_Pos = 0;
  finally
   FreeAndNil(l_Space);
  end;
 end; // aLeaf.QT(InevTextPara, l_Para)
 inherited;
end;

end.
