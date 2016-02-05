{$IfNDef nevTinyParaXTool_imp}

// ������: "w:\common\components\gui\Garant\Everest\new\nevTinyParaXTool.imp.pas"
// ���������: "Impurity"

{$Define nevTinyParaXTool_imp}

 // _X_

 _nevTinyParaXTool_ = class(Tl3ProtoObject)
  private
   f_ParaX: _X_;
    {* ���� ��� �������� ParaX }
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(aTag: Tl3Variant); reintroduce;
  protected
   property ParaX: _X_
    read f_ParaX;
 end;//_nevTinyParaXTool_

{$Else nevTinyParaXTool_imp}

{$IfNDef nevTinyParaXTool_imp_impl}

{$Define nevTinyParaXTool_imp_impl}

constructor _nevTinyParaXTool_.Create(aTag: Tl3Variant);
//#UC START# *49E7692B0058_49E7612601CC_var*
//#UC END# *49E7692B0058_49E7612601CC_var*
begin
//#UC START# *49E7692B0058_49E7612601CC_impl*
 inherited Create;
 //if aTag.IsValid then
 // - ��� ��������� �������� ��� Painter'�� � FontTool
  if not aTag.QT(_X_, f_ParaX) then
   Assert(false, Format('�� �������������� ��������� %s [%s]',
                        [GUIDToString(_X_),  ClassName]));
//#UC END# *49E7692B0058_49E7612601CC_impl*
end;//_nevTinyParaXTool_.Create

procedure _nevTinyParaXTool_.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_49E7612601CC_var*
//#UC END# *479731C50290_49E7612601CC_var*
begin
//#UC START# *479731C50290_49E7612601CC_impl*
 f_ParaX := nil;
 inherited;
//#UC END# *479731C50290_49E7612601CC_impl*
end;//_nevTinyParaXTool_.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function _nevTinyParaXTool_.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_49E7612601CC_var*
//#UC END# *47A6FEE600FC_49E7612601CC_var*
begin
//#UC START# *47A6FEE600FC_49E7612601CC_impl*
 Result := true;
//#UC END# *47A6FEE600FC_49E7612601CC_impl*
end;//_nevTinyParaXTool_.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$EndIf nevTinyParaXTool_imp_impl}

{$EndIf nevTinyParaXTool_imp}

