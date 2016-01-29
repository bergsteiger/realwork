unit dragfrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_controls, vg_ani, vg_listbox,
  vg_layouts;

type
  TForm9 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Panel1: TvgPanel;
    Rectangle1: TvgRectangle;
    Ellipse1: TvgEllipse;
    FloatKeyAnimation1: TvgFloatKeyAnimation;
    Line1: TvgLine;
    Label1: TvgLabel;
    Label2: TvgLabel;
    Label3: TvgLabel;
    Panel2: TvgPanel;
    Label4: TvgLabel;
    Image1: TvgImage;
    ListBox1: TvgListBox;
    ListBoxItem1: TvgListBoxItem;
    Image2: TvgImage;
    ListBoxItem2: TvgListBoxItem;
    ListBoxItem3: TvgListBoxItem;
    Image3: TvgImage;
    Image4: TvgImage;
    procedure Rectangle1DragOver(Sender: TObject;
      const Data: TvgDragObject; const Point: TvgPoint;
      var Accept: Boolean);
    procedure Rectangle1DragDrop(Sender: TObject;
      const Data: TvgDragObject; const Point: TvgPoint);
    procedure Image1DragOver(Sender: TObject; const Data: TvgDragObject;
      const Point: TvgPoint; var Accept: Boolean);
    procedure Image1DragDrop(Sender: TObject; const Data: TvgDragObject;
      const Point: TvgPoint);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.Rectangle1DragOver(Sender: TObject;
  const Data: TvgDragObject; const Point: TvgPoint; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TForm9.Rectangle1DragDrop(Sender: TObject;
  const Data: TvgDragObject; const Point: TvgPoint);
begin
  if (Data.Data = '') and (Data.Source <> nil) then
    Label1.Text := 'Dropped object - ' + Data.Source.ClassName
  else
    Label1.Text := 'Dropped object - ' + Data.Data;

  if Data.Source is TvgImage then
  begin
    Image1.Bitmap.Assign(TvgImage(Data.Source).Bitmap);
  end
  else
    if FileExists(Data.Data) and (Pos(ExtractFileExt(Data.Data), DefaultFilterClass.GetFileTypes) > 0) then
      Image1.Bitmap.LoadThumbnailFromFile(Data.Data, 300, 300, false);
end;

procedure TForm9.Image1DragOver(Sender: TObject; const Data: TvgDragObject;
  const Point: TvgPoint; var Accept: Boolean);
begin
  // accept correct image file or TvgImage 
  Accept :=
    ((Length(Data.Files) > 0) and FileExists(Data.Files[0]) and (Pos(ExtractFileExt(Data.Files[0]), DefaultFilterClass.GetFileTypes) > 0))
    or
    (Data.Source is TvgImage);
end;

procedure TForm9.Image1DragDrop(Sender: TObject; const Data: TvgDragObject;
  const Point: TvgPoint);
begin
  if Data.Source is TvgImage then
  begin
    Image1.Bitmap.Assign(TvgImage(Data.Source).Bitmap);
  end
  else
  if Length(Data.Files) > 0 then
  begin
    Image1.Bitmap.LoadThumbnailFromFile(Data.Files[0], 300, 300, false);
  end;
  Image1.Repaint;
end;

end.
