unit evTxtRd;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evTxtRd - разборщик текстовых файлов }
{ Начат: 05.10.1999 17:44 }
{ $Id: evTxtRd.pas,v 1.35 2014/04/03 17:10:25 lulin Exp $ }

// $Log: evTxtRd.pas,v $
// Revision 1.35  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.34  2013/10/23 12:25:49  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.33  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.32  2012/02/29 09:09:44  lulin
// {RequestLink:336664105}
//
// Revision 1.31  2011/08/23 18:01:07  lulin
// {RequestLink:279774229}.
//
// Revision 1.30  2011/06/29 19:14:55  lulin
// {RequestLink:254944102}.
//
// Revision 1.29  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.28  2011/02/28 16:54:40  lulin
// {RequestLink:254944075}.
// - поддержка тега color.
//
// Revision 1.27  2009/12/14 11:46:41  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.26  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.25  2009/03/04 13:32:48  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.24  2008/06/20 14:48:51  lulin
// - используем префиксы элементов.
//
// Revision 1.23  2008/06/16 13:55:03  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.22  2008/05/20 12:03:55  lulin
// - <K>: 90448469.
//
// Revision 1.21  2008/05/16 11:42:09  lulin
// - даём возможность варьировать тип документа.
//
// Revision 1.20  2008/05/16 11:36:43  lulin
// - рисуем на модели.
//
// Revision 1.19  2007/12/04 12:47:07  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.17.8.3  2007/07/18 15:07:19  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.17.8.2  2006/12/14 10:41:03  lulin
// - cleanup.
//
// Revision 1.17.8.1  2005/12/09 13:14:25  lulin
// - bug fix: из пустого потока получался документ с нулевым количеством параграфов.
//
// Revision 1.17  2005/03/03 14:28:37  fireton
// - change: TevCustomTxtReader научили конвертировать табы в отступы
//
// Revision 1.16  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.15  2004/04/14 14:59:10  law
// - rename proc: ev_lpCharSetPresent -> l3CharSetPresent.
//
// Revision 1.14  2001/12/27 15:19:28  law
// - change visibility: Tl3CustomString._SetSt перенесен из секции public в protected.
//
// Revision 1.13  2001/03/27 13:59:43  law
// - bug fix: неправильно выливалась таблица шрифтов.
//
// Revision 1.12  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.11  2000/12/15 15:10:39  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3ProtoObject,

  k2Tags,
  k2Base,
  k2TagGen,
  k2Reader,

  Document_Const
  ;

