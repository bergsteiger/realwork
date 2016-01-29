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
{ The Original Code is BinaryTree.pas.                                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Jean-Philippe BEMPEL aka RDM. Portions created by  }
{ Jean-Philippe BEMPEL are Copyright (C) Jean-Philippe BEMPEL (rdm_30 att yahoo dott com)          }
{ All rights reserved.                                                                             }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Florent Ouchet (outchy)                                                                        }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ The Delphi Container Library                                                                     }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date: 2013/04/05 15:06:45 $ }
{ Revision:      $Rev:: 3511                                                                     $ }
{ Author:        $Author: lulin $ }
{                                                                                                  }
{**************************************************************************************************}

unit JclBinaryTrees;

{$I jcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes,
  JclBase, JclAbstractContainers, JclAlgorithms, JclContainerIntf, JclSynch;
{$I containers\JclContainerCommon.imp}
{$I containers\JclBinaryTrees.imp}
{$I containers\JclBinaryTrees.int}
type
  TItrStart = (isFirst, isLast, isRoot);

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO JCLBINARYTREETYPESINT(,)}

  {$JPPEXPANDMACRO JCLBINARYTREEINT(,,,,,,,,,,,,,,)}

  {$JPPEXPANDMACRO JCLBINARYTREEITRINT(,,,,,,,,,,,,,,)}

*)
  {$IFDEF SUPPORTS_GENERICS}
  //DOM-IGNORE-BEGIN

  (*$JPPEXPANDMACRO JCLBINARYTREETYPESINT(TJclBinaryNode<T>,T)*)

  TJclBinaryTreeIterator<T> = class;
  TJclPreOrderBinaryTreeIterator<T> = class;
  TJclInOrderBinaryTreeIterator<T> = class;
  TJclPostOrderBinaryTreeIterator<T> = class;

  (*$JPPEXPANDMACRO JCLBINARYTREEINT(TBinaryNode,TJclBinaryTree<T>,TJclAbstractContainer<T>,IJclCollection<T>,IJclTree<T>,IJclIterator<T>,IJclTreeIterator<T>, IJclItemOwner<T>\, IJclEqualityComparer<T>\, IJclComparer<T>\,,

protected
  type
    TBinaryNode = TJclBinaryNode<T>;
    TPreOrderBinaryTreeIterator = TJclPreOrderBinaryTreeIterator<T>;
    TInOrderBinaryTreeIterator = TJclInOrderBinaryTreeIterator<T>;
    TPostOrderBinaryTreeIterator = TJclPostOrderBinaryTreeIterator<T>;,,AOwnsItems: Boolean,,const ,AItem,T)*)

  {$JPPEXPANDMACRO JCLBINARYTREEITRINT(TJclBinaryTreeIterator<T>,TJclPreOrderBinaryTreeIterator<T>,TJclInOrderBinaryTreeIterator<T>,TJclPostOrderBinaryTreeIterator<T>,IJclIterator<T>,IJclTreeIterator<T>,IJclBinaryTreeIterator<T>,IJclCollection<T>,IJclEqualityComparer<T>,TJclBinaryNode<T>,const ,AItem,T,GetItem,SetItem)}

  // E = External helper to compare items
  TJclBinaryTreeE<T> = class(TJclBinaryTree<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclBaseContainer, IJclItemOwner<T>, IJclEqualityComparer<T>, IJclComparer<T>,
    IJclCollection<T>, IJclTree<T>)
  private
    FComparer: IJclComparer<T>;
  protected
    procedure AssignPropertiesTo(Dest: TJclAbstractContainerBase); override;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
  public
    constructor Create(const AComparer: IJclComparer<T>; AOwnsItems: Boolean);
    { IJclComparer<T> }
    function ItemsCompare(const A, B: T): Integer; override;
    { IJclEqualityComparer<T> }
    function ItemsEqual(const A, B: T): Boolean; override;
    property Comparer: IJclComparer<T> read FComparer write FComparer;
  end;

  // F = Function to compare items
  TJclBinaryTreeF<T> = class(TJclBinaryTree<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclBaseContainer, IJclItemOwner<T>, IJclEqualityComparer<T>, IJclComparer<T>,
    IJclCollection<T>, IJclTree<T>)
  protected
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
  public
    constructor Create(ACompare: TCompare<T>; AOwnsItems: Boolean);
  end;

  // I = Items can compare themselves to an other
  TJclBinaryTreeI<T: IComparable<T>> = class(TJclBinaryTree<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclBaseContainer, IJclItemOwner<T>, IJclEqualityComparer<T>, IJclComparer<T>,
    IJclCollection<T>, IJclTree<T>)
  protected
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
  public
    { IJclComparer<T> }
    function ItemsCompare(const A, B: T): Integer; override;
    { IJclEqualityComparer<T> }
    function ItemsEqual(const A, B: T): Boolean; override;
  end;

  //DOM-IGNORE-END
  {$ENDIF SUPPORTS_GENERICS}


