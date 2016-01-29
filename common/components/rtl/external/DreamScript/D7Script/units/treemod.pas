{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit treemod;

interface
{$I dc.inc}
uses
  dcsystem,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dcgen, dccommon, dcdreamlib,ComCtrls, DcTree, dctslite, Buttons, ExtCtrls,
  dcconsts, consts, dcDTree;


type
  TStrEditForm = class(TForm)
    DCStringSource: TDCStringSource;
    Panel1: TPanel;
    DCTreeView: TDCTreeView;
    Panel2: TPanel;
    SpeedUp: TSpeedButton;
    SpeedDown: TSpeedButton;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    procedure DCTreeViewDblClick(Sender: TObject);
    procedure SpeedUpClick(Sender: TObject);
    procedure SpeedDownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetMultiSelect:boolean;
    procedure SetMultiselect(Value:Boolean);
    { Private declarations }
  public
    trackDblClick:boolean;
    property Multiselect:boolean read  GetMultiSelect write SetMultiselect;

    { Public declarations }
  end;
  TOnStringEvent = procedure(Sender : TObject; const S : string; var AllowAdd : boolean);


var
  StrEditForm: TStrEditForm;
  FOnAddString : TOnStringEvent;
Type
  TStrEditOption=(uoSelectAll,uoTrackDblClick);
  TStrEditOptions=set of TStrEditOption;

function FilterStringsForm(U:TStrings;Const ACaption:String;AHelpCtx:Integer;
           Options:TStrEditOptions):Boolean;
procedure EditStrings(Strings:TStrings;Const ACaption:String);
procedure ChangeCreationOrder(AOwner : TComponent);
procedure ChangeTabOrder(AParent : TWinControl);
function EditSourceModal(ASource:TComponentSource;Const ACaption:String;AHelpCtx:Integer):integer; forward;

implementation

{$R *.DFM}

function AddString(Sender : TObject; const s : string) : boolean;
begin
  result := true;
  if Assigned(FOnAddString) then
    FOnAddString(Sender, s, result)
end;

{-----------------------------------------------------------}

function EditSourceModal(ASource:TComponentSource;Const ACaption:String;AHelpCtx:Integer):integer;
begin
  result:=0;
  if ASource = nil then
    Exit;
  With TStrEditForm.Create(Application) do
  try
    Caption:=ACaption;
    HelpContext:=AHelpCtx;
    with DcTreeView do
    begin
      Source:=ASource;
      if Source.ActionAllowed(0,acCanDrag) then
        DragMode:=dmAutomatic
      else
        DragMode:=dmManual;
      SpeedUp.Visible:=false;
      SpeedDown.Visible:=false;
      MultiSelect:=Source.ActionAllowed(0,acMultiSelect);
      ShowLines:=Source.ActionAllowed(0,acShowLines);
      ShowRoot:=ShowLines;
    end;
     with DCTreeView do
     if (ShowModal = mrOk) and Assigned(Selected) then
        result:= TDCTreeNode(Selected).ObjId;
   finally
     Free;
   end;
end;

{-----------------------------------------------------------}

procedure  EditStrings(Strings:TStrings;Const ACaption:String);
var
  Sl:TStrings;
begin
  Sl:=TStringList.Create;
  With TStrEditForm.Create(Application) do
  try
    Caption:=ACaption;
    Sl.Assign(Strings);
    DCStringSource.Strings:=Sl;
    if ShowModal = mrOk then
      Strings.Assign(Sl);
  finally
    Free;
    Sl.Free;
  end;

end;

{-----------------------------------------------------------}

function FilterStringsForm(U:TStrings;Const ACaption:String;AHelpCtx:Integer;
           Options:TStrEditOptions):Boolean;
Var
  i:Integer;
begin
  With TStrEditForm.Create(Application) do
  try
    Caption:=ACaption;
    HelpContext:=AHelpCtx;
    SpeedUp.Visible:=false;
    SpeedDown.Visible:=false;
    MultiSelect:=true;
    DCStringSource.Strings:=U;
    If uoSelectAll in Options then
      DCTreeView.SelectAllItems;
    TrackDblClick := uoTrackDblClick in Options;
    Result:=ShowModal = mrOk;
    If Result then
    begin
      For i:=U.Count-1 downto 0 do
        with DCTreeView do
          If (ItemsSelected.IndexOf(Items[i]) < 0) and (Items[i]<>Selected) then
            U.Delete(i);
      Result:=U.Count<>0;
    end;
    DCStringSource.Strings:=nil;
  finally
    Free;
  end;
end;


{-----------------------------------------------------------}

procedure ChangeCreationOrder(AOwner : TComponent);
Var
  i:Integer;
  Sl:TStringList;
  c : TComponent;
  Lst : TStringList;
begin
  if AOwner = nil then
    exit;

  Sl:=TStringList.Create;
  Lst := TStringList.Create;
  with TStrEditForm.Create(Application) do
    try
      Caption:=SCreateOrderCaption;
      MultiSelect:=false;
      with AOwner do
        for i := 0 to ComponentCount - 1 do
          begin
            c := Components[i];
            if not (c is TControl) and IsIconClass(TComponentClass(c.ClassType)) then
              if AddString(c, c.Name) then
              begin
                Sl.AddObject(c.Name, c);
                Lst.AddObject('', c);
              end
              else
                Lst.AddObject(c.Name, c);
          end;

      DCStringSource.Strings:=Sl;
      if ShowModal = idOK then
        with AOwner do
          begin
            for i := 0 to Sl.Count - 1 do
              TComponent(Sl.Objects[i]).ComponentIndex := i;
            for i := 0 to Lst.Count - 1 do
              if Lst[i] <> '' then
                TComponent(Lst.Objects[i]).ComponentIndex := i;

            DesignerModified(AOwner);
          end;
    finally
      DCStringSource.Strings:=nil;
      Sl.Free;
      Lst.Free;
      Free;
    end;
end;

{-----------------------------------------------------------}

function TStrEditForm.GetMultiSelect:boolean;
begin
 result:= DCTreeView.MultiSelect;
end;

{-----------------------------------------------------------}

procedure TStrEditForm.SetMultiselect(Value:Boolean);
begin
  DCTreeView.MultiSelect:=Value;
end;

{-----------------------------------------------------------}

procedure TStrEditForm.DCTreeViewDblClick(Sender: TObject);
begin
   with DcTreeView do
   if TrackDblClick or (Assigned(Source) and Assigned(Selected) and
      Source.ActionAllowed(0,AcShowModal)) then
     begin
       Close;
       ModalResult:=mrOk;
     end;
end;

{-----------------------------------------------------------}

procedure ChangeTabOrder(AParent : TWinControl);
var
  i        : integer;
  wclist   : TList;
  Sl       : TStringList;
  Lst      : TStringList;
begin
  if Aparent = nil then
    exit;

  Sl := TStringList.Create;
  wclist := TList.Create;
  Lst := TStringList.Create;
  with TStrEditForm.Create(Application), Aparent do
    try
      Caption := STabOrderCaption;
      DCTreeView.MultiSelect := false;
      for i := 0 to ControlCount - 1 do
        if Controls[i] is TWinControl then
          wclist.Add(Controls[i]);

      for i := 0 to wclist.Count - 1 do
      begin
        Sl.Add('');
        Lst.Add('')
      end;
      for i := 0 to wclist.Count - 1 do
        with Sl, TWinControl(wclist[i]) do
          if AddString(TWinControl(wclist[i]), Name) then
          begin
            Strings[TabOrder] := Name;
            Objects[TabOrder] := wclist[i];
          end
          else
          begin
            Lst.Strings[TabOrder] := Name;
            Lst.Objects[TabOrder] := wclist[i];
          end;
      for i := Sl.Count - 1 downto 0 do
        if Sl[i] = '' then
          Sl.Delete(i);

      DCStringSource.Strings:=Sl;
      if ShowModal = idOK then
        begin
          for i := 0 to Sl.Count - 1 do
            TWinControl(Sl.Objects[i]).TabOrder := i;
          for i := 0 to Lst.Count - 1 do
            if Lst[i] <> '' then
              TWinControl(Lst.Objects[i]).TabOrder := i;

          DesignerModified(AParent);
        end;
  finally
    Release;
    Sl.Free;
    wclist.Free;
    Lst.Free;
  end;
end;

{-----------------------------------------------------------}

procedure TStrEditForm.SpeedUpClick(Sender: TObject);
begin
  with DcTreeView,Items do
    MoveItemUp(Selected);
end;

{-----------------------------------------------------------}

procedure TStrEditForm.SpeedDownClick(Sender: TObject);
begin
  with DcTreeView,Items do
    MoveItemDown(Selected);
end;

{------------------------------------------------------------------}

procedure TStrEditForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  OkBut.Caption := ResStr(SOKButton);
  CancelBut.Caption := ResStr(SCancelButton);
  HelpBut.Caption := ResStr(SHelpButton);
  HelpBut.Visible := boolShowHelpButton;
end;

end.
