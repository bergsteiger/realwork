{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: corhdr.h                               }
{          Copyright (c) Microsoft Corporation.         }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

(*****************************************************************************
 **                                                                         **
 ** CorHdr.h - contains definitions for the Runtime structures,             **
 **            needed to work with metadata.                                **
 **                                                                         **
 *****************************************************************************)



unit Winapi.CorHdr;

{$ALIGN 8}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Winapi.Windows;

const
  FRAMEWORK_REGISTRY_KEY          = 'Software\Microsoft\.NETFramework';
  {$EXTERNALSYM FRAMEWORK_REGISTRY_KEY}
  FRAMEWORK_REGISTRY_KEY_W        = FRAMEWORK_REGISTRY_KEY;
  {$EXTERNALSYM FRAMEWORK_REGISTRY_KEY_W}

type
  mdScope = LPVOID;                        // Obsolete; not used in the runtime.
  {$EXTERNALSYM mdScope}
  mdToken = ULONG32;                       // Generic token
  {$EXTERNALSYM mdToken}
  {$POINTERMATH ON}
  pmdToken = ^mdToken;
  {$NODEFINE pmdToken}

// Token  definitions

  mdModule = mdToken;                   // Module token (roughly, a scope)
  {$EXTERNALSYM mdModule}
  mdTypeRef = mdToken;                  // TypeRef reference (this or other scope)
  {$EXTERNALSYM mdTypeRef}
  mdTypeDef = mdToken;                  // TypeDef in this scope
  {$EXTERNALSYM mdTypeDef}
  mdFieldDef = mdToken;                 // Field in this scope
  {$EXTERNALSYM mdFieldDef}
  mdMethodDef = mdToken;                // Method in this scope
  {$EXTERNALSYM mdMethodDef}
  mdParamDef = mdToken;                 // param token
  {$EXTERNALSYM mdParamDef}
  mdInterfaceImpl = mdToken;            // interface implementation token
  {$EXTERNALSYM mdInterfaceImpl}
  pmdMethodDef = ^mdMethodDef;
  {$NODEFINE pmdMethodDef}
  pmdTypeDef = ^mdTypeDef;
  {$NODEFINE pmdTypeDef}
  pmdInterfaceImpl = ^mdInterfaceImpl;
  {$NODEFINE pmdInterfaceImpl}
  pmdTypeRef = ^mdTypeRef;
  {$NODEFINE pmdTypeRef}
  pmdFieldDef = ^mdFieldDef;
  {$NODEFINE pmdFieldDef}
  pmdParamDef = ^mdParamDef;
  {$NODEFINE pmdParamDef}

  mdMemberRef = mdToken;                // MemberRef (this or other scope)
  {$EXTERNALSYM mdMemberRef}
  mdCustomAttribute = mdToken;          // attribute token
  {$EXTERNALSYM mdCustomAttribute}
  mdPermission = mdToken;               // DeclSecurity
  {$EXTERNALSYM mdPermission}
  pmdMemberRef = ^mdMemberRef;
  {$NODEFINE pmdMemberRef}
  pmdPermission = ^mdPermission;
  {$NODEFINE pmdPermission}
  pmdCustomAttribute = ^mdCustomAttribute;
  {$NODEFINE pmdCustomAttribute}

  mdSignature = mdToken;                // Signature object
  {$EXTERNALSYM mdSignature}
  mdEvent = mdToken;                    // event token
  {$EXTERNALSYM mdEvent}
  mdProperty = mdToken;                 // property token
  {$EXTERNALSYM mdProperty}
  pmdProperty = ^mdProperty;
  {$NODEFINE pmdProperty}
  pmdEvent = ^mdEvent;
  {$NODEFINE pmdEvent}
  pmdSignature = ^mdSignature;
  {$NODEFINE pmdSignature}

  mdModuleRef = mdToken;                // Module reference (for the imported modules)
  {$EXTERNALSYM mdModuleRef}
  pmdModuleRef = ^mdModuleRef;
  {$NODEFINE pmdModuleRef}

// Assembly tokens.
  mdAssembly = mdToken;                 // Assembly token.
  {$EXTERNALSYM mdAssembly}
  mdAssemblyRef = mdToken;              // AssemblyRef token.
  {$EXTERNALSYM mdAssemblyRef}
  mdFile = mdToken;                     // File token.
  {$EXTERNALSYM mdFile}
  mdExportedType = mdToken;             // ExportedType token.
  {$EXTERNALSYM mdExportedType}
  mdManifestResource = mdToken;         // ManifestResource token.
  {$EXTERNALSYM mdManifestResource}
  pmdAssemblyRef = ^mdAssemblyRef;
  {$NODEFINE pmdAssemblyRef}
  pmdFile = ^mdFile;
  {$NODEFINE pmdFile}
  pmdExportedType = ^mdExportedType;
  {$NODEFINE pmdExportedType}
  pmdManifestResource = ^mdManifestResource;
  {$NODEFINE pmdManifestResource}

  mdTypeSpec = mdToken;                 // TypeSpec object
  {$EXTERNALSYM mdTypeSpec}
  pmdTypeSpec = ^mdTypeSpec;
  {$NODEFINE pmdTypeSpec}

  mdGenericParam = mdToken;             // formal parameter to generic type or method
  {$EXTERNALSYM mdGenericParam}
  mdMethodSpec = mdToken;               // instantiation of a generic method
  {$EXTERNALSYM mdMethodSpec}
  mdGenericParamConstraint = mdToken;     // constraint on a formal generic parameter
  {$EXTERNALSYM mdGenericParamConstraint}
  pmdGenericParam = ^mdGenericParam;
  {$NODEFINE pmdGenericParam}
  pmdGenericParamConstraint = ^mdGenericParamConstraint;     // constraint on a formal generic parameter
  {$NODEFINE pmdGenericParamConstraint}
  pmdMethodSpec = ^mdMethodSpec;
  {$NODEFINE pmdMethodSpec}

// Application string.
  mdString = mdToken;                   // User literal string token.
  {$EXTERNALSYM mdString}
  pmdString = ^mdString;
  {$NODEFINE pmdString}

  mdCPToken = mdToken;                  // constantpool token
  {$EXTERNALSYM mdCPToken}

  {$POINTERMATH OFF}

  RID = ULONG;
  {$EXTERNALSYM RID}
(*
typedef enum ReplacesGeneralNumericDefines
{
// Directory entry macro for CLR data.
#ifndef IMAGE_DIRECTORY_ENTRY_COMHEADER
    IMAGE_DIRECTORY_ENTRY_COMHEADER     =14,
#endif // IMAGE_DIRECTORY_ENTRY_COMHEADER

    _NEW_FLAGS_IMPLEMENTED              =1,
    __NEW_FLAGS_IMPLEMENTED             =1,
} ReplacesGeneralNumericDefines;


#ifndef __IMAGE_COR20_HEADER_DEFINED__
#define __IMAGE_COR20_HEADER_DEFINED__

typedef enum ReplacesCorHdrNumericDefines
{
// COM+ Header entry point flags.
    COMIMAGE_FLAGS_ILONLY               =0x00000001,
    COMIMAGE_FLAGS_32BITREQUIRED        =0x00000002,
    COMIMAGE_FLAGS_IL_LIBRARY           =0x00000004,
    COMIMAGE_FLAGS_STRONGNAMESIGNED     =0x00000008,
// DDBLD - Added Next Line - Still verifying general usage
    COMIMAGE_FLAGS_NATIVE_ENTRYPOINT    =0x00000010,
// DDBLD - End of Add
    COMIMAGE_FLAGS_TRACKDEBUGDATA       =0x00010000,

// Version flags for image.
    COR_VERSION_MAJOR_V2                =2,
    COR_VERSION_MAJOR                   =COR_VERSION_MAJOR_V2,
    COR_VERSION_MINOR                   =5,
    COR_DELETED_NAME_LENGTH             =8,
    COR_VTABLEGAP_NAME_LENGTH           =8,

// Maximum size of a NativeType descriptor.
    NATIVE_TYPE_MAX_CB                  =1,
    COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE=0xFF,

// #defines for the MIH FLAGS
    IMAGE_COR_MIH_METHODRVA             =0x01,
    IMAGE_COR_MIH_EHRVA                 =0x02,
    IMAGE_COR_MIH_BASICBLOCK            =0x08,

// V-table constants
    COR_VTABLE_32BIT                    =0x01,          // V-table slots are 32-bits in size.
    COR_VTABLE_64BIT                    =0x02,          // V-table slots are 64-bits in size.
    COR_VTABLE_FROM_UNMANAGED           =0x04,          // If set, transition from unmanaged.
    COR_VTABLE_CALL_MOST_DERIVED        =0x10,          // Call most derived method described by

// EATJ constants
    IMAGE_COR_EATJ_THUNK_SIZE           =32,            // Size of a jump thunk reserved range.

// Max name lengths    
    //@todo: Change to unlimited name lengths - todo in sdk
    MAX_CLASS_NAME                      =1024,
    MAX_PACKAGE_NAME                    =1024,
} ReplacesCorHdrNumericDefines;

// COM+ 2.0 header structure.
typedef struct IMAGE_COR20_HEADER
{
    // Header versioning
    DWORD                   cb;              
    WORD                    MajorRuntimeVersion;
    WORD                    MinorRuntimeVersion;
    
    // Symbol table and startup information
    IMAGE_DATA_DIRECTORY    MetaData;
    DWORD                   Flags;           
// DDBLD - Added next section to replace following lin
// DDBLD - Still verifying, since not in NT SDK
//    DWORD                   EntryPointToken;
  
    // If COMIMAGE_FLAGS_NATIVE_ENTRYPOINT is not set, EntryPointToken represents a managed entrypoint.
    // If COMIMAGE_FLAGS_NATIVE_ENTRYPOINT is set, EntryPointRVA represents an RVA to a native entrypoint.
    union {
        DWORD               EntryPointToken;
        DWORD               EntryPointRVA;
    };
// DDBLD - End of Added Area
    
    // Binding information
    IMAGE_DATA_DIRECTORY    Resources;
    IMAGE_DATA_DIRECTORY    StrongNameSignature;

    // Regular fixup and binding information
    IMAGE_DATA_DIRECTORY    CodeManagerTable;
    IMAGE_DATA_DIRECTORY    VTableFixups;
    IMAGE_DATA_DIRECTORY    ExportAddressTableJumps;

    // Precompiled image info (internal use only - set to zero)
    IMAGE_DATA_DIRECTORY    ManagedNativeHeader;
    
} IMAGE_COR20_HEADER, *PIMAGE_COR20_HEADER;

#else // !__IMAGE_COR20_HEADER_DEFINED__

// <TODO>@TODO: This hack is required because we pull in the COM+ 2.0 PE header - todo in sdk
// definition from winnt.h, and the constant below hasn't propogated yet.</TODO>
#define COR_VTABLE_FROM_UNMANAGED_RETAIN_APPDOMAIN 0x08

#endif // __IMAGE_COR20_HEADER_DEFINED__

*)
// The most recent version.
const
  COR_CTOR_METHOD_NAME        = '.ctor';
  {$EXTERNALSYM COR_CTOR_METHOD_NAME}
  COR_CTOR_METHOD_NAME_W      = '.ctor';
  {$EXTERNALSYM COR_CTOR_METHOD_NAME_W}
  COR_CCTOR_METHOD_NAME       = '.cctor';
  {$EXTERNALSYM COR_CCTOR_METHOD_NAME}
  COR_CCTOR_METHOD_NAME_W     = '.cctor';
  {$EXTERNALSYM COR_CCTOR_METHOD_NAME_W}

  COR_ENUM_FIELD_NAME         = 'value__';
  {$EXTERNALSYM COR_ENUM_FIELD_NAME}
  COR_ENUM_FIELD_NAME_W       = 'value__';
  {$EXTERNALSYM COR_ENUM_FIELD_NAME_W}

  // The predefined name for deleting a typeDef,MethodDef, FieldDef, Property and Event
  COR_DELETED_NAME_A          = '_Deleted';
  {$EXTERNALSYM COR_DELETED_NAME_A}
  COR_DELETED_NAME_W          = '_Deleted';
  {$EXTERNALSYM COR_DELETED_NAME_W}
  COR_VTABLEGAP_NAME_A        = '_VtblGap';
  {$EXTERNALSYM COR_VTABLEGAP_NAME_A}
  COR_VTABLEGAP_NAME_W        = '_VtblGap';
  {$EXTERNALSYM COR_VTABLEGAP_NAME_W}

(*
  // We intentionally use strncmp so that we will ignore any suffix
  #define IsDeletedName(strName)      (strncmp(strName, COR_DELETED_NAME_A, COR_DELETED_NAME_LENGTH) == 0)
  #define IsVtblGapName(strName)      (strncmp(strName, COR_VTABLEGAP_NAME_A, COR_VTABLEGAP_NAME_LENGTH) == 0)
*)
type
// TypeDef/ExportedType attr bits, used by DefineTypeDef.
  CorTypeAttr = type DWORD;
  {$EXTERNALSYM CorTypeAttr}

const
  // Use this mask to retrieve the type visibility information.
  tdVisibilityMask        =   CorTypeAttr($00000007);
  {$EXTERNALSYM tdVisibilityMask}
  tdNotPublic             =   CorTypeAttr($00000000);     // Class is not public scope.
  {$EXTERNALSYM tdNotPublic}
  tdPublic                =   CorTypeAttr($00000001);     // Class is public scope.
  {$EXTERNALSYM tdPublic}
  tdNestedPublic          =   CorTypeAttr($00000002);     // Class is nested with public visibility.
  {$EXTERNALSYM tdNestedPublic}
  tdNestedPrivate         =   CorTypeAttr($00000003);     // Class is nested with private visibility.
  {$EXTERNALSYM tdNestedPrivate}
  tdNestedFamily          =   CorTypeAttr($00000004);     // Class is nested with family visibility.
  {$EXTERNALSYM tdNestedFamily}
  tdNestedAssembly        =   CorTypeAttr($00000005);     // Class is nested with assembly visibility.
  {$EXTERNALSYM tdNestedAssembly}
  tdNestedFamANDAssem     =   CorTypeAttr($00000006);     // Class is nested with family and assembly visibility.
  {$EXTERNALSYM tdNestedFamANDAssem}
  tdNestedFamORAssem      =   CorTypeAttr($00000007);     // Class is nested with family or assembly visibility.
  {$EXTERNALSYM tdNestedFamORAssem}

  // Use this mask to retrieve class layout information
  tdLayoutMask            =   CorTypeAttr($00000018);
  {$EXTERNALSYM tdLayoutMask}
  tdAutoLayout            =   CorTypeAttr($00000000);     // Class fields are auto-laid out
  {$EXTERNALSYM tdAutoLayout}
  tdSequentialLayout      =   CorTypeAttr($00000008);     // Class fields are laid out sequentially
  {$EXTERNALSYM tdSequentialLayout}
  tdExplicitLayout        =   CorTypeAttr($00000010);     // Layout is supplied explicitly
  {$EXTERNALSYM tdExplicitLayout}
  // end layout mask

  // Use this mask to retrieve class semantics information.
  tdClassSemanticsMask    =   CorTypeAttr($00000060);
  {$EXTERNALSYM tdClassSemanticsMask}
  tdClass                 =   CorTypeAttr($00000000);     // Type is a class.
  {$EXTERNALSYM tdClass}
  tdInterface             =   CorTypeAttr($00000020);     // Type is an interface.
  {$EXTERNALSYM tdInterface}
  // end semantics mask

  // Special semantics in addition to class semantics.
  tdAbstract              =   CorTypeAttr($00000080);     // Class is abstract
  {$EXTERNALSYM tdAbstract}
  tdSealed                =   CorTypeAttr($00000100);     // Class is concrete and may not be extended
  {$EXTERNALSYM tdSealed}
  tdSpecialName           =   CorTypeAttr($00000400);     // Class name is special.  Name describes how.
  {$EXTERNALSYM tdSpecialName}

  // Implementation attributes.
  tdImport                =   CorTypeAttr($00001000);     // Class / interface is imported
  {$EXTERNALSYM tdImport}
  tdSerializable          =   CorTypeAttr($00002000);     // The class is Serializable.
  {$EXTERNALSYM tdSerializable}

  // Use tdStringFormatMask to retrieve string information for native interop
  tdStringFormatMask      =   CorTypeAttr($00030000);
  {$EXTERNALSYM tdStringFormatMask}
  tdAnsiClass             =   CorTypeAttr($00000000);     // LPTSTR is interpreted as ANSI in this class
  {$EXTERNALSYM tdAnsiClass}
  tdUnicodeClass          =   CorTypeAttr($00010000);     // LPTSTR is interpreted as UNICODE
  {$EXTERNALSYM tdUnicodeClass}
  tdAutoClass             =   CorTypeAttr($00020000);     // LPTSTR is interpreted automatically
  {$EXTERNALSYM tdAutoClass}
  tdCustomFormatClass     =   CorTypeAttr($00030000);     // A non-standard encoding specified by CustomFormatMask
  {$EXTERNALSYM tdCustomFormatClass}
  tdCustomFormatMask      =   CorTypeAttr($00C00000);     // Use this mask to retrieve non-standard encoding information for native interop. The meaning of the values of these 2 bits is unspecified.
  {$EXTERNALSYM tdCustomFormatMask}

  // end string format mask

  tdBeforeFieldInit       =   CorTypeAttr($00100000);     // Initialize the class any time before first static field access.
  {$EXTERNALSYM tdBeforeFieldInit}
  tdForwarder             =   CorTypeAttr($00200000);     // This ExportedType is a type forwarder.
  {$EXTERNALSYM tdForwarder}

  // Flags reserved for runtime use.
  tdReservedMask          =   CorTypeAttr($00040800);
  {$EXTERNALSYM tdReservedMask}
  tdRTSpecialName         =   CorTypeAttr($00000800);     // Runtime should check name encoding.
  {$EXTERNALSYM tdRTSpecialName}
  tdHasSecurity           =   CorTypeAttr($00040000);     // Class has security associate with it.
  {$EXTERNALSYM tdHasSecurity}

