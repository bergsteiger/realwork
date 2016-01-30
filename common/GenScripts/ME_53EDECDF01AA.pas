unit csDecisionPhrasesHelper;

// Модуль: "w:\common\components\rtl\Garant\cs\csDecisionPhrasesHelper.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , evdTasksHelpers
 , CourtDecisionPhrase_Const
 , Classes
 , l3Variant
;

type
 DecisionPhrasesHelper = interface(StringListHelper)
  ['{346E9451-D5D3-4B6F-B24E-34E87B721E5D}']
 end;//DecisionPhrasesHelper

 TDecisionPhrasesHelper = class(TAbstractStringListHelper, DecisionPhrasesHelper)
  protected
   procedure DoAdd(const anItem: AnsiString); override;
   function DoGetStrings(anIndex: Integer): AnsiString; override;
  public
   class function Make(aValue: Tl3Tag): DecisionPhrasesHelper; reintroduce;
 end;//TDecisionPhrasesHelper
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

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
end;//TDecisionPhrasesHelper.Make

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
{$IfEnd} // NOT Defined(Nemesis)

end.
