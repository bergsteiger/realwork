unit evdF1HyperlinkCorrector;

// Модуль: "w:\common\components\gui\Garant\Everest\evdF1HyperlinkCorrector.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdF1HyperlinkCorrector" MUID: (52E0A8490387)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdCustomHyperlinkCorrector
;

type
 TevdF1HyperlinkCorrector = class(TevdCustomHyperlinkCorrector)
  protected
   function IsNeedCorrection: Boolean; override;
   function DoCorrectDocID(const aDocID: Integer): Integer; override;
   function CheckDocIDBeforeCorrection(const aDocID: Integer): Boolean; override;
 end;//TevdF1HyperlinkCorrector

implementation

uses
 l3ImplUses
 , evdVer
 , SysUtils
 //#UC START# *52E0A8490387impl_uses*
 //#UC END# *52E0A8490387impl_uses*
;

const
 c_F1DocIDThreshold = 100000;

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
