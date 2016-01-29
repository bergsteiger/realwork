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

unit imscan;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDETWAIN}

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ImageEnIO, ietwain, hyiedefs, hyieutils;

type
TIETWCloseCallBack = procedure of object;

function IETW_SelectImageSource(var SelectedSourceName:AnsiString; TWainShared:PIETWainShared; callwnd:HWND):boolean;
function IETW_Acquire(Bitmap:TIEBitmap; multi:boolean; MultiCallBack:TIEMultiCallBack; Params:TIETWainParams; IOParams:TIOParamsVals; var Progress:TProgressRec; TWainShared:PIETWainShared; callwnd:HWND):boolean;
procedure IETW_GetSourceList(SList:TList; TWainShared:PIETWainShared; callwnd:HWND);
function IETW_GetCapabilities(Params:TIETWainParams; var Capabilities:TIETWSourceCaps; setcap:boolean; TWainShared:PIETWainShared; callwnd:HWND):boolean;
function IETW_GetDefaultSource(TWainShared:PIETWainShared; callwnd:HWND):AnsiString;
procedure IETW_FreeResources(TWainShared:PIETWainShared; callwnd:HWND);

// new implementation
function IETWAINAcquireOpen(CloseCallBack:TIETWCloseCallBack; MultiCallBack:TIEMultiCallBack; Params:TIETWainParams; TWainShared:PIETWainShared; IOParams:TIOParamsVals; parent:TWinControl):pointer;
procedure IETWAINAcquireClose(var grec:pointer);


implementation

uses ImageEnProc, forms;

{$R-}

type

   ErrorDetail=(
	ED_NONE,
	ED_START_TRIPLET_ERRS,
	ED_CAP_GET,				// MSG_GET triplet on a capability failed
	ED_CAP_SET,				// MSG_SET triplet on capability failed
	ED_DSM_FAILURE,			// TWAIN DSM returned TWRC_FAILURE
	ED_DS_FAILURE,			// source returned TWRC_FAILURE
	ED_END_TRIPLET_ERRS,
	ED_NOT_STATE_4,			// operation invoked in wrong state
	ED_NULL_HCON,			// MSG_GET returned a null container handle
	ED_BAD_HCON,			// MSG_GET returned an invalid/unlockable container handle
	ED_BAD_CONTYPE,			// returned container ConType is not valid.
	ED_BAD_ITEMTYPE,		// returned container ItemType is not valid.
	ED_CAP_GET_EMPTY,		// returned container has 0 items.
	ED_CAP_SET_EMPTY		// trying to restrict a cap to empty set
   );

	TIEDPI=record
   	xdpi:integer;
      ydpi:integer;
   end;
   PIEDPI=^TIEDPI;

const
	DSM_FILENAME='TWAIN_32.DLL';
   DSM_ENTRYPOINT='DSM_Entry';

	TWAIN_PRESESSION=			1;	// source manager not loaded
	TWAIN_SM_LOADED=			2;	// source manager loaded
	TWAIN_SM_OPEN=				3;	// source manager open
	TWAIN_SOURCE_OPEN=		4;	// source open but not enabled
	TWAIN_SOURCE_ENABLED=	5;	// source enabled to acquire
	TWAIN_TRANSFER_READY=	6;	// image ready to transfer
	TWAIN_TRANSFERRING=		7;	// image in transit

   TWAIN_BW=		$0001;	// 1-bit per pixel, B&W 	(== TWPT_BW)
   TWAIN_GRAY=		$0002;	// 1,4, or 8-bit grayscale  (== TWPT_GRAY)
   TWAIN_RGB=		$0004;	// 24-bit RGB color         (== TWPT_RGB)
   TWAIN_PALETTE=	$0008;	// 1,4, or 8-bit palette    (== TWPT_PALETTE)
   TWAIN_ANYTYPE=	$0000;	// any of the above

type

tgrec=record
	nState:integer;			// TWAIN state (per the standard)
   hDSMLib:THANDLE;			   // handle of DSM
	DSM_Entry:TDSMEntryProc;	// entry point of Data Source Manager (TWAIN.DLL)
   hwnd32SM:TW_INT32;
	rc:TW_INT16;					// result code
	AppId:TW_IDENTITY;
	SourceId:TW_IDENTITY;			// source identity structure
	twUI:TW_USERINTERFACE;
   nErrDetail:ErrorDetail;			// detailed error code
   nErrRC, nErrCC:word;		// result code and condition code for last error
   bHideUI:boolean;			// allow source u/i to be hidden
   pendingXfers:TW_PENDINGXFERS;
   gmulti:boolean;
   MultiCallBack:TIEMultiCallBack;
   fAborting:boolean;	// usato solo se bHideUI=true
   TWParams:TIETWainParams;
   IOParams:TIOParamsVals;
   TransferMode:(tmNative,tmBuffered,tmFile);
   transferdone:boolean; // true on transfer completed
   breakmodalloop:boolean;
   fBitmap:TIEBitmap;	// bitmap to fill
   Progress:PProgressRec;
   PTWainShared:PIETWainShared;
   actwnd:HWND;
   callwnd:HWND;
   BWToInvert:boolean; // the black/white image need to be inverted
   // new implementation
   ProxyWin:TWinControl;
   modal:boolean;
   sending:boolean;
   fclosecallback:TIETWCloseCallBack;
   fWindowList:pointer;
end;
pgrec=^tgrec;

function GetUINT16asInteger(var grec:tgrec; ilist:TIEIntegerList; cap:TW_UINT16):boolean; forward;

procedure IETW_EmptyMessageQueue(var grec:tgrec); forward;

procedure LogWrite(ss:AnsiString);
begin
	if iegTWainLogName<>'' then begin
	   	closefile(iegTWainLogFile);
   	   assignfile(iegTWainLogFile,iegTWainLogName);
         append(iegTWainLogFile);
   	WriteLn(iegTWainLogFile,datetostr(date)+' '+timetostr(time)+' : '+ss);
      Flush(iegTWainLogFile);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure Init_grec(var grec:tgrec);
begin
	grec.actwnd:=windows.getactivewindow;
	grec.fAborting:=false;
	grec.nState:=1;
   grec.TWParams:=nil;
   grec.BWToInvert:=false;
   grec.sending:=false;
	with grec.AppId do begin
   	id:=0;
      with version do begin
   		MajorNum:=1;
         MinorNum:=0;
         Language:=TWLG_USA;
         Country:=TWCY_USA;
         Info:=' '+#0;
      end;
      ProtocolMajor:=TWON_PROTOCOLMAJOR;// 1
      ProtocolMinor:=TWON_PROTOCOLMINOR;// 7
      SupportedGroups:=DG_IMAGE or DG_CONTROL;
      Manufacturer:=' '+#0;
      ProductFamily:=' '+#0;
      ProductName:=' '+#0;
   end;
   grec.fWindowList:=nil;
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure Set_AppId(var grec:tgrec);
begin
	with grec.AppId do begin
      strcopy(version.Info,PAnsiChar(grec.TWParams.AppVersionInfo));	// <?>
      version.Info[33]:=#0;
      strcopy(Manufacturer,PAnsiChar(grec.TWParams.AppManufacturer));
		Manufacturer[33]:=#0;
      strcopy(ProductFamily,PAnsiChar(grec.TWParams.AppProductFamily));
		ProductFamily[33]:=#0;
      strcopy(ProductName,PAnsiChar(grec.TWParams.AppProductName));
      ProductName[33]:=#0;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_LoadSourceManager(var grec:tgrec):boolean;
var
	szSMDir: array [0..255] of char;
	cc:integer;
