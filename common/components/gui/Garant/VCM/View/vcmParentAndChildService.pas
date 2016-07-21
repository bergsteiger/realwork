unit vcmParentAndChildService;

// ������: "w:\common\components\gui\Garant\VCM\View\vcmParentAndChildService.pas"
// ���������: "Service"
// ������� ������: "TvcmParentAndChildService" MUID: (578CD42801C0)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MvcmParentAndChildService = interface
  {* �������� ������� TvcmParentAndChildService }
  function MakeChild(aMainForm: TvcmMainForm;
   anOwner: TvcmEntityForm): IvcmEntityForm;
  function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
 end;//MvcmParentAndChildService
 *)

type
 IvcmParentAndChildService = interface
  {* ��������� ������� TvcmParentAndChildService }
  function MakeChild(aMainForm: TvcmMainForm;
   anOwner: TvcmEntityForm): IvcmEntityForm;
  function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
 end;//IvcmParentAndChildService

 TvcmParentAndChildService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IvcmParentAndChildService;
    {* ������� ���������� ������� IvcmParentAndChildService }
  protected
   procedure pm_SetAlien(const aValue: IvcmParentAndChildService);
   procedure ClearFields; override;
  public
   function MakeChild(aMainForm: TvcmMainForm;
    anOwner: TvcmEntityForm): IvcmEntityForm;
   function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
   class function Instance: TvcmParentAndChildService;
    {* ����� ��������� ���������� ���������� TvcmParentAndChildService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IvcmParentAndChildService
    write pm_SetAlien;
    {* ������� ���������� ������� IvcmParentAndChildService }
 end;//TvcmParentAndChildService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvcmParentAndChildService: TvcmParentAndChildService = nil;
 {* ��������� ���������� TvcmParentAndChildService }

procedure TvcmParentAndChildServiceFree;
 {* ����� ������������ ���������� ���������� TvcmParentAndChildService }
begin
 l3Free(g_TvcmParentAndChildService);
end;//TvcmParentAndChildServiceFree

procedure TvcmParentAndChildService.pm_SetAlien(const aValue: IvcmParentAndChildService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmParentAndChildService.pm_SetAlien

function TvcmParentAndChildService.MakeChild(aMainForm: TvcmMainForm;
 anOwner: TvcmEntityForm): IvcmEntityForm;
//#UC START# *02C018BFDA93_578CD42801C0_var*
//#UC END# *02C018BFDA93_578CD42801C0_var*
begin
//#UC START# *02C018BFDA93_578CD42801C0_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.MakeChild(aMainForm, anOwner)
 else
  Result := nil; 
//#UC END# *02C018BFDA93_578CD42801C0_impl*
end;//TvcmParentAndChildService.MakeChild

function TvcmParentAndChildService.MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
//#UC START# *6D970D53CC11_578CD42801C0_var*
//#UC END# *6D970D53CC11_578CD42801C0_var*
begin
//#UC START# *6D970D53CC11_578CD42801C0_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.MakeParent(aMainForm)
 else
  Result := nil; 
//#UC END# *6D970D53CC11_578CD42801C0_impl*
end;//TvcmParentAndChildService.MakeParent

class function TvcmParentAndChildService.Instance: TvcmParentAndChildService;
 {* ����� ��������� ���������� ���������� TvcmParentAndChildService }
begin
 if (g_TvcmParentAndChildService = nil) then
 begin
  l3System.AddExitProc(TvcmParentAndChildServiceFree);
  g_TvcmParentAndChildService := Create;
 end;
 Result := g_TvcmParentAndChildService;
end;//TvcmParentAndChildService.Instance

class function TvcmParentAndChildService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmParentAndChildService <> nil;
end;//TvcmParentAndChildService.Exists

procedure TvcmParentAndChildService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TvcmParentAndChildService.ClearFields

end.
