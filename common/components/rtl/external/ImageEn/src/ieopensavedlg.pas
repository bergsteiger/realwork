(*
Copyright (c) 1998-2004 by HiComponents. All rights reserved.

This software comes without any warranty either implied or expressed.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the compiled component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE,
BUT YOU MAY NOT DISTRIBUTE THIS SOURCE CODE OR ITS COMPILED .DCU IN ANY FORM.

ImageEn may not be included in any commercial, shareware or freeware DELPHI
libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com

*)

unit ieopensavedlg;

{$R-}
{$Q-}



{$I ie.inc}

{$ifdef IEINCLUDEOPENSAVEDIALOGS}

interface



uses
  Windows, Messages, SysUtils, CommDlg, Classes, Graphics, Controls, Forms, comctrls,
  Clipbrd, stdctrls, buttons, extctrls, Dialogs, hyieutils, hyiedefs, ImageEnIO, ImageEnView,
  IEMView, IEMIO;

type

  TIEDBorderStyle=(iepsDefault, iepsCropped, iepsCropShadow);

  TIECommonDialog = class(TComponent)
  private
    fMsgLanguage:TMsgLanguage;
    //
    FCtl3D: Boolean;
    FDefWndProc: Pointer;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FObjectInstance: Pointer;
    FTemplate: PAnsiChar;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    fShowPlacesBar:boolean;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMInitDialog(var Message: TWMInitDialog); message WM_INITDIALOG;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure MainWndProc(var Message: TMessage);
  protected
  	 fExtendedDialog:boolean;
    procedure DoClose; virtual;
    procedure DoShow; virtual;
    procedure WndProc(var Message: TMessage); virtual;
    function MessageHook(var Msg: TMessage): Boolean; virtual;
    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; virtual;
    function Execute: Boolean; virtual; abstract;
    property Template: PAnsiChar read FTemplate write FTemplate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    property Handle: HWnd read FHandle;
  published
    property Ctl3D: Boolean read FCtl3D write FCtl3D default True;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
	 property MsgLanguage:TMsgLanguage read fMsgLanguage write fMsgLanguage default msSystem;
    property ShowPlacesBar:boolean read fShowPlacesBar write fShowPlacesBar default true;
    property ExtendedDialog:boolean read fExtendedDialog write fExtendedDialog default true;
  end;

  TOpenImageEnDialog = class(TIECommonDialog)
  private
    m_blnInSelectionChange: Boolean;
    FImageEnIO: TImageEnIO;
    FImageEnView: TImageEnView;
    {$ifdef IEINCLUDEMULTIVIEW}
    fImageEnMView: TImageEnMView;
    fImageEnMIO: TImageEnMIO;
    {$endif}
    FPicturePanel: TPanel;
    fPicLabel1: TLabel;
    fPicLabel2: TLabel;
    fPicLabel3: TLabel;
    fInfoPanel: TPanel;
    fInfoLabel1: TLabel;
    fInfoLabel2: TLabel;
    FPreviewButton: TSpeedButton;
    FZoomComboBox: TComboBox;
    fProgressBar:TProgressBar;
    {$ifdef IEINCLUDEMULTIVIEW}
    fPlayButton: TSpeedButton;
    {$endif}
    fAdvancedButton: TButton;
    fPreviewCheck: TCheckBox;
    fFileSize:integer;	// size of last file loaded
    fFrames:integer;	// page count of last file loaded
    SPreviewLabel:string;
    fSelType:string;
    fAutoSetFilter:boolean;
    {$ifdef IEINCLUDEMULTIVIEW}
    fAlwaysAnimate:boolean;
    {$endif}
    fAutoAdjustDPI:boolean;
    fFilteredAdjustDPI:boolean;
  	 //
    FHistoryList: TStrings;
    FOptions: TOpenOptions;
    FFilter: string;
    FFilterIndex: Integer;
    FCurrentFilterIndex: Integer;
    FInitialDir: string;
    FTitle: string;
    FDefaultExt: string;
    FFileName: TFileName;
    FFiles: TStrings;
    FFileEditStyle: TFileEditStyle;
    FOnSelectionChange: TNotifyEvent;
    FOnFolderChange: TNotifyEvent;
    FOnTypeChange: TNotifyEvent;
    FOnCanClose: TCloseQueryEvent;
    fPreviewBorderStyle: TIEDBorderStyle;
    fShowAVI:boolean;
    fExtendedFilters:string;
    fShowAllFrames:boolean;
    function GetFileName: TFileName;
    function GetFileName2: TFileName;
    function GetFilterIndex: Integer;
    procedure ReadFileEditStyle(Reader: TReader);
    procedure SetHistoryList(Value: TStrings);
    procedure SetInitialDir(const Value: string);
    //function AdjustFileName(fn:string):string;
    //
    procedure PreviewClick(Sender: TObject);
    procedure PreviewKeyPress(Sender: TObject; var Key: Char);
    procedure ZoomComboChange(Sender: TObject);
    procedure ImageEnIOProgress(Sender: TObject; per: integer);
    procedure ShowIOParams(params:TIOParamsVals);
    procedure DoCheckPreview(Sender: TObject);
    procedure SetPreviewBorderStyle(v:TIEDBorderStyle);
    procedure SetZoomFilter(v:TResampleFilter);
    function GetZoomFilter:TResampleFilter;
  protected
  	 fShowPreview:boolean;	// if true show the preview of images
    //
    procedure ImageSelect(Sender:TObject; idx:integer);
    procedure PlayClick(Sender: TObject);
    function CanClose(var OpenFileName: TOpenFileName): Boolean;
    function DoCanClose: Boolean; virtual;
    function DoExecute(Func: Pointer): Bool;
    procedure DoSelectionChange; virtual;
    procedure DoFolderChange; virtual;
    procedure DoTypeChange; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetFileNames(var OpenFileName: TOpenFileName);
    function GetStaticRect: TRect; virtual;
    procedure WndProc(var Message: TMessage); override;
    function BuildStrFilter:string;
    //
    procedure SetZoom; virtual;
    procedure DoClose; override;
    procedure DoShow; override;
	 procedure SetLang;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    property FileEditStyle: TFileEditStyle read FFileEditStyle write FFileEditStyle;
    property Files: TStrings read FFiles;
    property HistoryList: TStrings read FHistoryList write SetHistoryList;
 	 property ShowAVI:boolean read fShowAVI write fShowAVI;
    property PreviewCheckBox:TCheckBox read fPreviewCheck;
    property ExtendedFilters:string read fExtendedFilters write fExtendedFilters;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property FileName: TFileName read GetFileName write FFileName;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read GetFilterIndex write FFilterIndex default 1;
    property InitialDir: string read FInitialDir write SetInitialDir;
    property Options: TOpenOptions read FOptions write FOptions default [ofHideReadOnly];
    property Title: string read FTitle write FTitle;
    property OnCanClose: TCloseQueryEvent read FOnCanClose write FOnCanClose;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
    property AutoSetFilter:boolean read fAutoSetFilter write fAutoSetFilter default true;
    {$ifdef IEINCLUDEMULTIVIEW}
    property AlwaysAnimate:boolean read fAlwaysAnimate write fAlwaysAnimate default false;
    {$endif}
    property PreviewBorderStyle:TIEDBorderStyle read fPreviewBorderStyle write SetPreviewBorderStyle default iepsDefault;
    property AutoAdjustDPI:boolean read fAutoAdjustDPI write fAutoAdjustDPI default false;
    property FilteredAdjustDPI:boolean read fFilteredAdjustDPI write fFilteredAdjustDPI default false;
    property ZoomFilter:TResampleFilter read GetZoomFilter write SetZoomFilter default rfFastLinear;
    property ShowAllFrames:boolean read fShowAllFrames write fShowAllFrames default false;
  end;

  TIESaveDlgOpt = set of (sdShowPreview, sdShowAdvanced);

  TSaveImageEnDialog = class(TOpenImageEnDialog)
  private
    fExOptions:TIESaveDlgOpt;
	 fAttachedImageEnIO:TComponent;
    fBackParams:TIOParamsVals;
    procedure DoAdvanced(Sender: TObject);
    procedure SetAttachedImageEnIO(v:TComponent);
  protected
    procedure DoTypeChange; override;
    procedure SetFileNameExt; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
  published
    property ExOptions:TIESaveDlgOpt read fExOptions write fExOptions;
    property AttachedImageEnIO:TComponent read fAttachedImageEnIO write SetAttachedImageEnIO;
  end;

