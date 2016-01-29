{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: rtscom.h                               }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.RtsCom;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "rtscom.h"'}
{$HPPEMIT ''}

interface

uses
  Winapi.TpcShrd, Winapi.MsInkAut, Winapi.Manipulations, Winapi.Windows;

const
  RTSDI_AllData                = $FFFFFFFF;
  {$EXTERNALSYM RTSDI_AllData}
  RTSDI_None                   = 0;
  {$EXTERNALSYM RTSDI_None}
  RTSDI_Error                  = $1;
  {$EXTERNALSYM RTSDI_Error}
  RTSDI_RealTimeStylusEnabled  = $2;
  {$EXTERNALSYM RTSDI_RealTimeStylusEnabled}
  RTSDI_RealTimeStylusDisabled = $4;
  {$EXTERNALSYM RTSDI_RealTimeStylusDisabled}
  RTSDI_StylusNew              = $8;
  {$EXTERNALSYM RTSDI_StylusNew}
  RTSDI_StylusInRange          = $10;
  {$EXTERNALSYM RTSDI_StylusInRange}
  RTSDI_InAirPackets           = $20;
  {$EXTERNALSYM RTSDI_InAirPackets}
  RTSDI_StylusOutOfRange       = $40;
  {$EXTERNALSYM RTSDI_StylusOutOfRange}
  RTSDI_StylusDown             = $80;
  {$EXTERNALSYM RTSDI_StylusDown}
  RTSDI_Packets                = $100;
  {$EXTERNALSYM RTSDI_Packets}
  RTSDI_StylusUp               = $200;
  {$EXTERNALSYM RTSDI_StylusUp}
  RTSDI_StylusButtonUp         = $400;
  {$EXTERNALSYM RTSDI_StylusButtonUp}
  RTSDI_StylusButtonDown       = $800;
  {$EXTERNALSYM RTSDI_StylusButtonDown}
  RTSDI_SystemEvents           = $1000;
  {$EXTERNALSYM RTSDI_SystemEvents}
  RTSDI_TabletAdded            = $2000;
  {$EXTERNALSYM RTSDI_TabletAdded}
  RTSDI_TabletRemoved          = $4000;
  {$EXTERNALSYM RTSDI_TabletRemoved}
  RTSDI_CustomStylusDataAdded  = $8000;
  {$EXTERNALSYM RTSDI_CustomStylusDataAdded}
  RTSDI_UpdateMapping          = $10000;
  {$EXTERNALSYM RTSDI_UpdateMapping}
  RTSDI_DefaultEvents =        RTSDI_RealTimeStylusEnabled or
                               RTSDI_RealTimeStylusDisabled or
                               RTSDI_StylusDown or
                               RTSDI_Packets or
                               RTSDI_StylusUp or
                               RTSDI_SystemEvents or
                               RTSDI_CustomStylusDataAdded;
  {$EXTERNALSYM RTSDI_DefaultEvents}

const
  SyncStylusQueue           = $1;
  {$EXTERNALSYM SyncStylusQueue}
  AsyncStylusQueueImmediate = $2;
  {$EXTERNALSYM AsyncStylusQueueImmediate}
  AsyncStylusQueue          = $3;
  {$EXTERNALSYM AsyncStylusQueue}

const
  RTSLT_ObjLock         = $1;
  {$EXTERNALSYM RTSLT_ObjLock}
  RTSLT_SyncEventLock   = $2;
  {$EXTERNALSYM RTSLT_SyncEventLock}
  RTSLT_AsyncEventLock  = $4;
  {$EXTERNALSYM RTSLT_AsyncEventLock}
  RTSLT_ExcludeCallback = $8;
  {$EXTERNALSYM RTSLT_ExcludeCallback}
  RTSLT_SyncObjLock     = $B;
  {$EXTERNALSYM RTSLT_SyncObjLock}
  RTSLT_AsyncObjLock    = $D;
  {$EXTERNALSYM RTSLT_AsyncObjLock}

