// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 48730 $
// File generated on 16/05/2012 18:13:47 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\system32\shdocvw.dll (1)
// LIBID: {EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}
// LCID: 0
// Helpfile: 
// HelpString: Microsoft Internet Controls
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: Symbol 'WebBrowser_V1' renamed to 'CppWebBrowser_V1'
//   Hint: Symbol 'WebBrowser' renamed to 'CppWebBrowser'
//   Hint: Symbol 'InternetExplorer' renamed to 'CppInternetExplorer'
//   Hint: Symbol 'ShellBrowserWindow' renamed to 'CppShellBrowserWindow'
//   Hint: Symbol 'ShellWindows' renamed to 'CppShellWindows'
//   Hint: Symbol 'ShellUIHelper' renamed to 'CppShellUIHelper'
//   Hint: Symbol 'ShellNameSpace' renamed to 'ShellFavoritesNameSpace'
//   Hint: Symbol 'CScriptErrorList' renamed to 'CppCScriptErrorList'
// Cmdline:
//   tlibimp  -C+ -G+ -Cv- -HpaInternet -HpsServers -D.\cppie5 C:\Windows\system32\shdocvw.dll
// ************************************************************************ //

#include <vcl.h>
#pragma hdrstop

#include <Vcl.OleCtrls.hpp>
#include <Vcl.OleServer.hpp>
#if defined(USING_ATL)
#include <atl\atlvcl.h>
#endif

#pragma option -w-8122
#include "SHDocVw_OCX.h"

#if !defined(__PRAGMA_PACKAGE_SMART_INIT)
#define      __PRAGMA_PACKAGE_SMART_INIT
#pragma package(smart_init)
#endif