begin
	with grec do begin
   	LogWrite('IETW_LoadSourceManager');
      if (nState >= 2) then begin
      	LogWrite('  IETW_LoadSourceManager : already loaded');
         result:=TRUE;			// DSM already loaded
         exit;
      end;
      if PTWainShared^.hDSMLib<>0 then begin
	      hDSMLib:=PTWainShared^.hDSMLib;
			DSM_Entry:=PTWainShared^.DSM_Entry;
      	result:=TRUE;
         nState:=2;
         LogWrite('  IETW_LoadSourceManager : already loaded');
         exit;
      end;
      GetWindowsDirectory(szSMDir, sizeof(szSMDir));
      cc := lstrlen(szSMDir);
      if (cc<>0) and (szSMDir[cc-1]<>':') then
         lstrcat(szSMDir, '\');
      lstrcat(szSMDir, DSM_FILENAME);
      if fileexists(AnsiString(szSMDir)) then begin
         hDSMLib := LoadLibrary(szSMDir);
      end else begin
         hDSMLib := 0;
      end;
      if hDSMLib<>0 then begin
      	LogWrite('  IETW_LoadSourceManager : Load OK');
         DSM_Entry := TDSMEntryProc(GetProcAddress(hDSMLib, DSM_ENTRYPOINT));
         if @DSM_Entry<>nil then begin
            nState := 2;
         end else begin
            FreeLibrary(hDSMLib);
            hDSMLib := 0;
         end
      end else begin
         DSM_Entry := nil;
      end;
      result:= (nState >= 2);
      //
      PTWainShared^.hDSMLib:=hDSMLib;
		PTWainShared^.DSM_Entry:=DSM_Entry;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
// use Force=true to really unloadsourcemanager
function IETW_UnloadSourceManager(var grec:tgrec; force:boolean):boolean;
begin
	with grec do begin
   	LogWrite('IETW_UnloadSourceManager');
   	if force and (PTWainShared^.hDSMLib<>0) then begin
         FreeLibrary(hDSMLib);
         PTWainShared^.hDSMLib:=0;
         PTWainShared^.DSM_Entry:=nil;
         nState := 1;
         LogWrite('  IETW_UnloadSourceManager : Unload OK');
      end else if (nState = 2) then begin
         if (hDSMLib<>0) then
            hDSMLib := 0;
         DSM_Entry := nil;
         nState := 1;
         LogWrite('  IETW_UnloadSourceManager not Unloaded, for future uses');
      end;
      result:= (nState = 1);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function CreateProxyWindow(var grec:tgrec):HWND;
var
	mainwnd:HWND;
begin
	LogWrite('CreateProxyWindow');
	if grec.PTWainShared.hproxy<>0 then begin
   	result:=grec.PTWainShared^.hproxy;
      LogWrite('  CreateProxyWindow : already created');
      exit;
   end;
   {$ifdef OCXVERSION}
   mainwnd:=HWND_DESKTOP;
   {$else}
   mainwnd:=grec.callwnd;
   if mainwnd=0 then
   	mainwnd:=HWND_DESKTOP;
   {$endif}
{$WARNINGS OFF}
	// Here memory debuggers could show a memory leak: it is not true, if DestroyWindow is not called by ImageEn
   // it is called by parent window.
	result := CreateWindow('STATIC','Acquire Proxy',WS_POPUPWINDOW,CW_USEDEFAULT, CW_USEDEFAULT,	// changed WS_POPUPWINDOW in 2.1.0
						CW_USEDEFAULT, CW_USEDEFAULT,
						mainwnd
                  ,0,GetModuleHandle(nil),nil);
   if assigned(application) then
	   application.processmessages;
   grec.PTWainShared.hproxy:=result;
   LogWrite('  CreateProxyWindow : created');
{$WARNINGS ON}
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure DestroyProxyWindow(wnd:HWND; var grec:tgrec; force:boolean);
begin
	LogWrite('DestroyProxyWindow');
	if force then begin
   	// the window could be destroyed by parent
	   if IsWindow(grec.PTWainShared^.hproxy) then
			DestroyWindow(grec.PTWainShared.hproxy);
      grec.PTWainShared.hproxy:=0;
      LogWrite('  DestroyProxyWindow : destroyed');
   end else begin
   	LogWrite('  DestroyProxyWindow : not destroyed, for future uses');
   end;
end;

function ResultToStr(rsl:TW_UINT16): AnsiString;
begin
	case rsl of
   	TWCC_BADCAP: Result := 'Capability not supported by Source or operation (get,set) is not supported on capability, or capability had dependencies on other capabilities and cannot be operated upon at this time';
    	TWCC_BADDEST: Result := 'Unknown destination in DSM_Entry.';
    	TWCC_BADPROTOCOL: Result := 'Unrecognized operation triplet.';
    	TWCC_BADVALUE: Result := 'Data parameter out of supported range.';
      TWCC_BUMMER: Result := 'General failure. Unload Source immediately.';
      TWCC_CAPUNSUPPORTED: Result := 'Capability not supported by Source.';
    	TWCC_CAPBADOPERATION: Result := 'Operation not supported on capability.';
    	TWCC_CAPSEQERROR: Result := 'Capability has dependencies on other capabilities and cannot be operated upon at this time.';
    	TWCC_DENIED: Result := 'File System operation is denied (file is protected).';
    	TWCC_PAPERDOUBLEFEED: Result := 'Transfer failed because of a feeder error';
    	TWCC_FILEEXISTS: Result := 'Operation failed because file already exists.';
    	TWCC_FILENOTFOUND: Result := 'File not found.';
    	TWCC_LOWMEMORY: Result := 'Not enough memory to complete operation.';
    	TWCC_MAXCONNECTIONS: Result := 'Source is connected to maximum supported number of applications.';
    	TWCC_NODS: Result := 'Source Manager unable to find the specified Source.';
    	TWCC_NOTEMPTY: Result := 'Operation failed because directory is not empty.';
    	TWCC_OPERATIONERROR: Result := 'Source or Source Manager reported an error to the user and handled the error; no application action required.';
    	TWCC_PAPERJAM: Result := 'Transfer failed because of a feeder error';
    	TWCC_SEQERROR: Result := 'Illegal operation for current Source Manager Source state.';
    	TWCC_SUCCESS: Result := 'Operation worked.';
  		else Result := 'Unknown Condition '+inttostr(rsl);
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_Mgr(var grec:tgrec; dg:TW_UINT32; dat:TW_UINT16; msg:TW_UINT16; pd:TW_MEMREF):boolean;
begin
	with grec do begin
      rc := TWRC_FAILURE;
      if (@DSM_Entry<>nil) then begin
      	try
         rc := DSM_Entry(@AppId, nil, dg, dat, msg, pd);
         if (rc<>TWRC_SUCCESS) and assigned(TWParams) then begin
         	TWParams.LastError:=rc;
            TWParams.LastErrorStr:=ResultToStr(rc);
            LogWrite('IETW_Mgr : '+TWParams.LastErrorStr);
         end;
         except
         end;
      end;
      result:= (rc = TWRC_SUCCESS);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_DS(var grec:tgrec; dg:TW_UINT32; dat:TW_UINT16; msg:TW_UINT16; pd:TW_MEMREF):boolean;
begin
	with grec do begin
      rc := TWRC_FAILURE;
      if (@DSM_Entry<>nil) then begin
      	try
         rc := DSM_Entry(@AppId, @SourceId, dg, dat, msg, pd);
         if (rc<>TWRC_SUCCESS) and assigned(TWParams) then begin
         	TWParams.LastError:=rc;
            TWParams.LastErrorStr:=ResultToStr(rc);
            LogWrite('IETW_DS : '+TWParams.LastErrorStr);
         end;
         except
         end;
      end;
      result:= (rc = TWRC_SUCCESS);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_OpenSourceManager(var grec:tgrec; hwnd:HWND):boolean;
begin
	with grec do begin
   	LogWrite('IETW_OpenSourceManager');
      hwnd32SM := TW_INT32(hwnd);
      if (IETW_Mgr(grec,DG_CONTROL, DAT_PARENT, MSG_OPENDSM, @hwnd32SM)) then begin
         nState := TWAIN_SM_OPEN;
      end;
      result:= (nState >= TWAIN_SM_OPEN);
      if result then
      	LogWrite('  IETW_OpenSourceManager : Ok')
      else
      	LogWrite('  IETW_OpenSourceManager : FAILED!');
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_CloseSourceManager(var grec:tgrec; hwnd:HWND):boolean;
var
	hwnd32:TW_INT32;
begin
	with grec do begin
   	LogWrite('IETW_CloseSourceManager');
   	IETW_EmptyMessageQueue(grec);
      hwnd32 := TW_INT32(hwnd);
      rc := TWRC_SUCCESS;
      if (IETW_Mgr(grec,DG_CONTROL, DAT_PARENT, MSG_CLOSEDSM, @hwnd32)) then begin
         nState := 2;
      end;
      result:= (nState <= 2);
      if result then
      	LogWrite('  IETW_CloseSourceManager : Ok')
      else
      	LogWrite('  IETW_CloseSourceManager : FAILED!');
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_DisableSource(var grec:tgrec):boolean;
begin
	with grec do begin
   	LogWrite('IETW_DisableSource');
   	BreakModalLoop:=true;
      if (nState = 5) and (IETW_DS(grec,DG_CONTROL, DAT_USERINTERFACE, MSG_DISABLEDS, @twUI)) then
         nState := 4;
      {$ifdef IETWAINTASKWINDOWS}
      if fWindowList<>nil then
	      EnableTaskWindows(fWindowList);
      fWindowList:=nil;
      {$endif}
      IETW_EmptyMessageQueue(grec);
      result:= (nState <= 4);
      if result then
      	LogWrite('  IETW_DisableSource : Ok')
      else
      	LogWrite('  IETW_DisableSource : FAILED!');
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_CloseSource(var grec:tgrec):boolean;
begin
	with grec do begin
   	LogWrite('IETW_CloseSource');
   	BreakModalLoop:=true;
      rc := TWRC_SUCCESS;
      if (nState = 5) then IETW_DisableSource(grec);
      if (nState = 4) and (IETW_Mgr(grec,DG_CONTROL, DAT_IDENTITY, MSG_CLOSEDS, @SourceId)) then
         nState := 3;
      result:= (nState <= 3);
      if result then
      	LogWrite('  IETW_CloseSource : Ok')
      else
      	LogWrite('  IETW_CloseSource : FAILED!');
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
// rest. ProductName del source selezionato
function IETW_SelectImageSource(var SelectedSourceName:AnsiString; TWainShared:PIETWainShared; callwnd:HWND):boolean;
var
   NewSourceId:TW_IDENTITY;
   grec:tgrec;
   wnd:HWND;
begin
	try
	result:=false;
	Init_grec(grec);
   grec.callwnd:=callwnd;
   grec.PTWainShared:=TWainShared;
   wnd:=CreateProxyWindow(grec);
   if IETW_LoadSourceManager(grec) then begin
      if IETW_OpenSourceManager(grec,wnd) then begin
         fillmemory(@NewSourceId, sizeof(NewSourceId),0);
         // Post the Select Source dialog
         result:=IETW_Mgr(grec,DG_CONTROL, DAT_IDENTITY, MSG_USERSELECT, @NewSourceId);
         SelectedSourceName:=NewSourceId.ProductName;
         IETW_CloseSourceManager(grec,wnd);
       end else begin
        	DestroyProxyWindow(wnd,grec,false);
         exit;
       end;
       IETW_UnloadSourceManager(grec,false);
   end;
  	DestroyProxyWindow(wnd,grec,false);
   finally
   	windows.setactivewindow(grec.actwnd);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure ClearError(var grec:tgrec);
begin
	grec.nErrDetail := ED_NONE;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_GetResultCode(var grec:tgrec):word;
begin
	result:=grec.rc;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_GetConditionCode(var grec:tgrec):word;
var
  	twStatus:TW_STATUS;
begin
	with grec do begin
      if nState>=4 then begin
         // get source status if open
         IETW_DS(grec,DG_CONTROL, DAT_STATUS, MSG_GET, TW_MEMREF(@twStatus));
      end else if nState=3 then begin
         // otherwise get source manager status
         IETW_Mgr(grec,DG_CONTROL, DAT_STATUS, MSG_GET, TW_MEMREF(@twStatus));
      end else begin
         // nothing open, not a good time to get condition code!
         result:=TWCC_SEQERROR;
         exit;
      end;
      if rc=TWRC_SUCCESS then begin
         result:=twStatus.ConditionCode;
         exit;
      end else
         result:=TWCC_BUMMER;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function RecordError(var grec:tgrec; ed:ErrorDetail):boolean;
begin
	with grec do begin
      if nErrDetail=ED_NONE then begin
         nErrDetail := ed;
         if (ed>ED_START_TRIPLET_ERRS) and (ed<ED_END_TRIPLET_ERRS) then begin
            nErrRC := IETW_GetResultCode(grec);
            nErrCC := IETW_GetConditionCode(grec);
         end else begin
            nErrRC := 0;
            nErrCC := 0;
         end;
      end;
      result:=FALSE;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_OpenSource(var grec:tgrec):boolean;
var
	src:pTW_IDENTITY;
   sn:AnsiString;
begin
	with grec do begin
   	LogWrite('IETW_OpenSource');
      if (nState <> 3) then begin
         result:=FALSE;
      	LogWrite('  IETW_OpenSource : already loaded');
         exit;
      end;

      sn:=TWParams.SourceName[ TWParams.SelectedSource ];

      if sn<>'' then begin
      	// Find selected source by ProductName
      	src:=AllocMem(sizeof(TW_IDENTITY));
			IETW_Mgr(grec,DG_CONTROL,DAT_IDENTITY,MSG_GETFIRST,src);
      	while rc<>TWRC_ENDOFLIST do begin
         	if src^.ProductName=sn then
            	break;
            zeromemory(src,sizeof(TW_IDENTITY));
				IETW_Mgr(grec,DG_CONTROL,DAT_IDENTITY,MSG_GETNEXT,src);
         end;
      	move(src^,SourceId,sizeof(TW_IDENTITY));
         FreeMem(src);
      end else begin
      	// system default source
	      SourceId.ProductName[0] := #0;
	      SourceId.Id := 0;
      end;
      if (IETW_Mgr(grec,DG_CONTROL, DAT_IDENTITY, MSG_OPENDS, @SourceId)) then begin
         nState := 4;
      end else
         RecordError(grec,ED_DSM_FAILURE);
      result:=(nState = 4);
      if result then
      	LogWrite('  IETW_OpenSource : Ok')
      else
      	LogWrite('  IETW_OpenSource : FAILED!');
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function IETW_EnableSource(var grec:tgrec; hwnd:HWND):boolean;
begin
	with grec do begin
   	LogWrite('IETW_EnableSource');
      if (nState <> 4) then begin
         result:=FALSE;
         LogWrite('  IETW_EnableSource : already enabled');
         exit;
      end;
      twUI.ShowUI := not bHideUI;
      twUI.hParent := TW_HANDLE(hwnd);
      twUI.ModalUI:=modal;
      {$ifdef IETWAINTASKWINDOWS}
      fWindowList:=DisableTaskWindows(0);
      {$endif}
      IETW_DS(grec,DG_CONTROL, DAT_USERINTERFACE, MSG_ENABLEDS, @twUI);
      if (rc = TWRC_FAILURE) then begin
         RecordError(grec,ED_DS_FAILURE);
      end else
         nState := 5;
      result:= (nState = 5);
      if result then
      	LogWrite('  IETW_EnableSource : Ok')
      else
      	LogWrite('  IETW_EnableSource : FAILED!');
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
function GetCapability(var grec:tgrec; var twCapability:TW_CAPABILITY; cap:TW_UINT16):boolean;
begin
   twCapability.Cap:=cap;
   twCapability.ConType:=TWON_DONTCARE16;
   twCapability.hContainer:=0;
   LogWrite('GetCapability : $'+inttohex(cap,4));
   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_GET,@twCapability);
   result:= grec.rc=TWRC_SUCCESS;
   if result then
   	LogWrite('  GetCapability : Ok')
   else
   	LogWrite('  GetCapability : FAILED!');
end;

function GetOneStringCapability(var grec:tgrec; outstr:AnsiString; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
   pvalOneValue:pTW_ONEVALUE;
   ptr:PAnsiChar;
begin
	result:=true;
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   pvalOneValue:=GlobalLock(twCapability.hContainer);
   ptr:=@(pvalOneValue^.Item);
   outstr:=AnsiString(ptr);
   GlobalUnlock(twCapability.hContainer);
   GlobalFree(twCapability.hContainer);
end;

// Supported TW_ONEVALUE (current value)
function SetOneStringCapability(var grec:tgrec; value:AnsiString; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
   pvalOneValue:pTW_ONEVALUE;
   ptr:PAnsiChar;
begin
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   LogWrite('SetOnStringCapability $'+inttohex(cap,4));
   GlobalFree(twCapability.hContainer);
   twCapability.Cap:=cap;
   // write TW_ONEVALUE (current value only)
   value:=copy(value,1,255);
   twCapability.ConType:=TWON_ONEVALUE;
   twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ONEVALUE)+256-4);
   pvalOneValue:=GlobalLock(twCapability.hContainer);
   pvalOneValue^.ItemType:=TWTY_STR255;
   ptr:=@(pvalOneValue^.Item);
   strcopy(ptr,PAnsiChar(value));
   GlobalUnLock(twCapability.hContainer);
   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
   result:= grec.rc=TWRC_SUCCESS;
   GlobalFree(twCapability.hContainer);
   if result then
   	LogWrite('  SetOnStringCapability : Ok')
   else
   	LogWrite('  SetOnStringCapability : FAILED!')
end;


