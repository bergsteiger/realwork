{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{**********************************
 ***         IMPORTANT          ***
 **********************************

 This file has been modified from it's original because TLIBIMP did not
 import the file correctly.

 }

unit idoc;

// ************************************************************************ //
// WARNING                                                                  //
// -------                                                                  //
// The types declared in this file were generated from data read from a     //
// Type Library. If this type library is explicitly or indirectly (via      //
// another type library referring to this type library) re-imported, or the //
// 'Refresh' command of the Type Library Editor activated while editing the //
// Type Library, the contents of this file will be regenerated and all      //
// manual modifications will be lost.                                       //
// ************************************************************************ //

// PASTLWTR : 1.3
// File generated on 10/29/98 2:00:55 PM from Type Library described below.

// ************************************************************************ //
// IID\LCID: {B86D6F26-EAAE-11D1-AAA7-00C04FB17523}\0
// Helpfile:
// HelpString: testidl 1.0 Type Library
// Version:    1.0
// ************************************************************************ //

interface

uses Winapi.Windows, Winapi.ActiveX, System.Classes, Vcl.Graphics, Vcl.OleCtrls,
  System.Win.StdVCL, MSHTML;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:      //
//   Type Libraries     : LIBID_xxxx                                    //
//   CoClasses          : CLASS_xxxx                                    //
//   DISPInterfaces     : DIID_xxxx                                     //
//   Non-DISP interfaces: IID_xxxx                                      //
// *********************************************************************//
const
  LIBID_TESTIDLLib: TGUID = '{B86D6F26-EAAE-11D1-AAA7-00C04FB17523}';
  IID_IDocHostShowUI: TGUID = '{C4D244B0-D43E-11CF-893B-00AA00BDCE1A}';
  IID_IDocHostUIHandler: TGUID = '{BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}';
  IID_IOleWindow: TGUID = '{00000114-0000-0000-C000-000000000046}';
  IID_IOleInPlaceActiveObject: TGUID = '{00000117-0000-0000-C000-000000000046}';
  IID_IOleInPlaceUIWindow: TGUID = '{00000115-0000-0000-C000-000000000046}';
  IID_IOleCommandTarget: TGUID = '{B722BCCB-4E68-101B-A2BC-00AA00404770}';
  IID_IOleInPlaceFrame: TGUID = '{00000116-0000-0000-C000-000000000046}';
  IID_IDropTarget: TGUID = '{00000122-0000-0000-C000-000000000046}';
  IID_IDataObject: TGUID = '{0000010E-0000-0000-C000-000000000046}';
  IID_IEnumFORMATETC: TGUID = '{00000103-0000-0000-C000-000000000046}';
  IID_IAdviseSink: TGUID = '{0000010F-0000-0000-C000-000000000046}';
  IID_IAsyncManager: TGUID = '{0000002A-0000-0000-C000-000000000046}';
  IID_IPersist: TGUID = '{0000010C-0000-0000-C000-000000000046}';
  IID_IPersistStream: TGUID = '{00000109-0000-0000-C000-000000000046}';
  IID_IMoniker: TGUID = '{0000000F-0000-0000-C000-000000000046}';
  IID_ISequentialStream: TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_IStream: TGUID = '{0000000C-0000-0000-C000-000000000046}';
  IID_IBindCtx: TGUID = '{0000000E-0000-0000-C000-000000000046}';
  IID_IRunningObjectTable: TGUID = '{00000010-0000-0000-C000-000000000046}';
  IID_IEnumMoniker: TGUID = '{00000102-0000-0000-C000-000000000046}';
  IID_IEnumString: TGUID = '{00000101-0000-0000-C000-000000000046}';
  IID_IEnumSTATDATA: TGUID = '{00000105-0000-0000-C000-000000000046}';
  CLASS_FakeCoClass: TGUID = '{B86D6F34-EAAE-11D1-AAA7-00C04FB17523}';

type

// *********************************************************************//
// Forward declaration of interfaces defined in Type Library            //
// *********************************************************************//
  IDocHostShowUI = interface;
  IDocHostUIHandler = interface;
  IAsyncManager = interface;

// *********************************************************************//
// Declaration of structures, unions and aliases.                       //
// *********************************************************************//
  wireHWND = ^_RemotableHandle;

  PtagPoint = ^tagPOINT;
  tagPOINT = record
    x: Integer;
    y: Integer;
  end;

  _DOCHOSTUIINFO = record
    cbSize: UINT;
    dwFlags: UINT;
    dwDoubleClick: UINT;
    pchHostCss: POLESTR;
    pchHostNS: POLESTR;
  end;

// *********************************************************************//
// Interface: IDocHostShowUI
// Flags:     (0)
// GUID:      {C4D244B0-D43E-11CF-893B-00AA00BDCE1A}
// *********************************************************************//
  IDocHostShowUI = interface(IUnknown)
    ['{C4D244B0-D43E-11CF-893B-00AA00BDCE1A}']
    function ShowMessage(hwnd: THandle;lpstrText: POLESTR;lpstrCaption: POLESTR;
                         dwType: longint;lpstrHelpFile: POLESTR;dwHelpContext: longint;
                         var plResult: LRESULT): HRESULT; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: POLESTR; uCommand: UINT;
                      dwData: longint; ptMouse: TPoint; var pDispachObjectHit: IDispatch): HRESULT; stdcall;
  end;

