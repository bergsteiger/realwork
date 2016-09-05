unit ChromeLikeTabParams;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TChromeLikeTabParams" MUID: (53F2D86C02FC)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3TabbedContainersDispatcher
 , l3Interfaces
;

type
 TChromeLikeTabParams = class(Tl3ProtoObject, Il3TabParams)
  private
   f_UpdateOptions: Tl3TabUpdateOptions;
   f_ImageIndex: Integer;
   f_HintText: Il3CString;
   f_Text: Il3CString;
  protected
   function pm_GetHintText: WideString;
   function pm_GetText: WideString;
   function pm_GetImageIndex: Integer;
   function pm_GetUpdateOptions: Tl3TabUpdateOptions;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aText: Il3CString;
    const aHintText: Il3CString;
    aImageIndex: Integer;
    aUpdateOptions: Tl3TabUpdateOptions); reintroduce;
   class function Make(const aText: Il3CString;
    const aHintText: Il3CString;
    aImageIndex: Integer;
    aUpdateOptions: Tl3TabUpdateOptions): Il3TabParams; reintroduce;
 end;//TChromeLikeTabParams
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3String
 //#UC START# *53F2D86C02FCimpl_uses*
 //#UC END# *53F2D86C02FCimpl_uses*
;

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
end;//TChromeLikeTabParams.Make

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53F2D86C02FC_var*
//#UC END# *479731C50290_53F2D86C02FC_var*
begin
//#UC START# *479731C50290_53F2D86C02FC_impl*
 f_Text := nil;
 f_HintText := nil;
 inherited;
//#UC END# *479731C50290_53F2D86C02FC_impl*
end;//TChromeLikeTabParams.Cleanup
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
