unit evOutTextParaEliminator;
 {* ‘ильтр удал€ющий мусорные текстовые параграфы за пределами документа. }

// ћодуль: "w:\common\components\gui\Garant\Everest\evOutTextParaEliminator.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TevOutTextParaEliminator" MUID: (4F7D3EB4039D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
;

type
 TevOutTextParaEliminator = class(Tk2TagFilter)
  {* ‘ильтр удал€ющий мусорные текстовые параграфы за пределами документа. }
  private
   f_InDocument: Integer;
  protected
   procedure InitFields; override;
   procedure DoStartChild(TypeID: Tk2Type); override;
   function NeedTranslateChildToNext: Boolean; override;
   procedure DoCloseStructure(NeedUndo: Boolean); override;
 end;//TevOutTextParaEliminator

implementation

uses
 l3ImplUses
 , Document_Const
 //#UC START# *4F7D3EB4039Dimpl_uses*
 //#UC END# *4F7D3EB4039Dimpl_uses*
;

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
