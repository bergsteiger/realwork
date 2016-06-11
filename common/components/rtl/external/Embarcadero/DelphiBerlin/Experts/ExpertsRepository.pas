{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsRepository;

interface

uses ToolsAPI, SysUtils, Windows;

type

  TExpertsRepositoryWizard = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard,
    IOTAFormWizard, IOTARepositoryWizard60)
  private
    FComment: string;
    FName: string;
    FID: string;
    FPage: string;
    FAuthor: string;
  private
    { IOTAWizard }
    function GetName: string;
    function GetIDString: string;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetGlyph: Cardinal;
    function GetState: TWizardState;
    { IOTARepositoryWizard60 }
    function GetDesigner: string;
  protected
    function GetPage: string; virtual;
    { IOTAWizard }
    procedure Execute; virtual;
    function LoadIcon: Cardinal; virtual;
  public
    constructor Create(const AComment, AName, AID,
      APage, AAuthor: string);
  end;

  TExpertsRepositoryModuleWizard = class(TExpertsRepositoryWizard, IOTANotifier, IOTAWizard,
    IOTARepositoryWizard, IOTARepositoryWizard80, IOTAFormWizard, IOTARepositoryWizard160)
  private
    FPersonality: string;
    FPlatforms,
    FFrameworks: TArray<string>;
  private
    function GetIDString: string;
    { IOTARepositoryWizard80 }
    function GetDesigner: string;
    function GetGalleryCategory: IOTAGalleryCategory;
    function GetPersonality: string;
    { IOTARepositoryWizard160 }
    function GetFrameworkTypes: TArray<string>;
    function GetPlatforms: TArray<string>;
  public
    constructor Create(const APersonality, AComment, AName, AID,
      APage, AAuthor: string); overload;
    constructor Create(const APersonality, AComment, AName, AID,
      APage, AAuthor: string; const PlatformNames, FrameworkNames: TArray<string>); overload;
    property Personality: string read FPersonality;
  end;

  TExpertsRepositoryProjectWizard = class(TNotifierObject, IOTANotifier, IOTAWizard,
    IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard80, IOTARepositoryWizard160)
  private
    FPersonality: string;
    FComment: string;
    FName: string;
    FID: string;
    FPage: string;
    FAuthor: string;
    FPlatforms,
    FFrameworks: TArray<string>;
  private
    { IOTAWizard }
    function GetIDString: string;
    function GetName: string;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetGlyph: Cardinal;
    function GetState: TWizardState;
    { IOTARepositoryWizard80 }
    function GetGalleryCategory: IOTAGalleryCategory;
    function GetPersonality: string;
    function GetDesigner: string;
    { IOTARepositoryWizard160 }
    function GetFrameworkTypes: TArray<string>;
    function GetPlatforms: TArray<string>;
  protected
    function GetPage: string; virtual;
    { IOTAWizard }
    procedure Execute; virtual;
    function LoadIcon: Cardinal; virtual;
  public
    destructor Destroy; override;
    constructor Create(const APersonality, AComment, AName, AID,
      APage, AAuthor: string); overload;
    constructor Create(const APersonality, AComment, AName, AID,
      APage, AAuthor: string; const PlatformNames, FrameworkNames: TArray<string>); overload;
    property Personality: string read FPersonality;
  end;

  TExpertsRepositoryProjectWizardWithProc = class(TExpertsRepositoryProjectWizard)
  private
    FExecuteProc: TProc;
    FLoadIcon: TFunc<Cardinal>;
  protected
    procedure Execute; override;
    function LoadIcon: Cardinal; override;
  public
    constructor Create(const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
      ALoadIcon: TFunc<Cardinal>); overload;
    constructor Create(const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
      ALoadIcon: TFunc<Cardinal>; const PlatformNames, FrameworkNames: TArray<string>); overload;
  end;

  TExpertsRepositoryModuleWizardWithProc = class(TExpertsRepositoryModuleWizard)
  private
    FExecuteProc: TProc;
    FLoadIcon: TFunc<Cardinal>;
  protected
    procedure Execute; override;
    function LoadIcon: Cardinal; override;
  public
    constructor Create(const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
      ALoadIcon: TFunc<Cardinal>); overload;
    constructor Create(const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
      ALoadIcon: TFunc<Cardinal>; const PlatformNames, FrameworkNames: TArray<string>); overload;
  end;

  // Can be executed when no project is open
  TExpertsRepositoryFileWizard = class(TExpertsRepositoryModuleWizard,
    IOTAFormWizard100)
  private
    function IsVisible(Project: IOTAProject): Boolean;
  end;

  TExpertsRepositoryFileWizardWithProc = class(TExpertsRepositoryFileWizard)
  private
    FExecuteProc: TProc;
    FLoadIcon: TFunc<Cardinal>;
  protected
    procedure Execute; override;
    function LoadIcon: Cardinal; override;
  public
    constructor Create(const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
      ALoadIcon: TFunc<Cardinal>);

  end;


