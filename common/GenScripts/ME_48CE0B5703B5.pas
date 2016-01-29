unit nevPara;

interface

uses
 l3IntfUses
 , nevParaPrim
 , nevTools
 , l3Variant
 , k2Interfaces
 , nevBase
;

type
 TnevPara = class(TnevParaPrim, InevParaInternal)
  {* Базовый предок для реализации инструментов параграфов }
  function Make(aTag: Tl3Variant): InevParaInternal;
  procedure SignalPID(aPID: TnevParaIndex);
 end;//TnevPara
 
implementation

uses
 l3ImplUses
 , k2Tags
 , k2Const
 , l3Units
 , Classes
 , SysUtils
 , nevFacade
 , ParaList_Const
 , k2Base
 , k2NullTagImpl
;

end.
