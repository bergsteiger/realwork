unit ContentsView;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ContentsView.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , View
 , ViewBase
 , DynamicTreeUnit
;

type
 ContentsView = class
  public
   NodeDelegateType_: ;
  protected
   function alloc_new_view: ViewBase; override;
  public
   constructor make; reintroduce;
   procedure add_notifier(var root;
    var notifier: INodeNotifier); override;
 end;//ContentsView

implementation

uses
 l3ImplUses
;

constructor ContentsView.make;
//#UC START# *4CA06E69018C_4CA06D4A0272_var*
//#UC END# *4CA06E69018C_4CA06D4A0272_var*
begin
//#UC START# *4CA06E69018C_4CA06D4A0272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA06E69018C_4CA06D4A0272_impl*
end;//ContentsView.make

procedure ContentsView.add_notifier(var root;
 var notifier: INodeNotifier);
//#UC START# *46011F130203_4CA06D4A0272_var*
//#UC END# *46011F130203_4CA06D4A0272_var*
begin
//#UC START# *46011F130203_4CA06D4A0272_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F130203_4CA06D4A0272_impl*
end;//ContentsView.add_notifier

function ContentsView.alloc_new_view: ViewBase;
//#UC START# *460127E400EA_4CA06D4A0272_var*
//#UC END# *460127E400EA_4CA06D4A0272_var*
begin
//#UC START# *460127E400EA_4CA06D4A0272_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_4CA06D4A0272_impl*
end;//ContentsView.alloc_new_view

end.
