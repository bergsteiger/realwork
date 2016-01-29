unit ddAppConfig;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 , l3ProtoObject
 , StdCtrls
 , Classes
 , ddAppConfigConst
 , ddAppConfigStrings
 , Forms
 , vtOutliner
 , ddConfigStorages
 , l3ObjectList
 , ddAppConfigVersions
 , ddAppConfigWFrame
 , Controls
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
  procedure Create(const aStorage: IddConfigStorage);
  function FindNode(aItem: TddBaseConfigItem): TddCustomConfigNode;
  procedure Add(const aItemName: AnsiString);
  procedure AddAlias(const aAlias: AnsiString);
  function AddBooleanItem(const aAlias: Il3CString;
   const aCaption: Il3CString;
   aDefault: Boolean;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddButtonItem(const aCaption: AnsiString;
   aClick: TNotifyEvent;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  procedure AddCaptionElement(const aCaption: AnsiString;
   const aAliasPrefix: AnsiString);
  function AddChild(const aAlias: AnsiString;
   const aCaption: AnsiString): TddCustomConfigNode; overload;
  function AddChild(const aCaption: AnsiString): TddCustomConfigNode; overload;
  function AddColorItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefault: TColor;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddComboBoxItem(const aAlias: Il3CString;
   const aCaption: Il3CString;
   aDefaultValue: Integer;
   const aValueMap: Il3ValueMap;
   aMasterItem: TddBaseConfigItem;
   aMasterIndex: Integer): TddBaseConfigItem; overload;
  function AddComboBoxItem(const aAlias: Il3CString;
   const aCaption: Il3CString;
   const aDefaultValue: Il3CString;
   const aValueMap: Il3ValueMap;
   aMasterItem: TddBaseConfigItem;
   aMasterIndex: Integer): TddBaseConfigItem; overload;
  function AddComboBoxItem(const aAlias: Il3CString;
   const aCaption: Il3CString;
   const aDefaultValue: TddConfigValue;
   const aValueMap: Il3ValueMap;
   aMasterItem: TddBaseConfigItem;
   aMasterIndex: Integer): TddBaseConfigItem; overload;
  function AddDateItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefault: TDateTime;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddFileNameItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefault: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddFolderNameItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefault: AnsiString;
   aMasterItem: TddBaseConfigItem;
   AllowProcessDir: Boolean): TddBaseConfigItem;
  function AddFontItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefault: TFont;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddGroupItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem; overload;
  function AddIntegerItem(const aAlias: Il3CString;
   const aCaption: Il3CString;
   aDefault: Integer;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddItem(aNode: TddCustomConfigNode;
   aItem: TddBaseConfigItem): TddBaseConfigItem; overload;
  function AddItem(aItem: TddBaseConfigItem): TddBaseConfigItem; overload;
  function AddListItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDataAdapter: TddBaseConfigDataAdapter;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddStringsItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  procedure AddMapValue(const aCaption: AnsiString;
   aValue: Integer);
  function AddNode(const aAlias: AnsiString;
   const aText: AnsiString): TddCustomConfigNode; overload;
  function AddRadioGroupItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefault: Integer;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddSoundFileNameItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefault: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddTimeItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefault: TDateTime;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddStringItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefault: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  function AddMasterSlaveItem(const Alias: AnsiString;
   const aCaption: AnsiString): TddBaseConfigItem;
  function AddCheckListItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDefault: Integer;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  procedure AddDivider(const aCaption: AnsiString);
  function AddGroupItem(const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem; overload;
  function AddContainerGroup(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  procedure AddVersionHandler(aFromVersion: Integer;
   aToVersion: Integer;
   aProc: Tdd_acVersionUpgradeProc);
  function AddSimpleListItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem): TddBaseConfigItem;
  procedure CloseMasterSlaveItem;
  procedure AddUserNode(aNode: TddCustomConfigNode;
   AsChild: Boolean);
  procedure AdjustFormSize(aForm: TCustomForm;
   aOptions: TddAppDialogOptions);
  procedure ClearNode;
  procedure CloseChild;
  procedure CloseGroup;
  procedure MakeNodeVisible(aNode: TddCustomConfigNode);
  procedure FillDialog(aForm: TCustomForm;
   aOptions: TddAppDialogOptions;
   aCaptionPanelTypes: TddCaptionPanelTypes);
  function GetAliasName(const aAliasMask: AnsiString): AnsiString;
   {* Проверяет наличие элемента с указанным псевдонимом }
  function HasValue(const aAlias: AnsiString): Boolean; overload;
  function HasValue(const aAlias: AnsiString;
   out theItem: TddBaseConfigItem): Boolean; overload;
  procedure Load(const aStorage: IddConfigStorage);
  function ReadValuesFromDialog(aRead: Boolean): Boolean;
  procedure ReloadDefault;
  procedure Save(const aStorage: IddConfigStorage);
  function ShowDialog(const aCaption: AnsiString;
   aValidate: Boolean): Boolean;
  function ShowNodeDialog(const aAlias: AnsiString): Boolean;
  procedure DialogCloseQuery(Sender: TObject;
   var CanClose: Boolean);
  procedure SetReadOnly(aValue: Boolean);
 end;//TddAppConfiguration
 
 IddCNode = interface(Il3Base)
 end;//IddCNode
 
 TddCNode = class(Tl3UsualNode, Il3Node, IddCNode)
  procedure Create(aNode: TddCustomConfigNode);
  function Make(aNode: TddCustomConfigNode): Il3Node;
  function Control: TddCustomConfigNode;
 end;//TddCNode
 
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
 , Dialogs
 , l3Defaults
 , l3TreeInterfaces
 , l3String
 , ddIniStorage
 , ddAppConfigTFrame
 , ddAppConfigBFrame
 , vtVerInf
 , afwVCL
 , l3Base
 , multimon
 , l3Nodes
;

end.
