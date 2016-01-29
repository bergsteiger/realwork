{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFAttributedString.h                   }
{          Copyright (c) 2004-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ ! @header CFAttributedString
Instance of CFAttributedString manage character strings and associated sets
of attributes (for example, font and kerning) that apply to individual
characters or ranges of characters in the string. CFAttributedString as
defined in CoreFoundation provides the basic container functionality, while
higher levels provide definitions for standard attributes, their values,
and additional behaviors involving these.

CFAttributedString is not a "subclass" of CFString; that is, it does not
respond to CFString function calls. CFAttributedString conceptually contains
a CFString to which it applies attributes. This protects users of attributed
strings from ambiguities caused by the semantic differences between simple
and attributed string.

Attributes are identified by key/value pairs stored in CFDictionaryRefs.
Keys must be CFStrings, while the values are arbitrary CFTypeRefs.
 }

{$IFNDEF __COREFOUNDATION_CFATTRIBUTEDSTRING__}

{$DEFINE __COREFOUNDATION_CFATTRIBUTEDSTRING__}

{$I CFBase.inc}
{$I CFDictionary.inc}
{$I CFString.inc}


{ CFAttributedString comes in immutable and mutable flavors.
 }
type
  PCFAttributedStringRef = ^CFAttributedStringRef;
  CFAttributedStringRef = ^__CFAttributedString;
  {$EXTERNALSYM CFAttributedStringRef}
  __CFAttributedString = record
  end;
  {$EXTERNALSYM __CFAttributedString}
  CFMutableAttributedStringRef = ^__CFAttributedString; 
  {$EXTERNALSYM CFMutableAttributedStringRef}

{ ! @function CFAttributedStringGetTypeID
Returns the type identifier of all CFAttributedString instances.
 }
function CFAttributedStringGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetTypeID';
{$EXTERNALSYM CFAttributedStringGetTypeID}



{ ** CFAttributedString ** }

{ ! @function CFAttributedStringCreate
Creates an attributed string with the specified string and attributes (both copied).
 }
function CFAttributedStringCreate(alloc: CFAllocatorRef; str: CFStringRef; 
  attributes: CFDictionaryRef): CFAttributedStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringCreate';
{$EXTERNALSYM CFAttributedStringCreate}

{ ! @function CFAttributedStringCreateWithSubstring
Creates a sub-attributed string from the specified range. It's a programming
error for range to specify characters outside the bounds of aStr.
 }
function CFAttributedStringCreateWithSubstring(alloc: CFAllocatorRef; 
  aStr: CFAttributedStringRef; range: CFRange): CFAttributedStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringCreateWithSubstring';
{$EXTERNALSYM CFAttributedStringCreateWithSubstring}

{ ! @function CFAttributedStringCreateCopy
Creates an immutable attributed string copy.
 }
function CFAttributedStringCreateCopy(alloc: CFAllocatorRef; 
  aStr: CFAttributedStringRef): CFAttributedStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringCreateCopy';
{$EXTERNALSYM CFAttributedStringCreateCopy}

{ ! @function CFAttributedStringGetString
Returns the string for the attributed string. For performance reasons,
this will often point at the backing store of the attributed string, and
it might change if the attributed string is edited.  However, this is an
implementation detail, and definitely not something that should be counted on.
 }
