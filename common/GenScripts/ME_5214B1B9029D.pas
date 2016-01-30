unit ddAppConfigDates;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigDates.pas"
// Стереотип: "UtilityPack"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , ddAppConfigTypes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ddAppConfigConst
 , ddConfigStorages
 , vtLabel
;

type
 TddDateTimeConfigItem = class(TddVisualConfigItem)
  private
   procedure DoOnChange(Sender: TObject);
  protected
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
  public
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
 end;//TddDateTimeConfigItem

 {$If NOT Defined(Nemesis)}
 TddTimeConfigItem = class(TddDateTimeConfigItem)
  protected
   procedure AfterConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    theControl: TControl;
    theLabel: TvtLabel); override;
  public
   function MinWidth(aParent: TWinControl): Integer; override;
 end;//TddTimeConfigItem
 {$IfEnd} // NOT Defined(Nemesis)

 TddDateConfigItem = class(TddDateTimeConfigItem)
  protected
   procedure AfterConstruct(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    theControl: TControl;
    theLabel: TvtLabel); override;
  public
   function MinWidth(aParent: TWinControl): Integer; override;
 end;//TddDateConfigItem

 {$If NOT Defined(Nemesis)}
 TddWeekDayCombo = class(TddComboBoxConfigItem)
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aCase: Integer); reintroduce;
 end;//TddWeekDayCombo
 {$IfEnd} // NOT Defined(Nemesis)

 {$If NOT Defined(Nemesis)}
 TddMonthDayCombo = class(TddComboBoxConfigItem)
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aCase: Integer); reintroduce;
 end;//TddMonthDayCombo
 {$IfEnd} // NOT Defined(Nemesis)

 {$If NOT Defined(Nemesis)}
 TddMonthsCombo = class(TddComboBoxConfigItem)
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aCase: Integer); reintroduce;
 end;//TddMonthsCombo
 {$IfEnd} // NOT Defined(Nemesis)

 {$If NOT Defined(Nemesis)}
 TddWeekDaysCheckListItem = class(TddCheckListConfigItem)
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TddWeekDaysCheckListItem
 {$IfEnd} // NOT Defined(Nemesis)

 TddMonthType = (
  m1
  , m2
  , m3
  , m4
  , m5
  , m6
  , m7
  , m8
  , m9
  , m10
  , m11
  , m12
 );//TddMonthType

 TddWeekType = (
  Dw1
  , Dw2
  , Dw3
  , Dw4
  , Dw5
  , Dw6
  , Dw7
 );//TddWeekType

 TddDayType = (
  d1
  , d2
  , d3
  , d4
  , d5
  , d6
  , d7
  , d8
  , d9
  , d10
  , d11
  , d12
  , d13
  , d14
  , d15
  , d16
  , d17
  , d18
  , d19
  , d20
  , d21
  , d22
  , d23
  , d24
  , d25
  , d26
  , d27
  , d28
  , d29
  , d30
  , d31
 );//TddDayType

 TddDayArray = array [TddDayType] of AnsiString;

 T0_2Range = 0 .. 2;

 T0_1Range = 0 .. 1;

 TddWeekArray = array [TddWeekType] of AnsiString;

 TWeekDaysArray = array [T0_2Range] of TddWeekArray;

 TMonthArray = array [TddMonthType] of AnsiString;

 TMonthsArray = array [T0_1Range] of TMonthArray;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3TypedIntegerValueMap
;

const
 WeekDaysArray: TWeekDaysArray = (('Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'),('Понедельника', 'Вторника', 'Среды', 'Четверга', 'Пятницы', 'Субботы', 'Воскресенья'),('Понедельникам', 'Вторникам', 'Средам', 'Четвергам', 'Пятницам', 'Субботам', 'Воскресеньям'));
 MonthsArray: TMonthsArray = (('Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь','Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'),('Января', 'Февраля', 'Марта', 'Апреля', 'Мая', 'Июня','Июля', 'Августа', 'Сентября', 'Октября', 'Ноября', 'Декабря'));
 WeekID: Tl3ValueMapID = (rName: 'Дни недели'; rID : 1);
 MonthID: Tl3ValueMapID = (rName: 'Месяцы'; rID : 1);
 DayID: Tl3ValueMapID = (rName: 'Числа'; rID : 1);

