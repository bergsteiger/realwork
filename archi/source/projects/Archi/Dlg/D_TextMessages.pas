unit D_TextMessages;
// $Id: D_TextMessages.pas,v 1.4 2013/04/19 13:05:03 lulin Exp $

// $Log: D_TextMessages.pas,v $
// Revision 1.4  2013/04/19 13:05:03  lulin
// - портируем.
//
// Revision 1.3  2012/02/20 08:48:00  narry
// Сообщение о состоянии экспорта (340167865)
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OvcBase,
  l3Interfaces,
  afwControl, afwInputControl, vtLister, StdCtrls, afwControlPrim,
  afwBaseControl;

type
  TdlgTextMessages = class(TForm)
    Lister: TvtLister;
    Button1: TButton;
    procedure ListerGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function ListerGetItemImageIndex(Sender: TObject;
      Index: Integer): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure IncomingMessages(aCount: Integer; const aLastMsg: AnsiString);
  end;

var
  dlgTextMessages: TdlgTextMessages;

implementation
uses
 l3Base,
 ArchiUserRequestManager;

{$R *.dfm}

procedure TdlgTextMessages.ListerGetStrItem(Sender: TObject; Index: Integer;
  var ItemString: Il3CString);
begin
 ItemString := Tl3CConstDelphiString.MakeI(ArchiRequestManager.TextMessages[Index]);
end;

procedure TdlgTextMessages.FormShow(Sender: TObject);
begin
 Lister.Total := ArchiRequestManager.TextMessages.Count;
end;

procedure TdlgTextMessages.Button1Click(Sender: TObject);
begin
 ModalResult := mrOK;
end;

function TdlgTextMessages.ListerGetItemImageIndex(Sender: TObject;
  Index: Integer): Integer;
begin
 Result := 2;
end;

procedure TdlgTextMessages.IncomingMessages(aCount: Integer; const aLastMsg: AnsiString);
begin
 Lister.Total := ArchiRequestManager.TextMessages.Count;
end;

end.
