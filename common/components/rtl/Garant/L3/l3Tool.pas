unit l3Tool;

// Модуль: "w:\common\components\rtl\Garant\L3\l3Tool.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3Tool" MUID: (48E233B00094)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , l3Interfaces
;

type
 Tl3Tool = class(Tl3ProtoObjectWithCOMQI, Il3Tool)
  protected
   f_Owner: Pointer;
  protected
   procedure OwnerDead;
    {* Нотификация о смерти родителя. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(const anOwner: Il3ToolOwner); reintroduce;
 end;//Tl3Tool

implementation

uses
 l3ImplUses
 //#UC START# *48E233B00094impl_uses*
 //#UC END# *48E233B00094impl_uses*
;

constructor Tl3Tool.Create(const anOwner: Il3ToolOwner);
//#UC START# *48E2343E007B_48E233B00094_var*
//#UC END# *48E2343E007B_48E233B00094_var*
begin
//#UC START# *48E2343E007B_48E233B00094_impl*
 inherited Create;
 f_Owner := Pointer(anOwner);
 if (f_Owner <> nil) then
  Il3ToolOwner(f_Owner).AddTool(Self);
//#UC END# *48E2343E007B_48E233B00094_impl*
end;//Tl3Tool.Create

procedure Tl3Tool.OwnerDead;
 {* Нотификация о смерти родителя. }
//#UC START# *46A5D4220369_48E233B00094_var*
//#UC END# *46A5D4220369_48E233B00094_var*
begin
//#UC START# *46A5D4220369_48E233B00094_impl*
 f_Owner := nil;
//#UC END# *46A5D4220369_48E233B00094_impl*
end;//Tl3Tool.OwnerDead

procedure Tl3Tool.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48E233B00094_var*
//#UC END# *479731C50290_48E233B00094_var*
begin
//#UC START# *479731C50290_48E233B00094_impl*
 if (f_Owner <> nil) then
  Il3ToolOwner(f_Owner).RemoveTool(Self);
 f_Owner := nil;
 inherited;
//#UC END# *479731C50290_48E233B00094_impl*
end;//Tl3Tool.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3Tool.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_48E233B00094_var*
//#UC END# *47A6FEE600FC_48E233B00094_var*
begin
//#UC START# *47A6FEE600FC_48E233B00094_impl*
 Result := true;
//#UC END# *47A6FEE600FC_48E233B00094_impl*
end;//Tl3Tool.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