type
  TevCustomTxtReaderCriteria = class(Tl3ProtoObject)
    private
    {property fields}
      f_RedLineIndent : Long;
      f_CenterIndent  : Long;
      f_RightIndent   : Long;
      f_TableSpaces   : Long;
      f_SBSSpaces     : Long;
      f_NormalStyle   : Long;
      f_AddSBS        : Bool;
      f_Graphics      : TCharSet;
      f_EOLBeforeHeader : Bool;
    protected
    {property methods}
      procedure pm_SetTableSpacesCriteria(Value: Long);
        {-}
    public
    {public methods}
      constructor Create{(anOwner: TObject = nil)};
        //override;
        {-}
    public
    {public properties}
      property RedLineIndent: Long
        read f_RedLineIndent
        write f_RedLineIndent
        default 5;
        {-}
      property RightIndent: Long
        read f_RightIndent
        write f_RightIndent
        default 36;
        {-}
      property CenterIndent: Long
        read f_CenterIndent
        write f_CenterIndent
        default 10;
        {-}
      property TableSpaces: Long
        read f_TableSpaces
        write f_TableSpaces
        default 5;
        {-}
      property SBSSpaces: Long
        read f_SBSSpaces
        write f_SBSSpaces
        default 10;
        {-}
      property NormalStyle: Long
        read f_NormalStyle
        write f_NormalStyle;
        {-}
      property AddSBS: Bool
        read f_AddSBS
        write f_AddSBS
        default true;
        {-}
      property Graphics: TCharSet
        read f_Graphics
        write f_Graphics;
        {-}
      property EOLBeforeHeader: Bool
        read f_EOLBeforeHeader
        write f_EOLBeforeHeader
        default false;
        {-}
  end;{TevCustomTxtReaderCriteria}

  TevTxtReaderCriteria = class(TevCustomTxtReaderCriteria)
    published
    {published properties}
      property RedLineIndent;
         {-}
      property RightIndent;
        {-}
      property CenterIndent;
        {-}
      property TableSpaces;
        {-}
      property SBSSpaces;
        {-}
      property AddSBS;
        {-}
      property EOLBeforeHeader;
        {-}
  end;{TevTxtReaderCriteria}

  TevCustomTxtReader = class(Tk2CustomFileReader)
    private
    {property fields}
      f_Criteria        : TevCustomTxtReaderCriteria;
      f_AnalizeCharSet  : Bool;
      f_AddBlocks       : Bool;
      f_PlainText       : Bool;
      f_Tabs2FirstIndent: Boolean;
      f_DocumentType    : Tk2Type;  
    protected
    {property methods}
      procedure pm_SetCriteria(Value: TevCustomTxtReaderCriteria);
        {-}
      procedure DoText(aText : Tl3String);
        virtual;
        {-}
      function NeedOpenDefaultChild(aText : Tl3String) : Boolean;
        virtual;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    {public methods}
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure Read;
        override;
        {-}
    public
    {public properties}
      property AnalizeCharSet: Bool
        read f_AnalizeCharSet
        write f_AnalizeCharSet
        default true;
        {-}
      property AddBlocks: Bool
        read f_AddBlocks
        write f_AddBlocks
        default false;
        {-}
      property Criteria: TevCustomTxtReaderCriteria
        read f_Criteria
        write pm_SetCriteria;
        {-}
      property PlainText: Bool
        read f_PlainText
        write f_PlainText;
        {-}
      property Tabs2FirstIndent: Boolean
        read f_Tabs2FirstIndent
        write f_Tabs2FirstIndent
        default False;
        {-}
      property DocumentType: Tk2Type
        read f_DocumentType
        write f_DocumentType
        {default k2_idDocument};
        {-}
  end;{TevCustomTxtReader}

  TevTextParser = class(TevCustomTxtReader)
    published
    {published properties}
      property Filer;
        {-}
      property Generator;
        {-}
      property AnalizeCharSet;
        {-}
      property AddBlocks;
        {-}
      property Criteria;
        {-}
      property PlainText;
        {-}
  end;{TevTextParser}

  TevTxtReader = class(TevTextParser);

implementation

uses
  SysUtils,
   
  Classes,

  l3Chars,
  l3Filer,
  l3String,
  l3Parser,
  l3Memory,
  l3Defaults,
  l3Interfaces,

  evdTypes,
  
  evdStyles,
  evSBSTm,

  PageBreak_Const,
  Block_Const,
  TextPara_Const
  ;

{ start class TevCustomTxtReaderCriteria }  

constructor TevCustomTxtReaderCriteria.Create{(anOwner: TObject = nil)};
  {override;}
  {-}
begin
 inherited;
 f_RedLineIndent := 5;
 f_RightIndent := 36;
 f_CenterIndent := 10;
 f_TableSpaces := 5;
 f_SBSSpaces := 10;
 f_AddSBS := true;
 f_Graphics := cc_Graph_Criteria;
end;

procedure TevCustomTxtReaderCriteria.pm_SetTableSpacesCriteria(Value: Long);
  {-}
begin
 if (f_TableSpaces <> Value) then begin
  f_TableSpaces := Value;
  f_SBSSpaces := f_TableSpaces * 2;
 end;{f_TableSpaces <> Value}
end;

{ start class TevCustomTxtReader }

constructor TevCustomTxtReader.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 f_Criteria := TevTxtReaderCriteria.Create{(Self)};
 f_AnalizeCharSet := true;
 f_Tabs2FirstIndent := False;
 f_DocumentType := k2_typDocument;
