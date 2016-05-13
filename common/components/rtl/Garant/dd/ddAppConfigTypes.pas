unit ddAppConfigTypes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfigTypes" MUID: (52161F2B00C4)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , ddConfigStorages
 , SysUtils
 , ddAppConfigConst
 , ddAppConfigBase
 , l3ObjectList
 , l3ProtoPersistentRefList
 , l3Interfaces
 , vtLabel
 , Graphics
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3VCLStrings
 , Contnrs
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 , vtComboBoxQS
;

type
 RddBaseConfigItem = class of TddBaseConfigItem;

 RddBaseConfigNode = class of TddCustomConfigNode;

 IddMasterItem = interface
  ['{7186411A-F177-458A-802C-2A40BE15A74A}']
  function pm_GetBooleanValue: Boolean;
  property BooleanValue: Boolean
   read pm_GetBooleanValue;
 end;//IddMasterItem

 IddConfigNode = interface
  ['{66FB62AB-6EBC-45C3-88BD-2EE1037AAE9C}']
  function pm_GetChanged: Boolean;
  procedure ClearControls;
  function CreateFrame(aOwner: TComponent;
   aTag: Integer): TCustomFrame;
  procedure FrameSize(aParent: TWinControl;
   out aHeight: Integer;
   out aWidth: Integer);
  procedure GetControlValues;
  function IsItem(aItem: TObject): Boolean;
  procedure LoadData(const aStorage: IddConfigStorage);
  procedure ResetToDefault;
  procedure SaveData(const aStorage: IddConfigStorage);
  procedure SetControlValues(aDefault: Boolean);
  property Changed: Boolean
   read pm_GetChanged;
 end;//IddConfigNode

 EddConfigError = class(Exception)
 end;//EddConfigError

 TddBaseConfigItem = class;

 TddValueChangedEvent = procedure(aItem: TddBaseConfigItem;
  const aValue: TddConfigValue) of object;

 TddConfigItemLabelType = (
  dd_cilMain
  , dd_cilAdditional
  , dd_cilRequired
 );//TddConfigItemLabelType

 TddBaseConfigItem = class(TddAppConfigBase)
  private
   f_Locked: Integer;
   f_Slaves: Tl3ObjectList;
   f_NotifyList: Tl3ObjectList;
   f_AbsoluteIndex: Integer;
   f_Alias: AnsiString;
   f_Caption: AnsiString;
   f_Changed: Boolean;
   f_DefaultValue: TddConfigValue;
   f_Enabled: Boolean;
   f_HelpContext: Integer;
   f_MasterItem: TddBaseConfigItem;
   f_Required: Boolean;
   f_OnChange: TNotifyEvent;
   f_OnNotify: TddValueChangedEvent;
   f_ReadOnly: Boolean;
  protected
   f_Value: TddConfigValue;
  private
   procedure AddSlave(aSlave: TddBaseConfigItem);
   procedure RemoveSlave(aSlave: TddBaseConfigItem);
  protected
   procedure pm_SetAlias(const aValue: AnsiString); virtual;
   function pm_GetBooleanValue: Boolean; virtual;
   procedure pm_SetBooleanValue(aValue: Boolean); virtual;
   function pm_GetChanged: Boolean; virtual;
   procedure pm_SetChanged(aValue: Boolean); virtual;
   function pm_GetDateTimeValue: TDateTime; virtual;
   procedure pm_SetDateTimeValue(aValue: TDateTime); virtual;
   function pm_GetDefaultBooleanValue: Boolean;
   procedure pm_SetDefaultBooleanValue(aValue: Boolean);
   function pm_GetDefaultDateTimeValue: TDateTime;
   procedure pm_SetDefaultDateTimeValue(aValue: TDateTime);
   function pm_GetDefaultIntegerValue: Integer;
   procedure pm_SetDefaultIntegerValue(aValue: Integer);
   function pm_GetDefaultObjectValue: TObject;
   procedure pm_SetDefaultObjectValue(aValue: TObject);
   function pm_GetDefaultStringValue: AnsiString;
   procedure pm_SetDefaultStringValue(const aValue: AnsiString);
   procedure pm_SetDefaultValue(const aValue: TddConfigValue);
   function pm_GetEnabled: Boolean; virtual;
   procedure pm_SetEnabled(aValue: Boolean); virtual;
   function pm_GetIntegerValue: Integer;
   procedure pm_SetIntegerValue(aValue: Integer);
   function pm_GetIsRequired: Boolean;
   procedure pm_SetMasterItem(aValue: TddBaseConfigItem); virtual;
   function pm_GetObjectValue: TObject;
   procedure pm_SetObjectValue(aValue: TObject);
   function pm_GetRequired: Boolean; virtual;
   procedure pm_SetRequired(aValue: Boolean); virtual;
   function pm_GetStringValue: AnsiString; virtual;
   procedure pm_SetStringValue(const aValue: AnsiString); virtual;
   function pm_GetValue: TddConfigValue; virtual;
   procedure pm_SetValue(const aValue: TddConfigValue); virtual;
   procedure pm_SetReadOnly(aValue: Boolean);
   procedure Changing;
   procedure DoEnabled; virtual;
   function MayBeRequired: Boolean; virtual;
   procedure ProcessNotify(const aValue: TddConfigValue);
   procedure ReadOnlyChanged; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure Reset; virtual;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); reintroduce; virtual;
   procedure AddNotify(aItem: TddBaseConfigItem);
   procedure AssignValue(const aValue: TddConfigValue;
    aOnChange: Boolean = False); virtual;
    {* функция сравнения объекта с другим объектом.  Для перекрытия в потомках. }
   function HasValue(const anAlias: AnsiString;
    out theItem: TddBaseConfigItem): Boolean; overload; virtual;
   function HasValue(const anAlias: AnsiString): Boolean; overload; virtual;
   function IsLocked: Boolean;
   procedure Load(const aStorage: IddConfigStorage);
   procedure LoadValue(const aStorage: IddConfigStorage); virtual;
   procedure Lock;
   procedure Unlock;
   procedure RemoveNotify(aItem: TddBaseConfigItem);
   procedure ResetToDefault;
   procedure Save(const aStorage: IddConfigStorage);
   procedure SaveValue(const aStorage: IddConfigStorage); virtual;
   procedure Assign(Source: TPersistent); override;
   function Clone: Pointer; override;
  public
   property AbsoluteIndex: Integer
    read f_AbsoluteIndex
    write f_AbsoluteIndex;
   property Alias: AnsiString
    read f_Alias
    write pm_SetAlias;
   property BooleanValue: Boolean
    read pm_GetBooleanValue
    write pm_SetBooleanValue;
   property Caption: AnsiString
    read f_Caption
    write f_Caption;
   property Changed: Boolean
    read pm_GetChanged
    write pm_SetChanged;
   property DateTimeValue: TDateTime
    read pm_GetDateTimeValue
    write pm_SetDateTimeValue;
   property DefaultBooleanValue: Boolean
    read pm_GetDefaultBooleanValue
    write pm_SetDefaultBooleanValue;
   property DefaultDateTimeValue: TDateTime
    read pm_GetDefaultDateTimeValue
    write pm_SetDefaultDateTimeValue;
   property DefaultIntegerValue: Integer
    read pm_GetDefaultIntegerValue
    write pm_SetDefaultIntegerValue;
   property DefaultObjectValue: TObject
    read pm_GetDefaultObjectValue
    write pm_SetDefaultObjectValue;
   property DefaultStringValue: AnsiString
    read pm_GetDefaultStringValue
    write pm_SetDefaultStringValue;
   property DefaultValue: TddConfigValue
    read f_DefaultValue
    write pm_SetDefaultValue;
   property Enabled: Boolean
    read pm_GetEnabled
    write pm_SetEnabled;
   property HelpContext: Integer
    read f_HelpContext
    write f_HelpContext;
   property IntegerValue: Integer
    read pm_GetIntegerValue
    write pm_SetIntegerValue;
   property IsRequired: Boolean
    read pm_GetIsRequired;
   property MasterItem: TddBaseConfigItem
    read f_MasterItem
    write pm_SetMasterItem;
   property ObjectValue: TObject
    read pm_GetObjectValue
    write pm_SetObjectValue;
   property Required: Boolean
    read pm_GetRequired
    write pm_SetRequired;
   property StringValue: AnsiString
    read pm_GetStringValue
    write pm_SetStringValue;
   property Value: TddConfigValue
    read pm_GetValue
    write pm_SetValue;
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
   property OnNotify: TddValueChangedEvent
    read f_OnNotify
    write f_OnNotify;
   property ReadOnly: Boolean
    read f_ReadOnly
    write pm_SetReadOnly;
 end;//TddBaseConfigItem

 TddButtonPlace = (
  dd_bpAsDefine
  , dd_bpBottomRight
 );//TddButtonPlace

 TMapValue = class(TddAppConfigBase)
  private
   f_Value: TddConfigValue;
   f_Caption: AnsiString;
  protected
   procedure pm_SetValue(const aValue: TddConfigValue);
   procedure pm_SetCaption(const aValue: AnsiString);
   procedure ClearFields; override;
  public
   procedure Assign(Source: TPersistent); override;
   constructor Create; override;
  public
   property Value: TddConfigValue
    read f_Value
    write pm_SetValue;
   property Caption: AnsiString
    read f_Caption
    write pm_SetCaption;
 end;//TMapValue

 TMapValues = class(TddAppConfigBase)
  private
   f_List: Tl3ProtoPersistentRefList;
   f_MapKind: TddValueKind;
  private
   procedure CheckValueType(aKind: TddValueKind);
  protected
   function pm_GetCount: Integer; virtual;
   function pm_GetItems(aIndex: Integer): TMapValue;
   procedure pm_SetItems(aIndex: Integer;
    aValue: TMapValue);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function IndexOfCaption(const aCaption: Il3CString): Integer;
   function IndexOfValue(const aValue: TddConfigValue): Integer;
   procedure Clear; virtual;
   procedure AddMapValue(const aCaption: AnsiString;
    const aValue: TddConfigValue);
   constructor Create(aKind: TddValueKind); reintroduce;
   procedure Assign(Source: TPersistent); override;
  public
   property MapKind: TddValueKind
    read f_MapKind;
   property Count: Integer
    read pm_GetCount;
   property Items[aIndex: Integer]: TMapValue
    read pm_GetItems
    write pm_SetItems;
    default;
 end;//TMapValues

 TddVisualConfigItem = class(TddBaseConfigItem)
  private
   f_Label: TvtLabel;
   f_RequiredLabel: TvtLabel;
   f_Control: TControl;
   f_FirstLabel: TvtLabel;
   f_Hint: AnsiString;
   f_Labeled: Boolean;
   f_Visible: Boolean;
  protected
   f_LabelTop: Boolean;
  protected
   function pm_GetLabeled: Boolean; virtual;
   function pm_GetLabelTop: Boolean; virtual;
   procedure pm_SetLabelTop(aValue: Boolean); virtual;
   function pm_GetFullControlHeight(aParent: TWinControl): Integer; virtual;
   procedure AdjustLabel(theControl: TControl;
    theLabel: TvtLabel);
   procedure AfterConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    theControl: TControl;
    theLabel: TvtLabel); virtual;
   procedure BeforeConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl); virtual;
   procedure ChangeSlaveStatus(aEnabled: Boolean);
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; virtual; abstract;
   function CreateLabel(aParent: TWinControl;
    const aCaption: AnsiString;
    var aLeft: Integer;
    var aTop: Integer;
    aLabelType: TddConfigItemLabelType = dd_cilMain): TvtLabel;
   function GetCanvas(aParent: TWinControl): TCanvas;
   function GetForm(aParent: TWinControl): TCustomForm;
   procedure SplitCaption(const aCaption: AnsiString;
    out aPrefix: AnsiString;
    out aSuffix: AnsiString);
   procedure AdjustReadOnly(aControl: TControl); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoEnabled; override;
   function pm_GetChanged: Boolean; override;
   procedure pm_SetChanged(aValue: Boolean); override;
   function pm_GetValue: TddConfigValue; override;
   procedure pm_SetValue(const aValue: TddConfigValue); override;
   procedure ReadOnlyChanged; override;
   procedure ClearFields; override;
  public
   function IsSame(anItem: TObject): Boolean; virtual;
   procedure ClearControl; virtual;
   function ControlHeight(aParent: TWinControl): Integer; virtual; abstract;
   function CreateControl(aLeft: Integer;
    aMaxLeft: Integer;
    aTop: Integer;
    aParent: TWinControl): TControl;
   procedure GetValueFromControl; virtual; abstract;
   function LabelHeight(aParent: TWinControl): Integer;
   function LabelWidth(aParent: TWinControl): Integer; virtual;
   function MinWidth(aParent: TWinControl): Integer; virtual;
   procedure SetValueToControl(aDefault: Boolean); virtual; abstract;
   procedure Assign(Source: TPersistent); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
  protected
   property FirstLabel: TvtLabel
    read f_FirstLabel
    write f_FirstLabel;
  public
   property Control: TControl
    read f_Control
    write f_Control;
   property Hint: AnsiString
    read f_Hint
    write f_Hint;
   property Labeled: Boolean
    read pm_GetLabeled
    write f_Labeled;
   property LabelTop: Boolean
    read pm_GetLabelTop
    write pm_SetLabelTop;
   property Visible: Boolean
    read f_Visible
    write f_Visible;
   property FullControlHeight[aParent: TWinControl]: Integer
    read pm_GetFullControlHeight;
 end;//TddVisualConfigItem

 TddIntegerConfigItem = class(TddVisualConfigItem)
  private
   f_UpDown: TUpDown;
   f_MaxValue: Integer;
   f_MinValue: Integer;
  protected
   procedure pm_SetMaxValue(aValue: Integer);
   procedure pm_SetMinValue(aValue: Integer);
   procedure Validate;
   procedure DoOnChange(Sender: TObject); virtual;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   function pm_GetLabelTop: Boolean; override;
   procedure pm_SetLabelTop(aValue: Boolean); override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   constructor CreateItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefaultValue: Integer;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   procedure Assign(Source: TPersistent); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   procedure ClearControl; override;
   function MinWidth(aParent: TWinControl): Integer; override;
  public
   property MaxValue: Integer
    read f_MaxValue
    write pm_SetMaxValue;
   property MinValue: Integer
    read f_MinValue
    write pm_SetMinValue;
 end;//TddIntegerConfigItem

 EddInvalidValue = class(EddConfigError)
  private
   f_Item: TddVisualConfigItem;
  public
   constructor CreateFmt(const aMsg: AnsiString;
    const Args: array of const;
    aItem: TddVisualConfigItem); reintroduce;
  public
   property Item: TddVisualConfigItem
    read f_Item;
 end;//EddInvalidValue

 TddMapValueConfigItem = class(TddVisualConfigItem)
  private
   f_ValueKind: TddValueKind;
   f_ValueMap: Il3ValueMap;
  protected
   f_MapValues: TMapValues;
  private
   function DisplayNameToValue(const aName: Il3CString): TddConfigValue;
  protected
   procedure pm_SetItem(const aValue: AnsiString);
   function DisplayNameContainer: Tl3Strings; virtual; abstract;
   function IsSet: Boolean;
   function CalcDisplayName(const aValue: TddConfigValue): AnsiString;
   function CalcValue(const aName: Il3CString): TddConfigValue;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure AddMapValue(const aCaption: AnsiString;
    const aValue: TddConfigValue); overload;
   procedure AddMapValue(const aCaption: AnsiString;
    aValue: Integer); overload;
   procedure AddMapValue(const aCaption: AnsiString;
    const aValue: AnsiString); overload;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    const aValueMap: Il3ValueMap = nil;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   procedure Assign(Source: TPersistent); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function Clone: Pointer; override;
  public
   property Item: AnsiString
    write pm_SetItem;
   property ValueMap: Il3ValueMap
    read f_ValueMap;
 end;//TddMapValueConfigItem

 TddRadioGroupConfigItem = class(TddIntegerConfigItem)
  private
   f_Items: TStrings;
   f_MaxCount: Integer;
  protected
   procedure pm_SetMaxCount(aValue: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetLabelTop: Boolean; override;
   procedure pm_SetLabelTop(aValue: Boolean); override;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure DoOnChange(Sender: TObject); override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   procedure Add(const aItem: AnsiString);
   procedure Assign(Source: TPersistent); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
  public
   property MaxCount: Integer
    read f_MaxCount
    write pm_SetMaxCount;
 end;//TddRadioGroupConfigItem

 TddRadioConfigItem = class(TddVisualConfigItem)
  protected
   procedure DoOnChange(Sender: TObject);
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   constructor CreateItem(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefaultValue: Boolean;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   function MinWidth(aParent: TWinControl): Integer; override;
 end;//TddRadioConfigItem

 TddGroupConfigItem = class(TddVisualConfigItem)
  private
   f_SubItems: TObjectList;
   f_ShowCaption: Boolean;
  private
   procedure DoOnChange(Sender: TObject);
  protected
   function pm_GetSubItem(Index: Integer): TddVisualConfigItem;
   function pm_GetCount: Integer;
   function HeaderHeight(aParent: TWinControl): Integer; virtual;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetChanged: Boolean; override;
   procedure pm_SetChanged(aValue: Boolean); override;
   function pm_GetEnabled: Boolean; override;
   procedure pm_SetEnabled(aValue: Boolean); override;
   function MayBeRequired: Boolean; override;
   function pm_GetFullControlHeight(aParent: TWinControl): Integer; override;
   procedure ReadOnlyChanged; override;
  public
   constructor SimpleCreate(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   function ItemsLabelWidth(aParent: TWinControl;
    var aLeftLabeled: Integer): Integer;
   function Add(aItem: TddBaseConfigItem): TddBaseConfigItem; virtual;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   procedure Assign(Source: TPersistent); override;
   procedure Reset; override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   function HasValue(const anAlias: AnsiString;
    out theItem: TddBaseConfigItem): Boolean; override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function IsSame(anItem: TObject): Boolean; override;
   procedure ClearControl; override;
   function LabelWidth(aParent: TWinControl): Integer; override;
   function MinWidth(aParent: TWinControl): Integer; override;
  public
   property SubItems: TObjectList
    read f_SubItems;
   property ShowCaption: Boolean
    read f_ShowCaption
    write f_ShowCaption;
   property SubItem[Index: Integer]: TddVisualConfigItem
    read pm_GetSubItem;
   property Count: Integer
    read pm_GetCount;
 end;//TddGroupConfigItem

 TddFontConfigItem = class(TddVisualConfigItem)
  protected
   procedure FontButtonClick(Sender: TObject);
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AfterConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    theControl: TControl;
    theLabel: TvtLabel); override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
 end;//TddFontConfigItem

 TddBaseStringsConfigItem = {abstract} class(TddMapValueConfigItem)
  protected
   function pm_GetControlClass: TControlClass; virtual;
   function pm_GetSelectedItemIndex: Integer; virtual;
   procedure pm_SetSelectedItemIndex(aValue: Integer); virtual;
   function pm_GetControlStrings: Il3StringsEx; virtual;
   procedure DoOnChange(aSender: TObject); virtual;
   procedure CheckLoadItems; virtual;
   procedure SelectValue(aValue: Integer); virtual;
   procedure InitControl(aControl: TControl); virtual;
   procedure AssignStringsToControl(const aStrings: Il3StringsEx); virtual;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   function DisplayNameContainer: Tl3Strings; override;
  public
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
  protected
   property ControlClass: TControlClass
    read pm_GetControlClass;
   property SelectedItemIndex: Integer
    read pm_GetSelectedItemIndex
    write pm_SetSelectedItemIndex;
   property ControlStrings: Il3StringsEx
    read pm_GetControlStrings;
 end;//TddBaseStringsConfigItem

 TddCustomConfigNode = class(TddBaseConfigItem, IddConfigNode)
  private
   f_Alias: AnsiString;
   f_Caption: AnsiString;
   f_OnChange: TNotifyEvent;
   f_HelpContext: Integer;
   f_Parent: TddCustomConfigNode;
   f_ParentAlias: AnsiString;
   f_ScrollBars: TScrollStyle;
  protected
   f_Children: Tl3ProtoPersistentRefList;
  protected
   function pm_GetChildrenCount: Integer;
   function pm_GetChildren(anIndex: Integer): TddCustomConfigNode; virtual;
   function pm_GetIsHorizontalScrollBar: Boolean;
   function pm_GetIsVerticalScrollBar: Boolean;
   procedure pm_SetParent(aValue: TddCustomConfigNode);
   procedure ItemChanged(Sender: TObject);
   procedure DoClearControls; virtual; abstract;
   function DoCreateFrame(aOwner: TComponent;
    aTag: Integer): TCustomFrame; virtual; abstract;
   procedure DoFrameSize(aParent: TWinControl;
    out aHeight: Integer;
    out aWidth: Integer); virtual;
   procedure DoGetControlValues; virtual; abstract;
   function DoIsItem(aItem: TObject): Boolean; virtual; abstract;
   procedure DoLoad(const aStorage: IddConfigStorage); virtual; abstract;
   procedure DoResetToDefault; virtual;
   procedure DoSave(const aStorage: IddConfigStorage); virtual; abstract;
   procedure DoSetControlValues(aDefault: Boolean); virtual; abstract;
   procedure ClearControls;
   function CreateFrame(aOwner: TComponent;
    aTag: Integer): TCustomFrame;
   procedure FrameSize(aParent: TWinControl;
    out aHeight: Integer;
    out aWidth: Integer);
   procedure GetControlValues;
   function IsItem(aItem: TObject): Boolean;
   procedure LoadData(const aStorage: IddConfigStorage);
   procedure ResetToDefault;
   procedure SaveData(const aStorage: IddConfigStorage);
   procedure SetControlValues(aDefault: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetChanged: Boolean; override;
   procedure pm_SetChanged(aValue: Boolean); override;
   function pm_GetValue: TddConfigValue; override;
   procedure pm_SetValue(const aValue: TddConfigValue); override;
   procedure ReadOnlyChanged; override;
   procedure ClearFields; override;
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString); reintroduce;
   function AddNode(const aAlias: AnsiString): TddCustomConfigNode; overload;
   function AddNode(const aAlias: AnsiString;
    const aCaption: AnsiString): TddCustomConfigNode; overload;
   function AddNode(aNode: TddCustomConfigNode): TddCustomConfigNode; overload;
   function IsRequired(out aMessage: AnsiString): Boolean; virtual;
   procedure PostEdit; virtual;
   procedure Assign(Source: TPersistent); override;
   function Clone: Pointer; override;
  public
   property Alias: AnsiString
    read f_Alias
    write f_Alias;
   property Caption: AnsiString
    read f_Caption
    write f_Caption;
   property ChildrenCount: Integer
    read pm_GetChildrenCount;
   property Children[anIndex: Integer]: TddCustomConfigNode
    read pm_GetChildren;
   property IsHorizontalScrollBar: Boolean
    read pm_GetIsHorizontalScrollBar;
   property IsVerticalScrollBar: Boolean
    read pm_GetIsVerticalScrollBar;
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
   property HelpContext: Integer
    read f_HelpContext
    write f_HelpContext;
   property Parent: TddCustomConfigNode
    read f_Parent
    write pm_SetParent;
   property ParentAlias: AnsiString
    read f_ParentAlias;
   property ScrollBars: TScrollStyle
    read f_ScrollBars
    write f_ScrollBars;
 end;//TddCustomConfigNode

 TddBooleanConfigItem = class(TddVisualConfigItem, IddMasterItem)
  private
   procedure OnClick(Sender: TObject);
  protected
   function pm_GetBooleanValue: Boolean;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   function pm_GetRequired: Boolean; override;
   procedure pm_SetRequired(aValue: Boolean); override;
   function MayBeRequired: Boolean; override;
   function pm_GetFullControlHeight(aParent: TWinControl): Integer; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function MinWidth(aParent: TWinControl): Integer; override;
 end;//TddBooleanConfigItem

 TddButtonConfigItem = class(TddVisualConfigItem)
  private
   f_OnClick: TNotifyEvent;
   f_ButtonPlace: TddButtonPlace;
  private
   procedure ButtonSize(aParent: TWinControl;
    out aSize: TSize);
  protected
   procedure pm_SetOnClick(aValue: TNotifyEvent);
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   function pm_GetRequired: Boolean; override;
   procedure pm_SetRequired(aValue: Boolean); override;
   function MayBeRequired: Boolean; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   constructor Create(const anAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aClick: TNotifyEvent;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   procedure Assign(Source: TPersistent); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function MinWidth(aParent: TWinControl): Integer; override;
  public
   property OnClick: TNotifyEvent
    read f_OnClick
    write pm_SetOnClick;
   property ButtonPlace: TddButtonPlace
    read f_ButtonPlace
    write f_ButtonPlace;
 end;//TddButtonConfigItem

 TddColorConfigItem = class(TddIntegerConfigItem)
  protected
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure DoOnChange(Sender: TObject); override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
 end;//TddColorConfigItem

 TddConfigChangedEvent = procedure(Sender: TddCustomConfigNode) of object;

 TddCheckListConfigItem = class(TddRadioGroupConfigItem)
  private
   f_Columns: Integer;
  protected
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   procedure Assign(Source: TPersistent); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
  public
   property Columns: Integer
    read f_Columns
    write f_Columns;
 end;//TddCheckListConfigItem

 TddDividerConfigItem = class(TddVisualConfigItem)
  protected
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   function MayBeRequired: Boolean; override;
  public
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function LabelWidth(aParent: TWinControl): Integer; override;
   function MinWidth(aParent: TWinControl): Integer; override;
 end;//TddDividerConfigItem

 TddAppConfigNode = class(TddCustomConfigNode)
  private
   f_Objects: Tl3ProtoPersistentRefList;
   f_LabelTop: Boolean;
  protected
   procedure pm_SetObjects(aValue: Tl3ProtoPersistentRefList);
   procedure pm_SetLabelTop(aValue: Boolean);
   function pm_GetItems(anIndex: Integer): TddVisualConfigItem;
   function pm_GetItemByIndex(anIndex: Integer): TddVisualConfigItem;
   function pm_GetAsBoolean(const anAlias: AnsiString): Boolean;
   procedure pm_SetAsBoolean(const anAlias: AnsiString;
    aValue: Boolean);
   function pm_GetAsDateTime(const anAlias: AnsiString): TDateTime;
   procedure pm_SetAsDateTime(const anAlias: AnsiString;
    aValue: TDateTime);
   function pm_GetAsInteger(const anAlias: AnsiString): Integer;
   procedure pm_SetAsInteger(const anAlias: AnsiString;
    aValue: Integer);
   function pm_GetAsObject(const anAlias: AnsiString): TObject;
   procedure pm_SetAsObject(const anAlias: AnsiString;
    aValue: TObject);
   function pm_GetAsString(const anAlias: AnsiString): AnsiString;
   procedure pm_SetAsString(const anAlias: AnsiString;
    const aValue: AnsiString);
   function pm_GetCount: Integer;
   function pm_GetItemByAlias(const anAlias: AnsiString): TddBaseConfigItem;
   procedure DoClearControls; override;
   function DoCreateFrame(aOwner: TComponent;
    aTag: Integer): TCustomFrame; override;
   procedure DoGetControlValues; override;
   function DoIsItem(aItem: TObject): Boolean; override;
   procedure DoLoad(const aStorage: IddConfigStorage); override;
   procedure DoSave(const aStorage: IddConfigStorage); override;
   procedure DoSetControlValues(aDefault: Boolean); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetChanged: Boolean; override;
   procedure pm_SetChanged(aValue: Boolean); override;
   procedure DoFrameSize(aParent: TWinControl;
    out aHeight: Integer;
    out aWidth: Integer); override;
   procedure DoResetToDefault; override;
   procedure ReadOnlyChanged; override;
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString); reintroduce;
   function AddItem(aItem: TddBaseConfigItem): TddBaseConfigItem;
   procedure Assign(Source: TPersistent); override;
   function HasValue(const anAlias: AnsiString;
    out theItem: TddBaseConfigItem): Boolean; override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function IsRequired(out aMessage: AnsiString): Boolean; override;
   function Clone: Pointer; override;
  public
   property Objects: Tl3ProtoPersistentRefList
    read f_Objects
    write pm_SetObjects;
   property LabelTop: Boolean
    read f_LabelTop
    write pm_SetLabelTop;
   property Items[anIndex: Integer]: TddVisualConfigItem
    read pm_GetItems;
   property ItemByIndex[anIndex: Integer]: TddVisualConfigItem
    read pm_GetItemByIndex;
   property AsBoolean[const anAlias: AnsiString]: Boolean
    read pm_GetAsBoolean
    write pm_SetAsBoolean;
   property AsDateTime[const anAlias: AnsiString]: TDateTime
    read pm_GetAsDateTime
    write pm_SetAsDateTime;
   property AsInteger[const anAlias: AnsiString]: Integer
    read pm_GetAsInteger
    write pm_SetAsInteger;
   property AsObject[const anAlias: AnsiString]: TObject
    read pm_GetAsObject
    write pm_SetAsObject;
   property AsString[const anAlias: AnsiString]: AnsiString
    read pm_GetAsString
    write pm_SetAsString;
   property Count: Integer
    read pm_GetCount;
   property ItemByAlias[const anAlias: AnsiString]: TddBaseConfigItem
    read pm_GetItemByAlias;
    default;
 end;//TddAppConfigNode

 TddMasterSlaveConfigItem = class(TddGroupConfigItem)
  private
   f_Captions: TStrings;
   f_ListItems: Tl3ProtoPersistentRefList;
   f_ComboBox: TvtComboBoxQS;
   f_PrevIndex: Integer;
  private
   function CheckItem(const aAlias: AnsiString): Boolean;
   procedure OnChange(Sender: TObject);
   function FirstItem(aItemIndex: Integer): Integer;
   procedure ChangeItem;
   procedure AssignDataFromDetail;
   procedure UpdateDataItems(aItemIndex: Integer);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   function HeaderHeight(aParent: TWinControl): Integer; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   procedure AddStructureItem(aItem: TddBaseConfigItem);
   procedure AddCaption(const aCaption: AnsiString;
    const aAliasPrefix: AnsiString);
   function AddAlias(const aAlias: AnsiString): TddBaseConfigItem;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   procedure SetValueToControl(aDefault: Boolean); override;
 end;//TddMasterSlaveConfigItem

 TddContainerConfigItem = class(TddGroupConfigItem)
  private
   f_InCreate: Boolean;
   f_Left: Integer;
   f_MaxLeft: Integer;
   f_LastIndex: Integer;
   f_ForceComboBox: Boolean;
  private
   function GetCaseIndex: Integer;
   procedure ConstructSubItems(aLeft: Integer;
    aMaxLeft: Integer);
   procedure DestroySubItems;
   procedure SetValueToSubitems(aDefault: Boolean);
   procedure OnClick(Sender: TObject);
   function UseCheckBox: Boolean;
  protected
   function pm_GetBooleanValue: Boolean; override;
   procedure pm_SetBooleanValue(aValue: Boolean); override;
   function MayBeRequired: Boolean; override;
   function pm_GetLabeled: Boolean; override;
   procedure AfterConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    theControl: TControl;
    theLabel: TvtLabel); override;
   procedure BeforeConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl); override;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   procedure AddCase(const aCaption: AnsiString);
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   function LabelWidth(aParent: TWinControl): Integer; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   function Add(aItem: TddBaseConfigItem): TddBaseConfigItem; override;
  public
   property ForceComboBox: Boolean
    read f_ForceComboBox
    write f_ForceComboBox;
 end;//TddContainerConfigItem

 TddComboBoxConfigItem = class(TddBaseStringsConfigItem, IddMasterItem)
  private
   f_MasterIndex: Integer;
   f_ComboBoxStyle: TComboBoxStyle;
   f_DropDownCount: Integer;
  private
   procedure OnExit(Sender: TObject);
  protected
   procedure pm_SetComboBoxStyle(aValue: TComboBoxStyle);
   procedure pm_SetDropDownCount(aValue: Integer);
   procedure DoExit; virtual;
   function pm_GetBooleanValue: Boolean;
   function DisplayNameContainer: Tl3Strings; override;
   function pm_GetControlClass: TControlClass; override;
   procedure DoOnChange(aSender: TObject); override;
   procedure SelectValue(aValue: Integer); override;
   function pm_GetSelectedItemIndex: Integer; override;
   procedure pm_SetSelectedItemIndex(aValue: Integer); override;
   procedure InitControl(aControl: TControl); override;
   function pm_GetControlStrings: Il3StringsEx; override;
   procedure AssignStringsToControl(const aStrings: Il3StringsEx); override;
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    const aValueMap: Il3ValueMap = nil;
    aMasterItem: TddBaseConfigItem = nil;
    aMasterIndex: Integer = -1); reintroduce; virtual;
   function ControlHeight(aParent: TWinControl): Integer; override;
   function Clone: Pointer; override;
  public
   property ComboBoxStyle: TComboBoxStyle
    read f_ComboBoxStyle
    write pm_SetComboBoxStyle;
   property DropDownCount: Integer
    read f_DropDownCount
    write pm_SetDropDownCount;
 end;//TddComboBoxConfigItem

 TddMapRadioGroupConfigItem = class(TddBaseStringsConfigItem)
  private
   f_ControlStrings: Tl3Strings;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   function DisplayNameContainer: Tl3Strings; override;
   function pm_GetControlClass: TControlClass; override;
   function pm_GetSelectedItemIndex: Integer; override;
   procedure pm_SetSelectedItemIndex(aValue: Integer); override;
   procedure InitControl(aControl: TControl); override;
   function pm_GetControlStrings: Il3StringsEx; override;
   procedure AssignStringsToControl(const aStrings: Il3StringsEx); override;
  public
   function ControlHeight(aParent: TWinControl): Integer; override;
 end;//TddMapRadioGroupConfigItem

 TddContainerComboConfigItem = class(TddGroupConfigItem)
  private
   f_InCreate: Boolean;
   f_LastIndex: Integer;
   f_Left: Integer;
   f_MaxLeft: Integer;
  private
   procedure ConstructSubItems(aLeft: Integer;
    aMaxLeft: Integer);
   procedure DestroySubItems;
   procedure OnClick(Sender: TObject);
   function GetCaseCode: AnsiString;
   procedure SetValueToSubItems(aDefault: Boolean);
   function GetCaseIndex: Integer;
  protected
   function MayBeRequired: Boolean; override;
   function pm_GetLabeled: Boolean; override;
   procedure AfterConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    theControl: TControl;
    theLabel: TvtLabel); override;
   procedure BeforeConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl); override;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   procedure AddCase(const aCaseCode: AnsiString;
    const aCaption: AnsiString);
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   function LabelWidth(aParent: TWinControl): Integer; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   function Add(aItem: TddBaseConfigItem): TddBaseConfigItem; override;
 end;//TddContainerComboConfigItem

function RequiredSignWidth(aParent: TWinControl): Integer;

implementation

uses
 l3ImplUses
 , ddAppConfigTypesRes
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3String
 , DateUtils
 , l3Base
 , StrUtils
 , Math
 , vtSpinEdit
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtRadioButton
 , vtGroupBox
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , vtPanel
 , vtButton
 , vtCheckBox
 {$If NOT Defined(NoVCL)}
 , CheckLst
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Bits
 , ddAppConfigRes
 , l3Defaults
 , l3ValueMap
;

function GetGroupHeaderHeight(aParent: TWinControl;
 const aCaption: AnsiString;
 aShowCaption: Boolean): Integer;
