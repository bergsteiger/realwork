{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit NewStdAc;

interface

uses Windows, SysUtils, Classes, System.Actions, Graphics, Forms, Controls,
  System.Generics.Collections, StdCtrls, Buttons, ExtCtrls, ComCtrls, ActnList;

type
  TCategoryKind = (ckCategory, ckNone, ckAll, ckAction);

  TTreeNode = class (ComCtrls.TTreeNode)
  private
    FKind: TCategoryKind;
    function GetCategory: string;
  public
    property Kind: TCategoryKind read FKind write FKind;
    property Category: string read GetCategory;
  end;

  TTreeViewCat = class (ComCtrls.TCustomTreeView)
  protected
    function CreateNode: ComCtrls.TTreeNode; override;
  public
    function AddNode(Parent: ComCtrls.TTreeNode;
                     Text: string;
                     Kind: TCategoryKind): TTreeNode;
    function InsertNode(Parent: ComCtrls.TTreeNode;
                        Index: integer;
                        Text: string;
                        Kind: TCategoryKind): TTreeNode;
    function NodeOf(Text: string;
                    Kind: TCategoryKind): TTreeNode;
    procedure GetExpandedList(List: TStringList);
    procedure SetExpandedList(List: TStringList);
    procedure Assign(Source: TPersistent); override;

    property Items;
    property HideSelection;
    property ReadOnly;
    property MultiSelect;
    property RowSelect;
    property ShowLines;
    property OnChange;
    property OnMouseDown;
  end;

  TRegAct = record
    Category: string;
    ActionClass: TBasicActionClass;
    NeedFullName: boolean;
  end;

  TNewStdActionDlg = class(TForm)
    HelpBtn: TButton;
    OKBtn: TButton;
    CancelBtn: TButton;
    ActionList1: TActionList;
    AcceptAction: TAction;
    Label1: TLabel;
    Panel1: TPanel;
    procedure HelpBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ActionListDblClick(Sender: TObject);
    procedure AcceptActionUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FSortColumn: Integer;
    FFrameworkType: string;
    FSectionName: string;
    FRegKey: string;
    FTopItem: string;
    FSelItem: string;
    FActionTree: TTreeViewCat;
    FListAct: TList<TRegAct>;
    procedure AddAction(const Category: string; ActionClass: TBasicActionClass;
      Info: Pointer);
    procedure ReadSettings;
    procedure WriteSettings;
    procedure UpdateActionTree;
    procedure SetFrameworkType(const Value: string);
    procedure UpdateTreePos;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ActionTree: TTreeViewCat read FActionTree;
    property FrameworkType: string read FFrameworkType write SetFrameworkType;
    property SectionName: string read FSectionName write FSectionName;
    property RegKey: string read FRegKey write FRegKey;
  end;

implementation

{$R *.dfm}

uses DeskStrs, DesignWindows, DsnConst, Registry;

{ TTreeNode }

function TTreeNode.GetCategory: string;
var
  Parent: TTreeNode;
  First: boolean;
begin
  Result := '';
  Parent := self;
  First := True;
  repeat
    if Assigned(Parent) then
    begin
      if Parent.Kind = ckCategory then
      begin
        if not First then
          Result := '.' + Result
        else
          First := False;
        Result := Parent.Text + Result;
      end;
      Parent := TTreeNode(Parent.Parent);
    end;
  until not Assigned(Parent);
end;

{ TTreeViewCat }

function TTreeViewCat.AddNode(Parent: ComCtrls.TTreeNode; Text: string;
  Kind: TCategoryKind): TTreeNode;
var NewNode: ComCtrls.TTreeNode;
begin
  Result := nil;
  NewNode := Items.AddChild(Parent, Text);
  if NewNode is TTreeNode then
  begin
    Result := TTreeNode(NewNode);
    Result.Kind := Kind;
  end
  else
    FreeAndNil(NewNode);
end;

function TTreeViewCat.InsertNode(Parent: ComCtrls.TTreeNode; Index: integer;
  Text: string; Kind: TCategoryKind): TTreeNode;
var NewNode: ComCtrls.TTreeNode;
begin
  Result := nil;
  if not Assigned(Parent) then
    NewNode := Items.Insert(Items.Item[Index], Text)
  else
    NewNode := Items.Insert(Parent.Item[Index], Text);
  if NewNode is TTreeNode then
  begin
    TTreeNode(NewNode).Kind := Kind;
    Result := TTreeNode(NewNode);
  end
  else
    FreeAndNil(NewNode);
end;

function TTreeViewCat.NodeOf(Text: string; Kind: TCategoryKind): TTreeNode;
var I: integer;
    Node: TTreeNode;
    S: string;
begin
  Result := nil;
  for I := 0 to Items.Count - 1 do
  if Items[I] is TTreeNode then
  begin
    Node := TTreeNode(Items[I]);
    S := Copy(Text,
              Length(Text) - Length(Node.Text) + 1,
              Length(Node.Text));
    if (Node.Kind = Kind) and
       ((Kind <> ckCategory) or
        (SameText(S, Node.Text))) then
    begin
      if Kind = ckCategory then
      begin
        if SameText(Node.Category, Text) then
        begin
          Result := Node;
          Break;
        end;
      end
      else
      begin
        Result := Node;
        Break;
      end;
    end;
  end;
end;

procedure TTreeViewCat.GetExpandedList(List: TStringList);
var
  I: Integer;
begin
  List.Clear;
  List.Sorted := True;
  try
    List.Sorted := True;
    List.Duplicates := dupIgnore;
    for I := 0 to Items.Count - 1 do
    begin
      if (TTreeNode(Items[I]).Kind = ckCategory) and
         (Items[I].Expanded) and
         (Items[I].HasChildren) then
        List.Add(AnsiUpperCase(TTreeNode(Items[I]).GetCategory));
    end;
  except
    List.Clear;
    Raise;
  end;
end;

procedure TTreeViewCat.SetExpandedList(List: TStringList);
var
  I, J: Integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    if (TTreeNode(Items[I]).Kind = ckCategory) then
    begin
      if List.Find(AnsiUpperCase(TTreeNode(Items[I]).GetCategory), J) then
        Items[I].Expanded := True;
    end;
  end;
end;

procedure TTreeViewCat.Assign(Source: TPersistent);
var List, SubList: TStringList;
  I: NativeInt;
  J: integer;
  S: string;
  procedure StringToList(S: string; List: TStringList);
  var
    L, X1, X2: Integer;
  begin
    List.Clear;
    L := 0;
    X1 := 1;
    repeat
      X2 := Pos('.', S, X1);
      if X2 > 0 then
      begin
        List.Add(Copy(S, X1, X2 - X1));
        X1 := X2 + 1;
        inc(L);
      end;
    until (L > 3) or (X2 = 0);
    X2 := Length(S);
    List.Add(Copy(S, X1, X2 - X1 + 1));
  end;
  procedure IntAdd(Cat: string);
  var I, J: integer;
      Parent, Node: TTreeNode;
  begin
    if Cat <> '' then
    begin
      StringToList(Cat, SubList);
      Parent := nil;
      for I := 0 to SubList.Count - 1 do
      begin
        Node := nil;
        if not Assigned(Parent) then
        begin
          for J := 0 to Items.Count - 1 do
          begin
            if (Items[J].Level = I) and (Items[J] is TTreeNode) then
            begin
              Node := TTreeNode(Items[J]);
              if (Node.Kind = ckCategory) and
                 (SameText(Node.Text, SubList[I])) then
                break
              else
                Node := nil;
            end;
          end;
        end
        else
        begin
          for J := 0 to Parent.Count - 1 do
          begin
            if (Parent.Item[J].Level = I) and (Parent.Item[J] is TTreeNode) then
            begin
              Node := TTreeNode(Parent.Item[J]);
              if (Node.Kind = ckCategory) and
                 (SameText(Node.Text, SubList[I])) then
                break
              else
                Node := nil;
            end;
          end;
        end;
        if not Assigned(Node) then
          Node := self.AddNode(Parent, SubList[I], ckCategory);
        if Assigned(Node) then
        begin
          Parent := Node;
        end
        else
          Break;
      end;
    end;
  end;
begin
  if Source is TStringList then
  begin
    List := TStringList.Create;
    try
      List.Sorted := True;
      List.Duplicates := dupIgnore;
      for I := 0 to TStringList(Source).Count - 1 do
      begin
        S := AnsiUpperCase(TStringList(Source)[I]);
        if S <> '' then
          List.AddObject(S, TObject(I));
      end;
      if List.Count > 0 then
      begin
        SubList := TStringList.Create;
        try
          SubList.Delimiter := '.';
          for J := 0 to List.Count - 1 do
          begin
            IntAdd(TStringList(Source)[NativeInt(List.Objects[J])]);
          end;
        finally
          FreeAndNil(SubList);
        end;
      end;
    finally
      FreeAndNil(List);
    end;
  end
  else
    inherited;
end;

function TTreeViewCat.CreateNode: ComCtrls.TTreeNode;
var
  LClass: TTreeNodeClass;
begin
  LClass := TTreeNode;
  Result := LClass.Create(Items);
end;

{ TNewStdActionDlg }

constructor TNewStdActionDlg.Create(AOwner: TComponent);
begin
  inherited;
  FActionTree := TTreeViewCat.Create(self);
  FActionTree.AlignWithMargins := True;
  FActionTree.Margins.Top := 0;
  FActionTree.Align := alClient;
  FActionTree.MultiSelect := True;
  FActionTree.MultiSelectStyle := [msControlSelect, msShiftSelect];
  FActionTree.ReadOnly := True;
  FActionTree.Parent := self;
  FActionTree.Indent := 19;
  FActionTree.TabOrder := 1;
  FActionTree.OnDblClick := ActionListDblClick;
  ActiveControl := FActionTree;
  Label1.FocusControl := FActionTree;
end;

destructor TNewStdActionDlg.Destroy;
begin
  FreeAndNil(FListAct);
  inherited;
end;

procedure TNewStdActionDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TNewStdActionDlg.AddAction(const Category: string;
  ActionClass: TBasicActionClass; Info: Pointer);
var
  R: TRegAct;
begin
  R.Category := Category;
  R.ActionClass := ActionClass;
  R.NeedFullName := False;
  FListAct.Add(R);
end;

procedure TNewStdActionDlg.ReadSettings;
var
  Reg: TRegIniFile;
  Key: string;
begin
  Key := RegKey;
  if Key <> '' then
  begin
    if SectionName <> '' then
      Key := Key + '/' + SectionName;
    Reg := TRegIniFile.Create(Key);
    try
      LoadFormPos(Reg, ClassName, self);
      FTopItem := Trim(Reg.ReadString(ClassName, ivTopItem, ''));
      FSelItem := Trim(Reg.ReadString(ClassName, ivSelItem, ''));
      UpdateTreePos;
    finally
      FreeAndNil(Reg);
    end;
  end;
end;



procedure TNewStdActionDlg.WriteSettings;
var
  Reg: TRegIniFile;
  Key: string;
begin
  Key := RegKey;
  if Key <> '' then
  begin
    if SectionName <> '' then
      Key := Key + '/' + SectionName;
    Reg := TRegIniFile.Create(Key);
    try
      SaveFormPos(Reg, ClassName, self);
      if (FActionTree.Enabled) then
      begin
        if (FActionTree.Selected <> nil) then
          Reg.WriteString(ClassName, ivSelItem, FActionTree.Selected.Text)
        else
          Reg.DeleteKey(ClassName, ivTopItem);
        if (FActionTree.TopItem <> nil) then
          Reg.WriteString(ClassName, ivTopItem, FActionTree.TopItem.Text)
        else
          Reg.DeleteKey(ClassName, ivTopItem);
      end;
    finally
      FreeAndNil(Reg);
    end;
  end;
end;

procedure TNewStdActionDlg.SetFrameworkType(const Value: string);
begin
  if FFrameworkType <> Value then
  begin
    FFrameworkType := Value;
    if Visible then
      UpdateActionTree;
  end;
end;

procedure TNewStdActionDlg.UpdateTreePos;
var
  I: Integer;
begin
  if FTopItem <> '' then
    for I := 0 to FActionTree.Items.Count - 1 do
      if WideSameText(FTopItem, Trim(FActionTree.Items[I].Text)) then
      begin
        FActionTree.TopItem := FActionTree.Items[I];
        Break;
      end;
  if FSelItem <> '' then
    for I := 0 to FActionTree.Items.Count - 1 do
      if WideSameText(FSelItem, Trim(FActionTree.Items[I].Text)) then
      begin
        FActionTree.Items[I].Selected := True;
        FActionTree.Items[I].Focused := True;
        Break;
      end;
end;

procedure TNewStdActionDlg.UpdateActionTree;
var
  Node, NewNode: TTreeNode;
  List: TStringList;
  I, J: integer;
  CurrAct, R: TRegAct;
  S: string;
  NeedEmpty: boolean;
  Kind: TCategoryKind;
begin
  FActionTree.Items.BeginUpdate;
  try
    if Assigned(FListAct) then
      FListAct.Clear
    else
      FListAct := TList<TRegAct>.Create;
    FActionTree.Items.Clear;
    System.Actions.EnumRegisteredActions(AddAction, nil, FrameworkType);
    List := TStringList.Create;
    try
      NeedEmpty := False;
      for I := 0 to FListAct.Count - 1 do
      begin
        CurrAct := FListAct[I];
        if CurrAct.Category = '' then
          NeedEmpty := True
        else
          List.Add(CurrAct.Category);
        if not CurrAct.NeedFullName then
        begin
          for J := 0 to FListAct.Count - 1 do
          begin
            R := FListAct[J];
            if (I <> J) and
               (WideSameText(R.ActionClass.ClassName,
                             CurrAct.ActionClass.ClassName)) then
            begin
              CurrAct.NeedFullName := True;
              R.NeedFullName := True;
              FListAct[I] := CurrAct;
              FListAct[J] := R;
            end;
          end;
        end;
      end;
      FActionTree.Assign(List);
      if NeedEmpty then
      begin
        if FActionTree.Items.Count = 0 then
          FActionTree.AddNode(nil, SActionCategoryNone, ckNone)
        else
          FActionTree.InsertNode(nil, 0, SActionCategoryNone, ckNone);
      end;
    finally
      FreeAndNil(List);
    end;
    for CurrAct in FListAct do
    begin
      if CurrAct.Category = '' then
        Kind := ckNone
      else
        Kind := ckCategory;
      Node := FActionTree.NodeOf(CurrAct.Category, Kind);
      if Assigned(Node) then
      begin
        if CurrAct.NeedFullName then
          S := CurrAct.ActionClass.QualifiedClassName
        else
          S := CurrAct.ActionClass.ClassName;
        NewNode := FActionTree.AddNode(Node, S, ckAction);
        if Assigned(NewNode) and (CurrAct.ActionClass.InheritsFrom(TContainedAction)) then
          NewNode.Data := Pointer(CurrAct.ActionClass);
        Node.Expanded := True;
      end;
    end;
    FreeAndNil(FListAct);
  finally
    FActionTree.Items.EndUpdate;
  end;
  if FActionTree.Items.Count > 0 then
  begin
    if FActionTree.Items.Count > 1 then
      Node := TTreeNode(FActionTree.Items[1])
    else
      Node := TTreeNode(FActionTree.Items[0]);
    FActionTree.Enabled := True;
    Node.Selected := True;
    Node.Focused := True;
    UpdateTreePos;
  end
  else
  begin
    FActionTree.Enabled := False;
    FActionTree.AddNode(nil, StrNoSuported, ckNone);
  end;
end;

procedure TNewStdActionDlg.FormShow(Sender: TObject);
begin
  ReadSettings;
  UpdateActionTree;
  if FActionTree.Enabled then
    FActionTree.SetFocus;
end;

procedure TNewStdActionDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteSettings;
end;

procedure TNewStdActionDlg.ActionListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if Abs(FSortColumn) = 1 then
    Compare := FSortColumn * AnsiCompareText(Item1.Caption, Item2.Caption) else
    Compare := FSortColumn * AnsiCompareText(Item1.SubItems[0], Item2.SubItems[0]);
end;

procedure TNewStdActionDlg.ActionListDblClick(Sender: TObject);
begin
  if OKBtn.Enabled then OKBtn.Click;
end;

procedure TNewStdActionDlg.AcceptActionUpdate(Sender: TObject);
begin
  AcceptAction.Enabled := (FActionTree.Enabled) and (FActionTree.SelectionCount > 0);
end;

end.

