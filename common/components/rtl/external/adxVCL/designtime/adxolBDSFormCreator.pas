unit adxolBDSFormCreator;

{$I adxolDefs.inc}

interface


uses
 Windows,
 ToolsAPI;

{$IFDEF DELPHI_9_UP}
type
 TadxOlFormImplementationFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

 TadxXlFormImplementationFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

 TadxWdFormImplementationFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

 TadxPpFormImplementationFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

 TadxOlFormImplementationDfmFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

 TadxXlFormImplementationDfmFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

 TadxWdFormImplementationDfmFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

 TadxPpFormImplementationDfmFile = class(TInterfacedObject, IOTAFile)
   private
    fModuleName : String;
    fAncestorIdent: String;
    fAncestorClass: TClass;
    fFormIdent: String;
   public
    constructor Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
    { Return the actual source code }
    function GetSource: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    { Return the age of the file. -1 if new }
    function GetAge: TDateTime; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
   property ModuleName : String read fModuleName write fModuleName;
   property FormIdent : String read fFormIdent write fFormIdent;
   property AncestorIdent: String read fAncestorIdent write fAncestorIdent;
   property AncestorClass: TClass read fAncestorClass write fAncestorClass;

  end;

  TadxOlFormCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
   private
    fNewUnitIdent : String;
    fNewClassname : String;
    fNewFilename : String;
   public
    constructor Create;
    function GetCreatorType: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetExisting: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFileSystem: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetOwner: IOTAModule; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetUnnamed: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetAncestorName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetImplFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetIntfFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFormName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetMainForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowSource: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
{$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}

    procedure FormCreated(const FormEditor: IOTAFormEditor); {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    property NewUnitIdent : String read fNewUnitIdent write fNewUnitIdent;
    property NewClassName : String read fNewClassname write fNewClassname;
    property NewFilename : String read fNewFilename write fNewFilename;
  end;

  TadxXlFormCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
   private
    fNewUnitIdent : String;
    fNewClassname : String;
    fNewFilename : String;
   public
    constructor Create;
    function GetCreatorType: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetExisting: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFileSystem: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetOwner: IOTAModule; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetUnnamed: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetAncestorName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetImplFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetIntfFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFormName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetMainForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowSource: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
{$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}

    procedure FormCreated(const FormEditor: IOTAFormEditor); {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    property NewUnitIdent : String read fNewUnitIdent write fNewUnitIdent;
    property NewClassName : String read fNewClassname write fNewClassname;
    property NewFilename : String read fNewFilename write fNewFilename;
  end;

  TadxWdFormCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
   private
    fNewUnitIdent : String;
    fNewClassname : String;
    fNewFilename : String;
   public
    constructor Create;
    function GetCreatorType: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetExisting: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFileSystem: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetOwner: IOTAModule; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetUnnamed: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetAncestorName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetImplFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetIntfFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFormName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetMainForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowSource: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
{$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}

    procedure FormCreated(const FormEditor: IOTAFormEditor); {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    property NewUnitIdent : String read fNewUnitIdent write fNewUnitIdent;
    property NewClassName : String read fNewClassname write fNewClassname;
    property NewFilename : String read fNewFilename write fNewFilename;
  end;

  TadxPpFormCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
   private
    fNewUnitIdent : String;
    fNewClassname : String;
    fNewFilename : String;
   public
    constructor Create;
    function GetCreatorType: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetExisting: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFileSystem: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetOwner: IOTAModule; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetUnnamed: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetAncestorName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetImplFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetIntfFileName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetFormName: string; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetMainForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowForm: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function GetShowSource: Boolean; {$IFDEF BCBHEADER} virtual; abstract;
{$ENDIF}
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
{$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent:
string): IOTAFile; {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}

    procedure FormCreated(const FormEditor: IOTAFormEditor); {$IFDEF BCBHEADER} virtual; abstract; {$ENDIF}
    property NewUnitIdent : String read fNewUnitIdent write fNewUnitIdent;
    property NewClassName : String read fNewClassname write fNewClassname;
    property NewFilename : String read fNewFilename write fNewFilename;
end;


{$ENDIF}

implementation

uses
  TypInfo,
  adxolFormsManager,
  adxwdFormsManager,
  adxppFormsManager,
  adxxlFormsManager;

const
  CRLF = #13#10;

function GetCurrentProjectGroup: IOTAProjectGroup;
var
  IModuleServices: IOTAModuleServices;
  IModule: IOTAModule;
  IProjectGroup: IOTAProjectGroup;
  i: Integer;
begin
  Result := nil;
  IModuleServices := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to IModuleServices.ModuleCount - 1 do
  begin
    IModule := IModuleServices.Modules[i];
    if IModule.QueryInterface(IOTAProjectGroup, IProjectGroup) = S_OK then
    begin
      Result := IProjectGroup;
      Break;
    end;
  end;
end;


function GetCurrentProject: IOTAProject;
var
  ProjectGroup: IOTAProjectGroup;
begin
  Result := nil;
  ProjectGroup := GetCurrentProjectGroup;

  if Assigned(ProjectGroup) then
    if ProjectGroup.ProjectCount > 0 then
      Result := ProjectGroup.ActiveProject
end;


{$IFDEF DELPHI_9_UP}
function GetCustomFormUnit(const AClass: TClass): string;
begin
  {$IFDEF UNICODE}
  Result := UTF8ToString(GetTypeData(PTypeInfo(AClass.ClassInfo))^.UnitName);
  {$ELSE}
  Result := GetTypeData(PTypeInfo(AClass.ClassInfo))^.UnitName;
  {$ENDIF}
end;

constructor TadxOlFormCreator.Create;
  var OTAModuleServices : IOTAModuleServices;
begin
  inherited Create;
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);
  end;
end;

function TadxOlFormCreator.GetCreatorType : String;
begin
 result := sForm;
end;

function TadxOlFormCreator.GetExisting : Boolean;
begin
 result := FALSE;
end;

function TadxOlFormCreator.GetFileSystem : String;
var OTAModuleServices : IOTAModuleServices;
begin
  result := '';
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    Result := OTAModuleServices.CurrentModule.GetFileSystem;
  end;
end;

function TadxOlFormCreator.GetOwner : IOTAModule;
{var OTAModuleServices : IOTAModuleServices;
begin
 result := nil;
   if BorlandIDEServices.QueryInterface(IOTAModuleServices,
OTAModuleServices) = S_OK then begin
    if OTAModuleServices.CurrentModule.GetOwnerCount > 0 then
     result := OTAModuleServices.CurrentModule.GetOwner(0);
   end; // if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK
end;
}
begin
  Result := GetCurrentProjectGroup;
  if Assigned(Result) then
    Result := (Result as IOTAProjectGroup).ActiveProject
  else
    Result := GetCurrentProject;
end;

function TadxOlFormCreator.GetUnnamed : Boolean;
begin
 result := TRUE;
end;

function TadxOlFormCreator.GetAncestorName: string;
begin
 result := 'adxOlForm';
end;

function TadxOlFormCreator.GetImplFileName: string;
begin
 result := NewFilename;
end;

function TadxOlFormCreator.GetIntfFileName: string;
begin
 result := NewFilename;
end;

function TadxOlFormCreator.GetFormName: string;
begin
 result := NewClassName;
end;

function TadxOlFormCreator.GetShowSource: Boolean;
begin
 result := false;
end;

function TadxOlFormCreator.NewImplSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
  result := TadxOlFormImplementationFile.Create(NewUnitIdent, NewClassName, AncestorIdent,  TadxOlForm);
end;

function TadxOlFormCreator.NewIntfSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
 result := nil;
end;

function TadxOlFormCreator.NewFormFile(const FormIdent, AncestorIdent: string):
IOTAFile;
begin
  result := TadxOlFormImplementationDfmFile.Create(NewUnitIdent, NewClassName, AncestorIdent,  TadxOlForm);
  //result := nil;
end;

function TadxOlFormCreator.GetMainForm: Boolean;
begin
  result := false;
end;

function TadxOlFormCreator.GetShowForm: Boolean;
begin
 result := false;
end;

procedure TadxOlFormCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
   // Do Nothing
end;


{-----------------------------------------------------------------------­------}

constructor TadxXlFormCreator.Create;
  var OTAModuleServices : IOTAModuleServices;
begin
  inherited Create;
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);
  end;
end;

function TadxXlFormCreator.GetCreatorType : String;
begin
 result := sForm;
end;

function TadxXlFormCreator.GetExisting : Boolean;
begin
 result := FALSE;
end;

function TadxXlFormCreator.GetFileSystem : String;
var OTAModuleServices : IOTAModuleServices;
begin
  result := '';
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    Result := OTAModuleServices.CurrentModule.GetFileSystem;
  end;
end;

function TadxXlFormCreator.GetOwner : IOTAModule;
{var OTAModuleServices : IOTAModuleServices;
begin
 result := nil;
   if BorlandIDEServices.QueryInterface(IOTAModuleServices,
OTAModuleServices) = S_OK then begin
    if OTAModuleServices.CurrentModule.GetOwnerCount > 0 then
     result := OTAModuleServices.CurrentModule.GetOwner(0);
   end; // if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK
end;
}
begin
  Result := GetCurrentProjectGroup;
  if Assigned(Result) then
    Result := (Result as IOTAProjectGroup).ActiveProject
  else
    Result := GetCurrentProject;
end;

function TadxXlFormCreator.GetUnnamed : Boolean;
begin
 result := TRUE;
end;

function TadxXlFormCreator.GetAncestorName: string;
begin
 result := 'adxXlForm';
end;

function TadxXlFormCreator.GetImplFileName: string;
begin
 result := NewFilename;
end;

function TadxXlFormCreator.GetIntfFileName: string;
begin
 result := NewFilename;
end;

function TadxXlFormCreator.GetFormName: string;
begin
 result := NewClassName;
end;

function TadxXlFormCreator.GetShowSource: Boolean;
begin
 result := false;
end;

function TadxXlFormCreator.NewImplSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
  result := TadxXlFormImplementationFile.Create(NewUnitIdent, NewClassName, AncestorIdent,  TadxExcelTaskPane);
end;

function TadxXlFormCreator.NewIntfSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
 result := nil;
end;

function TadxXlFormCreator.NewFormFile(const FormIdent, AncestorIdent: string):
IOTAFile;
begin
  result := TadxXlFormImplementationDfmFile.Create(NewUnitIdent, NewClassName, AncestorIdent,  TadxOlForm);
  //result := nil;
end;

function TadxXlFormCreator.GetMainForm: Boolean;
begin
  result := false;
end;

function TadxXlFormCreator.GetShowForm: Boolean;
begin
 result := false;
end;

procedure TadxXlFormCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
   // Do Nothing
end;

{-----------------------------------------------------------------------­------}

constructor TadxWdFormCreator.Create;
  var OTAModuleServices : IOTAModuleServices;
begin
  inherited Create;
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);
  end;
