unit nevControlPara;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevControlPara.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevControlPara" MUID: (48D11BE0015E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevTextPara
 , nevTools
 , evQueryCardInt
 , l3Variant
 , l3Interfaces
 , evdTypes
 , nevBase
;

type
 TnevControlPara = class(TnevTextPara, IevCommonControl, IevControl, IevControlFriend)
  protected
   function Get_Enabled: Boolean;
   function Get_Checked: Boolean;
   procedure Set_Checked(aValue: Boolean);
   function Get_Flat: Boolean;
   function Get_Name: Tl3WString;
   function Get_Text: Tl3WString;
   function Get_ControlType: TevControlType;
   function Get_Upper: Boolean;
   procedure Set_Upper(aValue: Boolean);
   function pm_GetCollapsed: Boolean;
   procedure pm_SetCollapsed(aValue: Boolean);
   function GetControl: IevEditorControl;
    {* Получить контрол по ссылке. }
   function TreatCollapsedAsHidden: Boolean; override;
   function GetText: TnevStr; override;
  public
   class function Make(aTag: Tl3Variant): IevControlFriend; reintroduce;
 end;//TnevControlPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , l3StringIDEx
 , k2Tags
 , l3String
 , afwFacade
 , afwInterfaces
;

const
 {* Локализуемые строки Local }
 str_MemoHintForConsult: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MemoHintForConsult'; rValue : 'Введите текст запроса');
  {* 'Введите текст запроса' }

class function TnevControlPara.Make(aTag: Tl3Variant): IevControlFriend;
var
 l_Inst : TnevControlPara;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevControlPara.Make

function TnevControlPara.Get_Enabled: Boolean;
//#UC START# *47C7CDC802F0_48D11BE0015Eget_var*
//#UC END# *47C7CDC802F0_48D11BE0015Eget_var*
begin
//#UC START# *47C7CDC802F0_48D11BE0015Eget_impl*
 Result := GetRedirect.BoolA[k2_tiEnabled];
//#UC END# *47C7CDC802F0_48D11BE0015Eget_impl*
end;//TnevControlPara.Get_Enabled

function TnevControlPara.Get_Checked: Boolean;
//#UC START# *47C7CDD80342_48D11BE0015Eget_var*
//#UC END# *47C7CDD80342_48D11BE0015Eget_var*
begin
//#UC START# *47C7CDD80342_48D11BE0015Eget_impl*
 Result := GetRedirect.BoolA[k2_tiChecked];
//#UC END# *47C7CDD80342_48D11BE0015Eget_impl*
end;//TnevControlPara.Get_Checked

procedure TnevControlPara.Set_Checked(aValue: Boolean);
//#UC START# *47C7CDD80342_48D11BE0015Eset_var*
//#UC END# *47C7CDD80342_48D11BE0015Eset_var*
begin
//#UC START# *47C7CDD80342_48D11BE0015Eset_impl*
 GetRedirect.BoolW[k2_tiChecked, nil] := aValue;
//#UC END# *47C7CDD80342_48D11BE0015Eset_impl*
end;//TnevControlPara.Set_Checked

function TnevControlPara.Get_Flat: Boolean;
//#UC START# *47C7CDE7036F_48D11BE0015Eget_var*
//#UC END# *47C7CDE7036F_48D11BE0015Eget_var*
begin
//#UC START# *47C7CDE7036F_48D11BE0015Eget_impl*
 Result := GetRedirect.BoolA[k2_tiFlat];
//#UC END# *47C7CDE7036F_48D11BE0015Eget_impl*
end;//TnevControlPara.Get_Flat

function TnevControlPara.Get_Name: Tl3WString;
//#UC START# *47C7CE080350_48D11BE0015Eget_var*
//#UC END# *47C7CE080350_48D11BE0015Eget_var*
begin
//#UC START# *47C7CE080350_48D11BE0015Eget_impl*
 Result := GetRedirect.PCharLenA[k2_tiName];
//#UC END# *47C7CE080350_48D11BE0015Eget_impl*
end;//TnevControlPara.Get_Name

function TnevControlPara.Get_Text: Tl3WString;
//#UC START# *47C7CE18022D_48D11BE0015Eget_var*
//#UC END# *47C7CE18022D_48D11BE0015Eget_var*
begin
//#UC START# *47C7CE18022D_48D11BE0015Eget_impl*
 Result := pm_GetText{GetRedirect.PCharLenA[k2_tiText]};
