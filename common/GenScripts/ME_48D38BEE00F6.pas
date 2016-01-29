unit evDropCalendarControl;

interface

uses
 l3IntfUses
 , evDropControl
 , evQueryCardInt
 , evQueryCardDropControlsInt
 , l3Interfaces
 , nevTools
 , nevBase
;

type
 TevDropCalendarControl = class(TevDropControl, IevEditorCalendarField, IevDropCalendar)
  procedure CheckText(const Value: Il3CString);
   {* Аналог _TextChange, но для произвольной строки }
  procedure AnalyzeText;
   {* Расширение даты, если введены только день и месяц. }
  function IsBlank: Boolean;
   {* Поле пустое, т.е. равно шаблону. }
  procedure ClearField;
   {* Очищает только самое поле. ClearText - очищает оба поля сразу. }
  function IsStart: Boolean;
   {* Контрол хранит начальную дату интервала. }
  function GetOtherField: IevEditorCalendarField;
   {* Другой контрол. }
  procedure ApplyDate(Value: TDateTime);
   {* Передаёт выбранную дату в календарь. }
  procedure ChooseDate(Sender: TObject);
  procedure CancelDate(Sender: TObject);
  function aDate: TDateTime;
   {* Дата из контрола. }
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* Вываливает выпадающий виджет по указанным координатам }
 end;//TevDropCalendarControl
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Date
 , l3Base
 , SysUtils
 , DateUtils
 , evControlParaTools
;

end.
