{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdsgnutil;

interface
{$I dc.inc}

{$IFDEF D6}
uses
  dcinstprop,RTLConsts,Variants,graphics,dialogs,registry,
  inifiles,menus,controls,forms,windows,typinfo,classes,
  sysutils,dcsystem,dcdreamlib,consts,dcconsts;

const
  spaValueList               =1;
  spaSubProperties           =2;
  spaDialog                  =3;
  spaMultiSelect             =4;
  spaAutoUpdate              =5;
  spaSortList                =6;
  spaReadOnly                =7;
  spaRevertable              =8;
  spaFullWidthName           =9;
  spaVolatileSubProperties   =10;
  spaVCL                     =11;
  spaNotNestable             =12;

  ssCtrlAndLeft=[ssCtrl,ssLeft];

type
  TDCDsgnPropertyAttribute=spaValueList..spaNotNestable;

  TDCDsgnPropertyAttributes=set of TDCDsgnPropertyAttribute;

  IDCDsgnActivatable=interface
  ['{4C574065-8F7F-4CD7-AEEA-13A85591D9FB}']
    procedure Activate;
  end;

  IDCDsgnDesigner=interface
  ['{9F02DAB2-4AC6-4AE3-9788-1606974A3C30}']
    function GetComponent(const Name:string):TComponent;
    procedure Modified;
    function GetRoot:TComponent;
    function UniqueName(const BaseName:string):string;
    procedure SelectComponent(Instance:TPersistent);
    function GetMethodName(const Method:TMethod):string;
    function MethodExists(const Name:string):Boolean;
    function CreateMethod(const Name:string;TypeData:PTypeData):TMethod;
    procedure ShowMethod(const Name:string);
    procedure RenameMethod(const CurName,NewName:string);
    procedure GetMethods(TypeData:PTypeData;Proc:TGetStrProc);
    function GetObjectName(Instance:TPersistent):string;
    function MethodFromAncestor(const Method:TMethod):Boolean;
    procedure Activate;
    function GetPathAndBaseExeName:string;
    function GetPrivateDirectory:string;
    function GetBaseRegKey:string;
    procedure GetSelections(const List:IDCDsgnDesignerSelections);
    procedure SetSelections(const List:IDCDsgnDesignerSelections);
    procedure GetComponentNames(TypeData:PTypeData;Proc:TGetStrProc);
    function GetComponentName(Component:TComponent):string;
    function GetObject(const Name:string):TPersistent;
    procedure GetObjectNames(TypeData:PTypeData;Proc:TGetStrProc);
    function CreateComponent(ComponentClass:TComponentClass;Parent:TComponent;
      Left,Top,Width,Height:Integer):TComponent;
    function CreateCurrentComponent(Parent:TComponent;const Rect:TRect):TComponent;
    function IsComponentLinkable(Component:TComponent):Boolean;
    function IsComponentHidden(Component:TComponent):Boolean;
    procedure MakeComponentLinkable(Component:TComponent);
    procedure Revert(Instance:TPersistent;PropInfo:PPropInfo);
    function GetIsDormant:Boolean;
    procedure GetProjectModules(Proc:TGetModuleProc);
    function GetAncestorDesigner:IDCDsgnDesigner;
    function IsSourceReadOnly:Boolean;
    function GetScrollRanges(const ScrollPosition:TPoint):TPoint;
    procedure Edit(const Component:TComponent);
    procedure ChainCall(const MethodName,InstanceName,InstanceMethod:string;
      TypeData:PTypeData);
    procedure CopySelection;
    procedure CutSelection;
    function CanPaste:Boolean;
    procedure PasteSelection;
    procedure DeleteSelection(ADoAll:Boolean=False);
    procedure ClearSelection;
    procedure NoSelection;
    procedure ModuleFileNames(var ImplFileName,IntfFileName,FormFileName:string);
    function GetRootClassName:string;
    function GetShiftState:TShiftState;
    procedure ModalEdit(EditKey:Char;const ReturnWindow:IDCDsgnActivatable);
    procedure SelectItemName(const PropertyName:string);
    procedure Resurrect;
    property IsDormant:Boolean read GetIsDormant;
    property AncestorDesigner:IDCDsgnDesigner read GetAncestorDesigner;
    property Root:TComponent read GetRoot;
  end;

  IDCDsgnComponentEditor=interface
  ['{7C9165F2-3B0A-43CE-95D8-610BC16A274E}']
    procedure ExecuteVerb(Index:Integer);
    function GetVerb(Index:Integer):string;
    function GetComponent:TComponent;
    function GetDesigner:IDCDsgnDesigner;
    function GetVerbCount:Integer;
    procedure Edit;
  end;

  IDCDsgnProperty=interface;

  TDCDsgnGetPropProc=procedure(const Prop:IDCDsgnProperty) of object;
  TDCDsgnPropertyEditorFilterFunc=function(const ATestEditor:IDCDsgnProperty):Boolean of object;

  IDCDsgnProperty=interface
  ['{83CFC3DC-1389-47C9-8845-C3FAF8D3DC10}']
    procedure GetProperties(Proc:TDCDsgnGetPropProc);
    function GetPropInfo:PPropInfo;
    function GetName:string;
    procedure Edit;
    function AllEqual:Boolean;
    function GetValue:string;
    procedure GetValues(Proc:TGetStrProc);
    procedure SetValue(const Value:string);
    function GetPropType:PTypeInfo;
    function AutoFill:Boolean;
    procedure Activate;
    function ValueAvailable:Boolean;
    function GetAttributes:TDCDsgnPropertyAttributes;

    function HasInstance(Instance: TPersistent): Boolean;
    function GetEditLimit: Integer;
    function GetEditValue(out Value: string): Boolean;
    procedure Revert;
  end;

type
  TDCDsgnPropertyEditor=class;

  TDCDsgnPropertyEditorClass=class of TDCDsgnPropertyEditor;

  TDCEditLimitKind=(lkLimitByValue,lkLimitAsStr);

  PDCDsgnPropEditParamRec=^TDCDsgnPropEditParamRec;
  TDCDsgnPropEditParamRec=record
    EditorClass          :TDCDsgnPropertyEditorClass;
    InfoKinds            :TDCDsgnPropEditParamInfoKinds;
    PropAttrs            :TDCDsgnPropertyAttributes;
    EditLimit            :Integer;
    EditLimitKind        :TDCEditLimitKind;
    case Byte of
     0:(
       AllEqualKind  :TDCPropAccessKind;
       GetValueKind  :TDCPropAccessKind;
       GetValuesKind :TDCPropAccessKind;
       SetValueKind  :TDCPropAccessKind;
       EditKind      :TDCPropAccessKind;
       );
     1:(
       CallKinds :Array[TDCAccessKindsInPropEdit] of TDCPropAccessKind;
       );
  end;

  TDCDsgnPropertyEditor=class(TInterfacedObject,IDCDsgnProperty,IDCDsgnImplementation,IPSCGetInstance)
  private
    FDesigner:IDCDsgnDesigner;
    FProperties:IDCInstPropList;
    FLoadedInfo:TDCDsgnPropEditParamRec;
    procedure EditAsDefault;
    function GetPrivateDirectory:string;
    function GetPropCount:Integer;
    function GetElement:Integer;
    function GetPropAccessKind(AKind:TDCAccessKindsInPropEdit):TDCPropAccessKind;

    {IPSCGetInstance}
    function GetIntfImplementer:TObject;
  protected
    function GetInstance:TObject;
    function GetFloatValue:Extended;
    function GetFloatValueAt(Index:Integer):Extended;
    function GetInt64Value:Int64;
    function GetInt64ValueAt(Index:Integer):Int64;
    function GetMethodValue:TMethod;
    function GetMethodValueAt(Index:Integer):TMethod;
    function GetOrdValue:Longint;
    function GetOrdValueAt(Index:Integer):Longint;
    function GetStrValue:string;
    function GetStrValueAt(Index:Integer):string;
    function GetVarValue:Variant;
    function GetVarValueAt(Index:Integer):Variant;
    procedure Modified;
    procedure SetFloatValue(Value:Extended);
    procedure SetMethodValue(const Value:TMethod);
    procedure SetInt64Value(Value:Int64);
    procedure SetOrdValue(Value:Longint);
    procedure SetStrValue(const Value:string);
    procedure SetVarValue(const Value:Variant);

    property Element:Integer read GetElement;
  protected
    function GetEditValue(out Value:string):Boolean;
    function HasInstance(Instance:TPersistent):Boolean;
  public
    procedure SetPropEntry(Index:Integer;AInstance:TPersistent;
      APropInfo:PPropInfo);virtual;
    constructor Create(const ADesigner:IDCDsgnDesigner;APropCount:Integer;
      AElement:Integer=0);virtual;
    destructor Destroy;override;
    procedure Activate;virtual;
    function AllEqual:Boolean;virtual;
    function AutoFill:Boolean;virtual;
    procedure Edit;virtual;
    function GetAttributes:TDCDsgnPropertyAttributes;virtual;
    function GetComponent(Index:Integer):TPersistent;
    function GetEditLimit:Integer;virtual;
    function GetName:string;virtual;
    procedure GetProperties(Proc:TDCDsgnGetPropProc);virtual;
    function GetPropInfo:PPropInfo;virtual;
    function GetPropType:PTypeInfo;
    function GetValue:string;virtual;
    function GetVisualValue:string;
    procedure GetValues(Proc:TGetStrProc);virtual;
    procedure Initialize;virtual;
    procedure Revert;
    procedure SetValue(const Value:string);virtual;
    function ValueAvailable:Boolean;
    property Designer:IDCDsgnDesigner read FDesigner;
    property PrivateDirectory:string read GetPrivateDirectory;
    property PropCount:Integer read GetPropCount;
    property Value:string read GetValue write SetValue;
  end;

  TDCDsgnComponentEditor=class(TInterfacedObject,IDCDsgnComponentEditor)
  private
    FComponent:TComponent;
    FDesigner:IDCDsgnDesigner;
  public
    constructor Create(AComponent:TComponent;ADesigner:IDCDsgnDesigner);virtual;
    procedure Edit;virtual;
    procedure ExecuteVerb(Index:Integer);virtual;
    function GetComponent:TComponent;
    function GetDesigner:IDCDsgnDesigner;
    function GetVerb(Index:Integer):string;virtual;
    function GetVerbCount:Integer;virtual;
    function IsInInlined:Boolean;
    procedure Copy;virtual;
    property Component:TComponent read FComponent;
    property Designer:IDCDsgnDesigner read GetDesigner;
  end;

  IDCDsgnMethodProperty=interface
  ['{4404273E-8A98-4532-BA38-9713A8160841}']
  end;

  TDCDsgnDefaultEditor = class(TDCDsgnComponentEditor)
  private
    fEdit        : IDCDsgnProperty;
    fCurPriority : integer;
    fContinue    : boolean;
    
    procedure GetPropEditForEditProperty(const Prop: IDCDsgnProperty);
    procedure GetPropEdit(const Prop: IDCDsgnProperty);
  protected
    procedure EditProperty(const PropertyEditor:IDCDsgnProperty;var Continue:Boolean); virtual;
  public
    procedure Edit; override;
  end;

  TDCDsgnComponentEditorClass=class of TDCDsgnComponentEditor;

  TDCDsgnOrdinalProperty      =class(TDCDsgnPropertyEditor);
  TDCDsgnIntegerProperty      =class(TDCDsgnOrdinalProperty);
  TDCDsgnCharProperty         =class(TDCDsgnOrdinalProperty);
  TDCDsgnFloatProperty        =class(TDCDsgnPropertyEditor);
  TDCDsgnStringProperty       =class(TDCDsgnPropertyEditor);
  TDCDsgnEnumProperty         =class(TDCDsgnOrdinalProperty);
  TDCDsgnInt64Property        =class(TDCDsgnPropertyEditor);
  TDCDsgnFontNameProperty     =class(TDCDsgnStringProperty);
  TDCDsgnFontCharsetProperty  =class(TDCDsgnIntegerProperty);
  TDCDsgnImeNameProperty      =class(TDCDsgnStringProperty);
  TDCDsgnBrushStyleProperty   =class(TDCDsgnEnumProperty);
  TDCDsgnPenStyleProperty     =class(TDCDsgnEnumProperty);
  TDCDsgnCursorProperty       =class(TDCDsgnIntegerProperty);
  TDCDsgnModalResultProperty  =class(TDCDsgnIntegerProperty);
  TDCDsgnShortCutProperty     =class(TDCDsgnOrdinalProperty);
  TDCDsgnTabOrderProperty     =class(TDCDsgnIntegerProperty);
  TDCDsgnCaptionProperty      =class(TDCDsgnStringProperty);
  TDCDsgnComponentNameProperty=class(TDCDsgnStringProperty);
  TDCDsgnDateProperty         =class(TDCDsgnPropertyEditor);
  TDCDsgnTimeProperty         =class(TDCDsgnPropertyEditor);
  TDCDsgnDateTimeProperty     =class(TDCDsgnPropertyEditor);

  TDCDsgnNestedProperty=class(TDCDsgnPropertyEditor)
  public
    constructor Create(Parent:IDCDsgnProperty;AElement:Integer=0);reintroduce;
  end;

  TDCDsgnSetElementProperty=class(TDCDsgnNestedProperty)
  public
    function GetName:string;override;
  end;

  TDCDsgnSetProperty=class(TDCDsgnOrdinalProperty)
  public
    procedure GetProperties(Proc:TDCDsgnGetPropProc);override;
  end;

  TDCDsgnClassProperty=class(TDCDsgnPropertyEditor)
  public
    procedure GetProperties(Proc:TDCDsgnGetPropProc);override;
  end;

  TDCDsgnMethodProperty=class(TDCDsgnPropertyEditor,IDCDsgnMethodProperty);

  TDCDsgnComponentProperty=class(TDCDsgnPropertyEditor)
  protected
    function GetComponentReference:TComponent;virtual;
  public
    procedure GetValues(Proc:TGetStrProc);override;
    procedure SetValue(const Value:string);override;
    function GetValue:string;override;
    procedure Edit;override;
    function GetAttributes:TDCDsgnPropertyAttributes;override;
  end;

  TDCDsgnColorProperty     =class(TDCDsgnIntegerProperty);
  TDCDsgnFontProperty      =class(TDCDsgnClassProperty);
  TDCDsgnMPFilenameProperty=class(TDCDsgnStringProperty);

  TDCGroupChangeProc=procedure(AGroup:Integer);

function DCCreateSelectionList:IDCDsgnDesignerSelections;
function DCNewEditorGroup:Integer;

procedure DCNotifyGroupChange(AProc:TDCGroupChangeProc);
procedure DCUnnotifyGroupChange(AProc:TDCGroupChangeProc);
procedure DCFreeEditorGroup(Group:Integer);

procedure DCRegisterComponentEditor(ComponentClass:TComponentClass;
  ComponentEditor:TDCDsgnComponentEditorClass);

var
  GShowReadOnlyProps:Boolean=True;

procedure DCRegisterPropertyEditor(PropertyType:PTypeInfo;ComponentClass:TClass;
  const PropertyName:string;EditorClass:TDCDsgnPropertyEditorClass);

procedure DCGetComponentProperties(const Components:IDCDsgnDesignerSelections;
  Filter:TTypeKinds;const Designer:IDCDsgnDesigner;Proc:TDCDsgnGetPropProc;
  EditorFilterFunc:TDCDsgnPropertyEditorFilterFunc=nil);

function DCGetComponentEditor(Component:TComponent;
  const Designer:IDCDsgnDesigner):IDCDsgnComponentEditor;

procedure DCTestProperlyRegistered;

function DCFindPropEditParams(EditorClass:TDCDsgnPropertyEditorClass;
  RequiredInfo:TDCDsgnPropEditParamInfoKind):PDCDsgnPropEditParamRec;

type
  IDCGetDCDesigner=interface
  ['{82061132-39DC-4F72-85D4-ACF682D0943F}']
    function GetDCDesigner:IDCDsgnDesigner;
  end;

  IDCSetDCDesigner=interface(IDCGetDCDesigner)
  ['{87807AFE-6A99-4A42-B02C-F977C49BCE0D}']
    procedure SetDCDesigner(const V:IDCDsgnDesigner);
  end;

  TDCDsgnGetComponentPropertiesProc= procedure(
    const Components:IDCDsgnDesignerSelections;
    Filter:TTypeKinds;const Designer:IDCDsgnDesigner;Proc:TDCDsgnGetPropProc;
    EditorFilterFunc:TDCDsgnPropertyEditorFilterFunc=nil);

  TDCDsgnGetComponentEditorProc=function(Component:TComponent;
    const Designer:IDCDsgnDesigner):IDCDsgnComponentEditor;

  TDCNewEditorGroupProc         = function:Integer;
  TDCNotifyGroupChangeProc      = procedure(AProc:TDCGroupChangeProc);
  TDCFreeEditorGroupProc        = procedure(EditorGroup:Integer);

  TDCRegisterPropertyEditorProc=procedure(PropertyType:PTypeInfo;
    ComponentClass:TClass;const PropertyName:string;
    EditorClass:TDCDsgnPropertyEditorClass);

  TDCRegisterComponentEditorProc=procedure(ComponentClass:TComponentClass;
    ComponentEditor:TDCDsgnComponentEditorClass);

implementation

uses
  dcVarPropEd,dcgen;

{------------------------------------}

type
  TDCDesignerInstPropList=class(TDCInstPropList,IDCGetDCDesigner,IDCSetDCDesigner)
  private
    FDesigner:IDCDsgnDesigner;
    function GetDCDesigner:IDCDsgnDesigner;
    procedure SetDCDesigner(const V:IDCDsgnDesigner);
    function GetFormMethodName:string;
  protected
    procedure LoadAllProcs;override;
    procedure GetValuesAsMethod(Proc:TGetStrProc);
    function GetValueAsMethod:String;
    procedure SetValueAsMethod(const AValue:string);
    procedure EditAsMethod;
  public
  published
  end;

{---------------------}

procedure TDCDesignerInstPropList.EditAsMethod;
var
  FormMethodName:string;
begin
  if not AllNamed then
    raise EPropertyError.Create(SDCCannotCreateName);
  FormMethodName:=GetValueAsMethod;
  if (FormMethodName='') or
    FDesigner.MethodFromAncestor(GetValueAtAsMethod(0)) then
  begin
    if FormMethodName='' then
      FormMethodName:=GetFormMethodName;
    if FormMethodName='' then
      raise EPropertyError.Create(SDCCannotCreateName);
    SetValueAsMethod(FormMethodName);
  end;
  FDesigner.ShowMethod(FormMethodName);
end;

{---------------------}

function TDCDesignerInstPropList.GetFormMethodName:string;
var
  I:Integer;
begin
  if PDCInstPropItem(Items[0]).Instance=FDesigner.GetRoot then
  begin
    Result:=FDesigner.GetRootClassName;
    if (Result<>'') and (Result[1]='T') then
      System.Delete(Result,1,1);
  end
  else
  begin
    Result:=FDesigner.GetObjectName(PDCInstPropItem(Items[0]).Instance);
    for I:=Length(Result) downto 1 do
      if Result[I] in ['.','[',']','-','>'] then
        System.Delete(Result,I,1);
  end;
  if Result='' then
    raise EPropertyError.Create(SDCCannotCreateName);
  Result:=Result+DCTrimEventName(GetName);
end;

{---------------------}

procedure TDCDesignerInstPropList.LoadAllProcs;
begin
  inherited;
  With ProcArrays do
  begin
    FSetValueProcs[akMethod].AsSetValue   :=SetValueAsMethod;
    FGetValuesProcs[akMethod].AsGetValues :=GetValuesAsMethod;
    FGetValueProcs[akMethod].AsStrMethod  :=GetValueAsMethod;
    FEditProcs[akMethod].AsNoParams       :=EditAsMethod;
  end;
end;

{---------------------}

{
  TDCProcArrays=record
    case Byte of
      0:(
        FAllEqualProcs        : TDCProcArray;//ikAllEqual,
        FEditProcs            : TDCProcArray;//ikEdit,
        FSetValueDataPtrProcs : TDCProcArray;//ikSetValueByDataPtr,
        FGetValueAtProcs      : TDCProcArray;//ikGetValueAt,
        //ikEditLimit,
        //ikPropAttrs
      );
      1:
       (ProcArray:Array[TDCPropProcKind] of TDCProcArray);
  end;
}
{---------------------}

procedure TDCDesignerInstPropList.GetValuesAsMethod(Proc:TGetStrProc);
begin
  FDesigner.GetMethods(GetTypeData(GetPropType),Proc);
end;

{---------------------}

function TDCDesignerInstPropList.GetValueAsMethod:String;
begin
  Result:=FDesigner.GetMethodName(GetValueAtAsMethod(0));
end;

{---------------------}

procedure TDCDesignerInstPropList.SetValueAsMethod(const AValue:string);
var
  NewMethod:Boolean;
  CurValue:string;
  OldMethod:TMethod;
begin
  if not AllNamed then
    raise EPropertyError.Create(SCannotCreateName);
  CurValue:= GetValueAsMethod;
  if (CurValue<>'') and (AValue<>'') and (SameText(CurValue,AValue) or
    not FDesigner.MethodExists(AValue)) and not FDesigner.MethodFromAncestor(GetValueAtAsMethod(0))
  then
    FDesigner.RenameMethod(CurValue,AValue)
  else
    begin
      NewMethod:=(AValue<>'') and not FDesigner.MethodExists(AValue);
      OldMethod:=GetValueAtAsMethod(0);
      SetMethodValue(FDesigner.CreateMethod(AValue,GetTypeData(GetPropType)));
      if NewMethod then
        FDesigner.ShowMethod(AValue);
    end;
end;

{------------------------------------}

function TDCDesignerInstPropList.GetDCDesigner:IDCDsgnDesigner;
begin
  Result:=FDesigner;
end;

{------------------------------------}

procedure TDCDesignerInstPropList.SetDCDesigner(const V:IDCDsgnDesigner);
begin
  FDesigner:=V;
end;

{------------------------------------}

type
  TDCDsgnPropertyMapperFunc=function(Obj:TPersistent;
    PropInfo:PPropInfo):TDCDsgnPropertyEditorClass;
  TDCDsgnRegisterPropertyMapperProc=procedure (Mapper:TDCDsgnPropertyMapperFunc);
  TDCRegisterPropertyMapperProc = procedure(Mapper:TDCDsgnPropertyMapperFunc);

procedure DCRegisterPropertyMapper(Mapper:TDCDsgnPropertyMapperFunc);forward;

{------------------------------------}

const
  CDCFontNamePropAttrs       =[spaMultiSelect,spaValueList,spaSortList,spaRevertable];
  CDCCursorPropAttrs         =[spaMultiSelect,spaValueList,spaSortList,spaRevertable];
  CDCEnumPropAttrs           =[spaMultiSelect,spaValueList,spaSortList,spaRevertable];
  CDCMethodPropAttrs         =[spaMultiSelect,spaValueList,spaSortList,spaRevertable];

  CDCModalResultPropAttrs    =[spaMultiSelect,spaValueList,spaRevertable];
  CDCShortCutPropAttrs       =[spaMultiSelect,spaValueList,spaRevertable];

  CDCDatePropAttrs           =[spaMultiSelect,spaRevertable];
  CDCTimePropAttrs           =[spaMultiSelect,spaRevertable];
  CDCDateTimePropAttrs       =[spaMultiSelect,spaRevertable];

  CDCSetPropAttrs            =[spaMultiSelect,spaSubProperties,spaReadOnly,spaRevertable];
  CDCClassPropAttrs          =[spaMultiSelect,spaSubProperties,spaReadOnly];
  CDCFontPropAttrs           =[spaMultiSelect,spaSubProperties,spaDialog,spaReadOnly];

  CDCSetElementPropAttrs     =[spaMultiSelect,spaValueList,spaSortList];
  CDCDsgnImeNamePropAttrs    =[spaMultiSelect,spaValueList,spaSortList];

  CDCDefaultPropAttrs        =[spaMultiSelect,spaRevertable];
  CDCFontCharSetPropAttrs    =[spaMultiSelect,spaSortList,spaValueList];
  CDCColorPropAttrs          =[spaMultiSelect,spaDialog,spaValueList,spaRevertable];
  CDCCaptionPropAttrs        =[spaMultiSelect,spaAutoUpdate,spaRevertable];
  CDCMPFilenamePropAttr      =[spaDialog,spaRevertable];
  CDCComponentNamePropAttrs  =[spaNotNestable];

const
  MaxIdentLength=63;

  CDCPropEditParams:Array[0..27] of TDCDsgnPropEditParamRec=(

    (EditorClass:          TDCDsgnFloatProperty;
     InfoKinds:            [ikAllValues,ikGetValue,ikSetValue];
     AllEqualKind:         akFloat;
     GetValueKind:         akFloat;
     SetValueKind:         akFloat;
    ),

    (EditorClass:          TDCDsgnFontNameProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues];
     PropAttrs:            CDCFontNamePropAttrs;
     GetValuesKind:        akFontName;
    ),

    (EditorClass:          TDCDsgnCursorProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues,ikGetValue,ikSetValue];
     PropAttrs:            CDCCursorPropAttrs;
     GetValueKind:         akCursor;
     GetValuesKind:        akCursor;
     SetValueKind:         akCursor;
     ),

    (EditorClass:          TDCDsgnEnumProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues,ikGetValue,ikSetValue];
     PropAttrs:            CDCEnumPropAttrs;
     GetValueKind:         akEnum;
     GetValuesKind:        akEnum;
     SetValueKind:         akEnum;
    ),

    (EditorClass:          TDCDsgnMethodProperty;
     InfoKinds:            [ikEditLimit,ikPropAttrs,ikAllValues,ikGetValues,
       ikGetValue,ikSetValue,ikEdit];
     PropAttrs:            CDCMethodPropAttrs;
     EditLimit:            MaxIdentLength;
     AllEqualKind:         akMethod;
     GetValueKind:         akMethod;
     GetValuesKind:        akMethod;
     SetValueKind:         akMethod;
     EditKind:             akMethod;
    ),

    (EditorClass:          TDCDsgnModalResultProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues,ikGetValue,ikSetValue];
     PropAttrs:            CDCModalResultPropAttrs;
     GetValueKind:         akModalResult;
     GetValuesKind:        akModalResult;
     SetValueKind:         akModalResult;
    ),

    (EditorClass:          TDCDsgnShortCutProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues,ikGetValue,ikSetValue];
     PropAttrs:            CDCShortCutPropAttrs;
     GetValueKind:         akShortCut;
     GetValuesKind:        akShortCut;
     SetValueKind:         akShortCut;
    ),

    (EditorClass:          TDCDsgnDateProperty;
     InfoKinds:            [ikPropAttrs,ikGetValue,ikSetValue];
     PropAttrs:            CDCDatePropAttrs;
     GetValueKind:         akDate;
     SetValueKind:         akDate;
    ),

    (EditorClass:          TDCDsgnTimeProperty;
     InfoKinds:            [ikPropAttrs,ikGetValue,ikSetValue];
     PropAttrs:            CDCTimePropAttrs;
     GetValueKind:         akTime;
     SetValueKind:         akTime;
    ),

    (EditorClass:          TDCDsgnDateTimeProperty;
     InfoKinds:            [ikPropAttrs,ikGetValue,ikSetValue];
     PropAttrs:            CDCDateTimePropAttrs;
     GetValueKind:         akDateTime;
     SetValueKind:         akDateTime;
    ),

    (EditorClass:          TDCDsgnSetProperty;
     InfoKinds:            [ikPropAttrs,ikGetValue];
     PropAttrs:            CDCSetPropAttrs;
     GetValueKind:         akSet;
    ),

    (EditorClass:          TDCDsgnClassProperty;
     InfoKinds:            [ikPropAttrs,ikGetValue];
     PropAttrs:            CDCClassPropAttrs;
     GetValueKind:         akClass;
    ),

    (EditorClass:          TDCDsgnFontProperty;
     InfoKinds:            [ikPropAttrs,ikEdit];
     PropAttrs:            CDCFontPropAttrs;
     EditKind:             akFont;
    ),

    (EditorClass:          TDCDsgnSetElementProperty;
     InfoKinds:            [ikPropAttrs,ikAllValues,ikGetValues,ikGetValue,ikSetValue];
     PropAttrs:            CDCSetElementPropAttrs;
     AllEqualKind:         akSetElem;
     GetValueKind:         akSetElem;
     GetValuesKind:        akSetElem;
     SetValueKind:         akSetElem;
    ),

    (EditorClass:          TDCDsgnImeNameProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues];
     PropAttrs:            CDCDsgnImeNamePropAttrs;
     GetValuesKind:        akImeName;
    ),

    (EditorClass:          TDCDsgnPropertyEditor;
     InfoKinds:            [ikPropAttrs,ikAllValues,ikEdit];
     PropAttrs:            CDCDefaultPropAttrs;
     AllEqualKind:         akDefault;
     EditKind:             akDefault;             
    ),

    (EditorClass:          TDCDsgnFontCharSetProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues,ikGetValue,ikSetValue];
     PropAttrs:            CDCFontCharSetPropAttrs;
     GetValueKind:         akFontCharSet;
     GetValuesKind:        akFontCharSet;
     SetValueKind:         akFontCharSet;
    ),

    (EditorClass:          TDCDsgnColorProperty;
     InfoKinds:            [ikPropAttrs,ikGetValues,ikGetValue,ikSetValue,ikEdit];
     PropAttrs:            CDCColorPropAttrs;
     GetValueKind:         akColor;
     GetValuesKind:        akColor;
     SetValueKind:         akColor;
     EditKind:             akColor;
    ),

    (EditorClass:          TDCDsgnCaptionProperty;
     InfoKinds:            [ikPropAttrs];
     PropAttrs:            CDCCaptionPropAttrs;
    ),

    (EditorClass:          TDCDsgnMPFilenameProperty;
     InfoKinds:            [ikPropAttrs,ikEdit];
     PropAttrs:            CDCMPFilenamePropAttr;
     EditKind:             akMPFileName;            
    ),

    (EditorClass:          TDCDsgnComponentNameProperty;
     InfoKinds:            [ikEditLimit,ikPropAttrs];
     PropAttrs:            CDCComponentNamePropAttrs;
     EditLimit:            MaxIdentLength;
    ),

    (EditorClass:          TDCDsgnTabOrderProperty;
     InfoKinds:            [ikPropAttrs];
     PropAttrs:            [];
    ),

    (EditorClass:          TDCDsgnOrdinalProperty;
     InfoKinds:            [ikEditLimit,ikAllValues];
     EditLimit:            63;
     AllEqualKind:         akOrd;
    ),

    (EditorClass:          TDCDsgnCharProperty;
     InfoKinds:            [ikGetValue,ikSetValue];
     GetValueKind:         akChar;
     SetValueKind:         akChar;
    ),

    (EditorClass:          TDCDsgnIntegerProperty;
     InfoKinds:            [ikGetValue,ikSetValue];
     GetValueKind:         akInt;
     SetValueKind:         akInt;
    ),

    (EditorClass:          TDCDsgnInt64Property;
     InfoKinds:            [ikEditLimit,ikAllValues,ikGetValue,ikSetValue];
     EditLimit:            63;
     AllEqualKind:         akInt64;
     GetValueKind:         akInt64;
     SetValueKind:         akInt64;
    ),

    (EditorClass:          TDCDsgnComponentProperty;
     InfoKinds:            [ikEditLimit,ikAllValues];
     EditLimit:            127;
     AllEqualKind:         akComponent;
    ),

    (EditorClass:          TDCDsgnStringProperty;
     InfoKinds:            [ikEditLimit,ikAllValues,ikGetValue,ikSetValue];
     EditLimitKind:        lkLimitAsStr;
     AllEqualKind:         akStr;
     GetValueKind:         akStr;
     SetValueKind:         akStr;
    )
  );

