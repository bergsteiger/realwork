{*******************************************************}
{                                                       }
{           Delphi FireMonkey Mobile Services           }
{                                                       }
{     Implementation of interface for in-app purchases  }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

// Reference on Android developer site: http://d.android.com/google/play/billing

unit FMX.InAppPurchase.Android;

interface

{$SCOPEDENUMS ON}

procedure RegisterInAppPurchaseService;
procedure UnRegisterInAppPurchaseService;

implementation

uses
  System.Types, System.Classes, System.SysUtils, System.Generics.Collections, System.DateUtils, FMX.Platform,
  FMX.Platform.Android, FMX.Types, FMX.Consts, FMX.Helpers.Android, FMX.InAppPurchase, Androidapi.Consts, 
  Androidapi.Helpers, Androidapi.NativeActivity, Androidapi.JNI, Androidapi.JNIBridge,  Androidapi.JNI.JavaTypes, 
  Androidapi.JNI.App, Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.InAppBilling, Androidapi.JNI.Os,
  Androidapi.JNI.Java.Security, Androidapi.Log, System.Messaging, System.TypInfo, Androidapi.JNI.Embarcadero;

type
  TIabResult = class;
  TPurchase = class;
  TInventory = class;

  TOrderId = string;
  TPurchaseState = (psPurchased = 0, psCanceled = 1, psRefunded = 2);

  TSkuId = string;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Alias for type string for localized prices. A price string is the
  ///	  formatted price (exclusive of tax) of the item, including its currency
  ///	  sign.
  ///	</summary>
  {$ENDREGION}
  TSkuPrice = string;

  TProductKind = (InApp, Subscription);

  TProductKindHelper = record helper for TProductKind
  const
    pkInApp = TProductKind.InApp deprecated 'Use TProductKind.InApp';
    pkSubscription = TProductKind.Subscription deprecated 'Use TProductKind.Subscription';
  end;

  TIABResponseCode = (Ok, UserCancelled, BillingUnavailable, ItemUnavailable, DeveloperError, Error, ItemAlreadyOwned,
    ItemNotOwned, RemoteException, BadResponse, VerificationFailed, SendIntentFailed, UnknownPurchaseResponse,
    MissingToken, UnknownError, SubscriptionsNotAvailable, InvalidConsumption);

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Called to notify that setup is complete.
  ///	</summary>
  ///	<param name="IabResult">
  ///	  The result of the setup process.
  ///	</param>
  {$ENDREGION}
  TOnSetupFinished = procedure(const IabResult: TIabResult) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Called to notify that an in-app purchase finished. If the purchase was
  ///	  successful, then the Info parameter specifies which item was purchased.
  ///	</summary>
  ///	<param name="IabResult">
  ///	  The result of the purchase.
  ///	</param>
  ///	<param name="Purchase">
  ///	  The purchase information (nil if purchase failed)
  ///	</param>
  {$ENDREGION}
  TOnPurchaseFinished = procedure(const IabResult: TIabResult; const Purchase: TPurchase) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Called to notify that an inventory query operation completed.
  ///	</summary>
  ///	<param name="IabResult">
  ///	  The result of the operation.
  ///	</param>
  ///	<param name="Inventory">
  ///	  The inventory.
  ///	</param>
  {$ENDREGION}
  TOnQueryInventoryFinished = procedure(const IabResult: TIabResult; const Inventory: TInventory) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Called to notify that a consumption has finished.
  ///	</summary>
  ///	<param name="Purchase">
  ///	  The purchase that was (or was to be) consumed.
  ///	</param>
  ///	<param name="IabResult">
  ///	  The result of the consumption operation.
  ///	</param>
  {$ENDREGION}
  TOnConsumeFinished = procedure(const Purchase: TPurchase; const IabResult: TIabResult) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Called to notify that a consumption of multiple items has finished.
  ///	</summary>
  ///	<param name="Purchases">
  ///	  The purchases that were (or were to be) consumed.
  ///	</param>
  ///	<param name="Results">
  ///	  The results of each consumption operation, corresponding to each sku.
  ///	</param>
  {$ENDREGION}
  TOnConsumeMultiFinished = procedure(const Purchases: TList<TPurchase>; const Results: TList<TIabResult>) of object;

  // Helper based on https://code.google.com/p/marketbilling/
  TIabHelper = class(TJavaLocal, JServiceConnection)
  private
    FDebugLog: Boolean;
    FSetupDone: Boolean;
    FSubscriptionsSupported: Boolean;
    // Only one asynchronous operation at a time can be in progress)
    FAsyncInProgress: Boolean;
    // (for logging/debugging)
    // if FAsyncInProgress == true, what asynchronous operation is in progress?
    FAsyncOperation: string;
    FContext: JContext;
    FService: JIInAppBillingService;
    FServiceConn: JServiceConnection;
    FRequestCode: Integer;
    FPurchasingItemKind: TProductKind;
    FBase64PublicKey: string;
    FPurchaseListener: TOnPurchaseFinished;
    FSetupFinishedListener: TOnSetupFinished;

    // Keys for the responses from InAppBillingService
    ResponseKeyCode: JString;
    ResponseKeySkuDetailsList: JString;
    ResponseKeyBuyIntent: JString;
    ResponseKeyInAppPurchaseData: JString;
    ResponseKeyInAppSignature: JString;
    ResponseKeyInAppItemList: JString;
    ResponseKeyInAppPurchaseDataList: JString;
    ResponseKeyInAppSignatureList: JString;
    ResponeKeyInAppContinuationToken: JString;

    GetSkuDetailsItemList: JString;
    GetSkuDetailsItemKindList: JString;
    FMessageSubscriptionID: Integer;

    procedure CheckSetupDone(const Operation: string);
    // Workaround to bug where sometimes response codes come as Long instead of Integer
    function GetResponseCodeFromBundle(const Bundle: JBundle): Integer;
    // Workaround to bug where sometimes response codes come as Long instead of Integer
    function GetResponseCodeFromIntent(const Intent: JIntent): Integer;
    procedure FlagStartAsync(const Operation: string);
    procedure FlagEndAsync;
    function QueryPurchases(const Inv: TInventory; ItemKind: TProductKind): TIABResponseCode;
    function QuerySkuDetails(ItemKind: TProductKind; const Inv: TInventory; const MoreSkus: TList<TSkuId>): TIABResponseCode;
    procedure ConsumeAsyncInternal(const Purchases: TList<TPurchase>; const SingleListener: TOnConsumeFinished;
      const MultiListener: TOnConsumeMultiFinished);

  public
    constructor Create;
    procedure onServiceConnected(Name: JComponentName; service: JIBinder); cdecl;
    procedure onServiceDisconnected(Name: JComponentName); cdecl;
    procedure EnableDebugLogging(Enable: Boolean); overload;
    procedure LogDebug(const Msg: string);
    procedure LogError(const Msg: string);
    procedure LogWarn(const Msg: string);
    procedure StartSetup(const Listener: TOnSetupFinished);
    procedure Dispose;
    function SubscriptionsSupported: Boolean;
    procedure LaunchPurchaseFlow(const Sku: TSkuId; ItemKind: TProductKind; RequestCode: Integer;
      const Listener: TOnPurchaseFinished; const ExtraData: string);
    procedure HandleActivityMessage(const Sender: TObject; const M: TMessage);
    function HandleActivityResult(RequestCode: Integer; ResultCode: Integer; const Data: JIntent): Boolean;
    function QueryInventory(ShouldQuerySkuDetails: Boolean; const MoreItemSkus, MoreSubsSkus: TList<TSkuId>): TInventory; overload;
    procedure QueryInventoryAsync(ShouldQuerySkuDetails: Boolean; const MoreSkus: TList<TSkuId>;
      const Listener: TOnQueryInventoryFinished);
    procedure Consume(const ItemInfo: TPurchase);
    procedure ConsumeAsync(const Purchase: TPurchase; const Listener: TOnConsumeFinished); overload;
    procedure ConsumeAsync(const Purchases: TList<TPurchase>; const Listener: TOnConsumeMultiFinished); overload;
    property Base64PublicKey: string read FBase64PublicKey write FBase64PublicKey;
    class function GetResponseDesc(Code: TIABResponseCode): string;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Represents an in-app product&amp;apos;s listing details.
  ///	</summary>
  {$ENDREGION}
  TSkuDetails = class
  private
    FItemKind: TProductKind;
    FSku: TSkuId;
    FType: string;
    FPrice: TSkuPrice;
    FTitle: string;
    FDescription: string;
    FJson: string;
    class var JProductID: JString;
    class var JType: JString;
    class var JPrice: JString;
    class var JTitle: JString;
    class var JDescription: JString;
  public
    class constructor Create;
    constructor Create(const JsonSkuDetails: string); overload;
    constructor Create(ItemKind: TProductKind; const JsonSkuDetails: string); overload;
    function ToString: string; override;
    property Sku: TSkuId read FSku;
    property ItemKind: TProductKind read FItemKind;
    property Price: TSkuPrice read FPrice;
    property Title: string read FTitle;
    property Description: string read FDescription;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Represents an in-app billing purchase.
  ///	</summary>
  {$ENDREGION}
  TPurchase = class
  private
    FItemKind: TProductKind;
    FOrderId: TOrderId;
    FPackageName: string;
    FSku: string;
    FPurchaseTime: TDateTime;
    FPurchaseState: TPurchaseState;
    FDeveloperPayload: string;
    FToken: string;
    FOriginalJson: string;
    FSignature: string;
    class var JOrderId: JString;
    class var JPackageName: JString;
    class var JSku: JString;
    class var JPurchaseTime: JString;
    class var JPurchaseState: JString;
    class var JDeveloperPayload: JString;
    class var JToken: JString;
    class var JPurchaseToken: JString;
  public
    class constructor Create;
    constructor Create(ItemKind: TProductKind; const JsonPurchaseInfo, Signature: string);
    function ToString: string; override;
    property ItemKind: TProductKind read FItemKind;
    property OrderId: TOrderId read FOrderId;
    property PackageName: string read FPackageName;
    property Sku: TSkuId read FSku;
    property PurchaseTime: TDateTime read FPurchaseTime;
    property PurchaseState: TPurchaseState read FPurchaseState;
    property DeveloperPayload: string read FDeveloperPayload;
    property Token: string read FToken;
    property OriginalJson: string read FOriginalJson;
    property Signature: string read FSignature;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Represents a block of information about in-app items. An Inventory is
  ///	  returned by such methods as TIabHelper.QueryInventory.
  ///	</summary>
  {$ENDREGION}
  TInventory = class
  private
    FSkuMap: TDictionary<TSkuId, TSkuDetails>;
    FPurchaseMap: TDictionary<TSkuId, TPurchase>;
    function GetSkuDetails(const Sku: TSkuId): TSkuDetails;
    // Returns purchase information for a given product, or nil if there is no purchase.
    function GetPurchase(const Sku: TSkuId): TPurchase;
  public
    constructor Create;
    function IsPurchased(const Sku: TSkuId): Boolean;
    function HasDetails(const Sku: TSkuId): Boolean;
    // Erase a purchase (locally) from the inventory, given its product ID. This just
    // modifies the Inventory object locally and has no effect on the server! This is
    // useful when you have an existing Inventory object which you know to be up to date,
    // and you have just consumed an item successfully, which means that erasing its
    // purchase data from the Inventory you already have is quicker than querying for
    // a new Inventory.
    procedure ErasePurchase(const Sku: TSkuId);
    procedure AddPurchase(const Purchase: TPurchase);
    procedure AddSkuDetails(const SkuDetails: TSkuDetails);
    function GetAllSkus: TList<TSkuId>; overload;
    function GetAllOwnedSkus: TList<TSkuId>; overload;
    function GetAllOwnedSkus(ItemKind: TProductKind): TList<TSkuId>; overload;
    function GetAllPurchases: TList<TPurchase>;
    property SkuDetails[const Sku: TSkuId]: TSkuDetails read GetSkuDetails;
    property Purchases[const Sku: TSkuId]: TPurchase read GetPurchase;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Represents the result of an in-app billing operation. A result is
  ///	  composed of a response code (an enum) and possibly a message (string).
  ///	  You can get those through the Response and Message prroperties,
  ///	  respectively. You can also inquire whether a result is a success or a
  ///	  failure via the IsSuccess and isFailure properties.
  ///	</summary>
  {$ENDREGION}
  TIabResult = class
  private
    FResponse: TIABResponseCode;
    FMessage: String;
    function GetIsSuccess: Boolean;
    function GetIsFailure: Boolean;
  public
    constructor Create(Response: TIABResponseCode; const Msg: String);
    function ToString: String; override;
    class function IntToResponseCode(Response: Integer): TIABResponseCode;
    property Response: TIABResponseCode read FResponse;
    property Message: String read FMessage;
    property IsSuccess: Boolean read GetIsSuccess;
    property IsFailure: Boolean read GetIsFailure;
  end;

  TAndroidInAppPurchaseService = class(TInterfacedObject, IFMXInAppPurchaseService)
  private
    FHelper: TIabHelper;
    FComponents: TList<TCustomInAppPurchase>;
    FComponentsPendingSetupCompleteEvent: TList<TCustomInAppPurchase>;
    FSetupIsComplete: Boolean;
    FInventory: TInventory;
    FTransactionPayload: string;
    procedure CheckApplicationLicenseKey;
    function GetApplicationLicenseKey: string;
    procedure SetApplicationLicenseKey(const Value: string);
    function GetTransactionPayload: string;
    procedure SetTransactionPayload(const Value: string);
    {$REGION 'TIABHelper callback methods'}
    procedure DoSetupComplete(const IabResult: TIabResult);
    procedure DoQueryInventoryFinished(const IabResult: TIabResult; const Inventory: TInventory);
    // Callback for when a purchase is finished
    procedure DoPurchaseFinished(const IabResult: TIabResult; const Purchase: TPurchase);
    // Called when consumption is complete
    procedure DoConsumeFinished(const Purchase: TPurchase; const IabResult: TIabResult);
    procedure DoConsumeMultiFinished(const Purchases: TList<TPurchase>; const Results: TList<TIabResult>);
    {$ENDREGION}
    procedure DoProductsRequestResponse(const Products: TIAPProductList;
      const InvalidProductIDs: TStrings);
    procedure DoError(FailureKind: TFailureKind; const ErrorMessage: string);
    function DoVerifyPayload(Purchase: TPurchase): Boolean;
    procedure DoPurchaseCompleted(const ProductID: string;
      NewTransaction: Boolean);
    procedure DoRecordTransaction(const ProductID, TransactionID: string;
      TransactionDate: TDateTime);
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXInAppPurchaseService }
    procedure AddComponent(const Component: TCustomInAppPurchase);
    procedure RemoveComponent(const Component: TCustomInAppPurchase);
    procedure SetupInAppPurchase(Component: TCustomInAppPurchase);
    function CanMakeInAppPurchases: Boolean;
    procedure QueryProducts(const ProductIDs: TStrings);
    function IsProductPurchased(const ProductID: string): Boolean;
    procedure PurchaseProduct(const ProductID: string);
    procedure ConsumeProduct(const ProductID: string);
    procedure ConsumeProducts(const ProductIDs: TStrings);
    procedure RestorePurchasedProducts;
    property ApplicationLicenseKey: string read GetApplicationLicenseKey write SetApplicationLicenseKey;
    property TransactionPayload: string read GetTransactionPayload write SetTransactionPayload;
  end;

                                              

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Exception thrown when something went wrong with in-app billing. An
  ///	  EIabException has an associated IabResult (an error). To get the IAB
  ///	  result that caused this exception to be thrown, use <see cref="Result" />
  ///	</summary>
  {$ENDREGION}
  EIabException = class(Exception)
  private
    FResult: TIabResult;
  public
    constructor Create(const R: TIabResult); overload;
    constructor Create(Response: TIABResponseCode; const AMessage: String); overload;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The result that caused this exception to be thrown
    ///	</summary>
    {$ENDREGION}
    property Result: TIabResult read FResult;
  end;
  EIllegalStateException = class(EIabException);
  ERuntimeException = class(EIabException);

