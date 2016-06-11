{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzureTable;

interface

uses AzureUI, System.Classes, Vcl.ComCtrls, Vcl.Controls, Vcl.ImgList, Vcl.Menus;

type
  ///<summary> The possible types of Azure table nodes.
  ///</summary>
  TNodeType = (aztUnknown, aztTables, aztTable, aztLoading, aztTruncated);

  ///<summary>
  ///  Data to store with a node which holds its value, and type.
  ///</summary>
  TNodeData = class
  protected
    FValue: String;
    FNodeType: TNodeType;
  public
    constructor Create(NodeType: TNodeType = aztUnknown); Virtual;
    ///<summary> The value associated with the node. </summary>
    ///<remarks> May be the same as the Node's text, although this value will never be truncated. </remarks>
    property Value: String read FValue write FValue;
    ///<summary> The node's type. </summary>
    property NodeType: TNodeType read FNodeType write FNodeType;
  end;

  ///<summary>
  ///  Component for managing Azure Tables on Microsoft Azure.
  ///</summary>
  ///<remarks>
  ///  A tree component for viewing all of the tables stored for the given Microsoft Azure connection.
  ///  Each table has entities (rows) which are visible in a dialog accessable from each table node.
  ///</remarks>
  TAzureTableManagement = class(TAzureManagement)
  protected
    FActive: Boolean;
    FCustomImages: TCustomImageList;
    FMenuNode: TTreeNode;
    FAdvancedFilterPrefix: String;
    FForceCollapse: Boolean;

    procedure SetCustomImages(Value: TCustomImageList);

    procedure ForceCollapse(Node: TTreeNode; FullCollapse: Boolean = True);

    procedure InitializeTree;
    procedure HandleNodeExpanded(Sender: TObject; Node: TTreeNode);
    procedure HandleCreateNodeClass(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
    procedure HandleNodeCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
    function Activate: Boolean;
    procedure SetActive(Active: Boolean);

    //Checks given node and recursivly searches all child nodes
    //to see if any node is expanded and has a loading node as its child.
    function HasLoadingNode(Node: TTreeNode): Boolean;
    function isNodeLoading(Node: TTreeNode): Boolean;

    function CreatePopupMenu: TPopupMenu;
    procedure UpdatePopupMenu(Sender: TObject);
    function CreateImageList: TCustomImageList;
    procedure OnImageIndex(Sender: TObject; Node: TTreeNode);
    procedure HandleDoubleClick(Sender: TObject);
    procedure HandleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    //Context Menu actions
    procedure ActivateAction(Sender: TObject);
    procedure AddTableAction(Sender: TObject);
    procedure RemoveTableAction(Sender: TObject);
    procedure ViewTableAction(Sender: TObject);
    procedure RefreshTablesAction(Sender: TObject);

    procedure OpenViewTableDialog(TableNode: TTreeNode);

    //Callbacks for action threads (refresh/add/remove)
    procedure PopulateTables(Node: TTreeNode; TableNames: TStringList; StartingTable: String;
                             NextTableName: String; ForceExpand: Boolean; ErrorMessage: String);
    procedure TableCreated(TableName: String; Success: Boolean; ForceExpand: Boolean);
    procedure TableDeleted(TableName: String; Success: Boolean; ForceExpand: Boolean);

    //Helper functions for managing nodes
    function CreateLoadingNode(ParentNode: TTreeNode): TTreeNode;
    function CreateLoadMoreNode(ParentNode: TTreeNode): TTreeNode;
    procedure PopulateForNode(Node: TTreeNode; ForceExpand: Boolean = True);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property DoubleBuffered;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property RowSelect;
    property Touch;
    property Visible;

    property ConnectionInfo;

    /// <summary>
    ///   Character(s) to type first into the filter field of the table dialog for advanced filtering
    /// </summary>
    /// <remarks> To have the rest of the filter treated as an expression instead of a RowKey or PartitionKey </remarks>
    property AdvancedFilterPrefix: String read FAdvancedFilterPrefix write FAdvancedFilterPrefix;
    /// <summary> Images to use instead of the default tree node images </summary>
    /// <remarks> In the (index) order of: Tables, Table, Load More Tables </remarks>
    property CustomImages: TCustomImageList read FCustomImages write SetCustomImages;
    /// <summary> Set to True to be able to connect to azure and populate the tree. </summary>
    property Active: Boolean read FActive write SetActive;
  end;

const
  ADD_TABLE = 'AddTable';
  REMOVE_TABLE = 'RemoveTable';
  VIEW_TABLE_DATA = 'ViewData';
  REFRESH_SEL = 'Refresh';
  ACTIVATE_ITEM = 'Activate';
  NODE_TABLE = 'entry';
  NODE_TABLE_CONTENT = 'content';
  NODE_PROPERTIES = 'm:properties';
  NODE_TABLE_NAME = 'd:TableName';

implementation

uses
  Winapi.ActiveX, Data.DBXClientResStrs, Vcl.Dialogs, DSAzure, DSAzureTableDialog, Vcl.ExtCtrls,
  Vcl.Graphics, System.SysUtils, System.UITypes, Winapi.Windows, Xml.XMLDoc, Xml.XMLIntf;

type
   TTablesPopulatedCallback = procedure(Node: TTreeNode; TableNames: TStringList; StartingTable: String;
                                        NextTableName: String; ForceExpand: Boolean; ErrorMessage: String) of object;
   TTableCreatedCallback = procedure(TableName: String; Success: Boolean; ForceExpand: Boolean) of object;
   TTableDeletedCallback = procedure(TableName: String; Success: Boolean; ForceExpand: Boolean) of object;

  TTablesPopulator = class(TThread)
  protected
    FNode: TTreeNode;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TTablesPopulatedCallback;
    FTableService: TAzureTableService;
    FForceExpand: Boolean;
    FStartingTable: String;
  public
    constructor Create(Node: TTreeNode; ConnectionInfo: TAzureConnectionString;
                       Callback: TTablesPopulatedCallback; StartingTable: String;
                       ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TTableCreator = class(TThread)
  protected
    FTableName: String;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TTableCreatedCallback;
    FTableService: TAzureTableService;
    FForceExpand: Boolean;
  public
    constructor Create(TableName: String; ConnectionInfo: TAzureConnectionString;
                       Callback: TTableCreatedCallback; ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TTableDeletor = class(TThread)
  protected
    FTableName: String;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TTableDeletedCallback;
    FTableService: TAzureTableService;
    FForceExpand: Boolean;
  public
    constructor Create(TableName: String; ConnectionInfo: TAzureConnectionString;
                       Callback: TTableDeletedCallback; ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

function GetNodeData(Node: TTreeNode; NodeType: TNodeType = aztUnknown): TNodeData;
begin
  //NodeType should only be unknown if the data is already assigned and not being created here
  Assert((NodeType <> aztUnknown) or Assigned(Node.Data));

  if not Assigned(Node.Data) then
  begin
    Node.Data := Pointer(TNodeData.Create);
    TNodeData(Node.Data).NodeType := NodeType;
  end;

  Result := TNodeData(Node.Data);
end;

{ TNodeData }

constructor TNodeData.Create(NodeType: TNodeType);
begin
  FNodeType := NodeType;
end;

{ TAzureTableManagement }

function TAzureTableManagement.Activate: Boolean;
begin
  Result := False;
  if FConnectionInfo <> nil then
  begin
    InitializeTree;
    Result := True;
  end;
end;

procedure TAzureTableManagement.ActivateAction(Sender: TObject);
begin
  SetActive(True);
end;

procedure TAzureTableManagement.AddTableAction(Sender: TObject);
var
  TableName: String;
begin
  if not IsNodeLoading(GetNodeAt(0, 0)) then
  begin
    TableName := InputBox(SAddTable, SAddTableMessage, EmptyStr);

    if TableName <> EmptyStr then
    begin
      TableName := AnsiLowerCase(TableName);
      TTableCreator.Create(TableName, FConnectionInfo, TableCreated, True);
    end;
  end;
end;

constructor TAzureTableManagement.Create(AOwner: TComponent);
begin
  inherited;
  FActive := False;
  ReadOnly := True;
  OnExpanded := HandleNodeExpanded;
  OnCollapsing := HandleNodeCollapsing;
  OnGetImageIndex := OnImageIndex;
  OnCreateNodeClass := HandleCreateNodeClass;
  OnDblClick := HandleDoubleClick;
  OnKeyUp := HandleKeyUp;
  PopupMenu := CreatePopupMenu;
  Images := CreateImageList;
  RightClickSelect := True;
  FMenuNode := nil;
  FAdvancedFilterPrefix := '~';

  TAzureService.SetUp;
end;

function TAzureTableManagement.CreateImageList: TCustomImageList;
var
  Images: TCustomImageList;
  BMP: Vcl.Graphics.TBitmap;
begin
  Images := TCustomImageList.Create(Self);

  BMP := GetAzureImage('IMG_AZURETABLES');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZURETABLE');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREMORETABLES');
  Images.Add(BMP, nil);
  BMP.Free;

  Result := Images;
end;

function TAzureTableManagement.CreateLoadingNode(ParentNode: TTreeNode): TTreeNode;
var
  Node: TTreeNode;
  Nodedata: TNodeData;
begin
  Node := Items.AddChild(ParentNode, SNodeLoading);
  NodeData := GetNodeData(Node, aztLoading);
  NodeData.Value := Node.Text;

  Result := Node;
end;

function TAzureTableManagement.CreateLoadMoreNode(ParentNode: TTreeNode): TTreeNode;
var
  Node: TTreeNode;
  Nodedata: TNodeData;
begin
  Node := Items.AddChild(ParentNode, SMoreTables);
  NodeData := GetNodeData(Node, aztTruncated);
  NodeData.Value := Node.Text;

  CreateLoadingNode(Node);

  Result := Node;
end;

function TAzureTableManagement.CreatePopupMenu: TPopupMenu;
var
  Menu: TPopupMenu;
  Item: TMenuItem;
begin
  Menu := TPopupMenu.Create(Self);
  Menu.OnPopup := UpdatePopupMenu;

  Item := Menu.CreateMenuItem;
  Item.Name := ACTIVATE_ITEM;
  Item.Caption := SActivate;
  Item.OnClick := ActivateAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := ADD_TABLE;
  Item.Caption := SAddTable;
  Item.OnClick := AddTableAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := REMOVE_TABLE;
  Item.Caption := SRemoveTable;
  Item.OnClick := RemoveTableAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := VIEW_TABLE_DATA;
  Item.Caption := SViewTableData;
  Item.OnClick := ViewTableAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := 'N1';
  Item.Caption := cLineCaption;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := REFRESH_SEL;
  Item.Caption := SRefresh;
  Item.OnClick := RefreshTablesAction;
  Menu.Items.Add(Item);

  Result := Menu;
end;

destructor TAzureTableManagement.Destroy;
begin
  if not Assigned(CustomImages) and Assigned(Images) then
  begin
    Images.Clear;
    Images.Free;
    Images := nil;
  end;

  inherited;
end;

procedure TAzureTableManagement.ForceCollapse(Node: TTreeNode; FullCollapse: Boolean);
begin
  FForceCollapse := True;
  try
    if Node = nil then
      Node := Items.GetFirstNode;

    if Node <> nil then
      Node.Collapse(FullCollapse);
  finally
    FForceCollapse := False;
  end;
end;

procedure TAzureTableManagement.HandleCreateNodeClass(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
begin
  NodeClass := TAzureTreeNode;
end;

procedure TAzureTableManagement.HandleDoubleClick(Sender: TObject);
begin
  OpenViewTableDialog(Selected);
end;

procedure TAzureTableManagement.HandleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Data: TNodeData;
begin
  if Selected = nil then
    Exit;

  Data := Selected.Data;
  if (Data.NodeType = aztTables) and (Key = VK_F5) then
    RefreshTablesAction(Sender)
  else if Data.NodeType = aztTable then
  begin
    if (Key = VK_DELETE) then
    begin
      FMenuNode := Selected;
      RemoveTableAction(Sender);
    end
    else if (Key = VK_RETURN) then
    begin
      while ssShift in Shift do
      begin
        OpenViewTableDialog(Selected);
        Break;
      end;
    end;
  end;
end;

procedure TAzureTableManagement.HandleNodeCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
begin
  AllowCollapse := FForceCollapse or not isNodeLoading(Node);
end;

procedure TAzureTableManagement.HandleNodeExpanded(Sender: TObject; Node: TTreeNode);
var
  NodeData: TNodeData;
  LoadingNode: TTreeNode;
begin
  if isNodeLoading(Node) then
  begin
    LoadingNode := Node.getFirstChild;
    NodeData := GetNodeData(LoadingNode);
    Assert(NodeData.NodeType = aztLoading);

    PopulateForNode(Node);
  end;
end;

function TAzureTableManagement.HasLoadingNode(Node: TTreeNode): Boolean;
var
  ChildNode: TTreeNode;
begin
  if Node = nil then
    Exit(False);

  Result := False;

  if Node.Expanded and isNodeLoading(Node) then
    Exit(True);

  if Node.HasChildren then
  begin
    ChildNode := Node.getFirstChild;

    while ChildNode <> nil do
    begin
      if HasLoadingNode(ChildNode) then
        Exit(True);

      ChildNode := ChildNode.getNextSibling;
    end;
  end;
end;

procedure TAzureTableManagement.UpdatePopupMenu(Sender: TObject);
var
  Data: TNodeData;
  MenuItem: TMenuItem;
begin
  FMenuNode := Selected;
  Data := nil;

  if FMenuNode <> nil then
    Data := FMenuNode.Data;

  for MenuItem in PopupMenu.Items do
  begin
    if not FActive then
      MenuItem.Visible := MenuItem.Name = ACTIVATE_ITEM
    else if (MenuItem.Name = REMOVE_TABLE) or (MenuItem.Name = VIEW_TABLE_DATA) then
      MenuItem.Visible := (Data <> nil) and (Data.NodeType = aztTable)
    else
      MenuItem.Visible := MenuItem.Name <> ACTIVATE_ITEM;
  end;
end;

procedure TAzureTableManagement.ViewTableAction(Sender: TObject);
begin
  OpenViewTableDialog(FMenuNode);
end;

procedure TAzureTableManagement.InitializeTree;
var
  Node: TTreeNode;
  NodeData: TNodeData;
begin
  Items.Clear;

  Node := Items.AddChild(nil, SNodeAzureTableRoot);
  NodeData := GetNodeData(Node, aztTables);
  NodeData.Value := Node.Text;

  CreateLoadingNode(Node);
end;

function TAzureTableManagement.isNodeLoading(Node: TTreeNode): Boolean;
var
  LoadingNode: TTreeNode;
begin
  Result := False;

  //is only loading if the loading node is exposed
  if (Node <> nil) and (Node.Count = 1) and Node.Expanded then
  begin
    LoadingNode := Node.getFirstChild;
    Result := (GetNodeData(LoadingNode).NodeType = aztLoading);
  end;
end;

procedure TAzureTableManagement.OnImageIndex(Sender: TObject; Node: TTreeNode);
var
  Data: TNodeData;
  Indx: Integer;
begin
  Data := GetNodeData(Node);

  case Data.NodeType of
    aztTables: Indx := 0;
    aztTable: Indx := 1;
    aztTruncated: Indx := 2;
    else
      Indx := -1;
  end;

  Node.ImageIndex := Indx;
  Node.SelectedIndex := Indx;
end;

procedure TAzureTableManagement.OpenViewTableDialog(TableNode: TTreeNode);
var
  Data: TNodeData;
  Dialog: TTAzureTableDialog;
begin
  if (TableNode <> nil) then
  begin
    Data := TableNode.Data;
    if Data.NodeType = aztTable then
    begin
      Dialog := nil;
      try
        Dialog := TTAzureTableDialog.Create(Self, FConnectionInfo);
        Dialog.AdvancedFilterPrefix := FAdvancedFilterPrefix;
        Dialog.SetTable(TableNode.Text);
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    end;
  end;
end;

procedure TAzureTableManagement.PopulateForNode(Node: TTreeNode; ForceExpand: Boolean);
var
  NodeData: TNodeData;
begin
  NodeData := GetNodeData(Node);

  if (NodeData.NodeType = aztTables) then
    TTablesPopulator.Create(Node, FConnectionInfo, PopulateTables, EmptyStr, ForceExpand)
  else if (NodeData.NodeType = aztTruncated) and (NodeData.Value <> EmptyStr) then
    TTablesPopulator.Create(Node.Parent, FConnectionInfo, PopulateTables, NodeData.Value, ForceExpand);
end;

procedure TAzureTableManagement.PopulateTables(Node: TTreeNode; TableNames: TStringList; StartingTable: String;
                                               NextTableName: String; ForceExpand: Boolean; ErrorMessage: String);
var
  TableName: String;
  TableNode: TTreeNode;
  TableNodeData: TNodeData;
begin
  if not FActive then
  begin
    ForceCollapse(nil);
    Exit;
  end;

  if (ErrorMessage <> EmptyStr) then
  begin
    MessageDlg(ErrorMessage, mtError, [mbOK], 0);
    ForceCollapse(nil);
    Exit;
  end;

  if (TableNames = nil) then
  begin
    if (StartingTable <> EmptyStr) and Node.HasChildren then
      Node.GetLastChild.Collapse(False)
    else
      Node.Collapse(False);
    Exit;
  end;

  Items.BeginUpdate;

  try
    //If the tables being passed in at the first tables, clear all old tables,
    //otherwise clear only the fake ('load more') node.
    if StartingTable = EmptyStr then
      Node.DeleteChildren
    else if Node.HasChildren then
    begin
      TableNodeData := Node.GetLastChild.Data;
      //should always be true
      if TableNodeData.NodeType = aztTruncated then
        Node.GetLastChild.Delete;
    end;

    for TableName in TableNames do
    begin
      TableNode := Items.AddChild(Node, TableName);
      TableNodeData := GetNodeData(TableNode, aztTable);
      TableNodeData.Value := TableNode.Text;
    end;

    //If there are more tables to load, add the 'load more' node
    if NextTableName <> EmptyStr then
    begin
      TableNode := CreateLoadMoreNode(Node);
      TableNodeData := TableNode.Data;
      TableNodeData.Value := NextTableName;
    end;
  finally
    if ForceExpand and not Node.Expanded then
      Node.Expand(False);
    Items.EndUpdate;
    FreeAndNil(TableNames);
  end;
end;

procedure TAzureTableManagement.RefreshTablesAction(Sender: TObject);
var
  RootNode: TTreeNode;
begin
  RootNode := GetNodeAt(0, 0);
  if not HasLoadingNode(RootNode) then
  begin
    //add a loading node when refreshing tables
    Items.BeginUpdate;
    RootNode.DeleteChildren;
    CreateLoadingNode(RootNode);
    RootNode.Expand(False);
    Items.EndUpdate;

    PopulateForNode(RootNode, True);
  end;
end;

procedure TAzureTableManagement.RemoveTableAction(Sender: TObject);
var
  Data: TNodeData;
begin
  if (FMenuNode <> nil) and not IsNodeLoading(FMenuNode) then
  begin
    if ConfirmDeleteItem then
    begin
      Data := FMenuNode.Data;
      Assert(Data.NodeType = aztTable);
      TTableDeletor.Create(FMenuNode.Text, FConnectionInfo, TableDeleted, True);
    end;
  end;
end;

procedure TAzureTableManagement.SetActive(Active: Boolean);
begin
  if (FActive <> Active) then
  begin
    if not Active then
    begin
      FActive := False;
      Items.Clear;
    end
    else
      FActive := Activate;
  end;
end;

procedure TAzureTableManagement.SetCustomImages(Value: TCustomImageList);
begin
  if Value <> nil then
  begin
    //If the current Images are ones made internally, not set through CustomImages property, Free them
    if FCustomImages <> Images then
    begin
      Images.Free;
    end;

    Images := Value;
  end
  else
    Images := CreateImageList;

  FCustomImages := Value;
end;

procedure TAzureTableManagement.TableCreated(TableName: String; Success, ForceExpand: Boolean);
begin
  if not FActive then
    Exit;

  if Success then
    PopulateForNode(GetNodeAt(0, 0), ForceExpand)
  else
    MessageDlg(Format(SAddTableError, [TableName]), mtError, [mbOK], 0);
end;

procedure TAzureTableManagement.TableDeleted(TableName: String; Success, ForceExpand: Boolean);
begin
  if not FActive then
    Exit;

  if Success then
    PopulateForNode(GetNodeAt(0, 0), ForceExpand)
  else
    MessageDlg(Format(SDeleteTableError, [TableName]), mtError, [mbOK], 0);
end;

{ TTablesPopulator }

constructor TTablesPopulator.Create(Node: TTreeNode; ConnectionInfo: TAzureConnectionString;
                                    Callback: TTablesPopulatedCallback; StartingTable: String;
                                    ForceExpand: Boolean);
begin
  inherited Create;
  Assert(Node <> nil);
  Assert(ConnectionInfo <> nil);

  FNode := Node;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
  FStartingTable := StartingTable;
end;

destructor TTablesPopulator.Destroy;
begin
  FreeAndNil(FTableService);
  inherited;
end;

procedure TTablesPopulator.Execute;
var
  xml: String;
  xmlDoc: IXMLDocument;
  TableNames: TStringList;
  TableNode: IXMLNode;
  ContentNode: IXMLNode;
  PropertiesNode: IXMLNode;
  TableNameNode: IXMLNode;
  NextTableName: String;
  ErrorMessage: String;
begin
  inherited;
  FreeOnTerminate := True;

  CoInitialize(nil);
  TableNames := nil;
  xmlDoc := nil;
  NextTableName := EmptyStr;
  ErrorMessage := EmptyStr;

  try
    try
      FTableService := TAzureTableService.Create(FConnectionInfo);

      xml := FTableService.QueryTables(FStartingTable);
      xmlDoc := TXMLDocument.Create(nil);
      xmlDoc.LoadFromXML(xml);

      //continuation token support, for the case when more tables exist than were returned
      NextTableName := FTableService.ResponseHeader['x-ms-continuation-NextTableName'];

      TableNames := TStringList.Create;

      TableNode := xmlDoc.DocumentElement.ChildNodes.FindNode(NODE_TABLE);

      while (TableNode <> nil) and (TableNode.HasChildNodes) do
      begin
        if (TableNode.NodeName = NODE_TABLE) then
        begin
          ContentNode := TableNode.ChildNodes.FindNode(NODE_TABLE_CONTENT);

          if (ContentNode <> nil) and (ContentNode.HasChildNodes) then
          begin
            PropertiesNode := GetFirstMatchingChildNode(ContentNode, NODE_PROPERTIES);

            if (PropertiesNode <> nil) and (PropertiesNode.HasChildNodes) then
            begin
              TableNameNode := GetFirstMatchingChildNode(PropertiesNode, NODE_TABLE_NAME);
              TableNames.Add(TableNameNode.Text);
            end;
          end;
        end;
        TableNode := TableNode.NextSibling;
      end;
    except
      on E : Exception do
      begin
        FreeAndNil(TableNames);
        if (FTableService <> nil) and (FTableService.ResponseText <> EmptyStr) then
          ErrorMessage := SErrorGeneric + FTableService.ResponseText
        else
          ErrorMessage := E.Message;
      end;
    end;
  finally
    CoUnInitialize();
    TThread.Synchronize(nil, procedure begin FCallback(FNode, TableNames, FStartingTable,
                                                       NextTableName, FForceExpand, ErrorMessage); end);
  end;
end;

{ TTableCreator }

constructor TTableCreator.Create(TableName: String; ConnectionInfo: TAzureConnectionString;
                                 Callback: TTableCreatedCallback; ForceExpand: Boolean);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);

  FTableName := TableName;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
end;

destructor TTableCreator.Destroy;
begin
  FreeAndNil(FTableService);
  inherited;
end;

procedure TTableCreator.Execute;
var
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;

  try
    try
      FTableService := TAzureTableService.Create(FConnectionInfo);
      Success := FTableService.CreateTable(FTableName);
    except
      Success := False;
    end;
  finally
    TThread.Synchronize(nil, procedure begin FCallback(FTableName, Success, FForceExpand); end);
  end;
end;

{ TTableDeletor }

constructor TTableDeletor.Create(TableName: String; ConnectionInfo: TAzureConnectionString;
                                 Callback: TTableDeletedCallback; ForceExpand: Boolean);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);

  FTableName := TableName;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
end;

destructor TTableDeletor.Destroy;
begin
  FreeAndNil(FTableService);
  inherited;
end;

procedure TTableDeletor.Execute;
var
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;

  try
    try
      FTableService := TAzureTableService.Create(FConnectionInfo);
      Success := FTableService.DeleteTable(FTableName);
    except
      Success := False;
    end;
  finally
    TThread.Synchronize(nil, procedure begin FCallback(FTableName, Success, FForceExpand); end);
  end;
end;

end.
