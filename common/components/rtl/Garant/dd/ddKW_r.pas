//..........................................................................................................................................................................................................................................................
unit ddKW_r;

{=====================================
 = Читатель файлов ключевых слов     =
 = начат под конец рабочего  дня     =
 = 15 апреля последнего года ХХ века =
 ===================================== }
{ $Id: ddKW_r.pas,v 1.69 2015/11/26 08:45:43 lukyanets Exp $ }

// $Log: ddKW_r.pas,v $
// Revision 1.69  2015/11/26 08:45:43  lukyanets
// КОнстанты переехали
//
// Revision 1.68  2015/07/02 07:36:05  lukyanets
// Описываем словари
//
// Revision 1.67  2014/04/17 13:04:46  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.66  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.65  2013/10/30 10:36:36  voba
// - отказ от fSrchList
//
// Revision 1.64  2013/04/11 17:14:58  lulin
// - отлаживаем под XE3.
//
// Revision 1.63  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.62  2013/01/17 10:11:53  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.61  2012/02/28 10:14:07  dinishev
// Bug fix: не проходили тесты.
//
// Revision 1.60  2011/10/13 08:43:31  narry
// Накопившиеся изменения
//
// Revision 1.59  2011/09/08 06:42:43  fireton
// - изменилось название метода
//
// Revision 1.58  2011/07/12 09:46:59  voba
// - k : 265413348
//
// Revision 1.57  2011/05/13 14:58:42  fireton
// - не собирался Архивариус (у Tl3Parser.Create пропал параметр)
//
// Revision 1.56  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.55  2010/09/21 11:06:50  fireton
// - переводим деревья с PAnsiChar на Tl3WString
//
// Revision 1.54  2010/02/24 18:34:47  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.53  2009/12/14 11:46:59  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.52  2009/07/23 08:15:10  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.51  2009/07/22 11:27:31  narry
// - изменение доступа к DictServer
//
// Revision 1.50  2009/07/20 12:39:00  voba
// - Засунул renum в атрибуты
//
// Revision 1.49  2009/06/23 07:33:51  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.48  2009/05/13 11:19:26  voba
// - перевел procedure TKWReaderEx.ClearKWOnDocuments на ISab
//
// Revision 1.47  2009/04/13 07:12:57  narry
// - разделение определения типов и реализации
//
// Revision 1.46  2009/04/09 09:43:02  narry
// - процедура импорта линков многоуровневого словаря
//
// Revision 1.45  2009/04/02 15:17:28  narry
// - сделан универсальный заливатор линков
//
// Revision 1.44  2008/09/15 14:09:26  narry
// - защита от неверного формата (частично)
//
// Revision 1.43  2008/07/17 10:43:38  voba
// - enh. сокращаем количество функций редактирования словаря
//
// Revision 1.42  2008/07/09 06:05:45  narry
// - исправление ошибки применения delta.kw
//
// Revision 1.41  2008/07/07 09:40:08  voba
// - refact. выделил объект для работы со словарем (TDictionary)
//
// Revision 1.40  2008/06/17 08:20:48  narry
// - ошибка переименования с изменением регистра
//
// Revision 1.39  2008/06/16 14:44:18  narry
// - дублирование создваемого ключа
//
// Revision 1.38  2008/06/16 12:35:49  narry
// - ошибка применения команды RELOCATED в delta.kw
//
// Revision 1.37  2008/04/07 11:40:09  voba
// - вызываем delete на ноде
//
// Revision 1.36  2008/03/24 13:42:07  narry
// - борьба с дублированием элементов
//
// Revision 1.35  2008/03/20 09:48:29  lulin
// - cleanup.
//
// Revision 1.34  2008/02/07 14:44:37  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.33  2007/11/26 09:53:55  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.32  2007/10/24 10:47:55  voba
// - enh. NeedAddToDictionary - возможность заливки KW без пополнения словаря
//
// Revision 1.31  2007/10/09 08:54:06  voba
// - merge with b_archi_export_refact2
//
// Revision 1.30  2007/09/28 05:42:01  narry
// - обновление
//
// Revision 1.29.18.1  2007/09/14 15:51:27  voba
// no message
//
// Revision 1.29.10.1  2007/07/26 12:07:42  voba
// - refact. выкинул  ImportType, все равно он только ietMassive использовался
//
// Revision 1.29  2007/02/12 16:00:44  voba
// - buf fix (Шура чото наменял)
//
// Revision 1.28  2006/09/01 13:57:08  narry
// - более подробное логирование
//
// Revision 1.27  2006/08/24 10:00:41  narry
// - добавлена возможность импортировать ключевые слова без привязки к документам
//
// Revision 1.26  2006/03/27 13:20:05  lulin
// - cleanup.
//
// Revision 1.25  2005/07/21 14:20:14  narry
// - new: механизим импорта дельты ключевых слов
//
// Revision 1.24  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.23  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.22  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.21  2004/04/26 14:00:55  voba
// -replace Charset to CodePage
//
// Revision 1.20  2003/09/15 14:35:24  narry
// - update: механизм прерывания заливки
//
// Revision 1.19  2003/08/29 14:58:18  narry
// - new class: TddKeywordsPipe
// -
//
// Revision 1.18  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.17  2002/12/26 11:20:09  narry
// - new behavior: поддержка формата файла с эквивалентами
//
// Revision 1.16  2002/02/01 11:55:57  narry
// - update
//
// Revision 1.15  2001/12/13 09:31:11  narry
// - update
//
// Revision 1.14  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.13  2001/09/27 11:07:33  narry
// - update
//
// Revision 1.12  2000/12/15 15:29:54  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  Classes,
  l3Types, l3Base,
  k2TagGen, k2Reader,
  daTypes,
  dt_Types, dt_Const, dt_AttrSchema,
  ddProgressObj;

