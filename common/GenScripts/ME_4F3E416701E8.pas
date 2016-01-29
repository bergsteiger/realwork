unit kwStringFactory;

interface

uses
 l3IntfUses
 , kwStringList
 , kwString
 , l3Interfaces
;

type
 TkwStringFactory = class(TkwStringList)
  function MakeKW(const aValue: Il3CString): TkwString;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TkwStringFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
;

end.
