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
{ The Original Code is JclContainerIntfTemplates.pas.                                              }
{                                                                                                  }
{ The Initial Developer of the Original Code is Florent Ouchet                                     }
{         <outchy att users dott sourceforge dott net>                                             }
{ Portions created by Florent Ouchet are Copyright (C) of Florent Ouchet. All rights reserved.     }
{                                                                                                  }
{ Contributors:                                                                                    }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date: 2010/12/01 12:58:12 $ }
{ Revision:      $Rev:: 3295                                                                     $ }
{ Author:        $Author: lulin $ }
{                                                                                                  }
{**************************************************************************************************}

unit JclContainerIntfTemplates;

interface

{$I jcl.inc}

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JclContainerTypes,
  JclContainerTemplates,
  JclContainer1DTemplates,
  JclContainer2DTemplates;

type
  TJclContainerIntf1DParams = class(TJclContainerInterfaceParams)
  protected
    // function CodeUnit: string; override;
  end;

  TJclContainerIntf2DParams = class(TJclMapInterfaceParams)
  protected
    // function CodeUnit: string; override;
  end;

  TJclContainerIntfAncestorParams = class(TJclContainerIntf1DParams)
  protected
    FAncestorName: string;
    function GetAncestorName: string; virtual;
    function IsAncestorNameStored: Boolean;
  public
    property AncestorName: string read GetAncestorName write FAncestorName stored IsAncestorNameStored;
  end;

  TJclContainerIntfFlatAncestorParams = class(TJclContainerIntfAncestorParams)
  protected
    function GetAncestorName: string; override;
  end;

  (* ITERPROCEDURE(PROCNAME, CONSTKEYWORD, PARAMETERNAME, TYPENAME) *)
  TJclIterProcedureParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property ProcName: string index taIterateProcedureName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* APPLYFUNCTION(FUNCNAME, CONSTKEYWORD, PARAMETERNAME, TYPENAME) *)
  TJclApplyFunctionParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property FuncName: string index taApplyFunctionName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* COMPAREFUNCTION(FUNCNAME, CONSTKEYWORD, TYPENAME) *)
  TJclCompareFunctionParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property FuncName: string index taCompareFunctionName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* EQUALITYCOMPAREFUNCTION(FUNCNAME, CONSTKEYWORD, TYPENAME) *)
  TJclEqualityCompareFunctionParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property FuncName: string index taEqualityCompareFunctionName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* HASHFUNCTION(FUNCNAME, CONSTKEYWORD, PARAMETERNAME, TYPENAME) *)
  TJclHashFunctionParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property FuncName: string index taHashConvertFunctionName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* SORTPROC(PROCNAME, LISTINTERFACENAME, COMPAREFUNCNAME) *)
  TJclSortFunctionParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property ProcName: string index taSortProcedureName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ListInterfaceName: string index taListInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property CompareFuncName: string index taCompareFunctionName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* EQUALITYCOMPARER(INTERFACENAME, GUID, EQUALITYCOMPARETYPENAME, CONSTKEYWORD, TYPENAME) *)
  TJclEqualityComparerParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taEqualityComparerInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property GUID: string index taEqualityComparerInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property EqualityCompareTypeName: string index taEqualityCompareFunctionName read GetTypeAttribute write SetTypeAttribute stored False;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* COMPARER(INTERFACENAME, GUID, COMPARETYPENAME, CONSTKEYWORD, TYPENAME) *)
  TJclComparerParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taComparerInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property GUID: string index taComparerInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property CompareTypeName: string index taCompareFunctionName read GetTypeAttribute write SetTypeAttribute stored False;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* HASHCONVERTER(INTERFACENAME, GUID, HASHCONVERTTYPENAME, CONSTKEYWORD, PARAMETERNAME, TYPENAME) *)
  TJclHashConverterParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taHashConverterInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property GUID: string index taHashConverterInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property HashConvertTypeName: string index taHashConvertFunctionName read GetTypeAttribute write SetTypeAttribute stored False;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* ITERATOR(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, PARAMETERNAME, TYPENAME, GETTERNAME, SETTERNAME) *)
  TJclIteratorParams = class(TJclContainerIntfAncestorParams)
  protected
    function GetAncestorName: string; override;
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName;
    property GUID: string index taIteratorInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property GetterName: string index taGetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property SetterName: string index taSetterName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* TREEITERATOR(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, PARAMETERNAME, TYPENAME) *)
  TJclTreeIteratorParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taTreeIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName: string index taIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property GUID: string index taTreeIteratorInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* BINTREEITERATOR(INTERFACENAME, ANCESTORNAME, GUID, TYPENAME) *)
  TJclBinaryTreeIteratorParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taBinaryTreeIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName: string index taTreeIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property GUID: string index taBinaryTreeIteratorInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* COLLECTION(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, PARAMETERNAME, TYPENAME, ITRNAME) *)
  TJclCollectionParams = class(TJclContainerIntfFlatAncestorParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taCollectionInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName;
    property GUID: string index taCollectionInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItrName: string index taIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* LIST(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, PARAMETERNAME, TYPENAME, GETTERNAME, SETTERNAME, PROPNAME) *)
  TJclListParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taListInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName: string index taCollectionInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property GUID: string index taListInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property GetterName: string index taGetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property SetterName: string index taSetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property PropName: string index taArrayName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* ARRAY(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, PARAMETERNAME, TYPENAME, GETTERNAME, SETTERNAME, PROPNAME) *)
  TJclArrayParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taArrayInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName: string index taListInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property GUID: string index taArrayInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property GetterName: string index taGetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property SetterName: string index taSetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property PropName: string index taArrayName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* SET(INTERFACENAME, ANCESTORNAME, GUID) *)
  TJclSetParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taSetInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName: string index taCollectionInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property GUID: string index taSetInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
  end;

  (* TREE(INTERFACENAME, ANCESTORNAME, GUID, ITRNAME) *)
  TJclTreeParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taTreeInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName: string index taCollectionInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property GUID: string index taTreeInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ItrName: string index taTreeIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* MAP(INTERFACENAME, ANCESTORNAME, GUID, KEYCONSTKEYWORD, KEYTYPENAME, KEYSETNAME,
         VALUECONSTKEYWORD, VALUETYPENAME, VALUECOLLECTIONNAME) *)
  TJclMapParams = class(TJclContainerIntf2DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index maMapInterfaceName read GetMapAttribute write SetMapAttribute stored IsMapAttributeStored;
    property AncestorName: string index maMapInterfaceAncestorName read GetMapAttribute write SetMapAttribute stored IsMapAttributeStored;
    property GUID: string index maMapInterfaceGUID read GetMapAttribute write SetMapAttribute stored IsMapAttributeStored;
    property ConstKeyword: string index kaKeyConstKeyword read GetKeyAttribute write SetKeyAttribute stored False;
    property TypeName: string index kaKeyTypeName read GetKeyAttribute write SetKeyAttribute stored False;
    property SetName: string index kaKeySetInterfaceName read GetKeyAttribute write SetKeyAttribute stored False;
    property CollectionName: string index vaValueCollectionInterfaceName read GetValueAttribute write SetValueAttribute stored False;
    property KeyConstKeyword: string index kaKeyConstKeyword read GetKeyAttribute write SetKeyAttribute stored False;
    property KeyTypeName: string index kaKeyTypeName read GetKeyAttribute write SetKeyAttribute stored False;
    property KeySetName: string index kaKeySetInterfaceName read GetKeyAttribute write SetKeyAttribute stored False;
    property ValueConstKeyword: string index vaValueConstKeyword read GetValueAttribute write SetValueAttribute stored False;
    property ValueTypeName: string index vaValueTypeName read GetValueAttribute write SetValueAttribute stored False;
    property ValueCollectionName: string index vaValueCollectionInterfaceName read GetValueAttribute write SetValueAttribute stored False;
  end;

  (* QUEUE(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, PARAMETERNAME, TYPENAME) *)
  TJclQueueParams = class(TJclContainerIntfAncestorParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taQueueInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName;
    property GUID: string index taQueueInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* SORTEDMAP(INTERFACENAME, ANCESTORNAME, GUID, KEYCONSTKEYWORD, KEYTYPENAME) *)
  TJclSortedMapParams = class(TJclContainerIntf2DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index maSortedMapInterfaceName read GetMapAttribute write SetMapAttribute stored IsMapAttributeStored;
    property AncestorName: string index maMapInterfaceName read GetMapAttribute write SetMapAttribute stored False;
    property GUID: string index maSortedMapInterfaceGUID read GetMapAttribute write SetMapAttribute stored IsMapAttributeStored;
    property KeyConstKeyword: string index kaKeyConstKeyword read GetKeyAttribute write SetKeyAttribute stored False;
    property KeyTypeName: string index kaKeyTypeName read GetKeyAttribute write SetKeyAttribute stored False;
  end;

  (* SORTEDSET(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, TYPENAME) *)
  TJclSortedSetParams = class(TJclContainerIntf1DParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taSortedSetInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName: string index taSetInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property GUID: string index taSortedSetInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* STACK(INTERFACENAME, ANCESTORNAME, GUID, CONSTKEYWORD, PARAMETERNAME, TYPENAME) *)
  TJclStackParams = class(TJclContainerIntfAncestorParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property InterfaceName: string index taStackInterfaceName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorName;
    property GUID: string index taStackInterfaceGUID read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.2-Build3886/jcl/devtools/jpp/Templates/JclContainerIntfTemplates.pas $';
    Revision: '$Revision: 1.1 $';
    Date: '$Date: 2010/12/01 12:58:12 $';
    LogPath: 'JCL\devtools\jpp\Templates';
    Extra: '';
    Data: nil
    );
{$ENDIF UNITVERSIONING}

implementation

procedure RegisterJclContainers;
begin
  RegisterContainerParams('ITERPROCEDURE', TJclIterProcedureParams);
  RegisterContainerParams('APPLYFUNCTION', TJclApplyFunctionParams);
  RegisterContainerParams('COMPAREFUNCTION', TJclCompareFunctionParams);
  RegisterContainerParams('EQUALITYCOMPAREFUNCTION', TJclEqualityCompareFunctionParams);
  RegisterContainerParams('HASHFUNCTION', TJclHashFunctionParams);
  RegisterContainerParams('SORTPROC', TJclSortFunctionParams);
  RegisterContainerParams('EQUALITYCOMPARER', TJclEqualityComparerParams);
  RegisterContainerParams('COMPARER', TJclComparerParams);
  RegisterContainerParams('HASHCONVERTER', TJclHashConverterParams);
  RegisterContainerParams('ITERATOR', TJclIteratorParams);
  RegisterContainerParams('TREEITERATOR', TJclTreeIteratorParams);
  RegisterContainerParams('BINTREEITERATOR', TJclBinaryTreeIteratorParams);
  RegisterContainerParams('COLLECTION', TJclCollectionParams);
  RegisterContainerParams('LIST', TJclListParams);
  RegisterContainerParams('ARRAY', TJclArrayParams);
  RegisterContainerParams('SET', TJclSetParams);
  RegisterContainerParams('TREE', TJclTreeParams);
  RegisterContainerParams('MAP', TJclMapParams);
  RegisterContainerParams('QUEUE', TJclQueueParams);
  RegisterContainerParams('SORTEDMAP', TJclSortedMapParams);
  RegisterContainerParams('SORTEDSET', TJclSortedSetParams);
  RegisterContainerParams('STACK', TJclStackParams);
end;

//=== { TJclContainerIntfAncestorParams } ====================================

function TJclContainerIntfAncestorParams.GetAncestorName: string;
begin
  Result := FAncestorName;
  if Result = '' then
    Result := TypeInfo.TypeAttributes[taContainerInterfaceName];
  if Result = '' then
    Result := 'IJclContainer';
end;

function TJclContainerIntfAncestorParams.IsAncestorNameStored: Boolean;
begin
  Result := FAncestorName <> '';
end;

//=== { TJclIteratorParams } =================================================

function TJclIteratorParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taIteratorInterfaceName];
end;

function TJclIteratorParams.GetAncestorName: string;
begin
  Result := FAncestorName;
  if Result = '' then
    Result := 'IJclAbstractIterator';
end;

//=== { TJclContainerIntfFlatAncestorParams } ================================

function TJclContainerIntfFlatAncestorParams.GetAncestorName: string;
begin
  Result := FAncestorName;
  if Result = '' then
    Result := TypeInfo.TypeAttributes[taFlatContainerInterfaceName];
  if Result = '' then
    Result := TypeInfo.TypeAttributes[taContainerInterfaceName];
  if Result = '' then
    Result := 'IJclContainer';
end;

//=== { TJclIterProcedureParams } ============================================

function TJclIterProcedureParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taIterateProcedureName];
end;

