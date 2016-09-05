unit ContentsView;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ContentsView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ContentsView" MUID: (4CA06D4A0272)

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
   function AllocNewView: ViewBase; override;
  public
   constructor Make; reintroduce; stdcall;
   procedure AddNotifier(var root;
    var notifier: INodeNotifier); override;
 end;//ContentsView

implementation

uses
 l3ImplUses
 //#UC START# *4CA06D4A0272impl_uses*
 //#UC END# *4CA06D4A0272impl_uses*
;

constructor ContentsView.Make;
//#UC START# *4CA06E69018C_4CA06D4A0272_var*
//#UC END# *4CA06E69018C_4CA06D4A0272_var*
begin
//#UC START# *4CA06E69018C_4CA06D4A0272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA06E69018C_4CA06D4A0272_impl*
end;//ContentsView.Make

procedure ContentsView.AddNotifier(var root;
 var notifier: INodeNotifier);
//#UC START# *46011F130203_4CA06D4A0272_var*
//#UC END# *46011F130203_4CA06D4A0272_var*
begin
//#UC START# *46011F130203_4CA06D4A0272_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F130203_4CA06D4A0272_impl*
end;//ContentsView.AddNotifier

function ContentsView.AllocNewView: ViewBase;
//#UC START# *460127E400EA_4CA06D4A0272_var*
//#UC END# *460127E400EA_4CA06D4A0272_var*
begin
//#UC START# *460127E400EA_4CA06D4A0272_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_4CA06D4A0272_impl*
end;//ContentsView.AllocNewView

end.
