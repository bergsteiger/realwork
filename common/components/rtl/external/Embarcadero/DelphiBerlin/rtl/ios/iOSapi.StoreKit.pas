{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework StoreKit                  }
{                                                          }
{ Copyright (c) 2009, Apple Inc. All rights reserved.      }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.         }
{              All rights reserved                         }
{                                                          }
{**********************************************************}

unit iOSapi.StoreKit;

interface

uses Macapi.ObjectiveC, iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.UIKit;

const
  SKDownloadStateActive = 1;
  SKDownloadStateCancelled = 5;
  SKDownloadStateFailed = 4;
  SKDownloadStateFinished = 3;
  SKDownloadStatePaused = 2;
  SKDownloadStateWaiting = 0;
  SKErrorClientInvalid = 1;
  SKErrorPaymentCancelled = 2;
  SKErrorPaymentInvalid = 3;
  SKErrorPaymentNotAllowed = 4;
  SKErrorStoreProductNotAvailable = 5;
  SKErrorUnknown = 0;
  SKPaymentTransactionStateFailed = 2;
  SKPaymentTransactionStatePurchased = 1;
  SKPaymentTransactionStatePurchasing = 0;
  SKPaymentTransactionStateRestored = 3;

const
  libStoreKit = '/System/Library/Frameworks/StoreKit.framework/StoreKit';

// Typedefs and structs
{$M+}
type
  SKDownloadState = NSInteger;
  SKPaymentTransactionState = NSInteger;

type
{$M+}
// ===== Forward declarations =====

  SKProduct = interface;
  SKPaymentTransaction = interface;
  SKProductsResponse = interface;
  SKStoreProductViewController = interface;
  SKRequest = interface;
  SKDownload = interface;
  SKPaymentQueue = interface;
  SKPayment = interface;
  SKProductsRequest = interface;
  SKMutablePayment = interface;
  SKPaymentTransactionObserver = interface;
  SKProductsRequestDelegate = interface;
  SKRequestDelegate = interface;
  SKStoreProductViewControllerDelegate = interface;

// ===== Protocol declarations =====

  SKPaymentTransactionObserver = interface(IObjectiveC)
    ['{88D273EF-BD1E-4BE8-9F69-21C5A7B89953}']
    procedure paymentQueue(queue: SKPaymentQueue; removedTransactions: NSArray); cdecl; overload;
    procedure paymentQueue(queue: SKPaymentQueue; restoreCompletedTransactionsFailedWithError: NSError); cdecl; overload;
    [MethodName('paymentQueue:updatedDownloads:')]
    procedure paymentQueueUpdatedDownloads(queue: SKPaymentQueue; updatedDownloads: NSArray); cdecl;
    [MethodName('paymentQueue:updatedTransactions:')]
    procedure paymentQueueUpdatedTransactions(queue: SKPaymentQueue; updatedTransactions: NSArray); cdecl;
    procedure paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue); cdecl;
  end;

  SKRequestDelegate = interface(IObjectiveC)
    ['{75551E3D-FE0A-439C-A2AE-44E6AFDBE137}']
    procedure request(request: SKRequest; didFailWithError: NSError); cdecl;
    procedure requestDidFinish(request: SKRequest); cdecl;
  end;

  SKProductsRequestDelegate = interface(SKRequestDelegate)
    ['{78F9F6B7-5F27-4FC8-A11D-4E5B546FF0A3}']
    procedure productsRequest(request: SKProductsRequest; didReceiveResponse: SKProductsResponse); cdecl;
  end;

  SKStoreProductViewControllerDelegate = interface(IObjectiveC)
    ['{8EA90AB3-A629-4E8E-B8DD-752B0EF06624}']
    procedure productViewControllerDidFinish(viewController: SKStoreProductViewController); cdecl;
  end;

