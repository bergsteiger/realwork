unit ft1main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, ShockwaveFlashObjects_TLB, ShockwaveEx;

type
  TForm1 = class(TForm)
    Flash: TShockwaveFlashEx;
    procedure FlashFSCommand(ASender: TObject; const command,
      args: WideString);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FlashFSCommand(ASender: TObject; const command,
  args: WideString);
begin
 MessageDlg(command+#13#10+args, mtInformation, [mbOK], 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 l_Path: string;
 l_Stream: TMemoryStream;
begin
 l_Path := Application.ExeName;
 l_Path := ExtractFilePath(l_Path);
 l_Path := IncludeTrailingPathDelimiter(l_Path) + 'test1.swf';
 l_Stream := TMemoryStream.Create;
 l_Stream.LoadFromFile(l_Path);
 Flash.LoadMovieFromStream(l_Stream);
 l_Stream.Free;
 Flash.Play;
end;

end.