const
  //Exception class names as picked up by EJNIException
  //The JNI exception class name extraction uses the exception class's
  //toString() method, which inserts the class prefix in
  SRemoteException = 'class android.os.RemoteException';  // do not localize
  SJSONException = 'class org.json.JSONException'; // do not localize
  SSendIntentException = 'class android.content.IntentSender.SendIntentException'; // do not localize
  SNoSuchAlgorithmException = 'class java.security.NoSuchAlgorithmException'; // do not localize
  SInvalidKeySpecException = 'class java.security.spec.InvalidKeySpecException'; // do not localize
  SInvalidKeyException = 'class java.security.InvalidKeyException'; // do not localize
  SSignatureException = 'class java.security.SignatureException'; // do not localize
  InAppPurchaseRequestCode = 100;

var
  InAppPurchaseService: TAndroidInAppPurchaseService;

function ProductKindToStr(Kind: TProductKind): string;
const
  // Do not localize
  Strs: array[TProductKind] of string = ('inapp', 'subs'); // do not localize
begin
  Result := Strs[Kind];
end;

function SkuDetailsToProduct(const SkuDetails: TSkuDetails): TProduct;
begin
  Result := TProduct.Create(SkuDetails.Sku, TProduct.PriceNotAvailable,
    SkuDetails.Price, SkuDetails.Title, SkuDetails.Description, False, nil, '');
