{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

Unit Winapi.MsCTF;

{ TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{ WARN SYMBOL_PLATFORM OFF}
{ WRITEABLECONST ON}
{ VARPROPSETTER ON}
{$ALIGN 4}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include <msctf.h>'}
{$HPPEMIT '#include <inputscope.h>'}
{$HPPEMIT ''}

interface

uses
  Winapi.Windows, Winapi.ActiveX;

// Text Framework declarations.

const
  TF_E_LOCKED          = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or  $0500);
  {$EXTERNALSYM TF_E_LOCKED}
  TF_E_STACKFULL       = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0501);
  {$EXTERNALSYM TF_E_STACKFULL}
  TF_E_NOTOWNEDRANGE   = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0502);
  {$EXTERNALSYM TF_E_NOTOWNEDRANGE}
  TF_E_NOPROVIDER      = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0503);
  {$EXTERNALSYM TF_E_NOPROVIDER}
  TF_E_DISCONNECTED    = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0504);
  {$EXTERNALSYM TF_E_DISCONNECTED}
  TF_E_INVALIDVIEW     = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0505);
  {$EXTERNALSYM TF_E_INVALIDVIEW}
  TF_E_ALREADY_EXISTS  = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0506);
  {$EXTERNALSYM TF_E_ALREADY_EXISTS}
  TF_E_RANGE_NOT_COVERED = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0507);
  {$EXTERNALSYM TF_E_RANGE_NOT_COVERED}
  TF_E_COMPOSITION_REJECTED = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0508);
  {$EXTERNALSYM TF_E_COMPOSITION_REJECTED}
  TF_E_EMPTYCONTEXT    = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0509);
  {$EXTERNALSYM TF_E_EMPTYCONTEXT}
  TF_E_INVALIDPOS      = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0200);
  {$EXTERNALSYM TF_E_INVALIDPOS}
  TF_E_NOLOCK          = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0201);
  {$EXTERNALSYM TF_E_NOLOCK}
  TF_E_NOOBJECT        = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0202);
  {$EXTERNALSYM TF_E_NOOBJECT}
  TF_E_NOSERVICE       = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0203);
  {$EXTERNALSYM TF_E_NOSERVICE}
  TF_E_NOINTERFACE     = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0204);
  {$EXTERNALSYM TF_E_NOINTERFACE}
  TF_E_NOSELECTION     = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0205);
  {$EXTERNALSYM TF_E_NOSELECTION}
  TF_E_NOLAYOUT        = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0206);
  {$EXTERNALSYM TF_E_NOLAYOUT}
  TF_E_INVALIDPOINT    = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0207);
  {$EXTERNALSYM TF_E_INVALIDPOINT}
  TF_E_SYNCHRONOUS     = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0208);
  {$EXTERNALSYM TF_E_SYNCHRONOUS}
  TF_E_READONLY        = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $0209);
  {$EXTERNALSYM TF_E_READONLY}
  TF_E_FORMAT          = HRESULT((SEVERITY_ERROR shL 31) or (FACILITY_ITF shl 16) or $020a);
  {$EXTERNALSYM TF_E_FORMAT}
  TF_S_ASYNC           = HRESULT((SEVERITY_SUCCESS shl 31) or (FACILITY_ITF shl 16) or $0300);
  {$EXTERNALSYM TF_S_ASYNC}

  TF_RCM_COMLESS             = $00000001;
  {$EXTERNALSYM TF_RCM_COMLESS}
  TF_RCM_VKEY                = $00000002;
  {$EXTERNALSYM TF_RCM_VKEY}
  TF_RCM_HINT_READING_LENGTH = $00000004;
  {$EXTERNALSYM TF_RCM_HINT_READING_LENGTH}
  TF_RCM_HINT_COLLISION      = $00000008;
  {$EXTERNALSYM TF_RCM_HINT_COLLISION}

  TF_INVALID_EDIT_COOKIE	= 0;
  {$EXTERNALSYM TF_INVALID_EDIT_COOKIE}

  TKB_ALTERNATES_STANDARD               = $00000001;
  {$EXTERNALSYM TKB_ALTERNATES_STANDARD}
  TKB_ALTERNATES_FOR_AUTOCORRECTION     = $00000002;
  {$EXTERNALSYM TKB_ALTERNATES_FOR_AUTOCORRECTION}
  TKB_ALTERNATES_FOR_PREDICTION         = $00000003;
  {$EXTERNALSYM TKB_ALTERNATES_FOR_PREDICTION}
  TKB_ALTERNATES_AUTOCORRECTION_APPLIED = $00000004;
  {$EXTERNALSYM TKB_ALTERNATES_AUTOCORRECTION_APPLIED}

  TF_INVALID_GUIDATOM = 0; //TfGuidAtom(0);
  {$EXTERNALSYM TF_INVALID_GUIDATOM}
  TF_CLIENTID_NULL    = 0; //TfClientId(0);
  {$EXTERNALSYM TF_CLIENTID_NULL}

  TF_TMAE_NOACTIVATETIP              = $00000001;
  {$EXTERNALSYM TF_TMAE_NOACTIVATETIP}
  TF_TMAE_SECUREMODE                 = $00000002;
  {$EXTERNALSYM TF_TMAE_SECUREMODE}
  TF_TMAE_UIELEMENTENABLEDONLY       = $00000004;
  {$EXTERNALSYM TF_TMAE_UIELEMENTENABLEDONLY}
  TF_TMAE_COMLESS                    = $00000008;
  {$EXTERNALSYM TF_TMAE_COMLESS}
  TF_TMAE_WOW16                      = $00000010;
  {$EXTERNALSYM TF_TMAE_WOW16}
  TF_TMAE_NOACTIVATEKEYBOARDLAYOUT   = $00000020;
  {$EXTERNALSYM TF_TMAE_NOACTIVATEKEYBOARDLAYOUT}
  TF_TMAE_CONSOLE                    = $00000040;
  {$EXTERNALSYM TF_TMAE_CONSOLE}

  TF_TMF_NOACTIVATETIP          = TF_TMAE_NOACTIVATETIP;
  {$EXTERNALSYM TF_TMF_NOACTIVATETIP}
  TF_TMF_SECUREMODE             = TF_TMAE_SECUREMODE;
  {$EXTERNALSYM TF_TMF_SECUREMODE}
  TF_TMF_UIELEMENTENABLEDONLY   = TF_TMAE_UIELEMENTENABLEDONLY;
  {$EXTERNALSYM TF_TMF_UIELEMENTENABLEDONLY}
  TF_TMF_COMLESS                = TF_TMAE_COMLESS;
  {$EXTERNALSYM TF_TMF_COMLESS}
  TF_TMF_WOW16                  = TF_TMAE_WOW16;
  {$EXTERNALSYM TF_TMF_WOW16}
  TF_TMF_CONSOLE                = TF_TMAE_CONSOLE;
  {$EXTERNALSYM TF_TMF_CONSOLE}
  TF_TMF_IMMERSIVEMODE          = $40000000;
  {$EXTERNALSYM TF_TMF_IMMERSIVEMODE}
  TF_TMF_ACTIVATED              = $80000000;
  {$EXTERNALSYM TF_TMF_ACTIVATED}

  TF_MOD_ALT                         = $0001;
  {$EXTERNALSYM TF_MOD_ALT}
  TF_MOD_CONTROL                     = $0002;
  {$EXTERNALSYM TF_MOD_CONTROL}
  TF_MOD_SHIFT                       = $0004;
  {$EXTERNALSYM TF_MOD_SHIFT}
  TF_MOD_RALT                        = $0008;
  {$EXTERNALSYM TF_MOD_RALT}
  TF_MOD_RCONTROL                    = $0010;
  {$EXTERNALSYM TF_MOD_RCONTROL}
  TF_MOD_RSHIFT                      = $0020;
  {$EXTERNALSYM TF_MOD_RSHIFT}
  TF_MOD_LALT                        = $0040;
  {$EXTERNALSYM TF_MOD_LALT}
  TF_MOD_LCONTROL                    = $0080;
  {$EXTERNALSYM TF_MOD_LCONTROL}
  TF_MOD_LSHIFT                      = $0100;
  {$EXTERNALSYM TF_MOD_LSHIFT}
  TF_MOD_ON_KEYUP                    = $0200;
  {$EXTERNALSYM TF_MOD_ON_KEYUP}
  TF_MOD_IGNORE_ALL_MODIFIER         = $0400;
  {$EXTERNALSYM TF_MOD_IGNORE_ALL_MODIFIER}

  TF_US_HIDETIPUI = $00000001;
  {$EXTERNALSYM TF_US_HIDETIPUI}

  TF_DISABLE_SPEECH         = $00000001;
  {$EXTERNALSYM TF_DISABLE_SPEECH}
  TF_DISABLE_DICTATION      = $00000002;
  {$EXTERNALSYM TF_DISABLE_DICTATION}
  TF_DISABLE_COMMANDING     = $00000004;
  {$EXTERNALSYM TF_DISABLE_COMMANDING}

  TF_PROCESS_ATOM             = '_CTF_PROCESS_ATOM_';
  {$EXTERNALSYM TF_PROCESS_ATOM}
  TF_ENABLE_PROCESS_ATOM      = '_CTF_ENABLE_PROCESS_ATOM_';
  {$EXTERNALSYM TF_ENABLE_PROCESS_ATOM}
  TF_INVALID_UIELEMENTID    = DWORD(-1);
  {$EXTERNALSYM TF_INVALID_UIELEMENTID}
  TF_CLUIE_DOCUMENTMGR      = $00000001;
  {$EXTERNALSYM TF_CLUIE_DOCUMENTMGR}
  TF_CLUIE_COUNT            = $00000002;
  {$EXTERNALSYM TF_CLUIE_COUNT}
  TF_CLUIE_SELECTION        = $00000004;
  {$EXTERNALSYM TF_CLUIE_SELECTION}
  TF_CLUIE_STRING           = $00000008;
  {$EXTERNALSYM TF_CLUIE_STRING}
  TF_CLUIE_PAGEINDEX        = $00000010;
  {$EXTERNALSYM TF_CLUIE_PAGEINDEX}
  TF_CLUIE_CURRENTPAGE      = $00000020;
  {$EXTERNALSYM TF_CLUIE_CURRENTPAGE}
  TF_RIUIE_CONTEXT                 = $00000001;
  {$EXTERNALSYM TF_RIUIE_CONTEXT}
  TF_RIUIE_STRING                  = $00000002;
  {$EXTERNALSYM TF_RIUIE_STRING}
  TF_RIUIE_MAXREADINGSTRINGLENGTH  = $00000004;
  {$EXTERNALSYM TF_RIUIE_MAXREADINGSTRINGLENGTH}
  TF_RIUIE_ERRORINDEX              = $00000008;
  {$EXTERNALSYM TF_RIUIE_ERRORINDEX}
  TF_RIUIE_VERTICALORDER           = $00000010;
  {$EXTERNALSYM TF_RIUIE_VERTICALORDER}
  TF_CONVERSIONMODE_ALPHANUMERIC        = $0000;
  {$EXTERNALSYM TF_CONVERSIONMODE_ALPHANUMERIC}
  TF_CONVERSIONMODE_NATIVE              = $0001;
  {$EXTERNALSYM TF_CONVERSIONMODE_NATIVE}
  TF_CONVERSIONMODE_KATAKANA            = $0002;
  {$EXTERNALSYM TF_CONVERSIONMODE_KATAKANA}
  TF_CONVERSIONMODE_FULLSHAPE           = $0008;
  {$EXTERNALSYM TF_CONVERSIONMODE_FULLSHAPE}
  TF_CONVERSIONMODE_ROMAN               = $0010;
  {$EXTERNALSYM TF_CONVERSIONMODE_ROMAN}
  TF_CONVERSIONMODE_CHARCODE            = $0020;
  {$EXTERNALSYM TF_CONVERSIONMODE_CHARCODE}
  TF_CONVERSIONMODE_SOFTKEYBOARD        = $0080;
  {$EXTERNALSYM TF_CONVERSIONMODE_SOFTKEYBOARD}
  TF_CONVERSIONMODE_NOCONVERSION        = $0100;
  {$EXTERNALSYM TF_CONVERSIONMODE_NOCONVERSION}
  TF_CONVERSIONMODE_EUDC                = $0200;
  {$EXTERNALSYM TF_CONVERSIONMODE_EUDC}
  TF_CONVERSIONMODE_SYMBOL              = $0400;
  {$EXTERNALSYM TF_CONVERSIONMODE_SYMBOL}
  TF_CONVERSIONMODE_FIXED               = $0800;
  {$EXTERNALSYM TF_CONVERSIONMODE_FIXED}
  TF_SENTENCEMODE_NONE                  = $0000;
  {$EXTERNALSYM TF_SENTENCEMODE_NONE}
  TF_SENTENCEMODE_PLAURALCLAUSE         = $0001;
  {$EXTERNALSYM TF_SENTENCEMODE_PLAURALCLAUSE}
  TF_SENTENCEMODE_SINGLECONVERT         = $0002;
  {$EXTERNALSYM TF_SENTENCEMODE_SINGLECONVERT}
  TF_SENTENCEMODE_AUTOMATIC             = $0004;
  {$EXTERNALSYM TF_SENTENCEMODE_AUTOMATIC}
  TF_SENTENCEMODE_PHRASEPREDICT         = $0008;
  {$EXTERNALSYM TF_SENTENCEMODE_PHRASEPREDICT}
  TF_SENTENCEMODE_CONVERSATION          = $0010;
  {$EXTERNALSYM TF_SENTENCEMODE_CONVERSATION}

  TF_TRANSITORYEXTENSION_NONE           = $0000;
  {$EXTERNALSYM TF_TRANSITORYEXTENSION_NONE}
  TF_TRANSITORYEXTENSION_FLOATING       = $0001;
  {$EXTERNALSYM TF_TRANSITORYEXTENSION_FLOATING}
  TF_TRANSITORYEXTENSION_ATSELECTION    = $0002;
  {$EXTERNALSYM TF_TRANSITORYEXTENSION_ATSELECTION}

  TF_PROFILETYPE_INPUTPROCESSOR         = $0001;
  {$EXTERNALSYM TF_PROFILETYPE_INPUTPROCESSOR}
  TF_PROFILETYPE_KEYBOARDLAYOUT         = $0002;
  {$EXTERNALSYM TF_PROFILETYPE_KEYBOARDLAYOUT}
  TF_RIP_FLAG_FREEUNUSEDLIBRARIES         = $00000001;
  {$EXTERNALSYM TF_RIP_FLAG_FREEUNUSEDLIBRARIES}
  TF_IPP_FLAG_ACTIVE                      = $00000001;
  {$EXTERNALSYM TF_IPP_FLAG_ACTIVE}
  TF_IPP_FLAG_ENABLED                     = $00000002;
  {$EXTERNALSYM TF_IPP_FLAG_ENABLED}
  TF_IPP_FLAG_SUBSTITUTEDBYINPUTPROCESSOR = $00000004;
  {$EXTERNALSYM TF_IPP_FLAG_SUBSTITUTEDBYINPUTPROCESSOR}
  TF_IPP_CAPS_DISABLEONTRANSITORY         = $00000001;
  {$EXTERNALSYM TF_IPP_CAPS_DISABLEONTRANSITORY}
  TF_IPP_CAPS_SECUREMODESUPPORT           = $00000002;
  {$EXTERNALSYM TF_IPP_CAPS_SECUREMODESUPPORT}
  TF_IPP_CAPS_UIELEMENTENABLED            = $00000004;
  {$EXTERNALSYM TF_IPP_CAPS_UIELEMENTENABLED}
  TF_IPP_CAPS_COMLESSSUPPORT              = $00000008;
  {$EXTERNALSYM TF_IPP_CAPS_COMLESSSUPPORT}
  TF_IPP_CAPS_WOW16SUPPORT                = $00000010;
  {$EXTERNALSYM TF_IPP_CAPS_WOW16SUPPORT}
  TF_IPP_CAPS_IMMERSIVESUPPORT            = $00010000;
  {$EXTERNALSYM TF_IPP_CAPS_IMMERSIVESUPPORT}
  TF_IPP_CAPS_SYSTRAYSUPPORT              = $00020000;
  {$EXTERNALSYM TF_IPP_CAPS_SYSTRAYSUPPORT}
  TF_IPPMF_FORPROCESS                     = $10000000;
  {$EXTERNALSYM TF_IPPMF_FORPROCESS}
  TF_IPPMF_FORSESSION                     = $20000000;
  {$EXTERNALSYM TF_IPPMF_FORSESSION}
  TF_IPPMF_FORSYSTEMALL                   = $40000000;
  {$EXTERNALSYM TF_IPPMF_FORSYSTEMALL}
  TF_IPPMF_ENABLEPROFILE                  = $00000001;
  {$EXTERNALSYM TF_IPPMF_ENABLEPROFILE}
  TF_IPPMF_DISABLEPROFILE                 = $00000002;
  {$EXTERNALSYM TF_IPPMF_DISABLEPROFILE}
  TF_IPPMF_DONTCARECURRENTINPUTLANGUAGE   = $00000004;
  {$EXTERNALSYM TF_IPPMF_DONTCARECURRENTINPUTLANGUAGE}
  TF_RP_HIDDENINSETTINGUI                 = $00000002;
  {$EXTERNALSYM TF_RP_HIDDENINSETTINGUI}
  TF_RP_LOCALPROCESS                      = $00000004;
  {$EXTERNALSYM TF_RP_LOCALPROCESS}
  TF_RP_LOCALTHREAD                       = $00000008;
  {$EXTERNALSYM TF_RP_LOCALTHREAD}
  TF_RP_SUBITEMINSETTINGUI                = $00000010;
  {$EXTERNALSYM TF_RP_SUBITEMINSETTINGUI}
  TF_URP_ALLPROFILES                      = $00000002;
  {$EXTERNALSYM TF_URP_ALLPROFILES}
  TF_URP_LOCALPROCESS                     = $00000004;
  {$EXTERNALSYM TF_URP_LOCALPROCESS}
  TF_URP_LOCALTHREAD                      = $00000008;
  {$EXTERNALSYM TF_URP_LOCALTHREAD}
  TF_IPSINK_FLAG_ACTIVE                   = $0001;
  {$EXTERNALSYM TF_IPSINK_FLAG_ACTIVE}

