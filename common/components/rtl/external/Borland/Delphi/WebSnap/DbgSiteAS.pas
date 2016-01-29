{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Web server application components               }
{                                                       }
{       Copyright (c) 2001-2002 Borland Software Corp.  }
{                                                       }
{*******************************************************}

unit DbgSiteAS;

interface

uses SysUtils, Classes, Contnrs, HTTPApp, HTTPProd, AscrLib, ActiveX, ActivDbgLib, WebScript,
  WebScriptAs, AutoAdapAS;

type

  TTimeoutThread = class;

  TBaseDebugScriptSite = class(TActiveScriptSite, IActiveScriptSiteWindow, IDebugDocumentHost, IActiveScriptSiteDebug)
  private
    FDebugDocumentHelper: IDebugDocumentHelper;
    FDebugApplication: IDebugApplication;
    FTimeOut: TTimeoutThread;
  protected
    procedure HandleScriptError(const AErrorDebug: IActiveScriptErrorDebug;
      var AEnterDebugger: Boolean); virtual;
    function BreakOnFirstStatement: Boolean; virtual;

    property DebugDocumentHelper: IDebugDocumentHelper read FDebugDocumentHelper;
    property DebugApplication: IDebugApplication read FDebugApplication;
    function SetupDebugApplication(var AProcessDebugManager: IProcessDebugManager;
      var ADebugApplication: IDebugApplication; var AApplicationCookie: DWord;
      AScriptFile: TScriptFile): Boolean;
    function SetupDebugDocumentHelper(AProcessDebugManager: IProcessDebugManager;
      ADebugApplication: IDebugApplication; DebugDocumentHost: IDebugDocumentHost;
      AApplicationCookie: DWord; AScriptFile: TScriptFile): IDebugDocumentHelper;
    function SetupDebugScript(AActiveScript: IActiveScript; AScriptFile: TScriptFile;
      ADebugDocHelper: IDebugDocumentHelper): DWord;
    { IActiveScriptSiteWindow }
    function  GetWindow(out phwnd: wireHWND): HResult; stdcall;
    function  EnableModeless(fEnable: Integer): HResult; stdcall;
    { IDebugDocumentHost }
    function  GetDeferredText {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_19:0}dwTextStartCookie: LongWord;
                                                                   {VT_2:1}var pcharText: Smallint;
                                                                   {VT_18:1}var pstaTextAttr: Word;
                                                                   {VT_19:1}var pcNumChars: LongWord;
                                                                   {VT_19:0}cMaxChars: LongWord): HResult; stdcall;
    function  GetScriptTextAttributes {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_31:0}pstrCode: PWideChar;
                                                                           {VT_19:0}uNumCodeChars: LongWord;
                                                                           {VT_31:0}pstrDelimiter: PWideChar;
                                                                           {VT_19:0}dwFlags: LongWord;
                                                                           {VT_18:1}var pattr: Word): HResult; stdcall;
    function  OnCreateDocumentContext {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_13:1}out ppunkOuter: IUnknown): HResult; stdcall;
    function  GetPathName {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrLongName: WideString;
                                                               {VT_3:1}out pfIsOriginalFile: Integer): HResult; stdcall;
    function  GetFileName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrShortName: WideString): HResult; stdcall;
    function  NotifyChanged {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    { IActiveScriptSiteDebug }
    function  GetDocumentContextFromPosition {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_19:0}dwSourceContext: LongWord;
                                                                                  {VT_19:0}uCharacterOffset: LongWord;
                                                                                  {VT_19:0}uNumChars: LongWord;
                                                                                  {VT_29:2}out ppsc: IDebugDocumentContext): HResult; stdcall;
    function  GetApplication {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppda: IDebugApplication): HResult; stdcall;
    function  GetRootApplicationNode {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppdanRoot: IDebugApplicationNode): HResult; stdcall;
    function  OnScriptErrorDebug {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_29:1}const AErrorDebug: IActiveScriptErrorDebug;
                                                                      {VT_3:1}out AEnterDebuggerFlag: Integer;
                                                                      {VT_3:1}out ACallOnScriptErrorWhenContinuingFlag: Integer): HResult; stdcall;

  public
    procedure RunExpression(AScriptFile: TScriptFile;
      AEngine: IInterface); override;
  end;

  TTimeoutThread = class(TThread)
  private
    FTimeOutSecs: Integer;
    FEndTime: TDateTime;
    FEngine: IActiveScript;
    FTimedout: Boolean;
  public
    constructor Create(ATimeoutSecs: Integer; AEngine: IActiveScript);
    procedure Execute; override;
    property Timedout: Boolean read FTimedout;
  end;

