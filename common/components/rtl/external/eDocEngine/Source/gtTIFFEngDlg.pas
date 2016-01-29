{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDocDefines.inc}
unit gtTIFFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtGfxDlg, gtDocResStrs, gtTIFFEng, gtUtils3;

type
  TgtTIFFEngineDlg = class(TgtGraphicsDlg)
    chkGrayscale: TCheckBox;
    chkMultiPage: TCheckBox;
    lblCompressionType: TLabel;
    cbCompressionType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure Localize; override;

  public
    { Public declarations }
  end;

const
  TIFFCompressionType: array[TgtTIFFCompressionType] of String = (SctNone, SctLZW, SctRLE, SctCCITT3, SctCCITT4);

implementation

uses gtCstDocEng, gtCstGfxEng, gtDocDlg;

{$R *.dfm}

procedure TgtTIFFEngineDlg.FormCreate(Sender: TObject);
var
  I: TgtTIFFCompressionType;
begin
  inherited;
  for I := Low(TgtTIFFCompressionType) to High(TgtTIFFCompressionType) do
		cbCompressionType.Items.AddObject(TIFFCompressionType[I], TObject(I));
  //
  {$IFDEF EMailSupport}
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1, SQualityScaling);
  {$ELSE}
  lbDocumentDlg.Items.Append(SQualityScaling);
  {$ENDIF}
  //
  SetControlsEnabled(gbDocInfo, True);
end;

procedure TgtTIFFEngineDlg.FormShow(Sender: TObject);
begin
  with TgtTIFFEngine(Engine) do
  begin
    with DocInfo do
    begin
      edAuthor.Text := Author;
      edCreator.Text := Creator;
      edKeywords.Text := Keywords;
      edSubject.Text := Subject;
      edTitle.Text := Title;
    end;
    chkGrayscale.Checked := Grayscale;
    chkMultiPage.Checked := MultiPage;
		cbCompressionType.ItemIndex := cbCompressionType.Items.IndexOfObject(
			TObject(Ord(CompressionType)));
  end;
  inherited;
end;

procedure TgtTIFFEngineDlg.Localize;
begin
  inherited;
  Caption := STIFFDlgCaption;

  chkGrayscale.Caption := SchkGrayscale;
  chkMultiPage.Caption := SchkMultiPage;
  lblCompressionType.Caption := SlblCompressionType;
end;

procedure TgtTIFFEngineDlg.btnOKClick(Sender: TObject);
begin
  inherited;
  with TgtTIFFEngine(Engine) do
  begin
    with DocInfo do
    begin
      Author := edAuthor.Text;
      Creator := edCreator.Text;
      Keywords := edKeywords.Text;
      Subject := edSubject.Text;
      Title := edTitle.Text;
    end;  
    Grayscale := chkGrayscale.Checked;
    MultiPage := chkMultiPage.Checked;
    CompressionType := TgtTIFFCompressionType(cbCompressionType.Items.Objects[
      cbCompressionType.ItemIndex]);
  end;
end;

end.