//============================================================================================================================

// ************************************************************************  //
// Errors:
//   Hint: Symbol 'type' renamed to 'type_'
// Cmdline:
//   tlibimp   -P -Hs- -Hr- -Fe- msctf.tlb
// ************************************************************************ //

const
  IID_ITfThreadMgrEventSink: TGUID = '{AA80E80E-2021-11D2-93E0-0060B067B86E}';
  IID_ITfDocumentMgr: TGUID = '{AA80E7F4-2021-11D2-93E0-0060B067B86E}';
  IID_ITfContext: TGUID = '{AA80E7FD-2021-11D2-93E0-0060B067B86E}';
  IID_ITfEditSession: TGUID = '{AA80E803-2021-11D2-93E0-0060B067B86E}';
  IID_ITfRange: TGUID = '{AA80E7FF-2021-11D2-93E0-0060B067B86E}';
  IID_ISequentialStream: TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_ITfContextView: TGUID = '{2433BF8E-0F9B-435C-BA2C-180611978C30}';
  IID_IEnumTfContextViews: TGUID = '{F0C0F8DD-CF38-44E1-BB0F-68CF0D551C78}';
  IID_ITfReadOnlyProperty: TGUID = '{17D49A3D-F8B8-4B2F-B254-52319DD64C53}';
  IID_ITfProperty: TGUID = '{E2449660-9542-11D2-BF46-00105A2799B5}';
  IID_IEnumTfRanges: TGUID = '{F99D3F40-8E32-11D2-BF46-00105A2799B5}';
  IID_ITfPropertyStore: TGUID = '{6834B120-88CB-11D2-BF45-00105A2799B5}';
  IID_IEnumTfProperties: TGUID = '{19188CB0-ACA9-11D2-AFC5-00105A2799B5}';
  IID_ITfRangeBackup: TGUID = '{463A506D-6992-49D2-9B88-93D55E70BB16}';
  IID_IEnumTfContexts: TGUID = '{8F1A7EA6-1654-4502-A86E-B2902344D507}';
  IID_ITfTextInputProcessor: TGUID = '{AA80E7F7-2021-11D2-93E0-0060B067B86E}';
  IID_ITfThreadMgr: TGUID = '{AA80E801-2021-11D2-93E0-0060B067B86E}';
  IID_IEnumTfDocumentMgrs: TGUID = '{AA80E808-2021-11D2-93E0-0060B067B86E}';
  IID_ITfFunctionProvider: TGUID = '{101D6610-0990-11D3-8DF0-00105A2799B5}';
  IID_IEnumTfFunctionProviders: TGUID = '{E4B24DB0-0990-11D3-8DF0-00105A2799B5}';
  IID_ITfCompartmentMgr: TGUID = '{7DCF57AC-18AD-438B-824D-979BFFB74B7C}';
  IID_ITfCompartment: TGUID = '{BB08F7A9-607A-4384-8623-056892B64371}';
  IID_ITfRangeACP: TGUID = '{057A6296-029B-4154-B79A-0D461D4EA94C}';
  IID_ITfPersistentPropertyLoaderACP: TGUID = '{4EF89150-0807-11D3-8DF0-00105A2799B5}';
  IID_ITfKeyEventSink: TGUID = '{AA80E7F5-2021-11D2-93E0-0060B067B86E}';
  IID_ITfSource: TGUID = '{4EA48A35-60AE-446F-8FD6-E6A8D82459F7}';
  IID_ITfMouseSink: TGUID = '{A1ADAAA2-3A24-449D-AC96-5183E7F5C217}';
  IID_IEnumTfLanguageProfiles: TGUID = '{3D61BF11-AC5F-42C8-A4CB-931BCC28C744}';
  IID_ITfUIElement: TGUID = '{EA1EA137-19DF-11D7-A6D2-00065B84435C}';
  IID_IEnumTfUIElements: TGUID = '{887AA91E-ACBA-4931-84DA-3C5208CF543F}';
  IID_IEnumTfInputProcessorProfiles: TGUID = '{71C6E74D-0F28-11D8-A82A-00065B84435C}';
  IID_ITfThreadMgrEx: TGUID = '{3E90ADE3-7594-4CB0-BB58-69628F5F458C}';
  IID_ITfThreadMgr2: TGUID = '{0AB198EF-6477-4EE8-8812-6780EDB82D5E}';
  IID_ITfConfigureSystemKeystrokeFeed: TGUID = '{0D2C969A-BC9C-437C-84EE-951C49B1A764}';
  IID_ITfCompositionView: TGUID = '{D7540241-F9A1-4364-BEFC-DBCD2C4395B7}';
  IID_IEnumITfCompositionView: TGUID = '{5EFD22BA-7838-46CB-88E2-CADB14124F8F}';
  IID_ITfComposition: TGUID = '{20168D64-5A8F-4A5A-B7BD-CFA29F4D0FD9}';
  IID_ITfCompositionSink: TGUID = '{A781718C-579A-4B15-A280-32B8577ACC5E}';
  IID_ITfContextComposition: TGUID = '{D40C8AAE-AC92-4FC7-9A11-0EE0E23AA39B}';
  IID_ITfContextOwnerCompositionServices: TGUID = '{86462810-593B-4916-9764-19C08E9CE110}';
  IID_ITfContextOwnerCompositionSink: TGUID = '{5F20AA40-B57A-4F34-96AB-3576F377CC79}';
  IID_ITfQueryEmbedded: TGUID = '{0FAB9BDB-D250-4169-84E5-6BE118FDD7A8}';
  IID_ITfInsertAtSelection: TGUID = '{55CE16BA-3014-41C1-9CEB-FADE1446AC6C}';
  IID_ITfCleanupContextSink: TGUID = '{01689689-7ACB-4E9B-AB7C-7EA46B12B522}';
  IID_ITfCleanupContextDurationSink: TGUID = '{45C35144-154E-4797-BED8-D33AE7BF8794}';
  IID_IEnumTfPropertyValue: TGUID = '{8ED8981B-7C10-4D7D-9FB3-AB72E9C75F72}';
  IID_ITfMouseTracker: TGUID = '{09D146CD-A544-4132-925B-7AFA8EF322D0}';
  IID_ITfMouseTrackerACP: TGUID = '{3BDD78E2-C16E-47FD-B883-CE6FACC1A208}';
  IID_ITfEditRecord: TGUID = '{42D4D099-7C1A-4A89-B836-6C6F22160DF0}';
  IID_ITfTextEditSink: TGUID = '{8127D409-CCD3-4683-967A-B43D5B482BF7}';
  IID_ITfTextLayoutSink: TGUID = '{2AF2D06A-DD5B-4927-A0B4-54F19C91FADE}';
  IID_ITfStatusSink: TGUID = '{6B7D8D73-B267-4F69-B32E-1CA321CE4F45}';
  IID_ITfEditTransactionSink: TGUID = '{708FBF70-B520-416B-B06C-2C41AB44F8BA}';
  IID_ITfContextOwner: TGUID = '{AA80E80C-2021-11D2-93E0-0060B067B86E}';
  IID_ITfContextOwnerServices: TGUID = '{B23EB630-3E1C-11D3-A745-0050040AB407}';
  IID_ITfContextKeyEventSink: TGUID = '{0552BA5D-C835-4934-BF50-846AAA67432F}';
  IID_ITextStoreACPServices: TGUID = '{AA80E901-2021-11D2-93E0-0060B067B86E}';
  IID_ITfCreatePropertyStore: TGUID = '{2463FBF0-B0AF-11D2-AFC5-00105A2799B5}';
  IID_ITfCompartmentEventSink: TGUID = '{743ABD5F-F26D-48DF-8CC5-238492419B64}';
  IID_ITfFunction: TGUID = '{DB593490-098F-11D3-8DF0-00105A2799B5}';
  IID_ITfInputProcessorProfiles: TGUID = '{1F02B6C5-7842-4EE6-8A0B-9A24183A95CA}';
  IID_ITfInputProcessorProfilesEx: TGUID = '{892F230F-FE00-4A41-A98E-FCD6DE0D35EF}';
  IID_ITfInputProcessorProfileSubstituteLayout: TGUID = '{4FD67194-1002-4513-BFF2-C0DDF6258552}';
  IID_ITfActiveLanguageProfileNotifySink: TGUID = '{B246CB75-A93E-4652-BF8C-B3FE0CFD7E57}';
  IID_ITfLanguageProfileNotifySink: TGUID = '{43C9FE15-F494-4C17-9DE2-B8A4AC350AA8}';
  IID_ITfInputProcessorProfileMgr: TGUID = '{71C6E74C-0F28-11D8-A82A-00065B84435C}';
  IID_ITfInputProcessorProfileActivationSink: TGUID = '{71C6E74E-0F28-11D8-A82A-00065B84435C}';
  IID_ITfKeystrokeMgr: TGUID = '{AA80E7F0-2021-11D2-93E0-0060B067B86E}';
  IID_ITfKeyTraceEventSink: TGUID = '{1CD4C13B-1C36-4191-A70A-7F3E611F367D}';
  IID_ITfPreservedKeyNotifySink: TGUID = '{6F77C993-D2B1-446E-853E-5912EFC8A286}';
  IID_ITfMessagePump: TGUID = '{8F1B8AD8-0B6B-4874-90C5-BD76011E8F7C}';
  IID_ITfThreadFocusSink: TGUID = '{C0F1DB0C-3A20-405C-A303-96B6010A885F}';
  IID_ITfTextInputProcessorEx: TGUID = '{6E4E2102-F9CD-433D-B496-303CE03A6507}';
  IID_ITfClientId: TGUID = '{D60A7B49-1B9F-4BE2-B702-47E9DC05DEC3}';
  IID_ITfDisplayAttributeInfo: TGUID = '{70528852-2F26-4AEA-8C96-215150578932}';
  IID_IEnumTfDisplayAttributeInfo: TGUID = '{7CEF04D7-CB75-4E80-A7AB-5F5BC7D332DE}';
  IID_ITfDisplayAttributeProvider: TGUID = '{FEE47777-163C-4769-996A-6E9C50AD8F54}';
  IID_ITfDisplayAttributeMgr: TGUID = '{8DED7393-5DB1-475C-9E71-A39111B0FF67}';
  IID_ITfDisplayAttributeNotifySink: TGUID = '{AD56F402-E162-4F25-908F-7D577CF9BDA9}';
  IID_ITfCategoryMgr: TGUID = '{C3ACEFB5-F69D-4905-938F-FCADCF4BE830}';
  IID_ITfSourceSingle: TGUID = '{73131F9C-56A9-49DD-B0EE-D046633F7528}';
  IID_ITfUIElementMgr: TGUID = '{EA1EA135-19DF-11D7-A6D2-00065B84435C}';
  IID_ITfUIElementSink: TGUID = '{EA1EA136-19DF-11D7-A6D2-00065B84435C}';
  IID_ITfCandidateListUIElement: TGUID = '{EA1EA138-19DF-11D7-A6D2-00065B84435C}';
  IID_ITfCandidateListUIElementBehavior: TGUID = '{85FAD185-58CE-497A-9460-355366B64B9A}';
  IID_ITfReadingInformationUIElement: TGUID = '{EA1EA139-19DF-11D7-A6D2-00065B84435C}';
  IID_ITfTransitoryExtensionUIElement: TGUID = '{858F956A-972F-42A2-A2F2-0321E1ABE209}';
  IID_ITfTransitoryExtensionSink: TGUID = '{A615096F-1C57-4813-8A15-55EE6E5A839C}';
  IID_ITfToolTipUIElement: TGUID = '{52B18B5C-555D-46B2-B00A-FA680144FBDB}';
  IID_ITfReverseConversionList: TGUID = '{151D69F0-86F4-4674-B721-56911E797F47}';
  IID_ITfReverseConversion: TGUID = '{A415E162-157D-417D-8A8C-0AB26C7D2781}';
  IID_ITfReverseConversionMgr: TGUID = '{B643C236-C493-41B6-ABB3-692412775CC4}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//

