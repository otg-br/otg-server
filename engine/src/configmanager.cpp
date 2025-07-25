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

#include "otpch.h"

#if __has_include("luajit/lua.hpp")
#include <luajit/lua.hpp>
#else
#include <lua.hpp>
#endif

#include "configmanager.h"
#include "game.h"

#if LUA_VERSION_NUM >= 502
#undef lua_strlen
#define lua_strlen lua_rawlen
#endif

extern Game g_game;

namespace {

std::string getGlobalString(lua_State* L, const char* identifier, const char* defaultValue)
{
	lua_getglobal(L, identifier);
	if (!lua_isstring(L, -1)) {
		return defaultValue;
	}

	size_t len = lua_strlen(L, -1);
	std::string ret(lua_tostring(L, -1), len);
	lua_pop(L, 1);
	return ret;
}

int32_t getGlobalNumber(lua_State* L, const char* identifier, const int32_t defaultValue = 0)
{
	lua_getglobal(L, identifier);
	if (!lua_isnumber(L, -1)) {
		return defaultValue;
	}

	int32_t val = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return val;
}

bool getGlobalBoolean(lua_State* L, const char* identifier, const bool defaultValue)
{
	lua_getglobal(L, identifier);
	if (!lua_isboolean(L, -1)) {
		if (!lua_isstring(L, -1)) {
			return defaultValue;
		}

		size_t len = lua_strlen(L, -1);
		std::string ret(lua_tostring(L, -1), len);
		lua_pop(L, 1);
		return booleanString(ret);
	}

	int val = lua_toboolean(L, -1);
	lua_pop(L, 1);
	return val != 0;
}

float getGlobalFloat(lua_State* L, const char* identifier, const float defaultValue = 0.0)
{
	lua_getglobal(L, identifier);
	if (!lua_isnumber(L, -1)) {
		return defaultValue;
	}

	float val = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return val;
}

double getGlobalDouble(lua_State* L, const char* identifier, const double defaultValue = 0.0)
{
	lua_getglobal(L, identifier);
	if (!lua_isnumber(L, -1)) {
		return defaultValue;
	}

	double val = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return val;
}

}

