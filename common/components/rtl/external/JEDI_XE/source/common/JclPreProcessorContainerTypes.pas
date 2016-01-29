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
{ The Original Code is JclContainerTypes.pas.                                                      }
{                                                                                                  }
{ The Initial Developer of the Original Code is Florent Ouchet                                     }
{         <outchy att users dott sourceforge dott net>                                             }
{ Portions created by Florent Ouchet are Copyright (C) of Florent Ouchet. All rights reserved.     }
{                                                                                                  }
{ Contributors:                                                                                    }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date: 2013/04/05 14:59:16 $ }
{ Revision:      $Rev:: 3511                                                                     $ }
{ Author:        $Author: lulin $ }
{                                                                                                  }
{**************************************************************************************************}

unit JclPreProcessorContainerTypes;

interface

{$I jcl.inc}

uses
  JclBase,
  JclPreProcessorTemplates,
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JclNotify;


type
  TAllTypeAttributeID = (
    // attributes for 1-D containers
    taTypeName,
    taCondition, // condition while expanding macros, will be emitted
    taDefines,   // list of defines while expanding macros, won't be emitted
    taUndefs,    // list of undefs while expanding macros, won't be emitted
    taAlias,
    taAliasCondition,
    taDefaultValue,
    taConstKeyword,
    taOwnershipParameter,
    taOwnershipInterfaceName,
    taOwnershipInterfaceGUID,
    taReleaserName,
    taReleaseEventName,
    taReleaseEventTypeName,
    taGetterName,
    taSetterName,
    taParameterName,
    taDynArrayTypeName,
    taArrayName,
    taBaseContainer,
    taBaseCollection,
    taIterateProcedureName,
    taApplyFunctionName,
    taCompareFunctionName,
    taSimpleCompareFunctionName,
    taEqualityCompareFunctionName,
    taSimpleEqualityCompareFunctionName,
    taHashConvertFunctionName,
    taSimpleHashConvertFunctionName,
    taContainerInterfaceName,
    taContainerInterfaceGUID,
    taFlatContainerInterfaceName,
    taFlatContainerInterfaceGUID,
    taEqualityComparerInterfaceName,
    taEqualityComparerInterfaceGUID,
    taComparerInterfaceName,
    taComparerInterfaceGUID,
    taHashConverterInterfaceName,
    taHashConverterInterfaceGUID,
    taIteratorInterfaceName,
    taIteratorInterfaceGUID,
    taBinaryTreeIteratorInterfaceName,
    taBinaryTreeIteratorInterfaceGUID,
    taBinaryTreeNodeTypeName,
    taBinaryTreeClassName,
    taBinaryTreeBaseIteratorClassName,
    taBinaryTreePreOrderIteratorClassName,
    taBinaryTreeInOrderIteratorClassName,
    taBinaryTreePostOrderIteratorClassName,
    taCollectionInterfaceName,
    taCollectionInterfaceGUID,
    taListInterfaceName,
    taListInterfaceGUID,
    taSortProcedureName,
    taArrayInterfaceName,
    taArrayInterfaceGUID,
    taArrayListClassName,
    taArrayIteratorClassName,
    taLinkedListItemClassName,
    taLinkedListClassName,
    taLinkedListIteratorClassName,
    taVectorClassName,
    taVectorIteratorClassName,
    taSetInterfaceName,
    taSetInterfaceGUID,
    taArraySetClassName,
    taTreeIteratorInterfaceName,
    taTreeIteratorInterfaceGUID,
    taTreeInterfaceName,
    taTreeInterfaceGUID,
    taTreeNodeClassName,
    taTreeClassName,
    taTreeBaseIteratorClassName,
    taTreePreOrderIteratorClassName,
    taTreePostOrderIteratorClassName,
    taQueueInterfaceName,
    taQueueInterfaceGUID,
    taQueueClassName,
    taSortedSetInterfaceName,
    taSortedSetInterfaceGUID,
    taStackInterfaceName,
    taStackInterfaceGUID,
    taStackClassName,
    // attributes for 2-D containers (maps)
    kaKeyTypeName,
    kaKeyOwnershipParameter,
    kaKeyConstKeyword,
    kaKeyParameterName,
    kaKeyDefaultValue,
    kaKeySimpleCompareFunctionName,
    kaKeySimpleEqualityCompareFunctionName,
    kaKeySimpleHashConvertFunctionName,
    kaKeyBaseContainerClassName,
    kaKeyIteratorInterfaceName,
    kaKeySetInterfaceName,
    kaKeyArraySetClassName,
    vaValueTypeName,
    vaValueOwnershipParameter,
    vaValueConstKeyword,
    vaValueDefaultValue,
    vaValueSimpleCompareFunctionName,
    vaValueSimpleEqualityCompareFunctionName,
    vaValueBaseContainerClassName,
    vaValueCollectionInterfaceName,
    vaValueArrayListClassName,
    maMapInterfaceName,
    maMapInterfaceGUID,
    maMapInterfaceAncestorName,
    maSortedMapInterfaceName,
    maSortedMapInterfaceGUID,
    maMapAncestorClassName,
    maHashMapEntryTypeName,
    maHashMapBucketTypeName,
    maHashMapClassName,
    maSortedMapEntryTypeName,
    maSortedMapClassName);
  TAllTypeAttributeIDs = set of TAllTypeAttributeID;

  TTypeAttributeID = taTypeName..taStackClassName;
  {$EXTERNALSYM TTypeAttributeID}
  {$HPPEMIT '#define TTypeAttributeID int'}

  TTypeAttributes = array [TTypeAttributeID] of string;

  TKnownTypeAttributes = TTypeAttributes;
  PKnownTypeAttributes = ^TKnownTypeAttributes;

  TKeyAttributeID = kaKeyTypeName..kaKeyArraySetClassName;
  {$EXTERNALSYM TKeyAttributeID}
  {$HPPEMIT '#define TKeyAttributeID int'}

  TValueAttributeID = vaValueTypeName..vaValueArrayListClassName;
  {$EXTERNALSYM TValueAttributeID}
  {$HPPEMIT '#define TValueAttributeID int'}

  TMapAttributeID = maMapInterfaceName..maSortedMapClassName;
  {$EXTERNALSYM TMapAttributeID}
  {$HPPEMIT '#define TMapAttributeID int'}

  TMapAttributes = array [TMapAttributeID] of string;

  TKnownMapAttributes = record
    MapAttributes: TMapAttributes;
    KeyAttributes: PKnownTypeAttributes;
    ValueAttributes: PKnownTypeAttributes;
  end;
  PKnownMapAttributes = ^TKnownMapAttributes;

  TTypeAttributeInfo = record
    IsGUID: Boolean;
    DefaultValue: string;
  end;

