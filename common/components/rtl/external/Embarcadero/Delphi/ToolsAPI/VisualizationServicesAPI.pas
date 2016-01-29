{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit VisualizationServicesAPI;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Winapi.Windows,
  DesignIntf, ToolsAPI, Vcl.Graphics;

type
  TVGPropertyNames = class
  const
    ModelSettingsSection = 'Module Settings';
    ActiveLayerNames = 'ActiveLayerNames';
    EditingLayerName = 'EditingLayerName';
    ModelLayerNames = 'ModelLayerNames';
    Unknown = 'Unknown';
    Name = 'Name';
    DisplayName = 'DisplayName';
    Kind = 'Kind';
    LinkDir = 'LinkDir';
    Coordinates = 'Coordinates';
    MetaData = 'Metadata';
    BgColor ='BackgroundColor';
    FgColor = 'ForegroundColor';
    FooterColor = 'FooterColor';
    ExplicitSubNodes = 'ExplicitSubNodes';
    NodeLayerNames = 'LayerNames';
    Visible = 'Visible';
  end;

  TVGMenuContext = class
  const
    Unknown = 'UnknownContext';
    RightClick = 'RightClickContext';
    CreateLink = 'CreateLinkContext';
  end;

  TVGDirection = (vdUnknown, vdRightToLeft, vdLeftToRight, vdBidirectional);
  TVGElementKind = (vkUnknown, vkNode, vkSubNode, vkLink);
  TVGRouteValue = (vrRouteAllowed, vrRouteDisallowed, vrRouteOptions);
  TVGRouteIDValuePair = TPair<Integer, TVGRouteValue>;
  TVGElementState = (
    vcSelected,   // element is selected
    vcHidden,     // element is hidden
    vcHovered    // element is being hovered (node/subnodes only)
  );
  TVGElementStates = set of TVGElementState;
  TVGPersistentIDPair = TPair<TPersistent, Integer>;
  IVGModel = Interface;
  IVGElement = Interface
    ['{4813A017-C549-4CC1-997A-BC995A39A046}']
    function ToStr: string;
    function GetModel: IVGModel;
    property Model: IVGModel read GetModel;
    function GetDisplayName: string;
    function GetLayerNames: TArray<string>;
    procedure SetLayerNames(ANames: TArray<string>);
    procedure RemoveLayerName(const AName: string);
    procedure AddLayerName(const AName: string);
    function GetName: string;
    function GetId: Integer;
    function GetComponent: TComponent;
    function GetKind: TVGElementKind;
    property DisplayName: string read GetDisplayName;
    property LayerNames: TArray<string> read GetLayerNames write SetLayerNames;
    property Name: string read GetName;
    property Id: Integer read GetId;
    property Kind: TVGElementKind read GetKind;
    property Component: TComponent read GetComponent;
    function IsLink: Boolean;
    function IsNode: Boolean;
    function IsSubNode: Boolean;
    function IsCaption: Boolean;
    function IsElementKind(const AKind: TVGElementKind): Boolean;
    function IsExternal: Boolean;
  End;

  IVGLink = Interface(IVGElement)
    ['{F08902EA-CED2-4F41-AE32-ED6803A90C56}']
    function GetLeftNodeId: Integer;
    function GetLeftSubNodeId: Integer;
    function GetRightNodeId: Integer;
    function GetRightSubNodeId: Integer;
    property LeftNodeId: Integer read GetLeftNodeId;
    property LeftSubNodeId: Integer read GetLeftSubNodeId;
    property RightNodeId: Integer read GetRightNodeId;
    property RightSubNodeId: Integer read GetRightSubNodeId;
    function Direction: TVGDirection;
  End;

  IVGSubNode = Interface(IVGElement)
    ['{E014B935-3D98-4B6A-8DCA-74A35E331747}']
    function GetPersistent: TPersistent;
    function GetProperty: string;
    property PropertyName: string read GetProperty;
    property Persistent: TPersistent read GetPersistent;
  End;

  IVGCaption = Interface(IVGElement)
    ['{99E30750-6366-4824-9D75-FF308EF7EACE}']
    function GetEmbedded: TComponent;
    property Embedded: TComponent read GetEmbedded;
  End;

  IVGNode = Interface(IVGElement)
    ['{602A8704-B020-40C8-B689-2F1E2F64CA44}']
    procedure SetDisplayName(const AName: string);
    procedure SetName(const AName: string);
  End;

  IVGElementEnumerator = interface
    ['{FB21362B-BDFA-4297-A0A3-EF3A2F501FF3}']
    procedure First;
    function GetCurrent: IVGElement;
    function MoveNext: Boolean;
    property Current: IVGElement read GetCurrent;
  end;

  IVGMenuItem = Interface
    ['{F3ACC26B-C4F1-4656-B3CA-A968D68A033D}']
    function CategoryName: string;
    function CaptionName: string;
    function ShortcutKey: string;
    function Enabled: Boolean;
    procedure Execute;
  End;

  IVGShortcutItem = Interface
    ['{760738D6-9108-4A43-B0A5-E17F84A30158}']
    function GetImageIndex: Integer;
    function GetHint: string;
    function GetEnabled: Boolean;
    procedure Execute;
  End;

  IVGModule = Interface;
  IVGModel = Interface
    ['{7527CE30-FAC1-4D52-8153-7717F8A30BAE}']
    // Returns a string representiaton of the current cached model
    function ToStr: string;
    function GetModule: IVGModule;
    function GetShortcuts: TArray<IVGShortcutItem>;
    function ElementCount: Integer;
    function GetElementIDs: TArray<Integer>;
    function GetComponents: TArray<TComponent>;
    function GetNodeCount: Integer;
    function GetNodeID(const AIndex: Integer): Integer;
    function GetSubNodeParentID(const ASubNodeID: Integer): Integer;
    function GetSubNodeCount(const ANodeID: Integer): Integer;
    function GetSubNodeID(const ANodeID: Integer; const AIndex: Integer): Integer;
    function GetEmbeddedID(const ANodeID: Integer): TArray<Integer>;
    function GetLinkCount: Integer;
    function GetLinkID(const AIndex: Integer): Integer;
    function GetLinkSourceID(const ALinkID: Integer): Integer;
    function GetLinkDestinationID(const ALinkID: Integer): Integer;
    function GetProperty(const AElementID: Integer; const AProperty: string): string;
    procedure SetProperty(const AElementId: Integer; const AProperty: string; const APropertyValue: string);
    function FindElement(const AElementID: Integer): IVGElement;
    //Ids for all Node, SubNode, or Link elements
    function FindElementIds(const AComponent: TComponent): TArray<Integer>; overload;
    //Links components may have multiple links with unique IDs
    function FindLinkIds(const AComponent: TComponent): TArray<Integer>;
    function FindNodeId(const AComponent: TComponent): Integer; overload;
    function FindNodeId(const ADisplayName: string): Integer; overload;
    function FindSubNodeId(const ANode: TComponent; const ASubNodeName: string): Integer; overload;
    function FindSubNodeId(const APersistent: TPersistent): Integer; overload;
    function FindPersistent(AComponent: TComponent; APersistent: TArray<TPersistent>): TArray<TVGPersistentIDPair>; overload;
    function FindPersistent(APersistent: TArray<TPersistent>): TArray<TVGPersistentIDPair>; overload;
    function IsSubNodeMember(const ANode: TComponent; const ASubNodeName: string): Integer;
    function IsLinkType(const AComponent: TComponent): Boolean;
    function CanAddLink(const ASrcID, ADestID: Integer): TVGRouteValue;
    function CanAddLinks(const ASrcID: Integer; ADestIDs: TArray<Integer>): TArray<TVGRouteIDValuePair>;
    function CanRerouteLink(const ALinkID, AFromElementID, AToElementID: Integer): TVGRouteValue;
    procedure RerouteLink(const ALinkID, AFromElementID, AToElementID: Integer);
    procedure AddLink(const ASrcID, ADestID: Integer);
    function IsLinked(const ANode: TComponent): Boolean; overload;
    function IsLinked(const ANode: TComponent; const ASubNodeName: string): Boolean; overload;
    function GetLinks(const ANode: TComponent): TArray<Integer>; overload;
    function GetLinks(const ANode: TComponent; const ASubNodeName: string): TArray<Integer>; overload;
    function IsElementVisible(AElementID: Integer): Boolean;
    function IsDefaultVisible(AElementID: Integer): Boolean;
    procedure ShowElement(const AElementID: Integer; APersist: Boolean);
    procedure HideElement(const AElementID: Integer; APersist: Boolean);
    procedure RestoreDefaultVisibility(const AElementID: Integer);
    procedure AddLayerName(const AName: string);
    procedure RemoveLayerName(const AName: string);
    function GetLayerNames: TArray<string>;
    procedure SetActiveLayerNames(ANames: TArray<string>);
    function GetActiveLayerNames: TArray<string>;
    procedure SetEditingLayerName(const AName: string);
    function GetEditingLayerName: string;
    procedure FooterClicked(const ANodeID: Integer);
    procedure SelectBindableDestination(const ASourceSubNodeId, ADestinationNodeId: Integer);
    function GetMenuItems(const AParentOrigin: TPoint; const AMenuContext: string; const AContextIDs: TArray<Integer>): TArray<IVGMenuItem>;

    // Check whether the cached model is out of sync with its module designer
    //function NeedsReload: Boolean;
    // Check if the model contains changes in its delta for updating the drawing
    function IsModified: Boolean;
    procedure Loaded;
    procedure Prepare;
    function GetAddedCount: Integer;
    function GetAddedElementID(const AIndex: Integer): Integer;
    function GetRemovedCount: Integer;
    function GetRemovedElementID(const AIndex: Integer): Integer;
    function GetChangedCount: Integer;
    function GetChangedElementID(const AIndex: Integer): Integer;
    procedure AddElement(const AComponent: TComponent);
    procedure RemoveElement(const AComponent: TComponent);
    procedure ElementChanged(const AComponent: TComponent); overload;
    procedure ElementChanged(const AElementId: Integer); overload;
    procedure ElementAdded(const AElement: IVGElement);
    procedure ElementRemoved(const AElementId: Integer);
    procedure ColorChanged(const AElementId: Integer);
    procedure ElementsSelected(AElemIds: TArray<Integer>);
    procedure SelectElements(AElemIds: TArray<Integer>);
    procedure ElementHovered(const AElementId: Integer);
    procedure InitNewLink(AElementId: Integer; SelectForBinding: Boolean);
    procedure InitRerouteLink(const ALinkId, ASrcId, ADestId: Integer);
    function SelectedElements: TArray<Integer>;
    procedure AddSubNode(const ANode: TComponent; const ASubNodeName: string; const APersistent: TPersistent; const IsPersisted: Boolean);
    procedure RemoveSubNode(const ANode: TComponent; const ASubNodeName: string);
  End;

  IVGDataAdmin = Interface
    ['{EF2B1AE6-9592-41A3-B605-D549262FA4A9}']
    function GetConfigData: TStrings;
    procedure SetConfigData(const AData: TStrings);
    function GetFileName: string;
    function UpdateProperty(const ASectionName: string; const AProperty: string; APropertyValue: string): Boolean;
    function GetProperty(const ASectionName, AProperty, ADefault: string): string;
    procedure ClearProperty(const ASectionName: string; const AProperty: string);
    procedure RenameSection(const AOldSectionName, ANewSectionName: string);
    procedure SaveChanges;
    property FileName: string read GetFileName;
    property ConfigData: TStrings read GetConfigData write SetConfigData;
  End;

  // Every module (with a designer) opened will need one of these
  // each module will probably have one IVGModel
  IVGModule = Interface
    ['{4634A103-2379-46DD-9ACA-6C2B4BDD4848}']
    function Designer: IDesigner;
    function HasDesigner: Boolean;
    procedure ModuleModified;
    procedure ModuleSaved;
    procedure ModuleBeforeRename(const AOldName, ANewName: string);
    procedure ModuleBeforeSave;
    procedure ModuleRenamed(const ANewName: string);
    procedure DesignerActivated;
    procedure DesignerClosed;
    function HasComponent(const AModel: IVGModel; const AComponent: TComponent): Boolean;
    procedure ComponentRenamed(const AComponent: TComponent; const ANewName: string);
    procedure ComponentChanged(const AComponent: TComponent);
    procedure ComponentAdded(const AComponent: TComponent);
    procedure ComponentRemoved(const AComponent: TComponent);
    procedure ComponentsSelected(AComponents: TArray<TPersistent>);
    procedure ExternalComponentChanged(const AComponent: TComponent);
    procedure ExternalComponentRenamed(const AComponent: TComponent; const ANewName: string);
    procedure ExternalComponentAdded(const AComponent: TComponent);
    procedure ExternalComponentRemoved(const AComponent: TComponent);
    function GetProperty(const AName: string; const AProperty: string; const ADefault: string): string;
    procedure SetProperty(const AName: string; const AProperty: string; const APropertyValue: string);
    procedure ClearProperty(const AName: string; const AProperty: string);
    // To be called before model is about to be updated/loaded/refreshed
    procedure Prepare;
    // To be called after model is updated/loaded/refreshed
    procedure Loaded;
    function GetAddedCount: Integer;
    function GetAddedElementID(const AIndex: Integer): Integer;
    function GetRemovedCount: Integer;
    function GetRemovedElementID(const AIndex: Integer): Integer;
    function GetChangedCount: Integer;
    function GetChangedElementID(const AIndex: Integer): Integer;
    function IsModified: Boolean;
    function GetModel: IVGModel;
    function LockSelection: Boolean;
    procedure UnlockSelection;
    function GetDataAdmin: IVGDataAdmin;
    // This reloads the module in its current state
    procedure Reload;
    // This instantiates a new model based on the current module
    function MakeModel: IVGModel;
    function GetPairedId(const AObject: TObject): Integer; overload;
    function GetPairedId(const AComponent: TComponent; const AMember: string): Integer; overload;
    function FindPairedSubNode(const AElementId: Integer): TPair<TObject,string>;
  End;

  // The handler specifies graph specific details like file extension and
  //  creates a IVGModule for every unit
  IVGHandler = Interface
    ['{7F7F3B6A-57DF-4E56-8ECF-AB6993E5AE11}']
    function GetGraphIdentifier: string;
    function GetGraphFileExtension: string;
    function AddModule(const ADesigner: IDesigner; const ASourceModule: IOTAModule): IVGModule;
    function GetModule(const ADesigner: IDesigner): IVGModule;
    procedure RemoveModule(const ADesigner: IDesigner);
    function GetModules: TArray<IVGModule>;
    function GetCurrentModule: IVGModule;
    procedure SetCurrentModule(const AModule: IVGModule);
    property CurrentModule: IVGModule read GetCurrentModule write SetCurrentModule;
  End;

  IVGDrawing = Interface
    ['{95F5ABCC-5920-4E7C-9B92-7A716ED0D352}']
    procedure LayoutNodes;
    procedure RecolorModel(AElements: TArray<Integer>);
    procedure UpdateDrawing;
    function GetActiveLayers: TArray<string>;
    procedure SetEditLayer(const ALayerName: string);
    function GetEditLayer: string;
    property EditLayer: string read GetEditLayer write SetEditLayer;
    function AddNewLayer: string;
    procedure ActivateLayer(const ALayerName: string);
    procedure DeactivateLayer(const ALayerName: string);
    procedure RefreshLayers;
    function GetActiveDesigner: string;
    procedure SetActiveDesigner(const ALayerName: string);
    procedure HideElement(const AElementId: Integer);
    procedure ShowElement(const AElementId: Integer);
    procedure ScrollToElement(const AElementId: Integer);
    function AddImage(const ABitmap: TBitmap): Integer;
    procedure InitNewLink(const ASrcId: Integer);
    // used to determine or change active views of the drawing if any (blank is default)
    property ActiveLayers: TArray<string> read GetActiveLayers;
    property ActiveDesigner: string read GetActiveDesigner write SetActiveDesigner;
  End;

  IVisualizationService = Interface
    ['{66C2DF99-87FD-41D9-9894-21D14D256F7A}']
    procedure DeleteGroup(const AGroupNum: Integer);
    procedure RegisterDrawingControl(const ADrawing: IInterface);
    procedure UnregisterDrawingControl(const ADrawing: IInterface);
    function GetDrawingControl: IVGDrawing;
    procedure FocusDrawing;

    // for supporting custom graph plugins like LiveBindings graph
    procedure RegisterGraphHandler(const AGraphHandler: IVGHandler);
    procedure UnregisterGraphHandler(const AGraphHandler: IVGHandler);
    function ActiveGraph: IVGHandler;
    procedure ActivateGraph(const AGraphHandlerId: string);
    procedure ClearActiveGraph;
    function GetGraphIds: TArray<string>;

    // for graph plugins to call when they would like to activate a new
    //  model for drawing.  for example, on form activation, this can be
    //  pushed for the current form.  otherwise, it can be done on other
    //  scenarios as needed
    procedure ActivateModule(const AModule: IVGModule);
    // used to retrieve active model showing if any
    function ActiveModel: IVGModel;
    function VGDirToLBDir(const ALinkDir: TVGDirection): string;
    function VGElementKindToLBPropertyValue(const AElementKind: TVGElementKind): string;
  End;

function VisualizationService: IVisualizationService;

implementation

function VisualizationService: IVisualizationService;
begin
  Supports(BorlandIDEServices, IVisualizationService, Result);
end;

end.