{------------------------------------}

function DCGetProcKindForClass(C:TDCDsgnPropertyEditorClass;
  ProcKind:TDCAccessKindsInPropEdit;var AccessKind:TDCPropAccessKind):boolean;
var
  Item:PDCDsgnPropEditParamRec;
begin
  Item:=DCFindPropEditParams(C,ProcKind);
  If Item<>nil then
    begin
      Result:=True;
      AccessKind:=Item.CallKinds[ProcKind];
    end
  else
    Result:=False;
end;

{------------------------------------}

procedure DCTestClassForProcKind(C:TDCDsgnPropertyEditorClass;
  ProcKind:TDCAccessKindsInPropEdit;UserData:Pointer);
var
  AccessKind:TDCPropAccessKind;
begin
  If DCGetProcKindForClass(C,ProcKind,AccessKind) then
    DCDumpInvalidProcAccessKinds(ProcKind,AccessKind,UserData);
end;

{------------------------------------}

procedure DCTestClassProperlyRegistered(C:TDCDsgnPropertyEditorClass;UserData:Pointer);
var
  i:TDCAccessKindsInPropEdit;
begin
  for i:=Low(TDCAccessKindsInPropEdit) to High(TDCAccessKindsInPropEdit) do
    DCTestClassForProcKind(C,i,UserData);