end;

procedure TevCustomTxtReader.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Criteria);
 inherited;
end;

procedure TevCustomTxtReader.pm_SetCriteria(Value: TevCustomTxtReaderCriteria);
  {-}
begin
 l3Set(f_Criteria, Value);
end;

type
  TevTableStyle = (ev_tsNone, ev_tsFramed, ev_tsSpaced, ev_tsSBS);

  Tev_Para = packed object
    private
    {internal fields}
      Justification : TevIndentType; {-выравнивание}
      Style         : Long;          {-стиль}
      TableStyle    : TevTableStyle; {-стиль таблицы}
  end;//Tev_Para

  TevPara = packed object(Tev_Para) {-параметры параграфа}
    public
    {public methods}
      function  InTable: Bool;
        {-}
      function  InFramedTable: Bool;
        {-}
      function  InSBS: Bool;
        {-}
      function  EQ(const P: Tev_Para): Bool;
        {-}
  end;//TevPara

  TevInParaPrim = packed object(TevPara)
    private
    {internal fields}
      SepPos   : Long; {-позиция первого разделителя}
      SepLen   : Long; {-длина первого разделителя}
      SepCount : Long; {-количество разделителей}
      Text     : Tl3WString;     {-текст параграфа}
      f_Indent : Long;          {-отступ}
    public
    {public methods}
      function  IsEOP: Bool;
        {-}
      function  Empty: Bool;
        {-}
      function  Indent: Long;
        {-}
  end;//TevInParaPrim

  TevOutPara = packed object(TevPara)
    private
    {internal fields}
     Text     : Tl3String;     {-текст параграфа}
     SBSRight : Tl3String;
    public
    {public methods}
      procedure Append(const P: TevInParaPrim);
        {-}
      procedure Add2Text(Generator: Tk2TagGenerator;
                         var InBlock: Bool; AddBlocks: Bool; var BlockHandle: Long);
        {-}
      procedure AddSBS(Generator: Tk2TagGenerator);
        {-}
      procedure AddTextPara(Generator: Tk2TagGenerator);
        {-}
      function  IsEOP: Bool;
        {-}
      function  Empty: Bool;
        {-}
  end;//TevOutPara

  TevInPara = packed object(TevInParaPrim)
    public
    {public methods}
      procedure Read(Filer: Tl3CustomFiler);
        {-}
      procedure AnalizeParam(Criteria       : TevCustomTxtReaderCriteria;
                             const PrevPara : TevOutPara);
        {-}
  end;//TevInPara

function TevPara.InTable: Bool;
  {-}
begin
 Result := (TableStyle <> ev_tsNone);
end;

function TevPara.InSBS: Bool;
  {-}
begin
 Result := (TableStyle = ev_tsSBS);
end;

function TevPara.InFramedTable: Bool;
  {-}
begin
 Result := (TableStyle = ev_tsFramed);
end;

function TevPara.EQ(const P: Tev_Para): Bool;
  {-}
begin
 Result := (Justification = P.Justification) AND
           (Style = P.Style);
end;

// start class TevInParaPrim

function TevInParaPrim.Indent: Long;
  {-}
begin
 if (f_Indent = High(Long)) then
  f_Indent := ev_lpIndent(Text.S, Text.SLen);
 Result := f_Indent;
end;

function TevInParaPrim.Empty: Bool;
  {-}
begin
 Result := l3IsNil(Text);
end;

function TevInParaPrim.IsEOP: Bool;
  {-}
begin
 Result := not l3IsNil(Text) AND (Text.S^ = cc_EOP);
end;

// start class TevInPara

procedure TevInPara.Read(Filer: Tl3CustomFiler);
  {-}
begin
 f_Indent := High(Long);
 Text := Filer.ReadLn;
end;

procedure TevInPara.AnalizeParam(Criteria       : TevCustomTxtReaderCriteria;
                                 const PrevPara : TevOutPara);
  {-}
