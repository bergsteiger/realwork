{ **************************************************************************** }
{                                                                              }
{    PppState - Pascal PreProcessor State                                      }
{    Copyright (c) 2001 Barry Kelly.                                           }
{    barry_j_kelly@hotmail.com                                                 }
{                                                                              }
{    The contents of this file are subject to the Mozilla Public License       }
{    Version 1.1 (the "License"); you may not use this file except in          }
{    compliance with the License. You may obtain a copy of the License at      }
{    http://www.mozilla.org/MPL/                                               }
{                                                                              }
{    Software distributed under the License is distributed on an "AS IS"       }
{    basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the   }
{    License for the specific language governing rights and limitations        }
{    under the License.                                                        }
{                                                                              }
{    The Original Code is PppState.pas                                         }
{                                                                              }
{    The Initial Developer of the Original Code is Barry Kelly.                }
{    Portions created by Barry Kelly are Copyright (C) 2001                    }
{    Barry Kelly. All Rights Reserved.                                         }
{                                                                              }
{    Contributors:                                                             }
{      Florent Ouchet                                                          }
{                                                                              }
{    Alternatively, the contents of this file may be used under the terms      }
{    of the Lesser GNU Public License (the  "LGPL License"), in which case     }
{    the provisions of LGPL License are applicable instead of those            }
{    above.  If you wish to allow use of your version of this file only        }
{    under the terms of the LPGL License and not to allow others to use        }
{    your version of this file under the MPL, indicate your decision by        }
{    deleting  the provisions above and replace  them with the notice and      }
{    other provisions required by the LGPL License.  If you do not delete      }
{    the provisions above, a recipient may use your version of this file       }
{    under either the MPL or the LPGL License.                                 }
{                                                                              }
{ **************************************************************************** }
{ $Id: JppState.pas,v 1.1 2010/12/01 12:58:10 lulin Exp $ }

{ Brief: The state of the preprocessor; options (e.g. remove comments),
    defines, include search path, etc. }

// Modifications by Robert Rossmair:  Addition of TTriState type, TriState methods
unit JppState;

{$I jcl.inc}

interface

uses
  SysUtils, Classes,
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JclBase, JclContainerIntf;

type
  EPppState = class(Exception);

  TPppOption = (poProcessIncludes, poProcessDefines, poStripComments,
    poProcessMacros, poProcessValues);
  TPppOptions = set of TPppOption;

  TTriState = (ttUnknown, ttUndef, ttDefined);

  TPppProvider = class(TPersistent)
  protected
    function GetBoolValue(const Name: string): Boolean; virtual; abstract;
    function GetDefine(const ASymbol: string): TTriState; virtual; abstract;
    function GetIntegerValue(const Name: string): Integer; virtual; abstract;
    function GetStringValue(const Name: string): string; virtual; abstract;
    procedure SetBoolValue(const Name: string; Value: Boolean); virtual; abstract;
    procedure SetDefine(const ASymbol: string; const Value: TTriState); virtual; abstract;
    procedure SetIntegerValue(const Name: string; Value: Integer); virtual; abstract;
    procedure SetStringValue(const Name, Value: string); virtual; abstract;
  public
    property Defines[const ASymbol: string]: TTriState read GetDefine write SetDefine;
    property BoolValues[const Name: string]: Boolean read GetBoolValue write SetBoolValue;
    property StringValues[const Name: string]: string read GetStringValue write SetStringValue;
    property IntegerValues[const Name: string]: Integer read GetIntegerValue write SetIntegerValue;
  end;

  TPppState = class(TPppProvider)
  private
    FStateStack: IJclStack;
    FOptions: TPppOptions;
    procedure InternalPushState(const ExcludedFiles, SearchPath: IJclStrList;
      const Macros: IJclStrIntfMap; const Defines: IJclStrMap; ATriState: TTriState);
    function InternalPeekDefines: IJclStrMap;
    function InternalPeekExcludedFiles: IJclStrList;
    function InternalPeekMacros: IJclStrIntfMap;
    function InternalPeekSearchPath: IJclStrList;
    function InternalPeekTriState: TTriState;
    procedure InternalSetTriState(Value: TTriState);
  protected
    function GetOptions: TPppOptions;
    procedure SetOptions(AOptions: TPppOptions);

    function FindMacro(const AMacroName: string): IJclStrList;
    function AssociateParameters(const ParamNames: IJclStrList;
      const ParamValues: TDynStringArray): TDynWideStringArray;

    function GetBoolValue(const Name: string): Boolean; override;
    function GetDefine(const ASymbol: string): TTriState; override;
    function GetIntegerValue(const Name: string): Integer; override;
    function GetStringValue(const Name: string): string; override;
    procedure SetBoolValue(const Name: string; Value: Boolean); override;
    procedure SetDefine(const ASymbol: string; const Value: TTriState); override;
    procedure SetIntegerValue(const Name: string; Value: Integer); override;
    procedure SetStringValue(const Name, Value: string); override;
  public
    constructor Create;
    destructor Destroy; override;

    { PushState is called at the start of every unit, and PopState at the
      end. This means that any declarations like $DEFINE will be file-local
      in scope. }
    procedure PushState;
    procedure PopState;

    property TriState: TTriState read InternalPeekTriState write InternalSetTriState;

    procedure Define(const ASymbol: string);
    procedure Undef(const ASymbol: string);

    function FindFile(const AName: string): TStream;
    procedure AddToSearchPath(const AName: string);

    procedure AddFileToExclusionList(const AName: string);
    function IsFileExcluded(const AName: string): Boolean;

    function ExpandMacro(const AName: string; const ParamValues: TDynStringArray): string; virtual;
    procedure DefineMacro(const AName: string; const ParamNames: TDynStringArray;
      const Value: string);
    procedure UndefMacro(const AName: string; const ParamNames: TDynStringArray);

    property Options: TPppOptions read GetOptions write SetOptions;
  end;

  TPppStateClass = class of TPppState;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.2-Build3886/jcl/devtools/jpp/JppState.pas $';
    Revision: '$Revision: 1.1 $';
    Date: '$Date: 2010/12/01 12:58:10 $';
    LogPath: 'JCL\devtools\jpp';
    Extra: '';
    Data: nil
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  TypInfo,
  JclStrings, JclArrayLists, JclHashMaps, JclStacks;

type
  TSimplePppStateItem = class
  public
    DefinedKeywords: IJclStrMap;
    ExcludedFiles: IJclStrList;
    Macros: IJclStrIntfMap;
    SearchPath: IJclStrList;
    TriState: TTriState;
    ParentTriState: TTriState;
  end;

//=== { TPppState } ==========================================================

constructor TPppState.Create;
begin
  FStateStack := TJclStack.Create(16, True);
  InternalPushState(TJclStrArrayList.Create(16), TJclStrArrayList.Create(16),
    TJclStrIntfHashMap.Create(16), TJclStrHashMap.Create(16, False), ttUnknown);
end;

destructor TPppState.Destroy;
begin
  FStateStack := nil;
  inherited Destroy;
end;

procedure TPppState.AddFileToExclusionList(const AName: string);
begin
  InternalPeekExcludedFiles.Add(AName);
end;

procedure TPppState.AddToSearchPath(const AName: string);
begin
  InternalPeekSearchPath.Add(AName);
end;

function TPppState.AssociateParameters(const ParamNames: IJclStrList;
  const ParamValues: TDynStringArray): TDynWideStringArray;
var
  StrParams: TStrings;
  AssociationByName: Boolean;
  Index, ParamIndex: Integer;
  AParamName, AParamText: string;
begin
  SetLength(Result, Length(ParamValues));
  AssociationByName := True;
  StrParams := TStringList.Create;
  try
    for Index := Low(ParamValues) to High(ParamValues) do
    begin
      StrParams.Add(ParamValues[Index]);
      AParamName := StrParams.Names[Index];
      if AParamName <> '' then
      begin
        // verify parameter names
        ParamIndex := ParamNames.IndexOf(AParamName);
        if ParamIndex < 0 then
          AssociationByName := False;
      end
      else
        AssociationByName := False;
    end;
    for Index := Low(ParamValues) to High(ParamValues) do
    begin
      if AssociationByName then
        AParamText := StrParams.Values[ParamNames.Strings[Index]]
      else
        AParamText := StrParams.Strings[Index];
      Result[Index] := WideString(AParamText);
    end;
  finally
    StrParams.Free;
  end;
end;

function TPppState.ExpandMacro(const AName: string;
  const ParamValues: TDynStringArray): string;
var
  AMacro: IJclStrList;
  AMacroName, AMacroText: string;
  Index: Integer;
  Params: array of TVarRec;
  AMacroParams: TDynWideStringArray;
begin
  AMacroName := Format('%s`%d', [AName, Length(ParamValues)]);
  AMacro := FindMacro(AMacroName);
  // the macro text is the last item, previous items are the macro parameter names
  AMacroText := AMacro.Strings[AMacro.Size - 1];
  AMacroParams := AssociateParameters(AMacro.SubList(0, AMacro.Size - 1), ParamValues);

  SetLength(Params, Length(ParamValues));
  for Index := Low(ParamValues) to High(ParamValues) do
  begin
    Params[Index].VType := vtPWideChar;
    Params[Index].VPWideChar := PWideChar(AMacroParams[Index]);
  end;
  Result := Format(AMacroText, Params);
end;

procedure TPppState.Define(const ASymbol: string);
begin
  Defines[ASymbol] := ttDefined;
end;

procedure TPppState.DefineMacro(const AName: string;
  const ParamNames: TDynStringArray; const Value: string);
var
  AMacro: IJclStrList;
  AMacros: IJclStrIntfMap;
  AMacroNames: IJclStrIterator;
  AMacroName, AMacroFormat: string;
  Index: Integer;
begin
  AMacros := InternalPeekMacros;
  AMacroName := Format('%s`%d', [AName, Length(ParamNames)]);
  AMacroNames := AMacros.KeySet.First;
  while AMacroNames.HasNext do
    if JclStrings.StrSame(AMacroNames.Next, AMacroName) then
      raise EPppState.CreateFmt('macro "%s" is already defined', [AName]);
  AMacroFormat := Value;
  AMacro := TJclStrArrayList.Create(16);
  for Index := Low(ParamNames) to High(ParamNames) do
  begin
    StrReplace(AMacroFormat, ParamNames[Index], '%' + IntToStr(Index) + ':s', [rfReplaceAll, rfIgnoreCase]);
    // the first elements in the list are the macro parameter names
    AMacro.Add(ParamNames[Index]);
  end;
  // the macro text is the last element in the list
  AMacro.Add(AMacroFormat);
  AMacros.Items[AMacroName] := AMacro;
end;

function TPppState.FindFile(const AName: string): TStream;
var
  i: Integer;
  fn: string;
  Found: Boolean;
  ASearchPath: IJclStrList;
begin
  ASearchPath := InternalPeekSearchPath;
  fn := AName;
  Found := FileExists(fn);
  if not Found then
    for i := 0 to ASearchPath.Size - 1 do
    begin
      fn := ASearchPath.Strings[i] + PathDelim + AName;
      if FileExists(fn) then
      begin
        Found := True;
        Break;
      end;
    end;
  if not Found then
    raise EPppState.CreateFmt('File not found: %s', [AName]);
  Result := TFileStream.Create(fn, fmOpenRead or fmShareDenyWrite);
end;

function TPppState.FindMacro(const AMacroName: string): IJclStrList;
var
  AMacros: IJclStrIntfMap;
  AMacroNames: IJclStrIterator;
begin
  AMacros := InternalPeekMacros;
  AMacroNames := AMacros.KeySet.First;
  while AMacroNames.HasNext do
  begin
    if JclStrings.StrSame(AMacroNames.Next, AMacroName) then
    begin
      Result := AMacros.Items[AMacroNames.GetString] as IJclStrList;
      Exit;
    end;
  end;
  raise EPppState.CreateFmt('unknown macro "%s"', [AMacroName]);
end;

function TPppState.GetBoolValue(const Name: string): Boolean;
var
  VariantValue: Variant;
begin
  VariantValue := GetPropValue(Self, Name);
  Result := Boolean(VariantValue);
end;

function TPppState.GetIntegerValue(const Name: string): Integer;
var
  VariantValue: Variant;
begin
  VariantValue := GetPropValue(Self, Name);
  Result := Integer(VariantValue);
end;

function TPppState.GetStringValue(const Name: string): string;
var
  VariantValue: Variant;
begin
  VariantValue := GetPropValue(Self, Name, True);
  Result := string(VariantValue);
end;

function TPppState.GetOptions: TPppOptions;
begin
  Result := FOptions;
end;

function TPppState.GetDefine(const ASymbol: string): TTriState;
var
  ADefines: IJclStrMap;
  ASymbolNames: IJclStrIterator;
  PI: PPropInfo;
  PV: Variant;
begin
  Result := ttUnknown;
  ADefines := InternalPeekDefines;
  ASymbolNames := ADefines.KeySet.First;
  while ASymbolNames.HasNext do
  begin
    if JclStrings.StrSame(ASymbolNames.Next, ASymbol) then
    begin
      Result := TTriState(ADefines.Items[ASymbolNames.GetString]);
      Break;
    end;
  end;
  if Result = ttUnknown then
  begin
    PI := GetPropInfo(Self, ASymbol);
    if Assigned(PI) then
    begin
      {$IFDEF COMPILER8_UP}
      PV := GetPropValue(Self, PI);
      {$ELSE ~COMPILER8_UP}
      PV := GetPropValue(Self, PI^.Name);
      {$ENDIF ~COMPILER8_UP}
      if Boolean(PV) then
        Result := ttDefined
      else
        Result := ttUndef;
    end;
  end;
end;

function TPppState.InternalPeekDefines: IJclStrMap;
begin
  if FStateStack.Empty then
    raise EPppState.Create('Internal error: PPP State stack is empty');
  Result := (FStateStack.Peek as TSimplePppStateItem).DefinedKeywords;
end;

function TPppState.InternalPeekExcludedFiles: IJclStrList;
begin
  if FStateStack.Empty then
    raise EPppState.Create('Internal error: PPP State stack is empty');
  Result := (FStateStack.Peek as TSimplePppStateItem).ExcludedFiles;
end;

function TPppState.InternalPeekMacros: IJclStrIntfMap;
begin
  if FStateStack.Empty then
    raise EPppState.Create('Internal error: PPP State stack is empty');
  Result := (FStateStack.Peek as TSimplePppStateItem).Macros;
end;

function TPppState.InternalPeekSearchPath: IJclStrList;
begin
  if FStateStack.Empty then
    raise EPppState.Create('Internal error: PPP State stack is empty');
  Result := (FStateStack.Peek as TSimplePppStateItem).SearchPath;
end;

function TPppState.InternalPeekTriState: TTriState;
begin
  if FStateStack.Empty then
    raise EPppState.Create('Internal error: PPP State stack is empty');
  Result := (FStateStack.Peek as TSimplePppStateItem).TriState;
end;

procedure TPppState.InternalPushState(const ExcludedFiles, SearchPath: IJclStrList;
  const Macros: IJclStrIntfMap; const Defines: IJclStrMap; ATriState: TTriState);
var
  AStateItem: TSimplePppStateItem;
begin
  AStateItem := TSimplePppStateItem.Create;
  AStateItem.ExcludedFiles := ExcludedFiles;
  AStateItem.DefinedKeywords := Defines;
  AStateItem.Macros := Macros;
  AStateItem.SearchPath := SearchPath;
  AStateItem.TriState := ATriState;
  if FStateStack.Empty then
    AStateItem.ParentTriState := ttUnknown
  else
    AStateItem.ParentTriState := InternalPeekTriState;
  FStateStack.Push(AStateItem);
end;

procedure TPppState.InternalSetTriState(Value: TTriState);
var
  ASimplePppStateItem: TSimplePppStateItem;
begin
  if FStateStack.Empty then
    raise EPppState.Create('Internal error: PPP State stack is empty');
  ASimplePppStateItem := FStateStack.Peek as TSimplePppStateItem;
  if (ASimplePppStateItem.ParentTriState <> ttUndef) or (Value = ttUndef) then
    ASimplePppStateItem.TriState := Value;
end;

function TPppState.IsFileExcluded(const AName: string): Boolean;
var
  AExcludedFiles: IJclStrList;
  AFileNames: IJclStrIterator;
begin
  AExcludedFiles := InternalPeekExcludedFiles;
  AFileNames := AExcludedFiles.First;
  Result := False;
  while AFileNames.HasNext do
  begin
    if JclStrings.StrSame(AFileNames.Next, AName) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TPppState.PopState;
begin
  if FStateStack.Size <= 1 then
    raise EPppState.Create('Internal error: PPP State stack underflow');
  FStateStack.Pop.Free;
end;

procedure TPppState.PushState;
var
  AExcludedFiles, ASearchPath: IJclStrList;
  ADefines: IJclStrMap;
  AMacros: IJclStrIntfMap;
  ATriState: TTriState;
begin
  ADefines := (InternalPeekDefines as IJclIntfCloneable).IntfClone as IJclStrMap;
  AExcludedFiles := (InternalPeekExcludedFiles as IJclIntfCloneable).IntfClone as IJclStrList;
  ASearchPath := (InternalPeekSearchPath as IJclIntfCloneable).IntfClone as IJclStrList;
  AMacros := (InternalPeekMacros as IJclIntfCloneable).IntfClone as IJclStrIntfMap;
  ATriState := InternalPeekTriState;

  InternalPushState(AExcludedFiles, ASearchPath, AMacros, ADefines, ATriState);
end;

procedure TPppState.SetOptions(AOptions: TPppOptions);
begin
  FOptions := AOptions;
end;

procedure TPppState.SetBoolValue(const Name: string; Value: Boolean);
var
  VariantValue: Variant;
begin
  VariantValue := Value;
  SetPropValue(Self, Name, VariantValue);
end;

procedure TPppState.SetDefine(const ASymbol: string;
  const Value: TTriState);
var
  ADefines: IJclStrMap;
  ASymbolNames: IJclStrIterator;
  PI: PPropInfo;
begin
  ADefines := InternalPeekDefines;
  ASymbolNames := ADefines.KeySet.First;
  while ASymbolNames.HasNext do
  begin
    if JclStrings.StrSame(ASymbolNames.Next, ASymbol) then
    begin
      ADefines.Items[ASymbolNames.GetString] := TObject(Value);
      Exit;
    end;
  end;
  if Value <> ttUnknown then
  begin
    PI := GetPropInfo(Self, ASymbol);
    if Assigned(PI) then
    begin
      if Value = ttDefined then
        {$IFDEF COMPILER8_UP}
        SetPropValue(Self, PI, True)
        {$ELSE ~COMPILER8_UP}
        SetPropValue(Self, PI^.Name, True)
        {$ENDIF ~COMPILER8_UP}
      else
        {$IFDEF COMPILER8_UP}
        SetPropValue(Self, PI, False);
        {$ELSE ~COMPILER8_UP}
        SetPropValue(Self, PI^.Name, False);
        {$ENDIF ~COMPILER8_UP}
      Exit;
    end;
  end;
  ADefines.Items[ASymbol] := TObject(Value);
end;

procedure TPppState.SetIntegerValue(const Name: string; Value: Integer);
var
  VariantValue: Variant;
begin
  VariantValue := Value;
  SetPropValue(Self, Name, VariantValue);
end;

procedure TPppState.SetStringValue(const Name, Value: string);
var
  VariantValue: Variant;
begin
  VariantValue := Value;
  SetPropValue(Self, Name, VariantValue);
end;

procedure TPppState.Undef(const ASymbol: string);
begin
  Defines[ASymbol] := ttUndef;
end;

procedure TPppState.UndefMacro(const AName: string; const ParamNames: TDynStringArray);
var
  AMacros: IJclStrIntfMap;
  AMacroNames: IJclStrIterator;
  AMacroName: string;
begin
  AMacros := InternalPeekMacros;
  AMacroName := Format('%s`%d', [AName, Length(ParamNames)]);
  AMacroNames := AMacros.KeySet.First;
  while AMacroNames.HasNext do
    if JclStrings.StrSame(AMacroNames.Next, AMacroName) then
      AMacros.Remove(AMacroNames.GetString);
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
