unit rtRegionIDDlg;

{ $Id: rtRegionIDDlg.pas,v 1.3 2015/04/02 12:46:24 lukyanets Exp $}

// $Log: rtRegionIDDlg.pas,v $
// Revision 1.3  2015/04/02 12:46:24  lukyanets
// Изолируем регион
//
// Revision 1.2  2007/05/07 08:09:41  fireton
// - cBadRegion вынесен в отдельный модуль
//
// Revision 1.1  2007/04/09 11:31:44  fireton
// - первый коммит
//

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TRegionIDDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    edRegionID: TEdit;
    Label1: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    f_RegionID: Byte;
    { Private declarations }
  public
    property RegionID: Byte read f_RegionID write f_RegionID;
    { Public declarations }
  end;

var
  RegionIDDlg: TRegionIDDlg;

implementation
uses
 Dialogs,

 DT_Types,
 daDataProvider,

 rtConst;

{$R *.dfm}

procedure TRegionIDDlg.OKBtnClick(Sender: TObject);
begin
 f_RegionID := StrToIntDef(edRegionID.Text, cBadRegion);
 if (f_RegionID = cBadRegion) or (not GlobalDataProvider.IsRegionExists(f_RegionID)) then
  MessageDlg('Неверный код региона!', mtError, [mbYes], 0)
 else
  ModalResult := mrOK;
end;

procedure TRegionIDDlg.FormShow(Sender: TObject);
begin
 if f_RegionID <> cBadRegion then
  edRegionID.Text := IntTostr(f_RegionID)
 else
  edRegionID.Text := '';
 ActiveControl := edRegionID;
end;

end.