///////////////////////////////////////////////////////////////////////////////////////
function IETW_AbortAllPendingXfers(var grec:tgrec):boolean;
begin
	with grec do begin
   	LogWrite('IETW_AbortAllPendingXfers');
   	breakmodalloop:=true;
      if (nState = 7) and IETW_DS(grec,DG_CONTROL, DAT_PENDINGXFERS, MSG_ENDXFER, @pendingXfers) then begin
         if pendingXfers.Count<>0 then
            nState:=6
         else
            nState:=5;
      end;
      if (nState = 6) and (IETW_DS(grec,DG_CONTROL, DAT_PENDINGXFERS, MSG_RESET, @pendingXfers)) then begin
         nState := 5;
      end;
      IETW_EmptyMessageQueue(grec);
      result:= (nState <= 5);
      if result then
      	LogWrite('  IETW_AbortAllPendingXfers : Ok')
      else
      	LogWrite('  IETW_AbortAllPendingXfers : FAILED!')
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
// supported 1bit(black/write), 8bit(grayscale), 24bit(truecolor)
procedure CopyBuffer(var grec:tgrec; Bitmap:TIEBitmap; const twImageInfo:TW_IMAGEINFO; const imxfer:TW_IMAGEMEMXFER; LockMemory:boolean);
var
	src,dst:pbyte;	// source buffer
   sinc:integer;	// source row length DWORDed
   pb:pbyte;	// dest buffer
   row,col:integer;
   px:PRGB;
begin
{$WARNINGS OFF}
	LogWrite('CopyBuffer compression='+inttostr(imxfer.Compression)+' BytesPerRow='+inttostr(imxfer.BytesPerRow)+' Columns='+inttostr(imxfer.Columns)+' Rows='+
   			inttostr(imxfer.Rows)+' XOffset='+inttostr(imxfer.XOffset)+' YOffset='+inttostr(imxfer.YOffset)+' BytesWritten='+inttostr(imxfer.BytesWritten));
	if LockMemory then
		src:=GlobalLock(integer(imxfer.Memory.TheMem))	// source data
   else
   	src:=imxfer.Memory.TheMem;
	sinc:=imxfer.BytesPerRow;
   if (twImageInfo.BitsPerPixel=24) then begin
   	// truecolor (24bit)
		for row:=0 to imxfer.Rows-1 do begin
         dst:=Bitmap.Scanline[row+imxfer.YOffset];
         inc(dst,imxfer.XOffset*3);	// select column
         _CopyBGR_RGB(PRGB(dst),PRGB(src),imxfer.Columns);
         inc(src,sinc);
      end;
   end else if (twImageInfo.BitsPerPixel=8) then begin
   	// grayscale (8bit) (convert to 24bit)
		for row:=0 to imxfer.Rows-1 do begin
         dst:=Bitmap.Scanline[row+imxfer.YOffset];
         inc(dst,imxfer.XOffset*3);	// select column
      	pb:=src;
         px:=PRGB(dst);
			for col:=0 to imxfer.Columns-1 do begin
				with px^ do begin
            	r:=pb^;
               g:=pb^;
               b:=pb^;
            end;
            inc(pb);
            inc(px);
         end;
         inc(src,sinc);
      end;
   end else if (twImageInfo.BitsPerPixel=1) then begin
   	// black/write (1bit)
      for row:=0 to imxfer.Rows-1 do begin
         dst:=Bitmap.Scanline[row+imxfer.YOffset];
      	_CopyBits(dst,src,imxfer.XOffset,0,imxfer.Columns,2147483647);
         inc(src,sinc);
      end;
   end;
   if LockMemory then
	   GlobalUnlock(integer(imxfer.Memory.TheMem));
   LogWrite('CopyBuffer : Ok');
{$WARNINGS ON}
end;

function GetOneBool(var grec:tgrec; var Value:boolean; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
   pvalOneValue:pTW_ONEVALUE;
   pbol:pTW_BOOL;
begin
	result:=true;
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
	if twCapability.ConType=TWON_ONEVALUE then begin
      pvalOneValue:=GlobalLock(twCapability.hContainer);
      pbol:=@(pvalOneValue^.Item);
      Value:=pbol^;
      GlobalUnlock(twCapability.hContainer);
   end else
   	result:=false;
   GlobalFree(twCapability.hContainer);
end;

///////////////////////////////////////////////////////////////////////////////////////
// Supported TW_ONEVALUE (current value)
function SetOneBoolCapability(var grec:tgrec; value:boolean; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
   pvalOneValue:pTW_ONEVALUE;
begin
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   GlobalFree(twCapability.hContainer);
   twCapability.Cap:=cap;
   // write TW_ONEVALUE (current value only)
   LogWrite('SetOnBoolCapability');
   twCapability.ConType:=TWON_ONEVALUE;
   twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ONEVALUE));
   pvalOneValue:=GlobalLock(twCapability.hContainer);
   pvalOneValue^.ItemType:=TWTY_BOOL;
   pvalOneValue^.Item:=ord(value);
   GlobalUnLock(twCapability.hContainer);
   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
   result:= grec.rc=TWRC_SUCCESS;
   GlobalFree(twCapability.hContainer);
   if result then
   	LogWrite('  SetOnBoolCapability : Ok')
   else
   	LogWrite('  SetOnBoolCapability : FAILED!');
end;


///////////////////////////////////////////////////////////////////////////////////////
procedure IETW_XferReady(var grec:tgrec; pmsg:PMSG);
var
	hNative:TW_UINT32;
   setupmemxfer:TW_SETUPMEMXFER;
   setupfilexfer:TW_SETUPFILEXFER;
   imxfer:TW_IMAGEMEMXFER;
   hbuff:THandle;
   twImageInfo:TW_IMAGEINFO;
   pimxfer:pTW_IMAGEMEMXFER;
   DelayImageInfo:boolean;	// if true recall ImageInfo after loaded all buffers
   buffers:TList;
   ptr:pointer;
   i:integer;
   pixfor:TIEPixelFormat;
   io:TImageEnIO;
//
function ImageInfo:boolean;
begin
	LogWrite('IETW_XferReady.ImageInfo');
	DelayImageInfo:=false;
	result:=true;
   try
	with grec do begin
      if not IETW_DS(grec,DG_IMAGE,DAT_IMAGEINFO,MSG_GET,TW_MEMREF(@twImageInfo)) then begin
			IETW_AbortAllPendingXfers(grec);
      	result:=false;
         LogWrite('IETW_XferReady.ImageInfo : not available!');
         exit;
      end;
      if (TransferMode<>tmFile) and ((twImageInfo.PixelType>2) or (twImageInfo.Planar<>false) or (twImageInfo.Compression<>0)) then
      	TransferMode:=tmNative;
      case twImageInfo.BitsPerPixel of
      	1..8: begin IOParams.BitsPerSample:=twImageInfo.BitsPerPixel; IOParams.SamplesPerPixel:=1; end;
         24: begin IOParams.BitsPerSample:=8; IOParams.SamplesPerPixel:=3; end;
		end;
      IOParams.DpiX:=round(twImageInfo.XResolution.Whole+twImageInfo.XResolution.Frac/65536);
		IOParams.DpiY:=round(twImageInfo.YResolution.Whole+twImageInfo.YResolution.Frac/65536);
      IOParams.Width:=twImageInfo.ImageWidth;
      IOParams.Height:=twImageInfo.ImageLength;
      if IOParams.ColorMap<>nil then begin
      	freemem(IOParams.ColorMap);
         IOParams.fColorMap:=nil;
         IOParams.fColorMapCount:=0;
      end;
      if (IOParams.Width<0) or (IOParams.Height<0) then begin
      	DelayImageInfo:=true;
         result:=true;
         exit;
      end;
      if (IOParams.Width=0) or (IOParams.Height=0) then begin
			IETW_AbortAllPendingXfers(grec);
         result:=false;
         exit;
      end;
      if (IOParams.BitsPerSample=1) and (IOParams.SamplesPerPixel=1) then
         pixfor:=ie1g
      else
         pixfor:=ie24RGB;
      if (fBitmap.Width<>IOParams.Width) or (fBitmap.Height<>IOParams.Height) or (fBitmap.PixelFormat<>pixfor) then
         fBitmap.allocate(IOParams.Width,IOParams.Height,pixfor);
   end;
   except
   	LogWrite('  IETW_XferReady.ImageInfo : exception!');
   	if result then begin
      	IETW_AbortAllPendingXfers(grec);
         result:=false;
      end;
   end;
   LogWrite('  IETW_XferReady.ImageInfo : end');
end;
//
begin
{$WARNINGS OFF}
	LogWrite('IETW_XferReady');
	with grec do begin
      if not ImageInfo then begin
         fAborting:=true;
         LogWrite('IETW_XferReady : ABORTED, image info not available!');
         exit;
      end;
      //DelayImageInfo:=true;	// uncomment to force undefined size (test only)
      case TransferMode of
      	tmBuffered:
         	begin
               ///// Buffered xfer
               LogWrite('  IETW_XferReady : buffered transfer mode');
               buffers:=nil;
               if DelayImageInfo then
                  buffers:=TList.Create;
               if assigned(Progress) then
                  Progress.per1:=100/twImageInfo.ImageLength;
               if IETW_DS(grec,DG_CONTROL,DAT_SETUPMEMXFER,MSG_GET,@setupmemxfer) then
	               LogWrite('  IETW_XferReady : DAT_SETUPMEMXFER Ok')
               else
               	LogWrite('  IETW_XferReady : DAT_SETUPMEMXFER FAILED!');
               hbuff:=GlobalAlloc(GPTR,setupmemxfer.Preferred);
               with imxfer do begin
                  Compression:=TWON_DONTCARE16;
                  BytesPerRow:=TW_UINT32(TWON_DONTCARE32);
                  Columns:=TW_UINT32(TWON_DONTCARE32);
                  Rows:=TW_UINT32(TWON_DONTCARE32);
                  XOffset:=TW_UINT32(TWON_DONTCARE32);
                  YOffset:=TW_UINT32(TWON_DONTCARE32);
                  BytesWritten:=TW_UINT32(TWON_DONTCARE32);
                  Memory.Flags:=TWMF_APPOWNS or TWMF_HANDLE;
                  Memory.Length:=setupmemxfer.Preferred;
                  Memory.TheMem:=pointer(hbuff);
               end;
               repeat
                  if IETW_DS(grec,DG_IMAGE,DAT_IMAGEMEMXFER,MSG_GET,@imxfer) then
                  	LogWrite('  IETW_XferReady : DAT_IMAGEMEMXFER Ok')
                  else
                  	LogWrite('  IETW_XferReady : DAT_IMAGEMEMXFER FAILED! (image terminated?)');
                  case rc of
                     TWRC_SUCCESS, TWRC_XFERDONE:
                        begin
                        	if rc=TWRC_SUCCESS then
                        		LogWrite('  IETW_XferReady : TWRC_SUCCESS begin');
                           if rc=TWRC_XFERDONE then
                           	LogWrite('  IETW_XferReady : TWRC_XFERDONE begin');
                           if DelayImageInfo then begin
                              new(pimxfer);
                              move(imxfer,pimxfer^,sizeof(TW_IMAGEMEMXFER));
                              getmem(pimxfer^.Memory.TheMem,imxfer.BytesWritten);
                              ptr:=GlobalLock(integer(imxfer.Memory.TheMem));
                              copymemory(pimxfer^.Memory.TheMem,ptr,imxfer.BytesWritten);
                              GlobalUnlock(integer(imxfer.Memory.TheMem));
                              buffers.Add( pimxfer );
                           end else
                              CopyBuffer(grec,fBitmap,twImageInfo,imxfer,true);
                           if rc=TWRC_XFERDONE then begin
                              // CAP_CAPTION
                              if not GetOneStringCapability(grec,IOParams.fFileName,CAP_CAPTION) then
                                 IOParams.fFileName:='';
                              //
                              nState := 7;
                              transferdone:=true;
                              if DelayImageInfo then begin
                                 // get image info and copy buffers
                                 if (nState = 7) and IETW_DS(grec,DG_CONTROL, DAT_PENDINGXFERS, MSG_ENDXFER, @pendingXfers) then begin
                                    if pendingXfers.Count<>0 then
                                       nState:=6
                                    else
                                       nState:=5;
                                 end;
                                 if ImageInfo then begin
                                    for i:=0 to buffers.Count-1 do begin
                                       pimxfer:=buffers[i];
                                       CopyBuffer(grec,fBitmap,twImageInfo,pimxfer^,false);
                                    end;
                                 end;
                                 DelayImageInfo:=true;	// this because ImageInfo set it to False
                              end;
                              //
                              break;
                           end;
                           LogWrite('  IETW_XferReady : TWRC_SUCCESS or TWRC_XFERDONE end');
                        end;
                     TWRC_CANCEL:
                        begin
                        	LogWrite('  IETW_XferReady : TWRC_CANCEL');
                           breakmodalloop:=true;
                           nState := 7;
                           if bHideUI then
                              fAborting:=true;
                           break;
                        end;
                     TWRC_FAILURE:
                        begin
                        	LogWrite('  IETW_XferReady : TWRC_FAILURE');
                           nState := 6;
                           if bHideUI then
                              fAborting:=true;
                           break;
                        end;
                  end;
                  // OnProgress
                  if assigned(Progress) then begin
                     with Progress^ do
                        if assigned(fOnProgress) then
                           fOnProgress(Sender,trunc(per1*(imxfer.YOffset+imxfer.Rows)));
                     if Progress^.Aborting^ then begin
                        nState := 7;
                        if bHideUI then
                           fAborting:=true;
                        break;
                     end;
                  end;
               until false;
               GlobalFree(hbuff);
               if DelayImageInfo then begin
                  while buffers.Count>0 do begin
                     pimxfer:=buffers[0];
                     freemem( pimxfer^.Memory.TheMem );
                     dispose(pimxfer);
                     buffers.delete(0);
                  end;
                  buffers.free;
               end;
         	end;
         tmNative:
         	begin
               ////// Native xfer
               LogWrite('  IETW_XferReady : Native transfer mode');
               IETW_DS(grec,DG_IMAGE, DAT_IMAGENATIVEXFER, MSG_GET, @hNative);
               case (rc) of
                  TWRC_XFERDONE:
                     begin
                        // copy image
                        LogWrite('  IETW_XferReady : TWRC_XFERDONE');
                        _CopyDIB2BitmapEx(hNative,fBitmap,nil,false);
                        GlobalFree(hNative);	// 2.0.9
                        //
                        nState := 7;
                        transferdone:=true;
                     end;
                  TWRC_CANCEL:
                     begin
                     	LogWrite('  IETW_XferReady : TWRC_CANCEL');
                        breakmodalloop:=true;
                        nState := 7;
                        if bHideUI then
                           fAborting:=true;
                     end;
                  TWRC_FAILURE:
                     begin
                     	LogWrite('  IETW_XferReady : TWRC_FAILURE');
                        nState := 6;
                        if bHideUI then
                           fAborting:=true;
                     end;
                  else
                     nState := 6;
               end;
            end;
         tmFile:
         	begin
            	////// File xfer
               LogWrite('  IETW_XferReady : File transfer mode');
               IETW_DS(grec,DG_CONTROL,DAT_SETUPFILEXFER,MSG_GET,@setupfilexfer);
               setupfilexfer.FileName:='c:\imageentwain03.bmp';
               if (setupfilexfer.Format=1) or (setupfilexfer.Format=3) or (setupfilexfer.Format=5) or (setupfilexfer.Format=6) or (setupfilexfer.Format>7) then
	               setupfilexfer.Format:=TWFF_BMP;
               setupfilexfer.VRefNum:=0;
               IETW_DS(grec,DG_CONTROL,DAT_SETUPFILEXFER,MSG_SET,@setupfilexfer);
               IETW_DS(grec,DG_IMAGE, DAT_IMAGEFILEXFER, MSG_GET, nil);
               case (rc) of
                  TWRC_XFERDONE:
                     begin
                        // copy image
                        LogWrite('  IETW_XferReady : TWRC_XFERDONE');
                        io:=TImageEnIO.Create(nil);
                        io.AttachedIEBitmap:=fBitmap;
                        io.LoadFromFileFormat(setupfilexfer.FileName,FindFileFormat(setupfilexfer.FileName,false));
                        io.free;
                        //
                        nState := 7;
                        transferdone:=true;
                     end;
                  TWRC_CANCEL:
                     begin
                     	LogWrite('  IETW_XferReady : TWRC_CANCEL');
                        breakmodalloop:=true;
                        nState := 7;
                        if bHideUI then
                           fAborting:=true;
                     end;
                  TWRC_FAILURE:
                     begin
                     	LogWrite('  IETW_XferReady : TWRC_FAILURE');
                        nState := 6;
                        if bHideUI then
                           fAborting:=true;
                     end;
                  else
                     nState := 6;
               end;
            end;
      end;
      breakmodalloop:=true;
      IETW_AbortAllPendingXfers(grec);
   end;
   LogWrite('  IETW_XferReady : end');
{$WARNINGS ON}
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure IETW_XferReadyMulti(var grec:tgrec; pmsg:PMSG);
var
	hNative:TW_UINT32;
   setupmemxfer:TW_SETUPMEMXFER;
   setupfilexfer:TW_SETUPFILEXFER;
   imxfer:TW_IMAGEMEMXFER;
   hbuff:THandle;
   twImageInfo:TW_IMAGEINFO;
   ofy:integer;
   ofy_set:boolean;
   pimxfer:pTW_IMAGEMEMXFER;
   DelayImageInfo:boolean;	// if true recall ImageInfo after loaded all buffers
   buffers:TList;
   ptr:pointer;
   i:integer;
   fCaption:AnsiString;
   io:TImageEnIO;