bool ConfigManager::load()
{
	lua_State* L = luaL_newstate();
	if (!L) {
		throw std::runtime_error("Failed to allocate memory");
	}

	luaL_openlibs(L);

	if (luaL_dofile(L, configFileLua.c_str())) {
		std::cout << "[Error - ConfigManager::load] " << lua_tostring(L, -1) << std::endl;
		lua_close(L);
		return false;
	}

	//parse config
	if (!loaded) { //info that must be loaded one time (unless we reset the modules involved)
		boolean[BIND_ONLY_GLOBAL_ADDRESS] = getGlobalBoolean(L, "bindOnlyGlobalAddress", false);
		boolean[OPTIMIZE_DATABASE] = getGlobalBoolean(L, "startupDatabaseOptimization", true);

		string[IP] = getGlobalString(L, "ip", "127.0.0.1");
		string[MAP_NAME] = getGlobalString(L, "mapName", "forgotten");
		string[MAP_AUTHOR] = getGlobalString(L, "mapAuthor", "Unknown");
		string[HOUSE_RENT_PERIOD] = getGlobalString(L, "houseRentPeriod", "never");
		string[MYSQL_HOST] = getGlobalString(L, "mysqlHost", "127.0.0.1");
		string[MYSQL_USER] = getGlobalString(L, "mysqlUser", "forgottenserver");
		string[MYSQL_PASS] = getGlobalString(L, "mysqlPass", "");
		string[MYSQL_DB] = getGlobalString(L, "mysqlDatabase", "forgottenserver");
		string[MYSQL_SOCK] = getGlobalString(L, "mysqlSock", "");
		string[VERSION_STR] = getGlobalString(L, "clientVersionStr", "");

		integer[SQL_PORT] = getGlobalNumber(L, "mysqlPort", 3306);
		integer[GAME_PORT] = getGlobalNumber(L, "gameProtocolPort", 7172);
		integer[LOGIN_PORT] = getGlobalNumber(L, "loginProtocolPort", 7171);
		integer[STATUS_PORT] = getGlobalNumber(L, "statusProtocolPort", 7171);
		integer[CHECK_PORT] = getGlobalNumber(L, "checkProtocolPort", 7175);
		integer[MARKET_OFFER_DURATION] = getGlobalNumber(L, "marketOfferDuration", 30 * 24 * 60 * 60);

		// Load proxy list
		string[PROXY_LIST] = getGlobalString(L, "proxyList", "");
		StringVector proxies = explodeString(string[PROXY_LIST], ";");
		for (const std::string& proxyInfo : proxies) {
			StringVector info = explodeString(proxyInfo, ",");
			if (info.size() == 4) {
				const std::string& ip = info[1];
				const std::string& name = info[3];
				uint16_t proxyId = std::stoi(info[0]);
				uint16_t port = std::stoi(info[2]);
				auto it = proxyList.emplace(std::piecewise_construct, std::forward_as_tuple(proxyId), std::forward_as_tuple(ip, port, name));
				if (it.second) {
					std::cout << "> Loaded proxy with id: " << proxyId << ", ip: " << ip << ", port: " << port << ", name: " << name << std::endl;
				}
			}
		}

		integer[VERSION_MIN] = getGlobalNumber(L, "clientVersionMin", CLIENT_VERSION_MIN);
		integer[VERSION_MAX] = getGlobalNumber(L, "clientVersionMax", CLIENT_VERSION_MAX);
		integer[FREE_DEPOT_LIMIT] = getGlobalNumber(L, "freeDepotLimit", 2000);
		integer[PREMIUM_DEPOT_LIMIT] = getGlobalNumber(L, "premiumDepotLimit", 8000);
		integer[DEPOT_BOXES] = getGlobalNumber(L, "depotBoxes", 17);
		integer[AUTOLOOT_MODE] = getGlobalNumber(L, "autolootmode", 0); //Autoloot

		boolean[PROTO_BUFF] = getGlobalNumber(L, "protobuff", false); //Autoloot

		doubling[SPAWN_SPEED] = getGlobalNumber(L, "spawnSpeed", 1.0);

	}

	boolean[ALLOW_CHANGEOUTFIT] = getGlobalBoolean(L, "allowChangeOutfit", true);
	boolean[ONE_PLAYER_ON_ACCOUNT] = getGlobalBoolean(L, "onePlayerOnlinePerAccount", true);
	boolean[AIMBOT_HOTKEY_ENABLED] = getGlobalBoolean(L, "hotkeyAimbotEnabled", true);
	boolean[REMOVE_RUNE_CHARGES] = getGlobalBoolean(L, "removeChargesFromRunes", true);
	boolean[EXPERIENCE_FROM_PLAYERS] = getGlobalBoolean(L, "experienceByKillingPlayers", false);
	boolean[FREE_PREMIUM] = getGlobalBoolean(L, "freePremium", false);
	boolean[REPLACE_KICK_ON_LOGIN] = getGlobalBoolean(L, "replaceKickOnLogin", true);
	boolean[ALLOW_CLONES] = getGlobalBoolean(L, "allowClones", false);
	boolean[MARKET_PREMIUM] = getGlobalBoolean(L, "premiumToCreateMarketOffer", true);
	boolean[EMOTE_SPELLS] = getGlobalBoolean(L, "emoteSpells", false);
	boolean[STAMINA_SYSTEM] = getGlobalBoolean(L, "staminaSystem", true);
	boolean[WARN_UNSAFE_SCRIPTS] = getGlobalBoolean(L, "warnUnsafeScripts", true);
	boolean[CONVERT_UNSAFE_SCRIPTS] = getGlobalBoolean(L, "convertUnsafeScripts", true);
	boolean[CLASSIC_EQUIPMENT_SLOTS] = getGlobalBoolean(L, "classicEquipmentSlots", false);
	boolean[CLASSIC_ATTACK_SPEED] = getGlobalBoolean(L, "classicAttackSpeed", false);
	boolean[SCRIPTS_CONSOLE_LOGS] = getGlobalBoolean(L, "showScriptsLogInConsole", true);
	boolean[ALLOW_BLOCK_SPAWN] = getGlobalBoolean(L, "allowBlockSpawn", true);
	boolean[REMOVE_WEAPON_AMMO] = getGlobalBoolean(L, "removeWeaponAmmunition", true);
	boolean[REMOVE_WEAPON_CHARGES] = getGlobalBoolean(L, "removeWeaponCharges", true);
	boolean[REMOVE_POTION_CHARGES] = getGlobalBoolean(L, "removeChargesFromPotions", true);
	boolean[STOREMODULES] = getGlobalBoolean(L, "gamestoreByModules", true);
	boolean[QUEST_LUA] = getGlobalBoolean(L, "loadQuestLua", true);
	boolean[EXPERT_PVP] = getGlobalBoolean(L, "expertPvp", false);
	boolean[SHOW_PACKETS] = getGlobalBoolean(L, "showPackets", false);
	boolean[ENABLE_LIVE_CASTING] = getGlobalBoolean(L, "enableLiveCasting", false);
	boolean[MAINTENANCE] = getGlobalBoolean(L, "maintenance", false);
	boolean[FORCE_MONSTERTYPE_LOAD] = getGlobalBoolean(L, "forceMonsterTypesOnLoad", true);
	boolean[YELL_ALLOW_PREMIUM] = getGlobalBoolean(L, "yellAlwaysAllowPremium", false);
	boolean[BLESS_RUNE] = getGlobalBoolean(L, "blessRune", true);
	boolean[ANTI_MULTI_CLIENT_ENABLED] = getGlobalBoolean(L, "antiMultiClientEnabled", true);
	boolean[ALLOW_MOUNT_IN_PZ] = getGlobalBoolean(L, "allowMountInPz", false);

	string[DEFAULT_PRIORITY] = getGlobalString(L, "defaultPriority", "high");
	string[SERVER_NAME] = getGlobalString(L, "serverName", "");
	string[OWNER_NAME] = getGlobalString(L, "ownerName", "");
	string[OWNER_EMAIL] = getGlobalString(L, "ownerEmail", "");
	string[URL] = getGlobalString(L, "url", "");
	string[LOCATION] = getGlobalString(L, "location", "");
	string[MOTD] = getGlobalString(L, "motd", "");
	string[WORLD_TYPE] = getGlobalString(L, "worldType", "pvp");
	string[STORE_IMAGES_URL] = getGlobalString(L, "storeImagesUrl", "http://os.quelibra.online/images/store/");
	string[DEFAULT_OFFER] = getGlobalString(L, "defaultStoreOffer", "Blessings");
	string[BLOCK_WORD] = getGlobalString(L, "blockWord", "");
	string[MONSTER_URL] = getGlobalString(L, "monsterImageUrl", "AnimatedOutfits/outfit.php?");
	string[ITEM_URL] = getGlobalString(L, "itemImagemUrl", "layouts/tibiacom/images/shop/items/");

	integer[MAX_PLAYERS] = getGlobalNumber(L, "maxPlayers");
	integer[PZ_LOCKED] = getGlobalNumber(L, "pzLocked", 60000);
	integer[DEFAULT_DESPAWNRANGE] = getGlobalNumber(L, "deSpawnRange", 2);
	integer[DEFAULT_DESPAWNRADIUS] = getGlobalNumber(L, "deSpawnRadius", 50);
	integer[RATE_EXPERIENCE] = getGlobalNumber(L, "rateExp", 5);
	integer[RATE_SKILL] = getGlobalNumber(L, "rateSkill", 3);
	integer[RATE_LOOT] = getGlobalNumber(L, "rateLoot", 2);
	integer[RATE_MAGIC] = getGlobalNumber(L, "rateMagic", 3);
	integer[RATE_SPAWN] = getGlobalNumber(L, "rateSpawn", 1);
	integer[HOUSE_PRICE] = getGlobalNumber(L, "housePriceEachSQM", 1000);
	integer[ACTIONS_DELAY_INTERVAL] = getGlobalNumber(L, "timeBetweenActions", 200);
	integer[EX_ACTIONS_DELAY_INTERVAL] = getGlobalNumber(L, "timeBetweenExActions", 1000);
	integer[MAX_MESSAGEBUFFER] = getGlobalNumber(L, "maxMessageBuffer", 4);
	integer[KICK_AFTER_MINUTES] = getGlobalNumber(L, "kickIdlePlayerAfterMinutes", 15);
	integer[PROTECTION_LEVEL] = getGlobalNumber(L, "protectionLevel", 1);
	integer[DEATH_LOSE_PERCENT] = getGlobalNumber(L, "deathLosePercent", -1);
	integer[STATUSQUERY_TIMEOUT] = getGlobalNumber(L, "statusTimeout", 5000);
	integer[FRAG_TIME] = getGlobalNumber(L, "timeToDecreaseFrags", 45 * 24 * 60 * 60);
	integer[WHITE_SKULL_TIME] = getGlobalNumber(L, "whiteSkullTime", 15 * 60 * 1000);
	integer[STAIRHOP_DELAY] = getGlobalNumber(L, "stairJumpExhaustion", 2000);
	integer[MAX_CONTAINER] = getGlobalNumber(L, "maxContainer", 500);
	integer[MAX_ITEM] = getGlobalNumber(L, "maxItem", 10000);
	integer[EXP_FROM_PLAYERS_LEVEL_RANGE] = getGlobalNumber(L, "expFromPlayersLevelRange", 75);
	integer[CHECK_EXPIRED_MARKET_OFFERS_EACH_MINUTES] = getGlobalNumber(L, "checkExpiredMarketOffersEachMinutes", 60);
	integer[MAX_MARKET_OFFERS_AT_A_TIME_PER_PLAYER] = getGlobalNumber(L, "maxMarketOffersAtATimePerPlayer", 100);
	integer[MAX_PACKETS_PER_SECOND] = getGlobalNumber(L, "maxPacketsPerSecond", 25);
	integer[STORE_COINS_PACKET_SIZE] = getGlobalNumber(L, "storeCoinsPacketSize", 25);
	integer[DAY_KILLS_TO_RED] = getGlobalNumber(L, "dayKillsToRedSkull", 3);
	integer[WEEK_KILLS_TO_RED] = getGlobalNumber(L, "weekKillsToRedSkull", 5);
	integer[MONTH_KILLS_TO_RED] = getGlobalNumber(L, "monthKillsToRedSkull", 10);
	integer[RED_SKULL_DURATION] = getGlobalNumber(L, "redSkullDuration", 30);
	integer[BLACK_SKULL_DURATION] = getGlobalNumber(L, "blackSkullDuration", 45);
	integer[ORANGE_SKULL_DURATION] = getGlobalNumber(L, "orangeSkullDuration", 7);
	integer[NETWORK_ATTACK_THRESHOLD] = getGlobalNumber(L, "networkAttackThreshold", 10);
	integer[LIVE_CAST_PORT] = getGlobalNumber(L, "liveCastPort", 7173);
	integer[SERVER_SAVE_NOTIFY_DURATION] = getGlobalNumber(L, "serverSaveNotifyDuration", 5);
	integer[YELL_MINIMUM_LEVEL] = getGlobalNumber(L, "yellMinimumLevel", 2);
	integer[TIME_GMT] = getGlobalNumber(L, "timeGMT", -3 * 60 * 60);
	integer[ANTI_MULTI_CLIENT_LIMIT] = getGlobalNumber(L, "antiMultiClientLimit", 4);
	integer[PVP_PROTECTION_LEVEL] = getGlobalNumber(L, "pvpProtectionLevel", 50);

	floating[RATE_MONSTER_HEALTH] = getGlobalFloat(L, "rateMonsterHealth", 1.0);
	floating[RATE_MONSTER_ATTACK] = getGlobalFloat(L, "rateMonsterAttack", 1.0);
	floating[RATE_MONSTER_DEFENSE] = getGlobalFloat(L, "rateMonsterDefense", 1.0);

	doubling[RATE_MONSTER_SPEED] = getGlobalDouble(L, "rateMonsterSpeed", 1.95);

	loaded = true;
	lua_close(L);
	return true;
}

