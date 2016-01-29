{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.Locationapi;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "locationapi.h"'}
{$HPPEMIT ''}

interface

uses Winapi.ActiveX, Winapi.Propkey, Winapi.Sensorsapi, Winapi.Windows;

type
  LOCATION_REPORT_STATUS = type Integer;
  {$EXTERNALSYM LOCATION_REPORT_STATUS}

const
  LOCATION_API_VERSION = 1;
  {$EXTERNALSYM LOCATION_API_VERSION}
  REPORT_NOT_SUPPORTED = 0;
  {$EXTERNALSYM REPORT_NOT_SUPPORTED}
  REPORT_ERROR         = 1;
  {$EXTERNALSYM REPORT_ERROR}
  REPORT_ACCESS_DENIED = 2;
  {$EXTERNALSYM REPORT_ACCESS_DENIED}
  REPORT_INITIALIZING  = 3;
  {$EXTERNALSYM REPORT_INITIALIZING}
  REPORT_RUNNING       = 4;
  {$EXTERNALSYM REPORT_RUNNING}

const
  SID_ILocationReport = '{C8B7F7EE-75D0-4db9-B62D-7A0F369CA456}';
  {$EXTERNALSYM SID_ILocationReport}
  IID_ILocationReport: TGUID = '{C8B7F7EE-75D0-4db9-B62D-7A0F369CA456}';
  {$EXTERNALSYM IID_ILocationReport}
  SID_ILatLongReport = '{7FED806D-0EF8-4f07-80AC-36A0BEAE3134}';
  {$EXTERNALSYM SID_ILatLongReport}
  IID_ILatLongReport: TGUID = '{7FED806D-0EF8-4f07-80AC-36A0BEAE3134}';
  {$EXTERNALSYM IID_ILatLongReport}
  SID_ICivicAddressReport = '{C0B19F70-4ADF-445d-87F2-CAD8FD711792}';
  {$EXTERNALSYM SID_ICivicAddressReport}
  IID_ICivicAddressReport: TGUID = '{C0B19F70-4ADF-445d-87F2-CAD8FD711792}';
  {$EXTERNALSYM IID_ICivicAddressReport}
  SID_ILocation = '{AB2ECE69-56D9-4F28-B525-DE1B0EE44237}';
  {$EXTERNALSYM SID_ILocation}
  IID_ILocation: TGUID = '{AB2ECE69-56D9-4F28-B525-DE1B0EE44237}';
  {$EXTERNALSYM IID_ILocation}
  SID_IDefaultLocation = '{A65AF77E-969A-4a2e-8ACA-33BB7CBB1235}';
  {$EXTERNALSYM SID_IDefaultLocation}
  IID_IDefaultLocation: TGUID = '{A65AF77E-969A-4a2e-8ACA-33BB7CBB1235}';
  {$EXTERNALSYM IID_IDefaultLocation}
  SID_ILocationEvents = '{CAE02BBF-798B-4508-A207-35A7906DC73D}';
  {$EXTERNALSYM SID_ILocationEvents}
  IID_ILocationEvents: TGUID = '{CAE02BBF-798B-4508-A207-35A7906DC73D}';
  {$EXTERNALSYM IID_ILocationEvents}
  SID_IDispLatLongReport = '{8AE32723-389B-4A11-9957-5BDD48FC9617}';
  {$EXTERNALSYM SID_IDispLatLongReport}
  IID_IDispLatLongReport: TGUID = '{8AE32723-389B-4A11-9957-5BDD48FC9617}';
  {$EXTERNALSYM IID_IDispLatLongReport}
  SID_IDispCivicAddressReport = '{16FF1A34-9E30-42c3-B44D-E22513B5767A}';
  {$EXTERNALSYM SID_IDispCivicAddressReport}
  IID_IDispCivicAddressReport: TGUID = '{16FF1A34-9E30-42c3-B44D-E22513B5767A}';
  {$EXTERNALSYM IID_IDispCivicAddressReport}
  SID_ILocationReportFactory = '{2DAEC322-90B2-47e4-BB08-0DA841935A6B}';
  {$EXTERNALSYM SID_ILocationReportFactory}
  IID_ILocationReportFactory: TGUID = '{2DAEC322-90B2-47e4-BB08-0DA841935A6B}';
  {$EXTERNALSYM IID_ILocationReportFactory}
  SID_ILatLongReportFactory = '{3F0804CB-B114-447D-83DD-390174EBB082}';
  {$EXTERNALSYM SID_ILatLongReportFactory}
  IID_ILatLongReportFactory: TGUID = '{3F0804CB-B114-447D-83DD-390174EBB082}';
  {$EXTERNALSYM IID_ILatLongReportFactory}
  SID_ICivicAddressReportFactory = '{BF773B93-C64F-4bee-BEB2-67C0B8DF66E0}';
  {$EXTERNALSYM SID_ICivicAddressReportFactory}
  IID_ICivicAddressReportFactory: TGUID = '{BF773B93-C64F-4bee-BEB2-67C0B8DF66E0}';
  {$EXTERNALSYM IID_ICivicAddressReportFactory}
  SID__ILatLongReportFactoryEvents = '{16EE6CB7-AB3C-424B-849F-269BE551FCBC}';
  {$EXTERNALSYM SID__ILatLongReportFactoryEvents}
  IID__ILatLongReportFactoryEvents: TGUID = '{16EE6CB7-AB3C-424B-849F-269BE551FCBC}';
  {$EXTERNALSYM IID__ILatLongReportFactoryEvents}
  SID__ICivicAddressReportFactoryEvents = '{C96039FF-72EC-4617-89BD-84D88BEDC722}';
  {$EXTERNALSYM SID__ICivicAddressReportFactoryEvents}
  IID__ICivicAddressReportFactoryEvents: TGUID = '{C96039FF-72EC-4617-89BD-84D88BEDC722}';
  {$EXTERNALSYM IID__ICivicAddressReportFactoryEvents}

type

{ Forward Declarations }

  ILocationReport = interface;
  ILatLongReport = interface;
  ICivicAddressReport = interface;
  ILocation = interface;
  IDefaultLocation = interface;
  ILocationEvents = interface;
  IDispLatLongReport = interface;
  IDispCivicAddressReport = interface;
  ILocationReportFactory = interface;
  ILatLongReportFactory = interface;
  ICivicAddressReportFactory = interface;
  _ILatLongReportFactoryEvents = interface;
  _ICivicAddressReportFactoryEvents = interface;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILocationReport);'}
  ILocationReport = interface(IUnknown)
    [SID_ILocationReport]
    function GetSensorID(out pSensorID: SENSOR_ID): HRESULT; stdcall;
    function GetTimestamp(out pCreationTime: SYSTEMTIME): HRESULT; stdcall;
    function GetValue(const pKey: PROPERTYKEY; out pValue: PROPVARIANT): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILocationReport}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILatLongReport);'}
  ILatLongReport = interface(ILocationReport)
    [SID_ILatLongReport]
    function GetLatitude(out pLatitude: Double): HRESULT; stdcall;
    function GetLongitude(out pLongitude: Double): HRESULT; stdcall;
    function GetErrorRadius(out pErrorRadius: Double): HRESULT; stdcall;
    function GetAltitude(out pAltitude: Double): HRESULT; stdcall;
    function GetAltitudeError(out pAltitudeError: Double): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILatLongReport}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ICivicAddressReport);'}
  ICivicAddressReport = interface(ILocationReport) 
    [SID_ICivicAddressReport]
    function GetAddressLine1(out pbstrAddress1: WideString): HRESULT; stdcall;
    function GetAddressLine2(out pbstrAddress2: WideString): HRESULT; stdcall;
    function GetCity(out pbstrCity: WideString): HRESULT; stdcall;
    function GetStateProvince(out pbstrStateProvince: WideString): HRESULT; stdcall;
    function GetPostalCode(out pbstrPostalCode: WideString): HRESULT; stdcall;
    function GetCountryRegion(out pbstrCountryRegion: WideString): HRESULT; stdcall;
    function GetDetailLevel(out pDetailLevel: DWORD): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ICivicAddressReport}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILocation);'}
  ILocation = interface(IUnknown)
    [SID_ILocation]
    function RegisterForReport(const pEvents: ILocationEvents; const reportType: TIID; dwRequestedReportInterval: DWORD): HRESULT; stdcall;
    function UnregisterForReport(const reportType: TIID): HRESULT; stdcall;
    function GetReport(const reportType: TIID; out ppLocationReport: ILocationReport): HRESULT; stdcall;
    function GetReportStatus(const reportType: TIID; out pStatus: LOCATION_REPORT_STATUS): HRESULT; stdcall;
    function GetReportInterval(const reportType: TIID; out pMilliseconds: DWORD): HRESULT; stdcall;
    function SetReportInterval(const reportType: TIID; millisecondsRequested: DWORD): HRESULT; stdcall;
    function GetDesiredAccuracy(const reportType: TIID; out pDesiredAccuracy: LOCATION_DESIRED_ACCURACY): HRESULT; stdcall;
    function SetDesiredAccuracy(const reportType: TIID; desiredAccuracy: LOCATION_DESIRED_ACCURACY): HRESULT; stdcall;
    function RequestPermissions(hParent: HWND; pReportTypes: PIID; count: Cardinal; fModal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILocation}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDefaultLocation);'}
  IDefaultLocation = interface(IUnknown)
    [SID_IDefaultLocation]
    function SetReport(const reportType: TIID; const pLocationReport: ILocationReport): HRESULT; stdcall;
    function GetReport(const reportType: TIID; out ppLocationReport: ILocationReport): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDefaultLocation}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILocationEvents);'}
  ILocationEvents = interface(IUnknown)
    [SID_ILocationEvents]
    function OnLocationChanged(const reportType: TIID; const pLocationReport: ILocationReport): HRESULT; stdcall;
    function OnStatusChanged(const reportType: TIID; newStatus: LOCATION_REPORT_STATUS): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILocationEvents}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDispLatLongReport);'}
  IDispLatLongReport = interface(IDispatch) 
    [SID_IDispLatLongReport]
    function get_Latitude(out pVal: Double): HRESULT; stdcall;
    function get_Longitude(out pVal: Double): HRESULT; stdcall;
    function get_ErrorRadius(out pVal: Double): HRESULT; stdcall;
    function get_Altitude(out pVal: Double): HRESULT; stdcall;
    function get_AltitudeError(out pVal: Double): HRESULT; stdcall;
    function get_Timestamp(out pVal: TDateTime): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDispLatLongReport}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDispCivicAddressReport);'}
  IDispCivicAddressReport = interface(IDispatch)
    [SID_IDispCivicAddressReport]
    function get_AddressLine1(out pAddress1: WideString): HRESULT; stdcall;
    function get_AddressLine2(out pAddress2: WideString): HRESULT; stdcall;
    function get_City(out pCity: WideString): HRESULT; stdcall;
    function get_StateProvince(out pStateProvince: WideString): HRESULT; stdcall;
    function get_PostalCode(out pPostalCode: WideString): HRESULT; stdcall;
    function get_CountryRegion(out pCountryRegion: WideString): HRESULT; stdcall;
    function get_DetailLevel(out pDetailLevel: Cardinal): HRESULT; stdcall;
    function get_Timestamp(out pVal: TDateTime): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDispCivicAddressReport}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILocationReportFactory);'}
  ILocationReportFactory = interface(IDispatch)
    [SID_ILocationReportFactory]
    function ListenForReports(requestedReportInterval: Cardinal = 0): HRESULT; stdcall;
    function StopListeningForReports: HRESULT; stdcall; { [helpstring][id] }
    function get_Status(out pVal: Cardinal): HRESULT; stdcall;
    function get_ReportInterval(out pMilliseconds: Cardinal): HRESULT; stdcall;
    function put_ReportInterval(millisecondsRequested: Cardinal): HRESULT; stdcall;
    function get_DesiredAccuracy(out pDesiredAccuracy: Cardinal): HRESULT; stdcall;
    function put_DesiredAccuracy(desiredAccuracy: Cardinal): HRESULT; stdcall;
    function RequestPermissions(hWnd: HWND): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILocationReportFactory}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILatLongReportFactory);'}
  ILatLongReportFactory = interface(ILocationReportFactory)
    [SID_ILatLongReportFactory]
    function get_LatLongReport(out pVal: IDispLatLongReport): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILatLongReportFactory}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ICivicAddressReportFactory);'}
  ICivicAddressReportFactory = interface(ILocationReportFactory)
    [SID_ICivicAddressReportFactory]
    function get_CivicAddressReport(out pVal: IDispCivicAddressReport): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ICivicAddressReportFactory}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(_ILatLongReportFactoryEvents);'}
  _ILatLongReportFactoryEvents = interface(IDispatch)
    [SID__ILatLongReportFactoryEvents]
  end;
  {$EXTERNALSYM _ILatLongReportFactoryEvents}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(_ICivicAddressReportFactoryEvents);'}
  _ICivicAddressReportFactoryEvents = interface(IDispatch) 
    [SID__ICivicAddressReportFactoryEvents]
  end;
  {$EXTERNALSYM _ICivicAddressReportFactoryEvents}