begin
 Justification := ev_itLeft;
 {-пока устанавливаем выравнивание влево}
 TableStyle := ev_tsNone;
 {-пока вне таблицы}
 Style := Criteria.NormalStyle;
 {-пока устанавливаем "нормальный" стиль}
 if (Text.SCodePage = CP_OEM) AND
    l3CharSetPresent(Text.S, Text.SLen, Criteria.Graphics) then
  TableStyle := ev_tsFramed
 else
 begin
  if ev_lpIsTableLine(Text.S, Text.SLen, Criteria.TableSpaces,
                      SepPos, SepLen, SepCount) then begin
   if Criteria.AddSBS AND (SepCount = 1) AND (SepLen >= Criteria.SBSSpaces) then
    TableStyle := ev_tsSBS
   else
    TableStyle := ev_tsSpaced;
  end else begin
   {-находимся вне таблицы}
   if (Indent > Criteria.CenterIndent) then
   begin
    {-проверяем: может это центрированный параграф}
    if (Indent <= Criteria.RightIndent) then
    begin
     {-а может это прижатый вправо параграф?}
     {-нет - это центрированный параграф}
     if Criteria.EOLBeforeHeader then
     begin
      {-проверять пустую строку перед заголовком ?}
      if PrevPara.Empty OR (PrevPara.Style = ev_saTxtHeader1) then
       Style := ev_saTxtHeader1
      else
      begin
       PrevPara.Text.RTrim;
       if PrevPara.Empty then
        Style := ev_saTxtHeader1
       else
        TableStyle := ev_tsSpaced;
      end;
     end else
      Style := ev_saTxtHeader1;
    end else
     {-да это прижатый вправо параграф}
     Justification := ev_itRight;
   end;{thisPara.Indent > CenterJustifyCriteria}
  end;{ev_lpIsTableLine..}
 end;{DCS = l3_csOEM..}
end;

// start class TevOutPara

function TevOutPara.IsEOP: Bool;
  {-}
begin
 Result := (Text.AsChar = cc_EOP);
end;

function TevOutPara.Empty: Bool;
  {-}
begin
 Result := Text.Empty;
end;

procedure TevOutPara.Append(const P: TevInParaPrim);
  {-}
begin
 if (Text = nil) then
 begin
  Text := Tl3String.Create;
  Text.CodePage := P.Text.SCodePage;
 end;{Text = nil}
 if P.InSBS then
 begin
  Text.AsPCharLen := l3PCharLen(P.Text.S + P.Indent, P.SepPos - P.Indent, P.Text.SCodePage);
  SBSRight := Tl3String.Create;
  SBSRight.CodePage := P.Text.SCodePage;
  SBSRight.AsPCharLen := l3PCharLen(P.Text.S + P.SepPos + P.SepLen,
                                    P.Text.SLen - P.SepPos - P.SepLen,
                                    P.Text.SCodePage);
  SBSRight.CodePage := CP_ANSI;
  SBSRight.TrimAll;
 end//P.InSBS
 else
 begin
  if not P.Empty then
  begin
   if not Text.Empty then
   begin
    if (Text.Last = cc_Hyphen) then
     Text.Shrink(Pred(Text.Len))
    else if (P.Style = ev_saTxtHeader1) then
     Text.Append(cc_SoftEnter)
    else
     Text.Append(cc_HardSpace);
   end;//not Para.Empty
   Text.Append(P.Text);
  end;//not P.Empty
 end;//P.InSBS
 {запоминаем параметры текущего параграфа:}
 Justification := P.Justification;
 Style         := P.Style;
 TableStyle    := P.TableStyle;
 //f_Indent      := P.f_Indent;
end;

procedure TevOutPara.Add2Text(Generator: Tk2TagGenerator;
                              var InBlock: Bool; AddBlocks: Bool; var BlockHandle: Long);
  {-}
