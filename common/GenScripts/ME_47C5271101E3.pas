unit nevParas;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TnevParas = class(_l3InterfaceRefList_, InevParas)
  {* ������ ����������. }
  function Count: Integer;
   {* ����� ���������. }
 end;//TnevParas
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
