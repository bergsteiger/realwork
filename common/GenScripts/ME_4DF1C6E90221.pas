unit PrintRowHeightsSpy;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObject
 , l3Filer
;

type
 TRowHeight = record
 end;//TRowHeight
 
 TRowHeightsList = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TRowHeightsList
 
 TPrintRowHeightsSpy = class(Tl3ProtoObject)
  {* �������� �� �������� ����� �� ������ ��������� }
  procedure AddRowData(const aData: TRowHeight);
   {* �������� ������ � ������ ������. }
  procedure ClearData;
   {* �������� ������ � �������. }
  function Exists: Boolean;
  procedure StartLogging(const aLogName: AnsiString);
  procedure StopLogging;
 end;//TPrintRowHeightsSpy
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , evConst
;

end.
