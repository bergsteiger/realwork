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
   {* ������ �� ������. ������������ �������� ��. TevReplaceConfirmEvent. }
  function DeleteFoundRgn: Boolean;
  procedure Update;
  function Progress: InevProgress;
  function View: InevView;
   {* ������� ������. }
 end;//TnevConfirm
 
implementation

uses
 l3ImplUses
 , Controls
;

end.
