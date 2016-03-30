{$IfNDef nsNodeNotifierImplementation_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\NOT_COMPLETED_nsNodeNotifierImplementation.imp.pas"
// ���������: "Impurity"
// ������� ������: "nsNodeNotifierImplementation" MUID: (48FDA9D500E4)
// ��� ����: "_nsNodeNotifierImplementation_"

{$Define nsNodeNotifierImplementation_imp}

 _nsNodeNotifierBase_Parent_ = _nsNodeNotifierImplementation_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifierBase.imp.pas}
 _nsNodeNotifierImplementation_ = class(_nsNodeNotifierBase_, INodeNotifier)
  protected
   procedure OldChanging;
   procedure OldChanged;
   procedure ChangeChildrenCount(node_index: TVisibleIndex;
    delta: Integer;
    const index_path: INodeIndexPath;
    child_index: TIndexInParent); stdcall;
    {* ����������� �� ��������� ���-�� ������� ����� �� ���� � ��������� ��������. � ������ ���� ��������� ��� ������ ���� �� ���������������� � �� �� ������, ������ ������ ���� ����� ��� -1. 
parent_path - ���� � ���� � ������� ��������� ��������� (���� delta < 0 - ��������, ���� delta > 0 - �������)
    left_child_index - ������ ������� � ����: ���� ��������, �� ������� � �������� (������������) �� ������� delta ����������; ���� �������, �� ����� ����� �������� �� ��������� delta ���������.
    left_child_index, ����� ������� "�����������" �������� IIP_BEFORE_LEFT_CHILD (-1) - ���������� ������� "�� �������" - �������� ��� ������� � ������ �����. }
   procedure ResetChildrenCount; stdcall;
    {* ������������� ���-�� ����� = 0 }
   function IsRootVisible: ByteBool; stdcall;
    {* ������� ���������� ��� �� � ������� ����� }
   function IsOneLevel: ByteBool; stdcall;
    {* ������� ���������� ��� �� ������������� }
   procedure Invalidate(const index_path: INodeIndexPath); stdcall;
    {* ����������� � ������������� �����������. ������ ���������� ����� change_children_count (������� ����� �����������) ��� �������������� ��� ��������� ������ �� ��������� � ���-��� �����.
    parent_path - ���� � ���� � ������� ��������� ��������� }
   procedure Changing; stdcall;
    {* ������ �������� ��������� ������ }
   procedure Changed; stdcall;
    {* ����� �������� ��������� ������ }
   function GetId: TNotifierID; stdcall;
    {* ���������� ���������� ������������� ������� }
 end;//_nsNodeNotifierImplementation_

{$Else nsNodeNotifierImplementation_imp}

{$IfNDef nsNodeNotifierImplementation_imp_impl}

{$Define nsNodeNotifierImplementation_imp_impl}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifierBase.imp.pas}

procedure _nsNodeNotifierImplementation_.OldChanging;
//#UC START# *48FDAA2000B3_48FDA9D500E4_var*
//#UC END# *48FDAA2000B3_48FDA9D500E4_var*
begin
//#UC START# *48FDAA2000B3_48FDA9D500E4_impl*
 inherited Changing;
//#UC END# *48FDAA2000B3_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.OldChanging

procedure _nsNodeNotifierImplementation_.OldChanged;
//#UC START# *48FDAA330353_48FDA9D500E4_var*
//#UC END# *48FDAA330353_48FDA9D500E4_var*
begin
//#UC START# *48FDAA330353_48FDA9D500E4_impl*
 inherited Changed;
//#UC END# *48FDAA330353_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.OldChanged

procedure _nsNodeNotifierImplementation_.ChangeChildrenCount(node_index: TVisibleIndex;
 delta: Integer;
 const index_path: INodeIndexPath;
 child_index: TIndexInParent);
 {* ����������� �� ��������� ���-�� ������� ����� �� ���� � ��������� ��������. � ������ ���� ��������� ��� ������ ���� �� ���������������� � �� �� ������, ������ ������ ���� ����� ��� -1. 
parent_path - ���� � ���� � ������� ��������� ��������� (���� delta < 0 - ��������, ���� delta > 0 - �������)
    left_child_index - ������ ������� � ����: ���� ��������, �� ������� � �������� (������������) �� ������� delta ����������; ���� �������, �� ����� ����� �������� �� ��������� delta ���������.
    left_child_index, ����� ������� "�����������" �������� IIP_BEFORE_LEFT_CHILD (-1) - ���������� ������� "�� �������" - �������� ��� ������� � ������ �����. }
//#UC START# *45EEC8E102FE_48FDA9D500E4_var*
var
 l_Data: TnsThreadCallParamsRec;
//#UC END# *45EEC8E102FE_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E102FE_48FDA9D500E4_impl*
 if IsInGetByVisibleIndex then
  // ������ ��������������� � �������� ��������� ����
  f_CountViewChanged := True;

 if (GetCurrentThreadID = MainThreadID) then
  ChangeChildrenCountPrim(aNodeIndex, aDelta, aIndexPath, aChildIndex)
 else
 begin
  with l_Data do
  begin
   rNodeIndex := aNodeIndex;
   rDelta := aDelta;
   rIndexPath := aIndexPath;
   rChildIndex := aChildIndex;
  end;//with l_Data
  Synchronize(ChangeChildrenCountThread, @l_Data, SizeOf(l_Data), [l_Data.rIndexPath]);
 end;//GetCurrentThreadID = MainThreadID
