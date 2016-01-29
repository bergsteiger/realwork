unit imageviewerfrm;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_layouts, vg_listbox, vg_controls, vg_objects,
  vg_effects, ExtDlgs,
  vg_extctrls;

type
  TfrmImageViewer = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Button1: TvgButton;
    Layout1: TvgLayout;
    OpenPictureDialog1: TOpenDialog;
    Label1: TvgLabel;
    Label2: TvgLabel;
    imageList: TvgHorzImageListBox;
    StyleBox: TvgPopupBox;
    Label3: TvgLabel;
    ModernStyle: TvgResources;
    VistaStyle: TvgResources;
    imageList2: TvgImageListBox;
    imageList3: TvgHorzImageListBox;
    Label4: TvgLabel;
    ImageViewer1: TvgImageViewer;
    procedure Button1Click(Sender: TObject);
    procedure imageListChange(Sender: TObject);
    procedure StyleBoxChange(Sender: TObject);
    procedure imageList2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure imageList3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImageViewer: TfrmImageViewer;

implementation

{$R *.dfm}

{ TfrmImageViewer =============================================================}

procedure TfrmImageViewer.Button1Click(Sender: TObject);
var
  Dir: string;
begin
  { add folder }
  OpenPictureDialog1.Filter := 'Image files|' + DefaultFilterClass.GetFileTypes;
  if OpenPictureDialog1.Execute then
  begin
    Dir := ExtractFilePath(OpenPictureDialog1.FileName);
    imageList.AddFolder(Dir);
    imageList2.AddFolder(Dir);
    imageList3.AddFolder(Dir);
  end;
end;

procedure TfrmImageViewer.imageListChange(Sender: TObject);
begin
  if (imageList.SelectedFileName <> '') then
  begin
    ImageViewer1.Bitmap.LoadThumbnailFromFile(imageList.SelectedFileName, ImageViewer1.Width, ImageViewer1.Height, false);
  end;
end;

procedure TfrmImageViewer.StyleBoxChange(Sender: TObject);
begin
  case StyleBox.ItemIndex of
    0: vgScene1.Style := nil;
    1: vgScene1.Style := ModernStyle;
    2: vgScene1.Style := VistaStyle;
  end;
end;

procedure TfrmImageViewer.imageList2Change(Sender: TObject);
begin
  if (imageList2.SelectedFileName <> '') then
  begin
    ImageViewer1.Bitmap.LoadThumbnailFromFile(imageList2.SelectedFileName, ImageViewer1.Width, ImageViewer1.Height, false);
  end;
end;

procedure TfrmImageViewer.Button2Click(Sender: TObject);
begin
  imageList.Clear;
  imageList2.Clear;
end;

procedure TfrmImageViewer.imageList3Change(Sender: TObject);
begin
  if (imageList3.SelectedFileName <> '') then
  begin
    ImageViewer1.Bitmap.LoadThumbnailFromFile(imageList3.SelectedFileName, ImageViewer1.Width, ImageViewer1.Height, false);
  end;
end;

end.