function CreateDebugManager: IProcessDebugManager;

implementation

uses ComObj, SiteComp;

{ TTimeoutThread }

constructor TTimeoutThread.Create(ATimeoutSecs: Integer; AEngine: IActiveScript);
begin
  FTimeoutSecs := ATimeoutSecs;
  FEngine := AEngine;
  inherited Create(True { Suspended });
end;

const
  SCRIPTTHREADID_BASE = -2;
  SCRIPTINTERRUPT_RAISEEXCEPTION = 1;
var
  ExcepInfo: TExcepInfo;

procedure TTimeoutThread.Execute;
  function IncSecond(const AValue: TDateTime;
    const ANumberOfSeconds: Int64): TDateTime;
  begin
    Result := ((AValue * SecsPerDay) + ANumberOfSeconds) / SecsPerDay;
  end;
begin
  while not Terminated do
  begin
    if FEndTime = 0 then
      FEndTime := IncSecond(Now, FTimeoutSecs)
    else
      if Now > FEndTime then
      begin
        FTimedout := True;
        FEngine.InterruptScriptThread(LongWord(SCRIPTTHREADID_BASE), ExcepInfo, SCRIPTINTERRUPT_RAISEEXCEPTION);
        Exit;
      end;
  end;
end;

function TBaseDebugScriptSite.GetWindow(out phwnd: wireHWND): HResult;
begin
  { IActiveScriptSiteWindow }

  { Get design window? }
  // phwnd := FForm.Handle;
  // Result := S_OK;
  Result := S_FALSE;
end;

function TBaseDebugScriptSite.EnableModeless(fEnable: Integer): HResult;
begin
  { IActiveScriptSiteWindow }

  Result := S_FALSE;

end;

function TBaseDebugScriptSite.GetDeferredText(dwTextStartCookie: LongWord;
  var pcharText: Smallint; var pstaTextAttr: Word;
  var pcNumChars: LongWord; cMaxChars: LongWord): HResult;
begin
  { IDebugDocumentHost }

  Result := E_NOTIMPL;
end;

function TBaseDebugScriptSite.GetScriptTextAttributes(pstrCode: PWideChar;
  uNumCodeChars: LongWord; pstrDelimiter: PWideChar; dwFlags: LongWord;
  var pattr: Word): HResult;
begin
  { IDebugDocumentHost }

  Result := E_NOTIMPL;
end;

function TBaseDebugScriptSite.OnCreateDocumentContext(
  out ppunkOuter: IUnknown): HResult;
begin
  { IDebugDocumentHost }

   Result := E_NOTIMPL;
end;

function TBaseDebugScriptSite.GetPathName(out pbstrLongName: WideString;
  out pfIsOriginalFile: Integer): HResult;
begin
  { IDebugDocumentHost }

 // Provide the full path (including file name) to the document's source file.
 // IsOriginalPath is True if the path refers to the original file for the document,
 // False if the path refers to a newly created temporary file
 // Result is E_FAIL if no source file can be created/determined.

  pbstrLongName := 'GetTheLongName';
  pfIsOriginalFile := 0; { False }

  Result := S_OK;
end;

function TBaseDebugScriptSite.GetFileName(out pbstrShortName: WideString): HResult;
begin
  { IDebugDocumentHost }

  // Provide just the name of the document, with no path information.
  // (Used for "Save As...")
  pbstrShortName := 'GetFileName';

  Result := S_OK;
end;

