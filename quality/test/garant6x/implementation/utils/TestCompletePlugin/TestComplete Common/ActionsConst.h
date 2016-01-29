// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================

// 
// NOTE: Keep this file synchronized with ActionConsts.pas
//

#pragma once

#define NULL_CONTEXT GUID_NULL
typedef int AQ_ACTION_PROPERTY;

// Identifiers of properties common for all actions
const AQ_ACTION_PROPERTY apBasePropertyStartID          = 0;	// Helper constant.
const AQ_ACTION_PROPERTY apEnabled			= 0;	// Boolean. Specifies whether the action is enabled or disabled.
const AQ_ACTION_PROPERTY apCaption			= 1;	// WideString. Action caption.
const AQ_ACTION_PROPERTY apDescription			= 2;	// WideString. Action description displayed in the Toolbar Customization dialog.
const AQ_ACTION_PROPERTY apHint				= 3;	// WideString. Action hint.
const AQ_ACTION_PROPERTY apHelpContext			= 4;	// Integer. Topic id for the What's This help.
const AQ_ACTION_PROPERTY apHelpFileName			= 5;	// WideString. The name of a .hlp file for the What's This help.
const AQ_ACTION_PROPERTY apBasePropertyCount		= 6;	// Helper constant. The number of basic properties.


// Identifiers of properties specific to Button actions
const AQ_ACTION_PROPERTY apButtonPropertyStartID  	= 100;  // Helper constant.
const AQ_ACTION_PROPERTY apButtonImage            	= 100;  // HBITMAP. The handle of the button image.
const AQ_ACTION_PROPERTY apButtonPropertyCount    	= 1;    // Helper constant. The number of properties specific to Button actions.

// Identifiers of properties specific to CheckBox actions
const AQ_ACTION_PROPERTY apButtonCheckedPropertyStartID = 200;  // Helper constant.
const AQ_ACTION_PROPERTY apButtonChecked		= 200;  // Boolean. Specifies if the item is checked or unchecked.
const AQ_ACTION_PROPERTY apButtonCheckedPropertyCount   = 1;    // Helper constant. The number of properties specific to the CheckBox action.

// Identifiers of properties specific to actions that have a drop-down list of items (a tree-like drop-down list).
const AQ_ACTION_PROPERTY apDDPropertyStartID            = 300;  // Helper constant.
const AQ_ACTION_PROPERTY apDDItemsList			= 300;  // An array of item captions.
const AQ_ACTION_PROPERTY apDDImages                     = 301;  // An array of item images (HBITMAP values).
const AQ_ACTION_PROPERTY apDDCategoryImage		= 302;  // HBITMAP. The handle of the image that is shown for "category" items.
const AQ_ACTION_PROPERTY apDDCurrentItem     		= 303;  // Integer. The index of the currently selected item.
const AQ_ACTION_PROPERTY apDDPropertyCount   		= 4;    // Helper constant. The number of specific properties of the DropDown action.


// Identifiers of properties specific to MRUButton actions
const AQ_ACTION_PROPERTY apMRUButtonPropertyStartID     = 400;  // Helper constant.
const AQ_ACTION_PROPERTY apMRUButtonItemList		= 400;  // An array of item captions.
const AQ_ACTION_PROPERTY apMRUButtonPropertyCount	= 1;    // Helper constant. The number of specific properties of the MRUButton action.
// If you execute a MRUButton action without parameters, this emulates a click on the MRU button.
// If you execute a MRUButton action and pass a value to the InValue parameter, this emulates selection of an item from the MRU list.

// Identifiers of properties specific to MRUMenuItem actions
const AQ_ACTION_PROPERTY apMRUMenuItemPropertyStartID   = 500;  // Helper constant.
const AQ_ACTION_PROPERTY apMRUMenuItemList		= 500;  // An array of item captions.
const AQ_ACTION_PROPERTY apMRUMenuPropertyCount         = 1;    // Helper constant. The number of specific properties of the MRUMenuItem action.

// Identifiers of properties specific to actions that have a drop-down list of commands
const AQ_ACTION_PROPERTY apCommandDDPropertyStartID     = 600;  // Helper constant.
const AQ_ACTION_PROPERTY apCommandDDCount		= 600;  // Integer. The number of commands in the list.
const AQ_ACTION_PROPERTY apCommandDDCaptions		= 601;  // An array of command captions.
const AQ_ACTION_PROPERTY apCommandDDImages              = 602;  // An array of commands' image handles (HBITMAP values).
const AQ_ACTION_PROPERTY apCommandDDEnabled		= 603;  // An array of boolean values that specify whether a command is enabled or disabled.
const AQ_ACTION_PROPERTY apCommandDDCurentIndex		= 604;  // Integer. The index of the currently selected item (command).
const AQ_ACTION_PROPERTY apCommandDDCheckboxed		= 605;  // Boolean. Specifies whether list items function as check boxes or as ordinary buttons.
const AQ_ACTION_PROPERTY apCommandDDPropertyCount       = 6;    // Helper constant. The number of properties specific to actions that have a drop-down list of commands.


// Identifiers of properties specific to actions that have an editable drop-down list of commands
const AQ_ACTION_PROPERTY apDDEPropertyStartID           = 700;  // Helper constant.
const AQ_ACTION_PROPERTY apDDEItemsList                 = 700;  // Captions of commands separated by new line characters.
const AQ_ACTION_PROPERTY apDDEValue                     = 701;  // The caption of the current item (command).
const AQ_ACTION_PROPERTY apDDEPropertyCount             = 2;    // Helper constant. The number of properties specific to the Edit DropDown action.