type
  TfActiveSelEnd = (
    TF_AE_NONE = $00000000,
    TF_AE_START = $00000001,
    TF_AE_END = $00000002
  );
  {$EXTERNALSYM TfActiveSelEnd}

  TfAnchor = (
    TF_ANCHOR_START = $00000000,
    TF_ANCHOR_END = $00000001
  );
  {$EXTERNALSYM TfAnchor}

  TfShiftDir = (
    TF_SD_BACKWARD = $00000000,
    TF_SD_FORWARD = $00000001
  );
  {$EXTERNALSYM TfShiftDir}

  TfGravity = (
    TF_GRAVITY_BACKWARD = $00000000,
    TF_GRAVITY_FORWARD = $00000001
  );
  {$EXTERNALSYM TfGravity}

  TfLayoutCode = (
    TF_LC_CREATE = $00000000,
    TF_LC_CHANGE = $00000001,
    TF_LC_DESTROY = $00000002
  );
  {$EXTERNALSYM TfLayoutCode}

  TF_DA_LINESTYLE = (
    TF_LS_NONE = $00000000,
    TF_LS_SOLID = $00000001,
    TF_LS_DOT = $00000002,
    TF_LS_DASH = $00000003,
    TF_LS_SQUIGGLE = $00000004
  );
  {$EXTERNALSYM TF_DA_LINESTYLE}

  TF_DA_COLORTYPE = (
    TF_CT_NONE = $00000000,
    TF_CT_SYSCOLOR = $00000001,
    TF_CT_COLORREF = $00000002
  );
  {$EXTERNALSYM TF_DA_COLORTYPE}

  TF_DA_ATTR_INFO = (
    TF_ATTR_INPUT = $00000000,
    TF_ATTR_TARGET_CONVERTED = $00000001,
    TF_ATTR_CONVERTED = $00000002,
    TF_ATTR_TARGET_NOTCONVERTED = $00000003,
    TF_ATTR_INPUT_ERROR = $00000004,
    TF_ATTR_FIXEDCONVERTED = $00000005,
    TF_ATTR_OTHER = -1 // $FFFFFFFF
  );
  {$EXTERNALSYM TF_DA_ATTR_INFO}

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ITfThreadMgrEventSink = interface;
  ITfDocumentMgr = interface;
  ITfContext = interface;
  ITfEditSession = interface;
  ITfRange = interface;
  ISequentialStream = interface;
  ITfContextView = interface;
  IEnumTfContextViews = interface;
  ITfReadOnlyProperty = interface;
  ITfProperty = interface;
  IEnumTfRanges = interface;
  ITfPropertyStore = interface;
  IEnumTfProperties = interface;
  ITfRangeBackup = interface;
  IEnumTfContexts = interface;
  ITfTextInputProcessor = interface;
  ITfThreadMgr = interface;
  IEnumTfDocumentMgrs = interface;
  ITfFunctionProvider = interface;
  IEnumTfFunctionProviders = interface;
  ITfCompartmentMgr = interface;
  ITfCompartment = interface;
  ITfRangeACP = interface;
  ITfPersistentPropertyLoaderACP = interface;
  ITfKeyEventSink = interface;
  ITfSource = interface;
  ITfMouseSink = interface;
  IEnumTfLanguageProfiles = interface;
  ITfUIElement = interface;
  IEnumTfUIElements = interface;
  IEnumTfInputProcessorProfiles = interface;
  ITfThreadMgrEx = interface;
  ITfThreadMgr2 = interface;
  ITfConfigureSystemKeystrokeFeed = interface;
  ITfCompositionView = interface;
  IEnumITfCompositionView = interface;
  ITfComposition = interface;
  ITfCompositionSink = interface;
  ITfContextComposition = interface;
  ITfContextOwnerCompositionServices = interface;
  ITfContextOwnerCompositionSink = interface;
  ITfQueryEmbedded = interface;
  ITfInsertAtSelection = interface;
  ITfCleanupContextSink = interface;
  ITfCleanupContextDurationSink = interface;
  IEnumTfPropertyValue = interface;
  ITfMouseTracker = interface;
  ITfMouseTrackerACP = interface;
  ITfEditRecord = interface;
  ITfTextEditSink = interface;
  ITfTextLayoutSink = interface;
  ITfStatusSink = interface;
  ITfEditTransactionSink = interface;
  ITfContextOwner = interface;
  ITfContextOwnerServices = interface;
  ITfContextKeyEventSink = interface;
  ITextStoreACPServices = interface;
  ITfCreatePropertyStore = interface;
  ITfCompartmentEventSink = interface;
  ITfFunction = interface;
  ITfInputProcessorProfiles = interface;
  ITfInputProcessorProfilesEx = interface;
  ITfInputProcessorProfileSubstituteLayout = interface;
  ITfActiveLanguageProfileNotifySink = interface;
  ITfLanguageProfileNotifySink = interface;
  ITfInputProcessorProfileMgr = interface;
  ITfInputProcessorProfileActivationSink = interface;
  ITfKeystrokeMgr = interface;
  ITfKeyTraceEventSink = interface;
  ITfPreservedKeyNotifySink = interface;
  ITfMessagePump = interface;
  ITfThreadFocusSink = interface;
  ITfTextInputProcessorEx = interface;
  ITfClientId = interface;
  ITfDisplayAttributeInfo = interface;
  IEnumTfDisplayAttributeInfo = interface;
  ITfDisplayAttributeProvider = interface;
  ITfDisplayAttributeMgr = interface;
  ITfDisplayAttributeNotifySink = interface;
  ITfCategoryMgr = interface;
  ITfSourceSingle = interface;
  ITfUIElementMgr = interface;
  ITfUIElementSink = interface;
  ITfCandidateListUIElement = interface;
  ITfCandidateListUIElementBehavior = interface;
  ITfReadingInformationUIElement = interface;
  ITfTransitoryExtensionUIElement = interface;
  ITfTransitoryExtensionSink = interface;
  ITfToolTipUIElement = interface;
  ITfReverseConversionList = interface;
  ITfReverseConversion = interface;
  ITfReverseConversionMgr = interface;

// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//

  PPGUID = ^PGUID;
  PPWord = ^PWord;

  TfClientId = LongWord;
  {$EXTERNALSYM TfClientId}
  TfEditCookie = LongWord;
  {$EXTERNALSYM TfEditCookie}

  TF_HALTCOND = record
    pHaltRange: ITfRange;
    aHaltPos: TfAnchor;
    dwFlags: LongWord;
  end {$IFDEF CPUX64} align 8 {$ENDIF};
  {$EXTERNALSYM TF_HALTCOND}

  TF_SELECTIONSTYLE = record
    ase: TfActiveSelEnd;
    fInterimChar: Integer;
  end;
  {$EXTERNALSYM TF_SELECTIONSTYLE}

  TF_SELECTION = record
    range: ITfRange;
    style: TF_SELECTIONSTYLE;
  end {$IFDEF CPUX64} align 8 {$ENDIF};
  {$EXTERNALSYM TF_SELECTION}

  TS_STATUS = record
    dwDynamicFlags: LongWord;
    dwStaticFlags: LongWord;
  end;
  {$EXTERNALSYM TS_STATUS}

  TF_STATUS = TS_STATUS;
  {$EXTERNALSYM TF_STATUS}

  TF_PERSISTENT_PROPERTY_HEADER_ACP = record
    guidType: TGUID;
    ichStart: Integer;
    cch: Integer;
    cb: LongWord;
    dwPrivate: LongWord;
    clsidTIP: TGUID;
  end;
  {$EXTERNALSYM TF_PERSISTENT_PROPERTY_HEADER_ACP}

  TF_LANGUAGEPROFILE = record
    clsid: TGUID;
    langid: Word;
    catid: TGUID;
    fActive: Integer;
    guidProfile: TGUID;
  end;
  {$EXTERNALSYM TF_LANGUAGEPROFILE}

  TF_INPUTPROCESSORPROFILE = record
    dwProfileType: LongWord;
    langid: Word;
    clsid: TGUID;
    guidProfile: TGUID;
    catid: TGUID;
    hklSubstitute: HKL;
    dwCaps: LongWord;
    HKL: HKL;
    dwFlags: LongWord;
  end;
  {$EXTERNALSYM TF_INPUTPROCESSORPROFILE}

  TfGuidAtom = LongWord;
  {$EXTERNALSYM TfGuidAtom}

{$ALIGN 8}
  TF_PROPERTYVAL = record
    guidId: TGUID;
    varValue: OleVariant;
  end;
  {$EXTERNALSYM TF_PROPERTYVAL}

{$ALIGN 4}
  TF_PRESERVEDKEY = record
    uVKey: SYSUINT;
    uModifiers: SYSUINT;
  end;
  {$EXTERNALSYM TF_PRESERVEDKEY}

  TF_DA_COLOR = record
    type_: TF_DA_COLORTYPE;
    case Integer of
      0: (nIndex: SYSINT);
      1: (cr: TColorRef);
  end;
  {$EXTERNALSYM TF_DA_COLOR}

  TF_DISPLAYATTRIBUTE = record
    crText: TF_DA_COLOR;
    crBk: TF_DA_COLOR;
    lsStyle: TF_DA_LINESTYLE;
    fBoldLine: Integer;
    crLine: TF_DA_COLOR;
    bAttr: TF_DA_ATTR_INFO;
  end;
  {$EXTERNALSYM TF_DISPLAYATTRIBUTE}


// *********************************************************************//
// Interface: ITfThreadMgrEventSink
// Flags:     (0)
// GUID:      {AA80E80E-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfThreadMgrEventSink = interface(IUnknown)
    ['{AA80E80E-2021-11D2-93E0-0060B067B86E}']
    function OnInitDocumentMgr(const pdim: ITfDocumentMgr): HResult; stdcall;
    function OnUninitDocumentMgr(const pdim: ITfDocumentMgr): HResult; stdcall;
    function OnSetFocus(const pdimFocus: ITfDocumentMgr; const pdimPrevFocus: ITfDocumentMgr): HResult; stdcall;
    function OnPushContext(const pic: ITfContext): HResult; stdcall;
    function OnPopContext(const pic: ITfContext): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfThreadMgrEventSink}

// *********************************************************************//
// Interface: ITfDocumentMgr
// Flags:     (0)
// GUID:      {AA80E7F4-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfDocumentMgr = interface(IUnknown)
    ['{AA80E7F4-2021-11D2-93E0-0060B067B86E}']
    function CreateContext(tidOwner: TfClientId; dwFlags: LongWord; const punk: IUnknown;
                           out ppic: ITfContext; out pecTextStore: TfEditCookie): HResult; stdcall;
    function Push(const pic: ITfContext): HResult; stdcall;
    function Pop(dwFlags: LongWord): HResult; stdcall;
    function GetTop(out ppic: ITfContext): HResult; stdcall;
    function GetBase(out ppic: ITfContext): HResult; stdcall;
    function EnumContexts(out ppenum: IEnumTfContexts): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfDocumentMgr}

// *********************************************************************//
// Interface: ITfContext
// Flags:     (0)
// GUID:      {AA80E7FD-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfContext = interface(IUnknown)
    ['{AA80E7FD-2021-11D2-93E0-0060B067B86E}']
    function RequestEditSession(tid: TfClientId; const pes: ITfEditSession; dwFlags: LongWord;
                                out phrSession: HResult): HResult; stdcall;
    function InWriteSession(tid: TfClientId; out pfWriteSession: Integer): HResult; stdcall;
    function GetSelection(ec: TfEditCookie; ulIndex: LongWord; ulCount: LongWord;
                          out pSelection: TF_SELECTION; out pcFetched: LongWord): HResult; stdcall;
    function SetSelection(ec: TfEditCookie; ulCount: LongWord; var pSelection: TF_SELECTION): HResult; stdcall;
    function GetStart(ec: TfEditCookie; out ppStart: ITfRange): HResult; stdcall;
    function GetEnd(ec: TfEditCookie; out ppEnd: ITfRange): HResult; stdcall;
    function GetActiveView(out ppView: ITfContextView): HResult; stdcall;
    function EnumViews(out ppenum: IEnumTfContextViews): HResult; stdcall;
    function GetStatus(out pdcs: TF_STATUS): HResult; stdcall;
    function GetProperty(var guidProp: TGUID; out ppProp: ITfProperty): HResult; stdcall;
    function GetAppProperty(var guidProp: TGUID; out ppProp: ITfReadOnlyProperty): HResult; stdcall;
    function TrackProperties(prgProp: PPGUID; cProp: LongWord; prgAppProp: PPGUID;
                             cAppProp: LongWord; out ppProperty: ITfReadOnlyProperty): HResult; stdcall;
    function EnumProperties(out ppenum: IEnumTfProperties): HResult; stdcall;
    function GetDocumentMgr(out ppDm: ITfDocumentMgr): HResult; stdcall;
    function CreateRangeBackup(ec: TfEditCookie; const pRange: ITfRange;
                               out ppBackup: ITfRangeBackup): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContext}

// *********************************************************************//
// Interface: ITfEditSession
// Flags:     (0)
// GUID:      {AA80E803-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfEditSession = interface(IUnknown)
    ['{AA80E803-2021-11D2-93E0-0060B067B86E}']
    function DoEditSession(ec: TfEditCookie): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfEditSession}

// *********************************************************************//
// Interface: ITfRange
// Flags:     (0)
// GUID:      {AA80E7FF-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfRange = interface(IUnknown)
    ['{AA80E7FF-2021-11D2-93E0-0060B067B86E}']
// !! "out word" -> PWideChar
    function GetText(ec: TfEditCookie; dwFlags: LongWord; pchText: PWideChar; cchMax: LongWord;
                     out pcch: LongWord): HResult; stdcall;
