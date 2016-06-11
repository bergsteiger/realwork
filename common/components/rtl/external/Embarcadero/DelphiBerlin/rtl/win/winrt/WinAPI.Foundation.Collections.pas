{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Foundation.Collections;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Foundation.Collections Class Names
  // Windows.Foundation.Collections.PropertySet
  // DualAPI
  SPropertySet = 'Windows.Foundation.Collections.PropertySet';
  // Windows.Foundation.Collections.ValueSet
  // DualAPI
  SValueSet = 'Windows.Foundation.Collections.ValueSet';
  // Windows.Foundation.Collections.StringMap
  // DualAPI
  SStringMap = 'Windows.Foundation.Collections.StringMap';


type
  // Forward declare interfaces
  // Windows.Foundation.Collections.IVectorChangedEventArgs
  IVectorChangedEventArgs = interface;
  PIVectorChangedEventArgs = ^IVectorChangedEventArgs;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Object>
  IKeyValuePair_2__HSTRING__IInspectable = interface;
  PIKeyValuePair_2__HSTRING__IInspectable = ^IKeyValuePair_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Object>>
  IIterator_1__IKeyValuePair_2__HSTRING__IInspectable = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__IInspectable = ^IIterator_1__IKeyValuePair_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Object>>
  IIterable_1__IKeyValuePair_2__HSTRING__IInspectable = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__IInspectable = ^IIterable_1__IKeyValuePair_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IMapView`2<String,Object>
  IMapView_2__HSTRING__IInspectable = interface;
  PIMapView_2__HSTRING__IInspectable = ^IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IMap`2<String,Object>
  IMap_2__HSTRING__IInspectable = interface;
  PIMap_2__HSTRING__IInspectable = ^IMap_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IMapChangedEventArgs`1<String>
  IMapChangedEventArgs_1__HSTRING = interface;
  PIMapChangedEventArgs_1__HSTRING = ^IMapChangedEventArgs_1__HSTRING;

  // Windows.Foundation.Collections.MapChangedEventHandler`2<String,Object>
  MapChangedEventHandler_2__HSTRING__IInspectable = interface;
  PMapChangedEventHandler_2__HSTRING__IInspectable = ^MapChangedEventHandler_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IObservableMap`2<String,Object>
  IObservableMap_2__HSTRING__IInspectable = interface;
  PIObservableMap_2__HSTRING__IInspectable = ^IObservableMap_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IPropertySet
  IPropertySet = interface;
  PIPropertySet = ^IPropertySet;

  // Windows.Foundation.Collections.IIterator`1<String>
  IIterator_1__HSTRING = interface;
  PIIterator_1__HSTRING = ^IIterator_1__HSTRING;

  // Windows.Foundation.Collections.IIterable`1<String>
  IIterable_1__HSTRING = interface;
  PIIterable_1__HSTRING = ^IIterable_1__HSTRING;

  // Windows.Foundation.Collections.IVectorView`1<String>
  IVectorView_1__HSTRING = interface;
  PIVectorView_1__HSTRING = ^IVectorView_1__HSTRING;

  // Windows.Foundation.Collections.IVector`1<String>
  IVector_1__HSTRING = interface;
  PIVector_1__HSTRING = ^IVector_1__HSTRING;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<String>>
  AsyncOperationCompletedHandler_1__IVectorView_1__HSTRING = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__HSTRING = ^AsyncOperationCompletedHandler_1__IVectorView_1__HSTRING;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<String>>
  IAsyncOperation_1__IVectorView_1__HSTRING = interface;
  PIAsyncOperation_1__IVectorView_1__HSTRING = ^IAsyncOperation_1__IVectorView_1__HSTRING;

  // Windows.Foundation.Collections.IKeyValuePair`2<Guid,Object>
  IKeyValuePair_2__TGuid__IInspectable = interface;
  PIKeyValuePair_2__TGuid__IInspectable = ^IKeyValuePair_2__TGuid__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<Guid,Object>>
  IIterator_1__IKeyValuePair_2__TGuid__IInspectable = interface;
  PIIterator_1__IKeyValuePair_2__TGuid__IInspectable = ^IIterator_1__IKeyValuePair_2__TGuid__IInspectable;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<Guid,Object>>
  IIterable_1__IKeyValuePair_2__TGuid__IInspectable = interface;
  PIIterable_1__IKeyValuePair_2__TGuid__IInspectable = ^IIterable_1__IKeyValuePair_2__TGuid__IInspectable;

  // Windows.Foundation.Collections.IMapView`2<Guid,Object>
  IMapView_2__TGuid__IInspectable = interface;
  PIMapView_2__TGuid__IInspectable = ^IMapView_2__TGuid__IInspectable;

  // Windows.Foundation.Collections.IMap`2<Guid,Object>
  IMap_2__TGuid__IInspectable = interface;
  PIMap_2__TGuid__IInspectable = ^IMap_2__TGuid__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Int32>
  IIterator_1__Integer = interface;
  PIIterator_1__Integer = ^IIterator_1__Integer;

  // Windows.Foundation.Collections.IIterable`1<Int32>
  IIterable_1__Integer = interface;
  PIIterable_1__Integer = ^IIterable_1__Integer;

  // Windows.Foundation.Collections.IVectorView`1<Int32>
  IVectorView_1__Integer = interface;
  PIVectorView_1__Integer = ^IVectorView_1__Integer;

  // Windows.Foundation.Collections.IVector`1<Int32>
  IVector_1__Integer = interface;
  PIVector_1__Integer = ^IVector_1__Integer;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,String>
  IKeyValuePair_2__HSTRING__HSTRING = interface;
  PIKeyValuePair_2__HSTRING__HSTRING = ^IKeyValuePair_2__HSTRING__HSTRING;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,String>>
  IIterator_1__IKeyValuePair_2__HSTRING__HSTRING = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__HSTRING = ^IIterator_1__IKeyValuePair_2__HSTRING__HSTRING;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,String>>
  IIterable_1__IKeyValuePair_2__HSTRING__HSTRING = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__HSTRING = ^IIterable_1__IKeyValuePair_2__HSTRING__HSTRING;

  // Windows.Foundation.Collections.IMapView`2<String,String>
  IMapView_2__HSTRING__HSTRING = interface;
  PIMapView_2__HSTRING__HSTRING = ^IMapView_2__HSTRING__HSTRING;

  // Windows.Foundation.Collections.IMap`2<String,String>
  IMap_2__HSTRING__HSTRING = interface;
  PIMap_2__HSTRING__HSTRING = ^IMap_2__HSTRING__HSTRING;

  // Windows.Foundation.Collections.MapChangedEventHandler`2<String,String>
  MapChangedEventHandler_2__HSTRING__HSTRING = interface;
  PMapChangedEventHandler_2__HSTRING__HSTRING = ^MapChangedEventHandler_2__HSTRING__HSTRING;

  // Windows.Foundation.Collections.IObservableMap`2<String,String>
  IObservableMap_2__HSTRING__HSTRING = interface;
  PIObservableMap_2__HSTRING__HSTRING = ^IObservableMap_2__HSTRING__HSTRING;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVectorView`1<String>>
  IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = interface;
  PIKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = ^IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVectorView`1<String>>>
  IIterator_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = ^IIterator_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVectorView`1<String>>>
  IIterable_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = ^IIterable_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Foundation.Collections.IVectorView`1<String>>
  IMapView_2__HSTRING__IVectorView_1__HSTRING = interface;
  PIMapView_2__HSTRING__IVectorView_1__HSTRING = ^IMapView_2__HSTRING__IVectorView_1__HSTRING;

  // Windows.Foundation.Collections.IIterator`1<Guid>
  IIterator_1__TGuid = interface;
  PIIterator_1__TGuid = ^IIterator_1__TGuid;

  // Windows.Foundation.Collections.IIterable`1<Guid>
  IIterable_1__TGuid = interface;
  PIIterable_1__TGuid = ^IIterable_1__TGuid;

  // Windows.Foundation.Collections.IVectorView`1<Guid>
  IVectorView_1__TGuid = interface;
  PIVectorView_1__TGuid = ^IVectorView_1__TGuid;

  // Windows.Foundation.Collections.IVector`1<Guid>
  IVector_1__TGuid = interface;
  PIVector_1__TGuid = ^IVector_1__TGuid;

  // Windows.Foundation.Collections.IIterator`1<UInt32>
  IIterator_1__Cardinal = interface;
  PIIterator_1__Cardinal = ^IIterator_1__Cardinal;

  // Windows.Foundation.Collections.IIterable`1<UInt32>
  IIterable_1__Cardinal = interface;
  PIIterable_1__Cardinal = ^IIterable_1__Cardinal;

  // Windows.Foundation.Collections.IVectorView`1<UInt32>
  IVectorView_1__Cardinal = interface;
  PIVectorView_1__Cardinal = ^IVectorView_1__Cardinal;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<UInt32>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Cardinal = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__Cardinal = ^AsyncOperationCompletedHandler_1__IVectorView_1__Cardinal;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<UInt32>>
  IAsyncOperation_1__IVectorView_1__Cardinal = interface;
  PIAsyncOperation_1__IVectorView_1__Cardinal = ^IAsyncOperation_1__IVectorView_1__Cardinal;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IPropertySet>
  AsyncOperationCompletedHandler_1__IPropertySet = interface;
  PAsyncOperationCompletedHandler_1__IPropertySet = ^AsyncOperationCompletedHandler_1__IPropertySet;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IPropertySet>
  IAsyncOperation_1__IPropertySet = interface;
  PIAsyncOperation_1__IPropertySet = ^IAsyncOperation_1__IPropertySet;

  // Windows.Foundation.Collections.IIterator`1<Object>
  IIterator_1__IInspectable = interface;
  PIIterator_1__IInspectable = ^IIterator_1__IInspectable;

  // Windows.Foundation.Collections.IIterable`1<Object>
  IIterable_1__IInspectable = interface;
  PIIterable_1__IInspectable = ^IIterable_1__IInspectable;

  // Windows.Foundation.Collections.IVectorView`1<Object>
  IVectorView_1__IInspectable = interface;
  PIVectorView_1__IInspectable = ^IVectorView_1__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Double>
  IIterator_1__Double = interface;
  PIIterator_1__Double = ^IIterator_1__Double;

  // Windows.Foundation.Collections.IIterable`1<Double>
  IIterable_1__Double = interface;
  PIIterable_1__Double = ^IIterable_1__Double;

  // Windows.Foundation.Collections.IVectorView`1<Double>
  IVectorView_1__Double = interface;
  PIVectorView_1__Double = ^IVectorView_1__Double;

  // Windows.Foundation.Collections.IVector`1<Double>
  IVector_1__Double = interface;
  PIVector_1__Double = ^IVector_1__Double;

  // Windows.Foundation.Collections.IVector`1<UInt32>
  IVector_1__Cardinal = interface;
  PIVector_1__Cardinal = ^IVector_1__Cardinal;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMap`2<String,Object>>
  AsyncOperationCompletedHandler_1__IMap_2__HSTRING__IInspectable = interface;
  PAsyncOperationCompletedHandler_1__IMap_2__HSTRING__IInspectable = ^AsyncOperationCompletedHandler_1__IMap_2__HSTRING__IInspectable;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMap`2<String,Object>>
  IAsyncOperation_1__IMap_2__HSTRING__IInspectable = interface;
  PIAsyncOperation_1__IMap_2__HSTRING__IInspectable = ^IAsyncOperation_1__IMap_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<UInt8>
  IIterator_1__Byte = interface;
  PIIterator_1__Byte = ^IIterator_1__Byte;

  // Windows.Foundation.Collections.IIterable`1<UInt8>
  IIterable_1__Byte = interface;
  PIIterable_1__Byte = ^IIterable_1__Byte;

  // Windows.Foundation.Collections.IVectorView`1<UInt8>
  IVectorView_1__Byte = interface;
  PIVectorView_1__Byte = ^IVectorView_1__Byte;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IInspectable = interface;
  PAsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IInspectable = ^AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IAsyncOperation_1__IMapView_2__HSTRING__IInspectable = interface;
  PIAsyncOperation_1__IMapView_2__HSTRING__IInspectable = ^IAsyncOperation_1__IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IIterator_1__IMapView_2__HSTRING__IInspectable = interface;
  PIIterator_1__IMapView_2__HSTRING__IInspectable = ^IIterator_1__IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IIterable_1__IMapView_2__HSTRING__IInspectable = interface;
  PIIterable_1__IMapView_2__HSTRING__IInspectable = ^IIterable_1__IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IVectorView_1__IMapView_2__HSTRING__IInspectable = interface;
  PIVectorView_1__IMapView_2__HSTRING__IInspectable = ^IVectorView_1__IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Foundation.Collections.IMapView`2<String,Object>>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IMapView_2__HSTRING__IInspectable = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IMapView_2__HSTRING__IInspectable = ^AsyncOperationCompletedHandler_1__IVectorView_1__IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Foundation.Collections.IMapView`2<String,Object>>>
  IAsyncOperation_1__IVectorView_1__IMapView_2__HSTRING__IInspectable = interface;
  PIAsyncOperation_1__IVectorView_1__IMapView_2__HSTRING__IInspectable = ^IAsyncOperation_1__IVectorView_1__IMapView_2__HSTRING__IInspectable;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVector`1<String>>
  AsyncOperationCompletedHandler_1__IVector_1__HSTRING = interface;
  PAsyncOperationCompletedHandler_1__IVector_1__HSTRING = ^AsyncOperationCompletedHandler_1__IVector_1__HSTRING;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVector`1<String>>
  IAsyncOperation_1__IVector_1__HSTRING = interface;
  PIAsyncOperation_1__IVector_1__HSTRING = ^IAsyncOperation_1__IVector_1__HSTRING;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVector`1<String>>
  IKeyValuePair_2__HSTRING__IVector_1__HSTRING = interface;
  PIKeyValuePair_2__HSTRING__IVector_1__HSTRING = ^IKeyValuePair_2__HSTRING__IVector_1__HSTRING;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVector`1<String>>>
  IIterator_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING = ^IIterator_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVector`1<String>>>
  IIterable_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING = ^IIterable_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Foundation.Collections.IVector`1<String>>
  IMapView_2__HSTRING__IVector_1__HSTRING = interface;
  PIMapView_2__HSTRING__IVector_1__HSTRING = ^IMapView_2__HSTRING__IVector_1__HSTRING;

  // Windows.Foundation.Collections.IMap`2<String,Windows.Foundation.Collections.IVector`1<String>>
  IMap_2__HSTRING__IVector_1__HSTRING = interface;
  PIMap_2__HSTRING__IVector_1__HSTRING = ^IMap_2__HSTRING__IVector_1__HSTRING;

  // Windows.Foundation.Collections.IVector`1<Object>
  IVector_1__IInspectable = interface;
  PIVector_1__IInspectable = ^IVector_1__IInspectable;

  // Windows.Foundation.Collections.IKeyValuePair`2<Object,Object>
  IKeyValuePair_2__IInspectable__IInspectable = interface;
  PIKeyValuePair_2__IInspectable__IInspectable = ^IKeyValuePair_2__IInspectable__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<Object,Object>>
  IIterator_1__IKeyValuePair_2__IInspectable__IInspectable = interface;
  PIIterator_1__IKeyValuePair_2__IInspectable__IInspectable = ^IIterator_1__IKeyValuePair_2__IInspectable__IInspectable;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<Object,Object>>
  IIterable_1__IKeyValuePair_2__IInspectable__IInspectable = interface;
  PIIterable_1__IKeyValuePair_2__IInspectable__IInspectable = ^IIterable_1__IKeyValuePair_2__IInspectable__IInspectable;

  // Windows.Foundation.Collections.IMapView`2<Object,Object>
  IMapView_2__IInspectable__IInspectable = interface;
  PIMapView_2__IInspectable__IInspectable = ^IMapView_2__IInspectable__IInspectable;

  // Windows.Foundation.Collections.IMap`2<Object,Object>
  IMap_2__IInspectable__IInspectable = interface;
  PIMap_2__IInspectable__IInspectable = ^IMap_2__IInspectable__IInspectable;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Object>
  VectorChangedEventHandler_1__IInspectable = interface;
  PVectorChangedEventHandler_1__IInspectable = ^VectorChangedEventHandler_1__IInspectable;

  // Windows.Foundation.Collections.IObservableVector`1<Object>
  IObservableVector_1__IInspectable = interface;
  PIObservableVector_1__IInspectable = ^IObservableVector_1__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Single>
  IIterator_1__Single = interface;
  PIIterator_1__Single = ^IIterator_1__Single;

  // Windows.Foundation.Collections.IIterable`1<Single>
  IIterable_1__Single = interface;
  PIIterable_1__Single = ^IIterable_1__Single;

  // Windows.Foundation.Collections.IVectorView`1<Single>
  IVectorView_1__Single = interface;
  PIVectorView_1__Single = ^IVectorView_1__Single;

  // Windows.Foundation.Collections.IVector`1<Single>
  IVector_1__Single = interface;
  PIVector_1__Single = ^IVector_1__Single;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Object>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IInspectable = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IInspectable = ^AsyncOperationCompletedHandler_1__IVectorView_1__IInspectable;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Object>>
  IAsyncOperation_1__IVectorView_1__IInspectable = interface;
  PIAsyncOperation_1__IVectorView_1__IInspectable = ^IAsyncOperation_1__IVectorView_1__IInspectable;


  // Emit Forwarded interfaces
  // Windows.Foundation.Collections Interfaces
  // Windows.Foundation.Collections.IVectorChangedEventArgs
  IVectorChangedEventArgs = interface(IInspectable)
  ['{575933DF-34FE-4480-AF15-07691F3D5D9B}']
    function get_CollectionChange: CollectionChange; safecall;
    function get_Index: Cardinal; safecall;
    property CollectionChange: CollectionChange read get_CollectionChange;
    property Index: Cardinal read get_Index;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Object>
  IKeyValuePair_2__HSTRING__IInspectable = interface(IInspectable)
  ['{09335560-6C6B-5A26-9348-97B781132B20}']
    function get_Key: HSTRING; safecall;
    function get_Value: IInspectable; safecall;
    property Key: HSTRING read get_Key;
    property Value: IInspectable read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Object>>
  IIterator_1__IKeyValuePair_2__HSTRING__IInspectable = interface(IInspectable)
  ['{5DB5FA32-707C-5849-A06B-91C8EB9D10E8}']
    function get_Current: IKeyValuePair_2__HSTRING__IInspectable; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__IInspectable): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__IInspectable read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Object>>
  IIterable_1__IKeyValuePair_2__HSTRING__IInspectable = interface(IInspectable)
  ['{FE2F3D47-5D47-5499-8374-430C7CDA0204}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__IInspectable; safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IMapView`2<String,Object>
  IMapView_2__HSTRING__IInspectable = interface(IInspectable)
  ['{BB78502A-F79D-54FA-92C9-90C5039FDF7E}']
    function Lookup(key: HSTRING): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__IInspectable; out second: IMapView_2__HSTRING__IInspectable); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IMap`2<String,Object>
  IMap_2__HSTRING__IInspectable = interface(IInspectable)
  ['{1B0D3570-0877-5EC2-8A2C-3B9539506ACA}']
    function Lookup(key: HSTRING): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    function GetView: IMapView_2__HSTRING__IInspectable; safecall;
    function Insert(key: HSTRING; value: IInspectable): Boolean; safecall;
    procedure Remove(key: HSTRING); safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IMapChangedEventArgs`1<String>
  IMapChangedEventArgs_1__HSTRING = interface(IInspectable)
  ['{60141EFB-F2F9-5377-96FD-F8C60D9558B5}']
    function get_CollectionChange: CollectionChange; safecall;
    function get_Key: HSTRING; safecall;
    property CollectionChange: CollectionChange read get_CollectionChange;
    property Key: HSTRING read get_Key;
  end;

  // Windows.Foundation.Collections.MapChangedEventHandler`2<String,Object>
  MapChangedEventHandler_2__HSTRING__IInspectable = interface(IUnknown)
  ['{24F981E5-DDCA-538D-AADA-A59906084CF1}']
    procedure Invoke(sender: IObservableMap_2__HSTRING__IInspectable; event: IMapChangedEventArgs_1__HSTRING); safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IObservableMap`2<String,Object>
  IObservableMap_2__HSTRING__IInspectable = interface(IInspectable)
  ['{236AAC9D-FB12-5C4D-A41C-9E445FB4D7EC}']
    function add_MapChanged(vhnd: MapChangedEventHandler_2__HSTRING__IInspectable): EventRegistrationToken; safecall;
    procedure remove_MapChanged(token: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IPropertySet
  [WinRTClassNameAttribute(SValueSet)]
  IPropertySet = interface(IInspectable)
  ['{8A43ED9F-F4E6-4421-ACF9-1DAB2986820C}']
  end;

  // Windows.Foundation.Collections.IIterator`1<String>
  IIterator_1__HSTRING = interface(IInspectable)
  ['{8C304EBB-6615-50A4-8829-879ECD443236}']
    function get_Current: HSTRING; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PHSTRING): Cardinal; safecall;
    property Current: HSTRING read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<String>
  IIterable_1__HSTRING = interface(IInspectable)
  ['{E2FCC7C1-3BFC-5A0B-B2B0-72E769D1CB7E}']
    function First: IIterator_1__HSTRING; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<String>
  IVectorView_1__HSTRING = interface(IInspectable)
  ['{2F13C006-A03A-5F69-B090-75A43E33423E}']
    function GetAt(index: Cardinal): HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: HSTRING; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PHSTRING): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<String>
  IVector_1__HSTRING = interface(IInspectable)
  ['{98B9ACC1-4B56-532E-AC73-03D5291CCA90}']
    function GetAt(index: Cardinal): HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__HSTRING; safecall;
    function IndexOf(value: HSTRING; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: HSTRING); safecall;
    procedure InsertAt(index: Cardinal; value: HSTRING); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: HSTRING); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PHSTRING): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PHSTRING); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<String>>
  AsyncOperationCompletedHandler_1__IVectorView_1__HSTRING = interface(IUnknown)
  ['{7C7899BE-5F2E-5BF3-ADE5-AD98B772C7CD}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__HSTRING; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<String>>
  IAsyncOperation_1__IVectorView_1__HSTRING = interface(IInspectable)
  ['{2F92B529-119B-575A-A419-3904B4E41AF2}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__HSTRING); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__HSTRING; safecall;
    function GetResults: IVectorView_1__HSTRING; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__HSTRING read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<Guid,Object>
  IKeyValuePair_2__TGuid__IInspectable = interface(IInspectable)
  ['{3BDA1540-D089-5A1A-8F0D-94EBA8068E58}']
    function get_Key: TGuid; safecall;
    function get_Value: IInspectable; safecall;
    property Key: TGuid read get_Key;
    property Value: IInspectable read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<Guid,Object>>
  IIterator_1__IKeyValuePair_2__TGuid__IInspectable = interface(IInspectable)
  ['{4F25059A-0B9A-5F25-9B9E-4B9F1D22FF65}']
    function get_Current: IKeyValuePair_2__TGuid__IInspectable; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__TGuid__IInspectable): Cardinal; safecall;
    property Current: IKeyValuePair_2__TGuid__IInspectable read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<Guid,Object>>
  IIterable_1__IKeyValuePair_2__TGuid__IInspectable = interface(IInspectable)
  ['{F3B20528-E3B3-5331-B2D0-0C2623AEE785}']
    function First: IIterator_1__IKeyValuePair_2__TGuid__IInspectable; safecall;
  end;

  // Windows.Foundation.Collections.IMapView`2<Guid,Object>
  IMapView_2__TGuid__IInspectable = interface(IInspectable)
  ['{E4D2C732-BBC1-5EF4-869F-5007CEB55F6E}']
    function Lookup(key: TGuid): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: TGuid): Boolean; safecall;
    procedure Split(out first: IMapView_2__TGuid__IInspectable; out second: IMapView_2__TGuid__IInspectable); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IMap`2<Guid,Object>
  IMap_2__TGuid__IInspectable = interface(IInspectable)
  ['{5EE3189C-7DBF-5998-AD07-5414FB82567C}']
    function Lookup(key: TGuid): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: TGuid): Boolean; safecall;
    function GetView: IMapView_2__TGuid__IInspectable; safecall;
    function Insert(key: TGuid; value: IInspectable): Boolean; safecall;
    procedure Remove(key: TGuid); safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Int32>
  IIterator_1__Integer = interface(IInspectable)
  ['{BFEA7F78-50C2-5F1D-A6EA-9E978D2699FF}']
    function get_Current: Integer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PInteger): Cardinal; safecall;
    property Current: Integer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Int32>
  IIterable_1__Integer = interface(IInspectable)
  ['{81A643FB-F51C-5565-83C4-F96425777B66}']
    function First: IIterator_1__Integer; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Int32>
  IVectorView_1__Integer = interface(IInspectable)
  ['{8D720CDF-3934-5D3F-9A55-40E8063B086A}']
    function GetAt(index: Cardinal): Integer; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Integer; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PInteger): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Int32>
  IVector_1__Integer = interface(IInspectable)
  ['{B939AF5B-B45D-5489-9149-61442C1905FE}']
    function GetAt(index: Cardinal): Integer; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Integer; safecall;
    function IndexOf(value: Integer; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Integer); safecall;
    procedure InsertAt(index: Cardinal; value: Integer); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Integer); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PInteger): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PInteger); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,String>
  IKeyValuePair_2__HSTRING__HSTRING = interface(IInspectable)
  ['{60310303-49C5-52E6-ABC6-A9B36ECCC716}']
    function get_Key: HSTRING; safecall;
    function get_Value: HSTRING; safecall;
    property Key: HSTRING read get_Key;
    property Value: HSTRING read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,String>>
  IIterator_1__IKeyValuePair_2__HSTRING__HSTRING = interface(IInspectable)
  ['{05EB86F1-7140-5517-B88D-CBAEBE57E6B1}']
    function get_Current: IKeyValuePair_2__HSTRING__HSTRING; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__HSTRING): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__HSTRING read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,String>>
  IIterable_1__IKeyValuePair_2__HSTRING__HSTRING = interface(IInspectable)
  ['{E9BDAAF0-CBF6-5C72-BE90-29CBF3A1319B}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__HSTRING; safecall;
  end;

  // Windows.Foundation.Collections.IMapView`2<String,String>
  IMapView_2__HSTRING__HSTRING = interface(IInspectable)
  ['{AC7F26F2-FEB7-5B2A-8AC4-345BC62CAEDE}']
    function Lookup(key: HSTRING): HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__HSTRING; out second: IMapView_2__HSTRING__HSTRING); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IMap`2<String,String>
  [WinRTClassNameAttribute(SStringMap)]
  IMap_2__HSTRING__HSTRING = interface(IInspectable)
  ['{F6D1F700-49C2-52AE-8154-826F9908773C}']
    function Lookup(key: HSTRING): HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    function GetView: IMapView_2__HSTRING__HSTRING; safecall;
    function Insert(key: HSTRING; value: HSTRING): Boolean; safecall;
    procedure Remove(key: HSTRING); safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.MapChangedEventHandler`2<String,String>
  MapChangedEventHandler_2__HSTRING__HSTRING = interface(IUnknown)
  ['{E2663F37-2E1B-500C-AD68-C3ED7A8F74C8}']
    procedure Invoke(sender: IObservableMap_2__HSTRING__HSTRING; event: IMapChangedEventArgs_1__HSTRING); safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IObservableMap`2<String,String>
  IObservableMap_2__HSTRING__HSTRING = interface(IInspectable)
  ['{1E036276-2F60-55F6-B7F3-F86079E6900B}']
    function add_MapChanged(vhnd: MapChangedEventHandler_2__HSTRING__HSTRING): EventRegistrationToken; safecall;
    procedure remove_MapChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVectorView`1<String>>
  IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = interface(IInspectable)
  ['{BCDE03AD-EA71-5077-A961-1C0ECFF57202}']
    function get_Key: HSTRING; safecall;
    function get_Value: IVectorView_1__HSTRING; safecall;
    property Key: HSTRING read get_Key;
    property Value: IVectorView_1__HSTRING read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVectorView`1<String>>>
  IIterator_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = interface(IInspectable)
  ['{643B6D83-457E-5A43-800F-B0449F91D96B}']
    function get_Current: IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__IVectorView_1__HSTRING): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVectorView`1<String>>>
  IIterable_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING = interface(IInspectable)
  ['{A4CD6151-2CC1-56F1-9014-DF6BA3410BEB}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__IVectorView_1__HSTRING; safecall;
  end;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Foundation.Collections.IVectorView`1<String>>
  IMapView_2__HSTRING__IVectorView_1__HSTRING = interface(IInspectable)
  ['{2843D34F-D3E5-5FCA-9FDC-B568DD5C1E64}']
    function Lookup(key: HSTRING): IVectorView_1__HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__IVectorView_1__HSTRING; out second: IMapView_2__HSTRING__IVectorView_1__HSTRING); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Guid>
  IIterator_1__TGuid = interface(IInspectable)
  ['{D3D64048-82B3-53C7-9285-B0BE18368482}']
    function get_Current: TGuid; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PGuid): Cardinal; safecall;
    property Current: TGuid read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Guid>
  IIterable_1__TGuid = interface(IInspectable)
  ['{F4CA3045-5DD7-54BE-982E-D88D8CA0876E}']
    function First: IIterator_1__TGuid; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Guid>
  IVectorView_1__TGuid = interface(IInspectable)
  ['{9520E64B-15B2-52A6-98ED-3191FA6CF68A}']
    function GetAt(index: Cardinal): TGuid; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: TGuid; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PGuid): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Guid>
  IVector_1__TGuid = interface(IInspectable)
  ['{482E676D-B913-5EC1-AFA8-5F96922E94AE}']
    function GetAt(index: Cardinal): TGuid; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__TGuid; safecall;
    function IndexOf(value: TGuid; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: TGuid); safecall;
    procedure InsertAt(index: Cardinal; value: TGuid); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: TGuid); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PGuid): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PGuid); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<UInt32>
  IIterator_1__Cardinal = interface(IInspectable)
  ['{F06A2739-9443-5EF0-B284-DC5AFF3E7D10}']
    function get_Current: Cardinal; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCardinal): Cardinal; safecall;
    property Current: Cardinal read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<UInt32>
  IIterable_1__Cardinal = interface(IInspectable)
  ['{421D4B91-B13B-5F37-AE54-B5249BD80539}']
    function First: IIterator_1__Cardinal; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<UInt32>
  IVectorView_1__Cardinal = interface(IInspectable)
  ['{E5CE1A07-8D33-5007-BA64-7D2508CCF85C}']
    function GetAt(index: Cardinal): Cardinal; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Cardinal; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCardinal): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<UInt32>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Cardinal = interface(IUnknown)
  ['{55772F29-DA64-5C87-871C-074337A84573}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__Cardinal; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<UInt32>>
  IAsyncOperation_1__IVectorView_1__Cardinal = interface(IInspectable)
  ['{52C56F3C-713A-5162-9E62-362CE7ED53BE}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__Cardinal); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Cardinal; safecall;
    function GetResults: IVectorView_1__Cardinal; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Cardinal read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IPropertySet>
  AsyncOperationCompletedHandler_1__IPropertySet = interface(IUnknown)
  ['{5075A55F-68BA-56F2-97E6-9B1CBFA2C5F2}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IPropertySet; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IPropertySet>
  IAsyncOperation_1__IPropertySet = interface(IInspectable)
  ['{490B0686-AFD7-5037-9647-D8FE248F182C}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IPropertySet); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IPropertySet; safecall;
    function GetResults: IPropertySet; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IPropertySet read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Object>
  IIterator_1__IInspectable = interface(IInspectable)
  ['{44A94F2D-04F8-5091-B336-BE7892DD10BE}']
    function get_Current: IInspectable; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIInspectable): Cardinal; safecall;
    property Current: IInspectable read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Object>
  IIterable_1__IInspectable = interface(IInspectable)
  ['{092B849B-60B1-52BE-A44A-6FE8E933CBE4}']
    function First: IIterator_1__IInspectable; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Object>
  IVectorView_1__IInspectable = interface(IInspectable)
  ['{A6487363-B074-5C60-AB16-866DCE4EE54D}']
    function GetAt(index: Cardinal): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IInspectable; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIInspectable): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Double>
  IIterator_1__Double = interface(IInspectable)
  ['{638A2CF4-F474-5318-9055-141CB909AC4B}']
    function get_Current: Double; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PDouble): Cardinal; safecall;
    property Current: Double read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Double>
  IIterable_1__Double = interface(IInspectable)
  ['{C738964E-9C64-5BCE-B5CE-61E9A282EC4A}']
    function First: IIterator_1__Double; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Double>
  IVectorView_1__Double = interface(IInspectable)
  ['{AF7586A8-6B21-5F61-BFF1-1B682293AD96}']
    function GetAt(index: Cardinal): Double; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Double; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PDouble): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Double>
  IVector_1__Double = interface(IInspectable)
  ['{F452D23C-BF05-5F3E-88E7-D17A6716B911}']
    function GetAt(index: Cardinal): Double; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Double; safecall;
    function IndexOf(value: Double; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Double); safecall;
    procedure InsertAt(index: Cardinal; value: Double); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Double); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PDouble): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PDouble); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<UInt32>
  IVector_1__Cardinal = interface(IInspectable)
  ['{534832ED-2A03-5604-890D-5A928CD427B9}']
    function GetAt(index: Cardinal): Cardinal; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Cardinal; safecall;
    function IndexOf(value: Cardinal; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Cardinal); safecall;
    procedure InsertAt(index: Cardinal; value: Cardinal); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Cardinal); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCardinal): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCardinal); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMap`2<String,Object>>
  AsyncOperationCompletedHandler_1__IMap_2__HSTRING__IInspectable = interface(IUnknown)
  ['{7344F356-8399-5756-A2F8-ABD50C4146FF}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMap_2__HSTRING__IInspectable; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMap`2<String,Object>>
  IAsyncOperation_1__IMap_2__HSTRING__IInspectable = interface(IInspectable)
  ['{127E39C7-07C1-58E5-B48E-3A4729839FEC}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMap_2__HSTRING__IInspectable); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMap_2__HSTRING__IInspectable; safecall;
    function GetResults: IMap_2__HSTRING__IInspectable; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMap_2__HSTRING__IInspectable read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<UInt8>
  IIterator_1__Byte = interface(IInspectable)
  ['{40556131-A2A1-5FAB-AAEE-5F35268CA26B}']
    function get_Current: Byte; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PByte): Cardinal; safecall;
    property Current: Byte read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<UInt8>
  IIterable_1__Byte = interface(IInspectable)
  ['{88318266-F3FD-50FC-8F08-B823A41B60C1}']
    function First: IIterator_1__Byte; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<UInt8>
  IVectorView_1__Byte = interface(IInspectable)
  ['{6D05FB29-7885-544E-9382-A1AD391A3FA4}']
    function GetAt(index: Cardinal): Byte; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Byte; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PByte): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IInspectable = interface(IUnknown)
  ['{89981889-1207-5AE6-9B28-CCC58F3AAC6E}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMapView_2__HSTRING__IInspectable; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IAsyncOperation_1__IMapView_2__HSTRING__IInspectable = interface(IInspectable)
  ['{5DCBEE48-9965-51DA-A461-177C885BE7E5}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IInspectable); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IInspectable; safecall;
    function GetResults: IMapView_2__HSTRING__IInspectable; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IInspectable read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IIterator_1__IMapView_2__HSTRING__IInspectable = interface(IInspectable)
  ['{53A2E825-9BF1-5083-8A7B-9D94F312DADE}']
    function get_Current: IMapView_2__HSTRING__IInspectable; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIMapView_2__HSTRING__IInspectable): Cardinal; safecall;
    property Current: IMapView_2__HSTRING__IInspectable read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IIterable_1__IMapView_2__HSTRING__IInspectable = interface(IInspectable)
  ['{E1670FAE-49CD-5C47-A8C8-F6FA2C650C6C}']
    function First: IIterator_1__IMapView_2__HSTRING__IInspectable; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Foundation.Collections.IMapView`2<String,Object>>
  IVectorView_1__IMapView_2__HSTRING__IInspectable = interface(IInspectable)
  ['{172A655B-B3B8-5EAE-BC2E-A6A1F1708B4B}']
    function GetAt(index: Cardinal): IMapView_2__HSTRING__IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IMapView_2__HSTRING__IInspectable; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIMapView_2__HSTRING__IInspectable): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Foundation.Collections.IMapView`2<String,Object>>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IMapView_2__HSTRING__IInspectable = interface(IUnknown)
  ['{A782A13A-16A0-5326-B985-C4CA49E54E77}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IMapView_2__HSTRING__IInspectable; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Foundation.Collections.IMapView`2<String,Object>>>
  IAsyncOperation_1__IVectorView_1__IMapView_2__HSTRING__IInspectable = interface(IInspectable)
  ['{FC227365-219D-5D59-8B5B-58EB0A91CA0A}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IMapView_2__HSTRING__IInspectable); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IMapView_2__HSTRING__IInspectable; safecall;
    function GetResults: IVectorView_1__IMapView_2__HSTRING__IInspectable; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IMapView_2__HSTRING__IInspectable read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVector`1<String>>
  AsyncOperationCompletedHandler_1__IVector_1__HSTRING = interface(IUnknown)
  ['{FAE4B396-97C8-5CC3-BF88-EA3098EDF6B2}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVector_1__HSTRING; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVector`1<String>>
  IAsyncOperation_1__IVector_1__HSTRING = interface(IInspectable)
  ['{92B02CD3-AA6E-573D-BC03-8D2309CBA3EB}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVector_1__HSTRING); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVector_1__HSTRING; safecall;
    function GetResults: IVector_1__HSTRING; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVector_1__HSTRING read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVector`1<String>>
  IKeyValuePair_2__HSTRING__IVector_1__HSTRING = interface(IInspectable)
  ['{174F26C7-79EA-5F7C-BD70-AC4457F2CAC8}']
    function get_Key: HSTRING; safecall;
    function get_Value: IVector_1__HSTRING; safecall;
    property Key: HSTRING read get_Key;
    property Value: IVector_1__HSTRING read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVector`1<String>>>
  IIterator_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING = interface(IInspectable)
  ['{A11824C9-E458-502A-AFD8-CE3CE0ABD6FE}']
    function get_Current: IKeyValuePair_2__HSTRING__IVector_1__HSTRING; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__IVector_1__HSTRING): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__IVector_1__HSTRING read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Foundation.Collections.IVector`1<String>>>
  IIterable_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING = interface(IInspectable)
  ['{4FED2669-D0D3-59F6-91D9-95902D728D6A}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__IVector_1__HSTRING; safecall;
  end;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Foundation.Collections.IVector`1<String>>
  IMapView_2__HSTRING__IVector_1__HSTRING = interface(IInspectable)
  ['{153F9C9C-D22A-5C9E-9C74-8B85C908B000}']
    function Lookup(key: HSTRING): IVector_1__HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__IVector_1__HSTRING; out second: IMapView_2__HSTRING__IVector_1__HSTRING); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IMap`2<String,Windows.Foundation.Collections.IVector`1<String>>
  IMap_2__HSTRING__IVector_1__HSTRING = interface(IInspectable)
  ['{E475CA9D-6AFB-5992-993E-53E6EF7A9ECD}']
    function Lookup(key: HSTRING): IVector_1__HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    function GetView: IMapView_2__HSTRING__IVector_1__HSTRING; safecall;
    function Insert(key: HSTRING; value: IVector_1__HSTRING): Boolean; safecall;
    procedure Remove(key: HSTRING); safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Object>
  IVector_1__IInspectable = interface(IInspectable)
  ['{B32BDCA4-5E52-5B27-BC5D-D66A1A268C2A}']
    function GetAt(index: Cardinal): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IInspectable; safecall;
    function IndexOf(value: IInspectable; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IInspectable); safecall;
    procedure InsertAt(index: Cardinal; value: IInspectable); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IInspectable); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIInspectable): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIInspectable); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<Object,Object>
  IKeyValuePair_2__IInspectable__IInspectable = interface(IInspectable)
  ['{59E7AE0C-C29D-5AD6-BEF5-DEDB52A198E1}']
    function get_Key: IInspectable; safecall;
    function get_Value: IInspectable; safecall;
    property Key: IInspectable read get_Key;
    property Value: IInspectable read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<Object,Object>>
  IIterator_1__IKeyValuePair_2__IInspectable__IInspectable = interface(IInspectable)
  ['{31E55E8A-0F05-52FD-90D3-B04AA331AAA4}']
    function get_Current: IKeyValuePair_2__IInspectable__IInspectable; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__IInspectable__IInspectable): Cardinal; safecall;
    property Current: IKeyValuePair_2__IInspectable__IInspectable read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<Object,Object>>
  IIterable_1__IKeyValuePair_2__IInspectable__IInspectable = interface(IInspectable)
  ['{33AC68F0-1084-529A-8A17-4E7C8ADB7A0C}']
    function First: IIterator_1__IKeyValuePair_2__IInspectable__IInspectable; safecall;
  end;

  // Windows.Foundation.Collections.IMapView`2<Object,Object>
  IMapView_2__IInspectable__IInspectable = interface(IInspectable)
  ['{EFE76D10-CB60-50AD-8A4F-6885CD6212A1}']
    function Lookup(key: IInspectable): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: IInspectable): Boolean; safecall;
    procedure Split(out first: IMapView_2__IInspectable__IInspectable; out second: IMapView_2__IInspectable__IInspectable); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IMap`2<Object,Object>
  IMap_2__IInspectable__IInspectable = interface(IInspectable)
  ['{F5F69427-55ED-5512-8429-D4F6626DFCDD}']
    function Lookup(key: IInspectable): IInspectable; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: IInspectable): Boolean; safecall;
    function GetView: IMapView_2__IInspectable__IInspectable; safecall;
    function Insert(key: IInspectable; value: IInspectable): Boolean; safecall;
    procedure Remove(key: IInspectable); safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Object>
  VectorChangedEventHandler_1__IInspectable = interface(IUnknown)
  ['{B423A801-D35E-56B9-813B-00889536CB98}']
    procedure Invoke(sender: IObservableVector_1__IInspectable; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Object>
  IObservableVector_1__IInspectable = interface(IInspectable)
  ['{7B81C56A-0985-518D-BAA9-0DA9AE009F65}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__IInspectable): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Single>
  IIterator_1__Single = interface(IInspectable)
  ['{42614E61-B0AA-5E72-9354-2771DB20B7A8}']
    function get_Current: Single; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PSingle): Cardinal; safecall;
    property Current: Single read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Single>
  IIterable_1__Single = interface(IInspectable)
  ['{B01BEE51-063A-5FDA-BD72-D76637BB8CB8}']
    function First: IIterator_1__Single; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Single>
  IVectorView_1__Single = interface(IInspectable)
  ['{7BCA64FD-150C-5D50-B56B-9F4F474C5930}']
    function GetAt(index: Cardinal): Single; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Single; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PSingle): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Single>
  IVector_1__Single = interface(IInspectable)
  ['{61CF693F-DB4C-579F-B905-5DD3D23CFD4D}']
    function GetAt(index: Cardinal): Single; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Single; safecall;
    function IndexOf(value: Single; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Single); safecall;
    procedure InsertAt(index: Cardinal; value: Single); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Single); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PSingle): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PSingle); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Object>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IInspectable = interface(IUnknown)
  ['{261A9D81-F58F-5283-9461-CA3E31C1123C}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IInspectable; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Object>>
  IAsyncOperation_1__IVectorView_1__IInspectable = interface(IInspectable)
  ['{D671D332-22AA-5597-8DCC-2459EAB49418}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IInspectable); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IInspectable; safecall;
    function GetResults: IVectorView_1__IInspectable; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IInspectable read get_Completed write put_Completed;
  end;


  // Emit Forwarded classes
  // Windows.Foundation.Collections.PropertySet
  // DualAPI
  TPropertySet = class(TWinRTGenericImportI<IPropertySet>) end;

  // Windows.Foundation.Collections.ValueSet
  // DualAPI
  TValueSet = class(TWinRTGenericImportI<IPropertySet>) end;

  // Windows.Foundation.Collections.StringMap
  // DualAPI
  TStringMap = class(TWinRTGenericImportI<IMap_2__HSTRING__HSTRING>) end;


implementation

  // Emit Classes Implementation
 { TPropertySet }

 { TValueSet }

 { TStringMap }


end.