implementation

uses dlgs;

{$R-}

{$R IEOpenSaveDlg.res}

var
  CreationControl: TIECommonDialog = nil;
  HelpMsg: Cardinal;
  //WndProcPtrAtom: TAtom = 0;
  HookCtl3D: Boolean;

type
  TIEOpenFileNameEx = packed record
    lStructSize: DWORD;
    hWndOwner: HWND;
    hInstance: HINST;
    lpstrFilter: PAnsiChar;
    lpstrCustomFilter: PAnsiChar;
    nMaxCustFilter: DWORD;
    nFilterIndex: DWORD;
    lpstrFile: PAnsiChar;
    nMaxFile: DWORD;
    lpstrFileTitle: PAnsiChar;
    nMaxFileTitle: DWORD;
    lpstrInitialDir: PAnsiChar;
    lpstrTitle: PAnsiChar;
    Flags: DWORD;
    nFileOffset: Word;
    nFileExtension: Word;
    lpstrDefExt: PAnsiChar;
    lCustData: LPARAM;
    lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
    lpTemplateName: PAnsiChar;
    pvReserved : Pointer;
    dwReserved : DWORD;
    FlagsEx : DWORD;
  end;


///////////////////////////////////////////////////////////////////////////////
// in '*.jpg;*.jpeg' result= '.jpg'
function ExtractFirstExt(s:string):string;
var
	p1,p2:integer;
begin
	p1:=pos('.',s);
   p2:=pos(';',s);
   if p2=0 then
   	p2:=length(s)+1;
   result:=copy(s,p1,p2-p1);
end;

///////////////////////////////////////////////////////////////////////////////
function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  case Msg of
    WM_INITDIALOG:
      begin
        if HookCtl3D then
        begin
        	 {$WARNINGS OFF}
          Subclass3DDlg(Wnd, CTL3D_ALL);
          SetAutoSubClass(True);
          {$WARNINGS ON}
        end;
        IECenterWindow(Wnd);
        CreationControl.FHandle:= Wnd;
        CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
          Longint(CreationControl.FObjectInstance)));
        CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
        CreationControl := nil;
      end;
    WM_DESTROY:
    	{$WARNINGS OFF}
      if HookCtl3D then SetAutoSubClass(False);
      {$WARNINGS ON}
  end;
end;

///////////////////////////////////////////////////////////////////////////////
constructor TIECommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCtl3D := True;
  fExtendedDialog:=true;
  {$WARNINGS OFF}
  FObjectInstance := MakeObjectInstance(MainWndProc);
  {$WARNINGS ON}
  //
  fMsgLanguage:=msSystem;
  fShowPlacesBar:=true;
end;

///////////////////////////////////////////////////////////////////////////////
destructor TIECommonDialog.Destroy;
begin
  {$WARNINGS OFF}
  if FObjectInstance <> nil then FreeObjectInstance(FObjectInstance);
  {$WARNINGS ON}
  inherited Destroy;
end;

///////////////////////////////////////////////////////////////////////////////
function TIECommonDialog.MessageHook(var Msg: TMessage): Boolean;
begin
   Result := False;
   if (Msg.Msg = HelpMsg) and (FHelpContext <> 0) then begin
   	if assigned(Application) then
			Application.HelpContext(FHelpContext);
     	Result := True;
   end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, LParam)
  else inherited DefaultHandler(Message);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.MainWndProc(var Message: TMessage);
begin
   try
   	WndProc(Message);
   except
   	if assigned(Application) then
	      Application.HandleException(Self);
   end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  DoClose;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.WMInitDialog(var Message: TWMInitDialog);
begin
  { Called only by non-explorer style dialogs }
  DoShow;
  { Prevent any further processing }
  Message.Result := 0;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
end;

///////////////////////////////////////////////////////////////////////////////
function TIECommonDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
type
	TDialogFunc = function(var DialogData): Bool stdcall;
var
   {$ifndef OCXVERSION}
   ActiveWindow: HWnd;
   {$endif}
   WindowList: Pointer;
begin
   {$ifndef OCXVERSION}
   ActiveWindow := GetActiveWindow;
   {$endif}
   WindowList := DisableTaskWindows(0);
   try
   	if assigned(Application) then
	      Application.HookMainWindow(MessageHook);
      try
         CreationControl := Self;
         Result := TDialogFunc(DialogFunc)(DialogData);
         Set8087CW(Default8087CW);
      finally
      	if assigned(Application) then
	         Application.UnhookMainWindow(MessageHook);
      end;
   finally
      EnableTaskWindows(WindowList);
      {$ifndef OCXVERSION}
      SetActiveWindow(ActiveWindow);
      {$endif}
   end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.DoClose;
begin
  inherited DoClose;
  {$ifdef IEINCLUDEMULTIVIEW}
  fImageEnMView.Playing:=false;
  fImageEnMView.clear;
  {$endif}
  fImageEnView.blank;
  if assigned(Application) then
	  Application.HideHint;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TIECommonDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

///////////////////////////////////////////////////////////////////////////////
function ExplorerHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end
  else if (Msg = WM_NOTIFY) and (POFNotify(LParam)^.hdr.code = CDN_INITDONE) then
  		IECenterWindow(GetWindowLong(Wnd, GWL_HWNDPARENT));
end;


{ TOpenImageEnDialog }

function TOpenImageEnDialog.BuildStrFilter;
var
	q,w,cc:integer;
   all,ex,s1,s2:string;
   c:char;
begin
 	IEUpdateGIFStatus;
   all:=iemsg(IEMSG_ALLGRAPHICS,fMsglanguage)+'|';
   result:='';
	for q:=0 to iegFileFormats.Count-1 do
   	with PIEFileFormatInfo(iegFileFormats[q])^ do begin
         if ((self is TSaveImageEnDialog) and (@WriteFunction<>nil)) or ((not(self is TSaveImageEnDialog)) and (@ReadFunction<>nil)) then begin
            ex:='*.'+lowercase(IEFileFormatGetExt(FileType,0));
            cc:=IEFileFormatGetExtCount(FileType);
            for w:=1 to cc-1 do
               ex:=ex+';*.'+lowercase(IEFileFormatGetExt(FileType,w));
            all:=all+ex;
            if q<iegFileFormats.Count-1 then
               all:=all+';';
            result:=result+'|'+FullName+' ('+uppercase(IEFileFormatGetExt(FileType,0));
            for w:=1 to cc-1 do
               result:=result+';'+uppercase(IEFileFormatGetExt(FileType,w));
            result:=result+')|'+ex;
         end;
	   end;
   // animated files
   if fShowAVI then begin
      all:=all+';*.avi';
      result:=result+'|'+iemsg(IEMSG_VIDEOFORWINDOWS,fMsglanguage)+' (AVI)|*.avi';
   end;
   // Extended filters (example: 'Fun Bitmap|*.fun;*.fan|etc...'
   s1:='';	// to result
   s2:='';	// to all graphics
   q:=1; w:=-1;
   while q<=length(fExtendedFilters) do begin
   	c:=fExtendedFilters[q];
   	if w=-1 then begin
      	s1:=s1+c;
        	if c='|' then w:=q;
      end else begin
      	if (c='|') or (q=length(fExtendedFilters)) then begin
				w:=-1;
            s1:=s1+c;
            if c<>'|' then
            	s2:=s2+c;
            if q<length(fExtendedFilters) then
		         s2:=s2+';';
         end else begin
            s1:=s1+c;
            s2:=s2+c;
         end;
      end;
      inc(q);
   end;
   s1:=trim(s1);
   s2:=trim(s2);
   if s1<>'' then
   	result:=result+'|'+s1;
   if s2<>'' then
   	all:=all+';'+s2;
   //
   if self is TSaveImageEnDialog then
      result:=copy(result,2,length(result))
   else
	   result:=all+result;
