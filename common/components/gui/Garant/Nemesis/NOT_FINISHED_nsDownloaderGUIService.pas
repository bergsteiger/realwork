unit NOT_FINISHED_nsDownloaderGUIService;

// ������: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nsDownloaderGUIService.pas"
// ���������: "Service"
// ������� ������: "TnsDownloaderGUIService" MUID: (57BC05FD03A1)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , nsDownloaderInterfaces
;

 (*
 MnsDownloaderGUIService = interface
  {* �������� ������� TnsDownloaderGUIService }
  function EditParams(const aParams: InsDownloadParams): Boolean;
 end;//MnsDownloaderGUIService
 *)

type
 InsDownloaderGUIService = interface
  {* ��������� ������� TnsDownloaderGUIService }
  function EditParams(const aParams: InsDownloadParams): Boolean;
 end;//InsDownloaderGUIService

 TnsDownloaderGUIService = {final} class(Tl3ProtoObject)
  private
   f_Alien: InsDownloaderGUIService;
    {* ������� ���������� ������� InsDownloaderGUIService }
  protected
   procedure pm_SetAlien(const aValue: InsDownloaderGUIService);
   procedure ClearFields; override;
  public
   function EditParams(const aParams: InsDownloadParams): Boolean;
   class function Instance: TnsDownloaderGUIService;
    {* ����� ��������� ���������� ���������� TnsDownloaderGUIService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: InsDownloaderGUIService
    write pm_SetAlien;
    {* ������� ���������� ������� InsDownloaderGUIService }
 end;//TnsDownloaderGUIService
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nsOpenOrSaveInternetFileDialog
 , SysUtils
 , l3Base
 //#UC START# *57BC05FD03A1impl_uses*
 //#UC END# *57BC05FD03A1impl_uses*
;

var g_TnsDownloaderGUIService: TnsDownloaderGUIService = nil;
 {* ��������� ���������� TnsDownloaderGUIService }

procedure TnsDownloaderGUIServiceFree;
 {* ����� ������������ ���������� ���������� TnsDownloaderGUIService }
begin
 l3Free(g_TnsDownloaderGUIService);
end;//TnsDownloaderGUIServiceFree

procedure TnsDownloaderGUIService.pm_SetAlien(const aValue: InsDownloaderGUIService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TnsDownloaderGUIService.pm_SetAlien

function TnsDownloaderGUIService.EditParams(const aParams: InsDownloadParams): Boolean;
//#UC START# *A56660AF8F69_57BC05FD03A1_var*
//#UC END# *A56660AF8F69_57BC05FD03A1_var*
begin
//#UC START# *A56660AF8F69_57BC05FD03A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *A56660AF8F69_57BC05FD03A1_impl*
end;//TnsDownloaderGUIService.EditParams

class function TnsDownloaderGUIService.Instance: TnsDownloaderGUIService;
 {* ����� ��������� ���������� ���������� TnsDownloaderGUIService }
begin
 if (g_TnsDownloaderGUIService = nil) then
 begin
  l3System.AddExitProc(TnsDownloaderGUIServiceFree);
  g_TnsDownloaderGUIService := Create;
 end;
 Result := g_TnsDownloaderGUIService;
end;//TnsDownloaderGUIService.Instance

class function TnsDownloaderGUIService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsDownloaderGUIService <> nil;
end;//TnsDownloaderGUIService.Exists

procedure TnsDownloaderGUIService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TnsDownloaderGUIService.ClearFields
{$IfEnd} // Defined(Nemesis)

end.
