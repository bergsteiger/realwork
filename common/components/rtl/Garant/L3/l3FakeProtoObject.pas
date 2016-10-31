unit l3FakeProtoObject;
 {* fnlgknbkfknkfmkfgnfgnnfffnnfnfffg }

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeProtoObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FakeProtoObject123" MUID: (57EBE76D0357)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3NCString
 , l3ProtoDataContainer
 , l3Interfaces
 , l3Variant
;

type
 Tl3FakeProtoObject123 = class;

 ISomeInterface = interface
  function Get_IntProp: Integer;
  procedure Set_IntProp(aValue: Integer);
  procedure SomeInterfaceOperation;
  property IntProp: Integer
   read Get_IntProp
   write Set_IntProp;
 end;//ISomeInterface

 ISomeInterface1 = interface
  ['{EA49343B-7E7A-438A-914D-2EA4774E104D}']
  function Get_IntProp: Integer;
  procedure Set_IntProp(aValue: Integer);
  procedure SomeInterfaceOperation;
  procedure AnotherInterfaceOperation;
  property IntProp: Integer
   read Get_IntProp
   write Set_IntProp;
 end;//ISomeInterface1

 ISomeInterface2 = interface
  {* SomeDocumentation }
  ['{6B61C924-5C5B-4F4D-B789-9FCEED5E1C6F}']
  procedure SomeInterfaceOperation;
 end;//ISomeInterface2

 Tl3SomeInnerClass = class
 end;//Tl3SomeInnerClass

 Tl3FakeProtoObject123 = class(Tl3ProtoObject, Il3CString, Il3Lock, Il3OpPack, Il3RangeManager, ISomeInterface, ISomeInterface1, ISomeInterface2)
  {* fnlgknbkfknkfmkfgnfgnnfffnnfnfffg }
  private
   f_Owner: Tl3ProtoObject;
   f_Parent: Tl3ProtoObject;
   f_Next: Tl3ProtoObject;
   f_Prev: Tl3ProtoObject;
  public
   NewAttribute: AnsiString;
  protected
   function pm_GetProp(anIndex: Integer): AnsiString; virtual;
   procedure pm_SetProp(anIndex: Integer;
    const aValue: AnsiString); virtual;
   function pm_GetAsWStr: Tl3WString;
   procedure Lock(const aLocker: IUnknown); overload;
    {* закрыть. }
   procedure Unlock(const aLocker: IUnknown); overload;
    {* открыть. }
   function Undo(const aProcessor: Ik2Processor): Integer;
    {* откатывает все операции и возвращает их количество. }
   function Redo(const aProcessor: Ik2Processor): Integer;
    {* возвращает все операции и возвращает их количество. }
   procedure Lock; overload;
    {* закрыть. }
   procedure Unlock; overload;
    {* открыть. }
   function Get_Code: Integer;
   function HasPage(anIndex: Integer): Boolean;
    {* содержит ли диапазон указанную страницу. }
   function Get_Count: Integer;
   function Get_Pages(anIndex: Integer): Integer;
   function Get_IndexOfPage(Page: Integer): Integer;
   procedure SomeInterfaceOperation; overload;
   function Get_IntProp: Integer;
   procedure Set_IntProp(aValue: Integer);
   procedure SomeInterfaceOperation; overload;
   procedure AnotherInterfaceOperation;
   function Get_IntProp: Integer;
   procedure Set_IntProp(aValue: Integer);
   procedure SomeInterfaceOperation; overload;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure InitFields; override;
   procedure Release; override;
   procedure DoForceStore; override;
  public
   function Owner: Tl3ProtoObject;
   function NewOperation(aParam: Integer;
    const anObject): AnsiString; virtual;
   procedure Clear; override;
    {* Функция очистки объекта.  Для перекрытия в потомках. }
  public
   property Prop[anIndex: Integer]: AnsiString
    read pm_GetProp
    write pm_SetProp;
 end;//Tl3FakeProtoObject123

implementation

uses
 l3ImplUses
 , l3String
 {$If NOT Defined(NoScripts)}
 , tfwIl3CStringPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57EBE76D0357impl_uses*
 //#UC END# *57EBE76D0357impl_uses*
;

function Tl3FakeProtoObject123.pm_GetProp(anIndex: Integer): AnsiString;
//#UC START# *MSM4A58264277E8_57EBE76D0357get_var*
//#UC END# *MSM4A58264277E8_57EBE76D0357get_var*
begin
//#UC START# *MSM4A58264277E8_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM4A58264277E8_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.pm_GetProp

procedure Tl3FakeProtoObject123.pm_SetProp(anIndex: Integer;
 const aValue: AnsiString);