// *********************************************************************//
// Interface: IDocHostUIHandler
// Flags:     (0)
// GUID:      {BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}
// *********************************************************************//
  IDocHostUIHandler = interface(IUnknown)
    ['{BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}']
    function ShowContextMenu(dwID: UINT; ppt: PtagPOINT; const pcmdtReserved: IUnknown;
                             const pdispReserved: IDispatch): HResult; stdcall;
    function GetHostInfo(var pInfo: _DOCHOSTUIINFO): HResult; stdcall;
    function ShowUI(dwID: UINT; const pActiveObject: IOleInPlaceActiveObject;
                    const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
                    const pDoc: IOleInPlaceUIWindow): HResult; stdcall;
    function HideUI: HResult; stdcall;
    function UpdateUI: HResult; stdcall;
    function EnableModeless(fEnable: Integer): HResult; stdcall;
    function OnDocWindowActivate(fActivate: Integer): HResult; stdcall;
    function OnFrameWindowActivate(fActivate: Integer): HResult; stdcall;
    function ResizeBorder(var prcBorder: tagRECT; const pUIWindow: IOleInPlaceUIWindow;
                          fRameWindow: Integer): HResult; stdcall;
    function TranslateAccelerator(var lpmsg: tagMSG; var pguidCmdGroup: TGUID; nCmdID: UINT): HResult; stdcall;
    function GetOptionKeyPath(out pchKey: PWideChar; dw: UINT): HResult; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget; out ppDropTarget: IDropTarget): HResult; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HResult; stdcall;
    function TranslateUrl(dwTranslate: UINT; pchURLIn: PWideChar; out ppchURLOut: PWideChar): HResult; stdcall;
    function FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HResult; stdcall;
  end;

  IDocHostUIHandler2 = interface(IDocHostUIHandler)
    ['{3050f6d0-98b5-11cf-bb82-00aa00bdce0b}']
    function GetOverrideKeyPath(out pchKey: PWideChar; dw: DWORD): HRESULT; stdcall;
  end;

// *********************************************************************//
// Interface: IAsyncManager
// Flags:     (0)
// GUID:      {0000002A-0000-0000-C000-000000000046}
// *********************************************************************//
  IAsyncManager = interface(IUnknown)
    ['{0000002A-0000-0000-C000-000000000046}']
    function CompleteCall(Result_: HResult): HResult; stdcall;
    function GetCallContext(var riid: TGUID; out pInterface: Pointer): HResult; stdcall;
    function GetState(out pulStateFlags: UINT): HResult; stdcall;
  end;

implementation

end.

