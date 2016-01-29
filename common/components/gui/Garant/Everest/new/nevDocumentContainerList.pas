unit nevDocumentContainerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevDocumentContainerList.pas"
// �����: 17.2011 15:25
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TnevDocumentContainerList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  k2Interfaces,
  nevDocumentContainerListPrim,
  afwInterfaces,
  k2Prim
  ;

type
 _afwApplicationDataUpdate_Parent_ = TnevDocumentContainerListPrim;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnevDocumentContainerList = class(_afwApplicationDataUpdate_, Ik2Listener)
 protected
 // realized methods
   procedure Fire(const anEvent: Tk2Event;
    const anOp: Ik2Op);
     {* ��������� � ���, ��� ���-�� ���������. }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: TnevDocumentContainerList;
    {- ���������� ��������� ����������. }
 end;//TnevDocumentContainerList

implementation

uses
  l3Base {a},
  k2Facade,
  afwFacade
  ;


// start class TnevDocumentContainerList

var g_TnevDocumentContainerList : TnevDocumentContainerList = nil;

procedure TnevDocumentContainerListFree;
begin
 l3Free(g_TnevDocumentContainerList);
end;

class function TnevDocumentContainerList.Instance: TnevDocumentContainerList;
begin
 if (g_TnevDocumentContainerList = nil) then
 begin
  l3System.AddExitProc(TnevDocumentContainerListFree);
  g_TnevDocumentContainerList := Create;
 end;
 Result := g_TnevDocumentContainerList;
end;


{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnevDocumentContainerList

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
//#UC START# *476144F90102_4DD25B17012A_var*
//#UC END# *476144F90102_4DD25B17012A_var*
begin
//#UC START# *476144F90102_4DD25B17012A_impl*
 if (anEvent.ID = k2_eidTypeTableWillBeDestroyed) then
  Clear;
//#UC END# *476144F90102_4DD25B17012A_impl*
end;//TnevDocumentContainerList.Fire

procedure TnevDocumentContainerList.Cleanup;
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