// Macros for accessing the members of the CorTypeAttr.
function IsTdNotPublic(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNotPublic}
function IsTdPublic(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdPublic}
function IsTdNestedPublic(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNestedPublic}
function IsTdNestedPrivate(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNestedPrivate}
function IsTdNestedFamily(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNestedFamily}
function IsTdNestedAssembly(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNestedAssembly}
function IsTdNestedFamANDAssem(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNestedFamANDAssem}
function IsTdNestedFamORAssem(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNestedFamORAssem}
function IsTdNested(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdNested}

function IsTdAutoLayout(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdAutoLayout}
function IsTdSequentialLayout(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdSequentialLayout}
function IsTdExplicitLayout(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdExplicitLayout}

function IsTdClass(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdClass}
function IsTdInterface(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdInterface}

function IsTdAbstract(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdAbstract}
function IsTdSealed(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdSealed}
function IsTdSpecialName(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdSpecialName}

function IsTdImport(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdImport}
function IsTdSerializable(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdSerializable}

function IsTdAnsiClass(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdAnsiClass}
function IsTdUnicodeClass(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdUnicodeClass}
function IsTdAutoClass(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdAutoClass}
function IsTdCustomFormatClass(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdCustomFormatClass}
function IsTdBeforeFieldInit(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdBeforeFieldInit}
function IsTdForwarder(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdForwarder}

function IsTdRTSpecialName(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdRTSpecialName}
function IsTdHasSecurity(x: CorTypeAttr): Boolean; inline;
{$EXTERNALSYM IsTdHasSecurity}

type
  // MethodDef attr bits, Used by DefineMethod.
  CorMethodAttr = type WORD;
  {$EXTERNALSYM CorMethodAttr}

const
  // member access mask - Use this mask to retrieve accessibility information.
  mdMemberAccessMask          =   CorMethodAttr($0007);
  {$EXTERNALSYM mdMemberAccessMask}
  mdPrivateScope              =   CorMethodAttr($0000);     // Member not referenceable.
  {$EXTERNALSYM mdPrivateScope}
  mdPrivate                   =   CorMethodAttr($0001);     // Accessible only by the parent type.
  {$EXTERNALSYM mdPrivate}
  mdFamANDAssem               =   CorMethodAttr($0002);     // Accessible by sub-types only in this Assembly.
  {$EXTERNALSYM mdFamANDAssem}
  mdAssem                     =   CorMethodAttr($0003);     // Accessibly by anyone in the Assembly.
  {$EXTERNALSYM mdAssem}
  mdFamily                    =   CorMethodAttr($0004);     // Accessible only by type and sub-types.
  {$EXTERNALSYM mdFamily}
  mdFamORAssem                =   CorMethodAttr($0005);     // Accessibly by sub-types anywhere, plus anyone in assembly.
  {$EXTERNALSYM mdFamORAssem}
  mdPublic                    =   CorMethodAttr($0006);     // Accessibly by anyone who has visibility to this scope.
  {$EXTERNALSYM mdPublic}
  // end member access mask

  // method contract attributes.
  mdStatic                    =   CorMethodAttr($0010);     // Defined on type, else per instance.
  {$EXTERNALSYM mdStatic}
  mdFinal                     =   CorMethodAttr($0020);     // Method may not be overridden.
  {$EXTERNALSYM mdFinal}
  mdVirtual                   =   CorMethodAttr($0040);     // Method virtual.
  {$EXTERNALSYM mdVirtual}
  mdHideBySig                 =   CorMethodAttr($0080);     // Method hides by name+sig, else just by name.
  {$EXTERNALSYM mdHideBySig}

  // vtable layout mask - Use this mask to retrieve vtable attributes.
  mdVtableLayoutMask          =   CorMethodAttr($0100);
  {$EXTERNALSYM mdVtableLayoutMask}
  mdReuseSlot                 =   CorMethodAttr($0000);     // The default.
  {$EXTERNALSYM mdReuseSlot}
  mdNewSlot                   =   CorMethodAttr($0100);     // Method always gets a new slot in the vtable.
  {$EXTERNALSYM mdNewSlot}
  // end vtable layout mask

  // method implementation attributes.
  mdCheckAccessOnOverride     =   CorMethodAttr($0200);     // Overridability is the same as the visibility.
  {$EXTERNALSYM mdCheckAccessOnOverride}
  mdAbstract                  =   CorMethodAttr($0400);     // Method does not provide an implementation.
  {$EXTERNALSYM mdAbstract}
  mdSpecialName               =   CorMethodAttr($0800);     // Method is special.  Name describes how.
  {$EXTERNALSYM mdSpecialName}

  // interop attributes
  mdPinvokeImpl               =   CorMethodAttr($2000);     // Implementation is forwarded through pinvoke.
  {$EXTERNALSYM mdPinvokeImpl}
  mdUnmanagedExport           =   CorMethodAttr($0008);     // Managed method exported via thunk to unmanaged code.
  {$EXTERNALSYM mdUnmanagedExport}

  // Reserved flags for runtime use only.
  mdReservedMask              =   CorMethodAttr($d000);
  {$EXTERNALSYM mdReservedMask}
  mdRTSpecialName             =   CorMethodAttr($1000);     // Runtime should check name encoding.
  {$EXTERNALSYM mdRTSpecialName}
  mdHasSecurity               =   CorMethodAttr($4000);     // Method has security associate with it.
  {$EXTERNALSYM mdHasSecurity}
  mdRequireSecObject          =   CorMethodAttr($8000);     // Method calls another method containing security code.
  {$EXTERNALSYM mdRequireSecObject}

// Macros for accessing the members of CorMethodAttr.
function IsMdPrivateScope(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdPrivateScope}
function IsMdPrivate(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdPrivate}
function IsMdFamANDAssem(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdFamANDAssem}
function IsMdAssem(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdAssem}
function IsMdFamily(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdFamily}
function IsMdFamORAssem(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdFamORAssem}
function IsMdPublic(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdPublic}

function IsMdStatic(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdStatic}
function IsMdFinal(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdFinal}
function IsMdVirtual(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdVirtual}
function IsMdHideBySig(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdHideBySig}

function IsMdReuseSlot(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdReuseSlot}
function IsMdNewSlot(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdNewSlot}

function IsMdCheckAccessOnOverride(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdCheckAccessOnOverride}
function IsMdAbstract(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdAbstract}
function IsMdSpecialName(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdSpecialName}

function IsMdPinvokeImpl(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdPinvokeImpl}
function IsMdUnmanagedExport(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdUnmanagedExport}

function IsMdRTSpecialName(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdRTSpecialName}
//#define IsMdInstanceInitializer(x, str)     (((x) & mdRTSpecialName) && !strcmp((str), COR_CTOR_METHOD_NAME))
//#define IsMdInstanceInitializerW(x, str)    (((x) & mdRTSpecialName) && !wcscmp((str), COR_CTOR_METHOD_NAME_W))
//#define IsMdClassConstructor(x, str)        (((x) & mdRTSpecialName) && !strcmp((str), COR_CCTOR_METHOD_NAME))
//#define IsMdClassConstructorW(x, str)       (((x) & mdRTSpecialName) && !wcscmp((str), COR_CCTOR_METHOD_NAME_W))
function IsMdHasSecurity(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdHasSecurity}
function IsMdRequireSecObject(x: CorMethodAttr): Boolean; inline;
{$EXTERNALSYM IsMdRequireSecObject}

type
  // FieldDef attr bits, used by DefineField.
  CorFieldAttr = type WORD;
  {$EXTERNALSYM CorFieldAttr}

const
  // member access mask - Use this mask to retrieve accessibility information.
  fdFieldAccessMask           =   CorFieldAttr($0007);
  {$EXTERNALSYM fdFieldAccessMask}
  fdPrivateScope              =   CorFieldAttr($0000);     // Member not referenceable.
  {$EXTERNALSYM fdPrivateScope}
  fdPrivate                   =   CorFieldAttr($0001);     // Accessible only by the parent type.
  {$EXTERNALSYM fdPrivate}
  fdFamANDAssem               =   CorFieldAttr($0002);     // Accessible by sub-types only in this Assembly.
  {$EXTERNALSYM fdFamANDAssem}
  fdAssembly                  =   CorFieldAttr($0003);     // Accessibly by anyone in the Assembly.
  {$EXTERNALSYM fdAssembly}
  fdFamily                    =   CorFieldAttr($0004);     // Accessible only by type and sub-types.
  {$EXTERNALSYM fdFamily}
  fdFamORAssem                =   CorFieldAttr($0005);     // Accessibly by sub-types anywhere, plus anyone in assembly.
  {$EXTERNALSYM fdFamORAssem}
  fdPublic                    =   CorFieldAttr($0006);     // Accessibly by anyone who has visibility to this scope.
  {$EXTERNALSYM fdPublic}
  // end member access mask

  // field contract attributes.
  fdStatic                    =   CorFieldAttr($0010);     // Defined on type, else per instance.
  {$EXTERNALSYM fdStatic}
  fdInitOnly                  =   CorFieldAttr($0020);     // Field may only be initialized, not written to after init.
  {$EXTERNALSYM fdInitOnly}
  fdLiteral                   =   CorFieldAttr($0040);     // Value is compile time constant.
  {$EXTERNALSYM fdLiteral}
  fdNotSerialized             =   CorFieldAttr($0080);     // Field does not have to be serialized when type is remoted.
  {$EXTERNALSYM fdNotSerialized}

  fdSpecialName               =   CorFieldAttr($0200);     // field is special.  Name describes how.
  {$EXTERNALSYM fdSpecialName}

  // interop attributes
  fdPinvokeImpl               =   CorFieldAttr($2000);     // Implementation is forwarded through pinvoke.
  {$EXTERNALSYM fdPinvokeImpl}

  // Reserved flags for runtime use only.
  fdReservedMask              =   CorFieldAttr($9500);
  {$EXTERNALSYM fdReservedMask}
  fdRTSpecialName             =   CorFieldAttr($0400);     // Runtime(metadata internal APIs) should check name encoding.
  {$EXTERNALSYM fdRTSpecialName}
  fdHasFieldMarshal           =   CorFieldAttr($1000);     // Field has marshalling information.
  {$EXTERNALSYM fdHasFieldMarshal}
  fdHasDefault                =   CorFieldAttr($8000);     // Field has default.
  {$EXTERNALSYM fdHasDefault}
  fdHasFieldRVA               =   CorFieldAttr($0100);     // Field has RVA.
  {$EXTERNALSYM fdHasFieldRVA}

// Macros for accessing the members of CorFieldAttr.
function IsFdPrivateScope(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdPrivateScope}
function IsFdPrivate(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdPrivate}
function IsFdFamANDAssem(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdFamANDAssem}
function IsFdAssembly(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdAssembly}
function IsFdFamily(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdFamily}
function IsFdFamORAssem(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdFamORAssem}
function IsFdPublic(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdPublic}

function IsFdStatic(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdStatic}
function IsFdInitOnly(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdInitOnly}
function IsFdLiteral(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdLiteral}
function IsFdNotSerialized(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdNotSerialized}

function IsFdPinvokeImpl(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdPinvokeImpl}

function IsFdSpecialName(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdSpecialName}
function IsFdHasFieldRVA(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdHasFieldRVA}
function IsFdRTSpecialName(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdRTSpecialName}
function IsFdHasFieldMarshal(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdHasFieldMarshal}
function IsFdHasDefault(x: CorFieldAttr): Boolean; inline;
{$EXTERNALSYM IsFdHasDefault}

type
  // Param attr bits, used by DefineParam.
  CorParamAttr = type WORD;
  {$EXTERNALSYM CorParamAttr}

const
  pdIn                        =   CorParamAttr($0001);     // Param is [In]
  {$EXTERNALSYM pdIn}
  pdOut                       =   CorParamAttr($0002);     // Param is [out]
  {$EXTERNALSYM pdOut}
  pdOptional                  =   CorParamAttr($0010);     // Param is optional
  {$EXTERNALSYM pdOptional}

  // Reserved flags for Runtime use only.
  pdReservedMask              =   CorParamAttr($f000);
  {$EXTERNALSYM pdReservedMask}
  pdHasDefault                =   CorParamAttr($1000);     // Param has default value.
  {$EXTERNALSYM pdHasDefault}
  pdHasFieldMarshal           =   CorParamAttr($2000);     // Param has FieldMarshal.
  {$EXTERNALSYM pdHasFieldMarshal}

  pdUnused                    =   CorParamAttr($cfe0);
  {$EXTERNALSYM pdUnused}

// Macros for accessing the members of CorParamAttr.
function IsPdIn(x: CorParamAttr): Boolean; inline;
{$EXTERNALSYM IsPdIn}
function IsPdOut(x: CorParamAttr): Boolean; inline;
{$EXTERNALSYM IsPdOut}
function IsPdOptional(x: CorParamAttr): Boolean; inline;
{$EXTERNALSYM IsPdOptional}

function IsPdHasDefault(x: CorParamAttr): Boolean; inline;
{$EXTERNALSYM IsPdHasDefault}
function IsPdHasFieldMarshal(x: CorParamAttr): Boolean; inline;
{$EXTERNALSYM IsPdHasFieldMarshal}

type
  // Property attr bits, used by DefineProperty.
  CorPropertyAttr = type WORD;
  {$EXTERNALSYM CorPropertyAttr}

const
  prSpecialName           =   CorPropertyAttr($0200);     // property is special.  Name describes how.
  {$EXTERNALSYM prSpecialName}

  // Reserved flags for Runtime use only.
  prReservedMask          =   CorPropertyAttr($f400);
  {$EXTERNALSYM prReservedMask}
  prRTSpecialName         =   CorPropertyAttr($0400);     // Runtime(metadata internal APIs) should check name encoding.
  {$EXTERNALSYM prRTSpecialName}
  prHasDefault            =   CorPropertyAttr($1000);     // Property has default
  {$EXTERNALSYM prHasDefault}

  prUnused                =   CorPropertyAttr($e9ff);
  {$EXTERNALSYM prUnused}

// Macros for accessing the members of CorPropertyAttr.
function IsPrSpecialName(x: CorPropertyAttr): Boolean; inline;
{$EXTERNALSYM IsPrSpecialName}

function IsPrRTSpecialName(x: CorPropertyAttr): Boolean; inline;
{$EXTERNALSYM IsPrRTSpecialName}
function IsPrHasDefault(x: CorPropertyAttr): Boolean; inline;
{$EXTERNALSYM IsPrHasDefault}

type
  // Event attr bits, used by DefineEvent.
  CorEventAttr = type WORD;
  {$EXTERNALSYM CorEventAttr}

const
  evSpecialName           =   CorEventAttr($0200);     // event is special.  Name describes how.
  {$EXTERNALSYM evSpecialName}

  // Reserved flags for Runtime use only.
  evReservedMask          =   CorEventAttr($0400);
  {$EXTERNALSYM evReservedMask}
  evRTSpecialName         =   CorEventAttr($0400);     // Runtime(metadata internal APIs) should check name encoding.
  {$EXTERNALSYM evRTSpecialName}

// Macros for accessing the members of CorEventAttr.
function IsEvSpecialName(x: CorEventAttr): Boolean; inline;
{$EXTERNALSYM IsEvSpecialName}

function IsEvRTSpecialName(x: CorEventAttr): Boolean; inline;
{$EXTERNALSYM IsEvRTSpecialName}

type
  // MethodSemantic attr bits, used by DefineProperty, DefineEvent.
  CorMethodSemanticsAttr = type WORD;
  {$EXTERNALSYM CorMethodSemanticsAttr}

