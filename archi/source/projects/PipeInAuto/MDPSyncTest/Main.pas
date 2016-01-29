unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TImportKind = (ikTop, ikNoTop);

  TForm2 = class(TForm)
    LoadBtn: TButton;
    UnloadBtn: TButton;
    Label1: TLabel;
    LoadEdit: TEdit;
    Button1: TButton;
    TypeGroup: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    CountEdit: TEdit;
    GetNFreeBtn: TButton;
    GetEdit: TEdit;
    Button3: TButton;
    UnloadCheck: TCheckBox;
    Label4: TLabel;
    TopDateEdit: TEdit;
    DefaultDateBtn: TButton;
    ProgressLabel: TLabel;
    LogMemo: TMemo;
    Label5: TLabel;
    NoTopDateEdit: TEdit;
    OneIterationBtn: TButton;
    Button2: TButton;
    procedure LoadBtnClick(Sender: TObject);
    procedure UnloadBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure GetNFreeBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DefaultDateBtnClick(Sender: TObject);
    procedure OneIterationBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function GetFromDate(anIndex: TImportKind): TDateTime;
    procedure SetFromDate(anIndex: TImportKind; const Value: TDateTime);
  private
    { Private declarations }
    f_DateArr: array [TImportKind] of TEdit;
    procedure SetProgress(aCurr, aTotal: Integer);
    function DoProcess(aKind: TImportKind; var aMaxCount: Integer): Integer;
    property FromDate[anIndex: TImportKind]: TDateTime read GetFromDate write SetFromDate;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
 ArchiAdapter,
 GardocsUnit,
 IOUnit,
 l3DateTimeBox,
 Math,
 ActiveX,
 l3Memory;

{$R *.dfm}

procedure TForm2.LoadBtnClick(Sender: TObject);
begin
  TArchiAdapterDll.Make;
end;

procedure TForm2.UnloadBtnClick(Sender: TObject);
begin
 try
  FreeAdapterSingleton;
 except
  on E: Exception do
   begin
    LogMemo.Lines.Add('UNLOAD FAILED!!!');
    raise;
   end;
 end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
 l_IDX: Integer;
begin
 for l_IDX := 1 to StrToInt(LoadEdit.Text) do
 begin
  LoadBtn.Click;
  UnloadBtn.Click;
  SetProgress(l_IDX, StrToInt(LoadEdit.Text));
 end;
 ProgressLabel.Caption := '';
 ShowMessage('Done');
end;

procedure TForm2.Button3Click(Sender: TObject);
var
 l_IDX: Integer;
begin
 for l_IDX := 1 to StrToInt(GetEdit.Text) do
 begin
  GetNFreeBtn.Click;
  SetProgress(l_IDX, StrToInt(GetEdit.Text));
 end;
 ProgressLabel.Caption := '';
 UnloadBtn.Click;
 ShowMessage('Done');
end;

procedure TForm2.GetNFreeBtnClick(Sender: TObject);
var
 l_Count: Integer;
const
 cMap: array [0..1] of TImportKind = (ikTop, ikNotop);
begin
 LogMemo.Lines.Clear;
 Application.ProcessMessages;
 l_Count := StrToInt(CountEdit.Text);
 DoProcess(cMap[TypeGroup.ItemIndex], l_Count);
 if UnloadCheck.Checked then
  UnloadBtn.Click;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 f_DateArr[ikTop] := TopDateEdit;
 f_DateArr[ikNoTop] := NoTopDateEdit;
 DefaultDateBtn.Click;
end;

procedure TForm2.DefaultDateBtnClick(Sender: TObject);
begin
 FromDate[ikTop] := Now - 1;
 FromDate[ikNoTop] := FromDate[ikTop];
end;

procedure TForm2.SetProgress(aCurr, aTotal: Integer);
begin
 ProgressLabel.Caption := Format('%d/%d', [aCurr, aTotal]);
 ProgressLabel.Update;
end;

function TForm2.GetFromDate(anIndex: TImportKind): TDateTime;
begin
 Result := StrToDateTime(f_DateArr[anIndex].Text)
end;

procedure TForm2.SetFromDate(anIndex: TImportKind; const Value: TDateTime);
begin
 f_DateArr[anIndex].Text := FormatDateTime('dd/mm/yyyy hh:nn:ss', Value);
end;

