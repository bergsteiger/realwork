Unit VConst;

{ $Id: vconst.pas,v 1.22 2008/03/28 13:53:40 lulin Exp $ }

// $Log: vconst.pas,v $
// Revision 1.22  2008/03/28 13:53:40  lulin
// - рисуем модель в рамках <K>: 88081637.
//
// Revision 1.21  2007/08/14 14:29:59  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.20  2004/09/06 11:41:16  voba
// - _move romXXX  const to Com_Cnst
//
// Revision 1.19  2004/09/02 10:27:48  law
// - cleanup: убраны лишние зависимости.
//
// Revision 1.18  2004/08/19 14:17:33  step
// new: wm_RefreshDocs
//
// Revision 1.17  2003/11/19 17:05:01  voba
// no message
//
// Revision 1.16  2003/06/23 14:28:21  voba
// - спланировал  константы rom* = DT_Const.acg*
//
// Revision 1.15  2003/05/21 15:23:15  voba
// no message
//
// Revision 1.14  2003/04/19 11:24:48  law
// - new file: vtDefine.inc.
//
// Revision 1.13  2002/12/24 13:02:03  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.12  2002/12/23 13:02:13  voba
// no message
//
// Revision 1.11.4.1  2002/12/23 13:05:04  law
// - объединил с основной веткой (то что Вован забыл положить).
//
// Revision 1.12  2002/12/23 13:02:13  voba
// no message
//
// Revision 1.11  2002/02/05 15:04:43  voba
// no message
//
// Revision 1.10  2001/09/04 14:04:30  voba
// no message
//
// Revision 1.9  2001/02/20 13:24:13  voba
// no message
//
// Revision 1.8  2000/12/19 15:14:33  voba
// no message
//
// Revision 1.7  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

{$I vtDefine.inc }

interface

uses
  Messages,
  l3Interfaces
  ;

const
 {+-------------------------------+
 | Константы прогресс индикатора  |
 +--------------------------------+}
  piStart   = l3Interfaces.piStart;
  piCurrent = l3Interfaces.piCurrent;
  piEnd     = l3Interfaces.piEnd;

const
  vm_vtMessages       = wm_User + $100;
  {wm_DropAccept = wm_MYMessages;} {Define in DragData}
  wm_DelDoc           = vm_vtMessages + $01;
  wm_Logoff           = vm_vtMessages + $02;

  vm_WinSetBtn        = vm_vtMessages + $11;
  wm_WinAddClick      = vm_vtMessages + $12;
  wm_WinEditClick     = vm_vtMessages + $13;
  wm_WinDelClick      = vm_vtMessages + $14;

  wm_WinClipChange    = vm_vtMessages + $15;

  vm_Cut              = wm_Cut;//vm_vtMessages + $16;
  vm_Copy             = wm_Copy;//vm_vtMessages + $17;
  vm_Paste            = wm_Paste;//vm_vtMessages + $18;
  vm_Save             = vm_vtMessages + $19;
  vm_SaveAs           = vm_vtMessages + $20;
  vm_Print            = vm_vtMessages + $21;

  wm_IdleMsg          = vm_vtMessages + $22;
  vm_MDIChildActivate = vm_vtMessages + $23;
  wm_RefreshDocs      = vm_vtMessages + $24;

implementation

end.