const
  msSetter    =   CorMethodSemanticsAttr($0001);     // Setter for property
  {$EXTERNALSYM msSetter}
  msGetter    =   CorMethodSemanticsAttr($0002);     // Getter for property
  {$EXTERNALSYM msGetter}
  msOther     =   CorMethodSemanticsAttr($0004);     // other method for property or event
  {$EXTERNALSYM msOther}
  msAddOn     =   CorMethodSemanticsAttr($0008);     // AddOn method for event
  {$EXTERNALSYM msAddOn}
  msRemoveOn  =   CorMethodSemanticsAttr($0010);     // RemoveOn method for event
  {$EXTERNALSYM msRemoveOn}
  msFire      =   CorMethodSemanticsAttr($0020);     // Fire method for event
  {$EXTERNALSYM msFire}

// Macros for accessing the members of CorMethodSemanticsAttr.
function IsMsSetter(x: CorMethodSemanticsAttr): Boolean; inline;
{$EXTERNALSYM IsMsSetter}
function IsMsGetter(x: CorMethodSemanticsAttr): Boolean; inline;
{$EXTERNALSYM IsMsGetter}
function IsMsOther(x: CorMethodSemanticsAttr): Boolean; inline;
{$EXTERNALSYM IsMsOther}
function IsMsAddOn(x: CorMethodSemanticsAttr): Boolean; inline;
{$EXTERNALSYM IsMsAddOn}
function IsMsRemoveOn(x: CorMethodSemanticsAttr): Boolean; inline;
{$EXTERNALSYM IsMsRemoveOn}
function IsMsFire(x: CorMethodSemanticsAttr): Boolean; inline;
{$EXTERNALSYM IsMsFire}

type
  // DeclSecurity attr bits, used by DefinePermissionSet.
  CorDeclSecurity = type WORD;
  {$EXTERNALSYM CorDeclSecurity}

const
  dclActionMask               =   CorDeclSecurity($001f);     // Mask allows growth of enum.
  {$EXTERNALSYM dclActionMask}
  dclActionNil                =   CorDeclSecurity($0000);     //
  {$EXTERNALSYM dclActionNil}
  dclRequest                  =   CorDeclSecurity($0001);     //
  {$EXTERNALSYM dclRequest}
  dclDemand                   =   CorDeclSecurity($0002);     //
  {$EXTERNALSYM dclDemand}
  dclAssert                   =   CorDeclSecurity($0003);     //
  {$EXTERNALSYM dclAssert}
  dclDeny                     =   CorDeclSecurity($0004);     //
  {$EXTERNALSYM dclDeny}
  dclPermitOnly               =   CorDeclSecurity($0005);     //
  {$EXTERNALSYM dclPermitOnly}
  dclLinktimeCheck            =   CorDeclSecurity($0006);     //
  {$EXTERNALSYM dclLinktimeCheck}
  dclInheritanceCheck         =   CorDeclSecurity($0007);     //
  {$EXTERNALSYM dclInheritanceCheck}
  dclRequestMinimum           =   CorDeclSecurity($0008);     //
  {$EXTERNALSYM dclRequestMinimum}
  dclRequestOptional          =   CorDeclSecurity($0009);     //
  {$EXTERNALSYM dclRequestOptional}
  dclRequestRefuse            =   CorDeclSecurity($000a);     //
  {$EXTERNALSYM dclRequestRefuse}
  dclPrejitGrant              =   CorDeclSecurity($000b);     // Persisted grant set at prejit time
  {$EXTERNALSYM dclPrejitGrant}
  dclPrejitDenied             =   CorDeclSecurity($000c);     // Persisted denied set at prejit time
  {$EXTERNALSYM dclPrejitDenied}
  dclNonCasDemand             =   CorDeclSecurity($000d);     //
  {$EXTERNALSYM dclNonCasDemand}
  dclNonCasLinkDemand         =   CorDeclSecurity($000e);     //
  {$EXTERNALSYM dclNonCasLinkDemand}
  dclNonCasInheritance        =   CorDeclSecurity($000f);     //
  {$EXTERNALSYM dclNonCasInheritance}
  dclMaximumValue             =   CorDeclSecurity($000f);     // Maximum legal value
  {$EXTERNALSYM dclMaximumValue}

// Macros for accessing the members of CorDeclSecurity.
function IsDclActionNil(x: CorDeclSecurity): Boolean; inline;
{$EXTERNALSYM IsDclActionNil}
// Is this a demand that can trigger a stackwalk?
function IsDclActionAnyStackModifier(x: CorDeclSecurity): Boolean; inline;
{$EXTERNALSYM IsDclActionAnyStackModifier}

type
  // MethodImpl attr bits, used by DefineMethodImpl.
  CorMethodImpl = type WORD;
  {$EXTERNALSYM CorMethodImpl}

const
  // code impl mask
  miCodeTypeMask      =   CorMethodImpl($0003);   // Flags about code type.
  {$EXTERNALSYM miCodeTypeMask}
  miIL                =   CorMethodImpl($0000);   // Method impl is IL.
  {$EXTERNALSYM miIL}
  miNative            =   CorMethodImpl($0001);   // Method impl is native.
  {$EXTERNALSYM miNative}
  miOPTIL             =   CorMethodImpl($0002);   // Method impl is OPTIL
  {$EXTERNALSYM miOPTIL}
  miRuntime           =   CorMethodImpl($0003);   // Method impl is provided by the runtime.
  {$EXTERNALSYM miRuntime}
  // end code impl mask

  // managed mask
  miManagedMask       =   CorMethodImpl($0004);   // Flags specifying whether the code is managed or unmanaged.
  {$EXTERNALSYM miManagedMask}
  miUnmanaged         =   CorMethodImpl($0004);   // Method impl is unmanaged, otherwise managed.
  {$EXTERNALSYM miUnmanaged}
  miManaged           =   CorMethodImpl($0000);   // Method impl is managed.
  {$EXTERNALSYM miManaged}
  // end managed mask

  // implementation info and interop
  miForwardRef        =   CorMethodImpl($0010);   // Indicates method is defined; used primarily in merge scenarios.
  {$EXTERNALSYM miForwardRef}
  miPreserveSig       =   CorMethodImpl($0080);   // Indicates method sig is not to be mangled to do HRESULT conversion.
  {$EXTERNALSYM miPreserveSig}

  miInternalCall      =   CorMethodImpl($1000);   // Reserved for internal use.
  {$EXTERNALSYM miInternalCall}

  miSynchronized      =   CorMethodImpl($0020);   // Method is single threaded through the body.
  {$EXTERNALSYM miSynchronized}
  miNoInlining        =   CorMethodImpl($0008);   // Method may not be inlined.
  {$EXTERNALSYM miNoInlining}
  miMaxMethodImplVal  =   CorMethodImpl($ffff);   // Range check value
  {$EXTERNALSYM miMaxMethodImplVal}

// Macros for accesing the members of CorMethodImpl.
function IsMiIL(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiIL}
function IsMiNative(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiNative}
function IsMiOPTIL(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiOPTIL}
function IsMiRuntime(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiRuntime}

function IsMiUnmanaged(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiUnmanaged}
function IsMiManaged(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiManaged}

function IsMiForwardRef(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiForwardRef}
function IsMiPreserveSig(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiPreserveSig}

function IsMiInternalCall(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiInternalCall}

function IsMiSynchronized(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiSynchronized}
function IsMiNoInlining(x: CorMethodImpl): Boolean; inline;
{$EXTERNALSYM IsMiNoInlining}

type
  // PinvokeMap attr bits, used by DefinePinvokeMap.
  CorPinvokeMap = type WORD;
  {$EXTERNALSYM CorPinvokeMap}

const
  pmNoMangle          = CorPInvokeMap($0001);   // Pinvoke is to use the member name as specified.
  {$EXTERNALSYM pmNoMangle}

  // Use this mask to retrieve the CharSet information.
  pmCharSetMask       = CorPInvokeMap($0006);
  {$EXTERNALSYM pmCharSetMask}
  pmCharSetNotSpec    = CorPInvokeMap($0000);
  {$EXTERNALSYM pmCharSetNotSpec}
  pmCharSetAnsi       = CorPInvokeMap($0002);
  {$EXTERNALSYM pmCharSetAnsi}
  pmCharSetUnicode    = CorPInvokeMap($0004);
  {$EXTERNALSYM pmCharSetUnicode}
  pmCharSetAuto       = CorPInvokeMap($0006);
  {$EXTERNALSYM pmCharSetAuto}

  pmBestFitUseAssem   = CorPInvokeMap($0000);
  {$EXTERNALSYM pmBestFitUseAssem}
  pmBestFitEnabled    = CorPInvokeMap($0010);
  {$EXTERNALSYM pmBestFitEnabled}
  pmBestFitDisabled   = CorPInvokeMap($0020);
  {$EXTERNALSYM pmBestFitDisabled}
  pmBestFitMask       = CorPInvokeMap($0030);
  {$EXTERNALSYM pmBestFitMask}

  pmThrowOnUnmappableCharUseAssem   = CorPInvokeMap($0000);
  {$EXTERNALSYM pmThrowOnUnmappableCharUseAssem}
  pmThrowOnUnmappableCharEnabled    = CorPInvokeMap($1000);
  {$EXTERNALSYM pmThrowOnUnmappableCharEnabled}
  pmThrowOnUnmappableCharDisabled   = CorPInvokeMap($2000);
  {$EXTERNALSYM pmThrowOnUnmappableCharDisabled}
  pmThrowOnUnmappableCharMask       = CorPInvokeMap($3000);
  {$EXTERNALSYM pmThrowOnUnmappableCharMask}

  pmSupportsLastError = CorPInvokeMap($0040);   // Information about target function. Not relevant for fields.
  {$EXTERNALSYM pmSupportsLastError}

  // None of the calling convention flags is relevant for fields.
  pmCallConvMask      = CorPInvokeMap($0700);
  {$EXTERNALSYM pmCallConvMask}
  pmCallConvWinapi    = CorPInvokeMap($0100);   // Pinvoke will use native callconv appropriate to target windows platform.
  {$EXTERNALSYM pmCallConvWinapi}
  pmCallConvCdecl     = CorPInvokeMap($0200);
  {$EXTERNALSYM pmCallConvCdecl}
  pmCallConvStdcall   = CorPInvokeMap($0300);
  {$EXTERNALSYM pmCallConvStdcall}
  pmCallConvThiscall  = CorPInvokeMap($0400);   // In M9, pinvoke will raise exception.
  {$EXTERNALSYM pmCallConvThiscall}
  pmCallConvFastcall  = CorPInvokeMap($0500);
  {$EXTERNALSYM pmCallConvFastcall}

  pmMaxValue          = CorPInvokeMap($FFFF);
  {$EXTERNALSYM pmMaxValue}

// Macros for accessing the members of CorPinvokeMap
function IsPmNoMangle(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmNoMangle}

function IsPmCharSetNotSpec(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCharSetNotSpec}
function IsPmCharSetAnsi(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCharSetAnsi}
function IsPmCharSetUnicode(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCharSetUnicode}
function IsPmCharSetAuto(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCharSetAuto}

function IsPmSupportsLastError(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmSupportsLastError}

function IsPmCallConvWinapi(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCallConvWinapi}
function IsPmCallConvCdecl(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCallConvCdecl}
function IsPmCallConvStdcall(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCallConvStdcall}
function IsPmCallConvThiscall(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCallConvThiscall}
function IsPmCallConvFastcall(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmCallConvFastcall}

function IsPmBestFitEnabled(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmBestFitEnabled}
function IsPmBestFitDisabled(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmBestFitDisabled}
function IsPmBestFitUseAssem(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmBestFitUseAssem}

function IsPmThrowOnUnmappableCharEnabled(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmThrowOnUnmappableCharEnabled}
function IsPmThrowOnUnmappableCharDisabled(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmThrowOnUnmappableCharDisabled}
function IsPmThrowOnUnmappableCharUseAssem(x: CorPInvokeMap): Boolean; inline;
{$EXTERNALSYM IsPmThrowOnUnmappableCharUseAssem}

type
  // Assembly attr bits, used by DefineAssembly.
  CorAssemblyFlags = type WORD;
  {$EXTERNALSYM CorAssemblyFlags}

const
  afPublicKey             =   CorAssemblyFlags($0001);     // The assembly ref holds the full (unhashed) public key.
  {$EXTERNALSYM afPublicKey}

  afPA_None               =   CorAssemblyFlags($0000);     // Processor Architecture unspecified
  {$EXTERNALSYM afPA_None}
  afPA_MSIL               =   CorAssemblyFlags($0010);     // Processor Architecture: neutral (PE32)
  {$EXTERNALSYM afPA_MSIL}
  afPA_x86                =   CorAssemblyFlags($0020);     // Processor Architecture: x86 (PE32)
  {$EXTERNALSYM afPA_x86}
  afPA_IA64               =   CorAssemblyFlags($0030);     // Processor Architecture: Itanium (PE32+)
  {$EXTERNALSYM afPA_IA64}
  afPA_AMD64              =   CorAssemblyFlags($0040);     // Processor Architecture: AMD X64 (PE32+)
  {$EXTERNALSYM afPA_AMD64}
  afPA_Specified          =   CorAssemblyFlags($0080);     // Propagate PA flags to AssemblyRef record
  {$EXTERNALSYM afPA_Specified}
  afPA_Mask               =   CorAssemblyFlags($0070);     // Bits describing the processor architecture
  {$EXTERNALSYM afPA_Mask}
  afPA_FullMask           =   CorAssemblyFlags($00F0);     // Bits describing the PA incl. Specified
  {$EXTERNALSYM afPA_FullMask}
  afPA_Shift              =   CorAssemblyFlags($0004);     // NOT A FLAG, shift count in PA flags <--> index conversion
  {$EXTERNALSYM afPA_Shift}

  afEnableJITcompileTracking  =   CorAssemblyFlags($8000); // From "DebuggableAttribute".
  {$EXTERNALSYM afEnableJITcompileTracking}
  afDisableJITcompileOptimizer=   CorAssemblyFlags($4000); // From "DebuggableAttribute".
  {$EXTERNALSYM afDisableJITcompileOptimizer}

  afRetargetable          =   CorAssemblyFlags($0100);     // The assembly can be retargeted (at runtime) to an
  {$EXTERNALSYM afRetargetable}
                                                           //  assembly from a different publisher.

// Macros for accessing the members of CorAssemblyFlags.
function IsAfRetargetable(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfRetargetable}

// Macros for accessing the Processor Architecture flags of CorAssemblyFlags.
function IsAfPA_MSIL(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfPA_MSIL}
function IsAfPA_x86(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfPA_x86}
function IsAfPA_IA64(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfPA_IA64}
function IsAfPA_AMD64(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfPA_AMD64}
function IsAfPA_Specified(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfPA_Specified}
function PAIndex(x: CorAssemblyFlags): CorAssemblyFlags; inline;
{$EXTERNALSYM PAIndex}
function PAFlag(x: CorAssemblyFlags): CorAssemblyFlags; inline;
{$EXTERNALSYM PAFlag}
//#define PrepareForSaving(x) ((x) & (((x) & afPA_Specified) ? ~afPA_Specified : ~afPA_FullMask))

function IsAfEnableJITcompileTracking(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfEnableJITcompileTracking}
function IsAfDisableJITcompileOptimizer(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfDisableJITcompileOptimizer}

// Macros for accessing the public key flags of CorAssemblyFlags.
function IsAfPublicKey(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfPublicKey}
function IsAfPublicKeyToken(x: CorAssemblyFlags): Boolean; inline;
{$EXTERNALSYM IsAfPublicKeyToken}

type
  // ManifestResource attr bits, used by DefineManifestResource.
  CorManifestResourceFlags = type WORD;
  {$EXTERNALSYM CorManifestResourceFlags}

const
  mrVisibilityMask        =   CorManifestResourceFlags($0007);
  {$EXTERNALSYM mrVisibilityMask}
  mrPublic                =   CorManifestResourceFlags($0001);     // The Resource is exported from the Assembly.
  {$EXTERNALSYM mrPublic}
  mrPrivate               =   CorManifestResourceFlags($0002);     // The Resource is private to the Assembly.
  {$EXTERNALSYM mrPrivate}

// Macros for accessing the members of CorManifestResourceFlags.
function IsMrPublic(x: CorManifestResourceFlags): Boolean; inline;
{$EXTERNALSYM IsMrPublic}
function IsMrPrivate(x: CorManifestResourceFlags): Boolean; inline;
{$EXTERNALSYM IsMrPrivate}

type
  // File attr bits, used by DefineFile.
  CorFileFlags = type WORD;
  {$EXTERNALSYM CorFileFlags}

const
  ffContainsMetaData      =   CorFileFlags($0000);     // This is not a resource file
  {$EXTERNALSYM ffContainsMetaData}
  ffContainsNoMetaData    =   CorFileFlags($0001);     // This is a resource file or other non-metadata-containing file
  {$EXTERNALSYM ffContainsNoMetaData}

// Macros for accessing the members of CorFileFlags.
function IsFfContainsMetaData(x: CorFileFlags): Boolean; inline;
{$EXTERNALSYM IsFfContainsMetaData}
function IsFfContainsNoMetaData(x: CorFileFlags): Boolean; inline;
{$EXTERNALSYM IsFfContainsNoMetaData}

