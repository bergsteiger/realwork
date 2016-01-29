unit NOT_FINISHED_evdLeafParaFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/NOT_FINISHED_evdLeafParaFilter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdLeafParaFilter
//
// Класс, фильтрующий "листьевые" абзацы. Параметры фильтрации
// задаются методом TevdLeafParaFilter.ParaTypeForFiltering
// (если нужно фильтровать один тип) и TevdLeafParaFilter.NeedWritePara
// (если нужно фильтровать несколько типов или условие
// фильтрации меняется с течением времени). Запись
// отфильтрованного абзаца выполняется в методе TevdLeafParaFilter.DoWritePara,
// перекрывая который, можно вносить изменения в содержание
// абзаца
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base,
  k2TagFilter,
  l3Variant
  ;

type
 TevdLeafParaFilter = class(Tk2TagFilter)
  {* Класс, фильтрующий "листьевые" абзацы. Параметры фильтрации
 задаются методом TevdLeafParaFilter.ParaTypeForFiltering
(если нужно фильтровать один тип) и TevdLeafParaFilter.NeedWritePara
(если нужно фильтровать несколько типов или условие
фильтрации меняется с течением времени). Запись
отфильтрованного абзаца выполняется в методе TevdLeafParaFilter.DoWritePara,
перекрывая который, можно вносить изменения в содержание
абзаца }
 protected
 // protected methods
   function ParaTypeForFiltering: Tk2Type; virtual;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; virtual;
     {* Определяет нужно ли фильтровать переданный абзац }
   procedure DoWritePara(aLeaf: Tl3Variant); virtual;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevdLeafParaFilter

implementation

// start class TevdLeafParaFilter

function TevdLeafParaFilter.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_49E487650342_var*
//#UC END# *49E488070386_49E487650342_var*
begin
//#UC START# *49E488070386_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E488070386_49E487650342_impl*
end;//TevdLeafParaFilter.ParaTypeForFiltering

function TevdLeafParaFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_49E487650342_var*
//#UC END# *49E48829016F_49E487650342_var*
begin
//#UC START# *49E48829016F_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E48829016F_49E487650342_impl*
end;//TevdLeafParaFilter.NeedWritePara

procedure TevdLeafParaFilter.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_49E487650342_var*
//#UC END# *49E4883E0176_49E487650342_var*
begin
//#UC START# *49E4883E0176_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E4883E0176_49E487650342_impl*
end;//TevdLeafParaFilter.DoWritePara

end.