//
function ImageInfo:boolean;
begin
	LogWrite('IETW_XferReadyMulti.ImageInfo');
	DelayImageInfo:=false;
	result:=true;
   try
   with grec do begin
      if not IETW_DS(grec,DG_IMAGE,DAT_IMAGEINFO,MSG_GET,TW_MEMREF(@twImageInfo)) then begin
         IETW_AbortAllPendingXfers(grec);
         result:=false;
         LogWrite('IETW_XferReadyMulti.ImageInfo : not available!');
         exit;
      end;
      if (TransferMode<>tmFile) and ((twImageInfo.PixelType>2) or (twImageInfo.Planar<>false) or (twImageInfo.Compression<>0)) then
      	TransferMode:=tmNative;
		if (twImageInfo.ImageWidth<0) or (twImageInfo.ImageLength<0) then begin
      	DelayImageInfo:=true;
         result:=true;
         exit;
      end;
		if (twImageInfo.ImageWidth<=0) or (twImageInfo.ImageLength<=0) then begin
         IETW_AbortAllPendingXfers(grec);
         result:=false;
         exit;
      end;
      fBitmap:=TIEBitmap.Create;
      if twImageInfo.BitsPerPixel=1 then
         fBitmap.Allocate(twImageInfo.ImageWidth,twImageInfo.ImageLength,ie1g)
      else
         fBitmap.Allocate(twImageInfo.ImageWidth,twImageInfo.ImageLength,ie24RGB);
   end;
   except
   	LogWrite('  IETW_XferReadyMulti.ImageInfo : exception!');
   	if result then begin
      	IETW_AbortAllPendingXfers(grec);
         result:=false;
      end;
   end;
   LogWrite('  IETW_XferReadyMulti.ImageInfo : end');
end;
//
begin
{$WARNINGS OFF}
	LogWrite('IETW_XferReadyMulti');
	fCaption:='';
	with grec do begin
      repeat
      	LogWrite('  IETW_XferReadyMulti : getting another image');
         if assigned(Progress) and Progress^.Aborting^ then begin
            IETW_AbortAllPendingXfers(grec);
            exit;
         end;
         if not ImageInfo then begin
         	LogWrite('IETW_XferReadyMulti : ABORTED, image info not available!');
         	fAborting:=true;
         	exit;
         end;
         //DelayImageInfo:=true;	// uncomment for force undefined size (test only)
         case TransferMode of
         	tmBuffered:
            	begin
                  ///// Buffered xfer
                  LogWrite('  IETW_XferReadyMulti : buffered transfer mode');
                  buffers:=nil;
                  if DelayImageInfo then
                     buffers:=TList.Create;
                  if IETW_DS(grec,DG_CONTROL,DAT_SETUPMEMXFER,MSG_GET,@setupmemxfer) then
                  	LogWrite('  IETW_XferReadyMulti : DAT_SETUPMEMXFER Ok')
                  else
							LogWrite('  IETW_XferReadyMulti : DAT_SETUPMEMXFER FAILED!');
                  hbuff:=GlobalAlloc(GPTR,setupmemxfer.Preferred);
                  with imxfer do begin
                     Compression:=TWON_DONTCARE16;
                     BytesPerRow:=TW_UINT32(TWON_DONTCARE32);
                     Columns:=TW_UINT32(TWON_DONTCARE32);
                     Rows:=TW_UINT32(TWON_DONTCARE32);
                     XOffset:=TW_UINT32(TWON_DONTCARE32);
                     YOffset:=TW_UINT32(TWON_DONTCARE32);
                     BytesWritten:=TW_UINT32(TWON_DONTCARE32);
                     Memory.Flags:=TWMF_APPOWNS or TWMF_HANDLE;
                     Memory.Length:=setupmemxfer.Preferred;
                     Memory.TheMem:=pointer(hbuff);
                  end;
                  if assigned(Progress) then
                     Progress.per1:=100/twImageInfo.ImageLength;
                  ofy_set:=false;
                  ofy:=0;
                  repeat
                     if IETW_DS(grec,DG_IMAGE,DAT_IMAGEMEMXFER,MSG_GET,@imxfer) then
                     	LogWrite('  IETW_XferReadyMulti : DAT_IMAGEMEMXFER Ok')
                     else
								LogWrite('  IETW_XferReadyMulti : DAT_IMAGEMEMXFER FAILED! (image terminated?)');
                     if not ofy_set then begin
                        ofy_set:=true;
                        ofy:=imxfer.YOffset;
                     end;
                     imxfer.YOffset:=imxfer.YOffset-ofy;
                     case rc of
                        TWRC_SUCCESS, TWRC_XFERDONE:
                           begin
                              if rc=TWRC_SUCCESS then
                                 LogWrite('  IETW_XferReadyMulti : TWRC_SUCCESS begin');
                              if rc=TWRC_XFERDONE then
                                 LogWrite('  IETW_XferReadyMulti : TWRC_XFERDONE begin');
                              if DelayImageInfo then begin
                                 new(pimxfer);
                                 move(imxfer,pimxfer^,sizeof(TW_IMAGEMEMXFER));
                                 getmem(pimxfer^.Memory.TheMem,imxfer.BytesWritten);
                                 ptr:=GlobalLock(integer(imxfer.Memory.TheMem));
                                 copymemory(pimxfer^.Memory.TheMem,ptr,imxfer.BytesWritten);
                                 GlobalUnlock(integer(imxfer.Memory.TheMem));
                                 buffers.Add( pimxfer );
                              end else
                                 CopyBuffer(grec,fBitmap,twImageInfo,imxfer,true);
                              if rc=TWRC_XFERDONE then begin
                                 // CAP_CAPTION
                                 if not GetOneStringCapability(grec,fCaption,CAP_CAPTION) then
                                    fCaption:='';
                                 //
                                 transferdone:=true;
                                 nState := 7;
                                 if DelayImageInfo then begin
                                    // get image info and copy buffers
                                    if (nState = 7) and IETW_DS(grec,DG_CONTROL, DAT_PENDINGXFERS, MSG_ENDXFER, @pendingXfers) then begin
                                       if pendingXfers.Count<>0 then
                                          nState:=6
                                       else
                                          nState:=5;
                                    end;
                                    if ImageInfo then begin
                                       for i:=0 to buffers.Count-1 do begin
                                          pimxfer:=buffers[i];
                                          CopyBuffer(grec,fBitmap,twImageInfo,pimxfer^,false);
                                       end;
                                    end;
                                    DelayImageInfo:=true;	// this because ImageInfo set it to False
                                 end;
                                 break;
                              end;
                              LogWrite('  IETW_XferReadyMulti : TWRC_SUCCESS or TWRC_XFERDONE end');
                           end;
                        TWRC_CANCEL:
                           begin
                           	LogWrite('  IETW_XferReadyMulti : TWRC_CANCEL');
                              breakmodalloop:=true;
                              nState := 7;
                              if bHideUI then
                                 fAborting:=true;
                              break;
                           end;
                        TWRC_FAILURE:
                           begin
                           	LogWrite('  IETW_XferReadyMulti : TWRC_FAILURE');
                              nState := 6;
                              if bHideUI then
                                 fAborting:=true;
                              break;
                           end;
                     end;
                     // OnProgress
                     if assigned(Progress) then
                        with Progress^ do
                           if assigned(fOnProgress) then
                              fOnProgress(Sender,trunc(per1*(imxfer.YOffset+imxfer.Rows)));
                  until false;
                  GlobalFree(hbuff);
                  if DelayImageInfo then begin
                     while buffers.Count>0 do begin
                        pimxfer:=buffers[0];
                        freemem( pimxfer^.Memory.TheMem );
                        dispose(pimxfer);
                        buffers.delete(0);
                     end;
                     buffers.free;
                  end;
               end;
            tmNative:
            	begin
                  ////// Native xfer
                  LogWrite('  IETW_XferReadyMulti : Native transfer mode');
                  IETW_DS(grec,DG_IMAGE, DAT_IMAGENATIVEXFER, MSG_GET, @hNative);
                  case (rc) of
                     TWRC_XFERDONE:
                        begin
                           // copy image
                           LogWrite('  IETW_XferReadyMulti : TWRC_XFERDONE');
                           _CopyDIB2BitmapEx(hNative,fBitmap,nil,false);
                           GlobalFree(hNative);	// 2.0.9
                           //
                           nState := 7;
                           transferdone:=true;
                        end;
                     TWRC_CANCEL:
                        begin
                        	LogWrite('  IETW_XferReadyMulti : TWRC_CANCEL');
                           breakmodalloop:=true;
                           nState := 7;
                           if bHideUI then
                              fAborting:=true;
                        end;
                     TWRC_FAILURE:
                        begin
                        	LogWrite('  IETW_XferReadyMulti : TWRC_FAILURE');
                           nState := 6;
                           if bHideUI then
                              fAborting:=true;
                        end;
                     else
                        nState := 6;
                  end;
               end;
            tmFile:
               begin
                  ////// File xfer
                  LogWrite('  IETW_XferReadyMulti : File transfer mode');
                  IETW_DS(grec,DG_CONTROL,DAT_SETUPFILEXFER,MSG_GET,@setupfilexfer);
                  setupfilexfer.FileName:='c:\imageentwain03.bmp';
                  if (setupfilexfer.Format=1) or (setupfilexfer.Format=3) or (setupfilexfer.Format=5) or (setupfilexfer.Format=6) or (setupfilexfer.Format>7) then
                     setupfilexfer.Format:=TWFF_BMP;
                  setupfilexfer.VRefNum:=0;
                  IETW_DS(grec,DG_CONTROL,DAT_SETUPFILEXFER,MSG_SET,@setupfilexfer);
                  IETW_DS(grec,DG_IMAGE, DAT_IMAGEFILEXFER, MSG_GET, nil);
                  case (rc) of
                     TWRC_XFERDONE:
                        begin
                           // copy image
                           LogWrite('  IETW_XferReadyMulti : TWRC_XFERDONE');
                           io:=TImageEnIO.Create(nil);
                           io.AttachedIEBitmap:=fBitmap;
                           io.LoadFromFileFormat(setupfilexfer.FileName,FindFileFormat(setupfilexfer.FileName,false));
                           io.free;
                           //
                           nState := 7;
                           transferdone:=true;
                        end;
                     TWRC_CANCEL:
                        begin
                        	LogWrite('  IETW_XferReadyMulti : TWRC_CANCEL');
                           breakmodalloop:=true;
                           nState := 7;
                           if bHideUI then
                              fAborting:=true;
                        end;
                     TWRC_FAILURE:
                        begin
                        	LogWrite('  IETW_XferReadyMulti : TWRC_FAILURE');
                           nState := 6;
                           if bHideUI then
                              fAborting:=true;
                        end;
                     else
                        nState := 6;
                  end;
               end;
         end;
         //
		   if (fBitmap.PixelFormat=ie1g) and grec.BWToInvert then
		      _Negative1BitEx(fBitmap);
			MultiCallBack(fBitmap,TObject(IOParams));
         fBitmap.free;
         if IOParams<>nil then begin
            case twImageInfo.BitsPerPixel of
               1..8: begin IOParams.BitsPerSample:=twImageInfo.BitsPerPixel; IOParams.SamplesPerPixel:=1; end;
               24: begin IOParams.BitsPerSample:=8; IOParams.SamplesPerPixel:=3; end;
            end;
            IOParams.DpiX:=round(twImageInfo.XResolution.Whole+twImageInfo.XResolution.Frac/65536);
            IOParams.DpiY:=round(twImageInfo.YResolution.Whole+twImageInfo.YResolution.Frac/65536);
            IOParams.Width:=twImageInfo.ImageWidth;
            IOParams.Height:=twImageInfo.ImageLength;
            if IOParams.ColorMap<>nil then begin
               freemem(IOParams.ColorMap);
               IOParams.fColorMap:=nil;
               IOParams.fColorMapCount:=0;
            end;
            IOParams.fFileName:=fCaption;
         end;
         //
         if (nState = 7) and IETW_DS(grec,DG_CONTROL, DAT_PENDINGXFERS, MSG_ENDXFER, @pendingXfers) then begin
            if pendingXfers.Count<>0 then
               nState:=6
            else
               nState:=5;
         end;
      until nState<>6;
      breakmodalloop:=true;
      IETW_AbortAllPendingXfers(grec);
   end;
   LogWrite('  IETW_XferReadyMulti : end');
{$WARNINGS ON}
end;

