{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Datasnap.Midas;

interface

uses
{$IF DEFINED(MSWINDOWS) and NOT DEFINED(NEXTGEN)}
  Winapi.ActiveX,
{$ENDIF}
  System.Types;

const
  LIBID_Midas: TGUID = '{83F57D68-CA9A-11D2-9088-00C04FA35CFA}';
  IID_IAppServer: TGUID = '{1AEFCC20-7A24-11D2-98B0-C69BEB4B5B6D}';
type
{$M+}
  IAppServer = interface(IDispatch)
    ['{1AEFCC20-7A24-11D2-98B0-C69BEB4B5B6D}']
    function  AS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                              MaxErrors: Integer; out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; safecall;
    function  AS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                            Options: Integer; const CommandText: OleStr;
                            var Params: OleVariant; var OwnerData: OleVariant): OleVariant; safecall;
    function  AS_DataRequest(const ProviderName: OleStr; Data: OleVariant): OleVariant; safecall;
    function  AS_GetProviderNames: OleVariant; safecall;
    function  AS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant; safecall;
    function  AS_RowRequest(const ProviderName: OleStr; Row: OleVariant; RequestType: Integer;
                            var OwnerData: OleVariant): OleVariant; safecall;
    procedure AS_Execute(const ProviderName: OleStr; const CommandText: OleStr;
                         var Params: OleVariant; var OwnerData: OleVariant); safecall;
  end;
{$M-}

{$IF defined(WIN32) or defined(WIN64) }
{ Raw C++ version of IAppServer for C++Builder }
(*$HPPEMIT'#if !defined(NO_CPP_IAPPSERVER)' *)
(*$HPPEMIT'namespace Datasnap {' *)
(*$HPPEMIT' namespace Midas {' *)
(*$HPPEMIT'  __interface  INTERFACE_UUID("{1AEFCC20-7A24-11D2-98B0-C69BEB4B5B6D}") ICppAppServer : public IDispatch' *)
(*$HPPEMIT'  {' *)
(*$HPPEMIT'  public:' *)
(*$HPPEMIT'    virtual HRESULT __stdcall AS_ApplyUpdates(BSTR ProviderName, VARIANT Delta, long MaxErrors, int* ErrorCount, VARIANT* OwnerData, VARIANT* AS_ApplyUpdates_result) = 0 ;' *)
(*$HPPEMIT'    virtual HRESULT __stdcall AS_GetRecords(BSTR ProviderName, long Count, int* RecsOut, long Options, BSTR CommandText, VARIANT* Params, VARIANT* OwnerData, VARIANT* AS_GetRecords_result) = 0 ;' *)
(*$HPPEMIT'    virtual HRESULT __stdcall AS_DataRequest(BSTR ProviderName, VARIANT Data, VARIANT* AS_DataRequest_result) = 0 ;' *)
(*$HPPEMIT'    virtual HRESULT __stdcall AS_GetProviderNames(VARIANT* AS_GetProviderNames_result) = 0 ;' *)
(*$HPPEMIT'    virtual HRESULT __stdcall AS_GetParams(BSTR ProviderName, VARIANT* OwnerData, VARIANT* AS_GetParams_result) = 0 ;' *)
(*$HPPEMIT'    virtual HRESULT __stdcall AS_RowRequest(BSTR ProviderName, VARIANT Row, long RequestType, VARIANT* OwnerData, VARIANT* AS_RowRequest_result) = 0 ;' *)
(*$HPPEMIT'    virtual HRESULT __stdcall AS_Execute(BSTR ProviderName, BSTR CommandText, VARIANT* Params, VARIANT* OwnerData) = 0 ;' *)
(*$HPPEMIT'  };' *)
(*$HPPEMIT' }' *)
(*$HPPEMIT'}' *)
(*$HPPEMIT'#endif' *)
{$ENDIF}

  IAppServerDisp = dispinterface
    ['{1AEFCC20-7A24-11D2-98B0-C69BEB4B5B6D}']
    function  AS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                              MaxErrors: Integer; out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function  AS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                            Options: Integer; const CommandText: OleStr;
                            var Params: OleVariant; var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function  AS_DataRequest(const ProviderName: OleStr; Data: OleVariant): OleVariant; dispid 20000002;
    function  AS_GetProviderNames: OleVariant; dispid 20000003;
    function  AS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function  AS_RowRequest(const ProviderName: OleStr; Row: OleVariant; RequestType: Integer;
                            var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: OleStr; const CommandText: OleStr;
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

implementation

end.
