unit nscStatusBarOperationDef;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscStatusBarOperationDef.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscStatusBarOperationDef" MUID: (49871E4F01AF)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscStatusBarItemDef
 , nscNewInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnscStatusBarOperationDef = class(TnscStatusBarItemDef{$If NOT Defined(NoVCM)}
 , InscStatusBarOperationDef
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_Operation: TvcmOpSelector;
  protected
   {$If NOT Defined(NoVCM)}
   function Get_Operation: TvcmOpSelector;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   constructor Create(const anOperation: TvcmOpSelector;
    aShowCaption: Boolean;
    const aCaption: Il3CString;
    aUseToolTip: Boolean;
    aRequireAutoPopup: Boolean;
    anAutoPopupTimeout: Cardinal;
    aToolTipKind: TnscToolTipKind); reintroduce;
   class function Make(const anOperation: TvcmOpSelector;
    aShowCaption: Boolean;
    const aCaption: Il3CString;
    aUseToolTip: Boolean;
    aRequireAutoPopup: Boolean;
    anAutoPopupTimeout: Cardinal;
    aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef; reintroduce;
   class function MakeS(const anOperation: TvcmOPID;
    aShowCaption: Boolean;
    const aCaption: TvcmStringID;
    aUseToolTip: Boolean;
    aRequireAutoPopup: Boolean;
    anAutoPopupTimeout: Cardinal;
    aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
   class function MakeSDefaultCaption(const anOperation: TvcmOPID;
    aUseToolTip: Boolean;
    aRequireAutoPopup: Boolean;
    anAutoPopupTimeout: Cardinal;
    aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
   class function MakeSNoCaption(const anOperation: TvcmOPID;
    aUseToolTip: Boolean;
    aRequireAutoPopup: Boolean;
    anAutoPopupTimeout: Cardinal;
    aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
 end;//TnscStatusBarOperationDef
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *49871E4F01AFimpl_uses*
 //#UC END# *49871E4F01AFimpl_uses*
;

constructor TnscStatusBarOperationDef.Create(const anOperation: TvcmOpSelector;
 aShowCaption: Boolean;
 const aCaption: Il3CString;
 aUseToolTip: Boolean;
 aRequireAutoPopup: Boolean;
 anAutoPopupTimeout: Cardinal;
 aToolTipKind: TnscToolTipKind);
//#UC START# *4FEC4A26030E_49871E4F01AF_var*
//#UC END# *4FEC4A26030E_49871E4F01AF_var*
begin
//#UC START# *4FEC4A26030E_49871E4F01AF_impl*
 inherited Create(aShowCaption, aCaption, aUseToolTip, aRequireAutoPopup, anAutoPopupTimeout, aToolTipKind);
 f_Operation := anOperation;
//#UC END# *4FEC4A26030E_49871E4F01AF_impl*
end;//TnscStatusBarOperationDef.Create

class function TnscStatusBarOperationDef.Make(const anOperation: TvcmOpSelector;
 aShowCaption: Boolean;
 const aCaption: Il3CString;
 aUseToolTip: Boolean;
 aRequireAutoPopup: Boolean;
 anAutoPopupTimeout: Cardinal;
 aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
var
 l_Inst : TnscStatusBarOperationDef;
begin
 l_Inst := Create(anOperation, aShowCaption, aCaption, aUseToolTip, aRequireAutoPopup, anAutoPopupTimeout, aToolTipKind);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscStatusBarOperationDef.Make

class function TnscStatusBarOperationDef.MakeS(const anOperation: TvcmOPID;
 aShowCaption: Boolean;
 const aCaption: TvcmStringID;
 aUseToolTip: Boolean;
 aRequireAutoPopup: Boolean;
 anAutoPopupTimeout: Cardinal;
 aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
//#UC START# *4FEC5B7B00CE_49871E4F01AF_var*
var
 l_Op : TvcmOpSelector;
//#UC END# *4FEC5B7B00CE_49871E4F01AF_var*
begin
//#UC START# *4FEC5B7B00CE_49871E4F01AF_impl*
 l_Op.rKind := vcm_okEntity;
 l_Op.rID := anOperation;
 Result := Make(l_Op, aShowCaption, vcmCStr(aCaption),
  aUseToolTip, aRequireAutoPopup, anAutoPopupTimeout, aToolTipKind);
//#UC END# *4FEC5B7B00CE_49871E4F01AF_impl*
end;//TnscStatusBarOperationDef.MakeS

class function TnscStatusBarOperationDef.MakeSDefaultCaption(const anOperation: TvcmOPID;
 aUseToolTip: Boolean;
 aRequireAutoPopup: Boolean;
 anAutoPopupTimeout: Cardinal;
 aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
//#UC START# *4FF59E080381_49871E4F01AF_var*
var
 l_Op : TvcmOpSelector;
//#UC END# *4FF59E080381_49871E4F01AF_var*
begin
//#UC START# *4FF59E080381_49871E4F01AF_impl*
 l_Op.rKind := vcm_okEntity;
 l_Op.rID := anOperation;
 Result := Make(l_Op, True, nil, aUseToolTip, aRequireAutoPopup, anAutoPopupTimeout, aToolTipKind);
//#UC END# *4FF59E080381_49871E4F01AF_impl*
end;//TnscStatusBarOperationDef.MakeSDefaultCaption

class function TnscStatusBarOperationDef.MakeSNoCaption(const anOperation: TvcmOPID;
 aUseToolTip: Boolean;
 aRequireAutoPopup: Boolean;
 anAutoPopupTimeout: Cardinal;
 aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
//#UC START# *4FFAFB0B03CC_49871E4F01AF_var*
var
 l_Op : TvcmOpSelector;
//#UC END# *4FFAFB0B03CC_49871E4F01AF_var*
begin
//#UC START# *4FFAFB0B03CC_49871E4F01AF_impl*
 l_Op.rKind := vcm_okEntity;
 l_Op.rID := anOperation;
 Result := Make(l_Op, False, nil, aUseToolTip, aRequireAutoPopup, anAutoPopupTimeout, aToolTipKind);
//#UC END# *4FFAFB0B03CC_49871E4F01AF_impl*
end;//TnscStatusBarOperationDef.MakeSNoCaption

{$If NOT Defined(NoVCM)}
function TnscStatusBarOperationDef.Get_Operation: TvcmOpSelector;
//#UC START# *4FE9F49C0299_49871E4F01AFget_var*
//#UC END# *4FE9F49C0299_49871E4F01AFget_var*
begin
//#UC START# *4FE9F49C0299_49871E4F01AFget_impl*
 Result := f_Operation;
//#UC END# *4FE9F49C0299_49871E4F01AFget_impl*
end;//TnscStatusBarOperationDef.Get_Operation
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Nemesis)
end.
