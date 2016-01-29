{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcMemoReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes, Graphics, Forms, Consts,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcdreamlib, dccommon, dccommonreg, dcsystem,
  dcstring, dcmemo
  {$IFDEF D6} ,Variants {$ENDIF}
  ;

type
  TTemplateEditor = class(TStringProperty)
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc);override;
  end;

{--------------------------------------------------------------}

function  TTemplateEditor.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes + [paValueList];
end;

{--------------------------------------------------------------}

procedure TTemplateEditor.GetValues(Proc: TGetStrProc);
var
  List : TList;
  V    : variant;
  S    : string;
  i    : integer;
begin
  List := TList.Create;
  try
    GetRegisteredClasses(TMemoCodeTemplates, List);
    for i := 0 to List.Count - 1 do
      with TObjectParamListItem(List[i]) do
      begin
         V := Params[SCodeTemplateLang];
         if not (VarIsNull(V) or VarIsEmpty(V)) then
         begin
           S := V;
           if S <> '' then
             Proc(S);
         end;
      end
  finally
    List.Free;
  end;
end;

{-------------------------------------------------------------}

type
  TMemoFontProperty = class(TFontProperty)
  private
    function GetMemo : TCustomDCMemo;
    function UseMonoFont : boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TMemoFontNamesProperty = class(TFontNameProperty)
  private
    function GetMemo : TCustomDCMemo;
    function UseMonoFont : boolean;
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{---------TMemoFontProperty-----------------------------------}

function TMemoFontProperty.GetMemo : TCustomDCMemo;
var
  C : TPersistent;
begin
  C := GetComponent(0);
  if C is TCustomDCMemo then
    result := TCustomDCMemo(C)
  else
  if C is TTextStyle then
    result := TTextStyle(C).Memo
  else
    result := nil;
end;

{-------------------------------------------------------------}

function TMemoFontProperty.UseMonoFont : boolean;
var
  Memo : TCustomDCMemo;
begin
  Memo := GetMemo;
  if Memo <> nil then
    result := Memo.UseMonoFont
  else
    result := false;
end;

{-------------------------------------------------------------}

function TMemoFontProperty.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes;
  if UseMonoFont then
    Exclude(result,paDialog);
end;

{-------------------------------------------------------------}

procedure TMemoFontProperty.Edit;
begin
  if not UseMonoFont then
    inherited Edit;
end;

{-------TMemoFontNamesProperty--------------------------------}

function TMemoFontNamesProperty.GetMemo : TCustomDCMemo;
var
  C : TPersistent;
begin
  result := nil;
  C := GetComponent(0);
  if C is TMemoFont then
  begin
    C := TMemoFont(C).Owner;
    if C is TCustomDCMemo then
      result := TCustomDCMemo(C)
    else
    if C is TTextStyle then
      result := TTextStyle(C).Memo;
  end;
end;

{-------------------------------------------------------------}

function TMemoFontNamesProperty.UseMonoFont : boolean;
var
  Memo : TCustomDCMemo;
begin
  Memo := GetMemo;
  if Memo <> nil then
    result := Memo.UseMonoFont
  else
    result := false;
end;

{-------------------------------------------------------------}

procedure TMemoFontNamesProperty.GetValues(Proc: TGetStrProc);
var
  i : integer;
  f : TFont;
begin
  if UseMonoFont then
  begin
    f := TFont.Create;
    try
      with Screen.Fonts do
        for i := 0 to Count - 1 do
          begin
            f.Name := Strings[i];
            if IsFontMonoSpaced(f) then
              Proc(f.Name);
          end;
    finally
      f.Free;
    end;
  end
  else
    inherited GetValues(Proc);
end;

{-------------------------------------------------------------}

procedure TMemoFontNamesProperty.SetValue(const Value: string);
var
  f : TFont;
begin
  if UseMonoFont then
  begin
    f := TFont.Create;
    try
      F.Name:=Value;
      if IsFontMonoSpaced(f) then
        inherited SetValue(Value)
      else
        dcdreamLib.Error(SErrNonMonoSpacedFont);
    finally
      f.Free;
    end;
  end
  else
    inherited SetValue(Value);  
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDreamMemo,[TDCMemo]);
  RegisterPropertyEditor(TypeInfo(string), TMemoEnvOptions, 'KeyMapping', TKeymappingEdit);
  RegisterPropertyEditor(TypeInfo(string), TCustomDCMemo, 'TemplatesType', TTemplateEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomMemoSource, 'TemplatesType', TTemplateEditor);
end;

{-------------------------------------------------------------}

//BeginSkipConst
procedure _Register;
begin
  RegisterOptionExt(TMemoEnvOptions);
  RegisterPropertyEditor(TypeInfo(TMemoFont), nil, 'Font', TMemoFontProperty);
  RegisterPropertyEditor(TypeInfo(TFontName), TMemoFont, '', TMemoFontNamesProperty);
end;

//EndSkipConst
{-------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------}

initialization
  RunRegister;
end.
