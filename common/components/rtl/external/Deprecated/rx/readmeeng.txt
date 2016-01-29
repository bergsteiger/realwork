HHHH       H            H        HHHH       H  H
H   H  HH  H  HHH  H HH    HHH  H     HH   H  HHH H   H  HHH  H HH  HH
H   H H  H H H  H  HH   H H     HH   H  H HHH  H  H H H H  H  HH   H  H
HHHH  H  H H H  H  H    H  HH     HH H  H  H   H   HHH  H  H  H    HHH   
H      HH  H  HHHH H    H    H     H  HH   H    H  H H   HHHH H    H   
H                         HHH  HHHH       H                         HHH

 ----------------------------
-=  Patch for RXLib 2.75.   =-
 ----------------------------
        Version 1.5

Unofficial set of correct and additional files RXLib 2.75 and not included to official Rx275fix.zip.

All changes marks in PAS-files by comments as // Polaris

Tested on Delphi 3 C/S Update Pack 2 (build 5.83),
          Delphi 4 C/S Update Pack 3 (build 5.108),
          Delphi 5 Ent Update Pack 1 (build 6.18),
          Delphi 6 Ent (build 6.163),
          BCB    4 Ent (build 14.4),
          BCB    5 Ent (build 12.34).

CHANGES (patch version is in brackets)
~~~~~~~
RxDBComb.pas
------------
TRxDBComboBox: 
1. Property EnableValues default True.
2.(1.0) Property Style default csDropDownList. Now if Style = csSingle or csDropDown then
   EnableValues = False.
3.(1.2) Property Align added.

ToolEdit.pas (pached for Polaris Library)
------------
1. TPopupWindow: method Show is virtual.
2. TCustomComboEdit: properties FButton, FPopupVisible, FFocused, SetShowCaret, SetDirectInput 
   are moved from private section to protected. Method DoChange is virtual.
TCustomDateEdit:
3.(1.2) properties MinDate, MaxDate and DateAutoBetween (last property controls Date if its value
        out of [MinDate, MaxDate]).
4.(1.2) SetDate is moved to protected section and it's virtual.
5.(1.3) The DateAutoBetween property controls values of the MinDate and MaxDate properties now: 
        if new MinDate's value is larger of MaxDate, then MinDate := MaxDate.
TCustomComboEdit: 
6.(1.2) Ctrl-Enter key inserted CR.
7.(1.3) Right and center alignment is worked properly now. (bug after article 5)
8.(1.3) Ctrl-Tab key inserted Tab.
9.(1.3) Exception raised during component's creating if GlyphKind changed in descendant's Create method.
10.(1.3) The right margin is reduced on 2 pixels.

Pickdate.pas
------------
1. TSelectDateDlg: TButton is replaced with TBitBtn.
2. Function SelectDate is changed for showing date select dialog (CalendarStyle=csDialog) in
   TDateEdit and TDBDateEdit not in screen center, but as popup dialog.
3.(1.2) SelectDate: if Sender=nil calendar is showed as default (in screen center).
4.(1.2) Changes in forms, related with new properties MinDate and MaxDate.

RxCConst.pas, RxCConst.r32
--------------------------
1.(1.2) The error messages for TDateEdit added.

RxLookup.pas
------------
TRxLookupControl: changed
1. behavior KeyValue - if KeyValue is empty NULL returns, but not Unassigned.
2. method ResetField - if TDataSet.State <> dsEdit then text is not cleared on press Esc.
3. method SetValue - event OnChange is not called if DataField, DataSource assigned and 
   property KeyValue changed.
4.(1.0) property EmptyStrIsNull added, which controls KeyValue when EmptyValue is empty:
   KeyValue := NULL (EmptyStrIsNull=True)  or  KeyValue := '' (EmptyStrIsNull=False) .

TRxDBLookupCombo: changed
5. method KeyPress - after press Esc for text clearing not continue process pressure.
6. method KeyValueChanged - DisplayEmpty value is not showed later, if DataField is lookup
   field and equal Null.