//#UC START# *53A2C016009F_52161F2B00C4_var*
var
  l_Label: TStaticText;
//#UC END# *53A2C016009F_52161F2B00C4_var*
begin
//#UC START# *53A2C016009F_52161F2B00C4_impl*
 {$IFNDEF Nemesis}
 if (aCaption = '') or not aShowCaption then
  Result := 14 // magicHeight
 {$ELSE}
 if (aCaption = '') then
  Result := 14
 {$ENDIF}
 else
 begin
  l_Label := TStaticText.Create(nil);
  try
   l_Label.Parent := aParent;
   l_Label.Caption := aCaption;
   Result := l_Label.Height + c_ConfigItemTop;
  finally
   FreeAndNil(l_Label);
  end;
 end;
//#UC END# *53A2C016009F_52161F2B00C4_impl*
end;//GetGroupHeaderHeight

function RequiredSignWidth(aParent: TWinControl): Integer;
//#UC START# *5216245D03BA_52161F2B00C4_var*
//#UC END# *5216245D03BA_52161F2B00C4_var*
begin
//#UC START# *5216245D03BA_52161F2B00C4_impl*
 with TvtLabel.Create(aParent) do
 try
  Parent := aParent;
  CCaption := l3CStr(ddRequiredSign);
  Font.Name := ddRequiredFont;
  Result := Width;
 finally
  Free;
 end;
//#UC END# *5216245D03BA_52161F2B00C4_impl*
end;//RequiredSignWidth

procedure TddBaseConfigItem.pm_SetAlias(const aValue: AnsiString);
//#UC START# *52171FCA00C1_4E302F4201D5set_var*
//#UC END# *52171FCA00C1_4E302F4201D5set_var*
begin
//#UC START# *52171FCA00C1_4E302F4201D5set_impl*
 f_Alias := aValue;
//#UC END# *52171FCA00C1_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetAlias

function TddBaseConfigItem.pm_GetBooleanValue: Boolean;
//#UC START# *52171FDF0382_4E302F4201D5get_var*
//#UC END# *52171FDF0382_4E302F4201D5get_var*
begin
//#UC START# *52171FDF0382_4E302F4201D5get_impl*
 Result := Value.AsBoolean;
//#UC END# *52171FDF0382_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetBooleanValue

procedure TddBaseConfigItem.pm_SetBooleanValue(aValue: Boolean);
//#UC START# *52171FDF0382_4E302F4201D5set_var*
//#UC END# *52171FDF0382_4E302F4201D5set_var*
begin
//#UC START# *52171FDF0382_4E302F4201D5set_impl*
 if f_Value.AsBoolean <> aValue then
 begin
  f_Value.AsBoolean := aValue;
  Changing;
 end;
//#UC END# *52171FDF0382_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetBooleanValue

function TddBaseConfigItem.pm_GetChanged: Boolean;
//#UC START# *5217205002F2_4E302F4201D5get_var*
//#UC END# *5217205002F2_4E302F4201D5get_var*
begin
//#UC START# *5217205002F2_4E302F4201D5get_impl*
 Result := f_Changed;
//#UC END# *5217205002F2_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetChanged

procedure TddBaseConfigItem.pm_SetChanged(aValue: Boolean);
//#UC START# *5217205002F2_4E302F4201D5set_var*
//#UC END# *5217205002F2_4E302F4201D5set_var*
begin
//#UC START# *5217205002F2_4E302F4201D5set_impl*
 f_Changed := aValue;
//#UC END# *5217205002F2_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetChanged

function TddBaseConfigItem.pm_GetDateTimeValue: TDateTime;
//#UC START# *5217207F003D_4E302F4201D5get_var*
//#UC END# *5217207F003D_4E302F4201D5get_var*
begin
//#UC START# *5217207F003D_4E302F4201D5get_impl*
 if Value.AsDateTime = ddEmptyDateValue.AsDateTime then
  Result := Now
 else
  Result := Value.AsDateTime;
//#UC END# *5217207F003D_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetDateTimeValue

procedure TddBaseConfigItem.pm_SetDateTimeValue(aValue: TDateTime);
//#UC START# *5217207F003D_4E302F4201D5set_var*
//#UC END# *5217207F003D_4E302F4201D5set_var*
begin
//#UC START# *5217207F003D_4E302F4201D5set_impl*
 if not SameDateTime(Value.AsDateTime, aValue) then
 begin
  f_Value.AsDateTime := aValue;
  Changing;
 end;
//#UC END# *5217207F003D_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetDateTimeValue

function TddBaseConfigItem.pm_GetDefaultBooleanValue: Boolean;
//#UC START# *521720A10002_4E302F4201D5get_var*
//#UC END# *521720A10002_4E302F4201D5get_var*
begin
//#UC START# *521720A10002_4E302F4201D5get_impl*
 Result := f_DefaultValue.AsBoolean;
//#UC END# *521720A10002_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetDefaultBooleanValue

procedure TddBaseConfigItem.pm_SetDefaultBooleanValue(aValue: Boolean);
//#UC START# *521720A10002_4E302F4201D5set_var*
//#UC END# *521720A10002_4E302F4201D5set_var*
begin
//#UC START# *521720A10002_4E302F4201D5set_impl*
 with f_DefaultValue do
 begin
  Kind := dd_vkBoolean;
  AsBoolean := aValue;
 end;
//#UC END# *521720A10002_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetDefaultBooleanValue

function TddBaseConfigItem.pm_GetDefaultDateTimeValue: TDateTime;
//#UC START# *52172110032B_4E302F4201D5get_var*
//#UC END# *52172110032B_4E302F4201D5get_var*
begin
//#UC START# *52172110032B_4E302F4201D5get_impl*
 Result := f_DefaultValue.AsDateTime;
//#UC END# *52172110032B_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetDefaultDateTimeValue

procedure TddBaseConfigItem.pm_SetDefaultDateTimeValue(aValue: TDateTime);
//#UC START# *52172110032B_4E302F4201D5set_var*
//#UC END# *52172110032B_4E302F4201D5set_var*
begin
//#UC START# *52172110032B_4E302F4201D5set_impl*
  with f_DefaultValue do
  begin
   Kind := dd_vkDateTime;
   AsDateTime := aValue;
  end;
//#UC END# *52172110032B_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetDefaultDateTimeValue

function TddBaseConfigItem.pm_GetDefaultIntegerValue: Integer;
//#UC START# *521721320074_4E302F4201D5get_var*
//#UC END# *521721320074_4E302F4201D5get_var*
begin
//#UC START# *521721320074_4E302F4201D5get_impl*
 Result := f_DefaultValue.AsInteger;
//#UC END# *521721320074_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetDefaultIntegerValue

procedure TddBaseConfigItem.pm_SetDefaultIntegerValue(aValue: Integer);
//#UC START# *521721320074_4E302F4201D5set_var*
//#UC END# *521721320074_4E302F4201D5set_var*
begin
//#UC START# *521721320074_4E302F4201D5set_impl*
 with f_DefaultValue do
 begin
  AsInteger := aValue;
  Kind := dd_vkInteger;
 end;
//#UC END# *521721320074_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetDefaultIntegerValue

function TddBaseConfigItem.pm_GetDefaultObjectValue: TObject;
//#UC START# *5217217B014F_4E302F4201D5get_var*
//#UC END# *5217217B014F_4E302F4201D5get_var*
begin
//#UC START# *5217217B014F_4E302F4201D5get_impl*
 Result := f_DefaultValue.AsObject;                             
//#UC END# *5217217B014F_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetDefaultObjectValue

procedure TddBaseConfigItem.pm_SetDefaultObjectValue(aValue: TObject);
//#UC START# *5217217B014F_4E302F4201D5set_var*
//#UC END# *5217217B014F_4E302F4201D5set_var*
begin
//#UC START# *5217217B014F_4E302F4201D5set_impl*
 with f_DefaultValue do
 begin
  Kind := dd_vkObject;
  AsObject := aValue;
 end;
//#UC END# *5217217B014F_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetDefaultObjectValue

function TddBaseConfigItem.pm_GetDefaultStringValue: AnsiString;
//#UC START# *521721A6018E_4E302F4201D5get_var*
//#UC END# *521721A6018E_4E302F4201D5get_var*
begin
//#UC START# *521721A6018E_4E302F4201D5get_impl*
 Result := f_DefaultValue.AsString;
//#UC END# *521721A6018E_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetDefaultStringValue

procedure TddBaseConfigItem.pm_SetDefaultStringValue(const aValue: AnsiString);
//#UC START# *521721A6018E_4E302F4201D5set_var*
//#UC END# *521721A6018E_4E302F4201D5set_var*
begin
//#UC START# *521721A6018E_4E302F4201D5set_impl*
 with f_DefaultValue do
 begin
  Kind := dd_vkString;
  AsString := aValue;
 end;
//#UC END# *521721A6018E_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetDefaultStringValue

procedure TddBaseConfigItem.pm_SetDefaultValue(const aValue: TddConfigValue);
//#UC START# *5217221402A6_4E302F4201D5set_var*
//#UC END# *5217221402A6_4E302F4201D5set_var*
begin
//#UC START# *5217221402A6_4E302F4201D5set_impl*
 l3Move(aValue, f_DefaultValue, SizeOf(aValue));
 l3Move(aValue, f_Value, SizeOf(aValue));
//#UC END# *5217221402A6_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetDefaultValue

function TddBaseConfigItem.pm_GetEnabled: Boolean;
//#UC START# *521722C103B5_4E302F4201D5get_var*
var
 l_MasterItem: IddMasterItem;
//#UC END# *521722C103B5_4E302F4201D5get_var*
begin
//#UC START# *521722C103B5_4E302F4201D5get_impl*
 Result := f_Enabled;
 if MasterItem <> nil then
  if Supports(MasterItem, IddMasterItem, l_MasterItem) then
   Result := Result and MasterItem.Enabled and l_MasterItem.BooleanValue
  else
   Result := Result and MasterItem.Enabled and MasterItem.BooleanValue
//#UC END# *521722C103B5_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetEnabled

procedure TddBaseConfigItem.pm_SetEnabled(aValue: Boolean);
//#UC START# *521722C103B5_4E302F4201D5set_var*
//#UC END# *521722C103B5_4E302F4201D5set_var*
begin
//#UC START# *521722C103B5_4E302F4201D5set_impl*
 f_Enabled := aValue;
 DoEnabled;
//#UC END# *521722C103B5_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetEnabled

function TddBaseConfigItem.pm_GetIntegerValue: Integer;
//#UC START# *521723D100AE_4E302F4201D5get_var*
//#UC END# *521723D100AE_4E302F4201D5get_var*
begin
//#UC START# *521723D100AE_4E302F4201D5get_impl*
 Result := Value.AsInteger;
//#UC END# *521723D100AE_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetIntegerValue

procedure TddBaseConfigItem.pm_SetIntegerValue(aValue: Integer);
//#UC START# *521723D100AE_4E302F4201D5set_var*
//#UC END# *521723D100AE_4E302F4201D5set_var*
begin
//#UC START# *521723D100AE_4E302F4201D5set_impl*
 if Value.AsInteger <> aValue then
 begin
  f_Value.AsInteger := aValue;
  Changing;
 end;
//#UC END# *521723D100AE_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetIntegerValue

function TddBaseConfigItem.pm_GetIsRequired: Boolean;
//#UC START# *521723F70062_4E302F4201D5get_var*
//#UC END# *521723F70062_4E302F4201D5get_var*
begin
//#UC START# *521723F70062_4E302F4201D5get_impl*
 Result := Required and IsValueEmpty(f_Value) and Enabled;
//#UC END# *521723F70062_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetIsRequired

procedure TddBaseConfigItem.pm_SetMasterItem(aValue: TddBaseConfigItem);
//#UC START# *521724460319_4E302F4201D5set_var*
var
 l_MasterItem: IddMasterItem;
//#UC END# *521724460319_4E302F4201D5set_var*
begin
//#UC START# *521724460319_4E302F4201D5set_impl*
 if f_MasterItem <> aValue then
 begin
  if f_MasterItem <> nil then
   f_MasterItem.RemoveSlave(Self);
  f_MasterItem := aValue;
  f_MasterItem.AddSlave(Self);
  if f_MasterItem <> nil then
   if Supports(f_MasterItem, IddMasterItem, l_MasterItem) then
    Enabled := l_MasterItem.BooleanValue
   else
    Enabled := f_MasterItem.Value.AsBoolean;
 end;
//#UC END# *521724460319_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetMasterItem

function TddBaseConfigItem.pm_GetObjectValue: TObject;
//#UC START# *5217247901BD_4E302F4201D5get_var*
//#UC END# *5217247901BD_4E302F4201D5get_var*
begin
//#UC START# *5217247901BD_4E302F4201D5get_impl*
 Result := Value.AsObject;
//#UC END# *5217247901BD_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetObjectValue

procedure TddBaseConfigItem.pm_SetObjectValue(aValue: TObject);
//#UC START# *5217247901BD_4E302F4201D5set_var*
//#UC END# *5217247901BD_4E302F4201D5set_var*
begin
//#UC START# *5217247901BD_4E302F4201D5set_impl*
 if f_Value.AsObject <> aValue then
 begin
  f_Value.AsObject := aValue;
  Changing;
 end;
//#UC END# *5217247901BD_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetObjectValue

function TddBaseConfigItem.pm_GetRequired: Boolean;
//#UC START# *521724C0003E_4E302F4201D5get_var*
//#UC END# *521724C0003E_4E302F4201D5get_var*
begin
//#UC START# *521724C0003E_4E302F4201D5get_impl*
 Result := f_Required;
//#UC END# *521724C0003E_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetRequired

procedure TddBaseConfigItem.pm_SetRequired(aValue: Boolean);
//#UC START# *521724C0003E_4E302F4201D5set_var*
//#UC END# *521724C0003E_4E302F4201D5set_var*
begin
//#UC START# *521724C0003E_4E302F4201D5set_impl*
 f_Required := aValue;
//#UC END# *521724C0003E_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetRequired

function TddBaseConfigItem.pm_GetStringValue: AnsiString;
//#UC START# *521724F702D9_4E302F4201D5get_var*
//#UC END# *521724F702D9_4E302F4201D5get_var*
begin
//#UC START# *521724F702D9_4E302F4201D5get_impl*
 Result := Value.AsString;
//#UC END# *521724F702D9_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetStringValue

procedure TddBaseConfigItem.pm_SetStringValue(const aValue: AnsiString);
//#UC START# *521724F702D9_4E302F4201D5set_var*
//#UC END# *521724F702D9_4E302F4201D5set_var*
begin
//#UC START# *521724F702D9_4E302F4201D5set_impl*
 if Value.AsString <> aValue then
 begin
  f_Value.AsString := aValue;
  Changing;
 end;
//#UC END# *521724F702D9_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetStringValue

function TddBaseConfigItem.pm_GetValue: TddConfigValue;
//#UC START# *521725130281_4E302F4201D5get_var*
//#UC END# *521725130281_4E302F4201D5get_var*
begin
//#UC START# *521725130281_4E302F4201D5get_impl*
 Result := f_Value;
//#UC END# *521725130281_4E302F4201D5get_impl*
end;//TddBaseConfigItem.pm_GetValue

procedure TddBaseConfigItem.pm_SetValue(const aValue: TddConfigValue);
//#UC START# *521725130281_4E302F4201D5set_var*
var
 I: Integer;
//#UC END# *521725130281_4E302F4201D5set_var*
begin
//#UC START# *521725130281_4E302F4201D5set_impl*
 l3Move(aValue, f_Value, SizeOf(aValue));
 Changing;
//#UC END# *521725130281_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetValue

procedure TddBaseConfigItem.pm_SetReadOnly(aValue: Boolean);
//#UC START# *552BA4A103A3_4E302F4201D5set_var*
//#UC END# *552BA4A103A3_4E302F4201D5set_var*
begin
//#UC START# *552BA4A103A3_4E302F4201D5set_impl*
 if f_ReadOnly <> aValue then
 begin
  f_ReadOnly := aValue;
  ReadOnlyChanged;
 end;
//#UC END# *552BA4A103A3_4E302F4201D5set_impl*
end;//TddBaseConfigItem.pm_SetReadOnly

procedure TddBaseConfigItem.AddSlave(aSlave: TddBaseConfigItem);
//#UC START# *52171C590103_4E302F4201D5_var*
//#UC END# *52171C590103_4E302F4201D5_var*
begin
//#UC START# *52171C590103_4E302F4201D5_impl*
 f_Slaves.Add(aSlave);
//#UC END# *52171C590103_4E302F4201D5_impl*
end;//TddBaseConfigItem.AddSlave

procedure TddBaseConfigItem.RemoveSlave(aSlave: TddBaseConfigItem);
//#UC START# *52171C8500C0_4E302F4201D5_var*
//#UC END# *52171C8500C0_4E302F4201D5_var*
begin
//#UC START# *52171C8500C0_4E302F4201D5_impl*
 f_Slaves.Remove(aSlave);
//#UC END# *52171C8500C0_4E302F4201D5_impl*
end;//TddBaseConfigItem.RemoveSlave

procedure TddBaseConfigItem.Changing;
//#UC START# *52171CBA0170_4E302F4201D5_var*
var
 I: Integer;
//#UC END# *52171CBA0170_4E302F4201D5_var*
begin
//#UC START# *52171CBA0170_4E302F4201D5_impl*
 Changed := True;
 if not IsLocked then
  for I := 0 to f_NotifyList.Hi do
   TddBaseConfigItem(f_NotifyList.Items[I]).ProcessNotify(Self.Value);
//#UC END# *52171CBA0170_4E302F4201D5_impl*
end;//TddBaseConfigItem.Changing

procedure TddBaseConfigItem.DoEnabled;
//#UC START# *52171D0D031D_4E302F4201D5_var*
//#UC END# *52171D0D031D_4E302F4201D5_var*
begin
//#UC START# *52171D0D031D_4E302F4201D5_impl*
 //virtual
//#UC END# *52171D0D031D_4E302F4201D5_impl*
end;//TddBaseConfigItem.DoEnabled

function TddBaseConfigItem.MayBeRequired: Boolean;
//#UC START# *521725C301A5_4E302F4201D5_var*
//#UC END# *521725C301A5_4E302F4201D5_var*
begin
//#UC START# *521725C301A5_4E302F4201D5_impl*
 Result := True;
//#UC END# *521725C301A5_4E302F4201D5_impl*
end;//TddBaseConfigItem.MayBeRequired

procedure TddBaseConfigItem.ProcessNotify(const aValue: TddConfigValue);
//#UC START# *521725E40234_4E302F4201D5_var*
//#UC END# *521725E40234_4E302F4201D5_var*
begin
//#UC START# *521725E40234_4E302F4201D5_impl*
 if Assigned(f_OnNotify) then
  f_OnNotify(Self, aValue);
//#UC END# *521725E40234_4E302F4201D5_impl*
end;//TddBaseConfigItem.ProcessNotify

procedure TddBaseConfigItem.Reset;
//#UC START# *521726060214_4E302F4201D5_var*
//#UC END# *521726060214_4E302F4201D5_var*
begin
//#UC START# *521726060214_4E302F4201D5_impl*
 Value := DefaultValue;
//#UC END# *521726060214_4E302F4201D5_impl*
end;//TddBaseConfigItem.Reset

constructor TddBaseConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_4E302F4201D5_var*
//#UC END# *5217273F000F_4E302F4201D5_var*
begin
//#UC START# *5217273F000F_4E302F4201D5_impl*
 inherited Create;
 f_Slaves := Tl3ObjectList.Create;
 f_NotifyList := Tl3ObjectList.Create;
 f_Alias := aAlias;
 f_Caption := aCaption;
 f_Enabled := True;
 f_AbsoluteIndex := -1;
 DefaultValue := aDefaultValue;
//#UC END# *5217273F000F_4E302F4201D5_impl*
end;//TddBaseConfigItem.Create

procedure TddBaseConfigItem.AddNotify(aItem: TddBaseConfigItem);
//#UC START# *521727EA03C9_4E302F4201D5_var*
//#UC END# *521727EA03C9_4E302F4201D5_var*
begin
//#UC START# *521727EA03C9_4E302F4201D5_impl*
 f_NotifyList.Add(aItem)
//#UC END# *521727EA03C9_4E302F4201D5_impl*
end;//TddBaseConfigItem.AddNotify

procedure TddBaseConfigItem.AssignValue(const aValue: TddConfigValue;
 aOnChange: Boolean = False);
 {* функция сравнения объекта с другим объектом.  Для перекрытия в потомках. }
//#UC START# *5217286C0304_4E302F4201D5_var*
//#UC END# *5217286C0304_4E302F4201D5_var*
begin
//#UC START# *5217286C0304_4E302F4201D5_impl*
 if aOnChange then
 case aValue.Kind of
  dd_vkBoolean: BooleanValue := aValue.AsBoolean;
  dd_vkDateTime: DateTimeValue := aValue.AsDateTime;
  dd_vkInteger: IntegerValue := aValue.AsInteger;
  dd_vkObject: ObjectValue := aValue.AsObject;
  dd_vkString: StringValue := aValue.AsString;
 end
 else
  f_Value := aValue;
//#UC END# *5217286C0304_4E302F4201D5_impl*
end;//TddBaseConfigItem.AssignValue

function TddBaseConfigItem.HasValue(const anAlias: AnsiString;
 out theItem: TddBaseConfigItem): Boolean;
//#UC START# *52172A7700CB_4E302F4201D5_var*
//#UC END# *52172A7700CB_4E302F4201D5_var*
begin
//#UC START# *52172A7700CB_4E302F4201D5_impl*
 Result := AnsiCompareText(anAlias, Alias) = 0;
 if Result then
  theItem := Self
 else
  theItem := nil;
//#UC END# *52172A7700CB_4E302F4201D5_impl*
end;//TddBaseConfigItem.HasValue

function TddBaseConfigItem.HasValue(const anAlias: AnsiString): Boolean;
//#UC START# *52172AE002EA_4E302F4201D5_var*
var
 l_Obj: TddBaseConfigItem;
//#UC END# *52172AE002EA_4E302F4201D5_var*
begin
//#UC START# *52172AE002EA_4E302F4201D5_impl*
 Result := HasValue(anAlias, l_Obj);
//#UC END# *52172AE002EA_4E302F4201D5_impl*
end;//TddBaseConfigItem.HasValue

function TddBaseConfigItem.IsLocked: Boolean;
//#UC START# *52172B0A003B_4E302F4201D5_var*
//#UC END# *52172B0A003B_4E302F4201D5_var*
begin
//#UC START# *52172B0A003B_4E302F4201D5_impl*
 Result := f_Locked > 0;
//#UC END# *52172B0A003B_4E302F4201D5_impl*
end;//TddBaseConfigItem.IsLocked

procedure TddBaseConfigItem.Load(const aStorage: IddConfigStorage);
//#UC START# *52172B340290_4E302F4201D5_var*
//#UC END# *52172B340290_4E302F4201D5_var*
begin
//#UC START# *52172B340290_4E302F4201D5_impl*
 Lock;
 try
  LoadValue(aStorage);
 except
  on E: Exception do
   l3System.Msg2Log('Ошибка "%s" загрузки значения элемента "%s"', [E.Message, Alias]);
 end;
 Unlock;
 Changed := False;
//#UC END# *52172B340290_4E302F4201D5_impl*
end;//TddBaseConfigItem.Load

procedure TddBaseConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_4E302F4201D5_var*
//#UC END# *52172B72014C_4E302F4201D5_var*
begin
//#UC START# *52172B72014C_4E302F4201D5_impl*
 case f_Value.Kind of
  dd_vkBoolean: f_Value.AsBoolean := aStorage.ReadBool(f_Alias, f_DefaultValue.AsBoolean);
  dd_vkDateTime: f_Value.AsDateTime := aStorage.ReadDateTime(f_Alias, f_DefaultValue.AsDateTime);
  dd_vkInteger: f_Value.AsInteger := aStorage.ReadInteger(f_Alias, f_DefaultValue.AsInteger);
  dd_vkString: f_Value.AsString := l3Str(aStorage.ReadString(f_Alias, f_DefaultValue.AsString));
 end;
//#UC END# *52172B72014C_4E302F4201D5_impl*
end;//TddBaseConfigItem.LoadValue

procedure TddBaseConfigItem.Lock;
//#UC START# *52172BB502E3_4E302F4201D5_var*
//#UC END# *52172BB502E3_4E302F4201D5_var*
begin
//#UC START# *52172BB502E3_4E302F4201D5_impl*
 Inc(f_Locked);
//#UC END# *52172BB502E3_4E302F4201D5_impl*
end;//TddBaseConfigItem.Lock

procedure TddBaseConfigItem.Unlock;
//#UC START# *52172BC5003D_4E302F4201D5_var*
//#UC END# *52172BC5003D_4E302F4201D5_var*
begin
//#UC START# *52172BC5003D_4E302F4201D5_impl*
 Assert(f_Locked > 0);
 Dec(f_Locked);
//#UC END# *52172BC5003D_4E302F4201D5_impl*
end;//TddBaseConfigItem.Unlock

procedure TddBaseConfigItem.RemoveNotify(aItem: TddBaseConfigItem);
//#UC START# *52172C2E00D0_4E302F4201D5_var*
//#UC END# *52172C2E00D0_4E302F4201D5_var*
begin
//#UC START# *52172C2E00D0_4E302F4201D5_impl*
 f_NotifyList.Remove(aItem);
//#UC END# *52172C2E00D0_4E302F4201D5_impl*
end;//TddBaseConfigItem.RemoveNotify

procedure TddBaseConfigItem.ResetToDefault;
//#UC START# *52172C50023A_4E302F4201D5_var*
//#UC END# *52172C50023A_4E302F4201D5_var*
begin
//#UC START# *52172C50023A_4E302F4201D5_impl*
 { TODO -oДмитрий Дудко -cРазвитие : Сброс всех значений в значение по умолчанию }
//#UC END# *52172C50023A_4E302F4201D5_impl*
end;//TddBaseConfigItem.ResetToDefault

procedure TddBaseConfigItem.Save(const aStorage: IddConfigStorage);
//#UC START# *52172C68039D_4E302F4201D5_var*
//#UC END# *52172C68039D_4E302F4201D5_var*
begin
//#UC START# *52172C68039D_4E302F4201D5_impl*
 if Changed then
  SaveValue(aStorage);
//#UC END# *52172C68039D_4E302F4201D5_impl*
end;//TddBaseConfigItem.Save

procedure TddBaseConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_4E302F4201D5_var*
//#UC END# *52172CA801E3_4E302F4201D5_var*
begin
//#UC START# *52172CA801E3_4E302F4201D5_impl*
 if f_Changed then
  case f_Value.Kind of
   dd_vkBoolean: aStorage.WriteBool(f_Alias, f_Value.AsBoolean);
   dd_vkDateTime: aStorage.WriteDateTime(f_Alias, f_Value.AsDateTime);
   dd_vkInteger: aStorage.WriteInteger(f_Alias, f_Value.AsInteger);
   dd_vkString: aStorage.WriteString(f_Alias, f_Value.AsString);
  end;
//#UC END# *52172CA801E3_4E302F4201D5_impl*
end;//TddBaseConfigItem.SaveValue

procedure TddBaseConfigItem.ReadOnlyChanged;
//#UC START# *552BA9B9039B_4E302F4201D5_var*
//#UC END# *552BA9B9039B_4E302F4201D5_var*
begin
//#UC START# *552BA9B9039B_4E302F4201D5_impl*
// DoNothing
//#UC END# *552BA9B9039B_4E302F4201D5_impl*
end;//TddBaseConfigItem.ReadOnlyChanged

procedure TddBaseConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_4E302F4201D5_var*
//#UC END# *478CF34E02CE_4E302F4201D5_var*
begin
//#UC START# *478CF34E02CE_4E302F4201D5_impl*
 if Source is TddBaseConfigItem then
 begin
  AbsoluteIndex := TddBaseConfigItem(Source).AbsoluteIndex;
  DefaultValue := TddBaseConfigItem(Source).DefaultValue;
  Alias := TddBaseConfigItem(Source).Alias;
  Caption := TddBaseConfigItem(Source).Caption;
  Changed := TddBaseConfigItem(Source).Changed;
  Enabled := TddBaseConfigItem(Source).Enabled;
  Value := TddBaseConfigItem(Source).Value;
  f_NotifyList.Assign(TddBaseConfigItem(Source).f_NotifyList);
  OnNotify := TddBaseConfigItem(Source).f_OnNotify;
  f_ReadOnly := TddBaseConfigItem(Source).ReadOnly;
 end
 else
  inherited;
//#UC END# *478CF34E02CE_4E302F4201D5_impl*
end;//TddBaseConfigItem.Assign

procedure TddBaseConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E302F4201D5_var*
//#UC END# *479731C50290_4E302F4201D5_var*
begin
//#UC START# *479731C50290_4E302F4201D5_impl*
 FreeAndNil(f_Slaves);
 FreeAndNil(f_NotifyList);
 inherited;
//#UC END# *479731C50290_4E302F4201D5_impl*
end;//TddBaseConfigItem.Cleanup

function TddBaseConfigItem.Clone: Pointer;
//#UC START# *5301EC7500FF_4E302F4201D5_var*
//#UC END# *5301EC7500FF_4E302F4201D5_var*
begin
//#UC START# *5301EC7500FF_4E302F4201D5_impl*
 Result := RddBaseConfigItem(ClassType).Create(Alias, Caption, DefaultValue, MasterItem);
 TddBaseConfigItem(Result).Assign(Self);
//#UC END# *5301EC7500FF_4E302F4201D5_impl*
end;//TddBaseConfigItem.Clone

procedure TddBaseConfigItem.ClearFields;
begin
 Alias := '';
 Caption := '';
 Finalize(f_DefaultValue);
 inherited;
end;//TddBaseConfigItem.ClearFields

procedure TMapValue.pm_SetValue(const aValue: TddConfigValue);
//#UC START# *521625BD02ED_521624EA0293set_var*
//#UC END# *521625BD02ED_521624EA0293set_var*
begin
//#UC START# *521625BD02ED_521624EA0293set_impl*
 f_Value := aValue;
//#UC END# *521625BD02ED_521624EA0293set_impl*
end;//TMapValue.pm_SetValue

procedure TMapValue.pm_SetCaption(const aValue: AnsiString);
//#UC START# *521625E801C5_521624EA0293set_var*
//#UC END# *521625E801C5_521624EA0293set_var*
begin
//#UC START# *521625E801C5_521624EA0293set_impl*
 f_Caption := aValue;
//#UC END# *521625E801C5_521624EA0293set_impl*
end;//TMapValue.pm_SetCaption

procedure TMapValue.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_521624EA0293_var*
//#UC END# *478CF34E02CE_521624EA0293_var*
begin
//#UC START# *478CF34E02CE_521624EA0293_impl*
 if Source is TMapValue then
  with TMapValue(Source) do
  begin
   Self.Caption := Caption;
   Self.Value := Value;
  end;
//#UC END# *478CF34E02CE_521624EA0293_impl*
end;//TMapValue.Assign

constructor TMapValue.Create;
//#UC START# *5301EC5A006A_521624EA0293_var*
//#UC END# *5301EC5A006A_521624EA0293_var*
begin
//#UC START# *5301EC5A006A_521624EA0293_impl*
 inherited;
 f_Caption := '';
 f_Value.Kind := dd_vkObject;
 f_Value.AsObject := nil;
//#UC END# *5301EC5A006A_521624EA0293_impl*
end;//TMapValue.Create

procedure TMapValue.ClearFields;
begin
 Finalize(f_Value);
 Caption := '';
 inherited;
end;//TMapValue.ClearFields

function TMapValues.pm_GetCount: Integer;
//#UC START# *52162709029F_5216255500D5get_var*
//#UC END# *52162709029F_5216255500D5get_var*
begin
//#UC START# *52162709029F_5216255500D5get_impl*
 Assert(f_List <> nil);
 Result := f_List.Count;
//#UC END# *52162709029F_5216255500D5get_impl*
end;//TMapValues.pm_GetCount

function TMapValues.pm_GetItems(aIndex: Integer): TMapValue;
//#UC START# *5216295D00DB_5216255500D5get_var*
//#UC END# *5216295D00DB_5216255500D5get_var*
begin
//#UC START# *5216295D00DB_5216255500D5get_impl*
 Result := TMapValue(f_List.Items[aIndex]);
//#UC END# *5216295D00DB_5216255500D5get_impl*
end;//TMapValues.pm_GetItems

procedure TMapValues.pm_SetItems(aIndex: Integer;
 aValue: TMapValue);
//#UC START# *5216295D00DB_5216255500D5set_var*
//#UC END# *5216295D00DB_5216255500D5set_var*
begin
//#UC START# *5216295D00DB_5216255500D5set_impl*
 TMapValue(f_List.Items[aIndex]).Assign(aValue);
//#UC END# *5216295D00DB_5216255500D5set_impl*
end;//TMapValues.pm_SetItems

function TMapValues.IndexOfCaption(const aCaption: Il3CString): Integer;
//#UC START# *5216272A0158_5216255500D5_var*
var
  l_Index: Integer;
//#UC END# *5216272A0158_5216255500D5_var*
begin
//#UC START# *5216272A0158_5216255500D5_impl*
 Result := -1;
 for l_Index := 0 to Pred(f_List.Count) do
  if l3Same(aCaption, Items[l_Index].Caption) then
  begin            
   Result := l_Index;
   Break;
  end;//l3Same(aCaption, 
//#UC END# *5216272A0158_5216255500D5_impl*
end;//TMapValues.IndexOfCaption

function TMapValues.IndexOfValue(const aValue: TddConfigValue): Integer;
//#UC START# *521627490388_5216255500D5_var*
 function lp_ItemsIsEqual(aValue1 : TddConfigValue; aValue2 : TddConfigValue): Boolean;
 begin
  case f_MapKind of
   dd_vkString  : Result := aValue1.AsString = aValue2.AsString;
   dd_vkInteger : Result := aValue1.AsInteger = aValue2.AsInteger;
   dd_vkBoolean : Result := aValue1.AsBoolean = aValue2.AsBoolean;
   dd_vkDateTime: Result := aValue1.AsDateTime = aValue2.AsDateTime;
   dd_vkObject  : Result := aValue1.AsObject = aValue2.AsObject;
  else
   Result := False;
   Assert(False);
  end;
 end;
var
 l_Index: Integer;
//#UC END# *521627490388_5216255500D5_var*
begin
//#UC START# *521627490388_5216255500D5_impl*
 CheckValueType(aValue.Kind);
 Result := -1;
 for l_Index := 0 to Pred(f_List.Count) do
  if lp_ItemsIsEqual(Items[l_Index].Value, aValue) then
  begin
   Result := l_Index;
   Break;
  end;
//#UC END# *521627490388_5216255500D5_impl*
end;//TMapValues.IndexOfValue

procedure TMapValues.Clear;
//#UC START# *521627800086_5216255500D5_var*
//#UC END# *521627800086_5216255500D5_var*
begin
//#UC START# *521627800086_5216255500D5_impl*
 f_List.Clear;
//#UC END# *521627800086_5216255500D5_impl*
end;//TMapValues.Clear

procedure TMapValues.AddMapValue(const aCaption: AnsiString;
 const aValue: TddConfigValue);
//#UC START# *5216279203D3_5216255500D5_var*
var
 l_MapValue: TMapValue;
