unit nsBaseSearchService;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchService.pas"
// ���������: "Service"
// ������� ������: "TnsBaseSearchService" MUID: (563875050317)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoObject
 , BaseSearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MnsBaseSearchService = interface
  {* �������� ������� TnsBaseSearchService }
  function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
  procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
  procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
 end;//MnsBaseSearchService
 *)

type
 InsBaseSearchService = interface
  {* ��������� ������� TnsBaseSearchService }
  ['{40B734EB-B07C-49D2-B51A-EC2A0B80C837}']
  function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
  procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
  procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
 end;//InsBaseSearchService

 TnsBaseSearchService = {final} class(Tl3ProtoObject)
  private
   f_Alien: InsBaseSearchService;
    {* ���� ��� �������� Alien }
  protected
   procedure pm_SetAlien(const aValue: InsBaseSearchService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
   procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   class function Instance: TnsBaseSearchService;
    {* ����� ��������� ���������� ���������� TnsBaseSearchService }
  public
   property Alien: InsBaseSearchService
    write pm_SetAlien;
    {* ������� ���������� ������� InsBaseSearchService }
 end;//TnsBaseSearchService
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsBaseSearchService: TnsBaseSearchService = nil;
 {* ��������� ���������� TnsBaseSearchService }

procedure TnsBaseSearchServiceFree;
 {* ����� ������������ ���������� ���������� TnsBaseSearchService }
begin
 l3Free(g_TnsBaseSearchService);
end;//TnsBaseSearchServiceFree

procedure TnsBaseSearchService.pm_SetAlien(const aValue: InsBaseSearchService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TnsBaseSearchService.pm_SetAlien

class function TnsBaseSearchService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsBaseSearchService <> nil;
end;//TnsBaseSearchService.Exists

function TnsBaseSearchService.GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
//#UC START# *4923CA8F0CFB_563875050317_var*
//#UC END# *4923CA8F0CFB_563875050317_var*
begin
//#UC START# *4923CA8F0CFB_563875050317_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetBaseSearcher(aEntityForm)
 else
  Assert(False);
//#UC END# *4923CA8F0CFB_563875050317_impl*
end;//TnsBaseSearchService.GetBaseSearcher

procedure TnsBaseSearchService.RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
 const aProvider: InsBaseSearcherProvider);
//#UC START# *B86FD3ED4532_563875050317_var*
//#UC END# *B86FD3ED4532_563875050317_var*
begin
//#UC START# *B86FD3ED4532_563875050317_impl*
 if (f_Alien <> nil) then
  f_Alien.RegisterBaseSearcherProvider(aContainer, aProvider)
 else
  Assert(False);
//#UC END# *B86FD3ED4532_563875050317_impl*
end;//TnsBaseSearchService.RegisterBaseSearcherProvider

procedure TnsBaseSearchService.UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
 const aProvider: InsBaseSearcherProvider);
//#UC START# *CB784FFDCCE4_563875050317_var*
//#UC END# *CB784FFDCCE4_563875050317_var*
begin
//#UC START# *CB784FFDCCE4_563875050317_impl*
 if (f_Alien <> nil) then
  f_Alien.UnregisterBaseSearcherProvider(aContainer, aProvider)
 else
  Assert(False);
//#UC END# *CB784FFDCCE4_563875050317_impl*
end;//TnsBaseSearchService.UnregisterBaseSearcherProvider

class function TnsBaseSearchService.Instance: TnsBaseSearchService;
 {* ����� ��������� ���������� ���������� TnsBaseSearchService }
begin
 if (g_TnsBaseSearchService = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchServiceFree);
  g_TnsBaseSearchService := Create;
 end;
 Result := g_TnsBaseSearchService;
end;//TnsBaseSearchService.Instance

procedure TnsBaseSearchService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TnsBaseSearchService.ClearFields
{$IfEnd} // NOT Defined(Admin)

end.
