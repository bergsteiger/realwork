unit evdTaskFolderEliminator;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTaskFolderEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdTaskFolderEliminator" MUID: (53C3AC15027D)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdTaskFolderEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevdTaskFolderEliminator

implementation

uses
 l3ImplUses
 , Task_Const
;

function TevdTaskFolderEliminator.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_53C3AC15027D_var*
//#UC END# *49E488070386_53C3AC15027D_var*
begin
//#UC START# *49E488070386_53C3AC15027D_impl*
 Result := k2_typTask;
//#UC END# *49E488070386_53C3AC15027D_impl*
end;//TevdTaskFolderEliminator.ParaTypeForFiltering

procedure TevdTaskFolderEliminator.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_53C3AC15027D_var*
//#UC END# *49E4883E0176_53C3AC15027D_var*
begin
//#UC START# *49E4883E0176_53C3AC15027D_impl*
 aLeaf.AttrW[k2_attrTaskFolder, nil] := nil;
 inherited;
//#UC END# *49E4883E0176_53C3AC15027D_impl*
end;//TevdTaskFolderEliminator.DoWritePara

end.
