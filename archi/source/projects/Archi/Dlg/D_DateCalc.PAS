unit D_DateCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, vtSpin, Mask,
  vtCombo, vtDateEdit,
  l3Date;

type
  TDateCalcDlg = class(TBottomBtnDlg)
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    edtInitialDate: TvtDateEdit;
    edtlDateDelta: TvtSpinEdit;
    edtResultDate: TvtDateEdit;
    cbLogModificator: TComboBox;
    cbDeltaKind: TComboBox;
    procedure Calculate;
    procedure edtInitialDateChange(Sender: TObject);
    procedure edtlDateDeltaChange(Sender: TObject);
    procedure cbDeltaKindChange(Sender: TObject);
    procedure cbLogModificatorChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GetCalculateDate(var aDate : TStDate) : Boolean;

implementation

{$R *.dfm}

 uses
  l3MinMax;

function GetCalculateDate(var aDate : TStDate) : Boolean;
begin
 with TDateCalcDlg.Create(nil) do
 try
  edtInitialDate.StDate := aDate;
  Result := Execute;
  if Result then
   aDate := edtResultDate.StDate;
 finally
  Free;
 end;
end;


(*
From: Денис А. Кузякин
To: Соловьев Саша ; Дудко Дима ; Бабанин Вова ; Подключение
Sent: Wednesday, June 13, 2007 3:57 PM
Subject: Калькулятор дат

Вованыч!
Надо сделать, чтобы подсчет в калькуляторе для МЕСЯЦЕВ осуществлялся следующим образом:
"По истечении Х месяцев со дня опубликования"
1. Определяется начало срока - ДЕНЬ ОПУБЛИКОВАНИЯ - число Y
2. От месяца начала срока определяется месяц окончания срока
3. Смотрится есть ли в этом месяце это число Y. Если есть, то берется оно, если нет - берется 1-е число следующего месяца

Например, Док опубликован 30 января 2007. Вступает по истечении 1 месяца со дня опубликования.
1. Начало срока - 30 января
2. Месяц окончания - февраль
3. В феврале нет 30-го числа, значит вступает - с 1 марта

Пример 2:
Док опубликован 30 января 2007. Вступает по истечении 3 месяцев со дня опубликования.
1. Начало срока - 30 января
2. Месяц окончания - апрель
3. В апреле есть 30-е число, значит вступает - с 30 апреля

"По истечении Х месяцев после дня опубликования"
1. Определяется начало срока - ДЕНЬ ОПУБЛИКОВАНИЯ ПЛЮС ОДИН ДЕНЬ - число Z
2. От месяца начала срока определяется месяц окончания срока
3. Смотрится есть ли в этом месяце это число Z. Если есть, то берется оно, если нет - берется 1-е число следующего месяца

Например, Док опубликован 30 января 2007. Вступает по истечении 1 месяца после дня опубликования.
1. Начало срока - 30 января + 1 = 31 января
2. Месяц окончания - февраль
3. В феврале нет 31-го числа, значит вступает - с 1 марта

Пример 2:
Док опубликован 31 января 2007. Вступает по истечении 3 месяцев со дня опубликования.
1. Начало срока - 31 января + 1 = 1 февраля
2. Месяц окончания - май
3. 1 мая
____________________________________
С уважением, Кузякин Денис
*)

procedure TDateCalcDlg.Calculate;
var
 Day, Month, Year : Integer;
 lDate : TStDate;
 lDinM : Integer;

 procedure MonthYearRecalc;
 begin
  Year := Year + (Month - 1) div 12;
  Month := ((Month-1) mod 12) + 1;
 end;

begin
 if edtInitialDate.IsValid then
 begin
  lDate := edtInitialDate.StDate + cbLogModificator.ItemIndex;
  if cbDeltaKind.ItemIndex = 0 then //дней
   edtResultDate.StDate := lDate + edtlDateDelta.AsInteger
  else
  begin
   StDateToDMY(lDate, Day, Month, Year);
   if cbDeltaKind.ItemIndex = 1 then //месяцев
    Month := Month + edtlDateDelta.AsInteger
   else //лет
    Month := Month + edtlDateDelta.AsInteger * 12;

   MonthYearRecalc;

   lDinM := DaysInMonth(Month, Year);
   if Day > lDinM then
   begin
    Day := Day - lDinM;
    Inc(Month);
    MonthYearRecalc;
   end;

   edtResultDate.StDate := DMYToStDate(Day, Month, Year);
  end;
 end
 else
  edtResultDate.ClearDate;
end;

procedure TDateCalcDlg.edtInitialDateChange(Sender: TObject);
begin
 Calculate;
end;

procedure TDateCalcDlg.edtlDateDeltaChange(Sender: TObject);
begin
 Calculate;
end;

procedure TDateCalcDlg.cbDeltaKindChange(Sender: TObject);
begin
 Calculate;
end;

procedure TDateCalcDlg.cbLogModificatorChange(Sender: TObject);
begin
 Calculate;
end;
end.