const
  GUID_GESTURE_DATA: TGUID = (
    D1:$41E4EC0F; D2:$26AA; D3:$455A; D4:($9A,$A5,$2C,$D3,$6C,$F6,$3F,$B9));
  {$EXTERNALSYM GUID_GESTURE_DATA}
  GUID_DYNAMIC_RENDERER_CACHED_DATA: TGUID = (
    D1:$BF531B92; D2:$25BF; D3:$4A95; D4:($89,$AD,$0E,$47,$6B,$34,$B4,$F5));
  {$EXTERNALSYM GUID_DYNAMIC_RENDERER_CACHED_DATA}
  GUID_MANIPULATION_PROCESSOR_DATA: TGUID = (
    D1:$F5A96D02; D2:$4AFD; D3:$4ACD; D4:($A6,$97,$D9,$2E,$A1,$13,$5D,$21));
  {$EXTERNALSYM GUID_MANIPULATION_PROCESSOR_DATA}

const
  SID_IRealTimeStylus = '{A8BB5D22-3144-4a7b-93CD-F34A16BE513A}';
  SID_IRealTimeStylus2 = '{B5F2A6CD-3179-4a3e-B9C4-BB5865962BE2}';
  SID_IRealTimeStylus3 = '{D70230A3-6986-4051-B57A-1CF69F4D9DB5}';
  SID_IRealTimeStylusSynchronization = '{AA87EAB8-AB4A-4cea-B5CB-46D84C6A2509}';
  SID_IStrokeBuilder = '{A5FD4E2D-C44B-4092-9177-260905EB672B}';
  SID_IStylusPlugin = '{A81436D8-4757-4fd1-A185-133F97C6C545}';
  SID_IStylusSyncPlugin = '{A157B174-482F-4d71-A3F6-3A41DDD11BE9}';
  SID_IStylusAsyncPlugin = '{A7CCA85A-31BC-4cd2-AADC-3289A3AF11C8}';
  SID_IDynamicRenderer = '{A079468E-7165-46f9-B7AF-98AD01A93009}';
  SID_IGestureRecognizer = '{AE9EF86B-7054-45e3-AE22-3174DC8811B7}';

  IID_IRealTimeStylus: TGUID = (
    D1:$A8BB5D22; D2:$3144; D3:$4A7B; D4:($93,$CD,$F3,$4A,$16,$BE,$51,$3A));
  {$EXTERNALSYM IID_IRealTimeStylus}
  IID_IRealTimeStylus2: TGUID = (
    D1:$B5F2A6CD; D2:$3179; D3:$4A3E; D4:($B9,$C4,$BB,$58,$65,$96,$2B,$E2));
  {$EXTERNALSYM IID_IRealTimeStylus2}
  IID_IRealTimeStylus3: TGUID = (
    D1:$D70230A3; D2:$6986; D3:$4051; D4:($B5,$7A,$1C,$F6,$9F,$4D,$9D,$B5));
  {$EXTERNALSYM IID_IRealTimeStylus3}
  IID_IRealTimeStylusSynchronization: TGUID = (
    D1:$AA87EAB8; D2:$AB4A; D3:$4CEA; D4:($B5,$CB,$46,$D8,$4C,$6A,$25,$09));
  {$EXTERNALSYM IID_IRealTimeStylusSynchronization}
  IID_IStrokeBuilder: TGUID = (
    D1:$A5FD4E2D; D2:$C44B; D3:$4092; D4:($91,$77,$26,$09,$05,$EB,$67,$2B));
  {$EXTERNALSYM IID_IStrokeBuilder}
  IID_IStylusPlugin: TGUID = (
    D1:$A81436D8; D2:$4757; D3:$4FD1; D4:($A1,$85,$13,$3F,$97,$C6,$C5,$45));
  {$EXTERNALSYM IID_IStylusPlugin}
  IID_IStylusSyncPlugin: TGUID = (
    D1:$A157B174; D2:$482F; D3:$4D71; D4:($A3,$F6,$3A,$41,$DD,$D1,$1B,$E9));
  {$EXTERNALSYM IID_IStylusSyncPlugin}
  IID_IStylusAsyncPlugin: TGUID = (
    D1:$A7CCA85A; D2:$31BC; D3:$4CD2; D4:($AA,$DC,$32,$89,$A3,$AF,$11,$C8));
  {$EXTERNALSYM IID_IStylusAsyncPlugin}
  IID_IDynamicRenderer: TGUID = (
    D1:$A079468E; D2:$7165; D3:$46F9; D4:($B7,$AF,$98,$AD,$01,$A9,$30,$09));
  {$EXTERNALSYM IID_IDynamicRenderer}
  IID_IGestureRecognizer: TGUID = (
    D1:$AE9EF86B; D2:$7054; D3:$45E3; D4:($AE,$22,$31,$74,$DC,$88,$11,$B7));
  {$EXTERNALSYM IID_IGestureRecognizer}

