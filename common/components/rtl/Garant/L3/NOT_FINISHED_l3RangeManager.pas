unit NOT_FINISHED_l3RangeManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Жучков А.Ю.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3RangeManager.pas"
// Начат: 2004/01/08 14:34:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Misc::Tl3RangeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3CProtoObject
  ;

type
 Tl3RangeManager = class(Tl3CProtoObject, Il3RangeManager)
 protected
 // realized methods
   function HasPage(anIndex: Integer): Boolean;
     {* содержит ли диапазон указанную страницу. }
   function Get_Count: Integer;
   function Get_Pages(anIndex: Integer): Integer;
   function Get_IndexOfPage(Page: Integer): Integer;
 end;//Tl3RangeManager

implementation

// start class Tl3RangeManager

function Tl3RangeManager.HasPage(anIndex: Integer): Boolean;
//#UC START# *46A45DA20336_4B9FBF5A021A_var*
//#UC END# *46A45DA20336_4B9FBF5A021A_var*
begin
//#UC START# *46A45DA20336_4B9FBF5A021A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DA20336_4B9FBF5A021A_impl*
end;//Tl3RangeManager.HasPage

function Tl3RangeManager.Get_Count: Integer;
//#UC START# *46A45DC20057_4B9FBF5A021Aget_var*
//#UC END# *46A45DC20057_4B9FBF5A021Aget_var*
begin
//#UC START# *46A45DC20057_4B9FBF5A021Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DC20057_4B9FBF5A021Aget_impl*
end;//Tl3RangeManager.Get_Count

function Tl3RangeManager.Get_Pages(anIndex: Integer): Integer;
//#UC START# *46A45DE80156_4B9FBF5A021Aget_var*
//#UC END# *46A45DE80156_4B9FBF5A021Aget_var*
begin
//#UC START# *46A45DE80156_4B9FBF5A021Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DE80156_4B9FBF5A021Aget_impl*
end;//Tl3RangeManager.Get_Pages

function Tl3RangeManager.Get_IndexOfPage(Page: Integer): Integer;
//#UC START# *46A45EB10245_4B9FBF5A021Aget_var*
//#UC END# *46A45EB10245_4B9FBF5A021Aget_var*
begin
//#UC START# *46A45EB10245_4B9FBF5A021Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45EB10245_4B9FBF5A021Aget_impl*
end;//Tl3RangeManager.Get_IndexOfPage

end.