const
  TypeAttributeInfos: array [TTypeAttributeID] of TTypeAttributeInfo =
    ( {TypeName} (IsGUID: False; DefaultValue: ''),
      {Condition} (IsGUID: False; DefaultValue: ''),
      {Defines} (IsGUID: False; DefaultValue: ''),
      {Undefs} (IsGUID: False; DefaultValue: ''),
      {Alias} (IsGUID: False; DefaultValue: ''),
      {AliasCondition} (IsGUID: False; DefaultValue: ''),
      {DefaultValue} (IsGUID: False; DefaultValue: ''),
      {ConstKeyword} (IsGUID: False; DefaultValue: ''),
      {OwnershipParameter} (IsGUID: False; DefaultValue: ''),
      {OwnershipInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sOwner'),
      {OwnershipInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {ReleaserName} (IsGUID: False; DefaultValue: 'Free%s'),
      {ReleaseEventName} (IsGUID: False; DefaultValue: 'OnFree%s'),
      {ReleaseEventTypeName} (IsGUID: False; DefaultValue: 'TFree%sEvent'),
      {GetterName} (IsGUID: False; DefaultValue: 'Get%s'),
      {SetterName} (IsGUID: False; DefaultValue: 'Set%s'),
      {ParameterName} (IsGUID: False; DefaultValue: 'A%s'),
      {DynArrayTypeName} (IsGUID: False; DefaultValue: 'TDyn%sArray'),
      {ArrayName} (IsGUID: False; DefaultValue: '%ss'),
      {BaseContainer} (IsGUID: False; DefaultValue: ''),
      {BaseCollection} (IsGUID: False; DefaultValue: ''),
      {IterateProcedureName} (IsGUID: False; DefaultValue: 'T%sIterateFunction'),
      {ApplyFunctionName} (IsGUID: False; DefaultValue: 'T%sApplyFunction'),
      {CompareFunctionName} (IsGUID: False; DefaultValue: 'T%sCompareFunction'),
      {SimpleCompareFunctionName} (IsGUID: False; DefaultValue: '%sSimpleCompare'),
      {EqualityCompareFunctionName} (IsGUID: False; DefaultValue: 'T%sEqualityCompare'),
      {SimpleEqualityCompareFunctionName} (IsGUID: False; DefaultValue: '%sSimpleCompare'),
      {HashConvertFunctionName} (IsGUID: False; DefaultValue: 'T%sHashConvert'),
      {SimpleHashConvertFunctionName} (IsGUID: False; DefaultValue: '%sSimpleHashConvert'),
      {ContainerInterfaceName} (IsGUID: False; DefaultValue: ''),
      {ContainerInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {FlatContainerInterfaceName} (IsGUID: False; DefaultValue: ''),
      {FlatContainerInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {EqualityComparerInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sEqualityComparer'),
      {EqualityComparerInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {ComparerInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sComparer'),
      {ComparerInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {HashConverterInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sHashConverter'),
      {HashConverterInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {IteratorInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sIterator'),
      {IteratorInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {BinaryTreeIteratorInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sBinaryTreeIterator'),
      {BinaryTreeIteratorInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {BinaryTreeNodeTypeName} (IsGUID: False; DefaultValue: 'TJcl%sBinaryNode'),
      {BinaryTreeClassName} (IsGUID: False; DefaultValue: 'TJcl%sBinaryTree'),
      {BinaryTreeBaseIteratorClassName} (IsGUID: False; DefaultValue: 'TJcl%sBinaryTreeIterator'),
      {BinaryTreePreOrderIteratorClassName} (IsGUID: False; DefaultValue: 'TJclPreOrder%sBinaryTreeIterator'),
      {BinaryTreeInOrderIteratorClassName} (IsGUID: False; DefaultValue: 'TJclInOrder%sBinaryTreeIterator'),
      {BinaryTreePostOrderIteratorClassName} (IsGUID: False; DefaultValue: 'TJclPostOrder%sBinaryTreeIterator'),
      {CollectionInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sCollection'),
      {CollectionInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {ListInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sList'),
      {ListInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {SortProcedureName} (IsGUID: False; DefaultValue: 'T%sSortProc'),
      {ArrayInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sArray'),
      {ArrayInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {ArrayListClassName} (IsGUID: False; DefaultValue: 'TJcl%sArrayList'),
      {ArrayIteratorClassName} (IsGUID: False; DefaultValue: 'TJcl%sArrayIterator'),
      {ArrayListClassName} (IsGUID: False; DefaultValue: 'TJcl%sArraySet'),
      {LinkedListItemTypeName} (IsGUID: False; DefaultValue: 'TJcl%sLinkedListItem'),
      {LinkedListClassName} (IsGUID: False; DefaultValue: 'TJcl%sLinkedList'),
      {LinkedListIteratorClassName} (IsGUID: False; DefaultValue: 'TJcl%sLinkedListIterator'),
      {VectorClassName} (IsGUID: False; DefaultValue: 'TJcl%sVector'),
      {VectorIteratorClassName} (IsGUID: False; DefaultValue: 'TJcl%sVectorIterator'),
      {SetInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sSet'),
      {SetInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {TreeIteratorInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sTreeIterator'),
      {TreeIteratorInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {TreeInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sTree'),
      {TreeInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {TreeNodeClassName} (IsGUID: False; DefaultValue: 'TJcl%sTreeNode'),
      {TreeClassName} (IsGUID: False; DefaultValue: 'TJcl%sTree'),
      {TreeBaseIteratorClassName} (IsGUID: False; DefaultValue: 'TJcl%sTreeIterator'),
      {TreePreOrderIteratorClassName} (IsGUID: False; DefaultValue: 'TJclPreOrder%sTreeIterator'),
      {TreePostOrderIteratorClassName} (IsGUID: False; DefaultValue: 'TJclPostOrder%sTreeIterator'),
      {QueueInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sQueue'),
      {QueueInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {QueueClassName} (IsGUID: False; DefaultValue: 'TJcl%sQueue'),
      {SortedSetInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sSortedSet'),
      {SortedSetInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {StackInterfaceName} (IsGUID: False; DefaultValue: 'IJcl%sStack'),
      {StackInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {StackClassName} (IsGUID: False; DefaultValue: 'TJcl%sStack') );

  KeyAttributeInfos: array [TKeyAttributeID] of TTypeAttributeID =
    ( {KeyTypeName} taTypeName,
      {KeyOwnershipParameter} taOwnershipParameter,
      {KeyConstKeyword} taConstKeyword,
      {KeyParameterName} taParameterName,
      {KeyDefaultValue} taDefaultValue,
      {KeySimpleCompareFunctionName} taSimpleCompareFunctionName,
      {KeySimpleEqualityCompareFunctionName} taSimpleEqualityCompareFunctionName,
      {KeySimpleHashConvertFunctionName} taSimpleHashConvertFunctionName,
      {KeyBaseContainerClassName} taBaseContainer,
      {KeyIteratorInterfaceName} taIteratorInterfaceName,
      {KeySetInterfaceName} taSetInterfaceName,
      {KeyArraySetClassName} taArraySetClassName);

  ValueAttributeInfos: array [TValueAttributeID] of TTypeAttributeID =
    ( {ValueTypeName} taTypeName,
      {ValueOwnershipParameter} taOwnershipParameter,
      {ValueConstKeyword} taConstKeyword,
      {ValueDefaultValue} taDefaultValue,
      {ValueSimpleCompareFunctionName} taSimpleCompareFunctionName,
      {ValueSimpleEqualityCompareFunctionName} taSimpleEqualityCompareFunctionName,
      {ValueBaseContainerClassName} taBaseContainer,
      {ValueCollectionInterfaceName} taCollectionInterfaceName,
      {ValueArrayListClassName} taArrayListClassName);

  MapAttributeInfos: array [TMapAttributeID] of TTypeAttributeInfo =
    ( {MapInterfaceName} (IsGUID: False; DefaultValue: 'TJcl%s%sMap'),
      {MapInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {MapInterfaceAncestorName} (IsGUID: False; DefaultValue: 'IJclBaseContainer'),
      {SortedMapInterfaceName} (IsGUID: False; DefaultValue: 'TJcl%s%sSortedMap'),
      {SortedMapInterfaceGUID} (IsGUID: True; DefaultValue: ''),
      {MapAncestorClassName} (IsGUID: False; DefaultValue: 'TJclContainer'),
      {HashMapEntryTypeName} (IsGUID: False; DefaultValue: 'TJcl%s%sHashEntry'),
      {HashMapBucketTypeName} (IsGUID: False; DefaultValue: 'TJcl%s%sHashBucket'),
      {HashMapClassName} (IsGUID: False; DefaultValue: 'TJcl%s%sHashMap'),
      {SortedMapEntryTypeName} (IsGUID: False; DefaultValue: 'TJcl%s%sSortedEntry'),
      {SortedMapClassName} (IsGUID: False; DefaultValue: 'TJcl%s%sSortedMap') );

type
  EJclContainerException = class(EJclError);

  TCodeLocation = (clDefault, clAtCursor, clInterface, clImplementation);

  TJclMacroParams = class
  private
    // FCodeLocation: TCodeLocation;
    // FCodeUnit: string;
  protected
    // function CodeLocation: string; virtual;
    // function CodeUnit: string; virtual;
  public
    function IsDefault: Boolean; virtual;
    procedure ResetDefault(Value: Boolean); virtual;

    // this function returns some text to be emitted at the beginning of the macro
    function GetMacroHeader: string; virtual;
    // this function returns some text to be emitted at the end of the macro
    function GetMacroFooter: string; virtual;

    // procedure InterfaceUnitDependencies(Units: TStrings); virtual;
    // procedure ImplementationUnitDependencies(Units: TStrings); virtual;

    // property CodeLocation: TCodeLocation read GetCodeLocation write FCodeLocation;
    // property CodeUnit: string read GetCodeUnit write FCodeUnit;
  end;

  TJclInterfaceParams = class(TJclMacroParams)
  public
    // this function returns the attribute ID when alias declarations should be emitted
    // taTypeName is ignored
    function AliasAttributeIDs: TAllTypeAttributeIDs; virtual;
  end;

  TJclInterfaceParamsClass = class of TJclInterfaceParams;

  TJclImplementationParams = class(TJclMacroParams)
  private
    FInterfaceParams: TJclInterfaceParams;
  public
    constructor Create(AInterfaceParams: TJclInterfaceParams);
    property InterfaceParams: TJclInterfaceParams read FInterfaceParams;
  end;

  TJclImplementationParamsClass = class of TJclImplementationParams;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.3-Build4197/jcl/source/common/JclPreProcessorContainerTypes.pas $';
    Revision: '$Revision: 1.1 $';
    Date: '$Date: 2013/04/05 14:59:16 $';
    LogPath: 'JCL\source\common';
    Extra: '';
    Data: nil
    );
{$ENDIF UNITVERSIONING}

implementation

//=== { TJclMacroParams } ====================================================

function TJclMacroParams.GetMacroFooter: string;
begin
  // override to customize
  Result := '';
end;

function TJclMacroParams.GetMacroHeader: string;
begin
  // override to customize
  Result := '';
end;

function TJclMacroParams.IsDefault: Boolean;
begin
  // default if no properties are marked as "stored"
  Result := True;
end;

procedure TJclMacroParams.ResetDefault(Value: Boolean);
begin
  // override to customize
end;

//=== { TJclInterfaceParams } ================================================

function TJclInterfaceParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [];
end;

//=== { TJclImplementationParams } ===========================================

constructor TJclImplementationParams.Create(AInterfaceParams: TJclInterfaceParams);
begin
  inherited Create;
  FInterfaceParams := AInterfaceParams;
end;


{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

