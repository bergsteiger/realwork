unit evPhoneEdit;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evPhoneEdit.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevPhoneEdit" MUID: (48D25DD8039D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEditControl
 , evQueryCardInt
;

type
 TevPhoneEdit = class(TevEditControl, IevEditorPhoneField)
  private
   f_OtherField: Pointer;
    {* Ссылка на другое поле даты }
   f_IsStart: Boolean;
    {* Признак того, что дата задает начало интервала }
  protected
   function IsStart: Boolean;
    {* Контрол хранит начальную дату интервала. }
   function GetOtherField: IevEditorPhoneField;
    {* Другой контрол. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetIsClear: Boolean; override;
   procedure DoInitOtherField(const aValue: IevEditorControl;
    aIsStart: Boolean); override;
   procedure DoClearText; override;
 end;//TevPhoneEdit

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *48D25DD8039Dimpl_uses*
 //#UC END# *48D25DD8039Dimpl_uses*
;

function TevPhoneEdit.IsStart: Boolean;
 {* Контрол хранит начальную дату интервала. }
//#UC START# *47CD7F220315_48D25DD8039D_var*
//#UC END# *47CD7F220315_48D25DD8039D_var*
begin
//#UC START# *47CD7F220315_48D25DD8039D_impl*
 Result := f_IsStart;
//#UC END# *47CD7F220315_48D25DD8039D_impl*
end;//TevPhoneEdit.IsStart

function TevPhoneEdit.GetOtherField: IevEditorPhoneField;
 {* Другой контрол. }
//#UC START# *47CD7F300065_48D25DD8039D_var*
//#UC END# *47CD7F300065_48D25DD8039D_var*
begin
//#UC START# *47CD7F300065_48D25DD8039D_impl*
 Result := IevEditorPhoneField(f_OtherField);
//#UC END# *47CD7F300065_48D25DD8039D_impl*
end;//TevPhoneEdit.GetOtherField

procedure TevPhoneEdit.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48D25DD8039D_var*
//#UC END# *479731C50290_48D25DD8039D_var*
begin
//#UC START# *479731C50290_48D25DD8039D_impl*
 f_OtherField := nil;
 inherited;
//#UC END# *479731C50290_48D25DD8039D_impl*
end;//TevPhoneEdit.Cleanup

function TevPhoneEdit.GetIsClear: Boolean;
//#UC START# *48D24A66039B_48D25DD8039D_var*
//#UC END# *48D24A66039B_48D25DD8039D_var*
begin
//#UC START# *48D24A66039B_48D25DD8039D_impl*
 Result := IsFieldEmpty and GetOtherField.IsFieldEmpty;
//#UC END# *48D24A66039B_48D25DD8039D_impl*
end;//TevPhoneEdit.GetIsClear

procedure TevPhoneEdit.DoInitOtherField(const aValue: IevEditorControl;
 aIsStart: Boolean);
//#UC START# *48D24AA202D1_48D25DD8039D_var*
var
 l_Field: IevEditorPhoneField;
//#UC END# *48D24AA202D1_48D25DD8039D_var*
begin
//#UC START# *48D24AA202D1_48D25DD8039D_impl*
 inherited;
 if Supports(aValue, IevEditorPhoneField, l_Field) then
 try
  f_OtherField := Pointer(l_Field);
  if aIsStart then //чтобы не возникало бесконечных циклов
   IevEditorPhoneField(f_OtherField).InitOtherField(Self, False);
  f_IsStart := aIsStart;
 finally
  l_Field := nil;
 end;
//#UC END# *48D24AA202D1_48D25DD8039D_impl*
end;//TevPhoneEdit.DoInitOtherField

procedure TevPhoneEdit.DoClearText;
//#UC START# *48D24C9F02F5_48D25DD8039D_var*
//#UC END# *48D24C9F02F5_48D25DD8039D_var*
begin
//#UC START# *48D24C9F02F5_48D25DD8039D_impl*
 SetText(nil);
 IevEditorPhoneField(f_OtherField).Text := nil;
 Set_Valid(True);
//#UC END# *48D24C9F02F5_48D25DD8039D_impl*
end;//TevPhoneEdit.DoClearText

end.
