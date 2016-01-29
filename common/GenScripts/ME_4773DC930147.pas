unit l3LongintListPrim;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , Classes
;

type
 Tl3LongintListPrim = class(_l3AtomicList_)
  {* ������ ����� �����. }
  procedure Load(aStream: TStream);
  procedure Save(aStream: TStream);
  function Delete(anIndex: Integer): Integer;
   {* ������� ������� � �������� Index. }
  procedure SaveToStream(aStream: TStream);
   {* ��������� � �����. }
  procedure LoadFromStream(aStream: TStream;
   aNeedSort: Boolean);
   {* ��������� �� ������. }
 end;//Tl3LongintListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3Stream
;

end.
