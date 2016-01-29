unit NOT_FINISHED_k2TagFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/NOT_FINISHED_k2TagFilter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::Generators::Tk2TagFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base,
  k2TagTerminator,
  l3Variant
  ;

type
 Tk2TagFilterOpenMode = (
   
 );//Tk2TagFilterOpenMode

 Tk2TagFilter = class(Tk2TagTerminator)
 protected
 // protected methods
   function NeedTranslateChildToNextPrim(anOpenMode: Tk2TagFilterOpenMode): Boolean; virtual;
   procedure DoCloseStructure(NeedUndo: Boolean); virtual;
   procedure DoStartChild(TypeID: Tk2Type); virtual;
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); virtual;
   function NeedTranslateChildToNext: Boolean; virtual;
 end;//Tk2TagFilter

implementation

// start class Tk2TagFilter

function Tk2TagFilter.NeedTranslateChildToNextPrim(anOpenMode: Tk2TagFilterOpenMode): Boolean;
//#UC START# *4E15CBD5018B_49E487A70144_var*
//#UC END# *4E15CBD5018B_49E487A70144_var*
begin
//#UC START# *4E15CBD5018B_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E15CBD5018B_49E487A70144_impl*
end;//Tk2TagFilter.NeedTranslateChildToNextPrim

procedure Tk2TagFilter.DoCloseStructure(NeedUndo: Boolean);
//#UC START# *4E45166B0156_49E487A70144_var*
//#UC END# *4E45166B0156_49E487A70144_var*
begin
//#UC START# *4E45166B0156_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E45166B0156_49E487A70144_impl*
end;//Tk2TagFilter.DoCloseStructure

procedure Tk2TagFilter.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_49E487A70144_var*
//#UC END# *4A2D1217037A_49E487A70144_var*
begin
//#UC START# *4A2D1217037A_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A2D1217037A_49E487A70144_impl*
end;//Tk2TagFilter.DoStartChild

procedure Tk2TagFilter.DoAddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4A2D1634025B_49E487A70144_var*
//#UC END# *4A2D1634025B_49E487A70144_var*
begin
//#UC START# *4A2D1634025B_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A2D1634025B_49E487A70144_impl*
end;//Tk2TagFilter.DoAddAtomEx

function Tk2TagFilter.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_49E487A70144_var*
//#UC END# *4CA3006302BC_49E487A70144_var*
begin
//#UC START# *4CA3006302BC_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA3006302BC_49E487A70144_impl*
end;//Tk2TagFilter.NeedTranslateChildToNext

end.