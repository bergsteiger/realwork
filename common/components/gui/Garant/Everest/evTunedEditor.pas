unit evTunedEditor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evTunedEditor.pas"
// �����: 25.11.2004 10:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevTunedEditor
//
// ������������� ����� ��� ���������� ������������ ��������� (�� ��� published-�������).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  Messages,
  evEditorWithOperations
  ;

type
 TevTunedEditor = class(TevEditorWithOperations)
  {* ������������� ����� ��� ���������� ������������ ��������� (�� ��� published-�������). }
 private
 // private methods
   procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
 public
 // overridden public methods
   function Tabulate: Boolean; override;
     {* ����������� ������� Tab. }
   function Untabulate: Boolean; override;
     {* ����������� ������� Shift-Tab. }
 end;//TevTunedEditor

implementation

uses
  nevTools,
  k2Tags,
  Windows,
  l3Base,
  evMsgCode
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  evOp,
  l3Chars
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  ,
  Block_Const,
  Table_Const,
  k2Base,
  evExcept
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevTunedEditor

procedure TevTunedEditor.WMKeyDown(var Msg: TWMKeyDown);
//#UC START# *484536B5002C_4845367E03B1_var*
var
 l_BlockCursor       : InevBasePoint;
 l_BlockCursorParent : InevBasePoint;
 l_AtEnd             : Boolean;
 l_OpPack            : InevOp;
 l_Position          : Integer;
 l_ParaCount         : Integer;
//#UC END# *484536B5002C_4845367E03B1_var*
begin
//#UC START# *484536B5002C_4845367E03B1_impl*
 Case Msg.CharCode of
  {$IfNDef DesignTimeLibrary}
  vk_Space:
  begin
   if l3System.Keyboard.Key[vk_Shift].Down AND
      l3System.Keyboard.Key[vk_Control].Down then
   begin
    TextPara.Font := nil;
    Msg.Result := 0;
   end//l3System.Keyboard.Key[vk_Shift].Down..
   else
    inherited;
  end;//vk_Space
  {$EndIf  DesignTimeLibrary}
  vk_Return: begin
   if l3System.Keyboard.Key[vk_Menu].Down AND
      l3System.Keyboard.Key[vk_Control].Down then
   begin
    if InPara(k2_typTable, l_BlockCursor) OR
       InPara(k2_typBlock, l_BlockCursor) then            
    begin
     l_BlockCursorParent := l_BlockCursor.ParentPoint;
     if (l_BlockCursorParent <> nil) then
     begin
      with l_BlockCursor do
      begin
       l_Position := Position;
       l_ParaCount := Obj.AsObject.ChildrenCount;
      end;//with l_BlockCursor
      if (l_Position = l_ParaCount) then begin
       if (l_Position = 1) then begin
        l_AtEnd := (l_BlockCursor.Inner.Position > 0);
       end else                                      
        l_AtEnd := true
      end else if (l_Position = 1) then
       l_AtEnd := false
      else
       Exit;
      l_OpPack := StartOp(ev_msgInsertPara);
      try
       try
        if evInsertPara(l_OpPack,
                        l_BlockCursorParent,
                        Tk2Type(l_BlockCursorParent.Obj.AsObject.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject,
                        AtEndFromBool[l_AtEnd]) then
        begin
         if l_AtEnd then
          l_BlockCursorParent.Move(View, ev_ocParaDown, l_OpPack)
         else
          l_BlockCursorParent.Move(View, ev_ocParaUp, l_OpPack);
        end;//evInsertPara
       except
        on EevReadOnly do;
       end;
      finally
       l_OpPack := nil;
      end;//try..finally
     end;//l_BlockCursorParent <> nil
     Msg.Result := 0;
    end;//InPara(k2_idBlock..
   end else
    inherited;
  end;//vk_Return
  else
   inherited;
 end;//Case Msg.CharCode
//#UC END# *484536B5002C_4845367E03B1_impl*
end;//TevTunedEditor.WMKeyDown

function TevTunedEditor.Tabulate: Boolean;
//#UC START# *482BFD1802D3_4845367E03B1_var*
//#UC END# *482BFD1802D3_4845367E03B1_var*
begin
//#UC START# *482BFD1802D3_4845367E03B1_impl*
 Result := inherited Tabulate;
 if not Result and not ReadOnly then
 begin
  if (Selection <> nil) then
   with Selection do
    if (Cursor <> nil) then
    begin
     if (Cursor.MostInner.Position = 0) then
      IncIndent
     else
     begin
      {$IfDef l3NeedTabbedText}
      Text.Modify.InsertString(View, 
                               l3CStr(cc_Tab),
                               StartOp(ev_msgInsertString),
                               InsertMode, [misfDirect]);
      {$EndIf l3NeedTabbedText}
     end;//Cursor.MostInner.Position = 0
     Result := true;
    end;//Cursor <> nil
 end;//not Result
//#UC END# *482BFD1802D3_4845367E03B1_impl*
end;//TevTunedEditor.Tabulate

function TevTunedEditor.Untabulate: Boolean;
//#UC START# *482BFD2C0107_4845367E03B1_var*
//#UC END# *482BFD2C0107_4845367E03B1_var*
begin
//#UC START# *482BFD2C0107_4845367E03B1_impl*
 Result := inherited Untabulate;
 if not Result and not ReadOnly then 
 begin
  if (Selection <> nil) then with Selection do
   if (Cursor <> nil) AND (Cursor.MostInner.Position = 0) then
   begin
    DecIndent;
    Result := true;
   end;//Cursor <> nil
 end;//not Result
//#UC END# *482BFD2C0107_4845367E03B1_impl*
end;//TevTunedEditor.Untabulate

initialization
{$If not defined(NoScripts)}
// ����������� TevTunedEditor
 TtfwClassRef.Register(TevTunedEditor);
{$IfEnd} //not NoScripts

end.