// !! "var word" -> PWideChary
    function SetText(ec: TfEditCookie; dwFlags: LongWord; pchText: PWideChar; cch: Integer): HResult; stdcall;
    function GetFormattedText(ec: TfEditCookie; out ppDataObject: IDataObject): HResult; stdcall;
    function GetEmbedded(ec: TfEditCookie; var rguidService: TGUID; var riid: TGUID;
                         out ppunk: IUnknown): HResult; stdcall;
    function InsertEmbedded(ec: TfEditCookie; dwFlags: LongWord; const pDataObject: IDataObject): HResult; stdcall;
    function ShiftStart(ec: TfEditCookie; cchReq: Integer; out pcch: Integer; var pHalt: TF_HALTCOND): HResult; stdcall;
    function ShiftEnd(ec: TfEditCookie; cchReq: Integer; out pcch: Integer; var pHalt: TF_HALTCOND): HResult; stdcall;
    function ShiftStartToRange(ec: TfEditCookie; const pRange: ITfRange; aPos: TfAnchor): HResult; stdcall;
    function ShiftEndToRange(ec: TfEditCookie; const pRange: ITfRange; aPos: TfAnchor): HResult; stdcall;
    function ShiftStartRegion(ec: TfEditCookie; dir: TfShiftDir; out pfNoRegion: Integer): HResult; stdcall;
    function ShiftEndRegion(ec: TfEditCookie; dir: TfShiftDir; out pfNoRegion: Integer): HResult; stdcall;
    function IsEmpty(ec: TfEditCookie; out pfEmpty: Integer): HResult; stdcall;
    function Collapse(ec: TfEditCookie; aPos: TfAnchor): HResult; stdcall;
    function IsEqualStart(ec: TfEditCookie; const pWith: ITfRange; aPos: TfAnchor;
                          out pfEqual: Integer): HResult; stdcall;
    function IsEqualEnd(ec: TfEditCookie; const pWith: ITfRange; aPos: TfAnchor;
                        out pfEqual: Integer): HResult; stdcall;
    function CompareStart(ec: TfEditCookie; const pWith: ITfRange; aPos: TfAnchor;
                          out plResult: Integer): HResult; stdcall;
    function CompareEnd(ec: TfEditCookie; const pWith: ITfRange; aPos: TfAnchor;
                        out plResult: Integer): HResult; stdcall;
    function AdjustForInsert(ec: TfEditCookie; cchInsert: LongWord; out pfInsertOk: Integer): HResult; stdcall;
    function GetGravity(out pgStart: TfGravity; out pgEnd: TfGravity): HResult; stdcall;
    function SetGravity(ec: TfEditCookie; gStart: TfGravity; gEnd: TfGravity): HResult; stdcall;
    function Clone(out ppClone: ITfRange): HResult; stdcall;
    function GetContext(out ppContext: ITfContext): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfRange}

// *********************************************************************//
// Interface: ISequentialStream
// Flags:     (0)
// GUID:      {0C733A30-2A1C-11CE-ADE5-00AA0044773D}
// *********************************************************************//
  ISequentialStream = interface(IUnknown)
    ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    function RemoteRead(out pv: Byte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
    function RemoteWrite(var pv: Byte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ISequentialStream}

// *********************************************************************//
// Interface: ITfContextView
// Flags:     (0)
// GUID:      {2433BF8E-0F9B-435C-BA2C-180611978C30}
// *********************************************************************//
  ITfContextView = interface(IUnknown)
    ['{2433BF8E-0F9B-435C-BA2C-180611978C30}']
    function GetRangeFromPoint(ec: TfEditCookie; var ppt: TPoint; dwFlags: LongWord;
                               out ppRange: ITfRange): HResult; stdcall;
    function GetTextExt(ec: TfEditCookie; const pRange: ITfRange; out prc: TRect;
                        out pfClipped: Integer): HResult; stdcall;
    function GetScreenExt(out prc: TRect): HResult; stdcall;
// !! "out wireHWND" -> "out HWND"
    function GetWnd(out phwnd: HWND): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContextView}

// *********************************************************************//
// Interface: IEnumTfContextViews
// Flags:     (0)
// GUID:      {F0C0F8DD-CF38-44E1-BB0F-68CF0D551C78}
// *********************************************************************//
  IEnumTfContextViews = interface(IUnknown)
    ['{F0C0F8DD-CF38-44E1-BB0F-68CF0D551C78}']
    function Clone(out ppenum: IEnumTfContextViews): HResult; stdcall;
    function Next(ulCount: LongWord; out rgViews: ITfContextView; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfContextViews}

// *********************************************************************//
// Interface: ITfReadOnlyProperty
// Flags:     (0)
// GUID:      {17D49A3D-F8B8-4B2F-B254-52319DD64C53}
// *********************************************************************//
  ITfReadOnlyProperty = interface(IUnknown)
    ['{17D49A3D-F8B8-4B2F-B254-52319DD64C53}']
    function GetType(out pguid: TGUID): HResult; stdcall;
    function EnumRanges(ec: TfEditCookie; out ppenum: IEnumTfRanges; const pTargetRange: ITfRange): HResult; stdcall;
    function GetValue(ec: TfEditCookie; const pRange: ITfRange; out pvarValue: OleVariant): HResult; stdcall;
    function GetContext(out ppContext: ITfContext): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfReadOnlyProperty}

// *********************************************************************//
// Interface: ITfProperty
// Flags:     (0)
// GUID:      {E2449660-9542-11D2-BF46-00105A2799B5}
// *********************************************************************//
  ITfProperty = interface(ITfReadOnlyProperty)
    ['{E2449660-9542-11D2-BF46-00105A2799B5}']
    function FindRange(ec: TfEditCookie; const pRange: ITfRange; out ppRange: ITfRange;
                       aPos: TfAnchor): HResult; stdcall;
    function SetValueStore(ec: TfEditCookie; const pRange: ITfRange;
                           const pPropStore: ITfPropertyStore): HResult; stdcall;
    function SetValue(ec: TfEditCookie; const pRange: ITfRange; const pvarValue: OleVariant): HResult; stdcall;
    function Clear(ec: TfEditCookie; const pRange: ITfRange): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfProperty}

// *********************************************************************//
// Interface: IEnumTfRanges
// Flags:     (0)
// GUID:      {F99D3F40-8E32-11D2-BF46-00105A2799B5}
// *********************************************************************//
  IEnumTfRanges = interface(IUnknown)
    ['{F99D3F40-8E32-11D2-BF46-00105A2799B5}']
    function Clone(out ppenum: IEnumTfRanges): HResult; stdcall;
    function Next(ulCount: LongWord; out ppRange: ITfRange; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfRanges}

// *********************************************************************//
// Interface: ITfPropertyStore
// Flags:     (0)
// GUID:      {6834B120-88CB-11D2-BF45-00105A2799B5}
// *********************************************************************//
  ITfPropertyStore = interface(IUnknown)
    ['{6834B120-88CB-11D2-BF45-00105A2799B5}']
    function GetType(out pguid: TGUID): HResult; stdcall;
    function GetDataType(out pdwReserved: LongWord): HResult; stdcall;
    function GetData(out pvarValue: OleVariant): HResult; stdcall;
    function OnTextUpdated(dwFlags: LongWord; const pRangeNew: ITfRange; out pfAccept: Integer): HResult; stdcall;
    function Shrink(const pRangeNew: ITfRange; out pfFree: Integer): HResult; stdcall;
    function Divide(const pRangeThis: ITfRange; const pRangeNew: ITfRange;
                    out ppPropStore: ITfPropertyStore): HResult; stdcall;
    function Clone(out pPropStore: ITfPropertyStore): HResult; stdcall;
    function GetPropertyRangeCreator(out pclsid: TGUID): HResult; stdcall;
    function Serialize(const pStream: IStream; out pcb: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfPropertyStore}

// *********************************************************************//
// Interface: IEnumTfProperties
// Flags:     (0)
// GUID:      {19188CB0-ACA9-11D2-AFC5-00105A2799B5}
// *********************************************************************//
  IEnumTfProperties = interface(IUnknown)
    ['{19188CB0-ACA9-11D2-AFC5-00105A2799B5}']
    function Clone(out ppenum: IEnumTfProperties): HResult; stdcall;
    function Next(ulCount: LongWord; out ppProp: ITfProperty; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfProperties}

// *********************************************************************//
// Interface: ITfRangeBackup
// Flags:     (0)
// GUID:      {463A506D-6992-49D2-9B88-93D55E70BB16}
// *********************************************************************//
  ITfRangeBackup = interface(IUnknown)
    ['{463A506D-6992-49D2-9B88-93D55E70BB16}']
    function Restore(ec: TfEditCookie; const pRange: ITfRange): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfRangeBackup}

// *********************************************************************//
// Interface: IEnumTfContexts
// Flags:     (0)
// GUID:      {8F1A7EA6-1654-4502-A86E-B2902344D507}
// *********************************************************************//
  IEnumTfContexts = interface(IUnknown)
    ['{8F1A7EA6-1654-4502-A86E-B2902344D507}']
    function Clone(out ppenum: IEnumTfContexts): HResult; stdcall;
    function Next(ulCount: LongWord; out rgContext: ITfContext; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfContexts}

// *********************************************************************//
// Interface: ITfTextInputProcessor
// Flags:     (0)
// GUID:      {AA80E7F7-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfTextInputProcessor = interface(IUnknown)
    ['{AA80E7F7-2021-11D2-93E0-0060B067B86E}']
    function Activate(const ptim: ITfThreadMgr; tid: TfClientId): HResult; stdcall;
    function Deactivate: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfTextInputProcessor}

// *********************************************************************//
// Interface: ITfThreadMgr
// Flags:     (0)
// GUID:      {AA80E801-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfThreadMgr = interface(IUnknown)
    ['{AA80E801-2021-11D2-93E0-0060B067B86E}']
    function Activate(out ptid: TfClientId): HResult; stdcall;
    function Deactivate: HResult; stdcall;
    function CreateDocumentMgr(out ppdim: ITfDocumentMgr): HResult; stdcall;
    function EnumDocumentMgrs(out ppenum: IEnumTfDocumentMgrs): HResult; stdcall;
    function GetFocus(out ppdimFocus: ITfDocumentMgr): HResult; stdcall;
    function SetFocus(const pdimFocus: ITfDocumentMgr): HResult; stdcall;
 // !! "var hwnd: _RemotableHandle" -> "hwnd: HWND"
    function AssociateFocus(hwnd: HWND; const pdimNew: ITfDocumentMgr;
                            out ppdimPrev: ITfDocumentMgr): HResult; stdcall;
    function IsThreadFocus(out pfThreadFocus: Integer): HResult; stdcall;
    function GetFunctionProvider(var clsid: TGUID; out ppFuncProv: ITfFunctionProvider): HResult; stdcall;
    function EnumFunctionProviders(out ppenum: IEnumTfFunctionProviders): HResult; stdcall;
    function GetGlobalCompartment(out ppCompMgr: ITfCompartmentMgr): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfThreadMgr}

// *********************************************************************//
// Interface: IEnumTfDocumentMgrs
// Flags:     (0)
// GUID:      {AA80E808-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  IEnumTfDocumentMgrs = interface(IUnknown)
    ['{AA80E808-2021-11D2-93E0-0060B067B86E}']
    function Clone(out ppenum: IEnumTfDocumentMgrs): HResult; stdcall;
    function Next(ulCount: LongWord; out rgDocumentMgr: ITfDocumentMgr; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfDocumentMgrs}

// *********************************************************************//
// Interface: ITfFunctionProvider
// Flags:     (0)
// GUID:      {101D6610-0990-11D3-8DF0-00105A2799B5}
// *********************************************************************//
  ITfFunctionProvider = interface(IUnknown)
    ['{101D6610-0990-11D3-8DF0-00105A2799B5}']
    function GetType(out pguid: TGUID): HResult; stdcall;
    function GetDescription(out pbstrDesc: WideString): HResult; stdcall;
    function GetFunction(var rguid: TGUID; var riid: TGUID; out ppunk: IUnknown): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfFunctionProvider}

// *********************************************************************//
// Interface: IEnumTfFunctionProviders
// Flags:     (0)
// GUID:      {E4B24DB0-0990-11D3-8DF0-00105A2799B5}
// *********************************************************************//
  IEnumTfFunctionProviders = interface(IUnknown)
    ['{E4B24DB0-0990-11D3-8DF0-00105A2799B5}']
    function Clone(out ppenum: IEnumTfFunctionProviders): HResult; stdcall;
    function Next(ulCount: LongWord; out ppCmdobj: ITfFunctionProvider; out pcFetch: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfFunctionProviders}

// *********************************************************************//
// Interface: ITfCompartmentMgr
// Flags:     (0)
// GUID:      {7DCF57AC-18AD-438B-824D-979BFFB74B7C}
// *********************************************************************//
  ITfCompartmentMgr = interface(IUnknown)
    ['{7DCF57AC-18AD-438B-824D-979BFFB74B7C}']
    function GetCompartment(var rguid: TGUID; out ppcomp: ITfCompartment): HResult; stdcall;
    function ClearCompartment(tid: TfClientId; var rguid: TGUID): HResult; stdcall;
    function EnumCompartments(out ppenum: IEnumGUID): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCompartmentMgr}

// *********************************************************************//
// Interface: ITfCompartment
// Flags:     (0)
// GUID:      {BB08F7A9-607A-4384-8623-056892B64371}
// *********************************************************************//
  ITfCompartment = interface(IUnknown)
    ['{BB08F7A9-607A-4384-8623-056892B64371}']
    function SetValue(tid: TfClientId; const pvarValue: OleVariant): HResult; stdcall;
    function GetValue(out pvarValue: OleVariant): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCompartment}

// *********************************************************************//
// Interface: ITfRangeACP
// Flags:     (0)
// GUID:      {057A6296-029B-4154-B79A-0D461D4EA94C}
// *********************************************************************//
  ITfRangeACP = interface(ITfRange)
    ['{057A6296-029B-4154-B79A-0D461D4EA94C}']
    function GetExtent(out pacpAnchor: Integer; out pcch: Integer): HResult; stdcall;
    function SetExtent(acpAnchor: Integer; cch: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfRangeACP}

// *********************************************************************//
// Interface: ITfPersistentPropertyLoaderACP
// Flags:     (0)
// GUID:      {4EF89150-0807-11D3-8DF0-00105A2799B5}
// *********************************************************************//
  ITfPersistentPropertyLoaderACP = interface(IUnknown)
    ['{4EF89150-0807-11D3-8DF0-00105A2799B5}']
    function LoadProperty(var pHdr: TF_PERSISTENT_PROPERTY_HEADER_ACP; out ppStream: IStream): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfPersistentPropertyLoaderACP}

// *********************************************************************//
// Interface: ITfKeyEventSink
// Flags:     (0)
// GUID:      {AA80E7F5-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfKeyEventSink = interface(IUnknown)
    ['{AA80E7F5-2021-11D2-93E0-0060B067B86E}']
    function OnSetFocus(fForeground: Integer): HResult; stdcall;
    function OnTestKeyDown(const pic: ITfContext; wParam: WPARAM; lParam: LPARAM;
                           out pfEaten: Integer): HResult; stdcall;
    function OnTestKeyUp(const pic: ITfContext; wParam: WPARAM; lParam: LPARAM;
                         out pfEaten: Integer): HResult; stdcall;
    function OnKeyDown(const pic: ITfContext; wParam: WPARAM; lParam: LPARAM;
                       out pfEaten: Integer): HResult; stdcall;
    function OnKeyUp(const pic: ITfContext; wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function OnPreservedKey(const pic: ITfContext; var rguid: TGUID; out pfEaten: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfKeyEventSink}

// *********************************************************************//
// Interface: ITfSource
// Flags:     (0)
// GUID:      {4EA48A35-60AE-446F-8FD6-E6A8D82459F7}
// *********************************************************************//
  ITfSource = interface(IUnknown)
    ['{4EA48A35-60AE-446F-8FD6-E6A8D82459F7}']
    function AdviseSink(var riid: TGUID; const punk: IUnknown; out pdwCookie: LongWord): HResult; stdcall;
    function UnadviseSink(dwCookie: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfSource}

// *********************************************************************//
// Interface: ITfMouseSink
// Flags:     (0)
// GUID:      {A1ADAAA2-3A24-449D-AC96-5183E7F5C217}
// *********************************************************************//
  ITfMouseSink = interface(IUnknown)
    ['{A1ADAAA2-3A24-449D-AC96-5183E7F5C217}']
    function OnMouseEvent(uEdge: LongWord; uQuadrant: LongWord; dwBtnStatus: LongWord;
                          out pfEaten: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfMouseSink}

// *********************************************************************//
// Interface: IEnumTfLanguageProfiles
// Flags:     (0)
// GUID:      {3D61BF11-AC5F-42C8-A4CB-931BCC28C744}
// *********************************************************************//
  IEnumTfLanguageProfiles = interface(IUnknown)
    ['{3D61BF11-AC5F-42C8-A4CB-931BCC28C744}']
    function Clone(out ppenum: IEnumTfLanguageProfiles): HResult; stdcall;
    function Next(ulCount: LongWord; out pProfile: TF_LANGUAGEPROFILE; out pcFetch: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfLanguageProfiles}

// *********************************************************************//
// Interface: ITfUIElement
// Flags:     (0)
// GUID:      {EA1EA137-19DF-11D7-A6D2-00065B84435C}
// *********************************************************************//
  ITfUIElement = interface(IUnknown)
    ['{EA1EA137-19DF-11D7-A6D2-00065B84435C}']
    function GetDescription(out pbstrDescription: WideString): HResult; stdcall;
    function GetGUID(out pguid: TGUID): HResult; stdcall;
    function Show(bShow: Integer): HResult; stdcall;
    function IsShown(out pbShow: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfUIElement}

// *********************************************************************//
// Interface: IEnumTfUIElements
// Flags:     (0)
// GUID:      {887AA91E-ACBA-4931-84DA-3C5208CF543F}
// *********************************************************************//
  IEnumTfUIElements = interface(IUnknown)
    ['{887AA91E-ACBA-4931-84DA-3C5208CF543F}']
    function Clone(out ppenum: IEnumTfUIElements): HResult; stdcall;
    function Next(ulCount: LongWord; out ppElement: ITfUIElement; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfUIElements}

// *********************************************************************//
// Interface: IEnumTfInputProcessorProfiles
// Flags:     (0)
// GUID:      {71C6E74D-0F28-11D8-A82A-00065B84435C}
// *********************************************************************//
  IEnumTfInputProcessorProfiles = interface(IUnknown)
    ['{71C6E74D-0F28-11D8-A82A-00065B84435C}']
    function Clone(out ppenum: IEnumTfInputProcessorProfiles): HResult; stdcall;
    function Next(ulCount: LongWord; out pProfile: TF_INPUTPROCESSORPROFILE; out pcFetch: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfInputProcessorProfiles}

// *********************************************************************//
// Interface: ITfThreadMgrEx
// Flags:     (0)
// GUID:      {3E90ADE3-7594-4CB0-BB58-69628F5F458C}
// *********************************************************************//
  ITfThreadMgrEx = interface(ITfThreadMgr)
    ['{3E90ADE3-7594-4CB0-BB58-69628F5F458C}']
    function ActivateEx(out ptid: TfClientId; dwFlags: LongWord): HResult; stdcall;
    function GetActiveFlags(out lpdwFlags: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfThreadMgrEx}

// *********************************************************************//
// Interface: ITfThreadMgr2
// Flags:     (0)
// GUID:      {0AB198EF-6477-4EE8-8812-6780EDB82D5E}
// *********************************************************************//
  ITfThreadMgr2 = interface(IUnknown)
    ['{0AB198EF-6477-4EE8-8812-6780EDB82D5E}']
    function Activate(out ptid: TfClientId): HResult; stdcall;
    function Deactivate: HResult; stdcall;
    function CreateDocumentMgr(out ppdim: ITfDocumentMgr): HResult; stdcall;
    function EnumDocumentMgrs(out ppenum: IEnumTfDocumentMgrs): HResult; stdcall;
    function GetFocus(out ppdimFocus: ITfDocumentMgr): HResult; stdcall;
    function SetFocus(const pdimFocus: ITfDocumentMgr): HResult; stdcall;
    function IsThreadFocus(out pfThreadFocus: Integer): HResult; stdcall;
    function GetFunctionProvider(var clsid: TGUID; out ppFuncProv: ITfFunctionProvider): HResult; stdcall;
    function EnumFunctionProviders(out ppenum: IEnumTfFunctionProviders): HResult; stdcall;
    function GetGlobalCompartment(out ppCompMgr: ITfCompartmentMgr): HResult; stdcall;
    function ActivateEx(out ptid: TfClientId; dwFlags: LongWord): HResult; stdcall;
    function GetActiveFlags(out lpdwFlags: LongWord): HResult; stdcall;
    function SuspendKeystrokeHandling: HResult; stdcall;
    function ResumeKeystrokeHandling: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfThreadMgr2}

// *********************************************************************//
// Interface: ITfConfigureSystemKeystrokeFeed
// Flags:     (0)
// GUID:      {0D2C969A-BC9C-437C-84EE-951C49B1A764}
// *********************************************************************//
  ITfConfigureSystemKeystrokeFeed = interface(IUnknown)
    ['{0D2C969A-BC9C-437C-84EE-951C49B1A764}']
    function DisableSystemKeystrokeFeed: HResult; stdcall;
    function EnableSystemKeystrokeFeed: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfConfigureSystemKeystrokeFeed}

// *********************************************************************//
// Interface: ITfCompositionView
// Flags:     (0)
// GUID:      {D7540241-F9A1-4364-BEFC-DBCD2C4395B7}
// *********************************************************************//
  ITfCompositionView = interface(IUnknown)
    ['{D7540241-F9A1-4364-BEFC-DBCD2C4395B7}']
    function GetOwnerClsid(out pclsid: TGUID): HResult; stdcall;
    function GetRange(out ppRange: ITfRange): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCompositionView}

// *********************************************************************//
// Interface: IEnumITfCompositionView
// Flags:     (0)
// GUID:      {5EFD22BA-7838-46CB-88E2-CADB14124F8F}
// *********************************************************************//
  IEnumITfCompositionView = interface(IUnknown)
    ['{5EFD22BA-7838-46CB-88E2-CADB14124F8F}']
    function Clone(out ppenum: IEnumITfCompositionView): HResult; stdcall;
    function Next(ulCount: LongWord; out rgCompositionView: ITfCompositionView;
                  out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumITfCompositionView}

// *********************************************************************//
// Interface: ITfComposition
// Flags:     (0)
// GUID:      {20168D64-5A8F-4A5A-B7BD-CFA29F4D0FD9}
// *********************************************************************//
  ITfComposition = interface(IUnknown)
    ['{20168D64-5A8F-4A5A-B7BD-CFA29F4D0FD9}']
    function GetRange(out ppRange: ITfRange): HResult; stdcall;
    function ShiftStart(ecWrite: TfEditCookie; const pNewStart: ITfRange): HResult; stdcall;
    function ShiftEnd(ecWrite: TfEditCookie; const pNewEnd: ITfRange): HResult; stdcall;
    function EndComposition(ecWrite: TfEditCookie): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfComposition}

// *********************************************************************//
// Interface: ITfCompositionSink
// Flags:     (0)
// GUID:      {A781718C-579A-4B15-A280-32B8577ACC5E}
// *********************************************************************//
  ITfCompositionSink = interface(IUnknown)
    ['{A781718C-579A-4B15-A280-32B8577ACC5E}']
    function OnCompositionTerminated(ecWrite: TfEditCookie; const pComposition: ITfComposition): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCompositionSink}

// *********************************************************************//
// Interface: ITfContextComposition
// Flags:     (0)
// GUID:      {D40C8AAE-AC92-4FC7-9A11-0EE0E23AA39B}
// *********************************************************************//
  ITfContextComposition = interface(IUnknown)
    ['{D40C8AAE-AC92-4FC7-9A11-0EE0E23AA39B}']
    function StartComposition(ecWrite: TfEditCookie; const pCompositionRange: ITfRange;
                              const pSink: ITfCompositionSink; out ppComposition: ITfComposition): HResult; stdcall;
    function EnumCompositions(out ppenum: IEnumITfCompositionView): HResult; stdcall;
    function FindComposition(ecRead: TfEditCookie; const pTestRange: ITfRange;
                             out ppenum: IEnumITfCompositionView): HResult; stdcall;
    function TakeOwnership(ecWrite: TfEditCookie; const pComposition: ITfCompositionView;
                           const pSink: ITfCompositionSink; out ppComposition: ITfComposition): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContextComposition}

// *********************************************************************//
// Interface: ITfContextOwnerCompositionServices
// Flags:     (0)
// GUID:      {86462810-593B-4916-9764-19C08E9CE110}
// *********************************************************************//
  ITfContextOwnerCompositionServices = interface(ITfContextComposition)
    ['{86462810-593B-4916-9764-19C08E9CE110}']
    function TerminateComposition(const pComposition: ITfCompositionView): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContextOwnerCompositionServices}

// *********************************************************************//
// Interface: ITfContextOwnerCompositionSink
// Flags:     (0)
// GUID:      {5F20AA40-B57A-4F34-96AB-3576F377CC79}
// *********************************************************************//
  ITfContextOwnerCompositionSink = interface(IUnknown)
    ['{5F20AA40-B57A-4F34-96AB-3576F377CC79}']
    function OnStartComposition(const pComposition: ITfCompositionView; out pfOk: Integer): HResult; stdcall;
    function OnUpdateComposition(const pComposition: ITfCompositionView; const pRangeNew: ITfRange): HResult; stdcall;
    function OnEndComposition(const pComposition: ITfCompositionView): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContextOwnerCompositionSink}

// *********************************************************************//
// Interface: ITfQueryEmbedded
// Flags:     (0)
// GUID:      {0FAB9BDB-D250-4169-84E5-6BE118FDD7A8}
// *********************************************************************//
  ITfQueryEmbedded = interface(IUnknown)
    ['{0FAB9BDB-D250-4169-84E5-6BE118FDD7A8}']
    function QueryInsertEmbedded(var pguidService: TGUID; var pformatetc: TFormatEtc;
                                 out pfInsertable: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfQueryEmbedded}

// *********************************************************************//
// Interface: ITfInsertAtSelection
// Flags:     (0)
// GUID:      {55CE16BA-3014-41C1-9CEB-FADE1446AC6C}
// *********************************************************************//
  ITfInsertAtSelection = interface(IUnknown)
    ['{55CE16BA-3014-41C1-9CEB-FADE1446AC6C}']
// !! "var word" -> PWideChar
    function InsertTextAtSelection(ec: TfEditCookie; dwFlags: LongWord; pchText: PWideChar;
                                   cch: Integer; out ppRange: ITfRange): HResult; stdcall;
    function InsertEmbeddedAtSelection(ec: TfEditCookie; dwFlags: LongWord;
                                       const pDataObject: IDataObject; out ppRange: ITfRange): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfInsertAtSelection}

// *********************************************************************//
// Interface: ITfCleanupContextSink
// Flags:     (0)
// GUID:      {01689689-7ACB-4E9B-AB7C-7EA46B12B522}
// *********************************************************************//
  ITfCleanupContextSink = interface(IUnknown)
    ['{01689689-7ACB-4E9B-AB7C-7EA46B12B522}']
    function OnCleanupContext(ecWrite: TfEditCookie; const pic: ITfContext): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCleanupContextSink}

// *********************************************************************//
// Interface: ITfCleanupContextDurationSink
// Flags:     (0)
// GUID:      {45C35144-154E-4797-BED8-D33AE7BF8794}
// *********************************************************************//
  ITfCleanupContextDurationSink = interface(IUnknown)
    ['{45C35144-154E-4797-BED8-D33AE7BF8794}']
    function OnStartCleanupContext: HResult; stdcall;
    function OnEndCleanupContext: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCleanupContextDurationSink}

// *********************************************************************//
// Interface: IEnumTfPropertyValue
// Flags:     (0)
// GUID:      {8ED8981B-7C10-4D7D-9FB3-AB72E9C75F72}
// *********************************************************************//
  IEnumTfPropertyValue = interface(IUnknown)
    ['{8ED8981B-7C10-4D7D-9FB3-AB72E9C75F72}']
    function Clone(out ppenum: IEnumTfPropertyValue): HResult; stdcall;
    function Next(ulCount: LongWord; out rgValues: TF_PROPERTYVAL; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfPropertyValue}

// *********************************************************************//
// Interface: ITfMouseTracker
// Flags:     (0)
// GUID:      {09D146CD-A544-4132-925B-7AFA8EF322D0}
// *********************************************************************//
  ITfMouseTracker = interface(IUnknown)
    ['{09D146CD-A544-4132-925B-7AFA8EF322D0}']
    function AdviseMouseSink(const range: ITfRange; const pSink: ITfMouseSink;
                             out pdwCookie: LongWord): HResult; stdcall;
    function UnadviseMouseSink(dwCookie: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfMouseTracker}

// *********************************************************************//
// Interface: ITfMouseTrackerACP
// Flags:     (0)
// GUID:      {3BDD78E2-C16E-47FD-B883-CE6FACC1A208}
// *********************************************************************//
  ITfMouseTrackerACP = interface(IUnknown)
    ['{3BDD78E2-C16E-47FD-B883-CE6FACC1A208}']
    function AdviseMouseSink(const range: ITfRangeACP; const pSink: ITfMouseSink;
                             out pdwCookie: LongWord): HResult; stdcall;
    function UnadviseMouseSink(dwCookie: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfMouseTrackerACP}

