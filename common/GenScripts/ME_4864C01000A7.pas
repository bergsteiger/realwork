unit evMemoProcessor;

// Модуль: "w:\common\components\gui\Garant\Everest\evMemoProcessor.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEditorWindowProcessor
 , Classes
;

type
 TevMemoProcessor = class(TevCustomEditorWindowProcessor)
  protected
   function pm_GetMemo: TComponent;
   function GetNeedReplaceQuotes: Boolean; override;
  public
   constructor Create; reintroduce;
  public
   property Memo: TComponent
    read pm_GetMemo;
 end;//TevMemoProcessor

implementation

uses
 l3ImplUses
 , evCustomMemo
 , evDefaultContext
 , nevTools
;

function TevMemoProcessor.pm_GetMemo: TComponent;
//#UC START# *4864C37103E7_4864C01000A7get_var*
var
 l_Control: InevControl;
//#UC END# *4864C37103E7_4864C01000A7get_var*
begin
//#UC START# *4864C37103E7_4864C01000A7get_impl*
 (Document As InevDocumentContainer).TextSource.CastAnyEditorTo(InevControl, l_Control);
 if Assigned(l_Control) then
 begin
  Result := l_Control.GetDelphiControl;
  if Assigned(Result) and not Result.InheritsFrom(TevCustomMemo) then
   Result := nil;
 end
 else
  Result := nil;
 Assert(Assigned(Result));
//#UC END# *4864C37103E7_4864C01000A7get_impl*
end;//TevMemoProcessor.pm_GetMemo

constructor TevMemoProcessor.Create;
//#UC START# *48CE03EB0178_4864C01000A7_var*
//#UC END# *48CE03EB0178_4864C01000A7_var*
begin
//#UC START# *48CE03EB0178_4864C01000A7_impl*
 inherited Create(TevDefaultContext); 
//#UC END# *48CE03EB0178_4864C01000A7_impl*
end;//TevMemoProcessor.Create

function TevMemoProcessor.GetNeedReplaceQuotes: Boolean;
//#UC START# *4843D3020153_4864C01000A7_var*
//#UC END# *4843D3020153_4864C01000A7_var*
begin
//#UC START# *4843D3020153_4864C01000A7_impl*
 Result := TevCustomMemo(Memo).NeedReplaceQuotes;
//#UC END# *4843D3020153_4864C01000A7_impl*
end;//TevMemoProcessor.GetNeedReplaceQuotes

end.
