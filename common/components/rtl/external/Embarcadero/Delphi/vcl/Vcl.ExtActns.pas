{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ExtActns;

interface

uses 
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices,
{$ENDIF}
{$IF NOT DEFINED(LINUX)}
  Winapi.UrlMon, Winapi.ActiveX, 
{$ENDIF}
  System.SysUtils, Winapi.Windows, System.Classes, Vcl.Controls, Vcl.ComCtrls, Vcl.Graphics, System.Win.Registry,
  Vcl.ActnList, Vcl.StdActns, Vcl.StdCtrls, Winapi.ShellAPI, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ImgList, Winapi.Mapi;

type

{ TFileRun }

  TShowCmd = (scHide, scMaximize, scMinimize, scRestore, scShow, scShowDefault,
    scShowMaximized, scShowMinimized, scShowMinNoActive, scShowNA,
    scShowNoActivate, scShowNormal);

  TCustomFileRun = class(TCustomAction)
  private
    FBrowse: Boolean;
    FDirectory: TFileName;
    FFile: TFileName;
    FHInst: HInst;
    FParentHWnd: THandle;
    FParameters: String;
    FOperation: String;
    FShowCmd: TShowCmd;
    FBrowseDlg: TOpenDialog;
    FParentControl: TWinControl;
    function GetDirectory: TFileName;
    function GetFileName: TFileName;
    procedure SetBrowseDlg(const Value: TOpenDialog);
    procedure SetDirectory(Value: TFileName);
    procedure SetFileName(Value: TFileName);
    procedure SetParentControl(const Value: TWinControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure SetupBrowseDialog;
    property HInst: HInst read FHInst;
    procedure UpdateTarget(Target: TObject); override;
    property Browse: Boolean read FBrowse write FBrowse;
    property BrowseDlg: TOpenDialog read FBrowseDlg write SetBrowseDlg;
    property Directory: TFileName read GetDirectory write SetDirectory;
    property FileName: TFileName read GetFileName write SetFileName;
    property Operation: String read FOperation write FOperation;
    property ParentControl: TWinControl read FParentControl write SetParentControl;
    property Parameters: String read FParameters write FParameters;
    property ShowCmd: TShowCmd read FShowCmd write FShowCmd;
  end;

  TFileRun = class(TCustomFileRun)
  published
    property Browse;
    property BrowseDlg;
    property Caption;
    property Directory;
    property Enabled;
    property FileName;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property Operation;
    property ParentControl;
    property Parameters;
    property ShowCmd;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnUpdate;
    property OnHint;
  end;

{ TRichEditAction }

  TRichEditAction = class(TEditAction)
  protected
    function CurrText(Edit: TCustomRichEdit): TTextAttributes;
    procedure SetFontStyle(Edit: TCustomRichEdit; Style: TFontStyle);
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
  end;

{ TRichEditBold }

  TRichEditBold = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TRichEditItalic }

  TRichEditItalic = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TRichEditUnderline }

  TRichEditUnderline = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TRichEditStrikeOut }

  TRichEditStrikeOut = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TRichEditBullets }

  TRichEditBullets = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TRichEditAlignLeft }

  TRichEditAlignLeft = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TRichEditAlignRight }

  TRichEditAlignRight = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TRichEditAlignCenter }

  TRichEditAlignCenter = class(TRichEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

{ TTabAction }

  TTabAction = class;
  TValidateTabEvent = procedure(Sender: TTabAction; TabControl: TCustomTabControl;
    var Enabled: Boolean) of object;

  TTabAction = class(TCustomAction)
  private
    FAfterTabChange: TNotifyEvent;
    FBeforeTabChange: TNotifyEvent;
    FEnabled: Boolean;    
    FOnValidateTab: TValidateTabEvent;
    FSkipHiddenTabs: Boolean;
    FTabControl: TCustomTabControl;
    FWrap: Boolean;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SelectNextTab(GoForward: Boolean = True);
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    property SkipHiddenTabs :Boolean read FSkipHiddenTabs write FSkipHiddenTabs default True;
    property TabControl: TCustomTabControl read FTabControl write FTabControl;
    property Wrap: Boolean read FWrap write FWrap default False;
    property BeforeTabChange: TNotifyEvent read FBeforeTabChange write FBeforeTabChange;
    property AfterTabChange: TNotifyEvent read FAfterTabChange write FAfterTabChange;
    property OnValidateTab: TValidateTabEvent read FOnValidateTab write FOnValidateTab;
  end;

{ TPreviousTab }

  TPreviousTab = class(TTabAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property TabControl;
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SkipHiddenTabs;
    property Visible;
    property Wrap;
    property AfterTabChange;
    property BeforeTabChange;
    property OnHint;
    property OnUpdate;
    property OnValidateTab;
  end;

{ TNextTab }

  TNextTab = class(TTabAction)
  private
    FOldCaption: String;
    FLastTabCaption: String;
    FOnFinish: TNotifyEvent;
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property LastTabCaption: String read FLastTabCaption write FLastTabCaption;
    property TabControl;
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SkipHiddenTabs;
    property Visible;
    property Wrap;
    property AfterTabChange;
    property BeforeTabChange;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
    property OnHint;
    property OnUpdate;
    property OnValidateTab;
  end;

{ TOpenPicture }

  TOpenPicture = class(TCommonDialogAction)
  private
    function GetDialog: TOpenPictureDialog;
  protected
    function GetDialogClass: TCommonDialogClass; override;
  published
    property Dialog: TOpenPictureDialog read GetDialog;
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
    property OnAccept;
    property OnCancel;
  end;

{ TSavePicture }

  TSavePicture = class(TCommonDialogAction)
  private
    function GetDialog: TSavePictureDialog;
  protected
    function GetDialogClass: TCommonDialogClass; override;
  published
    property Dialog: TSavePictureDialog read GetDialog;
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
    property OnAccept;
    property OnCancel;
  end;

{ TURLAction }

{$IF NOT DEFINED(LINUX)}
  TURLAction = class(TCustomAction)
  private
    FURL: String;
    function GetURL: string;
    procedure SetURL(Value: string);
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property URL: String read GetURL write SetURL;
    property OnHint;
    property OnUpdate;
  end;

{ TBrowserURL }

  TBrowseURL = class(TURLAction)
  private
    FAfterBrowse: TNotifyEvent;
    FBeforeBrowse: TNotifyEvent;
  public
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property URL;
    property OnHint;
    property OnUpdate;
    property BeforeBrowse: TNotifyEvent read FBeforeBrowse write FBeforeBrowse;
    property AfterBrowse: TNotifyEvent read FAfterBrowse write FAfterBrowse;
  end;

{ TDownLoadURL }

  TURLDownloadStatus = (dsFindingResource, dsConnecting, dsRedirecting,
    dsBeginDownloadData, dsDownloadingData, dsEndDownloadData,
    dsBeginDownloadComponents, dsInstallingComponents,
    dsEndDownloadComponents, dsUsingCachedCopy, dsSendingRequest,
    dsClassIDAvailable, dsMIMETypeAvailable, dsCacheFileNameAvailable,
    dsBeginSyncOperation, dsEndSyncOperation, dsBeginUploadData,
    dsUploadingData, dsEndUploadData, dsProtocolClassID, dsEncoding,
    dsVerifiedMIMETypeAvailable, dsClassInstallLocation, dsDecoding,
    dsLoadingMIMEHandler, dsContentDispositionAttach, dsFilterReportMIMEType,
    dsCLSIDCanInstantiate, dsIUnKnownAvailable, dsDirectBind, dsRawMIMEType,
    dsProxyDetecting, dsAcceptRanges, dsCookieSent, dsCompactPolicyReceived,
    dsCookieSuppressed, dsCookieStateUnknown, dsCookieStateAccept,
    dsCookeStateReject, dsCookieStatePrompt, dsCookieStateLeash,
    dsCookieStateDowngrade, dsPolicyHREF, dsP3PHeader, dsSessionCookieReceived,
    dsPersistentCookieReceived, dsSessionCookiesAllowed);

  TDownLoadURL = class;

  TDownloadProgressEvent = procedure(Sender: TDownLoadURL; Progress,
    ProgressMax: Cardinal; StatusCode: TURLDownloadStatus; StatusText: String;
    var Cancel: Boolean) of object;

  TDownLoadURL = class(TURLAction , IBindStatusCallback)
  private
    FOnDownloadProgress: TDownloadProgressEvent;
    FFilename: TFilename;
    FBeforeDownload: TNotifyEvent;
    FAfterDownload: TNotifyEvent;
    function GetFileName: TFileName;
    procedure SetFileName(Value: TFileName);
  protected
    { IBindStatusCallback }
{$IF DEFINED(CLR)}
    function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult;
    function GetPriority(out nPriority): HRESULT;
    function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD;
      var formatetc: TFormatEtc; var stgmed: TStgMedium): HResult;
    function OnLowResource(reserved: DWORD): HRESULT;
    function OnObjectAvailable([in, MarshalAs(UnmanagedType.LPStruct)] iid: TGUID;
      [in, MarshalAs(UnmanagedType.IUnknown)] punk: TObject): HRESULT;
    function OnProgress(ulProgress: ULONG; ulProgressMax: ULONG;
      ulStatusCode: ULONG; szStatusText: string): HRESULT;
    function OnStartBinding(dwReserved: DWORD; pib: IBinding): HRESULT;
    function OnStopBinding(hresult: HRESULT; szError: string): HRESULT;
{$ELSE}
    function GetBindInfo(out grfBINDF: Cardinal;
      var bindinfo: _tagBINDINFO): HRESULT; stdcall;
    function GetPriority(out nPriority): HRESULT; stdcall;
    function OnDataAvailable(grfBSCF: Cardinal; dwSize: Cardinal;
      formatetc: PFormatEtc; stgmed: PStgMedium): HRESULT; stdcall;
    function OnLowResource(reserved: Cardinal): HRESULT; stdcall;
    function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HRESULT; stdcall;
    function OnProgress(ulProgress: Cardinal; ulProgressMax: Cardinal;
      ulStatusCode: Cardinal; szStatusText: PWideChar): HRESULT; stdcall;
    function OnStartBinding(dwReserved: Cardinal; pib: IBinding): HRESULT; stdcall;
    function OnStopBinding(hresult: HRESULT; szError: PWideChar): HRESULT; stdcall;
{$ENDIF}
  public
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property Filename: TFilename read GetFilename write SetFilename;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property URL;
    property BeforeDownload: TNotifyEvent read FBeforeDownload write FBeforeDownload;
    property AfterDownload: TNotifyEvent read FAfterDownload write FAfterDownload;
    property OnHint;
    property OnUpdate;
    property OnDownloadProgress: TDownloadProgressEvent read FOnDownloadProgress write FOnDownloadProgress;
  end;
{$ENDIF} // NOT LINUX

  { TSendMail }

{$IFNDEF CLR}
  TSendMail = class;

  TRecipientType = (
    rtPrimary,      // primary message recipient
    rtCC,           // recipient of a message copy
    rtBCC);         // recipient of a blind copy

  TRecipientItem = class(TCollectionItem)
  private
    FAddress: string;
    FDisplayName: string;
    FRecipientType: TRecipientType;
  protected
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
  published
    property RecipientType: TRecipientType read FRecipientType write FRecipientType;
    property DisplayName;
    // examples of valid addresses:
    // FAX:206-555-1212
    // SMTP:M@X.COM
    property Address: string read FAddress write FAddress;
  end;

  TRecipientCollection = class(TOwnedCollection)
  private
    FDisplayCounter: Integer;
    function GetRecipients(const Index: Integer): TRecipientItem; inline;
    procedure SetRecipients(const Index: Integer; const Value: TRecipientItem); inline;
  protected
    property DisplayCounter: Integer read FDisplayCounter;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create(const Action: TSendMail); virtual;
    property Recipients[const Index: Integer]: TRecipientItem read
        GetRecipients write SetRecipients; default;
  end;

  TMailSendStatus = (
    mssSuccess,                // the message was sent
    mssAmbiguousRecipient,     // a recipient matched more than one of the recipient descriptor structures
    mssAttachmentNotFound,     // attachment was not found
    mssAttachmentOpenFailure,  // attachment could not be opened
    mssBadRecipType,           // type of a recipient was not rtPrimary, rtCC, rtBCC
    mssFailure,                // one or more unspecified errors occurred
    mssInsufficientMemory,     // insufficient memory to proceed
    mssInvalidRecips,          // one or more recipients were invalid or did not resolve to any address
    mssLoginFailure,           // no default logon;  the user failed to log on successfully in the logon dialog
    mssTextTooLarge,           // message was too large
    mssTooManyFiles,           // too many file attachments
    mssTooManyRecipients,      // too many recipients
    mssUnknownRecipient,       // a recipient did not appear in the address list
    mssUserAbort,              // user canceled one of the dialog boxes
    mssStatusCodeError);       // the status code is not a valid one

  TMailSendStatusEvent = procedure (Sender: TObject; const Status: TMailSendStatus) of object;
{$ENDIF}

  TSendMail = class(TCustomAction)
  private
    FText: TStrings;
{$IFNDEF CLR}
    FUTF8Encoded: Boolean;
    FSubject: string;
    FRecipients: TRecipientCollection;
    FOnMailSendStatus: TMailSendStatusEvent;
    FAttachments: TStrings;
{$ENDIF}
    procedure SetText(const Value: TStrings);
  protected
{$IFNDEF CLR}
    // every string returned by this function has to be destroyed
    function GetMAPIString(const Value: string): PAnsiChar;
    procedure FreeMAPIString(var Value: PAnsiChar); inline;

    // converts a recipient type value to a MAPI specific value
    function RecipientTypeToRecipClass(const Value: TRecipientType): ULONG; inline;
    function MAPISendStatusToMailSendStatus(const Value: ULONG): TMailSendStatus;

    // obtains a structure specific to MAPI regarding the recipient at
    // the index Index stored by Recipients
    function GetRecipientData(const Index: Integer): TMapiRecipDesc; virtual;
    // frees specifically allocated memory for the fields inside the structure
    procedure FreeRecipientData(var RecipData: TMapiRecipDesc); virtual;
    // returns an array of recipients containing their data specific to MAPI
    // every array of this kind has to be destroyed specifically
    function GetRecipientDataTable: PMapiRecipDesc; virtual;
    // call this function on each array you use to store data for MAPI recipients;
    // it frees all the memory stored inside each structure and the memory for
    // the hole array
    procedure FreeRecipientDataTable(var DataTable: PMapiRecipDesc); virtual;

    // obtains a structure specific to MAPI regarding the attachment specified
    // at the index Index in Attachments
    function GetAttachmentData(const Index: Integer): TMapiFileDesc; virtual;
    // frees specifically allocated memory for the fields inside the structure
    procedure FreeAttachmentData(var AttachData: TMapiFileDesc); virtual;
    // returns an array of attachments containing their data specific to MAPI
    // every array of this kind has to be destroyed specifically
    function GetAttachmentDataTable: PMapiFileDesc; virtual;
    // call this function on each array you use to store data for MAPI attachments;
    // it frees all the memory stored inside each structure and the memory for
    // the hole array
    procedure FreeAttachmentDataTable(var DataTable: PMapiFileDesc); virtual;

    procedure DoMailSendStatus(const MAPIStatus: ULONG); virtual;
{$ENDIF}
    // constructs the MAPI specific structure that represents the message
    function GetMessageData: TMapiMessage; virtual;
    // frees memory explicitly allocated for fields in the structure
    procedure FreeMessageData(var MsgData: TMapiMessage); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
  published
    // each line of the string list specifies the full path to an existing file
    // that will represent part of the attachment of the e-mail
{$IFNDEF CLR}
    property Attachments: TStrings read FAttachments;
{$ENDIF}
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
{$IFNDEF CLR}
    property Recipients: TRecipientCollection read FRecipients;
{$ENDIF}
    property ShortCut;
    property SecondaryShortCuts;
{$IFNDEF CLR}
    // the subject of the e-mail
    property Subject: string read FSubject write FSubject;
{$ENDIF}
    // the e-mail text
    property Text: TStrings read FText write SetText;
    property Visible;
    // determines the usage of UTF8 encoding of the e-mail;
    // if False, the e-mail text uses ASCII charset
{$IFNDEF CLR}
    property UTF8Encoded: Boolean read FUTF8Encoded write FUTF8Encoded default True;
{$ENDIF}
    property OnHint;
    property OnUpdate;
{$IFNDEF CLR}
    property OnMailSendStatus: TMailSendStatusEvent read FOnMailSendStatus write FOnMailSendStatus;
{$ENDIF}
  end;

{ TListControlAction }

  TListControlAction = class(TCustomAction)
  private
    FListControl: TCustomListControl;
    procedure SetListControl(const Value: TCustomListControl);
  protected
    function IsEnabled(Target: TObject): Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    property ListControl: TCustomListControl read FListControl write SetListControl;
  end;

{ TListControlSelectAll }

  TListControlSelectAll = class(TListControlAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ListControl;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
  end;

{ TListControlClearSelection }

  TListControlClearSelection = class(TListControlAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ListControl;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
  end;

{ TListControlDeleteSelection }

  TListControlDeleteSelection = class(TListControlAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ListControl;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
  end;

{ TListBoxCopySelection }

  TListControlCopySelection = class(TListControlAction)
  private
    FDestination: TCustomListControl;
    procedure SetDestination(const Value: TCustomListControl);
  public
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Caption;
    property Destination: TCustomListControl read FDestination write SetDestination;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ListControl;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
  end;

{ TListControlMoveSelection }

  TListControlMoveSelection = class(TListControlCopySelection)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

implementation

uses
{$IF DEFINED(CLR)}
  System.Security.Permissions, System.Net, System.IO,
{$ELSE}
  System.IOUtils,
{$ENDIF}
  Vcl.Forms, Winapi.CommCtrl, Vcl.Consts;

{$IFDEF CLR}
type
  TPath = Path;
{$ENDIF}

{ TCustomFileRun }

constructor TCustomFileRun.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBrowse := False;
  FHinst := 0;
  FParentHWnd := 0;
  FOperation := 'open';
  FFile := '';
  FParameters := '';
  FDirectory := '';
  FShowCmd := scShowNormal;
  SetupBrowseDialog;
end;

[FileIOPermission(SecurityAction.LinkDemand, Unrestricted=True)]
procedure TCustomFileRun.ExecuteTarget(Target: TObject);
const
  ShowCmds: array[TShowCmd] of Integer = (SW_HIDE, SW_MAXIMIZE, SW_MINIMIZE,
    SW_RESTORE, SW_SHOW, SW_SHOWDEFAULT, SW_SHOWMAXIMIZED, SW_SHOWMINIMIZED,
    SW_SHOWMINNOACTIVE, SW_SHOWNA, SW_SHOWNOACTIVATE, SW_SHOWNORMAL);
var
  ParentHWnd: THandle;
begin
  if Assigned(FParentControl) then
  begin
    if FParentControl.HandleAllocated then
      ParentHwnd := FParentControl.Handle
    else
      ParentHWnd := 0;
  end
  else
    if IsWindow(FParentHWnd) then
      ParentHwnd := FParentHWnd
    else
      ParentHWnd := 0;
  if FBrowse then
  begin
    if FBrowseDlg.Execute then
{$IF DEFINED(CLR)}
      FHInst := ShellExecute(ParentHWnd, FOperation, FBrowseDlg.FileName,
        FParameters, FDirectory, ShowCmds[FShowCmd])
{$ELSE}
      FHInst := ShellExecute(ParentHWnd, PChar(FOperation),
        PChar(FBrowseDlg.FileName), PChar(FParameters), PChar(FDirectory),
        ShowCmds[FShowCmd])
{$ENDIF}
    else
      exit;
  end
  else
{$IF DEFINED(CLR)}
    FHInst := ShellExecute(ParentHWnd, FOperation, FFile, FParameters,
      FDirectory, ShowCmds[FShowCmd]);
{$ELSE}
    FHInst := ShellExecute(ParentHWnd, PChar(FOperation), PChar(FFile),
      PChar(FParameters), PChar(FDirectory), ShowCmds[FShowCmd]);
{$ENDIF}
  if FHInst <= 32 then
    raise Exception.Create(SysErrorMessage(FHinst));
end;

function TCustomFileRun.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
function TCustomFileRun.GetDirectory: TFileName;
begin
  Result := FDirectory;
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
function TCustomFileRun.GetFileName: TFileName;
begin
  Result := FFile;
end;

procedure TCustomFileRun.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FParentControl) then
    FParentControl := nil;
end;

procedure TCustomFileRun.SetBrowseDlg(const Value: TOpenDialog);
begin
  if Value <> FBrowseDlg then
  begin
    if Value = nil then
      SetupBrowseDialog
    else
    begin
      if FBrowseDlg.Owner = Self then
        FreeAndNil(FBrowseDlg);
      FBrowseDlg := Value;
    end;
  end;
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
procedure TCustomFileRun.SetDirectory(Value: TFileName);
begin
  if Value <> FDirectory then
    FDirectory := Value;
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
procedure TCustomFileRun.SetFileName(Value: TFileName);
begin
  if Value <> FFile then
    FFile := Value;
end;

procedure TCustomFileRun.SetParentControl(const Value: TWinControl);
begin
  if FParentControl <> Value then
  begin
    FParentControl := Value;
    FParentControl.FreeNotification(Self);
  end;
end;

procedure TCustomFileRun.SetupBrowseDialog;
begin
  FBrowseDlg := TOpenDialog.Create(Self);
  FBrowseDlg.Name := Copy(TOpenDialog.ClassName, 2, Length(TOpenDialog.ClassName));
  FBrowseDlg.SetSubComponent(True);
  FBrowseDlg.Title := SFileRunDialogTitle;
  FBrowseDlg.Name := 'FileRunBrowseDlg';  { do not localize }
end;

procedure TCustomFileRun.UpdateTarget(Target: TObject);
begin
  Enabled := FBrowse or (not FBrowse and (Length(FFile) > 0));
end;

{ TRichEditAction }

constructor TRichEditAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoCheck := True;
end;

function TRichEditAction.CurrText(Edit: TCustomRichEdit): TTextAttributes;
begin
  Result := Edit.SelAttributes;
end;

function TRichEditAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := ((Control <> nil) and (Target = Control) or
    (Control = nil) and (Target is TCustomRichEdit)) and TCustomEdit(Target).Focused;
end;

procedure TRichEditAction.SetFontStyle(Edit: TCustomRichEdit; Style: TFontStyle);
begin
  if Edit = nil then exit;
  if Style in CurrText(Edit).Style then
    CurrText(Edit).Style := CurrText(Edit).Style - [Style]
  else
    CurrText(Edit).Style := CurrText(Edit).Style + [Style];
end;

{ TRichEditBold }

procedure TRichEditBold.ExecuteTarget(Target: TObject);
begin
  SetFontStyle(Target as TCustomRichEdit, fsBold);
end;

procedure TRichEditBold.UpdateTarget(Target: TObject);
begin
  inherited UpdateTarget(Target);
  Enabled := Target is TCustomRichEdit;
  Checked := fsBold in TCustomRichEdit(Target).SelAttributes.Style;
end;

{ TRichEditItalic }

procedure TRichEditItalic.ExecuteTarget(Target: TObject);
begin
  SetFontStyle(Target as TCustomRichEdit, fsItalic);
end;

procedure TRichEditItalic.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomRichEdit;
  Checked := fsItalic in TCustomRichEdit(Target).SelAttributes.Style;
end;

{ TRichEditUnderline }

procedure TRichEditUnderline.ExecuteTarget(Target: TObject);
begin
  SetFontStyle(Target as TCustomRichEdit, fsUnderline);
end;

procedure TRichEditUnderline.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomRichEdit;
  Checked := fsUnderline in TCustomRichEdit(Target).SelAttributes.Style;
end;

{ TRichEditStrikeOut }

procedure TRichEditStrikeOut.ExecuteTarget(Target: TObject);
begin
  if Target is TCustomRichEdit then
    SetFontStyle(Target as TCustomRichEdit, fsStrikeOut);
end;

procedure TRichEditStrikeOut.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomRichEdit;
  if Target is TCustomRichEdit then
    Checked := fsStrikeOut in TCustomRichEdit(Target).SelAttributes.Style;
end;

{ TRichEditBullets }

procedure TRichEditBullets.ExecuteTarget(Target: TObject);
begin
  if Target is TCustomRichEdit then
    if TCustomRichEdit(Target).Paragraph.Numbering = nsNone then
      TCustomRichEdit(Target).Paragraph.Numbering := nsBullet
    else
      TCustomRichEdit(Target).Paragraph.Numbering := nsNone;
end;

procedure TRichEditBullets.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomRichEdit;
  Checked := Enabled and (TCustomRichEdit(Target).Paragraph.Numbering = nsBullet);
end;

{ TRichEditAlignLeft }

procedure TRichEditAlignLeft.ExecuteTarget(Target: TObject);
begin
  if Target is TCustomRichEdit then
    TCustomRichEdit(Target).Paragraph.Alignment := taLeftJustify;
  Checked := True;
end;

procedure TRichEditAlignLeft.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomRichEdit;
  Checked := Enabled and (TCustomRichEdit(Target).Paragraph.Alignment = taLeftJustify);
end;

{ TRichEditAlignRight }

procedure TRichEditAlignRight.ExecuteTarget(Target: TObject);
begin
  if Target is TCustomRichEdit then
    TCustomRichEdit(Target).Paragraph.Alignment := taRightJustify;
  Checked := True;
end;

procedure TRichEditAlignRight.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomRichEdit;
  Checked := Enabled and (TCustomRichEdit(Target).Paragraph.Alignment = taRightJustify);
end;

{ TRichEditAlignCenter }

procedure TRichEditAlignCenter.ExecuteTarget(Target: TObject);
begin
  if Target is TCustomRichEdit then
    TCustomRichEdit(Target).Paragraph.Alignment := taCenter;
  Checked := True;
end;

procedure TRichEditAlignCenter.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomRichEdit;
  Checked := Enabled and (TCustomRichEdit(Target).Paragraph.Alignment = taCenter);
end;

{ TTabAction }

constructor TTabAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableIfNoHandler := False;
  Enabled := csDesigning in ComponentState;
  FSkipHiddenTabs := True;
end;

function TTabAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Assigned(FTabControl);
end;

procedure TTabAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FTabControl) then
    FTabControl := nil;
end;

type
  TTabControlClass = class(TCustomTabControl);

procedure TTabAction.UpdateTarget(Target: TObject);
begin
  if FTabControl is TPageControl then
    FEnabled := Assigned(FTabControl) and FTabControl.Enabled and
      (TPageControl(FTabControl).PageCount > 0)
  else
    FEnabled := Assigned(FTabControl) and FTabControl.Enabled and
      (TTabControlClass(FTabControl).Tabs.Count > 0);
  if FEnabled and Assigned(FOnValidateTab) then
    FOnValidateTab(Self, FTabControl, FEnabled);
end;

procedure TTabAction.SelectNextTab(GoForward: Boolean = True);
const
  Direction: array[Boolean] of Integer = (-1, 1);
begin
  if Assigned(FBeforeTabChange) then
    FBeforeTabChange(Self);
  if FTabControl is TPageControl then
  begin
    with FTabControl as TPageControl do
      if Wrap and GoForward and (ActivePageIndex = PageCount - 1) then
        ActivePageIndex := 0
      else if Wrap and not GoForward and (ActivePageIndex = 0) then
        ActivePageIndex := PageCount - 1
      else
        SelectNextPage(GoForward, FSkipHiddenTabs);
  end
  else if FTabControl is TCustomTabControl then
    with TTabControlClass(FTabControl) do
      if Wrap and GoForward and (TabIndex = Tabs.Count - 1) then
        TabIndex := 0
      else if Wrap and not GoForward and (TabIndex = 0) then
        TabIndex := Tabs.Count - 1
      else
        TabIndex := TabIndex + Direction[GoForward];
  if Assigned(FAfterTabChange) then
    FAfterTabChange(Self);
end;

{ TPreviousTab }

procedure TPreviousTab.ExecuteTarget(Target: TObject);
begin
  SelectNextTab(False)
end;

procedure TPreviousTab.UpdateTarget(Target: TObject);
begin
  inherited UpdateTarget(Target);
  if FEnabled then
  begin
    if FWrap then
      Enabled := True
    else
      if FTabControl is TPageControl then
        Enabled := (TPageControl(FTabControl).ActivePageIndex > 0)
      else
        Enabled := (TTabControlClass(FTabControl).TabIndex > 0);
  end;
end;

{ TNextTab }

procedure TNextTab.ExecuteTarget(Target: TObject);

  function NextPage: Boolean;
  begin
    if FTabControl is TPageControl then
      with TPageControl(FTabControl) do
        Result := ActivePageIndex < PageCount - 1
    else
      with TTabControlClass(FTabControl) do
        Result := TabIndex < Tabs.Count - 1;
  end;

begin
  if NextPage or FWrap then
    SelectNextTab
  else
    if (Length(FLastTabCaption) > 0) and Assigned(FOnFinish) then
      FOnFinish(Self);
end;

procedure TNextTab.UpdateTarget(Target: TObject);

  function OnLastTab: Boolean;
  begin
    if FTabControl is TPageControl then
      with TPageControl(FTabControl) do
        Result := ActivePageIndex = PageCount - 1
    else
      with TTabControlClass(FTabControl) do
        Result := TabIndex = Tabs.Count - 1;
  end;

begin
  inherited UpdateTarget(Target);
  if not FWrap and FEnabled and (Length(FLastTabCaption) = 0) and OnLastTab then
    Enabled := False
  else
    Enabled := FEnabled;
  if not Enabled then exit;
  if not FWrap and OnLastTab then
  begin
    if (Caption <> FLastTabCaption) then
    begin
      FOldCaption := Caption;
      Caption := FLastTabCaption;
    end;
  end
  else
    if (Length(FOldCaption) > 0) and (AnsiCompareText(Caption, FOldCaption) <> 0) then
    begin
      Caption := FOldCaption;
      FOldCaption := ''
    end;
end;

{ TOpenPicture }

function TOpenPicture.GetDialog: TOpenPictureDialog;
begin
  Result := TOpenPictureDialog(FDialog);
end;

function TOpenPicture.Getdialogclass: TCommonDialogClass;
begin
  Result := TOpenPictureDialog;
end;

{ TSavePicture }

function TSavePicture.GetDialog: TSavePictureDialog;
begin
  Result := TSavePictureDialog(FDialog);
end;

function TSavePicture.Getdialogclass: TCommonDialogClass;
begin
  Result := TSavePictureDialog;
end;

{ TURLAction }

{$IF NOT DEFINED(LINUX)}
function TURLAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

[WebPermission(SecurityAction.Demand, Unrestricted=True)]
function TURLAction.GetURL: string;
begin
  Result := FURL;
end;

[WebPermission(SecurityAction.Demand, Unrestricted=True)]
procedure TURLAction.SetURL(Value: string);
begin
  if Value <> FURL then
    FURL := Value;
end;

procedure TURLAction.UpdateTarget(Target: TObject);
begin
  Enabled := (Length(FURL) > 0);
end;

{ TBrowseURL }

[WebPermission(SecurityAction.LinkDemand, Unrestricted=True)]
procedure TBrowseURL.ExecuteTarget(Target: TObject);
begin
  if Assigned(FBeforeBrowse) then
    FBeforeBrowse(Self);
{$IF DEFINED(CLR)}
  ShellExecute(0, nil, URL, '', '', SW_SHOWNORMAL);
{$ELSE}
  ShellExecute(0, nil, PChar(URL), '', '', SW_SHOWNORMAL);
{$ENDIF}
  if Assigned(FAfterBrowse) then
    FAfterBrowse(Self);
end;
{$ENDIF} // NOT LINUX

{ TSendMail }

{$IFNDEF CLR}
function TSendMail.GetAttachmentData(const Index: Integer): TMapiFileDesc;
begin
  with Result do
  begin
    ulReserved := 0;
    flFlags := 0;
    nPosition := $FFFFFFFF;
    lpszPathName := GetMAPIString(TPath.GetFullPath(Attachments[Index]));
    lpszFileName := nil;
    lpFileType := nil;
  end;
end;
{$ENDIF}

{$IFNDEF CLR}
function TSendMail.GetAttachmentDataTable: PMapiFileDesc;
var
  Current: PMapiFileDesc;
  i: Integer;
begin
  Result := nil;
  if Attachments.Count > 0 then
  begin
    GetMem(Result, SizeOf(TMapiFileDesc) * Attachments.Count);

    Current := Result;
    for i := 0 to Attachments.Count - 1do
    begin
      Current^ := GetAttachmentData(i);
      Current := Current + 1;
    end;
  end;
end;
{$ENDIF}

{$IFNDEF CLR}
function TSendMail.GetMAPIString(const Value: string): PAnsiChar;
begin
  Result := nil;
  if Value <> '' then
  begin
    if UTF8Encoded then
      Result := StrNew(PAnsiChar(UTF8Encode(Value)))
    else
      Result := StrNew(PAnsiChar(AnsiString(Value)));
  end;
end;
{$ENDIF}

constructor TSendMail.Create(AOwner: TComponent);
begin
  inherited;

{$IFNDEF CLR}
  UTF8Encoded := True;
  FAttachments := TStringList.Create;
  FRecipients := TRecipientCollection.Create(Self);
{$ENDIF}
  FText := TStringList.Create;
end;

destructor TSendMail.Destroy;
begin
{$IFNDEF CLR}
  FAttachments.Free;
  FRecipients.Free;
{$ENDIF}
  FText.Free;

  inherited Destroy;
end;

{$IFNDEF CLR}
procedure TSendMail.DoMailSendStatus(const MAPIStatus: ULONG);
begin
  if Assigned(OnMailSendStatus) then
    OnMailSendStatus(Self, MAPISendStatusToMailSendStatus(MAPIStatus));
end;
{$ENDIF}

{$IFNDEF CLR}
procedure TSendMail.FreeAttachmentData(var AttachData: TMapiFileDesc);
begin
  FreeMAPIString(AttachData.lpszPathName);
end;
{$ENDIF}

{$IFNDEF CLR}
procedure TSendMail.FreeAttachmentDataTable(var DataTable: PMapiFileDesc);
var
  Current: PMapiFileDesc;
  i: Integer;
begin
  Current := DataTable;
  for i := 0 to Attachments.Count - 1 do
  begin
    FreeAttachmentData(Current^);
    Current := Current + 1;
  end;

  FreeMem(DataTable);
  DataTable := nil;
end;
{$ENDIF}

{$IFNDEF CLR}
procedure TSendMail.FreeMAPIString(var Value: PAnsiChar);
begin
  StrDispose(Value);
  Value := nil;
end;
{$ENDIF}

[SecurityPermission(SecurityAction.LinkDemand, UnmanagedCode=True)]
procedure TSendMail.ExecuteTarget(Target: TObject);
var
  MapiMessage: TMapiMessage;
  Status: Cardinal;
begin
  MapiMessage := GetMessageData;

  Status := MapiSendMail(0, Application.Handle, MapiMessage,
    MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);
  FreeMessageData(MapiMessage);

{$IFNDEF CLR}
  DoMailSendStatus(Status);
{$ENDIF}
end;

procedure TSendMail.FreeMessageData(var MsgData: TMapiMessage);
begin
  {$IFNDEF CLR}
  with MsgData do
  begin
    FreeMAPIString(lpszSubject);
    FreeMAPIString(lpszNoteText);
    FreeRecipientDataTable(lpRecips);
    FreeAttachmentDataTable(lpFiles);
  end;
  {$ENDIF}
end;

{$IFNDEF CLR}
procedure TSendMail.FreeRecipientData(var RecipData: TMapiRecipDesc);
begin
  FreeMAPIString(RecipData.lpszName);
  FreeMAPIString(RecipData.lpszAddress);
end;
{$ENDIF}

{$IFNDEF CLR}
procedure TSendMail.FreeRecipientDataTable(var DataTable: PMapiRecipDesc);
var
  Current: PMapiRecipDesc;
  i: Integer;
begin
  Current := DataTable;
  for i := 0 to Recipients.Count - 1 do
  begin
    FreeRecipientData(Current^);
    Current := Current + 1;
  end;

  FreeMem(DataTable);
  DataTable := nil;
end;
{$ENDIF}

function TSendMail.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

{$IFNDEF CLR}
function TSendMail.MAPISendStatusToMailSendStatus(
  const Value: ULONG): TMailSendStatus;
begin
  case Value of
    SUCCESS_SUCCESS                : Result := mssSuccess;
    MAPI_E_AMBIGUOUS_RECIPIENT     : Result := mssAmbiguousRecipient;
    MAPI_E_ATTACHMENT_NOT_FOUND    : Result := mssAttachmentNotFound;
    MAPI_E_ATTACHMENT_OPEN_FAILURE : Result := mssAttachmentOpenFailure;
    MAPI_E_BAD_RECIPTYPE           : Result := mssBadRecipType;
    MAPI_E_FAILURE                 : Result := mssFailure;
    MAPI_E_INSUFFICIENT_MEMORY     : Result := mssInsufficientMemory;
    MAPI_E_INVALID_RECIPS          : Result := mssInvalidRecips;
    MAPI_E_LOGIN_FAILURE           : Result := mssLoginFailure;
    MAPI_E_TEXT_TOO_LARGE          : Result := mssTextTooLarge;
    MAPI_E_TOO_MANY_FILES          : Result := mssTooManyFiles;
    MAPI_E_TOO_MANY_RECIPIENTS     : Result := mssTooManyRecipients;
    MAPI_E_UNKNOWN_RECIPIENT       : Result := mssUnknownRecipient;
    MAPI_E_USER_ABORT              : Result := mssUserAbort;
  else
    Result := mssStatusCodeError;
  end;
end;
{$ENDIF}

procedure TSendMail.SetText(const Value: TStrings);
begin
  FText.Assign(Value);
end;

procedure TSendMail.UpdateTarget(Target: TObject);
begin
  Enabled := True;
end;

{ TListControlAction }

constructor TListControlAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListControl := nil;
end;

function TListControlAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := (ListControl <> nil) or
    (ListControl = nil) and (Target is TCustomListControl) and
    TCustomListControl(Target).Focused;
end;

function TListControlAction.IsEnabled(Target: TObject): Boolean;
var
  LC: TCustomListControl;
begin
  if Target is TCustomListControl then
  begin
    LC := TCustomListControl(Target);
    Result := (LC.GetCount > 0);
  end
  else
    Result := False;
end;

procedure TListControlAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FListControl) then
    FListControl := nil;
end;

procedure TListControlAction.SetListControl(const Value: TCustomListControl);
begin
  if Value <> FListControl then
  begin
    FListControl := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

{ TListControlSelectAll }

procedure TListControlSelectAll.ExecuteTarget(Target: TObject);
begin
  TCustomListControl(Target).SelectAll;
end;

procedure TListControlSelectAll.UpdateTarget(Target: TObject);
var
  LC: TCustomMultiSelectListControl;
begin
  if Target is TCustomMultiSelectListControl then
  begin
    LC := TCustomMultiSelectListControl(Target);
    Enabled := inherited IsEnabled(Target) and LC.MultiSelect and
      (LC.GetCount > 0) and (LC.SelCount < LC.GetCount);
  end
  else
    Enabled := False;
end;

{ TListControlClearSelection }

procedure TListControlClearSelection.ExecuteTarget(Target: TObject);
begin
  TCustomListControl(Target).ClearSelection;
end;

procedure TListControlClearSelection.UpdateTarget(Target: TObject);
var
  LC: TCustomListControl;
begin
  LC := TCustomListControl(Target);
  if Target is TCustomMultiSelectListControl then
    Enabled := inherited IsEnabled(Target) and (LC.GetCount > 0) and
      (LC.ItemIndex <> -1) and (TCustomMultiSelectListControl(LC).SelCount > 0)
  else
    Enabled := inherited IsEnabled(Target) and (LC.GetCount > 0) and
      (LC.ItemIndex <> -1);
end;

{ TListControlCopySelection }

procedure TListControlCopySelection.ExecuteTarget(Target: TObject);
begin
  ListControl.CopySelection(FDestination);
end;

function TListControlCopySelection.HandlesTarget(Target: TObject): Boolean;
begin
  Result := inherited HandlesTarget(Target) and Assigned(FDestination);
  if Result then
    if ListControl = nil then
      with Target as TCustomListControl do
        Result := ItemIndex <> -1
    else
      Result := ListControl.ItemIndex <> -1
end;

procedure TListControlCopySelection.SetDestination(
  const Value: TCustomListControl);
begin
  if Value <> FDestination then
  begin
    FDestination := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TListControlCopySelection.UpdateTarget(Target: TObject);
var
  LC: TCustomListControl;
begin
  LC := TCustomListControl(Target);
  if Target is TCustomMultiSelectListControl then
    Enabled := inherited IsEnabled(Target) and (LC.GetCount > 0) and
      (LC.ItemIndex >= 0) and (TCustomMultiSelectListControl(LC).SelCount > 0)
  else
    Enabled := inherited IsEnabled(Target) and (LC.GetCount > 0) and
      (LC.ItemIndex >= 0) and (LC.ItemIndex >= 0);
end;

{ TListControlMoveSelection }

procedure TListControlMoveSelection.ExecuteTarget(Target: TObject);
begin
  TCustomListControl(Target).MoveSelection(FDestination);
end;

{ TListControlDeleteSelection }

procedure TListControlDeleteSelection.ExecuteTarget(Target: TObject);
begin
  TCustomListControl(Target).DeleteSelected;
end;

type
  TCustomListControlClass = class(TCustomListControl);

procedure TListControlDeleteSelection.UpdateTarget(Target: TObject);
begin
  Enabled := inherited IsEnabled(Target) and
    (TCustomListControl(Target).ItemIndex <> -1);
end;

{ TDownLoadURL }

{$IF NOT DEFINED(LINUX)}
const
  // Maps to the status codes for IBindStatusCallBack
  BindStatusCode: array[0..54] of DWORD =
   (BINDSTATUS_FINDINGRESOURCE,
    BINDSTATUS_CONNECTING,
    BINDSTATUS_REDIRECTING,
    BINDSTATUS_BEGINDOWNLOADDATA,
    BINDSTATUS_DOWNLOADINGDATA,
    BINDSTATUS_ENDDOWNLOADDATA,
    BINDSTATUS_BEGINDOWNLOADCOMPONENTS,
    BINDSTATUS_INSTALLINGCOMPONENTS,
    BINDSTATUS_ENDDOWNLOADCOMPONENTS,
    BINDSTATUS_USINGCACHEDCOPY,
    BINDSTATUS_SENDINGREQUEST,
    BINDSTATUS_CLASSIDAVAILABLE,
    BINDSTATUS_MIMETYPEAVAILABLE,
    BINDSTATUS_CACHEFILENAMEAVAILABLE,
    BINDSTATUS_BEGINSYNCOPERATION,
    BINDSTATUS_ENDSYNCOPERATION,
    BINDSTATUS_BEGINUPLOADDATA,
    BINDSTATUS_UPLOADINGDATA,
    BINDSTATUS_ENDUPLOADDATA,
    BINDSTATUS_PROTOCOLCLASSID,
    BINDSTATUS_ENCODING,
    BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE,
    BINDSTATUS_CLASSINSTALLLOCATION,
    BINDSTATUS_DECODING,
    BINDSTATUS_LOADINGMIMEHANDLER,
    BINDSTATUS_CONTENTDISPOSITIONATTACH,
    BINDSTATUS_FILTERREPORTMIMETYPE,
    BINDSTATUS_CLSIDCANINSTANTIATE,
    BINDSTATUS_IUNKNOWNAVAILABLE,
    BINDSTATUS_DIRECTBIND,
    BINDSTATUS_RAWMIMETYPE,
    BINDSTATUS_PROXYDETECTING,
    BINDSTATUS_ACCEPTRANGES,
    BINDSTATUS_CONTENTDISPOSITIONATTACH,
    BINDSTATUS_FILTERREPORTMIMETYPE,
    BINDSTATUS_CLSIDCANINSTANTIATE,
    BINDSTATUS_IUNKNOWNAVAILABLE,
    BINDSTATUS_DIRECTBIND,
    BINDSTATUS_RAWMIMETYPE,
    BINDSTATUS_PROXYDETECTING,
    BINDSTATUS_ACCEPTRANGES,
    BINDSTATUS_COOKIE_SENT,
    BINDSTATUS_COMPACT_POLICY_RECEIVED,
    BINDSTATUS_COOKIE_SUPPRESSED,
    BINDSTATUS_COOKIE_STATE_UNKNOWN,
    BINDSTATUS_COOKIE_STATE_ACCEPT,
    BINDSTATUS_COOKIE_STATE_REJECT,
    BINDSTATUS_COOKIE_STATE_PROMPT,
    BINDSTATUS_COOKIE_STATE_LEASH,
    BINDSTATUS_COOKIE_STATE_DOWNGRADE,
    BINDSTATUS_POLICY_HREF,
    BINDSTATUS_P3P_HEADER,
    BINDSTATUS_SESSION_COOKIE_RECEIVED,
    BINDSTATUS_PERSISTENT_COOKIE_RECEIVED,
    BINDSTATUS_SESSION_COOKIES_ALLOWED
    );

function DWordEnumToPascalEnumOrd(const EnumArray: array of DWORD; Value: DWORD): Integer;
begin
  for Result := Low(EnumArray) to High(EnumArray) do
    if Value = EnumArray[Result] then Exit;
  raise Exception.CreateRes({$IFNDEF CLR}@{$ENDIF}SInvalidEnumValue);
end;

                                
{$IF NOT DEFINED(CLR)}
type
  TUrlMonDownloadToFile = function(Caller: IUnknown; URL: PChar; FileName: PChar;
    Reserved: DWORD; StatusCB: IBindStatusCallback): HResult; stdcall;
{$ENDIF}

var
{$IF DEFINED(CLR)}
  UrlMonChecked: Boolean = False;
  SupportsDownLoad: Boolean = False;
{$ELSE}
  UrlMonHandle: HMODULE;
  UrlMonDownloadToFile: TUrlMonDownloadToFile;
  UrlMonInitialized: Boolean;
{$ENDIF}

const
  UrlMonLib = 'urlmon.dll'; // Do not localize
{$IFDEF UNICODE}
  sURLMonDownloadToFile = 'URLDownloadToFileW'; // Do not localize
{$ELSE}
  sURLMonDownloadToFile = 'URLDownloadToFileA'; // Do not localize
{$ENDIF}

[WebPermission(SecurityAction.LinkDemand, Unrestricted=True)]
procedure TDownLoadURL.ExecuteTarget(Target: TObject);
{$IF DEFINED(CLR)}
var
  UrlMonHandle: THandle;
begin
  if not UrlMonChecked then
  begin
    UrlMonChecked := True;
    UrlMonHandle := LoadLibrary(UrlMonLib);
    if UrlMonHandle <> 0 then
    try
      SupportsDownLoad := GetProcAddress(UrlMonHandle, sURLMonDownloadToFile) <> nil;
    finally
      FreeLibrary(UrlMonHandle);
    end;
  end;
  if SupportsDownLoad then
  begin
    if URLDownloadToFile(nil, URL, FileName, 0, Self as IBindStatusCallBack) <> S_OK then
      raise Exception.CreateFmt(SErrorDownloadingURL, [URL]);
  end else
    raise Exception.CreateFmt(SUrlMonDllMissing, [UrlMonLib]);
{$ELSE}
begin
  if not UrlMonInitialized then
  begin
    UrlMonHandle := LoadLibrary(UrlMonLib);
    if UrlMonHandle <> 0 then
      UrlMonDownloadToFile := GetProcAddress(UrlMonHandle, PAnsiChar(AnsiString(sURLMonDownloadToFile)));
    UrlMonInitialized := True;
  end;
  if Assigned(UrlMonDownloadToFile) then
  begin
    if URLMonDownloadToFile(nil, PChar(URL), PChar(FileName), 0, Self as IBindStatusCallBack) <> S_OK then
      raise Exception.CreateResFmt(@SErrorDownloadingURL, [URL]);
  end else
    raise Exception.CreateResFmt(@SUrlMonDllMissing, [UrlMonLib]);
{$ENDIF}
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
function TDownLoadURL.GetFileName: TFileName;
begin
  Result := FFileName;
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
procedure TDownLoadURL.SetFileName(Value: TFileName);
begin
  if Value <> FFileName then
    FFileName := Value;
end;

{$IF DEFINED(CLR)}
function TDownLoadURL.GetBindInfo(out grfBINDF: DWORD;
  var bindinfo: TBindInfo): HResult;
{$ELSE}
function TDownLoadURL.GetBindInfo(out grfBINDF: Cardinal;
  var bindinfo: _tagBINDINFO): HRESULT;
{$ENDIF}
begin
  Result := E_NOTIMPL;
end;

function TDownLoadURL.GetPriority(out nPriority): HRESULT;
begin
  Result := E_NOTIMPL;
end;

{$IF DEFINED(CLR)}
function TDownLoadURL.OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD;
  var formatetc: TFormatEtc; var stgmed: TStgMedium): HResult;
{$ELSE}
function TDownLoadURL.OnDataAvailable(grfBSCF, dwSize: Cardinal;
  formatetc: PFormatEtc; stgmed: PStgMedium): HRESULT;
{$ENDIF}
begin
  Result := E_NOTIMPL;
