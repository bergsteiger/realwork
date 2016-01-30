unit alcuTaskChangeHelper;

// ������: "w:\archi\source\projects\PipeInAuto\Server\alcuTaskChangeHelper.pas"
// ���������: "ServiceImplementation"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , csTaskChangeHelper
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuTaskChangeHelper = {final} class(Tl3ProtoObject{$If NOT Defined(Nemesis)}
 , IcsTaskChangeHelper
 {$IfEnd} // NOT Defined(Nemesis)
 )
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   {$If NOT Defined(Nemesis)}
   procedure TaskGotErrorStatus;
   {$IfEnd} // NOT Defined(Nemesis)
   class function Instance: TalcuTaskChangeHelper;
    {* ����� ��������� ���������� ���������� TalcuTaskChangeHelper }
 end;//TalcuTaskChangeHelper
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , alcuMailServer
 , alcuTypes
 , SysUtils
 , l3Base
;

var g_TalcuTaskChangeHelper: TalcuTaskChangeHelper = nil;
 {* ��������� ���������� TalcuTaskChangeHelper }

procedure TalcuTaskChangeHelperFree;
 {* ����� ������������ ���������� ���������� TalcuTaskChangeHelper }
begin
 l3Free(g_TalcuTaskChangeHelper);
end;//TalcuTaskChangeHelperFree

class function TalcuTaskChangeHelper.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TalcuTaskChangeHelper <> nil;
end;//TalcuTaskChangeHelper.Exists

{$If NOT Defined(Nemesis)}
procedure TalcuTaskChangeHelper.TaskGotErrorStatus;
//#UC START# *F75B4443B80B_5583CD3601BD_var*
//#UC END# *F75B4443B80B_5583CD3601BD_var*
begin
//#UC START# *F75B4443B80B_5583CD3601BD_impl*
 alcuMail.SendSMSNotify(eventTaskError, dd_apsProcessQuery);
//#UC END# *F75B4443B80B_5583CD3601BD_impl*
end;//TalcuTaskChangeHelper.TaskGotErrorStatus
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuTaskChangeHelper.Instance: TalcuTaskChangeHelper;
 {* ����� ��������� ���������� ���������� TalcuTaskChangeHelper }
begin
 if (g_TalcuTaskChangeHelper = nil) then
 begin
  l3System.AddExitProc(TalcuTaskChangeHelperFree);
  g_TalcuTaskChangeHelper := Create;
 end;
 Result := g_TalcuTaskChangeHelper;
end;//TalcuTaskChangeHelper.Instance

initialization
{$If NOT Defined(Nemesis)}
 TcsTaskChangeHelper.Instance.Alien := TalcuTaskChangeHelper.Instance;
{$IfEnd} // NOT Defined(Nemesis)
 {* ����������� TalcuTaskChangeHelper }
{$IfEnd} // Defined(AppServerSide)

end.
