{$IfNDef nevTinyParaXTool_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTinyParaXTool.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevTinyParaXTool" MUID: (49E7612601CC)
// Имя типа: "_nevTinyParaXTool_"

{$Define nevTinyParaXTool_imp}

 // _X_

 _nevTinyParaXTool_ = class(Tl3ProtoObject)
  private
   f_ParaX: _X_;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
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
 // - эта идиотская проверка для Painter'ов и FontTool
  if not aTag.QT(_X_, f_ParaX) then
   Assert(false, Format('Не поддерживается интерфейс %s [%s]',
                        [GUIDToString(_X_),  ClassName]));
//#UC END# *49E7692B0058_49E7612601CC_impl*
end;//_nevTinyParaXTool_.Create

procedure _nevTinyParaXTool_.Cleanup;
 {* Функция очистки полей объекта. }
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
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_49E7612601CC_var*
//#UC END# *47A6FEE600FC_49E7612601CC_var*
begin
//#UC START# *47A6FEE600FC_49E7612601CC_impl*
 Result := true;
//#UC END# *47A6FEE600FC_49E7612601CC_impl*
end;//_nevTinyParaXTool_.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure _nevTinyParaXTool_.ClearFields;
begin
 Finalize(f_ParaX);
 inherited;
end;//_nevTinyParaXTool_.ClearFields

{$EndIf nevTinyParaXTool_imp_impl}

{$EndIf nevTinyParaXTool_imp}

