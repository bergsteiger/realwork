{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit ExpertsUIIniOptions;

interface

uses
  IniFiles, WizardAPI,  Classes,  Variants;

type

  TWizardIniOptions = class;

  TOptionChangeEvent = procedure(AIniFile: TIniFile; const SectionName, OptionName: string;
    const Value: Variant) of object;

  TWizardIniOptions = class(TPersistent)
  private
    FIniFile: TIniFile;
    FSectionName: string;
    FOptions: TStringList;
    FOnOptionChange: TOptionChangeEvent;
    function GetOptionData(const Name: string): TObject;
    procedure SetOptionData(const Name: string; const Value: TObject);
    class procedure OptionChanged(AIniFile: TIniFile; const SectionName,
      OptionName: string; const Value: Variant);
  protected
    procedure SetOption(const Name: string; const Value: Variant);
    property SectionName: string read FSectionName;
    procedure AssignTo(Dest: TPersistent); override;
    procedure DoOptionChange(const OptionName: string; const Value: Variant);
  public
    constructor Create(const SectionName: string;
      AIniFile: TIniFile; OnChangeEvent: TOptionChangeEvent = nil);
    destructor Destroy; override;
    class procedure InitOptions(const AIniFileName: string;
      out AUIOptions: TWizardIniOptions); static;
    procedure EnsureOption(const OptionStr: string);
    function GetOptionValue(const Name: string): Variant;
    function GetOption(const Name: string; const Default: Variant): Variant;
    procedure InitializeOptions(const Values: array of string); overload;
    procedure InitializeOptions(const Values: TStrings); overload;
    function IsTrue(const Name: string): Boolean;
    property Options[const Name: string]: Variant read GetOptionValue write SetOption; default;
    property OptionData[const Name: string]: TObject read GetOptionData write SetOptionData;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property OnOptionChange: TOptionChangeEvent read FOnOptionChange write FOnOptionChange;
  end;

implementation

uses
    Graphics, Math, SysUtils, ToolsAPI,
  Forms,  Dialogs, Controls;

const
  fnOptionsFile = 'DSSampleWizard.ini';
  STrue = 'True';
  { Ini File Sections }
  SWizardUI = 'Wizard State';

class procedure TWizardIniOptions.InitOptions(const AIniFileName: string;
  out AUIOptions: TWizardIniOptions);
var
  LIniFile: TIniFile;

  procedure LoadOptions(const Section: string; Options: TWizardIniOptions);
  var
    IniValues: TStrings;
  begin
    IniValues := TStringList.Create;
    try
      LIniFile.ReadSectionValues(Section, IniValues);
      if IniValues.Count = 0 then Exit;
      Options.InitializeOptions(IniValues);
    finally
      IniValues.Free;
    end;
  end;

  function GetIniDirectory: string;
  var
    OTAServices: IOTAServices;
  begin
    if (BorlandIDEServices <> nil) and
        Supports(BorlandIDEServices, IOTAServices, OTAServices) then
      Result := OTAServices.GetApplicationDataDirectory
    else
      Result := ExtractFilePath(ParamStr(0));
    Result := IncludeTrailingPathDelimiter(Result);
  end;

begin
  LIniFile := TIniFile.Create(GetIniDirectory+AIniFileName);
  AUIOptions := TWizardIniOptions.Create(SWizardUI, LIniFile, OptionChanged);
  LoadOptions(SWizardUI, AUIOptions);
end;

class procedure TWizardIniOptions.OptionChanged(AIniFile: TIniFile; const SectionName,
  OptionName: string; const Value: Variant);
begin
  if OptionName <> '' then
    AIniFile.WriteString(SectionName, OptionName, Value)
  else
    AIniFile.EraseSection(SectionName);
end;



{ TWizardIniOptions }

constructor TWizardIniOptions.Create(const SectionName: string;
  AIniFile: TIniFile; OnChangeEvent: TOptionChangeEvent = nil);
begin
  //FWebWizardContext := TWebWizardContext.Create;
  FOptions := TStringList.Create;
  FIniFile := AIniFile;
  FSectionName := SectionName;
  if Assigned(OnChangeEvent) then
    FOnOptionChange := OnChangeEvent;
  inherited Create;
end;

destructor TWizardIniOptions.Destroy;
var
  I: Integer;
begin
 //FWebWizardContext.Free;
  { We are assumed to be the owner of any
    objects placed into the OptionData properties }
  for I := 0 to FOptions.Count - 1 do
    FOptions.Objects[I].Free;
  FOptions.Free;
  FIniFile.Free;
  inherited;
end;

procedure TWizardIniOptions.Assign(Source: TPersistent);
var
  I, ValPos: Integer;
  S: string;
  Strings: TStrings;
begin
  if Source is TStrings then
  begin
    Strings := TStrings(Source);
    for I := 0 to Strings.Count - 1 do
    begin
      S := Strings[I];
      ValPos := Pos('=', S);
      if ValPos > 0 then
        SetOption(Copy(S, 1, ValPos-1), Copy(S, ValPos+1, MAXINT));
    end;
  end
  else
    inherited;
end;

procedure TWizardIniOptions.AssignTo(Dest: TPersistent);
begin
  if Dest is TStrings then
  begin
    TStrings(Dest).Assign(FOptions)
  end
  else
    inherited;
end;

procedure TWizardIniOptions.DoOptionChange(const OptionName: string;
  const Value: Variant);
begin
  if Assigned(OnOptionChange) then
    OnOptionChange(FIniFile, SectionName, OptionName, Value);
end;

procedure TWizardIniOptions.EnsureOption(const OptionStr: string);
var
  ValPos: Integer;
  Name, Value: string;
begin
  ValPos := Pos('=', OptionStr);
  Name := Copy(OptionStr, 1, ValPos-1);
  Value := Copy(OptionStr, ValPos+1, MAXINT);
  { Force option to exist in the list }
  if FOptions.Values[Name] <> Value then
    SetOption(Name, Value);
end;

function TWizardIniOptions.GetOption(const Name: string; const Default: Variant): Variant;
begin
  Result := FOptions.Values[Name];
  if (Result = '') and (VarToStr(Default) <> '') then
    Result := Default;
end;

function TWizardIniOptions.GetOptionValue(const Name: string): Variant;
begin
  Result := GetOption(Name, '');
end;

procedure TWizardIniOptions.SetOption(const Name: string; const Value: Variant);
var
  Index: Integer;
  StrValue: string;
begin
  StrValue := VarToStr(Value);
  if FOptions.Values[Name] = StrValue then Exit;
  if StrValue = '' then
  begin
    Index := FOptions.IndexOfName(Name);
    FOptions[Index] := Name+'=';
  end
  else
    FOptions.Values[Name] := StrValue;
  DoOptionChange(Name, Value);
end;

function TWizardIniOptions.GetOptionData(const Name: string): TObject;
var
  Index: Integer;
begin
  Index := FOptions.IndexOfName(Name);
  if Index <> -1 then
    Result := FOptions.Objects[Index]
  else
    Result := nil;
end;

procedure TWizardIniOptions.SetOptionData(const Name: string;
  const Value: TObject);
var
  Index: Integer;
begin
  Index := FOptions.IndexOfName(Name);
  if Index <> -1 then
    FOptions.Objects[Index] := Value;
end;

procedure TWizardIniOptions.InitializeOptions(const Values: array of string);
var
  I: Integer;
begin
  for I := 0 to High(Values) do
    EnsureOption(Values[I]);
end;

procedure TWizardIniOptions.InitializeOptions(const Values: TStrings);
var
  I: Integer;
begin
  for I := 0 to Values.Count - 1 do
    EnsureOption(Values[I]);
end;

procedure TWizardIniOptions.Clear;
begin
  FOptions.Clear;
  DoOptionChange('', VarNull);
end;

function TWizardIniOptions.IsTrue(const Name: string): Boolean;
var
  Value: Variant;
begin
  Value := GetOption(Name, '');
  Result := Value;
end;

end.