bool ConfigManager::reload()
{
	bool result = load();
	if (transformToSHA1(getString(ConfigManager::MOTD)) != g_game.getMotdHash()) {
		g_game.incrementMotdNum();
	}
	return result;
}

static std::string dummyStr;

const std::string& ConfigManager::getString(string_config_t what) const
{
	if (what >= LAST_STRING_CONFIG) {
		std::cout << "[Warning - ConfigManager::getString] Accessing invalid index: " << what << std::endl;
		return dummyStr;
	}
	return string[what];
}

int32_t ConfigManager::getNumber(integer_config_t what) const
{
	if (what >= LAST_INTEGER_CONFIG) {
		std::cout << "[Warning - ConfigManager::getNumber] Accessing invalid index: " << what << std::endl;
		return 0;
	}
	return integer[what];
}

static ConfigManager::ProxyInfo dummyInfo;
std::pair<bool, const ConfigManager::ProxyInfo&> ConfigManager::getProxyInfo(uint16_t proxyId) {
	auto it = proxyList.find(proxyId);
	if (it == proxyList.end()) {
		return {false, dummyInfo};
	}

	return {true, it->second};
}

bool ConfigManager::getBoolean(boolean_config_t what) const
{
	if (what >= LAST_BOOLEAN_CONFIG) {
		std::cout << "[Warning - ConfigManager::getBoolean] Accessing invalid index: " << what << std::endl;
		return false;
	}
	return boolean[what];
}

float ConfigManager::getFloat(floating_config_t what) const
{
	if (what >= LAST_FLOATING_CONFIG) {
		std::cout << "[Warning - ConfigManager::getFLoat] Accessing invalid index: " << what << std::endl;
		return 0;
	}
	return floating[what];
}

double ConfigManager::getDouble(doubling_config_t what) const
{
	if (what >= LAST_DOUBLING_CONFIG) {
		std::cout << "[Warning - ConfigManager::getDouble] Accessing invalid index: " << what << std::endl;
		return 0;
	}
	return doubling[what];
}
