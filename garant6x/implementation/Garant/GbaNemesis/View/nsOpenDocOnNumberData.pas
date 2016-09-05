unit nsOpenDocOnNumberData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsOpenDocOnNumberData.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsOpenDocOnNumberData" MUID: (4AE760FD0182)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CProtoObject
 , NavigationInterfaces
 , l3Interfaces
 , bsTypesNew
;

type
 TnsOpenDocOnNumberData = class(Tl3CProtoObject, InsOpenDocOnNumberData)
  private
   f_DocID: Integer;
   f_PosID: Integer;
   f_Internal: Boolean;
   f_History: Il3CString;
   f_Done: Boolean;
   f_PosType: TDocumentPositionType;
  protected
   function Get_DocID: Integer;
   procedure Set_DocID(aValue: Integer);
   function Get_PosID: Integer;
   procedure Set_PosID(aValue: Integer);
   function Get_Internal: Boolean;
   procedure Set_Internal(aValue: Boolean);
   function Get_History: Il3CString;
   procedure Set_History(const aValue: Il3CString);
   function Get_Done: Boolean;
   procedure Set_Done(aValue: Boolean);
   function Get_PosType: TDocumentPositionType;
   procedure Set_PosType(aValue: TDocumentPositionType);
   procedure ClearFields; override;
  public
   constructor Create(aDocID: Integer;
    aPosID: Integer;
    aPosType: TDocumentPositionType;
    aInternal: Boolean;
    const aHistory: Il3CString); reintroduce;
   class function Make(aDocID: Integer;
    aPosID: Integer;
    aPosType: TDocumentPositionType;
    aInternal: Boolean;
    const aHistory: Il3CString): InsOpenDocOnNumberData; reintroduce;
 end;//TnsOpenDocOnNumberData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4AE760FD0182impl_uses*
 //#UC END# *4AE760FD0182impl_uses*
;

constructor TnsOpenDocOnNumberData.Create(aDocID: Integer;
 aPosID: Integer;
 aPosType: TDocumentPositionType;
 aInternal: Boolean;
 const aHistory: Il3CString);
//#UC START# *4AE761950144_4AE760FD0182_var*
//#UC END# *4AE761950144_4AE760FD0182_var*
begin
//#UC START# *4AE761950144_4AE760FD0182_impl*
 inherited Create;
 f_Done := false;
 f_DocID := aDocID;
 f_PosID := aPosID;
 f_PosType := aPosType;
 f_Internal := aInternal;
 f_History := aHistory;
//#UC END# *4AE761950144_4AE760FD0182_impl*
end;//TnsOpenDocOnNumberData.Create

class function TnsOpenDocOnNumberData.Make(aDocID: Integer;
 aPosID: Integer;
 aPosType: TDocumentPositionType;
 aInternal: Boolean;
 const aHistory: Il3CString): InsOpenDocOnNumberData;
var
 l_Inst : TnsOpenDocOnNumberData;
