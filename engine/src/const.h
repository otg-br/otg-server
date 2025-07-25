/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019 Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include <cstdint>

#ifndef FS_CONST_H_0A49B5996F074465BF44B90F4F780E8B
#define FS_CONST_H_0A49B5996F074465BF44B90F4F780E8B

static constexpr int32_t NETWORKMESSAGE_MAXSIZE = 65500;

// baseado em "data/modules/scripts/blessings/blessings.lua"
enum BlessType_t : uint8_t
{
	ADVENTURE_BLESS = 0,
	TWIST_OF_FATE = 1, // PVP
	WISDOM_OF_SOLITUDE = 2,
	SPARK_OF_THE_PHOENIX = 3,
	FIRE_OF_THE_SUNS = 4,
	SPIRITUAL_SHIELDING = 5,
	EMBRACE_OF_TIBIA = 6,
	HEART_OF_THE_MOUNTAIN = 7, // mountain
	BLOOD_OF_THE_MOUNTAIN = 8, // mountain

	BLESS_ADV_FIRST = ADVENTURE_BLESS,
	BLESS_FIRST = TWIST_OF_FATE,
	BLESS_PVE_FIRST = WISDOM_OF_SOLITUDE,
	BLESS_LAST = BLOOD_OF_THE_MOUNTAIN
};

enum MagicEffectClasses : uint16_t {
	CONST_ME_NONE,

	CONST_ME_DRAWBLOOD = 1,
	CONST_ME_LOSEENERGY = 2,
	CONST_ME_POFF = 3,
	CONST_ME_BLOCKHIT = 4,
	CONST_ME_EXPLOSIONAREA = 5,
	CONST_ME_EXPLOSIONHIT = 6,
	CONST_ME_FIREAREA = 7,
	CONST_ME_YELLOW_RINGS = 8,
	CONST_ME_GREEN_RINGS = 9,
	CONST_ME_HITAREA = 10,
	CONST_ME_TELEPORT = 11,
	CONST_ME_ENERGYHIT = 12,
	CONST_ME_MAGIC_BLUE = 13,
	CONST_ME_MAGIC_RED = 14,
	CONST_ME_MAGIC_GREEN = 15,
	CONST_ME_HITBYFIRE = 16,
	CONST_ME_HITBYPOISON = 17,
	CONST_ME_MORTAREA = 18,
	CONST_ME_SOUND_GREEN = 19,
	CONST_ME_SOUND_RED = 20,
	CONST_ME_POISONAREA = 21,
	CONST_ME_SOUND_YELLOW = 22,
	CONST_ME_SOUND_PURPLE = 23,
	CONST_ME_SOUND_BLUE = 24,
	CONST_ME_SOUND_WHITE = 25,
	CONST_ME_BUBBLES = 26,
	CONST_ME_CRAPS = 27,
	CONST_ME_GIFT_WRAPS = 28,
	CONST_ME_FIREWORK_YELLOW = 29,
	CONST_ME_FIREWORK_RED = 30,
	CONST_ME_FIREWORK_BLUE = 31,
	CONST_ME_STUN = 32,
	CONST_ME_SLEEP = 33,
	CONST_ME_WATERCREATURE = 34,
	CONST_ME_GROUNDSHAKER = 35,
	CONST_ME_HEARTS = 36,
	CONST_ME_FIREATTACK = 37,
	CONST_ME_ENERGYAREA = 38,
	CONST_ME_SMALLCLOUDS = 39,
	CONST_ME_HOLYDAMAGE = 40,
	CONST_ME_BIGCLOUDS = 41,
	CONST_ME_ICEAREA = 42,
	CONST_ME_ICETORNADO = 43,
	CONST_ME_ICEATTACK = 44,
	CONST_ME_STONES = 45,
	CONST_ME_SMALLPLANTS = 46,
	CONST_ME_CARNIPHILA = 47,
	CONST_ME_PURPLEENERGY = 48,
	CONST_ME_YELLOWENERGY = 49,
	CONST_ME_HOLYAREA = 50,
	CONST_ME_BIGPLANTS = 51,
	CONST_ME_CAKE = 52,
	CONST_ME_GIANTICE = 53,
	CONST_ME_WATERSPLASH = 54,
	CONST_ME_PLANTATTACK = 55,
	CONST_ME_TUTORIALARROW = 56,
	CONST_ME_TUTORIALSQUARE = 57,
	CONST_ME_MIRRORHORIZONTAL = 58,
	CONST_ME_MIRRORVERTICAL = 59,
	CONST_ME_SKULLHORIZONTAL = 60,
	CONST_ME_SKULLVERTICAL = 61,
	CONST_ME_ASSASSIN = 62,
	CONST_ME_STEPSHORIZONTAL = 63,
	CONST_ME_BLOODYSTEPS = 64,
	CONST_ME_STEPSVERTICAL = 65,
	CONST_ME_YALAHARIGHOST = 66,
	CONST_ME_BATS = 67,
	CONST_ME_SMOKE = 68,
	CONST_ME_INSECTS = 69,
	CONST_ME_DRAGONHEAD = 70,
	CONST_ME_ORCSHAMAN = 71,
	CONST_ME_ORCSHAMAN_FIRE = 72,
	CONST_ME_THUNDER = 73,
	CONST_ME_FERUMBRAS = 74,
	CONST_ME_CONFETTI_HORIZONTAL = 75,
	CONST_ME_CONFETTI_VERTICAL = 76,
	// 77-157 are empty
	CONST_ME_BLACKSMOKE = 158,
	// 159-166 are empty
	CONST_ME_REDSMOKE = 167,
	CONST_ME_YELLOWSMOKE = 168,
	CONST_ME_GREENSMOKE = 169,
	CONST_ME_PURPLESMOKE = 170,
	CONST_ME_EARLY_THUNDER = 171,
	CONST_ME_RAGIAZ_BONECAPSULE = 172,
	CONST_ME_CRITICAL_DAMAGE = 173,
	// 174 is empty
	CONST_ME_PLUNGING_FISH = 175,