end;

{------------------------------------}

procedure DCTestProperlyRegistered;
const
  CDCTestForClasses:Array[0..30] of TDCDsgnPropertyEditorClass=(
    TDCDsgnPropertyEditor,
    TDCDsgnOrdinalProperty,
    TDCDsgnIntegerProperty,
    TDCDsgnCharProperty,
    TDCDsgnFloatProperty,
    TDCDsgnStringProperty,
    TDCDsgnEnumProperty,
    TDCDsgnInt64Property,
    TDCDsgnFontNameProperty,
    TDCDsgnFontCharsetProperty,
    TDCDsgnImeNameProperty,
    TDCDsgnBrushStyleProperty,
    TDCDsgnPenStyleProperty,
    TDCDsgnCursorProperty,
    TDCDsgnModalResultProperty,
    TDCDsgnShortCutProperty,
    TDCDsgnTabOrderProperty,
    TDCDsgnCaptionProperty,
    TDCDsgnComponentNameProperty,
    TDCDsgnDateProperty,
    TDCDsgnTimeProperty,
    TDCDsgnDateTimeProperty,
    TDCDsgnNestedProperty,
    TDCDsgnSetElementProperty,
    TDCDsgnSetProperty,
    TDCDsgnClassProperty,
    TDCDsgnMethodProperty,
    TDCDsgnComponentProperty,
    TDCDsgnColorProperty,
    TDCDsgnFontProperty,
    TDCDsgnMPFilenameProperty
  );

