unit ErrorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TPipeErrorForm  = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PipeErrorForm: TPipeErrorForm;

implementation

{$R *.DFM}
Uses
 afwVCL;

procedure TPipeErrorForm.Button2Click(Sender: TObject);
begin
  { Сохранение лога ошибок в файл }
  if SaveDialog1.Execute then
    ListBox1.Items.SavetoFile(SaveDialog1.FileName);
end;

procedure TPipeErrorForm.FormCreate(Sender: TObject);
begin
 afwHackControlFont(Self);
end;

end.
