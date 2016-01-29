unit Submit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,

  gtCstDocEng, gtExPDFEng, gtPDFEng
  ;

type
  TfrmSample = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSample: TfrmSample;

implementation

uses gtCstPDFEng, gtCstPlnEng;

{$R *.dfm}

procedure TfrmSample.Button1Click(Sender: TObject);
var
	Eng: TgtPDFEngine;
  LField: TgtPDFFormField;
  LI: Integer;
  LRadioItem: array[0..1] of TgtPDFFormRadioItem;
begin
	Eng := TgtPDFEngine.Create(Self);
  with Eng do
  begin
  	FileName := ExtractFilePath(Application.ExeName) + 'PDFForm';
    Preferences.ShowSetupDialog := False;
    Preferences.OpenAfterCreate := False;
    Compression.Enabled := False;
    MeasurementUnit := muPixels;
    BeginDoc;
    	LI := SaveEngineState;
      Font.Size := 20;
      Font.Style := [fsBold];
    	TextFormatting.Alignment := haCenter;
      TextFormatting.BeforeSpace := 60;
    	BeginPara;
    	TextOut('eDocEngine PDF Form Submission Demo');
      EndPara;
      TextFormatting.BeforeSpace := 5;
      Font.Size := 14;
    	BeginPara;
    	TextOut('Sample PDF Form');
      EndPara;
      RestoreEngineState(LI);

      TextOut(200, 160, 'Name:');
	    LField := TgtPDFFormTextField.Create;
      with TgtPDFFormTextField(LField) do
      begin
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
        Rect := gtRect(300, 150, 550, 180);
        Value := 'Type your name here';
        FieldName := 'name';
      end;
      AddFormItem(LField);

      TextOut(200, 210, 'Company:');
	    LField := TgtPDFFormTextField.Create;
      with TgtPDFFormTextField(LField) do
      begin
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
        Rect := gtRect(300, 200, 550, 230);
        Value := 'Your company name';
        FieldName := 'company';
      end;
      AddFormItem(LField);

      TextOut(200, 250, 'Email:');
	    LField := TgtPDFFormTextField.Create;
      with TgtPDFFormTextField(LField) do
      begin
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
        Rect := gtRect(300, 240, 550, 270);
        Value := 'Your email-id';
        FieldName := 'email_id';
      end;
      AddFormItem(LField);

      TextOut(200, 290, 'Gender:');
      TextOut(325, 290, 'Male');
      TextOut(450, 290, 'Female');
	    LField := TgtPDFFormRadioButton.Create;
      LRadioItem[0] := TgtPDFFormRadioItem.Create;
      with LRadioItem[0] do
      begin
        Rect := gtRect(300, 290, 315, 305);
        Value := 'Male';
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
      end;
      LRadioItem[1] := TgtPDFFormRadioItem.Create;
      with LRadioItem[1] do
      begin
        Rect := gtRect(425, 290, 440, 305);
        Value := 'Female';
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
      end;
      with TgtPDFFormRadioButton(LField) do
      begin
        FieldName := 'gender';
        Symbol := pfcsStar;
        AtleastOneSelectedItem := True;
        SelectedItemIndex := 1;
        AddItem(LRadioItem[0]);
        AddItem(LRadioItem[1]);
      end;
      AddFormItem(LField);

			TextOut(200, 330, 'Country:');
      LField := TgtPDFFormComboBox.Create;
      with TgtPDFFormComboBox(LField) do
      begin
        FieldName := 'country';
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
        Rect := gtRect(300, 320, 550, 350);
        IsEditable := False;
        SelectedItemIndex := 0;
        AddItem('Afghanistan');
        AddItem('Australia');
        AddItem('Canada');
        AddItem('China');
        AddItem('France');
        AddItem('Germany');
        AddItem('India');
        AddItem('Japan');
        AddItem('Korea');
        AddItem('Malaysia');
        AddItem('Mexico');
        AddItem('New Zealand');
        AddItem('Portugal');
        AddItem('Russia');
        AddItem('Singapore');
        AddItem('Spain');
        AddItem('Switzerland');
        AddItem('Taiwan');
        AddItem('Thailand');
        AddItem('United Arab Emirates');
        AddItem('United Kingdom');
        AddItem('United States');
        AddItem('Zimbabwe');
        AddItem('Other');
      end;
      AddFormItem(LField);

			TextOut(200, 370, 'Profession:');
      LField := TgtPDFFormListBox.Create;
      with TgtPDFFormListBox(LField) do
      begin
        FieldName := 'profession';
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
        Rect := gtRect(300, 370, 550, 470);
        IsMultiSelect := False;
        AddItem('Accounting/Finance');
        AddItem('Computer Related (other)');
        AddItem('Computer Related (Internet)');
        AddItem('Consulting');
        AddItem('Customer Service/Support');
        AddItem('Education/Training');
        AddItem('Engineering');
        AddItem('Executive/Senior Management');
        AddItem('Government/Military');
        AddItem('Homemaker');
        AddItem('Professional');
        AddItem('Research and Development');
        AddItem('Retired');
        AddItem('Sales/Marketing/Advertising');
        AddItem('Self-employed/Owner');
        AddItem('Student');
        AddItem('Unemployed/Between Jobs');
        AddItem('Other');
      end;
      AddFormItem(LField);

      LField := TgtPDFFormCheckBox.Create;
      with TgtPDFFormCheckBox(LField) do
      begin
        Checked := True;
        Symbol := pfcsCheck;
        BackgroundColor := clLtGray;
        BorderColor := clBlue;
        Rect := gtRect(300, 485, 315, 500);
        FieldName := 'subscribe';
      end;
      AddFormItem(LField);
      TextOut(325, 485, 'Yes! I want to subscribe to the newsletter');

      LField := TgtPDFFormPushButton.Create;
      with TgtPDFFormPushButton(LField) do
      begin
        Rect := gtRect(275, 540, 375, 570);
        NormalCaption := 'Submit';
        RolloverCaption := 'Submit';
        DownCaption := 'Submit';
        Action := pbaSubmit;
        TgtPDFFormPushButton(LField).Preferences := [afpNoExport];
        SubmitURL := 'http://localhost/edocweb/4.3.%20PDFFormServer/PDFFormServer.exe';
        BackgroundColor := clBtnFace;
      end;
      AddFormItem(LField);

      LField := TgtPDFFormPushButton.Create;
      with TgtPDFFormPushButton(LField) do
      begin
        Rect := gtRect(425, 540, 525, 570);
        NormalCaption := 'Reset';
        RolloverCaption := 'Reset';
        DownCaption := 'Reset';
        Action := pbaReset;
        BackgroundColor := clBtnFace;
      end;
      AddFormItem(LField);

    EndDoc;
  end;
  Eng.Free;
end;

end.
