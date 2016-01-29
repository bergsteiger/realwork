unit nscSimpleEditorForDialogs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis$Tails"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscSimpleEditorForDialogs.pas"
// Начат: 28.02.2011 15:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Nemesis$Tails::Editors::TnscSimpleEditorForDialogs
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

uses
  nscSimpleEditor,
  Classes,
  evCustomMemo,
  evEditorWithOperations
  ;

type
 TnscSimpleEditorForDialogs = class(TnscSimpleEditor)
 protected
 // overridden protected methods
   function TextSourceClass: RevCustomMemoTextSource; override;
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
     {* Какие операции публикуются компонентом. }
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   function KeepParaFormattingTag(aTag: Integer): Boolean; override;
     {* Сохранять ли элемент оформления }
   function UseMemoFontForParagraphs: Boolean; override;
    {$If not defined(NoVCL)}
   function CanFocus: Boolean; override;
    {$IfEnd} //not NoVCL
 end;//TnscSimpleEditorForDialogs

implementation

uses
  nscSimpleEditorForDialogsTextSource,
  k2Tags
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TnscSimpleEditorForDialogs

constructor TnscSimpleEditorForDialogs.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4D6B981E0319_var*
//#UC END# *47D1602000C6_4D6B981E0319_var*
begin
//#UC START# *47D1602000C6_4D6B981E0319_impl*
 inherited;
 PlainText := false;
 KeepAllFormatting := false;
 WebStyle := true;
 IsStaticText := true;
 TabStop := false;
//#UC END# *47D1602000C6_4D6B981E0319_impl*
end;//TnscSimpleEditorForDialogs.Create

function TnscSimpleEditorForDialogs.TextSourceClass: RevCustomMemoTextSource;
//#UC START# *482D9D1701E0_4D6B981E0319_var*
//#UC END# *482D9D1701E0_4D6B981E0319_var*
begin
//#UC START# *482D9D1701E0_4D6B981E0319_impl*
 Result := TnscSimpleEditorForDialogsTextSource;
//#UC END# *482D9D1701E0_4D6B981E0319_impl*
end;//TnscSimpleEditorForDialogs.TextSourceClass

function TnscSimpleEditorForDialogs.DefineProvideOperations: TevEditorProvideOperationTypes;
//#UC START# *48735C4A03C3_4D6B981E0319_var*
//#UC END# *48735C4A03C3_4D6B981E0319_var*
begin
//#UC START# *48735C4A03C3_4D6B981E0319_impl*
 {$ifdef nsTest}
 Result := [potEdit];
 {$else}
 Result := [];
 {$endif}
//#UC END# *48735C4A03C3_4D6B981E0319_impl*
end;//TnscSimpleEditorForDialogs.DefineProvideOperations

function TnscSimpleEditorForDialogs.KeepParaFormattingTag(aTag: Integer): Boolean;
//#UC START# *4A8A6D4701CC_4D6B981E0319_var*
//#UC END# *4A8A6D4701CC_4D6B981E0319_var*
begin
//#UC START# *4A8A6D4701CC_4D6B981E0319_impl*
 if (aTag = k2_tiSegments) OR
    (aTag = k2_tiBullet) OR
    (aTag = k2_tiFirstIndent) OR
    (aTag = k2_tiLeftIndent) OR
    (aTag = k2_tiRightIndent) OR
    (aTag = k2_tiStyle) OR
    (aTag = k2_tiJustification) OR
    (aTag = k2_tiFont) then
  Result := true
 else
  Result := inherited KeepParaFormattingTag(aTag);
//#UC END# *4A8A6D4701CC_4D6B981E0319_impl*
end;//TnscSimpleEditorForDialogs.KeepParaFormattingTag

function TnscSimpleEditorForDialogs.UseMemoFontForParagraphs: Boolean;
//#UC START# *4D6B97CB00AA_4D6B981E0319_var*
//#UC END# *4D6B97CB00AA_4D6B981E0319_var*
begin
//#UC START# *4D6B97CB00AA_4D6B981E0319_impl*
 Result := false{true};
//#UC END# *4D6B97CB00AA_4D6B981E0319_impl*
end;//TnscSimpleEditorForDialogs.UseMemoFontForParagraphs

{$If not defined(NoVCL)}
function TnscSimpleEditorForDialogs.CanFocus: Boolean;
//#UC START# *4E1350DE0094_4D6B981E0319_var*
//#UC END# *4E1350DE0094_4D6B981E0319_var*
begin
//#UC START# *4E1350DE0094_4D6B981E0319_impl*
 Result := false;
//#UC END# *4E1350DE0094_4D6B981E0319_impl*
end;//TnscSimpleEditorForDialogs.CanFocus
{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts)}
// Регистрация TnscSimpleEditorForDialogs
 TtfwClassRef.Register(TnscSimpleEditorForDialogs);
{$IfEnd} //not NoScripts

end.