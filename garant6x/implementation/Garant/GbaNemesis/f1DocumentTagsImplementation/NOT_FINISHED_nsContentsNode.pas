unit NOT_FINISHED_nsContentsNode;
 {* Нода оглавления. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\NOT_FINISHED_nsContentsNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsContentsNode" MUID: (46827E69026A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsINodeWrapBase
 , l3TreeInterfaces
 , k2Interfaces
;

type
 TnsContentsNode = class(TnsINodeWrapBase, Il3HandleNode)
  {* Нода оглавления. }
  private
   f_Document: Ik2Tag;
    {* Документ. }
  protected
   function Get_Handle: Integer;
   procedure Set_Handle(aValue: Integer);
   procedure ClearFields; override;
 end;//TnsContentsNode

implementation

uses
 l3ImplUses
 //#UC START# *46827E69026Aimpl_uses*
 //#UC END# *46827E69026Aimpl_uses*
;

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
begin
 f_Document := nil;
 inherited;
end;//TnsContentsNode.ClearFields

end.
