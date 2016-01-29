unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LibPQ, Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    ConnectBtn: TButton;
    DisconnectBtn: TButton;
    OpenBtn: TButton;
    CloseBtn: TButton;
    FetchOne: TButton;
    CommitBtn: TButton;
    LastBtn: TButton;
    FirstBtn: TButton;
    Open2Btn: TButton;
    Fetch2Btn: TButton;
    Last2Btn: TButton;
    First2Btn: TButton;
    Close2Btn: TButton;
    Button3: TButton;
    HandredLast: TButton;
    StressOpen: TButton;
    TerminateCheck: TCheckBox;
    SpinEdit1: TSpinEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure DisconnectBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FetchOneClick(Sender: TObject);
    procedure CommitBtnClick(Sender: TObject);
    procedure LastBtnClick(Sender: TObject);
    procedure FirstBtnClick(Sender: TObject);
    procedure Open2BtnClick(Sender: TObject);
    procedure Fetch2BtnClick(Sender: TObject);
    procedure Last2BtnClick(Sender: TObject);
    procedure First2BtnClick(Sender: TObject);
    procedure Close2BtnClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure HandredLastClick(Sender: TObject);
    procedure StressOpenClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    f_Conn: PPGconn;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
//  LibPQ,
  l3StopWatch;

const
// cLogin =   'postgresql://postgres:admin@cooker3:5432\postgres';
// cLogin =   'postgresql://postgres:admin@cooker3:5432\postgres?client_encoding=WIN1251';
 cLogin =   'postgresql://postgres:admin@cooker3:5432/archi?client_encoding=WIN1251';

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  l_Conn: PPGconn;
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_Watch: Tl3StopWatch;
begin
  l_Watch.Reset;
  l_Conn := PQconnectdb(cLogin);
  try
    if PQstatus(l_Conn) <> CONNECTION_OK then
    begin
     Memo1.Lines.Add(PQerrorMessage(l_Conn));
     raise Exception.Create(PQerrorMessage(l_Conn));
    end
    else
     Memo1.Lines.Add('OK!');
//    if PQsendQuery(l_Conn, 'select * from pg_attribute;') = 0 then
    if PQsendQuery(l_Conn, 'select * from archi.file order by 1;') = 0 then
     raise Exception.Create(PQerrorMessage(l_Conn));
    if CheckBox1.Checked then
      PQsetSingleRowMode(l_Conn);
    if PQconsumeInput(l_Conn) = 0 then
     Exception.Create(PQerrorMessage(l_Conn));
    repeat
      l_Watch.Start;
      l_Result := PQgetResult(l_Conn);
      l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
      if l_Msg <> '' then
       Memo1.Lines.Add(l_Msg)
      else
      begin
//       Memo1.Lines.Add(Format('DataReceived %d records, %d fields time - %s ms', [PQntuples(l_Result), PQnfields(l_Result), FormatFloat('#,##0.00', l_Watch.Time * 1000)]));
//       l_Str := '';
//       for l_IDX := 0 to PQnfields(l_Result) - 1 do
//         l_Str := l_Str + ' ' + PQfname(l_Result, l_IDX);
//       Memo1.Lines.Add(l_Str);
       for l_IDX := 0 to PQntuples(l_Result) - 1 do
         l_Str := PQgetvalue(l_Result, l_IDX, 0);
//         Memo1.Lines.Add(PQgetvalue(l_Result, l_IDX, 0));
      end;
      l_Watch.Stop(PQntuples(l_Result));
      if l_Result = nil then
       Break;
      PQclear(l_Result);
    until False;
    if CheckBox1.Checked then
     Memo1.Lines.Add('SingleRow')
    else
     Memo1.Lines.Add('FullPack');
    Memo1.Lines.Add(Format('Total %s PerSec %s Avg %s', [FormatFloat('#,##0.00', l_Watch.Time * 1000), FormatFloat('#,##0.00', l_Watch.OpsPerSec), FormatFloat('#,##0.00', l_Watch.AvgTime * 1000000)]));
  finally
    PQfinish(l_Conn);
  end;
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  l_Conn: PPGconn;
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: AnsiString;
  l_IDX: Integer;
  l_Params: TPQparamValues;
  l_Dummy: TPQparamFormats;
const
 cCnt = 100000;

