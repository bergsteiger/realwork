unit evRootContentsNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evRootContentsNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ContentsTree::TevRootContentsNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3TreeInterfaces,
  l3Base,
  evContentsNode,
  l3Interfaces,
  l3Types
  ;

type
 TevRootContentsNode = class(TevContentsNode)
 private
 // private fields
   f_Text : Tl3String;
 protected
 // realized methods
   procedure DoTryGetChildren; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   function NeedMakeChildren: Boolean; override;
 public
 // public methods
   class function Make: Il3SimpleRootNode;
 end;//TevRootContentsNode

implementation

uses
  l3String
  ;

// start class TevRootContentsNode

class function TevRootContentsNode.Make: Il3SimpleRootNode;
//#UC START# *4DFF29C3012D_4DFEF8FA00FB_var*
var
 l_RCN: TevRootContentsNode;
//#UC END# *4DFF29C3012D_4DFEF8FA00FB_var*
begin
//#UC START# *4DFF29C3012D_4DFEF8FA00FB_impl*
 l_RCN := TevRootContentsNode.Create;
 try
  Result := l_RCN;
  l_RCN.Text := l3PCharLen('*');
 finally
  l3Free(l_RCN);
 end;
//#UC END# *4DFF29C3012D_4DFEF8FA00FB_impl*
end;//TevRootContentsNode.Make

procedure TevRootContentsNode.DoTryGetChildren;
//#UC START# *4DFF03AF01A1_4DFEF8FA00FB_var*
//#UC END# *4DFF03AF01A1_4DFEF8FA00FB_var*
begin
//#UC START# *4DFF03AF01A1_4DFEF8FA00FB_impl*
//#UC END# *4DFF03AF01A1_4DFEF8FA00FB_impl*
end;//TevRootContentsNode.DoTryGetChildren

procedure TevRootContentsNode.Cleanup;
//#UC START# *479731C50290_4DFEF8FA00FB_var*
//#UC END# *479731C50290_4DFEF8FA00FB_var*
begin
//#UC START# *479731C50290_4DFEF8FA00FB_impl*
 l3Free(f_Text);
 inherited;
//#UC END# *479731C50290_4DFEF8FA00FB_impl*
end;//TevRootContentsNode.Cleanup

function TevRootContentsNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4DFEF8FA00FB_var*
//#UC END# *47A869BB02DE_4DFEF8FA00FB_var*
begin
//#UC START# *47A869BB02DE_4DFEF8FA00FB_impl*
 Result := f_Text.AsPCharLen;
//#UC END# *47A869BB02DE_4DFEF8FA00FB_impl*
end;//TevRootContentsNode.GetAsPCharLen

procedure TevRootContentsNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_4DFEF8FA00FB_var*
//#UC END# *47A869D10074_4DFEF8FA00FB_var*
begin
//#UC START# *47A869D10074_4DFEF8FA00FB_impl*
 l3Set(f_Text, Value);
//#UC END# *47A869D10074_4DFEF8FA00FB_impl*
end;//TevRootContentsNode.DoSetAsPCharLen

function TevRootContentsNode.NeedMakeChildren: Boolean;
//#UC START# *4DFF1C860175_4DFEF8FA00FB_var*
//#UC END# *4DFF1C860175_4DFEF8FA00FB_var*
begin
//#UC START# *4DFF1C860175_4DFEF8FA00FB_impl*
 Result := False;
//#UC END# *4DFF1C860175_4DFEF8FA00FB_impl*
end;//TevRootContentsNode.NeedMakeChildren

end.