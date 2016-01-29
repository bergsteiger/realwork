unit ChromeLikeTabParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeTabParams.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::TChromeLikeTabParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Interfaces,
  l3ProtoObject,
  l3TabbedContainersDispatcher
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TChromeLikeTabParams = class(Tl3ProtoObject, Il3TabParams)
 private
 // private fields
   f_UpdateOptions : Tl3TabUpdateOptions;
   f_ImageIndex : Integer;
   f_HintText : Il3CString;
   f_Text : Il3CString;
 protected
 // realized methods
   function pm_GetHintText: WideString;
   function pm_GetText: WideString;
   function pm_GetImageIndex: Integer;
   function pm_GetUpdateOptions: Tl3TabUpdateOptions;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aText: Il3CString;
     const aHintText: Il3CString;
     aImageIndex: Integer;
     aUpdateOptions: Tl3TabUpdateOptions); reintroduce;
   class function Make(const aText: Il3CString;
     const aHintText: Il3CString;
     aImageIndex: Integer;
     aUpdateOptions: Tl3TabUpdateOptions): Il3TabParams; reintroduce;
     {* Сигнатура фабрики TChromeLikeTabParams.Make }
 end;//TChromeLikeTabParams
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3String
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TChromeLikeTabParams

constructor TChromeLikeTabParams.Create(const aText: Il3CString;
  const aHintText: Il3CString;
  aImageIndex: Integer;
  aUpdateOptions: Tl3TabUpdateOptions);
//#UC START# *53F2DA6F0255_53F2D86C02FC_var*
//#UC END# *53F2DA6F0255_53F2D86C02FC_var*
begin
//#UC START# *53F2DA6F0255_53F2D86C02FC_impl*
 inherited Create;
 f_Text := aText;
 f_HintText := aHintText;
 f_ImageIndex := aImageIndex;
 f_UpdateOptions := aUpdateOptions;
//#UC END# *53F2DA6F0255_53F2D86C02FC_impl*
end;//TChromeLikeTabParams.Create

class function TChromeLikeTabParams.Make(const aText: Il3CString;
  const aHintText: Il3CString;
  aImageIndex: Integer;
  aUpdateOptions: Tl3TabUpdateOptions): Il3TabParams;
var
 l_Inst : TChromeLikeTabParams;
begin
 l_Inst := Create(aText, aHintText, aImageIndex, aUpdateOptions);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TChromeLikeTabParams.pm_GetHintText: WideString;
//#UC START# *53F2D8130105_53F2D86C02FCget_var*
//#UC END# *53F2D8130105_53F2D86C02FCget_var*
begin
//#UC START# *53F2D8130105_53F2D86C02FCget_impl*
 Result := l3DStr(f_HintText);
//#UC END# *53F2D8130105_53F2D86C02FCget_impl*
end;//TChromeLikeTabParams.pm_GetHintText

function TChromeLikeTabParams.pm_GetText: WideString;
//#UC START# *53F2D8210054_53F2D86C02FCget_var*
//#UC END# *53F2D8210054_53F2D86C02FCget_var*
begin
//#UC START# *53F2D8210054_53F2D86C02FCget_impl*
 Result := l3DStr(f_Text);
//#UC END# *53F2D8210054_53F2D86C02FCget_impl*
end;//TChromeLikeTabParams.pm_GetText

function TChromeLikeTabParams.pm_GetImageIndex: Integer;
//#UC START# *53F2D837021D_53F2D86C02FCget_var*
//#UC END# *53F2D837021D_53F2D86C02FCget_var*
begin
//#UC START# *53F2D837021D_53F2D86C02FCget_impl*
 Result := f_ImageIndex;
//#UC END# *53F2D837021D_53F2D86C02FCget_impl*
end;//TChromeLikeTabParams.pm_GetImageIndex

function TChromeLikeTabParams.pm_GetUpdateOptions: Tl3TabUpdateOptions;
//#UC START# *53F2E49B01F5_53F2D86C02FCget_var*
//#UC END# *53F2E49B01F5_53F2D86C02FCget_var*
begin
//#UC START# *53F2E49B01F5_53F2D86C02FCget_impl*
 Result := f_UpdateOptions;
//#UC END# *53F2E49B01F5_53F2D86C02FCget_impl*
end;//TChromeLikeTabParams.pm_GetUpdateOptions

procedure TChromeLikeTabParams.Cleanup;
//#UC START# *479731C50290_53F2D86C02FC_var*
//#UC END# *479731C50290_53F2D86C02FC_var*
begin
//#UC START# *479731C50290_53F2D86C02FC_impl*
 f_Text := nil;
 f_HintText := nil;
 inherited;
//#UC END# *479731C50290_53F2D86C02FC_impl*
end;//TChromeLikeTabParams.Cleanup

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.