unit evTunedEditor_p;

// Модуль: "w:\common\components\gui\Garant\Everest\evTunedEditor_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TevTunedEditor" MUID: (4999A57C01BA)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , evTunedEditor
 , nevSelection
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

function TevTunedEditor_Get_IsDocumentTailVisible(Self: TevTunedEditor): Boolean;
//#UC START# *499A7B700283_4999A57C01BAget_var*
//#UC END# *499A7B700283_4999A57C01BAget_var*
begin
 with Self do
 begin
//#UC START# *499A7B700283_4999A57C01BAget_impl*
  Result := View.IsDocumentTailVisible;
//#UC END# *499A7B700283_4999A57C01BAget_impl*
 end;//with Self
end;//TevTunedEditor_Get_IsDocumentTailVisible

function TevTunedEditor_Get_Selection(Self: TevTunedEditor): TnevSelection;
//#UC START# *4999A61D00BC_4999A57C01BAget_var*
//#UC END# *4999A61D00BC_4999A57C01BAget_var*
begin
 with Self do
 begin
//#UC START# *4999A61D00BC_4999A57C01BAget_impl*
  Result := Selection;
//#UC END# *4999A61D00BC_4999A57C01BAget_impl*
 end;//with Self
end;//TevTunedEditor_Get_Selection

procedure TevTunedEditor_Get_IsDocumentTailVisible_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TevTunedEditor);
 try
  Value := (TevTunedEditor_Get_IsDocumentTailVisible(TevTunedEditor(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TevTunedEditor_Get_Selection_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TevTunedEditor);
 try
  Value := tc5PublicInfo.VarFromObject(TevTunedEditor_Get_Selection(TevTunedEditor(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TevTunedEditor, tc5OpenAppClasses.mtGet, 'IsDocumentTailVisible', TypeInfo(Boolean), [], [], TevTunedEditor_Get_IsDocumentTailVisible_Pub5);
 tc5PublicInfo._RegisterMethod(TevTunedEditor, tc5OpenAppClasses.mtGet, 'Selection', TypeInfo(TnevSelection), [], [], TevTunedEditor_Get_Selection_Pub5);
end;

procedure TevTunedEditor_Get_IsDocumentTailVisible_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TevTunedEditor);
 try
  Value := (TevTunedEditor_Get_IsDocumentTailVisible(TevTunedEditor(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TevTunedEditor_Get_Selection_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TevTunedEditor);
 try
  Value := tc6PublicInfo.VarFromObject(TevTunedEditor_Get_Selection(TevTunedEditor(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TevTunedEditor, tc6OpenAppClasses.mtGet, 'IsDocumentTailVisible', TypeInfo(Boolean), [], [], TevTunedEditor_Get_IsDocumentTailVisible_Pub6);
 tc6PublicInfo._RegisterMethod(TevTunedEditor, tc6OpenAppClasses.mtGet, 'Selection', TypeInfo(TnevSelection), [], [], TevTunedEditor_Get_Selection_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
