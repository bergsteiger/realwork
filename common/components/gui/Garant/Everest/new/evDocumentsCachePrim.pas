unit evDocumentsCachePrim;

// ������: "w:\common\components\gui\Garant\Everest\new\evDocumentsCachePrim.pas"
// ���������: "SimpleClass"
// ������� ������: "TevDocumentsCachePrim" MUID: (5506FEE90052)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3DocumentsCacheService
;

type
 TevDocumentsCacheService = {final} class(Tl3ProtoObject, Il3DocumentsCacheService)
  public
   procedure Clear;
   class function Instance: TevDocumentsCacheService;
    {* ����� ��������� ���������� ���������� TevDocumentsCacheService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TevDocumentsCacheService

 TevDocumentsCachePrim = class
 end;//TevDocumentsCachePrim

implementation

uses
 l3ImplUses
 , evDocumentsCache
 , SysUtils
 , l3Base
 //#UC START# *5506FEE90052impl_uses*
 //#UC END# *5506FEE90052impl_uses*
;

var g_TevDocumentsCacheService: TevDocumentsCacheService = nil;
 {* ��������� ���������� TevDocumentsCacheService }

procedure TevDocumentsCacheServiceFree;
 {* ����� ������������ ���������� ���������� TevDocumentsCacheService }
begin
 l3Free(g_TevDocumentsCacheService);
end;//TevDocumentsCacheServiceFree

procedure TevDocumentsCacheService.Clear;
//#UC START# *5506FEB701D1_5506FF1A0056_var*
//#UC END# *5506FEB701D1_5506FF1A0056_var*
begin
//#UC START# *5506FEB701D1_5506FF1A0056_impl*
 TevDocumentsCache.Clear;
//#UC END# *5506FEB701D1_5506FF1A0056_impl*
end;//TevDocumentsCacheService.Clear

class function TevDocumentsCacheService.Instance: TevDocumentsCacheService;
 {* ����� ��������� ���������� ���������� TevDocumentsCacheService }
begin
 if (g_TevDocumentsCacheService = nil) then
 begin
  l3System.AddExitProc(TevDocumentsCacheServiceFree);
  g_TevDocumentsCacheService := Create;
 end;
 Result := g_TevDocumentsCacheService;
end;//TevDocumentsCacheService.Instance

class function TevDocumentsCacheService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TevDocumentsCacheService <> nil;
end;//TevDocumentsCacheService.Exists

initialization
 Tl3DocumentsCacheService.Instance.Alien := TevDocumentsCacheService.Instance;
 {* ����������� TevDocumentsCacheService }

end.
