unit l3InterfacedStringList;

interface

uses
 l3IntfUses
 , l3StringList
 , l3_String
;

type
 Tl3InterfacedString = class(Tl3_String)
  {* ����� ����������� ������ � ������������ �������� ���������� }
 end;//Tl3InterfacedString
 
 Tl3InterfacedStringList = class(Tl3StringList)
  {* ����� ����������� ������ ����� �� ���������� ������������ }
 end;//Tl3InterfacedStringList
 
implementation

uses
 l3ImplUses
;

end.
