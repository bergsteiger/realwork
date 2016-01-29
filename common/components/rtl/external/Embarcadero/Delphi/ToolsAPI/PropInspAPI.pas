{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit PropInspAPI;

{ PropInspAPI. Open Tools API for the Property Inspector. }

interface

uses System.Classes, DesignIntf, ToolsAPI, System.IniFiles;

type
  { IPropInspSaveState is a hack until the OTA has a way of
    saving desktop state. The OI checks to see if the selection
    implements this and calls it }
  IPropInspSaveState = interface
    ['{B4EB42CD-7616-409F-99ED-C38B40953E02}']
    procedure SaveWindowState(Desktop: TCustomIniFile; isProject: Boolean);
    procedure LoadWindowState(Desktop: TCustomIniFile);
  end;

  TInspArrangeMode = (iamByCategory, iamByName);

                                                            
                                     
  IPropListBoxSelection = interface
    ['{2C6EC290-6159-4D66-8C45-06EFA815106A}']
    function GetCount: Integer;
    function GetCurrentSubItem: IProperty;
    function GetSubItem(const Index: Integer): IProperty;
    function GetSubItemCount: Integer;
    function GetItem(const Index: Integer): IProperty;
    procedure SetCurrentSubItem(const Value: IProperty);
    { Items are all of the first level items to display }
    property Items[const Index: Integer]: IProperty read GetItem;
    { Count is a Count of the Items }
    property Count: Integer read GetCount;
    { CurrentSubItem will be set when the Property Inspector is about
      to iterate through the SubItems array for that particular IProperty }
    property CurrentSubItem: IProperty read GetCurrentSubItem write SetCurrentSubItem;
    property SubItemCount: Integer read GetSubItemCount;
    property SubItems[const Index: Integer]: IProperty read GetSubItem;
  end;

  { IOTAPropInspPages }
  { Query IOTAPropInspPages from an IOTAPropInspSelection.
    If returned, then the Property Inspector should display
    each Item as a page. }
  IOTAPropInspPages = interface(IOTAStrings)
    ['{A8CFD9BF-7A6C-4F99-879E-ADBA5C8FEC08}']
    function GetPageIndex: Integer;
    procedure SetPageIndex(const Value: Integer);
    { PageIndex: The active page index }
    property PageIndex: Integer read GetPageIndex write SetPageIndex;
  end;

  { IOTAPropInspInstanceList }
  { Query IOTAPropInspInstanceList from an IOTAPropInspSelection.
    If returned, then the Property Inspector will enumerate through the
    Count, adding all the Name/Value's to the InstanceList list when it
    is dropped down. }
  IOTAPropInspInstanceList = interface(IOTAStrings)
    ['{394C9D2B-0925-460B-8678-1B1547AEC1A1}']
    function GetActiveName: string;
    function GetActiveValue: string;
    function GetHint: string;
    function GetItemIndex: Integer;
    procedure SetItemIndex(const Value: Integer);

    { ActiveName and ActiveValue are displayed in the InstanceList when
      it is not dropped down. }
    property ActiveName: string read GetActiveName;
    property ActiveValue: string read GetActiveValue;

    property Hint: string read GetHint;
    { ItemIndex will be set when a new item is selected from the InstanceList
      list. You should update your list of items as needed }
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
  end;

  IOTAWidePropInspInstanceList = interface
    ['{561F40D1-38D0-4f4b-8AD2-F0582E4E2AD3}']
    function GetWideActiveName: Widestring;
    function GetWideActiveValue: WideString;
    function GetWideHint: WideString;
    function GetWideItem(const Index: Integer): WideString;
    procedure SetWideItem(const Index: Integer; const Value: WideString);

    property WideActiveName: WideString read GetWideActiveName;
    property WideActiveValue: WideString read GetWideActiveValue;

    property WideHint: WideString read GetWideHint;
    property WideItems[const Index: Integer]: Widestring read GetWideItem write SetWideItem;
  end;

  { IOTAPropInspCategories }
  { String Name Value is the category name. String Value for a given name
    should be "1" if it is On/Checked, or anything else if it isn't.
    Integer Data can be whatever you want.
    Implementing Assign is not required; it is not used.
    Assignment of things other than Value is not done.}
  IOTAPropInspCategories = interface(IOTAStrings)
    ['{75F38883-A97D-4687-BD14-E14D6685D9B3}']
    procedure ViewAll;
    procedure ToggleAll;
    procedure ViewNone;
  end;

  { IOTAPropInspHotCommands }
  { Query IOTAPropInspInstanceList from and IOTAPropInspSelection.  If returned,
    then the property inspector will display a pane at the bottom with various
    hot-links associated with the current selection.  This allows, for instance,
    component editor verbs to be invoked directly from the property inspector.
    Since this interface descends from IOTAStrings, the Count and string items
    from IOTAStrings will describe what commands and their display strings to
    show. }
  IOTAPropInspHotCommands = interface(IOTAStrings)
    ['{550D14EA-78AC-4936-AC06-E084F10C1EE7}']
    { This method will be invoked when the user clicks on the indicated item
      index. }
    procedure CommandClicked(Index: Integer);
    { This method is called periodically in order to determine if the specified
      command index should be enabled. }
    function CommandEnabled(Index: Integer): Boolean;
  end;


  { The programmer who wishes to interact with the Property Inspector will
    implement IOTAPropInspSelection and will set IOTAPropInspManager.Selection
    to change what the Property Inspector displays. }

  IOTAPropInspSelection = interface(IPropListBoxSelection)
    ['{0078EE6B-FB6D-4082-BB8A-189FD58395F6}']
    function GetActiveItem: string;
    function GetExpandAll: Boolean;
    function GetExpandedItems: string;
    function GetArrangeMode: TInspArrangeMode;
    function GetShowDescriptionPane: Boolean;
    function GetShowHotCommands: Boolean;
    function GetStatusText: string;
    function GetCategories: IOTAPropInspCategories;
    procedure SetActiveItem(const Value: string);
    procedure SetArrangeMode(const Value: TInspArrangeMode);
    procedure SetExpandedItems(const Value: string);

    { Show help based on the Item that we are passing to you }
    procedure InvokeHelp(const Item: IProperty);
    { Return True from IsExpandable if the property can be expanded.
      The IProperty must already have paSubProperties in Attributes
      for this to be called. It allows you to make an item not
      appear expandable for whatever reason. Default implementations
      should always return True. }
    function IsExpandable(const Item: IProperty): Boolean;
    { HandleActivation should be called whenever a viewer of this
      PropInspSelection is activated or deactivated.  This allows the selection
      to perform special processing related to the user selecting a view of the
      selection }
    procedure HandleActivation(Activating: Boolean);

    { ExpandAll returns whether or not the the property inspector will automatically
      expand all the first level items.  This is generally useful to tell the
      inspector to automatically expand the categories when in the iamByCategory
      ArrangeMode.  Once Expanded items is set for the first time, ExpandAll can
      return False in order to properly preserve the expanded and collapsed
      catebories. }
    property ExpandAll: Boolean read GetExpandAll;
    { ExpandedItems will be used by the Property Inspector to
      retrieve and write its expanded items that are associated with this
      selection. You will need to persist the state. }
    property ExpandedItems: string read GetExpandedItems write SetExpandedItems;
    { ActiveItem will be used by the Property Inspector to retrieve and
      store the currently selected item. Again, you will need to persist
      the state. }
    property ActiveItem: string read GetActiveItem write SetActiveItem;

    property ArrangeMode: TInspArrangeMode read GetArrangeMode write SetArrangeMode;
    { ShowDescriptionPane is used by the property inspector to indicated whether
      or not it should display the description pane at the bottom of the property
      list.  This pane will display the name of the currently selected property
      and if the current IProperty also implements IPropertyDescription, displays
      the text from IPropertyDescription.GetDescription. }
    property ShowDescriptionPane: Boolean read GetShowDescriptionPane;
    { ShowHotCommands is used by the property inspector to indicate whether or
      not it should display the hot commands pane at the bottom of the property
      list.  If this property is True, the selection should implement
      IOTAPropInspHotCommands in order for the property inspector to get the
      content to display in that pane. }
    property ShowHotCommands: Boolean read GetShowHotCommands;
    property StatusText: string read GetStatusText;
    { Retrieve the categories for this selection, and if they
      are visible (checked) or not }
    property Categories: IOTAPropInspCategories read GetCategories;
  end;

  { Notifiers can be added to "hear" when things change in the
    Property Inspector. Those who wish to implement a Property Inspector
    would add a IOTASelectionNotifier to the IOTAPropInspServices and
    display the IProperty's retrieved from the IOTAPropInspSelection.

    For IOTANotifier, the only pertinent events are Destroyed (which
    hppens when the references should be dropped) and Modifed (which
    signals that you should refresh your view).
   }

  IOTASelectionNotifier = interface(IOTANotifier)
    ['{3C2059B2-0C44-4C4C-9C9F-F325A509D9B4}']
    { SelectionChanged: tells you when a NewSelection has happened.
      You should update your display with the NewSelection at this time }
    procedure SelectionChanged(const NewSelection: IOTAPropInspSelection);
    { UpdateState: called when you should save out your current state. }
    procedure UpdateState;
  end;

  IOTASelectionNotifier160 = interface
    ['{157FFA94-DA86-4112-9C94-8DFAED6EAAF7}']
    { This associated item was modified in some way. Subitems of volatile
      properties may need to be recalculated }
    procedure VolatileModified;
    { Expand the selection if possible }
    procedure Expand;
  end;

  IOTAPropInspServices100 = interface
    ['{84494824-29A8-4F78-B58D-A87A9A1333F8}']
    function GetSelection: IOTAPropInspSelection;
    procedure SetSelection(const Value: IOTAPropInspSelection);

    property Selection: IOTAPropInspSelection read GetSelection write SetSelection;
    { Modified can be called when the selection needs to be updated to
      possibly display some new information. The implementation
      calls all of the IOTASelectionNotifier's Modified. }
    procedure Modified;
    { UpdateState can be called whenever the current Selection should
      have some of its state stored out (such as when a desktop is
      loaded or saved, your OI closes, or some other state changes). }
    procedure UpdateState;
    { AddNotifier returns the index of the new notifier that was added }
    function AddNotifier(const Notifier: IOTASelectionNotifier): Integer;
    { RemoveNotifider removes a given index }
    procedure RemoveNotifier(const Index: Integer);
    { Prevent a selection from being cleared }
    procedure LockSelection;
    procedure UnlockSelection;
  end;

  INTAPropInspServices = interface(IInterface)
    ['{5891E776-BAFA-4EA5-AEE6-E32F210B5326}']
    procedure SelectObjects(const Objects: array of TPersistent);
    function ObjectsSelected(const Objects: array of TPersistent): Boolean;
  end;

  IOTAPropInspServices160 = interface(IOTAPropInspServices100)
    ['{15D694E6-E2D8-4BBA-A1D2-D8B6F8E8CCC2}']
    { VolatileModified can be called when the selection needs to be updated to
      possibly display some new information, included different child items of
      volatile properties. The implementation
      calls all of the IOTASelectionNotifier160 VolatileModified. }
    procedure VolatileModified;
    { Expand the selection }
    procedure Expand;
  end;

  IOTAPropInspServices = interface(IOTAPropInspServices160)
    ['{7EF7625C-42C0-434F-B538-76B12C3D8E7C}']
  end;

implementation

end.
