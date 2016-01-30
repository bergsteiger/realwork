unit ctAbstractEdit;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\ctAbstractEdit.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , ctButtonEdit
;

type
 TctAbstractEdit = class(TctButtonEdit)
  public
   procedure DeleteToClipboard; virtual;
   function CopyAllowed: Boolean; virtual;
   function CutAllowed: Boolean; virtual;
   function PasteAllowed: Boolean; virtual;
   function DeleteAllowed: Boolean; virtual;
 end;//TctAbstractEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Clipbrd
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TctAbstractEdit.DeleteToClipboard;
//#UC START# *482C806D02B4_4829BB0F0179_var*
//#UC END# *482C806D02B4_4829BB0F0179_var*
begin
//#UC START# *482C806D02B4_4829BB0F0179_impl*
 Assert(false);
//#UC END# *482C806D02B4_4829BB0F0179_impl*
end;//TctAbstractEdit.DeleteToClipboard

function TctAbstractEdit.CopyAllowed: Boolean;
//#UC START# *482C808C0188_4829BB0F0179_var*
//#UC END# *482C808C0188_4829BB0F0179_var*
begin
//#UC START# *482C808C0188_4829BB0F0179_impl*
 Result := HasSelection;
//#UC END# *482C808C0188_4829BB0F0179_impl*
end;//TctAbstractEdit.CopyAllowed

function TctAbstractEdit.CutAllowed: Boolean;
//#UC START# *482C809801F7_4829BB0F0179_var*
//#UC END# *482C809801F7_4829BB0F0179_var*
begin
//#UC START# *482C809801F7_4829BB0F0179_impl*
 Result := CopyAllowed;
//#UC END# *482C809801F7_4829BB0F0179_impl*
end;//TctAbstractEdit.CutAllowed

function TctAbstractEdit.PasteAllowed: Boolean;
//#UC START# *482C80A30223_4829BB0F0179_var*
//#UC END# *482C80A30223_4829BB0F0179_var*
begin
//#UC START# *482C80A30223_4829BB0F0179_impl*
 Result := not Readonly and ClipBoard.HasFormat(CF_TEXT);
//#UC END# *482C80A30223_4829BB0F0179_impl*
end;//TctAbstractEdit.PasteAllowed

function TctAbstractEdit.DeleteAllowed: Boolean;
//#UC START# *482C80CA01B7_4829BB0F0179_var*
//#UC END# *482C80CA01B7_4829BB0F0179_var*
begin
//#UC START# *482C80CA01B7_4829BB0F0179_impl*
 Result := CopyAllowed and not Readonly;
//#UC END# *482C80CA01B7_4829BB0F0179_impl*
end;//TctAbstractEdit.DeleteAllowed

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TctAbstractEdit);
 {* Регистрация TctAbstractEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
