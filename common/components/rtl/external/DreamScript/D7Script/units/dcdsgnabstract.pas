{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdsgnabstract;

interface
{$I dc.inc}
uses
  inifiles,menus,controls,forms,windows,typinfo,classes,
  sysutils,dcsystem,dcdsgnutil,activex;

const
  DCcursorPos=Integer(0);
  DCViewTopPos=Integer(1);

const
  sshNone   = 0;
  sshPascal = 1;
  sshC      = 2;
  sshSQL    = 3;
  sshQuery  = 4;

  sbtInclusive     = 0;
  sbtLine          = 1;
  sbtColumn        = 2;
  sbtNonInclusive  = 3;
  sbtUnknown       = 4;

  scmAddToProject  = 0;
  scmShowSource    = 1;
  scmShowForm      = 2;
  scmUnNamed       = 3;
  scmNewUnit       = 4;
  scmNewForm       = 5;
  scmMainForm      = 6;
  scmMarkModified  = 7;
  scmNewFile       = 8;
  scmExisting      = 9;

  slmModule      = 0;
  slmComponent   = 1;
  slmDesigner    = 2;

  sesStandard    = 0;
  sesForm        = 1;
  sesProject     = 2;
  sesAddIn       = 3;

  smfInvalid     = 0;
  smfEnabled     = 1;
  smfVisible     = 2;
  smfChecked     = 3;
  smfBreak       = 4;
  smfBarBreak    = 5;
  smfRadioItem   = 6;

  sesEnabled     = 0;
  sesChecked     = 1;

  sptUnknown      = 0;
  sptInteger      = 1;
  sptChar         = 2;
  sptEnumeration  = 3;
  sptFloat        = 4;
  sptString       = 5;
  sptSet          = 6;
  sptClass        = 7;
  sptMethod       = 8;
  sptWChar        = 9;
  sptLString      = 10;
  sptLWString     = 11;
  sptVariant      = 12;

  sncModuleDeleted   = 0;
  sncModuleRenamed   = 1;
  sncEditorModified  = 2;
  sncFormModified    = 3;
  sncEditorSelected  = 4;
  sncFormSelected    = 5;
  sncBeforeSave      = 6;
  sncAfterSave       = 7;
  sncFormSaving      = 8;
  sncProjResModified = 9;

  sfnFileOpening          = 0;
  sfnFileOpened           = 1;
  sfnFileClosing          = 2;
  sfnProjectOpening       = 3;
  sfnProjectOpened        = 4;
  sfnProjectClosing       = 5;
  sfnAddedToProject       = 6;
  sfnRemovedFromProject   = 7;
  sfnDefaultDesktopLoad   = 8;
  sfnDefaultDesktopSave   = 9;
  sfnProjectDesktopLoad   = 10;
  sfnprojectDesktopSave   = 11;
  sfnPackageInstalled     = 12;
  sfnPackageUninstalled   = 13;

  senBeforeCompile        = 0;
  senAfterCompile         = 1;

  scpCustom         = 0;
  scpApplication    = 1;
  scpLibrary        = 2;
  scpCanShowSource  = 3;
  scpExisting       = 4;
  scpConsole        = 5;

  sbtForm           = 0;
  sbtCustomModule   = 1;

  shvFlags            = 0;
  shvLanguage         = 1;
  shvDataVersion      = 2;
  shvVersion          = 3;
  shvCharacteristics  = 4;

type

  TDCLocalMenuFilter   = slmModule..slmDesigner;
  TDCLocalMenuFilters  = set of TDCLocalMenuFilter;

  TDCResHeaderValue    = shvFlags..shvCharacteristics;

  TDCExpertStyle       = sesStandard..sesAddIn;

  TDCExpertStateItem   = sesEnabled..sesChecked;
  TDCExpertState       = set of TDCExpertStateItem;

  TDCIMenuFlag         = smfInvalid..smfRadioItem;
  TDCIMenuFlags        = set of TDCIMenuFlag;

  TDCCreateModuleFlag  = scmAddToProject..scmExisting;
  TDCCreateModuleFlags = set of TDCCreateModuleFlag;

  TDCSyntaxHighlighter = sshNone..sshQuery;
  TDCBlockType         = sbtInclusive..sbtUnknown;

  TDCNotifyCode         = sncModuleDeleted..sncProjResModified;
  TDCFileNotification   = sfnFileOpening..sfnPackageUninstalled;
  TDCEventNotification  = senBeforeCompile..senAfterCompile;

  TDCCreateProjectFlag  = scpCustom..scpConsole;
  TDCCreateProjectFlags = set of TDCCreateProjectFlag;
  
  TDCBoundsType         = sbtForm..sbtCustomModule;
  TDCPropertyType       = sptUnknown..sptVariant;

  TDCProjectEnumProc=function (Param:Pointer;const FileName,UnitName,
    FormName:string):Boolean stdcall;

  TDCIEditReader=class(TInterfacedObject)
  public
    function GetText(Position:Longint;Buffer:PChar;Count:Longint):Longint;
      virtual;stdcall;abstract;
  end;

  TDCCharPos=packed record
    CharIndex:SmallInt;
    Line:Longint;
  end;

  TDCEditPos=packed record
    Col:SmallInt;
    Line:Longint;
  end;

  TDCIEditWriter=class(TInterfacedObject)
  public
    function CopyTo(Pos:Longint):Boolean;virtual;stdcall;abstract;
    function DeleteTo(Pos:Longint):Boolean;virtual;stdcall;abstract;
    function Insert(Text:PChar):Boolean;virtual;stdcall;abstract;
    function Position:Longint;virtual;stdcall;abstract;
    function GetCurrentPos:TDCCharPos;virtual;stdcall;abstract;
    property CurrentPos:TDCCharPos read GetCurrentPos;
  end;

  TDCIEditView=class(TInterfacedObject)
  public
    function GetPos(Index:Integer):TDCEditPos;virtual;stdcall;abstract;
    procedure SetPos(Index:Integer;Value:TDCEditPos);virtual;stdcall;abstract;
    function GetViewSize:TSize;virtual;stdcall;abstract;
    function PosToCharPos(Pos:Longint):TDCCharPos;virtual;stdcall;abstract;
    function CharPosToPos(CharPos:TDCCharPos):Longint;virtual;stdcall;abstract;
    procedure ConvertPos(EdPosToCharPos:Boolean;var EditPos:TDCEditPos;
      var CharPos:TDCCharPos);virtual;stdcall;abstract;
    procedure GetAttributeAtPos(const EdPos:TDCEditPos;var Element,LineFlag:Integer);
      virtual;stdcall;abstract;

    property CursorPos:TDCEditPos index DCCursorPos read GetPos write SetPos;
    property TopPos:TDCEditPos index DCViewTopPos read GetPos write SetPos;
    property ViewSize:TSize read GetViewSize;
  end;

  TDCIEditorInterface=class(TInterfacedObject)
  public
    function CreateReader:TDCIEditReader;virtual;stdcall;abstract;
    function CreateWriter:TDCIEditWriter;virtual;stdcall;abstract;
    function FileName:string;virtual;stdcall;abstract;
    function LinesInBuffer:Longint;virtual;stdcall;abstract;
    function BufferModified:Boolean;virtual;stdcall;abstract;
    function MarkModified:Boolean;virtual;stdcall;abstract;
    function SetSyntaxHighlighter(SyntaxHighlighter:TDCSyntaxHighlighter):TDCSyntaxHighlighter;
      virtual;stdcall;abstract;
    function GetViewCount:Integer;virtual;stdcall;abstract;
    function GetView(Index:Integer):TDCIEditView;virtual;stdcall;abstract;
    function CreateUndoableWriter:TDCIEditWriter;virtual;stdcall;abstract;
    function GetBlockAfter:TDCCharPos;virtual;stdcall;abstract;
    function GetBlockStart:TDCCharPos;virtual;stdcall;abstract;
    function GetBlockType:TDCBlockType;virtual;stdcall;abstract;
    function GetBlockVisible:Boolean;virtual;stdcall;abstract;
    procedure SetBlockAfter(Value:TDCCharPos);virtual;stdcall;abstract;
    procedure SetBlockStart(Value:TDCCharPos);virtual;stdcall;abstract;
    procedure SetBlockType(Value:TDCBlockType);virtual;stdcall;abstract;
    procedure SetBlockVisible(Value:Boolean);virtual;stdcall;abstract;

    property BlockStart:TDCCharPos read GetBlockStart write SetBlockStart;
    property BlockAfter:TDCCharPos read GetBlockAfter write SetBlockAfter;
    property BlockType:TDCBlockType read GetBlockType write SetBlockType;
    property BlockVisible:Boolean read GetBlockVisible write SetBlockVisible;
  end;

  TDCIComponentInterface=class;

  TDCGetChildCallback=function (Param:Pointer;
    ComponentInterface:TDCIComponentInterface):Boolean stdcall;

  TDCIComponentInterface=class(TInterfacedObject)
  public
    function GetComponentType:string;virtual;stdcall;abstract;
    function GetComponentHandle:Pointer;virtual;stdcall;abstract;
    function GetParent:TDCIComponentInterface;virtual;stdcall;abstract;
    function IsTControl:Boolean;virtual;stdcall;abstract;
    function GetPropCount:Integer;virtual;stdcall;abstract;
    function GetPropName(Index:Integer):string;virtual;stdcall;abstract;
    function GetPropType(Index:Integer):TDCPropertyType;virtual;stdcall;abstract;
    function GetPropTypeByName(const Name:string):TDCPropertyType;
      virtual;stdcall;abstract;
    function GetPropValue(Index:Integer;var Value):Boolean;
      virtual;stdcall;abstract;
    function GetPropValueByName(const Name:string;var Value):Boolean;
      virtual;stdcall;abstract;
    function SetProp(Index:Integer;const Value):Boolean;
      virtual;stdcall;abstract;
    function SetPropByName(const Name:string;const Value):Boolean;
      virtual;stdcall;abstract;
    function GetChildren(Param:Pointer;Proc:TDCGetChildCallback):Boolean;
      virtual;stdcall;abstract;
    function GetControlCount:Integer;virtual;stdcall;abstract;
    function GetControl(Index:Integer):TDCIComponentInterface;
      virtual;stdcall;abstract;
    function GetComponentCount:Integer;virtual;stdcall;abstract;
    function GetComponent(Index:Integer):TDCIComponentInterface;
      virtual;stdcall;abstract;
    function Select:Boolean;virtual;stdcall;abstract;
    function Focus:Boolean;virtual;stdcall;abstract;
    function Delete:Boolean;virtual;stdcall;abstract;
  end;

  TDCIFormInterface=class(TInterfacedObject)
  public
    function FileName:string;virtual;stdcall;abstract;
    function FormModified:Boolean;virtual;stdcall;abstract;
    function MarkModified:Boolean;virtual;stdcall;abstract;
    function GetFormComponent:TDCIComponentInterface;virtual;stdcall;abstract;
    function FindComponent(const Name:string):TDCIComponentInterface;
      virtual;stdcall;abstract;
    function GetComponentFromHandle(ComponentHandle:Pointer):TDCIComponentInterface;
      virtual;stdcall;abstract;
    function GetSelCount:Integer;virtual;stdcall;abstract;
    function GetSelComponent(Index:Integer):TDCIComponentInterface;
      virtual;stdcall;abstract;
    function GetCreateParent:TDCIComponentInterface;virtual;stdcall;abstract;
    function CreateComponent(Container:TDCIComponentInterface;
      const TypeName:string;X,Y,W,H:Integer):TDCIComponentInterface;
      virtual;stdcall;abstract;
  end;

  TDCIResourceEntry=class(TInterfacedObject)
  public
    function GetResourceType:PChar;virtual;stdcall;abstract;
    function GetResourceName:PChar;virtual;stdcall;abstract;
    function Change(NewType,NewName:PChar):Boolean;virtual;stdcall;abstract;
    function GetHeaderValue(HeaderValue:TDCResHeaderValue;
      var Value:Integer):Boolean;virtual;stdcall;abstract;
    function SetHeaderValue(HeaderValue:TDCResHeaderValue;
      Value:Integer):Boolean;virtual;stdcall;abstract;
    function GetData:Pointer;virtual;stdcall;abstract;
    function GetDataSize:Integer;virtual;stdcall;abstract;
    function SetDataSize(NewSize:Integer):Boolean;virtual;stdcall;abstract;
    function GetEntryHandle:Pointer;virtual;stdcall;abstract;
  end;

  TDCIResourceFile=class(TInterfacedObject)
  public
    function FileName:string;virtual;stdcall;abstract;
    function GetEntryCount:Integer;virtual;stdcall;abstract;
    function GetEntry(Index:Integer):TDCIResourceEntry;virtual;stdcall;abstract;
    function GetEntryFromHandle(EntryHandle:Pointer):TDCIResourceEntry;virtual;stdcall;abstract;
    function FindEntry(ResType,Name:PChar):TDCIResourceEntry;virtual;stdcall;abstract;
    function DeleteEntry(EntryHandle:Pointer):Boolean;virtual;stdcall;abstract;
    function CreateEntry(ResType,Name:PChar;Flags,LanguageId:Word;
      DataVersion,Version,Characteristics:Integer):TDCIResourceEntry;virtual;stdcall;abstract;
  end;

  TDCIModuleNotifier=class(TInterfacedObject)
  public
    procedure Notify(NotifyCode:TDCNotifyCode);virtual;stdcall;abstract;
    procedure ComponentRenamed(const AComponent:TComponent;
      const OldName,NewName:string);virtual;stdcall;abstract;
  end;

  TDCIModuleInterface=class(TInterfacedObject)
  public
    function GetEditorInterface:TDCIEditorInterface;virtual;stdcall;abstract;
    function GetFormInterface:TDCIFormInterface;virtual;stdcall;abstract;
    function GetAncestorModule:TDCIModuleInterface;virtual;stdcall;abstract;
    function GetProjectResource:TDCIResourceFile;virtual;stdcall;abstract;
    function IsProjectModule:Boolean;virtual;stdcall;abstract;
    function Close:Boolean;virtual;stdcall;abstract;
    function Save(ForceSave:Boolean):Boolean;virtual;stdcall;abstract;
    function Rename(const NewName:string):Boolean;virtual;stdcall;abstract;
    function GetFileSystem(var FileSystem:string):Boolean;virtual;stdcall;abstract;
    function SetFileSystem(const FileSystem:string):Boolean;virtual;stdcall;abstract;
    function ShowSource:Boolean;virtual;stdcall;abstract;
    function ShowForm:Boolean;virtual;stdcall;abstract;
    function AddNotifier(AModuleNotifier:TDCIModuleNotifier):Boolean;virtual;stdcall;abstract;
    function RemoveNotifier(AModuleNotifier:TDCIModuleNotifier):Boolean;virtual;stdcall;abstract;
    function GetAuxEditorInterface:TDCIEditorInterface;virtual;stdcall;abstract;
  end;

  TDCIVirtualFileSystem=class(TInterfacedObject)
  public
    function GetFileStream(const FileName:TFileName;Mode:Integer):IStream;
      virtual;stdcall;abstract;
    function FileAge(const FileName:TFileName):Longint;
      virtual;stdcall;abstract;
    function RenameFile(const OldName,NewName:TFileName):Boolean;
      virtual;stdcall;abstract;
    function IsReadonly(const FileName:TFileName):Boolean;
      virtual;stdcall;abstract;
    function IsFileBased:Boolean;virtual;stdcall;abstract;
    function DeleteFile(const FileName:TFileName):Boolean;
      virtual;stdcall;abstract;
    function FileExists(const FileName:TFileName):Boolean;
      virtual;stdcall;abstract;
    function GetTempFileName(const FileName:TFileName):TFileName;
      virtual;stdcall;abstract;
    function GetBackupFileName(const FileName:TFileName):TFileName;
      virtual;stdcall;abstract;
    function GetIDString:string;virtual;stdcall;abstract;
  end;

  TDCIExpert=class(TInterfacedObject)
  public
    function GetName:string;virtual;stdcall;abstract;
    function GetAuthor:string;virtual;stdcall;abstract;
    function GetComment:string;virtual;stdcall;abstract;
    function GetPage:string;virtual;stdcall;abstract;

{$IFDEF MSWINDOWS}
    function GetGlyph:HICON;virtual;stdcall;abstract;
{$ENDIF}
{$IFDEF LINUX}
    function GetGlyph:Cardinal;virtual;stdcall;abstract;
{$ENDIF}

    function GetStyle:TDCExpertStyle;virtual;stdcall;abstract;
    function GetState:TDCExpertState;virtual;stdcall;abstract;
    function GetIDString:string;virtual;stdcall;abstract;
    function GetMenuText:string;virtual;stdcall;abstract;
    procedure Execute;virtual;stdcall;abstract;
  end;

  TDCIMenuItemIntf=class;

  TDCIMenuClickEvent=procedure (Sender:TDCIMenuItemIntf) of object;

  TDCIMenuItemIntf=class(TInterfacedObject)
  public
    function DestroyMenuItem:Boolean;virtual;stdcall;abstract;
    function GetIndex:Integer;virtual;stdcall;abstract;
    function GetItemCount:Integer;virtual;stdcall;abstract;
    function GetItem(Index:Integer):TDCIMenuItemIntf;virtual;stdcall;abstract;
    function GetName:string;virtual;stdcall;abstract;
    function GetParent:TDCIMenuItemIntf;virtual;stdcall;abstract;
    function GetCaption:string;virtual;stdcall;abstract;
    function SetCaption(const Caption:string):Boolean;virtual;stdcall;abstract;
    function GetShortCut:Integer;virtual;stdcall;abstract;
    function SetShortCut(ShortCut:Integer):Boolean;virtual;stdcall;abstract;
    function GetFlags:TDCIMenuFlags;virtual;stdcall;abstract;
    function SetFlags(Mask,Flags:TDCIMenuFlags):Boolean;virtual;stdcall;abstract;
    function GetGroupIndex:Integer;virtual;stdcall;abstract;
    function SetGroupIndex(GroupIndex:Integer):Boolean;virtual;stdcall;abstract;
    function GetHint:string;virtual;stdcall;abstract;
    function SetHint(Hint:string):Boolean;virtual;stdcall;abstract;
    function getContext:Integer;virtual;stdcall;abstract;
    function setContext(Context:Integer):Boolean;virtual;stdcall;abstract;
    function GetOnClick:TDCIMenuClickEvent;virtual;stdcall;abstract;
    function SetOnClick(Click:TDCIMenuClickEvent):Boolean;virtual;stdcall;abstract;
    function InsertItem(Index:Integer;Caption,Name,Hint:string;
      ShortCut,Context,GroupIndex:Integer;Flags:TDCIMenuFlags;
      EventHandler:TDCIMenuClickEvent):TDCIMenuItemIntf;virtual;stdcall;abstract;
  end;

  TDCIMainMenuIntf=class(TInterfacedObject)
  public
    function GetMenuItems:TDCIMenuItemIntf;virtual;stdcall;abstract;
    function FindMenuItem(const Name:string):TDCIMenuItemIntf;virtual;stdcall;abstract;
  end;

  TDCIAddInNotifier=class(TInterfacedObject)
  public
    procedure FileNotification(NotifyCode:TDCFileNotification;
      const FileName:string;var Cancel:Boolean);virtual;stdcall;abstract;
    procedure EventNotification(NotifyCode:TDCEventNotification;
      var Cancel:Boolean);virtual;stdcall;abstract;
  end;

  TDCProjectEnumModuleProc=function (Param:Pointer;const FileName,UnitName,
    FormName,DesignClass:string):Boolean stdcall;

  TDCIModuleCreator=class(TInterfacedObject)
  public
    function Existing:Boolean;virtual;stdcall;abstract;
    function GetAncestorName:string;virtual;stdcall;abstract;
    function GetFileName:string;virtual;stdcall;abstract;
    function GetFileSystem:string;virtual;stdcall;abstract;
    function GetFormName:string;virtual;stdcall;abstract;
    function NewModuleSource(const UnitIdent,FormIdent,
      AncestorIdent:string):string;virtual;stdcall;abstract;
    procedure FormCreated(Form:TDCIFormInterface);virtual;stdcall;abstract;
  end;

  TDCIProjectCreator=class(TInterfacedObject)
  public
    function Existing:Boolean;virtual;stdcall;abstract;
    function GetFileName:string;virtual;stdcall;abstract;
    function GetFileSystem:string;virtual;stdcall;abstract;
    function NewProjectSource(const ProjectName:string):string;virtual;stdcall;abstract;
    procedure NewDefaultModule;virtual;stdcall;abstract;
    procedure NewProjectResource(Module:TDCIModuleInterface);virtual;stdcall;abstract;
  end;

  TDCIProjectCreatorEx=class(TDCIProjectCreator)
  public
    function GetOptionName:string;virtual;stdcall;abstract;
    function NewOptionSource(const ProjectName:string):string;virtual;stdcall;abstract;
  end;

  TDCIModuleCreatorEx=class(TDCIModuleCreator)
  public
    function GetIntfName:string;virtual;stdcall;abstract;
    function NewIntfSource(const UnitIdent,FormIdent,
      AncestorIdent:string):string;virtual;stdcall;abstract;
  end;

  TDCIToolServices=class(TInterfacedObject)
  public
    function EnumProjectModules(EnumProc:TDCProjectEnumModuleProc;Param:Pointer):Boolean;
      virtual;stdcall;abstract;

    function ProjectCreateEx(ProjectCreator:TDCIProjectCreatorEx;
      CreateFlags:TDCCreateProjectFlags):TDCIModuleInterface;virtual;stdcall;abstract;
    function ModuleCreateEx(ModuleCreator:TDCIModuleCreatorEx;
      CreateFlags:TDCCreateModuleFlags):TDCIModuleInterface;virtual;stdcall;abstract;

    function CreateCppModule(const ModuleName,FormName,AncestorClass,
      FileSystem:string;HdrSource,Source,Form:IStream;
      CreateFlags:TDCCreateModuleFlags):TDCIModuleInterface;virtual;stdcall;abstract;

    function ProjectCreate(ProjectCreator:TDCIProjectCreator;
      CreateFlags:TDCCreateProjectFlags):TDCIModuleInterface;virtual;stdcall;abstract;
    function ModuleCreate(ModuleCreator:TDCIModuleCreator;
      CreateFlags:TDCCreateModuleFlags):TDCIModuleInterface;virtual;stdcall;abstract;

    function AddNotifierEx(AddInNotifier:TDCIAddInNotifier):Boolean;
      virtual;stdcall;abstract;

    function GetFormBounds(BoundsType:TDCBoundsType):TRect;virtual;stdcall;abstract;

    function AddNotifier(AddInNotifier:TDCIAddInNotifier):Boolean;
      virtual;stdcall;abstract;
    function RemoveNotifier(AddInNotifier:TDCIAddInNotifier):Boolean;
      virtual;stdcall;abstract;

    function CreateModule(const ModuleName:string;
      Source,Form:IStream;CreateFlags:TDCCreateModuleFlags):Boolean;
      virtual;stdcall;abstract;
    function CreateModuleEx(const ModuleName,FormName,AncestorClass,
      FileSystem:string;Source,Form:IStream;
      CreateFlags:TDCCreateModuleFlags):TDCIModuleInterface;virtual;stdcall;abstract;
    function EnumProjectUnits(EnumProc:TDCProjectEnumProc;Param:Pointer):Boolean;
      virtual;stdcall;abstract;

    function RegisterFileSystem(AVirtualFileSystem:TDCIVirtualFileSystem):Boolean;virtual;stdcall;abstract;
    function UnRegisterFileSystem(const Ident:string):Boolean;virtual;stdcall;abstract;
    function GetFileSystem(const Ident:string):TDCIVirtualFileSystem;virtual;stdcall;abstract;

    function GetModuleInterface(const FileName:string):TDCIModuleInterface;
      virtual;stdcall;abstract;
    function GetFormModuleInterface(const FormName:string):TDCIModuleInterface;
      virtual;stdcall;abstract;

    function CloseProject:Boolean;virtual;stdcall;abstract;
    function OpenProject(const ProjName:string):Boolean;virtual;stdcall;abstract;
    function OpenProjectInfo(const ProjName:string):Boolean;virtual;stdcall;abstract;
    function SaveProject:Boolean;virtual;stdcall;abstract;
    function CloseFile(const FileName:string):Boolean;virtual;stdcall;abstract;
    function SaveFile(const FileName:string):Boolean;virtual;stdcall;abstract;
    function OpenFile(const FileName:string):Boolean;virtual;stdcall;abstract;
    function ReloadFile(const FileName:string):Boolean;virtual;stdcall;abstract;
    function ModalDialogBox(Instance:THandle;TemplateName:PChar; WndParent:HWnd;
      DialogFunc:TFarProc;InitParam:LongInt):Integer;virtual;stdcall;abstract;

    function GetParentHandle:HWND;virtual;stdcall;abstract;
    function GetProjectName:string;virtual;stdcall;abstract;
    function GetUnitCount:Integer;virtual;stdcall;abstract;
    function GetUnitName(Index:Integer):string;virtual;stdcall;abstract;

    function GetFormCount:Integer;virtual;stdcall;abstract;
    function GetFormName(Index:Integer):string;virtual;stdcall;abstract;
    function GetCurrentFile:string;virtual;stdcall;abstract;
    function IsFileOpen(const FileName:string):Boolean;virtual;stdcall;abstract;
    function GetNewModuleName(var UnitIdent,FileName:string):Boolean;virtual;stdcall;abstract;

    function GetModuleCount:Integer;virtual;stdcall;abstract;
    function GetModuleName(Index:Integer):string;virtual;stdcall;abstract;
    function GetComponentCount(ModIndex:Integer):Integer;virtual;stdcall;abstract;
    function GetComponentName(ModIndex,CompIndex:Integer):string;virtual;stdcall;abstract;
    function GetMainMenu:TDCIMainMenuIntf;virtual;stdcall;abstract;

    function NewPascalString(Str:PChar):Pointer;virtual;stdcall;abstract;
    procedure FreePascalString(var Str:Pointer);virtual;stdcall;abstract;
    procedure ReferencePascalString(var Str:Pointer);virtual;stdcall;abstract;
    procedure AssignPascalString(var Dest,Src:Pointer);virtual;stdcall;abstract;

    procedure RaiseException(const Message:string);virtual;stdcall;abstract;

    function GetBaseRegistryKey:string;virtual;stdcall;abstract;

    function GetNewModuleAndClassName(const Prefix:string;var UnitIdent,
      ClassName,FileName:string):Boolean;virtual;stdcall;abstract;

    function GetVcsCount:Integer;virtual;stdcall;abstract;
    procedure GetVcsList(List:TStringList);virtual;stdcall;abstract;
    function GetVcsName(Index:Integer):string;virtual;stdcall;abstract;
  end;

  TDCExpertRegisterProc=function(Expert:TDCIExpert):Boolean;

implementation


end.
