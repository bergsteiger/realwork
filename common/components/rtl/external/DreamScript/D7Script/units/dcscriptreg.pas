{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcScriptReg;

interface

{.$I dc.inc}
{$I dcprod.inc}
uses
  Classes, SysUtils, TypInfo,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcSystem, dcScript, dcCommon
  ,dcGen,dcGenReg
  {$IFDEF DREAMDESIGNER}, dcScDes{$ENDIF};

type
  TScriptMethodProperty = class(TStringProperty)
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
    function GetScripter : TDCScripter; virtual;
  end;

  TDCScripterLanguageEdit = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TEventItemMethodProperty = class(TScriptMethodProperty)
    function GetScripter : TDCScripter; override;
  end;

{$IFDEF D4}
type
  TScriptActionMethodProperty = class(TScriptMethodProperty)
    function GetScripter : TDCScripter; override;
  end;
{$ENDIF}

  TEventItemEventProperty = class(TPropNameEditor)
  protected
    function Component : TPersistent; override;
    function GetFilter : TTypeKinds; override;
  end;

procedure Register;

implementation


function TDCScripterLanguageEdit.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes + [paValueList, paSortList];
end;

{-----------------------------------------------------------}

procedure TDCScripterLanguageEdit.GetValues(Proc: TGetStrProc);
var
  l : TList;
  i : integer;
begin
  l := TList.Create;
  with l do
    try
      dcsystem.GetRegisteredClasses(TScriptRunner, l);
      for i := 0 to Count - 1 do
        Proc(TObjectParamListItem(Items[i]).Params[SRunnerDescription]);
    finally
      Free;
    end;
end;

{-----------------------------------------------------------}

procedure TScriptMethodProperty.GetValues(Proc: TGetStrProc);
var
  scripter     : TDCScripter;
  cdesignclass : TCodeDesignerClass;
  s            : TStringList;
  cdesign      : TCodeDesigner;
begin
  scripter := GetScripter;
  if scripter = nil then
    exit;

  cdesignclass := scripter.GetCodeDesignerClass;
  if cdesignclass <> nil then
    begin
      s := TStringList.Create;
      cdesign := cdesignclass.Create(nil);
      with cdesign do
        try
          ModuleOwner := scripter.GetModule;
          Strings := scripter.Script;
          GetMethods(nil, s);
          StringsToProc(s, Proc);
        finally
          Free;
          s.Free;
        end;
    end;
end;

{------------------------------------------------------------------}

function TScriptMethodProperty.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes;
  include(result, paValueList);
end;

{-----------------------------------------------------------}

function TScriptMethodProperty.GetScripter : TDCScripter;
begin
  Result := nil;
end;

{-----------------------------------------------------------}

function TEventItemMethodProperty.GetScripter : TDCScripter;
begin
  result := TDCScripter(TEventItems(TEventItem(GetComponent(0)).Collection).Owner);
end;

{-----------------------------------------------------------}

{$IFDEF D4}
function TScriptActionMethodProperty.GetScripter : TDCScripter;
begin
  result := TDCScriptAction(GetComponent(0)).Scripter;
end;
{$ENDIF}

{-----------------------------------------------------------}

function TEventItemEventProperty.Component : TPersistent;
begin
  result := TEventItem(GetComponent(0)).Component;
end;

{------------------------------------------------------------------}

function TEventItemEventProperty.GetFilter : TTypeKinds;
begin
  result := tkMethods;
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDream,[TDCScripter]);
{$IFDEF WIN}
  {$IFDEF DREAMDESIGNER}
  RegisterPropertyEditor(TypeInfo(string), TCustomScriptDesigner, 'Language', TDCScripterLanguageEdit);
  {$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TDCScripter, 'Language', TDCScripterLanguageEdit);
  RegisterPropertyEditor(TypeInfo(TComponent), TDCScripter, 'Module', TExtCompEditor);
  RegisterPropertyEditor(TypeInfo(TFileName), TDCScripter, 'ScriptFile', TFileNameEdit);
  RegisterPropertyEditor(TypeInfo(string), TEventItem, 'Event', TEventItemEventProperty);
  RegisterPropertyEditor(TypeInfo(string), TEventItem, 'ScriptMethod', TEventItemMethodProperty);
  {$IFDEF D4}
  SafeRegisterActions(SDreamActions, [TDCScriptAction], TDCScriptAction);
  RegisterPropertyEditor(TypeInfo(string), TDCScriptAction, 'ExecuteMethod', TScriptActionMethodProperty);
  RegisterPropertyEditor(TypeInfo(string), TDCScriptAction, 'UpdateMethod', TScriptActionMethodProperty);
  {$ENDIF}
{$ENDIF}
end;

end.
