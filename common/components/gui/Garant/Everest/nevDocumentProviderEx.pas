unit nevDocumentProviderEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevDocumentProviderEx.pas"
// Начат: 13.10.2010 14:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Printing::TnevDocumentProviderEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  afwInterfaces,
  nevTools,
  nevDocumentProvider,
  l3Variant,
  nevBase,
  evdInterfaces,
  l3Interfaces
  ;

type
 TnevDocumentProviderEx = class(TnevDocumentProvider, IafwPageSetup)
 private
 // private fields
   f_Document : Tl3Tag;
 protected
 // realized methods
   function pm_GetMargins: TafwRect;
   function pm_GetOrientation: Tl3PageOrientation;
 protected
 // overridden property methods
   function pm_GetCanProvideOriginalDocument: Boolean; override;
   function pm_GetOriginalDocument: Tl3Variant; override;
   function pm_GetPageSetup: IafwPageSetup; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aStorable: InevStorable;
     aDocument: Tl3Variant); reintroduce;
   class function Make(const aStorable: InevStorable;
     aDocument: Tl3Variant): InevDocumentProvider; reintroduce;
     {* Сигнатура фабрики TnevDocumentProviderEx.Make }
 end;//TnevDocumentProviderEx

implementation

uses
  k2Tags,
  l3Units,
  evPreviewForTestsTuning,
  afwFacade,
  SysUtils
  ;

// start class TnevDocumentProviderEx

constructor TnevDocumentProviderEx.Create(const aStorable: InevStorable;
  aDocument: Tl3Variant);
//#UC START# *4CB586450301_4CB586140150_var*
//#UC END# *4CB586450301_4CB586140150_var*
begin
//#UC START# *4CB586450301_4CB586140150_impl*
 inherited Create(aStorable);
 aDocument.SetRef(f_Document);
//#UC END# *4CB586450301_4CB586140150_impl*
end;//TnevDocumentProviderEx.Create

class function TnevDocumentProviderEx.Make(const aStorable: InevStorable;
  aDocument: Tl3Variant): InevDocumentProvider;
var
 l_Inst : TnevDocumentProviderEx;
begin
 l_Inst := Create(aStorable, aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnevDocumentProviderEx.pm_GetMargins: TafwRect;
//#UC START# *473D8F8602AE_4CB586140150get_var*
//#UC END# *473D8F8602AE_4CB586140150get_var*
begin
//#UC START# *473D8F8602AE_4CB586140150get_impl*
{$IF not Defined(Archi) and not Defined(EverestLite)}
 {$IfDef nsTest}
 Assert(not OldBehaviourForK235875079);
 {$EndIf nsTest}
{$IfEnd}//{$IF not Defined(Archi) and not Defined(EverestLite)} 
 with f_Document.Attr[k2_tiParas] do
  Result := l3Rect(IntA[k2_tiLeftIndent],
                   IntA[k2_tiSpaceBefore],
                   IntA[k2_tiRightIndent],
                   IntA[k2_tiSpaceAfter]);
//#UC END# *473D8F8602AE_4CB586140150get_impl*
end;//TnevDocumentProviderEx.pm_GetMargins

function TnevDocumentProviderEx.pm_GetOrientation: Tl3PageOrientation;
//#UC START# *473D8F9202F2_4CB586140150get_var*
//#UC END# *473D8F9202F2_4CB586140150get_var*
begin
//#UC START# *473D8F9202F2_4CB586140150get_impl*
{$IF not Defined(Archi) and not Defined(EverestLite)}
 {$IfDef nsTest}
 Assert(not OldBehaviourForK235875079);
 {$EndIf nsTest}
{$IfEnd}//{$IF not Defined(Archi) and not Defined(EverestLite)}
 Result := Tl3PageOrientation(f_Document.Attr[k2_tiParas].IntA[k2_tiOrientation]);
//#UC END# *473D8F9202F2_4CB586140150get_impl*
end;//TnevDocumentProviderEx.pm_GetOrientation

procedure TnevDocumentProviderEx.Cleanup;
//#UC START# *479731C50290_4CB586140150_var*
//#UC END# *479731C50290_4CB586140150_var*
begin
//#UC START# *479731C50290_4CB586140150_impl*
 FreeAndNil(f_Document);
 inherited;
//#UC END# *479731C50290_4CB586140150_impl*
end;//TnevDocumentProviderEx.Cleanup

function TnevDocumentProviderEx.pm_GetCanProvideOriginalDocument: Boolean;
//#UC START# *4CB589C80045_4CB586140150get_var*
//#UC END# *4CB589C80045_4CB586140150get_var*
begin
//#UC START# *4CB589C80045_4CB586140150get_impl*
 {$IfDef nsTest}
{$IF not Defined(Archi) and not Defined(EverestLite)}
 if OldBehaviourForK235875079 then
  Result := false
 else
{$IfEnd}//{$IF not Defined(Archi) and not Defined(EverestLite)}
  Result := true;
 {$Else  nsTest}
 Result := true;
 {$EndIf nsTest}
//#UC END# *4CB589C80045_4CB586140150get_impl*
end;//TnevDocumentProviderEx.pm_GetCanProvideOriginalDocument

function TnevDocumentProviderEx.pm_GetOriginalDocument: Tl3Variant;
//#UC START# *4CB589F902EA_4CB586140150get_var*
//#UC END# *4CB589F902EA_4CB586140150get_var*
begin
//#UC START# *4CB589F902EA_4CB586140150get_impl*
 Result := f_Document;
//#UC END# *4CB589F902EA_4CB586140150get_impl*
end;//TnevDocumentProviderEx.pm_GetOriginalDocument

function TnevDocumentProviderEx.pm_GetPageSetup: IafwPageSetup;
//#UC START# *4D18832500B4_4CB586140150get_var*
//#UC END# *4D18832500B4_4CB586140150get_var*
begin
//#UC START# *4D18832500B4_4CB586140150get_impl*
{$IF not Defined(Archi) and not Defined(EverestLite)}
 {$IfDef nsTest}
 if OldBehaviourForK235875079 then
  Result := nil
 else
 {$EndIf nsTest}
{$IfEnd}//{$IF not Defined(Archi) and not Defined(EverestLite)}
 begin
  if (afw.Application <> nil) AND
     (afw.Application.PrintManager <> nil) then
   Result := afw.Application.PrintManager.PageSetup
  else
   Result := Self;
 end;//OldBehaviourForK235875079
//#UC END# *4D18832500B4_4CB586140150get_impl*
end;//TnevDocumentProviderEx.pm_GetPageSetup

end.