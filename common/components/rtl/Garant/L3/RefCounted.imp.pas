{$IfNDef RefCounted_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Basic Concepts"
// ������: "RefCounted.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi ���������� � �������������� �����������::L3$Basic Concepts::Ref Counting::RefCounted
//
// � ���� ������ �������� ������, ������� ��������� ����������� � �������� ��������
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define RefCounted_imp}
 _RefCountedPrim_Parent_ = _RefCounted_Parent_;
 {$Include ..\L3\RefCountedPrim.imp.pas}
 _RefCounted_ = {mixin} class(_RefCountedPrim_)
  {* � ���� ������ �������� ������, ������� ��������� ����������� � �������� �������� }
 public
 // public methods
   destructor Destroy;
     {* ��� ����� �� ���� �������� ����������� destroy. }
   class function NewInstance: TObject;
   procedure FreeInstance;
   procedure AfterConstruction;
   procedure BeforeDestruction;
 end;//_RefCounted_

{$Else RefCounted_imp}

{$Include ..\L3\RefCountedPrim.imp.pas}

// start class _RefCounted_

destructor _RefCounted_.Destroy;
//#UC START# *5161409E01B6_51614065019A_var*
//#UC END# *5161409E01B6_51614065019A_var*
begin
//#UC START# *5161409E01B6_51614065019A_impl*
 assert(false, '�� ���� �� ������� ���� �� ������');
 inherited;
//#UC END# *5161409E01B6_51614065019A_impl*
end;//_RefCounted_.Destroy

class function _RefCounted_.NewInstance: TObject;
//#UC START# *516D4E5A000A_51614065019A_var*
//#UC END# *516D4E5A000A_51614065019A_var*
begin
//#UC START# *516D4E5A000A_51614065019A_impl*
 Result := nil;
 assert(false);
//#UC END# *516D4E5A000A_51614065019A_impl*
end;//_RefCounted_.NewInstance

procedure _RefCounted_.FreeInstance;
//#UC START# *516D4E780193_51614065019A_var*
//#UC END# *516D4E780193_51614065019A_var*
begin
//#UC START# *516D4E780193_51614065019A_impl*
 assert(false);
//#UC END# *516D4E780193_51614065019A_impl*
end;//_RefCounted_.FreeInstance

procedure _RefCounted_.AfterConstruction;
//#UC START# *516D4E9403A0_51614065019A_var*
//#UC END# *516D4E9403A0_51614065019A_var*
begin
//#UC START# *516D4E9403A0_51614065019A_impl*
 assert(false);
//#UC END# *516D4E9403A0_51614065019A_impl*
end;//_RefCounted_.AfterConstruction

procedure _RefCounted_.BeforeDestruction;
//#UC START# *516D4EAD0095_51614065019A_var*
//#UC END# *516D4EAD0095_51614065019A_var*
begin
//#UC START# *516D4EAD0095_51614065019A_impl*
 assert(false);
//#UC END# *516D4EAD0095_51614065019A_impl*
end;//_RefCounted_.BeforeDestruction

{$EndIf RefCounted_imp}
