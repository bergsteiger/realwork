{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

//uses Availabilitymacros, Carboncore, Stdbool, Sys, Windows;

{ 
     File:       CarbonCore/MacTypes.h
     Contains:   Basic Macintosh data types.
     Version:    CarbonCore-859.2~178
     Copyright:  © 1985-2008 by Apple Computer, Inc., all rights reserved.
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
                     http://developer.apple.com/bugreporter/
 }

{
        CarbonCore Deprecation flags.

     Certain Carbon API functions are deprecated in 10.3 and later
      systems.  These will produce a warning when compiling on 10.3.

        Other functions and constants do not produce meaningful
        results when building Carbon for Mac OS X.  For these
      functions, no-op macros are provided, but only when the
        ALLOW_OBSOLETE_CARBON flag is defined to be 0: eg
      -DALLOW_OBSOLETE_CARBON=0.
 }

//const
//  ALLOW_OBSOLETE_CARBON_MACMEMORY = 0;
//  ALLOW_OBSOLETE_CARBON_OSUTILS = 0;



//  ALLOW_OBSOLETE_CARBON_MACMEMORY = 1; { Removes obsolete constants; turns HLock/HUnlock into no-op macros }
//  ALLOW_OBSOLETE_CARBON_OSUTILS = 1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       { Removes obsolete structures }




//  NULL = __DARWIN_NULL;


//  nil = NULL;

{ *******************************************************************************

    Base integer types for all target OS's and CPU's
    
        UInt8            8-bit unsigned integer 
        SInt8            8-bit signed integer
        UInt16          16-bit unsigned integer 
        SInt16          16-bit signed integer           
        UInt32          32-bit unsigned integer 
        SInt32          32-bit signed integer   
        UInt64          64-bit unsigned integer 
        SInt64          64-bit signed integer   

******************************************************************************** }
type

  SInt8 = Byte; 
  {$EXTERNALSYM SInt8}

  SInt16 = Int16;
  {$EXTERNALSYM SInt16}


  SInt32 = Int32;
  {$EXTERNALSYM SInt32}
  PSInt32 = ^SInt32;
  {$EXTERNALSYM PSInt32}
  PUInt8 = ^UInt8;
  {$EXTERNALSYM PUInt8}

{ avoid redeclaration if libkern/OSTypes.h }

// defined in CoreServices.pas
//  wide = record
//    lo: UInt32;
//    hi: SInt32;
//  end;
//  UnsignedWide = record
//    lo: UInt32;
//    hi: UInt32;
//  end;

{ 
  Note:   wide and UnsignedWide must always be structs for source code
           compatibility. On the other hand UInt64 and SInt64 can be
          either a struct or a long long, depending on the compiler.
         
           If you use UInt64 and SInt64 you should do all operations on 
          those data types through the functions/macros in Math64.h.  
           This will assure that your code compiles with compilers that
           support long long and those that don't.
            
           The MS Visual C/C++ compiler uses __int64 instead of long long. 
 }
  SInt64 = Int64;
  {$EXTERNALSYM SInt64}
//  UInt64 = Int64;  //TODO: -ocbensen -cImplement : Change the define by the compiler from MACOSX to MACOS

//  SInt64 = signed long long;
//  UInt64 = unsigned long long;




//  SInt64 = wide;
//  UInt64 = UnsignedWide;


{ *******************************************************************************

    Base fixed point types 
    
        Fixed           16-bit signed integer plus 16-bit fraction
        UnsignedFixed   16-bit unsigned integer plus 16-bit fraction
        Fract           2-bit signed integer plus 30-bit fraction
        ShortFixed      8-bit signed integer plus 8-bit fraction
        
******************************************************************************** }
  Fixed = SInt32; 
  {$EXTERNALSYM Fixed}
  FixedPtr = ^Fixed; 
  {$EXTERNALSYM FixedPtr}
  Fract = SInt32; 
  {$EXTERNALSYM Fract}
  FractPtr = ^Fract; 
  {$EXTERNALSYM FractPtr}
  UnsignedFixed = UInt32; 
  {$EXTERNALSYM UnsignedFixed}
  UnsignedFixedPtr = ^UnsignedFixed; 
  {$EXTERNALSYM UnsignedFixedPtr}
  ShortFixed = Smallint; 
  {$EXTERNALSYM ShortFixed}
  ShortFixedPtr = ^ShortFixed; 
  {$EXTERNALSYM ShortFixedPtr}


{ *******************************************************************************

    Base floating point types 
    
        Float32         32 bit IEEE float:  1 sign bit, 8 exponent bits, 23 fraction bits
        Float64         64 bit IEEE float:  1 sign bit, 11 exponent bits, 52 fraction bits  
        Float80         80 bit MacOS float: 1 sign bit, 15 exponent bits, 1 integer bit, 63 fraction bits
        Float96         96 bit 68881 float: 1 sign bit, 15 exponent bits, 16 pad bits, 1 integer bit, 63 fraction bits
        
    Note: These are fixed size floating point types, useful when writing a floating
          point value to disk.  If your compiler does not support a particular size 
          float, a struct is used instead.
          Use of of the NCEG types (e.g. double_t) or an ANSI C type (e.g. double) if
          you want a floating point representation that is natural for any given
          compiler, but might be a different size on different compilers.

******************************************************************************** }
  Float32 = Single; 
  {$EXTERNALSYM Float32}
  Float64 = Double; 
  {$EXTERNALSYM Float64}
  Float80 = record 
    exp: SInt16;
    man: packed array[0..3] of UInt16;
  end;
  {$EXTERNALSYM Float80}

  Float96 = record 
    exp: packed array[0..1] of SInt16;
    man: packed array[0..3] of UInt16;
  end;
  {$EXTERNALSYM Float96}
  Float32Point = record 
    x: Float32;
    y: Float32;
  end;
  {$EXTERNALSYM Float32Point}

{ *******************************************************************************

    MacOS Memory Manager types
    
        Ptr             Pointer to a non-relocatable block
        Handle          Pointer to a master pointer to a relocatable block
        Size            The number of bytes in a block (signed for historical reasons)
        
******************************************************************************** }
  Ptr = ^Pointer;
  {$EXTERNALSYM Ptr}
  Handle = ^Ptr;
  {$EXTERNALSYM Handle}
  Size = LongInt;
  {$EXTERNALSYM Size}

{ *******************************************************************************

    Higher level basic types
    
        OSErr                   16-bit result error code
        OSStatus                32-bit result error code
        LogicalAddress          Address in the clients virtual address space
        ConstLogicalAddress     Address in the clients virtual address space that will only be read
        PhysicalAddress         Real address as used on the hardware bus
        BytePtr                 Pointer to an array of bytes
        ByteCount               The size of an array of bytes
        ByteOffset              An offset into an array of bytes
        ItemCount               32-bit iteration count
        OptionBits              Standard 32-bit set of bit flags
        PBVersion               ?
        Duration                32-bit millisecond timer for drivers
        AbsoluteTime            64-bit clock
        ScriptCode              A particular set of written characters (e.g. Roman vs Cyrillic) and their encoding
        LangCode                A particular language (e.g. English), as represented using a particular ScriptCode
        RegionCode              Designates a language as used in a particular region (e.g. British vs American
                                English) together with other region-dependent characteristics (e.g. date format)
        FourCharCode            A 32-bit value made by packing four 1 byte characters together
        OSType                  A FourCharCode used in the OS and file system (e.g. creator)
        ResType                 A FourCharCode used to tag resources (e.g. 'DLOG')
        
******************************************************************************** }
{  OSErr = SInt16;
  OSStatus = SInt32;
  LogicalAddress = ^Pointer;
  ConstLogicalAddress = ^Pointer;
  PhysicalAddress = ^Pointer;
  BytePtr = ^UInt8;
  ByteCount = LongWord;
  ByteOffset = LongWord;
  Duration = SInt32;
  AbsoluteTime = UnsignedWide;
  OptionBits = UInt32;
  ItemCount = LongWord;
  PBVersion = UInt32;
  ScriptCode = SInt16;
  LangCode = SInt16;
  RegionCode = SInt16;
  FourCharCode = UInt32;
  OSType = FourCharCode;
  ResType = FourCharCode;
  OSTypePtr = ^OSType;
  ResTypePtr = ^ResType;
  }

  OSErr = SmallInt;
  {$EXTERNALSYM OSErr}
  OSStatus = Integer;
  {$EXTERNALSYM OSStatus}
  POSStatus = PInteger;
  LogicalAddress = type Pointer;
  {$EXTERNALSYM LogicalAddress}
  ConstLogicalAddress = type Pointer;
  {$EXTERNALSYM ConstLogicalAddress}
  PhysicalAddress = type Pointer;
  {$EXTERNALSYM PhysicalAddress}
  BytePtr = PByte;
  {$EXTERNALSYM BytePtr}
  ByteCount = Cardinal;
  {$EXTERNALSYM ByteCount}
  ByteOffset = Cardinal;
  {$EXTERNALSYM ByteOffset}
  Duration = SInt32;//Integer;
  {$EXTERNALSYM Duration}
  AbsoluteTime = UnsignedWide;
  {$EXTERNALSYM AbsoluteTime}
  OptionBits = Cardinal;
  {$EXTERNALSYM OptionBits}
  ItemCount = Cardinal;
  {$EXTERNALSYM ItemCount}
  PBVersion = Cardinal;
  {$EXTERNALSYM PBVersion}
  ScriptCode = type SmallInt;
  {$EXTERNALSYM ScriptCode}
  LangCode = type SmallInt;
  {$EXTERNALSYM LangCode}
  RegionCode = type SmallInt;
  {$EXTERNALSYM RegionCode}
  FourCharCode = type Cardinal;
  {$EXTERNALSYM FourCharCode}
  OSType = FourCharCode;
  {$EXTERNALSYM OSType}
  ResType = FourCharCode;
  {$EXTERNALSYM ResType}
  OSTypePtr = ^FourCharCode;
  {$EXTERNALSYM OSTypePtr}
  ResTypePtr = ^ResType;
  {$EXTERNALSYM ResTypePtr}

{ *******************************************************************************

    Boolean types and values
    
        Boolean         Mac OS historic type, sizeof(Boolean)==1
        bool            Defined in stdbool.h, ISO C/C++ standard type
        false           Now defined in stdbool.h
        true            Now defined in stdbool.h
        
******************************************************************************** }
//  Boolean = Byte;
{ *******************************************************************************

    Function Pointer Types
    
        ProcPtr                 Generic pointer to a function
        Register68kProcPtr      Pointer to a 68K function that expects parameters in registers
        UniversalProcPtr        Pointer to classic 68K code or a RoutineDescriptor
        
        ProcHandle              Pointer to a ProcPtr
        UniversalProcHandle     Pointer to a UniversalProcPtr
        
******************************************************************************** }
type
  ProcPtr = function: LongInt;
//: CALLBACK_API_C; cdecl;
//type
//  Register68kProcPtr = function: CALLBACK_API;
//: CALLBACK_API; cdecl;
{  The RoutineDescriptor structure is defined in MixedMode.h }

//  UniversalProcPtr = ProcPtr;


//  ProcHandle = ^ProcPtr;
//  UniversalProcHandle = ^UniversalProcPtr;
{ *******************************************************************************

    RefCon Types
    
        For access to private data in callbacks, etc.; refcons are generally
        used as a pointer to something, but in the 32-bit world refcons in
        different APIs have had various types: pointer, unsigned scalar, and
        signed scalar. The RefCon types defined here support the current 32-bit
        usage but provide normalization to pointer types for 64-bit.
        
        PRefCon is preferred for new APIs; URefCon and SRefCon are primarily
        for compatibility with existing APIs.
        
******************************************************************************** }
  PRefCon = ^Pointer;
{$IF defined(CPU64BITS)}
  URefCon = ^Pointer;
  SRefCon = ^Pointer;
{$ELSE}
  URefCon = UInt32;
  SRefCon = SInt32;
{$ENDIF}

//  URefCon = UInt32;
//  SRefCon = SInt32;


(* *******************************************************************************

    Common Constants

        noErr                   OSErr: function performed properly - no error
        kNilOptions             OptionBits: all flags false
        kInvalidID              KernelID: NULL is for pointers as kInvalidID is for ID's
        kVariableLengthArray    array bounds: variable length array

    Note: kVariableLengthArray is used in array bounds to specify a variable length array.
          It is ususally used in variable length structs when the last field is an array
          of any size.  Before ANSI C, we used zero as the bounds of variable length
          array, but zero length array are illegal in ANSI C.  Example usage:

        struct FooList
        {
            short   listLength;
            Foo     elements[kVariableLengthArray];
        };

******************************************************************************** *)
const
  noErr = 0;
  {$EXTERNALSYM noErr}

const
  kNilOptions = 0; 
  {$EXTERNALSYM kNilOptions}

  kInvalidID = 0;
  {$EXTERNALSYM kInvalidID}

const
  kVariableLengthArray = 1; 
  {$EXTERNALSYM kVariableLengthArray}

const
  kUnknownType = $3F3F3F3F;
  {$EXTERNALSYM kUnknownType}



{ *******************************************************************************

    String Types and Unicode Types
    
        UnicodeScalarValue,     A complete Unicode character in UTF-32 format, with
        UTF32Char               values from 0 through 0x10FFFF (excluding the surrogate
                                range 0xD800-0xDFFF and certain disallowed values).

        UniChar,                A 16-bit Unicode code value in the default UTF-16 format.
        UTF16Char               UnicodeScalarValues 0-0xFFFF are expressed in UTF-16
                                format using a single UTF16Char with the same value.
                                UnicodeScalarValues 0x10000-0x10FFFF are expressed in
                                UTF-16 format using a pair of UTF16Chars - one in the
                                high surrogate range (0xD800-0xDBFF) followed by one in
                                the low surrogate range (0xDC00-0xDFFF). All of the
                                characters defined in Unicode versions through 3.0 are
                                in the range 0-0xFFFF and can be expressed using a single
                                UTF16Char, thus the term "Unicode character" generally
                                refers to a UniChar = UTF16Char.

        UTF8Char                An 8-bit code value in UTF-8 format. UnicodeScalarValues
                                0-0x7F are expressed in UTF-8 format using one UTF8Char
                                with the same value. UnicodeScalarValues above 0x7F are
                                expressed in UTF-8 format using 2-4 UTF8Chars, all with
                                values in the range 0x80-0xF4 (UnicodeScalarValues
                                0x100-0xFFFF use two or three UTF8Chars,
                                UnicodeScalarValues 0x10000-0x10FFFF use four UTF8Chars).

        UniCharCount            A count of UTF-16 code values in an array or buffer.

        StrNNN                  Pascal string holding up to NNN bytes
        StringPtr               Pointer to a pascal string
        StringHandle            Pointer to a StringPtr
        ConstStringPtr          Pointer to a read-only pascal string
        ConstStrNNNParam        For function parameters only - means string is const
        
        CStringPtr              Pointer to a C string           (in C:  char*)
        ConstCStringPtr         Pointer to a read-only C string (in C:  const char*)
        
    Note: The length of a pascal string is stored as the first byte.
          A pascal string does not have a termination byte.
          A pascal string can hold at most 255 bytes of data.
          The first character in a pascal string is offset one byte from the start of the string. 
          
          A C string is terminated with a byte of value zero.  
          A C string has no length limitation.
          The first character in a C string is the zeroth byte of the string. 
          
        
******************************************************************************** }
type
  UnicodeScalarValue = UInt32; 
  UTF32Char = UInt32; 
  UniChar = UInt16; 
  UTF16Char = UInt16; 
  UTF8Char = UInt8; 
  UniCharPtr = ^UniChar; 
  UniCharCount = LongWord;
  UniCharCountPtr = ^UniCharCount; 
  Str255 = packed array[0..255] of Byte; 
  Str63 = packed array[0..63] of Byte; 
  Str32 = packed array[0..32] of Byte; 
  Str31 = packed array[0..31] of Byte; 
  Str27 = packed array[0..27] of Byte; 
  Str15 = packed array[0..15] of Byte; 
{ 
    The type Str32 is used in many AppleTalk based data structures.
    It holds up to 32 one byte chars.  The problem is that with the
    length byte it is 33 bytes long.  This can cause weird alignment
    problems in structures.  To fix this the type "Str32Field" has
    been created.  It should only be used to hold 32 chars, but
    it is 34 bytes long so that there are no alignment problems.
 }
  Str32Field = packed array[0..33] of Byte; 
{ 
    QuickTime 3.0:
    The type StrFileName is used to make MacOS structs work 
    cross-platform.  For example FSSpec or SFReply previously
    contained a Str63 field.  They now contain a StrFileName
    field which is the same when targeting the MacOS but is
    a 256 char buffer for Win32 and unix, allowing them to
    contain long file names.
 }
  StrFileName = Str63; 
  StringPtr = ^Byte; 
  StringHandle = ^StringPtr; 
  ConstStringPtr = ^Byte; 
  ConstStr255Param = ^Byte; 
  ConstStr63Param = ^Byte; 
  ConstStr32Param = ^Byte; 
  ConstStr31Param = ^Byte; 
  ConstStr27Param = ^Byte; 
  ConstStr15Param = ^Byte; 
  ConstStrFileNameParam = ConstStr63Param;

function StrLength(str: ConstStr255Param): Byte;


{ *******************************************************************************

    Process Manager type ProcessSerialNumber (previously in Processes.h)

******************************************************************************** }
{ type for unique process identifier }
type
  ProcessSerialNumber = record 
    highLongOfPSN: UInt32;
    lowLongOfPSN: UInt32;
  end;
  ProcessSerialNumberPtr = ^ProcessSerialNumber; 
{ *******************************************************************************

    Quickdraw Types
    
        Point               2D Quickdraw coordinate, range: -32K to +32K
        Rect                Rectangular Quickdraw area
        Style               Quickdraw font rendering styles
        StyleParameter      Style when used as a parameter (historical 68K convention)
        StyleField          Style when used as a field (historical 68K convention)
        CharParameter       Char when used as a parameter (historical 68K convention)
        
    Note:   The original Macintosh toolbox in 68K Pascal defined Style as a SET.  
            Both Style and CHAR occupy 8-bits in packed records or 16-bits when 
            used as fields in non-packed records or as parameters. 
        
******************************************************************************** }
  Point = record 
    v: Smallint;
    h: Smallint;
  end;
  PointPtr = ^Point; 
  Rect = record 
    top: Smallint;
    left: Smallint;
    bottom: Smallint;
    right: Smallint;
  end;
  RectPtr = ^Rect; 
  FixedPoint = record 
    x: Fixed;
    y: Fixed;
  end;
  FixedRect = record 
    left: Fixed;
    top: Fixed;
    right: Fixed;
    bottom: Fixed;
  end;

  CharParameter = Smallint; 
const
  normal    = 0; 
  bold      = 1; 
  italic    = 2; 
  underline = 4; 
  outline   = 8; 
  shadow    = $10; 
  condense  = $20; 
  extend    = $40; 

type
  Style = Byte; 
  StyleParameter = Smallint; 
  StyleField = Style; 


{ *******************************************************************************

    QuickTime TimeBase types (previously in Movies.h)
    
        TimeValue           Count of units
        TimeScale           Units per second
        CompTimeValue       64-bit count of units (always a struct) 
        TimeValue64         64-bit count of units (long long or struct) 
        TimeBase            An opaque reference to a time base
        TimeRecord          Package of TimeBase, duration, and scale
        
******************************************************************************** }
  TimeValue = SInt32; 
  TimeScale = SInt32; 
  CompTimeValue = wide; 
  TimeValue64 = SInt64;
  TimeBase = Pointer; // ^TimeBaseRecord
{$ALIGN 2}
  TimeRecord = record
    value: CompTimeValue;
    scale: TimeScale;
    base: TimeBase;
  end;
{$ALIGN ON}

{ *******************************************************************************

    THINK C base objects

        HandleObject        Root class for handle based THINK C++ objects
        PascalObject        Root class for pascal style objects in THINK C++

******************************************************************************** }
  HandleObject = class
  end;

{ *******************************************************************************

    MacOS versioning structures

        VersRec                 Contents of a 'vers' resource
        VersRecPtr              Pointer to a VersRecPtr
        VersRecHndl             Resource Handle containing a VersRec
        NumVersion              Packed BCD version representation (e.g. "4.2.1a3" is 0x04214003)
        UniversalProcPtr        Pointer to classic 68K code or a RoutineDescriptor

        ProcHandle              Pointer to a ProcPtr
        UniversalProcHandle     Pointer to a UniversalProcPtr

******************************************************************************** }
  NumVersion = record
    nonRelRev: UInt8;
    stage: UInt8;
    minorAndBugRev: UInt8;
    majorRev: UInt8;
  end;

  { Version Release Stage Codes }

  NumVersionVariant = record
    case Integer of
     0: (parts: NumVersion);
     1: (whole: UInt32);
  end;
  NumVersionVariantPtr = ^NumVersionVariant;
  NumVersionVariantHandle = ^NumVersionVariantPtr;
  VersRec = record
    numericVersion: NumVersion;
    countryCode: Smallint;
    shortVersion: Str255;
    reserved: Str255;
  end;
  VersRecPtr = ^VersRec;
  VersRecHndl = ^VersRecPtr;
{ ********************************************************************************

    Old names for types
        
******************************************************************************** }
  Byte = UInt8; 
  {$EXTERNALSYM Byte}
  SignedByte = SInt8; 
  {$EXTERNALSYM SignedByte}
  WidePtr = ^wide; 
  {$EXTERNALSYM WidePtr}
  UnsignedWidePtr = ^UnsignedWide; 
  {$EXTERNALSYM UnsignedWidePtr}
  extended80 = Float80; 
  {$EXTERNALSYM extended80}
  extended96 = Float96; 
  {$EXTERNALSYM extended96}
  VHSelect = SInt8; 
  {$EXTERNALSYM VHSelect}
{ ********************************************************************************

    Debugger functions
    
******************************************************************************** }
{ 
 *  Debugger()
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//procedure Debugger; cdecl;


{
 *  DebugStr()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//procedure DebugStr(debuggerMsg: ConstStr255Param); cdecl;


{ SADE break points }
{
 *  SysBreak()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//procedure SysBreak; cdecl;


{
 *  SysBreakStr()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//procedure SysBreakStr(debuggerMsg: ConstStr255Param); cdecl;


{
 *  SysBreakFunc()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//procedure SysBreakFunc(debuggerMsg: ConstStr255Param); cdecl;


{ old names for Debugger and DebugStr }

