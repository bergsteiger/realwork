{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit PaletteAPI;

{ Component Palette / ToolBox API }

interface

uses System.Classes, ToolsAPI, Vcl.Graphics, Winapi.ActiveX, Vcl.Menus, Vcl.GraphUtil;

type
  TNTAPaintIconSize = (pi16x16, pi24x24, pi32x32);

  { INTAPalettePaintIcon }
  { Palette items which implement INTAPalettePaintIcon will be called to paint
    their icon to the given Canvas. }
  INTAPalettePaintIcon = interface
    ['{D9BAD01A-99D9-4661-A470-90C7BC743DC9}']
    procedure Paint(const Canvas: TCanvas; const X, Y: Integer;
      const IconSize: TNTAPaintIconSize);
  end;

  INTAPalettePaintIcon160 = interface(INTAPalettePaintIcon)
    ['{EAF90D7D-0C59-4B90-AF44-EE525719EEFC}']
    procedure Paint(const Canvas: TCanvas; const X, Y: Integer;
      const IconSize: TNTAPaintIconSize; Enabled: Boolean); overload;
  end;

  { TPalDragState: same as QControls.TDragState and Controls.TDragState.
    Added here for a more generic TDragState. }
  TPalDragState = (pdsDragEnter, pdsDragLeave, pdsDragMove);

  { IOTAPaletteDragAcceptor }
  { Register your IOTAPaletteDragAcceptor to mark that window
    as acceptable for a drop target from the Palette. Handle
    is topmost parent handle for your accepting window.

    You can either use this, or register your window as an OLE drop target
    and implement the IOTAPaletteOleDragDropOp interface to fill in the
    OLE IDataObject drag and drop interface that will be "dragged over" the window.
   }
  IOTAPaletteDragAcceptor = interface
    ['{44E0BDCA-EEDD-45A5-8170-A764D9E26056}']
    function GetHandle: THandle;
    property Handle: THandle read GetHandle;
  end;

  { IOTADesignerDragAcceptor }
  { Use this interface to see if your item is being dragged over
    the VCL designer. }
  IOTADesignerDragAcceptor = interface(IOTAPaletteDragAcceptor)
    ['{0047B6A0-D238-4627-8EBD-9F66A57CF2F5}']
  end;


  { IOTACodeEditorDragAcceptor }
  { Use this interface to see if your item is being dragged over the code
    editor. }
  IOTACodeEditorDragAcceptor = interface(IOTAPaletteDragAcceptor)
    ['{7A8E3301-46A6-4226-9B8F-0BCEC7E9E801}']
    function GetEditorControl: TObject;
    { Returns the EditorControl object for this acceptor. You can only
     access this if you are NTA, however, the interface query is valid for OTA. }
    property EditorControl: TObject read GetEditorControl;
  end;
  
  { TOTAPaletteDragDropOp }
  { If your Palette Item implements this interface, DragOver will
    be called when the item is dragged over something that supports
    items being dropped on it, such as the Code Editor or
    Designer.  If the item was droped there, DragDrop will be called
    for the item. }
  IOTAPaletteDragDropOp = interface
    ['{A6364D92-37AB-4C39-ACA3-4CB1F8BD0C94}']
    procedure DragOver(Target: IOTAPaletteDragAcceptor; X, Y: Integer;
      State: TPalDragState; var Accept: Boolean);
    procedure DragDrop(Target: IOTAPaletteDragAcceptor; X, Y: Integer);
  end;

  { IOTAPaletteOleDragDropOp }
  { If your Palette Item implementes this interface, it will be called
    to fill in the OLE IDataObject that will be dragged around.
    This is required for designers or windows that use OLE drag and drop. }
  IOTAPaletteOleDragDropOp = interface
    ['{5B524357-BB75-4C8A-B88F-954075A60FFD}']
    { Provides the TFormatEtc indicating the data that the IDataObject
      will contain. }
    function GetFormatRec: TFormatEtc;
    { Allows you to return true if you return data in the SourceFormat }
    function QueryGetData(const SourceFormat: TFormatEtc): Boolean;
    { Allows you to fill in the Medium with the requested SourceFormat } 
    function GetData(const SourceFormat: TFormatEtc; out Medium: TStgMedium): Boolean;
  end;

  { IOTAPaletteCursor }
  { Implement this interface to set the cursor when the palette item is dragged onto a designer.
    WebForms uses this interface. }
  IOTAPaletteCursor = interface
    ['{26DDEB04-1FFC-45B0-98E7-02AD8706AF70}']
    function SetCursor: Boolean;
  end;

  { IOTABasePaletteItem }
  { A base bare minimum item on the component palette. Base interface
    for other items. }
  IOTABasePaletteItem = interface
    ['{9CAEBEBF-6BFB-4E9A-B5E7-C3146DEFA6E8}']
    function GetCanDelete: Boolean;
    function GetEnabled: Boolean;
    function GetHelpName: string;
    function GetHintText: string;
    function GetIDString: string;
    function GetName: string;
    function GetVisible: Boolean;
    procedure SetEnabled(Value: Boolean);
    procedure SetHelpName(const Value: string);
    procedure SetName(const Value: string);
    procedure SetVisible(const Value: Boolean);
    procedure SetHintText(const Value: string);
    { If this item can be deleted (permanently), return true.
      When Delete is called, you should remove the item (permanently) }
    property CanDelete: Boolean read GetCanDelete;
    property Enabled: Boolean read GetEnabled;
    { HelpName: used for displaying a help page for this item }
    property HelpName: string read GetHelpName write SetHelpName;
    { HintText: The tool tip that is displayed for this item }
    property HintText: string read GetHintText write SetHintText;
    { IDString: uniquely identifies the item, and never changes }
    property IDString: string read GetIDString;
    { Name: the display name for a given item }
    property Name: string read GetName write SetName;
    { Visible: if the item should be shown or not. Items should
      be hidden when they are not valid for the current designer. Hidden
      items may be shown when customizing the palette. }
    property Visible: Boolean read GetVisible write SetVisible;
    { Execute: call it when you want this item to create itself
      or execute its action. Groups will do nothing. Palette items
      will typically create themselves. }
    procedure Execute;
    { Delete is called when an item is removed from the IDE permanently.
      CanDelete should be checked before calling Delete. }
    procedure Delete;
  end;

  { IOTAGetPaletteItem }
  { This interface is used to get a palette item from an IDataObject during
    ole drag drop processing }
  IOTAGetPaletteItem = interface
    ['{ED77C99B-5994-4C8B-92BB-CB72B3BEEBD9}']
    function GetPaletteItem: IOTABasePaletteItem;
  end;

  { IOTAExecutePaletteItem }
  { Modules implement this interface if they support execution of a palette item.
    This interface is used when a snippet is double clicked. }
  IOTAExecutePaletteItem = interface
    ['{70FAFCB8-EE3D-487F-B546-00E002AA7027}']
    procedure ExecutePaletteItem(Item: IOTABasePaletteItem);
  end;

  { IOTAComponentPaletteItem }
  IOTAComponentPaletteItem = interface(IOTABasePaletteItem)
    ['{5A1A13FD-48B6-4A76-BB3F-374102172767}']
    procedure SetPackageName(const Value: string);
    procedure SetClassName(const Value: string);
    procedure SetUnitName(const Value: string);

    function GetClassName: string;
    function GetPackageName: string;
    function GetUnitName: string;
    { ClassName: the classname of the item. May be different, or the
      same thing as the Name. }
    property ClassName: string read GetClassName write SetClassName;
    { PackageName: the base package that this item exists in. }
    property PackageName: string read GetPackageName write SetPackageName;
    { UnitName: the full unit name that contains the given item.
      It may be blank for items that don't have units (such as templates) }
    property UnitName: string read GetUnitName write SetUnitName;
  end;

  { IOTAPaletteGroup }
  { Each group can contain regular palette items and/or other
    groups. If the Item is a IOTAPaletteGroup, it is a subgroup. }
  IOTAPaletteGroup = interface(IOTABasePaletteItem)
    ['{C7593CE8-1A0B-409F-B21F-84D983593F77}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): IOTABasePaletteItem;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: IOTABasePaletteItem read GetItem; default;

    { AddGroup: adds a new sub-group to this group, or returns an existing
      group if IDString was already found. }
    function AddGroup(const Name, IDString: string): IOTAPaletteGroup;
    { AddItem: adds an item and returns its current index. The current
      index may change if an item is deleted before it. }
    function AddItem(const Item: IOTABasePaletteItem): Integer;
    procedure Clear;
    { FindItem*: for locating particular items. If Recurse is True, it will
      iterate through subgroups. }
    function FindItem(const IDString: string; Recurse: Boolean): IOTABasePaletteItem;
    function FindItemByName(const Name: string; Recurse: Boolean): IOTABasePaletteItem;
    { FindItemGroup: Finds the group for which the given item is contained in.
      It should always be recursive, and can return the current group,
      if it contains the item. Returns nil if it could not find the item. }
    function FindItemGroup(const IDString: string): IOTAPaletteGroup;
    function FindItemGroupByName(const Name: string): IOTAPaletteGroup;
    { InsertItem: Add an item at a particular index }
    procedure InsertItem(const Index: Integer; const Item: IOTABasePaletteItem);
    { IndexOf: Returns the index of an Item in the group, or -1 if not found }
    function IndexOf(const Item: IOTABasePaletteItem): Integer;
    { Move: Moves the item at CurIndex to NewIndex.  If NewIndex < 0 then the item
      is deleted. }
    procedure Move(const CurIndex, NewIndex: Integer);
    { RemoveItem: remove the Item from the Group, searching all the
      subgroups if Recursive is True. }
    function RemoveItem(const IDString: string; Recurse: Boolean): Boolean;
  end;

  { IOTAPaletteNotifier }
  { Add this notifier to the IOTAPaletteServices to be notified when
    the palette has changed.

    Modifed: called when you should refresh all your items.

    Destroyed: Release your hold on the IOTAPaletteServices.

    ***NOTE:*** When ItemAdded or ItemRemoved are called, Modified will not
    be called. This allows you to keep your updates to a minimum.
   }
  IOTAPaletteNotifier = interface(IOTANotifier)
    ['{6A3D2F2D-19BD-487E-A715-F1E7FECF8791}']
    { ItemAdded: called when a particular item is added to a group. }
    procedure ItemAdded(const Group: IOTAPaletteGroup;
      const Item: IOTABasePaletteItem);
    { ItemRemoved: called when a particular item is deleted from the
      palette. You should release your references to the item at this time. }
    procedure ItemRemoved(const Group: IOTAPaletteGroup;
      const Item: IOTABasePaletteItem);
    { SelectedToolChanged: a new tool was selected. If you show a selected
      tool, you should "unselect" it, and display this Tool as selected. }
    procedure SelectedToolChanged(const Tool: IOTABasePaletteItem);
    { BeginUpdate/EndUpdate: will be called before multiple items are added
      or removed. You should refresh your UI and list of items on the
      last EndUpdate. }
    procedure BeginUpdate;
    procedure EndUpdate;
  end;

  TOTAPaletteColorItem = record
    StartColor: TColor;
    EndColor: TColor;
    TextColor: TColor;
  end;

  TOTAPaletteButtonColors = record
    RegularColor, SelectedColor, HotColor: TColor;
  end;

  TOTAPaletteOptions = record
    BackgroundColor, BackgroundGradientColor: TColor;
    BoldCaptions: Boolean;
    CaptionOnlyBorder: Boolean;
    UsePlusMinus: Boolean;
    CategoryGradientDirection: TGradientDirection;
    BackgroundGradientDirection: TGradientDirection;
  end;

  { IOTAPaletteColorScheme }
  { A Color scheme used by the default palette. Can be used by other
    palette via the IOTAPaletteServices, if you wish }
  IOTAPaletteColorScheme = interface
    ['{75D3424A-6518-4465-B940-E004D7FFBB0C}']
    function GetButtonColors: TOTAPaletteButtonColors;
    function GetColor(const Index: Integer): TOTAPaletteColorItem;
    function GetCount: Integer;
    function GetIDString: string;
    function GetName: string;
    function GetOptions: TOTAPaletteOptions;

    property ButtonColors: TOTAPaletteButtonColors read GetButtonColors;
    property Options: TOTAPaletteOptions read GetOptions;
    { Colors are the colors to iterate through for each category when
      using a Scheme }
    property Colors[const Index: Integer]: TOTAPaletteColorItem read GetColor; default;
    property Count: Integer read GetCount;

    property IDString: string read GetIDString;
    property Name: string read GetName;
  end;

  { IOTAPaletteServices }
  { Query BorlandIDEServices for IOTAPaletteServices.
    Use IOTAPaletteServices to iterate through all the top level groups,
    add a notifier, and notify when you add/remove items. }
  IOTAPaletteServices = interface
    ['{6963F71C-0A3F-4598-B6F6-9574CE0E6847}']
    procedure SetSelectedTool(const Value: IOTABasePaletteItem);
    function GetBaseGroup: IOTAPaletteGroup;
    function GetSelectedTool: IOTABasePaletteItem;

    function AddNotifier(const Notifier: IOTAPaletteNotifier): Integer;
    { BaseGroup: the first group in the palette which contains all of the
      other groups. Iterate through it to find all the items. }
    property BaseGroup: IOTAPaletteGroup read GetBaseGroup;
    { BeginUpdate: Call when you are adding or removing multiple items.
      Always match with an EndUpdate. }
    procedure BeginUpdate;
    procedure EndUpdate;
    { Call ItemAdded when you add an item to a group. }
    procedure ItemAdded(const Group: IOTAPaletteGroup;
      const Item: IOTABasePaletteItem);
    { Call ItemRemoved when you delete an item. }
    procedure ItemRemoved(const Group: IOTAPaletteGroup;
      const Item: IOTABasePaletteItem);
    { Call Modifed when one or more items state has changed. }
    procedure Modified;

    { RegisterDragAcceptor: returns the index of a newly registered acceptor }
    function RegisterDragAcceptor(const Acceptor: IOTAPaletteDragAcceptor): Integer;
    { RemoveDragAcceptor: removes the acceptor at Index }
    procedure UnRegisterDragAcceptor(const Index: Integer);
    { GetDragAcceptors: returns a list of all acceptors.
      Each item in the list is a IOTAPaletteDragAcceptor }
    function GetDragAcceptors: IInterfaceList;

    function RegisterColorScheme(const ColorScheme: IOTAPaletteColorScheme): Integer;
    procedure UnRegisterColorScheme(const Index: Integer);
    function GetColorSchemes: IInterfaceList;

    procedure RemoveNotifier(const Index: Integer);
    { SelectedTool: The current selected tool (may be nil). When you
      visually change what the selected tool is, you must set this
      property. It will notify each Notifier. }
    property SelectedTool: IOTABasePaletteItem read GetSelectedTool write SetSelectedTool;

    { PaletteState: a string which contains multiple "states" that the IDE
      is in. This allows palette items to determine if they should
      be visible or not, based on what is in the state. }
    procedure AddPaletteState(const State: string);
    procedure RemovePaletteState(const State: string);
    { If your state is a "designer" state, use this method to add your state.
      The "cPSDesignerActive" state will be set when at least one
      designer state is in the PaletteState string. }
    procedure AddPaletteDesignerState(const State: string);

    function ContainsPaletteState(const State: string): Boolean;
    function GetPaletteState: string;

  end;

  { INTAPaletteContextMenu}
  { Query the BorlandIDEServices for this service. It allows you to dynamically
    add context menus to the palette. Consumers can use menu items from the
    interface, producers can add menu items to the interface. }
  INTAPaletteContextMenu = interface
    ['{B58639BC-4332-45BF-A79E-D4977EE7E024}']
    function GetCount: Integer;
    function GetContextMenuItem(const Index: Integer): TMenuItem;

    { Adds a context menu to the internal list. }
    procedure AddContextMenuItem(const MenuItem: TMenuItem);
    { Remove a context menu item previously added }
    procedure RemoveContextMenuItem(const MenuItem: TMenuItem);
    { Retrieves the menu items. Since the item may have already been used
      by someone else, you should remove it from the parent before
      using it:

      NewMenuItem := ContextMenuItems[I];
      if NewMenuItem.Parent <> nil then
        NewMenuItem.Parent.Remove(NewMenuItem);

    }
    property ContextMenuItems[const Index: Integer]: TMenuItem read GetContextMenuItem; default;
    property Count: Integer read GetCount;
  end;

(*
    Note: snipplets have been removed in favor of code templates.
    Please see CodeTemplateAPI.pas.

    { IOTASnippletManager }
    { Allows you to add/remove/query for code snipplets }
    IOTASnippletManager = interface
      ['{8E96E78C-1153-4CCA-B8D2-CF5F4DBA7329}']
      function GetCount: Integer;

      { Adds a snipplet to the palette; returns the IDString for the new snipplet as UTF8 }
      function AddSnipplet(const Text: string): string; overload;
      { Remove a snipplet with the given IDString}
      function RemoveSnipplet(const IDString: string): Boolean;
      { Remove all snipplet's }
      procedure RemoveAllSnipplets;
      { The count of all snipplets }
      property Count: Integer read GetCount;
      { Gets a particular id string at a given index }
      function GetIDString(const Index: Integer): string;
      { Retrieves the snipplet text at a particular index }
      function GetSnipplet(const Index: Integer): string; overload;
    end deprecated;
  
    { IOTAWideSnippletManager }
    { Wide string support }
    IOTAWideSnippletManager = interface
      ['{D30FBAC1-653C-405F-AF8A-6048A8B79ED2}']
      { AddSnipplet: Wide string version }
      function AddSnippletW(const Text: Widestring): string;
      { GetSnipplet: Wide string version }
      function GetSnippletW(const Index: Integer): Widestring;
    end deprecated;
*)

const
  { Some predefined palette states }
  cPSCodeEditorActive = 'CodeEditorActive';
  cPSDesignerActive = 'DesignerActive';
  { The cPSDesignerActive state is special. If you remove it,
    it clears all states added with AddDesignerState.
    If you add a state with AddDesignerState, it implicitly adds
    the cPSDesignerActive state. When you remove the last designer state
    previously added with AddDesignerState, then cPSDesignerActive is
    automatically removed.
  }

implementation

end.
