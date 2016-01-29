unit nsF1AutoreferatDocumentTagNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/nsF1AutoreferatDocumentTagNode.pas"
// Начат: 02.03.2011 17:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::Autoreferat::TnsF1AutoreferatDocumentTagNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsF1DocumentTagNode,
  k2Base,
  l3Variant
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsF1AutoreferatDocumentTagNode = class(TnsF1DocumentTagNode)
 protected
 // overridden protected methods
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
   function NodeChildrenCount: Integer; override;
 end;//TnsF1AutoreferatDocumentTagNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  k2Tags,
  F1TagDataProviderInterface
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsF1AutoreferatDocumentTagNode

function TnsF1AutoreferatDocumentTagNode.DoGetSubAtom(aProp: Tk2Prop;
  out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_4D6E58B300D2_var*
//#UC END# *4C6D1D450332_4D6E58B300D2_var*
begin
//#UC START# *4C6D1D450332_4D6E58B300D2_impl*
 Case aProp.TagIndex of
  k2_tiFixedWidth,
  k2_tiOrientation,
  k2_tiCollapsed:
   Result := BaseGetSubAtom(aProp, Data);
  else
   Result := inherited DoGetSubAtom(aProp, Data);
 end;//Case aProp.TagIndex
//#UC END# *4C6D1D450332_4D6E58B300D2_impl*
end;//TnsF1AutoreferatDocumentTagNode.DoGetSubAtom

function TnsF1AutoreferatDocumentTagNode.NodeChildrenCount: Integer;
//#UC START# *4CED5CEF011A_4D6E58B300D2_var*
//#UC END# *4CED5CEF011A_4D6E58B300D2_var*
begin
//#UC START# *4CED5CEF011A_4D6E58B300D2_impl*
 if TagDataProvider.IsProviderGot then
  Result := inherited NodeChildrenCount
 else
  Result := IntA[k2_tiAllChildrenCount]; 
//#UC END# *4CED5CEF011A_4D6E58B300D2_impl*
end;//TnsF1AutoreferatDocumentTagNode.NodeChildrenCount

{$IfEnd} //not Admin AND not Monitorings

end.