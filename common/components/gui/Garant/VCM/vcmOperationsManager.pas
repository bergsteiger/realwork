unit vcmOperationsManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/vcmOperationsManager.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Operations::TvcmOperationsManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmBaseOperationsCollectionItem,
  vcmBaseEntitiesCollectionItem
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 IvcmOperationsRegistrar = interface(IUnknown)
   ['{3E98A7F7-A01F-4D5A-8AB2-2C731A6E8CB5}']
   procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
     anOp: TvcmBaseOperationsCollectionItem);
 end;//IvcmOperationsRegistrar

 TvcmOperationsManager = class
 private
 // private fields
   f_Registrar : IvcmOperationsRegistrar;
    {* ���� ��� �������� Registrar}
 public
 // public methods
   procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
     anOp: TvcmBaseOperationsCollectionItem);
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // public properties
   property Registrar: IvcmOperationsRegistrar
     read f_Registrar
     write f_Registrar;
 public
 // singleton factory method
   class function Instance: TvcmOperationsManager;
    {- ���������� ��������� ����������. }
 end;//TvcmOperationsManager
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TvcmOperationsManager

var g_TvcmOperationsManager : TvcmOperationsManager = nil;

procedure TvcmOperationsManagerFree;
begin
 l3Free(g_TvcmOperationsManager);
end;

class function TvcmOperationsManager.Instance: TvcmOperationsManager;
begin
 if (g_TvcmOperationsManager = nil) then
 begin
  l3System.AddExitProc(TvcmOperationsManagerFree);
  g_TvcmOperationsManager := Create;
 end;
 Result := g_TvcmOperationsManager;
end;


procedure TvcmOperationsManager.Register(anEn: TvcmBaseEntitiesCollectionItem;
  anOp: TvcmBaseOperationsCollectionItem);
//#UC START# *52A73ABA0304_52A73A5900E2_var*
//#UC END# *52A73ABA0304_52A73A5900E2_var*
begin
//#UC START# *52A73ABA0304_52A73A5900E2_impl*
 Assert(f_Registrar <> nil);
 f_Registrar.Register(anEn, anOp);
//#UC END# *52A73ABA0304_52A73A5900E2_impl*
end;//TvcmOperationsManager.Register

class function TvcmOperationsManager.Exists: Boolean;
 {-}
begin
 Result := g_TvcmOperationsManager <> nil;
end;//TvcmOperationsManager.Exists

{$IfEnd} //not NoVCM

end.