	CONST_ME_BLUE_ENERGY_SPARK = 176,
	CONST_ME_ORANGE_ENERGY_SPARK = 177,
	CONST_ME_GREEN_ENERGY_SPARK = 178,
	CONST_ME_PINK_ENERGY_SPARK = 179,
	CONST_ME_WHITE_ENERGY_SPARK = 180,
	CONST_ME_YELLOW_ENERGY_SPARK = 181,
	CONST_ME_MAGIC_POWDER = 182,
	// 183 is empty
	CONST_ME_PIXIE_EXPLOSION = 184,
	CONST_ME_PIXIE_COMING = 185,
	CONST_ME_PIXIE_GOING = 186,
	// 187 is empty
	CONST_ME_STORM = 188,
	CONST_ME_STONE_STORM = 189,
	// 190 is empty
	CONST_ME_BLUE_GHOST = 191,
	// 192 is empty
	CONST_ME_PINK_VORTEX = 193,
	CONST_ME_TREASURE_MAP = 194,
	CONST_ME_PINK_BEAM = 195,
	CONST_ME_GREEN_FIREWORKS = 196,
	CONST_ME_ORANGE_FIREWORKS = 197,
	CONST_ME_PINK_FIREWORKS = 198,
	CONST_ME_BLUE_FIREWORKS = 199,

	CONST_ME_LAST = CONST_ME_BLUE_FIREWORKS,
};

enum ShootType_t : uint8_t {
	CONST_ANI_NONE,

	CONST_ANI_SPEAR = 1,
	CONST_ANI_BOLT = 2,
	CONST_ANI_ARROW = 3,
	CONST_ANI_FIRE = 4,
	CONST_ANI_ENERGY = 5,
	CONST_ANI_POISONARROW = 6,
	CONST_ANI_BURSTARROW = 7,
	CONST_ANI_THROWINGSTAR = 8,
	CONST_ANI_THROWINGKNIFE = 9,
	CONST_ANI_SMALLSTONE = 10,
	CONST_ANI_DEATH = 11,
	CONST_ANI_LARGEROCK = 12,
	CONST_ANI_SNOWBALL = 13,
	CONST_ANI_POWERBOLT = 14,
	CONST_ANI_POISON = 15,
	CONST_ANI_INFERNALBOLT = 16,
	CONST_ANI_HUNTINGSPEAR = 17,
	CONST_ANI_ENCHANTEDSPEAR = 18,
	CONST_ANI_REDSTAR = 19,
	CONST_ANI_GREENSTAR = 20,
	CONST_ANI_ROYALSPEAR = 21,
	CONST_ANI_SNIPERARROW = 22,
	CONST_ANI_ONYXARROW = 23,
	CONST_ANI_PIERCINGBOLT = 24,
	CONST_ANI_WHIRLWINDSWORD = 25,
	CONST_ANI_WHIRLWINDAXE = 26,
	CONST_ANI_WHIRLWINDCLUB = 27,
	CONST_ANI_ETHEREALSPEAR = 28,
	CONST_ANI_ICE = 29,
	CONST_ANI_EARTH = 30,
	CONST_ANI_HOLY = 31,
	CONST_ANI_SUDDENDEATH = 32,
	CONST_ANI_FLASHARROW = 33,
	CONST_ANI_FLAMMINGARROW = 34,
	CONST_ANI_SHIVERARROW = 35,
	CONST_ANI_ENERGYBALL = 36,
	CONST_ANI_SMALLICE = 37,
	CONST_ANI_SMALLHOLY = 38,
	CONST_ANI_SMALLEARTH = 39,
	CONST_ANI_EARTHARROW = 40,
	CONST_ANI_EXPLOSION = 41,
	CONST_ANI_CAKE = 42,

