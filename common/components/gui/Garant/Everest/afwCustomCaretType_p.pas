unit afwCustomCaretType_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestTest"
// Модуль: "w:/common/components/gui/Garant/Everest/afwCustomCaretType_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::EverestTest::Editors::TafwCustomCaretType
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
  afwCustomCaretType,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TafwCustomCaretType

{$If not defined(XE)}
function TafwCustomCaretType_Get_CaretHeight(Self: TafwCustomCaretType): Integer;
//#UC START# *4999A885032B_4999A8660215get_var*
//#UC END# *4999A885032B_4999A8660215get_var*
begin
 with Self do
 begin
//#UC START# *4999A885032B_4999A8660215get_impl*
  Result := CaretHeight;
//#UC END# *4999A885032B_4999A8660215get_impl*
 end;//with Self
end;//TafwCustomCaretType_Get_CaretHeight
{$IfEnd} //not XE

procedure TafwCustomCaretType_Get_CaretHeight_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCustomCaretType);
 try
  Value := (TafwCustomCaretType_Get_CaretHeight(TafwCustomCaretType(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCustomCaretType_Get_CaretHeight_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCustomCaretType);
 try
  Value := (TafwCustomCaretType_Get_CaretHeight(TafwCustomCaretType(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TafwCustomCaretType, tc5OpenAppClasses.mtGet, 'CaretHeight', TypeInfo(Integer), [], [], TafwCustomCaretType_Get_CaretHeight_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TafwCustomCaretType, tc6OpenAppClasses.mtGet, 'CaretHeight', TypeInfo(Integer), [], [], TafwCustomCaretType_Get_CaretHeight_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.