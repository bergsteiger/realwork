{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Design.Style;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows, Registry,
  {$ENDIF}
  ComponentDesigner, DesignIntf, DesignEditors, ToolsAPI, 
  PaletteAPI, StructureViewAPI,
  SysUtils, Classes, ActiveX, ShlObj,
  FmxEditors, System.UITypes, System.Rtti,
  Generics.Collections, System.Generics.Defaults,
  FMX.Forms, FMX.Dialogs, FMX.Types, FMX.Layouts, FMX.TreeView, FMX.StdCtrls,
  FMX.Controls, FMX.Objects, FMX.ListBox, FMX.Edit, FMX.Design.Brush,
  FmxDesignWindows, FMX.ExtCtrls, FMX.Styles;

type
  TStyleStructureNode = class(TFmxObject, IOTAStructureNode, 
    IOTASortableStructureNode, IOTADragStructureNode)
  private
    FExpanded: Boolean;
    FCaption: WideString;
    FFocused: Boolean;
    FObject: TFmxObject;
    FSelected: Boolean;
    function AddChildNode(const ANode: IOTAStructureNode; Index: Integer = -1): Integer; safecall;
    function Get_Caption: WideString; safecall;
    function Get_ChildCount: Integer; safecall;
    function Get_Child(Index: Integer): IOTAStructureNode; safecall;
    function Get_Expanded: WordBool; safecall;
    procedure Set_Expanded(Value: WordBool); safecall;
    function Get_Focused: WordBool; safecall;
    procedure Set_Focused(Value: WordBool); safecall;
    function Get_Hint: WideString; safecall;
    function Get_ImageIndex: Integer; safecall;
    function Get_Name: WideString; safecall;
    function Get_Parent: IOTAStructureNode; safecall;
    function Get_Selected: WordBool; safecall;
    procedure Set_Selected(Value: WordBool); safecall;
    function Get_StateIndex: Integer; safecall;
    function Get_Data: Integer; safecall;
    procedure Set_Data(Value: Integer); safecall;
    procedure RemoveChildNode(Index: Integer); safecall;
    { IOTASortableStructureNode }
    function Get_SortByIndex: WordBool; safecall;
    function Get_ItemIndex: Integer; safecall;
    { IOTADragStructureNode }
    function DragAllowed: WordBool; safecall;
    procedure DragDrop(DataObject: OleVariant; const FormatArray: WideString;
      X, Y: Integer; KeyState: Integer; Mode: TOTADropMode; var Effect: Integer); safecall;
    function DragOver(DataObject: OleVariant; State: TOTADragState;
      X, Y: Integer; KeyState: Integer; Mode: TOTADropMode; var Effect: Integer): WordBool; safecall;
  public
  end;
  
  TStyleDesigner = class(TFmxDesignWindow, IOTAPaletteDragAcceptor, 
    IOTAStructureContext, IOTAStructureContextToolbar, IOTADragStructureContext)
    tbMain: TToolBar;
    btnLoad: TButton;
    btnSave: TButton;
    btnClear: TButton;
    btnApply: TButton;
    dlgOpenStyle: TOpenDialog;
    dlgSaveStyle: TSaveDialog;
    btnClose: TButton;
    btnApplyClose: TButton;
    btnMerge: TButton;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DesignRootDragOver(Sender: TObject;
      const Data: TDragObject; const Point: TPoint;
      var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnApplyCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnMergeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    FVclHost: TComponent;
    FVclHostOnResize: TNotifyEvent;
    FTreeRoot: TStyleStructureNode;
    FSelection: TSelection;
    FStoredClassGroup: TPersistentClass;
    FLastSelectedRoot: TFmxObject;
    FSaveContext: IOTAStructureContext;
    FStructureView: IOTAStructureView;
    FDragNode: IOTAStructureNode;
    FRemoveList: TList<TStyleStructureNode>;
    function Selection: TSelection;
    procedure UpdateTree;
    procedure DoSelectionTrack(Sender: TObject);
    procedure DoObjectClick(Sender: TObject);
    procedure CreateEmptyRoot;
    { IOTAStructureContext }
    function Get_ContextIdent: WideString; safecall;
    function Get_StructureType: WideString; safecall;
    function Get_ViewOptions: Integer; safecall;
    function Get_RootNodeCount: Integer; safecall;
    function GetRootStructureNode(Index: Integer): IOTAStructureNode; safecall;
    function SameContext(const AContext: IOTAStructureContext): WordBool; safecall;
    procedure InitPopupMenu(const Node: IOTAStructureNode;
      const PopupMenu: IOTAStructureNodeMenuItem); safecall;
    procedure AddRootNode(const ANode: IOTAStructureNode; Index: Integer); safecall;
    procedure RemoveRootNode(const ANode: IOTAStructureNode); safecall;
    procedure NodeSelected(const Node: IOTAStructureNode); safecall;
    procedure NodeFocused(const Node: IOTAStructureNode); safecall;
    procedure NodeEdited(const Node: IOTAStructureNode); safecall;
    procedure DefaultNodeAction(const Node: IOTAStructureNode); safecall;
    { IOTAPaletteDragAcceptor}
    function GetHandle: THandle;
    function GetHWND: HWND;
    procedure LoadFromFile(AFileName: string);
    procedure AddFromFile(AFileName: string);
    { IOTAStructureContextToolbar }
    function Get_ButtonCount: Integer; safecall;
    function GetButtonCaption(Index: Integer): WideString; safecall;
    function GetButtonEnabled(Index: Integer): WordBool; safecall;
    function GetButtonEnableDropDown(Index: Integer): WordBool; safecall;
    function GetButtonHasDropDown(Index: Integer): WordBool; safecall;
    function GetButtonHint(Index: Integer): WideString; safecall;
    function GetButtonImageIndex(Index: Integer): Integer; safecall;
    function GetButtonMenu(Index: Integer): IOTAStructureNodeMenuItem; safecall;
    function GetButtonSeparator(Index: Integer): WordBool; safecall;
    function GetButtonVisible(Index: Integer): WordBool; safecall;
    procedure Invoke(Index: Integer); safecall;
    { IOTADragStructureContext }
    function DragAllowed(const Node: IOTAStructureNode): WordBool; safecall;
    {$WARNINGS OFF}
    procedure DragDrop(const Node: IOTAStructureNode;
      DataObject: OleVariant; const FormatArray: WideString;
      X, Y: Integer; KeyState: Integer; Mode: TOTADropMode; var Effect: Integer); safecall;
    function DragOver(const Node: IOTAStructureNode;
      DataObject: OleVariant; State: TOTADragState;
      X, Y: Integer; KeyState: Integer; Mode: TOTADropMode; var Effect: Integer): WordBool; safecall;
    {$WARNINGS ON}
    function GetDataObject: OleVariant; safecall;
  protected
    FChangesMade: Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure VclHostResized(Sender: TObject);
    procedure ReleaseHostReferences();
  public
    { Public declarations }
    DesignRoot: TControl;
    FStyleBook: TStyleBook;
    procedure LoadFromStrings(Str: TStrings);
    procedure SaveToStrings(Str: TStrings);
    procedure SetVclHost(HostControl: TComponent);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;
    procedure DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean); override;
    procedure ItemsModified(const Designer: IDesigner); override;
    { IEditHandler }
    function GetEditState: TEditState; override;
    function EditAction(Action: TEditAction): Boolean; override;
    { }
    procedure SelectByName(const AName: string);
  end;

resourcestring
  sOpenStyleFilter = 'FireMonkey Style|*.style;*.fsf';
  sSaveStyleFilter = 'FireMonkey Style|*.style|FireMonkey Style Binary|*.fsf';

var
  StyleDesigner: TStyleDesigner;

implementation

uses TypInfo, Math, VCL.Forms, FMX.Platform.Win,
  System.Types, FmxDsnConst, FMX.Consts;

{$R *.fmx}

var
  SaveDesigner: IDesigner;

type
  TStyleCompare = class(TComparer<TStyleStructureNode>)
  public
    function Compare(const Left, Right: TStyleStructureNode): Integer; override;
  end;

function TStyleCompare.Compare(const Left, Right: TStyleStructureNode): Integer;
begin
  Result := CompareText(Left.FCaption, Right.FCaption);
end;

{ StrtucreView }

function TStyleStructureNode.AddChildNode(const ANode: IOTAStructureNode; Index: Integer = -1): Integer; 
begin
  InsertObject(Index, TStyleStructureNode(ANode));
end;
    
function TStyleStructureNode.Get_Caption: WideString; 
begin
  Result := FCaption;
end;

function TStyleStructureNode.Get_ChildCount: Integer; 
begin
  Result := ChildrenCount;
end;
    
function TStyleStructureNode.Get_Child(Index: Integer): IOTAStructureNode; 
begin
  Result := TStyleStructureNode(Children[Index]);
end;
    
function TStyleStructureNode.Get_Expanded: WordBool; 
begin
  if Assigned(Parent) and not Assigned(Parent.Parent) then
    Result := True
  else
    Result := FExpanded;
end;
    
procedure TStyleStructureNode.Set_Expanded(Value: WordBool); 
begin
  FExpanded := Value;
end;
    
function TStyleStructureNode.Get_Focused: WordBool; 
begin
  Result := FFocused;
end;
    
procedure TStyleStructureNode.Set_Focused(Value: WordBool); 
begin
  FFocused := Value;
end;
    
function TStyleStructureNode.Get_Hint: WideString; 
begin
  Result := '';
end;
    
function TStyleStructureNode.Get_ImageIndex: Integer; 
begin
  if Assigned(Parent) and not Assigned(Parent.Parent) then
    Result := 7
  else
    Result := 5;
end;
    
function TStyleStructureNode.Get_Name: WideString;
begin
  Result := FCaption;  
end;
    
function TStyleStructureNode.Get_Parent: IOTAStructureNode; 
begin
  Result := TStyleStructureNode(Parent);
end;
    
function TStyleStructureNode.Get_Selected: WordBool; 
begin
  Result := FSelected;
end;
    
procedure TStyleStructureNode.Set_Selected(Value: WordBool); 
begin
  FSelected := Value;
end;
    
function TStyleStructureNode.Get_StateIndex: Integer; 
begin
  Result := -1;
end;
    
function TStyleStructureNode.Get_Data: Integer; 
begin
  Result := Tag;
end;
    
procedure TStyleStructureNode.Set_Data(Value: Integer); 
begin
  Tag := Value;
end;
    
procedure TStyleStructureNode.RemoveChildNode(Index: Integer); 
begin
  RemoveObject(Index);
end;
    
function TStyleStructureNode.Get_ItemIndex: Integer;
begin
  Result := 0;
end;

function TStyleStructureNode.Get_SortByIndex: WordBool;
begin
  Result := False;
end;

{ IOTADragStructureNode }

function TStyleStructureNode.DragAllowed: WordBool;
begin
  if Assigned(Parent) and not Assigned(Parent.Parent) then
    Result := False
  else
    Result := True;
end;

procedure TStyleStructureNode.DragDrop(DataObject: OleVariant;
  const FormatArray: WideString; X, Y, KeyState: Integer; Mode: TOTADropMode;
  var Effect: Integer);
var
  GetPaletteItem: IOTAGetPaletteItem;
  PaletteDragDropOp: IOTAPaletteDragDropOp;
  ObjClass: TClass;
  NewObj: TFmxObject;
  Cur, Node: TStyleStructureNode;
begin
  Effect := DROPEFFECT_NONE;
  if Supports(DataObject, IOTAGetPaletteItem, GetPaletteItem) and
    Supports(GetPaletteItem.GetPaletteItem, IOTAPaletteDragDropOp, PaletteDragDropOp) then
  begin
    ObjClass := FindClass(GetPaletteItem.GetPaletteItem.Name);
    if (ObjClass <> nil) and (ObjClass.InheritsFrom(TFmxObject)) and (ObjClass.ClassName <> TStyleBook.ClassName) then
    begin
      // make the child object
      NewObj := TFmxObjectClass(ObjClass).Create(StyleDesigner.DesignRoot.Root.GetObject);
      NewObj.Parent := FObject;
      NewObj.StyleName := StyleDesigner.Designer.UniqueName(NewObj.ClassName);
      // make the child node
      Node := TStyleStructureNode.Create(nil);
      Node.Parent := Self;
      Node.FObject := NewObj;
      Node.FCaption := NewObj.StyleName + ':' + NewObj.ClassName;
      StyleDesigner.FStructureView.StructureChanged(True);
      Effect := DROPEFFECT_COPY;
    end;
    StyleDesigner.ComponentDesigner.Environment.ResetCompClass;
  end
  else
  if Assigned(StyleDesigner.FDragNode) then
  begin
    Node := TStyleStructureNode(StyleDesigner.FDragNode);
    // Check equal
    if Node.Parent = Self then Exit;
    // check for parent
    Cur := Self;
    while Cur.Parent <> nil do
    begin
      if Cur = Node then
        Exit;
      Cur := TStyleStructureNode(Cur.Parent);
    end;
    //
    Node.Parent := Self;
    Node.FObject.Parent := FObject;
    StyleDesigner.FStructureView.StructureChanged(True);
    
    Effect := DROPEFFECT_COPY;
    StyleDesigner.FDragNode := nil;
  end;
end;

function TStyleStructureNode.DragOver(DataObject: OleVariant;
  State: TOTADragState; X, Y, KeyState: Integer; Mode: TOTADropMode;
  var Effect: Integer): WordBool;
begin
  Result := True;
end;

{ TStyleReader }

type
  TStyleReader = class(TReader)
  private
  protected
    procedure SetName(Component: TComponent; var Name: string); override;
    function Error(const Message: string): Boolean; override;
  end;


function TStyleReader.Error(const Message: string): Boolean;
begin
  Result := True;
end;

procedure TStyleReader.SetName(Component: TComponent; var Name: string);
begin
  Name := '';
end;

function GetCurrentPlatform: string;
var
 Proj: IOTAProject;
 function GetCurrentProject: IOTAProject;
 var
   Services: IOTAModuleServices;
   Module: IOTAModule;
   Project: IOTAProject;
   ProjectGroup: IOTAProjectGroup;
   MultipleProjects: boolean;
   I: integer;
 begin
   Result   := nil;
   MultipleProjects := False;
   Services := BorlandIDEServices as IOTAModuleServices;
   Module := Services.CurrentModule;
   if (Module = nil) or (Module.OwnerModuleCount <> 1) then
   begin
     for I := 0 to Services.ModuleCount - 1 do
     begin
       Module := Services.Modules[I];
       if Module.QueryInterface(IOTAProjectGroup, ProjectGroup) = S_OK then
       begin
         Result := ProjectGroup.ActiveProject;
         Exit;
       end
       else if Module.QueryInterface(IOTAProject, Project) = S_OK then
       begin
         if Result = nil then
           Result := Project
         else
           MultipleProjects := True;
       end;
     end;
     if MultipleProjects then
       Result := nil;
   end
   else
     Result := Module.Owners[0];
 end;
begin
  Result := '';
  Proj := GetCurrentProject; //GetActiveProject;
  if Proj <> nil then
    Result := Proj.CurrentPlatform;
end;

function FindStyleDescriptor(AObject: TFmxObject): TStyleDescription;
var
  I: Integer;
  Founded: Boolean;
  DescriptorTmp: TStyleDescription;
begin
  I := 0;
  Founded := False;
  DescriptorTmp := nil;
  while (I < AObject.ChildrenCount) and not Founded do
    if AObject.Children[I] is TStyleDescription then
    begin
      Founded := True;
      DescriptorTmp := AObject.Children[I] as TStyleDescription;
    end
    else
    begin
       DescriptorTmp := FindStyleDescriptor(AObject.Children[I]);
       Founded := Assigned(DescriptorTmp);
       Inc(I);
    end;
  Result := DescriptorTmp;
end;

function LoadStyleFromIndexedStream(const AStream: TStream): TFmxObject;
var
  StyleContainer: TStyleContainer;
begin
  StyleContainer := TStyleContainer.Create(nil);
  StyleContainer.LoadFromIndexedStream(AStream);
  Result := StyleContainer;
end;

function LoadStyleFromStream(const AStream: TStream): TFmxObject;
var
  BinStream: TStream;
  Reader: TStyleReader;
  Sign: array of Byte;
begin
  Result := nil;
  // Ensure the correct class group is active
  ActivateClassGroup(TFmxObject);
  try
    SetLength(Sign, 13);
    case TestStreamFormat(AStream) of
      sofUnknown: begin
        AStream.Read(Sign[0], Length(Sign));
        if (Sign[0] = FireMonkey25StyleSign[0]) and (Sign[1] = FireMonkey25StyleSign[1]) and (Sign[2] = FireMonkey25StyleSign[2]) and
           (Sign[3] = FireMonkey25StyleSign[3]) and (Sign[4] = FireMonkey25StyleSign[4]) and (Sign[5] = FireMonkey25StyleSign[5]) and
           (Sign[6] = FireMonkey25StyleSign[6]) and (Sign[6] = FireMonkey25StyleSign[6]) and (Sign[7] = FireMonkey25StyleSign[7]) and
           (Sign[8] = FireMonkey25StyleSign[8]) and (Sign[9] = FireMonkey25StyleSign[9]) and (Sign[10] = FireMonkey25StyleSign[10]) and
           (Sign[11] = FireMonkey25StyleSign[11]) and (Sign[12] = FireMonkey25StyleSign[12]) then
          Result := LoadStyleFromIndexedStream(AStream)
        else if (Sign[0] = FireMonkeyStyleSign[0]) and (Sign[1] = FireMonkeyStyleSign[1]) and (Sign[2] = FireMonkeyStyleSign[2]) and
           (Sign[3] = FireMonkeyStyleSign[3]) and (Sign[4] = FireMonkeyStyleSign[4]) and (Sign[5] = FireMonkeyStyleSign[5]) and
           (Sign[6] = FireMonkeyStyleSign[6]) and (Sign[6] = FireMonkeyStyleSign[6]) and (Sign[7] = FireMonkeyStyleSign[7]) and
           (Sign[8] = FireMonkeyStyleSign[8]) and (Sign[9] = FireMonkeyStyleSign[9]) and (Sign[10] = FireMonkeyStyleSign[10]) and
           (Sign[11] = FireMonkeyStyleSign[11]) and (Sign[12] = FireMonkeyStyleSign[12]) then
          Result := LoadStyleFromStream(AStream)
        else
          Result := nil;
      end;
      sofBinary: begin
        Reader := TStyleReader.Create(AStream, 4096);
        try
          Result := TFmxObject(Reader.ReadRootComponent(nil));
        finally
          Reader.Free;
        end;
      end;
      sofText, sofUTF8Text: begin
        BinStream := TMemoryStream.Create;
        try
          ObjectTextToBinary(AStream, BinStream);
          BinStream.Position := 0;
          Reader := TStyleReader.Create(BinStream, 4096);
          try
            Result := TFmxObject(Reader.ReadRootComponent(nil));
          finally
            Reader.Free;
          end;
        finally
          BinStream.Free;
        end;
      end;
    end;
  except
    Result := nil;
  end;
end;

function CheckStyle(const AStyle: TFmxObject): Boolean;
var
  Desc: TStyleDescription;
begin
  Result := True;
  // Check description
  if Assigned(AStyle) then
  begin
    Desc := FindStyleDescriptor(AStyle);
    if Assigned(Desc) and (Desc.PlatformTarget <> '') then
    begin
      if (Pos('[MSWINDOWS]', UpperCase(Desc.PlatformTarget)) > 0) and (Pos('win', LowerCase(GetCurrentPlatform)) <> 1) then
        Result := False;
      if (Pos('[MACOS]', UpperCase(Desc.PlatformTarget)) > 0) and (Pos('osx', LowerCase(GetCurrentPlatform)) <> 1) then
        Result := False;
      if (Pos('[IOS]', UpperCase(Desc.PlatformTarget)) > 0) and (Pos('ios', LowerCase(GetCurrentPlatform)) <> 1) then
        Result := False;
      if (Pos('[IOSALTERNATE]', UpperCase(Desc.PlatformTarget)) > 0) and (Pos('ios', LowerCase(GetCurrentPlatform)) <> 1) then
        Result := False;

      if not Result then
        ShowMessage(SInvalidStyleForPlatform);
    end
  end;
end;

type
  THackFmxObject = class(TFmxObject);

{ TStyleDesignerOleDropTarget }

  TStyleDesignerOleDropTarget = class(TDesignerOleDropTarget, IDropTarget,
    IOTAPaletteDragAcceptor, IOTADesignerDragAcceptor)
  private
    FLastDataObject: IDataObject;
    FWrappedDataObject: IDataObject;
    FDropTargetHelper: IDropTargetHelper;
    FStyleDesigner: TStyleDesigner;
  protected
    { IDropTarget }
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    { IOTAPaletteDragAcceptor }
    function GetHandle: THandle;
  public
    constructor Create(AStyleDesigner: TStyleDesigner);
    destructor Destroy; override;
  end;

{ TStyleDesignerOleDropTarget }

constructor TStyleDesignerOleDropTarget.Create(AStyleDesigner: TStyleDesigner);
begin
  inherited Create(nil);
  FStyleDesigner := AStyleDesigner;
end;

destructor TStyleDesignerOleDropTarget.Destroy;
begin
  inherited;
end;

function TStyleDesignerOleDropTarget.DragLeave: HResult;
begin
  Result := S_OK;
  if FDropTargetHelper <> nil then
    FDropTargetHelper.DragLeave;
  FLastDataObject := nil;
  FWrappedDataObject := nil;
  FDropTargetHelper := nil;
end;

function TStyleDesignerOleDropTarget.Drop(const dataObj: IDataObject; grfKeyState: Integer;
  pt: TPoint; var dwEffect: Integer): HResult;
var
  GetPaletteItem: IOTAGetPaletteItem;
  PaletteDragDropOp: IOTAPaletteDragDropOp;
  ObjClass: TClass;
  LControl: IControl;
begin
  Result := S_OK;
  try
    dwEffect := DROPEFFECT_NONE;
    try
      if Supports(dataObj, IOTAGetPaletteItem, GetPaletteItem) and
        Supports(GetPaletteItem.GetPaletteItem, IOTAPaletteDragDropOp, PaletteDragDropOp) then
      begin
        ObjClass := FindClass(GetPaletteItem.GetPaletteItem.Name);
        if (ObjClass <> nil) and (ObjClass.InheritsFrom(TFmxObject)) and (ObjClass.ClassName <> TStyleBook.ClassName) then
        begin
          if FStyleDesigner.DesignRoot = nil then
            FStyleDesigner.CreateEmptyRoot;
          LControl := FStyleDesigner.ObjectAtPoint(PointF(pt.X, pt.Y));
(*          if (FStyleDesigner.ObjectsTree.Selected = nil)
            or (Assigned(LControl) and (LControl.GetObject = FStyleDesigner.DropTarget1)) then
          begin
            // as new node
            NewObj := TFmxObjectClass(ObjClass).Create(FStyleDesigner.DesignRoot.Root.GetObject);
            NewObj.Parent := FStyleDesigner.DesignRoot;
            NewObj.StyleName := FStyleDesigner.Designer.UniqueName('newstyle');
          end
          else
          begin
            // use the selected item by default
            LParent := TFmxObject(FStyleDesigner.ObjectsTree.Selected.TagObject); 

            // look to see if we are over a tree item
            if Assigned(LControl) then
            begin
              if (LControl.GetObject = FStyleDesigner.ObjectsTree) then
              begin
                LPtF := LControl.ScreenToLocal(PointF(pt.X, pt.Y));
                LItem := TTreeView(LControl.GetObject).ItemByPoint(LPtF.X, LPtF.Y);
                if Assigned(LItem) and Assigned(LItem.TagObject) then
                  LParent := TFmxObject(LItem.TagObject);
              end;
            end;

            // make the child
            NewObj := TFmxObjectClass(ObjClass).Create(FStyleDesigner.DesignRoot.Root.GetObject);
            NewObj.Parent := LParent;
            NewObj.StyleName := FStyleDesigner.Designer.UniqueName(NewObj.ClassName);
          end;
          FStyleDesigner.UpdateTree;
          FStyleDesigner.ObjectsTree.Selected := TTreeViewItem(NewObj.TagObject);


          // notify the designer
          FStyleDesigner.Designer.Modified;
          FStyleDesigner.FChangesMade := True; *)

          dwEffect := DROPEFFECT_COPY;
        end;
      end;
      FStyleDesigner.ComponentDesigner.Environment.ResetCompClass;
    finally
      if FDropTargetHelper <> nil then
        FDropTargetHelper.Drop(dataObj, pt, dwEffect);
    end;
  finally
    FLastDataObject := nil;
    FWrappedDataObject := nil;
    FDropTargetHelper := nil;
  end;
end;

function TStyleDesignerOleDropTarget.DragEnter(const dataObj: IDataObject; grfKeyState: Integer;
  pt: TPoint; var dwEffect: Integer): HResult;
var
  GetPaletteItem: IOTAGetPaletteItem;
  PaletteDragDropOp: IOTAPaletteDragDropOp;
  Accept: Boolean;
begin
  if FDropTargetHelper = nil then
    CoCreateInstance(CLSID_DragDropHelper, nil, CLSCTX_INPROC_SERVER, IID_IDropTargetHelper, FDropTargetHelper);
  Result := S_OK;
  dwEffect := DROPEFFECT_NONE;
  try
    if Supports(dataObj, IOTAGetPaletteItem, GetPaletteItem) and
      Supports(GetPaletteItem.GetPaletteItem, IOTAPaletteDragDropOp, PaletteDragDropOp) then
    begin
      Accept := False;
      PaletteDragDropOp.DragOver(Self as IOTAPaletteDragAcceptor, pt.X, pt.Y, pdsDragEnter, Accept);

      if Accept then
      begin
        dwEffect := DROPEFFECT_COPY;
        FLastDataObject := dataObj;
      end;
    end;
  finally
    if FDropTargetHelper <> nil then
      FDropTargetHelper.DragEnter(FStyleDesigner.GetHWND, dataObj, pt, dwEffect);
  end;
end;

function TStyleDesignerOleDropTarget.DragOver(grfKeyState: Integer; pt: TPoint;
  var dwEffect: Integer): HResult;
var
  GetPaletteItem: IOTAGetPaletteItem;
  PaletteDragDropOp: IOTAPaletteDragDropOp;
  ObjClass: TClass;
  Accept: Boolean;
//  LControl: IControl;
//  LItem: TTreeViewItem;
//  LPtF: TPointF;
begin
//  LControl := FStyleDesigner.ObjectAtPoint(PointF(pt.X, pt.Y));
//  if Assigned(LControl) then
//  begin
//    Writeln(LControl.GetObject.Name);
//    if (LControl.GetObject = FStyleDesigner.ObjectsTree) then
//    begin
//      LPtF := LControl.ScreenToLocal(PointF(pt.X, pt.Y));
//      LItem := TTreeView(LControl.GetObject).ItemByPoint(LPtF.X, LPtF.Y);
//      if Assigned(LItem) then
//        Writeln(LItem.Text);
//    end;
//  end;
//
  Result := S_OK;
  dwEffect := DROPEFFECT_NONE;
  try
    if Supports(FLastDataObject, IOTAGetPaletteItem, GetPaletteItem) and
      Supports(GetPaletteItem.GetPaletteItem, IOTAPaletteDragDropOp, PaletteDragDropOp) then
    begin
      Accept := False;
      PaletteDragDropOp.DragOver(Self as IOTAPaletteDragAcceptor, pt.X, pt.Y, pdsDragMove, Accept);
      if Accept then
      begin
        ObjClass := FindClass(GetPaletteItem.GetPaletteItem.Name);
        if (ObjClass <> nil) and (ObjClass.InheritsFrom(TFmxObject)) and (ObjClass.ClassName <> TStyleBook.ClassName) then
        begin
          dwEffect := DROPEFFECT_COPY;
        end;
      end;
    end;
  finally
    if FDropTargetHelper <> nil then
      FDropTargetHelper.DragOver(pt, dwEffect);
  end;
end;

function TStyleDesignerOleDropTarget.GetHandle: THandle;
begin
  Result := FStyleDesigner.GetHWND;
end;

{ TStyleDesigner }

procedure TStyleDesigner.FormActivate(Sender: TObject);
var
  LHost: TComponent;
  LEditHandlerHost: IEditHandlerDelegateTrait;
begin
  LHost := FVclHost;
  if (LHost is TFrame) and not TFrame(LHost).Focused then
    if TFrame(LHost).Visible then
       TFrame(LHost).SetFocus;
  Self.BringToFront;

  if Supports(Designer, IEditHandlerDelegateTrait, LEditHandlerHost) then
  begin
    if Assigned(SaveDesigner) and Supports(SaveDesigner, IEditHandlerDelegateTrait, LEditHandlerHost) then
      LEditHandlerHost.SetEditHandlerDelegate(nil);
    SaveDesigner := Designer;

    Supports(Designer, IEditHandlerDelegateTrait, LEditHandlerHost);
    LEditHandlerHost.SetEditHandlerDelegate(Self);
  end;

  if Supports(BorlandIDEServices, IOTAStructureView, FStructureView) then
  begin
    if Assigned(FStructureView.GetStructureContext) and (FStructureView.GetStructureContext.ContextIdent <> '') and not (FStructureView.GetStructureContext.SameContext(Self)) then
      FSaveContext := FStructureView.GetStructureContext;
    FStructureView.SetStructureContext(Self);
  end;
end;

procedure TStyleDesigner.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LHost: TComponent;
  LEditHandlerHost: IEditHandlerDelegateTrait;
begin
  if not Assigned(Designer) then Exit;

  LHost := FVclHost;

  ReleaseHostReferences;

  if DesignRoot <> nil then
  begin
    THackFmxObject(DesignRoot).SetDesign(false);
    THackFmxObject(DesignRoot).BringToFront;
    DesignRoot.SetFocus;
  end;

  if LHost is TFrame then
    if TFrame(LHost).Visible then
      TFrame(LHost).SetFocus;

  Designer.ClearSelection;
  StyleDesigner := nil;

  if Supports(SaveDesigner, IEditHandlerDelegateTrait, LEditHandlerHost) then
  begin
    LEditHandlerHost.SetEditHandlerDelegate(nil);
    SaveDesigner := nil;
  end;

  if Assigned(FStructureView) then
  begin
    if Assigned(FSaveContext) then
    begin
      if not FStructureView.ViewShowing then
        FStructureView.SetStructureContext(nil)
      else
        FStructureView.SetStructureContext(FSaveContext);
      FSaveContext := nil;
    end else
      if Assigned(FStructureView.GetStructureContext) and FStructureView.GetStructureContext.SameContext(Self) then
        FStructureView.SetStructureContext(nil);
  end;

  Action := caFree;
end;

procedure TStyleDesigner.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;

  if FChangesMade then
  begin
    case MessageDlg(sApplyChanges, TMsgDlgType.mtConfirmation, mbYesNoCancel, 0, TMsgDlgBtn.mbYes) of
      mrYes:
        btnApplyClick(btnApply);
      mrCancel:
        CanClose := False;
    end;
  end;
end;

procedure TStyleDesigner.FormCreate(Sender: TObject);
const
  ButtonMargin: Integer = 4;
var
  Buttons: TList<TButton>;
  i, x: Integer;
begin
  dlgOpenStyle.Filter := sOpenStyleFilter;
  dlgSaveStyle.Filter := sSaveStyleFilter;

  // Layout left side buttons for localization
  Buttons := TList<TButton>.Create;
  try
    Buttons.Add(btnLoad);
    Buttons.Add(btnMerge);
    Buttons.Add(btnSave);

    x := 0;
    for i := 0 to Buttons.Count - 1 do
    begin
      inc(x, ButtonMargin);
      if Assigned(Buttons.Items[i]) then
      begin
        with Buttons.Items[i] do
        begin
          Position.X := x;
          Width := Math.Max(70, Canvas.TextWidth(Text) + ButtonMargin * 4);
          x := x + Round(Width);
        end
      end
      else
        inc(x, ButtonMargin * 2);
    end;
  finally
    Buttons.Free;
  end;

  // Layout right side buttons for localization
  Buttons := TList<TButton>.Create;
  try
    Buttons.Add(btnClose);
    Buttons.Add(btnApplyClose);
    Buttons.Add(btnApply);

    x := Width;
    for i := 0 to Buttons.Count - 1 do
    begin
      dec(x, ButtonMargin);
      if Assigned(Buttons.Items[i]) then
      begin
        with Buttons.Items[i] do
        begin
          Width := Math.Max(70, Canvas.TextWidth(Text) + ButtonMargin * 4);
          x := x - Round(Width);
          Position.X := x;
        end
      end
      else
        dec(x, ButtonMargin * 2);
    end;
  finally
    Buttons.Free;
  end;

  btnClear.Width := Math.Max(70, Canvas.TextWidth(btnClear.Text) + ButtonMargin * 4);

  CreateEmptyRoot;
  FLastSelectedRoot := nil;
  FChangesMade := false;

  // StrctureView
  FTreeRoot := TStyleStructureNode.Create(nil);
  if Supports(BorlandIDEServices, IOTAStructureView, FStructureView) then
  begin
    if Assigned(FStructureView.GetStructureContext) and (FStructureView.GetStructureContext.ContextIdent <> '') and not (FStructureView.GetStructureContext.SameContext(Self)) then
      FSaveContext := FStructureView.GetStructureContext;
    FStructureView.SetStructureContext(Self);
  end;
end;

procedure TStyleDesigner.FormDestroy(Sender: TObject);
var
  i: Integer;
  LEditHandlerHost: IEditHandlerDelegateTrait;
begin
  if Supports(SaveDesigner, IEditHandlerDelegateTrait, LEditHandlerHost) then
  begin
    LEditHandlerHost.SetEditHandlerDelegate(nil);
    SaveDesigner := nil;
  end;

  if Assigned(FRemoveList) then
    for i := 0 to FRemoveList.Count - 1 do
      FRemoveList[i].Free;
  FreeAndNil(FRemoveList);
    
  if Assigned(FStructureView) then
  begin
    if Assigned(FSaveContext) then
    begin
      if not FStructureView.ViewShowing then
        FStructureView.SetStructureContext(nil)
      else
        FStructureView.SetStructureContext(FSaveContext);
      FSaveContext := nil;
    end else
      if Assigned(FStructureView.GetStructureContext) and FStructureView.GetStructureContext.SameContext(Self) then
        FStructureView.SetStructureContext(nil);
  end;
  FreeAndNil(FTreeRoot);

  RevokeDragDrop(GetHWND);
end;

procedure TStyleDesigner.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);