type
 TCustomDictLinkReader = class(Tk2CustomFileParser)
 private
   f_ClearOld : Boolean;
   fNeedAddToDictionary : Boolean;
   f_Abort : PBool;
   f_DictID: TdaDictionaryType;
   f_Family: TFamilyID;
   f_Renum: Boolean;
 protected
 public
   constructor Create(aOwner: Tk2TagGeneratorOwner); override;
   procedure Read; override;
 public
   property ClearOld: Boolean
     read f_ClearOld write f_ClearOld;

   property NeedAddToDictionary: Boolean
     read fNeedAddToDictionary write fNeedAddToDictionary;

   property AbortImport: PBool
     read f_Abort write f_Abort;
   property DictID: TdaDictionaryType read f_DictID write f_DictID;
   property Family: TFamilyID read f_Family write f_Family;
   property Renum: Boolean read f_Renum write f_Renum;
 end;

 TKWReader = class(TCustomDictLinkReader)
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner); override;
 end;

  TKWReaderEx = class(TCustomDictLinkReader)
  private
    procedure ClearKWOnDocuments;
  public
    constructor Create(aOwner: Tk2TagGeneratorOwner); override;
    procedure Read; override;
  end;

 TddDictLinkPipe = class(Tl3Base)
 private
  fAborted: PBool;
  fIsDelta: Boolean;
  fProgressor: TddProgressObject;
  fOnProgressProc: Tl3ProgressProc;
  f_KWR: TCustomDictLinkReader;
 private
  procedure SetProgressor(const Value: TddProgressObject);
  procedure SetOnProgressProc(const Value: Tl3ProgressProc);
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  function Execute(aFileName: AnsiString; aFamily: TFamilyID; aDict: TdaDictionaryType; aRenum, aClear, aAddNewItems: Boolean): boolean;
 public
  property Aborted: PBool read FAborted write FAborted;
  { Имя файла ключевых слов }
  property Progressor: TddProgressObject
   read FProgressor
   write SetProgressor;
 public
  property IsDelta: Boolean
   read FIsDelta
   write FIsDelta;
  property OnProgressProc: Tl3ProgressProc
   read FOnProgressProc
   write SetOnProgressProc;
 end;

 TDeltaKWReader = class(Tl3Base)
 private
  FDeletedKeys: TStrings;
  FDeltaFileName: AnsiString;
  FKeysAdded: Integer;
  FKeysCopied: Integer;
  FKeysDeleted: Integer;
  FKeysEdited: Integer;
  FKillFileName: AnsiString;
  f_Errors: TStrings;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  function Execute: Boolean;
  procedure ParseKWFile(aFilename: AnsiString);
 public
  property DeletedKeys: TStrings
   read FDeletedKeys write FDeletedKeys;
  property DeltaFileName: AnsiString
   read FDeltaFileName write FDeltaFileName;
  property Errors: TStrings read f_Errors write f_Errors;
  property KeysAdded: Integer read FKeysAdded;
  property KeysCopied: Integer read FKeysCopied;
  property KeysDeleted: Integer read FKeysDeleted;
  property KeysEdited: Integer read FKeysEdited;
  property KillFileName: AnsiString
   read FKillFileName write FKillFileName;
 end;


