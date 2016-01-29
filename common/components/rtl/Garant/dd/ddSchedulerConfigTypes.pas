unit ddSchedulerConfigTypes;

{$Include ..\dd\ddDefine.inc}

interface

uses
 l3Interfaces, 
 l3ValueMap,
 l3TypedIntegerValueMap,

 ddCalendarEvents;

type
  TddCalendarEventsMap = class(Tl3IntegerValueMap)
  private
  protected
 // protected methods
    function DoDisplayNameToValue(const aDisplayName: Il3CString): Integer; override;
     {* Функция очистки полей объекта. }
   procedure DoGetDisplayNames(const aList: Il3StringsEx); override;
    function DoValueToDisplayName(aValue: Integer): Il3CString; override;
   function GetMapSize: Integer; override;
  public
   constructor Make;
  end;

implementation

uses
 l3Base,
 l3String;

{ TddCalendarEventsMap }

function TddCalendarEventsMap.DoDisplayNameToValue(
  const aDisplayName: Il3CString): Integer;
var
 i: TddCalendarTaskType;
 l_Value: String;
begin
 Result:= -1;
 l_Value:= l3Str(aDisplayName);
 for i:= low(TddCalendarTaskType) to High(TddCalendarTaskType) do
  if (i in ddEnabledTasks) and (ddCalendarEventArray[i].Caption = l_Value) then
   Result:= Ord(i);
end;

procedure TddCalendarEventsMap.DoGetDisplayNames(
  const aList: Il3StringsEx);
var
 l_Index: TddCalendarTaskType;
begin
 inherited;
 aList.Add('Выберите тип задания');
 for l_Index := low(TddCalendarTaskType) to High(TddCalendarTaskType) Do
  if (l_Index in ddEnabledTasks) then
   aList.Add(l3CStr(ddCalendarEventArray[l_Index].Caption));
end;

function TddCalendarEventsMap.DoValueToDisplayName(
  aValue: Integer): Il3CString;
var
 i: TddCalendarTaskType;
begin
 Result:= nil;
 if aValue = -1 then
  Result:= l3CStr('Выберите тип задания')
 else
  for i:= low(TddCalendarTaskType) to High(TddCalendarTaskType) do
   if (i in ddEnabledTasks) and (Ord(i) = aValue) then
    Result:= l3CStr(ddCalendarEventArray[i].Caption);
end;

function TddCalendarEventsMap.GetMapSize: Integer;
var
 i: TddCalendarTaskType;
begin
 Result:= 0;
 for i:= low(TddCalendarTaskType) to High(TddCalendarTaskType) do
  if (i in ddEnabledTasks) then
   Inc(Result)
end;

constructor TddCalendarEventsMap.Make;
var
 l_Rec: Tl3ValueMapID;
begin
 l_Rec.rName:= 'Календарь';
 l_Rec.rID:= 1;
 Create(l_Rec, TypeInfo(Integer));
end;

end.