end;

procedure TOpenImageEnDialog.SetLang;
begin
	FPreviewButton.Hint:=iemsg(IEMSG_PREVIEW,fMsglanguage);
   fPreviewCheck.Caption:=iemsg(IEMSG_PREVIEW,fMsglanguage);
   fAdvancedButton.Caption:=iemsg(IEMSG_ADVANCED,fMsgLanguage)+'...';
   {$ifdef IEINCLUDEMULTIVIEW}
   FPlayButton.Hint:=iemsg(IEMSG_ANIMATE,fMsglanguage);
   {$endif}
end;

constructor TOpenImageEnDialog.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   IEUpdateGIFStatus;
   fShowAVI:=true;
   fShowAllFrames:=false;
   fPreviewBorderStyle:=iepsDefault;
   {$ifdef IEINCLUDEMULTIVIEW}
   fAlwaysAnimate:=false;
   {$endif}
   fSelType:='';
   FHistoryList := TStringList.Create;
   FOptions := [ofHideReadOnly];
   FFiles := TStringList.Create;
   FFilterIndex := 1;
   FFileEditStyle := fsEdit;
   fAutoAdjustDPI:=false;
   fFilteredAdjustDPI:=false;
   fExtendedFilters:='';
   //
   fShowPreview:=true;
   fAutoSetFilter:=true;
   Filter:=BuildStrFilter;
   //
   FInfoPanel := TPanel.Create(Self);
   with FInfoPanel do begin
     Name := 'InfoPanel';
     Caption := '';
     Ctl3D := True;
     SetBounds(204, 5, 169, 200);
     BevelOuter := bvNone;
     BorderWidth := 6;
     TabOrder := 1;
   end;
   FInfoLabel1 := TLabel.Create(Self);
   with fInfoLabel1 do begin
     Name := 'InfoLabel1';
     Parent := FInfoPanel;
     Caption := '';
     SetBounds(6, 6, 157, 23);
     AutoSize := true;
   end;
   FInfoLabel2 := TLabel.Create(Self);
   with fInfoLabel2 do begin
     Name := 'InfoLabel2';
     Parent := FInfoPanel;
     Caption := '';
     SetBounds(6, 29, 157, 23);
     AutoSize := true;
   end;
   fAdvancedButton := TButton.Create(Self);
   with FAdvancedButton do begin
     Name := 'AdvancedButton';
     Parent := FInfoPanel;
     if fShowPlacesBar then
     		SetBounds(474, 0,75,23)
     else
     		SetBounds(333, 0,75,23);
     Enabled := true;
     visible:=false;
   end;
   fPreviewCheck := TCheckBox.Create(Self);
   with fPreviewCheck do begin
     Name := 'PreviewCheck';
     Parent := FInfoPanel;
     SetBounds(195, 24,130,23);
     Enabled := true;
     checked:=true;
     visible:=false;
     OnClick:=DoCheckPreview;
   end;
   //
   FPicturePanel := TPanel.Create(Self);
   with FPicturePanel do begin
     Name := 'PicturePanel';
     align:=alLeft;
     Caption := '';
     Ctl3D := True;
     SetBounds(204, 5, 169, 200);
     BevelOuter := bvNone;
     BorderWidth := 6;
     TabOrder := 1;
   end;
   FPicLabel1 := TLabel.Create(Self);
   with fPicLabel1 do begin
     Name := 'PicLabel1';
     Parent := FPicturePanel;
     Caption := '';
     SetBounds(6, 180, 157, 23);
     AutoSize := true;
   end;
   FPicLabel2 := TLabel.Create(Self);
   with fPicLabel2 do begin
     Name := 'PicLabel2';
     Parent := FPicturePanel;
     Caption := '';
     SetBounds(6, 203, 157, 23);
     AutoSize := true;
   end;
   FPicLabel3 := TLabel.Create(Self);
   with fPicLabel3 do begin
     Name := 'PicLabel3';
     Parent := FPicturePanel;
     Caption := '';
     SetBounds(6, 226, 157, 23);
     AutoSize := true;
   end;
   FZoomComboBox := TComboBox.Create(Self);
   with FZoomComboBox do begin
     Name := 'ZoomCombo';
     Parent := FPicturePanel;
     Style := csDropDownList;
     SetBounds(6, 5, 50, 21);
     Enabled := True;
     Hint := 'Zoom';
     ParentShowHint := False;
     ShowHint := True;
     OnChange := ZoomComboChange;
   end;
   FPreviewButton := TSpeedButton.Create(Self);
   with FPreviewButton do begin
     Name := 'PreviewButton';
     Parent := FPicturePanel;
     SetBounds(60, 5, 23, 22);
     Flat := True;
     Enabled := False;
     Glyph.LoadFromResourceName(HInstance, 'IDB_PREVIEW');
     OnClick := PreviewClick;
     ShowHint:=true;
   end;
   {$ifdef IEINCLUDEMULTIVIEW}
   fPlayButton := TSpeedButton.Create(Self);
   with FPlayButton do begin
     Name := 'PlayButton';
     Parent := FPicturePanel;
     SetBounds(85, 5, 23, 22);
     Flat := true;
     Enabled := false;
     groupindex:=1;
     allowallup:=true;
     Glyph.LoadFromResourceName(HInstance, 'IDB_PLAY');
     onclick:=playclick;
     visible:=true;
     ShowHint:=true;
   end;
   {$endif}
   FImageEnView := TImageEnView.Create(Self);
   with FImageEnView do begin
     Name := 'ImageEnView';
     SetBounds(6, 36, 133, 139);
     TabOrder := 0;
     Cursor := crDefault;
     Ctl3d:=true;
     OnDblClick := PreviewClick;
     MouseInteract := [miScroll];
     Background:=clWhite;
     BackgroundStyle:=iebsSolid;
     BorderStyle:=bsSingle;
     Center:=true;
     ZoomFilter:=rfFastLinear;
     DelayZoomFilter:=false;
     EnableAlphaChannel:=true;
   end;
   FImageEnIO := TImageEnIO.Create(Self);
   with FImageEnIO do begin
     OnProgress := ImageEnIOProgress;
     AttachedImageEn := FImageEnView;
   end;
   //
   {$ifdef IEINCLUDEMULTIVIEW}
   FImageEnMView := TImageEnMView.Create(Self);
   with FImageEnMView do begin
     Name := 'ImageEnMView';
     SetBounds(6, 36, 133, 139);
     TabOrder := 0;
     Cursor := crDefault;
     BorderStyle:=bsSingle;
     Ctl3d:=true;
     MouseInteract := [mmiScroll, mmiSelect];
     ScrollBars:=ssHorizontal;
     KeyInteract:=[mkiMoveSelected];
     ThumbHeight:=109;
     ThumbWidth:=100;
     OnImageSelect:=ImageSelect;
     Visible:=false;
     background:=clWhite;
   end;
   FImageEnMIO := TImageEnMIO.Create(Self);
   with FImageEnMIO do begin
     OnProgress := ImageEnIOProgress;
     AttachedMView := FImageEnMView;
   end;
   {$endif}
   fProgressBar:=TProgressBar.Create(Self);
   with fProgressBar do begin
     Name:='ProgressBar';
     SetBounds(0,55,127,19);
     min:=0;
     max:=100;
     Visible:=false;
   end;
   SetLang;
end;

