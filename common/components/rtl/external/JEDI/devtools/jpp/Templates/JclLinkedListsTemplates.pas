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
{ The Original Code is JclLinkedListsTemplates.pas.                                                }
{                                                                                                  }
{ The Initial Developer of the Original Code is Florent Ouchet                                     }
{         <outchy att users dott sourceforge dott net>                                             }
{ Portions created by Florent Ouchet are Copyright (C) of Florent Ouchet. All rights reserved.     }
{                                                                                                  }
{ Contributors:                                                                                    }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date: 2010/12/01 12:58:13 $ }
{ Revision:      $Rev:: 3273                                                                     $ }
{ Author:        $Author: lulin $ }
{                                                                                                  }
{**************************************************************************************************}

unit JclLinkedListsTemplates;

interface

{$I jcl.inc}

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JclContainerTypes,
  JclContainerTemplates,
  JclContainer1DTemplates;

type
  (* JCLLINKEDLISTTYPESINT(ITEMCLASSNAME, TYPENAME) *)
  TJclLinkedListTypeIntParams = class(TJclContainerInterfaceParams)
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property ItemClassName: string index taLinkedListItemClassName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* JCLLINKEDLISTINT(ITEMCLASSNAME, SELFCLASSNAME, ANCESTORCLASSNAME, COLLECTIONINTERFACENAME,
                      LISTINTERFACENAME, ITRINTERFACENAME, INTERFACEADDITIONAL, SECTIONADDITIONAL,
                      COLLECTIONFLAGS, OWNERSHIPDECLARATION, CONSTKEYWORD, PARAMETERNAME,
                      TYPENAME, GETTERNAME, SETTERNAME) *)
  TJclLinkedListIntParams = class(TJclCollectionInterfaceParams)
  protected
    // function CodeUnit: string; override;
    function GetInterfaceAdditional: string; override;
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property ItemClassName: string index taLinkedListItemClassName read GetTypeAttribute write SetTypeAttribute stored False;
    property SelfClassName: string index taLinkedListClassName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property AncestorClassName;
    property CollectionInterfaceName: string index taCollectionInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ListInterfaceName: string index taListInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItrInterfaceName: string index taIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property EqualityComparerInterfaceName: string index taEqualityComparerInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property InterfaceAdditional;
    property SectionAdditional;
    property CollectionFlags;
    property OwnershipDeclaration;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property GetterName: string index taGetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property SetterName: string index taSetterName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* JCLLINKEDLISTITRINT(SELFCLASSNAME, ITRINTERFACENAME, LISTINTERFACENAME, EQUALITYCOMPARERINTERFACENAME,
                         ITEMCLASSNAME, CONSTKEYWORD, PARAMETERNAME, TYPENAME, DEFAULTVALUE,
                         GETTERNAME, SETTERNAME) *)
  TJclLinkedListItrIntParams = class(TJclContainerInterfaceParams)
  protected
    // function CodeUnit: string; override;
  public
    function AliasAttributeIDs: TAllTypeAttributeIDs; override;
  published
    property SelfClassName: string index taLinkedListIteratorClassName read GetTypeAttribute write SetTypeAttribute stored IsTypeAttributeStored;
    property ItrInterfaceName: string index taIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ListInterfaceName: string index taListInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property EqualityComparerInterfaceName: string index taEqualityComparerInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItemClassName: string index taLinkedListItemClassName read GetTypeAttribute write SetTypeAttribute stored False;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property DefaultValue: string index taDefaultValue read GetTypeAttribute write SetTypeAttribute stored False;
    property GetterName: string index taGetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property SetterName: string index taSetterName read GetTypeAttribute write SetTypeAttribute stored False;
  end;

  (* JCLLINKEDLISTIMP(SELFCLASSNAME, ITEMCLASSNAME, COLLECTIONINTERFACENAME, LISTINTERFACENAME,
                      ITRINTERFACENAME, ITRCLASSNAME, OWNERSHIPDECLARATION, OWNERSHIPPARAMETER,
                      CONSTKEYWORD, PARAMETERNAME, TYPENAME, DEFAULTVALUE,
                      GETTERNAME, SETTERNAME, RELEASERNAME) *)
  TJclLinkedListImpParams = class(TJclCollectionImplementationParams)
  protected
    // function CodeUnit: string; override;
  public
    function GetConstructorParameters: string; override;
    function GetSelfClassName: string; override;
  published
    property SelfClassName: string index taLinkedListClassName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItemClassName: string index taLinkedListItemClassName read GetTypeAttribute write SetTypeAttribute stored False;
    property CollectionInterfaceName: string index taCollectionInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ListInterfaceName: string index taListInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItrInterfaceName: string index taIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItrClassName: string index taLinkedListIteratorClassName read GetTypeAttribute write SetTypeAttribute stored False;
    property OwnershipDeclaration;
    property OwnershipParameter: string index taOwnershipParameter read GetTypeAttribute write SetTypeAttribute stored False;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property DefaultValue: string index taDefaultValue read GetTypeAttribute write SetTypeAttribute stored False;
    property GetterName: string index taGetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property SetterName: string index taSetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property ReleaserName: string index taReleaserName read GetTypeAttribute write SetTypeAttribute stored False;
    property MacroFooter;
  end;

  (* JCLLINKEDLISTITRIMP(SELFCLASSNAME, ITRINTERFACENAME, LISTINTERFACENAME, EQUALITYCOMPARERINTERFACENAME,
                         ITEMCLASSNAME, CONSTKEYWORD, PARAMETERNAME, TYPENAME, DEFAULTVALUE,
                         GETTERNAME, SETTERNAME, RELEASERCALL) *)
  TJclLinkedListItrImpParams = class(TJclContainerImplementationParams)
  private
    FReleaserCall: string;
    function GetReleaserCall: string;
  protected
    // function CodeUnit: string; override;
  public
    procedure ResetDefault(Value: Boolean); override;
  published
    property SelfClassName: string index taLinkedListIteratorClassName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItrInterfaceName: string index taIteratorInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ListInterfaceName: string index taListInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property EqualityComparerInterfaceName: string index taEqualityComparerInterfaceName read GetTypeAttribute write SetTypeAttribute stored False;
    property ItemClassName: string index taLinkedListItemClassName read GetTypeAttribute write SetTypeAttribute stored False;
    property ConstKeyword: string index taConstKeyword read GetTypeAttribute write SetTypeAttribute stored False;
    property ParameterName: string index taParameterName read GetTypeAttribute write SetTypeAttribute stored False;
    property TypeName: string index taTypeName read GetTypeAttribute write SetTypeAttribute stored False;
    property DefaultValue: string index taDefaultValue read GetTypeAttribute write SetTypeAttribute stored False;
    property GetterName: string index taGetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property SetterName: string index taSetterName read GetTypeAttribute write SetTypeAttribute stored False;
    property ReleaserCall: string read GetReleaserCall write FReleaserCall;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.2-Build3886/jcl/devtools/jpp/Templates/JclLinkedListsTemplates.pas $';
    Revision: '$Revision: 1.1 $';
    Date: '$Date: 2010/12/01 12:58:13 $';
    LogPath: 'JCL\devtools\jpp\Templates';
    Extra: '';
    Data: nil
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils,
  JclStrings;

