unit tfwScriptDebugger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, afwTextControlPrim, afwTextControl, vtPanel,
  vtSizeablePanel, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  nevControl, evCustomEditorWindowPrim, evEditorWindow,
  evCustomEditorWindowModelPart, evMultiSelectEditorWindow,
  evCustomEditorModelPart, evCustomEditor, evEditorWithOperations,
  evCustomMemo, evMemo,

  tfwScriptingInterfaces, tb97GraphicControl, TB97Ctls, evButton,

  l3CardinalList,

  l3Interfaces, afwInputControl, vtLister, ExtCtrls, l3WinControlCanvas,
  evCustomEditorWindow, vtPanelPrim
  ;

type
  TtfwScriptDebugger_Form = class(TForm, ItfwScriptCaller)
    edScript: TevMemo;
    pnFooter: TvtSizeablePanel;
    pnHeader: TvtSizeablePanel;
    edOutput: TevMemo;
    btRun: TevButton;
    btClear: TevButton;
    lstStack : TvtLister;
    pnStack: TvtSizeablePanel;
    tmStack: TTimer;
    procedure btRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure lstStackGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
    procedure tmStackTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
   f_Starts : Tl3CardinalList;
    {* Начальные точки замеров}
   f_TextForm : TCustomForm;
    { Private declarations }
   procedure Check(aCondition: Boolean; const aMessage : AnsiString = '');
     {* Проверяет инвариант }
   procedure Print(const aStr: Tl3WString); overload;
   procedure Print(const aStr: Il3CString); overload;
   function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
   function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
   function ResolveInputFilePath(const aFile: AnsiString): AnsiString;
   function SystemDictionary: IStream;
   procedure CheckPictureOnly;
   procedure CheckWithEtalon(const aFileName: AnsiString;
    aHeaderBegin: AnsiChar);
   procedure CheckOutputWithInput(const aIn: AnsiString;
     const aOut: AnsiString;
     aHeaderBegin: AnsiChar;
     aEtalonNeedsComputerName: Boolean;
     aEtalonCanHaveDiff: Boolean;
     const anExtraFileName: AnsiString;
     aNeedsCheck: Boolean); overload;
   procedure CheckOutputWithInput(const aSt: AnsiString;
     aHeaderBegin: AnsiChar = #0;
     const anExtraFileName: AnsiString = '';
     aNeedsCheck: Boolean = true); overload;
   //function PrepareForm(aClass: TClass): TCustomForm;
   procedure CheckPrintEtalon(const aLogName: AnsiString; const aOutputName: AnsiString);
   function ShouldStop: Boolean;
   procedure CheckTimeout(aNow: Cardinal;
    aTimeout: Cardinal);
   function StartTimer: Longword;
   function StopTimer(const aSt: AnsiString = '';
    const aSubName: AnsiString = '';
    aNeedTimeToLog: Boolean = true): Longword;
   function KPage: AnsiString;
   procedure ToLog(const aSt: AnsiString);
   function CompileOnly: Boolean;
   function GetIsWritingToK: Boolean;
   function GetIsFakeCVS: Boolean;
   function GetCVSPath: AnsiString;
   procedure TimeToLog(aTime: Cardinal;
     const aSt: AnsiString;
     const aSubName: AnsiString);
     {* Выводит замер времени в лог }
   function GetEtalonSuffix: AnsiString;
  protected
   procedure DontRaiseIfEtalonCreated;
   function GetTestSetFolderName: AnsiString;
  public
    { Public declarations }
   procedure LoadScriptFromFile(aFileName: AnsiString);
   procedure RunScript;
  end;

var
 g_DebuggerForm: TtfwScriptDebugger_Form;

implementation

{$R *.dfm}

uses
  vcmInsiderTest,
  tfwScriptEngine,
  l3String,
  afwAnswer,
  {$IfNDef NoVCM}
  vcmForm,
  vcmBase,
  {$EndIf  NoVCM}
  k2Reader,
  {$IF not Defined(Nemesis) and not Defined(Archi) and not Defined(EverestLite)}
  //AutoTestFormFactory,
  {$IFEND}
  //_afwFacade,
  l3Base,
  l3Filer,
  evTxtRd,
  TypInfo,
  kwMain,
  l3BatchService,
  l3KeyboardLayoutService
  ;

procedure TtfwScriptDebugger_Form.Check(aCondition: Boolean; const aMessage : AnsiString = '');
  {* Проверяет инвариант }
begin
 if (aMessage = '') then
  Assert(aCondition)
 else
  Assert(aCondition, aMessage);
end;

