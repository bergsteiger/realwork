unit evdAllSubsEliminator;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdAllSubsEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdAllSubsEliminator" MUID: (4EC116A50211)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdAllSubsEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdAllSubsEliminator

implementation

uses
 l3ImplUses
 , k2Tags
 , Sub_Const
 //#UC START# *4EC116A50211impl_uses*
 //#UC END# *4EC116A50211impl_uses*
;

function TevdAllSubsEliminator.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4EC116A50211_var*
//#UC END# *49E488070386_4EC116A50211_var*
begin
//#UC START# *49E488070386_4EC116A50211_impl*
 Result := k2_idSub; 
//#UC END# *49E488070386_4EC116A50211_impl*
end;//TevdAllSubsEliminator.ParaTypeForFiltering

function TevdAllSubsEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_4EC116A50211_var*
//#UC END# *49E48829016F_4EC116A50211_var*
begin
//#UC START# *49E48829016F_4EC116A50211_impl*
 Result := false;
//#UC END# *49E48829016F_4EC116A50211_impl*
end;//TevdAllSubsEliminator.NeedWritePara

end.
