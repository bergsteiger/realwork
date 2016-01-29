unit NOT_FINISHED_ddRTFReader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_ddRTFReader.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::Readers::TddRTFReader
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddCustomRTFReader,
  ddDocumentAtom
  ;

type
 TddRTFReader = class(TddCustomRTFReader)
 protected
 // realized methods
   procedure BeforeClosePara(const aPara: TddDocumentAtom); override;
   procedure AddFooterHyperlink; override;
   procedure FootNoteSymbol; override;
 end;//TddRTFReader

implementation

// start class TddRTFReader

procedure TddRTFReader.BeforeClosePara(const aPara: TddDocumentAtom);
//#UC START# *534F8F4D0317_4C971BD4031B_var*
//#UC END# *534F8F4D0317_4C971BD4031B_var*
begin
//#UC START# *534F8F4D0317_4C971BD4031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *534F8F4D0317_4C971BD4031B_impl*
end;//TddRTFReader.BeforeClosePara

procedure TddRTFReader.AddFooterHyperlink;
//#UC START# *5624D5E80387_4C971BD4031B_var*
//#UC END# *5624D5E80387_4C971BD4031B_var*
begin
//#UC START# *5624D5E80387_4C971BD4031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5624D5E80387_4C971BD4031B_impl*
end;//TddRTFReader.AddFooterHyperlink

procedure TddRTFReader.FootNoteSymbol;
//#UC START# *562616AD01DF_4C971BD4031B_var*
//#UC END# *562616AD01DF_4C971BD4031B_var*
begin
//#UC START# *562616AD01DF_4C971BD4031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *562616AD01DF_4C971BD4031B_impl*
end;//TddRTFReader.FootNoteSymbol

end.