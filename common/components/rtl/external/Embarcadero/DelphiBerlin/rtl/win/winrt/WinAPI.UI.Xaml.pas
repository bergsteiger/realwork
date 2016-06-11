{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.Xaml;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Devices,
  Winapi.UI.Core,
  Winapi.ApplicationModel.DataTransfer,
  Winapi.UI.Input,
  Winapi.GraphicsRT,
  Winapi.UI.Text,
  Winapi.Media,
  Winapi.WebRT,
  Winapi.ApplicationModel,
  Winapi.UI.Input.Inking,
  Winapi.ApplicationModel.Background,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.Globalization,
  Winapi.Storage.Streams,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // External: Windows.UI.Xaml.Interop.IBindableIterator
  Interop_IBindableIterator = interface;
  PInterop_IBindableIterator = ^Interop_IBindableIterator;

  // External: Windows.UI.Xaml.Interop.IBindableIterable
  Interop_IBindableIterable = interface;
  PInterop_IBindableIterable = ^Interop_IBindableIterable;

  // External: Windows.UI.Xaml.Interop.IBindableVectorView
  Interop_IBindableVectorView = interface;
  PInterop_IBindableVectorView = ^Interop_IBindableVectorView;

  // External: Windows.UI.Xaml.Interop.IBindableVector
  Interop_IBindableVector = interface;
  PInterop_IBindableVector = ^Interop_IBindableVector;

  // External: Windows.UI.Xaml.Interop.IBindableObservableVector
  Interop_IBindableObservableVector = interface;
  PInterop_IBindableObservableVector = ^Interop_IBindableObservableVector;

  // External: Windows.UI.Xaml.Interop.BindableVectorChangedEventHandler
  Interop_BindableVectorChangedEventHandler = interface;
  PInterop_BindableVectorChangedEventHandler = ^Interop_BindableVectorChangedEventHandler;

  // External: Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Xaml.Data.LoadMoreItemsResult>
  AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult = interface;
  PAsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult = ^AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult;

  // External: Windows.Foundation.IAsyncOperation`1<Windows.UI.Xaml.Data.LoadMoreItemsResult>
  IAsyncOperation_1__Data_LoadMoreItemsResult = interface;
  PIAsyncOperation_1__Data_LoadMoreItemsResult = ^IAsyncOperation_1__Data_LoadMoreItemsResult;

  // External: Windows.UI.Xaml.CreateDefaultValueCallback
  CreateDefaultValueCallback = interface;
  PCreateDefaultValueCallback = ^CreateDefaultValueCallback;

  // External: Windows.UI.Xaml.Documents.ITextElementFactory
  Documents_ITextElementFactory = interface;
  PDocuments_ITextElementFactory = ^Documents_ITextElementFactory;

  // External: Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.UI.Xaml.Controls.IGroupStyle>
  VectorChangedEventHandler_1__Controls_IGroupStyle = interface;
  PVectorChangedEventHandler_1__Controls_IGroupStyle = ^VectorChangedEventHandler_1__Controls_IGroupStyle;

  // External: Windows.Foundation.Collections.IObservableVector`1<Windows.UI.Xaml.Controls.IGroupStyle>
  IObservableVector_1__Controls_IGroupStyle = interface;
  PIObservableVector_1__Controls_IGroupStyle = ^IObservableVector_1__Controls_IGroupStyle;

  // External: Windows.UI.Xaml.Controls.IVirtualizingPanelFactory
  Controls_IVirtualizingPanelFactory = interface;
  PControls_IVirtualizingPanelFactory = ^Controls_IVirtualizingPanelFactory;

  // External: Windows.UI.Xaml.Controls.IListViewBaseHeaderItemFactory
  Controls_IListViewBaseHeaderItemFactory = interface;
  PControls_IListViewBaseHeaderItemFactory = ^Controls_IListViewBaseHeaderItemFactory;

  // External: Windows.UI.Xaml.Input.ICommand
  Input_ICommand = interface;
  PInput_ICommand = ^Input_ICommand;

  // External: Windows.UI.Xaml.Controls.Primitives.IOrientedVirtualizingPanelFactory
  Controls_Primitives_IOrientedVirtualizingPanelFactory = interface;
  PControls_Primitives_IOrientedVirtualizingPanelFactory = ^Controls_Primitives_IOrientedVirtualizingPanelFactory;

  // External: Windows.UI.Xaml.Controls.Primitives.ISelectorFactory
  Controls_Primitives_ISelectorFactory = interface;
  PControls_Primitives_ISelectorFactory = ^Controls_Primitives_ISelectorFactory;

  // External: Windows.Foundation.Collections.IIterator`1<Windows.UI.Color>
  IIterator_1__Color = interface;
  PIIterator_1__Color = ^IIterator_1__Color;

  // External: Windows.Foundation.Collections.IIterable`1<Windows.UI.Color>
  IIterable_1__Color = interface;
  PIIterable_1__Color = ^IIterable_1__Color;

  // External: Windows.UI.Xaml.Controls.ListViewItemToKeyHandler
  Controls_ListViewItemToKeyHandler = interface;
  PControls_ListViewItemToKeyHandler = ^Controls_ListViewItemToKeyHandler;

  // External: Windows.UI.Xaml.Controls.ListViewKeyToItemHandler
  Controls_ListViewKeyToItemHandler = interface;
  PControls_ListViewKeyToItemHandler = ^Controls_ListViewKeyToItemHandler;

  // External: Windows.UI.Xaml.Controls.ISectionsInViewChangedEventArgsFactory
  Controls_ISectionsInViewChangedEventArgsFactory = interface;
  PControls_ISectionsInViewChangedEventArgsFactory = ^Controls_ISectionsInViewChangedEventArgsFactory;

  // External: Windows.UI.Xaml.Controls.IIconElementFactory
  Controls_IIconElementFactory = interface;
  PControls_IIconElementFactory = ^Controls_IIconElementFactory;

  // External: Windows.UI.Xaml.Controls.IMenuFlyoutItemBaseFactory
  Controls_IMenuFlyoutItemBaseFactory = interface;
  PControls_IMenuFlyoutItemBaseFactory = ^Controls_IMenuFlyoutItemBaseFactory;

  // External: Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Xaml.Controls.ContentDialogResult>
  AsyncOperationCompletedHandler_1__Controls_ContentDialogResult = interface;
  PAsyncOperationCompletedHandler_1__Controls_ContentDialogResult = ^AsyncOperationCompletedHandler_1__Controls_ContentDialogResult;

  // External: Windows.Foundation.IAsyncOperation`1<Windows.UI.Xaml.Controls.ContentDialogResult>
  IAsyncOperation_1__Controls_ContentDialogResult = interface;
  PIAsyncOperation_1__Controls_ContentDialogResult = ^IAsyncOperation_1__Controls_ContentDialogResult;

  // External: Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.UI.Xaml.Controls.ICommandBarElement>
  VectorChangedEventHandler_1__Controls_ICommandBarElement = interface;
  PVectorChangedEventHandler_1__Controls_ICommandBarElement = ^VectorChangedEventHandler_1__Controls_ICommandBarElement;

  // External: Windows.Foundation.Collections.IObservableVector`1<Windows.UI.Xaml.Controls.ICommandBarElement>
  IObservableVector_1__Controls_ICommandBarElement = interface;
  PIObservableVector_1__Controls_ICommandBarElement = ^IObservableVector_1__Controls_ICommandBarElement;

  // External: Windows.UI.Xaml.IExceptionRoutedEventArgsFactory
  IExceptionRoutedEventArgsFactory = interface;
  PIExceptionRoutedEventArgsFactory = ^IExceptionRoutedEventArgsFactory;

  // External: Windows.UI.Xaml.ISetterBaseFactory
  ISetterBaseFactory = interface;
  PISetterBaseFactory = ^ISetterBaseFactory;

  // External: Windows.UI.Xaml.ITriggerActionFactory
  ITriggerActionFactory = interface;
  PITriggerActionFactory = ^ITriggerActionFactory;

  // External: Windows.UI.Xaml.ITriggerBaseFactory
  ITriggerBaseFactory = interface;
  PITriggerBaseFactory = ^ITriggerBaseFactory;

  // External: Windows.UI.Xaml.IUIElementFactory
  IUIElementFactory = interface;
  PIUIElementFactory = ^IUIElementFactory;

  // External: Windows.UI.Xaml.Media.IGeometryFactory
  Media_IGeometryFactory = interface;
  PMedia_IGeometryFactory = ^Media_IGeometryFactory;

  // External: Windows.UI.Xaml.Media.IImageSourceFactory
  Media_IImageSourceFactory = interface;
  PMedia_IImageSourceFactory = ^Media_IImageSourceFactory;

  // External: Windows.UI.Xaml.Media.IPathSegmentFactory
  Media_IPathSegmentFactory = interface;
  PMedia_IPathSegmentFactory = ^Media_IPathSegmentFactory;

  // External: Windows.UI.Xaml.Media.ITransformFactory
  Media_ITransformFactory = interface;
  PMedia_ITransformFactory = ^Media_ITransformFactory;

  // External: Windows.UI.Xaml.Media.Animation.IEasingFunctionBaseFactory
  Media_Animation_IEasingFunctionBaseFactory = interface;
  PMedia_Animation_IEasingFunctionBaseFactory = ^Media_Animation_IEasingFunctionBaseFactory;

  // External: Windows.UI.Xaml.Media.Animation.ITransitionFactory
  Media_Animation_ITransitionFactory = interface;
  PMedia_Animation_ITransitionFactory = ^Media_Animation_ITransitionFactory;

  // External: Windows.Foundation.IReference`1<Windows.UI.Color>
  IReference_1__Color = interface;
  PIReference_1__Color = ^IReference_1__Color;

  // External: Windows.UI.Xaml.Automation.Provider.IIRawElementProviderSimple
  Automation_Provider_IIRawElementProviderSimple = interface;
  PAutomation_Provider_IIRawElementProviderSimple = ^Automation_Provider_IIRawElementProviderSimple;

  // External: Windows.UI.Xaml.Automation.Provider.IAnnotationProvider
  Automation_Provider_IAnnotationProvider = interface;
  PAutomation_Provider_IAnnotationProvider = ^Automation_Provider_IAnnotationProvider;

  // External: Windows.UI.Xaml.Automation.Provider.IDockProvider
  Automation_Provider_IDockProvider = interface;
  PAutomation_Provider_IDockProvider = ^Automation_Provider_IDockProvider;

  // External: Windows.UI.Xaml.Automation.Provider.IDragProvider
  Automation_Provider_IDragProvider = interface;
  PAutomation_Provider_IDragProvider = ^Automation_Provider_IDragProvider;

  // External: Windows.UI.Xaml.Automation.Provider.IGridItemProvider
  Automation_Provider_IGridItemProvider = interface;
  PAutomation_Provider_IGridItemProvider = ^Automation_Provider_IGridItemProvider;

  // External: Windows.UI.Xaml.Automation.Provider.IGridProvider
  Automation_Provider_IGridProvider = interface;
  PAutomation_Provider_IGridProvider = ^Automation_Provider_IGridProvider;

  // External: Windows.UI.Xaml.Automation.Provider.IMultipleViewProvider
  Automation_Provider_IMultipleViewProvider = interface;
  PAutomation_Provider_IMultipleViewProvider = ^Automation_Provider_IMultipleViewProvider;

  // External: Windows.UI.Xaml.Automation.Provider.IObjectModelProvider
  Automation_Provider_IObjectModelProvider = interface;
  PAutomation_Provider_IObjectModelProvider = ^Automation_Provider_IObjectModelProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ISpreadsheetItemProvider
  Automation_Provider_ISpreadsheetItemProvider = interface;
  PAutomation_Provider_ISpreadsheetItemProvider = ^Automation_Provider_ISpreadsheetItemProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ISpreadsheetProvider
  Automation_Provider_ISpreadsheetProvider = interface;
  PAutomation_Provider_ISpreadsheetProvider = ^Automation_Provider_ISpreadsheetProvider;

  // External: Windows.UI.Xaml.Automation.Provider.IStylesProvider
  Automation_Provider_IStylesProvider = interface;
  PAutomation_Provider_IStylesProvider = ^Automation_Provider_IStylesProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ISynchronizedInputProvider
  Automation_Provider_ISynchronizedInputProvider = interface;
  PAutomation_Provider_ISynchronizedInputProvider = ^Automation_Provider_ISynchronizedInputProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITableItemProvider
  Automation_Provider_ITableItemProvider = interface;
  PAutomation_Provider_ITableItemProvider = ^Automation_Provider_ITableItemProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITableProvider
  Automation_Provider_ITableProvider = interface;
  PAutomation_Provider_ITableProvider = ^Automation_Provider_ITableProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITextRangeProvider
  Automation_Provider_ITextRangeProvider = interface;
  PAutomation_Provider_ITextRangeProvider = ^Automation_Provider_ITextRangeProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITextChildProvider
  Automation_Provider_ITextChildProvider = interface;
  PAutomation_Provider_ITextChildProvider = ^Automation_Provider_ITextChildProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITextProvider
  Automation_Provider_ITextProvider = interface;
  PAutomation_Provider_ITextProvider = ^Automation_Provider_ITextProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITextProvider2
  Automation_Provider_ITextProvider2 = interface;
  PAutomation_Provider_ITextProvider2 = ^Automation_Provider_ITextProvider2;

  // External: Windows.UI.Xaml.Automation.Provider.ITextRangeProvider2
  Automation_Provider_ITextRangeProvider2 = interface;
  PAutomation_Provider_ITextRangeProvider2 = ^Automation_Provider_ITextRangeProvider2;

  // External: Windows.UI.Xaml.Automation.Provider.ITransformProvider
  Automation_Provider_ITransformProvider = interface;
  PAutomation_Provider_ITransformProvider = ^Automation_Provider_ITransformProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITransformProvider2
  Automation_Provider_ITransformProvider2 = interface;
  PAutomation_Provider_ITransformProvider2 = ^Automation_Provider_ITransformProvider2;

  // External: Windows.UI.Xaml.Automation.Provider.IWindowProvider
  Automation_Provider_IWindowProvider = interface;
  PAutomation_Provider_IWindowProvider = ^Automation_Provider_IWindowProvider;

  // External: Windows.UI.Xaml.Data.ICollectionViewGroup
  Data_ICollectionViewGroup = interface;
  PData_ICollectionViewGroup = ^Data_ICollectionViewGroup;

  // External: Windows.UI.Xaml.Data.ICustomProperty
  Data_ICustomProperty = interface;
  PData_ICustomProperty = ^Data_ICustomProperty;

  // External: Windows.UI.Xaml.Data.ISupportIncrementalLoading
  Data_ISupportIncrementalLoading = interface;
  PData_ISupportIncrementalLoading = ^Data_ISupportIncrementalLoading;

  // External: Windows.UI.Xaml.Data.IBindingExpressionBaseFactory
  Data_IBindingExpressionBaseFactory = interface;
  PData_IBindingExpressionBaseFactory = ^Data_IBindingExpressionBaseFactory;

  // External: Windows.UI.Xaml.Data.IBindingExpressionFactory
  Data_IBindingExpressionFactory = interface;
  PData_IBindingExpressionFactory = ^Data_IBindingExpressionFactory;

  // External: Windows.UI.Xaml.Markup.IComponentConnector
  Markup_IComponentConnector = interface;
  PMarkup_IComponentConnector = ^Markup_IComponentConnector;

  // External: Windows.UI.Xaml.Markup.IComponentConnector2
  Markup_IComponentConnector2 = interface;
  PMarkup_IComponentConnector2 = ^Markup_IComponentConnector2;

  // External: Windows.UI.Xaml.Markup.IXamlType
  Markup_IXamlType = interface;
  PMarkup_IXamlType = ^Markup_IXamlType;

  // External: Windows.UI.Xaml.Markup.IXamlMember
  Markup_IXamlMember = interface;
  PMarkup_IXamlMember = ^Markup_IXamlMember;

  // External: Windows.UI.Xaml.Markup.IXamlMetadataProvider
  Markup_IXamlMetadataProvider = interface;
  PMarkup_IXamlMetadataProvider = ^Markup_IXamlMetadataProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ICustomNavigationProvider
  Automation_Provider_ICustomNavigationProvider = interface;
  PAutomation_Provider_ICustomNavigationProvider = ^Automation_Provider_ICustomNavigationProvider;

  // External: Windows.UI.Xaml.Automation.Provider.ITextEditProvider
  Automation_Provider_ITextEditProvider = interface;
  PAutomation_Provider_ITextEditProvider = ^Automation_Provider_ITextEditProvider;

  // External: Windows.UI.Xaml.Markup.IDataTemplateComponent
  Markup_IDataTemplateComponent = interface;
  PMarkup_IDataTemplateComponent = ^Markup_IDataTemplateComponent;

  // External: Windows.Foundation.IReference`1<Windows.UI.Xaml.Thickness>
  IReference_1__Thickness = interface;
  PIReference_1__Thickness = ^IReference_1__Thickness;

  // External: Windows.UI.Xaml.Hosting.IXamlUIPresenterHost
  Hosting_IXamlUIPresenterHost = interface;
  PHosting_IXamlUIPresenterHost = ^Hosting_IXamlUIPresenterHost;

  // External: Windows.UI.Xaml.Hosting.IXamlUIPresenterHost2
  Hosting_IXamlUIPresenterHost2 = interface;
  PHosting_IXamlUIPresenterHost2 = ^Hosting_IXamlUIPresenterHost2;


  // Emit Forwarded interfaces
  // Windows.UI.Xaml Interfaces
  // Windows.UI.Xaml.Interop.IBindableIterator
  // External 
  Interop_IBindableIterator = interface(IInspectable)
  ['{6A1D6C07-076D-49F2-8314-F52C9C9A8331}']
    function get_Current: IInspectable; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    property Current: IInspectable read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.UI.Xaml.Interop.IBindableIterable
  // External 
  Interop_IBindableIterable = interface(IInspectable)
  ['{036D2C08-DF29-41AF-8AA2-D774BE62BA6F}']
    function First: Interop_IBindableIterator; safecall;
  end;

  // Windows.UI.Xaml.Interop.IBindableVectorView
  // External 
  Interop_IBindableVectorView = interface(IInspectable)
  ['{346DD6E7-976E-4BC3-815D-ECE243BC0F33}']
    function GetAt(index: Cardinal): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IInspectable; out index: Cardinal): Boolean; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.UI.Xaml.Interop.IBindableVector
  // External 
  Interop_IBindableVector = interface(IInspectable)
  ['{393DE7DE-6FD0-4C0D-BB71-47244A113E93}']
    function GetAt(index: Cardinal): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: Interop_IBindableVectorView; safecall;
    function IndexOf(value: IInspectable; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IInspectable); safecall;
    procedure InsertAt(index: Cardinal; value: IInspectable); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IInspectable); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.UI.Xaml.Interop.IBindableObservableVector
  // External 
  Interop_IBindableObservableVector = interface(IInspectable)
  ['{FE1EB536-7E7F-4F90-AC9A-474984AAE512}']
    function add_VectorChanged(value: Interop_BindableVectorChangedEventHandler): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.UI.Xaml.Interop.BindableVectorChangedEventHandler
  // External 
  Interop_BindableVectorChangedEventHandler = interface(IUnknown)
  ['{624CD4E1-D007-43B1-9C03-AF4D3E6258C4}']
    procedure Invoke(vector: Interop_IBindableObservableVector; e: IInspectable); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Xaml.Data.LoadMoreItemsResult>
  AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult_Delegate_Base = interface(IUnknown)
  ['{10FB738B-A63B-506E-9ED7-2EAB37915221}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Xaml.Data.LoadMoreItemsResult>
  // External 
  AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult = interface(AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Data_LoadMoreItemsResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.UI.Xaml.Data.LoadMoreItemsResult>
  IAsyncOperation_1__Data_LoadMoreItemsResult_Base = interface(IInspectable)
  ['{C788089D-37AB-5BA2-B865-5A309ACDFC4D}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.UI.Xaml.Data.LoadMoreItemsResult>
  // External 
  IAsyncOperation_1__Data_LoadMoreItemsResult = interface(IAsyncOperation_1__Data_LoadMoreItemsResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult; safecall;
    function GetResults: Data_LoadMoreItemsResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Data_LoadMoreItemsResult read get_Completed write put_Completed;
  end;

  // Windows.UI.Xaml.CreateDefaultValueCallback
  // External 
  CreateDefaultValueCallback = interface(IUnknown)
  ['{D6ECB12C-15B5-4EC8-B95C-CDD208F08153}']
    function Invoke: IInspectable; safecall;
  end;

  // Windows.UI.Xaml.Documents.ITextElementFactory
  // External 
  Documents_ITextElementFactory = interface(IInspectable)
  ['{35007285-CF47-4BFE-B1BC-39C93AF4AE80}']
  end;

  // Generic Delegate for 
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.UI.Xaml.Controls.IGroupStyle>
  VectorChangedEventHandler_1__Controls_IGroupStyle_Delegate_Base = interface(IUnknown)
  ['{2CAA8225-B3D4-5725-B0CF-5E6E61453B23}']
  end;
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.UI.Xaml.Controls.IGroupStyle>
  // External 
  VectorChangedEventHandler_1__Controls_IGroupStyle = interface(VectorChangedEventHandler_1__Controls_IGroupStyle_Delegate_Base)
  ['{9F07FAA2-97FC-5A69-9C31-FA23937DB2E9}']
    procedure Invoke(sender: IObservableVector_1__Controls_IGroupStyle; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.UI.Xaml.Controls.IGroupStyle>
  // External 
  IObservableVector_1__Controls_IGroupStyle = interface(IInspectable)
  ['{693D0DA3-AF0B-533B-9642-F16B63E0BC4F}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__Controls_IGroupStyle): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.UI.Xaml.Controls.IVirtualizingPanelFactory
  // External 
  Controls_IVirtualizingPanelFactory = interface(IInspectable)
  ['{BE19F839-CBD0-43E9-A5D0-0BDBA0FFBD38}']
  end;

  // Windows.UI.Xaml.Controls.IListViewBaseHeaderItemFactory
  // External 
  Controls_IListViewBaseHeaderItemFactory = interface(IInspectable)
  ['{3872A6A1-EA19-455F-9DF7-147CC41D329C}']
  end;

  // Windows.UI.Xaml.Input.ICommand
  // External 
  Input_ICommand = interface(IInspectable)
  ['{E5AF3542-CA67-4081-995B-709DD13792DF}']
    function add_CanExecuteChanged(value: EventHandler_1__IInspectable): EventRegistrationToken; safecall;
    procedure remove_CanExecuteChanged(token: EventRegistrationToken); safecall;
    function CanExecute(parameter: IInspectable): Boolean; safecall;
    procedure Execute(parameter: IInspectable); safecall;
  end;

  // Windows.UI.Xaml.Controls.Primitives.IOrientedVirtualizingPanelFactory
  // External 
  Controls_Primitives_IOrientedVirtualizingPanelFactory = interface(IInspectable)
  ['{7B8EAEAF-F92F-439D-9EBF-E9919F56C94D}']
  end;

  // Windows.UI.Xaml.Controls.Primitives.ISelectorFactory
  // External 
  Controls_Primitives_ISelectorFactory = interface(IInspectable)
  ['{C9BE2995-D136-4600-B187-8AD56079B48A}']
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Color>
  // External 
  IIterator_1__Color = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: Color; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PColor): Cardinal; safecall;
    property Current: Color read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Color>
  IIterable_1__Color_Base = interface(IInspectable)
  ['{932EEF5E-2C2F-5EAE-929A-74E973B57C27}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Color>
  // External 
  IIterable_1__Color = interface(IIterable_1__Color_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__Color; safecall;
  end;

  // Windows.UI.Xaml.Controls.ListViewItemToKeyHandler
  // External 
  Controls_ListViewItemToKeyHandler = interface(IUnknown)
  ['{6AF5DA76-7E8B-4A91-9A56-460CB47D523F}']
    function Invoke(item: IInspectable): HSTRING; safecall;
  end;

  // Windows.UI.Xaml.Controls.ListViewKeyToItemHandler
  // External 
  Controls_ListViewKeyToItemHandler = interface(IUnknown)
  ['{26FD5855-B530-4688-B9F0-428249178EF8}']
    function Invoke(key: HSTRING): IAsyncOperation_1__IInspectable; safecall;
  end;

  // Windows.UI.Xaml.Controls.ISectionsInViewChangedEventArgsFactory
  // External 
  Controls_ISectionsInViewChangedEventArgsFactory = interface(IInspectable)
  ['{557F5244-92F8-4150-B730-E6346E8F50D1}']
  end;

  // Windows.UI.Xaml.Controls.IIconElementFactory
  // External 
  Controls_IIconElementFactory = interface(IInspectable)
  ['{CF37A562-0424-43C7-8BEA-720FBA973EF1}']
  end;

  // Windows.UI.Xaml.Controls.IMenuFlyoutItemBaseFactory
  // External 
  Controls_IMenuFlyoutItemBaseFactory = interface(IInspectable)
  ['{83E6DBAD-FC67-41D5-8797-60ACD1CEB1D9}']
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Xaml.Controls.ContentDialogResult>
  AsyncOperationCompletedHandler_1__Controls_ContentDialogResult_Delegate_Base = interface(IUnknown)
  ['{45C7A306-E330-54D6-A9BA-61C91F93F53B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Xaml.Controls.ContentDialogResult>
  // External 
  AsyncOperationCompletedHandler_1__Controls_ContentDialogResult = interface(AsyncOperationCompletedHandler_1__Controls_ContentDialogResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Controls_ContentDialogResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.UI.Xaml.Controls.ContentDialogResult>
  IAsyncOperation_1__Controls_ContentDialogResult_Base = interface(IInspectable)
  ['{1F23BDD1-06DC-5BE9-9A60-0B4D94D4D72C}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.UI.Xaml.Controls.ContentDialogResult>
  // External 
  IAsyncOperation_1__Controls_ContentDialogResult = interface(IAsyncOperation_1__Controls_ContentDialogResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Controls_ContentDialogResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Controls_ContentDialogResult; safecall;
    function GetResults: Controls_ContentDialogResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Controls_ContentDialogResult read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.UI.Xaml.Controls.ICommandBarElement>
  // External 
  VectorChangedEventHandler_1__Controls_ICommandBarElement = interface(IUnknown)
  ['{20B884E1-C1DA-5332-B801-4F1C21744AC8}']
    procedure Invoke(sender: IObservableVector_1__Controls_ICommandBarElement; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.UI.Xaml.Controls.ICommandBarElement>
  // External 
  IObservableVector_1__Controls_ICommandBarElement = interface(IInspectable)
  ['{D5644006-717D-512D-8785-B48C17E73468}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__Controls_ICommandBarElement): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.UI.Xaml.IExceptionRoutedEventArgsFactory
  // External 
  IExceptionRoutedEventArgsFactory = interface(IInspectable)
  ['{BBA9826D-5D7A-44E7-B893-B2AE0DD24273}']
  end;

  // Windows.UI.Xaml.ISetterBaseFactory
  // External 
  ISetterBaseFactory = interface(IInspectable)
  ['{81F8AD60-1CE8-469D-A667-16E37CEF8BA9}']
  end;

  // Windows.UI.Xaml.ITriggerActionFactory
  // External 
  ITriggerActionFactory = interface(IInspectable)
  ['{68D2C0B9-3289-414F-8F6E-C6B97AEDDA03}']
  end;

  // Windows.UI.Xaml.ITriggerBaseFactory
  // External 
  ITriggerBaseFactory = interface(IInspectable)
  ['{6A3B9E57-FC5D-42D0-8CB9-CA50667AF746}']
  end;

  // Windows.UI.Xaml.IUIElementFactory
  // External 
  IUIElementFactory = interface(IInspectable)
  ['{B9EE93FE-A338-419F-AC32-91DCAADF5D08}']
  end;

  // Windows.UI.Xaml.Media.IGeometryFactory
  // External 
  Media_IGeometryFactory = interface(IInspectable)
  ['{F65DAF23-D5FD-42F9-B32A-929C5A4B54E1}']
  end;

  // Windows.UI.Xaml.Media.IImageSourceFactory
  // External 
  Media_IImageSourceFactory = interface(IInspectable)
  ['{297EC001-2540-4E5A-AB66-88035DD3DDB5}']
  end;

  // Windows.UI.Xaml.Media.IPathSegmentFactory
  // External 
  Media_IPathSegmentFactory = interface(IInspectable)
  ['{2A1C0AAE-ECCD-4464-A148-6FFDB3AA281F}']
  end;

  // Windows.UI.Xaml.Media.ITransformFactory
  // External 
  Media_ITransformFactory = interface(IInspectable)
  ['{1A955A66-7CF4-4320-B416-6181192FCC6D}']
  end;

  // Windows.UI.Xaml.Media.Animation.IEasingFunctionBaseFactory
  // External 
  Media_Animation_IEasingFunctionBaseFactory = interface(IInspectable)
  ['{1830FE6A-F01B-43E0-B61F-B452A1C66FD2}']
  end;

  // Windows.UI.Xaml.Media.Animation.ITransitionFactory
  // External 
  Media_Animation_ITransitionFactory = interface(IInspectable)
  ['{DC9AB2CF-3BC9-44AA-B3FC-883A83233A2C}']
  end;

  // Windows.Foundation.IReference`1<Windows.UI.Color>
  // External 
  IReference_1__Color = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: Color; safecall;
    property Value: Color read get_Value;
  end;

  // Windows.UI.Xaml.Automation.Provider.IIRawElementProviderSimple
  // External 
  Automation_Provider_IIRawElementProviderSimple = interface(IInspectable)
  ['{EC752224-9B77-4720-BB21-4AC89FDB1AFD}']
  end;

  // Windows.UI.Xaml.Automation.Provider.IAnnotationProvider
  // External 
  Automation_Provider_IAnnotationProvider = interface(IInspectable)
  ['{95BA1417-4437-451B-9461-050A49B59D06}']
    function get_AnnotationTypeId: Integer; safecall;
    function get_AnnotationTypeName: HSTRING; safecall;
    function get_Author: HSTRING; safecall;
    function get_DateTime: HSTRING; safecall;
    function get_Target: Automation_Provider_IIRawElementProviderSimple; safecall;
    property AnnotationTypeId: Integer read get_AnnotationTypeId;
    property AnnotationTypeName: HSTRING read get_AnnotationTypeName;
    property Author: HSTRING read get_Author;
    property DateTime: HSTRING read get_DateTime;
    property Target: Automation_Provider_IIRawElementProviderSimple read get_Target;
  end;

  // Windows.UI.Xaml.Automation.Provider.IDockProvider
  // External 
  Automation_Provider_IDockProvider = interface(IInspectable)
  ['{48C243F8-78B1-44A0-AC5F-750757BCDE3C}']
    function get_DockPosition: Automation_DockPosition; safecall;
    procedure SetDockPosition(dockPosition: Automation_DockPosition); safecall;
    property DockPosition: Automation_DockPosition read get_DockPosition;
  end;

  // Windows.UI.Xaml.Automation.Provider.IDragProvider
  // External 
  Automation_Provider_IDragProvider = interface(IInspectable)
  ['{2E7786A9-7FFC-4F57-B965-1EF1F373F546}']
    function get_IsGrabbed: Boolean; safecall;
    function get_DropEffect: HSTRING; safecall;
    function get_DropEffects(resultSize: Cardinal; resultValue: PHSTRING): HRESULT; stdcall;
    function GetGrabbedItems(resultSize: Cardinal; resultValue: PAutomation_Provider_IIRawElementProviderSimple): HRESULT; stdcall;
    property DropEffect: HSTRING read get_DropEffect;
    // property DropEffects: PHSTRING read get_DropEffects;
    property IsGrabbed: Boolean read get_IsGrabbed;
  end;

  // Windows.UI.Xaml.Automation.Provider.IGridItemProvider
  // External 
  Automation_Provider_IGridItemProvider = interface(IInspectable)
  ['{FFF3683C-7407-45BB-A936-DF3ED6D3837D}']
    function get_Column: Integer; safecall;
    function get_ColumnSpan: Integer; safecall;
    function get_ContainingGrid: Automation_Provider_IIRawElementProviderSimple; safecall;
    function get_Row: Integer; safecall;
    function get_RowSpan: Integer; safecall;
    property Column: Integer read get_Column;
    property ColumnSpan: Integer read get_ColumnSpan;
    property ContainingGrid: Automation_Provider_IIRawElementProviderSimple read get_ContainingGrid;
    property Row: Integer read get_Row;
    property RowSpan: Integer read get_RowSpan;
  end;

  // Windows.UI.Xaml.Automation.Provider.IGridProvider
  // External 
  Automation_Provider_IGridProvider = interface(IInspectable)
  ['{8B62B7A0-932C-4490-9A13-02FDB39A8F5B}']
    function get_ColumnCount: Integer; safecall;
    function get_RowCount: Integer; safecall;
    function GetItem(row: Integer; column: Integer): Automation_Provider_IIRawElementProviderSimple; safecall;
    property ColumnCount: Integer read get_ColumnCount;
    property RowCount: Integer read get_RowCount;
  end;

  // Windows.UI.Xaml.Automation.Provider.IMultipleViewProvider
  // External 
  Automation_Provider_IMultipleViewProvider = interface(IInspectable)
  ['{D014E196-0E50-4843-A5D2-C22897C8845A}']
    function get_CurrentView: Integer; safecall;
    function GetSupportedViews(resultSize: Cardinal; resultValue: PInteger): HRESULT; stdcall;
    function GetViewName(viewId: Integer): HSTRING; safecall;
    procedure SetCurrentView(viewId: Integer); safecall;
    property CurrentView: Integer read get_CurrentView;
  end;

  // Windows.UI.Xaml.Automation.Provider.IObjectModelProvider
  // External 
  Automation_Provider_IObjectModelProvider = interface(IInspectable)
  ['{C3CA36B9-0793-4ED0-BBF4-9FF4E0F98F80}']
    function GetUnderlyingObjectModel: IInspectable; safecall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ISpreadsheetItemProvider
  // External 
  Automation_Provider_ISpreadsheetItemProvider = interface(IInspectable)
  ['{EBDE8F92-6015-4826-B719-47521A81C67E}']
    function get_Formula: HSTRING; safecall;
    function GetAnnotationObjects(resultSize: Cardinal; resultValue: PAutomation_Provider_IIRawElementProviderSimple): HRESULT; stdcall;
    function GetAnnotationTypes(resultSize: Cardinal; resultValue: PAutomation_AnnotationType): HRESULT; stdcall;
    property Formula: HSTRING read get_Formula;
  end;

  // Windows.UI.Xaml.Automation.Provider.ISpreadsheetProvider
  // External 
  Automation_Provider_ISpreadsheetProvider = interface(IInspectable)
  ['{15359093-BD99-4CFD-9F07-3B14B315E23D}']
    function GetItemByName(name: HSTRING): Automation_Provider_IIRawElementProviderSimple; safecall;
  end;

  // Windows.UI.Xaml.Automation.Provider.IStylesProvider
  // External 
  Automation_Provider_IStylesProvider = interface(IInspectable)
  ['{1A5B7A17-7C01-4BEC-9CD4-2DFA7DC246CD}']
    function get_ExtendedProperties: HSTRING; safecall;
    function get_FillColor: Color; safecall;
    function get_FillPatternColor: Color; safecall;
    function get_FillPatternStyle: HSTRING; safecall;
    function get_Shape: HSTRING; safecall;
    function get_StyleId: Integer; safecall;
    function get_StyleName: HSTRING; safecall;
    property ExtendedProperties: HSTRING read get_ExtendedProperties;
    property FillColor: Color read get_FillColor;
    property FillPatternColor: Color read get_FillPatternColor;
    property FillPatternStyle: HSTRING read get_FillPatternStyle;
    property Shape: HSTRING read get_Shape;
    property StyleId: Integer read get_StyleId;
    property StyleName: HSTRING read get_StyleName;
  end;

  // Windows.UI.Xaml.Automation.Provider.ISynchronizedInputProvider
  // External 
  Automation_Provider_ISynchronizedInputProvider = interface(IInspectable)
  ['{3D60CECB-DA54-4AA3-B915-E3244427D4AC}']
    procedure Cancel; safecall;
    procedure StartListening(inputType: Automation_SynchronizedInputType); safecall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITableItemProvider
  // External 
  Automation_Provider_ITableItemProvider = interface(IInspectable)
  ['{3B2C49CD-1DE2-4EE2-A3E1-FB553559D15D}']
    function GetColumnHeaderItems(resultSize: Cardinal; resultValue: PAutomation_Provider_IIRawElementProviderSimple): HRESULT; stdcall;
    function GetRowHeaderItems(resultSize: Cardinal; resultValue: PAutomation_Provider_IIRawElementProviderSimple): HRESULT; stdcall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITableProvider
  // External 
  Automation_Provider_ITableProvider = interface(IInspectable)
  ['{7A8ED399-6824-4595-BAB3-464BC9A04417}']
    function get_RowOrColumnMajor: Automation_RowOrColumnMajor; safecall;
    function GetColumnHeaders(resultSize: Cardinal; resultValue: PAutomation_Provider_IIRawElementProviderSimple): HRESULT; stdcall;
    function GetRowHeaders(resultSize: Cardinal; resultValue: PAutomation_Provider_IIRawElementProviderSimple): HRESULT; stdcall;
    property RowOrColumnMajor: Automation_RowOrColumnMajor read get_RowOrColumnMajor;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITextRangeProvider
  // External 
  Automation_Provider_ITextRangeProvider = interface(IInspectable)
  ['{0274688D-06E9-4F66-9446-28A5BE98FBD0}']
    function Clone: Automation_Provider_ITextRangeProvider; safecall;
    function Compare(textRangeProvider: Automation_Provider_ITextRangeProvider): Boolean; safecall;
    function CompareEndpoints(endpoint: Automation_Text_TextPatternRangeEndpoint; textRangeProvider: Automation_Provider_ITextRangeProvider; targetEndpoint: Automation_Text_TextPatternRangeEndpoint): Integer; safecall;
    procedure ExpandToEnclosingUnit(&unit: Automation_Text_TextUnit); safecall;
    function FindAttribute(attributeId: Integer; value: IInspectable; backward: Boolean): Automation_Provider_ITextRangeProvider; safecall;
    function FindText(text: HSTRING; backward: Boolean; ignoreCase: Boolean): Automation_Provider_ITextRangeProvider; safecall;
    function GetAttributeValue(attributeId: Integer): IInspectable; safecall;
    procedure GetBoundingRectangles(returnValueSize: Cardinal; returnValue: PDouble); safecall;
    function GetEnclosingElement: Automation_Provider_IIRawElementProviderSimple; safecall;
    function GetText(maxLength: Integer): HSTRING; safecall;
    function Move(&unit: Automation_Text_TextUnit; count: Integer): Integer; safecall;
    function MoveEndpointByUnit(endpoint: Automation_Text_TextPatternRangeEndpoint; &unit: Automation_Text_TextUnit; count: Integer): Integer; safecall;
    procedure MoveEndpointByRange(endpoint: Automation_Text_TextPatternRangeEndpoint; textRangeProvider: Automation_Provider_ITextRangeProvider; targetEndpoint: Automation_Text_TextPatternRangeEndpoint); safecall;
    procedure Select; safecall;
    procedure AddToSelection; safecall;
    procedure RemoveFromSelection; safecall;
    procedure ScrollIntoView(alignToTop: Boolean); safecall;
    function GetChildren(resultSize: Cardinal; resultValue: PAutomation_Provider_IIRawElementProviderSimple): HRESULT; stdcall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITextChildProvider
  // External 
  Automation_Provider_ITextChildProvider = interface(IInspectable)
  ['{1133C336-A89B-4130-9BE6-55E33334F557}']
    function get_TextContainer: Automation_Provider_IIRawElementProviderSimple; safecall;
    function get_TextRange: Automation_Provider_ITextRangeProvider; safecall;
    property TextContainer: Automation_Provider_IIRawElementProviderSimple read get_TextContainer;
    property TextRange: Automation_Provider_ITextRangeProvider read get_TextRange;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITextProvider
  // External 
  Automation_Provider_ITextProvider = interface(IInspectable)
  ['{DB5BBC9F-4807-4F2A-8678-1B13F3C60E22}']
    function get_DocumentRange: Automation_Provider_ITextRangeProvider; safecall;
    function get_SupportedTextSelection: Automation_SupportedTextSelection; safecall;
    function GetSelection(resultSize: Cardinal; resultValue: PAutomation_Provider_ITextRangeProvider): HRESULT; stdcall;
    function GetVisibleRanges(resultSize: Cardinal; resultValue: PAutomation_Provider_ITextRangeProvider): HRESULT; stdcall;
    function RangeFromChild(childElement: Automation_Provider_IIRawElementProviderSimple): Automation_Provider_ITextRangeProvider; safecall;
    function RangeFromPoint(screenLocation: TPointF): Automation_Provider_ITextRangeProvider; safecall;
    property DocumentRange: Automation_Provider_ITextRangeProvider read get_DocumentRange;
    property SupportedTextSelection: Automation_SupportedTextSelection read get_SupportedTextSelection;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITextProvider2
  // External 
  Automation_Provider_ITextProvider2 = interface(IInspectable)
  ['{DF1D48BC-0487-4E7F-9D5E-F09E77E41246}']
    function RangeFromAnnotation(annotationElement: Automation_Provider_IIRawElementProviderSimple): Automation_Provider_ITextRangeProvider; safecall;
    function GetCaretRange(out isActive: Boolean): Automation_Provider_ITextRangeProvider; safecall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITextRangeProvider2
  // External 
  Automation_Provider_ITextRangeProvider2 = interface(IInspectable)
  ['{D3BE3DFB-9F54-4642-A7A5-5C18D5EE2A3F}']
    procedure ShowContextMenu; safecall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITransformProvider
  // External 
  Automation_Provider_ITransformProvider = interface(IInspectable)
  ['{79670FDD-F6A9-4A65-AF17-861DB799A2DA}']
    function get_CanMove: Boolean; safecall;
    function get_CanResize: Boolean; safecall;
    function get_CanRotate: Boolean; safecall;
    procedure Move(x: Double; y: Double); safecall;
    procedure Resize(width: Double; height: Double); safecall;
    procedure Rotate(degrees: Double); safecall;
    property CanMove: Boolean read get_CanMove;
    property CanResize: Boolean read get_CanResize;
    property CanRotate: Boolean read get_CanRotate;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITransformProvider2
  // External 
  Automation_Provider_ITransformProvider2 = interface(IInspectable)
  ['{A8B11756-A39F-4E97-8C7D-C1EA8DD633C5}']
    function get_CanZoom: Boolean; safecall;
    function get_ZoomLevel: Double; safecall;
    function get_MaxZoom: Double; safecall;
    function get_MinZoom: Double; safecall;
    procedure Zoom(zoom: Double); safecall;
    procedure ZoomByUnit(zoomUnit: Automation_ZoomUnit); safecall;
    property CanZoom: Boolean read get_CanZoom;
    property MaxZoom: Double read get_MaxZoom;
    property MinZoom: Double read get_MinZoom;
    property ZoomLevel: Double read get_ZoomLevel;
  end;

  // Windows.UI.Xaml.Automation.Provider.IWindowProvider
  // External 
  Automation_Provider_IWindowProvider = interface(IInspectable)
  ['{1BAA8B3D-38CF-415A-85D3-20E43A0EC1B1}']
    function get_IsModal: Boolean; safecall;
    function get_IsTopmost: Boolean; safecall;
    function get_Maximizable: Boolean; safecall;
    function get_Minimizable: Boolean; safecall;
    function get_InteractionState: Automation_WindowInteractionState; safecall;
    function get_VisualState: Automation_WindowVisualState; safecall;
    procedure Close; safecall;
    procedure SetVisualState(state: Automation_WindowVisualState); safecall;
    function WaitForInputIdle(milliseconds: Integer): Boolean; safecall;
    property InteractionState: Automation_WindowInteractionState read get_InteractionState;
    property IsModal: Boolean read get_IsModal;
    property IsTopmost: Boolean read get_IsTopmost;
    property Maximizable: Boolean read get_Maximizable;
    property Minimizable: Boolean read get_Minimizable;
    property VisualState: Automation_WindowVisualState read get_VisualState;
  end;

  // Windows.UI.Xaml.Data.ICollectionViewGroup
  // External 
  Data_ICollectionViewGroup = interface(IInspectable)
  ['{7E01B9D8-D7B5-48B6-B31C-5BB5BDF5F09B}']
    function get_Group: IInspectable; safecall;
    function get_GroupItems: IObservableVector_1__IInspectable; safecall;
    property Group: IInspectable read get_Group;
    property GroupItems: IObservableVector_1__IInspectable read get_GroupItems;
  end;

  // Windows.UI.Xaml.Data.ICustomProperty
  // External 
  Data_ICustomProperty = interface(IInspectable)
  ['{30DA92C0-23E8-42A0-AE7C-734A0E5D2782}']
    function get_Type: Interop_TypeName; safecall;
    function get_Name: HSTRING; safecall;
    function GetValue(target: IInspectable): IInspectable; safecall;
    procedure SetValue(target: IInspectable; value: IInspectable); safecall;
    function GetIndexedValue(target: IInspectable; index: IInspectable): IInspectable; safecall;
    procedure SetIndexedValue(target: IInspectable; value: IInspectable; index: IInspectable); safecall;
    function get_CanWrite: Boolean; safecall;
    function get_CanRead: Boolean; safecall;
    property CanRead: Boolean read get_CanRead;
    property CanWrite: Boolean read get_CanWrite;
    property Name: HSTRING read get_Name;
    property &Type: Interop_TypeName read get_Type;
  end;

  // Windows.UI.Xaml.Data.ISupportIncrementalLoading
  // External 
  Data_ISupportIncrementalLoading = interface(IInspectable)
  ['{7F5EE992-7694-4E6C-A51B-E34BF43DE743}']
    function LoadMoreItemsAsync(count: Cardinal): IAsyncOperation_1__Data_LoadMoreItemsResult; safecall;
    function get_HasMoreItems: Boolean; safecall;
    property HasMoreItems: Boolean read get_HasMoreItems;
  end;

  // Windows.UI.Xaml.Data.IBindingExpressionBaseFactory
  // External 
  Data_IBindingExpressionBaseFactory = interface(IInspectable)
  ['{EA7116A7-C2D9-4375-B471-66B9C48C7930}']
  end;

  // Windows.UI.Xaml.Data.IBindingExpressionFactory
  // External 
  Data_IBindingExpressionFactory = interface(IInspectable)
  ['{1CB55CD9-DB72-40B3-A2B5-24EE6EA5C328}']
  end;

  // Windows.UI.Xaml.Markup.IComponentConnector
  // External 
  Markup_IComponentConnector = interface(IInspectable)
  ['{F6790987-E6E5-47F2-92C6-ECCCE4BA159A}']
    procedure Connect(connectionId: Integer; target: IInspectable); safecall;
  end;

  // Windows.UI.Xaml.Markup.IComponentConnector2
  // External 
  Markup_IComponentConnector2 = interface(IInspectable)
  ['{DC8F368B-ECCC-498E-B139-91142254D7AE}']
    function GetBindingConnector(connectionId: Integer; target: IInspectable): Markup_IComponentConnector; safecall;
  end;

  // Windows.UI.Xaml.Markup.IXamlType
  // External 
  Markup_IXamlType = interface(IInspectable)
  ['{7920EAB1-A2E5-479A-BD50-6CEF3C0B4970}']
    function get_BaseType: Markup_IXamlType; safecall;
    function get_ContentProperty: Markup_IXamlMember; safecall;
    function get_FullName: HSTRING; safecall;
    function get_IsArray: Boolean; safecall;
    function get_IsCollection: Boolean; safecall;
    function get_IsConstructible: Boolean; safecall;
    function get_IsDictionary: Boolean; safecall;
    function get_IsMarkupExtension: Boolean; safecall;
    function get_IsBindable: Boolean; safecall;
    function get_ItemType: Markup_IXamlType; safecall;
    function get_KeyType: Markup_IXamlType; safecall;
    function get_UnderlyingType: Interop_TypeName; safecall;
    function ActivateInstance: IInspectable; safecall;
    function CreateFromString(value: HSTRING): IInspectable; safecall;
    function GetMember(name: HSTRING): Markup_IXamlMember; safecall;
    procedure AddToVector(instance: IInspectable; value: IInspectable); safecall;
    procedure AddToMap(instance: IInspectable; key: IInspectable; value: IInspectable); safecall;
    procedure RunInitializer; safecall;
    property BaseType: Markup_IXamlType read get_BaseType;
    property ContentProperty: Markup_IXamlMember read get_ContentProperty;
    property FullName: HSTRING read get_FullName;
    property IsArray: Boolean read get_IsArray;
    property IsBindable: Boolean read get_IsBindable;
    property IsCollection: Boolean read get_IsCollection;
    property IsConstructible: Boolean read get_IsConstructible;
    property IsDictionary: Boolean read get_IsDictionary;
    property IsMarkupExtension: Boolean read get_IsMarkupExtension;
    property ItemType: Markup_IXamlType read get_ItemType;
    property KeyType: Markup_IXamlType read get_KeyType;
    property UnderlyingType: Interop_TypeName read get_UnderlyingType;
  end;

  // Windows.UI.Xaml.Markup.IXamlMember
  // External 
  Markup_IXamlMember = interface(IInspectable)
  ['{C541F58C-43A9-4216-B718-E0B11B14E93E}']
    function get_IsAttachable: Boolean; safecall;
    function get_IsDependencyProperty: Boolean; safecall;
    function get_IsReadOnly: Boolean; safecall;
    function get_Name: HSTRING; safecall;
    function get_TargetType: Markup_IXamlType; safecall;
    function get_Type: Markup_IXamlType; safecall;
    function GetValue(instance: IInspectable): IInspectable; safecall;
    procedure SetValue(instance: IInspectable; value: IInspectable); safecall;
    property IsAttachable: Boolean read get_IsAttachable;
    property IsDependencyProperty: Boolean read get_IsDependencyProperty;
    property IsReadOnly: Boolean read get_IsReadOnly;
    property Name: HSTRING read get_Name;
    property TargetType: Markup_IXamlType read get_TargetType;
    property &Type: Markup_IXamlType read get_Type;
  end;

  // Windows.UI.Xaml.Markup.IXamlMetadataProvider
  // External 
  Markup_IXamlMetadataProvider = interface(IInspectable)
  ['{B3765D69-68A5-4B32-8861-FDB90C1F5836}']
    function GetXamlType(&type: Interop_TypeName): Markup_IXamlType; overload; safecall;
    function GetXamlType(fullName: HSTRING): Markup_IXamlType; overload; safecall;
    function GetXmlnsDefinitions(resultSize: Cardinal; resultValue: PMarkup_XmlnsDefinition): HRESULT; stdcall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ICustomNavigationProvider
  // External 
  Automation_Provider_ICustomNavigationProvider = interface(IInspectable)
  ['{2BD8A6D0-2FA3-4717-B28C-4917CE54928D}']
    function NavigateCustom(direction: Automation_Peers_AutomationNavigationDirection): IInspectable; safecall;
  end;

  // Windows.UI.Xaml.Automation.Provider.ITextEditProvider
  // External 
  Automation_Provider_ITextEditProvider = interface(IInspectable)
  ['{EA3605B4-3A05-400E-B5F9-4E91B40F6176}']
    function GetActiveComposition: Automation_Provider_ITextRangeProvider; safecall;
    function GetConversionTarget: Automation_Provider_ITextRangeProvider; safecall;
  end;

  // Windows.UI.Xaml.Markup.IDataTemplateComponent
  // External 
  Markup_IDataTemplateComponent = interface(IInspectable)
  ['{08429DC8-8AB0-4747-AA9A-FEADFC8DA8E1}']
    procedure Recycle; safecall;
    procedure ProcessBindings(item: IInspectable; itemIndex: Integer; phase: Integer; out nextPhase: Integer); safecall;
  end;

  // Windows.Foundation.IReference`1<Windows.UI.Xaml.Thickness>
  // External 
  IReference_1__Thickness = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: Thickness; safecall;
    property Value: Thickness read get_Value;
  end;

  // Windows.UI.Xaml.Hosting.IXamlUIPresenterHost
  // External 
  Hosting_IXamlUIPresenterHost = interface(IInspectable)
  ['{AAFB84CD-9F6D-4F80-AC2C-0E6CB9F31659}']
    function ResolveFileResource(path: HSTRING): HSTRING; safecall;
  end;

  // Windows.UI.Xaml.Hosting.IXamlUIPresenterHost2
  // External 
  Hosting_IXamlUIPresenterHost2 = interface(IInspectable)
  ['{61595672-7CA4-4A21-B56A-88F4812388CA}']
    function GetGenericXamlFilePath: HSTRING; safecall;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