implementation

uses
  Classes, ExpertsResStrs;



{ TDSServerModuleWizard }



{ TExpertsRepositoryProjectWizard }

constructor TExpertsRepositoryProjectWizard.Create(const APersonality: string;
  const AComment, AName, AID, APage, AAuthor: string);
begin
  FPersonality := APersonality;
  FComment := AComment;
  FName := AName;
  FID := AID;
  FPage := APage;
  FAuthor := AAuthor;
  inherited Create;
end;

constructor TExpertsRepositoryProjectWizard.Create(const APersonality, AComment,
  AName, AID, APage, AAuthor: string; const PlatformNames,
  FrameworkNames: TArray<string>);
begin
  Create(APersonality, AComment, AName, AID, APage, AAuthor);
  FPlatforms := PlatformNames;
  FFrameworks := FrameworkNames;
end;

destructor TExpertsRepositoryProjectWizard.Destroy;
begin
  inherited Destroy;
end;

function TExpertsRepositoryProjectWizard.GetName: string;
begin
  Result := FName;
end;

function TExpertsRepositoryProjectWizard.GetAuthor: string;
begin
  Result := FAuthor;
end;

function TExpertsRepositoryProjectWizard.GetComment: string;
begin
  Result := FComment;
end;

function TExpertsRepositoryProjectWizard.GetPage: string;
begin
  Result := FPage;
end;

function TExpertsRepositoryProjectWizard.GetGlyph: Cardinal;
begin
  // Result := LoadIcon(HInstance, PWideChar(FIcon));
  Result := LoadIcon;
end;

function TExpertsRepositoryProjectWizard.GetState: TWizardState;
begin
  Result := [];
end;

function TExpertsRepositoryProjectWizard.LoadIcon: Cardinal;
begin
  Result := 0;
end;

function TExpertsRepositoryProjectWizard.GetIDString: string;
begin
  Result := FID + '.' + Personality  // do not localize
end;

procedure TExpertsRepositoryProjectWizard.Execute;
begin
  Assert(False);  // Must be implemented by descendent
end;

function TExpertsRepositoryProjectWizard.GetDesigner: string;
begin
  Result := dVCL;                      
end;

function TExpertsRepositoryProjectWizard.GetFrameworkTypes: TArray<string>;
begin
  Result := FFrameworks;
end;

function TExpertsRepositoryProjectWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := nil;
end;

function TExpertsRepositoryProjectWizard.GetPersonality: string;
begin
  Result := Personality;
end;

function TExpertsRepositoryProjectWizard.GetPlatforms: TArray<string>;
begin
  Result := FPlatforms;
end;

{ TExpertsRepositoryProjectWizardWithProc }

constructor TExpertsRepositoryProjectWizardWithProc.Create(
  const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
   ALoadIcon: TFunc<Cardinal>);
begin
  FExecuteProc := AExecuteProc;
  FLoadIcon := ALoadIcon;
  inherited Create(APersonality, AComment, AName, AID,
     APage, AAuthor);
end;

constructor TExpertsRepositoryProjectWizardWithProc.Create(const APersonality,
  AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
  ALoadIcon: TFunc<Cardinal>; const PlatformNames,
  FrameworkNames: TArray<string>);
begin
  FExecuteProc := AExecuteProc;
  FLoadIcon := ALoadIcon;
  inherited Create(APersonality, AComment, AName, AID,
     APage, AAuthor, PlatformNames, FrameworkNames);
end;

procedure TExpertsRepositoryProjectWizardWithProc.Execute;
begin
  if Assigned(FExecuteProc) then
    FExecuteProc
  else
    raise Exception.Create(rsNotImplemented);
end;

function TExpertsRepositoryProjectWizardWithProc.LoadIcon: Cardinal;
begin
  if Assigned(FLoadIcon) then
    Result := FLoadIcon
  else
    Result := 0;
end;

{ TExpertsRepositoryFileWizard }

constructor TExpertsRepositoryWizard.Create(
  const AComment, AName, AID, APage, AAuthor: string);
begin
  FComment := AComment;
  FName := AName;
  FID := AID;
  FPage := APage;
  FAuthor := AAuthor;
  inherited Create;
end;

function TExpertsRepositoryWizard.GetName: string;
begin
  Result := FName;