var
  i        : Integer;
  UserData : Pointer;
begin

  UserData:=DCCreateTestInstPropList;

  for i:=Low(CDCTestForClasses) to High(CDCTestForClasses) do
    DCTestClassProperlyRegistered(CDCTestForClasses[i],UserData);

  DCDumpProcUsage(UserData);
end;

{------------------------------------}

function DCFindPropEditParams(EditorClass:TDCDsgnPropertyEditorClass;
  RequiredInfo:TDCDsgnPropEditParamInfoKind):PDCDsgnPropEditParamRec;
var
  i:Integer;
  BestParent:TDCDsgnPropertyEditorClass;

  function ClassIsOk:boolean;
  var
    TryClass:TDCDsgnPropertyEditorClass;
  begin
    TryClass:=CDCPropEditParams[i].EditorClass;
    Result:=TryClass=EditorClass;
    If not Result then
      If EditorClass.InheritsFrom(TryClass) then
      begin
        If (BestParent=nil) or (TryClass.InheritsFrom(BestParent)) then
          Result:=True;
      end;
    If Result then
      BestParent:=TryClass;
  end;

begin
{
  If EditorClass.InheritsFrom(TDCDSgnCaptionProperty) then
    asm nop end;
}
  BestParent:=nil;
  Result:=nil;
  for i:=Low(CDCPropEditParams) to High(CDCPropEditParams) do
    if (RequiredInfo in CDCPropEditParams[i].InfoKinds) then
      If ClassIsOk then //should be after check of required info
      begin
        Result:=@CDCPropEditParams[i];
        If CDCPropEditParams[i].EditorClass=EditorClass then
          exit;
      end;
{
  If BestParent<>nil then
    DoWriteToLog(EditorClass.ClassName+'-->'+Result.EditorClass.ClassName+'  in '+DCErrorAccessKindToStr(RequiredInfo));
}
end;

{------------------------------------}

function DCGetStdPropAttrs(Editor:TDCDsgnPropertyEditor):TDCDsgnPropertyAttributes;
var
  Item:PDCDsgnPropEditParamRec;
begin
  Item:=DCFindPropEditParams(TDCDsgnPropertyEditorClass(Editor.ClassType),ikPropAttrs);
  If Item<>nil then
    Result:=Item.PropAttrs
  else
    Result:=CDCDefaultPropAttrs;
end;

{------------------------------------}

function DCGetAllEqualKind(Editor:TDCDsgnPropertyEditor):TDCPropAccessKind;
var
  Item:PDCDsgnPropEditParamRec;
begin
  Item:=DCFindPropEditParams(TDCDsgnPropertyEditorClass(Editor.ClassType),ikAllValues);
  If Item<>nil then
    Result:=Item.AllEqualKind
  else
    Result:=akDefault;
end;

{------------------------------------}

procedure DCGetStdPropEditLimit(Editor:TDCDsgnPropertyEditor;
  var EditLimitKind:TDCEditLimitKind;var EditLimit:Integer;Search:boolean);
var
  Item:PDCDsgnPropEditParamRec;
begin
  If Search then
  begin
    Item:=DCFindPropEditParams(TDCDsgnPropertyEditorClass(Editor.ClassType),ikEditLimit);
    If Item<>nil then
      begin
        EditLimitKind:=Item.EditLimitKind;
        EditLimit:=Item.EditLimit;
      end
    else
      begin
        EditLimitKind:=lkLimitByValue;
        EditLimit:=255;
        exit;
      end;
  end;

  case EditLimitKind of
    lkLimitAsStr:
      With Editor do
        if GetPropType^.Kind=tkString then
          EditLimit:=GetTypeData(GetPropType)^.MaxLength
        else
          EditLimit:=255;
    else
      If EditLimit=0 then
        EditLimit:=255;
  end;