function TBaseDebugScriptSite.NotifyChanged: HResult;
begin
  { IDebugDocumentHost }

  // Notify the host that the document's source file has been saved and
  // that its contents should be refreshed.

  Result := S_OK;
end;

function TBaseDebugScriptSite.GetDocumentContextFromPosition(dwSourceContext,
  uCharacterOffset, uNumChars: LongWord;
  out ppsc: IDebugDocumentContext): HResult;
var
  ulStartPos: LongWord;
  temp1: IActiveScript;
  temp2: LongWord;
begin
  { IActiveScriptSiteDebug }

  if (FDebugDocumentHelper <> nil) then
  begin
    FDebugDocumentHelper.GetScriptBlockInfo(dwSourceContext, temp1, ulStartPos, temp2);
    Result := FDebugDocumentHelper.CreateDebugDocumentContext(ulStartPos + uCharacterOffset, uNumChars, ppsc);
  end
  else
  begin
    Result := E_NOTIMPL;
  end;
end;

function TBaseDebugScriptSite.GetApplication(out ppda: IDebugApplication): HResult;
begin
  { IActiveScriptSiteDebug }

  ppda := FDebugApplication;
  Result := S_OK;
end;

function TBaseDebugScriptSite.GetRootApplicationNode(
  out ppdanRoot: IDebugApplicationNode): HResult;
begin
  { IActiveScriptSiteDebug }

   if FDebugDocumentHelper <> nil then
   begin
      Result := FDebugDocumentHelper.GetDebugApplicationNode(ppdanRoot);
   end
   else
     Result := E_NOTIMPL;
end;

procedure TBaseDebugScriptSite.HandleScriptError(
  const AErrorDebug: IActiveScriptErrorDebug; var AEnterDebugger: Boolean);
begin
  GlobalObjects.Producer.HandleScriptError(AErrorDebug);
end;

function TBaseDebugScriptSite.OnScriptErrorDebug(
  const AErrorDebug: IActiveScriptErrorDebug; out AEnterDebuggerFlag,
  ACallOnScriptErrorWhenContinuingFlag: Integer): HResult;
var
  EnterDebugger: Boolean;
begin
  { IActiveScriptSiteDebug }

  if FTimeout <> nil then
    FTimeout.Terminate;
  ACallOnScriptErrorWhenContinuingFlag := 0;
  EnterDebugger := True;
  HandleScriptError(AErrorDebug, EnterDebugger);
  if EnterDebugger then
    AEnterDebuggerFlag := 1
  else
    AEnterDebuggerFlag := 0;
  Result := S_OK;
end;

function TBaseDebugScriptSite.SetupDebugScript(AActiveScript: IActiveScript; AScriptFile: TScriptFile; ADebugDocHelper: IDebugDocumentHelper): DWord;
var
  hr: HRESULT;
  SourceContext: DWord;
  S: string;
begin
   S := AScriptFile.Source;
   hr := ADebugDocHelper.AddDBCSText(PChar(S));
   if (FAILED(hr)) then
     Assert(False, 'AddDBCSText failed');

   SourceContext := 0;
   ADebugDocHelper.DefineScriptBlock(0, Length(S), AActiveScript, 0 { False }, SourceContext);

   Result := SourceContext;
end;

function TBaseDebugScriptSite.SetupDebugDocumentHelper(AProcessDebugManager: IProcessDebugManager;
  ADebugApplication: IDebugApplication; DebugDocumentHost: IDebugDocumentHost;
  AApplicationCookie: DWord; AScriptFile: TScriptFile): IDebugDocumentHelper;
var
  DebugDocHelper: IDebugDocumentHelper;
  hr: HRESULT;
