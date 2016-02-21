unit kwIterateSubDecriptorsOnSubPanel;
 {* ���������� ��� SubDescriptot �� SubPanel, ������� *����� ����* ���������� (!). �.�. �������� �� Visible �� ������������. ���� ��� �����, �� ����� ���������� � ��������. 
������:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanel
[code]
aLayerID - ����, � ������� ������������ ��������
aSubPanel - ������� ���������.
aWord - ������� ��� ��������� ����:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription INTEGER IN aHandle
 // � ����� ������������ ���������� aSubDescription
;
[code]
��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType � �.�.
aHandle - ����� ����, � �������� �������� �����. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDecriptorsOnSubPanel.pas"
// ���������: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , tfwScriptingInterfaces
 , evSubPn
 , evSubPanelSub
;

type
 TkwIterateSubDecriptorsOnSubPanel = {final} class(TkwSubPanelFromStackWord)
  {* ���������� ��� SubDescriptot �� SubPanel, ������� *����� ����* ���������� (!). �.�. �������� �� Visible �� ������������. ���� ��� �����, �� ����� ���������� � ��������. 
������:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanel
[code]
aLayerID - ����, � ������� ������������ ��������
aSubPanel - ������� ���������.
aWord - ������� ��� ��������� ����:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription INTEGER IN aHandle
 // � ����� ������������ ���������� aSubDescription
;
[code]
��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType � �.�.
aHandle - ����� ����, � �������� �������� �����. }
  protected
   procedure PushObjData(const aCtx: TtfwContext;
    aSubDescription: TevSubDescriptor;
    aSubPanelSub: TevSubPanelSub); virtual;
   procedure DoWithSubPanel(aControl: TevCustomSubPanel;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIterateSubDecriptorsOnSubPanel
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evSubPanelSubCollection
 , evSubPanelSubArray
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwIterateSubDecriptorsOnSubPanel.PushObjData(const aCtx: TtfwContext;
 aSubDescription: TevSubDescriptor;
 aSubPanelSub: TevSubPanelSub);
//#UC START# *53EDFA0401B8_52D78486017B_var*
//#UC END# *53EDFA0401B8_52D78486017B_var*
begin
//#UC START# *53EDFA0401B8_52D78486017B_impl*
 aCtx.rEngine.PushObj(aSubDescription);
 aCtx.rEngine.PushInt(aSubPanelSub.Handle);
//#UC END# *53EDFA0401B8_52D78486017B_impl*
end;//TkwIterateSubDecriptorsOnSubPanel.PushObjData

procedure TkwIterateSubDecriptorsOnSubPanel.DoWithSubPanel(aControl: TevCustomSubPanel;
 const aCtx: TtfwContext);
//#UC START# *52D6471802DC_52D78486017B_var*
var
 i               : Integer;
 k               : Integer;
 l_Obj           : TObject;
 l_Lambda        : TtfwWord;
 l_SubArray      : TevSubPanelSubArray;
 l_Collection    : TevSubPanelSubCollection;
 l_SubDescriptor : TevSubDescriptor;
//#UC END# *52D6471802DC_52D78486017B_var*
begin
//#UC START# *52D6471802DC_52D78486017B_impl*
 RunnerAssert(aCtx.rEngine.IsTopObj, '� �������� �� �������� �����.', aCtx);
 l_Obj := aCtx.rEngine.PopObj;
 RunnerAssert(l_Obj is TtfwWord, '� �������� �� �������� �����.', aCtx);

 l_Lambda := l_Obj as TtfwWord;
 l_Collection := aControl.GetSubPanelSubCollection;
 for i := 0 to l_Collection.Count - 1 do
 try
  l_SubArray := l_Collection.Items[i];
  {$IFDEF NoScripts}
  l_SubDescriptor := nil;
  {$ELSE}
  l_SubDescriptor := aControl.SubDescriptors[l_SubArray.Handle];
  {$ENDIF NoScripts}
  if l_SubDescriptor <> nil then
   for k := 0 to l_SubArray.Count - 1 do
   begin
    PushObjData(aCtx, l_SubDescriptor, l_SubArray.Items[k]);
    l_Lambda.DoIt(aCtx);
   end; // for k := 0 to l_SubArray.Count - 1 do
 except
  on EtfwBreakIterator do
   Exit;
 end;//try..except
//#UC END# *52D6471802DC_52D78486017B_impl*
end;//TkwIterateSubDecriptorsOnSubPanel.DoWithSubPanel

class function TkwIterateSubDecriptorsOnSubPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateSubDecriptorsOnSubPanel';
end;//TkwIterateSubDecriptorsOnSubPanel.GetWordNameForRegister

initialization
 TkwIterateSubDecriptorsOnSubPanel.RegisterInEngine;
 {* ����������� IterateSubDecriptorsOnSubPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