end;

{ TIabHelper }

constructor TIabHelper.Create;
begin
  inherited Create;
  FDebugLog := True;
  FContext := TAndroidHelper.Context.getApplicationContext;
  ResponseKeyCode := StringToJString('RESPONSE_CODE');
  ResponseKeySkuDetailsList := StringToJString('DETAILS_LIST');
  ResponseKeyBuyIntent := StringToJString('BUY_INTENT');
  ResponseKeyInAppPurchaseData := StringToJString('INAPP_PURCHASE_DATA');
  ResponseKeyInAppSignature := StringToJString('INAPP_DATA_SIGNATURE');
  ResponseKeyInAppItemList := StringToJString('INAPP_PURCHASE_ITEM_LIST');
  ResponseKeyInAppPurchaseDataList := StringToJString('INAPP_PURCHASE_DATA_LIST');
  ResponseKeyInAppSignatureList := StringToJString('INAPP_DATA_SIGNATURE_LIST');
  ResponeKeyInAppContinuationToken := StringToJString('INAPP_CONTINUATION_TOKEN');
  GetSkuDetailsItemList := StringToJString('ITEM_ID_LIST');
  GetSkuDetailsItemKindList := StringToJString('ITEM_TYPE_LIST');
end;

procedure TIabHelper.CheckSetupDone(const Operation: string);
begin
  if not FSetupDone then
    raise EIllegalStateException.CreateFmt(SIABNotSetUpErrorFmt, [Operation]);
end;

procedure TIabHelper.Consume(const ItemInfo: TPurchase);
var
  Token: string;
  Sku: TSkuId;
  Response: TIABResponseCode;
begin
  CheckSetupDone('consume');
  if ItemInfo.ItemKind <> TProductKind.InApp then
    raise EIabException.Create(TIABResponseCode.InvalidConsumption,
      Format(SCantConsumeThoseErrorFmt, [ProductKindToStr(ItemInfo.ItemKind)]));
  try
    Token := ItemInfo.Token;
    Sku := ItemInfo.Sku;
    if Token.IsEmpty then
      raise EIabException.Create(TIABResponseCode.MissingToken, Format(SSkuTokenMissingErrorFmt, [Sku, ItemInfo.ToString]));
    Response := TIabResult.IntToResponseCode(FService.consumePurchase(3, FContext.getPackageName, StringToJString(Token)));
    if Response <> TIABResponseCode.Ok then
      raise EIabException.Create(Response, Format(SSkuConsumptionErrorFmt, [Sku]));
  except
    on e: EJNIException do
    begin
      if e.ExceptionClassName.Equals(SRemoteException) then
        raise EIabException.Create(TIABResponseCode.RemoteException, Format(SConsumeErrorFmt, [itemInfo.ToString]))
      else
        raise;
    end;
  end
end;

procedure TIabHelper.ConsumeAsync(const Purchase: TPurchase; const Listener: TOnConsumeFinished);
var
  Purchases: TList<TPurchase>;
begin
  CheckSetupDone('consume');
  Purchases := TList<TPurchase>.Create;
  Purchases.Add(Purchase);
  ConsumeAsyncInternal(Purchases, Listener, nil);
end;

procedure TIabHelper.ConsumeAsync(const Purchases: TList<TPurchase>; const Listener: TOnConsumeMultiFinished);
begin
  CheckSetupDone('consume');
  ConsumeAsyncInternal(Purchases, nil, Listener);
end;

var
  ConsumeThread: TThread;

procedure TIabHelper.ConsumeAsyncInternal(const Purchases: TList<TPurchase>; const SingleListener: TOnConsumeFinished;
  const MultiListener: TOnConsumeMultiFinished);
begin
  FlagStartAsync('consume');
  ConsumeThread := TThread.CreateAnonymousThread(procedure
    var
      Results: TList<TIabResult>;
      Purchase: TPurchase;
    begin
      try
        Results := TList<TIabResult>.Create;
        for Purchase in Purchases do
          try
            Consume(Purchase);
            Results.Add(TIabResult.Create(TIABResponseCode.Ok, Format(SConsumeOKFmt, [Purchase.Sku])));
          except
            on e: EIabException do
              Results.Add(e.Result);
          end;
        FlagEndAsync;
        if Assigned(SingleListener) then
          CallInUiThread(procedure
            begin
              if Assigned(SingleListener) then
                SingleListener(Purchases[0], Results[0]);
            end);
        if Assigned(MultiListener) then
          CallInUiThread(procedure
            begin
              if Assigned(MultiListener) then
                MultiListener(Purchases, Results);
            end);
      finally
        GetAndroidApp.activity.vm^.DetachCurrentThread(GetAndroidApp.activity.vm);
      end;
    end);
  ConsumeThread.Start;
end;

procedure TIabHelper.Dispose;
begin
  FSetupDone := False;
  if FServiceConn <> nil then
  begin
    if FContext <> nil then
      FContext.unbindService(FServiceConn);
    FServiceConn := nil;
    FService := nil;
    FPurchaseListener := nil;
  end;
end;

procedure TIabHelper.EnableDebugLogging(Enable: Boolean);
begin
  FDebugLog := Enable;
end;

procedure TIabHelper.FlagEndAsync;
begin
  FAsyncOperation := '';
  FAsyncInProgress := False;
end;

procedure TIabHelper.FlagStartAsync(const Operation: string);
begin
  if FAsyncInProgress then
    raise EIllegalStateException.CreateFmt(SAsyncInProgressError, [Operation, FAsyncOperation]);
  FAsyncOperation := Operation;
  FAsyncInProgress := True;
end;

function TIabHelper.GetResponseCodeFromBundle(const Bundle: JBundle): Integer;
var
  JO: JObject;
  JI: JInteger;
  JL: JLong;
begin
  JO := Bundle.get(ResponseKeyCode);
  if JO = nil then
    Exit(Integer(TIABResponseCode.Ok))
  else
  if JO.getClass.getName.equals(StringToJString('java.lang.Integer')) then
  begin
    JI := TJInteger.Wrap((JO as ILocalObject).GetObjectID);
    Exit(JI.intValue);
  end
  else
  if JO.getClass.getName.equals(StringToJString('java.lang.Long')) then
  begin
    JL := TJLong.Wrap((JO as ILocalObject).GetObjectID);
    Exit(JL.longValue);
  end
  else
    raise ERuntimeException.CreateFmt(SBadBundleResponseCodeType, [JStringToString(JO.getClass.getName)]);
end;

function TIabHelper.GetResponseCodeFromIntent(const Intent: JIntent): Integer;
var
  JO: JObject;
  JI: JInteger;
  JL: JLong;
begin
  JO := Intent.getExtras.get(ResponseKeyCode);
  if JO = nil then
    Exit(Integer(TIABResponseCode.Ok))
  else
  if JO.getClass.getName.equals(StringToJString('java.lang.Integer')) then
  begin
    JI := TJInteger.Wrap((JO as ILocalObject).GetObjectID);
    Exit(JI.intValue);
  end
  else
  if JO.getClass.getName.equals(StringToJString('java.lang.Long')) then
  begin
    JL := TJLong.Wrap((JO as ILocalObject).GetObjectID);
    Exit(JL.longValue);
  end
  else
    raise ERuntimeException.CreateFmt(SBadIntentResponseCodeType, [JStringToString(JO.GetClass.GetName)]);
