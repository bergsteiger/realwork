unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Menu11: TMenuItem;
    Item11: TMenuItem;
    Item21: TMenuItem;
    Item31: TMenuItem;
    Menu21: TMenuItem;
    Item12: TMenuItem;
    Item22: TMenuItem;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    f_BackgroundBrush: TBrush;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure SetMainMenuBackground(aMainMenu: TMainMenu; aBackgroundBrush: TBrush; aMainForm: TCustomForm = nil);
var
 l_MenuInfo: TMenuInfo;
begin
 l_MenuInfo.cbSize := SizeOf(TMenuInfo);
 l_MenuInfo.fMask := MIM_BACKGROUND or MIM_APPLYTOSUBMENUS;
 l_MenuInfo.hbrBack := aBackgroundBrush.Handle;
 SetMenuInfo(aMainMenu.Handle, l_MenuInfo);
 { если окно уже открыто, то меню надо перерисовать }
 if aMainForm <> nil then
  DrawMenuBar(aMainForm.Handle);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 f_BackgroundBrush.Color := clRed;
 SetMainMenuBackground(MainMenu1, f_BackgroundBrush, Self);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 f_BackgroundBrush := TBrush.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_BackgroundBrush);
end;

end.
