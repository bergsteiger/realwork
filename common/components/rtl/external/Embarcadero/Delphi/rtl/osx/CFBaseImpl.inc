{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
  {$EXTERNALSYM _PU}
{$ENDIF}


var
  _kCFCoreFoundationVersionNumber: Pointer = nil;


function kCFCoreFoundationVersionNumber: Double;
begin
  if _kCFCoreFoundationVersionNumber = nil then
    _kCFCoreFoundationVersionNumber := dlsym(CFModule, MarshaledAString('kCFCoreFoundationVersionNumber'));
  Result := Double(_kCFCoreFoundationVersionNumber^);
end;

function CFRangeMake(loc: CFIndex; len: CFIndex): CFRange;
begin
  Result.location := loc;
  Result.length := len;
end;


{ Null representant }

var
  _kCFNull: Pointer = nil;
  _kCFAllocatorDefault: Pointer = nil;
  _kCFAllocatorSystemDefault: Pointer = nil;
  _kCFAllocatorMalloc: Pointer = nil;
  _kCFAllocatorMallocZone: Pointer = nil;
  _kCFAllocatorNull: Pointer = nil;
  _kCFAllocatorUseContext: Pointer = nil;

function CFNullGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFNullGetTypeID';


function kCFNull: CFNullRef;
begin
  if _kCFNull = nil then
    _kCFNull := dlsym(CFModule, MarshaledAString('kCFNull'));
  Result := CFNullRef(_kCFNull^);
end;


{ Allocator API }

function kCFAllocatorDefault: CFAllocatorRef;
begin
  if _kCFAllocatorDefault = nil then
    _kCFAllocatorDefault := dlsym(CFModule, MarshaledAString('kCFAllocatorDefault'));
  Result := CFAllocatorRef(_kCFAllocatorDefault^);
end;

function kCFAllocatorSystemDefault: CFAllocatorRef;
begin
  if _kCFAllocatorSystemDefault = nil then
    _kCFAllocatorSystemDefault := dlsym(CFModule, MarshaledAString('kCFAllocatorSystemDefault'));
  Result := CFAllocatorRef(_kCFAllocatorSystemDefault^);
end;

function kCFAllocatorMalloc: CFAllocatorRef;
begin
  if _kCFAllocatorMalloc = nil then
    _kCFAllocatorMalloc := dlsym(CFModule, MarshaledAString('kCFAllocatorMalloc'));
  Result := CFAllocatorRef(_kCFAllocatorMalloc^);
end;

function kCFAllocatorMallocZone: CFAllocatorRef;
begin
  if _kCFAllocatorMallocZone = nil then
    _kCFAllocatorMallocZone := dlsym(CFModule, MarshaledAString('kCFAllocatorMallocZone'));
  Result := CFAllocatorRef(_kCFAllocatorMallocZone^);
end;

function kCFAllocatorNull: CFAllocatorRef;
begin
  if _kCFAllocatorNull = nil then
    _kCFAllocatorNull := dlsym(CFModule, MarshaledAString('kCFAllocatorNull'));
  Result := CFAllocatorRef(_kCFAllocatorNull^);
end;

function kCFAllocatorUseContext: CFAllocatorRef;
begin
  if _kCFAllocatorUseContext = nil then
    _kCFAllocatorUseContext := dlsym(CFModule, MarshaledAString('kCFAllocatorUseContext'));
  Result := CFAllocatorRef(_kCFAllocatorUseContext^);
end;

function CFAllocatorGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorGetTypeID';

procedure CFAllocatorSetDefault(allocator: CFAllocatorRef); cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorSetDefault';

function CFAllocatorGetDefault: CFAllocatorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorGetDefault';

function CFAllocatorCreate(allocator: CFAllocatorRef;
  context: PCFAllocatorContext): CFAllocatorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorCreate';

function CFAllocatorAllocate(allocator: CFAllocatorRef; size: CFIndex;
  hint: CFOptionFlags): Pointer; cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorAllocate';

function CFAllocatorReallocate(allocator: CFAllocatorRef; ptr: Pointer;
  newsize: CFIndex; hint: CFOptionFlags): Pointer; cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorReallocate';

procedure CFAllocatorDeallocate(allocator: CFAllocatorRef; ptr: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorDeallocate';

function CFAllocatorGetPreferredSizeForSize(allocator: CFAllocatorRef;
  size: CFIndex; hint: CFOptionFlags): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorGetPreferredSizeForSize';

procedure CFAllocatorGetContext(allocator: CFAllocatorRef;
  context: PCFAllocatorContext); cdecl;
  external CoreFoundationLib name _PU + 'CFAllocatorGetContext';


{ Polymorphic CF functions }

function CFGetTypeID(cf: CFTypeRef): CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFGetTypeID';

function CFCopyTypeIDDescription(type_id: CFTypeID): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFCopyTypeIDDescription';

function CFRetain(cf: CFTypeRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFRetain';

procedure CFRelease(cf: CFTypeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRelease';

function CFGetRetainCount(cf: CFTypeRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFGetRetainCount';

function CFMakeCollectable(cf: CFTypeRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFMakeCollectable';

function CFEqual(cf1: CFTypeRef; cf2: CFTypeRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFEqual';

function CFHash(cf: CFTypeRef): CFHashCode; cdecl;
  external CoreFoundationLib name _PU + 'CFHash';

function CFCopyDescription(cf: CFTypeRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFCopyDescription';

function CFGetAllocator(cf: CFTypeRef): CFAllocatorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFGetAllocator';