begin
// XX ActiveX Scripting with debug support XX
  Assert(DebugDocHelper = nil);
  hr := AProcessDebugManager.CreateDebugDocumentHelper(nil, DebugDocHelper);
  if FAILED(hr) then
    Assert(False, 'Could not create debug document helper');

  Assert(DebugDocHelper <> nil);

  hr := DebugDocHelper.Init(ADebugApplication,PWideChar(WideString(AScriptFile.ShortName)), PWideChar(WideString(AScriptFile.LongName)), TEXT_DOC_ATTR_READONLY);
  if FAILED(hr) then
    Assert(False, 'Could not init debug document helper');

  hr := DebugDocHelper.Attach(nil);
  if FAILED(hr) then
    Assert(False, 'Could not attach debug document helper');

  hr := DebugDocHelper.SetDocumentAttr(TEXT_DOC_ATTR_READONLY);
  if FAILED(hr) then
    Assert(False, 'Could not setdocumentattr');

  // this step is optional but it deosn't require much effort to perform
  hr := DebugDocHelper.SetDebugDocumentHost(DebugDocumentHost);
  if FAILED(hr) then
    Assert(False, 'Could not set debug document host');

  Result := DebugDocHelper;

end;

function CreateDebugManager: IProcessDebugManager;
var
  ClsID: TGuid;
  hr: HRESULT;
begin
  CLSIDFromProgID('ProcessDebugManager.ProcessDebugManager', ClsID);

  hr := CoCreateInstance(ClsID, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
        IProcessDebugManager, Result);
  if FAILED(hr) then
  begin
    CLSIDFromProgID('ProcessDebugManager', ClsID);
    hr := CoCreateInstance(ClsID, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
          IProcessDebugManager, Result);
    if FAILED(hr) then
      Result := nil;
  end
end;

function TBaseDebugScriptSite.SetupDebugApplication(var AProcessDebugManager: IProcessDebugManager; var ADebugApplication: IDebugApplication;
  var AApplicationCookie: DWord; AScriptFile: TScriptFile): Boolean;
var
  hr: HRESULT;
begin
  try
    AProcessDebugManager := CreateDebugManager;
    if AProcessDebugManager = nil then
    begin
      Result := False;
      Assert(False, 'Could not create process debug manager');
    end
    else
    begin
      hr := AProcessDebugManager.CreateApplication(ADebugApplication);
      if FAILED(hr) then
        Assert(False, 'Could not create debug application');

      hr := ADebugApplication.SetName(PWideChar(WideString(AScriptFile.ApplicationName)));
      if FAILED(hr) then
        Assert(False, 'Could not set debug app name');

      hr := AProcessDebugManager.AddApplication(ADebugApplication, AApplicationCookie);
      if FAILED(hr) then
        Assert(False, 'Could not add application');

      Result := True;
    end
  except
    if ADebugApplication <> nil then
    begin
      AProcessDebugManager.RemoveApplication(AApplicationCookie);
      ADebugApplication.Close();
    end;
    ADebugApplication := nil;
    AProcessDebugManager := nil;
    Result := False;
  end;

end;

resourcestring
  sCouldNotInitializeDebugger = 'Initialization of script debugger failed. Verify that a script debugger is installed';
  sScriptTimedout = 'Script execution timed out after %d seconds';

procedure TBaseDebugScriptSite.RunExpression(AScriptFile: TScriptFile;
      AEngine: IInterface);

  procedure TimeoutError(TimeoutSecs: Integer);
  begin
    with GlobalObjects.Producer.Errors do
      if (Count > 0) and (Errors[Count-1].Description = '') then
        Errors[Count-1].Description := Format(sScriptTimedOut, [TimeoutSecs])
      else
        raise EActiveScriptError.CreateFmt(sScriptTimedOut, [TimeoutSecs])
  end;

var

  ExcepInfo: TExcepInfo;
  ActiveScriptParse: IActiveScriptParse;
  hr: HRESULT;
  I: Integer;
  SourceContext: DWord;
  ProcessDebugManager: IProcessDebugManager;
  ApplicationCookie: DWord;
  ScriptSite: TActiveScriptSite;
  SaveScriptSite: IUnknown;
  TimeoutSecs: Integer;
  Engine: IActiveScript;
