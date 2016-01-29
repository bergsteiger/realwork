{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.WinHelpViewer;

{ ************************************************************************ }
{                                                                          }
{  This unit implements a help viewer for WinHelp (on Windows) or          }
{  HyperHelp (a WinHelp emulator) on Linux. The design goal is for this    }
{  unit to be indistinguishable from other viewers as far as the IDE help  }
{  manager can determine --- there should be no special casing.            }
{                                                                          }
{  Because neither WinHelp nor HyperHelp support direct querying without   }
{  displaying results, it is necessary for the WinHelp viewer to maintain  }
{  a topic list itself. In the case of the built-in IDE help viewer, this  }
{  list is drawn out of the .ALS file, and the analysis of the list is     }
{  delegated to an implementation of IWinHelpTester. The code for this     }
{  is not publically available, and individual applications wishing to     }
{  support this functionality must implement IWinHelpTester themselves.    }
{  Absent an implementation of IWinHelpTester, the WinHelpViewer will      }
{  *always* assume that the query should succeed and WinHelp can be asked  }
{  to provide help (in a Windows application; the opposite is true in a    }
{  Linux application). Any application supporting multiple help viewers is }
{  encouraged to implement IWinHelpTester to get around this.              }
{                                                                          }
{  Much of the code in this file was ripped from existing systems which    }
{  have been redirected through this system; some of the obscurity is      }
{  built-in, and significant portions of the code reflect necessities      }
{  imposed by interactions with ancient WinHelp systems.                   }
{                                                                          }
{  This file is part of the Visual Component Library on Windows, and is    }
{  linked into the VCL package. On Linux, it is provided as an example     }
{  and may be used *in applications* as desired. This file does not work   }
{  when linked into a package on Linux (because the unit is already used   }
{  by the IDE), and will not interact with HyperHelp without an associated }
{  implementation of the function WinHelp. NOTE: winhelp.so is provided by }
{  Borland for use of the IDE only and is *not* redistributable in any     }
{  fashion. Developers of applications wishing to use HyperHelp *must*     }
{  licence HyperHelp seperately from Bristol Technologies.                 }
{                                                                          }
{ ************************************************************************ }

interface

uses 
{$IF DEFINED(CLR)}
  System.Security.Permissions,
{$ENDIF}
  System.Classes;

{ Because WinHelp is uncooperative about responding to queries along the 
  lines of 'do you support this', the WinHelp viewer in essence needs to
  hack a response to that. This interface is a hook by which user applications
  can override the WinHelp viewer's default hack answer. }

type
  IWinHelpTester = interface(IInterface)
    ['{B0FC9354-5F0E-11D3-A3B9-00C04F79AD3A}']
    function CanShowALink(const ALink, FileName: String): Boolean;
    function CanShowTopic(const Topic, FileName: String): Boolean;
    function CanShowContext(const Context: Integer;
                            const FileName: String): Boolean;
    function GetHelpStrings(const ALink: String): TStringList;
    [FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
    function GetHelpPath : String;
    [FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
    function GetDefaultHelpFile: String;
    end;

{ Naming variables which can be set externally, probably by the implementation
  of WinHelpTester. }

var
 WinHelpTester : IWinHelpTester;
 { The Viewer Name is the name used by the Help Manager when it
   needs to display a UI element to allow the program's user to
	 select a viewer by name. }
 ViewerName : String;
{$IFDEF LINUX}
 { HyperHelp requires that you specify the name of the window, and requires
   in which it will display help information, as well. }
 HyperHelpWindowName : String;
{$ENDIF}

{ =========================================================================== }

implementation

uses 
{$IF DEFINED(CLR)}
  System.Text, System.Threading,
{$ENDIF}
{$IF DEFINED(LINUX)}
  Libc,
{$ELSE}
  Winapi.Windows,
{$ENDIF}
  Vcl.Consts, System.HelpIntfs, System.SysUtils;

{$IFDEF LINUX}
{ forward calls to WinHelp on to the HyperHelp implementation }
const
  winhelpmodulename = 'winhelp.so';

function WinHelp(HWND: LongInt; HelpFile: PChar; Command: LongInt; 
                 Data: LongWord): Boolean; cdecl;

external winhelpmodulename name 'WinHelp';
{$ENDIF}

type
{$IF DEFINED(CLR)}
  TWinHelpFinder = class
  private
    HelpTitle: string;
    HelpWnd: HWnd;
    DialogWnd: HWnd;
    FoundMainWindow: Boolean;
    FoundDialog: Boolean;
  public
    function WindowEnumerationTester(wnd: HWnd; Info: LParam): Bool;
    function DialogEnumerationTester(wnd: HWnd; Info: LParam): Bool;
  end;
{$ENDIF}

{$IF DEFINED(MSWINDOWS)}
  TWinHelpFinder = record
    HelpTitle: PChar;
    HelpWnd: HWnd;
    DialogWnd: HWnd;
    FoundMainWindow: Boolean;
    FoundDialog: Boolean;
  end;
{$ENDIF}

{$IF DEFINED(LINUX)}
  TWinHelpFinder = record
    HelpTitle: PChar;
    HelpWnd: Longint;
    DialogWnd: Longint;
    FoundMainWindow: Boolean;
    FoundDialog: Boolean;
  end;
{$ENDIF}

  TWHCommandType = (twhContext, twhCommand, twhContents, twhQuit);

{ TWinHelpViewer.
  TWinHelpViewer implements the interfaces supported by WinHelp ---
  ICustomHelpViewer (required of all Help Viewers), 
  IExtendedHelpViewer (Topic and Context),
  ISpecialWinHelpViewer (Winhelp-specific messages }
 TWinHelpViewer = class(TInterfacedObject, ICustomHelpViewer, IExtendedHelpViewer, ISpecialWinHelpViewer)
  private
   FViewerID: Integer;
   FLastCommandType: TWHCommandType;
   FLastCommand: String;
   FLastContext: Integer;
   function IsNewQuery(QueryType: TWHCommandType; Command: String; Context: Integer): Boolean;
   function MakeWinHelpHappy: Boolean;
   function IsBusyWindow(WndInfo: TWinHelpFinder): Boolean;
   function CouldBeUnstableWindow(WndInfo: TWinHelpFinder): Boolean;
   procedure RestartWinHelp;
{$IF DEFINED(CLR)}
  strict protected
    procedure Finalize; override;
{$ENDIF}
  public
   FHelpManager: IHelpManager;
   constructor Create;
   destructor Destroy; override;
   function HelpFile(const Name: String) : String;
   procedure InternalShutDown;
   { ICustomHelpViewer }
   function GetViewerName : String;
   function UnderstandsKeyword(const HelpString: String): Integer;
   function GetHelpStrings(const HelpString: String): TStringList;
   function CanShowTableOfContents: Boolean;
   procedure ShowTableOfContents;
   procedure ShowHelp(const HelpString: String);
   procedure NotifyID(const ViewerID: Integer);
   procedure SoftShutDown;
   procedure ShutDown;
   { IExtendedHelpViewer }
   function UnderstandsTopic(const Topic: String): Boolean;
   procedure DisplayTopic(const Topic: String);
   function UnderstandsContext(const ContextID: Integer;
                               const HelpFileName: String): Boolean;
   procedure DisplayHelpByContext(const ContextID: Integer;
                                  const HelpFileName: String);
   { ISpecialWinHelpViewer }
   function CallWinHelp(Handle: THandle; const HelpFileName: String;
                        Command: Word; Data: NativeUInt) : Boolean;
   property ViewerID : Integer read FViewerID;
   property HelpManager : IHelpManager read FHelpManager write FHelpManager;
  end;


{ global instance of TWinHelpViewer which HelpIntfs can talk to. }
var
  HelpViewer: TWinHelpViewer;
  HelpViewerIntf: ICustomHelpViewer;

{----------------------------------------------------------------------------}
{ TWinHelpVIewer }

{ internal function used to ensure that the Help File variable
  is something meaningful. Order of checking is:
  (a) if the parameter is nil, then ask the Help Manager what it thinks.
  (b) if the value is stil nil, then ask the Help Tester for the default.
  (c) if this is Linux, then build a full path name, because
      HyperHelp doesn't understand it if you don't. }

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
function TWinHelpViewer.HelpFile(const Name: String): String;
var
  FileName : String;
begin
  Result := '';
  if (Name = '') and Assigned(FHelpManager) then
    FileName := HelpManager.GetHelpFile
  else FileName := Name;
  if FileName = '' then 
    if Assigned(WinHelpTester) then
       FileName := WinHelpTester.GetDefaultHelpFile;

  if Assigned(WinHelpTester) then
    FileName := WinHelpTester.GetHelpPath + PathDelim + FileName;
  Result := FileName;
end;

{ InternalShut Down is called from unit finalization if the unit is exiting
  and the Help Manager needs to be informed. }

procedure TWinHelpViewer.InternalShutDown;
begin
  SoftShutDown;
  if Assigned(FHelpManager) then
  begin
    HelpManager.Release(ViewerID);
    HelpManager := nil;
  end;
end;

{ Finalize frees any resources if the WinHelpViewer gets garbage collected
  without being explicitly freed }

{$IF DEFINED(CLR)}
procedure TWinHelpViewer.Finalize;
begin
  InternalShutDown;
end;
{$ENDIF}

{---------------------------------------------------------------------------}
{ TWinHelpViewer - ICustomHelpViewer }

{ GetViewerName returns a string that the Help Manager can use to identify
  this Viewer in a UI element asking users to choose among Viewers. }
function TWinHelpViewer.GetViewerName: String;
begin
  Result := ViewerName;
end;

{ UnderstandsKeyword is a querying function that the Help Manager calls to
  determine if the Viewer provide helps on a particular keyword string. }
function TWinHelpViewer.UnderstandsKeyword(const HelpString: String): Integer;
var
  CanShowHelp : Boolean;
begin
  { if there's a WinHelp Tester, then ask it if the keyword is supported. }
  if Assigned(WinHelpTester) then 
  begin
    CanShowHelp := WinHelpTester.CanShowALink(HelpString, HelpFile(''));
    if CanShowHelp then
      Result := 1
    else
      Result := 0;
  end 

  { if there is no Tester, then use operating-system specific assumptions:
    under Windows, assume that it's supported; under Linux, assume that it
    isn't. }
  else
  begin
{$IF DEFINED(CLR) OR DEFINED(MSWINDOWS)} 
    Result := 1;
{$ENDIF}
{$IF DEFINED(LINUX)}
    Result := 0;
{$ENDIF}
  end;
end;

{ GetHelpStrings is used by the Help Manager to display a list of keyword
  matches from which an application's user can select one. It assumes
  that the String List is properly allocated, so this function should
  never return nil. }
  
function TWinHelpViewer.GetHelpStrings(const HelpString: String): TStringList;
begin
  { ask the Tester, if there is one. }
  if Assigned(WinHelpTester) then
    Result := WinHelpTester.GetHelpStrings(HelpString)
  else
  begin
    { otherwise, use operating-system specific assumptions:   
      (1) under Windows, return a list with just the string, signifying support;
      (2) under Linux, return an empty list. }
    Result := TStringList.Create;
{$IF NOT DEFINED(LINUX)}
    Result.Add(GetViewerName + ': ' + HelpString);
{$ENDIF}
  end;
end;

{ CanShowTableOfContents is a querying function that the Help Manager
  calls to determine if the Viewer supports tables of contents. WinHelp
  and HyperHelp both do. }

function TWinHelpViewer.CanShowTableOfContents: Boolean;
begin
  Result := True;
end;

{ ShowTableOfContents is a command function that the Help Manager uses
  to direct the Viewer to display a table of contents. It is never
  called without being preceded by a call to CanShowTableOfContents. }
procedure TWinHelpViewer.ShowTableOfContents;
var
  FileName : String;
begin
  if MakeWinHelpHappy then 
  begin
    FLastCommandType := twhContents;
    FileName := HelpFile(HelpManager.GetHelpFile);
    if FileName <> '' then 
      WinHelp(HelpManager.GetHandle, FileName, HELP_CONTENTS, 0);
  end;
end;

{ ShowHelp is the function that the Help Manager calls to request that
  a Help Viewer display help for a given keyword. For WinHelp, this is
  done via a complex WinHelp macro. }

{$IF DEFINED(CLR) OR DEFINED(MSWINDOWS)}
procedure TWinHelpViewer.ShowHelp(const HelpString: String);
const
  Macro = 'IE(AL("%s",4),"AL(\"%0:s\",3)","JK(\"%1:s\",\"%0:s\")")';
var
  HelpCmd : String;
  FileName: String;
begin
  if HelpString = '' then
    raise EHelpSystemException.CreateRes({$IFNDEF CLR}@{$ENDIF}SNoKeyword);
  HelpCmd := Format(Macro, [HelpString, HelpFile('')]);
  if (MakeWinHelpHappy) then
  begin
    FileName := HelpFile('');
    if (IsNewQuery(twhCommand, HelpCmd, 0)) and (FileName <> '') then
    begin
      FLastCommandType := twhCommand;
      FLastCommand := HelpCmd;
{$IF DEFINED(CLR)}
      WinHelp(HelpManager.GetHandle, FileName, HELP_COMMAND, HelpCmd);
{$ELSE}
      WinHelp(HelpManager.GetHandle, PChar(FileName), HELP_COMMAND,
              UIntPtr(PChar(HelpCmd)));
{$ENDIF}
    end;
  end;
end;
{$ENDIF}

{$IF DEFINED(LINUX)}
procedure TWinHelpViewer.ShowHelp(const HelpString: String);
const
  Macro = 'AL(%0s,3,,%1s)'; 
var
  HelpCmd : String;
  FileName: String;
begin
  HelpCmd := Format(Macro, [HelpString, HyperHelpWindowName]);
  FileName := HelpFile('');
  if (IsNewQuery(twhCommand, HelpCmd, 0)) and (FileName <> '') then
  begin
    FLastCommandType := twhCommand;
    FLastCommand := HelpCmd;
    WinHelp(HelpManager.GetHandle, PChar(FileName), HELP_COMMAND,
      UIntPtr(Pchar(HelpCmd)));
  end;
end;
{$ENDIF}

{ NotifyID is called by the Help Manager after a successful registration
  to provide the Help Viewer with a cookie which uniquely identifies the
  Viewer to the Manager, and can be used in communications between the two. }

procedure TWinHelpViewer.NotifyID(const ViewerID: Integer);
begin
  FViewerID := ViewerID;
end;

{ SoftShutDown is called by the help manager to ask the viewer to 
  terminate any externally spawned subsystem without shutting itself down. }
procedure TWinHelpViewer.SoftShutDown;
begin
  FLastCommandType := twhQuit;
  WinHelp(0, '', HELP_QUIT, 0);
end;

procedure TWinHelpViewer.ShutDown;
begin
  SoftShutDown;
  if Assigned(FHelpManager) then
    HelpManager := nil;
  if Assigned(WinHelpTester) then
    WinHelpTester := nil;
end;

{-----------------------------------------------------------------------------}
{ TWinHelpViewer --- IExtendedHelpViewer }

{ UnderstandsTopic is called by the Help Manager to ask if the Viewer
  is capable of displaying a topic-based help query for a given topic. 
  Its default behavior, like all default behaviors in this file, is 
  opposite for Windows than it is for linux. }

function TWinHelpViewer.UnderstandsTopic(const Topic: String): Boolean;
begin
  { after setting the defaults, if there's a Tester, ask it. }
  if Assigned(WinHelpTester) then
    Result := WinHelpTester.CanShowTopic(Topic, HelpFile(''))
  else
    Result := True;  //there is no tester, assume it understands
end;

{ DisplayTopic is called by the Help Manager if a Help Viewer claims
  in its response to UnderstandsTopic to be able to provide Topic-based
  help for a particular keyword. }

procedure TWinHelpViewer.DisplayTopic(const Topic: String);
var
{$IF DEFINED(CLR)}
  HelpCommand: string;
{$ELSE}
  HelpCommand: array[0..255] of Char;
{$ENDIF}
  FileName: String;
begin
  { note that because HelpCommand is of a fixed-size, ridiculously long
    topic strings will result in errors from WinHelp/HyperHelp. }
{$IF DEFINED(CLR)}
  HelpCommand := Format('JumpID("","%s")', [Topic]);
{$ELSE}
  StrLFmt(HelpCommand, Length(HelpCommand) -1, 'JumpID("","%s")', [Topic]);
{$ENDIF}

  FileName := HelpFile('');
  if MakeWinHelpHappy then
  begin
    if (IsNewQuery(twhCommand, HelpCommand, 0)) and (FileName <> '') then
    begin
      FLastCommandType := twhCommand;
      FLastCommand := HelpCommand;
{$IF DEFINED(CLR)}
      WinHelp(HelpManager.GetHandle, FileName, HELP_COMMAND, HelpCommand);
{$ELSE}
      WinHelp(HelpManager.GetHandle, PChar(FileName), HELP_COMMAND,
        UIntPtr(@HelpCommand));
{$ENDIF}
    end;
  end;
end;

{ UnderstandsContext is a querying function called by the Help Manager
  to determine if an Extended Help Viewer is capable of providing
  help for a particular context-ID. Like all querying functions in
  this file, the default behavior is opposite --- YES for windows,
  NO for linux --- and the Tester is asked, if available. }
function TWinHelpViewer.UnderstandsContext(const ContextID: Integer;
  const HelpFileName: String): Boolean;
begin
{$IF NOT DEFINED(LINUX)}
  Result := True;
{$ELSE}
  Result := False;
{$ENDIF}
  if Assigned(WinHelpTester) then
    Result := WinHelpTester.CanShowContext(ContextID, HelpFile(HelpFileName));
end;

{ DisplayHelpByContext is used by the Help Manager to request that a 
  Help Viewer display help for a particular Context-ID. It is only
  invoked after a successful call to CanShowContext. }
procedure TWinHelpViewer.DisplayHelpByContext(const ContextID: Integer;
                                              const HelpFileName: String);
var
   FileName: String;
begin
   FileName := HelpFile(HelpFileName);
   if MakeWinHelpHappy then
   begin
     if IsNewQuery(twhContext, '', ContextID) and (FileName <> '') then
     begin 
       FLastCommandType := twhContext;
       FLastContext := ContextID;
       WinHelp(HelpManager.GetHandle, FileName, HELP_CONTEXT, ContextID);
     end;
   end;
end;

{----------------------------------------------------------------------------}
{ TWinHelpViewer --- ISpecialWinHelpViewer }

{ CallWinHelp is called by the Help Manager when it recieves WinHelp-style
  help requests from external systems and is not able to deconstruct them
  into something meaningful for non-winhelp specific viewers. These
  get forwarded on to WinHelp in *all* circumstances. HyperHelp may
  not support some of these functions, and will issue an error complaint
  in that case. }
function TWinHelpViewer.CallWinHelp(Handle: THandle; const HelpFileName: String;
                                    Command: Word; Data: NativeUInt) : Boolean;
var
  Calling : Boolean;
begin
  Result := False;
  if MakeWinHelpHappy then
  begin
    if (Command = 258 { HELP_COMMAND }) or
    (Command = 261 { HELP_PARTIALKEY}) or
    (Command = 513 { HELP_MULTIKEY}) or
    (Command = 10 { HELP_CONTEXTMENU}) or
    (Command = 8 { HELP_CONTEXTPOPUP}) or
    (Command = 1 { HELP_CONTEXT }) or
    (Command = 257 { HELP_KEY}) then
      Calling := IsNewQuery(twhCommand, IntToStr(Command), 0)
    else 
      Calling := True;
    if Calling then 
    begin
      FLastCommandType := twhCommand;
      FLastCommand := IntToStr(Command);
      Result := WinHelp(Handle, HelpFile(HelpFileName), Command, Data);
    end;
  end;
end;

{----------------------------------------------------------------------------}
{ TWinHelpViewer internal support methods }

{ These functions may only be invoked from code intended to run under Windows.}
{$IF DEFINED(CLR)}
function TWinHelpFinder.WindowEnumerationTester(wnd: HWnd; Info: LParam): Bool;
var
  Buf: StringBuilder;
begin
  Buf := StringBuilder.Create(256);
  GetClassName(wnd, Buf, Buf.Capacity);
  if SameText(Buf.ToString, 'MS_WINHELP') then
  begin
    HelpWnd := Wnd;
    FoundMainWindow := True;
  end;
  Result := not FoundMainWindow;
end;

function TWinHelpFinder.DialogEnumerationTester(wnd: HWnd; Info: LParam): Bool;
var
  Buf: StringBuilder;
begin
  Buf := StringBuilder.Create(256);
  GetClassName(wnd, Buf, Buf.Capacity);
  if SameStr(Buf.ToString, '#32770')  then
  begin
    FoundDialog := True;
    DialogWnd := Wnd;
  end;
  Result := not FoundDialog;
end;

function FindWinHelp: TWinHelpFinder;
begin
  Result := TWinHelpFinder.Create;                                            
  Result.FoundMainWindow := False;
  Result.FoundDialog := False;
  Result.HelpWnd := 0;
  EnumWindows(@Result.WindowEnumerationTester, 0);
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
{$IFDEF MSWINDOWS}
{ These functions will not work with HyperHelp, because HyperHelp does not
  run under the WINE subsystem. These functions may only be invoked from code
  intended to run under Windows.}
function WindowEnumerationTester(wnd: HWnd; var Info: TWinHelpFinder): Bool; stdcall;
var
  Buf: array [Byte] of Char;
begin
  GetClassName(wnd, Buf, Length(Buf));
  if (StrIComp(Buf, 'MS_WINHELP') = 0) then
  begin
    Info.HelpWnd := Wnd;
    Info.FoundMainWindow := True;
  end;
  Result := not Info.FoundMainWindow;
end;

function DialogEnumerationTester(wnd: HWnd; var Info: TWinHelpFinder): Bool; stdcall;
var
  Buf: Array [Byte] of Char;
begin
  GetClassName(wnd, Buf, Length(Buf));
  if (StrComp(Buf, '#32770') = 0) then
  begin
    Info.FoundDialog := True;
    Info.DialogWnd := Wnd;
  end;
  Result := not Info.FoundDialog;
end;
{$ENDIF}

function FindWinHelp: TWinHelpFinder;
begin
{$IFDEF MSWINDOWS}
  Result.FoundMainWindow := False;
  Result.FoundDialog := False;
  Result.HelpWnd := 0;
  EnumWindows(@WindowEnumerationTester, LPARAM(@Result));
{$ENDIF}
end;
{$ENDIF}


function TWinHelpViewer.IsNewQuery(QueryType: TWHCommandType; Command: String; Context: Integer): Boolean;
var
  WndHelpFinder : TWinHelpFinder;
begin
  Result := True;
  WndHelpFinder := FindWinHelp;
  if WndHelpFinder.FoundMainWindow and (QueryType = FLastCommandType) then
    case QueryType of
      twhCommand:
       Result := (CompareStr(Command, FLastCommand) <> 0);
      twhContext:
       Result := Context <> FLastContext;
    end;
end;

{ Note --- the following two methods will work in Linux but is semantically
  devoid of meaningless. If you find yourself tempted to use them, please
  reconsider, and be sure that the TWinHelpFinder you pass is meaningful.}
function TWinHelpViewer.IsBusyWindow(WndInfo: TWinHelpFinder): Boolean;
begin
  Result := False;{
  if (WndInfo.HelpWnd <> 0) and (not IsWindowVisible(WndInfo.HelpWnd)) then
    Result := true;}
end;

function TWinHelpViewer.CouldBeUnstableWindow(WndInfo: TWinHelpFinder): Boolean;
begin
  Result := (not WndInfo.FoundDialog);
  { also check here for version number. }
end;


function TWinHelpViewer.MakeWinHelpHappy: Boolean;
{$IF NOT DEFINED(LINUX)}
var
  WndInfo: TWinHelpFinder;
{$ENDIF}
begin
{$IF NOT DEFINED(LINUX)}
  Result := False;
  { first pretend we're in C. }
  { if winhelp is up, see if it has a dialog loaded. }
  WndInfo := FindWinHelp;
  if WndInfo.FoundMainWindow then
{$IF DEFINED(CLR)}
    EnumThreadWindows(GetWindowThreadProcessId(WndInfo.HelpWnd, nil),
      @WndInfo.DialogEnumerationTester, 0);
{$ELSE}
    EnumThreadWindows(GetWindowThreadProcessId(WndInfo.HelpWnd, nil),
      @DialogEnumerationTester, LPARAM(@WndInfo));
{$ENDIF}
  { if the window is busy, silently fail the help request rather
    than harassing WinHelp into failure. }

  if IsBusyWindow(WndInfo) then
    Exit;

  if CouldBeUnstableWindow(WndInfo) then RestartWinHelp;
{$ENDIF}
  Result := True;
end;

procedure TWinHelpViewer.RestartWinHelp;
{$IF NOT DEFINED(LINUX)}
var
  StartTime: LongWord;
  FileName : String;
{$ENDIF}
begin
{ WinHelp has an annoying property where if it has an open dialog
  and you send it a new macro, it crashes. In addition, certain older
  versions of WinHelp exhibit similar instabilities at other times.
  This function sends a HELP_QUIT message to winhelp and then waits
  for long enough for the message to be processed and WinHelp to go away.
  WinHelp can then be restarted with a new macro. }
{$IF NOT DEFINED(LINUX)}
  SoftShutDown;
  StartTime := GetTickCount;
  repeat
    //Application.ProcessMessages;
    Sleep(0);
  until ((GetTickCount - StartTime) > 1000);
  FileName := HelpFile('');
  if FileName <> '' then 
    WinHelp(HelpManager.GetHandle, FileName, HELP_FORCEFILE, 0);
{$ENDIF}
{$IFDEF LINUX}
  { The above code has not been tested with HyperHelp under Linux. It is
    possible that the identical code will work, but it is not guaranteed
    at this time. }
{$ENDIF}
end;

{============================================================================}

constructor TWinHelpViewer.Create;
begin
  inherited Create;
  HelpViewerIntf := Self;
end;

destructor TWinHelpViewer.Destroy;
begin
  HelpViewer := nil;
  inherited Destroy;
end;

initialization
  HelpViewer := TWinHelpViewer.Create;
  System.HelpIntfs.RegisterViewer(HelpViewerIntf, HelpViewer.FHelpManager);

{$IF NOT DEFINED(CLR)}
finalization
  if Assigned(HelpViewer.FHelpManager) then
    HelpViewer.InternalShutDown;
  HelpViewerIntf := nil;
  WinHelpTester := nil;
{$ENDIF}
end.
