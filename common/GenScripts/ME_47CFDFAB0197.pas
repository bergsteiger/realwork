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
  {* Базовый класс, содержащий ссылку на параграф. }
  procedure Create(const aPara: InevPara);
  procedure Set__Para(const Value: InevPara);
  function Para: InevPara;
   {* Параграф, соотвествующий объекту. }
 end;//TevCustomControlTool
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3InterfacesMisc
;

end.
