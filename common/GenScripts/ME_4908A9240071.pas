unit nsDataResetTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsDataResetTree.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3Tree
 , nsTypes
 , l3Tree_TLB
 , afwInterfaces
;

type
 _afwApplicationDataUpdate_Parent_ = Tl3Tree;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsDataResetTree = class(_afwApplicationDataUpdate_)
  private
   f_InGetRoot: Boolean;
   f_BeenReseted: TnsResetTreeStatus;
    {* Поле для свойства BeenReseted }
  protected
   procedure BeforeReset; virtual;
   procedure AfterReget; virtual;
   function RegetRootNode: Il3RootNode; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   function Get_CRootNode: Il3RootNode; override;
  public
   property BeenReseted: TnsResetTreeStatus
    read f_BeenReseted;
 end;//TnsDataResetTree

implementation

uses
 l3ImplUses
 , afwFacade
;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

procedure TnsDataResetTree.BeforeReset;
//#UC START# *4908AAED02BD_4908A9240071_var*
//#UC END# *4908AAED02BD_4908A9240071_var*
begin
//#UC START# *4908AAED02BD_4908A9240071_impl*
 if fRootNode <> nil then
  f_BeenReseted := rtsRoot
 else
  f_BeenReseted := rtsNone;
//#UC END# *4908AAED02BD_4908A9240071_impl*
end;//TnsDataResetTree.BeforeReset

procedure TnsDataResetTree.AfterReget;
//#UC START# *4908AAF6015C_4908A9240071_var*
//#UC END# *4908AAF6015C_4908A9240071_var*
begin
//#UC START# *4908AAF6015C_4908A9240071_impl*
 ;
//#UC END# *4908AAF6015C_4908A9240071_impl*
end;//TnsDataResetTree.AfterReget

function TnsDataResetTree.RegetRootNode: Il3RootNode;
//#UC START# *4908AB070319_4908A9240071_var*
//#UC END# *4908AB070319_4908A9240071_var*
begin
//#UC START# *4908AB070319_4908A9240071_impl*
 Result := inherited Get_CRootNode;
//#UC END# *4908AB070319_4908A9240071_impl*
end;//TnsDataResetTree.RegetRootNode

procedure TnsDataResetTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4908A9240071_var*
//#UC END# *479731C50290_4908A9240071_var*
begin
//#UC START# *479731C50290_4908A9240071_impl*
 f_BeenReseted := rtsNone;
 f_InGetRoot := False;

 inherited;
//#UC END# *479731C50290_4908A9240071_impl*
end;//TnsDataResetTree.Cleanup

procedure TnsDataResetTree.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4908A9240071_var*
//#UC END# *47EA4E9002C6_4908A9240071_var*
begin
//#UC START# *47EA4E9002C6_4908A9240071_impl*
 inherited;
 Changing;
 try
  if fRootNode <> nil then
  begin
   BeforeReset;
   RootNode := nil;
  end;//if fRootNode <> nil then
 finally
  Changed;
 end;//try..finally
//#UC END# *47EA4E9002C6_4908A9240071_impl*
end;//TnsDataResetTree.FinishDataUpdate

function TnsDataResetTree.Get_CRootNode: Il3RootNode;
//#UC START# *4FFC1D0502D0_4908A9240071_var*
//#UC END# *4FFC1D0502D0_4908A9240071_var*
begin
//#UC START# *4FFC1D0502D0_4908A9240071_impl*
 if f_InGetRoot then
 begin
  Result := nil;
  Exit;
 end;

 if (f_BeenReseted <> rtsNone) and
    (fRootNode = nil) then
 begin
  f_InGetRoot := True;
  Changing;
  try
   Result := RegetRootNode;
  finally
   f_InGetRoot := False;
   Changed;
   f_BeenReseted := rtsNone;
   AfterReget;
  end;
 end
 else
  Result := inherited Get_CRootNode;
//#UC END# *4FFC1D0502D0_4908A9240071_impl*
end;//TnsDataResetTree.Get_CRootNode

end.