{ this one is duplicated in Context.pas in order to bind correctly to Wiki topic }
const
  hcFmxStyleDesigner = 16531;

begin
                                                                                        
  { just call the help with the HC for FMX Style Designer }
  if Key = VK_F1 then
    Application.HelpContext(hcFmxStyleDesigner);
end;

function TStyleDesigner.GetHWND: HWND;
begin
  Result := WindowHandleToPlatform(Handle).Wnd;
end;

procedure TStyleDesigner.ItemsModified(const Designer: IDesigner);
begin
  // notify modifications
  FChangesMade := True;
  inherited;
end;

function TStyleDesigner.GetEditState: TEditState;
var
  LSelObj: TDesignerSelections;
  LSelections: IDesignerSelections;
  LSelectedObject: TFmxObject;
begin
  Result := [];

  LSelObj := TDesignerSelections.Create;
  Designer.GetSelections(LSelObj);

  if Supports(LSelObj, IDesignerSelections, LSelections) and (LSelections.Count = 1) then
  begin
    LSelectedObject := TFmxObject(LSelections.Items[0]);
    if not (LSelectedObject is TStyleBook) then
      Result := [esCanDelete];
  end
end;

function TStyleDesigner.GetHandle: THandle;
begin
  Result := GetHWND;
end;

