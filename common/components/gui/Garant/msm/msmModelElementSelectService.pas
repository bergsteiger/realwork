unit msmModelElementSelectService;

// ������: "w:\common\components\gui\Garant\msm\msmModelElementSelectService.pas"
// ���������: "Service"
// ������� ������: "TmsmModelElementSelectService" MUID: (57F5040203B0)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmConcreteModels
 , msmListAndTreeViewUtils
 , msmModelElements
;

type
 ImsmElementSelector = interface
  ['{BB24B3A1-7520-46D9-80C2-696EE7386AD5}']
  procedure SelectElement(const anElementName: AnsiString;
   const anElementStereotype: ImsmModelElement);
 end;//ImsmElementSelector

 (*
 MmsmModelElementSelectService = interface
  {* �������� ������� TmsmModelElementSelectService }
  procedure SelectElement(const aList: ImsmListModel;
   const aListContext: TmsmListViewtInitContext;
   const aSelector: ImsmElementSelector);
 end;//MmsmModelElementSelectService
 *)

 ImsmModelElementSelectService = interface
  {* ��������� ������� TmsmModelElementSelectService }
  procedure SelectElement(const aList: ImsmListModel;
   const aListContext: TmsmListViewtInitContext;
   const aSelector: ImsmElementSelector);
 end;//ImsmModelElementSelectService

 TmsmModelElementSelectService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ImsmModelElementSelectService;
    {* ������� ���������� ������� ImsmModelElementSelectService }
  protected
   procedure pm_SetAlien(const aValue: ImsmModelElementSelectService);
   procedure ClearFields; override;
  public
   procedure SelectElement(const aList: ImsmListModel;
    const aListContext: TmsmListViewtInitContext;
    const aSelector: ImsmElementSelector);
   class function Instance: TmsmModelElementSelectService;
    {* ����� ��������� ���������� ���������� TmsmModelElementSelectService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ImsmModelElementSelectService
    write pm_SetAlien;
    {* ������� ���������� ������� ImsmModelElementSelectService }
 end;//TmsmModelElementSelectService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57F5040203B0impl_uses*
 //#UC END# *57F5040203B0impl_uses*
;

var g_TmsmModelElementSelectService: TmsmModelElementSelectService = nil;
 {* ��������� ���������� TmsmModelElementSelectService }

procedure TmsmModelElementSelectServiceFree;
 {* ����� ������������ ���������� ���������� TmsmModelElementSelectService }
begin
 l3Free(g_TmsmModelElementSelectService);
end;//TmsmModelElementSelectServiceFree

procedure TmsmModelElementSelectService.pm_SetAlien(const aValue: ImsmModelElementSelectService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TmsmModelElementSelectService.pm_SetAlien

procedure TmsmModelElementSelectService.SelectElement(const aList: ImsmListModel;
 const aListContext: TmsmListViewtInitContext;
 const aSelector: ImsmElementSelector);
//#UC START# *BBCBB8731EE0_57F5040203B0_var*
//#UC END# *BBCBB8731EE0_57F5040203B0_var*
begin
//#UC START# *BBCBB8731EE0_57F5040203B0_impl*
 if (f_Alien <> nil) then
  f_Alien.SelectElement(aList, aListContext, aSelector)
 else
  Assert(false); 
//#UC END# *BBCBB8731EE0_57F5040203B0_impl*
end;//TmsmModelElementSelectService.SelectElement

class function TmsmModelElementSelectService.Instance: TmsmModelElementSelectService;
 {* ����� ��������� ���������� ���������� TmsmModelElementSelectService }
begin
 if (g_TmsmModelElementSelectService = nil) then
 begin
  l3System.AddExitProc(TmsmModelElementSelectServiceFree);
  g_TmsmModelElementSelectService := Create;
 end;
 Result := g_TmsmModelElementSelectService;
end;//TmsmModelElementSelectService.Instance

class function TmsmModelElementSelectService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TmsmModelElementSelectService <> nil;
end;//TmsmModelElementSelectService.Exists

procedure TmsmModelElementSelectService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TmsmModelElementSelectService.ClearFields

end.
