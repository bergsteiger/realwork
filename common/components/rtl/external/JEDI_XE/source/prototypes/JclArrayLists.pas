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
{ The Original Code is ArrayList.pas.                                                              }
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

unit JclArrayLists;

{$I jcl.inc}

interface

uses
  Classes,
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JclAlgorithms,
  JclBase, JclAbstractContainers, JclContainerIntf, JclSynch;
{$I containers\JclContainerCommon.imp}
{$I containers\JclArrayLists.int}
{$I containers\JclArrayLists.imp}
type
  TItrStart = (isFirst, isLast);

(*$JPPLOOP ALLTYPEINDEX ALLTYPECOUNT
  {$JPPEXPANDMACRO JCLARRAYLISTINT(,,,,,,,,,,,,,,,)}

  {$JPPEXPANDMACRO JCLARRAYLISTITRINT(,,,,,,,)}

*)
  {$IFDEF SUPPORTS_GENERICS}
  //DOM-IGNORE-BEGIN

  TJclArrayIterator<T> = class;

  {$JPPEXPANDMACRO JCLARRAYLISTINT(TJclArrayList<T>,TJclAbstractContainer<T>,IJclCollection<T>,IJclList<T>,IJclArray<T>,IJclIterator<T>,TDynArray, IJclItemOwner<T>\, IJclEqualityComparer<T>\,,

protected
  type
    TDynArray = array of T;
    TArrayIterator = TJclArrayIterator<T>;
  procedure MoveArray(var List: TDynArray; FromIndex, ToIndex, Count: Integer);,,; AOwnsItems: Boolean,const ,AItem,T,GetItem,SetItem)}

  {$JPPEXPANDMACRO JCLARRAYLISTITRINT(TJclArrayIterator<T>,IJclIterator<T>,IJclList<T>,const ,AItem,T,GetItem,SetItem)}

  // E = External helper to compare items for equality
  // GetHashCode is not used
  TJclArrayListE<T> = class(TJclArrayList<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclPackable, IJclGrowable, IJclBaseContainer, IJclItemOwner<T>, IJclEqualityComparer<T>,
    IJclCollection<T>, IJclList<T>, IJclArray<T>)
  private
    FEqualityComparer: IJclEqualityComparer<T>;
  protected
    procedure AssignPropertiesTo(Dest: TJclAbstractContainerBase); override;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
  public
    constructor Create(const AEqualityComparer: IJclEqualityComparer<T>; ACapacity: Integer; AOwnsItems: Boolean); overload;
    constructor Create(const AEqualityComparer: IJclEqualityComparer<T>; const ACollection: IJclCollection<T>; AOwnsItems: Boolean); overload;
    { IJclEqualityComparer<T> }
    function ItemsEqual(const A, B: T): Boolean; override;
    property EqualityComparer: IJclEqualityComparer<T> read FEqualityComparer write FEqualityComparer;
  end;

  // F = Function to compare items for equality
  TJclArrayListF<T> = class(TJclArrayList<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclPackable, IJclGrowable, IJclBaseContainer, IJclItemOwner<T>, IJclEqualityComparer<T>,
    IJclCollection<T>, IJclList<T>, IJclArray<T>)
  protected
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
  public
    constructor Create(const AEqualityCompare: TEqualityCompare<T>; ACapacity: Integer; AOwnsItems: Boolean); overload;
    constructor Create(const AEqualityCompare: TEqualityCompare<T>; const ACollection: IJclCollection<T>; AOwnsItems: Boolean); overload;
  end;

  // I = Items can compare themselves to others
  TJclArrayListI<T: IEquatable<T>> = class(TJclArrayList<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclPackable, IJclGrowable, IJclBaseContainer, IJclItemOwner<T>, IJclEqualityComparer<T>,
    IJclCollection<T>, IJclList<T>, IJclArray<T>)
  protected
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
  public
    { IJclEqualityComparer<T> }
    function ItemsEqual(const A, B: T): Boolean; override;
  end;

  //DOM-IGNORE-END
  {$ENDIF SUPPORTS_GENERICS}

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.3-Build4197/jcl/source/prototypes/JclArrayLists.pas $';
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
{$JPPEXPANDMACRO JCLARRAYLISTIMP(,,,,,,,,,,,,,)}

{$JPPEXPANDMACRO JCLARRAYLISTITRIMP(,,,,,,,)}