///////////////////////////////////////////////////////////////////////////////////////
// true msg processed
function IETW_MessageHook(var grec:tgrec; lpmsg:pMSG):boolean;
var
   bProcessed:boolean;
	twEvent:TW_EVENT;
   xmodal:boolean;
begin
	LogWrite('IETW_MessageHook');
	with grec do begin
   	xmodal:=modal;	// grec.modal could not be more valid after ProxyWin.Free
      bProcessed := FALSE;
      if (nState >= 5) then begin
         // source enabled
         LogWrite('IETW_MessageHook : state>=5');
         twEvent.pEvent := TW_MEMREF(lpmsg);
         twEvent.TWMessage := MSG_NULL;
         //
         IETW_DS(grec,DG_CONTROL, DAT_EVENT, MSG_PROCESSEVENT, @twEvent);
         LogWrite('IETW_MessageHook : event.msg=$'+inttohex(twEvent.TWMessage,4));
         bProcessed := (rc = TWRC_DSEVENT);
         case (twEvent.TWMessage) of
            MSG_XFERREADY:
               begin
               	if not sending then begin
                  	sending:=true;
                     nState := 6;
                     if gmulti then
                        IETW_XferReadyMulti(grec,lpmsg)
                     else
                        IETW_XferReady(grec,lpmsg);
                     if fAborting then
                        IETW_DisableSource(grec);
                     sending:=false;
                     LogWrite('  IETW_MessageHook : processed MSG_XFERREADY');
                  end;
               end;
            MSG_CLOSEDSREQ:
               begin
               	LogWrite('  IETW_MessageHook : processed MSG_CLOSEDSREQ');
                  IETW_DisableSource(grec);
                	if not xmodal then
                  	grec.ProxyWin.free;
               end;
            MSG_NULL:
               begin
                  // no message returned from DS
                  LogWrite('  IETW_MessageHook : MSG_NULL');
               end;
         end;
      end;
      result:=bProcessed;
   end;
   if xmodal then
	   LogWrite('IETW_MessageHook : end');
end;

procedure IETW_EmptyMessageQueue(var grec:tgrec);
var
   msg:TMSG;
begin
	LogWrite('IETW_EmptyMessageQueue');
	with grec do begin
   	while (PeekMessage(msg, 0, 0, 0, PM_REMOVE)) do begin
      	if (msg.message = WM_QUIT) then begin
         	PostQuitMessage(msg.wParam);
         	break;
        	end;
        	if (not IETW_MessageHook(grec,@msg)) then begin
        		TranslateMessage(msg);
        		DispatchMessage(msg);
        	end;
      end;
   end;
   LogWrite('  IETW_EmptyMessageQueue : end');
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure IETW_ModalEventLoop(var grec:tgrec);
var
   msg:TMSG;
begin
	LogWrite('IETW_ModalEventLoop');
	with grec do begin
   	BreakModalLoop:=false;
      while (nState >= 5) and (not TransferDone) and (not BreakModalLoop) and (GetMessage(msg, 0, 0, 0)) do begin
         if (not IETW_MessageHook(grec,@msg)) then begin
            TranslateMessage(msg);
            try
            DispatchMessage(msg);
            except
            end;
         end;
      end;
      breakmodalloop:=false;
   end;
   LogWrite('IETW_ModalEventLoop : end');
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure IETW_GetSourceList(SList:TList; TWainShared:PIETWainShared; callwnd:HWND);
var
   SourceId:pTW_IDENTITY;
   grec:tgrec;
   wnd:HWND;
begin
	try
	SList.Clear;
	Init_grec(grec);
   grec.callwnd:=callwnd;
   grec.PTWainShared:=TWainShared;
   wnd := CreateProxyWindow(grec);
   if (IETW_LoadSourceManager(grec)) then begin
      if (IETW_OpenSourceManager(grec,wnd)) then begin
      	SourceId:=AllocMem(sizeof(TW_IDENTITY));
			IETW_Mgr(grec,DG_CONTROL,DAT_IDENTITY,MSG_GETFIRST,SourceId);
      	while grec.rc<>TWRC_ENDOFLIST do begin
         	if SourceId^.ProductName='' then
            	freemem(SourceId)
            else
	         	SList.Add(SourceId);
				SourceId:=AllocMem(sizeof(TW_IDENTITY));
				IETW_Mgr(grec,DG_CONTROL,DAT_IDENTITY,MSG_GETNEXT,SourceId);
         end;
         FreeMem(SourceId);	// last not assigned
         IETW_CloseSourceManager(grec,wnd);
       end else begin
       	DestroyProxyWindow(wnd,grec,false);
         exit;
       end;
       IETW_UnloadSourceManager(grec,false);
   end else begin
   	DestroyProxyWindow(wnd,grec,false);
      exit;
   end;
   DestroyProxyWindow(wnd,grec,false);
   finally
   	windows.setactivewindow(grec.actwnd);
   end;
end;

