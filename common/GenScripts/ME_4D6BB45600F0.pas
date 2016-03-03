unit nscSimpleEditor_p;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSimpleEditor_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\gui\Garant\Nemesis\l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
 , nscSimpleEditor
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

implementation

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3ImplUses
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TnscSimpleEditor, tc5OpenAppClasses.mtGet, 'Buffer', TypeInfo(AnsiString), [], [], TnscSimpleEditor_Get_Buffer_Pub5);
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

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TnscSimpleEditor, tc6OpenAppClasses.mtGet, 'Buffer', TypeInfo(AnsiString), [], [], TnscSimpleEditor_Get_Buffer_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
