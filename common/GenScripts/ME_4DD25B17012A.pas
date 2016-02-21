unit nevDocumentContainerList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevDocumentContainerList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevDocumentContainerListPrim
 , k2Interfaces
 , k2Prim
 , afwInterfaces
;

type
 _afwApplicationDataUpdate_Parent_ = TnevDocumentContainerListPrim;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnevDocumentContainerList = class(_afwApplicationDataUpdate_, Ik2Listener)
  protected
   procedure Fire(const anEvent: Tk2Event;
    const anOp: Ik2Op);
    {* сообщение о том, что что-то произошло. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
  public
   class function Exists: Boolean;
   class function Instance: TnevDocumentContainerList;
    {* Метод получения экземпляра синглетона TnevDocumentContainerList }
 end;//TnevDocumentContainerList

implementation

uses
 l3ImplUses
 , k2Facade
 , afwFacade
 , nevTools
 , l3Memory
 , SysUtils
 , l3Base
;

var g_TnevDocumentContainerList: TnevDocumentContainerList = nil;
 {* Экземпляр синглетона TnevDocumentContainerList }

procedure TnevDocumentContainerListFree;
 {* Метод освобождения экземпляра синглетона TnevDocumentContainerList }
begin
 l3Free(g_TnevDocumentContainerList);
end;//TnevDocumentContainerListFree

{$If not Declared(_ItemType_)}type _ItemType_ = InevDocumentContainer;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

class function TnevDocumentContainerList.Exists: Boolean;
//#UC START# *4DD26253028D_4DD25B17012A_var*
//#UC END# *4DD26253028D_4DD25B17012A_var*
begin
//#UC START# *4DD26253028D_4DD25B17012A_impl*
 Result := (g_TnevDocumentContainerList <> nil);
//#UC END# *4DD26253028D_4DD25B17012A_impl*
end;//TnevDocumentContainerList.Exists

procedure TnevDocumentContainerList.Fire(const anEvent: Tk2Event;
 const anOp: Ik2Op);
 {* сообщение о том, что что-то произошло. }
//#UC START# *476144F90102_4DD25B17012A_var*
//#UC END# *476144F90102_4DD25B17012A_var*
begin
//#UC START# *476144F90102_4DD25B17012A_impl*
 if (anEvent.ID = k2_eidTypeTableWillBeDestroyed) then
  Clear;
//#UC END# *476144F90102_4DD25B17012A_impl*
end;//TnevDocumentContainerList.Fire

class function TnevDocumentContainerList.Instance: TnevDocumentContainerList;
 {* Метод получения экземпляра синглетона TnevDocumentContainerList }
begin
 if (g_TnevDocumentContainerList = nil) then
 begin
  l3System.AddExitProc(TnevDocumentContainerListFree);
  g_TnevDocumentContainerList := Create;
 end;
 Result := g_TnevDocumentContainerList;
end;//TnevDocumentContainerList.Instance

procedure TnevDocumentContainerList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DD25B17012A_var*
//#UC END# *479731C50290_4DD25B17012A_var*
begin
//#UC START# *479731C50290_4DD25B17012A_impl*
 inherited;
 k2.RemoveListener(Self);
//#UC END# *479731C50290_4DD25B17012A_impl*
end;//TnevDocumentContainerList.Cleanup

procedure TnevDocumentContainerList.InitFields;
//#UC START# *47A042E100E2_4DD25B17012A_var*
//#UC END# *47A042E100E2_4DD25B17012A_var*
begin
//#UC START# *47A042E100E2_4DD25B17012A_impl*
 k2.AddListener(Self);
 inherited;
//#UC END# *47A042E100E2_4DD25B17012A_impl*
end;//TnevDocumentContainerList.InitFields

procedure TnevDocumentContainerList.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4DD25B17012A_var*
//#UC END# *47EA4E9002C6_4DD25B17012A_var*
begin
//#UC START# *47EA4E9002C6_4DD25B17012A_impl*
 Clear;
//#UC END# *47EA4E9002C6_4DD25B17012A_impl*
end;//TnevDocumentContainerList.FinishDataUpdate

end.
