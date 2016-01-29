{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dctoolin;

interface
{$I dc.inc}
uses
  Windows, Classes, sysutils, menus,

  {$IFDEF USEOWNDSGNSTUFF}
    dcdsgnstuff,
  {$ELSE}
    ToolIntf, VirtIntf, ExptIntf,
    EditIntf, FileIntf,

    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  Forms, dcsystem, dcapp, dcvcllib, dcconsts,dcapi,
  dcidemem, dcfdmemo, dcdreamlib,dcidedes {$IFDEF D3} ,activex ,dcpload {$ENDIF};

type
  TIDCToolServices = class(TIToolServices)
  private
    FList : TList;
    function ListByClass(AClass : TIDEObjectClass ; AList : TList) : integer;
  public
    constructor Create;
    destructor Destroy; override;
    function CloseProject: Boolean; override; stdcall;
    function OpenProject(const ProjName: string): Boolean; override;  stdcall;
    function OpenProjectInfo(const ProjName: string): Boolean; override; stdcall;
    function SaveProject: Boolean; override;  stdcall;
    function CloseFile(const FileName: string): Boolean; override;  stdcall;
    function SaveFile(const FileName: string): Boolean; override; stdcall;
    function OpenFile(const FileName: string): Boolean; override; stdcall;
    function ReloadFile(const FileName: string): Boolean; override; stdcall;
    function ModalDialogBox(Instance: THandle; TemplateName: PChar;  WndParent: HWnd;
      DialogFunc: TFarProc; InitParam: LongInt): Integer; override; stdcall;

    function CreateModule(const ModuleName: string;
      Source, Form: {$IFDEF D4} IStream {$ELSE}TIStream{$ENDIF}; CreateFlags: TCreateModuleFlags): Boolean;
      override;  stdcall;
    function CreateModuleEx(const ModuleName, FormName, AncestorClass,
      FileSystem: string; Source, Form: {$IFDEF D4} IStream {$ELSE}TIStream{$ENDIF};
      CreateFlags: TCreateModuleFlags): TIModuleInterface; override; stdcall;
    { Project/UI information }
    function GetParentHandle: HWND; override; stdcall;
    function GetProjectName: string; override; stdcall;
    function GetUnitCount: Integer; override; stdcall;
    function GetUnitName(Index: Integer): string; override; stdcall;
    function EnumProjectUnits(EnumProc: TProjectEnumProc; Param: Pointer): Boolean;
      override; stdcall;
    function GetFormCount: Integer; override; stdcall;
    function GetFormName(Index: Integer): string; override; stdcall;
    function GetCurrentFile: string; override; stdcall;
    function IsFileOpen(const FileName: string): Boolean; override; stdcall;
    function GetNewModuleName(var UnitIdent, FileName: string): Boolean; override; stdcall;

    { Component Library interface }
    function GetModuleCount: Integer; override; stdcall;
    function GetModuleName(Index: Integer): string; override; stdcall;
    function GetComponentCount(ModIndex: Integer): Integer; override; stdcall;
    function GetComponentName(ModIndex, CompIndex: Integer): string; override; stdcall;
    {function InstallModule(const ModuleName: string): Boolean; override; stdcall;
    function CompileLibrary: Boolean; override; stdcall; }

    { override File system interfaces }
    function RegisterFileSystem(AoverrideFileSystem: TIVirtualFileSystem): Boolean; override; stdcall;
    function UnRegisterFileSystem(const Ident: string): Boolean; override; stdcall;
    function GetFileSystem(const Ident: string): TIVirtualFileSystem; override; stdcall;

    { Editor Interfaces }
    function GetModuleInterface(const FileName: string): TIModuleInterface;
      override; stdcall;
    function GetFormModuleInterface(const FormName: string): TIModuleInterface;
      override; stdcall;

    { Menu Interfaces }
    function GetMainMenu: TIMainMenuIntf; override; stdcall;

    { Notification registration }
    function AddNotifier(AddInNotifier: TIAddInNotifier): Boolean;
      override; stdcall;
    function RemoveNotifier(AddInNotifier: TIAddInNotifier): Boolean;
      override; stdcall;

    { Pascal string handling functions }
    function NewPascalString(Str: PChar): Pointer; override; stdcall;
    procedure FreePascalString(var Str: Pointer); override; stdcall;
    procedure ReferencePascalString(var Str: Pointer); override; stdcall;
    procedure AssignPascalString(var Dest, Src: Pointer); override; stdcall;

    { Error handling }
    procedure RaiseException(const Message: string); override; stdcall;

    { Configuration Access }
    function GetBaseRegistryKey: string; override; stdcall;

    { Extensions }
    {$IFDEF D3}
    function GetFormBounds(BoundsType: TBoundsType): TRect; override; stdcall;

    function ProjectCreate(ProjectCreator: TIProjectCreator;
      CreateFlags: TCreateProjectFlags): TIModuleInterface; override; stdcall;

    function ModuleCreate(ModuleCreator: TIModuleCreator;
      CreateFlags: TCreateModuleFlags): TIModuleInterface; override; stdcall;

    { Extended Notification registration }
    function AddNotifierEx(AddInNotifier: TIAddInNotifier): Boolean;
      override; stdcall;

    { Create a unique unit name and class name }
    function GetNewModuleAndClassName(const Prefix: string; var UnitIdent,
      ClassName, FileName: string): Boolean; override; stdcall;
    {$ENDIF}

    {$IFDEF CPB3}
    function CreateCppModule(const ModuleName, FormName, AncestorClass,
      FileSystem: string; HdrSource, Source, Form: {$IFDEF D4} IStream {$ELSE}TIStream{$ENDIF};
      CreateFlags: TCreateModuleFlags): TIModuleInterface; override; stdcall;
    function GetVcsCount: Integer; override; stdcall;
    procedure GetVcsList(List: TStringList); override; stdcall;
    function GetVcsName(Index: Integer): string; override; stdcall;

    function EnumProjectModules(EnumProc: TProjectEnumModuleProc; Param: Pointer): Boolean;
      override; stdcall;

    function ProjectCreateEx(ProjectCreator: TIProjectCreatorEx;
      CreateFlags: TCreateProjectFlags): TIModuleInterface; override; stdcall;
    function ModuleCreateEx(ModuleCreator: TIModuleCreatorEx;
      CreateFlags: TCreateModuleFlags): TIModuleInterface; override; stdcall;
    {$ENDIF}

  end;

  TIDCMenuItemIntf = class;

  TMenuClickItem = class(TObject)
  private
    FOnClick : TIMenuClickEvent;
    FMenuItem : TMenuItem;
    FMenuIntf : TIDCMenuItemIntf ;
    procedure MenuClick(Sender :TObject);
  public
    constructor Create(MenuItem : TMenuItem ; MenuIntf : TIDCMenuItemIntf ;Handler : TIMenuClickEvent);
  end;

  TIDCMenuItemIntf = class(TIMenuItemIntf)
  private
    FLinkedComponent : TDCLinkedComponent;
    FMenuClickItem : TMenuClickItem;
    function  GetFMenuItem : TMenuItem;
    procedure SetFMenuItem(Value : TMenuItem);
  protected
    property FMenuItem : TMenuItem read GetFMenuItem write SetFMenuItem;
  public
    constructor Create(MenuItem : TMenuItem);
    destructor Destroy ; override;
    function DestroyMenuItem: Boolean; override; stdcall;
    function GetIndex: Integer; override; stdcall;
    function GetItemCount: Integer; override; stdcall;
    function GetItem(Index: Integer): TIMenuItemIntf; override; stdcall;
    function GetName: string; override; stdcall;
    function GetParent: TIMenuItemIntf; override; stdcall;
    function GetCaption: string; override; stdcall;
    function SetCaption(const Caption: string): Boolean; override; stdcall;
    function GetShortCut: Integer; override; stdcall;
    function SetShortCut(ShortCut: Integer): Boolean; override; stdcall;
    function GetFlags: TIMenuFlags; override; stdcall;
    function SetFlags(Mask, Flags: TIMenuFlags): Boolean; override; stdcall;
    function GetGroupIndex: Integer; override; stdcall;
    function SetGroupIndex(GroupIndex: Integer): Boolean; override; stdcall;
    function GetHint: string; override; stdcall;
    function SetHint(Hint: string): Boolean; override; stdcall;
    function GetContext: Integer; override; stdcall;
    function SetContext(Context: Integer): Boolean; override; stdcall;
    function GetOnClick: TIMenuClickEvent; override; stdcall;
    function SetOnClick(Click: TIMenuClickEvent): Boolean; override; stdcall;
    function InsertItem(Index: Integer; Caption, Name, Hint: string;
      ShortCut, Context, GroupIndex: Integer; Flags: TIMenuFlags;
      EventHandler: TIMenuClickEvent): TIMenuItemIntf; override; stdcall;
  end;


  TIDCMainMenuIntf = class(TIMainMenuIntf)
  public
    destructor Destroy; override;
    function GetMenuItems: TIMenuItemIntf; override; stdcall;
    function FindMenuItem(const Name: string): TIMenuItemIntf; override; stdcall;
  end;
  {$IFDEF D3}
  TIDCAddInNotifier = class(TIAddInNotifier)
  public
    procedure FileNotification(NotifyCode: TFileNotification;
      const FileName: string; var Cancel: Boolean); override; stdcall;
    procedure EventNotification(NotifyCode: TEventNotification;
      var Cancel: Boolean); override; stdcall;
  end;
  {$ENDIF}



implementation

//var
{  FreeCustomModulesProc: TFreeCustomModulesProc;
  RegisterCustomModuleProc: TRegisterCustomModuleProc;
  LibraryExpertProc: TExpertRegisterProc = nil;
  ToolServices: TCToolServices = nil;}

type
  TMenuIntflist = class(TSortedList)
    function  CompareWithKey(Item,Key:Pointer):Integer;override;
    function  Compare(Item1, Item2: Pointer):integer;override;
  end;


  TMenuCollectionItem = class (TPackagedCollectionItem)
  private
    FLinkedComponent : TDCLinkedComponent;
    function  GetMenuItem : TMenuItem;
    procedure SetMenuItem(Value : TMenuItem);
  public
    constructor Create(Collection: TCollection);override;
    destructor Destroy; override;
    property MenuItem : TMenuItem read GetMenuItem write SetMenuItem ;
  end;

var
  FIDCToolServices    : TIDCToolServices = nil;
  FIDCMainMenuIntf    : TIDCMainMenuIntf = nil;
  FIMenuIntflist      : TMenuIntflist   = nil;
  FMenuItemCollection : TPackagedCollection = nil;
  FNotifierList       : TList;
  FMenuClickList      : TList;

{--------TIDCToolServices-----------------------------------------------}

constructor TIDCToolServices.Create;
begin
  FList := TList.Create;
  inherited Create;
end;

{------------------------------------------------------------------}

destructor TIDCToolServices.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function TIDCToolServices.CloseProject: Boolean;
begin
  with MainIdeObject do
    result := CloseObject(ActiveProject);
end;

{------------------------------------------------------------------}

function TIDCToolServices.OpenProject(const ProjName: string): Boolean;
begin
  with MainIdeObject do
    if ProjName = '' then
      result := NewRegisteredIDEObject(TIDEProject,true) <> nil
    else
      result := OpenWin32File(ProjName) <> nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.OpenProjectInfo(const ProjName: string): Boolean;
begin
  with MainIdeObject do
    result := OpenWin32File(ProjName) <> nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.SaveProject: Boolean;
begin
  with MainIdeObject do
    result := SaveObject(ActiveProject);
end;

{------------------------------------------------------------------}

function TIDCToolServices.CloseFile(const FileName: string): Boolean;
var
  Fname : string;
begin
  Fname := FileName;
  with MainIdeObject do
    result := CloseObject(ObjectByFileName(FName,''));
end;

{------------------------------------------------------------------}

function TIDCToolServices.SaveFile(const FileName: string): Boolean;
var
  Fname : string;
begin
  Fname := FileName;
  with MainIdeObject do
    result := SaveObject(ObjectByFileName(FName,''));
end;

{------------------------------------------------------------------}

function TIDCToolServices.OpenFile(const FileName: string): Boolean;
var
  Fname : string;
begin
  Fname := FileName;
  with MainIdeObject do
    result := OpenWin32File(FName) <> nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.ReloadFile(const FileName: string): Boolean;
var
  Fname : string;
begin
  Fname := FileName;
  with MainIdeObject do
    result := ObjectByFileName(FName,'') <> nil
end;

{------------------------------------------------------------------}

function TIDCToolServices.ModalDialogBox(Instance: THandle; TemplateName: PChar;  WndParent: HWnd;
  DialogFunc: TFarProc; InitParam: LongInt): Integer;
begin
  result := -1;
end;

{------------------------------------------------------------------}

function TIDCToolServices.CreateModule(const ModuleName: string;
  Source, Form: {$IFDEF D4} IStream {$ELSE}TIStream{$ENDIF}; CreateFlags: TCreateModuleFlags): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

function TIDCToolServices.CreateModuleEx(const ModuleName, FormName, AncestorClass,
  FileSystem: string; Source, Form: {$IFDEF D4} IStream {$ELSE}TIStream{$ENDIF};
  CreateFlags: TCreateModuleFlags): TIModuleInterface;
begin
  result := nil;
end;

{------------------------------------------------------------------}

{ Project/UI information }
function TIDCToolServices.GetParentHandle: HWND;
begin
  result := Application.Handle;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetProjectName: string;
begin
  with MainIdeObject do
    if  ActiveProject <> nil then
      result := ActiveProject.FileName
    else
      result := '';
end;

{------------------------------------------------------------------}

function TIDCToolServices.ListByClass(AClass : TIDEObjectClass ; AList : TList) : integer;
var
  i: integer;
  C : TClass;
begin
  result := 0;
  with MainIdeObject do
    if  ActiveProject <> nil then
      with ActiveProject.ProjectItems do
        for i:= 0 to Count - 1  do
        begin
          C:= GetClass(Items[i].ObjectClassName);
          if (C <> nil) and C.InheritsFrom(AClass) then
          begin
            inc(result);
            AList.Add(Items[i]);
          end;
        end;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetUnitCount: Integer;
begin
  FList.Clear;
  ListByClass(TIDEMemoObject,FList);
  ListByClass(TIDEFormMemoObject,FList);
  result :=  FList.Count;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetUnitName(Index: Integer): string;
begin
  FList.Clear;
  ListByClass(TIDEMemoObject,FList);
  ListByClass(TIDEFormMemoObject,FList);
  result := TIDEProjectItem(FList.Items[Index]).FileName;
end;

{------------------------------------------------------------------}

function TIDCToolServices.EnumProjectUnits(EnumProc: TProjectEnumProc; Param: Pointer): Boolean;
var
  i:integer;
  formname : string;
begin
  FList.Clear;
  ListByClass(TIDEFormMemoObject,FList);
  ListByClass(TIDEFormObject,FList);
  ListByClass(TIDEMemoObject,FList);
  result := FList.Count <> 0 ;
  for i:= 0 to FList.Count -1 do
    with TIDEProjectItem(FList.Items[i]) do
    begin
      if (RelatedObject <> nil) and (RelatedObject.GetInstance <> nil) then
        formname := RelatedObject.GetInstance.Name
      else
        formname := '';
      if not EnumProc(Param,FileName,ExtractOnlyName(FileName),formname) then
        break;
    end;

end;

{------------------------------------------------------------------}

function TIDCToolServices.GetFormCount: Integer;
begin
  FList.Clear;
  ListByClass(TIDEFormObject,FList);
  ListByClass(TIDEFormMemoObject,FList);
  result :=  FList.Count;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetFormName(Index: Integer): string;
begin
  FList.Clear;
  ListByClass(TIDEMemoObject,FList);
  ListByClass(TIDEFormMemoObject,FList);
  with TIDEProjectItem(FList.Items[Index]) do
    if (RelatedObject <> nil) and (RelatedObject.GetInstance <> nil) then
      result := RelatedObject.GetInstance.Name
    else
      result := '';
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetCurrentFile: string;
begin
  with MainIdeObject do
    if  ActiveObject <> nil then
      result :=  ActiveObject.FileName
    else
      result := '';
end;

{------------------------------------------------------------------}

function TIDCToolServices.IsFileOpen(const FileName: string): Boolean;
var
  Fname : string;
begin
  Fname := FileName;
  with MainIdeObject do
    result := ObjectByFileName(FName,'') <> nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetNewModuleName(var UnitIdent, FileName: string): Boolean;
var
  AName : string;
begin
  with MainIdeObject do
    AName := UniqueObjectName('Unit'); //don't resource
  UnitIdent := AName;
  FileName := AddSlash(GetCurrentDir) + AName + '.pas'; //don't resource
  result := AName <> '';
end;

{------------------------------------------------------------------}


{ Component Library interface }

{$IFDEF D3}
function TIDCToolServices.GetModuleCount: Integer;
var
  Pl : TDCPackageLoader;
begin
  Pl := GetPackageLoader;
  if Pl <> nil then
    result := Pl.RegisteredPackageCount
  else
    result := 0;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetModuleName(Index: Integer): string;
var
  Pl : TDCPackageLoader;
begin
  Pl := GetPackageLoader;
  if Pl <> nil then
    result := Pl.PackagePath[Index]
  else
    result := '';
end;

{------------------------------------------------------------------}

function ListClassesForPackage(Handle : THandle; List:TList) :integer;
var
  i : integer;
begin
  List.Clear;
  with ClassItems do
  for i := 0 to Count - 1 do
    if TClassItem(Items[i]).PackageHandle = Handle then
      List.Add(Items[i]);
  result := List.Count;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetComponentCount(ModIndex: Integer): Integer;
var
  Pl : TDCPackageLoader;
begin
  Pl := GetPackageLoader;
  if Pl <> nil then
    result := ListClassesForPackage(Pl.PackageHandle[ModIndex],FList)
  else
    result := 0;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetComponentName(ModIndex, CompIndex: Integer): string;
var
  Pl : TDCPackageLoader;
  AClass : TClass;
begin
  Pl := GetPackageLoader;
  result := '';
  if Pl <> nil then
  begin
    ListClassesForPackage(Pl.PackageHandle[ModIndex],FList);
    AClass := TClassItem(FList.Items[CompIndex]).ClassPtr;
    if AClass <> nil then
      result  := AClass.ClassName;
  end;
end;

{$ELSE}

{------------------------------------------------------------------}

function TIDCToolServices.GetModuleCount: Integer;
begin
  result := 0;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetModuleName(Index: Integer): string;
begin
  result := '';
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetComponentCount(ModIndex: Integer): Integer;
begin
  result := 0;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetComponentName(ModIndex, CompIndex: Integer): string;
begin
  result := '';
end;

{$ENDIF}


{------------------------------------------------------------------}

{function InstallModule(const ModuleName: string): Boolean; override; stdcall;
function CompileLibrary: Boolean; override; stdcall; }

{ override File system interfaces }
function TIDCToolServices.RegisterFileSystem(AoverrideFileSystem: TIVirtualFileSystem): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

function TIDCToolServices.UnRegisterFileSystem(const Ident: string): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetFileSystem(const Ident: string): TIVirtualFileSystem;
begin
  result := nil;
end;

{------------------------------------------------------------------}


{ Editor Interfaces }
function TIDCToolServices.GetModuleInterface(const FileName: string): TIModuleInterface;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetFormModuleInterface(const FormName: string): TIModuleInterface;
begin
  result := nil;
end;

{------------------------------------------------------------------}

{ Menu Interfaces }

function MainMenuIntf : TIDCMainMenuIntf;
begin
  if FIDCMainMenuIntf = nil then
    FIDCMainMenuIntf := TIDCMainMenuIntf.Create;
  result := FIDCMainMenuIntf;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetMainMenu: TIMainMenuIntf;
begin
  result := MainMenuIntf;
end;

{------------------------------------------------------------------}

{ Notification registration }
function TIDCToolServices.AddNotifier(AddInNotifier: TIAddInNotifier): Boolean;
begin
  result := AddInNotifier <> nil;
  if result then
    FNotifierList.Add(AddInNotifier);
end;

{------------------------------------------------------------------}

function TIDCToolServices.RemoveNotifier(AddInNotifier: TIAddInNotifier): Boolean;
begin
  result := FNotifierList.Remove(AddInNotifier) >=0
end;

{------------------------------------------------------------------}

{ Pascal string handling functions }
function TIDCToolServices.NewPascalString(Str: PChar): Pointer;
begin
  result := nil;
end;

{------------------------------------------------------------------}

procedure TIDCToolServices.FreePascalString(var Str: Pointer);
begin
end;

{------------------------------------------------------------------}

procedure TIDCToolServices.ReferencePascalString(var Str: Pointer);
begin
end;

{------------------------------------------------------------------}

procedure TIDCToolServices.AssignPascalString(var Dest, Src: Pointer);
begin
end;

{------------------------------------------------------------------}


{ Error handling }
procedure TIDCToolServices.RaiseException(const Message: string);
begin
  raise Exception.Create(Message);
end;

{------------------------------------------------------------------}

{ Configuration Access }
function TIDCToolServices.GetBaseRegistryKey: string;
begin
  result := RegistryKey;
end;

{------------------------------------------------------------------}

{ Extensions }
{$IFDEF D3}
function TIDCToolServices.GetFormBounds(BoundsType: TBoundsType): TRect;
begin
  result.Left := (Screen.Width - cFormWidth) div 2;
  result.Top  := (Screen.Height - cFormHeight) div 2;
  result.Right := result.Left + cFormWidth;
  result.Bottom := result.Top + cFormHeight;
end;

{------------------------------------------------------------------}

function TIDCToolServices.ProjectCreate(ProjectCreator: TIProjectCreator;
  CreateFlags: TCreateProjectFlags): TIModuleInterface;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.ModuleCreate(ModuleCreator: TIModuleCreator;
  CreateFlags: TCreateModuleFlags): TIModuleInterface;
begin
  result := nil;
end;

{------------------------------------------------------------------}

{ Extended Notification registration }
function TIDCToolServices.AddNotifierEx(AddInNotifier: TIAddInNotifier): Boolean;
begin
  result :=  AddNotifier(AddInNotifier);
end;

{------------------------------------------------------------------}

{ Create a unique unit name and class name }
function TIDCToolServices.GetNewModuleAndClassName(const Prefix: string; var UnitIdent,
  ClassName, FileName: string): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}
{$ENDIF}
{$IFDEF CPB3}

