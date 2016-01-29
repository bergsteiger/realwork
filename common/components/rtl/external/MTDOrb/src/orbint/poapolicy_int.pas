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
unit poapolicy_int;

interface

uses
  orb_int,orbtypes,ir_int,except_int,Policy_int;

const
  // Policy error codes
  BAD_POLICY : _short = 0;
  UNSUPPORTED_POLICY : _short = 1;
  BAD_POLICY_TYPE : _short = 2;
  BAD_POLICY_VALUE : _short = 3;
  UNSUPPORTED_POLICY_VALUE : _short = 4;

type

  ThreadPolicyValue = (ORB_CTRL_MODEL,SINGLE_THREAD_MODEL);

  IThreadPolicy = interface(IPolicy)
  ['{5A26DAC1-6B0E-11d4-9D3D-204C4F4F5020}']
    function value(): ThreadPolicyValue;
  end;

  LifeSpanPolicyValue = (TRANSIENT,PERSISTENT);

  ILifespanPolicy = interface(IPolicy)
  ['{5A26DAC2-6B0E-11d4-9D3D-204C4F4F5020}']
    function value(): LifeSpanPolicyValue;
  end;

  IdUniquenessPolicyValue = (UNIQUE_ID,MULTIPLE_ID);

  IIdUniquenessPolicy = interface(IPolicy)
  ['{5A26DAC3-6B0E-11d4-9D3D-204C4F4F5020}']
    function value(): IdUniquenessPolicyValue;
  end;

  IdAssignmentPolicyValue = (USER_ID,SYSTEM_ID);

  IIdAssignmentPolicy = interface(IPolicy)
  ['{5A26DAC4-6B0E-11d4-9D3D-204C4F4F5020}']
    function value(): IdAssignmentPolicyValue;
  end;

  ImplicitActivationPolicyValue = (IMPLICIT_ACTIVATION,NO_IMPLICIT_ACTIVATION);

  IImplicitActivationPolicy = interface(IPolicy)
  ['{5A26DAC5-6B0E-11d4-9D3D-204C4F4F5020}']
    function value(): ImplicitActivationPolicyValue;
  end;

  ServantRetentionPolicyValue = (RETAIN,NON_RETAIN);

  IServantRetentionPolicy = interface(IPolicy)
  ['{5A26DAC6-6B0E-11d4-9D3D-204C4F4F5020}']
    function value(): ServantRetentionPolicyValue;
  end;

  RequestProcessingPolicyValue = (
    USE_ACTIVE_OBJECT_MAP_ONLY,
    USE_DEFAULT_SERVANT,
    USE_SERVANT_MANAGER
  );

  IRequestProcessingPolicy = interface(IPolicy)
  ['{5A26DAC7-6B0E-11d4-9D3D-204C4F4F5020}']
    function value(): RequestProcessingPolicyValue;
  end;

  IConstructionPolicy = interface(IPolicy)
  ['{AF662CD2-4D2E-11d4-9D27-204C4F4F5020}']
    procedure make_domain_manager(const objtype: IInterfaceDef; constr_policy: Boolean);
    function constr_policy(const obj: IORBObject): Boolean;
  end;

  TPolicyErrorCode = short;

  IPolicyError = interface(IUserException)
  ['{71284B76-DD35-44FD-A907-9A8F50BD4EA1}']
    function reason: TPolicyErrorCode; overload;
    procedure reason(const val : TPolicyErrorCode); overload;
  end;

implementation

end.
