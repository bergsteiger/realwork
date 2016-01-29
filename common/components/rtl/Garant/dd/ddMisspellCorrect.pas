unit ddMisspellCorrect;

{ $Id: ddMisspellCorrect.pas,v 1.34 2015/05/15 12:14:29 fireton Exp $ }

// $Log: ddMisspellCorrect.pas,v $
// Revision 1.34  2015/05/15 12:14:29  fireton
// - не происходила замена, если были ТОЛЬКО регекспы
//
// Revision 1.33  2014/08/12 11:20:57  fireton
// - выделяем функцию поиска одной строки
//
// Revision 1.32  2014/04/16 09:50:34  fireton
// - зацикливалось
//
// Revision 1.31  2014/04/11 15:30:50  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.30  2014/04/10 11:59:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.29  2014/04/08 14:17:10  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.28  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.27  2014/04/03 17:10:42  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.26  2014/02/28 14:54:30  lulin
// - перетряхиваем генераторы.
//
// Revision 1.25  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.24  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.23  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.22  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.21  2013/08/13 11:05:38  fireton
// - LoadPairs -> public
//
// Revision 1.20  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.19  2013/04/05 12:04:29  lulin
// - портируем.
//
// Revision 1.18  2012/12/13 09:45:17  fireton
// - блок теперь умеет обновлять границы, удаляем костыль
//
// Revision 1.17  2012/11/20 10:58:13  fireton
// - делаем возможным отчёты о замене опечаток
//
// Revision 1.16  2012/01/31 11:04:04  fireton
// - неверно создавался searcher для поиска регулярных выражений
//
// Revision 1.15  2011/12/29 04:09:06  fireton
// - сообщения об исправлении опечаток не попадали в лог
//
// Revision 1.14  2011/11/22 11:44:38  fireton
// - замена опечаток по регулярным выражениям
//
// Revision 1.13  2011/09/22 08:40:40  lulin
// {RequestLink:284164798}.
//
// Revision 1.12  2011/09/07 12:48:25  fireton
// - переводим исправление опечаток на поисковое дерево
//
// Revision 1.11  2011/09/07 11:37:57  narry
// Не исправляются опечатки на этапе заливки апелляций (281525895)
//
// Revision 1.10  2011/08/26 10:59:59  fireton
// - выносим создание контекста за скобки
//
// Revision 1.9  2011/08/25 14:04:47  fireton
// - попытки избавиться от накладных расходов
//
// Revision 1.8  2011/07/07 05:59:40  narry
// Утилита исправления названий и текстов (271757472)
//
// Revision 1.7  2011/05/24 15:12:38  fireton
// - отчитываемся о ненайденных опечатках
//
// Revision 1.6  2011/01/28 13:25:31  fireton
// - возможность отключенияпроверки имён
// - кастомная категория сообщений в лог
//
// Revision 1.5  2011/01/28 12:56:36  fireton
// - проверяем имя документа и блоков/сабов
//
// Revision 1.4  2010/05/19 13:12:54  dinishev
// Bug fix: не компилировался Арчи в ветке
//
// Revision 1.3  2010/05/19 11:00:21  narry
// - K211878089
//
// Revision 1.2  2010/05/17 08:31:20  narry
// - K211878129
// - переименование типов
//
// Revision 1.1  2010/05/07 14:19:58  fireton
// - initial
//

interface

uses
 l3Types,
 l3Interfaces,
 l3LongintList,
 l3ProtoObject,

 k2Types,
 k2TagGen,
 k2Interfaces,
 k2Prim,
 k2Context,

 evdLeafParaFilter,

 evTypes,
 evSearch,
 evInternalInterfaces,
 evSearcherAndReplacerPairList,

 nevTools, l3CustomString,

 ddTypes,
 ddSearchTree;

