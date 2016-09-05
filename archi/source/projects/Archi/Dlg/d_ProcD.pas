unit D_ProcD;

{ $Id: d_ProcD.pas,v 1.26 2016/08/24 07:39:25 lukyanets Exp $ }

interface

{$Include l3XE.inc}

uses SysUtils, WinTypes, WinProcs,
     Classes, Graphics, Forms, Dialogs, vtDialogs,
     Controls, Buttons,
     StdCtrls, ExtCtrls,
     l3Types, l3Base,
     daTypes,
     DocIntf, W95Meter, OvcBase, afwControl, afwControlPrim, afwBaseControl, arInterfaces;

type
  TGetDocFunc = function(var aDocID : TdaGlobalCoordinateRec) : Boolean;

  TDocListProcessor = class(Tl3Base)
  protected
   fStop           : Boolean;
  public
   procedure PrintF(aGetDocFunc : TGetDocFunc);
   procedure SaveToEVD;
   procedure GetStatistic;
   procedure Stop;
  end;


  TDocActions = (daPrint, daSaveToEVD, daShowStat);

  TProcessDocList = class(TForm)
    pbList    : TW95Meter;
    Panel1    : TPanel;
    btnCancel : TBitBtn;

    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
   private
    fStop               : Boolean;   
    fDocsList           : TDocsList;
    fInProcess          : Boolean;
    fProcessor          : TDocListProcessor;
    f_SumCharCount      : Integer;
    f_SumCellCount      : Integer;
    f_SumTableCharCount : Integer;
    procedure SetDocsList(Value : TDocsList);
    function  GetProcessor : TDocListProcessor;
//    procedure SetProcessor(aProcessor : TDocListProcessor);
    procedure GetDocListInformation(const anInfoOut: IInfoOut);
   public
    procedure ExecutePrint;
    procedure ExecuteSaveToEVD;
    procedure ExecuteShowStatistic;
    procedure Stop;
    procedure Execute(aActions : TDocActions);
    property  DocsList : TDocsList read fDocsList write SetDocsList;
    property  Processor : TDocListProcessor read GetProcessor {write SetProcessor};
   end;


procedure ProcessDocs(aDocsList : TDocsList; aActions : TDocActions);

implementation

{$R *.DFM}

 Uses
  l3FileUtils, FileCtrl,
  StrShop,
  Main,

  D_ShowInfo;


 {TDocListProcessor}

procedure TDocListProcessor.PrintF(aGetDocFunc : TGetDocFunc);
var
 lDocID : TdaGlobalCoordinateRec;
 lCnt   : Integer;
 lDocIntf : TarDocument;
begin
 fStop := False;
 lCnt := 0;
 lDocIntf := TarDocument.Create;
 try
  try
   while aGetDocFunc(lDocID) do
   begin
    if fStop then Break;
    With lDocIntf do
    begin
     DocFamily := lDocID.Family;
     DocID     := lDocID.Doc;
     try
      TextSource.PrintText;
      if Spravka <> nil then
       Spravka.TextSource.PrintText;
     except
     end;
    end;
   end;
  finally
   l3FreeFA(Tl3FreeAction(aGetDocFunc));
  end;
 finally
  l3Free(lDocIntf);
 end;

end;

procedure TDocListProcessor.SaveToEVD;
begin
end;

procedure TDocListProcessor.GetStatistic;
begin
end;

procedure TDocListProcessor.Stop;
begin
 fStop := True;
end;

{TProcessDocList}
procedure TProcessDocList.FormDestroy(Sender: TObject);
begin
 l3Free(fProcessor);
 DocsList := nil;
end;

function TProcessDocList.GetProcessor : TDocListProcessor;
begin
 if fProcessor = nil then
  fProcessor := TDocListProcessor.Create;

 Result := fProcessor;
end;

(*procedure TProcessDocList.SetProcessor(aProcessor : TDocListProcessor);
begin
//
end;*)

procedure TProcessDocList.SetDocsList(Value : TDocsList);
begin
 if fDocsList = Value then Exit;
 l3Free(fDocsList);
 pbList.Percent := 0;

 if Value <> nil then
 begin
  fDocsList := Value.Use;
  pbList.MaxNumber := fDocsList.Count;
 end;
end;

procedure TProcessDocList.FormResize(Sender: TObject);
begin
 pbList.Width := Width - 110;
 {pbDoc.Width  := Width - 110;}
end;

procedure TProcessDocList.Stop;
begin
 if fInProcess then
 begin
  fStop := True;
  Processor.Stop;
 end;
end;

procedure TProcessDocList.btnCancelClick(Sender: TObject);
begin
 Stop;
end;

procedure TProcessDocList.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose := Not fInProcess;
 if fInProcess and
    (vtMessageDlg(l3CStr('Процесс "' + Caption + '" не завершен. Прервать?'),
                mtWarning, [mbYes, mbNo], 0) = mrYes) then Stop;
end;

procedure TProcessDocList.Execute(aActions : TDocActions);
begin
 if fDocsList.Count = 0 then Exit;
 fInProcess := True;
 try
  Case aActions of
   daPrint     : ExecutePrint;
   daSaveToEVD : ExecuteSaveToEVD;
   daShowStat  : ExecuteShowStatistic;
  end;
 finally
  fInProcess := false;
  pbList.Percent := 0;
 end;
end;

procedure TProcessDocList.ExecuteShowStatistic;
var
 I               : Longint;
 lDocIntf        : TarDocument;
 lDocAddr        : TDocAddr;
 lCharCount      : Longint;
 lCellCount      : Longint; 
 lTableCharCount : Longint;
