{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit UrlHist;

interface

uses Winapi.Windows, Winapi.ActiveX;

{ For C++ support }
(*$HPPEMIT '#include <urlhist.h>'*)


const
  {$EXTERNALSYM STATURL_QUERYFLAG_ISCACHED}
  STATURL_QUERYFLAG_ISCACHED = $00010000;
  {$EXTERNALSYM STATURL_QUERYFLAG_NOURL}
  STATURL_QUERYFLAG_NOURL    = $00020000;
  {$EXTERNALSYM STATURL_QUERYFLAG_NOTITLE}
  STATURL_QUERYFLAG_NOTITLE  = $00040000;
  {$EXTERNALSYM STATURL_QUERYFLAG_TOPLEVEL}
  STATURL_QUERYFLAG_TOPLEVEL = $00080000;
  {$EXTERNALSYM STATURLFLAG_ISCACHED}
  STATURLFLAG_ISCACHED       = $00000001;
  {$EXTERNALSYM STATURLFLAG_ISTOPLEVEL}
  STATURLFLAG_ISTOPLEVEL     = $00000002;

  IID_IUrlHistoryStg = '{3C374A41-BAE4-11CF-BF7D-00AA006946EE}';
  IID_IUrlHistoryStg2 = '{AFA0DC11-C313-11d0-831A-00C04FD5AE38}';
  IID_IUrlHistoryNotify = '{BC40BEC1-C493-11d0-831B-00C04FD5AE38}';
  IID_IEnumSTATURL = '{3C374A42-BAE4-11CF-BF7D-00AA006946EE}';

type
  _STATURL = record
    cbSize: DWORD;
    pwcsUrl: LPWSTR;
    pwcsTitle: LPWSTR;
    ftLastVisited: FILETIME;
    ftLastUpdated: FILETIME;
    ftExpires: FILETIME;
    dwFlags: DWORD;
  end;
  STATURL = _STATURL;
  TStatUrl = _STATURL;
  LPSTATURL = ^STATURL;
  PStatUrl = LPSTATURL;

  IEnumStatURL = interface(IUnknown)
    [IID_IEnumSTATURL]
    function Next(
        {* [in] *} celt: ULONG;
        {* [out][in] *} var rgelt: TStatUrl;
        {* [out][in] *} var pceltFetched: ULONG): HRESULT; stdcall;
    function Skip(
        {* [in] *} celt: ULONG): HRESULT; stdcall;
    function Reset: HRESULT; stdcall;
    function Clone(
        {* [out] *} out ppenum: IEnumSTATURL): HRESULT; stdcall;
    function SetFilter(
        {* [in] *} poszFilter: LPWSTR;
        {* [in] *} dwFlags: DWORD): HRESULT; stdcall;
  end;

  IUrlHistoryStg = interface(IUnknown)
    [IID_IUrlHistoryStg]
    function AddUrl(
        {* [in] *} pocsUrl: LPWSTR;
        {* [unique][in] *} pocsTitle: LPWSTR;
        {* [in] *} dwFlags: DWORD): HRESULT; stdcall;
    function DeleteUrl(
        {* [in] *} pocsUrl: LPWSTR;
        {* [in] *} dwFlags: DWORD): HRESULT; stdcall;
    function QueryUrl(
        {* [in] *} pocsUrl: LPWSTR;
        {* [in] *} dwFlags: DWORD;
        {* [unique][out][in] *} var lpSTATURL: TStatUrl): HRESULT; stdcall;
    function BindToObject(
        {* [in] *} pocsUrl: LPWSTR;
        {* [in] *} const riid: TGUID;
        {* [iid_is][out] *} out ppvOut): HRESULT; stdcall;
    function EnumUrls(
        {* [out] *} out ppEnum: IEnumSTATURL): HRESULT; stdcall;
  end;

  IUrlHistoryStg2 = interface(IUrlHistoryStg)
    [IID_IUrlHistoryStg2]
    function AddUrlAndNotify(
        {* [in] *} pocsUrl: LPWSTR;
        {* [unique][in] *}  pocsTitle: LPWSTR;
        {* [in] *} dwFlags: DWORD;
        {* [in] *} fWriteHistory: BOOL;
        {* [in] *} poctNotify: IOleCommandTarget;
        {* [unique][in] *} punkISFolder: IUnknown): HRESULT; stdcall;
    function ClearHistory: HRESULT; stdcall;
  end;

  IUrlHistoryNotify = interface(IOleCommandTarget)
    [IID_IUrlHistoryNotify]
  end;

implementation

end.
