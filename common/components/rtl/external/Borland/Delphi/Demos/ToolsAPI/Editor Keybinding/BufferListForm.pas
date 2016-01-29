unit BufferListForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TBufferListFrm = class(TForm)
    BufferListBox: TListBox;
    OKButton: TButton;
    CancelButton: TButton;
    procedure BufferListBoxDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

var
 g_Top  : Integer = -1;
 g_Left : Integer = -1;
 g_Width  : Integer = 0;
 g_Height : Integer = 0;

procedure TBufferListFrm.BufferListBoxDblClick(Sender: TObject);
begin
  if BufferListBox.ItemIndex > -1 then ModalResult := mrOK;
end;

procedure TBufferListFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 g_Width := Width;
 g_Height := Height;
 g_Top := Top;
 g_Left := Left;
end;

procedure TBufferListFrm.FormShow(Sender: TObject);
begin
 if (g_Top >= 0) then
  Top := g_Top;
 if (g_Left >= 0) then
  Left := g_Left;
 if (g_Width > 0) then
  Width := g_Width;
 if (g_Height > 0) then
  Height := g_Height;
end;

end.
