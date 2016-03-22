unit kwIterateSubDecriptorsOnSubPanelEX;
 {* ���������� ��� SubDescriptot �� SubPanel, ������� *����� ����* ���������� (!). �.�. �������� �� Visible �� ������������. ���� ��� �����, �� ����� ���������� � ��������. 
������:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanelEX
[code]
aLayerID - ����, � ������� ������������ ��������
aSubPanel - ������� ���������.
aWord - ������� ��� ��������� ����:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription OBJECT IN aSubPanelSub
 // � ����� ������������ ���������� aSubDescription
;
[code]
��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType � �.�.
aSubPanelSub - ���������� ������������� �����. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDecriptorsOnSubPanelEX.pas"
// ���������: "ScriptKeyword"
// ������� ������: "IterateSubDecriptorsOnSubPanelEX" MUID: (53EDF0A20129)
// ��� ����: "TkwIterateSubDecriptorsOnSubPanelEX"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIterateSubDecriptorsOnSubPanel
 , tfwScriptingInterfaces
 , evSubPn
 , evSubPanelSub
;

type
 TkwIterateSubDecriptorsOnSubPanelEX = {final} class(TkwIterateSubDecriptorsOnSubPanel)
  {* ���������� ��� SubDescriptot �� SubPanel, ������� *����� ����* ���������� (!). �.�. �������� �� Visible �� ������������. ���� ��� �����, �� ����� ���������� � ��������. 
������:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanelEX
[code]
aLayerID - ����, � ������� ������������ ��������
aSubPanel - ������� ���������.
aWord - ������� ��� ��������� ����:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription OBJECT IN aSubPanelSub
 // � ����� ������������ ���������� aSubDescription
;
[code]
��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType � �.�.
aSubPanelSub - ���������� ������������� �����. }
  protected
   procedure PushObjData(const aCtx: TtfwContext;
    aSubDescription: TevSubDescriptor;
    aSubPanelSub: TevSubPanelSub); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIterateSubDecriptorsOnSubPanelEX
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evSubPanelSubArray
 , evSubPanelSubCollection
;

procedure TkwIterateSubDecriptorsOnSubPanelEX.PushObjData(const aCtx: TtfwContext;
 aSubDescription: TevSubDescriptor;
 aSubPanelSub: TevSubPanelSub);
//#UC START# *53EDFA0401B8_53EDF0A20129_var*
//#UC END# *53EDFA0401B8_53EDF0A20129_var*
begin
//#UC START# *53EDFA0401B8_53EDF0A20129_impl*
 aCtx.rEngine.PushObj(aSubDescription);
 aCtx.rEngine.PushObj(aSubPanelSub);
//#UC END# *53EDFA0401B8_53EDF0A20129_impl*
end;//TkwIterateSubDecriptorsOnSubPanelEX.PushObjData

class function TkwIterateSubDecriptorsOnSubPanelEX.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateSubDecriptorsOnSubPanelEX';
end;//TkwIterateSubDecriptorsOnSubPanelEX.GetWordNameForRegister

initialization
 TkwIterateSubDecriptorsOnSubPanelEX.RegisterInEngine;
 {* ����������� IterateSubDecriptorsOnSubPanelEX }
{$IfEnd} // NOT Defined(NoScripts)

end.
