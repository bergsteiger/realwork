unit evUnblockEmptyParaFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// ������: "w:/common/components/gui/Garant/EverestCommon/evUnblockEmptyParaFilter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Generators::TevUnblockEmptyParaFilter
//
// ������ ���� ����� � ������� ����������� � ����� ������ � "�����������" ��� ������ ���������
// ������. ��. [$228692043]
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  evdBufferedFilter,
  l3Variant
  ;

type
 TevUnblockEmptyParaFilter = class(TevdBufferedFilter)
  {* ������ ���� ����� � ������� ����������� � ����� ������ � "�����������" ��� ������ ��������� ������. ��. [$228692043] }
 private
 // private fields
   f_NeedToReport : Boolean;
 protected
 // overridden protected methods
   procedure StartChild(TypeID: Tl3Type); override;
   procedure CloseStructure(NeedUndo: Boolean); override;
     {* ���������� �� ������������� "������". ��� ���������� � ��������. }
   function NeedStartBuffering(aID: Integer): Boolean; override;
 end;//TevUnblockEmptyParaFilter

implementation

uses
  l3String,
  k2Interfaces,
  k2Tags,
  Block_Const,
  LeafPara_Const,
  l3Base
  ;

// start class TevUnblockEmptyParaFilter

procedure TevUnblockEmptyParaFilter.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_4C56D4E002D2_var*
//#UC END# *4836D4650177_4C56D4E002D2_var*
begin
//#UC START# *4836D4650177_4C56D4E002D2_impl*
 if (TypeID = k2_typBlock) and (SkipLevel = 2) then
 begin
  f_NeedToReport := True;
  StopBufferingAndFlush(False, TopObject[0], False);
 end;
 inherited StartChild(TypeID);
//#UC END# *4836D4650177_4C56D4E002D2_impl*
end;//TevUnblockEmptyParaFilter.StartChild

procedure TevUnblockEmptyParaFilter.CloseStructure(NeedUndo: Boolean);
//#UC START# *4836D4C20059_4C56D4E002D2_var*
var
 l_Para: Tl3Variant;
 l_ID: Integer;
//#UC END# *4836D4C20059_4C56D4E002D2_var*
begin
//#UC START# *4836D4C20059_4C56D4E002D2_impl*
 if CurrentType.IsKindOf(k2_typLeafPara) and (SkipLevel = 3) then
 begin
  l_Para := f_Buffer.Tags.Top^.Box;
  if l3IsNil(l_Para.PCharLenA[k2_tiText]) then
  begin
   if not f_NeedToReport then
   begin
    // "�������" ������ �������� �� �����, �� ���� "������"
    Generator.StartChild(l_Para.TagType);
    try
     l_Para.WriteTag(Generator);
    finally
     Generator.Finish;
    end;
    // ������� ��������
    inherited;
    with f_Buffer.Tags.Top^.Box do
     DeleteChild(Pred(ChildrenCount));
   end
   else
   begin
    // �������� ������, �� ��� ������ ��������
    inherited;
    l_ID := f_Buffer.Tags.Top^.Box.IntA[k2_tiHandle];
    l3System.Msg2Log('���������� ������� ������ �������� � ����� %d', [l_ID]);
   end;
  end
  else
   inherited;
  // ���������� �����������
  StopBufferingAndFlush(NeedUndo, TopObject[SkipLevel-2], False);
  f_NeedToReport := False;
 end
 else
  inherited;
//#UC END# *4836D4C20059_4C56D4E002D2_impl*
end;//TevUnblockEmptyParaFilter.CloseStructure

function TevUnblockEmptyParaFilter.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_4C56D4E002D2_var*
//#UC END# *4C56D54B002A_4C56D4E002D2_var*
begin
//#UC START# *4C56D54B002A_4C56D4E002D2_impl*
 Result := (aID < 0) and (aID = -k2_idBlock);//TypeTable.TypeByHandle[-aID].IsKindOf(k2_typBlock);
//#UC END# *4C56D54B002A_4C56D4E002D2_impl*
end;//TevUnblockEmptyParaFilter.NeedStartBuffering

end.