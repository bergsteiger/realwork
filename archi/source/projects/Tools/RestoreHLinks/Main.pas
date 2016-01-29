unit Main;

{ $Id: Main.pas,v 1.12 2015/04/27 09:20:18 fireton Exp $ }

// $Log: Main.pas,v $
// Revision 1.12  2015/04/27 09:20:18  fireton
// - bugfix
//
// Revision 1.11  2005/05/27 14:44:39  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.10  2004/10/08 16:53:10  step
// уточнение расположения файлов
//
// Revision 1.9  2004/10/04 15:58:06  step
// добавлена возможность удаления из хранилища документов-фантомов
//
// Revision 1.8  2004/09/27 11:53:06  lulin
// - добавлены забытые inherited вызовы.
// - убраны лишние вызовы Clear.
//
// Revision 1.7  2004/09/27 11:31:24  step
// проект переписан
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  l3Base, OvcBase,  W95Meter, Mask, ToolEdit,
  HLinkRestorer, afwControlPrim, afwBaseControl, afwControl;

type
  TMainForm = class(TForm)
    bGo: TButton;
    FileMeter: TW95Meter;
    FilesMeter: TW95Meter;
    labInfo: TLabel;
    labStarted: TLabel;
    labFinished: TLabel;
    labFinishedTime: TLabel;
    labStartedTime: TLabel;
    labFoundHLink: TLabel;
    labFoundSub: TLabel;
    labFoundSubNum: TLabel;
    labFoundHLinkNum: TLabel;
    BadDocsDirEdit: TDirectoryEdit;
    Label1: TLabel;
    bDownload: TButton;
    procedure bGoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bDownloadClick(Sender: TObject);
  private
   f_HLinkRestorer: THLinkRestorer;
   procedure InitHLinkRestorer;
  public
   procedure Yield(aSender: TObject); overload;
   procedure Yield; overload;
   procedure ShowHlinksAmount(aAmount: Integer);
   procedure ShowSubsAmount(aAmount: Integer);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 l3FileUtils;

procedure TMainForm.bGoClick(Sender: TObject);
begin
 Screen.Cursor := crHourGlass;
 bGo.Enabled := False;
 bDownload.Enabled := False;
 BadDocsDirEdit.Enabled := False;
 try
  InitHLinkRestorer;
  f_HLinkRestorer.Execute;
 finally
  bGo.Enabled := True;
  bDownload.Enabled := True;
  BadDocsDirEdit.Enabled := True;
  Screen.Cursor := crDefault;
 end;
end;

procedure TMainForm.ShowHlinksAmount(aAmount: Integer);
begin
 labFoundHLinkNum.Caption := IntToStr(aAmount);
end;

procedure TMainForm.ShowSubsAmount(aAmount: Integer);
begin
 labFoundSubNum.Caption := IntToStr(aAmount);
end;

procedure TMainForm.Yield(aSender: TObject);
begin
 Application.ProcessMessages;
end;

procedure TMainForm.Yield;
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 l3Free(f_HLinkRestorer);
end;

procedure TMainForm.bDownloadClick(Sender: TObject);
begin
 Screen.Cursor := crHourGlass;
 bGo.Enabled := False;
 bDownload.Enabled := False;
 BadDocsDirEdit.Enabled := False;
 try
  InitHLinkRestorer;
  if f_HLinkRestorer.RemoveBadDocs(BadDocsDirEdit.Text) then
   MessageDlg('Документы-фантомы успешно слиты.', mtInformation, [mbOk], 0)
  else
   MessageDlg('Сбой при сливе документов-фантомов', mtError, [mbOk], 0);
 finally
  bGo.Enabled := True;
  bDownload.Enabled := True;
  BadDocsDirEdit.Enabled := True;
  Screen.Cursor := crDefault;
 end;
end;

procedure TMainForm.InitHLinkRestorer;
begin
 if f_HLinkRestorer = nil then
  f_HLinkRestorer := THLinkRestorer.Create(Self,
                                           ExtractFileDir(Application.ExeName));
end;

end.