type
  // PE file kind bits, returned by IMetaDataImport2::GetPEKind()
  CorPEKind = type DWORD;
  {$EXTERNALSYM CorPEKind}

const
  peNot       = CorPEKind($00000000);   // not a PE file
  {$EXTERNALSYM peNot}
  peILonly    = CorPEKind($00000001);   // flag IL_ONLY is set in COR header
  {$EXTERNALSYM peILonly}
  pe32BitRequired=CorPEKind($00000002);  // flag 32BIT_REQUIRED is set in COR header
  {$EXTERNALSYM pe32BitRequired}
  pe32Plus    = CorPEKind($00000004);   // PE32+ file (64 bit)
  {$EXTERNALSYM pe32Plus}
  pe32Unmanaged=CorPEKind($00000008);   // PE32 without COR header
  {$EXTERNALSYM pe32Unmanaged}

type
  // GenericParam bits, used by DefineGenericParam.
  CorGenericParamAttr = type WORD;
  {$EXTERNALSYM CorGenericParamAttr}

const
  // Variance of type parameters, only applicable to generic parameters
  // for generic interfaces and delegates
  gpVarianceMask          =   CorGenericParamAttr($0003);
  {$EXTERNALSYM gpVarianceMask}
  gpNonVariant            =   CorGenericParamAttr($0000);
  {$EXTERNALSYM gpNonVariant}
  gpCovariant             =   CorGenericParamAttr($0001);
  {$EXTERNALSYM gpCovariant}
  gpContravariant         =   CorGenericParamAttr($0002);
  {$EXTERNALSYM gpContravariant}

  // Special constraints, applicable to any type parameters
  gpSpecialConstraintMask =  CorGenericParamAttr($001C);
  {$EXTERNALSYM gpSpecialConstraintMask}
  gpNoSpecialConstraint   =   CorGenericParamAttr($0000);
  {$EXTERNALSYM gpNoSpecialConstraint}
  gpReferenceTypeConstraint = CorGenericParamAttr($0004);      // type argument must be a reference type
  {$EXTERNALSYM gpReferenceTypeConstraint}
  gpNotNullableValueTypeConstraint   =   CorGenericParamAttr($0008);      // type argument must be a value type but not Nullable
  {$EXTERNALSYM gpNotNullableValueTypeConstraint}
  gpDefaultConstructorConstraint = CorGenericParamAttr($0010); // type argument must have a public default constructor
  {$EXTERNALSYM gpDefaultConstructorConstraint}

type
  // structures and enums moved from COR.H
  COR_SIGNATURE = Byte;
  {$EXTERNALSYM COR_SIGNATURE}
  {$POINTERMATH ON}
  PCOR_SIGNATURE = ^COR_SIGNATURE;            // pointer to a cor sig.  Not void* so that
  {$EXTERNALSYM PCOR_SIGNATURE}
                                              // the bytes can be incremented easily
  PCCOR_SIGNATURE = ^COR_SIGNATURE;
  {$EXTERNALSYM PCCOR_SIGNATURE}

  MDUTF8CSTR = PAnsiChar;
  {$EXTERNALSYM MDUTF8CSTR}
  MDUTF8STR = PAnsiChar;
  {$EXTERNALSYM MDUTF8STR}
  {$POINTERMATH OFF}

//*****************************************************************************
//
// Element type for Cor signature
//
//*****************************************************************************

  CorElementType = Byte;
  {$EXTERNALSYM CorElementType}

const
  ELEMENT_TYPE_END            = $0;
  {$EXTERNALSYM ELEMENT_TYPE_END}
  ELEMENT_TYPE_VOID           = $1;
  {$EXTERNALSYM ELEMENT_TYPE_VOID}
  ELEMENT_TYPE_BOOLEAN        = $2;
  {$EXTERNALSYM ELEMENT_TYPE_BOOLEAN}
  ELEMENT_TYPE_CHAR           = $3;
  {$EXTERNALSYM ELEMENT_TYPE_CHAR}
  ELEMENT_TYPE_I1             = $4;
  {$EXTERNALSYM ELEMENT_TYPE_I1}
  ELEMENT_TYPE_U1             = $5;
  {$EXTERNALSYM ELEMENT_TYPE_U1}
  ELEMENT_TYPE_I2             = $6;
  {$EXTERNALSYM ELEMENT_TYPE_I2}
  ELEMENT_TYPE_U2             = $7;
  {$EXTERNALSYM ELEMENT_TYPE_U2}
  ELEMENT_TYPE_I4             = $8;
  {$EXTERNALSYM ELEMENT_TYPE_I4}
  ELEMENT_TYPE_U4             = $9;
  {$EXTERNALSYM ELEMENT_TYPE_U4}
  ELEMENT_TYPE_I8             = $a;
  {$EXTERNALSYM ELEMENT_TYPE_I8}
  ELEMENT_TYPE_U8             = $b;
  {$EXTERNALSYM ELEMENT_TYPE_U8}
  ELEMENT_TYPE_R4             = $c;
  {$EXTERNALSYM ELEMENT_TYPE_R4}
  ELEMENT_TYPE_R8             = $d;
  {$EXTERNALSYM ELEMENT_TYPE_R8}
  ELEMENT_TYPE_STRING         = $e;
  {$EXTERNALSYM ELEMENT_TYPE_STRING}

  // every type above PTR will be simple type
  ELEMENT_TYPE_PTR            = $f;      // PTR <type>
  {$EXTERNALSYM ELEMENT_TYPE_PTR}
  ELEMENT_TYPE_BYREF          = $10;     // BYREF <type>
  {$EXTERNALSYM ELEMENT_TYPE_BYREF}

  // Please use ELEMENT_TYPE_VALUETYPE. ELEMENT_TYPE_VALUECLASS is deprecated.
  ELEMENT_TYPE_VALUETYPE      = $11;     // VALUETYPE <class Token>
  {$EXTERNALSYM ELEMENT_TYPE_VALUETYPE}
  ELEMENT_TYPE_CLASS          = $12;     // CLASS <class Token>
  {$EXTERNALSYM ELEMENT_TYPE_CLASS}
  ELEMENT_TYPE_VAR            = $13;     // a class type variable VAR <U1>
  {$EXTERNALSYM ELEMENT_TYPE_VAR}
  ELEMENT_TYPE_ARRAY          = $14;     // MDARRAY <type> <rank> <bcount> <bound1> ... <lbcount> <lb1> ...
  {$EXTERNALSYM ELEMENT_TYPE_ARRAY}
  ELEMENT_TYPE_GENERICINST    = $15;     // GENERICINST <generic type> <argCnt> <arg1> ... <argn>
  {$EXTERNALSYM ELEMENT_TYPE_GENERICINST}
  ELEMENT_TYPE_TYPEDBYREF     = $16;     // TYPEDREF  (it takes no args) a typed referece to some other type
  {$EXTERNALSYM ELEMENT_TYPE_TYPEDBYREF}

  ELEMENT_TYPE_I              = $18;     // native integer size
  {$EXTERNALSYM ELEMENT_TYPE_I}
  ELEMENT_TYPE_U              = $19;     // native unsigned integer size
  {$EXTERNALSYM ELEMENT_TYPE_U}
  ELEMENT_TYPE_FNPTR          = $1B;     // FNPTR <complete sig for the function including calling convention>
  {$EXTERNALSYM ELEMENT_TYPE_FNPTR}
  ELEMENT_TYPE_OBJECT         = $1C;     // Shortcut for System.Object
  {$EXTERNALSYM ELEMENT_TYPE_OBJECT}
  ELEMENT_TYPE_SZARRAY        = $1D;     // Shortcut for single dimension zero lower bound array
  {$EXTERNALSYM ELEMENT_TYPE_SZARRAY}
                                         // SZARRAY <type>
  ELEMENT_TYPE_MVAR           = $1e;     // a method type variable MVAR <U1>
  {$EXTERNALSYM ELEMENT_TYPE_MVAR}

  // This is only for binding
  ELEMENT_TYPE_CMOD_REQD      = $1F;     // required C modifier : E_T_CMOD_REQD <mdTypeRef/mdTypeDef>
  {$EXTERNALSYM ELEMENT_TYPE_CMOD_REQD}
  ELEMENT_TYPE_CMOD_OPT       = $20;     // optional C modifier : E_T_CMOD_OPT <mdTypeRef/mdTypeDef>
  {$EXTERNALSYM ELEMENT_TYPE_CMOD_OPT}

  // This is for signatures generated internally (which will not be persisted in any way).
  ELEMENT_TYPE_INTERNAL       = $21;     // INTERNAL <typehandle>
  {$EXTERNALSYM ELEMENT_TYPE_INTERNAL}

  // Note that this is the max of base type excluding modifiers
  ELEMENT_TYPE_MAX            = $22;     // first invalid element type
  {$EXTERNALSYM ELEMENT_TYPE_MAX}

  ELEMENT_TYPE_MODIFIER       = $40;
  {$EXTERNALSYM ELEMENT_TYPE_MODIFIER}
  ELEMENT_TYPE_SENTINEL       = $01 or ELEMENT_TYPE_MODIFIER; // sentinel for varargs
  {$EXTERNALSYM ELEMENT_TYPE_SENTINEL}
  ELEMENT_TYPE_PINNED         = $05 or ELEMENT_TYPE_MODIFIER;
  {$EXTERNALSYM ELEMENT_TYPE_PINNED}
  ELEMENT_TYPE_R4_HFA         = $06 or ELEMENT_TYPE_MODIFIER; // used only internally for R4 HFA types
  {$EXTERNALSYM ELEMENT_TYPE_R4_HFA}
  ELEMENT_TYPE_R8_HFA         = $07 or ELEMENT_TYPE_MODIFIER; // used only internally for R8 HFA types
  {$EXTERNALSYM ELEMENT_TYPE_R8_HFA}

