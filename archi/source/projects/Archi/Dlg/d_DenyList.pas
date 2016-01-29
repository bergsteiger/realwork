unit d_DenyList;

{ $Id: d_DenyList.pas,v 1.6 2013/04/09 12:29:09 narry Exp $ }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RightBtnDlg, ComCtrls, vtStatusBar, OvcBase, vtLister, StdCtrls, Buttons, ExtCtrls,
  afwControl, afwInputControl, Menus, afwControlPrim, afwBaseControl;

type
  TAccessErrorWin = class(TRightBtnDlg)
    ItemList: TvtDStringLister;
    ListFooter: TvtStatusBar;
    PopupMenu1: TPopupMenu;
    pmCopy: TMenuItem;
    procedure ItemListCurrentChanged(Sender: TObject; NewCurrent, OldCurrent: Longint);
    procedure pmCopyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses
 l3Types,
 l3Base,
 l3Stream,
 l3Clipboard, l3DatLst;

{$R *.dfm}

procedure TAccessErrorWin.ItemListCurrentChanged(Sender: TObject; NewCurrent, OldCurrent: Longint);
begin
 ListFooter.Panels[0].Text := Format('%d из %d', [NewCurrent+1,ItemList.Total]);
end;

procedure TAccessErrorWin.pmCopyClick(Sender: TObject);
var
 l_Stream     : Tl3ClipboardStream;
 l_TextStream : Tl3TextStream;
 I: Integer;
 l_Str: String;
begin
 l_Stream := Tl3ClipboardStream.Create(l3_fmWrite, CF_TEXT {CF_UNICODETEXT});
 try
  l_TextStream := Tl3TextStream.Create(l_Stream);
  try
   with l_TextStream do
   begin
    for I := 0 to Pred(ItemList.Total) do
    if ItemList.Selected[I] then
    begin
     //l_Str := ItemList.Items.PasStr[I] + #13#10;
     //Write((@l_Str[1])^ ,Length(l_Str)*2);
     l_Str:= IntToStr(ItemList.Items.DataInt[I])+#13#10;
     Write(l_Str[1], Length(l_Str));
    end;
    l_Str:= #0;
    Write(l_Str[1], Length(l_Str));
   end;
  finally
   l3Free(l_TextStream);
  end;
 finally
  l3Free(l_Stream);
 end;
end;

end.