end;

class function TIabHelper.GetResponseDesc(Code: TIABResponseCode): string;
const
  SIABMessages: array[TIabResponseCode] of String = (
    SOk,
    SUserCanceled,
    SBillingUnavailable,
    SItemUnavailable,
    SDeveloperError,
    SError,
    SItemAlreadyOwned,
    SItemNotOwned,
    SRemoteExceptionOccurred,
    SBadResponse,
    SVerificationFailed,
    SSendIntentFailed,
    SUnknownPurchaseResponse,
    SMissingToken,
    SUnknownError,
    SSubscriptionsNotAvailable,
    SInvalidConsumption
  );
begin
  Result := SIABMessages[Code];
end;

procedure TIabHelper.HandleActivityMessage(const Sender: TObject; const M: TMessage);
begin
  if M is TMessageResultNotification then
    HandleActivityResult(FRequestCode, TMessageResultNotification(M).ResultCode, TMessageResultNotification(M).Value);
end;

function TIabHelper.HandleActivityResult(RequestCode, ResultCode: Integer; const Data: JIntent): Boolean;
var
  IabResult: TIabResult;
  ResponseCode: TIABResponseCode;
  PurchaseData: string;
  DataSignature: string;
  Purchase: TPurchase;
  Sku: TSkuId;
begin
  if RequestCode <> FRequestCode then
    Exit(False);
  TMessageManager.DefaultManager.Unsubscribe(TMessageResultNotification, FMessageSubscriptionID);
  FMessageSubscriptionID := 0;
  CheckSetupDone('handleActivityResult');
  // end of async purchase operation
  FlagEndAsync;
  if Data = nil then
  begin
    IabResult := TIabResult.Create(TIABResponseCode.BadResponse, SNullInResultData);
    if Assigned(FPurchaseListener) then
      FPurchaseListener(IabResult, nil);
    Exit(True);
  end;
  ResponseCode := TIabResult.IntToResponseCode(GetResponseCodeFromIntent(Data));
  PurchaseData := JStringToString(Data.getStringExtra(ResponseKeyInAppPurchaseData));
  DataSignature := JStringToString(Data.getStringExtra(ResponseKeyInAppSignature));
  if (ResultCode = TJActivity.JavaClass.RESULT_OK) and (ResponseCode = TIABResponseCode.Ok) then
  begin
    if PurchaseData.IsEmpty or DataSignature.IsEmpty then
    begin
      IabResult := TIabResult.Create(TIABResponseCode.UnknownError, SNullReturn);
      if Assigned(FPurchaseListener) then
        FPurchaseListener(IabResult, nil);
      Exit(True);
    end;
    Purchase := nil;
    try
      Purchase := TPurchase.Create(FPurchasingItemKind, PurchaseData, DataSignature);
      Sku := Purchase.Sku;
      // Verify signature
      if not TJIAPSecurity.JavaClass.verifyPurchase(StringToJString(FBase64PublicKey), StringToJString(PurchaseData),
        StringToJString(DataSignature)) then
      begin
        IabResult := TIabResult.Create(TIABResponseCode.VerificationFailed, Format(SSignatureFailureFmt, [Sku]));
        if Assigned(FPurchaseListener) then
          FPurchaseListener(IabResult, Purchase);
        Exit(True);
      end;
    except
      on e: EJNIException do
      begin
        if e.ExceptionClassName.Equals(SJSONException) then
        begin
          IabResult := TIabResult.Create(TIABResponseCode.BadResponse, SPurchaseDataParse);
          if Assigned(FPurchaseListener) then
            FPurchaseListener(IabResult, nil);
          Exit(True);
        end
        else
          raise;
      end
    end;
    if Assigned(FPurchaseListener) then
      FPurchaseListener(TIabResult.Create(TIABResponseCode.Ok, SSuccess), Purchase);
  end
  else
  if ResultCode = TJActivity.JavaClass.RESULT_OK then
  begin
    // result code was OK, but in-app billing response was not OK.
    if Assigned(FPurchaseListener) then
    begin
      IabResult := TIabResult.Create(ResponseCode, SPurchaseProblem);
      FPurchaseListener(IabResult, nil);
    end
  end
  else
  if ResultCode = TJActivity.JavaClass.RESULT_CANCELED then
  begin
    IabResult := TIabResult.Create(TIABResponseCode.UserCancelled, SUserCanceled);
    if Assigned(FPurchaseListener) then
      FPurchaseListener(IabResult, nil);
  end
  else
  begin
    IabResult := TIabResult.Create(TIABResponseCode.UnknownPurchaseResponse, SUnknownPurchaseResponse);
    if Assigned(FPurchaseListener) then
      FPurchaseListener(IabResult, nil);
  end;
  Result := True;
end;

procedure TIabHelper.LaunchPurchaseFlow(const Sku: TSkuId; ItemKind: TProductKind; RequestCode: Integer;
  const Listener: TOnPurchaseFinished; const ExtraData: string);
var
  IabResult: TIabResult;
  BuyIntentBundle: JBundle;
  Response: TIABResponseCode;
  PendingIntent: JPendingIntent;
  Parcelable: JParcelable;
begin
  CheckSetupDone('launchPurchaseFlow');
  FlagStartAsync('launchPurchaseFlow');
  if (ItemKind = TProductKind.Subscription) and not FSubscriptionsSupported then
  begin
    IabResult := TIabResult.Create(TIABResponseCode.SubscriptionsNotAvailable, SNoSubscriptions);
    if Assigned(Listener) then
      Listener(IabResult, nil);
    FlagEndAsync;
    Exit;
  end;
  try
    BuyIntentBundle := FService.getBuyIntent(3, FContext.getPackageName, StringToJString(Sku),
      StringToJString(ProductKindToStr(ItemKind)), StringToJString(ExtraData));
    Response := TIabResult.IntToResponseCode(GetResponseCodeFromBundle(BuyIntentBundle));
    if Response <> TIABResponseCode.Ok then
    begin
      IabResult := TIabResult.Create(Response, SBuyFailure);
      if Assigned(Listener) then
        Listener(IabResult, nil);
      FlagEndAsync;
      Exit;
    end;
    //This was a generic call in Java. Not here though.
    //But we do need to be careful to keep the parcelable around as
    //long as the freshly wrapped pending intent needs to live
    Parcelable := BuyIntentBundle.getParcelable(ResponseKeyBuyIntent);
    PendingIntent := TJPendingIntent.Wrap((Parcelable as ILocalObject).GetObjectID);
    FRequestCode := RequestCode;
    // take a local copy of the listener object reference
    FPurchaseListener := Listener;
    FPurchasingItemKind := ItemKind;
    FMessageSubscriptionID := TMessageManager.DefaultManager.SubscribeToMessage(TMessageResultNotification, HandleActivityMessage);
    TAndroidHelper.Activity.startIntentSenderForResult(PendingIntent.getIntentSender, RequestCode, TJIntent.Create, 0, 0, 0);
  except
    on e: EJNIException do
    begin
      if e.ExceptionClassName.Equals(SSendIntentException) then
      begin
        FlagEndAsync;
        IabResult := TIabResult.Create(TIABResponseCode.SendIntentFailed, SIntentSendError);
        if Assigned(listener) then
          listener(IabResult, nil);
      end
      else if e.ExceptionClassName.Equals(SRemoteException) then
      begin
        FlagEndAsync;
        IabResult := TIabResult.Create(TIABResponseCode.RemoteException, SPurchaseFlowError);
        if Assigned(listener) then
          listener(IabResult, nil);
      end
      else
        raise;
    end;
  end
end;

procedure TIabHelper.LogDebug(const Msg: string);
var
  M: TMarshaller;
begin
  if FDebugLog then
    LOGI(M.AsAnsi(Msg).ToPointer);
end;

procedure TIabHelper.LogError(const Msg: string);
var
  M: TMarshaller;
begin
  LOGE(M.AsAnsi(Msg).ToPointer);
end;

procedure TIabHelper.LogWarn(const Msg: string);
var
  M: TMarshaller;
begin
  LOGW(M.AsAnsi(Msg).ToPointer);
end;

function TIabHelper.QueryInventory(ShouldQuerySkuDetails: Boolean; const MoreItemSkus,
  MoreSubsSkus: TList<TSkuId>): TInventory;
