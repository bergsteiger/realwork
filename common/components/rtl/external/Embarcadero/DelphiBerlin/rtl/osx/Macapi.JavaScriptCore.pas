{***********************************************************}
{                                                           }
{             CodeGear Delphi Runtime Library               }
{                                                           }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.          }
{              All rights reserved                          }
{                                                           }
{***********************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework JavaScriptCore
//

unit Macapi.JavaScriptCore;

interface

uses
  Posix.StdDef,
  Macapi.CocoaTypes,
  Macapi.CoreFoundation;

const
  kJSTypeUndefined = 0;
  kJSTypeNull = 1;
  kJSTypeBoolean = 2;
  kJSTypeNumber = 3;
  kJSTypeString = 4;
  kJSTypeObject = 5;
  kJSPropertyAttributeNone = 0;
  kJSPropertyAttributeReadOnly = 1 shl 1;
  kJSPropertyAttributeDontEnum = 1 shl 2;
  kJSPropertyAttributeDontDelete = 1 shl 3;
  kJSClassAttributeNone = 0;
  kJSClassAttributeNoAutomaticPrototype = 1 shl 1;

type
  // ===== Framework typedefs =====
{$M+}
  JSContextGroupRef = Pointer;
  JSContextRef = Pointer;
  JSGlobalContextRef = Pointer;
  JSStringRef = Pointer;
  JSClassRef = Pointer;
  JSPropertyNameArrayRef = Pointer;
  JSPropertyNameAccumulatorRef = Pointer;
  JSValueRef = Pointer;
  JSObjectRef = Pointer;
  JSType = UInt32;
  JSPropertyAttributes = Cardinal;
  JSClassAttributes = Cardinal;
  JSObjectInitializeCallback = procedure(param1: JSContextRef; param2: JSObjectRef); cdecl;
  JSObjectFinalizeCallback = procedure(param1: JSObjectRef); cdecl;
  JSObjectHasPropertyCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: JSStringRef)
    : Integer; cdecl;
  JSObjectGetPropertyCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: JSStringRef;
    param4: JSValueRef): JSValueRef; cdecl;
  JSObjectSetPropertyCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: JSStringRef;
    param4: JSValueRef; param5: JSValueRef): Integer; cdecl;
  JSObjectDeletePropertyCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: JSStringRef;
    param4: JSValueRef): Integer; cdecl;
  JSObjectGetPropertyNamesCallback = procedure(param1: JSContextRef; param2: JSObjectRef;
    param3: JSPropertyNameAccumulatorRef); cdecl;
  JSObjectCallAsFunctionCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: JSObjectRef;
    param4: size_t; param5: JSValueRef; param6: JSValueRef): JSValueRef; cdecl;
  JSObjectCallAsConstructorCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: size_t;
    param4: JSValueRef; param5: JSValueRef): JSObjectRef; cdecl;
  JSObjectHasInstanceCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: JSValueRef;
    param4: JSValueRef): Integer; cdecl;
  JSObjectConvertToTypeCallback = function(param1: JSContextRef; param2: JSObjectRef; param3: JSType;
    param4: JSValueRef): JSValueRef; cdecl;

  JSStaticValue = record
{$IFDEF NEXTGEN}
    name: PByte;                                                                 
{$ELSE  NEXTGEN}
    name: AnsiChar;
{$ENDIF NEXTGEN}
    getProperty: JSObjectGetPropertyCallback;
    setProperty: JSObjectSetPropertyCallback;
    attributes: JSPropertyAttributes;
  end;

  PJSStaticValue = ^JSStaticValue;

  JSStaticFunction = record
{$IFDEF NEXTGEN}
    name: PByte;                                                                 
{$ELSE  NEXTGEN}
    name: AnsiChar;
{$ENDIF NEXTGEN}
    callAsFunction: JSObjectCallAsFunctionCallback;
    attributes: JSPropertyAttributes;
  end;

  PJSStaticFunction = ^JSStaticFunction;

  JSClassDefinition = record
    version: Integer;
    attributes: JSClassAttributes;
{$IFDEF NEXTGEN}
    className: PByte;                                                                 
{$ELSE  NEXTGEN}
    className: AnsiChar;
{$ENDIF NEXTGEN}
    parentClass: JSClassRef;
    staticValues: Pointer;
    staticFunctions: Pointer;
    initialize: JSObjectInitializeCallback;
    finalize: JSObjectFinalizeCallback;
    hasProperty: JSObjectHasPropertyCallback;
    getProperty: JSObjectGetPropertyCallback;
    setProperty: JSObjectSetPropertyCallback;
    deleteProperty: JSObjectDeletePropertyCallback;
    getPropertyNames: JSObjectGetPropertyNamesCallback;
    callAsFunction: JSObjectCallAsFunctionCallback;
    callAsConstructor: JSObjectCallAsConstructorCallback;
    hasInstance: JSObjectHasInstanceCallback;
    convertToType: JSObjectConvertToTypeCallback;
  end;

  PJSClassDefinition = ^JSClassDefinition;

  JSChar = Word;
  // ===== External functions =====