procedure TddDateTimeConfigItem.DoOnChange(Sender: TObject);
//#UC START# *522F10E10084_522F0FB3004F_var*
//#UC END# *522F10E10084_522F0FB3004F_var*
begin
//#UC START# *522F10E10084_522F0FB3004F_impl*
 Changed := True;
//#UC END# *522F10E10084_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.DoOnChange

function TddDateTimeConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_522F0FB3004F_var*
//#UC END# *521761BB03DE_522F0FB3004F_var*
begin
//#UC START# *521761BB03DE_522F0FB3004F_impl*
 Result := TDateTimePicker.Create(aParent);
 Result.Parent := aParent;
 Result.Left := aLeft;
 Result.Top := aTop;
 if LabelTop then
  Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight
 else
  Result.Width := MinWidth(aParent);
 TDateTimePicker(Result).OnChange := DoOnChange;
//#UC END# *521761BB03DE_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.ConstructControl

function TddDateTimeConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_522F0FB3004F_var*
//#UC END# *521B053F03C3_522F0FB3004F_var*
begin
//#UC START# *521B053F03C3_522F0FB3004F_impl*
 with TDateTimePicker.Create(aParent) do
 try
  Parent := aParent;
  Result := Height;
 finally
  Free;
 end;
//#UC END# *521B053F03C3_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.ControlHeight

procedure TddDateTimeConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_522F0FB3004F_var*
//#UC END# *521B058801FD_522F0FB3004F_var*
begin
//#UC START# *521B058801FD_522F0FB3004F_impl*
 DateTimeValue := TDateTimePicker(Control).DateTime;
//#UC END# *521B058801FD_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.GetValueFromControl

procedure TddDateTimeConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_522F0FB3004F_var*
//#UC END# *521B07030052_522F0FB3004F_var*
begin
//#UC START# *521B07030052_522F0FB3004F_impl*
 if aDefault then
  TDateTimePicker(Control).DateTime:= DefaultValue.AsDateTime
 else
  TDateTimePicker(Control).DateTime:= DateTimeValue;
//#UC END# *521B07030052_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.SetValueToControl

constructor TddDateTimeConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_522F0FB3004F_var*
var
 l_DefValue: TddConfigValue;
//#UC END# *5217273F000F_522F0FB3004F_var*
begin
//#UC START# *5217273F000F_522F0FB3004F_impl*
 l_DefValue := aDefaultValue;
 if l_DefValue.AsDateTime = 0 then
  l_DefValue.AsDateTime := Now;
 inherited Create(aAlias, aCaption, l_DefValue, aMasterItem);
 f_Value.Kind := dd_vkDateTime;
 f_Value.AsDateTime := Now;
//#UC END# *5217273F000F_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.Create

procedure TddDateTimeConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_522F0FB3004F_var*
//#UC END# *52172B72014C_522F0FB3004F_var*
begin
//#UC START# *52172B72014C_522F0FB3004F_impl*
 DateTimeValue := aStorage.ReadDateTime(Alias, Now{DefaultValue.AsDateTime});
//#UC END# *52172B72014C_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.LoadValue

procedure TddDateTimeConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_522F0FB3004F_var*
//#UC END# *52172CA801E3_522F0FB3004F_var*
begin
//#UC START# *52172CA801E3_522F0FB3004F_impl*
 aStorage.WriteDateTime(Alias, DateTimeValue);
//#UC END# *52172CA801E3_522F0FB3004F_impl*
end;//TddDateTimeConfigItem.SaveValue

procedure TddTimeConfigItem.AfterConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 theControl: TControl;
 theLabel: TvtLabel);
//#UC START# *521760C60369_522F0FC7007F_var*
//#UC END# *521760C60369_522F0FC7007F_var*
begin
//#UC START# *521760C60369_522F0FC7007F_impl*
 inherited AfterConstruct(aLeft, aMaxLeft, aTop, theControl, theLabel);
 (theControl as TDateTimePicker).Kind:= dtkTime;
