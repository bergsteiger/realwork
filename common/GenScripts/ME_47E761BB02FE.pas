unit vcmAction;

interface

uses
 l3IntfUses
 , ActnList
;

type
 TvcmAction = class(_l3Unknown_)
  {* ������� �������� ���������� vcm ��� �������� � ����. }
  procedure DoUpdate;
 end;//TvcmAction
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
