unit Main;

{ $Id: Main.pas,v 1.8 2009/09/17 11:44:18 lulin Exp $ }
// $Log: Main.pas,v $
// Revision 1.8  2009/09/17 11:44:18  lulin
// {RequestLink:163065542}.
//
// Revision 1.7  2006/04/25 08:57:23  lulin
// - cleanup.
//
// Revision 1.6  2005/05/27 14:44:41  lulin
// - ������� ������� �������� � ���������� L3.
//
// Revision 1.5  2005/05/23 15:47:35  lulin
// - ����� ��������� ����������� ����� ������������.
//
// Revision 1.4  2004/10/12 08:22:27  step
// ���������������� �������� ������������ ������ ������-�� ��
//
// Revision 1.3  2004/10/11 07:00:17  step
// ����� update ������� ���������
//
// Revision 1.2  2004/10/08 14:02:59  step
// - �������� update ������� ��������� ��� ��������� �������� ������
// - ��������� ��������� ��� ������ ������ Start
//
// Revision 1.1  2004/10/05 16:19:31  step
// �������� � CVS
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3Types, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit;

type
  TMainForm = class(TForm)
    btCopy: TButton;
    FileMeter: TvtW95Meter;
    FilesMeter: TvtW95Meter;
    lbFile: TLabel;
    lbFiles: TLabel;
    lbNum: TLabel;
    pnStatus: TPanel;
    lbPercent: TLabel;
    edBaseDir: TDirectoryEdit;
    Label1: TLabel;
    procedure btCopyClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FilesMeterSetStr(const aStr: String);
  private
    f_InProcess: Boolean;
    procedure Yield(aSender: TObject);
    procedure FilesProcessedEx(aCurrentID : Long;
                               aMaxID     : Long;
                               aTime      : TDateTime);
    procedure Old2New;
    procedure Delta2Const;
    function StorageFile: string;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  l3Base,
  l3MinMax,
  l3Filer,
  l3FileUtils,
  l3WindowsStorageFiler,
  l3String,

  m0EXCLib,

  m2COMLib,

  m3Const,
  m3StorageInterfaces,
  m3StorageTools,
  m3StgMgr,
  m3OldBaseTools,
  m3BackupTools,
  m3DB,

  m4DB,
  m4DBInterfaces,

  evEvdRd,
  evEvdWriter;

const
 cFileName = 'bserv001';

procedure TMainForm.btCopyClick(Sender: TObject);
begin
{
 if not FileExists(ChangeFileExt(StorageFile, '.STG')) then
 begin
  MessageDlg('��������� �� �������.'#13#10'��������� ��������.',
             mtError, [mbOk], 0);
  Exit;
 end;
}
 btCopy.Enabled := False;
 edBaseDir.Enabled := False;
 f_InProcess := True;
 try
  pnStatus.Caption := '����������� �����������.';
  Old2New;

  pnStatus.Caption := '����������� ����������.';
  Delta2Const;

  pnStatus.Caption := '��������� ���������.';
 finally
  f_InProcess := False;
  btCopy.Enabled := True;
  edBaseDir.Enabled := True;
 end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose := not f_InProcess;
end;

procedure TMainForm.Yield(aSender: TObject);
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FilesProcessedEx(aCurrentID : Long;
                                     aMaxID     : Long;
                                     aTime      : TDateTime);
begin
 lbPercent.Caption := IntToStr(FilesMeter.Percent) +
                               '% ' +
                               TimeToStr(aTime);
 if (FilesMeter.Percent > 0) then
  lbPercent.Caption := lbPercent.Caption +
                       ' ��������� ����� ' + TimeToStr((aTime) * 100 / FilesMeter.Percent);
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbNum.Caption := aStr;
end;

procedure TMainForm.Old2New;
var
 l_Db: Im3DB;
 l_DbOld: Im3DB;
begin
 l_Db := Tm3DB.Make(StorageFile,
                    False,
                    Yield,
                    FileMeter.ProgressProc_ev,
                    FilesMeter.ProgressProc_ev,
                    nil,
                    FilesProcessedEx);
 try
  l_Db.Start(m3_saReadWrite, m3_saRead);
  try
   l_DbOld := Tm3DB.Make(StorageFile,
                         true,
                         Yield,
                         FileMeter.ProgressProc_ev,
                         FilesMeter.ProgressProc_ev,
                         nil,
                         FilesProcessedEx);
   try

    // update ������� - ����� ���� ���������
//    l_DbOld.Start(m3_saRead, m3_saReadWrite);
//    try
//     l_DbOld.Update;
//    finally
//     l_DbOld.Finish;
//    end;

    // ������� �� ������� � �����
    l_DbOld.AllFiles.CopyTo(l_Db, False, m3_cmRewriteEmpty);

   finally
    l_DbOld := nil;
   end;
  finally
   l_Db.Finish;
  end;
 finally
  l_Db := nil;
 end;
end;

procedure TMainForm.Delta2Const;
var
 l_Db: Im4DB;
 I: Integer;
begin
 l_Db := Tm4DB.Make(StorageFile, 
                    False,
                    Yield,
                    FileMeter.ProgressProc_ev,
                    FilesMeter.ProgressProc_ev);
 try
  l_Db.Start(m3_saRead, m3_saReadWrite);
  try
   l_Db.Update;
  finally
   l_Db.Finish;
  end;
 finally
  l_Db := nil;
 end;
end;

function TMainForm.StorageFile: string;
begin
 Result := ConcatDirName(edBaseDir.Text, cFileName);
end;

end.
