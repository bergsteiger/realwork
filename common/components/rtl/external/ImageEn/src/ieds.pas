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

unit ieds;

{$R-}
{$Q-}


{$I ie.inc}


interface


{$ifdef IEINCLUDEDIRECTSHOW}

uses Windows, Classes, Sysutils, Graphics, hyieutils, hyiedefs, iewia, imageenproc, dialogs;

const
   IEEC_COMPLETE                         =$01;
   IEEC_USERABORT                        =$02;
   IEEC_ERRORABORT                       =$03;
   IEEC_TIME                             =$04;
   IEEC_REPAINT                          =$05;
   IEEC_STREAM_ERROR_STOPPED             =$06;
   IEEC_STREAM_ERROR_STILLPLAYING        =$07;
   IEEC_ERROR_STILLPLAYING               =$08;
   IEEC_PALETTE_CHANGED                  =$09;
   IEEC_VIDEO_SIZE_CHANGED               =$0A;
   IEEC_QUALITY_CHANGE                   =$0B;
   IEEC_SHUTTING_DOWN                    =$0C;
   IEEC_CLOCK_CHANGED                    =$0D;
   IEEC_PAUSED                           =$0E;
   IEEC_OPENING_FILE	                  =$10;
   IEEC_BUFFERING_DATA                   =$11;
   IEEC_FULLSCREEN_LOST                  =$12;
   IEEC_ACTIVATE                         =$13;
   IEEC_NEED_RESTART                     =$14;
   IEEC_WINDOW_DESTROYED                 =$15;
   IEEC_DISPLAY_CHANGED                  =$16;
   IEEC_STARVATION                       =$17;
   IEEC_OLE_EVENT			    				=$18;
   IEEC_NOTIFY_WINDOW                    =$19;
   IEEC_STREAM_CONTROL_STOPPED	    		=$1A;
   IEEC_STREAM_CONTROL_STARTED	    		=$1B;
   IEEC_END_OF_SEGMENT                   =$1C;
   IEEC_SEGMENT_STARTED                  =$1D;
   IEEC_LENGTH_CHANGED                  	=$1E;
   IEEC_DEVICE_LOST                     	=$1f;
   IEEC_STEP_COMPLETE                    =$24;
   IEEC_SKIP_FRAMES                      =$25;
   IEEC_TIMECODE_AVAILABLE					=$30;
   IEEC_EXTDEVICE_MODE_CHANGE				=$31;
   IEEC_GRAPH_CHANGED                    =$50;
   IEEC_CLOCK_UNSET                      =$51;