end;

function TDownLoadURL.OnLowResource(reserved: Cardinal): HRESULT;
begin
  Result := E_NOTIMPL;
end;

{$IF DEFINED(CLR)}
function TDownLoadURL.OnObjectAvailable([in, MarshalAs(UnmanagedType.LPStruct)] iid: TGUID;
  [in, MarshalAs(UnmanagedType.IUnknown)] punk: TObject): HRESULT;
{$ELSE}
function TDownLoadURL.OnObjectAvailable(const iid: TGUID;
  punk: IUnknown): HRESULT;
{$ENDIF}
begin
  Result := E_NOTIMPL;
end;

{$IF DEFINED(CLR)}
function TDownLoadURL.OnProgress(ulProgress: ULONG; ulProgressMax: ULONG;
  ulStatusCode: ULONG; szStatusText: string): HRESULT;
{$ELSE}
function TDownLoadURL.OnProgress(ulProgress, ulProgressMax,
  ulStatusCode: Cardinal; szStatusText: PWideChar): HRESULT;
{$ENDIF}
const
  ContinueDownload: array[Boolean] of Integer = (S_OK, E_ABORT);
var
  Cancel: Boolean;
begin
  Cancel := False;
  if Assigned(FOnDownloadProgress) then
    FOnDownloadProgress(Self, ulProgress, ulProgressMax,
      TURLDownloadStatus(DWordEnumToPascalEnumOrd(BindStatusCode, ulStatusCode)),
{$IF DEFINED(CLR)}
      Trim(szStatusText), Cancel);
{$ELSE}
      Trim(WideCharToString(szStatusText)), Cancel);
{$ENDIF}
  Result := ContinueDownload[Cancel];