	CONST_ANI_TARSALARROW = 44,
	CONST_ANI_VORTEXBOLT = 45,

	CONST_ANI_PRISMATICBOLT = 48,
	CONST_ANI_CRYSTALLINEARROW = 49,
	CONST_ANI_DRILLBOLT = 50,
	CONST_ANI_ENVENOMEDARROW = 51,

	CONST_ANI_GLOOTHSPEAR = 53,
	CONST_ANI_SIMPLEARROW = 54,

	CONST_ANI_LEAFSTAR = 56,
	CONST_ANI_DIAMONDARROW = 57,
	CONST_ANI_SPECTRALBOLT = 58,
	CONST_ANI_ROYALSTAR = 59,

	CONST_ANI_LAST = CONST_ANI_ROYALSTAR,

	// for internal use, don't send to client
	CONST_ANI_WEAPONTYPE = 0xFE, // 254
};

enum SpeakClasses : uint8_t {
	TALKTYPE_SAY = 1,
	TALKTYPE_WHISPER = 2,
	TALKTYPE_YELL = 3,
	TALKTYPE_PRIVATE_FROM = 4,
	TALKTYPE_PRIVATE_TO = 5,
	TALKTYPE_CHANNEL_Y = 7,
	TALKTYPE_CHANNEL_O = 8,
	TALKTYPE_PRIVATE_NP = 10,
	TALKTYPE_PRIVATE_PN = 12,
	TALKTYPE_BROADCAST = 13,
	TALKTYPE_CHANNEL_R1 = 14, //red - #c text
	TALKTYPE_PRIVATE_RED_FROM = 15, //@name@text
	TALKTYPE_PRIVATE_RED_TO = 16, //@name@text
	TALKTYPE_MONSTER_SAY = 36,
	TALKTYPE_MONSTER_YELL = 37,

	TALKTYPE_CHANNEL_R2 = 0xFF, //#d
};

enum MessageClasses : uint8_t {
	MESSAGE_STATUS_CONSOLE_RED = 13, /*Red message in the console*/

	MESSAGE_STATUS_DEFAULT = 17, /*White message at the bottom of the game window and in the console*/
	MESSAGE_STATUS_WARNING = 18, /*Red message in game window and in the console*/
	MESSAGE_EVENT_ADVANCE = 19, /*White message in game window and in the console*/

	MESSAGE_STATUS_SMALL = 21, /*White message at the bottom of the game window"*/
	MESSAGE_INFO_DESCR = 22, /*Green message in game window and in the console*/
	MESSAGE_DAMAGE_DEALT = 23,
	MESSAGE_DAMAGE_RECEIVED = 24,
	MESSAGE_HEALED = 25,
	MESSAGE_EXPERIENCE = 26,
	MESSAGE_DAMAGE_OTHERS = 27,
	MESSAGE_HEALED_OTHERS = 28,
	MESSAGE_EXPERIENCE_OTHERS = 29,
	MESSAGE_EVENT_DEFAULT = 30, /*White message at the bottom of the game window and in the console*/
	MESSAGE_LOOT = 31,

	MESSAGE_GUILD = 33, /*White message in channel (+ channelId)*/
	MESSAGE_PARTY_MANAGEMENT = 34, /*White message in channel (+ channelId)*/
	MESSAGE_PARTY = 35, /*White message in channel (+ channelId)*/
	MESSAGE_EVENT_ORANGE = 36, /*Orange message in the console*/
	MESSAGE_STATUS_CONSOLE_ORANGE = 37,  /*Orange message in the console*/

	MESSAGE_STATUS_CONSOLE_BLUE = MESSAGE_EVENT_ADVANCE,
};

enum FluidColors_t : uint8_t {
	FLUID_EMPTY,
	FLUID_BLUE,
	FLUID_RED,
	FLUID_BROWN,
	FLUID_GREEN,
	FLUID_YELLOW,
	FLUID_WHITE,
	FLUID_PURPLE,
};

