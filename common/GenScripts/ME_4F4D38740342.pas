unit tfwCStringArraySing;

interface

uses
 l3IntfUses
 , tfwCStringArray
;

type
 TtfwCStringArraySing = class(TtfwCStringArray)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwCStringArraySing
 
implementation

uses
 l3ImplUses
;

end.