//#UC END# *5216279203D3_5216255500D5_var*
begin
//#UC START# *5216279203D3_5216255500D5_impl*
 CheckValueType(aValue.Kind);
 l_MapValue := TMapValue.Create;
 try
  l_MapValue.Caption := aCaption;
  l_MapValue.Value := aValue;
  f_List.Add(l_MapValue);
 finally
  FreeAndNil(l_MapValue);
 end;
//#UC END# *5216279203D3_5216255500D5_impl*
end;//TMapValues.AddMapValue

constructor TMapValues.Create(aKind: TddValueKind);
//#UC START# *521627BB0336_5216255500D5_var*
//#UC END# *521627BB0336_5216255500D5_var*
begin
//#UC START# *521627BB0336_5216255500D5_impl*
 inherited Create;
 f_MapKind := aKind;
 f_List := Tl3ProtoPersistentRefList.Create;
//#UC END# *521627BB0336_5216255500D5_impl*
end;//TMapValues.Create

procedure TMapValues.CheckValueType(aKind: TddValueKind);
//#UC START# *521634D401C2_5216255500D5_var*
//#UC END# *521634D401C2_5216255500D5_var*
begin
//#UC START# *521634D401C2_5216255500D5_impl*
 if aKind <> f_MapKind then
  raise EddConfigError.Create('Несовпадение типа map-value');
//#UC END# *521634D401C2_5216255500D5_impl*
end;//TMapValues.CheckValueType

procedure TMapValues.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5216255500D5_var*
//#UC END# *478CF34E02CE_5216255500D5_var*
begin
//#UC START# *478CF34E02CE_5216255500D5_impl*
 if Source is TMapValues then
  with TMapValues(Source) do
  begin
   Self.f_List.Assign(f_List);
   Self.f_MapKind := f_MapKind;
  end;
//#UC END# *478CF34E02CE_5216255500D5_impl*
end;//TMapValues.Assign

procedure TMapValues.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5216255500D5_var*
//#UC END# *479731C50290_5216255500D5_var*
begin
//#UC START# *479731C50290_5216255500D5_impl*
 Clear;
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_5216255500D5_impl*
end;//TMapValues.Cleanup

function TddVisualConfigItem.pm_GetLabeled: Boolean;
//#UC START# *5217600501C4_4E302F24003Fget_var*
//#UC END# *5217600501C4_4E302F24003Fget_var*
begin
//#UC START# *5217600501C4_4E302F24003Fget_impl*
 Result := f_Labeled;
//#UC END# *5217600501C4_4E302F24003Fget_impl*
end;//TddVisualConfigItem.pm_GetLabeled

function TddVisualConfigItem.pm_GetLabelTop: Boolean;
//#UC START# *5217602C020A_4E302F24003Fget_var*
//#UC END# *5217602C020A_4E302F24003Fget_var*
begin
//#UC START# *5217602C020A_4E302F24003Fget_impl*
 Result := f_LabelTop;
//#UC END# *5217602C020A_4E302F24003Fget_impl*
end;//TddVisualConfigItem.pm_GetLabelTop

procedure TddVisualConfigItem.pm_SetLabelTop(aValue: Boolean);
//#UC START# *5217602C020A_4E302F24003Fset_var*
//#UC END# *5217602C020A_4E302F24003Fset_var*
begin
//#UC START# *5217602C020A_4E302F24003Fset_impl*
 if Pos('|', Caption) = 0 then
  f_LabelTop := aValue
 else
  f_LabelTop := False;
//#UC END# *5217602C020A_4E302F24003Fset_impl*
end;//TddVisualConfigItem.pm_SetLabelTop

function TddVisualConfigItem.pm_GetFullControlHeight(aParent: TWinControl): Integer;
//#UC START# *521760660110_4E302F24003Fget_var*
//#UC END# *521760660110_4E302F24003Fget_var*
begin
//#UC START# *521760660110_4E302F24003Fget_impl*
 Result := LabelHeight(aParent) + ControlHeight(aParent);
 if LabelTop then
  Inc(Result, c_ConfigItemTop);
//#UC END# *521760660110_4E302F24003Fget_impl*
end;//TddVisualConfigItem.pm_GetFullControlHeight

procedure TddVisualConfigItem.AdjustLabel(theControl: TControl;
 theLabel: TvtLabel);
//#UC START# *521760A4009E_4E302F24003F_var*
//#UC END# *521760A4009E_4E302F24003F_var*
begin
//#UC START# *521760A4009E_4E302F24003F_impl*
 if (theLabel <> nil) then
 begin
  if theControl is TWinControl then
   theLabel.FocusControl := theControl as TWinControl;
  if not LabelTop then
   theLabel.Top := theControl.Top + c_ConfigItemTop;// (theControl.Height - theLabel.Height) div 2;
 end;
//#UC END# *521760A4009E_4E302F24003F_impl*
end;//TddVisualConfigItem.AdjustLabel

procedure TddVisualConfigItem.AfterConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 theControl: TControl;
 theLabel: TvtLabel);
//#UC START# *521760C60369_4E302F24003F_var*
//#UC END# *521760C60369_4E302F24003F_var*
begin
//#UC START# *521760C60369_4E302F24003F_impl*
 if theControl <> nil then
 begin
  theControl.Tag := AbsoluteIndex;
  theControl.Hint := Hint;
  AdjustLabel(theControl, theLabel);
 end; // theControl <> nil
//#UC END# *521760C60369_4E302F24003F_impl*
end;//TddVisualConfigItem.AfterConstruct

procedure TddVisualConfigItem.BeforeConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl);
//#UC START# *5217612C01B6_4E302F24003F_var*
//#UC END# *5217612C01B6_4E302F24003F_var*
begin
//#UC START# *5217612C01B6_4E302F24003F_impl*
 //
//#UC END# *5217612C01B6_4E302F24003F_impl*
end;//TddVisualConfigItem.BeforeConstruct

procedure TddVisualConfigItem.ChangeSlaveStatus(aEnabled: Boolean);
//#UC START# *521761980131_4E302F24003F_var*
var
 I: Integer;
//#UC END# *521761980131_4E302F24003F_var*
begin
//#UC START# *521761980131_4E302F24003F_impl*
  for I := 0 to Pred(f_Slaves.Count) do
   TddVisualConfigItem(f_Slaves.Items[I]).Enabled := aEnabled;
//#UC END# *521761980131_4E302F24003F_impl*
end;//TddVisualConfigItem.ChangeSlaveStatus

function TddVisualConfigItem.CreateLabel(aParent: TWinControl;
 const aCaption: AnsiString;
 var aLeft: Integer;
 var aTop: Integer;
 aLabelType: TddConfigItemLabelType = dd_cilMain): TvtLabel;
//#UC START# *5217620D0151_4E302F24003F_var*
var
 l_Prefix,
 l_Suffix: AnsiString;
//#UC END# *5217620D0151_4E302F24003F_var*
begin
//#UC START# *5217620D0151_4E302F24003F_impl*
 SplitCaption(aCaption, l_Prefix, l_Suffix);
 if ((l_Prefix <> '') and (aLabelType in [dd_cilMain, dd_cilRequired])) or
    ((aLabelType = dd_cilAdditional) and (l_Suffix <> '')) then
 begin
  Result := TvtLabel.Create(aParent);
  aParent.InsertControl(Result);
  if aLabelType = dd_cilAdditional then
  begin
   aTop := f_Label.Top;
   if Control <> nil then
    aLeft := Control.Width + Control.Left + c_ConfigItemLeft;
  end
  else
  if aLabelType = dd_cilRequired then
   Result.Font.Name := ddRequiredFont;
  Result.Left := aLeft;
  Result.Top := aTop;
  if (aLabelType = dd_cilAdditional) then
  begin
   Result.CCaption := l3CStr(l_Suffix);
   if (Result.Width + Result.Left) > aParent.Width then
   begin
    Control.Width := Control.Width-Result.Width-c_ConfigItemLeft;
    Result.Left := Control.Width + Control.Left + c_ConfigItemLeft;
   end;
   AdjustLabel(Control, Result);
  end
  else
   Result.CCaption := l3CStr(l_Prefix);
  if aLabelType = dd_cilRequired then
   Result.Top := Result.Top + c_ConfigItemTop;
  Result.Tag := AbsoluteIndex;
  if f_Hint <> '' then
  begin
   Result.Hint := f_Hint;
   Result.ShowHint := True;
  end;
  if LabelTop and (aLabelType = dd_cilMain) then
   Inc(aTop, Result.Height + c_ConfigItemTop)
  else
  if aLabelType = dd_cilRequired then
   Inc(aLeft, Result.Width)
  else
   Inc(aLeft, Result.Width + c_ConfigItemLeft);
 end
 else
  Result := nil;
 case aLabelType of
  dd_cilMain: f_Label := Result;
  dd_cilRequired: f_RequiredLabel := Result;
 end;
//#UC END# *5217620D0151_4E302F24003F_impl*
end;//TddVisualConfigItem.CreateLabel

function TddVisualConfigItem.GetCanvas(aParent: TWinControl): TCanvas;
//#UC START# *5217627A02E8_4E302F24003F_var*
var
 l_Form: TCustomForm;
//#UC END# *5217627A02E8_4E302F24003F_var*
begin
//#UC START# *5217627A02E8_4E302F24003F_impl*
 l_Form := GetForm(aParent);
 l_Form.Canvas.Font := l_Form.Font;
 Result := l_Form.Canvas;
//#UC END# *5217627A02E8_4E302F24003F_impl*
end;//TddVisualConfigItem.GetCanvas

function TddVisualConfigItem.GetForm(aParent: TWinControl): TCustomForm;
//#UC START# *521B04400217_4E302F24003F_var*
var
  l_Parent: TControl;
//#UC END# *521B04400217_4E302F24003F_var*
begin
//#UC START# *521B04400217_4E302F24003F_impl*
 if not (aParent is TCustomForm) then
 begin
  l_Parent := aParent.Parent;
  while (l_Parent <> nil) and not (l_Parent is TCustomForm) do
   l_Parent := l_Parent.Parent;
  Result := l_Parent as TCustomForm;
 end
 else
  Result := aParent as TCustomForm;
//#UC END# *521B04400217_4E302F24003F_impl*
end;//TddVisualConfigItem.GetForm

procedure TddVisualConfigItem.SplitCaption(const aCaption: AnsiString;
 out aPrefix: AnsiString;
 out aSuffix: AnsiString);
//#UC START# *521B048C0198_4E302F24003F_var*
var
 l_Pos: Integer;
//#UC END# *521B048C0198_4E302F24003F_var*
begin
//#UC START# *521B048C0198_4E302F24003F_impl*
 l_Pos := Pos('|', aCaption);
 if l_Pos > 0 then
 begin
  aPrefix := Copy(aCaption, 1, Pred(l_Pos));
  aSuffix := Copy(aCaption, Succ(l_Pos), Length(aCaption));
  if LabelTop then
  begin
   aPrefix := aPrefix + ', ' + aSuffix;
   aSuffix := '';
  end;
 end
 else
 begin
  aPrefix := aCaption;
  aSuffix := '';
 end;
//#UC END# *521B048C0198_4E302F24003F_impl*
end;//TddVisualConfigItem.SplitCaption

function TddVisualConfigItem.IsSame(anItem: TObject): Boolean;
//#UC START# *521B04BC01C6_4E302F24003F_var*
//#UC END# *521B04BC01C6_4E302F24003F_var*
begin
//#UC START# *521B04BC01C6_4E302F24003F_impl*
 Result := Self = anItem;
//#UC END# *521B04BC01C6_4E302F24003F_impl*
end;//TddVisualConfigItem.IsSame

procedure TddVisualConfigItem.ClearControl;
//#UC START# *521B05280392_4E302F24003F_var*
//#UC END# *521B05280392_4E302F24003F_var*
begin
//#UC START# *521B05280392_4E302F24003F_impl*
 f_Control := nil;
 f_Label := nil;
 f_FirstLabel := nil; // NEW ! ! !
//#UC END# *521B05280392_4E302F24003F_impl*
end;//TddVisualConfigItem.ClearControl