enum FluidTypes_t : uint8_t {
	FLUID_NONE = FLUID_EMPTY,
	FLUID_WATER = FLUID_BLUE,
	FLUID_BLOOD = FLUID_RED,
	FLUID_BEER = FLUID_BROWN,
	FLUID_SLIME = FLUID_GREEN,
	FLUID_LEMONADE = FLUID_YELLOW,
	FLUID_MILK = FLUID_WHITE,
	FLUID_MANA = FLUID_PURPLE,

	FLUID_LIFE = FLUID_RED + 8,
	FLUID_OIL = FLUID_BROWN + 8,
	FLUID_URINE = FLUID_YELLOW + 8,
	FLUID_COCONUTMILK = FLUID_WHITE + 8,
	FLUID_WINE = FLUID_PURPLE + 8,

	FLUID_MUD = FLUID_BROWN + 16,
	FLUID_FRUITJUICE = FLUID_YELLOW + 16,

	FLUID_LAVA = FLUID_RED + 24,
	FLUID_RUM = FLUID_BROWN + 24,
	FLUID_SWAMP = FLUID_GREEN + 24,

	FLUID_TEA = FLUID_BROWN + 32,

	FLUID_MEAD = FLUID_BROWN + 40,
};

const uint8_t reverseFluidMap[] = {
	FLUID_EMPTY,
	FLUID_WATER,
	FLUID_MANA,
	FLUID_BEER,
	FLUID_EMPTY,
	FLUID_BLOOD,
	FLUID_SLIME,
	FLUID_EMPTY,
	FLUID_LEMONADE,
	FLUID_MILK,
};

const uint8_t clientToServerFluidMap[] = {
	FLUID_EMPTY,
	FLUID_WATER,
	FLUID_MANA,
	FLUID_BEER,
	FLUID_MUD,
	FLUID_BLOOD,
	FLUID_SLIME,
	FLUID_RUM,
	FLUID_LEMONADE,
	FLUID_MILK,
	FLUID_WINE,
	FLUID_LIFE,
	FLUID_URINE,
	FLUID_OIL,
	FLUID_FRUITJUICE,
	FLUID_COCONUTMILK,
	FLUID_TEA,
	FLUID_MEAD,
};

enum ClientFluidTypes_t : uint8_t {
	CLIENTFLUID_EMPTY = 0,
	CLIENTFLUID_BLUE = 1,
	CLIENTFLUID_PURPLE = 2,
	CLIENTFLUID_BROWN_1 = 3,
	CLIENTFLUID_BROWN_2 = 4,
	CLIENTFLUID_RED = 5,
	CLIENTFLUID_GREEN = 6,
	CLIENTFLUID_BROWN = 7,
	CLIENTFLUID_YELLOW = 8,
	CLIENTFLUID_WHITE = 9,
};

const uint8_t fluidMap[] = {
	CLIENTFLUID_EMPTY,
	CLIENTFLUID_BLUE,
	CLIENTFLUID_RED,
	CLIENTFLUID_BROWN_1,
	CLIENTFLUID_GREEN,
	CLIENTFLUID_YELLOW,
	CLIENTFLUID_WHITE,
	CLIENTFLUID_PURPLE,
};

enum SquareColor_t : uint8_t {
	SQ_COLOR_BLACK = 0,
	SQ_COLOR_BROWN = 114,
	SQ_COLOR_ORANGE = 198,
	SQ_COLOR_YELLOW = 210,
	SQ_COLOR_NONE = 255, // internal
};

enum TextColor_t : uint8_t {
	TEXTCOLOR_BLUE = 5,
	TEXTCOLOR_LIGHTGREEN = 30,
	TEXTCOLOR_LIGHTBLUE = 35,
	TEXTCOLOR_MAYABLUE = 95,
	TEXTCOLOR_MAYARED = 194,
	TEXTCOLOR_DARKRED = 108,
	TEXTCOLOR_LIGHTGREY = 129,
	TEXTCOLOR_SKYBLUE = 143,
	TEXTCOLOR_PURPLE = 155,
	TEXTCOLOR_ELECTRICPURPLE = 155,
	TEXTCOLOR_RED = 180,
	TEXTCOLOR_ORANGE = 198,
	TEXTCOLOR_YELLOW = 210,
	TEXTCOLOR_WHITE_EXP = 215,
	TEXTCOLOR_NONE = 255,
};