//=== { TJclApplyFunctionParams } ============================================

function TJclApplyFunctionParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taApplyFunctionName];
end;

//=== { TJclCompareFunctionParams } ==========================================

function TJclCompareFunctionParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taCompareFunctionName];
end;

//=== { TJclEqualityCompareFunctionParams } ==================================

function TJclEqualityCompareFunctionParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taEqualityCompareFunctionName];
end;

//=== { TJclHashFunctionParams } =============================================

function TJclHashFunctionParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taHashConvertFunctionName];
end;

//=== { TJclSortFunctionParams } =============================================

function TJclSortFunctionParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taSortProcedureName];
end;

//=== { TJclEqualityComparerParams } =========================================

function TJclEqualityComparerParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taEqualityComparerInterfaceName];
end;

//=== { TJclComparerParams } =================================================

function TJclComparerParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taComparerInterfaceName];
end;

//=== { TJclHashConverterParams } ============================================

function TJclHashConverterParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taHashConverterInterfaceName];
end;

//=== { TJclTreeIteratorParams } =============================================

function TJclTreeIteratorParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taTreeIteratorInterfaceName];
end;

//=== { TJclBinaryTreeIteratorParams } =======================================

function TJclBinaryTreeIteratorParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taBinaryTreeIteratorInterfaceName];
end;

//=== { TJclCollectionParams } ===============================================

function TJclCollectionParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taCollectionInterfaceName];
end;

//=== { TJclListParams } =====================================================

function TJclListParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taListInterfaceName];
end;

//=== { TJclArrayParams } ====================================================

function TJclArrayParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taArrayInterfaceName];
end;

//=== { TJclSetParams } ======================================================

function TJclSetParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taSetInterfaceName];
end;

//=== { TJclTreeParams } =====================================================

function TJclTreeParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taTreeInterfaceName];
end;

//=== { TJclMapParams } =====================================================

function TJclMapParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [maMapInterfaceName];
end;

//=== { TJclQueueParams } ====================================================

function TJclQueueParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taQueueInterfaceName];
end;

//=== { TJclSortedMapParams } ================================================

function TJclSortedMapParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [maSortedMapInterfaceName];
end;

//=== { TJclSortedSetParams } ================================================

function TJclSortedSetParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taSortedSetInterfaceName];
end;

//=== { TJclStackParams } ====================================================

function TJclStackParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taStackInterfaceName];
end;

initialization
  RegisterJclContainers;
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}

finalization
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.

