unit evCustomControlTool;

interface

uses
 l3IntfUses
 , l3_Base
 , evQueryCardInt
 , nevTools
;

type
 TevCustomControlTool = class(Tl3_Base, IevCustomParaTool)
  {* ������� �����, ���������� ������ �� ��������. }
  procedure Create(const aPara: InevPara);
  procedure Set__Para(const Value: InevPara);
  function Para: InevPara;
   {* ��������, �������������� �������. }
 end;//TevCustomControlTool
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3InterfacesMisc
;

end.
