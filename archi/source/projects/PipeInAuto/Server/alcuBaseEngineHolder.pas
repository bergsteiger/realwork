unit alcuBaseEngineHolder;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuBaseEngineHolder.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuBaseEngineHolder" MUID: (53CE4F2F008D)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , alcuBaseEngine
;

type
 TalcuBaseEngineHolder = class(Tl3ProtoObject)
  private
   f_BaseEngine: TalcuBaseEngine;
  protected
   procedure pm_SetBaseEngine(aValue: TalcuBaseEngine); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function IsBaseLocked: Boolean;
  public
   property BaseEngine: TalcuBaseEngine
    read f_BaseEngine
    write pm_SetBaseEngine;
 end;//TalcuBaseEngineHolder
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *53CE4F2F008Dimpl_uses*
 //#UC END# *53CE4F2F008Dimpl_uses*
;

procedure TalcuBaseEngineHolder.pm_SetBaseEngine(aValue: TalcuBaseEngine);
//#UC START# *53CE4F5F0206_53CE4F2F008Dset_var*
//#UC END# *53CE4F5F0206_53CE4F2F008Dset_var*
begin
//#UC START# *53CE4F5F0206_53CE4F2F008Dset_impl*
 if f_BaseEngine <> aValue then
 begin
  FreeAndNil(f_BaseEngine);
  if Assigned(aValue) then
    aValue.SetRefTo(f_BaseEngine);
 end;
//#UC END# *53CE4F5F0206_53CE4F2F008Dset_impl*
end;//TalcuBaseEngineHolder.pm_SetBaseEngine

function TalcuBaseEngineHolder.IsBaseLocked: Boolean;
//#UC START# *561CCA19026B_53CE4F2F008D_var*
//#UC END# *561CCA19026B_53CE4F2F008D_var*
begin
//#UC START# *561CCA19026B_53CE4F2F008D_impl*
 Result := (BaseEngine = nil) or (BaseEngine.IsBaseLocked);
//#UC END# *561CCA19026B_53CE4F2F008D_impl*
end;//TalcuBaseEngineHolder.IsBaseLocked

procedure TalcuBaseEngineHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53CE4F2F008D_var*
//#UC END# *479731C50290_53CE4F2F008D_var*
begin
//#UC START# *479731C50290_53CE4F2F008D_impl*
 BaseEngine := nil;
 inherited;
//#UC END# *479731C50290_53CE4F2F008D_impl*
end;//TalcuBaseEngineHolder.Cleanup
{$IfEnd} // Defined(AppServerSide)

end.
