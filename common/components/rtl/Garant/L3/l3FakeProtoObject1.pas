unit l3FakeProtoObject1;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeProtoObject1.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3FakeProtoObject1" MUID: (MSM824D82F9B947)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3FakeProtoObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 (*
 Ml3FakeProtoObject1 = interface
  {* Контракт сервиса Tl3FakeProtoObject1 }
  function SomeServiceMethod: Integer;
 end;//Ml3FakeProtoObject1
 *)

type
 Il3FakeProtoObject1 = interface
  {* Интерфейс сервиса Tl3FakeProtoObject1 }
  function SomeServiceMethod: Integer;
 end;//Il3FakeProtoObject1

 _l3MapPrim_Parent_ = Tl3FakeProtoObject123;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3MapPrim.imp.pas}
 _l3DataContainer_Parent_ = _l3MapPrim_;
 {$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}
 _l3OpenArray_Parent_ = _l3DataContainer_;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 Tl3FakeProtoObject1 = class(_l3OpenArray_)
  private
   f_Alien: Il3FakeProtoObject1;
    {* Внешняя реализация сервиса Il3FakeProtoObject1 }
  protected
   procedure pm_SetAlien(const aValue: Il3FakeProtoObject1);
   procedure ClearFields; override;
  public
   function Parent: Tl3FakeProtoObject123; virtual;
   function SomeServiceMethod: Integer;
   class function Instance: Tl3FakeProtoObject1;
    {* Метод получения экземпляра синглетона Tl3FakeProtoObject1 }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3FakeProtoObject1
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3FakeProtoObject1 }
 end;//Tl3FakeProtoObject1

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *MSM824D82F9B947impl_uses*
 //#UC END# *MSM824D82F9B947impl_uses*
;

var g_Tl3FakeProtoObject1: Tl3FakeProtoObject1 = nil;
 {* Экземпляр синглетона Tl3FakeProtoObject1 }

procedure Tl3FakeProtoObject1Free;
 {* Метод освобождения экземпляра синглетона Tl3FakeProtoObject1 }
begin
 l3Free(g_Tl3FakeProtoObject1);
end;//Tl3FakeProtoObject1Free

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3KeyValuePair;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_MSM824D82F9B947_var*
//#UC END# *5609091B00C0_MSM824D82F9B947_var*
begin
//#UC START# *5609091B00C0_MSM824D82F9B947_impl*
 !!! Needs to be implemented !!!
//#UC END# *5609091B00C0_MSM824D82F9B947_impl*
end;//CompareKeys

type _Instance_R_ = Tl3FakeProtoObject1;

{$Include w:\common\components\rtl\Garant\L3\l3MapPrim.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

procedure Tl3FakeProtoObject1.pm_SetAlien(const aValue: Il3FakeProtoObject1);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3FakeProtoObject1.pm_SetAlien

function Tl3FakeProtoObject1.Parent: Tl3FakeProtoObject123;
//#UC START# *MSM0322E46FE55D_MSM824D82F9B947_var*
//#UC END# *MSM0322E46FE55D_MSM824D82F9B947_var*
begin
//#UC START# *MSM0322E46FE55D_MSM824D82F9B947_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM0322E46FE55D_MSM824D82F9B947_impl*
end;//Tl3FakeProtoObject1.Parent

function Tl3FakeProtoObject1.SomeServiceMethod: Integer;
//#UC START# *MSM46EDDD962C72_MSM824D82F9B947_var*
//#UC END# *MSM46EDDD962C72_MSM824D82F9B947_var*
begin
//#UC START# *MSM46EDDD962C72_MSM824D82F9B947_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM46EDDD962C72_MSM824D82F9B947_impl*
end;//Tl3FakeProtoObject1.SomeServiceMethod

class function Tl3FakeProtoObject1.Instance: Tl3FakeProtoObject1;
 {* Метод получения экземпляра синглетона Tl3FakeProtoObject1 }
begin
 if (g_Tl3FakeProtoObject1 = nil) then
 begin
  l3System.AddExitProc(Tl3FakeProtoObject1Free);
  g_Tl3FakeProtoObject1 := Create;
 end;
 Result := g_Tl3FakeProtoObject1;
end;//Tl3FakeProtoObject1.Instance

class function Tl3FakeProtoObject1.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3FakeProtoObject1 <> nil;
end;//Tl3FakeProtoObject1.Exists

procedure Tl3FakeProtoObject1.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3FakeProtoObject1.ClearFields

end.
