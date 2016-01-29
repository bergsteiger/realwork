{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFPlugIn.h                             }
{          Copyright (c) 1999-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFPLUGIN__}

{$DEFINE __COREFOUNDATION_CFPLUGIN__}

{$I CFArray.inc}
{$I CFBase.inc}
{$I CFBundle.inc}
//{$I CFPlugInCOM.inc}
{$I CFString.inc}
{$I CFURL.inc}
{$I CFUUID.inc}

{$IFNDEF COREFOUNDATION_CFPLUGINCOM_SEPARATE}
  {$DEFINE COREFOUNDATION_CFPLUGINCOM_SEPARATE}
{$ENDIF !COREFOUNDATION_CFPLUGINCOM_SEPARATE}


{ ================ Standard Info.plist keys for plugIns ================ }

function kCFPlugInDynamicRegistrationKey: CFStringRef;
{$EXTERNALSYM kCFPlugInDynamicRegistrationKey}
function kCFPlugInDynamicRegisterFunctionKey: CFStringRef;
{$EXTERNALSYM kCFPlugInDynamicRegisterFunctionKey}
function kCFPlugInUnloadFunctionKey: CFStringRef;
{$EXTERNALSYM kCFPlugInUnloadFunctionKey}
function kCFPlugInFactoriesKey: CFStringRef;
{$EXTERNALSYM kCFPlugInFactoriesKey}
function kCFPlugInTypesKey: CFStringRef;
{$EXTERNALSYM kCFPlugInTypesKey}

{ ================= Function prototypes for various callbacks ================= }
{ Function types that plugIn authors can implement for various purposes. }

type
  CFPlugInDynamicRegisterFunction = function(plugIn: CFPlugInRef): Pointer; cdecl;
  {$EXTERNALSYM CFPlugInDynamicRegisterFunction}
  CFPlugInUnloadFunction = function(plugIn: CFPlugInRef): Pointer; cdecl;
  {$EXTERNALSYM CFPlugInUnloadFunction}
  CFPlugInFactoryFunction = function(allocator: CFAllocatorRef;
    typeUUID: CFUUIDRef): PPointer; cdecl;
  {$EXTERNALSYM CFPlugInFactoryFunction}

{ ================= Creating PlugIns ================= }

function CFPlugInGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInGetTypeID';
{$EXTERNALSYM CFPlugInGetTypeID}

function CFPlugInCreate(allocator: CFAllocatorRef; 
  plugInURL: CFURLRef): CFPlugInRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInCreate';
{$EXTERNALSYM CFPlugInCreate}
{ Might return an existing instance with the ref-count bumped. }

function CFPlugInGetBundle(plugIn: CFPlugInRef): CFBundleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInGetBundle';
{$EXTERNALSYM CFPlugInGetBundle}

{ ================= Controlling load on demand ================= }
{ For plugIns. }
{ PlugIns that do static registration are load on demand by default. }
{ PlugIns that do dynamic registration are not load on demand by default. }
{ A dynamic registration function can call CFPlugInSetLoadOnDemand(). }

procedure CFPlugInSetLoadOnDemand(plugIn: CFPlugInRef; flag: Boolean); cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInSetLoadOnDemand';
{$EXTERNALSYM CFPlugInSetLoadOnDemand}

function CFPlugInIsLoadOnDemand(plugIn: CFPlugInRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInIsLoadOnDemand';
{$EXTERNALSYM CFPlugInIsLoadOnDemand}

{ ================= Finding factories and creating instances ================= }
{ For plugIn hosts. }
{ Functions for finding factories to create specific types and actually creating instances of a type. }

function CFPlugInFindFactoriesForPlugInType(
  typeUUID: CFUUIDRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInFindFactoriesForPlugInType';
{$EXTERNALSYM CFPlugInFindFactoriesForPlugInType}
{ This function finds all the factories from any plugin for the given type.  Returns an array that the caller must release. }

function CFPlugInFindFactoriesForPlugInTypeInPlugIn(typeUUID: CFUUIDRef; 
  plugIn: CFPlugInRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInFindFactoriesForPlugInTypeInPlugIn';
{$EXTERNALSYM CFPlugInFindFactoriesForPlugInTypeInPlugIn}
{ This function restricts the result to factories from the given plug-in that can create the given type.  Returns an array that the caller must release. }

procedure CFPlugInInstanceCreate(allocator: CFAllocatorRef; 
  factoryUUID: CFUUIDRef; typeUUID: CFUUIDRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInInstanceCreate';
{$EXTERNALSYM CFPlugInInstanceCreate}
{ This function returns the IUnknown interface for the new instance. }

{ ================= Registering factories and types ================= }
{ For plugIn writers who must dynamically register things. }
{ Functions to register factory functions and to associate factories with types. }

function CFPlugInRegisterFactoryFunction(factoryUUID: CFUUIDRef; 
  func: CFPlugInFactoryFunction): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInRegisterFactoryFunction';
{$EXTERNALSYM CFPlugInRegisterFactoryFunction}

function CFPlugInRegisterFactoryFunctionByName(factoryUUID: CFUUIDRef; 
  plugIn: CFPlugInRef; functionName: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInRegisterFactoryFunctionByName';
{$EXTERNALSYM CFPlugInRegisterFactoryFunctionByName}

function CFPlugInUnregisterFactory(factoryUUID: CFUUIDRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInUnregisterFactory';
{$EXTERNALSYM CFPlugInUnregisterFactory}

function CFPlugInRegisterPlugInType(factoryUUID: CFUUIDRef; 
  typeUUID: CFUUIDRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInRegisterPlugInType';
{$EXTERNALSYM CFPlugInRegisterPlugInType}

function CFPlugInUnregisterPlugInType(factoryUUID: CFUUIDRef; 
  typeUUID: CFUUIDRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInUnregisterPlugInType';
{$EXTERNALSYM CFPlugInUnregisterPlugInType}

{ ================= Registering instances ================= }
{ When a new instance of a type is created, the instance is responsible for registering itself with the factory that created it and unregistering when it deallocates. }
{ This means that an instance must keep track of the CFUUIDRef of the factory that created it so it can unregister when it goes away. }

procedure CFPlugInAddInstanceForFactory(factoryID: CFUUIDRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInAddInstanceForFactory';
{$EXTERNALSYM CFPlugInAddInstanceForFactory}

procedure CFPlugInRemoveInstanceForFactory(factoryID: CFUUIDRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPlugInRemoveInstanceForFactory';
{$EXTERNALSYM CFPlugInRemoveInstanceForFactory}


{$IFNDEF COREFOUNDATION_CFPLUGINCOM_SEPARATE}
{$I CFPlugInCOM.inc}
{$ENDIF !COREFOUNDATION_CFPLUGINCOM_SEPARATE}

{$ENDIF !__COREFOUNDATION_CFPLUGIN__}