function TIDCToolServices.CreateCppModule(const ModuleName, FormName, AncestorClass,
  FileSystem: string; HdrSource, Source, Form: {$IFDEF D4} IStream {$ELSE}TIStream{$ENDIF};
  CreateFlags: TCreateModuleFlags): TIModuleInterface;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetVcsCount: Integer;
begin
  result := 0;
end;

{------------------------------------------------------------------}

procedure TIDCToolServices.GetVcsList(List: TStringList);
begin
end;

{------------------------------------------------------------------}

function TIDCToolServices.GetVcsName(Index: Integer): string;
begin
  result := '';
end;

{------------------------------------------------------------------}

function TIDCToolServices.EnumProjectModules(EnumProc: TProjectEnumModuleProc; Param: Pointer): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

function TIDCToolServices.ProjectCreateEx(ProjectCreator: TIProjectCreatorEx;
  CreateFlags: TCreateProjectFlags): TIModuleInterface;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function TIDCToolServices.ModuleCreateEx(ModuleCreator: TIModuleCreatorEx;
  CreateFlags: TCreateModuleFlags): TIModuleInterface;
begin
  result := nil;
end;

{$ENDIF}


{----Menu Interfaces-------------------------------------------------}

function MainMenu : TMenu;
begin
  if Assigned(Application.MainForm) then
    result := Application.MainForm.Menu
  else
    result := nil;
