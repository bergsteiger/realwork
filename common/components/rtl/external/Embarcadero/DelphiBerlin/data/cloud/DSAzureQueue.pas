{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzureQueue;

interface

uses AzureUI, System.Classes, Vcl.ComCtrls, Vcl.Controls, System.Generics.Collections, Vcl.ImgList, Vcl.Menus;

type
  ///<summary> The possible types of Azure queue nodes.
  ///</summary>
  TNodeType = (azqUnknown, azqQueues, azqQueue, azqMessage, azqLoading, azqTruncated);

  ///<summary>
  ///  Data to store with a node which holds its value, and type.
  ///</summary>
  TNodeData = class
  protected
    FValue: String;
    FNodeType: TNodeType;
  public
    constructor Create; Virtual;
    ///<summary> The value associated with the node. </summary>
    ///<remarks> May be the same as the Node's text, although this value will never be truncated. </remarks>
    property Value: String read FValue write FValue;
    ///<summary> The node's type. </summary>
    property NodeType: TNodeType read FNodeType write FNodeType;
  end;

  ///<summary>
  ///  Extension of TNodeData adding Queue Message specific information.
  ///</summary>
  TMessageNodeData = class(TNodeData)
  protected
    FMessageId: String;
    FInsertTime: String;
    FExpireTime: String;
    FDequeueCount: Integer;
    FMessageText: String;
  public
    constructor Create; Override;
    property MessageId: String read FMessageId write FMessageId;
    property InsertTime: String read FInsertTime write FInsertTime;
    property ExpireTime: String read FExpireTime write FExpireTime;
    property DequeueCount: Integer read FDequeueCount write FDequeueCount;
    property MessageText: String read FMessageText write FMessageText;
  end;

  ///<summary>
  ///  Event for a message node in the tree being 'activated' (double-click or ENTER)
  ///</summary>
  TMessageActiveEvent = procedure(MessageData: TMessageNodeData) of object;

  ///<summary>
  ///  Component for managing Queues and their messages on Microsoft Azure.
  ///</summary>
  ///<remarks>
  ///  A tree component for viewing all of the queues stored for the given Microsoft Azure connection.
  ///  Each queue has messages as child nodes, with a limitation of showing a maximum of 32 messages.
  ///  From the tree you are able to add or remove queues, and for each queue you are able to pop the
  ///  top message or add a new message to any queue.
  ///</remarks>
  TAzureQueueManagement = class(TAzureManagement)
  protected
    FMessageActivate: TMessageActiveEvent;
    FActive: Boolean;
    FCustomImages: TCustomImageList;
    FMessageLength: Integer;
    FMenuNode: TTreeNode;
    FForceCollapse: Boolean;

    procedure SetMessageLength(Length: Integer);

    procedure SetCustomImages(Value: TCustomImageList);

    function Activate: Boolean;
    procedure SetActive(Active: Boolean);

    function CreatePopupMenu: TPopupMenu;
    procedure UpdatePopupMenu(Sender: TObject);
    function CreateImageList: TCustomImageList;

    //Context Menu actions
    procedure ActivateAction(Sender: TObject);
    procedure AddQueueAction(Sender: TObject);
    procedure RemoveQueueAction(Sender: TObject);
    procedure ClearMessagesAction(Sender: TObject);
    procedure AddMessageAction(Sender: TObject);
    procedure RemoveMessageAction(Sender: TObject);
    procedure RefreshQueueAction(Sender: TObject);
    procedure RefreshListAction(Sender: TObject);
    procedure OpenQueueMetadata(Sender: TObject);

    //Checks given node and recursivly searches all child nodes
    //to see if any node is expanded and has a loading node as its child.
    function HasLoadingNode(Node: TTreeNode): Boolean;
    function isNodeLoading(Node: TTreeNode): Boolean;

    procedure ForceCollapse(Node: TTreeNode; FullCollapse: Boolean = True);

    procedure InitializeTree;
    procedure HandleNodeExpanded(Sender: TObject; Node: TTreeNode);
    procedure HandleNodeCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
    procedure OnImageIndex(Sender: TObject; Node: TTreeNode);
    procedure OnGetHint(Sender: TObject; const Node: TTreeNode; var Hint: string);
    procedure HandleCreateNodeClass(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
    procedure HandleDoubleClick(Sender: TObject);
    procedure HandleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    //Callbacks for action threads (refresh/add/remove)
    procedure PopulateQueues(Node: TTreeNode; QueueNames: TStringList; ForceExpand: Boolean; ErrorMessage: String);
    procedure PopulateMessages(Node: TTreeNode; Messages: TList<TMessageNodeData>;
                               TotalMessages: Integer; ForceExpand: Boolean = True);
    procedure QueueCreated(QueueName: String; Success: Boolean; ForceExpand: Boolean);
    procedure QueueDeleted(QueueName: String; Success: Boolean; ForceExpand: Boolean);
    procedure MessageCreated(QueueNode: TTreeNode; Success: Boolean; ForceExpand: Boolean);
    procedure MessageRemoved(QueueNode: TTreeNode; Success: Boolean; ForceExpand: Boolean);

    //Helper functions for managing nodes
    function CreateLoadingNode(ParentNode: TTreeNode): TTreeNode;
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
    property ToolTips;

    property ConnectionInfo;

    /// <summary> Display length for a Queue message in the tree </summary>
    /// <remarks> Must be between 5 and 400.
    ///           If a message is truncated its node will have a tooltip showing more of the message.
    /// </remarks>
    property MessageLength: Integer read FMessageLength write SetMessageLength;
    /// <summary> Images to use instead of the default tree node images </summary>
    /// <remarks> In the (index) order of: Queues, Queue, Message </remarks>
    property CustomImages: TCustomImageList read FCustomImages write SetCustomImages;
    /// <summary> Callback to use for displaying a Queue message. </summary>
    /// <remarks> If set this replaces the message dialog which shows up by default. </remarks>
    property OnMessageActivate: TMessageActiveEvent read FMessageActivate write FMessageActivate;
    /// <summary> Set to True to be able to connect to azure and populate the tree. </summary>
    property Active: Boolean read FActive write SetActive;
  end;

const
  ADD_QUEUE = 'AddQueue';
  REMOVE_QUEUE = 'RemoveQueue';
  ADD_MESSAGE = 'AddMessage';
  CLEAR_MESSAGES = 'ClearMessages';
  REMOVE_MESSAGE = 'RemoveMessage';
  REFRESH_QUEUE = 'RefreshQueue';
  REFRESH_LIST = 'RefreshList';
  ACTIVATE_ITEM = 'Activate';
  QUEUE_METADATA = 'QueueMetadata';
  NODE_QUEUES = 'Queues';
  NODE_QUEUE = 'Queue';
  NODE_QUEUE_NAME = 'Name';

implementation

uses
  Winapi.ActiveX, Data.DBXClientResStrs, Vcl.Dialogs, DSAzure, DSAzureMessageDialog, DSAzureQueueMetadataDialog, Vcl.ExtCtrls,
  Vcl.Graphics, System.SysUtils, Winapi.Windows, Xml.XMLDoc, Xml.XMLIntf, System.StrUtils, System.UITypes;

type
  TQueuesPopulatedCallback = procedure(Node: TTreeNode; QueueNames: TStringList;
                                       ForceExpand: Boolean; ErrorMessage: String) of object;
  TMessagesPopulatedCallback = procedure(Node: TTreeNode; Messages: TList<TMessageNodeData>;
                                         TotalMessages: Integer; ForceExpand: Boolean) of object;
  TQueueCreatedCallback = procedure(QueueName: String; Success: Boolean; ForceExpand: Boolean) of object;
  TQueueDeletedCallback = procedure(QueueName: String; Success: Boolean; ForceExpand: Boolean) of object;
  TMessageCreatedCallback = procedure(QueueNode: TTreeNode; Success: Boolean; ForceExpand: Boolean) of object;
  TMessageRemovedCallback = procedure(QueueNode: TTreeNode; Success: Boolean; ForceExpand: Boolean) of object;

  TQueuePopulator = class(TThread)
  protected
    FNode: TTreeNode;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TQueuesPopulatedCallback;
    FQueueService: TAzureQueueService;
    FForceExpand: Boolean;
  public
    constructor Create(Node: TTreeNode; ConnectionInfo: TAzureConnectionString;
                       Callback: TQueuesPopulatedCallback; ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TMessagePopulator = class(TThread)
  protected
    FNode: TTreeNode;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TMessagesPopulatedCallback;
    FQueueService: TAzureQueueService;
    FForceExpand: Boolean;

    function GetMessageCount(QueueName: String): Integer;
  public
    constructor Create(Node: TTreeNode; ConnectionInfo: TAzureConnectionString;
                       Callback: TMessagesPopulatedCallback; ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TQueueMetadataUpdater = class(TThread)
  protected
    FQueueName: String;
    FConnectionInfo: TAzureConnectionString;
    FQueueService: TAzureQueueService;
    FParent: TAzureQueueManagement;
  public
    constructor Create(QueueName: String; ConnectionInfo: TAzureConnectionString;
                       Parent: TAzureQueueManagement); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TQueueCreator = class(TThread)
  protected
    FQueueName: String;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TQueueCreatedCallback;
    FQueueService: TAzureQueueService;
    FForceExpand: Boolean;
  public
    constructor Create(QueueName: String; ConnectionInfo: TAzureConnectionString;
                       Callback: TQueueCreatedCallback; ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TQueueDeletor = class(TThread)
  protected
    FQueueName: String;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TQueueDeletedCallback;
    FQueueService: TAzureQueueService;
    FForceExpand: Boolean;
  public
    constructor Create(QueueName: String; ConnectionInfo: TAzureConnectionString;
                       Callback: TQueueDeletedCallback; ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TMessageCreator = class(TThread)
  protected
    FQueueNode: TTreeNode;
    FMessage: String;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TMessageCreatedCallback;
    FQueueService: TAzureQueueService;
    FForceExpand: Boolean;
  public
    constructor Create(QueueNode: TTreeNode; MessageText: String; ConnectionInfo: TAzureConnectionString;
                       Callback: TMessageCreatedCallback; ForceExpand: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TMessageDeletor = class(TThread)
  protected
    FQueueNode: TTreeNode;
    FConnectionInfo: TAzureConnectionString;
    FCallback: TMessageRemovedCallback;
    FQueueService: TAzureQueueService;
    FForceExpand: Boolean;
    FClearAll: Boolean;
  public
    constructor Create(QueueNode: TTreeNode; ConnectionInfo: TAzureConnectionString;
                       Callback: TMessageRemovedCallback; ForceExpand: Boolean;
                       ClearAll: Boolean); Virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

function GetNodeData(Node: TTreeNode; NodeType: TNodeType = azqUnknown): TNodeData;
begin
  //NodeType should only be unknown if the data is already assigned and not being created here
  Assert((NodeType <> azqUnknown) or Assigned(Node.Data));

  if not Assigned(Node.Data) then
  begin
    if NodeType = azqMessage then
      Node.Data := Pointer(TMessageNodeData.Create)
    else
      Node.Data := Pointer(TNodeData.Create);

    TNodeData(Node.Data).NodeType := NodeType;
  end;

  Result := TNodeData(Node.Data);
end;

{ TAzureQueueManagement }

procedure TAzureQueueManagement.ActivateAction(Sender: TObject);
begin
  SetActive(True);
end;

procedure TAzureQueueManagement.AddMessageAction(Sender: TObject);
var
  Data: TNodeData;
  Msg: String;
begin
  if (FMenuNode <> nil) and not IsNodeLoading(FMenuNode) then
  begin
    Data := FMenuNode.Data;
    Assert(Data.NodeType = azqQueue);

    Msg := InputBox(SAddMsgTitle, SAddMsgMessage, EmptyStr);

    if Msg <> EmptyStr then
    begin
      TMessageCreator.Create(FMenuNode, Msg, FConnectionInfo, MessageCreated, True);
    end;
  end;
end;

procedure TAzureQueueManagement.AddQueueAction(Sender: TObject);
var
  QueueName: String;
begin
  if not IsNodeLoading(GetNodeAt(0, 0)) then
  begin
    QueueName := InputBox(SAddQueueTitle, SAddQueueMessage, EmptyStr);

    if QueueName <> EmptyStr then
    begin
      QueueName := AnsiLowerCase(QueueName);
      TQueueCreator.Create(QueueName, FConnectionInfo, QueueCreated, True);
    end;
  end;
end;

procedure TAzureQueueManagement.ClearMessagesAction(Sender: TObject);
var
  Data: TNodeData;
begin
  if (FMenuNode <> nil) and not IsNodeLoading(FMenuNode) and ConfirmDeleteItem(True) then
  begin
    Data := FMenuNode.Data;

    Assert(Data.NodeType = azqQueue);

    TMessageDeletor.Create(FMenuNode, FConnectionInfo, MessageRemoved, True, True);
  end;
end;

constructor TAzureQueueManagement.Create(AOwner: TComponent);
begin
  inherited;
  FMessageLength := 20;
  FActive := False;
  ReadOnly := True;
  OnExpanded := HandleNodeExpanded;
  OnCollapsing := HandleNodeCollapsing;
  OnGetImageIndex := OnImageIndex;
  OnCreateNodeClass := HandleCreateNodeClass;
  OnDblClick := HandleDoubleClick;
  OnKeyUp := HandleKeyUp;
  PopupMenu := CreatePopupMenu;
  FMessageActivate := nil;
  Images := CreateImageList;
  OnHint := OnGetHint;
  RightClickSelect := True;
  FMenuNode := nil;

  TAzureService.SetUp;
end;

function TAzureQueueManagement.CreateImageList: TCustomImageList;
var
  Images: TCustomImageList;
  BMP: Vcl.Graphics.TBitmap;
begin
  Images := TCustomImageList.Create(Self);

  BMP := GetAzureImage('IMG_AZUREQUEUES');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREQUEUE');
  Images.Add(BMP, nil);
  BMP.Free;

  BMP := GetAzureImage('IMG_AZUREMESSAGE');
  Images.Add(BMP, nil);
  BMP.Free;

  Result := Images;
end;

function TAzureQueueManagement.CreateLoadingNode(ParentNode: TTreeNode): TTreeNode;
var
  Node: TTreeNode;
  Nodedata: TNodeData;
begin
  Node := Items.AddChild(ParentNode, SNodeLoading);
  NodeData := GetNodeData(Node, azqLoading);
  NodeData.Value := Node.Text;

  Result := Node;
end;

function TAzureQueueManagement.CreatePopupMenu: TPopupMenu;
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
  Item.Name := ADD_QUEUE;
  Item.Caption := SAddQueue;
  Item.OnClick := AddQueueAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := REMOVE_QUEUE;
  Item.Caption := SRemoveQueue;
  Item.OnClick := RemoveQueueAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := QUEUE_METADATA;
  Item.Caption := SQueueMetadata;
  Item.OnClick := OpenQueueMetadata;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := CLEAR_MESSAGES;
  Item.Caption := SClearQueueMessages;
  Item.OnClick := ClearMessagesAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := 'N1';
  Item.Caption := cLineCaption;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := ADD_MESSAGE;
  Item.Caption := SAddMessage;
  Item.OnClick := AddMessageAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := REMOVE_MESSAGE;
  Item.Caption := SRemoveMessage;
  Item.OnClick := RemoveMessageAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := 'N2';
  Item.Caption := cLineCaption;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := REFRESH_QUEUE;
  Item.Caption := SRefresh;
  Item.OnClick := RefreshQueueAction;
  Menu.Items.Add(Item);

  Item := Menu.CreateMenuItem;
  Item.Name := REFRESH_LIST;
  Item.Caption := SRefresh;
  Item.OnClick := RefreshListAction;
  Menu.Items.Add(Item);

  Result := Menu;
end;

procedure TAzureQueueManagement.UpdatePopupMenu(Sender: TObject);
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
    else
    begin
      if MenuItem.Name = REMOVE_QUEUE then
        MenuItem.Visible := (Data <> nil) and (Data.NodeType = azqQueue)
      else if MenuItem.Name = QUEUE_METADATA then
        MenuItem.Visible := (Data <> nil) and (Data.NodeType = azqQueue)
      else if MenuItem.Name = ADD_MESSAGE then
        MenuItem.Visible := (Data <> nil) and (Data.NodeType = azqQueue)
      else if MenuItem.Name = CLEAR_MESSAGES then
        MenuItem.Visible := (Data <> nil) and (Data.NodeType = azqQueue)
      else if MenuItem.Name = REMOVE_MESSAGE then
        MenuItem.Visible := (Data <> nil) and (Data.NodeType = azqMessage) and (FMenuNode.GetPrevSibling = nil)
      else if MenuItem.Name = REFRESH_QUEUE then
        MenuItem.Visible := (Data <> nil) and (Data.NodeType = azqQueue)
      else if MenuItem.Name = REFRESH_LIST then
        MenuItem.Visible := (Data = nil) or (Data.NodeType = azqQueues)
      else if MenuItem.Name = ACTIVATE_ITEM then
        MenuItem.Visible := False
      else
        MenuItem.Visible := True;
    end;
  end;
end;

destructor TAzureQueueManagement.Destroy;
begin
  if not Assigned(CustomImages) and Assigned(Images) then
  begin
    Images.Clear;
    Images.Free;
    Images := nil;
  end;

  inherited;
end;

procedure TAzureQueueManagement.ForceCollapse(Node: TTreeNode; FullCollapse: Boolean);
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

procedure TAzureQueueManagement.HandleCreateNodeClass(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
begin
   NodeClass := TAzureTreeNode;
end;

procedure TAzureQueueManagement.HandleDoubleClick(Sender: TObject);
var
  Dialog: TAzureMsgDialog;
  Data: TMessageNodeData;
begin
  if (Selected <> nil) then
  begin
    if GetNodeData(Selected).NodeType = azqMessage then
    begin
      Data := TMessageNodeData(GetNodeData(Selected));
      if Assigned(FMessageActivate) then
        FMessageActivate(Data)
      else
      begin
        Dialog := TAzureMsgDialog.Create(Self);
        Dialog.SetMessage(TMessageNodeData(GetNodeData(Selected)));
        Dialog.ShowModal;
        Dialog.Free;
      end;
    end;
  end;
end;

procedure TAzureQueueManagement.HandleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  NodeData: TNodeData;
  IsDelete: Boolean;
  IsRefresh: Boolean;
begin
  IsDelete := Key = VK_DELETE;
  IsRefresh := Key = VK_F5;

  if (Selected <> nil) and (IsDelete or IsRefresh) then
  begin
    NodeData := Selected.Data;
    FMenuNode := Selected;
    if (NodeData.NodeType = azqQueues) and IsRefresh then
      RefreshListAction(Sender)
    else if NodeData.NodeType = azqQueue then
    begin
      if IsDelete then
        RemoveQueueAction(Sender)
      else
        RefreshQueueAction(Sender);
    end
    else if IsDelete and (NodeData.NodeType = azqMessage) and (Selected.getPrevSibling = nil) then
      RemoveMessageAction(Sender);
  end
  else if (Key = VK_RETURN) then
    while ssShift in Shift do
    begin
      HandleDoubleClick(Sender);
      Break;
    end;
end;

procedure TAzureQueueManagement.HandleNodeCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
begin
  AllowCollapse := FForceCollapse or not isNodeLoading(Node);
end;

procedure TAzureQueueManagement.HandleNodeExpanded(Sender: TObject; Node: TTreeNode);
var
  NodeData: TNodeData;
  LoadingNode: TTreeNode;
begin
  if isNodeLoading(Node) then
  begin
    LoadingNode := Node.getFirstChild;
    NodeData := GetNodeData(LoadingNode);
    Assert(NodeData.NodeType = azqLoading);

    PopulateForNode(Node);
  end;
end;

function TAzureQueueManagement.HasLoadingNode(Node: TTreeNode): Boolean;
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

procedure TAzureQueueManagement.InitializeTree;
var
  Node: TTreeNode;
  NodeData: TNodeData;
begin
  Items.Clear;

  Node := Items.AddChild(nil, SNodeAzureQueueRoot);
  NodeData := GetNodeData(Node, azqQueues);
  NodeData.Value := Node.Text;

  CreateLoadingNode(Node);
end;

function TAzureQueueManagement.isNodeLoading(Node: TTreeNode): Boolean;
var
  LoadingNode: TTreeNode;
begin
  Result := False;

  //is only loading if the loading node is exposed
  if (Node <> nil) and (Node.Count = 1) and Node.Expanded then
  begin
    LoadingNode := Node.getFirstChild;
    Result := (GetNodeData(LoadingNode).NodeType = azqLoading);
  end;
end;

procedure TAzureQueueManagement.OnGetHint(Sender: TObject; const Node: TTreeNode; var Hint: string);
var
  Data: TNodeData;
begin
  Hint := EmptyStr;

  Data := GetNodeData(Node);

  if Data.NodeType = azqMessage then
  begin
    if TMessageNodeData(Data).MessageText <> Node.Text then
      Hint := TMessageNodeData(Data).MessageText;
  end;
end;

procedure TAzureQueueManagement.OnImageIndex(Sender: TObject; Node: TTreeNode);
var
  Data: TNodeData;
  Indx: Integer;
begin
  Data := GetNodeData(Node);

  case Data.NodeType of
    azqQueues: Indx := 0;
    azqQueue: Indx := 1;
    azqMessage: Indx := 2;
    else
      Indx := -1;
  end;

  Node.ImageIndex := Indx;
  Node.SelectedIndex := Indx;
end;

procedure TAzureQueueManagement.OpenQueueMetadata(Sender: TObject);
var
  Data: TNodeData;
  QueueName: String;
begin
  if (FMenuNode <> nil) then
  begin
    Data := GetNodeData(FMenuNode);

    if Data.NodeType = azqQueue then
    begin
      QueueName := Data.Value;

      TQueueMetadataUpdater.Create(QueueName, FConnectionInfo, Self);
    end;
  end;
end;

procedure TAzureQueueManagement.PopulateForNode(Node: TTreeNode; ForceExpand: Boolean);
var
  NodeData: TNodeData;
begin
  NodeData := GetNodeData(Node);

  if (NodeData.NodeType = azqQueues) then
    TQueuePopulator.Create(Node, FConnectionInfo, PopulateQueues, ForceExpand)
  else if (NodeData.NodeType = azqQueue) then
    TMessagePopulator.Create(Node, FConnectionInfo, PopulateMessages, ForceExpand);

end;

procedure TAzureQueueManagement.PopulateMessages(Node: TTreeNode; Messages: TList<TMessageNodeData>;
                                                 TotalMessages: Integer; ForceExpand: Boolean);
var
  NodeData: TMessageNodeData;
  NewChild: TTreeNode;
  MoreData: TNodeData;
  ShortMessage: String;
begin
  if not FActive then
    Exit;

  if Messages = nil then
  begin
    Node.Collapse(False);
    Exit;
  end;

  Assert(TotalMessages > -1);

  Items.BeginUpdate;

  try
    Node.DeleteChildren;

    for NodeData in Messages do
    begin
      ShortMessage := NodeData.MessageText;
      if Length(ShortMessage) > FMessageLength then
        ShortMessage := Format('%s...', [Copy(ShortMessage, 0, FMessageLength)]);

      NewChild := Items.AddChild(Node, ShortMessage);
      NewChild.Data := Pointer(NodeData);
    end;

    if TotalMessages > Messages.Count then
    begin
      NewChild := Items.AddChild(Node, Format(SMoreMessages,[(TotalMessages - Messages.Count)]));
      MoreData := GetNodeData(NewChild, azqTruncated);
      MoreData.Value := NewChild.Text;
    end;
  finally
    if ForceExpand and not Node.Expanded then
      Node.Expand(False);
    Items.EndUpdate;
    FreeAndNil(Messages);
  end;
end;

procedure TAzureQueueManagement.PopulateQueues(Node: TTreeNode; QueueNames: TStringList;
                                               ForceExpand: Boolean; ErrorMessage: String);
var
  QueueName: String;
  QueueNode: TTreeNode;
  QueueNodeData: TNodeData;
begin
  if not FActive or (Node = nil) then
  begin
    ForceCollapse(nil);
    Exit;
  end;

  if (QueueNames = nil) or (ErrorMessage <> EmptyStr) then
  begin
    if (ErrorMessage <> EmptyStr) then
      MessageDlg(ErrorMessage, mtError, [mbOK], 0);
    ForceCollapse(nil);
    Exit;
  end;

  Items.BeginUpdate;

  try
    Node.DeleteChildren;

    for QueueName in QueueNames do
    begin
      QueueNode := Items.AddChild(Node, QueueName);
      QueueNodeData := GetNodeData(QueueNode, azqQueue);
      QueueNodeData.Value := QueueNode.Text;

      CreateLoadingNode(QueueNode);
    end;
  finally
    if ForceExpand and not Node.Expanded then
      Node.Expand(False);
    Items.EndUpdate;
    FreeAndNil(QueueNames);
  end;
end;

procedure TAzureQueueManagement.QueueCreated(QueueName: String; Success: Boolean; ForceExpand: Boolean);
begin
  if not FActive then
    Exit;

  if Success then
    PopulateForNode(GetNodeAt(0, 0), ForceExpand)
  else
    MessageDlg(Format(SAddQueueError, [QueueName]), mtError, [mbOK], 0);
end;

procedure TAzureQueueManagement.QueueDeleted(QueueName: String; Success, ForceExpand: Boolean);
begin
  if not FActive then
    Exit;

  if Success then
    PopulateForNode(GetNodeAt(0, 0), ForceExpand)
  else
    MessageDlg(Format(SDeleteQueueError, [QueueName]), mtError, [mbOK], 0);
end;

procedure TAzureQueueManagement.MessageCreated(QueueNode: TTreeNode; Success, ForceExpand: Boolean);
begin
  if not FActive or (QueueNode = nil) then
    Exit;

  if Success then
    PopulateForNode(QueueNode, ForceExpand)
  else
    MessageDlg(Format(SAddQueueMessageError, [QueueNode.Text]), mtError, [mbOK], 0);
end;

procedure TAzureQueueManagement.MessageRemoved(QueueNode: TTreeNode; Success, ForceExpand: Boolean);
begin
  if not FActive or (QueueNode = nil) then
    Exit;

  if Success then
    PopulateForNode(QueueNode, ForceExpand)
  else
    MessageDlg(Format(SRemoveQueueMessageError, [QueueNode.Text]), mtError, [mbOK], 0);
end;

procedure TAzureQueueManagement.RefreshListAction(Sender: TObject);
var
  RootNode: TTreeNode;
begin
  RootNode := GetNodeAt(0, 0);
  if not HasLoadingNode(RootNode) then
  begin
    //add a loading node when refreshing queues
    Items.BeginUpdate;
    RootNode.DeleteChildren;
    CreateLoadingNode(RootNode);
    RootNode.Expand(False);
    Items.EndUpdate;

    PopulateForNode(RootNode, True);
  end;
end;

procedure TAzureQueueManagement.RefreshQueueAction(Sender: TObject);
var
  Data: TNodeData;
begin
  if (FMenuNode <> nil) and not IsNodeLoading(FMenuNode) then
  begin
    Data := FMenuNode.Data;
    Assert(Data.NodeType = azqQueue);

    //add a loading node when refreshing queue
    Items.BeginUpdate;
    FMenuNode.DeleteChildren;
    CreateLoadingNode(FMenuNode);
    FMenuNode.Expand(False);
    Items.EndUpdate;

    PopulateForNode(FMenuNode, True);
  end;
end;

procedure TAzureQueueManagement.RemoveMessageAction(Sender: TObject);
var
  Data: TNodeData;
begin
  if (FMenuNode <> nil) and not IsNodeLoading(FMenuNode) and ConfirmDeleteItem then
  begin
    Data := FMenuNode.Data;

    Assert(Data.NodeType = azqMessage);

    TMessageDeletor.Create(FMenuNode.Parent, FConnectionInfo, MessageRemoved, True, False);
  end;
end;

procedure TAzureQueueManagement.RemoveQueueAction(Sender: TObject);
var
  Data: TNodeData;
begin
  if (FMenuNode <> nil) and not IsNodeLoading(FMenuNode) then
  begin
    if ConfirmDeleteItem then
    begin
      Data := FMenuNode.Data;
      Assert(Data.NodeType = azqQueue);
      TQueueDeletor.Create(FMenuNode.Text, FConnectionInfo, QueueDeleted, True);
    end;
  end;
end;

function TAzureQueueManagement.Activate: Boolean;
begin
  Result := False;
  if FConnectionInfo <> nil then
  begin
    InitializeTree;
    Result := True;
  end;
end;

procedure TAzureQueueManagement.SetActive(Active: Boolean);
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

procedure TAzureQueueManagement.SetCustomImages(Value: TCustomImageList);
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

procedure TAzureQueueManagement.SetMessageLength(Length: Integer);
begin
  if Length < 5 then
    FMessageLength := 5
  else if Length > 400 then
    FMessageLength := 400
  else
    FMessageLength := Length;
end;

{ TQueuePopulator }

constructor TQueuePopulator.Create(Node: TTreeNode; ConnectionInfo: TAzureConnectionString;
                                   Callback: TQueuesPopulatedCallback; ForceExpand: Boolean);
begin
  inherited Create;
  Assert(Node <> nil);
  Assert(ConnectionInfo <> nil);

  FNode := Node;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
end;

destructor TQueuePopulator.Destroy;
begin
  FreeAndNil(FQueueService);
  inherited;
end;

procedure TQueuePopulator.Execute;
var
  xml: String;
  xmlDoc: IXMLDocument;
  QueueNames: TStringList;
  QueuesXMLNode: IXMLNode;
  QueueNode: IXMLNode;
  NameNode: IXMLNode;
  ErrorMessage: String;
begin
  inherited;
  FreeOnTerminate := True;

  CoInitialize(nil);
  QueueNames := nil;
  xmlDoc := nil;
  ErrorMessage := EmptyStr;

  try
    try
      FQueueService := TAzureQueueService.Create(FConnectionInfo);

      xml := FQueueService.ListQueues([],[]);
      xmlDoc := TXMLDocument.Create(nil);
      xmlDoc.LoadFromXML(xml);

      QueueNames := TStringList.Create;

      QueuesXMLNode := xmlDoc.DocumentElement.ChildNodes.FindNode(NODE_QUEUES);

      if (QueuesXMLNode <> nil) and (QueuesXMLNode.HasChildNodes) then
      begin
        QueueNode := QueuesXMLNode.ChildNodes.FindNode(NODE_QUEUE);

        while (QueueNode <> nil) do
        begin
          if QueueNode.NodeName = NODE_QUEUE then
          begin
            NameNode := QueueNode.ChildNodes.FindNode(NODE_QUEUE_NAME);
            QueueNames.Add(NameNode.Text);
          end;
          QueueNode := QueueNode.NextSibling;
        end;
      end;
    except
      on E : Exception do
      begin
        FreeAndNil(QueueNames);
        if (FQueueService <> nil) and (FQueueService.ResponseText <> EmptyStr) then
          ErrorMessage := SErrorGeneric + FQueueService.ResponseText
        else
          ErrorMessage := E.Message;
      end;
    end;
  finally
    CoUnInitialize();
    TThread.Synchronize(nil, procedure begin FCallback(FNode, QueueNames, FForceExpand, ErrorMessage); end);
  end;
end;

{ TMessageNodeData }

constructor TMessageNodeData.Create;
begin
  FDequeueCount := -1;
  FNodeType := azqMessage;
end;

{ TNodeData }

constructor TNodeData.Create;
begin
  FNodeType := azqUnknown;
end;

{ TMessagePopulator }

constructor TMessagePopulator.Create(Node: TTreeNode; ConnectionInfo: TAzureConnectionString;
                                     Callback: TMessagesPopulatedCallback; ForceExpand: Boolean);
begin
  inherited Create;
  Assert(Node <> nil);
  Assert(ConnectionInfo <> nil);

  FNode := Node;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
end;

destructor TMessagePopulator.Destroy;
begin
  FreeAndNil(FQueueService);
  inherited;
end;

procedure TMessagePopulator.Execute;
const
  MsgRetrieveNum = 32;
var
  QueueName: String;
  Messages: TList<TMessageNodeData>;
  xml: String;
  xmlDoc: IXMLDocument;
  RootNode: IXMLNode;
  MessageNode: IXMLNode;
  AuxNode: IXMLNode;
  MessageData: TMessageNodeData;
  Added: Boolean;
  MsgCount: Integer;
begin
  inherited;
  FreeOnTerminate := True;

  CoInitialize(nil);
  Messages := nil;
  xmlDoc := nil;

  QueueName := FNode.Text;

  MsgCount := -1;

  try
    try
      FQueueService := TAzureQueueService.Create(FConnectionInfo);

      try
        MsgCount := GetMessageCount(QueueName);
      except
      end;

      xml := FQueueService.PeekMessages(QueueName, MsgRetrieveNum);
      xmlDoc := TXMLDocument.Create(nil);
      xmlDoc.LoadFromXML(xml);

      Messages := TList<TMessageNodeData>.Create;

      RootNode := xmlDoc.DocumentElement;

      if (RootNode <> nil) and (RootNode.HasChildNodes) then
      begin
        MessageNode := RootNode.ChildNodes.FindNode('QueueMessage');

        while (MessageNode <> nil) do
        begin
          Added := False;

          //making sure to only add the message if all of its values are valid
          if MessageNode.NodeName = 'QueueMessage' then
          begin
            MessageData := TMessageNodeData.Create;
            AuxNode := MessageNode.ChildNodes.FindNode('MessageId');
            if AuxNode <> nil then
            begin
              MessageData.MessageId := AuxNode.Text;
              AuxNode := MessageNode.ChildNodes.FindNode('InsertionTime');
              if AuxNode <> nil then
              begin
                MessageData.InsertTime := AuxNode.Text;
                AuxNode := MessageNode.ChildNodes.FindNode('ExpirationTime');
                if AuxNode <> nil then
                begin
                  MessageData.ExpireTime := AuxNode.Text;
                  AuxNode := MessageNode.ChildNodes.FindNode('DequeueCount');
                  if AuxNode <> nil then
                  begin
                    try
                      MessageData.DequeueCount := StrToInt(AuxNode.Text);
                      AuxNode := MessageNode.ChildNodes.FindNode('MessageText');
                      if AuxNode <> nil then
                      begin
                        MessageData.MessageText := AuxNode.Text;
                        Messages.Add(MessageData);
                        Added := True;
                      end;
                    except
                    end;
                  end;
                end;
              end;
            end;
          end;

          if not Added then
            FreeAndNil(MessageData);

          MessageNode := MessageNode.NextSibling;
        end;
      end;
    except
      FreeAndNil(Messages);
    end;
  finally
    CoUninitialize;
    TThread.Synchronize(nil, procedure begin FCallback(FNode, Messages, MsgCount, FForceExpand); end);
  end;
end;

function TMessagePopulator.GetMessageCount(QueueName: String): Integer;
var
  ValS: String;
begin
  Result := -1;
  Assert(FQueueService <> nil);
  if FQueueService.GetQueueMetadata(QueueName) then
  begin
    ValS := FQueueService.ResponseHeader['x-ms-approximate-messages-count'];
    try
      Result := StrToInt(ValS);
    except
    end;
  end;
end;

{ TQueueCreator }

constructor TQueueCreator.Create(QueueName: String; ConnectionInfo: TAzureConnectionString;
                                 Callback: TQueueCreatedCallback; ForceExpand: Boolean);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);

  FQueueName := QueueName;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
end;

destructor TQueueCreator.Destroy;
begin
  FreeAndNil(FQueueService);
  inherited;
end;

procedure TQueueCreator.Execute;
var
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;
  CoInitialize(nil);

  try
    try
      FQueueService := TAzureQueueService.Create(FConnectionInfo);
      Success := FQueueService.CreateQueue(AnsiLowerCase(FQueueName));
    except
      Success := False;
    end;
  finally
    CoUninitialize;
    TThread.Synchronize(nil, procedure begin FCallback(FQueueName, Success, FForceExpand); end);
  end;
end;

{ TQueueDeletor }

constructor TQueueDeletor.Create(QueueName: String; ConnectionInfo: TAzureConnectionString;
  Callback: TQueueDeletedCallback; ForceExpand: Boolean);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);

  FQueueName := QueueName;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
end;

destructor TQueueDeletor.Destroy;
begin
  FreeAndNil(FQueueService);
  inherited;
end;

procedure TQueueDeletor.Execute;
var
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;
  CoInitialize(nil);

  try
    try
      FQueueService := TAzureQueueService.Create(FConnectionInfo);
      Success := FQueueService.DeleteQueue(AnsiLowerCase(FQueueName));
    except
      Success := False;
    end;
  finally
    CoUninitialize;
    TThread.Synchronize(nil, procedure begin FCallback(FQueueName, Success, FForceExpand); end);
  end;
end;

{ TMessageCreator }

constructor TMessageCreator.Create(QueueNode: TTreeNode; MessageText: String; ConnectionInfo: TAzureConnectionString;
                                   Callback: TMessageCreatedCallback; ForceExpand: Boolean);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);

  FQueueNode := QueueNode;
  FMessage := MessageText;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
end;

destructor TMessageCreator.Destroy;
begin
  FreeAndNil(FQueueService);
  inherited;
end;

procedure TMessageCreator.Execute;
var
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;
  CoInitialize(nil);

  try
    try
      FQueueService := TAzureQueueService.Create(FConnectionInfo);
      Success := FQueueService.PutMessage(AnsiLowerCase(FQueueNode.Text), FMessage);
    except
      Success := False;
    end;
  finally
    CoUninitialize;
    TThread.Synchronize(nil, procedure begin FCallback(FQueueNode, Success, FForceExpand); end);
  end;
end;

{ TMessageDeletor }

constructor TMessageDeletor.Create(QueueNode: TTreeNode; ConnectionInfo: TAzureConnectionString;
                                   Callback: TMessageRemovedCallback; ForceExpand: Boolean;
                                   ClearAll: Boolean);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);
  Assert(QueueNode <> nil);
  Assert(GetNodeData(QueueNode).NodeType = azqQueue);

  FQueueNode := QueueNode;
  FConnectionInfo := ConnectionInfo;
  FCallback := Callback;
  FForceExpand := ForceExpand;
  FClearAll := ClearAll;
end;

destructor TMessageDeletor.Destroy;
begin
  FreeAndNil(FQueueService);
  inherited;
end;

procedure TMessageDeletor.Execute;
var
  Success: Boolean;
  xml: String;
  popReceipt: String;
  MessageNode: TTreeNode;
  MessageData: TMessageNodeData;
begin
  inherited;
  FreeOnTerminate := True;
  CoInitialize(nil);
  Success := False;

  try
    try
      FQueueService := TAzureQueueService.Create(FConnectionInfo);

      if FClearAll then
      begin
        Success := FQueueService.ClearMessages(FQueueNode.Text);
      end
      else
      begin
        xml := FQueueService.GetMessages(FQueueNode.Text, 1);
        popReceipt := FQueueService.GetPopReceipt(xml);

        if popReceipt <> EmptyStr then
        begin
          Assert(FQueueNode.HasChildren);
          MessageNode := FQueueNode.getFirstChild;

          Assert(GetNodeData(MessageNode).NodeType = azqMessage);
          MessageData := TMessageNodeData(GetNodeData(MessageNode));

          Success := FQueueService.DeleteMessage(FQueueNode.Text, MessageData.MessageId, popReceipt);
        end;
      end;
    except
      Success := False;
    end;
  finally
    CoUninitialize;
    TThread.Synchronize(nil, procedure begin FCallback(FQueueNode, Success, FForceExpand); end);
  end;
end;

{ TQueueMetadataUpdater }

constructor TQueueMetadataUpdater.Create(QueueName: String; ConnectionInfo: TAzureConnectionString;
                                         Parent: TAzureQueueManagement);
begin
  inherited Create;
  Assert(ConnectionInfo <> nil);

  FQueueName := QueueName;
  FConnectionInfo := ConnectionInfo;
  FParent := Parent;
end;

destructor TQueueMetadataUpdater.Destroy;
begin
  FreeAndNil(FQueueService);
  inherited;
end;

procedure TQueueMetadataUpdater.Execute;
var
  Dialog: TAzureQueueMetadataDialog;
  Metadata, ModMetadata: TStringList;
  Count, I: Integer;
  AKey, AVal: String;
  Success: Boolean;
begin
  inherited;
  FreeOnTerminate := True;

  Metadata := nil;
  ModMetadata := nil;

  Success := False;

  try
    try
      FQueueService := TAzureQueueService.Create(FConnectionInfo);
      if FQueueService.GetQueueMetadata(FQueueName) then
      begin
        Metadata := TStringList.Create;
        FQueueService.PopulateContainer('x-ms-meta-', Metadata, True);

        TThread.Synchronize(nil,
          procedure
          begin
            Dialog := TAzureQueueMetadataDialog.Create(FParent);
            try
              Dialog.SetActiveQueue(FQueueName, Metadata);
              FreeAndNil(MetaData); //Will reuse the variable lower down

              if Dialog.ShowModal = mrOK then
              begin
                Metadata := Dialog.GetMetadata;
                ModMetadata := TStringList.Create;
              end
              else
                Success := True; //Closed the dialog, so finished successfully
            finally
              FreeAndNil(Dialog);
            end;
          end);

        if Metadata <> nil then
        begin
          Count := Metadata.Count;
          for I := 0 to Count - 1 do
          begin
            AKey := Metadata.Names[I];
            if AKey <> EmptyStr then
            begin
              AVal := Metadata.ValueFromIndex[I];
              if not AnsiStartsText('x-ms-meta-', AKey) then
                AKey := 'x-ms-meta-' + AKey;

              ModMetadata.Values[AKey] := AVal;
            end;
          end;
          Success := FQueueService.PutQueueMetadata(FQueueName, ModMetadata);
        end;
      end;
    except
      Success := False;
    end;
  finally
    FreeAndNil(Metadata);
    FreeAndNil(ModMetadata);
    if not Success then
    begin
      TThread.Queue(nil, procedure
        begin
          MessageDlg(Format(SQueueMetadataError, [FQueueName]), mtError, [mbOK], 0);
        end);
    end;
  end;
end;

end.