function CFAttributedStringGetString(
  aStr: CFAttributedStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetString';
{$EXTERNALSYM CFAttributedStringGetString}

{ ! @function CFAttributedStringGetLength
Returns the length of the attributed string in characters; same as
CFStringGetLength(CFAttributedStringGetString(aStr))
 }
function CFAttributedStringGetLength(
  aStr: CFAttributedStringRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetLength';
{$EXTERNALSYM CFAttributedStringGetLength}

{ ! @function CFAttributedStringGetAttributes
Returns the attributes at the specified location. If effectiveRange is not
NULL, upon return *effectiveRange contains a range over which the exact same
set of attributes apply. Note that for performance reasons, the returned
effectiveRange is not necessarily the maximal range - for that, use
CFAttributedStringGetAttributesAndLongestEffectiveRange().  It's a
programming error for loc to specify a location outside the bounds of the
attributed string.

Note that the returned attribute dictionary might change in unpredictable
ways from under the caller if the attributed string is edited after this call.
If you wish to hang on to the dictionary long-term, you should make an actual
copy of it rather than just retaining it.  Also, no assumptions should be made
about the relationship of the actual CFDictionaryRef returned by this call
and the dictionary originally used to set the attributes, other than the
fact that the values stored in the dictionary will be identical
(that is, ==) to those originally specified.
 }
function CFAttributedStringGetAttributes(aStr: CFAttributedStringRef; 
  loc: CFIndex; effectiveRange: PCFRange): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetAttributes';
{$EXTERNALSYM CFAttributedStringGetAttributes}

{ ! @function CFAttributedStringGetAttribute
Returns the value of a single attribute at the specified location. If the
specified attribute doesn't exist at the location, returns NULL. If
effectiveRange is not NULL, upon return *effectiveRange contains a range
over which the exact same attribute value applies. Note that for performance
reasons, the returned effectiveRange is not necessarily the maximal range -
for that, use CFAttributedStringGetAttributeAndLongestEffectiveRange(). It's
a programming error for loc to specify a location outside the bounds of the
attributed string.
 }
function CFAttributedStringGetAttribute(aStr: CFAttributedStringRef; 
  loc: CFIndex; attrName: CFStringRef; 
  effectiveRange: PCFRange): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetAttribute';
{$EXTERNALSYM CFAttributedStringGetAttribute}

{ ! @function CFAttributedStringGetAttributesAndLongestEffectiveRange
Returns the attributes at the specified location. If longestEffectiveRange
is not NULL, upon return *longestEffectiveRange contains the maximal range
within inRange over which the exact same set of attributes apply. The returned
range is clipped to inRange. It's a programming error for loc or inRange to
pecify locations outside the bounds of the attributed string.
 }
function CFAttributedStringGetAttributesAndLongestEffectiveRange(
  aStr: CFAttributedStringRef; loc: CFIndex; inRange: CFRange; 
  longestEffectiveRange: PCFRange): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetAttributesAndLongestEffectiveRange';
{$EXTERNALSYM CFAttributedStringGetAttributesAndLongestEffectiveRange}

{ ! @function CFAttributedStringGetAttributeAndLongestEffectiveRange
Returns the value of a single attribute at the specified location. If
longestEffectiveRange is not NULL, upon return *longestEffectiveRange
contains the maximal range within inRange over which the exact same a
ttribute value applies. The returned range is clipped to inRange. It's
a programming error for loc or inRange to specify locations outside the
 bounds of the attributed string.
 }
function CFAttributedStringGetAttributeAndLongestEffectiveRange(
  aStr: CFAttributedStringRef; loc: CFIndex; attrName: CFStringRef; 
  inRange: CFRange; longestEffectiveRange: PCFRange): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetAttributeAndLongestEffectiveRange';
{$EXTERNALSYM CFAttributedStringGetAttributeAndLongestEffectiveRange}



{ ** CFMutableAttributedString ** }

{ ! @function CFAttributedStringCreateMutableCopy
Creates a mutable attributed string copy. maxLength, if not 0, is a hard
bound on the length of the attributed string; exceeding this size limit
during any editing operation is a programming error. If 0, there is no
limit on the length.
 }
function CFAttributedStringCreateMutableCopy(alloc: CFAllocatorRef; 
  maxLength: CFIndex; 
  aStr: CFAttributedStringRef): CFMutableAttributedStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringCreateMutableCopy';
{$EXTERNALSYM CFAttributedStringCreateMutableCopy}

{ ! @function CFAttributedStringCreateMutable
Creates a mutable empty attributed string. maxLength, if not 0, is a hard
bound on the length of the attributed string; exceeding this size limit
during any editing operation is a programming error. If 0, there is no
limit on the length.
 }
function CFAttributedStringCreateMutable(alloc: CFAllocatorRef; 
  maxLength: CFIndex): CFMutableAttributedStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringCreateMutable';
{$EXTERNALSYM CFAttributedStringCreateMutable}

{ ! @function CFAttributedStringReplaceString
Modifies the string for the attributed string, much like CFStringReplace().
It's an error for range to specify characters outside the bounds of aStr.

(Note: This function is a convenience on CFAttributedStringGetMutableString();
       however, until CFAttributedStringGetMutableString() is implemented, it
       remains the only way to edit the string of the attributed string.)
 }
procedure CFAttributedStringReplaceString(aStr: CFMutableAttributedStringRef; 
  range: CFRange; replacement: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringReplaceString';
{$EXTERNALSYM CFAttributedStringReplaceString}

{ ! @function CFAttributedStringGetMutableString
Gets the string for the attributed string as a mutable string, allowing
editing the character contents of the string as if it were an CFMutableString.
Attributes corresponding to the edited range are appropriately modified. If,
as a result of the edit, new characters are introduced into the string, they
inherit the attributes of the first replaced character from range. If no
existing characters are replaced by the edit, the new characters inherit the
attributes of the character preceding range if it has any, otherwise of the
character following range. If the initial string is empty, the attributes for
the new characters are also empty.

(Note: This function is not yet implemented and will return NULL
       except for toll-free bridged instances.)
 }
function CFAttributedStringGetMutableString(
  aStr: CFMutableAttributedStringRef): CFMutableStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringGetMutableString';
{$EXTERNALSYM CFAttributedStringGetMutableString}

{ ! @function CFAttributedStringSetAttributes
Sets the value of multiple attributes over the specified range, which
should be valid. If clearOtherAttributes is false, existing attributes
(which aren't being replaced) are left alone; otherwise they are cleared.
The dictionary should be setup for "usual" CF type usage --- CFString keys,
and arbitrary CFType values. Note that after this call, further mutations
to the replacement dictionary argument by the caller will not affect the
contents of the attributed string.
 }
procedure CFAttributedStringSetAttributes(aStr: CFMutableAttributedStringRef; 
  range: CFRange; replacement: CFDictionaryRef; 
  clearOtherAttributes: Boolean); cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringSetAttributes';
{$EXTERNALSYM CFAttributedStringSetAttributes}

{ ! @function CFAttributedStringSetAttribute
Sets the value of a single attribute over the specified range, which
should be valid. value should not be NULL.
 }
procedure CFAttributedStringSetAttribute(aStr: CFMutableAttributedStringRef; 
  range: CFRange; attrName: CFStringRef; value: CFTypeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringSetAttribute';
{$EXTERNALSYM CFAttributedStringSetAttribute}

{ ! @function CFAttributedStringRemoveAttribute
Removes the value of a single attribute over the specified range, which
should be valid. It's OK for the attribute not the exist over the specified range.
 }
procedure CFAttributedStringRemoveAttribute(aStr: CFMutableAttributedStringRef; 
  range: CFRange; attrName: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringRemoveAttribute';
{$EXTERNALSYM CFAttributedStringRemoveAttribute}

{ ! @function CFAttributedStringReplaceAttributedString
Replaces the attributed substring over the specified range with the
attributed string specified in replacement. range should be valid. To
delete a range of the attributed string, call CFAttributedStringReplaceString()
with empty string and specified range.
 }
procedure CFAttributedStringReplaceAttributedString(
  aStr: CFMutableAttributedStringRef; range: CFRange; 
  replacement: CFAttributedStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringReplaceAttributedString';
{$EXTERNALSYM CFAttributedStringReplaceAttributedString}

{ ! @function CFAttributedStringBeginEditing
In cases where attributed string might do a bunch of work to assure
self-consistency, CFAttributedStringBeginEditing/CFAttributedStringEndEditing
allow disabling that to allow deferring and coalescing any work. It's a good
idea to call these around a set of related mutation calls which don't require
the string to be in consistent state in between. These calls can be nested.
 }
procedure CFAttributedStringBeginEditing(
  aStr: CFMutableAttributedStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringBeginEditing';
{$EXTERNALSYM CFAttributedStringBeginEditing}

{ ! @function CFAttributedStringEndEditing
In cases where attributed string might do a bunch of work to assure
self-consistency, CFAttributedStringBeginEditing/CFAttributedStringEndEditing
allow disabling that to allow deferring and coalescing any work. It's a good
idea to call these around a set of related mutation calls which don't require
the string to be in consistent state in between. These calls can be nested.
 }
procedure CFAttributedStringEndEditing(
  aStr: CFMutableAttributedStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFAttributedStringEndEditing';
{$EXTERNALSYM CFAttributedStringEndEditing}


{$ENDIF !__COREFOUNDATION_CFATTRIBUTEDSTRING__}