end;

function TExpertsRepositoryWizard.GetAuthor: string;
begin
  Result := FAuthor;
end;

function TExpertsRepositoryWizard.GetComment: string;
begin
  Result := FComment;
end;

function TExpertsRepositoryWizard.GetPage: string;
begin
  Result := FPage;
end;

function TExpertsRepositoryWizard.GetGlyph: Cardinal;
begin
  Result := LoadIcon;
end;

function TExpertsRepositoryWizard.GetIDString: string;
begin
  Result := FID;
end;

function TExpertsRepositoryWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

function TExpertsRepositoryWizard.LoadIcon: Cardinal;
begin
  Result := 0;
end;

procedure TExpertsRepositoryWizard.Execute;
begin
  Assert(False);  // Must be implemented by descendent
end;

function TExpertsRepositoryWizard.GetDesigner: string;
begin
  Result := dAny;
end;

{ TExpertsRepositoryFileWizard }

function TExpertsRepositoryFileWizard.IsVisible(Project: IOTAProject): Boolean;
begin
  Result := True;  // Always visible
end;

{ TExpertsRepositoryModuleWizard }

constructor TExpertsRepositoryModuleWizard.Create(const APersonality: string;
  const AComment, AName, AID, APage, AAuthor: string);
begin
  FPersonality := APersonality;
  inherited Create(AComment, AName, AID, APage, AAuthor);
end;

constructor TExpertsRepositoryModuleWizard.Create(const APersonality, AComment,
  AName, AID, APage, AAuthor: string; const PlatformNames,
  FrameworkNames: TArray<string>);
begin
  Create(APersonality, AComment, AName, AID, APage, AAuthor);
  FPlatforms := PlatformNames;
  FFrameworks := FrameworkNames;
end;

function TExpertsRepositoryModuleWizard.GetIDString: string;
begin
  Result := FID + '.' + Personality  // do not localize
end;

function TExpertsRepositoryModuleWizard.GetPersonality: string;
begin
  Result := Personality;
end;

function TExpertsRepositoryModuleWizard.GetPlatforms: TArray<string>;
begin
  Result := FPlatforms;
end;

function TExpertsRepositoryModuleWizard.GetDesigner: string;
begin
  Result := dVCL;
end;

function TExpertsRepositoryModuleWizard.GetFrameworkTypes: TArray<string>;
begin
  Result := FFrameworks;
end;

function TExpertsRepositoryModuleWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := nil;
end;

{ TExpertsRepositoryModuleWizardWithProc }

constructor TExpertsRepositoryModuleWizardWithProc.Create(
  const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
      ALoadIcon: TFunc<Cardinal>);
begin
  FExecuteProc := AExecuteProc;
  FLoadIcon := ALoadIcon;
  inherited Create(APersonality, AComment, AName, AID,
     APage, AAuthor);
end;

constructor TExpertsRepositoryModuleWizardWithProc.Create(const APersonality,
  AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
  ALoadIcon: TFunc<Cardinal>; const PlatformNames,
  FrameworkNames: TArray<string>);
begin
  FExecuteProc := AExecuteProc;
  FLoadIcon := ALoadIcon;
  inherited Create(APersonality, AComment, AName, AID,
     APage, AAuthor, PlatformNames, FrameworkNames);
end;

procedure TExpertsRepositoryModuleWizardWithProc.Execute;
begin
  if Assigned(FExecuteProc) then
    FExecuteProc
  else
    raise Exception.Create(rsNotImplemented);
end;

function TExpertsRepositoryModuleWizardWithProc.LoadIcon: Cardinal;
begin
  if Assigned(FLoadIcon) then
    Result := FLoadIcon
  else
    Result := 0;
end;

{ TExpertsRepositoryFileWizardWithProc }

constructor TExpertsRepositoryFileWizardWithProc.Create(
  const APersonality, AComment, AName, AID, APage, AAuthor: string; AExecuteProc: TProc;
      ALoadIcon: TFunc<Cardinal>);
begin
  FExecuteProc := AExecuteProc;
  FLoadIcon := ALoadIcon;
  inherited Create(APersonality, AComment, AName, AID,
     APage, AAuthor);
end;

procedure TExpertsRepositoryFileWizardWithProc.Execute;
begin
  if Assigned(FExecuteProc) then
    FExecuteProc
  else
    raise Exception.Create(rsNotImplemented);
end;

function TExpertsRepositoryFileWizardWithProc.LoadIcon: Cardinal;
begin
  if Assigned(FLoadIcon) then
    Result := FLoadIcon
  else
    Result := 0;
end;

end.
