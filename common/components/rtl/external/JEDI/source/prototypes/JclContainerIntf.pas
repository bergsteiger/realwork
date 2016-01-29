{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is DCL_intf.pas.                                                               }
{                                                                                                  }
{ The Initial Developer of the Original Code is Jean-Philippe BEMPEL aka RDM. Portions created by  }
{ Jean-Philippe BEMPEL are Copyright (C) Jean-Philippe BEMPEL (rdm_30 att yahoo dott com)          }
{ All rights reserved.                                                                             }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Robert Marquardt (marquardt)                                                                   }
{   Robert Rossmair (rrossmair)                                                                    }
{   Florent Ouchet (outchy)                                                                        }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ The Delphi Container Library                                                                     }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date: 2010/12/01 13:00:14 $ }
{ Revision:      $Rev:: 3295                                                                     $ }
{ Author:        $Author: lulin $ }
{                                                                                                  }
{**************************************************************************************************}

unit JclContainerIntf;

{$I jcl.inc}
{$I containers\JclContainerIntf.int}
interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes,
  JclBase,
  JclAnsiStrings,
  JclWideStrings;

{$IFDEF BCB6}
{$DEFINE BUGGY_DEFAULT_INDEXED_PROP}
{$ENDIF BCB6}
{$IFDEF BCB10}
{$DEFINE BUGGY_DEFAULT_INDEXED_PROP}
{$ENDIF BCB10}
{$IFDEF BCB11}
{$DEFINE BUGGY_DEFAULT_INDEXED_PROP}
{$ENDIF BCB11}

const
  DefaultContainerCapacity = 16;

type
  // function pointer types

  // iterate functions Type -> (void)
(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO ITERPROCEDURE(,,,)}*)
  {$IFDEF SUPPORTS_GENERICS}
  {$JPPEXPANDMACRO ITERPROCEDURE(TIterateProcedure<T>,const ,AItem,T)}
  {$ENDIF SUPPORTS_GENERICS}

  // apply functions Type -> Type
(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO APPLYFUNCTION(,,,)}*)
  {$IFDEF SUPPORTS_GENERICS}
  {$JPPEXPANDMACRO APPLYFUNCTION(TApplyFunction<T>,const ,AItem,T)}
  {$ENDIF SUPPORTS_GENERICS}

  // comparison functions Type -> Type -> Integer
(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO COMPAREFUNCTION(,,)}*)
  {$IFDEF SUPPORTS_GENERICS}
  {$JPPEXPANDMACRO COMPAREFUNCTION(TCompare<T>,const ,T)}
  {$ENDIF SUPPORTS_GENERICS}

  // comparison for equality functions Type -> Type -> Boolean
(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO EQUALITYCOMPAREFUNCTION(,,)}*)
  {$IFDEF SUPPORTS_GENERICS}
  {$JPPEXPANDMACRO EQUALITYCOMPAREFUNCTION(TEqualityCompare<T>,const ,T)}
  {$ENDIF SUPPORTS_GENERICS}

  // hash functions Type -> Integer