end;

{------------------------------------}

function DCCreateSelectionList:IDCDsgnDesignerSelections;
begin
  Result:=TDCPersistentList.Create;
end;

{------------------------------------}

var
  DCGroupNotifyList:TList;
  DCEditorGroupList:TBits;

function DCNewEditorGroup:Integer;
begin
  if DCEditorGroupList=nil then
    DCEditorGroupList:=TBits.Create;
  CurrentGroup:=DCEditorGroupList.OpenBit;
  DCEditorGroupList[CurrentGroup]:=True;
  Result:=CurrentGroup;
end;

{------------------------------------}

procedure DCNotifyGroupChange(AProc:TDCGroupChangeProc);
begin
  DCUnnotifyGroupChange(AProc);
  if not Assigned(DCGroupNotifyList) then
    DCGroupNotifyList:=TList.Create;
  DCGroupNotifyList.Add(@AProc);
end;

{------------------------------------}

procedure DCUnnotifyGroupChange(AProc:TDCGroupChangeProc);
begin
  if Assigned(DCGroupNotifyList) then
    DCGroupNotifyList.Remove(@AProc);
end;

{-----------------------------------------------------------}

const
  DCDsgnPropClassMap: array[TypInfo.TTypeKind] of TDCDsgnPropertyEditorClass = (
    nil,                      // tkUnknown
    TDCDsgnIntegerProperty,   // tkInteger
    TDCDsgnCharProperty,      // tkChar
    TDCDsgnEnumProperty,      // tkEnumeration
    TDCDsgnFloatProperty,     // tkFloat
    TDCDsgnStringProperty,    // tkString
    TDCDsgnSetProperty,       // tkSet
    TDCDsgnClassProperty,     // tkClass
    TDCDsgnMethodProperty,    // tkMethod
    TDCDsgnPropertyEditor,    // tkWChar
    TDCDsgnStringProperty,    // tkLString
    TDCDsgnStringProperty,    // tkWString
    TDCVariantProperty,       // tkVariant
    nil,                      // tkArray
    nil,                      // tkRecord
    nil,                      // tkInterface
    TDCDsgnInt64Property,     // tkInt64
    nil);                     // tkDynArray

{-----------------------------------------------------------}
type
  PPropEditorRec = ^TPropEditorRec;
  TPropEditorRec = record
    PropType    : PTypeInfo;
    EditorGroup : integer;
    PropName    : string;
    EClass      : TDCDsgnPropertyEditorClass;
  end;

  TClassItem = class
  private
    Editors : TList;
  public
    tClass : TClass;

    constructor Create;
    destructor  Destroy; override;
    procedure DeleteEditors(EditorGroup:Integer);
  end;

  TPropEditorsList = class(TSortedKeyList)
  protected
    function KeyByItem(Item : Pointer) : Pointer; override;
    procedure DeleteEditors(EditorGroup:Integer);
  end;

{-----------------------------------------------------------}

procedure TClassItem.DeleteEditors(EditorGroup:Integer);
var
  i:Integer;
begin
  for i:=Editors.Count-1 downto 0 do
    if PPropEditorRec(Editors.Items[i]).EditorGroup=EditorGroup then
    begin
      Dispose(PPropEditorRec(Editors.Items[i]));
      Editors.Delete(i);
    end;
end;

{-----------------------------------------------------------}

procedure TPropEditorsList.DeleteEditors(EditorGroup:Integer);
var
  i:Integer;
begin
  for i:=Count-1 downto 0 do
  begin
    TClassItem(items[i]).DeleteEditors(EditorGroup);
    if TClassItem(items[i]).Editors.Count=0 then
      Delete(i);
  end;
end;

{-----------------------------------------------------------}

var
  PropEditors  : TPropEditorsList;

(*
function GetEditorClass(PropInfo: PPropInfo; Obj: TPersistent): TDCDsgnPropertyEditorClass;
var
  IsClassProp : boolean;
  BestClassType : TClass;

  function BetterChoice(Candidate, Best : PPropEditorRec) : boolean;
  begin
    result := true;

    if (Best = nil) then
      exit;

    if (Best.PropName = '') and (Candidate.PropName <> '') then
      exit;

    if IsClassProp and GetTypeData(Candidate^.PropType)^.ClassType.InheritsFrom(BestClassType) then
      exit;

    result := false;
  end;

var
  cItem    : TClassItem;
  i        : integer;
  erec     : PPropEditorRec;
  best     : PPropEditorRec;
  ObjClass : TClass;
  pType    : PTypeInfo;
{
  APropName : String;
}
begin
  result := nil;
  if PropEditors = nil then
    exit;

  pType := PropInfo^.PropType^;
  ObjClass := Obj.ClassType;
  best := nil;
  IsClassProp := pType.Kind = tkClass;

  repeat
    cItem := PropEditors.ItemByKey(ObjClass);
    if cItem <> nil then
      begin
        for i := cItem.Editors.Count - 1 downto 0 do
          begin
            erec := cItem.Editors[i];
{
            APropName:=PropInfo.Name;

            If APropName='Action' then
              asm nop end;
}
            if (erec.PropType = pType) and ((erec.PropName = '') or SameText(erec.PropName, PropInfo^.Name)) then
              if BetterChoice(erec, best) then
                begin
                  best := erec;
                  if IsClassProp then
                    BestClassType := GetTypeData(best.PropType)^.ClassType;                  
                end;
          end;
      end;

    if ObjClass = nil then
      break;

    ObjClass := ObjClass.ClassParent;
  until false;

  if Best = nil then
    result := DCDsgnPropClassMap[PropInfo.PropType^.Kind]
  else
    result := Best.EClass;
end;
*)

function GetEditorClass(PropInfo: PPropInfo; Obj: TPersistent):TDCDsgnPropertyEditorClass;
var
  IsClassProp : boolean;
  BestClassType : TClass;

  function BetterChoice(Candidate, Best : PPropEditorRec) : boolean;
  var
    CandidateClassType:TClass;
  begin
    result := true;

    if (Best = nil) then
      exit;

    if (Best.PropName = '') and (Candidate.PropName <> '') then
      exit;

    CandidateClassType:=GetTypeData(Candidate^.PropType)^.ClassType;

    {$IFDEF DEBUG}
    If CandidateClassType=TStrings then
      asm nop end;
    {$ENDIF}

    if IsClassProp and (CandidateClassType<>BestClassType) and
      CandidateClassType.InheritsFrom(BestClassType)
    then
      exit;

    result := false;
  end;

var
  cItem    : TClassItem;
  i        : integer;
  erec     : PPropEditorRec;
  best     : PPropEditorRec;
  ObjClass : TClass;
  pType    : PTypeInfo;
  PropClassType : TClass;
begin
  {$IFDEF DEBUG}
  if PropInfo.Name='Items' then
    asm nop end;
  {$ENDIF}

  result := nil;
  if PropEditors = nil then
    exit;

  pType := PropInfo^.PropType^;
  ObjClass := Obj.ClassType;
  best := nil;
  IsClassProp := pType.Kind = tkClass;
  PropClassType := nil;
  if IsClassProp then
    PropClassType := GetTypeData(ptype).ClassType;

  repeat
    cItem := PropEditors.ItemByKey(ObjClass);
    if cItem <> nil then
      begin
        for i := cItem.Editors.Count - 1 downto 0 do
          begin
            erec := cItem.Editors[i];
            if
              (
              (erec.PropType = pType)
              or
              (IsClassProp and (erec.PropType.Kind = tkClass) and
               PropClassType.InheritsFrom(GetTypeData(erec^.PropType)^.ClassType))
              )
              and
              ((erec.PropName = '') or SameText(erec.PropName,PropInfo^.Name))
            then
              if BetterChoice(erec, best) then
                begin
                  best := erec;
                  if IsClassProp then
                    BestClassType := GetTypeData(best.PropType)^.ClassType;
                end;
          end;
      end;

    if ObjClass = nil then
      break;

    ObjClass := ObjClass.ClassParent;
    
  until false;

  if Best = nil then
    result := DCDsgnPropClassMap[PropInfo.PropType^.Kind]
  else
    result := Best.EClass;
end;

{-----------------------------------------------------------}

procedure DCRegisterPropertyEditor(PropertyType: PTypeInfo; ComponentClass: TClass;
  const PropertyName: string; EditorClass: TDCDsgnPropertyEditorClass);
var
  cItem  : TClassItem;
  erec   : PPropEditorRec;
begin
  if PropertyType = nil then
    exit;

  if PropEditors = nil then
    PropEditors := TPropEditorsList.Create;

  cItem := PropEditors.ItemByKey(ComponentClass);
  if cItem = nil then
    begin
      cItem := TClassItem.Create;
      cItem.tClass := ComponentClass;
      PropEditors.Add(cItem);
    end;

  New(erec);
  erec.PropType := PropertyType;
  erec.EditorGroup := CurrentGroup;
  erec.PropName := PropertyName;
  erec.EClass := EditorClass;
  cItem.Editors.Add(erec);
end;

{-----------------------------------------------------------}

constructor TClassItem.Create;
begin
  inherited;
  Editors := TList.Create;
end;

{-----------------------------------------------------------}

destructor TClassItem.Destroy;
var
  i : integer;
begin
  for i := 0 to Editors.Count - 1 do
    Dispose(Editors[i]);

  Editors.Free;
  inherited;
end;

{-----------------------------------------------------------}

function TPropEditorsList.KeyByItem(Item: Pointer): Pointer;
begin
  result := TClassItem(Item).tClass;
end;

{-----------------------------------------------------------}