///////////////////////////////////////////////////////////////////////////////
destructor TOpenImageEnDialog.Destroy;
begin
  FZoomComboBox.Free;
  FPreviewButton.Free;
  {$ifdef IEINCLUDEMULTIVIEW}
  fPlayButton.free;
  {$endif}
  fProgressBar.free;
  fPicLabel1.free;
  fPicLabel2.free;
  fPicLabel3.free;
  fInfolabel1.free;
  fInfoLabel2.free;
  fAdvancedButton.free;
  fPreviewCheck.free;
  FImageEnIO.Free;
  {$ifdef IEINCLUDEMULTIVIEW}
  fImageEnMIO.free;
  fImageEnMView.Free;
  {$endif}
  FImageEnView.Free;
  fInfoPanel.free;
  FPicturePanel.Free;
  //
  FFiles.Free;
  FHistoryList.Free;
  inherited Destroy;
end;

///////////////////////////////////////////////////////////////////////////////
function TOpenImageEnDialog.CanClose(var OpenFileName: TOpenFileName): Boolean;
begin
  GetFileNames(OpenFileName);
  Result := DoCanClose;
  FFiles.Clear;
end;

///////////////////////////////////////////////////////////////////////////////
function _ExtractFilter(sa:PAnsiChar; idx:integer):string;
begin
	while idx>1 do begin
   	inc(sa, strlen(sa)+1);
      inc(sa, strlen(sa)+1);
   	dec(idx);
   end;
   inc(sa, strlen(sa)+1);
   result:=sa;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.WndProc(var Message: TMessage);
var
  Index,q:Integer;
  ss:string;
begin
  Message.Result := 0;
  if (Message.Msg = WM_INITDIALOG) and not (ofOldStyleDialog in Options) then Exit
  else if (Message.Msg = WM_NOTIFY) then
    case (POFNotify(Message.LParam)^.hdr.code) of
      CDN_FILEOK:
      	begin
            if not CanClose(POFNotify(Message.LParam)^.lpOFN^) then
            begin
              Message.Result := 1;
              SetWindowLong(Handle, DWL_MSGRESULT, Message.Result);
              Exit;
            end;
         end;
      CDN_INITDONE: begin
        {$ifDef XE}assert(false);{$Else}
      	fSelType:=_ExtractFilter(POFNotify(Message.LParam)^.lpOFN^.lpstrFilter,FCurrentFilterIndex);
        {$EndIf}
      	DoShow;
      end;
      CDN_SELCHANGE: DoSelectionChange;
      CDN_FOLDERCHANGE: DoFolderChange;
      CDN_TYPECHANGE:
        begin
          Index := POFNotify(Message.LParam)^.lpOFN^.nFilterIndex;
          {$ifDef XE}assert(false);{$Else}
          fSelType:=_ExtractFilter(POFNotify(Message.LParam)^.lpOFN^.lpstrFilter,Index);
          {$EndIf}

          //ss:=ExtractFirstExt(fSelType);
          //ss:=copy(ss,2,length(ss));
          //strdispose(POFNotify(Message.LParam)^.lpOFN^.lpstrDefExt);
          //POFNotify(Message.LParam)^.lpOFN^.lpstrDefExt:=stralloc(length(ss));
          //strcopy(POFNotify(Message.LParam)^.lpOFN^.lpstrDefExt,PAnsiChar(ss));

	    	 ss:=fSelType;
	       Delete(ss, 1, 1);
	       q:=pos(';',ss);
	       Delete(ss,q,length(ss));
               {$ifDef XE}assert(false);{$Else}
			 POFNotify(Message.LParam)^.lpOFN^.lpstrDefExt := PAnsiChar(ss);
                         {$EndIf}

          if Index <> FCurrentFilterIndex then
          begin
            FCurrentFilterIndex := Index;
            DoTypeChange;
          end;
        end;
    end;
  inherited WndProc(Message);
end;

///////////////////////////////////////////////////////////////////////////////
function TOpenImageEnDialog.DoCanClose: Boolean;
begin
  Result := True;
  if Assigned(FOnCanClose) then FOnCanClose(Self, Result);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.DoFolderChange;
begin
  if Assigned(FOnFolderChange) then FOnFolderChange(Self);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.DoTypeChange;
begin
  if Assigned(FOnTypeChange) then FOnTypeChange(Self);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.ReadFileEditStyle(Reader: TReader);
begin
  Reader.ReadIdent;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('FileEditStyle', ReadFileEditStyle, nil, False);
end;

///////////////////////////////////////////////////////////////////////////////
function TOpenImageEnDialog.DoExecute(Func: Pointer): Bool;
const
   MultiSelectBufferSize=High(Word)-16;
   OpenOptions: array [TOpenOption] of DWORD=(
     OFN_READONLY, OFN_OVERWRITEPROMPT, OFN_HIDEREADONLY,
     OFN_NOCHANGEDIR, OFN_SHOWHELP, OFN_NOVALIDATE, OFN_ALLOWMULTISELECT,
     OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST,
     OFN_CREATEPROMPT, OFN_SHAREAWARE, OFN_NOREADONLYRETURN,
     OFN_NOTESTFILECREATE, OFN_NONETWORKBUTTON, OFN_NOLONGNAMES,
     OFN_EXPLORER, OFN_NODEREFERENCELINKS
     {$ifndef IEDELPHI3}
     {$ifndef IECPPBUILDER3}
     ,OFN_ENABLEINCLUDENOTIFY,OFN_ENABLESIZING
     {$endif}
     {$endif}
     {$ifdef IEDELPHI6}
     ,OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN
     {$endif}
     {$ifdef IEDELPHI7}
     ,OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN
     {$endif}
     {$ifdef XE}
     //,OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN
     {$endif}
     {$ifdef IECPPBUILDER6}
     ,OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN
     {$endif}
     );
var
   Option:TOpenOption;
   OpenFilename:TOpenFilename;
   //
   function AllocFilterStr(const S:string):string;
   var
   	P:PAnsiChar;
   begin
      Result:='';
      if S<>'' then begin
         Result:=S+#0;
         P:=AnsiStrScan(PAnsiChar(Result),'|');
         while P<>nil do begin
            P^:=#0;
            Inc(P);
            P:=AnsiStrScan(P,'|');
         end;
      end;
   end;
	//
var
   TempFilter,TempFilename,TempExt: string;
   q:integer;
   OpenFileNameEx:TIEOpenFileNameEx;