function TForm2.DoProcess(aKind: TImportKind; var aMaxCount: Integer): Integer;
var
 l_DLL: IArchiAdapterDll;
 l_Searcher: ISearcher2;
 l_Date: TDateTimeBox;
 l_List: IGardocList;
 l_IDX: Integer;
 l_NewDate: TDateTime;
 l_TickCount: Integer;
 l_Doc: TGardoc;
 l_ImgIdx: Integer;
 l_Image: TImage;
 l_TotalSize: Int64;
 l_CurrSize: Int64;
 l_Stream: Tl3MemoryStream;
 l_Dummy: Int64;
 l_Str: String;
const
 cMap: array [TImportKind] of String = ('Top', 'Notop');
begin
 Result := 0;
 if aMaxCount <= 0 then
  Exit;
 l_DLL := TArchiAdapterDll.Make;
 try
  l_Searcher := l_DLL.GetSearcher2;
  try
   l3DateTimeToBox(FromDate[aKind], l_Date);
   LogMemo.Lines.Add(Format('Receiving %s from %s ', [cMap[aKind], FormatDateTime('dd/mm/yyyy hh:nn:ss', FromDate[aKind])]));

   l_TickCount := GetTickCount;
   case aKind of
    ikTop: l_Searcher.GetTopCreatedSince(l_Date, aMaxCount, '0', l_List);
    ikNoTop: l_Searcher.GetNotopCreatedSince(l_Date, aMaxCount, '0', l_List);
   end;
   try
    if (l_List <> nil) and (l_List.Count > 0) then
    begin
     LogMemo.Lines.Add(Format('Received %d docs in %s msec', [l_List.Count, FormatFLoat('#,##0', GetTickCount - l_TickCount)]));
     l_NewDate := 0;
     aMaxCount := aMaxCount - l_List.Count;
     Result := l_List.Count;
     for l_IDX := 0 to l_List.Count - 1 do
     begin
      l_List.pm_GetItem(l_IDX, l_Doc);
      try
       l_Str := l_Doc.rTitle.GetData;
       if (l_Doc.rImages <> nil) and (l_Doc.rImages.Count > 0 ) then
       begin
        l_TotalSize := 0;
        for l_ImgIdx := 0 to l_Doc.rImages.Count - 1 do
        begin
         l_Doc.rImages.pm_GetItem(l_ImgIdx, l_Image);
         try
          if l_Image.rData <> nil then
          begin
           l_Stream := Tl3MemoryStream.Make;
           try
            l_Image.rData.CopyTo(l_STream, MaxInt, l_CurrSize, l_Dummy);
           finally
            FreeAndNil(l_Stream);
           end;
           l_TotalSize := l_TotalSize + l_CurrSize;
          end;
         finally
          Finalize(l_Image);
         end;
        end;
        LogMemo.Lines.Add(Format('  ImagesCount: %d, Total Size: %s kb', [l_Doc.rImages.Count, FormatFloat('#,##0', l_TotalSize / 1024)]));
       end;
       l_NewDate := Max(l_NewDate, l3BoxToDateTime(l_Doc.rTimestamp));
      finally
       Finalize(l_Doc);
      end;
     end;
     LogMemo.Lines.Add(Format('New time is %s', [FormatDateTime('dd/mm/yyyy hh:nn:ss', l_NewDate)]));
     FromDate[aKind] := l_NewDate;
    end
    else
     LogMemo.Lines.Add('There isn''t any documents');
   finally
    l_List := nil;
   end;
  finally
   l_Searcher := nil;
  end;
 finally
  l_DLL := nil;
 end;
end;

procedure TForm2.OneIterationBtnClick(Sender: TObject);
var
 l_Count: Integer;
begin
 LogMemo.Lines.Clear;
 Application.ProcessMessages;
 l_Count := StrToInt(CountEdit.Text);
 DoProcess(ikTop, l_Count);
 DoProcess(ikNoTop, l_Count);
 if UnloadCheck.Checked then
  UnloadBtn.Click;
 ShowMessage('Done');
end;

procedure TForm2.Button2Click(Sender: TObject);
var
 l_Count: Integer;
 l_LoadedCount: Integer;
begin
 LogMemo.Lines.Clear;
 Application.ProcessMessages;
 repeat
  l_Count := StrToInt(CountEdit.Text);
  l_LoadedCount := DoProcess(ikTop, l_Count);
  l_LoadedCount := l_LoadedCount + DoProcess(ikNoTop, l_Count);
  if UnloadCheck.Checked then
   UnloadBtn.Click;
  Application.ProcessMessages;
 until l_LoadedCount = 0;
 UnloadBtn.Click;
 ShowMessage('Done');
end;

end.