enum Icons_t {
	ICON_POISON = 1 << 0,
	ICON_BURN = 1 << 1,
	ICON_ENERGY =  1 << 2,
	ICON_DRUNK = 1 << 3,
	ICON_MANASHIELD = 1 << 4,
	ICON_PARALYZE = 1 << 5,
	ICON_HASTE = 1 << 6,
	ICON_SWORDS = 1 << 7,
	ICON_DROWNING = 1 << 8,
	ICON_FREEZING = 1 << 9,
	ICON_DAZZLED = 1 << 10,
	ICON_CURSED = 1 << 11,
	ICON_PARTY_BUFF = 1 << 12,
	ICON_REDSWORDS = 1 << 13,
	ICON_PIGEON = 1 << 14,
	ICON_BLEEDING = 1 << 15,
	ICON_WITHIN_RESTING_AREA = 1<<16 //client 11.40+
};

enum WeaponType_t : uint8_t {
	WEAPON_NONE,
	WEAPON_SWORD,
	WEAPON_CLUB,
	WEAPON_AXE,
	WEAPON_SHIELD,
	WEAPON_DISTANCE,
	WEAPON_WAND,
	WEAPON_AMMO,
	WEAPON_QUIVER,
};

enum Ammo_t : uint8_t {
	AMMO_NONE,
	AMMO_BOLT,
	AMMO_ARROW,
	AMMO_SPEAR,
	AMMO_THROWINGSTAR,
	AMMO_THROWINGKNIFE,
	AMMO_STONE,
	AMMO_SNOWBALL,
};

enum WeaponAction_t : uint8_t {
	WEAPONACTION_NONE,
	WEAPONACTION_REMOVECOUNT,
	WEAPONACTION_REMOVECHARGE,
	WEAPONACTION_MOVE,
};

enum WieldInfo_t {
	WIELDINFO_NONE = 0 << 0,
	WIELDINFO_LEVEL = 1 << 0,
	WIELDINFO_MAGLV = 1 << 1,
	WIELDINFO_VOCREQ = 1 << 2,
	WIELDINFO_PREMIUM = 1 << 3,
};

enum Skulls_t : uint8_t {
	SKULL_NONE = 0,
	SKULL_YELLOW = 1,
	SKULL_GREEN = 2,
	SKULL_WHITE = 3,
	SKULL_RED = 4,
	SKULL_BLACK = 5,
	SKULL_ORANGE = 6,
};

enum PartyShields_t : uint8_t {
	SHIELD_NONE = 0,
	SHIELD_WHITEYELLOW = 1,
	SHIELD_WHITEBLUE = 2,
	SHIELD_BLUE = 3,
	SHIELD_YELLOW = 4,
	SHIELD_BLUE_SHAREDEXP = 5,
	SHIELD_YELLOW_SHAREDEXP = 6,
	SHIELD_BLUE_NOSHAREDEXP_BLINK = 7,
	SHIELD_YELLOW_NOSHAREDEXP_BLINK = 8,
	SHIELD_BLUE_NOSHAREDEXP = 9,
	SHIELD_YELLOW_NOSHAREDEXP = 10,
	SHIELD_GRAY = 11,
};

enum GuildEmblems_t : uint8_t {
	GUILDEMBLEM_NONE = 0,
	GUILDEMBLEM_ALLY = 1,
	GUILDEMBLEM_ENEMY = 2,
	GUILDEMBLEM_NEUTRAL = 3,
	GUILDEMBLEM_MEMBER = 4,
	GUILDEMBLEM_OTHER = 5,
};

enum item_t : uint16_t {
	ITEM_BROWSEFIELD = 460, // for internal use
	ITEM_PVP_SAFE_NULL = 461, // for internal use

	ITEM_DEPOT_NULL = 25452, // for internal use
	ITEM_GOLD_POUCH = 26377,
	TRANSFORM_BOX_ID = 26054, // for internal use

	ITEM_DEPOT_I = 25453,
	ITEM_DEPOT_II = 25454,
	ITEM_DEPOT_III = 25455,
	ITEM_DEPOT_IV = 25456,
	ITEM_DEPOT_V = 25457,
	ITEM_DEPOT_VI = 25458,
	ITEM_DEPOT_VII = 25459,
	ITEM_DEPOT_VIII = 25460,
	ITEM_DEPOT_IX = 25461,
	ITEM_DEPOT_X = 25462,
	ITEM_DEPOT_XI = 25463,
	ITEM_DEPOT_XII = 25464,
	ITEM_DEPOT_XIII = 25465,
	ITEM_DEPOT_XIV = 25466,
	ITEM_DEPOT_XV = 25467,
	ITEM_DEPOT_XVI = 25468,
	ITEM_DEPOT_XVII = 25469,
	ITEM_DEPOT_XVIII = 36629,