end;

function TadxWdFormCreator.GetCreatorType : String;
begin
 result := sForm;
end;

function TadxWdFormCreator.GetExisting : Boolean;
begin
 result := FALSE;
end;

function TadxWdFormCreator.GetFileSystem : String;
var OTAModuleServices : IOTAModuleServices;
begin
  result := '';
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    Result := OTAModuleServices.CurrentModule.GetFileSystem;
  end;
end;

function TadxWdFormCreator.GetOwner : IOTAModule;
{var OTAModuleServices : IOTAModuleServices;
begin
 result := nil;
   if BorlandIDEServices.QueryInterface(IOTAModuleServices,
OTAModuleServices) = S_OK then begin
    if OTAModuleServices.CurrentModule.GetOwnerCount > 0 then
     result := OTAModuleServices.CurrentModule.GetOwner(0);
   end; // if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK
end;
}
begin
  Result := GetCurrentProjectGroup;
  if Assigned(Result) then
    Result := (Result as IOTAProjectGroup).ActiveProject
  else
    Result := GetCurrentProject;
end;

function TadxWdFormCreator.GetUnnamed : Boolean;
begin
 result := TRUE;
end;

function TadxWdFormCreator.GetAncestorName: string;
begin
 result := 'adxWdForm';
end;

function TadxWdFormCreator.GetImplFileName: string;
begin
 result := NewFilename;