type
(*

//*****************************************************************************
//
// Serialization types for Custom attribute support
//
//*****************************************************************************

typedef enum CorSerializationType
{
    SERIALIZATION_TYPE_UNDEFINED    = 0,
    SERIALIZATION_TYPE_BOOLEAN      = ELEMENT_TYPE_BOOLEAN,
    SERIALIZATION_TYPE_CHAR         = ELEMENT_TYPE_CHAR,
    SERIALIZATION_TYPE_I1           = ELEMENT_TYPE_I1,
    SERIALIZATION_TYPE_U1           = ELEMENT_TYPE_U1,
    SERIALIZATION_TYPE_I2           = ELEMENT_TYPE_I2,
    SERIALIZATION_TYPE_U2           = ELEMENT_TYPE_U2,
    SERIALIZATION_TYPE_I4           = ELEMENT_TYPE_I4,
    SERIALIZATION_TYPE_U4           = ELEMENT_TYPE_U4,
    SERIALIZATION_TYPE_I8           = ELEMENT_TYPE_I8,
    SERIALIZATION_TYPE_U8           = ELEMENT_TYPE_U8,
    SERIALIZATION_TYPE_R4           = ELEMENT_TYPE_R4,
    SERIALIZATION_TYPE_R8           = ELEMENT_TYPE_R8,
    SERIALIZATION_TYPE_STRING       = ELEMENT_TYPE_STRING,
    SERIALIZATION_TYPE_SZARRAY      = ELEMENT_TYPE_SZARRAY, // Shortcut for single dimension zero lower bound array
    SERIALIZATION_TYPE_TYPE         = 0x50,
    SERIALIZATION_TYPE_TAGGED_OBJECT= 0x51,
    SERIALIZATION_TYPE_FIELD        = 0x53,
    SERIALIZATION_TYPE_PROPERTY     = 0x54,
    SERIALIZATION_TYPE_ENUM         = 0x55
} CorSerializationType;

//
// Calling convention flags.
//


typedef enum CorCallingConvention
{
    IMAGE_CEE_CS_CALLCONV_DEFAULT       = 0x0,

    IMAGE_CEE_CS_CALLCONV_VARARG        = 0x5,
    IMAGE_CEE_CS_CALLCONV_FIELD         = 0x6,
    IMAGE_CEE_CS_CALLCONV_LOCAL_SIG     = 0x7,
    IMAGE_CEE_CS_CALLCONV_PROPERTY      = 0x8,
    IMAGE_CEE_CS_CALLCONV_UNMGD         = 0x9,
    IMAGE_CEE_CS_CALLCONV_GENERICINST   = 0xa,  // generic method instantiation
    IMAGE_CEE_CS_CALLCONV_NATIVEVARARG  = 0xb,  // used ONLY for 64bit vararg PInvoke calls
    IMAGE_CEE_CS_CALLCONV_MAX           = 0xc,  // first invalid calling convention


        // The high bits of the calling convention convey additional info
    IMAGE_CEE_CS_CALLCONV_MASK      = 0x0f,  // Calling convention is bottom 4 bits
    IMAGE_CEE_CS_CALLCONV_HASTHIS   = 0x20,  // Top bit indicates a 'this' parameter
    IMAGE_CEE_CS_CALLCONV_EXPLICITTHIS = 0x40,  // This parameter is explicitly in the signature
    IMAGE_CEE_CS_CALLCONV_GENERIC   = 0x10,  // Generic method sig with explicit number of type arguments (precedes ordinary parameter count)
} CorCallingConvention;

#define IMAGE_CEE_CS_CALLCONV_INSTANTIATION IMAGE_CEE_CS_CALLCONV_GENERICINST

typedef enum CorUnmanagedCallingConvention
{
    IMAGE_CEE_UNMANAGED_CALLCONV_C         = 0x1,
    IMAGE_CEE_UNMANAGED_CALLCONV_STDCALL   = 0x2,
    IMAGE_CEE_UNMANAGED_CALLCONV_THISCALL  = 0x3,
    IMAGE_CEE_UNMANAGED_CALLCONV_FASTCALL  = 0x4,

    IMAGE_CEE_CS_CALLCONV_C         = IMAGE_CEE_UNMANAGED_CALLCONV_C,
    IMAGE_CEE_CS_CALLCONV_STDCALL   = IMAGE_CEE_UNMANAGED_CALLCONV_STDCALL,
    IMAGE_CEE_CS_CALLCONV_THISCALL  = IMAGE_CEE_UNMANAGED_CALLCONV_THISCALL,
    IMAGE_CEE_CS_CALLCONV_FASTCALL  = IMAGE_CEE_UNMANAGED_CALLCONV_FASTCALL,

} CorUnmanagedCallingConvention;


typedef enum CorArgType
{
    IMAGE_CEE_CS_END        = 0x0,
    IMAGE_CEE_CS_VOID       = 0x1,
    IMAGE_CEE_CS_I4         = 0x2,
    IMAGE_CEE_CS_I8         = 0x3,
    IMAGE_CEE_CS_R4         = 0x4,
    IMAGE_CEE_CS_R8         = 0x5,
    IMAGE_CEE_CS_PTR        = 0x6,
    IMAGE_CEE_CS_OBJECT     = 0x7,
    IMAGE_CEE_CS_STRUCT4    = 0x8,
    IMAGE_CEE_CS_STRUCT32   = 0x9,
    IMAGE_CEE_CS_BYVALUE    = 0xA,
} CorArgType;


//*****************************************************************************
//
// Native type for N-Direct
//
//*****************************************************************************

typedef enum CorNativeType
{
    NATIVE_TYPE_END         = 0x0,    //DEPRECATED
    NATIVE_TYPE_VOID        = 0x1,    //DEPRECATED
    NATIVE_TYPE_BOOLEAN     = 0x2,    // (4 byte boolean value: TRUE = non-zero, FALSE = 0)
    NATIVE_TYPE_I1          = 0x3,
    NATIVE_TYPE_U1          = 0x4,
    NATIVE_TYPE_I2          = 0x5,
    NATIVE_TYPE_U2          = 0x6,
    NATIVE_TYPE_I4          = 0x7,
    NATIVE_TYPE_U4          = 0x8,
    NATIVE_TYPE_I8          = 0x9,
    NATIVE_TYPE_U8          = 0xa,
    NATIVE_TYPE_R4          = 0xb,
    NATIVE_TYPE_R8          = 0xc,
    NATIVE_TYPE_SYSCHAR     = 0xd,    //DEPRECATED
    NATIVE_TYPE_VARIANT     = 0xe,    //DEPRECATED
    NATIVE_TYPE_CURRENCY    = 0xf,
    NATIVE_TYPE_PTR         = 0x10,   //DEPRECATED

    NATIVE_TYPE_DECIMAL     = 0x11,   //DEPRECATED
    NATIVE_TYPE_DATE        = 0x12,   //DEPRECATED
    NATIVE_TYPE_BSTR        = 0x13,   //COMINTEROP
    NATIVE_TYPE_LPSTR       = 0x14,
    NATIVE_TYPE_LPWSTR      = 0x15,
    NATIVE_TYPE_LPTSTR      = 0x16,
    NATIVE_TYPE_FIXEDSYSSTRING  = 0x17,
    NATIVE_TYPE_OBJECTREF   = 0x18,   //DEPRECATED
    NATIVE_TYPE_IUNKNOWN    = 0x19,   //COMINTEROP
    NATIVE_TYPE_IDISPATCH   = 0x1a,   //COMINTEROP
    NATIVE_TYPE_STRUCT      = 0x1b,
    NATIVE_TYPE_INTF        = 0x1c,   //COMINTEROP
    NATIVE_TYPE_SAFEARRAY   = 0x1d,   //COMINTEROP
    NATIVE_TYPE_FIXEDARRAY  = 0x1e,
    NATIVE_TYPE_INT         = 0x1f,
    NATIVE_TYPE_UINT        = 0x20,

    NATIVE_TYPE_NESTEDSTRUCT  = 0x21, //DEPRECATED (use NATIVE_TYPE_STRUCT)

    NATIVE_TYPE_BYVALSTR    = 0x22,   //COMINTEROP

    NATIVE_TYPE_ANSIBSTR    = 0x23,   //COMINTEROP

    NATIVE_TYPE_TBSTR       = 0x24, // select BSTR or ANSIBSTR depending on platform
                                      //COMINTEROP

    NATIVE_TYPE_VARIANTBOOL = 0x25, // (2-byte boolean value: TRUE = -1, FALSE = 0)
                                      //COMINTEROP
    NATIVE_TYPE_FUNC        = 0x26,

    NATIVE_TYPE_ASANY       = 0x28,

    NATIVE_TYPE_ARRAY       = 0x2a,
    NATIVE_TYPE_LPSTRUCT    = 0x2b,

    NATIVE_TYPE_CUSTOMMARSHALER = 0x2c,  // Custom marshaler native type. This must be followed
                                         // by a string of the following format:
                                         // "Native type name/0Custom marshaler type name/0Optional cookie/0"
                                         // Or
                                         // "{Native type GUID}/0Custom marshaler type name/0Optional cookie/0"

    NATIVE_TYPE_ERROR       = 0x2d, // This native type coupled with ELEMENT_TYPE_I4 will map to VT_HRESULT
                                    //COMINTEROP

    NATIVE_TYPE_MAX         = 0x50, // first invalid element type
} CorNativeType;


enum
{
    DESCR_GROUP_METHODDEF = 0,          // DESCR group for MethodDefs
    DESCR_GROUP_METHODIMPL,             // DESCR group for MethodImpls
};

/***********************************************************************************/
// a COR_ILMETHOD_SECT is a generic container for attributes that are private
// to a particular method.  The COR_ILMETHOD structure points to one of these
// (see GetSect()).  COR_ILMETHOD_SECT can decode the Kind of attribute (but not
// its internal data layout, and can skip past the current attibute to find the
// Next one.   The overhead for COR_ILMETHOD_SECT is a minimum of 2 bytes.

typedef enum CorILMethodSect                             // codes that identify attributes
{
    CorILMethod_Sect_Reserved    = 0,
    CorILMethod_Sect_EHTable     = 1,
    CorILMethod_Sect_OptILTable  = 2,

    CorILMethod_Sect_KindMask    = 0x3F,        // The mask for decoding the type code
    CorILMethod_Sect_FatFormat   = 0x40,        // fat format
    CorILMethod_Sect_MoreSects   = 0x80,        // there is another attribute after this one
} CorILMethodSect;

/************************************/
/* NOTE this structure must be DWORD aligned!! */

typedef struct IMAGE_COR_ILMETHOD_SECT_SMALL
{
    BYTE Kind;
    BYTE DataSize;

} IMAGE_COR_ILMETHOD_SECT_SMALL;



/************************************/
/* NOTE this structure must be DWORD aligned!! */
typedef struct IMAGE_COR_ILMETHOD_SECT_FAT
{
    unsigned Kind : 8;
    unsigned DataSize : 24;

} IMAGE_COR_ILMETHOD_SECT_FAT;



/***********************************************************************************/
/* If COR_ILMETHOD_SECT_HEADER::Kind() = CorILMethod_Sect_EHTable then the attribute
   is a list of exception handling clauses.  There are two formats, fat or small
*/
typedef enum CorExceptionFlag                       // defintitions for the Flags field below (for both big and small)
{
    COR_ILEXCEPTION_CLAUSE_NONE,                    // This is a typed handler
    COR_ILEXCEPTION_CLAUSE_OFFSETLEN = 0x0000,      // Deprecated
    COR_ILEXCEPTION_CLAUSE_DEPRECATED = 0x0000,     // Deprecated
    COR_ILEXCEPTION_CLAUSE_FILTER  = 0x0001,        // If this bit is on, then this EH entry is for a filter
    COR_ILEXCEPTION_CLAUSE_FINALLY = 0x0002,        // This clause is a finally clause
    COR_ILEXCEPTION_CLAUSE_FAULT = 0x0004,          // Fault clause (finally that is called on exception only)
    COR_ILEXCEPTION_CLAUSE_DUPLICATED = 0x0008,     // duplicated clase..  this clause was duplicated down to a funclet which was pulled out of line
} CorExceptionFlag;

/***********************************/
// NOTE !!! NOTE
// This structure should line up with EE_ILEXCEPTION_CLAUSE,
// otherwise you'll have to adjust code in Excep.cpp, re: EHRangeTree
// NOTE !!! NOTE

typedef struct IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_FAT
{
    CorExceptionFlag    Flags;
    DWORD               TryOffset;
    DWORD               TryLength;      // relative to start of try block
    DWORD               HandlerOffset;
    DWORD               HandlerLength;  // relative to start of handler
    union {
        DWORD           ClassToken;     // use for type-based exception handlers
        DWORD           FilterOffset;   // use for filter-based exception handlers (COR_ILEXCEPTION_FILTER is set)
    };
} IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_FAT;

typedef struct IMAGE_COR_ILMETHOD_SECT_EH_FAT
{
    IMAGE_COR_ILMETHOD_SECT_FAT   SectFat;
    IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_FAT Clauses[1];     // actually variable size
} IMAGE_COR_ILMETHOD_SECT_EH_FAT;

/***********************************/
typedef struct IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL
{
#ifdef _WIN64
    unsigned            Flags         : 16;
#else // !_WIN64
    CorExceptionFlag    Flags         : 16;
#endif
    unsigned            TryOffset     : 16;
    unsigned            TryLength     : 8;  // relative to start of try block
    unsigned            HandlerOffset : 16;
    unsigned            HandlerLength : 8;  // relative to start of handler
    union {
        DWORD       ClassToken;
        DWORD       FilterOffset;
    };
} IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL;

/***********************************/
typedef struct IMAGE_COR_ILMETHOD_SECT_EH_SMALL
{
    IMAGE_COR_ILMETHOD_SECT_SMALL SectSmall;
    WORD Reserved;
    IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL Clauses[1];   // actually variable size
} IMAGE_COR_ILMETHOD_SECT_EH_SMALL;



typedef union IMAGE_COR_ILMETHOD_SECT_EH
{
    IMAGE_COR_ILMETHOD_SECT_EH_SMALL Small;
    IMAGE_COR_ILMETHOD_SECT_EH_FAT Fat;
} IMAGE_COR_ILMETHOD_SECT_EH;


/***********************************************************************************/
typedef enum CorILMethodFlags
{
    CorILMethod_InitLocals      = 0x0010,           // call default constructor on all local vars
    CorILMethod_MoreSects       = 0x0008,           // there is another attribute after this one

    CorILMethod_CompressedIL    = 0x0040,           // FIX Remove this and do it on a per Module basis

        // Indicates the format for the COR_ILMETHOD header
    CorILMethod_FormatShift     = 3,
    CorILMethod_FormatMask      = ((1 << CorILMethod_FormatShift) - 1),
    CorILMethod_TinyFormat      = 0x0002,         // use this code if the code size is even
    CorILMethod_SmallFormat     = 0x0000,
    CorILMethod_FatFormat       = 0x0003,
    CorILMethod_TinyFormat1     = 0x0006,         // use this code if the code size is odd
} CorILMethodFlags;

/***************************************************************************/
/* Used when the method is tiny (< 64 bytes), and there are no local vars */
typedef struct IMAGE_COR_ILMETHOD_TINY
{
    BYTE Flags_CodeSize;
} IMAGE_COR_ILMETHOD_TINY;

/************************************/
// This strucuture is the 'fat' layout, where no compression is attempted.
// Note that this structure can be added on at the end, thus making it extensible
typedef struct IMAGE_COR_ILMETHOD_FAT
{
    unsigned Flags    : 12;     // Flags
    unsigned Size     :  4;     // size in DWords of this structure (currently 3)
    unsigned MaxStack : 16;     // maximum number of items (I4, I, I8, obj ...), on the operand stack
    DWORD   CodeSize;           // size of the code
    mdSignature   LocalVarSigTok;     // token that indicates the signature of the local vars (0 means none)

} IMAGE_COR_ILMETHOD_FAT;

typedef union IMAGE_COR_ILMETHOD
{
    IMAGE_COR_ILMETHOD_TINY       Tiny;
    IMAGE_COR_ILMETHOD_FAT        Fat;
} IMAGE_COR_ILMETHOD;

//
// Native method descriptor.
//

typedef struct IMAGE_COR_NATIVE_DESCRIPTOR
{
    DWORD       GCInfo;
    DWORD       EHInfo;
} IMAGE_COR_NATIVE_DESCRIPTOR;


typedef struct IMAGE_COR_X86_RUNTIME_FUNCTION_ENTRY
{
    ULONG       BeginAddress;           // RVA of start of function
    ULONG       EndAddress;             // RVA of end of function
    ULONG       MIH;                    // Associated MIH
} IMAGE_COR_X86_RUNTIME_FUNCTION_ENTRY;

typedef struct IMAGE_COR_MIH_ENTRY
{
    ULONG   EHRVA;
    ULONG   MethodRVA;
    mdToken Token;
    BYTE    Flags;
    BYTE    CodeManager;
#if !defined(__BORLANDC__)
    BYTE    MIHData[0];
#else
    BYTE    MIHData[];
#endif
} IMAGE_COR_MIH_ENTRY;

//*****************************************************************************
// Non VOS v-table entries.  Define an array of these pointed to by
// IMAGE_COR20_HEADER.VTableFixups.  Each entry describes a contiguous array of
// v-table slots.  The slots start out initialized to the meta data token value
// for the method they need to call.  At image load time, the CLR Loader will
// turn each entry into a pointer to machine code for the CPU and can be
// called directly.
//*****************************************************************************

typedef struct IMAGE_COR_VTABLEFIXUP
{
    ULONG       RVA;                    // Offset of v-table array in image.
    USHORT      Count;                  // How many entries at location.
    USHORT      Type;                   // COR_VTABLE_xxx type of entries.
} IMAGE_COR_VTABLEFIXUP;





//*****************************************************************************
//*****************************************************************************
//
// M E T A - D A T A    D E C L A R A T I O N S
//
//*****************************************************************************
//*****************************************************************************

//*****************************************************************************
//
// Enums for SetOption API.
//
//*****************************************************************************

// flags for MetaDataCheckDuplicatesFor
typedef enum CorCheckDuplicatesFor
{
    MDDupAll                    = 0xffffffff,
    MDDupENC                    = MDDupAll,
    MDNoDupChecks               = 0x00000000,
    MDDupTypeDef                = 0x00000001,
    MDDupInterfaceImpl          = 0x00000002,
    MDDupMethodDef              = 0x00000004,
    MDDupTypeRef                = 0x00000008,
    MDDupMemberRef              = 0x00000010,
    MDDupCustomAttribute        = 0x00000020,
    MDDupParamDef               = 0x00000040,
    MDDupPermission             = 0x00000080,
    MDDupProperty               = 0x00000100,
    MDDupEvent                  = 0x00000200,
    MDDupFieldDef               = 0x00000400,
    MDDupSignature              = 0x00000800,
    MDDupModuleRef              = 0x00001000,
    MDDupTypeSpec               = 0x00002000,
    MDDupImplMap                = 0x00004000,
    MDDupAssemblyRef            = 0x00008000,
    MDDupFile                   = 0x00010000,
    MDDupExportedType           = 0x00020000,
    MDDupManifestResource       = 0x00040000,
    MDDupGenericParam           = 0x00080000,
    MDDupMethodSpec             = 0x00100000,
    MDDupGenericParamConstraint = 0x00200000,
    // gap for debug junk
    MDDupAssembly               = 0x10000000,

    // This is the default behavior on metadata. It will check duplicates for TypeRef, MemberRef, Signature, TypeSpec and MethodSpec.
    MDDupDefault = MDNoDupChecks | MDDupTypeRef | MDDupMemberRef | MDDupSignature | MDDupTypeSpec | MDDupMethodSpec,
} CorCheckDuplicatesFor;

// flags for MetaDataRefToDefCheck
typedef enum CorRefToDefCheck
{
    // default behavior is to always perform TypeRef to TypeDef and MemberRef to MethodDef/FieldDef optimization
    MDRefToDefDefault           = 0x00000003,
    MDRefToDefAll               = 0xffffffff,
    MDRefToDefNone              = 0x00000000,
    MDTypeRefToDef              = 0x00000001,
    MDMemberRefToDef            = 0x00000002
} CorRefToDefCheck;


// MetaDataNotificationForTokenMovement
typedef enum CorNotificationForTokenMovement
{
    // default behavior is to notify TypeRef, MethodDef, MemberRef, and FieldDef token remaps
    MDNotifyDefault             = 0x0000000f,
    MDNotifyAll                 = 0xffffffff,
    MDNotifyNone                = 0x00000000,
    MDNotifyMethodDef           = 0x00000001,
    MDNotifyMemberRef           = 0x00000002,
    MDNotifyFieldDef            = 0x00000004,
    MDNotifyTypeRef             = 0x00000008,

    MDNotifyTypeDef             = 0x00000010,
    MDNotifyParamDef            = 0x00000020,
    MDNotifyInterfaceImpl       = 0x00000040,
    MDNotifyProperty            = 0x00000080,
    MDNotifyEvent               = 0x00000100,
    MDNotifySignature           = 0x00000200,
    MDNotifyTypeSpec            = 0x00000400,
    MDNotifyCustomAttribute     = 0x00000800,
    MDNotifySecurityValue       = 0x00001000,
    MDNotifyPermission          = 0x00002000,
    MDNotifyModuleRef           = 0x00004000,

    MDNotifyNameSpace           = 0x00008000,

    MDNotifyAssemblyRef         = 0x01000000,
    MDNotifyFile                = 0x02000000,
    MDNotifyExportedType        = 0x04000000,
    MDNotifyResource            = 0x08000000,
} CorNotificationForTokenMovement;


typedef enum CorSetENC
{
    MDSetENCOn                  = 0x00000001,   // Deprecated name.
    MDSetENCOff                 = 0x00000002,   // Deprecated name.

    MDUpdateENC                 = 0x00000001,   // ENC mode.  Tokens don't move; can be updated.
    MDUpdateFull                = 0x00000002,   // "Normal" update mode.
    MDUpdateExtension           = 0x00000003,   // Extension mode.  Tokens don't move, adds only.
    MDUpdateIncremental         = 0x00000004,   // Incremental compilation
    MDUpdateDelta               = 0x00000005,   // If ENC on, save only deltas.
    MDUpdateMask                = 0x00000007,


} CorSetENC;

#define IsENCDelta(x)                       (((x) & MDUpdateMask) == MDUpdateDelta)

// flags used in SetOption when pair with MetaDataErrorIfEmitOutOfOrder guid
typedef enum CorErrorIfEmitOutOfOrder
{
    MDErrorOutOfOrderDefault    = 0x00000000,   // default not to generate any error
    MDErrorOutOfOrderNone       = 0x00000000,   // do not generate error for out of order emit
    MDErrorOutOfOrderAll        = 0xffffffff,   // generate out of order emit for method, field, param, property, and event
    MDMethodOutOfOrder          = 0x00000001,   // generate error when methods are emitted out of order
    MDFieldOutOfOrder           = 0x00000002,   // generate error when fields are emitted out of order
    MDParamOutOfOrder           = 0x00000004,   // generate error when params are emitted out of order
    MDPropertyOutOfOrder        = 0x00000008,   // generate error when properties are emitted out of order
    MDEventOutOfOrder           = 0x00000010,   // generate error when events are emitted out of order
} CorErrorIfEmitOutOfOrder;


// flags used in SetOption when pair with MetaDataImportOption guid
typedef enum CorImportOptions
{
    MDImportOptionDefault       = 0x00000000,   // default to skip over deleted records
    MDImportOptionAll           = 0xFFFFFFFF,   // Enumerate everything
    MDImportOptionAllTypeDefs   = 0x00000001,   // all of the typedefs including the deleted typedef
    MDImportOptionAllMethodDefs = 0x00000002,   // all of the methoddefs including the deleted ones
    MDImportOptionAllFieldDefs  = 0x00000004,   // all of the fielddefs including the deleted ones
    MDImportOptionAllProperties = 0x00000008,   // all of the properties including the deleted ones
    MDImportOptionAllEvents     = 0x00000010,   // all of the events including the deleted ones
    MDImportOptionAllCustomAttributes = 0x00000020, // all of the custom attributes including the deleted ones
    MDImportOptionAllExportedTypes  = 0x00000040,   // all of the ExportedTypes including the deleted ones

} CorImportOptions;


// flags for MetaDataThreadSafetyOptions
typedef enum CorThreadSafetyOptions
{
    // default behavior is to have thread safety turn off. This means that MetaData APIs will not take reader/writer
    // lock. Clients is responsible to make sure the properly thread synchornization when using MetaData APIs.
    MDThreadSafetyDefault       = 0x00000000,
    MDThreadSafetyOff           = 0x00000000,
    MDThreadSafetyOn            = 0x00000001,
} CorThreadSafetyOptions;


// flags for MetaDataLinkerOptions
typedef enum CorLinkerOptions
{
    // default behavior is not to keep private types
    MDAssembly          = 0x00000000,
    MDNetModule         = 0x00000001,
} CorLinkerOptions;

// flags for MetaDataMergeOptions
typedef enum MergeFlags
{
    MergeFlagsNone      =   0,
    MergeManifest       =   0x00000001,     
    DropMemberRefCAs    =   0x00000002,
    NoDupCheck          =   0x00000004,
    MergeExportedTypes  =   0x00000008
} MergeFlags;


//
// struct used to retrieve field offset
// used by GetClassLayout and SetClassLayout
//

#ifndef _COR_FIELD_OFFSET_
#define _COR_FIELD_OFFSET_
*)

  COR_FIELD_OFFSET = record
    ridOfField: mdFieldDef;
    ulOffset: ULONG;
  end;
  {$EXTERNALSYM COR_FIELD_OFFSET}
  PCOR_FIELD_OFFSET = ^COR_FIELD_OFFSET;
  {$NODEFINE PCOR_FIELD_OFFSET}


  IMAGE_COR_FIXUPENTRY = record
    ulRVA: ULONG;
    Count: ULONG;
  end;
  {$EXTERNALSYM IMAGE_COR_FIXUPENTRY}

  //
  // Token tags.
  //
  CorTokenType = LongWord;
  {$EXTERNALSYM CorTokenType}