(*
procedure FloatToFIX32(const floater:double; fix32:pTW_FIX32);
var
	value:integer;
begin
	value:=trunc(floater*65536+0.5);
   fix32^.Whole:=value shr 16;
   fix32^.Frac:=value and $0000FFFF;
end;
//*)
procedure FloatToFix32(const floater:double; fix32:pTW_FIX32 );
var
   s:double;
   value:TW_INT32;
begin
	try
   if floater<0 then s:=-0.5 else s:=0.5;
   value := trunc(floater * 65536 + s);
   Fix32^.Whole := value shr 16;
   Fix32^.Frac := value and $0000ffff;
   except
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure GetAcquireFrame(var grec:tgrec; var fAcquireFrame:TIEDRect);
var
	ImageLayout:TW_IMAGELAYOUT;
begin
	LogWrite('GetAcquireFrame');
	IETW_DS(grec,DG_IMAGE,DAT_IMAGELAYOUT,MSG_GET,@ImageLayout);
   if grec.rc=TWRC_SUCCESS then begin
      with ImageLayout.Frame do begin
         fAcquireFrame.Left:= Left.Whole+Left.Frac/65536;
         fAcquireFrame.Top:= Top.Whole+Top.Frac/65536;
         fAcquireFrame.Right:= Right.Whole+Right.Frac/65536;
         fAcquireFrame.Bottom:= Bottom.Whole+BOttom.Frac/65536;
      end;
		LogWrite('  GetAcquireFrame : ok');
   end else begin
   	LogWrite('  GetAcquireFrame : FAILED!');
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
procedure SetAcquireFrame(var grec:tgrec; const fLeft,fTop,fRight,fBottom:double);
var
	ImageLayout:TW_IMAGELAYOUT;
begin
	LogWrite('SetAcquireFrame');
	fillchar(ImageLayout,sizeof(TW_IMAGELAYOUT),0);
   with ImageLayout.Frame do begin
   	FloatToFIX32(fLeft,@Left);
      FloatToFIX32(fTop,@Top);
      FloatToFIX32(fRight,@Right);
      FloatToFIX32(fBottom,@Bottom);
   end;
   IETW_DS(grec,DG_IMAGE,DAT_IMAGELAYOUT,MSG_SET,@ImageLayout);
   LogWrite('  SetAcquireFrame : end');
end;

///////////////////////////////////////////////////////////////////////////////////////
// get a Fix32 data (one,range,enum,array) and convert to double data
// free and realloc vlist
function GetFix32asDouble(var grec:tgrec; dlist:TIEDoubleList; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
	pvalEnum:pTW_ENUMERATION;
   pvalOneValue:pTW_ONEVALUE;
   pvalArray:pTW_ARRAY;
   pvalRange:pTW_RANGE;
   pfix:pTW_FIX32;
   q:integer;
begin
	result:=true;
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
	dlist.clear;
   LogWrite('GetFix32asDouble');
   case twCapability.ConType of
      TWON_ENUMERATION:
      	begin
	         pvalEnum:=GlobalLock(twCapability.hContainer);
            dlist.Count:=pvalEnum^.NumItems;;
            pfix:=@(pvalEnum^.ItemList[0]);
				for q:=0 to dlist.Count-1 do begin
            	dlist[q]:=pfix^.Whole+pfix^.Frac/65536;
               inc(pfix);
            end;
            dlist.CurrentValue:=dlist[pvalEnum^.CurrentIndex];
         end;
      TWON_ONEVALUE:
      	begin
				pvalOneValue:=GlobalLock(twCapability.hContainer);
            dlist.Count:=1;
            pfix:=@(pvalOneValue^.Item);
            dlist[0]:=pfix^.Whole+pfix^.Frac/65536;
            if ((cap=ICAP_XRESOLUTION) or (cap=ICAP_YRESOLUTION)) and (dlist[0]<0) then
               dlist[0]:=300;   // workaround for some scanner that return invalid resolution values
            dlist.CurrentValue:=dlist[0];
         end;
      TWON_ARRAY:
      	begin
				pvalArray:=GlobalLock(twCapability.hContainer);
            dlist.Count:=pvalArray^.NumItems;
            pfix:=@(pvalArray^.ItemList[0]);
				for q:=0 to dlist.Count-1 do begin
            	dlist[q]:=pfix^.Whole+pfix^.Frac/65536;
               inc(pfix);
            end;
         end;
      TWON_RANGE:
      	begin
				pvalRange:=GlobalLock(twCapability.hContainer);
            pfix:=@(pvalRange^.MinValue);
            dlist.RangeMin:=pfix^.Whole+pfix^.Frac/65536;
            pfix:=@(pvalRange^.MaxValue);
				dlist.RangeMax:=pfix^.Whole+pfix^.Frac/65536;
            pfix:=@(pvalRange^.StepSize);
            dlist.RangeStep:=pfix^.Whole+pfix^.Frac/65536;
            pfix:=@(pvalRange^.CurrentValue);
            dlist.CurrentValue:=pfix^.Whole+pfix^.Frac/65536;
         end;
      else
      	result:=false;
   end;
   GlobalUnlock(twCapability.hContainer);
   GlobalFree(twCapability.hContainer);
   if result then
   	LogWrite('  GetFix32asDouble : ok')
   else
   	LogWrite('  GetFix32asDouble : FAILED!');
end;

///////////////////////////////////////////////////////////////////////////////////////
function GetOneFIX32asDouble(var grec:tgrec; var Value:double; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
   pvalOneValue:pTW_ONEVALUE;
   pfix:pTW_FIX32;
begin
	result:=true;
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   LogWrite('GetOnFIX32asDouble');
	if twCapability.ConType=TWON_ONEVALUE then begin
      pvalOneValue:=GlobalLock(twCapability.hContainer);
      pfix:=@(pvalOneValue^.Item);
      Value:=pfix^.Whole+pfix^.Frac/65536;
      GlobalUnlock(twCapability.hContainer);
   end else
   	result:=false;
   GlobalFree(twCapability.hContainer);
   if result then
   	LogWrite('  GetOneFIX32asDouble : ok')
   else
   	LogWrite('  GetOneFIX32asDouble : FAILED!');
end;

///////////////////////////////////////////////////////////////////////////////////////
// get a UINT16 data (one,range,enum,array) and convert to integer data
// free and realloc vlist
function GetUINT16asInteger(var grec:tgrec; ilist:TIEIntegerList; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
	pvalEnum:pTW_ENUMERATION;
   pvalOneValue:pTW_ONEVALUE;
   pvalArray:pTW_ARRAY;
   pvalRange:pTW_RANGE;
   v16:pTW_UINT16;
   q:integer;
begin
	result:=true;
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
	ilist.Clear;
   LogWrite('GetUINT16asInteger');
   case twCapability.ConType of
      TWON_ENUMERATION:
      	begin
	         pvalEnum:=GlobalLock(twCapability.hContainer);
				ilist.Count:=pvalEnum^.NumItems;
            v16:=@(pvalEnum^.ItemList[0]);
				for q:=0 to ilist.Count-1 do begin
            	ilist[q]:=v16^;
               inc(v16);
            end;
            ilist.CurrentValue:=ilist[pvalEnum^.CurrentIndex];
         end;
      TWON_ONEVALUE:
      	begin
				pvalOneValue:=GlobalLock(twCapability.hContainer);
            ilist.Count:=1;
            v16:=@(pvalOneValue^.Item);
            ilist[0]:=v16^;
            ilist.CurrentValue:=ilist[0];
         end;
      TWON_ARRAY:
      	begin
				pvalArray:=GlobalLock(twCapability.hContainer);
            ilist.Count:=pvalArray^.NumItems;
            v16:=@(pvalArray^.ItemList[0]);
				for q:=0 to ilist.Count-1 do begin
            	ilist[q]:=v16^;
               inc(v16);
            end;
         end;
      TWON_RANGE:
      	begin
				pvalRange:=GlobalLock(twCapability.hContainer);
            v16:=@(pvalRange^.MinValue);
            ilist.RangeMin:=v16^;
            v16:=@(pvalRange^.MaxValue);
				ilist.RangeMax:=v16^;
            v16:=@(pvalRange^.StepSize);
            ilist.RangeStep:=v16^;
            v16:=@(pvalRange^.CurrentValue);
            ilist.CurrentValue:=v16^;
         end;
      else
      	result:=false;
   end;
   GlobalUnlock(twCapability.hContainer);
   GlobalFree(twCapability.hContainer);
   if result then
   	LogWrite('  GetUINT16asInteger : ok')
   else
   	LogWrite('  GetUINT16asInteger : FAILED!');
end;

///////////////////////////////////////////////////////////////////////////////////////
// Supported only TW_ENUMERATION (allowed values and curr.) and TW_ONEVALUE (current value)
function SetIntegerAsUINT16Capability(var grec:tgrec; ilist:TIEIntegerList; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
	pvalEnum:pTW_ENUMERATION;
   pvalOneValue:pTW_ONEVALUE;
	v16:pTW_UINT16;
   q:integer;
begin
	result:=true;
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   LogWrite('SetIntegerAsUINT16Capability');
   GlobalFree(twCapability.hContainer);
   twCapability.Cap:=cap;
   if ielItems in ilist.WasChanged then begin
   	// write TW_ENUMERATION (allowed values and current value)
      twCapability.ConType:=TWON_ENUMERATION;
      twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ENUMERATION)+sizeof(TW_UINT16)*ilist.Count);
		pvalEnum:=GlobalLock(twCapability.hContainer);
      pvalEnum^.ItemType:=TWTY_UINT16;
      pvalEnum^.NumItems:=ilist.Count;
      pvalEnum^.CurrentIndex:=ilist.IndexOf( ilist.CurrentValue );
      v16:=@(pvalEnum^.ItemList[0]);
      for q:=0 to ilist.Count-1 do begin
      	v16^:=ilist[q];
         inc(v16);
		end;
      GlobalUnLock(twCapability.hContainer);
	   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
	   result:= grec.rc=TWRC_SUCCESS;
		GlobalFree(twCapability.hContainer);
   end;
   if ielCurrentValue in ilist.WasChanged then begin
   	// write TW_ONEVALUE (current value only)
      twCapability.ConType:=TWON_ONEVALUE;
      twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ONEVALUE));
		pvalOneValue:=GlobalLock(twCapability.hContainer);
      pvalOneValue^.ItemType:=TWTY_UINT16;
      pvalOneValue^.Item:=ilist.CurrentValue;
      GlobalUnLock(twCapability.hContainer);
	   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
	   result:= grec.rc=TWRC_SUCCESS;
		GlobalFree(twCapability.hContainer);
   end;
   if result then
   	LogWrite('  SetIntegerAsUINT16Capability : ok')
   else
   	LogWrite('  SetIntegerAsUINT16Capability : FAILED!');
end;

///////////////////////////////////////////////////////////////////////////////////////
// Supported only TW_ENUMERATION (allowed values and curr.), TW_ONEVALUE (current value)
// TW_RANGE (allowed values and curr.)
function SetDoubleAsFIX32Capability(var grec:tgrec; dlist:TIEDoubleList; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
	pvalEnum:pTW_ENUMERATION;
   pvalOneValue:pTW_ONEVALUE;
   pvalRange:pTW_RANGE;
	pfix:pTW_FIX32;
   q:integer;
begin
	result:=true;
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   LogWrite('SetDoubleAsFIX32Capability');
   GlobalFree(twCapability.hContainer);
   twCapability.Cap:=cap;
   if ielItems in dlist.WasChanged then begin
   	// write TW_ENUMERATION (allowed values and current value)
      twCapability.ConType:=TWON_ENUMERATION;
      twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ENUMERATION)+sizeof(TW_FIX32)*dlist.Count);
		pvalEnum:=GlobalLock(twCapability.hContainer);
      pvalEnum^.ItemType:=TWTY_FIX32;
      pvalEnum^.NumItems:=dlist.Count;
      pvalEnum^.CurrentIndex:=dlist.IndexOf( dlist.CurrentValue );
      pfix:=@(pvalEnum^.ItemList[0]);
      for q:=0 to dlist.Count-1 do begin
      	FloatToFIX32(dlist[q],pfix);
         inc(pfix);
		end;
      GlobalUnLock(twCapability.hContainer);
	   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
	   result:= grec.rc=TWRC_SUCCESS;
		GlobalFree(twCapability.hContainer);
   end;
   if ielCurrentValue in dlist.WasChanged then begin
   	// write TW_ONEVALUE (current value only)
      twCapability.ConType:=TWON_ONEVALUE;
      twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ONEVALUE));
		pvalOneValue:=GlobalLock(twCapability.hContainer);
      pvalOneValue^.ItemType:=TWTY_FIX32;
		FloatToFIX32(dlist.CurrentValue,@pvalOneValue^.Item);
      GlobalUnLock(twCapability.hContainer);
	   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
	   result:= grec.rc=TWRC_SUCCESS;
		GlobalFree(twCapability.hContainer);
   end;
   if ielRange in dlist.WasChanged then begin
   	// write TW_RANGE (allowed values and current)
      twCapability.ConType:=TWON_RANGE;
      twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_RANGE));
		pvalRange:=GlobalLock(twCapability.hContainer);
      pvalRange^.ItemType:=TWTY_FIX32;
		FloatToFIX32(dlist.CurrentValue,@pvalRange^.CurrentValue);
      FloatToFIX32(dlist.RangeMin,@pvalRange^.MinValue);
      FloatToFIX32(dlist.RangeMax,@pvalRange^.MaxValue);
      FloatToFIX32(dlist.RangeStep,@pvalRange^.StepSize);
      GlobalUnLock(twCapability.hContainer);
	   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
	   result:= grec.rc=TWRC_SUCCESS;
		GlobalFree(twCapability.hContainer);
   end;
   if result then
   	LogWrite('  SetDoubleAsFIX32Capability : ok')
   else
   	LogWrite('  SetDoubleAsFIX32Capability : FAILED!');
end;

///////////////////////////////////////////////////////////////////////////////////////
// Supported TW_ONEVALUE (current value)
function SetOneDoubleAsFIX32Capability(var grec:tgrec; value:double; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
   pvalOneValue:pTW_ONEVALUE;
begin
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   LogWrite('SetOneDoubleAsFIX32Capability');
   GlobalFree(twCapability.hContainer);
   twCapability.Cap:=cap;
   // write TW_ONEVALUE (current value only)
   twCapability.ConType:=TWON_ONEVALUE;
   twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ONEVALUE));
   pvalOneValue:=GlobalLock(twCapability.hContainer);
   pvalOneValue^.ItemType:=TWTY_FIX32;
   FloatToFIX32(value,@pvalOneValue^.Item);
   GlobalUnLock(twCapability.hContainer);
   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
   result:= grec.rc=TWRC_SUCCESS;
   GlobalFree(twCapability.hContainer);
   if result then
   	LogWrite('  SetOneDoubleAsFIX32Capability : ok')
   else
   	LogWrite('  SetOneDoubleAsFIX32Capability : FAILED!');
end;

///////////////////////////////////////////////////////////////////////////////////////
// Supported TW_ONEVALUE (current value)
function SetOneUINT16Capability(var grec:tgrec; value:word; cap:TW_UINT16):boolean;
var
	twCapability:TW_CAPABILITY;
   pvalOneValue:pTW_ONEVALUE;
	pv16:pTW_UINT16;
begin
	if not GetCapability(grec,twCapability,cap) then begin
   	result:=false;
   	exit;
   end;
   LogWrite('SetOneUINT16Capability');
   GlobalFree(twCapability.hContainer);
   twCapability.Cap:=cap;
   // write TW_ONEVALUE (current value only)
   twCapability.ConType:=TWON_ONEVALUE;
   twCapability.hContainer:=GlobalAlloc(GHND,sizeof(TW_ONEVALUE));
   pvalOneValue:=GlobalLock(twCapability.hContainer);
   pvalOneValue^.ItemType:=TWTY_UINT16;
   pv16:=@(pvalOneValue^.Item);
	pv16^:=value;
   GlobalUnLock(twCapability.hContainer);
   IETW_DS(grec,DG_CONTROL,DAT_CAPABILITY,MSG_SET,@twCapability);
   result:= grec.rc=TWRC_SUCCESS;
   GlobalFree(twCapability.hContainer);
   if result then
   	LogWrite('  SetOneUINT16Capability : ok')
   else
   	LogWrite('  SetOneUINT16Capability : FAILED!');
end;

///////////////////////////////////////////////////////////////////////////////////////
// Need source loaded
function IETW_SetCapabilities(var grec:tgrec):boolean;
var
	Units:TIEIntegerList;
   xbuf:boolean;
   xfer:TIEIntegerList;
   chunk:TIEIntegerList;
   itmp:TIEIntegerList;