end;

function TadxWdFormCreator.GetIntfFileName: string;
begin
 result := NewFilename;
end;

function TadxWdFormCreator.GetFormName: string;
begin
 result := NewClassName;
end;

function TadxWdFormCreator.GetShowSource: Boolean;
begin
 result := false;
end;

function TadxWdFormCreator.NewImplSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
  result := TadxWdFormImplementationFile.Create(NewUnitIdent, NewClassName, AncestorIdent, TadxWordTaskPane);
end;

function TadxWdFormCreator.NewIntfSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
 result := nil;
end;

function TadxWdFormCreator.NewFormFile(const FormIdent, AncestorIdent: string):
IOTAFile;
begin
  result := TadxWdFormImplementationDfmFile.Create(NewUnitIdent, NewClassName, AncestorIdent,  TadxOlForm);
  //result := nil;
end;

function TadxWdFormCreator.GetMainForm: Boolean;
begin
  result := false;
end;

function TadxWdFormCreator.GetShowForm: Boolean;
begin
 result := false;
end;

procedure TadxWdFormCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
   // Do Nothing
end;


{------------------------------------------------------------------------------}

{-----------------------------------------------------------------------­------}

constructor TadxPpFormCreator.Create;
  var OTAModuleServices : IOTAModuleServices;
