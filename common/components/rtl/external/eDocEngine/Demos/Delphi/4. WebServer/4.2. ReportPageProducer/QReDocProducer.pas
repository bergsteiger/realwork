unit QReDocProducer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, DBTables;

type
  TfrmQuickReport = class(TForm)
    QuickRep1: TQuickRep;
    Table1: TTable;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRDBRichText1: TQRDBRichText;
    QRDBImage1: TQRDBImage;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
