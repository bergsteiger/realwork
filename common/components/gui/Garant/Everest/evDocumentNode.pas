unit evDocumentNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evDocumentNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ContentsTree::TevDocumentNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Base,
  evContentsTagNode,
  l3Interfaces,
  l3Tree_TLB,
  evInternalInterfaces,
  l3Variant
  ;

type
 TevDocumentNode = class(TevContentsTagNode)
 private
 // private fields
   f_Name : Tl3String;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
 public
 // overridden public methods
   class function Make(aTag: Tl3Variant;
    const aFilter: InevContentsNodeFilter): Il3Node; override;
 end;//TevDocumentNode

implementation

uses
  l3String,
  nevInterfaces
  ;

// start class TevDocumentNode

procedure TevDocumentNode.Cleanup;
//#UC START# *479731C50290_4DFEF94101DF_var*
//#UC END# *479731C50290_4DFEF94101DF_var*
begin
//#UC START# *479731C50290_4DFEF94101DF_impl*
 l3Free(f_Name);
 inherited;
//#UC END# *479731C50290_4DFEF94101DF_impl*
end;//TevDocumentNode.Cleanup

function TevDocumentNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4DFEF94101DF_var*
//#UC END# *47A869BB02DE_4DFEF94101DF_var*
begin
//#UC START# *47A869BB02DE_4DFEF94101DF_impl*
 if (f_Name = nil) then
  f_Name := Tl3String.Make(l3PCharLen(str_nevmmTOC.AsCStr));
 Result := f_Name.AsPCharLen;
//#UC END# *47A869BB02DE_4DFEF94101DF_impl*
end;//TevDocumentNode.GetAsPCharLen

class function TevDocumentNode.Make(aTag: Tl3Variant;
  const aFilter: InevContentsNodeFilter): Il3Node;
//#UC START# *4DFF1D3501C1_4DFEF94101DF_var*
var
 l_DocNode: TevDocumentNode;
//#UC END# *4DFF1D3501C1_4DFEF94101DF_var*
begin
//#UC START# *4DFF1D3501C1_4DFEF94101DF_impl*
 l_DocNode := TevDocumentNode.Create(aTag, aFilter);
 try
  Result := l_DocNode;
 finally
  l3Free(l_DocNode);
 end;
//#UC END# *4DFF1D3501C1_4DFEF94101DF_impl*
end;//TevDocumentNode.Make

end.