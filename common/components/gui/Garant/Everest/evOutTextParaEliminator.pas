unit evOutTextParaEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evOutTextParaEliminator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevOutTextParaEliminator
//
// Фильтр удаляющий мусорные текстовые параграфы за пределами документа.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2TagFilter,
  k2Base
  ;

type
 TevOutTextParaEliminator = class(Tk2TagFilter)
  {* Фильтр удаляющий мусорные текстовые параграфы за пределами документа. }
 private
 // private fields
   f_InDocument : Integer;
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure DoStartChild(TypeID: Tk2Type); override;
   function NeedTranslateChildToNext: Boolean; override;
   procedure DoCloseStructure(NeedUndo: Boolean); override;
 end;//TevOutTextParaEliminator

implementation

uses
  Document_Const
  ;

// start class TevOutTextParaEliminator

procedure TevOutTextParaEliminator.InitFields;
//#UC START# *47A042E100E2_4F7D3EB4039D_var*
//#UC END# *47A042E100E2_4F7D3EB4039D_var*
begin
//#UC START# *47A042E100E2_4F7D3EB4039D_impl*
 f_InDocument := 0;
 inherited;
//#UC END# *47A042E100E2_4F7D3EB4039D_impl*
end;//TevOutTextParaEliminator.InitFields

procedure TevOutTextParaEliminator.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_4F7D3EB4039D_var*
//#UC END# *4A2D1217037A_4F7D3EB4039D_var*
begin
//#UC START# *4A2D1217037A_4F7D3EB4039D_impl*
 if CurrentType.IsKindOf(k2_typDocument) then
  Inc(f_InDocument);
 inherited;
//#UC END# *4A2D1217037A_4F7D3EB4039D_impl*
end;//TevOutTextParaEliminator.DoStartChild

function TevOutTextParaEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4F7D3EB4039D_var*
//#UC END# *4CA3006302BC_4F7D3EB4039D_var*
begin
//#UC START# *4CA3006302BC_4F7D3EB4039D_impl*
 Result := f_InDocument > 0;
//#UC END# *4CA3006302BC_4F7D3EB4039D_impl*
end;//TevOutTextParaEliminator.NeedTranslateChildToNext

procedure TevOutTextParaEliminator.DoCloseStructure(NeedUndo: Boolean);
//#UC START# *4E45166B0156_4F7D3EB4039D_var*
//#UC END# *4E45166B0156_4F7D3EB4039D_var*
begin
//#UC START# *4E45166B0156_4F7D3EB4039D_impl*
 if CurrentType.IsKindOf(k2_typDocument) then
  Dec(f_InDocument);
 inherited;
//#UC END# *4E45166B0156_4F7D3EB4039D_impl*
end;//TevOutTextParaEliminator.DoCloseStructure

end.