var
  Inventory: TInventory;
  Res: TIABResponseCode;
begin
  CheckSetupDone('queryInventory');
  try
    Inventory := TInventory.Create;
    Res := QueryPurchases(Inventory, TProductKind.InApp);
    if Res <> TIABResponseCode.Ok then
      raise EIabException.Create(Res, SInventoryRefreshOwnedItemsError);
    if ShouldQuerySkuDetails then
    begin
      Res := QuerySkuDetails(TProductKind.InApp, Inventory, MoreItemSkus);
      if Res <> TIABResponseCode.Ok then
        raise EIabException.Create(Res, SInventoryRefreshItemPricesError);
    end;
    // if subscriptions are supported, then also query for subscriptions
    if FSubscriptionsSupported then
    begin
      Res := QueryPurchases(Inventory, TProductKind.Subscription);
      if Res <> TIABResponseCode.Ok then
        raise EIabException.Create(Res, SInventoryRefreshOwnedSubsError);
      if ShouldQuerySkuDetails then
      begin
        //Google's code actually passes in MoreItemSkus again here
        Res := QuerySkuDetails(TProductKind.Subscription, Inventory, MoreSubsSkus);
        if Res <> TIABResponseCode.Ok then
          raise EIabException.Create(Res, SInventoryRefreshSubsPricesError)
      end
    end;
    Result := Inventory;
  except
    on e: EJNIException do
    begin
      if e.ExceptionClassName.Equals(SRemoteException) then
        raise EIabException.Create(TIABResponseCode.RemoteException, SInventoryRefreshRemoteError);
      if e.ExceptionClassName.Equals(SJSONException) then
        raise EIabException.Create(TIABResponseCode.BadResponse, SInventoryJSONError);
    end
  end
end;

var
  InvQueryRunnerThread: TThread;

procedure TIabHelper.QueryInventoryAsync(ShouldQuerySkuDetails: Boolean; const MoreSkus: TList<TSkuId>;
  const Listener: TOnQueryInventoryFinished);
begin
  CheckSetupDone('queryInventory');
  FlagStartAsync('refresh inventory');
  InvQueryRunnerThread := TThread.CreateAnonymousThread(procedure
    var
      FRes: TIabResult;
      FInv: TInventory;
    begin
      try
        FRes := TIabResult.Create(TIABResponseCode.Ok, SInventoryRefreshOK);
        try
          FInv := QueryInventory(ShouldQuerySkuDetails, MoreSkus, MoreSkus);
        except
          on e: EIabException do
            FRes := e.Result;
        end;
        FlagEndAsync;
        CallInUiThread(procedure
          begin
            if Assigned(Listener) then
              Listener(FRes, FInv);
          end);
      finally
        GetAndroidApp.activity.vm^.DetachCurrentThread(GetAndroidApp.activity.vm);
      end;
    end);
  InvQueryRunnerThread.Start;
end;

function TIabHelper.QueryPurchases(const Inv: TInventory; ItemKind: TProductKind): TIABResponseCode;
var
  VerificationFailed: Boolean;
  ContinueToken: JString;
  OwnedItems: JBundle;
  Response: TIABResponseCode;
  OwnedSkus: JArrayList;
  PurchaseDataList: JArrayList;
  SignatureList: JArrayList;
  I: Integer;
  PurchaseData: string;
  Signature: string;
  Sku: TSkuId;
  Purchase: TPurchase;
begin
  // Query purchases
  VerificationFailed := False;
  ContinueToken := nil;
  repeat
    OwnedItems := FService.getPurchases(3, FContext.getPackageName, StringToJString(ProductKindToStr(ItemKind)),
      ContinueToken);
    Response := TIabResult.IntToResponseCode(GetResponseCodeFromBundle(OwnedItems));
    if Response <> TIABResponseCode.Ok then
      Exit(Response);
    if (not OwnedItems.containsKey(ResponseKeyInAppItemList) or not OwnedItems.containsKey(ResponseKeyInAppPurchaseDataList) or
        not OwnedItems.containsKey(ResponseKeyInAppSignatureList)) then
      Exit(TIABResponseCode.BadResponse);
    OwnedSkus := OwnedItems.getStringArrayList(ResponseKeyInAppItemList);
    PurchaseDataList := OwnedItems.getStringArrayList(ResponseKeyInAppPurchaseDataList);
    SignatureList := OwnedItems.getStringArrayList(ResponseKeyInAppSignatureList);
    I := 0;
    while (PurchaseDataList <> nil) and (I < PurchaseDataList.size) do
    begin
      PurchaseData := JStringToString(JString(PurchaseDataList.get(I)));
      Signature := JStringToString(JString(SignatureList.get(I)));
      Sku := JStringToString(JString(OwnedSkus.get(I)));
      if TJIAPSecurity.JavaClass.verifyPurchase(StringToJString(FBase64PublicKey), StringToJString(PurchaseData),
        StringToJString(Signature)) then
      begin
        Purchase := TPurchase.Create(ItemKind, PurchaseData, Signature);
        // Record ownership and token
        Inv.AddPurchase(Purchase);
      end
      else
        VerificationFailed := True;
      Inc(I);
    end;
    ContinueToken := OwnedItems.getString(ResponeKeyInAppContinuationToken);
  until ContinueToken = nil;
  if VerificationFailed then
    Result := TIABResponseCode.VerificationFailed
  else
    Result := TIABResponseCode.Ok;
end;

function TIabHelper.QuerySkuDetails(ItemKind: TProductKind; const Inv: TInventory; const MoreSkus: TList<TSkuId>)
  : TIABResponseCode;
var
  SkuList: JArrayList;
  Sku: TSkuId;
  ThisResponse: string;
  I: Integer;
  QuerySkusBundle, SkuDetailsBundle: JBundle;
  SkuDetails: TSkuDetails;
  Response: TIABResponseCode;
  ResponseList: JArrayList;
begin
  SkuList := TJArrayList.Create;
  for Sku in Inv.GetAllOwnedSkus(ItemKind) do
    SkuList.add(StringToJString(Sku));
  if MoreSkus <> nil then
    for Sku in MoreSkus do
    begin
                                                             
      SkuList.add(StringToJString(Sku));
    end;
  if SkuList.size = 0 then
    Exit(TIABResponseCode.Ok);
  QuerySkusBundle := TJBundle.Create;
  QuerySkusBundle.putStringArrayList(GetSkuDetailsItemList, SkuList);
  SkuDetailsBundle := FService.getSkuDetails(3, FContext.getPackageName, StringToJString(ProductKindToStr(ItemKind)),
    QuerySkusBundle);
  if not SkuDetailsBundle.containsKey(ResponseKeySkuDetailsList) then
  begin
    Response := TIabResult.IntToResponseCode(GetResponseCodeFromBundle(SkuDetailsBundle));
    if Response <> TIABResponseCode.Ok then
      Exit(Response)
    else
      Exit(TIABResponseCode.BadResponse);
  end;
  ResponseList := SkuDetailsBundle.getStringArrayList(ResponseKeySkuDetailsList);
  for I := 0 to Pred(ResponseList.size) do
  begin
    ThisResponse := JStringToString(JString(ResponseList.get(I)));
    SkuDetails := TSkuDetails.Create(ItemKind, ThisResponse);
    Inv.AddSkuDetails(SkuDetails);
  end;
  Result := TIABResponseCode.Ok;
end;

procedure TIabHelper.StartSetup(const Listener: TOnSetupFinished);
var
  ServiceIntent: JIntent;
begin
  // If already set up, can't do it again.
  if FSetupDone then
    raise EIllegalStateException.Create('IAB helper is already set up.');

  // Connection to IAB service
  //FServiceConn := Self;
  FServiceConn := TJServiceConnection.Wrap((Self as ILocalObject).GetObjectID);
  FSetupFinishedListener := Listener;
  ServiceIntent := TJIntent.JavaClass.init(StringToJString('com.android.vending.billing.InAppBillingService.BIND'));
  ServiceIntent.setPackage(StringToJString('com.android.vending'));
  // Query whether anything has registered an intent filter to support IAB
  if not FContext.getPackageManager.queryIntentServices(serviceIntent, 0).isEmpty then
  begin
    // service available to handle that Intent
    FContext.bindService(serviceIntent, FServiceConn, TJContext.JavaClass.BIND_AUTO_CREATE);
  end
  else
    // no service available to handle that Intent
    if Assigned(Listener) then
      Listener(TIabResult.Create(TIABResponseCode.BillingUnavailable, SIABUnavailable));