begin
 lDocIntf := TarDocument.Create;
 Try
  f_SumCharCount      := 0;
  f_SumTableCharCount := 0;
  f_SumCellCount      := 0;
  For I := 0 to Pred(fDocsList.Count) do
   begin
    if fStop then Break;
    Caption := Format('Подсчет размера документов %d из %d',[Succ(I), fDocsList.Count]);
    Try
     lDocAddr := fDocsList.DocAddr[I];
     With lDocIntf do
      begin
       DocFamily := lDocAddr.FamID;
       DocID := lDocAddr.DocID;
       Try
        Application.ProcessMessages;
        GetDocStatistic(lCharCount, lTableCharCount, lCellCount);

        Inc(f_SumCharCount,      lCharCount);
        Inc(f_SumTableCharCount, lTableCharCount);
        Inc(f_SumCellCount,      lCellCount);
       except
       end;
      end;
    finally
     pbList.CurNumber := I;
    end;
   end;
  ShowInfoDialog('Объем документов в выборке', 0, GetDocListInformation);
 finally
  l3Free(lDocIntf);
 end;
end;


(*
procedure TProcessDocList.ExecutePrint;
var
 I        : Longint;
 lDocIntf : TarDocument;
 lDocAddr : TDocAddr;
begin
 lDocIntf := TarDocument.Create;
 Try
  For I := 0 to Pred(fDocsList.Count) do
   begin
    If fStop then Break;
    Caption := Format('ПЕЧАТЬ %d из %d',[Succ(I), fDocsList.Count]);
    Try
     lDocAddr := fDocsList.DocAddr[I];
     With lDocIntf do
      begin
       DocFamily := lDocAddr.FamID;
       DocID     := lDocAddr.DocID;
       Try
        Application.ProcessMessages;
        PrintText;
        if Spravka <> nil then
         Spravka.PrintText;
       except
       end;
      end;
    finally
     pbList.CurNumber := I;
    end;
   end;
 finally
  l3Free(lDocIntf);
 end;
end;
*)

procedure TProcessDocList.ExecutePrint;
 var
  lCurrent : Integer;

 function lGetDocFunc(var aDocID : TdaGlobalCoordinateRec) : Boolean;
 begin
  Result := lCurrent < fDocsList.Count;
  if Result then
   with fDocsList.DocAddr[lCurrent] do
   begin
    aDocID.Family := FamID;
    aDocID.Doc    := DocID;
   end;
  Caption := Format('ПЕЧАТЬ %d из %d',[Succ(lCurrent), fDocsList.Count]);
  Inc(lCurrent);
  pbList.CurNumber := lCurrent;
  Application.ProcessMessages;
  //Inc(lCurrent);
 end;

begin
 lCurrent := 0;
 Processor.PrintF(TGetDocFunc(l3LocalStub(@lGetDocFunc)));
end;

procedure TProcessDocList.ExecuteSaveToEVD;
var
 I        : Longint;
 lDocIntf : TarDocument;
 lDocAddr : TDocAddr;
 lFileName : AnsiString;
 {$ifDef XE}
 l_S : String;
 {$endif XE}
 IsDir    : Boolean;

function MakeFullName(aFileName : TFileName) : TFileName;
begin
 if IsDir then
  Result := ConcatDirName(aFileName,IntToStr(lDocAddr.DocID)+'.evd')
 else
  Result := ChangeFileExt(aFileName, '.evd');
end;

begin
 lDocIntf := TarDocument.Create;
 try
  IsDir := fDocsList.Count > 1;
  if IsDir then
  begin
   {$ifDef XE}
   l_S := lFileName;
   if not SelectDirectory(l_S, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then Exit;
   lFileName := l_S;
   {$Else  XE}
   if not SelectDirectory(lFileName, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then Exit;
   {$Endif XE}
  end
  else
   if not vtExecuteSaveDialog(lFileName, sidEvdDlgFilter) then Exit;

  for I := 0 to Pred(fDocsList.Count) do
  begin
   if fStop then Break;
   Caption := Format('ЗАПИСЬ НА ДИСК %d из %d',[Succ(I), fDocsList.Count]);
   try
    lDocAddr := fDocsList.DocAddr[I];
    With lDocIntf do
    begin
     DocFamily := lDocAddr.FamID;
     DocID     := lDocAddr.DocID;
     try
      Application.ProcessMessages;
      TextSource.SaveToEVD(MakeFullName(lFileName));
     except
     end;
    end;
   finally
    pbList.CurNumber := I;
   end;
  end;
 finally
  l3Free(lDocIntf);
 end;
end;

{-}
procedure ProcessDocs(aDocsList : TDocsList; aActions : TDocActions);
begin
 With TProcessDocList.Create(Application.MainForm) do
  try
   DocsList := aDocsList;
   Execute(aActions);
  finally
   Free;
  end;
end;

procedure TProcessDocList.GetDocListInformation(const anInfoOut: IInfoOut);
begin
 with anInfoOut do
 begin
  StartData;
  AddString(Format('Количество документов : %d'#13#10,[fDocsList.Count]));
  AddString(#13#10);
  AddString(Format('Всего символов        : %d'#13#10,[f_SumCharCount + f_SumTableCharCount]));
  AddString(Format('из них в таблице      : %d'#13#10,[f_SumTableCharCount]));
  AddString(Format('Ячеек                 : %d'#13#10,[f_SumCellCount]));
  EndData;
 end;
end;

end.