const
  CLSID_Location: TGUID = '{E5B8E079-EE6D-4E33-A438-C87F2E959254}';
  {$EXTERNALSYM CLSID_Location}
  CLSID_DefaultLocation: TGUID = '{8B7FBFE0-5CD7-494a-AF8C-283A65707506}';
  {$EXTERNALSYM CLSID_DefaultLocation}
  CLSID_LatLongReport: TGUID = '{ED81C073-1F84-4ca8-A161-183C776BC651}';
  {$EXTERNALSYM CLSID_LatLongReport}
  CLSID_CivicAddressReport: TGUID = '{D39E7BDD-7D05-46b8-8721-80CF035F57D7}';
  {$EXTERNALSYM CLSID_CivicAddressReport}
  CLSID_LatLongReportFactory: TGUID = '{9DCC3CC8-8609-4863-BAD4-03601F4C65E8}';
  {$EXTERNALSYM CLSID_LatLongReportFactory}
  CLSID_CivicAddressReportFactory: TGUID = '{2A11F42C-3E81-4ad4-9CBE-45579D89671A}';
  {$EXTERNALSYM CLSID_CivicAddressReportFactory}
  CLSID_DispLatLongReport: TGUID = '{7A7C3277-8F84-4636-95B2-EBB5507FF77E}';
  {$EXTERNALSYM CLSID_DispLatLongReport}
  CLSID_DispCivicAddressReport: TGUID = '{4C596AEC-8544-4082-BA9F-EB0A7D8E65C6}';
  {$EXTERNALSYM CLSID_DispCivicAddressReport}

implementation

end.