//#UC START# *MSM4A58264277E8_57EBE76D0357set_var*
//#UC END# *MSM4A58264277E8_57EBE76D0357set_var*
begin
//#UC START# *MSM4A58264277E8_57EBE76D0357set_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM4A58264277E8_57EBE76D0357set_impl*
end;//Tl3FakeProtoObject123.pm_SetProp

function Tl3FakeProtoObject123.Owner: Tl3ProtoObject;
//#UC START# *MSM8169BDEDFFBF_57EBE76D0357_var*
//#UC END# *MSM8169BDEDFFBF_57EBE76D0357_var*
begin
//#UC START# *MSM8169BDEDFFBF_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM8169BDEDFFBF_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Owner

function Tl3FakeProtoObject123.NewOperation(aParam: Integer;
 const anObject): AnsiString;
//#UC START# *MSM3D5B2A8CE3A3_57EBE76D0357_var*
//#UC END# *MSM3D5B2A8CE3A3_57EBE76D0357_var*
begin
//#UC START# *MSM3D5B2A8CE3A3_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM3D5B2A8CE3A3_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.NewOperation

function Tl3FakeProtoObject123.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_57EBE76D0357get_var*
//#UC END# *46780DEF03E5_57EBE76D0357get_var*
begin
//#UC START# *46780DEF03E5_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46780DEF03E5_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.pm_GetAsWStr

procedure Tl3FakeProtoObject123.Lock(const aLocker: IUnknown);
 {* закрыть. }
//#UC START# *467C0F680174_57EBE76D0357_var*
//#UC END# *467C0F680174_57EBE76D0357_var*
begin
//#UC START# *467C0F680174_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *467C0F680174_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Lock

procedure Tl3FakeProtoObject123.Unlock(const aLocker: IUnknown);
 {* открыть. }
//#UC START# *467C0F76026E_57EBE76D0357_var*
//#UC END# *467C0F76026E_57EBE76D0357_var*
begin
//#UC START# *467C0F76026E_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *467C0F76026E_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Unlock

function Tl3FakeProtoObject123.Undo(const aProcessor: Ik2Processor): Integer;
 {* откатывает все операции и возвращает их количество. }
//#UC START# *46A5D33D025C_57EBE76D0357_var*
//#UC END# *46A5D33D025C_57EBE76D0357_var*
begin
//#UC START# *46A5D33D025C_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5D33D025C_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Undo

function Tl3FakeProtoObject123.Redo(const aProcessor: Ik2Processor): Integer;
 {* возвращает все операции и возвращает их количество. }
//#UC START# *46A5D37B0247_57EBE76D0357_var*
//#UC END# *46A5D37B0247_57EBE76D0357_var*
begin
//#UC START# *46A5D37B0247_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5D37B0247_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Redo

procedure Tl3FakeProtoObject123.Lock;
 {* закрыть. }
//#UC START# *46A5D3BC0041_57EBE76D0357_var*
//#UC END# *46A5D3BC0041_57EBE76D0357_var*
begin
//#UC START# *46A5D3BC0041_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5D3BC0041_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Lock

procedure Tl3FakeProtoObject123.Unlock;
 {* открыть. }
//#UC START# *46A5D3D101E6_57EBE76D0357_var*
//#UC END# *46A5D3D101E6_57EBE76D0357_var*
begin
//#UC START# *46A5D3D101E6_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5D3D101E6_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Unlock

function Tl3FakeProtoObject123.Get_Code: Integer;
//#UC START# *4874FC1C01D2_57EBE76D0357get_var*
//#UC END# *4874FC1C01D2_57EBE76D0357get_var*
begin
//#UC START# *4874FC1C01D2_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4874FC1C01D2_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.Get_Code

function Tl3FakeProtoObject123.HasPage(anIndex: Integer): Boolean;
 {* содержит ли диапазон указанную страницу. }
//#UC START# *46A45DA20336_57EBE76D0357_var*
//#UC END# *46A45DA20336_57EBE76D0357_var*
begin
//#UC START# *46A45DA20336_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DA20336_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.HasPage

function Tl3FakeProtoObject123.Get_Count: Integer;
//#UC START# *46A45DC20057_57EBE76D0357get_var*
//#UC END# *46A45DC20057_57EBE76D0357get_var*
begin
//#UC START# *46A45DC20057_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DC20057_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.Get_Count

function Tl3FakeProtoObject123.Get_Pages(anIndex: Integer): Integer;
//#UC START# *46A45DE80156_57EBE76D0357get_var*
//#UC END# *46A45DE80156_57EBE76D0357get_var*
begin
//#UC START# *46A45DE80156_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DE80156_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.Get_Pages

function Tl3FakeProtoObject123.Get_IndexOfPage(Page: Integer): Integer;
//#UC START# *46A45EB10245_57EBE76D0357get_var*
//#UC END# *46A45EB10245_57EBE76D0357get_var*
begin
//#UC START# *46A45EB10245_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45EB10245_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.Get_IndexOfPage

