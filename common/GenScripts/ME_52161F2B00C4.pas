unit ddAppConfigTypes;

interface

uses
 l3IntfUses
 , Controls
 , Forms
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
 , ComCtrls
 , l3VCLStrings
 , Contnrs
 , StdCtrls
 , Types
 , vtComboBoxQS
;

type
 IddMasterItem = interface
 end;//IddMasterItem
 
 IddConfigNode = interface
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
  procedure AddSlave(aSlave: TddBaseConfigItem);
  procedure RemoveSlave(aSlave: TddBaseConfigItem);
  procedure Changing;
  procedure DoEnabled;
  function MayBeRequired: Boolean;
  procedure ProcessNotify(const aValue: TddConfigValue);
  procedure Reset;
  procedure Create(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   aMasterItem: TddBaseConfigItem);
  procedure AddNotify(aItem: TddBaseConfigItem);
  procedure AssignValue(const aValue: TddConfigValue;
   aOnChange: Boolean);
   {* функция сравнения объекта с другим объектом.  Для перекрытия в потомках. }
  function HasValue(const anAlias: AnsiString;
   out theItem: TddBaseConfigItem): Boolean; overload;
  function HasValue(const anAlias: AnsiString): Boolean; overload;
  function IsLocked: Boolean;
  procedure Load(const aStorage: IddConfigStorage);
  procedure LoadValue(const aStorage: IddConfigStorage);
  procedure Lock;
  procedure Unlock;
  procedure RemoveNotify(aItem: TddBaseConfigItem);
  procedure ResetToDefault;
  procedure Save(const aStorage: IddConfigStorage);
  procedure SaveValue(const aStorage: IddConfigStorage);
  procedure ReadOnlyChanged;
 end;//TddBaseConfigItem
 
 TddButtonPlace = (
  dd_bpAsDefine
  , dd_bpBottomRight
 );//TddButtonPlace
 
 TMapValue = class(TddAppConfigBase)
 end;//TMapValue
 
 TMapValues = class(TddAppConfigBase)
  function IndexOfCaption(const aCaption: Il3CString): Integer;
  function IndexOfValue(const aValue: TddConfigValue): Integer;
  procedure Clear;
  procedure AddMapValue(const aCaption: AnsiString;
   const aValue: TddConfigValue);
  procedure Create(aKind: TddValueKind);
  procedure CheckValueType(aKind: TddValueKind);
 end;//TMapValues
 
 TddVisualConfigItem = class(TddBaseConfigItem)
  procedure AdjustLabel(theControl: TControl;
   theLabel: TvtLabel);
  procedure AfterConstruct(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   theControl: TControl;
   theLabel: TvtLabel);
  procedure BeforeConstruct(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl);
  procedure ChangeSlaveStatus(aEnabled: Boolean);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function CreateLabel(aParent: TWinControl;
   const aCaption: AnsiString;
   var aLeft: Integer;
   var aTop: Integer;
   aLabelType: TddConfigItemLabelType): TvtLabel;
  function GetCanvas(aParent: TWinControl): TCanvas;
  function GetForm(aParent: TWinControl): TCustomForm;
  procedure SplitCaption(const aCaption: AnsiString;
   out aPrefix: AnsiString;
   out aSuffix: AnsiString);
  function IsSame(anItem: TObject): Boolean;
  procedure ClearControl;
  function ControlHeight(aParent: TWinControl): Integer;
  function CreateControl(aLeft: Integer;
   aMaxLeft: Integer;
   aTop: Integer;
   aParent: TWinControl): TControl;
  procedure GetValueFromControl;
  function LabelHeight(aParent: TWinControl): Integer;
  function LabelWidth(aParent: TWinControl): Integer;
  function MinWidth(aParent: TWinControl): Integer;
  procedure SetValueToControl(aDefault: Boolean);
  procedure AdjustReadOnly(aControl: TControl);
 end;//TddVisualConfigItem
 
 TddIntegerConfigItem = class(TddVisualConfigItem)
  procedure Validate;
  procedure DoOnChange(Sender: TObject);
  procedure CreateItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefaultValue: Integer;
   aMasterItem: TddBaseConfigItem);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddIntegerConfigItem
 
 EddInvalidValue = class(EddConfigError)
  procedure CreateFmt(const aMsg: AnsiString;
   const Args: array of const;
   aItem: TddVisualConfigItem);
 end;//EddInvalidValue
 
 TddMapValueConfigItem = class(TddVisualConfigItem)
  procedure AddMapValue(const aCaption: AnsiString;
   const aValue: TddConfigValue); overload;
  procedure AddMapValue(const aCaption: AnsiString;
   aValue: Integer); overload;
  procedure AddMapValue(const aCaption: AnsiString;
   const aValue: AnsiString); overload;
  procedure Create(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   const aValueMap: Il3ValueMap;
   aMasterItem: TddBaseConfigItem);
  function DisplayNameContainer: Tl3Strings;
  function IsSet: Boolean;
  function CalcDisplayName(const aValue: TddConfigValue): AnsiString;
  function CalcValue(const aName: Il3CString): TddConfigValue;
  function DisplayNameToValue(const aName: Il3CString): TddConfigValue;
 end;//TddMapValueConfigItem
 
 RddBaseConfigItem = class of TddBaseConfigItem;
 
 TddRadioGroupConfigItem = class(TddIntegerConfigItem)
  procedure Add(const aItem: AnsiString);
 end;//TddRadioGroupConfigItem
 
 TddRadioConfigItem = class(TddVisualConfigItem)
  procedure CreateItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefaultValue: Boolean;
   aMasterItem: TddBaseConfigItem);
  procedure DoOnChange(Sender: TObject);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddRadioConfigItem
 
 TddGroupConfigItem = class(TddVisualConfigItem)
  procedure DoOnChange(Sender: TObject);
  function HeaderHeight(aParent: TWinControl): Integer;
  procedure SimpleCreate(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem);
  function ItemsLabelWidth(aParent: TWinControl;
   var aLeftLabeled: Integer): Integer;
  function Add(aItem: TddBaseConfigItem): TddBaseConfigItem;
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddGroupConfigItem
 
 TddFontConfigItem = class(TddVisualConfigItem)
  procedure FontButtonClick(Sender: TObject);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddFontConfigItem
 
 TddBaseStringsConfigItem = class(TddMapValueConfigItem)
  procedure DoOnChange(aSender: TObject);
  procedure CheckLoadItems;
  procedure SelectValue(aValue: Integer);
  procedure InitControl(aControl: TControl);
  procedure AssignStringsToControl(const aStrings: Il3StringsEx);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
  function DisplayNameContainer: Tl3Strings;
 end;//TddBaseStringsConfigItem
 
 RddBaseConfigNode = class of TddCustomConfigNode;
 
 TddCustomConfigNode = class(TddBaseConfigItem, IddConfigNode)
  procedure ItemChanged(Sender: TObject);
  procedure Create(const aAlias: AnsiString;
   const aCaption: AnsiString);
  function AddNode(const aAlias: AnsiString): TddCustomConfigNode; overload;
  function AddNode(const aAlias: AnsiString;
   const aCaption: AnsiString): TddCustomConfigNode; overload;
  function AddNode(aNode: TddCustomConfigNode): TddCustomConfigNode; overload;
  function IsRequired(out aMessage: AnsiString): Boolean;
  procedure PostEdit;
  procedure DoClearControls;
  function DoCreateFrame(aOwner: TComponent;
   aTag: Integer): TCustomFrame;
  procedure DoFrameSize(aParent: TWinControl;
   out aHeight: Integer;
   out aWidth: Integer);
  procedure DoGetControlValues;
  function DoIsItem(aItem: TObject): Boolean;
  procedure DoLoad(const aStorage: IddConfigStorage);
  procedure DoResetToDefault;
  procedure DoSave(const aStorage: IddConfigStorage);
  procedure DoSetControlValues(aDefault: Boolean);
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
 end;//TddCustomConfigNode
 
 TddBooleanConfigItem = class(TddVisualConfigItem, IddMasterItem)
  procedure OnClick(Sender: TObject);
  function BooleanValue: Boolean;
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddBooleanConfigItem
 
 TddButtonConfigItem = class(TddVisualConfigItem)
  procedure ButtonSize(aParent: TWinControl;
   out aSize: TSize);
  procedure Create(const anAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   aClick: TNotifyEvent;
   aMasterItem: TddBaseConfigItem);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddButtonConfigItem
 
 TddColorConfigItem = class(TddIntegerConfigItem)
 end;//TddColorConfigItem
 
 TddConfigChangedEvent = procedure(Sender: TddCustomConfigNode) of object;
 
 TddCheckListConfigItem = class(TddRadioGroupConfigItem)
 end;//TddCheckListConfigItem
 
 TddDividerConfigItem = class(TddVisualConfigItem)
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddDividerConfigItem
 
 TddAppConfigNode = class(TddCustomConfigNode)
  procedure Create(const aAlias: AnsiString;
   const aCaption: AnsiString);
  function AddItem(aItem: TddBaseConfigItem): TddBaseConfigItem;
  procedure DoClearControls;
  function DoCreateFrame(aOwner: TComponent;
   aTag: Integer): TCustomFrame;
  procedure DoGetControlValues;
  function DoIsItem(aItem: TObject): Boolean;
  procedure DoLoad(const aStorage: IddConfigStorage);
  procedure DoSave(const aStorage: IddConfigStorage);
  procedure DoSetControlValues(aDefault: Boolean);
 end;//TddAppConfigNode
 
 TddMasterSlaveConfigItem = class(TddGroupConfigItem)
  function CheckItem(const aAlias: AnsiString): Boolean;
  procedure OnChange(Sender: TObject);
  function FirstItem(aItemIndex: Integer): Integer;
  procedure ChangeItem;
  procedure AssignDataFromDetail;
  procedure AddStructureItem(aItem: TddBaseConfigItem);
  procedure AddCaption(const aCaption: AnsiString;
   const aAliasPrefix: AnsiString);
  function AddAlias(const aAlias: AnsiString): TddBaseConfigItem;
  procedure UpdateDataItems(aItemIndex: Integer);
 end;//TddMasterSlaveConfigItem
 
 TddContainerConfigItem = class(TddGroupConfigItem)
  function GetCaseIndex: Integer;
  procedure ConstructSubItems(aLeft: Integer;
   aMaxLeft: Integer);
  procedure DestroySubItems;
  procedure SetValueToSubitems(aDefault: Boolean);
  procedure AddCase(const aCaption: AnsiString);
  procedure OnClick(Sender: TObject);
  function UseCheckBox: Boolean;
 end;//TddContainerConfigItem
 
 TddComboBoxConfigItem = class(TddBaseStringsConfigItem, IddMasterItem)
  procedure OnExit(Sender: TObject);
  procedure DoExit;
  procedure Create(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   const aValueMap: Il3ValueMap;
   aMasterItem: TddBaseConfigItem;
   aMasterIndex: Integer);
  function BooleanValue: Boolean;
 end;//TddComboBoxConfigItem
 
 TddMapRadioGroupConfigItem = class(TddBaseStringsConfigItem)
 end;//TddMapRadioGroupConfigItem
 
 TddContainerComboConfigItem = class(TddGroupConfigItem)
  procedure AddCase(const aCaseCode: AnsiString;
   const aCaption: AnsiString);
  procedure ConstructSubItems(aLeft: Integer;
   aMaxLeft: Integer);
  procedure DestroySubItems;
  procedure OnClick(Sender: TObject);
  function GetCaseCode: AnsiString;
  procedure SetValueToSubItems(aDefault: Boolean);
  function GetCaseIndex: Integer;
 end;//TddContainerComboConfigItem
 
implementation

uses
 l3ImplUses
 , ddAppConfigTypesRes
 , l3String
 , DateUtils
 , l3Base
 , StrUtils
 , Math
 , vtSpinEdit
 , ExtCtrls
 , vtRadioButton
 , vtGroupBox
 , Dialogs
 , vtPanel
 , vtButton
 , vtCheckBox
 , CheckLst
 , l3Bits
 , ddAppConfigRes
 , l3Defaults
 , l3ValueMap
;

end.
