{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{    File: ComSvcs.h                                    }
{    Copyright (C) 1995-1999 Microsoft Corporation.     }
{    All Rights Reserved.                               }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{            MS Event Server Interface Unit             }
{*******************************************************}

unit Winapi.ComSvcs;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface

uses Winapi.Windows, Winapi.Mtx, Winapi.ActiveX;

const

  LIBID_COMSVCSLib: TGUID = '{2A005C00-A5DE-11CF-9E66-00AA00A3F464}';
  {$EXTERNALSYM LIBID_COMSVCSLib}

  IID_ISecurityCertificateColl: TGUID = '{CAFC823B-B441-11D1-B82B-0000F8757E2A}';
  {$EXTERNALSYM IID_ISecurityCertificateColl}
  CLASS_SecurityCertificate: TGUID = '{ECABB0A4-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_SecurityCertificate}
  IID_ISecurityIdentityColl: TGUID = '{CAFC823C-B441-11D1-B82B-0000F8757E2A}';
  {$EXTERNALSYM IID_ISecurityIdentityColl}
  CLASS_SecurityIdentity: TGUID = '{ECABB0A5-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_SecurityIdentity}
  IID_ISecurityCallersColl: TGUID = '{CAFC823D-B441-11D1-B82B-0000F8757E2A}';
  {$EXTERNALSYM IID_ISecurityCallersColl}
  CLASS_SecurityCallers: TGUID = '{ECABB0A6-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_SecurityCallers}
  IID_ISecurityCallContext: TGUID = '{CAFC823E-B441-11D1-B82B-0000F8757E2A}';
  {$EXTERNALSYM IID_ISecurityCallContext}
  CLASS_SecurityCallContext: TGUID = '{ECABB0A7-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_SecurityCallContext}
  IID_IGetSecurityCallContext: TGUID = '{CAFC823F-B441-11D1-B82B-0000F8757E2A}';
  {$EXTERNALSYM IID_IGetSecurityCallContext}
  CLASS_GetSecurityCallContextAppObject: TGUID = '{ECABB0A8-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_GetSecurityCallContextAppObject}
  IID_IContextState: TGUID = '{3C05E54B-A42A-11D2-AFC4-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IContextState}
  IID_IObjectContextInfo: TGUID = '{75B52DDB-E8ED-11D1-93AD-00AA00BA3258}';
  {$EXTERNALSYM IID_IObjectContextInfo}
  IID_IObjectConstruct: TGUID = '{41C4F8B3-7439-11D2-98CB-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IObjectConstruct}
  IID_IObjectConstructString: TGUID = '{41C4F8B2-7439-11D2-98CB-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IObjectConstructString}
  IID_IObjectContextTip: TGUID = '{92FD41CA-BAD9-11D2-9A2D-00C04F797BC9}';
  {$EXTERNALSYM IID_IObjectContextTip}
  IID_IPlaybackControl: TGUID = '{51372AFD-CAE7-11CF-BE81-00AA00A2FA25}';
  {$EXTERNALSYM IID_IPlaybackControl}
  IID_ICrmCompensator: TGUID = '{BBC01830-8D3B-11D1-82EC-00A0C91EEDE9}';
  {$EXTERNALSYM IID_ICrmCompensator}
  IID_ICrmCompensatorVariants: TGUID = '{F0BAF8E4-7804-11D1-82E9-00A0C91EEDE9}';
  {$EXTERNALSYM IID_ICrmCompensatorVariants}
  IID_ICrmLogControl: TGUID = '{A0E174B3-D26E-11D2-8F84-00805FC7BCD9}';
  {$EXTERNALSYM IID_ICrmLogControl}
  IID_ICrmFormatLogRecords: TGUID = '{9C51D821-C98B-11D1-82FB-00A0C91EEDE9}';
  {$EXTERNALSYM IID_ICrmFormatLogRecords}
  CLASS_Dummy30040732: TGUID = '{ECABB0A9-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_Dummy30040732}
  IID_ObjectControl: TGUID = '{7DC41850-0C31-11D0-8B79-00AA00B8A790}';
  {$EXTERNALSYM IID_ObjectControl}
  IID_IMTxAS: TGUID = '{74C08641-CEDB-11CF-8B49-00AA00B8A790}';
  {$EXTERNALSYM IID_IMTxAS}
  CLASS_AppServer: TGUID = '{71E38F91-7E88-11CF-9EDE-0080C78B7F89}';
  {$EXTERNALSYM CLASS_AppServer}
  IID_ObjectContext: TGUID = '{74C08646-CEDB-11CF-8B49-00AA00B8A790}';
  {$EXTERNALSYM IID_ObjectContext}
  IID_SecurityProperty: TGUID = '{E74A7215-014D-11D1-A63C-00A0C911B4E0}';
  {$EXTERNALSYM IID_SecurityProperty}
  IID_ContextInfo: TGUID = '{19A5A02C-0AC8-11D2-B286-00C04F8EF934}';
  {$EXTERNALSYM IID_ContextInfo}
  IID_ICreateWithTipTransactionEx: TGUID = '{455ACF59-5345-11D2-99CF-00C04F797BC9}';
  {$EXTERNALSYM IID_ICreateWithTipTransactionEx}
  IID_ICreateWithTransactionEx: TGUID = '{455ACF57-5345-11D2-99CF-00C04F797BC9}';
  {$EXTERNALSYM IID_ICreateWithTransactionEx}
  CLASS_ByotServerEx: TGUID = '{ECABB0AA-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_ByotServerEx}
  IID_ITransaction: TGUID = '{0FB15084-AF41-11CE-BD2B-204C4F4F5020}';
  {$EXTERNALSYM IID_ITransaction}
  IID_IMtsEvents: TGUID = '{BACEDF4D-74AB-11D0-B162-00AA00BA3258}';
  {$EXTERNALSYM IID_IMtsEvents}
  IID_IMtsEventInfo: TGUID = '{D56C3DC1-8482-11D0-B170-00AA00BA3258}';
  {$EXTERNALSYM IID_IMtsEventInfo}
  CLASS_COMEvents: TGUID = '{ECABB0AB-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_COMEvents}
  IID_IMTSLocator: TGUID = '{D19B8BFD-7F88-11D0-B16E-00AA00BA3258}';
  {$EXTERNALSYM IID_IMTSLocator}
  CLASS_CoMTSLocator: TGUID = '{ECABB0AC-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_CoMTSLocator}
  IID_IMtsGrp: TGUID = '{4B2E958C-0393-11D1-B1AB-00AA00BA3258}';
  {$EXTERNALSYM IID_IMtsGrp}
  CLASS_MtsGrp: TGUID = '{4B2E958D-0393-11D1-B1AB-00AA00BA3258}';
  {$EXTERNALSYM CLASS_MtsGrp}
  IID_IComThreadEvents: TGUID = '{683130A5-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComThreadEvents}
  IID_IComUserEvent: TGUID = '{683130A4-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComUserEvent}
  IID_IComAppEvents: TGUID = '{683130A6-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComAppEvents}
  IID_IComInstanceEvents: TGUID = '{683130A7-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComInstanceEvents}
  IID_IComTransactionEvents: TGUID = '{683130A8-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComTransactionEvents}
  IID_IComMethodEvents: TGUID = '{683130A9-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComMethodEvents}
  IID_IComObjectEvents: TGUID = '{683130AA-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComObjectEvents}
  IID_IComResourceEvents: TGUID = '{683130AB-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComResourceEvents}
  IID_IComSecurityEvents: TGUID = '{683130AC-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComSecurityEvents}
  IID_IComObjectPoolEvents: TGUID = '{683130AD-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComObjectPoolEvents}
  IID_IComObjectPoolEvents2: TGUID = '{683130AE-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComObjectPoolEvents2}
  IID_IComObjectConstructionEvents: TGUID = '{683130AF-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComObjectConstructionEvents}
  IID_IComActivityEvents: TGUID = '{683130B0-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComActivityEvents}
  IID_IComIdentityEvents: TGUID = '{683130B1-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComIdentityEvents}
  IID_IComQCEvents: TGUID = '{683130B2-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComQCEvents}
  IID_IComExceptionEvents: TGUID = '{683130B3-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComExceptionEvents}
  IID_IComCRMEvents: TGUID = '{683130B5-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_IComCRMEvents}
  CLASS_ComServiceEvents: TGUID = '{ECABB0C3-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_ComServiceEvents}
  IID_ICrmMonitorLogRecords: TGUID = '{70C8E441-C7ED-11D1-82FB-00A0C91EEDE9}';
  {$EXTERNALSYM IID_ICrmMonitorLogRecords}
  CLASS_CRMClerk: TGUID = '{ECABB0BD-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_CRMClerk}
  IID_ICrmMonitor: TGUID = '{70C8E443-C7ED-11D1-82FB-00A0C91EEDE9}';
  {$EXTERNALSYM IID_ICrmMonitor}
  CLASS_CRMRecoveryClerk: TGUID = '{ECABB0BE-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_CRMRecoveryClerk}
  IID_ICrmMonitorClerks: TGUID = '{70C8E442-C7ED-11D1-82FB-00A0C91EEDE9}';
  {$EXTERNALSYM IID_ICrmMonitorClerks}
  IID_ILBEvents: TGUID = '{683130B4-2E50-11D2-98A5-00C04F8EE1C4}';
  {$EXTERNALSYM IID_ILBEvents}
  CLASS_LBEvents: TGUID = '{ECABB0C1-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_LBEvents}
  IID_IMessageMover: TGUID = '{588A085A-B795-11D1-8054-00C04FC340EE}';
  {$EXTERNALSYM IID_IMessageMover}
  CLASS_MessageMover: TGUID = '{ECABB0BF-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_MessageMover}
  IID_IDispenserManager: TGUID = '{5CB31E10-2B5F-11CF-BE10-00AA00A2FA25}';
  {$EXTERNALSYM IID_IDispenserManager}
  IID_IDispenserManagerShutdownGuarantee: TGUID = '{5CB31E11-2B5F-11CF-BE10-00AA00A2FA25}';
  {$EXTERNALSYM IID_IDispenserManagerShutdownGuarantee}
  IID_IDispenserDriver: TGUID = '{208B3651-2B48-11CF-BE10-00AA00A2FA25}';
  {$EXTERNALSYM IID_IDispenserDriver}
  IID_IHolder: TGUID = '{BF6A1850-2B45-11CF-BE10-00AA00A2FA25}';
  {$EXTERNALSYM IID_IHolder}
  CLASS_DispenserManager: TGUID = '{ECABB0C0-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_DispenserManager}
  IID_IReceiveAppData: TGUID = '{413DAFB0-BCF4-11D1-861D-0080C729264D}';
  {$EXTERNALSYM IID_IReceiveAppData}
  IID_IGetAppData: TGUID = '{B60040E0-BCF3-11D1-861D-0080C729264D}';
  {$EXTERNALSYM IID_IGetAppData}
  CLASS_TrackerServer: TGUID = '{ECABAFB9-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_TrackerServer}
  IID_IEventServer: TGUID = '{F1CB0608-EC04-11D1-93AE-00AA00BA3258}';
  {$EXTERNALSYM IID_IEventServer}
  IID_IProcessTerminateNotify: TGUID = '{3194B4CF-EF32-11D1-93AE-00AA00BA3258}';
  {$EXTERNALSYM IID_IProcessTerminateNotify}
  CLASS_EventServer: TGUID = '{ECABAFBC-7F19-11D2-978E-0000F8757E2A}';
  {$EXTERNALSYM CLASS_EventServer}

type
  tagTransactionVote = TOleEnum;
  {$EXTERNALSYM tagTransactionVote}
const
  TxCommit = $00000000;
  {$EXTERNALSYM TxCommit}
  TxAbort = $00000001;
  {$EXTERNALSYM TxAbort}

type
  __MIDL___MIDL_itf_autosvcs_0342_0001 = TOleEnum;
  {$EXTERNALSYM __MIDL___MIDL_itf_autosvcs_0342_0001}
const
  mtsErrCtxAborted = $8004E002;
  {$EXTERNALSYM mtsErrCtxAborted}
  mtsErrCtxAborting = $8004E003;
  {$EXTERNALSYM mtsErrCtxAborting}
  mtsErrCtxNoContext = $8004E004;
  {$EXTERNALSYM mtsErrCtxNoContext}
  mtsErrCtxNotRegistered = $8004E005;
  {$EXTERNALSYM mtsErrCtxNotRegistered}
  mtsErrCtxSynchTimeout = $8004E006;
  {$EXTERNALSYM mtsErrCtxSynchTimeout}
  mtsErrCtxOldReference = $8004E007;
  {$EXTERNALSYM mtsErrCtxOldReference}
  mtsErrCtxRoleNotFound = $8004E00C;
  {$EXTERNALSYM mtsErrCtxRoleNotFound}
  mtsErrCtxNoSecurity = $8004E00D;
  {$EXTERNALSYM mtsErrCtxNoSecurity}
  mtsErrCtxWrongThread = $8004E00E;
  {$EXTERNALSYM mtsErrCtxWrongThread}
  mtsErrCtxTMNotAvailable = $8004E00F;
  {$EXTERNALSYM mtsErrCtxTMNotAvailable}
  comQCErrApplicationNotQueued = $80110600;
  {$EXTERNALSYM comQCErrApplicationNotQueued}
  comQCErrNoQueueableInterfaces = $80110601;
  {$EXTERNALSYM comQCErrNoQueueableInterfaces}
  comQCErrQueuingServiceNotAvailable = $80110602;
  {$EXTERNALSYM comQCErrQueuingServiceNotAvailable}
  comQCErrQueueTransactMismatch = $80110603;
  {$EXTERNALSYM comQCErrQueueTransactMismatch}
  comqcErrRecorderMarshalled = $80110604;
  {$EXTERNALSYM comqcErrRecorderMarshalled}
  comqcErrOutParam = $80110605;
  {$EXTERNALSYM comqcErrOutParam}
  comqcErrRecorderNotTrusted = $80110606;
  {$EXTERNALSYM comqcErrRecorderNotTrusted}
  comqcErrPSLoad = $80110607;
  {$EXTERNALSYM comqcErrPSLoad}
  comqcErrMarshaledObjSameTxn = $80110608;
  {$EXTERNALSYM comqcErrMarshaledObjSameTxn}
  comqcErrInvalidMessage = $80110650;
  {$EXTERNALSYM comqcErrInvalidMessage}
  comqcErrMsmqSidUnavailable = $80110651;
  {$EXTERNALSYM comqcErrMsmqSidUnavailable}
  comqcErrWrongMsgExtension = $80110652;
  {$EXTERNALSYM comqcErrWrongMsgExtension}
  comqcErrMsmqServiceUnavailable = $80110653;
  {$EXTERNALSYM comqcErrMsmqServiceUnavailable}
  comqcErrMsgNotAuthenticated = $80110654;
  {$EXTERNALSYM comqcErrMsgNotAuthenticated}
  comqcErrMsmqConnectorUsed = $80110655;
  {$EXTERNALSYM comqcErrMsmqConnectorUsed}
  comqcErrBadMarshaledObject = $80110656;
  {$EXTERNALSYM comqcErrBadMarshaledObject}

type
  __MIDL___MIDL_itf_autosvcs_0342_0002 = TOleEnum;
  {$EXTERNALSYM __MIDL___MIDL_itf_autosvcs_0342_0002}
const
  LockSetGet = $00000000;
  {$EXTERNALSYM LockSetGet}
  LockMethod = $00000001;
  {$EXTERNALSYM LockMethod}

type
  __MIDL___MIDL_itf_autosvcs_0342_0003 = TOleEnum;
  {$EXTERNALSYM __MIDL___MIDL_itf_autosvcs_0342_0003}
const
  Standard = $00000000;
  {$EXTERNALSYM Standard}
  Process = $00000001;
  {$EXTERNALSYM Process}

type
  tagCRMFLAGS = TOleEnum;
  {$EXTERNALSYM tagCRMFLAGS}
const
  CRMFLAG_FORGETTARGET = $00000001;
  {$EXTERNALSYM CRMFLAG_FORGETTARGET}
  CRMFLAG_WRITTENDURINGPREPARE = $00000002;
  {$EXTERNALSYM CRMFLAG_WRITTENDURINGPREPARE}
  CRMFLAG_WRITTENDURINGCOMMIT = $00000004;
  {$EXTERNALSYM CRMFLAG_WRITTENDURINGCOMMIT}
  CRMFLAG_WRITTENDURINGABORT = $00000008;
  {$EXTERNALSYM CRMFLAG_WRITTENDURINGABORT}
  CRMFLAG_WRITTENDURINGRECOVERY = $00000010;
  {$EXTERNALSYM CRMFLAG_WRITTENDURINGRECOVERY}
  CRMFLAG_WRITTENDURINGREPLAY = $00000020;
  {$EXTERNALSYM CRMFLAG_WRITTENDURINGREPLAY}
  CRMFLAG_REPLAYINPROGRESS = $00000040;
  {$EXTERNALSYM CRMFLAG_REPLAYINPROGRESS}

type
  tagCRMREGFLAGS = TOleEnum;
  {$EXTERNALSYM tagCRMREGFLAGS}
const
  CRMREGFLAG_PREPAREPHASE = $00000001;
  {$EXTERNALSYM CRMREGFLAG_PREPAREPHASE}
  CRMREGFLAG_COMMITPHASE = $00000002;
  {$EXTERNALSYM CRMREGFLAG_COMMITPHASE}
  CRMREGFLAG_ABORTPHASE = $00000004;
  {$EXTERNALSYM CRMREGFLAG_ABORTPHASE}
  CRMREGFLAG_ALLPHASES = $00000007;
  {$EXTERNALSYM CRMREGFLAG_ALLPHASES}
  CRMREGFLAG_FAILIFINDOUBTSREMAIN = $00000010;
  {$EXTERNALSYM CRMREGFLAG_FAILIFINDOUBTSREMAIN}

type
  tagCrmTransactionState = TOleEnum;
  {$EXTERNALSYM tagCrmTransactionState}
const
  TxState_Active = $00000000;
  {$EXTERNALSYM TxState_Active}
  TxState_Committed = $00000001;
  {$EXTERNALSYM TxState_Committed}
  TxState_Aborted = $00000002;
  {$EXTERNALSYM TxState_Aborted}
  TxState_Indoubt = $00000003;
  {$EXTERNALSYM TxState_Indoubt}

type

{ Forward declarations: Interfaces }

  ISecurityIdentityColl = interface;
  {$EXTERNALSYM ISecurityIdentityColl}
  ISecurityCallersColl = interface;
  {$EXTERNALSYM ISecurityCallersColl}
  ISecurityCallContext = interface;
  {$EXTERNALSYM ISecurityCallContext}
  IGetSecurityCallContext = interface;
  {$EXTERNALSYM IGetSecurityCallContext}

  IContextState = interface;
  {$EXTERNALSYM IContextState}

  IObjectConstruct = interface;
  {$EXTERNALSYM IObjectConstruct}
  IObjectConstructString = interface;
  {$EXTERNALSYM IObjectConstructString}
  IObjectContextTip = interface;
  {$EXTERNALSYM IObjectContextTip}
  IPlaybackControl = interface;
  {$EXTERNALSYM IPlaybackControl}
  ICrmCompensator = interface;
  {$EXTERNALSYM ICrmCompensator}
  ICrmCompensatorVariants = interface;
  {$EXTERNALSYM ICrmCompensatorVariants}
  ICrmLogControl = interface;
  {$EXTERNALSYM ICrmLogControl}
  ICrmFormatLogRecords = interface;
  {$EXTERNALSYM ICrmFormatLogRecords}
  ObjectControl = interface;
  {$EXTERNALSYM ObjectControl}
  IMTxAS = interface;
  {$EXTERNALSYM IMTxAS}
  ObjectContext = interface;
  {$EXTERNALSYM ObjectContext}
  SecurityProperty = interface;
  {$EXTERNALSYM SecurityProperty}
  ContextInfo = interface;
  {$EXTERNALSYM ContextInfo}
  ICreateWithTipTransactionEx = interface;
  {$EXTERNALSYM ICreateWithTipTransactionEx}
  ICreateWithTransactionEx = interface;
  {$EXTERNALSYM ICreateWithTransactionEx}
  ITransaction = interface;
  {$EXTERNALSYM ITransaction}
  IMtsEvents = interface;
  {$EXTERNALSYM IMtsEvents}
  IMtsEventInfo = interface;
  {$EXTERNALSYM IMtsEventInfo}
  IMTSLocator = interface;
  {$EXTERNALSYM IMTSLocator}
  IMtsGrp = interface;
  {$EXTERNALSYM IMtsGrp}
  IComThreadEvents = interface;
  {$EXTERNALSYM IComThreadEvents}
  IComUserEvent = interface;
  {$EXTERNALSYM IComUserEvent}
  IComAppEvents = interface;
  {$EXTERNALSYM IComAppEvents}
  IComInstanceEvents = interface;
  {$EXTERNALSYM IComInstanceEvents}
  IComTransactionEvents = interface;
  {$EXTERNALSYM IComTransactionEvents}
  IComMethodEvents = interface;
  {$EXTERNALSYM IComMethodEvents}
  IComObjectEvents = interface;
  {$EXTERNALSYM IComObjectEvents}
  IComResourceEvents = interface;
  {$EXTERNALSYM IComResourceEvents}
  IComSecurityEvents = interface;
  {$EXTERNALSYM IComSecurityEvents}
  IComObjectPoolEvents = interface;
  {$EXTERNALSYM IComObjectPoolEvents}
  IComObjectPoolEvents2 = interface;
  {$EXTERNALSYM IComObjectPoolEvents2}
  IComObjectConstructionEvents = interface;
  {$EXTERNALSYM IComObjectConstructionEvents}
  IComActivityEvents = interface;
  {$EXTERNALSYM IComActivityEvents}
  IComIdentityEvents = interface;
  {$EXTERNALSYM IComIdentityEvents}
  IComQCEvents = interface;
  {$EXTERNALSYM IComQCEvents}
  IComExceptionEvents = interface;
  {$EXTERNALSYM IComExceptionEvents}
  IComCRMEvents = interface;
  {$EXTERNALSYM IComCRMEvents}
  ICrmMonitorLogRecords = interface;
  {$EXTERNALSYM ICrmMonitorLogRecords}
  ICrmMonitor = interface;
  {$EXTERNALSYM ICrmMonitor}
  ICrmMonitorClerks = interface;
  {$EXTERNALSYM ICrmMonitorClerks}
  ILBEvents = interface;
  {$EXTERNALSYM ILBEvents}
  IMessageMover = interface;
  {$EXTERNALSYM IMessageMover}
  IDispenserManager = interface;
  {$EXTERNALSYM IDispenserManager}
  IDispenserManagerShutdownGuarantee = interface;
  {$EXTERNALSYM IDispenserManagerShutdownGuarantee}
  IDispenserDriver = interface;
  {$EXTERNALSYM IDispenserDriver}
  IHolder = interface;
  {$EXTERNALSYM IDispenserDriver}
  IReceiveAppData = interface;
  {$EXTERNALSYM IReceiveAppData}
  IGetAppData = interface;
  {$EXTERNALSYM IGetAppData}
  IEventServer = interface;
  {$EXTERNALSYM IEventServer}
  IProcessTerminateNotify = interface;
  {$EXTERNALSYM IProcessTerminateNotify}


  POleVariant1 = ^OleVariant;
  {$EXTERNALSYM POleVariant1}
  PUserType1 = ^TGUID;
  {$EXTERNALSYM PUserType1}
  PIUnknown1 = ^IUnknown;
  {$EXTERNALSYM PIUnknown1}
  PPPrivateAlias1 = ^Pointer;
  {$EXTERNALSYM PPPrivateAlias1}
  PUserType2 = ^tagBLOB;
  {$EXTERNALSYM PUserType2}
  PUserType3 = ^BOID;
  {$EXTERNALSYM PUserType3}
  PUserType4 = ^COMSVCSEVENTINFO;
  {$EXTERNALSYM PUserType4}
  PByte1 = ^Byte;
  {$EXTERNALSYM PByte1}
  PUserType5 = ^CLSIDDATA;
  {$EXTERNALSYM PUserType5}
  PUserType6 = ^appData;
  {$EXTERNALSYM PUserType6}

  tagBLOB = record
    cbSize: LongWord;
    pBlobData: ^Byte;
  end;
  {$EXTERNALSYM tagBLOB}

  tagCrmLogRecordRead = record
    dwCrmFlags: LongWord;
    dwSequenceNumber: LongWord;
    blobUserData: tagBLOB;
  end;
  {$EXTERNALSYM tagCrmLogRecordRead}

  Error_Constants = __MIDL___MIDL_itf_autosvcs_0342_0001;
  {$EXTERNALSYM Error_Constants}

  BOID = record
    rgb: array[0..15] of Byte;
  end;
  {$EXTERNALSYM BOID}

  XACTTRANSINFO = record
    uow: BOID;
    isoLevel: Integer;
    isoFlags: LongWord;
    grfTCSupported: LongWord;
    grfRMSupported: LongWord;
    grfTCSupportedRetaining: LongWord;
    grfRMSupportedRetaining: LongWord;
  end;
  {$EXTERNALSYM XACTTRANSINFO}

  LockModes = __MIDL___MIDL_itf_autosvcs_0342_0002;
  {$EXTERNALSYM LockModes}
  ReleaseModes = __MIDL___MIDL_itf_autosvcs_0342_0003;
  {$EXTERNALSYM ReleaseModes}

  __MIDL___MIDL_itf_autosvcs_0279_0001 = record
    cbSize: DWORD;
    dwPid: DWORD;
    lTime: LONGLONG;
    lMicroTime: Integer;
    perfCount: LONGLONG;
    guidApp: TGUID;
    sMachineName: PWideChar;
  end;
  {$EXTERNALSYM __MIDL___MIDL_itf_autosvcs_0279_0001}

  COMSVCSEVENTINFO = __MIDL___MIDL_itf_autosvcs_0279_0001;
  {$EXTERNALSYM COMSVCSEVENTINFO}
  ULONG_PTR = LongWord;
  {$EXTERNALSYM ULONG_PTR}

  CAppStatistics = record
    m_cTotalCalls: LongWord;
    m_cTotalInstances: LongWord;
    m_cTotalClasses: LongWord;
    m_cCallsPerSecond: LongWord;
  end;
  {$EXTERNALSYM CAppStatistics}

  APPSTATISTICS = CAppStatistics;
  {$EXTERNALSYM APPSTATISTICS}

  CCLSIDData = record
    m_clsid: TGUID;
    m_cReferences: LongWord;
    m_cBound: LongWord;
    m_cPooled: LongWord;
    m_cInCall: LongWord;
    m_dwRespTime: LongWord;
    m_cCallsCompleted: LongWord;
    m_cCallsFailed: LongWord;
  end;
  {$EXTERNALSYM CCLSIDData}

  CLSIDDATA = CCLSIDData;
  {$EXTERNALSYM CLSIDDATA}

  CAppData = record
    m_idApp: LongWord;
    m_szAppGuid: array[0..39] of Word;
    m_dwAppProcessId: LongWord;
    m_AppStatistics: CAppStatistics;
  end;
  {$EXTERNALSYM CAppData}

  appData = CAppData;
  {$EXTERNALSYM appData}
  PrivateAlias1 = array[0..59] of Word; {*}
  {$EXTERNALSYM PrivateAlias1}

{ ISecurityIdentityColl }

  ISecurityIdentityColl = interface(IDispatch)
    ['{CAFC823C-B441-11D1-B82B-0000F8757E2A}']
    function get_Count: Integer; safecall;
    function get_Item(const name: WideString): OleVariant; safecall;
    function get__NewEnum: IUnknown; safecall;
  end;
  {$EXTERNALSYM ISecurityIdentityColl}

{ ISecurityCallersColl }

  ISecurityCallersColl = interface(IDispatch)
    ['{CAFC823D-B441-11D1-B82B-0000F8757E2A}']
    function get_Count: Integer; safecall;
    function get_Item(lIndex: Integer): ISecurityIdentityColl; safecall;
    function get__NewEnum: IUnknown; safecall;
  end;
  {$EXTERNALSYM ISecurityCallersColl}

{ ISecurityCallContext }

  ISecurityCallContext = interface(IDispatch)
    ['{CAFC823E-B441-11D1-B82B-0000F8757E2A}']
    function get_Count: Integer; safecall;
    function get_Item(const name: WideString): OleVariant; safecall;
    function get__NewEnum: IUnknown; safecall;
    function IsCallerInRole(const bstrRole: WideString): WordBool; safecall;
    function IsSecurityEnabled: WordBool; safecall;
    function IsUserInRole(const pUser: OleVariant; const bstrRole: WideString): WordBool; safecall;
  end;
  {$EXTERNALSYM ISecurityCallContext}

{ IGetSecurityCallContext }

  IGetSecurityCallContext = interface(IDispatch)
    ['{CAFC823F-B441-11D1-B82B-0000F8757E2A}']
    function GetSecurityCallContext: ISecurityCallContext; safecall;
  end;
  {$EXTERNALSYM IGetSecurityCallContext}

{ IContextState }

  IContextState = interface(IUnknown)
    ['{3C05E54B-A42A-11D2-AFC4-00C04F8EE1C4}']
    procedure SetDeactivateOnReturn(bDeactivate: WordBool); safecall;
    procedure GetDeactivateOnReturn(out pbDeactivate: WordBool); safecall;
    procedure SetMyTransactionVote(txVote: tagTransactionVote); safecall;
    procedure GetMyTransactionVote(out ptxVote: tagTransactionVote); safecall;
  end;
  {$EXTERNALSYM IContextState}

{ IObjectConstruct }

  IObjectConstruct = interface(IUnknown)
    ['{41C4F8B3-7439-11D2-98CB-00C04F8EE1C4}']
    function  Construct(const pCtorObj: IDispatch): HResult; stdcall;
  end;
  {$EXTERNALSYM IObjectConstruct}

{ IObjectConstructString }

  IObjectConstructString = interface(IDispatch)
    ['{41C4F8B2-7439-11D2-98CB-00C04F8EE1C4}']
    function get_ConstructString: WideString; safecall;
  end;
  {$EXTERNALSYM IObjectConstructString}

{ IObjectContextTip }

  IObjectContextTip = interface(IUnknown)
    ['{92FD41CA-BAD9-11D2-9A2D-00C04F797BC9}']
    procedure GetTipUrl(out pTipUrl: WideString); safecall;
  end;
  {$EXTERNALSYM IObjectContextTip}

{ IPlaybackControl }

  IPlaybackControl = interface(IUnknown)
    ['{51372AFD-CAE7-11CF-BE81-00AA00A2FA25}']
    procedure FinalClientRetry; safecall;
    procedure FinalServerRetry; safecall;
  end;
  {$EXTERNALSYM IPlaybackControl}

{ ICrmCompensator }

  ICrmCompensator = interface(IUnknown)
    ['{BBC01830-8D3B-11D1-82EC-00A0C91EEDE9}']
    procedure SetLogControl(const pLogControl: ICrmLogControl); safecall;
    procedure BeginPrepare; safecall;
    function PrepareRecord(const pLogRecord: OleVariant): Boolean; safecall;
    function EndPrepare: Boolean; safecall;
    procedure BeginCommit(fRecovery: Integer); safecall;
    function CommitRecord(const pLogRecord: OleVariant): Boolean; safecall;
    procedure EndCommit; safecall;
    procedure BeginAbort(bRecovery: Boolean); safecall;
    function AbortRecord(const pLogRecord): Boolean; safecall;
    procedure EndAbort; safecall;
  end;
  {$EXTERNALSYM ICrmCompensator}

{ ICrmCompensatorVariants }

  ICrmCompensatorVariants = interface(IUnknown)
    ['{F0BAF8E4-7804-11D1-82E9-00A0C91EEDE9}']
    procedure SetLogControlVariants(const pLogControl: ICrmLogControl); safecall;
    procedure BeginPrepareVariants; safecall;
    function PrepareRecordVariants(const pLogRecord: OleVariant): WordBool; safecall;
    function EndPrepareVariants: WordBool; safecall;
    procedure BeginCommitVariants(bRecovery: WordBool); safecall;
    function CommitRecordVariants(const pLogRecord: OleVariant): WordBool; safecall;
    procedure EndCommitVariants; safecall;
    procedure BeginAbortVariants(bRecovery: WordBool); safecall;
    function AbortRecordVariants(var pLogRecord: OleVariant): WordBool; safecall;
    procedure EndAbortVariants; safecall;
  end;
  {$EXTERNALSYM ICrmCompensatorVariants}

{ ICrmLogControl }

  ICrmLogControl = interface(IUnknown)
    ['{A0E174B3-D26E-11D2-8F84-00805FC7BCD9}']
    function get_TransactionUOW : WideString; safecall;
    procedure RegisterCompensator(lpcwstrProgIdCompensator, lpcwstrDescription: PWideChar;
                                 lCrmRegFlags: Integer); safecall;
    procedure WriteLogRecordVariants(var pLogRecord: OleVariant); safecall;
    procedure ForceLog; safecall;
    procedure ForgetLogRecord; safecall;
    procedure ForceTransactionToAbort; safecall;
    procedure WriteLogRecord(const rgBlob: tagBLOB; const cBlob: LongWord); safecall;
  end;
  {$EXTERNALSYM ICrmLogControl}

{ ICrmFormatLogRecords }

  ICrmFormatLogRecords = interface(IUnknown)
    ['{9C51D821-C98B-11D1-82FB-00A0C91EEDE9}']
    procedure GetColumnCount(out plColumnCount: Integer); safecall;
    procedure GetColumnHeaders(out pHeaders: OleVariant); safecall;
    procedure GetColumn(crmLogRec: tagCrmLogRecordRead; out pFormattedLogRecord: OleVariant); safecall;
    procedure GetColumnVariants(LogRecord: OleVariant; out pFormattedLogRecord: OleVariant); safecall;
  end;
  {$EXTERNALSYM ICrmFormatLogRecords}

{ ObjectControl }

  ObjectControl = interface(IUnknown)
    ['{7DC41850-0C31-11D0-8B79-00AA00B8A790}']
    procedure Activate; safecall;
    procedure Deactivate; safecall;
    function CanBePooled: WordBool; safecall;
  end;
  {$EXTERNALSYM ObjectControl}

{ IMTxAs}

  IMTxAS = interface(IDispatch)
    ['{74C08641-CEDB-11CF-8B49-00AA00B8A790}']
    function GetObjectContext: ObjectContext; safecall;
    function SafeRef(vRefIn: OleVariant): OleVariant; safecall;
  end;
  {$EXTERNALSYM IMTxAS}

{ ObjectContext }

  ObjectContext = interface(IDispatch)
    ['{74C08646-CEDB-11CF-8B49-00AA00B8A790}']
    function CreateInstance(const bstrProgID: WideString): OleVariant; safecall;
    procedure SetComplete; safecall;
    procedure SetAbort; safecall;
    procedure EnableCommit; safecall;
    procedure DisableCommit; safecall;
    function IsInTransaction: WordBool; safecall;
    function IsSecurityEnabled: WordBool; safecall;
    function IsCallerInRole(const bstrRole: WideString): WordBool; safecall;
    function get_Count: Integer; safecall;
    function get_Item(const name: WideString): OleVariant; safecall;
    function get__NewEnum: IUnknown; safecall;
    function get_Security: SecurityProperty; safecall;
    function get_ContextInfo: ContextInfo; safecall;
  end;
  {$EXTERNALSYM ObjectContext}

{ SecurityProperty }

  SecurityProperty = interface(IDispatch)
    ['{E74A7215-014D-11D1-A63C-00A0C911B4E0}']
    function GetDirectCallerName: WideString; safecall;
    function GetDirectCreatorName: WideString; safecall;
    function GetOriginalCallerName: WideString; safecall;
    function GetOriginalCreatorName: WideString; safecall;
  end;
  {$EXTERNALSYM SecurityProperty}

{ ContextInfo }

  ContextInfo = interface(IDispatch)
    ['{19A5A02C-0AC8-11D2-B286-00C04F8EF934}']
    function IsInTransaction: WordBool; safecall;
    function GetTransaction: IUnknown; safecall;
    function GetTransactionId: WideString; safecall;
    function GetActivityId: WideString; safecall;
    function GetContextId: WideString; safecall;
  end;
  {$EXTERNALSYM ContextInfo}

{ ICreateWithTipTransactionEx }

  ICreateWithTipTransactionEx = interface(IUnknown)
    ['{455ACF59-5345-11D2-99CF-00C04F797BC9}']
    function CreateInstance(const bstrTipUrl: WideString;
                            const rclsid, riid: TGUID): Pointer; safecall;
  end;
  {$EXTERNALSYM ICreateWithTipTransactionEx}

{ ICreateWithTransactionEx }

  ICreateWithTransactionEx = interface(IUnknown)
    ['{455ACF57-5345-11D2-99CF-00C04F797BC9}']
    function CreateInstance(const pTransaction: ITransaction;
                            const rclsid, riid: TGUID): Pointer; stdcall;
  end;
  {$EXTERNALSYM ICreateWithTransactionEx}

{ ITransaction }

  ITransaction = interface(IUnknown)
    ['{0FB15084-AF41-11CE-BD2B-204C4F4F5020}']
    procedure Commit(fRetaining: Integer; grfTC: LongWord; grfRM: LongWord); safecall;
    procedure Abort(var pboidReason: BOID; fRetaining: Integer; fAsync: Integer); safecall;
    procedure GetTransactionInfo(out pinfo: XACTTRANSINFO); safecall;
  end;
  {$EXTERNALSYM ITransaction}

{ IMtsEvents }

  IMtsEvents = interface(IDispatch)
    ['{BACEDF4D-74AB-11D0-B162-00AA00BA3258}']
    function get_PackageName: WideString; safecall;
    function get_PackageGuid: WideString; safecall;
    procedure PostEvent(const vEvent: OleVariant); safecall;
    function get_FireEvents: WordBool; safecall;
    function GetProcessID: Integer; safecall;
  end;
  {$EXTERNALSYM IMtsEvents}

  IMtsEventInfo = interface(IDispatch)
    ['{D56C3DC1-8482-11D0-B170-00AA00BA3258}']
    function Get_Names: IUnknown; safecall;
    function Get_DisplayName: WideString; safecall;
    function Get_EventID: WideString; safecall;
    function Get_Count: Integer; safecall;
    function Get_Value(const sKey: WideString): OleVariant; safecall;
  end;
  {$EXTERNALSYM IMtsEventInfo}

{ IMTSLocator }

  IMTSLocator = interface(IDispatch)
    ['{D19B8BFD-7F88-11D0-B16E-00AA00BA3258}']
    function GetEventDispatcher: IUnknown; safecall;
  end;
  {$EXTERNALSYM IMTSLocator}

{ IMtsGrp }

  IMtsGrp = interface(IDispatch)
    ['{4B2E958C-0393-11D1-B1AB-00AA00BA3258}']
    function  Get_Count: Integer; safecall;
    procedure Item(const lIndex: Integer; out ppUnkDispatcher: IUnknown);safecall;
    procedure Refresh; safecall;
  end;
  {$EXTERNALSYM IMtsGrp}

{ IComThreadEvents }

  IComThreadEvents = interface(IUnknown)
    ['{683130A5-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnThreadStart({varconst???}const pInfo: COMSVCSEVENTINFO;
                     const ThreadID: Largeuint;
                     const dwThread, dwTheadCnt: LongWord); safecall;
    procedure OnThreadTerminate(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID: Largeuint;
                     const dwThread, dwTheadCnt: LongWord); safecall;
    procedure OnThreadBindToApartment(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID: Largeuint;
                     const AptID: Largeuint;
                     const dwActCnt, dwLowCnt: LongWord); safecall;
    procedure OnThreadUnBind(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID: Largeuint;
                     const AptID: Largeuint;
                     const dwActCnt: LongWord); safecall;
    procedure OnThreadWorkEnque(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID, MsgWorkID: Largeuint;
                     const QueueLen: LongWord); safecall;
    procedure OnThreadWorkPrivate(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID, MsgWorkID: Largeuint); safecall;
    procedure OnThreadWorkPublic(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID, MsgWorkID: Largeuint;
                     const QueueLen: LongWord); safecall;
    procedure OnThreadWorkRedirect(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID, MsgWorkID: Largeuint;
                     const QueueLen: LongWord; ThreadNum: Largeuint); safecall;
    procedure OnThreadWorkReject(const pInfo: COMSVCSEVENTINFO;
                     const ThreadID, MsgWorkID: Largeuint;
                     const QueueLen: LongWord); safecall;
    procedure OnThreadAssignApartment(const pInfo: COMSVCSEVENTINFO;
                     const guidActivity: TGUID;
                     const AptID: Largeuint); safecall;
    procedure OnThreadUnassignApartment(const pInfo: COMSVCSEVENTINFO;
                     const AptID: Largeuint); safecall;
  end;
  {$EXTERNALSYM IComThreadEvents}

{ IComUserEvent }

  IComUserEvent = interface(IUnknown)
    ['{683130A4-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnUserEvent(const pInfo: COMSVCSEVENTINFO); safecall;
  end;
  {$EXTERNALSYM IComUserEvent}

{ IComAppEvents }

  IComAppEvents = interface(IUnknown)
    ['{683130A6-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnAppActivation(const pInfo: COMSVCSEVENTINFO; guidApp: TGUID); safecall;
    procedure OnAppShutdown(const pInfo: COMSVCSEVENTINFO; guidApp: TGUID); safecall;
    procedure OnAppForceShutdown(const pInfo: COMSVCSEVENTINFO; guidApp: TGUID); safecall;
  end;
  {$EXTERNALSYM IComAppEvents}

{ IComInstanceEvents}

  IComInstanceEvents = interface(IUnknown)
    ['{683130A7-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnObjectCreate(const pInfo: COMSVCSEVENTINFO;
                            const guidActivity, clsid: TGUID; const tsid: TGUID;
                            CtxtID, ObjectID: Largeuint); safecall;
    procedure OnObjectDestroy(const pInfo: COMSVCSEVENTINFO; CtxtID: Largeuint); safecall;
  end;
  {$EXTERNALSYM IComInstanceEvents}

{ IComTransactionEvents }

  IComTransactionEvents = interface(IUnknown)
    ['{683130A8-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnTransactionStart(const pInfo: COMSVCSEVENTINFO;
                                const guidTx, tsid: TGUID;
                                fRoot: Integer); safecall;
    procedure OnTransactionPrepare(const pinfo: COMSVCSEVENTINFO;
                                  const guidTx: TGUID; fVoteYes: Integer); safecall;
    procedure OnTransactionAbort(const pinfo: COMSVCSEVENTINFO; const guidTx: TGUID); safecall;
    procedure OnTransactionCommit(const pinfo: COMSVCSEVENTINFO; const guidTx: TGUID); safecall;
  end;
  {$EXTERNALSYM IComTransactionEvents}

{ IComMethodEvents }

  IComMethodEvents = interface(IUnknown)
    ['{683130A9-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnMethodCall(const pinfo: COMSVCSEVENTINFO; oid: Largeuint;
                           const guidCid, guidRid: TGUID;
                           iMeth: LongWord); safecall;
    procedure OnMethodReturn(const pinfo: COMSVCSEVENTINFO; oid: Largeuint;
                            const guidCid, guidRid: TGUID; iMeth: LongWord;
                            hresult: HResult); safecall;
    procedure OnMethodException(const pinfo: COMSVCSEVENTINFO; oid: Largeuint;
                               const guidCid, guidRid: TGUID; iMeth: LongWord); safecall;
  end;
  {$EXTERNALSYM IComMethodEvents}

{ IComObjectEvents }

  IComObjectEvents = interface(IUnknown)
    ['{683130AA-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnObjectActivate(const pInfo: COMSVCSEVENTINFO; CtxtID, ObjectID: Largeuint); safecall;
    procedure OnObjectDeactivate(const pInfo: COMSVCSEVENTINFO; CtxtID, ObjectID: Largeuint); safecall;
    procedure OnDisableCommit(const pInfo: COMSVCSEVENTINFO; CtxtID: Largeuint); safecall;
    procedure OnEnableCommit(const pInfo: COMSVCSEVENTINFO; CtxtID: Largeuint); safecall;
    procedure OnSetComplete(const pInfo: COMSVCSEVENTINFO; CtxtID: Largeuint); safecall;
    procedure OnSetAbort(const pInfo: COMSVCSEVENTINFO; CtxtID: Largeuint); safecall;
  end;
  {$EXTERNALSYM IComObjectEvents}

{ IComResourceEvents }

  IComResourceEvents = interface(IUnknown)
    ['{683130AB-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnResourceCreate(const pinfo: COMSVCSEVENTINFO; ObjectID: Largeuint;
                              pszType: PWideChar; resId: Largeuint; enlisted: Integer); safecall;
    procedure OnResourceAllocate(const pinfo: COMSVCSEVENTINFO; ObjectID: Largeuint;
                                pszType: PWideChar; resId: Largeuint; enlisted: Integer;
                                NumRated: LongWord; Rating: LongWord); safecall;
    procedure OnResourceRecycle(const pinfo: COMSVCSEVENTINFO; ObjectID: Largeuint;
                               pszType: PWideChar; resId: Largeuint); safecall;
    procedure OnResourceDestroy(const pinfo: COMSVCSEVENTINFO; ObjectID: Largeuint; hr: HResult;
                               pszType: PWideChar; resId: Largeuint); safecall;
    procedure OnResourceTrack(const pinfo: COMSVCSEVENTINFO; ObjectID: Largeuint; pszType: PWideChar;
                             resId: Largeuint; enlisted: Integer); safecall;
  end;
  {$EXTERNALSYM IComResourceEvents}

{ IComSecurityEvents }

  IComSecurityEvents = interface(IUnknown)
    ['{683130AC-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnAuthenticate(pInfo: COMSVCSEVENTINFO; guidActivity: TGUID;
                            ObjectID: Largeuint; guidIID: TGUID;
                            iMeth, cbByteOrig: LongWord; pSidOriginalUser: Byte;
                            cbByteCur: LongWord; pSidCurrentUser: Byte;
                            bCurrentUserInpersonatingInProc: Integer); safecall;
    procedure OnAuthenticateFail(pInfo: COMSVCSEVENTINFO; guidActivity: TGUID;
                            ObjectID: Largeuint; guidIID: TGUID;
                            iMeth, cbByteOrig: LongWord; pSidOriginalUser: Byte;
                            cbByteCur: LongWord; pSidCurrentUser: Byte;
                            bCurrentUserInpersonatingInProc: Integer); safecall;
  end;
  {$EXTERNALSYM IComSecurityEvents}

{ IComObjectPoolEvents }

  IComObjectPoolEvents = interface(IUnknown)
    ['{683130AD-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnObjPoolPutObject(pInfo: COMSVCSEVENTINFO; guidObject: TGUID;
                                 nReason: SYSINT; dwAvailable: LongWord; oid: Largeuint); safecall;
    procedure OnObjPoolGetObject(pInfo: COMSVCSEVENTINFO; guidActivity: TGUID;
                                 guidObject: TGUID; dwAvailable: LongWord; oid: Largeuint); safecall;
    procedure OnObjPoolRecycleToTx(pInfo: COMSVCSEVENTINFO; guidActivity: TGUID;
                                   guidObject: TGUID; guidTx: TGUID; objid: Largeuint); safecall;
    procedure OnObjPoolGetFromTx(pInfo: COMSVCSEVENTINFO; guidActivity: TGUID;
                                 guidObject: TGUID; guidTx: TGUID; objid: Largeuint); safecall;
  end;
  {$EXTERNALSYM IComObjectPoolEvents}

{ IComObjectPoolEvents2 }

  IComObjectPoolEvents2 = interface(IUnknown)
    ['{683130AE-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnObjPoolCreateObject(pInfo: COMSVCSEVENTINFO; guidObject: TGUID;
                                    dwObjsCreated: LongWord; oid: Largeuint); safecall;
    procedure OnObjPoolDestroyObject(pInfo: COMSVCSEVENTINFO; guidObject: TGUID;
                                     dwObjsCreated: LongWord; oid: Largeuint); safecall;
    procedure OnObjPoolCreateDecision(pInfo: COMSVCSEVENTINFO; dwThreadsWaiting: LongWord;
                                      dwAvail: LongWord; dwCreated: LongWord; dwMin: LongWord;
                                      dwMax: LongWord); safecall;
    procedure OnObjPoolTimeout(pInfo: COMSVCSEVENTINFO; guidObject: TGUID;
                               guidActivity: TGUID; dwTimeout: LongWord); safecall;
    procedure OnObjPoolCreatePool(pInfo: COMSVCSEVENTINFO; guidObject: TGUID;
                                  dwMin: LongWord; dwMax: LongWord; dwTimeout: LongWord); safecall;
  end;
  {$EXTERNALSYM IComObjectPoolEvents2}

{ IComObjectConstructionEvents }

  IComObjectConstructionEvents = interface(IUnknown)
    ['{683130AF-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnObjectConstruct(pInfo: COMSVCSEVENTINFO; guidObject: TGUID;
                                sConstructString: PWideChar; oid: Largeuint); safecall;
  end;
  {$EXTERNALSYM IComObjectConstructionEvents}

{ IComActivityEvents }

  IComActivityEvents = interface(IUnknown)
    ['{683130B0-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnActivityCreate(const pInfo: COMSVCSEVENTINFO; const guidActivity: TGUID); safecall;
    procedure OnActivityDestroy(const pinfo: COMSVCSEVENTINFO; const guidActivity: TGUID); safecall;
    procedure OnActivityEnter(const pinfo: COMSVCSEVENTINFO; const guidCurrent: TGUID;
                              const guidEntered: TGUID; dwThread: LongWord); safecall;
    procedure OnActivityTimeout(const pinfo: COMSVCSEVENTINFO; const guidCurrent: TGUID;
                                const guidEntered: TGUID; dwThread: LongWord; dwTimeout: LongWord); safecall;
    procedure OnActivityReenter(const pinfo: COMSVCSEVENTINFO; const guidCurrent: TGUID;
                                dwThread: LongWord; dwCallDepth: LongWord); safecall;
    procedure OnActivityLeave(const pinfo: COMSVCSEVENTINFO;
                              const guidCurrent, guidLeft: TGUID); safecall;
    procedure OnActivityLeaveSame(const pinfo: COMSVCSEVENTINFO; const guidCurrent: TGUID;
                                  dwCallDepth: LongWord); safecall;
  end;
  {$EXTERNALSYM IComActivityEvents}

{ IComIdentityEvents }

  IComIdentityEvents = interface(IUnknown)
    ['{683130B1-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnIISRequestInfo(pInfo: COMSVCSEVENTINFO; objid: Largeuint;
                               pszClientIP: PWideChar; pszServerIP: PWideChar;
                               pszURL: PWideChar); safecall;
  end;
  {$EXTERNALSYM IComIdentityEvents}

{ IComQCEvents }

  IComQCEvents = interface(IUnknown)
    ['{683130B2-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnQCRecord(const pInfo: COMSVCSEVENTINFO; objid: Largeuint; szQueue: PrivateAlias1;
                         const guidMsgId, guidWorkFlowId: TGUID; msmqhr: HResult); safecall;
    procedure OnQCQueueOpen(const pInfo: COMSVCSEVENTINFO; szQueue: PrivateAlias1;
                            QueueID: Largeuint; hr: HResult); safecall;
    procedure OnQCReceive(const pInfo: COMSVCSEVENTINFO; QueueID: Largeuint; var guidMsgId: TGUID;
                          const guidWorkFlowId: TGUID; hr: HResult); safecall;
    procedure OnQCReceiveFail(const pInfo: COMSVCSEVENTINFO; QueueID: Largeuint; msmqhr: HResult); safecall;
    procedure OnQCMoveToReTryQueue(const pInfo: COMSVCSEVENTINFO; const guidMsgId: TGUID;
                                   const guidWorkFlowId: TGUID; RetryIndex: LongWord); safecall;
    procedure OnQCMoveToDeadQueue(const pInfo: COMSVCSEVENTINFO; const guidMsgId: TGUID;
                                  const guidWorkFlowId: TGUID); safecall;
    procedure OnQCPlayback(const pInfo: COMSVCSEVENTINFO; objid: Largeuint; var guidMsgId: TGUID;
                           const guidWorkFlowId: TGUID; hr: HResult); safecall;
  end;
  {$EXTERNALSYM IComQCEvents}

{ IComExceptionEvents }

  IComExceptionEvents = interface(IUnknown)
    ['{683130B3-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnExceptionUser(const pinfo: COMSVCSEVENTINFO; code: LongWord; address: Largeuint;
                              pszStackTrace: PWideChar); safecall;
  end;
  {$EXTERNALSYM IComExceptionEvents}

{ IComCRMEvents }

  IComCRMEvents = interface(IUnknown)
    ['{683130B5-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure OnCRMRecoveryStart(const pInfo: COMSVCSEVENTINFO; guidApp: TGUID); safecall;
    procedure OnCRMRecoveryDone(const pInfo: COMSVCSEVENTINFO; guidApp: TGUID); safecall;
    procedure OnCRMCheckpoint(const pInfo: COMSVCSEVENTINFO; guidApp: TGUID); safecall;
    procedure OnCRMBegin(const pInfo: COMSVCSEVENTINFO;
                        guidClerkCLSID, guidActivity, guidTx: TGUID; szProgIdCompensator: PrivateAlias1;
                        szDescription: PrivateAlias1); safecall;
    procedure OnCRMPrepare(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMCommit(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMAbort(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMIndoubt(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMDone(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMRelease(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMAnalyze(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID;
                          dwCrmRecordType: LongWord; dwRecordSize: LongWord); safecall;
    procedure OnCRMWrite(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID; fVariants: Integer;
                        dwRecordSize: LongWord); safecall;
    procedure OnCRMForget(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMForce(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID); safecall;
    procedure OnCRMDeliver(const pInfo: COMSVCSEVENTINFO; guidClerkCLSID: TGUID; fVariants: Integer;
                           dwRecordSize: LongWord); safecall;
  end;
  {$EXTERNALSYM IComCRMEvents}

{ ICrmMonitorLogRecords }

  ICrmMonitorLogRecords = interface(IUnknown)
    ['{70C8E441-C7ED-11D1-82FB-00A0C91EEDE9}']
    function get_Count: Integer; safecall;
    function get_TransactionState: tagCrmTransactionState; safecall;
    function get_StructuredRecords: WordBool; safecall;
    procedure GetLogRecord(dwIndex: LongWord; var pCrmLogRec: tagCrmLogRecordRead); safecall;
    function GetLogRecordVariants(IndexNumber: OleVariant): OleVariant; safecall;
  end;
  {$EXTERNALSYM ICrmMonitorLogRecords}

{ ICrmMonitor }

  ICrmMonitor = interface(IUnknown)
    ['{70C8E443-C7ED-11D1-82FB-00A0C91EEDE9}']
    function GetClerks: ICrmMonitorClerks; safecall;
    function HoldClerk(Index: OleVariant): OleVariant; safecall;
  end;
  {$EXTERNALSYM ICrmMonitor}

{ ICrmMonitorClerks }

  ICrmMonitorClerks = interface(IDispatch)
    ['{70C8E442-C7ED-11D1-82FB-00A0C91EEDE9}']
    function Item(Index: OleVariant): OleVariant; safecall;
    function get__NewEnum: IUnknown; safecall;
    function get_Count: Integer; safecall;
    function ProgIdCompensator(Index: OleVariant): OleVariant; safecall;
    function Description(Index: OleVariant): OleVariant; safecall;
    function TransactionUOW(Index: OleVariant): OleVariant; safecall;
    function ActivityId(Index: OleVariant): OleVariant; safecall;
  end;
  {$EXTERNALSYM ICrmMonitorClerks}

{ ILBEvents }

  ILBEvents = interface(IUnknown)
    ['{683130B4-2E50-11D2-98A5-00C04F8EE1C4}']
    procedure TargetUp(bstrServerName: WideString; bstrClsidEng: WideString); safecall;
    procedure TargetDown(bstrServerName: WideString; bstrClsidEng: WideString); safecall;
    procedure EngineDefined(bstrPropName: WideString; varPropValue: OleVariant;
                           bstrClsidEng: WideString); safecall;
  end;
  {$EXTERNALSYM ILBEvents}

{ IMessageMover }

  IMessageMover = interface(IDispatch)
    ['{588A085A-B795-11D1-8054-00C04FC340EE}']
    function get_SourcePath: WideString; safecall;
    procedure put_SourcePath(const pVal: WideString); safecall;
    function get_DestPath: WideString; safecall;
    procedure put_DestPath(const pVal: WideString); safecall;
    function get_CommitBatchSize: Integer; safecall;
    procedure put_CommitBatchSize(pVal: Integer); safecall;
    function MoveMessages: Integer; safecall;
  end;
  {$EXTERNALSYM IMessageMover}

{ IDispenserManager }

  IDispenserManager = interface(IUnknown)
    ['{5CB31E10-2B5F-11CF-BE10-00AA00A2FA25}']
    procedure RegisterDispenser(const __MIDL_0011: IDispenserDriver; szDispenserName: PWideChar;
                               out __MIDL_0012: IHolder); safecall;
    procedure GetContext(out __MIDL_0013: ULONG_PTR; out __MIDL_0014: ULONG_PTR); safecall;
  end;
  {$EXTERNALSYM IDispenserManager}

{ IDispenserManagerShutdownGuarantee }

  IDispenserManagerShutdownGuarantee = interface(IUnknown)
    ['{5CB31E11-2B5F-11CF-BE10-00AA00A2FA25}']
    procedure IsComPlusApp(out pfIsComPlusApp: Integer); safecall;
  end;
  {$EXTERNALSYM IDispenserManagerShutdownGuarantee}

{ IDispenserDriver }

  IDispenserDriver = interface(IUnknown)
    ['{208B3651-2B48-11CF-BE10-00AA00A2FA25}']
    procedure CreateResource(const ResTypId: ULONG_PTR; out pResId: ULONG_PTR;
                            out pSecsFreeBeforeDestroy: Integer); safecall;
    procedure RateResource(const ResTypId: ULONG_PTR; const resId: ULONG_PTR;
                          const fRequiresTransactionEnlistment: Integer; out pRating: LongWord); safecall;
    procedure EnlistResource(const resId: ULONG_PTR; const TransId: ULONG_PTR); safecall;
    procedure ResetResource(const resId: ULONG_PTR); safecall;
    procedure DestroyResource(const resId: ULONG_PTR); safecall;
    procedure DestroyResourceS(const resId: PWideChar); safecall;
  end;
  {$EXTERNALSYM IDispenserDriver}

{ IHolder }

  IHolder = interface(IUnknown)
    ['{BF6A1850-2B45-11CF-BE10-00AA00A2FA25}']
    procedure AllocResource(const __MIDL_0015: ULONG_PTR; out __MIDL_0016: ULONG_PTR); safecall;
    procedure FreeResource(const __MIDL_0017: ULONG_PTR); safecall;
    procedure TrackResource(const __MIDL_0018: ULONG_PTR); safecall;
    procedure TrackResourceS(const __MIDL_0019: PWideChar); safecall;
    procedure UntrackResource(const __MIDL_0020: ULONG_PTR; const __MIDL_0021: Integer); safecall;
    procedure UntrackResourceS(const __MIDL_0022: PWideChar; const __MIDL_0023: Integer); safecall;
    procedure Close; safecall;
    procedure RequestDestroyResource(const __MIDL_0024: ULONG_PTR); safecall;
  end;
  {$EXTERNALSYM IHolder}

{ IReceiveAppData }

  IReceiveAppData = interface(IUnknown)
    ['{413DAFB0-BCF4-11D1-861D-0080C729264D}']
    procedure Register(pAppGuid: PWideChar; dwAppProcessId: LongWord; out pidApp: LongWord;
                       out pPushRate: LongWord); safecall;
    procedure PushAppData(idApp: LongWord; appData: APPSTATISTICS; nCLSIDs: LongWord;
                          var clsids: CLSIDDATA); safecall;
    procedure Unregister(idApp: LongWord); safecall;
  end;
  {$EXTERNALSYM IReceiveAppData}

{ IGetAppData }

  IGetAppData = interface(IUnknown)
    ['{B60040E0-BCF3-11D1-861D-0080C729264D}']
    procedure SetPushRate(dwPushRate: LongWord); safecall;
    procedure GetApps(out nApps: LongWord; out aAppData: PUserType6); safecall;
    procedure GetAppData(idApp: LongWord; out nCLSIDs: LongWord; out aAppData: PUserType5); safecall;
    procedure GetCLSIDData(idApp: LongWord; clsid: TGUID; out ppAppData: PUserType5); safecall;
    procedure Shutdown; safecall;
  end;
  {$EXTERNALSYM IGetAppData}

{ IEventServer }

  IEventServer = interface(IUnknown)
    ['{F1CB0608-EC04-11D1-93AE-00AA00BA3258}']
    procedure DispatchManyEvents(dwPid: LongWord; var appGuid: TGUID; dwEvents: LongWord;
                                cbSize: LongWord; var pBuf: Byte); safecall;
    procedure DispatchOneEvent(dwPid: LongWord; var appGuid: TGUID; cbSize: LongWord; var pBuf: Byte); safecall;
    procedure AddProcess(dwPid: LongWord; var guidApp: TGUID; out pdwInitialEventMask: LongWord;
                        out ppUnkCallfactory: IUnknown); safecall;
    procedure RemoveProcess(dwPid: LongWord); safecall;
    procedure GetCallFactoryObject(dwPid: LongWord; out ppUnkCallfactory: IUnknown); safecall;
  end;
  {$EXTERNALSYM IEventServer}

{ IProcessTerminateNotify }

  IProcessTerminateNotify = interface(IUnknown)
    ['{3194B4CF-EF32-11D1-93AE-00AA00BA3258}']
    procedure ProcessShutdown(dwPid: LongWord); stdcall;
  end;
  {$EXTERNALSYM IProcessTerminateNotify}

implementation

end.

