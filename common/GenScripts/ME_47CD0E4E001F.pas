unit vtNavigatorForm;
 {* ������� ������  ���� ����������. }

// ������: "w:\common\components\gui\Garant\VT\vtNavigatorForm.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmExternalInterfaces
;

type
 TvtNavigatorForm = class(Tl3ProtoObject)
  {* ������� ������  ���� ����������. }
  private
   f_CloseHandler: IvcmFormHandler;
    {* ���� ��� �������� CloseHandler }
  protected
   function pm_GetCloseHandler: IvcmFormHandler; virtual;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   constructor Create(const aCloseHandler: IvcmFormHandler); reintroduce;
    {* ����������� ������. }
  public
   property CloseHandler: IvcmFormHandler
    read pm_GetCloseHandler;
    {* ���������� ������� �����. }
 end;//TvtNavigatorForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

function TvtNavigatorForm.pm_GetCloseHandler: IvcmFormHandler;
//#UC START# *47D0FB460226_47CD0E4E001Fget_var*
//#UC END# *47D0FB460226_47CD0E4E001Fget_var*
begin
//#UC START# *47D0FB460226_47CD0E4E001Fget_impl*
 Result := f_CloseHandler;
//#UC END# *47D0FB460226_47CD0E4E001Fget_impl*
end;//TvtNavigatorForm.pm_GetCloseHandler

constructor TvtNavigatorForm.Create(const aCloseHandler: IvcmFormHandler);
 {* ����������� ������. }
//#UC START# *47CE93D9033B_47CD0E4E001F_var*
//#UC END# *47CE93D9033B_47CD0E4E001F_var*
begin
//#UC START# *47CE93D9033B_47CD0E4E001F_impl*
 inherited Create;
 f_CloseHandler := aCloseHandler;
//#UC END# *47CE93D9033B_47CD0E4E001F_impl*
end;//TvtNavigatorForm.Create

procedure TvtNavigatorForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_47CD0E4E001F_var*
//#UC END# *479731C50290_47CD0E4E001F_var*
begin
//#UC START# *479731C50290_47CD0E4E001F_impl*
 f_CloseHandler := nil;
 inherited;
//#UC END# *479731C50290_47CD0E4E001F_impl*
end;//TvtNavigatorForm.Cleanup

procedure TvtNavigatorForm.ClearFields;
begin
 f_CloseHandler := nil;
 inherited;
end;//TvtNavigatorForm.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
