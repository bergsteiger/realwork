unit dxsbstrs;

interface
const
  DXSB_NEWITEM        = 37301;  // 'New item'

  {Constant strings which are using in Run-time} //37601 - 37700

  DXSB_DEFAULTGROUP          = 37302; //'Default'
  DXSB_DEFAULTITEMCAPTION    = 37303; //'New Item'
  DXSB_DEFAULTGROUPCAPTION   = 37304;  // 'New Group'

  //PopupMenu
  DXSB_ADDGROUP              = 37310;  //'Add Group';
  DXSB_REMOVEGROUP           = 37311;  //'Remove Group';
  DXSB_RENAMEGROUP           = 37312;  //'Rename Group';
  DXSB_REMOVEITEM            = 37313;  //'Remove ShortCut';
  DXSB_RENAMEITEM            = 37314;  //'Rename ShortCut';
  DXSB_LARGEICONTYPE         = 37315;  //'Large Icons';
  DXSB_SMALLICONTYPE         = 37316;  //'Small Icons';
  DXSB_CUSTOMIZE             = 37317;  //'Customize...';

  DXSB_CANTDELETEGROUP  = 37320; //'Can't delete the group. It has items.'

implementation
{$R dxsbstrs.res}

end.
