unit ddCmdLineDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TddCmdLineDlgForm = class(TForm)
    listParams: TListView;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ddCmdLineDlgForm: TddCmdLineDlgForm;

procedure ShowCmdHelpMessage(const aTitle, Helptext: AnsiString);

implementation

uses
  StrUtils;

{$R *.dfm}

procedure ShowCmdHelpMessage(const aTitle, Helptext: AnsiString);
var
 l_EOL, l_Prev: Integer;
 l_Tab: Integer;
 l_S: AnsiString;
 l_Item: TListItem;
begin
 with TddCmdLineDlgForm.Create(nil) do
 try
  Caption:= aTitle;
  l_EOL:= Pos(#13#10, HelpText);
  l_Prev:= 0;
  while l_EOL <> 0 do
  begin
   l_S:= Copy(HelpText, Succ(l_Prev), Pred(l_EOL-l_Prev));
   if l_S <> '' then
   begin
    l_Item:= listParams.Items.Add;
    l_Tab:= Pos(#9, l_S);
    l_Item.Caption:= Copy(l_S, 1, Pred(l_Tab));
    l_Item.SubItems.Add(Copy(l_S, Succ(l_Tab), MaxInt));
   end; // l_S <> ''
   l_Prev:= l_EOL;
   l_EOL:= PosEx(#13#10, HelpText, Succ(l_EOL));
  end; // while l_EOL <> 0
  l_EOL:= MaxInt;
  l_S:= Copy(HelpText, Succ(l_Prev), Pred(l_EOL-l_Prev));
  if l_S <> '' then
  begin
   l_Item:= listParams.Items.Add;
   l_Tab:= Pos(#9, l_S);
   l_Item.Caption:= Copy(l_S, 1, Pred(l_Tab));
   l_Item.SubItems.Add(Copy(l_S, Succ(l_Tab), MaxInt));
  end; // l_S <> ''

  ShowModal;
 finally
  Free;
 end;
end;

procedure TddCmdLineDlgForm.Button1Click(Sender: TObject);
begin
 Close
end;

end.
