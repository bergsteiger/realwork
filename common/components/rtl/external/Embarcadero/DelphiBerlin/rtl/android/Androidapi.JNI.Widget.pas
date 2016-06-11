{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Widget;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util;

type
// ===== Forward declarations =====

  JAdapterView = interface;//android.widget.AdapterView
  JAbsListView = interface;//android.widget.AbsListView
  JAbsListView_LayoutParams = interface;//android.widget.AbsListView$LayoutParams
  JAbsListView_MultiChoiceModeListener = interface;//android.widget.AbsListView$MultiChoiceModeListener
  JAbsListView_OnScrollListener = interface;//android.widget.AbsListView$OnScrollListener
  JAbsListView_RecyclerListener = interface;//android.widget.AbsListView$RecyclerListener
  JAbsoluteLayout = interface;//android.widget.AbsoluteLayout
  JAdapter = interface;//android.widget.Adapter
  JAdapterView_OnItemClickListener = interface;//android.widget.AdapterView$OnItemClickListener
  JAdapterView_OnItemLongClickListener = interface;//android.widget.AdapterView$OnItemLongClickListener
  JAdapterView_OnItemSelectedListener = interface;//android.widget.AdapterView$OnItemSelectedListener
  JBaseAdapter = interface;//android.widget.BaseAdapter
  JTextView = interface;//android.widget.TextView
  JButton = interface;//android.widget.Button
  JFrameLayout = interface;//android.widget.FrameLayout
  JCalendarView = interface;//android.widget.CalendarView
  JCalendarView_OnDateChangeListener = interface;//android.widget.CalendarView$OnDateChangeListener
  JDatePicker = interface;//android.widget.DatePicker
  JDatePicker_OnDateChangedListener = interface;//android.widget.DatePicker$OnDateChangedListener
  JEditText = interface;//android.widget.EditText
  JFrameLayout_LayoutParams = interface;//android.widget.FrameLayout$LayoutParams
  JImageView = interface;//android.widget.ImageView
  JImageView_ScaleType = interface;//android.widget.ImageView$ScaleType
  JLinearLayout = interface;//android.widget.LinearLayout
  JLinearLayout_LayoutParams = interface;//android.widget.LinearLayout$LayoutParams
  JListAdapter = interface;//android.widget.ListAdapter
  JListView = interface;//android.widget.ListView
  JPopupWindow = interface;//android.widget.PopupWindow
  JPopupWindow_OnDismissListener = interface;//android.widget.PopupWindow$OnDismissListener
  JRelativeLayout = interface;//android.widget.RelativeLayout
  JRelativeLayout_LayoutParams = interface;//android.widget.RelativeLayout$LayoutParams
  JRemoteViews = interface;//android.widget.RemoteViews
  JScrollView = interface;//android.widget.ScrollView
  JScroller = interface;//android.widget.Scroller
  JSpinnerAdapter = interface;//android.widget.SpinnerAdapter
  JTextView_BufferType = interface;//android.widget.TextView$BufferType
  JTextView_OnEditorActionListener = interface;//android.widget.TextView$OnEditorActionListener
  JTimePicker = interface;//android.widget.TimePicker
  JTimePicker_OnTimeChangedListener = interface;//android.widget.TimePicker$OnTimeChangedListener
  JToast = interface;//android.widget.Toast
  JToolbar = interface;//android.widget.Toolbar
  //JToolbar_LayoutParams = interface;//android.widget.Toolbar$LayoutParams
  JToolbar_OnMenuItemClickListener = interface;//android.widget.Toolbar$OnMenuItemClickListener

// ===== Interface declarations =====

  JAdapterViewClass = interface(JViewGroupClass)
    ['{6490B102-5823-45D6-A2C4-E7211652D552}']
    {class} function _GetINVALID_POSITION: Integer; cdecl;
    {class} function _GetINVALID_ROW_ID: Int64; cdecl;
    {class} function _GetITEM_VIEW_TYPE_HEADER_OR_FOOTER: Integer; cdecl;
    {class} function _GetITEM_VIEW_TYPE_IGNORE: Integer; cdecl;
    {class} function init(context: JContext): JAdapterView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JAdapterView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JAdapterView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JAdapterView; cdecl; overload;
    {class} property INVALID_POSITION: Integer read _GetINVALID_POSITION;
    {class} property INVALID_ROW_ID: Int64 read _GetINVALID_ROW_ID;
    {class} property ITEM_VIEW_TYPE_HEADER_OR_FOOTER: Integer read _GetITEM_VIEW_TYPE_HEADER_OR_FOOTER;
    {class} property ITEM_VIEW_TYPE_IGNORE: Integer read _GetITEM_VIEW_TYPE_IGNORE;
  end;

  [JavaSignature('android/widget/AdapterView')]
  JAdapterView = interface(JViewGroup)
    ['{7A567A58-E436-4C18-94B6-DCE4ECB35FDB}']
    procedure addView(child: JView); cdecl; overload;
    procedure addView(child: JView; index: Integer); cdecl; overload;
    procedure addView(child: JView; params: JViewGroup_LayoutParams); cdecl; overload;
    procedure addView(child: JView; index: Integer; params: JViewGroup_LayoutParams); cdecl; overload;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getAdapter: JAdapter; cdecl;
    function getCount: Integer; cdecl;
    function getEmptyView: JView; cdecl;
    function getFirstVisiblePosition: Integer; cdecl;
    function getItemAtPosition(position: Integer): JObject; cdecl;
    function getItemIdAtPosition(position: Integer): Int64; cdecl;
    function getLastVisiblePosition: Integer; cdecl;
    function getOnItemClickListener: JAdapterView_OnItemClickListener; cdecl;
    function getOnItemLongClickListener: JAdapterView_OnItemLongClickListener; cdecl;
    function getOnItemSelectedListener: JAdapterView_OnItemSelectedListener; cdecl;
    function getPositionForView(view: JView): Integer; cdecl;
    function getSelectedItem: JObject; cdecl;
    function getSelectedItemId: Int64; cdecl;
    function getSelectedItemPosition: Integer; cdecl;
    function getSelectedView: JView; cdecl;
    function performItemClick(view: JView; position: Integer; id: Int64): Boolean; cdecl;
    procedure removeAllViews; cdecl;
    procedure removeView(child: JView); cdecl;
    procedure removeViewAt(index: Integer); cdecl;
    procedure setAdapter(adapter: JAdapter); cdecl;
    procedure setEmptyView(emptyView: JView); cdecl;
    procedure setFocusable(focusable: Boolean); cdecl;
    procedure setFocusableInTouchMode(focusable: Boolean); cdecl;
    procedure setOnClickListener(l: JView_OnClickListener); cdecl;
    procedure setOnItemClickListener(listener: JAdapterView_OnItemClickListener); cdecl;
    procedure setOnItemLongClickListener(listener: JAdapterView_OnItemLongClickListener); cdecl;
    procedure setOnItemSelectedListener(listener: JAdapterView_OnItemSelectedListener); cdecl;
    procedure setSelection(position: Integer); cdecl;
  end;
  TJAdapterView = class(TJavaGenericImport<JAdapterViewClass, JAdapterView>) end;

  JAbsListViewClass = interface(JAdapterViewClass)
    ['{BAC07826-4DE7-4811-BCF8-A4E35AF7F784}']
    {class} function _GetCHOICE_MODE_MULTIPLE: Integer; cdecl;
    {class} function _GetCHOICE_MODE_MULTIPLE_MODAL: Integer; cdecl;
    {class} function _GetCHOICE_MODE_NONE: Integer; cdecl;
    {class} function _GetCHOICE_MODE_SINGLE: Integer; cdecl;
    {class} function _GetTRANSCRIPT_MODE_ALWAYS_SCROLL: Integer; cdecl;
    {class} function _GetTRANSCRIPT_MODE_DISABLED: Integer; cdecl;
    {class} function _GetTRANSCRIPT_MODE_NORMAL: Integer; cdecl;
    {class} function init(context: JContext): JAbsListView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JAbsListView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JAbsListView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JAbsListView; cdecl; overload;
    {class} property CHOICE_MODE_MULTIPLE: Integer read _GetCHOICE_MODE_MULTIPLE;
    {class} property CHOICE_MODE_MULTIPLE_MODAL: Integer read _GetCHOICE_MODE_MULTIPLE_MODAL;
    {class} property CHOICE_MODE_NONE: Integer read _GetCHOICE_MODE_NONE;
    {class} property CHOICE_MODE_SINGLE: Integer read _GetCHOICE_MODE_SINGLE;
    {class} property TRANSCRIPT_MODE_ALWAYS_SCROLL: Integer read _GetTRANSCRIPT_MODE_ALWAYS_SCROLL;
    {class} property TRANSCRIPT_MODE_DISABLED: Integer read _GetTRANSCRIPT_MODE_DISABLED;
    {class} property TRANSCRIPT_MODE_NORMAL: Integer read _GetTRANSCRIPT_MODE_NORMAL;
  end;

  [JavaSignature('android/widget/AbsListView')]
  JAbsListView = interface(JAdapterView)
    ['{F366DE71-7C40-4135-8C83-F7354D97A276}']
    procedure addTouchables(views: JArrayList); cdecl;
    procedure afterTextChanged(s: JEditable); cdecl;
    procedure beforeTextChanged(s: JCharSequence; start: Integer; count: Integer; after: Integer); cdecl;
    function canScrollList(direction: Integer): Boolean; cdecl;
    function checkInputConnectionProxy(view: JView): Boolean; cdecl;
    procedure clearChoices; cdecl;
    procedure clearTextFilter; cdecl;
    procedure deferNotifyDataSetChanged; cdecl;
    procedure dispatchDrawableHotspotChanged(x: Single; y: Single); cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    procedure fling(velocityY: Integer); cdecl;
    function generateLayoutParams(attrs: JAttributeSet): JAbsListView_LayoutParams; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getCacheColorHint: Integer; cdecl;
    function getCheckedItemCount: Integer; cdecl;
    function getCheckedItemIds: TJavaArray<Int64>; cdecl;
    function getCheckedItemPosition: Integer; cdecl;
    function getCheckedItemPositions: JSparseBooleanArray; cdecl;
    function getChoiceMode: Integer; cdecl;
    procedure getFocusedRect(r: JRect); cdecl;
    function getListPaddingBottom: Integer; cdecl;
    function getListPaddingLeft: Integer; cdecl;
    function getListPaddingRight: Integer; cdecl;
    function getListPaddingTop: Integer; cdecl;
    function getSelectedView: JView; cdecl;
    function getSelector: JDrawable; cdecl;
    function getSolidColor: Integer; cdecl;
    function getTextFilter: JCharSequence; cdecl;
    function getTranscriptMode: Integer; cdecl;
    function getVerticalScrollbarWidth: Integer; cdecl;
    function hasTextFilter: Boolean; cdecl;
    procedure invalidateViews; cdecl;
    function isFastScrollAlwaysVisible: Boolean; cdecl;
    function isFastScrollEnabled: Boolean; cdecl;
    function isItemChecked(position: Integer): Boolean; cdecl;
    function isScrollingCacheEnabled: Boolean; cdecl;
    function isSmoothScrollbarEnabled: Boolean; cdecl;
    function isStackFromBottom: Boolean; cdecl;
    function isTextFilterEnabled: Boolean; cdecl;
    procedure jumpDrawablesToCurrentState; cdecl;
    procedure onCancelPendingInputEvents; cdecl;
    function onCreateInputConnection(outAttrs: JEditorInfo): JInputConnection; cdecl;
    procedure onFilterComplete(count: Integer); cdecl;
    function onGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onGlobalLayout; cdecl;
    procedure onInitializeAccessibilityNodeInfoForItem(view: JView; position: Integer; info: JAccessibilityNodeInfo); cdecl;
    function onInterceptHoverEvent(event: JMotionEvent): Boolean; cdecl;
    function onInterceptTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onNestedFling(target: JView; velocityX: Single; velocityY: Single; consumed: Boolean): Boolean; cdecl;
    procedure onNestedScroll(target: JView; dxConsumed: Integer; dyConsumed: Integer; dxUnconsumed: Integer; dyUnconsumed: Integer); cdecl;
    procedure onNestedScrollAccepted(child: JView; target: JView; axes: Integer); cdecl;
    function onRemoteAdapterConnected: Boolean; cdecl;
    procedure onRemoteAdapterDisconnected; cdecl;
    procedure onRestoreInstanceState(state: JParcelable); cdecl;
    procedure onRtlPropertiesChanged(layoutDirection: Integer); cdecl;
    function onSaveInstanceState: JParcelable; cdecl;
    function onStartNestedScroll(child: JView; target: JView; nestedScrollAxes: Integer): Boolean; cdecl;
    procedure onTextChanged(s: JCharSequence; start: Integer; before: Integer; count: Integer); cdecl;
    function onTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    procedure onTouchModeChanged(isInTouchMode: Boolean); cdecl;
    procedure onWindowFocusChanged(hasWindowFocus: Boolean); cdecl;
    function performItemClick(view: JView; position: Integer; id: Int64): Boolean; cdecl;
    function pointToPosition(x: Integer; y: Integer): Integer; cdecl;
    function pointToRowId(x: Integer; y: Integer): Int64; cdecl;
    procedure reclaimViews(views: JList); cdecl;
    procedure requestDisallowInterceptTouchEvent(disallowIntercept: Boolean); cdecl;
    procedure requestLayout; cdecl;
    procedure scrollListBy(y: Integer); cdecl;
    procedure setAdapter(adapter: JListAdapter); cdecl;
    procedure setCacheColorHint(color: Integer); cdecl;
    procedure setChoiceMode(choiceMode: Integer); cdecl;
    procedure setDrawSelectorOnTop(onTop: Boolean); cdecl;
    procedure setFastScrollAlwaysVisible(alwaysShow: Boolean); cdecl;
    procedure setFastScrollEnabled(enabled: Boolean); cdecl;
    procedure setFastScrollStyle(styleResId: Integer); cdecl;
    procedure setFilterText(filterText: JString); cdecl;
    procedure setFriction(friction: Single); cdecl;
    procedure setItemChecked(position: Integer; value: Boolean); cdecl;
    procedure setMultiChoiceModeListener(listener: JAbsListView_MultiChoiceModeListener); cdecl;
    procedure setOnScrollListener(l: JAbsListView_OnScrollListener); cdecl;
    procedure setOverScrollMode(mode: Integer); cdecl;
    procedure setRecyclerListener(listener: JAbsListView_RecyclerListener); cdecl;
    procedure setRemoteViewsAdapter(intent: JIntent); cdecl;
    procedure setScrollBarStyle(style: Integer); cdecl;
    procedure setScrollIndicators(up: JView; down: JView); cdecl;
    procedure setScrollingCacheEnabled(enabled: Boolean); cdecl;
    procedure setSelectionFromTop(position: Integer; y: Integer); cdecl;
    procedure setSelector(resID: Integer); cdecl; overload;
    procedure setSelector(sel: JDrawable); cdecl; overload;
    procedure setSmoothScrollbarEnabled(enabled: Boolean); cdecl;
    procedure setStackFromBottom(stackFromBottom: Boolean); cdecl;
    procedure setTextFilterEnabled(textFilterEnabled: Boolean); cdecl;
    procedure setTranscriptMode(mode: Integer); cdecl;
    procedure setVelocityScale(scale: Single); cdecl;
    procedure setVerticalScrollbarPosition(position: Integer); cdecl;
    function showContextMenuForChild(originalView: JView): Boolean; cdecl;
    procedure smoothScrollBy(distance: Integer; duration: Integer); cdecl;
    procedure smoothScrollToPosition(position: Integer); cdecl; overload;
    procedure smoothScrollToPosition(position: Integer; boundPosition: Integer); cdecl; overload;
    procedure smoothScrollToPositionFromTop(position: Integer; offset: Integer; duration: Integer); cdecl; overload;
    procedure smoothScrollToPositionFromTop(position: Integer; offset: Integer); cdecl; overload;
    function verifyDrawable(dr: JDrawable): Boolean; cdecl;
  end;
  TJAbsListView = class(TJavaGenericImport<JAbsListViewClass, JAbsListView>) end;

  JAbsListView_LayoutParamsClass = interface(JViewGroup_LayoutParamsClass)
    ['{BA119D83-F4CC-4B61-B09E-949DDD5F3E2C}']
    {class} function init(c: JContext; attrs: JAttributeSet): JAbsListView_LayoutParams; cdecl; overload;
    {class} function init(w: Integer; h: Integer): JAbsListView_LayoutParams; cdecl; overload;
    {class} function init(w: Integer; h: Integer; viewType: Integer): JAbsListView_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_LayoutParams): JAbsListView_LayoutParams; cdecl; overload;
  end;

  [JavaSignature('android/widget/AbsListView$LayoutParams')]
  JAbsListView_LayoutParams = interface(JViewGroup_LayoutParams)
    ['{0257889C-E50D-40DF-8A0E-1CABF3504F80}']
  end;
  TJAbsListView_LayoutParams = class(TJavaGenericImport<JAbsListView_LayoutParamsClass, JAbsListView_LayoutParams>) end;

  JAbsListView_MultiChoiceModeListenerClass = interface(JActionMode_CallbackClass)
    ['{8BB552DD-2198-4EE3-954D-7AED2EA26652}']
  end;

  [JavaSignature('android/widget/AbsListView$MultiChoiceModeListener')]
  JAbsListView_MultiChoiceModeListener = interface(JActionMode_Callback)
    ['{33997ECE-97BD-47EF-BCAD-E9175C1E4DED}']
    procedure onItemCheckedStateChanged(mode: JActionMode; position: Integer; id: Int64; checked: Boolean); cdecl;
  end;
  TJAbsListView_MultiChoiceModeListener = class(TJavaGenericImport<JAbsListView_MultiChoiceModeListenerClass, JAbsListView_MultiChoiceModeListener>) end;

  JAbsListView_OnScrollListenerClass = interface(IJavaClass)
    ['{479243DC-B7C6-4219-A4EA-4DB71A796E0D}']
    {class} function _GetSCROLL_STATE_FLING: Integer; cdecl;
    {class} function _GetSCROLL_STATE_IDLE: Integer; cdecl;
    {class} function _GetSCROLL_STATE_TOUCH_SCROLL: Integer; cdecl;
    {class} property SCROLL_STATE_FLING: Integer read _GetSCROLL_STATE_FLING;
    {class} property SCROLL_STATE_IDLE: Integer read _GetSCROLL_STATE_IDLE;
    {class} property SCROLL_STATE_TOUCH_SCROLL: Integer read _GetSCROLL_STATE_TOUCH_SCROLL;
  end;

  [JavaSignature('android/widget/AbsListView$OnScrollListener')]
  JAbsListView_OnScrollListener = interface(IJavaInstance)
    ['{9B3AA66F-2D52-4E66-BF3B-4664B89919F7}']
    procedure onScroll(view: JAbsListView; firstVisibleItem: Integer; visibleItemCount: Integer; totalItemCount: Integer); cdecl;
    procedure onScrollStateChanged(view: JAbsListView; scrollState: Integer); cdecl;
  end;
  TJAbsListView_OnScrollListener = class(TJavaGenericImport<JAbsListView_OnScrollListenerClass, JAbsListView_OnScrollListener>) end;

  JAbsListView_RecyclerListenerClass = interface(IJavaClass)
    ['{06DBD286-C7E2-43B3-B493-7DA33E6C15BC}']
  end;

  [JavaSignature('android/widget/AbsListView$RecyclerListener')]
  JAbsListView_RecyclerListener = interface(IJavaInstance)
    ['{FD43448A-4F16-42C9-BA44-62CB7DC68E6C}']
    procedure onMovedToScrapHeap(view: JView); cdecl;
  end;
  TJAbsListView_RecyclerListener = class(TJavaGenericImport<JAbsListView_RecyclerListenerClass, JAbsListView_RecyclerListener>) end;

  JAbsoluteLayoutClass = interface(JViewGroupClass)
    ['{FD88C087-3EAF-4ABA-A323-5C0788D7B04F}']
    {class} function init(context: JContext): JAbsoluteLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JAbsoluteLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JAbsoluteLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JAbsoluteLayout; cdecl; overload;
  end;

  [JavaSignature('android/widget/AbsoluteLayout')]
  JAbsoluteLayout = interface(JViewGroup)
    ['{0880FBEB-72E8-4BFB-922D-A773808F1999}']
    function generateLayoutParams(attrs: JAttributeSet): JViewGroup_LayoutParams; cdecl;
    function shouldDelayChildPressedState: Boolean; cdecl;
  end;
  TJAbsoluteLayout = class(TJavaGenericImport<JAbsoluteLayoutClass, JAbsoluteLayout>) end;

  JAdapterClass = interface(IJavaClass)
    ['{3958FE3D-7A07-4294-B0AD-318CFF53495F}']
    {class} function _GetIGNORE_ITEM_VIEW_TYPE: Integer; cdecl;
    {class} function _GetNO_SELECTION: Integer; cdecl;
    {class} property IGNORE_ITEM_VIEW_TYPE: Integer read _GetIGNORE_ITEM_VIEW_TYPE;
    {class} property NO_SELECTION: Integer read _GetNO_SELECTION;
  end;

  [JavaSignature('android/widget/Adapter')]
  JAdapter = interface(IJavaInstance)
    ['{0D24EAC8-AFC6-4494-B3D7-B7A70C11B7A2}']
    function getCount: Integer; cdecl;
    function getItem(position: Integer): JObject; cdecl;
    function getItemId(position: Integer): Int64; cdecl;
    function getItemViewType(position: Integer): Integer; cdecl;
    function getView(position: Integer; convertView: JView; parent: JViewGroup): JView; cdecl;
    function getViewTypeCount: Integer; cdecl;
    function hasStableIds: Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    procedure registerDataSetObserver(observer: JDataSetObserver); cdecl;
    procedure unregisterDataSetObserver(observer: JDataSetObserver); cdecl;
  end;
  TJAdapter = class(TJavaGenericImport<JAdapterClass, JAdapter>) end;

  JAdapterView_OnItemClickListenerClass = interface(IJavaClass)
    ['{927C4193-A697-4855-B9DB-F8E7238E505B}']
  end;

  [JavaSignature('android/widget/AdapterView$OnItemClickListener')]
  JAdapterView_OnItemClickListener = interface(IJavaInstance)
    ['{C961007F-9268-49A1-A7D2-FF18F99CB04F}']
    procedure onItemClick(parent: JAdapterView; view: JView; position: Integer; id: Int64); cdecl;
  end;
  TJAdapterView_OnItemClickListener = class(TJavaGenericImport<JAdapterView_OnItemClickListenerClass, JAdapterView_OnItemClickListener>) end;

  JAdapterView_OnItemLongClickListenerClass = interface(IJavaClass)
    ['{56FC07F2-9B26-4321-BBA7-87B90FE02F20}']
  end;

  [JavaSignature('android/widget/AdapterView$OnItemLongClickListener')]
  JAdapterView_OnItemLongClickListener = interface(IJavaInstance)
    ['{64F90302-CAC6-499D-85CB-B8159D130BE7}']
    function onItemLongClick(parent: JAdapterView; view: JView; position: Integer; id: Int64): Boolean; cdecl;
  end;
  TJAdapterView_OnItemLongClickListener = class(TJavaGenericImport<JAdapterView_OnItemLongClickListenerClass, JAdapterView_OnItemLongClickListener>) end;

  JAdapterView_OnItemSelectedListenerClass = interface(IJavaClass)
    ['{8CC3E8E8-40EF-49D6-990B-985B599D11E1}']
  end;

  [JavaSignature('android/widget/AdapterView$OnItemSelectedListener')]
  JAdapterView_OnItemSelectedListener = interface(IJavaInstance)
    ['{81BE7775-99A9-4BF0-B1D4-920851584468}']
    procedure onItemSelected(parent: JAdapterView; view: JView; position: Integer; id: Int64); cdecl;
    procedure onNothingSelected(parent: JAdapterView); cdecl;
  end;
  TJAdapterView_OnItemSelectedListener = class(TJavaGenericImport<JAdapterView_OnItemSelectedListenerClass, JAdapterView_OnItemSelectedListener>) end;

  JBaseAdapterClass = interface(JObjectClass)
    ['{EF2DDA32-D53B-4127-8BDB-D0080A04ABE7}']
    {class} function init: JBaseAdapter; cdecl;
  end;

  [JavaSignature('android/widget/BaseAdapter')]
  JBaseAdapter = interface(JObject)
    ['{97D5EC81-ED8E-4BC8-8176-8918C46D6D61}']
    function areAllItemsEnabled: Boolean; cdecl;
    function getDropDownView(position: Integer; convertView: JView; parent: JViewGroup): JView; cdecl;
    function getItemViewType(position: Integer): Integer; cdecl;
    function getViewTypeCount: Integer; cdecl;
    function hasStableIds: Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function isEnabled(position: Integer): Boolean; cdecl;
    procedure notifyDataSetChanged; cdecl;
    procedure notifyDataSetInvalidated; cdecl;
    procedure registerDataSetObserver(observer: JDataSetObserver); cdecl;
    procedure unregisterDataSetObserver(observer: JDataSetObserver); cdecl;
  end;
  TJBaseAdapter = class(TJavaGenericImport<JBaseAdapterClass, JBaseAdapter>) end;

  JTextViewClass = interface(JViewClass)
    ['{FF2B8D3E-17E8-4F9A-AEC2-B2E39AB20CDE}']
    {class} function init(context: JContext): JTextView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JTextView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JTextView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JTextView; cdecl; overload;
    {class} function getTextColor(context: JContext; attrs: JTypedArray; def: Integer): Integer; cdecl;
    {class} function getTextColors(context: JContext; attrs: JTypedArray): JColorStateList; cdecl; overload;
  end;

  [JavaSignature('android/widget/TextView')]
  JTextView = interface(JView)
    ['{45436351-10E4-41C0-ADB2-099CB38BA534}']
    procedure addTextChangedListener(watcher: JTextWatcher); cdecl;
    procedure append(text: JCharSequence); cdecl; overload;
    procedure append(text: JCharSequence; start: Integer; end_: Integer); cdecl; overload;
    procedure beginBatchEdit; cdecl;
    function bringPointIntoView(offset: Integer): Boolean; cdecl;
    procedure cancelLongPress; cdecl;
    procedure clearComposingText; cdecl;
    procedure computeScroll; cdecl;
    procedure debug(depth: Integer); cdecl;
    function didTouchFocusSelect: Boolean; cdecl;
    procedure drawableHotspotChanged(x: Single; y: Single); cdecl;
    procedure endBatchEdit; cdecl;
    function extractText(request: JExtractedTextRequest; outText: JExtractedText): Boolean; cdecl;
    procedure findViewsWithText(outViews: JArrayList; searched: JCharSequence; flags: Integer); cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getAutoLinkMask: Integer; cdecl;
    function getBaseline: Integer; cdecl;
    function getBreakStrategy: Integer; cdecl;
    function getCompoundDrawablePadding: Integer; cdecl;
    function getCompoundDrawableTintList: JColorStateList; cdecl;
    function getCompoundDrawableTintMode: JPorterDuff_Mode; cdecl;
    function getCompoundDrawables: TJavaObjectArray<JDrawable>; cdecl;
    function getCompoundDrawablesRelative: TJavaObjectArray<JDrawable>; cdecl;
    function getCompoundPaddingBottom: Integer; cdecl;
    function getCompoundPaddingEnd: Integer; cdecl;
    function getCompoundPaddingLeft: Integer; cdecl;
    function getCompoundPaddingRight: Integer; cdecl;
    function getCompoundPaddingStart: Integer; cdecl;
    function getCompoundPaddingTop: Integer; cdecl;
    function getCurrentHintTextColor: Integer; cdecl;
    function getCurrentTextColor: Integer; cdecl;
    function getCustomInsertionActionModeCallback: JActionMode_Callback; cdecl;
    function getCustomSelectionActionModeCallback: JActionMode_Callback; cdecl;
    function getEditableText: JEditable; cdecl;
    function getEllipsize: JTextUtils_TruncateAt; cdecl;
    function getError: JCharSequence; cdecl;
    function getExtendedPaddingBottom: Integer; cdecl;
    function getExtendedPaddingTop: Integer; cdecl;
    function getFilters: TJavaObjectArray<JInputFilter>; cdecl;
    procedure getFocusedRect(r: JRect); cdecl;
    function getFontFeatureSettings: JString; cdecl;
    function getFreezesText: Boolean; cdecl;
    function getGravity: Integer; cdecl;
    function getHighlightColor: Integer; cdecl;
    function getHint: JCharSequence; cdecl;
    function getHintTextColors: JColorStateList; cdecl;
    function getHyphenationFrequency: Integer; cdecl;
    function getImeActionId: Integer; cdecl;
    function getImeActionLabel: JCharSequence; cdecl;
    function getImeOptions: Integer; cdecl;
    function getIncludeFontPadding: Boolean; cdecl;
    function getInputExtras(create: Boolean): JBundle; cdecl;
    function getInputType: Integer; cdecl;
    function getKeyListener: JKeyListener; cdecl;
    function getLayout: JLayout; cdecl;
    function getLetterSpacing: Single; cdecl;
    function getLineBounds(line: Integer; bounds: JRect): Integer; cdecl;
    function getLineCount: Integer; cdecl;
    function getLineHeight: Integer; cdecl;
    function getLineSpacingExtra: Single; cdecl;
    function getLineSpacingMultiplier: Single; cdecl;
    function getLinkTextColors: JColorStateList; cdecl;
    function getLinksClickable: Boolean; cdecl;
    function getMarqueeRepeatLimit: Integer; cdecl;
    function getMaxEms: Integer; cdecl;
    function getMaxHeight: Integer; cdecl;
    function getMaxLines: Integer; cdecl;
    function getMaxWidth: Integer; cdecl;
    function getMinEms: Integer; cdecl;
    function getMinHeight: Integer; cdecl;
    function getMinLines: Integer; cdecl;
    function getMinWidth: Integer; cdecl;
    function getMovementMethod: JMovementMethod; cdecl;
    function getOffsetForPosition(x: Single; y: Single): Integer; cdecl;
    function getPaint: JTextPaint; cdecl;
    function getPaintFlags: Integer; cdecl;
    function getPrivateImeOptions: JString; cdecl;
    function getSelectionEnd: Integer; cdecl;
    function getSelectionStart: Integer; cdecl;
    function getShadowColor: Integer; cdecl;
    function getShadowDx: Single; cdecl;
    function getShadowDy: Single; cdecl;
    function getShadowRadius: Single; cdecl;
    function getShowSoftInputOnFocus: Boolean; cdecl;
    function getText: JCharSequence; cdecl;
    function getTextColors: JColorStateList; cdecl; overload;
    function getTextLocale: JLocale; cdecl;
    function getTextScaleX: Single; cdecl;
    function getTextSize: Single; cdecl;
    function getTotalPaddingBottom: Integer; cdecl;
    function getTotalPaddingEnd: Integer; cdecl;
    function getTotalPaddingLeft: Integer; cdecl;
    function getTotalPaddingRight: Integer; cdecl;
    function getTotalPaddingStart: Integer; cdecl;
    function getTotalPaddingTop: Integer; cdecl;
    function getTransformationMethod: JTransformationMethod; cdecl;
    function getTypeface: JTypeface; cdecl;
    function getUrls: TJavaObjectArray<JURLSpan>; cdecl;
    function hasOverlappingRendering: Boolean; cdecl;
    function hasSelection: Boolean; cdecl;
    procedure invalidateDrawable(drawable: JDrawable); cdecl;
    function isCursorVisible: Boolean; cdecl;
    function isInputMethodTarget: Boolean; cdecl;
    function isSuggestionsEnabled: Boolean; cdecl;
    function isTextSelectable: Boolean; cdecl;
    procedure jumpDrawablesToCurrentState; cdecl;
    function length: Integer; cdecl;
    function moveCursorToVisibleOffset: Boolean; cdecl;
    procedure onBeginBatchEdit; cdecl;
    function onCheckIsTextEditor: Boolean; cdecl;
    procedure onCommitCompletion(text: JCompletionInfo); cdecl;
    procedure onCommitCorrection(info: JCorrectionInfo); cdecl;
    function onCreateInputConnection(outAttrs: JEditorInfo): JInputConnection; cdecl;
    function onDragEvent(event: JDragEvent): Boolean; cdecl;
    procedure onEditorAction(actionCode: Integer); cdecl;
    procedure onEndBatchEdit; cdecl;
    procedure onFinishTemporaryDetach; cdecl;
    function onGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyMultiple(keyCode: Integer; repeatCount: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyPreIme(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyShortcut(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onPreDraw: Boolean; cdecl;
    function onPrivateIMECommand(action: JString; data: JBundle): Boolean; cdecl;
    procedure onProvideStructure(structure: JViewStructure); cdecl;
    procedure onRestoreInstanceState(state: JParcelable); cdecl;
    procedure onRtlPropertiesChanged(layoutDirection: Integer); cdecl;
    function onSaveInstanceState: JParcelable; cdecl;
    procedure onScreenStateChanged(screenState: Integer); cdecl;
    procedure onStartTemporaryDetach; cdecl;
    function onTextContextMenuItem(id: Integer): Boolean; cdecl;
    function onTouchEvent(event: JMotionEvent): Boolean; cdecl;
    function onTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onWindowFocusChanged(hasWindowFocus: Boolean); cdecl;
    function performLongClick: Boolean; cdecl;
    procedure removeTextChangedListener(watcher: JTextWatcher); cdecl;
    procedure setAllCaps(allCaps: Boolean); cdecl;
    procedure setAutoLinkMask(mask: Integer); cdecl;
    procedure setBreakStrategy(breakStrategy: Integer); cdecl;
    procedure setCompoundDrawablePadding(pad: Integer); cdecl;
    procedure setCompoundDrawableTintList(tint: JColorStateList); cdecl;
    procedure setCompoundDrawableTintMode(tintMode: JPorterDuff_Mode); cdecl;
    procedure setCompoundDrawables(left: JDrawable; top: JDrawable; right: JDrawable; bottom: JDrawable); cdecl;
    procedure setCompoundDrawablesRelative(start: JDrawable; top: JDrawable; end_: JDrawable; bottom: JDrawable); cdecl;
    procedure setCompoundDrawablesRelativeWithIntrinsicBounds(start: Integer; top: Integer; end_: Integer; bottom: Integer); cdecl; overload;
    procedure setCompoundDrawablesRelativeWithIntrinsicBounds(start: JDrawable; top: JDrawable; end_: JDrawable; bottom: JDrawable); cdecl; overload;
    procedure setCompoundDrawablesWithIntrinsicBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure setCompoundDrawablesWithIntrinsicBounds(left: JDrawable; top: JDrawable; right: JDrawable; bottom: JDrawable); cdecl; overload;
    procedure setCursorVisible(visible: Boolean); cdecl;
    procedure setCustomInsertionActionModeCallback(actionModeCallback: JActionMode_Callback); cdecl;
    procedure setCustomSelectionActionModeCallback(actionModeCallback: JActionMode_Callback); cdecl;
    procedure setEditableFactory(factory: JEditable_Factory); cdecl;
    procedure setElegantTextHeight(elegant: Boolean); cdecl;
    procedure setEllipsize(where: JTextUtils_TruncateAt); cdecl;
    procedure setEms(ems: Integer); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setError(error: JCharSequence); cdecl; overload;
    procedure setError(error: JCharSequence; icon: JDrawable); cdecl; overload;
    procedure setExtractedText(text: JExtractedText); cdecl;
    procedure setFilters(filters: TJavaObjectArray<JInputFilter>); cdecl;
    procedure setFontFeatureSettings(fontFeatureSettings: JString); cdecl;
    procedure setFreezesText(freezesText: Boolean); cdecl;
    procedure setGravity(gravity: Integer); cdecl;
    procedure setHeight(pixels: Integer); cdecl;
    procedure setHighlightColor(color: Integer); cdecl;
    procedure setHint(hint: JCharSequence); cdecl; overload;
    procedure setHint(resid: Integer); cdecl; overload;
    procedure setHintTextColor(color: Integer); cdecl; overload;
    procedure setHintTextColor(colors: JColorStateList); cdecl; overload;
    procedure setHorizontallyScrolling(whether: Boolean); cdecl;
    procedure setHyphenationFrequency(hyphenationFrequency: Integer); cdecl;
    procedure setImeActionLabel(label_: JCharSequence; actionId: Integer); cdecl;
    procedure setImeOptions(imeOptions: Integer); cdecl;
    procedure setIncludeFontPadding(includepad: Boolean); cdecl;
    procedure setInputExtras(xmlResId: Integer); cdecl;
    procedure setInputType(type_: Integer); cdecl;
    procedure setKeyListener(input: JKeyListener); cdecl;
    procedure setLetterSpacing(letterSpacing: Single); cdecl;
    procedure setLineSpacing(add: Single; mult: Single); cdecl;
    procedure setLines(lines: Integer); cdecl;
    procedure setLinkTextColor(color: Integer); cdecl; overload;
    procedure setLinkTextColor(colors: JColorStateList); cdecl; overload;
    procedure setLinksClickable(whether: Boolean); cdecl;
    procedure setMarqueeRepeatLimit(marqueeLimit: Integer); cdecl;
    procedure setMaxEms(maxems: Integer); cdecl;
    procedure setMaxHeight(maxHeight: Integer); cdecl;
    procedure setMaxLines(maxlines: Integer); cdecl;
    procedure setMaxWidth(maxpixels: Integer); cdecl;
    procedure setMinEms(minems: Integer); cdecl;
    procedure setMinHeight(minHeight: Integer); cdecl;
    procedure setMinLines(minlines: Integer); cdecl;
    procedure setMinWidth(minpixels: Integer); cdecl;
    procedure setMovementMethod(movement: JMovementMethod); cdecl;
    procedure setOnEditorActionListener(l: JTextView_OnEditorActionListener); cdecl;
    procedure setPadding(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setPaddingRelative(start: Integer; top: Integer; end_: Integer; bottom: Integer); cdecl;
    procedure setPaintFlags(flags: Integer); cdecl;
    procedure setPrivateImeOptions(type_: JString); cdecl;
    procedure setRawInputType(type_: Integer); cdecl;
    procedure setScroller(s: JScroller); cdecl;
    procedure setSelectAllOnFocus(selectAllOnFocus: Boolean); cdecl;
    procedure setSelected(selected: Boolean); cdecl;
    procedure setShadowLayer(radius: Single; dx: Single; dy: Single; color: Integer); cdecl;
    procedure setShowSoftInputOnFocus(show: Boolean); cdecl;
    procedure setSingleLine; cdecl; overload;
    procedure setSingleLine(singleLine: Boolean); cdecl; overload;
    procedure setSpannableFactory(factory: JSpannable_Factory); cdecl;
    procedure setText(text: JCharSequence); cdecl; overload;
    procedure setText(text: JCharSequence; type_: JTextView_BufferType); cdecl; overload;
    procedure setText(text: TJavaArray<Char>; start: Integer; len: Integer); cdecl; overload;
    procedure setText(resid: Integer); cdecl; overload;
    procedure setText(resid: Integer; type_: JTextView_BufferType); cdecl; overload;
    procedure setTextAppearance(resId: Integer); cdecl; overload;
    procedure setTextAppearance(context: JContext; resId: Integer); cdecl; overload;//Deprecated
    procedure setTextColor(color: Integer); cdecl; overload;
    procedure setTextColor(colors: JColorStateList); cdecl; overload;
    procedure setTextIsSelectable(selectable: Boolean); cdecl;
    procedure setTextKeepState(text: JCharSequence); cdecl; overload;
    procedure setTextKeepState(text: JCharSequence; type_: JTextView_BufferType); cdecl; overload;
    procedure setTextLocale(locale: JLocale); cdecl;
    procedure setTextScaleX(size: Single); cdecl;
    procedure setTextSize(size: Single); cdecl; overload;
    procedure setTextSize(unit_: Integer; size: Single); cdecl; overload;
    procedure setTransformationMethod(method: JTransformationMethod); cdecl;
    procedure setTypeface(tf: JTypeface; style: Integer); cdecl; overload;
    procedure setTypeface(tf: JTypeface); cdecl; overload;
    procedure setWidth(pixels: Integer); cdecl;
  end;
  TJTextView = class(TJavaGenericImport<JTextViewClass, JTextView>) end;

  JButtonClass = interface(JTextViewClass)
    ['{84EB5039-0F0A-420F-8AAA-1454DE4BC213}']
    {class} function init(context: JContext): JButton; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JButton; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JButton; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JButton; cdecl; overload;
  end;

  [JavaSignature('android/widget/Button')]
  JButton = interface(JTextView)
    ['{72BF0D65-7D16-4B9D-B6E7-5CAF786278CC}']
    function getAccessibilityClassName: JCharSequence; cdecl;
  end;
  TJButton = class(TJavaGenericImport<JButtonClass, JButton>) end;

  JFrameLayoutClass = interface(JViewGroupClass)
    ['{6E65B2D2-EEA5-40FA-9F02-D104EC2EABCC}']
    {class} function init(context: JContext): JFrameLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JFrameLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JFrameLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JFrameLayout; cdecl; overload;
  end;

  [JavaSignature('android/widget/FrameLayout')]
  JFrameLayout = interface(JViewGroup)
    ['{94E79213-4DDA-45B3-B896-22E5AA59C3D3}']
    function generateLayoutParams(attrs: JAttributeSet): JFrameLayout_LayoutParams; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getConsiderGoneChildrenWhenMeasuring: Boolean; cdecl;//Deprecated
    function getMeasureAllChildren: Boolean; cdecl;
    procedure setForegroundGravity(foregroundGravity: Integer); cdecl;
    procedure setMeasureAllChildren(measureAll: Boolean); cdecl;
    function shouldDelayChildPressedState: Boolean; cdecl;
  end;
  TJFrameLayout = class(TJavaGenericImport<JFrameLayoutClass, JFrameLayout>) end;

  JCalendarViewClass = interface(JFrameLayoutClass)
    ['{296A6CD9-C5FB-4267-8E0A-FE5E3D63984F}']
    {class} function init(context: JContext): JCalendarView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JCalendarView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JCalendarView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JCalendarView; cdecl; overload;
  end;

  [JavaSignature('android/widget/CalendarView')]
  JCalendarView = interface(JFrameLayout)
    ['{EC25F4BA-2D6E-4641-9C00-CEBFE6C66BA8}']
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getDate: Int64; cdecl;
    function getDateTextAppearance: Integer; cdecl;
    function getFirstDayOfWeek: Integer; cdecl;
    function getFocusedMonthDateColor: Integer; cdecl;//Deprecated
    function getMaxDate: Int64; cdecl;
    function getMinDate: Int64; cdecl;
    function getSelectedDateVerticalBar: JDrawable; cdecl;//Deprecated
    function getSelectedWeekBackgroundColor: Integer; cdecl;//Deprecated
    function getShowWeekNumber: Boolean; cdecl;
    function getShownWeekCount: Integer; cdecl;//Deprecated
    function getUnfocusedMonthDateColor: Integer; cdecl;//Deprecated
    function getWeekDayTextAppearance: Integer; cdecl;
    function getWeekNumberColor: Integer; cdecl;//Deprecated
    function getWeekSeparatorLineColor: Integer; cdecl;//Deprecated
    procedure setDate(date: Int64); cdecl; overload;
    procedure setDate(date: Int64; animate: Boolean; center: Boolean); cdecl; overload;
    procedure setDateTextAppearance(resourceId: Integer); cdecl;
    procedure setFirstDayOfWeek(firstDayOfWeek: Integer); cdecl;
    procedure setFocusedMonthDateColor(color: Integer); cdecl;//Deprecated
    procedure setMaxDate(maxDate: Int64); cdecl;
    procedure setMinDate(minDate: Int64); cdecl;
    procedure setOnDateChangeListener(listener: JCalendarView_OnDateChangeListener); cdecl;
    procedure setSelectedDateVerticalBar(resourceId: Integer); cdecl; overload;//Deprecated
    procedure setSelectedDateVerticalBar(drawable: JDrawable); cdecl; overload;//Deprecated
    procedure setSelectedWeekBackgroundColor(color: Integer); cdecl;//Deprecated
    procedure setShowWeekNumber(showWeekNumber: Boolean); cdecl;
    procedure setShownWeekCount(count: Integer); cdecl;//Deprecated
    procedure setUnfocusedMonthDateColor(color: Integer); cdecl;//Deprecated
    procedure setWeekDayTextAppearance(resourceId: Integer); cdecl;
    procedure setWeekNumberColor(color: Integer); cdecl;//Deprecated
    procedure setWeekSeparatorLineColor(color: Integer); cdecl;//Deprecated
  end;
  TJCalendarView = class(TJavaGenericImport<JCalendarViewClass, JCalendarView>) end;

  JCalendarView_OnDateChangeListenerClass = interface(IJavaClass)
    ['{1A59348E-9069-4AC0-993A-0621FE1AF5DE}']
  end;

  [JavaSignature('android/widget/CalendarView$OnDateChangeListener')]
  JCalendarView_OnDateChangeListener = interface(IJavaInstance)
    ['{8BFCE3F3-F4AF-4758-A036-7C63196D41A4}']
    procedure onSelectedDayChange(view: JCalendarView; year: Integer; month: Integer; dayOfMonth: Integer); cdecl;
  end;
  TJCalendarView_OnDateChangeListener = class(TJavaGenericImport<JCalendarView_OnDateChangeListenerClass, JCalendarView_OnDateChangeListener>) end;

  JDatePickerClass = interface(JFrameLayoutClass)
    ['{1896B41D-1252-4F3F-BDE6-0D510F6DF7E1}']
    {class} function init(context: JContext): JDatePicker; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JDatePicker; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JDatePicker; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JDatePicker; cdecl; overload;
  end;

  [JavaSignature('android/widget/DatePicker')]
  JDatePicker = interface(JFrameLayout)
    ['{C7B0DF58-E364-4312-A6AC-15B036CEE969}']
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getCalendarView: JCalendarView; cdecl;
    function getCalendarViewShown: Boolean; cdecl;
    function getDayOfMonth: Integer; cdecl;
    function getFirstDayOfWeek: Integer; cdecl;
    function getMaxDate: Int64; cdecl;
    function getMinDate: Int64; cdecl;
    function getMonth: Integer; cdecl;
    function getSpinnersShown: Boolean; cdecl;
    function getYear: Integer; cdecl;
    procedure init(year: Integer; monthOfYear: Integer; dayOfMonth: Integer; onDateChangedListener: JDatePicker_OnDateChangedListener); cdecl; overload;
    function isEnabled: Boolean; cdecl;
    procedure setCalendarViewShown(shown: Boolean); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setFirstDayOfWeek(firstDayOfWeek: Integer); cdecl;
    procedure setMaxDate(maxDate: Int64); cdecl;
    procedure setMinDate(minDate: Int64); cdecl;
    procedure setSpinnersShown(shown: Boolean); cdecl;
    procedure updateDate(year: Integer; month: Integer; dayOfMonth: Integer); cdecl;
  end;
  TJDatePicker = class(TJavaGenericImport<JDatePickerClass, JDatePicker>) end;

  JDatePicker_OnDateChangedListenerClass = interface(IJavaClass)
    ['{1D607822-DB13-4D3A-987A-1142465633A3}']
  end;

  [JavaSignature('android/widget/DatePicker$OnDateChangedListener')]
  JDatePicker_OnDateChangedListener = interface(IJavaInstance)
    ['{33E320F2-69E9-4349-8B66-FA8C424FFB03}']
    procedure onDateChanged(view: JDatePicker; year: Integer; monthOfYear: Integer; dayOfMonth: Integer); cdecl;
  end;
  TJDatePicker_OnDateChangedListener = class(TJavaGenericImport<JDatePicker_OnDateChangedListenerClass, JDatePicker_OnDateChangedListener>) end;

  JEditTextClass = interface(JTextViewClass)
    ['{A1E1255C-8FC9-449A-A886-57ABA315C3E3}']
    {class} function init(context: JContext): JEditText; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JEditText; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JEditText; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JEditText; cdecl; overload;
  end;

  [JavaSignature('android/widget/EditText')]
  JEditText = interface(JTextView)
    ['{53E7BC41-9ED8-4863-B9A3-B8D23DA1794F}']
    procedure extendSelection(index: Integer); cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getText: JEditable; cdecl;
    procedure selectAll; cdecl;
    procedure setEllipsize(ellipsis: JTextUtils_TruncateAt); cdecl;
    procedure setSelection(start: Integer; stop: Integer); cdecl; overload;
    procedure setSelection(index: Integer); cdecl; overload;
    procedure setText(text: JCharSequence; type_: JTextView_BufferType); cdecl;
  end;
  TJEditText = class(TJavaGenericImport<JEditTextClass, JEditText>) end;

  JFrameLayout_LayoutParamsClass = interface(JViewGroup_MarginLayoutParamsClass)
    ['{F5F1E63E-8329-4F5C-8096-D369E2650637}']
    {class} function init(c: JContext; attrs: JAttributeSet): JFrameLayout_LayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer): JFrameLayout_LayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer; gravity: Integer): JFrameLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_LayoutParams): JFrameLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_MarginLayoutParams): JFrameLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JFrameLayout_LayoutParams): JFrameLayout_LayoutParams; cdecl; overload;
  end;

  [JavaSignature('android/widget/FrameLayout$LayoutParams')]
  JFrameLayout_LayoutParams = interface(JViewGroup_MarginLayoutParams)
    ['{01468B94-1F5E-4E57-990C-909B89476072}']
    function _Getgravity: Integer; cdecl;
    procedure _Setgravity(Value: Integer); cdecl;
    property gravity: Integer read _Getgravity write _Setgravity;
  end;
  TJFrameLayout_LayoutParams = class(TJavaGenericImport<JFrameLayout_LayoutParamsClass, JFrameLayout_LayoutParams>) end;

  JImageViewClass = interface(JViewClass)
    ['{0BBBCB19-E4B1-4147-99A8-9DA0AEEEA7AD}']
    {class} function init(context: JContext): JImageView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JImageView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JImageView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JImageView; cdecl; overload;
  end;

  [JavaSignature('android/widget/ImageView')]
  JImageView = interface(JView)
    ['{21CA0CF7-F857-4E53-9E2B-A12903F4216E}']
    procedure clearColorFilter; cdecl;
    procedure drawableHotspotChanged(x: Single; y: Single); cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getAdjustViewBounds: Boolean; cdecl;
    function getBaseline: Integer; cdecl;
    function getBaselineAlignBottom: Boolean; cdecl;
    function getColorFilter: JColorFilter; cdecl;
    function getCropToPadding: Boolean; cdecl;
    function getDrawable: JDrawable; cdecl;
    function getImageAlpha: Integer; cdecl;
    function getImageMatrix: JMatrix; cdecl;
    function getImageTintList: JColorStateList; cdecl;
    function getImageTintMode: JPorterDuff_Mode; cdecl;
    function getMaxHeight: Integer; cdecl;
    function getMaxWidth: Integer; cdecl;
    function getScaleType: JImageView_ScaleType; cdecl;
    function hasOverlappingRendering: Boolean; cdecl;
    procedure invalidateDrawable(dr: JDrawable); cdecl;
    function isOpaque: Boolean; cdecl;
    procedure jumpDrawablesToCurrentState; cdecl;
    function onCreateDrawableState(extraSpace: Integer): TJavaArray<Integer>; cdecl;
    procedure onRtlPropertiesChanged(layoutDirection: Integer); cdecl;
    procedure setAdjustViewBounds(adjustViewBounds: Boolean); cdecl;
    procedure setAlpha(alpha: Integer); cdecl;//Deprecated
    procedure setBaseline(baseline: Integer); cdecl;
    procedure setBaselineAlignBottom(aligned: Boolean); cdecl;
    procedure setColorFilter(color: Integer; mode: JPorterDuff_Mode); cdecl; overload;
    procedure setColorFilter(color: Integer); cdecl; overload;
    procedure setColorFilter(cf: JColorFilter); cdecl; overload;
    procedure setCropToPadding(cropToPadding: Boolean); cdecl;
    procedure setImageAlpha(alpha: Integer); cdecl;
    procedure setImageBitmap(bm: JBitmap); cdecl;
    procedure setImageDrawable(drawable: JDrawable); cdecl;
    procedure setImageIcon(icon: JIcon); cdecl;
    procedure setImageLevel(level: Integer); cdecl;
    procedure setImageMatrix(matrix: JMatrix); cdecl;
    procedure setImageResource(resId: Integer); cdecl;
    procedure setImageState(state: TJavaArray<Integer>; merge: Boolean); cdecl;
    procedure setImageTintList(tint: JColorStateList); cdecl;
    procedure setImageTintMode(tintMode: JPorterDuff_Mode); cdecl;
    procedure setImageURI(uri: Jnet_Uri); cdecl;
    procedure setMaxHeight(maxHeight: Integer); cdecl;
    procedure setMaxWidth(maxWidth: Integer); cdecl;
    procedure setScaleType(scaleType: JImageView_ScaleType); cdecl;
    procedure setSelected(selected: Boolean); cdecl;
    procedure setVisibility(visibility: Integer); cdecl;
  end;
  TJImageView = class(TJavaGenericImport<JImageViewClass, JImageView>) end;

  JImageView_ScaleTypeClass = interface(JEnumClass)
    ['{37CB0769-42AF-482A-BC66-8B9D10398D26}']
    {class} function _GetCENTER: JImageView_ScaleType; cdecl;
    {class} function _GetCENTER_CROP: JImageView_ScaleType; cdecl;
    {class} function _GetCENTER_INSIDE: JImageView_ScaleType; cdecl;
    {class} function _GetFIT_CENTER: JImageView_ScaleType; cdecl;
    {class} function _GetFIT_END: JImageView_ScaleType; cdecl;
    {class} function _GetFIT_START: JImageView_ScaleType; cdecl;
    {class} function _GetFIT_XY: JImageView_ScaleType; cdecl;
    {class} function _GetMATRIX: JImageView_ScaleType; cdecl;
    {class} function valueOf(name: JString): JImageView_ScaleType; cdecl;
    {class} function values: TJavaObjectArray<JImageView_ScaleType>; cdecl;
    {class} property CENTER: JImageView_ScaleType read _GetCENTER;
    {class} property CENTER_CROP: JImageView_ScaleType read _GetCENTER_CROP;
    {class} property CENTER_INSIDE: JImageView_ScaleType read _GetCENTER_INSIDE;
    {class} property FIT_CENTER: JImageView_ScaleType read _GetFIT_CENTER;
    {class} property FIT_END: JImageView_ScaleType read _GetFIT_END;
    {class} property FIT_START: JImageView_ScaleType read _GetFIT_START;
    {class} property FIT_XY: JImageView_ScaleType read _GetFIT_XY;
    {class} property MATRIX: JImageView_ScaleType read _GetMATRIX;
  end;

  [JavaSignature('android/widget/ImageView$ScaleType')]
  JImageView_ScaleType = interface(JEnum)
    ['{A1D4F79C-D43B-4158-B200-826C032F62A1}']
  end;
  TJImageView_ScaleType = class(TJavaGenericImport<JImageView_ScaleTypeClass, JImageView_ScaleType>) end;

  JLinearLayoutClass = interface(JViewGroupClass)
    ['{EAEAF7E9-98CA-403B-A2E4-2AA56B0A3E1F}']
    {class} function _GetHORIZONTAL: Integer; cdecl;
    {class} function _GetSHOW_DIVIDER_BEGINNING: Integer; cdecl;
    {class} function _GetSHOW_DIVIDER_END: Integer; cdecl;
    {class} function _GetSHOW_DIVIDER_MIDDLE: Integer; cdecl;
    {class} function _GetSHOW_DIVIDER_NONE: Integer; cdecl;
    {class} function _GetVERTICAL: Integer; cdecl;
    {class} function init(context: JContext): JLinearLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JLinearLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JLinearLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JLinearLayout; cdecl; overload;
    {class} property HORIZONTAL: Integer read _GetHORIZONTAL;
    {class} property SHOW_DIVIDER_BEGINNING: Integer read _GetSHOW_DIVIDER_BEGINNING;
    {class} property SHOW_DIVIDER_END: Integer read _GetSHOW_DIVIDER_END;
    {class} property SHOW_DIVIDER_MIDDLE: Integer read _GetSHOW_DIVIDER_MIDDLE;
    {class} property SHOW_DIVIDER_NONE: Integer read _GetSHOW_DIVIDER_NONE;
    {class} property VERTICAL: Integer read _GetVERTICAL;
  end;

  [JavaSignature('android/widget/LinearLayout')]
  JLinearLayout = interface(JViewGroup)
    ['{903D0B13-CCC1-4012-B4A8-C24B6013F07F}']
    function generateLayoutParams(attrs: JAttributeSet): JLinearLayout_LayoutParams; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getBaseline: Integer; cdecl;
    function getBaselineAlignedChildIndex: Integer; cdecl;
    function getDividerDrawable: JDrawable; cdecl;
    function getDividerPadding: Integer; cdecl;
    function getOrientation: Integer; cdecl;
    function getShowDividers: Integer; cdecl;
    function getWeightSum: Single; cdecl;
    function isBaselineAligned: Boolean; cdecl;
    function isMeasureWithLargestChildEnabled: Boolean; cdecl;
    procedure onRtlPropertiesChanged(layoutDirection: Integer); cdecl;
    procedure setBaselineAligned(baselineAligned: Boolean); cdecl;
    procedure setBaselineAlignedChildIndex(i: Integer); cdecl;
    procedure setDividerDrawable(divider: JDrawable); cdecl;
    procedure setDividerPadding(padding: Integer); cdecl;
    procedure setGravity(gravity: Integer); cdecl;
    procedure setHorizontalGravity(horizontalGravity: Integer); cdecl;
    procedure setMeasureWithLargestChildEnabled(enabled: Boolean); cdecl;
    procedure setOrientation(orientation: Integer); cdecl;
    procedure setShowDividers(showDividers: Integer); cdecl;
    procedure setVerticalGravity(verticalGravity: Integer); cdecl;
    procedure setWeightSum(weightSum: Single); cdecl;
    function shouldDelayChildPressedState: Boolean; cdecl;
  end;
  TJLinearLayout = class(TJavaGenericImport<JLinearLayoutClass, JLinearLayout>) end;

  JLinearLayout_LayoutParamsClass = interface(JViewGroup_MarginLayoutParamsClass)
    ['{F97E1053-9B59-4F9E-AB20-FFAE01213E75}']
    {class} function init(c: JContext; attrs: JAttributeSet): JLinearLayout_LayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer): JLinearLayout_LayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer; weight: Single): JLinearLayout_LayoutParams; cdecl; overload;
    {class} function init(p: JViewGroup_LayoutParams): JLinearLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_MarginLayoutParams): JLinearLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JLinearLayout_LayoutParams): JLinearLayout_LayoutParams; cdecl; overload;
  end;

  [JavaSignature('android/widget/LinearLayout$LayoutParams')]
  JLinearLayout_LayoutParams = interface(JViewGroup_MarginLayoutParams)
    ['{D53D211C-BCB8-4B84-9F82-BBCAC65549F7}']
    function _Getgravity: Integer; cdecl;
    procedure _Setgravity(Value: Integer); cdecl;
    function _Getweight: Single; cdecl;
    procedure _Setweight(Value: Single); cdecl;
    function debug(output: JString): JString; cdecl;
    property gravity: Integer read _Getgravity write _Setgravity;
    property weight: Single read _Getweight write _Setweight;
  end;
  TJLinearLayout_LayoutParams = class(TJavaGenericImport<JLinearLayout_LayoutParamsClass, JLinearLayout_LayoutParams>) end;

  JListAdapterClass = interface(JAdapterClass)
    ['{C631AA3D-E166-4F53-8B50-A801AD94FB9C}']
  end;

  [JavaSignature('android/widget/ListAdapter')]
  JListAdapter = interface(JAdapter)
    ['{F7DEDFB9-6976-4AFF-9264-02AEC6317A7B}']
    function areAllItemsEnabled: Boolean; cdecl;
    function isEnabled(position: Integer): Boolean; cdecl;
  end;
  TJListAdapter = class(TJavaGenericImport<JListAdapterClass, JListAdapter>) end;

  JListViewClass = interface(JAbsListViewClass)
    ['{64E52E74-CA76-451C-83EA-2A6C996C3E42}']
    {class} function init(context: JContext): JListView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JListView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JListView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JListView; cdecl; overload;
  end;

  [JavaSignature('android/widget/ListView')]
  JListView = interface(JAbsListView)
    ['{2F533089-9B07-456B-9CCD-E37633BC3E9B}']
    procedure addFooterView(v: JView; data: JObject; isSelectable: Boolean); cdecl; overload;
    procedure addFooterView(v: JView); cdecl; overload;
    procedure addHeaderView(v: JView; data: JObject; isSelectable: Boolean); cdecl; overload;
    procedure addHeaderView(v: JView); cdecl; overload;
    function areFooterDividersEnabled: Boolean; cdecl;
    function areHeaderDividersEnabled: Boolean; cdecl;
    function dispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getAdapter: JListAdapter; cdecl;
    function getCheckItemIds: TJavaArray<Int64>; cdecl;//Deprecated
    function getDivider: JDrawable; cdecl;
    function getDividerHeight: Integer; cdecl;
    function getFooterViewsCount: Integer; cdecl;
    function getHeaderViewsCount: Integer; cdecl;
    function getItemsCanFocus: Boolean; cdecl;
    function getMaxScrollAmount: Integer; cdecl;
    function getOverscrollFooter: JDrawable; cdecl;
    function getOverscrollHeader: JDrawable; cdecl;
    function isOpaque: Boolean; cdecl;
    procedure onInitializeAccessibilityNodeInfoForItem(view: JView; position: Integer; info: JAccessibilityNodeInfo); cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyMultiple(keyCode: Integer; repeatCount: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function removeFooterView(v: JView): Boolean; cdecl;
    function removeHeaderView(v: JView): Boolean; cdecl;
    function requestChildRectangleOnScreen(child: JView; rect: JRect; immediate: Boolean): Boolean; cdecl;
    procedure setAdapter(adapter: JListAdapter); cdecl;
    procedure setCacheColorHint(color: Integer); cdecl;
    procedure setDivider(divider: JDrawable); cdecl;
    procedure setDividerHeight(height: Integer); cdecl;
    procedure setFooterDividersEnabled(footerDividersEnabled: Boolean); cdecl;
    procedure setHeaderDividersEnabled(headerDividersEnabled: Boolean); cdecl;
    procedure setItemsCanFocus(itemsCanFocus: Boolean); cdecl;
    procedure setOverscrollFooter(footer: JDrawable); cdecl;
    procedure setOverscrollHeader(header: JDrawable); cdecl;
    procedure setRemoteViewsAdapter(intent: JIntent); cdecl;
    procedure setSelection(position: Integer); cdecl;
    procedure setSelectionAfterHeaderView; cdecl;
    procedure smoothScrollByOffset(offset: Integer); cdecl;
    procedure smoothScrollToPosition(position: Integer); cdecl;
  end;
  TJListView = class(TJavaGenericImport<JListViewClass, JListView>) end;

  JPopupWindowClass = interface(JObjectClass)
    ['{D703BEFF-3652-475F-A780-B2B2C9F43D66}']
    {class} function _GetINPUT_METHOD_FROM_FOCUSABLE: Integer; cdecl;
    {class} function _GetINPUT_METHOD_NEEDED: Integer; cdecl;
    {class} function _GetINPUT_METHOD_NOT_NEEDED: Integer; cdecl;
    {class} function init(context: JContext): JPopupWindow; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JPopupWindow; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JPopupWindow; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JPopupWindow; cdecl; overload;
    {class} function init: JPopupWindow; cdecl; overload;
    {class} function init(contentView: JView): JPopupWindow; cdecl; overload;
    {class} function init(width: Integer; height: Integer): JPopupWindow; cdecl; overload;
    {class} function init(contentView: JView; width: Integer; height: Integer): JPopupWindow; cdecl; overload;
    {class} function init(contentView: JView; width: Integer; height: Integer; focusable: Boolean): JPopupWindow; cdecl; overload;
    {class} property INPUT_METHOD_FROM_FOCUSABLE: Integer read _GetINPUT_METHOD_FROM_FOCUSABLE;
    {class} property INPUT_METHOD_NEEDED: Integer read _GetINPUT_METHOD_NEEDED;
    {class} property INPUT_METHOD_NOT_NEEDED: Integer read _GetINPUT_METHOD_NOT_NEEDED;
  end;

  [JavaSignature('android/widget/PopupWindow')]
  JPopupWindow = interface(JObject)
    ['{5D44B452-2E94-47F4-9610-F25833488A46}']
    procedure dismiss; cdecl;
    function getAnimationStyle: Integer; cdecl;
    function getBackground: JDrawable; cdecl;
    function getContentView: JView; cdecl;
    function getElevation: Single; cdecl;
    function getHeight: Integer; cdecl;
    function getInputMethodMode: Integer; cdecl;
    function getMaxAvailableHeight(anchor: JView): Integer; cdecl; overload;
    function getMaxAvailableHeight(anchor: JView; yOffset: Integer): Integer; cdecl; overload;
    function getOverlapAnchor: Boolean; cdecl;
    function getSoftInputMode: Integer; cdecl;
    function getWidth: Integer; cdecl;
    function getWindowLayoutType: Integer; cdecl;
    function isAboveAnchor: Boolean; cdecl;
    function isAttachedInDecor: Boolean; cdecl;
    function isClippingEnabled: Boolean; cdecl;
    function isFocusable: Boolean; cdecl;
    function isOutsideTouchable: Boolean; cdecl;
    function isShowing: Boolean; cdecl;
    function isSplitTouchEnabled: Boolean; cdecl;
    function isTouchable: Boolean; cdecl;
    procedure setAnimationStyle(animationStyle: Integer); cdecl;
    procedure setAttachedInDecor(enabled: Boolean); cdecl;
    procedure setBackgroundDrawable(background: JDrawable); cdecl;
    procedure setClippingEnabled(enabled: Boolean); cdecl;
    procedure setContentView(contentView: JView); cdecl;
    procedure setElevation(elevation: Single); cdecl;
    //procedure setEnterTransition(enterTransition: JTransition); cdecl;
    //procedure setExitTransition(exitTransition: JTransition); cdecl;
    procedure setFocusable(focusable: Boolean); cdecl;
    procedure setHeight(height: Integer); cdecl;
    procedure setIgnoreCheekPress; cdecl;
    procedure setInputMethodMode(mode: Integer); cdecl;
    procedure setOnDismissListener(onDismissListener: JPopupWindow_OnDismissListener); cdecl;
    procedure setOutsideTouchable(touchable: Boolean); cdecl;
    procedure setOverlapAnchor(overlapAnchor: Boolean); cdecl;
    procedure setSoftInputMode(mode: Integer); cdecl;
    procedure setSplitTouchEnabled(enabled: Boolean); cdecl;
    procedure setTouchInterceptor(l: JView_OnTouchListener); cdecl;
    procedure setTouchable(touchable: Boolean); cdecl;
    procedure setWidth(width: Integer); cdecl;
    procedure setWindowLayoutMode(widthSpec: Integer; heightSpec: Integer); cdecl;//Deprecated
    procedure setWindowLayoutType(layoutType: Integer); cdecl;
    procedure showAsDropDown(anchor: JView); cdecl; overload;
    procedure showAsDropDown(anchor: JView; xoff: Integer; yoff: Integer); cdecl; overload;
    procedure showAsDropDown(anchor: JView; xoff: Integer; yoff: Integer; gravity: Integer); cdecl; overload;
    procedure showAtLocation(parent: JView; gravity: Integer; x: Integer; y: Integer); cdecl;
    procedure update; cdecl; overload;
    procedure update(width: Integer; height: Integer); cdecl; overload;
    procedure update(x: Integer; y: Integer; width: Integer; height: Integer); cdecl; overload;
    procedure update(x: Integer; y: Integer; width: Integer; height: Integer; force: Boolean); cdecl; overload;
    procedure update(anchor: JView; width: Integer; height: Integer); cdecl; overload;
    procedure update(anchor: JView; xoff: Integer; yoff: Integer; width: Integer; height: Integer); cdecl; overload;
  end;
  TJPopupWindow = class(TJavaGenericImport<JPopupWindowClass, JPopupWindow>) end;

  JPopupWindow_OnDismissListenerClass = interface(IJavaClass)
    ['{0D8EC9E0-1E9D-4218-B811-4D795CBDEF2D}']
  end;

  [JavaSignature('android/widget/PopupWindow$OnDismissListener')]
  JPopupWindow_OnDismissListener = interface(IJavaInstance)
    ['{C4613C55-80EE-41CB-A235-6C002B229AED}']
    procedure onDismiss; cdecl;
  end;
  TJPopupWindow_OnDismissListener = class(TJavaGenericImport<JPopupWindow_OnDismissListenerClass, JPopupWindow_OnDismissListener>) end;

  JRelativeLayoutClass = interface(JViewGroupClass)
    ['{8D562318-EFE5-4CAE-AFAA-23E36D81BA54}']
    {class} function _GetABOVE: Integer; cdecl;
    {class} function _GetALIGN_BASELINE: Integer; cdecl;
    {class} function _GetALIGN_BOTTOM: Integer; cdecl;
    {class} function _GetALIGN_END: Integer; cdecl;
    {class} function _GetALIGN_LEFT: Integer; cdecl;
    {class} function _GetALIGN_PARENT_BOTTOM: Integer; cdecl;
    {class} function _GetALIGN_PARENT_END: Integer; cdecl;
    {class} function _GetALIGN_PARENT_LEFT: Integer; cdecl;
    {class} function _GetALIGN_PARENT_RIGHT: Integer; cdecl;
    {class} function _GetALIGN_PARENT_START: Integer; cdecl;
    {class} function _GetALIGN_PARENT_TOP: Integer; cdecl;
    {class} function _GetALIGN_RIGHT: Integer; cdecl;
    {class} function _GetALIGN_START: Integer; cdecl;
    {class} function _GetALIGN_TOP: Integer; cdecl;
    {class} function _GetBELOW: Integer; cdecl;
    {class} function _GetCENTER_HORIZONTAL: Integer; cdecl;
    {class} function _GetCENTER_IN_PARENT: Integer; cdecl;
    {class} function _GetCENTER_VERTICAL: Integer; cdecl;
    {class} function _GetEND_OF: Integer; cdecl;
    {class} function _GetLEFT_OF: Integer; cdecl;
    {class} function _GetRIGHT_OF: Integer; cdecl;
    {class} function _GetSTART_OF: Integer; cdecl;
    {class} function _GetTRUE: Integer; cdecl;
    {class} function init(context: JContext): JRelativeLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JRelativeLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JRelativeLayout; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JRelativeLayout; cdecl; overload;
    {class} property ABOVE: Integer read _GetABOVE;
    {class} property ALIGN_BASELINE: Integer read _GetALIGN_BASELINE;
    {class} property ALIGN_BOTTOM: Integer read _GetALIGN_BOTTOM;
    {class} property ALIGN_END: Integer read _GetALIGN_END;
    {class} property ALIGN_LEFT: Integer read _GetALIGN_LEFT;
    {class} property ALIGN_PARENT_BOTTOM: Integer read _GetALIGN_PARENT_BOTTOM;
    {class} property ALIGN_PARENT_END: Integer read _GetALIGN_PARENT_END;
    {class} property ALIGN_PARENT_LEFT: Integer read _GetALIGN_PARENT_LEFT;
    {class} property ALIGN_PARENT_RIGHT: Integer read _GetALIGN_PARENT_RIGHT;
    {class} property ALIGN_PARENT_START: Integer read _GetALIGN_PARENT_START;
    {class} property ALIGN_PARENT_TOP: Integer read _GetALIGN_PARENT_TOP;
    {class} property ALIGN_RIGHT: Integer read _GetALIGN_RIGHT;
    {class} property ALIGN_START: Integer read _GetALIGN_START;
    {class} property ALIGN_TOP: Integer read _GetALIGN_TOP;
    {class} property BELOW: Integer read _GetBELOW;
    {class} property CENTER_HORIZONTAL: Integer read _GetCENTER_HORIZONTAL;
    {class} property CENTER_IN_PARENT: Integer read _GetCENTER_IN_PARENT;
    {class} property CENTER_VERTICAL: Integer read _GetCENTER_VERTICAL;
    {class} property END_OF: Integer read _GetEND_OF;
    {class} property LEFT_OF: Integer read _GetLEFT_OF;
    {class} property RIGHT_OF: Integer read _GetRIGHT_OF;
    {class} property START_OF: Integer read _GetSTART_OF;
    {class} property TRUE: Integer read _GetTRUE;
  end;

  [JavaSignature('android/widget/RelativeLayout')]
  JRelativeLayout = interface(JViewGroup)
    ['{6EBCD918-E863-4925-8C9F-5854948F05C2}']
    function generateLayoutParams(attrs: JAttributeSet): JRelativeLayout_LayoutParams; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getBaseline: Integer; cdecl;
    function getGravity: Integer; cdecl;
    procedure requestLayout; cdecl;
    procedure setGravity(gravity: Integer); cdecl;
    procedure setHorizontalGravity(horizontalGravity: Integer); cdecl;
    procedure setIgnoreGravity(viewId: Integer); cdecl;
    procedure setVerticalGravity(verticalGravity: Integer); cdecl;
    function shouldDelayChildPressedState: Boolean; cdecl;
  end;
  TJRelativeLayout = class(TJavaGenericImport<JRelativeLayoutClass, JRelativeLayout>) end;

  JRelativeLayout_LayoutParamsClass = interface(JViewGroup_MarginLayoutParamsClass)
    ['{869D1064-F0BF-4BBC-AB67-F3354AE7D63C}']
    {class} function init(c: JContext; attrs: JAttributeSet): JRelativeLayout_LayoutParams; cdecl; overload;
    {class} function init(w: Integer; h: Integer): JRelativeLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_LayoutParams): JRelativeLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_MarginLayoutParams): JRelativeLayout_LayoutParams; cdecl; overload;
    {class} function init(source: JRelativeLayout_LayoutParams): JRelativeLayout_LayoutParams; cdecl; overload;
  end;

  [JavaSignature('android/widget/RelativeLayout$LayoutParams')]
  JRelativeLayout_LayoutParams = interface(JViewGroup_MarginLayoutParams)
    ['{FF04C65D-4845-4AA6-B259-B32A28442D8C}']
    function _GetalignWithParent: Boolean; cdecl;
    procedure _SetalignWithParent(Value: Boolean); cdecl;
    procedure addRule(verb: Integer); cdecl; overload;
    procedure addRule(verb: Integer; anchor: Integer); cdecl; overload;
    function debug(output: JString): JString; cdecl;
    function getRule(verb: Integer): Integer; cdecl;
    function getRules: TJavaArray<Integer>; cdecl;
    procedure removeRule(verb: Integer); cdecl;
    procedure resolveLayoutDirection(layoutDirection: Integer); cdecl;
    property alignWithParent: Boolean read _GetalignWithParent write _SetalignWithParent;
  end;
  TJRelativeLayout_LayoutParams = class(TJavaGenericImport<JRelativeLayout_LayoutParamsClass, JRelativeLayout_LayoutParams>) end;

  JRemoteViewsClass = interface(JObjectClass)
    ['{5C019581-AE7F-440F-A66D-AAA4F5DBE9C2}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(packageName: JString; layoutId: Integer): JRemoteViews; cdecl; overload;
    {class} function init(landscape: JRemoteViews; portrait: JRemoteViews): JRemoteViews; cdecl; overload;
    {class} function init(parcel: JParcel): JRemoteViews; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/widget/RemoteViews')]
  JRemoteViews = interface(JObject)
    ['{C4C8FF03-5E94-4821-9401-A3DCA8A1119A}']
    procedure addView(viewId: Integer; nestedView: JRemoteViews); cdecl;
    function apply(context: JContext; parent: JViewGroup): JView; cdecl;
    function clone: JRemoteViews; cdecl;
    function describeContents: Integer; cdecl;
    function getLayoutId: Integer; cdecl;
    function getPackage: JString; cdecl;
    function onLoadClass(clazz: Jlang_Class): Boolean; cdecl;
    procedure reapply(context: JContext; v: JView); cdecl;
    procedure removeAllViews(viewId: Integer); cdecl;
    procedure setAccessibilityTraversalAfter(viewId: Integer; nextId: Integer); cdecl;
    procedure setAccessibilityTraversalBefore(viewId: Integer; nextId: Integer); cdecl;
    procedure setBitmap(viewId: Integer; methodName: JString; value: JBitmap); cdecl;
    procedure setBoolean(viewId: Integer; methodName: JString; value: Boolean); cdecl;
    procedure setBundle(viewId: Integer; methodName: JString; value: JBundle); cdecl;
    procedure setByte(viewId: Integer; methodName: JString; value: Byte); cdecl;
    procedure setChar(viewId: Integer; methodName: JString; value: Char); cdecl;
    procedure setCharSequence(viewId: Integer; methodName: JString; value: JCharSequence); cdecl;
    procedure setChronometer(viewId: Integer; base: Int64; format: JString; started: Boolean); cdecl;
    procedure setContentDescription(viewId: Integer; contentDescription: JCharSequence); cdecl;
    procedure setDisplayedChild(viewId: Integer; childIndex: Integer); cdecl;
    procedure setDouble(viewId: Integer; methodName: JString; value: Double); cdecl;
    procedure setEmptyView(viewId: Integer; emptyViewId: Integer); cdecl;
    procedure setFloat(viewId: Integer; methodName: JString; value: Single); cdecl;
    procedure setIcon(viewId: Integer; methodName: JString; value: JIcon); cdecl;
    procedure setImageViewBitmap(viewId: Integer; bitmap: JBitmap); cdecl;
    procedure setImageViewIcon(viewId: Integer; icon: JIcon); cdecl;
    procedure setImageViewResource(viewId: Integer; srcId: Integer); cdecl;
    procedure setImageViewUri(viewId: Integer; uri: Jnet_Uri); cdecl;
    procedure setInt(viewId: Integer; methodName: JString; value: Integer); cdecl;
    procedure setIntent(viewId: Integer; methodName: JString; value: JIntent); cdecl;
    procedure setLabelFor(viewId: Integer; labeledId: Integer); cdecl;
    procedure setLong(viewId: Integer; methodName: JString; value: Int64); cdecl;
    procedure setOnClickFillInIntent(viewId: Integer; fillInIntent: JIntent); cdecl;
    //procedure setOnClickPendingIntent(viewId: Integer; pendingIntent: JPendingIntent); cdecl;
    //procedure setPendingIntentTemplate(viewId: Integer; pendingIntentTemplate: JPendingIntent); cdecl;
    procedure setProgressBar(viewId: Integer; max: Integer; progress: Integer; indeterminate: Boolean); cdecl;
    procedure setRelativeScrollPosition(viewId: Integer; offset: Integer); cdecl;
    procedure setRemoteAdapter(appWidgetId: Integer; viewId: Integer; intent: JIntent); cdecl; overload;//Deprecated
    procedure setRemoteAdapter(viewId: Integer; intent: JIntent); cdecl; overload;
    procedure setScrollPosition(viewId: Integer; position: Integer); cdecl;
    procedure setShort(viewId: Integer; methodName: JString; value: SmallInt); cdecl;
    procedure setString(viewId: Integer; methodName: JString; value: JString); cdecl;
    procedure setTextColor(viewId: Integer; color: Integer); cdecl;
    procedure setTextViewCompoundDrawables(viewId: Integer; left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setTextViewCompoundDrawablesRelative(viewId: Integer; start: Integer; top: Integer; end_: Integer; bottom: Integer); cdecl;
    procedure setTextViewText(viewId: Integer; text: JCharSequence); cdecl;
    procedure setTextViewTextSize(viewId: Integer; units: Integer; size: Single); cdecl;
    procedure setUri(viewId: Integer; methodName: JString; value: Jnet_Uri); cdecl;
    procedure setViewPadding(viewId: Integer; left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setViewVisibility(viewId: Integer; visibility: Integer); cdecl;
    procedure showNext(viewId: Integer); cdecl;
    procedure showPrevious(viewId: Integer); cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJRemoteViews = class(TJavaGenericImport<JRemoteViewsClass, JRemoteViews>) end;

  JScrollViewClass = interface(JFrameLayoutClass)
    ['{ECF090FA-E2FD-4EBD-8703-621FCE93BBF3}']
    {class} function init(context: JContext): JScrollView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JScrollView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JScrollView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JScrollView; cdecl; overload;
  end;

  [JavaSignature('android/widget/ScrollView')]
  JScrollView = interface(JFrameLayout)
    ['{583976EE-6287-4A78-8B75-27D2799348D0}']
    procedure addView(child: JView); cdecl; overload;
    procedure addView(child: JView; index: Integer); cdecl; overload;
    procedure addView(child: JView; params: JViewGroup_LayoutParams); cdecl; overload;
    procedure addView(child: JView; index: Integer; params: JViewGroup_LayoutParams); cdecl; overload;
    function arrowScroll(direction: Integer): Boolean; cdecl;
    procedure computeScroll; cdecl;
    function dispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function executeKeyEvent(event: JKeyEvent): Boolean; cdecl;
    procedure fling(velocityY: Integer); cdecl;
    function fullScroll(direction: Integer): Boolean; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getMaxScrollAmount: Integer; cdecl;
    function isFillViewport: Boolean; cdecl;
    function isSmoothScrollingEnabled: Boolean; cdecl;
    function onGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    function onInterceptTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    function onNestedFling(target: JView; velocityX: Single; velocityY: Single; consumed: Boolean): Boolean; cdecl;
    procedure onNestedScroll(target: JView; dxConsumed: Integer; dyConsumed: Integer; dxUnconsumed: Integer; dyUnconsumed: Integer); cdecl;
    procedure onNestedScrollAccepted(child: JView; target: JView; axes: Integer); cdecl;
    function onStartNestedScroll(child: JView; target: JView; nestedScrollAxes: Integer): Boolean; cdecl;
    procedure onStopNestedScroll(target: JView); cdecl;
    function onTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    function pageScroll(direction: Integer): Boolean; cdecl;
    procedure requestChildFocus(child: JView; focused: JView); cdecl;
    function requestChildRectangleOnScreen(child: JView; rectangle: JRect; immediate: Boolean): Boolean; cdecl;
    procedure requestDisallowInterceptTouchEvent(disallowIntercept: Boolean); cdecl;
    procedure requestLayout; cdecl;
    procedure scrollTo(x: Integer; y: Integer); cdecl;
    procedure setFillViewport(fillViewport: Boolean); cdecl;
    procedure setOverScrollMode(mode: Integer); cdecl;
    procedure setSmoothScrollingEnabled(smoothScrollingEnabled: Boolean); cdecl;
    function shouldDelayChildPressedState: Boolean; cdecl;
    procedure smoothScrollBy(dx: Integer; dy: Integer); cdecl;
    procedure smoothScrollTo(x: Integer; y: Integer); cdecl;
  end;
  TJScrollView = class(TJavaGenericImport<JScrollViewClass, JScrollView>) end;

  JScrollerClass = interface(JObjectClass)
    ['{B6534774-81A9-4C48-BB64-97570118163B}']
    {class} function init(context: JContext): JScroller; cdecl; overload;
    {class} //function init(context: JContext; interpolator: JInterpolator): JScroller; cdecl; overload;
    {class} //function init(context: JContext; interpolator: JInterpolator; flywheel: Boolean): JScroller; cdecl; overload;
  end;

  [JavaSignature('android/widget/Scroller')]
  JScroller = interface(JObject)
    ['{35B1FBEE-2281-4808-B971-93DBCCA5E7F2}']
    procedure abortAnimation; cdecl;
    function computeScrollOffset: Boolean; cdecl;
    procedure extendDuration(extend: Integer); cdecl;
    procedure fling(startX: Integer; startY: Integer; velocityX: Integer; velocityY: Integer; minX: Integer; maxX: Integer; minY: Integer; maxY: Integer); cdecl;
    procedure forceFinished(finished: Boolean); cdecl;
    function getCurrVelocity: Single; cdecl;
    function getCurrX: Integer; cdecl;
    function getCurrY: Integer; cdecl;
    function getDuration: Integer; cdecl;
    function getFinalX: Integer; cdecl;
    function getFinalY: Integer; cdecl;
    function getStartX: Integer; cdecl;
    function getStartY: Integer; cdecl;
    function isFinished: Boolean; cdecl;
    procedure setFinalX(newX: Integer); cdecl;
    procedure setFinalY(newY: Integer); cdecl;
    procedure setFriction(friction: Single); cdecl;
    procedure startScroll(startX: Integer; startY: Integer; dx: Integer; dy: Integer); cdecl; overload;
    procedure startScroll(startX: Integer; startY: Integer; dx: Integer; dy: Integer; duration: Integer); cdecl; overload;
    function timePassed: Integer; cdecl;
  end;
  TJScroller = class(TJavaGenericImport<JScrollerClass, JScroller>) end;

  JSpinnerAdapterClass = interface(JAdapterClass)
    ['{691169DF-C0EF-4E6C-8E72-E7128AE1841B}']
  end;

  [JavaSignature('android/widget/SpinnerAdapter')]
  JSpinnerAdapter = interface(JAdapter)
    ['{68A77466-E8F0-443D-88C6-FB41DB5AB915}']
    function getDropDownView(position: Integer; convertView: JView; parent: JViewGroup): JView; cdecl;
  end;
  TJSpinnerAdapter = class(TJavaGenericImport<JSpinnerAdapterClass, JSpinnerAdapter>) end;

  JTextView_BufferTypeClass = interface(JEnumClass)
    ['{7275F65A-D22F-4DB7-8B68-C7607AFCB6DC}']
    {class} function _GetEDITABLE: JTextView_BufferType; cdecl;
    {class} function _GetNORMAL: JTextView_BufferType; cdecl;
    {class} function _GetSPANNABLE: JTextView_BufferType; cdecl;
    {class} function valueOf(name: JString): JTextView_BufferType; cdecl;
    {class} function values: TJavaObjectArray<JTextView_BufferType>; cdecl;
    {class} property EDITABLE: JTextView_BufferType read _GetEDITABLE;
    {class} property NORMAL: JTextView_BufferType read _GetNORMAL;
    {class} property SPANNABLE: JTextView_BufferType read _GetSPANNABLE;
  end;

  [JavaSignature('android/widget/TextView$BufferType')]
  JTextView_BufferType = interface(JEnum)
    ['{059F9BC3-E477-4961-B36D-8BEB7170D0F5}']
  end;
  TJTextView_BufferType = class(TJavaGenericImport<JTextView_BufferTypeClass, JTextView_BufferType>) end;

  JTextView_OnEditorActionListenerClass = interface(IJavaClass)
    ['{F1975C99-6495-441B-AE06-1BF3187DCCC8}']
  end;

  [JavaSignature('android/widget/TextView$OnEditorActionListener')]
  JTextView_OnEditorActionListener = interface(IJavaInstance)
    ['{6E2FAEE9-92A5-4592-B040-72632B17DA08}']
    function onEditorAction(v: JTextView; actionId: Integer; event: JKeyEvent): Boolean; cdecl;
  end;
  TJTextView_OnEditorActionListener = class(TJavaGenericImport<JTextView_OnEditorActionListenerClass, JTextView_OnEditorActionListener>) end;

  JTimePickerClass = interface(JFrameLayoutClass)
    ['{3061352E-39CC-4614-BF94-C3856A4ECA05}']
    {class} function init(context: JContext): JTimePicker; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JTimePicker; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JTimePicker; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JTimePicker; cdecl; overload;
  end;

  [JavaSignature('android/widget/TimePicker')]
  JTimePicker = interface(JFrameLayout)
    ['{BC21C49B-9018-4962-93F6-7D8FC5E254F5}']
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getBaseline: Integer; cdecl;
    function getCurrentHour: JInteger; cdecl;//Deprecated
    function getCurrentMinute: JInteger; cdecl;//Deprecated
    function getHour: Integer; cdecl;
    function getMinute: Integer; cdecl;
    function is24HourView: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    procedure setCurrentHour(currentHour: JInteger); cdecl;//Deprecated
    procedure setCurrentMinute(currentMinute: JInteger); cdecl;//Deprecated
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setHour(hour: Integer); cdecl;
    procedure setIs24HourView(is24HourView: JBoolean); cdecl;
    procedure setMinute(minute: Integer); cdecl;
    procedure setOnTimeChangedListener(onTimeChangedListener: JTimePicker_OnTimeChangedListener); cdecl;
  end;
  TJTimePicker = class(TJavaGenericImport<JTimePickerClass, JTimePicker>) end;

  JTimePicker_OnTimeChangedListenerClass = interface(IJavaClass)
    ['{72F8448B-20CE-4BE8-9B35-B4F2C0677091}']
  end;

  [JavaSignature('android/widget/TimePicker$OnTimeChangedListener')]
  JTimePicker_OnTimeChangedListener = interface(IJavaInstance)
    ['{201D381C-01E8-4104-BE53-7DD32EB514C7}']
    procedure onTimeChanged(view: JTimePicker; hourOfDay: Integer; minute: Integer); cdecl;
  end;
  TJTimePicker_OnTimeChangedListener = class(TJavaGenericImport<JTimePicker_OnTimeChangedListenerClass, JTimePicker_OnTimeChangedListener>) end;

  JToastClass = interface(JObjectClass)
    ['{D06A7EAF-EE60-4F55-A3EA-E7B0B37EC7CB}']
    {class} function _GetLENGTH_LONG: Integer; cdecl;
    {class} function _GetLENGTH_SHORT: Integer; cdecl;
    {class} function init(context: JContext): JToast; cdecl;
    {class} function makeText(context: JContext; text: JCharSequence; duration: Integer): JToast; cdecl; overload;
    {class} function makeText(context: JContext; resId: Integer; duration: Integer): JToast; cdecl; overload;
    {class} property LENGTH_LONG: Integer read _GetLENGTH_LONG;
    {class} property LENGTH_SHORT: Integer read _GetLENGTH_SHORT;
  end;

  [JavaSignature('android/widget/Toast')]
  JToast = interface(JObject)
    ['{410DDA5F-7D4B-415E-8BE4-F545D331176C}']
    procedure cancel; cdecl;
    function getDuration: Integer; cdecl;
    function getGravity: Integer; cdecl;
    function getHorizontalMargin: Single; cdecl;
    function getVerticalMargin: Single; cdecl;
    function getView: JView; cdecl;
    function getXOffset: Integer; cdecl;
    function getYOffset: Integer; cdecl;
    procedure setDuration(duration: Integer); cdecl;
    procedure setGravity(gravity: Integer; xOffset: Integer; yOffset: Integer); cdecl;
    procedure setMargin(horizontalMargin: Single; verticalMargin: Single); cdecl;
    procedure setText(resId: Integer); cdecl; overload;
    procedure setText(s: JCharSequence); cdecl; overload;
    procedure setView(view: JView); cdecl;
    procedure show; cdecl;
  end;
  TJToast = class(TJavaGenericImport<JToastClass, JToast>) end;

  JToolbarClass = interface(JViewGroupClass)
    ['{1CB20DE3-2F6E-42CC-8FC8-BB5E27FFF510}']
    {class} function init(context: JContext): JToolbar; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JToolbar; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JToolbar; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JToolbar; cdecl; overload;
  end;

  [JavaSignature('android/widget/Toolbar')]
  JToolbar = interface(JViewGroup)
    ['{D338BDF9-DC9C-4325-A04D-642A6D7F4FBC}']
    procedure collapseActionView; cdecl;
    procedure dismissPopupMenus; cdecl;
    //function generateLayoutParams(attrs: JAttributeSet): JToolbar_LayoutParams; cdecl;
    function getContentInsetEnd: Integer; cdecl;
    function getContentInsetLeft: Integer; cdecl;
    function getContentInsetRight: Integer; cdecl;
    function getContentInsetStart: Integer; cdecl;
    function getLogo: JDrawable; cdecl;
    function getLogoDescription: JCharSequence; cdecl;
    function getMenu: JMenu; cdecl;
    function getNavigationContentDescription: JCharSequence; cdecl;
    function getNavigationIcon: JDrawable; cdecl;
    function getOverflowIcon: JDrawable; cdecl;
    function getPopupTheme: Integer; cdecl;
    function getSubtitle: JCharSequence; cdecl;
    function getTitle: JCharSequence; cdecl;
    function hasExpandedActionView: Boolean; cdecl;
    function hideOverflowMenu: Boolean; cdecl;
    procedure inflateMenu(resId: Integer); cdecl;
    function isOverflowMenuShowing: Boolean; cdecl;
    procedure onRtlPropertiesChanged(layoutDirection: Integer); cdecl;
    function onTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    procedure setContentInsetsAbsolute(contentInsetLeft: Integer; contentInsetRight: Integer); cdecl;
    procedure setContentInsetsRelative(contentInsetStart: Integer; contentInsetEnd: Integer); cdecl;
    procedure setLogo(resId: Integer); cdecl; overload;
    procedure setLogo(drawable: JDrawable); cdecl; overload;
    procedure setLogoDescription(resId: Integer); cdecl; overload;
    procedure setLogoDescription(description: JCharSequence); cdecl; overload;
    procedure setNavigationContentDescription(resId: Integer); cdecl; overload;
    procedure setNavigationContentDescription(description: JCharSequence); cdecl; overload;
    procedure setNavigationIcon(resId: Integer); cdecl; overload;
    procedure setNavigationIcon(icon: JDrawable); cdecl; overload;
    procedure setNavigationOnClickListener(listener: JView_OnClickListener); cdecl;
    procedure setOnMenuItemClickListener(listener: JToolbar_OnMenuItemClickListener); cdecl;
    procedure setOverflowIcon(icon: JDrawable); cdecl;
    procedure setPopupTheme(resId: Integer); cdecl;
    procedure setSubtitle(resId: Integer); cdecl; overload;
    procedure setSubtitle(subtitle: JCharSequence); cdecl; overload;
    procedure setSubtitleTextAppearance(context: JContext; resId: Integer); cdecl;
    procedure setSubtitleTextColor(color: Integer); cdecl;
    procedure setTitle(resId: Integer); cdecl; overload;
    procedure setTitle(title: JCharSequence); cdecl; overload;
    procedure setTitleTextAppearance(context: JContext; resId: Integer); cdecl;
    procedure setTitleTextColor(color: Integer); cdecl;
    function showOverflowMenu: Boolean; cdecl;
  end;
  TJToolbar = class(TJavaGenericImport<JToolbarClass, JToolbar>) end;

  // android.widget.Toolbar$LayoutParams
  JToolbar_OnMenuItemClickListenerClass = interface(IJavaClass)
    ['{906D5CB5-5B59-455F-82B3-023A7610849F}']
  end;

  [JavaSignature('android/widget/Toolbar$OnMenuItemClickListener')]
  JToolbar_OnMenuItemClickListener = interface(IJavaInstance)
    ['{B997AA5D-5096-46A3-9194-5196C1A74673}']
    function onMenuItemClick(item: JMenuItem): Boolean; cdecl;
  end;
  TJToolbar_OnMenuItemClickListener = class(TJavaGenericImport<JToolbar_OnMenuItemClickListenerClass, JToolbar_OnMenuItemClickListener>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAdapterView', TypeInfo(Androidapi.JNI.Widget.JAdapterView));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAbsListView', TypeInfo(Androidapi.JNI.Widget.JAbsListView));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAbsListView_LayoutParams', TypeInfo(Androidapi.JNI.Widget.JAbsListView_LayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAbsListView_MultiChoiceModeListener', TypeInfo(Androidapi.JNI.Widget.JAbsListView_MultiChoiceModeListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAbsListView_OnScrollListener', TypeInfo(Androidapi.JNI.Widget.JAbsListView_OnScrollListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAbsListView_RecyclerListener', TypeInfo(Androidapi.JNI.Widget.JAbsListView_RecyclerListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAbsoluteLayout', TypeInfo(Androidapi.JNI.Widget.JAbsoluteLayout));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAdapter', TypeInfo(Androidapi.JNI.Widget.JAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAdapterView_OnItemClickListener', TypeInfo(Androidapi.JNI.Widget.JAdapterView_OnItemClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAdapterView_OnItemLongClickListener', TypeInfo(Androidapi.JNI.Widget.JAdapterView_OnItemLongClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JAdapterView_OnItemSelectedListener', TypeInfo(Androidapi.JNI.Widget.JAdapterView_OnItemSelectedListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JBaseAdapter', TypeInfo(Androidapi.JNI.Widget.JBaseAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JTextView', TypeInfo(Androidapi.JNI.Widget.JTextView));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JButton', TypeInfo(Androidapi.JNI.Widget.JButton));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JFrameLayout', TypeInfo(Androidapi.JNI.Widget.JFrameLayout));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JCalendarView', TypeInfo(Androidapi.JNI.Widget.JCalendarView));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JCalendarView_OnDateChangeListener', TypeInfo(Androidapi.JNI.Widget.JCalendarView_OnDateChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JDatePicker', TypeInfo(Androidapi.JNI.Widget.JDatePicker));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JDatePicker_OnDateChangedListener', TypeInfo(Androidapi.JNI.Widget.JDatePicker_OnDateChangedListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JEditText', TypeInfo(Androidapi.JNI.Widget.JEditText));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JFrameLayout_LayoutParams', TypeInfo(Androidapi.JNI.Widget.JFrameLayout_LayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JImageView', TypeInfo(Androidapi.JNI.Widget.JImageView));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JImageView_ScaleType', TypeInfo(Androidapi.JNI.Widget.JImageView_ScaleType));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JLinearLayout', TypeInfo(Androidapi.JNI.Widget.JLinearLayout));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JLinearLayout_LayoutParams', TypeInfo(Androidapi.JNI.Widget.JLinearLayout_LayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JListAdapter', TypeInfo(Androidapi.JNI.Widget.JListAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JListView', TypeInfo(Androidapi.JNI.Widget.JListView));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JPopupWindow', TypeInfo(Androidapi.JNI.Widget.JPopupWindow));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JPopupWindow_OnDismissListener', TypeInfo(Androidapi.JNI.Widget.JPopupWindow_OnDismissListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JRelativeLayout', TypeInfo(Androidapi.JNI.Widget.JRelativeLayout));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JRelativeLayout_LayoutParams', TypeInfo(Androidapi.JNI.Widget.JRelativeLayout_LayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JRemoteViews', TypeInfo(Androidapi.JNI.Widget.JRemoteViews));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JScrollView', TypeInfo(Androidapi.JNI.Widget.JScrollView));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JScroller', TypeInfo(Androidapi.JNI.Widget.JScroller));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JSpinnerAdapter', TypeInfo(Androidapi.JNI.Widget.JSpinnerAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JTextView_BufferType', TypeInfo(Androidapi.JNI.Widget.JTextView_BufferType));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JTextView_OnEditorActionListener', TypeInfo(Androidapi.JNI.Widget.JTextView_OnEditorActionListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JTimePicker', TypeInfo(Androidapi.JNI.Widget.JTimePicker));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JTimePicker_OnTimeChangedListener', TypeInfo(Androidapi.JNI.Widget.JTimePicker_OnTimeChangedListener));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JToast', TypeInfo(Androidapi.JNI.Widget.JToast));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JToolbar', TypeInfo(Androidapi.JNI.Widget.JToolbar));
  //TRegTypes.RegisterType('Androidapi.JNI.Widget.JToolbar_LayoutParams', TypeInfo(Androidapi.JNI.Widget.JToolbar_LayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.Widget.JToolbar_OnMenuItemClickListener', TypeInfo(Androidapi.JNI.Widget.JToolbar_OnMenuItemClickListener));
end;

initialization
  RegisterTypes;
end.


