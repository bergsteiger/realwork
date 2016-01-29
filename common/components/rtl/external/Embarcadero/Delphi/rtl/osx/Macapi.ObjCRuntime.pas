{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Macapi.ObjCRuntime;

{$WEAKPACKAGEUNIT}

interface


const
  libobjc = '/usr/lib/libobjc.dylib';

  YES: Integer = 1;
  NO: Integer = 0;
  
type
  SEL = Pointer;
  obj_super = packed record
    receiver: Pointer;
    cls: Pointer;
  end;
  Pobj_super = ^obj_super;

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
  {$EXTERNALSYM _PU}
{$ENDIF}

// Exported C methods in the Objective-C runtime
function objc_getClass(const name: MarshaledAString): Pointer; cdecl;
  external libobjc name _PU + 'objc_getClass';
function objc_getClassList(buffer: Pointer; bufferLen: Integer): Integer; cdecl;
  external libobjc name _PU + 'objc_getClassList';
function objc_allocateClassPair(superclass: Pointer; name: MarshaledAString; ExtraBytes: Longword)
  : Pointer; cdecl; external libobjc name _PU + 'objc_allocateClassPair';
procedure objc_registerClassPair(Cls: Pointer); cdecl;
  external libobjc name _PU + 'objc_registerClassPair';
function objc_addClass(Cls: Pointer): Integer; cdecl; external libobjc name _PU + 'objc_addClass';

function objc_msgSend(theReceiver: Pointer; theSelector: Pointer): Pointer; cdecl; varargs;
  external libobjc name _PU + 'objc_msgSend';

function objc_msgSend_stret(theReceiver: Pointer; theSelector: Pointer): Extended; cdecl; varargs;
  external libobjc name _PU + 'objc_msgSend_stret';

function objc_msgSend_fpret(theReceiver: Pointer; theSelector: Pointer): Extended; cdecl; varargs;
  external libobjc name _PU + 'objc_msgSend_fpret';

function objc_msgSendSuper(theReceiver: Pobj_super; theSelector: Pointer): Pointer; cdecl; varargs;
  external libobjc name _PU + 'objc_msgSendSuper';

function objc_msgSendSuper_stret(theReceiver: Pobj_super; theSelector: Pointer): Extended; cdecl; varargs;
  external libobjc name _PU + 'objc_msgSendSuper_stret';

function objc_getProtocol(const name: MarshaledAString): Pointer; cdecl; external libobjc name _PU + 'objc_getProtocol';

function sel_getUid(const str: MarshaledAString): SEL; cdecl; external libobjc name _PU + 'sel_getUid';
function sel_registerName(const str: MarshaledAString): SEL; cdecl; external libobjc name _PU + 'sel_registerName';
function sel_getName(Selector: Pointer): MarshaledAString; cdecl; external libobjc name _PU + 'sel_getName';
function class_copyMethodList(Cls: Pointer; var OutCount: Integer): Pointer; cdecl; external libobjc name _PU + 'class_copyMethodList';
function class_addMethod(Cls: Pointer; theSelector: Pointer; Impl: Pointer; types: MarshaledAString)
  : Integer; cdecl; external libobjc name _PU + 'class_addMethod';
function class_addIvar(Cls: Pointer; name: MarshaledAString; Size: Integer; alignment: Byte;
  types: MarshaledAString): Integer; cdecl; external libobjc name _PU + 'class_addIvar';
function class_addProtocol(Cls: Pointer; protocol: Pointer): Integer; cdecl; external libobjc name _PU + 'class_addProtocol';
function class_getInstanceMethod(Cls: Pointer; Selector: Pointer): Pointer; cdecl;
  external libobjc name _PU + 'class_getInstanceMethod';
function class_getClassMethod(Cls: Pointer; Selector: Pointer): Pointer; cdecl;
  external libobjc name _PU + 'class_getClassMethod';
function class_getName(Cls: Pointer): MarshaledAString; cdecl; external libobjc name _PU + 'class_getName';
function object_getInstanceVariable(obj: Pointer; name: MarshaledAString; out value: Pointer): Pointer;
  cdecl; external libobjc name _PU + 'object_getInstanceVariable';
function object_getClass(obj: Pointer): Pointer;
  cdecl; external libobjc name _PU + 'object_getClass';
function object_setInstanceVariable(obj: Pointer; name: MarshaledAString; value: Pointer): Pointer; cdecl;
  external libobjc name _PU + 'object_setInstanceVariable';
function method_getTypeEncoding(Method: Pointer): MarshaledAString; cdecl;
  external libobjc name _PU + 'method_getTypeEncoding';
function   method_getImplementation(Method: Pointer): Pointer; cdecl;
  external libobjc name _PU + 'method_getImplementation';
function   method_setImplementation(Method: Pointer; Imp: Pointer): Pointer; cdecl;
  external libobjc name _PU + 'method_setImplementation';

procedure method_exchangeImplementations(Method1, Method2: Pointer); cdecl;
  external libobjc name _PU + 'method_exchangeImplementations';

implementation

end.
