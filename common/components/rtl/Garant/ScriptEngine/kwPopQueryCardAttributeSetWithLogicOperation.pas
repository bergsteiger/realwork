unit kwPopQueryCardAttributeSetWithLogicOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// �����: ����� �.�.
// ������: "kwPopQueryCardAttributeSetWithLogicOperation.pas"
// �����: 28.09.2011 12:04
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::QueryCardProcessing::pop_QueryCard_Attribute_SetWithLogicOperation
//
// ��������� ������� � ���������� ��������� � ������� �������� �������.
// 
// *������:*
// {code}
// ���::�����_�����_��������������_��������
// 'AT_PHARM_NAME' '�������' Search:SetAttribute
// 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
// 1 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����'
// Search:SetAttributeWithLogicOperation
// Ok
// {code}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  nevBase,
  evQueryCardInt,
  evQueryCardEditor,
  tfwScriptingInterfaces,
  kwQueryCardFromStackWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwPopQueryCardAttributeSetWithLogicOperation = {scriptword} class(TkwQueryCardFromStackWord)
  {* ��������� ������� � ���������� ��������� � ������� �������� �������.

*������:*
[code]
 ���::�����_�����_��������������_��������
 'AT_PHARM_NAME' '�������' Search:SetAttribute
 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
 1 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����' Search:SetAttributeWithLogicOperation
 Ok
[code] }
 private
 // private methods
   procedure DoModelImpl(const aCtx: TtfwContext;
     aCard: TevQueryCardEditor);
 protected
 // realized methods
   procedure DoCard(const aCtx: TtfwContext;
     aCard: TevQueryCardEditor); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeSetWithLogicOperation
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String,
  l3Base,
  evReqIterator
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwPopQueryCardAttributeSetWithLogicOperation

procedure TkwPopQueryCardAttributeSetWithLogicOperation.DoModelImpl(const aCtx: TtfwContext;
  aCard: TevQueryCardEditor);
var
 l_Name : Il3CString;
 l_Value : Il3CString;
 l_Op : InevOp;
 l_LogicOp : Integer;

 procedure CallIterator;

  function DoIt(const anItem: IevReq): Boolean;
  //#UC START# *64362B31BF0F__var*
  var
   l_F : IevEditorControlField;
  //#UC END# *64362B31BF0F__var*
  begin
  //#UC START# *64362B31BF0F__impl*
   if l3Same(l_Name, anItem.ReqName) then
   begin
    Result := false;
    l_F := anItem.FirstField;
    if not l3IsNil(anItem.FirstField.Text) then
     l_F := anItem.AddField(aCard.View, true);
    l_F.Text := l_Value;
    l_F.SynchronizeSelectedValueWithText{TextChange(aCard.View, l_F.Para, l_Op)};
    (l_F As IevEditorFieldWithTree).LogicalState := l_LogicOp; 
    Exit;
   end//l3Same(l_Name, anItem.ReqName)
   else
    Result := true;
  //#UC END# *64362B31BF0F__impl*
  end;//DoIt

 //#UC START# *4E82D5F601E2__var*
 //#UC END# *4E82D5F601E2__var*
 begin
  //#UC START# *4E82D5F601E2iter*
  TevReqIterator.Make(aCard).
  //#UC END# *4E82D5F601E2iter*
   DoReqF(L2IevReqIteratorDoReqAction(@DoIt));
 end;//CallIterator

//#UC START# *4E82D58E02D1_4E82D4F60180_var*
//#UC END# *4E82D58E02D1_4E82D4F60180_var*
begin
//#UC START# *4E82D58E02D1_4E82D4F60180_impl*
 l_Value := aCtx.rEngine.PopString;
 l_Name := aCtx.rEngine.PopString;
 l_LogicOp := aCtx.rEngine.PopInt;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *4E82D58E02D1_4E82D4F60180_impl*
end;//TkwPopQueryCardAttributeSetWithLogicOperation.DoModelImpl

procedure TkwPopQueryCardAttributeSetWithLogicOperation.DoCard(const aCtx: TtfwContext;
  aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4E82D4F60180_var*
//#UC END# *4E808E8B01BB_4E82D4F60180_var*
begin
//#UC START# *4E808E8B01BB_4E82D4F60180_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_4E82D4F60180_impl*
end;//TkwPopQueryCardAttributeSetWithLogicOperation.DoCard

class function TkwPopQueryCardAttributeSetWithLogicOperation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:QueryCard:Attribute:SetWithLogicOperation';
end;//TkwPopQueryCardAttributeSetWithLogicOperation.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_QueryCard_Attribute_SetWithLogicOperation
 TkwPopQueryCardAttributeSetWithLogicOperation.RegisterInEngine;
{$IfEnd} //not NoScripts

end.