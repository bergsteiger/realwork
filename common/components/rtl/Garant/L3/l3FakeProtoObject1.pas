unit l3FakeProtoObject1;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeProtoObject1.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FakeProtoObject1" MUID: (MSM20B3BEC5015F)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3FakeProtoObject1 = class(Tl3ProtoObject)
  private
   f_FakeAttr2: Tl3ProtoObject;
  protected
   NewAttribute: Tl3ProtoObject;
  public
   f_FakeAttr: Tl3ProtoObject;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function FakeOperation: Tl3ProtoObject; virtual;
   function SomeMethod: Tl3ProtoObject; virtual;
 end;//Tl3FakeProtoObject1

implementation

uses
 l3ImplUses
 , l3CustomString
 , l3String
 //#UC START# *MSM20B3BEC5015Fimpl_uses*
 //#UC END# *MSM20B3BEC5015Fimpl_uses*
;

type
 Tl3ProtoObjectFriend = {abstract} class(Tl3ProtoObject)
  {* Друг к классу Tl3ProtoObject }
 end;//Tl3ProtoObjectFriend

function Tl3FakeProtoObject1.FakeOperation: Tl3ProtoObject;
//#UC START# *MSMA1AE0BFFD3AA_MSM20B3BEC5015F_var*
//#UC END# *MSMA1AE0BFFD3AA_MSM20B3BEC5015F_var*
begin
//#UC START# *MSMA1AE0BFFD3AA_MSM20B3BEC5015F_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMA1AE0BFFD3AA_MSM20B3BEC5015F_impl*
end;//Tl3FakeProtoObject1.FakeOperation

function Tl3FakeProtoObject1.SomeMethod: Tl3ProtoObject;
//#UC START# *MSMCE050051A26D_MSM20B3BEC5015F_var*
//#UC END# *MSMCE050051A26D_MSM20B3BEC5015F_var*
begin
//#UC START# *MSMCE050051A26D_MSM20B3BEC5015F_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMCE050051A26D_MSM20B3BEC5015F_impl*
end;//Tl3FakeProtoObject1.SomeMethod

procedure Tl3FakeProtoObject1.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_MSM20B3BEC5015F_var*
//#UC END# *479731C50290_MSM20B3BEC5015F_var*
begin
//#UC START# *479731C50290_MSM20B3BEC5015F_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_MSM20B3BEC5015F_impl*
end;//Tl3FakeProtoObject1.Cleanup

end.