implementation

uses
  Forms, SysUtils, StrUtils,

  l3Chars, l3Tree_TLB, l3Parser, l3Filer, l3Memory,
  l3LongintList,
  l3String,

  afwFacade,

  daSchemeConsts,

  dtIntf, dt_Sab,
  dt_Serv,
  dt_ImpKW, dt_Link, dt_LinkServ, dt_Renum,
  dt_Dict, dt_DictConst, dt_DictIntf;

constructor TCustomDictLinkReader.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(aOwner);
 f_ClearOld:= True;
 f_Abort:= nil;
 with Parser do begin
  LineComment  := ';';
  OpenComment  := '';
  CloseComment := '';
  WhiteSpace   := [#0..#32]{-[#1..#6,#9,#10,#13]};
 end;{with Parser}
end;

procedure TCustomDictLinkReader.Read;
var
  KWServ          : TDictLinkImportServer;
  lRootNode        : Il3Node;
  lRootID          : TDictID;
  l_LineStream    : Tl3StringStream;
  l_LineParser    : Tl3CustomParser;
  l_KeyWord       : Tl3String;
  l_DocID         : TDocID;
  l_SubID         : TSubID;
  l_DictID        : TDictID;
  l_S             : Tl3String;
begin
  Filer.AnalizeCodePage;
  KWServ:= TDictLinkImportServer.Create(Family, DictID, ClearOld, fNeedAddToDictionary);
  try
   KWServ.ReNum:= Renum;
   l_LineParser := Tl3CustomParser.Create;
   try
    with l_LineParser do begin
     CheckKeyWords := false;
     CheckFloat := false;
     LineComment  := '';
     OpenComment  := '';
     CloseComment := '';
     WhiteSpace   := Parser.WhiteSpace;
    end;{with l_LineParser}
    l_KeyWord := Tl3String.Create;
    try
     l_LineStream := Tl3StringStream.Create;
     try
      while not Parser.Filer.EOF do begin
       afw.ProcessMessages;
       Parser.NextToken;
       if (Parser.TokenChar = '!') then
       begin
        {-это команда}
        if (AbortImport <> nil) and AbortImport^ then
          break;
        Parser.NextToken;
        if Parser.TokenSymbolIs('KEY') then
        begin
         {- это группа ключевых слов}
         lRootID := KWServ.GetRootKeyWord(l3PCharLen2String(l3LTrim(Filer.ReadLn),
                                                           CP_ANSI),
                                         lRootNode);
        end{'KEY'}
        else
        if Parser.TokenSymbolIs('EQ') then
         Filer.Readln
        else
        if Parser.TokenSymbolIs('ITEM') then
        begin
         {- это полный путь}
          
          {-здесь разбираем ключевые слова}
          l_S := Tl3String.Make(Filer.ReadLn);
          try
           l_LineStream._String := l_S;
          finally
           FreeAndNil(l_S);
          end;//try..finally
          try
           (*
           with l_LineStream._String do begin
            JoinWith(Filer.ReadLn, nil);
            CodePage := CP_ANSI;
           end;{with l_LineStream._String}
           *)
           l_LineStream._String.CodePage := CP_ANSI;
           with l_LineParser do begin
            CheckFiler.Stream := l_LineStream;
            try
             WhiteSpace := [];
             WordChars := [#0 .. #255] - [':'];
             {-концом ключевого слова является двоеточие}
             CheckInt := false;
             NextTokenPrim(l3NextTokenAllFlags - [l3_ntfCheckString]);
             l_KeyWord.Assign(TokenLongString);
             l_KeyWord.LTrim;
             {-вычленили ключевое слово}
             NextToken; {-пропускаем имя ключа}
             CheckInt := true;
             WhiteSpace := Parser.WhiteSpace;
             WordChars := Parser.WordChars;
             NextToken; {-пропускаем двоеточие}
             l_DictID := 0;
             if (l_LineParser.TokenType <> l3_ttEOF) then
              while (l_LineParser.TokenType <> l3_ttEOF) do
              begin
               {-перебираем номера документов до конца строки}
               l_DocID := TokenInt; {-берем номер документа}
               NextToken; {-пропускаем номер документа}
               if (TokenChar = '.') then
               begin
                NextToken; {-пропускаем точку}
                l_SubID := TokenInt; {-должен быть номер Sub'а}
                NextToken; {-пропускаем номер Sub'а}
               end
               else
                l_SubID := 0;
                KWServ.AddKeyWord(lRootNode, l_DictID, l_KeyWord.AsWStr, l_DocID, l_SubID);
              end{while (l_LineParser.TokenType <> l3_ttEOF)}
             else
             if not l_Keyword.Empty then
              KWServ.AddKeyWord(lRootNode, l_DictID, l_KeyWord.AsWStr, 0{l_DocID}, 0{l_SubID});
            finally
             Filer.Stream := nil;
            end;{try..finally}
           end;{with l_LineParser}
          finally
           l_LineStream._String := nil;
          end;{try..finally}
        end;
       end
       else
       begin
        {-здесь разбираем ключевые слова}
        l_LineStream._String := Parser.TokenLongString;
        try
         with l_LineStream._String do
         begin
          Append(Filer.ReadLn);
          CodePage := CP_ANSI;
         end;{with l_LineStream._String}
         with l_LineParser do begin
          CheckFiler.Stream := l_LineStream;
          try
           WhiteSpace := [];
           WordChars := [#0 .. #255] - [':'];
           {-концом ключевого слова является двоеточие}
           CheckInt := false;
           NextTokenPrim(l3NextTokenAllFlags - [l3_ntfCheckString]);
           l_KeyWord.Assign(TokenLongString);
           l_KeyWord.LTrim;
           {-вычленили ключевое слово}
           NextToken; {-пропускаем имя ключа}
           CheckInt := true;
           WhiteSpace := Parser.WhiteSpace;
           WordChars := Parser.WordChars;
           NextToken; {-пропускаем двоеточие}
           l_DictID := 0;
           if (l_LineParser.TokenType <> l3_ttEOF) then
            while (l_LineParser.TokenType <> l3_ttEOF) do
            begin
             {-перебираем номера документов до конца строки}
             l_DocID := TokenInt; {-берем номер документа}
             NextToken; {-пропускаем номер документа}
             if (TokenChar = '.') then
             begin
              NextToken; {-пропускаем точку}
              l_SubID := TokenInt; {-должен быть номер Sub'а}
              NextToken; {-пропускаем номер Sub'а}
             end
             else
              l_SubID := 0;
              KWServ.AddKeyWord(lRootID, lRootNode, l_DictID, l_KeyWord.AsWStr, l_DocID, l_SubID);
            end{while (l_LineParser.TokenType <> l3_ttEOF)}
           else
           if not l_Keyword.Empty then
            KWServ.AddKeyWord(lRootID, lRootNode, l_DictID, l_KeyWord.AsWStr, 0{l_DocID}, 0{l_SubID});
          finally
           Filer.Stream := nil;
          end;{try..finally}
         end;{with l_LineParser}
        finally
         l_LineStream._String := nil;
        end;{try..finally}
       end;{Parser.TokenChar = '!'}
      end;{while not EOF}
      l3System.Msg2Log('Разбор файла ключевых слов закончен');
     finally
      l3Free(l_LineStream);
     end;{try..finally}
    finally
     l3Free(l_KeyWord);
    end;{try..finally}
   finally
    l3Free(l_LineParser);
   end;{try..finally}
  finally
   l3Free(KWServ);
  end;{try..finally}
end;

{ TddKeywordsPipe }

constructor TddDictLinkPipe.Create;
begin
 inherited;
end;

function TddDictLinkPipe.Execute(aFileName: AnsiString; aFamily: TFamilyID; aDict: TdaDictionaryType; aRenum, aClear, aAddNewItems:
    Boolean): boolean;
var
 l_InFiler: Tl3DOSFiler;
 l_Msg: AnsiString;
begin
 if IsDelta then
  f_KWR:= TKWReaderEx.Create(nil)
 else
  f_KWR:= TCustomDictLinkReader.Create(nil);
 try
  f_KWR.Family := aFamily;
  f_KWR.DictID:= aDict;
  f_KWR.ClearOld := aClear;
  f_KWR.fNeedAddToDictionary := aAddNewItems;
  f_KWR.AbortImport := FAborted;
  f_KWR.Renum:= aRenum;
  l_InFiler:= Tl3DOSFiler.Create(nil);
  try
   l_InFiler.FileName:= aFileName;
   l_InFiler.Indicator.NeedProgressProc:= True;
   f_KWR.Filer:= l_InFiler;
   l_Msg:= Format('Импорт файла связи словаря %s', [cDLPassports[aDict].rName]);
   if fProgressor <> nil then
   begin
    l_InFiler.Indicator.OnProgressProc:= fProgressor.ProcessUpdate;
   end
   else
    l_InFiler.Indicator.OnProgressProc:= fOnProgressProc;
   try
    l3System.Msg2Log('%s начался', [l_Msg]);
    f_KWR.Execute;
    l3System.Msg2Log('%s завершен', [l_Msg]);
    Result:= True;
   except
    on E: Exception do
    begin
     l3System.Exception2Log(E);
     Result:= False;
    end;
   end;
  finally
   l3FRee(l_InFiler);
  end;
 finally
  l3Free(f_KWR);
 end;
end;

procedure TddDictLinkPipe.Cleanup;
begin
 inherited;
end;

procedure TddDictLinkPipe.SetOnProgressProc(const Value: Tl3ProgressProc);
begin
  FOnProgressProc := Value;
end;

procedure TddDictLinkPipe.SetProgressor(const Value: TddProgressObject);
begin
  FProgressor := Value;
end;

constructor TKWReaderEx.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(aOwner);
 f_ClearOld:= False;
 f_Abort:= nil;
end;

procedure TKWReaderEx.ClearKWOnDocuments;
var
  l_LineStream    : Tl3StringStream;
  l_LineParser    : Tl3CustomParser;
  l_KeyWord       : Tl3String;
  l_DocID         : TDocID;
  l_SubID         : TSubID;
  l_DocumentIndex : TDictID;
  lSab            : ISab;
  lValFiller      : IValueSetFiller;
  l_S             : Tl3String;
begin
  Filer.AnalizeCodePage;

  lSab := MakeSab(LinkServer(Family)[atKeyWords]);
  lValFiller := lSab.MakeValueSetFiller(lnkDocIDFld);

  l_LineParser := Tl3CustomParser.Create;
  try
   l_LineStream := Tl3StringStream.Create;
   try
    l_S := Tl3String.Make(Filer.Readln);
    try
     l_LineStream._String := l_S;
    finally
     FreeAndNil(l_S);
    end;//try..finally
    try
     with l_LineParser do
     begin
      CheckFiler.Stream := l_LineStream;
      try
       WhiteSpace := [];
       WordChars := ['0'..'9'];
       CheckInt := True;
       NextTokenPrim(l3NextTokenAllFlags - [l3_ntfCheckString]);
       {-вычленили ключевое слово}
       NextToken; {-пропускаем двоеточие}
       l_DocumentIndex := 0;
       while (l_LineParser.TokenType <> l3_ttEOF) do
       begin
        {-перебираем номера документов до конца строки}
        l_DocID := TokenInt; {-берем номер документа}
        NextToken; {-пропускаем номер документа}
        NextToken; {-пропускаем двоеточие}
        lValFiller.AddValue(l_DocID);
       end;{while (l_LineParser.TokenType <> l3_ttEOF)}
      finally
       Filer.Stream := nil;
      end;{try..finally}
     end;{with l_LineParser}
    finally
     l_LineStream._String := nil;
    end;{try..finally}
    lValFiller := nil;

    LinkServer(Family).Renum.ConvertToInternalNumbers(lSab);
    LinkServer(Family)[atKeyWords].DelAllLinkItems(lSab);
    l3System.Msg2Log('Очистка ключей завершена');
   finally
    l3Free(l_LineStream);
   end;
  finally
   l3Free(l_LineParser);
  end;// l_LineParser
end;

procedure TKWReaderEx.Read;
begin
 ClearKWOnDocuments;
 inherited;
end;

constructor TDeltaKWReader.Create;
begin
 inherited;
 FDeletedKeys := TStringList.Create;
 f_Errors:= TStringList.Create;
end;

procedure TDeltaKWReader.Cleanup;
begin
 l3Free(f_Errors);
 l3Free(FDeletedKeys);
 inherited;
end;

function TDeltaKWReader.Execute: Boolean;
begin
 FKeysAdded:= 0;
 FKeysCopied:= 0;
 FKeysDeleted:= 0;
 FKeysEdited:= 0;
 f_Errors.Clear;
 ParseKWFile(DeltaFileName);
 ParseKWFile(KillFileName);
 Result := FDeletedKeys.Count <> 0;
end;

(*
[DELETED]!KEY K2[CREATED] !KEY K1 - переименование ключа
[DELETED]!KEY K1                  - удаление ключа
[CREATED]!KEY K1                  - создание ключа
!KEY K1
 * Далее по умолчанию поле действия - KEY K1.
      дальнейшие команды воспринимаются под полем
      действия ближайшей сверху команды !KEY.

  [DELETED]subkey1[CREATED]subkey2 - переименование подключа
  [CREATED]subkey1                 - создание подключа
  [DELETED]subkey1                 - удаление подключа

  [RELOCATED]subkey[NEWKEY]K1[NEWKEY]K2... - перемещает subkey в ключи K1, K2,...
*)
procedure TDeltaKWReader.ParseKWFile(aFilename: AnsiString);
var
 l_Filer: TevDOSFiler;
 l_Str : Tl3String;
 l_Root, l_OldItem, l_NewItem : AnsiString;
 l_IsKey : Boolean;
 l_Pos : Integer;
 l_Fullpath, l_FullPath2 : AnsiString;
 l_ID : Integer;
 l_FullPathNew: AnsiString;
 l_OldID, l_NewID: TDictID;
 l_Node   : Il3Node;
 l_ParentNode : Il3Node;
begin
 l_Filer:= TevDOSFiler.Make(aFileName);
 try
  l_Filer.Open;
  while not l_Filer.EOF do
  begin
   l_Str := Tl3String.Make(l_Filer.ReadLn);
   try
    l_Str.CodePage := CP_ANSI;
    l_Str.TrimAll;
    if not l_Str.Empty then
    begin
     if AnsiStartsText('!KEY', l_Str.St) then
     begin
      l_Str.Delete(0, 5);
      l_Root := l_Str.AsString;
     end // l_Str.St[0] = '!'
     else
     begin
      l_IsKey := AnsiContainsText(l_Str.St, '!KEY');
      if AnsiStartsText('[DELETED]', l_Str.St) then
      begin
       l_Str.Delete(0, 9); // [DELETED]
       if l_IsKey then
       begin
        l_Str.Delete(0, 5);
        l_Root := '';
       end;
       l_Str.TrimAll;
       if AnsiContainsText(l_Str.St, '[CREATED]') then
       begin
        l_Pos := ansiPos('[CREATED]', l_Str.St);
        l_OldItem:= Copy(l_Str.AsString, 1, Pred(l_Pos));
        l_Str.Delete(0, Pred(l_Pos));
        l_Str.Delete(0, 9); // [CREATED]
        if l_IsKey then
         l_Str.Delete(0, 5);
        l_Str.TrimAll;
        l_NewItem := l_Str.AsString;
        // переименование элемента
        l_Fullpath := l_Root + '\' + l_OldItem;
        l_Node := DictServer(CurrentFamily).Dict[da_dlKeyWords].FindNodeByFullPath(l3PCharLen(l_Fullpath));

        if l_Node = nil then
         f_Errors.Add(Format('Ошибка переименования %s в %s - исходный элемент отсутствует', [l_FullPath, l_NewItem]))
        else
        begin
         l_FullPathNew:= l_Root + '\' + l_NewItem;
         l_OldID:= DictServer(CurrentFamily).Dict[da_dlKeyWords].FindIdByFullPath(l3PCharLen(l_FullPath));
         l_NewID:= DictServer(CurrentFamily).Dict[da_dlKeyWords].FindIdByFullPath(l3PCharLen(l_FullPathNew));

         try
          if (l_NewID <> cUndefDictID) and (l_OldID <> l_NewID) then
           (l_Node as IPersistentNode).DeleteEx(l_NewID)
          else
           with DictServer(CurrentFamily).Dict[da_dlKeyWords] do
            EditDictItem(l_OldID, l3PCharLen(l_NewItem), l3PCharLen, l3PCharLen);
           Inc(FKeysEdited);
         except
          on E: Exception do
          begin
           l3System.Msg2Log('Не удалось переименовать элемент "%s"', [l_FullPath]);
           l3System.Msg2Log(E.Message);
          end; // on E
         end; // try..except
        end; // l_Node = nil
       end
       else
       begin
        // чистый [DELETED] без переименования
        //заносим FDeletedKeys и выставляем l_Root для следующих
        if l_IsKey then
        begin
         fDeletedKeys.Add(l_Str.AsString);
         l_Root := l_Str.AsString;
        end
        else
         fDeletedKeys.Add(l_Root + '\' + l_Str.AsString);
       end;
      end
      else
      if AnsiStartsText('[CREATED]', l_Str.St) then
      begin
       l_Str.Delete(0, 9); // [CREATED]
       if l_IsKey then
       begin
        l_Str.Delete(0, 5); // [KEY]
        l_Root := '';
       end;
       l_Str.TrimAll;
       l_NewItem := l_Str.AsString;
       // создание элемента
       l_FullPath := l_Root;
       try
        l_Fullpath2 := IfThen(l_IsKey, l_NewItem, l_FullPath + '\' + l_NewItem);
        if DictServer(CurrentFamily).Dict[da_dlKeyWords].FindIdByFullPath(l3PCharLen(l_Fullpath2)) = cUndefDictID then
        begin
         with DictServer(CurrentFamily).Dict[da_dlKeyWords] do
          AddDictNode(cUndefDictID, l3PCharLen(l_NewItem), l3PCharLen(cEmptyEngName), l3PCharLen,  FindNodeByFullPath(l3PCharLen(l_FullPath)));
         Inc(FKeysAdded);
        end;
       if l_IsKey then
        l_Root := l_NewItem;
       except
        on E: Exception do
        begin
         f_Errors.Add(Format('Не удалось добавить элемент "%s"', [l_FullPath]));
         l3System.Msg2Log('Не удалось добавить элемент "%s"', [l_FullPath]);
         l3System.Msg2Log(E.Message);
        end;
       end;
      end
      else
      // [RELOCATED]subkey[NEWKEY]K1[NEWKEY]K2... - перемещает subkey в ключи K1, K2,...
      if AnsiStartsText('[RELOCATED]', l_Str.St) then
      begin
       l_Str.Delete(0, 11); // [RELOCATED]
       l_Pos := AnsiPos('[NEWKEY]', l_Str.St);
       if l_Pos > 0 then
       begin
        l_OldItem := Copy(l_Str.AsString, 0, Pred(l_Pos));
        l_FullPath := l_Root + '\' + l_OldItem;
        l_Str.Delete(0, Pred(l_Pos));
        l_Str.TrimAll;
        while not l_Str.Empty do
        begin
         l_Str.Delete(0, 8); // NEWKEY
         l_Str.TrimAll;
         l_Pos := AnsiPos('[NEWKEY]', l_Str.St);
         if l_Pos = 0 then
         begin
          l_NewItem := l_Str.AsString;
          l_Str.Delete(0, l_Str.Len);
         end
         else
         begin
          l_NewItem := Copy(l_Str.AsString, 0, Pred(l_Pos));
          l_Str.Delete(0, Pred(l_Pos));
          l_Str.TrimAll;
         end;
         l_FullPath2 := l_NewItem + '\' + l_OldItem;
         // Добавление-Удаление
         if DictServer(CurrentFamily).Dict[da_dlKeyWords].FindIdByFullPath(l3PCharLen(l_Fullpath2)) = cUndefDictID then
         begin
          l_ParentNode := DictServer(CurrentFamily).Dict[da_dlKeyWords].FindNodeByFullPath(l3PCharLen(l_NewItem));
          if l_ParentNode = nil then
           l_ParentNode := DictServer(CurrentFamily).Dict[da_dlKeyWords].AddDictNode(cUndefDictID, l3PCharLen(l_NewItem), l3PCharLen(cEmptyEngName), l3PCharLen, nil);

          DictServer(CurrentFamily).Dict[da_dlKeyWords].AddDictNode(cUndefDictID, l3PCharLen(l_OldItem), l3PCharLen(cEmptyEngName), l3PCharLen, l_ParentNode);
         end; 
         try
          LinkServer(CurrentFamily).CopyLinks(atKeywords, l3PCharLen(l_FullPath), l3PCharLen(l_FullPath2));
          Inc(FKeysCopied);
         except
          on E: Exception do
          begin
           f_Errors.Add(Format('Не удалось скопировать элемент "%s" в "%s"', [l_FullPath, l_Fullpath2]));
           l3System.Msg2Log('Не удалось скопировать элемент "%s" в "%s"', [l_FullPath, l_Fullpath2]);
           l3System.Exception2Log(E);
          end;
         end;
         l_Node := DictServer(CurrentFamily).Dict[da_dlKeyWords].FindNodeByFullPath(l3PCharLen(l_Fullpath));
         if l_Node <> nil then
         try
          l_Node.Delete;
         except
          on E: Exception do
          begin
           f_Errors.Add(Format('Не удалось удалить элемент "%s"', [l_FullPath]));
           l3System.Msg2Log(Format('Не удалось удалить элемент "%s"', [l_FullPath]));
           l3System.Msg2Log(E.Message);
          end;
         end;
        end; // while l_Pos <> 0
       end
      end;
     end;
    end; // not l_Str.Empty
   finally
    FreeAndNil(l_Str);
   end;//try..finally
  end; // while not l_Filer.EOF
 finally
  l3Free(l_Filer);
 end; // l_Filer
end;

constructor TKWReader.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(aOwner);
 DictID:= da_dlKeywords;
end;

end.