function TddVisualConfigItem.CreateControl(aLeft: Integer;
 aMaxLeft: Integer;
 aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521B0563000D_4E302F24003F_var*
var
 l_Label: TvtLabel;
 l_Caption: AnsiString;
//#UC END# *521B0563000D_4E302F24003F_var*
begin
//#UC START# *521B0563000D_4E302F24003F_impl*
 l_Label := nil;
 BeforeConstruct(aLeft, aMaxLeft, aTop, aParent);
 if Labeled then
 begin
  l_Label := Createlabel(aParent, Caption, aLeft, aTop, dd_cilMain);
  if (l_Label <> nil) and not LabelTop then
  begin
   if (aMaxLeft = 0) then
    aLeft := l_Label.Width + l_Label.Left + c_ConfigItemLeft
   else
    aLeft := aMaxLeft;
  end; // not LabelTop
 end;
 if MayBeRequired then
  if IsRequired then
   CreateLabel(aParent, ddRequiredSign, aLeft, aTop, dd_cilRequired).Font.Color := clRed
  else
   Inc(aLeft, RequiredSignWidth(aParent));
 f_Control := ConstructControl(aLeft, aMaxLeft, aTop, aParent);
 {.$IFDEF Nemesis}
 if Labeled then
  Createlabel(aParent, Caption, aLeft, aTop, dd_cilAdditional);
 {.$ENDIF}
 AfterConstruct(aLeft, aMaxLeft, aTop, f_Control, l_Label);
 DoEnabled;
 if Control <> nil then
  AdjustReadOnly(Control);
 Result := Control;
//#UC END# *521B0563000D_4E302F24003F_impl*
end;//TddVisualConfigItem.CreateControl

function TddVisualConfigItem.LabelHeight(aParent: TWinControl): Integer;
//#UC START# *521B05BF02BE_4E302F24003F_var*
var
 l_Label: TvtLabel;
//#UC END# *521B05BF02BE_4E302F24003F_var*
begin
//#UC START# *521B05BF02BE_4E302F24003F_impl*
 if (Caption = '') or not LabelTop then
  Result := 0
 else
 begin
  l_Label := TvtLabel.Create(nil);
  try
   l_Label.Parent := aParent;
   l_Label.CCaption := l3CStr(Caption);
   Result := l_Label.Height;
  finally
   FreeAndNil(l_Label);
  end;
 end;
//#UC END# *521B05BF02BE_4E302F24003F_impl*
end;//TddVisualConfigItem.LabelHeight

function TddVisualConfigItem.LabelWidth(aParent: TWinControl): Integer;
//#UC START# *521B05DF00FC_4E302F24003F_var*
var
 l_Label: TvtLabel;
 l_P, l_S: AnsiString;
//#UC END# *521B05DF00FC_4E302F24003F_var*
begin
//#UC START# *521B05DF00FC_4E302F24003F_impl*
 SplitCaption(Caption, l_P, l_S);
 if l_P = '' then
  Result := 0
 else
 begin
  l_Label := TvtLabel.Create(nil);
  try
   l_Label.Parent := aParent;
   l_Label.CCaption := l3CStr(l_P + IfThen(MayBeRequired,' '{Поле для звездочки}, ''));
   Result := l_Label.Width + c_ConfigItemLeft;
  finally
   FreeAndNil(l_Label);
  end;
 end;
//#UC END# *521B05DF00FC_4E302F24003F_impl*
end;//TddVisualConfigItem.LabelWidth

function TddVisualConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_4E302F24003F_var*
//#UC END# *521B061A0387_4E302F24003F_var*
begin
//#UC START# *521B061A0387_4E302F24003F_impl*
 Result := 0;
//#UC END# *521B061A0387_4E302F24003F_impl*
end;//TddVisualConfigItem.MinWidth

procedure TddVisualConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_4E302F24003F_var*
//#UC END# *552BB745031E_4E302F24003F_var*
begin
//#UC START# *552BB745031E_4E302F24003F_impl*
// DoNothing
//#UC END# *552BB745031E_4E302F24003F_impl*
end;//TddVisualConfigItem.AdjustReadOnly

procedure TddVisualConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_4E302F24003F_var*
//#UC END# *478CF34E02CE_4E302F24003F_var*
begin
//#UC START# *478CF34E02CE_4E302F24003F_impl*
 if Source is TddVisualConfigItem then
 begin
  inherited;
  Hint := TddVisualConfigItem(Source).Hint;
  Labeled := TddVisualConfigItem(Source).Labeled;
  LabelTop := TddVisualConfigItem(Source).LabelTop;
 end
 else
  inherited;
//#UC END# *478CF34E02CE_4E302F24003F_impl*
end;//TddVisualConfigItem.Assign

procedure TddVisualConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E302F24003F_var*
//#UC END# *479731C50290_4E302F24003F_var*
begin
//#UC START# *479731C50290_4E302F24003F_impl*
 try
  FreeAndNil(f_Slaves);
  ClearControl;
  inherited;
 finally
  f_Control := nil;
 end;//try..finally
//#UC END# *479731C50290_4E302F24003F_impl*
end;//TddVisualConfigItem.Cleanup

procedure TddVisualConfigItem.DoEnabled;
//#UC START# *52171D0D031D_4E302F24003F_var*
//#UC END# *52171D0D031D_4E302F24003F_var*
begin
//#UC START# *52171D0D031D_4E302F24003F_impl*
 if Control <> nil then
  Control.Enabled := Enabled;
 if f_Label <> nil then
 begin
  f_Label.Enabled := Enabled;
  f_Label.Refresh;
 end;
 ChangeSlaveStatus(Enabled);
//#UC END# *52171D0D031D_4E302F24003F_impl*
end;//TddVisualConfigItem.DoEnabled

function TddVisualConfigItem.pm_GetChanged: Boolean;
//#UC START# *5217205002F2_4E302F24003Fget_var*
//#UC END# *5217205002F2_4E302F24003Fget_var*
begin
//#UC START# *5217205002F2_4E302F24003Fget_impl*
 Result := inherited pm_GetChanged;
//#UC END# *5217205002F2_4E302F24003Fget_impl*
end;//TddVisualConfigItem.pm_GetChanged

procedure TddVisualConfigItem.pm_SetChanged(aValue: Boolean);
//#UC START# *5217205002F2_4E302F24003Fset_var*
var
 l_Value: TddConfigValue;
 I: Integer;
//#UC END# *5217205002F2_4E302F24003Fset_var*
begin
//#UC START# *5217205002F2_4E302F24003Fset_impl*
 (* ! ! ! ! Починить
 if not IsLocked and aValue and (Control <> nil) then
  begin
   Lock;
   try
    l3Move(f_Value, l_Value, SizeOf(TddConfigValue));
    GetValueFromControl;
    for I := 0 to f_NotifyList.Hi do
     TddBaseConfigItem(f_NotifyList.Items[I]).ProcessNotify(Value);
    l3Move(l_Value, f_Value, SizeOf(TddConfigValue));
   finally
    UnLock;
   end;
  end; // not IsLocked and aValue and (Control <> nil)
 *)
 inherited;
//#UC END# *5217205002F2_4E302F24003Fset_impl*
end;//TddVisualConfigItem.pm_SetChanged

function TddVisualConfigItem.pm_GetValue: TddConfigValue;
//#UC START# *521725130281_4E302F24003Fget_var*
//#UC END# *521725130281_4E302F24003Fget_var*
begin
//#UC START# *521725130281_4E302F24003Fget_impl*
 Result := inherited pm_GetValue; 
//#UC END# *521725130281_4E302F24003Fget_impl*
end;//TddVisualConfigItem.pm_GetValue

procedure TddVisualConfigItem.pm_SetValue(const aValue: TddConfigValue);
//#UC START# *521725130281_4E302F24003Fset_var*
//#UC END# *521725130281_4E302F24003Fset_var*
begin
//#UC START# *521725130281_4E302F24003Fset_impl*
 if Control <> nil then
  Lock; // Иначе затирается выставленное значение
 try
  inherited;
 finally
  if Control <> nil then
   Unlock;
 end;
 if not IsLocked and (Control <> nil) then
  SetValueToControl(False);
//#UC END# *521725130281_4E302F24003Fset_impl*
end;//TddVisualConfigItem.pm_SetValue

constructor TddVisualConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_4E302F24003F_var*
//#UC END# *5217273F000F_4E302F24003F_var*
begin
//#UC START# *5217273F000F_4E302F24003F_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_LabelTop := True;
 MasterItem := aMasterItem;
 f_Control := nil;
 f_Label := nil;
 f_Locked := 0;
 Labeled := True;
 Visible := True;
//#UC END# *5217273F000F_4E302F24003F_impl*
end;//TddVisualConfigItem.Create

procedure TddVisualConfigItem.ReadOnlyChanged;
//#UC START# *552BA9B9039B_4E302F24003F_var*
//#UC END# *552BA9B9039B_4E302F24003F_var*
begin
//#UC START# *552BA9B9039B_4E302F24003F_impl*
 if Assigned(f_Control) then
  AdjustReadOnly(f_Control);
//#UC END# *552BA9B9039B_4E302F24003F_impl*
end;//TddVisualConfigItem.ReadOnlyChanged

procedure TddVisualConfigItem.ClearFields;
begin
 Hint := '';
 inherited;
end;//TddVisualConfigItem.ClearFields

procedure TddIntegerConfigItem.pm_SetMaxValue(aValue: Integer);
//#UC START# *5220C01C00FF_5220BFBC0399set_var*
//#UC END# *5220C01C00FF_5220BFBC0399set_var*
begin
//#UC START# *5220C01C00FF_5220BFBC0399set_impl*
 if f_MaxValue <> aValue then
 begin
  if aValue <= ddMaxInt then
   f_MaxValue := aValue
  else
   raise EddConfigError.CreateFmt(str_ddcmInvalidMaxValue.AsStr, [aValue, ddMaxInt]);
 end;
//#UC END# *5220C01C00FF_5220BFBC0399set_impl*
end;//TddIntegerConfigItem.pm_SetMaxValue

procedure TddIntegerConfigItem.pm_SetMinValue(aValue: Integer);
//#UC START# *5220C02A0383_5220BFBC0399set_var*
//#UC END# *5220C02A0383_5220BFBC0399set_var*
begin
//#UC START# *5220C02A0383_5220BFBC0399set_impl*
 if f_MinValue <> aValue then
 begin
  if aValue >= ddMinInt then
   f_MinValue := aValue
  else
   raise EddConfigError.CreateFmt(str_ddcmInvalidMinValue.AsStr, [aValue, ddMaxInt]);
 end;
//#UC END# *5220C02A0383_5220BFBC0399set_impl*
end;//TddIntegerConfigItem.pm_SetMinValue

procedure TddIntegerConfigItem.Validate;
//#UC START# *5220C05000A7_5220BFBC0399_var*
//#UC END# *5220C05000A7_5220BFBC0399_var*
begin
//#UC START# *5220C05000A7_5220BFBC0399_impl*
 if (IntegerValue > MaxValue) or (IntegerValue < MinValue) then
  raise EddInvalidValue.CreateFmt(str_ddcmErrorIntegerRange.AsStr,
    [IntegerValue, MinValue, MaxValue], Self);
//#UC END# *5220C05000A7_5220BFBC0399_impl*
end;//TddIntegerConfigItem.Validate

procedure TddIntegerConfigItem.DoOnChange(Sender: TObject);
//#UC START# *5220C06103B2_5220BFBC0399_var*
//#UC END# *5220C06103B2_5220BFBC0399_var*
begin
//#UC START# *5220C06103B2_5220BFBC0399_impl*
 {$IFDEF ddUseVTSpin}
 Assert(Control is TvtSpinEdit, Control.ClassName); 
 Changed := TvtSpinEdit(Control).Text <> IntToStr(IntegerValue);
 {$ELSE}
 Assert(Control is TEdit, Control.ClassName); 
 Changed := TEdit(Control).Text <> IntToStr(IntegerValue);
 {$ENDIF}
//#UC END# *5220C06103B2_5220BFBC0399_impl*
end;//TddIntegerConfigItem.DoOnChange

constructor TddIntegerConfigItem.CreateItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefaultValue: Integer;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5220C0FF0081_5220BFBC0399_var*
var
 l_Value : TddConfigValue;
//#UC END# *5220C0FF0081_5220BFBC0399_var*
begin
//#UC START# *5220C0FF0081_5220BFBC0399_impl*
 with l_Value do
 begin
  Kind := dd_vkInteger;
  AsInteger := aDefaultValue;
 end;
 Create(aAlias, aCaption, l_Value, aMasterItem);
//#UC END# *5220C0FF0081_5220BFBC0399_impl*
end;//TddIntegerConfigItem.CreateItem

function TddIntegerConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5220BFBC0399_var*
var
 l_MaxValue: Integer;
//#UC END# *521761BB03DE_5220BFBC0399_var*
begin
//#UC START# *521761BB03DE_5220BFBC0399_impl*
{$IFDEF ddUseVTSpin}
 Result := TvtSpinEdit.Create(aParent);
{$ELSE}
 //Result := TSpinEdit.Create(aParent);
 Result := TEdit.Create(aParent);
 f_UpDown := TUpDown.Create(aParent);
 with f_UpDown do
 begin
  Parent := aParent;
  Thousands := False;
 end;
 {$ENDIF}
 Result.Parent := aParent;
 {$IFDEF ddUseVTSpin}
 //TvtSpinEdit(Result).ButtonKind := bkClassic;
 TvtSpinEdit(Result).MaxValue := MaxValue;
 TvtSpinEdit(Result).MinValue := MinValue;
 TvtSpinEdit(Result).AllowAnyValueManualInput := True;
 TvtSpinEdit(Result).EmptyValue := MinValue - 1;
 TvtSpinEdit(Result).OnChange := DoOnChange;
 {$ELSE}
 TEdit(Result).OnChange := DoOnChange;
 TEdit(Result).MaxLength := Length(IntToStr(MaxValue));
 f_UpDown.Min := MinValue;
 f_UpDown.Max := MaxValue;
 {$ENDIF}
 Result.Top := aTop;
 Result.Left := aLeft;
 l_MaxValue := Max(Abs(MaxValue), Abs(MinValue));
 if l_MaxValue = 0 then
  l_MaxValue := Low(l_MaxValue);
 Result.Width := GetCanvas(aParent).TextWidth(IntToStr(l_MaxValue) + ' ') + 16 + c_ConfigItemLeft;
 {$IfNDef ddUseVTSpin}
 f_UpDown.Associate := TWinControl(Result);
 {$EndIf ddUseVTSpin}
//#UC END# *521761BB03DE_5220BFBC0399_impl*
end;//TddIntegerConfigItem.ConstructControl

function TddIntegerConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5220BFBC0399_var*
//#UC END# *521B053F03C3_5220BFBC0399_var*
begin
//#UC START# *521B053F03C3_5220BFBC0399_impl*
 {$IFDEF ddUseVTSpin}
 with TvtSpinEdit.Create(aParent) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
 {$ELSE}
 with TEdit.Create(aParent) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
 {$ENDIF}
//#UC END# *521B053F03C3_5220BFBC0399_impl*
end;//TddIntegerConfigItem.ControlHeight

procedure TddIntegerConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5220BFBC0399_var*
 function lpCheckValue : Integer;
 var
  lValue : Integer;
 begin
  Assert(Control is TEdit, Control.ClassName); 
  lValue := StrToIntDef(TEdit(Control).Text, MaxInt);
  // Не является числом
  if lValue = MaxInt then
   raise EddInvalidValue.CreateFmt(str_ddcmInvalidIntegerValue.AsStr,
    [TEdit(Control).Text], Self);
  // Выходит за пределы диапазона
  if  not InRange(lValue, MinValue, MaxValue) then
   raise EddInvalidValue.CreateFmt(str_ddcmErrorIntegerRange.AsStr,
    [lValue, MinValue, MaxValue], Self);
  Result := lValue;
 end;
//#UC END# *521B058801FD_5220BFBC0399_var*
begin
//#UC START# *521B058801FD_5220BFBC0399_impl*
 {$IFDEF ddUseVTSpin}
 if StrToIntDef(TvtSpinEdit(Control).Text, MaxInt) = MaxInt then
  raise EddInvalidValue.CreateFmt(str_ddcmInvalidIntegerValue.AsStr,
   [TvtSpinEdit(Control).Text], Self);

 IntegerValue := TvtSpinEdit(Control).AsInteger;
 Validate;
 {$ELSE}
 IntegerValue := lpCheckValue;
 {$ENDIF}
//#UC END# *521B058801FD_5220BFBC0399_impl*
end;//TddIntegerConfigItem.GetValueFromControl

procedure TddIntegerConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5220BFBC0399_var*
var
 I: Integer;
//#UC END# *521B07030052_5220BFBC0399_var*
begin
//#UC START# *521B07030052_5220BFBC0399_impl*
 if aDefault then
  I := DefaultValue.AsInteger
 else
  I := IntegerValue;
 {$IFDEF ddUseVTSpin}
 Assert(Control is TvtSpinEdit, Control.ClassName);
 TvtSpinEdit(Control).Value := I;
 {$ELSE}
 Assert(Control is TEdit, Control.ClassName); 
 TEdit(Control).Text := IntToStr(I);
 f_UpDown.Position := I;
 {$ENDIF}
//#UC END# *521B07030052_5220BFBC0399_impl*
end;//TddIntegerConfigItem.SetValueToControl

procedure TddIntegerConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5220BFBC0399_var*
//#UC END# *478CF34E02CE_5220BFBC0399_var*
begin
//#UC START# *478CF34E02CE_5220BFBC0399_impl*
 if Source is TddIntegerConfigItem then
 begin
  inherited;
  Self.f_MaxValue := TddIntegerConfigItem(Source).MaxValue;
  Self.f_MinValue := TddIntegerConfigItem(Source).MinValue;
 end else
  inherited;
//#UC END# *478CF34E02CE_5220BFBC0399_impl*
end;//TddIntegerConfigItem.Assign

constructor TddIntegerConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5220BFBC0399_var*
//#UC END# *5217273F000F_5220BFBC0399_var*
begin
//#UC START# *5217273F000F_5220BFBC0399_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 MinValue := ddMinInt;
 MaxValue := ddMaxInt;
 LabelTop := False;
 f_Value.Kind := dd_vkInteger;
//#UC END# *5217273F000F_5220BFBC0399_impl*
end;//TddIntegerConfigItem.Create

procedure TddIntegerConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5220BFBC0399_var*
var
 l_Value: TddConfigValue;
//#UC END# *52172B72014C_5220BFBC0399_var*
begin
//#UC START# *52172B72014C_5220BFBC0399_impl*
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := aStorage.ReadInteger(Alias, DefaultValue.AsInteger);
 if InRange(l_Value.AsInteger, MinValue, MaxValue) then
  Value := l_Value;
//#UC END# *52172B72014C_5220BFBC0399_impl*
end;//TddIntegerConfigItem.LoadValue

procedure TddIntegerConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5220BFBC0399_var*
//#UC END# *52172CA801E3_5220BFBC0399_var*
begin
//#UC START# *52172CA801E3_5220BFBC0399_impl*
 aStorage.WriteInteger(Alias, Value.AsInteger);
//#UC END# *52172CA801E3_5220BFBC0399_impl*
end;//TddIntegerConfigItem.SaveValue

function TddIntegerConfigItem.pm_GetLabelTop: Boolean;
//#UC START# *5217602C020A_5220BFBC0399get_var*
//#UC END# *5217602C020A_5220BFBC0399get_var*
begin
//#UC START# *5217602C020A_5220BFBC0399get_impl*
 Result := inherited pm_GetLabelTop;
//#UC END# *5217602C020A_5220BFBC0399get_impl*
end;//TddIntegerConfigItem.pm_GetLabelTop

procedure TddIntegerConfigItem.pm_SetLabelTop(aValue: Boolean);
//#UC START# *5217602C020A_5220BFBC0399set_var*
//#UC END# *5217602C020A_5220BFBC0399set_var*
begin
//#UC START# *5217602C020A_5220BFBC0399set_impl*
 f_LabelTop := False;
//#UC END# *5217602C020A_5220BFBC0399set_impl*
end;//TddIntegerConfigItem.pm_SetLabelTop

procedure TddIntegerConfigItem.ClearControl;
//#UC START# *521B05280392_5220BFBC0399_var*
//#UC END# *521B05280392_5220BFBC0399_var*
begin
//#UC START# *521B05280392_5220BFBC0399_impl*
 inherited;
 FirstLabel := nil;
//#UC END# *521B05280392_5220BFBC0399_impl*
end;//TddIntegerConfigItem.ClearControl

function TddIntegerConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_5220BFBC0399_var*
//#UC END# *521B061A0387_5220BFBC0399_var*
begin
//#UC START# *521B061A0387_5220BFBC0399_impl*
 Result := 32;
//#UC END# *521B061A0387_5220BFBC0399_impl*
end;//TddIntegerConfigItem.MinWidth

procedure TddIntegerConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5220BFBC0399_var*
//#UC END# *552BB745031E_5220BFBC0399_var*
begin
//#UC START# *552BB745031E_5220BFBC0399_impl*
 if aControl is TvtSpinEdit then
  TvtSpinEdit(aControl).ReadOnly := ReadOnly
 else
 begin
  if aControl is TEdit then
   TEdit(aControl).ReadOnly := ReadOnly;
  if Assigned(f_UpDown) then
   f_UpDown.Enabled := f_UpDown.Enabled and not ReadOnly;
 end;
//#UC END# *552BB745031E_5220BFBC0399_impl*
end;//TddIntegerConfigItem.AdjustReadOnly

constructor EddInvalidValue.CreateFmt(const aMsg: AnsiString;
 const Args: array of const;
 aItem: TddVisualConfigItem);
//#UC START# *521622D00234_521621FD0394_var*
//#UC END# *521622D00234_521621FD0394_var*
begin
//#UC START# *521622D00234_521621FD0394_impl*
 inherited CreateFmt(aMsg, Args);
 f_Item := aItem;
//#UC END# *521622D00234_521621FD0394_impl*
end;//EddInvalidValue.CreateFmt

procedure TddMapValueConfigItem.pm_SetItem(const aValue: AnsiString);
//#UC START# *52245AE202CF_4E302F130143set_var*
//#UC END# *52245AE202CF_4E302F130143set_var*
begin
//#UC START# *52245AE202CF_4E302F130143set_impl*
 AddMapValue(aValue, aValue);
//#UC END# *52245AE202CF_4E302F130143set_impl*
end;//TddMapValueConfigItem.pm_SetItem

procedure TddMapValueConfigItem.AddMapValue(const aCaption: AnsiString;
 const aValue: TddConfigValue);
//#UC START# *52245B740188_4E302F130143_var*
//#UC END# *52245B740188_4E302F130143_var*
begin
//#UC START# *52245B740188_4E302F130143_impl*
 Assert(f_ValueMap = Nil,'Il3ValueMap assigned. Use of AddMapValue disabled');
 f_MapValues.AddMapValue(aCaption, aValue);
//#UC END# *52245B740188_4E302F130143_impl*
end;//TddMapValueConfigItem.AddMapValue

procedure TddMapValueConfigItem.AddMapValue(const aCaption: AnsiString;
 aValue: Integer);
//#UC START# *52245B81014A_4E302F130143_var*
var
 l_Value : TddConfigValue;
//#UC END# *52245B81014A_4E302F130143_var*
begin
//#UC START# *52245B81014A_4E302F130143_impl*
 with l_Value do
 begin
  Kind := dd_vkInteger;
  AsInteger := aValue;
 end;
 AddMapValue(aCaption, l_Value);
//#UC END# *52245B81014A_4E302F130143_impl*
end;//TddMapValueConfigItem.AddMapValue

procedure TddMapValueConfigItem.AddMapValue(const aCaption: AnsiString;
 const aValue: AnsiString);
//#UC START# *52245B900389_4E302F130143_var*
var
 l_Value : TddConfigValue;
//#UC END# *52245B900389_4E302F130143_var*
begin
//#UC START# *52245B900389_4E302F130143_impl*
 with l_Value do
 begin
  Kind := dd_vkString;
  AsString := aValue;
 end;
 AddMapValue(aCaption, l_Value);
//#UC END# *52245B900389_4E302F130143_impl*
end;//TddMapValueConfigItem.AddMapValue

constructor TddMapValueConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 const aValueMap: Il3ValueMap = nil;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *52245BFF021F_4E302F130143_var*
//#UC END# *52245BFF021F_4E302F130143_var*
begin
//#UC START# *52245BFF021F_4E302F130143_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_ValueMap := aValueMap;
 f_ValueKind := aDefaultValue.Kind;
 f_Value.Kind := aDefaultValue.Kind;
 f_MapValues := TMapValues.Create(f_ValueKind);
//#UC END# *52245BFF021F_4E302F130143_impl*
end;//TddMapValueConfigItem.Create

function TddMapValueConfigItem.IsSet: Boolean;
//#UC START# *52245D8D0350_4E302F130143_var*
//#UC END# *52245D8D0350_4E302F130143_var*
begin
//#UC START# *52245D8D0350_4E302F130143_impl*
 Result := Assigned(f_ValueMap) or (f_MapValues.Count > 0);
//#UC END# *52245D8D0350_4E302F130143_impl*
end;//TddMapValueConfigItem.IsSet

function TddMapValueConfigItem.CalcDisplayName(const aValue: TddConfigValue): AnsiString;
//#UC START# *52245DAD015F_4E302F130143_var*
//#UC END# *52245DAD015F_4E302F130143_var*
begin
//#UC START# *52245DAD015F_4E302F130143_impl*
 if Assigned(f_ValueMap) then
 case f_ValueKind of
  dd_vkString:  Result := l3Str((f_ValueMap as Il3StringValueMap).ValueToDisplayName(l3CStr(aValue.AsString)));
  dd_vkInteger: Result := l3Str((f_ValueMap as Il3IntegerValueMap).ValueToDisplayName(aValue.AsInteger));
  dd_vkBoolean: Result := l3Str((f_ValueMap as Il3IntegerValueMap).ValueToDisplayName(ord(aValue.AsBoolean)));
 else
  Result := '';
  Assert(False, 'Unsupported combobox value type');
 end
 else
  Result := f_MapValues.Items[f_MapValues.IndexOfValue(aValue)].Caption;
//#UC END# *52245DAD015F_4E302F130143_impl*
end;//TddMapValueConfigItem.CalcDisplayName

function TddMapValueConfigItem.CalcValue(const aName: Il3CString): TddConfigValue;
//#UC START# *52245DCB009E_4E302F130143_var*
var
 l_Index: Integer;
//#UC END# *52245DCB009E_4E302F130143_var*
begin
//#UC START# *52245DCB009E_4E302F130143_impl*
 Result.Kind := f_ValueKind;
 if (f_ValueMap <> nil) then
  Case f_ValueKind of
   dd_vkString: Result.AsString := l3Str((f_ValueMap as Il3StringValueMap).DisplayNameToValue(aName));
   dd_vkInteger: Result.AsInteger := (f_ValueMap as Il3IntegerValueMap).DisplayNameToValue(aName);
   dd_vkBoolean: Result.AsBoolean := Boolean((f_ValueMap as Il3IntegerValueMap).DisplayNameToValue(aName));
  else
   Result := DefaultValue;
   Assert(False, 'Unsupported combobox value type');
  end
 else
 begin
  l_Index := f_MapValues.IndexOfCaption(aName);
  if l_Index <> -1 then
   Result := f_MapValues.Items[l_Index].Value
  else
   Result := DisplayNameToValue(aName);
 end;//f_ValueMap <> nil
//#UC END# *52245DCB009E_4E302F130143_impl*
end;//TddMapValueConfigItem.CalcValue

function TddMapValueConfigItem.DisplayNameToValue(const aName: Il3CString): TddConfigValue;
//#UC START# *52245E3E0387_4E302F130143_var*
//#UC END# *52245E3E0387_4E302F130143_var*
begin
//#UC START# *52245E3E0387_4E302F130143_impl*
 Result.Kind := f_MapValues.MapKind;
 case f_ValueKind of
  dd_vkString: Result.AsString := l3Str(aName);
 else
  raise EddInvalidValue.Create(str_ddcmInvalidMapValue.AsStr);
 end;
//#UC END# *52245E3E0387_4E302F130143_impl*
end;//TddMapValueConfigItem.DisplayNameToValue

procedure TddMapValueConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_4E302F130143_var*
//#UC END# *478CF34E02CE_4E302F130143_var*
begin
//#UC START# *478CF34E02CE_4E302F130143_impl*
 if Source is TddMapValueConfigItem then
  with TddMapValueConfigItem(Source) do
  begin
   inherited Assign(Source);
   Self.f_ValueMap := f_ValueMap;
   Self.f_MapValues.Assign(f_MapValues);
   Self.f_ValueKind := f_ValueKind;
  end;
//#UC END# *478CF34E02CE_4E302F130143_impl*
end;//TddMapValueConfigItem.Assign

procedure TddMapValueConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E302F130143_var*
//#UC END# *479731C50290_4E302F130143_var*
begin
//#UC START# *479731C50290_4E302F130143_impl*
 f_ValueMap := nil;
 FreeAndNil(f_MapValues);
 inherited;
//#UC END# *479731C50290_4E302F130143_impl*
end;//TddMapValueConfigItem.Cleanup

procedure TddMapValueConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_4E302F130143_var*
//#UC END# *52172B72014C_4E302F130143_var*
begin
//#UC START# *52172B72014C_4E302F130143_impl*
 // установим текущее значение
 case f_ValueKind of
  dd_vkString: StringValue := l3Str(aStorage.ReadString(Alias, DefaultValue.AsString));
  dd_vkInteger: IntegerValue := aStorage.ReadInteger(Alias, DefaultValue.AsInteger);
  dd_vkBoolean : BooleanValue := aStorage.ReadBool(Alias, DefaultValue.AsBoolean);
  dd_vkDateTime : DateTimeValue := aStorage.ReadDateTime(Alias, DefaultValue.AsDateTime);
 else
  raise EddConfigError.Create('Неподдерживаемый тип map-value');
 end;
//#UC END# *52172B72014C_4E302F130143_impl*
end;//TddMapValueConfigItem.LoadValue

procedure TddMapValueConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_4E302F130143_var*
//#UC END# *52172CA801E3_4E302F130143_var*
begin
//#UC START# *52172CA801E3_4E302F130143_impl*
 case f_ValueKind of
  dd_vkString: aStorage.WriteString(Alias, Value.AsString);
  dd_vkInteger: aStorage.WriteInteger(Alias, IntegerValue);
  dd_vkBoolean : aStorage.WriteBool(Alias, BooleanValue);
  dd_vkDateTime : aStorage.WriteDateTime(Alias, DateTimeValue);
 else
  raise EddConfigError.Create('Неподдерживаемый тип map-value');
 end;
//#UC END# *52172CA801E3_4E302F130143_impl*
end;//TddMapValueConfigItem.SaveValue

function TddMapValueConfigItem.Clone: Pointer;
//#UC START# *5301EC7500FF_4E302F130143_var*
//#UC END# *5301EC7500FF_4E302F130143_var*
begin
//#UC START# *5301EC7500FF_4E302F130143_impl*
 Result := TddMapValueConfigItem.Create(Alias, Caption, DefaultValue, ValueMap, MasterItem);
 TddMapValueConfigItem(Result).Assign(Self);
//#UC END# *5301EC7500FF_4E302F130143_impl*
end;//TddMapValueConfigItem.Clone

procedure TddMapValueConfigItem.ClearFields;
begin
 f_ValueMap := nil;
 inherited;
end;//TddMapValueConfigItem.ClearFields

procedure TddRadioGroupConfigItem.pm_SetMaxCount(aValue: Integer);
//#UC START# *5226101F0249_52260D9A0238set_var*
//#UC END# *5226101F0249_52260D9A0238set_var*
begin
//#UC START# *5226101F0249_52260D9A0238set_impl*
 f_MaxCount := Min(32, aValue);
//#UC END# *5226101F0249_52260D9A0238set_impl*
end;//TddRadioGroupConfigItem.pm_SetMaxCount

procedure TddRadioGroupConfigItem.Add(const aItem: AnsiString);
//#UC START# *522610770231_52260D9A0238_var*
//#UC END# *522610770231_52260D9A0238_var*
begin
//#UC START# *522610770231_52260D9A0238_impl*
 if f_Items.Count < f_MaxCount then
  f_Items.Add(aItem)
 else
  raise EListError.CreateFmt('Превышен размер списка (%d)', [f_MaxCount]);
//#UC END# *522610770231_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.Add

procedure TddRadioGroupConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_52260D9A0238_var*
//#UC END# *478CF34E02CE_52260D9A0238_var*
begin
//#UC START# *478CF34E02CE_52260D9A0238_impl*
 inherited;
 if Source is TddRadioGroupConfigItem then
  f_Items.Assign(TddRadioGroupConfigItem(Source).f_Items);
//#UC END# *478CF34E02CE_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.Assign

procedure TddRadioGroupConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52260D9A0238_var*
//#UC END# *479731C50290_52260D9A0238_var*
begin
//#UC START# *479731C50290_52260D9A0238_impl*
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.Cleanup

constructor TddRadioGroupConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_52260D9A0238_var*
//#UC END# *5217273F000F_52260D9A0238_var*
begin
//#UC START# *5217273F000F_52260D9A0238_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_Items := TStringList.Create;
 LabelTop := True;
 Labeled := False;
 f_MaxCount := 32;
//#UC END# *5217273F000F_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.Create

function TddRadioGroupConfigItem.pm_GetLabelTop: Boolean;
//#UC START# *5217602C020A_52260D9A0238get_var*
//#UC END# *5217602C020A_52260D9A0238get_var*
begin
//#UC START# *5217602C020A_52260D9A0238get_impl*
 Result := inherited pm_GetLabelTop;
//#UC END# *5217602C020A_52260D9A0238get_impl*
end;//TddRadioGroupConfigItem.pm_GetLabelTop

procedure TddRadioGroupConfigItem.pm_SetLabelTop(aValue: Boolean);
//#UC START# *5217602C020A_52260D9A0238set_var*
//#UC END# *5217602C020A_52260D9A0238set_var*
begin
//#UC START# *5217602C020A_52260D9A0238set_impl*
 f_LabelTop := aValue;
//#UC END# *5217602C020A_52260D9A0238set_impl*
end;//TddRadioGroupConfigItem.pm_SetLabelTop

function TddRadioGroupConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_52260D9A0238_var*
//#UC END# *521761BB03DE_52260D9A0238_var*
begin
//#UC START# *521761BB03DE_52260D9A0238_impl*
 Result := TRadioGroup.Create(aParent);
 Result.Parent := aParent as TWinControl;
 Result.Left := aLeft;
 Result.Top := aTop;
 if aParent is TScrollBox
  then Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight - c_ScrollBarWidth
  else Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight;
 Result.Height := ControlHeight(aParent);
 TRadioGroup(Result).Items := f_Items;
 TRadioGroup(Result).Caption := Caption;
 TRadioGroup(Result).OnClick := DoOnChange;
//#UC END# *521761BB03DE_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.ConstructControl

function TddRadioGroupConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_52260D9A0238_var*
//#UC END# *521B053F03C3_52260D9A0238_var*
begin
//#UC START# *521B053F03C3_52260D9A0238_impl*
 Result := GetCanvas(aParent).TextHeight('A');
 Inc(Result, (f_Items.Count + 2) * Result);
//#UC END# *521B053F03C3_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.ControlHeight

procedure TddRadioGroupConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_52260D9A0238_var*
//#UC END# *521B058801FD_52260D9A0238_var*
begin
//#UC START# *521B058801FD_52260D9A0238_impl*
 IntegerValue := TRadioGroup(Control).ItemIndex;
//#UC END# *521B058801FD_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.GetValueFromControl

procedure TddRadioGroupConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_52260D9A0238_var*
var
 I: Integer;
//#UC END# *521B07030052_52260D9A0238_var*
begin
//#UC START# *521B07030052_52260D9A0238_impl*
 if aDefault then
  I := DefaultValue.AsInteger
 else
  I := IntegerValue;
 TRadioGroup(Control).ItemIndex := I;
//#UC END# *521B07030052_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.SetValueToControl

procedure TddRadioGroupConfigItem.DoOnChange(Sender: TObject);
//#UC START# *5220C06103B2_52260D9A0238_var*
//#UC END# *5220C06103B2_52260D9A0238_var*
begin
//#UC START# *5220C06103B2_52260D9A0238_impl*
 Changed := True;
//#UC END# *5220C06103B2_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.DoOnChange

procedure TddRadioGroupConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_52260D9A0238_var*
//#UC END# *552BB745031E_52260D9A0238_var*
begin
//#UC START# *552BB745031E_52260D9A0238_impl*
 if aControl is TRadioGroup then
  TRadioGroup(aControl).Enabled := TRadioGroup(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_52260D9A0238_impl*
end;//TddRadioGroupConfigItem.AdjustReadOnly

constructor TddRadioConfigItem.CreateItem(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefaultValue: Boolean;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *522447C701ED_522446F90281_var*
var
 l_Value : TddConfigValue;
//#UC END# *522447C701ED_522446F90281_var*
begin
//#UC START# *522447C701ED_522446F90281_impl*
 with l_Value do
 begin
  Kind := dd_vkBoolean;
  AsBoolean := aDefaultValue;
 end;
 Create(aAlias, aCaption, l_Value, aMasterItem);
//#UC END# *522447C701ED_522446F90281_impl*
end;//TddRadioConfigItem.CreateItem

procedure TddRadioConfigItem.DoOnChange(Sender: TObject);
//#UC START# *5224480E021D_522446F90281_var*
//#UC END# *5224480E021D_522446F90281_var*
begin
//#UC START# *5224480E021D_522446F90281_impl*
 GetValueFromControl;
 ChangeSlaveStatus(BooleanValue);
//#UC END# *5224480E021D_522446F90281_impl*
end;//TddRadioConfigItem.DoOnChange

function TddRadioConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_522446F90281_var*
//#UC END# *521761BB03DE_522446F90281_var*
begin
//#UC START# *521761BB03DE_522446F90281_impl*
 Result := TvtRadioButton.Create(aParent);
 Result.Parent := aParent;
 Result.Left := aLeft;
 Result.Top := aTop;
 Result.Width := GetCanvas(aParent).TextWidth(Caption) + 2 * c_ConfigItemLeft;
 with Result as TvtRadioButton do
 begin
  Caption := Self.Caption;
  OnChange := DoOnChange;
 end;
//#UC END# *521761BB03DE_522446F90281_impl*
end;//TddRadioConfigItem.ConstructControl

function TddRadioConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_522446F90281_var*
//#UC END# *521B053F03C3_522446F90281_var*
begin
//#UC START# *521B053F03C3_522446F90281_impl*
 with TvtRadioButton.Create(nil) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
//#UC END# *521B053F03C3_522446F90281_impl*
end;//TddRadioConfigItem.ControlHeight

procedure TddRadioConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_522446F90281_var*
//#UC END# *521B058801FD_522446F90281_var*
begin
//#UC START# *521B058801FD_522446F90281_impl*
 BooleanValue := TvtRadioButton(Control).Checked;
//#UC END# *521B058801FD_522446F90281_impl*
end;//TddRadioConfigItem.GetValueFromControl

procedure TddRadioConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_522446F90281_var*
//#UC END# *521B07030052_522446F90281_var*
begin
//#UC START# *521B07030052_522446F90281_impl*
 with TvtRadioButton(Control) do
  if aDefault
   then Checked := DefaultValue.AsBoolean
   else Checked := BooleanValue;
//#UC END# *521B07030052_522446F90281_impl*
end;//TddRadioConfigItem.SetValueToControl

constructor TddRadioConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_522446F90281_var*
//#UC END# *5217273F000F_522446F90281_var*
begin
//#UC START# *5217273F000F_522446F90281_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 if (f_Value.Kind = dd_vkString) then
  f_Value.Kind := dd_vkBoolean;
 Assert(f_Value.Kind in [dd_vkBoolean, dd_vkInteger]);
 Labeled := False;
//#UC END# *5217273F000F_522446F90281_impl*
end;//TddRadioConfigItem.Create

function TddRadioConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_522446F90281_var*
//#UC END# *521B061A0387_522446F90281_var*
begin
//#UC START# *521B061A0387_522446F90281_impl*
 with TvtRadioButton.Create(nil) do
 try
  Parent := aParent;
  Caption := Self.Caption;
  Result := Width + c_ConfigItemLeft;
 finally
  Free;
 end;
//#UC END# *521B061A0387_522446F90281_impl*
end;//TddRadioConfigItem.MinWidth

procedure TddRadioConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_522446F90281_var*
//#UC END# *552BB745031E_522446F90281_var*
begin
//#UC START# *552BB745031E_522446F90281_impl*
 if aControl is TvtRadioButton then
  TvtRadioButton(aControl).Enabled := TvtRadioButton(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_522446F90281_impl*
end;//TddRadioConfigItem.AdjustReadOnly

function TddGroupConfigItem.pm_GetSubItem(Index: Integer): TddVisualConfigItem;
//#UC START# *5227080C0080_5227064102D9get_var*
//#UC END# *5227080C0080_5227064102D9get_var*
begin
//#UC START# *5227080C0080_5227064102D9get_impl*
 Assert(f_SubItems <> nil);
 Result := TddVisualConfigItem(f_SubItems.Items[Index]);
//#UC END# *5227080C0080_5227064102D9get_impl*
end;//TddGroupConfigItem.pm_GetSubItem

function TddGroupConfigItem.pm_GetCount: Integer;
//#UC START# *5227088402CF_5227064102D9get_var*
//#UC END# *5227088402CF_5227064102D9get_var*
begin
//#UC START# *5227088402CF_5227064102D9get_impl*
 if (f_SubItems = nil) then
  Result := 0
 else
  Result := f_SubItems.Count;
//#UC END# *5227088402CF_5227064102D9get_impl*
end;//TddGroupConfigItem.pm_GetCount

procedure TddGroupConfigItem.DoOnChange(Sender: TObject);
//#UC START# *52270A5C030E_5227064102D9_var*
//#UC END# *52270A5C030E_5227064102D9_var*
begin
//#UC START# *52270A5C030E_5227064102D9_impl*
 Changed := (Sender as TddBaseConfigItem).Changed;
//#UC END# *52270A5C030E_5227064102D9_impl*
end;//TddGroupConfigItem.DoOnChange

function TddGroupConfigItem.HeaderHeight(aParent: TWinControl): Integer;
//#UC START# *52270A8C03B4_5227064102D9_var*
//#UC END# *52270A8C03B4_5227064102D9_var*
begin
//#UC START# *52270A8C03B4_5227064102D9_impl*
 {$IFNDEF Nemesis}
 Result := GetGroupHeaderHeight(aParent, Caption, ShowCaption);
 {$ELSE}
 Result := GetGroupHeaderHeight(aParent, Caption, True);
 {$ENDIF}
//#UC END# *52270A8C03B4_5227064102D9_impl*
end;//TddGroupConfigItem.HeaderHeight

constructor TddGroupConfigItem.SimpleCreate(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *52270ABC00D6_5227064102D9_var*
//#UC END# *52270ABC00D6_5227064102D9_var*
begin
//#UC START# *52270ABC00D6_5227064102D9_impl*
 Create(aAlias, aCaption, ddEmptyValue, aMasterItem);
//#UC END# *52270ABC00D6_5227064102D9_impl*
end;//TddGroupConfigItem.SimpleCreate

function TddGroupConfigItem.ItemsLabelWidth(aParent: TWinControl;
 var aLeftLabeled: Integer): Integer;
//#UC START# *52270AE801AC_5227064102D9_var*
var
 lIndex, l_Index2 : Integer;
 lItem  : TddVisualConfigItem;
//#UC END# *52270AE801AC_5227064102D9_var*
begin
//#UC START# *52270AE801AC_5227064102D9_impl*
 Result := 0;
 for lIndex := 0 to Pred(f_SubItems.Count) do
 begin
  lItem := TddVisualConfigItem(f_SubItems[lIndex]);
  if lItem is TddGroupConfigItem then
   Result := Max(Result, TddGroupConfigItem(lItem).ItemsLabelWidth(aParent, aLeftLabeled))
  else
   if lItem.Labeled and not lItem.LabelTop then
   begin
    Result := Max(Result, c_ConfigItemLeft + lItem.LabelWidth(aParent));
    Inc(aLeftLabeled);
   end;
 end;
//#UC END# *52270AE801AC_5227064102D9_impl*
end;//TddGroupConfigItem.ItemsLabelWidth

function TddGroupConfigItem.Add(aItem: TddBaseConfigItem): TddBaseConfigItem;
//#UC START# *52270B070394_5227064102D9_var*
//#UC END# *52270B070394_5227064102D9_var*
begin
//#UC START# *52270B070394_5227064102D9_impl*
 aItem.ReadOnly := ReadOnly;
 f_SubItems.Add(aItem);
 aItem.OnChange := DoOnChange;
 if (aItem is TddVisualConfigItem) then
  TddVisualConfigItem(aItem).LabelTop := LabelTop;
 Result := aItem;
//#UC END# *52270B070394_5227064102D9_impl*
end;//TddGroupConfigItem.Add

function TddGroupConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5227064102D9_var*
var
 I: Integer;
 l_Height: Integer;

 function lp_FixCaption(const aCaption: String): String;
 begin
  Result := aCaption;
  if Result <> '' then
  begin
   if Result[1] <> ' ' then
    Insert(' ', Result, 1);
   if Result[Length(Result)] <> ' ' then
    Result := Result + ' ';
  end;
 end;
//#UC END# *521761BB03DE_5227064102D9_var*
begin
//#UC START# *521761BB03DE_5227064102D9_impl*
 if Count > 0 then
 begin
  Result := TvtGroupBox.Create(aParent);
  {$IFNDEF Nemesis}
  if ShowCaption then
   TvtGroupBox(Result).Caption := lp_FixCaption(Caption)
  else
   TvtGroupBox(Result).Caption := '';
  {$ELSE} 
  TvtGroupBox(Result).Caption := lp_FixCaption(Caption);
  {$ENDIF}
  aParent.InsertControl(Result);
  Result.Left := aLeft;
  Result.Top := aTop;
  if aParent is TScrollBox
   then Result.Width := aParent.ClientWidth - c_ConfigItemRight - aLeft - c_ScrollBarWidth
   else Result.Width := aParent.ClientWidth - c_ConfigItemRight - aLeft;
  Result.Height := ControlHeight(aParent);
  aTop := HeaderHeight(aParent);
  if aMaxLeft < aLeft then
   aMaxLeft := aLeft;
  for I := 0 to Pred(Count) do
  begin
   SubItem[I].CreateControl(c_ConfigItemLeft, aMaxLeft-aLeft, aTop, Result as TWinControl);
   Inc(aTop, SubItem[I].FullControlHeight[Result as TWinControl] + c_ConfigItemTop);
  end;// for I
 end
 else
  Result := nil;
//#UC END# *521761BB03DE_5227064102D9_impl*
end;//TddGroupConfigItem.ConstructControl

function TddGroupConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5227064102D9_var*
var
 I: Integer;
//#UC END# *521B053F03C3_5227064102D9_var*
begin
//#UC START# *521B053F03C3_5227064102D9_impl*
 Result := HeaderHeight(aParent) + c_ConfigItemTop;

 for I := 0 to Pred(Count) do
  Inc(Result, SubItem[I].FullControlHeight[aParent] + c_ConfigItemTop);
//#UC END# *521B053F03C3_5227064102D9_impl*
end;//TddGroupConfigItem.ControlHeight

procedure TddGroupConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5227064102D9_var*
var
 I: Integer;
//#UC END# *521B058801FD_5227064102D9_var*
begin
//#UC START# *521B058801FD_5227064102D9_impl*
 for I := 0 to Pred(Count) do
 begin
  SubItem[I].Lock;
  SubItem[I].GetValueFromControl;
  SubItem[I].Unlock;
  if SubItem[I].Changed then
   Changed := True;
 end; // for I
//#UC END# *521B058801FD_5227064102D9_impl*
end;//TddGroupConfigItem.GetValueFromControl

procedure TddGroupConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5227064102D9_var*
var
 I: Integer;
//#UC END# *521B07030052_5227064102D9_var*
begin
//#UC START# *521B07030052_5227064102D9_impl*
 for I := 0 to Pred(Count) do
 begin
  SubItem[I].Lock;
  SubItem[I].SetValueToControl(aDefault);
  SubItem[I].Unlock;
 end;
//#UC END# *521B07030052_5227064102D9_impl*
end;//TddGroupConfigItem.SetValueToControl

procedure TddGroupConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5227064102D9_var*
var
 I: Integer;
 l_Obj: TddVisualConfigItem;
//#UC END# *478CF34E02CE_5227064102D9_var*
begin
//#UC START# *478CF34E02CE_5227064102D9_impl*
 if Source is TddGroupConfigItem then
 begin
  inherited;
  // клонируем элементы в Source.SubItems
  f_SubItems.Clear;
  for I := 0 to TddGroupConfigItem(Source).Count-1 do
    f_SubItems.Add(TddGroupConfigItem(Source).SubItem[I].Clone);
 end
 else
  inherited;
//#UC END# *478CF34E02CE_5227064102D9_impl*
end;//TddGroupConfigItem.Assign

procedure TddGroupConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5227064102D9_var*
//#UC END# *479731C50290_5227064102D9_var*
begin
//#UC START# *479731C50290_5227064102D9_impl*
  FreeAndNil(f_SubItems);
  inherited;
//#UC END# *479731C50290_5227064102D9_impl*
end;//TddGroupConfigItem.Cleanup

function TddGroupConfigItem.pm_GetChanged: Boolean;
//#UC START# *5217205002F2_5227064102D9get_var*
var
 I: Integer;
//#UC END# *5217205002F2_5227064102D9get_var*
begin
//#UC START# *5217205002F2_5227064102D9get_impl*
 Result := inherited pm_GetChanged;
 if not Result then
  for I := 0 to Pred(Count) do
   if SubItem[I].Changed then
   begin
    Result := True;
    break
   end;
//#UC END# *5217205002F2_5227064102D9get_impl*
end;//TddGroupConfigItem.pm_GetChanged

procedure TddGroupConfigItem.pm_SetChanged(aValue: Boolean);
//#UC START# *5217205002F2_5227064102D9set_var*
var
 I: Integer;
//#UC END# *5217205002F2_5227064102D9set_var*
begin
//#UC START# *5217205002F2_5227064102D9set_impl*
 inherited pm_SetChanged(aValue);
 if not aValue then 
  for I := 0 to Pred(Count) do
   SubItem[I].Changed := aValue;
//#UC END# *5217205002F2_5227064102D9set_impl*
end;//TddGroupConfigItem.pm_SetChanged

function TddGroupConfigItem.pm_GetEnabled: Boolean;
//#UC START# *521722C103B5_5227064102D9get_var*
//#UC END# *521722C103B5_5227064102D9get_var*
begin
//#UC START# *521722C103B5_5227064102D9get_impl*
 Result := inherited pm_GetEnabled;
//#UC END# *521722C103B5_5227064102D9get_impl*
end;//TddGroupConfigItem.pm_GetEnabled

procedure TddGroupConfigItem.pm_SetEnabled(aValue: Boolean);
//#UC START# *521722C103B5_5227064102D9set_var*
var
 I: Integer;
//#UC END# *521722C103B5_5227064102D9set_var*
begin
//#UC START# *521722C103B5_5227064102D9set_impl*
 inherited;
 if f_SubItems <> nil then
  for I := 0 to Pred(Count) do
   SubItem[I].Enabled := aValue;
//#UC END# *521722C103B5_5227064102D9set_impl*
end;//TddGroupConfigItem.pm_SetEnabled

function TddGroupConfigItem.MayBeRequired: Boolean;
//#UC START# *521725C301A5_5227064102D9_var*
//#UC END# *521725C301A5_5227064102D9_var*
begin
//#UC START# *521725C301A5_5227064102D9_impl*
 Result := False;
//#UC END# *521725C301A5_5227064102D9_impl*
end;//TddGroupConfigItem.MayBeRequired

procedure TddGroupConfigItem.Reset;
//#UC START# *521726060214_5227064102D9_var*
var
 I: Integer;
//#UC END# *521726060214_5227064102D9_var*
begin
//#UC START# *521726060214_5227064102D9_impl*
 for I := 0 to Pred(Count) do
  SubItem[I].Reset;
//#UC END# *521726060214_5227064102D9_impl*
end;//TddGroupConfigItem.Reset

constructor TddGroupConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5227064102D9_var*
//#UC END# *5217273F000F_5227064102D9_var*
begin
//#UC START# *5217273F000F_5227064102D9_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_SubItems := TObjectList.Create;
 Labeled := False;
 ShowCaption := True;
//#UC END# *5217273F000F_5227064102D9_impl*
end;//TddGroupConfigItem.Create

function TddGroupConfigItem.HasValue(const anAlias: AnsiString;
 out theItem: TddBaseConfigItem): Boolean;
//#UC START# *52172A7700CB_5227064102D9_var*
var
 I: Integer;
//#UC END# *52172A7700CB_5227064102D9_var*
begin
//#UC START# *52172A7700CB_5227064102D9_impl*
 Result := inherited HasValue(anAlias, theItem);
 if not Result then
 begin
  for I := 0 to Pred(Count) do
  begin
   Result := SubItem[I].HasValue(anAlias, theItem);
   if Result then
    break;
  end;
 end;
//#UC END# *52172A7700CB_5227064102D9_impl*
end;//TddGroupConfigItem.HasValue

procedure TddGroupConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5227064102D9_var*
var
 I: Integer;
//#UC END# *52172B72014C_5227064102D9_var*
begin
//#UC START# *52172B72014C_5227064102D9_impl*
 for I := 0 to Pred(Count) do
  SubItem[I].Load(aStorage);
//#UC END# *52172B72014C_5227064102D9_impl*
end;//TddGroupConfigItem.LoadValue

procedure TddGroupConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5227064102D9_var*
var
 I: Integer;
//#UC END# *52172CA801E3_5227064102D9_var*
begin
//#UC START# *52172CA801E3_5227064102D9_impl*
 for I := 0 to Pred(Count) do
  SubItem[I].Save(aStorage);
//#UC END# *52172CA801E3_5227064102D9_impl*
end;//TddGroupConfigItem.SaveValue

function TddGroupConfigItem.pm_GetFullControlHeight(aParent: TWinControl): Integer;
//#UC START# *521760660110_5227064102D9get_var*
//#UC END# *521760660110_5227064102D9get_var*
begin
//#UC START# *521760660110_5227064102D9get_impl*
 Result := ControlHeight(aParent);
//#UC END# *521760660110_5227064102D9get_impl*
end;//TddGroupConfigItem.pm_GetFullControlHeight

function TddGroupConfigItem.IsSame(anItem: TObject): Boolean;
//#UC START# *521B04BC01C6_5227064102D9_var*
var
 l_Idx: Integer;
//#UC END# *521B04BC01C6_5227064102D9_var*
begin
//#UC START# *521B04BC01C6_5227064102D9_impl*
 Result := Inherited IsSame(anItem);
 if not Result then
  for l_Idx := 0 to Count - 1 do
   if SubItem[l_Idx].IsSame(anItem) then
   begin
    Result := True;
    Exit;
   end;
//#UC END# *521B04BC01C6_5227064102D9_impl*
end;//TddGroupConfigItem.IsSame

procedure TddGroupConfigItem.ClearControl;
//#UC START# *521B05280392_5227064102D9_var*
var
 I: Integer;
//#UC END# *521B05280392_5227064102D9_var*
begin
//#UC START# *521B05280392_5227064102D9_impl*
 for I := 0 to Pred(Count) do
  SubItem[I].ClearControl;
 inherited;
//#UC END# *521B05280392_5227064102D9_impl*
end;//TddGroupConfigItem.ClearControl

function TddGroupConfigItem.LabelWidth(aParent: TWinControl): Integer;
//#UC START# *521B05DF00FC_5227064102D9_var*
var
 I: Integer;
 l_MI: TddBaseConfigItem;
//#UC END# *521B05DF00FC_5227064102D9_var*
begin
//#UC START# *521B05DF00FC_5227064102D9_impl*
  Result := 0;
  for I := 0 to Pred(Count) do
   if SubItem[I].Labeled then
    Result := Max(Result, SubItem[I].LabelWidth(aParent));
  l_MI := MasterItem;
  while l_MI <> nil do
  begin
   Inc(Result, c_ConfigItemLeft);
   l_MI := l_MI.MasterItem;
  end; // while l_MI <> nil
  { TODO -oNarry -cРазвитие : По идее нужно создать TvtGroupBox и считать ширину метки именно на нем }
//#UC END# *521B05DF00FC_5227064102D9_impl*
end;//TddGroupConfigItem.LabelWidth

function TddGroupConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_5227064102D9_var*
var
  I: Integer;
//#UC END# *521B061A0387_5227064102D9_var*
begin
//#UC START# *521B061A0387_5227064102D9_impl*
 Result := High(Integer);
 for I := 0 to Pred(Count) do
  Result := Min(Result, SubItem[I].MinWidth(aParent));
//#UC END# *521B061A0387_5227064102D9_impl*
end;//TddGroupConfigItem.MinWidth

procedure TddGroupConfigItem.ReadOnlyChanged;
//#UC START# *552BA9B9039B_5227064102D9_var*
var
 l_IDX: Integer;
//#UC END# *552BA9B9039B_5227064102D9_var*
begin
//#UC START# *552BA9B9039B_5227064102D9_impl*
 for l_IDX := 0 to Count - 1 do
  SubItem[l_IDX].ReadOnly := ReadOnly;
//#UC END# *552BA9B9039B_5227064102D9_impl*
end;//TddGroupConfigItem.ReadOnlyChanged

procedure TddFontConfigItem.FontButtonClick(Sender: TObject);
//#UC START# *522457330322_4B9E682C038E_var*
//#UC END# *522457330322_4B9E682C038E_var*
begin
//#UC START# *522457330322_4B9E682C038E_impl*
 with TFontDialog.Create(nil) do
 try
  Font := ((Control as TvtPanel).Controls[1] as TvtPanel).Font;
  if Execute then
  begin
   ((Control as TvtPanel).Controls[1] as TvtPanel).Font := Font;
   Changed := True;
  end;
 finally
  Free;
 end;
//#UC END# *522457330322_4B9E682C038E_impl*
end;//TddFontConfigItem.FontButtonClick

function TddFontConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_4B9E682C038E_var*
var
 l_Panel: TvtPanel;
 l_Button: TvtButton;
//#UC END# *521761BB03DE_4B9E682C038E_var*
begin
//#UC START# *521761BB03DE_4B9E682C038E_impl*
 Result := TvtPanel.Create(aParent);
 Result.Parent := aParent as TwinControl;
 Result.Left := aLeft;
 Result.Top := aTop;
 Result.Height := ControlHeight(aParent);
 if aParent is TScrollBox
  then Result.Width := aParent.ClientWidth - 2 * c_ConfigItemRight - c_ScrollBarWidth
  else Result.Width := aParent.ClientWidth - 2 * c_ConfigItemRight;
 (Result as TvtPanel).BevelOuter := bvNone;
 (Result as TvtPanel).CCaption := nil;

 l_Button := TvtButton.Create(Result);
 l_Button.Parent := Result as TWinControl;
 l_Button.Top := 2;
 l_Button.Left := Result.ClientWidth - l_Button.Width;
 (l_Button as TvtButton).Caption := str_ddcmSelectButton.AsStr;
 l_Button.Tag := AbsoluteIndex;
 l_Button.Name := Alias + '_Button';
 (l_Button as TvtButton).OnClick := FontButtonClick;

 l_Panel := TvtPanel.Create(Result);
 l_Panel.Parent := Result as TWinControl;
 l_Panel.Name := Alias + '_Example';
 l_Panel.Top := 2;
 l_Panel.Color := clWindow;
 l_Panel.Height := Result.Height-4;
 l_Panel.Width := Result.ClientWidth - l_Button.Width - c_ConfigItemLeft;
 l_Panel.BevelOuter := bvRaised;
 l_Panel.BevelInner := bvLowered;
 l_Panel.CCaption := str_ddcmFontExample.AsCStr;
//#UC END# *521761BB03DE_4B9E682C038E_impl*
end;//TddFontConfigItem.ConstructControl

function TddFontConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_4B9E682C038E_var*
//#UC END# *521B053F03C3_4B9E682C038E_var*
begin
//#UC START# *521B053F03C3_4B9E682C038E_impl*
 with TvtButton.Create(aParent) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
 Inc(Result, 4); // Два пикселя сверху и снизу кнопки
//#UC END# *521B053F03C3_4B9E682C038E_impl*
end;//TddFontConfigItem.ControlHeight

procedure TddFontConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_4B9E682C038E_var*
var
 I: Integer;
 l_C: TControl;
//#UC END# *521B058801FD_4B9E682C038E_var*
begin
//#UC START# *521B058801FD_4B9E682C038E_impl*
for I := 0 to (Control as TvtPanel).ControlCount-1 do
 if (Control as TvtPanel).Controls[I] is TvtPanel then
 begin
  l_C := (Control as TvtPanel).Controls[I];
  Break;
 end;
 TFont(ObjectValue).Assign((l_C as TvtPanel).Font);
 { TODO -oДимка -cРазвитие : Придумать как сравнивать шрифты }
 Changed := True;
//#UC END# *521B058801FD_4B9E682C038E_impl*
end;//TddFontConfigItem.GetValueFromControl

procedure TddFontConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_4B9E682C038E_var*
var
 I: Integer;
 l_C: TControl;
//#UC END# *521B07030052_4B9E682C038E_var*
begin
//#UC START# *521B07030052_4B9E682C038E_impl*
 for I := 0 to (Control as TvtPanel).ControlCount-1 do
  if (Control as TvtPanel).Controls[I] is TvtPanel then
  begin
   l_C := (Control as TvtPanel).Controls[I];
   Break;
  end;
  if aDefault then
   (l_C as TvtPanel).Font := TFont(DefaultValue.AsObject)
  else
   (l_C as TvtPanel).Font := TFont(ObjectValue);
//#UC END# *521B07030052_4B9E682C038E_impl*
end;//TddFontConfigItem.SetValueToControl

constructor TddFontConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_4B9E682C038E_var*
//#UC END# *5217273F000F_4B9E682C038E_var*
begin
//#UC START# *5217273F000F_4B9E682C038E_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 // Создать объект для шрифта
 f_Value.Kind := dd_vkObject;
 f_Value.AsObject := TFont.Create;
//#UC END# *5217273F000F_4B9E682C038E_impl*
end;//TddFontConfigItem.Create

procedure TddFontConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_4B9E682C038E_var*
//#UC END# *52172B72014C_4B9E682C038E_var*
begin
//#UC START# *52172B72014C_4B9E682C038E_impl*
 with TFont(f_Value.AsObject), aStorage do
 begin
  Name := l3Str(ReadString(Alias + '.Name', TFont(DefaultValue.AsObject).Name));
  CharSet := ReadInteger(Alias + '.CharSet', TFont(DefaultValue.AsObject).CharSet);
  Color := ReadInteger(Alias + '.Color', TFont(DefaultValue.AsObject).Color);
  Size := ReadInteger(Alias + '.Size', TFont(DefaultValue.AsObject).Size);
  if ReadBool(Alias + '.Bold', fsBold in TFont(DefaultValue.AsObject).Style) then
   Style := Style + [fsBold];
  if ReadBool(Alias + '.Italic', fsItalic in TFont(DefaultValue.AsObject).Style) then
   Style := Style + [fsItalic];
  if ReadBool(Alias + '.Underline', fsUnderline in TFont(DefaultValue.AsObject).Style) then
   Style := Style + [fsUnderline];
  if ReadBool(Alias + '.Strikeout', fsStrikeout in TFont(DefaultValue.AsObject).Style) then
   Style := Style + [fsStrikeout];
 end;
//#UC END# *52172B72014C_4B9E682C038E_impl*
end;//TddFontConfigItem.LoadValue

procedure TddFontConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_4B9E682C038E_var*
//#UC END# *52172CA801E3_4B9E682C038E_var*
begin
//#UC START# *52172CA801E3_4B9E682C038E_impl*
 with TFont(f_Value.AsObject), aStorage do
 begin
  WriteString(Alias + '.Name', Name);
  WriteInteger(Alias + '.CharSet', CharSet);
  WriteInteger(Alias + '.Color', Color);
  WriteInteger(Alias + '.Size', Size);
  WriteBool(Alias + '.Bold', fsBold in Style);
  WriteBool(Alias + '.Italic', fsItalic in Style);
  WriteBool(Alias + '.Underline', fsUnderline in Style);
  WriteBool(Alias + '.Strikeout', fsStrikeout in Style);
 end;
//#UC END# *52172CA801E3_4B9E682C038E_impl*
end;//TddFontConfigItem.SaveValue

procedure TddFontConfigItem.AfterConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 theControl: TControl;
 theLabel: TvtLabel);
//#UC START# *521760C60369_4B9E682C038E_var*
//#UC END# *521760C60369_4B9E682C038E_var*
begin
//#UC START# *521760C60369_4B9E682C038E_impl*
 inherited AfterConstruct(aLeft, aMaxLeft, aTop, theControl, theLabel);
 (theControl as TvtPanel).CCaption := nil;
//#UC END# *521760C60369_4B9E682C038E_impl*
end;//TddFontConfigItem.AfterConstruct

procedure TddFontConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_4B9E682C038E_var*
var
 I: Integer;
//#UC END# *552BB745031E_4B9E682C038E_var*
begin
//#UC START# *552BB745031E_4B9E682C038E_impl*
for I := 0 to (Control as TvtPanel).ControlCount-1 do
 if (Control as TvtPanel).Controls[I] is TvtButton then
 begin
  (Control as TvtPanel).Controls[I].Enabled := (Control as TvtPanel).Controls[I].Enabled and not ReadOnly;
  Break;
 end;
//#UC END# *552BB745031E_4B9E682C038E_impl*
end;//TddFontConfigItem.AdjustReadOnly

function TddBaseStringsConfigItem.pm_GetControlClass: TControlClass;
//#UC START# *53A299B303CB_53A297C601F0get_var*
//#UC END# *53A299B303CB_53A297C601F0get_var*
begin
//#UC START# *53A299B303CB_53A297C601F0get_impl*
 Assert(False);
//#UC END# *53A299B303CB_53A297C601F0get_impl*
end;//TddBaseStringsConfigItem.pm_GetControlClass

function TddBaseStringsConfigItem.pm_GetSelectedItemIndex: Integer;
//#UC START# *53A29D68029C_53A297C601F0get_var*
//#UC END# *53A29D68029C_53A297C601F0get_var*
begin
//#UC START# *53A29D68029C_53A297C601F0get_impl*
 Assert(False);
//#UC END# *53A29D68029C_53A297C601F0get_impl*
end;//TddBaseStringsConfigItem.pm_GetSelectedItemIndex

procedure TddBaseStringsConfigItem.pm_SetSelectedItemIndex(aValue: Integer);
//#UC START# *53A29D68029C_53A297C601F0set_var*
//#UC END# *53A29D68029C_53A297C601F0set_var*
begin
//#UC START# *53A29D68029C_53A297C601F0set_impl*
 Assert(False);
//#UC END# *53A29D68029C_53A297C601F0set_impl*
end;//TddBaseStringsConfigItem.pm_SetSelectedItemIndex

function TddBaseStringsConfigItem.pm_GetControlStrings: Il3StringsEx;
//#UC START# *53A3BE140327_53A297C601F0get_var*
//#UC END# *53A3BE140327_53A297C601F0get_var*
begin
//#UC START# *53A3BE140327_53A297C601F0get_impl*
 Assert(False);
//#UC END# *53A3BE140327_53A297C601F0get_impl*
end;//TddBaseStringsConfigItem.pm_GetControlStrings

procedure TddBaseStringsConfigItem.DoOnChange(aSender: TObject);
//#UC START# *53A29C9C00DA_53A297C601F0_var*
//#UC END# *53A29C9C00DA_53A297C601F0_var*
begin
//#UC START# *53A29C9C00DA_53A297C601F0_impl*
 Changed := True;
//#UC END# *53A29C9C00DA_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.DoOnChange

procedure TddBaseStringsConfigItem.CheckLoadItems;
//#UC START# *53A29CE60182_53A297C601F0_var*
var
 l_Items : Il3StringsEx;
 l_Index: Integer;
//#UC END# *53A29CE60182_53A297C601F0_var*
begin
//#UC START# *53A29CE60182_53A297C601F0_impl*
 Assert(Control is ControlClass, Control.ClassName);
 if (f_ValueMap <> nil) then
 begin
  if (ControlStrings.Count = 0) then
  begin
   // загрузим значения
   l_Items := Tl3Strings.Make;
   try
    f_ValueMap.GetDisplayNames(l_Items);
    try
     AssignStringsToControl(l_Items);
     SetValueToControl(false);
    except
     on El3ValueMapValueNotFound do
     begin
      Value := DefaultValue;
      SetValueToControl(false);
     end;//on El3ValueMapValueNotFound
    end;//try..except
   finally
    l_Items := nil;
   end;//try..finally
  end//ControlStrings.Count = 0
 end//f_ValueMap <> nil
 else
  // первая загрузка
 if (ControlStrings.Count = 0) and (f_MapValues.Count > 0) then
 begin
  // загрузим значения
  for l_Index := 0 to Pred(f_MapValues.Count) do
   ControlStrings.Add(f_MapValues[l_Index].Caption);
  // установим текущее значение
  SelectedItemIndex := ControlStrings.IndexOf(CalcDisplayName(Value));
 end;//ControlStrings.Count = 0
//#UC END# *53A29CE60182_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.CheckLoadItems

procedure TddBaseStringsConfigItem.SelectValue(aValue: Integer);
//#UC START# *53A29D070172_53A297C601F0_var*
//#UC END# *53A29D070172_53A297C601F0_var*
begin
//#UC START# *53A29D070172_53A297C601F0_impl*
 SelectedItemIndex := aValue;
//#UC END# *53A29D070172_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.SelectValue

procedure TddBaseStringsConfigItem.InitControl(aControl: TControl);
//#UC START# *53A2A16C0369_53A297C601F0_var*
//#UC END# *53A2A16C0369_53A297C601F0_var*
begin
//#UC START# *53A2A16C0369_53A297C601F0_impl*
 // ничего не делаем
//#UC END# *53A2A16C0369_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.InitControl

procedure TddBaseStringsConfigItem.AssignStringsToControl(const aStrings: Il3StringsEx);
//#UC START# *53A3D16C014B_53A297C601F0_var*
//#UC END# *53A3D16C014B_53A297C601F0_var*
begin
//#UC START# *53A3D16C014B_53A297C601F0_impl*
 Assert(False);
//#UC END# *53A3D16C014B_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.AssignStringsToControl

function TddBaseStringsConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_53A297C601F0_var*
//#UC END# *521761BB03DE_53A297C601F0_var*
begin
//#UC START# *521761BB03DE_53A297C601F0_impl*
 Control := ControlClass.Create(aParent);
 with Control do
 begin
  aParent.InsertControl(Control);
  Top := aTop;
  Left := aLeft;
  if aParent is TScrollBox
   then Width := aParent.ClientWidth - aLeft - c_ConfigItemRight - c_ScrollBarWidth
   else Width := aParent.ClientWidth - aLeft - c_ConfigItemRight;
  InitControl(Control);
  CheckLoadItems;
  Height := ControlHeight(aParent);
  if aMaxLeft < aLeft then
   aMaxLeft := aLeft;
 end;
 Result := Control;
//#UC END# *521761BB03DE_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.ConstructControl

function TddBaseStringsConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_53A297C601F0_var*
//#UC END# *521B053F03C3_53A297C601F0_var*
begin
//#UC START# *521B053F03C3_53A297C601F0_impl*
 Assert(False);
//#UC END# *521B053F03C3_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.ControlHeight

procedure TddBaseStringsConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_53A297C601F0_var*
//#UC END# *521B058801FD_53A297C601F0_var*
begin
//#UC START# *521B058801FD_53A297C601F0_impl*
 if (SelectedItemIndex <> -1) then
  Value := CalcValue(ControlStrings[SelectedItemIndex]);
//#UC END# *521B058801FD_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.GetValueFromControl

procedure TddBaseStringsConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_53A297C601F0_var*
var
 l_Index: Integer;
 l_Name: String;
 l_DefaultValueIndex: Integer;
//#UC END# *521B07030052_53A297C601F0_var*
begin
//#UC START# *521B07030052_53A297C601F0_impl*
 if aDefault then
  l_Name := CalcDisplayName(DefaultValue)
 else
  l_Name := CalcDisplayName(Value);
 l_Index := ControlStrings.IndexOf(l_Name);
 if l_Index <> -1 then
  SelectValue(l_Index)
 else
 begin
  l_DefaultValueIndex := ControlStrings.IndexOf(CalcDisplayName(DefaultValue));
  if (not aDefault) and (l_DefaultValueIndex <> -1) then
   SelectValue(l_DefaultValueIndex)
  else
   SelectValue(0);
 end;
//#UC END# *521B07030052_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.SetValueToControl

function TddBaseStringsConfigItem.DisplayNameContainer: Tl3Strings;
//#UC START# *52245D1400E9_53A297C601F0_var*
//#UC END# *52245D1400E9_53A297C601F0_var*
begin
//#UC START# *52245D1400E9_53A297C601F0_impl*
 Assert(False);
//#UC END# *52245D1400E9_53A297C601F0_impl*
end;//TddBaseStringsConfigItem.DisplayNameContainer

function TddCustomConfigNode.pm_GetChildrenCount: Integer;
//#UC START# *521B26D40382_51D547DD026Cget_var*
//#UC END# *521B26D40382_51D547DD026Cget_var*
begin
//#UC START# *521B26D40382_51D547DD026Cget_impl*
 Result := f_Children.Count;
//#UC END# *521B26D40382_51D547DD026Cget_impl*
end;//TddCustomConfigNode.pm_GetChildrenCount

function TddCustomConfigNode.pm_GetChildren(anIndex: Integer): TddCustomConfigNode;
//#UC START# *521B26EF0350_51D547DD026Cget_var*
//#UC END# *521B26EF0350_51D547DD026Cget_var*
begin
//#UC START# *521B26EF0350_51D547DD026Cget_impl*
 if InRange(anIndex, 0, Pred(f_Children.Count)) then
  Result := TddCustomConfigNode(f_Children.Items[anIndex])
 else
  raise EddConfigError.Create('Запрошенного элемента не существует');
//#UC END# *521B26EF0350_51D547DD026Cget_impl*
end;//TddCustomConfigNode.pm_GetChildren

function TddCustomConfigNode.pm_GetIsHorizontalScrollBar: Boolean;
//#UC START# *521B27170183_51D547DD026Cget_var*
//#UC END# *521B27170183_51D547DD026Cget_var*
begin
//#UC START# *521B27170183_51D547DD026Cget_impl*
 Result := f_ScrollBars in [ssHorizontal, ssBoth];
//#UC END# *521B27170183_51D547DD026Cget_impl*
end;//TddCustomConfigNode.pm_GetIsHorizontalScrollBar

function TddCustomConfigNode.pm_GetIsVerticalScrollBar: Boolean;
//#UC START# *521B272D03C7_51D547DD026Cget_var*
//#UC END# *521B272D03C7_51D547DD026Cget_var*
begin
//#UC START# *521B272D03C7_51D547DD026Cget_impl*
 Result := f_ScrollBars in [ssVertical, ssBoth];
//#UC END# *521B272D03C7_51D547DD026Cget_impl*
end;//TddCustomConfigNode.pm_GetIsVerticalScrollBar

procedure TddCustomConfigNode.pm_SetParent(aValue: TddCustomConfigNode);
//#UC START# *521B277C02F3_51D547DD026Cset_var*
//#UC END# *521B277C02F3_51D547DD026Cset_var*
begin
//#UC START# *521B277C02F3_51D547DD026Cset_impl*
 if f_Parent <> aValue then
 begin
  if aValue <> nil then
   f_ParentAlias := aValue.Alias;
  f_Parent := aValue;
 end;
//#UC END# *521B277C02F3_51D547DD026Cset_impl*
end;//TddCustomConfigNode.pm_SetParent

procedure TddCustomConfigNode.ItemChanged(Sender: TObject);
//#UC START# *521B21AC0008_51D547DD026C_var*
//#UC END# *521B21AC0008_51D547DD026C_var*
begin
//#UC START# *521B21AC0008_51D547DD026C_impl*
 Changed := True;
//#UC END# *521B21AC0008_51D547DD026C_impl*
end;//TddCustomConfigNode.ItemChanged

constructor TddCustomConfigNode.Create(const aAlias: AnsiString;
 const aCaption: AnsiString);
//#UC START# *521B21EE02E6_51D547DD026C_var*
//#UC END# *521B21EE02E6_51D547DD026C_var*
begin
//#UC START# *521B21EE02E6_51D547DD026C_impl*
 inherited Create(aAlias, aCaption, ddEmptyObjectValue);
 f_Children := Tl3ProtoPersistentRefList.Create;
 f_Alias := aAlias;
 f_Caption := aCaption;
 f_ScrollBars := ssNone;
//#UC END# *521B21EE02E6_51D547DD026C_impl*
end;//TddCustomConfigNode.Create

function TddCustomConfigNode.AddNode(const aAlias: AnsiString): TddCustomConfigNode;
//#UC START# *521B2293010A_51D547DD026C_var*
//#UC END# *521B2293010A_51D547DD026C_var*
begin
//#UC START# *521B2293010A_51D547DD026C_impl*
 Result := AddNode(TddAppConfigNode.Create(aAlias, ''));
//#UC END# *521B2293010A_51D547DD026C_impl*
end;//TddCustomConfigNode.AddNode

function TddCustomConfigNode.AddNode(const aAlias: AnsiString;
 const aCaption: AnsiString): TddCustomConfigNode;
//#UC START# *521B22D3023D_51D547DD026C_var*
//#UC END# *521B22D3023D_51D547DD026C_var*
begin
//#UC START# *521B22D3023D_51D547DD026C_impl*
 Result := AddNode(TddAppConfigNode.Create(aAlias, aCaption));
//#UC END# *521B22D3023D_51D547DD026C_impl*
end;//TddCustomConfigNode.AddNode

function TddCustomConfigNode.AddNode(aNode: TddCustomConfigNode): TddCustomConfigNode;
//#UC START# *521B22E003E5_51D547DD026C_var*
//#UC END# *521B22E003E5_51D547DD026C_var*
begin
//#UC START# *521B22E003E5_51D547DD026C_impl*
 if aNode <> nil then
 begin
  aNode.Parent := Self;
  aNode.ReadOnly := ReadOnly;
  f_Children.Add(aNode);
  FreeAndNil(aNode);
  Result := TddCustomConfigNode(f_Children.Last);
 end
 else
  Result := nil;
//#UC END# *521B22E003E5_51D547DD026C_impl*
end;//TddCustomConfigNode.AddNode

function TddCustomConfigNode.IsRequired(out aMessage: AnsiString): Boolean;
//#UC START# *521B251D0001_51D547DD026C_var*
//#UC END# *521B251D0001_51D547DD026C_var*
begin
//#UC START# *521B251D0001_51D547DD026C_impl*
 Result := False;
 aMessage := '';
//#UC END# *521B251D0001_51D547DD026C_impl*
end;//TddCustomConfigNode.IsRequired

procedure TddCustomConfigNode.PostEdit;
//#UC START# *521B25470196_51D547DD026C_var*
//#UC END# *521B25470196_51D547DD026C_var*
begin
//#UC START# *521B25470196_51D547DD026C_impl*
 // Вызывается по окончании редактирования для возможных дополнительных действий
//#UC END# *521B25470196_51D547DD026C_impl*
end;//TddCustomConfigNode.PostEdit

procedure TddCustomConfigNode.DoFrameSize(aParent: TWinControl;
 out aHeight: Integer;
 out aWidth: Integer);
//#UC START# *521B28930009_51D547DD026C_var*
//#UC END# *521B28930009_51D547DD026C_var*
begin
//#UC START# *521B28930009_51D547DD026C_impl*
 aHeight := 0;
 aWidth := 0;
//#UC END# *521B28930009_51D547DD026C_impl*
end;//TddCustomConfigNode.DoFrameSize

procedure TddCustomConfigNode.DoResetToDefault;
//#UC START# *521B293B0012_51D547DD026C_var*
//#UC END# *521B293B0012_51D547DD026C_var*
begin
//#UC START# *521B293B0012_51D547DD026C_impl*
 { TODO -oДмитрий Дудко -cРазвитие : Сброс всех значений в значение по умолчанию }
//#UC END# *521B293B0012_51D547DD026C_impl*
end;//TddCustomConfigNode.DoResetToDefault

procedure TddCustomConfigNode.ClearControls;
//#UC START# *52162011011D_51D547DD026C_var*
//#UC END# *52162011011D_51D547DD026C_var*
begin
//#UC START# *52162011011D_51D547DD026C_impl*
 DoClearControls;
//#UC END# *52162011011D_51D547DD026C_impl*
end;//TddCustomConfigNode.ClearControls

function TddCustomConfigNode.CreateFrame(aOwner: TComponent;
 aTag: Integer): TCustomFrame;
//#UC START# *52162023035F_51D547DD026C_var*
//#UC END# *52162023035F_51D547DD026C_var*
begin
//#UC START# *52162023035F_51D547DD026C_impl*
 Result := DoCreateFrame(aOwner, aTag);
//#UC END# *52162023035F_51D547DD026C_impl*
end;//TddCustomConfigNode.CreateFrame

procedure TddCustomConfigNode.FrameSize(aParent: TWinControl;
 out aHeight: Integer;
 out aWidth: Integer);
//#UC START# *5216204C0197_51D547DD026C_var*
//#UC END# *5216204C0197_51D547DD026C_var*
begin
//#UC START# *5216204C0197_51D547DD026C_impl*
 DoFrameSize(aParent, aHeight, aWidth);
//#UC END# *5216204C0197_51D547DD026C_impl*
end;//TddCustomConfigNode.FrameSize

procedure TddCustomConfigNode.GetControlValues;
//#UC START# *521620A90269_51D547DD026C_var*
//#UC END# *521620A90269_51D547DD026C_var*
begin
//#UC START# *521620A90269_51D547DD026C_impl*
 DoGetControlValues;
//#UC END# *521620A90269_51D547DD026C_impl*
end;//TddCustomConfigNode.GetControlValues

function TddCustomConfigNode.IsItem(aItem: TObject): Boolean;
//#UC START# *521620B90082_51D547DD026C_var*
//#UC END# *521620B90082_51D547DD026C_var*
begin
//#UC START# *521620B90082_51D547DD026C_impl*
 Result := DoIsItem(aItem);
//#UC END# *521620B90082_51D547DD026C_impl*
end;//TddCustomConfigNode.IsItem

procedure TddCustomConfigNode.LoadData(const aStorage: IddConfigStorage);
//#UC START# *521620D000F7_51D547DD026C_var*
//#UC END# *521620D000F7_51D547DD026C_var*
begin
//#UC START# *521620D000F7_51D547DD026C_impl*
 DoLoad(aStorage);
//#UC END# *521620D000F7_51D547DD026C_impl*
end;//TddCustomConfigNode.LoadData

procedure TddCustomConfigNode.ResetToDefault;
//#UC START# *5216210503CE_51D547DD026C_var*
//#UC END# *5216210503CE_51D547DD026C_var*
begin
//#UC START# *5216210503CE_51D547DD026C_impl*
 DoResetToDefault;
//#UC END# *5216210503CE_51D547DD026C_impl*
end;//TddCustomConfigNode.ResetToDefault

procedure TddCustomConfigNode.SaveData(const aStorage: IddConfigStorage);
//#UC START# *5216211600A8_51D547DD026C_var*
//#UC END# *5216211600A8_51D547DD026C_var*
begin
//#UC START# *5216211600A8_51D547DD026C_impl*
 DoSave(aStorage);
//#UC END# *5216211600A8_51D547DD026C_impl*
end;//TddCustomConfigNode.SaveData

procedure TddCustomConfigNode.SetControlValues(aDefault: Boolean);
//#UC START# *521621460326_51D547DD026C_var*
//#UC END# *521621460326_51D547DD026C_var*
begin
//#UC START# *521621460326_51D547DD026C_impl*
 DoSetControlValues(aDefault);
//#UC END# *521621460326_51D547DD026C_impl*
end;//TddCustomConfigNode.SetControlValues

procedure TddCustomConfigNode.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_51D547DD026C_var*
var
  l_CN: TddCustomConfigNode absolute Source;
  l_Node, l_N: TddCustomConfigNode;
  I: Integer;
//#UC END# *478CF34E02CE_51D547DD026C_var*
begin
//#UC START# *478CF34E02CE_51D547DD026C_impl*
 if Source is TddCustomConfigNode then
 begin
  l_Node := Source as TddCustomConfigNode;
  Alias := l_CN.Alias;
  Caption := l_CN.Caption;
  Changed := l_CN.Changed;
  f_Children.Clear;
  for I := 0 to Pred(l_Node.ChildrenCount) do
  begin
   l_N := l_CN.Children[I].Clone;
   try
    f_Children.Add(l_N);
   finally
    FreeAndNil(l_N);
   end;
  end;
 end
 else
  inherited;
//#UC END# *478CF34E02CE_51D547DD026C_impl*
end;//TddCustomConfigNode.Assign

procedure TddCustomConfigNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51D547DD026C_var*
//#UC END# *479731C50290_51D547DD026C_var*
begin
//#UC START# *479731C50290_51D547DD026C_impl*
 FreeAndNil(f_Children);
 inherited;
//#UC END# *479731C50290_51D547DD026C_impl*
end;//TddCustomConfigNode.Cleanup

function TddCustomConfigNode.pm_GetChanged: Boolean;
//#UC START# *5217205002F2_51D547DD026Cget_var*
var
 I: Integer;
//#UC END# *5217205002F2_51D547DD026Cget_var*
begin
//#UC START# *5217205002F2_51D547DD026Cget_impl*
 Result := inherited pm_GetChanged;
 if not Result then
  for I := 0 to Pred(ChildrenCount) do
   if Children[I].Changed then
   begin
    Result := True;
    Break;
   end;
//#UC END# *5217205002F2_51D547DD026Cget_impl*
end;//TddCustomConfigNode.pm_GetChanged

procedure TddCustomConfigNode.pm_SetChanged(aValue: Boolean);
//#UC START# *5217205002F2_51D547DD026Cset_var*
var
 I: Integer;
//#UC END# *5217205002F2_51D547DD026Cset_var*
begin
//#UC START# *5217205002F2_51D547DD026Cset_impl*
 if aValue <> f_Changed then
 begin
  f_Changed := aValue;
  for I := 0 to Pred(ChildrenCount) do
   Children[I].Changed := aValue;
  if f_Changed and Assigned(f_OnChange) then
   f_OnChange(Self);
 end; // Value <> FChanged
//#UC END# *5217205002F2_51D547DD026Cset_impl*
end;//TddCustomConfigNode.pm_SetChanged

function TddCustomConfigNode.pm_GetValue: TddConfigValue;
//#UC START# *521725130281_51D547DD026Cget_var*
//#UC END# *521725130281_51D547DD026Cget_var*
begin
//#UC START# *521725130281_51D547DD026Cget_impl*
 Result := ddEmptyObjectValue;
//#UC END# *521725130281_51D547DD026Cget_impl*
end;//TddCustomConfigNode.pm_GetValue

procedure TddCustomConfigNode.pm_SetValue(const aValue: TddConfigValue);
//#UC START# *521725130281_51D547DD026Cset_var*
//#UC END# *521725130281_51D547DD026Cset_var*
begin
//#UC START# *521725130281_51D547DD026Cset_impl*
 inherited pm_SetValue(aValue);
//#UC END# *521725130281_51D547DD026Cset_impl*
end;//TddCustomConfigNode.pm_SetValue

function TddCustomConfigNode.Clone: Pointer;
//#UC START# *5301EC7500FF_51D547DD026C_var*
//#UC END# *5301EC7500FF_51D547DD026C_var*
begin
//#UC START# *5301EC7500FF_51D547DD026C_impl*
 Result := RddBaseConfigNode(ClassType).Create(Alias, Caption);
 TddCustomConfigNode(Result).Assign(Self);
//#UC END# *5301EC7500FF_51D547DD026C_impl*
end;//TddCustomConfigNode.Clone

procedure TddCustomConfigNode.ReadOnlyChanged;
//#UC START# *552BA9B9039B_51D547DD026C_var*
var
 l_IDX: Integer;
//#UC END# *552BA9B9039B_51D547DD026C_var*
begin
//#UC START# *552BA9B9039B_51D547DD026C_impl*
 for l_IDX := 0 to f_Children.Count - 1 do
 begin
  Assert(f_Children[l_IDX] is TddCustomConfigNode);
  TddCustomConfigNode(f_Children[l_IDX]).ReadOnly := ReadOnly;
 end;
//#UC END# *552BA9B9039B_51D547DD026C_impl*
end;//TddCustomConfigNode.ReadOnlyChanged

procedure TddCustomConfigNode.ClearFields;
begin
 Alias := '';
 Caption := '';
 f_ParentAlias := '';
 inherited;
end;//TddCustomConfigNode.ClearFields

procedure TddBooleanConfigItem.OnClick(Sender: TObject);
//#UC START# *5225E578019A_5225E4F80224_var*
//#UC END# *5225E578019A_5225E4F80224_var*
begin
//#UC START# *5225E578019A_5225E4F80224_impl*
 Assert(Sender is TvtCheckBox, Sender.ClassName);
 ChangeSlaveStatus((Sender as TvtCheckBox).Checked);
 if inherited pm_GetBooleanValue <> (Sender as TvtCheckBox).Checked then
  Changed := True;
//#UC END# *5225E578019A_5225E4F80224_impl*
end;//TddBooleanConfigItem.OnClick

function TddBooleanConfigItem.pm_GetBooleanValue: Boolean;
//#UC START# *52161FC80131_5225E4F80224get_var*
//#UC END# *52161FC80131_5225E4F80224get_var*
begin
//#UC START# *52161FC80131_5225E4F80224get_impl*
 if Control <> nil then
 begin
  Assert(Control is TvtCheckBox, Control.ClassName);
  Result := (Control as TvtCheckBox).Checked
 end
 else
  Result := inherited pm_GetBooleanValue;
//#UC END# *52161FC80131_5225E4F80224get_impl*
end;//TddBooleanConfigItem.pm_GetBooleanValue

function TddBooleanConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5225E4F80224_var*
//#UC END# *521761BB03DE_5225E4F80224_var*
begin
//#UC START# *521761BB03DE_5225E4F80224_impl*
 Result := TvtCheckBox.Create(aParent);
 TvtCheckBox(Result).Caption := Caption;
 Result.Parent := aParent;
 Result.Left := aLeft;
 Result.Top := aTop;
 Result.Width := MinWidth(aParent); //aParent.ClientWidth - aLeft -2*c_ConfigItemLeft;
 if Hint <> '' then
 begin
  TvtCheckBox(Result).Hint := Hint;
  TvtCheckBox(Result).ShowHint := True;
 end;
 TvtCheckBox(Result).OnClick := OnClick;
//#UC END# *521761BB03DE_5225E4F80224_impl*
end;//TddBooleanConfigItem.ConstructControl

function TddBooleanConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5225E4F80224_var*
//#UC END# *521B053F03C3_5225E4F80224_var*
begin
//#UC START# *521B053F03C3_5225E4F80224_impl*
 with TvtCheckBox.Create(nil) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
//#UC END# *521B053F03C3_5225E4F80224_impl*
end;//TddBooleanConfigItem.ControlHeight

procedure TddBooleanConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5225E4F80224_var*
//#UC END# *521B058801FD_5225E4F80224_var*
begin
//#UC START# *521B058801FD_5225E4F80224_impl*
 Assert(Control is TvtCheckBox, Control.ClassName);
 BooleanValue := (Control as TvtCheckBox).Checked;
//#UC END# *521B058801FD_5225E4F80224_impl*
end;//TddBooleanConfigItem.GetValueFromControl

procedure TddBooleanConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5225E4F80224_var*
//#UC END# *521B07030052_5225E4F80224_var*
begin
//#UC START# *521B07030052_5225E4F80224_impl*
 Assert(Control is TvtCheckBox, Control.ClassName);
 if aDefault then
  (Control as TvtCheckBox).Checked := DefaultValue.AsBoolean
 else
  (Control as TvtCheckBox).Checked := Value.AsBoolean;
 { TODO -oNarry -cРазвитие : нужно реагировать на доступность повелителя }
 ChangeSlaveStatus(BooleanValue);
//#UC END# *521B07030052_5225E4F80224_impl*
end;//TddBooleanConfigItem.SetValueToControl

function TddBooleanConfigItem.pm_GetRequired: Boolean;
//#UC START# *521724C0003E_5225E4F80224get_var*
//#UC END# *521724C0003E_5225E4F80224get_var*
begin
//#UC START# *521724C0003E_5225E4F80224get_impl*
 Result := False;
//#UC END# *521724C0003E_5225E4F80224get_impl*
end;//TddBooleanConfigItem.pm_GetRequired

procedure TddBooleanConfigItem.pm_SetRequired(aValue: Boolean);
//#UC START# *521724C0003E_5225E4F80224set_var*
//#UC END# *521724C0003E_5225E4F80224set_var*
begin
//#UC START# *521724C0003E_5225E4F80224set_impl*
 raise EddConfigError.CreateFmt('Значение элемента %s не может быть обязательно к заполнению', [ClassName]);
//#UC END# *521724C0003E_5225E4F80224set_impl*
end;//TddBooleanConfigItem.pm_SetRequired

function TddBooleanConfigItem.MayBeRequired: Boolean;
//#UC START# *521725C301A5_5225E4F80224_var*
//#UC END# *521725C301A5_5225E4F80224_var*
begin
//#UC START# *521725C301A5_5225E4F80224_impl*
 Result := False;
//#UC END# *521725C301A5_5225E4F80224_impl*
end;//TddBooleanConfigItem.MayBeRequired

constructor TddBooleanConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5225E4F80224_var*
//#UC END# *5217273F000F_5225E4F80224_var*
begin
//#UC START# *5217273F000F_5225E4F80224_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_Value.Kind := dd_vkBoolean;
 Labeled := False;
//#UC END# *5217273F000F_5225E4F80224_impl*
end;//TddBooleanConfigItem.Create

procedure TddBooleanConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5225E4F80224_var*
//#UC END# *52172B72014C_5225E4F80224_var*
begin
//#UC START# *52172B72014C_5225E4F80224_impl*
 BooleanValue := aStorage.ReadBool(Alias, DefaultValue.AsBoolean);
//#UC END# *52172B72014C_5225E4F80224_impl*
end;//TddBooleanConfigItem.LoadValue

procedure TddBooleanConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5225E4F80224_var*
//#UC END# *52172CA801E3_5225E4F80224_var*
begin
//#UC START# *52172CA801E3_5225E4F80224_impl*
 aStorage.WriteBool(Alias, BooleanValue);
//#UC END# *52172CA801E3_5225E4F80224_impl*
end;//TddBooleanConfigItem.SaveValue

function TddBooleanConfigItem.pm_GetFullControlHeight(aParent: TWinControl): Integer;
//#UC START# *521760660110_5225E4F80224get_var*
//#UC END# *521760660110_5225E4F80224get_var*
begin
//#UC START# *521760660110_5225E4F80224get_impl*
 Result := ControlHeight(aParent);
//#UC END# *521760660110_5225E4F80224get_impl*
end;//TddBooleanConfigItem.pm_GetFullControlHeight

function TddBooleanConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_5225E4F80224_var*
var
 l_Form: TForm;
//#UC END# *521B061A0387_5225E4F80224_var*
begin
//#UC START# *521B061A0387_5225E4F80224_impl*
 if Caption = '' then
  Result := 40
 else
  Result := 40 + GetCanvas(aParent).TextWidth(Caption) + c_ConfigItemLeft;
//#UC END# *521B061A0387_5225E4F80224_impl*
end;//TddBooleanConfigItem.MinWidth

procedure TddBooleanConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5225E4F80224_var*
//#UC END# *552BB745031E_5225E4F80224_var*
begin
//#UC START# *552BB745031E_5225E4F80224_impl*
 if aControl is TvtCheckBox then
  TvtCheckBox(aControl).Enabled := TvtCheckBox(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_5225E4F80224_impl*
end;//TddBooleanConfigItem.AdjustReadOnly

procedure TddButtonConfigItem.pm_SetOnClick(aValue: TNotifyEvent);
//#UC START# *5225EB4F012A_5225EB120246set_var*
//#UC END# *5225EB4F012A_5225EB120246set_var*
begin
//#UC START# *5225EB4F012A_5225EB120246set_impl*
 f_OnClick := aValue;
 if Assigned(Control) then
 begin
  Assert(Control Is TvtButton, Control.ClassName);
  TvtButton(Control).OnClick := aValue;
 end;
 Enabled := Assigned(f_OnClick);
//#UC END# *5225EB4F012A_5225EB120246set_impl*
end;//TddButtonConfigItem.pm_SetOnClick

procedure TddButtonConfigItem.ButtonSize(aParent: TWinControl;
 out aSize: TSize);
//#UC START# *5225EC1300A1_5225EB120246_var*
var
 l_Button: TvtButton;
//#UC END# *5225EC1300A1_5225EB120246_var*
begin
//#UC START# *5225EC1300A1_5225EB120246_impl*
 l_Button := TvtButton.Create(aParent);
 try
  l_Button.Parent := aParent;
  l_Button.Width := GetCanvas(aParent).TextWidth(Caption) + 2*c_ConfigItemLeft;
  with aSize, l_Button do
  begin
   cx := Width;
   cy := Height;
  end;
 finally
  FreeAndNil(l_Button);
 end;
//#UC END# *5225EC1300A1_5225EB120246_impl*
end;//TddButtonConfigItem.ButtonSize

constructor TddButtonConfigItem.Create(const anAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aClick: TNotifyEvent;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5225EF6D0040_5225EB120246_var*
//#UC END# *5225EF6D0040_5225EB120246_var*
begin
//#UC START# *5225EF6D0040_5225EB120246_impl*
 inherited Create(anAlias, aCaption, aDefaultValue, aMasterItem);
 f_OnClick := aClick;
 f_ButtonPlace := dd_bpAsDefine;
 Labeled := False;
 Enabled := Assigned(f_OnClick);
//#UC END# *5225EF6D0040_5225EB120246_impl*
end;//TddButtonConfigItem.Create

function TddButtonConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5225EB120246_var*
//#UC END# *521761BB03DE_5225EB120246_var*
begin
//#UC START# *521761BB03DE_5225EB120246_impl*
 Result := TvtButton.Create(aParent);
 Result.Parent := aParent;
 Result.Left := aLeft;
 Result.Top := aTop;
 Result.Width := GetCanvas(aParent).TextWidth(Caption) + 2 * c_ConfigItemLeft;
 with Result as TvtButton do
 begin
  Caption := Self.Caption;
  OnClick := f_OnClick;
 end;
//#UC END# *521761BB03DE_5225EB120246_impl*
end;//TddButtonConfigItem.ConstructControl

function TddButtonConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5225EB120246_var*
var
 l_Size : TSize;
//#UC END# *521B053F03C3_5225EB120246_var*
begin
//#UC START# *521B053F03C3_5225EB120246_impl*
 ButtonSize(aParent, l_Size);
 Result := l_Size.cy;
//#UC END# *521B053F03C3_5225EB120246_impl*
end;//TddButtonConfigItem.ControlHeight

procedure TddButtonConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5225EB120246_var*
//#UC END# *521B058801FD_5225EB120246_var*
begin
//#UC START# *521B058801FD_5225EB120246_impl*
//#UC END# *521B058801FD_5225EB120246_impl*
end;//TddButtonConfigItem.GetValueFromControl

procedure TddButtonConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5225EB120246_var*
//#UC END# *521B07030052_5225EB120246_var*
begin
//#UC START# *521B07030052_5225EB120246_impl*
//#UC END# *521B07030052_5225EB120246_impl*
end;//TddButtonConfigItem.SetValueToControl

procedure TddButtonConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5225EB120246_var*
//#UC END# *478CF34E02CE_5225EB120246_var*
begin
//#UC START# *478CF34E02CE_5225EB120246_impl*
 inherited;
 if Source is TddButtonConfigItem then
 begin
  ButtonPlace := TddButtonConfigItem(Source).ButtonPlace;
  OnClick := TddButtonConfigItem(Source).OnClick;
 end;
//#UC END# *478CF34E02CE_5225EB120246_impl*
end;//TddButtonConfigItem.Assign

function TddButtonConfigItem.pm_GetRequired: Boolean;
//#UC START# *521724C0003E_5225EB120246get_var*
//#UC END# *521724C0003E_5225EB120246get_var*
begin
//#UC START# *521724C0003E_5225EB120246get_impl*
 Result := False;
//#UC END# *521724C0003E_5225EB120246get_impl*
end;//TddButtonConfigItem.pm_GetRequired

procedure TddButtonConfigItem.pm_SetRequired(aValue: Boolean);
//#UC START# *521724C0003E_5225EB120246set_var*
//#UC END# *521724C0003E_5225EB120246set_var*
begin
//#UC START# *521724C0003E_5225EB120246set_impl*
 inherited;
//#UC END# *521724C0003E_5225EB120246set_impl*
end;//TddButtonConfigItem.pm_SetRequired

function TddButtonConfigItem.MayBeRequired: Boolean;
//#UC START# *521725C301A5_5225EB120246_var*
//#UC END# *521725C301A5_5225EB120246_var*
begin
//#UC START# *521725C301A5_5225EB120246_impl*
 Result := False;
//#UC END# *521725C301A5_5225EB120246_impl*
end;//TddButtonConfigItem.MayBeRequired

procedure TddButtonConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5225EB120246_var*
//#UC END# *52172B72014C_5225EB120246_var*
begin
//#UC START# *52172B72014C_5225EB120246_impl*
//#UC END# *52172B72014C_5225EB120246_impl*
end;//TddButtonConfigItem.LoadValue

procedure TddButtonConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5225EB120246_var*
//#UC END# *52172CA801E3_5225EB120246_var*
begin
//#UC START# *52172CA801E3_5225EB120246_impl*
//#UC END# *52172CA801E3_5225EB120246_impl*
end;//TddButtonConfigItem.SaveValue

function TddButtonConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_5225EB120246_var*
var
 l_Size : TSize;
//#UC END# *521B061A0387_5225EB120246_var*
begin
//#UC START# *521B061A0387_5225EB120246_impl*
 ButtonSize(aParent, l_Size);
 Result := l_Size.cx;
//#UC END# *521B061A0387_5225EB120246_impl*
end;//TddButtonConfigItem.MinWidth

procedure TddButtonConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5225EB120246_var*
//#UC END# *552BB745031E_5225EB120246_var*
begin
//#UC START# *552BB745031E_5225EB120246_impl*
 if aControl is TvtButton then
  TvtButton(aControl).Enabled := TvtButton(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_5225EB120246_impl*
end;//TddButtonConfigItem.AdjustReadOnly

function TddColorConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_52260D070311_var*
//#UC END# *521761BB03DE_52260D070311_var*
begin
//#UC START# *521761BB03DE_52260D070311_impl*
 {$IFDEF RxLibrary}
 Result := TColorBox.Create(aParent);
 (Result as TColorBox).OnChange := DoOnChange;
 {$ELSE}
 { TODO -oДудко Дмитрий -cРазвитие : Создать связку из двух контролов - ComboBox и rкнопки }
 Result := nil;
 raise EddConfigError.Create('К сожалению, ColorConfigItem не реализован');
 {$ENDIF}
 Result.Parent := aParent as TWinControl;
 Result.Top := aTop;
 Result.Left := aLeft;
 if aParent is TScrollBox
  then Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight - c_ScrollBarWidth
  else Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight;
 {$IFDEF RxLibrary}
 (Result as TColorBox).Style := [cbStandardColors,cbExtendedColors,cbIncludeDefault];
 {$ENDIF}
//#UC END# *521761BB03DE_52260D070311_impl*
end;//TddColorConfigItem.ConstructControl

procedure TddColorConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_52260D070311_var*
//#UC END# *521B058801FD_52260D070311_var*
begin
//#UC START# *521B058801FD_52260D070311_impl*
 {$IFDEF RxLibrary}
 IntegerValue := (Control as TColorBox).Selected;
 {$Else}
 Assert(false);
 {$ENDIF}
//#UC END# *521B058801FD_52260D070311_impl*
end;//TddColorConfigItem.GetValueFromControl

procedure TddColorConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_52260D070311_var*
//#UC END# *521B07030052_52260D070311_var*
begin
//#UC START# *521B07030052_52260D070311_impl*
 {$IFDEF RxLibrary}
 if aDefault then
  (Control as TColorBox).Selected := DefaultValue.AsInteger
 else
  (Control as TColorBox).Selected := IntegerValue;
 {$Else}
 Assert(false);
 {$ENDIF}
//#UC END# *521B07030052_52260D070311_impl*
end;//TddColorConfigItem.SetValueToControl

procedure TddColorConfigItem.DoOnChange(Sender: TObject);
//#UC START# *5220C06103B2_52260D070311_var*
//#UC END# *5220C06103B2_52260D070311_var*
begin
//#UC START# *5220C06103B2_52260D070311_impl*
 Changed := True;
//#UC END# *5220C06103B2_52260D070311_impl*
end;//TddColorConfigItem.DoOnChange

procedure TddColorConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_52260D070311_var*
//#UC END# *552BB745031E_52260D070311_var*
begin
//#UC START# *552BB745031E_52260D070311_impl*
 if (aControl is TColorBox) then
  TColorBox(aControl).Enabled := TColorBox(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_52260D070311_impl*
end;//TddColorConfigItem.AdjustReadOnly

procedure TddCheckListConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5226188001A3_var*
//#UC END# *478CF34E02CE_5226188001A3_var*
begin
//#UC START# *478CF34E02CE_5226188001A3_impl*
 inherited;
 if Source is TddCheckListConfigItem then
  Self.Columns := TddCheckListConfigItem(Source).Columns;
//#UC END# *478CF34E02CE_5226188001A3_impl*
end;//TddCheckListConfigItem.Assign

constructor TddCheckListConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5226188001A3_var*
//#UC END# *5217273F000F_5226188001A3_var*
begin
//#UC START# *5217273F000F_5226188001A3_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 Labeled := True;
 Columns := 1;
//#UC END# *5217273F000F_5226188001A3_impl*
end;//TddCheckListConfigItem.Create

function TddCheckListConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5226188001A3_var*
//#UC END# *521761BB03DE_5226188001A3_var*
begin
//#UC START# *521761BB03DE_5226188001A3_impl*
 Result := TCheckListBox.Create(aParent);
 Result.Parent := aParent as TWinControl;
 Result.Left := aLeft;
 Result.Top := aTop;
 if aParent is TScrollBox
  then Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight - c_ScrollBarWidth
  else Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight;
 Result.Height := ControlHeight(aParent);
 TCheckListBox(Result).Items := f_Items;
 TCheckListBox(Result).Columns := Columns;
 TCheckListBox(Result).OnClick := DoOnChange;
//#UC END# *521761BB03DE_5226188001A3_impl*
end;//TddCheckListConfigItem.ConstructControl

function TddCheckListConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5226188001A3_var*
//#UC END# *521B053F03C3_5226188001A3_var*
begin
//#UC START# *521B053F03C3_5226188001A3_impl*
 Result := GetCanvas(aParent).TextHeight('A');
 Inc(Result, (f_Items.Count div Columns + IfThen(f_Items.Count mod Columns <> 0, 1, 0))*Result);
//#UC END# *521B053F03C3_5226188001A3_impl*
end;//TddCheckListConfigItem.ControlHeight

procedure TddCheckListConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5226188001A3_var*
var
 l_Value, I: Integer;
//#UC END# *521B058801FD_5226188001A3_var*
begin
//#UC START# *521B058801FD_5226188001A3_impl*
 l_Value := 0;
 for I := 0 to Pred(TCheckListBox(Control).Items.Count) do
  if TCheckListBox(Control).Checked[I] then
   l3SetBit(l_Value, I);
  IntegerValue := l_Value;
//#UC END# *521B058801FD_5226188001A3_impl*
end;//TddCheckListConfigItem.GetValueFromControl

procedure TddCheckListConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5226188001A3_var*
var
 I, l_Value: Integer;
//#UC END# *521B07030052_5226188001A3_var*
begin
//#UC START# *521B07030052_5226188001A3_impl*
 if aDefault then
  l_Value := DefaultValue.AsInteger
 else
  l_Value := IntegerValue;
 for I := 0 to Pred(TCheckListBox(Control).Count) do
  TCheckListBox(Control).Checked[I] := l3TestBit(l_Value, I);
//#UC END# *521B07030052_5226188001A3_impl*
end;//TddCheckListConfigItem.SetValueToControl

procedure TddCheckListConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5226188001A3_var*
//#UC END# *552BB745031E_5226188001A3_var*
begin
//#UC START# *552BB745031E_5226188001A3_impl*
 if aControl is TCheckListBox then
  TCheckListBox(aControl).Enabled := TCheckListBox(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_5226188001A3_impl*
end;//TddCheckListConfigItem.AdjustReadOnly

function TddDividerConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_522623110098_var*
var
 l_Bevel: TBevel;
//#UC END# *521761BB03DE_522623110098_var*
begin
//#UC START# *521761BB03DE_522623110098_impl*
 Result := TvtLabel.Create(aParent);
 Result.Parent := aParent;
 Result.Left := aLeft;
 TvtLabel(Result).Caption := Caption;
 TvtLabel(Result).Font.Style := [fsBold];
 Result.Top := aTop;
 l_Bevel := TBevel.Create(aParent);
 l_Bevel.Parent := aParent as TWinControl;
 l_Bevel.Left := Result.Width + aLeft + c_ConfigItemLeft;
 l_Bevel.Top := aTop + Result.Height div 2;
 if aParent is TScrollBox
  then l_Bevel.Width := aParent.ClientWidth - l_Bevel.Left - c_ConfigItemRight - c_ScrollBarWidth
  else l_Bevel.Width := aParent.ClientWidth - l_Bevel.Left - c_ConfigItemRight;
 l_Bevel.Height := 2;
//#UC END# *521761BB03DE_522623110098_impl*
end;//TddDividerConfigItem.ConstructControl

function TddDividerConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_522623110098_var*
//#UC END# *521B053F03C3_522623110098_var*
begin
//#UC START# *521B053F03C3_522623110098_impl*
 with TvtLabel.Create(nil) do
 try
  Parent := aParent;
  Result := Height + c_ConfigItemTop;
 finally
  Free;
 end;
//#UC END# *521B053F03C3_522623110098_impl*
end;//TddDividerConfigItem.ControlHeight

procedure TddDividerConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_522623110098_var*
//#UC END# *521B058801FD_522623110098_var*
begin
//#UC START# *521B058801FD_522623110098_impl*
 // TODO -cMM: TddDivider.GetValueFromControl default body inserted
//#UC END# *521B058801FD_522623110098_impl*
end;//TddDividerConfigItem.GetValueFromControl

procedure TddDividerConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_522623110098_var*
//#UC END# *521B07030052_522623110098_var*
begin
//#UC START# *521B07030052_522623110098_impl*
 // TODO -cMM: TddDivider.SetValueToControl default body inserted
//#UC END# *521B07030052_522623110098_impl*
end;//TddDividerConfigItem.SetValueToControl

function TddDividerConfigItem.MayBeRequired: Boolean;
//#UC START# *521725C301A5_522623110098_var*
//#UC END# *521725C301A5_522623110098_var*
begin
//#UC START# *521725C301A5_522623110098_impl*
 Result := False;
//#UC END# *521725C301A5_522623110098_impl*
end;//TddDividerConfigItem.MayBeRequired

constructor TddDividerConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_522623110098_var*
//#UC END# *5217273F000F_522623110098_var*
begin
//#UC START# *5217273F000F_522623110098_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_LabelTop := False;
 Labeled := False;
//#UC END# *5217273F000F_522623110098_impl*
end;//TddDividerConfigItem.Create

procedure TddDividerConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_522623110098_var*
//#UC END# *52172B72014C_522623110098_var*
begin
//#UC START# *52172B72014C_522623110098_impl*
//#UC END# *52172B72014C_522623110098_impl*
end;//TddDividerConfigItem.LoadValue

procedure TddDividerConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_522623110098_var*
//#UC END# *52172CA801E3_522623110098_var*
begin
//#UC START# *52172CA801E3_522623110098_impl*
//#UC END# *52172CA801E3_522623110098_impl*
end;//TddDividerConfigItem.SaveValue

function TddDividerConfigItem.LabelWidth(aParent: TWinControl): Integer;
//#UC START# *521B05DF00FC_522623110098_var*
var
 l_Label: TvtLabel;
//#UC END# *521B05DF00FC_522623110098_var*
begin
//#UC START# *521B05DF00FC_522623110098_impl*
 l_Label := TvtLabel.Create(nil);
 try
  l_Label.Parent := aParent;
  l_Label.CCaption := l3CStr(Caption);
  Result := l_Label.Width + c_ConfigItemLeft;
 finally
  FreeAndNil(l_Label);
 end;
//#UC END# *521B05DF00FC_522623110098_impl*
end;//TddDividerConfigItem.LabelWidth

function TddDividerConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_522623110098_var*
//#UC END# *521B061A0387_522623110098_var*
begin
//#UC START# *521B061A0387_522623110098_impl*
 Result := LabelWidth(aParent) + 50;
//#UC END# *521B061A0387_522623110098_impl*
end;//TddDividerConfigItem.MinWidth

procedure TddAppConfigNode.pm_SetObjects(aValue: Tl3ProtoPersistentRefList);
//#UC START# *5225B8100090_51D547F700ABset_var*
//#UC END# *5225B8100090_51D547F700ABset_var*
begin
//#UC START# *5225B8100090_51D547F700ABset_impl*
 f_Objects.Assign(aValue);
//#UC END# *5225B8100090_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetObjects

procedure TddAppConfigNode.pm_SetLabelTop(aValue: Boolean);
//#UC START# *5225B88A031F_51D547F700ABset_var*
var
 I: Integer;
//#UC END# *5225B88A031F_51D547F700ABset_var*
begin
//#UC START# *5225B88A031F_51D547F700ABset_impl*
 if f_LabelTop <> aValue then
 begin
  f_LabelTop := aValue;
  for I := 0 to Pred(Count) do
   Items[I].LabelTop := f_LabelTop;
 end; // f_LabelTop <> aValue
//#UC END# *5225B88A031F_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetLabelTop

function TddAppConfigNode.pm_GetItems(anIndex: Integer): TddVisualConfigItem;
//#UC START# *5225B97C02D3_51D547F700ABget_var*
//#UC END# *5225B97C02D3_51D547F700ABget_var*
begin
//#UC START# *5225B97C02D3_51D547F700ABget_impl*
 Result := TddVisualConfigItem(f_Objects.Items[anIndex]);
//#UC END# *5225B97C02D3_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetItems

function TddAppConfigNode.pm_GetItemByIndex(anIndex: Integer): TddVisualConfigItem;
//#UC START# *5225B9B00383_51D547F700ABget_var*
var
  I: Integer;
  l_Item: TddVisualConfigItem;
//#UC END# *5225B9B00383_51D547F700ABget_var*
begin
//#UC START# *5225B9B00383_51D547F700ABget_impl*
 Result := nil;
 for I := 0 to Pred(f_Objects.Count) do
 begin
  l_Item := TddVisualConfigItem(f_Objects.Items[I]);
  if l_Item.AbsoluteIndex = anIndex then
  begin
   Result := l_Item;
   Break;
  end;
 end;
//#UC END# *5225B9B00383_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetItemByIndex

function TddAppConfigNode.pm_GetAsBoolean(const anAlias: AnsiString): Boolean;
//#UC START# *5225BA060217_51D547F700ABget_var*
//#UC END# *5225BA060217_51D547F700ABget_var*
begin
//#UC START# *5225BA060217_51D547F700ABget_impl*
 Result := ItemByAlias[anAlias].Value.AsBoolean;
//#UC END# *5225BA060217_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetAsBoolean

procedure TddAppConfigNode.pm_SetAsBoolean(const anAlias: AnsiString;
 aValue: Boolean);
//#UC START# *5225BA060217_51D547F700ABset_var*
var
 l_Value: TddConfigValue;
 l_Item: TddBaseConfigItem;
//#UC END# *5225BA060217_51D547F700ABset_var*
begin
//#UC START# *5225BA060217_51D547F700ABset_impl*
 l_Item := ItemByAlias[anAlias];
 l_Value := l_Item.Value;
 if l_Value.Kind = dd_vkBoolean then
 begin
  l_Value.AsBoolean := aValue;
  l_Item.Value := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [anAlias]);
//#UC END# *5225BA060217_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetAsBoolean

function TddAppConfigNode.pm_GetAsDateTime(const anAlias: AnsiString): TDateTime;
//#UC START# *5225BAF902D3_51D547F700ABget_var*
//#UC END# *5225BAF902D3_51D547F700ABget_var*
begin
//#UC START# *5225BAF902D3_51D547F700ABget_impl*
 Result := ItemByAlias[anAlias].Value.AsDateTime;
//#UC END# *5225BAF902D3_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetAsDateTime

procedure TddAppConfigNode.pm_SetAsDateTime(const anAlias: AnsiString;
 aValue: TDateTime);
//#UC START# *5225BAF902D3_51D547F700ABset_var*
var
 l_Value: TddConfigValue;
 l_Item: TddBaseConfigItem;
//#UC END# *5225BAF902D3_51D547F700ABset_var*
begin
//#UC START# *5225BAF902D3_51D547F700ABset_impl*
 l_Item := ItemByAlias[anAlias];
 l_Value := l_Item.Value;
 if l_Value.Kind = dd_vkDateTime then
 begin
  l_Value.AsDateTime := aValue;
  l_Item.Value := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [anAlias]);
//#UC END# *5225BAF902D3_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetAsDateTime

function TddAppConfigNode.pm_GetAsInteger(const anAlias: AnsiString): Integer;
//#UC START# *5225BB4B0246_51D547F700ABget_var*
//#UC END# *5225BB4B0246_51D547F700ABget_var*
begin
//#UC START# *5225BB4B0246_51D547F700ABget_impl*
 Result := ItemByAlias[anAlias].Value.AsInteger;
//#UC END# *5225BB4B0246_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetAsInteger

procedure TddAppConfigNode.pm_SetAsInteger(const anAlias: AnsiString;
 aValue: Integer);
//#UC START# *5225BB4B0246_51D547F700ABset_var*
var
 l_Value: TddConfigValue;
 l_Item: TddBaseConfigItem;
//#UC END# *5225BB4B0246_51D547F700ABset_var*
begin
//#UC START# *5225BB4B0246_51D547F700ABset_impl*
 l_Item := ItemByAlias[anAlias];
 l_Value := l_Item.Value;
 if l_Value.Kind = dd_vkInteger then
 begin
  l_Value.AsInteger := aValue;
  l_Item.Value := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [anAlias]);
//#UC END# *5225BB4B0246_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetAsInteger

function TddAppConfigNode.pm_GetAsObject(const anAlias: AnsiString): TObject;
//#UC START# *5225BB59010E_51D547F700ABget_var*
//#UC END# *5225BB59010E_51D547F700ABget_var*
begin
//#UC START# *5225BB59010E_51D547F700ABget_impl*
 Result := ItemByAlias[anAlias].Value.AsObject;
//#UC END# *5225BB59010E_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetAsObject

procedure TddAppConfigNode.pm_SetAsObject(const anAlias: AnsiString;
 aValue: TObject);
//#UC START# *5225BB59010E_51D547F700ABset_var*
var
 l_Value: TddConfigValue;
 l_Item: TddBaseConfigItem;
//#UC END# *5225BB59010E_51D547F700ABset_var*
begin
//#UC START# *5225BB59010E_51D547F700ABset_impl*
 l_Item := ItemByAlias[anAlias];
 l_Value := l_Item.Value;
 if l_Value.Kind = dd_vkObject then
 begin
  l_Value.AsObject := aValue;
  l_Item.Value := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [anAlias]);
//#UC END# *5225BB59010E_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetAsObject

function TddAppConfigNode.pm_GetAsString(const anAlias: AnsiString): AnsiString;
//#UC START# *5225BB630324_51D547F700ABget_var*
//#UC END# *5225BB630324_51D547F700ABget_var*
begin
//#UC START# *5225BB630324_51D547F700ABget_impl*
 Result := ItemByAlias[anAlias].Value.AsString;
//#UC END# *5225BB630324_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetAsString

procedure TddAppConfigNode.pm_SetAsString(const anAlias: AnsiString;
 const aValue: AnsiString);
//#UC START# *5225BB630324_51D547F700ABset_var*
var
 l_Value: TddConfigValue;
 l_Item: TddBaseConfigItem;
//#UC END# *5225BB630324_51D547F700ABset_var*
begin
//#UC START# *5225BB630324_51D547F700ABset_impl*
 l_Item := ItemByAlias[anAlias];
 l_Value := l_Item.Value;
 if l_Value.Kind = dd_vkString then
 begin
  l_Value.AsString := aValue;
  l_Item.Value := l_Value;
 end
 else
  EddConfigError.CreateFmt(str_DifferentType.AsStr, [anAlias]);
//#UC END# *5225BB630324_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetAsString

function TddAppConfigNode.pm_GetCount: Integer;
//#UC START# *5225BBD2035C_51D547F700ABget_var*
//#UC END# *5225BBD2035C_51D547F700ABget_var*
begin
//#UC START# *5225BBD2035C_51D547F700ABget_impl*
  Assert(f_Objects <> nil);
  Result := f_Objects.Count
//#UC END# *5225BBD2035C_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetCount

function TddAppConfigNode.pm_GetItemByAlias(const anAlias: AnsiString): TddBaseConfigItem;
//#UC START# *5225C9B80025_51D547F700ABget_var*
var
 l_Obj: TddBaseConfigItem;
//#UC END# *5225C9B80025_51D547F700ABget_var*
begin
//#UC START# *5225C9B80025_51D547F700ABget_impl*
 if HasValue(anAlias, l_Obj) then
  Result := l_Obj
 else
  raise EddConfigError.CreateFmt(str_PropertyAbsent.AsStr, [anAlias]);;
//#UC END# *5225C9B80025_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetItemByAlias

constructor TddAppConfigNode.Create(const aAlias: AnsiString;
 const aCaption: AnsiString);
//#UC START# *5225BC4B01A6_51D547F700AB_var*
//#UC END# *5225BC4B01A6_51D547F700AB_var*
begin
//#UC START# *5225BC4B01A6_51D547F700AB_impl*
 inherited;
 f_Objects := Tl3ProtoPersistentRefList.Create;
 f_LabelTop := True;
//#UC END# *5225BC4B01A6_51D547F700AB_impl*
end;//TddAppConfigNode.Create

function TddAppConfigNode.AddItem(aItem: TddBaseConfigItem): TddBaseConfigItem;
//#UC START# *5225BCAE02EE_51D547F700AB_var*
//#UC END# *5225BCAE02EE_51D547F700AB_var*
begin
//#UC START# *5225BCAE02EE_51D547F700AB_impl*
 Result := aItem;
 aItem.ReadOnly := ReadOnly;
 Result.OnChange := ItemChanged;
 if (Result is TddVisualConfigItem) then
  TddVisualConfigItem(Result).LabelTop := LabelTop;
 f_Objects.Add(Result);
 FreeAndNil(aItem);
//#UC END# *5225BCAE02EE_51D547F700AB_impl*
end;//TddAppConfigNode.AddItem

procedure TddAppConfigNode.DoClearControls;
//#UC START# *521B285C035B_51D547F700AB_var*
var
  I: Integer;
//#UC END# *521B285C035B_51D547F700AB_var*
begin
//#UC START# *521B285C035B_51D547F700AB_impl*
  for I := 0 to Pred(Count) do
   Items[I].ClearControl;
  for I := 0 to Pred(ChildrenCount) do
   IddConfigNode(Children[I]).ClearControls;
//#UC END# *521B285C035B_51D547F700AB_impl*
end;//TddAppConfigNode.DoClearControls

function TddAppConfigNode.DoCreateFrame(aOwner: TComponent;
 aTag: Integer): TCustomFrame;
//#UC START# *521B28760177_51D547F700AB_var*
var
  l_MaxLeft: Integer;
  l_Top: Integer;
  l_Left: Integer;
  J, l_LJCount: Integer;
  l_CI: TddVisualConfigItem;
  l_Control, l_PrevControl: TControl;
  l_ButtonLeft: Integer;
  l_ButtonHeight: Integer;
  l_I: TddBaseConfigItem;
  //l_P: TvtPanel;
  l_ScrollBox: TScrollBox;
  l_FirstButton: Boolean;
//  procedure CheckHeight(aHeight : Integer);
//  begin
//   if not IsVerticalScrollBar and (aHeight > Result.ClientHeight) then
//    ScrollBars := ssVertical;
//    raise EddConfigError.CreateFmt('??????? "%s" (%s) ??????? ?? ??????? ?????',
//     [l_CI.Alias, l_CI.Caption]);
//  end;

//#UC END# *521B28760177_51D547F700AB_var*
begin
//#UC START# *521B28760177_51D547F700AB_impl*
 Result := TFrame.Create(aOwner);
 Result.Name := Alias;
 Result.Parent := aOwner as TWinControl;
 Result.Align := alClient;
 Result.Tag := aTag;
 Result.HelpContext := HelpContext;

//  l_P := TvtPanel.Create(aOwner);
//  Result.InsertControl(l_P);
//  l_P.Align := alClient;
//  l_P.BorderStyle := bsNone;
//  l_P.BevelOuter := bvNone;
//  l_P.BevelInner := bvNone;
//  {$IfDef Nemesis}
//  l_P.Color := cGarant2011BackColor;
//  {$EndIf};
 l_ScrollBox := TScrollBox.Create(aOwner);
 Result.InsertControl(l_ScrollBox);
 with l_ScrollBox do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  {$IfDef Nemesis}
  Color := cGarant2011BackColor;
  {$EndIf};
 end;

 l_ButtonLeft := Result.ClientWidth;
 l_ButtonHeight := 0;
 l_MaxLeft := RequiredSignWidth(Result);
 l_LJCount := 0;
 for J := 0 to Pred(Count) do
 begin
  l_CI := Items[J];
  if l_CI is TddGroupConfigItem then
   l_MaxLeft := Max(l_MaxLeft, TddGroupConfigItem(l_CI).ItemsLabelWidth(Result, l_LJCount))
  else
  if l_CI.Labeled and not l_CI.LabelTop then
  begin
   l_MaxLeft := Max(l_MaxLeft, l_CI.LabelWidth(Result));
   if not l_CI.LabelTop then
    Inc(l_LJCount);
  end;
 end;
 { TODO -oДмитрий Дудко -cОшибка :
 Выравнивать элементы по ширине метки нужно только в том случае,
 если есть несколько элементов с горизонтальным расположением элемента }
   if l_LJCount < 2 then
    l_MaxLeft := 0
   else
    Inc(l_MaxLeft, c_ConfigItemLeft);

 // Здесь добавляем контролы
 l_FirstButton := True;
 l_Top := c_ConfigItemTop;
 l_PrevControl := nil;
 for J := 0 to Pred(Count) do
 begin
  l_CI := Items[J];
  l_Left := c_ConfigItemLeft;
  l_I := l_CI.MasterItem;
  while l_I <> nil do
  begin
   Inc(l_Left, c_ConfigItemLeft);
   l_I := l_I.MasterItem;
  end;
  if l_CI.Visible then // Правильнее засунуть это внутрь CreateControl
   l_Control := l_CI.CreateControl(l_Left, l_MaxLeft, l_Top, l_ScrollBox{l_P}{Result})
  else
   l_Control := nil;
  if l_Control <> nil then
  begin
   if l_Control.HelpContext = 0 then
    l_Control.HelpContext := HelpContext;
   // кнопка в правом нижнем
   if (l_CI is TddButtonConfigItem) then       
   begin
    if (TddButtonConfigItem(l_CI).ButtonPlace = dd_bpBottomRight) then
    begin
     l_Control.Top := Result.ClientHeight - l_Control.Height - c_ConfigItemTop;
     if (l_Control.Parent is TScrollBox) and l_FirstButton
      then l_Control.Left := l_ButtonLeft - l_Control.Width - 2 * c_ConfigItemTop - c_ScrollBarWidth
      else l_Control.Left := l_ButtonLeft - l_Control.Width - 2 * c_ConfigItemTop;
     l_FirstButton := False;
     l_ButtonLeft := l_Control.Left;
     l_ButtonHeight := l_Control.Height + c_ConfigItemTop;
    end
    else
    begin
     if (l_PrevControl <> nil) and (l_PrevControl is TvtButton) then
     begin
      l_Control.Top := l_PrevControl.Top;
      l_Control.Left := l_PrevControl.Left + l_PrevControl.Width + c_ConfigItemTop;
      l_Top := l_Control.Height + l_Control.Top;
      Inc(l_Top, c_ConfigItemTop);
     end;
    end;
   end
   else // остальные компоненты
   begin
    l_Top := l_CI.ControlHeight(l_ScrollBox{l_P}) + l_Control.Top;
    Inc(l_Top, c_ConfigItemTop);
   end;
   l_PrevControl := l_Control;
  end;
  //CheckHeight(l_ButtonHeight + l_Top);
 end; // for J

 for J := 0 to Pred(Count) do
 begin
  l_CI := Items[J];
  l_Control := l_CI.Control;

  if l_Control <> nil then
   if (l_CI is TddButtonConfigItem) then
    if (TddButtonConfigItem(l_CI).ButtonPlace = dd_bpBottomRight) then
     l_Control.Top := Max(l_Control.Top, l_Top + c_ConfigItemTop);
 end;
//#UC END# *521B28760177_51D547F700AB_impl*
end;//TddAppConfigNode.DoCreateFrame

procedure TddAppConfigNode.DoGetControlValues;
//#UC START# *521B28BE015D_51D547F700AB_var*
var
 I: Integer;
 l_Item: TddVisualConfigItem;
//#UC END# *521B28BE015D_51D547F700AB_var*
begin
//#UC START# *521B28BE015D_51D547F700AB_impl*
 for I := 0 to Pred(Count) do
 begin
  with Items[I]do
  begin
   if Visible then
   begin
    Lock;
    GetValueFromControl;
    UnLock;
   end
  end
 end; // for I
 for I := 0 to Pred(ChildrenCount) do
  IddConfigNode(Children[I]).GetControlValues;
//#UC END# *521B28BE015D_51D547F700AB_impl*
end;//TddAppConfigNode.DoGetControlValues

function TddAppConfigNode.DoIsItem(aItem: TObject): Boolean;
//#UC START# *521B28D60001_51D547F700AB_var*
var
 lIndex : Integer;
//#UC END# *521B28D60001_51D547F700AB_var*
begin
//#UC START# *521B28D60001_51D547F700AB_impl*
 Result := False;
 for lIndex := 0 to Pred(Count) do
  if Items[lIndex].IsSame(aItem) then
  begin
   Result := True;
   Break;
  end;
//#UC END# *521B28D60001_51D547F700AB_impl*
end;//TddAppConfigNode.DoIsItem

procedure TddAppConfigNode.DoLoad(const aStorage: IddConfigStorage);
//#UC START# *521B28F40355_51D547F700AB_var*
//#UC END# *521B28F40355_51D547F700AB_var*
begin
//#UC START# *521B28F40355_51D547F700AB_impl*
 LoadValue(aStorage)
//#UC END# *521B28F40355_51D547F700AB_impl*
end;//TddAppConfigNode.DoLoad

procedure TddAppConfigNode.DoSave(const aStorage: IddConfigStorage);
//#UC START# *521B295A024F_51D547F700AB_var*
//#UC END# *521B295A024F_51D547F700AB_var*
begin
//#UC START# *521B295A024F_51D547F700AB_impl*
 SaveValue(aStorage);
//#UC END# *521B295A024F_51D547F700AB_impl*
end;//TddAppConfigNode.DoSave

procedure TddAppConfigNode.DoSetControlValues(aDefault: Boolean);
//#UC START# *521B298800F7_51D547F700AB_var*
var
  I: Integer;
  l_Item: TddVisualConfigItem;
//#UC END# *521B298800F7_51D547F700AB_var*
begin
//#UC START# *521B298800F7_51D547F700AB_impl*
 for I := 0 to Pred(Count) do
 begin
  l_Item := Items[I];
  if l_Item.Control <> nil then
  begin
   l_Item.Lock;
   l_Item.SetValueToControl(aDefault);
   l_Item.UnLock;
  end; // l_Item.Control <> nil
 end;
 for I := 0 to Pred(ChildrenCount) do
  IddConfigNode(Children[I]).SetControlValues(aDefault);
//#UC END# *521B298800F7_51D547F700AB_impl*
end;//TddAppConfigNode.DoSetControlValues

procedure TddAppConfigNode.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_51D547F700AB_var*
var
 l_AC: TddAppConfigNode absolute Source;
 I: Integer;
 l_Item: TddBaseConfigItem;
//#UC END# *478CF34E02CE_51D547F700AB_var*
begin
//#UC START# *478CF34E02CE_51D547F700AB_impl*
 if Source is TddAppConfigNode then
 begin
  inherited;
  f_Objects.Clear;
  for I := 0 to Pred(l_AC.Count) do
  begin
   l_Item := l_AC.Items[I].Clone;
   try
    f_Objects.Add(l_Item);
   finally
    FreeAndNil(l_Item);
   end;
  end
 end
 else
  inherited;
//#UC END# *478CF34E02CE_51D547F700AB_impl*
end;//TddAppConfigNode.Assign

procedure TddAppConfigNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51D547F700AB_var*
//#UC END# *479731C50290_51D547F700AB_var*
begin
//#UC START# *479731C50290_51D547F700AB_impl*
 FreeAndNil(f_Objects);
 inherited;
//#UC END# *479731C50290_51D547F700AB_impl*
end;//TddAppConfigNode.Cleanup

function TddAppConfigNode.pm_GetChanged: Boolean;
//#UC START# *5217205002F2_51D547F700ABget_var*
var
 I: Integer;
//#UC END# *5217205002F2_51D547F700ABget_var*
begin
//#UC START# *5217205002F2_51D547F700ABget_impl*
 Result := inherited pm_GetChanged;
 if not Result then
  for I := 0 to Pred(Count) do
   if Items[I].Changed then
   begin
    Result := true;
    break
   end;
//#UC END# *5217205002F2_51D547F700ABget_impl*
end;//TddAppConfigNode.pm_GetChanged

procedure TddAppConfigNode.pm_SetChanged(aValue: Boolean);
//#UC START# *5217205002F2_51D547F700ABset_var*
var
 I: Integer;
//#UC END# *5217205002F2_51D547F700ABset_var*
begin
//#UC START# *5217205002F2_51D547F700ABset_impl*
 inherited;
 for I := 0 to Pred(Count) do
  Items[I].Changed := aValue;
 if not aValue then 
  for I := 0 to Pred(ChildrenCount) do
   Children[I].Changed := aValue;
//#UC END# *5217205002F2_51D547F700ABset_impl*
end;//TddAppConfigNode.pm_SetChanged

function TddAppConfigNode.HasValue(const anAlias: AnsiString;
 out theItem: TddBaseConfigItem): Boolean;
//#UC START# *52172A7700CB_51D547F700AB_var*
var
 I: Integer;
//#UC END# *52172A7700CB_51D547F700AB_var*
begin
//#UC START# *52172A7700CB_51D547F700AB_impl*
 Result := AnsiCompareStr(Alias, anAlias) = 0;
 if Result then
  theItem := Self
 else
 begin
  for I := 0 to Pred(Count) do
  begin
   Result := Items[I].HasValue(anAlias, theItem);
   if Result then
    break;
  end;
  if not Result then
   for I := 0 to Pred(ChildrenCount) do
   begin
    Result := Children[I].HasValue(anAlias, theItem);
    if Result then
     break;
   end;
 end;
//#UC END# *52172A7700CB_51D547F700AB_impl*
end;//TddAppConfigNode.HasValue

procedure TddAppConfigNode.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_51D547F700AB_var*
var
 I: Integer;
//#UC END# *52172B72014C_51D547F700AB_var*
begin
//#UC START# *52172B72014C_51D547F700AB_impl*
 for I := 0 to Pred(Count) do
 begin
  aStorage.Section := Alias;
  Items[I].Load(aStorage);
 end; // for I
 for I := 0 to Pred(ChildrenCount) do
  Children[I].Load(aStorage);
//#UC END# *52172B72014C_51D547F700AB_impl*
end;//TddAppConfigNode.LoadValue

procedure TddAppConfigNode.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_51D547F700AB_var*
var
 I: Integer;
//#UC END# *52172CA801E3_51D547F700AB_var*
begin
//#UC START# *52172CA801E3_51D547F700AB_impl*
 for I := 0 to Pred(f_Objects.Count) do
 begin
   aStorage.Section := Alias;
   Items[I].Save(aStorage);
 end; // for I
 for I := 0 to Pred(ChildrenCount) do
   Children[I].Save(aStorage);
//#UC END# *52172CA801E3_51D547F700AB_impl*
end;//TddAppConfigNode.SaveValue

function TddAppConfigNode.IsRequired(out aMessage: AnsiString): Boolean;
//#UC START# *521B251D0001_51D547F700AB_var*
var
 I: Integer;
//#UC END# *521B251D0001_51D547F700AB_var*
begin
//#UC START# *521B251D0001_51D547F700AB_impl*
 Result := False;
 aMessage := '';
 for I := 0 to Pred(Count) do
 begin
  if Items[I].IsRequired then
  begin
   Result := True;
   aMessage := aMessage + Items[I].Caption;
  end;
 end;
//#UC END# *521B251D0001_51D547F700AB_impl*
end;//TddAppConfigNode.IsRequired

procedure TddAppConfigNode.DoFrameSize(aParent: TWinControl;
 out aHeight: Integer;
 out aWidth: Integer);
//#UC START# *521B28930009_51D547F700AB_var*
var
  I: Integer;
  l_ButtonHeight: Integer;
  l_ButtonWidth: Integer;
  procedure _ItemSize(aCI: TddVisualConfigItem; out aH, aW: Integer);
  var
   l_LW, l_CW: Integer;
   l_Delta: Integer;
   l_I: TddBaseConfigItem;
  begin
   l_Delta := 0;
   l_I := aCI.MasterItem;
   while l_I <> nil do // Вычисляем сдвиг относительно Хозяина
   begin
    Inc(l_Delta, c_ConfigItemLeft);
    l_I := l_I.MasterItem;
   end; // while l_I <> nil

    l_LW := IfThen(aCI.Labeled, aCI.LabelWidth(aParent), 0); // метка

    l_CW := aCI.MinWidth(aParent) + RequiredSignWidth(aParent); // контрол

   if aCI.Labeled and (not aCI.LabelTop) then
    Inc(l_CW, l_LW + c_ConfigItemLeft);

   aW := Max(aW, l_CW);

   Inc(aW, l_Delta);
   Inc(aH, aCI.FullControlHeight[aParent]);
  end;
//#UC END# *521B28930009_51D547F700AB_var*
begin
//#UC START# *521B28930009_51D547F700AB_impl*
 l_ButtonHeight := 0;
 l_ButtonWidth := 0;
 aHeight := 0;
 aWidth := 0;

 for I := 0 to Pred(Count) do
 begin
  // учитываем кнопки в правом нижнем
  if (Items[I] is TddButtonConfigItem) and
   (TddButtonConfigItem(Items[I]).ButtonPlace = dd_bpBottomRight) then
  begin
   // учитываем только первую, потому что кнопки размещаются на одной линии
   if (l_ButtonHeight = 0) then
   begin
    l_ButtonHeight := Items[I].ControlHeight(aParent) + c_ConfigItemTop;
    Inc(aHeight, l_ButtonHeight);
   end;
   // ширина вытянутых в линию кнопок
   Inc(l_ButtonWidth, Items[I].MinWidth(aParent) + c_ConfigItemLeft);
  end
  // все остальные
  else
  begin
   _ItemSize(Items[I], aHeight, aWidth);
   Inc(aHeight, c_ConfigItemTop);
  end;
 end; // for I
 aHeight := aHeight + 2 * c_ConfigItemTop;
 aWidth := Max(aWidth, l_ButtonWidth);
//#UC END# *521B28930009_51D547F700AB_impl*
end;//TddAppConfigNode.DoFrameSize

procedure TddAppConfigNode.DoResetToDefault;
//#UC START# *521B293B0012_51D547F700AB_var*
var
 I: Integer;
//#UC END# *521B293B0012_51D547F700AB_var*
begin
//#UC START# *521B293B0012_51D547F700AB_impl*
 for I := 0 to Pred(f_Objects.Count) do
  TddVisualConfigItem(f_Objects.Items[I]).ResetToDefault;
 for I := 0 to Pred(ChildrenCount) do
  IddConfigNode(Children[I]).ResetToDefault;
//#UC END# *521B293B0012_51D547F700AB_impl*
end;//TddAppConfigNode.DoResetToDefault

function TddAppConfigNode.Clone: Pointer;
//#UC START# *5301EC7500FF_51D547F700AB_var*
//#UC END# *5301EC7500FF_51D547F700AB_var*
begin
//#UC START# *5301EC7500FF_51D547F700AB_impl*
 Result := TddAppConfigNode.Create(Alias, Caption);
 TddAppConfigNode(Result).Assign(Self);
//#UC END# *5301EC7500FF_51D547F700AB_impl*
end;//TddAppConfigNode.Clone

procedure TddAppConfigNode.ReadOnlyChanged;
//#UC START# *552BA9B9039B_51D547F700AB_var*
var
 l_IDX: Integer;
//#UC END# *552BA9B9039B_51D547F700AB_var*
begin
//#UC START# *552BA9B9039B_51D547F700AB_impl*
 inherited;
 for l_IDX := 0 to Count - 1 do
  Items[l_IDX].ReadOnly := ReadOnly;
//#UC END# *552BA9B9039B_51D547F700AB_impl*
end;//TddAppConfigNode.ReadOnlyChanged

function TddMasterSlaveConfigItem.CheckItem(const aAlias: AnsiString): Boolean;
//#UC START# *52270BD70078_5227065901DC_var*
var
 lIndex : Integer;
//#UC END# *52270BD70078_5227065901DC_var*
begin
//#UC START# *52270BD70078_5227065901DC_impl*
 Result := True;
 for lIndex := 0 to Pred(f_ListItems.Count) do
  if TddBaseConfigItem(f_ListItems[lIndex]).Alias = aAlias then
  begin
   Result := False;
   Break;
  end;
//#UC END# *52270BD70078_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.CheckItem

procedure TddMasterSlaveConfigItem.OnChange(Sender: TObject);
//#UC START# *52270BF4035A_5227065901DC_var*
//#UC END# *52270BF4035A_5227065901DC_var*
begin
//#UC START# *52270BF4035A_5227065901DC_impl*
 ChangeItem;
//#UC END# *52270BF4035A_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.OnChange

function TddMasterSlaveConfigItem.FirstItem(aItemIndex: Integer): Integer;
//#UC START# *52270C3200A1_5227065901DC_var*
//#UC END# *52270C3200A1_5227065901DC_var*
begin
//#UC START# *52270C3200A1_5227065901DC_impl*
 Result := aItemIndex * SubItems.Count;
//#UC END# *52270C3200A1_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.FirstItem

procedure TddMasterSlaveConfigItem.ChangeItem;
//#UC START# *52270C520373_5227065901DC_var*
//#UC END# *52270C520373_5227065901DC_var*
begin
//#UC START# *52270C520373_5227065901DC_impl*
 UpdateDataItems(f_PrevIndex);
 f_PrevIndex := f_ComboBox.ItemIndex;
 AssignDataFromDetail;
//#UC END# *52270C520373_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.ChangeItem

procedure TddMasterSlaveConfigItem.AssignDataFromDetail;
//#UC START# *52270C5C02D6_5227065901DC_var*
var
 lItem: Integer;
 lIndex: Integer;
 lDest: TddVisualConfigItem;
 lSource: TddBaseConfigItem;
//#UC END# *52270C5C02D6_5227065901DC_var*
begin
//#UC START# *52270C5C02D6_5227065901DC_impl*
 if f_ComboBox.ItemIndex = -1 then
  Exit;
 lItem := FirstItem(f_ComboBox.ItemIndex);
 for lIndex := 0 to Pred(SubItems.Count) do
 begin
  // Визуальный элемент
  lDest := TddVisualConfigItem(SubItems[lIndex]);
  // Элемент данных
  lSource := TddBaseConfigItem(f_ListItems[lIndex + lItem]);
  // Установим
  lDest.AssignValue(lSource.Value, True);
  // Отобразим
  lDest.SetValueToControl(False);
 end;
//#UC END# *52270C5C02D6_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.AssignDataFromDetail

procedure TddMasterSlaveConfigItem.AddStructureItem(aItem: TddBaseConfigItem);
//#UC START# *52270CA70249_5227065901DC_var*
//#UC END# *52270CA70249_5227065901DC_var*
begin
//#UC START# *52270CA70249_5227065901DC_impl*
 SubItems.Add(aItem);
//#UC END# *52270CA70249_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.AddStructureItem

procedure TddMasterSlaveConfigItem.AddCaption(const aCaption: AnsiString;
 const aAliasPrefix: AnsiString);
//#UC START# *52270CC9030D_5227065901DC_var*
var
 lIndex : Integer;
//#UC END# *52270CC9030D_5227065901DC_var*
begin
//#UC START# *52270CC9030D_5227065901DC_impl*
 // Проверим на уникальность
 lIndex := f_Captions.IndexOf(aCaption);
 if lIndex <> -1 then
  raise EddConfigError.CreateFmt('Элемент с именем %s уже существует.',
   [aCaption]);
 // Добавим в список
 f_Captions.Add(aCaption);
//#UC END# *52270CC9030D_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.AddCaption

function TddMasterSlaveConfigItem.AddAlias(const aAlias: AnsiString): TddBaseConfigItem;
//#UC START# *52270CF103B7_5227065901DC_var*
var
 lIndex : Integer;
 lTemp  : TddBaseConfigItem;
//#UC END# *52270CF103B7_5227065901DC_var*
begin
//#UC START# *52270CF103B7_5227065901DC_impl*
 // Не определен ни один StructureItem
 if SubItems.Count = 0 then
  raise EddConfigError.Create('Прежде чем добавлять очередной идентификатор ' + 
   'настройки нужно создать хотя бы один элемент в группе AddStructureItem.');
 // Проверим на уникальность
 if not CheckItem(aAlias) then
  raise EddConfigError.CreateFmt('Элемент и именем %s уже существует.',
   [aAlias]);
 // Проверим, что добавляемый элемент не выходит за пределы StructureItems
 lIndex := Succ(f_ListItems.Count mod SubItems.Count);
 if lIndex > SubItems.Count then
  raise EddConfigError.CreateFmt('Добавляемый элемент является %d, всего ' + 
   'StructureItems определено %d.', [lIndex, SubItems.Count]);
 // Добавим новый элемент
 Result := TddBaseConfigItem.Create(aAlias, '', ddEmptyValue);
 // Скопируем параметры
 Result.Assign(TddBaseConfigItem(SubItems.Items[Pred(lIndex)]));
 Result.Alias := aAlias;
 // Добавим в список
 f_ListItems.Add(Result);
 // Уменьшим счетчик ссылок
 lTemp := Result;
 FreeAndNil(lTemp);
//#UC END# *52270CF103B7_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.AddAlias

procedure TddMasterSlaveConfigItem.UpdateDataItems(aItemIndex: Integer);
//#UC START# *5228420602FA_5227065901DC_var*
var
 lSource: TddVisualConfigItem;
 lDest: TddBaseConfigItem;
 lItem: Integer;
 lIndex: Integer;
//#UC END# *5228420602FA_5227065901DC_var*
begin
//#UC START# *5228420602FA_5227065901DC_impl*
 if (aItemIndex = -1) or (aItemIndex > Pred(f_ComboBox.Items.Count)) then
  Exit;
 lItem := FirstItem(aItemIndex);
 for lIndex := 0 to Pred(f_SubItems.Count) do
 begin
  lSource := SubItem[lIndex];
  lSource.GetValueFromControl;
  lDest := TddBaseConfigItem(f_ListItems[lIndex + lItem]);
  lDest.AssignValue(lSource.Value, True);
 end;
//#UC END# *5228420602FA_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.UpdateDataItems

procedure TddMasterSlaveConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5227065901DC_var*
//#UC END# *479731C50290_5227065901DC_var*
begin
//#UC START# *479731C50290_5227065901DC_impl*
 FreeAndNil(f_Captions);
 FreeAndNil(f_ListItems);
 inherited;
//#UC END# *479731C50290_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.Cleanup

constructor TddMasterSlaveConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5227065901DC_var*
//#UC END# *5217273F000F_5227065901DC_var*
begin
//#UC START# *5217273F000F_5227065901DC_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_ListItems := Tl3ProtoPersistentRefList.Create;
 f_Captions := TStringList.Create;
 f_PrevIndex := -1;
//#UC END# *5217273F000F_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.Create

procedure TddMasterSlaveConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5227065901DC_var*
var
 lIndex : Integer;
//#UC END# *52172B72014C_5227065901DC_var*
begin
//#UC START# *52172B72014C_5227065901DC_impl*
 // Прочитаем
 for lIndex := 0 to Pred(f_ListItems.Count) do
  TddBaseConfigItem(f_ListItems[lIndex]).LoadValue(aStorage);
//#UC END# *52172B72014C_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.LoadValue

procedure TddMasterSlaveConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5227065901DC_var*
var
 lIndex : Integer;
//#UC END# *52172CA801E3_5227065901DC_var*
begin
//#UC START# *52172CA801E3_5227065901DC_impl*
 // Запишием значения из визуальных элементов в элементы списка
 if f_ComboBox <> nil then
  UpdateDataItems(f_ComboBox.ItemIndex);
 // Сохраним
 for lIndex := 0 to Pred(f_ListItems.Count) do
  TddBaseConfigItem(f_ListItems[lIndex]).SaveValue(aStorage);
//#UC END# *52172CA801E3_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.SaveValue

function TddMasterSlaveConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5227065901DC_var*
var
 lLabel : TvtLabel;
//#UC END# *521761BB03DE_5227065901DC_var*
begin
//#UC START# *521761BB03DE_5227065901DC_impl*
 Result := inherited ConstructControl(aLeft, aMaxLeft, aTop, aParent);
 if Assigned(Result) then
 begin
  // Удалим caption
  TvtGroupBox(Result).Caption := '';
  // Метка
  lLabel := TvtLabel.Create(Result);
  lLabel.Parent := TWinControl(Result);
  if Caption <> '' then
  lLabel.CCaption := l3CStr(' ' + Caption + ' ');
  lLabel.Left := c_ConfigItemLeft;
  // Список
  f_ComboBox := TvtComboBoxQS.Create(Result);
  with f_ComboBox do
  begin
   Parent := TWinControl(Result);
   Left := lLabel.Left + lLabel.Width + c_ConfigItemLeft;
   Width := Result.ClientRect.Right - Left - c_ConfigItemRight;
   Style := csDropDownList;
   OnChange := Self.OnChange;
   if f_Captions.Count > 0 then
   begin
    Items.Assign(f_Captions);
    ItemIndex := 0;
   end;
   ChangeItem;
  end;
 end;
//#UC END# *521761BB03DE_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.ConstructControl

procedure TddMasterSlaveConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5227065901DC_var*
//#UC END# *521B07030052_5227065901DC_var*
begin
//#UC START# *521B07030052_5227065901DC_impl*
 inherited;
 AssignDataFromDetail;
//#UC END# *521B07030052_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.SetValueToControl

function TddMasterSlaveConfigItem.HeaderHeight(aParent: TWinControl): Integer;
//#UC START# *52270A8C03B4_5227065901DC_var*
var
 lComboBox : TvtComboBoxQS;
//#UC END# *52270A8C03B4_5227065901DC_var*
begin
//#UC START# *52270A8C03B4_5227065901DC_impl*
 lComboBox := TvtComboBoxQS.Create(aParent);
 try
  lComboBox.Parent := aParent;
  Result := lComboBox.Height + c_ConfigItemTop;
 finally
  FreeAndNil(lComboBox);
 end;
//#UC END# *52270A8C03B4_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.HeaderHeight

procedure TddMasterSlaveConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5227065901DC_var*
//#UC END# *552BB745031E_5227065901DC_var*
begin
//#UC START# *552BB745031E_5227065901DC_impl*
 inherited;
// f_ComboBox.ReadOnly := ReadOnly;
 f_ComboBox.Enabled := f_ComboBox.Enabled and not ReadOnly;
//#UC END# *552BB745031E_5227065901DC_impl*
end;//TddMasterSlaveConfigItem.AdjustReadOnly

function TddContainerConfigItem.GetCaseIndex: Integer;
//#UC START# *522711880283_5227066903AF_var*
//#UC END# *522711880283_5227066903AF_var*
begin
//#UC START# *522711880283_5227066903AF_impl*
 if UseCheckBox then
  Result := 0
 else
  Result := TvtComboBoxQS(Control).ItemIndex;
//#UC END# *522711880283_5227066903AF_impl*
end;//TddContainerConfigItem.GetCaseIndex

procedure TddContainerConfigItem.ConstructSubItems(aLeft: Integer;
 aMaxLeft: Integer);
//#UC START# *52271241038E_5227066903AF_var*
var
 I: Integer;
 l_Top: Integer;
//#UC END# *52271241038E_5227066903AF_var*
begin
//#UC START# *52271241038E_5227066903AF_impl*
 l_Top := Control.Top + Control.Height;
 if aMaxLeft < aLeft then
  aMaxLeft := aLeft;
 SubItem[GetCaseIndex].CreateControl(aleft,aMaxLeft, l_Top, Control.Parent);
 // Нужно установить значения элементам. Кроме себя самого
 SetValueToSubitems(False);
//#UC END# *52271241038E_5227066903AF_impl*
end;//TddContainerConfigItem.ConstructSubItems

procedure TddContainerConfigItem.DestroySubItems;
//#UC START# *522712640327_5227066903AF_var*
var
 I: Integer;
//#UC END# *522712640327_5227066903AF_var*
begin
//#UC START# *522712640327_5227066903AF_impl*
 I := GetCaseIndex;
 for I := 0 to Pred(Count) do
  if SubItem[I].Control <> nil then
  begin
   Control.Parent.RemoveControl(SubItem[I].Control);
   SubItem[I].Control.Free;
   SubItem[I].Control := nil;
   SubItem[I].ClearControl;
  end;
//#UC END# *522712640327_5227066903AF_impl*
end;//TddContainerConfigItem.DestroySubItems

procedure TddContainerConfigItem.SetValueToSubitems(aDefault: Boolean);
//#UC START# *522713BB02EE_5227066903AF_var*
var
 I: Integer;
//#UC END# *522713BB02EE_5227066903AF_var*
begin
//#UC START# *522713BB02EE_5227066903AF_impl*
 if BooleanValue then
 begin
  I := GetCaseIndex;
  SubItem[I].Lock;
  SubItem[I].SetValueToControl(aDefault);
  SubItem[I].Unlock;
 end;
//#UC END# *522713BB02EE_5227066903AF_impl*
end;//TddContainerConfigItem.SetValueToSubitems

procedure TddContainerConfigItem.AddCase(const aCaption: AnsiString);
//#UC START# *522713E90174_5227066903AF_var*
var
 l_Group: TddGroupConfigItem;
//#UC END# *522713E90174_5227066903AF_var*
begin
//#UC START# *522713E90174_5227066903AF_impl*
 l_Group := TddGroupConfigItem.SimpleCreate(Alias + IntToStr(SubItems.Count), aCaption);
 l_Group.ReadOnly := ReadOnly;
 l_Group.ShowCaption := False;
 l_Group.LabelTop := False;
 SubItems.Add(l_Group);
//#UC END# *522713E90174_5227066903AF_impl*
end;//TddContainerConfigItem.AddCase

procedure TddContainerConfigItem.OnClick(Sender: TObject);
//#UC START# *522843D202FB_5227066903AF_var*
var
 l_True: Boolean;
//#UC END# *522843D202FB_5227066903AF_var*
begin
//#UC START# *522843D202FB_5227066903AF_impl*
 Lock;
 try
  l_True := pm_GetBooleanValue;
  ChangeSlaveStatus(l_True);
  if inherited pm_GetBooleanValue <> l_True then
   Changed := True;
  if l_True then
  begin
   if f_LastIndex <> -1 then
    SubItem[f_LastIndex].GetValueFromControl;
   DestroySubItems;
   ConstructSubItems(f_Left, f_MaxLeft);
   f_LastIndex := GetCaseIndex;
  end
  else
  begin
   DestroySubItems;
   f_LastIndex := -1;
  end;
 finally
  Unlock;
 end;
//#UC END# *522843D202FB_5227066903AF_impl*
end;//TddContainerConfigItem.OnClick

function TddContainerConfigItem.UseCheckBox: Boolean;
//#UC START# *5514FCD10138_5227066903AF_var*
//#UC END# *5514FCD10138_5227066903AF_var*
begin
//#UC START# *5514FCD10138_5227066903AF_impl*
 Result := (Count < 2) and not ForceComboBox;
//#UC END# *5514FCD10138_5227066903AF_impl*
end;//TddContainerConfigItem.UseCheckBox

function TddContainerConfigItem.pm_GetBooleanValue: Boolean;
//#UC START# *52171FDF0382_5227066903AFget_var*
//#UC END# *52171FDF0382_5227066903AFget_var*
begin
//#UC START# *52171FDF0382_5227066903AFget_impl*
 if Control <> nil then
  if UseCheckBox then
  begin
   assert(Control Is TvtCheckBox, Control.ClassName);
   Result := (Control as TvtCheckBox).Checked;
  end
  else
  begin
   assert(Control Is TvtComboBoxQS, Control.ClassName);
   Result := (Control as TvtComboBoxQS).ItemIndex <> -1
  end
 else
  Result := inherited pm_GetBooleanValue;
//#UC END# *52171FDF0382_5227066903AFget_impl*
end;//TddContainerConfigItem.pm_GetBooleanValue

procedure TddContainerConfigItem.pm_SetBooleanValue(aValue: Boolean);
//#UC START# *52171FDF0382_5227066903AFset_var*
//#UC END# *52171FDF0382_5227066903AFset_var*
begin
//#UC START# *52171FDF0382_5227066903AFset_impl*
 inherited pm_SetBooleanValue(aValue);
//#UC END# *52171FDF0382_5227066903AFset_impl*
end;//TddContainerConfigItem.pm_SetBooleanValue

function TddContainerConfigItem.MayBeRequired: Boolean;
//#UC START# *521725C301A5_5227066903AF_var*
//#UC END# *521725C301A5_5227066903AF_var*
begin
//#UC START# *521725C301A5_5227066903AF_impl*
 Result := True;
//#UC END# *521725C301A5_5227066903AF_impl*
end;//TddContainerConfigItem.MayBeRequired

constructor TddContainerConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5227066903AF_var*
var
 l_Value : TddConfigValue;
//#UC END# *5217273F000F_5227066903AF_var*
begin
//#UC START# *5217273F000F_5227066903AF_impl*
 f_LastIndex := -1;
 with l_Value do
 begin
  Kind := dd_vkInteger;
  AsInteger := aDefaultValue.AsInteger;
 end;
 inherited Create(aAlias, aCaption, l_Value, aMasterItem);
 Labeled := False;
 ShowCaption := False;
//#UC END# *5217273F000F_5227066903AF_impl*
end;//TddContainerConfigItem.Create

procedure TddContainerConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5227066903AF_var*
var
 I: Integer;
//#UC END# *52172B72014C_5227066903AF_var*
begin
//#UC START# *52172B72014C_5227066903AF_impl*
 IntegerValue := aStorage.ReadInteger(Alias, DefaultValue.AsInteger);
 BooleanValue := Boolean(IntegerValue);
 for I := 0 to Pred(Count) do
  SubItem[I].Load(aStorage);
//#UC END# *52172B72014C_5227066903AF_impl*
end;//TddContainerConfigItem.LoadValue

procedure TddContainerConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5227066903AF_var*
var
 I: Integer;
//#UC END# *52172CA801E3_5227066903AF_var*
begin
//#UC START# *52172CA801E3_5227066903AF_impl*
 aStorage.WriteInteger(Alias, IntegerValue);
  for I := 0 to Pred(Count) do
   SubItem[I].Save(aStorage);
//#UC END# *52172CA801E3_5227066903AF_impl*
end;//TddContainerConfigItem.SaveValue

function TddContainerConfigItem.pm_GetLabeled: Boolean;
//#UC START# *5217600501C4_5227066903AFget_var*
var
 I, J: Integer;
 l_SI: TddGroupConfigItem;
//#UC END# *5217600501C4_5227066903AFget_var*
begin
//#UC START# *5217600501C4_5227066903AFget_impl*
 if f_InCreate then
  Result := Count > 1
 else
 begin
  Result := False;
  for I := 0 to Pred(Count) do
  begin
   l_SI := SubItem[I] as TddGroupConfigItem;
   for J := 0 to Pred(l_SI.Count) do
   if l_SI.SubItem[J].Labeled then
   begin
    Result := True;
    break;
   end;
   if Result then
    break;
  end;
 end;
//#UC END# *5217600501C4_5227066903AFget_impl*
end;//TddContainerConfigItem.pm_GetLabeled

procedure TddContainerConfigItem.AfterConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 theControl: TControl;
 theLabel: TvtLabel);
//#UC START# *521760C60369_5227066903AF_var*
//#UC END# *521760C60369_5227066903AF_var*
begin
//#UC START# *521760C60369_5227066903AF_impl*
 inherited;
 f_InCreate := False;
 f_LastIndex := -1;
//#UC END# *521760C60369_5227066903AF_impl*
end;//TddContainerConfigItem.AfterConstruct

procedure TddContainerConfigItem.BeforeConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl);
//#UC START# *5217612C01B6_5227066903AF_var*
//#UC END# *5217612C01B6_5227066903AF_var*
begin
//#UC START# *5217612C01B6_5227066903AF_impl*
 inherited;
 f_InCreate := True;
//#UC END# *5217612C01B6_5227066903AF_impl*
end;//TddContainerConfigItem.BeforeConstruct

function TddContainerConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5227066903AF_var*
var
 I: Integer;
 l_Height: Integer;
//#UC END# *521761BB03DE_5227066903AF_var*
begin
//#UC START# *521761BB03DE_5227066903AF_impl*
 f_Left := aLeft;
 f_MaxLeft := aMaxLeft;
 if Count > 0 then
 begin
  if UseCheckBox then
  begin
   // Добавляем TvtCheckBox
   Result := TvtCheckBox.Create(aParent);
   aParent.InsertControl(Result);
   TvtCheckBox(Result).Caption := Caption;
   TvtCheckBox(Result).OnClick := OnClick;
  end
  else
  begin
   // Добавляем TvtComboBoxQS
   Result := TvtComboBoxQS.Create(aParent);
   aParent.InsertControl(Result);
   TvtComboBoxQS(Result).Style := csDropDownList;
   for I := 0 to Pred(SubItems.Count) do
    TvtComboBoxQS(Result).Items.Add(TddGroupConfigItem(SubItems.Items[I]).Caption);
   TvtComboBoxQS(Result).OnChange := OnClick;
  end;
  Result.Left := aLeft;
  Result.Top := aTop;
  if aParent is TScrollBox
   then Result.Width := aParent.ClientWidth - c_ConfigItemRight - aLeft - c_ScrollBarWidth
   else Result.Width := aParent.ClientWidth - c_ConfigItemRight - aLeft;

  if Hint <> '' then
  begin
   Result.Hint := Hint;
   Result.ShowHint := True;
  end;
 end
 else
  Result := nil;
//#UC END# *521761BB03DE_5227066903AF_impl*
end;//TddContainerConfigItem.ConstructControl

function TddContainerConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5227066903AF_var*
var
 I: Integer;
 l_Max: Integer;
//#UC END# *521B053F03C3_5227066903AF_var*
begin
//#UC START# *521B053F03C3_5227066903AF_impl*
 with TvtCheckBox.Create(nil) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
 // Нужно перебрать все наборы и выбрать самый высокий
 l_Max := 0;
 for I := 0 to Pred(Count) do
  l_Max := Max(l_Max, SubItem[I].FullControlHeight[aParent] + c_ConfigItemTop);
 Inc(Result, c_ConfigItemTop + l_Max);
//#UC END# *521B053F03C3_5227066903AF_impl*
end;//TddContainerConfigItem.ControlHeight

procedure TddContainerConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5227066903AF_var*
var
 I: Integer;
//#UC END# *521B058801FD_5227066903AF_var*
begin
//#UC START# *521B058801FD_5227066903AF_impl*
 if UseCheckBox then
 begin
  assert(Control Is TvtCheckBox, Control.ClassName);
  IntegerValue := Ord(TvtCheckBox(Control).Checked);
 end 
 else
 begin
  assert(Control Is TvtComboBoxQS, Control.ClassName);
  IntegerValue := TvtComboBoxQS(Control).ItemIndex;
 end;
 if BooleanValue then
 begin
  I := GetCaseIndex;
  if SubItem[I].Control <> nil then
  begin
  SubItem[I].GetValueFromControl;
  if SubItem[I].Changed then
   Changed := True;
  end;
 end;
//#UC END# *521B058801FD_5227066903AF_impl*
end;//TddContainerConfigItem.GetValueFromControl

function TddContainerConfigItem.LabelWidth(aParent: TWinControl): Integer;
//#UC START# *521B05DF00FC_5227066903AF_var*
var
 l_Label: TvtLabel;
 l_P, l_S: AnsiString;
 I, J: Integer;
 l_SI: TddGroupConfigItem;
//#UC END# *521B05DF00FC_5227066903AF_var*
begin
//#UC START# *521B05DF00FC_5227066903AF_impl*
 SplitCaption(Caption, l_P, l_S);
 if l_P = '' then
  Result := 0
 else
 begin
  l_Label := TvtLabel.Create(nil);
  try
   l_Label.Parent := aParent;
   l_Label.Caption := l_P;
   Result := l_Label.Width + c_ConfigItemLeft;
  finally
   FreeAndNil(l_Label);
  end;
 end;
 for I := 0 to Pred(Count) do
 begin
  l_SI := SubItem[I] as TddGroupConfigItem;
  for J := 0 to Pred(l_SI.Count) do
   if l_SI.SubItem[J].Labeled then
   if l_SI.SubItem[J] is TddContainerConfigItem then
   begin
    l_Label := TvtLabel.Create(nil);
    try
     l_Label.Parent := aParent;
     l_Label.Caption := l_SI.SubItem[J].Caption;
     Result := Max(Result, (l_Label.Width + c_ConfigItemLeft));
    finally
     FreeAndNil(l_Label);
    end;
   end
   else
    Result := Max(Result, l_SI.SubItem[J].LabelWidth(aParent));
 end;
//#UC END# *521B05DF00FC_5227066903AF_impl*
end;//TddContainerConfigItem.LabelWidth

procedure TddContainerConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5227066903AF_var*
var
 l_CheckBox: TvtCheckBox;
//#UC END# *521B07030052_5227066903AF_var*
begin
//#UC START# *521B07030052_5227066903AF_impl*
 if UseCheckBox then
 begin
  l_CheckBox := (Control as TvtCheckBox);
  l_CheckBox.Checked := Boolean(IntegerValue)
 end
 else
  (Control as TvtComboBoxQS).ItemIndex := IntegerValue;
 OnClick(Self);
 SetValueToSubitems(aDefault);
//#UC END# *521B07030052_5227066903AF_impl*
end;//TddContainerConfigItem.SetValueToControl

function TddContainerConfigItem.Add(aItem: TddBaseConfigItem): TddBaseConfigItem;
//#UC START# *52270B070394_5227066903AF_var*
//#UC END# *52270B070394_5227066903AF_var*
begin
//#UC START# *52270B070394_5227066903AF_impl*
 if SubItems.Count = 0 then
  AddCase(''{Caption});
 TddGroupConfigItem(SubItems.Items[Pred(SubItems.Count)]).Add(aItem)
//#UC END# *52270B070394_5227066903AF_impl*
end;//TddContainerConfigItem.Add

procedure TddContainerConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5227066903AF_var*
//#UC END# *552BB745031E_5227066903AF_var*
begin
//#UC START# *552BB745031E_5227066903AF_impl*
 inherited;
 if aControl is TvtCheckBox then
  TvtCheckBox(aControl).Enabled := TvtCheckBox(aControl).Enabled and not ReadOnly;
// if aControl is TvtComboBoxQS then
//  TvtComboBoxQS(aControl).ReadOnly := ReadOnly;
 if aControl is TvtComboBoxQS then
  TvtComboBoxQS(aControl).Enabled := TvtComboBoxQS(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_5227066903AF_impl*
end;//TddContainerConfigItem.AdjustReadOnly

procedure TddComboBoxConfigItem.pm_SetComboBoxStyle(aValue: TComboBoxStyle);
//#UC START# *5225983A0002_522461B00212set_var*
//#UC END# *5225983A0002_522461B00212set_var*
begin
//#UC START# *5225983A0002_522461B00212set_impl*
 f_ComboBoxStyle := aValue;
 if Assigned(Control) then
 begin
  Assert(Control is TvtComboBoxQS, Control.ClassName);
  TvtComboBoxQS(Control).Style := aValue;
 end;//Assigned(Control)
//#UC END# *5225983A0002_522461B00212set_impl*
end;//TddComboBoxConfigItem.pm_SetComboBoxStyle

procedure TddComboBoxConfigItem.pm_SetDropDownCount(aValue: Integer);
//#UC START# *5225988B0236_522461B00212set_var*
//#UC END# *5225988B0236_522461B00212set_var*
begin
//#UC START# *5225988B0236_522461B00212set_impl*
 f_DropDownCount := aValue;
//#UC END# *5225988B0236_522461B00212set_impl*
end;//TddComboBoxConfigItem.pm_SetDropDownCount

procedure TddComboBoxConfigItem.OnExit(Sender: TObject);
//#UC START# *5225991403D3_522461B00212_var*
//#UC END# *5225991403D3_522461B00212_var*
begin
//#UC START# *5225991403D3_522461B00212_impl*
 DoExit;
//#UC END# *5225991403D3_522461B00212_impl*
end;//TddComboBoxConfigItem.OnExit

procedure TddComboBoxConfigItem.DoExit;
//#UC START# *522599F1033C_522461B00212_var*
//#UC END# *522599F1033C_522461B00212_var*
begin
//#UC START# *522599F1033C_522461B00212_impl*
 // virtual
//#UC END# *522599F1033C_522461B00212_impl*
end;//TddComboBoxConfigItem.DoExit

constructor TddComboBoxConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 const aValueMap: Il3ValueMap = nil;
 aMasterItem: TddBaseConfigItem = nil;
 aMasterIndex: Integer = -1);
//#UC START# *52259A2E028E_522461B00212_var*
var
 l_Caption : AnsiString;
//#UC END# *52259A2E028E_522461B00212_var*
begin
//#UC START# *52259A2E028E_522461B00212_impl*
 l_Caption := aCaption;
 if (aMasterItem <> nil) then
  if (aMasterItem.Caption = l_Caption) OR
     (aMasterItem.Caption = l_Caption + ':') then
   l_Caption := '';
 inherited Create(aAlias, l_Caption, aDefaultValue, aValueMap, aMasterItem);
 if f_ValueKind = dd_vkBoolean then
  Assert((aMasterIndex=-1),'Unsupported params');
 f_DropDownCount := 8;
 f_ComboBoxStyle := csDropDownList;
 f_MasterIndex := aMasterIndex;
 Labeled := True;
//#UC END# *52259A2E028E_522461B00212_impl*
end;//TddComboBoxConfigItem.Create

function TddComboBoxConfigItem.pm_GetBooleanValue: Boolean;
//#UC START# *52161FC80131_522461B00212get_var*
//#UC END# *52161FC80131_522461B00212get_var*
begin
//#UC START# *52161FC80131_522461B00212get_impl*
 if (f_ValueKind = dd_vkBoolean) or (f_MasterIndex = -1) then
  Result := inherited pm_GetBooleanValue
 else
  if Control <> nil then
  begin
   Assert(Control is TvtComboBoxQS, Control.ClassName);
   Result := TvtComboBoxQS(Control).ItemIndex <> f_MasterIndex;
  end
  else
   Result := false;
//#UC END# *52161FC80131_522461B00212get_impl*
end;//TddComboBoxConfigItem.pm_GetBooleanValue

function TddComboBoxConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_522461B00212_var*
var
 lComboBox: TvtComboBoxQS;
//#UC END# *521B053F03C3_522461B00212_var*
begin
//#UC START# *521B053F03C3_522461B00212_impl*
 lComboBox := TvtComboBoxQS.Create(nil);
 try
  lComboBox.Parent := aParent;
  Result := lComboBox.Height;
 finally
  FreeAndNil(lComboBox);
 end;
//#UC END# *521B053F03C3_522461B00212_impl*
end;//TddComboBoxConfigItem.ControlHeight

function TddComboBoxConfigItem.DisplayNameContainer: Tl3Strings;
//#UC START# *52245D1400E9_522461B00212_var*
//#UC END# *52245D1400E9_522461B00212_var*
begin
//#UC START# *52245D1400E9_522461B00212_impl*
 if Assigned(Control) then
 begin
  Assert(Control is TvtComboBoxQS, Control.ClassName);
  Result := TvtComboBoxQS(Control).Items;
 end
 else
  Result := nil;
//#UC END# *52245D1400E9_522461B00212_impl*
end;//TddComboBoxConfigItem.DisplayNameContainer

function TddComboBoxConfigItem.Clone: Pointer;
//#UC START# *5301EC7500FF_522461B00212_var*
//#UC END# *5301EC7500FF_522461B00212_var*
begin
//#UC START# *5301EC7500FF_522461B00212_impl*
 Result := TddComboBoxConfigItem.Create(Alias, Caption, DefaultValue, ValueMap, MasterItem, f_MasterIndex);
 TddComboBoxConfigItem(Result).Assign(Self);
//#UC END# *5301EC7500FF_522461B00212_impl*
end;//TddComboBoxConfigItem.Clone

function TddComboBoxConfigItem.pm_GetControlClass: TControlClass;
//#UC START# *53A299B303CB_522461B00212get_var*
//#UC END# *53A299B303CB_522461B00212get_var*
begin
//#UC START# *53A299B303CB_522461B00212get_impl*
 Result := TvtComboBoxQS;
//#UC END# *53A299B303CB_522461B00212get_impl*
end;//TddComboBoxConfigItem.pm_GetControlClass

procedure TddComboBoxConfigItem.DoOnChange(aSender: TObject);
//#UC START# *53A29C9C00DA_522461B00212_var*
//#UC END# *53A29C9C00DA_522461B00212_var*
begin
//#UC START# *53A29C9C00DA_522461B00212_impl*
 if Control <> nil then
 begin
  Assert(Control is TvtComboBoxQS, Control.ClassName);
  ChangeSlaveStatus(TvtComboBoxQS(Control).ItemIndex <> f_MasterIndex);
 end;
 inherited;
//#UC END# *53A29C9C00DA_522461B00212_impl*
end;//TddComboBoxConfigItem.DoOnChange

procedure TddComboBoxConfigItem.SelectValue(aValue: Integer);
//#UC START# *53A29D070172_522461B00212_var*
//#UC END# *53A29D070172_522461B00212_var*
begin
//#UC START# *53A29D070172_522461B00212_impl*
 SelectedItemIndex := aValue;
//#UC END# *53A29D070172_522461B00212_impl*
end;//TddComboBoxConfigItem.SelectValue

function TddComboBoxConfigItem.pm_GetSelectedItemIndex: Integer;
//#UC START# *53A29D68029C_522461B00212get_var*
//#UC END# *53A29D68029C_522461B00212get_var*
begin
//#UC START# *53A29D68029C_522461B00212get_impl*
 Result := TvtComboBoxQS(Control).ItemIndex;
//#UC END# *53A29D68029C_522461B00212get_impl*
end;//TddComboBoxConfigItem.pm_GetSelectedItemIndex

procedure TddComboBoxConfigItem.pm_SetSelectedItemIndex(aValue: Integer);
//#UC START# *53A29D68029C_522461B00212set_var*
//#UC END# *53A29D68029C_522461B00212set_var*
begin
//#UC START# *53A29D68029C_522461B00212set_impl*
 TvtComboBoxQS(Control).ItemIndex := aValue;
//#UC END# *53A29D68029C_522461B00212set_impl*
end;//TddComboBoxConfigItem.pm_SetSelectedItemIndex

procedure TddComboBoxConfigItem.InitControl(aControl: TControl);
//#UC START# *53A2A16C0369_522461B00212_var*
//#UC END# *53A2A16C0369_522461B00212_var*
begin
//#UC START# *53A2A16C0369_522461B00212_impl*
 with TvtComboBoxQS(aControl) do
 begin
  OnChange := DoOnChange;
  Style := f_ComboBoxStyle;
  OnExit := Self.OnExit;
  DropDownCount := f_DropDownCount;
 end;
//#UC END# *53A2A16C0369_522461B00212_impl*
end;//TddComboBoxConfigItem.InitControl

function TddComboBoxConfigItem.pm_GetControlStrings: Il3StringsEx;
//#UC START# *53A3BE140327_522461B00212get_var*
//#UC END# *53A3BE140327_522461B00212get_var*
begin
//#UC START# *53A3BE140327_522461B00212get_impl*
 Result := TvtComboBoxQS(Control).Items as Il3StringsEx;
//#UC END# *53A3BE140327_522461B00212get_impl*
end;//TddComboBoxConfigItem.pm_GetControlStrings

procedure TddComboBoxConfigItem.AssignStringsToControl(const aStrings: Il3StringsEx);
//#UC START# *53A3D16C014B_522461B00212_var*
//#UC END# *53A3D16C014B_522461B00212_var*
begin
//#UC START# *53A3D16C014B_522461B00212_impl*
 TvtComboBoxQS(Control).Items.Assign(aStrings.Items);
//#UC END# *53A3D16C014B_522461B00212_impl*
end;//TddComboBoxConfigItem.AssignStringsToControl

procedure TddMapRadioGroupConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53A2A70E0369_var*
//#UC END# *479731C50290_53A2A70E0369_var*
begin
//#UC START# *479731C50290_53A2A70E0369_impl*
 FreeAndNil(f_ControlStrings);
 inherited;
//#UC END# *479731C50290_53A2A70E0369_impl*
end;//TddMapRadioGroupConfigItem.Cleanup

function TddMapRadioGroupConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_53A2A70E0369_var*
var
 l_Width: Integer;
//#UC END# *521761BB03DE_53A2A70E0369_var*
begin
//#UC START# *521761BB03DE_53A2A70E0369_impl*
 Result := inherited ConstructControl(aLeft, aMaxLeft, aTop, aParent);
 TRadioGroup(Control).Caption := Caption;
 with Result do
 begin
  Parent := aParent as TWinControl;
  Left := aLeft;
  Top := aTop;
  l_Width := aParent.ClientWidth - aLeft - c_ConfigItemRight;
  if (aParent is TScrollBox) then
   Dec(l_Width, c_ScrollBarWidth);
  Height := ControlHeight(aParent);
 end;
//#UC END# *521761BB03DE_53A2A70E0369_impl*
end;//TddMapRadioGroupConfigItem.ConstructControl

function TddMapRadioGroupConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_53A2A70E0369_var*
var
 l_Count: Integer;
 l_RadioButton: TRadioButton;
 l_RadioGroup: TRadioGroup;
 l_Index: Integer;
 l_HeaderHeight: Integer;
 l_ItemsHeight: Integer;
//#UC END# *521B053F03C3_53A2A70E0369_var*
begin
//#UC START# *521B053F03C3_53A2A70E0369_impl*
 if (ValueMap <> nil) then
  l_Count := ValueMap.MapSize
 else
  l_Count := f_MapValues.Count;

 Result := GetCanvas(aParent).TextHeight('A');
 Inc(Result, (l_Count + 2) * Result);

//#UC END# *521B053F03C3_53A2A70E0369_impl*
end;//TddMapRadioGroupConfigItem.ControlHeight

function TddMapRadioGroupConfigItem.DisplayNameContainer: Tl3Strings;
//#UC START# *52245D1400E9_53A2A70E0369_var*
//#UC END# *52245D1400E9_53A2A70E0369_var*
begin
//#UC START# *52245D1400E9_53A2A70E0369_impl*
 Result := f_ControlStrings;
//#UC END# *52245D1400E9_53A2A70E0369_impl*
end;//TddMapRadioGroupConfigItem.DisplayNameContainer

function TddMapRadioGroupConfigItem.pm_GetControlClass: TControlClass;
//#UC START# *53A299B303CB_53A2A70E0369get_var*
//#UC END# *53A299B303CB_53A2A70E0369get_var*
begin
//#UC START# *53A299B303CB_53A2A70E0369get_impl*
 Result := TRadioGroup;
//#UC END# *53A299B303CB_53A2A70E0369get_impl*
end;//TddMapRadioGroupConfigItem.pm_GetControlClass

function TddMapRadioGroupConfigItem.pm_GetSelectedItemIndex: Integer;
//#UC START# *53A29D68029C_53A2A70E0369get_var*
//#UC END# *53A29D68029C_53A2A70E0369get_var*
begin
//#UC START# *53A29D68029C_53A2A70E0369get_impl*
 Result := TRadioGroup(Control).ItemIndex;
//#UC END# *53A29D68029C_53A2A70E0369get_impl*
end;//TddMapRadioGroupConfigItem.pm_GetSelectedItemIndex

procedure TddMapRadioGroupConfigItem.pm_SetSelectedItemIndex(aValue: Integer);
//#UC START# *53A29D68029C_53A2A70E0369set_var*
//#UC END# *53A29D68029C_53A2A70E0369set_var*
begin
//#UC START# *53A29D68029C_53A2A70E0369set_impl*
 TRadioGroup(Control).ItemIndex := aValue;
//#UC END# *53A29D68029C_53A2A70E0369set_impl*
end;//TddMapRadioGroupConfigItem.pm_SetSelectedItemIndex

procedure TddMapRadioGroupConfigItem.InitControl(aControl: TControl);
//#UC START# *53A2A16C0369_53A2A70E0369_var*
//#UC END# *53A2A16C0369_53A2A70E0369_var*
begin
//#UC START# *53A2A16C0369_53A2A70E0369_impl*
 TRadioGroup(Control).OnClick := DoOnChange;
//#UC END# *53A2A16C0369_53A2A70E0369_impl*
end;//TddMapRadioGroupConfigItem.InitControl

function TddMapRadioGroupConfigItem.pm_GetControlStrings: Il3StringsEx;
//#UC START# *53A3BE140327_53A2A70E0369get_var*
//#UC END# *53A3BE140327_53A2A70E0369get_var*
begin
//#UC START# *53A3BE140327_53A2A70E0369get_impl*
 if (f_ControlStrings = nil) then
  f_ControlStrings := Tl3Strings.Create;
 f_ControlStrings.Assign(TRadioGroup(Control).Items);
 Result := f_ControlStrings as Il3StringsEx;
//#UC END# *53A3BE140327_53A2A70E0369get_impl*
end;//TddMapRadioGroupConfigItem.pm_GetControlStrings

procedure TddMapRadioGroupConfigItem.AssignStringsToControl(const aStrings: Il3StringsEx);
//#UC START# *53A3D16C014B_53A2A70E0369_var*
//#UC END# *53A3D16C014B_53A2A70E0369_var*
begin
//#UC START# *53A3D16C014B_53A2A70E0369_impl*
 TRadioGroup(Control).Items.Assign(aStrings.Items);
//#UC END# *53A3D16C014B_53A2A70E0369_impl*
end;//TddMapRadioGroupConfigItem.AssignStringsToControl

procedure TddContainerComboConfigItem.AddCase(const aCaseCode: AnsiString;
 const aCaption: AnsiString);
//#UC START# *5440C90D0156_5440C8300216_var*
var
 l_Group: TddGroupConfigItem;
//#UC END# *5440C90D0156_5440C8300216_var*
begin
//#UC START# *5440C90D0156_5440C8300216_impl*
 l_Group := TddGroupConfigItem.SimpleCreate(aCaseCode, aCaption);
 l_Group.ReadOnly := ReadOnly;
 l_Group.ShowCaption := False;
 l_Group.LabelTop := False;
 SubItems.Add(l_Group);
//#UC END# *5440C90D0156_5440C8300216_impl*
end;//TddContainerComboConfigItem.AddCase

procedure TddContainerComboConfigItem.ConstructSubItems(aLeft: Integer;
 aMaxLeft: Integer);
//#UC START# *5440C91D0309_5440C8300216_var*
var
 I: Integer;
 l_Top: Integer;
//#UC END# *5440C91D0309_5440C8300216_var*
begin
//#UC START# *5440C91D0309_5440C8300216_impl*
 l_Top := Control.Top + Control.Height;
 if aMaxLeft < aLeft then
  aMaxLeft := aLeft;
 SubItem[GetCaseIndex].CreateControl(aleft,aMaxLeft, l_Top, Control.Parent);
 // Нужно установить значения элементам. Кроме себя самого
 SetValueToSubitems(False);
//#UC END# *5440C91D0309_5440C8300216_impl*
end;//TddContainerComboConfigItem.ConstructSubItems

procedure TddContainerComboConfigItem.DestroySubItems;
//#UC START# *5440C9330208_5440C8300216_var*
var
 I: Integer;
//#UC END# *5440C9330208_5440C8300216_var*
begin
//#UC START# *5440C9330208_5440C8300216_impl*
 for I := 0 to Pred(Count) do
  if SubItem[I].Control <> nil then
  begin
   Control.Parent.RemoveControl(SubItem[I].Control);
   SubItem[I].Control.Free;
   SubItem[I].Control := nil;
   SubItem[I].ClearControl;
  end;
//#UC END# *5440C9330208_5440C8300216_impl*
end;//TddContainerComboConfigItem.DestroySubItems

procedure TddContainerComboConfigItem.OnClick(Sender: TObject);
//#UC START# *5440C95A017E_5440C8300216_var*
var
 l_True: Boolean;
//#UC END# *5440C95A017E_5440C8300216_var*
begin
//#UC START# *5440C95A017E_5440C8300216_impl*
 Lock;
 try
  l_True := pm_GetBooleanValue;
  ChangeSlaveStatus(l_True);
  if inherited pm_GetBooleanValue <> l_True then
   Changed := True;
  if l_True then
  begin
   if f_LastIndex <> -1 then
    SubItem[f_LastIndex].GetValueFromControl;
   DestroySubItems;
   ConstructSubItems(f_Left, f_MaxLeft);
   f_LastIndex := GetCaseIndex;
  end
  else
  begin
   DestroySubItems;
   f_LastIndex := -1;
  end;
 finally
  Unlock;
 end;
//#UC END# *5440C95A017E_5440C8300216_impl*
end;//TddContainerComboConfigItem.OnClick

function TddContainerComboConfigItem.GetCaseCode: AnsiString;
//#UC START# *5440C97000A7_5440C8300216_var*
//#UC END# *5440C97000A7_5440C8300216_var*
begin
//#UC START# *5440C97000A7_5440C8300216_impl*
 if Count = 0 then
  Result := ''
 else
  Result := TddGroupConfigItem(SubItems[TvtComboBoxQS(Control).ItemIndex]).Alias;
//#UC END# *5440C97000A7_5440C8300216_impl*
end;//TddContainerComboConfigItem.GetCaseCode

procedure TddContainerComboConfigItem.SetValueToSubItems(aDefault: Boolean);
//#UC START# *5440C9860018_5440C8300216_var*
var
 I: Integer;
//#UC END# *5440C9860018_5440C8300216_var*
begin
//#UC START# *5440C9860018_5440C8300216_impl*
 Exit;
{ if BooleanValue then
 begin
  I := GetCaseIndex;
  SubItem[I].Lock;
  SubItem[I].SetValueToControl(aDefault);
  SubItem[I].Unlock;
 end;}
//#UC END# *5440C9860018_5440C8300216_impl*
end;//TddContainerComboConfigItem.SetValueToSubItems

function TddContainerComboConfigItem.GetCaseIndex: Integer;
//#UC START# *5440E47601D2_5440C8300216_var*
//#UC END# *5440E47601D2_5440C8300216_var*
begin
//#UC START# *5440E47601D2_5440C8300216_impl*
 Result := TvtComboBoxQS(Control).ItemIndex;
//#UC END# *5440E47601D2_5440C8300216_impl*
end;//TddContainerComboConfigItem.GetCaseIndex

function TddContainerComboConfigItem.MayBeRequired: Boolean;
//#UC START# *521725C301A5_5440C8300216_var*
//#UC END# *521725C301A5_5440C8300216_var*
begin
//#UC START# *521725C301A5_5440C8300216_impl*
 Result := True;
//#UC END# *521725C301A5_5440C8300216_impl*
end;//TddContainerComboConfigItem.MayBeRequired

constructor TddContainerComboConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5440C8300216_var*
var
 l_Value : TddConfigValue;
//#UC END# *5217273F000F_5440C8300216_var*
begin
//#UC START# *5217273F000F_5440C8300216_impl*
 f_LastIndex := -1;
 with l_Value do
 begin
  Kind := dd_vkString;
  AsString := aDefaultValue.AsString;
 end;
 inherited Create(aAlias, aCaption, l_Value, aMasterItem);
 Labeled := False;
 ShowCaption := False;
//#UC END# *5217273F000F_5440C8300216_impl*
end;//TddContainerComboConfigItem.Create

procedure TddContainerComboConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5440C8300216_var*
var
 I: Integer;
//#UC END# *52172B72014C_5440C8300216_var*
begin
//#UC START# *52172B72014C_5440C8300216_impl*
 StringValue := l3Str(aStorage.ReadString(Alias, DefaultValue.AsString));
 for I := 0 to Pred(Count) do
  SubItem[I].Load(aStorage);
//#UC END# *52172B72014C_5440C8300216_impl*
end;//TddContainerComboConfigItem.LoadValue

procedure TddContainerComboConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5440C8300216_var*
var
 I: Integer;
//#UC END# *52172CA801E3_5440C8300216_var*
begin
//#UC START# *52172CA801E3_5440C8300216_impl*
 aStorage.WriteString(Alias, StringValue);
 for I := 0 to Pred(Count) do
  SubItem[I].Save(aStorage);
//#UC END# *52172CA801E3_5440C8300216_impl*
end;//TddContainerComboConfigItem.SaveValue

function TddContainerComboConfigItem.pm_GetLabeled: Boolean;
//#UC START# *5217600501C4_5440C8300216get_var*
var
 I, J: Integer;
 l_SI: TddGroupConfigItem;
//#UC END# *5217600501C4_5440C8300216get_var*
begin
//#UC START# *5217600501C4_5440C8300216get_impl*
 if f_InCreate then
  Result := Count > 1
 else
 begin
  Result := False;
  for I := 0 to Pred(Count) do
  begin
   l_SI := SubItem[I] as TddGroupConfigItem;
   for J := 0 to Pred(l_SI.Count) do
   if l_SI.SubItem[J].Labeled then
   begin
    Result := True;
    break;
   end;
   if Result then
    break;
  end;
 end;
//#UC END# *5217600501C4_5440C8300216get_impl*
end;//TddContainerComboConfigItem.pm_GetLabeled

procedure TddContainerComboConfigItem.AfterConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 theControl: TControl;
 theLabel: TvtLabel);
//#UC START# *521760C60369_5440C8300216_var*
//#UC END# *521760C60369_5440C8300216_var*
begin
//#UC START# *521760C60369_5440C8300216_impl*
 inherited;
 f_InCreate := False;
 f_LastIndex := -1;
//#UC END# *521760C60369_5440C8300216_impl*
end;//TddContainerComboConfigItem.AfterConstruct

procedure TddContainerComboConfigItem.BeforeConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl);
//#UC START# *5217612C01B6_5440C8300216_var*
//#UC END# *5217612C01B6_5440C8300216_var*
begin
//#UC START# *5217612C01B6_5440C8300216_impl*
 inherited;
 f_InCreate := True;
//#UC END# *5217612C01B6_5440C8300216_impl*
end;//TddContainerComboConfigItem.BeforeConstruct

function TddContainerComboConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5440C8300216_var*
var
 I: Integer;
 l_Height: Integer;
//#UC END# *521761BB03DE_5440C8300216_var*
begin
//#UC START# *521761BB03DE_5440C8300216_impl*
 f_Left := aLeft;
 f_MaxLeft := aMaxLeft;
 if Count > 0 then
 begin
  begin
   // Добавляем TvtComboBoxQS
   Result := TvtComboBoxQS.Create(aParent);
   aParent.InsertControl(Result);
   TvtComboBoxQS(Result).Style := csDropDownList;
   for I := 0 to Pred(SubItems.Count) do
    TvtComboBoxQS(Result).Items.Add(TddGroupConfigItem(SubItems.Items[I]).Caption);
   TvtComboBoxQS(Result).OnChange := OnClick;
  end;
  Result.Left := aLeft;
  Result.Top := aTop;
  if aParent is TScrollBox
   then Result.Width := aParent.ClientWidth - c_ConfigItemRight - aLeft - c_ScrollBarWidth
   else Result.Width := aParent.ClientWidth - c_ConfigItemRight - aLeft;

  if Hint <> '' then
  begin
   Result.Hint := Hint;
   Result.ShowHint := True;
  end;
 end
 else
  Result := nil;
//#UC END# *521761BB03DE_5440C8300216_impl*
end;//TddContainerComboConfigItem.ConstructControl

function TddContainerComboConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5440C8300216_var*
var
 I: Integer;
 l_Max: Integer;
//#UC END# *521B053F03C3_5440C8300216_var*
begin
//#UC START# *521B053F03C3_5440C8300216_impl*
 with TvtCheckBox.Create(nil) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
 // Нужно перебрать все наборы и выбрать самый высокий
 l_Max := 0;
 for I := 0 to Pred(Count) do
  l_Max := Max(l_Max, SubItem[I].FullControlHeight[aParent] + c_ConfigItemTop);
 Inc(Result, c_ConfigItemTop + l_Max);
//#UC END# *521B053F03C3_5440C8300216_impl*
end;//TddContainerComboConfigItem.ControlHeight

procedure TddContainerComboConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5440C8300216_var*
var
 I: Integer;
//#UC END# *521B058801FD_5440C8300216_var*
begin
//#UC START# *521B058801FD_5440C8300216_impl*
 assert(Control Is TvtComboBoxQS, Control.ClassName);
 StringValue := GetCaseCode;
 if BooleanValue then
 begin
  if SubItem[I].Control <> nil then
  begin
   SubItem[GetCaseIndex].GetValueFromControl;
   if SubItem[I].Changed then
    Changed := True;
  end;
 end;
//#UC END# *521B058801FD_5440C8300216_impl*
end;//TddContainerComboConfigItem.GetValueFromControl

function TddContainerComboConfigItem.LabelWidth(aParent: TWinControl): Integer;
//#UC START# *521B05DF00FC_5440C8300216_var*
var
 l_Label: TvtLabel;
 l_P, l_S: AnsiString;
 I, J: Integer;
 l_SI: TddGroupConfigItem;
//#UC END# *521B05DF00FC_5440C8300216_var*
begin
//#UC START# *521B05DF00FC_5440C8300216_impl*
 SplitCaption(Caption, l_P, l_S);
 if l_P = '' then
  Result := 0
 else
 begin
  l_Label := TvtLabel.Create(nil);
  try
   l_Label.Parent := aParent;
   l_Label.Caption := l_P;
   Result := l_Label.Width + c_ConfigItemLeft;
  finally
   FreeAndNil(l_Label);
  end;
 end;
 for I := 0 to Pred(Count) do
 begin
  l_SI := SubItem[I] as TddGroupConfigItem;
  for J := 0 to Pred(l_SI.Count) do
   if l_SI.SubItem[J].Labeled then
   if l_SI.SubItem[J] is TddContainerConfigItem then
   begin
    l_Label := TvtLabel.Create(nil);
    try
     l_Label.Parent := aParent;
     l_Label.Caption := l_SI.SubItem[J].Caption;
     Result := Max(Result, (l_Label.Width + c_ConfigItemLeft));
    finally
     FreeAndNil(l_Label);
    end;
   end
   else
    Result := Max(Result, l_SI.SubItem[J].LabelWidth(aParent));
 end;
//#UC END# *521B05DF00FC_5440C8300216_impl*
end;//TddContainerComboConfigItem.LabelWidth

procedure TddContainerComboConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5440C8300216_var*

 function lp_CaseIndex(const aCaseCode: AnsiString): Integer;
 var
  l_IDX: Integer;
 begin
  Result := -1;
  for l_IDX := 0 to SubItems.Count - 1 do
   if SameText(TddGroupConfigItem(SubItems[l_IDX]).Alias, aCaseCode) then
   begin
    Result := l_IDX;
    Break;
   end;
 end;

//#UC END# *521B07030052_5440C8300216_var*
begin
//#UC START# *521B07030052_5440C8300216_impl*
 (Control as TvtComboBoxQS).ItemIndex := lp_CaseIndex(StringValue);
 OnClick(Self);
 SetValueToSubitems(aDefault);
//#UC END# *521B07030052_5440C8300216_impl*
end;//TddContainerComboConfigItem.SetValueToControl

function TddContainerComboConfigItem.Add(aItem: TddBaseConfigItem): TddBaseConfigItem;
//#UC START# *52270B070394_5440C8300216_var*
//#UC END# *52270B070394_5440C8300216_var*
begin
//#UC START# *52270B070394_5440C8300216_impl*
 if SubItems.Count = 0 then
  AddCase('', ''{Caption});
 TddGroupConfigItem(SubItems.Items[Pred(SubItems.Count)]).Add(aItem)
//#UC END# *52270B070394_5440C8300216_impl*
end;//TddContainerComboConfigItem.Add

procedure TddContainerComboConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5440C8300216_var*
//#UC END# *552BB745031E_5440C8300216_var*
begin
//#UC START# *552BB745031E_5440C8300216_impl*
 inherited;
// if aControl is TvtComboBoxQS then
//  TvtComboBoxQS(aControl).ReadOnly := ReadOnly;
 if aControl is TvtComboBoxQS then
  TvtComboBoxQS(aControl).Enabled := TvtComboBoxQS(aControl).Enabled and not ReadOnly;
//#UC END# *552BB745031E_5440C8300216_impl*
end;//TddContainerComboConfigItem.AdjustReadOnly

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EddConfigError));
 {* Регистрация типа EddConfigError }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(EddInvalidValue);
 {* Регистрация EddInvalidValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