// *********************************************************************//
// Interface: ITfEditRecord
// Flags:     (0)
// GUID:      {42D4D099-7C1A-4A89-B836-6C6F22160DF0}
// *********************************************************************//
  ITfEditRecord = interface(IUnknown)
    ['{42D4D099-7C1A-4A89-B836-6C6F22160DF0}']
    function GetSelectionStatus(out pfChanged: Integer): HResult; stdcall;
    function GetTextAndPropertyUpdates(dwFlags: LongWord; prgProperties: PPGUID;
                                       cProperties: LongWord; out ppenum: IEnumTfRanges): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfEditRecord}

// *********************************************************************//
// Interface: ITfTextEditSink
// Flags:     (0)
// GUID:      {8127D409-CCD3-4683-967A-B43D5B482BF7}
// *********************************************************************//
  ITfTextEditSink = interface(IUnknown)
    ['{8127D409-CCD3-4683-967A-B43D5B482BF7}']
    function OnEndEdit(const pic: ITfContext; ecReadOnly: TfEditCookie;
                       const pEditRecord: ITfEditRecord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfTextEditSink}

// *********************************************************************//
// Interface: ITfTextLayoutSink
// Flags:     (0)
// GUID:      {2AF2D06A-DD5B-4927-A0B4-54F19C91FADE}
// *********************************************************************//
  ITfTextLayoutSink = interface(IUnknown)
    ['{2AF2D06A-DD5B-4927-A0B4-54F19C91FADE}']
    function OnLayoutChange(const pic: ITfContext; lcode: TfLayoutCode; const pView: ITfContextView): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfTextLayoutSink}

// *********************************************************************//
// Interface: ITfStatusSink
// Flags:     (0)
// GUID:      {6B7D8D73-B267-4F69-B32E-1CA321CE4F45}
// *********************************************************************//
  ITfStatusSink = interface(IUnknown)
    ['{6B7D8D73-B267-4F69-B32E-1CA321CE4F45}']
    function OnStatusChange(const pic: ITfContext; dwFlags: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfStatusSink}

// *********************************************************************//
// Interface: ITfEditTransactionSink
// Flags:     (0)
// GUID:      {708FBF70-B520-416B-B06C-2C41AB44F8BA}
// *********************************************************************//
  ITfEditTransactionSink = interface(IUnknown)
    ['{708FBF70-B520-416B-B06C-2C41AB44F8BA}']
    function OnStartEditTransaction(const pic: ITfContext): HResult; stdcall;
    function OnEndEditTransaction(const pic: ITfContext): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfEditTransactionSink}

// *********************************************************************//
// Interface: ITfContextOwner
// Flags:     (0)
// GUID:      {AA80E80C-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfContextOwner = interface(IUnknown)
    ['{AA80E80C-2021-11D2-93E0-0060B067B86E}']
    function GetACPFromPoint(var ptScreen: TPoint; dwFlags: LongWord; out pacp: Integer): HResult; stdcall;
    function GetTextExt(acpStart: Integer; acpEnd: Integer; out prc: TRect; out pfClipped: Integer): HResult; stdcall;
    function GetScreenExt(out prc: TRect): HResult; stdcall;
    function GetStatus(out pdcs: TF_STATUS): HResult; stdcall;
// !! "out wireHWND" -> "out HWND"
    function GetWnd(out phwnd: HWND): HResult; stdcall;
    function GetAttribute(var rguidAttribute: TGUID; out pvarValue: OleVariant): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContextOwner}

// *********************************************************************//
// Interface: ITfContextOwnerServices
// Flags:     (0)
// GUID:      {B23EB630-3E1C-11D3-A745-0050040AB407}
// *********************************************************************//
  ITfContextOwnerServices = interface(IUnknown)
    ['{B23EB630-3E1C-11D3-A745-0050040AB407}']
    function OnLayoutChange: HResult; stdcall;
    function OnStatusChange(dwFlags: LongWord): HResult; stdcall;
    function OnAttributeChange(var rguidAttribute: TGUID): HResult; stdcall;
    function Serialize(const pProp: ITfProperty; const pRange: ITfRange;
                       out pHdr: TF_PERSISTENT_PROPERTY_HEADER_ACP; const pStream: IStream): HResult; stdcall;
    function Unserialize(const pProp: ITfProperty; var pHdr: TF_PERSISTENT_PROPERTY_HEADER_ACP;
                         const pStream: IStream; const pLoader: ITfPersistentPropertyLoaderACP): HResult; stdcall;
    function ForceLoadProperty(const pProp: ITfProperty): HResult; stdcall;
    function CreateRange(acpStart: Integer; acpEnd: Integer; out ppRange: ITfRangeACP): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContextOwnerServices}

// *********************************************************************//
// Interface: ITfContextKeyEventSink
// Flags:     (0)
// GUID:      {0552BA5D-C835-4934-BF50-846AAA67432F}
// *********************************************************************//
  ITfContextKeyEventSink = interface(IUnknown)
    ['{0552BA5D-C835-4934-BF50-846AAA67432F}']
    function OnKeyDown(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function OnKeyUp(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function OnTestKeyDown(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function OnTestKeyUp(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfContextKeyEventSink}

// *********************************************************************//
// Interface: ITextStoreACPServices
// Flags:     (0)
// GUID:      {AA80E901-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITextStoreACPServices = interface(IUnknown)
    ['{AA80E901-2021-11D2-93E0-0060B067B86E}']
    function Serialize(const pProp: ITfProperty; const pRange: ITfRange;
                       out pHdr: TF_PERSISTENT_PROPERTY_HEADER_ACP; const pStream: IStream): HResult; stdcall;
    function Unserialize(const pProp: ITfProperty; var pHdr: TF_PERSISTENT_PROPERTY_HEADER_ACP;
                         const pStream: IStream; const pLoader: ITfPersistentPropertyLoaderACP): HResult; stdcall;
    function ForceLoadProperty(const pProp: ITfProperty): HResult; stdcall;
    function CreateRange(acpStart: Integer; acpEnd: Integer; out ppRange: ITfRangeACP): HResult; stdcall;
  end;
  {$EXTERNALSYM ITextStoreACPServices}

// *********************************************************************//
// Interface: ITfCreatePropertyStore
// Flags:     (0)
// GUID:      {2463FBF0-B0AF-11D2-AFC5-00105A2799B5}
// *********************************************************************//
  ITfCreatePropertyStore = interface(IUnknown)
    ['{2463FBF0-B0AF-11D2-AFC5-00105A2799B5}']
    function IsStoreSerializable(var guidProp: TGUID; const pRange: ITfRange;
                                 const pPropStore: ITfPropertyStore; out pfSerializable: Integer): HResult; stdcall;
    function CreatePropertyStore(var guidProp: TGUID; const pRange: ITfRange; cb: LongWord;
                                 const pStream: IStream; out ppStore: ITfPropertyStore): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCreatePropertyStore}

// *********************************************************************//
// Interface: ITfCompartmentEventSink
// Flags:     (0)
// GUID:      {743ABD5F-F26D-48DF-8CC5-238492419B64}
// *********************************************************************//
  ITfCompartmentEventSink = interface(IUnknown)
    ['{743ABD5F-F26D-48DF-8CC5-238492419B64}']
    function OnChange(var rguid: TGUID): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCompartmentEventSink}

// *********************************************************************//
// Interface: ITfFunction
// Flags:     (0)
// GUID:      {DB593490-098F-11D3-8DF0-00105A2799B5}
// *********************************************************************//
  ITfFunction = interface(IUnknown)
    ['{DB593490-098F-11D3-8DF0-00105A2799B5}']
    function GetDisplayName(out pbstrName: WideString): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfFunction}

// *********************************************************************//
// Interface: ITfInputProcessorProfiles
// Flags:     (0)
// GUID:      {1F02B6C5-7842-4EE6-8A0B-9A24183A95CA}
// *********************************************************************//
  ITfInputProcessorProfiles = interface(IUnknown)
    ['{1F02B6C5-7842-4EE6-8A0B-9A24183A95CA}']
    function Register(var rclsid: TGUID): HResult; stdcall;
    function Unregister(var rclsid: TGUID): HResult; stdcall;
// !! "var word" -> PWideChar
    function AddLanguageProfile(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                pchDesc: PWideChar; cchDesc: LongWord; pchIconFile: PWideChar;
                                cchFile: LongWord; uIconIndex: LongWord): HResult; stdcall;
    function RemoveLanguageProfile(var rclsid: TGUID; langid: Word; var guidProfile: TGUID): HResult; stdcall;
    function EnumInputProcessorInfo(out ppenum: IEnumGUID): HResult; stdcall;
    function GetDefaultLanguageProfile(langid: Word; var catid: TGUID; out pclsid: TGUID;
                                       out pguidProfile: TGUID): HResult; stdcall;
    function SetDefaultLanguageProfile(langid: Word; var rclsid: TGUID; var guidProfiles: TGUID): HResult; stdcall;
    function ActivateLanguageProfile(var rclsid: TGUID; langid: Word; var guidProfiles: TGUID): HResult; stdcall;
    function GetActiveLanguageProfile(var rclsid: TGUID; out plangid: Word; out pguidProfile: TGUID): HResult; stdcall;
    function GetLanguageProfileDescription(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                           out pbstrProfile: WideString): HResult; stdcall;
    function GetCurrentLanguage(out plangid: Word): HResult; stdcall;
    function ChangeCurrentLanguage(langid: Word): HResult; stdcall;
    function GetLanguageList(ppLangId: PPWord; out pulCount: LongWord): HResult; stdcall;
    function EnumLanguageProfiles(langid: Word; out ppenum: IEnumTfLanguageProfiles): HResult; stdcall;
    function EnableLanguageProfile(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                   fEnable: Integer): HResult; stdcall;
    function IsEnabledLanguageProfile(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                      out pfEnable: Integer): HResult; stdcall;
    function EnableLanguageProfileByDefault(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                            fEnable: Integer): HResult; stdcall;
    function SubstituteKeyboardLayout(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                      HKL: HKL): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfInputProcessorProfiles}

// *********************************************************************//
// Interface: ITfInputProcessorProfilesEx
// Flags:     (0)
// GUID:      {892F230F-FE00-4A41-A98E-FCD6DE0D35EF}
// *********************************************************************//
  ITfInputProcessorProfilesEx = interface(ITfInputProcessorProfiles)
    ['{892F230F-FE00-4A41-A98E-FCD6DE0D35EF}']
// !! "var word" -> PWideChar
    function SetLanguageProfileDisplayName(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                           pchFile: PWideChar; cchFile: LongWord; uResId: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfInputProcessorProfilesEx}

// *********************************************************************//
// Interface: ITfInputProcessorProfileSubstituteLayout
// Flags:     (0)
// GUID:      {4FD67194-1002-4513-BFF2-C0DDF6258552}
// *********************************************************************//
  ITfInputProcessorProfileSubstituteLayout = interface(IUnknown)
    ['{4FD67194-1002-4513-BFF2-C0DDF6258552}']
    function GetSubstituteKeyboardLayout(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                                         out phKL: HKL): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfInputProcessorProfileSubstituteLayout}

// *********************************************************************//
// Interface: ITfActiveLanguageProfileNotifySink
// Flags:     (0)
// GUID:      {B246CB75-A93E-4652-BF8C-B3FE0CFD7E57}
// *********************************************************************//
  ITfActiveLanguageProfileNotifySink = interface(IUnknown)
    ['{B246CB75-A93E-4652-BF8C-B3FE0CFD7E57}']
    function OnActivated(var clsid: TGUID; var guidProfile: TGUID; fActivated: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfActiveLanguageProfileNotifySink}

// *********************************************************************//
// Interface: ITfLanguageProfileNotifySink
// Flags:     (0)
// GUID:      {43C9FE15-F494-4C17-9DE2-B8A4AC350AA8}
// *********************************************************************//
  ITfLanguageProfileNotifySink = interface(IUnknown)
    ['{43C9FE15-F494-4C17-9DE2-B8A4AC350AA8}']
    function OnLanguageChange(langid: Word; out pfAccept: Integer): HResult; stdcall;
    function OnLanguageChanged: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfLanguageProfileNotifySink}

// *********************************************************************//
// Interface: ITfInputProcessorProfileMgr
// Flags:     (0)
// GUID:      {71C6E74C-0F28-11D8-A82A-00065B84435C}
// *********************************************************************//
  ITfInputProcessorProfileMgr = interface(IUnknown)
    ['{71C6E74C-0F28-11D8-A82A-00065B84435C}']
    function ActivateProfile(dwProfileType: LongWord; langid: Word; var clsid: TGUID;
                             var guidProfile: TGUID; HKL: HKL; dwFlags: LongWord): HResult; stdcall;
    function DeactivateProfile(dwProfileType: LongWord; langid: Word; var clsid: TGUID;
                               var guidProfile: TGUID; HKL: HKL; dwFlags: LongWord): HResult; stdcall;
    function GetProfile(dwProfileType: LongWord; langid: Word; var clsid: TGUID;
                        var guidProfile: TGUID; HKL: HKL; out pProfile: TF_INPUTPROCESSORPROFILE): HResult; stdcall;
    function EnumProfiles(langid: Word; out ppenum: IEnumTfInputProcessorProfiles): HResult; stdcall;
    function ReleaseInputProcessor(var rclsid: TGUID; dwFlags: LongWord): HResult; stdcall;
// !! "var word" -> PWideChar
    function RegisterProfile(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                             pchDesc: PWideChar; cchDesc: LongWord; pchIconFile: PWideChar;
                             cchFile: LongWord; uIconIndex: LongWord; hklSubstitute: HKL;
                             dwPreferredLayout: LongWord; bEnabledByDefault: Integer;
                             dwFlags: LongWord): HResult; stdcall;
    function UnregisterProfile(var rclsid: TGUID; langid: Word; var guidProfile: TGUID;
                               dwFlags: LongWord): HResult; stdcall;
    function GetActiveProfile(var catid: TGUID; out pProfile: TF_INPUTPROCESSORPROFILE): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfInputProcessorProfileMgr}

// *********************************************************************//
// Interface: ITfInputProcessorProfileActivationSink
// Flags:     (0)
// GUID:      {71C6E74E-0F28-11D8-A82A-00065B84435C}
// *********************************************************************//
  ITfInputProcessorProfileActivationSink = interface(IUnknown)
    ['{71C6E74E-0F28-11D8-A82A-00065B84435C}']
    function OnActivated(dwProfileType: LongWord; langid: Word; var clsid: TGUID; var catid: TGUID;
                         var guidProfile: TGUID; HKL: HKL; dwFlags: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfInputProcessorProfileActivationSink}

// *********************************************************************//
// Interface: ITfKeystrokeMgr
// Flags:     (0)
// GUID:      {AA80E7F0-2021-11D2-93E0-0060B067B86E}
// *********************************************************************//
  ITfKeystrokeMgr = interface(IUnknown)
    ['{AA80E7F0-2021-11D2-93E0-0060B067B86E}']
    function AdviseKeyEventSink(tid: TfClientId; const pSink: ITfKeyEventSink; fForeground: Integer): HResult; stdcall;
    function UnadviseKeyEventSink(tid: TfClientId): HResult; stdcall;
    function GetForeground(out pclsid: TGUID): HResult; stdcall;
    function TestKeyDown(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function TestKeyUp(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function KeyDown(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function KeyUp(wParam: WPARAM; lParam: LPARAM; out pfEaten: Integer): HResult; stdcall;
    function GetPreservedKey(const pic: ITfContext; var pprekey: TF_PRESERVEDKEY; out pguid: TGUID): HResult; stdcall;
    function IsPreservedKey(var rguid: TGUID; var pprekey: TF_PRESERVEDKEY; out pfRegistered: Integer): HResult; stdcall;
// !! "var word" -> PWideChar
    function PreserveKey(tid: TfClientId; var rguid: TGUID; var prekey: TF_PRESERVEDKEY;
                         pchDesc: PWideChar; cchDesc: LongWord): HResult; stdcall;
    function UnpreserveKey(var rguid: TGUID; var pprekey: TF_PRESERVEDKEY): HResult; stdcall;
// !! "var word" -> PWideChar
    function SetPreservedKeyDescription(var rguid: TGUID; pchDesc: PWideChar; cchDesc: LongWord): HResult; stdcall;
    function GetPreservedKeyDescription(var rguid: TGUID; out pbstrDesc: WideString): HResult; stdcall;
    function SimulatePreservedKey(const pic: ITfContext; var rguid: TGUID; out pfEaten: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfKeystrokeMgr}

// *********************************************************************//
// Interface: ITfKeyTraceEventSink
// Flags:     (0)
// GUID:      {1CD4C13B-1C36-4191-A70A-7F3E611F367D}
// *********************************************************************//
  ITfKeyTraceEventSink = interface(IUnknown)
    ['{1CD4C13B-1C36-4191-A70A-7F3E611F367D}']
    function OnKeyTraceDown(wParam: WPARAM; lParam: LPARAM): HResult; stdcall;
    function OnKeyTraceUp(wParam: WPARAM; lParam: LPARAM): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfKeyTraceEventSink}

// *********************************************************************//
// Interface: ITfPreservedKeyNotifySink
// Flags:     (0)
// GUID:      {6F77C993-D2B1-446E-853E-5912EFC8A286}
// *********************************************************************//
  ITfPreservedKeyNotifySink = interface(IUnknown)
    ['{6F77C993-D2B1-446E-853E-5912EFC8A286}']
    function OnUpdated(var pprekey: TF_PRESERVEDKEY): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfPreservedKeyNotifySink}

// *********************************************************************//
// Interface: ITfMessagePump
// Flags:     (0)
// GUID:      {8F1B8AD8-0B6B-4874-90C5-BD76011E8F7C}
// *********************************************************************//
  ITfMessagePump = interface(IUnknown)
    ['{8F1B8AD8-0B6B-4874-90C5-BD76011E8F7C}']
 // !! "var hwnd: _RemotableHandle" -> "hwnd: HWND"
    function PeekMessageA(out pMsg: TMSG; hwnd: HWND; wMsgFilterMin: SYSUINT;
                          wMsgFilterMax: SYSUINT; wRemoveMsg: SYSUINT; out pfResult: Integer): HResult; stdcall;
 // !! "var hwnd: _RemotableHandle" -> "hwnd: HWND"
    function GetMessageA(out pMsg: TMSG; hwnd: HWND; wMsgFilterMin: SYSUINT;
                         wMsgFilterMax: SYSUINT; out pfResult: Integer): HResult; stdcall;
 // !! "var hwnd: _RemotableHandle" -> "hwnd: HWND"
    function PeekMessageW(out pMsg: TMSG; hwnd: HWND; wMsgFilterMin: SYSUINT;
                          wMsgFilterMax: SYSUINT; wRemoveMsg: SYSUINT; out pfResult: Integer): HResult; stdcall;
 // !! "var hwnd: _RemotableHandle" -> "hwnd: HWND"
    function GetMessageW(out pMsg: TMSG; hwnd: HWND; wMsgFilterMin: SYSUINT;
                         wMsgFilterMax: SYSUINT; out pfResult: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfMessagePump}

// *********************************************************************//
// Interface: ITfThreadFocusSink
// Flags:     (0)
// GUID:      {C0F1DB0C-3A20-405C-A303-96B6010A885F}
// *********************************************************************//
  ITfThreadFocusSink = interface(IUnknown)
    ['{C0F1DB0C-3A20-405C-A303-96B6010A885F}']
    function OnSetThreadFocus: HResult; stdcall;
    function OnKillThreadFocus: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfThreadFocusSink}

// *********************************************************************//
// Interface: ITfTextInputProcessorEx
// Flags:     (0)
// GUID:      {6E4E2102-F9CD-433D-B496-303CE03A6507}
// *********************************************************************//
  ITfTextInputProcessorEx = interface(ITfTextInputProcessor)
    ['{6E4E2102-F9CD-433D-B496-303CE03A6507}']
    function ActivateEx(const ptim: ITfThreadMgr; tid: TfClientId; dwFlags: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfTextInputProcessorEx}

// *********************************************************************//
// Interface: ITfClientId
// Flags:     (0)
// GUID:      {D60A7B49-1B9F-4BE2-B702-47E9DC05DEC3}
// *********************************************************************//
  ITfClientId = interface(IUnknown)
    ['{D60A7B49-1B9F-4BE2-B702-47E9DC05DEC3}']
    function GetClientId(var rclsid: TGUID; out ptid: TfClientId): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfClientId}

// *********************************************************************//
// Interface: ITfDisplayAttributeInfo
// Flags:     (0)
// GUID:      {70528852-2F26-4AEA-8C96-215150578932}
// *********************************************************************//
  ITfDisplayAttributeInfo = interface(IUnknown)
    ['{70528852-2F26-4AEA-8C96-215150578932}']
    function GetGUID(out pguid: TGUID): HResult; stdcall;
    function GetDescription(out pbstrDesc: WideString): HResult; stdcall;
    function GetAttributeInfo(out pda: TF_DISPLAYATTRIBUTE): HResult; stdcall;
    function SetAttributeInfo(var pda: TF_DISPLAYATTRIBUTE): HResult; stdcall;
    function Reset: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfDisplayAttributeInfo}

// *********************************************************************//
// Interface: IEnumTfDisplayAttributeInfo
// Flags:     (0)
// GUID:      {7CEF04D7-CB75-4E80-A7AB-5F5BC7D332DE}
// *********************************************************************//
  IEnumTfDisplayAttributeInfo = interface(IUnknown)
    ['{7CEF04D7-CB75-4E80-A7AB-5F5BC7D332DE}']
    function Clone(out ppenum: IEnumTfDisplayAttributeInfo): HResult; stdcall;
    function Next(ulCount: LongWord; out rgInfo: ITfDisplayAttributeInfo; out pcFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(ulCount: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM IEnumTfDisplayAttributeInfo}

// *********************************************************************//
// Interface: ITfDisplayAttributeProvider
// Flags:     (0)
// GUID:      {FEE47777-163C-4769-996A-6E9C50AD8F54}
// *********************************************************************//
  ITfDisplayAttributeProvider = interface(IUnknown)
    ['{FEE47777-163C-4769-996A-6E9C50AD8F54}']
    function EnumDisplayAttributeInfo(out ppenum: IEnumTfDisplayAttributeInfo): HResult; stdcall;
    function GetDisplayAttributeInfo(var GUID: TGUID; out ppInfo: ITfDisplayAttributeInfo): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfDisplayAttributeProvider}

// *********************************************************************//
// Interface: ITfDisplayAttributeMgr
// Flags:     (0)
// GUID:      {8DED7393-5DB1-475C-9E71-A39111B0FF67}
// *********************************************************************//
  ITfDisplayAttributeMgr = interface(IUnknown)
    ['{8DED7393-5DB1-475C-9E71-A39111B0FF67}']
    function OnUpdateInfo: HResult; stdcall;
    function EnumDisplayAttributeInfo(out ppenum: IEnumTfDisplayAttributeInfo): HResult; stdcall;
    function GetDisplayAttributeInfo(var GUID: TGUID; out ppInfo: ITfDisplayAttributeInfo;
                                     out pclsidOwner: TGUID): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfDisplayAttributeMgr}

// *********************************************************************//
// Interface: ITfDisplayAttributeNotifySink
// Flags:     (0)
// GUID:      {AD56F402-E162-4F25-908F-7D577CF9BDA9}
// *********************************************************************//
  ITfDisplayAttributeNotifySink = interface(IUnknown)
    ['{AD56F402-E162-4F25-908F-7D577CF9BDA9}']
    function OnUpdateInfo: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfDisplayAttributeNotifySink}

// *********************************************************************//
// Interface: ITfCategoryMgr
// Flags:     (0)
// GUID:      {C3ACEFB5-F69D-4905-938F-FCADCF4BE830}
// *********************************************************************//
  ITfCategoryMgr = interface(IUnknown)
    ['{C3ACEFB5-F69D-4905-938F-FCADCF4BE830}']
    function RegisterCategory(var rclsid: TGUID; var rcatid: TGUID; var rguid: TGUID): HResult; stdcall;
    function UnregisterCategory(var rclsid: TGUID; var rcatid: TGUID; var rguid: TGUID): HResult; stdcall;
    function EnumCategoriesInItem(var rguid: TGUID; out ppenum: IEnumGUID): HResult; stdcall;
    function EnumItemsInCategory(var rcatid: TGUID; out ppenum: IEnumGUID): HResult; stdcall;
    function FindClosestCategory(var rguid: TGUID; out pcatid: TGUID; ppcatidList: PPGUID;
                                 ulCount: LongWord): HResult; stdcall;
// !! "var word" -> PWideChar
    function RegisterGUIDDescription(var rclsid: TGUID; var rguid: TGUID; pchDesc: PWideChar;
                                     cch: LongWord): HResult; stdcall;
    function UnregisterGUIDDescription(var rclsid: TGUID; var rguid: TGUID): HResult; stdcall;
    function GetGUIDDescription(var rguid: TGUID; out pbstrDesc: WideString): HResult; stdcall;
    function RegisterGUIDDWORD(var rclsid: TGUID; var rguid: TGUID; dw: LongWord): HResult; stdcall;
    function UnregisterGUIDDWORD(var rclsid: TGUID; var rguid: TGUID): HResult; stdcall;
    function GetGUIDDWORD(var rguid: TGUID; out pdw: LongWord): HResult; stdcall;
    function RegisterGUID(var rguid: TGUID; out pguidatom: TfGuidAtom): HResult; stdcall;
    function GetGUID(guidatom: TfGuidAtom; out pguid: TGUID): HResult; stdcall;
    function IsEqualTfGuidAtom(guidatom: TfGuidAtom; var rguid: TGUID; out pfEqual: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCategoryMgr}

// *********************************************************************//
// Interface: ITfSourceSingle
// Flags:     (0)
// GUID:      {73131F9C-56A9-49DD-B0EE-D046633F7528}
// *********************************************************************//
  ITfSourceSingle = interface(IUnknown)
    ['{73131F9C-56A9-49DD-B0EE-D046633F7528}']
    function AdviseSingleSink(tid: TfClientId; var riid: TGUID; const punk: IUnknown): HResult; stdcall;
    function UnadviseSingleSink(tid: TfClientId; var riid: TGUID): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfSourceSingle}

// *********************************************************************//
// Interface: ITfUIElementMgr
// Flags:     (0)
// GUID:      {EA1EA135-19DF-11D7-A6D2-00065B84435C}
// *********************************************************************//
  ITfUIElementMgr = interface(IUnknown)
    ['{EA1EA135-19DF-11D7-A6D2-00065B84435C}']
    function BeginUIElement(const pElement: ITfUIElement; var pbShow: Integer;
                            out pdwUIElementId: LongWord): HResult; stdcall;
    function UpdateUIElement(dwUIElementId: LongWord): HResult; stdcall;
    function EndUIElement(dwUIElementId: LongWord): HResult; stdcall;
    function GetUIElement(dwUIElementId: LongWord; out ppElement: ITfUIElement): HResult; stdcall;
    function EnumUIElements(out ppenum: IEnumTfUIElements): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfUIElementMgr}

// *********************************************************************//
// Interface: ITfUIElementSink
// Flags:     (0)
// GUID:      {EA1EA136-19DF-11D7-A6D2-00065B84435C}
// *********************************************************************//
  ITfUIElementSink = interface(IUnknown)
    ['{EA1EA136-19DF-11D7-A6D2-00065B84435C}']
    function BeginUIElement(dwUIElementId: LongWord; var pbShow: Integer): HResult; stdcall;
    function UpdateUIElement(dwUIElementId: LongWord): HResult; stdcall;
    function EndUIElement(dwUIElementId: LongWord): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfUIElementSink}

// *********************************************************************//
// Interface: ITfCandidateListUIElement
// Flags:     (0)
// GUID:      {EA1EA138-19DF-11D7-A6D2-00065B84435C}
// *********************************************************************//
  ITfCandidateListUIElement = interface(ITfUIElement)
    ['{EA1EA138-19DF-11D7-A6D2-00065B84435C}']
    function GetUpdatedFlags(out pdwFlags: LongWord): HResult; stdcall;
    function GetDocumentMgr(out ppdim: ITfDocumentMgr): HResult; stdcall;
    function GetCount(out puCount: SYSUINT): HResult; stdcall;
    function GetSelection(out puIndex: SYSUINT): HResult; stdcall;
    function GetString(uIndex: SYSUINT; out pstr: WideString): HResult; stdcall;
    function GetPageIndex(out pIndex: SYSUINT; uSize: SYSUINT; out puPageCnt: SYSUINT): HResult; stdcall;
    function SetPageIndex(var pIndex: SYSUINT; uPageCnt: SYSUINT): HResult; stdcall;
    function GetCurrentPage(out puPage: SYSUINT): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCandidateListUIElement}

// *********************************************************************//
// Interface: ITfCandidateListUIElementBehavior
// Flags:     (0)
// GUID:      {85FAD185-58CE-497A-9460-355366B64B9A}
// *********************************************************************//
  ITfCandidateListUIElementBehavior = interface(ITfCandidateListUIElement)
    ['{85FAD185-58CE-497A-9460-355366B64B9A}']
    function SetSelection(nIndex: SYSUINT): HResult; stdcall;
    function Finalize: HResult; stdcall;
    function Abort: HResult; stdcall;
  end;
  {$EXTERNALSYM ITfCandidateListUIElementBehavior}