end;

function TIabHelper.SubscriptionsSupported: Boolean;
begin
  Result := FSubscriptionsSupported;
end;

{$REGION 'JServiceConnection methods'}
procedure TIabHelper.onServiceConnected(Name: JComponentName; service: JIBinder);
var
  JPackageName: JString;
  PackageName: string;
  Response: TIABResponseCode;
  JProductKinds: array[TProductKind] of JString;
begin
  FService := TJIInAppBillingService_Stub.JavaClass.asInterface(service);
  JPackageName := FContext.getPackageName;
  JProductKinds[TProductKind.InApp] := StringToJString(ProductKindToStr(TProductKind.InApp));
  JProductKinds[TProductKind.Subscription] := StringToJString(ProductKindToStr(TProductKind.Subscription));
  PackageName := JStringToString(JPackageName);
  try
    // check for in-app billing v3 support
    Response := TIabResult.IntToResponseCode(FService.isBillingSupported(3, JPackageName, JProductKinds[TProductKind.InApp]));
    if Response <> TIABResponseCode.Ok then
    begin
      if Assigned(FSetupFinishedListener) then
        FSetupFinishedListener(TIabResult.Create(Response, SIABv3NotFound));
      // if in-app purchases aren't supported, neither are subscriptions.
      FSubscriptionsSupported := False;
      Exit
    end;
    // check for v3 subscriptions support
    Response := TIabResult.IntToResponseCode(FService.isBillingSupported(3, JPackageName, JProductKinds[TProductKind.Subscription]));
    if Response = TIABResponseCode.Ok then
      FSubscriptionsSupported := True;
    FSetupDone := True;
  except
    //TIDI: clean up JNI class name check
    on e: EJNIException do
    begin
      if e.ClassName.Equals(SRemoteException) then
      begin
        if Assigned(FSetupFinishedListener) then
          FSetupFinishedListener(
            TIabResult.Create(TIABResponseCode.RemoteException, sSetupException));
        Exit;
      end
      else
        raise;
    end
  end;
  if Assigned(FSetupFinishedListener) then
    FSetupFinishedListener(TIabResult.Create(TIABResponseCode.Ok, SSetupOK));
end;

procedure TIabHelper.onServiceDisconnected(Name: JComponentName);
begin
  FService := nil;
end;
{$ENDREGION}

{ TSkuDetails }

class constructor TSkuDetails.Create;
begin
  inherited;
  JProductID := StringToJString('productId');
  JType := StringToJString('type');
  JPrice := StringToJString('price');
  JTitle := StringToJString('title');
  JDescription := StringToJString('description')
end;

constructor TSkuDetails.Create(const JsonSkuDetails: string);
begin
  Create(TProductKind.InApp, JsonSkuDetails);
end;

constructor TSkuDetails.Create(ItemKind: TProductKind; const JsonSkuDetails: string);
var
  Json: JJSONObject;
begin
  FItemKind := ItemKind;
  FJson := JsonSkuDetails;
  Json := TJJSONObject.JavaClass.init(StringToJString(FJson));
  FSku := JStringToString(Json.optString(JProductID));
                                               
  FType := JStringToString(Json.optString(JType));
  FPrice := JStringToString(Json.optString(JPrice));
  FTitle := JStringToString(Json.optString(JTitle));
  FDescription := JStringToString(Json.optString(JDescription));
end;

function TSkuDetails.ToString: string;
begin
  Result := 'SkuDetails:' + FJson;
end;

{ TPurchase }

class constructor TPurchase.Create;
begin
  inherited;
  JOrderId := StringToJString('orderId');
  JPackageName := StringToJString('packageName');
  JSku := StringToJString('productId');
  JPurchaseTime := StringToJString('purchaseTime');
  JPurchaseState := StringToJString('purchaseState');
  JDeveloperPayload := StringToJString('developerPayload');
  JToken := StringToJString('token');
  JPurchaseToken := StringToJString('purchaseToken');
end;

constructor TPurchase.Create(ItemKind: TProductKind; const JsonPurchaseInfo, Signature: string);
var
  Json: JJSONObject;
begin
  FItemKind := ItemKind;
  FOriginalJson := JsonPurchaseInfo;
  Json := TJJSONObject.JavaClass.init(StringToJString(FOriginalJson));
  FOrderId := JStringToString(Json.optString(JOrderID));
  FPackageName := JStringToString(Json.optString(JPackageName));
  FSku := JStringToString(Json.optString(JSku));
  FPurchaseTime := IncMilliSecond(UnixDateDelta, Json.optLong(JPurchaseTime));
  FPurchaseState := TPurchaseState(Json.optInt(JPurchaseState));
  FDeveloperPayload := JStringToString(Json.optString(JDeveloperPayload));
  FToken := JStringToString(Json.optString(JToken, Json.optString(JPurchaseToken)));
  FSignature := signature;
end;

function TPurchase.ToString: string;
begin
  Result := Format('PurchaseInfo(type:%s):%s', [ProductKindToStr(FItemKind), FOriginalJson]);
end;

{ TInventory }

constructor TInventory.Create;
begin
  inherited;
  FSkuMap := TDictionary<TSkuId, TSkuDetails>.Create;
  FPurchaseMap := TDictionary<TSkuId, TPurchase>.Create;
end;

procedure TInventory.AddPurchase(const Purchase: TPurchase);
begin
  if not IsPurchased(Purchase.Sku) then
    FPurchaseMap.Add(Purchase.Sku, Purchase);
end;

procedure TInventory.AddSkuDetails(const SkuDetails: TSkuDetails);
begin
  if not HasDetails(SkuDetails.Sku) then
    FSkuMap.Add(SkuDetails.Sku, SkuDetails);
end;

procedure TInventory.ErasePurchase(const Sku: TSkuId);
begin
  if FPurchaseMap.ContainsKey(Sku) then
    FPurchaseMap.Remove(Sku);
end;

function TInventory.GetAllOwnedSkus(ItemKind: TProductKind): TList<TSkuId>;
var
  Purchase: TPurchase;
begin
  Result := TList<TSkuId>.Create;
  for Purchase in FPurchaseMap.values do
  begin
    if Purchase.ItemKind = ItemKind then
      Result.Add(Purchase.Sku);
  end;
end;

function TInventory.GetAllSkus: TList<TSkuId>;
var
  SkuID: TSkuID;
begin
  Result := TList<TSkuId>.Create;
  for SkuId in FSkuMap.Keys do
    Result.Add(SkuId);
end;

function TInventory.GetAllOwnedSkus: TList<TSkuId>;
var
  Key: TSkuId;
begin
  Result := TList<TSkuId>.Create;
  for Key in FPurchaseMap.Keys do
    Result.Add(Key);
end;

function TInventory.GetAllPurchases: TList<TPurchase>;
var
  Purchase: TPurchase;
begin
  Result := TList<TPurchase>.Create;
  for Purchase in FPurchaseMap.Values do
    Result.Add(Purchase);
end;

function TInventory.GetPurchase(const Sku: TSkuId): TPurchase;
begin
  FPurchaseMap.TryGetValue(Sku, Result);
end;

function TInventory.GetSkuDetails(const Sku: TSkuId): TSkuDetails;
begin
  FSkuMap.TryGetValue(Sku, Result);
end;

function TInventory.HasDetails(const Sku: TSkuId): Boolean;
begin
  Result := FSkuMap.ContainsKey(Sku);
end;

function TInventory.IsPurchased(const Sku: TSkuId): Boolean;
begin
  Result := FPurchaseMap.ContainsKey(Sku);
end;

{ TIabResult }

constructor TIabResult.Create(Response: TIABResponseCode; const Msg: String);
begin
  inherited Create;
  FResponse := Response;
  if Msg.Trim.IsEmpty then
    FMessage := TIabHelper.GetResponseDesc(Response)
  else
    FMessage := Msg + ' (response: ' + TIabHelper.GetResponseDesc(Response) + ')';
end;

function TIabResult.GetIsFailure: Boolean;
begin
  Result := not IsSuccess;
end;