type

	IEREFERENCE_TIME=packed record
   	lo32:dword;
      hi32:dword;
   end;
	PIEREFERENCE_TIME=^IEREFERENCE_TIME;

   ISequentialStream = interface(IUnknown)
      ['{0c733a30-2a1c-11ce-ade5-00aa0044773d}']
      function Read: HResult; stdcall;
      function Write: HResult; stdcall;
  	end;

   IStream = interface(ISequentialStream)
      ['{0000000C-0000-0000-C000-000000000046}']
      function Seek: HResult; stdcall;
      function SetSize: HResult; stdcall;
      function CopyTo: HResult; stdcall;
      function Commit: HResult; stdcall;
      function Revert: HResult; stdcall;
      function LockRegion: HResult; stdcall;
      function UnlockRegion: HResult; stdcall;
      function Stat: HResult; stdcall;
      function Clone: HResult; stdcall;
  	end;

   IStorage = interface(IUnknown)
   	['{0000000B-0000-0000-C000-000000000046}']
    	function CreateStream(pwcsName: PWideChar; grfMode: Longint; reserved1: Longint; reserved2: Longint; out stm: IStream): HResult; stdcall;
    	function OpenStream: HResult; stdcall;
      function CreateStorage: HResult; stdcall;
      function OpenStorage: HResult; stdcall;
      function CopyTo: HResult; stdcall;
      function MoveElementTo: HResult; stdcall;
      function Commit(grfCommitFlags: Longint): HResult; stdcall;
      function Revert: HResult; stdcall;
      function EnumElements: HResult; stdcall;
      function DestroyElement: HResult; stdcall;
      function RenameElement: HResult; stdcall;
      function SetElementTimes: HResult; stdcall;
      function SetClass: HResult; stdcall;
      function SetStateBits: HResult; stdcall;
      function Stat: HResult; stdcall;
  	end;

	IPersist = interface(IUnknown)
   	['{0000010C-0000-0000-C000-000000000046}']
      function GetClassID(*(out classID: TCLSID)*): HResult; stdcall;
   end;

	IPersistStream = interface(IPersist)
      ['{00000109-0000-0000-C000-000000000046}']
      function IsDirty: HResult; stdcall;
      function Load(const stm: IStream): HResult; stdcall;
      function Save(const stm: IStream; fClearDirty: BOOL): HResult; stdcall;
      function GetSizeMax: HResult; stdcall;
  	end;
  	IID_IPersistStream=IPersistStream;


	IEnumMoniker = interface(IUnknown)
      ['{00000102-0000-0000-C000-000000000046}']
      function Next(celt: Longint; out elt; pceltFetched: PLongint): HResult; stdcall;
      function Skip(*(celt: Longint)*): HResult; stdcall;
      function Reset: HResult; stdcall;
      function Clone(*(out enm: IEnumMoniker)*): HResult; stdcall;
   end;

   IBindCtx = interface(IUnknown)
      ['{0000000E-0000-0000-C000-000000000046}']
      function RegisterObjectBound(*(const unk: IUnknown)*): HResult; stdcall;
      function RevokeObjectBound(*(const unk: IUnknown)*): HResult; stdcall;
      function ReleaseBoundObjects: HResult; stdcall;
      function SetBindOptions(*(const bindopts: TBindOpts)*): HResult; stdcall;
      function GetBindOptions(*(var bindopts: TBindOpts)*): HResult; stdcall;
      function GetRunningObjectTable(*(out rot: IRunningObjectTable)*): HResult; stdcall;
      function RegisterObjectParam(*(pszKey: POleStr; const unk: IUnknown)*): HResult; stdcall;
      function GetObjectParam(*(pszKey: POleStr; out unk: IUnknown)*): HResult; stdcall;
      function EnumObjectParam(*(out Enum: IEnumString)*): HResult; stdcall;
      function RevokeObjectParam(*(pszKey: POleStr)*): HResult; stdcall;
   end;


   IMoniker = interface(IPersistStream)
      ['{0000000F-0000-0000-C000-000000000046}']
      function BindToObject(const bc: IBindCtx; const mkToLeft: IMoniker; const iidResult: TGUID; out vResult): HResult; stdcall;
      function BindToStorage(const bc: IBindCtx; const mkToLeft: IMoniker; const iid: TGUID; out vObj): HResult; stdcall;
      function Reduce(*(const bc: IBindCtx; dwReduceHowFar: Longint; mkToLeft: PIMoniker; out mkReduced: IMoniker)*): HResult; stdcall;
      function ComposeWith(*(const mkRight: IMoniker; fOnlyIfNotGeneric: BOOL; out mkComposite: IMoniker)*): HResult; stdcall;
      function Enum(*(fForward: BOOL; out enumMoniker: IEnumMoniker)*): HResult; stdcall;
      function IsEqual(*(const mkOtherMoniker: IMoniker)*): HResult; stdcall;
      function Hash(*(out dwHash: Longint)*): HResult; stdcall;
      function IsRunning(*(const bc: IBindCtx; const mkToLeft: IMoniker; const mkNewlyRunning: IMoniker)*): HResult; stdcall;
      function GetTimeOfLastChange(*(const bc: IBindCtx; const mkToLeft: IMoniker; out filetime: TFileTime)*): HResult; stdcall;
      function Inverse(*(out mk: IMoniker)*): HResult; stdcall;
      function CommonPrefixWith(*(const mkOther: IMoniker; out mkPrefix: IMoniker)*): HResult; stdcall;
      function RelativePathTo(*(const mkOther: IMoniker; out mkRelPath: IMoniker)*): HResult; stdcall;
      function GetDisplayName(*(const bc: IBindCtx; const mkToLeft: IMoniker; out pszDisplayName: POleStr)*): HResult; stdcall;
      function ParseDisplayName(*(const bc: IBindCtx; const mkToLeft: IMoniker; pszDisplayName: POleStr; out chEaten: Longint; out mkOut: IMoniker)*): HResult; stdcall;
      function IsSystemMoniker(*(out dwMksys: Longint)*): HResult; stdcall;
   end;

	ICreateDevEnum = interface(IUnknown)
   	['{29840822-5B84-11D0-BD3B-00A0C911CE86}']
		function CreateClassEnumerator( const clsidDeviceClass:TGUID; var ppEnumMoniker:IEnumMoniker; dwFlags:DWORD ):HRESULT; stdcall;
   end;
   IID_ICreateDevEnum=ICreateDevEnum;

   IErrorLog = interface
      ['{3127CA40-446E-11CE-8135-00AA004BB851}']
      function AddError(*(pszPropName: POleStr; pExcepInfo: PExcepInfo)*): HResult; stdcall;
   end;

   (*
   IVideoFrameStep = interface( IUnknown )
   	['{e46a9787-2b71-444d-a4b5-1fab7b708d6a}']
      function Step(dwFrames:dword; pStepObject:IUnknown):HRESULT; stdcall;
      function CanStep:HRESULT; stdcall;
      function CancelStep:HRESULT; stdcall;
	end;
   IID_IVideoFrameStep=IVideoFrameStep;
   *)

  	TIECAGUID = record
   	cElems: Longint;
   	pElems: pointer;
  	end;

   ISpecifyPropertyPages = interface(IUnknown)
   	['{B196B28B-BAB4-101A-B69C-00AA00341D07}']
   	function GetPages(out pages: TIECAGUID): HResult; stdcall;
   end;
   IID_ISpecifyPropertyPages=ISpecifyPropertyPages;

   IAMVideoCompression = interface(IUnknown)
   	['{C6E13343-30AC-11d0-A18C-00A0C9118956}']
      function put_KeyFrameRate(KeyFrameRate:integer):HRESULT; stdcall;
      function get_KeyFrameRate(var pKeyFrameRate:integer):HRESULT; stdcall;
      function put_PFramesPerKeyFrame:HRESULT; stdcall;
      function get_PFramesPerKeyFrame:HRESULT; stdcall;
      function put_Quality(Quality:double):HRESULT; stdcall;
      function get_Quality(var pQuality:double):HRESULT; stdcall;
      function put_WindowSize:HRESULT; stdcall;
      function get_WindowSize:HRESULT; stdcall;
      function GetInfo:HRESULT; stdcall;
      function OverrideKeyFrame:HRESULT; stdcall;
      function OverrideFrameSize:HRESULT; stdcall;
	end;
   IID_IAMVideoCompression=IAMVideoCompression;

   IPropertyBag = interface
      ['{55272A00-42CB-11CE-8135-00AA004BB851}']
      function Read(pszPropName: PWideChar; var pvar: OleVariant; const pErrorLog: IErrorLog): HResult; stdcall;
      function Write(*(pszPropName: POleStr; const pvar: OleVariant)*): HResult; stdcall;
   end;
   IID_IPropertyBag=IPropertyBag;

   IMediaFilter = interface(IPersist)
      ['{56a86899-0ad4-11ce-b03a-0020af0ba770}']
      function Stop:HRESULT; stdcall;
      function Pause:HRESULT; stdcall;
      function Run:HRESULT; stdcall;
      function GetState:HRESULT; stdcall;
      function SetSyncSource:HRESULT; stdcall;
      function GetSyncSource:HRESULT; stdcall;
   end;

   IPin = interface(IUnknown)
   	['{56a86891-0ad4-11ce-b03a-0020af0ba770}']
      function Connect:HRESULT; stdcall;
      function ReceiveConnection:HRESULT; stdcall;
      function Disconnect:HRESULT; stdcall;
      function ConnectedTo:HRESULT; stdcall;
      function ConnectionMediaType:HRESULT; stdcall;
      function QueryPinInfo(pInfo:pointer):HRESULT; stdcall;
      function QueryDirection:HRESULT; stdcall;
      function QueryId:HRESULT; stdcall;
      function QueryAccept:HRESULT; stdcall;
      function EnumMediaTypes:HRESULT; stdcall;
      function QueryInternalConnections:HRESULT; stdcall;
      function EndOfStream:HRESULT; stdcall;
      function BeginFlush:HRESULT; stdcall;
      function EndFlush:HRESULT; stdcall;
      function NewSegment:HRESULT; stdcall;
   end;

   IEnumPins = interface(IUnknown)
   	['{56a86892-0ad4-11ce-b03a-0020af0ba770}']
      function Next(cPins:integer; var ppPins:IPin; var pcFetched:integer):HRESULT; stdcall;
      function Skip:HRESULT; stdcall;
      function Reset:HRESULT; stdcall;
		function Clone:HRESULT; stdcall;
   end;

   IBaseFilter = interface(IMediaFilter)
    	['{56a86895-0ad4-11ce-b03a-0020af0ba770}']
      function EnumPins(var ppEnum:IEnumPins):HRESULT; stdcall;
      function FindPin:HRESULT; stdcall;
      function QueryFilterInfo(pInfo:pointer):HRESULT; stdcall;
      function JoinFilterGraph:HRESULT; stdcall;
      function QueryVendorInfo:HRESULT; stdcall;
   end;
   IID_BaseFilter=IBaseFilter;

	IFilterGraph = interface(IUnknown)
   	['{56a8689f-0ad4-11ce-b03a-0020af0ba770}']
      function AddFilter(pFilter:IBaseFilter; pName:PWideChar):HRESULT; stdcall;
      function RemoveFilter:HRESULT; stdcall;
      function EnumFilters:HRESULT; stdcall;
      function FindFilterByName:HRESULT; stdcall;
      function ConnectDirect:HRESULT; stdcall;
      function Reconnect:HRESULT; stdcall;
      function Disconnect:HRESULT; stdcall;
      function SetDefaultSyncSource:HRESULT; stdcall;
	end;
   IID_IFilterGraph=IFilterGraph;

   const IEMAX_FILTER_NAME  = 128;
	type FILTER_INFO = record
   	achName:array [0..IEMAX_FILTER_NAME-1] of WideChar;
    	pGraph:IFilterGraph;
   end;

   type PIN_INFO = record
   	pFilter:IBaseFilter;
    	dir:integer;
    	achName:array [0..IEMAX_FILTER_NAME-1] of WideChar;
   end;


   IGraphBuilder = interface(IFilterGraph)
   	['{56a868a9-0ad4-11ce-b03a-0020af0ba770}']
   	function Connect:HRESULT; stdcall;
      function Render:HRESULT; stdcall;
      function RenderFile:HRESULT; stdcall;
      function AddSourceFilter(lpwstrFileName:PWideChar; lpwstrFilterName:PWideChar; var ppFilter:IBaseFilter):HRESULT; stdcall;
      function SetLogFile:HRESULT; stdcall;
      function Abort:HRESULT; stdcall;
      function ShouldOperationContinue:HRESULT; stdcall;
	end;
   IID_IGraphBuilder=IGraphBuilder;

   IFileSinkFilter = interface(IUnknown)
    	['{a2104830-7c70-11cf-8bce-00aa00a3f1a6}']
      function SetFileName:HRESULT; stdcall;
      function GetCurFile:HRESULT; stdcall;
   end;

   ICaptureGraphBuilder2 = interface(IUnknown)
		['{93E5A4E0-2D50-11d2-ABFA-00A0C9C6E38D}']
      function SetFiltergraph(pfg:IGraphBuilder):HRESULT; stdcall;
      function GetFiltergraph:HRESULT; stdcall;
      function SetOutputFileName(const pType:TGUID; lpwstrFile:PWideChar; var ppf:IBaseFilter; var pSink:IFileSinkFilter):HRESULT; stdcall;
      function FindInterface(pCategory, pType: PGUID; pf: IBaseFilter; const riid: TGUID; var ppint:IUnknown): HRESULT; stdcall;
      function RenderStream(pCategory:PGUID; pType:PGUID; pSource:IUnknown; pIntermediate:IBaseFilter; pSink:IBaseFilter):HRESULT; stdcall;
      function ControlStream(pCategory:PGUID; pType:PGUID; pFilter:IBaseFilter; pstart:PIEREFERENCE_TIME; pstop:PIEREFERENCE_TIME; wStartCookie:word; wStopCookie:word):HRESULT; stdcall;
      function AllocCapFile:HRESULT; stdcall;
      function CopyCaptureFile:HRESULT; stdcall;
      function FindPin(pSource:IUnknown; pindir:integer; pCategory:PGUID; pType:PGUID; fUnconnected:longbool; num:integer; var ppPin:IPin):HRESULT; stdcall;
	end;
   IID_ICaptureGraphBuilder2=ICaptureGraphBuilder2;

   TIEDirectShowState=(gsStopped,gsPaused,gsRunning);

	IMediaControl = interface(IDispatch)
   	['{56a868b1-0ad4-11ce-b03a-0020af0ba770}']
      function Run:HRESULT; stdcall;
      function Pause:HRESULT; stdcall;
      function Stop:HRESULT; stdcall;
      function GetState(msTimeout:dword; var pfs:TIEDirectShowState):HRESULT; stdcall;
      function RenderFile:HRESULT; stdcall;
      function AddSourceFilter:HRESULT; stdcall;
      function get_FilterCollection:HRESULT; stdcall;
      function get_RegFilterCollection:HRESULT; stdcall;
      function StopWhenReady:HRESULT; stdcall;
	end;
   IID_IMediaControl=IMediaControl;

   IMediaSeeking = interface(IUnknown)
   	['{36b73880-c2c8-11cf-8b46-00805f6cef60}']
      function GetCapabilities:HRESULT; stdcall;
      function CheckCapabilities:HRESULT; stdcall;
      function IsFormatSupported:HRESULT; stdcall;
      function QueryPreferredFormat:HRESULT; stdcall;
      function GetTimeFormat(pFormat:PGUID):HRESULT; stdcall;
      function IsUsingTimeFormat:HRESULT; stdcall;
      function SetTimeFormat(pFormat:PGUID):HRESULT; stdcall;
      function GetDuration(pDuration:PIEREFERENCE_TIME):HRESULT; stdcall;
      function GetStopPosition:HRESULT; stdcall;
      function GetCurrentPosition(pCurrent:PIEREFERENCE_TIME):HRESULT; stdcall;
      function ConvertTimeFormat:HRESULT; stdcall;
      function SetPositions(pCurrent:PIEREFERENCE_TIME; dwCurrentFlags:dword; pStop:PIEREFERENCE_TIME; dwStopFlags:dword):HRESULT; stdcall;
      function GetPositions(pCurrent:PIEREFERENCE_TIME; pStop:PIEREFERENCE_TIME):HRESULT; stdcall;
      function GetAvailable:HRESULT; stdcall;
      function SetRate(dRate:double):HRESULT; stdcall;
      function GetRate(dRate:pdouble):HRESULT; stdcall;
      function GetPreroll:HRESULT; stdcall;
	end;
   IID_IMediaSeeking=IMediaSeeking;

	IMediaEvent = interface(IDispatch)
   	['{56a868b6-0ad4-11ce-b03a-0020af0ba770}']
      function GetEventHandle:HRESULT; stdcall;
      function GetEvent(var lEventCode:integer; var lParam1:integer; var lParam2:integer; msTimeout:integer):HRESULT; stdcall;
      function WaitForCompletion(msTimeout:integer; var pEvCode:integer):HRESULT; stdcall;
      function CancelDefaultHandling:HRESULT; stdcall;
      function RestoreDefaultHandling:HRESULT; stdcall;
      function FreeEventParams(lEventCode:integer; lParam1:integer; lParam2:integer):HRESULT; stdcall;
	end;
   IID_IMediaEvent=IMediaEvent;

	IMediaEventEx = interface(IMediaEvent)
   	['{56a868c0-0ad4-11ce-b03a-0020af0ba770}']
      function SetNotifyWindow(hwnd:THandle; lMsg:integer; lInstanceData:integer):HRESULT; stdcall;
      function SetNotifyFlags:HRESULT; stdcall;
      function GetNotifyFlags:HRESULT; stdcall;
	end;
   IID_IMediaEventEx=IMediaEventEx;

   IEAM_MEDIA_TYPE=record
   	majortype:TGUID;
   	subtype:TGUID;
   	bFixedSizeSamples:longbool;
    	bTemporalCompression:longbool;
    	lSampleSize:dword;
    	formattype:TGUID;
    	pUnk:IUnknown;
    	cbFormat:dword;
    	pbFormat:pbyte;
   end;

	PIEAM_MEDIA_TYPE=^IEAM_MEDIA_TYPE;

   IEVIDEOINFOHEADER=record
      rcSource:TRect;
      rcTarget:TRect;
      dwBitRate:dword;
      dwBitErrorRate:dword;
      AvgTimePerFrame:IEREFERENCE_TIME;
      bmiHeader:TBITMAPINFOHEADER;
	end;
   PIEVIDEOINFOHEADER=^IEVIDEOINFOHEADER;

   IMediaSample = interface(IUnknown)
   	['{56a8689a-0ad4-11ce-b03a-0020af0ba770}']
      function GetPointer:HRESULT; stdcall;
      function GetSize:integer; stdcall;
      function GetTime:HRESULT; stdcall;
      function SetTime:HRESULT; stdcall;
      function IsSyncPoint:HRESULT; stdcall;
      function SetSyncPoint:HRESULT; stdcall;
      function IsPreroll:HRESULT; stdcall;
      function SetPreroll:HRESULT; stdcall;
      function GetActualDataLength:integer; stdcall;
      function SetActualDataLength:HRESULT; stdcall;
      function GetMediaType:HRESULT; stdcall;
      function SetMediaType:HRESULT; stdcall;
      function IsDiscontinuity:HRESULT; stdcall;
      function SetDiscontinuity:HRESULT; stdcall;
      function GetMediaTime:HRESULT; stdcall;
      function SetMediaTime:HRESULT; stdcall;
	end;

   ISampleGrabberCB = interface(IUnknown)
   	['{0579154A-2B53-4994-B0D0-E773148EFF85}']
      function SampleCB(SampleTime:double; pSample:IMediaSample):HRESULT; stdcall;
		function BufferCB(SampleTime:double; pBuffer:pbyte; BufferLen:integer):HRESULT; stdcall;
	end;

   ISampleGrabber = interface(IUnknown)
		['{6B652FFF-11FE-4fce-92AD-0266B5D7C78F}']
      function SetOneShot:HRESULT; stdcall;
      function SetMediaType(pType:PIEAM_MEDIA_TYPE):HRESULT; stdcall;
      function GetConnectedMediaType(pType:PIEAM_MEDIA_TYPE):HRESULT; stdcall;
      function SetBufferSamples(BufferThem:longbool):HRESULT; stdcall;
      function GetCurrentBuffer(pBufferSize:pinteger; pBuffer:pointer):HRESULT; stdcall;
      function GetCurrentSample:HRESULT; stdcall;
      function SetCallback(pCallback:ISampleGrabberCB; WhichMethodToCallback:integer):HRESULT; stdcall;
	end;
   IID_ISampleGrabber=ISampleGrabber;

   TIETimeFormat=(tfNone, tfFrame, tfSample, tfField, tfByte, tfTime);

   TIESampleGrabberCB = class(TInterfacedObject, ISampleGrabberCB)
   	private
      	fOwner:TObject;	// a TIEDirectShow object
      public
         constructor Create(Owner:TObject);
         destructor Destroy; override;
         function SampleCB(SampleTime:double; pSample:IMediaSample):HRESULT; stdcall;
         function BufferCB(SampleTime:double; pBuffer:pbyte; BufferLen:integer):HRESULT; stdcall;
   end;

   IAMStreamConfig = interface(IUnknown)
      ['{C6E13340-30AC-11d0-A18C-00A0C9118956}']
      function SetFormat(pmt: PIEAM_MEDIA_TYPE): HRESULT; stdcall;
      function GetFormat(var ppmt: PIEAM_MEDIA_TYPE): HRESULT; stdcall;
      function GetNumberOfCapabilities(var piCount, piSize: Integer): HRESULT; stdcall;
      function GetStreamCaps(iIndex: Integer; var ppmt: PIEAM_MEDIA_TYPE; pSCC:pointer): HRESULT; stdcall;
	end;
   IID_IAMStreamConfig=IAMStreamConfig;

   IAMCrossbar = interface(IUnknown)
   	['{C6E13380-30AC-11d0-A18C-00A0C9118956}']
      function get_PinCounts(var OutputPinCount:integer; var InputPinCount:integer): HRESULT; stdcall;
      function CanRoute(OutputPinIndex:integer; InputPinIndex:integer): HRESULT; stdcall;
      function Route(OutputPinIndex:integer; InputPinIndex:integer): HRESULT; stdcall;
      function get_IsRoutedTo(OutputPinIndex:integer; var InputPinIndex:integer): HRESULT; stdcall;
      function get_CrossbarPinInfo(IsInputPin:longbool; PinIndex:integer; var PinIndexRelated:integer; var PhysicalType:integer): HRESULT; stdcall;
	end;
   IID_IAMCrossBar = IAMCrossBar;

   IAMTuner = interface(IUnknown)
   	['{211A8761-03AC-11d1-8D13-00AA00BD8339}']
      function put_Channel(lChannel:integer; lVideoSubChannel:integer; lAudioSubChannel:integer): HRESULT; stdcall;
   	function get_Channel(var plChannel:integer; var plVideoSubChannel:integer; var plAudioSubChannel:integer): HRESULT; stdcall;
      function ChannelMinMax: HRESULT; stdcall;
      function put_CountryCode: HRESULT; stdcall;
      function get_CountryCode: HRESULT; stdcall;
      function put_TuningSpace(lTuningSpace:integer): HRESULT; stdcall;
      function get_TuningSpace: HRESULT; stdcall;
      function Logon: HRESULT; stdcall;
      function Logout: HRESULT; stdcall;
      function SignalPresent(var plSignalStrength:integer): HRESULT; stdcall;
      function put_Mode: HRESULT; stdcall;
      function get_Mode: HRESULT; stdcall;
      function GetAvailableModes: HRESULT; stdcall;
      function RegisterNotificationCallBack: HRESULT; stdcall;
      function UnRegisterNotificationCallBack: HRESULT; stdcall;
	end;
   IID_IAMTuner = IAMTuner;

   IAMTVTuner = interface(IAMTuner)
   	['{211A8766-03AC-11d1-8D13-00AA00BD8339}']
      function get_AvailableTVFormats: HRESULT; stdcall;
      function get_TVFormat: HRESULT; stdcall;
      function AutoTune(lChannel:integer; var plFoundSignal:integer): HRESULT; stdcall;
      function StoreAutoTune: HRESULT; stdcall;
      function get_NumInputConnections: HRESULT; stdcall;
      function put_InputType: HRESULT; stdcall;
      function get_InputType: HRESULT; stdcall;
      function put_ConnectInput: HRESULT; stdcall;
      function get_ConnectInput: HRESULT; stdcall;
      function get_VideoFrequency: HRESULT; stdcall;
      function get_AudioFrequency: HRESULT; stdcall;
   end;
   IID_IAMTVTuner = IAMTVTuner;

   TIEPropertyPages=(iepVideoInput,iepAudioInput,iepVideoCodec,iepAudioCodec,iepVideoInputSource,iepTuner);

   TIEPropertyPagesType=(ietFilter,ietInput,ietOutput);

   TIEVideoFormat=class
		Format:string;		// pixels format
		BitRate:integer;	// Approximate data rate of the video stream, in bits per second.
		VideoStandard:string; // The analog video standard supported.
      MinWidth:integer;
      MinHeight:integer;
      MaxWidth:integer;
      MaxHeight:integer;
      GranularityX:integer;
      GranularityY:integer;
   end;

	TIEDirectShow=class
   	private
      	// capture filters lists
			fAudioInputs:TStringList;
			fVideoInputs:TStringList;
         // compression filters list
         fVideoCodecs:TStringList;
         fAudioCodecs:TStringList;
         //
         fVideoFormats:TList;	// array of TIEVideoFormat classes
         fVideoInputSources:TStringList;	// crossbar inputs
         // conversion filters
         fCurColor:IBaseFilter;
         // currently input filters
         fCurAudioInput:IBaseFilter;
         fCurVideoInput:IBaseFilter;
         fCurFileInput:IBaseFilter;	// this implies that fCurAudioInput=nil and fCurVideoIinput=nil
         // file input
         fFileInput:string;
         // currently compression filters
         fCurVideoCodec:IBaseFilter;
         fCurAudioCodec:IBaseFilter;
         fIAMVideoCompression:IAMVideoCompression;
         // output file name
         fFileOutput:string;
         // currenly filter graph
         fGraph:IGraphBuilder;
         fBuilder:ICaptureGraphBuilder2;
         fControl:IMediaControl;
         fMediaSeeking:IMediaSeeking;
         fMediaEvent:IMediaEventEx;
         fStreamConfig:IAMStreamConfig;
         fCrossBarFilter:IBaseFilter;	// the same of fcrossbar but viewed as IBaseFilter
         fCrossBar:IAMCrossBar;
         fTuner:IAMTvTuner;
         fTunerFilter:IBaseFilter;	// the same of fTuner but viewed as IBaseFilter
         // currenly sample grabber filter
         fSampleGrabber:IBaseFilter;
         fSampleGrabberFilter:ISampleGrabber;	// ISampleGrabber queried from fSampleGrabber filter
         fEnableSampleGrabber:boolean;
         fSampleGrabberCB:TIESampleGrabberCB;	// sample grabber callback
         // renderer
         fNullRenderer:IBaseFilter;
         // notification window
         fNotifyWindow:THandle;
         fNewFrameMessage:integer;
         fEventMessage:integer;
         // filter graph creation steps
         function GetAudioInputs:TStringList;
         function GetVideoInputs:TStringList;
         function GetVideoCodecs:TStringList;
         function GetAudioCodecs:TStringList;
         //
         procedure SetPosition(v:int64);
         function GetPosition:int64;
         function GetDuration:int64;
         function GetEndOfStream:boolean;
         function GetGraphCreated:boolean;
         procedure SetRate(value:double);
         function GetRate:double;
         procedure SetTimeFormat(value:TIETimeFormat);
         function GetTimeFormat:TIETimeFormat;
         procedure SetVideoCodecQuality(value:double);
         function GetVideoCodecQuality:double;
         procedure ShowFilterPropertyPages(filter:IBaseFilter);
         procedure ShowPinPropertyPages(pin:IPin);
         procedure FillVideoFormats;
         procedure ClearVideoFormats;
         function GetVideoFormats(i:integer):TIEVideoFormat;
         function GetVideoFormatsCount:integer;
         procedure FillVideoInputSources;
         function GetInputSource:integer;
         procedure SetInputSource(value:integer);
         procedure SetVideoTunerChannel(value:integer);
         function GetVideoTunerChannel:integer;
      public
         constructor Create;
         destructor Destroy; override;
         property AudioInputs:TStringList read GetAudioInputs;
         property VideoInputs:TStringList read GetVideoInputs;
         property VideoCodecs:TStringList read GetVideoCodecs;
         property AudioCodecs:TStringList read GetAudioCodecs;
         procedure SetVideoInput(idx:integer);
         procedure SetAudioInput(idx:integer);
         procedure SetVideoCodec(idx:integer);
         procedure SetAudioCodec(idx:integer);
         property FileInput:string read fFileInput write fFileInput;
         property FileOutput:string read fFileOutput write fFileOutput;
         procedure SaveGraph(filename:string);	// save .grf files (readable with graphedit for debug)
         procedure Connect;
         procedure Disconnect;
         property Connected:boolean read GetGraphCreated;
         procedure Run;
         procedure Stop;
         procedure Pause;
         property Rate:double read GetRate write SetRate;
         function State:TIEDirectShowState;
         property Position:int64 read GetPosition write SetPosition;
         property Duration:int64 read GetDuration;
         property EndOfStream:boolean read GetEndOfStream;
         property EnableSampleGrabber:boolean read fEnableSampleGrabber write fEnableSampleGrabber;
         procedure GetSample(DestBitmap:TIEBitmap);
         property TimeFormat:TIETimeFormat read GetTimeFormat write SetTimeFormat;
         procedure BufferToTIEBitmap(buffer:pbyte; len:integer; DestBitmap:TIEBitmap);
         procedure SetNotifyWindow(WindowHandle:THandle; NewFrameMessage:integer; EventMessage:integer);
         function GetEventCode(var Event:integer):boolean;
         property VideoCodecQuality:double read GetVideoCodecQuality write SetVideoCodecQuality;
         procedure ShowPropertyPages(proppages:TIEPropertyPages; proptype:TIEPropertyPagesType);
			procedure SetCurrentVideoFormat(width,height:integer; format:string);
         procedure GetCurrentVideoFormat(var width,height:integer; var format:string);
         property VideoFormats[i:integer]:TIEVideoFormat read GetVideoFormats;
         property VideoFormatsCount:integer read GetVideoFormatsCount;
         property VideoInputSources:TStringList read fVideoInputSources;
         property VideoInputSource:integer read GetInputSource write SetInputSource;
         property TunerChannel:integer read GetVideoTunerChannel write SetVideoTunerChannel;
         function TunerFindSignal:boolean;
   end;


