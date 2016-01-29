unit csDecisionPhrasesHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csDecisionPhrasesHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::CourtDecisionSabCheckerParams::csDecisionPhrasesHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3Variant,
  evdTasksHelpers,
  Classes
  ;

type
 DecisionPhrasesHelper = interface(StringListHelper{, CourtDecisionPhraseTag})
   ['{346E9451-D5D3-4B6F-B24E-34E87B721E5D}']
 end;//DecisionPhrasesHelper

 TDecisionPhrasesHelper = class(TAbstractStringListHelper, DecisionPhrasesHelper)
 protected
 // realized methods
   procedure DoAdd(const anItem: AnsiString); override;
   function DoGetStrings(anIndex: Integer): AnsiString; override;
 public
 // public methods
   class function Make(aValue: Tl3Tag): DecisionPhrasesHelper; reintroduce;
     {* Сигнатура фабрики TDecisionPhrasesHelper.Make }
 end;//TDecisionPhrasesHelper
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  CourtDecisionPhrase_Const
  ;

// start class TDecisionPhrasesHelper

class function TDecisionPhrasesHelper.Make(aValue: Tl3Tag): DecisionPhrasesHelper;
var
 l_Inst : TDecisionPhrasesHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TDecisionPhrasesHelper.DoAdd(const anItem: AnsiString);
//#UC START# *53EDDCE10317_53EDE216017A_var*
var
 l_Phrase : Tl3Tag;
//#UC END# *53EDDCE10317_53EDE216017A_var*
begin
//#UC START# *53EDDCE10317_53EDE216017A_impl*
 l_Phrase := k2_typCourtDecisionPhrase.MakeTag.AsObject;
 l_Phrase.StrW[k2_attrPhrase, nil] := anItem;
 Value.AddChild(l_Phrase);
//#UC END# *53EDDCE10317_53EDE216017A_impl*
end;//TDecisionPhrasesHelper.DoAdd

function TDecisionPhrasesHelper.DoGetStrings(anIndex: Integer): AnsiString;
//#UC START# *53F1FD130157_53EDE216017A_var*
//#UC END# *53F1FD130157_53EDE216017A_var*
begin
//#UC START# *53F1FD130157_53EDE216017A_impl*
 Result := Value.Child[anIndex].StrA[k2_attrPhrase];
//#UC END# *53F1FD130157_53EDE216017A_impl*
end;//TDecisionPhrasesHelper.DoGetStrings
{$IfEnd} //not Nemesis

end.