namespace Shdocvw_tlb
{



// *********************************************************************//
// OCX PROXY CLASS IMPLEMENTATION
// (The following variables/methods implement the class TCppWebBrowser which
// allows "WebBrowser Control" to be hosted in CBuilder IDE/apps).
// *********************************************************************//
int   TCppWebBrowser::EventDispIDs[38] = {
    0x00000066, 0x0000006C, 0x00000069, 0x0000006A, 0x00000068, 0x00000071,
    0x00000070, 0x000000FA, 0x000000FB, 0x000000FC, 0x00000103, 0x000000FD,
    0x000000FE, 0x000000FF, 0x00000100, 0x00000101, 0x00000102, 0x00000104,
    0x00000106, 0x00000108, 0x00000109, 0x0000010A, 0x0000010B, 0x00000107,
    0x0000010C, 0x0000010D, 0x0000010E, 0x0000010F, 0x000000E1, 0x000000E2,
    0x000000E3, 0x00000110, 0x00000111, 0x0000011A, 0x0000011B, 0x0000011C,
    0x0000011D, 0x0000011E};

Vcl::Olectrls::TControlData2 TCppWebBrowser::CControlData =
{
  // GUID of CoClass and Event Interface of Control
  {0x8856F961, 0x340A, 0x11D0,{ 0xA9, 0x6B, 0x00,0xC0, 0x4F, 0xD7,0x05, 0xA2} }, // CoClass
  {0x34A715A0, 0x6587, 0x11D0,{ 0x92, 0x4A, 0x00,0x20, 0xAF, 0xC7,0xAC, 0x4D} }, // Events

  // Count of Events and array of their DISPIDs
  38, &EventDispIDs,

  // Pointer to Runtime License string
  NULL,  // HRESULT(0x80040111)

  // Flags for OnChanged PropertyNotification
  0x00000000,
  401,// (IDE Version)

  // Count of Font Prop and array of their DISPIDs
  0, Winapi::Activex::PDispIDList(NULL),

  // Count of Pict Prop and array of their DISPIDs
  0, Winapi::Activex::PDispIDList(NULL),
  0, // Reserved
  0, // Instance count (used internally)
  0, // List of Enum descriptions (internal)
};

GUID     TCppWebBrowser::DEF_CTL_INTF = {0xD30C1661, 0xCDAF, 0x11D0,{ 0x8A, 0x3E, 0x00,0xC0, 0x4F, 0xC9,0xE2, 0x6E} };
TNoParam TCppWebBrowser::OptParam;

static inline void ValidCtrCheck(TCppWebBrowser *)
{
   delete new TCppWebBrowser((System::Classes::TComponent*)(0));
};

void __fastcall TCppWebBrowser::InitControlData()
{
  ControlData = (Vcl::Olectrls::TControlData*)&CControlData;
  CControlData.FirstEventOfs = System::PByte(&FOnStatusTextChange) - System::PByte(this);
};

void __fastcall TCppWebBrowser::CreateControl()
{
  if (!m_OCXIntf)
  {
    _ASSERTE(DefaultDispatch);
    DefaultDispatch->QueryInterface(DEF_CTL_INTF, (LPVOID*)&m_OCXIntf);
  }
};

IWebBrowser2Disp __fastcall TCppWebBrowser::GetDefaultInterface()
{
  System::FSetExceptMask(System::femALLEXCEPT);
  CreateControl();
  return m_OCXIntf;
};

void __fastcall TCppWebBrowser::GoBack(void)
{
  GetDefaultInterface()->GoBack();
}

void __fastcall TCppWebBrowser::GoForward(void)
{
  GetDefaultInterface()->GoForward();
}

void __fastcall TCppWebBrowser::GoHome(void)
{
  GetDefaultInterface()->GoHome();
}

void __fastcall TCppWebBrowser::GoSearch(void)
{
  GetDefaultInterface()->GoSearch();
}

void __fastcall TCppWebBrowser::Navigate(BSTR URL/*[in]*/, VARIANT* Flags/*[in,opt]*/, 
                                         VARIANT* TargetFrameName/*[in,opt]*/, 
                                         VARIANT* PostData/*[in,opt]*/, VARIANT* Headers/*[in,opt]*/)
{
  GetDefaultInterface()->Navigate(URL/*[in]*/, Flags/*[in,opt]*/, TargetFrameName/*[in,opt]*/, 
                                  PostData/*[in,opt]*/, Headers/*[in,opt]*/);
}

void __fastcall TCppWebBrowser::Refresh(void)
{
  GetDefaultInterface()->Refresh();
}

void __fastcall TCppWebBrowser::Refresh2(VARIANT* Level/*[in,opt]*/)
{
  GetDefaultInterface()->Refresh2(Level/*[in,opt]*/);
}

void __fastcall TCppWebBrowser::Stop(void)
{
  GetDefaultInterface()->Stop();
}

void __fastcall TCppWebBrowser::Quit(void)
{
  GetDefaultInterface()->Quit();
}

void __fastcall TCppWebBrowser::ClientToWindow(int* pcx/*[in,out]*/, int* pcy/*[in,out]*/)
{
  GetDefaultInterface()->ClientToWindow(pcx/*[in,out]*/, pcy/*[in,out]*/);
}

void __fastcall TCppWebBrowser::PutProperty(BSTR Property/*[in]*/, VARIANT vtValue/*[in]*/)
{
  GetDefaultInterface()->PutProperty(Property/*[in]*/, vtValue/*[in]*/);
}

VARIANT __fastcall TCppWebBrowser::GetProperty(BSTR Property/*[in]*/)
{
  VARIANT pvtValue;
  OLECHECK(GetDefaultInterface()->GetProperty(Property, (VARIANT*)&pvtValue));
  return pvtValue;
}

void __fastcall TCppWebBrowser::Navigate2(VARIANT* URL/*[in]*/, VARIANT* Flags/*[in,opt]*/, 
                                          VARIANT* TargetFrameName/*[in,opt]*/, 
                                          VARIANT* PostData/*[in,opt]*/, 
                                          VARIANT* Headers/*[in,opt]*/)
{
  GetDefaultInterface()->Navigate2(URL/*[in]*/, Flags/*[in,opt]*/, TargetFrameName/*[in,opt]*/, 
                                   PostData/*[in,opt]*/, Headers/*[in,opt]*/);
}

Shdocvw_tlb::OLECMDF __fastcall TCppWebBrowser::QueryStatusWB(Shdocvw_tlb::OLECMDID cmdID/*[in]*/)
{
  Shdocvw_tlb::OLECMDF pcmdf;
  OLECHECK(GetDefaultInterface()->QueryStatusWB(cmdID, (Shdocvw_tlb::OLECMDF*)&pcmdf));
  return pcmdf;
}

void __fastcall TCppWebBrowser::ExecWB(Shdocvw_tlb::OLECMDID cmdID/*[in]*/, 
                                       Shdocvw_tlb::OLECMDEXECOPT cmdexecopt/*[in]*/, 
                                       VARIANT* pvaIn/*[in,opt]*/, VARIANT* pvaOut/*[in,out,opt]*/)
{
  GetDefaultInterface()->ExecWB(cmdID/*[in]*/, cmdexecopt/*[in]*/, pvaIn/*[in,opt]*/, 
                                pvaOut/*[in,out,opt]*/);
}

void __fastcall TCppWebBrowser::ShowBrowserBar(VARIANT* pvaClsid/*[in]*/, 
                                               VARIANT* pvarShow/*[in,opt]*/, 
                                               VARIANT* pvarSize/*[in,opt]*/)
{
  GetDefaultInterface()->ShowBrowserBar(pvaClsid/*[in]*/, pvarShow/*[in,opt]*/, pvarSize/*[in,opt]*/);
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppWebBrowser::get_Application(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Application((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppWebBrowser::get_Parent(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Parent((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppWebBrowser::get_Container(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Container((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppWebBrowser::get_Document(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Document((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:
long __fastcall TCppWebBrowser::get_HWND(void)
{
  long pHWND;
  OLECHECK(GetDefaultInterface()->get_HWND((long*)&pHWND));
  return pHWND;
}

IWebBrowser2Ptr& TCppInternetExplorer::GetDefaultInterface()
{
  if (!m_DefaultIntf)
    Connect();
  return m_DefaultIntf;
}

_di_IUnknown __fastcall TCppInternetExplorer::GetDunk()
{
  _di_IUnknown diUnk;
  if (m_DefaultIntf) {
    IUnknownPtr punk = m_DefaultIntf;
    diUnk = LPUNKNOWN(punk);
  }
  return diUnk;
}

void __fastcall TCppInternetExplorer::Connect()
{
  if (!m_DefaultIntf) {
    _di_IUnknown punk = GetServer();
    m_DefaultIntf = punk;
    if (ServerData->EventIID != GUID_NULL)
      ConnectEvents(GetDunk());
  }
}

void __fastcall TCppInternetExplorer::Disconnect()
{
  if (m_DefaultIntf) {

    if (ServerData->EventIID != GUID_NULL)
      DisconnectEvents(GetDunk());
    m_DefaultIntf.Reset();
  }
}

void __fastcall TCppInternetExplorer::BeforeDestruction()
{
  Disconnect();
}

void __fastcall TCppInternetExplorer::ConnectTo(IWebBrowser2Ptr intf)
{
  Disconnect();
  m_DefaultIntf = intf;
  if (ServerData->EventIID != GUID_NULL)
    ConnectEvents(GetDunk());
}

void __fastcall TCppInternetExplorer::InitServerData()
{
  static Vcl::Oleserver::TServerData sd;
  sd.ClassID = CLSID_CppInternetExplorer;
  sd.IntfIID = __uuidof(IWebBrowser2);
  sd.EventIID= __uuidof(DWebBrowserEvents2);
  ServerData = &sd;
}

void __fastcall TCppInternetExplorer::InvokeEvent(int id, Vcl::Oleserver::TVariantArray& params)
{
  switch(id)
  {
    case 102: {
      if (OnStatusTextChange) {
        (OnStatusTextChange)(this, params[0].bstrVal);
      }
      break;
      }
    case 108: {
      if (OnProgressChange) {
        (OnProgressChange)(this, params[0], params[1]);
      }
      break;
      }
    case 105: {
      if (OnCommandStateChange) {
        (OnCommandStateChange)(this, params[0], params[1]);
      }
      break;
      }
    case 106: {
      if (OnDownloadBegin) {
        (OnDownloadBegin)(this);
      }
      break;
      }
    case 104: {
      if (OnDownloadComplete) {
        (OnDownloadComplete)(this);
      }
      break;
      }
    case 113: {
      if (OnTitleChange) {
        (OnTitleChange)(this, params[0].bstrVal);
      }
      break;
      }
    case 112: {
      if (OnPropertyChange) {
        (OnPropertyChange)(this, params[0].bstrVal);
      }
      break;
      }
    case 250: {
      if (OnBeforeNavigate2) {
        (OnBeforeNavigate2)(this, params[0].pdispVal, params[1], params[2], params[3], params[4], params[5], params[6].pboolVal);
      }
      break;
      }
    case 251: {
      if (OnNewWindow2) {
        (OnNewWindow2)(this, params[0].ppdispVal, params[1].pboolVal);
      }
      break;
      }
    case 252: {
      if (OnNavigateComplete2) {
        (OnNavigateComplete2)(this, params[0].pdispVal, params[1]);
      }
      break;
      }
    case 259: {
      if (OnDocumentComplete) {
        (OnDocumentComplete)(this, params[0].pdispVal, params[1]);
      }
      break;
      }
    case 253: {
      if (OnQuit) {
        (OnQuit)(this);
      }
      break;
      }
    case 254: {
      if (OnVisible) {
        (OnVisible)(this, params[0]);
      }
      break;
      }
    case 255: {
      if (OnToolBar) {
        (OnToolBar)(this, params[0]);
      }
      break;
      }
    case 256: {
      if (OnMenuBar) {
        (OnMenuBar)(this, params[0]);
      }
      break;
      }
    case 257: {
      if (OnStatusBar) {
        (OnStatusBar)(this, params[0]);
      }
      break;
      }
    case 258: {
      if (OnFullScreen) {
        (OnFullScreen)(this, params[0]);
      }
      break;
      }
    case 260: {
      if (OnTheaterMode) {
        (OnTheaterMode)(this, params[0]);
      }
      break;
      }
    case 262: {
      if (OnWindowSetResizable) {
        (OnWindowSetResizable)(this, params[0]);
      }
      break;
      }
    case 264: {
      if (OnWindowSetLeft) {
        (OnWindowSetLeft)(this, params[0]);
      }
      break;
      }
    case 265: {
      if (OnWindowSetTop) {
        (OnWindowSetTop)(this, params[0]);
      }
      break;
      }
    case 266: {
      if (OnWindowSetWidth) {
        (OnWindowSetWidth)(this, params[0]);
      }
      break;
      }
    case 267: {
      if (OnWindowSetHeight) {
        (OnWindowSetHeight)(this, params[0]);
      }
      break;
      }
    case 263: {
      if (OnWindowClosing) {
        (OnWindowClosing)(this, params[0], params[1].pboolVal);
      }
      break;
      }
    case 268: {
      if (OnClientToHostWindow) {
        (OnClientToHostWindow)(this, params[0].plVal, params[1].plVal);
      }
      break;
      }
    case 269: {
      if (OnSetSecureLockIcon) {
        (OnSetSecureLockIcon)(this, params[0]);
      }
      break;
      }
    case 270: {
      if (OnFileDownload) {
        (OnFileDownload)(this, params[0], params[1].pboolVal);
      }
      break;
      }
    case 271: {
      if (OnNavigateError) {
        (OnNavigateError)(this, params[0].pdispVal, params[1], params[2], params[3], params[4].pboolVal);
      }
      break;
      }
    case 225: {
      if (OnPrintTemplateInstantiation) {
        (OnPrintTemplateInstantiation)(this, params[0].pdispVal);
      }
      break;
      }
    case 226: {
      if (OnPrintTemplateTeardown) {
        (OnPrintTemplateTeardown)(this, params[0].pdispVal);
      }
      break;
      }
    case 227: {
      if (OnUpdatePageStatus) {
        (OnUpdatePageStatus)(this, params[0].pdispVal, params[1], params[2]);
      }
      break;
      }
    case 272: {
      if (OnPrivacyImpactedStateChange) {
        (OnPrivacyImpactedStateChange)(this, params[0]);
      }
      break;
      }
    case 273: {
      if (OnNewWindow3) {
        (OnNewWindow3)(this, params[0].ppdispVal, params[1].pboolVal, params[2], params[3].bstrVal, params[4].bstrVal);
      }
      break;
      }
    case 282: {
      if (OnSetPhishingFilterStatus) {
        (OnSetPhishingFilterStatus)(this, params[0]);
      }
      break;
      }
    case 283: {
      if (OnWindowStateChanged) {
        (OnWindowStateChanged)(this, params[0], params[1]);
      }
      break;
      }
    case 284: {
      if (OnNewProcess) {
        (OnNewProcess)(this, params[0], params[1].pdispVal, params[2].pboolVal);
      }
      break;
      }
    case 285: {
      if (OnThirdPartyUrlBlocked) {
        (OnThirdPartyUrlBlocked)(this, params[0], params[1]);
      }
      break;
      }
    case 286: {
      if (OnRedirectXDomainBlocked) {
        (OnRedirectXDomainBlocked)(this, params[0].pdispVal, params[1], params[2], params[3], params[4]);
      }
      break;
      }
    default:
      break;
  }
}

void __fastcall TCppInternetExplorer::GoBack(void)
{
  GetDefaultInterface()->GoBack();
}

void __fastcall TCppInternetExplorer::GoForward(void)
{
  GetDefaultInterface()->GoForward();
}

void __fastcall TCppInternetExplorer::GoHome(void)
{
  GetDefaultInterface()->GoHome();
}

void __fastcall TCppInternetExplorer::GoSearch(void)
{
  GetDefaultInterface()->GoSearch();
}

void __fastcall TCppInternetExplorer::Navigate(BSTR URL/*[in]*/, VARIANT* Flags/*[in,opt]*/, 
                                               VARIANT* TargetFrameName/*[in,opt]*/, 
                                               VARIANT* PostData/*[in,opt]*/, 
                                               VARIANT* Headers/*[in,opt]*/)
{
  GetDefaultInterface()->Navigate(URL/*[in]*/, Flags/*[in,opt]*/, TargetFrameName/*[in,opt]*/, 
                                  PostData/*[in,opt]*/, Headers/*[in,opt]*/);
}

void __fastcall TCppInternetExplorer::Refresh(void)
{
  GetDefaultInterface()->Refresh();
}

void __fastcall TCppInternetExplorer::Refresh2(VARIANT* Level/*[in,opt]*/)
{
  GetDefaultInterface()->Refresh2(Level/*[in,opt]*/);
}

void __fastcall TCppInternetExplorer::Stop(void)
{
  GetDefaultInterface()->Stop();
}

void __fastcall TCppInternetExplorer::Quit(void)
{
  GetDefaultInterface()->Quit();
}

void __fastcall TCppInternetExplorer::ClientToWindow(int* pcx/*[in,out]*/, int* pcy/*[in,out]*/)
{
  GetDefaultInterface()->ClientToWindow(pcx/*[in,out]*/, pcy/*[in,out]*/);
}

void __fastcall TCppInternetExplorer::PutProperty(BSTR Property/*[in]*/, VARIANT vtValue/*[in]*/)
{
  GetDefaultInterface()->PutProperty(Property/*[in]*/, vtValue/*[in]*/);
}

VARIANT __fastcall TCppInternetExplorer::GetProperty(BSTR Property/*[in]*/)
{
  VARIANT pvtValue;
  OLECHECK(GetDefaultInterface()->GetProperty(Property, (VARIANT*)&pvtValue));
  return pvtValue;
}

void __fastcall TCppInternetExplorer::Navigate2(VARIANT* URL/*[in]*/, VARIANT* Flags/*[in,opt]*/, 
                                                VARIANT* TargetFrameName/*[in,opt]*/, 
                                                VARIANT* PostData/*[in,opt]*/, 
                                                VARIANT* Headers/*[in,opt]*/)
{
  GetDefaultInterface()->Navigate2(URL/*[in]*/, Flags/*[in,opt]*/, TargetFrameName/*[in,opt]*/, 
                                   PostData/*[in,opt]*/, Headers/*[in,opt]*/);
}

Shdocvw_tlb::OLECMDF __fastcall TCppInternetExplorer::QueryStatusWB(Shdocvw_tlb::OLECMDID cmdID/*[in]*/)
{
  Shdocvw_tlb::OLECMDF pcmdf;
  OLECHECK(GetDefaultInterface()->QueryStatusWB(cmdID, (Shdocvw_tlb::OLECMDF*)&pcmdf));
  return pcmdf;
}

void __fastcall TCppInternetExplorer::ExecWB(Shdocvw_tlb::OLECMDID cmdID/*[in]*/, 
                                             Shdocvw_tlb::OLECMDEXECOPT cmdexecopt/*[in]*/, 
                                             VARIANT* pvaIn/*[in,opt]*/, 
                                             VARIANT* pvaOut/*[in,out,opt]*/)
{
  GetDefaultInterface()->ExecWB(cmdID/*[in]*/, cmdexecopt/*[in]*/, pvaIn/*[in,opt]*/, 
                                pvaOut/*[in,out,opt]*/);
}

void __fastcall TCppInternetExplorer::ShowBrowserBar(VARIANT* pvaClsid/*[in]*/, 
                                                     VARIANT* pvarShow/*[in,opt]*/, 
                                                     VARIANT* pvarSize/*[in,opt]*/)
{
  GetDefaultInterface()->ShowBrowserBar(pvaClsid/*[in]*/, pvarShow/*[in,opt]*/, pvarSize/*[in,opt]*/);
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppInternetExplorer::get_Application(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Application((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppInternetExplorer::get_Parent(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Parent((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppInternetExplorer::get_Container(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Container((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TCppInternetExplorer::get_Document(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Document((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_TopLevelContainer(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_TopLevelContainer((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WideString
BSTR __fastcall TCppInternetExplorer::get_Type(void)
{
  BSTR Type = 0;
  OLECHECK(GetDefaultInterface()->get_Type((BSTR*)&Type));
  return Type;
}

// StdProp:Integer
long __fastcall TCppInternetExplorer::get_Left(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Left((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TCppInternetExplorer::set_Left(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Left(pl/*[in]*/);
}

// StdProp:Integer
long __fastcall TCppInternetExplorer::get_Top(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Top((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TCppInternetExplorer::set_Top(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Top(pl/*[in]*/);
}

// StdProp:Integer
long __fastcall TCppInternetExplorer::get_Width(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Width((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TCppInternetExplorer::set_Width(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Width(pl/*[in]*/);
}

// StdProp:Integer
long __fastcall TCppInternetExplorer::get_Height(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Height((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TCppInternetExplorer::set_Height(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Height(pl/*[in]*/);
}

// StdProp:WideString
BSTR __fastcall TCppInternetExplorer::get_LocationName(void)
{
  BSTR LocationName = 0;
  OLECHECK(GetDefaultInterface()->get_LocationName((BSTR*)&LocationName));
  return LocationName;
}

// StdProp:WideString
BSTR __fastcall TCppInternetExplorer::get_LocationURL(void)
{
  BSTR LocationURL = 0;
  OLECHECK(GetDefaultInterface()->get_LocationURL((BSTR*)&LocationURL));
  return LocationURL;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_Busy(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_Busy((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WideString
BSTR __fastcall TCppInternetExplorer::get_Name(void)
{
  BSTR Name = 0;
  OLECHECK(GetDefaultInterface()->get_Name((BSTR*)&Name));
  return Name;
}

// StdProp:
long __fastcall TCppInternetExplorer::get_HWND(void)
{
  long pHWND;
  OLECHECK(GetDefaultInterface()->get_HWND((long*)&pHWND));
  return pHWND;
}

// StdProp:WideString
BSTR __fastcall TCppInternetExplorer::get_FullName(void)
{
  BSTR FullName = 0;
  OLECHECK(GetDefaultInterface()->get_FullName((BSTR*)&FullName));
  return FullName;
}

// StdProp:WideString
BSTR __fastcall TCppInternetExplorer::get_Path(void)
{
  BSTR Path = 0;
  OLECHECK(GetDefaultInterface()->get_Path((BSTR*)&Path));
  return Path;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_Visible(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_Visible((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_Visible(VARIANT_BOOL pBool/*[in]*/)
{
  GetDefaultInterface()->set_Visible(pBool/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_StatusBar(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_StatusBar((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_StatusBar(VARIANT_BOOL pBool/*[in]*/)
{
  GetDefaultInterface()->set_StatusBar(pBool/*[in]*/);
}

// StdProp:WideString
BSTR __fastcall TCppInternetExplorer::get_StatusText(void)
{
  BSTR StatusText = 0;
  OLECHECK(GetDefaultInterface()->get_StatusText((BSTR*)&StatusText));
  return StatusText;
}

// StdProp:WideString
void __fastcall TCppInternetExplorer::set_StatusText(BSTR StatusText/*[in]*/)
{
  GetDefaultInterface()->set_StatusText(StatusText/*[in]*/);
}

// StdProp:Integer
int __fastcall TCppInternetExplorer::get_ToolBar(void)
{
  int Value;
  OLECHECK(GetDefaultInterface()->get_ToolBar((int*)&Value));
  return Value;
}

// StdProp:Integer
void __fastcall TCppInternetExplorer::set_ToolBar(int Value/*[in]*/)
{
  GetDefaultInterface()->set_ToolBar(Value/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_MenuBar(void)
{
  VARIANT_BOOL Value;
  OLECHECK(GetDefaultInterface()->get_MenuBar((VARIANT_BOOL*)&Value));
  return Value;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_MenuBar(VARIANT_BOOL Value/*[in]*/)
{
  GetDefaultInterface()->set_MenuBar(Value/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_FullScreen(void)
{
  VARIANT_BOOL pbFullScreen;
  OLECHECK(GetDefaultInterface()->get_FullScreen((VARIANT_BOOL*)&pbFullScreen));
  return pbFullScreen;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_FullScreen(VARIANT_BOOL pbFullScreen/*[in]*/)
{
  GetDefaultInterface()->set_FullScreen(pbFullScreen/*[in]*/);
}

// StdProp:TOleEnum
Shdocvw_tlb::tagREADYSTATE __fastcall TCppInternetExplorer::get_ReadyState(void)
{
  Shdocvw_tlb::tagREADYSTATE plReadyState;
  OLECHECK(GetDefaultInterface()->get_ReadyState((Shdocvw_tlb::tagREADYSTATE*)&plReadyState));
  return plReadyState;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_Offline(void)
{
  VARIANT_BOOL pbOffline;
  OLECHECK(GetDefaultInterface()->get_Offline((VARIANT_BOOL*)&pbOffline));
  return pbOffline;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_Offline(VARIANT_BOOL pbOffline/*[in]*/)
{
  GetDefaultInterface()->set_Offline(pbOffline/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_Silent(void)
{
  VARIANT_BOOL pbSilent;
  OLECHECK(GetDefaultInterface()->get_Silent((VARIANT_BOOL*)&pbSilent));
  return pbSilent;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_Silent(VARIANT_BOOL pbSilent/*[in]*/)
{
  GetDefaultInterface()->set_Silent(pbSilent/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_RegisterAsBrowser(void)
{
  VARIANT_BOOL pbRegister;
  OLECHECK(GetDefaultInterface()->get_RegisterAsBrowser((VARIANT_BOOL*)&pbRegister));
  return pbRegister;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_RegisterAsBrowser(VARIANT_BOOL pbRegister/*[in]*/)
{
  GetDefaultInterface()->set_RegisterAsBrowser(pbRegister/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_RegisterAsDropTarget(void)
{
  VARIANT_BOOL pbRegister;
  OLECHECK(GetDefaultInterface()->get_RegisterAsDropTarget((VARIANT_BOOL*)&pbRegister));
  return pbRegister;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_RegisterAsDropTarget(VARIANT_BOOL pbRegister/*[in]*/)
{
  GetDefaultInterface()->set_RegisterAsDropTarget(pbRegister/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_TheaterMode(void)
{
  VARIANT_BOOL pbRegister;
  OLECHECK(GetDefaultInterface()->get_TheaterMode((VARIANT_BOOL*)&pbRegister));
  return pbRegister;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_TheaterMode(VARIANT_BOOL pbRegister/*[in]*/)
{
  GetDefaultInterface()->set_TheaterMode(pbRegister/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_AddressBar(void)
{
  VARIANT_BOOL Value;
  OLECHECK(GetDefaultInterface()->get_AddressBar((VARIANT_BOOL*)&Value));
  return Value;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_AddressBar(VARIANT_BOOL Value/*[in]*/)
{
  GetDefaultInterface()->set_AddressBar(Value/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TCppInternetExplorer::get_Resizable(void)
{
  VARIANT_BOOL Value;
  OLECHECK(GetDefaultInterface()->get_Resizable((VARIANT_BOOL*)&Value));
  return Value;
}

// StdProp:WordBool
void __fastcall TCppInternetExplorer::set_Resizable(VARIANT_BOOL Value/*[in]*/)
{
  GetDefaultInterface()->set_Resizable(Value/*[in]*/);
}

IWebBrowser2Ptr& TInternetExplorerMedium::GetDefaultInterface()
{
  if (!m_DefaultIntf)
    Connect();
  return m_DefaultIntf;
}

_di_IUnknown __fastcall TInternetExplorerMedium::GetDunk()
{
  _di_IUnknown diUnk;
  if (m_DefaultIntf) {
    IUnknownPtr punk = m_DefaultIntf;
    diUnk = LPUNKNOWN(punk);
  }
  return diUnk;
}

void __fastcall TInternetExplorerMedium::Connect()
{
  if (!m_DefaultIntf) {
    _di_IUnknown punk = GetServer();
    m_DefaultIntf = punk;
    if (ServerData->EventIID != GUID_NULL)
      ConnectEvents(GetDunk());
  }
}

void __fastcall TInternetExplorerMedium::Disconnect()
{
  if (m_DefaultIntf) {

    if (ServerData->EventIID != GUID_NULL)
      DisconnectEvents(GetDunk());
    m_DefaultIntf.Reset();
  }
}

void __fastcall TInternetExplorerMedium::BeforeDestruction()
{
  Disconnect();
}

void __fastcall TInternetExplorerMedium::ConnectTo(IWebBrowser2Ptr intf)
{
  Disconnect();
  m_DefaultIntf = intf;
  if (ServerData->EventIID != GUID_NULL)
    ConnectEvents(GetDunk());
}

void __fastcall TInternetExplorerMedium::InitServerData()
{
  static Vcl::Oleserver::TServerData sd;
  sd.ClassID = CLSID_InternetExplorerMedium;
  sd.IntfIID = __uuidof(IWebBrowser2);
  sd.EventIID= __uuidof(DWebBrowserEvents2);
  ServerData = &sd;
}

void __fastcall TInternetExplorerMedium::InvokeEvent(int id, Vcl::Oleserver::TVariantArray& params)
{
  switch(id)
  {
    case 102: {
      if (OnStatusTextChange) {
        (OnStatusTextChange)(this, params[0].bstrVal);
      }
      break;
      }
    case 108: {
      if (OnProgressChange) {
        (OnProgressChange)(this, params[0], params[1]);
      }
      break;
      }
    case 105: {
      if (OnCommandStateChange) {
        (OnCommandStateChange)(this, params[0], params[1]);
      }
      break;
      }
    case 106: {
      if (OnDownloadBegin) {
        (OnDownloadBegin)(this);
      }
      break;
      }
    case 104: {
      if (OnDownloadComplete) {
        (OnDownloadComplete)(this);
      }
      break;
      }
    case 113: {
      if (OnTitleChange) {
        (OnTitleChange)(this, params[0].bstrVal);
      }
      break;
      }
    case 112: {
      if (OnPropertyChange) {
        (OnPropertyChange)(this, params[0].bstrVal);
      }
      break;
      }
    case 250: {
      if (OnBeforeNavigate2) {
        (OnBeforeNavigate2)(this, params[0].pdispVal, params[1], params[2], params[3], params[4], params[5], params[6].pboolVal);
      }
      break;
      }
    case 251: {
      if (OnNewWindow2) {
        (OnNewWindow2)(this, params[0].ppdispVal, params[1].pboolVal);
      }
      break;
      }
    case 252: {
      if (OnNavigateComplete2) {
        (OnNavigateComplete2)(this, params[0].pdispVal, params[1]);
      }
      break;
      }
    case 259: {
      if (OnDocumentComplete) {
        (OnDocumentComplete)(this, params[0].pdispVal, params[1]);
      }
      break;
      }
    case 253: {
      if (OnQuit) {
        (OnQuit)(this);
      }
      break;
      }
    case 254: {
      if (OnVisible) {
        (OnVisible)(this, params[0]);
      }
      break;
      }
    case 255: {
      if (OnToolBar) {
        (OnToolBar)(this, params[0]);
      }
      break;
      }
    case 256: {
      if (OnMenuBar) {
        (OnMenuBar)(this, params[0]);
      }
      break;
      }
    case 257: {
      if (OnStatusBar) {
        (OnStatusBar)(this, params[0]);
      }
      break;
      }
    case 258: {
      if (OnFullScreen) {
        (OnFullScreen)(this, params[0]);
      }
      break;
      }
    case 260: {
      if (OnTheaterMode) {
        (OnTheaterMode)(this, params[0]);
      }
      break;
      }
    case 262: {
      if (OnWindowSetResizable) {
        (OnWindowSetResizable)(this, params[0]);
      }
      break;
      }
    case 264: {
      if (OnWindowSetLeft) {
        (OnWindowSetLeft)(this, params[0]);
      }
      break;
      }
    case 265: {
      if (OnWindowSetTop) {
        (OnWindowSetTop)(this, params[0]);
      }
      break;
      }
    case 266: {
      if (OnWindowSetWidth) {
        (OnWindowSetWidth)(this, params[0]);
      }
      break;
      }
    case 267: {
      if (OnWindowSetHeight) {
        (OnWindowSetHeight)(this, params[0]);
      }
      break;
      }
    case 263: {
      if (OnWindowClosing) {
        (OnWindowClosing)(this, params[0], params[1].pboolVal);
      }
      break;
      }
    case 268: {
      if (OnClientToHostWindow) {
        (OnClientToHostWindow)(this, params[0].plVal, params[1].plVal);
      }
      break;
      }
    case 269: {
      if (OnSetSecureLockIcon) {
        (OnSetSecureLockIcon)(this, params[0]);
      }
      break;
      }
    case 270: {
      if (OnFileDownload) {
        (OnFileDownload)(this, params[0], params[1].pboolVal);
      }
      break;
      }
    case 271: {
      if (OnNavigateError) {
        (OnNavigateError)(this, params[0].pdispVal, params[1], params[2], params[3], params[4].pboolVal);
      }
      break;
      }
    case 225: {
      if (OnPrintTemplateInstantiation) {
        (OnPrintTemplateInstantiation)(this, params[0].pdispVal);
      }
      break;
      }
    case 226: {
      if (OnPrintTemplateTeardown) {
        (OnPrintTemplateTeardown)(this, params[0].pdispVal);
      }
      break;
      }
    case 227: {
      if (OnUpdatePageStatus) {
        (OnUpdatePageStatus)(this, params[0].pdispVal, params[1], params[2]);
      }
      break;
      }
    case 272: {
      if (OnPrivacyImpactedStateChange) {
        (OnPrivacyImpactedStateChange)(this, params[0]);
      }
      break;
      }
    case 273: {
      if (OnNewWindow3) {
        (OnNewWindow3)(this, params[0].ppdispVal, params[1].pboolVal, params[2], params[3].bstrVal, params[4].bstrVal);
      }
      break;
      }
    case 282: {
      if (OnSetPhishingFilterStatus) {
        (OnSetPhishingFilterStatus)(this, params[0]);
      }
      break;
      }
    case 283: {
      if (OnWindowStateChanged) {
        (OnWindowStateChanged)(this, params[0], params[1]);
      }
      break;
      }
    case 284: {
      if (OnNewProcess) {
        (OnNewProcess)(this, params[0], params[1].pdispVal, params[2].pboolVal);
      }
      break;
      }
    case 285: {
      if (OnThirdPartyUrlBlocked) {
        (OnThirdPartyUrlBlocked)(this, params[0], params[1]);
      }
      break;
      }
    case 286: {
      if (OnRedirectXDomainBlocked) {
        (OnRedirectXDomainBlocked)(this, params[0].pdispVal, params[1], params[2], params[3], params[4]);
      }
      break;
      }
    default:
      break;
  }
}

void __fastcall TInternetExplorerMedium::GoBack(void)
{
  GetDefaultInterface()->GoBack();
}

void __fastcall TInternetExplorerMedium::GoForward(void)
{
  GetDefaultInterface()->GoForward();
}

void __fastcall TInternetExplorerMedium::GoHome(void)
{
  GetDefaultInterface()->GoHome();
}

void __fastcall TInternetExplorerMedium::GoSearch(void)
{
  GetDefaultInterface()->GoSearch();
}

void __fastcall TInternetExplorerMedium::Navigate(BSTR URL/*[in]*/, VARIANT* Flags/*[in,opt]*/, 
                                                  VARIANT* TargetFrameName/*[in,opt]*/, 
                                                  VARIANT* PostData/*[in,opt]*/, 
                                                  VARIANT* Headers/*[in,opt]*/)
{
  GetDefaultInterface()->Navigate(URL/*[in]*/, Flags/*[in,opt]*/, TargetFrameName/*[in,opt]*/, 
                                  PostData/*[in,opt]*/, Headers/*[in,opt]*/);
}

void __fastcall TInternetExplorerMedium::Refresh(void)
{
  GetDefaultInterface()->Refresh();
}

void __fastcall TInternetExplorerMedium::Refresh2(VARIANT* Level/*[in,opt]*/)
{
  GetDefaultInterface()->Refresh2(Level/*[in,opt]*/);
}

void __fastcall TInternetExplorerMedium::Stop(void)
{
  GetDefaultInterface()->Stop();
}

void __fastcall TInternetExplorerMedium::Quit(void)
{
  GetDefaultInterface()->Quit();
}

void __fastcall TInternetExplorerMedium::ClientToWindow(int* pcx/*[in,out]*/, int* pcy/*[in,out]*/)
{
  GetDefaultInterface()->ClientToWindow(pcx/*[in,out]*/, pcy/*[in,out]*/);
}

void __fastcall TInternetExplorerMedium::PutProperty(BSTR Property/*[in]*/, VARIANT vtValue/*[in]*/)
{
  GetDefaultInterface()->PutProperty(Property/*[in]*/, vtValue/*[in]*/);
}

VARIANT __fastcall TInternetExplorerMedium::GetProperty(BSTR Property/*[in]*/)
{
  VARIANT pvtValue;
  OLECHECK(GetDefaultInterface()->GetProperty(Property, (VARIANT*)&pvtValue));
  return pvtValue;
}

void __fastcall TInternetExplorerMedium::Navigate2(VARIANT* URL/*[in]*/, VARIANT* Flags/*[in,opt]*/, 
                                                   VARIANT* TargetFrameName/*[in,opt]*/, 
                                                   VARIANT* PostData/*[in,opt]*/, 
                                                   VARIANT* Headers/*[in,opt]*/)
{
  GetDefaultInterface()->Navigate2(URL/*[in]*/, Flags/*[in,opt]*/, TargetFrameName/*[in,opt]*/, 
                                   PostData/*[in,opt]*/, Headers/*[in,opt]*/);
}

Shdocvw_tlb::OLECMDF __fastcall TInternetExplorerMedium::QueryStatusWB(Shdocvw_tlb::OLECMDID cmdID/*[in]*/)
{
  Shdocvw_tlb::OLECMDF pcmdf;
  OLECHECK(GetDefaultInterface()->QueryStatusWB(cmdID, (Shdocvw_tlb::OLECMDF*)&pcmdf));
  return pcmdf;
}

void __fastcall TInternetExplorerMedium::ExecWB(Shdocvw_tlb::OLECMDID cmdID/*[in]*/, 
                                                Shdocvw_tlb::OLECMDEXECOPT cmdexecopt/*[in]*/, 
                                                VARIANT* pvaIn/*[in,opt]*/, 
                                                VARIANT* pvaOut/*[in,out,opt]*/)
{
  GetDefaultInterface()->ExecWB(cmdID/*[in]*/, cmdexecopt/*[in]*/, pvaIn/*[in,opt]*/, 
                                pvaOut/*[in,out,opt]*/);
}

void __fastcall TInternetExplorerMedium::ShowBrowserBar(VARIANT* pvaClsid/*[in]*/, 
                                                        VARIANT* pvarShow/*[in,opt]*/, 
                                                        VARIANT* pvarSize/*[in,opt]*/)
{
  GetDefaultInterface()->ShowBrowserBar(pvaClsid/*[in]*/, pvarShow/*[in,opt]*/, pvarSize/*[in,opt]*/);
}

// StdProp:IDispatch
LPDISPATCH __fastcall TInternetExplorerMedium::get_Application(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Application((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TInternetExplorerMedium::get_Parent(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Parent((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TInternetExplorerMedium::get_Container(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Container((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:IDispatch
LPDISPATCH __fastcall TInternetExplorerMedium::get_Document(void)
{
  LPDISPATCH ppDisp;
  OLECHECK(GetDefaultInterface()->get_Document((LPDISPATCH*)&ppDisp));
  return ppDisp;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_TopLevelContainer(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_TopLevelContainer((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WideString
BSTR __fastcall TInternetExplorerMedium::get_Type(void)
{
  BSTR Type = 0;
  OLECHECK(GetDefaultInterface()->get_Type((BSTR*)&Type));
  return Type;
}

// StdProp:Integer
long __fastcall TInternetExplorerMedium::get_Left(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Left((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TInternetExplorerMedium::set_Left(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Left(pl/*[in]*/);
}

// StdProp:Integer
long __fastcall TInternetExplorerMedium::get_Top(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Top((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TInternetExplorerMedium::set_Top(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Top(pl/*[in]*/);
}

// StdProp:Integer
long __fastcall TInternetExplorerMedium::get_Width(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Width((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TInternetExplorerMedium::set_Width(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Width(pl/*[in]*/);
}

// StdProp:Integer
long __fastcall TInternetExplorerMedium::get_Height(void)
{
  long pl;
  OLECHECK(GetDefaultInterface()->get_Height((long*)&pl));
  return pl;
}

// StdProp:Integer
void __fastcall TInternetExplorerMedium::set_Height(long pl/*[in]*/)
{
  GetDefaultInterface()->set_Height(pl/*[in]*/);
}

// StdProp:WideString
BSTR __fastcall TInternetExplorerMedium::get_LocationName(void)
{
  BSTR LocationName = 0;
  OLECHECK(GetDefaultInterface()->get_LocationName((BSTR*)&LocationName));
  return LocationName;
}

// StdProp:WideString
BSTR __fastcall TInternetExplorerMedium::get_LocationURL(void)
{
  BSTR LocationURL = 0;
  OLECHECK(GetDefaultInterface()->get_LocationURL((BSTR*)&LocationURL));
  return LocationURL;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_Busy(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_Busy((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WideString
BSTR __fastcall TInternetExplorerMedium::get_Name(void)
{
  BSTR Name = 0;
  OLECHECK(GetDefaultInterface()->get_Name((BSTR*)&Name));
  return Name;
}

// StdProp:
long __fastcall TInternetExplorerMedium::get_HWND(void)
{
  long pHWND;
  OLECHECK(GetDefaultInterface()->get_HWND((long*)&pHWND));
  return pHWND;
}

// StdProp:WideString
BSTR __fastcall TInternetExplorerMedium::get_FullName(void)
{
  BSTR FullName = 0;
  OLECHECK(GetDefaultInterface()->get_FullName((BSTR*)&FullName));
  return FullName;
}

// StdProp:WideString
BSTR __fastcall TInternetExplorerMedium::get_Path(void)
{
  BSTR Path = 0;
  OLECHECK(GetDefaultInterface()->get_Path((BSTR*)&Path));
  return Path;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_Visible(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_Visible((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_Visible(VARIANT_BOOL pBool/*[in]*/)
{
  GetDefaultInterface()->set_Visible(pBool/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_StatusBar(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_StatusBar((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_StatusBar(VARIANT_BOOL pBool/*[in]*/)
{
  GetDefaultInterface()->set_StatusBar(pBool/*[in]*/);
}

// StdProp:WideString
BSTR __fastcall TInternetExplorerMedium::get_StatusText(void)
{
  BSTR StatusText = 0;
  OLECHECK(GetDefaultInterface()->get_StatusText((BSTR*)&StatusText));
  return StatusText;
}

// StdProp:WideString
void __fastcall TInternetExplorerMedium::set_StatusText(BSTR StatusText/*[in]*/)
{
  GetDefaultInterface()->set_StatusText(StatusText/*[in]*/);
}

// StdProp:Integer
int __fastcall TInternetExplorerMedium::get_ToolBar(void)
{
  int Value;
  OLECHECK(GetDefaultInterface()->get_ToolBar((int*)&Value));
  return Value;
}

// StdProp:Integer
void __fastcall TInternetExplorerMedium::set_ToolBar(int Value/*[in]*/)
{
  GetDefaultInterface()->set_ToolBar(Value/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_MenuBar(void)
{
  VARIANT_BOOL Value;
  OLECHECK(GetDefaultInterface()->get_MenuBar((VARIANT_BOOL*)&Value));
  return Value;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_MenuBar(VARIANT_BOOL Value/*[in]*/)
{
  GetDefaultInterface()->set_MenuBar(Value/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_FullScreen(void)
{
  VARIANT_BOOL pbFullScreen;
  OLECHECK(GetDefaultInterface()->get_FullScreen((VARIANT_BOOL*)&pbFullScreen));
  return pbFullScreen;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_FullScreen(VARIANT_BOOL pbFullScreen/*[in]*/)
{
  GetDefaultInterface()->set_FullScreen(pbFullScreen/*[in]*/);
}

// StdProp:TOleEnum
Shdocvw_tlb::tagREADYSTATE __fastcall TInternetExplorerMedium::get_ReadyState(void)
{
  Shdocvw_tlb::tagREADYSTATE plReadyState;
  OLECHECK(GetDefaultInterface()->get_ReadyState((Shdocvw_tlb::tagREADYSTATE*)&plReadyState));
  return plReadyState;
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_Offline(void)
{
  VARIANT_BOOL pbOffline;
  OLECHECK(GetDefaultInterface()->get_Offline((VARIANT_BOOL*)&pbOffline));
  return pbOffline;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_Offline(VARIANT_BOOL pbOffline/*[in]*/)
{
  GetDefaultInterface()->set_Offline(pbOffline/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_Silent(void)
{
  VARIANT_BOOL pbSilent;
  OLECHECK(GetDefaultInterface()->get_Silent((VARIANT_BOOL*)&pbSilent));
  return pbSilent;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_Silent(VARIANT_BOOL pbSilent/*[in]*/)
{
  GetDefaultInterface()->set_Silent(pbSilent/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_RegisterAsBrowser(void)
{
  VARIANT_BOOL pbRegister;
  OLECHECK(GetDefaultInterface()->get_RegisterAsBrowser((VARIANT_BOOL*)&pbRegister));
  return pbRegister;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_RegisterAsBrowser(VARIANT_BOOL pbRegister/*[in]*/)
{
  GetDefaultInterface()->set_RegisterAsBrowser(pbRegister/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_RegisterAsDropTarget(void)
{
  VARIANT_BOOL pbRegister;
  OLECHECK(GetDefaultInterface()->get_RegisterAsDropTarget((VARIANT_BOOL*)&pbRegister));
  return pbRegister;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_RegisterAsDropTarget(VARIANT_BOOL pbRegister/*[in]*/)
{
  GetDefaultInterface()->set_RegisterAsDropTarget(pbRegister/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_TheaterMode(void)
{
  VARIANT_BOOL pbRegister;
  OLECHECK(GetDefaultInterface()->get_TheaterMode((VARIANT_BOOL*)&pbRegister));
  return pbRegister;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_TheaterMode(VARIANT_BOOL pbRegister/*[in]*/)
{
  GetDefaultInterface()->set_TheaterMode(pbRegister/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_AddressBar(void)
{
  VARIANT_BOOL Value;
  OLECHECK(GetDefaultInterface()->get_AddressBar((VARIANT_BOOL*)&Value));
  return Value;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_AddressBar(VARIANT_BOOL Value/*[in]*/)
{
  GetDefaultInterface()->set_AddressBar(Value/*[in]*/);
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TInternetExplorerMedium::get_Resizable(void)
{
  VARIANT_BOOL Value;
  OLECHECK(GetDefaultInterface()->get_Resizable((VARIANT_BOOL*)&Value));
  return Value;
}

// StdProp:WordBool
void __fastcall TInternetExplorerMedium::set_Resizable(VARIANT_BOOL Value/*[in]*/)
{
  GetDefaultInterface()->set_Resizable(Value/*[in]*/);
}

IShellWindowsPtr& TCppShellWindows::GetDefaultInterface()
{
  if (!m_DefaultIntf)
    Connect();
  return m_DefaultIntf;
}

_di_IUnknown __fastcall TCppShellWindows::GetDunk()
{
  _di_IUnknown diUnk;
  if (m_DefaultIntf) {
    IUnknownPtr punk = m_DefaultIntf;
    diUnk = LPUNKNOWN(punk);
  }
  return diUnk;
}

void __fastcall TCppShellWindows::Connect()
{
  if (!m_DefaultIntf) {
    _di_IUnknown punk = GetServer();
    m_DefaultIntf = punk;
    if (ServerData->EventIID != GUID_NULL)
      ConnectEvents(GetDunk());
  }
}

void __fastcall TCppShellWindows::Disconnect()
{
  if (m_DefaultIntf) {

    if (ServerData->EventIID != GUID_NULL)
      DisconnectEvents(GetDunk());
    m_DefaultIntf.Reset();
  }
}

void __fastcall TCppShellWindows::BeforeDestruction()
{
  Disconnect();
}

void __fastcall TCppShellWindows::ConnectTo(IShellWindowsPtr intf)
{
  Disconnect();
  m_DefaultIntf = intf;
  if (ServerData->EventIID != GUID_NULL)
    ConnectEvents(GetDunk());
}

void __fastcall TCppShellWindows::InitServerData()
{
  static Vcl::Oleserver::TServerData sd;
  sd.ClassID = CLSID_CppShellWindows;
  sd.IntfIID = __uuidof(IShellWindows);
  sd.EventIID= __uuidof(DShellWindowsEvents);
  ServerData = &sd;
}

void __fastcall TCppShellWindows::InvokeEvent(int id, Vcl::Oleserver::TVariantArray& params)
{
  switch(id)
  {
    case 200: {
      if (OnWindowRegistered) {
        (OnWindowRegistered)(this, params[0]);
      }
      break;
      }
    case 201: {
      if (OnWindowRevoked) {
        (OnWindowRevoked)(this, params[0]);
      }
      break;
      }
    default:
      break;
  }
}

LPDISPATCH __fastcall TCppShellWindows::Item(VARIANT index/*[in,opt]*/)
{
  LPDISPATCH Folder;
  OLECHECK(GetDefaultInterface()->Item(index, (LPDISPATCH*)&Folder));
  return Folder;
}

LPUNKNOWN __fastcall TCppShellWindows::_NewEnum(void)
{
  LPUNKNOWN ppunk;
  OLECHECK(GetDefaultInterface()->_NewEnum((LPUNKNOWN*)&ppunk));
  return ppunk;
}

void __fastcall TCppShellWindows::Register(LPDISPATCH pid/*[in]*/, long HWND/*[in]*/, 
                                           int swClass/*[in]*/, long* plCookie/*[out]*/)
{
  GetDefaultInterface()->Register(pid/*[in]*/, HWND/*[in]*/, swClass/*[in]*/, plCookie/*[out]*/);
}

void __fastcall TCppShellWindows::RegisterPending(long lThreadId/*[in]*/, VARIANT* pvarloc/*[in]*/, 
                                                  VARIANT* pvarlocRoot/*[in]*/, int swClass/*[in]*/, 
                                                  long* plCookie/*[out]*/)
{
  GetDefaultInterface()->RegisterPending(lThreadId/*[in]*/, pvarloc/*[in]*/, pvarlocRoot/*[in]*/, 
                                         swClass/*[in]*/, plCookie/*[out]*/);
}

void __fastcall TCppShellWindows::Revoke(long lCookie/*[in]*/)
{
  GetDefaultInterface()->Revoke(lCookie/*[in]*/);
}

void __fastcall TCppShellWindows::OnNavigate(long lCookie/*[in]*/, VARIANT* pvarloc/*[in]*/)
{
  GetDefaultInterface()->OnNavigate(lCookie/*[in]*/, pvarloc/*[in]*/);
}

void __fastcall TCppShellWindows::OnActivated(long lCookie/*[in]*/, VARIANT_BOOL fActive/*[in]*/)
{
  GetDefaultInterface()->OnActivated(lCookie/*[in]*/, fActive/*[in]*/);
}

LPDISPATCH __fastcall TCppShellWindows::FindWindowSW(VARIANT* pvarloc/*[in]*/, 
                                                     VARIANT* pvarlocRoot/*[in]*/, 
                                                     int swClass/*[in]*/, long* pHWND/*[out]*/, 
                                                     int swfwOptions/*[in]*/)
{
  LPDISPATCH ppdispOut;
  OLECHECK(GetDefaultInterface()->FindWindowSW(pvarloc, pvarlocRoot, swClass, pHWND, swfwOptions, (LPDISPATCH*)&ppdispOut));
  return ppdispOut;
}

void __fastcall TCppShellWindows::OnCreated(long lCookie/*[in]*/, LPUNKNOWN punk/*[in]*/)
{
  GetDefaultInterface()->OnCreated(lCookie/*[in]*/, punk/*[in]*/);
}

void __fastcall TCppShellWindows::ProcessAttachDetach(VARIANT_BOOL fAttach/*[in]*/)
{
  GetDefaultInterface()->ProcessAttachDetach(fAttach/*[in]*/);
}

// StdProp:Integer
long __fastcall TCppShellWindows::get_Count(void)
{
  long Count;
  OLECHECK(GetDefaultInterface()->get_Count((long*)&Count));
  return Count;
}

IShellUIHelper3Ptr& TCppShellUIHelper::GetDefaultInterface()
{
  if (!m_DefaultIntf)
    Connect();
  return m_DefaultIntf;
}

_di_IUnknown __fastcall TCppShellUIHelper::GetDunk()
{
  _di_IUnknown diUnk;
  if (m_DefaultIntf) {
    IUnknownPtr punk = m_DefaultIntf;
    diUnk = LPUNKNOWN(punk);
  }
  return diUnk;
}

void __fastcall TCppShellUIHelper::Connect()
{
  if (!m_DefaultIntf) {
    _di_IUnknown punk = GetServer();
    m_DefaultIntf = punk;
    if (ServerData->EventIID != GUID_NULL)
      ConnectEvents(GetDunk());
  }
}

void __fastcall TCppShellUIHelper::Disconnect()
{
  if (m_DefaultIntf) {

    if (ServerData->EventIID != GUID_NULL)
      DisconnectEvents(GetDunk());
    m_DefaultIntf.Reset();
  }
}

void __fastcall TCppShellUIHelper::BeforeDestruction()
{
  Disconnect();
}

void __fastcall TCppShellUIHelper::ConnectTo(IShellUIHelper3Ptr intf)
{
  Disconnect();
  m_DefaultIntf = intf;
  if (ServerData->EventIID != GUID_NULL)
    ConnectEvents(GetDunk());
}

void __fastcall TCppShellUIHelper::InitServerData()
{
  static Vcl::Oleserver::TServerData sd;
  sd.ClassID = CLSID_CppShellUIHelper;
  sd.IntfIID = __uuidof(IShellUIHelper3);
  sd.EventIID= GUID_NULL;
  ServerData = &sd;
}

void __fastcall TCppShellUIHelper::ResetFirstBootMode(void)
{
  GetDefaultInterface()->ResetFirstBootMode();
}

void __fastcall TCppShellUIHelper::ResetSafeMode(void)
{
  GetDefaultInterface()->ResetSafeMode();
}

void __fastcall TCppShellUIHelper::RefreshOfflineDesktop(void)
{
  GetDefaultInterface()->RefreshOfflineDesktop();
}

void __fastcall TCppShellUIHelper::AddFavorite(BSTR URL/*[in]*/, VARIANT* Title/*[in,opt]*/)
{
  GetDefaultInterface()->AddFavorite(URL/*[in]*/, Title/*[in,opt]*/);
}

void __fastcall TCppShellUIHelper::AddChannel(BSTR URL/*[in]*/)
{
  GetDefaultInterface()->AddChannel(URL/*[in]*/);
}

void __fastcall TCppShellUIHelper::AddDesktopComponent(BSTR URL/*[in]*/, BSTR Type/*[in]*/, 
                                                       VARIANT* Left/*[in,opt]*/, 
                                                       VARIANT* Top/*[in,opt]*/, 
                                                       VARIANT* Width/*[in,opt]*/, 
                                                       VARIANT* Height/*[in,opt]*/)
{
  GetDefaultInterface()->AddDesktopComponent(URL/*[in]*/, Type/*[in]*/, Left/*[in,opt]*/, 
                                             Top/*[in,opt]*/, Width/*[in,opt]*/, Height/*[in,opt]*/);
}

VARIANT_BOOL __fastcall TCppShellUIHelper::IsSubscribed(BSTR URL/*[in]*/)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->IsSubscribed(URL, (VARIANT_BOOL*)&pBool));
  return pBool;
}

void __fastcall TCppShellUIHelper::NavigateAndFind(BSTR URL/*[in]*/, BSTR strQuery/*[in]*/, 
                                                   VARIANT* varTargetFrame/*[in]*/)
{
  GetDefaultInterface()->NavigateAndFind(URL/*[in]*/, strQuery/*[in]*/, varTargetFrame/*[in]*/);
}

void __fastcall TCppShellUIHelper::ImportExportFavorites(VARIANT_BOOL fImport/*[in]*/, 
                                                         BSTR strImpExpPath/*[in]*/)
{
  GetDefaultInterface()->ImportExportFavorites(fImport/*[in]*/, strImpExpPath/*[in]*/);
}

void __fastcall TCppShellUIHelper::AutoCompleteSaveForm(VARIANT* Form/*[in,opt]*/)
{
  GetDefaultInterface()->AutoCompleteSaveForm(Form/*[in,opt]*/);
}

void __fastcall TCppShellUIHelper::AutoScan(BSTR strSearch/*[in]*/, BSTR strFailureUrl/*[in]*/, 
                                            VARIANT* pvarTargetFrame/*[in,opt]*/)
{
  GetDefaultInterface()->AutoScan(strSearch/*[in]*/, strFailureUrl/*[in]*/, 
                                  pvarTargetFrame/*[in,opt]*/);
}

void __fastcall TCppShellUIHelper::AutoCompleteAttach(VARIANT* Reserved/*[in,opt]*/)
{
  GetDefaultInterface()->AutoCompleteAttach(Reserved/*[in,opt]*/);
}

VARIANT __fastcall TCppShellUIHelper::ShowBrowserUI(BSTR bstrName/*[in]*/, VARIANT* pvarIn/*[in]*/)
{
  VARIANT pvarOut;
  OLECHECK(GetDefaultInterface()->ShowBrowserUI(bstrName, pvarIn, (VARIANT*)&pvarOut));
  return pvarOut;
}

void __fastcall TCppShellUIHelper::AddSearchProvider(BSTR URL/*[in]*/)
{
  GetDefaultInterface()->AddSearchProvider(URL/*[in]*/);
}

void __fastcall TCppShellUIHelper::RunOnceShown(void)
{
  GetDefaultInterface()->RunOnceShown();
}

void __fastcall TCppShellUIHelper::SkipRunOnce(void)
{
  GetDefaultInterface()->SkipRunOnce();
}

void __fastcall TCppShellUIHelper::CustomizeSettings(VARIANT_BOOL fSQM/*[in]*/, 
                                                     VARIANT_BOOL fPhishing/*[in]*/, 
                                                     BSTR bstrLocale/*[in]*/)
{
  GetDefaultInterface()->CustomizeSettings(fSQM/*[in]*/, fPhishing/*[in]*/, bstrLocale/*[in]*/);
}

VARIANT_BOOL __fastcall TCppShellUIHelper::SqmEnabled(void)
{
  VARIANT_BOOL pfEnabled;
  OLECHECK(GetDefaultInterface()->SqmEnabled((VARIANT_BOOL*)&pfEnabled));
  return pfEnabled;
}

VARIANT_BOOL __fastcall TCppShellUIHelper::PhishingEnabled(void)
{
  VARIANT_BOOL pfEnabled;
  OLECHECK(GetDefaultInterface()->PhishingEnabled((VARIANT_BOOL*)&pfEnabled));
  return pfEnabled;
}

BSTR __fastcall TCppShellUIHelper::BrandImageUri(void)
{
  BSTR pbstrUri = 0;
  OLECHECK(GetDefaultInterface()->BrandImageUri((BSTR*)&pbstrUri));
  return pbstrUri;
}

void __fastcall TCppShellUIHelper::SkipTabsWelcome(void)
{
  GetDefaultInterface()->SkipTabsWelcome();
}

void __fastcall TCppShellUIHelper::DiagnoseConnection(void)
{
  GetDefaultInterface()->DiagnoseConnection();
}

void __fastcall TCppShellUIHelper::CustomizeClearType(VARIANT_BOOL fSet/*[in]*/)
{
  GetDefaultInterface()->CustomizeClearType(fSet/*[in]*/);
}

unsigned_long __fastcall TCppShellUIHelper::IsSearchProviderInstalled(BSTR URL/*[in]*/)
{
  unsigned_long pdwResult;
  OLECHECK(GetDefaultInterface()->IsSearchProviderInstalled(URL, (unsigned_long*)&pdwResult));
  return pdwResult;
}

VARIANT_BOOL __fastcall TCppShellUIHelper::IsSearchMigrated(void)
{
  VARIANT_BOOL pfMigrated;
  OLECHECK(GetDefaultInterface()->IsSearchMigrated((VARIANT_BOOL*)&pfMigrated));
  return pfMigrated;
}

BSTR __fastcall TCppShellUIHelper::DefaultSearchProvider(void)
{
  BSTR pbstrName = 0;
  OLECHECK(GetDefaultInterface()->DefaultSearchProvider((BSTR*)&pbstrName));
  return pbstrName;
}

void __fastcall TCppShellUIHelper::RunOnceRequiredSettingsComplete(VARIANT_BOOL fComplete/*[in]*/)
{
  GetDefaultInterface()->RunOnceRequiredSettingsComplete(fComplete/*[in]*/);
}

VARIANT_BOOL __fastcall TCppShellUIHelper::RunOnceHasShown(void)
{
  VARIANT_BOOL pfShown;
  OLECHECK(GetDefaultInterface()->RunOnceHasShown((VARIANT_BOOL*)&pfShown));
  return pfShown;
}

BSTR __fastcall TCppShellUIHelper::SearchGuideUrl(void)
{
  BSTR pbstrUrl = 0;
  OLECHECK(GetDefaultInterface()->SearchGuideUrl((BSTR*)&pbstrUrl));
  return pbstrUrl;
}

void __fastcall TCppShellUIHelper::AddService(BSTR URL/*[in]*/)
{
  GetDefaultInterface()->AddService(URL/*[in]*/);
}

unsigned_long __fastcall TCppShellUIHelper::IsServiceInstalled(BSTR URL/*[in]*/, BSTR Verb/*[in]*/)
{
  unsigned_long pdwResult;
  OLECHECK(GetDefaultInterface()->IsServiceInstalled(URL, Verb, (unsigned_long*)&pdwResult));
  return pdwResult;
}

VARIANT_BOOL __fastcall TCppShellUIHelper::InPrivateFilteringEnabled(void)
{
  VARIANT_BOOL pfEnabled;
  OLECHECK(GetDefaultInterface()->InPrivateFilteringEnabled((VARIANT_BOOL*)&pfEnabled));
  return pfEnabled;
}

void __fastcall TCppShellUIHelper::AddToFavoritesBar(BSTR URL/*[in]*/, BSTR Title/*[in]*/, 
                                                     VARIANT* Type/*[in,opt]*/)
{
  GetDefaultInterface()->AddToFavoritesBar(URL/*[in]*/, Title/*[in]*/, Type/*[in,opt]*/);
}

void __fastcall TCppShellUIHelper::BuildNewTabPage(void)
{
  GetDefaultInterface()->BuildNewTabPage();
}

void __fastcall TCppShellUIHelper::SetRecentlyClosedVisible(VARIANT_BOOL fVisible/*[in]*/)
{
  GetDefaultInterface()->SetRecentlyClosedVisible(fVisible/*[in]*/);
}

void __fastcall TCppShellUIHelper::SetActivitiesVisible(VARIANT_BOOL fVisible/*[in]*/)
{
  GetDefaultInterface()->SetActivitiesVisible(fVisible/*[in]*/);
}

void __fastcall TCppShellUIHelper::ContentDiscoveryReset(void)
{
  GetDefaultInterface()->ContentDiscoveryReset();
}

VARIANT_BOOL __fastcall TCppShellUIHelper::IsSuggestedSitesEnabled(void)
{
  VARIANT_BOOL pfEnabled;
  OLECHECK(GetDefaultInterface()->IsSuggestedSitesEnabled((VARIANT_BOOL*)&pfEnabled));
  return pfEnabled;
}

void __fastcall TCppShellUIHelper::EnableSuggestedSites(VARIANT_BOOL fEnable/*[in]*/)
{
  GetDefaultInterface()->EnableSuggestedSites(fEnable/*[in]*/);
}

void __fastcall TCppShellUIHelper::NavigateToSuggestedSites(BSTR bstrRelativeUrl/*[in]*/)
{
  GetDefaultInterface()->NavigateToSuggestedSites(bstrRelativeUrl/*[in]*/);
}

void __fastcall TCppShellUIHelper::ShowTabsHelp(void)
{
  GetDefaultInterface()->ShowTabsHelp();
}

void __fastcall TCppShellUIHelper::ShowInPrivateHelp(void)
{
  GetDefaultInterface()->ShowInPrivateHelp();
}

IShellNameSpacePtr& TShellFavoritesNameSpace::GetDefaultInterface()
{
  if (!m_DefaultIntf)
    Connect();
  return m_DefaultIntf;
}

_di_IUnknown __fastcall TShellFavoritesNameSpace::GetDunk()
{
  _di_IUnknown diUnk;
  if (m_DefaultIntf) {
    IUnknownPtr punk = m_DefaultIntf;
    diUnk = LPUNKNOWN(punk);
  }
  return diUnk;
}

void __fastcall TShellFavoritesNameSpace::Connect()
{
  if (!m_DefaultIntf) {
    _di_IUnknown punk = GetServer();
    m_DefaultIntf = punk;
    if (ServerData->EventIID != GUID_NULL)
      ConnectEvents(GetDunk());
  }
}

void __fastcall TShellFavoritesNameSpace::Disconnect()
{
  if (m_DefaultIntf) {

    if (ServerData->EventIID != GUID_NULL)
      DisconnectEvents(GetDunk());
    m_DefaultIntf.Reset();
  }
}

void __fastcall TShellFavoritesNameSpace::BeforeDestruction()
{
  Disconnect();
}

void __fastcall TShellFavoritesNameSpace::ConnectTo(IShellNameSpacePtr intf)
{
  Disconnect();
  m_DefaultIntf = intf;
  if (ServerData->EventIID != GUID_NULL)
    ConnectEvents(GetDunk());
}

void __fastcall TShellFavoritesNameSpace::InitServerData()
{
  static Vcl::Oleserver::TServerData sd;
  sd.ClassID = CLSID_ShellFavoritesNameSpace;
  sd.IntfIID = __uuidof(IShellNameSpace);
  sd.EventIID= __uuidof(DShellNameSpaceEvents);
  ServerData = &sd;
}

void __fastcall TShellFavoritesNameSpace::InvokeEvent(int id, Vcl::Oleserver::TVariantArray& params)
{
  switch(id)
  {
    case 1: {
      if (OnFavoritesSelectionChange) {
        (OnFavoritesSelectionChange)(this, params[0], params[1], params[2].bstrVal, params[3].bstrVal, params[4], params[5].bstrVal, params[6]);
      }
      break;
      }
    case 2: {
      if (OnSelectionChange) {
        (OnSelectionChange)(this);
      }
      break;
      }
    case 3: {
      if (OnDoubleClick) {
        (OnDoubleClick)(this);
      }
      break;
      }
    case 4: {
      if (OnInitialized) {
        (OnInitialized)(this);
      }
      break;
      }
    default:
      break;
  }
}

void __fastcall TShellFavoritesNameSpace::MoveSelectionUp(void)
{
  GetDefaultInterface()->MoveSelectionUp();
}

void __fastcall TShellFavoritesNameSpace::MoveSelectionDown(void)
{
  GetDefaultInterface()->MoveSelectionDown();
}

void __fastcall TShellFavoritesNameSpace::ResetSort(void)
{
  GetDefaultInterface()->ResetSort();
}

void __fastcall TShellFavoritesNameSpace::NewFolder(void)
{
  GetDefaultInterface()->NewFolder();
}

void __fastcall TShellFavoritesNameSpace::Synchronize(void)
{
  GetDefaultInterface()->Synchronize();
}

void __fastcall TShellFavoritesNameSpace::Import(void)
{
  GetDefaultInterface()->Import();
}

void __fastcall TShellFavoritesNameSpace::Export(void)
{
  GetDefaultInterface()->Export();
}

void __fastcall TShellFavoritesNameSpace::InvokeContextMenuCommand(BSTR strCommand/*[in]*/)
{
  GetDefaultInterface()->InvokeContextMenuCommand(strCommand/*[in]*/);
}

void __fastcall TShellFavoritesNameSpace::MoveSelectionTo(void)
{
  GetDefaultInterface()->MoveSelectionTo();
}

VARIANT_BOOL __fastcall TShellFavoritesNameSpace::CreateSubscriptionForSelection(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->CreateSubscriptionForSelection((VARIANT_BOOL*)&pBool));
  return pBool;
}

VARIANT_BOOL __fastcall TShellFavoritesNameSpace::DeleteSubscriptionForSelection(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->DeleteSubscriptionForSelection((VARIANT_BOOL*)&pBool));
  return pBool;
}

void __fastcall TShellFavoritesNameSpace::SetRoot(BSTR bstrFullPath/*[in]*/)
{
  GetDefaultInterface()->SetRoot(bstrFullPath/*[in]*/);
}

void __fastcall TShellFavoritesNameSpace::SetViewType(int iType/*[in]*/)
{
  GetDefaultInterface()->SetViewType(iType/*[in]*/);
}

LPDISPATCH __fastcall TShellFavoritesNameSpace::SelectedItems(void)
{
  LPDISPATCH ppid;
  OLECHECK(GetDefaultInterface()->SelectedItems((LPDISPATCH*)&ppid));
  return ppid;
}

void __fastcall TShellFavoritesNameSpace::Expand(VARIANT var/*[in]*/, int iDepth)
{
  GetDefaultInterface()->Expand(var/*[in]*/, iDepth);
}

void __fastcall TShellFavoritesNameSpace::UnselectAll(void)
{
  GetDefaultInterface()->UnselectAll();
}

// StdProp:WordBool
VARIANT_BOOL __fastcall TShellFavoritesNameSpace::get_SubscriptionsEnabled(void)
{
  VARIANT_BOOL pBool;
  OLECHECK(GetDefaultInterface()->get_SubscriptionsEnabled((VARIANT_BOOL*)&pBool));
  return pBool;
}

// StdProp:Integer
long __fastcall TShellFavoritesNameSpace::get_EnumOptions(void)
{
  long pgrfEnumFlags;
  OLECHECK(GetDefaultInterface()->get_EnumOptions((long*)&pgrfEnumFlags));
  return pgrfEnumFlags;
}

// StdProp:Integer
void __fastcall TShellFavoritesNameSpace::set_EnumOptions(long pgrfEnumFlags/*[in]*/)
{
  GetDefaultInterface()->set_EnumOptions(pgrfEnumFlags/*[in]*/);
}

// StdProp:IDispatch
LPDISPATCH __fastcall TShellFavoritesNameSpace::get_SelectedItem(void)
{
  LPDISPATCH pItem;
  OLECHECK(GetDefaultInterface()->get_SelectedItem((LPDISPATCH*)&pItem));
  return pItem;
}

// StdProp:IDispatch
void __fastcall TShellFavoritesNameSpace::set_SelectedItem(LPDISPATCH pItem/*[in]*/)
{
  GetDefaultInterface()->set_SelectedItem(pItem/*[in]*/);
}

// StdProp:OleVariant
VARIANT __fastcall TShellFavoritesNameSpace::get_Root(void)
{
  VARIANT pvar;
  OLECHECK(GetDefaultInterface()->get_Root((VARIANT*)&pvar));
  return pvar;
}

// StdProp:OleVariant
void __fastcall TShellFavoritesNameSpace::set_Root(VARIANT pvar/*[in]*/)
{
  GetDefaultInterface()->set_Root(pvar/*[in]*/);
}

// StdProp:Integer
int __fastcall TShellFavoritesNameSpace::get_Depth(void)
{
  int piDepth;
  OLECHECK(GetDefaultInterface()->get_Depth((int*)&piDepth));
  return piDepth;
}

// StdProp:Integer
void __fastcall TShellFavoritesNameSpace::set_Depth(int piDepth/*[in]*/)
{
  GetDefaultInterface()->set_Depth(piDepth/*[in]*/);
}

// StdProp:Integer
unsigned __fastcall TShellFavoritesNameSpace::get_Mode(void)
{
  unsigned puMode;
  OLECHECK(GetDefaultInterface()->get_Mode((unsigned*)&puMode));
  return puMode;
}

// StdProp:Integer
void __fastcall TShellFavoritesNameSpace::set_Mode(unsigned puMode/*[in]*/)
{
  GetDefaultInterface()->set_Mode(puMode/*[in]*/);
}

// StdProp:Integer
unsigned_long __fastcall TShellFavoritesNameSpace::get_Flags(void)
{
  unsigned_long pdwFlags;
  OLECHECK(GetDefaultInterface()->get_Flags((unsigned_long*)&pdwFlags));
  return pdwFlags;
}

// StdProp:Integer
void __fastcall TShellFavoritesNameSpace::set_Flags(unsigned_long pdwFlags/*[in]*/)
{
  GetDefaultInterface()->set_Flags(pdwFlags/*[in]*/);
}

// StdProp:Integer
void __fastcall TShellFavoritesNameSpace::set_TVFlags(unsigned_long dwFlags/*[in]*/)
{
  GetDefaultInterface()->set_TVFlags(dwFlags/*[in]*/);
}

// StdProp:Integer
unsigned_long __fastcall TShellFavoritesNameSpace::get_TVFlags(void)
{
  unsigned_long dwFlags;
  OLECHECK(GetDefaultInterface()->get_TVFlags((unsigned_long*)&dwFlags));
  return dwFlags;
}

// StdProp:WideString
BSTR __fastcall TShellFavoritesNameSpace::get_Columns(void)
{
  BSTR bstrColumns = 0;
  OLECHECK(GetDefaultInterface()->get_Columns((BSTR*)&bstrColumns));
  return bstrColumns;
}

// StdProp:WideString
void __fastcall TShellFavoritesNameSpace::set_Columns(BSTR bstrColumns/*[in]*/)
{
  GetDefaultInterface()->set_Columns(bstrColumns/*[in]*/);
}

// StdProp:Integer
int __fastcall TShellFavoritesNameSpace::get_CountViewTypes(void)
{
  int piTypes;
  OLECHECK(GetDefaultInterface()->get_CountViewTypes((int*)&piTypes));
  return piTypes;
}


};     // namespace Shdocvw_tlb


// *********************************************************************//
// The Register function is invoked by the IDE when this module is 
// installed in a Package. It provides the list of Components (including
// OCXes) implemented by this module. The following implementation
// informs the IDE of the OCX proxy classes implemented here.
// *********************************************************************//
namespace Shdocvw_ocx
{

void __fastcall PACKAGE Register()
{
  // [1]
  System::Classes::TComponentClass cls_ocx[] = {
                              __classid(Shdocvw_tlb::TCppWebBrowser)
                           };
  System::Classes::RegisterComponents("Internet", cls_ocx,
                     sizeof(cls_ocx)/sizeof(cls_ocx[0])-1);
  // [5]
  System::Classes::TComponentClass cls_svr[] = {
                              __classid(Shdocvw_tlb::TCppInternetExplorer), 
                              __classid(Shdocvw_tlb::TInternetExplorerMedium), 
                              __classid(Shdocvw_tlb::TCppShellWindows), 
                              __classid(Shdocvw_tlb::TCppShellUIHelper), 
                              __classid(Shdocvw_tlb::TShellFavoritesNameSpace)
                           };
  System::Classes::RegisterComponents("Servers", cls_svr,
                     sizeof(cls_svr)/sizeof(cls_svr[0])-1);
}

};     // namespace Shdocvw_ocx