begin
 l_Inst := Create(aDocID, aPosID, aPosType, aInternal, aHistory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsOpenDocOnNumberData.Make

function TnsOpenDocOnNumberData.Get_DocID: Integer;
//#UC START# *4AE760B500BD_4AE760FD0182get_var*
//#UC END# *4AE760B500BD_4AE760FD0182get_var*
begin
//#UC START# *4AE760B500BD_4AE760FD0182get_impl*
 Result := f_DocID
//#UC END# *4AE760B500BD_4AE760FD0182get_impl*
end;//TnsOpenDocOnNumberData.Get_DocID

procedure TnsOpenDocOnNumberData.Set_DocID(aValue: Integer);
//#UC START# *4AE760B500BD_4AE760FD0182set_var*
//#UC END# *4AE760B500BD_4AE760FD0182set_var*
begin
//#UC START# *4AE760B500BD_4AE760FD0182set_impl*
 f_DocID := aValue;
//#UC END# *4AE760B500BD_4AE760FD0182set_impl*
end;//TnsOpenDocOnNumberData.Set_DocID

function TnsOpenDocOnNumberData.Get_PosID: Integer;
//#UC START# *4AE760C90313_4AE760FD0182get_var*
//#UC END# *4AE760C90313_4AE760FD0182get_var*
begin
//#UC START# *4AE760C90313_4AE760FD0182get_impl*
 Result := f_PosID;
//#UC END# *4AE760C90313_4AE760FD0182get_impl*
end;//TnsOpenDocOnNumberData.Get_PosID

procedure TnsOpenDocOnNumberData.Set_PosID(aValue: Integer);
//#UC START# *4AE760C90313_4AE760FD0182set_var*
//#UC END# *4AE760C90313_4AE760FD0182set_var*
begin
//#UC START# *4AE760C90313_4AE760FD0182set_impl*
 f_PosID := aValue;
//#UC END# *4AE760C90313_4AE760FD0182set_impl*
end;//TnsOpenDocOnNumberData.Set_PosID

function TnsOpenDocOnNumberData.Get_Internal: Boolean;
//#UC START# *4AE760D30088_4AE760FD0182get_var*
//#UC END# *4AE760D30088_4AE760FD0182get_var*
begin
//#UC START# *4AE760D30088_4AE760FD0182get_impl*
 Result := f_Internal;
//#UC END# *4AE760D30088_4AE760FD0182get_impl*
end;//TnsOpenDocOnNumberData.Get_Internal

procedure TnsOpenDocOnNumberData.Set_Internal(aValue: Boolean);
//#UC START# *4AE760D30088_4AE760FD0182set_var*
//#UC END# *4AE760D30088_4AE760FD0182set_var*
begin
//#UC START# *4AE760D30088_4AE760FD0182set_impl*
 f_Internal := aValue;
//#UC END# *4AE760D30088_4AE760FD0182set_impl*
end;//TnsOpenDocOnNumberData.Set_Internal

function TnsOpenDocOnNumberData.Get_History: Il3CString;
//#UC START# *4AE760DB01E2_4AE760FD0182get_var*
//#UC END# *4AE760DB01E2_4AE760FD0182get_var*
begin
//#UC START# *4AE760DB01E2_4AE760FD0182get_impl*
 Result := f_History;
//#UC END# *4AE760DB01E2_4AE760FD0182get_impl*
end;//TnsOpenDocOnNumberData.Get_History

procedure TnsOpenDocOnNumberData.Set_History(const aValue: Il3CString);
//#UC START# *4AE760DB01E2_4AE760FD0182set_var*
//#UC END# *4AE760DB01E2_4AE760FD0182set_var*
begin
//#UC START# *4AE760DB01E2_4AE760FD0182set_impl*
 f_History := aValue;
//#UC END# *4AE760DB01E2_4AE760FD0182set_impl*
end;//TnsOpenDocOnNumberData.Set_History

function TnsOpenDocOnNumberData.Get_Done: Boolean;
//#UC START# *4AE81AD9019D_4AE760FD0182get_var*
//#UC END# *4AE81AD9019D_4AE760FD0182get_var*
begin
//#UC START# *4AE81AD9019D_4AE760FD0182get_impl*
 Result := f_Done;
//#UC END# *4AE81AD9019D_4AE760FD0182get_impl*
end;//TnsOpenDocOnNumberData.Get_Done

procedure TnsOpenDocOnNumberData.Set_Done(aValue: Boolean);
//#UC START# *4AE81AD9019D_4AE760FD0182set_var*
//#UC END# *4AE81AD9019D_4AE760FD0182set_var*
begin
//#UC START# *4AE81AD9019D_4AE760FD0182set_impl*
 f_Done := aValue;
//#UC END# *4AE81AD9019D_4AE760FD0182set_impl*
end;//TnsOpenDocOnNumberData.Set_Done

function TnsOpenDocOnNumberData.Get_PosType: TDocumentPositionType;
//#UC START# *4CC90CCA0027_4AE760FD0182get_var*
//#UC END# *4CC90CCA0027_4AE760FD0182get_var*
begin
//#UC START# *4CC90CCA0027_4AE760FD0182get_impl*
 Result := f_PosType;
//#UC END# *4CC90CCA0027_4AE760FD0182get_impl*
end;//TnsOpenDocOnNumberData.Get_PosType

procedure TnsOpenDocOnNumberData.Set_PosType(aValue: TDocumentPositionType);
//#UC START# *4CC90CCA0027_4AE760FD0182set_var*
//#UC END# *4CC90CCA0027_4AE760FD0182set_var*
begin
//#UC START# *4CC90CCA0027_4AE760FD0182set_impl*
 f_PosType := aValue;
//#UC END# *4CC90CCA0027_4AE760FD0182set_impl*
end;//TnsOpenDocOnNumberData.Set_PosType

procedure TnsOpenDocOnNumberData.ClearFields;
begin
 f_History := nil;
 inherited;
end;//TnsOpenDocOnNumberData.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