end;

function TDownLoadURL.OnStartBinding(dwReserved: Cardinal;
  pib: IBinding): HRESULT;
begin
  Result := E_NOTIMPL;
end;

{$IF DEFINED(CLR)}
function TDownLoadURL.OnStopBinding(hresult: HRESULT;
  szError: string): HRESULT;
{$ELSE}
function TDownLoadURL.OnStopBinding(hresult: HRESULT;
  szError: PWideChar): HRESULT;
{$ENDIF}
begin
  Result := E_NOTIMPL;
end;
{$ENDIF} // NOT LINUX

{ TRecipient }

function TSendMail.GetMessageData: TMapiMessage;
begin
  with Result do
  begin
{$IFNDEF CLR}
    if UTF8Encoded then
      ulReserved := CP_UTF8
    else
{$ENDIF}
      ulReserved := 0;

{$IF DEFINED(CLR)}
    lpszSubject := nil;
    lpszNoteText := Text.Text;
    lpszMessageType := '';
    lpszDateReceived := '';
    lpszConversationID := '';
    flFlags := 0;
    lpOriginator := nil;
    nRecipCount := 0;
    lpRecips := nil;
    nFileCount := 0;
    lpFiles := nil;
{$ELSE}
    lpszSubject := GetMAPIString(Subject);
    lpszNoteText := GetMAPIString(Text.Text);
    lpszMessageType := nil;
    lpszDateReceived := nil;
    lpszConversationID := nil;
    flFlags := 0;
    lpOriginator := nil;
    nRecipCount := Recipients.Count;
    lpRecips := Pointer(GetRecipientDataTable);
    nFileCount := Attachments.Count;
    lpFiles := Pointer(GetAttachmentDataTable);
{$ENDIF}
  end;
