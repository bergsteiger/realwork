unit nsOpenDocOnNumberData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsOpenDocOnNumberData.pas"
// Начат: 28.10.2009 0*07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Navigation::TnsOpenDocOnNumberData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  NavigationInterfaces,
  l3CProtoObject,
  bsTypesNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsOpenDocOnNumberData = class(Tl3CProtoObject, InsOpenDocOnNumberData)
 private
 // private fields
   f_DocID : Integer;
   f_PosID : Integer;
   f_Internal : Boolean;
   f_History : Il3CString;
   f_Done : Boolean;
   f_PosType : TDocumentPositionType;
 protected
 // realized methods
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
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsOpenDocOnNumberData

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
end;

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_History := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsOpenDocOnNumberData.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.