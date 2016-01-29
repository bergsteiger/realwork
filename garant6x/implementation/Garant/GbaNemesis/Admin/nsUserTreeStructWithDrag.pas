unit nsUserTreeStructWithDrag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Admin"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/nsUserTreeStructWithDrag.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 �������������::Admin::Admin::Users::TnsUserTreeStructWithDrag
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  nsUserTreeStruct,
  l3Interfaces,
  l3InternalInterfaces,
  l3TreeInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TnsUserTreeStructWithDrag = class(TnsUserTreeStruct)
 protected
 // overridden protected methods
   function DoMakeDataObject(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap): IDataObject; override;
     {* ������ ������ ������. aData - ������� ������� ������. aBitmap (Il3Bitmap) - �������� ��� �������������� }
 end;//TnsUserTreeStructWithDrag
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  bsUserDataObject,
  bsUserTreeData
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TnsUserTreeStructWithDrag

function TnsUserTreeStructWithDrag.DoMakeDataObject(const aData: Il3SimpleNode;
  const aBitmap: Il3Bitmap): IDataObject;
//#UC START# *48FEE6210205_49F16EBF02AD_var*
//#UC END# *48FEE6210205_49F16EBF02AD_var*
begin
//#UC START# *48FEE6210205_49F16EBF02AD_impl*
 Result := inherited DoMakeDataObject(aData, aBitmap);
 if Result = nil then
  Result := TbsUserDataObject.Make(aData, aBitmap,
   TbsUserTreeData.Make(Self, aData));
//#UC END# *48FEE6210205_49F16EBF02AD_impl*
end;//TnsUserTreeStructWithDrag.DoMakeDataObject

{$IfEnd} //Admin

end.