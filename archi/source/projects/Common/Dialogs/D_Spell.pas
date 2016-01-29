unit D_spell;

{ $Id: D_Spell.pas,v 1.48 2015/04/28 15:03:39 lulin Exp $ }

// $Log: D_Spell.pas,v $
// Revision 1.48  2015/04/28 15:03:39  lulin
// - рефакторим.
//
// Revision 1.47  2015/04/28 15:02:31  lulin
// - рефакторим.
//
// Revision 1.46  2015/04/28 15:01:34  lulin
// - рефакторим.
//
// Revision 1.45  2015/04/09 10:26:17  dinishev
// {Requestlink:583082850}
//
// Revision 1.44  2015/04/08 14:18:27  dinishev
// Убрал старый код.
//
// Revision 1.43  2014/04/04 07:14:17  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.42  2014/03/04 14:42:19  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.41  2014/01/29 12:18:56  dinishev
// Избавился от лишнего модуля.
//
// Revision 1.40  2013/10/18 14:11:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.39  2013/04/17 14:19:22  lulin
// - портируем.
//
// Revision 1.38  2013/01/29 11:25:17  fireton
// - передаём кодировку в проверку орфографии
//
// Revision 1.37  2012/10/29 16:55:36  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.36  2012/01/30 12:32:51  dinishev
// {Requestlink:330141531}
//
// Revision 1.35  2012/01/27 15:26:06  dinishev
// {Requestlink:330704233}. Тест.
//
// Revision 1.34  2012/01/27 15:01:09  dinishev
// {Requestlink:330704233}. Тест.
//
// Revision 1.33  2011/08/30 07:46:47  voba
// - bug fix
//
// Revision 1.32  2011/05/30 14:07:36  fireton
// - закрываем диалог при смене редактора
//
// Revision 1.31  2011/05/18 13:40:50  fireton
// - опция "считать точку разделителем слов при проверке орфографии"
//
// Revision 1.30  2011/05/18 12:00:50  fireton
// - возвращаем подсветку латинских букв красным цветом
//
// Revision 1.29  2011/05/17 13:56:03  fireton
// - возможность отключения проверки орфографии в коротких словах
//
// Revision 1.28  2011/04/28 10:15:18  dinishev
// Выделяем сообщения для общих диалогов.
//
// Revision 1.27  2011/02/08 10:49:05  fireton
// - не обновлялся список, если не менялся Total
//
// Revision 1.26  2010/12/13 15:17:02  fireton
// - боремся с расфокусировкой окна
//
// Revision 1.25  2010/12/13 14:55:03  fireton
// - меняем поведение - делаем похожим на проверку орфографии в MS Word
//
// Revision 1.24  2010/07/15 08:07:02  voba
// - не компилялось
//
// Revision 1.23  2010/07/12 14:34:45  fireton
// - переработанная проверка орфографии
//
// Revision 1.22  2009/04/07 07:20:00  voba
// no message
//
// Revision 1.21  2008/10/13 13:37:49  dinishev
// <K> : 84640081
//
// Revision 1.20  2008/04/16 11:50:22  lulin
// - выделяем фасад для скрытия различий старого и нового редакторов.
//
// Revision 1.19  2008/04/15 17:14:34  lulin
// - автоматизируем переключение между версиями редактора.
//
// Revision 1.18  2008/04/15 08:26:34  dinishev
// Восстанавливаем старый редактор
//
// Revision 1.17  2007/12/03 09:04:31  dinishev
// Используем редактор из ветки
//
// Revision 1.16  2007/02/19 15:18:41  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.15  2007/01/11 15:07:57  lulin
// - bug fix: не собиралось.
//
// Revision 1.14  2006/12/24 13:33:27  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.13  2006/12/10 18:59:50  lulin
// - класс формы переименован в соответствии с библиотекой.
//
// Revision 1.12  2006/02/08 17:30:35  lulin
// - cleanup.
//
// Revision 1.11  2005/05/27 14:44:22  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.10  2004/03/05 13:00:48  voba
// TCustomVLister -> TvtCustomLister
//
// Revision 1.9  2003/10/13 15:06:35  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.8  2002/10/29 11:08:03  law
// - new directive: evDualSpell.
//
// Revision 1.7  2002/07/10 09:01:28  narry
// - bug fix: не активиролась кнопка "заменить" при выборе варианта замены
//
// Revision 1.6  2002/06/28 16:13:33  law
// - new behavior: проверка орфографии при помощи DLL от Информатика.
// - new directive: evAlienSpell.
//
// Revision 1.5  2001/10/01 13:04:48  law
// - bug fix: не освобождалась форма проверки орфографии.
//
// Revision 1.4  2000/12/15 16:21:58  law
// - вставлены директивы Log.
//

