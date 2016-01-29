unit AddActn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DesignIntf, DesignEditors, DesignWindows;

type
  TAddActionDialog = class(TForm)
    URLEdit: TEdit;
    ComponentEdit: TEdit;
    TypeComboBox: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure TypeComboBoxChange(Sender: TObject);
  public
    Designer: IFormDesigner;
  end;

implementation

{$R *.dfm}

procedure TAddActionDialog.TypeComboBoxChange(Sender: TObject);
begin
  ComponentEdit.Text := Designer.UniqueName(TypeComboBox.Items[TypeComboBox.ItemIndex]);
end;

end.