const
  CLSID_RealTimeStylus: TGUID = (
    D1:$E26B366D; D2:$F998; D3:$43CE; D4:($83,$6F,$CB,$6D,$90,$44,$32,$B0));
  {$EXTERNALSYM CLSID_RealTimeStylus}
  CLSID_DynamicRenderer: TGUID = (
    D1:$ECD32AEA; D2:$746F; D3:$4DCB; D4:($BF,$68,$08,$27,$57,$FA,$FF,$18));
  {$EXTERNALSYM CLSID_DynamicRenderer}
  CLSID_GestureRecognizer: TGUID = (
    D1:$EA30C654; D2:$C62C; D3:$441F; D4:($AC,$00,$95,$F9,$A1,$96,$78,$2C));
  {$EXTERNALSYM CLSID_GestureRecognizer}
  CLSID_StrokeBuilder: TGUID = (
    D1:$E810CEE7; D2:$6E51; D3:$4CB0; D4:($AA,$3A,$0B,$98,$5B,$70,$DA,$F7));
  {$EXTERNALSYM CLSID_StrokeBuilder}
  CLSID_ManipulationProcessorRTS: TGUID = (
    D1:$BAFEB74A; D2:$B117; D3:$4DD3; D4:($A5,$C5,$14,$03,$1F,$35,$59,$5E));
  {$EXTERNALSYM CLSID_ManipulationProcessorRTS}

{ Forward Declarations }

