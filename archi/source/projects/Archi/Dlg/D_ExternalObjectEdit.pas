unit D_ExternalObjectEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls;

type
  TExternalObjEditDlg = class(TBottomBtnDlg)
    Label1: TLabel;
    editDescription: TEdit;
    Label2: TLabel;
    editExtension: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    editSeeAlso: TEdit;
    procedure editDescriptionChange(Sender: TObject);
    procedure editSeeAlsoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   function Execute(var Description, Extension, SeeAlso: String): Boolean;
  end;

var
  BottomBtnDlg1: TExternalObjEditDlg;

implementation

{$R *.dfm}

function TExternalObjEditDlg.Execute(var Description, Extension, SeeAlso: String): Boolean;
begin
  editDescription.Text := Description;
  editExtension.Text := Extension;
  editSeeAlso.Text := SeeAlso;
  Result := ShowModal = mrOk;
  if Result then
  begin
   Description := editDescription.Text;
   Extension := editExtension.Text;
   SeeAlso := editSeeAlso.Text;
  end; // Result
end;

procedure TExternalObjEditDlg.editDescriptionChange(Sender: TObject);
begin
  if editDescription.Text <> '' then
   Caption := editDescription.Text
  else
   Caption := 'Новый внешний объект'
end;

procedure TExternalObjEditDlg.editSeeAlsoChange(Sender: TObject);
begin
 if editSeeAlso.Text = '' then
  editSeeAlso.Text := 'редакторе ';
end;

end.