end;

{------------------------------------------------------------------}

function MainMenuItems : TMenuItem;
begin
  if (MainMenu <> nil) then
    result := MainMenu.Items
  else
    result := nil;
end;

{------------------------------------------------------------------}

function  TMenuIntflist.CompareWithKey(Item,Key:Pointer):Integer;
begin
  result := integer(TIDCMenuItemIntf(Item).FMenuItem) - integer(key);
end;

{------------------------------------------------------------------}

function  TMenuIntflist.Compare(Item1, Item2: Pointer):integer;
begin
  result := integer(TIDCMenuItemIntf(Item1).FMenuItem) - integer(TIDCMenuItemIntf(Item2).FMenuItem);
end;

{------------------------------------------------------------------}

constructor TMenuCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FLinkedComponent := TDCLinkedComponent.Create(nil);
end;

{------------------------------------------------------------------}

destructor TMenuCollectionItem.Destroy;
begin
  if (MenuItem <> nil) and not (csDestroying in MenuItem.ComponentState) then
    MenuItem.Free;
  FLinkedComponent.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------}

function  TMenuCollectionItem.GetMenuItem : TMenuItem;
begin
  result := TMenuItem(FLinkedComponent.Link);
end;

{------------------------------------------------------------------}

procedure TMenuCollectionItem.SetMenuItem(Value : TMenuItem);
begin
  FLinkedComponent.Link := Value;
