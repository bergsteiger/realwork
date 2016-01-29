unit DeletingRowCorrector.imp;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
;

type
 _DeletingRowCorrector_ = class
  procedure CheckRow(const aCheckingRow: InevPara;
   const anOpPack: InevOp);
 end;//_DeletingRowCorrector_
 
implementation

uses
 l3ImplUses
 , k2Base
 , evdTypes
 , l3Variant
;

end.