procedure TtfwScriptDebugger_Form.Print(const aStr: Tl3WString);
begin
 edOutput.GotoBottom;
 edOutput.InsertBuf(aStr);
 edOutput.InsertBuf(l3PCharLen(#13#10));
end;

procedure TtfwScriptDebugger_Form.Print(const aStr: Il3CString);
begin
 Print(l3PCharLen(aStr));
end;

function TtfwScriptDebugger_Form.ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
begin
 Result := TvcmInsiderTest.DoResolveIncludedFilePath(aFile);
end;

function TtfwScriptDebugger_Form.ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
begin
 Result := TvcmInsiderTest.DoResolveOutputFilePath(aFile);
end;

function TtfwScriptDebugger_Form.ResolveInputFilePath(const aFile: AnsiString): AnsiString;
begin
 Result := TvcmInsiderTest.DoResolveInputFilePath(aFile);
end;

function TtfwScriptDebugger_Form.SystemDictionary: IStream;
begin
 Result := nil;
end;

procedure TtfwScriptDebugger_Form.CheckWithEtalon(const aFileName: AnsiString;
 aHeaderBegin: AnsiChar);
begin
 // - ничего не делаем
end;

procedure TtfwScriptDebugger_Form.CheckOutputWithInput(const aIn: AnsiString;
  const aOut: AnsiString;
  aHeaderBegin: AnsiChar;
  aEtalonNeedsComputerName: Boolean;
  aEtalonCanHaveDiff: Boolean;
  const anExtraFileName: AnsiString;
  aNeedsCheck: Boolean); //overload;
begin
 Assert(false);
end;

procedure TtfwScriptDebugger_Form.CheckOutputWithInput(const aSt: AnsiString;
  aHeaderBegin: AnsiChar = #0;
  const anExtraFileName: AnsiString = '';
  aNeedsCheck: Boolean = true); //overload;
begin
 Assert(false);
end;

procedure TtfwScriptDebugger_Form.btRunClick(Sender: TObject);
begin
 Tl3KeyboardLayoutService.Instance.TryActivateKeyboardLayout;
 Assert(not Tl3BatchService.Instance.IsBatchMode);
 {$IF not Defined(Archi) and not Defined(EverestLite)}
 {$IfNDef NoVCM}
 vcmDispatcher.FormDispatcher.CurrentMainForm.VCLWinControl.SetFocus;
 {$EndIf  NoVCM}
 {$IFEND}
 Tl3BatchService.Instance.EnterBatchMode;
 try
  try
   TtfwScriptEngine.Script(edScript.Text, Self);
  except
   on E : Exception do
   begin
    try
     Print(l3PCharLen(E.Message));
    except
    end;//try..except 
    l3System.Exception2Log(E);
   end;//E : Exception
  end;//try..finally
 finally
  Tl3BatchService.Instance.LeaveBatchMode;
 end;//try..finally
end;

procedure TtfwScriptDebugger_Form.FormCreate(Sender: TObject);
begin
 edScript.TextSource.New;
 edScript.NeedReplaceQuotes := false;
 edScript.AutoSelect := false;
 edOutput.TextSource.New;
 edOutput.AutoSelect := false;
end;

procedure TtfwScriptDebugger_Form.btClearClick(Sender: TObject);
begin
 edOutput.TextSource.New;
end;

procedure TtfwScriptDebugger_Form.lstStackGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
begin
 ItemString := l3CStr('<' + IntToStr(Index) + '>');
 if (g_ScriptEngine <> nil) then
  if (g_ScriptEngine.ValueStack <> nil) then
   with g_ScriptEngine.ValueStack do
   begin
    if (Index < Count) then
     try
      ItemString := Items[Count - Index - 1].AsPrintable;
     except
      ItemString := l3CStr('Видимо битая ссылка на объект');
     end;//try..except
(*     with Items[Count - Index - 1] do
     begin
      Case rType of
       tfw_svtVoid:
        ItemString := l3CStr('<void>');
       tfw_svtInt:
        ItemString := l3CStr(IntToStr(rInteger));
       tfw_svtBool:
        ItemString := l3CStr(BoolToStr(AsBoolean, true));
       tfw_svtStr:
        ItemString := AsString;
       tfw_svtObj:
       try
        if (AsObject Is TComponent) then
         ItemString := l3CStr('Class: ' + TComponent(AsObject).Name + ' : ' +AsObject.ClassName)
        else
         ItemString := l3CStr('Class: ' + AsObject.ClassName);
       except
        ItemString := l3CStr('Видимо битая ссылка на объект');
       end;//try..except
       else
        ItemString := l3CStr(GetEnumName(TypeInfo(TtfwStackValueType), Ord(rType)));
      end;//Case rType
     end;//with Items[Count - Index - 1]*)
   end;//with g_ScriptEngine.ValueStack
end;

procedure TtfwScriptDebugger_Form.tmStackTimer(Sender: TObject);
var
 l_Cnt : Integer;
begin
 l_Cnt := 0;
 if (g_ScriptEngine <> nil) then
  if (g_ScriptEngine.ValueStack <> nil) then
   l_Cnt := g_ScriptEngine.ValueStack.Count;
 lstStack.Total := l_Cnt;  
end;

(*function TtfwScriptDebugger_Form.PrepareForm(aClass: TClass): TCustomForm;
begin
 Assert(false);
end;*)

procedure TtfwScriptDebugger_Form.FormDestroy(Sender: TObject);
begin
 l3Free(f_TextForm);
 l3Free(f_Starts);
end;

procedure TtfwScriptDebugger_Form.CheckPrintEtalon(const aLogName: AnsiString;
  const aOutputName: AnsiString);
begin
 Assert(False);
end;

procedure TtfwScriptDebugger_Form.CheckTimeout(aNow, aTimeout: Cardinal);
begin
 Assert(False);
end;

function TtfwScriptDebugger_Form.ShouldStop: Boolean;
begin
 Assert(False);
end;

function TtfwScriptDebugger_Form.StartTimer: Longword;
begin
 if (f_Starts = nil) then
  f_Starts := Tl3CardinalList.Make;
 Result := GetTickCount;
 f_Starts.Add(Result);
end;

function TtfwScriptDebugger_Form.StopTimer(const aSt, aSubName: AnsiString;
  aNeedTimeToLog: Boolean): Longword;
begin
 Assert(f_Starts <> nil);
 Assert(f_Starts.Count > 0);
 Result := GetTickCount - f_Starts.Last;
 f_Starts.Delete(f_Starts.Hi);
 if aNeedTimeToLog then
  TimeToLog(Result, aSt, aSubName);
end;

function TtfwScriptDebugger_Form.KPage: AnsiString;
begin
 Assert(False);
end;

procedure TtfwScriptDebugger_Form.ToLog(const aSt: AnsiString);
begin
(* if Assigned(f_ToLog) then
  f_ToLog(aSt)
 else*)
  l3System.Msg2Log(ClassName + '.Debugger: ' + aSt);
end;

function TtfwScriptDebugger_Form.CompileOnly: Boolean;
begin
 Result := false;
end;

function TtfwScriptDebugger_Form.GetCVSPath: AnsiString;
begin
 Assert(False);
 Result := '';
end;

function TtfwScriptDebugger_Form.GetIsFakeCVS: Boolean;
begin
 Assert(False);
 Result := False;
end;

function TtfwScriptDebugger_Form.GetIsWritingToK: Boolean;
begin
 Assert(False);
 Result := False;
end;

procedure TtfwScriptDebugger_Form.DontRaiseIfEtalonCreated;
begin
 Assert(False);
end;

procedure TtfwScriptDebugger_Form.LoadScriptFromFile(aFileName: AnsiString);
var
 l_Reader   : Tk2CustomFileReader;
 l_DosFiler : TevDosFiler;
begin
 l_DosFiler := TevDosFiler.Create;
 try
  l_Reader := TevTextParser.Create(nil);
  try
   l_DosFiler.FileName := aFileName;
   (l_Reader as TevTextParser).PlainText := True;
   l_Reader.Filer := l_DosFiler;
   edScript.TextSource.Load(l_Reader);
  finally
   l3Free(l_Reader);
  end; 
 finally
  l3Free(l_DosFiler);
 end;
end;

procedure TtfwScriptDebugger_Form.RunScript;
begin
 btRun.Click;
end;

procedure TtfwScriptDebugger_Form.TimeToLog(aTime: Cardinal; const aSt,
  aSubName: AnsiString);
var
 l_S : AnsiString;
begin
(* if Assigned(f_TimeToLog) then
 begin
  l_S := ClassName + '.' + FTestName;
  if (aSt <> '') then
   l_S := l_S + '.' + aSt;
  f_TimeToLog(aTime, l_S, aSubName);
 end//Assigned(f_TimeToLog)
 else*)
 begin
  l_S := 'time ' + IntToStr(aTime) + ' ms';
  if (aSubName <> '') then
   l_S := aSubName + ' ' + l_S;
  if (aSt <> '') then
   l_S := aSt + ' done: ' + l_S;
  ToLog(l_S);
 end;//Assigned(f_TimeToLog)
end;

function TtfwScriptDebugger_Form.GetTestSetFolderName: AnsiString;
begin
 Result := 'TestSet';
end;

function TtfwScriptDebugger_Form.GetEtalonSuffix: AnsiString;
begin
 Result := '.etalon';
end;

procedure TtfwScriptDebugger_Form.CheckPictureOnly;
begin

end;

end.
