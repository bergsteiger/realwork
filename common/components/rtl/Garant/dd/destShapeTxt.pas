unit destShapeTxt;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destShapeTxt.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::TdestShapeTxt
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  destNorm,
  ddRTFState,
  ddRTFShape
  ;

type
 TdestShapeTxt = class(TdestNorm)
 protected
 // overridden protected methods
   function CanAddTable: Boolean; override;
 public
 // overridden public methods
   procedure Clear; override;
 public
 // public methods
   procedure Apply2Shape(aState: TddRTFState;
     aShape: TddRTFShape);
 end;//TdestShapeTxt

implementation

// start class TdestShapeTxt

procedure TdestShapeTxt.Apply2Shape(aState: TddRTFState;
  aShape: TddRTFShape);
//#UC START# *559CC89A011D_5461C20002DF_var*
//#UC END# *559CC89A011D_5461C20002DF_var*
begin
//#UC START# *559CC89A011D_5461C20002DF_impl*
 aShape.Append(aState, Self);
 Clear;
//#UC END# *559CC89A011D_5461C20002DF_impl*
end;//TdestShapeTxt.Apply2Shape

procedure TdestShapeTxt.Clear;
//#UC START# *51D27A48038E_5461C20002DF_var*
//#UC END# *51D27A48038E_5461C20002DF_var*
begin
//#UC START# *51D27A48038E_5461C20002DF_impl*
 ParagraphsClear;
 inherited;
//#UC END# *51D27A48038E_5461C20002DF_impl*
end;//TdestShapeTxt.Clear

function TdestShapeTxt.CanAddTable: Boolean;
//#UC START# *559516AA0098_5461C20002DF_var*
//#UC END# *559516AA0098_5461C20002DF_var*
begin
//#UC START# *559516AA0098_5461C20002DF_impl*
 Result := True;
//#UC END# *559516AA0098_5461C20002DF_impl*
end;//TdestShapeTxt.CanAddTable

end.