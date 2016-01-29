unit kwIterateSubDescriptors;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwIterateSubDescriptors.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::SubPanelWords::IterateSubDescriptors
//
// ���������� ��� SubDescriptot �� SubPanel, ������� ����� ���� ������������ (!). ����� ������
// �������� �� ����� ��������������/��������� ���������. � �� ������� �� ���� �����������.
// ������:
// {code}
// @ aWord aLayerID aSubPanel ItarateSubDescriptors
// {code}
// aLayerID - ����, � ������� ������������ ��������
// aSubPanel - ������� ���������.
// aWord - ������� ��� ��������� ����:
// {code}
// PROCEDURE CheckDescription OBJECT IN aSubDescription
// // � ����� ������������ ���������� aSubDescription
// ;
// {code}
// ��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType
// � �.�.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwSubPanelFromStackWord,
  tfwScriptingInterfaces,
  evSubPn
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwIterateSubDescriptors = {final scriptword} class(TkwSubPanelFromStackWord)
  {* ���������� ��� SubDescriptot �� SubPanel, ������� ����� ���� ������������ (!). ����� ������ �������� �� ����� ��������������/��������� ���������. � �� ������� �� ���� �����������.
������:
[code]
@ aWord aLayerID aSubPanel ItarateSubDescriptors
[code]
aLayerID - ����, � ������� ������������ ��������
aSubPanel - ������� ���������.
aWord - ������� ��� ��������� ����:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription
 // � ����� ������������ ���������� aSubDescription
;
[code]
��� ���������� ������ ��������� �� aSubDescription ���� ����� �������: subdescriptor:GetDrawType � �.�. }
 protected
 // realized methods
   procedure DoWithSubPanel(aControl: TevCustomSubPanel;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIterateSubDescriptors
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwIterateSubDescriptors

procedure TkwIterateSubDescriptors.DoWithSubPanel(aControl: TevCustomSubPanel;
  const aCtx: TtfwContext);
//#UC START# *52D6471802DC_52D643C100A8_var*
var
 i        : Integer;
 l_Obj    : TObject;
 l_Layer  : TevSubLayerDescriptor;
 l_Lambda : TtfwWord;
 l_LayerID: Integer;
//#UC END# *52D6471802DC_52D643C100A8_var*
begin
//#UC START# *52D6471802DC_52D643C100A8_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, '���� ����� �� �����.', aCtx);
 l_LayerID := aCtx.rEngine.PopInt;
 RunnerAssert(l_LayerID = 0, '�� ������������ �����.', aCtx);
 
 RunnerAssert(aCtx.rEngine.IsTopObj, '� �������� �� �������� �����.', aCtx);
 l_Obj := aCtx.rEngine.PopObj;
 RunnerAssert(l_Obj is TtfwWord, '� �������� �� �������� �����.', aCtx);

 l_Lambda := l_Obj as TtfwWord;
 l_Layer := TevSubLayerDescriptor(aControl.SubDescriptors[l_LayerID]);
 RunnerAssert(l_Layer <> nil, '��� ������ ���� �����.', aCtx);
 for i := 0 to 7 do
 try
  aCtx.rEngine.PushObj(l_Layer.Flags[i]);
  l_Lambda.DoIt(aCtx);
 except
  on EtfwBreakIterator do
   Exit;
 end;//try..except
//#UC END# *52D6471802DC_52D643C100A8_impl*
end;//TkwIterateSubDescriptors.DoWithSubPanel

class function TkwIterateSubDescriptors.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IterateSubDescriptors';
end;//TkwIterateSubDescriptors.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� IterateSubDescriptors
 TkwIterateSubDescriptors.RegisterInEngine;
{$IfEnd} //not NoScripts

end.