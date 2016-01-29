unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, D_MEMUSG, StdCtrls, OvcBase,  Buttons,
  ExtCtrls, ImgList, vtLister, vtOutliner;

type
  TMainForm = class(TMemoryUsageDlg)
    ilCommon: TImageList;
    ilOffice: TImageList;
    procedure btOkClick(Sender: TObject);
    function TagTreeGetItemImage(Sender: TObject; Index: Integer;
      var aImages: TCustomImageList): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  StrUtils,
  
  l3Tree_TLB,
  l3String
  ;

{$R *.dfm}

procedure TMainForm.btOkClick(Sender: TObject);
begin
 Close;
end;

function TMainForm.TagTreeGetItemImage(Sender: TObject; Index: Integer;
  var aImages: TCustomImageList): Integer;
var
 l_Node : Il3Node;
 l_Text : String;
begin
 l_Node := TagTree.CTree.GetNode(Index);
 if (l_Node <> nil) then
  with l_Node do begin
   l_Text := l3PCharLen2String(l3PCharLen(Text, -1, TextCodePage));
   if ANSISameText(l_Text, 'properties') then begin
    aImages := ilOffice;
    Result := 231;
   end else if AnsiStartsText('children', l_Text) then begin
    aImages := ilCommon;
    Result := 17;
   end else
    Result := -1;
  end;//wint l_Node
end;

end.