begin
 if IsEOP then
 begin
  Generator.StartChild(k2_typPageBreak);
  Generator.Finish;
 end//IsEOP
 else
 begin
  if AddBlocks AND (Style = ev_saTxtHeader1) then
  begin
   if InBlock then Generator.Finish;
   InBlock := true;
   Generator.StartChild(k2_typBlock);
   Inc(BlockHandle);
   Generator.AddIntegerAtom(k2_tiHandle, BlockHandle);
  end;{AddBlocks}
  if InSBS then
   {-внутри параграфа Side By Side}
   AddSBS(Generator)
  else
   {-добавляем текстовый параграф}
   AddTextPara(Generator);
 end;//IsEOP
 l3Free(Text);
end;

procedure TevOutPara.AddSBS(Generator: Tk2TagGenerator);
  {-}
begin
 Text.CodePage := CP_ANSI;
 evSBSTm.OutSBS(Generator, Text, SBSRight);
 l3Free(SBSRight);
end;

procedure TevOutPara.AddTextPara(Generator: Tk2TagGenerator);
  {-}
begin
 Generator.StartChild(k2_typTextPara); {-открываем текстовый параграф}
 try
  Text.RTrim;
  if InTable then begin
   {-внутри таблицы}
   if InFramedTable then
    {-внутри таблицы с рамками}
    Generator.AddIntegerAtom(k2_tiStyle, Style)
   else begin
    {-внутри таблицы без рамок}
    Style := ev_saANSIDOS;
    Generator.AddIntegerAtom(k2_tiStyle, ev_saANSIDOS);
   end;
  end else begin
   {-внутри обычного параграфа}
   if (Style = ev_saTxtNormalOEM) then Style := ev_saTxtNormalANSI;
   if (Justification = ev_itRight) then
    Generator.AddIntegerAtom(k2_tiJustification, Ord(Justification));
    {-добавляем выравнивание параграфа}
   Generator.AddIntegerAtom(k2_tiStyle, Style);
   with Text do begin LTrim; DeleteDoubleSpace; end;
  end;
  if (Style <> ev_saTxtNormalOEM) then
   Text.CodePage := CP_ANSI;
  if not Text.Empty then
   Generator.AddStringAtom(k2_tiText, Text.AsWStr);
  {-добавляем текст параграфа}
 finally
  Generator.Finish; {-закрываем текстовый параграф}
 end;{try..finally}
end;

function TevCustomTxtReader.NeedOpenDefaultChild(aText : Tl3String) : Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

procedure TevCustomTxtReader.DoText(aText : Tl3String);
  //virtual;
  {-}
begin
 AddStringAtom(k2_tiText, aText.AsWStr);
end;
  
procedure TevCustomTxtReader.Read;
  {override;}
  {-}

var
 l_Indent       : Integer;
 prevPara       : TevOutPara; {-предыдущий параграф}
 thisPara       : TevInPara;  {-текущий параграф}
 InBlock        : Bool;
 BlockHandle    : Long;
 BreakPara      : Bool;
 BreakParaChars : TCharSet; {-множество символов, которые в начале строки
                              считаются началом параграфа}
 Parser         : Tl3Parser;
 l_Stream       : Tl3StringStream;
 l_Text         : Tl3String;
 l_WasPara      : Boolean;
