unit ddPictureSegment;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddPictureSegment.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddPictureSegment
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddObjectSegment,
  ddTextSegment
  ;

type
 TddPictureSegment = class(TddObjectSegment)
 protected
 // realized methods
   function Clone: TddTextSegment; override;
 end;//TddPictureSegment

implementation

// start class TddPictureSegment

function TddPictureSegment.Clone: TddTextSegment;
//#UC START# *54DC46B50110_54D9ACA500F5_var*
//#UC END# *54DC46B50110_54D9ACA500F5_var*
begin
//#UC START# *54DC46B50110_54D9ACA500F5_impl*
 Result := TddPictureSegment.Create;
 Result.Assign(Self);
//#UC END# *54DC46B50110_54D9ACA500F5_impl*
end;//TddPictureSegment.Clone

end.