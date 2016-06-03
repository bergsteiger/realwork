unit OfficeLike_Tree_Controls;
 {* Представление в виде дерева }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Tree_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Tree" MUID: (4BDAF7510113)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Tree = 'Tree';
 en_capTree = 'Дерево';
 op_ExpandAll = 'ExpandAll';
 op_capExpandAll = 'Развернуть все';
 op_CollapseAll = 'CollapseAll';
 op_capCollapseAll = 'Свернуть все';
 op_Wrap = 'Wrap';
 op_capWrap = 'Перенос по словам';
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