const
  libJavaScriptCore = '/System/Library/Frameworks/JavaScriptCore.framework/JavaScriptCore';

function JSEvaluateScript(ctx: JSContextRef; script: JSStringRef; thisObject: JSObjectRef; sourceURL: JSStringRef;
  startingLineNumber: Integer; exception: JSValueRef): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSEvaluateScript';
function JSCheckScriptSyntax(ctx: JSContextRef; script: JSStringRef; sourceURL: JSStringRef;
  startingLineNumber: Integer; exception: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSCheckScriptSyntax';
procedure JSGarbageCollect(ctx: JSContextRef); cdecl; external libJavaScriptCore name _PU + 'JSGarbageCollect';
function JSValueGetType(ctx: JSContextRef; param1: JSValueRef): JSType; cdecl;
  external libJavaScriptCore name _PU + 'JSValueGetType';
function JSValueIsUndefined(ctx: JSContextRef; value: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsUndefined';
function JSValueIsNull(ctx: JSContextRef; value: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsNull';
function JSValueIsBoolean(ctx: JSContextRef; value: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsBoolean';
function JSValueIsNumber(ctx: JSContextRef; value: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsNumber';
function JSValueIsString(ctx: JSContextRef; value: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsString';
function JSValueIsObject(ctx: JSContextRef; value: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsObject';
function JSValueIsObjectOfClass(ctx: JSContextRef; value: JSValueRef; jsClass: JSClassRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsObjectOfClass';
function JSValueIsEqual(ctx: JSContextRef; a: JSValueRef; b: JSValueRef; exception: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsEqual';
function JSValueIsStrictEqual(ctx: JSContextRef; a: JSValueRef; b: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueIsStrictEqual';
function JSValueIsInstanceOfConstructor(ctx: JSContextRef; value: JSValueRef; &constructor: JSObjectRef;
  exception: JSValueRef): Integer; cdecl; external libJavaScriptCore name _PU + 'JSValueIsInstanceOfConstructor';
function JSValueMakeUndefined(ctx: JSContextRef): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSValueMakeUndefined';
function JSValueMakeNull(ctx: JSContextRef): JSValueRef; cdecl; external libJavaScriptCore name _PU + 'JSValueMakeNull';
function JSValueMakeBoolean(ctx: JSContextRef; boolean: Integer): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSValueMakeBoolean';
function JSValueMakeNumber(ctx: JSContextRef; number: Double): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSValueMakeNumber';
function JSValueMakeString(ctx: JSContextRef; &string: JSStringRef): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSValueMakeString';
function JSValueMakeFromJSONString(ctx: JSContextRef; &string: JSStringRef): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSValueMakeFromJSONString';
function JSValueCreateJSONString(ctx: JSContextRef; value: JSValueRef; indent: Cardinal; exception: JSValueRef)
  : JSStringRef; cdecl; external libJavaScriptCore name _PU + 'JSValueCreateJSONString';
function JSValueToBoolean(ctx: JSContextRef; value: JSValueRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSValueToBoolean';
function JSValueToNumber(ctx: JSContextRef; value: JSValueRef; exception: JSValueRef): Double; cdecl;
  external libJavaScriptCore name _PU + 'JSValueToNumber';
function JSValueToStringCopy(ctx: JSContextRef; value: JSValueRef; exception: JSValueRef): JSStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSValueToStringCopy';
function JSValueToObject(ctx: JSContextRef; value: JSValueRef; exception: JSValueRef): JSObjectRef; cdecl;
  external libJavaScriptCore name _PU + 'JSValueToObject';
procedure JSValueProtect(ctx: JSContextRef; value: JSValueRef); cdecl;
  external libJavaScriptCore name _PU + 'JSValueProtect';
procedure JSValueUnprotect(ctx: JSContextRef; value: JSValueRef); cdecl;
  external libJavaScriptCore name _PU + 'JSValueUnprotect';
function JSClassCreate(definition: Pointer): JSClassRef; cdecl; external libJavaScriptCore name _PU + 'JSClassCreate';
function JSClassRetain(jsClass: JSClassRef): JSClassRef; cdecl; external libJavaScriptCore name _PU + 'JSClassRetain';
procedure JSClassRelease(jsClass: JSClassRef); cdecl; external libJavaScriptCore name _PU + 'JSClassRelease';
function JSObjectMake(ctx: JSContextRef; jsClass: JSClassRef; data: Pointer): JSObjectRef; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectMake';
function JSObjectMakeFunctionWithCallback(ctx: JSContextRef; name: JSStringRef;
  callAsFunction: JSObjectCallAsFunctionCallback): JSObjectRef; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectMakeFunctionWithCallback';
function JSObjectMakeConstructor(ctx: JSContextRef; jsClass: JSClassRef;
  callAsConstructor: JSObjectCallAsConstructorCallback): JSObjectRef; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectMakeConstructor';
function JSObjectMakeArray(ctx: JSContextRef; argumentCount: size_t; arguments: JSValueRef; exception: JSValueRef)
  : JSObjectRef; cdecl; external libJavaScriptCore name _PU + 'JSObjectMakeArray';
function JSObjectMakeDate(ctx: JSContextRef; argumentCount: size_t; arguments: JSValueRef; exception: JSValueRef)
  : JSObjectRef; cdecl; external libJavaScriptCore name _PU + 'JSObjectMakeDate';
function JSObjectMakeError(ctx: JSContextRef; argumentCount: size_t; arguments: JSValueRef; exception: JSValueRef)
  : JSObjectRef; cdecl; external libJavaScriptCore name _PU + 'JSObjectMakeError';
function JSObjectMakeRegExp(ctx: JSContextRef; argumentCount: size_t; arguments: JSValueRef; exception: JSValueRef)
  : JSObjectRef; cdecl; external libJavaScriptCore name _PU + 'JSObjectMakeRegExp';
function JSObjectMakeFunction(ctx: JSContextRef; name: JSStringRef; parameterCount: Cardinal;
  parameterNames: JSStringRef; body: JSStringRef; sourceURL: JSStringRef; startingLineNumber: Integer;
  exception: JSValueRef): JSObjectRef; cdecl; external libJavaScriptCore name _PU + 'JSObjectMakeFunction';
function JSObjectGetPrototype(ctx: JSContextRef; &object: JSObjectRef): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectGetPrototype';
procedure JSObjectSetPrototype(ctx: JSContextRef; &object: JSObjectRef; value: JSValueRef); cdecl;
  external libJavaScriptCore name _PU + 'JSObjectSetPrototype';
function JSObjectHasProperty(ctx: JSContextRef; &object: JSObjectRef; propertyName: JSStringRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectHasProperty';
function JSObjectGetProperty(ctx: JSContextRef; &object: JSObjectRef; propertyName: JSStringRef; exception: JSValueRef)
  : JSValueRef; cdecl; external libJavaScriptCore name _PU + 'JSObjectGetProperty';
procedure JSObjectSetProperty(ctx: JSContextRef; &object: JSObjectRef; propertyName: JSStringRef; value: JSValueRef;
  attributes: JSPropertyAttributes; exception: JSValueRef); cdecl;
  external libJavaScriptCore name _PU + 'JSObjectSetProperty';
function JSObjectDeleteProperty(ctx: JSContextRef; &object: JSObjectRef; propertyName: JSStringRef;
  exception: JSValueRef): Integer; cdecl; external libJavaScriptCore name _PU + 'JSObjectDeleteProperty';
function JSObjectGetPropertyAtIndex(ctx: JSContextRef; &object: JSObjectRef; propertyIndex: Cardinal;
  exception: JSValueRef): JSValueRef; cdecl; external libJavaScriptCore name _PU + 'JSObjectGetPropertyAtIndex';
procedure JSObjectSetPropertyAtIndex(ctx: JSContextRef; &object: JSObjectRef; propertyIndex: Cardinal;
  value: JSValueRef; exception: JSValueRef); cdecl; external libJavaScriptCore name _PU + 'JSObjectSetPropertyAtIndex';
function JSObjectGetPrivate(&object: JSObjectRef): Pointer; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectGetPrivate';
function JSObjectSetPrivate(&object: JSObjectRef; data: Pointer): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectSetPrivate';
function JSObjectIsFunction(ctx: JSContextRef; &object: JSObjectRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectIsFunction';
function JSObjectCallAsFunction(ctx: JSContextRef; &object: JSObjectRef; thisObject: JSObjectRef;
  argumentCount: size_t; arguments: JSValueRef; exception: JSValueRef): JSValueRef; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectCallAsFunction';
function JSObjectIsConstructor(ctx: JSContextRef; &object: JSObjectRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectIsConstructor';
function JSObjectCallAsConstructor(ctx: JSContextRef; &object: JSObjectRef; argumentCount: size_t;
  arguments: JSValueRef; exception: JSValueRef): JSObjectRef; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectCallAsConstructor';
function JSObjectCopyPropertyNames(ctx: JSContextRef; &object: JSObjectRef): JSPropertyNameArrayRef; cdecl;
  external libJavaScriptCore name _PU + 'JSObjectCopyPropertyNames';
function JSPropertyNameArrayRetain(&array: JSPropertyNameArrayRef): JSPropertyNameArrayRef; cdecl;
  external libJavaScriptCore name _PU + 'JSPropertyNameArrayRetain';
procedure JSPropertyNameArrayRelease(&array: JSPropertyNameArrayRef); cdecl;
  external libJavaScriptCore name _PU + 'JSPropertyNameArrayRelease';
function JSPropertyNameArrayGetCount(&array: JSPropertyNameArrayRef): size_t; cdecl;
  external libJavaScriptCore name _PU + 'JSPropertyNameArrayGetCount';
function JSPropertyNameArrayGetNameAtIndex(&array: JSPropertyNameArrayRef; index: size_t): JSStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSPropertyNameArrayGetNameAtIndex';
procedure JSPropertyNameAccumulatorAddName(accumulator: JSPropertyNameAccumulatorRef; propertyName: JSStringRef); cdecl;
  external libJavaScriptCore name _PU + 'JSPropertyNameAccumulatorAddName';
function JSContextGroupCreate: JSContextGroupRef; cdecl; external libJavaScriptCore name _PU + 'JSContextGroupCreate';
function JSContextGroupRetain(group: JSContextGroupRef): JSContextGroupRef; cdecl;
  external libJavaScriptCore name _PU + 'JSContextGroupRetain';
procedure JSContextGroupRelease(group: JSContextGroupRef); cdecl;
  external libJavaScriptCore name _PU + 'JSContextGroupRelease';
function JSGlobalContextCreate(globalObjectClass: JSClassRef): JSGlobalContextRef; cdecl;
  external libJavaScriptCore name _PU + 'JSGlobalContextCreate';
function JSGlobalContextCreateInGroup(group: JSContextGroupRef; globalObjectClass: JSClassRef): JSGlobalContextRef;
  cdecl; external libJavaScriptCore name _PU + 'JSGlobalContextCreateInGroup';
function JSGlobalContextRetain(ctx: JSGlobalContextRef): JSGlobalContextRef; cdecl;
  external libJavaScriptCore name _PU + 'JSGlobalContextRetain';
procedure JSGlobalContextRelease(ctx: JSGlobalContextRef); cdecl;
  external libJavaScriptCore name _PU + 'JSGlobalContextRelease';
function JSContextGetGlobalObject(ctx: JSContextRef): JSObjectRef; cdecl;
  external libJavaScriptCore name _PU + 'JSContextGetGlobalObject';
function JSContextGetGroup(ctx: JSContextRef): JSContextGroupRef; cdecl;
  external libJavaScriptCore name _PU + 'JSContextGetGroup';
function JSStringCreateWithCharacters(chars: JSChar; numChars: size_t): JSStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSStringCreateWithCharacters';
{$IFDEF NEXTGEN}
function JSStringCreateWithUTF8CString(&string: PByte): JSStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSStringCreateWithUTF8CString';                                                                 
{$ELSE  NEXTGEN}
function JSStringCreateWithUTF8CString(&string: AnsiChar): JSStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSStringCreateWithUTF8CString';
{$ENDIF NEXTGEN}
function JSStringRetain(&string: JSStringRef): JSStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSStringRetain';
procedure JSStringRelease(&string: JSStringRef); cdecl; external libJavaScriptCore name _PU + 'JSStringRelease';
function JSStringGetLength(&string: JSStringRef): size_t; cdecl;
  external libJavaScriptCore name _PU + 'JSStringGetLength';
function JSStringGetCharactersPtr(&string: JSStringRef): JSChar; cdecl;
  external libJavaScriptCore name _PU + 'JSStringGetCharactersPtr';
function JSStringGetMaximumUTF8CStringSize(&string: JSStringRef): size_t; cdecl;
  external libJavaScriptCore name _PU + 'JSStringGetMaximumUTF8CStringSize';
{$IFDEF NEXTGEN}
function JSStringGetUTF8CString(&string: JSStringRef; buffer: PByte; bufferSize: size_t): size_t; cdecl;
  external libJavaScriptCore name _PU + 'JSStringGetUTF8CString';                                                                 
{$ELSE  NEXTGEN}
function JSStringGetUTF8CString(&string: JSStringRef; buffer: AnsiChar; bufferSize: size_t): size_t; cdecl;
  external libJavaScriptCore name _PU + 'JSStringGetUTF8CString';
{$ENDIF NEXTGEN}
function JSStringIsEqual(a: JSStringRef; b: JSStringRef): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSStringIsEqual';
{$IFDEF NEXTGEN}
function JSStringIsEqualToUTF8CString(a: JSStringRef; b: PByte): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSStringIsEqualToUTF8CString';                                                                 
{$ELSE  NEXTGEN}
function JSStringIsEqualToUTF8CString(a: JSStringRef; b: AnsiChar): Integer; cdecl;
  external libJavaScriptCore name _PU + 'JSStringIsEqualToUTF8CString';
{$ENDIF NEXTGEN}
function JSStringCreateWithCFString(&string: CFStringRef): JSStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSStringCreateWithCFString';
function JSStringCopyCFString(alloc: CFAllocatorRef; &string: JSStringRef): CFStringRef; cdecl;
  external libJavaScriptCore name _PU + 'JSStringCopyCFString';

implementation

uses System.SysUtils;

var
  JavaScriptCoreModule: HMODULE;


initialization
  JavaScriptCoreModule := LoadLibrary(libJavaScriptCore);

finalization
  if JavaScriptCoreModule <> 0 then
    FreeLibrary(JavaScriptCoreModule);

end.
