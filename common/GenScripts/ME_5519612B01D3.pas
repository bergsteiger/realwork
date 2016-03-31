unit IterateableServiceProvider;

// ������: "w:\common\components\SandBox\IterateableServiceProvider.pas"
// ���������: "SimpleClass"
// ������� ������: "TIterateableServiceProvider" MUID: (5519612B01D3)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , IterateableService
 , Classes
;

type
 TIterateableServiceImpl = {final} class(Tl3ProtoObject, IIterateableService)
  public
   procedure IterateF(anAction: MIterateableService_IterateF_Action;
    anOwner: TComponent);
   class function Instance: TIterateableServiceImpl;
    {* ����� ��������� ���������� ���������� TIterateableServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TIterateableServiceImpl

 TIterateableServiceProvider = class
 end;//TIterateableServiceProvider

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TIterateableServiceImpl: TIterateableServiceImpl = nil;
 {* ��������� ���������� TIterateableServiceImpl }

procedure TIterateableServiceImplFree;
 {* ����� ������������ ���������� ���������� TIterateableServiceImpl }
begin
 l3Free(g_TIterateableServiceImpl);
end;//TIterateableServiceImplFree

procedure TIterateableServiceImpl.IterateF(anAction: MIterateableService_IterateF_Action;
 anOwner: TComponent);
//#UC START# *A44911B9A95D_551961470035_var*
var
 Hack : Pointer absolute anAction;
 l_Index : Integer;
//#UC END# *A44911B9A95D_551961470035_var*
begin
//#UC START# *A44911B9A95D_551961470035_impl*
 try
  if (anOwner <> nil) then
   for l_Index := 0 to Pred(anOwner.ComponentCount) do
    anAction(anOwner.Components[l_Index]);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *A44911B9A95D_551961470035_impl*
end;//TIterateableServiceImpl.IterateF

class function TIterateableServiceImpl.Instance: TIterateableServiceImpl;
 {* ����� ��������� ���������� ���������� TIterateableServiceImpl }
begin
 if (g_TIterateableServiceImpl = nil) then
 begin
  l3System.AddExitProc(TIterateableServiceImplFree);
  g_TIterateableServiceImpl := Create;
 end;
 Result := g_TIterateableServiceImpl;
end;//TIterateableServiceImpl.Instance

class function TIterateableServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TIterateableServiceImpl <> nil;
end;//TIterateableServiceImpl.Exists

initialization
 TIterateableService.Instance.Alien := TIterateableServiceImpl.Instance;
 {* ����������� TIterateableServiceImpl }

end.