procedure TStyleDesigner.SelectByName(const AName: string);
var
  Item: TStyleStructureNode;
begin
  Item := TStyleStructureNode(FTreeRoot.FindStyleResource(AName));
  if Assigned(Item) then
    FStructureView.SelectNode(Item);
end;

function TStyleDesigner.Selection: TSelection;
begin
  if FSelection = nil then
  begin
    FSelection := TSelection.Create(Self);
    FSelection.Stored := false;
    FSelection.OnTrack := DoSelectionTrack;
  end;
  Result := FSelection;
end;

procedure TStyleDesigner.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
begin
  inherited;
end;

procedure TStyleDesigner.SetVclHost(HostControl: TComponent);
begin
  ReleaseHostReferences;

  if (HostControl is Vcl.Forms.TFrame) then
  begin
    FStoredClassGroup := ActivateClassGroup(TFmxObject);
    FVclHost := HostControl;
    FVclHost.FreeNotification(Self);
    // store the existing resize event
    FVclHostOnResize := VCL.Forms.TFrame(HostControl).OnResize;
    VCL.Forms.TFrame(HostControl).OnResize := VclHostResized;
    VclHostResized(HostControl);
    // IDE Drag and Drop
    RevokeDragDrop(GetHWND); // for FMX
    RegisterDragDrop(GetHWND, TStyleDesignerOleDropTarget.Create(Self) as IDropTarget);
  end;
