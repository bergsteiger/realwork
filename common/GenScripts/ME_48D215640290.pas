unit evLabel;
 {* Класс для надисей (названий реквизитов) }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evLabel.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evControl
 , afwNavigation
 , evQueryCardInt
 , l3Interfaces
 , nevTools
 , nevBase
 , l3IID
;

type
 TevLabel = class(TevControl, IevMoniker, IevEditorControlLabel)
  {* Класс для надисей (названий реквизитов) }
  protected
   procedure RestoreCaption;
    {* Восстанавливает название метки. }
   function Get_Caption: Il3CString;
   procedure Set_Caption(const aValue: Il3CString);
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
   procedure Set_Para(const Value: InevPara); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  public
   function DoKeyCommand(const aView: InevControlView;
    aCmd: Word;
    const aTextPara: InevPara): Boolean; override;
 end;//TevLabel

implementation

uses
 l3ImplUses
 , l3String
 , evQueryCardDropControlsInt
 , nevNavigation
 , SysUtils
 , l3Base
 , l3Chars
 , OvcConst
 , k2Tags
;

procedure TevLabel.RestoreCaption;
 {* Восстанавливает название метки. }
//#UC START# *47CD795A0169_48D215640290_var*
//#UC END# *47CD795A0169_48D215640290_var*
begin
//#UC START# *47CD795A0169_48D215640290_impl*
 if not l3Same(Get_Caption, Get_Req.ReqCaption) then
  SetText(Get_Req.ReqCaption);
//#UC END# *47CD795A0169_48D215640290_impl*
end;//TevLabel.RestoreCaption

function TevLabel.Get_Caption: Il3CString;
//#UC START# *47CD79710152_48D215640290get_var*
//#UC END# *47CD79710152_48D215640290get_var*
begin
//#UC START# *47CD79710152_48D215640290get_impl*
 Result := inherited Get_Caption;
//#UC END# *47CD79710152_48D215640290get_impl*
end;//TevLabel.Get_Caption

procedure TevLabel.Set_Caption(const aValue: Il3CString);
//#UC START# *47CD79710152_48D215640290set_var*
//#UC END# *47CD79710152_48D215640290set_var*
begin
//#UC START# *47CD79710152_48D215640290set_impl*
 SetText(aValue);
//#UC END# *47CD79710152_48D215640290set_impl*
end;//TevLabel.Set_Caption

function TevLabel.DoLMouseBtnUp(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState;
 anInPara: Boolean): Boolean;
//#UC START# *48D1461101C6_48D215640290_var*
//#UC END# *48D1461101C6_48D215640290_var*
begin
//#UC START# *48D1461101C6_48D215640290_impl*
 Result := False;
//#UC END# *48D1461101C6_48D215640290_impl*
end;//TevLabel.DoLMouseBtnUp

function TevLabel.DoLMouseBtnDown(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState;
 anInPara: Boolean;
 const aMap: InevMap): Boolean;
//#UC START# *48D1464501E8_48D215640290_var*
var
 l_DropContainer: IevDropContainer; 
//#UC END# *48D1464501E8_48D215640290_var*
begin
//#UC START# *48D1464501E8_48D215640290_impl*
 if Supports(Get_Req.QueryCard, IevDropContainer, l_DropContainer) then
  l_DropContainer.HideControl(true);
 Result := Get_Enabled
//#UC END# *48D1464501E8_48D215640290_impl*
end;//TevLabel.DoLMouseBtnDown

procedure TevLabel.Set_Para(const Value: InevPara);
//#UC START# *47CFE37202A1_48D215640290_var*
//#UC END# *47CFE37202A1_48D215640290_var*
begin
//#UC START# *47CFE37202A1_48D215640290_impl*
 inherited;
 Assert(Value <> nil, 'Присваивается несуществующий параграф!'); 
 if l3EmptyOrAllCharsInCharSet(l3PCharLen(Get_Caption), cc_WhiteSpace) then
  InitBoolProperty(k2_tiVisible, False);
//#UC END# *47CFE37202A1_48D215640290_impl*
end;//TevLabel.Set_Para

function TevLabel.DoKeyCommand(const aView: InevControlView;
 aCmd: Word;
 const aTextPara: InevPara): Boolean;
//#UC START# *48D145B8036A_48D215640290_var*
var
 l_MonikerSink : IevMonikerSink;
 l_Control     : InevControl;
//#UC END# *48D145B8036A_48D215640290_var*
begin
//#UC START# *48D145B8036A_48D215640290_impl*
 if (aCmd = ccActionItem) then
  with aTextPara do
  begin
   l_Control := aView.Control;
   if (l_Control <> nil) and
     Supports(l_Control, IevMonikerSink, l_MonikerSink) then
    try
     Result := l_MonikerSink.JumpTo([], Self);
    finally
     l_MonikerSink := nil;
    end//try..finally
   else 
    Result := false; 
  end//with aTextPara
 else
  Result := inherited DoKeyCommand(aView, aCmd, aTextPara);
//#UC END# *48D145B8036A_48D215640290_impl*
end;//TevLabel.DoKeyCommand

function TevLabel.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_48D215640290_var*
var
 l_Control: InevControl;
//#UC END# *4A60B23E00C3_48D215640290_var*
begin
//#UC START# *4A60B23E00C3_48D215640290_impl*
 if IID.EQ(IevHyperlink) then
 begin
  l_Control := Get_Req.QueryCard.Editor;
  if Assigned(l_Control) then
   Result := Tl3HResult_C(l_Control.Selection.QueryInterface(IevHyperlink, Obj))
  else
   Result := inherited COMQueryInterface(IID, Obj);
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_48D215640290_impl*
end;//TevLabel.COMQueryInterface

end.
