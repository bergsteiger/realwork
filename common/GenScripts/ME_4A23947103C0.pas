unit nevFlatSubsList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevContainers
 , nevTools
;

type
 TnevFlatSubsList = class(_l3InterfaceRefList_, InevFlatSubsList)
  {* ������� ��������� ����� }
  function Count: Integer;
   {* ����� ���������. }
 end;//TnevFlatSubsList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