7.(1.0) Text right border moved left on two pixels if Alignment=taLeftJustify
   (like standard Delphi combo-components).
8.(1.2) Property Align added.
9.(1.3) Alignment is installed in the correspondence with Alignment property of DataField 
        if field's value is not empty.

RxCombos.pas
------------
TColorComboBox:
1. Array ColorValues increased to 41. Boolean property AllColors added - "use all colors".
2. Property ColorNames fill up with values from rxcombos.r32.
3.(1.0) ColorValues increased to 44 by constatants from VCLUtils.
4.(1.1) Changes from Rx275fix.zip.
5.(1.3) A custom color selecting is added, if coIncludeOther set in Options.
6.(1.3) Colors list creating bugs fixed.

rRxCombo.pas  [Added as interface to rxcombos.rc for TColorComboBox]
------------
1.(1.0) 3 colors added.
2.(1.1) 2 "colors" (None and Default) added.

RxCombos.r32
------------
1. Color names added.
2.(1.0) 3 colors added.
3.(1.1) 2 "colors" (None and Default) added.

ToolEdit.r32
------------
1. FEDITBMP: folder painted in yellow.

RxCtl.dpk,RxCtl4.dpk,RxCtl5.dpk,RxCtl.bpk,RxCtl4.bpk,RxCtl5.bpk
---------------------------------------------------------------
1.(1.1) rrxcombo.pas �dded in contains section.
2.(1.2) AppUtils.pas changed to RxAppUtils.pas. (only rxctl5.dpk)
3.(1.4) Changes 1,2 added to RxCtl.bpk,RxCtl4.bpk,RxCtl5.bpk.

RxAppUtils.pas
--------------
1.(1.2) Added for compatibility with Borland Integrated Translation Environment package.
   Same as AppUtils.pas.

Speedbar.pas, rxremlog.pas, Rxlogin.pas, Rxhints.pas, rxgrids.pas, Rxgrdcpt.pas, Rxdbctrl.pas,
Pictedit.pas, Placemnt.pas, Mrulist.pas, LoginDlg.pas, Dbutils.pas, Dbsecur.pas, BdeUtils.pas, 
Appevent.pas, Icoledit.pas
---------------------------------------------------------------------------------------------
1.(1.2) (D5) AppUtils changed to RxAppUtils in uses clause for compatibility with Borland 
Integrated Translation Environment package.

RxSpin.pas
----------
1.(1.2) Property TRxSpinButton.ButtonStyle added. It has values sbsDefault and sbsClassic 
(buttons like TSpinButton from Samples). Small changes in 'buttons' drawing.
2.(1.2) TRxCustomSpinEdit added.
TRxCustomSpinEdit:
3.(1.2) ButtonKind - value bkClassic added (TRxSpinButton.ButtonStyle=sbsClassic).
4.(1.2) Align and Alignment properties added.
5.(1.2) Exception not raise if Text cleared from debugging with Stop on Delphi Exceptions option.
6.(1.2) TRxSpinButton - default DownGlyph and UpGlyph property values are not saved in the DFM-file now.
TRxCustomSpinEdit:
7.(1.3) Properties CheckMinValue and CheckMaxValue added: if the MinValue property's value is 0 and 
CheckMinValue is False then MinValue not checked. There is similar algorithm for MaxValue and 
CheckMaxValue properties.
8.(1.4) Invalid text is not pasted from clipboard.
9.(1.4) CheckOnExit property added.

RxSpin.r32
----------
1.(1.2) Resources for sbsClassic buttons.

RxCtrls.pas
-----------
TRxSpeedButton:
1.(1.2) Property FlatStandard added (True - as Borland).
2.(1.2) Border drawing changed for Flat=True.

RxCalc.pas
----------
1.(1.2) Buttons sqrt, 1/x, % added in PopupCalculator. Buttons = and + enlarged.

CurrEdit.pas
------------
1.(1.2) TRxCalcEdit, TCurrencyEdit, other - Align property added.
2.(1.3) TCustomNumEdit - ButtonWidth = 21.
3.(1.4) TCustomNumEdit, TRxCalcEdit, TCurrencyEdit - DecimalPlaceRound property added - 
round to DecimalPlaces.