function TIabResult.GetIsSuccess: Boolean;
begin
  Result := FResponse = TIABResponseCode.Ok;
end;

class function TIabResult.IntToResponseCode(Response: Integer): TIABResponseCode;
const
  // Billing response codes
  BILLING_RESPONSE_RESULT_OK = 0;
  BILLING_RESPONSE_RESULT_USER_CANCELED = 1;
  BILLING_RESPONSE_RESULT_BILLING_UNAVAILABLE = 3;
  BILLING_RESPONSE_RESULT_ITEM_UNAVAILABLE = 4;
  BILLING_RESPONSE_RESULT_DEVELOPER_ERROR = 5;
  BILLING_RESPONSE_RESULT_ERROR = 6;
  BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED = 7;
  BILLING_RESPONSE_RESULT_ITEM_NOT_OWNED = 8;
  // IAB Helper error codes
  IABHELPER_ERROR_BASE = -1000;
  IABHELPER_REMOTE_EXCEPTION = -1001;
  IABHELPER_BAD_RESPONSE = -1002;
  IABHELPER_VERIFICATION_FAILED = -1003;
  IABHELPER_SEND_INTENT_FAILED = -1004;
  IABHELPER_USER_CANCELLED = -1005;
  IABHELPER_UNKNOWN_PURCHASE_RESPONSE = -1006;
  IABHELPER_MISSING_TOKEN = -1007;
  IABHELPER_UNKNOWN_ERROR = -1008;
  IABHELPER_SUBSCRIPTIONS_NOT_AVAILABLE = -1009;
  IABHELPER_INVALID_CONSUMPTION = -1010;
begin
  case Response of
    BILLING_RESPONSE_RESULT_OK: Result := TIABResponseCode.Ok;
    BILLING_RESPONSE_RESULT_USER_CANCELED: Result := TIABResponseCode.UserCancelled;
    BILLING_RESPONSE_RESULT_BILLING_UNAVAILABLE: Result := TIABResponseCode.BillingUnavailable;
    BILLING_RESPONSE_RESULT_ITEM_UNAVAILABLE: Result := TIABResponseCode.ItemUnavailable;
    BILLING_RESPONSE_RESULT_DEVELOPER_ERROR: Result := TIABResponseCode.DeveloperError;
    BILLING_RESPONSE_RESULT_ERROR: Result := TIABResponseCode.Error;
    BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED: Result := TIABResponseCode.ItemAlreadyOwned;
    BILLING_RESPONSE_RESULT_ITEM_NOT_OWNED: Result := TIABResponseCode.ItemNotOwned;
    IABHELPER_REMOTE_EXCEPTION: Result := TIABResponseCode.RemoteException;
    IABHELPER_BAD_RESPONSE: Result := TIABResponseCode.BadResponse;
    IABHELPER_VERIFICATION_FAILED: Result := TIABResponseCode.VerificationFailed;
    IABHELPER_SEND_INTENT_FAILED: Result := TIABResponseCode.SendIntentFailed;
    IABHELPER_USER_CANCELLED: Result := TIABResponseCode.UserCancelled;
    IABHELPER_UNKNOWN_PURCHASE_RESPONSE: Result := TIABResponseCode.UnknownPurchaseResponse;
    IABHELPER_MISSING_TOKEN: Result := TIABResponseCode.MissingToken;
    IABHELPER_UNKNOWN_ERROR: Result := TIABResponseCode.UnknownError;
    IABHELPER_SUBSCRIPTIONS_NOT_AVAILABLE: Result := TIABResponseCode.SubscriptionsNotAvailable;
    IABHELPER_INVALID_CONSUMPTION: Result := TIABResponseCode.InvalidConsumption;
  else
    Result := TIABResponseCode.UnknownError;
  end;
end;

function TIabResult.ToString: String;
begin
  Result := 'IabResult: ' + Message;
end;

{ EIabException }

constructor EIabException.Create(const R: TIabResult);
begin
  inherited Create(R.Message);
end;

constructor EIabException.Create(Response: TIABResponseCode; const AMessage: String);
begin
  Create(TIabResult.Create(Response, AMessage));
end;


{$REGION 'TAndroidInAppPurchaseService'}
constructor TAndroidInAppPurchaseService.Create;
begin
  inherited;
  FComponents := TList<TCustomInAppPurchase>.Create;
  FHelper := TiabHelper.Create;
{$IFDEF DEBUG}
  FHelper.EnableDebugLogging(True);
{$ENDIF}
  FHelper.startSetup(DoSetupComplete);
end;

destructor TAndroidInAppPurchaseService.Destroy;
begin
  FHelper.Dispose;
  FHelper := nil;
  while FComponents.Count > 0 do
    FComponents.Delete(0);
  FComponents := nil;
  if FComponentsPendingSetupCompleteEvent <> nil then
    while FComponentsPendingSetupCompleteEvent.Count > 0 do
      FComponentsPendingSetupCompleteEvent.Delete(0);
  FComponentsPendingSetupCompleteEvent := nil;
  inherited;
end;

{$REGION 'TIABHelper callbacks'}
procedure TAndroidInAppPurchaseService.DoSetupComplete(const IabResult: TIabResult);
var
  Component: TCustomInAppPurchase;
begin
  if IabResult.IsFailure then
    raise EIAPException.CreateFmt('%s: %s', [SIAPSetupProblem, IabResult.ToString]);
  FSetupIsComplete := True;
  if Assigned(FComponentsPendingSetupCompleteEvent) then
  begin
    for Component in FComponentsPendingSetupCompleteEvent do
      if Supports(Component, IInAppPurchaseCallbacks) then
        IInAppPurchaseCallbacks(Component).DoSetupComplete;
    while FComponentsPendingSetupCompleteEvent.Count > 0 do
      FComponentsPendingSetupCompleteEvent.Delete(0);
    FComponentsPendingSetupCompleteEvent := nil;
  end;
end;

procedure TAndroidInAppPurchaseService.DoQueryInventoryFinished(const IabResult: TIabResult;
  const Inventory: TInventory);
var
  SkuId: TSkuId;
  SkuIds: TList<TSkuId>;
  Products: TIAPProductList;
begin
  if (IabResult <> nil) and IabResult.IsSuccess then
  begin
    FInventory := Inventory;
    SkuIds := Inventory.GetAllSkus;
    Products := TIAPProductList.Create;
    for SkuId in SkuIds do
      Products.Add(SkuDetailsToProduct(Inventory.SkuDetails[SkuId]));
                                                                                  
    DoProductsRequestResponse(Products, nil);
  end
  else if IabResult <> nil then
    DoError(TFailureKind.ProductsRequest, IabResult.ToString)
  else
    DoError(TFailureKind.ProductsRequest, '');
end;

procedure TAndroidInAppPurchaseService.DoPurchaseFinished(const IabResult: TIabResult; const Purchase: TPurchase);
begin
  if IabResult.IsSuccess then
  begin
    //If we've a payload on the purchase, ensure it checks out before completing
    if not Purchase.DeveloperPayload.IsEmpty then
    begin
      if not DoVerifyPayload(Purchase) then
      begin
        DoError(TFailureKind.Purchase, SIAPPayloadVerificationFailed);
        Exit;
      end;
    end;
    FInventory.AddPurchase(Purchase);
    DoPurchaseCompleted(Purchase.Sku, True);
    DoRecordTransaction(Purchase.Sku, Purchase.Token, Purchase.PurchaseTime);
  end
  else
    DoError(TFailureKind.Purchase, IabResult.ToString);
end;

procedure TAndroidInAppPurchaseService.DoConsumeFinished(const Purchase: TPurchase; const IabResult: TIabResult);
var
  Component: TCustomInAppPurchase;
begin
  // Once consumed, the product is no longer considered owned,
  // and so can be purchased again
  if FInventory <> nil then
    FInventory.ErasePurchase(Purchase.Sku);
  //Now tell all the components it has been consumed
  for Component in FComponents do
    if Supports(Component, IInAppPurchaseCallbacks) then
    begin
      if IabResult.IsSuccess then
        IInAppPurchaseCallbacks(Component).DoConsumeCompleted(Purchase.Sku)
      else
        IInAppPurchaseCallbacks(Component).DoConsumeFailed(Purchase.Sku, IabResult.ToString);
    end;
end;

