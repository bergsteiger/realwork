{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ CAUTION!! This unit is for internal purposes only, can change in a future. }

unit System.Internal.DebugUtils;

interface

uses
  System.Generics.Collections;

                          
                                                  
                          

type
TDebugUtils = class
private const
{$IF defined(MACOS) or defined(LINUX)}
  EnvSeparator: string = ':';
{$ENDIF}
{$IFDEF MSWINDOWS}
  EnvSeparator: string = ';';
{$ENDIF MSWINDOWS}
private class var
  EnabledConditionMap: TDictionary<string, Boolean>;
  UnenabledConditionMap: TDictionary<string, Boolean>;
  DEBUG_CLASS: TArray<string>;
private
  class procedure ParseEnv(Env: string);
  class function SubMatch(Cond: string; Category: string): Boolean;
  class function Match(Cond: string): Boolean;
  class function CheckDebugClass(Cond: string): Boolean;
public
  class constructor Create;
  class destructor Destroy;
  //type
  //  DebugCode = class(TCustomAttribute)
  //  end;
  //[DebugCode]
  ///  
  ///  Conditionally outputs a formatted string to the debugging output.  The condition
  ///  is controlled by the environment variable <code>DEBUG_CLASS</code>.
  class procedure DebugPrint(Cond: string; Fmt: string; const Args: array of const); overload;
  //[DebugCode]
  class procedure DebugPrint(Cond: string; Fmt: string); overload;
end;

implementation

uses
  System.SysUtils, System.StrUtils;

class constructor TDebugUtils.Create;
begin
  EnabledConditionMap := TDictionary<string, Boolean>.Create;
  UnenabledConditionMap := TDictionary<string, Boolean>.Create;
  ParseEnv(GetEnvironmentVariable('DEBUG_CLASS'));
end;

class destructor TDebugUtils.Destroy;
begin
  EnabledConditionMap.Free;
  UnenabledConditionMap.Free;
end;

class procedure TDebugUtils.ParseEnv(Env: string);
begin
  SetLength(DEBUG_CLASS, 2);
  DEBUG_CLASS := TArray<string>(SplitString(Env, EnvSeparator));
//  DEBUG_CLASS := TArray<string>.Create;
end;

///
///  Compares a category to a condition.  If the strings are identical, we
///  return True.  If the strings are not, we look for wildcards in the category.
///  If we find one, we match the strings up to that point.  If they match,
///  we're done, and we return True.  Otherwise we return False.
///
///  Examples:
///  Cond = a.b.c Category = a.b.c.d -> False
///  Cond = a.b.c Category = a.b.c -> True
///  Cond = a.b.c Category = a.b.* -> True
///  Cond = a.b.c Category = a.* -> True
///  Cond = a.blueberry.c Category = a.blue* -> True
///  Cond = a.blueberry.c Category = a.blueberry -> False
class function TDebugUtils.SubMatch(Cond: string; Category: string): Boolean;
                                                        
var
  P: Integer;
  I: Integer;
begin
  Result := False;
  if Cond = Category then
    Exit(True);
  P := Pos('*', Category);
  // a.b.c vs x.y.nn*
  if P > 0 then
  begin
    if P > Length(Cond) - 1 then
      Exit(False);
    for I:= 1 to P - 1 do
      if Cond[I] <> Category[I] then
        Exit(False);
    Exit(True);
  end;
end;

class function TDebugUtils.Match(Cond: string): Boolean;
var
  S: string;
begin
  Result := False;
  for S in DEBUG_CLASS do
    if SubMatch(Cond, S) then
      Exit(True);
end;

                                            
class function TDebugUtils.CheckDebugClass(Cond: string): Boolean;
begin
  if (EnabledConditionMap.ContainsKey(Cond)) then
    Exit(True);
  if (UnenabledConditionMap.ContainsKey(Cond)) then
    Exit(False);
//  Exit(False);
  if Match(Cond) then
  begin
    Result := True;
    EnabledConditionMap.Add(Cond, True);
  end
  else
  begin
    Result := False;
    UnenabledConditionMap.Add(Cond, True);
  end;
end;

class procedure TDebugUtils.DebugPrint(Cond: string; Fmt: string; const Args: array of const);
begin
  if not TDebugUtils.CheckDebugClass(Cond) then Exit;
  Write(Cond + ': ');
  Writeln(Format(Fmt, Args));
end;

class procedure TDebugUtils.DebugPrint(Cond: string; Fmt: string);
begin
  if not TDebugUtils.CheckDebugClass(Cond) then Exit;
  Writeln(Cond + ': ' + Fmt);
end;

end.