begin
  inherited Create;
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);
  end;
end;

function TadxPpFormCreator.GetCreatorType : String;
begin
 result := sForm;
end;

function TadxPpFormCreator.GetExisting : Boolean;
begin
 result := FALSE;
end;

function TadxPpFormCreator.GetFileSystem : String;
var OTAModuleServices : IOTAModuleServices;
begin
  result := '';
  if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
    Result := OTAModuleServices.CurrentModule.GetFileSystem;
  end;
end;

function TadxPpFormCreator.GetOwner : IOTAModule;
begin
  Result := GetCurrentProjectGroup;
  if Assigned(Result) then
    Result := (Result as IOTAProjectGroup).ActiveProject
  else
    Result := GetCurrentProject;
end;

function TadxPpFormCreator.GetUnnamed : Boolean;
begin
 result := TRUE;
end;

function TadxPpFormCreator.GetAncestorName: string;
begin
 result := 'adxPpForm';
end;

function TadxPpFormCreator.GetImplFileName: string;
begin
 result := NewFilename;
end;

function TadxPpFormCreator.GetIntfFileName: string;
begin
 result := NewFilename;
end;

function TadxPpFormCreator.GetFormName: string;
begin
 result := NewClassName;
end;

function TadxPpFormCreator.GetShowSource: Boolean;
begin
 result := false;
end;

function TadxPpFormCreator.NewImplSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
  result := TadxPpFormImplementationFile.Create(NewUnitIdent, NewClassName, AncestorIdent, TadxPowerPointTaskPane);
end;

function TadxPpFormCreator.NewIntfSource(const ModuleIdent, FormIdent,
AncestorIdent: string): IOTAFile;
begin
 result := nil;
end;

function TadxPpFormCreator.NewFormFile(const FormIdent, AncestorIdent: string):
IOTAFile;
begin
  result := TadxPpFormImplementationDfmFile.Create(NewUnitIdent, NewClassName, AncestorIdent,  TadxOlForm);
  //result := nil;
end;

function TadxPpFormCreator.GetMainForm: Boolean;
begin
  result := false;
end;

function TadxPpFormCreator.GetShowForm: Boolean;
begin
 result := false;
end;

procedure TadxPpFormCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
   // Do Nothing
end;


{------------------------------------------------------------------------------}


{------------------------------------------------------------------------------}
constructor TadxOlFormImplementationFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


{ Return the actual source code }
function TadxOlFormImplementationFile.GetSource: string;
begin
  Result := 'unit ' + FModuleName + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


    Result := Result + ',' + CRLF +
       '  Outlook2000, adxolFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + fFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxOlFormsCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


    { Return the age of the file. -1 if new }
function TadxOlFormImplementationFile.GetAge: TDateTime;
begin
        result := -1;
end;

{------------------------------------------------------------------------------}
constructor TadxXlFormImplementationFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


    { Return the actual source code }
function TadxXlFormImplementationFile.GetSource: string;
begin
  Result := 'unit ' + FModuleName + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


    Result := Result + ',' + CRLF +
       '  Outlook2000, adxxlFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + fFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxXlFormsCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


    { Return the age of the file. -1 if new }
function TadxXlFormImplementationFile.GetAge: TDateTime;
begin
        result := -1;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
constructor TadxWdFormImplementationFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


    { Return the actual source code }
function TadxWdFormImplementationFile.GetSource: string;
begin
  Result := 'unit ' + FModuleName + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


    Result := Result + ',' + CRLF +
       '  Word2000, adxwdFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + fFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxWordTaskPanesCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


{ Return the age of the file. -1 if new }
function TadxWdFormImplementationFile.GetAge: TDateTime;
begin
        result := -1;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
constructor TadxPpFormImplementationFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


{ Return the actual source code }
function TadxPpFormImplementationFile.GetSource: string;
begin
  Result := 'unit ' + FModuleName + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


    Result := Result + ',' + CRLF +
       '  MSPpt2000, adxppFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + fFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxPowerPointTaskPanesCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


{ Return the age of the file. -1 if new }
function TadxPpFormImplementationFile.GetAge: TDateTime;
begin
        result := -1;
end;

{------------------------------------------------------------------------------}

{ TadxOlFormImplementationDfmFile }

constructor TadxOlFormImplementationDfmFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


    { Return the actual source code }
