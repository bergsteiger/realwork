unit l3FormsService;

// ������: "w:\common\components\rtl\Garant\L3\l3FormsService.pas"
// ���������: "Service"
// ������� ������: "Tl3FormsService" MUID: (5506D56601D6)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , Forms
 , Classes
;

type
 TCustomForm = Forms.TCustomForm;

 (*
 Ml3FormsService = interface
  {* �������� ������� Tl3FormsService }
  function GetParentForm(Component: TPersistent): TCustomForm;
  function GetAnotherParentForm(Component: TPersistent): TCustomForm;
  function GetTopParentForm(Component: TPersistent): TCustomForm;
  function GetMainForm(Component: TPersistent): TCustomForm;
 end;//Ml3FormsService
 *)

 Il3FormsService = interface
  {* ��������� ������� Tl3FormsService }
  function GetParentForm(Component: TPersistent): TCustomForm;
  function GetAnotherParentForm(Component: TPersistent): TCustomForm;
  function GetTopParentForm(Component: TPersistent): TCustomForm;
  function GetMainForm(Component: TPersistent): TCustomForm;
 end;//Il3FormsService

 Tl3FormsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3FormsService;
    {* ������� ���������� ������� Il3FormsService }
  protected
   procedure pm_SetAlien(const aValue: Il3FormsService);
   procedure ClearFields; override;
  public
   function GetParentForm(Component: TPersistent): TCustomForm;
   function GetAnotherParentForm(Component: TPersistent): TCustomForm;
   function GetTopParentForm(Component: TPersistent): TCustomForm;
   function GetMainForm(Component: TPersistent): TCustomForm;
   class function Instance: Tl3FormsService;
    {* ����� ��������� ���������� ���������� Tl3FormsService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: Il3FormsService
    write pm_SetAlien;
    {* ������� ���������� ������� Il3FormsService }
 end;//Tl3FormsService
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *5506D56601D6impl_uses*
 //#UC END# *5506D56601D6impl_uses*
;

var g_Tl3FormsService: Tl3FormsService = nil;
 {* ��������� ���������� Tl3FormsService }

procedure Tl3FormsServiceFree;
 {* ����� ������������ ���������� ���������� Tl3FormsService }
begin
 l3Free(g_Tl3FormsService);
end;//Tl3FormsServiceFree

procedure Tl3FormsService.pm_SetAlien(const aValue: Il3FormsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3FormsService.pm_SetAlien

function Tl3FormsService.GetParentForm(Component: TPersistent): TCustomForm;
//#UC START# *5506D58B0238_5506D56601D6_var*
//#UC END# *5506D58B0238_5506D56601D6_var*
begin
//#UC START# *5506D58B0238_5506D56601D6_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetParentForm(Component)
 else
 begin
  Result := nil;
  Assert(false, '������ �� ����������');
 end;//f_Alien <> nil
//#UC END# *5506D58B0238_5506D56601D6_impl*
end;//Tl3FormsService.GetParentForm

function Tl3FormsService.GetAnotherParentForm(Component: TPersistent): TCustomForm;
//#UC START# *5506D5B30127_5506D56601D6_var*
//#UC END# *5506D5B30127_5506D56601D6_var*
begin
//#UC START# *5506D5B30127_5506D56601D6_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetAnotherParentForm(Component)
 else
 begin
  Result := nil;
  Assert(false, '������ �� ����������');
 end;//f_Alien <> nil
//#UC END# *5506D5B30127_5506D56601D6_impl*
end;//Tl3FormsService.GetAnotherParentForm

function Tl3FormsService.GetTopParentForm(Component: TPersistent): TCustomForm;
//#UC START# *5506E84700E5_5506D56601D6_var*
//#UC END# *5506E84700E5_5506D56601D6_var*
begin
//#UC START# *5506E84700E5_5506D56601D6_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetTopParentForm(Component)
 else
 begin
  Result := nil;
  Assert(false, '������ �� ����������');
 end;//f_Alien <> nil
//#UC END# *5506E84700E5_5506D56601D6_impl*
end;//Tl3FormsService.GetTopParentForm

function Tl3FormsService.GetMainForm(Component: TPersistent): TCustomForm;
//#UC START# *5506E861028F_5506D56601D6_var*
//#UC END# *5506E861028F_5506D56601D6_var*
begin
//#UC START# *5506E861028F_5506D56601D6_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetMainForm(Component)
 else
 begin
  Result := nil;
  Assert(false, '������ �� ����������');
 end;//f_Alien <> nil
//#UC END# *5506E861028F_5506D56601D6_impl*
end;//Tl3FormsService.GetMainForm

class function Tl3FormsService.Instance: Tl3FormsService;
 {* ����� ��������� ���������� ���������� Tl3FormsService }
begin
 if (g_Tl3FormsService = nil) then
 begin
  l3System.AddExitProc(Tl3FormsServiceFree);
  g_Tl3FormsService := Create;
 end;
 Result := g_Tl3FormsService;
end;//Tl3FormsService.Instance

class function Tl3FormsService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3FormsService <> nil;
end;//Tl3FormsService.Exists

procedure Tl3FormsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3FormsService.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
 {* ����������� ���� TCustomForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
