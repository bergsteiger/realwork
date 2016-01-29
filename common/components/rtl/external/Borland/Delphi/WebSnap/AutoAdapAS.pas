{****************************************************************}
{                                                                }
{       Borland Delphi Visual Component Library                  }
{                                                                }
{       Copyright (c) 2000, 2001 Borland Software Corporation    }
{                                                                }
{****************************************************************}

unit AutoAdapAS;

interface

implementation

uses ActiveX, WebSnapObjs, ObjComAuto;

// This unit allows Enumerators to be used in Javascript with the
// ActiveScripting engine. 

type
  TEnumDispatcherAS = class(TCustomEnumDispatcher)
  private
    FEnumerator: IEnumVariant;
  public
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult: Pointer; ExcepInfo: Pointer;
      ArgErr: Pointer): HRESULT; override; stdcall; 
    constructor Create(ScriptObj: TEnumeratorObj); override;
    destructor Destroy; override;
  end;
  
  TScriptEnumerator = class(TInterfacedObject, IEnumVariant, IDispatch)
  private
    FScriptObj: TEnumeratorObj;
    FScriptObjRef: IDispatch;
    FEOF: Boolean;
    FReset: Boolean;
    FOwnerData: Pointer;
    FIterating: Boolean;
  protected
    { IEnumVariant }
    function Clone(out ppenum: IEnumVARIANT): HResult; stdcall;
    function Next(celt: LongWord; var rgvar: OleVariant;
      out pceltFetched: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount: Integer; LocaleID: Integer; DispIDs: Pointer): HRESULT;
      stdcall;
    function GetTypeInfo(Index: Integer; LocaleID: Integer;
      out TypeInfo): HRESULT; stdcall;
    function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult: Pointer; ExcepInfo: Pointer;
      ArgErr: Pointer): HRESULT; stdcall;
  public
    constructor Create(ScriptObj: TEnumeratorObj);
    destructor Destroy; override;
  end;

{ TEnumDispatcherAS }

constructor TEnumDispatcherAS.Create(ScriptObj: TEnumeratorObj);
begin
  inherited;
end;

destructor TEnumDispatcherAS.Destroy;
begin
  inherited;
end;


function TEnumDispatcherAS.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HRESULT;
begin
  // Capture the one particular invoke that we want to create new enumerator objects.
  // Otherwise, pass it onto the script object.
  if DispID = -4 then // -4 = new enumerator object
  begin
    if VarResult <> nil then
    begin
      TVarData(POleVariant(VarResult)^).VType := 0; // this is hacky...and probably wrong! - corbin
      // without it, it fives "Invalid variant type" quite frequently. It is difficult to reproduce.
      // But, with this code, it may cause references to be lost. However
      if FEnumerator = nil then
        FEnumerator := TScriptEnumerator.Create(FScriptObj) as IEnumVariant;
      POleVariant(VarResult)^ := FEnumerator;
      Result := S_OK;
    end
    else
      Result := S_FALSE;
  end
  else
    Result := inherited Invoke(DispID, IID, LocaleID, Flags, Params,
      VarResult, ExcepInfo, ArgErr);
end;

{ TScriptEnumerator }

function TScriptEnumerator.Clone(out ppenum: IEnumVARIANT): HResult;
begin
  Result := E_NOTIMPL;
end;

constructor TScriptEnumerator.Create(ScriptObj: TEnumeratorObj);
begin
  inherited Create;
  FScriptObj := ScriptObj;
  FScriptObjRef := ScriptObj; 
  FReset := True;
end;

destructor TScriptEnumerator.Destroy;
begin
  FScriptObjRef := nil;
end;

function TScriptEnumerator.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT;
begin
  Result := FScriptObj.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDS)
end;

function TScriptEnumerator.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HRESULT;
begin
  Result := FScriptObj.GetTypeInfo(Index, LocaleID, TypeInfo)
end;

function TScriptEnumerator.GetTypeInfoCount(out Count: Integer): HRESULT;
begin
  Result := FScriptObj.GetTypeInfoCount(Count)
end;

function TScriptEnumerator.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HRESULT;
begin
  Result := FScriptObj.Invoke(DispID, IID, LocaleID, Flags, Params, VarResult,
    ExcepInfo, ArgErr)
end;

function TScriptEnumerator.Next(celt: LongWord; var rgvar: OleVariant;
  out pceltFetched: LongWord): HResult;
begin
  if FReset then
  begin
    FIterating := False;
    FReset := False;
    FOwnerData := nil;
    FIterating := True;
    FEOF := not FScriptObj.moveFirst;
  end
  else
    FEOF := not FScriptObj.moveNext;

  if not FEOF then
  begin
    if celt = 1 then
    begin
      rgVar := FScriptObj.item;
      if @pceltFetched <> nil then
        pceltFetched := celt;
    end
    else
    begin
      Result := E_NOTIMPL;
      Exit;
    end;
  end;
  if FEOF then
    Result := S_FALSE
  else
    Result := S_OK;
end;

function TScriptEnumerator.Reset: HResult;
begin
  FReset := True;
  Result := S_OK;
end;

function TScriptEnumerator.Skip(celt: LongWord): HResult;
var
  I: LongWord;
begin
  if FEOF then
    Result := S_FALSE
  else
  begin
    I := 0;
    while (not FEOF) and (I < celt) do
    begin
      FEOF := not FScriptObj.moveNext;
      Inc(I);
    end;
    if not FEOF then
      Result := S_OK
    else
      Result := S_FALSE
  end
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\AutoAdapAS.pas initialization enter'); {$EndIf}
  DispatcherClass := TEnumDispatcherAS;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\AutoAdapAS.pas initialization leave'); {$EndIf}
finalization
  DispatcherClass := nil;
end.
