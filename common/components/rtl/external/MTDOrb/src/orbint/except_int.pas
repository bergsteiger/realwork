// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit except_int;

interface

uses
  code_int,Classes,orbtypes;

const
  OMGVMCID = $4f4d0000;
  MTDORBVMCID = $4f4f0000;

  // Minor error codes for INITIALIZE
  // MTDORB specific minor codes
  MinorORBDestroyed =  1 or MTDORBVMCID;

  // Minor error codes for NO_IMPLEMENT
  // Standard minor codes
  MinorMissingLocalValueImplementation = 1 or OMGVMCID;
  MinorIncompatibleValueImplementationVersion = 2 or OMGVMCID;
  MinorNotSupportedByLocalObject = 3 or OMGVMCID;
  MinorDIINotSupportedByLocalObject = 4 or OMGVMCID;

  // Minor error codes for OBJECT_NOT_EXIST
  // Standard minor codes
  MinorUnregisteredValue = 1 or OMGVMCID;
  MinorCannotDispatch = 2 or OMGVMCID;

  // Minor error codes for BAD_PARAM
  // Standard minor codes
  MinorValueFactoryError = 1 or OMGVMCID;
  MinorRepositoryIdExists = 2 or OMGVMCID;
  MinorNameExists = 3 or OMGVMCID;
  MinorInvalidContainer = 4 or OMGVMCID;
  MinorNameClashInInheritedContext = 5 or OMGVMCID;
  MinorBadAbstractInterfaceType = 6 or OMGVMCID;
  MinorBadSchemeName = 7 or OMGVMCID;
  MinorBadAddress = 8 or OMGVMCID;
  MinorBadSchemeSpecificPart = 9 or OMGVMCID;
  MinorOther = 10 or OMGVMCID;
  MinorInvalidAbstractInterfaceInheritance = 11 or OMGVMCID;
  MinorInvalidValueInheritance = 12 or OMGVMCID;
  MinorIncompleteTypeCodeParameter = 13 or OMGVMCID;
  MinorInvalidObjectId = 14 or OMGVMCID;
  MinorInvalidName = 15 or OMGVMCID;
  MinorInvalidId = 16 or OMGVMCID;
  MinorInvalidMemberName = 17 or OMGVMCID;
  MinorDuplicateLabel = 18 or OMGVMCID;
  MinorIncompatibleLabelType = 19 or OMGVMCID;
  MinorInvalidDiscriminatorType = 20 or OMGVMCID;
  MinorNoExceptionInAny = 21 or OMGVMCID;
  MinorUnlistedUserException = 22 or OMGVMCID;
  MinorNoWcharCodeSet = 23 or OMGVMCID;
  MinorServiceContextIdOutOfRange = 24 or OMGVMCID;
  MinorEnumValueOutOfRange = 25 or OMGVMCID;
  MinorInvalidServiceContextId = 26 or OMGVMCID;
  MinorObjectIsNull = 27 or OMGVMCID;
  MinorInvalidComponentId = 28 or OMGVMCID;
  MinorInvalidProfileId = 29 or OMGVMCID;
  MinorDuplicatePolicyType = 30 or OMGVMCID;
  // MTDORB specific minor codes
  MinorDuplicateDeclarator =  1 or MTDORBVMCID;
  MinorInvalidValueModifier = 2 or MTDORBVMCID;
  MinorDuplicateValueInit = 3 or MTDORBVMCID;
  MinorAbstractValueInit = 4 or MTDORBVMCID;
  MinorDuplicateBaseType = 5 or MTDORBVMCID;
  MinorSingleThreadedOnly = 6 or MTDORBVMCID;
  MinorNameRedefinitionInImmediateScope = 7 or MTDORBVMCID;
  MinorInvalidValueBoxType = 8 or MTDORBVMCID;
  MinorInvalidLocalInterfaceInheritance = 9 or MTDORBVMCID;
  MinorConstantTypeMismatch = 10 or MTDORBVMCID;

  // Minor error codes for BAD_INV_ORDER
  // Standard minor codes
  MinorDependencyPreventsDestruction = 1 or OMGVMCID;
  MinorIndestructibleObject = 2 or OMGVMCID;
  MinorDestroyWouldBlock = 3 or OMGVMCID;
  MinorShutdownCalled = 4 or OMGVMCID;
  MinorDuplicateSend = 5 or OMGVMCID;
  MinorServantManagerAlreadySet = 6 or OMGVMCID;
  MinorInvalidUseOfDSIArguments = 7 or OMGVMCID;
  MinorInvalidUseOfDSIContext = 8 or OMGVMCID;
  MinorInvalidUseOfDSIResult = 9 or OMGVMCID;
  MinorRequestAlreadySent = 10 or OMGVMCID;
  MinorRequestNotSent = 11 or OMGVMCID;
  MinorResponseAlreadyReceived = 12 or OMGVMCID;
  MinorSynchronousRequest = 13 or OMGVMCID;
  MinorInvalidPICall = 14 or OMGVMCID;
  MinorServiceContextExists = 15 or OMGVMCID;
  MinorPolicyFactoryExists = 16 or OMGVMCID;
  MinorNoCreatePOA = 17 or OMGVMCID;

  // Minor error codes for COMM_FAILURE
  // Standard minor code
  (* None yet *)

  // MTDORB specific minor codes
  MinorRecv = 1 or MTDORBVMCID;
  MinorSend = 2 or MTDORBVMCID;
  MinorRecvZero = 3 or MTDORBVMCID;
  MinorSendZero = 4 or MTDORBVMCID;
  MinorSocket = 5 or MTDORBVMCID;
  MinorSetsockopt = 6 or MTDORBVMCID;
  MinorGetsockopt = 7 or MTDORBVMCID;
  MinorBind = 8 or MTDORBVMCID;
  MinorListen = 9 or MTDORBVMCID;
  MinorConnect = 10 or MTDORBVMCID;
  MinorAccept = 11 or MTDORBVMCID;
  MinorSelect = 12 or MTDORBVMCID;
  MinorSetSoTimeout = 26 or MTDORBVMCID;

  MinorGethostname = 13 or MTDORBVMCID;
  MinorGethostbyname = 14 or MTDORBVMCID;

  MinorWSAStartup = 15 or MTDORBVMCID;
  MinorWSACleanup = 16 or MTDORBVMCID;

  MinorNoGIOP = 17 or MTDORBVMCID;
  MinorUnknownMessage = 18 or MTDORBVMCID;
  MinorWrongMessage = 19 or MTDORBVMCID;
  MinorMessageError = 21 or MTDORBVMCID;
  MinorFragment = 22 or MTDORBVMCID;
  MinorUnknownReqId = 24 or MTDORBVMCID;
  MinorVersion = 25 or MTDORBVMCID;

  MinorPipe = 23 or MTDORBVMCID;

  // Minor error codes for TRANSIENT
  // Standard minor codes
  MinorRequestDiscarded = 1 or OMGVMCID;
  MinorNoUsableProfileInIOR = 2 or OMGVMCID;
  MinorRequestCancelled = 3 or OMGVMCID;
  MinorPOADestroyed = 4 or OMGVMCID;

  // MTDORB specific minor codes
  MinorConnectFailed = 1 or MTDORBVMCID;
  MinorCloseConnection = 2 or MTDORBVMCID;
  MinorActiveConnectionManagement = 3 or MTDORBVMCID;
  MinorForcedShutdown = 4 or MTDORBVMCID;
  MinorLocationForwardHopCountExceeded = 5 or MTDORBVMCID;

  // Minor error codes for UNKNOWN
  // Standard minor codes
  //
  MinorUnknownUserException = 1 or OMGVMCID;
  MinorSystemExceptionNotSupported = 2 or OMGVMCID;

  // Minor error codes for INV_POLICY
  // Standard minor codes
  //
  MinorCannotReconcilePolicy = 1 or OMGVMCID;
  MinorInvalidPolicyType = 2 or OMGVMCID;
  MinorNoPolicyFactory = 3 or OMGVMCID;

  // Minor error codes for OBJ_ADAPTER
  // Standard minor codes
  //
  MinorSystemExceptionInUnknownAdapter = 1 or OMGVMCID;
  MinorServantNotFound = 2 or OMGVMCID;
  MinorNoDefaultServant = 3 or OMGVMCID;
  MinorNoServantManager = 4 or OMGVMCID;
  MinorIncarnateViolatedPOAPolicy = 5 or OMGVMCID;

  // Minor error codes for NO_RESOURCES
  // PortableInterceptor minor codes
  //
  MinorInvalidBinding = 1 or OMGVMCID;