begin
  l_Conn := PQconnectdb(cLogin);
  try
    if PQstatus(l_Conn) <> CONNECTION_OK then
     Memo1.Lines.Add(PQerrorMessage(l_Conn))
    else
     Memo1.Lines.Add('OK!');

    l_Result := PQexec(l_Conn, 'begin transaction;');
    Memo1.Lines.Add('begin transaction');
    l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
    if l_Msg <> '' then
     Memo1.Lines.Add(l_Msg);
    PQclear(l_Result);

    SetLength(l_Params, 1);
    SetLength(l_Dummy, 1);
    try
     for l_IDX := 1 to cCnt do
     begin
      l_Str := IntToStr(l_IDX * 10);
      l_Params[0] := @l_Str[1];
      l_Dummy[0] := 0;

      l_Result := PQexecParams(l_Conn, 'insert into test.test_tbl (key) values ($1);', 1, nil, l_Params, nil, nil, 0);
      try
        l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
        if l_Msg <> '' then
        begin
         Memo1.Lines.Add(l_Msg);
         raise Exception.Create(l_Msg);
        end;
      finally
       PQclear(l_Result);
      end;

      Label1.Caption := Format('%s%%', [FormatFloat('0.00', l_IDX / cCnt * 100)]);
      Label1.Update;
     end;

     l_Result := PQexec(l_Conn, 'commit;');
     Memo1.Lines.Add('commit');
     l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
     if l_Msg <> '' then
      Memo1.Lines.Add(l_Msg);
     PQclear(l_Result);

    except
     l_Result := PQexec(l_Conn, 'rollback;');
     Memo1.Lines.Add('rollback');
     l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
     if l_Msg <> '' then
      Memo1.Lines.Add(l_Msg);
     PQclear(l_Result);
    end;

  finally
    PQfinish(l_Conn);
  end;
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.ConnectBtnClick(Sender: TObject);
var
  l_Result: PPGResult;
begin
  f_Conn := PQconnectdb(cLogin);
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end
  else
   Memo1.Lines.Add('OK!');

(*  l_Result := PQExec(f_COnn, 'begin');
  try
   if PQresultStatus(l_Result) <> PGRES_COMMAND_OK then
     raise Exception.CreateFmt('Begin failed: ', [PQerrorMessage(f_conn)]);
  finally
   PQClear(l_Result);
  end;*)
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.DisconnectBtnClick(Sender: TObject);
var
  l_Result: PPGResult;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

