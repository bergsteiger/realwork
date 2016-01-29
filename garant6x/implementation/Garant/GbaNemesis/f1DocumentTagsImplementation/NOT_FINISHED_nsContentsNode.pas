unit NOT_FINISHED_nsContentsNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/NOT_FINISHED_nsContentsNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsContentsNode
//
// Нода оглавления.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  k2Interfaces,
  l3TreeInterfaces,
  nsINodeWrapBase
  ;

type
 TnsContentsNode = class(TnsINodeWrapBase, Il3HandleNode)
  {* Нода оглавления. }
 private
 // private fields
   f_Document : Ik2Tag;
    {* Документ.}
 protected
 // realized methods
   function Get_Handle: Integer;
   procedure Set_Handle(aValue: Integer);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//TnsContentsNode

implementation

// start class TnsContentsNode

function TnsContentsNode.Get_Handle: Integer;
//#UC START# *46827CAF03CD_46827E69026Aget_var*
//#UC END# *46827CAF03CD_46827E69026Aget_var*
begin
//#UC START# *46827CAF03CD_46827E69026Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46827CAF03CD_46827E69026Aget_impl*
end;//TnsContentsNode.Get_Handle

procedure TnsContentsNode.Set_Handle(aValue: Integer);
//#UC START# *46827CAF03CD_46827E69026Aset_var*
//#UC END# *46827CAF03CD_46827E69026Aset_var*
begin
//#UC START# *46827CAF03CD_46827E69026Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46827CAF03CD_46827E69026Aset_impl*
end;//TnsContentsNode.Set_Handle

procedure TnsContentsNode.ClearFields;
 {-}
begin
 f_Document := nil;
 inherited;
end;//TnsContentsNode.ClearFields

end.