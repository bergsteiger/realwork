unit eeTreeViewExport_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "NemesisTest"
// Модуль: "w:/common/components/gui/Garant/Nemesis/eeTreeViewExport_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi For F1::NemesisTest::Tree::TeeTreeViewExport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\l3Define.inc}

interface

implementation

{$If defined(Nemesis) AND not defined(XE)}
uses
  eeTreeViewExport,
  l3TreeInterfaces,
  nscTaskPanelInterfaces,
  SysUtils,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //Nemesis AND not XE

// start class TeeTreeViewExport

{$If defined(Nemesis) AND not defined(XE)}
function TeeTreeViewExport_Get_CurrentNodeLevel(Self: TeeTreeViewExport): Integer;
//#UC START# *499C0C240318_499C0C1A009Eget_var*
//#UC END# *499C0C240318_499C0C1A009Eget_var*
begin
 with Self do
 begin
//#UC START# *499C0C240318_499C0C1A009Eget_impl*
  Result := TreeStruct.GetLevel(GetCurrentNode);
//#UC END# *499C0C240318_499C0C1A009Eget_impl*
 end;//with Self
end;//TeeTreeViewExport_Get_CurrentNodeLevel
{$IfEnd} //Nemesis AND not XE

{$If defined(Nemesis) AND not defined(XE)}
function TeeTreeViewExport_Get_CurrentNodeIndex(Self: TeeTreeViewExport): Integer;
//#UC START# *499C0C3600B4_499C0C1A009Eget_var*
//#UC END# *499C0C3600B4_499C0C1A009Eget_var*
begin
 with Self do
 begin
//#UC START# *499C0C3600B4_499C0C1A009Eget_impl*
 Result := TreeStruct.GetIndex(GetCurrentNode);
//#UC END# *499C0C3600B4_499C0C1A009Eget_impl*
 end;//with Self
end;//TeeTreeViewExport_Get_CurrentNodeIndex
{$IfEnd} //Nemesis AND not XE

{$If defined(Nemesis) AND not defined(XE)}
function TeeTreeViewExport_Get_CurrentNodeExpanded(Self: TeeTreeViewExport): Boolean;
//#UC START# *499C0C420199_499C0C1A009Eget_var*
//#UC END# *499C0C420199_499C0C1A009Eget_var*
begin
 with Self do
 begin
//#UC START# *499C0C420199_499C0C1A009Eget_impl*
  Result := TreeStruct.IsExpanded(GetCurrentNode);
//#UC END# *499C0C420199_499C0C1A009Eget_impl*
 end;//with Self
end;//TeeTreeViewExport_Get_CurrentNodeExpanded
{$IfEnd} //Nemesis AND not XE

{$If defined(Nemesis) AND not defined(XE)}
function TeeTreeViewExport_Get_IsCurrentOperationEnabled(Self: TeeTreeViewExport): Boolean;
//#UC START# *499C1DC600BD_499C0C1A009Eget_var*
var
  l_Op: InscOperationNode;
//#UC END# *499C1DC600BD_499C0C1A009Eget_var*
begin
 with Self do
 begin
//#UC START# *499C1DC600BD_499C0C1A009Eget_impl*
  Result := False;
  try
   if Supports(GetCurrentNode, InscOperationNode, l_Op) then
    Result := l_Op.Op.RepOp.Action.Enabled
   else
    Result := false;
  except
    // гасим исключения
  end;
//#UC END# *499C1DC600BD_499C0C1A009Eget_impl*
 end;//with Self
end;//TeeTreeViewExport_Get_IsCurrentOperationEnabled
{$IfEnd} //Nemesis AND not XE

procedure TeeTreeViewExport_Get_CurrentNodeLevel_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_CurrentNodeLevel(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TeeTreeViewExport_Get_CurrentNodeLevel_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_CurrentNodeLevel(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TeeTreeViewExport_Get_CurrentNodeIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_CurrentNodeIndex(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TeeTreeViewExport_Get_CurrentNodeIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_CurrentNodeIndex(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TeeTreeViewExport_Get_CurrentNodeExpanded_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_CurrentNodeExpanded(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TeeTreeViewExport_Get_CurrentNodeExpanded_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_CurrentNodeExpanded(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TeeTreeViewExport_Get_IsCurrentOperationEnabled_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_IsCurrentOperationEnabled(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TeeTreeViewExport_Get_IsCurrentOperationEnabled_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TeeTreeViewExport);
 try
  Value := (TeeTreeViewExport_Get_IsCurrentOperationEnabled(TeeTreeViewExport(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'CurrentNodeLevel', TypeInfo(Integer), [], [], TeeTreeViewExport_Get_CurrentNodeLevel_Pub5);
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'CurrentNodeIndex', TypeInfo(Integer), [], [], TeeTreeViewExport_Get_CurrentNodeIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'CurrentNodeExpanded', TypeInfo(Boolean), [], [], TeeTreeViewExport_Get_CurrentNodeExpanded_Pub5);
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'IsCurrentOperationEnabled', TypeInfo(Boolean), [], [], TeeTreeViewExport_Get_IsCurrentOperationEnabled_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TeeTreeViewExport, tc6OpenAppClasses.mtGet, 'CurrentNodeLevel', TypeInfo(Integer), [], [], TeeTreeViewExport_Get_CurrentNodeLevel_Pub6);
 tc6PublicInfo._RegisterMethod(TeeTreeViewExport, tc6OpenAppClasses.mtGet, 'CurrentNodeIndex', TypeInfo(Integer), [], [], TeeTreeViewExport_Get_CurrentNodeIndex_Pub6);
 tc6PublicInfo._RegisterMethod(TeeTreeViewExport, tc6OpenAppClasses.mtGet, 'CurrentNodeExpanded', TypeInfo(Boolean), [], [], TeeTreeViewExport_Get_CurrentNodeExpanded_Pub6);
 tc6PublicInfo._RegisterMethod(TeeTreeViewExport, tc6OpenAppClasses.mtGet, 'IsCurrentOperationEnabled', TypeInfo(Boolean), [], [], TeeTreeViewExport_Get_IsCurrentOperationEnabled_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.