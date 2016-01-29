{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFPreferences.h                        }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFPREFERENCES__}

{$DEFINE __COREFOUNDATION_CFPREFERENCES__}

{$I CFArray.inc}
{$I CFBase.inc}
{$I CFString.inc}


function kCFPreferencesAnyApplication: CFStringRef;
{$EXTERNALSYM kCFPreferencesAnyApplication}
function kCFPreferencesCurrentApplication: CFStringRef;
{$EXTERNALSYM kCFPreferencesCurrentApplication}
function kCFPreferencesAnyHost: CFStringRef;
{$EXTERNALSYM kCFPreferencesAnyHost}
function kCFPreferencesCurrentHost: CFStringRef;
{$EXTERNALSYM kCFPreferencesCurrentHost}
function kCFPreferencesAnyUser: CFStringRef;
{$EXTERNALSYM kCFPreferencesAnyUser}
function kCFPreferencesCurrentUser: CFStringRef;
{$EXTERNALSYM kCFPreferencesCurrentUser}

{ NOTE: All CFPropertyListRef values returned from
         CFPreferences API should be assumed to be immutable.
 }

{ 	The "App" functions search the various sources of defaults that
	apply to the given application, and should never be called with
	kCFPreferencesAnyApplication - only kCFPreferencesCurrentApplication
	or an application's ID (its bundle identifier).
 }

{ Searches the various sources of application defaults to find the
value for the given key. key must not be NULL.  If a value is found,
it returns it; otherwise returns NULL.  Caller must release the
returned value }
function CFPreferencesCopyAppValue(key: CFStringRef; 
  applicationID: CFStringRef): CFPropertyListRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesCopyAppValue';
{$EXTERNALSYM CFPreferencesCopyAppValue}

{ Convenience to interpret a preferences value as a boolean directly.
Returns false if the key doesn't exist, or has an improper format; under
those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to false }
function CFPreferencesGetAppBooleanValue(key: CFStringRef; 
  applicationID: CFStringRef; 
  keyExistsAndHasValidFormat: PBoolean): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesGetAppBooleanValue';
{$EXTERNALSYM CFPreferencesGetAppBooleanValue}

{ Convenience to interpret a preferences value as an integer directly.
Returns 0 if the key doesn't exist, or has an improper format; under
those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to false }
function CFPreferencesGetAppIntegerValue(key: CFStringRef; 
  applicationID: CFStringRef; 
  keyExistsAndHasValidFormat: PBoolean): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesGetAppIntegerValue';
{$EXTERNALSYM CFPreferencesGetAppIntegerValue}

{ Sets the given value for the given key in the "normal" place for
application preferences.  key must not be NULL.  If value is NULL,
key is removed instead. }
procedure CFPreferencesSetAppValue(key: CFStringRef; value: CFPropertyListRef; 
  applicationID: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesSetAppValue';
{$EXTERNALSYM CFPreferencesSetAppValue}

{ Adds the preferences for the given suite to the app preferences for
   the specified application.  To write to the suite domain, use
   CFPreferencesSetValue(), below, using the suiteName in place
   of the appName }
procedure CFPreferencesAddSuitePreferencesToApp(applicationID: CFStringRef; 
  suiteID: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesAddSuitePreferencesToApp';
{$EXTERNALSYM CFPreferencesAddSuitePreferencesToApp}

procedure CFPreferencesRemoveSuitePreferencesFromApp(applicationID: CFStringRef; 
  suiteID: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesRemoveSuitePreferencesFromApp';
{$EXTERNALSYM CFPreferencesRemoveSuitePreferencesFromApp}

{ Writes all changes in all sources of application defaults.
Returns success or failure. }
function CFPreferencesAppSynchronize(
  applicationID: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesAppSynchronize';
{$EXTERNALSYM CFPreferencesAppSynchronize}

{ The primitive get mechanism; all arguments must be non-NULL
(use the constants above for common values).  Only the exact
location specified by app-user-host is searched.  The returned
CFType must be released by the caller when it is finished with it. }
function CFPreferencesCopyValue(key: CFStringRef; applicationID: CFStringRef; 
  userName: CFStringRef; hostName: CFStringRef): CFPropertyListRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesCopyValue';
{$EXTERNALSYM CFPreferencesCopyValue}

{ Convenience to fetch multiple keys at once.  Keys in 
keysToFetch that are not present in the returned dictionary
are not present in the domain.  If keysToFetch is NULL, all
keys are fetched. }
function CFPreferencesCopyMultiple(keysToFetch: CFArrayRef; 
  applicationID: CFStringRef; userName: CFStringRef; 
  hostName: CFStringRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesCopyMultiple';
{$EXTERNALSYM CFPreferencesCopyMultiple}

{ The primitive set function; all arguments except value must be
non-NULL.  If value is NULL, the given key is removed }
procedure CFPreferencesSetValue(key: CFStringRef; value: CFPropertyListRef; 
  applicationID: CFStringRef; userName: CFStringRef; 
  hostName: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesSetValue';
{$EXTERNALSYM CFPreferencesSetValue}

{ Convenience to set multiple values at once.  Behavior is undefined
if a key is in both keysToSet and keysToRemove }
procedure CFPreferencesSetMultiple(keysToSet: CFDictionaryRef; 
  keysToRemove: CFArrayRef; applicationID: CFStringRef; userName: CFStringRef; 
  hostName: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesSetMultiple';
{$EXTERNALSYM CFPreferencesSetMultiple}

function CFPreferencesSynchronize(applicationID: CFStringRef; 
  userName: CFStringRef; hostName: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesSynchronize';
{$EXTERNALSYM CFPreferencesSynchronize}

{ Constructs and returns the list of the name of all applications
which have preferences in the scope of the given user and host.
The returned value must be released by the caller; neither argument
may be NULL. }
function CFPreferencesCopyApplicationList(userName: CFStringRef; 
  hostName: CFStringRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesCopyApplicationList';
{$EXTERNALSYM CFPreferencesCopyApplicationList}

{ Constructs and returns the list of all keys set in the given
location.  The returned value must be released by the caller;
all arguments must be non-NULL }
function CFPreferencesCopyKeyList(applicationID: CFStringRef; 
  userName: CFStringRef; hostName: CFStringRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesCopyKeyList';
{$EXTERNALSYM CFPreferencesCopyKeyList}

{ Function to determine whether or not a given key has been imposed on the
user - In cases where machines and/or users are under some kind of management,
callers should use this function to determine whether or not to disable UI elements
corresponding to those preference keys. }
function CFPreferencesAppValueIsForced(key: CFStringRef;
  applicationID: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPreferencesAppValueIsForced';
{$EXTERNALSYM CFPreferencesAppValueIsForced}

{$ENDIF !__COREFOUNDATION_CFPREFERENCES__}

