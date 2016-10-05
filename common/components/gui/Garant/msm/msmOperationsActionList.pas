unit msmOperationsActionList;

// ������: "w:\common\components\gui\Garant\msm\msmOperationsActionList.pas"
// ���������: "SimpleClass"
// ������� ������: "TmsmOperationsActionList" MUID: (57EB9E8000FF)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TmsmOperationsActionList = class({$If NOT Defined(NoVCL)}
 TActionList
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   constructor Create; reintroduce;
   class function Instance: TmsmOperationsActionList;
    {* ����� ��������� ���������� ���������� TmsmOperationsActionList }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TmsmOperationsActionList

implementation

uses
 l3ImplUses
 , msmImages
 , SysUtils
 , l3Base
 //#UC START# *57EB9E8000FFimpl_uses*
 //#UC END# *57EB9E8000FFimpl_uses*
;

{$If NOT Defined(NoVCL)}
var g_TmsmOperationsActionList: TmsmOperationsActionList = nil;
 {* ��������� ���������� TmsmOperationsActionList }

procedure TmsmOperationsActionListFree;
 {* ����� ������������ ���������� ���������� TmsmOperationsActionList }
begin
 l3Free(g_TmsmOperationsActionList);
end;//TmsmOperationsActionListFree

constructor TmsmOperationsActionList.Create;
//#UC START# *57EB9EBA03B4_57EB9E8000FF_var*
//#UC END# *57EB9EBA03B4_57EB9E8000FF_var*
begin
//#UC START# *57EB9EBA03B4_57EB9E8000FF_impl*
 inherited Create(nil);
 Self.Images := TmsmImages.Instance.GetImagesForOperations;
//#UC END# *57EB9EBA03B4_57EB9E8000FF_impl*
end;//TmsmOperationsActionList.Create

class function TmsmOperationsActionList.Instance: TmsmOperationsActionList;
 {* ����� ��������� ���������� ���������� TmsmOperationsActionList }
begin
 if (g_TmsmOperationsActionList = nil) then
 begin
  l3System.AddExitProc(TmsmOperationsActionListFree);
  g_TmsmOperationsActionList := Create;
 end;
 Result := g_TmsmOperationsActionList;
end;//TmsmOperationsActionList.Instance

class function TmsmOperationsActionList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TmsmOperationsActionList <> nil;
end;//TmsmOperationsActionList.Exists
{$IfEnd} // NOT Defined(NoVCL)

end.
