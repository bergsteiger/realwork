unit SubTree_p;

// Модуль: "w:\common\components\gui\Garant\VT\SubTree_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TSubTree" MUID: (499AE0580291)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , DropDownTree
;
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

procedure TSubTree_ExpandCurrentNode(Self: TSubTree);
//#UC START# *499AE07B0052_499AE0580291_var*
//#UC END# *499AE07B0052_499AE0580291_var*
begin
 with Self do
 begin
//#UC START# *499AE07B0052_499AE0580291_impl*
  TryExpandNode(GetCurrentNode, true);
//#UC END# *499AE07B0052_499AE0580291_impl*
 end;//with Self
end;//TSubTree_ExpandCurrentNode

procedure TSubTree_GoToBeginNode(Self: TSubTree);
 {* этот метод нужен потому что дерево не реагирует на нажатие Home, и вообще не получается перейти на его начало с клавиатуры }
//#UC START# *499AE507018E_499AE0580291_var*
//#UC END# *499AE507018E_499AE0580291_var*
begin
 with Self do
 begin
//#UC START# *499AE507018E_499AE0580291_impl*
  GotoOnNode(GetNode(0));
//#UC END# *499AE507018E_499AE0580291_impl*
 end;//with Self
end;//TSubTree_GoToBeginNode

function TSubTree_Get_CurrentNodeLevel(Self: TSubTree): Integer;
//#UC START# *499AE6750165_499AE0580291get_var*
//#UC END# *499AE6750165_499AE0580291get_var*
begin
 with Self do
 begin
//#UC START# *499AE6750165_499AE0580291get_impl*
  Result := TreeStruct.GetLevel(GetCurrentNode);
//#UC END# *499AE6750165_499AE0580291get_impl*
 end;//with Self
end;//TSubTree_Get_CurrentNodeLevel

function TSubTree_Get_CurrentNodeIndex(Self: TSubTree): Integer;
//#UC START# *499AE7600051_499AE0580291get_var*
//#UC END# *499AE7600051_499AE0580291get_var*
begin
 with Self do
 begin
//#UC START# *499AE7600051_499AE0580291get_impl*
 Result := TreeStruct.GetIndex(GetCurrentNode);
//#UC END# *499AE7600051_499AE0580291get_impl*
 end;//with Self
end;//TSubTree_Get_CurrentNodeIndex

function TSubTree_Get_CurrentNodeExpanded(Self: TSubTree): Boolean;
//#UC START# *499AE76A0273_499AE0580291get_var*
//#UC END# *499AE76A0273_499AE0580291get_var*
begin
 with Self do
 begin
//#UC START# *499AE76A0273_499AE0580291get_impl*
  Result := TreeStruct.IsExpanded(GetCurrentNode);
//#UC END# *499AE76A0273_499AE0580291get_impl*
 end;//with Self
end;//TSubTree_Get_CurrentNodeExpanded

procedure TSubTree_ExpandCurrentNode_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  TSubTree_ExpandCurrentNode(TSubTree(Instance));
 except
  // - гасим исключения
 end;//try..except
end;

procedure TSubTree_GoToBeginNode_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  TSubTree_GoToBeginNode(TSubTree(Instance));
 except
  // - гасим исключения
 end;//try..except
end;

procedure TSubTree_Get_CurrentNodeLevel_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  Value := (TSubTree_Get_CurrentNodeLevel(TSubTree(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TSubTree_Get_CurrentNodeIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  Value := (TSubTree_Get_CurrentNodeIndex(TSubTree(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TSubTree_Get_CurrentNodeExpanded_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  Value := (TSubTree_Get_CurrentNodeExpanded(TSubTree(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TSubTree, tc5OpenAppClasses.mtInvoke, 'ExpandCurrentNode', nil, [], [], TSubTree_ExpandCurrentNode_Pub5);
 tc5PublicInfo._RegisterMethod(TSubTree, tc5OpenAppClasses.mtInvoke, 'GoToBeginNode', nil, [], [], TSubTree_GoToBeginNode_Pub5);
 tc5PublicInfo._RegisterMethod(TSubTree, tc5OpenAppClasses.mtGet, 'CurrentNodeLevel', TypeInfo(Integer), [], [], TSubTree_Get_CurrentNodeLevel_Pub5);
 tc5PublicInfo._RegisterMethod(TSubTree, tc5OpenAppClasses.mtGet, 'CurrentNodeIndex', TypeInfo(Integer), [], [], TSubTree_Get_CurrentNodeIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TSubTree, tc5OpenAppClasses.mtGet, 'CurrentNodeExpanded', TypeInfo(Boolean), [], [], TSubTree_Get_CurrentNodeExpanded_Pub5);
end;

procedure TSubTree_ExpandCurrentNode_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  TSubTree_ExpandCurrentNode(TSubTree(Instance));
 except
  // - гасим исключения
 end;//try..except
end;

procedure TSubTree_GoToBeginNode_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  TSubTree_GoToBeginNode(TSubTree(Instance));
 except
  // - гасим исключения
 end;//try..except
end;

procedure TSubTree_Get_CurrentNodeLevel_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  Value := (TSubTree_Get_CurrentNodeLevel(TSubTree(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TSubTree_Get_CurrentNodeIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  Value := (TSubTree_Get_CurrentNodeIndex(TSubTree(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TSubTree_Get_CurrentNodeExpanded_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TSubTree);
 try
  Value := (TSubTree_Get_CurrentNodeExpanded(TSubTree(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TSubTree, tc6OpenAppClasses.mtInvoke, 'ExpandCurrentNode', nil, [], [], TSubTree_ExpandCurrentNode_Pub6);
 tc6PublicInfo._RegisterMethod(TSubTree, tc6OpenAppClasses.mtInvoke, 'GoToBeginNode', nil, [], [], TSubTree_GoToBeginNode_Pub6);
 tc6PublicInfo._RegisterMethod(TSubTree, tc6OpenAppClasses.mtGet, 'CurrentNodeLevel', TypeInfo(Integer), [], [], TSubTree_Get_CurrentNodeLevel_Pub6);
 tc6PublicInfo._RegisterMethod(TSubTree, tc6OpenAppClasses.mtGet, 'CurrentNodeIndex', TypeInfo(Integer), [], [], TSubTree_Get_CurrentNodeIndex_Pub6);
 tc6PublicInfo._RegisterMethod(TSubTree, tc6OpenAppClasses.mtGet, 'CurrentNodeExpanded', TypeInfo(Boolean), [], [], TSubTree_Get_CurrentNodeExpanded_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
