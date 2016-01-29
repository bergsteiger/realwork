unit DigitalSeparatorSupport.imp;

interface

uses
 l3IntfUses
 , k2Interfaces
;

type
 TevCheckPointSeparator = (
  ev_cpsNone
   {* ничего не делать (не ждать разделител€, не выливать) }
  , ev_cpsWait
   {* ждать разделител€. }
  , ev_cpsReady
   {* готовность к выливке }
 );//TevCheckPointSeparator
 
 _DigitalSeparatorSupport_ = class
  function HasDigitalSeparatorAlignment: Boolean;
  procedure ContinueCell;
  procedure CellStarted;
   {* »нформируем о начале €чейки. }
  procedure CellFinished;
   {* ячейка закончена. }
  procedure SetDigitalSeparatorParams(anAtomIndex: Integer;
   const aValue: Tk2Variant);
  function GetDigitalSeparatorOffset: Integer;
 end;//_DigitalSeparatorSupport_
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Interfaces
 , TableCell_Const
 , Table_Const
 , l3String
;

end.
