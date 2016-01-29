unit nevAnchorModify.imp;

interface

uses
 l3IntfUses
 , nevTools
;

type
 _nevAnchorModify_ = class
  procedure DoBottom(const aView: InevView);
  function DoIncLinePrim(const aView: InevView;
   var theLine: Integer;
   aSmall: Boolean): Integer;
  procedure LockScroll;
  procedure UnlockScroll;
  procedure SignalScroll;
  procedure DoSignalScroll;
  procedure DoLockScroll;
  procedure DoUnlockScroll;
  procedure Bottom(const aView: InevView);
  function IncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
   {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
 end;//_nevAnchorModify_
 
implementation

uses
 l3ImplUses
;

end.