*)
{$IFDEF SUPPORTS_GENERICS}
//DOM-IGNORE-BEGIN

{$JPPEXPANDMACRO JCLARRAYLISTIMP(TJclArrayList<T>,; AOwnsItems: Boolean,AOwnsItems,IJclCollection<T>,IJclIterator<T>,TArrayIterator,IJclList<T>,const ,AItem,GetItem,SetItem,FreeItem,T,Default(T))}

{$JPPEXPANDMACRO JCLARRAYLISTITRIMP(TJclArrayIterator<T>,IJclIterator<T>,IJclList<T>,const ,AItem,T,GetItem,SetItem)}

procedure TJclArrayList<T>.MoveArray(var List: TDynArray; FromIndex, ToIndex, Count: Integer);
var
  I: Integer;
begin
  if FromIndex < ToIndex then
  begin
    for I := Count - 1 downto 0 do
      List[ToIndex + I] := List[FromIndex + I];

    if (ToIndex - FromIndex) < Count then
      // overlapped source and target
      for I := 0 to ToIndex - FromIndex - 1 do
        List[FromIndex + I] := Default(T)
    else
      // independant
      for I := 0 to Count - 1 do
        List[FromIndex + I] := Default(T);
  end
  else
  begin
    for I := 0 to Count - 1 do
      List[ToIndex + I] := List[FromIndex + I];

    if (FromIndex - ToIndex) < Count then
      // overlapped source and target
      for I := Count - FromIndex + ToIndex to Count - 1 do
        List[FromIndex + I] := Default(T)
    else
      // independant
      for I := 0 to Count - 1 do
        List[FromIndex + I] := Default(T);
  end; 
end;

//=== { TJclArrayListE<T> } ==================================================

constructor TJclArrayListE<T>.Create(const AEqualityComparer: IJclEqualityComparer<T>; ACapacity: Integer;
  AOwnsItems: Boolean);
begin
  inherited Create(ACapacity, AOwnsItems);
  FEqualityComparer := AEqualityComparer;
end;

constructor TJclArrayListE<T>.Create(const AEqualityComparer: IJclEqualityComparer<T>;
  const ACollection: IJclCollection<T>; AOwnsItems: Boolean);
begin
  inherited Create(ACollection, AOwnsItems);
  FEqualityComparer := AEqualityComparer;
end;

procedure TJclArrayListE<T>.AssignPropertiesTo(Dest: TJclAbstractContainerBase);
begin
  inherited AssignPropertiesTo(Dest);
  if Dest is TJclArrayListE<T> then
    TJclArrayListE<T>(Dest).FEqualityComparer := FEqualityComparer;
end;

function TJclArrayListE<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclArrayListE<T>.Create(EqualityComparer, FSize, False);
  AssignPropertiesTo(Result);
end;

function TJclArrayListE<T>.ItemsEqual(const A, B: T): Boolean;
begin
  if EqualityComparer <> nil then
    Result := EqualityComparer.ItemsEqual(A, B)
  else
    Result := inherited ItemsEqual(A, B);
end;

//=== { TJclArrayListF<T> } ==================================================

constructor TJclArrayListF<T>.Create(const AEqualityCompare: TEqualityCompare<T>;
  ACapacity: Integer; AOwnsItems: Boolean);
begin
  inherited Create(ACapacity, AOwnsItems);
  SetEqualityCompare(AEqualityCompare);
end;

constructor TJclArrayListF<T>.Create(const AEqualityCompare: TEqualityCompare<T>; const ACollection: IJclCollection<T>;
  AOwnsItems: Boolean);
begin
  inherited Create(ACollection, AOwnsItems);
  SetEqualityCompare(AEqualityCompare);
end;

function TJclArrayListF<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclArrayListF<T>.Create(EqualityCompare, FSize, False);
  AssignPropertiesTo(Result);
end;

//=== { TJclArrayListI<T> } ==================================================

function TJclArrayListI<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclArrayListI<T>.Create(FSize, False);
  AssignPropertiesTo(Result);
end;

function TJclArrayListI<T>.ItemsEqual(const A, B: T): Boolean;
begin
  if Assigned(FEqualityCompare) then
    Result := FEqualityCompare(A, B)
  else
  if Assigned(FCompare) then
    Result := FCompare(A, B) = 0
  else
    Result := A.Equals(B);
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

