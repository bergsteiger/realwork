unit a2InExUserDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, l3DatLst;

type
  TRegionChooseDlg = class(TForm)
    cbRegion: TComboBox;
    Label1: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    feFilename: TFilenameEdit;
    Label2: TLabel;
    procedure cbRegionSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure feFilenameChange(Sender: TObject);
  private
    f_RegionList: Tl3StringDataList;
    { Private declarations }
    procedure LoadRegionList;
  public
    { Public declarations }
  end;

var
  RegionChooseDlg: TRegionChooseDlg;

function ChooseFileAndRegionForImport(out theFilename: string; out theRegion: Integer): Boolean;
function ChooseFileAndRegionForExport(out theFilename: string; out theRegion: Integer): Boolean;

implementation
uses
 daDataProvider,

 dtDictItems,
 Dt_Dict,

 a2Interfaces;

{$R *.dfm}

function ChooseFileAndRegionPrim(const aForExport: Boolean; out theFilename: string; out theRegion: Integer): Boolean;
var
 l_Dlg: TRegionChooseDlg;
begin
 Result := False;
 l_Dlg := TRegionChooseDlg.Create(Application);
 try
  if aForExport then
  begin
   l_Dlg.Caption := 'Параметры экспорта';
   l_Dlg.cbRegion.ItemIndex := 1;
  end
  else
   l_Dlg.Caption := 'Параметры импорта';

  if l_Dlg.ShowModal = mrOK then
  begin
   Result := True;
   theFilename := l_Dlg.feFilename.FileName;
   case l_Dlg.cbRegion.ItemIndex of
    0: theRegion := regAllRegions;
    1: theRegion := GlobalDataProvider.RegionID;
   else
    theRegion := Byte(l_Dlg.f_RegionList.Data[l_Dlg.cbRegion.ItemIndex - 3]^);
   end;
  end;
 finally
  FreeAndNil(l_Dlg);
 end;
end;

function ChooseFileAndRegionForExport(out theFilename: string; out theRegion: Integer): Boolean;
begin
 Result := ChooseFileAndRegionPrim(True, theFilename, theRegion);
end;

function ChooseFileAndRegionForImport(out theFilename: string; out theRegion: Integer): Boolean;
begin
 Result := ChooseFileAndRegionPrim(False, theFilename, theRegion);
end;

procedure TRegionChooseDlg.cbRegionSelect(Sender: TObject);
begin
 if cbRegion.ItemIndex = 2 then
  cbRegion.ItemIndex := 1;
end;

procedure TRegionChooseDlg.LoadRegionList;
var
 I: Integer;
begin
 f_RegionList := Tl3StringDataList.Create;
 GlobalDataProvider.FillRegionDataList(f_RegionList, False);
 for I := 0 to Pred(f_RegionList.Count) do
  cbRegion.Items.Add(f_RegionList.PasStr[I]);
end;

procedure TRegionChooseDlg.FormCreate(Sender: TObject);
begin
 LoadRegionList;
end;

procedure TRegionChooseDlg.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_RegionList)
end;

procedure TRegionChooseDlg.feFilenameChange(Sender: TObject);
begin
 btnOK.Enabled := feFilename.FileName <> '';
end;

end.