begin
  Engine := AEngine as IActiveScript;

  if InternetEnvOptions <> nil then
    TimeoutSecs := InternetEnvOptions.ScriptTimeoutSecs
  else
    TimeoutSecs := 0;

  try
    if not SetupDebugApplication(ProcessDebugManager, FDebugApplication, ApplicationCookie, AScriptFile) then
    begin
      if BreakOnFirstStatement then
        raise EActiveScriptError.Create(sCouldNotInitializeDebugger)
      else
      begin
        // Use non debug script site
        ScriptSite := TActiveScriptSite.Create(GlobalObjects.Producer);
        SaveScriptSite := ScriptSite;
        if TimeoutSecs > 0 then
        begin
          FTimeout := TTimeOutThread.Create(TimeoutSecs, Engine);
          try
            FTimeout.Resume;
            ScriptSite.RunExpression(AScriptFile, Engine);
            if FTimeout.Timedout then
              TimeoutError(TimeoutSecs);
          finally
            FTimeout.Terminate;
            FreeAndNil(FTimeout);
          end;
        end
        else
          ScriptSite.RunExpression(AScriptFile, AEngine);
        Exit;
      end;
    end;

    //Now query for the IActiveScriptParse interface of the engine
    hr := AEngine.QueryInterface(IActiveScriptParse, ActiveScriptParse);
    OLECHECK(hr);

    //The engine needs to know the host it runs on.
    hr := Engine.SetScriptSite(Self);
    OLECHECK(hr);

    //Initialize the script engine so it's ready to run.
    hr := ActiveScriptParse.InitNew();
    OLECHECK(hr);

    for I := 0 to GlobalObjects.NamedItemCount - 1 do
      Engine.AddNamedItem(PWideChar(WideString(GlobalObjects.NamedItemName[I])), SCRIPTITEM_ISVISIBLE);

    FDebugDocumentHelper := SetupDebugDocumentHelper(ProcessDebugManager, FDebugApplication, Self,
      ApplicationCookie, AScriptFile);

    SourceContext := SetupDebugScript(Engine, AScriptFile, FDebugDocumentHelper);

    hr := ActiveScriptParse.ParseScriptText(PWideChar(WideString(AScriptFile.Script)), nil {sScriptMain}, nil, nil,
          SourceContext, 0, 0, { VariantResult }nil, ExcepInfo);
    // hr <> S_OK means that an error occured.  FErrors should
    // contain the error
    Assert((hr = S_OK) or (GlobalObjects.Producer.Errors.Count > 0), 'Errors expected');

    if BreakOnFirstStatement then
    begin
      FDebugDocumentHelper.BringDocumentToTop();
      hr := FDebugApplication.CauseBreak();
      if (FAILED(hr)) then
        Assert(False,'Error causing break point');
    end;

    if hr = S_OK then
    begin
      if (TimeoutSecs > 0) and not BreakOnFirstStatement then
      begin
        FTimeout := TTimeOutThread.Create(TimeoutSecs, Engine);
        try
          FTimeout.Resume;
          hr := Engine.SetScriptState(SCRIPTSTATE_CONNECTED);
          if FTimeout.Timedout then
            TimeoutError(TimeoutSecs);
        finally
          FTimeout.Terminate;
          FreeAndNil(FTimeout);
        end
      end
      else
        hr := Engine.SetScriptState(SCRIPTSTATE_CONNECTED);
      // hr <> S_OK means that an error occured.  FErrors should
      // contain the error
      Assert((hr = S_OK) or (GlobalObjects.Producer.Errors.Count > 0), 'Errors expected');
    end;

  finally
    if FDebugDocumentHelper <> nil then
    begin
      hr := FDebugDocumentHelper.Detach;
      if (FAILED(hr)) then
        Assert(False, 'Error detaching document helper');
    end;

    if ProcessDebugManager <> nil then
    begin
      hr := ProcessDebugManager.RemoveApplication(ApplicationCookie);
      if (FAILED(hr)) then
         Assert(False, 'Error removing application helper');
    end;


    if FDebugApplication <> nil then
    begin
      hr := FDebugApplication.Close();
      if (FAILED(hr)) then
        Assert(False, 'Error closing debug application');
    end;
    FDebugDocumentHelper := nil;
  end;

end;

function TBaseDebugScriptSite.BreakOnFirstStatement: Boolean;
begin
  Result := False;
end;

end.