	ITEM_FIREFIELD_PVP_FULL = 1487,
	ITEM_FIREFIELD_PVP_MEDIUM = 1488,
	ITEM_FIREFIELD_PVP_SMALL = 1489,
	ITEM_FIREFIELD_PERSISTENT_FULL = 1492,
	ITEM_FIREFIELD_PERSISTENT_MEDIUM = 1493,
	ITEM_FIREFIELD_PERSISTENT_SMALL = 1494,
	ITEM_FIREFIELD_NOPVP = 1500,
	ITEM_FIREFIELD_NOPVP_FULL = 1500,
	ITEM_FIREFIELD_NOPVP_MEDIUM = 1501,
	ITEM_FIREFIELD_NOPVP_SMALL = 1502,

	ITEM_POISONFIELD_PVP = 1490,
	ITEM_POISONFIELD_PERSISTENT = 1496,
	ITEM_POISONFIELD_NOPVP = 1503,

	ITEM_ENERGYFIELD_PVP = 1491,
	ITEM_ENERGYFIELD_PERSISTENT = 1495,
	ITEM_ENERGYFIELD_NOPVP = 1504,

	ITEM_MAGICWALL = 1497,
	ITEM_MAGICWALL_PERSISTENT = 1498,
	ITEM_MAGICWALL_SAFE = 11098,
	ITEM_MAGICWALL_NOPVP = 20669,

	ITEM_WILDGROWTH = 1499,
	ITEM_WILDGROWTH_PERSISTENT = 2721,
	ITEM_WILDGROWTH_SAFE = 11099,
	ITEM_WILDGROWTH_NOPVP = 20670,

	ITEM_BAG = 1987,

	ITEM_GOLD_COIN = 2148,
	ITEM_PLATINUM_COIN = 2152,
	ITEM_CRYSTAL_COIN = 2160,

	ITEM_REWARD_CONTAINER = 21518,
	ITEM_REWARD_CHEST = 21584,

	ITEM_DEPOT = 2594,
	ITEM_LOCKER1 = 2589,
	ITEM_INBOX = 14404,
	ITEM_MARKET = 14405,
	ITEM_STORE_INBOX = 26052,
	ITEM_SUPPLY_STASH = 33248,

	ITEM_MALE_CORPSE = 3058,
	ITEM_FEMALE_CORPSE = 3065,

	ITEM_FULLSPLASH = 2016,
	ITEM_SMALLSPLASH = 2019,

	ITEM_PARCEL = 2595,
	ITEM_LETTER = 2597,
	ITEM_LETTER_STAMPED = 2598,
	ITEM_LABEL = 2599,

	ITEM_AMULETOFLOSS = 2173,

	ITEM_TIBIA_COIN = 24774,
	ITEM_STORECOINS = 24774,

	/** Casks and Kegs **/
	ITEM_HEALTH_CASK_START = 28555,
	ITEM_HEALTH_CASK_END = 28559,

	ITEM_MANA_CASK_START = 28565,
	ITEM_MANA_CASK_END = 28569,

	ITEM_SPIRIT_CASK_START = 28575,
	ITEM_SPIRIT_CASK_END = 28578,

	ITEM_KEG_START = 28579, //kegs ids are contiguous in item.otb
	ITEM_KEG_END = 28590,

	ITEM_DOCUMENT_RO = 1968, //read-only
};

enum PlayerFlags : uint64_t {
	PlayerFlag_CannotUseCombat = 1 << 0,
	PlayerFlag_CannotAttackPlayer = 1 << 1,
	PlayerFlag_CannotAttackMonster = 1 << 2,
	PlayerFlag_CannotBeAttacked = 1 << 3,
	PlayerFlag_CanConvinceAll = 1 << 4,
	PlayerFlag_CanSummonAll = 1 << 5,
	PlayerFlag_CanIllusionAll = 1 << 6,
	PlayerFlag_CanSenseInvisibility = 1 << 7,
	PlayerFlag_IgnoredByMonsters = 1 << 8,
	PlayerFlag_NotGainInFight = 1 << 9,
	PlayerFlag_HasInfiniteMana = 1 << 10,
	PlayerFlag_HasInfiniteSoul = 1 << 11,
	PlayerFlag_HasNoExhaustion = 1 << 12,
	PlayerFlag_CannotUseSpells = 1 << 13,
	PlayerFlag_CannotPickupItem = 1 << 14,
	PlayerFlag_CanAlwaysLogin = 1 << 15,
	PlayerFlag_CanBroadcast = 1 << 16,
	PlayerFlag_CanEditHouses = 1 << 17,
	PlayerFlag_CannotBeBanned = 1 << 18,
	PlayerFlag_CannotBePushed = 1 << 19,
	PlayerFlag_HasInfiniteCapacity = 1 << 20,
	PlayerFlag_CanPushAllCreatures = 1 << 21,
	PlayerFlag_CanTalkRedPrivate = 1 << 22,
	PlayerFlag_CanTalkRedChannel = 1 << 23,
	PlayerFlag_TalkOrangeHelpChannel = 1 << 24,
	PlayerFlag_NotGainExperience = 1 << 25,
	PlayerFlag_NotGainMana = 1 << 26,
	PlayerFlag_NotGainHealth = 1 << 27,
	PlayerFlag_NotGainSkill = 1 << 28,
	PlayerFlag_SetMaxSpeed = 1 << 29,
	PlayerFlag_SpecialVIP = 1 << 30,
	PlayerFlag_NotGenerateLoot = static_cast<uint64_t>(1) << 31,
	PlayerFlag_CanTalkRedChannelAnonymous = static_cast<uint64_t>(1) << 32,
	PlayerFlag_IgnoreProtectionZone = static_cast<uint64_t>(1) << 33,
	PlayerFlag_IgnoreSpellCheck = static_cast<uint64_t>(1) << 34,
	PlayerFlag_IgnoreWeaponCheck = static_cast<uint64_t>(1) << 35,
	PlayerFlag_CannotBeMuted = static_cast<uint64_t>(1) << 36,
	PlayerFlag_IsAlwaysPremium = static_cast<uint64_t>(1) << 37,
};

