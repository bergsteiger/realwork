unit nsEditionTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsEditionTree.pas"
// Начат: 2003/09/05 16:07:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::DocumentContainers::TnsEditionTree
//
// Дерево редакций документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  nsDataResetTree,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsEditionTree = class(TnsDataResetTree)
  {* Дерево редакций документа }
 private
 // private fields
   f_Document : IDocument;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure BeforeReset; override;
   function RegetRootNode: Il3RootNode; override;
 end;//TnsEditionTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsEditionNodes,
  SysUtils,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsEditionTree

procedure TnsEditionTree.Cleanup;
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

{$IfEnd} //not Admin AND not Monitorings

end.