type
 IddReplaceData = interface(Il3Base)
  ['{2B0E1F36-DC8F-4253-80EC-3C3BCE848C1A}']
  function pm_GetReplaceStr: Il3CString;
  function pm_GetSearchStr: Il3CString;
  function pm_GetUpperReplaceStr: Il3CString;
  function pm_GetFirstUpperReplaceStr: Il3CString;
  function pm_GetUsed: Boolean;
  procedure pm_SetUsed(const Value: Boolean);
  property ReplaceStr: Il3CString read pm_GetReplaceStr;
  property SearchStr: Il3CString read pm_GetSearchStr;
  property UpperReplaceStr: Il3CString read pm_GetUpperReplaceStr;
  property FirstUpperReplaceStr: Il3CString read pm_GetFirstUpperReplaceStr;
  property Used: Boolean read pm_GetUsed write pm_SetUsed;
 end;

 IddReplaceDataProvider = interface(Il3Base)
  ['{F6D05BE3-35D0-4A9D-A784-67B593D96A41}']
  function pm_GetReplaceData: IddReplaceData;
  property ReplaceData: IddReplaceData read pm_GetReplaceData;
 end;

 IddReplaceReporter = interface(Il3Base)
  ['{1110F4CD-14B1-4FD9-98A7-41315B484F57}']
  procedure DoReportReplace(const aFrom, aTo: Il3CString);
 end;

 TddReplaceDataImpl = class(Tl3ProtoObject, IddReplaceData)
 private
  f_Used : Boolean;
  f_SearchStr: Il3CString;
  f_ReplaceStr: Il3CString;
  f_UpperReplaceStr: Il3CString;
  f_FirstUpperReplaceStr: Il3CString;
 protected
  function pm_GetReplaceStr: Il3CString;
  function pm_GetUpperReplaceStr: Il3CString;
  function pm_GetFirstUpperReplaceStr: Il3CString;
  function pm_GetSearchStr: Il3CString;
  function pm_GetUsed: Boolean;
  procedure pm_SetUsed(const Value: Boolean);
  procedure Cleanup; override;
 public
  constructor Create(const aSearchStr, aReplaceStr: Il3CString);
 end;

 TddMisspellSearcher = class(TevBaseSearcher, IddErrorHandler, IddReplaceDataProvider)
 private
  f_FoundData: IInterface;
  f_OnError: TddErrorEvent;
  f_SearchTree: TddSearchTree;
  function pm_GetOnError: TddErrorEvent; stdcall;
  procedure pm_SetOnError(aValue: TddErrorEvent); stdcall;
 protected
  procedure Cleanup; override;
  function pm_GetReplaceData: IddReplaceData;
 public
  constructor Create(anOwner: TevSearchToolOwner = nil); override;
  procedure AddPair(const aSearchStr, aReplaceStr: Il3CString);
  procedure Clear;
  function DoCheckText(aPara : Tl3Variant;
                             aText : Tl3CustomString;
                       const  aSel : TevPair;
                       out  theSel : TevPair): Bool;
      override;
  procedure DropUsed;
  function GetUnusedStrings: AnsiString;
  function HasData: Boolean;
  property OnError: TddErrorEvent read pm_GetOnError write pm_SetOnError;
 end;

 TddGetExternalDocIDEvent = function (aID : Longint): Longint of object;

 TddMisspellReplacer = class(TevBaseReplacer)
 private
  f_ReplaceReporter: Pointer;
  function pm_GetReplaceReporter: IddReplaceReporter;
  procedure pm_SetReplaceReporter(const Value: IddReplaceReporter);
 protected
        {-}
  function ReplaceFunc(const aView : InevView; const Container : InevOp; const aBlock : InevRange): Bool; override;
 public
  property ReplaceReporter: IddReplaceReporter read pm_GetReplaceReporter write pm_SetReplaceReporter;
 end;

 TddMisspellRegExpReplacer = class(TevRegExpReplacer)
 private
  f_ReplaceReporter: Pointer;
  function pm_GetReplaceReporter: IddReplaceReporter;
  procedure pm_SetReplaceReporter(const Value: IddReplaceReporter);
 public
  function ReplaceFunc(const aView : InevView; const Container : InevOp; const aBlock : InevRange): Bool; override;
  class function Make(const aText: AnsiString; const aReporter: IddReplaceReporter = nil; anOptions : TevSearchOptionSet = []): IevReplacer;
  property ReplaceReporter: IddReplaceReporter read pm_GetReplaceReporter write pm_SetReplaceReporter;
 end;

 TddMisspellCorrectFilter = class(TevdLeafParaFilter, IddErrorHandler, InevConfirm, Il3DocIDSource, IddReplaceReporter)
 private
  f_Category: Integer;
  f_Searcher: TddMisspellSearcher;
  f_Replacer: TddMisspellReplacer;
  f_RegExPairs: TevSearcherAndReplacerPairList;
  f_CheckNames: Boolean;
  f_CurBlock: Integer;
  f_DocID: Integer;
  f_ExtDocID: Integer;
  f_NeedErrorsLog: Boolean;
  f_OnError: TddErrorEvent;
  f_OnGetExternalDocID: TddGetExternalDocIDEvent;
  f_Op : Il3OpPack;
  function pm_GetOnError: TddErrorEvent; stdcall;
  procedure pm_SetOnError(aValue: TddErrorEvent); stdcall;
 protected
  procedure DoWritePara(aLeaf: Tl3Variant); override;
  procedure Cleanup; override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure CloseStructure(NeedUndo: Boolean); override;
  function pm_GetDocID: Integer;
  procedure pm_SetDocID(aValue: Integer);
 private
  // InevConfirm methods
  function ReplaceConfirm(const aBlock: InevRange; AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
    {* запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
  procedure DoReportReplace(const aFrom, aTo: Il3CString);
  function DeleteFoundRgn: Boolean;
  procedure InevConfirmUpdate;
  procedure InevConfirm.Update = InevConfirmUpdate;
  procedure DoLog(const aMsg: AnsiString);
  function Get_Progress: InevProgress;
  function Get_View: InevView;
  procedure DoReplace(aPara: Tl3Variant; aBlockLog: Boolean); overload;
  function DoReplace(const aText: Tl3WString; aBlockLog: Boolean): Il3CString; overload;
  procedure pm_SetNeedErrorsLog(const Value: Boolean);
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
   {-}
  procedure Reset;
  procedure AddPair(const aSearchFor, aReplaceTo: Tl3WString);
  procedure AddRegExpPair(const aSearchFor, aReplaceTo: Tl3WString);
  procedure SetOnError(aCategory: Integer; aHandler: TddErrorEvent);
  property CheckNames: Boolean read f_CheckNames write f_CheckNames;
  property DocID: Integer read pm_GetDocID write pm_SetDocID;
  property NeedErrorsLog: Boolean read f_NeedErrorsLog write pm_SetNeedErrorsLog;
  property OnGetExternalDocID: TddGetExternalDocIDEvent read f_OnGetExternalDocID write f_OnGetExternalDocID;
  property OnError: TddErrorEvent read pm_GetOnError write pm_SetOnError;
 end;

 TddMisspellCorrectFilterEx = class(TddMisspellCorrectFilter)
 public
  procedure LoadPairs(const aFileName: AnsiString);
  procedure ParsePairsString(const aSource: Tl3WString);
  class function SetTo(var theGenerator: Tk2TagGenerator; const aFileName:
      AnsiString; aCategory: Integer = 0; aOnError: TddErrorEvent = nil): Pointer;
      overload;
 end;

const
 cMisspellReportCategory = 3;

function ddParsePairsString(const aSource: Tl3WString; aFilter: TddMisspellCorrectFilter): Longint;
{ парсит строку вида "nnn:from1=to1;from2=to2;..." в пары для поиска/замены и возвращает nnn}

function ddAddOnePair(const aSource: Tl3WString; aFilter: TddMisspellCorrectFilter): Boolean;

implementation

uses
 Controls,
 SysUtils,
 StrUtils,

 l3Variant,
 l3Base,
 l3InterfacedString,
 l3String,
 l3Filer,
 l3PrimString,
 l3SearchNode,
 l3MinMax,

 k2Base,
 k2Tags,
 k2OpRefList,
 k2VariantImpl,
 k2String,
 TextPara_Const,
 Sub_Const,
 Document_Const,

 evdTypes,
 evIntf,
 evParaTools,
 nevConfirm,
 evSegLst,
 evCursorConst
 ;

const
 c_SROptions = [ev_soFind, ev_soGlobal, ev_soConfirm, ev_soReplaceAll, ev_soNoException];


function ddAddOnePair(const aSource: Tl3WString; aFilter: TddMisspellCorrectFilter): Boolean;
var
 l_Src: Tl3WString;
 l_Pos: Integer;
 l_From: Tl3WString;
 l_IsRegExp: Boolean;
 l_To  : Tl3WString;
begin
 Result := False;
 l_Src := l3Trim(aSource);
 if not l3IsNil(l_Src) then
 begin
  l_IsRegExp := l3IsChar(l_Src, 0, '#');
  if l_IsRegExp then
   l_Src := l3Copy(l_Src, 1, MaxInt);
  l_Pos := ev_lpCharIndex('=', l_Src);
  if l_Pos >= 0 then
  begin
   l_From := l3Trim(l3Copy(l_Src, 0, l_Pos));
   l_To   := l3Trim(l3Copy(l_Src, l_Pos+1, MaxInt));
   if (not l3IsNil(l_From)) and (not l3IsNil(l_To)) then
   begin
    if l_IsRegExp then
     aFilter.AddRegExpPair(l_From, l_To)
    else
     aFilter.AddPair(l_From, l_To);
    Result := True;
   end;
  end;
 end;
end;


function ddParsePairsString(const aSource: Tl3WString; aFilter: TddMisspellCorrectFilter): Longint;
var
 l_DocID: Integer;

 function DoPair(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  if l_DocID < 0 then
  begin
   try
    l_DocID := l3StrToInt(aStr);
   except
    l_DocID := -1;
   end;
   Result := l_DocID >= 0;
  end
  else
   ddAddOnePair(aStr, aFilter);
 end;
begin
 Result := -1;
 l_DocID := -1;
 aFilter.Reset;
 if not l3IsNil(aSource) then
  l3ParseWordsExF(aSource, l3L2WA(@DoPair), [':',';']);
 if aFilter.f_Searcher.HasData then
  Result := l_DocID;
end;

type
  TddContext = class(Tk2Context)
    protected
      function GetSaveUndo: Boolean; override;
        {-}
  end;//TddContext

function TddContext.GetSaveUndo: Boolean;
  {-}
begin
 Result := false;
end;

constructor TddMisspellCorrectFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
var
 l_Op : Tk2Context;
begin
 inherited;
 f_Searcher := TddMisspellSearcher.Create;
 f_Searcher.Options := c_SROptions;
 f_Replacer := TddMisspellReplacer.Create;
 f_Replacer.Options := c_SROptions;
 f_Replacer.Searcher := f_Searcher;
 f_Replacer.ReplaceReporter := Self;
 f_RegExPairs := TevSearcherAndReplacerPairList.Create;
 f_CheckNames := True;
 f_Category:= cMisspellReportCategory;
 l_Op := TddContext.Create(nil);
 try
  f_Op := l_Op;
 finally
  FreeAndNil(l_Op);
 end;
 NeedErrorsLog := True;
end;

procedure TddMisspellCorrectFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_Str  : Tk2String;
 l_Value: Tk2Variant;
begin
 if CheckNames and CurrentType.IsKindOf(k2_typSub) then
 begin
  case AtomIndex of
   k2_tiHandle:
    f_CurBlock := Value.AsInteger;
   k2_tiName, k2_tiShortName:
    begin
     if CurrentType.IsKindOf(k2_typDocument) then
     begin
      f_CurBlock := 0;
      f_Searcher.DropUsed;
     end;
     l_Str := Tk2String.Make(DoReplace(Value.AsString.AsWStr, True).AsWStr);
     try
      l_Value := Tk2VariantImpl.Make(l_Str);
      try
       inherited AddAtomEx(AtomIndex, l_Value);
      finally
       l_Value := nil;
      end;
      Exit;
     finally
      FreeAndNil(l_Str);
     end;
    end;
  end; // case
 end;
 inherited; 
end;

procedure TddMisspellCorrectFilter.AddPair(const aSearchFor, aReplaceTo: Tl3WString);
begin
 f_Searcher.AddPair(l3CStr(aSearchFor), l3CStr(aReplaceTo));
end;

procedure TddMisspellCorrectFilter.AddRegExpPair(const aSearchFor, aReplaceTo: Tl3WString);
var
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
begin
 l_Searcher := TevRegularExpressionSearcher.Make(l3Str(aSearchFor), c_SROptions);
 l_Searcher.Options := c_SROptions;
 l_Replacer := TddMisspellRegExpReplacer.Make(l3Str(aReplaceTo), Self, c_SROptions);
 l_Replacer.Options := c_SROptions;
 l_Replacer.Searcher := l_Searcher;
 f_RegExPairs.Add(TevSearcherAndReplacerPair_C(l_Searcher, l_Replacer));
end;

procedure TddMisspellCorrectFilter.Cleanup;
begin
 FreeAndNil(f_Searcher);
 FreeAndNil(f_Replacer);
 FreeAndNil(f_RegExPairs);
 inherited;
end;

procedure TddMisspellCorrectFilter.CloseStructure(NeedUndo: Boolean);
var
 I: Integer;
 l_SR: IevSearcher;
 l_Str: AnsiString;
begin
 if CurrentType.IsKindOf(k2_typDocument) and NeedErrorsLog then
 begin
  l_Str := f_Searcher.GetUnusedStrings;
  if l_Str <> '' then
   DoLog(l_Str);
 end;
 inherited;
end;

function TddMisspellCorrectFilter.DeleteFoundRgn: Boolean;
begin
 // empty
end;

procedure TddMisspellCorrectFilter.DoLog(const aMsg: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg, f_Category)
 else
  l3System.Msg2Log(aMsg, f_Category);
end;

procedure TddMisspellCorrectFilter.DoWritePara(aLeaf: Tl3Variant);
begin
 DoReplace(aLeaf, True);
 inherited;
end;

function TddMisspellCorrectFilter.Get_Progress: InevProgress;
begin
 Result := nil;
end;

function TddMisspellCorrectFilter.Get_View: InevView;
begin
 Result := nil;
end;

procedure TddMisspellCorrectFilter.InevConfirmUpdate;
begin
 // empty
end;

procedure TddMisspellCorrectFilter.DoReplace(aPara: Tl3Variant; aBlockLog: Boolean);
var
 I: Integer;
 l_Para: InevPara;
 l_Confirm: InevConfirm;
 l_Block   : InevRange;
 l_SRPair: TevSearcherAndReplacerPair;
begin
 if ((f_Searcher.HasData) or (f_RegExPairs.Count > 0)) and aPara.QT(InevPara, l_Para) then
 begin
  l_Block := l_Para.Range;
  try
   if aBlockLog then
    l_Confirm := Self
   else
    l_Confirm := TnevConfirm.Make;
   if f_Searcher.HasData then
    l_Block.SearchReplace(f_Searcher, f_Replacer, l_Confirm, nil, f_Op, False);
   for I := 0 to f_RegExPairs.Count - 1 do
   begin
    l_SRPair := f_RegExPairs.Items[I];
    l_Block.SearchReplace(l_SRPair.rSearcher, l_SRPair.rReplacer, l_Confirm, nil, f_Op, False);
   end;
  finally
   l_Block := nil;
  end;//try..finally
 end;
end;

function TddMisspellCorrectFilter.DoReplace(const aText: Tl3WString; aBlockLog: Boolean): Il3CString;
var
 l_Para: Tl3Variant;
begin
 l_Para := k2_typTextPara.MakeTag.AsObject;
 l_Para.PCharLenA[k2_tiText] := Tl3PCharLen(aText);
 DoReplace(l_Para, aBlockLog);
 Result := l3CStr(l_Para.PCharLenA[k2_tiText]);
end;

procedure TddMisspellCorrectFilter.DoReportReplace(const aFrom, aTo: Il3CString);
var
 l_S: Il3CString;
begin
 if f_DocID > 0 then
 begin
  if f_ExtDocID > 0 then
   l_S := l3Fmt(l3CStr('#%d, блок %d ("%s" -> "%s")'), [f_ExtDocID, f_CurBlock, aFrom, aTo])
  else
   l_S := l3Fmt(l3CStr('#%d (внутр.), блок %d ("%s" -> "%s")'), [f_DocID, f_CurBlock, aFrom, aTo])
 end
 else
  l_S := l3Fmt(l3CStr('Замена в блоке %d ("%s" -> "%s")'), [f_CurBlock, aFrom, aTo]);
 DoLog(l3Str(l_S));
end;

function TddMisspellCorrectFilter.pm_GetDocID: Integer;
begin
 Result:= f_DocID;
end;

function TddMisspellCorrectFilter.pm_GetOnError: TddErrorEvent;
begin
 Result:= f_Onerror;
end;

procedure TddMisspellCorrectFilter.pm_SetDocID(aValue: Integer);
begin
 f_DocID:= aValue;
 if (f_DocID > 0) and Assigned(f_OnGetExternalDocID) then
  f_ExtDocID := f_OnGetExternalDocID(f_DocID)
 else
  f_ExtDocID := -1;
end;

procedure TddMisspellCorrectFilter.pm_SetNeedErrorsLog(const Value: Boolean);
begin
 f_NeedErrorsLog := Value;
end;

procedure TddMisspellCorrectFilter.pm_SetOnError(aValue: TddErrorEvent);
begin
 f_OnError:= aValue;
end;

function TddMisspellCorrectFilter.ReplaceConfirm(const aBlock: InevRange;
                                                 AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
begin
 Result := mrYes;
end;

procedure TddMisspellCorrectFilter.Reset;
begin
 f_Searcher.Clear;
 f_RegExPairs.Clear;
end;

procedure TddMisspellCorrectFilter.SetOnError(aCategory: Integer; aHandler:
    TddErrorEvent);
begin
 OnError:= aHandler;
 f_Category:= aCategory;
end;

function TddMisspellReplacer.pm_GetReplaceReporter: IddReplaceReporter;
begin
 Result := IddReplaceReporter(f_ReplaceReporter);
end;

procedure TddMisspellReplacer.pm_SetReplaceReporter(const Value: IddReplaceReporter);
begin
 f_ReplaceReporter := Pointer(Value);
end;

function TddMisspellReplacer.ReplaceFunc(const aView     : InevView;
                                         const Container : InevOp;
                                         const aBlock    : InevRange): Bool;
var
 l_FoundStr:  Il3CString;
 l_FoundWStr: Tl3WString;
 I: Integer;
 l_AllCaps: Boolean;
 l_StrToReplace : Il3CString;
 l_RDP: IddReplaceDataProvider;
 l_RD: IddReplaceData;
begin
{$IFNDEF Archi}
 Assert(Supports(Searcher, IddReplaceDataProvider, l_RDP), 'TddMisspellReplacer работает только в паре с TddMisspellSearcher!');
 l_FoundStr := EvAsString(aBlock.Data);
 if not l3IsNil(l_FoundStr) then
 begin
  l_FoundWStr := l_FoundStr.AsWStr;
  l_AllCaps := True;
  for I := 0 to l_FoundWStr.SLen - 1 do
   if (not l3IsWordDelim(l_FoundWStr.S[I], l_FoundWStr.SCodePage)) and (not l3IsUpper(l_FoundWStr.S[I])) then
   begin
    l_AllCaps := False;
    Break;
   end;
  l_RD := l_RDP.ReplaceData;
  if l_AllCaps then
   l_StrToReplace := l_RD.UpperReplaceStr
  else
   if l3IsUpper(l_FoundWStr.S[0]) then
    l_StrToReplace := l_RD.FirstUpperReplaceStr
   else
    l_StrToReplace := l_RD.ReplaceStr;
  Result := aBlock.Text.Modify.InsertString(aView, l_StrToReplace, Container, true, [misfDirect]);
  l_RD.Used := True;
  if f_ReplaceReporter <> nil then
   ReplaceReporter.DoReportReplace(l_FoundStr, l_StrToReplace);
 end;
{$ENDIF Archi} 
end;

constructor TddMisspellSearcher.Create(anOwner: TevSearchToolOwner = nil);
begin
 inherited;
 f_SearchTree := TddSearchTree.Create;
end;

procedure TddMisspellSearcher.AddPair(const aSearchStr, aReplaceStr: Il3CString);
var
 l_RDImp: TddReplaceDataImpl;
 l_RD   : IddReplaceData;
begin
 l_RDImp := TddReplaceDataImpl.Create(aSearchStr, aReplaceStr);
 try
  l_RD := l_RDImp;
  f_SearchTree.AddString(aSearchStr, l_RD);
 finally
  FreeAndNil(l_RDImp);
 end;
end;

procedure TddMisspellSearcher.Cleanup;
begin
 FreeAndNil(f_SearchTree);
 inherited;
end;

procedure TddMisspellSearcher.Clear;
begin
 f_SearchTree.Clear;
end;

function TddMisspellSearcher.DoCheckText(aPara : Tl3Variant;
                                               aText : Tl3CustomString;
                                         const  aSel : TevPair;
                                         out  theSel : TevPair): Bool;
//        override;
var
 l_Diff: Integer;
 l_Sel : TevPair;
 l_Str : Tl3WString;
 l_Err : AnsiString;
 l_ESt : Tl3WString;
 l_Pos : TddFoundPosRec;

 function lp_CheckLayer: Boolean;
 var
  l_NotFound: Boolean absolute Result;

  function lp_CheckSegmant(aSeg: Tl3Variant; anIndex: Long): Boolean;
  begin
   l_NotFound := False; // Нам достаточно первого вхождения.
   Result := l_NotFound;
  end;

 var
  l_Segments : Tl3Variant;
  l_Layer    : Tl3Variant;
 begin
  l_NotFound := True;
  l_Segments := aPara.Attr[k2_tiSegments];
  if l_Segments.IsValid then
  begin
   l_Layer := evSegments_GetLayer(l_Segments, ev_slObjects);
   evSegmentsLayer_IterateSegmentsF(aPara.AsObject, l_Layer, theSel.rStart, theSel.rFinish, L2Mk2ChildrenIterateChildrenFAction(@lp_CheckSegmant))
  end; // if l_Segments.IsValid then
 end;

begin
 Result := False;
 if (aSel.rStart <> ev_cpAtEnd) then
 begin
  l_Str := aText.AsWStr;
  l_Str := l3PCharLenPart(l_Str.S, aSel.rStart, Min(aSel.rFinish, l_Str.SLen), l_Str.SCodePage);
  while True do
  begin
   Result := f_SearchTree.SearchWords(l_Str, l_Pos, f_FoundData);
   if Result then
   begin
    if (l_Pos.rStart > 0) and (l_Str.S[l_Pos.rStart-1] = '#') then
    begin
     l_ESt := l3PCharLenPart(l_Str.S, l_Pos.rStart-1, l_Pos.rStart + l_Pos.rLength, l_Str.SCodePage);
     l_Err:= Format('Слово с #: %s', [l3Str(l_Str)]);
     if Assigned(f_OnError) then
      f_OnError(l_Err, cMisspellReportCategory)
     else
      l3System.Msg2Log(l_Err, cMisspellReportCategory);
     Result := False;
    end
    else
    begin
     Result := lp_CheckLayer;
     if Result then
     begin
      l_Diff := Tl3PCharLen(l_Str).Diff(aText.AsWStr);
      theSel.rStart := l_Diff + l_Pos.rStart;
      theSel.rFinish := theSel.rStart + l_Pos.rLength;
     end;
    end;
    if Result then
     Break
    else
     l_Str := l3PCharLenPart(l_Str.S, l_Pos.rStart + l_Pos.rLength + 1, l_Str.SLen, l_Str.SCodePage);
   end
   else
    Break;
  end; // while True do
 end;
 if not Result then
 begin
  theSel.rStart := -1;
  theSel.rFinish := -1;
 end;//Result
end;

procedure TddMisspellSearcher.DropUsed;
 procedure DoLeaf(aLeaf: Tl3SearchNode);
 var
  l_RD: IddReplaceData;
 begin
  l_RD := IddReplaceData(aLeaf.Data);
  l_RD.Used := False;
 end;
begin
 f_SearchTree.IterateDataLeavesF(ddL2SNA(@DoLeaf));
end;

function TddMisspellSearcher.GetUnusedStrings: AnsiString;
var
 l_Str: AnsiString;
 procedure DoLeaf(aLeaf: Tl3SearchNode);
 var
  l_RD: IddReplaceData;
 begin
  l_RD := IddReplaceData(aLeaf.Data);
  if not l_RD.Used then
   if l_Str = '' then
    l_Str := Format('Не найдено: "%s"', [l3Str(l_RD.SearchStr)])
   else
    l_Str := Format('%s, "%s"', [l_Str, l3Str(l_RD.SearchStr)]);
 end;
begin
 l_Str := '';
 f_SearchTree.IterateDataLeavesF(ddL2SNA(@DoLeaf));
 Result := l_Str;
end;

function TddMisspellSearcher.HasData: Boolean;
begin
 Result := f_SearchTree.HasData;
end;

function TddMisspellSearcher.pm_GetOnError: TddErrorEvent;
begin
 Result:= f_Onerror;
end;

function TddMisspellSearcher.pm_GetReplaceData: IddReplaceData;
begin
 Result := IddReplaceData(f_FoundData);
end;

procedure TddMisspellSearcher.pm_SetOnError(aValue: TddErrorEvent);
begin
 f_OnError:= aValue;
end;

procedure TddMisspellCorrectFilterEx.ParsePairsString(const aSource: Tl3WString);
begin
 ddAddOnePair(aSource, Self);
end;

procedure TddMisspellCorrectFilterEx.LoadPairs(const  aFileName: AnsiString);
var
 l_TopicListFiler : Tl3DOSFiler;
 l_SRString: Tl3WString;
begin
 Reset;
 if FileExists(aFileName) then
 begin
  l_TopicListFiler := Tl3DOSFiler.Make(aFileName, l3_fmRead, False);
  try
   l_TopicListFiler.Open;
   try
    while not (l_TopicListFiler.EOF) do
    begin
     l_SRString := l_TopicListFiler.Readln;
     ParsePairsString(l_SRString);
    end;
   finally
    l_TopicListFiler.Close;
   end;
  finally
    FreeAndNil(l_TopicListFiler);
  end;
 end;
end;

class function TddMisspellCorrectFilterEx.SetTo(var theGenerator:
    Tk2TagGenerator; const aFileName: AnsiString; aCategory: Integer = 0; aOnError:
    TddErrorEvent = nil): Pointer;
var
 l_Filter : TddMisspellCorrectFilterEx;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Generator := theGenerator;
  l_Filter.SetOnError(aCategory, aOnError);
  l_Filter.LoadPairs(aFileName);
  l_Filter.NeedErrorsLog:= False;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

constructor TddReplaceDataImpl.Create(const aSearchStr, aReplaceStr: Il3CString);
var
 l_S: Tl3InterfacedString;
 l_C: AnsiChar;
begin
 inherited Create;
 f_SearchStr := aSearchStr;
 f_ReplaceStr := aReplaceStr;
 f_UpperReplaceStr := l3Upper(f_ReplaceStr);
 l_S := Tl3InterfacedString.Make(f_ReplaceStr.AsWStr);
 try
  l_C := l_S.Ch[0];
  l3MakeUpperCase(@l_C, 1);
  l_S.Ch[0] := l_C;
  f_FirstUpperReplaceStr := l_S;
 finally
  FreeAndNil(l_S);
 end;//try..finally
 f_Used := False;
end;

procedure TddReplaceDataImpl.Cleanup;
begin
 f_SearchStr := nil;
 f_ReplaceStr := nil;
 inherited;
end;

function TddReplaceDataImpl.pm_GetFirstUpperReplaceStr: Il3CString;
begin
 Result := f_FirstUpperReplaceStr;
end;

function TddReplaceDataImpl.pm_GetReplaceStr: Il3CString;
begin
 Result := f_ReplaceStr;
end;

function TddReplaceDataImpl.pm_GetSearchStr: Il3CString;
begin
 Result := f_SearchStr;
end;

function TddReplaceDataImpl.pm_GetUpperReplaceStr: Il3CString;
begin
 Result := f_UpperReplaceStr;
end;

function TddReplaceDataImpl.pm_GetUsed: Boolean;
begin
 Result := f_Used;
end;

procedure TddReplaceDataImpl.pm_SetUsed(const Value: Boolean);
begin
 f_Used := Value;
end;

class function TddMisspellRegExpReplacer.Make(const aText: AnsiString; const aReporter: IddReplaceReporter = nil;
    anOptions: TevSearchOptionSet = []): IevReplacer;
var
 l_R: TddMisspellRegExpReplacer;
begin
 l_R := TddMisspellRegExpReplacer.Create;
 try
  l_R.Text := aText;
  l_R.Options := anOptions;
  l_R.ReplaceReporter := aReporter;
  Result := l_R;
 finally
  FreeAndNil(l_R);
 end;
end;

function TddMisspellRegExpReplacer.pm_GetReplaceReporter: IddReplaceReporter;
begin
 Result := IddReplaceReporter(f_ReplaceReporter);
end;

procedure TddMisspellRegExpReplacer.pm_SetReplaceReporter(const Value: IddReplaceReporter);
begin
 f_ReplaceReporter := Pointer(Value);
end;

function TddMisspellRegExpReplacer.ReplaceFunc(const aView: InevView; const Container: InevOp; const aBlock: InevRange): Bool;
var
 l_FoundStr  : Il3CString;
 l_ReplaceStr: Il3CString;
begin
 if (f_ReplaceReporter = nil) then
  Result := inherited ReplaceFunc(aView, Container, aBlock)
 else
 begin
  l_FoundStr := EvAsString(aBlock.Data);
  Result := inherited ReplaceFunc(aView, Container, aBlock);
  aBlock.RefreshBorders;
  l_ReplaceStr := EvAsString(aBlock.Data);
  ReplaceReporter.DoReportReplace(l_FoundStr, l_ReplaceStr);
 end;
end;

end.