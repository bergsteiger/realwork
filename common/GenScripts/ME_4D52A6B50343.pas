unit vgPersistent;

interface

uses
 l3IntfUses
 , Classes
;

 {$Define l3Unknown_NoIUnknown}
 
 {$Define _UnknownForDesign}
 
type
 TvgPersistent = class(TPersistent)
  procedure Free(var Dummy: Integer);
   {* ��� ����� ������ Free }
 end;//TvgPersistent
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
