unit tfwCompiledAxiomaticsRes;

interface

uses
 l3IntfUses
 , l3StringList
;

type
 TtfwCompiledAxiomaticsRes = class(Tl3StringList)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwCompiledAxiomaticsRes
 
implementation

uses
 l3ImplUses
;

end.