//#UC END# *45EEC8E102FE_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.ChangeChildrenCount

procedure _nsNodeNotifierImplementation_.ResetChildrenCount;
 {* ������������� ���-�� ����� = 0 }
//#UC START# *45EEC8E10303_48FDA9D500E4_var*
//#UC END# *45EEC8E10303_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10303_48FDA9D500E4_impl*
 ResetChildrenCountPrim;
//#UC END# *45EEC8E10303_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.ResetChildrenCount

function _nsNodeNotifierImplementation_.IsRootVisible: ByteBool;
 {* ������� ���������� ��� �� � ������� ����� }
//#UC START# *45EEC8E10304_48FDA9D500E4_var*
//#UC END# *45EEC8E10304_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10304_48FDA9D500E4_impl*
 Result := GetShowRoot;
//#UC END# *45EEC8E10304_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.IsRootVisible

function _nsNodeNotifierImplementation_.IsOneLevel: ByteBool;
 {* ������� ���������� ��� �� ������������� }
//#UC START# *45EEC8E10305_48FDA9D500E4_var*
//#UC END# *45EEC8E10305_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10305_48FDA9D500E4_impl*
 Result := IsOneLevelPrim;
//#UC END# *45EEC8E10305_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.IsOneLevel

procedure _nsNodeNotifierImplementation_.Invalidate(const index_path: INodeIndexPath);
 {* ����������� � ������������� �����������. ������ ���������� ����� change_children_count (������� ����� �����������) ��� �������������� ��� ��������� ������ �� ��������� � ���-��� �����.
    parent_path - ���� � ���� � ������� ��������� ��������� }
//#UC START# *45EEC8E10306_48FDA9D500E4_var*
var
 l_Data: TnsThreadCallParamsRec;
//#UC END# *45EEC8E10306_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10306_48FDA9D500E4_impl*
 if (GetCurrentThreadID = MainThreadID) then
  InvalidatePrim
 else
 begin
  with l_Data do
  begin
   rNodeIndex := 0;
   rDelta := 0;
   rIndexPath := nil;
   rChildIndex := 0;
  end;//with l_Data
  Synchronize(InvalidateThread, @l_Data, SizeOf(l_Data));
 end;
//#UC END# *45EEC8E10306_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.Invalidate

procedure _nsNodeNotifierImplementation_.Changing;
 {* ������ �������� ��������� ������ }
//#UC START# *45EEC8E10308_48FDA9D500E4_var*
//#UC END# *45EEC8E10308_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10308_48FDA9D500E4_impl*
 // ��� �������� �������������� �� ���������������� � �������� �������, � ����������� �����
 // �.�. � ��� ���� ����������� ������� ���, ������� ������ ������ ��������������� � ������ ����� ������
 //
 // ������ � ���� ��������� �� ������������� ���������/������� ���������� ������� �� �������
 // ������� �������� � ��������� - ��� ����� ��������� � ���������� �������
 // ���� - ������� ������ ����������� �� ���������� �����������
 //        ������ � ���������� � ��� � �������� ����������� ������
 // ���� ����� - ������� ����� ������ ������������ ����������� ���������� �������
 //              �������/������� ���������� ������ ��� ���� ������ �� ����������� ������
 // ���� - ��������� Cleanup � �������� ���������� �� ���������� ����������� � ������ ��
 //        ���������� ��������
 ChangingPrim;
//#UC END# *45EEC8E10308_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.Changing

procedure _nsNodeNotifierImplementation_.Changed;
 {* ����� �������� ��������� ������ }
//#UC START# *45EEC8E10309_48FDA9D500E4_var*
var
 l_Data: TnsThreadCallParamsRec;
//#UC END# *45EEC8E10309_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10309_48FDA9D500E4_impl*
 if (GetCurrentThreadID = MainThreadID) then
  ChangedPrim
 else
 begin
  with l_Data do
  begin
   rNodeIndex := 0;
   rDelta := 0;
   rIndexPath := nil;
   rChildIndex := 0;
  end;//with l_Data
  Synchronize(ChangedThread, @l_Data, SizeOf(l_Data));
 end;
//#UC END# *45EEC8E10309_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.Changed

function _nsNodeNotifierImplementation_.GetId: TNotifierID;
 {* ���������� ���������� ������������� ������� }
//#UC START# *475E4B020072_48FDA9D500E4_var*
//#UC END# *475E4B020072_48FDA9D500E4_var*
begin
//#UC START# *475E4B020072_48FDA9D500E4_impl*
 Result := TNotifierID(Self);
//#UC END# *475E4B020072_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.GetId

{$EndIf nsNodeNotifierImplementation_imp_impl}

{$EndIf nsNodeNotifierImplementation_imp}

