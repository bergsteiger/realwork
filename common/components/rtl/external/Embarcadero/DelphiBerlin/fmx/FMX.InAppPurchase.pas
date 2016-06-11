{*******************************************************}
{                                                       }
{           Delphi FireMonkey Mobile Services           }
{                                                       }
{       Description of interface for in-app purchasing  }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.InAppPurchase;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Generics.Collections, System.Classes;

type
  EIAPException = class(Exception);

  EIAPNotSetup = class(EIAPException);

  EIAPNoLicenseKey = class(EIAPException);

  TCustomInAppPurchase = class;

  TDownloadLengths = array of Int64;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A class to represent a product accessible through In-App Purchase
  ///	</summary>
  {$ENDREGION}
  TProduct = class
  private
    FProductID: string;
    FPrice: Double;
    FLocalizedPrice: string;
    FLocalizedTitle: string;
    FLocalizedDescription: string;
    FDownloadable: Boolean;
    FDownloadContentLengths: TDownloadLengths;
    FDownloadContentVersion: string;
  public
    // Android supplies just a localized price string, not an actual value
    // so on Android the Price property will have this constant as a value
    const PriceNotAvailable = -1;
    constructor Create(const ProductID: string; Price: Double;
      const LocalizedPrice, LocalizedTitle, LocalizedDescription: string;
      Downloadable: Boolean; const DownloadContentLengths: TDownloadLengths;
      DownloadContentVersion: string);
    property ProductID: string read FProductID;
    property Price: Double read FPrice;
    property LocalizedPrice: string read FLocalizedPrice;
    property LocalizedTitle: string read FLocalizedTitle;
    property LocalizedDescription: string read FLocalizedDescription;
    property Downloadable: Boolean read FDownloadable;
    property DownloadContentLengths: TDownloadLengths
      read FDownloadContentLengths;
    property DownloadContentVersion: string read FDownloadContentVersion;
  end;

                       

  TFailureKind = (ProductsRequest, Purchase);

  // This type is used by the OnProductsRequestResponse event handler below. The
  // type alias is used to help C++ work with a published generic.
  TIAPProductList = class(TList<TProduct>)
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to communicate the response back after calling
  ///	  RequestProducts, including a list of product objects and a list of
  ///	  invalid product IDs
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="Products">
  ///	  Valid products, a generic list of TProduct objects
  ///	</param>
  ///	<param name="InvalidProductIDs">
  ///	  A list of the product IDs found to be invalid
  ///	</param>
  ///	<seealso cref="TCustomInAppPurchase.RequestProducts">
  ///	  RequestProducts
  ///	</seealso>
  {$ENDREGION}
  TIAPProductsRequestResponseEvent = procedure(Sender: TObject;
    const Products: TIAPProductList; const InvalidProductIDs: TStrings) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to communicate the response back after calling
  ///	  RequestProducts, including a list of product objects and a list of
  ///	  invalid product IDs
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="Payload">
  ///	  The payload string to verify for this user
  ///	</param>
  ///	<param name="PayloadOk">
  ///	  A reference parameter so you can indicate if the payload is not OK. It
  ///	  defaults to True; set to False to indicate a payload issue.
  ///	</param>
  {$ENDREGION}
  TIAPVerifyPayloadEvent = procedure(Sender: TObject; const Payload: String;
    var PayloadOk: Boolean) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to communicate download progress when downloading associated
  ///	  content for a product purchase
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="ProductID">
  ///	  The product whose content is being downloaded
  ///	</param>
  ///	<param name="ContentID">
  ///	  The content being downloaded
  ///	</param>
  ///	<param name="TimeRemaining">
  ///	  Time remaining in seconds, or -1 if the download is still preparing to
  ///	  start (progress is still 0)
  ///	</param>
  ///	<param name="Progress">
  ///	  Download progress between 0.0 and 1.0
  ///	</param>
  {$ENDREGION}
  TIAPDownloadProgressEvent = procedure(Sender: TObject;
    const ProductID, ContentID: string; TimeRemaining: Double; Progress: Single)
    of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to communicate download completion when downloading
  ///	  associated content for a product purchase. The ProductID argument
  ///	  identifies the product and the ContentID argument identifies what is
  ///	  being downloaded. FilePath gives the path to the downloaded content
  ///	  file.
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="ProductID">
  ///	  The product whose content is being downloaded
  ///	</param>
  ///	<param name="ContentID">
  ///	  The content being downloaded
  ///	</param>
  ///	<param name="FilePath">
  ///	  The path to the downloaded content
  ///	</param>
  {$ENDREGION}
  TIAPDownloadCompletedEvent = procedure(Sender: TObject;
    const ProductID, ContentID, FilePath: string) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to indicate purchase completion
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="ProductID">
  ///	  The product that was successfully purchased
  ///	</param>
  ///	<param name="NewTransaction">
  ///	  True is this was a new purchase or False if it was a restored historic
  ///	  purchase
  ///	</param>
  ///	<remarks>
  ///	  The app should ensure it provides the content at this point as the
  ///	  purchase has now been made
  ///	</remarks>
  {$ENDREGION}
  TIAPPurchaseCompletedEvent = procedure(Sender: TObject;
    const ProductID: string; NewTransaction: Boolean) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to allow a successful transaction to be recorded for audit
  ///	  purposes
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="ProductID">
  ///	  The product purchased in this transaction
  ///	</param>
  ///	<param name="TransactionID">
  ///	  The transaction ID
  ///	</param>
  ///	<param name="TransactionDate">
  ///	  The UTC transaction date
  ///	</param>
  {$ENDREGION}
  TIAPRecordTransactionEvent = procedure(Sender: TObject; const ProductID,
    TransactionID: string; TransactionDate: TDateTime) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to indicate consumption of a product was successful
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="ProductID">
  ///	  The product that was consumed
  ///	</param>
  {$ENDREGION}
  TIAPConsumeCompletedEvent = procedure(Sender: TObject;
    const ProductID: string) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to indicate consumption of a product was unsuccessful
  ///	</summary>
  ///	<param name="Sender">
  ///	  The In-App Purchase component
  ///	</param>
  ///	<param name="ProductID">
  ///	  The product that failed to be consumed
  ///	</param>
  ///	<param name="ErrorMessage">
  ///	  The error message regarding the failure
  ///	</param>
  {$ENDREGION}
  TIAPConsumeFailedEvent = procedure(Sender: TObject; const ProductID,
    ErrorMessage: string) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Event type to communicate some sort of failure
  ///	</summary>
  ///	<param name="Sender">
  ///	  The event's sender
  ///	</param>
  ///	<param name="ErrorKind">
  ///	  The type of error reported by this event
  ///	</param>
  ///	<param name="ErrorMessage">
  ///	  The localized error message, if any was available
  ///	</param>
  {$ENDREGION}
  TIAPErrorEvent = procedure(Sender: TObject; ErrorKind: TFailureKind;
    const ErrorMessage: string) of object;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  FireMonkey service for In-App Purchasing
  ///	</summary>
  {$ENDREGION}
  IFMXInAppPurchaseService = interface(IInterface)
    ['{D49D5CE3-136A-47A7-8243-FD929AD0FF29}']

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Add the In-App Purchase component to the list of such components
    ///	  managed by the IFMXInAppPurchaseService implementation.
    ///	</summary>
    {$ENDREGION}
    procedure AddComponent(const Component: TCustomInAppPurchase);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Removes the specified In-App Purchase component from the list of such
    ///	  components managed by the IFMXInAppPurchaseService implementation.
    ///	</summary>
    {$ENDREGION}
    procedure RemoveComponent(const Component: TCustomInAppPurchase);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Bind the component to the platform In-App Purchase service. Until the
    ///	  service is setup the various methods of the component will not be
    ///	  usable. When the setup in done the <see cref="OnSetupComplete" />
    ///	  event fires.
    ///	</summary>
    ///	<param name="Component">
    ///	  The component that requires notification when setup is complete.
    ///	</param>
    ///	<remarks>
    ///	  On iOS the setup is instantaneous. On Android it takes a while for
    ///	  the component to bind to the underlying Google Play In-App Billing
    ///	  service.
    ///	</remarks>
    ///	<seealso cref="OnSetupComplete">
    ///	  TCustomInAppPurchase.OnSetupComplete
    ///	</seealso>
    {$ENDREGION}
    procedure SetupInAppPurchase(Component: TCustomInAppPurchase);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Check if In-App Purchasing is currently enabled
    ///	</summary>
    ///	<returns>
    ///	  True if In-App Purchasing is available, otherwise False
    ///	</returns>
    {$ENDREGION}
    function CanMakeInAppPurchases: Boolean;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Initiates a request to the online store to retrieve information on
    ///	  which of the product IDs in the component's ProductIDs property are
    ///	  valid and available (and which are invalid).
    ///	</summary>
    ///	<remarks>
    ///	  Information comes back via the component's OnProductsRequest and
    ///	  OnProductsError events.
    ///	</remarks>
    ///	<seealso cref="IFMXIAPService.OnProductsRequest">
    ///	  OnProductsRequest event property
    ///	</seealso>
    ///	<seealso cref="IFMXIAPService.OnProductsError">
    ///	  OnProductsError event property
    ///	</seealso>
    {$ENDREGION}
    procedure QueryProducts(const ProductIDs: TStrings);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Checks if the product identified by the ProductID parameter has been
    ///	  purchased
    ///	</summary>
    ///	<param name="ProductID">
    ///	  The product identifier to check
    ///	</param>
    ///	<returns>
    ///	  True if product has been purchased, False otherwise
    ///	</returns>
    {$ENDREGION}
    function IsProductPurchased(const ProductID: string): Boolean;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Purchase a product identified by the specified product ID
    ///	</summary>
    ///	<param name="ProductID">
    ///	  The product identifier of the product you wish to purchase
    ///	</param>
    ///	<remarks>
    ///	  This is one of two overloads of PurchaseProduct
    ///	</remarks>
    {$ENDREGION}
    procedure PurchaseProduct(const ProductID: string);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Consume a product identified by the specified product ID
    ///	</summary>
    ///	<param name="ProductID">
    ///	  The product identifier of the product you wish to consume
    ///	</param>
    {$ENDREGION}
    procedure ConsumeProduct(const ProductID: string);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Consume products identified by the specified product IDs
    ///	</summary>
    ///	<param name="ProductIDs">
    ///	  The product identifiers of the products you wish to consume
    ///	</param>
    {$ENDREGION}
    procedure ConsumeProducts(const ProductIDs: TStrings);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Allows previously purchased products to be restored. This is useful
    ///	  when installing an app after uninstalling it when purchases have been
    ///	  made, or when installing on an additional device.
    ///	</summary>
    ///	<remarks>
    ///	  Note that this restores non-consumable products. Consumable products
    ///	  will not be restored.
    ///	</remarks>
    {$ENDREGION}
    procedure RestorePurchasedProducts;

    function GetApplicationLicenseKey: string;
    procedure SetApplicationLicenseKey(const Value: string);

    property ApplicationLicenseKey: string read GetApplicationLicenseKey
      write SetApplicationLicenseKey;

    function GetTransactionPayload: string;
    procedure SetTransactionPayload(const Value: string);

    property TransactionPayload: string read GetTransactionPayload
      write SetTransactionPayload;
  end;

  IInAppPurchaseCallbacks = interface
  ['{855557FC-1EE0-4295-8CFD-819D4BF21808}']
    procedure DoSetupComplete;
    procedure DoProductsRequestResponse(const Products: TIAPProductList; const InvalidProductIDs: TStrings);
    procedure DoError(FailureKind: TFailureKind; const ErrorMessage: string);
    procedure DoVerifyPayload(const Payload: String; var PayloadOk: Boolean);
    procedure DoPurchaseCompleted(const ProductID: string; NewTransaction: Boolean);
    procedure DoRecordTransaction(const ProductID, TransactionID: string; TransactionDate: TDateTime);
    procedure DoDownloadProgress(const ProductID, ContentID: string; TimeRemaining: Double; Progress: Single);
    procedure DoDownloadCompleted(const ProductID, ContentID, FilePath: string);
    procedure DoConsumeCompleted(const ProductID: string);
    procedure DoConsumeFailed(const ProductID, ErrorMessage: string);
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  FireMonkey In-App Purchase component base class
  ///	</summary>
  ///	<remarks>
  ///	  This is a non-visual component wrapper for IFMXInAppPurchaseService
  ///	</remarks>
  {$ENDREGION}
  TCustomInAppPurchase = class(TComponent, IInAppPurchaseCallbacks)
  private
    FProductIDs: TStrings;
    FIsSetupComplete: Boolean;
    FInAppPurchaseService: IFMXInAppPurchaseService;
    FOnSetupComplete: TNotifyEvent;
    FOnProductsRequestResponse: TIAPProductsRequestResponseEvent;
    FOnError: TIAPErrorEvent;
    FOnVerifyPayload: TIAPVerifyPayloadEvent;
    FOnDownloadProgress: TIAPDownloadProgressEvent;
    FOnDownloadCompleted: TIAPDownloadCompletedEvent;
    FOnPurchaseCompleted: TIAPPurchaseCompletedEvent;
    FOnRecordTransaction: TIAPRecordTransactionEvent;
    FOnConsumeCompleted: TIAPConsumeCompletedEvent;
    FOnConsumeFailed: TIAPConsumeFailedEvent;
    //Ensures IAP service has been setup first
    procedure CheckInAppPurchaseIsSetup;
    procedure SetProductIDs(const Value: TStrings);
    function GetApplicationLicenseKey: string;
    procedure SetApplicationLicenseKey(const Value: string);
    function GetTransactionPayload: string;
    procedure SetTransactionPayload(const Value: string);
  protected
    { IInAppPurchaseCallbacks }
    procedure DoSetupComplete;
    procedure DoProductsRequestResponse(const Products: TIAPProductList; const InvalidProductIDs: TStrings);
    procedure DoError(FailureKind: TFailureKind; const ErrorMessage: string);
    procedure DoVerifyPayload(const Payload: String; var PayloadOk: Boolean);
    procedure DoPurchaseCompleted(const ProductID: string; NewTransaction: Boolean);
    procedure DoRecordTransaction(const ProductID, TransactionID: string; TransactionDate: TDateTime);
    procedure DoDownloadProgress(const ProductID, ContentID: string; TimeRemaining: Double; Progress: Single);
    procedure DoDownloadCompleted(const ProductID, ContentID, FilePath: string);
    procedure DoConsumeCompleted(const ProductID: string);
    procedure DoConsumeFailed(const ProductID, ErrorMessage: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Bind the component to the platform In-App Purchase service. Until the
    ///	  service is setup the various methods of the component will not be
    ///	  usable. When the setup in done the <see cref="OnSetupComplete" />
    ///	  event fires.
    ///	</summary>
    ///	<remarks>
    ///	  On iOS the setup is instantaneous. On Android it takes a while for
    ///	  the component to bind to the underlying Google Play In-App Billing
    ///	  service.
    ///	</remarks>
    ///	<seealso cref="OnSetupComplete">
    ///	  TCustomInAppPurchase.OnSetupComplete
    ///	</seealso>
    {$ENDREGION}
    procedure SetupInAppPurchase;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Check if In-App Purchasing is currently enabled
    ///	</summary>
    ///	<returns>
    ///	  True if In-App Purchasing is available, otherwise False
    ///	</returns>
    ///	<remarks>
    ///	  In-App Purchasing may not be available if device settings prohibit
    ///	  it, or if In-App Purchasing setup has not yet completed (see
    ///	  <see cref="SetupInAppPurchase" />).
    ///	</remarks>
    ///	<seealso cref="SetupInAppPurchase">
    ///	  TCustomInAppPurchase.SetupInAppPurchase
    ///	</seealso>
    ///	<seealso cref="OnSetupComplete">
    ///	  TCustomInAppPurchase.OnSetupComplete
    ///	</seealso>
    ///	<seealso cref="SetupIsComplete">
    ///	  TCustomInAppPurchase.SetupIsComplete
    ///	</seealso>
    {$ENDREGION}
    function CanMakeInAppPurchases: Boolean;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Initiates a request to the online store to retrieve information on
    ///	  which of the product IDs in the component's ProductIDs property are
    ///	  valid and available (and which are invalid).
    ///	</summary>
    ///	<remarks>
    ///	  Information comes back via the component's
    ///	  <see cref="OnProductsRequest" /> and
    ///	  <see cref="OnProductsRequestError" /> events.
    ///	</remarks>
    ///	<seealso cref="OnProductsRequestResponse">
    ///	  OnProductsRequestResponse event property
    ///	</seealso>
    ///	<seealso cref="OnProductsRequestError">
    ///	  OnProductsRequestError event property
    ///	</seealso>
    {$ENDREGION}
    procedure QueryProducts;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Checks if the product identified by the ProductID parameter has been
    ///	  purchased
    ///	</summary>
    ///	<param name="ProductID">
    ///	  The product identifier to check
    ///	</param>
    ///	<returns>
    ///	  True if product has been purchased, False otherwise
    ///	</returns>
    {$ENDREGION}
    function IsProductPurchased(const ProductID: string): Boolean;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Purchase a product identified by the specified product ID
    ///	</summary>
    ///	<param name="ProductID">
    ///	  The product identifier of the product you wish to purchase
    ///	</param>
    ///	<remarks>
    ///	  This is one of two overloads of PurchaseProduct
    ///	</remarks>
    {$ENDREGION}
    procedure PurchaseProduct(const ProductID: string);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Consume a product identified by the specified product ID
    ///	</summary>
    ///	<param name="ProductID">
    ///	  The product identifier of the product you wish to consume
    ///	</param>
    {$ENDREGION}
    procedure ConsumeProduct(const ProductID: string);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Consume products identified by the specified product IDs
    ///	</summary>
    ///	<param name="ProductIDs">
    ///	  The product identifiers of the products you wish to consume
    ///	</param>
    {$ENDREGION}
    procedure ConsumeProducts(const ProductIDs: TStrings);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Allows previously purchased products to be restored. This is useful
    ///	  when installing an app after uninstalling it when purchases have been
    ///	  made, or when installing on an additional device.
    ///	</summary>
    ///	<remarks>
    ///	  Note that this restores non-consumable products. Consumable products
    ///	  will not be restored.
    ///	</remarks>
    {$ENDREGION}
    procedure RestorePurchasedProducts;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  <para>
    ///	    The Base64-encoded RSA public licensing key for the app when
    ///	    targeting the Android mobile platform (this value is not required
    ///	    for iOS).
    ///	  </para>
    ///	  <para>
    ///	    This is used for verification of purchase signatures. You can find
    ///	    your app's Base64-encoded public key in your application's page on
    ///	    Google Play Developer Console. Note that this is NOT your
    ///	    "developer public key"
    ///	  </para>
    ///	</summary>
    ///	<remarks>
    ///	  <para>
    ///	    To keep your public key safe from malicious users and hackers, do
    ///	    not store it directly in this property at design-time other than
    ///	    for testing purposes.
    ///	  </para>
    ///	  <para>
    ///	    Instead, construct the string at runtime from pieces or use bit
    ///	    manipulation (for example, XOR with some other string) to hide the
    ///	    actual key. The key itself is not secret information, but you do
    ///	    not want to make it easy for a hacker or malicious user to replace
    ///	    the public key with another key.
    ///	  </para>
    ///	</remarks>
    {$ENDREGION}
    property ApplicationLicenseKey: string
      read GetApplicationLicenseKey write SetApplicationLicenseKey;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Custom pay load attached to transactions that can be verified to
    ///	  ensure transactions are legitimate
    ///	</summary>
    ///	<remarks>
    ///	  This is only relevant on the Android mobile platform. This property
    ///	  is ignored on iOS.
    ///	</remarks>
    ///	<seealso cref="OnVerifyPayload">
    ///	  OnVerifyPayload
    ///	</seealso>
    {$ENDREGION}
    property TransactionPayload: string read GetTransactionPayload
      write SetTransactionPayload;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The product IDs for the products that will be offered to the user to
    ///	  purchase
    ///	</summary>
    ///	<remarks>
    ///	  The RequestProducts method will check with the online store as to
    ///	  which of the product IDs are actually available
    ///	</remarks>
    ///	<seealso cref="TCustomInAppPurchase.RequestProducts">
    ///	  RequestProducts method
    ///	</seealso>
    {$ENDREGION}
    property ProductIDs: TStrings read FProductIDs write SetProductIDs;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The call to <see cref="SetupInAppPurchase" /> has completed
    ///	</summary>
    {$ENDREGION}
    property IsSetupComplete: Boolean read FIsSetupComplete;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  This event is fired when the component is ready to be used after a
    ///	  prior call to <see cref="SetupInAppPurchase" />.
    ///	</summary>
    ///	<remarks>
    ///	  On iOS it will fire immediately. On Android it takes a little time to
    ///	  bind to the Google Play In-App Billing service before the event fires.
    ///	</remarks>
    ///	<seealso cref="SetupInAppPurchase">
    ///	  TCustomInAppPurchase. SetupInAppPurchase
    ///	</seealso>
    {$ENDREGION}
    property OnSetupComplete: TNotifyEvent read FOnSetupComplete
      write FOnSetupComplete;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  After a call to RequestProducts this event fires to let you know
    ///	  which product IDs are valid and which are invalid
    ///	</summary>
    ///	<seealso cref="TCustomInAppPurchase.RequestProducts">
    ///	  RequestProducts method
    ///	</seealso>
    {$ENDREGION}
    property OnProductsRequestResponse: TIAPProductsRequestResponseEvent
      read FOnProductsRequestResponse write FOnProductsRequestResponse;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  After a call to RequestProducts or PurchaseProduct this event fires in the event of some
    ///	  failure
    ///	</summary>
    ///	<seealso cref="TCustomInAppPurchase.RequestProducts">
    ///	  RequestProducts method
    ///	</seealso>
    ///	<seealso cref="TCustomInAppPurchase.PurchaseProduct">
    ///	  PurchaseProduct method
    ///	</seealso>
    {$ENDREGION}
    property OnError: TIAPErrorEvent
      read FOnError write FOnError;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  When a transaction occurs that has a payload associated this event is
    ///	  fired to validate the payload
    ///	</summary>
    ///	<remarks>
    ///	  This event is specific to the Android platform and is not called on
    ///	  iOS
    ///	</remarks>
    ///	<seealso cref="TransactionPayload">
    ///	  TransactionPayload
    ///	</seealso>
    {$ENDREGION}
    property OnVerifyPayload: TIAPVerifyPayloadEvent
      read FOnVerifyPayload write FOnVerifyPayload;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  When a product is purchased that has associated downloads, this event
    ///	  fires to let you know the progress of downloading them
    ///	</summary>
    {$ENDREGION}
    property OnDownloadProgress: TIAPDownloadProgressEvent
      read FOnDownloadProgress write FOnDownloadProgress;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  When a product is purchased that has associated downloads, this event
    ///	  fires to let you know that a download has completed
    ///	</summary>
    {$ENDREGION}
    property OnDownloadCompleted: TIAPDownloadCompletedEvent
      read FOnDownloadCompleted write FOnDownloadCompleted;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  This event fires to inform you of a completed purchase transaction
    ///	</summary>
    ///	<remarks>
    ///	  This event fires for both new purchases and restored old purchases.
    ///	  The NewTransaction Boolean parameter tells you which scenario is
    ///	  current.
    ///	</remarks>
    {$ENDREGION}
    property OnPurchaseCompleted: TIAPPurchaseCompletedEvent
      read FOnPurchaseCompleted write FOnPurchaseCompleted;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  When a product has been purchased this event triggers in case you
    ///	  wich to record the transaction identifier and purchase date for
    ///	  auditing purposes
    ///	</summary>
    {$ENDREGION}
    property OnRecordTransaction: TIAPRecordTransactionEvent
      read FOnRecordTransaction write FOnRecordTransaction;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Event that is fired to indicate successful consumption of a product
    ///	</summary>
    {$ENDREGION}
    property OnConsumeCompleted: TIAPConsumeCompletedEvent read FOnConsumeCompleted
      write FOnConsumeCompleted;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Event type to indicate unsuccessful consumption of a product
    ///	</summary>
    {$ENDREGION}
    property OnConsumeFailed: TIAPConsumeFailedEvent read FOnConsumeFailed
      write FOnConsumeFailed;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  FireMonkey In-App Purchase component
  ///	</summary>
  {$ENDREGION}
  [ComponentPlatformsAttribute(pidiOSSimulator or pidiOSDevice or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
  TInAppPurchase = class(TCustomInAppPurchase)
  published
    property ApplicationLicenseKey;
    property ProductIDs;
    property OnProductsRequestResponse;
    property OnError;
    property OnVerifyPayload;
    property OnDownloadProgress;
    property OnDownloadCompleted;
    property OnPurchaseCompleted;
    property OnRecordTransaction;
    property OnConsumeCompleted;
    property OnConsumeFailed;
  end;

implementation

uses
  System.TypInfo,
{$IF Defined(IOS)}
  FMX.InAppPurchase.iOS,
{$ELSEIF Defined(ANDROID)}
  FMX.InAppPurchase.Android,
{$ENDIF}
  FMX.Types,
  FMX.Forms,
  FMX.Consts,
  FMX.Platform;

{ TCustomInAppBilling }

constructor TCustomInAppPurchase.Create(AOwner: TComponent);
var
  IAPIntf: IInterface;
begin
  inherited;
  FProductIDs := TStringList.Create;
  if TPlatformServices.Current.SupportsPlatformService(IFMXInAppPurchaseService, IAPIntf) then
  begin
    FInAppPurchaseService := IFMXInAppPurchaseService(IAPIntf);
    FInAppPurchaseService.AddComponent(Self);
  end;
end;

destructor TCustomInAppPurchase.Destroy;
begin
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.RemoveComponent(Self);
  FInAppPurchaseService := nil;
  inherited;
end;

procedure TCustomInAppPurchase.CheckInAppPurchaseIsSetup;
begin
  if not IsSetupComplete then
    raise EIAPNotSetup.Create(SIAPNotSetup);
end;

procedure TCustomInAppPurchase.DoSetupComplete;
begin
  FIsSetupComplete := True;
  if Assigned(FOnSetupComplete) then
    try
      FOnSetupComplete(Self)
    except
      on E: Exception do
        Application.HandleException(E)
    end;
end;

procedure TCustomInAppPurchase.DoVerifyPayload(const Payload: String; var PayloadOk: Boolean);
begin
  if Assigned(FOnVerifyPayload) then
    try
      FOnVerifyPayload(Self, Payload, PayloadOk)
    except
      on E: Exception do
        Application.HandleException(E)
    end;
end;

procedure TCustomInAppPurchase.DoProductsRequestResponse(const Products: TIAPProductList;
  const InvalidProductIDs: TStrings);
begin
  if Assigned(FOnProductsRequestResponse) then
    try
      FOnProductsRequestResponse(Self, Products, InvalidProductIDs)
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

procedure TCustomInAppPurchase.DoError(FailureKind: TFailureKind; const ErrorMessage: string);
begin
  if Assigned(FOnError) then
    try
      FOnError(Self, FailureKind, ErrorMessage)
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

procedure TCustomInAppPurchase.DoPurchaseCompleted(const ProductID: string; NewTransaction: Boolean);
begin
  if Assigned(FOnPurchaseCompleted) then
    try
      FOnPurchaseCompleted(Self, ProductID, NewTransaction)
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

procedure TCustomInAppPurchase.DoRecordTransaction(const ProductID, TransactionID: string; TransactionDate: TDateTime);
begin
  if Assigned(FOnRecordTransaction) then
    try
      FOnRecordTransaction(Self, ProductID, TransactionID, TransactionDate)
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

procedure TCustomInAppPurchase.DoDownloadProgress(const ProductID, ContentID: string; TimeRemaining: Double;
  Progress: Single);
begin
  if Assigned(FOnDownloadProgress) then
    try
      FOnDownloadProgress(Self, ProductID, ContentID, TimeRemaining, Progress);
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

procedure TCustomInAppPurchase.DoDownloadCompleted(const ProductID, ContentID,
  FilePath: string);
begin
  if Assigned(FOnDownloadCompleted) then
    try
      FOnDownloadCompleted(Self, ProductID, ContentID, FilePath);
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

procedure TCustomInAppPurchase.DoConsumeCompleted(const ProductID: string);
begin
  if Assigned(FOnConsumeCompleted) then
    try
      FOnConsumeCompleted(Self, ProductID);
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

procedure TCustomInAppPurchase.DoConsumeFailed(const ProductID, ErrorMessage: string);
begin
  if Assigned(FOnConsumeFailed) then
    try
      FOnConsumeFailed(Self, ProductID, ErrorMessage);
    except
      on E: Exception do
        Application.HandleException(E)
    end
end;

function TCustomInAppPurchase.CanMakeInAppPurchases: Boolean;
begin
  Result := False;
  if FInAppPurchaseService <> nil then
    Result := IsSetupComplete and FInAppPurchaseService.CanMakeInAppPurchases
end;

function TCustomInAppPurchase.GetApplicationLicenseKey: string;
begin
  if FInAppPurchaseService <> nil then
    Result := FInAppPurchaseService.ApplicationLicenseKey
end;

function TCustomInAppPurchase.GetTransactionPayload: string;
begin
  if FInAppPurchaseService <> nil then
    Result := FInAppPurchaseService.TransactionPayload
end;

function TCustomInAppPurchase.IsProductPurchased(const ProductID: string): Boolean;
begin
  CheckInAppPurchaseIsSetup;
  Result := False;
  if FInAppPurchaseService <> nil then
    Result := FInAppPurchaseService.IsProductPurchased(ProductID)
end;

procedure TCustomInAppPurchase.PurchaseProduct(const ProductID: string);
begin
  CheckInAppPurchaseIsSetup;
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.PurchaseProduct(ProductID)
end;

procedure TCustomInAppPurchase.ConsumeProduct(const ProductID: string);
begin
  CheckInAppPurchaseIsSetup;
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.ConsumeProduct(ProductID)
end;

procedure TCustomInAppPurchase.ConsumeProducts(const ProductIDs: TStrings);
begin
  CheckInAppPurchaseIsSetup;
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.ConsumeProducts(ProductIDs)
end;

procedure TCustomInAppPurchase.QueryProducts;
begin
  CheckInAppPurchaseIsSetup;
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.QueryProducts(ProductIDs)
end;

procedure TCustomInAppPurchase.RestorePurchasedProducts;
begin
  CheckInAppPurchaseIsSetup;
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.RestorePurchasedProducts
end;

procedure TCustomInAppPurchase.SetApplicationLicenseKey(const Value: string);
begin
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.ApplicationLicenseKey := Value
end;

procedure TCustomInAppPurchase.SetProductIDs(const Value: TStrings);
begin
  FProductIDs.Assign(Value);
end;

procedure TCustomInAppPurchase.SetTransactionPayload(const Value: string);
begin
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.TransactionPayload := Value
end;

procedure TCustomInAppPurchase.SetupInAppPurchase;
begin
  if FInAppPurchaseService <> nil then
    FInAppPurchaseService.SetupInAppPurchase(Self)
end;

{ TProduct }

constructor TProduct.Create(const ProductID: string; Price: Double;
  const LocalizedPrice, LocalizedTitle, LocalizedDescription: string; Downloadable: Boolean;
  const DownloadContentLengths: TDownloadLengths; DownloadContentVersion: string);
begin
  inherited Create;
  FProductID := ProductID;
  FPrice := Price;
  FLocalizedPrice := LocalizedPrice;
  FLocalizedTitle := LocalizedTitle;
  FLocalizedDescription := LocalizedDescription;
  FDownloadable := Downloadable;
  FDownloadContentLengths := DownloadContentLengths;
  FDownloadContentVersion := DownloadContentVersion;
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TFailureKind), ['fkProductsRequest', 'fkPurchase']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TFailureKind));
end;

initialization
  RegisterAliases;
{$IF Defined(IOS) or Defined (ANDROID)}
  RegisterInAppPurchaseService;
{$ENDIF}
  RegisterFmxClasses([TInAppPurchase]);
  GroupDescendentsWith(TInAppPurchase, TFmxObject);

finalization
  UnregisterAliases;

{$IF Defined(IOS) or Defined (ANDROID)}
  UnRegisterInAppPurchaseService;
{$ENDIF}

end.
