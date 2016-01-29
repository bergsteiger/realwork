unit evdF1HyperlinkCorrector;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evdF1HyperlinkCorrector.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevdF1HyperlinkCorrector
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdCustomHyperlinkCorrector
  ;

type
 TevdF1HyperlinkCorrector = class(TevdCustomHyperlinkCorrector)
 protected
 // overridden protected methods
   function IsNeedCorrection: Boolean; override;
   function DoCorrectDocID(const aDocID: Integer): Integer; override;
   function CheckDocIDBeforeCorrection(const aDocID: Integer): Boolean; override;
 end;//TevdF1HyperlinkCorrector

implementation

uses
  evdVer,
  SysUtils
  ;

const
   { Constants }
  c_F1DocIDThreshold = 100000;

// start class TevdF1HyperlinkCorrector

function TevdF1HyperlinkCorrector.IsNeedCorrection: Boolean;
//#UC START# *52E0B71902EC_52E0A8490387_var*
//#UC END# *52E0B71902EC_52E0A8490387_var*
begin
//#UC START# *52E0B71902EC_52E0A8490387_impl*
 Result := inherited IsNeedCorrection and  (CurrentVersion > evVer20Step) and
           (CurrentVersion mod evFormatCurVersionStep = 1);
//#UC END# *52E0B71902EC_52E0A8490387_impl*
end;//TevdF1HyperlinkCorrector.IsNeedCorrection

function TevdF1HyperlinkCorrector.DoCorrectDocID(const aDocID: Integer): Integer;
//#UC START# *52E0B7BF0023_52E0A8490387_var*
//#UC END# *52E0B7BF0023_52E0A8490387_var*
begin
//#UC START# *52E0B7BF0023_52E0A8490387_impl*
 Result := aDocID - c_F1DocIDThreshold;
 Result := inherited DoCorrectDocID(Result);
//#UC END# *52E0B7BF0023_52E0A8490387_impl*
end;//TevdF1HyperlinkCorrector.DoCorrectDocID

function TevdF1HyperlinkCorrector.CheckDocIDBeforeCorrection(const aDocID: Integer): Boolean;
//#UC START# *52E0B83400F0_52E0A8490387_var*
//#UC END# *52E0B83400F0_52E0A8490387_var*
begin
//#UC START# *52E0B83400F0_52E0A8490387_impl*
 Result := inherited CheckDocIDBeforeCorrection(aDocID);
 if Result then
 begin
  Result := aDocID > c_F1DocIDThreshold;
  Assert(Result, Format('Номер документа в ссылке из F1 меньше %d', [c_F1DocIDThreshold]));
 end;
//#UC END# *52E0B83400F0_52E0A8490387_impl*
end;//TevdF1HyperlinkCorrector.CheckDocIDBeforeCorrection

end.