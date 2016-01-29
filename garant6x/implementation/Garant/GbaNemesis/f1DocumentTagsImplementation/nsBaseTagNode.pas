unit nsBaseTagNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsBaseTagNode.pas"
// Начат: 19.08.2010 14:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsBaseTagNode
//
// Базовая реализация тега на уровне оболочки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  k2Interfaces,
  k2HugeTagObject,
  l3Variant
  ;

type
 TnsBaseTagNode = {abstract} class(Tk2HugeTagObject)
  {* Базовая реализация тега на уровне оболочки }
 protected
 // overridden protected methods
   function DeleteChildPrim(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack): Boolean; override;
 protected
 // protected methods
   function BaseDeleteChild(anIndex: Integer;
     const aContext: Ik2Op): Boolean;
   procedure CheckChildDelete(anIndex: Integer;
    aChild: Tl3Tag); virtual;
   function DoDeleteChild(anIndex: Integer;
    const aContext: Ik2Op): Boolean; virtual;
 end;//TnsBaseTagNode

implementation

// start class TnsBaseTagNode

function TnsBaseTagNode.BaseDeleteChild(anIndex: Integer;
  const aContext: Ik2Op): Boolean;
//#UC START# *4C6CEDA601C5_467FCA4701F9_var*
//#UC END# *4C6CEDA601C5_467FCA4701F9_var*
begin
//#UC START# *4C6CEDA601C5_467FCA4701F9_impl*
 Result := inherited DeleteChildPrim(anIndex, nil, aContext);
//#UC END# *4C6CEDA601C5_467FCA4701F9_impl*
end;//TnsBaseTagNode.BaseDeleteChild

procedure TnsBaseTagNode.CheckChildDelete(anIndex: Integer;
  aChild: Tl3Tag);
//#UC START# *4C6CED10018F_467FCA4701F9_var*
//#UC END# *4C6CED10018F_467FCA4701F9_var*
begin
//#UC START# *4C6CED10018F_467FCA4701F9_impl*
//#UC END# *4C6CED10018F_467FCA4701F9_impl*
end;//TnsBaseTagNode.CheckChildDelete

function TnsBaseTagNode.DoDeleteChild(anIndex: Integer;
  const aContext: Ik2Op): Boolean;
//#UC START# *4C6CED4C009B_467FCA4701F9_var*
//#UC END# *4C6CED4C009B_467FCA4701F9_var*
begin
//#UC START# *4C6CED4C009B_467FCA4701F9_impl*
 Result := BaseDeleteChild(anIndex, aContext);
//#UC END# *4C6CED4C009B_467FCA4701F9_impl*
end;//TnsBaseTagNode.DoDeleteChild

function TnsBaseTagNode.DeleteChildPrim(anIndex: Integer;
  aChild: Tl3Variant;
  const aContext: Il3OpPack): Boolean;
//#UC START# *4C6CE735026E_467FCA4701F9_var*
//#UC END# *4C6CE735026E_467FCA4701F9_var*
begin
//#UC START# *4C6CE735026E_467FCA4701F9_impl*
 CheckChildDelete(anIndex, aChild);
 Result := DoDeleteChild(anIndex, aContext);
//#UC END# *4C6CE735026E_467FCA4701F9_impl*
end;//TnsBaseTagNode.DeleteChildPrim

end.