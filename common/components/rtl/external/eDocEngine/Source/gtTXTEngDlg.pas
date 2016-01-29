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
unit gtTXTEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  gtDocDlg, gtDocResStrs, gtUtils3, gtTXTEng;

type
  TgtTextEngineDlg = class(TgtDocumentDlg)
    tsTextFormatting: TTabSheet;
    gbFormatting: TGroupBox;
    lblTextLineSpacing: TLabel;
    cbLineSpacing: TComboBox;
    lblTextColumnSpacing: TLabel;
    edColumnSpacing: TEdit;
    gbSeparatorMode: TGroupBox;
    chkUseSeparator: TCheckBox;
    lblSeparator: TLabel;
    edSeparator: TEdit;
    lblTextDefaultFont: TLabel;
    pnlDefaultFont: TPanel;
    sbtnSetDefaultFont: TSpeedButton;
    chkTextPageEndLines: TCheckBox;
    chkInsertPageBreaks: TCheckBox;
    chkTextSingleFile: TCheckBox;
    FontDialog: TFontDialog;
    procedure FormCreate(Sender: TObject);
    procedure chkUseSeparatorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtnSetDefaultFontClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure Localize; override;
    
  public
    { Public declarations }
  end;

const
  TextLineSpacing: array[TgtTextLineSpacing] of String = (SlsActual,
    SlsOneBlank, SlsTwoBlank, SlsThreeBlank, SlsFourBlank, SlsFiveBlank);

implementation

uses gtCstDocEng;

{$R *.dfm}

{ TgtTextEngineDlg }

procedure TgtTextEngineDlg.Localize;
begin
  inherited;
  Caption := STXTDlgCaption;

  tsTextFormatting.Caption := StsTextFormatting;
  lblTextLineSpacing.Caption := SlblTextLineSpacing;
  lblTextColumnSpacing.Caption := SlblTextColumnSpacing;
  chkUseSeparator.Caption := SchkSeparatorMode;
  lblSeparator.Caption := SlblSeparator;
  lblTextDefaultFont.Caption := SlblTextDefaultFont;
  chkTextPageEndLines.Caption := SchkTextPageEndLines;
  chkInsertPageBreaks.Caption := SchkInsertPageBreaks;
  chkTextSingleFile.Caption := SchkTextSingleFile;
end;

procedure TgtTextEngineDlg.FormCreate(Sender: TObject);
var
  I: TgtTextLineSpacing;
begin
  inherited;
	for I := Low(TgtTextLineSpacing) to High(TgtTextLineSpacing) do
		cbLineSpacing.Items.AddObject(TextLineSpacing[I], TObject(I));
  //
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SContent));
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SBackground));

  {$IFDEF EMailSupport}
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1, StsFormatting);
  {$ELSE}
  lbDocumentDlg.Items.Append(StsFormatting);
  {$ENDIF}

  //
  //tsTextFormatting.PageIndex := tsTextFormatting.PageIndex - 2;
  tsContent.TabVisible := False;
  tsBackground.TabVisible := False;
end;

procedure TgtTextEngineDlg.chkUseSeparatorClick(Sender: TObject);
begin
	SetControlsEnabled(gbSeparatorMode, chkUseSeparator.Checked);
end;

procedure TgtTextEngineDlg.FormShow(Sender: TObject);
begin
  inherited;
  with TgtTextEngine(Engine) do
  begin
    chkUseSeparator.Checked := UseSeparator;
    edSeparator.Text := Separator;
    pnlDefaultFont.Font.Assign(DefaultFont);
    edColumnSpacing.Text := IntToStr(ColumnSpacing);
    cbLineSpacing.ItemIndex := cbLineSpacing.Items.IndexOfObject(
      TObject(Ord(LineSpacing)));
    chkInsertPageBreaks.Checked := InsertPageBreaks;
    chkTextPageEndLines.Checked := PageEndlines;
    chkTextSingleFile.Checked := SingleFile;
    chkUseSeparatorClick(Sender);
    lblTextDefaultFont.Caption := SlblDefaultDocFont;
  end;
end;

procedure TgtTextEngineDlg.sbtnSetDefaultFontClick(Sender: TObject);
begin
	with FontDialog do
	begin
    Font := pnlDefaultFont.Font;
		if Execute then
      pnlDefaultFont.Font.Assign(FontDialog.Font);
	end;
end;

procedure TgtTextEngineDlg.btnOKClick(Sender: TObject);
begin
  inherited;
  with TgtTextEngine(Engine) do
  begin
    UseSeparator := chkUseSeparator.Checked;
    if edSeparator.Text <> '' then
      Separator := edSeparator.Text[1];
    DefaultFont.Assign(pnlDefaultFont.Font);
    ColumnSpacing := StrToInt(edColumnSpacing.Text);
    LineSpacing := TgtTextLineSpacing(cbLineSpacing.Items.Objects[
      cbLineSpacing.ItemIndex]);
    InsertPageBreaks := chkInsertPageBreaks.Checked;
    PageEndlines := chkTextPageEndLines.Checked;
    SingleFile := chkTextSingleFile.Checked;
  end;
end;

end.