enum ReloadTypes_t : uint8_t  {
	RELOAD_TYPE_ALL,
	RELOAD_TYPE_ACTIONS,
	RELOAD_TYPE_BESTIARY,
	RELOAD_TYPE_CHAT,
	RELOAD_TYPE_COMMANDS,
	RELOAD_TYPE_CONFIG,
	RELOAD_TYPE_CREATURESCRIPTS,
	RELOAD_TYPE_EVENTS,
	RELOAD_TYPE_GLOBAL,
	RELOAD_TYPE_GLOBALEVENTS,
	RELOAD_TYPE_ITEMS,
	RELOAD_TYPE_MONSTERS,
	RELOAD_TYPE_MODULES,
	RELOAD_TYPE_MOUNTS,
	RELOAD_TYPE_MOVEMENTS,
	RELOAD_TYPE_NPCS,
	RELOAD_TYPE_QUESTS,
	RELOAD_TYPE_RAIDS,
	RELOAD_TYPE_SCRIPTS,
	RELOAD_TYPE_SPELLS,
	RELOAD_TYPE_TALKACTIONS,
	RELOAD_TYPE_WEAPONS,
	RELOAD_TYPE_STORE,
	RELOAD_TYPE_IMBUEMENTS,
	RELOAD_TYPE_FREE_PASS,
};

enum NameEval_t : uint8_t {
	VALID,
	INVALID,
	INVALID_LENGTH,
	INVALID_TOKEN_LENGTH,
	INVALID_FORBIDDEN,
	INVALID_CHARACTER
};

enum DailyRewardStorages_t: uint32_t {
	DAILYREWARDSTORAGE_NEXTREWARDPICK = 69799,
	DAILYREWARDSTORAGE_LASTREWARDPICK = 69800,
	DAILYREWARDSTORAGE_STREAKDAYS = 69801
};

