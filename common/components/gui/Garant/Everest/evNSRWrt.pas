unit evNSRWrt;
{* Фильтр для записи текста в формате NSRC. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evNSRWrt - генератор текстов в формате NSRC }
{ Начат: 04.10.1999 17:55 }

{$Include evDefine.inc }

{$IfDef evdNeedNSRCWriter}
{$IfDef evExternalProduct}
 !!! Данный модуль не может использоваться в сторонних продуктах !!!
{$EndIf evExternalProduct}
{$EndIf evdNeedNSRCWriter}

interface

{$IfDef evdNeedNSRCWriter}
uses
  l3Chars,
  l3Types,
  l3IID,
  l3InternalInterfaces,
  l3Base,
  l3Filer,
  l3Units,

  k2Types,
  k2Interfaces,
  k2TagGen,

  evdTypes,

  evTypes,
  evNSRCConst,
  evInternalInterfaces,
  evTextFormatter,
  evStyleInterface,
  evNSRCWriterTypes,
  evGeneratorsInterfaces
  ;

const
  evAllLineBrackets : array [0..1] of AnsiChar = (ev_NSRCOutOfDate, ev_NSRCNotApplied);
type
  TevNSRCDivision = record
   Heavy       : Boolean;
   Orientation : TevPageOrientation;
   Extent      : Tl3Point;
  end;//TevNSRCDivision

  TevCustomNSRCWriter = class(TevCustomTextPainter, Il3ObjectWrap)
   {* Фильтр для записи текста в формате NSRC. }
    public
     NeedOutDecorInfo : Boolean;
    private
    {internal fields}
      f_PrevParaStyle        : TevNSRCParaStyle;
      f_SubCount             : Integer;
      f_StringFiler          : Tl3CustomFiler;
      f_String               : Tl3String;
      f_StyleInterface       : TevStyleInterface;
      f_WasShortname         : Boolean;
      f_AddBlocks            : Boolean;
      f_BeforeCommentLetter  : AnsiChar;
      f_CodePage             : Integer;
      f_OutStyle             : Boolean;
      f_PlainText            : Boolean;
      f_SkipPreformatted     : Boolean;
      f_Division             : TevNSRCDivision;
      fHeaderString          : AnsiString;
      f_CheckChar            : AnsiChar; // Символ для проверки в ValidateLine
      f_ExternalDocHandle    : Integer;
    protected
     f_Handle                : Integer;                {  }
     f_CurParaParas          : TevNSRCParaParas;
    public 
     InternalHandle        : Integer;                {  }
     NeedCorrect : Boolean;
    private
    //event fields
      f_OnOutSub       : Tl3OutExtLongEvent;
      f_OnOutBlock     : Tl3OutExtLongEvent;
      f_OnOutHyperlink : Tl3OutExtLongEvent;
      f_OnOutShortname : TevOutExtStringEvent;
     f_SkipInvalidPictures: Boolean;
    {$IFDEF evUseEvdStyleOnly}
    private
      function NeedEmptyPara: Boolean;
       {* - Проверяет нужно ли пустому параграфу присваивать стиль. }
      function IsTechComment(aPrevStyle: Boolean): Boolean;
       {-}
    {$ENDIF evUseEvdStyleOnly}  
    protected
    {property methods}
      function  pm_GetStringFiler: Tl3CustomFiler;
        {-}
    protected
    {internal methods}
      procedure SaveObjFileName(const aFileName: AnsiString); virtual;
      procedure SetExternalDocHandle(anID: Integer);
      procedure CheckDigitalSeparatorAlignment; virtual;
        {-}
      procedure CheckNeed2AddBlock; virtual;
        {-}
      function  GetObject: TObject;
        {* - получить объект из обертки. }
      procedure OutText(S: Tl3CustomString);
        override;
        {-}
      procedure OutTextStyle(anEmpty   : Boolean;
                             aCodePage : Integer;
                             out anInsertSemeColon: Boolean);
      procedure AnalizeStyle(StHandle: Integer);
        {-}
      procedure OutSub(SubHandle: Integer);
        {-}
      function NeedOutSub: Boolean;
       virtual;
        {-}
      procedure OutStyle4Cell;
       virtual;
        {-}
      procedure OutSubInt(SubHandle: Integer);
       {-}
      procedure OpenBlock(BlockHandle: Integer);
        {-}
      procedure CloseBlock;
        {-}
      procedure DoOutSub(SubHandle: Integer);
        virtual;
        {* - процедура записи Sub'а. Может быть перекрыта в потомках. }
      procedure DoOutBlock(BlockHandle: Integer);
        virtual;
        {* - процедура записи блока. Может быть перекрыта в потомках. }
      procedure DoOutShortName(Name: Tl3CustomString);
        virtual;
        {* - процедура записи короткого названия документа. Может быть перекрыта в потомках. }
      procedure OutShortName(Name: Tl3CustomString);
        {-}
      procedure _Msg2Log(Msg: AnsiString);
        virtual;
      procedure DoOutHyperlinkEx(Ob: Tl3Variant; var S: AnsiString);
        virtual;
        {* - процедура записи гиперссылки. Может быть перекрыта в потомках. }
      procedure DoOutHyperlink(Ob: Tl3Variant; var S: AnsiString);
        virtual;
        {* - процедура записи гиперссылки. Проверяет наличие Handle и вызывает DoOutHyperlinkEx. Может быть перекрыта в потомках. }
      function  IsMarkStyle(aParaVisible        : Boolean;
                            aParaStyle          : Integer;
                            aStyledObject : Tl3Variant;
                            aText: Tl3String;
                            out Open, Close     : AnsiString;
                            var DeleteText      : Boolean): Boolean;
        override;
        {-}
      function IsStyleEqual(aParaStyle: Integer; aSegmentStyle: Integer): Boolean;
        override;
        {-}
      procedure ValidateLine(aLine : Tl3String; aCodePage : Integer);
        override;
        {* - процедура для проверки корректности строки. }
      function GetHeader : AnsiString;
        {* - Генерит строку - заголовок. }
      procedure OutHeader;
        {* - записывает шапку NSRC файла. }
      procedure Cleanup;
        override;
        {-}
      procedure CloseStream(NeedUndo: Boolean);
        override;
        {-вызывается один раз в конце генерации}
      procedure CloseStructure(NeedUndo: Boolean);
        override;
        {-вызывается на закрывающуюся скобку}
      procedure ClearPrevPara;
        {-}
      procedure ClearCurParaParam;
        {-}
      procedure ClearCurPara;
        {-}
      procedure ClearBothParas;
        {-}
      procedure OutPageBreak;
      procedure SetOutCodePage(aString: Tl3CustomString; aCodePage: Integer);
        {-}
     procedure ValidateText(aText: Tl3String; aValidateText: Tl3String = nil);
      override;
       {-}
    protected
    {properted properties}
      property StringFiler: Tl3CustomFiler
        read pm_GetStringFiler;
        {* - временный поток для записи параметров разлицных тегов. }
    public
    {public methods}
        {-}
      constructor Create(AOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure StartChild(TypeID: Tl3Type);
        override;
        {-}
      procedure StartTag(TagID: Integer);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
        override;
      procedure ClearPP;
      procedure ClearPPBetweenDoc;
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
    public
    {public properties}
      property AddBlocks: Boolean
        read f_AddBlocks
        write f_AddBlocks
        default false;
        {* - записывть блоки? }
      property CodePage: Integer
        read f_CodePage
        write f_CodePage
        default CP_OEM;
        {* - кодировка в которой записывать строки. }
      property OutStyle: Boolean
        read f_OutStyle
        write f_OutStyle
        default true;
        {-}
      property PlainText: Boolean
        read f_PlainText
        write f_PlainText
        default false;
        {-}
     property SkipInvalidPictures: Boolean
        read f_SkipInvalidPictures
        write f_SkipInvalidPictures;
        {-}
      property SkipPreformatted: Boolean
        read f_SkipPreformatted
        write f_SkipPreformatted
        default false;
        {-}
    public
    {public events}
      property OnOutSub: Tl3OutExtLongEvent
        read f_OnOutSub
        write f_OnOutSub;
        {* - событие для записи Sub'а. }
      property OnOutBlock: Tl3OutExtLongEvent
        read f_OnOutBlock
        write f_OnOutBlock;
        {* - событие для записи блока. }
      property OnOutHyperlink: Tl3OutExtLongEvent
        read f_OnOutHyperlink
        write f_OnOutHyperlink;
        {* - событие для записи гиперссылки. }
      property OnOutShortname: TevOutExtStringEvent
        read f_OnOutShortname
        write f_OnOutShortname;
        {* - событие для записи короткого названия документа. }
  end;{TevCustomNSRCWriter}
  {* Фильтр для записи текста в формате NSRC. Предполагает перед собой наличие фильтра TevCustomTextFormatter. }

  TevNSRCGenerator = class(TevCustomNSRCWriter)
   {*! Фильтр для записи текста в формате NSRC. Для конечного использования. }
    published
    {published properties}
      property Filer;
        {-}
      property AddBlocks;
        {-}
      property CodePage;
        {-}
    published
    {published events}
      property OnOutSub;
        {-}
      property OnOutBlock;
        {-}
      property OnOutHyperlink;
        {-}
      property OnOutShortname;
        {-}
  end;{TevNSRCGenerator}

  TevNSRCWriter = class(TevNSRCGenerator);
  
const
                                 {'0.11';}
                                 {'04/10/1999'; {-TevCustomNSRCGenerator перенесен в этот
                                                  модуль из evTxtExp и переименован в
                                                  TevCustomNSRCWriter}
                                 {'23/12/1999'; {-добавлена выливка текущей даты
                                                  в шапке файла}
                                 {'27/01/2000'; {-добавлена выливка ev_saArticleHeader}
                                 {'25/02/2000'; {-добавлена выливка k2_tiComment}
                                 {'0.13' '08/06/2000'; {-Pixel2Char(evCm2Pixel(def_cmParaWidth)) -> 73}
  {'0.14' '26/07/2000'; {-добавлена выливка ev_saToLeft}
  evNSRCGeneratorCurVersion    =  '0.34';
   {* - текущая версия NSRC генератора. }
  evNSRCGeneratorRevisionDate  =  '26/05/2008';
   {* - дата текущей ревизии NSRC генератора. }
{$EndIf evdNeedNSRCWriter}

implementation

{$IfDef evdNeedNSRCWriter}
uses
  Classes,
  SysUtils,
  StrUtils,

  l3Variant,
  l3Except,
  l3MinMax,
  l3Const,
  l3String,
  l3Memory,
  l3Interfaces,
  l3BaseStream,
  l3Stream,
  l3FileUtils,
  
  k2Tags,
  k2Base,

  evdVer,
  evdConst,
  
  evDef,
  evdStyles,

  evSectionPara,
  
  evNSRCCharSkipper,
  evNSRStringFormatter,
  //evSegmentFontSizeEliminator,

  Para_Const,
  Document_Const,
  Block_Const,
  TextPara_Const,
  DecorTextPara_Const,
  PageBreak_Const,
  SectionBreak_Const,
  PageProperties_Const,
  Hyperlink_Const,
  Segment_Const,
  ObjectSegment_Const,
  Formula_Const,
  Bookmark_Const,
  Sub_Const,
  DocumentSub_Const,
  BitmapPara_Const,
  ddConst,
  imageenio,
  evdNativeWriter,
  k2BaseTypes,
  evdTxtConst,

  l3StringEx,

  vtDebug
  ;

// start class TevCustomNSRCWriter

const
 PreformattedLetter = 'P';
 SBSLetter          = 'S';
 TechCommentLetter  = cc_SemiColon;
 VersionInfoLetter  = 'V';
 NilLetter          = cc_Null;
 NewSchoolStyleLetter = '#';

procedure TevCustomNSRCWriter.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_StyleInterface);
 inherited;
end;

function TevCustomNSRCWriter.GetHeader : AnsiString;
var
 lTitle : Tl3String;
begin
 if Length(fHeaderString) = 0 then
 begin
  lTitle := Tl3String.Create;
   try
    lTitle.AsString := l3System.AppTitle;
    SetOutCodePage(lTitle, CodePage);
    Assert(evFormatCurVersionS <> '');
    fHeaderString := ';%Producer ' + cc_SingleQuote + lTitle.AsString + cc_SingleQuote + cc_EOL +
                     ';%NSRC generator version ' + evNSRCGeneratorCurVersion + ' revision date ' +
                      evNSRCGeneratorRevisionDate + cc_EOL +
                     ';%Everest format version ' + evFormatCurVersionS + cc_EOL +
                     ';%Generation date ' + DateToStr(Date);
   finally
    l3Free(lTitle);
   end;{try..finally}
 end;
 Result := fHeaderString;
end;

procedure TevCustomNSRCWriter.OutHeader;
  {-}
var
 Title : Tl3String;
begin
 if (Filer.Pos = 0) then
 begin
  OutEOL;
  if not PlainText then
   OutString(GetHeader);
 end;
end;

constructor TevCustomNSRCWriter.Create(AOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 CodePage := CP_OEM;
 OutStyle := true;
 SkipInvalidPictures := false;
 NeedOutDecorInfo := false;
end;

procedure TevCustomNSRCWriter.StartChild(TypeID: Tl3Type);
  {override;}
  {-}
var
 CT : Tk2TypePrim;
begin
 inherited;
 CT := CurrentType;
 if CT.IsKindOf(k2_typPara) then
 begin
  if CT.IsKindOf(k2_typDocument) then
  begin
   if (TopType[1] = nil) then
    // - учитываем вложенные документы
    f_WasShortname := false;
   f_BeforeCommentLetter := NilLetter;
   ClearBothParas;
  end//CT.IsKindOf(k2_typDocument)
  else
  if CT.IsKindOf(k2_typBlock) then
  begin
   OutShortname(nil);
   ClearBothParas;
  end//CT.IsKindOf(k2_typBlock)
  else
  if CT.IsKindOf(k2_typTextPara) then
  begin
   OutShortname(nil);
   f_BeforeCommentLetter := f_PrevParaStyle.Letter;
   f_PrevParaStyle := f_CurParaParas.Style;
   ClearCurPara;
   { TODO -oЖучков А. -cРазвитие : Проверить правильность! }
   f_CurParaParas.Style.IsDecorPara := CT.IsKindOf(k2_typDecorTextPara);
  end//CT.IsKindOf(k2_typTextPara)
  else
  if CT.IsKindOf(k2_typPageBreak) then
  begin
   OutShortname(nil);
   with f_Division do
   begin
    Heavy := CT.IsKindOf(k2_typSectionBreak);
    if Heavy then
    begin
     with Tk2TypePrim(CT.Prop[k2_tiParas].AtomType) do
     begin
      Orientation := TevPageOrientation(Tk2Prop(Prop[k2_tiOrientation]).DefaultValue);
      Extent.X := Tk2Prop(Prop[k2_tiWidth]).DefaultValue;
      Extent.Y := Tk2Prop(Prop[k2_tiHeight]).DefaultValue;
     end;//with CT.Prop[k2_tiParas]
    end;//Heavy
   end;//with f_Division
   ClearBothParas;
  end;//..k2_idPageBreak..
 end;//..k2_idPara..
end;

procedure TevCustomNSRCWriter.StartTag(TagID: Integer);
  //override;
  {-}
var
 CT : Tk2TypePrim;
begin
 inherited;
 CT := CurrentType;
 if CT.IsKindOf(k2_typPageProperties) then
 begin
  with f_Division do
  begin
   with CT do
   begin
    Orientation := TevPageOrientation(Tk2Prop(Prop[k2_tiOrientation]).DefaultValue);
    Extent.X := Tk2Prop(Prop[k2_tiWidth]).DefaultValue;
    Extent.Y := Tk2Prop(Prop[k2_tiHeight]).DefaultValue;
   end;//with CT
  end;//with f_Division
 end;//..k2_idPageProperties..
end;

procedure TevCustomNSRCWriter.CloseStream(NeedUndo: Boolean);
  {override;}
  {-вызывается один раз в конце генерации}
begin
 l3Free(f_String);
 l3Free(f_StringFiler);
 inherited;
end;

procedure TevCustomNSRCWriter.CloseStructure(NeedUndo: Boolean);
  {override;}
  {-вызывается на закрывающуюся скобку}
var
 CT : Tk2TypePrim;  
begin
 CT := CurrentType;
 if CT.IsKindOf(k2_typPara) then
 begin
  if CT.IsKindOf(k2_typDocument) then
  begin
   if (TopType[1] = nil) then
   begin
    // - учитываем вложенные документы
    OutShortname(nil);
    f_ExternalDocHandle := 0;
    ClearPPBetweenDoc;
   end;//TopType[1] = nil
  end//k2_idDocument
  else
  if CT.IsKindOf(k2_typBlock) then
  begin
   ClearBothParas;
   CloseBlock;
  end//..k2_idBlock..
  else
  if CT.IsKindOf(k2_typTextPara) then
   ClearCurParaParam
   {..k2_idTextPara..}
  else
  if CT.IsKindOf(k2_typPageBreak) then
  begin
   OutPageBreak;
  end;//..k2_idPageBreak..
 end;{k2_idPara..}
 inherited;
end;

procedure TevCustomNSRCWriter.ClearPrevPara;
  {-}
begin
 f_PrevParaStyle.Clear;
end;

procedure TevCustomNSRCWriter.ClearCurParaParam;
  {-}
begin
 f_CurParaParas.Clear;
 f_SubCount := 0;
end;

procedure TevCustomNSRCWriter.ClearCurPara;
  {-}
begin
 f_CurParaParas.Style.Clear;
 ClearCurParaParam;
end;

procedure TevCustomNSRCWriter.ClearBothParas;
  {-}
begin
 ClearPrevPara;
 ClearCurPara;
end;

procedure TevCustomNSRCWriter.OutPageBreak;
  {-}
var
 l_PaperSizeName : AnsiString;
begin
 OutEOL;
 OutString('!DIVISION');
 with f_Division do
 begin
  if Heavy then
  begin
   case Orientation of
    ev_poPortrait:
     OutString(' P');
    ev_poLandscape:
     OutString(' L');
    else
     Assert(false); 
   end;//Case rOrientation
   l_PaperSizeName := evGetPaperSizeName(Extent);
   if (l_PaperSizeName = 'Custom') then
    l_PaperSizeName := 'A4';
   OutString(' ');
   OutString(l_PaperSizeName);
  end;//Heavy
 end;//with f_Division
end;
  
function  TevCustomNSRCWriter.pm_GetStringFiler: Tl3CustomFiler;
  {-}
var
 l_Stream : Tl3StringStream;
begin
 if (f_StringFiler = nil) then
 begin
  f_String := Tl3String.Create;
  l_Stream := Tl3StringStream.Create(f_String);
  try
   f_StringFiler := Tl3CustomFiler.Create{$IfDef k2GeneratorIsComponent}(Self){$EndIf};
   f_StringFiler.Stream := l_Stream;
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 end;//f_StringFiler = nil
 Result := f_StringFiler;
end;

procedure TevCustomNSRCWriter.OutText(S: Tl3CustomString);
  {override;}
  {-}
var
 {$IFDEF evUseEvdStyleOnly}
 l_CodePage      : Integer;
 l_EmptyText     : Boolean;
 l_InsertSemiCol : Boolean;
 {$ELSE}
 l_Suffix        : AnsiString;
 l_OutStyle      : Boolean;
 l_CodePage      : AnsiString;
 l_PrintFontSize : AnsiString;
 {$ENDIF evUseEvdStyleOnly}
begin
 CheckDigitalSeparatorAlignment;
 {$IFDEF evUseEvdStyleOnly}
 l_EmptyText := S.Empty;
 l_CodePage := S.CodePage;
 OutTextStyle(l_EmptyText, l_CodePage, l_InsertSemiCol);
 if l_InsertSemiCol then
  S.Insert(cc_SemiColon, 0);
 {$ELSE}
 with f_CurParaParas.Style do
 begin
  if S.Empty
     and (Letter <> TechCommentLetter)
     and (Letter <> NewSchoolStyleLetter)
     then
   Letter := NilLetter
  else
  begin
   Case Letter of
    NilLetter:
    begin
     l_OutStyle := false;
     if (f_PrevParaStyle.Letter = TechCommentLetter) AND not S.Empty then
     begin
      S.Insert(cc_SemiColon, 0);
      Letter := TechCommentLetter;
     end;//f_PrevParaStyle.Letter = TechCommentLetter
    end;//NilLetter
    PreformattedLetter:
    begin
     if (S Is TevSBSString) then
     begin
      Letter := SBSLetter;
      ParaLI := 0;
      ParaFI := 0;
      ParaWC := 73; // 08.06.2000 Pixel2Char(evCm2Pixel(def_cmParaWidth));
     end;{S Is TevSBSString}
     if (f_SubCount > 0) OR (Letter = SBSLetter) then
      l_OutStyle := true
     else
     begin
      if (f_PrevParaStyle.Letter = TechCommentLetter) AND
         (Letter = f_BeforeCommentLetter) then
      begin
       l_OutStyle := true;
       // - тут вообще говоря был пустой код
       //Assert(false, 'А попадаем ли мы сюда?');
       // http://mdp.garant.ru/pages/viewpage.action?pageId=336664105&focusedCommentId=342337450#comment-342337450
       // ПОПАДАЕМ - http://mdp.garant.ru/pages/viewpage.action?pageId=342865677
      end//f_PrevParaStyle.Letter = TechCommentLetter
      else
      if not EQ(f_PrevParaStyle) then
       l_OutStyle := true
      else
      begin
       l_OutStyle := false;
       // - тут вообще говоря был пустой код
       //Assert(false, 'А попадаем ли мы сюда?');
       // http://mdp.garant.ru/pages/viewpage.action?pageId=336664105&focusedCommentId=342337450#comment-342337450
       // - тестами выяснилось, что попадаем и что похоже, что эта ветка про то,
       //   что стиль текущего параграфа совпадает со стилем предыдущего и значит
       //   его - не нужно писать
      end;//not EQ(f_PrevParaStyle)
     end;//f_SubCount > 0
    end;//PreformattedLetter
    TechCommentLetter:
    begin
     l_OutStyle := false;
     //if not S.Empty then
      S.Insert(cc_SemiColon, 0);
    end;//TechCommentLetter
    else
     l_OutStyle := true;
   end;//Case Letter
   l_CodePage := '';
   if S.Empty then
   begin
    if (Letter <> NewSchoolStyleLetter) then
    begin
     l_OutStyle := false;
     Letter := NilLetter;
    end;//Letter <> NewSchoolStyleLetter
   end//S.Empty
   else
   if (Letter <> NilLetter) and (CodePage = CP_KeepExisting) then
   begin
     if ((S.CodePage = CP_TatarOEM) OR (S.CodePage = CP_Tatar)) then
     begin
      Assert(S.CodePage <> CP_Tatar, 'Как-то странно тут говорить про OEM или мы директивно к OEM потом приводим?');
      l_OutStyle := true;
      l_CodePage := ' CP_TatarOEM';
    end//S.CodePage = CP_TatarOEM
    else
    if l3IsOEMEx(S.CodePage) then
    begin
     // - ничего не делаем
    end//l3IsOEMEx(S.CodePage)
    else
    if l3IsANSI(S.CodePage) then
    begin
     // - ничего не делаем
    end//l3IsANSI(S.CodePage)
    else
    if (S.CodePage = CP_EastEurope) then
    begin
     l_OutStyle := true;
     l_CodePage := ' CP_EastEurope';
    end//S.CodePage = CP_EastEurope
    else
     Assert(false, 'Кодировка параграфа: ' + IntToStr(S.CodePage));
   end;//(Letter <> NilLetter) and (CodePage = CP_KeepExisting)
   if SkipPreformatted AND
     ((Letter = PreformattedLetter) OR (Letter = SBSLetter)) then
    Exit;
   if OutStyle AND l_OutStyle then
   begin
    OutEOL;
    if IsDecorPara then
     l_Suffix := 'A'
    else
     l_Suffix := '';
    if (PrintFontSize > 0) AND
       (PrintFontSize <> 12) AND
       (Letter = PreformattedLetter) then
     l_PrintFontSize := ' H' + IntToStr(PrintFontSize)
    else
     l_PrintFontSize := '';
    if (Letter = NewSchoolStyleLetter) then
     OutString(Format('!STYLE%s %s%d%s%s', [l_Suffix,
                                             Letter,
                                             StyleID,
                                             l_CodePage,
                                             l_PrintFontSize]))
    else
     OutString(Format('!STYLE%s %s %d %d %d%s%s', [l_Suffix,
                                             Letter,
                                             Max(0, ParaLI),
                                             Min(ParaWC, 73),
                                             Max(0, ParaFI),
                                             l_CodePage,
                                             l_PrintFontSize]));
   end;//l_OutStyle
  end;//not S.Empty
 end;//with f_CurParaParas.Style
 if PlainText then
 begin
  if (f_CurParaParas.Style.Letter = TechCommentLetter) then
   Exit;
 end;//PlainText
 SetOutCodePage(S, CodePage);
 if (CodePage = CP_KeepExisting) then
  Assert(S.IsOEMEx OR (S.CodePage = CP_EastEurope));
 {$ENDIF evUseEvdStyleOnly}
 inherited;
end;

function TevCustomNSRCWriter.GetObject: TObject;
  {* - получить объект из обертки. }
begin
 Result := Self;
end;

procedure TevCustomNSRCWriter.AnalizeStyle(StHandle: Integer);
  {-}
var
 St : Tl3Variant;
 IT : TevIndentType;
begin
 with f_CurParaParas.Style do
 begin
  if (Letter = NilLetter) then
  begin
   if (f_StyleInterface = nil) then
    f_StyleInterface := TevStyleInterface.Create;
   f_StyleInterface.SelectStyledObjectType(CurrentType);
   St := f_StyleInterface.SelectStyle(StHandle);
   {$IFDEF evUseEvdStyleOnly}
   if (f_CurParaParas.LeftIndent <> l3NilLong) and (f_CurParaParas.LeftIndent <> Pixel2Char(St.IntA[k2_tiLeftIndent])) then
    ParaLI := f_CurParaParas.LeftIndent
   else
    ParaLI := l3NilLong;
   {$ELSE}
   if (f_CurParaParas.FirstIndent = l3NilLong) then
    ParaFI := Pixel2Char(St.IntA[k2_tiFirstIndent])
   else
    ParaFI := f_CurParaParas.FirstIndent;
   if (f_CurParaParas.LeftIndent = l3NilLong) then
    ParaLI := Pixel2Char(St.IntA[k2_tiLeftIndent])
   else
    ParaLI := f_CurParaParas.LeftIndent;
   if (f_CurParaParas.Width = l3NilLong) then
    ParaWC := Pixel2Char(St.IntA[k2_tiWidth])
   else
    ParaWC := f_CurParaParas.Width;
   {$ENDIF evUseEvdStyleOnly}
   StyleID := 0; 
   Case StHandle of
    ev_saTxtHeader1 
    {$IF Defined(evUseEvdStyleOnly) OR Defined(evOutDecorToNSRC)},
    {$ELSE}:
     IT := ev_itCenter;
    {$IfEnd}
    {$If Defined(evOutDecorToNSRC)}
    ev_saEnclosureHeader,
    {$IfEnd}
    ev_saTxtHeader2,
    ev_saTxtHeader3, ev_saTxtHeader4:
    begin
     ParaLI := 0;
     StyleID := -StHandle;
     ParaWC := 0;
     ParaFI := 0;
     Letter := NewSchoolStyleLetter;
     Exit;
    end;//ev_saTxtHeader2..
    ev_saTxtNormalOEM, ev_saANSIDOS:
    begin
     {$IFDEF evUseEvdStyleOnly}
     StyleID := -StHandle;
     ParaWC := 0;
     ParaFI := 0;
     ParaLI := 0;
     Letter := NewSchoolStyleLetter;
     {$ELSE}
     IT := ev_itPreformatted;
     ParaLI := 0;
     ParaWC := 73; // 08.06.2000 Pixel2Char(evCm2Pixel(def_cmParaWidth)); {!!! 22.12.1998 255->73}
     {$ENDIF evUseEvdStyleOnly}
     ParaFI := 0;
    end;{ev_saTxtNormalOEM, ev_saANSIDOS}
    {$IFNDEF evUseEvdStyleOnly}
    ev_saTechComment :
    begin
     Letter := TechCommentLetter;
     Exit;
    end;//ev_saTechComment
    ev_saVersionInfo :
    begin
     Letter := VersionInfoLetter;
     Exit;
    end;//ev_saVersionInfo
    {$ENDIF evUseEvdStyleOnly}
    else
    begin
     {$IFNDEF evUseEvdStyleOnly}
     if (StHandle <= ev_saHLE1) then
     {$ENDIF evUseEvdStyleOnly}
     begin
     {$IFNDEF evUseEvdStyleOnly}
      if (StHandle <= ev_saHLE1) then ParaLI := 0;
     {$ENDIF evUseEvdStyleOnly}
      StyleID := -StHandle;
      ParaWC := 0;
      ParaFI := 0;
      Letter := NewSchoolStyleLetter;
     {$IFNDEF evUseEvdStyleOnly}
      Exit;
     {$ENDIF evUseEvdStyleOnly}
     end//StHandle <= ev_saHLE1
     {$IFNDEF evUseEvdStyleOnly}
     else
     begin
      if (f_CurParaParas.Justification = ev_itNone) then
       IT := TevIndentType(St.IntA[k2_tiJustification])
      else
       IT := f_CurParaParas.Justification;
     end;//StHandle <= ev_saHLE1
     {$ENDIF evUseEvdStyleOnly}
    end;//else
   end;//Case StHandle
   {$IFDEF evUseEvdStyleOnly}
   if (TevIndentType(St.IntA[k2_tiJustification]) = f_CurParaParas.Justification) then
    IT := ev_itNone
   else
    IT := f_CurParaParas.Justification;
   {$ENDIF evUseEvdStyleOnly}
   Case IT of
    ev_itLeft         : Letter := 'L';
    ev_itRight        : Letter := 'R';
    ev_itWidth        : Letter := 'J';
    ev_itCenter       : Letter := 'C';
   {$IFNDEF evUseEvdStyleOnly}
    ev_itPreformatted : Letter := PreformattedLetter;
    ev_itNone         : Letter := PreformattedLetter;
   {$ENDIF evUseEvdStyleOnly}
   end;{Case IT}
  end;{Letter = NilLetter}
 end;
end;

procedure TevCustomNSRCWriter.OutSub(SubHandle: Integer);
  {-}
begin
 Inc(f_SubCount);
 if NeedOutSub then
 begin
  OutEOL;
  OutSubInt(SubHandle);
 end;
end;

procedure TevCustomNSRCWriter.OpenBlock(BlockHandle: Integer);
  {-}
begin
 if AddBlocks then begin
  OutEOL;
  OutString(Format('!BLOCK %d', [BlockHandle]));
  ClearPrevPara;
  DoOutBlock(BlockHandle);
 end;{AddBlocks}
end;

procedure TevCustomNSRCWriter.CloseBlock;
  {-}
begin
 if AddBlocks then begin
  OutEOL;
  OutString('!BLOCKEND');
  ClearPrevPara;
 end;{AddBlocks}
end;

procedure TevCustomNSRCWriter.DoOutSub(SubHandle: Integer);
  {virtual;}
  {-}
begin
 if Assigned(f_OnOutSub) then f_OnOutSub(Self, SubHandle, Filer);
end;

procedure TevCustomNSRCWriter.DoOutBlock(BlockHandle: Integer);
  {virtual;}
  {-}
begin
 if Assigned(f_OnOutBlock) then f_OnOutBlock(Self, BlockHandle, Filer);
end;

procedure TevCustomNSRCWriter.DoOutShortName(Name: Tl3CustomString);
  {virtual;}
  {-}
begin
 if Assigned(f_OnOutShortname) then f_OnOutShortname(Self, Name, Filer);
end;

procedure TevCustomNSRCWriter.OutShortName(Name: Tl3CustomString);
  {-}
begin
 if not f_WasShortname then begin
  OutHeader;
  f_WasShortname := true;
  DoOutShortname(Name);
 end;
end;

const
  NSRCBrackets : array [TevStandardStylesNSRC] of AnsiChar =
   (
     #0,                    { ev_saTxtNormalANSI  - 'Нормальный (ANSI)'                   }
     #0,                    { ev_saTxtNormalOEM   - 'Нормальный (OEM)'                    }
     ev_NSRCHeader,         { ev_saTxtHeader1     - 'Заголовок 1'                         }
     #0{ev_NSRCHeader},         { ev_saTxtHeader2     - 'Заголовок 2'                         }
     #0{ev_NSRCHeader},         { ev_saTxtHeader3     - 'Заголовок 3'                         }
     #0{ev_NSRCHeader},         { ev_saTxtHeader4     - 'Заголовок 4'                         }
     ev_NSRCOutOfDate,      { ev_saTxtOutOfDate   - 'Утратил силу'                        }
     ev_NSRCHyperlink,      { ev_saHyperLink      - 'Гипертекстовая ссылка'               }
     ev_NSRCComment,        { ev_saTxtComment     - 'Комментарий'                         }
     ev_NSRCColorSelection, { ev_saColorSelection - 'Цветовое выделение'                  }
     ev_NSRCHyperlinkCont,  { ev_saHyperLinkCont  - 'Продолжение ссылки'                  }
     #0,                    { ev_saANSIDOS        - 'Моноширинный (ANSI)'                 }
     #0,                    {ev_saFoundWords      - Найденные слова.                      }
     #0,                    {ev_saNormalNote      - Нормальный (справка).                 }
     #0,                    {ev_saArticleHeader   - Заголовок статьи.                     }
     #0,                    {ev_saToLeft          - Прижатый влево.                       }
     #0,                    {ev_saNormalTable     - Нормальный для таблиц.                }
     #0,                    {ev_saNormalSBSLeft   - Нормальный для левых частей SBS.      }
     #0,                    {ev_saNormalSBSRight  - Нормальный для правых частей SBS.     }
     #0,                    {ev_saNormalTableList - нормальный для списков в виде таблиц. }
     #0,                    {ev_saTechComment     - технический комментарий.              }
     ev_NSRCComment,        {ev_saVersionInfo     - информация о версии.                  }
     #0,                    {ev_saUserComment     - комментарий пользователя (для Гаранта 6х). }
     #0,                    {ev_saContents        - оглавление (для Гаранта 6х).          }
     ev_NSRCNotApplied,     {ev_saNotApplied      - не вступил в силу.                    }
     #0,                    {ev_saDictEntry       - Словарная статья.                     }
     #0,                    {ev_saHFLeft          - колонтитул (левый).                   }
     #0,                    {ev_saHFRight         - колонтитул (правый).                  }
     #0,
     #0,                    {ev_saNormalAnno      - нормальный для аннотаций.             }
     #0,                    // ev_saMainMenuConstPath
     #0,                    // ev_saMainMenuChangePath
     #0,                    // ev_saMainMenuHeader
     #0,                    // ev_saMainMenuInteractiveHeader
     ev_NSRCFormula,        // ev_saObject        - псевдо-стиль, для объектных сегментов
     #0,                    // ev_saMistake       - Слово с опечаткой.
     ev_NSRCColorSelection  // ev_saEnclosureHeader - Заголовок приложения.
   );
const
 cDecor = evNSRCConst.cDecor;
 cDecorEx = evNSRCConst.cDecorEx;

procedure TevCustomNSRCWriter._Msg2Log(Msg: AnsiString);
begin
end;

procedure TevCustomNSRCWriter.DoOutHyperlinkEx(Ob: Tl3Variant; var S: AnsiString);
  {virtual;}
  {-}

var
 OutComma : Boolean;

 function OutAddress(anAddress: Tl3Variant; Index: Integer): Boolean; far;
 var
  DocID, SubID : Integer;
 begin
  if OutComma then
   S := S + {cc_Comma + }cc_HardSpace
  else
   OutComma := true;
  with anAddress do begin
   with Attr[k2_tiDocID] do
    if IsValid then
     DocID := AsLong
    else
     DocID := 0;
   with Attr[k2_tiSubID] do
    if IsValid then
     SubID := AsLong
    else
     SubID := 0;
  end;//with anAddress
  S := S + IntToStr(DocID);
  if (SubID <> 0) then
   S := S + cc_Dot + IntToStr(SubID);
  Result := true;
 end;

var
 SF       : Tl3CustomFiler;
 l_Handle : Integer;
begin
 if Assigned(f_OnOutHyperlink) then
 begin
  with Ob.Attr[k2_tiHandle] do
   if IsValid then
    l_Handle := AsLong
   else
    l_Handle := 0;
  if Assigned(f_OnOutHyperlink) then
  begin
   SF := StringFiler;
   with SF.Stream do
   begin
    Seek(0, soBeginning);
    Size := 0;
   end;//with SF.Stream
   f_OnOutHyperlink(Self, l_Handle, SF);
   S := S + f_String.AsString;
  end//Assigned(f_OnOutHyperlink)
  else
   {S := S + IntToStr(l_Handle)};
   // - так нельзя, т.к. l_Handle это не адрес !
 end//Assigned(f_OnOutHyperlink)
 else
 begin
  OutComma := false;
  with Ob.Attr[k2_tiChildren] do
   if IsValid then
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@OutAddress))
   else with Ob.Attr[k2_tiHandle] do
    if IsValid then
     _Msg2Log(Format('Topic #%d > Пустая ссылка %d', [f_Handle, AsLong]))
    else
     _Msg2Log('Совсем плохо - ссылка без Handle');
 end;//Assigned(f_OnOutHyperlink)
end;

procedure TevCustomNSRCWriter.DoOutHyperlink(Ob: Tl3Variant; var S: AnsiString);
  {virtual;}
  {-}
begin
 if Ob.IsKindOf(k2_typHyperlink) AND
    (not Ob.HasSubAtom(k2_tiStyle) OR (Ob.IntA[k2_tiStyle] = ev_saHyperLink))  
    {AND Ob.HasSubAtom(k2_tiHandle)} then
 begin
  DoOutHyperlinkEx(Ob, S);
  S := S + NSRCBrackets[-ev_saHyperlink];
 end;{..k2_idHyperlink..}
end;

function TevCustomNSRCWriter.IsMarkStyle(aParaVisible        : Boolean;
                                         aParaStyle          : Integer;
                                         aStyledObject       : Tl3Variant;
                                         aText: Tl3String;
                                         out Open, Close     : AnsiString;
                                         var DeleteText      : Boolean): Boolean;
  {override;}
  {-}

 {$IfDef evOutDecorToNSRC}
 function OutDecor: String;
 var
  l_W : TevdNativeWriter;
  l_G : Tk2TagGenerator;
  l_F : Tl3CustomFiler;
  l_Stream : Tl3StringStream;
  l_Pos : Integer;
  l_S : Tl3WString;
 begin//OutDecor
  Result := '';
  l_F := Tl3CustomFiler.Create;
  try
   l_Stream := Tl3StringStream.Create;
   try
    l_F.Mode := l3_fmWrite;
    l_F.Stream := l_Stream;
    try
     l_W := TevdNativeWriter.Create;
     try
      l_W.Filer := l_F;
      l_W.NeedOutHeader := false;
      {$IfDef evdNeedEverestTxt}
      l_W.Binary := false;
      {$Else}
      !!! нужен TevdNativeWriter с поддержкой текстового формата
      {$EndIf evdNeedEverestTxt}
      l_G := l_W.Use;
      try
       //TevSegmentFontSizeEliminator.SetTo(l_G);
       l_G.Start;
       try
        l_G.StartChild(aStyledObject.TagType);
        try
         aStyledObject.WriteTag(l_G, l3_spfAll, [k2_tiStart, k2_tiFinish, k2_tiVisible]);
        finally
         l_G.Finish;
        end;//try..finally
       finally
        l_G.Finish;
       end;//try..finally
      finally
       FreeAndNil(l_G);
      end;//try..finally
      Result := l_Stream._String.AsString;
      Result := l3ReplaceNonReadable(Result);
      Result := l3DeleteDoubleSpace(Result);
      Result := l3RTrim(Result);
      l_S := l3PCharLen(Result);
      l_Pos := l3Pos(l_S, l3PCharLen('='));
      if (l_Pos > 0) then
       Result := l3PCharLen2String(l3PCharLen(l_S.S + l_Pos + 1, l_S.SLen - l_Pos - 1, l_S.SCodePage));
      Result := TrimLeft(Result);
      if (Result = evdOpenBracket + evdCloseBracket) OR
         (Result = evdOpenBracket + cc_HardSpace + evdCloseBracket) then
       Result := '';
      if (Result <> '') then
      begin
       if AnsiStartsStr('{ ', Result) then
        Delete(Result, 2, 1);
       if AnsiEndsStr(' }', Result) then
        Delete(Result, Length(Result) - 1, 1);
      end;//Result <> ''
     finally
      FreeAndNil(l_W);
     end;//try..finally
    finally
     l_F.Stream := nil;
    end;//try..finally
   finally
    FreeAndNil(l_Stream);
   end;//try..finally
  finally
   FreeAndNil(l_F);
  end;//try..finally
 end;//OutDecor
 {$EndIf evOutDecorToNSRC}

var
 l_IsPara : Boolean;
 V        : Boolean;

 procedure OutVisible;
 begin//OutVisible
  if l_IsPara then
  begin
   if not V then
   begin
    Open := ev_NSRCInvisible + Open;
    Close := Close + ev_NSRCInvisible;
    Result := true;
   end;//not V
  end//l_IsPara
  else
  if (aParaVisible <> V) then
  begin
   Open := ev_NSRCInvisible + Open;
   Close := Close + ev_NSRCInvisible;
   Result := true;
  end;//aParaVisible <> V
 end;//OutVisible

var
 l_ValidPicture : Boolean;

 procedure lp_SkipPicture;
 begin
  l_ValidPicture := False;
  DeleteText := true;
  Open := '';
  Close := '';
 end;

var
 l_EndTextPos  : Integer;
 l_FormulaText : AnsiString;
 C             : AnsiChar;
 ID            : Integer;
 l_EP          : AnsiString;
 l_EH          : Integer;
 l_DPI         : Integer;
 l_IStream     : IStream;
 l_Stream      : Tl3Stream;
 l_OutStream   : Tl3NamedFileStream;
 l_Path        : AnsiString;
 l_Pos         : Int64;
 l_BL          : Integer;
 l_H: Integer;
 l_W: Integer;
 l_TextToOut : Tl3CustomString;
begin
 f_CheckChar := #0;
 Result := inherited IsMarkStyle(aParaVisible, aParaStyle, aStyledObject, aText, Open, Close, DeleteText);
 with aStyledObject do
 begin
  ID := IntA[k2_tiStyle];
  l_IsPara := IsKindOf(k2_typPara);
  if l_IsPara then
   V := aParaVisible
  else
  if (ID = ev_saTxtComment)
     // - иначе не работали тесты для http://mdp.garant.ru/pages/viewpage.action?pageId=180060974
     OR (ID = ev_saVersionInfo) then
     // - иначе не работали тесты для http://mdp.garant.ru/pages/viewpage.action?pageId=209584396
   V := false
  else
  if HasSubAtom(k2_tiVisible)
     AND Attr[k2_tiVisible].IsValid then
     // http://mdp.garant.ru/pages/viewpage.action?pageId=210043510
     // - забыли, что бывает прозрачность
   V := BoolA[k2_tiVisible]
  else
   V := aParaVisible;
(*   with Attr[k2_tiVisible] do
    if IsValid then
     V := AsBool
    else
     V := aParaVisible;*)
//  if ((ID >= Low(TevStandardStyle)) AND (ID <= High(TevStandardStyle))) then
  // - закомментировал, т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=604929313
  // - будем писать кусок EVD-оформления в NSRC
  begin
   if not l_IsPara AND (ID = aParaStyle) then
   begin
    if not aStyledObject.HasSubAtom(k2_tiFont) then
    begin
     OutVisible;
     Exit;
    end;//not aStyledObject.HasSubAtom(k2_tiFont)
   end;//not l_IsPara..
   if (ID = ev_saHyperlink) then
   begin
    if not IsKindOf(k2_typHyperlink) then
     Exit;
   end//ID = ev_saHyperlink
   {$IFDEF evUseEvdStyleOnly}
   else
   if l_IsPara then
    Exit
   {$ENDIF evUseEvdStyleOnly}
   else
(*   if ((ID >= ev_saTxtHeader4) AND (ID <= ev_saTxtHeader1)) then
   begin
    if IsKindOf(k2_typSegment) then
     Exit;
   end*)
   ;
   // - закомментировал, т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=604929313
   // - будем писать кусок EVD-оформления в NSRC
   C := #0;
   if ((ID >= Low(TevStandardStyle)) AND (ID <= High(TevStandardStyle))) then
   begin
    C := NSRCBrackets[-ID];
    if ((ID >= ev_saTxtHeader4) AND (ID <= ev_saTxtHeader1))
       {$IfDef evOutDecorToNSRC}
       OR (ID = ev_saEnclosureHeader)
       {$EndIf evOutDecorToNSRC}
       then
    begin
     {$IfNDef evOutDecorToNSRC}
     if IsKindOf(k2_typSegment) then
     {$EndIf  evOutDecorToNSRC}
      C := #0;
    end;//((ID >= ev_saTxtHeader4) AND (ID <= ev_saTxtHeader1))
    {$IfNDef evUseEvdStyleOnly}
    {$IfDef evOutDecorToNSRC}
    if (C <> #0) then
     if aStyledObject.IsKindOf(k2_typSegment) then
      if aStyledObject.HasSubAtom(k2_tiFont) then
      // - чтобы записать и стиль и шрифт по-новому
       if not aStyledObject.IsKindOf(k2_typObjectSegment) then
        if not aStyledObject.IsKindOf(k2_typHyperlink) then
         C := #0;
    {$EndIf  evOutDecorToNSRC}     
    {$EndIf  evUseEvdStyleOnly}
   end//((ID >= Low(TevStandardStyle)) AND (ID <= High(TevStandardStyle)))
   else
    C := #0; 
   if (C <> #0) then
   begin
    Close := C;
{    if (ID >= ev_saTxtHeader4) AND (ID < ev_saTxtHeader1) then
     Open := C + ev_psFixLen('', ev_saTxtHeader1 - ID, cc_Tab)
    else}
     Open := C;
   end//C <> #0
   else
   begin
    {$IfNDef evUseEvdStyleOnly}
    {$IfDef evOutDecorToNSRC}
    if aStyledObject.IsKindOf(k2_typSegment) then
     if not aStyledObject.IsKindOf(k2_typObjectSegment) then
      if not aStyledObject.IsKindOf(k2_typHyperlink) then
      begin
       Open := OutDecor;
       if (Open <> '') then
       begin
        if NeedOutDecorInfo then
        begin
         NeedCorrect := true;
         dbgAppendToLogLn(ChangeFileExt(ParamStr(0), '.num'), IntToStr(InternalHandle));
         l3System.Msg2Log('Decor: ' + Open);
         l3System.Msg2Log('DocID: ' + IntToStr(InternalHandle));
         l_TextToOut := aText;
         l3System.Msg2Log('Text part: ' + l3PCharLen2String(l_TextToOut.AsWStr, CP_ANSI));
         if (aText Is TevSubString) then
          if (TevSubString(aText).TP <> nil) then
          begin
           l_TextToOut := TevSubString(aText).TP.AsObject.Attr[k2_tiText] As Tl3CustomString;
           l3System.Msg2Log('Text: ' + l3PCharLen2String(l_TextToOut.AsWStr, CP_ANSI));
          end;//aText Is TevSubString
        end;//NeedOutDecorInfo
        C := cDecorBracket;
        Close := C;
        Open := cDecorEx + Open;
       end;//Open <> ''
      end;//IsKindOf(k2_typSegment)
    {$EndIf  evOutDecorToNSRC}  
    {$EndIf  evUseEvdStyleOnly}
   end;//C <> #0
   
   if (C <> #0) then
   begin
    f_CheckChar := C;
    Result := true;
    if (ID = ev_saObject) AND aStyledObject.IsKindOf(k2_typObjectSegment) then
     with aStyledObject.Child[0] do
      if IsKindOf(k2_typFormula) then
      begin
       l_FormulaText := StrA[k2_tiText];
       l_EndTextPos := Pos(cc_Null, l_FormulaText);
       if l_EndTextPos > 0 then
        l_FormulaText := Copy(l_FormulaText, 1, l_EndTextPos - 1);
       Close := l_FormulaText + Close;
       DeleteText := true;
      end//IsKindOf(k2_typFormula)
      else
      if IsKindOf(k2_typBitmapPara) then
      begin
       l_EH := IntA[k2_tiExternalHandle];
       l_ValidPicture := true;
       try
        if not Attr[k2_tiData].IsValid then
         raise El3BadDataInPara.Create(Format('Нет содержимого картинки. External handle = %d', [l_EH]));
        if not Attr[k2_tiData].IsStream(l_IStream) then
         raise El3BadDataInPara.Create(Format('Не получили поток картинки. External handle = %d', [l_EH]));
       except
        on E : Exception do
         if SkipInvalidPictures then
         begin
          lp_SkipPicture;
          _Msg2Log(E.Message);
         end//SkipInvalidPictures
         else
          raise;
       end;//try..except
       if l_ValidPicture then
       begin
        l3IStream2Stream(l_IStream, TStream(l_Stream));
        try
         l_Path := ExtractFilePath(Filer.Identifier);
         l_EP := StrA[k2_tiExternalPath];
         l_DPI := IntA[k2_tiDPI];
         l_BL := aStyledObject.IntA[k2_tiBaseLine];
         l_H:= IntA[k2_tiHeight];
         l_W:= IntA[k2_tiWidth];
         if l_EP = '' then
          l_EP := IntToStr(l_EH);
         if (ExtractFileExt(l_EP) = '') then
         begin
          l_Pos := l_Stream.Position;
          try
           l_Stream.Seek(0, soBeginning);
           l_EP := l_EP + PictExt[FindStreamFormat(l_Stream)];
          finally
           l_Stream.Seek(l_Pos, soBeginning);
           // - восстанавливем указатель ОСНОВНОГО потока
          end;//try..finally
         end;//ExtractFileExt(l_EP) = ''
         Assert(f_ExternalDocHandle <> 0);
         l_Path := l_Path + IntToStr(f_ExternalDocHandle);
         MakeDir(l_Path);
         l_OutStream := Tl3NamedFileStream.Create(l_Path + '\' + l_EP, l3_fmWrite);
         try
          l_Pos := l_Stream.Position;
          try
           l_Stream.Seek(0, soBeginning);
           {$IfDef nsTest}
           Dec(g_IStreamCopyTo_Guard);
           try
           {$EndIf nsTest}
            l3CopyStream(l_Stream, l_OutStream);
           {$IfDef nsTest}
           finally
            Inc(g_IStreamCopyTo_Guard);
           end;//try..finally
           {$EndIf nsTest}
          finally
           l_Stream.Seek(l_Pos, soBeginning);
           // - восстанавливем указатель ОСНОВНОГО потока
          end;//try..finally
         finally
          FreeAndNil(l_OutStream);
         end;//try..finally
         SaveObjFileName(l_Path + '\' + l_EP);
         l_FormulaText := 'pic:' + IntToStr(f_ExternalDocHandle) + '\' + l_EP + ';' +
                          'topic:' + IntToStr(l_EH);
         if (l_DPI > 0) then
          l_FormulaText := l_FormulaText + ';' +
                           'res:' + IntToStr(l_DPI);
         if (l_BL > 0) then
          l_FormulaText := l_FormulaText + ';' +
                           'bloffs:' + IntToStr(l_BL);
         if l_H > 0 then
          l_FormulaText := l_FormulaText + ';' +
                           'height:' + IntToStr(l_H);
         if l_W > 0 then
          l_FormulaText := l_FormulaText + ';' +
                           'width:' + IntToStr(l_W);
         l_EndTextPos := Pos(cc_Null, l_FormulaText);
         if (l_EndTextPos > 0) then
          l_FormulaText := Copy(l_FormulaText, 1, l_EndTextPos - 1);
         Close := l_FormulaText + Close;
         DeleteText := true;
        finally
         FreeAndNil(l_Stream);
        end;//try..finally
       end;//l_ValidPicture
      end;//IsKindOf(k2_typBitmapPara)
    try
     DoOutHyperLink(aStyledObject, Close);
    except
     on EevHyperlinkNotFound do
     begin
      Result := false;
      Open := ''; Close := '';
     end;{EevHyperlinkNotFound}
    end;{try..except}
    OutVisible;
   end//C <> #0
   else
    OutVisible;
  end;//ID >= Low(TevStandardStyle)..
 end;//with aStyledObject
end;

procedure TevCustomNSRCWriter.AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
  {override;}
  {-}
var
 S  : Tl3CustomString;
 CT : Tk2Type;
begin
 CT := CurrentType;
 if CT.IsKindOf(k2_typPageProperties) then
 begin
  Case AtomIndex of
   k2_tiOrientation:
    f_Division.Orientation := TevPageOrientation(VariantAsInteger(AtomIndex, Value));
   k2_tiHeight:
    f_Division.Extent.Y := Value.AsInteger;
   k2_tiWidth:
    f_Division.Extent.X := Value.AsInteger;
   else
    inherited;
  end;//Case AtomIndex
 end//CT.IsKindOf(k2_typPageProperties)
 else
 begin
  Case AtomIndex of
   k2_tiExternalHandle:
    if CT.IsKindOf(k2_typDocument) then
     if (TopType[1] = nil) then
     // - учитываем вложенные документы
      f_ExternalDocHandle := Value.AsInteger;
   k2_tiStyle:
    AnalizeStyle(Value.AsInteger);
   k2_tiHandle:
    begin
     if CT.IsKindOf(k2_typBlock) then
      OpenBlock(Value.AsInteger)
     else
     if CT.IsKindOf(k2_typSub) AND
        not CT.IsKindOf(k2_typDocumentSub) and
        not CT.IsKindOf(k2_typBookmark) then
      OutSub(Value.AsInteger);
    end;//AtomIndex = k2_tiHandle
   k2_tiJustification:
     if (f_CurParaParas.Justification = ev_itNone) then
      f_CurParaParas.Justification := TevIndentType(Value.AsInteger);
   k2_tiFirstIndent:
     if (f_CurParaParas.FirstIndent = l3NilLong) then
      f_CurParaParas.FirstIndent := Pixel2Char(Value.AsInteger);
   k2_tiWidth:
     if (f_CurParaParas.Width = l3NilLong) then
      f_CurParaParas.Width := Pixel2Char(Value.AsInteger);
   k2_tiLeftIndent:
     if (f_CurParaParas.LeftIndent = l3NilLong) then
      f_CurParaParas.LeftIndent := Pixel2Char(Value.AsInteger);
   k2_tiShortName:
    begin
     if CT.IsKindOf(k2_typDocument) then
     begin
      if (TopType[1] = nil) then
      begin
       S := VariantAsString(Value);
       try
        OutShortname(S);
       finally
        l3Free(S);
       end;{try..finally}
      end; // (TopType[1] = nil)
     end; // CT.IsKindOf(k2_typDocument)
    end;//AtomIndex = k2_tiShortName
   k2_tiComment:
    begin
     if CT.IsKindOf(k2_typDocument) then
     begin
      if (TopType[1] = nil) then
      begin
        // - учитываем вложенные документы
       S := VariantAsString(Value);
       try
        OutHeader;
        OutEOL;
        OutString(cc_SemiColon);
        SetOutCodePage(S, CodePage);
        OutString(S);
       finally
        l3Free(S);
       end;{try..finally}
      end;//TopType[1] = nil
     end//CT.IsKindOf(k2_typDocument)
     else
      inherited;
    end;//k2_tiComment
   k2_tiPrintFontSize: 
    if (f_CurParaParas.Style.PrintFontSize = 0) then
     f_CurParaParas.Style.PrintFontSize := Value.AsInteger;
   else
    inherited;
  end;//Case AtomIndex  
 end;//CT.IsKindOf(k2_typPageProperties)
end;

function TevCustomNSRCWriter.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(Il3CharSkipper) then 
 begin
  Result.SetOk;
  Pointer(Obj) := Pointer(Il3CharSkipper(TevNSRCCharSkipper.Create));
 end
 else
 if IID.EQ(Il3StringFormatter) then
 begin
  Result.SetOk;
  Pointer(Obj) := Pointer(Il3StringFormatter(TevNSRCStringFormatter.Create));
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TevCustomNSRCWriter.SetOutCodePage(aString: Tl3CustomString; aCodePage: Integer);
begin
 if (aCodePage = CP_KeepExisting) then
 begin
  if (aString.CodePage = CP_TatarOEM) then
  begin
   // - ничего не делаем
  end//aString.CodePage = CP_TatarOEM
  else
  if (aString.CodePage = CP_Tatar) then
  begin
   aString.CodePage := CP_TatarOEM;
  end//aString.CodePage = CP_Tatar
  else
  if l3IsOEMEx(aString.CodePage) then
   aString.CodePage := CP_OEMLite
  else
  if l3IsANSI(aString.CodePage) then
   aString.CodePage := CP_OEMLite
  else
  if (aString.CodePage = CP_EastEurope) then
  begin
   // - ничего не делаем
  end//aString.CodePage = CP_EastEurope
  else
   Assert(false, 'Кодировка параграфа: ' + IntToStr(aString.CodePage));
 end//aCodePage = CP_KeepExisting
 else
  aString.CodePage := aCodePage;
end;

procedure TevCustomNSRCWriter.ValidateLine(aLine : Tl3String; aCodePage : Integer);
  //override;
  {* - процедура для проверки корректности строки. }

  procedure CorrectFormulas; // удаляем пробелы в формулах (K 200088144)
  var
   I: Integer;
   l_InQuote: Boolean;
   l_SubStr: Tl3WString;
   l_ParCount: Integer;
   l_S : Tl3WString;
  begin
   I := 0;
   while I < aLine.Len do
   begin
    if aLine.Ch[I] = ev_NSRCFormula then
    begin
     Inc(I);
     l_S := aLine.AsWStr;
     l_S.S := l_S.S + I;
     l_S.SLen := l_S.SLen - I;
     if l3Starts(cDecor, l_S) then
     begin
      Inc(I, Length(cDecor) - 1);
      while (I < aLine.Len) do
      begin
       Inc(I);
       if (aLine.Ch[I] = ev_NSRCFormula) then
       begin
        Inc(I);
        break;
       end;//aLine.Ch[I] = ev_NSRCFormula
      end;//I
     end//l3Starts(cDecor, l_S)
     else
     while I < aLine.Len do
     begin
      case aLine.Ch[I] of
       ev_NSRCFormula: begin
                        Inc(I);
                        Break;
                       end;
       cc_HardSpace: aLine.Delete(I, 1);
       's','S': begin
                 l_SubStr := l3Copy(aLine.AsWStr, I, 7);
                 if l3Same(l_SubStr, 'String(', True) then
                 begin
                  Inc(I, l_SubStr.SLen);
                  l_InQuote := False;
                  l_ParCount := 1;
                  while I < aLine.Len do
                  begin
                   case aLine.Ch[I] of
                    '"' : l_InQuote := not l_InQuote;
                    '(' : if not l_InQuote then
                           Inc(l_ParCount);
                    ')' : if not l_InQuote then
                          begin
                           Dec(l_ParCount);
                           if l_ParCount = 0 then
                           begin
                            Inc(I);
                            Break;
                           end;
                          end;
                   end;//case aLine.Ch[I]
                   Inc(I);
                  end;//I < aLine.Len
                 end//l3Same(l_SubStr, 'String(', True)
                 else
                  Inc(I);
                end;//'s','S'
      else
       Inc(I);
      end;//case aLine.Ch[I]
     end;//while I < aLine.Len
    end;//aLine.Ch[I] = ev_NSRCFormula
    if aLine.Ch[I] <> ev_NSRCFormula then
     Inc(I);
   end;//I < aLine.Len
  end;//CorrectFormulas

  procedure CorrectSwappedCommentBrackets;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=207388924
  var
   l_Len : Integer;
  begin//CorrectSwappedCommentBrackets
   l_Len := aLine.RTrimLen;
   if (l_Len >= 4) then
   begin
    if (aLine[0] = ev_NSRCInvisible) AND (aLine[1] = ev_NSRCComment) AND
       (aLine[l_Len-2] = ev_NSRCInvisible) AND (aLine[l_Len-1] = ev_NSRCComment) then
    begin
     aLine[l_Len-1] := ev_NSRCInvisible;
     aLine[l_Len-2] := ev_NSRCComment;
    end;//(aLine[0] = ev_NSRCInvisible) AND (aLine[0] = ev_NSRCComment)
   end;//aLine.Len >= 4
  end;//CorrectSwappedCommentBrackets

  procedure lp_CheckStyle;
  var
   l_Str: Tl3String;         
  begin
   if (f_CheckChar <> #0) then
   begin
    l_Str := Tl3String.Make(aLine);
    try
     if l_Str.Trim.Len = 1 then
      aLine.DeleteAllChars(f_CheckChar);
    finally
     l3Free(l_Str);
    end;
   end; // if (f_CheckChar <> #0) then
  end;

  procedure lp_CheckIntersectionWithHyperlink;
  var
   i             : Integer;
   l_Char        : AnsiChar;
   l_OpenIndex   : Integer;
   l_HyperCount  : Integer;
   l_HyperStart  : Integer;
   l_PrevNSRCChar: AnsiChar;
   l_Count: Integer;
  begin
   i := 0;
   l_PrevNSRCChar := #0;
   l_HyperCount := 0;
   l_HyperStart := -1;
   l_OpenIndex := -1;
   l_Count := aLine.RTrimLen - 1; // A количество символов уже могло измениться...
   with aLine do
    while (i <= l_Count) do
    begin
     l_Char := Ch[i];
     if (l_Char in ev_NSRCSimple) then
     begin
      if (l_PrevNSRCChar = l_Char) then
       if (l_HyperCount = 1) and (l_OpenIndex > -1) and (l_OpenIndex < l_HyperStart) then
       begin
        Ch[l_OpenIndex] := ev_NSRCHyperlink;
        Ch[l_HyperStart] := l_PrevNSRCChar;
        l_PrevNSRCChar := #0;
        l_OpenIndex := -1;
       end // if (l_HyperCount > 0) and (l_PrevNSRCChar = l_Char) then
       else
       begin
        l_PrevNSRCChar := #0;
        l_OpenIndex := -1
       end
      else
      begin
       l_PrevNSRCChar := l_Char;
       l_OpenIndex := i;
      end;
     end; // if (l_Char in ev_NSRCSimple) then
     if (l_Char = ev_NSRCHyperlink) then
     begin
      if l_HyperCount = 0 then
       l_HyperStart := i;
      if l_HyperCount = 2 then
       l_HyperCount := 0
      else
       Inc(l_HyperCount);
     end; // if (l_Char in [ev_NSRCHyperlink, ev_NSRCHyperlinkCont]) then
     Inc(i);
    end; // while (i <= l_Count) do
  end; // lp_CheckIntersectionWithHyperlink

 procedure ValidateCodePage;
 var
  l_Index : Integer;
  l_W : WideChar;
  l_WS : Tl3PCharLen;
  l_NS : Tl3Str;
  l_S : Tl3String;
  l_InsString : AnsiString;
 begin
  if (aLine.CodePage = aCodePage) then
   Exit;
  if aLine.Empty then
   Exit;
  if (aLine.CodePage <> CP_Unicode) then
  begin
   if l3IsANSI(aLine.CodePage) then
    Exit;
   if l3IsOEM(aLine.CodePage) then
    Exit;
   aLine.CodePage := CP_Unicode;
  end;//aLine.CodePage <> CP_Unicode
  if (aLine.CodePage = CP_Unicode) then
  begin
   l_S := Tl3String.Create;
   try
    for l_Index := 0 to Pred(aLine.Len) do
    begin
     l_W := PWideChar(aLine.St)[l_Index];
     l_WS := l3PCharLen(PWideChar(@l_W), 1);
     l_NS.Init(l_WS, aCodePage);
     try
      if not l3Same(l_NS, l_WS) then
      begin
       l_InsString := ev_NSRCFormula + 'String(#@' + IntToStr(Integer(l_W)) + ')' + ev_NSRCFormula;
       l_WS := l3PCharLen(l_InsString, aCodePage)
      end;//l3Same(l_NS, l_WS)
     finally
      l_NS.Clear;
     end;//try..finally
     l_S.Append(l_WS);
    end;//for l_Index
    aLine.AsWStr := l_S.AsWStr;
   finally
    FreeAndNil(l_S);
   end;//try..finally
  end;//aLine.CodePage = CP_Unicode
 end;

 procedure CheckSpacesInHyperlink;
 var
  l_HlSymbS : Integer;
  l_HlSymbF : Integer;
  i         : Integer;
  l_Index   : Integer;
  l_Count   : Integer;
 begin//CheckSpacesInHyperlink
  // Дальше идет проверка на включение пробелов в гиперссылку - будет перенос, а он не нужен...
  // http://mdp.garant.ru/pages/viewpage.action?pageId=200088144&focusedCommentId=200088151#comment-200088151
  l_HlSymbS := -1;
  l_HlSymbF := -1;
  l_Count := aLine.RTrimLen - 1; // A количество символов уже могло измениться...
  //if false then
  begin
   for l_Index := 0 to l_Count - 1 do
   begin
    if (aLine.Ch[l_Index] = ev_NSRCHyperlink) then
     if (l_HlSymbS = -1) and (l_HlSymbF > -1) then
      l_HlSymbF := -1
     else
      if l_HlSymbS = -1 then
       l_HlSymbS := l_Index
      else
       if l_HlSymbF = -1 then
        l_HlSymbF := l_Index
       else
        begin
         l_HlSymbS := -1;
         l_HlSymbF := -1;
        end;
    if (l_HlSymbS <> -1) and (l_HlSymbF <> -1) then
    begin
     i := 0;
     for i := l_HlSymbS + 1 to l_HlSymbF - 1 do
      if aLine.Ch[i] <> cc_HardSpace then Break;
     if i > l_HlSymbS + 1 then
     begin
      aLine.Ch[i - 1] := ev_NSRCHyperlink;
      aLine.Ch[l_HlSymbS] := cc_HardSpace;
     end; //if i > l_HlSymbS + 1 then
     l_HlSymbS := -1;
    end; //if (l_HlSymbS <> -1) and (l_HlSymbF <> -1) then
   end; //for l_Index := 0 to l_Count - 1 do
  end;//if false
 end;//CheckSpacesInHyperlink

 procedure CheckHyperlinkSwappedBrackets;
 var
  l_FirstBracketChar : AnsiChar;

  function HasOpenHyperlink(anIndex: Integer): Boolean;
  var
   l_Index : Integer;
   l_Ch : Char;
  begin//HasOpenHyperlink
   if (anIndex < 0) then
    Result := false
   else
   begin
    l_Index := anIndex;
    while (l_Index >= 0) do
    begin
     l_Ch := aLine.Ch[l_Index];
     if (l_Ch = l_FirstBracketChar) then
     begin
      Result := true;
      Exit;
     end;//l_Ch = l_FirstBracketChar
     Dec(l_Index);
    end;//while (l_Index >= 0)
    Result := false;
   end;//anIndex < 0
  end;//HasOpenHyperlink
  
 var
  l_Index   : Integer;
  l_OpenedAfterHyperlink : TevNSRCSymbolStatus;
  l_OpenedInsideHyperlink : TevNSRCSymbolStatus;
  l_Char    : AnsiChar;
  l_HIndex  : Integer;
  l_HChar   : AnsiChar;
  l_Gap     : AnsiString;
  l_Count   : Integer;
  l_HyperlinkEndPos : Integer;
 begin//CheckHyperlinkSwappedBrackets
  l_Char := #0;
  l_Count := aLine.RTrimLen - 1;
  l_Index := l_Count;
  with aLine do
  begin
   //if false then
   begin
    l3FillChar(l_OpenedAfterHyperlink, SizeOf(l_OpenedAfterHyperlink));
    l_HyperlinkEndPos := -1;
    while (l_Index >= 0) do
    // - просматриваем строку от конца к началу на предмет перепутанности
    //   скобок оформления и гиперссылок
    begin
     l_FirstBracketChar := Ch[l_Index];
     if (l_FirstBracketChar in [ev_NSRCHyperlink, ev_NSRCHyperlinkCont]) then
     begin
      Assert(l_HyperlinkEndPos < 0);
      l_HyperlinkEndPos := l_Index;
      l3FillChar(l_OpenedInsideHyperlink, SizeOf(l_OpenedInsideHyperlink));
      Dec(l_Index);
      if (l_FirstBracketChar = ev_NSRCHyperlink) then
       // - если бывает номер
       while (l_Index >= 0) do
       begin
        // - пропускаем номер
        if (Ch[l_Index] = ev_NSRCHyperlink) then
        begin
         Dec(l_Index);
         Break
        end//Ch[l_Index] = ev_NSRCHyperlink
        else
         Dec(l_Index);
       end;//while (l_Index >= 0)
      l_Gap := '';
      while (l_Index >= 0) do
      begin
       l_Char := Ch[l_Index];
       if (l_Char = l_FirstBracketChar) then
       // - ссылка началась, но пара не найдена, добавляем в конец закрывающие скобки
       begin
        if (l_Gap <> '') then
         Append(l3PCharLen(l_Gap, CodePage));
        l_HyperlinkEndPos := -1; 
        Break;
       end;//l_Char = l_FirstBracketChar
       if (l_Char in ev_NSRCSimple) then
       begin
        if l_OpenedAfterHyperlink[l_Char] then
        begin
         Assert(not l_OpenedInsideHyperlink[l_Char]);
         Assert(l_HyperlinkEndPos > 0);
         if HasOpenHyperlink(l_Index - 1) then
         begin
          l_OpenedAfterHyperlink[l_Char] := false;
          Delete(l_Index, 1);
          Insert(l_Char, l_HyperlinkEndPos);
          break;
         end;//HasOpenHyperlink
        end;//l_OpenedAfterHyperlink[l_Char]

        l_OpenedAfterHyperlink[l_Char] := false;
        
        begin
         l_OpenedInsideHyperlink[l_Char] := not l_OpenedInsideHyperlink[l_Char];
         if (l_OpenedInsideHyperlink[l_Char]) then
         begin
          // - обрабатываем открывающий символ
          l_HIndex := Pred(l_Index);
          while (l_HIndex >= 0) do
          begin
           l_HChar := Ch[l_HIndex];
           if (l_HChar = l_Char) then
            // - нашли пару
            Break;
           if (l_HChar = l_FirstBracketChar) then
           begin
            Delete(l_Index, 1);
            l_Gap := l_Char + l_Gap;
            l_HyperlinkEndPos := -1;
            Break;
           end;//l_Char = l_FirstBracketChar
           Dec(l_HIndex);
          end;//while (l_HIndex >= 0)
         end;//l_OpenedInsideHyperlink[l_Char]
        end;//l_OpenedAfterHyperlink[l_Char]
       end;//l_Char in ev_NSRCSimple
       Dec(l_Index);
      end;//while (l_Index >= 0)
      Break;
     end//l_FirstBracketChar in [ev_NSRCHyperlink, ev_NSRCHyperlinkCont]
     else
     if (l_Char in ev_NSRCSimple) then
     // - уткнулись внутри ссылки в открывающую скобку
      Break
     else
     if (l_FirstBracketChar in ev_NSRCSimple) then
     begin
      Assert(l_HyperlinkEndPos = -1);
      // - потому, что вложенные в ссылку сегменты обрабатываются в другом цикле выше
      l_OpenedAfterHyperlink[l_FirstBracketChar] := not l_OpenedAfterHyperlink[l_FirstBracketChar];
     end;//l_FirstBracketChar in ev_NSRCSimple
     Dec(l_Index);
    end;//while (l_Index >= 0)
   end;//if false
  end;//with aLine
 end;//CheckHyperlinkSwappedBrackets

begin
 ValidateCodePage;
 aLine.CodePage := aCodePage;
 inherited;
 if not aLine.Empty then
 begin
  CorrectSwappedCommentBrackets;
  
  // Дальше, если я правильно понимаю, удаляются дублирующиеся символы.
  // - нет - НЕПРАВИЛЬНО - дальше переставляются местами непарные скобки
  // - bug fix: неправильно выливались сегменты и ссылки - было пересечение (см. _TestSet\Segments\Hyperlinks\5.evd).
  CheckHyperlinkSwappedBrackets;

  CorrectSwappedCommentBrackets;

  CorrectFormulas;
  lp_CheckStyle;
  //lp_CheckIntersectionWithHyperlink;
  {RequestLink:619944727} // - убрано, т.к. починили по-другому и это мешало

  CheckSpacesInHyperlink;
  
  if not aLine.Empty then
   if (aLine.Ch[0] = '!') then
    aLine.Insert('!', 0);
 end; //if not aLine.Empty then
end;

procedure TevCustomNSRCWriter.CheckNeed2AddBlock;
begin
 // - специально ничего не делаем. Делать должен потомок.
end;

procedure TevCustomNSRCWriter.ValidateText(aText: Tl3String;
  aValidateText: Tl3String = nil);
var
 l_BracketIndex  : Integer;
 
  procedure lp_CheckText;
  begin
   with aText do
   begin
    DeleteAllChars(evAllLineBrackets[l_BracketIndex]);
    LPad(evAllLineBrackets[l_BracketIndex]);
    Append(evAllLineBrackets[l_BracketIndex]);
   end;//with aText
  end; // lp_CheckText

const
 l_FrameCriteria = cc_Graph_Criteria +
                   [cc_SoftEnter, cc_HardSpace, cc_OEMSoftSpace, cc_Tab];
 l_Criteria = cc_AllChars - l_FrameCriteria;
var
 l_Pos           : Integer;
 l_Char          : AnsiChar;
 l_Open          : Boolean;
 l_Index         : Integer;
 l_ContinueOuter : Boolean;
 l_CheckString   : Tl3String;
begin
 if aValidateText = nil then
  l_CheckString := aText
 else
  l_CheckString := aValidateText;
 for l_BracketIndex := Low(evAllLineBrackets) to High(evAllLineBrackets) do
 begin
  if l_CheckString.IsOEM then
  begin
    l_Pos := l_CheckString.FindChar(0, evAllLineBrackets[l_BracketIndex]);
    if (l_Pos > 0) then
    begin
     l_Open := false;
     with l_CheckString do
     begin
      l_ContinueOuter := false;
      for l_Index := 0 to Pred(Len) do
      begin
       l_Char := Ch[l_Index];
       if (l_Char = evAllLineBrackets[l_BracketIndex]) then
        l_Open := not l_Open
       else
       if not l_Open then
       begin
        if (l_Char in l_Criteria) then
        begin
         l_ContinueOuter := True;
         // - надо переместиться на конец внешнего цикла
         Break;
        end;//l_Char in l_Criteria
       end;//l_Char = evAllLineBrackets[l_BracketIndex]
      end;//for l_Index
     end;//with l_CheckString
     if l_ContinueOuter then
      Continue;
     if not l_Open then lp_CheckText;
     Continue;
    end // l_Pos > 0
    else
     if (l_Pos = 0) and (aValidateText <> nil) then lp_CheckText;
  end;//aText.IsOEM
 end;//for l_BracketIndex
end;

procedure TevCustomNSRCWriter.ClearPP;
{ Вспомогательные процедуры для конвертера NSRC+ в NSRC }
begin
 ClearBothParas;
end;

procedure TevCustomNSRCWriter.ClearPPBetweenDoc;
{ Вспомогательные процедуры для конвертера NSRC+ в NSRC }
begin
 ClearPP;
 f_BeforeCommentLetter:= NilLetter;
 l3FillChar(f_Division, SizeOf(f_Division), 0);
end;

procedure TevCustomNSRCWriter.CheckDigitalSeparatorAlignment;
begin
end;

procedure TevCustomNSRCWriter.SaveObjFileName(const aFileName: AnsiString);
begin

end;

{$IFDEF evUseEvdStyleOnly}
function TevCustomNSRCWriter.NeedEmptyPara: Boolean;
begin
 with f_CurParaParas.Style do
  Result := (StyleID >= Abs(ev_saHLE1)){ or (StyleID = -ev_saTechComment)};
end;
{$ENDIF evUseEvdStyleOnly}

procedure TevCustomNSRCWriter.OutTextStyle(anEmpty: Boolean;
                                           aCodePage : Integer;
                                           out anInsertSemeColon: Boolean);
{$IFDEF evUseEvdStyleOnly}
var
 l_Suffix        : AnsiString;
 l_OutStyle      : Boolean;
 l_WasEmpty      : Boolean;
 l_CodePage      : AnsiString;
 l_LeftIndent    : AnsiString;
 l_Justification : AnsiString;
 l_PrintFontSize : AnsiString;
{$ENDIF evUseEvdStyleOnly}
begin
{$IFDEF evUseEvdStyleOnly}
 with f_CurParaParas.Style do
 begin
  l_OutStyle := False;
  l_WasEmpty := False;
  anInsertSemeColon := False;
  if (StyleID = ev_saEmpty) and IsTechComment(True) then
   f_CurParaParas.Style.StyleID := -ev_saTechComment;
  if (StyleID <> ev_saEmpty) then
  begin
   l_OutStyle := not EQ(f_PrevParaStyle) or (f_SubCount > 0);
   l_CodePage := '';
   if IsTechComment(False) then
   begin
    l_OutStyle := False;
    l_WasEmpty := False;
    anInsertSemeColon := True;
   end // if IsTechComment then
   else
    if anEmpty then
    begin
     l_OutStyle := NeedEmptyPara;
     l_WasEmpty := not l_OutStyle;
    end // if S.Empty then
    else
     if (CodePage = CP_KeepExisting) then
     begin
      if ((aCodePage = CP_TatarOEM) OR (aCodePage = CP_Tatar)) then
      begin
       l_OutStyle := True;
       l_CodePage := ' CP_TatarOEM';
      end//S.CodePage = CP_TatarOEM
      else
       Assert(false, 'Нехорошо заниматься copy/paste');
     end;//CodePage = CP_KeepExisting
  end; // if (StyleID <> ev_saEmpty) and (f_PrevParaStyle.StyleID <> ev_saEmpty) then
  if OutStyle AND l_OutStyle then
  begin
   OutEOL;
   if IsDecorPara then
    l_Suffix := 'A'
   else
    l_Suffix := '';
   if (PrintFontSize > 0) AND
      (PrintFontSize <> 12) AND
      ((StyleID = ev_saTxtNormalOEM) or (StyleID = ev_saANSIDOS)) then
    l_PrintFontSize := ' H' + IntToStr(PrintFontSize)
   else
    l_PrintFontSize := '';
   if (ParaLI <> 0) and (ParaLI <> l3NilLong) then
    l_LeftIndent := ' L' + IntToStr(ParaLI)
   else
    l_LeftIndent := '';
   if Letter <> NewSchoolStyleLetter then
    l_Justification := ' J' + Letter
   else
    l_Justification := '';
   OutString(Format('!STYLE%s #%d%s%s%s%s', [l_Suffix,
                                             StyleID,
                                             l_CodePage,
                                             l_PrintFontSize,
                                             l_LeftIndent,
                                             l_Justification]));
  end // l_OutStyle
  else
   if l_WasEmpty then
    f_CurParaParas.Style.StyleID := ev_saEmpty;
 end; // with f_CurParaParas.Style do
{$ENDIF evUseEvdStyleOnly}
end;

{$IFDEF evUseEvdStyleOnly}
function TevCustomNSRCWriter.IsTechComment(aPrevStyle: Boolean): Boolean;
begin
 if aPrevStyle then
  Result := (f_PrevParaStyle.StyleID = -ev_saTechComment)
 else
  Result := (f_CurParaParas.Style.StyleID = -ev_saTechComment)
end;
{$ENDIF evUseEvdStyleOnly}

procedure TevCustomNSRCWriter.OutSubInt(SubHandle: Integer);
begin
 OutString(Format('!SUB %d', [SubHandle]));
 DoOutSub(SubHandle);
end;

function TevCustomNSRCWriter.NeedOutSub: Boolean;
begin
 Result := True;
end;

procedure TevCustomNSRCWriter.OutStyle4Cell;
begin

end;

procedure TevCustomNSRCWriter.SetExternalDocHandle(anID: Integer);
begin
 f_ExternalDocHandle := anID;
end;

function TevCustomNSRCWriter.IsStyleEqual(aParaStyle,
  aSegmentStyle: Integer): Boolean;
begin
 Result := inherited IsStyleEqual(aParaStyle, aSegmentStyle);
 if not Result then
  if ((aParaStyle >= Low(TevStandardStyle)) and (aParaStyle <= High(TevStandardStyle))) and
     ((aSegmentStyle >= Low(TevStandardStyle)) and (aSegmentStyle <= High(TevStandardStyle))) then
   Result := NSRCBrackets[-aParaStyle] = NSRCBrackets[-aSegmentStyle];
end;
{$EndIf evdNeedNSRCWriter}

end.