interface

{$Include l3Define.inc}

{$Include evDefine.inc }

{$IfDef evDualSpell}
 {$Define evAlienSpell}
{$EndIf evDualSpell}

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, l3Interfaces, l3Types, l3Base, evTypes, OvcBase,  evEditorWindow, evEditor, evMemo, vtlister,
  evIntf, evEditorInterfaces, l3InternalInterfaces, l3Forms, afwControl,
  afwInputControl, evMultiSelectEditorWindow, evCustomEditor,
  evEditorWithOperations, afwControlPrim, afwBaseControl, nevControl,
  evInternalInterfaces,
  evCustomMemo, evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, nevTools, l3StringList, evSearch, ddSpell, ddSpellInterfaces,
  evCustomEditorWindow;

type
  TSpellCheckDlg = class(TForm)
    Label1: TLabel;
    btSkip: TButton;
    btSkipAll: TButton;
    btAddDic: TButton;
    Label2: TLabel;
    btCancel: TBitBtn;
    btHelp: TBitBtn;
    btReplace: TButton;
    btReplaceAll: TButton;
    memAbsent: TevMemo;
    lstAlternative: TvtLister;
    lblLatinChars: TLabel;
    procedure btSkipClick(Sender: TObject);
    procedure memAbsentChange(Sender: TObject);
    procedure lstAlternativeActionElement(Sender: TObject; Index: Integer);
    procedure memAbsentParaChange(Sender: TObject; const TextPara: IedTextParagraph);
    procedure memAbsentCursorInSelectionChange(Sender: TObject);
    procedure memAbsentFontChange(Sender: TObject; const Font: Il3Font);
    procedure lstAlternativeCountChanged(Sender: TObject;
      NewCount: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSkipAllClick(Sender: TObject);
    procedure btAddDicClick(Sender: TObject);
    procedure btReplaceClick(Sender: TObject);
    procedure btReplaceAllClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    f_Alternatives: Tl3StringList;
    f_BadWord: Tl3String;
    f_CurEditor: TevCustomEditor;
    f_Dictionary: TddSpellDictionary;
    f_IgnoreList: Tl3StringList;
    f_InReplaceLoop: Boolean;
    f_Interrupted: Boolean;
    f_OldSelectNotify: TNotifyEvent;
    f_ReplaceItem: TddReplaceItem;
    f_ReplaceList: Tl3StringList;
    f_Replacer: TevTextReplacer;
    f_ReplaceResult: Integer;
    f_Searcher: TddSpellCheckSearcher;
    f_SpellChecker: IddSpeller;
    f_IdleMode: Boolean;
  f_NeedClose: Boolean;
    f_NotificationsHooked: Boolean;
  f_OwnerToClose: HWND;
  procedure CreateSearcherAndReplacer;
    procedure CreateSpellCheker;
    procedure DropNotifications;
  procedure DropSearcherAndReplacer;
    procedure EditorSelectionChanged(Sender: TObject);
  procedure HookNotifications;
    procedure pm_SetIdleMode(const Value: Boolean);
    procedure pm_SetCurEditor(const Value: TevCustomEditor);
        {-}
    function SpellReplaceConfirm(Sender : TObject; const aBlock : InevRange): Shortint;
    procedure DoSearch;
  function GetReplacerText: string;
    { Private declarations }
    procedure UpdateListState;
      {-}
  protected
        {-}
    function DoFilterWord(const aString: Tl3WString): Bool;
        {-}
    procedure GetAlternative(Sender: TObject; Index: Long; var S: PAnsiChar);
    procedure Interrupt(aOwnerToClose: HWND = 0);
        {-}
    procedure SetDictList(Value: TddSpellDictionary);

    function CheckStamp(const aGUID: TGUID): Boolean;
  public
    class procedure CheckEditor(const aEditor: TevCustomEditor);
    class procedure CloseSpellCheck;
    { Public declarations }
    procedure EnableList;
    procedure DisableList;
    class procedure Execute(aEditor: TevCustomEditor; aDictionary: TddSpellDictionary);
  class procedure InterruptSpellCheck(aOwnerToClose: HWND = 0);
  class function IsSpellCheckInProgress: Boolean;
    property CurEditor: TevCustomEditor read f_CurEditor write pm_SetCurEditor;
  property Interrupted: Boolean read f_Interrupted;
        {-}
    property Replacer: TevTextReplacer read f_Replacer;
    property Searcher: TddSpellCheckSearcher read f_Searcher;
    property IdleMode: Boolean read f_IdleMode write pm_SetIdleMode;
  published
    property Dictionary: TddSpellDictionary read f_Dictionary write SetDictList;
  end;

const
  mrBase         = 10;
  tagSkip        = 1;  mrSkip = mrBase + tagSkip;
  tagSkipAll     = 2;  mrSkipAll = mrBase + tagSkipAll;
  tagAddDic      = 3;  mrAddDic = mrBase + tagAddDic;
  tagReplace     = 4;  mrReplace = mrBase + tagReplace;
  tagReplaceAll  = 5;  mrReplaceAll = mrBase + tagReplaceAll;
  tagAutoReplace = 6;  mrAutoReplace = mrBase + tagAutoReplace;

  cCaption = 'Правописание: (русский';
  cCaptionTailRus = ')';
  cCaptionTailDual = ' и английский)';

implementation

uses
  SysUtils,
  Dialogs,
  Messages,

  evCommonRes,
  vtDialogs,

  evFacadTextSource,
  evCommonTypes,
  evFacadeUtils,
  evExcept,

  l3Chars,
  l3String,

  {$IfDef evAlienSpell}
  ddAlienSpell,
  {$IfDef evDualSpell}
  ddNativeSpell,
  {$EndIf evDualSpell}
  {$Else  evAlienSpell}
  ddNativeSpell,
  {$EndIf evAlienSpell}

  evdTypes,

  k2Tags,
  Document_Const,
  TextPara_Const,
  SegmentsLayer_Const,
  TextSegment_Const,

  IniShop
  ,
  l3PrimString,
  l3BatchService,
  l3ModalService
  ;

{$IFDEF Archi}
{$INCLUDE ArchiDefine.inc}
{$ENDIF Archi}  

{$R *.DFM}


var
 g_SpellCheckDlg: TSpellCheckDlg;

procedure TSpellCheckDlg.btSkipClick(Sender: TObject);
begin
 if IdleMode then
  DoSearch
 else
  f_ReplaceResult := mrNo;
end;

procedure TSpellCheckDlg.CreateSpellCheker;
var
{$IfDef evAlienSpell}
 l_Speller   : TddSpeller;
{$IfDef evDualSpell}
 l_Speller1  : TmgSpellFormChecker;
{$EndIf evDualSpell}
{$Else  evAlienSpell}
 l_Speller   : TmgSpellFormChecker;
{$EndIf evAlienSpell}
begin
 l_Speller := {$IfDef evAlienSpell}
               TddSpeller
              {$Else  evAlienSpell}
               TmgSpellFormChecker
              {$EndIf evAlienSpell}.Create;
 try
  f_SpellChecker := l_Speller;

  {$IfDef evDualSpell}
  if l_Speller.CheckSpeller.Active then
   Caption := cCaption + cCaptionTailDual
  else begin
   // - если какие-то проблемы с dll
   l_Speller1 := TmgSpellFormChecker.Create;
   try
    l_Speller1.IgnoreFlags := [CmgSrcEvnDate,
                               CmgSrcEvnDigital,
                               CmgSrcEvnEnglish,
                               CmgSrcEvnAllCapital,
                               cmgSrcEvnNumberChar];
    Caption := cCaption + cCaptionTailRus;
    f_SpellChecker := l_Speller1;
   finally
    FreeAndNil(l_Speller1);
   end;//try..finally
  end;//not l_Speller.Speller.Active
  {$Else  evDualSpell}
  {$IfDef evAlienSpell}
  Caption := cCaption + cCaptionTailDual;
  {$Else  evAlienSpell}
  Caption := cCaption + cCaptionTailRus;
  {$EndIf evAlienSpell}
  {$EndIf evDualSpell}

  f_SpellChecker.Filter := DoFilterWord;
  {$IfNDef evAlienSpell}
  l_Speller.IgnoreFlags := [CmgSrcEvnDate,
                            CmgSrcEvnDigital,
                            CmgSrcEvnEnglish,
                            CmgSrcEvnAllCapital,
                            cmgSrcEvnNumberChar];
  {$EndIf evAlienSpell}
 finally
  FreeAndNil(l_Speller);
 end;//try..finally
end;

procedure TSpellCheckDlg.memAbsentChange(Sender: TObject);
begin
 UpdateListState;
end;

procedure TSpellCheckDlg.lstAlternativeActionElement(Sender: TObject;
  Index: Integer);
begin
 {
 with memAbsent do begin
  Text := l3Str(lstAlternative.Strings[Index]);
  TextSource.Modified := true;
 end;//with memAbsent
// ModalResult := mrReplace;
}
 btReplace.Click;
end;

procedure TSpellCheckDlg.memAbsentParaChange(Sender: TObject;
  const TextPara: IedTextParagraph);
begin
 UpdateListState;
end;

procedure TSpellCheckDlg.EnableList;
begin
 lstAlternative.Enabled:= True;
end;

procedure TSpellCheckDlg.DisableList;
begin
 lstAlternative.Enabled:= False;
end;

procedure TSpellCheckDlg.UpdateListState;
  {-}
begin
 if memAbsent.TextSource.Modified then
  DisableList
 else
  if (lstAlternative.Total > 0) then
   EnableList
  else
   DisableList; 
end;

procedure TSpellCheckDlg.memAbsentCursorInSelectionChange(Sender: TObject);
begin
 UpdateListState;
end;

procedure TSpellCheckDlg.memAbsentFontChange(Sender: TObject; const Font: Il3Font);
begin
 UpdateListState;
end;

procedure TSpellCheckDlg.lstAlternativeCountChanged(Sender: TObject;
  NewCount: Integer);
begin
 if NewCount > 0 then
  EnableList
 else
  DisableList; 
end;

procedure TSpellCheckDlg.FormShow(Sender: TObject);
begin
 evSetTextParaLimit(memAbsent.TextSource, 1);
end;

function TSpellCheckDlg.SpellReplaceConfirm(Sender : TObject; const aBlock : InevRange): Shortint;
var
  G: TevGenerator;
  i: Integer;
  l_SegStart,
  l_SegStop : Integer;
  l_Latin: Boolean;
  l_Write: Boolean;
begin
 if (f_ReplaceItem <> nil) then begin
  Result:= mrYes;
  Replacer.Text:= f_ReplaceItem.GoodWord.AsString;
 end
 else
 begin
  if not f_BadWord.Empty AND
     l3CharSetPresent(f_BadWord.st, f_BadWord.Len, cc_ANSIEnglish) AND
     l3CharSetPresent(f_BadWord.st, f_BadWord.Len, cc_ANSIRussian) then
  begin
    lblLatinChars.Visible := True;
    G:= evGetNewTextGenerator(memAbsent.TextSource);
    try
     G.Start;
     try
      G.StartChild(k2_typDocument);
      try
        G.AddIntegerAtom(k2_tiLeftIndent, 0);
        G.StartChild(k2_typTextPara);
        try
          G.AddIntegerAtom(k2_tiFirstIndent, 0);
          G.AddIntegerAtom(k2_tiLeftIndent, 0);
          G.AddStringAtom(k2_tiText, f_BadWord.AsWStr);
          G.StartTag(k2_tiSegments);
          try
            G.StartChild(k2_typSegmentsLayer);
            try
              G.AddIntegerAtom(k2_tiHandle, Ord(ev_slView));

              l_SegStart:= 1;
              l_SegStop:= 1;
              l_Latin:= False;
              l_Write:= False;

              for i := 0 to Pred(f_BadWord.Len) do
              begin

                if l_Latin then
                begin
                 l_Write:= not (f_Badword.Ch[i] in cc_ANSIEnglish);
                end
                else
                begin
                 l_Write:= (f_Badword.Ch[i] in cc_ANSIEnglish);
                end;

                if l_Write then
                begin
                  G.StartChild(k2_typTextSegment);
                  try
                   G.AddIntegerAtom(k2_tiStart, l_SegStart);
                   G.AddIntegerAtom(k2_tiFinish, l_SegStop-1);

                   if l_Latin then
                   begin
                     G.StartTag(k2_tiFont);
                     try
                       G.AddIntegerAtom(k2_tiForeColor, clRed);
                     finally
                       G.Finish;
                     end; { k2_tiFont }
                   end;
                  finally
                   G.Finish;
                  end; { k2_idTextSegment }
                  l_SegStart:= l_SegStop;
                  l_Latin:= (f_Badword.Ch[i] in cc_ANSIEnglish);
                end;
                Inc(l_SegStop);
              end; {for i}

              G.StartChild(k2_typTextSegment);
              try
               G.AddIntegerAtom(k2_tiStart, l_SegStart);
               G.AddIntegerAtom(k2_tiFinish, f_BadWord.Len);

               if l_Latin then
               begin
                 G.StartTag(k2_tiFont);
                 try
                   G.AddIntegerAtom(k2_tiForeColor, clRed);
                 finally
                   G.Finish;
                 end; { k2_tiFont }
               end;
              finally
               G.Finish;
               l_SegStart:= i+1;
              end; { k2_idTextSegment }
            finally
              G.Finish;
            end; { k2_idSegmentsLayer }
          finally
            G.Finish;
          end; { k2_idSegments }
          
        finally
          G.Finish;
        end; { k2_idTextPara }
      finally
        G.Finish;
      end; { k2_idDocument }
     finally
      G.Finish;
     end;
    finally
     evFreeGenerator(G);
    end;//try..finally
  end
  else
  begin
    memAbsent.Buffer:= f_BadWord.AsWStr;
    lblLatinChars.Visible := false;
  end;
  Result:= mrNone;
  Show;
  Application.ProcessMessages;
  f_CurEditor.AdjustForm2Found(Self);
  if f_Alternatives.Empty then
  begin
   lstAlternative.Total := 0;
   DisableList;
   //FocusControl(memAbsent);
  end
  else
  begin
   lstAlternative.Total := f_Alternatives.Count;
   lstAlternative.Current := 0;
   lstAlternative.Refresh;
   //FocusControl(lstAlternative);
  end;
  f_InReplaceLoop := True;
  try
   f_ReplaceResult := mrNone;
   while f_ReplaceResult = mrNone do
   begin
    {$IFDEF InsiderTest}
     if not Tl3BatchService.Instance.ExecuteCurrentModalWorker(se_meInLoop) then
      f_ReplaceResult := mrNone;
    {$ENDIF InsiderTest}
    Application.ProcessMessages;
   end; // while f_ReplaceResult = mrNone do
   Result := f_ReplaceResult;
   f_Interrupted := Result = mrCancel;
   if f_Interrupted then
   begin
    DropNotifications;
   end;
  finally
   f_InReplaceLoop := False;
  end;
 end;{f_ReplaceItem <> nil}
end;

function TSpellCheckDlg.DoFilterWord(const aString: Tl3WString): Bool;
  {-}
var
 i : Long;
begin
 Result := false;
 if (f_BadWord = nil) then
  f_BadWord := Tl3String.Create;
 f_BadWord.AsPCharLen := Tl3PCharLen(aString); 
 if (f_ReplaceList <> nil) AND f_ReplaceList.FindData(f_BadWord, i) then
  l3Set(f_ReplaceItem, f_ReplaceList.Items[i])
 else
  if ((f_Dictionary <> nil) AND f_Dictionary.InList(f_BadWord)) OR
    ((f_IgnoreList <> nil) AND f_IgnoreList.FindData(f_BadWord, i)) then
   Result := true
  else
  begin
   FreeAndNil(f_ReplaceItem);
   if (f_Alternatives = nil) then
    f_Alternatives := Tl3StringList.MakeSorted;
   f_SpellChecker.CreateAltvForms(f_Alternatives, f_BadWord.St, f_BadWord.Len, false);
   lstAlternative.Total := f_Alternatives.Count;
  end;
end;

class procedure TSpellCheckDlg.Execute(aEditor: TevCustomEditor; aDictionary: TddSpellDictionary);
begin
 if g_SpellCheckDlg = nil then
  g_SpellCheckDlg := TSpellCheckDlg.Create(Application);
 with g_SpellCheckDlg do
 begin
  memAbsent.KeepAllFormatting := False; //True;
  memAbsent.WebStyle := True;
  CurEditor := aEditor;
  if aDictionary <> Dictionary then
   Dictionary := aDictionary;
  g_SpellCheckDlg.DoSearch;
 end;
 //FreeAndNil(g_SpellCheckDlg);
end;

procedure TSpellCheckDlg.FormCreate(Sender: TObject);
begin
 CreateSearcherAndReplacer;
 lstAlternative.OnGetPCharItem := GetAlternative;
 IdleMode := True;
end;

procedure TSpellCheckDlg.GetAlternative(Sender: TObject; Index: Long; var S: PAnsiChar);
  {-}
begin
 S := f_Alternatives.Items[Index].AsWStr.S;
end;

procedure TSpellCheckDlg.SetDictList(Value: TddSpellDictionary);
begin
 l3Set(f_Dictionary, Value);
 if not f_IgnoreList.Empty then f_IgnoreList.Clear;
 if not f_ReplaceList.Empty then f_ReplaceList.Clear;
end;

procedure TSpellCheckDlg.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_IgnoreList);
 FreeAndNil(f_ReplaceList);
 FreeAndNil(f_Dictionary);
 FreeAndNil(f_Alternatives);

 FreeAndNil(f_ReplaceItem);
 FreeAndNil(f_BadWord);

 DropSearcherAndReplacer;

 g_SpellCheckDlg := nil;
