unit nevSelection_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestTest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevSelection_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::EverestTest::Editors::TnevSelection
//
// Выделение в редакторе
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
  nevBase,
  afwCaret,
  nevSelection,
  k2Tags,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TnevSelection

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectType(Self: TnevSelection): AnsiString;
//#UC START# *499985C40249_49997D89034Eget_var*
//#UC END# *499985C40249_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *499985C40249_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.AsObject.StrA[k2_tiType];
//#UC END# *499985C40249_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectType
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectName(Self: TnevSelection): AnsiString;
//#UC START# *4999A08E01C9_49997D89034Eget_var*
//#UC END# *4999A08E01C9_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A08E01C9_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.AsObject.StrA[k2_tiName];
//#UC END# *4999A08E01C9_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectName
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectShortName(Self: TnevSelection): AnsiString;
//#UC START# *4999A09D0016_49997D89034Eget_var*
//#UC END# *4999A09D0016_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A09D0016_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.AsObject.StrA[k2_tiShortName];
//#UC END# *4999A09D0016_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectShortName
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectText(Self: TnevSelection): AnsiString;
//#UC START# *4999A0A60316_49997D89034Eget_var*
//#UC END# *4999A0A60316_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A0A60316_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.AsObject.StrA[k2_tiText];
//#UC END# *4999A0A60316_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectText
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectOwnerReqId(Self: TnevSelection): AnsiString;
//#UC START# *4999A0B201AF_49997D89034Eget_var*
//#UC END# *4999A0B201AF_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A0B201AF_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.OwnerObj.OwnerObj.AsObject.StrA[k2_tiReqID];
//#UC END# *4999A0B201AF_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectOwnerReqId
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectRowID(Self: TnevSelection): TnevParaIndex;
//#UC START# *4999A0D501E5_49997D89034Eget_var*
//#UC END# *4999A0D501E5_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A0D501E5_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.OwnerObj.OwnerObj.PID;
//#UC END# *4999A0D501E5_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectRowID
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectCellID(Self: TnevSelection): TnevParaIndex;
//#UC START# *4999A0F302F1_49997D89034Eget_var*
//#UC END# *4999A0F302F1_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A0F302F1_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.OwnerObj.PID;
//#UC END# *4999A0F302F1_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectCellID
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectOwnerText(Self: TnevSelection): AnsiString;
//#UC START# *4999A10101CF_49997D89034Eget_var*
//#UC END# *4999A10101CF_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A10101CF_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.OwnerObj.AsObject.StrA[k2_tiText];
//#UC END# *4999A10101CF_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectOwnerText
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CurrentObjectState(Self: TnevSelection): Integer;
//#UC START# *4999A10C005F_49997D89034Eget_var*
//#UC END# *4999A10C005F_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A10C005F_49997D89034Eget_impl*
  Result := Cursor.MostInner.Obj.AsObject.IntA[k2_tiStateIndex] - Cursor.MostInner.Obj.AsObject.IntA[k2_tiImageIndex];
//#UC END# *4999A10C005F_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CurrentObjectState
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_CardType(Self: TnevSelection): Integer;
//#UC START# *4999A1180355_49997D89034Eget_var*
//#UC END# *4999A1180355_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A1180355_49997D89034Eget_impl*
  Result := Document.IntA[k2_tiCardType];
//#UC END# *4999A1180355_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_CardType
{$IfEnd} //not XE

{$If not defined(XE)}
function TnevSelection_Get_Caret(Self: TnevSelection): TafwCaret;
//#UC START# *4999A48D0296_49997D89034Eget_var*
//#UC END# *4999A48D0296_49997D89034Eget_var*
begin
 with Self do
 begin
//#UC START# *4999A48D0296_49997D89034Eget_impl*
  Result := Caret;
//#UC END# *4999A48D0296_49997D89034Eget_impl*
 end;//with Self
end;//TnevSelection_Get_Caret
{$IfEnd} //not XE

procedure TnevSelection_Get_CurrentObjectType_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectType(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectType_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectType(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectName_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectName(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectName_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectName(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectShortName_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectShortName(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectShortName_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectShortName(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectText_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectText(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectText_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectText(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectOwnerReqId_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectOwnerReqId(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectOwnerReqId_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectOwnerReqId(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectRowID_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectRowID(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectRowID_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectRowID(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectCellID_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectCellID(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectCellID_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectCellID(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectOwnerText_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectOwnerText(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectOwnerText_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectOwnerText(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectState_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectState(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CurrentObjectState_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CurrentObjectState(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CardType_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CardType(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_CardType_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := (TnevSelection_Get_CardType(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_Caret_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := tc5PublicInfo.VarFromObject(TnevSelection_Get_Caret(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnevSelection_Get_Caret_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnevSelection);
 try
  Value := tc6PublicInfo.VarFromObject(TnevSelection_Get_Caret(TnevSelection(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectType', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectType_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectName', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectName_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectShortName', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectShortName_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectText', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectText_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectOwnerReqId', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectOwnerReqId_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectRowID', TypeInfo(TnevParaIndex), [], [], TnevSelection_Get_CurrentObjectRowID_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectCellID', TypeInfo(TnevParaIndex), [], [], TnevSelection_Get_CurrentObjectCellID_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectOwnerText', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectOwnerText_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CurrentObjectState', TypeInfo(Integer), [], [], TnevSelection_Get_CurrentObjectState_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'CardType', TypeInfo(Integer), [], [], TnevSelection_Get_CardType_Pub5);
 tc5PublicInfo._RegisterMethod(TnevSelection, tc5OpenAppClasses.mtGet, 'Caret', TypeInfo(TafwCaret), [], [], TnevSelection_Get_Caret_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectType', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectType_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectName', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectName_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectShortName', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectShortName_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectText', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectText_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectOwnerReqId', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectOwnerReqId_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectRowID', TypeInfo(TnevParaIndex), [], [], TnevSelection_Get_CurrentObjectRowID_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectCellID', TypeInfo(TnevParaIndex), [], [], TnevSelection_Get_CurrentObjectCellID_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectOwnerText', TypeInfo(AnsiString), [], [], TnevSelection_Get_CurrentObjectOwnerText_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CurrentObjectState', TypeInfo(Integer), [], [], TnevSelection_Get_CurrentObjectState_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'CardType', TypeInfo(Integer), [], [], TnevSelection_Get_CardType_Pub6);
 tc6PublicInfo._RegisterMethod(TnevSelection, tc6OpenAppClasses.mtGet, 'Caret', TypeInfo(TafwCaret), [], [], TnevSelection_Get_Caret_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.