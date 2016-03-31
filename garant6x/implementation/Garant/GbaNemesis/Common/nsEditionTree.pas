unit nsEditionTree;
 {* Дерево редакций документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsEditionTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsEditionTree" MUID: (4909F77F0154)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTree
 , DocumentUnit
 , l3Tree_TLB
;

type
 TnsEditionTree = class(TnsDataResetTree)
  {* Дерево редакций документа }
  private
   f_Document: IDocument;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BeforeReset; override;
   function RegetRootNode: Il3RootNode; override;
 end;//TnsEditionTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsEditionNodes
 , SysUtils
 , nsTypes
;

procedure TnsEditionTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4909F77F0154_var*
//#UC END# *479731C50290_4909F77F0154_var*
begin
//#UC START# *479731C50290_4909F77F0154_impl*
 f_Document := nil;

 inherited;
//#UC END# *479731C50290_4909F77F0154_impl*
end;//TnsEditionTree.Cleanup

procedure TnsEditionTree.BeforeReset;
//#UC START# *4908AAED02BD_4909F77F0154_var*
//#UC END# *4908AAED02BD_4909F77F0154_var*
begin
//#UC START# *4908AAED02BD_4909F77F0154_impl*
 inherited;

 Supports(fRootNode, IDocument, f_Document);
 if (f_Document <> nil) and
    not f_Document.IsAlive then
  f_Document := nil;
//#UC END# *4908AAED02BD_4909F77F0154_impl*
end;//TnsEditionTree.BeforeReset

function TnsEditionTree.RegetRootNode: Il3RootNode;
//#UC START# *4908AB070319_4909F77F0154_var*
//#UC END# *4908AB070319_4909F77F0154_var*
begin
//#UC START# *4908AB070319_4909F77F0154_impl*
 if (f_Document <> nil) then
  case BeenReseted of
   rtsRoot :
    begin
     RootNode := TnsEditionsRoot.Make(f_Document) as Il3RootNode;
     Result := fRootNode;
    end;
   else
    Result := inherited RegetRootNode;
  end
 else
  Result := inherited RegetRootNode;
//#UC END# *4908AB070319_4909F77F0154_impl*
end;//TnsEditionTree.RegetRootNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