end;

procedure TSpellCheckDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caHide;
 f_ReplaceResult := mrCancel;
 FreeAndNil(f_ReplaceList);
 FreeAndNil(f_IgnoreList);
end;

procedure TSpellCheckDlg.DoSearch;
var
 l_Options: TevSearchOptionSetEx;
begin
 if not IdleMode then
  Exit;
 HookNotifications;
 IdleMode := False;
 f_Interrupted := False;
 f_NeedClose := False;
 f_OwnerToClose := 0;
 try
  try
   l_Options := [ev_soReplaceAll, ev_soConfirm]; // проверяем с текущей позиции
   if (not CurEditor.Selection.Collapsed) and
      (MessageDlg('Проверить правописание только в выделенном фрагменте?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    l_Options := l_Options + [ev_soSelText, ev_soGlobal];
   if IniRec.DontCheckThreeLetterWords then
    f_SpellChecker.MinWordLength := 4  // минимальная длина слова для проверки
   else
    f_SpellChecker.MinWordLength := 0; // не ограничивать длину слова

   f_SpellChecker.DotIsWordSeparator := IniRec.OrphoDotIsSeparator;
   CurEditor.Find(f_Searcher, f_Replacer, l_Options);
   //SpellChecker.DropLists;
  finally
   {$IFDEF InsiderTest}
    Tl3BatchService.Instance.ExecuteCurrentModalWorker(se_meAfterLoop);
   {$ENDIF InsiderTest}
   DropNotifications;
   IdleMode := True;
  end;{try..finally}
 except
   on E: Exception do
    if not (E is EevSearchFailed) then
     raise;
 end;
 if not f_Interrupted then
  vtMessageDlg(str_sidEWSpellCheckDone.AsCStr, mtInformation);
 if f_OwnerToClose <> 0 then
  PostMessage(f_OwnerToClose, WM_CLOSE, 0, 0);
 if f_NeedClose then
  Close; 
end;

procedure TSpellCheckDlg.btSkipAllClick(Sender: TObject);
begin
 if (f_IgnoreList = nil) then
  f_IgnoreList := Tl3StringList.MakeSorted;
 if (f_IgnoreList.Add(f_BadWord) >= 0) then
  FreeAndNil(f_BadWord);
 f_ReplaceResult := mrNo;
end;

procedure TSpellCheckDlg.btAddDicClick(Sender: TObject);
begin
 if (f_Dictionary <> nil) then
 begin
  if not f_SpellChecker.AddWord(f_BadWord.AsPCharLen) then
   f_Dictionary.Add(f_BadWord)
  else
   FreeAndNil(f_BadWord);
 end;//f_Dictionary <> nil
 f_ReplaceResult := mrNo;
end;

procedure TSpellCheckDlg.btReplaceClick(Sender: TObject);
begin
 f_Replacer.Text := GetReplacerText;
 f_ReplaceResult:= mrYes;
end;

procedure TSpellCheckDlg.btReplaceAllClick(Sender: TObject);
begin
 if (f_ReplaceList = nil) then
  f_ReplaceList := Tl3StringList.MakeSorted;
 FreeAndNil(f_ReplaceItem);
 f_ReplaceItem := TddReplaceItem.Make(f_BadWord);
 f_ReplaceItem.GoodWord.AsString := GetReplacerText;
 f_ReplaceList.Add(f_ReplaceItem);
 f_Replacer.Text:= f_ReplaceItem.GoodWord.AsString;
 f_ReplaceResult:= mrYes;
end;

procedure TSpellCheckDlg.btCancelClick(Sender: TObject);
begin
 Close;
end;

class procedure TSpellCheckDlg.CheckEditor(const aEditor: TevCustomEditor);
begin
 if (g_SpellCheckDlg <> nil) and (g_SpellCheckDlg.CurEditor <> aEditor) then
  CloseSpellCheck; 
end;

class procedure TSpellCheckDlg.CloseSpellCheck;
begin
 if (g_SpellCheckDlg <> nil) and g_SpellCheckDlg.Showing then
 begin
  g_SpellCheckDlg.Close;
 end;
end;

procedure TSpellCheckDlg.CreateSearcherAndReplacer;
var
 l_Validator: TddFoundValidator;
begin
 CreateSpellCheker;
 f_Searcher := TddSpellCheckSearcher.Create(f_SpellChecker);
 
 l_Validator := TddFoundValidator.Create(nil);
 try
  f_Searcher.NextSearcher := l_Validator;
 finally
  FreeAndNil(l_Validator);
 end;

 f_Replacer := TevTextReplacer.Create(nil);
 f_Replacer.OnReplaceConfirm := SpellReplaceConfirm;
 f_Replacer.Options := [ev_soReplaceAll, ev_soConfirm];
end;

procedure TSpellCheckDlg.DropNotifications;
begin
 if f_NotificationsHooked then
 begin
  f_CurEditor.OnSelectionChange := f_OldSelectNotify;
  f_NotificationsHooked := False;
 end;
end;

procedure TSpellCheckDlg.DropSearcherAndReplacer;
begin
 FreeAndNil(f_Searcher);
 FreeAndNil(f_Replacer);
 f_SpellChecker := nil;
end;

procedure TSpellCheckDlg.EditorSelectionChanged(Sender: TObject);
begin
 f_ReplaceResult := mrCancel;
 if Assigned(f_OldSelectNotify) then
  f_OldSelectNotify(f_CurEditor);
end;

procedure TSpellCheckDlg.HookNotifications;
begin
 if not f_NotificationsHooked then
 begin
  f_OldSelectNotify := f_CurEditor.OnSelectionChange;
  f_CurEditor.OnSelectionChange := EditorSelectionChanged;
  f_NotificationsHooked := True;
 end;
end;

procedure TSpellCheckDlg.Interrupt(aOwnerToClose: HWND = 0);
begin
 f_NeedClose := True;
 f_OwnerToClose := aOwnerToClose;
 f_ReplaceResult := mrCancel;
end;

class procedure TSpellCheckDlg.InterruptSpellCheck(aOwnerToClose: HWND = 0);
begin
 if g_SpellCheckDlg <> nil then
  g_SpellCheckDlg.Interrupt(aOwnerToClose);
end;

class function TSpellCheckDlg.IsSpellCheckInProgress: Boolean;
begin
 Result := (g_SpellCheckDlg <> nil) and (not g_SpellCheckDlg.IdleMode);
end;

function TSpellCheckDlg.CheckStamp(const aGUID: TGUID): Boolean;
  {-}
begin
 if l3SystemDown then
  Result := False
 else
  Result := IsEqualGUID(l3System.GetStamp, aGUID);
end;

function TSpellCheckDlg.GetReplacerText: string;
begin
 if lstAlternative.Enabled then
  Result := l3Str(lstAlternative.Strings[lstAlternative.Current])
 else
  Result := memAbsent.Text;
end;

procedure TSpellCheckDlg.pm_SetIdleMode(const Value: Boolean);
begin
 f_IdleMode := Value;
 if f_IdleMode then
 begin
  btSkip.Caption := 'Далее';
  if f_Alternatives <> nil then
   f_Alternatives.Clear;
  lstAlternative.Total := 0; 
  memAbsent.Text := '';
  btSkipAll.Enabled := False;
  btAddDic.Enabled := False;
  btReplace.Enabled := False;
  btReplaceAll.Enabled := False;
 end
 else
 begin
  btSkip.Caption := 'Пропустить';
  btSkipAll.Enabled := True;
  btReplace.Enabled := True;
  btReplaceAll.Enabled := True;
  btAddDic.Enabled := True;
  UpdateListState;
 end;
end;

procedure TSpellCheckDlg.pm_SetCurEditor(const Value: TevCustomEditor);
begin
 if f_CurEditor = Value then
  Exit;
 Close; 
 DropNotifications;
 f_CurEditor := Value;
end;

initialization

 g_SpellCheckDlg := nil;

end.