begin
 InBlock := false;
 BlockHandle := 0;
 if AnalizeCharSet then Filer.AnalizeCodePage;
 StartChild(f_DocumentType);
 try
  if PlainText then
  begin
   l_WasPara := false;
   while not Filer.EOF do
   begin
    l_WasPara := true;
    l_Text := Tl3String.Make(Filer.ReadLn);
    try
     if NeedOpenDefaultChild(l_Text) then
     begin
      StartDefaultChild;
      try
       if (Filer.CodePage = CP_OEM) then
        AddIntegerAtom(k2_tiStyle, ev_saTxtNormalOEM);
       if f_Tabs2FirstIndent then
       begin
        l_Indent := ev_lpCharset2Indent(l_Text.St, l_Text.Len, [cc_Tab]);
        l_Text.Delete(0, l_Indent);
        AddIntegerAtom(k2_tiFirstIndent, def_FirstIndent * l_Indent);
       end;//f_Tabs2FirstIndent
       DoText(l_Text);
      finally
       Finish;
      end;//try..finally
     end;//NeedOpenDefaultChild..
    finally
     FreeAndNil(l_Text);
    end;//try..finally
   end;//while not Filer.EOF
   if not l_WasPara then
   begin
    StartDefaultChild;
    Finish;
   end;//not l_WasPara
  end//PlainText
  else
  begin
   prevPara.Text := nil;
   try
    Parser := Tl3Parser.Create;
    try
     if (Filer.CodePage = CP_OEM) then
     begin
      Criteria.NormalStyle := ev_saTxtNormalOEM;
      BreakParaChars := [cc_Hyphen, cc_OEMParagraphSign];
      Parser.WhiteSpace := [cc_Null .. #31] - [cc_OEMParagraphSign] - [cc_SoftEnter, cc_HardEnter]
     end
     else
     begin
      Criteria.NormalStyle := ev_saTxtNormalANSI;
      BreakParaChars := [cc_Hyphen, cc_ParagraphSign];
      Parser.WhiteSpace := [cc_Null .. #31] - [cc_SoftEnter, cc_HardEnter];
     end;{CharSet = l3_csOEM}
     repeat
      if (prevPara.Text = nil) then
      begin
       {-разрывать нечего}
       BreakPara := false;
       thisPara.Read(Filer);
       {-читаем следующую строку}
      end//prevPara.Text = nil
      else
      begin
       {-если есть что разрывать}
       thisPara.Read(Filer);
       {-читаем следующую строку}
       l_Stream := Tl3StringStream.Create(thisPara.Text);
       try
        with Parser do
        begin
         CheckFiler.Stream := l_Stream;
         try
          NextToken;
          BreakPara := (TokenType = l3_ttFloat) OR (TokenChar in BreakParaChars);
         finally
          Filer.Stream := nil;
         end;//try..finally
        end;//with Parser
       finally
        l3Free(l_Stream);
       end;{try..finally}
      end;{Para = nil}
      thisPara.AnalizeParam(Criteria, PrevPara);
      {-анализируем параметры строки}
      if (prevPara.Text <> nil) then
      begin
       if prevPara.InSBS AND (thisPara.Justification = ev_itRight) then
       begin
        {-соединяем предыдущий SBS с текущим параграфом прижатым вправо}
        //thisPara.Text.CodePage := CP_ANSI;
        PrevPara.SBSRight.Append(cc_SoftEnter);
        PrevPara.SBSRight.Append(l3Trim(thisPara.Text));
        continue;
        {-переходим к следующему параграфу}
       end//prevPara.InSBS
       else
       begin
        if BreakPara OR
           thisPara.Empty OR prevPara.Empty OR
           thisPara.IsEOP OR prevPara.IsEOP OR
           thisPara.InTable OR prevPara.InTable OR
           not prevPara.EQ(thisPara) OR
           ((thisPara.Indent >= Criteria.RedLineIndent) AND (thisPara.Style <> ev_saTxtHeader1))
          then
         prevPara.Add2Text(Self, InBlock, AddBlocks, BlockHandle);
       end;{prevPara.InSBS..}
      end;{Para <> nil}
      prevPara.Append(thisPara);
      {-добавляем текущий параграф}
     until Filer.EOF;
    finally
     l3Free(Parser);
    end;{try..finally}
   finally
    if (prevPara.Text <> nil) then
     prevPara.Add2Text(Self, InBlock, AddBlocks, BlockHandle);
    if InBlock then begin
     Finish; {-закрываем текущий блок}
     InBlock := false;
    end;{InBlock}
   end;{try..finally}
  end;{PlainText}
 finally
  Finish; {-закрываем документ}
 end;{try..finally}
end;

end.

