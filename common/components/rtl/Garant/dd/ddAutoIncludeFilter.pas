unit ddAutoIncludeFilter;
{ Добавляет в документ запись о подключении ближайшей будущей субботой }


interface

uses
  ddHeaderFilter, k2Interfaces;

type
 TddAutoIncludeFilter = class(TddHeaderFilter)
 private
  function VersionDate: Integer;
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
 end;

implementation

uses
  k2Tags, dt_Types, l3Date, l3Datest;

procedure TddAutoIncludeFilter.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_Record: Tl3Variant;
begin
 l_Record:= aHeaderRoot.cAtomEx([k2_tiLogRecords, k2_tiChildren, k2_tiType, Ord(acIncluded)], nil);
 l_Record.IntW[k2_tiStart, nil]:= VersionDate;
end;                         

function TddAutoIncludeFilter.VersionDate: Integer;
begin
 Result := StDateToDemon(DateTimeToStDate(vtGetNearestDayOfWeek(Saturday, False)));
end;

end.