end;

procedure TStyleDesigner.CreateEmptyRoot;
begin
  // Create empty root
  if DesignRoot = nil then
  begin
    DesignRoot := TStyleContainer.Create(nil);
    THackFmxObject(DesignRoot).SetDesign(true);
    DesignRoot.Parent := Self;
    DesignRoot.Align := TAlignLayout.alClient;
  end;
end;

procedure TStyleDesigner.UpdateTree;

 procedure ProcessObject(Obj: TFmxObject; Node: TStyleStructureNode);
 var
   Number, i: integer;
   N: TStyleStructureNode;
   NewName, S: String;
   NameExists: Boolean;
 begin
   if not Obj.Stored then Exit;

   S := LowerCase(Obj.StyleName);
   if S = '' then
   begin
     S := LowerCase(Obj.ClassName);
     Delete(S, 1 , 1);
     if Assigned(Node.Parent) then
     begin
       Number := 1;
       NewName := S + IntToStr(Number);
       NameExists := True;
       while NameExists do
       begin
         NameExists := False;
         for I := 0 to Node.ChildrenCount - 1 do
           if Node.Children[I] is TStyleStructureNode then
           begin
             N := TStyleStructureNode(Node.Children[I]);
             if N.FCaption = NewName + ': ' + Obj.ClassName then
             begin
               Number := Number + 1;
               NewName := S + IntToStr(Number);
               NameExists := True;
             end;
           end;
       end;
       S := NewName;
     end;
   end;
   S := S + ': ' + Obj.ClassName;

   N := TStyleStructureNode.Create(nil);
   N.Parent := Node;
   N.FObject := Obj;
   N.FCaption := S;

   Obj.TagObject := N;
   if Obj is TControl and (Obj.Parent = DesignRoot) then
   begin
     TControl(Obj).DesignVisible := false;
     TControl(Obj).OnClick := DoObjectClick;
   end;

   // recurse through children
   if Obj.ChildrenCount > 0 then
     for i := 0 to Obj.ChildrenCount - 1 do
       ProcessObject(Obj.Children[i], N);
 end;