implementation

const
	ole32    = 'ole32.dll';

function CoCreateInstance(const clsid: TGUID; unkOuter: IUnknown; dwClsContext: Longint; const iid: TGUID; out pv): HResult; stdcall; external ole32 name 'CoCreateInstance';
function OleInitialize(pwReserved: Pointer): HResult; stdcall; external ole32 name 'OleInitialize';
procedure OleUninitialize; stdcall; external ole32 name 'OleUninitialize';
procedure CoTaskMemFree(pv:pointer); stdcall; external ole32 name 'CoTaskMemFree';
//procedure ReleaseStgMedium(pmedium:pointer); stdcall; external ole32 name 'ReleaseStgMedium';
function FreePropVariantArray(cVariants:ULONG; rgvars:pointer):HRESULT; stdcall; external ole32 name 'FreePropVariantArray';
procedure SysFreeString( pstr:pointer ); stdcall; external 'oleaut32' name 'SysFreeString';
function StgCreateDocfile( pwcsName:PWideChar; grfMode:dword; reserved:dword; var ppstgOpen:IStorage):HRESULT; stdcall; external ole32 name 'StgCreateDocfile';
function OleCreatePropertyFrame(hwndOwner:THandle; x,y:dword; lpszCaption:PAnsiChar; cObjects:dword; lplpUnk:pointer; cPages:dword; lpPageClsID:PGUID; lcid:PGUID; dwReserved:dword; lpvReserved:pointer):HRESULT; stdcall; external 'olepro32.dll' name 'OleCreatePropertyFrame';

