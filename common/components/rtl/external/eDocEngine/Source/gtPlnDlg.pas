{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2013 Gnostice Information Technologies Private Limited  }
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

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtPlnDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ExtDlgs,
  gtCstPlnEng, gtDocDlg, gtDocResStrs, gtUtils3;

type
  TgtPlainSheetDlg = class(TgtDocumentDlg)
    chkActiveHyperLinks: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkImageClick(Sender: TObject);
  private
    { Private declarations }

  protected
		procedure Localize; override;
    
  public
    { Public declarations }
  end;

implementation

uses gtCstDocEng;

{$R *.dfm}

procedure TgtPlainSheetDlg.FormCreate(Sender: TObject);
begin
	inherited FormCreate(Sender);
end;

procedure TgtPlainSheetDlg.Localize;
begin
  inherited;
  chkActiveHyperLinks.Caption := SchkActiveHyperLinks;
end;

procedure TgtPlainSheetDlg.btnOKClick(Sender: TObject);
begin
  with TgtCustomPlainSheetEngine(Engine) do
  begin
    Preferences.ActiveHyperLinks := chkActiveHyperLinks.Checked;
    
    if chkText.Checked then
      ItemsToRender := ItemsToRender + [irText]
    else
      ItemsToRender := ItemsToRender - [irText];
    if chkShape.Checked then
      ItemsToRender := ItemsToRender + [irShape]
    else
      ItemsToRender := ItemsToRender - [irShape];
    if chkImage.Checked then
      ItemsToRender := ItemsToRender + [irImage]
    else
      ItemsToRender := ItemsToRender - [irImage];

    with ImageSettings do
    begin
      OutputImageFormat :=
        TgtOutputImageFormat(cbOutputImageFormat.Items.Objects[
        cbOutputImageFormat.ItemIndex]);
      if (edJPEGQuality.Text <> '') then
      begin
        try
          JPEGQuality := StrToInt(edJPEGQuality.Text);
        except
          on EConvertError do
        end;
      end;
      ImagePixelFormat := TPixelFormat(cbImagePixelFormat.Items.Objects[
        cbImagePixelFormat.ItemIndex]);
      SourceDPI := StrToInt(edSourceDPI.Text);
    end;
    
    with DocInfo do
    begin
      Author := edAuthor.Text;
      Creator := edCreator.Text;
      Keywords := edKeywords.Text;
      Subject := edSubject.Text;
      Title := edTitle.Text;
    end;
  end;
	inherited btnOKClick(Sender);
end;

procedure TgtPlainSheetDlg.FormShow(Sender: TObject);
begin
  with TgtCustomPlainsheetEngine(Engine) do
  begin
    chkActiveHyperLinks.Checked := Preferences.ActiveHyperLinks;
    chkText.Checked := irText in ItemsToRender;
    chkShape.Checked := irShape in ItemsToRender;
    chkImage.Checked := irImage in ItemsToRender;
    with ImageSettings do
    begin
      cbImagePixelFormat.ItemIndex := Integer(TPixelFormat(ImagePixelFormat));
      edSourceDPI.Text := IntToStr(SourceDPI);
    end;
    with DocInfo do
    begin
      edAuthor.Text := Author;
      edCreator.Text := Creator;
      edKeywords.Text := Keywords;
      edSubject.Text := Subject;
      edTitle.Text := Title;
    end;
  end;
	inherited FormShow(Sender);
end;

procedure TgtPlainSheetDlg.chkImageClick(Sender: TObject);
begin
	SetControlsEnabled(gbImageSettings, chkImage.Checked);
	cbOutputImageFormatChange(Sender);
end;

end.
