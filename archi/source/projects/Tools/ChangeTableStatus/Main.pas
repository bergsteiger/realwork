unit Main;

{ $Id: Main.pas,v 1.4 2012/02/29 10:15:47 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.4  2012/02/29 10:15:47  lulin
// CheckFiler
//
// Revision 1.3  2010/07/16 07:30:52  dinishev
// [$226005005]. Интерфейсные правки.
//
// Revision 1.2  2010/07/15 13:28:46  dinishev
// [$226005005]
//
// Revision 1.1  2010/07/15 13:07:39  dinishev
// [$226005005]
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m3DBInterfaces, Mask, 
  afwControlPrim, afwBaseControl, afwControl, XPMan, ComCtrls, m3StorageInterfaces,
  ToolEdit;

type
  TMainForm = class(TForm)
    btWork: TButton;
    btStop: TButton;
    edBaseDir: TDirectoryEdit;
    pnStatus: TPanel;
    lbPercent: TLabel;
    Label1: TLabel;
    edTopicListFN: TFilenameEdit;
    lblTopicListFN: TLabel;
    XPManifest1: TXPManifest;
    Progress: TProgressBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btWorkClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
    f_Start     : TDateTime;
    function  pm_GetBaseDir: string;
    procedure pm_SetBaseDir(const aValue: string);
      {-}
    procedure DoBeforeIndexLoad(aSender: TObject);
      {-}
    procedure DoBeforeSort(aSender: TObject);
    procedure TotalProgress(aState : Byte; aValue : Long; const aMsg : string = '');
      {-}
    procedure Yield(aSender: TObject);
      {-}
    procedure WorkWithBase;
      {-}
    procedure ItarateBaseByList;
      {* - Поиск в базе соответсвующих документов и правка таблиц в них. }
    function GetList: Im3StorageElementIDList;
      {* - Возвращает список для поиска документов в базе. }
  public
    { Public declarations }
    property BaseDir: string
      read pm_GetBaseDir
      write pm_SetBaseDir;
      {-}
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  l3Math,
  l3Base,
  l3FileUtils,
  l3Parser,
  l3Stream,
  l3Memory,

  k2TagGen,

  m3DB,
  m3StorageElementIDList,

  evOEMTableFlagFilter,

  ddUtils;



function LoadDocNumbers(const aFileName: string): Im3StorageElementIDList;
var
 lStream    : Tl3FileStream;
 lTmpStream : Tl3MemoryStream;
 l_Parser   : Tl3Parser;
 l_CurNum   : Integer;
begin
 Result := nil;
 if FileExists(aFileName) then
 begin
  lStream := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   l_Parser := Tl3Parser.Create(nil);
   try
    l_Parser.CheckFloat := False;
    l_Parser.CheckFiler.Stream := lStream;
    l_Parser.NextTokenSp;
    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      if Result = nil then
       Result := Tm3StorageElementIDList.MakeI;
      try
       l_CurNum := l_Parser.TokenInt;
       Result.Add(l_CurNum);
      except
      end;
     end;
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   l3Free(lStream);
  end;
 end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 SaveSettings(Self);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 LoadSettings(Self);
end;

procedure TMainForm.btWorkClick(Sender: TObject);
begin
 f_Stopped := False;
 f_InProcess := True;
 btWork.Enabled := False;
 btStop.Enabled := True;
 try
  try
   l3System.Msg2Log('Начало обработки');
   WorkWithBase;
   if f_Stopped then
    l3System.Msg2Log('Обработка прервана пользователем')
   else
    l3System.Msg2Log('Обработка завершена');
  finally
   f_InProcess := False;
  end;//try..finally
 finally
  btWork.Enabled := True;
  btStop.Enabled := False;
 end;//try..finally
 pnStatus.Caption  := '';
 lbPercent.Caption := '';
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := True;
 if (f_DB <> nil) then
  f_DB.Stop;
end;

function TMainForm.pm_GetBaseDir: string;
  {-}
begin
 Result := edBaseDir.Text;
end;

procedure TMainForm.pm_SetBaseDir(const aValue: string);
  {-}
begin
 edBaseDir.Text := aValue;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f_InProcess then
 begin
  if (MessageDlg('Вы хотите прервать обработку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
   f_NeedClose := True;
   f_Stopped := True;
   if (f_DB <> nil) then
    f_DB.Stop;
  end; // if (MessageDlg('Вы хотите прервать обработку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  CanClose := False;
 end;//f_InProcess
end;

procedure TMainForm.DoBeforeIndexLoad(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Идёт расстановка разделов';
end;

procedure TMainForm.DoBeforeSort(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Расстановка разделов завершена';
end;

procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

procedure TMainForm.TotalProgress(aState: Byte; aValue: Long; const aMsg: string = '');
begin
 case aState of
  0:
   begin
    Progress.Max := aValue;
    Progress.Position := 0;
    lbPercent.Caption := Format('Приступаем к обработке %d документов', [aValue]);
   end;
  1:
   begin
    Progress.Position := aValue;
    if l3MulDiv(Progress.Position, 100, Progress.Max) > 0 then
     lbPercent.Caption := Format('Обработано %d документов из %d, до окончания осталось %s',
       [Progress.Position, Progress.Max, CalcLeftTime(Progress.Max, Progress.Position, f_Start, Now)])
    else
     lbPercent.Caption := Format('Обработано %d документов из %d',  [Progress.Position, Progress.Max]);
   end;
  2:
   begin
    Progress.Position := Progress.Max;
    lbPercent.Caption := 'Обработка завершена';
   end;
 end; // case aState of
end;

procedure TMainForm.WorkWithBase;
var
 l_Name : string;
begin
 l_Name := ConcatDirName(BaseDir, 'bserv001');
 f_DB := Tm3DB.Make(l_Name,
                    Yield,
                    nil,
                    TotalProgress);
 try
  ItarateBaseByList;
 finally
  f_DB := nil;
 end;//try..finally
 MessageDlg('Обработка завершена!', mtInformation, [mbOK], 0);
end;

procedure TMainForm.ItarateBaseByList;
var
 l_List   : Im3StorageElementIDList;
 l_Range  : Im3DBRange;
 l_Filter : Tk2TagGenerator;
begin
 l_List := GetList;
 if l_List = nil then
 begin
  MessageDlg('Не удалось получить список топиков из файла!', mtError, [mbOK], 0);
  Exit;
 end; // if Result = nil then
 l_Filter := nil;
 TevOEMTableFlagFilter.SetTo(l_Filter);
 try
  pnStatus.Caption := 'Выставление флага.';
  l_Range := f_DB.FilesInList(l_List);
  f_Start := Now;
  l_Range.Iterate(l_Filter, True, [m3_dsMain]);
 finally
  FreeAndNil(l_Filter);
 end;
end;

function TMainForm.GetList: Im3StorageElementIDList;
begin
 Result := nil;
 if f_Stopped then Exit;
 Result := LoadDocNumbers(edTopicListFN.FileName);
end;

end.
