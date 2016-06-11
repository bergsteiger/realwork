{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Mshtmhst;

{$WEAKPACKAGEUNIT}
(*$HPPEMIT '#include <mshtmhst.h>'*)

interface

uses Winapi.Windows, System.Classes, System.Variants, Winapi.ActiveX;

const

  DOCHOSTUIFLAG_FLAT_SCROLLBAR = $00000080;
  {$EXTERNALSYM DOCHOSTUIFLAG_FLAT_SCROLLBAR}
  DOCHOSTUIFLAG_SCROLL_NO = $00000008;
  {$EXTERNALSYM DOCHOSTUIFLAG_SCROLL_NO}
  DOCHOSTUIFLAG_NO3DBORDER = $00000004;
  {$EXTERNALSYM DOCHOSTUIFLAG_NO3DBORDER}
  DOCHOSTUIFLAG_DIALOG = $00000001;
  {$EXTERNALSYM DOCHOSTUIFLAG_DIALOG}
  DOCHOSTUIFLAG_THEME = $00040000;
  {$EXTERNALSYM DOCHOSTUIFLAG_THEME}
  DOCHOSTUIFLAG_NOTHEME = $00080000;
  {$EXTERNALSYM DOCHOSTUIFLAG_NOTHEME}

type

  TDocHostUIInfo = record
    cbSize: ULONG;
    dwFlags: DWORD;
    dwDoubleClick: DWORD;
    pchHostCss: PWChar;
    pchHostNS: PWChar;
  end;

  IDocHostShowUI = interface(IUnknown)
    ['{c4d244b0-d43e-11cf-893b-00aa00bdce1a}']
    function ShowMessage(hwnd: THandle;lpstrText: POLESTR;lpstrCaption: POLESTR; dwType: longint;lpstrHelpFile: POLESTR;dwHelpContext: longint; var plResult: LRESULT): HRESULT; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: POLESTR; uCommand: integer; dwData: longint; ptMouse: TPoint; var pDispachObjectHit: IDispatch): HRESULT; stdcall;
  end;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDocHostShowUI);'}
  {$EXTERNALSYM IDocHostShowUI}

  IDocHostUIHandler  = interface(IUnknown)
    ['{BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}']
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT; const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT; stdcall;
    function GetHostInfo(var pInfo: TDocHostUIInfo): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject; const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame; const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT; const pUIWindow: IOleInPlaceUIWindow; const FrameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup:  PGUID; const nCmdID: DWORD): HRESULT; stdcall;
    function GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD): HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget; out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POLESTR; var ppchURLOut: POLESTR): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HRESULT; stdcall;
  end;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDocHostUIHandler);'}
  {$EXTERNALSYM IDocHostUIHandler}

implementation

end.
