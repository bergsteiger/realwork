unit ItfwWordListenerList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwWordListenerList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TItfwWordListenerList" MUID: (57BAFF5F01D5)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ItfwWordListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TItfwWordListenerList = class(_l3InterfacePtrList_)
  public
   procedure Subscribe(const aListener: ItfwWordListener);
   procedure Unsubscribe(const aListener: ItfwWordListener);
   procedure Fire(aWord: TtfwWord);
 end;//TItfwWordListenerList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57BAFF5F01D5impl_uses*
 //#UC END# *57BAFF5F01D5impl_uses*
;

type _Instance_R_ = TItfwWordListenerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

procedure TItfwWordListenerList.Subscribe(const aListener: ItfwWordListener);
//#UC START# *57BB00560345_57BAFF5F01D5_var*
//#UC END# *57BB00560345_57BAFF5F01D5_var*
begin
//#UC START# *57BB00560345_57BAFF5F01D5_impl*
 Add(aListener);
//#UC END# *57BB00560345_57BAFF5F01D5_impl*
end;//TItfwWordListenerList.Subscribe

procedure TItfwWordListenerList.Unsubscribe(const aListener: ItfwWordListener);
//#UC START# *57BB007302F3_57BAFF5F01D5_var*
//#UC END# *57BB007302F3_57BAFF5F01D5_var*
begin
//#UC START# *57BB007302F3_57BAFF5F01D5_impl*
 Remove(aListener);
//#UC END# *57BB007302F3_57BAFF5F01D5_impl*
end;//TItfwWordListenerList.Unsubscribe

procedure TItfwWordListenerList.Fire(aWord: TtfwWord);
//#UC START# *57BB027A01CD_57BAFF5F01D5_var*
var
 l_Index : Integer;
//#UC END# *57BB027A01CD_57BAFF5F01D5_var*
begin
//#UC START# *57BB027A01CD_57BAFF5F01D5_impl*
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].Notify(aWord);
//#UC END# *57BB027A01CD_57BAFF5F01D5_impl*
end;//TItfwWordListenerList.Fire
{$IfEnd} // NOT Defined(NoScripts)

end.
