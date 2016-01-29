unit dp_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    btnGo: TButton;
    ProgressBar: TProgressBar;
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 daTypes,

 DT_Const,
 DT_Types,
 DT_Dict,
 DT_AttrSchema,
 dt_DictConst,

 l3String,
 l3Tree_TLB,
 l3DatLst;

{$R *.dfm}

procedure TForm1.btnGoClick(Sender: TObject);
var
 I: Integer;
 l_Dict: TDictionary;
 l_DocFormsID: TDictID;
 l_GazpromID : TDictID;
 l_ID : TDictID;
 l_List: Tl3StringDataList;
begin
 btnGo.Enabled := False;
 try
  l_Dict := DictServer(CurrentFamily).Dict[da_dlPrefixes];
  l_DocFormsID := l_Dict.FindIDByFullPath(l3PCharLen('Формы документов'));
  l_GazpromID := l_Dict.FindIDByFullPath(l3PCharLen('Документы ОАО "Газпром"'));
  l_List := l_Dict.List;
  ProgressBar.Max := l_List.Count;
  ProgressBar.Position := 0;
  for I := 0 to l_List.Count - 1 do
  begin
   l_ID := l_List.DataInt[I];
   if (l_ID <> l_DocFormsID) and (l_ID <> l_GazpromID) then
    l_Dict.DelDictItem(l_ID);
   ProgressBar.StepIt;
   Application.ProcessMessages;
  end;
  MessageDlg('Работа завершена', mtInformation, [mbOK], 0);
 finally
  btnGo.Enabled := True;
 end;
end;

end.