begin
	{$ifdef IEINCLUDEMULTIVIEW}
  	fPlayButton.visible:=not fAlwaysAnimate;
   {$endif}
   FFiles.Clear;
   FillChar(OpenFileName,SizeOf(OpenFileName),0);
   with OpenFilename do begin
      {$ifdef IEFIXOSDIALOGS}
      if (Win32MajorVersion>=5) and (Win32Platform=VER_PLATFORM_WIN32_NT) or { Win2k } ((Win32Platform=VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion>=4) and (Win32MinorVersion>=90)) then { WinME }
      	lStructSize:=SizeOf(TOpenFilename)
      else
      	lStructSize:=SizeOf(TOpenFilename)-(SizeOf(DWORD) shl 1)-SizeOf(Pointer); { subtract size of added fields }
      {$else}
      lStructSize:=SizeOf(TOpenFilename);
      {$endif}
      hInstance:=SysInit.HInstance;
      TempFilter:=AllocFilterStr(FFilter);
      {$ifDef XE}assert(false);{$Else}
      lpstrFilter:=PAnsiChar(TempFilter);
      {$EndIf}
      nFilterIndex:=FFilterIndex;
      FCurrentFilterIndex:=FFilterIndex;
      if ofAllowMultiSelect in FOptions then
      	nMaxFile:=MultiSelectBufferSize
      else
      	nMaxFile:=MAX_PATH;
      SetLength(TempFilename,nMaxFile+2);
      {$ifDef XE}assert(false);{$Else}
      lpstrFile:=PAnsiChar(TempFilename);
      {$EndIf}
      FillChar(lpstrFile^,nMaxFile+2,0);
      {$ifDef XE}assert(false);{$Else}
      StrLCopy(lpstrFile,PAnsiChar(FFileName),nMaxFile);
      lpstrInitialDir:=PAnsiChar(FInitialDir);
      lpstrTitle:=PAnsiChar(FTitle);
      {$EndIf}
      Flags:=OFN_ENABLEHOOK;
      for Option:=Low(Option) to High(Option) do
      	if Option in FOptions then
         	Flags:=Flags or OpenOptions[Option] {$ifdef IEDELPHI3}or $00800000{$endif};
      if NewStyleControls then
      	Flags:=Flags xor OFN_EXPLORER
      else
      	Flags:=Flags and not OFN_EXPLORER;
      TempExt:=FDefaultExt;
      if (TempExt='') and (Flags and OFN_EXPLORER=0) then begin
      	TempExt:=ExtractFileExt(FFilename);
      	Delete(TempExt,1,1);
      end;
      if TempExt<>'' then
        {$ifDef XE}assert(false){$Else}
      	lpstrDefExt:=PAnsiChar(TempExt)
        {$EndIf}
      else begin
         {$ifDef XE}assert(false);{$Else}
         TempExt:=_ExtractFilter(lpstrFilter,FCurrentFilterIndex);
         {$EndIf}
         Delete(TempExt,1,1);
         q:=pos(';',TempExt);
         Delete(TempExt,q,length(TempExt));
         {$ifDef XE}assert(false);{$Else}
         lpstrDefExt:=PAnsiChar(TempExt)
         {$EndIf}
      end;
      {$IfDef XE}
      assert(false);
      {$Else}
      if (ofOldStyleDialog in Options) or not NewStyleControls then
      	lpfnHook:=DialogHook
      else
      	lpfnHook:=ExplorerHook;
      {$EndIf}
      if Template<>nil then begin
         Flags:=Flags or OFN_ENABLETEMPLATE;
         {$ifDef XE}assert(false);{$Else}
         lpTemplateName:=Template;
         {$EndIf}
      end;
      {$ifndef OCXVERSION}
      if assigned(Application) then
	      hWndOwner:=Application.Handle
      else
         hWndOwner:=IEFindHandle(Owner); //hWndOwner:=TCustomControl(Owner).handle;
      {$else}
      hWndOwner:=IEFindHandle(Owner);
      {$endif}
      if IEIs_Win2000_ME_XP then begin
			Move(OpenFileName, OpenFileNameEx, sizeof(OpenFileName));
         if fShowPlacesBar then
   			OpenFileNameEx.FlagsEx := 0
         else
            OpenFileNameEx.FlagsEx := 1;
         OpenFileNameEx.lStructSize := sizeof(TIEOpenFileNameEx);
			Result:=TaskModalDialog(Func, OpenFileNameEx);
         Move(OpenFileNameEx, OpenFileName, SizeOf(OpenFileName));
      end else
	      Result:=TaskModalDialog(Func, OpenFileName);
      if Result then begin
         GetFileNames(OpenFilename);
         if (Flags and OFN_EXTENSIONDIFFERENT)<>0 then
         	Include(FOptions,ofExtensionDifferent)
         else
         	Exclude(FOptions,ofExtensionDifferent);
         if (Flags and OFN_READONLY)<>0 then
         	Include(FOptions,ofReadOnly)
         else
         	Exclude(FOptions,ofReadOnly);
         FFilterIndex:=nFilterIndex;
      end;
   end;
end;

