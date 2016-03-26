unit ddAppConfig;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfig.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfig" MUID: (4B990EF000AA)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , ddAppConfigConst
 , ddAppConfigStrings
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vtOutliner
 , ddConfigStorages
 , l3ObjectList
 , ddAppConfigVersions
 , ddAppConfigWFrame
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , Graphics
 , ddAppConfigDataAdapters
 , l3NodesModelPart
 , l3Tree_TLB
;

type
 TddAppDialogOption = (
  dd_doNoButtons
 );//TddAppDialogOption

 TddAppDialogOptions = set of TddAppDialogOption;

 TddCaptionPanelType = (
  {* настройка вида панели названия узла }
  cptNormalBevel
   {* установить панели, с именем узла в дереве, BevelWidth = 1 }
 );//TddCaptionPanelType

 TddCaptionPanelTypes = set of TddCaptionPanelType;
  {* набор настроек вида панели }

 TddErrorShowEvent = procedure(aSender: TObject;
  const aMessage: AnsiString) of object;
  {* Cобытие вызываемое при исключительной ситуации.
       Параметры:
         aItem  - элемент с ошибкой.
         aFocus - устанавливаеть фокус в элементе с ошибкой. }

 TddAppRequiredEvent = procedure(aNode: TddCustomConfigNode;
  var Resolved: Boolean) of object;

 TddAppConfiguration = class(Tl3ProtoObject)
  private
   f_AliasNameIndex: Integer;
   f_ButtonsPanel: TCustomFrame;
   f_ConfigTree: TvtCustomOutliner;
   f_CurItem: TddBaseConfigItem;
   f_Dialog: TCustomForm;
   f_Root: TddAppConfigNode;
   f_Selected: TddCustomConfigNode;
   f_Storage: IddConfigStorage;
   f_Groups: Tl3ObjectList;
   f_IsNode: Boolean;
   f_LabelTop: Boolean;
   f_RequiredNode: TddCustomConfigNode;
   f_Versions: TddAppConfigVersionManager;
   f_WorkFrame: TWorkFrame;
   f_AutoSize: Boolean;
    {* Поле для свойства AutoSize }
   f_DialogCaption: AnsiString;
    {* Поле для свойства DialogCaption }
   f_DialogIndex: Integer;
    {* Поле для свойства DialogIndex }
   f_FontName: AnsiString;
    {* Поле для свойства FontName }
   f_Items: TStringList;
    {* Поле для свойства Items }
   f_SaveChanged: Boolean;
    {* Поле для свойства SaveChanged }
   f_OnErrorShow: TddErrorShowEvent;
    {* Поле для свойства OnErrorShow }
   f_OnRequiredEvent: TddAppRequiredEvent;
    {* Поле для свойства OnRequiredEvent }
   f_AutoSave: Boolean;
    {* Поле для свойства AutoSave }
   f_ButtonsPanelHeight: Integer;
    {* Поле для свойства ButtonsPanelHeight }
   f_DialogOptions: TddAppDialogOptions;
    {* Поле для свойства DialogOptions }
   f_FormMinWidth: Integer;
    {* Поле для свойства FormMinWidth }
   f_RequiredMessage: AnsiString;
    {* Поле для свойства RequiredMessage }
   f_UseNodeNames: Boolean;
    {* Поле для свойства UseNodeNames }
   f_UseScrollbars: Boolean;
    {* Поле для свойства UseScrollbars }
  private
   function AddChildNode(aNode: TddCustomConfigNode): TddCustomConfigNode;
   procedure AddNode(aNode: TddCustomConfigNode); overload;
   procedure CalculateConstants(theTree: TCustomFrame;
    theWork: TCustomFrame;
    theButtons: TCustomFrame);
   procedure CheckEnabledStatus;
   function CheckRequiredValues: Boolean;
   procedure CheckVersion(const aStorage: IddConfigStorage);
   procedure ClearControls;
   procedure CreateComponents(theTree: TvtCustomOutliner;
    theParent: TWinControl);
   procedure CreateTree(aTree: TddCustomConfigNode;
    theTree: TvtCustomOutliner);
   procedure RecalcFormSize(aForm: TCustomForm);
   procedure DoError(const aMessage: AnsiString;
    aItem: TddVisualConfigItem);
   procedure DoFocus(aItem: TddVisualConfigItem);
   procedure SetFontName;
   procedure WorkupChanged;
   procedure DialogCloseQuery(Sender: TObject;
    var CanClose: Boolean);
  protected
   function pm_GetAllowTest: Boolean;
   procedure pm_SetAllowTest(aValue: Boolean);
   function pm_GetAsBoolean(const Alias: AnsiString): Boolean;
   procedure pm_SetAsBoolean(const Alias: AnsiString;
    aValue: Boolean);
   function pm_GetAsDateTime(const Alias: AnsiString): TDateTime;
   procedure pm_SetAsDateTime(const Alias: AnsiString;
    aValue: TDateTime);
   function pm_GetAsInteger(const Alias: AnsiString): Integer;
   procedure pm_SetAsInteger(const Alias: AnsiString;
    aValue: Integer);
   function pm_GetAsObject(const Alias: AnsiString): TObject;
   procedure pm_SetAsObject(const Alias: AnsiString;
    aValue: TObject);
   function pm_GetAsString(const Alias: AnsiString): AnsiString;
   procedure pm_SetAsString(const Alias: AnsiString;
    const aValue: AnsiString);
   function pm_GetChanged: Boolean;
   procedure pm_SetChanged(aValue: Boolean);
   function pm_GetComboBoxStyle: TComboBoxStyle;
   procedure pm_SetComboBoxStyle(aValue: TComboBoxStyle);
   procedure pm_SetDialogCaption(const aValue: AnsiString);
   function pm_GetDialogIndex: Integer;
   procedure pm_SetDialogIndex(aValue: Integer);
   function pm_GetEnabled: Boolean;
   procedure pm_SetEnabled(aValue: Boolean);
   function pm_GetFilter: AnsiString;
   procedure pm_SetFilter(const aValue: AnsiString);
   function pm_GetHint: AnsiString;
   procedure pm_SetHint(const aValue: AnsiString);
   function pm_GetLabelTop: Boolean;
   procedure pm_SetLabelTop(aValue: Boolean);
   function pm_GetLastItem: TddBaseConfigItem;
   function pm_GetMaxValue: Integer;
   procedure pm_SetMaxValue(aValue: Integer);
   function pm_GetMinValue: Integer;
   procedure pm_SetMinValue(aValue: Integer);
   function pm_GetPasswordChar: AnsiChar;
   procedure pm_SetPasswordChar(aValue: AnsiChar);
   function pm_GetTestButtonCaption: AnsiString;
   procedure pm_SetTestButtonCaption(const aValue: AnsiString);
   function pm_GetValues(const Alias: AnsiString): TddConfigValue;
   procedure pm_SetValues(const Alias: AnsiString;
    const aValue: TddConfigValue);
   procedure pm_SetButtonsPanelHeight(aValue: Integer);
   function pm_GetColumns: Integer;
   procedure pm_SetColumns(aValue: Integer);
   procedure pm_SetFormMinWidth(aValue: Integer);
   function pm_GetHelpContext: Integer; virtual;
   procedure pm_SetHelpContext(aValue: Integer); virtual;
   function pm_GetIsEmpty(const Alias: AnsiString): Boolean;
   function pm_GetIsValid: Boolean;
   function pm_GetPathFill: TddFillType;
   procedure pm_SetPathFill(aValue: TddFillType);
   function pm_GetRequired: Boolean;
   procedure pm_SetRequired(aValue: Boolean);
   procedure pm_SetUseScrollbars(aValue: Boolean);
   function pm_GetVersion: Integer;
   procedure pm_SetVersion(aValue: Integer);
   function pm_GetButtonPlace: TddButtonPlace;
   procedure pm_SetButtonPlace(aValue: TddButtonPlace);
   function pm_GetIsChanged(const Alias: AnsiString): Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BeforeRelease; override;
   procedure ClearFields; override;
  public
   constructor Create(const aStorage: IddConfigStorage = nil); reintroduce;
   function FindNode(aItem: TddBaseConfigItem): TddCustomConfigNode;
   procedure Add(const aItemName: AnsiString);
   procedure AddAlias(const aAlias: AnsiString);
   function AddBooleanItem(const aAlias: Il3CString;
    const aCaption: Il3CString;
    aDefault: Boolean = False;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddButtonItem(const aCaption: AnsiString;
    aClick: TNotifyEvent;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   procedure AddCaptionElement(const aCaption: AnsiString;
    const aAliasPrefix: AnsiString = '');
   function AddChild(const aAlias: AnsiString;
    const aCaption: AnsiString): TddCustomConfigNode; overload;
   function AddChild(const aCaption: AnsiString): TddCustomConfigNode; overload;
   function AddColorItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefault: TColor = clBlack;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddComboBoxItem(const aAlias: Il3CString;
    const aCaption: Il3CString;
    aDefaultValue: Integer;
    const aValueMap: Il3ValueMap = nil;
    aMasterItem: TddBaseConfigItem = nil;
    aMasterIndex: Integer = -1): TddBaseConfigItem; overload;
   function AddComboBoxItem(const aAlias: Il3CString;
    const aCaption: Il3CString;
    const aDefaultValue: Il3CString;
    const aValueMap: Il3ValueMap = nil;
    aMasterItem: TddBaseConfigItem = nil;
    aMasterIndex: Integer = -1): TddBaseConfigItem; overload;
   function AddComboBoxItem(const aAlias: Il3CString;
    const aCaption: Il3CString;
    const aDefaultValue: TddConfigValue;
    const aValueMap: Il3ValueMap = nil;
    aMasterItem: TddBaseConfigItem = nil;
    aMasterIndex: Integer = -1): TddBaseConfigItem; overload;
   function AddDateItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefault: TDateTime = 0;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddFileNameItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefault: AnsiString = '';
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddFolderNameItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefault: AnsiString = '';
    aMasterItem: TddBaseConfigItem = nil;
    AllowProcessDir: Boolean = True): TddBaseConfigItem;
   function AddFontItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefault: TFont = nil;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddGroupItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem; overload;
   function AddIntegerItem(const aAlias: Il3CString;
    const aCaption: Il3CString;
    aDefault: Integer = 0;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddItem(aNode: TddCustomConfigNode;
    aItem: TddBaseConfigItem): TddBaseConfigItem; overload;
   function AddItem(aItem: TddBaseConfigItem): TddBaseConfigItem; overload;
   function AddListItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDataAdapter: TddBaseConfigDataAdapter;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddStringsItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   procedure AddMapValue(const aCaption: AnsiString;
    aValue: Integer);
   function AddNode(const aAlias: AnsiString;
    const aText: AnsiString): TddCustomConfigNode; overload;
   function AddRadioGroupItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefault: Integer = -1;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   {$If NOT Defined(Nemesis)}
   function AddSoundFileNameItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefault: AnsiString = '';
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   function AddTimeItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefault: TDateTime = 0;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   {$IfEnd} // NOT Defined(Nemesis)
   function AddStringItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefault: AnsiString = '';
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   function AddMasterSlaveItem(const Alias: AnsiString;
    const aCaption: AnsiString): TddBaseConfigItem;
   function AddCheckListItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefault: Integer = -1;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   procedure AddDivider(const aCaption: AnsiString);
   function AddGroupItem(const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem; overload;
   function AddContainerGroup(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   procedure AddVersionHandler(aFromVersion: Integer;
    aToVersion: Integer;
    aProc: Tdd_acVersionUpgradeProc);
   function AddSimpleListItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
   procedure CloseMasterSlaveItem;
   procedure AddUserNode(aNode: TddCustomConfigNode;
    AsChild: Boolean = False);
   procedure AdjustFormSize(aForm: TCustomForm;
    aOptions: TddAppDialogOptions);
   procedure ClearNode;
   procedure CloseChild;
   procedure CloseGroup;
   procedure MakeNodeVisible(aNode: TddCustomConfigNode);
   procedure FillDialog(aForm: TCustomForm;
    aOptions: TddAppDialogOptions = [];
    aCaptionPanelTypes: TddCaptionPanelTypes = []);
   function GetAliasName(const aAliasMask: AnsiString = 'AliasName'): AnsiString;
    {* Проверяет наличие элемента с указанным псевдонимом }
   function HasValue(const aAlias: AnsiString): Boolean; overload;
   function HasValue(const aAlias: AnsiString;
    out theItem: TddBaseConfigItem): Boolean; overload;
   procedure Load(const aStorage: IddConfigStorage = nil);
   function ReadValuesFromDialog(aRead: Boolean = True): Boolean;
   procedure ReloadDefault;
   procedure Save(const aStorage: IddConfigStorage = nil);
   function ShowDialog(const aCaption: AnsiString = '';
    aValidate: Boolean = False): Boolean;
   function ShowNodeDialog(const aAlias: AnsiString): Boolean;
   procedure SetReadOnly(aValue: Boolean);
  public
   property AllowTest: Boolean
    read pm_GetAllowTest
    write pm_SetAllowTest;
   property AsBoolean[const Alias: AnsiString]: Boolean
    read pm_GetAsBoolean
    write pm_SetAsBoolean;
   property AsDateTime[const Alias: AnsiString]: TDateTime
    read pm_GetAsDateTime
    write pm_SetAsDateTime;
   property AsInteger[const Alias: AnsiString]: Integer
    read pm_GetAsInteger
    write pm_SetAsInteger;
   property AsObject[const Alias: AnsiString]: TObject
    read pm_GetAsObject
    write pm_SetAsObject;
   property AsString[const Alias: AnsiString]: AnsiString
    read pm_GetAsString
    write pm_SetAsString;
   property AutoSize: Boolean
    read f_AutoSize
    write f_AutoSize;
   property Changed: Boolean
    read pm_GetChanged
    write pm_SetChanged;
   property ComboBoxStyle: TComboBoxStyle
    read pm_GetComboBoxStyle
    write pm_SetComboBoxStyle;
   property DialogCaption: AnsiString
    read f_DialogCaption
    write pm_SetDialogCaption;
   property DialogIndex: Integer
    read pm_GetDialogIndex
    write pm_SetDialogIndex;
   property Enabled: Boolean
    read pm_GetEnabled
    write pm_SetEnabled;
   property Filter: AnsiString
    read pm_GetFilter
    write pm_SetFilter;
   property FontName: AnsiString
    read f_FontName
    write f_FontName;
   property Hint: AnsiString
    read pm_GetHint
    write pm_SetHint;
   property Items: TStringList
    read f_Items;
   property LabelTop: Boolean
    read pm_GetLabelTop
    write pm_SetLabelTop;
   property LastItem: TddBaseConfigItem
    read pm_GetLastItem;
   property MaxValue: Integer
    read pm_GetMaxValue
    write pm_SetMaxValue;
   property MinValue: Integer
    read pm_GetMinValue
    write pm_SetMinValue;
   property PasswordChar: AnsiChar
    read pm_GetPasswordChar
    write pm_SetPasswordChar;
   property SaveChanged: Boolean
    read f_SaveChanged
    write f_SaveChanged;
   property TestButtonCaption: AnsiString
    read pm_GetTestButtonCaption
    write pm_SetTestButtonCaption;
   property Values[const Alias: AnsiString]: TddConfigValue
    read pm_GetValues
    write pm_SetValues;
   property OnErrorShow: TddErrorShowEvent
    read f_OnErrorShow
    write f_OnErrorShow;
   property OnRequiredEvent: TddAppRequiredEvent
    read f_OnRequiredEvent
    write f_OnRequiredEvent;
   property AutoSave: Boolean
    read f_AutoSave
    write f_AutoSave;
   property ButtonsPanelHeight: Integer
    read f_ButtonsPanelHeight
    write pm_SetButtonsPanelHeight;
   property Columns: Integer
    read pm_GetColumns
    write pm_SetColumns;
   property DialogOptions: TddAppDialogOptions
    read f_DialogOptions
    write f_DialogOptions;
   property FormMinWidth: Integer
    read f_FormMinWidth
    write pm_SetFormMinWidth;
   property HelpContext: Integer
    read pm_GetHelpContext
    write pm_SetHelpContext;
   property IsEmpty[const Alias: AnsiString]: Boolean
    read pm_GetIsEmpty;
   property IsValid: Boolean
    read pm_GetIsValid;
   property PathFill: TddFillType
    read pm_GetPathFill
    write pm_SetPathFill;
   property Required: Boolean
    read pm_GetRequired
    write pm_SetRequired;
   property RequiredMessage: AnsiString
    read f_RequiredMessage
    write f_RequiredMessage;
   property UseNodeNames: Boolean
    read f_UseNodeNames
    write f_UseNodeNames;
   property UseScrollbars: Boolean
    read f_UseScrollbars
    write pm_SetUseScrollbars;
   property Version: Integer
    read pm_GetVersion
    write pm_SetVersion;
   property ButtonPlace: TddButtonPlace
    read pm_GetButtonPlace
    write pm_SetButtonPlace;
   property IsChanged[const Alias: AnsiString]: Boolean
    read pm_GetIsChanged;
 end;//TddAppConfiguration

 IddCNode = interface(Il3Base)
  ['{5C490FF2-8054-429D-BC1F-8139DD3752E9}']
  function Get_Control: TddCustomConfigNode;
  property Control: TddCustomConfigNode
   read Get_Control;
 end;//IddCNode

 TddCNode = class(Tl3UsualNode, IddCNode)
  private
   f_Node: TddCustomConfigNode;
  protected
   function Get_Control: TddCustomConfigNode;
  public
   constructor Create(aNode: TddCustomConfigNode); reintroduce;
   class function Make(aNode: TddCustomConfigNode): Il3Node; reintroduce;
 end;//TddCNode

{$If NOT Defined(ServerAssistantSide)}
var ddAppConfiguration: TddAppConfiguration = nil;
{$IfEnd} // NOT Defined(ServerAssistantSide)

implementation

uses
 l3ImplUses
 , ddAppConfigRes
 , ddAppConfigLists
 , ddAppConfigUtils
 , ddAppConfigDates
 , SysUtils
 , Windows
 , Math
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Defaults
 , l3TreeInterfaces
 , l3String
 {$If NOT Defined(Nemesis)}
 , ddIniStorage
 {$IfEnd} // NOT Defined(Nemesis)
 , ddAppConfigTFrame
 , ddAppConfigBFrame
 , vtVerInf
 , afwVCL
 , l3Base
 , multimon
 , l3Nodes
 {$If NOT Defined(NoScripts)}
 , InterfacedNodeWords
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 cFormMinWidth = 4 * 75 + 5 * 12;
  {* ширина кнопок + расстояния между ними }
 cFormMinHeight = 104;
  {* высота панели кнопок + Высота заголовка }
 cMinFormClearance = 100;
  {* форма уже и ниже рабочей области экрана минимум на эту константу }

function TddAppConfiguration.pm_GetAllowTest: Boolean;
//#UC START# *521489EA0288_4B990F100126get_var*
//#UC END# *521489EA0288_4B990F100126get_var*
begin
//#UC START# *521489EA0288_4B990F100126get_impl*
 if LastItem is TddBrowseConfigItem then
  Result := (LastItem as TddBrowseConfigItem).AllowTest
 else
  Result := False;
//#UC END# *521489EA0288_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetAllowTest

procedure TddAppConfiguration.pm_SetAllowTest(aValue: Boolean);
//#UC START# *521489EA0288_4B990F100126set_var*
//#UC END# *521489EA0288_4B990F100126set_var*
begin
//#UC START# *521489EA0288_4B990F100126set_impl*
 if LastItem is TddBrowseConfigItem then
  (LastItem as TddBrowseConfigItem).AllowTest := aValue;
//#UC END# *521489EA0288_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetAllowTest

function TddAppConfiguration.pm_GetAsBoolean(const Alias: AnsiString): Boolean;
//#UC START# *52148A4A0330_4B990F100126get_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148A4A0330_4B990F100126get_var*
begin
//#UC START# *52148A4A0330_4B990F100126get_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkBoolean then
  Result := l_Value.AsBoolean
 else
  raise EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148A4A0330_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetAsBoolean

procedure TddAppConfiguration.pm_SetAsBoolean(const Alias: AnsiString;
 aValue: Boolean);
//#UC START# *52148A4A0330_4B990F100126set_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148A4A0330_4B990F100126set_var*
begin
//#UC START# *52148A4A0330_4B990F100126set_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkBoolean then
 begin
  l_Value.AsBoolean := aValue;
  Values[Alias] := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148A4A0330_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetAsBoolean

function TddAppConfiguration.pm_GetAsDateTime(const Alias: AnsiString): TDateTime;
//#UC START# *52148A8902A7_4B990F100126get_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148A8902A7_4B990F100126get_var*
begin
//#UC START# *52148A8902A7_4B990F100126get_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkDateTime then
  Result := l_Value.AsDateTime
 else
  raise EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148A8902A7_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetAsDateTime

procedure TddAppConfiguration.pm_SetAsDateTime(const Alias: AnsiString;
 aValue: TDateTime);
//#UC START# *52148A8902A7_4B990F100126set_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148A8902A7_4B990F100126set_var*
begin
//#UC START# *52148A8902A7_4B990F100126set_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkDateTime then
 begin
  l_Value.AsDateTime := aValue;
  Values[Alias] := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148A8902A7_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetAsDateTime

function TddAppConfiguration.pm_GetAsInteger(const Alias: AnsiString): Integer;
//#UC START# *52148AC0032F_4B990F100126get_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148AC0032F_4B990F100126get_var*
begin
//#UC START# *52148AC0032F_4B990F100126get_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkInteger then
  Result := l_Value.AsInteger
 else
  raise EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148AC0032F_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetAsInteger

procedure TddAppConfiguration.pm_SetAsInteger(const Alias: AnsiString;
 aValue: Integer);
//#UC START# *52148AC0032F_4B990F100126set_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148AC0032F_4B990F100126set_var*
begin
//#UC START# *52148AC0032F_4B990F100126set_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkInteger then
 begin
  l_Value.AsInteger := aValue;
  Values[Alias] := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148AC0032F_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetAsInteger

function TddAppConfiguration.pm_GetAsObject(const Alias: AnsiString): TObject;
//#UC START# *52148AFC0075_4B990F100126get_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148AFC0075_4B990F100126get_var*
begin
//#UC START# *52148AFC0075_4B990F100126get_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkObject then
  Result := l_Value.AsObject
 else
  raise EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148AFC0075_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetAsObject

procedure TddAppConfiguration.pm_SetAsObject(const Alias: AnsiString;
 aValue: TObject);
//#UC START# *52148AFC0075_4B990F100126set_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148AFC0075_4B990F100126set_var*
begin
//#UC START# *52148AFC0075_4B990F100126set_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkObject then
 begin
  l_Value.AsObject := aValue;
  Values[Alias] := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148AFC0075_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetAsObject

function TddAppConfiguration.pm_GetAsString(const Alias: AnsiString): AnsiString;
//#UC START# *52148B2701DE_4B990F100126get_var*
var
 l_Value: TddConfigValue;
 I: Integer;
 l_Obj: TddBaseConfigItem;
//#UC END# *52148B2701DE_4B990F100126get_var*
begin
//#UC START# *52148B2701DE_4B990F100126get_impl*
  if HasValue(Alias, l_Obj) then
  begin
   if l_Obj is TddBaseConfigItem then
    Result := TddBaseConfigItem(l_Obj).StringValue
   else
    Result := TddCustomConfigNode(l_Obj).Value.AsString;
  end
  else
   raise EddConfigError.CreateFmt(str_PropertyAbsent.AsStr, [Alias]);
//#UC END# *52148B2701DE_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetAsString

procedure TddAppConfiguration.pm_SetAsString(const Alias: AnsiString;
 const aValue: AnsiString);
//#UC START# *52148B2701DE_4B990F100126set_var*
var
 l_Value: TddConfigValue;
//#UC END# *52148B2701DE_4B990F100126set_var*
begin
//#UC START# *52148B2701DE_4B990F100126set_impl*
 l_Value := Values[Alias];
 if l_Value.Kind = dd_vkString then
 begin
  l_Value.AsString := aValue;
  Values[Alias] := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [Alias]);
//#UC END# *52148B2701DE_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetAsString

function TddAppConfiguration.pm_GetChanged: Boolean;
//#UC START# *52148B75037E_4B990F100126get_var*
var
 I: Integer;
 l_Obj: TObject;
//#UC END# *52148B75037E_4B990F100126get_var*
begin
//#UC START# *52148B75037E_4B990F100126get_impl*
 Result := False;
 for I := 0 to Pred(f_Items.Count) do
 begin
  l_Obj := f_Items.Objects[I];
  if l_Obj is TddBaseConfigItem then
  begin
   if TddBaseConfigItem(l_Obj).Changed then
   begin
    Result := True;
    Break;
   end
  end
  else
  if TddCustomConfigNode(l_Obj).Changed then
  begin
   Result := True;
   Break;
  end;
 end;
//#UC END# *52148B75037E_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetChanged

procedure TddAppConfiguration.pm_SetChanged(aValue: Boolean);
//#UC START# *52148B75037E_4B990F100126set_var*
var
 I: Integer;
 l_Obj: TObject;
//#UC END# *52148B75037E_4B990F100126set_var*
begin
//#UC START# *52148B75037E_4B990F100126set_impl*
 f_Root.Changed := aValue;
//#UC END# *52148B75037E_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetChanged

function TddAppConfiguration.pm_GetComboBoxStyle: TComboBoxStyle;
//#UC START# *52148BF3008C_4B990F100126get_var*
//#UC END# *52148BF3008C_4B990F100126get_var*
begin
//#UC START# *52148BF3008C_4B990F100126get_impl*
 Assert(LastItem is TddComboBoxConfigItem);
 Result := TddComboBoxConfigItem(LastItem).ComboBoxStyle;
//#UC END# *52148BF3008C_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetComboBoxStyle

procedure TddAppConfiguration.pm_SetComboBoxStyle(aValue: TComboBoxStyle);
//#UC START# *52148BF3008C_4B990F100126set_var*
//#UC END# *52148BF3008C_4B990F100126set_var*
begin
//#UC START# *52148BF3008C_4B990F100126set_impl*
 Assert(LastItem is TddComboBoxConfigItem);
 TddComboBoxConfigItem(LastItem).ComboBoxStyle := aValue;
//#UC END# *52148BF3008C_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetComboBoxStyle

procedure TddAppConfiguration.pm_SetDialogCaption(const aValue: AnsiString);
//#UC START# *52148C280308_4B990F100126set_var*
//#UC END# *52148C280308_4B990F100126set_var*
begin
//#UC START# *52148C280308_4B990F100126set_impl*
 f_DialogCaption := aValue;
//#UC END# *52148C280308_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetDialogCaption

function TddAppConfiguration.pm_GetDialogIndex: Integer;
//#UC START# *52148C520351_4B990F100126get_var*
//#UC END# *52148C520351_4B990F100126get_var*
begin
//#UC START# *52148C520351_4B990F100126get_impl*
 Result := AsInteger['_DialogIndex'];
//#UC END# *52148C520351_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetDialogIndex

procedure TddAppConfiguration.pm_SetDialogIndex(aValue: Integer);
//#UC START# *52148C520351_4B990F100126set_var*
//#UC END# *52148C520351_4B990F100126set_var*
begin
//#UC START# *52148C520351_4B990F100126set_impl*
 AsInteger['_DialogIndex'] := aValue;
//#UC END# *52148C520351_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetDialogIndex

function TddAppConfiguration.pm_GetEnabled: Boolean;
//#UC START# *52148C8A039F_4B990F100126get_var*
//#UC END# *52148C8A039F_4B990F100126get_var*
begin
//#UC START# *52148C8A039F_4B990F100126get_impl*
 Result := LastItem.Enabled;
//#UC END# *52148C8A039F_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetEnabled

procedure TddAppConfiguration.pm_SetEnabled(aValue: Boolean);
//#UC START# *52148C8A039F_4B990F100126set_var*
//#UC END# *52148C8A039F_4B990F100126set_var*
begin
//#UC START# *52148C8A039F_4B990F100126set_impl*
 LastItem.Enabled := aValue;
//#UC END# *52148C8A039F_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetEnabled

function TddAppConfiguration.pm_GetFilter: AnsiString;
//#UC START# *52148CBD018C_4B990F100126get_var*
//#UC END# *52148CBD018C_4B990F100126get_var*
begin
//#UC START# *52148CBD018C_4B990F100126get_impl*
 if LastItem is TddFileNameConfigItem then
  Result := (LastItem as TddFileNameConfigItem).FilterMask;
//#UC END# *52148CBD018C_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetFilter

procedure TddAppConfiguration.pm_SetFilter(const aValue: AnsiString);
//#UC START# *52148CBD018C_4B990F100126set_var*
//#UC END# *52148CBD018C_4B990F100126set_var*
begin
//#UC START# *52148CBD018C_4B990F100126set_impl*
 if LastItem is TddFileNameConfigItem then
  (LastItem as TddFileNameConfigItem).FilterMask := aValue;
//#UC END# *52148CBD018C_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetFilter

function TddAppConfiguration.pm_GetHint: AnsiString;
//#UC START# *52148D3C0365_4B990F100126get_var*
//#UC END# *52148D3C0365_4B990F100126get_var*
begin
//#UC START# *52148D3C0365_4B990F100126get_impl*
 if LastItem is TddVisualConfigItem then
  Result := TddVisualConfigItem(LastItem).Hint
 else
  Result := '';
//#UC END# *52148D3C0365_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetHint

procedure TddAppConfiguration.pm_SetHint(const aValue: AnsiString);
//#UC START# *52148D3C0365_4B990F100126set_var*
//#UC END# *52148D3C0365_4B990F100126set_var*
begin
//#UC START# *52148D3C0365_4B990F100126set_impl*
 if LastItem is TddVisualConfigItem then
  TddVisualConfigItem(LastItem).Hint := aValue;
//#UC END# *52148D3C0365_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetHint

function TddAppConfiguration.pm_GetLabelTop: Boolean;
//#UC START# *52148DE901A4_4B990F100126get_var*
//#UC END# *52148DE901A4_4B990F100126get_var*
begin
//#UC START# *52148DE901A4_4B990F100126get_impl*
 if LastItem is TddVisualConfigItem then
  Result := TddVisualConfigItem(LastItem).LabelTop
 else
  Result := f_LabelTop;
//#UC END# *52148DE901A4_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetLabelTop

procedure TddAppConfiguration.pm_SetLabelTop(aValue: Boolean);
//#UC START# *52148DE901A4_4B990F100126set_var*
//#UC END# *52148DE901A4_4B990F100126set_var*
begin
//#UC START# *52148DE901A4_4B990F100126set_impl*
 if LastItem is TddVisualConfigItem then
  TddVisualConfigItem(LastItem).LabelTop := aValue
 else
  f_LabelTop := aValue;
//#UC END# *52148DE901A4_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetLabelTop

function TddAppConfiguration.pm_GetLastItem: TddBaseConfigItem;
//#UC START# *52148E4603B5_4B990F100126get_var*
//#UC END# *52148E4603B5_4B990F100126get_var*
begin
//#UC START# *52148E4603B5_4B990F100126get_impl*
 if f_IsNode then
  Result := nil
 else 
 if f_Items.Count > 0 then
  Result := TddBaseConfigItem(f_Items.Objects[Pred(f_Items.Count)])
 else
  raise EddConfigError.Create(str_ListEmpty.AsStr);
//#UC END# *52148E4603B5_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetLastItem

function TddAppConfiguration.pm_GetMaxValue: Integer;
//#UC START# *52148E90004E_4B990F100126get_var*
//#UC END# *52148E90004E_4B990F100126get_var*
begin
//#UC START# *52148E90004E_4B990F100126get_impl*
 if LastItem is TddIntegerConfigItem then
  Result := (LastItem as TddIntegerConfigItem).MaxValue
 else
  Result := 0;
//#UC END# *52148E90004E_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetMaxValue

procedure TddAppConfiguration.pm_SetMaxValue(aValue: Integer);
//#UC START# *52148E90004E_4B990F100126set_var*
//#UC END# *52148E90004E_4B990F100126set_var*
begin
//#UC START# *52148E90004E_4B990F100126set_impl*
 if LastItem is TddIntegerConfigItem then
  (LastItem as TddIntegerConfigItem).MaxValue := aValue;
//#UC END# *52148E90004E_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetMaxValue

function TddAppConfiguration.pm_GetMinValue: Integer;
//#UC START# *52148EA20177_4B990F100126get_var*
//#UC END# *52148EA20177_4B990F100126get_var*
begin
//#UC START# *52148EA20177_4B990F100126get_impl*
 if LastItem is TddIntegerConfigItem then
  Result := (LastItem as TddIntegerConfigItem).MinValue
 else
  Result := 0;
//#UC END# *52148EA20177_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetMinValue

procedure TddAppConfiguration.pm_SetMinValue(aValue: Integer);
//#UC START# *52148EA20177_4B990F100126set_var*
//#UC END# *52148EA20177_4B990F100126set_var*
begin
//#UC START# *52148EA20177_4B990F100126set_impl*
 if LastItem is TddIntegerConfigItem then
  (LastItem as TddIntegerConfigItem).MinValue := aValue;
//#UC END# *52148EA20177_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetMinValue

function TddAppConfiguration.pm_GetPasswordChar: AnsiChar;
//#UC START# *52148EC70275_4B990F100126get_var*
//#UC END# *52148EC70275_4B990F100126get_var*
begin
//#UC START# *52148EC70275_4B990F100126get_impl*
 if LastItem is TddStringConfigItem then
  Result := (LastItem as TddStringConfigItem).PasswordChar
 else
  Result := #0;
//#UC END# *52148EC70275_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetPasswordChar

procedure TddAppConfiguration.pm_SetPasswordChar(aValue: AnsiChar);
//#UC START# *52148EC70275_4B990F100126set_var*
//#UC END# *52148EC70275_4B990F100126set_var*
begin
//#UC START# *52148EC70275_4B990F100126set_impl*
 if LastItem is TddStringConfigItem then
  (LastItem as TddStringConfigItem).PasswordChar := aValue;
//#UC END# *52148EC70275_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetPasswordChar

function TddAppConfiguration.pm_GetTestButtonCaption: AnsiString;
//#UC START# *521491310103_4B990F100126get_var*
//#UC END# *521491310103_4B990F100126get_var*
begin
//#UC START# *521491310103_4B990F100126get_impl*
 if LastItem is TddBrowseConfigItem then
  Result := (LastItem as TddBrowseConfigItem).TestButtonCaption
 else
  Result := '';
//#UC END# *521491310103_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetTestButtonCaption

procedure TddAppConfiguration.pm_SetTestButtonCaption(const aValue: AnsiString);
//#UC START# *521491310103_4B990F100126set_var*
//#UC END# *521491310103_4B990F100126set_var*
begin
//#UC START# *521491310103_4B990F100126set_impl*
 if LastItem is TddBrowseConfigItem then
  (LastItem as TddBrowseConfigItem).TestButtonCaption := aValue;
//#UC END# *521491310103_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetTestButtonCaption

function TddAppConfiguration.pm_GetValues(const Alias: AnsiString): TddConfigValue;
//#UC START# *5214919B02AD_4B990F100126get_var*
var
 l_Index: Integer;
 l_Obj: TddBaseConfigItem;
//#UC END# *5214919B02AD_4B990F100126get_var*
begin
//#UC START# *5214919B02AD_4B990F100126get_impl*
 if HasValue(Alias, l_Obj) then
  Result := l_Obj.Value
 else
  raise EddConfigError.CreateFmt(str_PropertyAbsent.AsStr, [Alias])
//#UC END# *5214919B02AD_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetValues

procedure TddAppConfiguration.pm_SetValues(const Alias: AnsiString;
 const aValue: TddConfigValue);
//#UC START# *5214919B02AD_4B990F100126set_var*
var
 l_Obj: TddBaseConfigItem;
//#UC END# *5214919B02AD_4B990F100126set_var*
begin
//#UC START# *5214919B02AD_4B990F100126set_impl*
 if hasValue(Alias, l_Obj) then
  l_Obj.Value := aValue;
//#UC END# *5214919B02AD_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetValues

procedure TddAppConfiguration.pm_SetButtonsPanelHeight(aValue: Integer);
//#UC START# *5214936E0315_4B990F100126set_var*
//#UC END# *5214936E0315_4B990F100126set_var*
begin
//#UC START# *5214936E0315_4B990F100126set_impl*
 if aValue <> f_ButtonsPanelHeight then
  f_ButtonsPanelHeight := aValue;
//#UC END# *5214936E0315_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetButtonsPanelHeight

function TddAppConfiguration.pm_GetColumns: Integer;
//#UC START# *521493A20246_4B990F100126get_var*
//#UC END# *521493A20246_4B990F100126get_var*
begin
//#UC START# *521493A20246_4B990F100126get_impl*
 if LastItem is TddCheckListConfigItem then
  Result := TddCheckListConfigItem(LastItem).Columns
 else
  Result := 1;
//#UC END# *521493A20246_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetColumns

procedure TddAppConfiguration.pm_SetColumns(aValue: Integer);
//#UC START# *521493A20246_4B990F100126set_var*
//#UC END# *521493A20246_4B990F100126set_var*
begin
//#UC START# *521493A20246_4B990F100126set_impl*
 if LastItem is TddCheckListConfigItem then
  TddCheckListConfigItem(LastItem).Columns := aValue;
//#UC END# *521493A20246_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetColumns

procedure TddAppConfiguration.pm_SetFormMinWidth(aValue: Integer);
//#UC START# *521494180133_4B990F100126set_var*
//#UC END# *521494180133_4B990F100126set_var*
begin
//#UC START# *521494180133_4B990F100126set_impl*
 if aValue <> f_FormMinWidth then
  f_FormMinWidth := aValue;
//#UC END# *521494180133_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetFormMinWidth

function TddAppConfiguration.pm_GetHelpContext: Integer;
//#UC START# *52149467027F_4B990F100126get_var*
//#UC END# *52149467027F_4B990F100126get_var*
begin
//#UC START# *52149467027F_4B990F100126get_impl*
 if f_IsNode then
  Result := f_Selected.HelpContext
 else
  Result := LastItem.HelpContext;
//#UC END# *52149467027F_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetHelpContext

procedure TddAppConfiguration.pm_SetHelpContext(aValue: Integer);
//#UC START# *52149467027F_4B990F100126set_var*
//#UC END# *52149467027F_4B990F100126set_var*
begin
//#UC START# *52149467027F_4B990F100126set_impl*
 if f_IsNode then
  f_Selected.HelpContext := aValue
 else
  LastItem.HelpContext := aValue;
//#UC END# *52149467027F_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetHelpContext

function TddAppConfiguration.pm_GetIsEmpty(const Alias: AnsiString): Boolean;
//#UC START# *521494850309_4B990F100126get_var*
//#UC END# *521494850309_4B990F100126get_var*
begin
//#UC START# *521494850309_4B990F100126get_impl*
 if HasValue(Alias) then
  Result := IsValueEmpty(Values[Alias])
 else
  raise EddConfigError.CreateFmt(str_PropertyAbsent.AsStr, [Alias]);
//#UC END# *521494850309_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetIsEmpty

function TddAppConfiguration.pm_GetIsValid: Boolean;
//#UC START# *521494C303BA_4B990F100126get_var*
var
 l_Index: Integer;
//#UC END# *521494C303BA_4B990F100126get_var*
begin
//#UC START# *521494C303BA_4B990F100126get_impl*
 Result := CheckRequiredValues;
//#UC END# *521494C303BA_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetIsValid

function TddAppConfiguration.pm_GetPathFill: TddFillType;
//#UC START# *521495D901DD_4B990F100126get_var*
//#UC END# *521495D901DD_4B990F100126get_var*
begin
//#UC START# *521495D901DD_4B990F100126get_impl*
 if LastItem is TddBrowseConfigItem then
  Result := TddBrowseConfigItem(LastItem).PathFill;
//#UC END# *521495D901DD_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetPathFill

procedure TddAppConfiguration.pm_SetPathFill(aValue: TddFillType);
//#UC START# *521495D901DD_4B990F100126set_var*
//#UC END# *521495D901DD_4B990F100126set_var*
begin
//#UC START# *521495D901DD_4B990F100126set_impl*
 if LastItem is TddBrowseConfigItem then
  TddBrowseConfigItem(LastItem).PathFill := aValue;
//#UC END# *521495D901DD_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetPathFill

function TddAppConfiguration.pm_GetRequired: Boolean;
//#UC START# *5214960201DF_4B990F100126get_var*
//#UC END# *5214960201DF_4B990F100126get_var*
begin
//#UC START# *5214960201DF_4B990F100126get_impl*
 Result := LastItem.Required;
//#UC END# *5214960201DF_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetRequired

procedure TddAppConfiguration.pm_SetRequired(aValue: Boolean);
//#UC START# *5214960201DF_4B990F100126set_var*
//#UC END# *5214960201DF_4B990F100126set_var*
begin
//#UC START# *5214960201DF_4B990F100126set_impl*
 LastItem.Required := aValue;
//#UC END# *5214960201DF_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetRequired

procedure TddAppConfiguration.pm_SetUseScrollbars(aValue: Boolean);
//#UC START# *5214965801D6_4B990F100126set_var*
//#UC END# *5214965801D6_4B990F100126set_var*
begin
//#UC START# *5214965801D6_4B990F100126set_impl*
 if f_UseScrollbars <> aValue then
 begin
  f_UseScrollbars := aValue;
  // Перебрать все узлы и выставить им скроллеры
 end;
//#UC END# *5214965801D6_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetUseScrollbars

function TddAppConfiguration.pm_GetVersion: Integer;
//#UC START# *521496760086_4B990F100126get_var*
//#UC END# *521496760086_4B990F100126get_var*
begin
//#UC START# *521496760086_4B990F100126get_impl*
 Result := AsInteger['_Version'];
//#UC END# *521496760086_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetVersion

procedure TddAppConfiguration.pm_SetVersion(aValue: Integer);
//#UC START# *521496760086_4B990F100126set_var*
//#UC END# *521496760086_4B990F100126set_var*
begin
//#UC START# *521496760086_4B990F100126set_impl*
 AsInteger['_Version'] := aValue;
//#UC END# *521496760086_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetVersion

function TddAppConfiguration.pm_GetButtonPlace: TddButtonPlace;
//#UC START# *5224660D00E1_4B990F100126get_var*
//#UC END# *5224660D00E1_4B990F100126get_var*
begin
//#UC START# *5224660D00E1_4B990F100126get_impl*
 if LastItem is TddButtonConfigItem then
  Result := TddButtonConfigItem(LastItem).ButtonPlace
 else
  Result := dd_bpAsDefine;
//#UC END# *5224660D00E1_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetButtonPlace

procedure TddAppConfiguration.pm_SetButtonPlace(aValue: TddButtonPlace);
//#UC START# *5224660D00E1_4B990F100126set_var*
//#UC END# *5224660D00E1_4B990F100126set_var*
begin
//#UC START# *5224660D00E1_4B990F100126set_impl*
 if LastItem is TddButtonConfigItem then
  TddButtonConfigItem(LastItem).ButtonPlace := aValue;
//#UC END# *5224660D00E1_4B990F100126set_impl*
end;//TddAppConfiguration.pm_SetButtonPlace

function TddAppConfiguration.pm_GetIsChanged(const Alias: AnsiString): Boolean;
//#UC START# *553A3BA701BF_4B990F100126get_var*
var
 l_Index: Integer;
 l_Obj: TddBaseConfigItem;
//#UC END# *553A3BA701BF_4B990F100126get_var*
begin
//#UC START# *553A3BA701BF_4B990F100126get_impl*
 if HasValue(Alias, l_Obj) then
  Result := l_Obj.Changed
 else
  Result := False;
//#UC END# *553A3BA701BF_4B990F100126get_impl*
end;//TddAppConfiguration.pm_GetIsChanged

function TddAppConfiguration.AddChildNode(aNode: TddCustomConfigNode): TddCustomConfigNode;
//#UC START# *52149C8203DB_4B990F100126_var*
//#UC END# *52149C8203DB_4B990F100126_var*
begin
//#UC START# *52149C8203DB_4B990F100126_impl*
 Result := f_Selected.AddNode(aNode);
//#UC END# *52149C8203DB_4B990F100126_impl*
end;//TddAppConfiguration.AddChildNode

procedure TddAppConfiguration.AddNode(aNode: TddCustomConfigNode);
//#UC START# *52149D07021E_4B990F100126_var*
//#UC END# *52149D07021E_4B990F100126_var*
begin
//#UC START# *52149D07021E_4B990F100126_impl*
 f_Selected := f_Root.AddNode(aNode);
 if UseScrollbars then
  f_Selected.ScrollBars := ssBoth;
 f_IsNode := True;
//#UC END# *52149D07021E_4B990F100126_impl*
end;//TddAppConfiguration.AddNode

procedure TddAppConfiguration.CalculateConstants(theTree: TCustomFrame;
 theWork: TCustomFrame;
 theButtons: TCustomFrame);
//#UC START# *52149D8C0361_4B990F100126_var*
//#UC END# *52149D8C0361_4B990F100126_var*
begin
//#UC START# *52149D8C0361_4B990F100126_impl*
 f_FormMinWidth := theTree.Width;
 if theButtons <> nil then
  Inc(f_ButtonsPanelHeight, theButtons.Height);
//#UC END# *52149D8C0361_4B990F100126_impl*
end;//TddAppConfiguration.CalculateConstants

procedure TddAppConfiguration.CheckEnabledStatus;
//#UC START# *52149E600021_4B990F100126_var*
var
 I: Integer;
 l_I: TddBaseConfigItem;
 l_Obj: TObject;
//#UC END# *52149E600021_4B990F100126_var*
begin
//#UC START# *52149E600021_4B990F100126_impl*
  { Проверяем изменение статуса доступности подэлементов }
  for I := 0 to Pred(f_Items.Count) do
  begin
   l_Obj := f_Items.Objects[I];
   if l_Obj is TddBaseConfigItem then
   begin
    l_I := TddBaseConfigItem(l_Obj);
    Assert(l_I <> nil);
    if (l_I.MasterItem <> nil) then
     l_I.Enabled := l_I.MasterItem.BooleanValue;
   end; // l_Obj is TddBaseConfigItem
  end; // for I
//#UC END# *52149E600021_4B990F100126_impl*
end;//TddAppConfiguration.CheckEnabledStatus

function TddAppConfiguration.CheckRequiredValues: Boolean;
//#UC START# *52149E86033F_4B990F100126_var*
 function _CheckNode(aNode: TddCustomConfigNode): Boolean;
 var
  I: Integer;
 begin
  Result := not aNode.IsRequired(f_RequiredMessage);
  if Result then
   for I := 0 to Pred(aNode.ChildrenCount) do
   begin
    Result := _CheckNode(aNode.Children[I]);
    if not Result then
     Break;
   end
  else
  begin
   if Assigned(f_OnRequiredEvent) then
    f_OnRequiredEvent(aNode, Result);
   if not Result then
   begin
    f_RequiredNode := aNode;
    f_RequiredMessage := Format('Не задан параметр "%s" на вкладке "%s"', [f_RequiredMessage, aNode.Caption]);
   end;
  end;
 end;
//#UC END# *52149E86033F_4B990F100126_var*
begin
//#UC START# *52149E86033F_4B990F100126_impl*
 f_RequiredNode := nil;
 f_RequiredMessage := '';
 Result := _CheckNode(f_Root);
//#UC END# *52149E86033F_4B990F100126_impl*
end;//TddAppConfiguration.CheckRequiredValues

procedure TddAppConfiguration.CheckVersion(const aStorage: IddConfigStorage);
//#UC START# *52149EA20119_4B990F100126_var*
var
 l_Version: TddBaseConfigItem;
 l_CurVersion, l_OldVersion: Integer;
//#UC END# *52149EA20119_4B990F100126_var*
begin
//#UC START# *52149EA20119_4B990F100126_impl*
 // Нужно прочитать версию из хранилища и при не совпадении запросить преобразование
 if HasValue('_Version', l_Version) then
 begin
  l_CurVersion := Version;
  aStorage.Section := f_Root.Alias;
  l_Version.LoadValue(aStorage);
  l_OldVersion := l_Version.IntegerValue;
  if l_CurVersion > l_OldVersion then
  begin
   f_Versions.Upgrade(l_OldVersion, l_CurVersion, aStorage);
   l_Version.IntegerValue := l_CurVersion;
   aStorage.Section := f_Root.Alias;
   l_Version.SaveValue(aStorage);
  end; // l_CurVersion <> l_OldVersion
 end;
//#UC END# *52149EA20119_4B990F100126_impl*
end;//TddAppConfiguration.CheckVersion

procedure TddAppConfiguration.ClearControls;
//#UC START# *52149EC1019B_4B990F100126_var*
 procedure _Clear(aNode: TddCustomConfigNode);
 var
  I: Integer;
 begin
  IddConfigNode(aNode).ClearControls;
  for I := 0 to Pred(aNode.ChildrenCount) do
   _Clear(aNode.Children[I]);
 end;
//#UC END# *52149EC1019B_4B990F100126_var*
begin
//#UC START# *52149EC1019B_4B990F100126_impl*
 f_AliasNameIndex := 0;
 _Clear(f_Root);
//#UC END# *52149EC1019B_4B990F100126_impl*
end;//TddAppConfiguration.ClearControls

procedure TddAppConfiguration.CreateComponents(theTree: TvtCustomOutliner;
 theParent: TWinControl);
//#UC START# *52149ECF002E_4B990F100126_var*
var
 l_Tree : Il3Tree;

 procedure DoNode(const aNode: Il3Node);
 var
  l_Frame : TCustomFrame;
  l_CN    : TddCustomConfigNode;
 begin
  l_CN := (aNode As IddCNode).Control;
  l_Frame := IddConfigNode(l_CN).CreateFrame(theParent, l_Tree.GetAbsIndex(aNode));
  if (l_Frame.Parent = nil) then
   l_Frame.Parent := theParent;
  l_Frame.Visible := aNode.IsSame(theTree.CurrentCNode);
 end;
//#UC END# *52149ECF002E_4B990F100126_var*
begin
//#UC START# *52149ECF002E_4B990F100126_impl*
 l_Tree := theTree.CTree;
 l_Tree.IterateF(l3L2NA(@DoNode))
//#UC END# *52149ECF002E_4B990F100126_impl*
end;//TddAppConfiguration.CreateComponents

procedure TddAppConfiguration.CreateTree(aTree: TddCustomConfigNode;
 theTree: TvtCustomOutliner);
//#UC START# *52149F05033E_4B990F100126_var*
var
 l_R: Il3Node;

 procedure ConvertNode(const aNode: TddCustomConfigNode; const aTreeNode: Il3Node);
 var
  I   : Integer;
  l_N : Il3Node;
 begin
  if (aTreeNode = nil) then
   l_N := l_R.InsertChild(TddCNode.Make(aNode))
  else
   l_N := aTreeNode.InsertChild(TddCNode.Make(aNode));
  for I := 0 to Pred(aNode.ChildrenCount) do
   ConvertNode(aNode.Children[I], l_N);
 end;

var
 I: Integer;
//#UC END# *52149F05033E_4B990F100126_var*
begin
//#UC START# *52149F05033E_4B990F100126_impl*
 l_R := theTree.CTree.CRootNode;
 l_R.ReleaseChilds;
 for I := 0 to Pred(aTree.ChildrenCount) do
  ConvertNode(aTree.Children[I], nil);
//#UC END# *52149F05033E_4B990F100126_impl*
end;//TddAppConfiguration.CreateTree

procedure TddAppConfiguration.RecalcFormSize(aForm: TCustomForm);
//#UC START# *52149F560306_4B990F100126_var*
var
 I: Integer;
 l_MaxHeight, l_CurHeight: Integer;
 l_MaxWidth: Integer;
 l_Height, l_Width: Integer;

 procedure CalcNodeBounds(aNode: TddCustomConfigNode);
 var
  l_Height, l_Width: Integer;
 begin
  IddConfigNode(aNode).FrameSize(aForm, l_Height, l_Width);
  if not aNode.IsVerticalScrollBar then
   l_MaxHeight := Max(l_MaxHeight, l_Height);
  if not aNode.IsHorizontalScrollBar then
   l_MaxWidth := Max(l_MaxWidth, l_Width);
 end;

 procedure lp_CalcBounds(aNode: TddCustomConfigNode);
 var
  l_IDX: Integer;
 begin
  CalcNodeBounds(aNode);
  for l_IDX := 0 to Pred(aNode.ChildrenCount) do
   lp_CalcBounds(aNode.Children[l_IDX]);
 end;

var
 l_WorkAreaRect: TRect;
 l_Monitor: HMONITOR;
 l_MI: TMonitorInfo;
//#UC END# *52149F560306_4B990F100126_var*
begin
//#UC START# *52149F560306_4B990F100126_impl*
  l_MaxWidth := 560;
  l_MaxHeight := 404;

  //l_MaxHeight := Low(l_MaxHeight);
  //l_MaxWidth := Low(l_MaxWidth);
  // Вычисление максимальных ширин и высот панелей
  for I := 0 to Pred(f_Root.ChildrenCount) do
   lp_CalcBounds(f_Root.Children[I]);
  // Окончательный пересчет
  if dd_doNoButtons in DialogOptions then
   l_Height := ButtonsPanelHeight + l_MaxHeight
  else
  if Assigned(f_ButtonsPanel) then
   l_Height := f_ButtonsPanel.Height + l_MaxHeight
  else
   l_Height := l_MaxHeight;
  // Учтем панель информации
  if Assigned(f_WorkFrame) then
   Inc(l_Height, f_WorkFrame.HeaderHeight);
  { TODO -oДмитрий Дудко -cРазвитие : Тщательно проверить пересчет }
  l_Width := Max(f_FormMinWidth, l_MaxWidth + f_WorkFrame.Left);
  l_CurHeight := MulDiv(l_Width, 10, 14);
  if l_CurHeight < l_Height then
   l_Width := MulDiv(l_Height, 14, 10)
  else
   l_Height := l_CurHeight;

  // Здесь нужно получить workarea того монитора, на котором показывают форму.
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=287997963
  l_Monitor := MonitorfromWindow(aForm.Handle, MONITOR_DEFAULTTONEAREST);
  l3FillChar(l_MI, SizeOf(l_MI), 0);
  l_MI.cbSize := SizeOf(l_MI);
  GetMonitorInfo(l_Monitor, @l_MI);
  l_WorkAreaRect := l_MI.rcWork;
  aForm.ClientHeight := Min(l_Height, l_WorkAreaRect.Bottom - l_WorkAreaRect.Top - cMinFormClearance);
  aForm.ClientWidth := Min(l_Width, l_WorkAreaRect.Right - l_WorkAreaRect.Left - cMinFormClearance);
//#UC END# *52149F560306_4B990F100126_impl*
end;//TddAppConfiguration.RecalcFormSize

procedure TddAppConfiguration.DoError(const aMessage: AnsiString;
 aItem: TddVisualConfigItem);
//#UC START# *52149F850071_4B990F100126_var*
//#UC END# *52149F850071_4B990F100126_var*
begin
//#UC START# *52149F850071_4B990F100126_impl*
 // Установим фокус в компоненте с неверным значением
 DoFocus(aItem);
 // Сообщение пользователю
 if Assigned(f_OnErrorShow) then
  f_OnErrorShow(Self, aMessage)
 else
  {$IfDef XE}
  Application.MessageBox(PChar(String(aMessage)),
   PChar(String(str_ddmmErrorCaption.AsStr)),
   MB_ICONERROR);
  {$Else  XE}
  Application.MessageBox(PAnsiChar(aMessage),
   PAnsiChar(str_ddmmErrorCaption.AsStr),
   MB_ICONERROR);
  {$EndIf XE}
//#UC END# *52149F850071_4B990F100126_impl*
end;//TddAppConfiguration.DoError

procedure TddAppConfiguration.DoFocus(aItem: TddVisualConfigItem);
//#UC START# *52149FDE0067_4B990F100126_var*
var
 lNode  : TddCustomConfigNode;

  function DoNode(const aNode: Il3Node): Boolean;
  begin
   Result := ((aNode As IddCNode).Control = lNode);
  end;

var
 l_N : Il3Node;
//#UC END# *52149FDE0067_4B990F100126_var*
begin
//#UC START# *52149FDE0067_4B990F100126_impl*
 lNode := FindNode(aItem);
 l_N := f_ConfigTree.CTree.IterateF(l3L2NA(@DoNode), imCheckResult);
 if (l_N <> nil) then
 begin
  f_ConfigTree.GotoOnNode(l_N);
  if TWinControl(aItem.Control).CanFocus then
   TWinControl(aItem.Control).SetFocus;
 end;//l_N <> nil
//#UC END# *52149FDE0067_4B990F100126_impl*
end;//TddAppConfiguration.DoFocus

procedure TddAppConfiguration.SetFontName;
//#UC START# *5214A0240395_4B990F100126_var*
//#UC END# *5214A0240395_4B990F100126_var*
begin
//#UC START# *5214A0240395_4B990F100126_impl*
 if (Win32Platform = VER_PLATFORM_WIN32_NT) then
 begin
  if (Win32MajorVersion >= 6) then
  // - Vista
   FontName := 'Segoe UI'
  else
   FontName := 'Arial';
 end//Win32Platform = VER_PLATFORM_WIN32_NT
 else
  FontName := 'Arial';
//#UC END# *5214A0240395_4B990F100126_impl*
end;//TddAppConfiguration.SetFontName

procedure TddAppConfiguration.WorkupChanged;
//#UC START# *5214A03602D0_4B990F100126_var*
 procedure _Work(aNode: TddCustomConfigNode);
 var
  I: Integer;
 begin
  if aNode.Changed then
   aNode.PostEdit;
  for I := 0 to Pred(aNode.ChildrenCount) do
   _Work(aNode.Children[I]);
 end;
//#UC END# *5214A03602D0_4B990F100126_var*
begin
//#UC START# *5214A03602D0_4B990F100126_impl*
 _work(f_Root);
//#UC END# *5214A03602D0_4B990F100126_impl*
end;//TddAppConfiguration.WorkupChanged

constructor TddAppConfiguration.Create(const aStorage: IddConfigStorage = nil);
//#UC START# *5214A1570063_4B990F100126_var*
//#UC END# *5214A1570063_4B990F100126_var*
begin
//#UC START# *5214A1570063_4B990F100126_impl*
  inherited Create;
  f_Groups := Tl3ObjectList.Make;
  f_AliasNameIndex := 0;
  f_DialogCaption := str_ddmmSettingsCaption.AsStr;
  SetFontName;
  f_Versions := TddAppConfigVersionManager.Create;
  f_Root := TddAppConfigNode.Create('Configuration', Application.Title);
  f_Items := TStringList.Create;
  AddIntegerItem(l3CStr('_DialogIndex'), l3CStr('Закладка в окошке'), -1);
  AddIntegerItem(l3CStr('_Version'), l3CStr('Версия настроек'), 1);
  if (aStorage <> nil) then
   f_Storage := aStorage
  else
  begin
   {$IfNDef Nemesis}
   f_Storage := TddIniStorage.Make(ChangeFileExt(Application.ExeName, '.ini'));
   {$Else   Nemesis}
   Assert(false);
   {$EndIf  Nemesis}
  end;//aStorage <> nil
  f_FormMinWidth := cFormMinWidth;
  f_UseNodeNames := False;
  f_LabelTop := True;
  AutoSave := False;
//#UC END# *5214A1570063_4B990F100126_impl*
end;//TddAppConfiguration.Create

function TddAppConfiguration.FindNode(aItem: TddBaseConfigItem): TddCustomConfigNode;
//#UC START# *5214A1D60395_4B990F100126_var*
  function DoNode(const aNode: Il3Node): Boolean;
  var
   l_C : TddCustomConfigNode;
  begin
   Result := false;
   l_C := (aNode As IddCNode).Control;
   if IddConfigNode(l_C).IsItem(aItem) then
   begin
    FindNode := l_C;
    Result := true;
   end;//l_C.IsItem(aItem)
  end;

  procedure _FindNode(aNode: TddCustomConfigNode);
  var
   I: Integer;
  begin
   if IddConfigNode(aNode).IsItem(aItem) then
    Result := aNode
   else
    for I := 0 to aNode.ChildrenCount -1 do
    begin
     _FindNode(aNode.Children[I]);
     if Result <> nil then
      Break;
    end;
  end;
//#UC END# *5214A1D60395_4B990F100126_var*
begin
//#UC START# *5214A1D60395_4B990F100126_impl*
 Result := nil;
 if f_ConfigTree <> nil then
  f_ConfigTree.CTree.IterateF(l3L2NA(@DoNode), imCheckResult)
 else
  _FindNode(f_Root);
//#UC END# *5214A1D60395_4B990F100126_impl*
end;//TddAppConfiguration.FindNode

procedure TddAppConfiguration.Add(const aItemName: AnsiString);
//#UC START# *5214A1FB010F_4B990F100126_var*
//#UC END# *5214A1FB010F_4B990F100126_var*
begin
//#UC START# *5214A1FB010F_4B990F100126_impl*
 if LastItem is TddRadioGroupConfigItem then
  TddRadioGroupConfigItem(LastItem).Add(aItemName)
 else
 if LastItem is TddMapValueConfigItem then
  TddMapValueConfigItem(LastItem).Item := aItemName;
//#UC END# *5214A1FB010F_4B990F100126_impl*
end;//TddAppConfiguration.Add

procedure TddAppConfiguration.AddAlias(const aAlias: AnsiString);
//#UC START# *5214A23B01B6_4B990F100126_var*
var
 l_Item: TddBaseConfigItem;
//#UC END# *5214A23B01B6_4B990F100126_var*
begin
//#UC START# *5214A23B01B6_4B990F100126_impl*
 l_Item := nil;
 if f_CurItem is TddMasterSlaveConfigItem then
  l_Item := (f_CurItem as TddMasterSlaveConfigItem).AddAlias(aAlias);
 Assert(Assigned(l_Item), 'Элемент не был создан.');
 f_Items.AddObject(l_Item.Alias, l_Item);
 l_Item.AbsoluteIndex := f_Items.IndexOfObject(l_Item);
//#UC END# *5214A23B01B6_4B990F100126_impl*
end;//TddAppConfiguration.AddAlias

function TddAppConfiguration.AddBooleanItem(const aAlias: Il3CString;
 const aCaption: Il3CString;
 aDefault: Boolean = False;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A27C00D7_4B990F100126_var*
var
  l_Default: TddConfigValue;
//#UC END# *5214A27C00D7_4B990F100126_var*
begin
//#UC START# *5214A27C00D7_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkBoolean;
 l_Default.AsBoolean := aDefault;
 Result := TddBooleanConfigItem.Create(l3Str(aAlias), l3Str(aCaption), l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A27C00D7_4B990F100126_impl*
end;//TddAppConfiguration.AddBooleanItem

function TddAppConfiguration.AddButtonItem(const aCaption: AnsiString;
 aClick: TNotifyEvent;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A2B600B4_4B990F100126_var*
var
 lDefaultValue: TddConfigValue;
//#UC END# *5214A2B600B4_4B990F100126_var*
begin
//#UC START# *5214A2B600B4_4B990F100126_impl*
 l3FillChar(lDefaultValue, SizeOf(lDefaultValue), 0);
 Result := TddButtonConfigItem.Create(GetAliasName, aCaption, lDefaultValue, aClick, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A2B600B4_4B990F100126_impl*
end;//TddAppConfiguration.AddButtonItem

procedure TddAppConfiguration.AddCaptionElement(const aCaption: AnsiString;
 const aAliasPrefix: AnsiString = '');
//#UC START# *5214A2E6031D_4B990F100126_var*
//#UC END# *5214A2E6031D_4B990F100126_var*
begin
//#UC START# *5214A2E6031D_4B990F100126_impl*
 if f_CurItem is TddMasterSlaveConfigItem then
  (f_CurItem as TddMasterSlaveConfigItem).AddCaption(aCaption, aAliasPrefix);
//#UC END# *5214A2E6031D_4B990F100126_impl*
end;//TddAppConfiguration.AddCaptionElement

function TddAppConfiguration.AddChild(const aAlias: AnsiString;
 const aCaption: AnsiString): TddCustomConfigNode;
//#UC START# *5214A3340388_4B990F100126_var*
//#UC END# *5214A3340388_4B990F100126_var*
begin
//#UC START# *5214A3340388_4B990F100126_impl*
 Result := f_Selected.AddNode(aAlias, aCaption);
 f_Selected := Result;
 f_LabelTop := True;
 f_IsNode := True;
//#UC END# *5214A3340388_4B990F100126_impl*
end;//TddAppConfiguration.AddChild

function TddAppConfiguration.AddChild(const aCaption: AnsiString): TddCustomConfigNode;
//#UC START# *5214A361012B_4B990F100126_var*
//#UC END# *5214A361012B_4B990F100126_var*
begin
//#UC START# *5214A361012B_4B990F100126_impl*
 Result := AddChild(GetAliasName('Child'), aCaption);
//#UC END# *5214A361012B_4B990F100126_impl*
end;//TddAppConfiguration.AddChild

function TddAppConfiguration.AddColorItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: TColor = clBlack;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A3A90120_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A3A90120_4B990F100126_var*
begin
//#UC START# *5214A3A90120_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkInteger;
 l_Default.AsInteger := aDefault;
 Result := TddColorConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A3A90120_4B990F100126_impl*
end;//TddAppConfiguration.AddColorItem

function TddAppConfiguration.AddComboBoxItem(const aAlias: Il3CString;
 const aCaption: Il3CString;
 aDefaultValue: Integer;
 const aValueMap: Il3ValueMap = nil;
 aMasterItem: TddBaseConfigItem = nil;
 aMasterIndex: Integer = -1): TddBaseConfigItem;
//#UC START# *5214A3F7005C_4B990F100126_var*
var
 lValue: TddConfigValue;
//#UC END# *5214A3F7005C_4B990F100126_var*
begin
//#UC START# *5214A3F7005C_4B990F100126_impl*
 // по умолчанию
 with lValue do
 begin
  Kind := dd_vkInteger;
  AsInteger := aDefaultValue;
 end;
 Result := AddComboBoxItem(aAlias, aCaption, lValue, aValueMap, aMasterItem, aMasterIndex);
//#UC END# *5214A3F7005C_4B990F100126_impl*
end;//TddAppConfiguration.AddComboBoxItem

function TddAppConfiguration.AddComboBoxItem(const aAlias: Il3CString;
 const aCaption: Il3CString;
 const aDefaultValue: Il3CString;
 const aValueMap: Il3ValueMap = nil;
 aMasterItem: TddBaseConfigItem = nil;
 aMasterIndex: Integer = -1): TddBaseConfigItem;
//#UC START# *5214A4770220_4B990F100126_var*
var
 lValue: TddConfigValue;
//#UC END# *5214A4770220_4B990F100126_var*
begin
//#UC START# *5214A4770220_4B990F100126_impl*
 // по умолчанию
 with lValue do
 begin
  Kind := dd_vkString;
  AsString := l3Str(aDefaultValue);
 end;
 Result := AddComboBoxItem(aAlias, aCaption, lValue, aValueMap, aMasterItem, aMasterIndex);
//#UC END# *5214A4770220_4B990F100126_impl*
end;//TddAppConfiguration.AddComboBoxItem

function TddAppConfiguration.AddComboBoxItem(const aAlias: Il3CString;
 const aCaption: Il3CString;
 const aDefaultValue: TddConfigValue;
 const aValueMap: Il3ValueMap = nil;
 aMasterItem: TddBaseConfigItem = nil;
 aMasterIndex: Integer = -1): TddBaseConfigItem;
//#UC START# *5214A4B800A9_4B990F100126_var*
//#UC END# *5214A4B800A9_4B990F100126_var*
begin
//#UC START# *5214A4B800A9_4B990F100126_impl*
 Result := TddComboBoxConfigItem.Create(l3Str(aAlias), l3Str(aCaption), aDefaultValue, aValueMap, aMasterItem, aMasterIndex);
 AddItem(f_Selected, Result);
//#UC END# *5214A4B800A9_4B990F100126_impl*
end;//TddAppConfiguration.AddComboBoxItem

function TddAppConfiguration.AddDateItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: TDateTime = 0;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A514022C_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A514022C_4B990F100126_var*
begin
//#UC START# *5214A514022C_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkDateTime;
 l_Default.AsDateTime := aDefault;
 Result := TddDateConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A514022C_4B990F100126_impl*
end;//TddAppConfiguration.AddDateItem

function TddAppConfiguration.AddFileNameItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString = '';
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A56301DE_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A56301DE_4B990F100126_var*
begin
//#UC START# *5214A56301DE_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkString;
 l_Default.AsString := aDefault;
 Result := TddFileNameConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A56301DE_4B990F100126_impl*
end;//TddAppConfiguration.AddFileNameItem

function TddAppConfiguration.AddFolderNameItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString = '';
 aMasterItem: TddBaseConfigItem = nil;
 AllowProcessDir: Boolean = True): TddBaseConfigItem;
//#UC START# *5214A59C02AD_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A59C02AD_4B990F100126_var*
begin
//#UC START# *5214A59C02AD_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkString;
 l_Default.AsString := aDefault;
 Result := TddFolderNameConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 TddFolderNameConfigItem(Result).AllowProcessDir := AllowProcessDir;
 AddItem(f_Selected, Result);
//#UC END# *5214A59C02AD_4B990F100126_impl*
end;//TddAppConfiguration.AddFolderNameItem

function TddAppConfiguration.AddFontItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: TFont = nil;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A5DB02EB_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A5DB02EB_4B990F100126_var*
begin
//#UC START# *5214A5DB02EB_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkObject;
 l_Default.AsObject := TFont.Create;
 if aDefault <> nil then
  TFont(l_Default.AsObject).Assign(aDefault);
 Result := TddFontConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A5DB02EB_4B990F100126_impl*
end;//TddAppConfiguration.AddFontItem

function TddAppConfiguration.AddGroupItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A60802F2_4B990F100126_var*
//#UC END# *5214A60802F2_4B990F100126_var*
begin
//#UC START# *5214A60802F2_4B990F100126_impl*
 Result := TddGroupConfigItem.Create(aAlias, aCaption, ddEmptyValue, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A60802F2_4B990F100126_impl*
end;//TddAppConfiguration.AddGroupItem

function TddAppConfiguration.AddIntegerItem(const aAlias: Il3CString;
 const aCaption: Il3CString;
 aDefault: Integer = 0;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A67A039A_4B990F100126_var*
var
  l_Default: TddConfigValue;
//#UC END# *5214A67A039A_4B990F100126_var*
begin
//#UC START# *5214A67A039A_4B990F100126_impl*
 l_Default := ddEmptyIntValue;
 l_Default.AsInteger := aDefault;
 Result := TddIntegerConfigItem.Create(l3Str(aAlias), l3Str(aCaption), l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A67A039A_4B990F100126_impl*
end;//TddAppConfiguration.AddIntegerItem

function TddAppConfiguration.AddItem(aNode: TddCustomConfigNode;
 aItem: TddBaseConfigItem): TddBaseConfigItem;
//#UC START# *5214A6CC001B_4B990F100126_var*
//#UC END# *5214A6CC001B_4B990F100126_var*
begin
//#UC START# *5214A6CC001B_4B990F100126_impl*
 if (aNode <> nil) and not (aNode is TddCustomConfigNode) then
 begin
  aItem.Free; // может это и не нужно делать?
  raise EddConfigError.Create('Нельзя добавлять элементы в пользовательский узел');
 end;
 if f_Items.IndexOf(aItem.Alias) = -1 then
 begin
  f_Items.AddObject(aItem.Alias, aItem);
  aItem.AbsoluteIndex := f_Items.IndexOfObject(aItem);
  if f_Groups.Count = 0 then
  begin
   if aNode = nil then
    aNode := f_Root;
   (aNode as TddAppConfigNode).AddItem(aItem);{ TODO -oДимка -cРазвитие : Тут нужно как-то учитывать наследование узла }
  end
  // Добавляем подэлемент в группу
  else
   TddGroupConfigItem(f_Groups[Pred(f_Groups.Count)]).Add(aItem);
  if aItem is TddGroupConfigItem then
  begin
   f_CurItem := aItem;
   f_Groups.Add(aItem);
  end;
  Result := aItem;
  if Result is TddVisualConfigItem then
   TddVisualConfigItem(Result).LabelTop := f_LabelTop;
  f_IsNode := False;
 end
 else
 begin
 {   aItem.Free; // может это и не нужно делать?}
  raise EddConfigError.CreateFmt(str_PropertyExists.AsStr, [aItem.Alias]);
 end;
//#UC END# *5214A6CC001B_4B990F100126_impl*
end;//TddAppConfiguration.AddItem

function TddAppConfiguration.AddItem(aItem: TddBaseConfigItem): TddBaseConfigItem;
//#UC START# *5214A70B0001_4B990F100126_var*
//#UC END# *5214A70B0001_4B990F100126_var*
begin
//#UC START# *5214A70B0001_4B990F100126_impl*
 Result := AddItem(f_Selected, aItem);
//#UC END# *5214A70B0001_4B990F100126_impl*
end;//TddAppConfiguration.AddItem

function TddAppConfiguration.AddListItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDataAdapter: TddBaseConfigDataAdapter;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A72D0135_4B990F100126_var*
//#UC END# *5214A72D0135_4B990F100126_var*
begin
//#UC START# *5214A72D0135_4B990F100126_impl*
 Result := TddListConfigItem.Make(aAlias, aCaption, aDataAdapter, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A72D0135_4B990F100126_impl*
end;//TddAppConfiguration.AddListItem

function TddAppConfiguration.AddStringsItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A76101D5_4B990F100126_var*
//#UC END# *5214A76101D5_4B990F100126_var*
begin
//#UC START# *5214A76101D5_4B990F100126_impl*
 Result := TddStringListConfigItem.Make(aAlias, aCaption, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A76101D5_4B990F100126_impl*
end;//TddAppConfiguration.AddStringsItem

procedure TddAppConfiguration.AddMapValue(const aCaption: AnsiString;
 aValue: Integer);
//#UC START# *5214A78601B9_4B990F100126_var*
//#UC END# *5214A78601B9_4B990F100126_var*
begin
//#UC START# *5214A78601B9_4B990F100126_impl*
 if LastItem is TddMapValueConfigItem then
  (LastItem as TddMapValueConfigItem).AddMapValue(aCaption, aValue);
//#UC END# *5214A78601B9_4B990F100126_impl*
end;//TddAppConfiguration.AddMapValue

function TddAppConfiguration.AddNode(const aAlias: AnsiString;
 const aText: AnsiString): TddCustomConfigNode;
//#UC START# *5214A7C70162_4B990F100126_var*
//#UC END# *5214A7C70162_4B990F100126_var*
begin
//#UC START# *5214A7C70162_4B990F100126_impl*
 Result := f_Root.AddNode(aAlias, aText);
 f_Selected := Result;
 if UseScrollbars then
  f_Selected.ScrollBars := ssBoth;
 f_IsNode := True;
//#UC END# *5214A7C70162_4B990F100126_impl*
end;//TddAppConfiguration.AddNode

function TddAppConfiguration.AddRadioGroupItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: Integer = -1;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A81001DA_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A81001DA_4B990F100126_var*
begin
//#UC START# *5214A81001DA_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkInteger;
 l_Default.AsInteger := aDefault;
 Result := TddRadioGroupConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A81001DA_4B990F100126_impl*
end;//TddAppConfiguration.AddRadioGroupItem

{$If NOT Defined(Nemesis)}
function TddAppConfiguration.AddSoundFileNameItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString = '';
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A84001A4_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A84001A4_4B990F100126_var*
begin
//#UC START# *5214A84001A4_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkString;
 l_Default.AsString := aDefault;
 Result := TddSoundFileNameConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A84001A4_4B990F100126_impl*
end;//TddAppConfiguration.AddSoundFileNameItem
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
function TddAppConfiguration.AddTimeItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: TDateTime = 0;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A87C009C_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A87C009C_4B990F100126_var*
begin
//#UC START# *5214A87C009C_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkDateTime;
 l_Default.AsDateTime := aDefault;
 Result := TddTimeConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A87C009C_4B990F100126_impl*
end;//TddAppConfiguration.AddTimeItem
{$IfEnd} // NOT Defined(Nemesis)

function TddAppConfiguration.AddStringItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString = '';
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A9020204_4B990F100126_var*
//#UC END# *5214A9020204_4B990F100126_var*
begin
//#UC START# *5214A9020204_4B990F100126_impl*
 Result := TddStringConfigItem.Create(aAlias, aCaption, MakeStrValue(aDefault), aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A9020204_4B990F100126_impl*
end;//TddAppConfiguration.AddStringItem

function TddAppConfiguration.AddMasterSlaveItem(const Alias: AnsiString;
 const aCaption: AnsiString): TddBaseConfigItem;
//#UC START# *5214A9540294_4B990F100126_var*
//#UC END# *5214A9540294_4B990F100126_var*
begin
//#UC START# *5214A9540294_4B990F100126_impl*
 Result := TddMasterSlaveConfigItem.Create(Alias, aCaption, EmptyConfigValue);
 AddItem(f_Selected, Result);
//#UC END# *5214A9540294_4B990F100126_impl*
end;//TddAppConfiguration.AddMasterSlaveItem

function TddAppConfiguration.AddCheckListItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: Integer = -1;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A97702D5_4B990F100126_var*
var
 l_Default: TddConfigValue;
//#UC END# *5214A97702D5_4B990F100126_var*
begin
//#UC START# *5214A97702D5_4B990F100126_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkInteger;
 l_Default.AsInteger := aDefault;
 Result := TddCheckListConfigItem.Create(aAlias, aCaption, l_Default, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214A97702D5_4B990F100126_impl*
end;//TddAppConfiguration.AddCheckListItem

procedure TddAppConfiguration.AddDivider(const aCaption: AnsiString);
//#UC START# *5214A9A802F3_4B990F100126_var*
//#UC END# *5214A9A802F3_4B990F100126_var*
begin
//#UC START# *5214A9A802F3_4B990F100126_impl*
 AddItem(TddDividerConfigItem.Create(GetAliasName('Divider'), aCaption, EmptyConfigValue));
//#UC END# *5214A9A802F3_4B990F100126_impl*
end;//TddAppConfiguration.AddDivider

function TddAppConfiguration.AddGroupItem(const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214A9C30020_4B990F100126_var*
//#UC END# *5214A9C30020_4B990F100126_var*
begin
//#UC START# *5214A9C30020_4B990F100126_impl*
 Result := AddGroupItem(GetAliasName('Group'), aCaption, aMasterItem);
//#UC END# *5214A9C30020_4B990F100126_impl*
end;//TddAppConfiguration.AddGroupItem

function TddAppConfiguration.AddContainerGroup(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214AA1A00A8_4B990F100126_var*
//#UC END# *5214AA1A00A8_4B990F100126_var*
begin
//#UC START# *5214AA1A00A8_4B990F100126_impl*
 Result := TddContainerConfigItem.Create(aAlias, aCaption, ddEmptyValue, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214AA1A00A8_4B990F100126_impl*
end;//TddAppConfiguration.AddContainerGroup

procedure TddAppConfiguration.AddVersionHandler(aFromVersion: Integer;
 aToVersion: Integer;
 aProc: Tdd_acVersionUpgradeProc);
//#UC START# *5214AA4A01F8_4B990F100126_var*
//#UC END# *5214AA4A01F8_4B990F100126_var*
begin
//#UC START# *5214AA4A01F8_4B990F100126_impl*
 f_Versions.AddHandler(aFromVersion, aToVersion, aProc);
//#UC END# *5214AA4A01F8_4B990F100126_impl*
end;//TddAppConfiguration.AddVersionHandler

function TddAppConfiguration.AddSimpleListItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil): TddBaseConfigItem;
//#UC START# *5214AA710099_4B990F100126_var*
//#UC END# *5214AA710099_4B990F100126_var*
begin
//#UC START# *5214AA710099_4B990F100126_impl*
 Result := TddSimpleListConfigItem.Make(aAlias, aCaption, aMasterItem);
 AddItem(f_Selected, Result);
//#UC END# *5214AA710099_4B990F100126_impl*
end;//TddAppConfiguration.AddSimpleListItem

procedure TddAppConfiguration.CloseMasterSlaveItem;
//#UC START# *5214AA9E0286_4B990F100126_var*
//#UC END# *5214AA9E0286_4B990F100126_var*
begin
//#UC START# *5214AA9E0286_4B990F100126_impl*
 CloseGroup;
//#UC END# *5214AA9E0286_4B990F100126_impl*
end;//TddAppConfiguration.CloseMasterSlaveItem

procedure TddAppConfiguration.AddUserNode(aNode: TddCustomConfigNode;
 AsChild: Boolean = False);
//#UC START# *5214AAAB0358_4B990F100126_var*
//#UC END# *5214AAAB0358_4B990F100126_var*
begin
//#UC START# *5214AAAB0358_4B990F100126_impl*
 if f_Items.IndexOf(aNode.Alias) = -1 then
 begin
  if AsChild then
   AddChildNode(aNode)
  else
   AddNode(aNode);
  f_Items.AddObject(aNode.Alias, aNode);
 end
 else
 begin
  aNode.Free; // может это и не нужно делать?
  raise EddConfigError.CreateFmt(str_PropertyExists.AsStr, [aNode.Alias]);
 end;
//#UC END# *5214AAAB0358_4B990F100126_impl*
end;//TddAppConfiguration.AddUserNode

procedure TddAppConfiguration.AdjustFormSize(aForm: TCustomForm;
 aOptions: TddAppDialogOptions);
//#UC START# *5214AAC40249_4B990F100126_var*
//#UC END# *5214AAC40249_4B990F100126_var*
begin
//#UC START# *5214AAC40249_4B990F100126_impl*
 if AutoSize then
  RecalcFormSize(aForm)
 else
 begin
  aForm.ClientWidth := 560;
  aForm.ClientHeight := 404;
 end;
//#UC END# *5214AAC40249_4B990F100126_impl*
end;//TddAppConfiguration.AdjustFormSize

procedure TddAppConfiguration.ClearNode;
//#UC START# *5214AADE0148_4B990F100126_var*
//#UC END# *5214AADE0148_4B990F100126_var*
begin
//#UC START# *5214AADE0148_4B990F100126_impl*
 f_Selected := nil;
//#UC END# *5214AADE0148_4B990F100126_impl*
end;//TddAppConfiguration.ClearNode

procedure TddAppConfiguration.CloseChild;
//#UC START# *5214AAED0119_4B990F100126_var*
//#UC END# *5214AAED0119_4B990F100126_var*
begin
//#UC START# *5214AAED0119_4B990F100126_impl*
 f_Selected := f_Selected.Parent;
//#UC END# *5214AAED0119_4B990F100126_impl*
end;//TddAppConfiguration.CloseChild

procedure TddAppConfiguration.CloseGroup;
//#UC START# *5214AAFA0035_4B990F100126_var*
//#UC END# *5214AAFA0035_4B990F100126_var*
begin
//#UC START# *5214AAFA0035_4B990F100126_impl*
 if f_Groups.Count > 0 then
  f_Groups.Delete(Pred(f_Groups.Count));
 f_CurItem := nil;
//#UC END# *5214AAFA0035_4B990F100126_impl*
end;//TddAppConfiguration.CloseGroup

procedure TddAppConfiguration.MakeNodeVisible(aNode: TddCustomConfigNode);
//#UC START# *5214AB0B02FA_4B990F100126_var*
  function DoNode(const aN: Il3Node): Boolean;
  begin
   Result := ((aN As IddCNode).Control = aNode);
  end;

var
 l_N : Il3Node;
//#UC END# *5214AB0B02FA_4B990F100126_var*
begin
//#UC START# *5214AB0B02FA_4B990F100126_impl*
 if (f_ConfigTree <> nil) then
 begin
  l_N := f_ConfigTree.CTree.IterateF(l3L2NA(@DoNode), imCheckResult);
  if (l_N <> nil) then
   f_ConfigTree.GotoOnNode(l_N);
 end;//f_ConfigTree <> nil
//#UC END# *5214AB0B02FA_4B990F100126_impl*
end;//TddAppConfiguration.MakeNodeVisible

procedure TddAppConfiguration.FillDialog(aForm: TCustomForm;
 aOptions: TddAppDialogOptions = [];
 aCaptionPanelTypes: TddCaptionPanelTypes = []);
//#UC START# *5214AB33027F_4B990F100126_var*
var
 l_Tree: TFrame;
//#UC END# *5214AB33027F_4B990F100126_var*
begin
//#UC START# *5214AB33027F_4B990F100126_impl*
   { Итак, нам передали форму. Для того, чтобы все работало, нам нужно создать:
       - Дерево конфигурации
       - панель элементов (набор фреймов-панелей)
       - панель с кнопками
     При этом чего-то может и не быть, например, панели кнопок
   }
  if aForm <> nil then
  begin
   DialogOptions := aOptions;
   aForm.Caption := DialogCaption;
   {$IFNDEF Nemesis}
   (aForm as TForm).OnCloseQuery := DialogCloseQuery;
   {$ENDIF Nemesis}
   l_Tree := TTreeFrame.Create(aForm);
   l_Tree.Align := alLeft;
   f_WorkFrame := TWorkFrame.Create(aForm);
   f_WorkFrame.Align := alClient;
   {$IfDef Nemesis}
   f_WorkFrame.Color := cGarant2011BackColor;
   {$EndIf Nemesis}
   if aCaptionPanelTypes <> [] then
   begin
    if cptNormalBevel in aCaptionPanelTypes then
     f_WorkFrame.CaptionPanel.BevelWidth := 1;
   end;
   if not (dd_doNoButtons in aOptions) then
   begin
    f_ButtonsPanel := TButtonsFrame.Create(aForm);
    TButtonsFrame(f_ButtonsPanel).Font := aForm.Font;
    TButtonsFrame(f_ButtonsPanel).Align := alBottom;
    TButtonsFrame(f_ButtonsPanel).HelpButton.Visible := Application.HelpFile <> '';
    TButtonsFrame(f_ButtonsPanel).textVersion.Caption := '  '+ vtGetProgramVersion;
   end
   else
    f_ButtonsPanel := nil;
   l_Tree.Parent := aForm;
   if f_ButtonsPanel <> nil then
   begin
    f_ButtonsPanel.Parent := aForm;
    //TButtonsFrame(f_ButtonsPanel).OnHelpContextChange := TTreeFrame(l_Tree).HelpContextChange;
   end;
   l_Tree.Parent := aForm;
   f_WorkFrame.Parent := aForm;
   CalculateConstants(l_Tree, f_WorkFrame, f_ButtonsPanel);
   AdjustFormSize(aForm, aOptions);
   //l_Tree.Width := 165; // хитрая подхачка против беспредела Windows
   with (l_Tree as TTreeFrame) do
   begin
    CreateTree(f_Root, ConfigTree);
    CreateComponents(ConfigTree, f_WorkFrame.ComponentsPanel);
    WorkFrame := f_WorkFrame;
    f_ConfigTree := ConfigTree;
   end; // (l_Tree as TTreeFrame)
   ReadValuesFromDialog(False);
   aForm.ActiveControl := f_ConfigTree;
  end
  else
   raise EddConfigError.Create('Отсутствует форма для отображения конфигурации');
//#UC END# *5214AB33027F_4B990F100126_impl*
end;//TddAppConfiguration.FillDialog

function TddAppConfiguration.GetAliasName(const aAliasMask: AnsiString = 'AliasName'): AnsiString;
 {* Проверяет наличие элемента с указанным псевдонимом }
//#UC START# *5214AB510002_4B990F100126_var*
//#UC END# *5214AB510002_4B990F100126_var*
begin
//#UC START# *5214AB510002_4B990F100126_impl*
 repeat
  Inc(f_AliasNameIndex);
  Result := Format('%s%d', [aAliasMask, f_AliasNameIndex]);
 until Items.IndexOf(Result) = -1;
//#UC END# *5214AB510002_4B990F100126_impl*
end;//TddAppConfiguration.GetAliasName

function TddAppConfiguration.HasValue(const aAlias: AnsiString): Boolean;
//#UC START# *5214ABB50242_4B990F100126_var*
var
 l_Obj: TddBaseConfigItem;
//#UC END# *5214ABB50242_4B990F100126_var*
begin
//#UC START# *5214ABB50242_4B990F100126_impl*
 Result := HasValue(aAlias, l_Obj);
//#UC END# *5214ABB50242_4B990F100126_impl*
end;//TddAppConfiguration.HasValue

function TddAppConfiguration.HasValue(const aAlias: AnsiString;
 out theItem: TddBaseConfigItem): Boolean;
//#UC START# *5214ABE30015_4B990F100126_var*
//#UC END# *5214ABE30015_4B990F100126_var*
begin
//#UC START# *5214ABE30015_4B990F100126_impl*
 Result := f_Root.HasValue(aAlias, theItem);
//#UC END# *5214ABE30015_4B990F100126_impl*
end;//TddAppConfiguration.HasValue

procedure TddAppConfiguration.Load(const aStorage: IddConfigStorage = nil);
//#UC START# *5214AC07007A_4B990F100126_var*
var
 l_Storage: IddConfigStorage;
 l_Index: Integer;
//#UC END# *5214AC07007A_4B990F100126_var*
begin
//#UC START# *5214AC07007A_4B990F100126_impl*
 if aStorage = nil then
  l_Storage := f_Storage
 else
  l_Storage := aStorage;
 if l_Storage <> nil then
 try
  CheckVersion(l_Storage);
  TddBaseConfigItem(f_Root).Load(l_Storage);
  CheckEnabledStatus;
 finally
  l_Storage := nil;
 end; // f_Storage
 CheckRequiredValues;
 Changed := False;
//#UC END# *5214AC07007A_4B990F100126_impl*
end;//TddAppConfiguration.Load

function TddAppConfiguration.ReadValuesFromDialog(aRead: Boolean = True): Boolean;
//#UC START# *5214AC340284_4B990F100126_var*
  procedure _ReadValue(const aNode: TddCustomConfigNode);
  var
   I: Integer;
  begin
    if aRead then
     IddConfigNode(aNode).GetControlValues
    else
     IddConfigNode(aNode).SetControlValues(False);
    for I := 0 to Pred(aNode.ChildrenCount) do
     _ReadValue(aNode.Children[I]);
  end;
var
 I: Integer;
//#UC END# *5214AC340284_4B990F100126_var*
begin
//#UC START# *5214AC340284_4B990F100126_impl*
 Result := True;
 if aRead then
  AsInteger['_DialogIndex'] := f_ConfigTree.CTree.GetAbsIndex(f_ConfigTree.CurrentCNode)
 else
  f_ConfigTree.GotoOnNode(f_ConfigTree.CTree.GetNodeByAbsIndex(AsInteger['_DialogIndex']));
 try
  { Пробегаем по дереву и считываем или устанавливаем значения элементам }
  for I := 0 to Pred(f_Root.ChildrenCount) do
   _ReadValue(f_Root.Children[I]);
 except
  on E : EddInvalidValue do
  begin
   DoError(E.Message, E.Item);
   Result := False;
  end;
 end;
//#UC END# *5214AC340284_4B990F100126_impl*
end;//TddAppConfiguration.ReadValuesFromDialog

procedure TddAppConfiguration.ReloadDefault;
//#UC START# *5214AC67037C_4B990F100126_var*
//#UC END# *5214AC67037C_4B990F100126_var*
begin
//#UC START# *5214AC67037C_4B990F100126_impl*
  { TODO -oДмитрий Дудко -cРазвитие : Сброс всех значений в значение по умолчанию }
//#UC END# *5214AC67037C_4B990F100126_impl*
end;//TddAppConfiguration.ReloadDefault

procedure TddAppConfiguration.Save(const aStorage: IddConfigStorage = nil);
//#UC START# *5214AC7E0128_4B990F100126_var*
var
 l_Storage: IddConfigStorage;
//#UC END# *5214AC7E0128_4B990F100126_var*
begin
//#UC START# *5214AC7E0128_4B990F100126_impl*
 {$if defined(ServerAssistantSide)}
 Assert(False);
 {$else}
 if aStorage = nil then
  l_Storage := f_Storage
 else
  l_Storage := aStorage;

 if l_Storage <> nil then
  TddBaseConfigItem(f_Root).Save(l_Storage);
 {$IfEnd defined(ServerAssistantSide)}
//#UC END# *5214AC7E0128_4B990F100126_impl*
end;//TddAppConfiguration.Save

function TddAppConfiguration.ShowDialog(const aCaption: AnsiString = '';
 aValidate: Boolean = False): Boolean;
//#UC START# *5214ACB801E8_4B990F100126_var*
var
 l_Ok: Boolean;
//#UC END# *5214ACB801E8_4B990F100126_var*
begin
//#UC START# *5214ACB801E8_4B990F100126_impl*
 Result := False;
 if aCaption <> '' then
  f_DialogCaption := aCaption;
 if f_Dialog = nil then
 begin
  f_Dialog := TForm.Create(Application);
  with TForm(f_Dialog) do
  try
   afwHackControlFont(f_Dialog);
   BorderStyle := bsDialog;
   Position := poScreenCenter;
   FillDialog(f_Dialog);
   ShowHint := True;
   l_Ok := True;
   repeat
    if f_RequiredNode <> nil then
     MakeNodeVisible(f_RequiredNode);
    if ShowModal = mrOk then
    begin
     Result := True;
     ReadValuesFromDialog(True);
     WorkupChanged;
     CheckEnabledStatus;
     if aValidate then
      l_Ok := CheckRequiredValues
     else
      l_Ok := True;
     if not l_Ok then
      MessageDlg(f_RequiredMessage, mtError, [mbOk], 0)
     else
      Save;
    end
    else
    begin
     Result := False;
     l_Ok := True;
    end;
   until l_Ok;
   ClearControls;
   f_ConfigTree := nil;
  finally
   FreeAndNil(f_Dialog);
  end
 end
 else
  f_Dialog.BringToFront;
//#UC END# *5214ACB801E8_4B990F100126_impl*
end;//TddAppConfiguration.ShowDialog

function TddAppConfiguration.ShowNodeDialog(const aAlias: AnsiString): Boolean;
//#UC START# *5214ACE103D9_4B990F100126_var*
var
 l_Node: TddBaseConfigItem;
//#UC END# *5214ACE103D9_4B990F100126_var*
begin
//#UC START# *5214ACE103D9_4B990F100126_impl*
 Result := False;
 if HasValue(aAlias, l_Node) then
 begin
  if l_Node is TddAppConfigNode then
   Result := ExecuteNodeDialog(TddAppConfigNode(l_Node))
  else
   raise EddConfigError.CreateFmt('Элемент %s не является узлом', [aAlias]);
 end
 else
  raise EddConfigError.CreateFmt('Отсутствует элемент %s', [aAlias]);
//#UC END# *5214ACE103D9_4B990F100126_impl*
end;//TddAppConfiguration.ShowNodeDialog

procedure TddAppConfiguration.DialogCloseQuery(Sender: TObject;
 var CanClose: Boolean);
//#UC START# *544635CC0079_4B990F100126_var*
//#UC END# *544635CC0079_4B990F100126_var*
begin
//#UC START# *544635CC0079_4B990F100126_impl*
 Assert(Assigned(f_Dialog));
 if f_Dialog.ModalResult = mrOk then
 begin
  if not ReadValuesFromDialog(True) then
  begin
   f_Dialog.ModalResult := mrNone;
   CanClose := False;
  end;
 end; 
//#UC END# *544635CC0079_4B990F100126_impl*
end;//TddAppConfiguration.DialogCloseQuery

procedure TddAppConfiguration.SetReadOnly(aValue: Boolean);
//#UC START# *552BA42B0337_4B990F100126_var*
//#UC END# *552BA42B0337_4B990F100126_var*
begin
//#UC START# *552BA42B0337_4B990F100126_impl*
 f_Root.ReadOnly := True;
//#UC END# *552BA42B0337_4B990F100126_impl*
end;//TddAppConfiguration.SetReadOnly

procedure TddAppConfiguration.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B990F100126_var*
//#UC END# *479731C50290_4B990F100126_var*
begin
//#UC START# *479731C50290_4B990F100126_impl*
 FreeAndNil(f_Versions); 
 FreeAndNil(f_Groups);
 FreeAndNil(f_Items);
 FreeAndNil(f_Root);
 f_Storage := nil;
 inherited;
//#UC END# *479731C50290_4B990F100126_impl*
end;//TddAppConfiguration.Cleanup

procedure TddAppConfiguration.BeforeRelease;
//#UC START# *49BFC98902FF_4B990F100126_var*
//#UC END# *49BFC98902FF_4B990F100126_var*
begin
//#UC START# *49BFC98902FF_4B990F100126_impl*
 if AutoSave then
  Save;
 inherited;
//#UC END# *49BFC98902FF_4B990F100126_impl*
end;//TddAppConfiguration.BeforeRelease

procedure TddAppConfiguration.ClearFields;
begin
 DialogCaption := '';
 FontName := '';
 RequiredMessage := '';
 inherited;
end;//TddAppConfiguration.ClearFields

constructor TddCNode.Create(aNode: TddCustomConfigNode);
//#UC START# *521486E4013C_52148644004C_var*
//#UC END# *521486E4013C_52148644004C_var*
begin
//#UC START# *521486E4013C_52148644004C_impl*
 inherited Create;
 f_Node := aNode;
 Text := l3PCharLen(aNode.Caption);
//#UC END# *521486E4013C_52148644004C_impl*
end;//TddCNode.Create

class function TddCNode.Make(aNode: TddCustomConfigNode): Il3Node;
var
 l_Inst : TddCNode;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TddCNode.Make

function TddCNode.Get_Control: TddCustomConfigNode;
//#UC START# *5214861D002A_52148644004Cget_var*
//#UC END# *5214861D002A_52148644004Cget_var*
begin
//#UC START# *5214861D002A_52148644004Cget_impl*
 Result := f_Node;
//#UC END# *5214861D002A_52148644004Cget_impl*
end;//TddCNode.Get_Control

end.