(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO HASHFUNCTION(,,,)}*)
  {$IFDEF SUPPORTS_GENERICS}
  {$JPPEXPANDMACRO HASHFUNCTION(THashConvert<T>,const ,AItem,T)}
  {$ENDIF SUPPORTS_GENERICS}

  IJclLockable = interface
    ['{524AD65E-AE1B-4BC6-91C8-8181F0198BA9}']
    procedure ReadLock;
    procedure ReadUnlock;
    procedure WriteLock;
    procedure WriteUnlock;
  end;

  IJclAbstractIterator = interface{$IFDEF THREADSAFE}(IJclLockable){$ENDIF THREADSAFE}
    ['{1064D0B4-D9FC-475D-88BE-520490013B46}']
    procedure Assign(const Source: IJclAbstractIterator);
    procedure AssignTo(const Dest: IJclAbstractIterator);
    function GetIteratorReference: TObject;
  end;

  IJclContainer = interface{$IFDEF THREADSAFE}(IJclLockable){$ENDIF THREADSAFE}
    ['{C517175A-028E-486A-BF27-5EF7FC3101D9}']
    procedure Assign(const Source: IJclContainer);
    procedure AssignTo(const Dest: IJclContainer);
    function GetAllowDefaultElements: Boolean;
    function GetContainerReference: TObject;
    function GetDuplicates: TDuplicates;
    function GetReadOnly: Boolean;
    function GetRemoveSingleElement: Boolean;
    function GetReturnDefaultElements: Boolean;
    function GetThreadSafe: Boolean;
    procedure SetAllowDefaultElements(Value: Boolean);
    procedure SetDuplicates(Value: TDuplicates);
    procedure SetReadOnly(Value: Boolean);
    procedure SetRemoveSingleElement(Value: Boolean);
    procedure SetReturnDefaultElements(Value: Boolean);
    procedure SetThreadSafe(Value: Boolean);
    property AllowDefaultElements: Boolean read GetAllowDefaultElements write SetAllowDefaultElements;
    property Duplicates: TDuplicates read GetDuplicates write SetDuplicates;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property RemoveSingleElement: Boolean read GetRemoveSingleElement write SetRemoveSingleElement;
    property ReturnDefaultElements: Boolean read GetReturnDefaultElements write SetReturnDefaultElements;
    property ThreadSafe: Boolean read GetThreadSafe write SetThreadSafe;
  end;

  IJclStrContainer = interface(IJclContainer)
    ['{9753E1D7-F093-4D5C-8B32-40403F6F700E}']
    function GetCaseSensitive: Boolean;
    procedure SetCaseSensitive(Value: Boolean);
    property CaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
  end;

  TJclAnsiStrEncoding = (seISO, seUTF8);

  IJclAnsiStrContainer = interface(IJclStrContainer)
    ['{F8239357-B96F-46F1-A48E-B5DF25B5F1FA}']
    function GetEncoding: TJclAnsiStrEncoding;
    procedure SetEncoding(Value: TJclAnsiStrEncoding);
    property Encoding: TJclAnsiStrEncoding read GetEncoding write SetEncoding;
  end;

  IJclAnsiStrFlatContainer = interface(IJclAnsiStrContainer)
    ['{8A45A4D4-6317-4CDF-8314-C3E5CC6899F4}']
    procedure LoadFromStrings(Strings: TJclAnsiStrings);
    procedure SaveToStrings(Strings: TJclAnsiStrings);
    procedure AppendToStrings(Strings: TJclAnsiStrings);
    procedure AppendFromStrings(Strings: TJclAnsiStrings);
    function GetAsStrings: TJclAnsiStrings;
    function GetAsDelimited(const Separator: AnsiString = AnsiLineBreak): AnsiString;
    procedure AppendDelimited(const AString: AnsiString; const Separator: AnsiString = AnsiLineBreak);
    procedure LoadDelimited(const AString: AnsiString; const Separator: AnsiString = AnsiLineBreak);
  end;

  TJclWideStrEncoding = (seUTF16);

  IJclWideStrContainer = interface(IJclStrContainer)
    ['{875E1AC4-CA22-46BC-8999-048E5B9BF11D}']
    function GetEncoding: TJclWideStrEncoding;
    procedure SetEncoding(Value: TJclWideStrEncoding);
    property Encoding: TJclWideStrEncoding read GetEncoding write SetEncoding;
  end;

  IJclWideStrFlatContainer = interface(IJclWideStrContainer)
    ['{5B001B93-CA1C-47A8-98B8-451CCB444930}']
    procedure LoadFromStrings(Strings: TJclWideStrings);
    procedure SaveToStrings(Strings: TJclWideStrings);
    procedure AppendToStrings(Strings: TJclWideStrings);
    procedure AppendFromStrings(Strings: TJclWideStrings);
    function GetAsStrings: TJclWideStrings;
    function GetAsDelimited(const Separator: WideString = WideLineBreak): WideString;
    procedure AppendDelimited(const AString: WideString; const Separator: WideString = WideLineBreak);
    procedure LoadDelimited(const AString: WideString; const Separator: WideString = WideLineBreak);
  end;

  {$IFDEF SUPPORTS_UNICODE_STRING}
  IJclUnicodeStrContainer = interface(IJclStrContainer)
    ['{619BA29F-5E05-464D-B472-1C8453DBC707}']
  end;

  IJclUnicodeStrFlatContainer = interface(IJclUnicodeStrContainer)
    ['{3343D73E-4ADC-458E-8289-A4B83D1479D1}']
    procedure LoadFromStrings(Strings: TJclUnicodeStrings);
    procedure SaveToStrings(Strings: TJclUnicodeStrings);
    procedure AppendToStrings(Strings: TJclUnicodeStrings);
    procedure AppendFromStrings(Strings: TJclUnicodeStrings);
    function GetAsStrings: TJclUnicodeStrings;
    function GetAsDelimited(const Separator: UnicodeString = WideLineBreak): UnicodeString;
    procedure AppendDelimited(const AString: UnicodeString; const Separator: UnicodeString = WideLineBreak);
    procedure LoadDelimited(const AString: UnicodeString; const Separator: UnicodeString = WideLineBreak);
  end;
  {$ENDIF SUPPORTS_UNICODE_STRING}

  IJclSingleContainer = interface(IJclContainer)
    ['{22BE88BD-87D1-4B4D-9FAB-F1B6D555C6A9}']
    function GetPrecision: Single;
    procedure SetPrecision(const Value: Single);
    property Precision: Single read GetPrecision write SetPrecision;
  end;

  IJclDoubleContainer = interface(IJclContainer)
    ['{372B9354-DF6D-4CAA-A5A9-C50E1FEE5525}']
    function GetPrecision: Double;
    procedure SetPrecision(const Value: Double);
    property Precision: Double read GetPrecision write SetPrecision;
  end;

  IJclExtendedContainer = interface(IJclContainer)
    ['{431A6482-FD5C-45A7-BE53-339A3CF75AC9}']
    function GetPrecision: Extended;
    procedure SetPrecision(const Value: Extended);
    property Precision: Extended read GetPrecision write SetPrecision;
  end;

  {$IFDEF MATH_EXTENDED_PRECISION}
  IJclFloatContainer = IJclExtendedContainer;
  {$ENDIF MATH_EXTENDED_PRECISION}
  {$IFDEF MATH_DOUBLE_PRECISION}
  IJclFloatContainer = IJclDoubleContainer;
  {$ENDIF MATH_DOUBLE_PRECISION}
  {$IFDEF MATH_SINGLE_PRECISION}
  IJclFloatContainer = IJclSingleContainer;
  {$ENDIF MATH_SINGLE_PRECISION}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO EQUALITYCOMPARER(,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO EQUALITYCOMPARER(IJclEqualityComparer<T>,{4AF79AD6-D9F4-424B-BEAA-68857F9222B4},TEqualityCompare<T>,const ,T)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO COMPARER(,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO COMPARER(IJclComparer<T>,{830AFC8C-AA06-46F5-AABD-8EB46B2A9986},TCompare<T>,const ,T)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO HASHCONVERTER(,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO HASHCONVERTER(IJclHashConverter<T>,{300AEA0E-7433-4C3E-99A6-E533212ACF42},THashConvert<T>,const ,AItem,T)*)
  {$ENDIF SUPPORTS_GENERICS}

  IJclIntfCloneable = interface
    ['{BCF77740-FB60-4306-9BD1-448AADE5FF4E}']
    function IntfClone: IInterface;
  end;

  IJclCloneable = interface
    ['{D224AE70-2C93-4998-9479-1D513D75F2B2}']
    function ObjectClone: TObject;
  end;

  TJclAutoPackStrategy = (apsDisabled, apsAgressive, apsProportional, apsIncremental);

  // parameter signification depends on strategy
  //  - Disabled = unused (arrays are never packed)
  //  - Agressive = unused (arrays are always packed)
  //  - Proportional = ratio of empty slots before the array is packed
  //    number of empty slots is computed by this formula: Capacity div Parameter
  //  - Incremental = amount of empty slots before the array is packed

  IJclPackable = interface
    ['{03802D2B-E0AB-4300-A777-0B8A2BD993DF}']
    function CalcGrowCapacity(ACapacity, ASize: Integer): Integer;
    function GetAutoPackParameter: Integer;
    function GetAutoPackStrategy: TJclAutoPackStrategy;
    function GetCapacity: Integer;
    procedure Pack; // reduce used memory by eliminating empty storage area (force)
    procedure SetAutoPackParameter(Value: Integer);
    procedure SetAutoPackStrategy(Value: TJclAutoPackStrategy);
    procedure SetCapacity(Value: Integer);
    property AutoPackParameter: Integer read GetAutoPackParameter write SetAutoPackParameter;
    property AutoPackStrategy: TJclAutoPackStrategy read GetAutoPackStrategy write SetAutoPackStrategy;
    property Capacity: Integer read GetCapacity write SetCapacity;
  end;

  TJclAutoGrowStrategy = (agsDisabled, agsAgressive, agsProportional, agsIncremental);

  // parameter signification depends on strategy
  //  - Disabled = unused (arrays never grow)
  //  - Agressive = unused (arrays always grow by 1 element)
  //  - Proportional = ratio of empty slots to add to the array
  //    number of empty slots is computed by this formula: Capacity div Parameter
  //  - Incremental = amount of empty slots to add to the array

  IJclGrowable = interface(IJclPackable)
    ['{C71E8586-5688-444C-9BDD-9969D988123B}']
    function CalcPackCapacity(ACapacity, ASize: Integer): Integer;
    function GetAutoGrowParameter: Integer;
    function GetAutoGrowStrategy: TJclAutoGrowStrategy;
    procedure Grow;
    procedure SetAutoGrowParameter(Value: Integer);
    procedure SetAutoGrowStrategy(Value: TJclAutoGrowStrategy);
    property AutoGrowParameter: Integer read GetAutoGrowParameter write SetAutoGrowParameter;
    property AutoGrowStrategy: TJclAutoGrowStrategy read GetAutoGrowStrategy write SetAutoGrowStrategy;
  end;

  IJclObjectOwner = interface
    ['{5157EA13-924E-4A56-995D-36956441025C}']
    function FreeObject(var AObject: TObject): TObject;
    function GetOwnsObjects: Boolean;
    property OwnsObjects: Boolean read GetOwnsObjects;
  end;

  IJclKeyOwner = interface
    ['{8BE209E6-2F85-44FD-B0CD-A8363C95349A}']
    function FreeKey(var Key: TObject): TObject;
    function GetOwnsKeys: Boolean;
    property OwnsKeys: Boolean read GetOwnsKeys;
  end;

  IJclValueOwner = interface
    ['{3BCD98CE-7056-416A-A9E7-AE3AB2A62E54}']
    function FreeValue(var Value: TObject): TObject;
    function GetOwnsValues: Boolean;
    property OwnsValues: Boolean read GetOwnsValues;
  end;

  {$IFDEF SUPPORTS_GENERICS}
  IJclItemOwner<T> = interface
    ['{0CC220C1-E705-4B21-9F53-4AD340952165}']
    function FreeItem(var AItem: T): T;
    function GetOwnsItems: Boolean;
    property OwnsItems: Boolean read GetOwnsItems;
  end;

  IJclPairOwner<TKey, TValue> = interface
    ['{321C1FF7-AA2E-4229-966A-7EC6417EA16D}']
    function FreeKey(var Key: TKey): TKey;
    function FreeValue(var Value: TValue): TValue;
    function GetOwnsKeys: Boolean;
    function GetOwnsValues: Boolean;
    property OwnsKeys: Boolean read GetOwnsKeys;
    property OwnsValues: Boolean read GetOwnsValues;
  end;
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO ITERATOR(,,,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO ITERATOR(IJclIterator<T>,IJclAbstractIterator,{6E8547A4-5B5D-4831-8AE3-9C6D04071B11},const ,AItem,T,GetItem,SetItem)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO TREEITERATOR(,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO TREEITERATOR(IJclTreeIterator<T>,IJclIterator<T>,{29A06DA4-D93A-40A5-8581-0FE85BC8384B},const ,AItem,T)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO BINTREEITERATOR(,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO BINTREEITERATOR(IJclBinaryTreeIterator<T>,IJclTreeIterator<T>,{0CF5B0FC-C644-458C-BF48-2E093DAFEC26},T)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO COLLECTION(,,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  //DOM-IGNORE-BEGIN
  (*$JPPEXPANDMACRO COLLECTION(IJclCollection<T>,IJclContainer,{67EE8AF3-19B0-4DCA-A730-3C9B261B8EC5},const ,AItem,T,IJclIterator<T>)*)
  //DOM-IGNORE-END
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO LIST(,,,,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO LIST(IJclList<T>,IJclCollection<T>,{3B4BE3D7-8FF7-4163-91DF-3F73AE6935E7},const ,AItem,T,GetItem,SetItem,Items)*)
  {$ENDIF SUPPORTS_GENERICS}

  // Pointer functions for sort algorithms
(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO SORTPROC(,,)}*)
  {$IFDEF SUPPORTS_GENERICS}
  {$JPPEXPANDMACRO SORTPROC(TSortProc<T>,IJclList<T>,TCompare<T>)}
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO ARRAY(,,,,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO ARRAY(IJclArray<T>,IJclList<T>,{38810C13-E35E-428A-B84F-D25FB994BE8E},const ,AItem,T,GetItem,SetItem,Items)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO SET(,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO SET(IJclSet<T>,IJclCollection<T>,{0B7CDB90-8588-4260-A54C-D87101C669EA})*)
  {$ENDIF SUPPORTS_GENERICS}

  TJclTraverseOrder = (toPreOrder, toOrder, toPostOrder);

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO TREE(,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO TREE(IJclTree<T>,IJclCollection<T>,{3F963AB5-5A75-41F9-A21B-7E7FB541A459},IJclTreeIterator<T>)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLMAPINDEX ALLMAPCOUNT
  {$JPPEXPANDMACRO MAP(,,,,,,,,)}
*)

  (*IJclMultiIntfIntfMap = interface(IJclIntfIntfMap)
    ['{497775A5-D3F1-49FC-A641-15CC9E77F3D0}']
    function GetValues(const Key: IInterface): IJclIntfIterator;
    function Count(const Key: IInterface): Integer;
  end;*)

  {$IFDEF SUPPORTS_GENERICS}
  IHashable = interface
    function GetHashCode: Integer;
  end;

  (*$JPPEXPANDMACRO MAP(IJclMap<TKey\,TValue>,IJclContainer,{22624C43-4828-4A1E-BDD4-4A7FE59AE135},const ,TKey,IJclSet<TKey>,const ,TValue,IJclCollection<TValue>)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO QUEUE(,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO QUEUE(IJclQueue<T>,IJclContainer,{16AB909F-2194-46CF-BD89-B4207AC0CAB8},const ,AItem,T)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLMAPINDEX ALLMAPCOUNT
  {$JPPEXPANDMACRO SORTEDMAP(,,,,)}
*)

  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO SORTEDMAP(IJclSortedMap<TKey\,TValue>,IJclMap<TKey\,TValue>,{C62B75C4-891B-442E-A5D6-9954E75A5C0C},const ,TKey)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO SORTEDSET(,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO SORTEDSET(IJclSortedSet<T>,IJclSet<T>,{30F836E3-2FB1-427E-A499-DFAE201633C8},const ,T)*)
  {$ENDIF SUPPORTS_GENERICS}

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO STACK(,,,,,)}
*)
  {$IFDEF SUPPORTS_GENERICS}
  (*$JPPEXPANDMACRO STACK(IJclStack<T>,IJclContainer,{2F08EAC9-270D-496E-BE10-5E975918A5F2},const ,AItem,T)*)
  {$ENDIF SUPPORTS_GENERICS}

  // Exceptions
  EJclContainerError = class(EJclError);

  EJclOutOfBoundsError = class(EJclContainerError)
  public
    // RsEOutOfBounds
    constructor Create;
  end;

  EJclNoSuchElementError = class(EJclContainerError)
  public
    // RsEValueNotFound
    constructor Create(const Value: string);
  end;

  EJclDuplicateElementError = class(EJclContainerError)
  public
    // RsEDuplicateElement
    constructor Create;
  end;

  EJclIllegalArgumentError = class(EJclContainerError)
  end;

  EJclNoCollectionError = class(EJclIllegalArgumentError)
  public
    // RsENoCollection
    constructor Create;
  end;

  EJclIllegalQueueCapacityError = class(EJclIllegalArgumentError)
  public
    // RsEIllegalQueueCapacity
    constructor Create;
  end;

  EJclOperationNotSupportedError = class(EJclContainerError)
  public
    // RsEOperationNotSupported
    constructor Create;
  end;

  EJclNoEqualityComparerError = class(EJclContainerError)
  public
    // RsENoEqualityComparer
    constructor Create;
  end;

  EJclNoComparerError = class(EJclContainerError)
  public
    // RsENoComparer
    constructor Create;
  end;

  EJclNoHashConverterError = class(EJclContainerError)
  public
    // RsENoHashConverter
    constructor Create;
  end;

  EJclIllegalStateOperationError = class(EJclContainerError)
  public
    // RsEIllegalStateOperation
    constructor Create;
  end;

  EJclAssignError = class(EJclContainerError)
  public
    // RsEAssignError
    constructor Create;
  end;

  EJclReadOnlyError = class(EJclContainerError)
  public
    // RsEReadOnlyError
    constructor Create;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.2-Build3886/jcl/source/prototypes/JclContainerIntf.pas $';
    Revision: '$Revision: 1.2 $';
    Date: '$Date: 2010/12/01 13:00:14 $';
    LogPath: 'JCL\source\common';
    Extra: '';
    Data: nil
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils,
  JclResources;

//=== { EJclOutOfBoundsError } ===============================================

constructor EJclOutOfBoundsError.Create;
begin
  inherited CreateRes(@RsEOutOfBounds);
end;

//=== { EJclNoSuchElementError } =============================================

constructor EJclNoSuchElementError.Create(const Value: string);
begin
  inherited CreateResFmt(@RsEValueNotFound, [Value]);
end;

//=== { EJclDuplicateElementError } ==========================================

constructor EJclDuplicateElementError.Create;
begin
  inherited CreateRes(@RsEDuplicateElement);
end;

//=== { EJclIllegalQueueCapacityError } ======================================

constructor EJclIllegalQueueCapacityError.Create;
begin
  inherited CreateRes(@RsEIllegalQueueCapacity);
end;

//=== { EJclNoCollectionError } ==============================================

constructor EJclNoCollectionError.Create;
begin
  inherited CreateRes(@RsENoCollection);
end;

//=== { EJclOperationNotSupportedError } =====================================

constructor EJclOperationNotSupportedError.Create;
begin
  inherited CreateRes(@RsEOperationNotSupported);
end;

//=== { EJclIllegalStateOperationError } =====================================

constructor EJclIllegalStateOperationError.Create;
begin
  inherited CreateRes(@RsEIllegalStateOperation);
end;

//=== { EJclNoComparerError } ================================================

constructor EJclNoComparerError.Create;
begin
  inherited CreateRes(@RsENoComparer);
end;

//=== { EJclNoEqualityComparerError } ========================================

constructor EJclNoEqualityComparerError.Create;
begin
  inherited CreateRes(@RsENoEqualityComparer);
end;

//=== { EJclNoHashConverterError } ===========================================

constructor EJclNoHashConverterError.Create;
begin
  inherited CreateRes(@RsENoHashConverter);
end;

//=== { EJclAssignError } ====================================================

constructor EJclAssignError.Create;
begin
  inherited CreateRes(@RsEAssignError);
end;

//=== { EJclReadOnlyError } ==================================================

constructor EJclReadOnlyError.Create;
begin
  inherited CreateRes(@RsEReadOnlyError);
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