end;

{$IFNDEF CLR}
function TSendMail.GetRecipientData(const Index: Integer): TMapiRecipDesc;
begin
  with Result do
  begin
    ulReserved := 0;
    ulRecipClass := RecipientTypeToRecipClass(Recipients[Index].RecipientType);
    lpszName := GetMAPIString(Recipients[Index].DisplayName);
    lpszAddress := GetMAPIString(Recipients[Index].Address);
    ulEIDSize := 0;
    lpEntryID := nil;
  end;
end;
{$ENDIF}

{$IFNDEF CLR}
function TSendMail.GetRecipientDataTable: PMapiRecipDesc;
var
  Current: PMapiRecipDesc;
  i: Integer;
begin
  Result := nil;
  if Recipients.Count > 0 then
  begin
    GetMem(Result, SizeOf(TMapiRecipDesc) * Recipients.Count);

    Current := Result;
    for i := 0 to Recipients.Count - 1do
    begin
      Current^ := GetRecipientData(i);
      Current := Current + 1;
    end;
  end;
end;
{$ENDIF}

{$IFNDEF CLR}
function TSendMail.RecipientTypeToRecipClass(
  const Value: TRecipientType): ULONG;
begin
  Result := Ord(Value) + 1;
end;
{$ENDIF}

{ TRecipient }