(*  l_Result := PQExec(f_COnn, 'end');
  try
   if PQresultStatus(l_Result) <> PGRES_COMMAND_OK then
     raise Exception.CreateFmt('end failed: ', [PQerrorMessage(f_conn)]);
  finally
   PQClear(l_Result);
  end;*)

  PQfinish(f_Conn);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.OpenBtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_Watch: Tl3StopWatch;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Watch.Reset;
  l_Watch.Start;
  l_Result := PQExec(f_Conn, 'declare xx cursor with hold for select * from archi.file');
  l_Watch.Stop;
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('cmdTuples %s records, %s ms', [PQcmdTuples(l_Result), FormatFloat('#,###.##', l_Watch.Time * 1000)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.CloseBtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end
  else
   Memo1.Lines.Add('OK!');
  l_Result := PQExec(f_Conn, 'close xx');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.FetchOneClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Result := PQExec(f_Conn, 'fetch 5 from xx');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.CommitBtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Result := PQExec(f_Conn, 'commit');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.LastBtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_Watch: Tl3StopWatch;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Watch.Reset;
  l_Watch.Start;
  l_Result := PQExec(f_Conn, 'move 2000000000 xx');
  l_Watch.Stop;
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('cmdTuples %s records, %s ms', [PQcmdTuples(l_Result), FormatFloat('#,###.##', l_Watch.Time * 1000)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.FirstBtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Result := PQExec(f_Conn, 'move absolute 0 xx');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('cmdTuples %s records', [PQcmdTuples(l_Result)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.Open2BtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_Params: TPQparamValues;
  l_Dummy: TPQparamFormats;
  l_Watch: Tl3StopWatch;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

    SetLength(l_Params, 1);
    SetLength(l_Dummy, 1);
    l_Str := IntToStr(104);
    l_Params[0] := @l_Str[1];
    l_Dummy[0] := 0;



//      l_Result := PQexecParams(f_Conn, 'declare xxx cursor with hold for select * from test.test_tbl where key = $1 order by 1', 1, nil, l_Params, nil, nil, 0);

  l_Watch.Reset;
  l_Watch.Start;
  l_Result := PQExec(f_Conn, 'declare xxx cursor with hold for select * from archi.hlink order by 1');
  l_Watch.Stop;
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('cmdTuples %s records, %s ms', [PQcmdTuples(l_Result), FormatFloat('#,###.##', l_Watch.Time * 1000)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.Fetch2BtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Result := PQExec(f_Conn, 'fetch 5 from xxx');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.Last2BtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_Watch: Tl3StopWatch;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Watch.Reset;
  l_Watch.Start;
  l_Result := PQExec(f_Conn, 'move 2000000000 xxx');
  l_Watch.Stop;
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('cmdTuples %s records, %s ms', [PQcmdTuples(l_Result), FormatFloat('#,###.##', l_Watch.Time * 1000)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.First2BtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Result := PQExec(f_Conn, 'move absolute 0 xxx');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('cmdTuples %s records', [PQcmdTuples(l_Result)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.Close2BtnClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end
  else
   Memo1.Lines.Add('OK!');
  l_Result := PQExec(f_Conn, 'close xxx');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  l_Conn: PPGconn;
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: AnsiString;
  l_Params: TPQparamValues;
  l_Dummy: TPQparamFormats;
begin
  l_Conn := PQconnectdb(cLogin);
  try
    if PQstatus(l_Conn) <> CONNECTION_OK then
     Memo1.Lines.Add(PQerrorMessage(l_Conn))
    else
     Memo1.Lines.Add('OK!');

    l_Result := PQexec(l_Conn, 'begin transaction;');
    Memo1.Lines.Add('begin transaction');
    l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
    if l_Msg <> '' then
     Memo1.Lines.Add(l_Msg);
    PQclear(l_Result);

    SetLength(l_Params, 1);
    SetLength(l_Dummy, 1);
    try
      l_Str := IntToStr(104);
      l_Params[0] := @l_Str[1];
      l_Dummy[0] := 0;

      l_Result := PQexecParams(l_Conn, 'insert into test.test_tbl (key) values ($1);', 1, nil, l_Params, nil, nil, 0);
      try
        l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
        if l_Msg <> '' then
        begin
         Memo1.Lines.Add(l_Msg);
         raise Exception.Create(l_Msg);
        end;
      finally
       PQclear(l_Result);
      end;

     l_Result := PQexec(l_Conn, 'commit;');
     Memo1.Lines.Add('commit');
     l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
     if l_Msg <> '' then
      Memo1.Lines.Add(l_Msg);
     PQclear(l_Result);

    except
     l_Result := PQexec(l_Conn, 'rollback;');
     Memo1.Lines.Add('rollback');
     l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
     if l_Msg <> '' then
      Memo1.Lines.Add(l_Msg);
     PQclear(l_Result);
    end;

  finally
    PQfinish(l_Conn);
  end;
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.HandredLastClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_Watch: Tl3StopWatch;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Watch.Reset;
  l_Watch.Start;
// 2232084
  l_Result := PQExec(f_Conn, 'move absolute -100 xx');
  l_Watch.Stop;
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   Memo1.Lines.Add(Format('cmdTuples %s records, %s ms', [PQcmdTuples(l_Result), FormatFloat('#,###.##', l_Watch.Time * 1000)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := PQgetvalue(l_Result, l_IDX, 0);
     Memo1.Lines.Add(l_Str);
   end;
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

procedure TForm1.StressOpenClick(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_Watch: Tl3StopWatch;
  l_ID: Integer;
  l_ID2: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_ID := 0;
  try
   repeat
    l_Watch.Reset;
    l_Watch.Start;
    l_ID2 := Trunc(Random(2000000));
    l_Result := PQExec(f_Conn, PChar(Format('declare xx%d cursor with hold for select * from archi.file where id between %d and %d', [l_ID, l_ID2, l_ID2 + SpinEdit1.Value])));
//    l_Result := PQExec(f_Conn, PChar(Format('declare xx%d cursor with hold for select * from archi.file', [l_ID])));
    Inc(l_ID);
    Label1.Caption := Format('%d cursors', [l_ID]);
    Label1.Update;
    l_Watch.Stop;
    l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
    if l_Msg <> '' then
     Memo1.Lines.Add(l_Msg)
    else
    begin
     Memo1.Lines.Add(Format('cmdTuples %s records, %s ms', [PQcmdTuples(l_Result), FormatFloat('#,###.##', l_Watch.Time * 1000)]));
     Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
     for l_IDX := 0 to PQntuples(l_Result) - 1 do
     begin
       l_Str := PQgetvalue(l_Result, l_IDX, 0);
       Memo1.Lines.Add(l_Str);
     end;
    end;
    PQclear(l_Result);
    Application.ProcessMessages;
    if TerminateCheck.Checked then
      Break;
   until False;
  finally
    Dec(l_ID);
    Memo1.Lines.Add(Format('Finish - total %d cursors', [l_ID]));
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_IDX2: Integer;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Result := PQprepare(f_Conn, 'TestStmt', 'select * from archi.file', 0, nil);

  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
   Memo1.Lines.Add('Prepare OK');

  PQclear(l_Result);

  l_Result := PQdescribePrepared(f_Conn, 'TestStmt');

  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
   Memo1.Lines.Add('Describe OK');


  for l_IDX := 0 to PQnfields(l_Result) - 1 do
  begin
    l_Str := PQfname(l_Result, l_IDX) + ' ' + IntToStr(PQftype(l_Result, l_IDX));
    Memo1.Lines.Add(l_Str);
  end;
  Memo1.Lines.Add('');

  for l_IDX := 0 to PQntuples(l_Result) - 1 do
  begin
    l_Str := '';
    for l_IDX2 := 0 to PQnfields(l_Result) - 1 do
      l_Str := l_Str + ' ' + PQgetvalue(l_Result, l_IDX, l_IDX2);
    Memo1.Lines.Add(l_Str);
  end;
  Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));

  PQclear(l_Result);

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  l_Name: String;
  l_IDX: Integer;
  l_Result: PPGResult;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_IDX := 0;
  repeat
    l_Result := PQExec(f_Conn, PAnsiChar(Format('select pg_encoding_to_char(%d)', [l_IDX])));
    l_Name := '';
    if PQntuples(l_Result) = 1 then
      l_Name := PQgetvalue(l_Result, 0, 0);
    PQclear(l_Result);
    inc(l_IDX);
    if l_Name <> '' then
      Memo1.Lines.Add(Format('%d = %s', [l_IDX, l_Name]));
  until l_Name = '';
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Result := PQExec(f_Conn, 'SET SESSION CLIENT_ENCODING TO ''WIN1251''; commit;');
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg);
  PQclear(l_Result);
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  l_Result: PPGResult;
  l_Msg: WideString;
  l_Str: String;
  l_IDX: Integer;
  l_IDX2: Integer;
  l_Watch: Tl3StopWatch;
  l_Watch2: Tl3StopWatch;
begin
  if PQstatus(f_Conn) <> CONNECTION_OK then
  begin
   Memo1.Lines.Add(PQerrorMessage(f_Conn));
   raise Exception.Create(PQerrorMessage(f_Conn));
  end;

  l_Watch.Reset;
  l_Watch.Start;
  l_Result := PQExec(f_Conn, 'select * from archi.dta');
  l_Watch.Stop;
  l_Msg := UTF8Decode(PQresultErrorMessage(l_Result));
  if l_Msg <> '' then
   Memo1.Lines.Add(l_Msg)
  else
  begin
   l_Watch2.Reset;
   l_Watch2.Start;
   for l_IDX := 0 to PQntuples(l_Result) - 1 do
   begin
     l_Str := '';
     for l_IDX2 := 0 to PQnfields(l_Result) - 1 do
       l_Str := l_Str + ' ' + PQgetvalue(l_Result, l_IDX, l_IDX2);
     Memo1.Lines.Add(l_Str);
   end;
   l_Watch2.Stop;
   Memo1.Lines.Add(Format('cmdTuples %s records, %s ms', [PQcmdTuples(l_Result), FormatFloat('#,###.##', l_Watch.Time * 1000)]));
   Memo1.Lines.Add(Format('DataReceived %d records, %d fields', [PQntuples(l_Result), PQnfields(l_Result)]));
   Memo1.Lines.Add(Format('Fetch in %s ms', [FormatFloat('#,###.##', l_Watch2.Time * 1000)]));
  end;
  PQclear(l_Result);
  Memo1.Lines.Add('Finish');
end;

end.