var
  SaveTreeRoot: TStyleStructureNode;
begin
  if Assigned(FStructureView) then
  begin
    FStructureView.ClearSelection;
    FLastSelectedRoot := nil;
    FStructureView.BeginUpdate;
    SaveTreeRoot := FTreeRoot;
    FTreeRoot := TStyleStructureNode.Create(nil);
    ProcessObject(DesignRoot, FTreeRoot);
    FStructureView.EndUpdate;
    FStructureView.StructureChanged(False);
    { free old }
    SaveTreeRoot.Release();
  end;
end;

procedure TStyleDesigner.VclHostResized(Sender: TObject);
var
  LRect: TRect;
  IdeHost: TFrame;
begin
  if Assigned(FVclHostOnResize) then
    FVclHostOnResize(Sender);

  if FVclHost is TFrame then
  begin
    IdeHost := TFrame(FVclHost);
    Windows.GetWindowRect(IdeHost.Handle, LRect);
    Width := LRect.Width;
    Height := LRect.Height;
  end;
  Windows.SetWindowPos(GetHWND, HWND_TOP, 0, 0, 0, 0, SWP_SHOWWINDOW or SWP_NOSIZE {or SWP_NOMOVE});
end;

function TStyleDesigner.EditAction(Action: TEditAction): Boolean;
begin
  Result := True;
{  case Action of
    eaDelete: DoDeleteButton(ObjectsTree);
  else
    Result := False;
  end;}