const
  mdtModule               = $00000000;       //
  {$EXTERNALSYM mdtModule}
  mdtTypeRef              = $01000000;       //
  {$EXTERNALSYM mdtTypeRef}
  mdtTypeDef              = $02000000;       //
  {$EXTERNALSYM mdtTypeDef}
  mdtFieldDef             = $04000000;       //
  {$EXTERNALSYM mdtFieldDef}
  mdtMethodDef            = $06000000;       //
  {$EXTERNALSYM mdtMethodDef}
  mdtParamDef             = $08000000;       //
  {$EXTERNALSYM mdtParamDef}
  mdtInterfaceImpl        = $09000000;       //
  {$EXTERNALSYM mdtInterfaceImpl}
  mdtMemberRef            = $0a000000;       //
  {$EXTERNALSYM mdtMemberRef}
  mdtCustomAttribute      = $0c000000;       //
  {$EXTERNALSYM mdtCustomAttribute}
  mdtPermission           = $0e000000;       //
  {$EXTERNALSYM mdtPermission}
  mdtSignature            = $11000000;       //
  {$EXTERNALSYM mdtSignature}
  mdtEvent                = $14000000;       //
  {$EXTERNALSYM mdtEvent}
  mdtProperty             = $17000000;       //
  {$EXTERNALSYM mdtProperty}
  mdtModuleRef            = $1a000000;       //
  {$EXTERNALSYM mdtModuleRef}
  mdtTypeSpec             = $1b000000;       //
  {$EXTERNALSYM mdtTypeSpec}
  mdtAssembly             = $20000000;       //
  {$EXTERNALSYM mdtAssembly}
  mdtAssemblyRef          = $23000000;       //
  {$EXTERNALSYM mdtAssemblyRef}
  mdtFile                 = $26000000;       //
  {$EXTERNALSYM mdtFile}
  mdtExportedType         = $27000000;       //
  {$EXTERNALSYM mdtExportedType}
  mdtManifestResource     = $28000000;       //
  {$EXTERNALSYM mdtManifestResource}
  mdtGenericParam         = $2a000000;       //
  {$EXTERNALSYM mdtGenericParam}
  mdtMethodSpec           = $2b000000;       //
  {$EXTERNALSYM mdtMethodSpec}
  mdtGenericParamConstraint = $2c000000;
  {$EXTERNALSYM mdtGenericParamConstraint}

  mdtString               = $70000000;       //
  {$EXTERNALSYM mdtString}
  mdtName                 = $71000000;       //
  {$EXTERNALSYM mdtName}
  mdtBaseType             = $72000000;       // Leave this on the high end value. This does not correspond to metadata table
  {$EXTERNALSYM mdtBaseType}


  //
  // Build / decompose tokens.
  //
function RidToToken(aRid: RID; tktype: mdToken): mdToken; inline;
{$EXTERNALSYM RidToToken}
function TokenFromRid(aRid: RID; tktype: mdToken): mdToken; inline;
{$EXTERNALSYM TokenFromRid}
function RidFromToken(tk: mdToken): RID; inline;
{$EXTERNALSYM RidFromToken}
function TypeFromToken(tk: mdToken): ULONG32; inline;
{$EXTERNALSYM TypeFromToken}
function IsNilToken(tk: mdToken): Boolean; inline;
{$EXTERNALSYM IsNilToken}

const
  //
  // Nil tokens
  //
  mdTokenNil                  = mdToken(0);
  {$EXTERNALSYM mdTokenNil}
  mdModuleNil                 = mdModule(mdtModule);
  {$EXTERNALSYM mdModuleNil}
  mdTypeRefNil                = mdTypeRef(mdtTypeRef);
  {$EXTERNALSYM mdTypeRefNil}
  mdTypeDefNil                = mdTypeDef(mdtTypeDef);
  {$EXTERNALSYM mdTypeDefNil}
  mdFieldDefNil               = mdFieldDef(mdtFieldDef);
  {$EXTERNALSYM mdFieldDefNil}
  mdMethodDefNil              = mdMethodDef(mdtMethodDef);
  {$EXTERNALSYM mdMethodDefNil}
  mdParamDefNil               = mdParamDef(mdtParamDef);
  {$EXTERNALSYM mdParamDefNil}
  mdInterfaceImplNil          = mdInterfaceImpl(mdtInterfaceImpl);
  {$EXTERNALSYM mdInterfaceImplNil}
  mdMemberRefNil              = mdMemberRef(mdtMemberRef);
  {$EXTERNALSYM mdMemberRefNil}
  mdCustomAttributeNil        = mdCustomAttribute(mdtCustomAttribute);
  {$EXTERNALSYM mdCustomAttributeNil}
  mdPermissionNil             = mdPermission(mdtPermission);
  {$EXTERNALSYM mdPermissionNil}
  mdSignatureNil              = mdSignature(mdtSignature);
  {$EXTERNALSYM mdSignatureNil}
  mdEventNil                  = mdEvent(mdtEvent);
  {$EXTERNALSYM mdEventNil}
  mdPropertyNil               = mdProperty(mdtProperty);
  {$EXTERNALSYM mdPropertyNil}
  mdModuleRefNil              = mdModuleRef(mdtModuleRef);
  {$EXTERNALSYM mdModuleRefNil}
  mdTypeSpecNil               = mdTypeSpec(mdtTypeSpec);
  {$EXTERNALSYM mdTypeSpecNil}
  mdAssemblyNil               = mdAssembly(mdtAssembly);
  {$EXTERNALSYM mdAssemblyNil}
  mdAssemblyRefNil            = mdAssemblyRef(mdtAssemblyRef);
  {$EXTERNALSYM mdAssemblyRefNil}
  mdFileNil                   = mdFile(mdtFile);
  {$EXTERNALSYM mdFileNil}
  mdExportedTypeNil           = mdExportedType(mdtExportedType);
  {$EXTERNALSYM mdExportedTypeNil}
  mdManifestResourceNil       = mdManifestResource(mdtManifestResource);
  {$EXTERNALSYM mdManifestResourceNil}

  mdGenericParamNil           = mdGenericParam(mdtGenericParam);
  {$EXTERNALSYM mdGenericParamNil}
  mdGenericParamConstraintNil = mdGenericParamConstraint(mdtGenericParamConstraint);
  {$EXTERNALSYM mdGenericParamConstraintNil}
  mdMethodSpecNil             = mdMethodSpec(mdtMethodSpec);
  {$EXTERNALSYM mdMethodSpecNil}

  mdStringNil                 = mdString(mdtString);
  {$EXTERNALSYM mdStringNil}

  //
  // Open bits.
  //
type
  CorOpenFlags = type DWORD;
  {$EXTERNALSYM CorOpenFlags}

const
  ofRead              =   CorOpenFlags($00000000);     // Open scope for read
  {$EXTERNALSYM ofRead}
  ofWrite             =   CorOpenFlags($00000001);     // Open scope for write.
  {$EXTERNALSYM ofWrite}
  ofReadWriteMask     =   CorOpenFlags($00000001);     // Mask for read/write bit.
  {$EXTERNALSYM ofReadWriteMask}

  ofCopyMemory        =   CorOpenFlags($00000002);     // Open scope with memory. Ask metadata to maintain its own copy of memory.
  {$EXTERNALSYM ofCopyMemory}

  ofManifestMetadata  =   CorOpenFlags($00000008);     // Open scope on ngen image; return the manifest metadata instead of the IL metadata
  {$EXTERNALSYM ofManifestMetadata}
  ofReadOnly          =   CorOpenFlags($00000010);     // Open scope for read. Will be unable to QI for a IMetadataEmit* interface
  {$EXTERNALSYM ofReadOnly}
  ofTakeOwnership     =   CorOpenFlags($00000020);     // The memory was allocated with CoTaskMemAlloc and will be freed by the metadata
  {$EXTERNALSYM ofTakeOwnership}

  // These are obsolete and are ignored.
  ofCacheImage        =   CorOpenFlags($00000004);     // EE maps but does not do relocations or verify image
  {$EXTERNALSYM ofCacheImage}
  ofNoTypeLib         =   CorOpenFlags($00000080);     // Don't OpenScope on a typelib.
  {$EXTERNALSYM ofNoTypeLib}

  // Internal bits
  ofReserved1         =   CorOpenFlags($00000100);     // Reserved for internal use.
  {$EXTERNALSYM ofReserved1}
  ofReserved2         =   CorOpenFlags($00000200);     // Reserved for internal use.
  {$EXTERNALSYM ofReserved2}
  ofReserved          =   CorOpenFlags($ffffff40);     // All the reserved bits.
  {$EXTERNALSYM ofReserved}

function IsOfRead(x: CorOpenFlags): Boolean; inline;
{$EXTERNALSYM IsOfRead}
function IsOfReadWrite(x: CorOpenFlags): Boolean; inline;
{$EXTERNALSYM IsOfReadWrite}
function IsOfCopyMemory(x: CorOpenFlags): Boolean; inline;
{$EXTERNALSYM IsOfCopyMemory}

function IsOfManifestMetadata(x: CorOpenFlags): Boolean; inline;
{$EXTERNALSYM IsOfManifestMetadata}
function IsOfReadOnly(x: CorOpenFlags): Boolean; inline;
{$EXTERNALSYM IsOfReadOnly}

function IsOfTakeOwnership(x: CorOpenFlags): Boolean; inline;
{$EXTERNALSYM IsOfTakeOwnership}

function IsOfReserved(x: CorOpenFlags): Boolean; inline;
{$EXTERNALSYM IsOfReserved}

type
  //CorRegTypeAttr = CorTypeAttr;
  //
  // Opaque type for an enumeration handle.
  //
  HCORENUM = PVOID;
  {$EXTERNALSYM HCORENUM}