RxDBCtrl.pas
------------
1.(1.2) TRxDBGrid - fixed columns redraw properly after moving forms over its.
2.(1.2) TDBDateEdit - changes, related with the TDateEdit changings.

TRxDBCalcEdit:
3.(1.3) EmptyIsNull �roperty is added.
4.(1.3) If field's value is NULL then display empty string.
5.(1.4) TRxDBCalcEdit - DecimalPlaceRound �roperty added from TCustomNumEdit.

6.(1.5) TRxDBGrid - AutoAppend property is added.

RxResExp.pas
------------
1.(1.2) TRxProjectResExpert don't check created menuitem Resources during Create.

LoginDlg.pas
------------
1.(1.3) DB is closed before assigning new alias.

RxCtl6.*, RxDB6.*, RxBDE6.*, DclRx6.*, DclRxDB6.*, DclRxBD6.*, RxStrUtils.pas
-----------------------------------------------------------------------------
1.(1.5) Added for compatibility with Delphi 6.

AniFile.pas, BDEUtils.pas, CheckItm.pas, ClipMon.pas, CurrEdit.pas, DateUtil.pas, 
DBFilter.pas, DBUtils.pas, ExcptDlg.pas, FileUtil.pas, GradEdit.pas, HintProp.pas, 
IcoLEdit.pas, MinMaxEd.pas, ObjStr.pas, PgMngrEd.pas, PicClip.pas, PickDate.pas, 
PictEdit.pas, Placemnt.pas, PresrDsn.pas, RxAppUtils.pas, RxBDEReg.pas, RxCalc.pas,
RxClock.pas, RxColors.pas, RxConst.pas, RxCtlReg.pas, RxCtrls.pas, RxDBComb.pas,
RxDBCtrl.pas, RxDBReg.pas, RxDice.pas, RxDsgn.pas, RxGIF.pas, RxGrids.pas, RxIni.pas,
RxLookup.pas, RxMemDS.pas, RxMenus.pas, RxProps.pas, RxQuery.pas, RxResExp.pas,
RxSpin.pas, RxTooReg.pas, SBEdit.pas, SelDSFrm.pas, SpeedBar.pas, StrHlder.pas,
StrLEdit.pas, TimerLst.pas, TImLstEd.pas, ToolEdit.pas, VCLUtils.pas
------------------------------------------------------------------------------------
1. (1.5) Changed for compatibility with Delphi 6:
  - StrUtils is replaced with RxStrUtils in uses clause;
  - Variants, RTLConsts are added in uses clause;
  - DsgnIntf is replaced with DesignIntf, DesignEditors in uses clause;
  - IFormDesigner is replaced with IDesigner;
  - conflicts of methods are eliminated;
  - are kept almost all of Warnings, connected with support of several platforms 
    by Delphi and moving of separate functions and classes from one module in other.

INSTALL
~~~~~~~
Copy all files and folders from archive to Units folder, which located in folder where RXLib installed. 
After that recompile following packages
Delphi3: rxctl, rxdb, dclrxctl, dclrxdb.
Delphi4: rxctl4, rxdb4, dclrx4, dclrxdb4.
Delphi5: rxctl5, rxdb5, rxbde5, dclrx5, dclrxdb5, dclrxbd5.
Delphi6: rxctl6, rxdb6, rxbde6, dclrx6, dclrxdb6, dclrxbd6.
BCB4   : rxctl4, rxdb4, dclrx4, dclrxdb4.
BCB5   : rxctl5, rxdb5, rxbde5, dclrx5, dclrxdb5, dclrxbd5.

For English users:
Copy *.r32 files from Resource\Eng folder into <RxLibDir>\Units folder.


31.07.01

Regards,

Russia, Krasnodar
                                        Thanks to
Polaris Software 			Bergamot
http://members.xoom.com/PolarisSoft     http://come.to/bergamot
polesoft@mail.ru			bergamot@chat.ru