unit uWordApp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TWordAppForm = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WordAppForm: TWordAppForm;

implementation

uses
  Mapi
  ;

{$R *.DFM}

procedure TWordAppForm.Button1Click(Sender: TObject);
var
 S : LHANDLE;
 Files : array [0..255] of Char;
begin
 Files := 'N:\My\1.EVD';
 MAPILogon(0, nil, nil, MAPI_LOGON_UI, 0, @S);
 try
  MAPISendDocuments(0, ';', @Files, nil, 0);
 finally
  MAPILogOff(S, 0, 0, 0);
 end;{try}
end;

end.