end;

procedure TStyleDesigner.btnLoadClick(Sender: TObject);
begin
  { Load style }
  if dlgOpenStyle.Execute then
    LoadFromFile(dlgOpenStyle.FileName);
end;

procedure TStyleDesigner.btnMergeClick(Sender: TObject);
begin
  { Add style }
  if dlgOpenStyle.Execute then
    AddFromFile(dlgOpenStyle.FileName);
end;

procedure TStyleDesigner.btnSaveClick(Sender: TObject);
var
  S: TStrings;
  F: TStream;
  I: Integer;
begin
  { Save style }
  if dlgSaveStyle.Execute then
  begin
    if CompareText(ExtractFileExt(dlgSaveStyle.FileName), '.style') = 0 then
    begin
      S := TStringList.Create;
      SaveToStrings(S);
      S.SaveToFile(dlgSaveStyle.FileName);
      S.Free;
    end
    else
    begin
      F := TFileStream.Create(dlgSaveStyle.FileName, fmCreate);
      try
        for i := 0 to DesignRoot.ChildrenCount - 1 do
          if DesignRoot.Children[i] is TControl then
            TControl(DesignRoot.Children[i]).Locked := false;
        F.Write(FireMonkeyStyleSign, Length(FireMonkeyStyleSign));
        F.WriteComponent(DesignRoot);
      finally
        F.Free;
      end;
    end;
  end;