//#UC END# *521760C60369_522F0FC7007F_impl*
end;//TddTimeConfigItem.AfterConstruct

function TddTimeConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_522F0FC7007F_var*
//#UC END# *521B061A0387_522F0FC7007F_var*
begin
//#UC START# *521B061A0387_522F0FC7007F_impl*
 Result := 40 + GetCanvas(aParent).TextWidth(TimeToStr(Time)) + c_ConfigItemLeft;
//#UC END# *521B061A0387_522F0FC7007F_impl*
end;//TddTimeConfigItem.MinWidth

procedure TddDateConfigItem.AfterConstruct(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 theControl: TControl;
 theLabel: TvtLabel);
//#UC START# *521760C60369_522F0FF8033E_var*
//#UC END# *521760C60369_522F0FF8033E_var*
begin
//#UC START# *521760C60369_522F0FF8033E_impl*
 inherited AfterConstruct(aLeft, aMaxLeft, aTop, theControl, theLabel);
 (theControl as TDateTimePicker).Kind:= dtkDate;
//#UC END# *521760C60369_522F0FF8033E_impl*
end;//TddDateConfigItem.AfterConstruct

function TddDateConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_522F0FF8033E_var*
//#UC END# *521B061A0387_522F0FF8033E_var*
begin
//#UC START# *521B061A0387_522F0FF8033E_impl*
 Result := 40 + GetCanvas(aParent).TextWidth(DateToStr(Date)) + c_ConfigItemLeft;
//#UC END# *521B061A0387_522F0FF8033E_impl*
end;//TddDateConfigItem.MinWidth

{$If NOT Defined(Nemesis)}
constructor TddWeekDayCombo.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aCase: Integer);
//#UC START# *522F11FB01F4_522F103A01FA_var*
//#UC END# *522F11FB01F4_522F103A01FA_var*
begin
//#UC START# *522F11FB01F4_522F103A01FA_impl*
 Create(aAlias, aCaption, aDefaultValue, Tl3SimpleTypedIntegerValueMap.Make(WeekID, TypeInfo(TddWeekType), WeekDaysArray[aCase]));
//#UC END# *522F11FB01F4_522F103A01FA_impl*
end;//TddWeekDayCombo.Make
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
constructor TddMonthDayCombo.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aCase: Integer);
//#UC START# *522F1221016B_522F10570306_var*
var
 l_A: TddDayArray;

 function MonthDaysArray: TddDayArray;
 var
  I: TddDayType;
 begin
  for I := low(TddDayType) to High(TddDayType) do
   Result[I] := Format('%d-го числа', [Succ(Ord(I))]);
 end;
//#UC END# *522F1221016B_522F10570306_var*
begin
//#UC START# *522F1221016B_522F10570306_impl*
 l_A := MonthDaysArray;
 Create(aAlias, aCaption, aDefaultValue, Tl3SimpleTypedIntegerValueMap.Make(DayID, TypeInfo(TddDayType), l_A));
//#UC END# *522F1221016B_522F10570306_impl*
end;//TddMonthDayCombo.Make
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
constructor TddMonthsCombo.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aCase: Integer);
//#UC START# *522F1243037E_522F106802E6_var*
//#UC END# *522F1243037E_522F106802E6_var*
begin
//#UC START# *522F1243037E_522F106802E6_impl*
 Create(aAlias, aCaption, aDefaultValue, Tl3SimpleTypedIntegerValueMap.Make(MonthID, TypeInfo(TddMonthType), MonthsArray[aCase]));
//#UC END# *522F1243037E_522F106802E6_impl*
end;//TddMonthsCombo.Make
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
constructor TddWeekDaysCheckListItem.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *522F125702AB_522F10880303_var*
var
 I: TddWeekType;
//#UC END# *522F125702AB_522F10880303_var*
begin
//#UC START# *522F125702AB_522F10880303_impl*
 Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 Columns := 2;
 for I := Low(TddWeekType) to High(TddWeekType) do
  Add(WeekDaysArray[1, I]);
//#UC END# *522F125702AB_522F10880303_impl*
end;//TddWeekDaysCheckListItem.Make
{$IfEnd} // NOT Defined(Nemesis)

end.
