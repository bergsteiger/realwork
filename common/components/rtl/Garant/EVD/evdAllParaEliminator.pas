unit evdAllParaEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdAllParaEliminator.pas"
// Начат: 12.07.2011 14:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdAllParaEliminator
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
 TevdAllParaEliminator = class(TevdLeafParaFilter)
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdAllParaEliminator

implementation

uses
  Para_Const
  ;

// start class TevdAllParaEliminator

function TevdAllParaEliminator.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4E1C278402E2_var*
//#UC END# *49E488070386_4E1C278402E2_var*
begin
//#UC START# *49E488070386_4E1C278402E2_impl*
 Result := k2_typPara;
//#UC END# *49E488070386_4E1C278402E2_impl*
end;//TevdAllParaEliminator.ParaTypeForFiltering

function TevdAllParaEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_4E1C278402E2_var*
//#UC END# *49E48829016F_4E1C278402E2_var*
begin
//#UC START# *49E48829016F_4E1C278402E2_impl*
 Result := false;
//#UC END# *49E48829016F_4E1C278402E2_impl*
end;//TevdAllParaEliminator.NeedWritePara

end.