(*

// Note that this must be kept in sync with System.AttributeTargets.
typedef enum CorAttributeTargets
{
    catAssembly      = 0x0001,
    catModule        = 0x0002,
    catClass         = 0x0004,
    catStruct        = 0x0008,
    catEnum          = 0x0010,
    catConstructor   = 0x0020,
    catMethod        = 0x0040,
    catProperty      = 0x0080,
    catField         = 0x0100,
    catEvent         = 0x0200,
    catInterface     = 0x0400,
    catParameter     = 0x0800,
    catDelegate      = 0x1000,
    catGenericParameter = 0x4000,

    catAll           = catAssembly | catModule | catClass | catStruct | catEnum | catConstructor |
                    catMethod | catProperty | catField | catEvent | catInterface | catParameter | catDelegate | catGenericParameter,
    catClassMembers  = catClass | catStruct | catEnum | catConstructor | catMethod | catProperty | catField | catEvent | catDelegate | catInterface,

} CorAttributeTargets;

#ifndef MACROS_NOT_SUPPORTED
//
// Some well-known custom attributes
//
#ifndef IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS
  #define IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS (IMAGE_CEE_CS_CALLCONV_DEFAULT | IMAGE_CEE_CS_CALLCONV_HASTHIS)
#endif

#define INTEROP_DISPID_TYPE_W                   L"System.Runtime.InteropServices.DispIdAttribute"
#define INTEROP_DISPID_TYPE                     "System.Runtime.InteropServices.DispIdAttribute"
#define INTEROP_DISPID_SIG                      {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I4}

#define INTEROP_INTERFACETYPE_TYPE_W            L"System.Runtime.InteropServices.InterfaceTypeAttribute"
#define INTEROP_INTERFACETYPE_TYPE              "System.Runtime.InteropServices.InterfaceTypeAttribute"
#define INTEROP_INTERFACETYPE_SIG               {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2}

#define INTEROP_CLASSINTERFACE_TYPE_W           L"System.Runtime.InteropServices.ClassInterfaceAttribute"
#define INTEROP_CLASSINTERFACE_TYPE             "System.Runtime.InteropServices.ClassInterfaceAttribute"
#define INTEROP_CLASSINTERFACE_SIG              {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2}

#define INTEROP_COMVISIBLE_TYPE_W               L"System.Runtime.InteropServices.ComVisibleAttribute"
#define INTEROP_COMVISIBLE_TYPE                 "System.Runtime.InteropServices.ComVisibleAttribute"
#define INTEROP_COMVISIBLE_SIG                  {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_BOOLEAN}

#define INTEROP_COMREGISTERFUNCTION_TYPE_W      L"System.Runtime.InteropServices.ComRegisterFunctionAttribute"
#define INTEROP_COMREGISTERFUNCTION_TYPE        "System.Runtime.InteropServices.ComRegisterFunctionAttribute"
#define INTEROP_COMREGISTERFUNCTION_SIG         {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_COMUNREGISTERFUNCTION_TYPE_W    L"System.Runtime.InteropServices.ComUnregisterFunctionAttribute"
#define INTEROP_COMUNREGISTERFUNCTION_TYPE      "System.Runtime.InteropServices.ComUnregisterFunctionAttribute"
#define INTEROP_COMUNREGISTERFUNCTION_SIG       {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_IMPORTEDFROMTYPELIB_TYPE_W      L"System.Runtime.InteropServices.ImportedFromTypeLibAttribute"
#define INTEROP_IMPORTEDFROMTYPELIB_TYPE        "System.Runtime.InteropServices.ImportedFromTypeLibAttribute"
#define INTEROP_IMPORTEDFROMTYPELIB_SIG         {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_STRING}

#define INTEROP_IDISPATCHIMPL_TYPE_W            L"System.Runtime.InteropServices.IDispatchImplAttribute"
#define INTEROP_IDISPATCHIMPL_TYPE              "System.Runtime.InteropServices.IDispatchImplAttribute"
#define INTEROP_IDISPATCHIMPL_SIG               {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2}

#define INTEROP_COMSOURCEINTERFACES_TYPE_W      L"System.Runtime.InteropServices.ComSourceInterfacesAttribute"
#define INTEROP_COMSOURCEINTERFACES_TYPE        "System.Runtime.InteropServices.ComSourceInterfacesAttribute"
#define INTEROP_COMSOURCEINTERFACES_SIG         {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_STRING}

#define INTEROP_COMDEFAULTINTERFACE_TYPE_W      L"System.Runtime.InteropServices.ComDefaultInterfaceAttribute"
#define INTEROP_COMDEFAULTINTERFACE_TYPE        "System.Runtime.InteropServices.ComDefaultInterfaceAttribute"

#define INTEROP_COMCONVERSIONLOSS_TYPE_W        L"System.Runtime.InteropServices.ComConversionLossAttribute"
#define INTEROP_COMCONVERSIONLOSS_TYPE          "System.Runtime.InteropServices.ComConversionLossAttribute"
#define INTEROP_COMCONVERSIONLOSS_SIG           {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_BESTFITMAPPING_TYPE_W           L"System.Runtime.InteropServices.BestFitMappingAttribute"
#define INTEROP_BESTFITMAPPING_TYPE             "System.Runtime.InteropServices.BestFitMappingAttribute"
#define INTEROP_BESTFITMAPPING_SIG              {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 2, ELEMENT_TYPE_VOID, ELEMENT_TYPE_BOOLEAN, ELEMENT_TYPE_BOOLEAN}

#define INTEROP_TYPELIBTYPE_TYPE_W              L"System.Runtime.InteropServices.TypeLibTypeAttribute"
#define INTEROP_TYPELIBTYPE_TYPE                "System.Runtime.InteropServices.TypeLibTypeAttribute"
#define INTEROP_TYPELIBTYPE_SIG                 {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2}

#define INTEROP_TYPELIBFUNC_TYPE_W              L"System.Runtime.InteropServices.TypeLibFuncAttribute"
#define INTEROP_TYPELIBFUNC_TYPE                "System.Runtime.InteropServices.TypeLibFuncAttribute"
#define INTEROP_TYPELIBFUNC_SIG                 {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2}

#define INTEROP_TYPELIBVAR_TYPE_W               L"System.Runtime.InteropServices.TypeLibVarAttribute"
#define INTEROP_TYPELIBVAR_TYPE                 "System.Runtime.InteropServices.TypeLibVarAttribute"
#define INTEROP_TYPELIBVAR_SIG                  {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2}

#define INTEROP_MARSHALAS_TYPE_W                L"System.Runtime.InteropServices.MarshalAsAttribute"
#define INTEROP_MARSHALAS_TYPE                  "System.Runtime.InteropServices.MarshalAsAttribute"
#define INTEROP_MARSHALAS_SIG                   {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2}

#define INTEROP_COMIMPORT_TYPE_W                L"System.Runtime.InteropServices.ComImportAttribute"
#define INTEROP_COMIMPORT_TYPE                  "System.Runtime.InteropServices.ComImportAttribute"
#define INTEROP_COMIMPORT_SIG                   {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_GUID_TYPE_W                     L"System.Runtime.InteropServices.GuidAttribute"
#define INTEROP_GUID_TYPE                       "System.Runtime.InteropServices.GuidAttribute"
#define INTEROP_GUID_SIG                        {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_STRING}

#define INTEROP_DEFAULTMEMBER_TYPE_W            L"System.Reflection.DefaultMemberAttribute"
#define INTEROP_DEFAULTMEMBER_TYPE              "System.Reflection.DefaultMemberAttribute"
#define INTEROP_DEFAULTMEMBER_SIG               {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_STRING}

#define INTEROP_COMEMULATE_TYPE_W               L"System.Runtime.InteropServices.ComEmulateAttribute"
#define INTEROP_COMEMULATE_TYPE                 "System.Runtime.InteropServices.ComEmulateAttribute"
#define INTEROP_COMEMULATE_SIG                  {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_STRING}

#define INTEROP_PRESERVESIG_TYPE_W              L"System.Runtime.InteropServices.PreserveSigAttribure"
#define INTEROP_PRESERVESIG_TYPE                "System.Runtime.InteropServices.PreserveSigAttribure"
#define INTEROP_PRESERVESIG_SIG                 {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_BOOLEAN}

#define INTEROP_IN_TYPE_W                       L"System.Runtime.InteropServices.InAttribute"
#define INTEROP_IN_TYPE                         "System.Runtime.InteropServices.InAttribute"
#define INTEROP_IN_SIG                          {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_OUT_TYPE_W                      L"System.Runtime.InteropServices.OutAttribute"
#define INTEROP_OUT_TYPE                        "System.Runtime.InteropServices.OutAttribute"
#define INTEROP_OUT_SIG                         {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_COMALIASNAME_TYPE_W             L"System.Runtime.InteropServices.ComAliasNameAttribute"
#define INTEROP_COMALIASNAME_TYPE               "System.Runtime.InteropServices.ComAliasNameAttribute"
#define INTEROP_COMALIASNAME_SIG                {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_STRING}

#define INTEROP_PARAMARRAY_TYPE_W               L"System.ParamArrayAttribute"
#define INTEROP_PARAMARRAY_TYPE                 "System.ParamArrayAttribute"
#define INTEROP_PARAMARRAY_SIG                  {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_LCIDCONVERSION_TYPE_W           L"System.Runtime.InteropServices.LCIDConversionAttribute"
#define INTEROP_LCIDCONVERSION_TYPE             "System.Runtime.InteropServices.LCIDConversionAttribute"
#define INTEROP_LCIDCONVERSION_SIG              {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I4}

#define INTEROP_COMSUBSTITUTABLEINTERFACE_TYPE_W    L"System.Runtime.InteropServices.ComSubstitutableInterfaceAttribute"
#define INTEROP_COMSUBSTITUTABLEINTERFACE_TYPE      "System.Runtime.InteropServices.ComSubstitutableInterfaceAttribute"
#define INTEROP_COMSUBSTITUTABLEINTERFACE_SIG       {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_DECIMALVALUE_TYPE_W             L"System.Runtime.CompilerServices.DecimalConstantAttribute"
#define INTEROP_DECIMALVALUE_TYPE               "System.Runtime.CompilerServices.DecimalConstantAttribute"
#define INTEROP_DECIMALVALUE_SIG                {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 5, ELEMENT_TYPE_VOID, ELEMENT_TYPE_U1, ELEMENT_TYPE_U1, ELEMENT_TYPE_U4, ELEMENT_TYPE_U4, ELEMENT_TYPE_U4}

#define INTEROP_DATETIMEVALUE_TYPE_W            L"System.Runtime.CompilerServices.DateTimeConstantAttribute"
#define INTEROP_DATETIMEVALUE_TYPE              "System.Runtime.CompilerServices.DateTimeConstantAttribute"
#define INTEROP_DATETIMEVALUE_SIG               {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I8}

#define INTEROP_IUNKNOWNVALUE_TYPE_W            L"System.Runtime.CompilerServices.IUnknownConstantAttribute"
#define INTEROP_IUNKNOWNVALUE_TYPE               "System.Runtime.CompilerServices.IUnknownConstantAttribute"
#define INTEROP_IUNKNOWNVALUE_SIG               {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_IDISPATCHVALUE_TYPE_W           L"System.Runtime.CompilerServices.IDispatchConstantAttribute"
#define INTEROP_IDISPATCHVALUE_TYPE              "System.Runtime.CompilerServices.IDispatchConstantAttribute"
#define INTEROP_IDISPATCHVALUE_SIG              {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_AUTOPROXY_TYPE_W                L"System.Runtime.InteropServices.AutomationProxyAttribute"
#define INTEROP_AUTOPROXY_TYPE                  "System.Runtime.InteropServices.AutomationProxyAttribute"
#define INTEROP_AUTOPROXY_SIG                   {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_BOOLEAN}

#define INTEROP_TYPELIBIMPORTCLASS_TYPE_W       L"System.Runtime.InteropServices.TypeLibImportClassAttribute"
#define INTEROP_TYPELIBIMPORTCLASS_TYPE         "System.Runtime.InteropServices.TypeLibImportClassAttribute"


#define INTEROP_TYPELIBVERSION_TYPE_W           L"System.Runtime.InteropServices.TypeLibVersionAttribute"
#define INTEROP_TYPELIBVERSION_TYPE             "System.Runtime.InteropServices.TypeLibVersionAttribute"
#define INTEROP_TYPELIBVERSION_SIG              {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 2, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2, ELEMENT_TYPE_I2}

#define INTEROP_COMCOMPATIBLEVERSION_TYPE_W     L"System.Runtime.InteropServices.ComCompatibleVersionAttribute"
#define INTEROP_COMCOMPATIBLEVERSION_TYPE       "System.Runtime.InteropServices.ComCompatibleVersionAttribute"
#define INTEROP_COMCOMPATIBLEVERSION_SIG        {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 4, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I2, ELEMENT_TYPE_I2, ELEMENT_TYPE_I2, ELEMENT_TYPE_I2}

#define INTEROP_COMEVENTINTERFACE_TYPE_W        L"System.Runtime.InteropServices.ComEventInterfaceAttribute"
#define INTEROP_COMEVENTINTERFACE_TYPE          "System.Runtime.InteropServices.ComEventInterfaceAttribute"

#define INTEROP_COCLASS_TYPE_W                  L"System.Runtime.InteropServices.CoClassAttribute"
#define INTEROP_COCLASS_TYPE                    "System.Runtime.InteropServices.CoClassAttribute"

#define INTEROP_SERIALIZABLE_TYPE_W             L"System.SerializableAttribute"
#define INTEROP_SERIALIZABLE_TYPE               "System.SerializableAttribute"
#define INTEROP_SERIALIZABLE_SIG                {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define INTEROP_SETWIN32CONTEXTINIDISPATCHATTRIBUTE_TYPE_W  L"System.Runtime.InteropServices.SetWin32ContextInIDispatchAttribute"
#define INTEROP_SETWIN32CONTEXTINIDISPATCHATTRIBUTE_TYPE     "System.Runtime.InteropServices.SetWin32ContextInIDispatchAttribute"
#define INTEROP_SETWIN32CONTEXTINIDISPATCHATTRIBUTE_SIG     {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define FRIEND_ASSEMBLY_TYPE_W                  L"System.Runtime.CompilerServices.InternalsVisibleToAttribute"
#define FRIEND_ASSEMBLY_TYPE                     "System.Runtime.CompilerServices.InternalsVisibleToAttribute"
#define FRIEND_ASSEMBLY_SIG                     {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_STRING}

#define DEFAULTDOMAIN_STA_TYPE_W                L"System.STAThreadAttribute"
#define DEFAULTDOMAIN_STA_TYPE                   "System.STAThreadAttribute"
#define DEFAULTDOMAIN_STA_SIG                   {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define DEFAULTDOMAIN_MTA_TYPE_W                L"System.MTAThreadAttribute"
#define DEFAULTDOMAIN_MTA_TYPE                   "System.MTAThreadAttribute"
#define DEFAULTDOMAIN_MTA_SIG                   {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 0, ELEMENT_TYPE_VOID}

#define DEFAULTDOMAIN_LOADEROPTIMIZATION_TYPE_W L"System.LoaderOptimizationAttribute"
#define DEFAULTDOMAIN_LOADEROPTIMIZATION_TYPE    "System.LoaderOptimizationAttribute"
#define DEFAULTDOMAIN_LOADEROPTIMIZATION_SIG    {IMAGE_CEE_CS_CALLCONV_DEFAULT_HASTHIS, 1, ELEMENT_TYPE_VOID, ELEMENT_TYPE_I1}


// Keep in sync with CompilationRelaxations.cs
typedef enum CompilationRelaxationsEnum
{
    CompilationRelaxations_NoStringInterning       = 0x0008,
        
} CompilationRelaxationEnum;

#define COMPILATIONRELAXATIONS_TYPE_W           L"System.Runtime.CompilerServices.CompilationRelaxationsAttribute"
#define COMPILATIONRELAXATIONS_TYPE             "System.Runtime.CompilerServices.CompilationRelaxationsAttribute"


// Keep in sync with RuntimeCompatibilityAttribute.cs
#define RUNTIMECOMPATIBILITY_TYPE_W             L"System.Runtime.CompilerServices.RuntimeCompatibilityAttribute"
#define RUNTIMECOMPATIBILITY_TYPE               "System.Runtime.CompilerServices.RuntimeCompatibilityAttribute"


// Keep in sync with AssemblySettingAttributes.cs

typedef enum NGenHintEnum
{    
    NGenDefault             = 0x0000, // No preference specified

    NGenEager               = 0x0001, // NGen at install time
    NGenLazy                = 0x0002, // NGen after install time
    NGenNever               = 0x0003  // Assembly should not be ngened      
#ifdef __BORLANDC__
} NGenHintEnum;
#else
};
#endif

typedef enum LoadHintEnum
{
    LoadDefault             = 0x0000, // No preference specified

    LoadAlways              = 0x0001, // Dependency is always loaded
    LoadSometimes           = 0x0002, // Dependency is sometimes loaded
    LoadNever               = 0x0003  // Dependency is never loaded
#ifdef __BORLANDC__
} LoadHintEnum;
#else
};
#endif

#define NGEN_TYPE_W                             L"System.Runtime.CompilerServices.NGenAttribute"
#define NGEN_TYPE                               "System.Runtime.CompilerServices.NGenAttribute"

#define DEFAULTDEPENDENCY_TYPE_W                L"System.Runtime.CompilerServices.DefaultDependencyAttribute"
#define DEFAULTDEPENDENCY_TYPE                  "System.Runtime.CompilerServices.DefaultDependencyAttribute"

#define DEPENDENCY_TYPE_W                       L"System.Runtime.CompilerServices.DependencyAttribute"
#define DEPENDENCY_TYPE                         "System.Runtime.CompilerServices.DependencyAttribute"


#define CMOD_CALLCONV_NAMESPACE_OLD             "System.Runtime.InteropServices"
#define CMOD_CALLCONV_NAMESPACE                 "System.Runtime.CompilerServices"
#define CMOD_CALLCONV_NAME_CDECL                "CallConvCdecl"
#define CMOD_CALLCONV_NAME_STDCALL              "CallConvStdcall"
#define CMOD_CALLCONV_NAME_THISCALL             "CallConvThiscall"
#define CMOD_CALLCONV_NAME_FASTCALL             "CallConvFastcall"

#endif // MACROS_NOT_SUPPORTED
*)

  //
  // GetSaveSize accuracy
  //
  CorSaveSize = (
      cssAccurate             = $0000,               // Find exact save size, accurate but slower.
      cssQuick                = $0001,               // Estimate save size, may pad estimate, but faster.
      cssDiscardTransientCAs  = $0002                // remove all of the CAs of discardable types
  );
  {$EXTERNALSYM CorSaveSize}
(*
#define COR_IS_METHOD_MANAGED_IL(flags)         ((flags & 0xf) == (miIL | miManaged))
#define COR_IS_METHOD_MANAGED_OPTIL(flags)      ((flags & 0xf) == (miOPTIL | miManaged))
#define COR_IS_METHOD_MANAGED_NATIVE(flags)     ((flags & 0xf) == (miNative | miManaged))
#define COR_IS_METHOD_UNMANAGED_NATIVE(flags)   ((flags & 0xf) == (miNative | miUnmanaged))

//
// Enum used with NATIVE_TYPE_ARRAY.
//
typedef enum NativeTypeArrayFlags
{
    ntaSizeParamIndexSpecified = 0x0001,
    ntaReserved                = 0xfffe      // All the reserved bits.
#ifdef __BORLANDC__
} NativeTypeArrayFlags;
#else
};
#endif

//
// Opaque types for security properties and values.
//
typedef void  *  PSECURITY_PROPS ;
typedef void  *  PSECURITY_VALUE ;
typedef void ** PPSECURITY_PROPS ;
typedef void ** PPSECURITY_VALUE ;

//-------------------------------------
//--- Security data structures
//-------------------------------------

*)
  {$POINTERMATH ON}
  // Descriptor for a single security custom attribute.
  COR_SECATTR = record
      tkCtor:            mdMemberRef;       // Ref to constructor of security attribute.
      pCustomAttribute:  PVOID;             // Blob describing ctor args and field/property values.
      cbCustomAttribute: ULONG;             // Length of the above blob.
  end;
  {$EXTERNALSYM COR_SECATTR}
  PCOR_SECATTR = ^COR_SECATTR;
  {$NODEFINE PCOR_SECATTR}
  {$POINTERMATH OFF}

implementation

function RidToToken(aRid: RID; tktype: mdToken): mdToken;
begin
 Result := mdToken(aRid) or tktype;
end;

function TokenFromRid(aRid: RID; tktype: mdToken): mdToken;
begin
 Result := mdToken(aRid) or tktype;
end;

function RidFromToken(tk: mdToken): RID;
begin
  Result := RID(tk and $00ffffff);
end;

function TypeFromToken(tk: mdToken): ULONG32;
begin
 Result := ULONG32(tk and $ff000000);
end;

function IsNilToken(tk: mdToken): Boolean;
begin
  Result := RidFromToken(tk) = 0;
end;

function IsOfRead(x: CorOpenFlags): Boolean;
begin
  Result := x and ofReadWriteMask = ofRead;
end;

function IsOfReadWrite(x: CorOpenFlags): Boolean;
begin
  Result := x and ofReadWriteMask = ofWrite;
end;

function IsOfCopyMemory(x: CorOpenFlags): Boolean;
begin
  Result := x and ofCopyMemory <> 0;
end;

function IsOfManifestMetadata(x: CorOpenFlags): Boolean;
begin
  Result := x and ofManifestMetadata <> 0;
end;

function IsOfReadOnly(x: CorOpenFlags): Boolean;
begin
  Result := x and ofReadOnly <> 0;
end;

function IsOfTakeOwnership(x: CorOpenFlags): Boolean;
begin
  Result := x and ofTakeOwnership <> 0;
end;

