{$IfNDef nevChildSpy_imp}

// ������: "w:\common\components\gui\Garant\Everest\new\nevChildSpy.imp.pas"
// ���������: "Impurity"
// ������� ������: "nevChildSpy" MUID: (48171088022D)
// ��� ����: "_nevChildSpy_"

{$Define nevChildSpy_imp}

 _nevChildSpy_ = class(_nevChildSpy_Parent_)
  public
   procedure ChildAdded(const aList: InevParaList;
    const aChild: InevPara); virtual; abstract;
   procedure ChildDeleted(const aList: InevParaList;
    const aChild: InevPara); virtual; abstract;
 end;//_nevChildSpy_

{$Else nevChildSpy_imp}

{$IfNDef nevChildSpy_imp_impl}

{$Define nevChildSpy_imp_impl}

{$EndIf nevChildSpy_imp_impl}

{$EndIf nevChildSpy_imp}

