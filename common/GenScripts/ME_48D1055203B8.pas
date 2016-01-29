unit evTabStops;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3Interfaces
 , l3Variant
 , l3StringList
 , l3LongintList
 , l3Const
;

type
 TevTabStops = class(Tl3CacheableBase, Il3TabStops)
  {* ������� ��������� }
  procedure Create(aTabStops: Tl3Variant);
  function Make(aTabStopsHolder: Tl3Variant): Il3TabStops;
  function Clone: Il3TabStops;
   {* ��������� ������� ���������. }
  function Next: Tl3TabStop;
   {* ��������� ������� ���������. }
  function Filler: Tl3WString;
   {* ��������� ������-�����������. }
  function Style: Tl3TabStopStyle;
   {* ��������� �����. }
  function NeedCutByTab: Boolean;
  procedure Reset;
 end;//TevTabStops
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , k2Tags
 , k2Base
 , SysUtils
;

end.
