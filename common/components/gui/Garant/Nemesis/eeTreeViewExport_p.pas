unit eeTreeViewExport_p;

// Модуль: "w:\common\components\gui\Garant\Nemesis\eeTreeViewExport_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TeeTreeViewExport" MUID: (499C0C1A009E)

{$Include w:\common\components\gui\Garant\Nemesis\l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
 , eeTreeViewExport
 , l3TreeInterfaces
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

implementation

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3ImplUses
 , nscTaskPanelInterfaces
 , SysUtils
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

function TeeTreeViewExport_pm_GetCurrentNodeLevel(Self: TeeTreeViewExport): Integer;
//#UC START# *499C0C240318_499C0C1A009Eget_var*
//#UC END# *499C0C240318_499C0C1A009Eget_var*
begin
 with Self do
 begin
//#UC START# *499C0C240318_499C0C1A009Eget_impl*
  Result := TreeStruct.GetLevel(GetCurrentNode);
//#UC END# *499C0C240318_499C0C1A009Eget_impl*
 end;//with Self
end;//TeeTreeViewExport_pm_GetCurrentNodeLevel

function TeeTreeViewExport_pm_GetCurrentNodeIndex(Self: TeeTreeViewExport): Integer;
//#UC START# *499C0C3600B4_499C0C1A009Eget_var*
//#UC END# *499C0C3600B4_499C0C1A009Eget_var*
begin
 with Self do
 begin
//#UC START# *499C0C3600B4_499C0C1A009Eget_impl*
 Result := TreeStruct.GetIndex(GetCurrentNode);
//#UC END# *499C0C3600B4_499C0C1A009Eget_impl*
 end;//with Self
end;//TeeTreeViewExport_pm_GetCurrentNodeIndex

function TeeTreeViewExport_pm_GetCurrentNodeExpanded(Self: TeeTreeViewExport): Boolean;
//#UC START# *499C0C420199_499C0C1A009Eget_var*
//#UC END# *499C0C420199_499C0C1A009Eget_var*
begin
 with Self do
 begin
//#UC START# *499C0C420199_499C0C1A009Eget_impl*
  Result := TreeStruct.IsExpanded(GetCurrentNode);
//#UC END# *499C0C420199_499C0C1A009Eget_impl*
 end;//with Self
end;//TeeTreeViewExport_pm_GetCurrentNodeExpanded

function TeeTreeViewExport_pm_GetIsCurrentOperationEnabled(Self: TeeTreeViewExport): Boolean;
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
end;//TeeTreeViewExport_pm_GetIsCurrentOperationEnabled

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'CurrentNodeLevel', TypeInfo(Integer), [], [], TeeTreeViewExport_Get_CurrentNodeLevel_Pub5);
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'CurrentNodeIndex', TypeInfo(Integer), [], [], TeeTreeViewExport_Get_CurrentNodeIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'CurrentNodeExpanded', TypeInfo(Boolean), [], [], TeeTreeViewExport_Get_CurrentNodeExpanded_Pub5);
 tc5PublicInfo._RegisterMethod(TeeTreeViewExport, tc5OpenAppClasses.mtGet, 'IsCurrentOperationEnabled', TypeInfo(Boolean), [], [], TeeTreeViewExport_Get_IsCurrentOperationEnabled_Pub5);
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
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