// OTCv8 features (from src/client/const.h)
enum GameFeature {
	GameProtocolChecksum = 1,
	GameAccountNames = 2,
	GameChallengeOnLogin = 3,
	GamePenalityOnDeath = 4,
	GameNameOnNpcTrade = 5,
	GameDoubleFreeCapacity = 6,
	GameDoubleExperience = 7,
	GameTotalCapacity = 8,
	GameSkillsBase = 9,
	GamePlayerRegenerationTime = 10,
	GameChannelPlayerList = 11,
	GamePlayerMounts = 12,
	GameEnvironmentEffect = 13,
	GameCreatureEmblems = 14,
	GameItemAnimationPhase = 15,
	GameMagicEffectU16 = 16,
	GamePlayerMarket = 17,
	GameSpritesU32 = 18,
	GameTileAddThingWithStackpos = 19,
	GameOfflineTrainingTime = 20,
	GamePurseSlot = 21,
	GameFormatCreatureName = 22,
	GameSpellList = 23,
	GameClientPing = 24,
	GameExtendedClientPing = 25,
	GameDoubleHealth = 28,
	GameDoubleSkills = 29,
	GameChangeMapAwareRange = 30,
	GameMapMovePosition = 31,
	GameAttackSeq = 32,
	GameBlueNpcNameColor = 33,
	GameDiagonalAnimatedText = 34,
	GameLoginPending = 35,
	GameNewSpeedLaw = 36,
	GameForceFirstAutoWalkStep = 37,
	GameMinimapRemove = 38,
	GameDoubleShopSellAmount = 39,
	GameContainerPagination = 40,
	GameThingMarks = 41,
	GameLooktypeU16 = 42,
	GamePlayerStamina = 43,
	GamePlayerAddons = 44,
	GameMessageStatements = 45,
	GameMessageLevel = 46,
	GameNewFluids = 47,
	GamePlayerStateU16 = 48,
	GameNewOutfitProtocol = 49,
	GamePVPMode = 50,
	GameWritableDate = 51,
	GameAdditionalVipInfo = 52,
	GameBaseSkillU16 = 53,
	GameCreatureIcons = 54,
	GameHideNpcNames = 55,
	GameSpritesAlphaChannel = 56,
	GamePremiumExpiration = 57,
	GameBrowseField = 58,
	GameEnhancedAnimations = 59,
	GameOGLInformation = 60,
	GameMessageSizeCheck = 61,
	GamePreviewState = 62,
	GameLoginPacketEncryption = 63,
	GameClientVersion = 64,
	GameContentRevision = 65,
	GameExperienceBonus = 66,
	GameAuthenticator = 67,
	GameUnjustifiedPoints = 68,
	GameSessionKey = 69,
	GameDeathType = 70,
	GameIdleAnimations = 71,
	GameKeepUnawareTiles = 72,
	GameIngameStore = 73,
	GameIngameStoreHighlights = 74,
	GameIngameStoreServiceType = 75,
	GameAdditionalSkills = 76,
	GameDistanceEffectU16 = 77,
	GamePrey = 78,
	GameDoubleMagicLevel = 79,

	GameExtendedOpcode = 80,
	GameMinimapLimitedToSingleFloor = 81,
	GameSendWorldName = 82,

	GameDoubleLevel = 83,
	GameDoubleSoul = 84,
	GameDoublePlayerGoodsMoney = 85,
	GameCreatureWalkthrough = 86,
	GameDoubleTradeMoney = 87,
	GameSequencedPackets = 88,
	GameTibia12Protocol = 89,

	// 90-99 otclientv8 features
	GameNewWalking = 90,
	GameSlowerManualWalking = 91,

	GameItemTooltip = 93,

	GameBot = 95,
	GameBiggerMapCache = 96,
	GameForceLight = 97,
	GameNoDebug = 98,
	GameBotProtection = 99,

	// Custom features for customer
	GameFasterAnimations = 101,
	GameCenteredOutfits = 102,
	GameSendIdentifiers = 103,
	GameWingsAndAura = 104,
	GamePlayerStateU32 = 105,
	GameOutfitShaders = 106,

	// advanced features
	GamePacketSizeU32 = 110,
	GamePacketCompression = 111,

	LastGameFeature = 120
};

static constexpr int32_t CHANNEL_GUILD = 0x00;
static constexpr int32_t CHANNEL_PARTY = 0x01;
static constexpr int32_t CHANNEL_PRIVATE = 0xFFFF;

static constexpr int32_t CHANNEL_CAST = 0xFFFE;

const std::string LIVE_CAST_CHAT_NAME = "Live Cast Chat";

static constexpr int32_t STORAGEVALUE_PROMOTION = 30018;
static constexpr int32_t STORAGEVALUE_EMOTE = 30019;
//Reserved player storage key ranges;
//[10000000 - 20000000];
static constexpr int32_t PSTRG_RESERVED_RANGE_START = 10000000;
static constexpr int32_t PSTRG_RESERVED_RANGE_SIZE = 10000000;
//[1000 - 1500];
static constexpr int32_t PSTRG_OUTFITS_RANGE_START = (PSTRG_RESERVED_RANGE_START + 1000);
static constexpr int32_t PSTRG_OUTFITS_RANGE_SIZE = 500;
//[2001 - 2011];
static constexpr int32_t PSTRG_MOUNTS_RANGE_START = (PSTRG_RESERVED_RANGE_START + 2001);
static constexpr int32_t PSTRG_MOUNTS_RANGE_SIZE = 10;
static constexpr int32_t PSTRG_MOUNTS_CURRENTMOUNT = (PSTRG_MOUNTS_RANGE_START + 10);

#define IS_IN_KEYRANGE(key, range) (key >= PSTRG_##range##_START && ((key - PSTRG_##range##_START) <= PSTRG_##range##_SIZE))

#define PREY_SLOTCOUNT 3

static constexpr int32_t PSTRG_BLESS_RUNA = 6984;

#endif
