unit IndexForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OvcBase, W95Meter, ComCtrls, alcuShowMessage;

type
  TArchiIndexForm = class(TForm)
    cbBuildDocumentIndex: TCheckBox;
    cbBuildHeaderIndex: TCheckBox;
    lblProgressDescript: TLabel;
    btnStart: TButton;
    pbProcess: TProgressBar;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    f_CurPath: String;
    { Private declarations }
   procedure TotalProc(aState: Byte; aValue: Longint; const aMsg: string);
  public
    { Public declarations }
  end;

var
  ArchiIndexForm: TArchiIndexForm;

implementation

Uses
 dt_IndexSupport, l3IniFile,
 l3FileUtils, m4DB, m4DBInterfaces, m3StorageInterfaces,
 dt_Serv, dt_Dict, dt_Types,
 ddHTInit, DT_Const;

{$R *.dfm}

function LCIDToCodePage(ALcid: LongWord): Integer;
const
  CP_ACP = 0;                                // system default code page
  LOCALE_IDEFAULTANSICODEPAGE = $00001004;   // default ansi code page
var
  ResultCode: Integer;
  Buffer: array [0..6] of Char;
begin
  GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, SizeOf(Buffer));
  Val(Buffer, Result, ResultCode);
  if ResultCode <> 0 then
    Result := CP_ACP;
end;



procedure TArchiIndexForm.btnStartClick(Sender: TObject);
  procedure DoIndex;
  var
   l_UpdateBase: Boolean;
   f_DB: Im4DB;
   l_EraseSAV: Boolean;
  begin
    f_DB:= Tm4DB.Make(ConcatDirName(f_CurPath, 'bserv001'), nil, nil, TotalProc);
    try
     f_DB.Start(m3_saReadWrite);
     try
       //f_DB.UpdateIndex;
       f_DB.BuildIndex();
       l_EraseSAV:= f_DB.Update;
       if l_EraseSAV then
        f_DB.Purge;
     finally
      f_DB.Finish;
     end;
    finally
     f_DB:= nil;
    end;
  end;

begin
 btnStart.Enabled:= False;
 try
  // тексты документов
  if cbBuildDocumentIndex.Checked then
   DoIndex;
  // заголовки документов
  if cbBuildHeaderIndex.Checked then
   BuildTextIndexbyHeader(1, TotalProc);
  // ”даление резервных копий
  if FileExists(ConcatDirName(f_CurPath, 'bserv001.sav')) then
   DeleteFile(ConcatDirName(f_CurPath, 'bserv001.sav'));
  if FileExists(ConcatDirName(f_CurPath, 'bserv001.bkp')) then
   DeleteFile(ConcatDirName(f_CurPath, 'bserv001.bkp'));
 finally
  pbProcess.Position:= 0;
  ShowMsg('»ндексаци€ и обновление завершены');
  btnStart.Enabled:= True;
 end;
end;

procedure TArchiIndexForm.FormCreate(Sender: TObject);
var
 CurAttrib : LongInt;
begin
 if InitBaseEngine then
 begin
  f_CurPath:= ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily));
  if LCIDToCodePage(GetThreadLocale) <> 1251 then
   alcuMsgDialog(' одова€ страница системы установлена неправильно. '+
              'Ёто повли€ет на построение индекса',
              mtWarning, [mbOk], 0);

 end
 else
 begin
  alcuMsgDialog('ќшибка подключени€ к базе данных. ѕриложение будет закрыто',
             mtError, [mbOk], 0);
  Application.Terminate;
 end;
end;


procedure TArchiIndexForm.TotalProc(aState: Byte; aValue: Longint; const aMsg: string);
begin
 with pbProcess do
 begin
  case aState of
   0: begin
       if aValue > 0 then
        Max:= aValue
       else
        Max:= 0;
       Position:= 0;
       lblProgressDescript.Caption:= aMsg;
      end;
   1: Position:= aValue;
   2: begin
       Position:= Max;
       lblProgressDescript.Caption:= '';
      end;
  end;
 end;
 Application.ProcessMessages;
end;


procedure TArchiIndexForm.FormDestroy(Sender: TObject);
begin
 DoneClientBaseEngine(True);
end;


end.
