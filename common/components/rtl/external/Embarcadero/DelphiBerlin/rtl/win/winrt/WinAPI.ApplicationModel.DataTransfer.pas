{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.ApplicationModel.DataTransfer;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Security,
  Winapi.GraphicsRT,
  // Internal Uses...
  Winapi.Storage.Streams,
  Winapi.Foundation.Collections,
  Winapi.Foundation,
  Winapi.Storage,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.ApplicationModel.DataTransfer Class Names
  // Windows.ApplicationModel.DataTransfer.StandardDataFormats
  // DualAPI
  SStandardDataFormats = 'Windows.ApplicationModel.DataTransfer.StandardDataFormats';
  // Windows.ApplicationModel.DataTransfer.DataPackagePropertySetView
  // DualAPI
  SDataPackagePropertySetView = 'Windows.ApplicationModel.DataTransfer.DataPackagePropertySetView';
  // Windows.ApplicationModel.DataTransfer.DataPackagePropertySet
  // DualAPI
  SDataPackagePropertySet = 'Windows.ApplicationModel.DataTransfer.DataPackagePropertySet';
  // Windows.ApplicationModel.DataTransfer.DataProviderDeferral
  // DualAPI
  SDataProviderDeferral = 'Windows.ApplicationModel.DataTransfer.DataProviderDeferral';
  // Windows.ApplicationModel.DataTransfer.DataProviderRequest
  // DualAPI
  SDataProviderRequest = 'Windows.ApplicationModel.DataTransfer.DataProviderRequest';
  // Windows.ApplicationModel.DataTransfer.OperationCompletedEventArgs
  // DualAPI
  SOperationCompletedEventArgs = 'Windows.ApplicationModel.DataTransfer.OperationCompletedEventArgs';
  // Windows.ApplicationModel.DataTransfer.DataPackageView
  // DualAPI
  SDataPackageView = 'Windows.ApplicationModel.DataTransfer.DataPackageView';
  // Windows.ApplicationModel.DataTransfer.DataPackage
  // DualAPI
  SDataPackage = 'Windows.ApplicationModel.DataTransfer.DataPackage';
  // Windows.ApplicationModel.DataTransfer.HtmlFormatHelper
  // DualAPI
  SHtmlFormatHelper = 'Windows.ApplicationModel.DataTransfer.HtmlFormatHelper';
  // Windows.ApplicationModel.DataTransfer.Clipboard
  // DualAPI
  SClipboard = 'Windows.ApplicationModel.DataTransfer.Clipboard';
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragInfo
  // DualAPI
  SDragDrop_Core_CoreDragInfo = 'Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragInfo';
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragUIOverride
  // DualAPI
  SDragDrop_Core_CoreDragUIOverride = 'Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragUIOverride';
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragDropManager
  // DualAPI
  SDragDrop_Core_CoreDragDropManager = 'Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragDropManager';
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDropOperationTargetRequestedEventArgs
  // DualAPI
  SDragDrop_Core_CoreDropOperationTargetRequestedEventArgs = 'Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDropOperationTargetRequestedEventArgs';
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragOperation
  // DualAPI
  SDragDrop_Core_CoreDragOperation = 'Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragOperation';
  // Windows.ApplicationModel.DataTransfer.DataTransferManager
  // DualAPI
  SDataTransferManager = 'Windows.ApplicationModel.DataTransfer.DataTransferManager';


type
  // Forward declare interfaces
  // Windows.ApplicationModel.DataTransfer.IStandardDataFormatsStatics
  IStandardDataFormatsStatics = interface;
  PIStandardDataFormatsStatics = ^IStandardDataFormatsStatics;

  // Windows.ApplicationModel.DataTransfer.IStandardDataFormatsStatics2
  IStandardDataFormatsStatics2 = interface;
  PIStandardDataFormatsStatics2 = ^IStandardDataFormatsStatics2;

  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySetView
  IDataPackagePropertySetView = interface;
  PIDataPackagePropertySetView = ^IDataPackagePropertySetView;

  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySetView2
  IDataPackagePropertySetView2 = interface;
  PIDataPackagePropertySetView2 = ^IDataPackagePropertySetView2;

  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySetView3
  IDataPackagePropertySetView3 = interface;
  PIDataPackagePropertySetView3 = ^IDataPackagePropertySetView3;

  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySet
  IDataPackagePropertySet = interface;
  PIDataPackagePropertySet = ^IDataPackagePropertySet;

  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySet2
  IDataPackagePropertySet2 = interface;
  PIDataPackagePropertySet2 = ^IDataPackagePropertySet2;

  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySet3
  IDataPackagePropertySet3 = interface;
  PIDataPackagePropertySet3 = ^IDataPackagePropertySet3;

  // Windows.ApplicationModel.DataTransfer.IDataProviderDeferral
  IDataProviderDeferral = interface;
  PIDataProviderDeferral = ^IDataProviderDeferral;

  // Windows.ApplicationModel.DataTransfer.IDataProviderRequest
  IDataProviderRequest = interface;
  PIDataProviderRequest = ^IDataProviderRequest;

  // Windows.ApplicationModel.DataTransfer.DataProviderHandler
  DataProviderHandler = interface;
  PDataProviderHandler = ^DataProviderHandler;

  // Windows.ApplicationModel.DataTransfer.IOperationCompletedEventArgs
  IOperationCompletedEventArgs = interface;
  PIOperationCompletedEventArgs = ^IOperationCompletedEventArgs;

  // Windows.ApplicationModel.DataTransfer.IDataPackageView
  IDataPackageView = interface;
  PIDataPackageView = ^IDataPackageView;

  // Windows.ApplicationModel.DataTransfer.IDataPackageView2
  IDataPackageView2 = interface;
  PIDataPackageView2 = ^IDataPackageView2;

  // Windows.ApplicationModel.DataTransfer.IDataPackageView3
  IDataPackageView3 = interface;
  PIDataPackageView3 = ^IDataPackageView3;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataPackage,Windows.ApplicationModel.DataTransfer.IOperationCompletedEventArgs>
  TypedEventHandler_2__IDataPackage__IOperationCompletedEventArgs = interface;
  PTypedEventHandler_2__IDataPackage__IOperationCompletedEventArgs = ^TypedEventHandler_2__IDataPackage__IOperationCompletedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataPackage,Object>
  TypedEventHandler_2__IDataPackage__IInspectable = interface;
  PTypedEventHandler_2__IDataPackage__IInspectable = ^TypedEventHandler_2__IDataPackage__IInspectable;

  // Windows.ApplicationModel.DataTransfer.IDataPackage
  IDataPackage = interface;
  PIDataPackage = ^IDataPackage;

  // Windows.ApplicationModel.DataTransfer.IDataPackage2
  IDataPackage2 = interface;
  PIDataPackage2 = ^IDataPackage2;

  // Windows.ApplicationModel.DataTransfer.IHtmlFormatHelperStatics
  IHtmlFormatHelperStatics = interface;
  PIHtmlFormatHelperStatics = ^IHtmlFormatHelperStatics;

  // Windows.ApplicationModel.DataTransfer.IClipboardStatics
  IClipboardStatics = interface;
  PIClipboardStatics = ^IClipboardStatics;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragInfo
  DragDrop_Core_ICoreDragInfo = interface;
  PDragDrop_Core_ICoreDragInfo = ^DragDrop_Core_ICoreDragInfo;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragUIOverride
  DragDrop_Core_ICoreDragUIOverride = interface;
  PDragDrop_Core_ICoreDragUIOverride = ^DragDrop_Core_ICoreDragUIOverride;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.DataTransfer.DataPackageOperation>
  AsyncOperationCompletedHandler_1__DataPackageOperation = interface;
  PAsyncOperationCompletedHandler_1__DataPackageOperation = ^AsyncOperationCompletedHandler_1__DataPackageOperation;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.DataTransfer.DataPackageOperation>
  IAsyncOperation_1__DataPackageOperation = interface;
  PIAsyncOperation_1__DataPackageOperation = ^IAsyncOperation_1__DataPackageOperation;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDropOperationTarget
  DragDrop_Core_ICoreDropOperationTarget = interface;
  PDragDrop_Core_ICoreDropOperationTarget = ^DragDrop_Core_ICoreDropOperationTarget;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragOperation
  DragDrop_Core_ICoreDragOperation = interface;
  PDragDrop_Core_ICoreDragOperation = ^DragDrop_Core_ICoreDragOperation;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDropOperationTargetRequestedEventArgs
  DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs = interface;
  PDragDrop_Core_ICoreDropOperationTargetRequestedEventArgs = ^DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragDropManager,Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDropOperationTargetRequestedEventArgs>
  TypedEventHandler_2__DragDrop_Core_ICoreDragDropManager__DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs = interface;
  PTypedEventHandler_2__DragDrop_Core_ICoreDragDropManager__DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs = ^TypedEventHandler_2__DragDrop_Core_ICoreDragDropManager__DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragDropManager
  DragDrop_Core_ICoreDragDropManager = interface;
  PDragDrop_Core_ICoreDragDropManager = ^DragDrop_Core_ICoreDragDropManager;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragDropManagerStatics
  DragDrop_Core_ICoreDragDropManagerStatics = interface;
  PDragDrop_Core_ICoreDragDropManagerStatics = ^DragDrop_Core_ICoreDragDropManagerStatics;

  // Windows.ApplicationModel.DataTransfer.IDataRequestDeferral
  IDataRequestDeferral = interface;
  PIDataRequestDeferral = ^IDataRequestDeferral;

  // Windows.ApplicationModel.DataTransfer.IDataRequest
  IDataRequest = interface;
  PIDataRequest = ^IDataRequest;

  // Windows.ApplicationModel.DataTransfer.IDataRequestedEventArgs
  IDataRequestedEventArgs = interface;
  PIDataRequestedEventArgs = ^IDataRequestedEventArgs;

  // Windows.ApplicationModel.DataTransfer.ITargetApplicationChosenEventArgs
  ITargetApplicationChosenEventArgs = interface;
  PITargetApplicationChosenEventArgs = ^ITargetApplicationChosenEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataTransferManager,Windows.ApplicationModel.DataTransfer.IDataRequestedEventArgs>
  TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs = interface;
  PTypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs = ^TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataTransferManager,Windows.ApplicationModel.DataTransfer.ITargetApplicationChosenEventArgs>
  TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs = interface;
  PTypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs = ^TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs;

  // Windows.ApplicationModel.DataTransfer.IDataTransferManager
  IDataTransferManager = interface;
  PIDataTransferManager = ^IDataTransferManager;

  // Windows.ApplicationModel.DataTransfer.IDataTransferManagerStatics
  IDataTransferManagerStatics = interface;
  PIDataTransferManagerStatics = ^IDataTransferManagerStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.DataTransfer.IDataPackage>
  AsyncOperationCompletedHandler_1__IDataPackage = interface;
  PAsyncOperationCompletedHandler_1__IDataPackage = ^AsyncOperationCompletedHandler_1__IDataPackage;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.DataTransfer.IDataPackage>
  IAsyncOperation_1__IDataPackage = interface;
  PIAsyncOperation_1__IDataPackage = ^IAsyncOperation_1__IDataPackage;


  // Emit Forwarded interfaces
  // Windows.ApplicationModel.DataTransfer Interfaces
  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IStandardDataFormatsStatics
  [WinRTClassNameAttribute(SStandardDataFormats)]
  IStandardDataFormatsStatics = interface(IInspectable)
  ['{7ED681A1-A880-40C9-B4ED-0BEE1E15F549}']
    function get_Text: HSTRING; safecall;
    function get_Uri: HSTRING; safecall;
    function get_Html: HSTRING; safecall;
    function get_Rtf: HSTRING; safecall;
    function get_Bitmap: HSTRING; safecall;
    function get_StorageItems: HSTRING; safecall;
    property Bitmap: HSTRING read get_Bitmap;
    property Html: HSTRING read get_Html;
    property Rtf: HSTRING read get_Rtf;
    property StorageItems: HSTRING read get_StorageItems;
    property Text: HSTRING read get_Text;
    property Uri: HSTRING read get_Uri;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IStandardDataFormatsStatics2
  [WinRTClassNameAttribute(SStandardDataFormats)]
  IStandardDataFormatsStatics2 = interface(IInspectable)
  ['{42A254F4-9D76-42E8-861B-47C25DD0CF71}']
    function get_WebLink: HSTRING; safecall;
    function get_ApplicationLink: HSTRING; safecall;
    property ApplicationLink: HSTRING read get_ApplicationLink;
    property WebLink: HSTRING read get_WebLink;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySetView
  [WinRTClassNameAttribute(SDataPackagePropertySetView)]
  IDataPackagePropertySetView = interface(IInspectable)
  ['{B94CEC01-0C1A-4C57-BE55-75D01289735D}']
    function get_Title: HSTRING; safecall;
    function get_Description: HSTRING; safecall;
    function get_Thumbnail: IRandomAccessStreamReference; safecall;
    function get_FileTypes: IVectorView_1__HSTRING; safecall;
    function get_ApplicationName: HSTRING; safecall;
    function get_ApplicationListingUri: IUriRuntimeClass; safecall;
    property ApplicationListingUri: IUriRuntimeClass read get_ApplicationListingUri;
    property ApplicationName: HSTRING read get_ApplicationName;
    property Description: HSTRING read get_Description;
    property FileTypes: IVectorView_1__HSTRING read get_FileTypes;
    property Thumbnail: IRandomAccessStreamReference read get_Thumbnail;
    property Title: HSTRING read get_Title;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySetView2
  IDataPackagePropertySetView2 = interface(IInspectable)
  ['{6054509B-8EBE-4FEB-9C1E-75E69DE54B84}']
    function get_PackageFamilyName: HSTRING; safecall;
    function get_ContentSourceWebLink: IUriRuntimeClass; safecall;
    function get_ContentSourceApplicationLink: IUriRuntimeClass; safecall;
    function get_Square30x30Logo: IRandomAccessStreamReference; safecall;
    function get_LogoBackgroundColor: Color; safecall;
    property ContentSourceApplicationLink: IUriRuntimeClass read get_ContentSourceApplicationLink;
    property ContentSourceWebLink: IUriRuntimeClass read get_ContentSourceWebLink;
    property LogoBackgroundColor: Color read get_LogoBackgroundColor;
    property PackageFamilyName: HSTRING read get_PackageFamilyName;
    property Square30x30Logo: IRandomAccessStreamReference read get_Square30x30Logo;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySetView3
  IDataPackagePropertySetView3 = interface(IInspectable)
  ['{DB764CE5-D174-495C-84FC-1A51F6AB45D7}']
    function get_EnterpriseId: HSTRING; safecall;
    property EnterpriseId: HSTRING read get_EnterpriseId;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySet
  [WinRTClassNameAttribute(SDataPackagePropertySet)]
  IDataPackagePropertySet = interface(IInspectable)
  ['{CD1C93EB-4C4C-443A-A8D3-F5C241E91689}']
    function get_Title: HSTRING; safecall;
    procedure put_Title(value: HSTRING); safecall;
    function get_Description: HSTRING; safecall;
    procedure put_Description(value: HSTRING); safecall;
    function get_Thumbnail: IRandomAccessStreamReference; safecall;
    procedure put_Thumbnail(value: IRandomAccessStreamReference); safecall;
    function get_FileTypes: IVector_1__HSTRING; safecall;
    function get_ApplicationName: HSTRING; safecall;
    procedure put_ApplicationName(value: HSTRING); safecall;
    function get_ApplicationListingUri: IUriRuntimeClass; safecall;
    procedure put_ApplicationListingUri(value: IUriRuntimeClass); safecall;
    property ApplicationListingUri: IUriRuntimeClass read get_ApplicationListingUri write put_ApplicationListingUri;
    property ApplicationName: HSTRING read get_ApplicationName write put_ApplicationName;
    property Description: HSTRING read get_Description write put_Description;
    property FileTypes: IVector_1__HSTRING read get_FileTypes;
    property Thumbnail: IRandomAccessStreamReference read get_Thumbnail write put_Thumbnail;
    property Title: HSTRING read get_Title write put_Title;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySet2
  IDataPackagePropertySet2 = interface(IInspectable)
  ['{EB505D4A-9800-46AA-B181-7B6F0F2B919A}']
    function get_ContentSourceWebLink: IUriRuntimeClass; safecall;
    procedure put_ContentSourceWebLink(value: IUriRuntimeClass); safecall;
    function get_ContentSourceApplicationLink: IUriRuntimeClass; safecall;
    procedure put_ContentSourceApplicationLink(value: IUriRuntimeClass); safecall;
    function get_PackageFamilyName: HSTRING; safecall;
    procedure put_PackageFamilyName(value: HSTRING); safecall;
    function get_Square30x30Logo: IRandomAccessStreamReference; safecall;
    procedure put_Square30x30Logo(value: IRandomAccessStreamReference); safecall;
    function get_LogoBackgroundColor: Color; safecall;
    procedure put_LogoBackgroundColor(value: Color); safecall;
    property ContentSourceApplicationLink: IUriRuntimeClass read get_ContentSourceApplicationLink write put_ContentSourceApplicationLink;
    property ContentSourceWebLink: IUriRuntimeClass read get_ContentSourceWebLink write put_ContentSourceWebLink;
    property LogoBackgroundColor: Color read get_LogoBackgroundColor write put_LogoBackgroundColor;
    property PackageFamilyName: HSTRING read get_PackageFamilyName write put_PackageFamilyName;
    property Square30x30Logo: IRandomAccessStreamReference read get_Square30x30Logo write put_Square30x30Logo;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackagePropertySet3
  IDataPackagePropertySet3 = interface(IInspectable)
  ['{9E87FD9B-5205-401B-874A-455653BD39E8}']
    function get_EnterpriseId: HSTRING; safecall;
    procedure put_EnterpriseId(value: HSTRING); safecall;
    property EnterpriseId: HSTRING read get_EnterpriseId write put_EnterpriseId;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataProviderDeferral
  [WinRTClassNameAttribute(SDataProviderDeferral)]
  IDataProviderDeferral = interface(IInspectable)
  ['{C2CF2373-2D26-43D9-B69D-DCB86D03F6DA}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataProviderRequest
  [WinRTClassNameAttribute(SDataProviderRequest)]
  IDataProviderRequest = interface(IInspectable)
  ['{EBBC7157-D3C8-47DA-ACDE-F82388D5F716}']
    function get_FormatId: HSTRING; safecall;
    function get_Deadline: DateTime; safecall;
    function GetDeferral: IDataProviderDeferral; safecall;
    procedure SetData(value: IInspectable); safecall;
    property Deadline: DateTime read get_Deadline;
    property FormatId: HSTRING read get_FormatId;
  end;

  // Windows.ApplicationModel.DataTransfer.DataProviderHandler
  DataProviderHandler = interface(IUnknown)
  ['{E7ECD720-F2F4-4A2D-920E-170A2F482A27}']
    procedure Invoke(request: IDataProviderRequest); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IOperationCompletedEventArgs
  [WinRTClassNameAttribute(SOperationCompletedEventArgs)]
  IOperationCompletedEventArgs = interface(IInspectable)
  ['{E7AF329D-051D-4FAB-B1A9-47FD77F70A41}']
    function get_Operation: DataPackageOperation; safecall;
    property Operation: DataPackageOperation read get_Operation;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackageView
  [WinRTClassNameAttribute(SDataPackageView)]
  IDataPackageView = interface(IInspectable)
  ['{7B840471-5900-4D85-A90B-10CB85FE3552}']
    function get_Properties: IDataPackagePropertySetView; safecall;
    function get_RequestedOperation: DataPackageOperation; safecall;
    procedure ReportOperationCompleted(value: DataPackageOperation); safecall;
    function get_AvailableFormats: IVectorView_1__HSTRING; safecall;
    function Contains(formatId: HSTRING): Boolean; safecall;
    function GetDataAsync(formatId: HSTRING): IAsyncOperation_1__IInspectable; safecall;
    function GetTextAsync: IAsyncOperation_1__HSTRING; overload; safecall;
    function GetTextAsync(formatId: HSTRING): IAsyncOperation_1__HSTRING; overload; safecall;
    function GetUriAsync: IAsyncOperation_1__IUriRuntimeClass; safecall;
    function GetHtmlFormatAsync: IAsyncOperation_1__HSTRING; safecall;
    function GetResourceMapAsync: IAsyncOperation_1__IMapView_2__HSTRING__IRandomAccessStreamReference; safecall;
    function GetRtfAsync: IAsyncOperation_1__HSTRING; safecall;
    function GetBitmapAsync: IAsyncOperation_1__IRandomAccessStreamReference; safecall;
    function GetStorageItemsAsync: IAsyncOperation_1__IVectorView_1__IStorageItem; safecall;
    property AvailableFormats: IVectorView_1__HSTRING read get_AvailableFormats;
    property Properties: IDataPackagePropertySetView read get_Properties;
    property RequestedOperation: DataPackageOperation read get_RequestedOperation;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackageView2
  IDataPackageView2 = interface(IInspectable)
  ['{40ECBA95-2450-4C1D-B6B4-ED45463DEE9C}']
    function GetApplicationLinkAsync: IAsyncOperation_1__IUriRuntimeClass; safecall;
    function GetWebLinkAsync: IAsyncOperation_1__IUriRuntimeClass; safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackageView3
  IDataPackageView3 = interface(IInspectable)
  ['{D37771A8-DDAD-4288-8428-D1CAE394128B}']
    function RequestAccessAsync: IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult; overload; safecall;
    function RequestAccessAsync(enterpriseId: HSTRING): IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult; overload; safecall;
    function UnlockAndAssumeEnterpriseIdentity: EnterpriseData_ProtectionPolicyEvaluationResult; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataPackage,Windows.ApplicationModel.DataTransfer.IOperationCompletedEventArgs>
  TypedEventHandler_2__IDataPackage__IOperationCompletedEventArgs_Delegate_Base = interface(IUnknown)
  ['{DD48AF6C-EF9A-59CB-B326-57D9E2411F21}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataPackage,Windows.ApplicationModel.DataTransfer.IOperationCompletedEventArgs>
  TypedEventHandler_2__IDataPackage__IOperationCompletedEventArgs = interface(TypedEventHandler_2__IDataPackage__IOperationCompletedEventArgs_Delegate_Base)
  ['{DE9E577F-9562-5D55-A33B-9EE39B3E5435}']
    procedure Invoke(sender: IDataPackage; args: IOperationCompletedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataPackage,Object>
  TypedEventHandler_2__IDataPackage__IInspectable_Delegate_Base = interface(IUnknown)
  ['{C156B0C3-1CBC-5CA4-901C-62C5A8CA5CB5}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataPackage,Object>
  TypedEventHandler_2__IDataPackage__IInspectable = interface(TypedEventHandler_2__IDataPackage__IInspectable_Delegate_Base)
  ['{FFA86A6A-1BEE-540E-9911-7272C487A1ED}']
    procedure Invoke(sender: IDataPackage; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackage
  [WinRTClassNameAttribute(SDataPackage)]
  IDataPackage = interface(IInspectable)
  ['{61EBF5C7-EFEA-4346-9554-981D7E198FFE}']
    function GetView: IDataPackageView; safecall;
    function get_Properties: IDataPackagePropertySet; safecall;
    function get_RequestedOperation: DataPackageOperation; safecall;
    procedure put_RequestedOperation(value: DataPackageOperation); safecall;
    function add_OperationCompleted(handler: TypedEventHandler_2__IDataPackage__IOperationCompletedEventArgs): EventRegistrationToken; safecall;
    procedure remove_OperationCompleted(eventCookie: EventRegistrationToken); safecall;
    function add_Destroyed(handler: TypedEventHandler_2__IDataPackage__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Destroyed(eventCookie: EventRegistrationToken); safecall;
    procedure SetData(formatId: HSTRING; value: IInspectable); safecall;
    procedure SetDataProvider(formatId: HSTRING; delayRenderer: DataProviderHandler); safecall;
    procedure SetText(value: HSTRING); safecall;
    procedure SetUri(value: IUriRuntimeClass); safecall;
    procedure SetHtmlFormat(value: HSTRING); safecall;
    function get_ResourceMap: IMap_2__HSTRING__IRandomAccessStreamReference; safecall;
    procedure SetRtf(value: HSTRING); safecall;
    procedure SetBitmap(value: IRandomAccessStreamReference); safecall;
    procedure SetStorageItems(value: IIterable_1__IStorageItem); overload; safecall;
    procedure SetStorageItems(value: IIterable_1__IStorageItem; readOnly: Boolean); overload; safecall;
    property Properties: IDataPackagePropertySet read get_Properties;
    property RequestedOperation: DataPackageOperation read get_RequestedOperation write put_RequestedOperation;
    property ResourceMap: IMap_2__HSTRING__IRandomAccessStreamReference read get_ResourceMap;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataPackage2
  IDataPackage2 = interface(IInspectable)
  ['{041C1FE9-2409-45E1-A538-4C53EEEE04A7}']
    procedure SetApplicationLink(value: IUriRuntimeClass); safecall;
    procedure SetWebLink(value: IUriRuntimeClass); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IHtmlFormatHelperStatics
  [WinRTClassNameAttribute(SHtmlFormatHelper)]
  IHtmlFormatHelperStatics = interface(IInspectable)
  ['{E22E7749-DD70-446F-AEFC-61CEE59F655E}']
    function GetStaticFragment(htmlFormat: HSTRING): HSTRING; safecall;
    function CreateHtmlFormat(htmlFragment: HSTRING): HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IClipboardStatics
  [WinRTClassNameAttribute(SClipboard)]
  IClipboardStatics = interface(IInspectable)
  ['{C627E291-34E2-4963-8EED-93CBB0EA3D70}']
    function GetContent: IDataPackageView; safecall;
    procedure SetContent(content: IDataPackage); safecall;
    procedure Flush; safecall;
    procedure Clear; safecall;
    function add_ContentChanged(changeHandler: EventHandler_1__IInspectable): EventRegistrationToken; safecall;
    procedure remove_ContentChanged(token: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragInfo
  [WinRTClassNameAttribute(SDragDrop_Core_CoreDragInfo)]
  DragDrop_Core_ICoreDragInfo = interface(IInspectable)
  ['{48353A8B-CB50-464E-9575-CD4E3A7AB028}']
    function get_Data: IDataPackageView; safecall;
    function get_Modifiers: DragDrop_DragDropModifiers; safecall;
    function get_Position: TPointF; safecall;
    property Data: IDataPackageView read get_Data;
    property Modifiers: DragDrop_DragDropModifiers read get_Modifiers;
    property Position: TPointF read get_Position;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragUIOverride
  [WinRTClassNameAttribute(SDragDrop_Core_CoreDragUIOverride)]
  DragDrop_Core_ICoreDragUIOverride = interface(IInspectable)
  ['{89A85064-3389-4F4F-8897-7E8A3FFB3C93}']
    procedure SetContentFromSoftwareBitmap(softwareBitmap: Imaging_ISoftwareBitmap); overload; safecall;
    procedure SetContentFromSoftwareBitmap(softwareBitmap: Imaging_ISoftwareBitmap; anchorPoint: TPointF); overload; safecall;
    function get_IsContentVisible: Boolean; safecall;
    procedure put_IsContentVisible(value: Boolean); safecall;
    function get_Caption: HSTRING; safecall;
    procedure put_Caption(value: HSTRING); safecall;
    function get_IsCaptionVisible: Boolean; safecall;
    procedure put_IsCaptionVisible(value: Boolean); safecall;
    function get_IsGlyphVisible: Boolean; safecall;
    procedure put_IsGlyphVisible(value: Boolean); safecall;
    procedure Clear; safecall;
    property Caption: HSTRING read get_Caption write put_Caption;
    property IsCaptionVisible: Boolean read get_IsCaptionVisible write put_IsCaptionVisible;
    property IsContentVisible: Boolean read get_IsContentVisible write put_IsContentVisible;
    property IsGlyphVisible: Boolean read get_IsGlyphVisible write put_IsGlyphVisible;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.DataTransfer.DataPackageOperation>
  AsyncOperationCompletedHandler_1__DataPackageOperation_Delegate_Base = interface(IUnknown)
  ['{ADD21D46-17DF-5A43-A685-3262FCE84643}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.DataTransfer.DataPackageOperation>
  AsyncOperationCompletedHandler_1__DataPackageOperation = interface(AsyncOperationCompletedHandler_1__DataPackageOperation_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__DataPackageOperation; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.DataTransfer.DataPackageOperation>
  IAsyncOperation_1__DataPackageOperation_Base = interface(IInspectable)
  ['{8B98AEA9-64F0-5672-B30E-DFD9C2E4F6FE}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.DataTransfer.DataPackageOperation>
  IAsyncOperation_1__DataPackageOperation = interface(IAsyncOperation_1__DataPackageOperation_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__DataPackageOperation); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__DataPackageOperation; safecall;
    function GetResults: DataPackageOperation; safecall;
    property Completed: AsyncOperationCompletedHandler_1__DataPackageOperation read get_Completed write put_Completed;
  end;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDropOperationTarget
  DragDrop_Core_ICoreDropOperationTarget = interface(IInspectable)
  ['{D9126196-4C5B-417D-BB37-76381DEF8DB4}']
    function EnterAsync(dragInfo: DragDrop_Core_ICoreDragInfo; dragUIOverride: DragDrop_Core_ICoreDragUIOverride): IAsyncOperation_1__DataPackageOperation; safecall;
    function OverAsync(dragInfo: DragDrop_Core_ICoreDragInfo; dragUIOverride: DragDrop_Core_ICoreDragUIOverride): IAsyncOperation_1__DataPackageOperation; safecall;
    function LeaveAsync(dragInfo: DragDrop_Core_ICoreDragInfo): IAsyncAction; safecall;
    function DropAsync(dragInfo: DragDrop_Core_ICoreDragInfo): IAsyncOperation_1__DataPackageOperation; safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragOperation
  [WinRTClassNameAttribute(SDragDrop_Core_CoreDragOperation)]
  DragDrop_Core_ICoreDragOperation = interface(IInspectable)
  ['{CC06DE4F-6DB0-4E62-AB1B-A74A02DC6D85}']
    function get_Data: IDataPackage; safecall;
    procedure SetPointerId(pointerId: Cardinal); safecall;
    procedure SetDragUIContentFromSoftwareBitmap(softwareBitmap: Imaging_ISoftwareBitmap); overload; safecall;
    procedure SetDragUIContentFromSoftwareBitmap(softwareBitmap: Imaging_ISoftwareBitmap; anchorPoint: TPointF); overload; safecall;
    function get_DragUIContentMode: DragDrop_Core_CoreDragUIContentMode; safecall;
    procedure put_DragUIContentMode(value: DragDrop_Core_CoreDragUIContentMode); safecall;
    function StartAsync: IAsyncOperation_1__DataPackageOperation; safecall;
    property Data: IDataPackage read get_Data;
    property DragUIContentMode: DragDrop_Core_CoreDragUIContentMode read get_DragUIContentMode write put_DragUIContentMode;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDropOperationTargetRequestedEventArgs
  [WinRTClassNameAttribute(SDragDrop_Core_CoreDropOperationTargetRequestedEventArgs)]
  DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs = interface(IInspectable)
  ['{2ACA929A-5E28-4EA6-829E-29134E665D6D}']
    procedure SetTarget(target: DragDrop_Core_ICoreDropOperationTarget); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragDropManager,Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDropOperationTargetRequestedEventArgs>
  TypedEventHandler_2__DragDrop_Core_ICoreDragDropManager__DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs_Delegate_Base = interface(IUnknown)
  ['{A4C3B1C1-B8AD-58CB-ACC0-8EF37EAE4ED4}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragDropManager,Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDropOperationTargetRequestedEventArgs>
  TypedEventHandler_2__DragDrop_Core_ICoreDragDropManager__DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs = interface(TypedEventHandler_2__DragDrop_Core_ICoreDragDropManager__DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs_Delegate_Base)
  ['{79E5B8A1-F24A-5D72-9E29-0503937617EB}']
    procedure Invoke(sender: DragDrop_Core_ICoreDragDropManager; args: DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragDropManager
  [WinRTClassNameAttribute(SDragDrop_Core_CoreDragDropManager)]
  DragDrop_Core_ICoreDragDropManager = interface(IInspectable)
  ['{7D56D344-8464-4FAF-AA49-37EA6E2D7BD1}']
    function add_TargetRequested(value: TypedEventHandler_2__DragDrop_Core_ICoreDragDropManager__DragDrop_Core_ICoreDropOperationTargetRequestedEventArgs): EventRegistrationToken; safecall;
    procedure remove_TargetRequested(value: EventRegistrationToken); safecall;
    function get_AreConcurrentOperationsEnabled: Boolean; safecall;
    procedure put_AreConcurrentOperationsEnabled(value: Boolean); safecall;
    property AreConcurrentOperationsEnabled: Boolean read get_AreConcurrentOperationsEnabled write put_AreConcurrentOperationsEnabled;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.ICoreDragDropManagerStatics
  [WinRTClassNameAttribute(SDragDrop_Core_CoreDragDropManager)]
  DragDrop_Core_ICoreDragDropManagerStatics = interface(IInspectable)
  ['{9542FDCA-DA12-4C1C-8D06-041DB29733C3}']
    function GetForCurrentView: DragDrop_Core_ICoreDragDropManager; safecall;
  end;

  // Windows.ApplicationModel.DataTransfer.IDataRequestDeferral
  IDataRequestDeferral = interface(IInspectable)
  ['{6DC4B89F-0386-4263-87C1-ED7DCE30890E}']
    procedure Complete; safecall;
  end;

  // Windows.ApplicationModel.DataTransfer.IDataRequest
  IDataRequest = interface(IInspectable)
  ['{4341AE3B-FC12-4E53-8C02-AC714C415A27}']
    function get_Data: IDataPackage; safecall;
    procedure put_Data(value: IDataPackage); safecall;
    function get_Deadline: DateTime; safecall;
    procedure FailWithDisplayText(value: HSTRING); safecall;
    function GetDeferral: IDataRequestDeferral; safecall;
    property Data: IDataPackage read get_Data write put_Data;
    property Deadline: DateTime read get_Deadline;
  end;

  // Windows.ApplicationModel.DataTransfer.IDataRequestedEventArgs
  IDataRequestedEventArgs = interface(IInspectable)
  ['{CB8BA807-6AC5-43C9-8AC5-9BA232163182}']
    function get_Request: IDataRequest; safecall;
    property Request: IDataRequest read get_Request;
  end;

  // Windows.ApplicationModel.DataTransfer.ITargetApplicationChosenEventArgs
  ITargetApplicationChosenEventArgs = interface(IInspectable)
  ['{CA6FB8AC-2987-4EE3-9C54-D8AFBCB86C1D}']
    function get_ApplicationName: HSTRING; safecall;
    property ApplicationName: HSTRING read get_ApplicationName;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataTransferManager,Windows.ApplicationModel.DataTransfer.IDataRequestedEventArgs>
  TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs_Delegate_Base = interface(IUnknown)
  ['{EC6F9CC8-46D0-5E0E-B4D2-7D7773AE37A0}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataTransferManager,Windows.ApplicationModel.DataTransfer.IDataRequestedEventArgs>
  TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs = interface(TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs_Delegate_Base)
  ['{041062FC-4655-55C7-A13F-1153F9CA6E51}']
    procedure Invoke(sender: IDataTransferManager; args: IDataRequestedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataTransferManager,Windows.ApplicationModel.DataTransfer.ITargetApplicationChosenEventArgs>
  TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs_Delegate_Base = interface(IUnknown)
  ['{C4AC1BA2-7851-5A44-BC8D-3D7C713F1F41}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.DataTransfer.IDataTransferManager,Windows.ApplicationModel.DataTransfer.ITargetApplicationChosenEventArgs>
  TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs = interface(TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs_Delegate_Base)
  ['{A3639038-7CA2-5BF9-9657-DDBB0B7C6142}']
    procedure Invoke(sender: IDataTransferManager; args: ITargetApplicationChosenEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataTransferManager
  [WinRTClassNameAttribute(SDataTransferManager)]
  IDataTransferManager = interface(IInspectable)
  ['{A5CAEE9B-8708-49D1-8D36-67D25A8DA00C}']
    function add_DataRequested(eventHandler: TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DataRequested(eventCookie: EventRegistrationToken); safecall;
    function add_TargetApplicationChosen(eventHandler: TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs): EventRegistrationToken; safecall;
    procedure remove_TargetApplicationChosen(eventCookie: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.DataTransfer.IDataTransferManagerStatics
  [WinRTClassNameAttribute(SDataTransferManager)]
  IDataTransferManagerStatics = interface(IInspectable)
  ['{A9DA01AA-E00E-4CFE-AA44-2DD932DCA3D8}']
    procedure ShowShareUI; safecall;
    function GetForCurrentView: IDataTransferManager; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.DataTransfer.IDataPackage>
  AsyncOperationCompletedHandler_1__IDataPackage_Delegate_Base = interface(IUnknown)
  ['{A93A3B99-E946-57CE-AAD9-C23D138C353E}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.DataTransfer.IDataPackage>
  AsyncOperationCompletedHandler_1__IDataPackage = interface(AsyncOperationCompletedHandler_1__IDataPackage_Delegate_Base)
  ['{926269A5-BCC6-5C70-90E0-79EAF8ECBABC}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IDataPackage; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.DataTransfer.IDataPackage>
  IAsyncOperation_1__IDataPackage_Base = interface(IInspectable)
  ['{A16F2D07-EAD3-53E4-9490-75BDBAEB7A5B}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.DataTransfer.IDataPackage>
  IAsyncOperation_1__IDataPackage = interface(IAsyncOperation_1__IDataPackage_Base)
  ['{F5B89375-4322-58CD-9F18-DBCF55147BF3}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IDataPackage); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IDataPackage; safecall;
    function GetResults: IDataPackage; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IDataPackage read get_Completed write put_Completed;
  end;


  // Emit Forwarded classes
  // Windows.ApplicationModel.DataTransfer.StandardDataFormats
  // DualAPI
  TStandardDataFormats = class(TWinRTGenericImportS2<IStandardDataFormatsStatics, IStandardDataFormatsStatics2>)
  public
    // -> IStandardDataFormatsStatics
    class function get_Text: HSTRING; static; inline;
    class function get_Uri: HSTRING; static; inline;
    class function get_Html: HSTRING; static; inline;
    class function get_Rtf: HSTRING; static; inline;
    class function get_Bitmap: HSTRING; static; inline;
    class function get_StorageItems: HSTRING; static; inline;
    class property Bitmap: HSTRING read get_Bitmap;
    class property Html: HSTRING read get_Html;
    class property Rtf: HSTRING read get_Rtf;
    class property StorageItems: HSTRING read get_StorageItems;
    class property Text: HSTRING read get_Text;
    class property Uri: HSTRING read get_Uri;

    // -> IStandardDataFormatsStatics2
    class function get_WebLink: HSTRING; static; inline;
    class function get_ApplicationLink: HSTRING; static; inline;
    class property ApplicationLink: HSTRING read get_ApplicationLink;
    class property WebLink: HSTRING read get_WebLink;
  end;

  // Windows.ApplicationModel.DataTransfer.DataPackagePropertySetView
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DataPackagePropertySet
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DataProviderDeferral
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DataProviderRequest
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.OperationCompletedEventArgs
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DataPackageView
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DataPackage
  // DualAPI
  TDataPackage = class(TWinRTGenericImportI<IDataPackage>) end;

  // Windows.ApplicationModel.DataTransfer.HtmlFormatHelper
  // DualAPI
  THtmlFormatHelper = class(TWinRTGenericImportS<IHtmlFormatHelperStatics>)
  public
    // -> IHtmlFormatHelperStatics
    class function GetStaticFragment(htmlFormat: HSTRING): HSTRING; static; inline;
    class function CreateHtmlFormat(htmlFragment: HSTRING): HSTRING; static; inline;
  end;

  // Windows.ApplicationModel.DataTransfer.Clipboard
  // DualAPI
  TClipboard = class(TWinRTGenericImportS<IClipboardStatics>)
  public
    // -> IClipboardStatics
    class function GetContent: IDataPackageView; static; inline;
    class procedure SetContent(content: IDataPackage); static; inline;
    class procedure Flush; static; inline;
    class procedure Clear; static; inline;
    class function add_ContentChanged(changeHandler: EventHandler_1__IInspectable): EventRegistrationToken; static; inline;
    class procedure remove_ContentChanged(token: EventRegistrationToken); static; inline;
  end;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragInfo
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragUIOverride
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragDropManager
  // DualAPI
  TDragDrop_Core_CoreDragDropManager = class(TWinRTGenericImportS<DragDrop_Core_ICoreDragDropManagerStatics>)
  public
    // -> DragDrop_Core_ICoreDragDropManagerStatics
    class function GetForCurrentView: DragDrop_Core_ICoreDragDropManager; static; inline;
  end;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDropOperationTargetRequestedEventArgs
  // DualAPI

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragOperation
  // DualAPI
  TDragDrop_Core_CoreDragOperation = class(TWinRTGenericImportI<DragDrop_Core_ICoreDragOperation>) end;

  // Windows.ApplicationModel.DataTransfer.DataTransferManager
  // DualAPI
  IDataTransferManagerInterop = interface(IUnknown)
    ['{3A3DCD6C-3EAB-43DC-BCDE-45671CE800C8}']
    function GetForWindow(appWindow: THandle; const riid: TGUID): IDataTransferManager; safecall;
    procedure ShowShareUIForWindow(appWindow: THandle); safecall;
  end;
  TDataTransferManager = class(TWinRTGenericImportSO<IDataTransferManagerStatics, IDataTransferManagerInterop>)
  public
    // -> IDataTransferManagerStatics
    class procedure ShowShareUI; static; inline;
    class function GetForCurrentView: IDataTransferManager; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TStandardDataFormats }

class function TStandardDataFormats.get_Text: HSTRING;
begin
  Result := Statics.get_Text;
end;

class function TStandardDataFormats.get_Uri: HSTRING;
begin
  Result := Statics.get_Uri;
end;

class function TStandardDataFormats.get_Html: HSTRING;
begin
  Result := Statics.get_Html;
end;

class function TStandardDataFormats.get_Rtf: HSTRING;
begin
  Result := Statics.get_Rtf;
end;

class function TStandardDataFormats.get_Bitmap: HSTRING;
begin
  Result := Statics.get_Bitmap;
end;

class function TStandardDataFormats.get_StorageItems: HSTRING;
begin
  Result := Statics.get_StorageItems;
end;


class function TStandardDataFormats.get_WebLink: HSTRING;
begin
  Result := Statics2.get_WebLink;
end;

class function TStandardDataFormats.get_ApplicationLink: HSTRING;
begin
  Result := Statics2.get_ApplicationLink;
end;


 { TDataPackage }

 { THtmlFormatHelper }

class function THtmlFormatHelper.GetStaticFragment(htmlFormat: HSTRING): HSTRING;
begin
  Result := Statics.GetStaticFragment(htmlFormat);
end;

class function THtmlFormatHelper.CreateHtmlFormat(htmlFragment: HSTRING): HSTRING;
begin
  Result := Statics.CreateHtmlFormat(htmlFragment);
end;


 { TClipboard }

class function TClipboard.GetContent: IDataPackageView;
begin
  Result := Statics.GetContent;
end;

class procedure TClipboard.SetContent(content: IDataPackage);
begin
  Statics.SetContent(content);
end;

class procedure TClipboard.Flush;
begin
  Statics.Flush;
end;

class procedure TClipboard.Clear;
begin
  Statics.Clear;
end;

class function TClipboard.add_ContentChanged(changeHandler: EventHandler_1__IInspectable): EventRegistrationToken;
begin
  Result := Statics.add_ContentChanged(changeHandler);
end;

class procedure TClipboard.remove_ContentChanged(token: EventRegistrationToken);
begin
  Statics.remove_ContentChanged(token);
end;


 { TDragDrop_Core_CoreDragDropManager }

class function TDragDrop_Core_CoreDragDropManager.GetForCurrentView: DragDrop_Core_ICoreDragDropManager;
begin
  Result := Statics.GetForCurrentView;
end;


 { TDragDrop_Core_CoreDragOperation }

 { TDataTransferManager }

class procedure TDataTransferManager.ShowShareUI;
begin
  Statics.ShowShareUI;
end;

class function TDataTransferManager.GetForCurrentView: IDataTransferManager;
begin
  Result := Statics.GetForCurrentView;
end;



end.
