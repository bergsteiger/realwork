unit ddAppConfigDates;

interface

uses
 l3IntfUses
 , l3Interfaces
 , ddAppConfigTypes
 , Controls
 , ddAppConfigConst
 , ddConfigStorages
 , vtLabel
;

type
 TddDateTimeConfigItem = class(TddVisualConfigItem)
  procedure DoOnChange(Sender: TObject);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddDateTimeConfigItem
 
 TddTimeConfigItem = class(TddDateTimeConfigItem)
 end;//TddTimeConfigItem
 
 TddDateConfigItem = class(TddDateTimeConfigItem)
 end;//TddDateConfigItem
 
 TddWeekDayCombo = class(TddComboBoxConfigItem)
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   aCase: Integer);
 end;//TddWeekDayCombo
 
 TddMonthDayCombo = class(TddComboBoxConfigItem)
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   aCase: Integer);
 end;//TddMonthDayCombo
 
 TddMonthsCombo = class(TddComboBoxConfigItem)
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   aCase: Integer);
 end;//TddMonthsCombo
 
 TddWeekDaysCheckListItem = class(TddCheckListConfigItem)
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefaultValue: TddConfigValue;
   aMasterItem: TddBaseConfigItem);
 end;//TddWeekDaysCheckListItem
 
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
 
 // TddDayArray
 
 // T0_2Range
 
 // T0_1Range
 
 // TddWeekArray
 
 // TWeekDaysArray
 
 // TMonthArray
 
 // TMonthsArray
 
implementation

uses
 l3ImplUses
 , ComCtrls
 , SysUtils
 , l3TypedIntegerValueMap
;

end.
