unit ctAbstractEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/ComboTree/ctAbstractEdit.pas"
// Начат: 13.05.2008 20:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::ComboTree::TctAbstractEdit
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  ctButtonEdit
  ;

type
 TctAbstractEdit = class(TctButtonEdit)
 public
 // public methods
   procedure DeleteToClipboard; virtual;
   function CopyAllowed: Boolean; virtual;
   function CutAllowed: Boolean; virtual;
   function PasteAllowed: Boolean; virtual;
   function DeleteAllowed: Boolean; virtual;
 end;//TctAbstractEdit

implementation

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Clipbrd
  {$IfEnd} //not NoVCL
  ,
  l3Interfaces
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TctAbstractEdit

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
{$If not defined(NoScripts)}
// Регистрация TctAbstractEdit
 TtfwClassRef.Register(TctAbstractEdit);
{$IfEnd} //not NoScripts

end.