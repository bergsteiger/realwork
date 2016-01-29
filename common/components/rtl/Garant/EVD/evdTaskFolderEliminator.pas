unit evdTaskFolderEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdTaskFolderEliminator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdTaskFolderEliminator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant
  ;

type
 TevdTaskFolderEliminator = class(TevdLeafParaFilter)
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevdTaskFolderEliminator

implementation

uses
  Task_Const
  ;

// start class TevdTaskFolderEliminator

function TevdTaskFolderEliminator.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_53C3AC15027D_var*
//#UC END# *49E488070386_53C3AC15027D_var*
begin
//#UC START# *49E488070386_53C3AC15027D_impl*
 Result := k2_typTask;
//#UC END# *49E488070386_53C3AC15027D_impl*
end;//TevdTaskFolderEliminator.ParaTypeForFiltering

procedure TevdTaskFolderEliminator.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_53C3AC15027D_var*
//#UC END# *49E4883E0176_53C3AC15027D_var*
begin
//#UC START# *49E4883E0176_53C3AC15027D_impl*
 aLeaf.AttrW[k2_attrTaskFolder, nil] := nil;
 inherited;
//#UC END# *49E4883E0176_53C3AC15027D_impl*
end;//TevdTaskFolderEliminator.DoWritePara

end.