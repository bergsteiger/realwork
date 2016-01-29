unit alcuBaseEngineHolder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuBaseEngineHolder.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Server::BaseEngine::TalcuBaseEngineHolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  l3ProtoObject,
  alcuBaseEngine
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TalcuBaseEngineHolder = class(Tl3ProtoObject)
 private
 // private fields
   f_BaseEngine : TalcuBaseEngine;
    {* Поле для свойства BaseEngine}
 protected
 // property methods
   procedure pm_SetBaseEngine(aValue: TalcuBaseEngine); virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   function IsBaseLocked: Boolean;
 public
 // public properties
   property BaseEngine: TalcuBaseEngine
     read f_BaseEngine
     write pm_SetBaseEngine;
 end;//TalcuBaseEngineHolder
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  SysUtils
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}

// start class TalcuBaseEngineHolder

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
//#UC START# *479731C50290_53CE4F2F008D_var*
//#UC END# *479731C50290_53CE4F2F008D_var*
begin
//#UC START# *479731C50290_53CE4F2F008D_impl*
 BaseEngine := nil;
 inherited;
//#UC END# *479731C50290_53CE4F2F008D_impl*
end;//TalcuBaseEngineHolder.Cleanup

{$IfEnd} //AppServerSide

end.