procedure FillPropInfos(const Components : IDCDsgnDesignerSelections; Filter: TTypeKinds; PropInfos : TList);
var
  i     : integer;
  cinfo : PTypeInfo;
  plist : TList;
begin
  for i := 0 to Components.Count - 1 do
    begin
      plist := TList.Create;
      cinfo := Components[i].ClassInfo;
      plist.Count := GetTypeData(cinfo)^.PropCount;
      plist.Count := GetPropList(cinfo, Filter, PPropList(plist.List));
      PropInfos.Add(plist);
    end;
end;

{-----------------------------------------------------------}

function FindPropInSortedPropList(plist : TList; const PropName : string) : boolean;
var
  L : integer;
  H : integer;
  I : integer;
  C : integer;
begin
  Result := False;
  L := 0;
  H := plist.Count - 1;
  while L <= H do
    begin
      I := (L + H) div 2;
      C := CompareText(PPropInfo(plist.List[I]).Name, PropName);
      if C < 0 then
        L := I + 1
      else
        begin
          if C = 0 then
            begin
              Result := True;
              exit;
            end;
          H := I - 1;
        end;
    end;
end;

{-----------------------------------------------------------}

procedure RemoveUnique(l1, l2 : TList);
var
  i     : integer;
  pname : string;
begin
  for i := l1.Count - 1 downto 0 do
    begin
      pname := PPropInfo(l1[i]).Name;
      if not FindPropInSortedPropList(l2, pname) then
        l1.Delete(i);
    end;
end;

{-----------------------------------------------------------}
type
  TPropertyEditor = class(TDCDsgnPropertyEditor);

procedure DCGetComponentProperties(const Components: IDCDsgnDesignerSelections;
  Filter: TTypeKinds; const Designer: IDCDsgnDesigner; Proc: TDCDsgnGetPropProc;
  EditorFilterFunc: TDCDsgnPropertyEditorFilterFunc = nil);

var
  PropInfos : TList;

{$IFDEF DEBUG}
  procedure DebugProc(const Prop:IDCDsgnProperty);
  var
    EditorClassName:String;
    DsgnGetImplement:IDCDsgnImplementation;
  begin
    If Supports(Prop,IDCDsgnImplementation,DsgnGetImplement) then
      EditorClassName:=DsgnGetImplement.GetInstance.Classname
    else
      EditorClassName:='Unknown';

    DoWriteToLog(Prop.GetName+' '+EditorClassName);
  end;
{$ENDIF}

  procedure CreateEditor(EditorClass : TDCDsgnPropertyEditorClass; PropIndex : integer);
  var
    Editor  : TDCDsgnPropertyEditor;
    iEditor : IDCDsgnProperty;
    i       : integer;
    cCount  : integer;
    DsgnImplementation:IDCDsgnImplementation;
  begin
    cCount  := Components.Count;
    iEditor := EditorClass.Create(Designer, cCount);

    Supports(IEditor,IDCDsgnImplementation,DsgnImplementation);
    Editor:=TDCDsgnPropertyEditor(DsgnImplementation.GetInstance);

    for i := 0 to cCount - 1 do
      TPropertyEditor(Editor).SetPropEntry(i, Components[i], TList(PropInfos[i])[PropIndex]);
    TPropertyEditor(Editor).Initialize;

    if ((cCount > 1) and not (spaMultiSelect in iEditor.GetAttributes)) or
       not iEditor.ValueAvailable or
       (Assigned(EditorFilterFunc) and not EditorFilterFunc(iEditor)) then
        exit;

{$IFDEF DEBUG}
    DebugProc(iEditor);
{$ENDIF}
    Proc(iEditor);
  end;

var
  i         : integer;
  k         : integer;
  l1        : TList;
  EdClass   : TDCDsgnPropertyEditorClass;
begin
  PropInfos := TList.Create;
  try
    FillPropInfos(Components, Filter, PropInfos);

    l1 := PropInfos[0];

    if Components.Count > 1 then
      begin
        for i := 1 to PropInfos.Count - 1 do
          RemoveUnique(l1, PropInfos[i]);

        for i := 1 to PropInfos.Count - 1 do
          RemoveUnique(PropInfos[i], l1);
      end;

    for i := l1.Count - 1 downto 0 do
      begin
        EdClass := GetEditorClass(l1[i], Components[0]);
        for k := 1 to PropInfos.Count - 1 do
        begin
          if GetEditorClass(TList(PropInfos[k])[i], Components[k]) <> EdClass then
            continue;
        end;

        If EdClass<>nil then
          CreateEditor(EdClass, i);
      end;

  finally
    for i := 0 to PropInfos.Count - 1 do
      TList(PropInfos[i]).Free;

    PropInfos.Free;
  end;
end;

{-----------------------------------------------------------}

procedure DeletePropertyClasses(Group:Integer);
begin
  if PropEditors<>nil then
    PropEditors.DeleteEditors(Group);
end;

{-----------------------------------------------------------}

type
  PComponentEditorRec = ^TComponentEditorRec;
  TComponentEditorRec = record
    EditorGroup : integer;
    EClass      : TDCDsgnComponentEditorClass;
  end;

  TComponentItem = class
  public
    CClass  : TComponentClass;
    Editors : TRecordList;

    constructor Create;
    procedure DeleteEditors(EditorGroup:Integer);
    destructor  Destroy; override;
  end;

  TComponentEditorsList = class(TSortedKeyList)
  protected
    function KeyByItem(Item : Pointer) : Pointer; override;
    procedure DeleteEditors(EditorGroup:Integer);
  end;

{-----------------------------------------------------------}

var
  ComponentEditors : TComponentEditorsList;

{-----------------------------------------------------------}

procedure TComponentItem.DeleteEditors(EditorGroup:Integer);
var
  i:Integer;
begin
  for i:=Editors.Count-1 downto 0 do
    if PComponentEditorRec(Editors[i]).EditorGroup=EditorGroup then
      Editors.Delete(i);
end;

{-----------------------------------------------------------}

procedure TComponentEditorsList.DeleteEditors(EditorGroup:Integer);
var
  i:Integer;
begin
  for i:=Count-1 downto 0 do
    With TComponentItem(Items[i]) do
    begin
      DeleteEditors(EditorGroup);
      If Editors.Count=0 then
        Self.Delete(i);
    end;
end;

{-----------------------------------------------------------}

procedure DeleteComponentClasses(Group:Integer);
begin
  If ComponentEditors<>nil then
    ComponentEditors.DeleteEditors(Group);
end;

{-----------------------------------------------------------}

function TComponentEditorsList.KeyByItem(Item: Pointer): Pointer;
begin
  result := TComponentItem(Item).CClass;
end;

{-----------------------------------------------------------}

procedure DCRegisterComponentEditor(ComponentClass: TComponentClass;
  ComponentEditor: TDCDsgnComponentEditorClass);
var
  cItem : TComponentItem;
  eRec  : TComponentEditorRec;
begin
  if ComponentEditors = nil then
    ComponentEditors := TComponentEditorsList.Create;

  cItem := ComponentEditors.ItemByKey(ComponentClass);
  if cItem = nil then
    begin
      cItem := TComponentItem.Create;
      cItem.CClass := ComponentClass;
    end;

  eRec.EditorGroup := CurrentGroup;
  eRec.EClass := ComponentEditor;
  cItem.Editors.Add(@eRec);
  ComponentEditors.Add(cItem);
end;

{-----------------------------------------------------------}

function DCGetComponentEditor(Component: TComponent;
  const Designer: IDCDsgnDesigner): IDCDsgnComponentEditor;
var
  CompClass   : TClass;
  cItem       : TComponentItem;
  pEditorRec  : PComponentEditorRec;
  EditorClass : TDCDsgnComponentEditorClass;
begin
  result := nil;

  if (Component = nil) or (ComponentEditors = nil) then
    exit;

  EditorClass := TDCDsgnDefaultEditor;
  CompClass := Component.ClassType;

  repeat
      cItem := ComponentEditors.ItemByKey(CompClass);
      if cItem <> nil then
        begin
          pEditorRec := cItem.Editors[cItem.Editors.Count - 1];
          EditorClass := pEditorRec.EClass;
          break;
        end;

      CompClass := CompClass.ClassParent;
  until CompClass = nil;

  result := EditorClass.Create(Component, Designer);
end;

{-----------------------------------------------------------}

constructor TComponentItem.Create;
begin
  inherited;
  Editors := TRecordList.Create(SizeOf(TComponentEditorRec));
end;

{-----------------------------------------------------------}

destructor TComponentItem.Destroy;
begin
  Editors.Free;
  inherited;
end;

{------------------------------------------------------------------}

type
  PDCDsgnPropertyMapperRec=^TDCDsgnPropertyMapperRec;
  TDCDsgnPropertyMapperRec=record
    Group:Integer;
    Mapper:TDCDsgnPropertyMapperFunc;
  end;

var
  PropertyMapperList:TRecordList;

procedure DeletePropertyMappers(Group:Integer);
var
  M:PDCDsgnPropertyMapperRec;
  I:Integer;
begin
  if PropertyMapperList<>nil then
    for I:=PropertyMapperList.Count-1 downto 0 do
    begin
      M:=PropertyMapperList[I];
      if M.Group=Group then
        PropertyMapperList.Delete(I);
    end;
end;

{------------------------------------------------------------------}

procedure DCRegisterPropertyMapper(Mapper:TDCDsgnPropertyMapperFunc);
var
  P:PDCDsgnPropertyMapperRec;
begin
  if PropertyMapperList=nil then
    PropertyMapperList:=TRecordList.Create(SizeOf(TDCDsgnPropertyMapperRec));
  P:=PropertyMapperList[PropertyMapperList.Add(nil)];
  P^.Group:=CurrentGroup;
  P^.Mapper:=Mapper;