// *********************************************************************//
// Interface: ITfReadingInformationUIElement
// Flags:     (0)
// GUID:      {EA1EA139-19DF-11D7-A6D2-00065B84435C}
// *********************************************************************//
  ITfReadingInformationUIElement = interface(ITfUIElement)
    ['{EA1EA139-19DF-11D7-A6D2-00065B84435C}']
    function GetUpdatedFlags(out pdwFlags: LongWord): HResult; stdcall;
    function GetContext(out ppic: ITfContext): HResult; stdcall;
    function GetString(out pstr: WideString): HResult; stdcall;
    function GetMaxReadingStringLength(out pcchMax: SYSUINT): HResult; stdcall;
    function GetErrorIndex(out pErrorIndex: SYSUINT): HResult; stdcall;
    function IsVerticalOrderPreferred(out pfVertical: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfReadingInformationUIElement}

// *********************************************************************//
// Interface: ITfTransitoryExtensionUIElement
// Flags:     (0)
// GUID:      {858F956A-972F-42A2-A2F2-0321E1ABE209}
// *********************************************************************//
  ITfTransitoryExtensionUIElement = interface(ITfUIElement)
    ['{858F956A-972F-42A2-A2F2-0321E1ABE209}']
    function GetDocumentMgr(out ppdim: ITfDocumentMgr): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfTransitoryExtensionUIElement}

// *********************************************************************//
// Interface: ITfTransitoryExtensionSink
// Flags:     (0)
// GUID:      {A615096F-1C57-4813-8A15-55EE6E5A839C}
// *********************************************************************//
  ITfTransitoryExtensionSink = interface(IUnknown)
    ['{A615096F-1C57-4813-8A15-55EE6E5A839C}']
    function OnTransitoryExtensionUpdated(const pic: ITfContext; ecReadOnly: TfEditCookie;
                                          const pResultRange: ITfRange;
                                          const pCompositionRange: ITfRange;
                                          out pfDeleteResultRange: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfTransitoryExtensionSink}

// *********************************************************************//
// Interface: ITfToolTipUIElement
// Flags:     (0)
// GUID:      {52B18B5C-555D-46B2-B00A-FA680144FBDB}
// *********************************************************************//
  ITfToolTipUIElement = interface(ITfUIElement)
    ['{52B18B5C-555D-46B2-B00A-FA680144FBDB}']
    function GetString(out pstr: WideString): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfToolTipUIElement}

// *********************************************************************//
// Interface: ITfReverseConversionList
// Flags:     (0)
// GUID:      {151D69F0-86F4-4674-B721-56911E797F47}
// *********************************************************************//
  ITfReverseConversionList = interface(IUnknown)
    ['{151D69F0-86F4-4674-B721-56911E797F47}']
    function GetLength(out puIndex: SYSUINT): HResult; stdcall;
    function GetString(uIndex: SYSUINT; out pbstr: WideString): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfReverseConversionList}

// *********************************************************************//
// Interface: ITfReverseConversion
// Flags:     (0)
// GUID:      {A415E162-157D-417D-8A8C-0AB26C7D2781}
// *********************************************************************//
  ITfReverseConversion = interface(IUnknown)
    ['{A415E162-157D-417D-8A8C-0AB26C7D2781}']
    function DoReverseConversion(lpstr: PWideChar; out ppList: ITfReverseConversionList): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfReverseConversion}

// *********************************************************************//
// Interface: ITfReverseConversionMgr
// Flags:     (0)
// GUID:      {B643C236-C493-41B6-ABB3-692412775CC4}
// *********************************************************************//
  ITfReverseConversionMgr = interface(IUnknown)
    ['{B643C236-C493-41B6-ABB3-692412775CC4}']
    function GetReverseConversion(langid: Word; var guidProfile: TGUID; dwflag: LongWord;
                                  out ppReverseConversion: ITfReverseConversion): HResult; stdcall;
  end;
  {$EXTERNALSYM ITfReverseConversionMgr}


//============================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------
// Moved C language section
type

  PTfThreadMgr = ^ITfThreadMgr;
  {$EXTERNALSYM PTfThreadMgr}
  PPTfThreadMgr = ^PTfThreadMgr;
  {$EXTERNALSYM PPTfThreadMgr}

  PTfInputProcessorProfiles =  ^ITfInputProcessorProfiles;
  {$EXTERNALSYM PTfInputProcessorProfiles}
  PPTfInputProcessorProfiles =  ^PTfInputProcessorProfiles;
  {$EXTERNALSYM PPTfInputProcessorProfiles}

  PTfDisplayAttributeMgr = ^ITfDisplayAttributeMgr;
  {$EXTERNALSYM PTfDisplayAttributeMgr}
  PPTfDisplayAttributeMgr = ^PTfDisplayAttributeMgr;
  {$EXTERNALSYM PPTfDisplayAttributeMgr}

//  PTfLangBarMgr = ^ITfLangBarMgr;
//  {$EXTERNALSYM PTfLangBarMgr}
//  PPTfLangBarMgr = ^PTfLangBarMgr;
//  {$EXTERNALSYM PPTfLangBarMgr}

//  PTfLangBarItemMgr = ^ITfLangBarItemMgr;
//  {$EXTERNALSYM PTfLangBarItemMgr}
//  PPTfLangBarItemMgr = ^PTfLangBarItemMgr;
//  {$EXTERNALSYM PPTfLangBarItemMgr}

  PTfCategoryMgr = ^ITfCategoryMgr;
  {$EXTERNALSYM PTfCategoryMgr}
  PPTfCategoryMgr = ^PTfCategoryMgr;
  {$EXTERNALSYM PPTfCategoryMgr}

function TF_CreateThreadMgr(pptim: PPTfThreadMgr): HRESULT; stdcall;
{$EXTERNALSYM TF_CreateThreadMgr}
function TF_GetThreadMgr(pptim: PPTfThreadMgr): HRESULT; stdcall;
{$EXTERNALSYM TF_GetThreadMgr}
function TF_CreateInputProcessorProfiles(ppipr: PPTfInputProcessorProfiles): HRESULT; stdcall;
{$EXTERNALSYM TF_CreateInputProcessorProfiles}
function TF_CreateDisplayAttributeMgr(ppdam: PPTfDisplayAttributeMgr): HRESULT; stdcall;
{$EXTERNALSYM TF_CreateDisplayAttributeMgr}
//function TF_CreateLangBarMgr(pppbm: PPTfLangBarMgr): HRESULT; stdcall;
//{$EXTERNALSYM TF_CreateLangBarMgr}
//function TF_CreateLangBarItemMgr(pplbim: PPTfLangBarItemMgr): HRESULT; stdcall;
//{$EXTERNALSYM TF_CreateLangBarItemMgr}
function TF_CreateCategoryMgr(ppcat: PPTfCategoryMgr): HRESULT; stdcall;
{$EXTERNALSYM TF_CreateCategoryMgr}

//============================================================================================================================


// InputScope declarations.

type
  InputScope = (
    // common input scopes
    IS_DEFAULT                        = 0,
    IS_URL                            = 1,
    IS_FILE_FULLFILEPATH              = 2,
    IS_FILE_FILENAME                  = 3,
    IS_EMAIL_USERNAME                 = 4,
    IS_EMAIL_SMTPEMAILADDRESS         = 5,
    IS_LOGINNAME                      = 6,
    IS_PERSONALNAME_FULLNAME          = 7,
    IS_PERSONALNAME_PREFIX            = 8,
    IS_PERSONALNAME_GIVENNAME         = 9,
    IS_PERSONALNAME_MIDDLENAME        = 10,
    IS_PERSONALNAME_SURNAME           = 11,
    IS_PERSONALNAME_SUFFIX            = 12,
    IS_ADDRESS_FULLPOSTALADDRESS      = 13,
    IS_ADDRESS_POSTALCODE             = 14,
    IS_ADDRESS_STREET                 = 15,
    IS_ADDRESS_STATEORPROVINCE        = 16,
    IS_ADDRESS_CITY                   = 17,
    IS_ADDRESS_COUNTRYNAME            = 18,
    IS_ADDRESS_COUNTRYSHORTNAME       = 19,
    IS_CURRENCY_AMOUNTANDSYMBOL       = 20,
    IS_CURRENCY_AMOUNT                = 21,
    IS_DATE_FULLDATE                  = 22,
    IS_DATE_MONTH                     = 23,
    IS_DATE_DAY                       = 24,
    IS_DATE_YEAR                      = 25,
    IS_DATE_MONTHNAME                 = 26,
    IS_DATE_DAYNAME                   = 27,
    IS_DIGITS                         = 28,
    IS_NUMBER                         = 29,
    IS_ONECHAR                        = 30,
    IS_PASSWORD                       = 31,
    IS_TELEPHONE_FULLTELEPHONENUMBER  = 32,
    IS_TELEPHONE_COUNTRYCODE          = 33,
    IS_TELEPHONE_AREACODE             = 34,
    IS_TELEPHONE_LOCALNUMBER          = 35,
    IS_TIME_FULLTIME                  = 36,
    IS_TIME_HOUR                      = 37,
    IS_TIME_MINORSEC                  = 38,
    IS_NUMBER_FULLWIDTH               = 39,
    IS_ALPHANUMERIC_HALFWIDTH         = 40,
    IS_ALPHANUMERIC_FULLWIDTH         = 41,
    IS_CURRENCY_CHINESE               = 42,
    IS_BOPOMOFO                       = 43,
    IS_HIRAGANA                       = 44,
    IS_KATAKANA_HALFWIDTH             = 45,
    IS_KATAKANA_FULLWIDTH             = 46,
    IS_HANJA                          = 47,
    IS_HANJA_HALFWIDTH                = 48,
    IS_HANJA_FULLWIDTH                = 49,
    IS_SEARCH                         = 50,
    IS_FORMULA                        = 51,

    // special input scopes for ITfInputScope
    IS_PHRASELIST                     = -1,
    IS_REGULAREXPRESSION              = -2,
    IS_SRGS                           = -3,
    IS_XML                            = -4,
    IS_ENUMSTRING                     = -5
  );

  TInputScope = InputScope;
  PInputScope = ^TInputScope;

  PEnumString = ^IEnumString;

//
// MSCTF entry
//
function SetInputScope(hwnd: HWND; inputscope: TInputScope): HRESULT; stdcall;
{ EXTERNALSYM SetInputScope}
function SetInputScopes(hwnd: HWND; pInputScopes: PInputScope; cInputScopes: UINT;
  ppszPhraseList: PLPWSTR; cPhrases: UINT; pszRegExp: LPWSTR; pszSRGS: LPWSTR): HRESULT; stdcall;
{$EXTERNALSYM SetInputScopes}
function SetInputScopeXML(hwnd: HWND; pszXML: LPWSTR): HRESULT; stdcall;
{$EXTERNALSYM SetInputScopeXML}
function SetInputScopes2(hwnd: HWND; pInputScopes: PInputScope; cInputScopes: UINT;
  pEnumString: PEnumString; pszRegExp: LPWSTR; pszSRGS: LPWSTR): HRESULT; stdcall;
{$EXTERNALSYM SetInputScopes2}

const
  // GUIDs for interfaces declared in this unit

  SID_ITfInputScope  =  '{fde1eaee-6924-4cdf-91e7-da38cff5559d}';
  SID_ITfInputScope2 =  '{5731eaa0-6bc2-4681-a532-92fbb74d7c41}';

  IID_ITfInputScope:     TGUID = SID_ITfInputScope;
  IID_ITfInputScope2:    TGUID = SID_ITfInputScope2;

  GUID_PROP_INPUTSCOPE:  TGUID = '{1713dd5a-68e7-4a5b-9af6-592a595c778d}';

type
  PPInputScope = ^PInputScope;
  PPBSTR = ^PBSTR;
  ppEnumString = ^PEnumString;

  ITfInputScope = interface(IUnknown)
    [SID_ITfInputScope]
    function GetInputScopes(pprgInputScopes: PPInputScope; pcCount: PUINT): HRESULT; stdcall;
    function GetPhrase(ppbstrPhrases: PPBSTR; pcCount: PUINT): HRESULT; stdcall;
    function GetRegularExpression( pbstrRegExp: PBSTR ): HRESULT; stdcall;
    function GetSRGS(pbstrSRGS: PBSTR ): HRESULT; stdcall;
    function GetXML(pbstrXML: PBSTR ): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITfInputScope}

  ITfInputScope2 = interface(ITfInputScope)
    [SID_ITfInputScope2]
    function EnumWordList(ppEnumString: PPEnumString): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ITfInputScope2}

var
  // To disable TSF, you can set 0 to this global control variable.
  MsCTFHandle: THandle = 0;

function IsMSCTFAvailable: Boolean;

implementation

uses
  System.SysUtils, System.Win.ComObj;

const
  MsCTFModName = 'Msctf.dll';

function TF_CreateThreadMgr; external MsCTFModName name 'TF_CreateThreadMgr' delayed;
function TF_GetThreadMgr; external MsCTFModName name 'TF_GetThreadMgr' delayed;
function TF_CreateInputProcessorProfiles; external MsCTFModName name 'TF_CreateInputProcessorProfiles' delayed;
function TF_CreateDisplayAttributeMgr; external MsCTFModName name 'TF_CreateDisplayAttributeMgr' delayed;
//function TF_CreateLangBarMgr; external MsCTFModName name 'TF_CreateLangBarMgr' delayed;
//function TF_CreateLangBarItemMgr; external MsCTFModName name 'TF_CreateLangBarItemMgr' delayed;
function TF_CreateCategoryMgr; external MsCTFModName name 'TF_CreateCategoryMgr' delayed;

//function SetInputScope; external MsCTFModName name 'SetInputScope' delayed;
type
  TSetInputScopeProc = function(hwnd: HWND; inputscope: TInputScope): HRESULT; stdcall;
var
  SetInputScopeProc: TSetInputScopeProc = nil;

function SetInputScope;
begin
  if not Assigned(SetInputScopeProc) and (MsCTFHandle <> 0) then
    @SetInputScopeProc := GetProcAddress(MsCTFHandle, 'SetInputScope');
  if Assigned(SetInputScopeProc) then
    Result := SetInputScopeProc(hwnd, inputscope)
  else
    Result := E_FAIL;
end;

function SetInputScopes; external MsCTFModName name 'SetInputScopes' delayed;
function SetInputScopeXML; external MsCTFModName name 'SetInputScopeXML' delayed;
function SetInputScopes2; external MsCTFModName name 'SetInputScopes2' delayed;

function IsMSCTFAvailable: Boolean;
begin
  Result := MsCTFHandle <> 0;
end;

procedure InitMSCTF;
begin
  if MsCTFHandle = 0 then
    MsCTFHandle := SafeLoadLibrary(MsCTFModName);
end;

procedure DoneMSCTF;
begin
  if MsCTFHandle <> 0 then
    FreeLibrary(MsCTFHandle);
end;

initialization
  InitMSCTF;
finalization
  DoneMSCTF;
end.



