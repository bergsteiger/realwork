unit evButtonControl;
 {* Класс кнопки }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evButtonControl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevButtonControl" MUID: (48D230A600EE)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evControl
 , evQueryCardInt
 , nevTools
 , nevBase
;

type
 TevButtonControl = class(TevControl, IevEditorControlButton, IevEditorStateButton)
  {* Класс кнопки }
  protected
   procedure IncButtonState;
    {* Изменяет состояние кнопки }
   function GetButtonType: TevButtonType;
   function Get_StateCount: Integer;
   function Get_CurrentIndex: Integer;
   procedure Set_CurrentIndex(aValue: Integer);
   function Get_ImageIndex: Integer;
   function GetStateIndex: Integer;
    {* Собственно возвращает состояние кнопки от 0 до максимального. }
   function DoLMouseBtnUp(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean): Boolean; override;
   function DoLMouseBtnDown(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean;
    const aMap: InevMap): Boolean; override;
   procedure DoUpperChange; override;
  public
   function DoKeyCommand(const aView: InevControlView;
    aCmd: Word;
    const aTextPara: InevPara): Boolean; override;
 end;//TevButtonControl

implementation

uses
 l3ImplUses
 , k2Tags
 , evQueryCardDropControlsInt
 , evQueryCardConst
 , l3String
 , OvcConst
 , SysUtils
 , l3Units
 , l3Base
;

procedure TevButtonControl.IncButtonState;
 {* Изменяет состояние кнопки }
//#UC START# *48D2334500E1_48D230A600EE_var*
var
 l_CurrIndex: Integer;
//#UC END# *48D2334500E1_48D230A600EE_var*
begin
//#UC START# *48D2334500E1_48D230A600EE_impl*
 l_CurrIndex := Get_CurrentIndex;
 if (Get_ImageIndex + Get_StateCount) > Get_CurrentIndex then
  Set_CurrentIndex(l_CurrIndex + 1)
 else
  Set_CurrentIndex(Get_ImageIndex);
//#UC END# *48D2334500E1_48D230A600EE_impl*
end;//TevButtonControl.IncButtonState

function TevButtonControl.GetButtonType: TevButtonType;
//#UC START# *47CD79C903AF_48D230A600EE_var*
var
 l_Long: Integer; 
//#UC END# *47CD79C903AF_48D230A600EE_var*
begin
//#UC START# *47CD79C903AF_48D230A600EE_impl*
 Result := ev_btNone;
 if l3Same(Get_ControlName, csLogicBTN) then
  Result := ev_btLogical
 else
 if l3Same(Get_ControlName, csAddBTN) then
  Result := ev_btAdd
 else
 if l3Same(Get_ControlName, csDeleteBTN) then
  Result := ev_btDelete;
 //Bug fix: карточка может использовать другие названия кнопок - это заплатка!
 if Result = ev_btNone then    
 begin
  if (Para.AsObject.IntA[k2_tiStateIndex] = -1) then
   if (Para.AsObject.IntA[k2_tiImageIndex] <> -1) then
    l_Long := Para.AsObject.IntA[k2_tiImageIndex]
   else
    l_Long := -1
  else
    l_Long := Para.AsObject.IntA[k2_tiStateIndex];
  if l_Long <> -1 then
   if l_Long = 5 then
    Result := ev_btDelete
  else 
   if l_Long = 58 then 
    Result := ev_btAdd
   else 
    if (l_Long >= 37) and (l_Long <= 39) then 
     Result := ev_btLogical;
 end;   
//#UC END# *47CD79C903AF_48D230A600EE_impl*
end;//TevButtonControl.GetButtonType

function TevButtonControl.Get_StateCount: Integer;
//#UC START# *47CD79ED01CC_48D230A600EEget_var*
//#UC END# *47CD79ED01CC_48D230A600EEget_var*
begin
//#UC START# *47CD79ED01CC_48D230A600EEget_impl*
 Result := Para.AsObject.IntA[k2_tiStateCount];
//#UC END# *47CD79ED01CC_48D230A600EEget_impl*
end;//TevButtonControl.Get_StateCount

function TevButtonControl.Get_CurrentIndex: Integer;
//#UC START# *47CD79FA004E_48D230A600EEget_var*
//#UC END# *47CD79FA004E_48D230A600EEget_var*
begin
//#UC START# *47CD79FA004E_48D230A600EEget_impl*
 Result := Para.AsObject.IntA[k2_tiStateIndex];
//#UC END# *47CD79FA004E_48D230A600EEget_impl*
end;//TevButtonControl.Get_CurrentIndex

