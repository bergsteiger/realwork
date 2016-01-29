{$IfNDef CurrentChangedListener_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/CurrentChangedListener.imp.pas"
// �����: 2008/01/30 08:25:26
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 ������� ����������� ���������� �������::SearchLite::Search::Search::CurrentChangedListener
//
// ������ ��������� ��� ���������� ��������� ��������� ����������
// ����������� �� ��������� �������� � ������ � �������� ������ ��
// ����������� ����� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define CurrentChangedListener_imp}
 _CurrentChangedListener_ = {mixin} class(_CurrentChangedListener_Parent_)
  {* ������ ��������� ��� ���������� ��������� ��������� ����������
����������� �� ��������� �������� � ������ � �������� ������ ��
����������� ����� ����������. }
 public
 // realized methods
   procedure Process(const aNode: Il3SimpleNode);
     {* ���������� ������� }
 protected
 // protected methods
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); virtual;
 end;//_CurrentChangedListener_

{$Else CurrentChangedListener_imp}

// start class _CurrentChangedListener_

procedure _CurrentChangedListener_.CurrentChangedNotification(const aNode: Il3SimpleNode);
//#UC START# *49242A4E0252_492428D203A1_var*
var
 l_Index    : Integer;
 l_Listener : IbsCurrentChangedListener;
 l_Item     : IUnknown;
//#UC END# *49242A4E0252_492428D203A1_var*
begin
//#UC START# *49242A4E0252_492428D203A1_impl*
 if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := NotifiedObjList.Items[l_Index];
   if Supports(l_Item, IbsCurrentChangedListener, l_Listener) and
     (l_Item = l_Listener) then
    l_Listener.Process(aNode);
  end;//if (NotifiedObjList <> nil)
//#UC END# *49242A4E0252_492428D203A1_impl*
end;//_CurrentChangedListener_.CurrentChangedNotification

procedure _CurrentChangedListener_.Process(const aNode: Il3SimpleNode);
//#UC START# *49590D4802EE_492428D203A1_var*
//#UC END# *49590D4802EE_492428D203A1_var*
begin
//#UC START# *49590D4802EE_492428D203A1_impl*
 CurrentChangedNotification(aNode);
//#UC END# *49590D4802EE_492428D203A1_impl*
end;//_CurrentChangedListener_.Process

{$EndIf CurrentChangedListener_imp}