begin
	LogWrite('IETW_SetCapabilities');
   if not grec.TWParams.CompatibilityMode then begin
      // set ICAPS_UNITS first
      LogWrite('  IETW_SetCapabilities : ICAP_UNITS');
      Units:=TIEIntegerList.Create;
      if GetUINT16asInteger(grec,Units,ICAP_UNITS) and (Units.CurrentValue<>0) then begin
         Units.CurrentValue:=0;
         SetIntegerAsUINT16Capability(grec,Units,ICAP_UNITS);
      end;
      Units.free;
      // ICAP_PIXELFLAVOR
      LogWrite('  IETW_SetCapabilities : ICAP_PIXELFLAVOR');
      SetOneUINT16Capability(grec,TWPF_CHOCOLATE,ICAP_PIXELFLAVOR);
      itmp:=TIEIntegerList.Create;
      if GetUINT16asInteger(grec,itmp,ICAP_PIXELFLAVOR) then
         grec.BWToInvert:= itmp.CurrentValue=TWPF_VANILLA
      else
         grec.BWToInvert:= false; // not supported capability, assume TWPF_CHOCOLATE
      itmp.free;
      // ICAP_UNDEFINEDIMAGESIZE
      if grec.TWParams.UndefinedImageSize then begin
         LogWrite('  IETW_SetCapabilities : ICAP_UNDEFINEDIMAGESIZE');
         SetOneBoolCapability(grec,true,ICAP_UNDEFINEDIMAGESIZE);
      end;
      // ICAP_CONTRAST
      if grec.TWParams.Contrast.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_CONTRAST');
         SetDoubleAsFIX32Capability(grec,grec.TWParams.Contrast,ICAP_CONTRAST);
      end;
      // ICAP_BRIGHTNESS
      if grec.TWParams.Brightness.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_BRIGHTNESS');
         SetDoubleAsFIX32Capability(grec,grec.TWParams.Brightness,ICAP_BRIGHTNESS);
      end;
      // ICAP_THRESHOLD
      if grec.TWParams.Threshold<>128 then begin
         LogWrite('  IETW_SetCapabilities : ICAP_THRESHOLD');
         SetOneDoubleAsFIX32Capability(grec,grec.TWParams.Threshold,ICAP_THRESHOLD);
      end;
      // ICAP_ROTATION
      if grec.TWParams.Rotation<>0 then begin
         LogWrite('  IETW_SetCapabilities : ICAP_ROTATION');
         SetOneDoubleAsFIX32Capability(grec,grec.TWParams.Rotation,ICAP_ROTATION);
      end;
      //
      if grec.TWParams.XResolution.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_XRESOLUTION');
         SetDoubleAsFIX32Capability(grec,grec.TWParams.XResolution,ICAP_XRESOLUTION);
      end;
      if grec.TWParams.YResolution.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_YRESOLUTION');
         SetDoubleAsFIX32Capability(grec,grec.TWParams.YResolution,ICAP_YRESOLUTION);
      end;
      if grec.TWParams.XScaling.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_XSCALING');
         SetDoubleAsFIX32Capability(grec,grec.TWParams.XScaling,ICAP_XSCALING);
      end;
      if grec.TWParams.YScaling.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_YSCALING');
         SetDoubleAsFIX32Capability(grec,grec.TWParams.YScaling,ICAP_YSCALING);
      end;
      // Pixel type
      // note: ImageEn buffer xfer supports BW(1bit), GRAYSCALE (8bit), RGB (8x3bit)
      if grec.TWParams.PixelType.CurrentValue>2 then
         grec.TWParams.PixelType.CurrentValue:=2;	// force to RGB when type is PALETTE...CIEXYZ
      LogWrite('  IETW_SetCapabilities : ICAP_PIXELTYpe');
      xbuf:=SetIntegerAsUINT16Capability(grec,grec.TWParams.PixelType,ICAP_PIXELTYPE);
      // set Chunky mode
      chunk:=TIEIntegerList.Create;
      GetUINT16asInteger(grec,chunk,ICAP_PLANARCHUNKY);
      if chunk.CurrentValue<>TWPC_CHUNKY then begin
         if xbuf and (grec.TWParams.PixelType.CurrentValue=2) then begin
            LogWrite('  IETW_SetCapabilities : TWPC_CHUNKY - ICAP_PLANARCHUNKY');
            xbuf:=SetOneUINT16Capability(grec,TWPC_CHUNKY,ICAP_PLANARCHUNKY);
         end;
      end;
      chunk.free;
      // set "memory mode transfer"
      if (grec.TransferMode=tmBuffered) and xbuf then begin
         xfer:=TIEIntegerList.Create;
         GetUINT16asInteger(grec,xfer,ICAP_XFERMECH);
         if xfer.IndexOf(TWSX_MEMORY)<0 then
            grec.TransferMode:=tmNative	// do not support memory transfer (buffered transfer)
         else begin
            LogWrite('  IETW_SetCapabilities : TWSX_MEMORY - ICAP_XFERMECH');
            if not SetOneUINT16Capability(grec,TWSX_MEMORY,ICAP_XFERMECH) then
               grec.TransferMode:=tmNative
            else begin
               xfer.Clear;
               GetUINT16asInteger(grec,xfer,ICAP_XFERMECH);
               if xfer.CurrentValue<>TWSX_MEMORY then
                  grec.TransferMode:=tmNative;
            end;
         end;
         xfer.free;
      end else
         if grec.TransferMode<>tmFile then
            grec.TransferMode:=tmNative;
      //
      LogWrite('  IETW_SetCapabilities : CAP_FEEDERENABLED');
      SetOneBoolCapability(grec,grec.TWParams.FeederEnabled,CAP_FEEDERENABLED);
      if grec.TWParams.FeederEnabled then begin
         LogWrite('  IETW_SetCapabilities : CAP_AUTOFEED');
         SetOneBoolCapability(grec,grec.TWParams.AutoFeed,CAP_AUTOFEED);
      end;
      if grec.TWParams.Orientation.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_ORIENTATION');
         SetIntegerAsUINT16Capability(grec,grec.TWParams.Orientation,ICAP_ORIENTATION);
      end;
      if grec.TWParams.StandardSize.WasChanged<>[] then begin
         LogWrite('  IETW_SetCapabilities : ICAP_SUPPORTEDSIZES');
         SetIntegerAsUINT16Capability(grec,grec.TWParams.StandardSize,ICAP_SUPPORTEDSIZES);
      end;
      LogWrite('  IETW_SetCapabilities : CAP_INDICATORS');
      SetOneBoolCapability(grec,grec.TWParams.ProgressIndicators,CAP_INDICATORS);
      LogWrite('  IETW_SetCapabilities : CAP_DUPLEXENABLED');
      SetOneBoolCapability(grec,grec.TWParams.DuplexEnabled,CAP_DUPLEXENABLED);
      if grec.TWParams.AcquireFrameEnabled then
         with grec.TWParams do begin
            LogWrite('  IETW_SetCapabilities : SETACQUIREFRAME');
            SetAcquireFrame(grec,AcquireFrameLeft,AcquireFrameTop,AcquireFrameRight,AcquireFrameBottom);
         end;
   end else begin
   	// compatibility mode
      grec.TransferMode:=tmFile;
   end;
	result:=true;
   LogWrite('  IETW_SetCapabilities : end');
end;

///////////////////////////////////////////////////////////////////////////////////////
// Bitmap is nil for multipage acquisition
function IETW_Acquire(Bitmap:TIEBitmap; multi:boolean; MultiCallBack:TIEMultiCallBack; Params:TIETWainParams; IOParams:TIOParamsVals; var Progress:TProgressRec; TWainShared:PIETWainShared; callwnd:HWND):boolean;
var
	grec:tgrec;
   wnd:HWND;
begin
	try
	result:=false;
	Init_grec(grec);
   grec.callwnd:=callwnd;
   grec.PTWainShared:=TWainShared;
   grec.modal:=true;
   with grec do begin
   	transferdone:=false;
      bHideUI:=not Params.VisibleDialog;
      gmulti:=multi;
      TWParams:=Params;
   end;
   LogWrite('IETW_Acquire');
   grec.IOParams:=IOParams;
   grec.fBitmap:=Bitmap;
   if Params.CompatibilityMode then
   	Params.FileTransfer:=true;
   if Params.FileTransfer then
   	grec.TransferMode:=tmFile
   else if Params.BufferedTransfer then
   	grec.TransferMode:=tmBuffered
   else
   	grec.TransferMode:=tmNative;
   grec.MultiCallBack:=MultiCallBack;
   grec.Progress:=@Progress;
   Set_AppId(grec);
	ClearError(grec);			// clear error detail
	wnd := CreateProxyWindow(grec);
	if (not IETW_LoadSourceManager(grec)) then begin
    	DestroyProxyWindow(wnd,grec,false);
      exit;
	end;
   if (not IETW_OpenSourceManager(grec,wnd)) then begin
	   IETW_UnloadSourceManager(grec,false);
    	DestroyProxyWindow(wnd,grec,false);
      exit;
   end;
   if (not IETW_OpenSource(grec)) then begin
	   IETW_CloseSourceManager(grec,wnd);
	   IETW_UnloadSourceManager(grec,false);
  	 	DestroyProxyWindow(wnd,grec,false);
      exit;
	end;
   if (not IETW_SetCapabilities(grec)) then begin
		IETW_CloseSource(grec);
	   IETW_CloseSourceManager(grec,wnd);
	   IETW_UnloadSourceManager(grec,false);
    	DestroyProxyWindow(wnd,grec,false);
      exit;
	end;
   if (not IETW_EnableSource(grec,wnd)) then begin
		IETW_CloseSource(grec);
	   IETW_CloseSourceManager(grec,wnd);
	   IETW_UnloadSourceManager(grec,false);
    	DestroyProxyWindow(wnd,grec,false);
   	exit
	end;
   EnableWindow(wnd, FALSE);
	// source is enabled, wait for transfer or source closed
   try
	IETW_ModalEventLoop(grec);
   finally
		EnableWindow(wnd, TRUE);
   end;
	// shut everything down in the right sequence
	// these routines do nothing if the corresponding 'open' failed
  	IETW_DisableSource(grec);
	IETW_CloseSource(grec);
	IETW_CloseSourceManager(grec,wnd);
   IETW_UnloadSourceManager(grec,false);
   DestroyProxyWindow(wnd,grec,false);
   // invert black/white image if necessary
   if assigned(Bitmap) and (Bitmap.PixelFormat=ie1g) and grec.BWToInvert then
      _Negative1BitEx(Bitmap);
   //
   result:=grec.transferdone;
   LogWrite('  IETW_Acquire : end');
   finally
   	if grec.fWindowList<>nil then
      	EnableTaskWindows(grec.fWindowList);
   	windows.setactivewindow(grec.actwnd);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
// if setcap is True then set capabilities and doesn't change the "Changed" field of the lists
// return false if fails
function IETW_GetCapabilities(Params:TIETWainParams; var Capabilities:TIETWSourceCaps; setcap:boolean; TWainShared:PIETWainShared; callwnd:HWND):boolean;
var
	grec:tgrec;
   wnd:HWND;
	Units:TIEIntegerList;
   the:double;
   fXResolutionChanged:TIEListChanges;
   fYResolutionChanged:TIEListChanges;
   fXScalingChanged:TIEListChanges;
   fYScalingChanged:TIEListChanges;
   fPixelTypeChanged:TIEListChanges;
   fOrientationChanged:TIEListChanges;
   fContrastChanged:TIEListChanges;
   fBrightnessChanged:TIEListChanges;
   fStandardSizeChanged:TIEListChanges;
