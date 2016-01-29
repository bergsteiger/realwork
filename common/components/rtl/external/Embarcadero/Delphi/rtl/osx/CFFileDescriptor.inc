{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFFileDescriptor.h                     }
{          Copyright (c) 2006-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFFILEDESCRIPTOR__}

{$DEFINE __COREFOUNDATION_CFFILEDESCRIPTOR__}

{$I CFRunLoop.inc}

type
  CFFileDescriptorNativeDescriptor = Integer; 
  {$EXTERNALSYM CFFileDescriptorNativeDescriptor}

  PCFFileDescriptorRef = ^CFFileDescriptorRef;
  CFFileDescriptorRef = ^__CFFileDescriptor;
  {$EXTERNALSYM CFFileDescriptorRef}
  __CFFileDescriptor = record
  end;
  {$EXTERNALSYM __CFFileDescriptor}

{ Callback Reason Types }
const
  kCFFileDescriptorReadCallBack    = 1 shl 0;
  {$EXTERNALSYM kCFFileDescriptorReadCallBack}
  kCFFileDescriptorWriteCallBack   = 1 shl 1;
  {$EXTERNALSYM kCFFileDescriptorWriteCallBack}

type
  CFFileDescriptorCallBack = procedure(f: CFFileDescriptorRef; 
    callBackTypes: CFOptionFlags; info: Pointer); cdecl;
  {$EXTERNALSYM CFFileDescriptorCallBack}

  PCFFileDescriptorContext = ^CFFileDescriptorContext;
  CFFileDescriptorContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallback;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallback;
  end;
  {$EXTERNALSYM CFFileDescriptorContext}

function CFFileDescriptorGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorGetTypeID';
{$EXTERNALSYM CFFileDescriptorGetTypeID}

function CFFileDescriptorCreate(allocator: CFAllocatorRef;
  fd: CFFileDescriptorNativeDescriptor; closeOnInvalidate: Boolean;
  callout: CFFileDescriptorCallBack;
  context: PCFFileDescriptorContext): CFFileDescriptorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorCreate';
{$EXTERNALSYM CFFileDescriptorCreate}

function CFFileDescriptorGetNativeDescriptor(
  f: CFFileDescriptorRef): CFFileDescriptorNativeDescriptor; cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorGetNativeDescriptor';
{$EXTERNALSYM CFFileDescriptorGetNativeDescriptor}

procedure CFFileDescriptorGetContext(f: CFFileDescriptorRef; 
  out context: CFFileDescriptorContext); cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorGetContext';
{$EXTERNALSYM CFFileDescriptorGetContext}

procedure CFFileDescriptorEnableCallBacks(f: CFFileDescriptorRef; 
  callBackTypes: CFOptionFlags); cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorEnableCallBacks';
{$EXTERNALSYM CFFileDescriptorEnableCallBacks}
procedure CFFileDescriptorDisableCallBacks(f: CFFileDescriptorRef; 
  callBackTypes: CFOptionFlags); cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorDisableCallBacks';
{$EXTERNALSYM CFFileDescriptorDisableCallBacks}

procedure CFFileDescriptorInvalidate(f: CFFileDescriptorRef); cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorInvalidate';
{$EXTERNALSYM CFFileDescriptorInvalidate}
function CFFileDescriptorIsValid(f: CFFileDescriptorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorIsValid';
{$EXTERNALSYM CFFileDescriptorIsValid}

function CFFileDescriptorCreateRunLoopSource(allocator: CFAllocatorRef; 
  f: CFFileDescriptorRef; order: CFIndex): CFRunLoopSourceRef; cdecl;
  external CoreFoundationLib name _PU + 'CFFileDescriptorCreateRunLoopSource';
{$EXTERNALSYM CFFileDescriptorCreateRunLoopSource}



{$ENDIF !__COREFOUNDATION_CFFILEDESCRIPTOR__}

