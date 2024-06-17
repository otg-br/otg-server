STORAGE_DEATH_COUNT = 81700 
STORAGE_KILL_COUNT = 81701

AUSENTE_TIMER = 81703

TEMPLE_TELEPORT_SCROLL = 81704
STAMINA_REFILL_TIME = 81706

-- Action ID
ACTIONID = {
}

-- Unique ID
UNIQUE_ID = {
}

-- Id dos modais usados
Modal = {

	-- bot functions
	autoHealOptions = 2230,
	autoHealHealthOptions = 2231,
	autoHealSpellList = 2232,
	autoHealItemList = 2233,
	autoHealManaItems = 2234,
	autoHealAbout = 2235,
	autoHealText = 2336,

	sellingNPCs = 6666,
	teleportScroll = 6667,
	teleportScrollCities = 6668,

	bless = 8009,

	analyserMain = 8010,
	analyser1 = 8011,
	analyser2 = 8012,
	analyser3 = 8013,
	analyser4 = 8014,
	analyser5 = 8015,

	WarPrivate = {
		[1] = 7016, -- main
		[2] = 7017, -- page1
		[3] = 7018, -- page2
		[4] = 7019, -- page3
		[5] = 7020, -- page4
		[6] = 7021, -- page5
		[7] = 7022, -- page6
		[8] = 7023, -- page7
		[9] = 7024, -- page8
		[10] = 7025, -- page9
		[11] = 7026, -- page10
		[12] = 7027, -- guild rival
		[13] = 7028, -- guild rival
		[14] = 7029, -- guild rival
	},

	Cyclopedia = {
		Bestiary = {
			[1] = 7128,
			[2] = 7129,
			[3] = 7130,
			[4] = 7132,
		},
		Charm = {
			[1] = 7133,
			[2] = 7134,
		}
	},

	autoloot = 7135,
	autolootContainer = 7136,
}

Storage = {
	-- empty_vial.lua [talkaction]
	emptyVials = {
		emptyVial = 99221,
		exhaust = 99222,
	},
	
	Exercisedummy = {
		exaust = 98231521
	},
	
	QuestChests = {
		DemonHelmetQuestDemonShield = 2212,
		DemonHelmetQuestDemonHelmet = 2213,
		DemonHelmetQuestSteelBoots = 2214,
	},


	-- Promotion Storage cannot be changed, it is set in source code
	Promotion = 30018,

	KawillBlessing = 50139,
	RentedHorseTimer = 50561,



	combatProtectionStorage = 50722,
	
	blockMovementStorage = 100000,
	PetSummon = 60045,

	dailyReward = {
		nextRewardPick = DAILYREWARDSTORAGE_NEXTREWARDPICK,
		lastRewardPick = DAILYREWARDSTORAGE_LASTREWARDPICK,
		streakDays = DAILYREWARDSTORAGE_STREAKDAYS,
		exhaust = 69802,
		currentIndex = 69803
	},

	StoreExaust = 6989912,

	BlessTime = 6982,

	LoginLogoutExaust = 6983,

	BlessRunas = 6984,

	WarDelay = 7092,
	WarDelay1 = 7093,
	CastDelay = 7094,


	Supply = 7095,

	SkillBot = 7096,
	VipSystem = 7097,

	NPCTable = 7098,

}

GlobalStorage = {

	ExpBoost = 51052,

	LastServerSave =  69798,
	LastBoostTime =  69799,

	XpDisplayMode = 5634,

	WarDelay = 69800,
	WarDelay1 = 69801,

}
