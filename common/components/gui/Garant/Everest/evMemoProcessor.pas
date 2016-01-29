unit evMemoProcessor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evMemoProcessor.pas"
// Начат: 27.06.2008 14:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevMemoProcessor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  Classes,
  evCustomEditorWindowProcessor
  ;

type
 TevMemoProcessor = class(TevCustomEditorWindowProcessor)
 protected
 // property methods
   function pm_GetMemo: TComponent;
 protected
 // overridden protected methods
   function GetNeedReplaceQuotes: Boolean; override;
 public
 // public methods
   constructor Create; reintroduce;
 public
 // public properties
   property Memo: TComponent
     read pm_GetMemo;
 end;//TevMemoProcessor

implementation

uses
  evCustomMemo,
  evDefaultContext,
  nevTools
  ;

// start class TevMemoProcessor

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