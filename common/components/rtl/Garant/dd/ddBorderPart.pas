unit ddBorderPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddBorderPart.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddBorderPart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  RTFtypes,
  ddBaseObject,
  k2Interfaces,
  ddTypes
  ;

type
 TddBorderPart = class(TddBaseObject)
 private
 // private fields
   f_Width : Integer;
    {* Поле для свойства Width}
   f_Space : Integer;
    {* Поле для свойства Space}
   f_Color : Integer;
    {* Поле для свойства Color}
   f_FrameType : TddBorderType;
    {* Поле для свойства FrameType}
 protected
 // property methods
   function pm_GetEnable: Boolean;
   procedure pm_SetEnable(aValue: Boolean);
 protected
 // realized methods
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aLiteVersion: TddLiteVersion); override;
 public
 // overridden public methods
   procedure Assign(anObject: TddBaseObject); override;
 public
 // public methods
   procedure Clear;
 public
 // public properties
   property Width: Integer
     read f_Width
     write f_Width;
   property Space: Integer
     read f_Space
     write f_Space;
   property Color: Integer
     read f_Color
     write f_Color;
   property FrameType: TddBorderType
     read f_FrameType
     write f_FrameType;
   property Enable: Boolean
     read pm_GetEnable
     write pm_SetEnable;
 end;//TddBorderPart

implementation

uses
  Graphics,
  ddEVDTypesSupport,
  k2Tags
  ;

// start class TddBorderPart

procedure TddBorderPart.Clear;
//#UC START# *525E2CA7024F_525E2AE802B2_var*
//#UC END# *525E2CA7024F_525E2AE802B2_var*
begin
//#UC START# *525E2CA7024F_525E2AE802B2_impl*
 f_FrameType := btNone;
 f_Color := 0;
 f_Width := 0;
 f_Space := 20;
 inherited;
//#UC END# *525E2CA7024F_525E2AE802B2_impl*
end;//TddBorderPart.Clear

function TddBorderPart.pm_GetEnable: Boolean;
//#UC START# *525E2E760175_525E2AE802B2get_var*
//#UC END# *525E2E760175_525E2AE802B2get_var*
begin
//#UC START# *525E2E760175_525E2AE802B2get_impl*
 Result := f_FrameType <> btNone;
//#UC END# *525E2E760175_525E2AE802B2get_impl*
end;//TddBorderPart.pm_GetEnable

procedure TddBorderPart.pm_SetEnable(aValue: Boolean);
//#UC START# *525E2E760175_525E2AE802B2set_var*
//#UC END# *525E2E760175_525E2AE802B2set_var*
begin
//#UC START# *525E2E760175_525E2AE802B2set_impl*
 if aValue <> Enable then
 begin
  if aValue then
  begin
   f_FrameType := btSingleThick;
   f_Color := clBlack;
   f_Width := 10;
  end // if Enable
  else
   f_FrameType := btNone;  
 end; // if Value <> Enable
//#UC END# *525E2E760175_525E2AE802B2set_impl*
end;//TddBorderPart.pm_SetEnable

procedure TddBorderPart.Write2Generator(const Generator: Ik2TagGenerator;
  aLiteVersion: TddLiteVersion);
//#UC START# *54DC9795018B_525E2AE802B2_var*
//#UC END# *54DC9795018B_525E2AE802B2_var*
begin
//#UC START# *54DC9795018B_525E2AE802B2_impl*
 
//#UC END# *54DC9795018B_525E2AE802B2_impl*
end;//TddBorderPart.Write2Generator

procedure TddBorderPart.Assign(anObject: TddBaseObject);
//#UC START# *52BACF8A01A9_525E2AE802B2_var*
//#UC END# *52BACF8A01A9_525E2AE802B2_var*
begin
//#UC START# *52BACF8A01A9_525E2AE802B2_impl*
 if (anObject is TddBorderPart) then
 begin
  f_FrameType := TddBorderPart(anObject).f_FrameType;
  f_Color := TddBorderPart(anObject).f_Color;
  f_Width := TddBorderPart(anObject).f_Width;
  f_Space := TddBorderPart(anObject).f_Space;
 end // if (Source Is TddBorderPart) then
 else
  inherited Assign(anObject);
//#UC END# *52BACF8A01A9_525E2AE802B2_impl*
end;//TddBorderPart.Assign

end.