type
  IRealTimeStylus = interface;
  IRealTimeStylus2 = interface;
  IRealTimeStylus3 = interface;
  IRealTimeStylusSynchronization = interface;
  IStrokeBuilder = interface;
  IStylusPlugin = interface;
  IStylusSyncPlugin = interface;
  IStylusAsyncPlugin = interface;
  IDynamicRenderer = interface;
  IGestureRecognizer = interface;

  RealTimeStylusDataInterest = type Integer;
  {$EXTERNALSYM RealTimeStylusDataInterest}

  STYLUS_ID = CURSOR_ID;
  {$EXTERNALSYM STYLUS_ID}

  StylusInfo = record
    tcid: TABLET_CONTEXT_ID;
    cid: STYLUS_ID;
    bIsInvertedCursor: BOOL;
  end;
  TStylusInfo = StylusInfo;
  PStylusInfo = ^TStylusInfo;
  {$EXTERNALSYM StylusInfo}

  StylusQueue = type Integer;
  {$EXTERNALSYM StylusQueue}

  RealTimeStylusLockType = type Integer;
  {$EXTERNALSYM RealTimeStylusLockType}

  GESTURE_DATA = record
    gestureId: Integer;
    recoConfidence: Integer;
    strokeCount: Integer;
  end;
  TGestureData = GESTURE_DATA;
  PGestureData = ^TGestureData;
  {$EXTERNALSYM GESTURE_DATA}

  DYNAMIC_RENDERER_CACHED_DATA = record
    strokeId: Integer;
    dynamicRenderer: IDynamicRenderer;
  end;
  TDynamicRendererCachedData = DYNAMIC_RENDERER_CACHED_DATA;
  PDynamicRendererCachedData = ^TDynamicRendererCachedData;
  {$EXTERNALSYM DYNAMIC_RENDERER_CACHED_DATA}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRealTimeStylus);'}
  IRealTimeStylus = interface(IUnknown)
    [SID_IRealTimeStylus]
    function get_Enabled(var pfEnable: BOOL): HRESULT; stdcall;
    function put_Enabled(fEnable: BOOL): HRESULT; stdcall;
    function get_HWND(var phwnd: HANDLE_PTR): HRESULT; stdcall;
    function put_HWND(hwnd: HANDLE_PTR): HRESULT; stdcall;
    function get_WindowInputRectangle(var prcWndInputRect: TRect): HRESULT; stdcall;
    function put_WindowInputRectangle(const prcWndInputRect: TRect): HRESULT; stdcall;
    function AddStylusSyncPlugin(iIndex: Cardinal;
      piPlugin: IStylusSyncPlugin): HRESULT; stdcall;
    function RemoveStylusSyncPlugin(iIndex: Cardinal;
      var ppiPlugin: IStylusSyncPlugin): HRESULT; stdcall;
    function RemoveAllStylusSyncPlugins: HRESULT; stdcall;
    function GetStylusSyncPlugin(iIndex: Cardinal;
      var ppiPlugin: IStylusSyncPlugin): HRESULT; stdcall;
    function GetStylusSyncPluginCount(var pcPlugins: Cardinal): HRESULT; stdcall;
    function AddStylusAsyncPlugin(iIndex: Cardinal;
      piPlugin: IStylusAsyncPlugin): HRESULT; stdcall;
    function RemoveStylusAsyncPlugin(iIndex: Cardinal;
      var ppiPlugin: IStylusAsyncPlugin): HRESULT; stdcall;
    function RemoveAllStylusAsyncPlugins: HRESULT; stdcall;
    function GetStylusAsyncPlugin(iIndex: Cardinal;
      var ppiPlugin: IStylusAsyncPlugin): HRESULT; stdcall;
    function GetStylusAsyncPluginCount(var pcPlugins: Cardinal): HRESULT; stdcall;
    function get_ChildRealTimeStylusPlugin(var ppiRTS: IRealTimeStylus): HRESULT; stdcall;
    function putref_ChildRealTimeStylusPlugin(piRTS: IRealTimeStylus): HRESULT; stdcall;
    function AddCustomStylusDataToQueue(sq: StylusQueue; const pGuidId: TGUID;
      cbData: Cardinal; pbData: PByte): HRESULT; stdcall;
    function ClearStylusQueues: HRESULT; stdcall;
    function SetAllTabletsMode(fUseMouseForInput: BOOL): HRESULT; stdcall;
    function SetSingleTabletMode(piTablet: IInkTablet): HRESULT; stdcall;
    function GetTablet(var ppiSingleTablet: IInkTablet): HRESULT; stdcall;
    function GetTabletContextIdFromTablet(piTablet: IInkTablet;
      var ptcid: TABLET_CONTEXT_ID): HRESULT; stdcall;
    function GetTabletFromTabletContextId(tcid: TABLET_CONTEXT_ID;
      var ppiTablet: IInkTablet): HRESULT; stdcall;
    function GetAllTabletContextIds(pcTcidCount: Cardinal;
      var ppTcids: PTABLET_CONTEXT_ID): HRESULT; stdcall;
    function GetStyluses(var ppiInkCursors: Pointer): HRESULT; stdcall;
    function GetStylusForId(sid: STYLUS_ID; var ppiInkCursor: IInkCursor): HRESULT; stdcall;
    function SetDesiredPacketDescription(cProperties: Cardinal;
      const pPropertyGuids: TGUID): HRESULT; stdcall;
    function GetDesiredPacketDescription(var pcProperties: Cardinal;
      var ppPropertyGuids: PGUID): HRESULT; stdcall;
    function GetPacketDescriptionData(tcid: TABLET_CONTEXT_ID;
      var pfInkToDeviceScaleX: Single; var pfInkToDeviceScaleY: Single;
      var pcPacketProperties: Cardinal; var ppPacketProperties: PPacketProperty): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRealTimeStylus}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRealTimeStylus2);'}
  IRealTimeStylus2 = interface(IUnknown)
    [SID_IRealTimeStylus2]
    function get_FlicksEnabled(var pfEnable: BOOL): HRESULT; stdcall;
    function put_FlicksEnabled(fEnable: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRealTimeStylus2}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRealTimeStylus3);'}
  IRealTimeStylus3 = interface(IUnknown)
    [SID_IRealTimeStylus3]
    function get_MultiTouchEnabled(var pfEnable: BOOL): HRESULT; stdcall;
    function put_MultiTouchEnabled(fEnable: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRealTimeStylus3}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IRealTimeStylusSynchronization);'}
  IRealTimeStylusSynchronization = interface(IUnknown)
    [SID_IRealTimeStylusSynchronization]
    function AcquireLock(lock: RealTimeStylusLockType): HRESULT; stdcall;
    function ReleaseLock(lock: RealTimeStylusLockType): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRealTimeStylusSynchronization}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IStrokeBuilder);'}
  IStrokeBuilder = interface(IUnknown)
    [SID_IStrokeBuilder]
    function CreateStroke(cPktBuffLength: Cardinal; pPackets: PInteger;
      cPacketProperties: Cardinal; const pPacketProperties: PACKET_PROPERTY;
      fInkToDeviceScaleX: Single; fInkToDeviceScaleY: Single;
      var ppIInkStroke: IInkStrokeDisp): HRESULT; stdcall;
    function BeginStroke(tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID;
      pPacket: PInteger; cPacketProperties: Cardinal;
      const pPacketProperties: PACKET_PROPERTY; fInkToDeviceScaleX: Single;
      fInkToDeviceScaleY: Single;
      var ppIInkStroke: IInkStrokeDisp): HRESULT; stdcall;
    function AppendPackets(tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID;
      cPktBuffLength: Cardinal; pPackets: PInteger): HRESULT; stdcall;
    function EndStroke(tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID;
      var ppIInkStroke: IInkStrokeDisp; pDirtyRect: PRect): HRESULT; stdcall;
    function get_Ink(var ppiInkObj: IInkDisp): HRESULT; stdcall;
    function putref_Ink(piInkObj: IInkDisp): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IStrokeBuilder}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IStylusPlugin);'}
  IStylusPlugin = interface(IUnknown)
    [SID_IStylusPlugin]
    function RealTimeStylusEnabled(piRtsSrc: IRealTimeStylus;
      cTcidCount: Cardinal; var pTcids: TABLET_CONTEXT_ID): HRESULT; stdcall;
    function RealTimeStylusDisabled(piRtsSrc: IRealTimeStylus;
      cTcidCount: Cardinal; var pTcids: TABLET_CONTEXT_ID): HRESULT; stdcall;
    function StylusInRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
      sid: STYLUS_ID): HRESULT; stdcall;
    function StylusOutOfRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID; 
      sid: STYLUS_ID): HRESULT; stdcall;
    function StylusDown(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
      cPropCountPerPkt: Cardinal; pPacket: PInteger; var ppInOutPkt: PInteger): HRESULT; stdcall;
    function StylusUp(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
      cPropCountPerPkt: Cardinal; pPacket: PInteger; var ppInOutPkt: PInteger): HRESULT; stdcall;
    function StylusButtonDown(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
      const pGuidStylusButton: TGUID; var pStylusPos: TPoint): HRESULT; stdcall;
    function StylusButtonUp(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
      const pGuidStylusButton: TGUID; var pStylusPos: TPoint): HRESULT; stdcall;
    function InAirPackets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
      cPktCount: Cardinal; cPktBuffLength: Cardinal; pPackets: PInteger; 
      var pcInOutPkts: Cardinal; var ppInOutPkts: PInteger): HRESULT; stdcall;
    function Packets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
      cPktCount: Cardinal; cPktBuffLength: Cardinal; pPackets: PInteger;
      var pcInOutPkts: Cardinal; var ppInOutPkts: PInteger): HRESULT; stdcall;
    function CustomStylusDataAdded(piRtsSrc: IRealTimeStylus; const pGuidId: TGUID;
      cbData: Cardinal; pbData: PByte): HRESULT; stdcall;
    function SystemEvent(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
      sid: STYLUS_ID; event: SYSTEM_EVENT;
      eventdata: SYSTEM_EVENT_DATA): HRESULT; stdcall;
    function TabletAdded(piRtsSrc: IRealTimeStylus;
      piTablet: IInkTablet): HRESULT; stdcall;
    function TabletRemoved(piRtsSrc: IRealTimeStylus;
      iTabletIndex: Integer): HRESULT; stdcall;
    function Error(piRtsSrc: IRealTimeStylus; piPlugin: IStylusPlugin;
      dataInterest: RealTimeStylusDataInterest; hrErrorCode: HRESULT;
      var lptrKey: LONG_PTR): HRESULT; stdcall;
    function UpdateMapping(piRtsSrc: IRealTimeStylus): HRESULT; stdcall;
    function DataInterest(out pDataInterest: RealTimeStylusDataInterest): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IStylusPlugin}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IStylusSyncPlugin);'}
  IStylusSyncPlugin = interface(IStylusPlugin)
    [SID_IStylusSyncPlugin]
  end;
  {$EXTERNALSYM IStylusSyncPlugin}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IStylusAsyncPlugin);'}
  IStylusAsyncPlugin = interface(IStylusPlugin)
    [SID_IStylusAsyncPlugin]
  end;
  {$EXTERNALSYM IStylusAsyncPlugin}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDynamicRenderer);'}
  IDynamicRenderer = interface(IUnknown)
    [SID_IDynamicRenderer]
    function get_Enabled(var bEnabled: BOOL): HRESULT; stdcall;
    function put_Enabled(bEnabled: BOOL): HRESULT; stdcall;
    function get_HWND(var hwnd: HANDLE_PTR): HRESULT; stdcall;
    function put_HWND(hwnd: HANDLE_PTR): HRESULT; stdcall;
    function get_ClipRectangle(var prcClipRect: TRect): HRESULT; stdcall;
    function put_ClipRectangle(const prcClipRect: TRect): HRESULT; stdcall;
    function get_ClipRegion(var phClipRgn: HANDLE_PTR): HRESULT; stdcall;
    function put_ClipRegion(hClipRgn: HANDLE_PTR): HRESULT; stdcall;
    function get_DrawingAttributes(var ppiDA: IInkDrawingAttributes): HRESULT; stdcall;
    function putref_DrawingAttributes(piDA: IInkDrawingAttributes): HRESULT; stdcall;
    function get_DataCacheEnabled(var pfCacheData: BOOL): HRESULT; stdcall;
    function put_DataCacheEnabled(fCacheData: BOOL): HRESULT; stdcall;
    function ReleaseCachedData(strokeId: Cardinal): HRESULT; stdcall;
    function Refresh: HRESULT; stdcall;
    function Draw(hDC: HANDLE_PTR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDynamicRenderer}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IGestureRecognizer);'}
  IGestureRecognizer = interface(IUnknown)
    [SID_IGestureRecognizer]
    function get_Enabled(var pfEnabled: BOOL): HRESULT; stdcall;
    function put_Enabled(fEnabled: BOOL): HRESULT; stdcall;
    function get_MaxStrokeCount(var pcStrokes: Integer): HRESULT; stdcall;
    function put_MaxStrokeCount(cStrokes: Integer): HRESULT; stdcall;
    function EnableGestures(cGestures: Cardinal; pGestures: PInteger): HRESULT; stdcall;
    function Reset: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IGestureRecognizer}


implementation

end.
