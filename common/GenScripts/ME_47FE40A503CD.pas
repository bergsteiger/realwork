unit nevConfirm;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
;

type
 TnevConfirm = class(Tl3ProtoObject, InevConfirm)
  function Make: InevConfirm;
  function ReplaceConfirm(const aBlock: InevRange;
   AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
   {* запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
  function DeleteFoundRgn: Boolean;
  procedure Update;
  function Progress: InevProgress;
  function View: InevView;
   {* Область вывода. }
 end;//TnevConfirm
 
implementation

uses
 l3ImplUses
 , Controls
;

end.
