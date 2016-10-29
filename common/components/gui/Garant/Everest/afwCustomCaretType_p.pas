unit afwCustomCaretType_p;

// Модуль: "w:\common\components\gui\Garant\Everest\afwCustomCaretType_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TafwCustomCaretType" MUID: (4999A8660215)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , afwCustomCaretType
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

function TafwCustomCaretType_pm_GetCaretHeight(Self: TafwCustomCaretType): Integer;
//#UC START# *4999A885032B_4999A8660215get_var*
//#UC END# *4999A885032B_4999A8660215get_var*
begin
 with Self do
 begin
//#UC START# *4999A885032B_4999A8660215get_impl*
  Result := CaretHeight;
//#UC END# *4999A885032B_4999A8660215get_impl*
 end;//with Self
end;//TafwCustomCaretType_pm_GetCaretHeight

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TafwCustomCaretType, tc5OpenAppClasses.mtGet, 'CaretHeight', TypeInfo(Integer), [], [], TafwCustomCaretType_Get_CaretHeight_Pub5);
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

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TafwCustomCaretType, tc6OpenAppClasses.mtGet, 'CaretHeight', TypeInfo(Integer), [], [], TafwCustomCaretType_Get_CaretHeight_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