{$IFNDEF CLR}
function TRecipientItem.GetDisplayName: string;
begin
  Result := FDisplayName;
end;
{$ENDIF}

{$IFNDEF CLR}
procedure TRecipientItem.SetDisplayName(const Value: string);
begin
  FDisplayName := Value;
  inherited;
end;
{$ENDIF}

{ TRecipients }

{$IFNDEF CLR}
constructor TRecipientCollection.Create(const Action: TSendMail);
begin
  inherited Create(Action, TRecipientItem);
end;
{$ENDIF}

{$IFNDEF CLR}
function TRecipientCollection.GetRecipients(const Index: Integer): TRecipientItem;
begin
  Result := TRecipientItem(GetItem(Index));
end;
{$ENDIF}

{$IFNDEF CLR}
procedure TRecipientCollection.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited;

  if Action = System.Classes.TCollectionNotification.cnAdded then
  begin
    Inc(FDisplayCounter);
    with Item do
      DisplayName := Copy(ClassName, 2, Length(ClassName) - 1) + IntToStr(DisplayCounter);
  end;
end;
{$ENDIF}

{$IFNDEF CLR}
procedure TRecipientCollection.SetRecipients(const Index: Integer;
  const Value: TRecipientItem);
begin
  SetItem(Index, Value);
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
initialization

finalization
  if UrlMonInitialized and (UrlMonHandle <> 0) then
    FreeLibrary(UrlMonHandle);
{$ENDIF}
end.


