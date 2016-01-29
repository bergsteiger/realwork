unit evTunedEditor_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestTest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTunedEditor_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::EverestTest::Editors::TevTunedEditor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\l3Define.inc}

interface

implementation

{$If not defined(XE)}
uses
  evTunedEditor,
  nevSelection,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TevTunedEditor

{$If not defined(XE)}
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
{$IfEnd} //not XE

{$If not defined(XE)}
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
{$IfEnd} //not XE

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TevTunedEditor, tc5OpenAppClasses.mtGet, 'IsDocumentTailVisible', TypeInfo(Boolean), [], [], TevTunedEditor_Get_IsDocumentTailVisible_Pub5);
 tc5PublicInfo._RegisterMethod(TevTunedEditor, tc5OpenAppClasses.mtGet, 'Selection', TypeInfo(TnevSelection), [], [], TevTunedEditor_Get_Selection_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TevTunedEditor, tc6OpenAppClasses.mtGet, 'IsDocumentTailVisible', TypeInfo(Boolean), [], [], TevTunedEditor_Get_IsDocumentTailVisible_Pub6);
 tc6PublicInfo._RegisterMethod(TevTunedEditor, tc6OpenAppClasses.mtGet, 'Selection', TypeInfo(TnevSelection), [], [], TevTunedEditor_Get_Selection_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.