procedure Tl3FakeProtoObject123.SomeInterfaceOperation;
//#UC START# *MSM2A2F9895783A_57EBE76D0357_var*
//#UC END# *MSM2A2F9895783A_57EBE76D0357_var*
begin
//#UC START# *MSM2A2F9895783A_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM2A2F9895783A_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.SomeInterfaceOperation

function Tl3FakeProtoObject123.Get_IntProp: Integer;
//#UC START# *MSM72479BD256E1_57EBE76D0357get_var*
//#UC END# *MSM72479BD256E1_57EBE76D0357get_var*
begin
//#UC START# *MSM72479BD256E1_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM72479BD256E1_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.Get_IntProp

procedure Tl3FakeProtoObject123.Set_IntProp(aValue: Integer);
//#UC START# *MSM72479BD256E1_57EBE76D0357set_var*
//#UC END# *MSM72479BD256E1_57EBE76D0357set_var*
begin
//#UC START# *MSM72479BD256E1_57EBE76D0357set_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM72479BD256E1_57EBE76D0357set_impl*
end;//Tl3FakeProtoObject123.Set_IntProp

procedure Tl3FakeProtoObject123.SomeInterfaceOperation;
//#UC START# *MSM3069F3954928_57EBE76D0357_var*
//#UC END# *MSM3069F3954928_57EBE76D0357_var*
begin
//#UC START# *MSM3069F3954928_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM3069F3954928_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.SomeInterfaceOperation

procedure Tl3FakeProtoObject123.AnotherInterfaceOperation;
//#UC START# *MSM1374212AD762_57EBE76D0357_var*
//#UC END# *MSM1374212AD762_57EBE76D0357_var*
begin
//#UC START# *MSM1374212AD762_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM1374212AD762_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.AnotherInterfaceOperation

function Tl3FakeProtoObject123.Get_IntProp: Integer;
//#UC START# *MSMB7DF4BC843BA_57EBE76D0357get_var*
//#UC END# *MSMB7DF4BC843BA_57EBE76D0357get_var*
begin
//#UC START# *MSMB7DF4BC843BA_57EBE76D0357get_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMB7DF4BC843BA_57EBE76D0357get_impl*
end;//Tl3FakeProtoObject123.Get_IntProp

procedure Tl3FakeProtoObject123.Set_IntProp(aValue: Integer);
//#UC START# *MSMB7DF4BC843BA_57EBE76D0357set_var*
//#UC END# *MSMB7DF4BC843BA_57EBE76D0357set_var*
begin
//#UC START# *MSMB7DF4BC843BA_57EBE76D0357set_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMB7DF4BC843BA_57EBE76D0357set_impl*
end;//Tl3FakeProtoObject123.Set_IntProp

procedure Tl3FakeProtoObject123.SomeInterfaceOperation;
//#UC START# *MSMFC31A174AA13_57EBE76D0357_var*
//#UC END# *MSMFC31A174AA13_57EBE76D0357_var*
begin
//#UC START# *MSMFC31A174AA13_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMFC31A174AA13_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.SomeInterfaceOperation

procedure Tl3FakeProtoObject123.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57EBE76D0357_var*
//#UC END# *479731C50290_57EBE76D0357_var*
begin
//#UC START# *479731C50290_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3FakeProtoObject123.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_57EBE76D0357_var*
//#UC END# *47A6FEE600FC_57EBE76D0357_var*
begin
//#UC START# *47A6FEE600FC_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A6FEE600FC_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure Tl3FakeProtoObject123.InitFields;
//#UC START# *47A042E100E2_57EBE76D0357_var*
//#UC END# *47A042E100E2_57EBE76D0357_var*
begin
//#UC START# *47A042E100E2_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.InitFields

procedure Tl3FakeProtoObject123.Clear;
 {* Функция очистки объекта.  Для перекрытия в потомках. }
//#UC START# *47BC02A50131_57EBE76D0357_var*
//#UC END# *47BC02A50131_57EBE76D0357_var*
begin
//#UC START# *47BC02A50131_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *47BC02A50131_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Clear

procedure Tl3FakeProtoObject123.Release;
//#UC START# *479F2AFB0397_57EBE76D0357_var*
//#UC END# *479F2AFB0397_57EBE76D0357_var*
begin
//#UC START# *479F2AFB0397_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *479F2AFB0397_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.Release

procedure Tl3FakeProtoObject123.DoForceStore;
//#UC START# *5321B9DF011A_57EBE76D0357_var*
//#UC END# *5321B9DF011A_57EBE76D0357_var*
begin
//#UC START# *5321B9DF011A_57EBE76D0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *5321B9DF011A_57EBE76D0357_impl*
end;//Tl3FakeProtoObject123.DoForceStore

end.
