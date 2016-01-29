unit alcuQueryExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, StdCtrls;

type
  TalcuQueryExportDlg = class(TForm)
    Label1: TLabel;
    EditCaption: TEdit;
    Label2: TLabel;
    comboQuery: TComboBox;
    ButtonImport: TButton;
    Label3: TLabel;
    ComboFormat: TComboBox;
    Label4: TLabel;
    EditPartSize: TEdit;
    Label5: TLabel;
    EditFolder: TEdit;
    Button2: TButton;
    Button3: TButton;
    procedure ButtonImportClick(Sender: TObject);
  private
    function Execute(var aCaption: string; var aQueryIndex, aFormat: Integer; var aPartSize: LongInt;
        var aFolder: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
 StrUtils;

{$R *.dfm}

procedure TalcuQueryExportDlg.ButtonImportClick(Sender: TObject);
begin
 // Для добавления запроса из папки пользователя
end;

function TalcuQueryExportDlg.Execute(var aCaption: string; var aQueryIndex, aFormat: Integer; var
    aPartSize: LongInt; var aFolder: String): Boolean;
begin
 EditCaption.Text:= aCaption;
 Caption:= IfThen(aCaption = '', 'Новый экспорт', aCaption);
 EditPartSize.Text:= IntToStr(aPartSize);
 EditFolder.Text:= aFolder;
 comboQuery.ItemIndex:= aQueryIndex;
 ComboFormat.ItemIndex:= aFormat;
 Result := IsPositiveResult(ShowModal);
 if Result then
 begin
  aCaption:= EditCaption.Text;
  aPartSize:= StrToIntDef(EditPartSize.Text, 0);
  aFolder:= EditFolder.Text;
  aQueryIndex:= comboQuery.ItemIndex;
  aFormat:= ComboFormat.ItemIndex;
 end; // Result
end;

end.
