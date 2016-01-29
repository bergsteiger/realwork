{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdsgnstuff;

interface
{$I dc.inc}

{$IFDEF D6}
uses
  inifiles,menus,controls,forms,windows,typinfo,classes,
  sysutils,dcsystem,dcdsgnutil,activex,dcdsgnabstract;

{------------------------}

const
  paValueList               = spaValueList;
  paSubProperties           = spaSubProperties;
  paDialog                  = spaDialog;
  paMultiSelect             = spaMultiSelect;
  paAutoUpdate              = spaAutoUpdate;
  paSortList                = spaSortList;
  paReadOnly                = spaReadOnly;
  paRevertable              = spaRevertable;
  paFullWidthName           = spaFullWidthName;
  paVolatileSubProperties   = spaVolatileSubProperties;
  paVCL                     = spaVCL;
  paNotNestable             = spaNotNestable;

  shNone                    = sshNone;
  shPascal                  = sshPascal;
  shC                       = sshC;
  shSQL                     = sshSQL;
  shQuery                   = sshQuery;

  btInclusive               = sbtInclusive;
  btLine                    = sbtLine;
  btColumn                  = sbtColumn;
  btNonInclusive            = sbtNonInclusive;
  btUnknown                 = sbtUnknown;

  cmAddToProject            = scmAddToProject;
  cmShowSource              = scmShowSource;
  cmShowForm                = scmShowForm;
  cmUnNamed                 = scmUnNamed;
  cmNewUnit                 = scmNewUnit;
  cmNewForm                 = scmNewForm;
  cmMainForm                = scmMainForm;
  cmMarkModified            = scmMarkModified;
  cmNewFile                 = scmNewFile;
  cmExisting                = scmExisting;

  lmModule                  = slmModule   ;
  lmComponent               = slmComponent;
  lmDesigner                = slmDesigner ;

  esStandard                = sesStandard ;
  esForm                    = sesForm     ;
  esProject                 = sesProject  ;
  esAddIn                   = sesAddIn    ;

  mfInvalid                 = smfInvalid  ;
  mfEnabled                 = smfEnabled  ;
  mfVisible                 = smfVisible  ;
  mfChecked                 = smfChecked  ;
  mfBreak                   = smfBreak    ;
  mfBarBreak                = smfBarBreak ;
  mfRadioItem               = smfRadioItem;

  esEnabled                 = sesEnabled  ;
  esChecked                 = sesChecked  ;

  ptUnknown                 = sptUnknown    ;
  ptInteger                 = sptInteger    ;
  ptChar                    = sptChar       ;
  ptEnumeration             = sptEnumeration;
  ptFloat                   = sptFloat      ;
  ptString                  = sptString     ;
  ptSet                     = sptSet        ;
  ptClass                   = sptClass      ;
  ptMethod                  = sptMethod     ;
  ptWChar                   = sptWChar      ;
  ptLString                 = sptLString    ;
  ptLWString                = sptLWString   ;
  ptVariant                 = sptVariant    ;

  ncModuleDeleted           = sncModuleDeleted  ;
  ncModuleRenamed           = sncModuleRenamed  ;
  ncEditorModified          = sncEditorModified ;
  ncFormModified            = sncFormModified   ;
  ncEditorSelected          = sncEditorSelected ;
  ncFormSelected            = sncFormSelected   ;
  ncBeforeSave              = sncBeforeSave     ;
  ncAfterSave               = sncAfterSave      ;
  ncFormSaving              = sncFormSaving     ;
  ncProjResModified         = sncProjResModified;

  fnFileOpening             = sfnFileOpening         ;
  fnFileOpened              = sfnFileOpened          ;
  fnFileClosing             = sfnFileClosing         ;
  fnProjectOpening          = sfnProjectOpening      ;
  fnProjectOpened           = sfnProjectOpened       ;
  fnProjectClosing          = sfnProjectClosing      ;
  fnAddedToProject          = sfnAddedToProject      ;
  fnRemovedFromProject      = sfnRemovedFromProject  ;
  fnDefaultDesktopLoad      = sfnDefaultDesktopLoad  ;
  fnDefaultDesktopSave      = sfnDefaultDesktopSave  ;
  fnProjectDesktopLoad      = sfnProjectDesktopLoad  ;
  fnprojectDesktopSave      = sfnprojectDesktopSave  ;
  fnPackageInstalled        = sfnPackageInstalled    ;
  fnPackageUninstalled      = sfnPackageUninstalled  ;

  enBeforeCompile           = senBeforeCompile;
  enAfterCompile            = senAfterCompile ;

  cpCustom                  = scpCustom       ;
  cpApplication             = scpApplication  ;
  cpLibrary                 = scpLibrary      ;
  cpCanShowSource           = scpCanShowSource;
  cpExisting                = scpExisting     ;
  cpConsole                 = scpConsole      ;

  btForm                    = sbtForm        ;
  btCustomModule            = sbtCustomModule;

  hvFlags                   = shvFlags          ;
  hvLanguage                = shvLanguage       ;
  hvDataVersion             = shvDataVersion    ;
  hvVersion                 = shvVersion        ;
  hvCharacteristics         = shvCharacteristics;

type
  TProjectEnumProc              = TDCProjectEnumProc;
  TCreateModuleFlag             = TDCCreateModuleFlag;
  TCreateModuleFlags            = TDCCreateModuleFlags;
  IDesignerSelections           = IDCDsgnDesignerSelections;
  IActivatable                  = IDCDsgnActivatable;
  IImplementation               = IDCDsgnImplementation;
  TDesignerSelections           = TDCPersistentList;
  TDesignerSelectionList        = TDCPersistentList;
  TComponentEditorClass         = TDCDsgnComponentEditorClass;
  TLocalMenuFilter              = TDCLocalMenuFilter;
  TLocalMenuFilters             = TDCLocalMenuFilters;
  TExpertStyle                  = TDCExpertStyle;
  TExpertState                  = TDCExpertState;
  TIMenuFlag                    = TDCIMenuFlag;
  TIMenuFlags                   = TDCIMenuFlags;
  TGroupChangeProc              = TDCGroupChangeProc;
  TFreeCustomModulesProc        = TGroupChangeProc;
  TPropertyAttribute            = TDCDsgnPropertyAttribute;
  TPropertyAttributes           = TDCDsgnPropertyAttributes;
  TPropertyEditorClass          = TDCDsgnPropertyEditorClass;
  IComponentEditor              = IDCDsgnComponentEditor;
  IDesigner                     = IDCDsgnDesigner;
  TGetPropProc                  = TDCDsgnGetPropProc;
  TPropertyEditorFilterFunc     = TDCDsgnPropertyEditorFilterFunc;
  IProperty                     = IDCDsgnProperty;
  TSyntaxHighlighter            = TDCSyntaxHighlighter;
  TBlockType                    = TDCBlockType;
  TIEditReader                  = TDCIEditReader;
  TCharPos                      = TDCCharPos;
  TIEditWriter                  = TDCIEditWriter;
  TEditPos                      = TDCEditPos;
  TIEditView                    = TDCIEditView;
  TIEditorInterface             = TDCIEditorInterface;
  TPropertyType                 = TDCPropertyType;
  TNotifyCode                   = TDCNotifyCode;
  TResHeaderValue               = TDCResHeaderValue;
  TFileNotification             = TDCFileNotification;
  TEventNotification            = TDCEventNotification;
  TCreateProjectFlag            = TDCCreateProjectFlag;
  TCreateProjectFlags           = TDCCreateProjectFlags;
  TBoundsType                   = TDCBoundsType;
  TGetChildCallback             = TDCGetChildCallback;
  TIComponentInterface          = TDCIComponentInterface;
  TIFormInterface               = TDCIFormInterface;
  TIResourceEntry               = TDCIResourceEntry;
  TIResourceFile                = TDCIResourceFile;
  TIModuleNotifier              = TDCIModuleNotifier;
  TIModuleInterface             = TDCIModuleInterface;
  TIVirtualFileSystem           = TDCIVirtualFileSystem;
  TIExpert                      = TDCIExpert;
  TIMenuClickEvent              = TDCIMenuClickEvent;
  TIMenuItemIntf                = TDCIMenuItemIntf;
  TIMainMenuIntf                = TDCIMainMenuIntf;
  TIAddInNotifier               = TDCIAddInNotifier;
  TProjectEnumModuleProc        = TDCProjectEnumModuleProc;
  TIModuleCreator               = TDCIModuleCreator;
  TIProjectCreator              = TDCIProjectCreator;
  TIProjectCreatorEx            = TDCIProjectCreatorEx;
  TIModuleCreatorEx             = TDCIModuleCreatorEx;
  TIToolServices                = TDCIToolServices;
  TExpertRegisterProc           = TDCExpertRegisterProc;
  TPropertyEditor               = TDCDsgnPropertyEditor;
  TComponentProperty            = TDCDsgnComponentProperty;
  TStringProperty               = TDCDsgnStringProperty;
  TNestedProperty               = TDCDsgnNestedProperty;
  TOrdinalProperty              = TDCDsgnOrdinalProperty;
  TIntegerProperty              = TDCDsgnIntegerProperty;
  TFontNameProperty             = TDCDsgnFontNameProperty;
  TClassProperty                = TDCDsgnClassProperty;
  TFontProperty                 = TDCDsgnFontProperty;
  TComponentEditor              = TDCDsgnComponentEditor;
  TDefaultEditor                = TDCDsgnDefaultEditor;
  TCharProperty                 = TDCDsgnCharProperty;
  TColorProperty                = TDCDsgnColorProperty;
  TCursorProperty               = TDCDsgnCursorProperty;
  TCaptionProperty              = TDCDsgnCaptionProperty;
  TModalResultProperty          = TDCDsgnModalResultProperty;
  TShortCutProperty             = TDCDsgnShortCutProperty;
  TComponentNameProperty        = TDCDsgnComponentNameProperty;
  TTabOrderProperty             = TDCDsgnTabOrderProperty;
  TDateTimeProperty             = TDCDsgnDateTimeProperty;
  TFontCharsetProperty          = TDCDsgnFontCharsetProperty;
  TImeNameProperty              = TDCDsgnImeNameProperty;
  TDateProperty                 = TDCDsgnDateProperty;
  TTimeProperty                 = TDCDsgnTimeProperty;
  TEnumProperty                 = TDCDsgnEnumProperty;
  TMPFilenameProperty           = TDCDsgnMPFilenameProperty;
  TSetElementProperty           = TDCDsgnSetElementProperty;
  TSetProperty                  = TDCDsgnSetProperty;
  TFloatProperty                = TDCDsgnFloatProperty;
{
  TPropertyMapperFunc           = TDCDsgnPropertyMapperFunc;
  TRegisterPropertyMapperProc   = TDCDsgnRegisterPropertyMapperProc;
}
{------------------------}

function CreateSelectionList:IDesignerSelections;
procedure RegisterLibraryExpert(Expert:TIExpert);

{------------------------}

var
  ToolServices       : TIToolServices      = nil;
  LibraryExpertProc  : TExpertRegisterProc = nil;

  GetComponentProperties   : TDCDsgnGetComponentPropertiesProc  = DCGetComponentProperties;
  GetComponentEditor       : TDCDsgnGetComponentEditorProc      = DCGetComponentEditor;
  NewEditorGroup           : TDCNewEditorGroupProc              = DCNewEditorGroup;
  NotifyGroupChange        : TDCNotifyGroupChangeProc           = DCNotifyGroupChange;
  UnnotifyGroupChange      : TDCNotifyGroupChangeProc           = DCUnnotifyGroupChange;
  FreeEditorGroup          : TDCFreeEditorGroupProc             = DCFreeEditorGroup;
  RegisterPropertyEditor   : TDCRegisterPropertyEditorProc      = DCRegisterPropertyEditor;
  RegisterComponentEditor  : TDCRegisterComponentEditorProc     = DCRegisterComponentEditor;

{
  RegisterPropertyMapper   : TDCRegisterPropertyMapperProc      = DCRegisterPropertyMapper;
}

{------------------------}

implementation

{------------------------}

function CreateSelectionList:IDesignerSelections;
begin
  Result:=DCCreateSelectionList;
end;

{------------------------}

procedure RegisterLibraryExpert(Expert:TIExpert);
begin
  if @LibraryExpertProc<>nil then
    LibraryExpertProc(Expert);
end;

{------------------------}

initialization
finalization

{------------------------}
{$ELSE}
implementation
begin
{$ENDIF}
end.

