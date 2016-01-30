{$IfNDef VScroll_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\VScroll.imp.pas"
// ���������: "Impurity"

{$Define VScroll_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _VScroll_ = {abstract} class(_VScroll_Parent_)
  {* ���������� ������ ������� VScroll ������������� ������ � ����� ����������� � ���� InsVScrollListener }
  public
   procedure Sync(const aPara: TnsParaCoord);
    {* ���������������� ������� }
   procedure CurrentChangedFragmentChanged(aParaID: Integer);
    {* ���������� ��������� �������� ���������� ���������. ĸ����� � ��������� ������ ��� ��������. aParaID == GetParaForPositionning }
 end;//_VScroll_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_VScroll_ = _VScroll_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else VScroll_imp}

{$IfNDef VScroll_imp_impl}

{$Define VScroll_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _VScroll_.Sync(const aPara: TnsParaCoord);
 {* ���������������� ������� }
//#UC START# *4A79AB290196_4B548BE50138_var*
var
 l_Index : Integer;
 l_Intf  : InsVScrollListener;
 l_Item  : IUnknown;
//#UC END# *4A79AB290196_4B548BE50138_var*
begin
//#UC START# *4A79AB290196_4B548BE50138_impl*
 if (NotifiedObjList <> nil) then
  for l_Index := NotifiedObjList.Hi downto 0 do
   try
    l_Item := f_NotifiedObjList[l_Index];
    if Supports(l_Item, InsVScrollListener, l_Intf) AND
       (l_Item = l_Intf) then
     try
      l_Intf.Sync(aPara);
     finally
      l_Intf := nil;
     end;//try..finaly
   except
    on E: Exception do
     l3System.Exception2Log(E);
   end;//try..except
//#UC END# *4A79AB290196_4B548BE50138_impl*
end;//_VScroll_.Sync

procedure _VScroll_.CurrentChangedFragmentChanged(aParaID: Integer);
 {* ���������� ��������� �������� ���������� ���������. ĸ����� � ��������� ������ ��� ��������. aParaID == GetParaForPositionning }
//#UC START# *4B54676B0132_4B548BE50138_var*
var
 l_Index : Integer;
 l_Intf  : InsVScrollListener;
 l_Item  : IUnknown;
//#UC END# *4B54676B0132_4B548BE50138_var*
begin
//#UC START# *4B54676B0132_4B548BE50138_impl*
 if (NotifiedObjList <> nil) then
  for l_Index := NotifiedObjList.Hi downto 0 do
   try
    l_Item := f_NotifiedObjList[l_Index];
    if Supports(l_Item, InsVScrollListener, l_Intf) AND
       (l_Item = l_Intf) then
     try
      l_Intf.CurrentChangedFragmentChanged(aParaID);
     finally
      l_Intf := nil;
     end;//try..finaly
   except
    on E: Exception do
     l3System.Exception2Log(E);
   end;//try..except
//#UC END# *4B54676B0132_4B548BE50138_impl*
end;//_VScroll_.CurrentChangedFragmentChanged
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf VScroll_imp_impl}

{$EndIf VScroll_imp}