function TadxOlFormImplementationDfmFile.GetSource: string;
begin
result := 'object ' + fFormIdent+':'+ 'T' + fFormIdent + CRLF +
  'Left = 223' + CRLF +
  'Top = 114' + CRLF +
  'Width = 400' + CRLF +
  'Height = 300' + CRLF +
  'Caption = ''' + fFormIdent + '''' + CRLF +
  'Color = clBtnFace' + CRLF +
  'Font.Charset = DEFAULT_CHARSET' + CRLF +
  'Font.Color = clWindowText' + CRLF +
  'Font.Height = -11' + CRLF +
  'Font.Name = ''MS Sans Serif''' + CRLF +
  'Font.Style = []' + CRLF +
  'OldCreateOrder = False' + CRLF +
  'PixelsPerInch = 96' + CRLF +
  'TextHeight = 13' + CRLF +
'end';
end;


    { Return the age of the file. -1 if new }
function TadxOlFormImplementationDfmFile.GetAge: TDateTime;
begin
        result := -1;
end;


{ TadxXlFormImplementationDfmFile }

constructor TadxXlFormImplementationDfmFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


    { Return the actual source code }
function TadxXlFormImplementationDfmFile.GetSource: string;
begin
result := 'object ' + fFormIdent+':'+ 'T' + fFormIdent + CRLF +
  'Left = 223' + CRLF +
  'Top = 114' + CRLF +
  'Width = 400' + CRLF +
  'Height = 300' + CRLF +
  'Caption = ''' + fFormIdent + '''' + CRLF +
  'Color = clBtnFace' + CRLF +
  'Font.Charset = DEFAULT_CHARSET' + CRLF +
  'Font.Color = clWindowText' + CRLF +
  'Font.Height = -11' + CRLF +
  'Font.Name = ''MS Sans Serif''' + CRLF +
  'Font.Style = []' + CRLF +
  'OldCreateOrder = False' + CRLF +
  'PixelsPerInch = 96' + CRLF +
  'TextHeight = 13' + CRLF +
'end';
end;


    { Return the age of the file. -1 if new }
function TadxXlFormImplementationDfmFile.GetAge: TDateTime;
begin
        result := -1;
end;

{ TadxWdFormImplementationDfmFile }

constructor TadxWdFormImplementationDfmFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


    { Return the actual source code }
function TadxWdFormImplementationDfmFile.GetSource: string;
begin
result := 'object ' + fFormIdent+':'+ 'T' + fFormIdent + CRLF +
  'Left = 223' + CRLF +
  'Top = 114' + CRLF +
  'Width = 400' + CRLF +
  'Height = 300' + CRLF +
  'Caption = ''' + fFormIdent + '''' + CRLF +
  'Color = clBtnFace' + CRLF +
  'Font.Charset = DEFAULT_CHARSET' + CRLF +
  'Font.Color = clWindowText' + CRLF +
  'Font.Height = -11' + CRLF +
  'Font.Name = ''MS Sans Serif''' + CRLF +
  'Font.Style = []' + CRLF +
  'OldCreateOrder = False' + CRLF +
  'PixelsPerInch = 96' + CRLF +
  'TextHeight = 13' + CRLF +
'end';
end;


    { Return the age of the file. -1 if new }
function TadxWdFormImplementationDfmFile.GetAge: TDateTime;
begin
        result := -1;
end;

{ TadxPpFormImplementationDfmFile }

constructor TadxPpFormImplementationDfmFile.Create(const AModuleName, AFormIdent, AAncestorIdent: String; AAncestorClass: TClass);
begin
 inherited Create;
 fModuleName := AModuleName;
 fFormIdent := AFormIdent;
 fAncestorIdent := AAncestorIdent;
 fAncestorClass := AAncestorClass;
end;


{ Return the actual source code }
function TadxPpFormImplementationDfmFile.GetSource: string;
begin
result := 'object ' + fFormIdent+':'+ 'T' + fFormIdent + CRLF +
  'Left = 223' + CRLF +
  'Top = 114' + CRLF +
  'Width = 400' + CRLF +
  'Height = 300' + CRLF +
  'Caption = ''' + fFormIdent + '''' + CRLF +
  'Color = clBtnFace' + CRLF +
  'Font.Charset = DEFAULT_CHARSET' + CRLF +
  'Font.Color = clWindowText' + CRLF +
  'Font.Height = -11' + CRLF +
  'Font.Name = ''MS Sans Serif''' + CRLF +
  'Font.Style = []' + CRLF +
  'OldCreateOrder = False' + CRLF +
  'PixelsPerInch = 96' + CRLF +
  'TextHeight = 13' + CRLF +
'end';
end;


    { Return the age of the file. -1 if new }
function TadxPpFormImplementationDfmFile.GetAge: TDateTime;
begin
        result := -1;
end;

{$ENDIF}
end.