procedure TevButtonControl.Set_CurrentIndex(aValue: Integer);
//#UC START# *47CD79FA004E_48D230A600EEset_var*
//#UC END# *47CD79FA004E_48D230A600EEset_var*
begin
//#UC START# *47CD79FA004E_48D230A600EEset_impl*
 Para.AsObject.IntW[k2_tiStateIndex, nil] := aValue;
//#UC END# *47CD79FA004E_48D230A600EEset_impl*
end;//TevButtonControl.Set_CurrentIndex

function TevButtonControl.Get_ImageIndex: Integer;
//#UC START# *47CD7A0A03DD_48D230A600EEget_var*
//#UC END# *47CD7A0A03DD_48D230A600EEget_var*
begin
//#UC START# *47CD7A0A03DD_48D230A600EEget_impl*
 Result := Para.AsObject.IntA[k2_tiImageIndex];
//#UC END# *47CD7A0A03DD_48D230A600EEget_impl*
end;//TevButtonControl.Get_ImageIndex

function TevButtonControl.GetStateIndex: Integer;
 {* Собственно возвращает состояние кнопки от 0 до максимального. }
//#UC START# *47CDA4CB026C_48D230A600EE_var*
//#UC END# *47CDA4CB026C_48D230A600EE_var*
begin
//#UC START# *47CDA4CB026C_48D230A600EE_impl*
 Result := Get_CurrentIndex - Get_ImageIndex;
//#UC END# *47CDA4CB026C_48D230A600EE_impl*
end;//TevButtonControl.GetStateIndex

function TevButtonControl.DoLMouseBtnUp(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState;
 anInPara: Boolean): Boolean;
//#UC START# *48D1461101C6_48D230A600EE_var*
var
 l_BtnType: TevButtonType;                               
//#UC END# *48D1461101C6_48D230A600EE_var*
begin
//#UC START# *48D1461101C6_48D230A600EE_impl*
 if Get_Visible then
 begin
  l_BtnType := GetButtonType;  
  case l_BtnType of
   ev_btLogical:
    if Get_Enabled then
     IncButtonState;
   ev_btAdd,
   ev_btDelete:
    Get_Req.ButtonPressed(aView, Self, l_BtnType);
  end;//case l_BtnType
  Result := True;
 end//Get_Visible
 else 
  Result := False;
//#UC END# *48D1461101C6_48D230A600EE_impl*
end;//TevButtonControl.DoLMouseBtnUp

function TevButtonControl.DoLMouseBtnDown(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState;
 anInPara: Boolean;
 const aMap: InevMap): Boolean;
//#UC START# *48D1464501E8_48D230A600EE_var*
var
 l_DropContainer: IevDropContainer; 
//#UC END# *48D1464501E8_48D230A600EE_var*
begin
//#UC START# *48D1464501E8_48D230A600EE_impl*
 if Supports(Get_Req.QueryCard, IevDropContainer, l_DropContainer) then
  l_DropContainer.HideControl(true);
 if anInPara and Get_Visible then
 begin
  SetChecked(True); 
  Result := True;
 end
 else 
  Result := False;
//#UC END# *48D1464501E8_48D230A600EE_impl*
end;//TevButtonControl.DoLMouseBtnDown

function TevButtonControl.DoKeyCommand(const aView: InevControlView;
 aCmd: Word;
 const aTextPara: InevPara): Boolean;
//#UC START# *48D145B8036A_48D230A600EE_var*
var
 l_Pt: Tl3Point;
 l_Keys : TevMouseState;
//#UC END# *48D145B8036A_48D230A600EE_var*
begin
//#UC START# *48D145B8036A_48D230A600EE_impl*
 if (aCmd = ccSelect) or (aCmd = ccActionItem) then
 begin
  Result := True;//Нам не нужно добавление нового параграфа (т.е. копирование виджета).
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l3FillChar(l_Pt, SizeOf(l_Pt), 0);
  LMouseBtnUp(aView, aTextPara, l_Pt, l_Keys, True)
 end
 else 
  Result := False;  
//#UC END# *48D145B8036A_48D230A600EE_impl*
end;//TevButtonControl.DoKeyCommand

procedure TevButtonControl.DoUpperChange;
//#UC START# *48D1489102C9_48D230A600EE_var*
//#UC END# *48D1489102C9_48D230A600EE_var*
begin
//#UC START# *48D1489102C9_48D230A600EE_impl*
 Get_Req.QueryCard.UpperChange(Self); 
//#UC END# *48D1489102C9_48D230A600EE_impl*
end;//TevButtonControl.DoUpperChange

end.