procedure TAndroidInAppPurchaseService.DoConsumeMultiFinished(const Purchases: TList<TPurchase>;
  const Results: TList<TIabResult>);
var
  Purchase: TPurchase;
  Component: TCustomInAppPurchase;
  I: Integer;
begin
  if Purchases.Count <> Results.Count then
    raise EIAPException.Create(SIAPIllegalArguments);
  // Once consumed, the product is no longer considered owned,
  // and so can be purchased again
  if FInventory <> nil then
    for Purchase in Purchases do
      FInventory.ErasePurchase(Purchase.Sku);
  //Now tell all the components it has been consumed
  for Component in FComponents do
    if Supports(Component, IInAppPurchaseCallbacks) then
    begin
      for I := 0 to Pred(Purchases.Count) do
        if Results[I].IsSuccess then
          IInAppPurchaseCallbacks(Component).DoConsumeCompleted(Purchases[I].Sku)
        else
          IInAppPurchaseCallbacks(Component).DoConsumeFailed(Purchases[I].Sku, Results[I].ToString);
    end;
end;
{$ENDREGION 'IABHelper callbacks'}

function TAndroidInAppPurchaseService.DoVerifyPayload(Purchase: TPurchase): Boolean;
var
  Component: TCustomInAppPurchase;
begin
  Result := True;
  for Component in FComponents do
    if Supports(Component, IInAppPurchaseCallbacks) then
    begin
      IInAppPurchaseCallbacks(Component).DoVerifyPayload(Purchase.DeveloperPayload, Result);
      if not Result then
        Break;
    end;
end;

procedure TAndroidInAppPurchaseService.DoProductsRequestResponse(const Products: TIAPProductList;
  const InvalidProductIDs: TStrings);
var
  Component: TCustomInAppPurchase;
begin
  for Component in FComponents do
    if Supports(Component, IInAppPurchaseCallbacks) then
      IInAppPurchaseCallbacks(Component).DoProductsRequestResponse(Products, InvalidProductIDs);
end;

procedure TAndroidInAppPurchaseService.DoError(FailureKind: TFailureKind; const ErrorMessage: string);
var
  Component: TCustomInAppPurchase;
begin
  for Component in FComponents do
    if Supports(Component, IInAppPurchaseCallbacks) then
      IInAppPurchaseCallbacks(Component).DoError(FailureKind, ErrorMessage);
end;

procedure TAndroidInAppPurchaseService.DoPurchaseCompleted(const ProductID: string; NewTransaction: Boolean);
var
  Component: TCustomInAppPurchase;
begin
  for Component in FComponents do
    if Supports(Component, IInAppPurchaseCallbacks) then
      IInAppPurchaseCallbacks(Component).DoPurchaseCompleted(ProductID, NewTransaction);
end;

procedure TAndroidInAppPurchaseService.DoRecordTransaction(const ProductID, TransactionID: string;
  TransactionDate: TDateTime);
var
  Component: TCustomInAppPurchase;
begin
  for Component in FComponents do
    if Supports(Component, IInAppPurchaseCallbacks) then
      IInAppPurchaseCallbacks(Component).DoRecordTransaction(ProductID, TransactionID, TransactionDate);
end;

{$REGION 'IFMXInAppPurchaseService methods'}

procedure TAndroidInAppPurchaseService.AddComponent(const Component: TCustomInAppPurchase);
begin
  if not FComponents.Contains(Component) then
    FComponents.Add(Component);
end;

procedure TAndroidInAppPurchaseService.RemoveComponent(const Component: TCustomInAppPurchase);
begin
  if Component <> nil then
    FComponents.Remove(Component);
end;

procedure TAndroidInAppPurchaseService.SetupInAppPurchase(Component: TCustomInAppPurchase);
begin
  //If setup has already been done just trigger the event, otherwise add
  //component into a pending list to notify later on setup completion
  if Supports(Component, IInAppPurchaseCallbacks) then
  begin
    if FSetupIsComplete then
        IInAppPurchaseCallbacks(Component).DoSetupComplete
    else
    begin
      if FComponentsPendingSetupCompleteEvent = nil then
        FComponentsPendingSetupCompleteEvent := TList<TCustomInAppPurchase>.Create;
      FComponentsPendingSetupCompleteEvent.Add(Component);
    end
  end;
end;

function TAndroidInAppPurchaseService.CanMakeInAppPurchases: Boolean;
begin
  Result := FSetupIsComplete;
end;

procedure TAndroidInAppPurchaseService.CheckApplicationLicenseKey;
begin
  if ApplicationLicenseKey.IsEmpty then
    raise EIAPNoLicenseKey.Create(SIAPNoLicenseKey);
end;

function TAndroidInAppPurchaseService.GetApplicationLicenseKey: string;
begin
  if FHelper <> nil then
    Result := FHelper.Base64PublicKey;
end;

function TAndroidInAppPurchaseService.GetTransactionPayload: string;
begin
  Result := FTransactionPayload;
end;

function TAndroidInAppPurchaseService.IsProductPurchased(const ProductID: string): Boolean;
begin
  Result := False;
  if FInventory <> nil then
    Result := FInventory.IsPurchased(ProductID);
end;

procedure TAndroidInAppPurchaseService.PurchaseProduct(const ProductID: string);
begin
  CheckApplicationLicenseKey;
  if IsProductPurchased(ProductID) then
    raise EIAPException.Create(SIAPAlreadyPurchased);
  //The docs say it must be called in the UI Thread, so...
  CallInUiThread(procedure
    begin
      FHelper.LaunchPurchaseFlow(ProductID, TProductKind.InApp, InAppPurchaseRequestCode,
        DoPurchaseFinished, FTransactionPayload);
    end);
end;

procedure TAndroidInAppPurchaseService.ConsumeProduct(const ProductID: string);
var
  Purchase: TPurchase;
begin
  CheckApplicationLicenseKey;
  if IsProductPurchased(ProductID) then
  begin
    Purchase := FInventory.Purchases[ProductID];
    FHelper.ConsumeAsync(Purchase, DoConsumeFinished);
  end;
end;

procedure TAndroidInAppPurchaseService.ConsumeProducts(const ProductIDs: TStrings);
var
  ProductID: string;
  Purchases: TList<TPurchase>;
begin
  CheckApplicationLicenseKey;
  Purchases := TList<TPurchase>.Create;
  for ProductID in ProductIDs do
    if IsProductPurchased(ProductID) then
      Purchases.Add(FInventory.Purchases[ProductID]);
  if Purchases.Count > 0 then
    FHelper.ConsumeAsync(Purchases, DoConsumeMultiFinished);
end;

procedure TAndroidInAppPurchaseService.QueryProducts(const ProductIDs: TStrings);
var
  Skus: TList<TSkuId>;
  ProductID: string;
begin
  Skus := TList<TSkuId>.Create;
  for ProductID in ProductIDs do
    Skus.Add(ProductID);
  FHelper.queryInventoryAsync(True, Skus, DoQueryInventoryFinished);
end;

procedure TAndroidInAppPurchaseService.RestorePurchasedProducts;
begin
  CheckApplicationLicenseKey;
  //On Android the restore functionality is irrelevant thanks to the inventory
  //system automatically identifying which products have been purchased
end;

procedure TAndroidInAppPurchaseService.SetApplicationLicenseKey(const Value: string);
begin
  if FHelper <> nil then
    FHelper.Base64PublicKey := Value;
end;

procedure TAndroidInAppPurchaseService.SetTransactionPayload(const Value: string);
begin
  FTransactionPayload := Value;
end;
{$ENDREGION 'IFMXInAppPurchaseService methods'}
{$ENDREGION 'TAndroidInAppBillingService'}

//var
//  NativeMethodIsRegistered: Boolean = False;

procedure RegisterInAppPurchaseService;
begin
  InAppPurchaseService := TAndroidInAppPurchaseService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXInAppPurchaseService, InAppPurchaseService);
//  if not NativeMethodIsRegistered then
//  begin
//    RegisterDelphiNativeMethod;
//    NativeMethodIsRegistered := True;
//  end;
end;

procedure UnRegisterInAppPurchaseService;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXInAppPurchaseService);
  InAppPurchaseService := nil;
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TProductKind), ['pkInApp', 'pkSubscription']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TProductKind));
end;

initialization
  RegisterAliases;

finalization
  UnregisterAliases;
end.
