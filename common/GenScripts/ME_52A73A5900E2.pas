unit vcmOperationsManager;

// ������: "w:\common\components\gui\Garant\VCM\vcmOperationsManager.pas"
// ���������: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseEntitiesCollectionItem
 , vcmBaseOperationsCollectionItem
;

type
 IvcmOperationsRegistrar = interface
  ['{3E98A7F7-A01F-4D5A-8AB2-2C731A6E8CB5}']
  procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
   anOp: TvcmBaseOperationsCollectionItem);
 end;//IvcmOperationsRegistrar

 TvcmOperationsManager = class
  private
   f_Registrar: IvcmOperationsRegistrar;
    {* ���� ��� �������� Registrar }
  public
   procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
    anOp: TvcmBaseOperationsCollectionItem);
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TvcmOperationsManager;
    {* ����� ��������� ���������� ���������� TvcmOperationsManager }
  public
   property Registrar: IvcmOperationsRegistrar
    read f_Registrar
    write f_Registrar;
 end;//TvcmOperationsManager
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvcmOperationsManager: TvcmOperationsManager = nil;
 {* ��������� ���������� TvcmOperationsManager }

procedure TvcmOperationsManagerFree;
 {* ����� ������������ ���������� ���������� TvcmOperationsManager }
begin
 l3Free(g_TvcmOperationsManager);
end;//TvcmOperationsManagerFree

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
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmOperationsManager <> nil;
end;//TvcmOperationsManager.Exists

class function TvcmOperationsManager.Instance: TvcmOperationsManager;
 {* ����� ��������� ���������� ���������� TvcmOperationsManager }
begin
 if (g_TvcmOperationsManager = nil) then
 begin
  l3System.AddExitProc(TvcmOperationsManagerFree);
  g_TvcmOperationsManager := Create;
 end;
 Result := g_TvcmOperationsManager;
end;//TvcmOperationsManager.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