// ===== Interface declarations =====

  SKProductClass = interface(NSObjectClass)
    ['{428A4142-EB45-4B2A-BAF1-7CAB8194E510}']
  end;
  SKProduct = interface(NSObject)
    ['{CB3FB7DE-2C6D-460F-ABC8-42A9E0DD27FA}']
    function downloadContentLengths: NSArray; cdecl;
    function downloadContentVersion: NSString; cdecl;
    function isDownloadable: Boolean; cdecl;
    function localizedDescription: NSString; cdecl;
    function localizedTitle: NSString; cdecl;
    function price: NSDecimalNumber; cdecl;
    function priceLocale: NSLocale; cdecl;
    function productIdentifier: NSString; cdecl;
  end;
  TSKProduct = class(TOCGenericImport<SKProductClass, SKProduct>) end;

  SKPaymentTransactionClass = interface(NSObjectClass)
    ['{63D69BB2-4E72-44CE-88D4-8CF9398DEE83}']
  end;
  SKPaymentTransaction = interface(NSObject)
    ['{C10BC112-D047-4710-8384-B731322AD5D9}']
    function downloads: NSArray; cdecl;
    function error: NSError; cdecl;
    function originalTransaction: SKPaymentTransaction; cdecl;
    function payment: SKPayment; cdecl;
    function transactionDate: NSDate; cdecl;
    function transactionIdentifier: NSString; cdecl;
    function transactionReceipt: NSData; cdecl;
    function transactionState: SKPaymentTransactionState; cdecl;
  end;
  TSKPaymentTransaction = class(TOCGenericImport<SKPaymentTransactionClass, SKPaymentTransaction>)  end;

  SKProductsResponseClass = interface(NSObjectClass)
    ['{1518D722-C0B3-4DDB-9D9A-BF082598437D}']
  end;
  SKProductsResponse = interface(NSObject)
    ['{BCD7691E-2AEB-4530-AAD5-8C4288573788}']
    function invalidProductIdentifiers: NSArray; cdecl;
    function products: NSArray; cdecl;
  end;
  TSKProductsResponse = class(TOCGenericImport<SKProductsResponseClass, SKProductsResponse>)  end;

  SKStoreProductViewControllerClass = interface(UIViewControllerClass)
    ['{0D751D11-5154-4CCF-B91D-FC1B8CBFC752}']
  end;
  SKStoreProductViewController = interface(UIViewController)
    ['{AA05EA7E-AFAE-48DA-9AC7-7CD34B4EE0A7}']
    function delegate: Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
  end;
  TSKStoreProductViewController = class(TOCGenericImport<SKStoreProductViewControllerClass, SKStoreProductViewController>)  end;

  SKRequestClass = interface(NSObjectClass)
    ['{57A7603D-5A6F-4BA4-AE2D-5591CEC2DE66}']
  end;
  SKRequest = interface(NSObject)
    ['{38CA6F9F-8509-43A8-8E70-A5B17B2FF95C}']
    procedure cancel; cdecl;
    function delegate: Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure start; cdecl;
  end;
  TSKRequest = class(TOCGenericImport<SKRequestClass, SKRequest>)  end;

  SKDownloadClass = interface(NSObjectClass)
    ['{FCB2BA81-B727-4EE6-9B7B-BF45CDF215E5}']
  end;
  SKDownload = interface(NSObject)
    ['{77A31CCE-8CA1-445F-82CD-4A2DD494C0F4}']
    function contentIdentifier: NSString; cdecl;
    function contentLength: Int64; cdecl;
    function contentURL: NSURL; cdecl;
    function contentVersion: NSString; cdecl;
    function downloadState: SKDownloadState; cdecl;
    function error: NSError; cdecl;
    function progress: Single; cdecl;
    function timeRemaining: NSTimeInterval; cdecl;
    function transaction: SKPaymentTransaction; cdecl;
  end;
  TSKDownload = class(TOCGenericImport<SKDownloadClass, SKDownload>)  end;

  SKPaymentQueueClass = interface(NSObjectClass)
    ['{F44FA678-A77E-4B32-B2FE-0AB2498E64F3}']
    {class} function canMakePayments: Boolean; cdecl;
    {class} function defaultQueue: Pointer; cdecl;
  end;
  SKPaymentQueue = interface(NSObject)
    ['{4AD59191-395F-4F52-9C1D-05E011E0AB8B}']
    procedure addPayment(payment: SKPayment); cdecl;
    procedure addTransactionObserver(observer: Pointer); cdecl;
    procedure cancelDownloads(downloads: NSArray); cdecl;
    procedure finishTransaction(transaction: SKPaymentTransaction); cdecl;
    procedure pauseDownloads(downloads: NSArray); cdecl;
    procedure removeTransactionObserver(observer: Pointer); cdecl;
    procedure restoreCompletedTransactions; cdecl;
    procedure resumeDownloads(downloads: NSArray); cdecl;
    procedure startDownloads(downloads: NSArray); cdecl;
    function transactions: NSArray; cdecl;
  end;
  TSKPaymentQueue = class(TOCGenericImport<SKPaymentQueueClass, SKPaymentQueue>)  end;

  SKPaymentClass = interface(NSObjectClass)
    ['{80EE0EA9-756C-4A86-86F3-490D8E76538F}']
    {class} function paymentWithProduct(product: SKProduct): Pointer; cdecl;
    {class} function paymentWithProductIdentifier(identifier: NSString): Pointer; cdecl;
  end;
  SKPayment = interface(NSObject)
    ['{67C12FA6-A97A-4484-AF97-34DCC66F858C}']
    function productIdentifier: NSString; cdecl;
    function quantity: NSInteger; cdecl;
    function requestData: NSData; cdecl;
  end;
  TSKPayment = class(TOCGenericImport<SKPaymentClass, SKPayment>)  end;

  SKProductsRequestClass = interface(SKRequestClass)
    ['{91F51A78-6385-4D57-8BCD-F055F7553FBB}']
  end;
  SKProductsRequest = interface(SKRequest)
    ['{083E9FED-BE5E-45C4-9975-24654345875F}']
    function delegate: Pointer; cdecl;
    function initWithProductIdentifiers(productIdentifiers: NSSet): Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
  end;
  TSKProductsRequest = class(TOCGenericImport<SKProductsRequestClass, SKProductsRequest>)  end;

  SKMutablePaymentClass = interface(SKPaymentClass)
    ['{D69C31D1-4A7A-46D9-A6B8-6061A6BFACB4}']
  end;
  SKMutablePayment = interface(SKPayment)
    ['{7387B4F4-4EF8-4D8B-BAE7-DDA8A56AAA15}']
    function productIdentifier: NSString; cdecl;
    function quantity: NSInteger; cdecl;
    function requestData: NSData; cdecl;
    procedure setProductIdentifier(productIdentifier: NSString); cdecl;
    procedure setQuantity(quantity: NSInteger); cdecl;
    procedure setRequestData(requestData: NSData); cdecl;
  end;
  TSKMutablePayment = class(TOCGenericImport<SKMutablePaymentClass, SKMutablePayment>) end;

implementation

{$IF defined(IOS) and NOT defined(CPUARM)}
uses
  Posix.Dlfcn;

var
  StoreKitModule: THandle;

initialization
  StoreKitModule := dlopen(MarshaledAString(libStoreKit), RTLD_LAZY);

finalization
  dlclose(StoreKitModule);
{$ENDIF IOS}
end.
