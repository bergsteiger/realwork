unit nscSimpleEditor_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "NemesisTest"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscSimpleEditor_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi For F1::NemesisTest::Editor::TnscSimpleEditor$ForTests
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
  nscSimpleEditor,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //Nemesis AND not XE

// start class TnscSimpleEditor

{$If defined(Nemesis) AND not defined(XE)}
function TnscSimpleEditor_Get_Buffer(Self: TnscSimpleEditor): AnsiString;
//#UC START# *4D6BB4690207_4D6BB45600F0get_var*
//#UC END# *4D6BB4690207_4D6BB45600F0get_var*
begin
 with Self do
 begin
//#UC START# *4D6BB4690207_4D6BB45600F0get_impl*
   Result := Buffer.S;
//#UC END# *4D6BB4690207_4D6BB45600F0get_impl*
 end;//with Self
end;//TnscSimpleEditor_Get_Buffer
{$IfEnd} //Nemesis AND not XE

procedure TnscSimpleEditor_Get_Buffer_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscSimpleEditor);
 try
  Value := (TnscSimpleEditor_Get_Buffer(TnscSimpleEditor(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnscSimpleEditor_Get_Buffer_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscSimpleEditor);
 try
  Value := (TnscSimpleEditor_Get_Buffer(TnscSimpleEditor(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TnscSimpleEditor, tc5OpenAppClasses.mtGet, 'Buffer', TypeInfo(AnsiString), [], [], TnscSimpleEditor_Get_Buffer_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TnscSimpleEditor, tc6OpenAppClasses.mtGet, 'Buffer', TypeInfo(AnsiString), [], [], TnscSimpleEditor_Get_Buffer_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.