end;

{------------------------------------------------------------------}

procedure NotifyGroupNotifyList(Group:Integer);
var
  I:Integer;
begin
  if Assigned(DCGroupNotifyList) then
    for I:=DCGroupNotifyList.Count - 1 downto 0 do
      TDCGroupChangeProc(DCGroupNotifyList[I])(Group);
end;

{------------------------------------------------------------------}

procedure DCFreeEditorGroup(Group:Integer);
begin
  DeletePropertyClasses(Group);
  DeleteComponentClasses(Group);
  DeletePropertyMappers(Group);
  NotifyGroupNotifyList(Group);
  if (Group>=0) and (Group<DCEditorGroupList.Size) then
    DCEditorGroupList[Group]:=False;
end;

{------------------}

function TDCDsgnPropertyEditor.GetIntfImplementer:TObject;
begin
  Result:=Self;
end;

{------------------}

function TDCDsgnPropertyEditor.GetElement:Integer;
begin
  Result:=FProperties.GetElement;
end;

{------------------}

function TDCDsgnPropertyEditor.GetPropCount:Integer;
begin
  Result:=FProperties.Count;
end;

{------------------}

function TDCDsgnPropertyEditor.GetInstance:TObject;
begin
  Result:=Self;
end;

{------------------}

constructor TDCDsgnPropertyEditor.Create(const ADesigner:IDCDsgnDesigner;
  APropCount,AElement:Integer);
var
  DCSetDesigner:IDCSetDCDesigner;
begin
  inherited Create;
  FDesigner:=ADesigner;
  FProperties:=DCCreateInstPropList(APropCount,AElement);
  If Supports(FProperties,IDCSetDCDesigner,DCSetDesigner) then
    DCSetDesigner.SetDCDesigner(ADesigner);
end;

{------------------}

destructor TDCDsgnPropertyEditor.Destroy;
begin
end;

{------------------}

procedure TDCDsgnPropertyEditor.Activate;
begin
end;

{------------------}

function TDCDsgnPropertyEditor.AllEqual:Boolean;
var
  CompareKind:TDCPropAccessKind;
begin
  If ikAllValues in FLoadedInfo.InfoKinds then
    CompareKind:=FLoadedInfo.AllEqualKind
  else
    begin
      CompareKind:=DCGetAllEqualKind(Self);
      FLoadedInfo.AllEqualKind:=CompareKind;
      FLoadedInfo.InfoKinds:=FLoadedInfo.InfoKinds+[ikAllValues];
    end;

  Result:=FProperties.AllEqual(CompareKind);
end;

{------------------------------------}

procedure TDCDsgnPropertyEditor.EditAsDefault;
var
  I:Integer;
  Values:TStringList;
  AddValue:TDCGetStrFunc;
begin
  if not AutoFill then
    Exit;
  Values:=TStringList.Create;
  Values.Sorted:=spaSortList in GetAttributes;
  try
    AddValue:=Values.Add;
    GetValues(TGetStrProc(AddValue));
    if Values.Count>0 then
    begin
      I:=Values.IndexOf(Value)+1;
      if I=Values.Count then
        I:=0;
      Value:=Values[I];
    end;
  finally
    Values.Free;
  end;
end;

{------------------}

procedure TDCDsgnPropertyEditor.Edit;
var
  AccessKind:TDCPropAccessKind;
begin
  AccessKind:=GetPropAccessKind(ikEdit);
  If not (AccessKind in [akInvalid]) then
  begin
    If AccessKind=akDefault then
      EditAsDefault
    else
      FProperties.Edit(AccessKind);
  end;
end;

{------------------}

function TDCDsgnPropertyEditor.AutoFill:Boolean;
begin
  Result:=Assigned(GetPropInfo^.SetProc);
end;

{------------------}

function TDCDsgnPropertyEditor.GetAttributes:TDCDsgnPropertyAttributes;
begin
  If ikPropAttrs in FLoadedInfo.InfoKinds then
    Result:=FLoadedInfo.PropAttrs
  else
    begin
      Result:=DCGetStdPropAttrs(Self);
      FLoadedInfo.PropAttrs:=Result;
      FLoadedInfo.InfoKinds:=FLoadedInfo.InfoKinds+[ikPropAttrs];
    end;
end;

{------------------}

function TDCDsgnPropertyEditor.GetComponent(Index:Integer):TPersistent;
begin
  Result:=FProperties[Index].Instance;
end;

{------------------}

function TDCDsgnPropertyEditor.GetFloatValue:Extended;
begin
  Result:=GetFloatValueAt(0);
end;

{------------------}

function TDCDsgnPropertyEditor.GetFloatValueAt(Index:Integer):Extended;
begin
  FProperties.GetValueAt(akFloat,Index,Result);
end;

{------------------}

function TDCDsgnPropertyEditor.GetMethodValue:TMethod;
begin
  Result:=GetMethodValueAt(0);
end;

{------------------}

function TDCDsgnPropertyEditor.GetMethodValueAt(Index:Integer):TMethod;
begin
  FProperties.GetValueAt(akMethod,Index,Result);
end;

{------------------}

function TDCDsgnPropertyEditor.GetEditLimit:Integer;
begin
  With FLoadedInfo do
  begin
    DCGetStdPropEditLimit(Self,EditLimitKind,EditLimit,not (ikEditLimit in InfoKinds));
    FLoadedInfo.InfoKinds:=FLoadedInfo.InfoKinds+[ikEditLimit];
    Result:=EditLimit;
  end;
end;

{------------------}

function TDCDsgnPropertyEditor.GetName:string;
begin
  Result:=FProperties.GetName;
end;

{------------------}

function TDCDsgnPropertyEditor.GetOrdValue:Longint;
begin
  Result:=GetOrdValueAt(0);
end;

{------------------}

function TDCDsgnPropertyEditor.GetOrdValueAt(Index:Integer):Longint;
begin
  FProperties.GetValueAt(akOrd,Index,Result);
end;

{------------------}

function TDCDsgnPropertyEditor.GetPrivateDirectory:string;
begin
  if Designer<>nil then
    Result:=Designer.GetPrivateDirectory
  else
    Result:='';
end;

{------------------}

procedure TDCDsgnPropertyEditor.GetProperties(Proc:TDCDsgnGetPropProc);
begin
end;

{------------------}

function TDCDsgnPropertyEditor.GetPropInfo:PPropInfo;
begin
  Result:=FProperties[0].PropInfo;
end;

{------------------}

function TDCDsgnPropertyEditor.GetPropType:PTypeInfo;
begin
  Result:=FProperties[0].PropInfo^.PropType^;
end;

{------------------}

function TDCDsgnPropertyEditor.GetStrValue:string;
begin
  Result:=GetStrValueAt(0);
end;

{------------------}

function TDCDsgnPropertyEditor.GetStrValueAt(Index:Integer):string;
begin
  FProperties.GetValueAt(akStr,Index,Result);
end;

{------------------}

function TDCDsgnPropertyEditor.GetVarValue:Variant;
begin
  Result:=GetVarValueAt(0);
end;

{------------------}

function TDCDsgnPropertyEditor.GetVarValueAt(Index:Integer):Variant;
begin
  FProperties.GetValueAt(akVar,Index,Result);
end;

{------------------}

function TDCDsgnPropertyEditor.GetVisualValue:string;
begin
  if AllEqual then
    Result:=GetValue
  else
    Result:='';
end;

{------------------}

procedure TDCDsgnPropertyEditor.Initialize;
begin
end;

{------------------}

procedure TDCDsgnPropertyEditor.Modified;
begin
  if Designer<>nil then
    Designer.Modified;
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetFloatValue(Value:Extended);
begin
  FProperties.SetValueByDataPtr(akFloat,@Value);
  Modified;
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetMethodValue(const Value:TMethod);
begin
  FProperties.SetValueByDataPtr(akMethod,@Value);
  Modified;
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetOrdValue(Value:Longint);
begin
  FProperties.SetValueByDataPtr(akOrd,@Value);
  Modified;
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetPropEntry(Index:Integer;
  AInstance:TPersistent;APropInfo:PPropInfo);
var
  Item:TDCInstPropItem;
begin
  with Item do
  begin
    Instance:=AInstance;
    PropInfo:=APropInfo;
  end;
  FProperties.Items[Index]:=Item;
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetStrValue(const Value:string);
begin
  FProperties.SetValueByDataPtr(akStr,@Value);
  Modified;
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetVarValue(const Value:Variant);
begin
  FProperties.SetValueByDataPtr(akVar,@Value);
  Modified;
end;

{------------------}

procedure TDCDsgnPropertyEditor.Revert;
var
  I:Integer;
begin
  if Designer<>nil then
    for I:=0 to PropCount - 1 do
      with FProperties[I] do
        Designer.Revert(Instance,PropInfo);
end;

{------------------}

function TDCDsgnPropertyEditor.GetPropAccessKind(
  AKind:TDCAccessKindsInPropEdit):TDCPropAccessKind;
var
  AccessKindFound:boolean;
begin
  If AKind in FLoadedInfo.InfoKinds then
    Result:=FLoadedInfo.CallKinds[AKind]
  else
    begin
      AccessKindFound:=DCGetProcKindForClass(
        TDCDsgnPropertyEditorClass(Self.ClassType),AKind,Result);
      If not AccessKindFound then
        Result:=akInvalid;
      FLoadedInfo.CallKinds[AKind]:=Result;
      FLoadedInfo.InfoKinds:=FLoadedInfo.InfoKinds+[AKind];
    end;
end;

{------------------}

procedure TDCDsgnPropertyEditor.GetValues(Proc:TGetStrProc);
var
  AccessKind:TDCPropAccessKind;
