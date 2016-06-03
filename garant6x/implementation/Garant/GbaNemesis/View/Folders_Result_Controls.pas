unit Folders_Result_Controls;
 {* Результат диалога }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Result_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Result" MUID: (4A97FFC40154)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Result = 'Result';
 en_capResult = 'Результат диалога';
 op_Append = 'Append';
 op_capAppend = 'Добавить';
 en_ResultExt = 'ResultExt';
 en_capResultExt = '';
 op_Ok = 'Ok';
 op_capOk = 'OK';
 op_Cancel = 'Cancel';
 op_capCancel = 'Отмена';

var st_user_ResultExt_Ok_None: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_NewFolder: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_Edit: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_Load: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <-> Загрузить }
var st_user_ResultExt_Ok_Select: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_FolderSave: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <-> Сохранить }
var st_user_ResultExt_Append_Bookmark: TvcmOperationStateIndex = (rID : -1);
 {*  -> Добавить <->  }
var st_user_ResultExt_Append_List: TvcmOperationStateIndex = (rID : -1);
 {*  -> Добавить <->  }
var st_user_ResultExt_Append_Query: TvcmOperationStateIndex = (rID : -1);
 {*  -> Добавить <->  }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
