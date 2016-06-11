{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Security;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Security.Cryptography,
  Winapi.WebRT,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Security.Credentials,
  Winapi.Foundation.Collections,
  Winapi.Storage.Streams,
  Winapi.Storage,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Security Class Names
  // Windows.Security.Authentication.Web.Core.WebTokenRequest
  // DualAPI
  SAuthentication_Web_Core_WebTokenRequest = 'Windows.Security.Authentication.Web.Core.WebTokenRequest';
  // Windows.Security.Authentication.Web.Core.WebAuthenticationCoreManager
  // DualAPI
  SAuthentication_Web_Core_WebAuthenticationCoreManager = 'Windows.Security.Authentication.Web.Core.WebAuthenticationCoreManager';
  // Windows.Security.Authentication.Web.Provider.WebProviderTokenRequest
  // DualAPI
  SAuthentication_Web_Provider_WebProviderTokenRequest = 'Windows.Security.Authentication.Web.Provider.WebProviderTokenRequest';
  // Windows.Security.Authentication.Web.Provider.WebProviderTokenResponse
  // DualAPI
  SAuthentication_Web_Provider_WebProviderTokenResponse = 'Windows.Security.Authentication.Web.Provider.WebProviderTokenResponse';
  // Windows.Security.Authentication.Web.Provider.WebAccountClientView
  // DualAPI
  SAuthentication_Web_Provider_WebAccountClientView = 'Windows.Security.Authentication.Web.Provider.WebAccountClientView';
  // Windows.Security.Authentication.Web.Provider.WebAccountManager
  // DualAPI
  SAuthentication_Web_Provider_WebAccountManager = 'Windows.Security.Authentication.Web.Provider.WebAccountManager';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderRequestTokenOperation
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderRequestTokenOperation = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderRequestTokenOperation';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderGetTokenSilentOperation
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderGetTokenSilentOperation = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderGetTokenSilentOperation';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderAddAccountOperation
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderAddAccountOperation = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderAddAccountOperation';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderManageAccountOperation
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderManageAccountOperation = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderManageAccountOperation';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderDeleteAccountOperation
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderDeleteAccountOperation = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderDeleteAccountOperation';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderSignOutAccountOperation
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderSignOutAccountOperation = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderSignOutAccountOperation';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderRetrieveCookiesOperation
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderRetrieveCookiesOperation = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderRetrieveCookiesOperation';
  // Windows.Security.Authentication.Web.Provider.WebAccountProviderTriggerDetails
  // DualAPI
  SAuthentication_Web_Provider_WebAccountProviderTriggerDetails = 'Windows.Security.Authentication.Web.Provider.WebAccountProviderTriggerDetails';
  // Windows.Security.Authentication.Web.Core.WebProviderError
  // DualAPI
  SAuthentication_Web_Core_WebProviderError = 'Windows.Security.Authentication.Web.Core.WebProviderError';
  // Windows.Security.Authentication.Web.Core.WebTokenResponse
  // DualAPI
  SAuthentication_Web_Core_WebTokenResponse = 'Windows.Security.Authentication.Web.Core.WebTokenResponse';
  // Windows.Security.Authentication.Web.Core.WebTokenRequestResult
  // DualAPI
  SAuthentication_Web_Core_WebTokenRequestResult = 'Windows.Security.Authentication.Web.Core.WebTokenRequestResult';
  // Windows.Security.EnterpriseData.FileProtectionInfo
  // DualAPI
  SEnterpriseData_FileProtectionInfo = 'Windows.Security.EnterpriseData.FileProtectionInfo';
  // Windows.Security.EnterpriseData.ProtectedContainerExportResult
  // DualAPI
  SEnterpriseData_ProtectedContainerExportResult = 'Windows.Security.EnterpriseData.ProtectedContainerExportResult';
  // Windows.Security.EnterpriseData.ProtectedContainerImportResult
  // DualAPI
  SEnterpriseData_ProtectedContainerImportResult = 'Windows.Security.EnterpriseData.ProtectedContainerImportResult';
  // Windows.Security.EnterpriseData.ProtectedFileCreateResult
  // DualAPI
  SEnterpriseData_ProtectedFileCreateResult = 'Windows.Security.EnterpriseData.ProtectedFileCreateResult';
  // Windows.Security.EnterpriseData.BufferProtectUnprotectResult
  // DualAPI
  SEnterpriseData_BufferProtectUnprotectResult = 'Windows.Security.EnterpriseData.BufferProtectUnprotectResult';
  // Windows.Security.EnterpriseData.DataProtectionInfo
  // DualAPI
  SEnterpriseData_DataProtectionInfo = 'Windows.Security.EnterpriseData.DataProtectionInfo';
  // Windows.Security.EnterpriseData.ThreadNetworkContext
  // DualAPI
  SEnterpriseData_ThreadNetworkContext = 'Windows.Security.EnterpriseData.ThreadNetworkContext';
  // Windows.Security.EnterpriseData.ProtectionPolicyManager
  // DualAPI
  SEnterpriseData_ProtectionPolicyManager = 'Windows.Security.EnterpriseData.ProtectionPolicyManager';
  // Windows.Security.EnterpriseData.ProtectedAccessSuspendingEventArgs
  // DualAPI
  SEnterpriseData_ProtectedAccessSuspendingEventArgs = 'Windows.Security.EnterpriseData.ProtectedAccessSuspendingEventArgs';
  // Windows.Security.EnterpriseData.ProtectedAccessResumedEventArgs
  // DualAPI
  SEnterpriseData_ProtectedAccessResumedEventArgs = 'Windows.Security.EnterpriseData.ProtectedAccessResumedEventArgs';
  // Windows.Security.EnterpriseData.ProtectedContentRevokedEventArgs
  // DualAPI
  SEnterpriseData_ProtectedContentRevokedEventArgs = 'Windows.Security.EnterpriseData.ProtectedContentRevokedEventArgs';
  // Windows.Security.EnterpriseData.FileRevocationManager
  // DualAPI
  SEnterpriseData_FileRevocationManager = 'Windows.Security.EnterpriseData.FileRevocationManager';
  // Windows.Security.EnterpriseData.FileProtectionManager
  // DualAPI
  SEnterpriseData_FileProtectionManager = 'Windows.Security.EnterpriseData.FileProtectionManager';
  // Windows.Security.EnterpriseData.DataProtectionManager
  // DualAPI
  SEnterpriseData_DataProtectionManager = 'Windows.Security.EnterpriseData.DataProtectionManager';


type
  // Forward declare interfaces
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.ProtectionPolicyEvaluationResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult = ^AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.ProtectionPolicyEvaluationResult>
  IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult = interface;
  PIAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult = ^IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderOperation
  Authentication_Web_Provider_IWebAccountProviderOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderOperation = ^Authentication_Web_Provider_IWebAccountProviderOperation;

  // Windows.Security.Authentication.Web.Core.IWebTokenRequest
  Authentication_Web_Core_IWebTokenRequest = interface;
  PAuthentication_Web_Core_IWebTokenRequest = ^Authentication_Web_Core_IWebTokenRequest;

  // Windows.Security.Authentication.Web.Core.IWebTokenRequestFactory
  Authentication_Web_Core_IWebTokenRequestFactory = interface;
  PAuthentication_Web_Core_IWebTokenRequestFactory = ^Authentication_Web_Core_IWebTokenRequestFactory;

  // Windows.Security.Authentication.Web.Core.IWebProviderError
  Authentication_Web_Core_IWebProviderError = interface;
  PAuthentication_Web_Core_IWebProviderError = ^Authentication_Web_Core_IWebProviderError;

  // Windows.Security.Authentication.Web.Core.IWebTokenResponse
  Authentication_Web_Core_IWebTokenResponse = interface;
  PAuthentication_Web_Core_IWebTokenResponse = ^Authentication_Web_Core_IWebTokenResponse;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Authentication.Web.Core.IWebTokenResponse>
  IIterator_1__Authentication_Web_Core_IWebTokenResponse = interface;
  PIIterator_1__Authentication_Web_Core_IWebTokenResponse = ^IIterator_1__Authentication_Web_Core_IWebTokenResponse;

  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Core.IWebTokenResponse>
  IIterable_1__Authentication_Web_Core_IWebTokenResponse = interface;
  PIIterable_1__Authentication_Web_Core_IWebTokenResponse = ^IIterable_1__Authentication_Web_Core_IWebTokenResponse;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Core.IWebTokenResponse>
  IVectorView_1__Authentication_Web_Core_IWebTokenResponse = interface;
  PIVectorView_1__Authentication_Web_Core_IWebTokenResponse = ^IVectorView_1__Authentication_Web_Core_IWebTokenResponse;

  // Windows.Security.Authentication.Web.Core.IWebTokenRequestResult
  Authentication_Web_Core_IWebTokenRequestResult = interface;
  PAuthentication_Web_Core_IWebTokenRequestResult = ^Authentication_Web_Core_IWebTokenRequestResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Authentication.Web.Core.IWebTokenRequestResult>
  AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult = interface;
  PAsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult = ^AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Authentication.Web.Core.IWebTokenRequestResult>
  IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult = interface;
  PIAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult = ^IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult;

  // Windows.Security.Authentication.Web.Core.IWebAuthenticationCoreManagerStatics
  Authentication_Web_Core_IWebAuthenticationCoreManagerStatics = interface;
  PAuthentication_Web_Core_IWebAuthenticationCoreManagerStatics = ^Authentication_Web_Core_IWebAuthenticationCoreManagerStatics;

  // Windows.Security.Authentication.Web.Core.IWebAuthenticationCoreManagerStatics2
  Authentication_Web_Core_IWebAuthenticationCoreManagerStatics2 = interface;
  PAuthentication_Web_Core_IWebAuthenticationCoreManagerStatics2 = ^Authentication_Web_Core_IWebAuthenticationCoreManagerStatics2;

  // Windows.Security.Authentication.Web.Provider.IWebProviderTokenRequest
  Authentication_Web_Provider_IWebProviderTokenRequest = interface;
  PAuthentication_Web_Provider_IWebProviderTokenRequest = ^Authentication_Web_Provider_IWebProviderTokenRequest;

  // Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse
  Authentication_Web_Provider_IWebProviderTokenResponse = interface;
  PAuthentication_Web_Provider_IWebProviderTokenResponse = ^Authentication_Web_Provider_IWebProviderTokenResponse;

  // Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponseFactory
  Authentication_Web_Provider_IWebProviderTokenResponseFactory = interface;
  PAuthentication_Web_Provider_IWebProviderTokenResponseFactory = ^Authentication_Web_Provider_IWebProviderTokenResponseFactory;

  // Windows.Security.Authentication.Web.Provider.IWebAccountClientView
  Authentication_Web_Provider_IWebAccountClientView = interface;
  PAuthentication_Web_Provider_IWebAccountClientView = ^Authentication_Web_Provider_IWebAccountClientView;

  // Windows.Security.Authentication.Web.Provider.IWebAccountClientViewFactory
  Authentication_Web_Provider_IWebAccountClientViewFactory = interface;
  PAuthentication_Web_Provider_IWebAccountClientViewFactory = ^Authentication_Web_Provider_IWebAccountClientViewFactory;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>
  IIterator_1__Authentication_Web_Provider_IWebAccountClientView = interface;
  PIIterator_1__Authentication_Web_Provider_IWebAccountClientView = ^IIterator_1__Authentication_Web_Provider_IWebAccountClientView;

  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>
  IIterable_1__Authentication_Web_Provider_IWebAccountClientView = interface;
  PIIterable_1__Authentication_Web_Provider_IWebAccountClientView = ^IIterable_1__Authentication_Web_Provider_IWebAccountClientView;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>
  IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = interface;
  PIVectorView_1__Authentication_Web_Provider_IWebAccountClientView = ^IVectorView_1__Authentication_Web_Provider_IWebAccountClientView;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = ^AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>>
  IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = interface;
  PIAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = ^IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView;

  // Windows.Security.Authentication.Web.Provider.IWebAccountManagerStatics
  Authentication_Web_Provider_IWebAccountManagerStatics = interface;
  PAuthentication_Web_Provider_IWebAccountManagerStatics = ^Authentication_Web_Provider_IWebAccountManagerStatics;

  // Windows.Security.Authentication.Web.Provider.IWebAccountScopeManagerStatics
  Authentication_Web_Provider_IWebAccountScopeManagerStatics = interface;
  PAuthentication_Web_Provider_IWebAccountScopeManagerStatics = ^Authentication_Web_Provider_IWebAccountScopeManagerStatics;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderBaseReportOperation
  Authentication_Web_Provider_IWebAccountProviderBaseReportOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderBaseReportOperation = ^Authentication_Web_Provider_IWebAccountProviderBaseReportOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderUIReportOperation
  Authentication_Web_Provider_IWebAccountProviderUIReportOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderUIReportOperation = ^Authentication_Web_Provider_IWebAccountProviderUIReportOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderSilentReportOperation
  Authentication_Web_Provider_IWebAccountProviderSilentReportOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderSilentReportOperation = ^Authentication_Web_Provider_IWebAccountProviderSilentReportOperation;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IIterator_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface;
  PIIterator_1__Authentication_Web_Provider_IWebProviderTokenResponse = ^IIterator_1__Authentication_Web_Provider_IWebProviderTokenResponse;

  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IIterable_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface;
  PIIterable_1__Authentication_Web_Provider_IWebProviderTokenResponse = ^IIterable_1__Authentication_Web_Provider_IWebProviderTokenResponse;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IVectorView_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface;
  PIVectorView_1__Authentication_Web_Provider_IWebProviderTokenResponse = ^IVectorView_1__Authentication_Web_Provider_IWebProviderTokenResponse;

  // Windows.Foundation.Collections.IVector`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IVector_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface;
  PIVector_1__Authentication_Web_Provider_IWebProviderTokenResponse = ^IVector_1__Authentication_Web_Provider_IWebProviderTokenResponse;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderTokenOperation
  Authentication_Web_Provider_IWebAccountProviderTokenOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderTokenOperation = ^Authentication_Web_Provider_IWebAccountProviderTokenOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderAddAccountOperation
  Authentication_Web_Provider_IWebAccountProviderAddAccountOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderAddAccountOperation = ^Authentication_Web_Provider_IWebAccountProviderAddAccountOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderManageAccountOperation
  Authentication_Web_Provider_IWebAccountProviderManageAccountOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderManageAccountOperation = ^Authentication_Web_Provider_IWebAccountProviderManageAccountOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderDeleteAccountOperation
  Authentication_Web_Provider_IWebAccountProviderDeleteAccountOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderDeleteAccountOperation = ^Authentication_Web_Provider_IWebAccountProviderDeleteAccountOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderSignOutAccountOperation
  Authentication_Web_Provider_IWebAccountProviderSignOutAccountOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderSignOutAccountOperation = ^Authentication_Web_Provider_IWebAccountProviderSignOutAccountOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderRetrieveCookiesOperation
  Authentication_Web_Provider_IWebAccountProviderRetrieveCookiesOperation = interface;
  PAuthentication_Web_Provider_IWebAccountProviderRetrieveCookiesOperation = ^Authentication_Web_Provider_IWebAccountProviderRetrieveCookiesOperation;

  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderTokenObjects
  Authentication_Web_Provider_IWebAccountProviderTokenObjects = interface;
  PAuthentication_Web_Provider_IWebAccountProviderTokenObjects = ^Authentication_Web_Provider_IWebAccountProviderTokenObjects;

  // Windows.Security.Authentication.Web.Core.IWebProviderErrorFactory
  Authentication_Web_Core_IWebProviderErrorFactory = interface;
  PAuthentication_Web_Core_IWebProviderErrorFactory = ^Authentication_Web_Core_IWebProviderErrorFactory;

  // Windows.Security.Authentication.Web.Core.IWebTokenResponseFactory
  Authentication_Web_Core_IWebTokenResponseFactory = interface;
  PAuthentication_Web_Core_IWebTokenResponseFactory = ^Authentication_Web_Core_IWebTokenResponseFactory;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.FileProtectionStatus>
  AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus = ^AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.FileProtectionStatus>
  IAsyncOperation_1__EnterpriseData_FileProtectionStatus = interface;
  PIAsyncOperation_1__EnterpriseData_FileProtectionStatus = ^IAsyncOperation_1__EnterpriseData_FileProtectionStatus;

  // Windows.Security.EnterpriseData.IFileRevocationManagerStatics
  EnterpriseData_IFileRevocationManagerStatics = interface;
  PEnterpriseData_IFileRevocationManagerStatics = ^EnterpriseData_IFileRevocationManagerStatics;

  // Windows.Security.EnterpriseData.IFileProtectionInfo
  EnterpriseData_IFileProtectionInfo = interface;
  PEnterpriseData_IFileProtectionInfo = ^EnterpriseData_IFileProtectionInfo;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IFileProtectionInfo>
  AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo = ^AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IFileProtectionInfo>
  IAsyncOperation_1__EnterpriseData_IFileProtectionInfo = interface;
  PIAsyncOperation_1__EnterpriseData_IFileProtectionInfo = ^IAsyncOperation_1__EnterpriseData_IFileProtectionInfo;

  // Windows.Security.EnterpriseData.IProtectedContainerExportResult
  EnterpriseData_IProtectedContainerExportResult = interface;
  PEnterpriseData_IProtectedContainerExportResult = ^EnterpriseData_IProtectedContainerExportResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedContainerExportResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult = ^AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedContainerExportResult>
  IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult = interface;
  PIAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult = ^IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult;

  // Windows.Security.EnterpriseData.IProtectedContainerImportResult
  EnterpriseData_IProtectedContainerImportResult = interface;
  PEnterpriseData_IProtectedContainerImportResult = ^EnterpriseData_IProtectedContainerImportResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedContainerImportResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult = ^AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedContainerImportResult>
  IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult = interface;
  PIAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult = ^IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult;

  // Windows.Security.EnterpriseData.IProtectedFileCreateResult
  EnterpriseData_IProtectedFileCreateResult = interface;
  PEnterpriseData_IProtectedFileCreateResult = ^EnterpriseData_IProtectedFileCreateResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedFileCreateResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult = ^AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedFileCreateResult>
  IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult = interface;
  PIAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult = ^IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult;

  // Windows.Security.EnterpriseData.IFileProtectionManagerStatics
  EnterpriseData_IFileProtectionManagerStatics = interface;
  PEnterpriseData_IFileProtectionManagerStatics = ^EnterpriseData_IFileProtectionManagerStatics;

  // Windows.Security.EnterpriseData.IDataProtectionInfo
  EnterpriseData_IDataProtectionInfo = interface;
  PEnterpriseData_IDataProtectionInfo = ^EnterpriseData_IDataProtectionInfo;

  // Windows.Security.EnterpriseData.IBufferProtectUnprotectResult
  EnterpriseData_IBufferProtectUnprotectResult = interface;
  PEnterpriseData_IBufferProtectUnprotectResult = ^EnterpriseData_IBufferProtectUnprotectResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IBufferProtectUnprotectResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult = ^AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IBufferProtectUnprotectResult>
  IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult = interface;
  PIAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult = ^IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IDataProtectionInfo>
  AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo = interface;
  PAsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo = ^AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IDataProtectionInfo>
  IAsyncOperation_1__EnterpriseData_IDataProtectionInfo = interface;
  PIAsyncOperation_1__EnterpriseData_IDataProtectionInfo = ^IAsyncOperation_1__EnterpriseData_IDataProtectionInfo;

  // Windows.Security.EnterpriseData.IDataProtectionManagerStatics
  EnterpriseData_IDataProtectionManagerStatics = interface;
  PEnterpriseData_IDataProtectionManagerStatics = ^EnterpriseData_IDataProtectionManagerStatics;

  // Windows.Security.EnterpriseData.IProtectionPolicyManager
  EnterpriseData_IProtectionPolicyManager = interface;
  PEnterpriseData_IProtectionPolicyManager = ^EnterpriseData_IProtectionPolicyManager;

  // Windows.Security.EnterpriseData.IThreadNetworkContext
  EnterpriseData_IThreadNetworkContext = interface;
  PEnterpriseData_IThreadNetworkContext = ^EnterpriseData_IThreadNetworkContext;

  // Windows.Security.EnterpriseData.IProtectedAccessSuspendingEventArgs
  EnterpriseData_IProtectedAccessSuspendingEventArgs = interface;
  PEnterpriseData_IProtectedAccessSuspendingEventArgs = ^EnterpriseData_IProtectedAccessSuspendingEventArgs;

  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedAccessSuspendingEventArgs>
  EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs = interface;
  PEventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs = ^EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs;

  // Windows.Security.EnterpriseData.IProtectedAccessResumedEventArgs
  EnterpriseData_IProtectedAccessResumedEventArgs = interface;
  PEnterpriseData_IProtectedAccessResumedEventArgs = ^EnterpriseData_IProtectedAccessResumedEventArgs;

  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedAccessResumedEventArgs>
  EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs = interface;
  PEventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs = ^EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs;

  // Windows.Security.EnterpriseData.IProtectedContentRevokedEventArgs
  EnterpriseData_IProtectedContentRevokedEventArgs = interface;
  PEnterpriseData_IProtectedContentRevokedEventArgs = ^EnterpriseData_IProtectedContentRevokedEventArgs;

  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedContentRevokedEventArgs>
  EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs = interface;
  PEventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs = ^EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs;

  // Windows.Security.EnterpriseData.IProtectionPolicyManagerStatics
  EnterpriseData_IProtectionPolicyManagerStatics = interface;
  PEnterpriseData_IProtectionPolicyManagerStatics = ^EnterpriseData_IProtectionPolicyManagerStatics;


  // Emit Forwarded interfaces
  // Windows.Security Interfaces
  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.ProtectionPolicyEvaluationResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult_Delegate_Base = interface(IUnknown)
  ['{2833BA54-A4E1-5C2D-8A7A-136E8510C78B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.ProtectionPolicyEvaluationResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult = interface(AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.ProtectionPolicyEvaluationResult>
  IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult_Base = interface(IInspectable)
  ['{E8D81715-C56C-5A6B-B738-5DF6C2775B7B}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.ProtectionPolicyEvaluationResult>
  IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult = interface(IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult; safecall;
    function GetResults: EnterpriseData_ProtectionPolicyEvaluationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_ProtectionPolicyEvaluationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderOperation
  Authentication_Web_Provider_IWebAccountProviderOperation = interface(IInspectable)
  ['{6D5D2426-10B1-419A-A44E-F9C5161574E6}']
    function get_Kind: Authentication_Web_Provider_WebAccountProviderOperationKind; safecall;
    property Kind: Authentication_Web_Provider_WebAccountProviderOperationKind read get_Kind;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebTokenRequest
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebTokenRequest)]
  Authentication_Web_Core_IWebTokenRequest = interface(IInspectable)
  ['{B77B4D68-ADCB-4673-B364-0CF7B35CAF97}']
    function get_WebAccountProvider: IWebAccountProvider; safecall;
    function get_Scope: HSTRING; safecall;
    function get_ClientId: HSTRING; safecall;
    function get_PromptType: Authentication_Web_Core_WebTokenRequestPromptType; safecall;
    function get_Properties: IMap_2__HSTRING__HSTRING; safecall;
    property ClientId: HSTRING read get_ClientId;
    property PromptType: Authentication_Web_Core_WebTokenRequestPromptType read get_PromptType;
    property Properties: IMap_2__HSTRING__HSTRING read get_Properties;
    property Scope: HSTRING read get_Scope;
    property WebAccountProvider: IWebAccountProvider read get_WebAccountProvider;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebTokenRequestFactory
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebTokenRequest)]
  Authentication_Web_Core_IWebTokenRequestFactory = interface(IInspectable)
  ['{6CF2141C-0FF0-4C67-B84F-99DDBE4A72C9}']
    function Create(provider: IWebAccountProvider; scope: HSTRING; clientId: HSTRING): Authentication_Web_Core_IWebTokenRequest; safecall;
    function CreateWithPromptType(provider: IWebAccountProvider; scope: HSTRING; clientId: HSTRING; promptType: Authentication_Web_Core_WebTokenRequestPromptType): Authentication_Web_Core_IWebTokenRequest; safecall;
    function CreateWithProvider(provider: IWebAccountProvider): Authentication_Web_Core_IWebTokenRequest; safecall;
    function CreateWithScope(provider: IWebAccountProvider; scope: HSTRING): Authentication_Web_Core_IWebTokenRequest; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebProviderError
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebProviderError)]
  Authentication_Web_Core_IWebProviderError = interface(IInspectable)
  ['{DB191BB1-50C5-4809-8DCA-09C99410245C}']
    function get_ErrorCode: Cardinal; safecall;
    function get_ErrorMessage: HSTRING; safecall;
    function get_Properties: IMap_2__HSTRING__HSTRING; safecall;
    property ErrorCode: Cardinal read get_ErrorCode;
    property ErrorMessage: HSTRING read get_ErrorMessage;
    property Properties: IMap_2__HSTRING__HSTRING read get_Properties;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebTokenResponse
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebTokenResponse)]
  Authentication_Web_Core_IWebTokenResponse = interface(IInspectable)
  ['{67A7C5CA-83F6-44C6-A3B1-0EB69E41FA8A}']
    function get_Token: HSTRING; safecall;
    function get_ProviderError: Authentication_Web_Core_IWebProviderError; safecall;
    function get_WebAccount: IWebAccount; safecall;
    function get_Properties: IMap_2__HSTRING__HSTRING; safecall;
    property Properties: IMap_2__HSTRING__HSTRING read get_Properties;
    property ProviderError: Authentication_Web_Core_IWebProviderError read get_ProviderError;
    property Token: HSTRING read get_Token;
    property WebAccount: IWebAccount read get_WebAccount;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Authentication.Web.Core.IWebTokenResponse>
  IIterator_1__Authentication_Web_Core_IWebTokenResponse = interface(IInspectable)
  ['{3AF93454-0FA5-5B50-9FA6-4CDE1AA49885}']
    function get_Current: Authentication_Web_Core_IWebTokenResponse; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PAuthentication_Web_Core_IWebTokenResponse): Cardinal; safecall;
    property Current: Authentication_Web_Core_IWebTokenResponse read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Core.IWebTokenResponse>
  IIterable_1__Authentication_Web_Core_IWebTokenResponse_Base = interface(IInspectable)
  ['{7E5BB7EC-BBD7-5575-9A61-F5815FA22A0E}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Core.IWebTokenResponse>
  IIterable_1__Authentication_Web_Core_IWebTokenResponse = interface(IIterable_1__Authentication_Web_Core_IWebTokenResponse_Base)
  ['{12223EBA-B793-5936-A23F-894F7F41CB0A}']
    function First: IIterator_1__Authentication_Web_Core_IWebTokenResponse; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Core.IWebTokenResponse>
  IVectorView_1__Authentication_Web_Core_IWebTokenResponse = interface(IInspectable)
  ['{DD754C27-54D4-5AA1-88C2-619EB1D36B2F}']
    function GetAt(index: Cardinal): Authentication_Web_Core_IWebTokenResponse; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Authentication_Web_Core_IWebTokenResponse; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PAuthentication_Web_Core_IWebTokenResponse): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebTokenRequestResult
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebTokenRequestResult)]
  Authentication_Web_Core_IWebTokenRequestResult = interface(IInspectable)
  ['{C12A8305-D1F8-4483-8D54-38FE292784FF}']
    function get_ResponseData: IVectorView_1__Authentication_Web_Core_IWebTokenResponse; safecall;
    function get_ResponseStatus: Authentication_Web_Core_WebTokenRequestStatus; safecall;
    function get_ResponseError: Authentication_Web_Core_IWebProviderError; safecall;
    function InvalidateCacheAsync: IAsyncAction; safecall;
    property ResponseData: IVectorView_1__Authentication_Web_Core_IWebTokenResponse read get_ResponseData;
    property ResponseError: Authentication_Web_Core_IWebProviderError read get_ResponseError;
    property ResponseStatus: Authentication_Web_Core_WebTokenRequestStatus read get_ResponseStatus;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Authentication.Web.Core.IWebTokenRequestResult>
  AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult_Delegate_Base = interface(IUnknown)
  ['{DEB54B22-70F2-55AB-97C0-6CBDC5DDB6F0}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Authentication.Web.Core.IWebTokenRequestResult>
  AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult = interface(AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult_Delegate_Base)
  ['{410483D4-EF99-5BB4-A63E-9F89DE125364}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Authentication.Web.Core.IWebTokenRequestResult>
  IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult_Base = interface(IInspectable)
  ['{0A815852-7C44-5674-B3D2-FA2E4C1E46C9}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Authentication.Web.Core.IWebTokenRequestResult>
  IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult = interface(IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult_Base)
  ['{D749599B-BAAE-5B22-A217-362B28FE19E4}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult; safecall;
    function GetResults: Authentication_Web_Core_IWebTokenRequestResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Authentication_Web_Core_IWebTokenRequestResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebAuthenticationCoreManagerStatics
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebAuthenticationCoreManager)]
  Authentication_Web_Core_IWebAuthenticationCoreManagerStatics = interface(IInspectable)
  ['{6ACA7C92-A581-4479-9C10-752EFF44FD34}']
    function GetTokenSilentlyAsync(request: Authentication_Web_Core_IWebTokenRequest): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; safecall;
    function GetTokenSilentlyAsync(request: Authentication_Web_Core_IWebTokenRequest; webAccount: IWebAccount): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; safecall;
    function RequestTokenAsync(request: Authentication_Web_Core_IWebTokenRequest): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; safecall;
    function RequestTokenAsync(request: Authentication_Web_Core_IWebTokenRequest; webAccount: IWebAccount): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; safecall;
    function FindAccountAsync(provider: IWebAccountProvider; webAccountId: HSTRING): IAsyncOperation_1__IWebAccount; safecall;
    function FindAccountProviderAsync(webAccountProviderId: HSTRING): IAsyncOperation_1__IWebAccountProvider; overload; safecall;
    function FindAccountProviderAsync(webAccountProviderId: HSTRING; authority: HSTRING): IAsyncOperation_1__IWebAccountProvider; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebAuthenticationCoreManagerStatics2
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebAuthenticationCoreManager)]
  Authentication_Web_Core_IWebAuthenticationCoreManagerStatics2 = interface(IInspectable)
  ['{F584184A-8B57-4820-B6A4-70A5B6FCF44A}']
    function FindAccountProviderAsync(webAccountProviderId: HSTRING; authority: HSTRING; user: IInspectable{IUser}): IAsyncOperation_1__IWebAccountProvider; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebProviderTokenRequest
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebProviderTokenRequest)]
  Authentication_Web_Provider_IWebProviderTokenRequest = interface(IInspectable)
  ['{1E18778B-8805-454B-9F11-468D2AF1095A}']
    function get_ClientRequest: Authentication_Web_Core_IWebTokenRequest; safecall;
    function get_WebAccounts: IVectorView_1__IWebAccount; safecall;
    function get_WebAccountSelectionOptions: Authentication_Web_Provider_WebAccountSelectionOptions; safecall;
    function get_ApplicationCallbackUri: IUriRuntimeClass; safecall;
    function GetApplicationTokenBindingKeyAsync(keyType: Authentication_Web_TokenBindingKeyType; target: IUriRuntimeClass): IAsyncOperation_1__Core_ICryptographicKey; safecall;
    property ApplicationCallbackUri: IUriRuntimeClass read get_ApplicationCallbackUri;
    property ClientRequest: Authentication_Web_Core_IWebTokenRequest read get_ClientRequest;
    property WebAccountSelectionOptions: Authentication_Web_Provider_WebAccountSelectionOptions read get_WebAccountSelectionOptions;
    property WebAccounts: IVectorView_1__IWebAccount read get_WebAccounts;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebProviderTokenResponse)]
  Authentication_Web_Provider_IWebProviderTokenResponse = interface(IInspectable)
  ['{EF213793-EF55-4186-B7CE-8CB2E7F9849E}']
    function get_ClientResponse: Authentication_Web_Core_IWebTokenResponse; safecall;
    property ClientResponse: Authentication_Web_Core_IWebTokenResponse read get_ClientResponse;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponseFactory
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebProviderTokenResponse)]
  Authentication_Web_Provider_IWebProviderTokenResponseFactory = interface(IInspectable)
  ['{FA49D99A-25BA-4077-9CFA-9DB4DEA7B71A}']
    function Create(webTokenResponse: Authentication_Web_Core_IWebTokenResponse): Authentication_Web_Provider_IWebProviderTokenResponse; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountClientView
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountClientView)]
  Authentication_Web_Provider_IWebAccountClientView = interface(IInspectable)
  ['{E7BD66BA-0BC7-4C66-BFD4-65D3082CBCA8}']
    function get_ApplicationCallbackUri: IUriRuntimeClass; safecall;
    function get_Type: Authentication_Web_Provider_WebAccountClientViewType; safecall;
    function get_AccountPairwiseId: HSTRING; safecall;
    property AccountPairwiseId: HSTRING read get_AccountPairwiseId;
    property ApplicationCallbackUri: IUriRuntimeClass read get_ApplicationCallbackUri;
    property &Type: Authentication_Web_Provider_WebAccountClientViewType read get_Type;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountClientViewFactory
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountClientView)]
  Authentication_Web_Provider_IWebAccountClientViewFactory = interface(IInspectable)
  ['{616D16A4-DE22-4855-A326-06CEBF2A3F23}']
    function Create(viewType: Authentication_Web_Provider_WebAccountClientViewType; applicationCallbackUri: IUriRuntimeClass): Authentication_Web_Provider_IWebAccountClientView; safecall;
    function CreateWithPairwiseId(viewType: Authentication_Web_Provider_WebAccountClientViewType; applicationCallbackUri: IUriRuntimeClass; accountPairwiseId: HSTRING): Authentication_Web_Provider_IWebAccountClientView; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>
  IIterator_1__Authentication_Web_Provider_IWebAccountClientView = interface(IInspectable)
  ['{DE310216-A3AB-5BE0-B9E5-12C407459359}']
    function get_Current: Authentication_Web_Provider_IWebAccountClientView; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PAuthentication_Web_Provider_IWebAccountClientView): Cardinal; safecall;
    property Current: Authentication_Web_Provider_IWebAccountClientView read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>
  IIterable_1__Authentication_Web_Provider_IWebAccountClientView_Base = interface(IInspectable)
  ['{610E0F9D-AAE4-54E1-BB0B-1ACA14110ABF}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>
  IIterable_1__Authentication_Web_Provider_IWebAccountClientView = interface(IIterable_1__Authentication_Web_Provider_IWebAccountClientView_Base)
  ['{7A564D5E-AAC6-57AE-9236-9992EB17F58A}']
    function First: IIterator_1__Authentication_Web_Provider_IWebAccountClientView; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>
  IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = interface(IInspectable)
  ['{06CBF02D-8929-5BCD-8398-70BDB051148B}']
    function GetAt(index: Cardinal): Authentication_Web_Provider_IWebAccountClientView; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Authentication_Web_Provider_IWebAccountClientView; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PAuthentication_Web_Provider_IWebAccountClientView): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView_Delegate_Base = interface(IUnknown)
  ['{3FA6536F-7E7A-5BC9-B20F-D866CACAF81C}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = interface(AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView_Delegate_Base)
  ['{C679A94A-DDDD-58C8-B07A-1544CBBCB60E}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>>
  IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView_Base = interface(IInspectable)
  ['{116827C1-187E-5095-A14B-DF4111C638C2}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebAccountClientView>>
  IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView = interface(IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView_Base)
  ['{05EC3908-83ED-58E6-9D7A-4B7E602837A9}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView; safecall;
    function GetResults: IVectorView_1__Authentication_Web_Provider_IWebAccountClientView; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountManagerStatics
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountManager)]
  Authentication_Web_Provider_IWebAccountManagerStatics = interface(IInspectable)
  ['{B2E8E1A6-D49A-4032-84BF-1A2847747BF1}']
    function UpdateWebAccountPropertiesAsync(webAccount: IWebAccount; webAccountUserName: HSTRING; additionalProperties: IMapView_2__HSTRING__HSTRING): IAsyncAction; safecall;
    function AddWebAccountAsync(webAccountId: HSTRING; webAccountUserName: HSTRING; props: IMapView_2__HSTRING__HSTRING): IAsyncOperation_1__IWebAccount; safecall;
    function DeleteWebAccountAsync(webAccount: IWebAccount): IAsyncAction; safecall;
    function FindAllProviderWebAccountsAsync: IAsyncOperation_1__IVectorView_1__IWebAccount; safecall;
    function PushCookiesAsync(uri: IUriRuntimeClass; cookies: IVectorView_1__Http_IHttpCookie): IAsyncAction; safecall;
    function SetViewAsync(webAccount: IWebAccount; view: Authentication_Web_Provider_IWebAccountClientView): IAsyncAction; safecall;
    function ClearViewAsync(webAccount: IWebAccount; applicationCallbackUri: IUriRuntimeClass): IAsyncAction; safecall;
    function GetViewsAsync(webAccount: IWebAccount): IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView; safecall;
    function SetWebAccountPictureAsync(webAccount: IWebAccount; webAccountPicture: IRandomAccessStream): IAsyncAction; safecall;
    function ClearWebAccountPictureAsync(webAccount: IWebAccount): IAsyncAction; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountScopeManagerStatics
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountManager)]
  Authentication_Web_Provider_IWebAccountScopeManagerStatics = interface(IInspectable)
  ['{5C6CE37C-12B2-423A-BF3D-85B8D7E53656}']
    function AddWebAccountAsync(webAccountId: HSTRING; webAccountUserName: HSTRING; props: IMapView_2__HSTRING__HSTRING; scope: Authentication_Web_Provider_WebAccountScope): IAsyncOperation_1__IWebAccount; safecall;
    function SetScopeAsync(webAccount: IWebAccount; scope: Authentication_Web_Provider_WebAccountScope): IAsyncAction; safecall;
    function GetScope(webAccount: IWebAccount): Authentication_Web_Provider_WebAccountScope; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderBaseReportOperation
  Authentication_Web_Provider_IWebAccountProviderBaseReportOperation = interface(IInspectable)
  ['{BBA4ACBB-993B-4D57-BBE4-1421E3668B4C}']
    procedure ReportCompleted; safecall;
    procedure ReportError(value: Authentication_Web_Core_IWebProviderError); safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderUIReportOperation
  Authentication_Web_Provider_IWebAccountProviderUIReportOperation = interface(IInspectable)
  ['{28FF92D3-8F80-42FB-944F-B2107BBD42E6}']
    procedure ReportUserCanceled; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderSilentReportOperation
  Authentication_Web_Provider_IWebAccountProviderSilentReportOperation = interface(IInspectable)
  ['{E0B545F8-3B0F-44DA-924C-7B18BAAA62A9}']
    procedure ReportUserInteractionRequired; overload; safecall;
    procedure ReportUserInteractionRequired(value: Authentication_Web_Core_IWebProviderError); overload; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IIterator_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface(IInspectable)
  ['{D4F07AD8-A677-5846-BFE8-035699DF4227}']
    function get_Current: Authentication_Web_Provider_IWebProviderTokenResponse; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PAuthentication_Web_Provider_IWebProviderTokenResponse): Cardinal; safecall;
    property Current: Authentication_Web_Provider_IWebProviderTokenResponse read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IIterable_1__Authentication_Web_Provider_IWebProviderTokenResponse_Base = interface(IInspectable)
  ['{E9BAC236-C077-553A-B4AE-B58FB0B89918}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IIterable_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface(IIterable_1__Authentication_Web_Provider_IWebProviderTokenResponse_Base)
  ['{A11FFD59-F667-536C-8505-232BCC190D06}']
    function First: IIterator_1__Authentication_Web_Provider_IWebProviderTokenResponse; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IVectorView_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface(IInspectable)
  ['{DFFEEDD9-AC45-5F45-9034-9546DE605FE9}']
    function GetAt(index: Cardinal): Authentication_Web_Provider_IWebProviderTokenResponse; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Authentication_Web_Provider_IWebProviderTokenResponse; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PAuthentication_Web_Provider_IWebProviderTokenResponse): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponse>
  IVector_1__Authentication_Web_Provider_IWebProviderTokenResponse = interface(IInspectable)
  ['{F5CDB8F8-CDF3-56BA-81A6-9CF52E23870D}']
    function GetAt(index: Cardinal): Authentication_Web_Provider_IWebProviderTokenResponse; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Authentication_Web_Provider_IWebProviderTokenResponse; safecall;
    function IndexOf(value: Authentication_Web_Provider_IWebProviderTokenResponse; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Authentication_Web_Provider_IWebProviderTokenResponse); safecall;
    procedure InsertAt(index: Cardinal; value: Authentication_Web_Provider_IWebProviderTokenResponse); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Authentication_Web_Provider_IWebProviderTokenResponse); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PAuthentication_Web_Provider_IWebProviderTokenResponse): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PAuthentication_Web_Provider_IWebProviderTokenResponse); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderTokenOperation
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountProviderGetTokenSilentOperation)]
  Authentication_Web_Provider_IWebAccountProviderTokenOperation = interface(IInspectable)
  ['{95C613BE-2034-4C38-9434-D26C14B2B4B2}']
    function get_ProviderRequest: Authentication_Web_Provider_IWebProviderTokenRequest; safecall;
    function get_ProviderResponses: IVector_1__Authentication_Web_Provider_IWebProviderTokenResponse; safecall;
    procedure put_CacheExpirationTime(value: DateTime); safecall;
    function get_CacheExpirationTime: DateTime; safecall;
    property CacheExpirationTime: DateTime read get_CacheExpirationTime write put_CacheExpirationTime;
    property ProviderRequest: Authentication_Web_Provider_IWebProviderTokenRequest read get_ProviderRequest;
    property ProviderResponses: IVector_1__Authentication_Web_Provider_IWebProviderTokenResponse read get_ProviderResponses;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderAddAccountOperation
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountProviderAddAccountOperation)]
  Authentication_Web_Provider_IWebAccountProviderAddAccountOperation = interface(IInspectable)
  ['{73EBDCCF-4378-4C79-9335-A5D7AB81594E}']
    procedure ReportCompleted; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderManageAccountOperation
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountProviderManageAccountOperation)]
  Authentication_Web_Provider_IWebAccountProviderManageAccountOperation = interface(IInspectable)
  ['{ED20DC5C-D21B-463E-A9B7-C1FD0EDAE978}']
    function get_WebAccount: IWebAccount; safecall;
    procedure ReportCompleted; safecall;
    property WebAccount: IWebAccount read get_WebAccount;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderDeleteAccountOperation
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountProviderDeleteAccountOperation)]
  Authentication_Web_Provider_IWebAccountProviderDeleteAccountOperation = interface(IInspectable)
  ['{0ABB48B8-9E01-49C9-A355-7D48CAF7D6CA}']
    function get_WebAccount: IWebAccount; safecall;
    property WebAccount: IWebAccount read get_WebAccount;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderSignOutAccountOperation
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountProviderSignOutAccountOperation)]
  Authentication_Web_Provider_IWebAccountProviderSignOutAccountOperation = interface(IInspectable)
  ['{B890E21D-0C55-47BC-8C72-04A6FC7CAC07}']
    function get_WebAccount: IWebAccount; safecall;
    function get_ApplicationCallbackUri: IUriRuntimeClass; safecall;
    function get_ClientId: HSTRING; safecall;
    property ApplicationCallbackUri: IUriRuntimeClass read get_ApplicationCallbackUri;
    property ClientId: HSTRING read get_ClientId;
    property WebAccount: IWebAccount read get_WebAccount;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderRetrieveCookiesOperation
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountProviderRetrieveCookiesOperation)]
  Authentication_Web_Provider_IWebAccountProviderRetrieveCookiesOperation = interface(IInspectable)
  ['{5A040441-0FA3-4AB1-A01C-20B110358594}']
    function get_Context: IUriRuntimeClass; safecall;
    function get_Cookies: IInspectable{IVector_1__Http_IHttpCookie}; safecall;
    procedure put_Uri(uri: IUriRuntimeClass); safecall;
    function get_Uri: IUriRuntimeClass; safecall;
    function get_ApplicationCallbackUri: IUriRuntimeClass; safecall;
    property ApplicationCallbackUri: IUriRuntimeClass read get_ApplicationCallbackUri;
    property Context: IUriRuntimeClass read get_Context;
    property Cookies: IInspectable{IVector_1__Http_IHttpCookie} read get_Cookies;
    property Uri: IUriRuntimeClass read get_Uri write put_Uri;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Provider.IWebAccountProviderTokenObjects
  [WinRTClassNameAttribute(SAuthentication_Web_Provider_WebAccountProviderTriggerDetails)]
  Authentication_Web_Provider_IWebAccountProviderTokenObjects = interface(IInspectable)
  ['{408F284B-1328-42DB-89A4-0BCE7A717D8E}']
    function get_Operation: Authentication_Web_Provider_IWebAccountProviderOperation; safecall;
    property Operation: Authentication_Web_Provider_IWebAccountProviderOperation read get_Operation;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebProviderErrorFactory
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebProviderError)]
  Authentication_Web_Core_IWebProviderErrorFactory = interface(IInspectable)
  ['{E3C40A2D-89EF-4E37-847F-A8B9D5A32910}']
    function Create(errorCode: Cardinal; errorMessage: HSTRING): Authentication_Web_Core_IWebProviderError; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Authentication.Web.Core.IWebTokenResponseFactory
  [WinRTClassNameAttribute(SAuthentication_Web_Core_WebTokenResponse)]
  Authentication_Web_Core_IWebTokenResponseFactory = interface(IInspectable)
  ['{AB6BF7F8-5450-4EF6-97F7-052B0431C0F0}']
    function CreateWithToken(token: HSTRING): Authentication_Web_Core_IWebTokenResponse; safecall;
    function CreateWithTokenAndAccount(token: HSTRING; webAccount: IWebAccount): Authentication_Web_Core_IWebTokenResponse; safecall;
    function CreateWithTokenAccountAndError(token: HSTRING; webAccount: IWebAccount; error: Authentication_Web_Core_IWebProviderError): Authentication_Web_Core_IWebTokenResponse; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.FileProtectionStatus>
  AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus_Delegate_Base = interface(IUnknown)
  ['{E104F25B-B957-5ED4-B1C5-1993604CFEAE}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.FileProtectionStatus>
  AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus = interface(AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_FileProtectionStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.FileProtectionStatus>
  IAsyncOperation_1__EnterpriseData_FileProtectionStatus_Base = interface(IInspectable)
  ['{033EFE7C-709E-53A8-8E64-CDAB6BD1ED59}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.FileProtectionStatus>
  IAsyncOperation_1__EnterpriseData_FileProtectionStatus = interface(IAsyncOperation_1__EnterpriseData_FileProtectionStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus; safecall;
    function GetResults: EnterpriseData_FileProtectionStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_FileProtectionStatus read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IFileRevocationManagerStatics
  [WinRTClassNameAttribute(SEnterpriseData_FileRevocationManager)]
  EnterpriseData_IFileRevocationManagerStatics = interface(IInspectable)
  ['{256BBC3D-1C5D-4260-8C75-9144CFB78BA9}']
    function ProtectAsync(storageItem: IStorageItem; enterpriseIdentity: HSTRING): IAsyncOperation_1__EnterpriseData_FileProtectionStatus; safecall;
    function CopyProtectionAsync(sourceStorageItem: IStorageItem; targetStorageItem: IStorageItem): IAsyncOperation_1__Boolean; safecall;
    procedure Revoke(enterpriseIdentity: HSTRING); safecall;
    function GetStatusAsync(storageItem: IStorageItem): IAsyncOperation_1__EnterpriseData_FileProtectionStatus; safecall;
  end deprecated;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IFileProtectionInfo
  [WinRTClassNameAttribute(SEnterpriseData_FileProtectionInfo)]
  EnterpriseData_IFileProtectionInfo = interface(IInspectable)
  ['{4EE96486-147E-4DD0-8FAF-5253ED91AD0C}']
    function get_Status: EnterpriseData_FileProtectionStatus; safecall;
    function get_IsRoamable: Boolean; safecall;
    function get_Identity: HSTRING; safecall;
    property Identity: HSTRING read get_Identity;
    property IsRoamable: Boolean read get_IsRoamable;
    property Status: EnterpriseData_FileProtectionStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IFileProtectionInfo>
  AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo_Delegate_Base = interface(IUnknown)
  ['{2918FFEA-E091-53E2-BDE5-617C9BB3D8FE}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IFileProtectionInfo>
  AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo = interface(AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo_Delegate_Base)
  ['{47807413-C271-59C5-A2F4-08C8A2AEC22D}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_IFileProtectionInfo; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IFileProtectionInfo>
  IAsyncOperation_1__EnterpriseData_IFileProtectionInfo_Base = interface(IInspectable)
  ['{67E04591-2D11-5018-9FF0-0B85520B888B}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IFileProtectionInfo>
  IAsyncOperation_1__EnterpriseData_IFileProtectionInfo = interface(IAsyncOperation_1__EnterpriseData_IFileProtectionInfo_Base)
  ['{989A307F-4554-565E-A161-D20734D4522E}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo; safecall;
    function GetResults: EnterpriseData_IFileProtectionInfo; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IFileProtectionInfo read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectedContainerExportResult
  [WinRTClassNameAttribute(SEnterpriseData_ProtectedContainerExportResult)]
  EnterpriseData_IProtectedContainerExportResult = interface(IInspectable)
  ['{3948EF95-F7FB-4B42-AFB0-DF70B41543C1}']
    function get_Status: EnterpriseData_ProtectedImportExportStatus; safecall;
    function get_File: IStorageFile; safecall;
    property &File: IStorageFile read get_File;
    property Status: EnterpriseData_ProtectedImportExportStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedContainerExportResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult_Delegate_Base = interface(IUnknown)
  ['{560C5521-5008-5272-A766-941F70718BC6}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedContainerExportResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult = interface(AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult_Delegate_Base)
  ['{B3C8B728-2CDF-5BC6-B75E-5F2BA085988D}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedContainerExportResult>
  IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult_Base = interface(IInspectable)
  ['{C99F0B2E-67AD-518A-866F-E39B4567B110}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedContainerExportResult>
  IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult = interface(IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult_Base)
  ['{30D5918D-F3DB-5249-B81E-D369047AF8A8}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult; safecall;
    function GetResults: EnterpriseData_IProtectedContainerExportResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerExportResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectedContainerImportResult
  [WinRTClassNameAttribute(SEnterpriseData_ProtectedContainerImportResult)]
  EnterpriseData_IProtectedContainerImportResult = interface(IInspectable)
  ['{CDB780D1-E7BB-4D1A-9339-34DC41149F9B}']
    function get_Status: EnterpriseData_ProtectedImportExportStatus; safecall;
    function get_File: IStorageFile; safecall;
    property &File: IStorageFile read get_File;
    property Status: EnterpriseData_ProtectedImportExportStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedContainerImportResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult_Delegate_Base = interface(IUnknown)
  ['{CFEA00F8-D2AD-5AD2-A396-E4F71B9A7C3F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedContainerImportResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult = interface(AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult_Delegate_Base)
  ['{6216C4E3-8995-531A-8629-149D190A7C37}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedContainerImportResult>
  IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult_Base = interface(IInspectable)
  ['{384E9499-D491-5297-BEBA-B33A3D67F207}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedContainerImportResult>
  IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult = interface(IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult_Base)
  ['{9B7EBD1A-6A2E-5D10-B342-B658A0039154}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult; safecall;
    function GetResults: EnterpriseData_IProtectedContainerImportResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedContainerImportResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectedFileCreateResult
  [WinRTClassNameAttribute(SEnterpriseData_ProtectedFileCreateResult)]
  EnterpriseData_IProtectedFileCreateResult = interface(IInspectable)
  ['{28E3ED6A-E9E7-4A03-9F53-BDB16172699B}']
    function get_File: IStorageFile; safecall;
    function get_Stream: IRandomAccessStream; safecall;
    function get_ProtectionInfo: EnterpriseData_IFileProtectionInfo; safecall;
    property &File: IStorageFile read get_File;
    property ProtectionInfo: EnterpriseData_IFileProtectionInfo read get_ProtectionInfo;
    property Stream: IRandomAccessStream read get_Stream;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedFileCreateResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult_Delegate_Base = interface(IUnknown)
  ['{6C44A868-7C80-5187-A08D-379BE41909F6}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IProtectedFileCreateResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult = interface(AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult_Delegate_Base)
  ['{432F8879-BB8B-5DE7-8003-B4588DCAD2E6}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedFileCreateResult>
  IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult_Base = interface(IInspectable)
  ['{D7F98A9C-738E-50F6-93E3-2608BAF54BE9}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IProtectedFileCreateResult>
  IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult = interface(IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult_Base)
  ['{D2A15153-2B9D-5F4B-A384-365C1B8973EA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult; safecall;
    function GetResults: EnterpriseData_IProtectedFileCreateResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IProtectedFileCreateResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IFileProtectionManagerStatics
  [WinRTClassNameAttribute(SEnterpriseData_FileProtectionManager)]
  EnterpriseData_IFileProtectionManagerStatics = interface(IInspectable)
  ['{5846FC9B-E613-426B-BB38-88CBA1DC9ADB}']
    function ProtectAsync(target: IStorageItem; identity: HSTRING): IAsyncOperation_1__EnterpriseData_IFileProtectionInfo; safecall;
    function CopyProtectionAsync(source: IStorageItem; target: IStorageItem): IAsyncOperation_1__Boolean; safecall;
    function GetProtectionInfoAsync(source: IStorageItem): IAsyncOperation_1__EnterpriseData_IFileProtectionInfo; safecall;
    function SaveFileAsContainerAsync(protectedFile: IStorageFile): IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult; safecall;
    function LoadFileFromContainerAsync(containerFile: IStorageFile): IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult; overload; safecall;
    function LoadFileFromContainerAsync(containerFile: IStorageFile; target: IStorageItem): IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult; overload; safecall;
    function CreateProtectedAndOpenAsync(parentFolder: IStorageFolder; desiredName: HSTRING; identity: HSTRING; collisionOption: CreationCollisionOption): IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IDataProtectionInfo
  [WinRTClassNameAttribute(SEnterpriseData_DataProtectionInfo)]
  EnterpriseData_IDataProtectionInfo = interface(IInspectable)
  ['{8420B0C1-5E31-4405-9540-3F943AF0CB26}']
    function get_Status: EnterpriseData_DataProtectionStatus; safecall;
    function get_Identity: HSTRING; safecall;
    property Identity: HSTRING read get_Identity;
    property Status: EnterpriseData_DataProtectionStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IBufferProtectUnprotectResult
  [WinRTClassNameAttribute(SEnterpriseData_BufferProtectUnprotectResult)]
  EnterpriseData_IBufferProtectUnprotectResult = interface(IInspectable)
  ['{47995EDC-6CEC-4E3A-B251-9E7485D79E7A}']
    function get_Buffer: IBuffer; safecall;
    function get_ProtectionInfo: EnterpriseData_IDataProtectionInfo; safecall;
    property Buffer: IBuffer read get_Buffer;
    property ProtectionInfo: EnterpriseData_IDataProtectionInfo read get_ProtectionInfo;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IBufferProtectUnprotectResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult_Delegate_Base = interface(IUnknown)
  ['{73D780CB-AD38-59E6-A236-CC0DF69F15A8}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IBufferProtectUnprotectResult>
  AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult = interface(AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult_Delegate_Base)
  ['{D1341AEB-476E-5F19-BE77-32BA3EF0C3B5}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IBufferProtectUnprotectResult>
  IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult_Base = interface(IInspectable)
  ['{11F95A2E-2E87-5449-BCA3-DCDF2AE6E17A}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IBufferProtectUnprotectResult>
  IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult = interface(IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult_Base)
  ['{7482F267-5E6F-5F4D-AEEA-6E782AAF3980}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult; safecall;
    function GetResults: EnterpriseData_IBufferProtectUnprotectResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IBufferProtectUnprotectResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IDataProtectionInfo>
  AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo_Delegate_Base = interface(IUnknown)
  ['{E12BB475-3F2B-51C9-83C6-A5661086B6C3}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.EnterpriseData.IDataProtectionInfo>
  AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo = interface(AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo_Delegate_Base)
  ['{84BFF12D-AD5A-53DE-8DA4-8F2F213C7C76}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IDataProtectionInfo>
  IAsyncOperation_1__EnterpriseData_IDataProtectionInfo_Base = interface(IInspectable)
  ['{C8EF3F16-DD70-5E88-9323-85DDDDCD2CA5}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.EnterpriseData.IDataProtectionInfo>
  IAsyncOperation_1__EnterpriseData_IDataProtectionInfo = interface(IAsyncOperation_1__EnterpriseData_IDataProtectionInfo_Base)
  ['{76A96925-B906-5D95-A98E-84BA5D758258}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo; safecall;
    function GetResults: EnterpriseData_IDataProtectionInfo; safecall;
    property Completed: AsyncOperationCompletedHandler_1__EnterpriseData_IDataProtectionInfo read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IDataProtectionManagerStatics
  [WinRTClassNameAttribute(SEnterpriseData_DataProtectionManager)]
  EnterpriseData_IDataProtectionManagerStatics = interface(IInspectable)
  ['{B6149B74-9144-4EE4-8A8A-30B5F361430E}']
    function ProtectAsync(data: IBuffer; identity: HSTRING): IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult; safecall;
    function UnprotectAsync(data: IBuffer): IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult; safecall;
    function ProtectStreamAsync(unprotectedStream: IInputStream; identity: HSTRING; protectedStream: IOutputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; safecall;
    function UnprotectStreamAsync(protectedStream: IInputStream; unprotectedStream: IOutputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; safecall;
    function GetProtectionInfoAsync(protectedData: IBuffer): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; safecall;
    function GetStreamProtectionInfoAsync(protectedStream: IInputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectionPolicyManager
  [WinRTClassNameAttribute(SEnterpriseData_ProtectionPolicyManager)]
  EnterpriseData_IProtectionPolicyManager = interface(IInspectable)
  ['{D5703E18-A08D-47E6-A240-9934D7165EB5}']
    procedure put_Identity(value: HSTRING); safecall;
    function get_Identity: HSTRING; safecall;
    property Identity: HSTRING read get_Identity write put_Identity;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IThreadNetworkContext
  [WinRTClassNameAttribute(SEnterpriseData_ThreadNetworkContext)]
  EnterpriseData_IThreadNetworkContext = interface(IInspectable)
  ['{FA4EA8E9-EF13-405A-B12C-D7348C6F41FC}']
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectedAccessSuspendingEventArgs
  [WinRTClassNameAttribute(SEnterpriseData_ProtectedAccessSuspendingEventArgs)]
  EnterpriseData_IProtectedAccessSuspendingEventArgs = interface(IInspectable)
  ['{75A193E0-A344-429F-B975-04FC1F88C185}']
    function get_Identities: IVectorView_1__HSTRING; safecall;
    function get_Deadline: DateTime; safecall;
    function GetDeferral: IDeferral; safecall;
    property Deadline: DateTime read get_Deadline;
    property Identities: IVectorView_1__HSTRING read get_Identities;
  end;

  // Generic Delegate for 
  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedAccessSuspendingEventArgs>
  EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs_Delegate_Base = interface(IUnknown)
  ['{FE8BB4D8-0D3D-5416-B390-9EAD5DD9B384}']
  end;
  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedAccessSuspendingEventArgs>
  EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs = interface(EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs_Delegate_Base)
  ['{D8E44E77-2784-5E85-8F85-E53D60557020}']
    procedure Invoke(sender: IInspectable; args: EnterpriseData_IProtectedAccessSuspendingEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectedAccessResumedEventArgs
  [WinRTClassNameAttribute(SEnterpriseData_ProtectedAccessResumedEventArgs)]
  EnterpriseData_IProtectedAccessResumedEventArgs = interface(IInspectable)
  ['{AC4DCA59-5D80-4E95-8C5F-8539450EEBE0}']
    function get_Identities: IVectorView_1__HSTRING; safecall;
    property Identities: IVectorView_1__HSTRING read get_Identities;
  end;

  // Generic Delegate for 
  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedAccessResumedEventArgs>
  EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs_Delegate_Base = interface(IUnknown)
  ['{9EFE4D36-6549-5222-9BC2-4D5D929D005C}']
  end;
  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedAccessResumedEventArgs>
  EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs = interface(EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs_Delegate_Base)
  ['{1496933D-E4C9-5242-BA9D-3AE36BE32697}']
    procedure Invoke(sender: IInspectable; args: EnterpriseData_IProtectedAccessResumedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectedContentRevokedEventArgs
  [WinRTClassNameAttribute(SEnterpriseData_ProtectedContentRevokedEventArgs)]
  EnterpriseData_IProtectedContentRevokedEventArgs = interface(IInspectable)
  ['{63686821-58B9-47EE-93D9-F0F741CF43F0}']
    function get_Identities: IVectorView_1__HSTRING; safecall;
    property Identities: IVectorView_1__HSTRING read get_Identities;
  end;

  // Generic Delegate for 
  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedContentRevokedEventArgs>
  EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs_Delegate_Base = interface(IUnknown)
  ['{4FF76357-6805-573E-A67D-2C594F5004B7}']
  end;
  // Windows.Foundation.EventHandler`1<Windows.Security.EnterpriseData.IProtectedContentRevokedEventArgs>
  EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs = interface(EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs_Delegate_Base)
  ['{D4BE21D1-DC3D-526C-B8FF-009700227E82}']
    procedure Invoke(sender: IInspectable; args: EnterpriseData_IProtectedContentRevokedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Security.EnterpriseData.IProtectionPolicyManagerStatics
  [WinRTClassNameAttribute(SEnterpriseData_ProtectionPolicyManager)]
  EnterpriseData_IProtectionPolicyManagerStatics = interface(IInspectable)
  ['{C0BFFC66-8C3D-4D56-8804-C68F0AD32EC5}']
    function IsIdentityManaged(identity: HSTRING): Boolean; safecall;
    function TryApplyProcessUIPolicy(identity: HSTRING): Boolean; safecall;
    procedure ClearProcessUIPolicy; safecall;
    function CreateCurrentThreadNetworkContext(identity: HSTRING): EnterpriseData_IThreadNetworkContext; safecall;
    function GetPrimaryManagedIdentityForNetworkEndpointAsync(endpointHost: IInspectable{IHostName}): IAsyncOperation_1__HSTRING; safecall;
    procedure RevokeContent(identity: HSTRING); safecall;
    function GetForCurrentView: EnterpriseData_IProtectionPolicyManager; safecall;
    function add_ProtectedAccessSuspending(handler: EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs): EventRegistrationToken; safecall;
    procedure remove_ProtectedAccessSuspending(token: EventRegistrationToken); safecall;
    function add_ProtectedAccessResumed(handler: EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ProtectedAccessResumed(token: EventRegistrationToken); safecall;
    function add_ProtectedContentRevoked(handler: EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ProtectedContentRevoked(token: EventRegistrationToken); safecall;
    function CheckAccess(sourceIdentity: HSTRING; targetIdentity: HSTRING): EnterpriseData_ProtectionPolicyEvaluationResult; safecall;
    function RequestAccessAsync(sourceIdentity: HSTRING; targetIdentity: HSTRING): IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult; safecall;
  end;


  // Emit Forwarded classes
  // Windows.Security.Authentication.Web.Core.WebTokenRequest
  // DualAPI
  TAuthentication_Web_Core_WebTokenRequest = class(TWinRTGenericImportF<Authentication_Web_Core_IWebTokenRequestFactory>)
  public
    // -> Authentication_Web_Core_IWebTokenRequestFactory
    class function Create(provider: IWebAccountProvider; scope: HSTRING; clientId: HSTRING): Authentication_Web_Core_IWebTokenRequest; static; inline;
    class function CreateWithPromptType(provider: IWebAccountProvider; scope: HSTRING; clientId: HSTRING; promptType: Authentication_Web_Core_WebTokenRequestPromptType): Authentication_Web_Core_IWebTokenRequest; static; inline;
    class function CreateWithProvider(provider: IWebAccountProvider): Authentication_Web_Core_IWebTokenRequest; static; inline;
    class function CreateWithScope(provider: IWebAccountProvider; scope: HSTRING): Authentication_Web_Core_IWebTokenRequest; static; inline;
  end;

  // Windows.Security.Authentication.Web.Core.WebAuthenticationCoreManager
  // DualAPI
  IWebAuthenticationCoreManagerInterop = interface(IInspectable)
  ['{F4B8E804-811E-4436-B69C-44CB67B72084}']
    function RequestTokenForWindowAsync(appWindow: THandle; request: IInspectable; const riid: TGUID): IAsyncInfo; safecall;
    function RequestTokenWithWebAccountForWindowAsync(appWindow: THandle; request, webAccount: IInspectable; const riid: TGUID): IAsyncInfo; safecall;
  end;
  TAuthentication_Web_Core_WebAuthenticationCoreManager = class(TWinRTGenericImportS2O<Authentication_Web_Core_IWebAuthenticationCoreManagerStatics, Authentication_Web_Core_IWebAuthenticationCoreManagerStatics2, IWebAuthenticationCoreManagerInterop>)
  public
    // -> Authentication_Web_Core_IWebAuthenticationCoreManagerStatics2
    class function FindAccountProviderAsync(webAccountProviderId: HSTRING; authority: HSTRING; user: IInspectable{IUser}): IAsyncOperation_1__IWebAccountProvider; overload; static; inline;

    // -> Authentication_Web_Core_IWebAuthenticationCoreManagerStatics
    class function GetTokenSilentlyAsync(request: Authentication_Web_Core_IWebTokenRequest): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; static; inline;
    class function GetTokenSilentlyAsync(request: Authentication_Web_Core_IWebTokenRequest; webAccount: IWebAccount): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; static; inline;
    class function RequestTokenAsync(request: Authentication_Web_Core_IWebTokenRequest): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; static; inline;
    class function RequestTokenAsync(request: Authentication_Web_Core_IWebTokenRequest; webAccount: IWebAccount): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult; overload; static; inline;
    class function FindAccountAsync(provider: IWebAccountProvider; webAccountId: HSTRING): IAsyncOperation_1__IWebAccount; static; inline;
    class function FindAccountProviderAsync(webAccountProviderId: HSTRING): IAsyncOperation_1__IWebAccountProvider; overload; static; inline;
    class function FindAccountProviderAsync(webAccountProviderId: HSTRING; authority: HSTRING): IAsyncOperation_1__IWebAccountProvider; overload; static; inline;
  end;

  // Windows.Security.Authentication.Web.Provider.WebProviderTokenRequest
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebProviderTokenResponse
  // DualAPI
  TAuthentication_Web_Provider_WebProviderTokenResponse = class(TWinRTGenericImportF<Authentication_Web_Provider_IWebProviderTokenResponseFactory>)
  public
    // -> Authentication_Web_Provider_IWebProviderTokenResponseFactory
    class function Create(webTokenResponse: Authentication_Web_Core_IWebTokenResponse): Authentication_Web_Provider_IWebProviderTokenResponse; static; inline;
  end;

  // Windows.Security.Authentication.Web.Provider.WebAccountClientView
  // DualAPI
  TAuthentication_Web_Provider_WebAccountClientView = class(TWinRTGenericImportF<Authentication_Web_Provider_IWebAccountClientViewFactory>)
  public
    // -> Authentication_Web_Provider_IWebAccountClientViewFactory
    class function Create(viewType: Authentication_Web_Provider_WebAccountClientViewType; applicationCallbackUri: IUriRuntimeClass): Authentication_Web_Provider_IWebAccountClientView; static; inline;
    class function CreateWithPairwiseId(viewType: Authentication_Web_Provider_WebAccountClientViewType; applicationCallbackUri: IUriRuntimeClass; accountPairwiseId: HSTRING): Authentication_Web_Provider_IWebAccountClientView; static; inline;
  end;

  // Windows.Security.Authentication.Web.Provider.WebAccountManager
  // DualAPI
  TAuthentication_Web_Provider_WebAccountManager = class(TWinRTGenericImportS2<Authentication_Web_Provider_IWebAccountManagerStatics, Authentication_Web_Provider_IWebAccountScopeManagerStatics>)
  public
    // -> Authentication_Web_Provider_IWebAccountManagerStatics
    class function UpdateWebAccountPropertiesAsync(webAccount: IWebAccount; webAccountUserName: HSTRING; additionalProperties: IMapView_2__HSTRING__HSTRING): IAsyncAction; static; inline;
    class function AddWebAccountAsync(webAccountId: HSTRING; webAccountUserName: HSTRING; props: IMapView_2__HSTRING__HSTRING): IAsyncOperation_1__IWebAccount; overload; static; inline;
    class function DeleteWebAccountAsync(webAccount: IWebAccount): IAsyncAction; static; inline;
    class function FindAllProviderWebAccountsAsync: IAsyncOperation_1__IVectorView_1__IWebAccount; static; inline;
    class function PushCookiesAsync(uri: IUriRuntimeClass; cookies: IVectorView_1__Http_IHttpCookie): IAsyncAction; static; inline;
    class function SetViewAsync(webAccount: IWebAccount; view: Authentication_Web_Provider_IWebAccountClientView): IAsyncAction; static; inline;
    class function ClearViewAsync(webAccount: IWebAccount; applicationCallbackUri: IUriRuntimeClass): IAsyncAction; static; inline;
    class function GetViewsAsync(webAccount: IWebAccount): IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView; static; inline;
    class function SetWebAccountPictureAsync(webAccount: IWebAccount; webAccountPicture: IRandomAccessStream): IAsyncAction; static; inline;
    class function ClearWebAccountPictureAsync(webAccount: IWebAccount): IAsyncAction; static; inline;

    // -> Authentication_Web_Provider_IWebAccountScopeManagerStatics
    class function AddWebAccountAsync(webAccountId: HSTRING; webAccountUserName: HSTRING; props: IMapView_2__HSTRING__HSTRING; scope: Authentication_Web_Provider_WebAccountScope): IAsyncOperation_1__IWebAccount; overload; static; inline;
    class function SetScopeAsync(webAccount: IWebAccount; scope: Authentication_Web_Provider_WebAccountScope): IAsyncAction; static; inline;
    class function GetScope(webAccount: IWebAccount): Authentication_Web_Provider_WebAccountScope; static; inline;
  end;

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderRequestTokenOperation
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderGetTokenSilentOperation
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderAddAccountOperation
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderManageAccountOperation
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderDeleteAccountOperation
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderSignOutAccountOperation
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderRetrieveCookiesOperation
  // DualAPI

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderTriggerDetails
  // DualAPI

  // Windows.Security.Authentication.Web.Core.WebProviderError
  // DualAPI
  TAuthentication_Web_Core_WebProviderError = class(TWinRTGenericImportF<Authentication_Web_Core_IWebProviderErrorFactory>)
  public
    // -> Authentication_Web_Core_IWebProviderErrorFactory
    class function Create(errorCode: Cardinal; errorMessage: HSTRING): Authentication_Web_Core_IWebProviderError; static; inline;
  end;

  // Windows.Security.Authentication.Web.Core.WebTokenResponse
  // DualAPI
  TAuthentication_Web_Core_WebTokenResponse = class(TWinRTGenericImportFI<Authentication_Web_Core_IWebTokenResponseFactory, Authentication_Web_Core_IWebTokenResponse>)
  public
    // -> Authentication_Web_Core_IWebTokenResponseFactory
    class function CreateWithToken(token: HSTRING): Authentication_Web_Core_IWebTokenResponse; static; inline;
    class function CreateWithTokenAndAccount(token: HSTRING; webAccount: IWebAccount): Authentication_Web_Core_IWebTokenResponse; static; inline;
    class function CreateWithTokenAccountAndError(token: HSTRING; webAccount: IWebAccount; error: Authentication_Web_Core_IWebProviderError): Authentication_Web_Core_IWebTokenResponse; static; inline;
  end;

  // Windows.Security.Authentication.Web.Core.WebTokenRequestResult
  // DualAPI

  // Windows.Security.EnterpriseData.FileProtectionInfo
  // DualAPI

  // Windows.Security.EnterpriseData.ProtectedContainerExportResult
  // DualAPI

  // Windows.Security.EnterpriseData.ProtectedContainerImportResult
  // DualAPI

  // Windows.Security.EnterpriseData.ProtectedFileCreateResult
  // DualAPI

  // Windows.Security.EnterpriseData.BufferProtectUnprotectResult
  // DualAPI

  // Windows.Security.EnterpriseData.DataProtectionInfo
  // DualAPI

  // Windows.Security.EnterpriseData.ThreadNetworkContext
  // DualAPI

  // Windows.Security.EnterpriseData.ProtectionPolicyManager
  // DualAPI
  TEnterpriseData_ProtectionPolicyManager = class(TWinRTGenericImportS<EnterpriseData_IProtectionPolicyManagerStatics>)
  public
    // -> EnterpriseData_IProtectionPolicyManagerStatics
    class function IsIdentityManaged(identity: HSTRING): Boolean; static; inline;
    class function TryApplyProcessUIPolicy(identity: HSTRING): Boolean; static; inline;
    class procedure ClearProcessUIPolicy; static; inline;
    class function CreateCurrentThreadNetworkContext(identity: HSTRING): EnterpriseData_IThreadNetworkContext; static; inline;
    class function GetPrimaryManagedIdentityForNetworkEndpointAsync(endpointHost: IInspectable{IHostName}): IAsyncOperation_1__HSTRING; static; inline;
    class procedure RevokeContent(identity: HSTRING); static; inline;
    class function GetForCurrentView: EnterpriseData_IProtectionPolicyManager; static; inline;
    class function add_ProtectedAccessSuspending(handler: EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs): EventRegistrationToken; static; inline;
    class procedure remove_ProtectedAccessSuspending(token: EventRegistrationToken); static; inline;
    class function add_ProtectedAccessResumed(handler: EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs): EventRegistrationToken; static; inline;
    class procedure remove_ProtectedAccessResumed(token: EventRegistrationToken); static; inline;
    class function add_ProtectedContentRevoked(handler: EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs): EventRegistrationToken; static; inline;
    class procedure remove_ProtectedContentRevoked(token: EventRegistrationToken); static; inline;
    class function CheckAccess(sourceIdentity: HSTRING; targetIdentity: HSTRING): EnterpriseData_ProtectionPolicyEvaluationResult; static; inline;
    class function RequestAccessAsync(sourceIdentity: HSTRING; targetIdentity: HSTRING): IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult; static; inline;
  end;

  // Windows.Security.EnterpriseData.ProtectedAccessSuspendingEventArgs
  // DualAPI

  // Windows.Security.EnterpriseData.ProtectedAccessResumedEventArgs
  // DualAPI

  // Windows.Security.EnterpriseData.ProtectedContentRevokedEventArgs
  // DualAPI

  // Windows.Security.EnterpriseData.FileRevocationManager
  // DualAPI
  TEnterpriseData_FileRevocationManager = class(TWinRTGenericImportS<EnterpriseData_IFileRevocationManagerStatics>)
  public
    // -> EnterpriseData_IFileRevocationManagerStatics
    class function ProtectAsync(storageItem: IStorageItem; enterpriseIdentity: HSTRING): IAsyncOperation_1__EnterpriseData_FileProtectionStatus; static; inline;
    class function CopyProtectionAsync(sourceStorageItem: IStorageItem; targetStorageItem: IStorageItem): IAsyncOperation_1__Boolean; static; inline;
    class procedure Revoke(enterpriseIdentity: HSTRING); static; inline;
    class function GetStatusAsync(storageItem: IStorageItem): IAsyncOperation_1__EnterpriseData_FileProtectionStatus; static; inline;
  end;

  // Windows.Security.EnterpriseData.FileProtectionManager
  // DualAPI
  TEnterpriseData_FileProtectionManager = class(TWinRTGenericImportS<EnterpriseData_IFileProtectionManagerStatics>)
  public
    // -> EnterpriseData_IFileProtectionManagerStatics
    class function ProtectAsync(target: IStorageItem; identity: HSTRING): IAsyncOperation_1__EnterpriseData_IFileProtectionInfo; static; inline;
    class function CopyProtectionAsync(source: IStorageItem; target: IStorageItem): IAsyncOperation_1__Boolean; static; inline;
    class function GetProtectionInfoAsync(source: IStorageItem): IAsyncOperation_1__EnterpriseData_IFileProtectionInfo; static; inline;
    class function SaveFileAsContainerAsync(protectedFile: IStorageFile): IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult; static; inline;
    class function LoadFileFromContainerAsync(containerFile: IStorageFile): IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult; overload; static; inline;
    class function LoadFileFromContainerAsync(containerFile: IStorageFile; target: IStorageItem): IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult; overload; static; inline;
    class function CreateProtectedAndOpenAsync(parentFolder: IStorageFolder; desiredName: HSTRING; identity: HSTRING; collisionOption: CreationCollisionOption): IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult; static; inline;
  end;

  // Windows.Security.EnterpriseData.DataProtectionManager
  // DualAPI
  TEnterpriseData_DataProtectionManager = class(TWinRTGenericImportS<EnterpriseData_IDataProtectionManagerStatics>)
  public
    // -> EnterpriseData_IDataProtectionManagerStatics
    class function ProtectAsync(data: IBuffer; identity: HSTRING): IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult; static; inline;
    class function UnprotectAsync(data: IBuffer): IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult; static; inline;
    class function ProtectStreamAsync(unprotectedStream: IInputStream; identity: HSTRING; protectedStream: IOutputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; static; inline;
    class function UnprotectStreamAsync(protectedStream: IInputStream; unprotectedStream: IOutputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; static; inline;
    class function GetProtectionInfoAsync(protectedData: IBuffer): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; static; inline;
    class function GetStreamProtectionInfoAsync(protectedStream: IInputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TAuthentication_Web_Core_WebTokenRequest }
// Factories for : "Authentication_Web_Core_WebTokenRequest"
// Factory: "Windows.Security.Authentication.Web.Core.IWebTokenRequestFactory"
// -> Authentication_Web_Core_IWebTokenRequestFactory

class function TAuthentication_Web_Core_WebTokenRequest.Create(provider: IWebAccountProvider; scope: HSTRING; clientId: HSTRING): Authentication_Web_Core_IWebTokenRequest;
begin
  Result := Factory.Create(provider, scope, clientId);
end;

class function TAuthentication_Web_Core_WebTokenRequest.CreateWithPromptType(provider: IWebAccountProvider; scope: HSTRING; clientId: HSTRING; promptType: Authentication_Web_Core_WebTokenRequestPromptType): Authentication_Web_Core_IWebTokenRequest;
begin
  Result := Factory.CreateWithPromptType(provider, scope, clientId, promptType);
end;

class function TAuthentication_Web_Core_WebTokenRequest.CreateWithProvider(provider: IWebAccountProvider): Authentication_Web_Core_IWebTokenRequest;
begin
  Result := Factory.CreateWithProvider(provider);
end;

class function TAuthentication_Web_Core_WebTokenRequest.CreateWithScope(provider: IWebAccountProvider; scope: HSTRING): Authentication_Web_Core_IWebTokenRequest;
begin
  Result := Factory.CreateWithScope(provider, scope);
end;


 { TAuthentication_Web_Core_WebAuthenticationCoreManager }

class function TAuthentication_Web_Core_WebAuthenticationCoreManager.GetTokenSilentlyAsync(request: Authentication_Web_Core_IWebTokenRequest): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult;
begin
  Result := Statics.GetTokenSilentlyAsync(request);
end;

class function TAuthentication_Web_Core_WebAuthenticationCoreManager.GetTokenSilentlyAsync(request: Authentication_Web_Core_IWebTokenRequest; webAccount: IWebAccount): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult;
begin
  Result := Statics.GetTokenSilentlyAsync(request, webAccount);
end;

class function TAuthentication_Web_Core_WebAuthenticationCoreManager.RequestTokenAsync(request: Authentication_Web_Core_IWebTokenRequest): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult;
begin
  Result := Statics.RequestTokenAsync(request);
end;

class function TAuthentication_Web_Core_WebAuthenticationCoreManager.RequestTokenAsync(request: Authentication_Web_Core_IWebTokenRequest; webAccount: IWebAccount): IAsyncOperation_1__Authentication_Web_Core_IWebTokenRequestResult;
begin
  Result := Statics.RequestTokenAsync(request, webAccount);
end;

class function TAuthentication_Web_Core_WebAuthenticationCoreManager.FindAccountAsync(provider: IWebAccountProvider; webAccountId: HSTRING): IAsyncOperation_1__IWebAccount;
begin
  Result := Statics.FindAccountAsync(provider, webAccountId);
end;

class function TAuthentication_Web_Core_WebAuthenticationCoreManager.FindAccountProviderAsync(webAccountProviderId: HSTRING): IAsyncOperation_1__IWebAccountProvider;
begin
  Result := Statics.FindAccountProviderAsync(webAccountProviderId);
end;

class function TAuthentication_Web_Core_WebAuthenticationCoreManager.FindAccountProviderAsync(webAccountProviderId: HSTRING; authority: HSTRING): IAsyncOperation_1__IWebAccountProvider;
begin
  Result := Statics.FindAccountProviderAsync(webAccountProviderId, authority);
end;


class function TAuthentication_Web_Core_WebAuthenticationCoreManager.FindAccountProviderAsync(webAccountProviderId: HSTRING; authority: HSTRING; user: IInspectable{IUser}): IAsyncOperation_1__IWebAccountProvider;
begin
  Result := Statics2.FindAccountProviderAsync(webAccountProviderId, authority, user);
end;


 { TAuthentication_Web_Provider_WebProviderTokenResponse }
// Factories for : "Authentication_Web_Provider_WebProviderTokenResponse"
// Factory: "Windows.Security.Authentication.Web.Provider.IWebProviderTokenResponseFactory"
// -> Authentication_Web_Provider_IWebProviderTokenResponseFactory

class function TAuthentication_Web_Provider_WebProviderTokenResponse.Create(webTokenResponse: Authentication_Web_Core_IWebTokenResponse): Authentication_Web_Provider_IWebProviderTokenResponse;
begin
  Result := Factory.Create(webTokenResponse);
end;


 { TAuthentication_Web_Provider_WebAccountClientView }
// Factories for : "Authentication_Web_Provider_WebAccountClientView"
// Factory: "Windows.Security.Authentication.Web.Provider.IWebAccountClientViewFactory"
// -> Authentication_Web_Provider_IWebAccountClientViewFactory

class function TAuthentication_Web_Provider_WebAccountClientView.Create(viewType: Authentication_Web_Provider_WebAccountClientViewType; applicationCallbackUri: IUriRuntimeClass): Authentication_Web_Provider_IWebAccountClientView;
begin
  Result := Factory.Create(viewType, applicationCallbackUri);
end;

class function TAuthentication_Web_Provider_WebAccountClientView.CreateWithPairwiseId(viewType: Authentication_Web_Provider_WebAccountClientViewType; applicationCallbackUri: IUriRuntimeClass; accountPairwiseId: HSTRING): Authentication_Web_Provider_IWebAccountClientView;
begin
  Result := Factory.CreateWithPairwiseId(viewType, applicationCallbackUri, accountPairwiseId);
end;


 { TAuthentication_Web_Provider_WebAccountManager }

class function TAuthentication_Web_Provider_WebAccountManager.UpdateWebAccountPropertiesAsync(webAccount: IWebAccount; webAccountUserName: HSTRING; additionalProperties: IMapView_2__HSTRING__HSTRING): IAsyncAction;
begin
  Result := Statics.UpdateWebAccountPropertiesAsync(webAccount, webAccountUserName, additionalProperties);
end;

class function TAuthentication_Web_Provider_WebAccountManager.AddWebAccountAsync(webAccountId: HSTRING; webAccountUserName: HSTRING; props: IMapView_2__HSTRING__HSTRING): IAsyncOperation_1__IWebAccount;
begin
  Result := Statics.AddWebAccountAsync(webAccountId, webAccountUserName, props);
end;

class function TAuthentication_Web_Provider_WebAccountManager.DeleteWebAccountAsync(webAccount: IWebAccount): IAsyncAction;
begin
  Result := Statics.DeleteWebAccountAsync(webAccount);
end;

class function TAuthentication_Web_Provider_WebAccountManager.FindAllProviderWebAccountsAsync: IAsyncOperation_1__IVectorView_1__IWebAccount;
begin
  Result := Statics.FindAllProviderWebAccountsAsync;
end;

class function TAuthentication_Web_Provider_WebAccountManager.PushCookiesAsync(uri: IUriRuntimeClass; cookies: IVectorView_1__Http_IHttpCookie): IAsyncAction;
begin
  Result := Statics.PushCookiesAsync(uri, cookies);
end;

class function TAuthentication_Web_Provider_WebAccountManager.SetViewAsync(webAccount: IWebAccount; view: Authentication_Web_Provider_IWebAccountClientView): IAsyncAction;
begin
  Result := Statics.SetViewAsync(webAccount, view);
end;

class function TAuthentication_Web_Provider_WebAccountManager.ClearViewAsync(webAccount: IWebAccount; applicationCallbackUri: IUriRuntimeClass): IAsyncAction;
begin
  Result := Statics.ClearViewAsync(webAccount, applicationCallbackUri);
end;

class function TAuthentication_Web_Provider_WebAccountManager.GetViewsAsync(webAccount: IWebAccount): IAsyncOperation_1__IVectorView_1__Authentication_Web_Provider_IWebAccountClientView;
begin
  Result := Statics.GetViewsAsync(webAccount);
end;

class function TAuthentication_Web_Provider_WebAccountManager.SetWebAccountPictureAsync(webAccount: IWebAccount; webAccountPicture: IRandomAccessStream): IAsyncAction;
begin
  Result := Statics.SetWebAccountPictureAsync(webAccount, webAccountPicture);
end;

class function TAuthentication_Web_Provider_WebAccountManager.ClearWebAccountPictureAsync(webAccount: IWebAccount): IAsyncAction;
begin
  Result := Statics.ClearWebAccountPictureAsync(webAccount);
end;


class function TAuthentication_Web_Provider_WebAccountManager.AddWebAccountAsync(webAccountId: HSTRING; webAccountUserName: HSTRING; props: IMapView_2__HSTRING__HSTRING; scope: Authentication_Web_Provider_WebAccountScope): IAsyncOperation_1__IWebAccount;
begin
  Result := Statics2.AddWebAccountAsync(webAccountId, webAccountUserName, props, scope);
end;

class function TAuthentication_Web_Provider_WebAccountManager.SetScopeAsync(webAccount: IWebAccount; scope: Authentication_Web_Provider_WebAccountScope): IAsyncAction;
begin
  Result := Statics2.SetScopeAsync(webAccount, scope);
end;

class function TAuthentication_Web_Provider_WebAccountManager.GetScope(webAccount: IWebAccount): Authentication_Web_Provider_WebAccountScope;
begin
  Result := Statics2.GetScope(webAccount);
end;


 { TAuthentication_Web_Core_WebProviderError }
// Factories for : "Authentication_Web_Core_WebProviderError"
// Factory: "Windows.Security.Authentication.Web.Core.IWebProviderErrorFactory"
// -> Authentication_Web_Core_IWebProviderErrorFactory

class function TAuthentication_Web_Core_WebProviderError.Create(errorCode: Cardinal; errorMessage: HSTRING): Authentication_Web_Core_IWebProviderError;
begin
  Result := Factory.Create(errorCode, errorMessage);
end;


 { TAuthentication_Web_Core_WebTokenResponse }
// Factories for : "Authentication_Web_Core_WebTokenResponse"
// Factory: "Windows.Security.Authentication.Web.Core.IWebTokenResponseFactory"
// -> Authentication_Web_Core_IWebTokenResponseFactory

class function TAuthentication_Web_Core_WebTokenResponse.CreateWithToken(token: HSTRING): Authentication_Web_Core_IWebTokenResponse;
begin
  Result := Factory.CreateWithToken(token);
end;

class function TAuthentication_Web_Core_WebTokenResponse.CreateWithTokenAndAccount(token: HSTRING; webAccount: IWebAccount): Authentication_Web_Core_IWebTokenResponse;
begin
  Result := Factory.CreateWithTokenAndAccount(token, webAccount);
end;

class function TAuthentication_Web_Core_WebTokenResponse.CreateWithTokenAccountAndError(token: HSTRING; webAccount: IWebAccount; error: Authentication_Web_Core_IWebProviderError): Authentication_Web_Core_IWebTokenResponse;
begin
  Result := Factory.CreateWithTokenAccountAndError(token, webAccount, error);
end;


 { TEnterpriseData_ProtectionPolicyManager }

class function TEnterpriseData_ProtectionPolicyManager.IsIdentityManaged(identity: HSTRING): Boolean;
begin
  Result := Statics.IsIdentityManaged(identity);
end;

class function TEnterpriseData_ProtectionPolicyManager.TryApplyProcessUIPolicy(identity: HSTRING): Boolean;
begin
  Result := Statics.TryApplyProcessUIPolicy(identity);
end;

class procedure TEnterpriseData_ProtectionPolicyManager.ClearProcessUIPolicy;
begin
  Statics.ClearProcessUIPolicy;
end;

class function TEnterpriseData_ProtectionPolicyManager.CreateCurrentThreadNetworkContext(identity: HSTRING): EnterpriseData_IThreadNetworkContext;
begin
  Result := Statics.CreateCurrentThreadNetworkContext(identity);
end;

class function TEnterpriseData_ProtectionPolicyManager.GetPrimaryManagedIdentityForNetworkEndpointAsync(endpointHost: IInspectable{IHostName}): IAsyncOperation_1__HSTRING;
begin
  Result := Statics.GetPrimaryManagedIdentityForNetworkEndpointAsync(endpointHost);
end;

class procedure TEnterpriseData_ProtectionPolicyManager.RevokeContent(identity: HSTRING);
begin
  Statics.RevokeContent(identity);
end;

class function TEnterpriseData_ProtectionPolicyManager.GetForCurrentView: EnterpriseData_IProtectionPolicyManager;
begin
  Result := Statics.GetForCurrentView;
end;

class function TEnterpriseData_ProtectionPolicyManager.add_ProtectedAccessSuspending(handler: EventHandler_1__EnterpriseData_IProtectedAccessSuspendingEventArgs): EventRegistrationToken;
begin
  Result := Statics.add_ProtectedAccessSuspending(handler);
end;

class procedure TEnterpriseData_ProtectionPolicyManager.remove_ProtectedAccessSuspending(token: EventRegistrationToken);
begin
  Statics.remove_ProtectedAccessSuspending(token);
end;

class function TEnterpriseData_ProtectionPolicyManager.add_ProtectedAccessResumed(handler: EventHandler_1__EnterpriseData_IProtectedAccessResumedEventArgs): EventRegistrationToken;
begin
  Result := Statics.add_ProtectedAccessResumed(handler);
end;

class procedure TEnterpriseData_ProtectionPolicyManager.remove_ProtectedAccessResumed(token: EventRegistrationToken);
begin
  Statics.remove_ProtectedAccessResumed(token);
end;

class function TEnterpriseData_ProtectionPolicyManager.add_ProtectedContentRevoked(handler: EventHandler_1__EnterpriseData_IProtectedContentRevokedEventArgs): EventRegistrationToken;
begin
  Result := Statics.add_ProtectedContentRevoked(handler);
end;

class procedure TEnterpriseData_ProtectionPolicyManager.remove_ProtectedContentRevoked(token: EventRegistrationToken);
begin
  Statics.remove_ProtectedContentRevoked(token);
end;

class function TEnterpriseData_ProtectionPolicyManager.CheckAccess(sourceIdentity: HSTRING; targetIdentity: HSTRING): EnterpriseData_ProtectionPolicyEvaluationResult;
begin
  Result := Statics.CheckAccess(sourceIdentity, targetIdentity);
end;

class function TEnterpriseData_ProtectionPolicyManager.RequestAccessAsync(sourceIdentity: HSTRING; targetIdentity: HSTRING): IAsyncOperation_1__EnterpriseData_ProtectionPolicyEvaluationResult;
begin
  Result := Statics.RequestAccessAsync(sourceIdentity, targetIdentity);
end;


 { TEnterpriseData_FileRevocationManager }

class function TEnterpriseData_FileRevocationManager.ProtectAsync(storageItem: IStorageItem; enterpriseIdentity: HSTRING): IAsyncOperation_1__EnterpriseData_FileProtectionStatus;
begin
  Result := Statics.ProtectAsync(storageItem, enterpriseIdentity);
end;

class function TEnterpriseData_FileRevocationManager.CopyProtectionAsync(sourceStorageItem: IStorageItem; targetStorageItem: IStorageItem): IAsyncOperation_1__Boolean;
begin
  Result := Statics.CopyProtectionAsync(sourceStorageItem, targetStorageItem);
end;

class procedure TEnterpriseData_FileRevocationManager.Revoke(enterpriseIdentity: HSTRING);
begin
  Statics.Revoke(enterpriseIdentity);
end;

class function TEnterpriseData_FileRevocationManager.GetStatusAsync(storageItem: IStorageItem): IAsyncOperation_1__EnterpriseData_FileProtectionStatus;
begin
  Result := Statics.GetStatusAsync(storageItem);
end;


 { TEnterpriseData_FileProtectionManager }

class function TEnterpriseData_FileProtectionManager.ProtectAsync(target: IStorageItem; identity: HSTRING): IAsyncOperation_1__EnterpriseData_IFileProtectionInfo;
begin
  Result := Statics.ProtectAsync(target, identity);
end;

class function TEnterpriseData_FileProtectionManager.CopyProtectionAsync(source: IStorageItem; target: IStorageItem): IAsyncOperation_1__Boolean;
begin
  Result := Statics.CopyProtectionAsync(source, target);
end;

class function TEnterpriseData_FileProtectionManager.GetProtectionInfoAsync(source: IStorageItem): IAsyncOperation_1__EnterpriseData_IFileProtectionInfo;
begin
  Result := Statics.GetProtectionInfoAsync(source);
end;

class function TEnterpriseData_FileProtectionManager.SaveFileAsContainerAsync(protectedFile: IStorageFile): IAsyncOperation_1__EnterpriseData_IProtectedContainerExportResult;
begin
  Result := Statics.SaveFileAsContainerAsync(protectedFile);
end;

class function TEnterpriseData_FileProtectionManager.LoadFileFromContainerAsync(containerFile: IStorageFile): IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult;
begin
  Result := Statics.LoadFileFromContainerAsync(containerFile);
end;

class function TEnterpriseData_FileProtectionManager.LoadFileFromContainerAsync(containerFile: IStorageFile; target: IStorageItem): IAsyncOperation_1__EnterpriseData_IProtectedContainerImportResult;
begin
  Result := Statics.LoadFileFromContainerAsync(containerFile, target);
end;

class function TEnterpriseData_FileProtectionManager.CreateProtectedAndOpenAsync(parentFolder: IStorageFolder; desiredName: HSTRING; identity: HSTRING; collisionOption: CreationCollisionOption): IAsyncOperation_1__EnterpriseData_IProtectedFileCreateResult;
begin
  Result := Statics.CreateProtectedAndOpenAsync(parentFolder, desiredName, identity, collisionOption);
end;


 { TEnterpriseData_DataProtectionManager }

class function TEnterpriseData_DataProtectionManager.ProtectAsync(data: IBuffer; identity: HSTRING): IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult;
begin
  Result := Statics.ProtectAsync(data, identity);
end;

class function TEnterpriseData_DataProtectionManager.UnprotectAsync(data: IBuffer): IAsyncOperation_1__EnterpriseData_IBufferProtectUnprotectResult;
begin
  Result := Statics.UnprotectAsync(data);
end;

class function TEnterpriseData_DataProtectionManager.ProtectStreamAsync(unprotectedStream: IInputStream; identity: HSTRING; protectedStream: IOutputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo;
begin
  Result := Statics.ProtectStreamAsync(unprotectedStream, identity, protectedStream);
end;

class function TEnterpriseData_DataProtectionManager.UnprotectStreamAsync(protectedStream: IInputStream; unprotectedStream: IOutputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo;
begin
  Result := Statics.UnprotectStreamAsync(protectedStream, unprotectedStream);
end;

class function TEnterpriseData_DataProtectionManager.GetProtectionInfoAsync(protectedData: IBuffer): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo;
begin
  Result := Statics.GetProtectionInfoAsync(protectedData);
end;

class function TEnterpriseData_DataProtectionManager.GetStreamProtectionInfoAsync(protectedStream: IInputStream): IAsyncOperation_1__EnterpriseData_IDataProtectionInfo;
begin
  Result := Statics.GetStreamProtectionInfoAsync(protectedStream);
end;



end.