begin
  AccessKind:=GetPropAccessKind(ikGetValues);
  If not (AccessKind in [akInvalid,akDefault]) then
    FProperties.GetValues(Proc,AccessKind);
end;

{------------------}

function TDCDsgnPropertyEditor.GetValue:string;
var
  AccessKind:TDCPropAccessKind;
begin
  AccessKind:=GetPropAccessKind(ikGetValue);
  If not (AccessKind in [akInvalid,akDefault]) then
    Result:=FProperties.GetValue(AccessKind)
  else
    Result:=srUnknown;
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetValue(const Value:string);
var
  AccessKind:TDCPropAccessKind;
begin
  AccessKind:=GetPropAccessKind(ikSetValue);
  If not (AccessKind in [akInvalid,akDefault]) then
    FProperties.SetValue(Value,AccessKind);
end;

{------------------}

function TDCDsgnPropertyEditor.ValueAvailable:Boolean;
var
  I:Integer;
  S:string;
begin
  Result:=True;
  for I:=0 to PropCount - 1 do
  begin
    if (FProperties[I].Instance is TComponent) and
      (csCheckPropAvail in TComponent(FProperties[I].Instance).ComponentStyle) then
    begin
      try
        S:=GetValue;
        AllEqual;
      except
        Result:=False;
      end;
      Exit;
    end;
  end;
end;

{------------------}

function TDCDsgnPropertyEditor.GetInt64Value:Int64;
begin
  Result:=GetInt64ValueAt(0);
end;

{------------------}

function TDCDsgnPropertyEditor.GetInt64ValueAt(Index:Integer):Int64;
begin
  FProperties.GetValueAt(akInt64,Index,Result);
end;

{------------------}

procedure TDCDsgnPropertyEditor.SetInt64Value(Value:Int64);
begin
  FProperties.SetValueByDataPtr(akInt64,@Value);
  Modified;
end;

{------------------}

function TDCDsgnPropertyEditor.GetEditValue(out Value:string):Boolean;
begin
  Result:=FProperties.GetEditValue(GetValue,Value);
end;

{------------------}

function TDCDsgnPropertyEditor.HasInstance(Instance:TPersistent):Boolean;
begin
  Result:=FProperties.HasInstance(Instance);
end;

{---------------------}

constructor TDCDsgnComponentEditor.Create(AComponent:TComponent;ADesigner:IDCDsgnDesigner);
begin
  inherited Create;
  FComponent:=AComponent;
  FDesigner:=ADesigner;
end;

{---------------------}

procedure TDCDsgnComponentEditor.Edit;
begin
  if GetVerbCount>0 then
    ExecuteVerb(0);
end;

{---------------------}

function TDCDsgnComponentEditor.GetComponent:TComponent;
begin
  Result:=FComponent;
end;

{---------------------}

function TDCDsgnComponentEditor.GetDesigner:IDCDsgnDesigner;
begin
  Result:=FDesigner;
end;

{---------------------}

function TDCDsgnComponentEditor.GetVerbCount:Integer;
begin
  Result:=0;
end;

{---------------------}

function TDCDsgnComponentEditor.GetVerb(Index:Integer):string;
begin
end;

{---------------------}

procedure TDCDsgnComponentEditor.ExecuteVerb(Index:Integer);
begin
end;

{---------------------}

procedure TDCDsgnComponentEditor.Copy;
begin
end;

{---------------------}

function TDCDsgnComponentEditor.IsInInlined:Boolean;
begin
  Result:=csInline in Component.Owner.ComponentState;
end;

{---------------------}

function DCInterfaceInheritsFrom(Child,Parent:PTypeData):Boolean;
begin
  while (Child<>nil) and (Child<>Parent) and (Child^.IntfParent<>nil) do
    Child:=GetTypeData(Child^.IntfParent^);
  Result:=(Child<>nil) and (Child=Parent);
end;

{-----------------------------------------------------------}

const
  cPreferredEventsCount = 3;
  PreferredEvents : array[0 .. cPreferredEventsCount - 1] of string =
(
 'OnClick',
 'OnChange',
 'OnCreate'
);

function GetPropEditPriority(const Prop: IDCDsgnProperty) : integer;
var
  i     : integer;
  pname : string;
begin
  pname := Prop.GetName;
  for i := 0 to cPreferredEventsCount - 1 do
    if SameText(pname, PreferredEvents[i]) then
      begin
        result := i;
        exit;
      end;

  result := -1;
end;

{-----------------------------------------------------------}

procedure TDCDsgnDefaultEditor.EditProperty(const PropertyEditor:IDCDsgnProperty;var Continue:Boolean);
begin
end;

{-----------------------------------------------------------}

procedure TDCDsgnDefaultEditor.GetPropEditForEditProperty(const Prop: IDCDsgnProperty);
begin
  If FContinue then
    EditProperty(Prop,FContinue);
end;

{-----------------------------------------------------------}

procedure TDCDsgnDefaultEditor.GetPropEdit(const Prop: IDCDsgnProperty);
var
  NewPriority : integer;
begin
  if Supports(Prop, IDCDsgnMethodProperty) then
    begin
      NewPriority := GetPropEditPriority(Prop);
      if fCurPriority < NewPriority then
        begin
          fEdit := Prop;
          fCurPriority := NewPriority;
        end;
    end;
end;

{-----------------------------------------------------------}

procedure TDCDsgnDefaultEditor.Edit;
var
  Components: IDCDsgnDesignerSelections;
begin
  Components := DCCreateSelectionList;
  Components.Add(Component);

  FContinue:=True;
  DCGetComponentProperties(Components, tkAny, Designer, GetPropEditForEditProperty);

  If not FContinue then
    exit;

  fEdit := nil;
  fCurPriority := -2;
  DCGetComponentProperties(Components, tkAny, Designer, GetPropEdit);
  if fEdit <> nil then
    try
      fEdit.Edit;
    finally
      fEdit := nil;
    end;
end;

{---------------------}

constructor TDCDsgnNestedProperty.Create(Parent:IDCDsgnProperty;AElement:Integer=0);
var
  A           : TDCDsgnPropertyEditor;
  Implementat : IDCDsgnImplementation;
begin
  If Supports(Parent,IDCDsgnImplementation,Implementat) then
    A:=Implementat.GetInstance as TDCDsgnPropertyEditor
  else
    raise Exception.Create('IDCDsgnImplementation is not supported');

  inherited Create(A.Designer,A.PropCount,AElement);
  FProperties.Assign(A.FProperties);
end;

{---------------------}

function TDCDsgnSetElementProperty.GetName:string;
begin
  Result:=GetEnumName(GetTypeData(GetPropType)^.CompType^,Element);
end;

{---------------------}

procedure TDCDsgnSetProperty.GetProperties(Proc:TDCDsgnGetPropProc);
var
  I:Integer;
begin
  with GetTypeData(GetTypeData(GetPropType)^.CompType^)^ do
    for I:=MinValue to MaxValue do
      Proc(TDCDsgnSetElementProperty.Create(Self,I));
end;

{---------------------}

procedure TDCDsgnClassProperty.GetProperties(Proc:TDCDsgnGetPropProc);
var
  I:Integer;
  J:Integer;
  Components:IDCDsgnDesignerSelections;
begin
  Components:=DCCreateSelectionList;
  for I:=0 to PropCount - 1 do
  begin
    J:=GetOrdValueAt(I);
    if J<>0 then
      Components.Add(TComponent(GetOrdValueAt(I)));
  end;
  if Components.Count > 0 then
    DCGetComponentProperties(Components,tkProperties,Designer,Proc);
end;

{---------------------}

procedure TDCDsgnComponentProperty.Edit;
var
  Temp:TComponent;
begin
  if (Designer.GetShiftState*ssCtrlAndLeft=ssCtrlAndLeft) then
  begin
    Temp:=GetComponentReference;
    if Temp<>nil then
      Designer.SelectComponent(Temp)
    else
      inherited Edit;
  end
  else
    inherited Edit;
end;

{---------------------}

function TDCDsgnComponentProperty.GetAttributes:TDCDsgnPropertyAttributes;
begin
  if Assigned(GetPropInfo^.SetProc) then
    Result:=[spaMultiSelect,spaValueList,spaSortList,spaRevertable]
  else
    Result:=[spaMultiSelect,spaReadOnly];
end;

{---------------------}

function TDCDsgnComponentProperty.GetValue:string;
begin
  Result:=Designer.GetComponentName(GetComponentReference);
end;

{---------------------}

procedure TDCDsgnComponentProperty.GetValues(Proc:TGetStrProc);
begin
  Designer.GetComponentNames(GetTypeData(GetPropType),Proc);
end;

{---------------------}

procedure TDCDsgnComponentProperty.SetValue(const Value:string);
var
  Component:TComponent;
begin
  if Value='' then
    Component:=nil
  else
    begin
      Component:=Designer.GetComponent(Value);
      if not (Component is GetTypeData(GetPropType)^.ClassType) then
        raise EPropertyError.Create(SInvalidPropertyValue);
    end;
  SetOrdValue(LongInt(Component));
end;

{---------------------}

function TDCDsgnComponentProperty.GetComponentReference:TComponent;
begin
  Result:=TComponent(GetOrdValue);
end;

{---------------------}

initialization
  CDCDefInstPropList:=TDCDesignerInstPropList;
{$IFDEF DEBUG_}
  DCTestProperlyRegistered;
{$ENDIF}
finalization
  FreeAndNil(DCGroupNotifyList);
  FreeAndNil(DCEditorGroupList);
  FreeObject(ComponentEditors,ComponentEditors);
  FreeObject(PropEditors,PropEditors);
  FreeObject(PropertyMapperList,PropertyMapperList);
{$ELSE}
implementation
begin
{$ENDIF}
end.