begin
	result:=false;
	try
	Init_grec(grec);
   grec.callwnd:=callwnd;
   grec.PTWainShared:=TWainShared;
   grec.TWParams:=Params;
   if Params.CompatibilityMode then
   	Params.FileTransfer:=true;
   if Params.FileTransfer then
   	grec.TransferMode:=tmFile
   else if Params.BufferedTransfer then
   	grec.TransferMode:=tmBuffered
   else
   	grec.TransferMode:=tmNative;
	ClearError(grec);			// clear error detail

	wnd := CreateProxyWindow(grec);

	if (not IETW_LoadSourceManager(grec)) then begin
    	DestroyProxyWindow(wnd,grec,false);
      exit;
	end;
   if (not IETW_OpenSourceManager(grec,wnd)) then begin
	   IETW_UnloadSourceManager(grec,false);
    	DestroyProxyWindow(wnd,grec,false);
      exit;
   end;
   if (not IETW_OpenSource(grec)) then begin
	   IETW_CloseSourceManager(grec,wnd);
	   IETW_UnloadSourceManager(grec,false);
  	 	DestroyProxyWindow(wnd,grec,false);
      exit;
	end;
   if setcap then
	   IETW_SetCapabilities(grec);
   with grec, Capabilities do begin
 	   fXResolutionChanged:=fXResolution.WasChanged;
   	fYResolutionChanged:=fYResolution.WasChanged;
   	fXScalingChanged:=fXScaling.WasChanged;
   	fYScalingChanged:=fYScaling.WasChanged;
 	   fPixelTypeChanged:=fPixelType.WasChanged;
   	fOrientationChanged:=fOrientation.WasChanged;
  	 	fContrastChanged:=fContrast.WasChanged;
  	 	fBrightnessChanged:=fBrightness.WasChanged;
   	fStandardSizeChanged:=fStandardSize.WasChanged;
   	if not Params.CompatibilityMode then begin
         // set ICAPS_UNITS first
         Units:=TIEIntegerList.Create;
         if GetUINT16asInteger(grec,Units,ICAP_UNITS) and (Units.CurrentValue<>0) then begin
            Units.CurrentValue:=0;
            SetIntegerAsUINT16Capability(grec,Units,ICAP_UNITS);
         end;
         Units.free;
      end;
      // ICAP_XRESOLUTION
		if not GetFix32asDouble(grec,fXResolution,ICAP_XRESOLUTION) then
      	fXResolution.Clear;
      // ICAP_YRESOLUTION
      if not GetFix32asDouble(grec,fYResolution,ICAP_YRESOLUTION) then
      	fYResolution.Clear;
      if not Params.CompatibilityMode then begin
         // ICAP_XSCALING
         if not GetFix32asDouble(grec,fXScaling,ICAP_XSCALING) then begin
            fXScaling.Clear;
            fXScaling.Add(1);
         end;
         // ICAP_YSCALING
         if not GetFix32asDouble(grec,fYScaling,ICAP_YSCALING) then begin
            fYScaling.Clear;
            fYScaling.Add(1);
         end;
         // ICAP_CONTRAST
         if not GetFix32asDouble(grec,fContrast,ICAP_CONTRAST) then
            fContrast.Clear;
         // ICAP_BRIGHTNESS
         if not GetFix32asDouble(grec,fBrightness,ICAP_BRIGHTNESS) then
            fBrightness.Clear;
         // ICAP_THRESHOLD
         if not GetOneFIX32asDouble(grec,the,ICAP_THRESHOLD) then
            the:=128;
         fThreshold:=trunc(the);
         // ICAP_ROTATION
         if not GetOneFIX32asDouble(grec,the,ICAP_ROTATION) then
            the:=0;
         fRotation:=trunc(the);
         // ICAP_PIXELTYPE
         if not GetUINT16asinteger(grec,fPixelType,ICAP_PIXELTYPE) then
            fPixelType.Clear;
         // ICAP_GAMMA
         if not GetOneFIX32asDouble(grec,fGamma,ICAP_GAMMA) then
            fGamma:=2.2;
         // ICAP_PHYSICALHEIGHT
         if not GetOneFIX32asDouble(grec,fPhysicalHeight,ICAP_PHYSICALHEIGHT) then
            fPhysicalHeight:=0;
         // ICAP_PHYSICALWIDTH
         if not GetOneFIX32asDouble(grec,fPhysicalWidth,ICAP_PHYSICALWIDTH) then
            fPhysicalWidth:=0;
         // CAP_FEEDERENABLED
         if not GetOneBOOL(grec,fFeederEnabled,CAP_FEEDERENABLED) then
            fFeederEnabled:=false;
         // CAP_AUTOFEED
         if not GetOneBOOL(grec,fAutoFeed,CAP_AUTOFEED) then
            fAutoFeed:=false;
         // CAP_FEEDERLOADED
         if not GetOneBOOL(grec,fFeederLoaded,CAP_FEEDERLOADED) then
            fFeederLoaded:=false;
         // CAP_PAPERDETECTABLE
         if not GetOneBOOL(grec,fPaperDetectable,CAP_PAPERDETECTABLE) then
            fPaperDetectable:=false;
         // CAP_DUPLEXENABLED
         if not GetOneBOOL(grec,fDuplexEnabled,CAP_DUPLEXENABLED) then
            fDuplexEnabled:=false;
         // CAP_DUPLEX
         if not GetOneBOOL(grec,fDuplexSupported,CAP_DUPLEX) then
            fDuplexSupported:=false;
         // ICAP_ORIENTATION
         if not GetUINT16asInteger(grec,fOrientation,ICAP_ORIENTATION) then begin
            fOrientation.Clear;
            fOrientation.Add(TWOR_PORTRAIT);
         end;
         // ICAP_SUPPORTEDSIZES (renamed as StandardSize)
         if not GetUINT16asInteger(grec,fStandardSize,ICAP_SUPPORTEDSIZES) then
            fStandardSize.Clear;
         // CAP_INDICATORS
         if not GetOneBOOL(grec,fIndicators,CAP_INDICATORS) then
            fIndicators:=True;
         // Acquire Frame
         if fAcquireFrameEnabled then
            GetAcquireFrame(grec,fAcquireFrame);
         // clear Changed property of lists
         if not setcap then begin
            fXResolution.WasChanged:=[];
            fYResolution.WasChanged:=[];
            fXScaling.WasChanged:=[];
            fYScaling.WasChanged:=[];
            fPixelType.WasChanged:=[];
            fOrientation.WasChanged:=[];
            fContrast.WasChanged:=[];
            fBrightness.WasChanged:=[];
            fStandardSize.WasChanged:=[];
         end else begin
            fXResolution.WasChanged:=fXResolutionChanged;
            fYResolution.WasChanged:=fYResolutionChanged;
            fXScaling.WasChanged:=fXScalingChanged;
            fYScaling.WasChanged:=fYScalingChanged;
            fPixelType.WasChanged:=fPixelTypeChanged;
            fOrientation.WasChanged:=fOrientationCHanged;
            fContrast.WasChanged:=fContrastChanged;
            fBrightness.WasChanged:=fBrightnessChanged;
            fStandardSize.WasChanged:=fStandardSizeChanged;
         end;
      end;
	end;

	IETW_CloseSource(grec);
   IETW_CloseSourceManager(grec,wnd);
   IETW_UnloadSourceManager(grec,false);

  	DestroyProxyWindow(wnd,grec,false);
   result:=true;
   finally
   	windows.setactivewindow(grec.actwnd);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
// rest. ProductName del source di default
function IETW_GetDefaultSource(TWainShared:PIETWainShared; callwnd:HWND):AnsiString;
var
   NewSourceId:TW_IDENTITY;
   grec:tgrec;
   wnd:HWND;
begin
	result:='';
	Init_grec(grec);
	try
   grec.callwnd:=callwnd;
   grec.PTWainShared:=TWainShared;
   wnd:=CreateProxyWindow(grec);
   if IETW_LoadSourceManager(grec) then begin
      if IETW_OpenSourceManager(grec,wnd) then begin
         fillmemory(@NewSourceId, sizeof(NewSourceId),0);
         // Post the Select Source dialog
         if IETW_Mgr(grec,DG_CONTROL, DAT_IDENTITY, MSG_GETDEFAULT, @NewSourceId) then
	         result:=NewSourceId.ProductName;
         IETW_CloseSourceManager(grec,wnd);
       end else begin
        	DestroyProxyWindow(wnd,grec,false);
         exit;
       end;
       IETW_UnloadSourceManager(grec,false);
   end;
  	DestroyProxyWindow(wnd,grec,false);
   finally
   	windows.setactivewindow(grec.actwnd);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
// unload sourcemanager
procedure IETW_FreeResources(TWainShared:PIETWainShared; callwnd:HWND);
var
   grec:tgrec;
begin
	Init_grec(grec);
   grec.callwnd:=callwnd;
   grec.PTWainShared:=TWainShared;
   if grec.PTWainShared^.hproxy<>0 then
		DestroyProxyWindow(0,grec,true);
   if grec.PTWainShared^.hDSMLib<>0 then
	   IETW_UnloadSourceManager(grec,true);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
// New implementation
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

procedure _IETWAINAcquireClose(var grec:pointer); forward;

type TIEProxyWin=class(TWinControl)
   public
		grec:pgrec;
      constructor NewCreate(AOwner: TComponent; xgrec:pgrec);
      destructor Destroy; override;
      procedure WndProc(var Message: TMessage); override;
end;

constructor TIEProxyWin.NewCreate(AOwner: TComponent; xgrec:pgrec);
begin
	inherited Create(AOwner);
	grec:=xgrec;
end;

destructor TIEProxyWin.Destroy;
begin
   _IETWAINAcquireClose(pointer(grec));
	inherited;
end;

procedure TIEProxyWin.WndProc(var Message: TMessage);
var
	msg:TMSG;
begin
	msg.hwnd:=handle;
   msg.message:=Message.Msg;
   msg.wParam:=Message.WParam;
   msg.lParam:=Message.LParam;
	if (not assigned(grec)) or (grec^.nState<5) or (not IETW_MessageHook(grec^,@msg)) then
		inherited WndProc(Message);
end;

function IETWAINAcquireOpen(CloseCallBack:TIETWCloseCallBack; MultiCallBack:TIEMultiCallBack; Params:TIETWainParams; TWainShared:PIETWainShared; IOParams:TIOParamsVals; parent:TWinControl):pointer;
var
	grec:pgrec;
begin
	new(grec);
	Init_grec(grec^);
   with grec^ do begin
   	transferdone:=false;
      bHideUI:=not Params.VisibleDialog;
      TWParams:=Params;
   end;
   grec.PTWainShared:=TWainShared;
   grec.modal:=false;
   grec.IOParams:=IOParams;
   if Params.FileTransfer then
   	grec.TransferMode:=tmFile
   else if Params.BufferedTransfer then
   	grec.TransferMode:=tmBuffered
   else
   	grec.TransferMode:=tmNative;
   grec.MultiCallBack:=MultiCallBack;
   grec.Progress:=nil;
   grec.gmulti:=true;
   grec.fclosecallback:=CloseCallBack;
   Set_AppId(grec^);
	ClearError(grec^);			// clear error detail
   // create proxy window
   grec^.ProxyWin:=TIEProxyWin.NewCreate(parent,grec);
   grec^.ProxyWin.Parent:=parent;
	if (not IETW_LoadSourceManager(grec^)) then begin
   	grec.ProxyWin.free;
      //dispose(grec);	// already disposes by ProxyWin.free
      result:=nil;
      exit;
	end;
   if (not IETW_OpenSourceManager(grec^,grec.ProxyWin.Handle)) then begin
	   IETW_UnloadSourceManager(grec^,false);
      grec.ProxyWin.free;
      dispose(grec);
      result:=nil;
      exit;
   end;
   if (not IETW_OpenSource(grec^)) then begin
	   IETW_CloseSourceManager(grec^,grec.ProxyWin.Handle);
	   IETW_UnloadSourceManager(grec^,false);
  	 	grec.ProxyWin.free;
      //dispose(grec);	// already disposes by ProxyWin.free
      result:=nil;
      exit;
	end;
   if (not IETW_SetCapabilities(grec^)) then begin
		IETW_CloseSource(grec^);
	   IETW_CloseSourceManager(grec^,grec.ProxyWin.Handle);
	   IETW_UnloadSourceManager(grec^,false);
    	grec.ProxyWin.free;
      //dispose(grec);	// already disposes by ProxyWin.free
      result:=nil;
      exit;
	end;
   if (not IETW_EnableSource(grec^,grec.ProxyWin.Handle)) then begin
		IETW_CloseSource(grec^);
	   IETW_CloseSourceManager(grec^,grec.ProxyWin.Handle);
	   IETW_UnloadSourceManager(grec^,false);
    	grec.ProxyWin.free;
      //dispose(grec);	// already disposes by ProxyWin.free
      result:=nil;
   	exit
	end;
   result:=grec;
end;

// important: ProxyWin will be destroyed by parent!!!
//             otherwise you can destroy it calling this function!
// called from external (then ProxyWin is not in destroying state)
procedure IETWAINAcquireClose(var grec:pointer);
begin
   pgrec(grec)^.ProxyWin.free;
end;

// called from TIEProxyWin (ProxyWin must be in destroying state)
procedure _IETWAINAcquireClose(var grec:pointer);
var
	closecallback:TIETWCloseCallBack;
begin
  	IETW_DisableSource(pgrec(grec)^);
	IETW_CloseSource(pgrec(grec)^);
   IETW_CloseSourceManager(pgrec(grec)^,pgrec(grec)^.hwnd32SM);
   IETW_UnloadSourceManager(pgrec(grec)^,true);
   closecallback:=pgrec(grec)^.fclosecallback;
   dispose(grec);
	closecallback;
   grec:=nil;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////


{$else} // {$ifdef IEINCLUDETWAIN}

interface
implementation

{$endif}

end.
