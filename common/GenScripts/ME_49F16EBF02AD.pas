unit nsUserTreeStructWithDrag;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\nsUserTreeStructWithDrag.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , nsUserTreeStruct
 , l3Interfaces
 , l3TreeInterfaces
 , l3InternalInterfaces
;

type
 TnsUserTreeStructWithDrag = class(TnsUserTreeStruct)
  protected
   function DoMakeDataObject(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap): IDataObject; override;
    {* объект данных дерева. aData - текущий элемент списка. aBitmap (Il3Bitmap) - картинка для перетаскивания }
 end;//TnsUserTreeStructWithDrag
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , bsUserDataObject
 , bsUserTreeData
;

function TnsUserTreeStructWithDrag.DoMakeDataObject(const aData: Il3SimpleNode;
 const aBitmap: Il3Bitmap): IDataObject;
 {* объект данных дерева. aData - текущий элемент списка. aBitmap (Il3Bitmap) - картинка для перетаскивания }
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
{$IfEnd} // Defined(Admin)

end.