end;

procedure TStyleDesigner.LoadFromStrings(Str: TStrings);
var
  S: TStream;
  i: integer;
  SaveRoot, Root: TFmxObject;
begin
  S := TMemoryStream.Create;
  try
    Str.SaveToStream(S);
    if S.Position > 0 then
    begin
      S.Position := 0;
      Root := LoadStyleFromStream(S);
    end
    else
      Root := TLayout.Create(nil);

    for i := 0 to Root.ChildrenCount - 1 do
      if Root.Children[i] is TControl then
        TControl(Root.Children[i]).Locked := false;

    SaveRoot := DesignRoot;
    
    DesignRoot := TControl(Root);
    THackFmxObject(DesignRoot).SetDesign(true);
    DesignRoot.Parent := Self;
    DesignRoot.Align := TAlignLayout.alClient;

    UpdateTree;
    FreeAndNil(SaveRoot);
  finally
    S.Free;
  end;
end;

procedure TStyleDesigner.SaveToStrings(Str: TStrings);
var
  B, T: TStream;
  i: integer;
begin
  if DesignRoot = nil then Exit;
  
  { Save style }
  B := TMemoryStream.Create;
  try
    Str.Clear;
    for i := 0 to DesignRoot.ChildrenCount - 1 do
      if DesignRoot.Children[i] is TControl then
        TControl(DesignRoot.Children[i]).Locked := false;
    B.WriteComponent(DesignRoot);
    B.Position := 0;
    T := TMemoryStream.Create;
    try
      ObjectBinaryToText(B, T);
      T.Position := 0;
      Str.LoadFromStream(T);
    finally
      T.Free;
    end;
  finally
    B.Free;
  end;
end;

procedure TStyleDesigner.LoadFromFile(AFileName: string);
var
  i: integer;
  SaveRoot, Root: TFmxObject;
  S: TFileStream;
begin
  S := TFileStream.Create(AFileName, fmOpenRead);
  try
    Root := LoadStyleFromStream(S);
    if not CheckStyle(Root) then Exit;
  finally
    S.Free;
  end;
  if Root = nil then Exit;

  SaveRoot := DesignRoot;
  for i := 0 to Root.ChildrenCount - 1 do
    if Root.Children[i] is TControl then
      TControl(Root.Children[i]).Locked := false;

  DesignRoot := TControl(Root);
  THackFmxObject(DesignRoot).SetDesign(true);
  DesignRoot.Parent := Self;
  DesignRoot.Align := TAlignLayout.alClient;

  UpdateTree;
  FreeAndNil(SaveRoot);
  FChangesMade := True;
end;

procedure TStyleDesigner.AddFromFile(AFileName: string);
var
  i: integer;
  Root: TFmxObject;
  S: TFileStream;
begin
  S := TFileStream.Create(AFileName, fmOpenRead);
  try
    Root := LoadStyleFromStream(S);
  finally
    S.Free;
  end;

  if Root = nil then Exit;

  THackFmxObject(Root).SetDesign(true);
  for i := Root.ChildrenCount - 1 downto 0 do
    if Root.Children[i] is TControl then
    begin
      TControl(Root.Children[i]).Locked := false;
      TControl(Root.Children[i]).Parent := DesignRoot;
    end;

  // notify the designer
  Designer.Modified;
  FChangesMade := True;
end;

procedure TStyleDesigner.btnApplyClick(Sender: TObject);
begin
  { apply }
  if FStyleBook <> nil then
  begin
    SaveToStrings(FStyleBook.Resource);
    Designer.Modified;
  end;

  FChangesMade := False;
end;

procedure TStyleDesigner.btnApplyCloseClick(Sender: TObject);
begin
  btnApplyClick(Sender);
  btnCloseClick(Sender);
end;

procedure TStyleDesigner.btnClearClick(Sender: TObject);
begin
  FreeAndNil(DesignRoot);
  CreateEmptyRoot;
  UpdateTree;
  // notify the designer
  Designer.Modified;
  FChangesMade := True;
end;

procedure TStyleDesigner.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TStyleDesigner.ReleaseHostReferences;
begin
  if Assigned(FVclHost) then
  begin
    FVclHost.RemoveFreeNotification(Self);
    if Assigned(FVclHostOnResize) and (FVclHost is TFrame) then
      TFrame(FVclHost).OnResize := FVclHostOnResize;
  end;
  // IDE Drag and Drop
  RevokeDragDrop(GetHWND);
  FVclHostOnResize := nil;
  FVclHost := nil;
  if Assigned(FStoredClassGroup) then
    ActivateClassGroup(FStoredClassGroup);
  FStoredClassGroup := nil;
end;

procedure TStyleDesigner.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (AComponent = FVclHost) and (Operation = opRemove) then
    Close;

  if (Operation = opRemove) and (AComponent = FSelection) then
    FSelection := nil;
end;

procedure TStyleDesigner.DesignerClosed(const Designer: IDesigner;
  AGoingDormant: Boolean);
begin
  if FDesigner = Designer then
    Close;
  inherited;
end;

procedure TStyleDesigner.DesignRootDragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPoint; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TStyleDesigner.DoObjectClick(Sender: TObject);
begin
  FStructureView.SelectNode(TStyleStructureNode(TControl(Sender).TagObject));
end;

procedure TStyleDesigner.DoSelectionTrack(Sender: TObject);
var
  N: TStyleStructureNode;
  Control: TControl;
begin
  if not Assigned(FStructureView.GetFirstSelected) then Exit;
  N := TStyleStructureNode(FStructureView.GetFirstSelected);
  if N.FObject is TControl then
  begin
    Control := TControl(N.FObject);
    with Selection.ParentedRect do
      Control.SetBounds(Left, Top, Width, Height);
    with Control.ParentedRect do
      Selection.SetBounds(Left, Top, Width, Height);
  end;
