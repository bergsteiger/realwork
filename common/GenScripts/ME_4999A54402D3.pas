unit afwCaret_p;

// Модуль: "w:\common\components\gui\Garant\Everest\afwCaret_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TafwCaret" MUID: (4999A54402D3)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , afwCaret
 , afwInsCaretType
 , afwOvrCaretType
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

function TafwCaret_Get_X(Self: TafwCaret): Integer;
//#UC START# *4999A591039A_4999A54402D3get_var*
//#UC END# *4999A591039A_4999A54402D3get_var*
begin
 with Self do
 begin
//#UC START# *4999A591039A_4999A54402D3get_impl*
  Result := Position.X;
//#UC END# *4999A591039A_4999A54402D3get_impl*
 end;//with Self
end;//TafwCaret_Get_X

function TafwCaret_Get_Y(Self: TafwCaret): Integer;
//#UC START# *4999A59B011A_4999A54402D3get_var*
//#UC END# *4999A59B011A_4999A54402D3get_var*
begin
 with Self do
 begin
//#UC START# *4999A59B011A_4999A54402D3get_impl*
  Result := Position.Y;
//#UC END# *4999A59B011A_4999A54402D3get_impl*
 end;//with Self
end;//TafwCaret_Get_Y

function TafwCaret_Get_CellHeight(Self: TafwCaret): Integer;
//#UC START# *4999A5A5023C_4999A54402D3get_var*
//#UC END# *4999A5A5023C_4999A54402D3get_var*
begin
 with Self do
 begin
//#UC START# *4999A5A5023C_4999A54402D3get_impl*
  Result := CellHeight;
//#UC END# *4999A5A5023C_4999A54402D3get_impl*
 end;//with Self
end;//TafwCaret_Get_CellHeight

function TafwCaret_Get_CellWidth(Self: TafwCaret): Integer;
//#UC START# *4999A5B103E1_4999A54402D3get_var*
//#UC END# *4999A5B103E1_4999A54402D3get_var*
begin
 with Self do
 begin
//#UC START# *4999A5B103E1_4999A54402D3get_impl*
  Result := CellWidth;
//#UC END# *4999A5B103E1_4999A54402D3get_impl*
 end;//with Self
end;//TafwCaret_Get_CellWidth

function TafwCaret_Get_InsCaretType(Self: TafwCaret): TafwInsCaretType;
//#UC START# *4999A5DB03C9_4999A54402D3get_var*
//#UC END# *4999A5DB03C9_4999A54402D3get_var*
begin
 with Self do
 begin
//#UC START# *4999A5DB03C9_4999A54402D3get_impl*
  Result := InsCaretType;
//#UC END# *4999A5DB03C9_4999A54402D3get_impl*
 end;//with Self
end;//TafwCaret_Get_InsCaretType

function TafwCaret_Get_OvrCaretType(Self: TafwCaret): TafwOvrCaretType;
//#UC START# *4999A5E5007C_4999A54402D3get_var*
//#UC END# *4999A5E5007C_4999A54402D3get_var*
begin
 with Self do
 begin
//#UC START# *4999A5E5007C_4999A54402D3get_impl*
  Result := OvrCaretType;
//#UC END# *4999A5E5007C_4999A54402D3get_impl*
 end;//with Self
end;//TafwCaret_Get_OvrCaretType

procedure TafwCaret_Get_X_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_X(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_Y_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_Y(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_CellHeight_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_CellHeight(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_CellWidth_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_CellWidth(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_InsCaretType_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := tc5PublicInfo.VarFromObject(TafwCaret_Get_InsCaretType(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_OvrCaretType_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := tc5PublicInfo.VarFromObject(TafwCaret_Get_OvrCaretType(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TafwCaret, tc5OpenAppClasses.mtGet, 'X', TypeInfo(Integer), [], [], TafwCaret_Get_X_Pub5);
 tc5PublicInfo._RegisterMethod(TafwCaret, tc5OpenAppClasses.mtGet, 'Y', TypeInfo(Integer), [], [], TafwCaret_Get_Y_Pub5);
 tc5PublicInfo._RegisterMethod(TafwCaret, tc5OpenAppClasses.mtGet, 'CellHeight', TypeInfo(Integer), [], [], TafwCaret_Get_CellHeight_Pub5);
 tc5PublicInfo._RegisterMethod(TafwCaret, tc5OpenAppClasses.mtGet, 'CellWidth', TypeInfo(Integer), [], [], TafwCaret_Get_CellWidth_Pub5);
 tc5PublicInfo._RegisterMethod(TafwCaret, tc5OpenAppClasses.mtGet, 'InsCaretType', TypeInfo(TafwInsCaretType), [], [], TafwCaret_Get_InsCaretType_Pub5);
 tc5PublicInfo._RegisterMethod(TafwCaret, tc5OpenAppClasses.mtGet, 'OvrCaretType', TypeInfo(TafwOvrCaretType), [], [], TafwCaret_Get_OvrCaretType_Pub5);
end;

procedure TafwCaret_Get_X_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_X(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_Y_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_Y(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_CellHeight_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_CellHeight(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_CellWidth_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := (TafwCaret_Get_CellWidth(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_InsCaretType_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := tc6PublicInfo.VarFromObject(TafwCaret_Get_InsCaretType(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TafwCaret_Get_OvrCaretType_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TafwCaret);
 try
  Value := tc6PublicInfo.VarFromObject(TafwCaret_Get_OvrCaretType(TafwCaret(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TafwCaret, tc6OpenAppClasses.mtGet, 'X', TypeInfo(Integer), [], [], TafwCaret_Get_X_Pub6);
 tc6PublicInfo._RegisterMethod(TafwCaret, tc6OpenAppClasses.mtGet, 'Y', TypeInfo(Integer), [], [], TafwCaret_Get_Y_Pub6);
 tc6PublicInfo._RegisterMethod(TafwCaret, tc6OpenAppClasses.mtGet, 'CellHeight', TypeInfo(Integer), [], [], TafwCaret_Get_CellHeight_Pub6);
 tc6PublicInfo._RegisterMethod(TafwCaret, tc6OpenAppClasses.mtGet, 'CellWidth', TypeInfo(Integer), [], [], TafwCaret_Get_CellWidth_Pub6);
 tc6PublicInfo._RegisterMethod(TafwCaret, tc6OpenAppClasses.mtGet, 'InsCaretType', TypeInfo(TafwInsCaretType), [], [], TafwCaret_Get_InsCaretType_Pub6);
 tc6PublicInfo._RegisterMethod(TafwCaret, tc6OpenAppClasses.mtGet, 'OvrCaretType', TypeInfo(TafwOvrCaretType), [], [], TafwCaret_Get_OvrCaretType_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