procedure RegisterJclContainers;
begin
  RegisterContainerParams('JCLLINKEDLISTTYPESINT', TJclLinkedListTypeIntParams);
  RegisterContainerParams('JCLLINKEDLISTINT', TJclLinkedListIntParams);
  RegisterContainerParams('JCLLINKEDLISTITRINT', TJclLinkedListItrIntParams);
  RegisterContainerParams('JCLLINKEDLISTIMP', TJclLinkedListImpParams, TJclLinkedListIntParams);
  RegisterContainerParams('JCLLINKEDLISTITRIMP', TJclLinkedListItrImpParams, TJclLinkedListItrIntParams);
end;

//=== { TJclLinkedListTypeIntParams } ========================================

function TJclLinkedListTypeIntParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taLinkedListItemClassName];
end;

//=== { TJclLinkedListIntParams } ============================================

function TJclLinkedListIntParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taLinkedListClassName];
end;

function TJclLinkedListIntParams.GetInterfaceAdditional: string;
begin
  Result := FInterfaceAdditional;
  if Result = '' then
    Result := Format('%s %s,', [inherited GetInterfaceAdditional, EqualityComparerInterfaceName]);
end;

//=== { TJclLinkedListItrIntParams } =========================================

function TJclLinkedListItrIntParams.AliasAttributeIDs: TAllTypeAttributeIDs;
begin
  Result := [taLinkedListIteratorClassName];
end;

//=== { TJclLinkedListImpParams } ============================================

function TJclLinkedListImpParams.GetConstructorParameters: string;
begin
  Result := 'nil';
end;

function TJclLinkedListImpParams.GetSelfClassName: string;
begin
  Result := SelfClassName;
end;

//=== { TJclLinkedListItrImpParams } =========================================

function TJclLinkedListItrImpParams.GetReleaserCall: string;
begin
  Result := FReleaserCall;
  if (Result = '') and TypeInfo.KnownType then
  begin
    if TypeInfo.TObjectType then
      Result := '(FownList as IJclObjectOwner).FreeObject(FCursor.Value);'
    else
      Result := Format('FCursor.Value := %s;', [TypeInfo.TypeAttributes[taDefaultValue]]);
  end;
end;

procedure TJclLinkedListItrImpParams.ResetDefault(Value: Boolean);
begin
  inherited ResetDefault(Value);
  FReleaserCall := '';
  if not Value then
    FReleaserCall := GetReleaserCall;
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