end;

{------------------------------------------------------------------}

function IMenuIntflist : TMenuIntflist;
begin
  if FIMenuIntflist = nil then
    FIMenuIntflist := TMenuIntflist.Create;
  result := FIMenuIntflist;
end;

{------------------------------------------------------------------}

function MenuItemCollection : TPackagedCollection;
begin
  if FMenuItemCollection = nil then
    FMenuItemCollection := TPackagedCollection.Create(TMenuCollectionItem);
  result := FMenuItemCollection;
end;

{------------------------------------------------------------------}

function GetMenuItem(Item : TMenuItem): TIMenuItemIntf;
var
  idx : integer;
begin
  with IMenuIntflist do
    if FindByKey(Item,Idx) then
      result := TIMenuItemIntf(Items[idx])
    else
      result := TIDCMenuItemIntf.Create(Item);
end;

{------------------------------------------------------------------}

procedure TMenuClickItem.MenuClick(Sender :TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(FMenuIntf);
end;

{------------------------------------------------------------------}

constructor TMenuClickItem.Create(MenuItem : TMenuItem ; MenuIntf : TIDCMenuItemIntf ;Handler : TIMenuClickEvent);
begin
  inherited Create;
  FMenuItem := MenuItem;
  FMenuIntf := MenuIntf;
  FOnClick := Handler;
  FMenuItem.OnClick  := MenuClick;
end;

{--------TIDCMenuItemIntf---------------------------------------------}

constructor TIDCMenuItemIntf.Create(MenuItem : TMenuItem);
begin
  inherited Create;
  FLinkedComponent := TDCLinkedComponent.Create(nil);
  FMenuItem := MenuItem;
  IMenuIntflist.Add(Self);
end;

{------------------------------------------------------------------}

destructor TIDCMenuItemIntf.Destroy ;
begin
  IMenuIntflist.Remove(Self);
  if FMenuClickItem <> nil then
    FMenuClickItem.FMenuIntf := nil;
  FLinkedComponent.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  TIDCMenuItemIntf.GetFMenuItem : TMenuItem;
begin
  result := TMenuItem(FLinkedComponent.Link);
end;

{------------------------------------------------------------------}

procedure TIDCMenuItemIntf.SetFMenuItem(Value : TMenuItem);
begin
  FLinkedComponent.Link  := Value;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.DestroyMenuItem: Boolean;
var
  i : integer;
begin
  result :=  FMenuItem <> nil;
  if result then
    with MenuItemCollection do
      for i := 0 to Count - 1 do
        with TMenuCollectionItem(Items[i]) do
          if MenuItem = FMenuItem then
          begin
            MenuItem := nil;
            break;
          end;
  FMenuItem.Free;
  FMenuClickList.Remove(FMenuClickItem);
  FMenuClickItem.Free;
  FMenuClickItem := nil;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetIndex: Integer;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.MenuIndex
  else
    result := -1;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetItemCount: Integer;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.Count
  else
    result := 0;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetItem(Index: Integer): TIMenuItemIntf;
begin
  result := GetMenuItem(FMenuItem.Items[Index]);
end;
{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetName: string;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.Name
  else
    result :='';
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetParent: TIMenuItemIntf;
begin
  if Assigned(FMenuItem) then
    result := GetMenuItem(FMenuItem.Parent)
  else
    result := nil;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetCaption: string;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.Caption
  else
    result := '';
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.SetCaption(const Caption: string): Boolean;
begin
  result := Assigned(FMenuItem);
  if result then
    FMenuItem.Caption := Caption;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetShortCut: Integer;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.ShortCut
  else
    result := 0;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.SetShortCut(ShortCut: Integer): Boolean;
begin
  result := Assigned(FMenuItem);
  if result then
    FMenuItem.ShortCut := ShortCut;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetFlags: TIMenuFlags;
begin
  if FMenuItem = nil then
    result := [mfInvalid]
  else
    with FMenuItem do
    begin
      result := [];
      if Enabled then
        include(result,mfEnabled);

      if Visible then
        include(result,mfVisible);

      if Checked then
        include(result,mfChecked);

      if Break = mbBreak then
        include(result,mfBreak);

      if Break = mbBarBreak then
          include(result,mfBarBreak);

      if RadioItem then
        include(result,mfRadioItem);

    end;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.SetFlags(Mask, Flags: TIMenuFlags): Boolean;
begin
  result := Assigned(FMenuItem);
  if result then
    with FMenuItem do
    begin
      if mfEnabled in Mask then
        Enabled := mfEnabled in Flags;

      if mfVisible in Mask then
        Visible := mfVisible in Flags;

      if mfChecked in Mask then
        Checked := mfChecked in Flags;

      if mfBreak in Mask then
        if mfBreak in Flags then
          Break := mbBreak
        else
          Break := mbNone;

      if mfBarBreak in Mask then
        if mfBarBreak in Flags then
          Break := mbBarBreak
        else
          Break := mbNone;

      if mfRadioItem in Mask then
        RadioItem := mfRadioItem in Flags;

    end;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetGroupIndex: Integer;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.GroupIndex
  else
    result := 0;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.SetGroupIndex(GroupIndex: Integer): Boolean;
begin
  result := Assigned(FMenuItem);
  if result then
    FMenuItem.GroupIndex := GroupIndex;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetHint: string;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.Hint
  else
    result := '';
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.SetHint(Hint: string): Boolean;
begin
  result := Assigned(FMenuItem);
  if result then
    FMenuItem.Hint := Hint;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetContext: Integer;
begin
  if Assigned(FMenuItem) then
    result := FMenuItem.HelpContext
  else
    result := 0;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.SetContext(Context: Integer): Boolean;
begin
  result := Assigned(FMenuItem);
  if result then
    FMenuItem.HelpContext := Context;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.GetOnClick: TIMenuClickEvent;
begin
  if Assigned(FMenuClickItem) then
    result := FMenuClickItem.FOnClick
  else
    result := nil;
end;


{------------------------------------------------------------------}

function TIDCMenuItemIntf.SetOnClick(Click: TIMenuClickEvent): Boolean;
begin
  result := Assigned(FMenuItem);
  if result then
  begin
    FMenuClickItem := TMenuClickItem.Create(FMenuItem,Self,Click);
    FMenuClickList.Add(FMenuClickItem);
  end;
end;

{------------------------------------------------------------------}

function TIDCMenuItemIntf.InsertItem(Index: Integer; Caption, Name, Hint: string;
  ShortCut, Context, GroupIndex: Integer; Flags: TIMenuFlags;
  EventHandler: TIMenuClickEvent): TIMenuItemIntf;
var
  FItem : TMenuItem;
begin
  result := nil;

  if (MainMenuItems = nil) then
    exit;
    
  FItem := TMenuItem.Create(MainMenu.Owner);

  TMenuCollectionItem(MenuItemCollection.Add).MenuItem := FItem;

  result := TIDCMenuItemIntf.Create(FItem);
  with TIDCMenuItemIntf(result) do
  begin
    SetCaption(Caption);
    FMenuItem.Name := Name;
    SetHint(Hint);
    SetShortCut(ShortCut);
    SetContext(Context);
    SetGroupIndex(GroupIndex);
    SetFlags([mfEnabled, mfVisible, mfChecked, mfBreak, mfBarBreak,mfRadioItem],Flags);
    SetOnClick(EventHandler);
  end;

  If (Index < 0) or (Index >= FMenuItem.Count) then
    FMenuItem.Add(FItem)
  else
    FMenuItem.Insert(Index,FItem);

  BroadCastToNotifiers(self, CM_MENUITEMINSERTED, integer(fItem), 0);
end;

{--------TIDCMainMenuIntf-------------------------------------------}

destructor TIDCMainMenuIntf.Destroy;
begin
  if FIDCMainMenuIntf =  self then
    FIDCMainMenuIntf := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function TIDCMainMenuIntf.GetMenuItems: TIMenuItemIntf;
begin
  result := GetMenuItem(MainMenuItems);
end;

{------------------------------------------------------------------}

function TIDCMainMenuIntf.FindMenuItem(const Name: string): TIMenuItemIntf;
var
  FItem : TMenuItem;
  {------------------------------------------------------------------}

  function FindItem(Item : TMenuItem ; const Name: string) : TMenuItem;
  var
    i : integer;
  begin
    result := nil;
    if Item.Name = Name then
      result := Item
    else
      for i := 0 to Item.Count - 1 do
      begin
        result := FindItem(Item.Items[i] , Name);
        if Assigned(result) then
          break;
      end;
  end;
  {------------------------------------------------------------------}
begin
  if MainMenuItems <> nil then
  begin
    FItem := FindItem(MainMenuItems,Name);
    if FItem <> nil then
      result := TIDCMenuItemIntf.Create(FItem)
    else
      result := nil;
  end
  else
    result := nil;    
end;

{-----TIDCAddInNotifier----------------------------------------------}
{$IFDEF D3}
procedure TIDCAddInNotifier.FileNotification(NotifyCode: TFileNotification; const FileName: string; var Cancel: Boolean);
begin
end;

{------------------------------------------------------------------}

procedure TIDCAddInNotifier.EventNotification(NotifyCode: TEventNotification; var Cancel: Boolean);
begin
end;

{$ENDIF}
{------------------------------------------------------------------}

initialization
  if ToolServices = nil then
  begin
    FIDCToolServices:= TIDCToolServices.Create;
    ToolServices := FIDCToolServices;
  end;
  FNotifierList := TList.Create;
  FMenuClickList := TList.Create;
finalization
  if Assigned(FIDCToolServices) then
  begin
    FIDCToolServices.Free;
    ToolServices := nil;
  end;
  FIDCMainMenuIntf.Free;
  FMenuItemCollection.Free;
  FreeSortedList(FIMenuIntflist,FIMenuIntflist);
  FNotifierList.Free;
  FreeList(FMenuClickList,FMenuClickList);
end.