//#UC END# *47C7CE18022D_48D11BE0015Eget_impl*
end;//TnevControlPara.Get_Text

function TnevControlPara.Get_ControlType: TevControlType;
//#UC START# *47C7CE270211_48D11BE0015Eget_var*
//#UC END# *47C7CE270211_48D11BE0015Eget_var*
begin
//#UC START# *47C7CE270211_48D11BE0015Eget_impl*
 Result := TevControlType(GetRedirect.IntA[k2_tiType]);
//#UC END# *47C7CE270211_48D11BE0015Eget_impl*
end;//TnevControlPara.Get_ControlType

function TnevControlPara.Get_Upper: Boolean;
//#UC START# *47C7CE3500E1_48D11BE0015Eget_var*
//#UC END# *47C7CE3500E1_48D11BE0015Eget_var*
begin
//#UC START# *47C7CE3500E1_48D11BE0015Eget_impl*
 Result := GetRedirect.BoolA[k2_tiUpper];
//#UC END# *47C7CE3500E1_48D11BE0015Eget_impl*
end;//TnevControlPara.Get_Upper

procedure TnevControlPara.Set_Upper(aValue: Boolean);
//#UC START# *47C7CE3500E1_48D11BE0015Eset_var*
//#UC END# *47C7CE3500E1_48D11BE0015Eset_var*
begin
//#UC START# *47C7CE3500E1_48D11BE0015Eset_impl*
 GetRedirect.BoolW[k2_tiUpper, nil{StartOp}] := aValue;
//#UC END# *47C7CE3500E1_48D11BE0015Eset_impl*
end;//TnevControlPara.Set_Upper

function TnevControlPara.pm_GetCollapsed: Boolean;
//#UC START# *47C7CEFB0205_48D11BE0015Eget_var*
//#UC END# *47C7CEFB0205_48D11BE0015Eget_var*
begin
//#UC START# *47C7CEFB0205_48D11BE0015Eget_impl*
 Result := GetRedirect.BoolA[k2_tiCollapsed];
//#UC END# *47C7CEFB0205_48D11BE0015Eget_impl*
end;//TnevControlPara.pm_GetCollapsed

procedure TnevControlPara.pm_SetCollapsed(aValue: Boolean);
//#UC START# *47C7CEFB0205_48D11BE0015Eset_var*
//#UC END# *47C7CEFB0205_48D11BE0015Eset_var*
begin
//#UC START# *47C7CEFB0205_48D11BE0015Eset_impl*
 GetRedirect.BoolW[k2_tiCollapsed,nil] := aValue;
 Invalidate([nev_spExtent]);
//#UC END# *47C7CEFB0205_48D11BE0015Eset_impl*
end;//TnevControlPara.pm_SetCollapsed

function TnevControlPara.GetControl: IevEditorControl;
 {* Получить контрол по ссылке. }
//#UC START# *47CD77350118_48D11BE0015E_var*
//#UC END# *47CD77350118_48D11BE0015E_var*
begin
//#UC START# *47CD77350118_48D11BE0015E_impl*
 GetRedirect.QT(IevEditorControl, Result);
//#UC END# *47CD77350118_48D11BE0015E_impl*
end;//TnevControlPara.GetControl

function TnevControlPara.TreatCollapsedAsHidden: Boolean;
//#UC START# *4D596369028C_48D11BE0015E_var*
//#UC END# *4D596369028C_48D11BE0015E_var*
begin
//#UC START# *4D596369028C_48D11BE0015E_impl*
 Result := false;
//#UC END# *4D596369028C_48D11BE0015E_impl*
end;//TnevControlPara.TreatCollapsedAsHidden

function TnevControlPara.GetText: TnevStr;
//#UC START# *4D7255870102_48D11BE0015E_var*
//#UC END# *4D7255870102_48D11BE0015E_var*
begin
//#UC START# *4D7255870102_48D11BE0015E_impl*
 Result := inherited GetText;
 // Для английской версии хинт не нужен
 // http://mdp.garant.ru/pages/viewpage.action?pageId=497680583
 if (afw.Application <> nil) then
  if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) AND l3IsNil(Result) AND
   (Get_ControlType = ev_ctMemoEdit) then
   Result := str_MemoHintForConsult.AsWStr;
//#UC END# *4D7255870102_48D11BE0015E_impl*
end;//TnevControlPara.GetText

initialization
 str_MemoHintForConsult.Init;
 {* Инициализация str_MemoHintForConsult }
{$IfEnd} // Defined(k2ForEditor)

end.
