unit OfficeLike_System_Controls;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_System_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "System" MUID: (4F6B439D0095)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Common = 'Common';
 en_capCommon = '';
 op_OpenNewWindowByUser = 'OpenNewWindowByUser';
 op_capOpenNewWindowByUser = '';
 op_GetWindowList = 'GetWindowList';
 op_capGetWindowList = '';
 op_CascadeWindows = 'CascadeWindows';
 op_capCascadeWindows = '';
 op_TileWindowsHorizontal = 'TileWindowsHorizontal';
 op_capTileWindowsHorizontal = '';
 op_TileWindowsVertical = 'TileWindowsVertical';
 op_capTileWindowsVertical = '';
 op_CloseAllWindows = 'CloseAllWindows';
 op_capCloseAllWindows = '';
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
