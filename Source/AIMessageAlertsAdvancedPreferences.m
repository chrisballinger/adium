//
//  AIMessageAlertsAdvancedPreferences.m
//  Adium
//
//  Created by Zachary West on 2009-05-23.
//  Copyright 2009 Adium. All rights reserved.
//

#import "AIMessageAlertsAdvancedPreferences.h"
#import "AIStatusController.h"
#import <AIUtilities/AIImageAdditions.h>


@implementation AIMessageAlertsAdvancedPreferences
#pragma mark Preference Pane
- (AIPreferenceCategory)category{
    return AIPref_Advanced;
}
- (NSString *)label{
    return AILocalizedString(@"Message Alerts",nil);
}
- (NSString *)nibName{
    return @"AIMessageAlertsAdvancedPreferences";
}
- (NSImage *)image{
	return [NSImage imageNamed:@"pref-status" forClass:[self class]];
}

#pragma mark Preference toggling

- (IBAction)changePreference:(id)sender
{
	if (sender == checkBox_unreadConversations) {
		[adium.preferenceController setPreference:[NSNumber numberWithInteger:[sender state]]
								   forKey:KEY_STATUS_CONVERSATION_COUNT
									group:PREF_GROUP_STATUS_PREFERENCES];
	}
	
	if (sender == checkBox_unreadContentMention) {
		[adium.preferenceController setPreference:[NSNumber numberWithInteger:[sender state]]
										   forKey:KEY_STATUS_MENTION_COUNT
											group:PREF_GROUP_STATUS_PREFERENCES];
	}
	
	if (sender == checkBox_statusMenuItemBadge) {
		[adium.preferenceController setPreference:[NSNumber numberWithInteger:[sender state]]
								   forKey:KEY_STATUS_MENU_ITEM_BADGE
									group:PREF_GROUP_STATUS_MENU_ITEM];
	}

	if (sender == checkBox_statusMenuItemFlash) {
		[adium.preferenceController setPreference:[NSNumber numberWithInteger:[sender state]]
								   forKey:KEY_STATUS_MENU_ITEM_FLASH
									group:PREF_GROUP_STATUS_MENU_ITEM];
	}
	
	if (sender == checkBox_statusMenuItemCount) {
		[adium.preferenceController setPreference:[NSNumber numberWithInteger:[sender state]]
								   forKey:KEY_STATUS_MENU_ITEM_COUNT
									group:PREF_GROUP_STATUS_MENU_ITEM];
	}
}

#pragma mark Display

//Configure the preference view
- (void)viewDidLoad
{
	[label_dockMenuBarIconCounts setLocalizedString:AILocalizedString(@"Dock Icon and Status Menu Item Counts", nil)];
	[checkBox_unreadConversations setLocalizedString:AILocalizedString(@"Count unread conversations instead of unread messages", nil)];
	[checkBox_unreadContentMention setLocalizedString:AILocalizedString(@"Only count number of highlights and mentions for group chats", nil)];
	
	NSDictionary *statusPreferences = [adium.preferenceController preferencesForGroup:PREF_GROUP_STATUS_PREFERENCES];
	
	[checkBox_unreadConversations setState:[[statusPreferences objectForKey:KEY_STATUS_CONVERSATION_COUNT] boolValue]];
	[checkBox_unreadContentMention setState:[[statusPreferences objectForKey:KEY_STATUS_MENTION_COUNT] boolValue]];

	[label_statusMenuItem setLocalizedString:AILocalizedString(@"Status Menu Item", nil)];
	[checkBox_statusMenuItemBadge setLocalizedString:AILocalizedString(@"Badge the menu item with current status", nil)];
	[checkBox_statusMenuItemFlash setLocalizedString:AILocalizedString(@"Flash when there are unread messages", nil)];
	[checkBox_statusMenuItemCount setLocalizedString:AILocalizedString(@"Show unread message count in the menu bar", nil)];	
	
	NSDictionary *menuItemPreferences = [adium.preferenceController preferencesForGroup:PREF_GROUP_STATUS_MENU_ITEM];
	
	[checkBox_statusMenuItemBadge setState:[[menuItemPreferences objectForKey:KEY_STATUS_MENU_ITEM_BADGE] boolValue]];
	[checkBox_statusMenuItemFlash setState:[[menuItemPreferences objectForKey:KEY_STATUS_MENU_ITEM_FLASH] boolValue]];
	[checkBox_statusMenuItemCount setState:[[menuItemPreferences objectForKey:KEY_STATUS_MENU_ITEM_COUNT] boolValue]];	
	
	[self configureControlDimming];
	[super viewDidLoad];
}


@end
