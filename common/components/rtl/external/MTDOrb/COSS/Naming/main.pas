unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls,orb_int,cosnaming_int,cosnaming, ImgList;

type
  TMainForm = class(TForm)
    LocationPanel: TPanel;
    TreeView: TTreeView;
    StatusBar: TStatusBar;
    Splitter1: TSplitter;
    LocationLabel: TLabel;
    LocationEdit: TEdit;
    ConnectButton: TButton;
    RefreshButton: TButton;
    ImageList1: TImageList;
    Notebook1: TNotebook;
    ListView: TListView;
    Edit: TRichEdit;
    procedure ConnectButtonClick(Sender: TObject);
    procedure LocationEditChange(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure ListViewDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure UpdateView;
    procedure Reset;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  dorb: IORB;
  lst : TBindingList;
  ns: INamingContext;
  stream: TMemoryStream;
  last_connected : string;

implementation

uses
  orb,registry,orbtypes;

{$R *.DFM}

procedure TMainForm.ConnectButtonClick(Sender: TObject);
var
  str: AnsiString;
  i : integer;
  tag : IObjectTag;
  naming : IORBObject;
begin
  reset;
  str := AnsiString(LocationEdit.text);
  i := Pos('-orbnamingaddr',lowercase(String(str)));
  naming := nil;
  if i > 0 then
    begin
      tag := dorb.string_to_tag('NameService');
      str := copy(str,i+15,1000);
      //naming := dorb.bind(PChar('IDL:omg.org/CosNaming/NamingContext:1.0'),tag,PChar(str));
      naming := dorb.string_to_object(AnsiString(Trim(String(str))));
      if naming <> nil then
        dorb.register_initial_reference('NameService',naming);
    end
  else if Pos('-orbnamingior',lowercase(String(str))) > 0 then
    begin
      str := AnsiString(copy(str,Pos('-orbnamingior',lowercase(String(str)))+13,1000));
      tag := dorb.string_to_tag('NameService');
      naming := dorb.string_to_object(AnsiString(Trim(String(str))));
      if naming <> nil then
        dorb.register_initial_reference('NameService',naming);
    end
  else
    begin
      ShowMessage('Unknown option');
      exit;
    end;
  if naming <> nil then
    begin
      ns := TNamingContext._narrow(naming);
      if ns = nil then
        ShowMessage('no name service avaliable')
      else
        begin
          ConnectButton.Enabled := false;
          RefreshButton.Enabled := true;
          UpdateView;
          last_connected := LocationEdit.Text;
        end;
    end
  else
    ShowMessage('no name service avaliable');
end;

procedure TMainForm.UpdateView;
var
  ind : integer;

  procedure Update(nc: INamingContext; item : TTreeNode);
  var
    i : integer;
    iter: IBindingIterator;
    obj : IORBObject;
    name: TName;
    blist : TBindingList;
    child: TTreeNode;
  begin
    nc.list(1000,blist,iter);
    for i := 0 to Pred(Length(blist)) do
      begin
        setLength(lst,ind+1);
        lst[ind] := blist[i];
        child := TreeView.Items.AddChildObject(item,String(blist[i].binding_name[0].id),Pointer(ind));
        inc(ind);
        if blist[i].binding_type = ncontext then
          begin
            child.ImageIndex := 1;
            child.SelectedIndex := 1;
            setLength(name,1);
            name[0] := blist[i].binding_name[0];
            obj := nc.resolve(name);
            Update(TNamingContext._narrow(obj),child);
          end
        else
          begin
            child.ImageIndex := 0;
            child.SelectedIndex := 0;
          end;
      end;
  end;

begin
  ind := 0;
  setLength(lst,0);
  TreeView.Items.BeginUpdate;
  try
    TreeView.Items.Clear;
    ListView.Items.Clear;
    Update(ns,nil);
  finally
    TreeView.Items.EndUpdate;
  end;
end;

procedure TMainForm.LocationEditChange(Sender: TObject);
begin
  ConnectButton.Enabled := true;
end;

procedure TMainForm.Reset;
begin
  ns := nil;
  ConnectButton.Enabled := true;
  RefreshButton.Enabled := false;
  TreeView.Items.Clear;
  ListView.Items.Clear;
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
const
  init = '{\rtf1\ansi\deff0\deftab720{\fonttbl{\f0\fnil MS Sans Serif;}}{\colortbl\red0\green0\blue0;\red120\green0\blue0;}';
var
  i : integer;
  obj : IORBObject;
  str: AnsiString;
  name: TName;
begin
  if lst[integer(Node.Data)].binding_type = nobject then
    begin
      stream.Clear;
      stream.WriteBuffer(init,length(init));
      try
        setLength(name,node.Level+1);
        for i := node.Level downto 0 do
          begin
            name[i] := lst[integer(Node.Data)].binding_name[0];
            node := node.Parent;
          end;
        obj := ns.resolve(name);
        str := '\plain\f2\fs16\b ID: \plain\f2\fs16\cf1\b "'+obj._ior.objid+'" \par\par';
        stream.WriteBuffer(PAnsiChar(str)^,length(str));
        str := '\plain\f2\fs16\b URL: \plain\f2\fs16\cf1\b '+ obj._ior.get_profile(TAG_INTERNET_IOP).address.toString+' }';
        stream.WriteBuffer(PAnsiChar(str)^,length(str));
      except
        str := '\plain\f2\fs16\b Error }';
        stream.WriteBuffer(PAnsiChar(str)^,length(str));
      end;
      stream.Position := 0;
      Edit.PlainText := false;
      Edit.Lines.LoadFromStream(stream);
      Edit.PlainText := true;
      Notebook1.ActivePage := 'Text';
    end
  else
    begin
      ListView.Items.Clear;
      ListView.Items.BeginUpdate;
      try
        for i := 0 to pred(Node.Count) do
          begin
            with ListView.Items.Add do
              begin
                Caption := Node.Item[i].Text;
                ImageIndex := Node.Item[i].ImageIndex;
                if Node.Item[i].Count > 0 then
                  SubItems.Add('Context')
                else
                  SubItems.Add('Object');
                Data := Pointer(Node.Item[i]);  
              end;
          end;
      finally
        ListView.Items.EndUpdate;
        Notebook1.ActivePage := 'List';
      end;
    end;
end;

procedure TMainForm.ListViewDblClick(Sender: TObject);
begin
  if ListView.Selected <> nil then
    TreeView.Selected := TTreeNode(ListView.Selected.data)
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Software\DORB\NViewer',true);
      if ValueExists('last_connected') then
        last_connected := ReadString('last_connected')
      else
        last_connected := '-ORBNamingIOR corbaname:iiop:localhost:10000'//'-ORBNamingAddr inet:localhost:10000';
    finally
      free;
    end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Software\DORB\NViewer',true);
      WriteString('last_connected',last_connected);
    finally
      free;
    end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  LocationEdit.Text := last_connected
end;

initialization
  dorb := ORB_Init(nil);
  stream := TMemoryStream.Create;
finalization
  stream.free;
end.
