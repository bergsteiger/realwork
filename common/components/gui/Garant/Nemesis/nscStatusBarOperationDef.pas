unit nscStatusBarOperationDef;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscStatusBarOperationDef.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::StatusBar::TnscStatusBarOperationDef
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  nscNewInterfaces,
  nscStatusBarItemDef
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscStatusBarOperationDef = class(TnscStatusBarItemDef {$If defined(Nemesis) AND not defined(NoVCM)}, InscStatusBarOperationDef{$IfEnd} //Nemesis AND not NoVCM
 )
 private
 // private fields
   f_Operation : TvcmOpSelector;
 protected
 // realized methods
   {$If defined(Nemesis) AND not defined(NoVCM)}
   function Get_Operation: TvcmOpSelector;
   {$IfEnd} //Nemesis AND not NoVCM
 public
 // public methods
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
     {* Сигнатура фабрики TnscStatusBarOperationDef.Make }
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
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscStatusBarOperationDef

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
end;

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

{$If defined(Nemesis) AND not defined(NoVCM)}
function TnscStatusBarOperationDef.Get_Operation: TvcmOpSelector;
//#UC START# *4FE9F49C0299_49871E4F01AFget_var*
//#UC END# *4FE9F49C0299_49871E4F01AFget_var*
begin
//#UC START# *4FE9F49C0299_49871E4F01AFget_impl*
 Result := f_Operation;
//#UC END# *4FE9F49C0299_49871E4F01AFget_impl*
end;//TnscStatusBarOperationDef.Get_Operation
{$IfEnd} //Nemesis AND not NoVCM

{$IfEnd} //Nemesis

end.