function IsOfReserved(x: CorOpenFlags): Boolean;
begin
  Result := x and ofReserved <> 0;
end;

function IsTdNotPublic(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNotPublic;
end;

function IsTdPublic(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdPublic;
end;

function IsTdNestedPublic(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNestedPublic;
end;

function IsTdNestedPrivate(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNestedPrivate;
end;

function IsTdNestedFamily(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNestedFamily;
end;

function IsTdNestedAssembly(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNestedAssembly;
end;

function IsTdNestedFamANDAssem(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNestedFamANDAssem;
end;

function IsTdNestedFamORAssem(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNestedFamORAssem;
end;

function IsTdNested(x: CorTypeAttr): Boolean;
begin
  Result := x and tdVisibilityMask = tdNestedPublic;
end;

function IsTdAutoLayout(x: CorTypeAttr): Boolean;
begin
  Result := x and tdLayoutMask = tdAutoLayout;
end;

function IsTdSequentialLayout(x: CorTypeAttr): Boolean;
begin
  Result := x and tdLayoutMask = tdSequentialLayout;
end;

function IsTdExplicitLayout(x: CorTypeAttr): Boolean;
begin
  Result := x and tdLayoutMask = tdExplicitLayout;
end;

function IsTdClass(x: CorTypeAttr): Boolean;
begin
  Result := x and tdClassSemanticsMask = tdClass;
end;

function IsTdInterface(x: CorTypeAttr): Boolean;
begin
  Result := x and tdClassSemanticsMask = tdInterface;
end;

function IsTdAbstract(x: CorTypeAttr): Boolean;
begin
  Result := x and tdAbstract <> 0;
end;

function IsTdSealed(x: CorTypeAttr): Boolean;
begin
  Result := x and tdSealed <> 0;
end;

function IsTdSpecialName(x: CorTypeAttr): Boolean;
begin
  Result := x and tdSpecialName <> 0;
end;

function IsTdImport(x: CorTypeAttr): Boolean;
begin
  Result := x and tdImport <> 0;
end;

function IsTdSerializable(x: CorTypeAttr): Boolean;
begin
  Result := x and tdSerializable <> 0;
end;

function IsTdAnsiClass(x: CorTypeAttr): Boolean;
begin
  Result := x and tdStringFormatMask = tdAnsiClass;
end;

function IsTdUnicodeClass(x: CorTypeAttr): Boolean;
begin
  Result := x and tdStringFormatMask = tdUnicodeClass;
end;

function IsTdAutoClass(x: CorTypeAttr): Boolean;
begin
  Result := x and tdStringFormatMask = tdAutoClass;
end;

function IsTdCustomFormatClass(x: CorTypeAttr): Boolean;
begin
  Result := x and tdStringFormatMask = tdCustomFormatClass;
end;

function IsTdBeforeFieldInit(x: CorTypeAttr): Boolean;
begin
  Result := x and tdBeforeFieldInit <> 0;
end;

function IsTdForwarder(x: CorTypeAttr): Boolean;
begin
  Result := x and tdForwarder <> 0;
end;

function IsTdRTSpecialName(x: CorTypeAttr): Boolean;
begin
  Result := x and tdRTSpecialName <> 0;
end;

function IsTdHasSecurity(x: CorTypeAttr): Boolean;
begin
  Result := x and tdHasSecurity <> 0;
end;

function IsMdPrivateScope(x: CorMethodAttr): Boolean;
begin
  Result := x and mdMemberAccessMask = mdPrivateScope;
end;

function IsMdPrivate(x: CorMethodAttr): Boolean;
begin
  Result := x and mdMemberAccessMask = mdPrivate;
end;

function IsMdFamANDAssem(x: CorMethodAttr): Boolean;
begin
  Result := x and mdMemberAccessMask = mdFamANDAssem;
end;

function IsMdAssem(x: CorMethodAttr): Boolean;
begin
  Result := x and mdMemberAccessMask = mdAssem;
end;

function IsMdFamily(x: CorMethodAttr): Boolean;
begin
  Result := x and mdMemberAccessMask = mdFamily;
end;

function IsMdFamORAssem(x: CorMethodAttr): Boolean;
begin
  Result := x and mdMemberAccessMask = mdFamORAssem;
end;

function IsMdPublic(x: CorMethodAttr): Boolean;
begin
  Result := x and mdMemberAccessMask = mdPublic;
end;

function IsMdStatic(x: CorMethodAttr): Boolean;
begin
  Result := x and mdStatic <> 0;
end;

function IsMdFinal(x: CorMethodAttr): Boolean;
begin
  Result := x and mdFinal <> 0;
end;

function IsMdVirtual(x: CorMethodAttr): Boolean;
begin
  Result := x and mdVirtual <> 0;
end;

function IsMdHideBySig(x: CorMethodAttr): Boolean;
begin
  Result := x and mdHideBySig <> 0;
end;

function IsMdReuseSlot(x: CorMethodAttr): Boolean;
begin
  Result := x and mdVtableLayoutMask = mdReuseSlot;
end;

function IsMdNewSlot(x: CorMethodAttr): Boolean;
begin
  Result := x and mdVtableLayoutMask = mdNewSlot;
end;

function IsMdCheckAccessOnOverride(x: CorMethodAttr): Boolean;
begin
  Result := x and mdCheckAccessOnOverride <> 0;
end;

function IsMdAbstract(x: CorMethodAttr): Boolean;
begin
  Result := x and mdAbstract <> 0;
end;

function IsMdSpecialName(x: CorMethodAttr): Boolean;
begin
  Result := x and mdSpecialName <> 0;
end;

function IsMdPinvokeImpl(x: CorMethodAttr): Boolean;
begin
  Result := x and mdPinvokeImpl <> 0;
end;

function IsMdUnmanagedExport(x: CorMethodAttr): Boolean;
begin
  Result := x and mdUnmanagedExport <> 0;
end;

function IsMdRTSpecialName(x: CorMethodAttr): Boolean;
begin
  Result := x and mdRTSpecialName <> 0;
end;

//#define IsMdInstanceInitializer(x, str)     (((x) & mdRTSpecialName) && !strcmp((str), COR_CTOR_METHOD_NAME))
//#define IsMdInstanceInitializerW(x, str)    (((x) & mdRTSpecialName) && !wcscmp((str), COR_CTOR_METHOD_NAME_W))
//#define IsMdClassConstructor(x, str)        (((x) & mdRTSpecialName) && !strcmp((str), COR_CCTOR_METHOD_NAME))
//#define IsMdClassConstructorW(x, str)       (((x) & mdRTSpecialName) && !wcscmp((str), COR_CCTOR_METHOD_NAME_W))
function IsMdHasSecurity(x: CorMethodAttr): Boolean;
begin
  Result := x and mdHasSecurity <> 0;
end;

function IsMdRequireSecObject(x: CorMethodAttr): Boolean;
begin
  Result := x and mdRequireSecObject <> 0;
end;

function IsFdPrivateScope(x: CorFieldAttr): Boolean;
begin
  Result := x and fdFieldAccessMask = fdPrivateScope;
end;

function IsFdPrivate(x: CorFieldAttr): Boolean;
begin
  Result := x and fdFieldAccessMask = fdPrivate;
end;

function IsFdFamANDAssem(x: CorFieldAttr): Boolean;
begin
  Result := x and fdFieldAccessMask = fdFamANDAssem;
end;

function IsFdAssembly(x: CorFieldAttr): Boolean;
begin
  Result := x and fdFieldAccessMask = fdAssembly;
end;

function IsFdFamily(x: CorFieldAttr): Boolean;
begin
  Result := x and fdFieldAccessMask = fdFamily;
end;

function IsFdFamORAssem(x: CorFieldAttr): Boolean;
begin
  Result := x and fdFieldAccessMask = fdFamORAssem;
end;

function IsFdPublic(x: CorFieldAttr): Boolean;
begin
  Result := x and fdFieldAccessMask = fdPublic;
end;

function IsFdStatic(x: CorFieldAttr): Boolean;
begin
  Result := x and fdStatic <> 0;
end;

function IsFdInitOnly(x: CorFieldAttr): Boolean;
begin
  Result := x and fdInitOnly <> 0;
end;

function IsFdLiteral(x: CorFieldAttr): Boolean;
begin
  Result := x and fdLiteral <> 0;
end;

function IsFdNotSerialized(x: CorFieldAttr): Boolean;
begin
  Result := x and fdNotSerialized <> 0;
end;

function IsFdPinvokeImpl(x: CorFieldAttr): Boolean;
begin
  Result := x and fdPinvokeImpl <> 0;
end;

function IsFdSpecialName(x: CorFieldAttr): Boolean;
begin
  Result := x and fdSpecialName <> 0;
end;

function IsFdHasFieldRVA(x: CorFieldAttr): Boolean;
begin
  Result := x and fdHasFieldRVA <> 0;
end;

function IsFdRTSpecialName(x: CorFieldAttr): Boolean;
begin
  Result := x and fdRTSpecialName <> 0;
end;

function IsFdHasFieldMarshal(x: CorFieldAttr): Boolean;
begin
  Result := x and fdHasFieldMarshal <> 0;
end;

function IsFdHasDefault(x: CorFieldAttr): Boolean;
begin
  Result := x and fdHasDefault <> 0;
end;

function IsPdIn(x: CorParamAttr): Boolean;
begin
  Result := x and pdIn <> 0;
end;

function IsPdOut(x: CorParamAttr): Boolean;
begin
  Result := x and pdOut <> 0;
end;

function IsPdOptional(x: CorParamAttr): Boolean;
begin
  Result := x and pdOptional <> 0;
end;

function IsPdHasDefault(x: CorParamAttr): Boolean;
begin
  Result := x and pdHasDefault <> 0;
end;

function IsPdHasFieldMarshal(x: CorParamAttr): Boolean;
begin
  Result := x and pdHasFieldMarshal <> 0;
end;

function IsPrSpecialName(x: CorPropertyAttr): Boolean;
begin
  Result := x and prSpecialName <> 0;
end;

function IsPrRTSpecialName(x: CorPropertyAttr): Boolean;
begin
  Result := x and prRTSpecialName <> 0;
end;

function IsPrHasDefault(x: CorPropertyAttr): Boolean;
begin
  Result := x and prHasDefault <> 0;
end;

function IsEvSpecialName(x: CorEventAttr): Boolean;
begin
  Result := x and evSpecialName <> 0;
end;

function IsEvRTSpecialName(x: CorEventAttr): Boolean;
begin
  Result := x and evRTSpecialName <> 0;
end;

function IsMsSetter(x: CorMethodSemanticsAttr): Boolean;
begin
  Result := x and msSetter <> 0;
end;

function IsMsGetter(x: CorMethodSemanticsAttr): Boolean;
begin
  Result := x and msGetter <> 0;
end;

function IsMsOther(x: CorMethodSemanticsAttr): Boolean;
begin
  Result := x and msOther <> 0;
end;

function IsMsAddOn(x: CorMethodSemanticsAttr): Boolean;
begin
  Result := x and msAddOn <> 0;
end;

function IsMsRemoveOn(x: CorMethodSemanticsAttr): Boolean;
begin
  Result := x and msRemoveOn <> 0;
end;

function IsMsFire(x: CorMethodSemanticsAttr): Boolean;
begin
  Result := x and msFire <> 0;
end;

function IsMiIL(x: CorMethodImpl): Boolean;
begin
  Result := x and miCodeTypeMask = miIL;
end;

function IsMiNative(x: CorMethodImpl): Boolean;
begin
  Result := x and miCodeTypeMask = miNative;
end;

function IsMiOPTIL(x: CorMethodImpl): Boolean;
begin
  Result := x and miCodeTypeMask = miOPTIL;
end;

function IsMiRuntime(x: CorMethodImpl): Boolean;
begin
  Result := x and miCodeTypeMask = miRuntime;
end;

function IsMiUnmanaged(x: CorMethodImpl): Boolean;
begin
  Result := x and miManagedMask = miUnmanaged;
end;

function IsMiManaged(x: CorMethodImpl): Boolean;
begin
  Result := x and miManagedMask = miManaged;
end;

function IsMiForwardRef(x: CorMethodImpl): Boolean;
begin
  Result := x and miForwardRef <> 0;
end;

function IsMiPreserveSig(x: CorMethodImpl): Boolean;
begin
  Result := x and miPreserveSig <> 0;
end;

function IsMiInternalCall(x: CorMethodImpl): Boolean;
begin
  Result := x and miInternalCall <> 0;
end;

function IsMiSynchronized(x: CorMethodImpl): Boolean;
begin
  Result := x and miSynchronized <> 0;
end;

function IsMiNoInlining(x: CorMethodImpl): Boolean;
begin
  Result := x and miNoInlining <> 0;
end;

function IsPmNoMangle(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmNoMangle <> 0;
end;

function IsPmCharSetNotSpec(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCharSetMask = pmCharSetNotSpec;
end;

function IsPmCharSetAnsi(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCharSetMask = pmCharSetAnsi;
end;

function IsPmCharSetUnicode(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCharSetMask = pmCharSetUnicode;
end;

function IsPmCharSetAuto(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCharSetMask = pmCharSetAuto;
end;

function IsPmSupportsLastError(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmSupportsLastError <> 0;
end;

function IsPmCallConvWinapi(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCallConvMask = pmCallConvWinapi;
end;

function IsPmCallConvCdecl(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCallConvMask = pmCallConvCdecl;
end;

function IsPmCallConvStdcall(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCallConvMask = pmCallConvStdcall;
end;

function IsPmCallConvThiscall(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCallConvMask = pmCallConvThiscall;
end;

function IsPmCallConvFastcall(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmCallConvMask = pmCallConvFastcall;
end;

function IsPmBestFitEnabled(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmBestFitMask = pmBestFitEnabled;
end;

function IsPmBestFitDisabled(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmBestFitMask = pmBestFitDisabled;
end;

function IsPmBestFitUseAssem(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmBestFitMask = pmBestFitUseAssem;
end;

function IsPmThrowOnUnmappableCharEnabled(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmThrowOnUnmappableCharMask = pmThrowOnUnmappableCharEnabled;
end;

function IsPmThrowOnUnmappableCharDisabled(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmThrowOnUnmappableCharMask = pmThrowOnUnmappableCharDisabled;
end;

function IsPmThrowOnUnmappableCharUseAssem(x: CorPInvokeMap): Boolean;
begin
  Result := x and pmThrowOnUnmappableCharMask = pmThrowOnUnmappableCharUseAssem;
end;

function IsAfRetargetable(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afRetargetable <> 0;
end;

// Macros for accessing the Processor Architecture flags of CorAssemblyFlags.
function IsAfPA_MSIL(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afPA_Mask = afPA_MSIL;
end;

function IsAfPA_x86(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afPA_Mask = afPA_x86;
end;

function IsAfPA_IA64(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afPA_Mask = afPA_IA64;
end;

function IsAfPA_AMD64(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afPA_Mask = afPA_AMD64;
end;

function IsAfPA_Specified(x: CorAssemblyFlags): Boolean;
begin
 Result := x and afPA_Specified <> 0;
end;

function PAIndex(x: CorAssemblyFlags): CorAssemblyFlags;
begin
 Result := (x and afPA_Mask) shr afPA_Shift;
end;

function PAFlag(x: CorAssemblyFlags): CorAssemblyFlags;
begin
  Result := (x shl afPA_Shift) and afPA_Mask;
end;

//#define PrepareForSaving(x) ((x) & (((x) & afPA_Specified) ? ~afPA_Specified : ~afPA_FullMask))

function IsAfEnableJITcompileTracking(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afEnableJITcompileTracking <> 0;
end;

function IsAfDisableJITcompileOptimizer(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afDisableJITcompileOptimizer <> 0;
end;

// Macros for accessing the public key flags of CorAssemblyFlags.
function IsAfPublicKey(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afPublicKey <> 0;
end;

function IsAfPublicKeyToken(x: CorAssemblyFlags): Boolean;
begin
  Result := x and afPublicKey = 0;
end;

function IsFfContainsMetaData(x: CorFileFlags): Boolean;
begin
  Result := x and ffContainsNoMetaData = 0;
end;

function IsFfContainsNoMetaData(x: CorFileFlags): Boolean;
begin
  Result := x and ffContainsNoMetaData <> 0;
end;

function IsDclActionNil(x: CorDeclSecurity): Boolean;
begin
  Result := x and dclActionMask = dclActionNil;
end;

// Is this a demand that can trigger a stackwalk?
function IsDclActionAnyStackModifier(x: CorDeclSecurity): Boolean;
begin
  Result := (x and dclActionMask = dclAssert) or (x and dclActionMask = dclDeny) or (x and dclActionMask = dclPermitOnly);
end;

function IsMrPublic(x: CorManifestResourceFlags): Boolean;
begin
  Result := x and mrVisibilityMask = mrPublic;
end;

function IsMrPrivate(x: CorManifestResourceFlags): Boolean;
begin
  Result := x and mrVisibilityMask = mrPrivate;
end;

end.

