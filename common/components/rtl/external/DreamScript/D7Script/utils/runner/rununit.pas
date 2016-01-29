{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit rununit;

interface
{$I dc.inc}
uses
  windows,
  dcapp,
  dccdes,
  dcconfig,
  classes,
  impreg,
  sysutils,
  forms,
  dcscript,
  dcpascal,
  dialogs,
  dcdreamlib,
{$IFDEF D3}
  dcpload,
{$ENDIF}

  {$IFDEF PRODELPHI}
  {$IFDEF DREAMMEMO}
  {$IFDEF DREAMIDE}
  {$IFDEF DREAMDESIGNER}
  dctoolin,
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

  dcsystem;


procedure Run;

implementation
uses
  runform;

var
  ProjectFile : string;
const
  HelpStr = 'Usage: DCRunner <ProjectFile|ScriptFile> [PackagesList]'#13#10'Examples:'#13#10'DCRunner MastApp.ipr dcctrl.dpl;dcdbctrl.dpl'#13#10'DCRunner Hello.vbs';

{$IFDEF D3}
var
  PLoader  : TDCPackageLoader;
{$ENDIF}

function ParseParams : boolean;
{$IFDEF D3}
var
  Packages : TStringList;
  i        : integer;
{$ENDIF}

begin
  result := true;
  if ParamCount = 0 then
    begin
      Application.CreateForm(TFrmRun,FrmRun);
      with  FrmRun do
      try
        if CompiledWithPackages then
          PackBut.Enabled := true;
          if ShowModal= idOk then
            ProjectFile := DCFileNameEdit1.FileName
          else
            begin
              result := false;
              exit;
            end;
      finally
        Free;
      end;
    end
    else
    begin
      ProjectFile := ParamStr(1);
     {$IFDEF D3}
     if CompiledWithPackages then
       if ParamCount > 1 then
         begin
           Packages := TStringList.Create;
           try
             ParseString(ParamStr(2), ';', Packages);
             for i := 0 to Packages.Count - 1 do
               PLoader.RegisterPackage(Packages[i], true);
           finally
             Packages.Free;
          end;
         end;
     {$ENDIF}
   end;
end;

var
  ErrorEvent : THandle;
  ErrorFile  : THandle;

procedure Run;
var
  title : string;
  p     : integer;
  rhandle : THandle;
  project : TIDEProject;

begin
  RegistryKey := GetDreamRegKey('Runner');
  ErrorEvent := OpenEvent(EVENT_ALL_ACCESS, false, pchar(SCRIPTERROREVENTNAME));
  ErrorFile  := OpenFileMapping(FILE_MAP_ALL_ACCESS, false, SCRIPTERRORFILENAME);

  Application.Initialize;
  
{$IFDEF D3}
  if CompiledWithPackages then
    ploader := TDCPackageLoader.Create(Application);
{$ENDIF}

  if not ParseParams then
    exit;
    
  title := ExtractFileName(ProjectFile);
  p := pos('.', title);
  if p > 0 then
    delete(title, p, length(title) - p + 1);

  Application.Title := title;

  project := nil;
  try
    if FileCanBeExecuted(ProjectFile) then
      rhandle := dcscript.RunUnit(ProjectFile)
    else
      begin
        project := TIDEProject.CreateFrom(ProjectFile, '');
        with project do
          if ProjectItems.Count > 0 then
            begin
              rhandle := RunObjectList(ProjectItems);
              if rHandle <> 0 then
                with TDCScripter(rHandle) do
                  if GetModule = nil then
                    Free;
            end
          else
            rhandle := 0;
      end;

    repeat
      Application.HandleMessage;
    until not IsModuleRunning(rHandle);

  finally
    Project.Free;
    CloseHandle(ErrorEvent);
  end;
end;

{------------------------------------------------------------------}

type
  TMyMessageAnswer = class(TMessageAnswer)
  protected
    procedure CMSCRIPTERROR(Var Message: TWMScriptError); message CM_SCRIPTERROR;
  end;

{------------------------------------------------------------------}

procedure TMyMessageAnswer.CMSCRIPTERROR(var Message: TWMScriptError);
var
  numwrite : DWord;
begin
  with Message.ErrorInfo^ do
    begin
      WriteFile(ErrorFile, Message.ErrorInfo^, sizeof(TScriptErrorInfo), numwrite, nil);
      SetEvent(ErrorEvent);
    end;
end;

{-------------------------------------------------------------}

var
  MyMessageAnswer:TMyMessageAnswer;

initialization
  MyMessageAnswer := TMyMessageAnswer.Create;

finalization
  MyMessageAnswer.Free;

end.