const

	CLSID_SystemDeviceEnum:TGUID='{62BE5D10-60EB-11d0-BD3B-00A0C911CE86}';
   CLSID_FilterGraph:TGUID='{e436ebb3-524f-11ce-9f53-0020af0ba770}';
   CLSID_CaptureGraphBuilder2:TGUID='{BF87B6E1-8C27-11d0-B3F0-00AA003761C5}';

   CLSID_VideoInputDeviceCategory:TGUID='{860BB310-5D01-11d0-BD3B-00A0C911CE86}';
   CLSID_LegacyAmFilterCategory:TGUID='{083863F1-70DE-11d0-BD40-00A0C911CE86}';
   CLSID_VideoCompressorCategory:TGUID='{33D9A760-90C8-11d0-BD43-00A0C911CE86}';
   CLSID_AudioCompressorCategory:TGUID='{33D9A761-90C8-11d0-BD43-00A0C911CE86}';
   CLSID_AudioInputDeviceCategory:TGUID='{33D9A762-90C8-11d0-BD43-00A0C911CE86}';
   CLSID_AudioRendererCategory:TGUID='{E0F158E1-CB04-11d0-BD4E-00A0C911CE86}';
   CLSID_MidiRendererCategory:TGUID='{4EFE2452-168A-11d1-BC76-00C04FB9453B}';
   CLSID_SampleGrabber:TGUID='{C1F400A0-3F08-11d3-9F0B-006008039E37}';
   CLSID_NullRenderer:TGUID='{C1F400A4-3F08-11d3-9F0B-006008039E37}';

	CLSID_Colour:TGUID='{1643e180-90f5-11ce-97d5-00aa0055595a}';

   MEDIASUBTYPE_Avi:TGUID='{e436eb88-524f-11ce-9f53-0020af0ba770}';
   MEDIASUBTYPE_Asf:TGUID='{3DB80F90-9412-11d1-ADED-0000F8754B99}';
   MEDIASUBTYPE_WAVE:TGUID='{e436eb8b-524f-11ce-9f53-0020af0ba770}';

   PIN_CATEGORY_CAPTURE:TGUID='{fb6c4281-0353-11d1-905f-0000c0cc16ba}';
   PIN_CATEGORY_PREVIEW:TGUID='{fb6c4282-0353-11d1-905f-0000c0cc16ba}';

   MEDIATYPE_Video:TGUID='{73646976-0000-0010-8000-00AA00389B71}';
   MEDIATYPE_Audio:TGUID='{73647561-0000-0010-8000-00AA00389B71}';
   FORMAT_VideoInfo:TGUID='{05589f80-c356-11ce-bf01-00aa0055595a}';

   CLSCTX_LOCAL_SERVER      = 4;
   CLSCTX_REMOTE_SERVER     = $10;
	CLSCTX_INPROC_HANDLER    = 2;
	CLSCTX_INPROC_SERVER     = 1;
	CLSCTX_INPROC = CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER;

   STGM_CREATE           = $00001000;
	STGM_TRANSACTED       = $00010000;
	STGM_READWRITE        = $00000002;
	STGM_SHARE_EXCLUSIVE  = $00000010;
	STGM_WRITE            = $00000001;
	STGC_DEFAULT          = 0;

   AM_SEEKING_NoPositioning	= 0;
	AM_SEEKING_AbsolutePositioning	= $1;
	AM_SEEKING_RelativePositioning	= $2;
	AM_SEEKING_IncrementalPositioning	= $3;
	AM_SEEKING_PositioningBitsMask	= $3;
	AM_SEEKING_SeekToKeyFrame	= $4;
	AM_SEEKING_ReturnTime	= $8;
	AM_SEEKING_Segment	= $10;
	AM_SEEKING_NoFlush	= $20;

   TIME_FORMAT_NONE:TGUID='{00000000-0000-0000-0000-000000000000}';
   TIME_FORMAT_FRAME:TGUID='{7b785570-8c82-11cf-bc0c-00aa00ac74f6}';
   TIME_FORMAT_BYTE:TGUID='{7b785571-8c82-11cf-bc0c-00aa00ac74f6}';
   TIME_FORMAT_SAMPLE:TGUID='{7b785572-8c82-11cf-bc0c-00aa00ac74f6}';
   TIME_FORMAT_FIELD:TGUID='{7b785573-8c82-11cf-bc0c-00aa00ac74f6}';
   TIME_FORMAT_MEDIA_TIME:TGUID='{7b785574-8c82-11cf-bc0c-00aa00ac74f6}';

   INFINITE            =$FFFFFFFF;

   MEDIASUBTYPE_CLPL: TGUID = (D1:$4C504C43;D2:$0000;D3:$0010;D4:($80,$00,$00,$aa,$00,$38,$9b,$71));
   MEDIASUBTYPE_YUYV: TGUID = (D1:$56595559;D2:$0000;D3:$0010;D4:($80,$00,$00,$aa,$00,$38,$9b,$71));
   MEDIASUBTYPE_IYUV: TGUID = (D1:$56555949;D2:$0000;D3:$0010;D4:($80,$00,$00,$aa,$00,$38,$9b,$71));
   MEDIASUBTYPE_YVU9: TGUID = (D1:$39555659;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_Y411: TGUID = (D1:$31313459;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_Y41P: TGUID = (D1:$50313459;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_YUY2: TGUID = (D1:$32595559;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_YVYU: TGUID = (D1:$55595659;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_UYVY: TGUID = (D1:$59565955;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_Y211: TGUID = (D1:$31313259;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_YV12: TGUID = (D1:$32315659;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_CLJR: TGUID = (D1:$524A4C43;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_IF09: TGUID = (D1:$39304649;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_CPLA: TGUID = (D1:$414C5043;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_MJPG: TGUID = (D1:$47504A4D;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_TVMJ: TGUID = (D1:$4A4D5654;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_WAKE: TGUID = (D1:$454B4157;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_CFCC: TGUID = (D1:$43434643;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_IJPG: TGUID = (D1:$47504A49;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_Plum: TGUID = (D1:$6D756C50;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_DVCS: TGUID = (D1:$53435644;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_DVSD: TGUID = (D1:$44535644;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_MDVF: TGUID = (D1:$4656444D;D2:$0000;D3:$0010;D4:($80,$00,$00,$AA,$00,$38,$9B,$71));
   MEDIASUBTYPE_RGB1: TGUID = (D1:$E436EB78;D2:$524F;D3:$11CE;D4:($9F,$53,$00,$20,$AF,$0B,$A7,$70));
   MEDIASUBTYPE_RGB4: TGUID = (D1:$E436EB79;D2:$524F;D3:$11CE;D4:($9F,$53,$00,$20,$AF,$0B,$A7,$70));
   MEDIASUBTYPE_RGB8: TGUID = (D1:$E436EB7A;D2:$524F;D3:$11CE;D4:($9F,$53,$00,$20,$AF,$0B,$A7,$70));
   MEDIASUBTYPE_RGB565: TGUID = (D1:$E436EB7B;D2:$524F;D3:$11CE;D4:($9F,$53,$00,$20,$AF,$0B,$A7,$70));
   MEDIASUBTYPE_RGB555: TGUID = (D1:$E436EB7C;D2:$524F;D3:$11CE;D4:($9F,$53,$00,$20,$AF,$0B,$A7,$70));
   MEDIASUBTYPE_RGB24: TGUID = (D1:$E436EB7D;D2:$524F;D3:$11CE;D4:($9F,$53,$00,$20,$AF,$0B,$A7,$70));
   MEDIASUBTYPE_RGB32:  TGUID = (D1:$E436EB7E;D2:$524F;D3:$11CE;D4:($9F,$53,$00,$20,$AF,$0B,$A7,$70));
   MEDIASUBTYPE_ARGB1555 : TGUID = '{297C55AF-E209-4cb3-B757-C76D6B9C88A8}';
   MEDIASUBTYPE_ARGB4444 : TGUID = '{6E6415E6-5C24-425f-93CD-80102B3D1CCA}';
   MEDIASUBTYPE_ARGB32   : TGUID = (D1:$773c9ac0;D2:$3274;D3:$11d0;D4:($b7,$24,$00,$aa,$00,$6c,$1a,$1 ));
   MEDIASUBTYPE_AYUV     : TGUID = '{56555941-0000-0010-8000-00AA00389B71}'; //'AYUV' == MEDIASUBTYPE_AYUV
   MEDIASUBTYPE_AI44     : TGUID = '{34344941-0000-0010-8000-00AA00389B71}'; //'AI44' == MEDIASUBTYPE_AI44
   MEDIASUBTYPE_IA44     : TGUID = '{34344149-0000-0010-8000-00AA00389B71}'; //'IA44' == MEDIASUBTYPE_IA44

   PINDIR_INPUT=0;
   PINDIR_OUTPUT=1;

   PhysConn_Video_Tuner = 1;
   PhysConn_Video_Composite=2;
   PhysConn_Video_SVideo=3;
   PhysConn_Video_RGB=4;
   PhysConn_Video_YRYBY=5;
   PhysConn_Video_SerialDigital=6;
   PhysConn_Video_ParallelDigital=7;
   PhysConn_Video_SCSI=8;
   PhysConn_Video_AUX=9;
   PhysConn_Video_1394=10;
   PhysConn_Video_USB=11;
   PhysConn_Video_VideoDecoder=12;
   PhysConn_Video_VideoEncoder=13;
   PhysConn_Video_SCART=14;

   PhysConn_Audio_Tuner = 4096;
   PhysConn_Audio_Line=4097;
   PhysConn_Audio_Mic=4098;
   PhysConn_Audio_AESDigital=4099;
   PhysConn_Audio_SPDIFDigital=4100;
   PhysConn_Audio_SCSI=4101;
   PhysConn_Audio_AUX=4102;
   PhysConn_Audio_1394=4103;
   PhysConn_Audio_USB=4104;
   PhysConn_Audio_AudioDecoder=4105;

	AMTUNER_SUBCHAN_NO_TUNE	= -2;
	AMTUNER_SUBCHAN_DEFAULT	= -1;


   type
      TVideo_Stream_Config_Caps = record
        guid: TGUID;
        VideoStandard: ULONG;
        InputSize: TSize;
        MinCroppingSize: TSize;
        MaxCroppingSize: TSize;
        CropGranularityX: Integer;
        CropGranularityY: Integer;
        CropAlignX: Integer;
        CropAlignY: Integer;
        MinOutputSize: TSize;
        MaxOutputSize: TSize;
        OutputGranularityX: Integer;
        OutputGranularityY: Integer;
        StretchTapsX: Integer;
        StretchTapsY: Integer;
        ShrinkTapsX: Integer;
        ShrinkTapsY: Integer;
        MinFrameIntervalLO: Integer;
        MinFrameIntervalHI: Integer;
        MaxFrameIntervalLO: Integer;
        MaxFrameIntervalHI: Integer;
        MinBitsPerSecond: Longint;
        MaxBitsPerSecond: Longint;
      end;
      PVideo_Stream_Config_Caps=^TVideo_Stream_Config_Caps;



procedure FreeMediaType(mt:IEAM_MEDIA_TYPE);
begin
    if (mt.cbFormat <>0) then begin
       CoTaskMemFree(mt.pbFormat);
       mt.cbFormat := 0;
       mt.pbFormat := nil;
    end;
    if (mt.pUnk <> nil) then begin
       mt.pUnk:=nil;
    end;
end;

procedure DeleteMediaType(pmt:PIEAM_MEDIA_TYPE);
begin
	if pmt<>nil then begin
   	FreeMediaType(pmt^);
      CoTaskMemFree(pmt);
   end;
end;


constructor TIEDirectShow.Create;
begin
   if not IEOleInitialized then
   	OleInitialize(nil);
	fAudioInputs:=TStringList.Create;
   fVideoInputs:=TStringList.Create;
   fVideoCodecs:=TStringList.Create;
   fAudioCodecs:=TStringList.Create;
   fVideoFormats:=TList.Create;
   fVideoInputSources:=TStringList.Create;
   fCurAudioInput:=nil;
   fCurVideoInput:=nil;
   fCurVideoCodec:=nil;
   fCurAudioCodec:=nil;
   fGraph:=nil;
   fBuilder:=nil;
   fFileOutput:='';
   fControl:=nil;
   fCurFileInput:=nil;
   fFileInput:='';
   fCurColor:=nil;
   fMediaSeeking:=nil;
   fMediaEvent:=nil;
   fSampleGrabber:=nil;
   fSampleGrabberFilter:=nil;
   fEnableSampleGrabber:=false;
   fNullRenderer:=nil;
   fSampleGrabberCB:=nil;
   fNotifyWindow:=0;
   fIAMVideoCompression:=nil;
   fStreamConfig:=nil;
   fCrossBar:=nil;
   fCrossBarFilter:=nil;
   fTuner:=nil;
   fTunerFilter:=nil;
end;

destructor TIEDirectShow.Destroy;
begin
	Disconnect;
   ClearVideoFormats;
   fVideoInputSources.free;
   fVideoFormats.free;
	fAudioInputs.free;
   fVideoInputs.free;
   fAudioCodecs.free;
   fVideoCodecs.free;
end;

procedure FillFilterList(clid:TGUID; list:TStringList);
var
	pSysDevEnum:ICreateDevEnum;
   pEnumCat:IEnumMoniker;
   pMoniker:IMoniker;
   cFetched:ULONG;
   pPropBag:IPropertyBag;
   bc:IBindCtx;
   mo:IMoniker;
   er:IErrorLog;
   ov:OleVariant;
begin
	list.clear;
	pSysDevEnum:=nil;
   CoCreateInstance(CLSID_SystemDeviceEnum,nil,CLSCTX_INPROC,IID_ICreateDevEnum,pSysDevEnum);
	pEnumCat:=nil;
   if pSysDevEnum.CreateClassEnumerator(clid,pEnumCat,0)=S_OK then begin
      pMoniker:=nil;
      while pEnumCat.Next(1,pMoniker,@cFetched)=S_OK do begin
         bc:=nil;
         mo:=nil;
         pMoniker.BindToStorage(bc,mo,IID_IPropertyBag,pPropBag);
         er:=nil;
         pPropBag.Read('FriendlyName',ov,er);
         list.Add(string(ov));
         pPropBag:=nil;
         pMoniker:=nil;
      end;
   end;
   pEnumCat:=nil;
   pSysDevEnum:=nil;
end;

function CreateFilter(clid:TGUID; FriendlyName:string):IBaseFilter;
var
	pSysDevEnum:ICreateDevEnum;
   pEnumCat:IEnumMoniker;
   pMoniker:IMoniker;
   cFetched:ULONG;
   pPropBag:IPropertyBag;
   bc:IBindCtx;
   mo:IMoniker;
   er:IErrorLog;
   ov:OleVariant;
begin
	result:=nil;
	pSysDevEnum:=nil;
   CoCreateInstance(CLSID_SystemDeviceEnum,nil,CLSCTX_INPROC,IID_ICreateDevEnum,pSysDevEnum);
	pEnumCat:=nil;
   if pSysDevEnum.CreateClassEnumerator(clid,pEnumCat,0)=S_OK then begin
      pMoniker:=nil;
      while pEnumCat.Next(1,pMoniker,@cFetched)=S_OK do begin
         bc:=nil;
         mo:=nil;
         pMoniker.BindToStorage(bc,mo,IID_IPropertyBag,pPropBag);
         er:=nil;
         pPropBag.Read('FriendlyName',ov,er);
			if string(ov)=FriendlyName then begin
         	bc:=nil;
            mo:=nil;
         	pMoniker.BindToObject(bc,mo,IID_BaseFilter,result);
         end;
         pPropBag:=nil;
         pMoniker:=nil;
      end;
   end;
   pEnumCat:=nil;
   pSysDevEnum:=nil;
end;

function TIEDirectShow.GetAudioInputs:TStringList;
begin
	if fAudioInputs.Count=0 then
   	FillFilterList(CLSID_AudioInputDeviceCategory,fAudioInputs);
   result:=fAudioInputs;
end;

function TIEDirectShow.GetVideoInputs:TStringList;
begin
	if fVideoInputs.Count=0 then
      FillFilterList(CLSID_VideoInputDeviceCategory,fVideoInputs);
   result:=fVideoInputs;
end;

function TIEDirectShow.GetVideoCodecs:TStringList;
begin
	if fVideoCodecs.Count=0 then
      FillFilterList(CLSID_VideoCompressorCategory,fVideoCodecs);
   result:=fVideoCodecs;
end;

function TIEDirectShow.GetAudioCodecs:TStringList;
begin
	if fAudioCodecs.Count=0 then
      FillFilterList(CLSID_AudioCompressorCategory,fAudioCodecs);
   result:=fAudioCodecs;
end;

procedure TIEDirectShow.SetVideoInput(idx:integer);
begin
	if (idx>-1) and (idx<VideoInputs.Count) then
		fCurVideoInput:=CreateFilter(CLSID_VideoInputDeviceCategory,VideoInputs[idx]);
end;

procedure TIEDirectShow.SetAudioInput(idx:integer);
begin
	if (idx>-1) and (idx<AudioInputs.Count) then
		fCurAudioInput:=CreateFilter(CLSID_AudioInputDeviceCategory,AudioInputs[idx]);
end;

// note about divx: it shows a window for compression feedback. To disable it set
// "HKEY_CURRENT_USER\Software\DivXNetworks\DivX4Windows\Disable Feedback" = 1
procedure TIEDirectShow.SetVideoCodec(idx:integer);
begin
	if (idx>-1) and (idx<VideoCodecs.Count) then
		fCurVideoCodec:=CreateFilter(CLSID_VideoCompressorCategory,VideoCodecs[idx]);
end;

procedure TIEDirectShow.SetAudioCodec(idx:integer);
begin
	if (idx>-1) and (idx<AudioCodecs.Count) then
		fCurAudioCodec:=CreateFilter(CLSID_AudioCompressorCategory,AudioCodecs[idx]);
end;

const
	cv:array [0..35] of PGUID=(@MEDIASUBTYPE_CLPL,@MEDIASUBTYPE_YUYV,@MEDIASUBTYPE_IYUV,@MEDIASUBTYPE_YVU9,@MEDIASUBTYPE_Y411,
									   @MEDIASUBTYPE_Y41P,@MEDIASUBTYPE_YUY2,@MEDIASUBTYPE_YVYU,@MEDIASUBTYPE_UYVY,@MEDIASUBTYPE_Y211,
   									@MEDIASUBTYPE_YV12,@MEDIASUBTYPE_CLJR,@MEDIASUBTYPE_IF09,@MEDIASUBTYPE_CPLA,@MEDIASUBTYPE_MJPG,
   									@MEDIASUBTYPE_TVMJ,@MEDIASUBTYPE_WAKE,@MEDIASUBTYPE_CFCC,@MEDIASUBTYPE_IJPG,@MEDIASUBTYPE_Plum,
   									@MEDIASUBTYPE_DVCS,@MEDIASUBTYPE_DVSD,@MEDIASUBTYPE_MDVF,@MEDIASUBTYPE_RGB1,@MEDIASUBTYPE_RGB4,
   									@MEDIASUBTYPE_RGB8,@MEDIASUBTYPE_RGB565,@MEDIASUBTYPE_RGB555,@MEDIASUBTYPE_RGB24,@MEDIASUBTYPE_RGB32,
   									@MEDIASUBTYPE_ARGB1555,@MEDIASUBTYPE_ARGB4444,@MEDIASUBTYPE_ARGB32,@MEDIASUBTYPE_AYUV,@MEDIASUBTYPE_AI44,@MEDIASUBTYPE_IA44);
	cs:array [0..35] of string=('CLPL','YUYV','IYUV','YVU9','Y411',
									   'Y41P','YUY2','YVYU','UYVY','Y211',
   									'YV12','CLJR','IF09','CPLA','MJPG',
   									'TVMJ','WAKE','CFCC','IJPG','Plum',
   									'DVCS','DVSD','MDVF','RGB1','RGB4',
   									'RGB8','RGB565','RGB555','RGB24','RGB32',
   									'ARGB1555','ARGB4444','ARGB32','AYUV','AI44','IA44');

function VideoMediaSubTypeToStr(mst:TGUID):string;
var
	i:integer;
begin
	result:='';
	for i:=0 to 35 do
   	if comparemem(cv[i],@mst,sizeof(TGuid)) then begin
      	result:=cs[i];
         break;
      end;
end;

function StrToVideoMediaSubType(ss:string):TGUID;
var
	i:integer;
begin
	result:=cv[0]^;
   for i:=0 to 35 do
   	if ss=cs[i] then begin
      	result:=cv[i]^;
         break;
      end;
end;

procedure TIEDirectShow.ClearVideoFormats;
var
	i:integer;
begin
	for i:=0 to fVideoFormats.Count-1 do
   	TIEVideoFormat(fVideoFormats[i]).Free;
   fVideoFormats.Clear;
end;

const
	vs1:array [0..19] of integer=($00000000,$00000001,$00000002,$00000004,$00000010,$00000020,$00000080,$00000100,$00000200,$00000400,
                                 $00000800,$00001000,$00002000,$00004000,$00008000,$00010000,$00020000,$00040000,$00080000,$00100000);
	vs2:array [0..19] of string=('None','NTSC_M','NTSC_M_J','NTSC_433','PAL_B','PAL_D','PAL_H','PAL_I','PAL_M','PAL_N','PAL_60','SECAM_B',
   									  'SECAM_D','SECAM_G','SECAM_H','SECAM_K','SECAM_K1','SECAM_L','SECAM_L1','PAL_N_COMBO');

function VideoStandard2Str(vs:integer):string;
var
	i:integer;
begin
	result:='';
	for i:=0 to 19 do
   	if (vs and vs1[i])<>0 then
      	result:=result+vs2[i]+' ';
   result:=trim(result);
end;

function Str2VideoStandard(vs:string):integer;
var
	i:integer;
begin
	result:=0;
   for i:=0 to 19 do
   	if pos(vs2[i],vs)>0 then
      	result:=result or vs1[i];
end;

procedure TIEDirectShow.FillVideoFormats;
var
	piCount,piSize:integer;
   i:integer;
   pSCC:PVideo_Stream_Config_Caps;
   pmt:PIEAM_MEDIA_TYPE;
   ih:PIEVIDEOINFOHEADER;
   vf:TIEVideoFormat;
begin
	ClearVideoFormats;
   if assigned(fStreamConfig) then begin
		fStreamConfig.GetNumberOfCapabilities(piCount,piSize);
      getmem(pSCC,piSize);
		for i:=0 to piCount-1 do begin
			fStreamConfig.GetStreamCaps(i,pmt,pSCC);
         ih:=pointer(pmt^.pbFormat);
         vf:=TIEVideoFormat.Create;
         fVideoFormats.Add(vf);
         vf.Format:=VideoMediaSubTypeToStr(pmt^.subtype);
         vf.BitRate:=ih^.dwBitRate;
         vf.VideoStandard:=VideoStandard2Str( pSCC^.VideoStandard );
         vf.MinWidth:=pSCC^.MinOutputSize.cx;
         vf.MinHeight:=pSCC^.MinOutputSize.cy;
         vf.MaxWidth:=pSCC^.MaxOutputSize.cx;
         vf.MaxHeight:=pSCC^.MaxOutputSize.cy;
         vf.GranularityX:=pSCC^.OutputGranularityX;
         vf.GranularityY:=pSCC^.OutputGranularityY;
         DeleteMediaType(pmt);
      end;
      freemem(pSCC);
   end;
end;

// uses fCrossBar inputs
procedure TIEDirectShow.FillVideoInputSources;
var
   pFilter:IBaseFilter;
   pins:IEnumPins;
   pP:IPin;
   n:integer;
   pInfo:PIN_INFO;
begin
	fVideoInputSources.Clear;
   if assigned(fCrossBar) then begin
		pFilter:=nil;
      fCrossBar.QueryInterface(IID_BaseFilter,pFilter);
      if assigned(pFilter) then begin
      	pins:=nil;
         pFilter.EnumPins(pins);
         while (pins.Next(1,pP,n)=S_OK) do begin
         	pP.QueryPinInfo(@pInfo);
            if pInfo.dir=PINDIR_INPUT then
	            fVideoInputSources.Add(WideCharToString(pInfo.achName));
            pInfo.pFilter:=nil;
         	pP:=nil;
         end;
         pins:=nil;
         pFilter:=nil;
      end;
   end;
end;

function TIEDirectShow.GetInputSource:integer;
var
	i:integer;
	OutputPinCount,InputPinCount:integer;
   PinIndexRelated,PhysicalType:integer;
begin
	result:=0;
	if assigned(fCrossBar) then begin
   	// identify the output pin (video decoder)
      fCrossBar.get_PinCounts(OutputPinCount,InputPinCount);
      for i:=0 to OutputPinCount-1 do begin
	   	fCrossBar.get_CrossbarPinInfo(false,i,PinIndexRelated,PhysicalType);
         if PhysicalType=PhysConn_Video_VideoDecoder then begin
         	// found
            fCrossBar.get_IsRoutedTo(i,result);
         	break;
         end;
      end;
   end;
end;

procedure TIEDirectShow.SetInputSource(value:integer);
var
	i:integer;
	OutputPinCount,InputPinCount:integer;
   PinIndexRelated,PhysicalType:integer;
begin
	if assigned(fCrossBar) then begin
   	// identify the output pin (video decoder)
      fCrossBar.get_PinCounts(OutputPinCount,InputPinCount);
      for i:=0 to OutputPinCount-1 do begin
	   	fCrossBar.get_CrossbarPinInfo(false,i,PinIndexRelated,PhysicalType);
         if PhysicalType=PhysConn_Video_VideoDecoder then begin
         	// found
            fCrossBar.Route(i,value);
         	break;
         end;
      end;
   end;
end;

function TIEDirectShow.GetVideoFormats(i:integer):TIEVideoFormat;
begin
	result:=TIEVideoFormat(fVideoFormats[i]);
end;

function TIEDirectShow.GetVideoFormatsCount:integer;
begin
	result:=fVideoFormats.Count;
end;

procedure TIEDirectShow.Connect;
var
	ppf:IBaseFilter;
   inter:IBaseFilter;
   pSink:IFileSinkFilter;
   ext:string;
   ws:pwidechar;
   mt:IEAM_MEDIA_TYPE;
   CurInput:IBaseFilter;
   iunk:IUnknown;
begin
	CurInput:=nil;
	fGraph:=nil;
   CoCreateInstance(CLSID_FilterGraph,nil,CLSCTX_INPROC,IID_IGraphBuilder,fGraph);
   fBuilder:=nil;
   CoCreateInstance(CLSID_CaptureGraphBuilder2,nil,CLSCTX_INPROC,IID_ICaptureGraphBuilder2,fBuilder);
   fBuilder.SetFiltergraph(fGraph);
   // set source filters
   if fCurVideoInput<>nil then
   	fGraph.AddFilter(fCurVideoInput,'VideoCapture');
   if fCurAudioInput<>nil then
   	fGraph.AddFilter(fCurAudioInput,'AudioCapture');
   if fFileInput<>'' then begin
   	fCurFileInput:=nil;
		getmem(ws,4096);
      StringToWideChar(fFileInput,ws,2048);
      fGraph.AddSourceFilter(ws,'FileFilter',fCurFileInput);
      freemem(ws);
   end;
   // codecs
   if fCurVideoCodec<>nil then
   	fGraph.AddFilter(fCurVideoCodec,'VideoCodec');
   if fCurAudioCodec<>nil then
   	fGraph.AddFilter(fCurAudioCodec,'AudioCodec');
	// output file
	if fFileOutput<>'' then begin
   	ppf:=nil;
      pSink:=nil;
      ext:=ExtractFileExt(lowercase(fFileOutput));
      getmem(ws,4096);
      StringToWideChar(fFileOutput,ws,2048);
      if ext='.avi' then
	      fBuilder.SetOutputFileName(MEDIASUBTYPE_Avi, ws, ppf, pSink)
      else if ext='.asf' then
			fBuilder.SetOutputFileName(MEDIASUBTYPE_Asf, ws, ppf, pSink);
      freemem(ws);
   end;
   // color conversion filter (needed only when it is not specified a video compression filter)
   if fCurVideoCodec=nil then begin
      fCurColor:=nil;
      CoCreateInstance(CLSID_Colour,nil,CLSCTX_INPROC,IID_BaseFilter,fCurColor);
      fGraph.AddFilter(fCurColor,'ColorConverter');
   	inter:=fCurColor;
   end else
   	inter:=fCurVideoCodec;
   // sample grabber
   if fEnableSampleGrabber and (fCurVideoCodec=nil) then begin	// grabbing and compression don't allowed
      fSampleGrabber:=nil;
      CoCreateInstance(CLSID_SampleGrabber,nil,CLSCTX_INPROC,IID_BaseFilter,fSampleGrabber);
      fGraph.AddFilter(fSampleGrabber,'SampleGrabber');
      fSampleGrabber.QueryInterface(IID_ISampleGrabber,fSampleGrabberFilter);
      fSampleGrabberFilter.SetBufferSamples(true);
		zeromemory(@mt,sizeof(IEAM_MEDIA_TYPE));
      mt.majortype:=MEDIATYPE_Video;
      mt.subtype:=MEDIASUBTYPE_RGB24;
      fSampleGrabberFilter.SetMediaType(@mt);
      if fNotifyWindow<>0 then begin
         fSampleGrabberCB:=TIESampleGrabberCB.Create(self);
         fSampleGrabberFilter.SetCallback(fSampleGrabberCB,1);	// call 1=BufferCB
      end;
      inter:=fSampleGrabber;
   end;
   // null renderer (avoid to display the output)
   if ppf=nil then begin
   	fNullRenderer:=nil;
		CoCreateInstance(CLSID_NullRenderer,nil,CLSCTX_INPROC,IID_BaseFilter,fNullRenderer);
      fGraph.AddFilter(fNullRenderer,'NullRenderer');
		ppf:=fNullRenderer;
   end;
	//
   if fCurVideoInput<>nil then begin
	   fBuilder.RenderStream(@PIN_CATEGORY_CAPTURE,@MEDIATYPE_Video,fCurVideoInput,inter,ppf);
      CurInput:=fCurVideoInput;
   end;
   if fCurAudioInput<>nil then
	   fBuilder.RenderStream(@PIN_CATEGORY_CAPTURE,@MEDIATYPE_Audio,fCurAudioInput,fCurAudioCodec,ppf);
   if fCurFileInput<>nil then begin
   	fBuilder.RenderStream(nil,nil,fCurFileInput,inter,ppf);
      if (ppf<>nil) then
	      fBuilder.RenderStream(nil,nil,fCurFileInput,fCurAudioCodec,ppf);
      CurInput:=fCurFileInput;
   end;
   //
   fControl:=nil;
   fGraph.QueryInterface(IID_IMediaControl,fControl);
   fMediaSeeking:=nil;
   fGraph.QueryInterface(IID_IMediaSeeking,fMediaSeeking);
   fMediaEvent:=nil;
   fGraph.QueryInterface(IID_IMediaEventEx,fMediaEvent);
   //
   if fNotifyWindow<>0 then begin
      fMediaEvent.SetNotifyWindow(fNotifyWindow,fEventMessage,integer(pointer(self)));
   end;
   //
   if fCurVideoCodec<>nil then begin
		fIAMVideoCompression:=nil;
		fCurVideoCodec.QueryInterface(IID_IAMVIdeoCompression,fIAMVideoCompression);
   end;
   // stream config
   iunk:=nil;
   fBuilder.FindInterface(nil,nil,CurInput,IID_IAMStreamConfig,iunk);
   fStreamConfig:=nil;
   if assigned(iunk) then begin
	   iunk.QueryInterface(IID_IAMStreamConfig,fStreamConfig);
   	iunk:=nil;
   end;
   // crossbar
   iunk:=nil;
   fBuilder.FindInterface(nil,nil,CurInput,IID_IAMCrossBar,iunk);
   fCrossBar:=nil;
   if assigned(iunk) then begin
   	iunk.QueryInterface(IID_IAMCrossBar,fCrossBar);
      iunk.QueryInterface(IID_BaseFilter,fCrossBarFilter);
      iunk:=nil;
   end;
   // tuner
   iunk:=nil;
   fBuilder.FindInterface(nil,nil,CurInput,IID_IAMTvTuner,iunk);
   fTuner:=nil;
   if assigned(iunk) then begin
   	iunk.QueryInterface(IID_IAMTvTuner,fTuner);
      iunk.QueryInterface(IID_BaseFilter,fTunerFilter);
      iunk:=nil;
   end;
   //
   FillVideoFormats;
   FillVideoInputSources;
end;

procedure TIEDirectShow.SetVideoTunerChannel(value:integer);
begin
	if assigned(fTuner) then
   	fTuner.put_Channel(value,AMTUNER_SUBCHAN_DEFAULT,AMTUNER_SUBCHAN_DEFAULT);
end;

function TIEDirectShow.GetVideoTunerChannel:integer;
var
	lVideoSubChannel:integer;
	lAudioSubChannel:integer;
begin
	result:=0;
	if assigned(fTuner) then
   	fTuner.get_Channel(result,lVideoSubChannel,lAudioSubChannel);
end;

function TIEDirectShow.TunerFindSignal:boolean;
var
	lChannel,lpFoundSignal:integer;
begin
	result:=false;
	if assigned(fTuner) then begin
   	lChannel:=GetVideoTunerChannel;
   	fTuner.AutoTune(lChannel,lpFoundSignal);
      result:=lpFoundSignal=1;
   end;
end;

procedure TIEDirectShow.SetCurrentVideoFormat(width,height:integer; format:string);
var
   pmt:PIEAM_MEDIA_TYPE;
   ih:PIEVIDEOINFOHEADER;
begin
	if assigned(fStreamConfig) then begin
      fStreamConfig.GetFormat(pmt);
      ih:=pointer(pmt^.pbFormat);
      ih^.bmiHeader.biWidth:=width;
      ih^.bmiHeader.biHeight:=height;
      if format<>'' then
	      pmt^.subtype:=StrToVideoMediaSubType(format);
      fStreamConfig.SetFormat(pmt);
      DeleteMediaType(pmt);
   end;
end;

procedure TIEDirectShow.GetCurrentVideoFormat(var width,height:integer; var format:string);
var
   pmt:PIEAM_MEDIA_TYPE;
   ih:PIEVIDEOINFOHEADER;
begin
	if assigned(fStreamConfig) then begin
      fStreamConfig.GetFormat(pmt);
      ih:=pointer(pmt^.pbFormat);
      width:=ih^.bmiHeader.biWidth;
      height:=ih^.bmiHeader.biHeight;
      format:=VideoMediaSubTypeToStr(pmt^.subtype);
      DeleteMediaType(pmt);
   end;
end;

procedure TIEDirectShow.Disconnect;
begin
	if (fControl<>nil) and (State<>gsStopped) then
   	fControl.Stop;
   fTunerFilter:=nil;
   fTuner:=nil;
   fCrossBarFilter:=nil;
   fCrossBar:=nil;
   fStreamConfig:=nil;
	fIAMVideoCompression:=nil;
   fMediaEvent:=nil;
   fMediaSeeking:=nil;
   fControl:=nil;
   fNullRenderer:=nil;
	fSampleGrabberFilter:=nil;
   fSampleGrabber:=nil;
   fCurColor:=nil;
   fCurFileInput:=nil;
   fBuilder:=nil;
   fGraph:=nil;
   fSampleGrabberCB:=nil;	// fSampleGrabberCB automatically called
end;

function TIEDirectShow.GetGraphCreated:boolean;
begin
	result:= fGraph<>nil;
end;

procedure TIEDirectShow.Run;
begin
	if fControl<>nil then
		fControl.Run;
end;

procedure TIEDirectShow.Stop;
begin
	if fControl<>nil then
		fControl.StopWhenReady;
end;

procedure TIEDirectShow.Pause;
begin
	if fControl<>nil then
		fControl.Pause;
end;

function TIEDirectShow.State:TIEDirectShowState;
begin
	if fControl<>nil then
		fControl.GetState(100,result)
   else
   	result:=gsStopped;
end;

procedure TIEDirectShow.SetRate(value:double);
begin
	if fMediaSeeking<>nil then
   	fMediaSeeking.SetRate(value);
end;

function TIEDirectShow.GetRate:double;
begin
	if fMediaSeeking<>nil then
   	fMediaSeeking.GetRate(@result);
end;

procedure TIEDirectShow.SetTimeFormat(value:TIETimeFormat);
begin
	if fMediaSeeking<>nil then begin
   	case value of
      	tfNone: fMediaSeeking.SetTimeFormat(@TIME_FORMAT_NONE);
         tfFrame: fMediaSeeking.SetTimeFormat(@TIME_FORMAT_FRAME);
         tfSample: fMediaSeeking.SetTimeFormat(@TIME_FORMAT_SAMPLE);
         tfField: fMediaSeeking.SetTimeFormat(@TIME_FORMAT_FIELD);
         tfByte: fMediaSeeking.SetTimeFormat(@TIME_FORMAT_BYTE);
         tfTime: fMediaSeeking.SetTimeFormat(@TIME_FORMAT_MEDIA_TIME);
      end;
   end;
end;

function TIEDirectShow.GetTimeFormat:TIETimeFormat;
var
	tf:TGUID;
begin
	result:=tfNone;
	if fMediaSeeking<>nil then begin
   	fMediaSeeking.GetTimeFormat(@tf);
      if CompareMem(@TIME_FORMAT_NONE,@tf,sizeof(TGUID)) then
      	result:=tfNone
      else if CompareMem(@TIME_FORMAT_FRAME,@tf,sizeof(TGUID)) then
      	result:=tfFrame
      else if CompareMem(@TIME_FORMAT_SAMPLE,@tf,sizeof(TGUID)) then
      	result:=tfSample
      else if CompareMem(@TIME_FORMAT_FIELD,@tf,sizeof(TGUID)) then
      	result:=tfField
      else if CompareMem(@TIME_FORMAT_BYTE,@tf,sizeof(TGUID)) then
      	result:=tfByte
      else if CompareMem(@TIME_FORMAT_MEDIA_TIME,@tf,sizeof(TGUID)) then
      	result:=tfTime;
   end;
end;

procedure TIEDirectShow.SaveGraph(filename:string);
const
	wszStreamName:PWideChar='ActiveMovieGraph';
var
   pStorage:IStorage;
   wszPath:PWideChar;
   pStream:IStream;
   pPersist:IPersistStream;
begin
	pStorage:=nil;
   getmem(wszPath,4096);
   StringToWideChar(filename,wszPath,2048);
   StgCreateDocfile( wszPath, STGM_CREATE or STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, pStorage);
	freemem(wszPath);
   pStorage.CreateStream( wszStreamName, STGM_WRITE or STGM_CREATE or STGM_SHARE_EXCLUSIVE,  0, 0, pStream);
   pPersist:=nil;
   fGraph.QueryInterface(IID_IPersistStream, pPersist);
   pPersist.Save(pStream, TRUE);
   pStream:=nil;
   pPersist:=nil;
   pStorage.Commit(STGC_DEFAULT);
   pStorage:=nil;
end;

function TIEDirectShow.GetDuration:int64;
var
	rf:IEREFERENCE_TIME;
begin
	if (fMediaSeeking<>nil) and (fMediaSeeking.GetDuration(@rf)=S_OK) then
   	{$ifdef IEHASINT64}
   	result:=rf.lo32 + (rf.hi32 * $100000000)
      {$else}
      result:=rf.lo32
      {$endif}
   else
   	result:=0;
end;

procedure TIEDirectShow.SetPosition(v:int64);
var
	rf:IEREFERENCE_TIME;
   pfs:TIEDirectShowState;
begin
	if fMediaSeeking<>nil then begin
      rf.lo32:=v and $FFFFFFFF;
      rf.hi32:=v shr 32;
      fMediaSeeking.SetPositions(@rf,AM_SEEKING_AbsolutePositioning ,nil,AM_SEEKING_NoPositioning);
      if fControl<>nil then
	      while fControl.GetState(INFINITE,pfs)<>S_OK do;
   end;
end;

function TIEDirectShow.GetPosition:int64;
var
	rf:IEREFERENCE_TIME;
begin
	if (fMediaSeeking<>nil) and (fMediaSeeking.GetCurrentPosition(@rf)=S_OK) then
   	{$ifdef IEHASINT64}
   	result:=rf.lo32 + (rf.hi32 * $100000000)
      {$else}
      result:=rf.lo32
      {$endif}
   else
   	result:=0;
end;

function TIEDirectShow.GetEndOfStream:boolean;
var
	pEvCode:integer;
begin
	if fMediaEvent<>nil then
		result:= fMediaEvent.WaitForCompletion(0,pEvCode)=S_OK
   else
   	result:=true;
end;

// if buffer=nil calls SampleGrabberFilter.GetCurrentBuffer to get it
procedure TIEDirectShow.BufferToTIEBitmap(buffer:pbyte; len:integer; DestBitmap:TIEBitmap);
var
   mt:IEAM_MEDIA_TYPE;
   vf:PIEVIDEOINFOHEADER;
begin
	if fSampleGrabberFilter<>nil then begin
      fSampleGrabberFilter.GetConnectedMediaType(@mt);
      if not CompareMem( @mt.formattype, @FORMAT_VideoInfo, sizeof(TGUID)) then
      	exit;
      vf:=PIEVIDEOINFOHEADER(mt.pbFormat);
      if DestBitmap.Location=ieFile then
         DestBitmap.Location:=ieMemory;
      if (DestBitmap.PixelFormat<>ie24RGB) or (DestBitmap.Width<>vf^.bmiHeader.biWidth) or (DestBitmap.Height<>vf^.bmiHeader.biHeight) then
         DestBitmap.Allocate(vf^.bmiHeader.biWidth,vf^.bmiHeader.biHeight,ie24RGB);
   	if buffer<>nil then begin
      	// use buffer and len
			copymemory(DestBitmap.Scanline[DestBitmap.Height-1],buffer,Destbitmap.RowLen*DestBitmap.Height);
      end else begin
      	// use GetCurrentBuffer to get the buffer
         len:=0;
         fSampleGrabberFilter.GetCurrentBuffer(@len,buffer);	// get buffer size
         //outputdebugstring(PAnsiChar(string(inttostr( integer(state) ))));
         if len<>0 then begin
            if len=DestBitmap.RowLen*DestBitmap.Height then begin
               buffer:=DestBitmap.ScanLine[DestBitmap.Height-1];
               fSampleGrabberFilter.GetCurrentBuffer(@len,buffer);
            end else if len=DestBitmap.Width*DestBitmap.Height*4 then begin
               // 32 bit, some filters (like divx) returns 32bit also if we set that want only 24 bit!
               getmem(buffer,len);
               fSampleGrabberFilter.GetCurrentBuffer(@len,buffer);
               copymemory(DestBitmap.Scanline[DestBitmap.Height-1],buffer,Destbitmap.RowLen*DestBitmap.Height);
               freemem(buffer);
            end;
            CoTaskMemFree(mt.pbFormat);
         end;
      end;
   end;
end;

procedure TIEDirectShow.GetSample(DestBitmap:TIEBitmap);
begin
	BufferToTIEBitmap(nil,0,DestBitmap);
end;

constructor TIESampleGrabberCB.Create(Owner:TObject);
begin
	fOwner:=Owner;
end;

destructor TIESampleGrabberCB.Destroy;
begin
	inherited;
end;

function TIESampleGrabberCB.SampleCB(SampleTime:double; pSample:IMediaSample):HRESULT;
begin
	result:=S_OK;
end;

function TIESampleGrabberCB.BufferCB(SampleTime:double; pBuffer:pbyte; BufferLen:integer):HRESULT;
var
	ds:TIEDirectShow;
begin
	try
	ds:=TIEDirectShow(fOwner);
	PostMessage(ds.fNotifyWindow,ds.fNewFrameMessage,0,integer(pointer(ds)));
   except
   end;
	result:=S_OK;
end;

procedure TIEDirectShow.SetNotifyWindow(WindowHandle:THandle; NewFrameMessage:integer; EventMessage:integer);
begin
	fNotifyWindow:=WindowHandle;
   fNewFrameMessage:=NewFrameMessage;
   fEventMessage:=EventMessage;
end;

function TIEDirectShow.GetEventCode(var Event:integer):boolean;
var
	evParam1,evParam2:integer;
begin
	result:= fMediaEvent.GetEvent(Event,evParam1,evParam2,0)=S_OK;
   if result then
   	fMediaEvent.FreeEventParams(Event,evParam1,evParam2);
end;

procedure TIEDirectShow.SetVideoCodecQuality(value:double);
begin
	if assigned(fIAMVideoCompression) then
   	fIAMVideoCompression.put_Quality(value);
end;

function TIEDirectShow.GetVideoCodecQuality:double;
begin
	result:=0;
	if assigned(fIAMVideoCompression) then
   	fIAMVideoCompression.get_Quality(result);
end;

procedure TIEDirectShow.ShowFilterPropertyPages(filter:IBaseFilter);
var
	pSpecify:ISpecifyPropertyPages;
   caGUID:TIECAGUID;
begin
	pSpecify:=nil;
   filter.QueryInterface(IID_ISpecifyPropertyPages,pSpecify);
   if pSpecify<>nil then begin
      pSpecify.GetPages(caGUID);
      pSpecify:=nil;
      OleCreatePropertyFrame(fNotifyWindow,0,0,'',1,pointer(@filter),caGUID.cElems,PGUID(caGUID.pElems),nil,0,nil);
      CoTaskMemFree(caGUID.pElems);
   end;
end;

procedure TIEDirectShow.ShowPinPropertyPages(pin:IPin);
var
	pSpecify:ISpecifyPropertyPages;
   caGUID:TIECAGUID;
begin
	pSpecify:=nil;
   pin.QueryInterface(IID_ISpecifyPropertyPages,pSpecify);
   if pSpecify<>nil then begin
      pSpecify.GetPages(caGUID);
      pSpecify:=nil;
      OleCreatePropertyFrame(fNotifyWindow,0,0,'',1,pointer(@pin),caGUID.cElems,PGUID(caGUID.pElems),nil,0,nil);
      CoTaskMemFree(caGUID.pElems);
   end;
end;

procedure TIEDirectShow.ShowPropertyPages(proppages:TIEPropertyPages; proptype:TIEPropertyPagesType);
var
	f:IBaseFilter;
   pin:IPin;
begin
	f:=nil;
	if not Connected then
   	Connect;
	case proppages of
	   iepVideoInput:
         if fCurVideoInput<>nil then
            f:=fCurVideoInput
         else if fCurFileInput<>nil then
            f:=fCurFileInput;
      iepAudioInput:
         if fCurAudioInput<>nil then
            f:=fCurAudioInput
         else if fCurFileInput<>nil then
            f:=fCurFileInput;
      iepVideoCodec:
         if fCurVideoCodec<>nil then
            f:=fCurVideoCodec;
      iepAudioCodec:
         if fCurAudioCodec<>nil then
            f:=fCurAudioCodec;
      iepVideoInputSource:
      	if fCrossBarFilter<>nil then
         	f:=fCrossBarFilter;
      iepTuner:
      	if fTunerFilter<>nil then
         	f:=fTunerFilter;
   end;
   if assigned(f) then
   	case proptype of
      	ietFilter:
		   	ShowFilterPropertyPages(f);
         ietInput:
         	begin
            	fBuilder.FindPin(f,PINDIR_INPUT,nil,nil,false,0,pin);
               if assigned(pin) then
	    				ShowPinPropertyPages(pin);
            end;
         ietOutput:
         	begin
            	fBuilder.FindPin(f,PINDIR_OUTPUT,nil,nil,false,0,pin);
               if assigned(pin) then
	    				ShowPinPropertyPages(pin);
            end;
      end;
end;



{$else} 	// IEINCLUDEDIRECTSHOW
implementation
{$endif}


end.