(*
///////////////////////////////////////////////////////////////////////////////
// add extension to fn
function TOpenImageEnDialog.AdjustFileName(fn:string):string;
var
	q:integer;
   f:string;
begin
   f:=extractfilename(fn);
   result:=f;
   q:=pos('.',result);
   if q>0 then
      result:=copy(result,1,q-1);
   result:=result+ExtractFirstExt(fSelType);
   result:=copy(fn,1,length(fn)-length(f))+result;
end;
*)

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.GetFileNames(var OpenFileName: TOpenFileName);
var
  Separator: AnsiChar;
	//
  function ExtractFileName(P: PAnsiChar; var S: TFilename): PAnsiChar;
  begin
    Result := AnsiStrScan(P, Separator);
    if Result = nil then
    begin
      S := P;
      Result := StrEnd(P);
    end
    else
    begin
      SetString(S, P, Result - P);
      Inc(Result);
    end;
  end;
	//
  procedure ExtractFileNames(P: PAnsiChar);
  var
    DirName, FileName: TFilename;
  begin
    P := ExtractFileName(P, DirName);
    P := ExtractFileName(P, FileName);
    if FileName = '' then
      FFiles.Add(DirName)
    else
    begin
      if AnsiLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
          (FileName[2] <> ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        FFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;
	//
begin
  Separator := #0;
  if (ofAllowMultiSelect in FOptions) and
    ((ofOldStyleDialog in FOptions) or not NewStyleControls) then
    Separator := ' ';
  with OpenFileName do
  begin
    if ofAllowMultiSelect in FOptions then
    begin
      {$ifDef XE}assert(false);{$Else}
      ExtractFileNames(lpstrFile);
      {$EndIf}
      FFileName := FFiles[0];
    end else
    begin
      {$ifDef XE}assert(false);{$Else}
      ExtractFileName(lpstrFile, FFileName);
      {$EndIf}
      FFiles.Add(FFileName);
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
function TOpenImageEnDialog.GetStaticRect: TRect;
begin
  if FHandle <> 0 then
  begin
    if not (ofOldStyleDialog in Options) then
    begin
      GetWindowRect(GetDlgItem(FHandle, stc32), Result);
      MapWindowPoints(0, FHandle, Result, 2);
    end
    else GetClientRect(FHandle, Result)
  end
  else Result := Rect(0,0,0,0);
end;

///////////////////////////////////////////////////////////////////////////////
function TOpenImageEnDialog.GetFileName: TFileName;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if NewStyleControls and (FHandle <> 0) then
  begin
    SendMessage(GetParent(FHandle), CDM_GETFILEPATH, SizeOf(Path), Integer(@Path));
    Result := StrPas(Path);
  end
  else Result := FFileName;
end;

///////////////////////////////////////////////////////////////////////////////
// only file name
function TOpenImageEnDialog.GetFileName2: TFileName;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if NewStyleControls and (FHandle <> 0) then
  begin
    SendMessage(GetParent(FHandle), CDM_GETSPEC, SizeOf(Path), Integer(@Path));
    Result := StrPas(Path);
  end
  else Result := FFileName;
end;

///////////////////////////////////////////////////////////////////////////////
function TOpenImageEnDialog.GetFilterIndex: Integer;
begin
  if FHandle <> 0 then
    Result := FCurrentFilterIndex
  else
    Result := FFilterIndex;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.SetHistoryList(Value: TStrings);
begin
  FHistoryList.Assign(Value);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.SetInitialDir(const Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  if (L > 1) and IsPathDelimiter(Value, L)
    and not IsDelimiter(':', Value, L - 1) then Dec(L);
  FInitialDir := Copy(Value, 1, L);
end;

///////////////////////////////////////////////////////////////////////////////
function TOpenImageEnDialog.Execute: Boolean;
begin
  Template := 'IDD_IETEMPLATE';
  SetLang;
  fPreviewCheck.visible:=true;
  if fAutoSetFilter then
     Filter:=BuildStrFilter;
  Result := DoExecute(@GetOpenFileName);
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.DoSelectionChange;
var
  FullName,ss: string;
  ValidPicture: Boolean;
  CursorBak: TCursor;

  function ValidFile(const FileName: AnsiString): Boolean;
  begin
    Result := GetFileAttributesA(PAnsiChar(FileName)) <> $FFFFFFFF;
  end;

begin
  if m_blnInSelectionChange then
    Exit;
  if (not fShowPreview) then begin
    if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
  	 exit;
  end;
  m_blnInSelectionChange := True;
  try
    FullName := FileName;
    ValidPicture := FileExists(FullName) and ValidFile(FullName);
    if ValidPicture then
    try
	   fFileSize:=_getfilesize(filename);	// fFileSize is assignable only here (!?)
      if not fPreviewCheck.Checked then begin
	      fImageEnIO.ParamsFromFile(FullName);
         fFrames:=1;
         if fImageEnIO.Params.FileType<>ioUnknown then
	         ShowIOParams(fImageEnIO.Params)
         else
         	ShowIOParams(nil);
		end else begin
         CursorBak:=Screen.Cursor;
         try
           Screen.Cursor := crHourGlass;
           fImageEnView.Background:=clWhite;
           fImageEnView.blank;
           fImageEnView.Paint;
           {$ifdef IEINCLUDEMULTIVIEW}
           fImageEnMView.background:=clwhite;
           fImageEnMView.Clear;
           fImageEnMView.Paint;
           fPlayButton.down:=false;
           {$endif}
           ss:=lowercase(extractfileext(FullName));
           {$ifdef IEINCLUDEMULTIVIEW}
           if ((ss='.avi') or
              ( (ss='.gif') and (@IEFileFormatGetInfo(ioGIF)^.ReadFunction<>nil) and (EnumGifIm(FullName)>1) ) or
              ( (ss='.tif') and (EnumTIFFIm(FullName)>1) ))
              and fShowAllFrames then begin
              // animated images
              fPlayButton.enabled:=true;
              FZoomComboBox.enabled:=false;
              fImageEnMView.show;
              fImageEnView.hide;
              with fProgressBar do begin
                 Parent:=fImageEnMView;
                 position:=0;
                 show;
                 repaint;
              end;
              fImageEnMIO.AutoAdjustDPI:=fAutoAdjustDPI;
              fImageEnMIO.FilteredAdjustDPI:=fFilteredAdjustDPI;
              fImageEnMIO.LoadFromFile(FullName);
              fFrames:=fImageEnMIO.ParamsCount;
              fImageEnMView.SelectSeek(iskFirst);
              if fAlwaysAnimate and ((ss='.avi') or ((ss='.gif') and (@IEFileFormatGetInfo(ioGIF)^.ReadFunction<>nil))) then begin
                 fPlayButton.down:=True;
	              PlayClick(self);
              end;
           end else begin
           		// static images
              fPlayButton.enabled:=false;
           {$endif}
              FZoomComboBox.enabled:=true;
              fImageEnView.Show;
              {$ifdef IEINCLUDEMULTIVIEW}
              fImageEnMView.hide;
              {$endif}
              with fProgressBar do begin
                 Parent:=fImageEnView;
                 position:=0;
                 show;
                 repaint;
              end;
              fImageEnIO.Params.Width:=FImageEnView.Width;
              fImageEnIO.Params.Height:=fImageEnView.Height;
              fImageEnIO.Params.JPEG_Scale:=ioJPEG_AUTOCALC;
              fImageEnIO.AutoAdjustDPI:=fAutoAdjustDPI;
              fImageEnIO.FilteredAdjustDPI:=fFilteredAdjustDPI;
              FImageEnIO.LoadFromFile(FullName);
              if fImageEnIO.Params.FileType=ioAVI then
              	fFrames:=fImageEnIO.Params.AVI_FrameCount
              else if fImageEnIO.Params.FileType=ioGIF then
              	fFrames:=EnumGIFIm(FullName)
              else if fImageEnIO.Params.FileType=ioTIFF then
              	fFrames:=EnumTIFFIm(FullName)
              else if fImageEnIO.Params.FileType=ioICO then
               fFrames:=EnumICOIm(FullName)
              else
              	fFrames:=1;
              ShowIOParams(fImageEnIO.Params);
           {$ifdef IEINCLUDEMULTIVIEW}
           end;
           {$endif}
           fProgressBar.hide;
           SetZoom;
         finally
           Screen.Cursor := CursorBak;
         end;
         FPreviewButton.Enabled := True;
         fZoomComboBox.Enabled:=true;
      end; 	// if fPreviewCheck
    except
      ValidPicture := False;
    end;
    if not ValidPicture then begin
      FInfoLabel1.Caption := '';
      fInfoLabel2.Caption := '';
      FPreviewButton.Enabled := False;
      fZoomComboBox.Enabled:=false;
      FImageEnView.blank;
      FPicLabel1.Caption:='';
      FPicLabel2.Caption:='';
      FPicLabel3.Caption:='';
      {$ifdef IEINCLUDEMULTIVIEW}
      fImageEnMView.Clear;
      fPlayButton.Enabled:=false;
      {$endif}
    end;
    if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
  finally
    m_blnInSelectionChange := False;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.PreviewClick(Sender: TObject);
var
  PreviewForm: TForm;
begin
  PreviewForm := TForm.Create(Self);
  with PreviewForm do
  try
    Name := 'PreviewForm';
    Caption := SPreviewLabel + ': ' + Self.FileName;
    BorderStyle := bsSizeToolWin;
    KeyPreview := True;
    Position := poScreenCenter;
    OnKeyPress := PreviewKeyPress;
    with TImageEnView.Create(PreviewForm) do begin
      Name := 'ImageEnView';
      Parent := PreviewForm;
      Align := alClient;
      Cursor := crDefault;
      MouseInteract := [miScroll, miZoom];
      if fImageEnView.visible then
	      Assign(FImageEnView)
      {$ifdef IEINCLUDEMULTIVIEW}
      else if fImageEnMView.visible then
      	Assign(fImageEnMView.Bitmap);
      {$else} ; {$endif}
      Background := clWhite;
      backgroundstyle:=iebsSolid;
      Center := True;
      ScrollBars:=ssBoth;
      if (Bitmap.Width > 100) then begin
        if (Bitmap.Width < Screen.Width) then
          PreviewForm.ClientWidth := Bitmap.Width
        else
          PreviewForm.Width := Screen.Width;
      end else
        PreviewForm.Width := 100;
      if (Bitmap.Height > 100) then begin
        if (Bitmap.Height < Screen.Height) then
          PreviewForm.ClientHeight := Bitmap.Height
        else
          PreviewForm.Height := Screen.Height;
      end else
        PreviewForm.Height := 100;
    end;
    ShowModal;
  finally
    Free;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.PlayClick(Sender: TObject);
begin
	{$ifdef IEINCLUDEMULTIVIEW}
	fImageEnMView.Playing:=fPlayButton.down;
   fPreviewButton.Enabled:=not fPlayButton.down;
   fZoomComboBox.Enabled:=not fPlayButton.down;
   {$endif}
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.PreviewKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  	 TForm(Sender).Close;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.ZoomComboChange(Sender: TObject);
begin
  SetZoom;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.ImageEnIOProgress(Sender: TObject;
  per: integer);
begin
  fProgressBar.position:=per;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.ImageSelect(Sender:TObject; idx:integer);
begin
	{$ifdef IEINCLUDEMULTIVIEW}
	ShowIOParams(fImageEnMIO.Params[idx]);
   {$endif}
end;

///////////////////////////////////////////////////////////////////////////////
// if params=nil then empties fields
procedure TOpenImageEnDialog.ShowIOParams(params:TIOParamsVals);
var
	ss:string;
   mdim,bitcount,ww,hh:integer;
begin
	if assigned(Params) then begin
      with Params do begin
      	if params.FileType=ioJPEG then begin
         	ww:=JPEG_OriginalWidth;
            hh:=JPEG_OriginalHeight;
         end else begin
         	ww:=Width;
            hh:=Height;
         end;
         // Width X Height Pixel (frames)
         ss := IntToStr(ww)+' x '+IntToStr(hh)+' pixel';
         if fFrames>1 then
            ss:=ss+' , '+inttostr(fFrames)+' frames';
         fPicLabel1.caption:=ss;
         // dpi
         ss:=inttostr(DpiX)+' x '+inttostr(DpiY)+' dpi';
         fPicLabel3.caption:=ss;
         // xxx colors
         if (SamplesPerPixel=4) and (BitsPerSample=8) then
         	ss:='16777216'
         else if (SamplesPerPixel=3) and (BitsPerSample=16) then
         	ss:='2^48'
         else
	         ss:=IntToStr(1 shl (SamplesPerPixel * BitsPerSample));
         ss:=ss+' '+iemsg(IEMSG_COLORS,fMsgLanguage)+' (';
         ss:=ss+IntToStr(SamplesPerPixel*BitsPerSample)+' bit)';
         fPicLabel2.caption:=ss;
         // file size
         if fFileSize<1024 then
         	ss:=iemsg(IEMSG_FILE,fMsglanguage)+': '+inttostr(fFileSize)+' bytes'
         else
	         ss:=iemsg(IEMSG_FILE,fMsglanguage)+': '+inttostr(fFileSize div 1024)+' Kb';
         // memory size
         // solo pf1bit e pf24bit sono attualmente supportati
         if (SamplesPerPixel=1) and (BitsPerSample=1) then
            bitcount:=1
         else
            bitcount:=24;
         mdim:=(((ww*BitCount)+31) div 32)*4*hh*fFrames;
         if mdim<1024 then
         	ss:=ss+'   '+iemsg(IEMSG_MEM,fMsglanguage)+': '+inttostr(mdim)+' bytes'
         else
	         ss:=ss+'   '+iemsg(IEMSG_MEM,fMsglanguage)+': '+inttostr(mdim div 1024)+' Kb';
         //
         fInfoLabel2.Caption:=ss;
         // compression
         ss:=FileTypeStr;
         fInfoLabel1.Caption:=ss;
      end;
   end else begin
      fPicLabel1.caption:='';
      fPicLabel3.caption:='';
      fPicLabel2.caption:='';
      fInfoLabel2.Caption:='';
      fInfoLabel1.Caption:='';
   end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.SetZoom;
var
  intItemIndex: integer;
begin
  if not Assigned(FZoomComboBox) then
    Exit;
  if not Assigned(FImageEnView) then
    Exit;
  intItemIndex := FZoomComboBox.ItemIndex;
  if (intItemIndex < 0) then
    Exit;
  if Assigned(FZoomComboBox.Items.Objects[intItemIndex]) then
    FImageEnView.Zoom := Integer(FZoomComboBox.Items.Objects[intItemIndex])
  else
    fImageEnView.Fit;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.DoShow;
var
  ClientRect, PreviewRect, StaticRect: TRect;
begin
   GetClientRect(handle, ClientRect);
   StaticRect := GetStaticRect;
   if fShowPreview then begin
      // PicturePanel
      PreviewRect:=ClientRect;
      PreviewRect.Left := StaticRect.Left + (StaticRect.Right - StaticRect.Left);
      PreviewRect.top:=StaticRect.Top;
      PreviewRect.Bottom:=staticrect.bottom;
      FPicturePanel.BoundsRect := PreviewRect;
      FPicturePanel.ParentWindow := handle;
      {$ifdef IEINCLUDEMULTIVIEW}
      fImageEnMView.ParentWindow:=fpicturepanel.handle;
      {$endif}
      fImageEnView.ParentWindow:=fPicturepanel.handle;
      with FZoomComboBox, Items do begin
        AddObject('Fit', nil);
        AddObject('25%', TObject(25));
        AddObject('50%', TObject(50));
        AddObject('75%', TObject(75));
        AddObject('100%', TObject(100));
        AddObject('125%', TObject(125));
        AddObject('150%', TObject(150));
        AddObject('175%', TObject(175));
        AddObject('200%', TObject(200));
        AddObject('300%', TObject(300));
        AddObject('400%', TObject(400));
        ItemIndex := 0;
      end;
      FImageEnView.Background := clWhite;
      FImageEnView.Center := True;
      {$ifdef IEINCLUDEMULTIVIEW}
      fPlayButton.down:=false;
      fImageEnMView.Playing:=false;
      fPlayButton.enabled:=false;
      {$endif}
   end;
   // Info panel
   if fExtendedDialog then begin
      fInfoPanel.top:=StaticRect.bottom;
      fInfoPanel.left:=StaticRect.left;
      fInfoPanel.width:=clientrect.Right;
      fInfoPanel.Height:=ClientRect.bottom;
      fInfoPanel.ParentWindow:=handle;
   end else begin
   	FPicLabel1.visible:=false;
      FPicLabel2.visible:=false;
		FPicLabel3.visible:=false;
      FZoomComboBox.visible:=false;
   end;
   inherited DoShow;
end;

///////////////////////////////////////////////////////////////////////////////
function TSaveImageEnDialog.Execute: Boolean;
begin
   fShowPreview:=sdShowPreview in fExOptions;
   if fShowPreview then
      Template := 'IDD_IETEMPLATE'
   else
      Template := 'IDD_IETEMPLATE1';
   if fAutoSetFilter then
      Filter:=BuildStrFilter;
   fAdvancedButton.OnClick:=DoAdvanced;
   {$ifdef IEINCLUDEDIALOGIO}
   fAdvancedButton.visible:=sdShowAdvanced in fExOptions;
   {$endif}
   SetLang;
   if fShowPlacesBar then
   	fAdvancedButton.SetBounds(474, 0,75,23)
   else
      fAdvancedButton.SetBounds(333, 0,75,23);
   fPreviewCheck.visible:=sdShowPreview in fExOptions;
   // save Params in fBackParams
   if fAttachedImageEnIO is TImageEnIO then
      fBackParams.Assign( (fAttachedImageEnIO as TImageEnIO).Params )
   {$ifdef IEINCLUDEMULTIVIEW}
   else if fAttachedImageEnIO is TImageEnMIO then
      with fAttachedImageEnIO as TImageEnMIO do begin
      	if ParamsCount>0 then
         	fBackParams.Assign( Params[0] )
         else begin
         	result:=false;
            exit;
         end;
   	end
   else if fAttachedImageEnIO is TImageEnMView then
      with (fAttachedImageEnIO as TImageEnMView).MIO do begin
      	if ParamsCount>0 then
         	fBackParams.Assign( Params[0] )
         else begin
         	result:=false;
            exit;
         end;
   	end
   {$endif}
   else if fAttachedImageEnIO is TImageEnView then
      fBackparams.Assign( (fAttachedImageEnIO as TImageEnView).IO.Params );
   //
   Result := DoExecute(@GetSaveFileName);
   if result=false then begin
      // restore Params
      if fAttachedImageEnIO is TImageEnIO then
         (fAttachedImageEnIO as TIMageEnIO).Params.Assign( fBackParams )
      {$ifdef IEINCLUDEMULTIVIEW}
      else if fAttachedImageEnIO is TImageEnMIO then
         (fAttachedImageEnIO as TImageEnMIO).Params[0].Assign( fBackParams )
      else if fAttachedImageEnIO is TImageEnMView then
         (fAttachedImageEnIO as TImageEnMView).MIO.Params[0].Assign( fBackParams )
      {$endif}
      else if fAttachedImageEnIO is TImageEnView then
         (fAttachedImageEnIO as TImageEnView).IO.Params.Assign( fBackParams );
   end;
   // add the extension to the file name (if there isn't)
   if extractfileext(FileName)='' then
   	FileName:=FileName+ExtractFirstExt(fSelType);
end;

///////////////////////////////////////////////////////////////////////////////
constructor TSaveImageEnDialog.Create(AOwner: TComponent);
var
   strFilter: String;
   fi:PIEFileFormatInfo;
begin
	inherited;
   fShowPreview:=true;
   strFilter := 'JPEG Bitmap (JPG)|*.jpg';
   fi:=IEFileFormatGetInfo(ioGIF);
   if assigned(fi) and (@fi^.WriteFunction<>nil) then
	   strFilter := strFilter + '|CompuServe Bitmap (GIF)|*.gif';
   strFilter := strFilter + '|TIFF Bitmap (TIF)|*.tif';
   strFilter := strFilter + '|PaintBrush (PCX)|*.pcx';
   strFilter := strFilter + '|Portable Network Graphics (PNG)|*.png';
   strFilter := strFilter + '|Windows Bitmap (BMP)|*.bmp';
   strFilter := strFilter + '|OS/2 Bitmap (BMP)|*.bmp';
   strFilter := strFilter + '|Targa Bitmap (TGA)|*.tga';
   strFilter := strFilter + '|Portable PixMap (PXM)|*.pxm';
   strFilter := strFilter + '|Portable PixMap (PPM)|*.ppm';
   strFilter := strFilter + '|Portable GreyMap (PGM)|*.pgm';
   strFilter := strFilter + '|Portable Bitmap (PBM)|*.pbm';
   strFilter := strFilter + '|JPEG2000 (JP2)|*.jp2';
   strFilter := strFilter + '|JPEG2000 Code Stream (J2K)|*.j2k';
   Filter := strFilter;
	//
   fExOptions:=[sdShowPreview,sdShowAdvanced];
   fAttachedImageEnIO:=nil;
   fBackParams:=TIOParamsVals.Create(nil);
end;

destructor TSaveImageEnDialog.Destroy;
begin
	fBackParams.free;
   inherited;
end;

procedure TSaveImageEnDialog.SetAttachedImageEnIO(v:TComponent);
begin
	if assigned(v) and ((v is TImageEnIO) {$ifdef IEINCLUDEMULTIVIEW}or (v is TImageEnMIO) or (v is TImageEnMView){$endif} or (v is TImageEnView)  )
   then begin
   	fAttachedImageEnIO:=v;
      fAttachedImageEnIO.FreeNotification(self);
      if v is TImageEnIO then
      	fMsgLanguage:=(v as TImageEnIO).MsgLanguage;
      {$ifdef IEINCLUDEMULTIVIEW}
      if v is TImageEnMIO then
      	fMsgLanguage:=(v as TImageEnMIO).MsgLanguage;
      {$endif}
   end;
end;

procedure TSaveImageEnDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
	inherited Notification(AComponent, Operation);
	if (AComponent=fAttachedImageEnIO) and (Operation=opRemove) then begin
   	fAttachedImageEnIO:=nil;
   end;
end;

procedure TSaveImageEnDialog.DoAdvanced(Sender: TObject);
{$ifdef IEINCLUDEDIALOGIO}
   function ConvertExt(e:string; var ft:TIOFileType):TPreviewParams;
   var
   	fi:PIEFileFormatInfo;
	begin
      e:=lowercase(e);
      if (Length(e)>0) and (e[1]='.') then
      	Delete(e,1,1);
      fi:=IEFileFormatGetInfo2(e);
      if fi<>nil then
      	result:=fi^.DialogPage
      else
      	result:=[];
      (*
      result:=[];
      if (e='jpg') or (e='jpeg') or (e='jpe') then
         result:=[ppJPEG]
      {$ifdef IEINCLUDEJPEG2000}
      else if (e='jp2') or (e='j2k') or (e='jpc') or (e='j2c') then
         result:=[ppJ2000]
      {$endif}
      else if (e='tif') or (e='tiff') or (e='fax') or (e='g3f') or (e='g3n') then
         result:=[ppTIFF]
      else if (e='gif') and (@IEFileFormatGetInfo(ioGIF)^.WriteFunction<>nil) then
         result:=[ppGIF]
      else if (e='bmp') or (e='dib') or (e='rle') then
         result:=[ppBMP]
      else if (e='pcx') then
         result:=[ppPCX]
      else if (e='png') then
         result:=[ppPNG]
      else if (e='tga') or (e='targa') or (e='vda') or (e='icb') or (e='vst') or (e='win') then
         result:=[ppTGA]
      *)

   end;
var
	e:string;
 	pp:TPreviewParams;
   ft:TIOFileType;
begin
	e:=ExtractFileExt(filename);
   if e<>'' then
   	pp:=ConvertExt(e,ft)
   else
   	pp:=ConvertExt(DefaultExt,ft);
   if pp=[] then
   	pp:=ConvertExt(ExtractFileExt(fSelType),ft);
   if pp<>[] then begin
      if fAttachedImageEnIO is TImageEnIO then begin
      	(fAttachedImageEnIO as TImageEnIO).Params.FileType:=ft;
         (fAttachedImageEnIO as TImageEnIO).DoPreviews(pp);
      end
      {$ifdef IEINCLUDEMULTIVIEW}
      else if fAttachedImageEnIO is TImageEnMIO then
         (fAttachedImageEnIO as TImageEnMIO).DoPreviews(-1,pp)
      else if fAttachedImageEnIO is TImageEnMView then
         (fAttachedImageEnIO as TImageEnMView).MIO.DoPreviews(-1,pp)
      {$endif}
      else if fAttachedImageEnIO is TImageEnView then begin
      	(fAttachedImageEnIO as TImageEnView).IO.Params.FileType:=ft;
         (fAttachedImageEnIO as TImageEnView).IO.DoPreviews(pp);
      end;
   end;
end;
{$else}  // {$ifdef IEINCLUDEDIALOGIO}
begin
end;
{$endif}

///////////////////////////////////////////////////////////////////////////////
procedure TSaveImageEnDialog.SetFileNameExt;
var
	q:integer;
   s:string;
begin
   s:=extractfilename(GetFileName2);
   q:=pos('.',s);
   if q>0 then
      s:=copy(s,1,q-1);
   s:=s+ExtractFirstExt(fSelType);
   SendMessage(GetParent(FHandle), CDM_SETCONTROLTEXT, edt1,longint(PAnsiChar(s)));
end;

///////////////////////////////////////////////////////////////////////////////
procedure TSaveImageEnDialog.DoTypeChange;
begin
   SetFileNameExt;
   inherited;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.DoCheckPreview(Sender: TObject);
begin
	if fPreviewCheck.Checked then begin
   	// reload image
      DoSelectionChange;
   end else begin
   	// empty fields
      ShowIOParams(nil);
      fImageEnView.blank;
      fImageEnView.background:=clWhite;
      fImageEnView.Zoom:=100;
      {$ifdef IEINCLUDEMULTIVIEW}
      fImageEnMView.Clear;
      fImageEnMView.background:=clWhite;
      {$endif}
      FPreviewButton.Enabled := False;
      fZoomComboBox.Enabled:=false;
   end;
end;

///////////////////////////////////////////////////////////////////////////////
procedure TOpenImageEnDialog.SetPreviewBorderStyle(v:TIEDBorderStyle);
begin
	fPreviewBorderStyle:=v;
   with FImageEnView do
      case fPreviewBorderStyle of
         iepsDefault:
            begin
               BackgroundStyle:=iebsSolid;
               BorderStyle:=bsSingle;
            end;
         iepsCropped:
            begin
               BackgroundStyle:=iebsCropped;
               BorderStyle:=bsNone;
            end;
         iepsCropShadow:
            begin
               BackgroundStyle:=iebsCropShadow;
               BorderStyle:=bsNone;
            end;
      end;
end;

procedure TOpenImageEnDialog.SetZoomFilter(v:TResampleFilter);
begin
	FImageEnView.ZoomFilter:=v;
end;

function TOpenImageEnDialog.GetZoomFilter:TResampleFilter;
begin
	result:=FImageEnView.ZoomFilter;
end;



{$else} // {$ifdef IEINCLUDEOPENSAVEDIALOGS}

interface
implementation

{$endif}


end.