{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.3-Build4197/jcl/source/prototypes/JclBinaryTrees.pas $';
    Revision: '$Revision: 1.1 $';
    Date: '$Date: 2013/04/05 15:06:45 $';
    LogPath: 'JCL\source\common';
    Extra: '';
    Data: nil
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils;

(*$JPPLOOP TRUETYPEINDEX TRUETYPECOUNT
{$JPPEXPANDMACRO JCLBINARYTREEIMP(,,,,,,,,,,,,,,,,)}

{$JPPEXPANDMACRO JCLBINARYTREEITRIMP(,,,,,,,,,,,,,,)}

*)

{$IFDEF SUPPORTS_GENERICS}
//DOM-IGNORE-BEGIN

(*$JPPEXPANDMACRO JCLBINARYTREEIMP(TJclBinaryTree<T>,TJclBinaryNode<T>,TPreOrderBinaryTreeIterator,TInOrderBinaryTreeIterator,TPostOrderBinaryTreeIterator,IJclCollection<T>,IJclIterator<T>,IJclTreeIterator<T>,,,AOwnsItems: Boolean,AOwnsItems,const ,AItem,T,Default(T),FreeItem)*)

{$JPPEXPANDMACRO JCLBINARYTREEITRIMP(TJclBinaryTreeIterator<T>,TJclPreOrderBinaryTreeIterator<T>,TJclInOrderBinaryTreeIterator<T>,TJclPostOrderBinaryTreeIterator<T>,IJclIterator<T>,IJclCollection<T>,IJclEqualityComparer<T>,TJclBinaryNode<T>,const ,AItem,T,Default(T),GetItem,SetItem,FreeItem)}

//=== { TJclBinaryTreeE<T> } =================================================

constructor TJclBinaryTreeE<T>.Create(const AComparer: IJclComparer<T>; AOwnsItems: Boolean);
begin
  inherited Create(AOwnsItems);
  FComparer := AComparer;
end;

procedure TJclBinaryTreeE<T>.AssignPropertiesTo(Dest: TJclAbstractContainerBase);
begin
  inherited AssignPropertiesTo(Dest);
  if Dest is TJclBinaryTreeE<T> then
    TJclBinaryTreeE<T>(Dest).FComparer := FComparer;
end;

function TJclBinaryTreeE<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclBinaryTreeE<T>.Create(Comparer, False);
  AssignPropertiesTo(Result);
end;

function TJclBinaryTreeE<T>.ItemsCompare(const A, B: T): Integer;
begin
  if Comparer <> nil then
    Result := Comparer.Compare(A, B)
  else
    Result := inherited ItemsCompare(A, B);
end;

function TJclBinaryTreeE<T>.ItemsEqual(const A, B: T): Boolean;
begin
  if Comparer <> nil then
    Result := Comparer.Compare(A, B) = 0
  else
    Result := inherited ItemsEqual(A, B);
end;

//=== { TJclBinaryTreeF<T> } =================================================

constructor TJclBinaryTreeF<T>.Create(ACompare: TCompare<T>; AOwnsItems: Boolean);
begin
  inherited Create(AOwnsItems);
  SetCompare(ACompare);
end;

function TJclBinaryTreeF<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclBinaryTreeF<T>.Create(Compare, False);
  AssignPropertiesTo(Result);
end;

//=== { TJclBinaryTreeI<T> } =================================================

function TJclBinaryTreeI<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclBinaryTreeI<T>.Create(False);
  AssignPropertiesTo(Result);
end;

function TJclBinaryTreeI<T>.ItemsCompare(const A, B: T): Integer;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B)
  else
    Result := A.CompareTo(B);
end;

function TJclBinaryTreeI<T>.ItemsEqual(const A, B: T): Boolean;
begin
  if Assigned(FEqualityCompare) then
    Result := FEqualityCompare(A, B)
  else
  if Assigned(FCompare) then
    Result := FCompare(A, B) = 0
  else
    Result := A.CompareTo(B) = 0;
end;

//DOM-IGNORE-END
{$ENDIF SUPPORTS_GENERICS}

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