type

  IORBException = interface(IUnknown)
  ['{61252F7A-4D23-11d4-9D27-204C4F4F5020}']
    procedure encode(const enc: IEncoder);
    procedure encode_any(const a: IAny);
    function clone(): IORBException;
    procedure print(s: TStream);
    function repoid(): RepositoryId;
    procedure throw();
    function ref_count(): integer;
  end;

  ISystemException = interface(IORBexception)
  ['{61252F7B-4D23-11d4-9D27-204C4F4F5020}']
    procedure assign(const ex: ISystemException);
    function completed(): TCompletionStatus;
    function minor(): _ulong;
    procedure set_minor(val: _ulong);
    procedure set_completed(val: TCompletionStatus);
    function extype(): SYSEXC_TYPES;
    function _reason(): string;
    procedure set_reason(const reason: string);
    function _remote(): boolean;
    procedure set_remote(remote: boolean);
  end;

  IUserException = interface(IORBException)
  ['{FBB86C41-9AF8-11d4-9DB2-204C4F4F5020}']
  end;

  IUnknownUserException = interface(IUserException)
  ['{61252F7C-4D23-11d4-9D27-204C4F4F5020}']
    function exception(tc: ITypeCode): IAny; overload;
    function exception(sa: IStaticTypeInfo): IStaticAny; overload;
    function except_repoid: RepositoryId;
  end;

  IBadKind = interface(IUserException)
  ['{FBB86C42-9AF8-11d4-9DB2-204C4F4F5020}']
  end;

  IBounds = interface(IUserException)
  ['{FBB86C43-9AF8-11d4-9DB2-204C4F4F5020}']
  end;

implementation



end.
