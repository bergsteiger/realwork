unit alcuEmailMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, StdCtrls, ExtCtrls, ddAppConfigDataAdapters;

type
  TEmailMessage = class(TForm)
    editAddress: TLabeledEdit;
    cbSubject: TComboBox;
    Label1: TLabel;
    memoBody: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    procedure cbSubjectSelect(Sender: TObject);
    procedure editAddressChange(Sender: TObject);
  private
    { Private declarations }
    f_Adapter : TddSimpleListDataAdapter;
    function FindSubjectInConfig(const aSubject: string): Integer;
  public
    { Public declarations }
   function Execute(var aAddress, aSubject, aBody: String): Boolean;
  end;

var
  EmailMessage: TEmailMessage;

implementation
uses
 ddAppConfig, ddAppConfigConst, ddAppConfigTypes, ddAppConfigUtils;

{$R *.dfm}

procedure TEmailMessage.cbSubjectSelect(Sender: TObject);
var
 l_Idx : Integer;
begin
 l_Idx := FindSubjectInConfig(cbSubject.Text);
 if l_Idx >= 0 then
  memoBody.Lines.Text := f_Adapter.Values[l_Idx, 'Body'].AsString;
end;

function TEmailMessage.Execute(var aAddress, aSubject, aBody: String): Boolean;
var
 I: Integer;
 l_New: TddAppConfigNode;
 l_Item: TddBaseConfigItem;
begin
  editAddress.Text := aAddress;
  cbSubject.Text := aSubject;
  memoBody.Lines.Text := aBody;
  f_Adapter := TddSimpleListDataAdapter(ddAppConfiguration.AsObject['EmailNotifications']);
  for I := 0 to f_Adapter.Count - 1 do
   cbSubject.Items.Add(f_Adapter.Strings[I]);
  Result := ShowModal = mrOk;
  if Result then
  begin
   aAddress := editAddress.Text;
   aSubject := cbSubject.Text;
   aBody := memoBody.Lines.Text;
   I := FindSubjectInConfig(aSubject);
   if I < 0 then
   begin
    I := f_Adapter.AddItem;
    l_New := TddAppConfigNode(f_Adapter.Objects[I]);
    l_New.Caption := aSubject;
    l_New.AsString['Caption'] := aSubject;
    l_New.AsString['Body']    := aBody;
    ddAppConfiguration.HasValue('EmailNotifications', l_Item);
    l_Item.Changed := True;
   end;
  end; // Result
end;

procedure TEmailMessage.editAddressChange(Sender: TObject);
begin
 Button1.Enabled := (editAddress.Text <> '') and (cbSubject.Text <> '')
                    and (memoBody.Lines.Text <> '');
end;

function TEmailMessage.FindSubjectInConfig(const aSubject: string): Integer;
var
 I: Integer;
begin
 Result := -1;
 for I := 0 to f_Adapter.Count - 1 do
  if f_Adapter.Strings[I] = aSubject then
  begin
   Result := I;
   Break;
  end;
end;

end.
