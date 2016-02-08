unit l3CProtoObject;
 {* ���������� Tl3ProtoObject }

// ������: "w:\common\components\rtl\Garant\L3\l3CProtoObject.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3CProtoObject = {abstract} class(Tl3ProtoObject)
  {* ���������� Tl3ProtoObject }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function NeedCleanupFields: Boolean; override;
 end;//Tl3CProtoObject

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CProtoObject.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_4AE5CA2D0034_var*
//#UC END# *47A6FEE600FC_4AE5CA2D0034_var*
begin
//#UC START# *47A6FEE600FC_4AE5CA2D0034_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4AE5CA2D0034_impl*
end;//Tl3CProtoObject.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function Tl3CProtoObject.NeedCleanupFields: Boolean;
//#UC START# *4AF44EC401EE_4AE5CA2D0034_var*
//#UC END# *4AF44EC401EE_4AE5CA2D0034_var*
begin
//#UC START# *4AF44EC401EE_4AE5CA2D0034_impl*
 Result := false;
//#UC END# *4AF44EC401EE_4AE5CA2D0034_impl*
end;//Tl3CProtoObject.NeedCleanupFields

end.
