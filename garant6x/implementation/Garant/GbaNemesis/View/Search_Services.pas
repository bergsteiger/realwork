unit Search_Services;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search_Services.pas"
// ���������: "VCMContracts"
// ������� ������: "Services" MUID: (57A2E803024D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , SearchUnit
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ConfigInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MCommonPostService = interface
  {* �������� ������� TCommonPostService }
  function CanSavePostList: Boolean;
   {* ����� �� ��������� �������������� ����� � ���� }
  procedure CheckHistory;
   {* ������� ������������ �� �������, ���� ������� ����� ���������������� ��������� }
  procedure SavePostList;
   {* ��������� �������������� ����� � ���� }
  procedure SavePostingList;
  function OpenPostingOrder(const aQuery: IQuery;
   const aContainer: IvcmContainer = nil): IvcmEntityForm;
  function StartOpen(const aContainer: IvcmContainer;
   aNewTab: Boolean): IvcmEntityForm;
 end;//MCommonPostService
 *)

type
 ICommonPostService = interface
  {* ��������� ������� TCommonPostService }
  function CanSavePostList: Boolean;
   {* ����� �� ��������� �������������� ����� � ���� }
  procedure CheckHistory;
   {* ������� ������������ �� �������, ���� ������� ����� ���������������� ��������� }
  procedure SavePostList;
   {* ��������� �������������� ����� � ���� }
  procedure SavePostingList;
  function OpenPostingOrder(const aQuery: IQuery;
   const aContainer: IvcmContainer = nil): IvcmEntityForm;
  function StartOpen(const aContainer: IvcmContainer;
   aNewTab: Boolean): IvcmEntityForm;
 end;//ICommonPostService

 TCommonPostService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ICommonPostService;
    {* ������� ���������� ������� ICommonPostService }
  protected
   procedure pm_SetAlien(const aValue: ICommonPostService);
   procedure ClearFields; override;
  public
   function CanSavePostList: Boolean;
    {* ����� �� ��������� �������������� ����� � ���� }
   procedure CheckHistory;
    {* ������� ������������ �� �������, ���� ������� ����� ���������������� ��������� }
   procedure SavePostList;
    {* ��������� �������������� ����� � ���� }
   procedure SavePostingList;
   function OpenPostingOrder(const aQuery: IQuery;
    const aContainer: IvcmContainer = nil): IvcmEntityForm;
   function StartOpen(const aContainer: IvcmContainer;
    aNewTab: Boolean): IvcmEntityForm;
   class function Instance: TCommonPostService;
    {* ����� ��������� ���������� ���������� TCommonPostService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ICommonPostService
    write pm_SetAlien;
    {* ������� ���������� ������� ICommonPostService }
 end;//TCommonPostService

 (*
 MCommonSearchService = interface
  {* �������� ������� TCommonSearchService }
  function MakeSaveLoadForm(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
  function MakeQueryCardForm(aFilter: Boolean;
   const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
 end;//MCommonSearchService
 *)

 ICommonSearchService = interface
  {* ��������� ������� TCommonSearchService }
  function MakeSaveLoadForm(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
  function MakeQueryCardForm(aFilter: Boolean;
   const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
 end;//ICommonSearchService

 TCommonSearchService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ICommonSearchService;
    {* ������� ���������� ������� ICommonSearchService }
  protected
   procedure pm_SetAlien(const aValue: ICommonSearchService);
   procedure ClearFields; override;
  public
   function MakeSaveLoadForm(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   function MakeQueryCardForm(aFilter: Boolean;
    const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   class function Instance: TCommonSearchService;
    {* ����� ��������� ���������� ���������� TCommonSearchService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ICommonSearchService
    write pm_SetAlien;
    {* ������� ���������� ������� ICommonSearchService }
 end;//TCommonSearchService

 (*
 MPrintingService = interface
  {* �������� ������� TPrintingService }
  function MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
  function MakePageSetup(const aData: InsPageSettingsInfo): Integer;
  function MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
 end;//MPrintingService
 *)

 IPrintingService = interface
  {* ��������� ������� TPrintingService }
  function MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
  function MakePageSetup(const aData: InsPageSettingsInfo): Integer;
  function MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
 end;//IPrintingService

 TPrintingService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IPrintingService;
    {* ������� ���������� ������� IPrintingService }
  protected
   procedure pm_SetAlien(const aValue: IPrintingService);
   procedure ClearFields; override;
  public
   function MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
   function MakePageSetup(const aData: InsPageSettingsInfo): Integer;
   function MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
   class function Instance: TPrintingService;
    {* ����� ��������� ���������� ���������� TPrintingService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IPrintingService
    write pm_SetAlien;
    {* ������� ���������� ������� IPrintingService }
 end;//TPrintingService

var mod_opcode_CommonPostService_SavePostList: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_TCommonPostService: TCommonPostService = nil;
 {* ��������� ���������� TCommonPostService }
var g_TCommonSearchService: TCommonSearchService = nil;
 {* ��������� ���������� TCommonSearchService }
var g_TPrintingService: TPrintingService = nil;
 {* ��������� ���������� TPrintingService }

procedure TCommonPostServiceFree;
 {* ����� ������������ ���������� ���������� TCommonPostService }
begin
 l3Free(g_TCommonPostService);
end;//TCommonPostServiceFree

procedure TCommonSearchServiceFree;
 {* ����� ������������ ���������� ���������� TCommonSearchService }
begin
 l3Free(g_TCommonSearchService);
end;//TCommonSearchServiceFree

procedure TPrintingServiceFree;
 {* ����� ������������ ���������� ���������� TPrintingService }
begin
 l3Free(g_TPrintingService);
end;//TPrintingServiceFree

procedure TCommonPostService.pm_SetAlien(const aValue: ICommonPostService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TCommonPostService.pm_SetAlien

function TCommonPostService.CanSavePostList: Boolean;
 {* ����� �� ��������� �������������� ����� � ���� }
begin
 if (f_Alien <> nil) then
  Result := f_Alien.CanSavePostList
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonPostService.CanSavePostList

procedure TCommonPostService.CheckHistory;
 {* ������� ������������ �� �������, ���� ������� ����� ���������������� ��������� }
begin
 if (f_Alien <> nil) then
  f_Alien.CheckHistory;
end;//TCommonPostService.CheckHistory

procedure TCommonPostService.SavePostList;
 {* ��������� �������������� ����� � ���� }
begin
 if (f_Alien <> nil) then
  f_Alien.SavePostList;
end;//TCommonPostService.SavePostList

procedure TCommonPostService.SavePostingList;
begin
 if (f_Alien <> nil) then
  f_Alien.SavePostingList;
end;//TCommonPostService.SavePostingList

function TCommonPostService.OpenPostingOrder(const aQuery: IQuery;
 const aContainer: IvcmContainer = nil): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenPostingOrder(aQuery, aContainer)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonPostService.OpenPostingOrder

function TCommonPostService.StartOpen(const aContainer: IvcmContainer;
 aNewTab: Boolean): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.StartOpen(aContainer, aNewTab)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonPostService.StartOpen

class function TCommonPostService.Instance: TCommonPostService;
 {* ����� ��������� ���������� ���������� TCommonPostService }
begin
 if (g_TCommonPostService = nil) then
 begin
  l3System.AddExitProc(TCommonPostServiceFree);
  g_TCommonPostService := Create;
 end;
 Result := g_TCommonPostService;
end;//TCommonPostService.Instance

class function TCommonPostService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TCommonPostService <> nil;
end;//TCommonPostService.Exists

procedure TCommonPostService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TCommonPostService.ClearFields

procedure TCommonSearchService.pm_SetAlien(const aValue: ICommonSearchService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TCommonSearchService.pm_SetAlien

function TCommonSearchService.MakeSaveLoadForm(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeSaveLoadForm(aParams, aZoneType, aRecursive, aUserType)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonSearchService.MakeSaveLoadForm

function TCommonSearchService.MakeQueryCardForm(aFilter: Boolean;
 const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeQueryCardForm(aFilter, aParams, aZoneType, aRecursive, aUserType)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonSearchService.MakeQueryCardForm

class function TCommonSearchService.Instance: TCommonSearchService;
 {* ����� ��������� ���������� ���������� TCommonSearchService }
begin
 if (g_TCommonSearchService = nil) then
 begin
  l3System.AddExitProc(TCommonSearchServiceFree);
  g_TCommonSearchService := Create;
 end;
 Result := g_TCommonSearchService;
end;//TCommonSearchService.Instance

class function TCommonSearchService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TCommonSearchService <> nil;
end;//TCommonSearchService.Exists

procedure TCommonSearchService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TCommonSearchService.ClearFields

procedure TPrintingService.pm_SetAlien(const aValue: IPrintingService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TPrintingService.pm_SetAlien

function TPrintingService.MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakePrintDialog(aPreview)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TPrintingService.MakePrintDialog

function TPrintingService.MakePageSetup(const aData: InsPageSettingsInfo): Integer;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakePageSetup(aData)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TPrintingService.MakePageSetup

function TPrintingService.MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakePreview(aPreview)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TPrintingService.MakePreview

class function TPrintingService.Instance: TPrintingService;
 {* ����� ��������� ���������� ���������� TPrintingService }
begin
 if (g_TPrintingService = nil) then
 begin
  l3System.AddExitProc(TPrintingServiceFree);
  g_TPrintingService := Create;
 end;
 Result := g_TPrintingService;
end;//TPrintingService.Instance

class function TPrintingService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TPrintingService <> nil;
end;//TPrintingService.Exists

procedure TPrintingService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TPrintingService.ClearFields

initialization
{$IfEnd} // NOT Defined(Admin)

end.