end;

{ IOTAStructureContext } 

function TStyleDesigner.Get_ContextIdent: WideString; safecall;
begin
  if Assigned(FStyleBook) then
    Result := FStyleBook.Name // do not localize
  else
    Result := '';
end;

function TStyleDesigner.Get_StructureType: WideString; safecall;
begin
  Result := DesignerStructureType;
end;

function TStyleDesigner.Get_ViewOptions: Integer; safecall;
begin
  Result := 0;
end;

function TStyleDesigner.Get_RootNodeCount: Integer; safecall;
begin
  Result := 1;
end;

function TStyleDesigner.GetRootStructureNode(Index: Integer): IOTAStructureNode; safecall;
begin
  Result := TStyleStructureNode(FTreeRoot);
end;

procedure TStyleDesigner.NodeEdited(const Node: IOTAStructureNode); safecall;
begin
end;

procedure TStyleDesigner.NodeFocused(const Node: IOTAStructureNode); safecall;
var
  Old, New, LSelectObject: TFmxObject;
begin
  LSelectObject := TStyleStructureNode(Node).FObject;
  if LSelectObject = DesignRoot then
  begin
    Designer.SelectComponent(DesignRoot);
    if (FLastSelectedRoot <> nil) and (FLastSelectedRoot is TControl) then
      TControl(FLastSelectedRoot).DesignVisible := False;
    Selection.Parent := nil;
    FLastSelectedRoot := DesignRoot;
    Exit;
  end;
  New := LSelectObject;
  while New.Parent <> DesignRoot do
    New := New.Parent;

  if New is TControl then
  begin
    // center
    TControl(New).Position.X := round((DesignRoot.Width - TControl(New).Width) / 2);
    TControl(New).Position.Y := round((DesignRoot.Height - TControl(New).Height) / 2);
    if FLastSelectedRoot <> nil then
      Old := FLastSelectedRoot
    else
      Old := nil;
    //
    if (Old <> nil) and (Old is TControl) then
    begin
      if Old <> DesignRoot then
        TControl(Old).DesignVisible := False
    end
    else
      if (Old <> nil) and (Old.Parent <> nil) and (Old.Parent is TControl) then
      begin
        if Old.Parent <> DesignRoot then
          TControl(Old.Parent).DesignVisible := False;
      end;
    if New <> DesignRoot then
      TControl(New).DesignVisible := True;
  end
  else
  begin
    if (New <> nil) and (New.Parent <> nil) and (New.Parent is TControl) then
    begin
      TControl(New.Parent).DesignVisible := True;
    end;
  end;
  FLastSelectedRoot := New;

  Designer.SelectComponent(TStyleStructureNode(Node).FObject);
  if LSelectObject is TControl then
  begin
    Selection.Parent := TFmxObject(LSelectObject).Parent;
    with TControl(LSelectObject).ParentedRect do
      Selection.SetBounds(Left, Top, Width, Height);
  end
  else
    Selection.Parent := nil;
end;

procedure TStyleDesigner.NodeSelected(const Node: IOTAStructureNode); safecall;
begin
end;

procedure TStyleDesigner.DefaultNodeAction(const Node: IOTAStructureNode); safecall;
begin
end;

function TStyleDesigner.SameContext(const AContext: IOTAStructureContext): WordBool; safecall;
begin
  if not Assigned(AContext) then
    Result := False
  else
    Result := SameText(AContext.ContextIdent, Get_ContextIdent);
end;

procedure TStyleDesigner.InitPopupMenu(const Node: IOTAStructureNode;
  const PopupMenu: IOTAStructureNodeMenuItem); safecall;
begin
end;

procedure TStyleDesigner.AddRootNode(const ANode: IOTAStructureNode; Index: Integer); safecall;
begin
end;

procedure TStyleDesigner.RemoveRootNode(const ANode: IOTAStructureNode); safecall;
begin

end;

{ IOTAStructureContextToolbar }

function TStyleDesigner.Get_ButtonCount: Integer; safecall;
begin
  Result := 1;
end;

function TStyleDesigner.GetButtonCaption(Index: Integer): WideString; safecall;
begin
  Result := '';
end;

function TStyleDesigner.GetButtonEnabled(Index: Integer): WordBool; safecall;
begin
  if Assigned(FLastSelectedRoot) and (FLastSelectedRoot = DesignRoot) then
    Result := False
  else
    Result := True;
end;

function TStyleDesigner.GetButtonEnableDropDown(Index: Integer): WordBool; safecall;
begin
  Result := False;
end;

function TStyleDesigner.GetButtonHasDropDown(Index: Integer): WordBool; safecall;
begin
  Result := False;
end;

function TStyleDesigner.GetButtonHint(Index: Integer): WideString; safecall;
begin
  Result := 'Delete';
end;

function TStyleDesigner.GetButtonImageIndex(Index: Integer): Integer; safecall;
begin
  Result := 26;
end;

function TStyleDesigner.GetButtonMenu(Index: Integer): IOTAStructureNodeMenuItem; safecall;
begin
  Result := nil;  
end;

function TStyleDesigner.GetButtonSeparator(Index: Integer): WordBool; safecall;
begin
  Result := False;  
end;

function TStyleDesigner.GetButtonVisible(Index: Integer): WordBool; safecall;
begin
  Result := True;
end;

procedure TStyleDesigner.Invoke(Index: Integer); safecall;
var 
  N: TStyleStructureNode;
begin
  if Index = 0 then
  begin
    if Assigned(FLastSelectedRoot) and (FLastSelectedRoot <> DesignRoot) then
    begin
      N := TStyleStructureNode(FStructureView.GetFirstSelected);
      FStructureView.ClearSelection;

      if Assigned(N.Parent) then
        FStructureView.SelectNode(TStyleStructureNode(N.Parent));

      if FLastSelectedRoot = N.FObject then
        FLastSelectedRoot := nil;
      
      N.FObject.Free;
      N.Parent := nil;
      
      FStructureView.StructureChanged(True);

      if not Assigned(FRemoveList) then
        FRemoveList := TList<TStyleStructureNode>.Create;
      FRemoveList.Add(N);
    end;
  end;
end;

function TStyleDesigner.DragAllowed(const Node: IOTAStructureNode): WordBool; safecall;
begin
  Result := True;
end;

procedure TStyleDesigner.DragDrop(const Node: IOTAStructureNode;
      DataObject: OleVariant; const FormatArray: WideString;
      X, Y: Integer; KeyState: Integer; Mode: TOTADropMode; var Effect: Integer); safecall;
begin
end;

function TStyleDesigner.DragOver(const Node: IOTAStructureNode;
      DataObject: OleVariant; State: TOTADragState;
      X, Y: Integer; KeyState: Integer; Mode: TOTADropMode; var Effect: Integer): WordBool; safecall;
begin
  Result := True;
end;

function TStyleDesigner.GetDataObject: OleVariant; safecall;
begin
  FDragNode := FStructureView.GetFirstSelected;
end;

end.

