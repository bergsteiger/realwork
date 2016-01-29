unit d_ExternalObject;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, d_IntEdit, StdCtrls, vtSpin, Buttons, ExtCtrls, Menus;

type
  TExternalObjectDlg = class(TIntegerEditDlg)
    lblObjType: TLabel;
    cbObjType: TComboBox;
    menuObjectType: TPopupMenu;
    itmAddObject: TMenuItem;
    itmEdit: TMenuItem;
    procedure itmEditClick(Sender: TObject);
    procedure itmAddObjectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function RequestExternalObject(var aTopicID : Integer; var aObjType : Integer) : boolean;

implementation

{$R *.dfm}

uses
 ddExternalObjects, D_ExternalObjectEdit,
 DT_Serv;

function RequestExternalObject(var aTopicID : Integer; var aObjType : Integer) : boolean;
begin
 with TExternalObjectDlg.Create(nil) do
 try
  Value := aTopicID;
  cbObjType.Items := ExtObjManager.Strings;
  cbObjType.ItemIndex := cbObjType.Items.IndexOfObject(ExtObjManager.Objects[aObjType]);
  Result := Execute;
  if Result then
  begin
   aTopicID := Value;
   aObjType := TddExternalObject(cbObjType.Items.Objects[cbObjType.ItemIndex]).Handle;
   ExtObjManager.Save;
  end // Result
  else
   ExtObjManager.Revert;
 finally
  Free;
 end;
end;

procedure TExternalObjectDlg.itmEditClick(Sender: TObject);
var
 l_Descr, l_Ext, l_See: String;
 l_ObjType : Integer;
 l_Obj : TddExternalObject;
begin
 // Вызов окна редактирования (добавления) элемента
 l_Obj := TddExternalObject(cbObjType.Items.Objects[cbObjType.ItemIndex]);
 l_Descr:= l_Obj.Description;
 l_Ext:= l_Obj.TypeExtension;
 l_See:= l_Obj.SeeAlsoText;
 with TExternalObjEditDlg.Create(nil) do
 try
  if Execute(l_Descr, l_Ext, l_See) then
  begin
   l_ObjType := l_Obj.Handle;
   l_Obj.Description := l_Descr;
   l_Obj.TypeExtension := l_Ext;
   l_Obj.SeeAlsoText := l_See;
   cbObjType.Items := ExtObjManager.Strings;
   cbObjType.ItemIndex := cbObjType.Items.IndexOfObject(ExtObjManager.Objects[l_ObjType]);
  end;
 finally
  Free;
 end; // TExternalObjEditDlg
end;

procedure TExternalObjectDlg.itmAddObjectClick(Sender: TObject);
var
 l_Descr, l_Ext, l_See: String;
 l_ObjType : Integer;
begin
 // Вызов окна редактирования (добавления) элемента
 l_Descr:= '';
 l_Ext:= '';
 l_See:= '';
 with TExternalObjEditDlg.Create(nil) do
 try
  if Execute(l_Descr, l_Ext, l_See) then
  begin
   l_ObjType := ExtObjManager.AddObject(l_Ext, l_Descr, l_See);
   cbObjType.Items := ExtObjManager.Strings;
   cbObjType.ItemIndex := cbObjType.Items.IndexOfObject(ExtObjManager.Objects[l_ObjType]);
  end;
 finally
  Free;
 end; // TExternalObjEditDlg
end;

procedure TExternalObjectDlg.FormCreate(Sender: TObject);
begin
 inherited;
 if GlobalHtServer.ExtDocIDsFromRange then
 begin
  lblText.Visible := False;
  edtValue.Visible := False;
  Height := Height - (lblObjType.Top - lblText.Top);
 end;
end;

end.
