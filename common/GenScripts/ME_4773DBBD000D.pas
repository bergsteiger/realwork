unit l3ObjectList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
;

type
 Tl3ObjectList = class(_l3ObjectPtrList_)
  {* ������� ���������� �� ������. }
 end;//Tl3ObjectList
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3Base
 , l3MinMax
 , SysUtils
;

end.
