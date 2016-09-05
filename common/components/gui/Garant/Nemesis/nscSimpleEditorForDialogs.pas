unit nscSimpleEditorForDialogs;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogs.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscSimpleEditorForDialogs" MUID: (4D6B981E0319)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

uses
 l3IntfUses
 , nscSimpleEditor
 , evCustomMemo
 , evEditorWithOperations
 , Classes
;

type
 TnscSimpleEditorForDialogs = class(TnscSimpleEditor)
  protected
   function TextSourceClass: RevCustomMemoTextSource; override;
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* Какие операции публикуются компонентом. }
  public
   constructor Create(AOwner: TComponent); override;
   function KeepParaFormattingTag(aTag: Integer): Boolean; override;
    {* Сохранять ли элемент оформления }
   function UseMemoFontForParagraphs: Boolean; override;
   {$If NOT Defined(NoVCL)}
   function CanFocus: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TnscSimpleEditorForDialogs

implementation

uses
 l3ImplUses
 , nscSimpleEditorForDialogsTextSource
 , k2Tags
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4D6B981E0319impl_uses*
 //#UC END# *4D6B981E0319impl_uses*
;

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
 {* Какие операции публикуются компонентом. }
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
 {* Сохранять ли элемент оформления }
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

{$If NOT Defined(NoVCL)}
function TnscSimpleEditorForDialogs.CanFocus: Boolean;
//#UC START# *4E1350DE0094_4D6B981E0319_var*
//#UC END# *4E1350DE0094_4D6B981E0319_var*
begin
//#UC START# *4E1350DE0094_4D6B981E0319_impl*
 Result := false;
//#UC END# *4E1350DE0094_4D6B981E0319_impl*
end;//TnscSimpleEditorForDialogs.CanFocus
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscSimpleEditorForDialogs);
 {* Регистрация TnscSimpleEditorForDialogs }
{$IfEnd} // NOT Defined(NoScripts)

end.
