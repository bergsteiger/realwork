unit l3FakeProtoObject;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeProtoObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FakeProtoObject" MUID: (57EBE76D0357)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TNestedClass = class
 end;//TNestedClass

 Tl3FakeProtoObject = class(Tl3ProtoObject)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure SomeOperation; virtual;
 end;//Tl3FakeProtoObject

implementation

uses
 l3ImplUses
 //#UC START# *57EBE76D0357impl_uses*
 //#UC END# *57EBE76D0357impl_uses*
;

procedure Tl3FakeProtoObject.SomeOperation;
//#UC START# *MSM35A46AA0F584_57EBE76D0357_var*
//#UC END# *MSM35A46AA0F584_57EBE76D0357_var*
begin
//#UC START# *MSM35A46AA0F584_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM35A46AA0F584_57EBE76D0357_impl*
end;//Tl3FakeProtoObject.SomeOperation

procedure Tl3FakeProtoObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57EBE76D0357_var*
//#UC END# *479731C50290_57EBE76D0357_var*
begin
//#UC START# *479731C50290_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_57EBE76D0357_impl*
end;//Tl3FakeProtoObject.Cleanup

end.
